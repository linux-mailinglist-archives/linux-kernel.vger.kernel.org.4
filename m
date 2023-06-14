Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C67161CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjE3N21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjE3N2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD5D9;
        Tue, 30 May 2023 06:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C4663035;
        Tue, 30 May 2023 13:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9316FC4339B;
        Tue, 30 May 2023 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685453267;
        bh=aF5fat/d/WzMbR+ksrmn7kPGBhRvWf8tNNYeJc9ZI2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxAW4VRTTfjKcEhur4AirlloJEstTtlnJl/qxyl7ja0i3B7zAOOGC1KVCNXxFqsAl
         bCRSy+GnKxyuThisJw3FXbRyYPPv4ZyJWI+MKHTSCKr98qXhJyZfpaowhcKIRstekK
         tOS8ZsrSVYXLzdOdSfKHq7QxNsICfNLI7Ac58mp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.31
Date:   Tue, 30 May 2023 14:27:38 +0100
Message-Id: <2023053037-constrain-breeching-da79@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023053037-juice-scrawny-83c3@gregkh>
References: <2023053037-juice-scrawny-83c3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
index dc9d6ed0781d..5d0bfea2c087 100644
--- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -64,7 +64,7 @@ properties:
     description:
       size of memory intended as internal memory for endpoints
       buffers expressed in KB
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint16
 
   cdns,phyrst-a-enable:
     description: Enable resetting of PHY if Rx fail is detected
diff --git a/Makefile b/Makefile
index aeb58c7a4baa..902a6b598c73 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 30
+SUBLEVEL = 31
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/boot/dts/imx6qdl-mba6.dtsi b/arch/arm/boot/dts/imx6qdl-mba6.dtsi
index 78555a618851..7b7e6c2ad190 100644
--- a/arch/arm/boot/dts/imx6qdl-mba6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-mba6.dtsi
@@ -209,6 +209,7 @@ &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio6 7 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
index 87b5e23c766f..d053ef302fb8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
@@ -98,11 +98,17 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		ethphy: ethernet-phy@4 {
+		ethphy: ethernet-phy@4 { /* AR8033 or ADIN1300 */
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <4>;
 			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
+			/*
+			 * Deassert delay:
+			 * ADIN1300 requires 5ms.
+			 * AR8033   requires 1ms.
+			 */
+			reset-deassert-us = <20000>;
 		};
 	};
 };
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 6dbc822332f2..f2fa8a0776e2 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -21,9 +21,10 @@ void copy_highpage(struct page *to, struct page *from)
 
 	copy_page(kto, kfrom);
 
+	if (kasan_hw_tags_enabled())
+		page_kasan_tag_reset(to);
+
 	if (system_supports_mte() && page_mte_tagged(from)) {
-		if (kasan_hw_tags_enabled())
-			page_kasan_tag_reset(to);
 		mte_copy_page_tags(kto, kfrom);
 		set_page_mte_tagged(to);
 	}
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index b9f6908a31bc..ba468b5f3f0b 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -858,11 +858,17 @@ static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *
 }
 
 static inline void __user *
-get_sigframe(struct ksignal *ksig, size_t frame_size)
+get_sigframe(struct ksignal *ksig, struct pt_regs *tregs, size_t frame_size)
 {
 	unsigned long usp = sigsp(rdusp(), ksig);
+	unsigned long gap = 0;
 
-	return (void __user *)((usp - frame_size) & -8UL);
+	if (CPU_IS_020_OR_030 && tregs->format == 0xb) {
+		/* USP is unreliable so use worst-case value */
+		gap = 256;
+	}
+
+	return (void __user *)((usp - gap - frame_size) & -8UL);
 }
 
 static int setup_frame(struct ksignal *ksig, sigset_t *set,
@@ -880,7 +886,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame) + fsize);
+	frame = get_sigframe(ksig, tregs, sizeof(*frame) + fsize);
 
 	if (fsize)
 		err |= copy_to_user (frame + 1, regs + 1, fsize);
@@ -952,7 +958,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame));
+	frame = get_sigframe(ksig, tregs, sizeof(*frame));
 
 	if (fsize)
 		err |= copy_to_user (&frame->uc.uc_extra, regs + 1, fsize);
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index a98940e64243..67c26e81e215 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -129,6 +129,10 @@ config PM
 config STACKTRACE_SUPPORT
 	def_bool y
 
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
 config ISA_DMA_API
 	bool
 
diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 0bdee6724132..c8b6928cee1e 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -48,6 +48,10 @@ void flush_dcache_page(struct page *page);
 
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
+		xa_lock_irqsave(&mapping->i_pages, flags)
+#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
+		xa_unlock_irqrestore(&mapping->i_pages, flags)
 
 #define flush_icache_page(vma,page)	do { 		\
 	flush_kernel_dcache_page_addr(page_address(page)); \
diff --git a/arch/parisc/kernel/alternative.c b/arch/parisc/kernel/alternative.c
index 66f5672c70bd..25c4d6c3375d 100644
--- a/arch/parisc/kernel/alternative.c
+++ b/arch/parisc/kernel/alternative.c
@@ -25,7 +25,7 @@ void __init_or_module apply_alternatives(struct alt_instr *start,
 {
 	struct alt_instr *entry;
 	int index = 0, applied = 0;
-	int num_cpus = num_online_cpus();
+	int num_cpus = num_present_cpus();
 	u16 cond_check;
 
 	cond_check = ALT_COND_ALWAYS |
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 1d3b8bc8a623..ca4a302d4365 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -399,6 +399,7 @@ void flush_dcache_page(struct page *page)
 	unsigned long offset;
 	unsigned long addr, old_addr = 0;
 	unsigned long count = 0;
+	unsigned long flags;
 	pgoff_t pgoff;
 
 	if (mapping && !mapping_mapped(mapping)) {
@@ -420,7 +421,7 @@ void flush_dcache_page(struct page *page)
 	 * to flush one address here for them all to become coherent
 	 * on machines that support equivalent aliasing
 	 */
-	flush_dcache_mmap_lock(mapping);
+	flush_dcache_mmap_lock_irqsave(mapping, flags);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		addr = mpnt->vm_start + offset;
@@ -460,7 +461,7 @@ void flush_dcache_page(struct page *page)
 		}
 		WARN_ON(++count == 4096);
 	}
-	flush_dcache_mmap_unlock(mapping);
+	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index c4f8374c7018..b62d60009fac 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -122,13 +122,18 @@ void machine_power_off(void)
 	/* It seems we have no way to power the system off via
 	 * software. The user has to press the button himself. */
 
-	printk(KERN_EMERG "System shut down completed.\n"
-	       "Please power this system off now.");
+	printk("Power off or press RETURN to reboot.\n");
 
 	/* prevent soft lockup/stalled CPU messages for endless loop. */
 	rcu_sysrq_start();
 	lockup_detector_soft_poweroff();
-	for (;;);
+	while (1) {
+		/* reboot if user presses RETURN key */
+		if (pdc_iodc_getc() == 13) {
+			printk("Rebooting...\n");
+			machine_restart(NULL);
+		}
+	}
 }
 
 void (*pm_power_off)(void);
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index f9696fbf646c..67b51841dc8b 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -291,19 +291,19 @@ static void handle_break(struct pt_regs *regs)
 	}
 
 #ifdef CONFIG_KPROBES
-	if (unlikely(iir == PARISC_KPROBES_BREAK_INSN)) {
+	if (unlikely(iir == PARISC_KPROBES_BREAK_INSN && !user_mode(regs))) {
 		parisc_kprobe_break_handler(regs);
 		return;
 	}
-	if (unlikely(iir == PARISC_KPROBES_BREAK_INSN2)) {
+	if (unlikely(iir == PARISC_KPROBES_BREAK_INSN2 && !user_mode(regs))) {
 		parisc_kprobe_ss_handler(regs);
 		return;
 	}
 #endif
 
 #ifdef CONFIG_KGDB
-	if (unlikely(iir == PARISC_KGDB_COMPILED_BREAK_INSN ||
-		iir == PARISC_KGDB_BREAK_INSN)) {
+	if (unlikely((iir == PARISC_KGDB_COMPILED_BREAK_INSN ||
+		iir == PARISC_KGDB_BREAK_INSN)) && !user_mode(regs)) {
 		kgdb_handle_exception(9, SIGTRAP, 0, regs);
 		return;
 	}
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 8f371f3cbbd2..935081ddf60b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5822,6 +5822,7 @@ static struct intel_uncore_type spr_uncore_mdf = {
 };
 
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
+#define UNCORE_SPR_CHA				0
 #define UNCORE_SPR_IIO				1
 #define UNCORE_SPR_IMC				6
 
@@ -6064,12 +6065,22 @@ static int uncore_type_max_boxes(struct intel_uncore_type **types,
 	return max + 1;
 }
 
+#define SPR_MSR_UNC_CBO_CONFIG		0x2FFE
+
 void spr_uncore_cpu_init(void)
 {
+	struct intel_uncore_type *type;
+	u64 num_cbo;
+
 	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
 						UNCORE_SPR_MSR_EXTRA_UNCORES,
 						spr_msr_uncores);
 
+	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
+	if (type) {
+		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
+		type->num_boxes = num_cbo;
+	}
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }
 
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 5e868b62a7c4..0270925fe013 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -79,7 +79,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
 	c->initial_apicid = edx;
-	smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 #endif
 	return 0;
 }
@@ -109,7 +109,8 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	 */
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	c->initial_apicid = edx;
-	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 0bf6779187dd..f18ca44c904b 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,7 +195,6 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
-	stack = stack ? : get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -214,9 +213,13 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	 * - hardirq stack
 	 * - entry stack
 	 */
-	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+	for (stack = stack ?: get_stack_pointer(task, regs);
+	     stack;
+	     stack = stack_info.next_sp) {
 		const char *stack_name;
 
+		stack = PTR_ALIGN(stack, sizeof(long));
+
 		if (get_stack_info(stack, task, &stack_info, &visit_mask)) {
 			/*
 			 * We weren't on a valid stack.  It's possible that
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 9121bc1b9453..0d5ccea2538f 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 
 #include <asm/set_memory.h>
+#include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/init.h>
 #include <asm/page.h>
@@ -260,6 +261,24 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
+#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
+			      .family  = 6,			\
+			      .model = _model,			\
+			    }
+/*
+ * INVLPG may not properly flush Global entries
+ * on these CPUs when PCIDs are enabled.
+ */
+static const struct x86_cpu_id invlpg_miss_ids[] = {
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	{}
+};
+
 static void setup_pcid(void)
 {
 	if (!IS_ENABLED(CONFIG_X86_64))
@@ -268,6 +287,12 @@ static void setup_pcid(void)
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
+	if (x86_match_cpu(invlpg_miss_ids)) {
+		pr_info("Incomplete global flushes, disabling PCID");
+		setup_clear_cpu_cap(X86_FEATURE_PCID);
+		return;
+	}
+
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
 		/*
 		 * This can't be cr4_set_bits_and_update_boot() -- the
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index b94f727251b6..5a4ecf0c2ac4 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -198,7 +198,7 @@ static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		i++;
 	}
 	kfree(v);
-	return 0;
+	return msi_device_populate_sysfs(&dev->dev);
 
 error:
 	if (ret == -ENOSYS)
@@ -254,7 +254,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		dev_dbg(&dev->dev,
 			"xen: msi --> pirq=%d --> irq=%d\n", pirq, irq);
 	}
-	return 0;
+	return msi_device_populate_sysfs(&dev->dev);
 
 error:
 	dev_err(&dev->dev, "Failed to create MSI%s! ret=%d!\n",
@@ -346,7 +346,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		if (ret < 0)
 			goto out;
 	}
-	ret = 0;
+	ret = msi_device_populate_sysfs(&dev->dev);
 out:
 	return ret;
 }
@@ -393,6 +393,8 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 		for (i = 0; i < msidesc->nvec_used; i++)
 			xen_destroy_irq(msidesc->irq + i);
 	}
+
+	msi_device_destroy_sysfs(&dev->dev);
 }
 
 static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index 876d5df157ed..5c01d7e70d90 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -343,7 +343,19 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 	struct rt_sigframe *frame;
 	int err = 0, sig = ksig->sig;
 	unsigned long sp, ra, tp, ps;
+	unsigned long handler = (unsigned long)ksig->ka.sa.sa_handler;
+	unsigned long handler_fdpic_GOT = 0;
 	unsigned int base;
+	bool fdpic = IS_ENABLED(CONFIG_BINFMT_ELF_FDPIC) &&
+		(current->personality & FDPIC_FUNCPTRS);
+
+	if (fdpic) {
+		unsigned long __user *fdpic_func_desc =
+			(unsigned long __user *)handler;
+		if (__get_user(handler, &fdpic_func_desc[0]) ||
+		    __get_user(handler_fdpic_GOT, &fdpic_func_desc[1]))
+			return -EFAULT;
+	}
 
 	sp = regs->areg[1];
 
@@ -373,20 +385,26 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
-		ra = (unsigned long)ksig->ka.sa.sa_restorer;
+		if (fdpic) {
+			unsigned long __user *fdpic_func_desc =
+				(unsigned long __user *)ksig->ka.sa.sa_restorer;
+
+			err |= __get_user(ra, fdpic_func_desc);
+		} else {
+			ra = (unsigned long)ksig->ka.sa.sa_restorer;
+		}
 	} else {
 
 		/* Create sys_rt_sigreturn syscall in stack frame */
 
 		err |= gen_return_code(frame->retcode);
-
-		if (err) {
-			return -EFAULT;
-		}
 		ra = (unsigned long) frame->retcode;
 	}
 
-	/* 
+	if (err)
+		return -EFAULT;
+
+	/*
 	 * Create signal handler execution context.
 	 * Return context not modified until this point.
 	 */
@@ -394,8 +412,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 	/* Set up registers for signal handler; preserve the threadptr */
 	tp = regs->threadptr;
 	ps = regs->ps;
-	start_thread(regs, (unsigned long) ksig->ka.sa.sa_handler,
-		     (unsigned long) frame);
+	start_thread(regs, handler, (unsigned long)frame);
 
 	/* Set up a stack frame for a call4 if userspace uses windowed ABI */
 	if (ps & PS_WOE_MASK) {
@@ -413,6 +430,8 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 	regs->areg[base + 4] = (unsigned long) &frame->uc;
 	regs->threadptr = tp;
 	regs->ps = ps;
+	if (fdpic)
+		regs->areg[base + 11] = handler_fdpic_GOT;
 
 	pr_debug("SIG rt deliver (%s:%d): signal=%d sp=%p pc=%08lx\n",
 		 current->comm, current->pid, sig, frame, regs->pc);
diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index 2a31b1ab0c9f..17a7ef86fd0d 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -56,6 +56,8 @@ EXPORT_SYMBOL(empty_zero_page);
  */
 extern long long __ashrdi3(long long, int);
 extern long long __ashldi3(long long, int);
+extern long long __bswapdi2(long long);
+extern int __bswapsi2(int);
 extern long long __lshrdi3(long long, int);
 extern int __divsi3(int, int);
 extern int __modsi3(int, int);
@@ -66,6 +68,8 @@ extern unsigned long long __umulsidi3(unsigned int, unsigned int);
 
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__bswapdi2);
+EXPORT_SYMBOL(__bswapsi2);
 EXPORT_SYMBOL(__lshrdi3);
 EXPORT_SYMBOL(__divsi3);
 EXPORT_SYMBOL(__modsi3);
diff --git a/arch/xtensa/lib/Makefile b/arch/xtensa/lib/Makefile
index 7ecef0519a27..c9c2614188f7 100644
--- a/arch/xtensa/lib/Makefile
+++ b/arch/xtensa/lib/Makefile
@@ -4,7 +4,7 @@
 #
 
 lib-y	+= memcopy.o memset.o checksum.o \
-	   ashldi3.o ashrdi3.o lshrdi3.o \
+	   ashldi3.o ashrdi3.o bswapdi2.o bswapsi2.o lshrdi3.o \
 	   divsi3.o udivsi3.o modsi3.o umodsi3.o mulsi3.o umulsidi3.o \
 	   usercopy.o strncpy_user.o strnlen_user.o
 lib-$(CONFIG_PCI) += pci-auto.o
diff --git a/arch/xtensa/lib/bswapdi2.S b/arch/xtensa/lib/bswapdi2.S
new file mode 100644
index 000000000000..d8e52e05eba6
--- /dev/null
+++ b/arch/xtensa/lib/bswapdi2.S
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+ENTRY(__bswapdi2)
+
+	abi_entry_default
+	ssai	8
+	srli	a4, a2, 16
+	src	a4, a4, a2
+	src	a4, a4, a4
+	src	a4, a2, a4
+	srli	a2, a3, 16
+	src	a2, a2, a3
+	src	a2, a2, a2
+	src	a2, a3, a2
+	mov	a3, a4
+	abi_ret_default
+
+ENDPROC(__bswapdi2)
diff --git a/arch/xtensa/lib/bswapsi2.S b/arch/xtensa/lib/bswapsi2.S
new file mode 100644
index 000000000000..9c1de1344f79
--- /dev/null
+++ b/arch/xtensa/lib/bswapsi2.S
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+ENTRY(__bswapsi2)
+
+	abi_entry_default
+	ssai	8
+	srli	a3, a2, 16
+	src	a3, a3, a2
+	src	a3, a3, a3
+	src	a2, a2, a3
+	abi_ret_default
+
+ENDPROC(__bswapsi2)
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 880224ec6abb..e374a8a2da46 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1934,24 +1934,23 @@ static void binder_deferred_fd_close(int fd)
 static void binder_transaction_buffer_release(struct binder_proc *proc,
 					      struct binder_thread *thread,
 					      struct binder_buffer *buffer,
-					      binder_size_t failed_at,
+					      binder_size_t off_end_offset,
 					      bool is_failure)
 {
 	int debug_id = buffer->debug_id;
-	binder_size_t off_start_offset, buffer_offset, off_end_offset;
+	binder_size_t off_start_offset, buffer_offset;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
 		     "%d buffer release %d, size %zd-%zd, failed at %llx\n",
 		     proc->pid, buffer->debug_id,
 		     buffer->data_size, buffer->offsets_size,
-		     (unsigned long long)failed_at);
+		     (unsigned long long)off_end_offset);
 
 	if (buffer->target_node)
 		binder_dec_node(buffer->target_node, 1, 0);
 
 	off_start_offset = ALIGN(buffer->data_size, sizeof(void *));
-	off_end_offset = is_failure && failed_at ? failed_at :
-				off_start_offset + buffer->offsets_size;
+
 	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
 	     buffer_offset += sizeof(binder_size_t)) {
 		struct binder_object_header *hdr;
@@ -2111,6 +2110,21 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 	}
 }
 
