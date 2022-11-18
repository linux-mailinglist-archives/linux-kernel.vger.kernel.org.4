Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A562FE55
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiKRTxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKRTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:53:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD200B7EB6;
        Fri, 18 Nov 2022 11:53:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4845A6251B;
        Fri, 18 Nov 2022 19:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA489C433C1;
        Fri, 18 Nov 2022 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668801196;
        bh=wXJGBT1A52XfTBUcUmXtciPhChh/z7Sw4+vgV7bpK4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFMMrT1GNVXJMOj/phzLELBESFBKwf25ezq14ItF4APdTJ90/ysm6FlUA6hOJzHrW
         iAad0HoYM0ruHOpEH/I5RvG6KjUOEHDGTxH9fY43tYmE9oadwLErYOTfGY1JTluqV0
         ZRmdvvdu2o/PSD3lhAa89yRvUoj9UPvrZvgzX9bpTIcnovx0HLjFiiYFVv0DdBIMBv
         Et5d31i0aZdRR6XcCFsP2HgIQk+KKfQ4LPDDABaEOmhHj7ErcI118T0K39+13al7sB
         cQ0y3+bmvmhdOEgIhfYsX5CwUnfjy1FJNnoA7WpWQA+hZzBK0sRaVI54zUMDhhJZDO
         0h4L8p+2wL1ww==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/6] kbuild: make CONFIG_*_VERSION always 6-digit
Date:   Sat, 19 Nov 2022 04:53:03 +0900
Message-Id: <20221118195307.86049-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118195307.86049-1-masahiroy@kernel.org>
References: <20221118195307.86049-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_*_VERSION is the version number of a tool in a 5 or 6-digit form.
This is fine in the Kconfig perspective because Kconfig supports numeric
comparison (<, <=, >, >=).

It is harder in Makefiles due to make's limited numerical capabilities.
So, we ask for shell's "test" command when we compare versions, but it
needs some process forks.

test-{le,ge,lt,gt} macros can compare versions by using only built-in
functions, but the number of digits must be aligned for those macros
to work correctly.

This commit (ab)uses Kconfig's hex type, which allows '0' prefixes,
in order to make CONFIG_*_VERSION always 6-digit.

For example with GCC 9.5, CONFIG_GCC_VERSION=90500 will be turned
into CONFIG_GCC_VERSION=090500.

I touched several Kconfig files so that versions are consistently
compared against 6-digit numbers although this is not mandated.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm/mach-rpc/Kconfig |  2 +-
 arch/arm64/Kconfig        |  4 ++--
 arch/mips/vdso/Kconfig    |  2 +-
 arch/powerpc/Kconfig      |  2 +-
 arch/riscv/Kconfig        |  4 ++--
 init/Kconfig              | 18 +++++++++---------
 lib/Kconfig.debug         |  6 +++---
 lib/Kconfig.kasan         |  2 +-
 scripts/as-version.sh     |  6 +++---
 scripts/cc-version.sh     |  6 +++---
 scripts/ld-version.sh     |  6 +++---
 11 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-rpc/Kconfig b/arch/arm/mach-rpc/Kconfig
index 55f6d829b677..106716042308 100644
--- a/arch/arm/mach-rpc/Kconfig
+++ b/arch/arm/mach-rpc/Kconfig
@@ -2,7 +2,7 @@ config ARCH_RPC
 	bool "RiscPC"
 	depends on ARCH_MULTI_V4 && !(ARCH_MULTI_V4T || ARCH_MULTI_V5)
 	depends on !(ARCH_FOOTBRIDGE || ARCH_SA1100 || ARCH_MOXART || ARCH_GEMINI)
-	depends on !CC_IS_CLANG && GCC_VERSION < 90100 && GCC_VERSION >= 60000
+	depends on !CC_IS_CLANG && GCC_VERSION < 090100 && GCC_VERSION >= 060000
 	depends on CPU_LITTLE_ENDIAN
 	depends on ATAGS
 	depends on MMU
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 505c8a1ccbe0..b318f7ad050b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -236,7 +236,7 @@ config ARM64
 config CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_REGS
 	def_bool CC_IS_CLANG
 	# https://github.com/ClangBuiltLinux/linux/issues/1507
-	depends on AS_IS_GNU || (AS_IS_LLVM && (LD_IS_LLD || LD_VERSION >= 23600))
+	depends on AS_IS_GNU || (AS_IS_LLVM && (LD_IS_LLD || LD_VERSION >= 023600))
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 
 config GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_REGS
