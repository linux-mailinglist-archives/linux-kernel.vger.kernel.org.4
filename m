Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B18662120
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbjAIJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbjAIJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:11:51 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3064C17E2A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:08:15 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxrvB+2btjkHUAAA--.1724S3;
        Mon, 09 Jan 2023 17:08:14 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxTuRw2btj_6sWAA--.4042S5;
        Mon, 09 Jan 2023 17:08:13 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] LoongArch: Add support for kernel relocation
Date:   Mon,  9 Jan 2023 17:07:53 +0800
Message-Id: <1673255274-18238-4-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
References: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxTuRw2btj_6sWAA--.4042S5
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3GrWxKF45uw4UZw4fWF18AFb_yoW3AF43pr
        W3ZrWkJr48GFnxJ3s2q348uryUZan7Ww43WanrKa4rCF1avF1rXw1vvr9rXFyjqws5Gr4F
        qFyrKasFva1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/loongarch/kernel/relocate.c contains the functions necessary to
relocate the kernel elsewhere in memory.

The kernel makes a copy of itself at the new address. It uses the
relocation table inserted by the relocs tool to fix symbol references
within the new image.

If copy/relocation is successful then the entry point of the new kernel
is returned, otherwise fall back to starting the kernel in place.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
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
index fcaa024a685e..33787d22e6f4 100644
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
index 000000000000..a58551c0698d
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
+	int res = 1;
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
+				relocated_addr = RELOCATED(relocated_addr);
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
+out:
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
2.37.1

