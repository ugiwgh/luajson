local tostring = tostring
local assert = assert
local util = require("json.util")

module("json.encode.number")

local defaultOptions = {
	nan = true,
	inf = true,
-- N/A - cannot tell encoder not to use fractions, exponents, or hex-form
--	frac = true,
--	exp = true,
--	hex = false
}

default = nil -- Let the buildCapture optimization take place
strict = {
	nan = false,
	inf = false
}

function encode(number, options)
	-- Load up number-only options
	options = options and options.number
	options = options and util.merge({}, defaultOptions, options) or defaultOptions
	local str = tostring(number)
	if str == "nan" then
		assert(options.nan, "Invalid number: NaN not enabled")
		return "NaN"
	end
	if str == "inf" then
		assert(options.inf, "Invalid number: Infinity not enabled")
		return "Infinity"
	end
	if str == "-inf" then
		assert(options.inf, "Invalid number: -Infinity not enabled")
		return "-Infinity"
	end
	return str
end