@@ -1814,7 +1814,7 @@ config ARM64_PTR_AUTH_KERNEL
 	depends on (CC_HAS_SIGN_RETURN_ADDRESS || CC_HAS_BRANCH_PROT_PAC_RET) && AS_HAS_PAC
 	# Modern compilers insert a .note.gnu.property section note for PAC
 	# which is only understood by binutils starting with version 2.33.1.
-	depends on LD_IS_LLD || LD_VERSION >= 23301 || (CC_IS_GCC && GCC_VERSION < 90100)
+	depends on LD_IS_LLD || LD_VERSION >= 23301 || (CC_IS_GCC && GCC_VERSION < 090100)
 	depends on !CC_IS_CLANG || AS_HAS_CFI_NEGATE_RA_STATE
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
 	help
diff --git a/arch/mips/vdso/Kconfig b/arch/mips/vdso/Kconfig
index a665f6108cb5..a8316108b756 100644
--- a/arch/mips/vdso/Kconfig
+++ b/arch/mips/vdso/Kconfig
@@ -12,7 +12,7 @@
 # the lack of relocations. As such, we disable the VDSO for microMIPS builds.
 
 config MIPS_LD_CAN_LINK_VDSO
-	def_bool LD_VERSION >= 22500 || LD_IS_LLD
+	def_bool LD_VERSION >= 022500 || LD_IS_LLD
 
 config MIPS_DISABLE_VDSO
 	def_bool CPU_MICROMIPS || (!CPU_MIPSR6 && !MIPS_LD_CAN_LINK_VDSO)
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2ca5418457ed..e7ba3a145595 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -220,7 +220,7 @@ config PPC
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
-	select HAVE_GCC_PLUGINS			if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC
+	select HAVE_GCC_PLUGINS			if GCC_VERSION >= 050200   # plugin support on gcc <= 5.1 is buggy on PPC
 	select HAVE_GENERIC_VDSO
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa78595a6089..292f134f4493 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -416,7 +416,7 @@ config TOOLCHAIN_HAS_ZICBOM
 	default y
 	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zicbom)
 	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zicbom)
-	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23800
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 023800
 
 config RISCV_ISA_ZICBOM
 	bool "Zicbom extension support for non-coherent DMA operation"
@@ -440,7 +440,7 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
 	default y
 	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zihintpause)
 	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zihintpause)
-	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23600
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 023600
 
 config FPU
 	bool "FPU support"
diff --git a/init/Kconfig b/init/Kconfig
index abf65098f1b6..402ce28c8eff 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -20,17 +20,17 @@ config CC_IS_GCC
 	def_bool $(success,test "$(cc-name)" = GCC)
 
 config GCC_VERSION
-	int
+	hex
 	default $(cc-version) if CC_IS_GCC
-	default 0
+	default 000000
 
 config CC_IS_CLANG
 	def_bool $(success,test "$(cc-name)" = Clang)
 
 config CLANG_VERSION
-	int
+	hex
 	default $(cc-version) if CC_IS_CLANG
-	default 0
+	default 000000
 
 config AS_IS_GNU
 	def_bool $(success,test "$(as-name)" = GNU)
@@ -39,7 +39,7 @@ config AS_IS_LLVM
 	def_bool $(success,test "$(as-name)" = LLVM)
 
 config AS_VERSION
-	int
+	hex
 	# Use clang version if this is the integrated assembler
 	default CLANG_VERSION if AS_IS_LLVM
 	default $(as-version)
@@ -48,17 +48,17 @@ config LD_IS_BFD
 	def_bool $(success,test "$(ld-name)" = BFD)
 
 config LD_VERSION
-	int
+	hex
 	default $(ld-version) if LD_IS_BFD
-	default 0
+	default 000000
 
 config LD_IS_LLD
 	def_bool $(success,test "$(ld-name)" = LLD)
 
 config LLD_VERSION
-	int
+	hex
 	default $(ld-version) if LD_IS_LLD
-	default 0
+	default 000000
 
 config RUST_IS_AVAILABLE
 	def_bool $(success,$(srctree)/scripts/rust_is_available.sh)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d93dbe5a1d14..9d5f061fc4cf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -258,7 +258,7 @@ config DEBUG_INFO_NONE
 config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 	bool "Rely on the toolchain's implicit default DWARF version"
 	select DEBUG_INFO
-	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502 && AS_HAS_NON_CONST_LEB128)
+	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 023502 && AS_HAS_NON_CONST_LEB128)
 	help
 	  The implicit default version of DWARF debug info produced by a
 	  toolchain changes over time.
