Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3914A68F428
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjBHRRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjBHRRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:17:02 -0500
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68049421
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1675876607;
        bh=sYO9Eb5bFjdOGiuca613wuxLe3kLk565FA8I9/Mll+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGcbUbIXGNH7OgrUI02nWRGUucyb+FkY0yzQ4eBwIoGBg3seYqs0Bho7f5N1UyTgV
         b7lO+PWEwv/sMdUX6kCTar8vHBJPKiCfKJ8otiyIFH5GFu1PVzyVyIZvTtVfbPp4lF
         bKzkYezoRTps59bVRpZ1sYXdgXnB3GnKNRdXu+rU=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:1174:d100:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 7F8AA65C52;
        Wed,  8 Feb 2023 12:16:40 -0500 (EST)
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v3 4/5] LoongArch: Add support for kernel relocation
Date:   Thu,  9 Feb 2023 01:16:06 +0800
Message-Id: <20230208171607.391107-5-xry111@xry111.site>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208171607.391107-1-xry111@xry111.site>
References: <20230208171607.391107-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youling Tang <tangyouling@loongson.cn>

arch/loongarch/kernel/relocate.c contains the functions necessary to
relocate the kernel elsewhere in memory.

The kernel makes a copy of itself at the new address. It uses the
relocation table inserted by the relocs tool to fix symbol references
within the new image.

If copy/relocation is successful then the entry point of the new kernel
is returned, otherwise fall back to starting the kernel in place.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Xi Ruoyao <xry111@xry111.site> # Fix compiler warnings
---
 arch/loongarch/Kconfig              | 15 +++++
 arch/loongarch/Makefile             |  5 ++
 arch/loongarch/kernel/Makefile      |  2 +
 arch/loongarch/kernel/head.S        | 18 ++++++
 arch/loongarch/kernel/relocate.c    | 96 +++++++++++++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S | 11 +++-
 6 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 arch/loongarch/kernel/relocate.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 9cc8b84f7eb0..089a4695b1b3 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -48,6 +48,7 @@ config LOONGARCH
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_NUMA_BALANCING
+	select SYS_SUPPORTS_RELOCATABLE
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
@@ -229,6 +230,11 @@ config SCHED_OMIT_FRAME_POINTER
 config AS_HAS_EXPLICIT_RELOCS
 	def_bool $(as-instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
 
+config SYS_SUPPORTS_RELOCATABLE
+	bool
+	help
+	  Selected if the platform supports relocating the kernel.
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
@@ -474,6 +480,15 @@ config PHYSICAL_START
 	  specified in the "crashkernel=YM@XM" command line boot parameter
 	  passed to the panic-ed kernel).
 
+config RELOCATABLE
+	bool "Relocatable kernel"
+	depends on SYS_SUPPORTS_RELOCATABLE
+	help
+	  This builds the kernel as a Position Independent Executable (PIE),
+	  which retains all relocation metadata required to relocate the
+	  kernel binary at runtime to a different virtual address than the
+	  address it was linked at.
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 4402387d2755..27b5a70ff31c 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -71,6 +71,11 @@ KBUILD_AFLAGS_MODULE		+= -Wa,-mla-global-with-abs
 KBUILD_CFLAGS_MODULE		+= -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
 endif
 
+ifeq ($(CONFIG_RELOCATABLE),y)
+LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext
+KBUILD_CFLAGS_KERNEL		+= -fPIE
+endif
+
 cflags-y += -ffreestanding
 cflags-y += $(call cc-option, -mno-check-zero-division)
 
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c8cfbd562921..3341dd5f0926 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -31,6 +31,8 @@ endif
 obj-$(CONFIG_MODULES)		+= module.o module-sections.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
+obj-$(CONFIG_RELOCATABLE)	+= relocate.o
+
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index e8a4bf9d7599..6db1549177ad 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -88,7 +88,25 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	PTR_ADD		sp, sp, tp
 	set_saved_sp	sp, t0, t1
 
+#ifdef CONFIG_RELOCATABLE
+	/* Copy kernel and apply the relocations */
+	bl		relocate_kernel
+
+	/* Repoint the sp into the new kernel image */
+	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
+	PTR_ADD		sp, sp, tp
+	set_saved_sp	sp, t0, t1
+	PTR_ADDI	sp, sp, -4 * SZREG      # init stack pointer
+
+	/*
+	 * relocate_kernel returns the entry point either
+	 * in the relocated kernel or the original if for
+	 * some reason relocation failed.
+	*/
+	jr		a0
+#else
 	bl		start_kernel
