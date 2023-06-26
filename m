Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF973DE9E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjFZMON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFZMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:13:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE4BE71
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:13:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687781632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=P8g+5n+J3N1nA93EaxAa5rsy1QFfTmfklOWO3RCLYj4=;
        b=CSfNrBw6TjAGvxzvcoH9X4ZnhjwkbbUoqBeI1xN+wWwdSeEZHMY+ZY6G+ZtY4Fb0rpBdz8
        W2CzdTvU+irf+BdswSwi88RRck7VdAn+MXJYNBsJkrGBcVWuQD1+7ekja++2OI8QX6+yYT
        n7YYfuOtw918bg7tqebaBpEm8kOHjlWpW7OAKkbbaCx00Wrg5Gvv4BCNT2WSCkBEHaHEfB
        AkM8rvgWUQKa27AZj/19S7KNflSMYabCM2C2X/1EEvwALzWdDRZAN/h9OYPsaqVjaA5GEQ
        aaTLcP7dwCJlndozv+LG+XqDdfOBVLciCKjP8ZhE6wdXYatmJ3nnj/ayQKC/aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687781632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=P8g+5n+J3N1nA93EaxAa5rsy1QFfTmfklOWO3RCLYj4=;
        b=4JXSYzSpcIgz4sKHZP7060b6D0IRodO8HGe6oxqjkQH0I3+5ewUtJ98+W8unPBjbj5ozKp
        eNrErgH1V7t8DTAA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/boot for v6.5-rc1
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz>
Message-ID: <168778151512.3634408.11432553576702911909.tglx@vps.praguecc.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 26 Jun 2023 14:13:52 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/boot branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2023-06=
-26

up to:  0a9567ac5e6a: x86/mem_encrypt: Unbreak the AMD_MEM_ENCRYPT=3Dn build


Updates for the x86 boot process:

 - Initialize FPU late.

   Right now FPU is initialized very early during boot. There is no real
   requirement to do so. The only requirement is to have it done before
   alternatives are patched.

   That's done in check_bugs() which does way more than what the function
   name suggests.

   So first rename check_bugs() to arch_cpu_finalize_init() which makes it
   clear what this is about.

   Move the invocation of arch_cpu_finalize_init() earlier in
   start_kernel() as it has to be done before fork_init() which needs to
   know the FPU register buffer size.

   With those prerequisites the FPU initialization can be moved into
   arch_cpu_finalize_init(), which removes it from the early and fragile
   part of the x86 bringup.

Note:

This conflicts with smp/core and x86/core. The recommended ordering of
merging these three branches is smp/core, x86/boot, x86/core.

The x86/boot and final x86/core merge have both subtle conflicts. I've
pushed out the following tags:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git merge_smp_core_x=
86_boot_for_6_5
   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git merge_smp_core_x=
86_boot_x86_core_for_6_5

for your conveniance to check against.

Thanks,

	tglx

