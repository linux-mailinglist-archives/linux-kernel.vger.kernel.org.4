Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C564A691A49
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjBJIsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjBJIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:48:12 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F6DE8184B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:48:00 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxe+q_BOZjoMAQAA--.32945S3;
        Fri, 10 Feb 2023 16:47:59 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+SpBOZjLUYwAA--.56353S6;
        Fri, 10 Feb 2023 16:47:58 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] LoongArch: Add support for kernel relocation
Date:   Fri, 10 Feb 2023 16:47:35 +0800
Message-Id: <1676018856-26520-5-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn>
References: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8AxX+SpBOZjLUYwAA--.56353S6
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKr4xCrW3Zw43Xw15Gw1Dtrb_yoWxZFW7pr
        Zruws5Jr47GFn3Xr9xt34kuryUJ3WkWw17WanxK34rAF12vF95X3ykZr9rXFyjqws5JFWr
        XFyrK342va15AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
        AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This config allows to compile kernel as PIE and to relocate it at
any virtual address at runtime: this paves the way to KASLR.
Runtime relocation is possible since relocation metadata are embedded
into the kernel.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Xi Ruoyao <xry111@xry111.site> # Use arch_initcall
---
 arch/loongarch/Kconfig              | 15 ++++++
 arch/loongarch/Makefile             |  5 ++
 arch/loongarch/kernel/Makefile      |  2 +
 arch/loongarch/kernel/head.S        |  5 ++
 arch/loongarch/kernel/relocate.c    | 78 +++++++++++++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S | 11 +++-
 6 files changed, 114 insertions(+), 2 deletions(-)
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
index d2ac26b5b22b..499edc80d8ab 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -86,6 +86,11 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	PTR_ADD		sp, sp, tp
 	set_saved_sp	sp, t0, t1
 
+#ifdef CONFIG_RELOCATABLE
+	/* Apply the relocations */
+	bl		relocate_kernel
+#endif
+
 	bl		start_kernel
 	ASM_BUG()
 
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
new file mode 100644
index 000000000000..91ce92433bab
--- /dev/null
+++ b/arch/loongarch/kernel/relocate.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for Kernel relocation at boot time
+ *
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/elf.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/panic_notifier.h>
+#include <asm/sections.h>
+
+#define RELOCATED(x) ((void *)((long)x + reloc_offset))
+
+extern long __rela_dyn_start;
+extern long __rela_dyn_end;
+
+static unsigned long reloc_offset;
+
+void __init relocate_kernel(void)
+{
+	reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
+
+	if (reloc_offset) {
+		Elf64_Rela *rela, *rela_end;
+		rela = (Elf64_Rela *)&__rela_dyn_start;
+		rela_end = (Elf64_Rela *)&__rela_dyn_end;
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
+		}
+	}
+}
+
+/*
+ * Show relocation information on panic.
+ */
+static void show_kernel_relocation(const char *level)
+{
+	if (reloc_offset > 0) {
+		printk(level);
+		pr_cont("Kernel relocated offset @ 0x%lx\n", reloc_offset);
+		pr_cont(" .text @ 0x%lx\n", (unsigned long)&_text);
+		pr_cont(" .data @ 0x%lx\n", (unsigned long)&_sdata);
+		pr_cont(" .bss  @ 0x%lx\n", (unsigned long)&__bss_start);
+	}
+}
+
+static int kernel_location_notifier_fn(struct notifier_block *self,
+				       unsigned long v, void *p)
+{
+	show_kernel_relocation(KERN_EMERG);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kernel_location_notifier = {
+	.notifier_call = kernel_location_notifier_fn
+};
+
+static int __init register_kernel_offset_dumper(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &kernel_location_notifier);
+	return 0;
+}
+
+arch_initcall(register_kernel_offset_dumper);
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
2.37.3

