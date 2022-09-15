Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1905B92C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIOCyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIOCyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:54:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 330D28D3D6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:54:04 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxrmu6kyJjTa8ZAA--.20455S4;
        Thu, 15 Sep 2022 10:53:48 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>, Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kexec@lists.infradead.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] LoongArch: Add kdump support
Date:   Thu, 15 Sep 2022 10:53:45 +0800
Message-Id: <1663210426-15446-3-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1663210426-15446-1-git-send-email-tangyouling@loongson.cn>
References: <1663210426-15446-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Cxrmu6kyJjTa8ZAA--.20455S4
X-Coremail-Antispam: 1UD129KBjvAXoW3ur4kur15XF1UJr13XF1rtFb_yoW8JFW8Co
        WftF1xtw10gry7trs5CF1jyFW5KryqkFsxA39Ivw43WFnYy34jg348KFWYy347Jws5Wws7
        W343WrWjya97Jr95n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOO7k0a2IF6w4kM7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
        I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY
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
        pf9x07bnjjkUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for kdump, the kernel will reserve a region
for the crash kernel and jump there on panic.

Arch-specific functions are added to allow for implementing a crash
dump file interface, /proc/vmcore, which can be viewed as a ELF file.

A user space tool, like kexec-tools, is responsible for allocating a
separate region for the core's ELF header within crash kdump kernel
memory and filling it in when executing kexec_load().

Then, its location will be advertised to crash dump kernel via a new
device-tree property, "linux,elfcorehdr", and crash dump kernel preserves
the region for later use with fdt_reserve_elfcorehdr() at boot time.

At the same time, it will also limit the crash kdump kernel to the
crashkernel area via a new device-tree property, "linux, usable-memory-range",
so as not to destroy the original kernel dump data.

On crash dump kernel, /proc/vmcore will access the primary kernel's memory
with copy_oldmem_page().

I tested this on  LoongArch 3A5000 machine and works as expected (Suggest
crashkernel parameter is "crashkernel=512M@2560M"), you may test it by
triggering a crash through /proc/sysrq_trigger:

 $ sudo kexec -p /boot/vmlinux-kdump --reuse-cmdline --append="nr_cpus=1"
 # echo c > /proc/sysrq_trigger

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/Kconfig                  | 22 ++++++
 arch/loongarch/Makefile                 |  4 +
 arch/loongarch/kernel/Makefile          |  1 +
 arch/loongarch/kernel/crash_dump.c      | 19 +++++
 arch/loongarch/kernel/machine_kexec.c   | 98 +++++++++++++++++++++++--
 arch/loongarch/kernel/mem.c             |  6 ++
 arch/loongarch/kernel/relocate_kernel.S |  6 ++
 arch/loongarch/kernel/setup.c           | 49 +++++++++++++
 arch/loongarch/kernel/traps.c           |  4 +
 9 files changed, 203 insertions(+), 6 deletions(-)
 create mode 100644 arch/loongarch/kernel/crash_dump.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 08e063aaf847..4eeeebf888c1 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -433,6 +433,28 @@ config KEXEC
 
 	  The name comes from the similarity to the exec system call.
 
+config CRASH_DUMP
+	bool "Build kdump crash kernel"
+	help
+	  Generate crash dump after being started by kexec. This should
+	  be normally only set in special crash dump kernels which are
+	  loaded in the main kernel with kexec-tools into a specially
+	  reserved region and then later executed after a crash by
+	  kdump/kexec.
+
+	  For more details see Documentation/admin-guide/kdump/kdump.rst
+
+config PHYSICAL_START
+	hex "Physical address where the kernel is loaded"
+	default "0x90000000a0000000" if 64BIT
+	depends on CRASH_DUMP
+	help
+	  This gives the XKPRANGE address where the kernel is loaded.
+	  If you plan to use kernel for capturing the crash dump change
+	  this value to start of the reserved region (the "X" value as
+	  specified in the "crashkernel=YM@XM" command line boot parameter
+	  passed to the panic-ed kernel).
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 69b39ba3a09d..224274c1644e 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -66,7 +66,11 @@ endif
 cflags-y += -ffreestanding
 cflags-y += $(call cc-option, -mno-check-zero-division)
 
+ifdef CONFIG_PHYSICAL_START
+load-y		= $(CONFIG_PHYSICAL_START)
+else
 load-y		= 0x9000000000200000