------------------>
Thomas Gleixner (18):
      init: Provide arch_cpu_finalize_init()
      x86/cpu: Switch to arch_cpu_finalize_init()
      ARM: cpu: Switch to arch_cpu_finalize_init()
      ia64/cpu: Switch to arch_cpu_finalize_init()
      loongarch/cpu: Switch to arch_cpu_finalize_init()
      m68k/cpu: Switch to arch_cpu_finalize_init()
      mips/cpu: Switch to arch_cpu_finalize_init()
      sh/cpu: Switch to arch_cpu_finalize_init()
      sparc/cpu: Switch to arch_cpu_finalize_init()
      um/cpu: Switch to arch_cpu_finalize_init()
      init: Remove check_bugs() leftovers
      init: Invoke arch_cpu_finalize_init() earlier
      init, x86: Move mem_encrypt_init() into arch_cpu_finalize_init()
      x86/init: Initialize signal frame size late
      x86/fpu: Remove cpuinfo argument from init functions
      x86/fpu: Mark init functions __init
      x86/fpu: Move FPU initialization into arch_cpu_finalize_init()
      x86/mem_encrypt: Unbreak the AMD_MEM_ENCRYPT=3Dn build


 arch/Kconfig                       |  3 ++
 arch/alpha/include/asm/bugs.h      | 20 ----------
 arch/arm/Kconfig                   |  1 +
 arch/arm/include/asm/bugs.h        |  4 --
 arch/arm/kernel/bugs.c             |  3 +-
 arch/ia64/Kconfig                  |  1 +
 arch/ia64/include/asm/bugs.h       | 20 ----------
 arch/ia64/kernel/setup.c           |  3 +-
 arch/loongarch/Kconfig             |  1 +
 arch/loongarch/include/asm/bugs.h  | 15 --------
 arch/loongarch/kernel/setup.c      |  4 +-
 arch/m68k/Kconfig                  |  1 +
 arch/m68k/include/asm/bugs.h       | 21 ----------
 arch/m68k/kernel/setup_mm.c        |  3 +-
 arch/mips/Kconfig                  |  1 +
 arch/mips/include/asm/bugs.h       | 17 --------
 arch/mips/kernel/setup.c           | 13 +++++++
 arch/parisc/include/asm/bugs.h     | 20 ----------
 arch/powerpc/include/asm/bugs.h    | 15 --------
 arch/sh/Kconfig                    |  1 +
 arch/sh/include/asm/bugs.h         | 74 -----------------------------------
 arch/sh/include/asm/processor.h    |  2 +
 arch/sh/kernel/idle.c              |  1 +
 arch/sh/kernel/setup.c             | 55 ++++++++++++++++++++++++++
 arch/sparc/Kconfig                 |  1 +
 arch/sparc/include/asm/bugs.h      | 18 ---------
 arch/sparc/kernel/setup_32.c       |  7 ++++
 arch/um/Kconfig                    |  1 +
 arch/um/include/asm/bugs.h         |  7 ----
 arch/um/kernel/um_arch.c           |  3 +-
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/bugs.h        |  2 -
 arch/x86/include/asm/fpu/api.h     |  2 +-
 arch/x86/include/asm/mem_encrypt.h |  9 +++--
 arch/x86/include/asm/sigframe.h    |  2 -
 arch/x86/kernel/cpu/bugs.c         | 51 +-----------------------
 arch/x86/kernel/cpu/common.c       | 79 ++++++++++++++++++++++++++++++++++--=
--
 arch/x86/kernel/cpu/cpu.h          |  1 +
 arch/x86/kernel/fpu/init.c         |  8 ++--
 arch/x86/kernel/signal.c           |  4 +-
 arch/xtensa/include/asm/bugs.h     | 18 ---------
 include/asm-generic/bugs.h         | 11 ------
 include/linux/cpu.h                |  6 +++
 init/main.c                        | 16 +-------
 44 files changed, 194 insertions(+), 352 deletions(-)
 delete mode 100644 arch/alpha/include/asm/bugs.h
 delete mode 100644 arch/ia64/include/asm/bugs.h
 delete mode 100644 arch/loongarch/include/asm/bugs.h
 delete mode 100644 arch/m68k/include/asm/bugs.h
 delete mode 100644 arch/parisc/include/asm/bugs.h
 delete mode 100644 arch/powerpc/include/asm/bugs.h
 delete mode 100644 arch/sh/include/asm/bugs.h
 delete mode 100644 arch/sparc/include/asm/bugs.h
 delete mode 100644 arch/um/include/asm/bugs.h
 delete mode 100644 arch/xtensa/include/asm/bugs.h
 delete mode 100644 include/asm-generic/bugs.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 205fd23e0cad..171e6b5e61b8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -285,6 +285,9 @@ config ARCH_HAS_DMA_SET_UNCACHED
 config ARCH_HAS_DMA_CLEAR_UNCACHED
 	bool
=20
+config ARCH_HAS_CPU_FINALIZE_INIT
+	bool
+
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
 	bool
diff --git a/arch/alpha/include/asm/bugs.h b/arch/alpha/include/asm/bugs.h
deleted file mode 100644
index 78030d1c7e7e..000000000000
--- a/arch/alpha/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  include/asm-alpha/bugs.h
- *
- *  Copyright (C) 1994  Linus Torvalds
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-/*
- * I don't know of any alpha bugs yet.. Nice chip
- */
-
-static void check_bugs(void)
-{
-}
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0fb4b218f665..d6ebe3e1f8d1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
 	select ARCH_32BIT_OFF_T
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POI=
NTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm/include/asm/bugs.h b/arch/arm/include/asm/bugs.h
index 97a312ba0840..fe385551edec 100644
--- a/arch/arm/include/asm/bugs.h
+++ b/arch/arm/include/asm/bugs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/include/asm/bugs.h
- *
  *  Copyright (C) 1995-2003 Russell King
  */
 #ifndef __ASM_BUGS_H
@@ -10,10 +8,8 @@
 extern void check_writebuffer_bugs(void);
=20
 #ifdef CONFIG_MMU
-extern void check_bugs(void);
 extern void check_other_bugs(void);
 #else
-#define check_bugs() do { } while (0)
 #define check_other_bugs() do { } while (0)
 #endif
