Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC45D5B92C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiIOCyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIOCyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:54:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32EE88C479
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:54:04 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxrmu6kyJjTa8ZAA--.20455S3;
        Thu, 15 Sep 2022 10:53:47 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>, Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kexec@lists.infradead.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] LoongArch: Add kexec support
Date:   Thu, 15 Sep 2022 10:53:44 +0800
Message-Id: <1663210426-15446-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1663210426-15446-1-git-send-email-tangyouling@loongson.cn>
References: <1663210426-15446-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Cxrmu6kyJjTa8ZAA--.20455S3
X-Coremail-Antispam: 1UD129KBjvAXoW3uF48ur47ZryfJrWxXFykGrg_yoW8JF4rKo
        Zrta1Utw18KryUCw15Kr98XFZ8XryDKFZxZrWSyanxWF9Fyryjqry7KryYy34ftwsYq3y8
        u343Z39xW397Jr1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOO7k0a2IF6w4kM7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
        I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY
        1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20x
        vEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04
        v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07brcTQUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
LoongArch architecture that add support for the kexec re-boot mechanis
(CONFIG_KEXEC) on LoongArch platforms.

Supports loading vmlinux (vmlinux.elf) in ELF format and vmlinux.efi in
PE format.

I tested this on  LoongArch 3A5000 machine and works as expected,

 $ sudo kexec -l /boot/vmlinux.efi --reuse-cmdline
 $ sudo kexec -e

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/Kconfig                  |  11 ++
 arch/loongarch/include/asm/kexec.h      |  58 +++++++
 arch/loongarch/kernel/Makefile          |   2 +
 arch/loongarch/kernel/head.S            |   6 +-
 arch/loongarch/kernel/machine_kexec.c   | 209 ++++++++++++++++++++++++
 arch/loongarch/kernel/relocate_kernel.S | 105 ++++++++++++
 6 files changed, 390 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/include/asm/kexec.h
 create mode 100644 arch/loongarch/kernel/machine_kexec.c
 create mode 100644 arch/loongarch/kernel/relocate_kernel.S

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 9b1f2ab878e9..08e063aaf847 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -422,6 +422,17 @@ config ARCH_IOREMAP
 	  protection support. However, you can enable LoongArch DMW-based
 	  ioremap() for better performance.
 
+config KEXEC
+	bool "Kexec system call"
+	select KEXEC_CORE
+	help
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is independent of the system firmware.   And like a reboot
+	  you can start any kernel with it, not just Linux.
+
+	  The name comes from the similarity to the exec system call.
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
new file mode 100644
index 000000000000..e5b022d335c7
--- /dev/null
+++ b/arch/loongarch/include/asm/kexec.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * kexec.h for kexec
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_KEXEC_H
+#define _ASM_KEXEC_H
+
+#include <asm/stacktrace.h>
+#include <asm/page.h>
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+ /* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
+
+/* Reserve a page for the control code buffer */
+#define KEXEC_CONTROL_PAGE_SIZE PAGE_SIZE
+
+/* The native architecture */
+#define KEXEC_ARCH KEXEC_ARCH_LOONGARCH
+
+static inline void crash_setup_regs(struct pt_regs *newregs,
+				    struct pt_regs *oldregs)
+{
+	if (oldregs)
+		memcpy(newregs, oldregs, sizeof(*newregs));
+	else
+		prepare_frametrace(newregs);
+}
+
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	unsigned long efi_boot;
+	unsigned long fdt_addr;
+};
+
+typedef void (*do_kexec_t)(unsigned long efi_boot,
+			   unsigned long fdt_addr,
+			   unsigned long jump_addr,
+			   unsigned long first_ind_entry);
+
+struct kimage;
+extern const unsigned char relocate_new_kernel[];
+extern const size_t relocate_new_kernel_size;
+extern void kexec_reboot(void);
+
+#ifdef CONFIG_SMP
+extern atomic_t kexec_ready_to_reboot;
+extern const unsigned char kexec_smp_wait[];
+#endif
+
+#endif /* !_ASM_KEXEC_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 7225916dd378..17dc8ce6b5ce 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
 obj-$(CONFIG_MODULES)		+= module.o module-sections.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
+obj-$(CONFIG_KEXEC)             += machine_kexec.o relocate_kernel.o
+
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index eb3f641d5915..c0d61b29fcaa 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -20,7 +20,11 @@
 
 _head:
 	.word	MZ_MAGIC		/* "MZ", MS-DOS header */