+/* Clean up all the objects in the buffer */
+static inline void binder_release_entire_buffer(struct binder_proc *proc,
+						struct binder_thread *thread,
+						struct binder_buffer *buffer,
+						bool is_failure)
+{
+	binder_size_t off_end_offset;
+
+	off_end_offset = ALIGN(buffer->data_size, sizeof(void *));
+	off_end_offset += buffer->offsets_size;
+
+	binder_transaction_buffer_release(proc, thread, buffer,
+					  off_end_offset, is_failure);
+}
+
 static int binder_translate_binder(struct flat_binder_object *fp,
 				   struct binder_transaction *t,
 				   struct binder_thread *thread)
@@ -2801,7 +2815,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 		t_outdated->buffer = NULL;
 		buffer->transaction = NULL;
 		trace_binder_transaction_update_buffer_release(buffer);
-		binder_transaction_buffer_release(proc, NULL, buffer, 0, 0);
+		binder_release_entire_buffer(proc, NULL, buffer, false);
 		binder_alloc_free_buf(&proc->alloc, buffer);
 		kfree(t_outdated);
 		binder_stats_deleted(BINDER_STAT_TRANSACTION);
@@ -3759,7 +3773,7 @@ binder_free_buf(struct binder_proc *proc,
 		binder_node_inner_unlock(buf_node);
 	}
 	trace_binder_transaction_buffer_release(buffer);
-	binder_transaction_buffer_release(proc, thread, buffer, 0, is_failure);
+	binder_release_entire_buffer(proc, thread, buffer, is_failure);
 	binder_alloc_free_buf(&proc->alloc, buffer);
 }
 
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 4ad42b0f75cd..4fb89ef067d5 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -212,8 +212,8 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		mm = alloc->mm;
 
 	if (mm) {
-		mmap_read_lock(mm);
-		vma = vma_lookup(mm, alloc->vma_addr);
+		mmap_write_lock(mm);
+		vma = alloc->vma;
 	}
 
 	if (!vma && need_mm) {
@@ -270,7 +270,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		trace_binder_alloc_page_end(alloc, index);
 	}
 	if (mm) {
-		mmap_read_unlock(mm);
+		mmap_write_unlock(mm);
 		mmput(mm);
 	}
 	return 0;
@@ -303,21 +303,24 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 err_no_vma:
 	if (mm) {
-		mmap_read_unlock(mm);
+		mmap_write_unlock(mm);
 		mmput(mm);
 	}
 	return vma ? -ENOMEM : -ESRCH;
 }
 
+static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
+		struct vm_area_struct *vma)
+{
+	/* pairs with smp_load_acquire in binder_alloc_get_vma() */
+	smp_store_release(&alloc->vma, vma);
+}
+
 static inline struct vm_area_struct *binder_alloc_get_vma(
 		struct binder_alloc *alloc)
 {
-	struct vm_area_struct *vma = NULL;
-
-	if (alloc->vma_addr)
-		vma = vma_lookup(alloc->mm, alloc->vma_addr);
-
-	return vma;
+	/* pairs with smp_store_release in binder_alloc_set_vma() */
+	return smp_load_acquire(&alloc->vma);
 }
 
 static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
@@ -380,15 +383,13 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
-	mmap_read_lock(alloc->mm);
+	/* Check binder_alloc is fully initialized */
 	if (!binder_alloc_get_vma(alloc)) {
-		mmap_read_unlock(alloc->mm);
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
 		return ERR_PTR(-ESRCH);
 	}
-	mmap_read_unlock(alloc->mm);
 
 	data_offsets_size = ALIGN(data_size, sizeof(void *)) +
 		ALIGN(offsets_size, sizeof(void *));
@@ -778,7 +779,9 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
-	alloc->vma_addr = vma->vm_start;
+
+	/* Signal binder_alloc is fully initialized */
+	binder_alloc_set_vma(alloc, vma);
 
 	return 0;
 
@@ -808,8 +811,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
-	BUG_ON(alloc->vma_addr &&
-	       vma_lookup(alloc->mm, alloc->vma_addr));
+	BUG_ON(alloc->vma);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -916,25 +918,17 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-
-	mmap_read_lock(alloc->mm);
-	if (binder_alloc_get_vma(alloc) == NULL) {
-		mmap_read_unlock(alloc->mm);
-		goto uninitialized;
-	}
-
-	mmap_read_unlock(alloc->mm);
-	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-		page = &alloc->pages[i];
-		if (!page->page_ptr)
-			free++;
-		else if (list_empty(&page->lru))
-			active++;
-		else
-			lru++;
+	if (binder_alloc_get_vma(alloc) != NULL) {
+		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+			page = &alloc->pages[i];
+			if (!page->page_ptr)
+				free++;
+			else if (list_empty(&page->lru))
+				active++;
+			else
+				lru++;
+		}
 	}
-
-uninitialized:
 	mutex_unlock(&alloc->mutex);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
@@ -969,7 +963,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
  */
 void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
-	alloc->vma_addr = 0;
+	binder_alloc_set_vma(alloc, NULL);
 }
 
 /**
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 0f811ac4bcff..138d1d5af9ce 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -75,7 +75,7 @@ struct binder_lru_page {
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
  * @mutex:              protects binder_alloc fields
- * @vma_addr:           vm_area_struct->vm_start passed to mmap_handler
+ * @vma:                vm_area_struct passed to mmap_handler
  *                      (invariant after mmap)
  * @mm:                 copy of task->mm (invariant after open)
  * @buffer:             base of per-proc address space mapped via mmap
@@ -99,7 +99,7 @@ struct binder_lru_page {
  */
 struct binder_alloc {
 	struct mutex mutex;
-	unsigned long vma_addr;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	void __user *buffer;
 	struct list_head buffers;
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 43a881073a42..c2b323bc3b3a 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -287,7 +287,7 @@ void binder_selftest_alloc(struct binder_alloc *alloc)
 	if (!binder_selftest_run)
 		return;
 	mutex_lock(&binder_selftest_lock);
-	if (!binder_selftest_run || !alloc->vma_addr)
+	if (!binder_selftest_run || !alloc->vma)
 		goto done;
 	pr_info("STARTED\n");
 	binder_selftest_alloc_offset(alloc, end_offset, 0);
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 5165f6d3da22..95d847c9de79 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -568,6 +568,10 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
 
+	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
+	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
+		return 0;
+
 	return tpm_get_random(chip, data, max);
 }
 
@@ -601,6 +605,42 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
 	return rc;
 }
 
+/*
+ * tpm_chip_bootstrap() - Boostrap TPM chip after power on
+ * @chip: TPM chip to use.
+ *
+ * Initialize TPM chip after power on. This a one-shot function: subsequent
+ * calls will have no effect.
+ */
+int tpm_chip_bootstrap(struct tpm_chip *chip)
+{
+	int rc;
+
+	if (chip->flags & TPM_CHIP_FLAG_BOOTSTRAPPED)
+		return 0;
+
+	rc = tpm_chip_start(chip);
+	if (rc)
+		return rc;
+
+	rc = tpm_auto_startup(chip);
+	if (rc)
+		goto stop;
+
+	rc = tpm_get_pcr_allocation(chip);
+stop:
+	tpm_chip_stop(chip);
+
+	/*
+	 * Unconditionally set, as driver initialization should cease, when the
+	 * boostrapping process fails.
+	 */
+	chip->flags |= TPM_CHIP_FLAG_BOOTSTRAPPED;
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_bootstrap);
+
 /*
  * tpm_chip_register() - create a character device for the TPM chip
  * @chip: TPM chip to use.
@@ -616,17 +656,7 @@ int tpm_chip_register(struct tpm_chip *chip)
 {
 	int rc;
 
-	rc = tpm_chip_start(chip);
-	if (rc)
-		return rc;
-	rc = tpm_auto_startup(chip);
-	if (rc) {
-		tpm_chip_stop(chip);
-		return rc;
-	}
-
-	rc = tpm_get_pcr_allocation(chip);
-	tpm_chip_stop(chip);
+	rc = tpm_chip_bootstrap(chip);
 	if (rc)
 		return rc;
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7e513b771832..0f941cb32eb1 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -412,6 +412,8 @@ int tpm_pm_suspend(struct device *dev)
 	}
 
 suspended:
+	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
+
 	if (rc)
 		dev_err(dev, "Ignoring error %d while suspending\n", rc);
 	return 0;
@@ -429,6 +431,14 @@ int tpm_pm_resume(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
+	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
+
+	/*
+	 * Guarantee that SUSPENDED is written last, so that hwrng does not
+	 * activate before the chip has been fully resumed.
+	 */
+	wmb();
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 830014a26609..f6c99b3f0045 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -263,6 +263,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 		     delay_msec * 1000);
 };
 
+int tpm_chip_bootstrap(struct tpm_chip *chip);
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 4be19d8f3ca9..0d084d6652c4 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -243,7 +243,7 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
 		irq = tpm_info->irq;
 
 	if (itpm || is_itpm(ACPI_COMPANION(dev)))
-		phy->priv.flags |= TPM_TIS_ITPM_WORKAROUND;
+		set_bit(TPM_TIS_ITPM_WORKAROUND, &phy->priv.flags);
 
 	return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
 				 ACPI_HANDLE(dev));
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index eecfbd7e9786..f02b583005a5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -53,41 +53,63 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 	long rc;
 	u8 status;
 	bool canceled = false;
+	u8 sts_mask = 0;
+	int ret = 0;
 
 	/* check current status */
 	status = chip->ops->status(chip);
 	if ((status & mask) == mask)
 		return 0;
 
-	stop = jiffies + timeout;
+	/* check what status changes can be handled by irqs */
+	if (priv->int_mask & TPM_INTF_STS_VALID_INT)
+		sts_mask |= TPM_STS_VALID;
 
-	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
+	if (priv->int_mask & TPM_INTF_DATA_AVAIL_INT)
+		sts_mask |= TPM_STS_DATA_AVAIL;
+
+	if (priv->int_mask & TPM_INTF_CMD_READY_INT)
+		sts_mask |= TPM_STS_COMMAND_READY;
+
+	sts_mask &= mask;
+
+	stop = jiffies + timeout;
+	/* process status changes with irq support */
+	if (sts_mask) {
+		ret = -ETIME;
 again:
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
 			return -ETIME;
 		rc = wait_event_interruptible_timeout(*queue,
-			wait_for_tpm_stat_cond(chip, mask, check_cancel,
+			wait_for_tpm_stat_cond(chip, sts_mask, check_cancel,
 					       &canceled),
 			timeout);
 		if (rc > 0) {
 			if (canceled)
 				return -ECANCELED;
-			return 0;
+			ret = 0;
 		}
 		if (rc == -ERESTARTSYS && freezing(current)) {
 			clear_thread_flag(TIF_SIGPENDING);
 			goto again;
 		}
-	} else {
-		do {
-			usleep_range(priv->timeout_min,
-				     priv->timeout_max);
-			status = chip->ops->status(chip);
-			if ((status & mask) == mask)
-				return 0;
-		} while (time_before(jiffies, stop));
 	}
+
+	if (ret)
+		return ret;
+
+	mask &= ~sts_mask;
+	if (!mask) /* all done */
+		return 0;
+	/* process status changes without irq support */
+	do {
+		status = chip->ops->status(chip);
+		if ((status & mask) == mask)
+			return 0;
+		usleep_range(priv->timeout_min,
+			     priv->timeout_max);
+	} while (time_before(jiffies, stop));
 	return -ETIME;
 }
 
@@ -376,7 +398,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int rc, status, burstcnt;
 	size_t count = 0;
-	bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
+	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
 
 	status = tpm_tis_status(chip);
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
@@ -509,7 +531,8 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	int rc, irq;
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
-	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
+	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) ||
+	     test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
 		return tpm_tis_send_main(chip, buf, len);
 
 	/* Verify receipt of the expected IRQ */
@@ -519,11 +542,11 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	rc = tpm_tis_send_main(chip, buf, len);
 	priv->irq = irq;
 	chip->flags |= TPM_CHIP_FLAG_IRQ;
-	if (!priv->irq_tested)
+	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
 		tpm_msleep(1);
-	if (!priv->irq_tested)
+	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
 		disable_interrupts(chip);
-	priv->irq_tested = true;
+	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
 	return rc;
 }
 
@@ -666,7 +689,7 @@ static int probe_itpm(struct tpm_chip *chip)
 	size_t len = sizeof(cmd_getticks);
 	u16 vendor;
 
-	if (priv->flags & TPM_TIS_ITPM_WORKAROUND)
+	if (test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags))
 		return 0;
 
 	rc = tpm_tis_read16(priv, TPM_DID_VID(0), &vendor);
@@ -686,13 +709,13 @@ static int probe_itpm(struct tpm_chip *chip)
 
 	tpm_tis_ready(chip);
 
-	priv->flags |= TPM_TIS_ITPM_WORKAROUND;
+	set_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
 
 	rc = tpm_tis_send_data(chip, cmd_getticks, len);
 	if (rc == 0)
 		dev_info(&chip->dev, "Detected an iTPM.\n");
 	else {
-		priv->flags &= ~TPM_TIS_ITPM_WORKAROUND;
+		clear_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
 		rc = -EFAULT;
 	}
 
@@ -736,7 +759,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 	if (interrupt == 0)
 		return IRQ_NONE;
 
-	priv->irq_tested = true;
+	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
 	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
 		wake_up_interruptible(&priv->read_queue);
 	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
@@ -819,7 +842,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	if (rc < 0)
 		goto restore_irqs;
 
-	priv->irq_tested = false;
+	clear_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
 
 	/* Generate an interrupt by having the core call through to
 	 * tpm_tis_send
@@ -1031,8 +1054,40 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (rc < 0)
 		goto out_err;
 
-	intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
-		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
+	/* Figure out the capabilities */
+	rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
+	if (rc < 0)
+		goto out_err;
+
+	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
+		intfcaps);
+	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
+		dev_dbg(dev, "\tBurst Count Static\n");
+	if (intfcaps & TPM_INTF_CMD_READY_INT) {
+		intmask |= TPM_INTF_CMD_READY_INT;
+		dev_dbg(dev, "\tCommand Ready Int Support\n");
+	}
+	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
+		dev_dbg(dev, "\tInterrupt Edge Falling\n");
+	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
+		dev_dbg(dev, "\tInterrupt Edge Rising\n");
+	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
+		dev_dbg(dev, "\tInterrupt Level Low\n");
+	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
+		dev_dbg(dev, "\tInterrupt Level High\n");
+	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT) {
+		intmask |= TPM_INTF_LOCALITY_CHANGE_INT;
+		dev_dbg(dev, "\tLocality Change Int Support\n");
+	}
+	if (intfcaps & TPM_INTF_STS_VALID_INT) {
+		intmask |= TPM_INTF_STS_VALID_INT;
+		dev_dbg(dev, "\tSts Valid Int Support\n");
+	}
+	if (intfcaps & TPM_INTF_DATA_AVAIL_INT) {
+		intmask |= TPM_INTF_DATA_AVAIL_INT;
+		dev_dbg(dev, "\tData Avail Int Support\n");
+	}
+
 	intmask &= ~TPM_GLOBAL_INT_ENABLE;
 
 	rc = tpm_tis_request_locality(chip, 0);
@@ -1066,35 +1121,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		goto out_err;
 	}
 