=20
diff --git a/arch/arm/kernel/bugs.c b/arch/arm/kernel/bugs.c
index 14c8dbbb7d2d..087bce6ec8e9 100644
--- a/arch/arm/kernel/bugs.c
+++ b/arch/arm/kernel/bugs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
+#include <linux/cpu.h>
 #include <asm/bugs.h>
 #include <asm/proc-fns.h>
=20
@@ -11,7 +12,7 @@ void check_other_bugs(void)
 #endif
 }
=20
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	check_writebuffer_bugs();
 	check_other_bugs();
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 21fa63ce5ffc..2cd93e6bf0fe 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -9,6 +9,7 @@ menu "Processor type and features"
 config IA64
 	bool
 	select ARCH_BINFMT_ELF_EXTRA_PHDRS
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
diff --git a/arch/ia64/include/asm/bugs.h b/arch/ia64/include/asm/bugs.h
deleted file mode 100644
index 0d6b9bded56c..000000000000
--- a/arch/ia64/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- *
- * Based on <asm-alpha/bugs.h>.
- *
- * Modified 1998, 1999, 2003
- *	David Mosberger-Tang <davidm@hpl.hp.com>,  Hewlett-Packard Co.
- */
-#ifndef _ASM_IA64_BUGS_H
-#define _ASM_IA64_BUGS_H
-
-#include <asm/processor.h>
-
-extern void check_bugs (void);
-
-#endif /* _ASM_IA64_BUGS_H */
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index c05728044272..9009f1871e3b 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -1067,8 +1067,7 @@ cpu_init (void)
 	}
 }
=20
-void __init
-check_bugs (void)
+void __init arch_cpu_finalize_init(void)
 {
 	ia64_patch_mckinley_e9((unsigned long) __start___mckinley_e9_bundles,
 			       (unsigned long) __end___mckinley_e9_bundles);
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d38b066fc931..cbab4f9ca15c 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -10,6 +10,7 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/loongarch/include/asm/bugs.h b/arch/loongarch/include/asm/b=
ugs.h
deleted file mode 100644
index 98396535163b..000000000000
--- a/arch/loongarch/include/asm/bugs.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#ifndef _ASM_BUGS_H
-#define _ASM_BUGS_H
-
-#include <asm/cpu.h>
-#include <asm/cpu-info.h>
-
-extern void check_bugs(void);
-
-#endif /* _ASM_BUGS_H */
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 4444b13418f0..78a00359bde3 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -12,6 +12,7 @@
  */
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/cpu.h>
 #include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/export.h>
@@ -37,7 +38,6 @@
 #include <asm/addrspace.h>
 #include <asm/alternative.h>
 #include <asm/bootinfo.h>
-#include <asm/bugs.h>
 #include <asm/cache.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
@@ -87,7 +87,7 @@ const char *get_system_type(void)
 	return "generic-loongson-machine";
 }
=20
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	alternative_instructions();
 }
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 40198a1ebe27..dc792b321f1e 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -4,6 +4,7 @@ config M68K
 	default y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
diff --git a/arch/m68k/include/asm/bugs.h b/arch/m68k/include/asm/bugs.h
deleted file mode 100644
index 745530651e0b..000000000000
--- a/arch/m68k/include/asm/bugs.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  include/asm-m68k/bugs.h
- *
- *  Copyright (C) 1994  Linus Torvalds
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-#ifdef CONFIG_MMU
-extern void check_bugs(void);	/* in arch/m68k/kernel/setup.c */
-#else
-static void check_bugs(void)
-{
-}
-#endif
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index fbff1cea62ca..6f1ae01f322c 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -10,6 +10,7 @@
  */
=20
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
@@ -504,7 +505,7 @@ static int __init proc_hardware_init(void)
 module_init(proc_hardware_init);
 #endif
