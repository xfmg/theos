NULLSTRING :=

ECHO_PIPEFAIL := set -o pipefail;

_THEOS_VERBOSE := $(call __theos_bool,$(or $(messages),$(MESSAGES)))

ifeq ($(_THEOS_VERBOSE),$(_THEOS_TRUE))
	ECHO_BEGIN = (
	ECHO_NOTHING = $(ECHO_PIPEFAIL) (
	ECHO_MAKE = +
	ECHO_END = )

	ifeq ($(call __executable,unbuffer),$(_THEOS_TRUE))
		ECHO_UNBUFFERED = unbuffer $(NULLSTRING)
	else
		ECHO_UNBUFFERED =
	endif

	STDERR_NULL_REDIRECT =
	STDOUT_NULL_REDIRECT =
else
	ECHO_BEGIN = @(
	ECHO_NOTHING = @(
	ECHO_MAKE = +@
	ECHO_UNBUFFERED =
	ECHO_END = )

	STDERR_NULL_REDIRECT = 2> /dev/null
	STDOUT_NULL_REDIRECT = > /dev/null
endif

ifeq ($(call __theos_bool,$(COLOR)),$(_THEOS_TRUE))
	PRINT_FORMAT = printf "\e[0;36m==> \e[1;36mNotice:\e[m %s\n"
	PRINT_FORMAT_MAKING = printf "\e[1;31m> \e[1;3;39m%s…\e[m\n"
	PRINT_FORMAT_STAGE = printf "\e[0;3%im==> \e[1;39m%s…\e[m\n"
	PRINT_FORMAT_RED = $(PRINT_FORMAT_STAGE) 1
	PRINT_FORMAT_GREEN = $(PRINT_FORMAT_STAGE) 2
	PRINT_FORMAT_YELLOW = $(PRINT_FORMAT_STAGE) 3
	PRINT_FORMAT_BLUE = $(PRINT_FORMAT_STAGE) 4
	PRINT_FORMAT_MAGENTA = $(PRINT_FORMAT_STAGE) 5
	PRINT_FORMAT_CYAN = $(PRINT_FORMAT_STAGE) 6
	PRINT_FORMAT_WARNING = printf "\e[0;33m==> \e[1;33mWarning:\e[m %s\n"
	PRINT_FORMAT_ERROR = printf "\e[0;31m==> \e[1;31mError:\e[m %s\n"
else
	PRINT_FORMAT = printf "==> Notice: %s\n"
	PRINT_FORMAT_MAKING = printf "> %s...\n"
	PRINT_FORMAT_STAGE = printf "==> %s...\n"
	PRINT_FORMAT_RED = $(PRINT_FORMAT_STAGE)
	PRINT_FORMAT_GREEN = $(PRINT_FORMAT_STAGE)
	PRINT_FORMAT_YELLOW = $(PRINT_FORMAT_STAGE)
	PRINT_FORMAT_BLUE = $(PRINT_FORMAT_STAGE)
	PRINT_FORMAT_MAGENTA = $(PRINT_FORMAT_STAGE)
	PRINT_FORMAT_CYAN = $(PRINT_FORMAT_STAGE)
	PRINT_FORMAT_WARNING = printf "==> Warning: %s\n"
	PRINT_FORMAT_ERROR = printf "==> Error: %s\n"
endif

	ECHO_PREPROCESSING = $(ECHO_BEGIN)$(PRINT_FORMAT_RED) "Preprocessing $<"$(ECHO_END); $(ECHO_PIPEFAIL) (

ifneq ($(_THEOS_DISPLAY_ARCH),)
	ECHO_COMPILING = $(ECHO_BEGIN)$(PRINT_FORMAT_GREEN) "Compiling $< ($(_THEOS_DISPLAY_ARCH))"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_SWIFTMODULE_HEADER = $(ECHO_BEGIN)$(PRINT_FORMAT_BLUE) "Generating $(notdir $@) ($(_THEOS_DISPLAY_ARCH))"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_LINKING = $(ECHO_BEGIN)$(PRINT_FORMAT_YELLOW) "Linking $(_THEOS_CURRENT_TYPE) $(THEOS_CURRENT_INSTANCE) ($(_THEOS_DISPLAY_ARCH))"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_STATIC_LINKING = $(ECHO_BEGIN)$(PRINT_FORMAT_YELLOW) "Linking static $(_THEOS_CURRENT_TYPE) $(THEOS_CURRENT_INSTANCE) ($(_THEOS_DISPLAY_ARCH))"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_LINKING_WITH_STRIP = $(ECHO_BEGIN)$(PRINT_FORMAT_YELLOW) "Linking $(_THEOS_CURRENT_TYPE) $(THEOS_CURRENT_INSTANCE) (with strip, $(_THEOS_DISPLAY_ARCH))"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_STRIPPING = $(ECHO_BEGIN)$(PRINT_FORMAT_BLUE) "Stripping $(THEOS_CURRENT_INSTANCE) ($(_THEOS_DISPLAY_ARCH))"$(ECHO_END); $(ECHO_PIPEFAIL) (
else
	ECHO_COMPILING = $(ECHO_BEGIN)$(PRINT_FORMAT_GREEN) "Compiling $<"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_SWIFTMODULE_HEADER = $(ECHO_BEGIN)$(PRINT_FORMAT_BLUE) "Generating $(notdir $@)"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_LINKING = $(ECHO_BEGIN)$(PRINT_FORMAT_YELLOW) "Linking $(_THEOS_CURRENT_TYPE) $(THEOS_CURRENT_INSTANCE)"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_STATIC_LINKING = $(ECHO_BEGIN)$(PRINT_FORMAT_YELLOW) "Linking static $(_THEOS_CURRENT_TYPE) $(THEOS_CURRENT_INSTANCE)"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_LINKING_WITH_STRIP = $(ECHO_BEGIN)$(PRINT_FORMAT_YELLOW) "Linking $(_THEOS_CURRENT_TYPE) $(THEOS_CURRENT_INSTANCE) (with strip)"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_STRIPPING = $(ECHO_BEGIN)$(PRINT_FORMAT_BLUE) "Stripping $(THEOS_CURRENT_INSTANCE)"$(ECHO_END); $(ECHO_PIPEFAIL) (
endif

	ECHO_MERGING = $(ECHO_BEGIN)$(PRINT_FORMAT_BLUE) "Merging $(_THEOS_CURRENT_TYPE) $(THEOS_CURRENT_INSTANCE)"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_SIGNING = $(ECHO_BEGIN)$(PRINT_FORMAT_BLUE) "Signing $(THEOS_CURRENT_INSTANCE)"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_DEBUG_SYMBOLS = $(ECHO_BEGIN)$(PRINT_FORMAT_BLUE) "Generating debug symbols for $(THEOS_CURRENT_INSTANCE)"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_COPYING_RESOURCE_FILES = $(ECHO_BEGIN)$(PRINT_FORMAT_MAGENTA) "Copying resource files into the $(_THEOS_CURRENT_TYPE) wrapper"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_COPYING_RESOURCE_DIRS = $(ECHO_BEGIN)$(PRINT_FORMAT_MAGENTA) "Copying resource directories into the $(_THEOS_CURRENT_TYPE) wrapper"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_COPYING_PUBLIC_HEADERS = $(ECHO_BEGIN)$(PRINT_FORMAT_MAGENTA) "Copying public headers into the $(_THEOS_CURRENT_TYPE) wrapper"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_COPYING_FRAMEWORK = $(ECHO_BEGIN)$(PRINT_FORMAT_MAGENTA) "Installing $(_THEOS_CURRENT_TYPE) to $(THEOS_LIBRARY_PATH)"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_PRE_UNLOADING = $(ECHO_BEGIN)$(PRINT_FORMAT_CYAN) "Unloading $(PREINSTALL_TARGET_PROCESSES)"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_INSTALLING = $(ECHO_BEGIN)$(PRINT_FORMAT_CYAN) "Installing"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_UNLOADING = $(ECHO_BEGIN)$(PRINT_FORMAT_CYAN) "Unloading $(INSTALL_TARGET_PROCESSES)"$(ECHO_END); $(ECHO_PIPEFAIL) (
	ECHO_CLEANING = $(ECHO_BEGIN)$(PRINT_FORMAT_CYAN) "Cleaning"$(ECHO_END); $(ECHO_PIPEFAIL) (

	ERROR_BEGIN = @$(PRINT_FORMAT_ERROR) $(NULLSTRING)
	ERROR_END = $(NULLSTRING) >&2; exit 1;

WARNING_EMPTY_LINKING = @$(PRINT_FORMAT_WARNING) "No files to link. Please check your Makefile! Make sure you set $(THEOS_CURRENT_INSTANCE)_FILES (or similar variables)"

# (bundle)
NOTICE_EMPTY_LINKING = @$(PRINT_FORMAT_WARNING) "No files to link - creating a bundle containing only resources"

$(eval $(call __mod,messages.mk))