+endif
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y)
 
 drivers-$(CONFIG_PCI)		+= arch/loongarch/pci/
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 17dc8ce6b5ce..79eee7db1414 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MODULES)		+= module.o module-sections.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
 obj-$(CONFIG_KEXEC)             += machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_CRASH_DUMP)        += crash_dump.o
 
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
diff --git a/arch/loongarch/kernel/crash_dump.c b/arch/loongarch/kernel/crash_dump.c
new file mode 100644
index 000000000000..13e5d2f7870d
--- /dev/null
+++ b/arch/loongarch/kernel/crash_dump.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/highmem.h>
+#include <linux/crash_dump.h>
+#include <linux/io.h>
+
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			 size_t csize, unsigned long offset)
+{
+	void  *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = kmap_local_pfn(pfn);
+	csize = copy_to_iter(vaddr + offset, csize, iter);
+	kunmap_local(vaddr);
+
+	return csize;
+}
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index a2f3c3e65130..c042d5e3bcfd 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -6,11 +6,16 @@
  */
 #include <linux/compiler.h>
 #include <linux/cpu.h>
-#include <linux/kexec.h>
-#include <linux/mm.h>
+#include <linux/crash_dump.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/kexec.h>
 #include <linux/libfdt.h>
+#include <linux/mm.h>
 #include <linux/of_fdt.h>
+#include <linux/reboot.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cacheflush.h>
@@ -21,6 +26,7 @@
 #define KEXEC_BLOB_ADDR	TO_CACHE(0x108000UL)
 
 static unsigned long reboot_code_buffer;
+static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 
 #ifdef CONFIG_SMP
 static void (*relocated_kexec_smp_wait)(void *);
@@ -70,7 +76,7 @@ int machine_kexec_prepare(struct kimage *kimage)
 		continue;
 	}
 
-	/* kexec need a safe page to save reboot_code_buffer */
+	/* kexec/kdump need a safe page to save reboot_code_buffer */
 	kimage->control_code_page = virt_to_page((void *)KEXEC_CTRL_CODE);
 
 	reboot_code_buffer =
@@ -97,7 +103,8 @@ void kexec_reboot(void)
 
 	/*
 	 * We know we were online, and there will be no incoming IPIs at
-	 * this point.
+	 * this point. Mark online again before rebooting so that the crash
+	 * analysis tool will see us correctly.
 	 */
 	set_cpu_online(smp_processor_id(), true);
 
@@ -142,10 +149,88 @@ static void kexec_shutdown_secondary(void *)
 
 	kexec_reboot();
 }
-#endif
+
+static void crash_shutdown_secondary(void *passed_regs)
+{
+	struct pt_regs *regs = passed_regs;
+	int cpu = smp_processor_id();
+
+	/*
+	 * If we are passed registers, use those.  Otherwise get the
+	 * regs from the last interrupt, which should be correct, as
+	 * we are in an interrupt.  But if the regs are not there,
+	 * pull them from the top of the stack.  They are probably
+	 * wrong, but we need something to keep from crashing again.
+	 */
+	if (!regs)
+		regs = get_irq_regs();
+	if (!regs)
+		regs = task_pt_regs(current);
+
+	/* We won't be sent IPIs any more. */
+	set_cpu_online(cpu, false);
+
+	local_irq_disable();
+	if (!cpumask_test_cpu(cpu, &cpus_in_crash))
+		crash_save_cpu(regs, cpu);
+	cpumask_set_cpu(cpu, &cpus_in_crash);
+
+	while (!atomic_read(&kexec_ready_to_reboot))
+		cpu_relax();
+
+	kexec_reboot();
+}
+
+void crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+	unsigned long timeout;
+	unsigned int ncpus;
+
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we execute this only once.
+	 */
+	if (cpus_stopped)
+		return;
+
+	cpus_stopped = 1;
+
+	 /* Excluding the panic cpu */
+	ncpus = num_online_cpus() - 1;
+
+	smp_call_function(crash_shutdown_secondary, NULL, 0);
+	smp_wmb();
+
+	/*
+	 * The crash CPU sends an IPI and wait for other CPUs to
+	 * respond. Delay of at least 10 seconds.
+	 */
+	pr_emerg("Sending IPI to other cpus...\n");
+	timeout = USEC_PER_SEC * 10;
+	while ((cpumask_weight(&cpus_in_crash) < ncpus) && timeout--) {
+		cpu_relax();
+		udelay(1);
+	}
+}
+#endif /* defined(CONFIG_SMP) */
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
+	int crashing_cpu;
+
+	local_irq_disable();
+
+	crashing_cpu = smp_processor_id();
+	crash_save_cpu(regs, crashing_cpu);
+
+#ifdef CONFIG_SMP
+	/* shutdown non-crashing cpus */
+	crash_smp_send_stop();
+#endif
+	cpumask_set_cpu(crashing_cpu, &cpus_in_crash);
+
+	pr_info("Starting crashdump kernel...\n");
 }
 
 void machine_shutdown(void)