=20
-void check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 #if defined(CONFIG_FPU) && !defined(CONFIG_M68KFPU_EMU)
 	if (m68k_fputype =3D=3D 0) {
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c2f5498d207f..023d3bd8956b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER if !CC_IS_CLANG || CLANG_VERSION >=3D=
 140000
 	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
index 653f78f3a685..84be74afcb9a 100644
--- a/arch/mips/include/asm/bugs.h
+++ b/arch/mips/include/asm/bugs.h
@@ -1,17 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
  * Copyright (C) 2007  Maciej W. Rozycki
- *
- * Needs:
- *	void check_bugs(void);
  */
 #ifndef _ASM_BUGS_H
 #define _ASM_BUGS_H
=20
 #include <linux/bug.h>
-#include <linux/delay.h>
 #include <linux/smp.h>
=20
 #include <asm/cpu.h>
@@ -24,17 +18,6 @@ extern void check_bugs64_early(void);
 extern void check_bugs32(void);
 extern void check_bugs64(void);
=20
-static inline void __init check_bugs(void)
-{
-	unsigned int cpu =3D smp_processor_id();
-
-	cpu_data[cpu].udelay_val =3D loops_per_jiffy;
-	check_bugs32();
-
-	if (IS_ENABLED(CONFIG_CPU_R4X00_BUGS64))
-		check_bugs64();
-}
-
 static inline int r4k_daddiu_bug(void)
 {
 	if (!IS_ENABLED(CONFIG_CPU_R4X00_BUGS64))
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index febdc5564638..07a151803ee0 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -11,6 +11,8 @@
  * Copyright (C) 2000, 2001, 2002, 2007	 Maciej W. Rozycki
  */
 #include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/export.h>
 #include <linux/screen_info.h>
@@ -840,3 +842,14 @@ static int __init setnocoherentio(char *str)
 }
 early_param("nocoherentio", setnocoherentio);
 #endif
+
+void __init arch_cpu_finalize_init(void)
+{
+	unsigned int cpu =3D smp_processor_id();
+
+	cpu_data[cpu].udelay_val =3D loops_per_jiffy;
+	check_bugs32();
+
+	if (IS_ENABLED(CONFIG_CPU_R4X00_BUGS64))
+		check_bugs64();
+}
diff --git a/arch/parisc/include/asm/bugs.h b/arch/parisc/include/asm/bugs.h
deleted file mode 100644
index 0a7f9db6bd1c..000000000000
--- a/arch/parisc/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  include/asm-parisc/bugs.h
- *
- *  Copyright (C) 1999	Mike Shaver
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-#include <asm/processor.h>
-
-static inline void check_bugs(void)
-{
-//	identify_cpu(&boot_cpu_data);
-}
diff --git a/arch/powerpc/include/asm/bugs.h b/arch/powerpc/include/asm/bugs.h
deleted file mode 100644
index 01b8f6ca4dbb..000000000000
--- a/arch/powerpc/include/asm/bugs.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_POWERPC_BUGS_H
-#define _ASM_POWERPC_BUGS_H
-
-/*
- */
-
-/*
- * This file is included by 'init/main.c' to check for
- * architecture-dependent bugs.
- */
-
-static inline void check_bugs(void) { }
-
-#endif	/* _ASM_POWERPC_BUGS_H */
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9652d367fc37..e339745f62a1 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -6,6 +6,7 @@ config SUPERH
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_HAS_BINFMT_FLAT if !MMU
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/sh/include/asm/bugs.h b/arch/sh/include/asm/bugs.h
deleted file mode 100644
index fe52abb69cea..000000000000
--- a/arch/sh/include/asm/bugs.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_BUGS_H
-#define __ASM_SH_BUGS_H
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-/*
- * I don't know of any Super-H bugs yet.
- */
-
-#include <asm/processor.h>
-
-extern void select_idle_routine(void);
-
-static void __init check_bugs(void)
-{
-	extern unsigned long loops_per_jiffy;
-	char *p =3D &init_utsname()->machine[2]; /* "sh" */
-
-	select_idle_routine();
-
-	current_cpu_data.loops_per_jiffy =3D loops_per_jiffy;
-
-	switch (current_cpu_data.family) {
-	case CPU_FAMILY_SH2:
-		*p++ =3D '2';
-		break;
-	case CPU_FAMILY_SH2A:
-		*p++ =3D '2';
-		*p++ =3D 'a';
-		break;
-	case CPU_FAMILY_SH3:
-		*p++ =3D '3';
-		break;
-	case CPU_FAMILY_SH4:
-		*p++ =3D '4';
-		break;
-	case CPU_FAMILY_SH4A:
-		*p++ =3D '4';
-		*p++ =3D 'a';
-		break;
-	case CPU_FAMILY_SH4AL_DSP:
-		*p++ =3D '4';
-		*p++ =3D 'a';
-		*p++ =3D 'l';
-		*p++ =3D '-';
-		*p++ =3D 'd';
-		*p++ =3D 's';
-		*p++ =3D 'p';
-		break;
-	case CPU_FAMILY_UNKNOWN:
-		/*
-		 * Specifically use CPU_FAMILY_UNKNOWN rather than
-		 * default:, so we're able to have the compiler whine
-		 * about unhandled enumerations.
-		 */
-		break;
-	}
-
-	printk("CPU: %s\n", get_cpu_subtype(&current_cpu_data));
-
-#ifndef __LITTLE_ENDIAN__
-	/* 'eb' means 'Endian Big' */
-	*p++ =3D 'e';
-	*p++ =3D 'b';
-#endif
-	*p =3D '\0';
-}
-#endif /* __ASM_SH_BUGS_H */
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 85a6c1c3c16e..73fba7c922f9 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -166,6 +166,8 @@ extern unsigned int instruction_size(unsigned int insn);
 #define instruction_size(insn)	(2)
 #endif
=20
+void select_idle_routine(void);
+
 #endif /* __ASSEMBLY__ */
=20
 #include <asm/processor_32.h>
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index d662503b0665..045d93f151fd 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -15,6 +15,7 @@
 #include <linux/irqflags.h>
 #include <linux/smp.h>
 #include <linux/atomic.h>
+#include <asm/processor.h>
 #include <asm/smp.h>
 #include <asm/bl_bit.h>
=20
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index af977ec4ca5e..cf7c0f72f293 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <asm/smp.h>
 #include <asm/mmu_context.h>
 #include <asm/mmzone.h>
+#include <asm/processor.h>
 #include <asm/sparsemem.h>
 #include <asm/platform_early.h>
=20
@@ -354,3 +355,57 @@ int test_mode_pin(int pin)
 {
 	return sh_mv.mv_mode_pins() & pin;
 }
+
+void __init arch_cpu_finalize_init(void)
+{
+	char *p =3D &init_utsname()->machine[2]; /* "sh" */
+
+	select_idle_routine();
+
+	current_cpu_data.loops_per_jiffy =3D loops_per_jiffy;
+
+	switch (current_cpu_data.family) {
+	case CPU_FAMILY_SH2:
+		*p++ =3D '2';
+		break;
+	case CPU_FAMILY_SH2A:
+		*p++ =3D '2';
+		*p++ =3D 'a';
+		break;
+	case CPU_FAMILY_SH3:
+		*p++ =3D '3';
+		break;
+	case CPU_FAMILY_SH4:
+		*p++ =3D '4';
+		break;
+	case CPU_FAMILY_SH4A:
+		*p++ =3D '4';
+		*p++ =3D 'a';
+		break;
+	case CPU_FAMILY_SH4AL_DSP:
+		*p++ =3D '4';
+		*p++ =3D 'a';
+		*p++ =3D 'l';
+		*p++ =3D '-';
+		*p++ =3D 'd';
+		*p++ =3D 's';
+		*p++ =3D 'p';
+		break;
+	case CPU_FAMILY_UNKNOWN:
+		/*
+		 * Specifically use CPU_FAMILY_UNKNOWN rather than
+		 * default:, so we're able to have the compiler whine
+		 * about unhandled enumerations.
+		 */
+		break;
+	}
+
+	pr_info("CPU: %s\n", get_cpu_subtype(&current_cpu_data));
+
+#ifndef __LITTLE_ENDIAN__
+	/* 'eb' means 'Endian Big' */
+	*p++ =3D 'e';
+	*p++ =3D 'b';
+#endif
+	*p =3D '\0';
+}
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8535e19062f6..36fd488ccbfa 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -52,6 +52,7 @@ config SPARC
 config SPARC32
 	def_bool !64BIT
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select CLZ_TAB
 	select DMA_DIRECT_REMAP
diff --git a/arch/sparc/include/asm/bugs.h b/arch/sparc/include/asm/bugs.h
deleted file mode 100644
index 02fa369b9c21..000000000000
--- a/arch/sparc/include/asm/bugs.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* include/asm/bugs.h:  Sparc probes for various bugs.
- *
- * Copyright (C) 1996, 2007 David S. Miller (davem@davemloft.net)
- */
-
-#ifdef CONFIG_SPARC32
-#include <asm/cpudata.h>
-#endif
-
-extern unsigned long loops_per_jiffy;
-
-static void __init check_bugs(void)
-{
-#if defined(CONFIG_SPARC32) && !defined(CONFIG_SMP)
-	cpu_data(0).udelay_val =3D loops_per_jiffy;
-#endif
-}
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index c8e0dd99f370..c9d1ba4f311b 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -412,3 +412,10 @@ static int __init topology_init(void)
 }