-	/* Figure out the capabilities */
-	rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
-	if (rc < 0)
-		goto out_err;
-
-	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
-		intfcaps);
-	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
-		dev_dbg(dev, "\tBurst Count Static\n");
-	if (intfcaps & TPM_INTF_CMD_READY_INT)
-		dev_dbg(dev, "\tCommand Ready Int Support\n");
-	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
-		dev_dbg(dev, "\tInterrupt Edge Falling\n");
-	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
-		dev_dbg(dev, "\tInterrupt Edge Rising\n");
-	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
-		dev_dbg(dev, "\tInterrupt Level Low\n");
-	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
-		dev_dbg(dev, "\tInterrupt Level High\n");
-	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
-		dev_dbg(dev, "\tLocality Change Int Support\n");
-	if (intfcaps & TPM_INTF_STS_VALID_INT)
-		dev_dbg(dev, "\tSts Valid Int Support\n");
-	if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
-		dev_dbg(dev, "\tData Avail Int Support\n");
-
 	/* INTERRUPT Setup */
 	init_waitqueue_head(&priv->read_queue);
 	init_waitqueue_head(&priv->int_queue);
+
+	rc = tpm_chip_bootstrap(chip);
+	if (rc)
+		goto out_err;
+
 	if (irq != -1) {
 		/*
 		 * Before doing irq testing issue a command to the TPM in polling mode
@@ -1122,7 +1156,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		else
 			tpm_tis_probe_irq(chip, intmask);
 
-		if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
+		if (chip->flags & TPM_CHIP_FLAG_IRQ) {
+			priv->int_mask = intmask;
+		} else {
 			dev_err(&chip->dev, FW_BUG
 					"TPM interrupt not working, polling instead\n");
 
@@ -1159,31 +1195,20 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
 	u32 intmask;
 	int rc;
 
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, true);
-
-	/* reenable interrupts that device may have lost or
-	 * BIOS/firmware may have disabled
+	/*
+	 * Re-enable interrupts that device may have lost or BIOS/firmware may
+	 * have disabled.
 	 */
 	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), priv->irq);
-	if (rc < 0)
-		goto out;
+	if (rc < 0) {
+		dev_err(&chip->dev, "Setting IRQ failed.\n");
+		return;
+	}
 
-	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
+	intmask = priv->int_mask | TPM_GLOBAL_INT_ENABLE;
+	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
 	if (rc < 0)
-		goto out;
-
-	intmask |= TPM_INTF_CMD_READY_INT
-	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
-	    | TPM_INTF_STS_VALID_INT | TPM_GLOBAL_INT_ENABLE;
-
-	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
-
-out:
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, false);
-
-	return;
+		dev_err(&chip->dev, "Enabling interrupts failed.\n");
 }
 
 int tpm_tis_resume(struct device *dev)
@@ -1191,27 +1216,27 @@ int tpm_tis_resume(struct device *dev)
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 	int ret;
 
-	ret = tpm_tis_request_locality(chip, 0);
-	if (ret < 0)
+	ret = tpm_chip_start(chip);
+	if (ret)
 		return ret;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
 		tpm_tis_reenable_interrupts(chip);
 
-	ret = tpm_pm_resume(dev);
-	if (ret)
-		goto out;
-
 	/*
 	 * TPM 1.2 requires self-test on resume. This function actually returns
 	 * an error code but for unknown reason it isn't handled.
 	 */
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		tpm1_do_selftest(chip);
-out:
-	tpm_tis_relinquish_locality(chip, 0);
 
-	return ret;
+	tpm_chip_stop(chip);
+
+	ret = tpm_pm_resume(dev);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_tis_resume);
 #endif
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 1d51d5168fb6..e978f457fd4d 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -87,6 +87,7 @@ enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
 	TPM_TIS_INVALID_STATUS		= BIT(1),
 	TPM_TIS_DEFAULT_CANCELLATION	= BIT(2),
+	TPM_TIS_IRQ_TESTED		= BIT(3),
 };
 
 struct tpm_tis_data {
@@ -95,7 +96,7 @@ struct tpm_tis_data {
 	unsigned int locality_count;
 	int locality;
 	int irq;
-	bool irq_tested;
+	unsigned int int_mask;
 	unsigned long flags;
 	void __iomem *ilb_base_addr;
 	u16 clkrun_enabled;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a8456d5441fc..003a44132418 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -103,23 +103,57 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
 
-/*
- * Wait up to @media_ready_timeout for the device to report memory
- * active.
- */
-int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec;
+	bool valid = false;
+	int rc, i;
+	u32 temp;
+
+	if (id > CXL_DVSEC_RANGE_MAX)
+		return -EINVAL;
+
+	/* Check MEM INFO VALID bit first, give up after 1s */
+	i = 1;
+	do {
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
+					   &temp);
+		if (rc)
+			return rc;
+
+		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
+		if (valid)
+			break;
+		msleep(1000);
+	} while (i--);
+
+	if (!valid) {
+		dev_err(&pdev->dev,
+			"Timeout awaiting memory range %d valid after 1s.\n",
+			id);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
 	bool active = false;
-	u64 md_status;
 	int rc, i;
+	u32 temp;
 
-	for (i = media_ready_timeout; i; i--) {
-		u32 temp;
+	if (id > CXL_DVSEC_RANGE_MAX)
+		return -EINVAL;
 
+	/* Check MEM ACTIVE bit, up to 60s timeout by default */
+	for (i = media_ready_timeout; i; i--) {
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
+			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
 		if (rc)
 			return rc;
 
@@ -136,6 +170,39 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 		return -ETIMEDOUT;
 	}
 
+	return 0;
+}
+
+/*
+ * Wait up to @media_ready_timeout for the device to report memory
+ * active.
+ */
+int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec;
+	int rc, i, hdm_count;
+	u64 md_status;
+	u16 cap;
+
+	rc = pci_read_config_word(pdev,
+				  d + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	for (i = 0; i < hdm_count; i++) {
+		rc = cxl_dvsec_mem_range_valid(cxlds, i);
+		if (rc)
+			return rc;
+	}
+
+	for (i = 0; i < hdm_count; i++) {
+		rc = cxl_dvsec_mem_range_active(cxlds, i);
+		if (rc)
+			return rc;
+	}
+
 	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
 	if (!CXLMDEV_READY(md_status))
 		return -EIO;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 79e5603dfc82..d6fafa1f92a4 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -31,6 +31,8 @@
 #define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
 #define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
 
+#define CXL_DVSEC_RANGE_MAX		2
+
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
 #define CXL_DVSEC_FUNCTION_MAP					2
 
diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 99d439480612..b9ce784f087d 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -15,6 +15,8 @@
 
 #include "common.h"
 
+static DEFINE_IDA(ffa_bus_id);
+
 static int ffa_device_match(struct device *dev, struct device_driver *drv)
 {
 	const struct ffa_device_id *id_table;
@@ -53,7 +55,8 @@ static void ffa_device_remove(struct device *dev)
 {
 	struct ffa_driver *ffa_drv = to_ffa_driver(dev->driver);
 
-	ffa_drv->remove(to_ffa_dev(dev));
+	if (ffa_drv->remove)
+		ffa_drv->remove(to_ffa_dev(dev));
 }
 
 static int ffa_device_uevent(struct device *dev, struct kobj_uevent_env *env)
@@ -130,6 +133,7 @@ static void ffa_release_device(struct device *dev)
 {
 	struct ffa_device *ffa_dev = to_ffa_dev(dev);
 
+	ida_free(&ffa_bus_id, ffa_dev->id);
 	kfree(ffa_dev);
 }
 
@@ -170,18 +174,24 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
 struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
 				       const struct ffa_ops *ops)
 {
-	int ret;
+	int id, ret;
 	struct device *dev;
 	struct ffa_device *ffa_dev;
 
+	id = ida_alloc_min(&ffa_bus_id, 1, GFP_KERNEL);
+	if (id < 0)
+		return NULL;
+
 	ffa_dev = kzalloc(sizeof(*ffa_dev), GFP_KERNEL);
-	if (!ffa_dev)
+	if (!ffa_dev) {
+		ida_free(&ffa_bus_id, id);
 		return NULL;
+	}
 
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
-	dev_set_name(&ffa_dev->dev, "arm-ffa-%04x", vm_id);
+	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->vm_id = vm_id;
 	ffa_dev->ops = ops;
@@ -217,4 +227,5 @@ void arm_ffa_bus_exit(void)
 {
 	ffa_devices_unregister();
 	bus_unregister(&ffa_bus_type);
+	ida_destroy(&ffa_bus_id);
 }
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index d5e86ef40b89..737f36e7a903 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -501,12 +501,17 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		ep_mem_access->receiver = args->attrs[idx].receiver;
 		ep_mem_access->attrs = args->attrs[idx].attrs;
 		ep_mem_access->composite_off = COMPOSITE_OFFSET(args->nattrs);
+		ep_mem_access->flag = 0;
+		ep_mem_access->reserved = 0;
 	}
+	mem_region->reserved_0 = 0;
+	mem_region->reserved_1 = 0;
 	mem_region->ep_count = args->nattrs;
 
 	composite = buffer + COMPOSITE_OFFSET(args->nattrs);
 	composite->total_pg_cnt = ffa_get_num_pages_sg(args->sg);
 	composite->addr_range_cnt = num_entries;
+	composite->reserved = 0;
 
 	length = COMPOSITE_CONSTITUENTS_OFFSET(args->nattrs, num_entries);
 	frag_len = COMPOSITE_CONSTITUENTS_OFFSET(args->nattrs, 0);
@@ -541,6 +546,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 
 		constituents->address = sg_phys(args->sg);
 		constituents->pg_cnt = args->sg->length / FFA_PAGE_SIZE;
+		constituents->reserved = 0;
 		constituents++;
 		frag_len += sizeof(struct ffa_mem_region_addr_range);
 	} while ((args->sg = sg_next(args->sg)));
diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 523dfd17dd92..72a369cf8207 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -368,7 +368,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 		priv->offset = i;
 		priv->desc = gpiochip_get_desc(gc, i);
 
-		debugfs_create_file(name, 0200, chip->dbg_dir, priv,
+		debugfs_create_file(name, 0600, chip->dbg_dir, priv,
 				    &gpio_mockup_debugfs_ops);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 7e8b7171068d..bebd136ed544 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1328,12 +1328,9 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 	struct amdgpu_mes_ctx_data ctx_data = {0};
 	struct amdgpu_ring *added_rings[AMDGPU_MES_CTX_MAX_RINGS] = { NULL };
 	int gang_ids[3] = {0};
-	int queue_types[][2] = { { AMDGPU_RING_TYPE_GFX,
-				   AMDGPU_MES_CTX_MAX_GFX_RINGS},
-				 { AMDGPU_RING_TYPE_COMPUTE,
-				   AMDGPU_MES_CTX_MAX_COMPUTE_RINGS},
-				 { AMDGPU_RING_TYPE_SDMA,
-				   AMDGPU_MES_CTX_MAX_SDMA_RINGS } };
+	int queue_types[][2] = { { AMDGPU_RING_TYPE_GFX, 1 },
+				 { AMDGPU_RING_TYPE_COMPUTE, 1 },
+				 { AMDGPU_RING_TYPE_SDMA, 1} };
 	int i, r, pasid, k = 0;
 
 	pasid = amdgpu_pasid_alloc(16);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 08766b678436..321a5ffebe88 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -390,6 +390,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.disable_reset = 1;
 	mes_set_hw_res_pkt.disable_mes_log = 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
+	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6299130663a3..5d53e54ebe90 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1634,14 +1634,18 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 
 			switch (link->dc->config.allow_edp_hotplug_detection) {
-			case 1: // only the 1st eDP handles hotplug
+			case HPD_EN_FOR_ALL_EDP:
+				link->irq_source_hpd_rx =
+						dal_irq_get_rx_source(link->hpd_gpio);
+				break;
+			case HPD_EN_FOR_PRIMARY_EDP_ONLY:
 				if (link->link_index == 0)
 					link->irq_source_hpd_rx =
 						dal_irq_get_rx_source(link->hpd_gpio);
 				else
 					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
-			case 2: // only the 2nd eDP handles hotplug
+			case HPD_EN_FOR_SECONDARY_EDP_ONLY:
 				if (link->link_index == 1)
 					link->irq_source_hpd_rx =
 						dal_irq_get_rx_source(link->hpd_gpio);
@@ -1649,6 +1653,7 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
 			default:
+				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index ad9041472cca..6050a3469a57 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -993,4 +993,10 @@ struct display_endpoint_id {
 	enum display_endpoint_type ep_type;
 };
 
+enum dc_hpd_enable_select {
+	HPD_EN_FOR_ALL_EDP = 0,
+	HPD_EN_FOR_PRIMARY_EDP_ONLY,
+	HPD_EN_FOR_SECONDARY_EDP_ONLY,
+};
+
 #endif /* DC_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 7e85cdc5bd34..dc694cb246d9 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -222,7 +222,11 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t apply_grbm_remote_register_dummy_read_wa : 1;
 				uint32_t second_gfx_pipe_enabled : 1;
 				uint32_t enable_level_process_quantum_check : 1;
-				uint32_t reserved	: 25;
+				uint32_t legacy_sch_mode : 1;
+				uint32_t disable_add_queue_wptr_mc_addr : 1;
+				uint32_t enable_mes_event_int_logging : 1;
+				uint32_t enable_reg_active_poll : 1;
+				uint32_t reserved	: 21;
 			};
 			uint32_t	uint32_t_all;
 		};
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2f3e239e623d..7d613118cb71 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -869,13 +869,11 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	}
 	if (ret == -ENOENT) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
-		if (size > 0) {
-			size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf + size);
-		}
+		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf + size);
 	}
 
 	if (size == 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 9dd92bbdcefd..bd61518bb7b1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -125,6 +125,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
+	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
index 4cf214de50c4..c21c3f623033 100644
--- a/drivers/gpu/drm/drm_managed.c
+++ b/drivers/gpu/drm/drm_managed.c
@@ -264,28 +264,10 @@ void drmm_kfree(struct drm_device *dev, void *data)
 }
 EXPORT_SYMBOL(drmm_kfree);
 
-static void drmm_mutex_release(struct drm_device *dev, void *res)
+void __drmm_mutex_release(struct drm_device *dev, void *res)
 {
 	struct mutex *lock = res;
 
 	mutex_destroy(lock);
 }
-
-/**
- * drmm_mutex_init - &drm_device-managed mutex_init()
- * @dev: DRM device
- * @lock: lock to be initialized
- *
- * Returns:
- * 0 on success, or a negative errno code otherwise.
- *
- * This is a &drm_device-managed version of mutex_init(). The initialized
- * lock is automatically destroyed on the final drm_dev_put().
- */
-int drmm_mutex_init(struct drm_device *dev, struct mutex *lock)
-{
-	mutex_init(lock);
-
-	return drmm_add_action_or_reset(dev, drmm_mutex_release, lock);
-}
-EXPORT_SYMBOL(drmm_mutex_init);
+EXPORT_SYMBOL(__drmm_mutex_release);
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index bbab2549243a..ae90b260312a 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -640,6 +640,11 @@ void mgag200_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_
 	if (funcs->pixpllc_atomic_update)
 		funcs->pixpllc_atomic_update(crtc, old_state);
 
+	if (crtc_state->gamma_lut)
+		mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut->data);
+	else
+		mgag200_crtc_set_gamma_linear(mdev, format);
+
 	mgag200_enable_display(mdev);
 
 	if (funcs->enable_vidrst)
diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index da2173435edd..6541c1f6fca6 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -100,6 +100,16 @@ static void radeon_hotplug_work_func(struct work_struct *work)
 
 static void radeon_dp_work_func(struct work_struct *work)
 {
+	struct radeon_device *rdev = container_of(work, struct radeon_device,
+						  dp_work);
+	struct drm_device *dev = rdev->ddev;
+	struct drm_mode_config *mode_config = &dev->mode_config;
+	struct drm_connector *connector;
+
+	mutex_lock(&mode_config->mutex);
+	list_for_each_entry(connector, &mode_config->connector_list, head)
+		radeon_connector_hotplug(connector);
+	mutex_unlock(&mode_config->mutex);
 }
 
 /**
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 867ad8bb9b0c..368f2e5a8627 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -942,7 +942,7 @@ tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
 
 	len = tmc_etr_buf_get_data(etr_buf, offset,
 				   CORESIGHT_BARRIER_PKT_SIZE, &bufp);
-	if (WARN_ON(len < CORESIGHT_BARRIER_PKT_SIZE))
+	if (WARN_ON(len < 0 || len < CORESIGHT_BARRIER_PKT_SIZE))
 		return -EINVAL;
 	coresight_insert_barrier_packet(bufp);
 	return offset + CORESIGHT_BARRIER_PKT_SIZE;
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 1ba0f1555c80..3a33aefec8a4 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -50,7 +50,7 @@ void __iomem *mips_gic_base;
 
 static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
 
-static DEFINE_SPINLOCK(gic_lock);
+static DEFINE_RAW_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
 static unsigned int gic_cpu_pin;
@@ -211,7 +211,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 	irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
 		pol = GIC_POL_FALLING_EDGE;
@@ -251,7 +251,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	else
 		irq_set_chip_handler_name_locked(d, &gic_level_irq_controller,
 						 handle_level_irq, NULL);
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
@@ -269,7 +269,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		return -EINVAL;
 
 	/* Assumption : cpumask refers to a single CPU */
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 
 	/* Re-route this IRQ */
 	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
