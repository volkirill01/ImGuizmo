IMGUIZMO_STATIC_LINKINK = true

project "ImGuizmo"
	if IMGUIZMO_STATIC_LINKINK then
		kind "StaticLib"
	else
		kind "SharedLib"
	end
	language "C++"
	cppdialect "C++17"
	staticruntime "off"

	warnings "Off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{IncludeDir.ImGui}/imgui.h",
		"ImGuizmo.h",
		"ImGuizmo.cpp"
	}

	includedirs
	{
		"%{IncludeDir.ImGui}"
	}

	if not IMGUIZMO_STATIC_LINKINK then
		defines { "IMGUIZMO_API=__declspec(dllexport)" }
	end
	
	if not IMGUI_STATIC_LINKINK then
		defines { "IMGUI_API=__declspec(dllimport)" }
	end

	links
	{
		"ImGui"
	}

	filter "system:windows"
		systemversion "latest"

	filter "system:linux"
		pic "on"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		runtime "Release"
		optimize "on"
		symbols "off"