=20
 subsys_initcall(topology_init);
+
+#if defined(CONFIG_SPARC32) && !defined(CONFIG_SMP)
+void __init arch_cpu_finalize_init(void)
+{
+	cpu_data(0).udelay_val =3D loops_per_jiffy;
+}
+#endif
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 541a9b18e343..887cfb636c26 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,6 +6,7 @@ config UML
 	bool
 	default y
 	select ARCH_EPHEMERAL_INODES
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
diff --git a/arch/um/include/asm/bugs.h b/arch/um/include/asm/bugs.h
deleted file mode 100644
index 4473942a0839..000000000000
--- a/arch/um/include/asm/bugs.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_BUGS_H
-#define __UM_BUGS_H
-
-void check_bugs(void);
-
-#endif
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0a23a98d4ca0..918fed7ad4d8 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
=20
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -430,7 +431,7 @@ void __init setup_arch(char **cmdline_p)
 	}
 }
=20
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	arch_check_bugs();
 	os_check_bugs();
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..e8ebafabd099 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -71,6 +71,7 @@ config X86
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
diff --git a/arch/x86/include/asm/bugs.h b/arch/x86/include/asm/bugs.h
index 92ae28389940..f25ca2d709d4 100644
--- a/arch/x86/include/asm/bugs.h
+++ b/arch/x86/include/asm/bugs.h
@@ -4,8 +4,6 @@
=20
 #include <asm/processor.h>