@@ -280,7 +280,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return IRQ_SET_MASK_OK;
 }
@@ -358,12 +358,12 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = false;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_rmask(BIT(intr));
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
@@ -376,12 +376,12 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = true;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_smask(BIT(intr));
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static void gic_all_vpes_irq_cpu_online(void)
@@ -394,19 +394,21 @@ static void gic_all_vpes_irq_cpu_online(void)
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 
 	for (i = 0; i < ARRAY_SIZE(local_intrs); i++) {
 		unsigned int intr = local_intrs[i];
 		struct gic_all_vpes_chip_data *cd;
 
+		if (!gic_local_irq_is_routable(intr))
+			continue;
 		cd = &gic_all_vpes_chip_data[intr];
 		write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
 		if (cd->mask)
 			write_gic_vl_smask(BIT(intr));
 	}
 
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static struct irq_chip gic_all_vpes_local_irq_controller = {
@@ -436,11 +438,11 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 
 	data = irq_get_irq_data(virq);
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
 	irq_data_update_effective_affinity(data, cpumask_of(cpu));
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
@@ -535,12 +537,12 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	if (!gic_local_irq_is_routable(intr))
 		return -EPERM;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
diff --git a/drivers/media/radio/radio-shark.c b/drivers/media/radio/radio-shark.c
index 8230da828d0e..127a3be0e0f0 100644
--- a/drivers/media/radio/radio-shark.c
+++ b/drivers/media/radio/radio-shark.c
@@ -316,6 +316,16 @@ static int usb_shark_probe(struct usb_interface *intf,
 {
 	struct shark_device *shark;
 	int retval = -ENOMEM;
+	static const u8 ep_addresses[] = {
+		SHARK_IN_EP | USB_DIR_IN,
+		SHARK_OUT_EP | USB_DIR_OUT,
+		0};
+
+	/* Are the expected endpoints present? */
+	if (!usb_check_int_endpoints(intf, ep_addresses)) {
+		dev_err(&intf->dev, "Invalid radioSHARK device\n");
+		return -EINVAL;
+	}
 
 	shark = kzalloc(sizeof(struct shark_device), GFP_KERNEL);
 	if (!shark)
diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index d150f12382c6..f1c5c0a6a335 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -282,6 +282,16 @@ static int usb_shark_probe(struct usb_interface *intf,
 {
 	struct shark_device *shark;
 	int retval = -ENOMEM;
+	static const u8 ep_addresses[] = {
+		SHARK_IN_EP | USB_DIR_IN,
+		SHARK_OUT_EP | USB_DIR_OUT,
+		0};
+
+	/* Are the expected endpoints present? */
+	if (!usb_check_int_endpoints(intf, ep_addresses)) {
+		dev_err(&intf->dev, "Invalid radioSHARK2 device\n");
+		return -EINVAL;
+	}
 
 	shark = kzalloc(sizeof(struct shark_device), GFP_KERNEL);
 	if (!shark)
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index db6d8a099910..498333b769fd 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -266,6 +266,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 		goto out_put;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_mq_free_request(req);
@@ -657,6 +658,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 	idatas[0] = idata;
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
 	blk_execute_rq(req, false);
@@ -728,6 +730,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 	}
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = n;
 	blk_execute_rq(req, false);
@@ -2812,6 +2815,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	if (ret >= 0) {
@@ -2850,6 +2854,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 		goto out_free;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
 	blk_execute_rq(req, false);
 	err = req_to_mmc_queue_req(req)->drv_op_result;
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8c62c3fba75e..b63cf1f9e8fb 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1585,6 +1585,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	/* HS400/HS400ES require 8 bit bus */
+	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+
 	if (mmc_gpio_get_cd(host->mmc) >= 0)
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
@@ -1669,10 +1673,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc_host_ops.execute_tuning = usdhc_execute_tuning;
 	}
 
-	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
-	if (err)
-		goto disable_ahb_clk;
-
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
@@ -1680,15 +1680,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
 		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
 
-	if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
-	    imx_data->socdata->flags & ESDHC_FLAG_HS400)
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 		host->mmc->caps2 |= MMC_CAP2_HS400;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
 		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
 
-	if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
-	    imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
 		host->mmc->caps2 |= MMC_CAP2_HS400_ES;
 		host->mmc_host_ops.hs400_enhanced_strobe =
 					esdhc_hs400_enhanced_strobe;
@@ -1710,6 +1708,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			goto disable_ahb_clk;
 	}
 
+	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
+	if (err)
+		goto disable_ahb_clk;
+
 	sdhci_esdhc_imx_hwinit(host);
 
 	err = sdhci_add_host(host);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 9f44c86a591d..9ed80f710651 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3921,7 +3921,11 @@ static int bond_slave_netdev_event(unsigned long event,
 		unblock_netpoll_tx();
 		break;
 	case NETDEV_FEAT_CHANGE:
-		bond_compute_features(bond);
+		if (!bond->notifier_ctx) {
+			bond->notifier_ctx = true;
+			bond_compute_features(bond);
+			bond->notifier_ctx = false;
+		}
 		break;
 	case NETDEV_RESEND_IGMP:
 		/* Propagate to master device */
@@ -6284,6 +6288,8 @@ static int bond_init(struct net_device *bond_dev)
 	if (!bond->wq)
 		return -ENOMEM;
 
+	bond->notifier_ctx = false;
+
 	spin_lock_init(&bond->stats_lock);
 	netdev_lockdep_set_classes(bond_dev);
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 12175195d396..a8ff6ee6d58e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5044,6 +5044,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.phy_write = mv88e6xxx_g2_smi_phy_write,
 	.port_set_link = mv88e6xxx_port_set_link,
 	.port_sync_link = mv88e6xxx_port_sync_link,
+	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -5088,6 +5089,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.phy_write = mv88e6xxx_g2_smi_phy_write,
 	.port_set_link = mv88e6xxx_port_set_link,
 	.port_sync_link = mv88e6xxx_port_sync_link,
+	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5c4195c635b0..f79cf716c541 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -133,6 +133,15 @@ int mv88e6390_port_set_rgmii_delay(struct mv88e6xxx_chip *chip, int port,
 	return mv88e6xxx_port_set_rgmii_delay(chip, port, mode);
 }
 
+int mv88e6320_port_set_rgmii_delay(struct mv88e6xxx_chip *chip, int port,
+				   phy_interface_t mode)
+{
+	if (port != 2 && port != 5 && port != 6)
+		return -EOPNOTSUPP;
+
+	return mv88e6xxx_port_set_rgmii_delay(chip, port, mode);
+}
+
 int mv88e6xxx_port_set_link(struct mv88e6xxx_chip *chip, int port, int link)
 {
 	u16 reg;
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index a91e22d9a6cb..d19b6303b91f 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -332,6 +332,8 @@ int mv88e6xxx_port_wait_bit(struct mv88e6xxx_chip *chip, int port, int reg,
 
 int mv88e6185_port_set_pause(struct mv88e6xxx_chip *chip, int port,
 			     int pause);
+int mv88e6320_port_set_rgmii_delay(struct mv88e6xxx_chip *chip, int port,
+				   phy_interface_t mode);
 int mv88e6352_port_set_rgmii_delay(struct mv88e6xxx_chip *chip, int port,
 				   phy_interface_t mode);
 int mv88e6390_port_set_rgmii_delay(struct mv88e6xxx_chip *chip, int port,
diff --git a/drivers/net/ethernet/3com/3c589_cs.c b/drivers/net/ethernet/3com/3c589_cs.c
index 82f94b1635bf..5267e9dcd87e 100644
--- a/drivers/net/ethernet/3com/3c589_cs.c
+++ b/drivers/net/ethernet/3com/3c589_cs.c
@@ -195,6 +195,7 @@ static int tc589_probe(struct pcmcia_device *link)
 {
 	struct el3_private *lp;
 	struct net_device *dev;
+	int ret;
 
 	dev_dbg(&link->dev, "3c589_attach()\n");
 
@@ -218,7 +219,15 @@ static int tc589_probe(struct pcmcia_device *link)
 
 	dev->ethtool_ops = &netdev_ethtool_ops;
 
-	return tc589_config(link);
+	ret = tc589_config(link);
+	if (ret)
+		goto err_free_netdev;
+
+	return 0;
+
+err_free_netdev:
+	free_netdev(dev);
+	return ret;
 }
 
 static void tc589_detach(struct pcmcia_device *link)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 7045fedfd73a..7af223b0a37f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -652,9 +652,7 @@ static void otx2_sqe_add_ext(struct otx2_nic *pfvf, struct otx2_snd_queue *sq,
 				htons(ext->lso_sb - skb_network_offset(skb));
 		} else if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6) {
 			ext->lso_format = pfvf->hw.lso_tsov6_idx;
-
-			ipv6_hdr(skb)->payload_len =
-				htons(ext->lso_sb - skb_network_offset(skb));
+			ipv6_hdr(skb)->payload_len = htons(tcp_hdrlen(skb));
 		} else if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
 			__be16 l3_proto = vlan_get_protocol(skb);
 			struct udphdr *udph = udp_hdr(skb);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 723891eb86ee..b3253e263ebc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1894,9 +1894,10 @@ static void mlx5_cmd_err_trace(struct mlx5_core_dev *dev, u16 opcode, u16 op_mod
 static void cmd_status_log(struct mlx5_core_dev *dev, u16 opcode, u8 status,
 			   u32 syndrome, int err)
 {
+	const char *namep = mlx5_command_str(opcode);
 	struct mlx5_cmd_stats *stats;
 
-	if (!err)
+	if (!err || !(strcmp(namep, "unknown command opcode")))
 		return;
 
 	stats = &dev->cmd.stats[opcode];
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index ae75e230170b..efd02ce4425d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -175,6 +175,8 @@ static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq, int budget)
 	/* ensure cq space is freed before enabling more cqes */
 	wmb();
 
+	mlx5e_txqsq_wake(&ptpsq->txqsq);
+
 	return work_done == budget;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index 2aaf8ab857b8..72b61f66df37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -1338,11 +1338,13 @@ static void mlx5e_invalidate_encap(struct mlx5e_priv *priv,
 	struct mlx5e_tc_flow *flow;
 
 	list_for_each_entry(flow, encap_flows, tmp_list) {
-		struct mlx5_flow_attr *attr = flow->attr;
 		struct mlx5_esw_flow_attr *esw_attr;
+		struct mlx5_flow_attr *attr;
 
 		if (!mlx5e_is_offloaded_flow(flow))
 			continue;
+
+		attr = mlx5e_tc_get_encap_attr(flow);
 		esw_attr = attr->esw_attr;
 
 		if (flow_flag_test(flow, SLOW))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 1b3a65325ece..344245c01150 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -177,6 +177,8 @@ static inline u16 mlx5e_txqsq_get_next_pi(struct mlx5e_txqsq *sq, u16 size)
 	return pi;
 }
 
+void mlx5e_txqsq_wake(struct mlx5e_txqsq *sq);
+
 static inline u16 mlx5e_shampo_get_cqe_header_index(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	return be16_to_cpu(cqe->shampo.header_entry_index) & (rq->mpwqe.shampo->hd_per_wq - 1);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 73af062a8783..7883b625634f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1578,11 +1578,9 @@ bool mlx5e_tc_is_vf_tunnel(struct net_device *out_dev, struct net_device *route_
 int mlx5e_tc_query_route_vport(struct net_device *out_dev, struct net_device *route_dev, u16 *vport)
 {
 	struct mlx5e_priv *out_priv, *route_priv;
-	struct mlx5_devcom *devcom = NULL;
 	struct mlx5_core_dev *route_mdev;
 	struct mlx5_eswitch *esw;
 	u16 vhca_id;
-	int err;
 
 	out_priv = netdev_priv(out_dev);
 	esw = out_priv->mdev->priv.eswitch;
@@ -1591,6 +1589,9 @@ int mlx5e_tc_query_route_vport(struct net_device *out_dev, struct net_device *ro
 
 	vhca_id = MLX5_CAP_GEN(route_mdev, vhca_id);
 	if (mlx5_lag_is_active(out_priv->mdev)) {
+		struct mlx5_devcom *devcom;
+		int err;
+
 		/* In lag case we may get devices from different eswitch instances.
 		 * If we failed to get vport num, it means, mostly, that we on the wrong
 		 * eswitch.
@@ -1599,16 +1600,16 @@ int mlx5e_tc_query_route_vport(struct net_device *out_dev, struct net_device *ro
 		if (err != -ENOENT)
 			return err;
 
+		rcu_read_lock();
 		devcom = out_priv->mdev->priv.devcom;
-		esw = mlx5_devcom_get_peer_data(devcom, MLX5_DEVCOM_ESW_OFFLOADS);
-		if (!esw)
-			return -ENODEV;
+		esw = mlx5_devcom_get_peer_data_rcu(devcom, MLX5_DEVCOM_ESW_OFFLOADS);
+		err = esw ? mlx5_eswitch_vhca_id_to_vport(esw, vhca_id, vport) : -ENODEV;
+		rcu_read_unlock();
+
+		return err;
 	}
 
-	err = mlx5_eswitch_vhca_id_to_vport(esw, vhca_id, vport);
-	if (devcom)
-		mlx5_devcom_release_peer_data(devcom, MLX5_DEVCOM_ESW_OFFLOADS);
-	return err;
+	return mlx5_eswitch_vhca_id_to_vport(esw, vhca_id, vport);
 }
 
 int mlx5e_tc_add_flow_mod_hdr(struct mlx5e_priv *priv,
@@ -5142,6 +5143,8 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 		goto err_register_fib_notifier;
 	}
 
+	mlx5_esw_offloads_devcom_init(esw);
+
 	return 0;
 
 err_register_fib_notifier:
@@ -5168,7 +5171,7 @@ void mlx5e_tc_esw_cleanup(struct mlx5_rep_uplink_priv *uplink_priv)
 	priv = netdev_priv(rpriv->netdev);
 	esw = priv->mdev->priv.eswitch;
 
-	mlx5e_tc_clean_fdb_peer_flows(esw);
+	mlx5_esw_offloads_devcom_cleanup(esw);
 
 	mlx5e_tc_tun_cleanup(uplink_priv->encap);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index f7897ddb29c5..a6d7e2cfcd0e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -777,6 +777,17 @@ static void mlx5e_tx_wi_consume_fifo_skbs(struct mlx5e_txqsq *sq, struct mlx5e_t
 	}
 }
 
+void mlx5e_txqsq_wake(struct mlx5e_txqsq *sq)
+{
+	if (netif_tx_queue_stopped(sq->txq) &&
+	    mlx5e_wqc_has_room_for(&sq->wq, sq->cc, sq->pc, sq->stop_room) &&
+	    mlx5e_ptpsq_fifo_has_room(sq) &&
+	    !test_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state)) {
+		netif_tx_wake_queue(sq->txq);
+		sq->stats->wake++;
+	}
+}
+
 bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 {
 	struct mlx5e_sq_stats *stats;
@@ -876,13 +887,7 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 
 	netdev_tx_completed_queue(sq->txq, npkts, nbytes);
 
-	if (netif_tx_queue_stopped(sq->txq) &&
-	    mlx5e_wqc_has_room_for(&sq->wq, sq->cc, sq->pc, sq->stop_room) &&
-	    mlx5e_ptpsq_fifo_has_room(sq) &&
-	    !test_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state)) {
-		netif_tx_wake_queue(sq->txq);
-		stats->wake++;
-	}
+	mlx5e_txqsq_wake(sq);
 
 	return (i == MLX5E_TX_CQ_POLL_BUDGET);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 9a458a5d9853..44547b22a536 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -161,20 +161,22 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
+	/* budget=0 means we may be in IRQ context, do as little as possible */
+	if (unlikely(!budget))
+		goto out;
+
 	busy |= mlx5e_poll_xdpsq_cq(&c->xdpsq.cq);
 
 	if (c->xdp)
 		busy |= mlx5e_poll_xdpsq_cq(&c->rq_xdpsq.cq);
 
-	if (likely(budget)) { /* budget=0 means: don't poll rx rings */
-		if (xsk_open)
-			work_done = mlx5e_poll_rx_cq(&xskrq->cq, budget);
+	if (xsk_open)
+		work_done = mlx5e_poll_rx_cq(&xskrq->cq, budget);
 
-		if (likely(budget - work_done))
-			work_done += mlx5e_poll_rx_cq(&rq->cq, budget - work_done);
+	if (likely(budget - work_done))
+		work_done += mlx5e_poll_rx_cq(&rq->cq, budget - work_done);
 
-		busy |= work_done == budget;
-	}
+	busy |= work_done == budget;
 
 	mlx5e_poll_ico_cq(&c->icosq.cq);
 	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 6e6e0864063f..821c78bab373 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -368,6 +368,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs);
 void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf);
 void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw);
 void mlx5_eswitch_disable(struct mlx5_eswitch *esw);
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw);
+void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw);
 int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
 			       u16 vport, const u8 *mac);
 int mlx5_eswitch_set_vport_state(struct mlx5_eswitch *esw,
@@ -757,6 +759,8 @@ static inline void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw) {}
 static inline int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs) { return 0; }
 static inline void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf) {}
 static inline void mlx5_eswitch_disable(struct mlx5_eswitch *esw) {}
+static inline void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw) {}
+static inline void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw) {}
 static inline bool mlx5_eswitch_is_funcs_handler(struct mlx5_core_dev *dev) { return false; }
 static inline
 int mlx5_eswitch_set_vport_state(struct mlx5_eswitch *esw, u16 vport, int link_state) { return 0; }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 519526a4810e..5235b5a7b963 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2864,7 +2864,7 @@ static int mlx5_esw_offloads_devcom_event(int event,
 	return err;
 }
 
-static void esw_offloads_devcom_init(struct mlx5_eswitch *esw)
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw)
 {
 	struct mlx5_devcom *devcom = esw->dev->priv.devcom;
 
@@ -2887,7 +2887,7 @@ static void esw_offloads_devcom_init(struct mlx5_eswitch *esw)
 			       ESW_OFFLOADS_DEVCOM_PAIR, esw);
 }
 