-	.org	0x3c			/* 0x04 ~ 0x3b reserved */
+	.org	0x8
+	.dword	kernel_entry		/* Kernel entry point */
+	.dword	_end - _text		/* Effective size of kernel image */
+	.quad	0			/* Image load offset from start of RAM */
+	.org	0x3c			/* 0x20 ~ 0x3b reserved */
 	.long	pe_header - _head	/* Offset to the PE header */
 
 pe_header:
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
new file mode 100644
index 000000000000..a2f3c3e65130
--- /dev/null
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * machine_kexec.c for kexec
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+#include <linux/compiler.h>
+#include <linux/cpu.h>
+#include <linux/kexec.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/libfdt.h>
+#include <linux/of_fdt.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cacheflush.h>
+#include <asm/page.h>
+
+/* 0x100000 ~ 0x200000 is safe */
+#define KEXEC_CTRL_CODE	TO_CACHE(0x100000UL)
+#define KEXEC_BLOB_ADDR	TO_CACHE(0x108000UL)
+
+static unsigned long reboot_code_buffer;
+
+#ifdef CONFIG_SMP
+static void (*relocated_kexec_smp_wait)(void *);
+atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
+#endif
+
+static unsigned long efi_boot;
+static unsigned long fdt_addr;
+static unsigned long jump_addr;
+static unsigned long first_ind_entry;
+
+static void kexec_image_info(const struct kimage *kimage)
+{
+	unsigned long i;
+
+	pr_debug("kexec kimage info:\n");
+	pr_debug("\ttype:        %d\n", kimage->type);
+	pr_debug("\tstart:       %lx\n", kimage->start);
+	pr_debug("\thead:        %lx\n", kimage->head);
+	pr_debug("\tnr_segments: %lu\n", kimage->nr_segments);
+
+	for (i = 0; i < kimage->nr_segments; i++) {
+		pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
+			kimage->segment[i].mem,
+			kimage->segment[i].mem + kimage->segment[i].memsz);
+		pr_debug("\t\t0x%lx bytes, %lu pages\n",
+			(unsigned long)kimage->segment[i].memsz,
+			(unsigned long)kimage->segment[i].memsz /  PAGE_SIZE);
+	}
+}
+
+int machine_kexec_prepare(struct kimage *kimage)
+{
+	int i;
+	void *dtb = (void *)KEXEC_BLOB_ADDR;
+
+	kexec_image_info(kimage);
+
+	/* Find the Flattened Device Tree */
+	for (i = 0; i < kimage->nr_segments; i++) {
+		if (!fdt_check_header(kimage->segment[i].buf)) {
+			memcpy(dtb, kimage->segment[i].buf, SZ_64K);
+			kimage->arch.efi_boot = fw_arg0;
+			kimage->arch.fdt_addr = (unsigned long) dtb;
+			break;
+		}
+		continue;
+	}
+
+	/* kexec need a safe page to save reboot_code_buffer */
+	kimage->control_code_page = virt_to_page((void *)KEXEC_CTRL_CODE);
+
+	reboot_code_buffer =
+	  (unsigned long)page_address(kimage->control_code_page);
+	memcpy((void *)reboot_code_buffer, relocate_new_kernel,
+	       relocate_new_kernel_size);
+
+#ifdef CONFIG_SMP
+	/* All secondary cpus now may jump to kexec_smp_wait cycle */
+	relocated_kexec_smp_wait = reboot_code_buffer +
+		(void *)(kexec_smp_wait - relocate_new_kernel);
+#endif
+
+	return 0;
+}
+
+void machine_kexec_cleanup(struct kimage *kimage)
+{
+}
+
+void kexec_reboot(void)
+{
+	do_kexec_t do_kexec = NULL;
+
+	/*
+	 * We know we were online, and there will be no incoming IPIs at
+	 * this point.
+	 */
+	set_cpu_online(smp_processor_id(), true);
+
+	/* Ensure remote CPUs observe that we're online before rebooting. */
+	smp_mb__after_atomic();
+
+	/*
+	 * Make sure we get correct instructions written by the
+	 * machine_kexec_prepare() CPU.
+	 */
+	asm volatile ("\tibar 0\n"::);
+
+#ifdef CONFIG_SMP
+	/* All secondary cpus go to kexec_smp_wait */
+	if (smp_processor_id() > 0) {
+		relocated_kexec_smp_wait(NULL);
+		unreachable();
+	}
+#endif
+
+	do_kexec = (void *)reboot_code_buffer;
+	do_kexec(efi_boot, fdt_addr, jump_addr, first_ind_entry);
+
+	unreachable();
+}
+
+
+#ifdef CONFIG_SMP
+static void kexec_shutdown_secondary(void *)
+{
+	int cpu = smp_processor_id();
+
+	if (!cpu_online(cpu))
+		return;
+
+	/* We won't be sent IPIs any more. */
+	set_cpu_online(cpu, false);
+
+	local_irq_disable();
+	while (!atomic_read(&kexec_ready_to_reboot))
+		cpu_relax();
+
+	kexec_reboot();
+}
+#endif
+
+void machine_crash_shutdown(struct pt_regs *regs)
+{
+}
+
+void machine_shutdown(void)
+{
+	int cpu;
+
+	/* All CPUs go to reboot_code_buffer */
+	for_each_possible_cpu(cpu)
+		if (!cpu_online(cpu))
+			cpu_device_up(get_cpu_device(cpu));
+
+#ifdef CONFIG_SMP
+	smp_call_function(kexec_shutdown_secondary, NULL, 0);
+#endif
+}
+
+void machine_kexec(struct kimage *image)
+{
+	unsigned long entry;
+	unsigned long *ptr;
+	struct kimage_arch *internal = &image->arch;
+
+	efi_boot = internal->efi_boot;
+	fdt_addr = internal->fdt_addr;
+
+	jump_addr = (unsigned long)phys_to_virt(image->start);
+
+	first_ind_entry = (unsigned long)phys_to_virt(image->head & PAGE_MASK);
+
+	/*
+	 * The generic kexec code builds a page list with physical
+	 * addresses. they are directly accessible through XKPRANGE
+	 * hence the phys_to_virt() call.
+	 */
+	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE);
+	     ptr = (entry & IND_INDIRECTION) ?
+	       phys_to_virt(entry & PAGE_MASK) : ptr + 1) {
+		if (*ptr & IND_SOURCE || *ptr & IND_INDIRECTION ||
+		    *ptr & IND_DESTINATION)
+			*ptr = (unsigned long) phys_to_virt(*ptr);
+	}
+
+	/* Mark offline before disabling local irq. */
+	set_cpu_online(smp_processor_id(), false);
+
+	/* we do not want to be bothered. */
+	local_irq_disable();
+
+	pr_notice("Will call new kernel at %lx\n", jump_addr);
+	pr_notice("FDT image at %lx\n", fdt_addr);
+	pr_notice("Bye ...\n");
+
+	/* Make reboot code buffer available to the boot CPU. */
+	flush_cache_all();
+
+#ifdef CONFIG_SMP
+	atomic_set(&kexec_ready_to_reboot, 1);
+#endif
+
+	kexec_reboot();
+}
diff --git a/arch/loongarch/kernel/relocate_kernel.S b/arch/loongarch/kernel/relocate_kernel.S
new file mode 100644
index 000000000000..0ea8b29242e6
--- /dev/null
+++ b/arch/loongarch/kernel/relocate_kernel.S
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * relocate_kernel.S for kexec
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/kexec.h>
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/regdef.h>
+#include <asm/loongarch.h>
+#include <asm/stackframe.h>
+#include <asm/addrspace.h>
+
+SYM_CODE_START(relocate_new_kernel)
+	/*
+	 * a0: Boot flag passed to the new kernel
+	 * a1: Virt address of the FDT image
+	 * a2: Virt address to jump to after relocation
+	 * a3: Pointer to the current indirection page entry
+	 */
+
+	move		s0, a3
+
+process_entry:
+	PTR_L		s1, s0, 0
+	PTR_ADDI	s0, s0, SZREG
+
+	/* destination page */
+	andi		s2, s1, IND_DESTINATION
+	beqz		s2, 1f
+	li.w		t0, ~0x1
+	and		s3, s1, t0	/* store destination addr in s3 */
+	b		process_entry
+
+1:
+	/* indirection page, update s0	*/
+	andi		s2, s1, IND_INDIRECTION
+	beqz		s2, 1f
+	li.w		t0, ~0x2
+	and		s0, s1, t0
+	b		process_entry
+
+1:
+	/* done page */
+	andi		s2, s1, IND_DONE
+	beqz		s2, 1f
+	b		done
+1:
+	/* source page */
+	andi		s2, s1, IND_SOURCE
+	beqz		s2, process_entry
+	li.w		t0, ~0x8
+	and		s1, s1, t0
+	li.w		s5, (1 << _PAGE_SHIFT) / SZREG
+
+copy_word:
+	/* copy page word by word */
+	REG_L		s4, s1, 0
+	REG_S		s4, s3, 0
+	PTR_ADDI	s3, s3, SZREG
+	PTR_ADDI	s1, s1, SZREG
+	LONG_ADDI	s5, s5, -1
+	beqz		s5, process_entry
+	b		copy_word
+	b		process_entry
+
+done:
+	ibar		0
+	dbar		0
+
+	/*
+	 * Jump to the new kernel,
+	 * make sure the values of a0, a1 and a2 are not changed.
+	 */
+	jr		a2
+SYM_CODE_END(relocate_new_kernel)
+
+#ifdef CONFIG_SMP
+/*
+ * Other CPUs should wait until code is relocated and
+ * then start at entry (?) point.
+ */
+SYM_CODE_START(kexec_smp_wait)
+1:	li.w		t0, 0x100			/* wait for init loop */
+2:	addi.w		t0, t0, -1			/* limit mailbox access */
+	bnez		t0, 2b
+	li.w		t1, LOONGARCH_IOCSR_MBUF0
+	iocsrrd.w	s0, t1				/* check PC as an indicator */
+	beqz		s0, 1b
+	iocsrrd.d	s0, t1				/* get PC via mailbox */
+
+	li.d		t0, CACHE_BASE
+	or		s0, s0, t0			/* s0 = TO_CACHE(s0) */
+	jr		s0				/* jump to initial PC */
+SYM_CODE_END(kexec_smp_wait)
+#endif
+
+relocate_new_kernel_end:
+
+SYM_DATA_START(relocate_new_kernel_size)
+	PTR		relocate_new_kernel_end - relocate_new_kernel
+SYM_DATA_END(relocate_new_kernel_size)
-- 
2.36.0