=20
-extern void check_bugs(void);
-
 #if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_X86_32)
 int ppro_with_ram_bug(void);
 #else
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 503a577814b2..b475d9a582b8 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -109,7 +109,7 @@ extern void fpu_reset_from_exception_fixup(void);
=20
 /* Boot, hotplug and resume */
 extern void fpu__init_cpu(void);
-extern void fpu__init_system(struct cpuinfo_x86 *c);
+extern void fpu__init_system(void);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
=20
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_en=
crypt.h
index b7126701574c..7f97a8a97e24 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -17,6 +17,12 @@
=20
 #include <asm/bootparam.h>
=20
+#ifdef CONFIG_X86_MEM_ENCRYPT
+void __init mem_encrypt_init(void);
+#else
+static inline void mem_encrypt_init(void) { }
+#endif
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
=20
 extern u64 sme_me_mask;
@@ -87,9 +93,6 @@ static inline void mem_encrypt_free_decrypted_mem(void) { }
=20
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
=20
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void);
-
 void add_encrypt_protection_map(void);
=20
 /*
diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index 5b1ed650b124..84eab2724875 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -85,6 +85,4 @@ struct rt_sigframe_x32 {
=20
 #endif /* CONFIG_X86_64 */
=20
-void __init init_sigframe_size(void);
-
 #endif /* _ASM_X86_SIGFRAME_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 182af64387d0..9e2a91830f72 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -9,7 +9,6 @@
  *	- Andrew D. Balsa (code cleanup).
  */
 #include <linux/init.h>
-#include <linux/utsname.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/nospec.h>
@@ -27,8 +26,6 @@
 #include <asm/msr.h>
 #include <asm/vmx.h>
 #include <asm/paravirt.h>
-#include <asm/alternative.h>
-#include <asm/set_memory.h>
 #include <asm/intel-family.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
@@ -125,21 +122,8 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 DEFINE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 EXPORT_SYMBOL_GPL(mmio_stale_data_clear);
=20
-void __init check_bugs(void)
+void __init cpu_select_mitigations(void)
 {
-	identify_boot_cpu();
-
-	/*
-	 * identify_boot_cpu() initialized SMT support information, let the
-	 * core code know.
-	 */
-	cpu_smt_check_topology();
-
-	if (!IS_ENABLED(CONFIG_SMP)) {
-		pr_info("CPU: ");
-		print_cpu_info(&boot_cpu_data);
-	}
-
 	/*
 	 * Read the SPEC_CTRL MSR to account for reserved bits which may
 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
@@ -176,39 +160,6 @@ void __init check_bugs(void)
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
-
-	arch_smt_update();
-
-#ifdef CONFIG_X86_32
-	/*
-	 * Check whether we are able to run this kernel safely on SMP.
-	 *
-	 * - i386 is no longer supported.
-	 * - In order to run on anything without a TSC, we need to be
-	 *   compiled for a i486.
-	 */
-	if (boot_cpu_data.x86 < 4)
-		panic("Kernel requires i486+ for 'invlpg' and other features");
-
-	init_utsname()->machine[1] =3D
-		'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
-	alternative_instructions();
-
-	fpu__init_check_bugs();
-#else /* CONFIG_X86_64 */
-	alternative_instructions();
-
-	/*
-	 * Make sure the first 2MB area is not mapped by huge pages
-	 * There are typically fixed size MTRRs in there and overlapping
-	 * MTRRs into large pages causes slow downs.
-	 *
-	 * Right now we don't do that with gbpages because there seems
-	 * very little benefit for that case.
-	 */
-	if (!direct_gbpages)
-		set_memory_4k((unsigned long)__va(0), 1);
-#endif
 }