-static void esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
+void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
 {
 	struct mlx5_devcom *devcom = esw->dev->priv.devcom;
 
@@ -3357,8 +3357,6 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	if (err)
 		goto err_vports;
 
-	esw_offloads_devcom_init(esw);
-
 	return 0;
 
 err_vports:
@@ -3399,7 +3397,6 @@ static int esw_offloads_stop(struct mlx5_eswitch *esw,
 
 void esw_offloads_disable(struct mlx5_eswitch *esw)
 {
-	esw_offloads_devcom_cleanup(esw);
 	mlx5_eswitch_disable_pf_vf_vports(esw);
 	esw_offloads_unload_rep(esw, MLX5_VPORT_UPLINK);
 	esw_set_passing_vport_metadata(esw, false);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index adefde3ea941..b7d779d08d83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -3,6 +3,7 @@
 
 #include <linux/mlx5/vport.h>
 #include "lib/devcom.h"
+#include "mlx5_core.h"
 
 static LIST_HEAD(devcom_list);
 
@@ -13,7 +14,7 @@ static LIST_HEAD(devcom_list);
 
 struct mlx5_devcom_component {
 	struct {
-		void *data;
+		void __rcu *data;
 	} device[MLX5_DEVCOM_PORTS_SUPPORTED];
 
 	mlx5_devcom_event_handler_t handler;
@@ -77,6 +78,7 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 	if (MLX5_CAP_GEN(dev, num_lag_ports) != MLX5_DEVCOM_PORTS_SUPPORTED)
 		return NULL;
 
+	mlx5_dev_list_lock();
 	sguid0 = mlx5_query_nic_system_image_guid(dev);
 	list_for_each_entry(iter, &devcom_list, list) {
 		struct mlx5_core_dev *tmp_dev = NULL;
@@ -102,8 +104,10 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 
 	if (!priv) {
 		priv = mlx5_devcom_list_alloc();
-		if (!priv)
-			return ERR_PTR(-ENOMEM);
+		if (!priv) {
+			devcom = ERR_PTR(-ENOMEM);
+			goto out;
+		}
 
 		idx = 0;
 		new_priv = true;
@@ -112,13 +116,16 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 	priv->devs[idx] = dev;
 	devcom = mlx5_devcom_alloc(priv, idx);
 	if (!devcom) {
-		kfree(priv);
-		return ERR_PTR(-ENOMEM);
+		if (new_priv)
+			kfree(priv);
+		devcom = ERR_PTR(-ENOMEM);
+		goto out;
 	}
 
 	if (new_priv)
 		list_add(&priv->list, &devcom_list);
-
+out:
+	mlx5_dev_list_unlock();
 	return devcom;
 }
 
@@ -131,6 +138,7 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom *devcom)
 	if (IS_ERR_OR_NULL(devcom))
 		return;
 
+	mlx5_dev_list_lock();
 	priv = devcom->priv;
 	priv->devs[devcom->idx] = NULL;
 
@@ -141,10 +149,12 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom *devcom)
 			break;
 
 	if (i != MLX5_DEVCOM_PORTS_SUPPORTED)
-		return;
+		goto out;
 
 	list_del(&priv->list);
 	kfree(priv);
+out:
+	mlx5_dev_list_unlock();
 }
 
 void mlx5_devcom_register_component(struct mlx5_devcom *devcom,
@@ -162,7 +172,7 @@ void mlx5_devcom_register_component(struct mlx5_devcom *devcom,
 	comp = &devcom->priv->components[id];
 	down_write(&comp->sem);
 	comp->handler = handler;
-	comp->device[devcom->idx].data = data;
+	rcu_assign_pointer(comp->device[devcom->idx].data, data);
 	up_write(&comp->sem);
 }
 
@@ -176,8 +186,9 @@ void mlx5_devcom_unregister_component(struct mlx5_devcom *devcom,
 
 	comp = &devcom->priv->components[id];
 	down_write(&comp->sem);
-	comp->device[devcom->idx].data = NULL;
+	RCU_INIT_POINTER(comp->device[devcom->idx].data, NULL);
 	up_write(&comp->sem);
+	synchronize_rcu();
 }
 
 int mlx5_devcom_send_event(struct mlx5_devcom *devcom,
@@ -193,12 +204,15 @@ int mlx5_devcom_send_event(struct mlx5_devcom *devcom,
 
 	comp = &devcom->priv->components[id];
 	down_write(&comp->sem);
-	for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++)
-		if (i != devcom->idx && comp->device[i].data) {
-			err = comp->handler(event, comp->device[i].data,
-					    event_data);
+	for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++) {
+		void *data = rcu_dereference_protected(comp->device[i].data,
+						       lockdep_is_held(&comp->sem));
+
+		if (i != devcom->idx && data) {
+			err = comp->handler(event, data, event_data);
 			break;
 		}
+	}
 
 	up_write(&comp->sem);
 	return err;
@@ -213,7 +227,7 @@ void mlx5_devcom_set_paired(struct mlx5_devcom *devcom,
 	comp = &devcom->priv->components[id];
 	WARN_ON(!rwsem_is_locked(&comp->sem));
 
-	comp->paired = paired;
+	WRITE_ONCE(comp->paired, paired);
 }
 
 bool mlx5_devcom_is_paired(struct mlx5_devcom *devcom,
@@ -222,7 +236,7 @@ bool mlx5_devcom_is_paired(struct mlx5_devcom *devcom,
 	if (IS_ERR_OR_NULL(devcom))
 		return false;
 
-	return devcom->priv->components[id].paired;
+	return READ_ONCE(devcom->priv->components[id].paired);
 }
 
 void *mlx5_devcom_get_peer_data(struct mlx5_devcom *devcom,
@@ -236,7 +250,7 @@ void *mlx5_devcom_get_peer_data(struct mlx5_devcom *devcom,
 
 	comp = &devcom->priv->components[id];
 	down_read(&comp->sem);
-	if (!comp->paired) {
+	if (!READ_ONCE(comp->paired)) {
 		up_read(&comp->sem);
 		return NULL;
 	}
@@ -245,7 +259,29 @@ void *mlx5_devcom_get_peer_data(struct mlx5_devcom *devcom,
 		if (i != devcom->idx)
 			break;
 
-	return comp->device[i].data;
+	return rcu_dereference_protected(comp->device[i].data, lockdep_is_held(&comp->sem));
+}
+
+void *mlx5_devcom_get_peer_data_rcu(struct mlx5_devcom *devcom, enum mlx5_devcom_components id)
+{
+	struct mlx5_devcom_component *comp;
+	int i;
+
+	if (IS_ERR_OR_NULL(devcom))
+		return NULL;
+
+	for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++)
+		if (i != devcom->idx)
+			break;
+
+	comp = &devcom->priv->components[id];
+	/* This can change concurrently, however 'data' pointer will remain
+	 * valid for the duration of RCU read section.
+	 */
+	if (!READ_ONCE(comp->paired))
+		return NULL;
+
+	return rcu_dereference(comp->device[i].data);
 }
 
 void mlx5_devcom_release_peer_data(struct mlx5_devcom *devcom,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index 94313c18bb64..9a496f4722da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -41,6 +41,7 @@ bool mlx5_devcom_is_paired(struct mlx5_devcom *devcom,
 
 void *mlx5_devcom_get_peer_data(struct mlx5_devcom *devcom,
 				enum mlx5_devcom_components id);
+void *mlx5_devcom_get_peer_data_rcu(struct mlx5_devcom *devcom, enum mlx5_devcom_components id);
 void mlx5_devcom_release_peer_data(struct mlx5_devcom *devcom,
 				   enum mlx5_devcom_components id);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index cc8057c4f908..91724c5450a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1024,7 +1024,7 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 
 	dev->dm = mlx5_dm_create(dev);
 	if (IS_ERR(dev->dm))
-		mlx5_core_warn(dev, "Failed to init device memory%d\n", err);
+		mlx5_core_warn(dev, "Failed to init device memory %ld\n", PTR_ERR(dev->dm));
 
 	dev->tracer = mlx5_fw_tracer_create(dev);
 	dev->hv_vhca = mlx5_hv_vhca_create(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
index 16d65fe4f654..84364691a379 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
@@ -117,6 +117,8 @@ int mlx5dr_cmd_query_device(struct mlx5_core_dev *mdev,
 	caps->gvmi		= MLX5_CAP_GEN(mdev, vhca_id);
 	caps->flex_protocols	= MLX5_CAP_GEN(mdev, flex_parser_protocols);
 	caps->sw_format_ver	= MLX5_CAP_GEN(mdev, steering_format_version);
+	caps->roce_caps.fl_rc_qp_when_roce_disabled =
+		MLX5_CAP_GEN(mdev, fl_rc_qp_when_roce_disabled);
 
 	if (MLX5_CAP_GEN(mdev, roce)) {
 		err = dr_cmd_query_nic_vport_roce_en(mdev, 0, &roce_en);
@@ -124,7 +126,7 @@ int mlx5dr_cmd_query_device(struct mlx5_core_dev *mdev,
 			return err;
 
 		caps->roce_caps.roce_en = roce_en;
-		caps->roce_caps.fl_rc_qp_when_roce_disabled =
+		caps->roce_caps.fl_rc_qp_when_roce_disabled |=
 			MLX5_CAP_ROCE(mdev, fl_rc_qp_when_roce_disabled);
 		caps->roce_caps.fl_rc_qp_when_roce_enabled =
 			MLX5_CAP_ROCE(mdev, fl_rc_qp_when_roce_enabled);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
index 09ebd3088857..7815a629d7e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
@@ -15,7 +15,8 @@ static u32 dr_ste_crc32_calc(const void *input_data, size_t length)
 {
 	u32 crc = crc32(0, input_data, length);
 
-	return (__force u32)htonl(crc);
+	return (__force u32)((crc >> 24) & 0xff) | ((crc << 8) & 0xff0000) |
+			    ((crc >> 8) & 0xff00) | ((crc << 24) & 0xff000000);
 }
 
 bool mlx5dr_ste_supp_ttl_cs_recalc(struct mlx5dr_cmd_caps *caps)
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 569108c49cbc..9ce46588aaf0 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -987,6 +987,16 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
 
 	reset_control_reset(switch_reset);
 
+	/* Don't reinitialize the switch core, if it is already initialized. In
+	 * case it is initialized twice, some pointers inside the queue system
+	 * in HW will get corrupted and then after a while the queue system gets
+	 * full and no traffic is passing through the switch. The issue is seen
+	 * when loading and unloading the driver and sending traffic through the
+	 * switch.
+	 */
+	if (lan_rd(lan966x, SYS_RESET_CFG) & SYS_RESET_CFG_CORE_ENA)
+		return 0;
+
 	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan966x, SYS_RESET_CFG);
 	lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan966x, SYS_RAM_INIT);
 	ret = readx_poll_timeout(lan966x_ram_init, lan966x,
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index daa028729d44..486cbc8ab224 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -6138,6 +6138,7 @@ static int nv_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 	return 0;
 
 out_error:
+	nv_mgmt_release_sema(dev);
 	if (phystate_orig)
 		writel(phystate|NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
 out_freering:
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 8a13b1ad9a33..f778e4f8b508 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2664,6 +2664,7 @@ static struct phy_driver vsc85xx_driver[] = {
 module_phy_driver(vsc85xx_driver);
 
 static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
+	{ PHY_ID_VSC8502, 0xfffffff0, },
 	{ PHY_ID_VSC8504, 0xfffffff0, },
 	{ PHY_ID_VSC8514, 0xfffffff0, },
 	{ PHY_ID_VSC8530, 0xfffffff0, },
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 62ade69295a9..b524bd374d68 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1629,6 +1629,7 @@ static int team_init(struct net_device *dev)
 
 	team->dev = dev;
 	team_set_no_mode(team);
+	team->notifier_ctx = false;
 
 	team->pcpu_stats = netdev_alloc_pcpu_stats(struct team_pcpu_stats);
 	if (!team->pcpu_stats)
@@ -3022,7 +3023,11 @@ static int team_device_event(struct notifier_block *unused,
 		team_del_slave(port->team->dev, dev);
 		break;
 	case NETDEV_FEAT_CHANGE:
-		team_compute_features(port->team);
+		if (!port->team->notifier_ctx) {
+			port->team->notifier_ctx = true;
+			team_compute_features(port->team);
+			port->team->notifier_ctx = false;
+		}
 		break;
 	case NETDEV_PRECHANGEMTU:
 		/* Forbid to change mtu of underlaying device */
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 0897fdb6254b..789e3647f979 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -180,9 +180,12 @@ static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 	else
 		min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth32);
 
-	max = min_t(u32, CDC_NCM_NTB_MAX_SIZE_TX, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize));
-	if (max == 0)
+	if (le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize) == 0)
 		max = CDC_NCM_NTB_MAX_SIZE_TX; /* dwNtbOutMaxSize not set */
+	else
+		max = clamp_t(u32, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize),
+			      USB_CDC_NCM_NTB_MIN_OUT_SIZE,
+			      CDC_NCM_NTB_MAX_SIZE_TX);
 
 	/* some devices set dwNtbOutMaxSize too low for the above default */
 	min = min(min, max);
@@ -1243,6 +1246,9 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 			 * further.
 			 */
 			if (skb_out == NULL) {
+				/* If even the smallest allocation fails, abort. */
+				if (ctx->tx_curr_size == USB_CDC_NCM_NTB_MIN_OUT_SIZE)
+					goto alloc_failed;
 				ctx->tx_low_mem_max_cnt = min(ctx->tx_low_mem_max_cnt + 1,
 							      (unsigned)CDC_NCM_LOW_MEM_MAX_CNT);
 				ctx->tx_low_mem_val = ctx->tx_low_mem_max_cnt;
@@ -1261,13 +1267,8 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 			skb_out = alloc_skb(ctx->tx_curr_size, GFP_ATOMIC);
 
 			/* No allocation possible so we will abort */
-			if (skb_out == NULL) {
-				if (skb != NULL) {
-					dev_kfree_skb_any(skb);
-					dev->net->stats.tx_dropped++;
-				}
-				goto exit_no_skb;
-			}
+			if (!skb_out)
+				goto alloc_failed;
 			ctx->tx_low_mem_val--;
 		}
 		if (ctx->is_ndp16) {
@@ -1460,6 +1461,11 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 
 	return skb_out;
 
+alloc_failed:
+	if (skb) {
+		dev_kfree_skb_any(skb);
+		dev->net->stats.tx_dropped++;
+	}
 exit_no_skb:
 	/* Start timer, if there is a remaining non-empty skb */
 	if (ctx->tx_curr_skb != NULL && n > 0)
diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index c2c9b0d3244c..be967d797c28 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1348,9 +1348,8 @@ static int mlxbf_pmc_map_counters(struct device *dev)
 
 	for (i = 0; i < pmc->total_blocks; ++i) {
 		if (strstr(pmc->block_name[i], "tile")) {
-			ret = sscanf(pmc->block_name[i], "tile%d", &tile_num);
-			if (ret < 0)
-				return ret;
+			if (sscanf(pmc->block_name[i], "tile%d", &tile_num) != 1)
+				return -EINVAL;
 
 			if (tile_num >= pmc->tile_count)
 				continue;
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 94af7d398a1b..3bacee2b8d52 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -552,7 +552,7 @@ static int __init hp_wmi_enable_hotkeys(void)
 
 static int hp_wmi_set_block(void *data, bool blocked)
 {
-	enum hp_wmi_radio r = (enum hp_wmi_radio) data;
+	enum hp_wmi_radio r = (long)data;
 	int query = BIT(r + 8) | ((!blocked) << r);
 	int ret;
 
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index d056617ddc85..3e52b4eb1450 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -154,7 +154,7 @@ static int scan_chunks_sanity_check(struct device *dev)
 			continue;
 		reinit_completion(&ifs_done);
 		local_work.dev = dev;
-		INIT_WORK(&local_work.w, copy_hashes_authenticate_chunks);
+		INIT_WORK_ONSTACK(&local_work.w, copy_hashes_authenticate_chunks);
 		schedule_work_on(cpu, &local_work.w);
 		wait_for_completion(&ifs_done);
 		if (ifsd->loading_error)
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index fd102678c75f..f6b32d31c511 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -294,14 +294,13 @@ struct isst_if_pkg_info {
 static struct isst_if_cpu_info *isst_cpu_info;
 static struct isst_if_pkg_info *isst_pkg_info;
 
-#define ISST_MAX_PCI_DOMAINS	8
-
 static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
 {
 	struct pci_dev *matched_pci_dev = NULL;
 	struct pci_dev *pci_dev = NULL;
+	struct pci_dev *_pci_dev = NULL;
 	int no_matches = 0, pkg_id;
-	int i, bus_number;
+	int bus_number;
 
 	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER || cpu < 0 ||
 	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
@@ -313,12 +312,11 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 	if (bus_number < 0)
 		return NULL;
 
-	for (i = 0; i < ISST_MAX_PCI_DOMAINS; ++i) {
-		struct pci_dev *_pci_dev;
+	for_each_pci_dev(_pci_dev) {
 		int node;
 
-		_pci_dev = pci_get_domain_bus_and_slot(i, bus_number, PCI_DEVFN(dev, fn));
-		if (!_pci_dev)
+		if (_pci_dev->bus->number != bus_number ||
+		    _pci_dev->devfn != PCI_DEVFN(dev, fn))
 			continue;
 
 		++no_matches;
diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 05f413178462..3be6f3b10ea4 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -507,7 +507,7 @@ static void fuel_gauge_external_power_changed(struct power_supply *psy)
 	mutex_lock(&info->lock);
 	info->valid = 0; /* Force updating of the cached registers */
 	mutex_unlock(&info->lock);
-	power_supply_changed(info->bat);
+	power_supply_changed(psy);
 }
 
 static struct power_supply_desc fuel_gauge_desc = {
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index d7400b56820d..0d3db227b63a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1262,6 +1262,7 @@ static void bq24190_input_current_limit_work(struct work_struct *work)
 	bq24190_charger_set_property(bdi->charger,
 				     POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 				     &val);
+	power_supply_changed(bdi->charger);
 }
 
 /* Sync the input-current-limit with our parent supply (if we have one) */
diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 0e15302b8df2..ee6e28f1d52d 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -650,7 +650,7 @@ static void bq25890_charger_external_power_changed(struct power_supply *psy)
 	if (bq->chip_version != BQ25892)
 		return;
 
-	ret = power_supply_get_property_from_supplier(bq->charger,
+	ret = power_supply_get_property_from_supplier(psy,
 						      POWER_SUPPLY_PROP_USB_TYPE,
 						      &val);
 	if (ret)
@@ -675,6 +675,7 @@ static void bq25890_charger_external_power_changed(struct power_supply *psy)
 	}
 
 	bq25890_field_write(bq, F_IINLIM, input_current_limit);
+	power_supply_changed(psy);
 }
 
 static int bq25890_get_chip_state(struct bq25890_device *bq,
@@ -973,6 +974,8 @@ static void bq25890_pump_express_work(struct work_struct *data)
 	dev_info(bq->dev, "Hi-voltage charging requested, input voltage is %d mV\n",
 		 voltage);
 
+	power_supply_changed(bq->charger);
+
 	return;
 error_print:
 	bq25890_field_write(bq, F_PUMPX_EN, 0);
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 8bf048fbd36a..17a09d103a59 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1761,60 +1761,6 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
-void bq27xxx_battery_update(struct bq27xxx_device_info *di)
-{
-	struct bq27xxx_reg_cache cache = {0, };
-	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
-
-	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
-	if ((cache.flags & 0xff) == 0xff)
-		cache.flags = -1; /* read error */
-	if (cache.flags >= 0) {
-		cache.temperature = bq27xxx_battery_read_temperature(di);
-		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
-			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
-		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
-			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
-		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
-			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
-
-		cache.charge_full = bq27xxx_battery_read_fcc(di);
-		cache.capacity = bq27xxx_battery_read_soc(di);
-		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
-			cache.energy = bq27xxx_battery_read_energy(di);
-		di->cache.flags = cache.flags;
-		cache.health = bq27xxx_battery_read_health(di);
-		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
-			cache.cycle_count = bq27xxx_battery_read_cyct(di);
-
-		/* We only have to read charge design full once */
-		if (di->charge_design_full <= 0)
-			di->charge_design_full = bq27xxx_battery_read_dcap(di);
-	}
-
-	if ((di->cache.capacity != cache.capacity) ||
-	    (di->cache.flags != cache.flags))
-		power_supply_changed(di->bat);
-
-	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
-		di->cache = cache;
-
-	di->last_update = jiffies;
-}
-EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
-
-static void bq27xxx_battery_poll(struct work_struct *work)
-{
-	struct bq27xxx_device_info *di =
-			container_of(work, struct bq27xxx_device_info,
-				     work.work);
-
-	bq27xxx_battery_update(di);
-
-	if (poll_interval > 0)
-		schedule_delayed_work(&di->work, poll_interval * HZ);
-}
-
 static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int flags)
 {
 	if (di->opts & BQ27XXX_O_ZERO)
@@ -1833,7 +1779,8 @@ static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int flags)
 static int bq27xxx_battery_current_and_status(
 	struct bq27xxx_device_info *di,
 	union power_supply_propval *val_curr,
-	union power_supply_propval *val_status)
+	union power_supply_propval *val_status,
+	struct bq27xxx_reg_cache *cache)
 {
 	bool single_flags = (di->opts & BQ27XXX_O_ZERO);
 	int curr;
@@ -1845,10 +1792,14 @@ static int bq27xxx_battery_current_and_status(
 		return curr;
 	}
 
-	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
-	if (flags < 0) {
-		dev_err(di->dev, "error reading flags\n");
-		return flags;
+	if (cache) {
+		flags = cache->flags;
+	} else {
+		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
+		if (flags < 0) {
+			dev_err(di->dev, "error reading flags\n");
+			return flags;
+		}
 	}
 
 	if (di->opts & BQ27XXX_O_ZERO) {
@@ -1883,6 +1834,78 @@ static int bq27xxx_battery_current_and_status(
 	return 0;
 }
 
+static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
+{
+	union power_supply_propval status = di->last_status;
+	struct bq27xxx_reg_cache cache = {0, };
+	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
+
+	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
+	if ((cache.flags & 0xff) == 0xff)
+		cache.flags = -1; /* read error */
+	if (cache.flags >= 0) {
+		cache.temperature = bq27xxx_battery_read_temperature(di);
+		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
+			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
+		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
+			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
+		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
+			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
+
+		cache.charge_full = bq27xxx_battery_read_fcc(di);
+		cache.capacity = bq27xxx_battery_read_soc(di);
+		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
+			cache.energy = bq27xxx_battery_read_energy(di);
+		di->cache.flags = cache.flags;
+		cache.health = bq27xxx_battery_read_health(di);
+		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
+			cache.cycle_count = bq27xxx_battery_read_cyct(di);
+
+		/*
+		 * On gauges with signed current reporting the current must be
+		 * checked to detect charging <-> discharging status changes.
+		 */
+		if (!(di->opts & BQ27XXX_O_ZERO))
+			bq27xxx_battery_current_and_status(di, NULL, &status, &cache);
+
+		/* We only have to read charge design full once */
+		if (di->charge_design_full <= 0)
+			di->charge_design_full = bq27xxx_battery_read_dcap(di);
+	}
+
+	if ((di->cache.capacity != cache.capacity) ||
+	    (di->cache.flags != cache.flags) ||
+	    (di->last_status.intval != status.intval)) {
+		di->last_status.intval = status.intval;
+		power_supply_changed(di->bat);
+	}
+
+	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
+		di->cache = cache;
+
+	di->last_update = jiffies;
+
+	if (!di->removed && poll_interval > 0)
+		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
+}
+
+void bq27xxx_battery_update(struct bq27xxx_device_info *di)
+{
+	mutex_lock(&di->lock);
+	bq27xxx_battery_update_unlocked(di);
+	mutex_unlock(&di->lock);
+}
+EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
+
+static void bq27xxx_battery_poll(struct work_struct *work)
+{
+	struct bq27xxx_device_info *di =
+			container_of(work, struct bq27xxx_device_info,
+				     work.work);
+
+	bq27xxx_battery_update(di);
+}
+
 /*
  * Get the average power in µW
  * Return < 0 if something fails.
@@ -1985,10 +2008,8 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
 	mutex_lock(&di->lock);
-	if (time_is_before_jiffies(di->last_update + 5 * HZ)) {
-		cancel_delayed_work_sync(&di->work);
-		bq27xxx_battery_poll(&di->work.work);
-	}
+	if (time_is_before_jiffies(di->last_update + 5 * HZ))
+		bq27xxx_battery_update_unlocked(di);
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
@@ -1996,7 +2017,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret = bq27xxx_battery_current_and_status(di, NULL, val);
+		ret = bq27xxx_battery_current_and_status(di, NULL, val, NULL);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = bq27xxx_battery_voltage(di, val);
@@ -2005,7 +2026,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		val->intval = di->cache.flags < 0 ? 0 : 1;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = bq27xxx_battery_current_and_status(di, val, NULL);
+		ret = bq27xxx_battery_current_and_status(di, val, NULL, NULL);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = bq27xxx_simple_value(di->cache.capacity, val);
@@ -2078,8 +2099,8 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
-	cancel_delayed_work_sync(&di->work);
-	schedule_delayed_work(&di->work, 0);
+	/* After charger plug in/out wait 0.5s for things to stabilize */
+	mod_delayed_work(system_wq, &di->work, HZ / 2);
 }
 
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
@@ -2127,22 +2148,18 @@ EXPORT_SYMBOL_GPL(bq27xxx_battery_setup);
 
 void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 {
-	/*
-	 * power_supply_unregister call bq27xxx_battery_get_property which
-	 * call bq27xxx_battery_poll.
-	 * Make sure that bq27xxx_battery_poll will not call
-	 * schedule_delayed_work again after unregister (which cause OOPS).
-	 */
-	poll_interval = 0;
-
-	cancel_delayed_work_sync(&di->work);
-
-	power_supply_unregister(di->bat);
-
 	mutex_lock(&bq27xxx_list_lock);
 	list_del(&di->list);
 	mutex_unlock(&bq27xxx_list_lock);
 
+	/* Set removed to avoid bq27xxx_battery_update() re-queuing the work */
+	mutex_lock(&di->lock);
+	di->removed = true;
+	mutex_unlock(&di->lock);
+
+	cancel_delayed_work_sync(&di->work);
+
+	power_supply_unregister(di->bat);
 	mutex_destroy(&di->lock);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 94b00bb89c17..0713a52a2510 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -179,7 +179,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, di);
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = request_threaded_irq(client->irq,
 				NULL, bq27xxx_battery_irq_handler_thread,
 				IRQF_ONESHOT,
 				di->name, di);
@@ -209,6 +209,7 @@ static void bq27xxx_battery_i2c_remove(struct i2c_client *client)
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
+	free_irq(client->irq, di);
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);
diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index 3abaa72e0668..f1248faf5905 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -799,7 +799,9 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	mci->vinovp = 6500000;
 	mutex_init(&mci->chgdet_lock);
 	platform_set_drvdata(pdev, mci);
-	devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
 
 	ret = device_property_read_u32(&pdev->dev, "richtek,vinovp-microvolt", &mci->vinovp);
 	if (ret)
diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index d69880cc3593..b7a2778f878d 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -34,8 +34,9 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 		led_trigger_event(psy->charging_full_trig, LED_FULL);
 		led_trigger_event(psy->charging_trig, LED_OFF);
 		led_trigger_event(psy->full_trig, LED_FULL);
-		led_trigger_event(psy->charging_blink_full_solid_trig,
-			LED_FULL);
+		/* Going from blink to LED on requires a LED_OFF event to stop blink */
+		led_trigger_event(psy->charging_blink_full_solid_trig, LED_OFF);
+		led_trigger_event(psy->charging_blink_full_solid_trig, LED_FULL);
 		break;
 	case POWER_SUPPLY_STATUS_CHARGING:
 		led_trigger_event(psy->charging_full_trig, LED_FULL);
diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index b08f7d0c4181..bc927c0ddd34 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -24,7 +24,7 @@
 #define SBS_CHARGER_REG_STATUS			0x13
 #define SBS_CHARGER_REG_ALARM_WARNING		0x16
 
-#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(1)
+#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(0)
 #define SBS_CHARGER_STATUS_RES_COLD		BIT(9)
 #define SBS_CHARGER_STATUS_RES_HOT		BIT(10)
 #define SBS_CHARGER_STATUS_BATTERY_PRESENT	BIT(14)
diff --git a/drivers/regulator/mt6359-regulator.c b/drivers/regulator/mt6359-regulator.c
index de3b0462832c..f94f87c5407a 100644
--- a/drivers/regulator/mt6359-regulator.c
+++ b/drivers/regulator/mt6359-regulator.c
@@ -951,9 +951,12 @@ static int mt6359_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config = {};
 	struct regulator_dev *rdev;
 	struct mt6359_regulator_info *mt6359_info;
-	int i, hw_ver;
+	int i, hw_ver, ret;
+
+	ret = regmap_read(mt6397->regmap, MT6359P_HWCID, &hw_ver);
+	if (ret)
+		return ret;
 
-	regmap_read(mt6397->regmap, MT6359P_HWCID, &hw_ver);
 	if (hw_ver >= MT6359P_CHIP_VER)
 		mt6359_info = mt6359p_regulators;
 	else
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 14b7d3376516..0fcda40cefa6 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -264,7 +264,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
@@ -502,7 +502,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..e6e0428f8e7b 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -984,8 +984,10 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
 
 	invoke_fn(OPTEE_SMC_GET_ASYNC_NOTIF_VALUE, 0, 0, 0, 0, 0, 0, 0, &res);
 
-	if (res.a0)
+	if (res.a0) {
+		*value_valid = false;
 		return 0;
+	}
 	*value_valid = (res.a2 & OPTEE_SMC_ASYNC_NOTIF_VALUE_VALID);
 	*value_pending = (res.a2 & OPTEE_SMC_ASYNC_NOTIF_VALUE_PENDING);
 	return res.a1;
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index a415206cab04..3500e3c94c4b 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -206,6 +206,82 @@ int usb_find_common_endpoints_reverse(struct usb_host_interface *alt,
 }
 EXPORT_SYMBOL_GPL(usb_find_common_endpoints_reverse);
 
+/**
+ * usb_find_endpoint() - Given an endpoint address, search for the endpoint's
+ * usb_host_endpoint structure in an interface's current altsetting.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addr: the endpoint address (number and direction) to find
+ *
+ * Search the altsetting's list of endpoints for one with the specified address.
+ *
+ * Return: Pointer to the usb_host_endpoint if found, %NULL otherwise.
+ */
+static const struct usb_host_endpoint *usb_find_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr)
+{
+	int n;
+	const struct usb_host_endpoint *ep;
+
+	n = intf->cur_altsetting->desc.bNumEndpoints;
+	ep = intf->cur_altsetting->endpoint;
+	for (; n > 0; (--n, ++ep)) {
+		if (ep->desc.bEndpointAddress == ep_addr)
+			return ep;
+	}
+	return NULL;
+}
+
+/**
+ * usb_check_bulk_endpoints - Check whether an interface's current altsetting
+ * contains a set of bulk endpoints with the given addresses.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addrs: 0-terminated array of the endpoint addresses (number and
+ * direction) to look for
+ *
+ * Search for endpoints with the specified addresses and check their types.
+ *
+ * Return: %true if all the endpoints are found and are bulk, %false otherwise.
+ */
+bool usb_check_bulk_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs)
+{
+	const struct usb_host_endpoint *ep;
+
+	for (; *ep_addrs; ++ep_addrs) {
+		ep = usb_find_endpoint(intf, *ep_addrs);
+		if (!ep || !usb_endpoint_xfer_bulk(&ep->desc))
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_check_bulk_endpoints);
+
+/**
+ * usb_check_int_endpoints - Check whether an interface's current altsetting
+ * contains a set of interrupt endpoints with the given addresses.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addrs: 0-terminated array of the endpoint addresses (number and
+ * direction) to look for
+ *
+ * Search for endpoints with the specified addresses and check their types.
+ *
+ * Return: %true if all the endpoints are found and are interrupt,
+ * %false otherwise.
+ */
+bool usb_check_int_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs)
+{
+	const struct usb_host_endpoint *ep;
+
+	for (; *ep_addrs; ++ep_addrs) {
+		ep = usb_find_endpoint(intf, *ep_addrs);
+		if (!ep || !usb_endpoint_xfer_int(&ep->desc))
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_check_int_endpoints);
+
 /**
  * usb_find_alt_setting() - Given a configuration, find the alternate setting
  * for the given interface.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 582ebd9cf9c2..bb57bc9bc17c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1110,6 +1110,7 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @suspended: set to track suspend event due to U3/L2.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1327,6 +1328,7 @@ struct dwc3 {
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
+	unsigned		suspended:1;
 
 	u16			imod_interval;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d12cb8f0d1f4..8cd0d919ef63 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3828,6 +3828,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 {
 	int			reg;
 
+	dwc->suspended = false;
+
 	dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RX_DET);
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -3859,6 +3861,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 {
 	u32			reg;
 
+	dwc->suspended = false;
+
 	/*
 	 * Ideally, dwc3_reset_gadget() would trigger the function
 	 * drivers to stop any active transfers through ep disable.
@@ -4088,6 +4092,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 {
+	dwc->suspended = false;
+
 	/*
 	 * TODO take core out of low power mode when that's
 	 * implemented.
@@ -4203,8 +4209,10 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 {
 	enum dwc3_link_state next = evtinfo & DWC3_LINK_STATE_MASK;
 
-	if (dwc->link_state != next && next == DWC3_LINK_STATE_U3)
+	if (!dwc->suspended && next == DWC3_LINK_STATE_U3) {
+		dwc->suspended = true;
 		dwc3_suspend_gadget(dwc);
+	}
 
 	dwc->link_state = next;
 }
diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index f08de33d9ff3..8ed803c4a251 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -3014,6 +3014,20 @@ static int sisusb_probe(struct usb_interface *intf,
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct sisusb_usb_data *sisusb;
 	int retval = 0, i;
+	static const u8 ep_addresses[] = {
+		SISUSB_EP_GFX_IN | USB_DIR_IN,
+		SISUSB_EP_GFX_OUT | USB_DIR_OUT,
+		SISUSB_EP_GFX_BULK_OUT | USB_DIR_OUT,
+		SISUSB_EP_GFX_LBULK_OUT | USB_DIR_OUT,
+		SISUSB_EP_BRIDGE_IN | USB_DIR_IN,
+		SISUSB_EP_BRIDGE_OUT | USB_DIR_OUT,
+		0};
+
+	/* Are the expected endpoints present? */
+	if (!usb_check_bulk_endpoints(intf, ep_addresses)) {
+		dev_err(&intf->dev, "Invalid USB2VGA device\n");
+		return -EINVAL;
+	}
 
 	dev_info(&dev->dev, "USB2VGA dongle found at address %d\n",
 			dev->devnum);
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 216d49c9d47e..256d9b61f4ea 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -27,6 +27,8 @@
 #include <video/udlfb.h>
 #include "edid.h"
 
+#define OUT_EP_NUM	1	/* The endpoint number we will use */
+
 static const struct fb_fix_screeninfo dlfb_fix = {
 	.id =           "udlfb",
 	.type =         FB_TYPE_PACKED_PIXELS,
@@ -1652,7 +1654,7 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 	struct fb_info *info;
 	int retval;
 	struct usb_device *usbdev = interface_to_usbdev(intf);
-	struct usb_endpoint_descriptor *out;
+	static u8 out_ep[] = {OUT_EP_NUM + USB_DIR_OUT, 0};
 
 	/* usb initialization */
 	dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
@@ -1666,9 +1668,9 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 	dlfb->udev = usb_get_dev(usbdev);
 	usb_set_intfdata(intf, dlfb);
 
-	retval = usb_find_common_endpoints(intf->cur_altsetting, NULL, &out, NULL, NULL);
-	if (retval) {
-		dev_err(&intf->dev, "Device should have at lease 1 bulk endpoint!\n");
+	if (!usb_check_bulk_endpoints(intf, out_ep)) {
+		dev_err(&intf->dev, "Invalid DisplayLink device!\n");
+		retval = -EINVAL;
 		goto error;
 	}
 
@@ -1927,7 +1929,8 @@ static int dlfb_alloc_urb_list(struct dlfb_data *dlfb, int count, size_t size)
 		}
 
 		/* urb->transfer_buffer_length set to actual before submit */
-		usb_fill_bulk_urb(urb, dlfb->udev, usb_sndbulkpipe(dlfb->udev, 1),
+		usb_fill_bulk_urb(urb, dlfb->udev,
+			usb_sndbulkpipe(dlfb->udev, OUT_EP_NUM),
 			buf, size, dlfb_urb_completion, unode);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index fb426b7d81da..14f8d8d90920 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -115,6 +115,10 @@ static int tco_timer_start(struct watchdog_device *wdd)
 	val |= SP5100_WDT_START_STOP_BIT;
 	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
 
+	/* This must be a distinct write. */
+	val |= SP5100_WDT_TRIGGER_BIT;
+	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
+
 	return 0;
 }
 
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 28b2a1fa25ab..0bff02ac0045 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -321,8 +321,10 @@ static struct sock_mapping *pvcalls_new_active_socket(
 	void *page;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
-	if (map == NULL)
+	if (map == NULL) {
+		sock_release(sock);
 		return NULL;
+	}
 
 	map->fedata = fedata;
 	map->sock = sock;
@@ -414,10 +416,8 @@ static int pvcalls_back_connect(struct xenbus_device *dev,
 					req->u.connect.ref,
 					req->u.connect.evtchn,
 					sock);
-	if (!map) {
+	if (!map)
 		ret = -EFAULT;
-		sock_release(sock);
-	}
 
 out:
 	rsp = RING_GET_RESPONSE(&fedata->ring, fedata->ring.rsp_prod_pvt++);
@@ -557,7 +557,6 @@ static void __pvcalls_back_accept(struct work_struct *work)
 					sock);
 	if (!map) {
 		ret = -EFAULT;
-		sock_release(sock);
 		goto out_error;
 	}
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index acae82a5f8ee..21d8a895e9ad 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -5035,7 +5035,11 @@ static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
 		 */
 		inode = igrab(&btrfs_inode->vfs_inode);
 		if (inode) {
+			unsigned int nofs_flag;
+
+			nofs_flag = memalloc_nofs_save();
 			invalidate_inode_pages2(inode->i_mapping);
+			memalloc_nofs_restore(nofs_flag);
 			iput(inode);
 		}
 		spin_lock(&root->delalloc_lock);
@@ -5140,7 +5144,12 @@ static void btrfs_cleanup_bg_io(struct btrfs_block_group *cache)
 
 	inode = cache->io_ctl.inode;
 	if (inode) {
+		unsigned int nofs_flag;
+
+		nofs_flag = memalloc_nofs_save();
 		invalidate_inode_pages2(inode->i_mapping);
+		memalloc_nofs_restore(nofs_flag);
+
 		BTRFS_I(inode)->generation = 0;
 		cache->io_ctl.inode = NULL;
 		iput(inode);
diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 89e810b27a4b..e2e2ef0fa9a0 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -904,6 +904,14 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			ctx->sfu_remap = false; /* disable SFU mapping */
 		}
 		break;
+	case Opt_mapchars:
+		if (result.negated)
+			ctx->sfu_remap = false;
+		else {
+			ctx->sfu_remap = true;
+			ctx->remap = false; /* disable SFM (mapposix) mapping */
+		}
+		break;
 	case Opt_user_xattr:
 		if (result.negated)
 			ctx->no_xattr = 1;
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 05f32989bad6..1c7ac433667d 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -242,6 +242,7 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
 	int want_meta = 0;
 	int xattr_credits = 0;
 	struct ocfs2_security_xattr_info si = {
+		.name = NULL,
 		.enable = 1,
 	};
 	int did_quota_inode = 0;
@@ -1805,6 +1806,7 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
 	int want_clusters = 0;
 	int xattr_credits = 0;
 	struct ocfs2_security_xattr_info si = {
+		.name = NULL,
 		.enable = 1,
 	};
 	int did_quota = 0, did_quota_inode = 0;
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 95d0611c5fc7..55699c573541 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7259,9 +7259,21 @@ static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
 static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
 		     void *fs_info)
 {
+	struct ocfs2_security_xattr_info *si = fs_info;
 	const struct xattr *xattr;
 	int err = 0;
 
+	if (si) {
+		si->value = kmemdup(xattr_array->value, xattr_array->value_len,
+				    GFP_KERNEL);
+		if (!si->value)
+			return -ENOMEM;
+
+		si->name = xattr_array->name;
+		si->value_len = xattr_array->value_len;
+		return 0;
+	}
+
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 		err = ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
 				      xattr->name, xattr->value,
@@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
 			    const struct qstr *qstr,
 			    struct ocfs2_security_xattr_info *si)
 {
+	int ret;
+
 	/* check whether ocfs2 support feature xattr */
 	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
 		return -EOPNOTSUPP;
-	if (si)
-		return security_old_inode_init_security(inode, dir, qstr,
-							&si->name, &si->value,
-							&si->value_len);
+	if (si) {
+		ret = security_inode_init_security(inode, dir, qstr,
+						   &ocfs2_initxattrs, si);
+		/*
+		 * security_inode_init_security() does not return -EOPNOTSUPP,
+		 * we have to check the xattr ourselves.
+		 */
+		if (!ret && !si->name)
+			si->enable = 0;
+
+		return ret;
+	}
 
 	return security_inode_init_security(inode, dir, qstr,
 					    &ocfs2_initxattrs, NULL);
diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
index 359883942612..ad08f834af40 100644
--- a/include/drm/drm_managed.h
+++ b/include/drm/drm_managed.h
@@ -105,6 +105,22 @@ char *drmm_kstrdup(struct drm_device *dev, const char *s, gfp_t gfp);
 
 void drmm_kfree(struct drm_device *dev, void *data);
 
-int drmm_mutex_init(struct drm_device *dev, struct mutex *lock);
+void __drmm_mutex_release(struct drm_device *dev, void *res);
+
+/**
+ * drmm_mutex_init - &drm_device-managed mutex_init()
+ * @dev: DRM device
+ * @lock: lock to be initialized
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
+ *
+ * This is a &drm_device-managed version of mutex_init(). The initialized
+ * lock is automatically destroyed on the final drm_dev_put().
+ */
+#define drmm_mutex_init(dev, lock) ({					     \
+	mutex_init(lock);						     \
+	drmm_add_action_or_reset(dev, __drmm_mutex_release, lock);	     \
+})									     \
 
 #endif
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 5f02d2e6b9d9..c617b179c26c 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -13,6 +13,7 @@
 
 /* FFA Bus/Device/Driver related */
 struct ffa_device {
+	u32 id;
 	int vm_id;
 	bool mode_32bit;
 	uuid_t uuid;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f14ecbeab2a9..a2b5592c6828 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1380,29 +1380,29 @@ extern int send_sigurg(struct fown_struct *fown);
  * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
  * represented in both.
  */
-#define SB_RDONLY	 1	/* Mount read-only */
-#define SB_NOSUID	 2	/* Ignore suid and sgid bits */
-#define SB_NODEV	 4	/* Disallow access to device special files */
-#define SB_NOEXEC	 8	/* Disallow program execution */
-#define SB_SYNCHRONOUS	16	/* Writes are synced at once */
-#define SB_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define SB_DIRSYNC	128	/* Directory modifications are synchronous */
-#define SB_NOATIME	1024	/* Do not update access times. */
-#define SB_NODIRATIME	2048	/* Do not update directory access times */
-#define SB_SILENT	32768
-#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
-#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
-#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
-#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+#define SB_RDONLY       BIT(0)	/* Mount read-only */
+#define SB_NOSUID       BIT(1)	/* Ignore suid and sgid bits */
+#define SB_NODEV        BIT(2)	/* Disallow access to device special files */
+#define SB_NOEXEC       BIT(3)	/* Disallow program execution */
+#define SB_SYNCHRONOUS  BIT(4)	/* Writes are synced at once */
+#define SB_MANDLOCK     BIT(6)	/* Allow mandatory locks on an FS */
+#define SB_DIRSYNC      BIT(7)	/* Directory modifications are synchronous */
+#define SB_NOATIME      BIT(10)	/* Do not update access times. */
+#define SB_NODIRATIME   BIT(11)	/* Do not update directory access times */
+#define SB_SILENT       BIT(15)
+#define SB_POSIXACL     BIT(16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT  BIT(17)	/* Use blk-crypto for encrypted files */
+#define SB_KERNMOUNT    BIT(22)	/* this is a kern_mount call */
+#define SB_I_VERSION    BIT(23)	/* Update inode I_version field */
+#define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
 
 /* These sb flags are internal to the kernel */
-#define SB_SUBMOUNT     (1<<26)
-#define SB_FORCE    	(1<<27)
-#define SB_NOSEC	(1<<28)
-#define SB_BORN		(1<<29)
-#define SB_ACTIVE	(1<<30)
-#define SB_NOUSER	(1<<31)
+#define SB_SUBMOUNT     BIT(26)
+#define SB_FORCE        BIT(27)
+#define SB_NOSEC        BIT(28)
+#define SB_BORN         BIT(29)
+#define SB_ACTIVE       BIT(30)
+#define SB_NOUSER       BIT(31)
 
 /* These flags relate to encoding and casefolding */
 #define SB_ENC_STRICT_MODE_FL	(1 << 0)
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index fc985e5c739d..8de6b6e67829 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -208,6 +208,7 @@ struct team {
 	bool queue_override_enabled;
 	struct list_head *qom_lists; /* array of queue override mapping lists */
 	bool port_mtu_change_allowed;
+	bool notifier_ctx;
 	struct {
 		unsigned int count;
 		unsigned int interval; /* in ms */
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 097cbf84c1e0..b2aee17a34d7 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1639,7 +1639,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         rc[0x1];
 
 	u8         uar_4k[0x1];
-	u8         reserved_at_241[0x9];
+	u8         reserved_at_241[0x7];
+	u8         fl_rc_qp_when_roce_disabled[0x1];
+	u8         regexp_params[0x1];
 	u8         uar_sz[0x6];
 	u8         port_selection_cap[0x1];
 	u8         reserved_at_248[0x1];
diff --git a/include/linux/msi.h b/include/linux/msi.h
index fc918a658d48..e5dfb9cf3aa1 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -278,6 +278,13 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
+
+/*
+ * Xen uses non-default msi_domain_ops and hence needs a way to populate sysfs
+ * entries of MSI IRQs.
+ */
+#if defined(CONFIG_PCI_XEN) || defined(CONFIG_PCI_MSI_ARCH_FALLBACKS)
 #ifdef CONFIG_SYSFS
 int msi_device_populate_sysfs(struct device *dev);
 void msi_device_destroy_sysfs(struct device *dev);
@@ -285,7 +292,7 @@ void msi_device_destroy_sysfs(struct device *dev);
 static inline int msi_device_populate_sysfs(struct device *dev) { return 0; }
 static inline void msi_device_destroy_sysfs(struct device *dev) { }
 #endif /* !CONFIG_SYSFS */
-#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
+#endif /* CONFIG_PCI_XEN || CONFIG_PCI_MSI_ARCH_FALLBACKS */
 
 /*
  * The restore hook is still available even for fully irq domain based
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index a1aa68141d0b..7c8d65414a70 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_BQ27X00_BATTERY_H__
 #define __LINUX_BQ27X00_BATTERY_H__
 
+#include <linux/power_supply.h>
+
 enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
@@ -68,7 +70,9 @@ struct bq27xxx_device_info {
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
 	int charge_design_full;
+	bool removed;
 	unsigned long last_update;
+	union power_supply_propval last_status;
 	struct delayed_work work;
 	struct power_supply *bat;
 	struct list_head list;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dfeb25a0362d..4e22e4f4cec8 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -273,13 +273,15 @@ enum tpm2_cc_attrs {
 #define TPM_VID_ATML     0x1114
 
 enum tpm_chip_flags {
-	TPM_CHIP_FLAG_TPM2		= BIT(1),
-	TPM_CHIP_FLAG_IRQ		= BIT(2),
-	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
-	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
-	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
+	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
+	TPM_CHIP_FLAG_TPM2			= BIT(1),
+	TPM_CHIP_FLAG_IRQ			= BIT(2),
+	TPM_CHIP_FLAG_VIRTUAL			= BIT(3),
+	TPM_CHIP_FLAG_HAVE_TIMEOUTS		= BIT(4),
+	TPM_CHIP_FLAG_ALWAYS_POWERED		= BIT(5),
 	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
-	TPM_CHIP_FLAG_FIRMWARE_UPGRADE	= BIT(7),
+	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
+	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 6c95af3317f7..3ce7b052a19f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -279,6 +279,11 @@ void usb_put_intf(struct usb_interface *intf);
 #define USB_MAXINTERFACES	32
 #define USB_MAXIADS		(USB_MAXINTERFACES/2)
 
+bool usb_check_bulk_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs);
+bool usb_check_int_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs);
+
 /*
  * USB Resume Timer: Every Host controller driver should drive the resume
  * signalling on the bus for the amount of time defined by this macro.
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 123729c0e1ee..17329a19f0c6 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -223,6 +223,7 @@ struct bonding {
 	struct   bond_up_slave __rcu *usable_slaves;
 	struct   bond_up_slave __rcu *all_slaves;
 	bool     force_primary;
+	bool     notifier_ctx;
 	s32      slave_cnt; /* never change this value outside the attach/detach wrappers */
 	int     (*recv_probe)(const struct sk_buff *, struct bonding *,
 			      struct slave *);
diff --git a/include/uapi/sound/skl-tplg-interface.h b/include/uapi/sound/skl-tplg-interface.h
index f29899b179a6..4bf9c4f9add8 100644
--- a/include/uapi/sound/skl-tplg-interface.h
+++ b/include/uapi/sound/skl-tplg-interface.h
@@ -66,7 +66,8 @@ enum skl_ch_cfg {
 	SKL_CH_CFG_DUAL_MONO = 9,
 	SKL_CH_CFG_I2S_DUAL_STEREO_0 = 10,
 	SKL_CH_CFG_I2S_DUAL_STEREO_1 = 11,
-	SKL_CH_CFG_4_CHANNEL = 12,
+	SKL_CH_CFG_7_1 = 12,
+	SKL_CH_CFG_4_CHANNEL = SKL_CH_CFG_7_1,
 	SKL_CH_CFG_INVALID
 };
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4a3d0a744702..e4e7f343346f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1203,7 +1203,7 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 
 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
-		return ret;
+		goto err_lock_bucket;
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1224,6 +1224,7 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
 
+err_lock_bucket:
 	if (ret)
 		htab_lru_push_free(htab, l_new);
 	else if (l_old)
@@ -1326,7 +1327,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
-		return ret;
+		goto err_lock_bucket;
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1349,6 +1350,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	ret = 0;
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
+err_lock_bucket:
 	if (l_new)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
 	return ret;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 322a2ae8f88b..280e689517e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13638,7 +13638,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
 									insn->dst_reg,
 									shift);
-				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
+				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
 								(1ULL << size * 8) - 1);
 			}
 		}
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index a9ee535293eb..77e513e2e5da 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -420,7 +420,7 @@ static int msi_sysfs_populate_desc(struct device *dev, struct msi_desc *desc)
 	return ret;
 }
 
-#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
+#if defined(CONFIG_PCI_MSI_ARCH_FALLBACKS) || defined(CONFIG_PCI_XEN)
 /**
  * msi_device_populate_sysfs - Populate msi_irqs sysfs entries for a device
  * @dev:	The device (PCI, platform etc) which will get sysfs entries
@@ -452,7 +452,7 @@ void msi_device_destroy_sysfs(struct device *dev)
 	msi_for_each_desc(desc, dev, MSI_DESC_ALL)
 		msi_sysfs_remove_desc(dev, desc);
 }
-#endif /* CONFIG_PCI_MSI_ARCH_FALLBACK */
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACK || CONFIG_PCI_XEN */
 #else /* CONFIG_SYSFS */
 static inline int msi_sysfs_create_group(struct device *dev) { return 0; }
 static inline int msi_sysfs_populate_desc(struct device *dev, struct msi_desc *desc) { return 0; }
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index bdfd859cccaf..c46736210363 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -126,7 +126,7 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 
 static void fill_pool(void)
 {
-	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
+	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
 	struct debug_obj *obj;
 	unsigned long flags;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 47660002cada..ef9772b12624 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -506,14 +506,14 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 */
 	size = SKB_DATA_ALIGN(size);
 	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
+	osize = kmalloc_size_roundup(size);
+	data = kmalloc_reserve(osize, gfp_mask, node, &pfmemalloc);
 	if (unlikely(!data))
 		goto nodata;
-	/* kmalloc(size) might give us more room than requested.
+	/* kmalloc_size_roundup() might give us more room than requested.
 	 * Put skb_shared_info exactly at the end of allocated zone,
 	 * to allow max possible filling before reallocation.
 	 */
-	osize = ksize(data);
 	size = SKB_WITH_OVERHEAD(osize);
 	prefetchw(data + size);
 
@@ -1822,10 +1822,11 @@ EXPORT_SYMBOL(__pskb_copy_fclone);
 int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		     gfp_t gfp_mask)
 {
-	int i, osize = skb_end_offset(skb);
-	int size = osize + nhead + ntail;
+	unsigned int osize = skb_end_offset(skb);
+	unsigned int size = osize + nhead + ntail;
 	long off;
 	u8 *data;
+	int i;
 
 	BUG_ON(nhead < 0);
 
@@ -1833,15 +1834,16 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 
 	skb_zcopy_downgrade_managed(skb);
 
-	size = SKB_DATA_ALIGN(size);
-
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
-	data = kmalloc_reserve(size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
-			       gfp_mask, NUMA_NO_NODE, NULL);
+
+	size = SKB_DATA_ALIGN(size);
+	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = kmalloc_size_roundup(size);
+	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
 		goto nodata;
-	size = SKB_WITH_OVERHEAD(ksize(data));
+	size = SKB_WITH_OVERHEAD(size);
 
 	/* Copy only real data... and, alas, header. This should be
 	 * optimized for the cases when header is void.
@@ -4981,8 +4983,10 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	} else {
 		skb = skb_clone(orig_skb, GFP_ATOMIC);
 
-		if (skb_orphan_frags_rx(skb, GFP_ATOMIC))
+		if (skb_orphan_frags_rx(skb, GFP_ATOMIC)) {
+			kfree_skb(skb);
 			return;
+		}
 	}
 	if (!skb)
 		return;
@@ -6182,21 +6186,20 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 				    const int headlen, gfp_t gfp_mask)
 {
 	int i;
-	int size = skb_end_offset(skb);
+	unsigned int size = skb_end_offset(skb);
 	int new_hlen = headlen - off;
 	u8 *data;
 
-	size = SKB_DATA_ALIGN(size);
-
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
-	data = kmalloc_reserve(size +
-			       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
-			       gfp_mask, NUMA_NO_NODE, NULL);
+
+	size = SKB_DATA_ALIGN(size);
+	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = kmalloc_size_roundup(size);
+	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
 		return -ENOMEM;
-
-	size = SKB_WITH_OVERHEAD(ksize(data));
+	size = SKB_WITH_OVERHEAD(size);
 
 	/* Copy real data, and all frags */
 	skb_copy_from_linear_data_offset(skb, off, data, new_hlen);
@@ -6301,22 +6304,21 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 				       int pos, gfp_t gfp_mask)
 {
 	int i, k = 0;
-	int size = skb_end_offset(skb);
+	unsigned int size = skb_end_offset(skb);
 	u8 *data;
 	const int nfrags = skb_shinfo(skb)->nr_frags;
 	struct skb_shared_info *shinfo;
 
-	size = SKB_DATA_ALIGN(size);
-
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
-	data = kmalloc_reserve(size +
-			       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
-			       gfp_mask, NUMA_NO_NODE, NULL);
+
+	size = SKB_DATA_ALIGN(size);
+	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = kmalloc_size_roundup(size);
+	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
 		return -ENOMEM;
-
-	size = SKB_WITH_OVERHEAD(ksize(data));
+	size = SKB_WITH_OVERHEAD(size);
 
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index e0c9cc39b81e..56d94d23b9e0 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -64,6 +64,8 @@ struct proto 	udplite_prot = {
 	.per_cpu_fw_alloc  = &udp_memory_per_cpu_fw_alloc,
 
 	.sysctl_mem	   = sysctl_udp_mem,
+	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
+	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size	   = sizeof(struct udp_sock),
 	.h.udp_table	   = &udplite_table,
 };
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index da46c4284676..49e31e4ae7b7 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -143,6 +143,8 @@ int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type)
 			optlen = 1;
 			break;
 		default:
+			if (len < 2)
+				goto bad;
 			optlen = nh[offset + 1] + 2;
 			if (optlen > len)
 				goto bad;
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index 67eaf3ca14ce..3bab0cc13697 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -60,6 +60,8 @@ struct proto udplitev6_prot = {
 	.per_cpu_fw_alloc  = &udp_memory_per_cpu_fw_alloc,
 
 	.sysctl_mem	   = sysctl_udp_mem,
+	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
+	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size	   = sizeof(struct udp6_sock),
 	.h.udp_table	   = &udplite_table,
 };
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index b3f1a91e9a07..2990365c2f2c 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -324,9 +324,12 @@ bool sctp_transport_pl_recv(struct sctp_transport *t)
 		t->pl.probe_size += SCTP_PL_BIG_STEP;
 	} else if (t->pl.state == SCTP_PL_SEARCH) {
 		if (!t->pl.probe_high) {
-			t->pl.probe_size = min(t->pl.probe_size + SCTP_PL_BIG_STEP,
-					       SCTP_MAX_PLPMTU);
-			return false;
+			if (t->pl.probe_size < SCTP_MAX_PLPMTU) {
+				t->pl.probe_size = min(t->pl.probe_size + SCTP_PL_BIG_STEP,
+						       SCTP_MAX_PLPMTU);
+				return false;
+			}
+			t->pl.probe_high = SCTP_MAX_PLPMTU;
 		}
 		t->pl.probe_size += SCTP_PL_MIN_STEP;
 		if (t->pl.probe_size >= t->pl.probe_high) {
@@ -341,7 +344,7 @@ bool sctp_transport_pl_recv(struct sctp_transport *t)
 	} else if (t->pl.state == SCTP_PL_COMPLETE) {
 		/* Raise probe_size again after 30 * interval in Search Complete */
 		t->pl.state = SCTP_PL_SEARCH; /* Search Complete -> Search */
-		t->pl.probe_size += SCTP_PL_MIN_STEP;
+		t->pl.probe_size = min(t->pl.probe_size + SCTP_PL_MIN_STEP, SCTP_MAX_PLPMTU);
 	}
 
 	return t->pl.state == SCTP_PL_COMPLETE;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e8018b0fb767..02d1daae7739 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1987,8 +1987,10 @@ static int smc_listen_rdma_init(struct smc_sock *new_smc,
 		return rc;
 
 	/* create send buffer and rmb */
-	if (smc_buf_create(new_smc, false))
+	if (smc_buf_create(new_smc, false)) {
+		smc_conn_abort(new_smc, ini->first_contact_local);
 		return SMC_CLC_DECL_MEM;
+	}
 
 	return 0;
 }
@@ -2204,8 +2206,11 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
 	smcr_version = ini->smcr_version;
 	ini->smcr_version = SMC_V2;
 	rc = smc_listen_rdma_init(new_smc, ini);
-	if (!rc)
+	if (!rc) {
 		rc = smc_listen_rdma_reg(new_smc, ini->first_contact_local);
+		if (rc)
+			smc_conn_abort(new_smc, ini->first_contact_local);
+	}
 	if (!rc)
 		return;
 	ini->smcr_version = smcr_version;
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 0208dfb35345..f82f43573a15 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -127,6 +127,7 @@ static int smcr_lgr_conn_assign_link(struct smc_connection *conn, bool first)
 	int i, j;
 
 	/* do link balancing */
+	conn->lnk = NULL;	/* reset conn->lnk first */
 	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 		struct smc_link *lnk = &conn->lgr->lnk[i];
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index c8321de341ee..6debf4fd42d4 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -927,11 +927,10 @@ static void __rpc_execute(struct rpc_task *task)
 		 */
 		do_action = task->tk_action;
 		/* Tasks with an RPC error status should exit */
-		if (do_action != rpc_exit_task &&
+		if (do_action && do_action != rpc_exit_task &&
 		    (status = READ_ONCE(task->tk_rpc_status)) != 0) {
 			task->tk_status = status;
-			if (do_action != NULL)
-				do_action = rpc_exit_task;
+			do_action = rpc_exit_task;
 		}
 		/* Callbacks override all actions */
 		if (task->tk_callback) {
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index b7e5032b61c9..bfd858577676 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -611,7 +611,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_power_up_pm);
 int snd_hdac_keep_power_up(struct hdac_device *codec)
 {
 	if (!atomic_inc_not_zero(&codec->in_pm)) {
-		int ret = pm_runtime_get_if_in_use(&codec->dev);
+		int ret = pm_runtime_get_if_active(&codec->dev, true);
 		if (!ret)
 			return -1;
 		if (ret < 0)
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 099722ebaed8..748a3c40966e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1306,6 +1306,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
+	SND_PCI_QUIRK(0x3842, 0x104b, "EVGA X299 Dark", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1055, "EVGA Z390 DARK", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c75760717736..379f216158ab 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11699,6 +11699,8 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3321, "Lenovo ThinkCentre M70 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x331b, "Lenovo ThinkCentre M90 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3742, "Lenovo TianYi510Pro-14IOB", ALC897_FIXUP_HEADSET_MIC_PIN2),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index d1d9d8d2df2d..9f59518005a5 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -745,6 +745,8 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
 
 	val = ucontrol->value.enumerated.item[0];
+	if (val >= e->items)
+		return -EINVAL;
 
 	switch (e->reg) {
 	case CDC_TX_INP_MUX_ADC_MUX0_CFG0:
@@ -771,6 +773,9 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
 	case CDC_TX_INP_MUX_ADC_MUX7_CFG0:
 		mic_sel_reg = CDC_TX7_TX_PATH_CFG0;
 		break;
+	default:
+		dev_err(component->dev, "Error in configuration!!\n");
+		return -EINVAL;
 	}
 
 	if (val != 0) {
diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 2935c1bb81f3..5bc46b041786 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -267,7 +267,9 @@ static int rt5682_i2c_probe(struct i2c_client *i2c)
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
 			rt5682_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5682", rt5682);
-		if (ret)
+		if (!ret)
+			rt5682->irq = i2c->irq;
+		else
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
 	}
 
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 2df95e792900..a6636ef69f57 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2957,6 +2957,9 @@ static int rt5682_suspend(struct snd_soc_component *component)
 	if (rt5682->is_sdw)
 		return 0;
 
+	if (rt5682->irq)
+		disable_irq(rt5682->irq);
+
 	cancel_delayed_work_sync(&rt5682->jack_detect_work);
 	cancel_delayed_work_sync(&rt5682->jd_check_work);
 	if (rt5682->hs_jack && (rt5682->jack_type & SND_JACK_HEADSET) == SND_JACK_HEADSET) {
@@ -3025,6 +3028,9 @@ static int rt5682_resume(struct snd_soc_component *component)
 	mod_delayed_work(system_power_efficient_wq,
 		&rt5682->jack_detect_work, msecs_to_jiffies(0));
 
+	if (rt5682->irq)
+		enable_irq(rt5682->irq);
+
 	return 0;
 }
 #else
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index 52ff0d9c36c5..5fd798eac40d 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -1462,6 +1462,7 @@ struct rt5682_priv {
 	int pll_out[RT5682_PLLS];
 
 	int jack_type;
+	int irq;
 	int irq_work_delay_time;
 };
 
diff --git a/sound/soc/intel/avs/apl.c b/sound/soc/intel/avs/apl.c
index b8e2b23c9f64..f366478a875d 100644
--- a/sound/soc/intel/avs/apl.c
+++ b/sound/soc/intel/avs/apl.c
@@ -173,6 +173,7 @@ static bool apl_lp_streaming(struct avs_dev *adev)
 {
 	struct avs_path *path;
 
+	spin_lock(&adev->path_list_lock);
 	/* Any gateway without buffer allocated in LP area disqualifies D0IX. */
 	list_for_each_entry(path, &adev->path_list, node) {
 		struct avs_path_pipeline *ppl;
@@ -192,11 +193,14 @@ static bool apl_lp_streaming(struct avs_dev *adev)
 				if (cfg->copier.dma_type == INVALID_OBJECT_ID)
 					continue;
 
-				if (!mod->gtw_attrs.lp_buffer_alloc)
+				if (!mod->gtw_attrs.lp_buffer_alloc) {
+					spin_unlock(&adev->path_list_lock);
 					return false;
+				}
 			}
 		}
 	}
+	spin_unlock(&adev->path_list_lock);
 
 	return true;
 }
diff --git a/sound/soc/intel/avs/messages.h b/sound/soc/intel/avs/messages.h
index c0f90dba9af8..b82b2483ef9b 100644
--- a/sound/soc/intel/avs/messages.h
+++ b/sound/soc/intel/avs/messages.h
@@ -611,7 +611,7 @@ enum avs_channel_config {
 	AVS_CHANNEL_CONFIG_DUAL_MONO = 9,
 	AVS_CHANNEL_CONFIG_I2S_DUAL_STEREO_0 = 10,
 	AVS_CHANNEL_CONFIG_I2S_DUAL_STEREO_1 = 11,
-	AVS_CHANNEL_CONFIG_4_CHANNEL = 12,
+	AVS_CHANNEL_CONFIG_7_1 = 12,
 	AVS_CHANNEL_CONFIG_INVALID
 };
 
diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index be675002f918..93798c8c5d54 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -22,6 +22,7 @@
 #include <linux/falloc.h>
 #include <fcntl.h>
 #include <linux/memfd.h>
+#include <linux/types.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 70ea8798b1f6..e5db2a2a67df 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -68,7 +68,7 @@ setup()
 cleanup()
 {
 	$IP link del dev dummy0 &> /dev/null
-	ip netns del ns1
+	ip netns del ns1 &> /dev/null
 	ip netns del ns2 &> /dev/null
 }
 