@@ -270,7 +270,7 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 config DEBUG_INFO_DWARF4
 	bool "Generate DWARF Version 4 debuginfo"
 	select DEBUG_INFO
-	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
+	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 023502)
 	help
 	  Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
 	  if using clang without clang's integrated assembler, and gdb 7.0+.
@@ -282,7 +282,7 @@ config DEBUG_INFO_DWARF4
 config DEBUG_INFO_DWARF5
 	bool "Generate DWARF Version 5 debuginfo"
 	select DEBUG_INFO
-	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502 && AS_HAS_NON_CONST_LEB128)
+	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 023502 && AS_HAS_NON_CONST_LEB128)
 	help
 	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
 	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index ca09b1cf8ee9..2ad969c6eb29 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -29,7 +29,7 @@ config CC_HAS_KASAN_SW_TAGS
 # Old GCC versions do not have proper support for no_sanitize_address.
 # See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89124 for details.
 config CC_HAS_WORKING_NOSANITIZE_ADDRESS
-	def_bool !CC_IS_GCC || GCC_VERSION >= 80300
+	def_bool !CC_IS_GCC || GCC_VERSION >= 080300
 
 menuconfig KASAN
 	bool "KASAN: dynamic memory safety error detector"
diff --git a/scripts/as-version.sh b/scripts/as-version.sh
index 1a21495e9ff0..778ccbc82ca8 100755
--- a/scripts/as-version.sh
+++ b/scripts/as-version.sh
@@ -1,14 +1,14 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Print the assembler name and its version in a 5 or 6-digit form.
+# Print the assembler name and its version in a 6-digit form.
 # Also, perform the minimum version check.
 # (If it is the integrated assembler, return 0 as the version, and
 # skip the version check.)
 
 set -e
 
-# Convert the version string x.y.z to a canonical 5 or 6-digit form.
+# Convert the version string x.y.z to a canonical 6-digit form.
 get_canonical_version()
 {
 	IFS=.
@@ -18,7 +18,7 @@ get_canonical_version()
 	#
 	# The 4th field, if present, is ignored.
 	# This occurs in development snapshots as in 2.35.1.20201116
-	echo $((10000 * $1 + 100 * ${2:-0} + ${3:-0}))
+	printf "%06d\n" $((10000 * $1 + 100 * ${2:-0} + ${3:-0}))
 }
 
 # Clang fails to handle -Wa,--version unless -fno-integrated-as is given.
diff --git a/scripts/cc-version.sh b/scripts/cc-version.sh
index 2401c86fcf53..fe9f446a40b4 100755
--- a/scripts/cc-version.sh
+++ b/scripts/cc-version.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 #
-# Print the C compiler name and its version in a 5 or 6-digit form.
+# Print the C compiler name and its version in a 6-digit form.
 # Also, perform the minimum version check.
 
 set -e
@@ -22,12 +22,12 @@ get_c_compiler_info()
 	EOF
 }
 
-# Convert the version string x.y.z to a canonical 5 or 6-digit form.
+# Convert the version string x.y.z to a canonical 6-digit form.
 get_canonical_version()
 {
 	IFS=.
 	set -- $1
-	echo $((10000 * $1 + 100 * $2 + $3))
+	printf "%06d\n" $((10000 * $1 + 100 * $2 + $3))
 }
 
 # $@ instead of $1 because multiple words might be given, e.g. CC="ccache gcc".
diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
index a78b804b680c..a00693198a53 100755
--- a/scripts/ld-version.sh
+++ b/scripts/ld-version.sh
@@ -1,12 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 #
-# Print the linker name and its version in a 5 or 6-digit form.
+# Print the linker name and its version in a 6-digit form.
 # Also, perform the minimum version check.
 
 set -e
 
-# Convert the version string x.y.z to a canonical 5 or 6-digit form.
+# Convert the version string x.y.z to a canonical 6-digit form.
 get_canonical_version()
 {
 	IFS=.
@@ -16,7 +16,7 @@ get_canonical_version()
 	#
 	# The 4th field, if present, is ignored.
 	# This occurs in development snapshots as in 2.35.1.20201116
-	echo $((10000 * $1 + 100 * ${2:-0} + ${3:-0}))
+	printf "%06d\n" $((10000 * $1 + 100 * ${2:-0} + ${3:-0}))
 }
 
 orig_args="$@"
-- 
2.34.1