=20
 /*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 80710a68ef7d..46ebdd60fd96 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -18,12 +18,16 @@
 #include <linux/init.h>
 #include <linux/kprobes.h>
 #include <linux/kgdb.h>
+#include <linux/mem_encrypt.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/syscore_ops.h>
 #include <linux/pgtable.h>
 #include <linux/stackprotector.h>
+#include <linux/utsname.h>
=20
+#include <asm/alternative.h>
 #include <asm/cmdline.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
@@ -59,7 +63,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
-#include <asm/sigframe.h>
+#include <asm/set_memory.h>
 #include <asm/traps.h>
 #include <asm/sev.h>
=20
@@ -1600,10 +1604,6 @@ static void __init early_identify_cpu(struct cpuinfo_x=
86 *c)
=20
 	sld_setup(c);
=20
-	fpu__init_system(c);
-
-	init_sigframe_size();
-
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
@@ -2285,8 +2285,6 @@ void cpu_init(void)
=20
 	doublefault_init_cpu_tss();
=20
-	fpu__init_cpu();
-
 	if (is_uv_system())
 		uv_cpu_init();
=20
@@ -2302,6 +2300,7 @@ void cpu_init_secondary(void)
 	 */
 	cpu_init_exception_handling();
 	cpu_init();
+	fpu__init_cpu();
 }
 #endif
=20
@@ -2362,3 +2361,69 @@ void arch_smt_update(void)
 	/* Check whether IPI broadcasting can be enabled */
 	apic_smt_update();
 }
+
+void __init arch_cpu_finalize_init(void)
+{
+	identify_boot_cpu();
+
+	/*
+	 * identify_boot_cpu() initialized SMT support information, let the
+	 * core code know.
+	 */
+	cpu_smt_check_topology();
+
+	if (!IS_ENABLED(CONFIG_SMP)) {
+		pr_info("CPU: ");
+		print_cpu_info(&boot_cpu_data);
+	}
+
+	cpu_select_mitigations();
+
+	arch_smt_update();
+
+	if (IS_ENABLED(CONFIG_X86_32)) {
+		/*
+		 * Check whether this is a real i386 which is not longer
+		 * supported and fixup the utsname.
+		 */
+		if (boot_cpu_data.x86 < 4)
+			panic("Kernel requires i486+ for 'invlpg' and other features");
+
+		init_utsname()->machine[1] =3D
+			'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
+	}
+
+	/*
+	 * Must be before alternatives because it might set or clear
+	 * feature bits.
+	 */
+	fpu__init_system();
+	fpu__init_cpu();
+
+	alternative_instructions();
+
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/*
+		 * Make sure the first 2MB area is not mapped by huge pages
+		 * There are typically fixed size MTRRs in there and overlapping
+		 * MTRRs into large pages causes slow downs.
+		 *
+		 * Right now we don't do that with gbpages because there seems
+		 * very little benefit for that case.
+		 */
+		if (!direct_gbpages)
+			set_memory_4k((unsigned long)__va(0), 1);
+	} else {
+		fpu__init_check_bugs();
+	}
+
+	/*
+	 * This needs to be called before any devices perform DMA
+	 * operations that might use the SWIOTLB bounce buffers. It will
+	 * mark the bounce buffers as decrypted so that their usage will
+	 * not cause "plain-text" data to be decrypted when accessed. It
+	 * must be called after late_time_init() so that Hyper-V x86/x64
+	 * hypercalls work when the SWIOTLB bounce buffers are decrypted.
+	 */
+	mem_encrypt_init();
+}
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index f97b0fe13da8..1c44630d4789 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -79,6 +79,7 @@ extern void detect_ht(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
=20
 unsigned int aperfmperf_get_khz(int cpu);
+void cpu_select_mitigations(void);
=20
 extern void x86_spec_ctrl_setup_ap(void);
 extern void update_srbds_msr(void);
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 851eb13edc01..998a08f17e33 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -53,7 +53,7 @@ void fpu__init_cpu(void)
 	fpu__init_cpu_xstate();
 }
=20
-static bool fpu__probe_without_cpuid(void)
+static bool __init fpu__probe_without_cpuid(void)
 {
 	unsigned long cr0;
 	u16 fsw, fcw;
@@ -71,7 +71,7 @@ static bool fpu__probe_without_cpuid(void)
 	return fsw =3D=3D 0 && (fcw & 0x103f) =3D=3D 0x003f;
 }
