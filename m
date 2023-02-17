Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFDE69A615
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBQH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBQH1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:27:04 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 669475DE07
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:26:47 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxidk2LO9jRa4BAA--.3971S3;
        Fri, 17 Feb 2023 15:26:46 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+QmLO9jiSQ1AA--.63745S6;
        Fri, 17 Feb 2023 15:26:45 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] LoongArch: Add support for kernel relocation
Date:   Fri, 17 Feb 2023 15:26:28 +0800
Message-Id: <1676618789-20485-5-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1676618789-20485-1-git-send-email-tangyouling@loongson.cn>
References: <1676618789-20485-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Cxf+QmLO9jiSQ1AA--.63745S6
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKr4xCrW3ZFWUZr4kZFyUtrb_yoWfGrWfpr
        Zrur4kJF45GFn3Z34Dt34kuryUJan7Ww12ga9xK34rAF42vFyDX3ykZr9rXF1jqw48XFWF
        gFyfKw12vF4UAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b2xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4U
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7eT5DUUUU
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
Signed-off-by: Jinyang He <hejinyang@loongson.cn> # Provide la_abs idea
---
 arch/loongarch/Kconfig                |   8 ++
 arch/loongarch/Makefile               |   5 ++
 arch/loongarch/include/asm/asmmacro.h |  13 ++++
 arch/loongarch/include/asm/setup.h    |  14 ++++
 arch/loongarch/kernel/Makefile        |   2 +
 arch/loongarch/kernel/head.S          |   5 ++
 arch/loongarch/kernel/relocate.c      | 104 ++++++++++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S   |  20 ++++-
 8 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 arch/loongarch/kernel/relocate.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 54bd3dbde1f2..406a28758a52 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -522,6 +522,14 @@ config PHYSICAL_START
 	  specified in the "crashkernel=YM@XM" command line boot parameter
 	  passed to the panic-ed kernel).
 
+config RELOCATABLE
+	bool "Relocatable kernel"
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
index ccfb52700237..2aba6ff30436 100644
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
 
diff --git a/arch/loongarch/include/asm/asmmacro.h b/arch/loongarch/include/asm/asmmacro.h
index adc92464afa6..ba99908d7d10 100644
--- a/arch/loongarch/include/asm/asmmacro.h
+++ b/arch/loongarch/include/asm/asmmacro.h
@@ -668,7 +668,20 @@
 .endm
 
 .macro la_abs reg, sym
+#ifndef CONFIG_RELOCATABLE
 	la.abs \reg, \sym
+#else
+766:
+	lu12i.w	\reg, 0
+	ori	\reg, \reg, 0
+	lu32i.d	\reg, 0
+	lu52i.d	\reg, \reg, 0
+	.pushsection ".la_abs", "aw", %progbits
+768:
+	.dword 768b-766b
+	.dword \sym
+	.popsection
+#endif
 .endm
 
 #endif /* _ASM_ASMMACRO_H */
diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index 72ead58039f3..efbd8d7b15df 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -21,4 +21,18 @@ extern void per_cpu_trap_init(int cpu);
 extern void set_handler(unsigned long offset, void *addr, unsigned long len);
 extern void set_merr_handler(unsigned long offset, void *addr, unsigned long len);
 
+#ifdef CONFIG_RELOCATABLE
+struct rela_la_abs {
+		long offset;
+		long symvalue;
+};
+
+extern long __rela_dyn_start;
+extern long __rela_dyn_end;
+extern void *__la_abs_begin;
+extern void *__la_abs_end;
+
+extern void __init relocate_kernel(void);
+#endif
+
 #endif /* __SETUP_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 45c78aea63ce..3288854dbe36 100644
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
index 000000000000..6f31753be1da
--- /dev/null
+++ b/arch/loongarch/kernel/relocate.c
@@ -0,0 +1,104 @@
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
+#include <asm/inst.h>
+#include <asm/sections.h>
+#include <asm/setup.h>
+
+#define RELOCATED(x) ((void *)((long)x + reloc_offset))
+
+static unsigned long reloc_offset;
+
+static inline __init void relocate_relative(void)
+{
+	Elf64_Rela *rela, *rela_end;
+	rela = (Elf64_Rela *)&__rela_dyn_start;
+	rela_end = (Elf64_Rela *)&__rela_dyn_end;
+
+	for ( ; rela < rela_end; rela++) {
+		Elf64_Addr addr = rela->r_offset;
+		Elf64_Addr relocated_addr = rela->r_addend;
+
+		if (rela->r_info != R_LARCH_RELATIVE)
+			continue;
+
+		if (relocated_addr >= VMLINUX_LOAD_ADDRESS)
+			relocated_addr =
+				(Elf64_Addr)RELOCATED(relocated_addr);
+
+		*(Elf64_Addr *)RELOCATED(addr) = relocated_addr;
+	}
+}
+
+static inline void __init relocate_la_abs(void)
+{
+	struct rela_la_abs *p;
+
+	for (p = (void *)&__la_abs_begin; (void *)p < (void *)&__la_abs_end; p++) {
+		long v = p->symvalue + reloc_offset;
+		union loongarch_instruction *insn = (void *)p - p->offset;
+		u32 lu12iw, ori, lu32id, lu52id;
+
+		lu12iw = (v >> 12) & 0xfffff;
+		ori = v & 0xfff;
+		lu32id = (v >> 32) & 0xfffff;
+		lu52id = v >> 52;
+
+		insn[0].reg1i20_format.immediate = lu12iw;
+		insn[1].reg2i12_format.immediate = ori;
+		insn[2].reg1i20_format.immediate = lu32id;
+		insn[3].reg2i12_format.immediate = lu52id;
+	}
+}
+
+void __init relocate_kernel(void)
+{
+	reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
+
+	if (reloc_offset)
+		relocate_relative();
+
+	relocate_la_abs();
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
index 733b16e8d55d..5ec0c008f01d 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -66,10 +66,21 @@ SECTIONS
 		__alt_instructions_end = .;
 	}
 
+#ifdef CONFIG_RELOCATABLE
+	. = ALIGN(8);
+	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
+		__la_abs_begin = .;
+		*(.la_abs)
+		__la_abs_end = .;
+	}
+#endif
+
 	.got : ALIGN(16) { *(.got) }
 	.plt : ALIGN(16) { *(.plt) }
 	.got.plt : ALIGN(16) { *(.got.plt) }
 
+	.data.rel : { *(.data.rel*) }
+
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	__init_begin = .;
 	__inittext_begin = .;
@@ -93,8 +104,6 @@ SECTIONS
 	PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
 #endif
 
-	.rela.dyn : ALIGN(8) { *(.rela.dyn) *(.rela*) }
-
 	.init.bss : {
 		*(.init.bss)
 	}
@@ -107,6 +116,12 @@ SECTIONS
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
@@ -133,6 +148,7 @@ SECTIONS
 
 	DISCARDS
 	/DISCARD/ : {
+		*(.dynamic .dynsym .dynstr .hash .gnu.hash)
 		*(.gnu.attributes)
 		*(.options)
 		*(.eh_frame)
-- 
2.37.3