@@ -173,7 +258,8 @@ void machine_kexec(struct kimage *image)
 
 	jump_addr = (unsigned long)phys_to_virt(image->start);
 
-	first_ind_entry = (unsigned long)phys_to_virt(image->head & PAGE_MASK);
+	if (image->type == KEXEC_TYPE_DEFAULT)
+		first_ind_entry = (unsigned long)phys_to_virt(image->head & PAGE_MASK);
 
 	/*
 	 * The generic kexec code builds a page list with physical
diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
index 7423361b0ebc..c6def6ff81c8 100644
--- a/arch/loongarch/kernel/mem.c
+++ b/arch/loongarch/kernel/mem.c
@@ -5,6 +5,7 @@
 #include <linux/efi.h>
 #include <linux/initrd.h>
 #include <linux/memblock.h>
+#include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
 #include <asm/loongson.h>
@@ -61,4 +62,9 @@ void __init memblock_init(void)
 
 	/* Reserve the initrd */
 	reserve_initrd_mem();
+
+	/* Mainly reserved memory for the elf core head */
+	early_init_fdt_scan_reserved_mem();
+	/* Parse linux,usable-memory-range is for crash dump kernel */
+	early_init_dt_check_for_usable_mem_range();
 }
diff --git a/arch/loongarch/kernel/relocate_kernel.S b/arch/loongarch/kernel/relocate_kernel.S
index 0ea8b29242e6..a4176f2ae402 100644
--- a/arch/loongarch/kernel/relocate_kernel.S
+++ b/arch/loongarch/kernel/relocate_kernel.S
@@ -24,6 +24,12 @@ SYM_CODE_START(relocate_new_kernel)
 
 	move		s0, a3
 
+	/*
+	 * In case of a kdump/crash kernel, the indirection page is not
+	 * populated as the kernel is directly copied to a reserved location
+	 */
+	beqz		s0, done
+
 process_entry:
 	PTR_L		s1, s0, 0
 	PTR_ADDI	s0, s0, SZREG
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 058c232c11e8..6974b88446a8 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -19,6 +19,8 @@
 #include <linux/memblock.h>
 #include <linux/initrd.h>
 #include <linux/ioport.h>
+#include <linux/kexec.h>
+#include <linux/crash_dump.h>
 #include <linux/root_dev.h>
 #include <linux/console.h>
 #include <linux/pfn.h>
@@ -185,6 +187,50 @@ static int __init early_parse_mem(char *p)
 }
 early_param("mem", early_parse_mem);
 
+static void __init loongarch_parse_crashkernel(void)
+{
+#ifdef CONFIG_KEXEC
+	unsigned long long start;
+	unsigned long long total_mem;
+	unsigned long long crash_size, crash_base;
+	int ret;
+
+	total_mem = memblock_phys_mem_size();
+	ret = parse_crashkernel(boot_command_line, total_mem,
+				&crash_size, &crash_base);
+	if (ret != 0 || crash_size <= 0)
+		return;
+
+
+	start = memblock_phys_alloc_range(crash_size, 1, crash_base,
+					crash_base + crash_size);
+	if (start != crash_base) {
+		pr_warn("Invalid memory region reserved for crash kernel\n");
+		return;
+	}
+
+	crashk_res.start = crash_base;
+	crashk_res.end	 = crash_base + crash_size - 1;
+#endif
+}
+
+static void __init request_crashkernel(struct resource *res)
+{
+#ifdef CONFIG_KEXEC
+	int ret;
+
+	if (crashk_res.start == crashk_res.end)
+		return;
+
+	ret = request_resource(res, &crashk_res);
+	if (!ret)
+		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
+			(unsigned long)((crashk_res.end -
+					 crashk_res.start + 1) >> 20),
+			(unsigned long)(crashk_res.start  >> 20));
+#endif
+}
+
 void __init platform_init(void)
 {
 	efi_init();
@@ -228,6 +274,8 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	check_kernel_sections_mem();
 
+	loongarch_parse_crashkernel();
+
 	/*
 	 * In order to reduce the possibility of kernel panic when failed to
 	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
@@ -289,6 +337,7 @@ static void __init resource_init(void)
 		request_resource(res, &code_resource);
 		request_resource(res, &data_resource);
 		request_resource(res, &bss_resource);
+		request_crashkernel(res);
 	}
 }
 
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index aa1c95aaf595..0e610872f3f4 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -10,6 +10,7 @@
 #include <linux/entry-common.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/extable.h>
 #include <linux/mm.h>
@@ -246,6 +247,9 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 
 	oops_exit();
 
+	if (regs && kexec_should_crash(current))
+		crash_kexec(regs);
+
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
-- 
2.36.0