=20
-static void fpu__init_system_early_generic(struct cpuinfo_x86 *c)
+static void __init fpu__init_system_early_generic(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
@@ -211,10 +211,10 @@ static void __init fpu__init_system_xstate_size_legacy(=
void)
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
-void __init fpu__init_system(struct cpuinfo_x86 *c)
+void __init fpu__init_system(void)
 {
 	fpstate_reset(&current->thread.fpu);
-	fpu__init_system_early_generic(c);
+	fpu__init_system_early_generic();
=20
 	/*
 	 * The FPU has to be operational for some of the
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 004cb30b7419..cfeec3ee877e 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -182,7 +182,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, =
size_t frame_size,
 static unsigned long __ro_after_init max_frame_size;
 static unsigned int __ro_after_init fpu_default_state_size;
=20
-void __init init_sigframe_size(void)
+static int __init init_sigframe_size(void)
 {
 	fpu_default_state_size =3D fpu__get_fpstate_size();
=20
@@ -194,7 +194,9 @@ void __init init_sigframe_size(void)
 	max_frame_size =3D round_up(max_frame_size, FRAME_ALIGNMENT);
=20
 	pr_info("max sigframe size: %lu\n", max_frame_size);
+	return 0;
 }
+early_initcall(init_sigframe_size);
=20
 unsigned long get_sigframe_size(void)
 {
diff --git a/arch/xtensa/include/asm/bugs.h b/arch/xtensa/include/asm/bugs.h
deleted file mode 100644
index 69b29d198249..000000000000
--- a/arch/xtensa/include/asm/bugs.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * include/asm-xtensa/bugs.h
- *
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Xtensa processors don't have any bugs.  :)
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file "COPYING" in the main directory of
- * this archive for more details.
- */
-
-#ifndef _XTENSA_BUGS_H
-#define _XTENSA_BUGS_H
-
-static void check_bugs(void) { }
-
-#endif /* _XTENSA_BUGS_H */
diff --git a/include/asm-generic/bugs.h b/include/asm-generic/bugs.h
deleted file mode 100644
index 69021830f078..000000000000
--- a/include/asm-generic/bugs.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_GENERIC_BUGS_H
-#define __ASM_GENERIC_BUGS_H
-/*
- * This file is included by 'init/main.c' to check for
- * architecture-dependent bugs.
- */
-
-static inline void check_bugs(void) { }
-
-#endif	/* __ASM_GENERIC_BUGS_H */
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 8582a7142623..4893c4ac026d 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -184,6 +184,12 @@ void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void __noreturn arch_cpu_idle_dead(void);
=20
+#ifdef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
+void arch_cpu_finalize_init(void);
+#else
+static inline void arch_cpu_finalize_init(void) { }
+#endif
+
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
diff --git a/init/main.c b/init/main.c
index af50044deed5..32c65f28d84a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -95,7 +95,6 @@
 #include <linux/cache.h>
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
-#include <linux/mem_encrypt.h>
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
@@ -103,7 +102,6 @@
 #include <net/net_namespace.h>
=20
 #include <asm/io.h>
-#include <asm/bugs.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -787,8 +785,6 @@ void __init __weak thread_stack_cache_init(void)
 }
 #endif
=20
-void __init __weak mem_encrypt_init(void) { }
-
 void __init __weak poking_init(void) { }
=20
 void __init __weak pgtable_cache_init(void) { }
@@ -1042,15 +1038,7 @@ asmlinkage __visible void __init __no_sanitize_address=
 __noreturn start_kernel(v
 	sched_clock_init();
 	calibrate_delay();
=20
-	/*
-	 * This needs to be called before any devices perform DMA
-	 * operations that might use the SWIOTLB bounce buffers. It will
-	 * mark the bounce buffers as decrypted so that their usage will
-	 * not cause "plain-text" data to be decrypted when accessed. It
-	 * must be called after late_time_init() so that Hyper-V x86/x64
-	 * hypercalls work when the SWIOTLB bounce buffers are decrypted.
-	 */
-	mem_encrypt_init();
+	arch_cpu_finalize_init();
=20
 	pid_idr_init();
 	anon_vma_init();
@@ -1078,8 +1066,6 @@ asmlinkage __visible void __init __no_sanitize_address =
__noreturn start_kernel(v
 	taskstats_init_early();
 	delayacct_init();
=20
-	check_bugs();
-
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
 	kcsan_init();

