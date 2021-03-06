require "ui/screen"
require "ui/rendertext"
require "ui/graphics"
require "ui/image"
require "ui/event"
require "ui/gesturedetector"
require "ui/font"

--[[
The EventListener is an interface that handles events

EventListeners have a rudimentary event handler/dispatcher that
will call a method "onEventName" for an event with name
"EventName"
--]]
EventListener = {}

function EventListener:new(o)
	local o = o or {}
	setmetatable(o, self)
	self.__index = self
	if o.init then o:init() end
	return o
end

function EventListener:handleEvent(event)
	if self[event.handler] then
		return self[event.handler](self, unpack(event.args))
	end
end


--[[
This is a generic Widget interface

widgets can be queried about their size and can be paint.
that's it for now. Probably we need something more elaborate
later.

if the table that was given to us as parameter has an "init"
method, it will be called. use this to set _instance_ variables
rather than class variables.
--]]
Widget = EventListener:new()

function Widget:new(o)
	local o = o or {}
	setmetatable(o, self)
	self.__index = self
	-- Both o._init and o.init are called on object create. But o._init is used
	-- for base widget initialization (basic component used to build other
	-- widgets). While o.init is for higher level widgets, for example Menu
	-- Widget
	if o._init then o:_init() end
	if o.init then o:init() end
	return o
end

function Widget:getSize()
	return self.dimen
end

function Widget:paintTo(bb, x, y)
end