+#endif
 	ASM_BUG()
 
 SYM_CODE_END(kernel_entry)
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
new file mode 100644
index 000000000000..9c61e03d3e91
--- /dev/null
+++ b/arch/loongarch/kernel/relocate.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for Kernel relocation at boot time
+ *
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/elf.h>
+#include <linux/kernel.h>
+#include <linux/start_kernel.h>
+#include <linux/printk.h>
+#include <linux/panic_notifier.h>
+#include <asm/bootinfo.h>
+#include <asm/inst.h>
+#include <asm/sections.h>
+
+#define RELOCATED(x) ((void *)((long)x + offset))
+
+extern long __rela_dyn_start;
+extern long __rela_dyn_end;
+
+/*
+ * Choose a new address for the kernel, for now we'll hard
+ * code the destination.
+ */
+static inline void __init *determine_relocation_address(void)
+{
+	return (void *)(CACHE_BASE + 0x02000000);
+}
+
+static inline int __init relocation_addr_valid(void *loc_new)
+{
+	if ((unsigned long)loc_new & 0x0000ffff) {
+		/* Inappropriately aligned new location */
+		return 0;
+	}
+	if ((unsigned long)loc_new < (unsigned long)_end) {
+		/* New location overlaps original kernel */
+		return 0;
+	}
+	return 1;
+}
+
+void *__init relocate_kernel(void)
+{
+	Elf64_Rela *rela, *rela_end;
+	void *loc_new;
+	unsigned long kernel_length;
+	long offset = 0;
+	/* Default to original kernel entry point */
+	void *kernel_entry = start_kernel;
+
+	kernel_length = (long)(_end) - (long)(_text);
+
+	loc_new = determine_relocation_address();
+
+	/* Sanity check relocation address */
+	if (relocation_addr_valid(loc_new))
+		offset = (unsigned long)loc_new - (unsigned long)(_text);
+
+	if (offset) {
+		/* Copy the kernel to it's new location */
+		memcpy(loc_new, _text, kernel_length);
+
+		/* Sync the caches ready for execution of new kernel */
+		__asm__ __volatile__ (
+			"ibar 0 \t\n"
+			"dbar 0 \t\n");
+
+		rela = (Elf64_Rela *)RELOCATED(&__rela_dyn_start);
+		rela_end = (Elf64_Rela *)RELOCATED(&__rela_dyn_end);
+
+		for ( ; rela < rela_end; rela++) {
+			Elf64_Addr addr = rela->r_offset;
+			Elf64_Addr relocated_addr = rela->r_addend;
+
+			if (rela->r_info != R_LARCH_RELATIVE)
+				continue;
+
+			if (relocated_addr >= VMLINUX_LOAD_ADDRESS)
+				relocated_addr =
+					(Elf64_Addr)RELOCATED(relocated_addr);
+
+			*(Elf64_Addr *)RELOCATED(addr) = relocated_addr;
+
+		}
+
+		/* The current thread is now within the relocated image */
+		__current_thread_info = RELOCATED(__current_thread_info);
+
+		/* Return the new kernel's entry point */
+		kernel_entry = RELOCATED(start_kernel);
+	}
+
+	return kernel_entry;
+}
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 733b16e8d55d..aec0b6567d24 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -70,6 +70,8 @@ SECTIONS
 	.plt : ALIGN(16) { *(.plt) }
 	.got.plt : ALIGN(16) { *(.got.plt) }
 
+	.data.rel : { *(.data.rel*) }
+
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	__init_begin = .;
 	__inittext_begin = .;
@@ -93,8 +95,6 @@ SECTIONS
 	PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
 #endif
 
-	.rela.dyn : ALIGN(8) { *(.rela.dyn) *(.rela*) }
-
 	.init.bss : {
 		*(.init.bss)
 	}
@@ -107,6 +107,12 @@ SECTIONS
 	RO_DATA(4096)
 	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
 
+	.rela.dyn : ALIGN(8) {
+		__rela_dyn_start = .;
+		 *(.rela.dyn) *(.rela*)
+		__rela_dyn_end = .;
+	}
+
 	.sdata : {
 		*(.sdata)
 	}
@@ -133,6 +139,7 @@ SECTIONS
 
 	DISCARDS
 	/DISCARD/ : {
+		*(.dynamic .dynsym .dynstr .hash .gnu.hash)
 		*(.gnu.attributes)
 		*(.options)
 		*(.eh_frame)
-- 
2.39.1

