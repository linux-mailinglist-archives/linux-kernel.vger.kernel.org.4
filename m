Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281645E7515
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiIWHpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIWHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:45:01 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57AA73ED5E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:44:56 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+DpYy1jsI4gAA--.57695S3;
        Fri, 23 Sep 2022 15:44:42 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kexec@lists.infradead.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] LoongArch: Add kexec support
Date:   Fri, 23 Sep 2022 15:44:31 +0800
Message-Id: <1663919073-26849-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1663919073-26849-1-git-send-email-tangyouling@loongson.cn>
References: <1663919073-26849-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8CxT+DpYy1jsI4gAA--.57695S3
X-Coremail-Antispam: 1UD129KBjvAXoW3uF48ur47ZryfJrWxXFykGrg_yoW8Gry7Ao
        ZFga1UKw48KrWUGw15Kr9xXFZ8XryDKF9xZry3AanxWr9FyryjqryUKryYy34ftrnYg3yr
        C343Z39rua97Jrn5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOn7k0a2IF6w4kM7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
        I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY
        1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20x
        vEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2
        xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
        W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
        UYeT5PUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to
the LoongArch architecture, so as to add support for the kexec re-boot
mechanism (CONFIG_KEXEC) on LoongArch platforms.

Kexec supports loading vmlinux.elf in ELF format and vmlinux.efi in PE
format.

I tested kexec on LoongArch machines (Loongson-3A5000) and it works as
expected:

 $ sudo kexec -l /boot/vmlinux.efi --reuse-cmdline
 $ sudo kexec -e

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/Kconfig                  |  11 ++
 arch/loongarch/include/asm/kexec.h      |  60 +++++++
 arch/loongarch/kernel/Makefile          |   2 +
 arch/loongarch/kernel/head.S            |   6 +-
 arch/loongarch/kernel/machine_kexec.c   | 221 ++++++++++++++++++++++++
 arch/loongarch/kernel/relocate_kernel.S | 106 ++++++++++++
 6 files changed, 405 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/include/asm/kexec.h
 create mode 100644 arch/loongarch/kernel/machine_kexec.c
 create mode 100644 arch/loongarch/kernel/relocate_kernel.S

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 221a3dbabfed..4352e9b271aa 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -419,6 +419,17 @@ config ARCH_IOREMAP
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
index 000000000000..a4875952f0dd
--- /dev/null
+++ b/arch/loongarch/include/asm/kexec.h
@@ -0,0 +1,60 @@
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
+	unsigned long cmdline_ptr;
+	unsigned long efi_system_table;
+};
+
+typedef void (*do_kexec_t)(unsigned long efi_boot,
+			   unsigned long cmdline_ptr,
+			   unsigned long efi_system_table,
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
index 7225916dd378..17554244db54 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
 obj-$(CONFIG_MODULES)		+= module.o module-sections.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index e2074cd4fff4..4d352230fbc3 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -20,7 +20,11 @@
 
 _head:
 	.word	MZ_MAGIC		/* "MZ", MS-DOS header */
-	.org	0x3c			/* 0x04 ~ 0x3b reserved */
+	.org	0x8
+	.dword	kernel_entry		/* Kernel entry point */
+	.dword	_end - _text		/* Kernel image effective size */
+	.quad	0			/* Kernel image load offset from start of RAM */
+	.org	0x3c			/* 0x20 ~ 0x3b reserved */
 	.long	pe_header - _head	/* Offset to the PE header */
 
 pe_header:
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
new file mode 100644
index 000000000000..348d914d6d85
--- /dev/null
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -0,0 +1,221 @@
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
+#define KEXEC_CMDL_ADDR	TO_CACHE(0x108000UL)
+#define KEXEC_STBL_ADDR	TO_CACHE(0x110000UL)
+
+static unsigned long reboot_code_buffer;
+
+#ifdef CONFIG_SMP
+static void (*relocated_kexec_smp_wait)(void *);
+atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
+#endif
+
+static unsigned long efi_boot;
+static unsigned long cmdline_ptr;
+static unsigned long efi_systab;
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
+	void *cmdline_ptr = (void *)KEXEC_CMDL_ADDR;
+	void *systbl_ptr = (void *)KEXEC_STBL_ADDR;
+	char *bootloader = "kexec";
+
+	kexec_image_info(kimage);
+
+	kimage->arch.efi_boot = fw_arg0;
+
+	memcpy(systbl_ptr, (void *)TO_CACHE(fw_arg2), SZ_64K);
+	kimage->arch.efi_system_table = (unsigned long)systbl_ptr;
+
+	/* Find the command line */
+	for (i = 0; i < kimage->nr_segments; i++) {
+		if (!strncmp(bootloader, (char *)kimage->segment[i].buf, strlen(bootloader))) {
+			memcpy(cmdline_ptr, kimage->segment[i].buf, COMMAND_LINE_SIZE);
+			kimage->arch.cmdline_ptr = (unsigned long)cmdline_ptr;
+			break;
+		}
+		continue;
+	}
+
+	if (!kimage->arch.cmdline_ptr) {
+		pr_err("Command line not included in the provided image\n");
+		return -EINVAL;
+	}
+
+	/* kexec need a safe page to save reboot_code_buffer */
+	kimage->control_code_page = virt_to_page((void *)KEXEC_CTRL_CODE);
+
+	reboot_code_buffer = (unsigned long)page_address(kimage->control_code_page);
+	memcpy((void *)reboot_code_buffer, relocate_new_kernel, relocate_new_kernel_size);
+
+#ifdef CONFIG_SMP
+	/* All secondary cpus now may jump to kexec_smp_wait cycle */
+	relocated_kexec_smp_wait = reboot_code_buffer + (void *)(kexec_smp_wait - relocate_new_kernel);
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
+	__asm__ __volatile__ ("\tibar 0\n"::);
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
+	do_kexec(efi_boot, cmdline_ptr, efi_systab, jump_addr, first_ind_entry);
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
+void machine_crash_shutdown(struct pt_regs *regs)
+{
+}
+
+void machine_kexec(struct kimage *image)
+{
+	unsigned long entry;
+	unsigned long *ptr;
+	struct kimage_arch *internal = &image->arch;
+
+	efi_boot = internal->efi_boot;
+	cmdline_ptr = internal->cmdline_ptr;
+	efi_systab = internal->efi_system_table;
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
+	/* We do not want to be bothered. */
+	local_irq_disable();
+
+	pr_notice("We will call new kernel at 0x%lx\n", jump_addr);
+	pr_notice("EFI boot flag 0x%lx, Command line at 0x%lx, EFI system table at 0x%lx\n",
+			efi_boot, cmdline_ptr, efi_systab);
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
index 000000000000..6eaa1eb05d8c
--- /dev/null
+++ b/arch/loongarch/kernel/relocate_kernel.S
@@ -0,0 +1,106 @@
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
+	 * a0: EFI boot flag for the new kernel
+	 * a1: Command line pointer for the new kernel
+	 * a2: EFI system table for the new kernel
+	 * a3: Virtual address to jump to after relocation
+	 * a4: Pointer to the current indirection page entry
+	 */
+	move		s0, a4
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
+
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
+	 * make sure the values of a0, a1, a2 and a3 are not changed.
+	 */
+	jr		a3
+SYM_CODE_END(relocate_new_kernel)
+
+#ifdef CONFIG_SMP
+/*
+ * Other CPUs should wait until code is relocated and
+ * then start at the entry point from LOONGARCH_IOCSR_MBUF0.
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

