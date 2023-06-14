Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6660715DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjE3Lwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjE3LwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E9BE8;
        Tue, 30 May 2023 04:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95A1262E82;
        Tue, 30 May 2023 11:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38044C4339C;
        Tue, 30 May 2023 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685447524;
        bh=Opv37iokk+lIS6kwsKoiP7MVS1wQgxyfUxu/bCaqzVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7WSvxPoTlaXzGPRpVSr7ytTckdJl7EqA3oHCddPypzAxDnRWwEW9RMEfABgscpy0
         hNroCYcskfd5xx1QKpfha+nhvCO2YE6Zqu0rh1R6LqAUeYCOqpgvIN642OZV1jQlaa
         ZC76UpHXMEjJ03r2X0Bz5AoHGnR6gm0jcF9wyZtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.284
Date:   Tue, 30 May 2023 12:51:52 +0100
Message-Id: <2023053052-gigabyte-size-017b@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023053051-entity-commend-d844@gregkh>
References: <2023053051-entity-commend-d844@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 71416fde7348..8d8803054d78 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 283
+SUBLEVEL = 284
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index c67a68b6b69d..d08c771b59c1 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -882,11 +882,17 @@ static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *
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
@@ -904,7 +910,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame) + fsize);
+	frame = get_sigframe(ksig, tregs, sizeof(*frame) + fsize);
 
 	if (fsize)
 		err |= copy_to_user (frame + 1, regs + 1, fsize);
@@ -975,7 +981,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame));
+	frame = get_sigframe(ksig, tregs, sizeof(*frame));
 
 	if (fsize)
 		err |= copy_to_user (&frame->uc.uc_extra, regs + 1, fsize);
diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 0c83644bfa5c..b4076ac51005 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -57,6 +57,11 @@ extern void flush_dcache_page(struct page *page);
 
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
+		xa_lock_irqsave(&mapping->i_pages, flags)
+#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
+		xa_unlock_irqrestore(&mapping->i_pages, flags)
+
 
 #define flush_icache_page(vma,page)	do { 		\
 	flush_kernel_dcache_page(page);			\
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index bddd2acebdcc..d03a5df7589f 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -309,6 +309,7 @@ void flush_dcache_page(struct page *page)
 	struct vm_area_struct *mpnt;
 	unsigned long offset;
 	unsigned long addr, old_addr = 0;
+	unsigned long flags;
 	pgoff_t pgoff;
 
 	if (mapping && !mapping_mapped(mapping)) {
@@ -328,7 +329,7 @@ void flush_dcache_page(struct page *page)
 	 * declared as MAP_PRIVATE or MAP_SHARED), so we only need
 	 * to flush one address here for them all to become coherent */
 
-	flush_dcache_mmap_lock(mapping);
+	flush_dcache_mmap_lock_irqsave(mapping, flags);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		addr = mpnt->vm_start + offset;
@@ -351,7 +352,7 @@ void flush_dcache_page(struct page *page)
 			old_addr = addr;
 		}
 	}
-	flush_dcache_mmap_unlock(mapping);
+	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 97c206734e24..80592603caaa 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -138,13 +138,18 @@ void machine_power_off(void)
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
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 1f2f52a34086..ccf07426a84d 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -74,6 +74,11 @@
 #define	INTEL_FAM6_LAKEFIELD		0x8A
 #define INTEL_FAM6_ALDERLAKE		0x97
 #define INTEL_FAM6_ALDERLAKE_L		0x9A
+#define INTEL_FAM6_ALDERLAKE_N		0xBE
+
+#define INTEL_FAM6_RAPTORLAKE		0xB7
+#define INTEL_FAM6_RAPTORLAKE_P		0xBA
+#define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
 /* "Small Core" Processors (Atom) */
 
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 2b17a5cec099..7e698c45760c 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -171,7 +171,6 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
-	stack = stack ? : get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -190,9 +189,13 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
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
index b1dba0987565..2c84c5595cf4 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -9,6 +9,7 @@
 #include <linux/kmemleak.h>
 
 #include <asm/set_memory.h>
+#include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/init.h>
 #include <asm/page.h>
@@ -207,6 +208,24 @@ static void __init probe_page_size_mask(void)
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
@@ -215,6 +234,12 @@ static void setup_pcid(void)
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
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 992bd7b92540..49afba8c916a 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -571,6 +571,9 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
 		object_info =
 		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
 
+		if (!object_info)
+			return (AE_NO_MEMORY);
+
 		/* Walk the namespace from the root */
 
 		(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index c879380e5ce1..ddafbf44158c 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -576,9 +576,14 @@ acpi_ds_init_aml_walk(struct acpi_walk_state *walk_state,
 	ACPI_FUNCTION_TRACE(ds_init_aml_walk);
 
 	walk_state->parser_state.aml =
-	    walk_state->parser_state.aml_start = aml_start;
-	walk_state->parser_state.aml_end =
-	    walk_state->parser_state.pkg_end = aml_start + aml_length;
+	    walk_state->parser_state.aml_start =
+	    walk_state->parser_state.aml_end =
+	    walk_state->parser_state.pkg_end = aml_start;
+	/* Avoid undefined behavior: applying zero offset to null pointer */
+	if (aml_length != 0) {
+		walk_state->parser_state.aml_end += aml_length;
+		walk_state->parser_state.pkg_end += aml_length;
+	}
 
 	/* The next_op of the next_walk will be the beginning of the method */
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3394ec64fe95..d2fde87e4d0d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1153,6 +1153,7 @@ static void acpi_ec_remove_query_handlers(struct acpi_ec *ec,
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	acpi_ec_remove_query_handlers(ec, false, query_bit);
+	flush_workqueue(ec_query_wq);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 349c2754eed7..2f89e618b142 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -80,6 +80,26 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
+/**
+ * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
+ *				    device
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource managemend
+ * @index: resource index
+ */
+#ifdef CONFIG_HAS_IOMEM
+void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
+					     unsigned int index)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	return devm_ioremap_resource(&pdev->dev, res);
+}
+EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
+#endif /* CONFIG_HAS_IOMEM */
+
 /**
  * platform_get_irq - get an IRQ for a device
  * @dev: platform device
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 773560348337..b78e4b6e2c9d 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -347,6 +347,9 @@ int regcache_sync(struct regmap *map)
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
@@ -416,6 +419,9 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 939dc25a7833..3abb4af80be6 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -87,6 +87,22 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkStation P360 Tiny",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
+		},
+	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkPad L490",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
+		},
+	},
 	{}
 };
 
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 5859b8ee1478..3d39a6dc2381 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -29,24 +29,24 @@
 #define MISC_CLK_ENB 0x48
 
 #define OSC_CTRL 0x50
-#define OSC_CTRL_OSC_FREQ_MASK (3<<30)
-#define OSC_CTRL_OSC_FREQ_13MHZ (0<<30)
-#define OSC_CTRL_OSC_FREQ_19_2MHZ (1<<30)
-#define OSC_CTRL_OSC_FREQ_12MHZ (2<<30)
-#define OSC_CTRL_OSC_FREQ_26MHZ (3<<30)
-#define OSC_CTRL_MASK (0x3f2 | OSC_CTRL_OSC_FREQ_MASK)
-
-#define OSC_CTRL_PLL_REF_DIV_MASK (3<<28)
-#define OSC_CTRL_PLL_REF_DIV_1		(0<<28)
-#define OSC_CTRL_PLL_REF_DIV_2		(1<<28)
-#define OSC_CTRL_PLL_REF_DIV_4		(2<<28)
+#define OSC_CTRL_OSC_FREQ_MASK (3u<<30)
+#define OSC_CTRL_OSC_FREQ_13MHZ (0u<<30)
+#define OSC_CTRL_OSC_FREQ_19_2MHZ (1u<<30)
+#define OSC_CTRL_OSC_FREQ_12MHZ (2u<<30)
+#define OSC_CTRL_OSC_FREQ_26MHZ (3u<<30)
+#define OSC_CTRL_MASK (0x3f2u | OSC_CTRL_OSC_FREQ_MASK)
+
+#define OSC_CTRL_PLL_REF_DIV_MASK	(3u<<28)
+#define OSC_CTRL_PLL_REF_DIV_1		(0u<<28)
+#define OSC_CTRL_PLL_REF_DIV_2		(1u<<28)
+#define OSC_CTRL_PLL_REF_DIV_4		(2u<<28)
 
 #define OSC_FREQ_DET 0x58
-#define OSC_FREQ_DET_TRIG (1<<31)
+#define OSC_FREQ_DET_TRIG (1u<<31)
 
 #define OSC_FREQ_DET_STATUS 0x5c
-#define OSC_FREQ_DET_BUSY (1<<31)
-#define OSC_FREQ_DET_CNT_MASK 0xFFFF
+#define OSC_FREQ_DET_BUSYu (1<<31)
+#define OSC_FREQ_DET_CNT_MASK 0xFFFFu
 
 #define TEGRA20_CLK_PERIPH_BANKS	3
 
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index e809f4d9a9e9..ea2c2bdcf4f7 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -43,6 +43,8 @@ static asmlinkage void (*sdei_firmware_call)(unsigned long function_id,
 /* entry point from firmware to arch asm code */
 static unsigned long sdei_entry_point;
 
+static int sdei_hp_state;
+
 struct sdei_event {
 	/* These three are protected by the sdei_list_lock */
 	struct list_head	list;
@@ -303,8 +305,6 @@ int sdei_mask_local_cpu(void)
 {
 	int err;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PE_MASK, 0, 0, 0, 0, 0, NULL);
 	if (err && err != -EIO) {
 		pr_warn_once("failed to mask CPU[%u]: %d\n",
@@ -317,6 +317,7 @@ int sdei_mask_local_cpu(void)
 
 static void _ipi_mask_cpu(void *ignored)
 {
+	WARN_ON_ONCE(preemptible());
 	sdei_mask_local_cpu();
 }
 
@@ -324,8 +325,6 @@ int sdei_unmask_local_cpu(void)
 {
 	int err;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PE_UNMASK, 0, 0, 0, 0, 0, NULL);
 	if (err && err != -EIO) {
 		pr_warn_once("failed to unmask CPU[%u]: %d\n",
@@ -338,6 +337,7 @@ int sdei_unmask_local_cpu(void)
 
 static void _ipi_unmask_cpu(void *ignored)
 {
+	WARN_ON_ONCE(preemptible());
 	sdei_unmask_local_cpu();
 }
 
@@ -345,6 +345,8 @@ static void _ipi_private_reset(void *ignored)
 {
 	int err;
 
+	WARN_ON_ONCE(preemptible());
+
 	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PRIVATE_RESET, 0, 0, 0, 0, 0,
 			     NULL);
 	if (err && err != -EIO)
@@ -391,8 +393,6 @@ static void _local_event_enable(void *data)
 	int err;
 	struct sdei_crosscall_args *arg = data;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = sdei_api_event_enable(arg->event->event_num);
 
 	sdei_cross_call_return(arg, err);
@@ -483,8 +483,6 @@ static void _local_event_unregister(void *data)
 	int err;
 	struct sdei_crosscall_args *arg = data;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = sdei_api_event_unregister(arg->event->event_num);
 
 	sdei_cross_call_return(arg, err);
@@ -573,8 +571,6 @@ static void _local_event_register(void *data)
 	struct sdei_registered_event *reg;
 	struct sdei_crosscall_args *arg = data;
 
-	WARN_ON(preemptible());
-
 	reg = per_cpu_ptr(arg->event->private_registered, smp_processor_id());
 	err = sdei_api_event_register(arg->event->event_num, sdei_entry_point,
 				      reg, 0, 0);
@@ -754,6 +750,8 @@ static int sdei_pm_notifier(struct notifier_block *nb, unsigned long action,
 {
 	int rv;
 
+	WARN_ON_ONCE(preemptible());
+
 	switch (action) {
 	case CPU_PM_ENTER:
 		rv = sdei_mask_local_cpu();
@@ -802,7 +800,7 @@ static int sdei_device_freeze(struct device *dev)
 	int err;
 
 	/* unregister private events */
-	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
+	cpuhp_remove_state(sdei_entry_point);
 
 	err = sdei_unregister_shared();
 	if (err)
@@ -823,12 +821,15 @@ static int sdei_device_thaw(struct device *dev)
 		return err;
 	}
 
-	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
+	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "SDEI",
 				&sdei_cpuhp_up, &sdei_cpuhp_down);
-	if (err)
+	if (err < 0) {
 		pr_warn("Failed to re-register CPU hotplug notifier...\n");
+		return err;
+	}
 
-	return err;
+	sdei_hp_state = err;
+	return 0;
 }
 
 static int sdei_device_restore(struct device *dev)
@@ -860,7 +861,7 @@ static int sdei_reboot_notifier(struct notifier_block *nb, unsigned long action,
 	 * We are going to reset the interface, after this there is no point
 	 * doing work when we take CPUs offline.
 	 */
-	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
+	cpuhp_remove_state(sdei_hp_state);
 
 	sdei_platform_reset();
 
@@ -973,13 +974,15 @@ static int sdei_probe(struct platform_device *pdev)
 		goto remove_cpupm;
 	}
 
-	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
+	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "SDEI",
 				&sdei_cpuhp_up, &sdei_cpuhp_down);
-	if (err) {
+	if (err < 0) {
 		pr_warn("Failed to register CPU hotplug notifier...\n");
 		goto remove_reboot;
 	}
 
+	sdei_hp_state = err;
+
 	return 0;
 
 remove_reboot:
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 6fd57cfb112f..96fdc18ecb3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -778,7 +778,7 @@ static void dce_transform_set_pixel_storage_depth(
 		color_depth = COLOR_DEPTH_101010;
 		pixel_depth = 0;
 		expan_mode  = 1;
-		BREAK_TO_DEBUGGER();
+		DC_LOG_DC("The pixel depth %d is not valid, set COLOR_DEPTH_101010 instead.", depth);
 		break;
 	}
 
@@ -792,8 +792,7 @@ static void dce_transform_set_pixel_storage_depth(
 	if (!(xfm_dce->lb_pixel_depth_supported & depth)) {
 		/*we should use unsupported capabilities
 		 *  unless it is required by w/a*/
-		DC_LOG_WARNING("%s: Capability not supported",
-			__func__);
+		DC_LOG_DC("%s: Capability not supported", __func__);
 	}
 }
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.h b/drivers/gpu/drm/exynos/exynos_drm_g2d.h
index 287b2ed8f178..60e420cd4caa 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.h
@@ -37,11 +37,11 @@ static inline int exynos_g2d_exec_ioctl(struct drm_device *dev, void *data,
 	return -ENODEV;
 }
 
-int g2d_open(struct drm_device *drm_dev, struct drm_file *file)
+static inline int g2d_open(struct drm_device *drm_dev, struct drm_file *file)
 {
 	return 0;
 }
 
-void g2d_close(struct drm_device *drm_dev, struct drm_file *file)
+static inline void g2d_close(struct drm_device *drm_dev, struct drm_file *file)
 { }
 #endif
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 83108e243050..adc191ec26a9 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -829,7 +829,7 @@ static int tegra_sor_compute_config(struct tegra_sor *sor,
 				    struct drm_dp_link *link)
 {
 	const u64 f = 100000, link_rate = link->rate * 1000;
-	const u64 pclk = mode->clock * 1000;
+	const u64 pclk = (u64)mode->clock * 1000;
 	u64 input, output, watermark, num;
 	struct tegra_sor_params params;
 	u32 num_syms_per_line;
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 504e8917b06f..5b6bb24df63e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -675,8 +675,7 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
-		 hdev->product, &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
 	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
 
 	name = hidpp_unifying_get_name(hidpp);
@@ -777,6 +776,54 @@ static bool hidpp_is_connected(struct hidpp_device *hidpp)
 	return ret == 0;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x0003: Device Information                                                 */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_DEVICE_INFORMATION			0x0003
+
+#define CMD_GET_DEVICE_INFO				0x00
+
+static int hidpp_get_serial(struct hidpp_device *hidpp, u32 *serial)
+{
+	struct hidpp_report response;
+	u8 feature_type;
+	u8 feature_index;
+	int ret;
+
+	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_DEVICE_INFORMATION,
+				     &feature_index,
+				     &feature_type);
+	if (ret)
+		return ret;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_GET_DEVICE_INFO,
+					  NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	/* See hidpp_unifying_get_serial() */
+	*serial = *((u32 *)&response.rap.params[1]);
+	return 0;
+}
+
+static int hidpp_serial_init(struct hidpp_device *hidpp)
+{
+	struct hid_device *hdev = hidpp->hid_dev;
+	u32 serial;
+	int ret;
+
+	ret = hidpp_get_serial(hidpp, &serial);
+	if (ret)
+		return ret;
+
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
+	dbg_hid("HID++ DeviceInformation: Got serial: %s\n", hdev->uniq);
+
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* 0x0005: GetDeviceNameType                                                  */
 /* -------------------------------------------------------------------------- */
@@ -3040,6 +3087,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
 		hidpp_unifying_init(hidpp);
+	else if (hid_is_usb(hidpp->hid_dev))
+		hidpp_serial_init(hidpp);
 
 	connected = hidpp_is_connected(hidpp);
 	atomic_set(&hidpp->connected, connected);
diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 9c0900c35b23..45636d82ec30 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -94,6 +94,7 @@
 #include <linux/leds.h>
 #include <linux/usb/input.h>
 #include <linux/power_supply.h>
+#include <linux/timer.h>
 #include <asm/unaligned.h>
 
 /*
@@ -170,6 +171,7 @@ struct wacom {
 	struct delayed_work init_work;
 	struct wacom_remote *remote;
 	struct work_struct mode_change_work;
+	struct timer_list idleprox_timer;
 	bool generic_has_leds;
 	struct wacom_leds {
 		struct wacom_group_leds *groups;
@@ -242,4 +244,5 @@ struct wacom_led *wacom_led_find(struct wacom *wacom, unsigned int group,
 struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur);
 int wacom_equivalent_usage(int usage);
 int wacom_initialize_leds(struct wacom *wacom);
+void wacom_idleprox_timeout(struct timer_list *list);
 #endif
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8e32415e0a90..4e4a3424c1f9 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2754,6 +2754,7 @@ static int wacom_probe(struct hid_device *hdev,
 	INIT_WORK(&wacom->battery_work, wacom_battery_work);
 	INIT_WORK(&wacom->remote_work, wacom_remote_work);
 	INIT_WORK(&wacom->mode_change_work, wacom_mode_change_work);
+	timer_setup(&wacom->idleprox_timer, &wacom_idleprox_timeout, TIMER_DEFERRABLE);
 
 	/* ask for the report descriptor to be loaded by HID */
 	error = hid_parse(hdev);
@@ -2802,6 +2803,7 @@ static void wacom_remove(struct hid_device *hdev)
 	cancel_work_sync(&wacom->battery_work);
 	cancel_work_sync(&wacom->remote_work);
 	cancel_work_sync(&wacom->mode_change_work);
+	del_timer_sync(&wacom->idleprox_timer);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da6053deb954..c3ebc0cb69b8 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -15,6 +15,7 @@
 #include "wacom_wac.h"
 #include "wacom.h"
 #include <linux/input/mt.h>
+#include <linux/jiffies.h>
 
 /* resolution for penabled devices */
 #define WACOM_PL_RES		20
@@ -45,6 +46,43 @@ static int wacom_numbered_button_to_key(int n);
 
 static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 			     int group);
+
+static void wacom_force_proxout(struct wacom_wac *wacom_wac)
+{
+	struct input_dev *input = wacom_wac->pen_input;
+
+	wacom_wac->shared->stylus_in_proximity = 0;
+
+	input_report_key(input, BTN_TOUCH, 0);
+	input_report_key(input, BTN_STYLUS, 0);
+	input_report_key(input, BTN_STYLUS2, 0);
+	input_report_key(input, BTN_STYLUS3, 0);
+	input_report_key(input, wacom_wac->tool[0], 0);
+	if (wacom_wac->serial[0]) {
+		input_report_abs(input, ABS_MISC, 0);
+	}
+	input_report_abs(input, ABS_PRESSURE, 0);
+
+	wacom_wac->tool[0] = 0;
+	wacom_wac->id[0] = 0;
+	wacom_wac->serial[0] = 0;
+
+	input_sync(input);
+}
+
+void wacom_idleprox_timeout(struct timer_list *list)
+{
+	struct wacom *wacom = from_timer(wacom, list, idleprox_timer);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+
+	if (!wacom_wac->hid_data.sense_state) {
+		return;
+	}
+
+	hid_warn(wacom->hdev, "%s: tool appears to be hung in-prox. forcing it out.\n", __func__);
+	wacom_force_proxout(wacom_wac);
+}
+
 /*
  * Percent of battery capacity for Graphire.
  * 8th value means AC online and show 100% capacity.
@@ -1839,18 +1877,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 static void wacom_wac_battery_usage_mapping(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage)
 {
-	struct wacom *wacom = hid_get_drvdata(hdev);
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct wacom_features *features = &wacom_wac->features;
-	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
-
-	switch (equivalent_usage) {
-	case HID_DG_BATTERYSTRENGTH:
-	case WACOM_HID_WD_BATTERY_LEVEL:
-	case WACOM_HID_WD_BATTERY_CHARGING:
-		features->quirks |= WACOM_QUIRK_BATTERY;
-		break;
-	}
+	return;
 }
 
 static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *field,
@@ -1871,18 +1898,21 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 			wacom_wac->hid_data.bat_connected = 1;
 			wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
 		}
+		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	case WACOM_HID_WD_BATTERY_LEVEL:
 		value = value * 100 / (field->logical_maximum - field->logical_minimum);
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
+		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	case WACOM_HID_WD_BATTERY_CHARGING:
 		wacom_wac->hid_data.bat_charging = value;
 		wacom_wac->hid_data.ps_connected = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
+		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	}
 }
@@ -1898,18 +1928,15 @@ static void wacom_wac_battery_report(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct wacom_features *features = &wacom_wac->features;
 
-	if (features->quirks & WACOM_QUIRK_BATTERY) {
-		int status = wacom_wac->hid_data.bat_status;
-		int capacity = wacom_wac->hid_data.battery_capacity;
-		bool charging = wacom_wac->hid_data.bat_charging;
-		bool connected = wacom_wac->hid_data.bat_connected;
-		bool powered = wacom_wac->hid_data.ps_connected;
+	int status = wacom_wac->hid_data.bat_status;
+	int capacity = wacom_wac->hid_data.battery_capacity;
+	bool charging = wacom_wac->hid_data.bat_charging;
+	bool connected = wacom_wac->hid_data.bat_connected;
+	bool powered = wacom_wac->hid_data.ps_connected;
 
-		wacom_notify_battery(wacom_wac, status, capacity, charging,
-				     connected, powered);
-	}
+	wacom_notify_battery(wacom_wac, status, capacity, charging,
+			     connected, powered);
 }
 
 static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
@@ -2266,6 +2293,7 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 		value = field->logical_maximum - value;
 		break;
 	case HID_DG_INRANGE:
+		mod_timer(&wacom->idleprox_timer, jiffies + msecs_to_jiffies(100));
 		wacom_wac->hid_data.inrange_state = value;
 		if (!(features->quirks & WACOM_QUIRK_SENSE))
 			wacom_wac->hid_data.sense_state = value;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 9a3cb07555e3..8f850c22be41 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -866,7 +866,7 @@ tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
 
 	len = tmc_etr_buf_get_data(etr_buf, offset,
 				   CORESIGHT_BARRIER_PKT_SIZE, &bufp);
-	if (WARN_ON(len < CORESIGHT_BARRIER_PKT_SIZE))
+	if (WARN_ON(len < 0 || len < CORESIGHT_BARRIER_PKT_SIZE))
 		return -EINVAL;
 	coresight_insert_barrier_packet(bufp);
 	return offset + CORESIGHT_BARRIER_PKT_SIZE;
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index c125cd42faee..0a85f0817662 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -503,6 +503,9 @@ struct xboxone_init_packet {
 	}
 
 
+#define GIP_WIRED_INTF_DATA 0
+#define GIP_WIRED_INTF_AUDIO 1
+
 /*
  * This packet is required for all Xbox One pads with 2015
  * or later firmware installed (or present from the factory).
@@ -1827,7 +1830,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	}
 
 	if (xpad->xtype == XTYPE_XBOXONE &&
-	    intf->cur_altsetting->desc.bInterfaceNumber != 0) {
+	    intf->cur_altsetting->desc.bInterfaceNumber != GIP_WIRED_INTF_DATA) {
 		/*
 		 * The Xbox One controller lists three interfaces all with the
 		 * same interface class, subclass and protocol. Differentiate by
diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index c2d69e33bf2b..63879d89c8c4 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -34,7 +34,7 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret;
+	int ret, table_size;
 	unsigned long flags;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct priv), GFP_KERNEL);
@@ -93,7 +93,30 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret < 0)
 		goto out_mcb_bus;
 
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size = ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mapbase, CHAM_HEADER_SIZE);
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res = devm_request_mem_region(&pdev->dev, priv->mapbase,
+						table_size,
+						KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret = -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base = devm_ioremap(&pdev->dev, priv->mapbase, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret = -ENOMEM;
+			goto out_mcb_bus;
+		}
+	}
 
 	mcb_bus_add_devices(priv->bus);
 
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index de3fc62810e6..0ead74c40a7b 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -706,7 +706,7 @@ static void netup_unidvb_dma_fini(struct netup_unidvb_dev *ndev, int num)
 	netup_unidvb_dma_enable(dma, 0);
 	msleep(50);
 	cancel_work_sync(&dma->work);
-	del_timer(&dma->timeout);
+	del_timer_sync(&dma->timeout);
 }
 
 static int netup_unidvb_dma_setup(struct netup_unidvb_dev *ndev)
diff --git a/drivers/media/radio/radio-shark.c b/drivers/media/radio/radio-shark.c
index 22f3466af2b1..5275180aed0b 100644
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
index 4d1a4b3d669c..5356941f54ae 100644
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
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 4728a42d54b8..edb1b5588b7a 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -831,7 +831,7 @@ static void r592_remove(struct pci_dev *pdev)
 	/* Stop the processing thread.
 	That ensures that we won't take any more requests */
 	kthread_stop(dev->io_thread);
-
+	del_timer_sync(&dev->detect_timer);
 	r592_enable_device(dev, false);
 
 	while (!error && dev->req) {
diff --git a/drivers/message/fusion/mptlan.c b/drivers/message/fusion/mptlan.c
index ebc00d47abf5..624803a887d8 100644
--- a/drivers/message/fusion/mptlan.c
+++ b/drivers/message/fusion/mptlan.c
@@ -1430,7 +1430,9 @@ mptlan_remove(struct pci_dev *pdev)
 {
 	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
 	struct net_device	*dev = ioc->netdev;
+	struct mpt_lan_priv *priv = netdev_priv(dev);
 
+	cancel_delayed_work_sync(&priv->post_buckets_task);
 	if(dev != NULL) {
 		unregister_netdev(dev);
 		free_netdev(dev);
diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index fe614ba5fec9..37217e01f27c 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -800,6 +800,7 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
+	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
diff --git a/drivers/net/ethernet/3com/3c589_cs.c b/drivers/net/ethernet/3com/3c589_cs.c
index 2b2695311bda..aab26dbe76ff 100644
--- a/drivers/net/ethernet/3com/3c589_cs.c
+++ b/drivers/net/ethernet/3com/3c589_cs.c
@@ -196,6 +196,7 @@ static int tc589_probe(struct pcmcia_device *link)
 {
 	struct el3_private *lp;
 	struct net_device *dev;
+	int ret;
 
 	dev_dbg(&link->dev, "3c589_attach()\n");
 
@@ -219,7 +220,15 @@ static int tc589_probe(struct pcmcia_device *link)
 
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
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 84bcb3ce00f7..d51857731314 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2980,7 +2980,7 @@ static int bcmgenet_open(struct net_device *dev)
 	return ret;
 }
 
-static void bcmgenet_netif_stop(struct net_device *dev)
+static void bcmgenet_netif_stop(struct net_device *dev, bool stop_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
@@ -2995,7 +2995,8 @@ static void bcmgenet_netif_stop(struct net_device *dev)
 	/* Disable MAC transmit. TX DMA disabled must be done before this */
 	umac_enable_set(priv, CMD_TX_EN, false);
 
-	phy_stop(dev->phydev);
+	if (stop_phy)
+		phy_stop(dev->phydev);
 	bcmgenet_disable_rx_napi(priv);
 	bcmgenet_intr_disable(priv);
 
@@ -3021,7 +3022,7 @@ static int bcmgenet_close(struct net_device *dev)
 
 	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
 
-	bcmgenet_netif_stop(dev);
+	bcmgenet_netif_stop(dev, false);
 
 	/* Really kill the PHY state machine and disconnect from it */
 	phy_disconnect(dev->phydev);
@@ -3721,7 +3722,7 @@ static int bcmgenet_suspend(struct device *d)
 
 	netif_device_detach(dev);
 
-	bcmgenet_netif_stop(dev);
+	bcmgenet_netif_stop(dev, true);
 
 	if (!device_may_wakeup(d))
 		phy_suspend(dev->phydev);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e97ab9545a79..e4162c2271e3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3721,7 +3721,9 @@ fec_drv_remove(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
-		return ret;
+		dev_err(&pdev->dev,
+			"Failed to resume device in remove callback (%pe)\n",
+			ERR_PTR(ret));
 
 	cancel_work_sync(&fep->tx_timeout_work);
 	fec_ptp_stop(pdev);
@@ -3734,8 +3736,13 @@ fec_drv_remove(struct platform_device *pdev)
 		of_phy_deregister_fixed_link(np);
 	of_node_put(fep->phy_node);
 
-	clk_disable_unprepare(fep->clk_ahb);
-	clk_disable_unprepare(fep->clk_ipg);
+	/* After pm_runtime_get_sync() failed, the clks are still off, so skip
+	 * disabling them again.
+	 */
+	if (ret >= 0) {
+		clk_disable_unprepare(fep->clk_ahb);
+		clk_disable_unprepare(fep->clk_ipg);
+	}
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index 79ee0a747260..4e69cb2c025f 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -425,7 +425,7 @@ void igb_mta_set(struct e1000_hw *hw, u32 hash_value)
 static u32 igb_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
 {
 	u32 hash_value, hash_mask;
-	u8 bit_shift = 0;
+	u8 bit_shift = 1;
 
 	/* Register count multiplied by bits per register */
 	hash_mask = (hw->mac.mta_reg_count * 32) - 1;
@@ -433,7 +433,7 @@ static u32 igb_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
 	/* For a mc_filter_type of 0, bit_shift is the number of left-shifts
 	 * where 0xFF would still fall within the hash mask.
 	 */
-	while (hash_mask >> bit_shift != 0xFF)
+	while (hash_mask >> bit_shift != 0xFF && bit_shift < 4)
 		bit_shift++;
 
 	/* The portion of the address that is used for the hash table
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 1d9b0d44ddb6..45be26dbdd11 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -6061,6 +6061,7 @@ static int nv_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 	return 0;
 
 out_error:
+	nv_mgmt_release_sema(dev);
 	if (phystate_orig)
 		writel(phystate|NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
 out_freering:
diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index e2c280913fbb..8238a7016159 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1435,7 +1435,7 @@ static void pasemi_mac_queue_csdesc(const struct sk_buff *skb,
 	write_dma_reg(PAS_DMA_TXCHAN_INCR(txring->chan.chno), 2);
 }
 
-static int pasemi_mac_start_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t pasemi_mac_start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct pasemi_mac * const mac = netdev_priv(dev);
 	struct pasemi_mac_txring * const txring = tx_ring(mac);
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index d323dd9daccb..a3a5edb8bc66 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -5138,6 +5138,8 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		cas_shutdown(cp);
 	mutex_unlock(&cp->pm_mutex);
 
+	vfree(cp->fw_data);
+
 	pci_iounmap(pdev, cp->regs);
 
 
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 63f0226b0a70..eb80d277b56f 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -443,6 +443,9 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
 		goto err;
 	}
 	skb_dst_set(skb, &rt->dst);
+
+	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+
 	err = ip_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		dev->stats.tx_errors++;
@@ -481,6 +484,9 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 		goto err;
 	}
 	skb_dst_set(skb, dst);
+
+	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+
 	err = ip6_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		dev->stats.tx_errors++;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index d77c1dbb5e19..1827be85f115 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1238,13 +1238,14 @@ static u16 brcmf_map_fw_linkdown_reason(const struct brcmf_event_msg *e)
 static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
 {
 	struct brcmf_wsec_pmk_le pmk;
-	int i, err;
+	int err;
+
+	memset(&pmk, 0, sizeof(pmk));
 
-	/* convert to firmware key format */
-	pmk.key_len = cpu_to_le16(pmk_len << 1);
-	pmk.flags = cpu_to_le16(BRCMF_WSEC_PASSPHRASE);
-	for (i = 0; i < pmk_len; i++)
-		snprintf(&pmk.key[2 * i], 3, "%02x", pmk_data[i]);
+	/* pass pmk directly */
+	pmk.key_len = cpu_to_le16(pmk_len);
+	pmk.flags = cpu_to_le16(0);
+	memcpy(pmk.key, pmk_data, pmk_len);
 
 	/* store psk in firmware */
 	err = brcmf_fil_cmd_data_set(ifp, BRCMF_C_SET_WSEC_PMK,
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
index de6ec9b7ace4..f30bac02d32c 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -1101,6 +1101,7 @@ static int iwlagn_send_sta_key(struct iwl_priv *priv,
 {
 	__le16 key_flags;
 	struct iwl_addsta_cmd sta_cmd;
+	size_t to_copy;
 	int i;
 
 	spin_lock_bh(&priv->sta_lock);
@@ -1120,7 +1121,9 @@ static int iwlagn_send_sta_key(struct iwl_priv *priv,
 		sta_cmd.key.tkip_rx_tsc_byte2 = tkip_iv32;
 		for (i = 0; i < 5; i++)
 			sta_cmd.key.tkip_rx_ttak[i] = cpu_to_le16(tkip_p1k[i]);
-		memcpy(sta_cmd.key.key, keyconf->key, keyconf->keylen);
+		/* keyconf may contain MIC rx/tx keys which iwl does not use */
+		to_copy = min_t(size_t, sizeof(sta_cmd.key.key), keyconf->keylen);
+		memcpy(sta_cmd.key.key, keyconf->key, to_copy);
 		break;
 	case WLAN_CIPHER_SUITE_WEP104:
 		key_flags |= STA_KEY_FLG_KEY_SIZE_MSK;
diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
index 213e2e15339c..fe23432e5b1a 100644
--- a/drivers/phy/st/phy-miphy28lp.c
+++ b/drivers/phy/st/phy-miphy28lp.c
@@ -13,6 +13,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -488,19 +489,11 @@ static inline void miphy28lp_pcie_config_gen(struct miphy28lp_phy *miphy_phy)
 
 static inline int miphy28lp_wait_compensation(struct miphy28lp_phy *miphy_phy)
 {
-	unsigned long finish = jiffies + 5 * HZ;
 	u8 val;
 
 	/* Waiting for Compensation to complete */
-	do {
-		val = readb_relaxed(miphy_phy->base + MIPHY_COMP_FSM_6);
-
-		if (time_after_eq(jiffies, finish))
-			return -EBUSY;
-		cpu_relax();
-	} while (!(val & COMP_DONE));
-
-	return 0;
+	return readb_relaxed_poll_timeout(miphy_phy->base + MIPHY_COMP_FSM_6,
+					  val, val & COMP_DONE, 1, 5 * USEC_PER_SEC);
 }
 
 
@@ -809,7 +802,6 @@ static inline void miphy28lp_configure_usb3(struct miphy28lp_phy *miphy_phy)
 
 static inline int miphy_is_ready(struct miphy28lp_phy *miphy_phy)
 {
-	unsigned long finish = jiffies + 5 * HZ;
 	u8 mask = HFC_PLL | HFC_RDY;
 	u8 val;
 
@@ -820,21 +812,14 @@ static inline int miphy_is_ready(struct miphy28lp_phy *miphy_phy)
 	if (miphy_phy->type == PHY_TYPE_SATA)
 		mask |= PHY_RDY;
 
-	do {
-		val = readb_relaxed(miphy_phy->base + MIPHY_STATUS_1);
-		if ((val & mask) != mask)
-			cpu_relax();
-		else
-			return 0;
-	} while (!time_after_eq(jiffies, finish));
-
-	return -EBUSY;
+	return readb_relaxed_poll_timeout(miphy_phy->base + MIPHY_STATUS_1,
+					  val, (val & mask) == mask, 1,
+					  5 * USEC_PER_SEC);
 }
 
 static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
 {
 	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
-	unsigned long finish = jiffies + 5 * HZ;
 	u32 val;
 
 	if (!miphy_phy->osc_rdy)
@@ -843,17 +828,10 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
 	if (!miphy_phy->syscfg_reg[SYSCFG_STATUS])
 		return -EINVAL;
 
-	do {
-		regmap_read(miphy_dev->regmap,
-				miphy_phy->syscfg_reg[SYSCFG_STATUS], &val);
-
-		if ((val & MIPHY_OSC_RDY) != MIPHY_OSC_RDY)
-			cpu_relax();
-		else
-			return 0;
-	} while (!time_after_eq(jiffies, finish));
-
-	return -EBUSY;
+	return regmap_read_poll_timeout(miphy_dev->regmap,
+					miphy_phy->syscfg_reg[SYSCFG_STATUS],
+					val, val & MIPHY_OSC_RDY, 1,
+					5 * USEC_PER_SEC);
 }
 
 static int miphy28lp_get_resource_byname(struct device_node *child,
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index b7dc88126866..b44776bb1da8 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1551,7 +1551,7 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
-void bq27xxx_battery_update(struct bq27xxx_device_info *di)
+static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 {
 	struct bq27xxx_reg_cache cache = {0, };
 	bool has_ci_flag = di->opts & BQ27XXX_O_ZERO;
@@ -1599,6 +1599,16 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 		di->cache = cache;
 
 	di->last_update = jiffies;
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
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
 
@@ -1609,9 +1619,6 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 				     work.work);
 
 	bq27xxx_battery_update(di);
-
-	if (poll_interval > 0)
-		schedule_delayed_work(&di->work, poll_interval * HZ);
 }
 
 /*
@@ -1772,10 +1779,8 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
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
@@ -1912,22 +1917,18 @@ EXPORT_SYMBOL_GPL(bq27xxx_battery_setup);
 
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
index 06dd5077104c..0fbc221ee50e 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -187,7 +187,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, di);
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = request_threaded_irq(client->irq,
 				NULL, bq27xxx_battery_irq_handler_thread,
 				IRQF_ONESHOT,
 				di->name, di);
@@ -217,6 +217,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
+	free_irq(client->irq, di);
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);
diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index 2277ad9c2f68..9188b7ccdd4c 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -35,8 +35,9 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
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
index 15947dbb511e..0f9cc82d8161 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -29,7 +29,7 @@
 #define SBS_CHARGER_REG_STATUS			0x13
 #define SBS_CHARGER_REG_ALARM_WARNING		0x16
 
-#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(1)
+#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(0)
 #define SBS_CHARGER_STATUS_RES_COLD		BIT(9)
 #define SBS_CHARGER_STATUS_RES_HOT		BIT(10)
 #define SBS_CHARGER_STATUS_BATTERY_PRESENT	BIT(14)
diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index ed60b8d4efe6..f98dc3a8e3c7 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -88,15 +88,15 @@ enum qdio_irq_states {
 static inline int do_sqbs(u64 token, unsigned char state, int queue,
 			  int *start, int *count)
 {
-	register unsigned long _ccq asm ("0") = *count;
-	register unsigned long _token asm ("1") = token;
 	unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
+	unsigned long _ccq = *count;
 
 	asm volatile(
-		"	.insn	rsy,0xeb000000008A,%1,0,0(%2)"
-		: "+d" (_ccq), "+d" (_queuestart)
-		: "d" ((unsigned long)state), "d" (_token)
-		: "memory", "cc");
+		"	lgr	1,%[token]\n"
+		"	.insn	rsy,0xeb000000008a,%[qs],%[ccq],0(%[state])"
+		: [ccq] "+&d" (_ccq), [qs] "+&d" (_queuestart)
+		: [state] "a" ((unsigned long)state), [token] "d" (token)
+		: "memory", "cc", "1");
 	*count = _ccq & 0xff;
 	*start = _queuestart & 0xff;
 
@@ -106,16 +106,17 @@ static inline int do_sqbs(u64 token, unsigned char state, int queue,
 static inline int do_eqbs(u64 token, unsigned char *state, int queue,
 			  int *start, int *count, int ack)
 {
-	register unsigned long _ccq asm ("0") = *count;
-	register unsigned long _token asm ("1") = token;
 	unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
 	unsigned long _state = (unsigned long)ack << 63;
+	unsigned long _ccq = *count;
 
 	asm volatile(
-		"	.insn	rrf,0xB99c0000,%1,%2,0,0"
-		: "+d" (_ccq), "+d" (_queuestart), "+d" (_state)
-		: "d" (_token)
-		: "memory", "cc");
+		"	lgr	1,%[token]\n"
+		"	.insn	rrf,0xb99c0000,%[qs],%[state],%[ccq],0"
+		: [ccq] "+&d" (_ccq), [qs] "+&d" (_queuestart),
+		  [state] "+&d" (_state)
+		: [token] "d" (token)
+		: "memory", "cc", "1");
 	*count = _ccq & 0xff;
 	*start = _queuestart & 0xff;
 	*state = _state & 0xff;
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 4b7cc8d425b1..6100cf4df54b 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -31,38 +31,41 @@ MODULE_DESCRIPTION("QDIO base support");
 MODULE_LICENSE("GPL");
 
 static inline int do_siga_sync(unsigned long schid,
-			       unsigned int out_mask, unsigned int in_mask,
+			       unsigned long out_mask, unsigned long in_mask,
 			       unsigned int fc)
 {
-	register unsigned long __fc asm ("0") = fc;
-	register unsigned long __schid asm ("1") = schid;
-	register unsigned long out asm ("2") = out_mask;
-	register unsigned long in asm ("3") = in_mask;
 	int cc;
 
 	asm volatile(
+		"	lgr	0,%[fc]\n"
+		"	lgr	1,%[schid]\n"
+		"	lgr	2,%[out]\n"
+		"	lgr	3,%[in]\n"
 		"	siga	0\n"
-		"	ipm	%0\n"
-		"	srl	%0,28\n"
-		: "=d" (cc)
-		: "d" (__fc), "d" (__schid), "d" (out), "d" (in) : "cc");
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		: [cc] "=&d" (cc)
+		: [fc] "d" (fc), [schid] "d" (schid),
+		  [out] "d" (out_mask), [in] "d" (in_mask)
+		: "cc", "0", "1", "2", "3");
 	return cc;
 }
 
-static inline int do_siga_input(unsigned long schid, unsigned int mask,
-				unsigned int fc)
+static inline int do_siga_input(unsigned long schid, unsigned long mask,
+				unsigned long fc)
 {
-	register unsigned long __fc asm ("0") = fc;
-	register unsigned long __schid asm ("1") = schid;
-	register unsigned long __mask asm ("2") = mask;
 	int cc;
 
 	asm volatile(
+		"	lgr	0,%[fc]\n"
+		"	lgr	1,%[schid]\n"
+		"	lgr	2,%[mask]\n"
 		"	siga	0\n"
-		"	ipm	%0\n"
-		"	srl	%0,28\n"
-		: "=d" (cc)
-		: "d" (__fc), "d" (__schid), "d" (__mask) : "cc");
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		: [cc] "=&d" (cc)
+		: [fc] "d" (fc), [schid] "d" (schid), [mask] "d" (mask)
+		: "cc", "0", "1", "2");
 	return cc;
 }
 
@@ -78,23 +81,24 @@ static inline int do_siga_input(unsigned long schid, unsigned int mask,
  * Note: For IQDC unicast queues only the highest priority queue is processed.
  */
 static inline int do_siga_output(unsigned long schid, unsigned long mask,
-				 unsigned int *bb, unsigned int fc,
+				 unsigned int *bb, unsigned long fc,
 				 unsigned long aob)
 {
-	register unsigned long __fc asm("0") = fc;
-	register unsigned long __schid asm("1") = schid;
-	register unsigned long __mask asm("2") = mask;
-	register unsigned long __aob asm("3") = aob;
 	int cc;
 
 	asm volatile(
+		"	lgr	0,%[fc]\n"
+		"	lgr	1,%[schid]\n"
+		"	lgr	2,%[mask]\n"
+		"	lgr	3,%[aob]\n"
 		"	siga	0\n"
-		"	ipm	%0\n"
-		"	srl	%0,28\n"
-		: "=d" (cc), "+d" (__fc), "+d" (__aob)
-		: "d" (__schid), "d" (__mask)
-		: "cc");
-	*bb = __fc >> 31;
+		"	lgr	%[fc],0\n"
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		: [cc] "=&d" (cc), [fc] "+&d" (fc)
+		: [schid] "d" (schid), [mask] "d" (mask), [aob] "d" (aob)
+		: "cc", "0", "1", "2", "3");
+	*bb = fc >> 31;
 	return cc;
 }
 
diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 8f7b26ec181e..0485593dc2f5 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -25,6 +25,7 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
+#include <linux/byteorder/generic.h>
 
 #include "spi-fsl-cpm.h"
 #include "spi-fsl-lib.h"
@@ -124,6 +125,21 @@ int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 		mspi->rx_dma = mspi->dma_dummy_rx;
 		mspi->map_rx_dma = 0;
 	}
+	if (t->bits_per_word == 16 && t->tx_buf) {
+		const u16 *src = t->tx_buf;
+		u16 *dst;
+		int i;
+
+		dst = kmalloc(t->len, GFP_KERNEL);
+		if (!dst)
+			return -ENOMEM;
+
+		for (i = 0; i < t->len >> 1; i++)
+			dst[i] = cpu_to_le16p(src + i);
+
+		mspi->tx = dst;
+		mspi->map_tx_dma = 1;
+	}
 
 	if (mspi->map_tx_dma) {
 		void *nonconst_tx = (void *)mspi->tx; /* shut up gcc */
@@ -177,6 +193,13 @@ void fsl_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi)
 	if (mspi->map_rx_dma)
 		dma_unmap_single(dev, mspi->rx_dma, t->len, DMA_FROM_DEVICE);
 	mspi->xfer_in_progress = NULL;
+
+	if (t->bits_per_word == 16 && t->rx_buf) {
+		int i;
+
+		for (i = 0; i < t->len; i += 2)
+			le16_to_cpus(t->rx_buf + i);
+	}
 }
 EXPORT_SYMBOL_GPL(fsl_spi_cpm_bufs_complete);
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 479d10dc6cb8..5e49fed487f8 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -201,26 +201,6 @@ static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	return bits_per_word;
 }
 
-static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
-				struct spi_device *spi,
-				int bits_per_word)
-{
-	/* CPM/QE uses Little Endian for words > 8
-	 * so transform 16 and 32 bits words into 8 bits
-	 * Unfortnatly that doesn't work for LSB so
-	 * reject these for now */
-	/* Note: 32 bits word, LSB works iff
-	 * tfcr/rfcr is set to CPMFCR_GBL */
-	if (spi->mode & SPI_LSB_FIRST &&
-	    bits_per_word > 8)
-		return -EINVAL;
-	if (bits_per_word <= 8)
-		return bits_per_word;
-	if (bits_per_word == 16 || bits_per_word == 32)
-		return 8; /* pretend its 8 bits */
-	return -EINVAL;
-}
-
 static int fsl_spi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -248,9 +228,6 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else
-		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
-							  bits_per_word);
 
 	if (bits_per_word < 0)
 		return bits_per_word;
@@ -357,12 +334,44 @@ static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
 static int fsl_spi_do_one_msg(struct spi_master *master,
 			      struct spi_message *m)
 {
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs = 50;
 	int status;
 
+	/*
+	 * In CPU mode, optimize large byte transfers to use larger
+	 * bits_per_word values to reduce number of interrupts taken.
+	 */
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
+			if (t->len < 256 || t->bits_per_word != 8)
+				continue;
+			if ((t->len & 3) == 0)
+				t->bits_per_word = 32;
+			else if ((t->len & 1) == 0)
+				t->bits_per_word = 16;
+		} else {
+			/*
+			 * CPM/QE uses Little Endian for words > 8
+			 * so transform 16 and 32 bits words into 8 bits
+			 * Unfortnatly that doesn't work for LSB so
+			 * reject these for now
+			 * Note: 32 bits word, LSB works iff
+			 * tfcr/rfcr is set to CPMFCR_GBL
+			 */
+			if (m->spi->mode & SPI_LSB_FIRST && t->bits_per_word > 8)
+				return -EINVAL;
+			if (t->bits_per_word == 16 || t->bits_per_word == 32)
+				t->bits_per_word = 8; /* pretend its 8 bits */
+			if (t->bits_per_word == 8 && t->len >= 256 &&
+			    (mpc8xxx_spi->flags & SPI_CPM1))
+				t->bits_per_word = 16;
+		}
+	}
+
 	/* Don't allow changes if CS is active */
 	first = list_first_entry(&m->transfers, struct spi_transfer,
 			transfer_list);
@@ -642,8 +651,14 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 	if (mpc8xxx_spi->type == TYPE_GRLIB)
 		fsl_spi_grlib_probe(dev);
 
-	master->bits_per_word_mask =
-		(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32)) &
+	if (mpc8xxx_spi->flags & SPI_CPM_MODE)
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 8) | SPI_BPW_MASK(16) | SPI_BPW_MASK(32));
+	else
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32));
+
+	master->bits_per_word_mask &=
 		SPI_BPW_RANGE_MASK(1, mpc8xxx_spi->max_bits_per_word);
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index ec2296a4c44d..1ad4b69292ad 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -237,6 +237,18 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	return true;
 }
 
+/*
+ * Note the number of natively supported chip selects for MX51 is 4. Some
+ * devices may have less actual SS pins but the register map supports 4. When
+ * using gpio chip selects the cs values passed into the macros below can go
+ * outside the range 0 - 3. We therefore need to limit the cs value to avoid
+ * corrupting bits outside the allocated locations.
+ *
+ * The simplest way to do this is to just mask the cs bits to 2 bits. This
+ * still allows all 4 native chip selects to work as well as gpio chip selects
+ * (which can use any of the 4 chip select configurations).
+ */
+
 #define MX51_ECSPI_CTRL		0x08
 #define MX51_ECSPI_CTRL_ENABLE		(1 <<  0)
 #define MX51_ECSPI_CTRL_XCH		(1 <<  2)
@@ -245,16 +257,16 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CTRL_DRCTL(drctl)	((drctl) << 16)
 #define MX51_ECSPI_CTRL_POSTDIV_OFFSET	8
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
-#define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
+#define MX51_ECSPI_CTRL_CS(cs)		((cs & 3) << 18)
 #define MX51_ECSPI_CTRL_BL_OFFSET	20
 #define MX51_ECSPI_CTRL_BL_MASK		(0xfff << 20)
 
 #define MX51_ECSPI_CONFIG	0x0c
-#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
-#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
-#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
-#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
-#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs) + 20))
+#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs & 3) +  0))
+#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs & 3) +  4))
+#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs & 3) +  8))
+#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs & 3) + 12))
+#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs & 3) + 20))
 
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index d5ef1986bde4..0afe4ed9ca88 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -61,9 +61,9 @@ static const struct rtl819x_ops rtl819xp_ops = {
 };
 
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
-	{RTL_PCI_DEVICE(0x10ec, 0x8192, rtl819xp_ops)},
-	{RTL_PCI_DEVICE(0x07aa, 0x0044, rtl819xp_ops)},
-	{RTL_PCI_DEVICE(0x07aa, 0x0047, rtl819xp_ops)},
+	{PCI_DEVICE(0x10ec, 0x8192)},
+	{PCI_DEVICE(0x07aa, 0x0044)},
+	{PCI_DEVICE(0x07aa, 0x0047)},
 	{}
 };
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 866fe4d4cb28..964cc5b8eb91 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -67,11 +67,6 @@
 #define IS_HARDWARE_TYPE_8192SE(_priv)		\
 	(((struct r8192_priv *)rtllib_priv(dev))->card_8192 == NIC_8192SE)
 
-#define RTL_PCI_DEVICE(vend, dev, cfg) \
-	.vendor = (vend), .device = (dev), \
-	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
-	.driver_data = (kernel_ulong_t)&(cfg)
-
 #define TOTAL_CAM_ENTRY		32
 #define CAM_CONTENT_COUNT	8
 
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index d2df7d71d666..a0325af2832a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1125,6 +1125,7 @@ void serial8250_unregister_port(int line)
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
 		uart->capabilities = 0;
+		serial8250_init_port(uart);
 		serial8250_apply_quirks(uart);
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index fd9dd800e1a6..274e644f34f2 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1648,6 +1648,8 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define PCI_SUBDEVICE_ID_SIIG_DUAL_30	0x2530
 #define PCI_VENDOR_ID_ADVANTECH		0x13fe
 #define PCI_DEVICE_ID_INTEL_CE4100_UART 0x2e66
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600	0x1600
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600_1611	0x1611
 #define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
 #define PCI_DEVICE_ID_ADVANTECH_PCI3618	0x3618
 #define PCI_DEVICE_ID_ADVANTECH_PCIf618	0xf618
@@ -3840,6 +3842,9 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
 			 pciserial_resume_one);
 
 static const struct pci_device_id serial_pci_tbl[] = {
+	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI1600,
+		PCI_DEVICE_ID_ADVANTECH_PCI1600_1611, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
 	/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
 	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
 		PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index d904a3a345e7..dd4be3c8c049 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -613,10 +613,11 @@ static int arc_serial_probe(struct platform_device *pdev)
 	}
 	uart->baud = val;
 
-	port->membase = of_iomap(np, 0);
-	if (!port->membase)
+	port->membase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(port->membase)) {
 		/* No point of dev_err since UART itself is hosed here */
-		return -ENXIO;
+		return PTR_ERR(port->membase);
+	}
 
 	port->irq = irq_of_parse_and_map(np, 0);
 
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 28bc9c70de3e..78ea9b9c6450 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -182,39 +182,47 @@ vcs_vc(struct inode *inode, int *viewed)
 	return vc_cons[currcons].d;
 }
 
-/*
- * Returns size for VC carried by inode.
+/**
+ * vcs_size -- return size for a VC in @vc
+ * @vc: which VC
+ * @attr: does it use attributes?
+ * @unicode: is it unicode?
+ *
  * Must be called with console_lock.
  */
-static int
-vcs_size(struct inode *inode)
+static int vcs_size(const struct vc_data *vc, bool attr, bool unicode)
 {
 	int size;
-	struct vc_data *vc;
 
 	WARN_CONSOLE_UNLOCKED();
 
-	vc = vcs_vc(inode, NULL);
-	if (!vc)
-		return -ENXIO;
-
 	size = vc->vc_rows * vc->vc_cols;
 
-	if (use_attributes(inode)) {
-		if (use_unicode(inode))
+	if (attr) {
+		if (unicode)
 			return -EOPNOTSUPP;
-		size = 2*size + HEADER_SIZE;
-	} else if (use_unicode(inode))
+
+		size = 2 * size + HEADER_SIZE;
+	} else if (unicode)
 		size *= 4;
+
 	return size;
 }
 
 static loff_t vcs_lseek(struct file *file, loff_t offset, int orig)
 {
+	struct inode *inode = file_inode(file);
+	struct vc_data *vc;
 	int size;
 
 	console_lock();
-	size = vcs_size(file_inode(file));
+	vc = vcs_vc(inode, NULL);
+	if (!vc) {
+		console_unlock();
+		return -ENXIO;
+	}
+
+	size = vcs_size(vc, use_attributes(inode), use_unicode(inode));
 	console_unlock();
 	if (size < 0)
 		return size;
@@ -276,7 +284,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 * as copy_to_user at the end of this loop
 		 * could sleep.
 		 */
-		size = vcs_size(inode);
+		size = vcs_size(vc, attr, uni_mode);
 		if (size < 0) {
 			ret = size;
 			break;
@@ -457,7 +465,11 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (!vc)
 		goto unlock_out;
 
-	size = vcs_size(inode);
+	size = vcs_size(vc, attr, false);
+	if (size < 0) {
+		ret = size;
+		goto unlock_out;
+	}
 	ret = -EINVAL;
 	if (pos < 0 || pos > size)
 		goto unlock_out;
@@ -492,11 +504,18 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 			}
 		}
 
-		/* The vcs_size might have changed while we slept to grab
-		 * the user buffer, so recheck.
+		/* The vc might have been freed or vcs_size might have changed
+		 * while we slept to grab the user buffer, so recheck.
 		 * Return data written up to now on failure.
 		 */
-		size = vcs_size(inode);
+		vc = vcs_vc(inode, &viewed);
+		if (!vc) {
+			if (written)
+				break;
+			ret = -ENXIO;
+			goto unlock_out;
+		}
+		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)
 				break;
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 4ebfbd737905..c369920b4854 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -209,6 +209,82 @@ int usb_find_common_endpoints_reverse(struct usb_host_interface *alt,
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
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 2fe91f120bb1..7d9a551c47f9 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -17,6 +17,8 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
+#include <linux/string_helpers.h>
+#include <linux/usb/composite.h>
 
 #include "u_ether.h"
 
@@ -102,41 +104,6 @@ static inline int qlen(struct usb_gadget *gadget, unsigned qmult)
 
 /*-------------------------------------------------------------------------*/
 
-/* REVISIT there must be a better way than having two sets
- * of debug calls ...
- */
-
-#undef DBG
-#undef VDBG
-#undef ERROR
-#undef INFO
-
-#define xprintk(d, level, fmt, args...) \
-	printk(level "%s: " fmt , (d)->net->name , ## args)
-
-#ifdef DEBUG
-#undef DEBUG
-#define DBG(dev, fmt, args...) \
-	xprintk(dev , KERN_DEBUG , fmt , ## args)
-#else
-#define DBG(dev, fmt, args...) \
-	do { } while (0)
-#endif /* DEBUG */
-
-#ifdef VERBOSE_DEBUG
-#define VDBG	DBG
-#else
-#define VDBG(dev, fmt, args...) \
-	do { } while (0)
-#endif /* DEBUG */
-
-#define ERROR(dev, fmt, args...) \
-	xprintk(dev , KERN_ERR , fmt , ## args)
-#define INFO(dev, fmt, args...) \
-	xprintk(dev , KERN_INFO , fmt , ## args)
-
-/*-------------------------------------------------------------------------*/
-
 /* NETWORK DRIVER HOOKUP (to the layer above this driver) */
 
 static void eth_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *p)
@@ -974,6 +941,8 @@ int gether_get_host_addr_cdc(struct net_device *net, char *host_addr, int len)
 	dev = netdev_priv(net);
 	snprintf(host_addr, len, "%pm", dev->host_mac);
 
+	string_upper(host_addr, host_addr);
+
 	return strlen(host_addr);
 }
 EXPORT_SYMBOL_GPL(gether_get_host_addr_cdc);
diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index 4877bf82ad39..6a68a9f8d57f 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -3016,6 +3016,20 @@ static int sisusb_probe(struct usb_interface *intf,
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
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index f287ee8183df..abeadc7c2673 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -392,22 +392,25 @@ static DEF_SCSI_QCMD(queuecommand)
  ***********************************************************************/
 
 /* Command timeout and abort */
-static int command_abort(struct scsi_cmnd *srb)
+static int command_abort_matching(struct us_data *us, struct scsi_cmnd *srb_match)
 {
-	struct us_data *us = host_to_us(srb->device->host);
-
-	usb_stor_dbg(us, "%s called\n", __func__);
-
 	/*
 	 * us->srb together with the TIMED_OUT, RESETTING, and ABORTING
 	 * bits are protected by the host lock.
 	 */
 	scsi_lock(us_to_host(us));
 
-	/* Is this command still active? */
-	if (us->srb != srb) {
+	/* is there any active pending command to abort ? */
+	if (!us->srb) {
 		scsi_unlock(us_to_host(us));
 		usb_stor_dbg(us, "-- nothing to abort\n");
+		return SUCCESS;
+	}
+
+	/* Does the command match the passed srb if any ? */
+	if (srb_match && us->srb != srb_match) {
+		scsi_unlock(us_to_host(us));
+		usb_stor_dbg(us, "-- pending command mismatch\n");
 		return FAILED;
 	}
 
@@ -430,6 +433,14 @@ static int command_abort(struct scsi_cmnd *srb)
 	return SUCCESS;
 }
 
+static int command_abort(struct scsi_cmnd *srb)
+{
+	struct us_data *us = host_to_us(srb->device->host);
+
+	usb_stor_dbg(us, "%s called\n", __func__);
+	return command_abort_matching(us, srb);
+}
+
 /*
  * This invokes the transport reset mechanism to reset the state of the
  * device
@@ -441,6 +452,9 @@ static int device_reset(struct scsi_cmnd *srb)
 
 	usb_stor_dbg(us, "%s called\n", __func__);
 
+	/* abort any pending command before reset */
+	command_abort_matching(us, NULL);
+
 	/* lock the device pointers and do the reset */
 	mutex_lock(&(us->dev_mutex));
 	result = us->transport_reset(us);
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 7387f52cb58d..bc09de5ea17d 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -501,6 +501,10 @@ static ssize_t pin_assignment_show(struct device *dev,
 
 	mutex_unlock(&dp->lock);
 
+	/* get_current_pin_assignments can return 0 when no matching pin assignments are found */
+	if (len == 0)
+		len++;
+
 	buf[len - 1] = '\n';
 	return len;
 }
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index e4308f97d973..0fdae44c9b8c 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -1006,7 +1006,21 @@ static bool svdm_consume_svids(struct tcpm_port *port, const __le32 *payload,
 		pmdata->svids[pmdata->nsvids++] = svid;
 		tcpm_log(port, "SVID %d: 0x%x", pmdata->nsvids, svid);
 	}
-	return true;
+
+	/*
+	 * PD3.0 Spec 6.4.4.3.2: The SVIDs are returned 2 per VDO (see Table
+	 * 6-43), and can be returned maximum 6 VDOs per response (see Figure
+	 * 6-19). If the Respondersupports 12 or more SVID then the Discover
+	 * SVIDs Command Shall be executed multiple times until a Discover
+	 * SVIDs VDO is returned ending either with a SVID value of 0x0000 in
+	 * the last part of the last VDO or with a VDO containing two SVIDs
+	 * with values of 0x0000.
+	 *
+	 * However, some odd dockers support SVIDs less than 12 but without
+	 * 0x0000 in the last VDO, so we need to break the Discover SVIDs
+	 * request and return false here.
+	 */
+	return cnt == 7;
 abort:
 	tcpm_log(port, "SVID_DISCOVERY_MAX(%d) too low!", SVID_DISCOVERY_MAX);
 	return false;
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index f94bb6034a5a..3441371a4ab4 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -330,8 +330,10 @@ static struct sock_mapping *pvcalls_new_active_socket(
 	void *page;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
-	if (map == NULL)
+	if (map == NULL) {
+		sock_release(sock);
 		return NULL;
+	}
 
 	map->fedata = fedata;
 	map->sock = sock;
@@ -423,10 +425,8 @@ static int pvcalls_back_connect(struct xenbus_device *dev,
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
@@ -567,7 +567,6 @@ static void __pvcalls_back_accept(struct work_struct *work)
 					sock);
 	if (!map) {
 		ret = -EFAULT;
-		sock_release(sock);
 		goto out_error;
 	}
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 98f87cc47433..437ca4691967 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4348,7 +4348,11 @@ static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
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
@@ -4466,7 +4470,12 @@ static void btrfs_cleanup_bg_io(struct btrfs_block_group_cache *cache)
 
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
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6511cb71986c..b623e9f3b4c4 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -783,15 +783,16 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			}
 			spin_lock(&ctl->tree_lock);
 			ret = link_free_space(ctl, e);
-			ctl->total_bitmaps++;
-			ctl->op->recalc_thresholds(ctl);
-			spin_unlock(&ctl->tree_lock);
 			if (ret) {
+				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
+			ctl->total_bitmaps++;
+			ctl->op->recalc_thresholds(ctl);
+			spin_unlock(&ctl->tree_lock);
 			list_add_tail(&e->list, &bitmaps);
 		}
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f314b2c2d148..e4a4074ef33d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6620,7 +6620,7 @@ static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_ino(root, &objectid);
+	err = btrfs_find_free_objectid(root, &objectid);
 	if (err)
 		goto out_unlock;
 
@@ -6684,7 +6684,7 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_ino(root, &objectid);
+	err = btrfs_find_free_objectid(root, &objectid);
 	if (err)
 		goto out_unlock;
 
@@ -6837,7 +6837,7 @@ static int btrfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_ino(root, &objectid);
+	err = btrfs_find_free_objectid(root, &objectid);
 	if (err)
 		goto out_fail;
 
@@ -9819,7 +9819,7 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	u64 objectid;
 	u64 index;
 
-	ret = btrfs_find_free_ino(root, &objectid);
+	ret = btrfs_find_free_objectid(root, &objectid);
 	if (ret)
 		return ret;
 
@@ -10316,7 +10316,7 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_ino(root, &objectid);
+	err = btrfs_find_free_objectid(root, &objectid);
 	if (err)
 		goto out_unlock;
 
@@ -10600,7 +10600,7 @@ static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_find_free_ino(root, &objectid);
+	ret = btrfs_find_free_objectid(root, &objectid);
 	if (ret)
 		goto out;
 
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index a5ef8275440d..07db34ffa7a1 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -976,6 +976,19 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 				continue;
 			adjust_snap_realm_parent(mdsc, child, realm->ino);
 		}
+	} else {
+		/*
+		 * In the non-split case both 'num_split_inos' and
+		 * 'num_split_realms' should be 0, making this a no-op.
+		 * However the MDS happens to populate 'split_realms' list
+		 * in one of the UPDATE op cases by mistake.
+		 *
+		 * Skip both lists just in case to ensure that 'p' is
+		 * positioned at the start of realm info, as expected by
+		 * ceph_update_snap_trace().
+		 */
+		p += sizeof(u64) * num_split_inos;
+		p += sizeof(u64) * num_split_realms;
 	}
 
 	/*
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 00e759f05161..a203a5723e2c 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -177,6 +177,7 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_MIN_BLOCK_SIZE		1024
 #define	EXT2_MAX_BLOCK_SIZE		4096
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define EXT2_MAX_BLOCK_LOG_SIZE		  16
 #define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
 #define EXT2_BLOCK_SIZE_BITS(s)		((s)->s_blocksize_bits)
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 44a1f356aca2..3349ce85d27c 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -978,6 +978,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
+	if (le32_to_cpu(es->s_log_block_size) >
+	    (EXT2_MAX_BLOCK_LOG_SIZE - BLOCK_SIZE_BITS)) {
+		ext2_msg(sb, KERN_ERR,
+			 "Invalid log block size: %u",
+			 le32_to_cpu(es->s_log_block_size));
+		goto failed_mount;
+	}
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (sbi->s_mount_opt & EXT2_MOUNT_DAX) {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 70e1121d0a30..23e56c1ffc1b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3089,6 +3089,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 				struct ext4_allocation_request *ar)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
 	ext4_lblk_t end;
 	loff_t size, start_off;
@@ -3269,18 +3270,21 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);
 
 	/* define goal start in order to merge */
-	if (ar->pright && (ar->lright == (start + size))) {
+	if (ar->pright && (ar->lright == (start + size)) &&
+	    ar->pright >= size &&
+	    ar->pright - size >= le32_to_cpu(es->s_first_data_block)) {
 		/* merge to the right */
 		ext4_get_group_no_and_offset(ac->ac_sb, ar->pright - size,
-						&ac->ac_f_ex.fe_group,
-						&ac->ac_f_ex.fe_start);
+						&ac->ac_g_ex.fe_group,
+						&ac->ac_g_ex.fe_start);
 		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
 	}
-	if (ar->pleft && (ar->lleft + 1 == start)) {
+	if (ar->pleft && (ar->lleft + 1 == start) &&
+	    ar->pleft + 1 < ext4_blocks_count(es)) {
 		/* merge to the left */
 		ext4_get_group_no_and_offset(ac->ac_sb, ar->pleft + 1,
-						&ac->ac_f_ex.fe_group,
-						&ac->ac_f_ex.fe_start);
+						&ac->ac_g_ex.fe_group,
+						&ac->ac_g_ex.fe_start);
 		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
 	}
 
@@ -3372,6 +3376,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
 	BUG_ON(start < pa->pa_pstart);
 	BUG_ON(end > pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len));
 	BUG_ON(pa->pa_free < len);
+	BUG_ON(ac->ac_b_ex.fe_len <= 0);
 	pa->pa_free -= len;
 
 	mb_debug(1, "use %llu/%u from inode pa %p\n", start, len, pa);
@@ -3676,10 +3681,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		return -ENOMEM;
 
 	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len) {
-		int winl;
-		int wins;
-		int win;
-		int offs;
+		int new_bex_start;
+		int new_bex_end;
 
 		/* we can't allocate as much as normalizer wants.
 		 * so, found space must get proper lstart
@@ -3687,26 +3690,40 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		BUG_ON(ac->ac_g_ex.fe_logical > ac->ac_o_ex.fe_logical);
 		BUG_ON(ac->ac_g_ex.fe_len < ac->ac_o_ex.fe_len);
 
-		/* we're limited by original request in that
-		 * logical block must be covered any way
-		 * winl is window we can move our chunk within */
-		winl = ac->ac_o_ex.fe_logical - ac->ac_g_ex.fe_logical;
+		/*
+		 * Use the below logic for adjusting best extent as it keeps
+		 * fragmentation in check while ensuring logical range of best
+		 * extent doesn't overflow out of goal extent:
+		 *
+		 * 1. Check if best ex can be kept at end of goal and still
+		 *    cover original start
+		 * 2. Else, check if best ex can be kept at start of goal and
+		 *    still cover original start
+		 * 3. Else, keep the best ex at start of original request.
+		 */
+		new_bex_end = ac->ac_g_ex.fe_logical +
+			EXT4_C2B(sbi, ac->ac_g_ex.fe_len);
+		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+		if (ac->ac_o_ex.fe_logical >= new_bex_start)
+			goto adjust_bex;
 
-		/* also, we should cover whole original request */
-		wins = EXT4_C2B(sbi, ac->ac_b_ex.fe_len - ac->ac_o_ex.fe_len);
+		new_bex_start = ac->ac_g_ex.fe_logical;
+		new_bex_end =
+			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+		if (ac->ac_o_ex.fe_logical < new_bex_end)
+			goto adjust_bex;
 
-		/* the smallest one defines real window */
-		win = min(winl, wins);
+		new_bex_start = ac->ac_o_ex.fe_logical;
+		new_bex_end =
+			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
 
-		offs = ac->ac_o_ex.fe_logical %
-			EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
-		if (offs && offs < win)
-			win = offs;
+adjust_bex:
+		ac->ac_b_ex.fe_logical = new_bex_start;
 
-		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical -
-			EXT4_NUM_B2C(sbi, win);
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
 		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
+		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
+				      EXT4_C2B(sbi, ac->ac_g_ex.fe_len)));
 	}
 
 	/* preallocation can change ac_b_ex, thus we store actually
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a563de5ccd21..621e0d4f1fbf 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -273,8 +273,15 @@ static int __f2fs_write_meta_page(struct page *page,
 
 	trace_f2fs_writepage(page, META);
 
-	if (unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi))) {
+		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
+			ClearPageUptodate(page);
+			dec_page_count(sbi, F2FS_DIRTY_META);
+			unlock_page(page);
+			return 0;
+		}
 		goto redirty_out;
+	}
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
@@ -1185,7 +1192,8 @@ void f2fs_wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
 		if (!get_pages(sbi, F2FS_WB_CP_DATA))
 			break;
 
-		if (unlikely(f2fs_cp_error(sbi)))
+		if (unlikely(f2fs_cp_error(sbi) &&
+			!is_sbi_flag_set(sbi, SBI_IS_CLOSE)))
 			break;
 
 		io_schedule_timeout(5*HZ);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 56b2dadd623b..419586809cef 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1885,7 +1885,8 @@ static int __write_data_page(struct page *page, bool *submitted,
 		 * don't drop any dirty dentry pages for keeping lastest
 		 * directory structure.
 		 */
-		if (S_ISDIR(inode->i_mode))
+		if (S_ISDIR(inode->i_mode) &&
+				!is_sbi_flag_set(sbi, SBI_IS_CLOSE))
 			goto redirty_out;
 		goto out;
 	}
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index a7a423adf7c8..ff35cc365930 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -339,6 +339,7 @@ static int inode_go_demote_ok(const struct gfs2_glock *gl)
 
 static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	const struct gfs2_dinode *str = buf;
 	struct timespec64 atime;
 	u16 height, depth;
@@ -378,7 +379,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	/* i_diskflags and i_eattr must be set before gfs2_set_inode_flags() */
 	gfs2_set_inode_flags(&ip->i_inode);
 	height = be16_to_cpu(str->di_height);
-	if (unlikely(height > GFS2_MAX_META_HEIGHT))
+	if (unlikely(height > sdp->sd_max_height))
 		goto corrupt;
 	ip->i_height = (u8)height;
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c7073a1517d6..a1d4ad584b10 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -476,7 +476,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 	if (type == HFSPLUS_FOLDER) {
 		struct hfsplus_cat_folder *folder = &entry.folder;
 
-		WARN_ON(fd->entrylength < sizeof(struct hfsplus_cat_folder));
+		if (fd->entrylength < sizeof(struct hfsplus_cat_folder)) {
+			pr_err("bad catalog folder entry\n");
+			res = -EIO;
+			goto out;
+		}
 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
 					sizeof(struct hfsplus_cat_folder));
 		hfsplus_get_perms(inode, &folder->permissions, 1);
@@ -496,7 +500,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 	} else if (type == HFSPLUS_FILE) {
 		struct hfsplus_cat_file *file = &entry.file;
 
-		WARN_ON(fd->entrylength < sizeof(struct hfsplus_cat_file));
+		if (fd->entrylength < sizeof(struct hfsplus_cat_file)) {
+			pr_err("bad catalog file entry\n");
+			res = -EIO;
+			goto out;
+		}
 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
 					sizeof(struct hfsplus_cat_file));
 
@@ -527,6 +535,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		pr_err("bad catalog entry used to create inode\n");
 		res = -EIO;
 	}
+out:
 	return res;
 }
 
@@ -535,6 +544,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	struct inode *main_inode = inode;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
+	int res = 0;
 
 	if (HFSPLUS_IS_RSRC(inode))
 		main_inode = HFSPLUS_I(inode)->rsrc_inode;
@@ -553,7 +563,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	if (S_ISDIR(main_inode->i_mode)) {
 		struct hfsplus_cat_folder *folder = &entry.folder;
 
-		WARN_ON(fd.entrylength < sizeof(struct hfsplus_cat_folder));
+		if (fd.entrylength < sizeof(struct hfsplus_cat_folder)) {
+			pr_err("bad catalog folder entry\n");
+			res = -EIO;
+			goto out;
+		}
 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
 					sizeof(struct hfsplus_cat_folder));
 		/* simple node checks? */
@@ -578,7 +592,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	} else {
 		struct hfsplus_cat_file *file = &entry.file;
 
-		WARN_ON(fd.entrylength < sizeof(struct hfsplus_cat_file));
+		if (fd.entrylength < sizeof(struct hfsplus_cat_file)) {
+			pr_err("bad catalog file entry\n");
+			res = -EIO;
+			goto out;
+		}
 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
 					sizeof(struct hfsplus_cat_file));
 		hfsplus_inode_write_fork(inode, &file->data_fork);
@@ -599,5 +617,5 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
-	return 0;
+	return res;
 }
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index cf01aa55dd44..53ec342eb787 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -930,6 +930,7 @@ void nilfs_evict_inode(struct inode *inode)
 	struct nilfs_transaction_info ti;
 	struct super_block *sb = inode->i_sb;
 	struct nilfs_inode_info *ii = NILFS_I(inode);
+	struct the_nilfs *nilfs;
 	int ret;
 
 	if (inode->i_nlink || !ii->i_root || unlikely(is_bad_inode(inode))) {
@@ -942,6 +943,23 @@ void nilfs_evict_inode(struct inode *inode)
 
 	truncate_inode_pages_final(&inode->i_data);
 
+	nilfs = sb->s_fs_info;
+	if (unlikely(sb_rdonly(sb) || !nilfs->ns_writer)) {
+		/*
+		 * If this inode is about to be disposed after the file system
+		 * has been degraded to read-only due to file system corruption
+		 * or after the writer has been detached, do not make any
+		 * changes that cause writes, just clear it.
+		 * Do this check after read-locking ns_segctor_sem by
+		 * nilfs_transaction_begin() in order to avoid a race with
+		 * the writer detach operation.
+		 */
+		clear_inode(inode);
+		nilfs_clear_inode(inode);
+		nilfs_transaction_abort(sb);
+		return;
+	}
+
 	/* TODO: some of the following operations may fail.  */
 	nilfs_truncate_bmap(ii, 0);
 	nilfs_mark_inode_dirty(inode);
diff --git a/fs/statfs.c b/fs/statfs.c
index 56f655f757ff..29786598c2b5 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -114,6 +114,7 @@ static int do_statfs_native(struct kstatfs *st, struct statfs __user *p)
 	if (sizeof(buf) == sizeof(*st))
 		memcpy(&buf, st, sizeof(*st));
 	else {
+		memset(&buf, 0, sizeof(buf));
 		if (sizeof buf.f_blocks == 4) {
 			if ((st->f_blocks | st->f_bfree | st->f_bavail |
 			     st->f_bsize | st->f_frsize) &
@@ -142,7 +143,6 @@ static int do_statfs_native(struct kstatfs *st, struct statfs __user *p)
 		buf.f_namelen = st->f_namelen;
 		buf.f_frsize = st->f_frsize;
 		buf.f_flags = st->f_flags;
-		memset(buf.f_spare, 0, sizeof(buf.f_spare));
 	}
 	if (copy_to_user(p, &buf, sizeof(buf)))
 		return -EFAULT;
@@ -155,6 +155,7 @@ static int do_statfs64(struct kstatfs *st, struct statfs64 __user *p)
 	if (sizeof(buf) == sizeof(*st))
 		memcpy(&buf, st, sizeof(*st));
 	else {
+		memset(&buf, 0, sizeof(buf));
 		buf.f_type = st->f_type;
 		buf.f_bsize = st->f_bsize;
 		buf.f_blocks = st->f_blocks;
@@ -166,7 +167,6 @@ static int do_statfs64(struct kstatfs *st, struct statfs64 __user *p)
 		buf.f_namelen = st->f_namelen;
 		buf.f_frsize = st->f_frsize;
 		buf.f_flags = st->f_flags;
-		memset(buf.f_spare, 0, sizeof(buf.f_spare));
 	}
 	if (copy_to_user(p, &buf, sizeof(buf)))
 		return -EFAULT;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 60efd9810d53..71a0a5ffdbb1 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -111,7 +111,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_CSTATE_STARTING,
 	CPUHP_AP_PERF_XTENSA_STARTING,
 	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
-	CPUHP_AP_ARM_SDEI_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
 	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 1a9f38f27f65..9e5c98fcea8c 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -51,6 +51,9 @@ extern struct device platform_bus;
 extern void arch_setup_pdev_archdata(struct platform_device *);
 extern struct resource *platform_get_resource(struct platform_device *,
 					      unsigned int, unsigned int);
+extern void __iomem *
+devm_platform_ioremap_resource(struct platform_device *pdev,
+			       unsigned int index);
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);
 extern struct resource *platform_get_resource_byname(struct platform_device *,
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 13d5dd4eb40b..95a8715624ed 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -63,6 +63,7 @@ struct bq27xxx_device_info {
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
 	int charge_design_full;
+	bool removed;
 	unsigned long last_update;
 	struct delayed_work work;
 	struct power_supply *bat;
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 4f099d3fed3a..f1063380e6d8 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -23,7 +23,7 @@ static inline void *task_stack_page(const struct task_struct *task)
 
 #define setup_thread_stack(new,old)	do { } while(0)
 
-static inline unsigned long *end_of_stack(const struct task_struct *task)
+static __always_inline unsigned long *end_of_stack(const struct task_struct *task)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long *)((unsigned long)task->stack + THREAD_SIZE) - 1;
diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index d23c5030901a..0618885b3edc 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_STRING_HELPERS_H_
 #define _LINUX_STRING_HELPERS_H_
 
+#include <linux/ctype.h>
 #include <linux/types.h>
 
 struct file;
@@ -72,6 +73,20 @@ static inline int string_escape_str_any_np(const char *src, char *dst,
 	return string_escape_str(src, dst, sz, ESCAPE_ANY_NP, only);
 }
 
+static inline void string_upper(char *dst, const char *src)
+{
+	do {
+		*dst++ = toupper(*src);
+	} while (*src++);
+}
+
+static inline void string_lower(char *dst, const char *src)
+{
+	do {
+		*dst++ = tolower(*src);
+	} while (*src++);
+}
+
 char *kstrdup_quotable(const char *src, gfp_t gfp);
 char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
 char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 744023c91404..c7adccb712cd 100644
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
diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index f594eb71c274..c26b39a30000 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -57,7 +57,7 @@ struct ip6_tnl {
 
 	/* These fields used only by GRE */
 	__u32 i_seqno;	/* The last seen seqno	*/
-	__u32 o_seqno;	/* The last output seqno */
+	atomic_t o_seqno;	/* The last output seqno */
 	int hlen;       /* tun_hlen + encap_hlen */
 	int tun_hlen;	/* Precalculated header length */
 	int encap_hlen; /* Encap header length (FOU,GUE) */
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index f8873c4eb003..bc2ae8ce5bd4 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -113,7 +113,7 @@ struct ip_tunnel {
 
 	/* These four fields used only by GRE */
 	u32		i_seqno;	/* The last seen seqno	*/
-	u32		o_seqno;	/* The last output seqno */
+	atomic_t	o_seqno;	/* The last output seqno */
 	int		tun_hlen;	/* Precalculated header length */
 
 	/* These four fields used only by ERSPAN */
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 78f5f0426e6b..1b4f47a87806 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -191,14 +191,13 @@ static inline enum nft_registers nft_type_to_reg(enum nft_data_types type)
 }
 
 int nft_parse_u32_check(const struct nlattr *attr, int max, u32 *dest);
-unsigned int nft_parse_register(const struct nlattr *attr);
 int nft_dump_register(struct sk_buff *skb, unsigned int attr, unsigned int reg);
 
-int nft_validate_register_load(enum nft_registers reg, unsigned int len);
-int nft_validate_register_store(const struct nft_ctx *ctx,
-				enum nft_registers reg,
-				const struct nft_data *data,
-				enum nft_data_types type, unsigned int len);
+int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len);
+int nft_parse_register_store(const struct nft_ctx *ctx,
+			     const struct nlattr *attr, u8 *dreg,
+			     const struct nft_data *data,
+			     enum nft_data_types type, unsigned int len);
 
 /**
  *	struct nft_userdata - user defined data associated with an object
@@ -226,6 +225,10 @@ struct nft_set_elem {
 		u32		buf[NFT_DATA_VALUE_MAXLEN / sizeof(u32)];
 		struct nft_data	val;
 	} key;
+	union {
+		u32		buf[NFT_DATA_VALUE_MAXLEN / sizeof(u32)];
+		struct nft_data val;
+	} data;
 	void			*priv;
 };
 
diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 8da837d2aaf9..6a3f76e012be 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -21,13 +21,14 @@ void nf_tables_core_module_exit(void);
 
 struct nft_cmp_fast_expr {
 	u32			data;
-	enum nft_registers	sreg:8;
+	u32			mask;
+	u8			sreg;
 	u8			len;
 };
 
 struct nft_immediate_expr {
 	struct nft_data		data;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			dlen;
 };
 
@@ -47,14 +48,14 @@ struct nft_payload {
 	enum nft_payload_bases	base:8;
 	u8			offset;
 	u8			len;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 };
 
 struct nft_payload_set {
 	enum nft_payload_bases	base:8;
 	u8			offset;
 	u8			len;
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	u8			csum_type;
 	u8			csum_offset;
 	u8			csum_flags;
diff --git a/include/net/netfilter/nft_fib.h b/include/net/netfilter/nft_fib.h
index a88f92737308..1f8726739529 100644
--- a/include/net/netfilter/nft_fib.h
+++ b/include/net/netfilter/nft_fib.h
@@ -3,7 +3,7 @@
 #define _NFT_FIB_H_
 
 struct nft_fib {
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			result;
 	u32			flags;
 };
diff --git a/include/net/netfilter/nft_masq.h b/include/net/netfilter/nft_masq.h
index e51ab3815797..e69a8277b70b 100644
--- a/include/net/netfilter/nft_masq.h
+++ b/include/net/netfilter/nft_masq.h
@@ -4,8 +4,8 @@
 
 struct nft_masq {
 	u32			flags;
-	enum nft_registers      sreg_proto_min:8;
-	enum nft_registers      sreg_proto_max:8;
+	u8			sreg_proto_min;
+	u8			sreg_proto_max;
 };
 
 extern const struct nla_policy nft_masq_policy[];
diff --git a/include/net/netfilter/nft_redir.h b/include/net/netfilter/nft_redir.h
index 4a970737c03c..2b4036c94cb3 100644
--- a/include/net/netfilter/nft_redir.h
+++ b/include/net/netfilter/nft_redir.h
@@ -3,8 +3,8 @@
 #define _NFT_REDIR_H_
 
 struct nft_redir {
-	enum nft_registers	sreg_proto_min:8;
-	enum nft_registers	sreg_proto_max:8;
+	u8			sreg_proto_min;
+	u8			sreg_proto_max;
 	u16			flags;
 };
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 9eb656683281..cfbd241935a3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1130,7 +1130,7 @@ struct proto {
 	unsigned int		inuse_idx;
 #endif
 
-	bool			(*stream_memory_free)(const struct sock *sk);
+	bool			(*stream_memory_free)(const struct sock *sk, int wake);
 	bool			(*stream_memory_read)(const struct sock *sk);
 	/* Memory pressure */
 	void			(*enter_memory_pressure)(struct sock *sk);
@@ -1212,19 +1212,29 @@ static inline void sk_refcnt_debug_release(const struct sock *sk)
 #define sk_refcnt_debug_release(sk) do { } while (0)
 #endif /* SOCK_REFCNT_DEBUG */
 
-static inline bool sk_stream_memory_free(const struct sock *sk)
+static inline bool __sk_stream_memory_free(const struct sock *sk, int wake)
 {
 	if (sk->sk_wmem_queued >= sk->sk_sndbuf)
 		return false;
 
 	return sk->sk_prot->stream_memory_free ?
-		sk->sk_prot->stream_memory_free(sk) : true;
+		sk->sk_prot->stream_memory_free(sk, wake) : true;
 }
 
-static inline bool sk_stream_is_writeable(const struct sock *sk)
+static inline bool sk_stream_memory_free(const struct sock *sk)
+{
+	return __sk_stream_memory_free(sk, 0);
+}
+
+static inline bool __sk_stream_is_writeable(const struct sock *sk, int wake)
 {
 	return sk_stream_wspace(sk) >= sk_stream_min_wspace(sk) &&
-	       sk_stream_memory_free(sk);
+	       __sk_stream_memory_free(sk, wake);
+}
+
+static inline bool sk_stream_is_writeable(const struct sock *sk)
+{
+	return __sk_stream_is_writeable(sk, 0);
 }
 
 static inline int sk_under_cgroup_hierarchy(struct sock *sk,
@@ -2406,7 +2416,7 @@ static inline void sock_recv_ts_and_drops(struct msghdr *msg, struct sock *sk,
 		__sock_recv_ts_and_drops(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
 		sock_write_timestamp(sk, skb->tstamp);
-	else if (unlikely(sk->sk_stamp == SK_DEFAULT_STAMP))
+	else if (unlikely(sock_read_timestamp(sk) == SK_DEFAULT_STAMP))
 		sock_write_timestamp(sk, 0);
 }
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9a154fe06c60..81300a04b580 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -389,6 +389,7 @@ void tcp_update_metrics(struct sock *sk);
 void tcp_init_metrics(struct sock *sk);
 void tcp_metrics_init(void);
 bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst);
+void __tcp_close(struct sock *sk, long timeout);
 void tcp_close(struct sock *sk, long timeout);
 void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op);
@@ -1884,12 +1885,16 @@ static inline u32 tcp_notsent_lowat(const struct tcp_sock *tp)
 	return tp->notsent_lowat ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
 }
 
-static inline bool tcp_stream_memory_free(const struct sock *sk)
+/* @wake is one when sk_stream_write_space() calls us.
+ * This sends EPOLLOUT only if notsent_bytes is half the limit.
+ * This mimics the strategy used in sock_def_write_space().
+ */
+static inline bool tcp_stream_memory_free(const struct sock *sk, int wake)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	u32 notsent_bytes = READ_ONCE(tp->write_seq) - tp->snd_nxt;
 
-	return notsent_bytes < tcp_notsent_lowat(tp);
+	return (notsent_bytes << wake) < tcp_notsent_lowat(tp);
 }
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/uapi/sound/skl-tplg-interface.h b/include/uapi/sound/skl-tplg-interface.h
index f39352cef382..2783253ba473 100644
--- a/include/uapi/sound/skl-tplg-interface.h
+++ b/include/uapi/sound/skl-tplg-interface.h
@@ -64,7 +64,8 @@ enum skl_ch_cfg {
 	SKL_CH_CFG_DUAL_MONO = 9,
 	SKL_CH_CFG_I2S_DUAL_STEREO_0 = 10,
 	SKL_CH_CFG_I2S_DUAL_STEREO_1 = 11,
-	SKL_CH_CFG_4_CHANNEL = 12,
+	SKL_CH_CFG_7_1 = 12,
+	SKL_CH_CFG_4_CHANNEL = SKL_CH_CFG_7_1,
 	SKL_CH_CFG_INVALID
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61f3a31abc1a..a48de55f5630 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5936,7 +5936,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
 									insn->dst_reg,
 									shift);
-				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
+				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
 								(1ULL << size * 8) - 1);
 			}
 		}
diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index f610b2a10b3e..f52389054a24 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -235,7 +235,8 @@ void free_irq_cpu_rmap(struct cpu_rmap *rmap)
 
 	for (index = 0; index < rmap->used; index++) {
 		glue = rmap->obj[index];
-		irq_set_affinity_notifier(glue->notify.irq, NULL);
+		if (glue)
+			irq_set_affinity_notifier(glue->notify.irq, NULL);
 	}
 
 	cpu_rmap_put(rmap);
@@ -271,6 +272,7 @@ static void irq_cpu_rmap_release(struct kref *ref)
 		container_of(ref, struct irq_glue, notify.kref);
 
 	cpu_rmap_put(glue->rmap);
+	glue->rmap->obj[glue->index] = NULL;
 	kfree(glue);
 }
 
@@ -300,6 +302,7 @@ int irq_cpu_rmap_add(struct cpu_rmap *rmap, int irq)
 	rc = irq_set_affinity_notifier(irq, &glue->notify);
 	if (rc) {
 		cpu_rmap_put(glue->rmap);
+		rmap->obj[glue->index] = NULL;
 		kfree(glue);
 	}
 	return rc;
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c80add6edf59..ba9b8980f100 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -115,8 +115,8 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
 	 * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
 	 * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
 	 */
-	if (veth->h_vlan_proto != vlan->vlan_proto ||
-	    vlan->flags & VLAN_FLAG_REORDER_HDR) {
+	if (vlan->flags & VLAN_FLAG_REORDER_HDR ||
+	    veth->h_vlan_proto != vlan->vlan_proto) {
 		u16 vlan_tci;
 		vlan_tci = vlan->vlan_id;
 		vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1a68aad5737e..94d40a20ab95 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4392,7 +4392,6 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan) {
-		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 865a8cb7b0bd..6ba82eb14b46 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -837,18 +837,21 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask;
+	u8 shutdown;
 
 	sock_poll_wait(file, sock, wait);
 	mask = 0;
 
 	/* exceptional events? */
-	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPRI : 0);
 
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	shutdown = READ_ONCE(sk->sk_shutdown);
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
-	if (sk->sk_shutdown == SHUTDOWN_MASK)
+	if (shutdown == SHUTDOWN_MASK)
 		mask |= EPOLLHUP;
 
 	/* readable? */
@@ -857,10 +860,12 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 
 	/* Connection-based need to check for termination and startup */
 	if (connection_based(sk)) {
-		if (sk->sk_state == TCP_CLOSE)
+		int state = READ_ONCE(sk->sk_state);
+
+		if (state == TCP_CLOSE)
 			mask |= EPOLLHUP;
 		/* connection hasn't started yet? */
-		if (sk->sk_state == TCP_SYN_SENT)
+		if (state == TCP_SYN_SENT)
 			return mask;
 	}
 
diff --git a/net/core/dev.c b/net/core/dev.c
index b778f3596543..03903d3f1d69 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2303,6 +2303,8 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 	bool active = false;
 	unsigned int nr_ids;
 
+	WARN_ON_ONCE(index >= dev->num_tx_queues);
+
 	if (dev->num_tc) {
 		/* Do not allow XPS on subordinate device directly */
 		num_tc = dev->num_tc;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5ae62d743357..b7314a6cf8c2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4446,8 +4446,10 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
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
diff --git a/net/core/stream.c b/net/core/stream.c
index 23e6669d3f8d..cd60746877b1 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -32,7 +32,7 @@ void sk_stream_write_space(struct sock *sk)
 	struct socket *sock = sk->sk_socket;
 	struct socket_wq *wq;
 
-	if (sk_stream_is_writeable(sk) && sock) {
+	if (__sk_stream_is_writeable(sk, 1) && sock) {
 		clear_bit(SOCK_NOSPACE, &sock->flags);
 
 		rcu_read_lock();
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 4b26ae525d6d..fb142ea73006 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -865,7 +865,7 @@ int inet_shutdown(struct socket *sock, int how)
 		   EPOLLHUP, even on eg. unconnected UDP sockets -- RR */
 		/* fall through */
 	default:
-		sk->sk_shutdown |= how;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | how);
 		if (sk->sk_prot->shutdown)
 			sk->sk_prot->shutdown(sk, how);
 		break;
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 898753328c17..e16373640f4c 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -440,7 +440,7 @@ static void __gre_xmit(struct sk_buff *skb, struct net_device *dev,
 	/* Push GRE header. */
 	gre_build_header(skb, tunnel->tun_hlen,
 			 flags, proto, tunnel->parms.o_key,
-			 (flags & TUNNEL_SEQ) ? htonl(tunnel->o_seqno++) : 0);
+			 (flags & TUNNEL_SEQ) ? htonl(atomic_fetch_inc(&tunnel->o_seqno)) : 0);
 
 	ip_tunnel_xmit(skb, dev, tnl_params, tnl_params->protocol);
 }
@@ -546,7 +546,7 @@ static void gre_fb_xmit(struct sk_buff *skb, struct net_device *dev,
 		(TUNNEL_CSUM | TUNNEL_KEY | TUNNEL_SEQ);
 	gre_build_header(skb, tunnel_hlen, flags, proto,
 			 tunnel_id_to_key32(tun_info->key.tun_id),
-			 (flags & TUNNEL_SEQ) ? htonl(tunnel->o_seqno++) : 0);
+			 (flags & TUNNEL_SEQ) ? htonl(atomic_fetch_inc(&tunnel->o_seqno)) : 0);
 
 	df = key->tun_flags & TUNNEL_DONT_FRAGMENT ?  htons(IP_DF) : 0;
 
@@ -635,7 +635,7 @@ static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	gre_build_header(skb, 8, TUNNEL_SEQ,
-			 proto, 0, htonl(tunnel->o_seqno++));
+			 proto, 0, htonl(atomic_fetch_inc(&tunnel->o_seqno)));
 
 	df = key->tun_flags & TUNNEL_DONT_FRAGMENT ?  htons(IP_DF) : 0;
 
diff --git a/net/ipv4/netfilter/nft_dup_ipv4.c b/net/ipv4/netfilter/nft_dup_ipv4.c
index 0af3d8df70dd..157bca240edc 100644
--- a/net/ipv4/netfilter/nft_dup_ipv4.c
+++ b/net/ipv4/netfilter/nft_dup_ipv4.c
@@ -16,8 +16,8 @@
 #include <net/netfilter/ipv4/nf_dup_ipv4.h>
 
 struct nft_dup_ipv4 {
-	enum nft_registers	sreg_addr:8;
-	enum nft_registers	sreg_dev:8;
+	u8	sreg_addr;
+	u8	sreg_dev;
 };
 
 static void nft_dup_ipv4_eval(const struct nft_expr *expr,
@@ -43,16 +43,16 @@ static int nft_dup_ipv4_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_DUP_SREG_ADDR] == NULL)
 		return -EINVAL;
 
-	priv->sreg_addr = nft_parse_register(tb[NFTA_DUP_SREG_ADDR]);
-	err = nft_validate_register_load(priv->sreg_addr, sizeof(struct in_addr));
+	err = nft_parse_register_load(tb[NFTA_DUP_SREG_ADDR], &priv->sreg_addr,
+				      sizeof(struct in_addr));
 	if (err < 0)
 		return err;
 
-	if (tb[NFTA_DUP_SREG_DEV] != NULL) {
-		priv->sreg_dev = nft_parse_register(tb[NFTA_DUP_SREG_DEV]);
-		return nft_validate_register_load(priv->sreg_dev, sizeof(int));
-	}
-	return 0;
+	if (tb[NFTA_DUP_SREG_DEV])
+		err = nft_parse_register_load(tb[NFTA_DUP_SREG_DEV],
+					      &priv->sreg_dev, sizeof(int));
+
+	return err;
 }
 
 static int nft_dup_ipv4_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 68f89fe7f923..b51e0a1e15b6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -515,6 +515,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	__poll_t mask;
 	struct sock *sk = sock->sk;
 	const struct tcp_sock *tp = tcp_sk(sk);
+	u8 shutdown;
 	int state;
 
 	sock_poll_wait(file, sock, wait);
@@ -557,9 +558,10 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	 * NOTE. Check for TCP_CLOSE is added. The goal is to prevent
 	 * blocking on fresh not-connected or disconnected socket. --ANK
 	 */
-	if (sk->sk_shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
+	shutdown = READ_ONCE(sk->sk_shutdown);
+	if (shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
 		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* Connected or passive Fast Open socket? */
@@ -575,8 +577,8 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 		if (tcp_stream_is_readable(tp, target, sk))
 			mask |= EPOLLIN | EPOLLRDNORM;
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
-			if (sk_stream_is_writeable(sk)) {
+		if (!(shutdown & SEND_SHUTDOWN)) {
+			if (__sk_stream_is_writeable(sk, 1)) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
 				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
@@ -588,7 +590,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 				 * pairs with the input side.
 				 */
 				smp_mb__after_atomic();
-				if (sk_stream_is_writeable(sk))
+				if (__sk_stream_is_writeable(sk, 1))
 					mask |= EPOLLOUT | EPOLLWRNORM;
 			}
 		} else
@@ -2338,14 +2340,13 @@ bool tcp_check_oom(struct sock *sk, int shift)
 	return too_many_orphans || out_of_socket_memory;
 }
 
-void tcp_close(struct sock *sk, long timeout)
+void __tcp_close(struct sock *sk, long timeout)
 {
 	struct sk_buff *skb;
 	int data_was_unread = 0;
 	int state;
 
-	lock_sock(sk);
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
@@ -2505,6 +2506,12 @@ void tcp_close(struct sock *sk, long timeout)
 out:
 	bh_unlock_sock(sk);
 	local_bh_enable();
+}
+
+void tcp_close(struct sock *sk, long timeout)
+{
+	lock_sock(sk);
+	__tcp_close(sk, timeout);
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2593,7 +2600,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
 		inet_reset_saddr(sk);
 
-	sk->sk_shutdown = 0;
+	WRITE_ONCE(sk->sk_shutdown, 0);
 	sock_reset_flag(sk, SOCK_DONE);
 	tp->srtt_us = 0;
 	tp->rcv_rtt_last_tsecr = 0;
@@ -3802,7 +3809,7 @@ void tcp_done(struct sock *sk)
 	if (req)
 		reqsk_fastopen_remove(sk, req, false);
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk->sk_state_change(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 11716780667c..bd921fa7b9ab 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4130,7 +4130,7 @@ void tcp_fin(struct sock *sk)
 
 	inet_csk_schedule_ack(sk);
 
-	sk->sk_shutdown |= RCV_SHUTDOWN;
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 	sock_set_flag(sk, SOCK_DONE);
 
 	switch (sk->sk_state) {
@@ -6209,7 +6209,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			break;
 
 		tcp_set_state(sk, TCP_FIN_WAIT2);
-		sk->sk_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
 
 		sk_dst_confirm(sk);
 
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index 6beab353bc8b..27173549b000 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -64,6 +64,8 @@ struct proto 	udplite_prot = {
 	.get_port	   = udp_v4_get_port,
 	.memory_allocated  = &udp_memory_allocated,
 	.sysctl_mem	   = sysctl_udp_mem,
+	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
+	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size	   = sizeof(struct udp_sock),
 	.h.udp_table	   = &udplite_table,
 #ifdef CONFIG_COMPAT
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index ae365df8abf7..f356d3049143 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -142,6 +142,8 @@ int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type)
 			optlen = 1;
 			break;
 		default:
+			if (len < 2)
+				goto bad;
 			optlen = nh[offset + 1] + 2;
 			if (optlen > len)
 				goto bad;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 166b7544e54a..45c304b51b2b 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -731,6 +731,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 {
 	struct ip6_tnl *tunnel = netdev_priv(dev);
 	__be16 protocol;
+	__be16 flags;
 
 	if (dev->type == ARPHRD_ETHER)
 		IPCB(skb)->flags = 0;
@@ -740,16 +741,12 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 	else
 		fl6->daddr = tunnel->parms.raddr;
 
-	if (skb_cow_head(skb, dev->needed_headroom ?: tunnel->hlen))
-		return -ENOMEM;
-
 	/* Push GRE header. */
 	protocol = (dev->type == ARPHRD_ETHER) ? htons(ETH_P_TEB) : proto;
 
 	if (tunnel->parms.collect_md) {
 		struct ip_tunnel_info *tun_info;
 		const struct ip_tunnel_key *key;
-		__be16 flags;
 		int tun_hlen;
 
 		tun_info = skb_tunnel_info(skb);
@@ -770,19 +767,25 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 			(TUNNEL_CSUM | TUNNEL_KEY | TUNNEL_SEQ);
 		tun_hlen = gre_calc_hlen(flags);
 
+		if (skb_cow_head(skb, dev->needed_headroom ?: tun_hlen + tunnel->encap_hlen))
+			return -ENOMEM;
+
 		gre_build_header(skb, tun_hlen,
 				 flags, protocol,
 				 tunnel_id_to_key32(tun_info->key.tun_id),
-				 (flags & TUNNEL_SEQ) ? htonl(tunnel->o_seqno++)
+				 (flags & TUNNEL_SEQ) ? htonl(atomic_fetch_inc(&tunnel->o_seqno))
 						      : 0);
 
 	} else {
-		if (tunnel->parms.o_flags & TUNNEL_SEQ)
-			tunnel->o_seqno++;
+		if (skb_cow_head(skb, dev->needed_headroom ?: tunnel->hlen))
+			return -ENOMEM;
+
+		flags = tunnel->parms.o_flags;
 
-		gre_build_header(skb, tunnel->tun_hlen, tunnel->parms.o_flags,
+		gre_build_header(skb, tunnel->tun_hlen, flags,
 				 protocol, tunnel->parms.o_key,
-				 htonl(tunnel->o_seqno));
+				 (flags & TUNNEL_SEQ) ? htonl(atomic_fetch_inc(&tunnel->o_seqno))
+						      : 0);
 	}
 
 	return ip6_tnl_xmit(skb, dev, dsfield, fl6, encap_limit, pmtu,
@@ -1018,12 +1021,14 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					    ntohl(tun_id),
 					    ntohl(md->u.index), truncate,
 					    false);
+			proto = htons(ETH_P_ERSPAN);
 		} else if (md->version == 2) {
 			erspan_build_header_v2(skb,
 					       ntohl(tun_id),
 					       md->u.md2.dir,
 					       get_hwid(&md->u.md2),
 					       truncate, false);
+			proto = htons(ETH_P_ERSPAN2);
 		} else {
 			goto tx_err;
 		}
@@ -1046,25 +1051,26 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			break;
 		}
 
-		if (t->parms.erspan_ver == 1)
+		if (t->parms.erspan_ver == 1) {
 			erspan_build_header(skb, ntohl(t->parms.o_key),
 					    t->parms.index,
 					    truncate, false);
-		else if (t->parms.erspan_ver == 2)
+			proto = htons(ETH_P_ERSPAN);
+		} else if (t->parms.erspan_ver == 2) {
 			erspan_build_header_v2(skb, ntohl(t->parms.o_key),
 					       t->parms.dir,
 					       t->parms.hwid,
 					       truncate, false);
-		else
+			proto = htons(ETH_P_ERSPAN2);
+		} else {
 			goto tx_err;
+		}
 
 		fl6.daddr = t->parms.raddr;
 	}
 
 	/* Push GRE header. */
-	proto = (t->parms.erspan_ver == 1) ? htons(ETH_P_ERSPAN)
-					   : htons(ETH_P_ERSPAN2);
-	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(t->o_seqno++));
+	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(atomic_fetch_inc(&t->o_seqno)));
 
 	/* TooBig packet may have updated dst->dev's mtu */
 	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)
diff --git a/net/ipv6/netfilter/nft_dup_ipv6.c b/net/ipv6/netfilter/nft_dup_ipv6.c
index d8b5b60b7d53..d8bb7c85287c 100644
--- a/net/ipv6/netfilter/nft_dup_ipv6.c
+++ b/net/ipv6/netfilter/nft_dup_ipv6.c
@@ -16,8 +16,8 @@
 #include <net/netfilter/ipv6/nf_dup_ipv6.h>
 
 struct nft_dup_ipv6 {
-	enum nft_registers	sreg_addr:8;
-	enum nft_registers	sreg_dev:8;
+	u8	sreg_addr;
+	u8	sreg_dev;
 };
 
 static void nft_dup_ipv6_eval(const struct nft_expr *expr,
@@ -41,16 +41,16 @@ static int nft_dup_ipv6_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_DUP_SREG_ADDR] == NULL)
 		return -EINVAL;
 
-	priv->sreg_addr = nft_parse_register(tb[NFTA_DUP_SREG_ADDR]);
-	err = nft_validate_register_load(priv->sreg_addr, sizeof(struct in6_addr));
+	err = nft_parse_register_load(tb[NFTA_DUP_SREG_ADDR], &priv->sreg_addr,
+				      sizeof(struct in6_addr));
 	if (err < 0)
 		return err;
 
-	if (tb[NFTA_DUP_SREG_DEV] != NULL) {
-		priv->sreg_dev = nft_parse_register(tb[NFTA_DUP_SREG_DEV]);
-		return nft_validate_register_load(priv->sreg_dev, sizeof(int));
-	}
-	return 0;
+	if (tb[NFTA_DUP_SREG_DEV])
+		err = nft_parse_register_load(tb[NFTA_DUP_SREG_DEV],
+					      &priv->sreg_dev, sizeof(int));
+
+	return err;
 }
 
 static int nft_dup_ipv6_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index f15b8305d87b..a26a4b5da09c 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -58,6 +58,8 @@ struct proto udplitev6_prot = {
 	.get_port	   = udp_v6_get_port,
 	.memory_allocated  = &udp_memory_allocated,
 	.sysctl_mem	   = sysctl_udp_mem,
+	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
+	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size	   = sizeof(struct udp6_sock),
 	.h.udp_table	   = &udplite_table,
 #ifdef CONFIG_COMPAT
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 976b67089ac1..b8456e2f1167 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1950,7 +1950,8 @@ static u32 gen_reqid(struct net *net)
 }
 
 static int
-parse_ipsecrequest(struct xfrm_policy *xp, struct sadb_x_ipsecrequest *rq)
+parse_ipsecrequest(struct xfrm_policy *xp, struct sadb_x_policy *pol,
+		   struct sadb_x_ipsecrequest *rq)
 {
 	struct net *net = xp_net(xp);
 	struct xfrm_tmpl *t = xp->xfrm_vec + xp->xfrm_nr;
@@ -1968,9 +1969,12 @@ parse_ipsecrequest(struct xfrm_policy *xp, struct sadb_x_ipsecrequest *rq)
 	if ((mode = pfkey_mode_to_xfrm(rq->sadb_x_ipsecrequest_mode)) < 0)
 		return -EINVAL;
 	t->mode = mode;
-	if (rq->sadb_x_ipsecrequest_level == IPSEC_LEVEL_USE)
+	if (rq->sadb_x_ipsecrequest_level == IPSEC_LEVEL_USE) {
+		if ((mode == XFRM_MODE_TUNNEL || mode == XFRM_MODE_BEET) &&
+		    pol->sadb_x_policy_dir == IPSEC_DIR_OUTBOUND)
+			return -EINVAL;
 		t->optional = 1;
-	else if (rq->sadb_x_ipsecrequest_level == IPSEC_LEVEL_UNIQUE) {
+	} else if (rq->sadb_x_ipsecrequest_level == IPSEC_LEVEL_UNIQUE) {
 		t->reqid = rq->sadb_x_ipsecrequest_reqid;
 		if (t->reqid > IPSEC_MANUAL_REQID_MAX)
 			t->reqid = 0;
@@ -2012,7 +2016,7 @@ parse_ipsecrequests(struct xfrm_policy *xp, struct sadb_x_policy *pol)
 		    rq->sadb_x_ipsecrequest_len < sizeof(*rq))
 			return -EINVAL;
 
-		if ((err = parse_ipsecrequest(xp, rq)) < 0)
+		if ((err = parse_ipsecrequest(xp, pol, rq)) < 0)
 			return err;
 		len -= rq->sadb_x_ipsecrequest_len;
 		rq = (void*)((u8*)rq + rq->sadb_x_ipsecrequest_len);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e20bde9cc7b1..62bc4cd0b7be 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2769,6 +2769,7 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 }
 
 static struct nft_rule *nft_rule_lookup_byid(const struct net *net,
+					     const struct nft_chain *chain,
 					     const struct nlattr *nla)
 {
 	u32 id = ntohl(nla_get_be32(nla));
@@ -2778,6 +2779,7 @@ static struct nft_rule *nft_rule_lookup_byid(const struct net *net,
 		struct nft_rule *rule = nft_trans_rule(trans);
 
 		if (trans->msg_type == NFT_MSG_NEWRULE &&
+		    trans->ctx.chain == chain &&
 		    id == nft_trans_rule_id(trans))
 			return rule;
 	}
@@ -2824,7 +2826,7 @@ static int nf_tables_delrule(struct net *net, struct sock *nlsk,
 
 			err = nft_delrule(&ctx, rule);
 		} else if (nla[NFTA_RULE_ID]) {
-			rule = nft_rule_lookup_byid(net, nla[NFTA_RULE_ID]);
+			rule = nft_rule_lookup_byid(net, chain, nla[NFTA_RULE_ID]);
 			if (IS_ERR(rule)) {
 				NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_ID]);
 				return PTR_ERR(rule);
@@ -3687,6 +3689,12 @@ static int nf_tables_delset(struct net *net, struct sock *nlsk,
 	return nft_delset(&ctx, set);
 }
 
+static int nft_validate_register_store(const struct nft_ctx *ctx,
+				       enum nft_registers reg,
+				       const struct nft_data *data,
+				       enum nft_data_types type,
+				       unsigned int len);
+
 static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
 					struct nft_set *set,
 					const struct nft_set_iter *iter,
@@ -4134,11 +4142,54 @@ static int nft_setelem_parse_flags(const struct nft_set *set,
 	return 0;
 }
 
+static int nft_setelem_parse_key(struct nft_ctx *ctx, struct nft_set *set,
+				 struct nft_data *key, struct nlattr *attr)
+{
+	struct nft_data_desc desc;
+	int err;
+
+	err = nft_data_init(ctx, key, NFT_DATA_VALUE_MAXLEN, &desc, attr);
+	if (err < 0)
+		return err;
+
+	if (desc.type != NFT_DATA_VALUE || desc.len != set->klen) {
+		nft_data_release(key, desc.type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nft_setelem_parse_data(struct nft_ctx *ctx, struct nft_set *set,
+				  struct nft_data_desc *desc,
+				  struct nft_data *data,
+				  struct nlattr *attr)
+{
+	u32 dtype;
+	int err;
+
+	err = nft_data_init(ctx, data, NFT_DATA_VALUE_MAXLEN, desc, attr);
+	if (err < 0)
+		return err;
+
+	if (set->dtype == NFT_DATA_VERDICT)
+		dtype = NFT_DATA_VERDICT;
+	else
+		dtype = NFT_DATA_VALUE;
+
+	if (dtype != desc->type ||
+	    set->dlen != desc->len) {
+		nft_data_release(data, desc->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nft_get_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr)
 {
 	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
-	struct nft_data_desc desc;
 	struct nft_set_elem elem;
 	struct sk_buff *skb;
 	uint32_t flags = 0;
@@ -4157,17 +4208,11 @@ static int nft_get_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	if (err < 0)
 		return err;
 
-	err = nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &desc,
-			    nla[NFTA_SET_ELEM_KEY]);
+	err = nft_setelem_parse_key(ctx, set, &elem.key.val,
+				    nla[NFTA_SET_ELEM_KEY]);
 	if (err < 0)
 		return err;
 
-	err = -EINVAL;
-	if (desc.type != NFT_DATA_VALUE || desc.len != set->klen) {
-		nft_data_release(&elem.key.val, desc.type);
-		return err;
-	}
-
 	priv = set->ops->get(ctx->net, set, &elem, flags);
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
@@ -4358,14 +4403,13 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 {
 	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
 	u8 genmask = nft_genmask_next(ctx->net);
-	struct nft_data_desc d1, d2;
 	struct nft_set_ext_tmpl tmpl;
 	struct nft_set_ext *ext, *ext2;
 	struct nft_set_elem elem;
 	struct nft_set_binding *binding;
 	struct nft_object *obj = NULL;
 	struct nft_userdata *udata;
-	struct nft_data data;
+	struct nft_data_desc desc;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
 	u32 flags = 0;
@@ -4398,6 +4442,15 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			return -EINVAL;
 	}
 
+	if (set->flags & NFT_SET_OBJECT) {
+		if (!nla[NFTA_SET_ELEM_OBJREF] &&
+		    !(flags & NFT_SET_ELEM_INTERVAL_END))
+			return -EINVAL;
+	} else {
+		if (nla[NFTA_SET_ELEM_OBJREF])
+			return -EINVAL;
+	}
+
 	if ((flags & NFT_SET_ELEM_INTERVAL_END) &&
 	     (nla[NFTA_SET_ELEM_DATA] ||
 	      nla[NFTA_SET_ELEM_OBJREF] ||
@@ -4419,15 +4472,12 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		timeout = set->timeout;
 	}
 
-	err = nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &d1,
-			    nla[NFTA_SET_ELEM_KEY]);
+	err = nft_setelem_parse_key(ctx, set, &elem.key.val,
+				    nla[NFTA_SET_ELEM_KEY]);
 	if (err < 0)
 		goto err1;
-	err = -EINVAL;
-	if (d1.type != NFT_DATA_VALUE || d1.len != set->klen)
-		goto err2;
 
-	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, d1.len);
+	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, set->klen);
 	if (timeout > 0) {
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_EXPIRATION);
 		if (timeout != set->timeout)
@@ -4435,10 +4485,6 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	if (nla[NFTA_SET_ELEM_OBJREF] != NULL) {
-		if (!(set->flags & NFT_SET_OBJECT)) {
-			err = -EINVAL;
-			goto err2;
-		}
 		obj = nft_obj_lookup(ctx->table, nla[NFTA_SET_ELEM_OBJREF],
 				     set->objtype, genmask);
 		if (IS_ERR(obj)) {
@@ -4449,15 +4495,11 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	if (nla[NFTA_SET_ELEM_DATA] != NULL) {
-		err = nft_data_init(ctx, &data, sizeof(data), &d2,
-				    nla[NFTA_SET_ELEM_DATA]);
+		err = nft_setelem_parse_data(ctx, set, &desc, &elem.data.val,
+					     nla[NFTA_SET_ELEM_DATA]);
 		if (err < 0)
 			goto err2;
 
-		err = -EINVAL;
-		if (set->dtype != NFT_DATA_VERDICT && d2.len != set->dlen)
-			goto err3;
-
 		dreg = nft_type_to_reg(set->dtype);
 		list_for_each_entry(binding, &set->bindings, list) {
 			struct nft_ctx bind_ctx = {
@@ -4471,19 +4513,19 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 				continue;
 
 			err = nft_validate_register_store(&bind_ctx, dreg,
-							  &data,
-							  d2.type, d2.len);
+							  &elem.data.val,
+							  desc.type, desc.len);
 			if (err < 0)
 				goto err3;
 
-			if (d2.type == NFT_DATA_VERDICT &&
-			    (data.verdict.code == NFT_GOTO ||
-			     data.verdict.code == NFT_JUMP))
+			if (desc.type == NFT_DATA_VERDICT &&
+			    (elem.data.val.verdict.code == NFT_GOTO ||
+			     elem.data.val.verdict.code == NFT_JUMP))
 				nft_validate_state_update(ctx->net,
 							  NFT_VALIDATE_NEED);
 		}
 
-		nft_set_ext_add_length(&tmpl, NFT_SET_EXT_DATA, d2.len);
+		nft_set_ext_add_length(&tmpl, NFT_SET_EXT_DATA, desc.len);
 	}
 
 	/* The full maximum length of userdata can exceed the maximum
@@ -4499,7 +4541,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	err = -ENOMEM;
-	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data, data.data,
+	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data,
+				      elem.data.val.data,
 				      timeout, GFP_KERNEL);
 	if (elem.priv == NULL)
 		goto err3;
@@ -4566,9 +4609,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	kfree(elem.priv);
 err3:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
-		nft_data_release(&data, d2.type);
+		nft_data_release(&elem.data.val, desc.type);
 err2:
-	nft_data_release(&elem.key.val, d1.type);
+	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 err1:
 	return err;
 }
@@ -4664,7 +4707,6 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 {
 	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
 	struct nft_set_ext_tmpl tmpl;
-	struct nft_data_desc desc;
 	struct nft_set_elem elem;
 	struct nft_set_ext *ext;
 	struct nft_trans *trans;
@@ -4675,11 +4717,10 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 	err = nla_parse_nested(nla, NFTA_SET_ELEM_MAX, attr,
 			       nft_set_elem_policy, NULL);
 	if (err < 0)
-		goto err1;
+		return err;
 
-	err = -EINVAL;
 	if (nla[NFTA_SET_ELEM_KEY] == NULL)
-		goto err1;
+		return -EINVAL;
 
 	nft_set_ext_prepare(&tmpl);
 
@@ -4689,37 +4730,31 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 	if (flags != 0)
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_FLAGS);
 
-	err = nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &desc,
-			    nla[NFTA_SET_ELEM_KEY]);
+	err = nft_setelem_parse_key(ctx, set, &elem.key.val,
+				    nla[NFTA_SET_ELEM_KEY]);
 	if (err < 0)
-		goto err1;
-
-	err = -EINVAL;
-	if (desc.type != NFT_DATA_VALUE || desc.len != set->klen)
-		goto err2;
+		return err;
 
-	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, desc.len);
+	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, set->klen);
 
 	err = -ENOMEM;
 	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data, NULL, 0,
 				      GFP_KERNEL);
 	if (elem.priv == NULL)
-		goto err2;
+		goto fail_elem;
 
 	ext = nft_set_elem_ext(set, elem.priv);
 	if (flags)
 		*nft_set_ext_flags(ext) = flags;
 
 	trans = nft_trans_elem_alloc(ctx, NFT_MSG_DELSETELEM, set);
-	if (trans == NULL) {
-		err = -ENOMEM;
-		goto err3;
-	}
+	if (trans == NULL)
+		goto fail_trans;
 
 	priv = set->ops->deactivate(ctx->net, set, &elem);
 	if (priv == NULL) {
 		err = -ENOENT;
-		goto err4;
+		goto fail_ops;
 	}
 	kfree(elem.priv);
 	elem.priv = priv;
@@ -4730,13 +4765,12 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
 	return 0;
 
-err4:
+fail_ops:
 	kfree(trans);
-err3:
+fail_trans:
 	kfree(elem.priv);
-err2:
-	nft_data_release(&elem.key.val, desc.type);
-err1:
+fail_elem:
+	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 	return err;
 }
 
@@ -6972,28 +7006,24 @@ int nft_parse_u32_check(const struct nlattr *attr, int max, u32 *dest)
 }
 EXPORT_SYMBOL_GPL(nft_parse_u32_check);
 
-/**
- *	nft_parse_register - parse a register value from a netlink attribute
- *
- *	@attr: netlink attribute
- *
- *	Parse and translate a register value from a netlink attribute.
- *	Registers used to be 128 bit wide, these register numbers will be
- *	mapped to the corresponding 32 bit register numbers.
- */
-unsigned int nft_parse_register(const struct nlattr *attr)
+static int nft_parse_register(const struct nlattr *attr, u32 *preg)
 {
 	unsigned int reg;
 
 	reg = ntohl(nla_get_be32(attr));
 	switch (reg) {
 	case NFT_REG_VERDICT...NFT_REG_4:
-		return reg * NFT_REG_SIZE / NFT_REG32_SIZE;
+		*preg = reg * NFT_REG_SIZE / NFT_REG32_SIZE;
+		break;
+	case NFT_REG32_00...NFT_REG32_15:
+		*preg = reg + NFT_REG_SIZE / NFT_REG32_SIZE - NFT_REG32_00;
+		break;
 	default:
-		return reg + NFT_REG_SIZE / NFT_REG32_SIZE - NFT_REG32_00;
+		return -ERANGE;
 	}
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(nft_parse_register);
 
 /**
  *	nft_dump_register - dump a register value to a netlink attribute
@@ -7026,7 +7056,7 @@ EXPORT_SYMBOL_GPL(nft_dump_register);
  * 	Validate that the input register is one of the general purpose
  * 	registers and that the length of the load is within the bounds.
  */
-int nft_validate_register_load(enum nft_registers reg, unsigned int len)
+static int nft_validate_register_load(enum nft_registers reg, unsigned int len)
 {
 	if (reg < NFT_REG_1 * NFT_REG_SIZE / NFT_REG32_SIZE)
 		return -EINVAL;
@@ -7037,7 +7067,24 @@ int nft_validate_register_load(enum nft_registers reg, unsigned int len)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nft_validate_register_load);
+
+int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len)
+{
+	u32 reg;
+	int err;
+
+	err = nft_parse_register(attr, &reg);
+	if (err < 0)
+		return err;
+
+	err = nft_validate_register_load(reg, len);
+	if (err < 0)
+		return err;
+
+	*sreg = reg;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nft_parse_register_load);
 
 /**
  *	nft_validate_register_store - validate an expressions' register store
@@ -7053,10 +7100,11 @@ EXPORT_SYMBOL_GPL(nft_validate_register_load);
  * 	A value of NULL for the data means that its runtime gathered
  * 	data.
  */
-int nft_validate_register_store(const struct nft_ctx *ctx,
-				enum nft_registers reg,
-				const struct nft_data *data,
-				enum nft_data_types type, unsigned int len)
+static int nft_validate_register_store(const struct nft_ctx *ctx,
+				       enum nft_registers reg,
+				       const struct nft_data *data,
+				       enum nft_data_types type,
+				       unsigned int len)
 {
 	int err;
 
@@ -7088,7 +7136,27 @@ int nft_validate_register_store(const struct nft_ctx *ctx,
 		return 0;
 	}
 }
-EXPORT_SYMBOL_GPL(nft_validate_register_store);
+
+int nft_parse_register_store(const struct nft_ctx *ctx,
+			     const struct nlattr *attr, u8 *dreg,
+			     const struct nft_data *data,
+			     enum nft_data_types type, unsigned int len)
+{
+	int err;
+	u32 reg;
+
+	err = nft_parse_register(attr, &reg);
+	if (err < 0)
+		return err;
+
+	err = nft_validate_register_store(ctx, reg, data, type, len);
+	if (err < 0)
+		return err;
+
+	*dreg = reg;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nft_parse_register_store);
 
 static const struct nla_policy nft_verdict_policy[NFTA_VERDICT_MAX + 1] = {
 	[NFTA_VERDICT_CODE]	= { .type = NLA_U32 },
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 058ee84ea531..c1055251ebde 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -18,8 +18,8 @@
 #include <net/netfilter/nf_tables.h>
 
 struct nft_bitwise {
-	enum nft_registers	sreg:8;
-	enum nft_registers	dreg:8;
+	u8			sreg;
+	u8			dreg;
 	u8			len;
 	struct nft_data		mask;
 	struct nft_data		xor;
@@ -68,14 +68,14 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 
 	priv->len = len;
 
-	priv->sreg = nft_parse_register(tb[NFTA_BITWISE_SREG]);
-	err = nft_validate_register_load(priv->sreg, priv->len);
+	err = nft_parse_register_load(tb[NFTA_BITWISE_SREG], &priv->sreg,
+				      priv->len);
 	if (err < 0)
 		return err;
 
-	priv->dreg = nft_parse_register(tb[NFTA_BITWISE_DREG]);
-	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFT_DATA_VALUE, priv->len);
+	err = nft_parse_register_store(ctx, tb[NFTA_BITWISE_DREG],
+				       &priv->dreg, NULL, NFT_DATA_VALUE,
+				       priv->len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 13d4e421a6b3..5e1fbdd7b284 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -19,8 +19,8 @@
 #include <net/netfilter/nf_tables.h>
 
 struct nft_byteorder {
-	enum nft_registers	sreg:8;
-	enum nft_registers	dreg:8;
+	u8			sreg;
+	u8			dreg;
 	enum nft_byteorder_ops	op:8;
 	u8			len;
 	u8			size;
@@ -133,20 +133,20 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 		return -EINVAL;
 	}
 
-	priv->sreg = nft_parse_register(tb[NFTA_BYTEORDER_SREG]);
 	err = nft_parse_u32_check(tb[NFTA_BYTEORDER_LEN], U8_MAX, &len);
 	if (err < 0)
 		return err;
 
 	priv->len = len;
 
-	err = nft_validate_register_load(priv->sreg, priv->len);
+	err = nft_parse_register_load(tb[NFTA_BYTEORDER_SREG], &priv->sreg,
+				      priv->len);
 	if (err < 0)
 		return err;
 
-	priv->dreg = nft_parse_register(tb[NFTA_BYTEORDER_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, priv->len);
+	return nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
+					&priv->dreg, NULL, NFT_DATA_VALUE,
+					priv->len);
 }
 
 static int nft_byteorder_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/netfilter/nft_cmp.c b/net/netfilter/nft_cmp.c
index 7007045c0849..36bf64ebc892 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -19,7 +19,7 @@
 
 struct nft_cmp_expr {
 	struct nft_data		data;
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	u8			len;
 	enum nft_cmp_ops	op:8;
 };
@@ -88,8 +88,7 @@ static int nft_cmp_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return err;
 	}
 
-	priv->sreg = nft_parse_register(tb[NFTA_CMP_SREG]);
-	err = nft_validate_register_load(priv->sreg, desc.len);
+	err = nft_parse_register_load(tb[NFTA_CMP_SREG], &priv->sreg, desc.len);
 	if (err < 0)
 		return err;
 
@@ -139,8 +138,7 @@ static int nft_cmp_fast_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	priv->sreg = nft_parse_register(tb[NFTA_CMP_SREG]);
-	err = nft_validate_register_load(priv->sreg, desc.len);
+	err = nft_parse_register_load(tb[NFTA_CMP_SREG], &priv->sreg, desc.len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 5dd87748afa8..f29f02805bcc 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -29,8 +29,8 @@ struct nft_ct {
 	enum nft_ct_keys	key:8;
 	enum ip_conntrack_dir	dir:8;
 	union {
-		enum nft_registers	dreg:8;
-		enum nft_registers	sreg:8;
+		u8		dreg;
+		u8		sreg;
 	};
 };
 
@@ -486,9 +486,8 @@ static int nft_ct_get_init(const struct nft_ctx *ctx,
 		}
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_CT_DREG]);
-	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFT_DATA_VALUE, len);
+	err = nft_parse_register_store(ctx, tb[NFTA_CT_DREG], &priv->dreg, NULL,
+				       NFT_DATA_VALUE, len);
 	if (err < 0)
 		return err;
 
@@ -581,8 +580,7 @@ static int nft_ct_set_init(const struct nft_ctx *ctx,
 		}
 	}
 
-	priv->sreg = nft_parse_register(tb[NFTA_CT_SREG]);
-	err = nft_validate_register_load(priv->sreg, len);
+	err = nft_parse_register_load(tb[NFTA_CT_SREG], &priv->sreg, len);
 	if (err < 0)
 		goto err1;
 
diff --git a/net/netfilter/nft_dup_netdev.c b/net/netfilter/nft_dup_netdev.c
index 2cc1e0ef56e8..e862f916efa0 100644
--- a/net/netfilter/nft_dup_netdev.c
+++ b/net/netfilter/nft_dup_netdev.c
@@ -16,7 +16,7 @@
 #include <net/netfilter/nf_dup_netdev.h>
 
 struct nft_dup_netdev {
-	enum nft_registers	sreg_dev:8;
+	u8	sreg_dev;
 };
 
 static void nft_dup_netdev_eval(const struct nft_expr *expr,
@@ -42,8 +42,8 @@ static int nft_dup_netdev_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_DUP_SREG_DEV] == NULL)
 		return -EINVAL;
 
-	priv->sreg_dev = nft_parse_register(tb[NFTA_DUP_SREG_DEV]);
-	return nft_validate_register_load(priv->sreg_dev, sizeof(int));
+	return nft_parse_register_load(tb[NFTA_DUP_SREG_DEV], &priv->sreg_dev,
+				       sizeof(int));
 }
 
 static const struct nft_expr_ops nft_dup_netdev_ingress_ops;
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index ea73130427eb..c5d42e704f04 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -20,8 +20,8 @@ struct nft_dynset {
 	struct nft_set			*set;
 	struct nft_set_ext_tmpl		tmpl;
 	enum nft_dynset_ops		op:8;
-	enum nft_registers		sreg_key:8;
-	enum nft_registers		sreg_data:8;
+	u8				sreg_key;
+	u8				sreg_data;
 	bool				invert;
 	u64				timeout;
 	struct nft_expr			*expr;
@@ -166,8 +166,8 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 						tb[NFTA_DYNSET_TIMEOUT])));
 	}
 
-	priv->sreg_key = nft_parse_register(tb[NFTA_DYNSET_SREG_KEY]);
-	err = nft_validate_register_load(priv->sreg_key, set->klen);
+	err = nft_parse_register_load(tb[NFTA_DYNSET_SREG_KEY], &priv->sreg_key,
+				      set->klen);
 	if (err < 0)
 		return err;
 
@@ -177,8 +177,8 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 		if (set->dtype == NFT_DATA_VERDICT)
 			return -EOPNOTSUPP;
 
-		priv->sreg_data = nft_parse_register(tb[NFTA_DYNSET_SREG_DATA]);
-		err = nft_validate_register_load(priv->sreg_data, set->dlen);
+		err = nft_parse_register_load(tb[NFTA_DYNSET_SREG_DATA],
+					      &priv->sreg_data, set->dlen);
 		if (err < 0)
 			return err;
 	} else if (set->flags & NFT_SET_MAP)
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 93fee4106019..8d0f14cd7cc3 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -22,8 +22,8 @@ struct nft_exthdr {
 	u8			offset;
 	u8			len;
 	u8			op;
-	enum nft_registers	dreg:8;
-	enum nft_registers	sreg:8;
+	u8			dreg;
+	u8			sreg;
 	u8			flags;
 };
 
@@ -258,12 +258,12 @@ static int nft_exthdr_init(const struct nft_ctx *ctx,
 	priv->type   = nla_get_u8(tb[NFTA_EXTHDR_TYPE]);
 	priv->offset = offset;
 	priv->len    = len;
-	priv->dreg   = nft_parse_register(tb[NFTA_EXTHDR_DREG]);
 	priv->flags  = flags;
 	priv->op     = op;
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, priv->len);
+	return nft_parse_register_store(ctx, tb[NFTA_EXTHDR_DREG],
+					&priv->dreg, NULL, NFT_DATA_VALUE,
+					priv->len);
 }
 
 static int nft_exthdr_tcp_set_init(const struct nft_ctx *ctx,
@@ -308,11 +308,11 @@ static int nft_exthdr_tcp_set_init(const struct nft_ctx *ctx,
 	priv->type   = nla_get_u8(tb[NFTA_EXTHDR_TYPE]);
 	priv->offset = offset;
 	priv->len    = len;
-	priv->sreg   = nft_parse_register(tb[NFTA_EXTHDR_SREG]);
 	priv->flags  = flags;
 	priv->op     = op;
 
-	return nft_validate_register_load(priv->sreg, priv->len);
+	return nft_parse_register_load(tb[NFTA_EXTHDR_SREG], &priv->sreg,
+				       priv->len);
 }
 
 static int nft_exthdr_dump_common(struct sk_buff *skb, const struct nft_exthdr *priv)
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 21df8cccea65..ce6891337304 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -88,7 +88,6 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 
 	priv->result = ntohl(nla_get_be32(tb[NFTA_FIB_RESULT]));
-	priv->dreg = nft_parse_register(tb[NFTA_FIB_DREG]);
 
 	switch (priv->result) {
 	case NFT_FIB_RESULT_OIF:
@@ -108,8 +107,8 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 	}
 
-	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFT_DATA_VALUE, len);
+	err = nft_parse_register_store(ctx, tb[NFTA_FIB_DREG], &priv->dreg,
+				       NULL, NFT_DATA_VALUE, len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 10a12e094929..2efbe78de3b2 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -20,7 +20,7 @@
 #include <net/ip.h>
 
 struct nft_fwd_netdev {
-	enum nft_registers	sreg_dev:8;
+	u8	sreg_dev;
 };
 
 static void nft_fwd_netdev_eval(const struct nft_expr *expr,
@@ -49,8 +49,8 @@ static int nft_fwd_netdev_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_FWD_SREG_DEV] == NULL)
 		return -EINVAL;
 
-	priv->sreg_dev = nft_parse_register(tb[NFTA_FWD_SREG_DEV]);
-	return nft_validate_register_load(priv->sreg_dev, sizeof(int));
+	return nft_parse_register_load(tb[NFTA_FWD_SREG_DEV], &priv->sreg_dev,
+				       sizeof(int));
 }
 
 static const struct nft_expr_ops nft_fwd_netdev_ingress_ops;
@@ -69,8 +69,8 @@ static int nft_fwd_netdev_dump(struct sk_buff *skb, const struct nft_expr *expr)
 }
 
 struct nft_fwd_neigh {
-	enum nft_registers	sreg_dev:8;
-	enum nft_registers	sreg_addr:8;
+	u8			sreg_dev;
+	u8			sreg_addr;
 	u8			nfproto;
 };
 
@@ -148,8 +148,6 @@ static int nft_fwd_neigh_init(const struct nft_ctx *ctx,
 	    !tb[NFTA_FWD_NFPROTO])
 		return -EINVAL;
 
-	priv->sreg_dev = nft_parse_register(tb[NFTA_FWD_SREG_DEV]);
-	priv->sreg_addr = nft_parse_register(tb[NFTA_FWD_SREG_ADDR]);
 	priv->nfproto = ntohl(nla_get_be32(tb[NFTA_FWD_NFPROTO]));
 
 	switch (priv->nfproto) {
@@ -163,11 +161,13 @@ static int nft_fwd_neigh_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	err = nft_validate_register_load(priv->sreg_dev, sizeof(int));
+	err = nft_parse_register_load(tb[NFTA_FWD_SREG_DEV], &priv->sreg_dev,
+				      sizeof(int));
 	if (err < 0)
 		return err;
 
-	return nft_validate_register_load(priv->sreg_addr, addr_len);
+	return nft_parse_register_load(tb[NFTA_FWD_SREG_ADDR], &priv->sreg_addr,
+				       addr_len);
 }
 
 static const struct nft_expr_ops nft_fwd_netdev_ingress_ops;
diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index b8f23f75aea6..513419aca9c6 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -18,8 +18,8 @@
 #include <linux/jhash.h>
 
 struct nft_jhash {
-	enum nft_registers      sreg:8;
-	enum nft_registers      dreg:8;
+	u8			sreg;
+	u8			dreg;
 	u8			len;
 	bool			autogen_seed:1;
 	u32			modulus;
@@ -65,7 +65,7 @@ static void nft_jhash_map_eval(const struct nft_expr *expr,
 }
 
 struct nft_symhash {
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u32			modulus;
 	u32			offset;
 	struct nft_set		*map;
@@ -136,9 +136,6 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_HASH_OFFSET])
 		priv->offset = ntohl(nla_get_be32(tb[NFTA_HASH_OFFSET]));
 
-	priv->sreg = nft_parse_register(tb[NFTA_HASH_SREG]);
-	priv->dreg = nft_parse_register(tb[NFTA_HASH_DREG]);
-
 	err = nft_parse_u32_check(tb[NFTA_HASH_LEN], U8_MAX, &len);
 	if (err < 0)
 		return err;
@@ -147,6 +144,10 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 
 	priv->len = len;
 
+	err = nft_parse_register_load(tb[NFTA_HASH_SREG], &priv->sreg, len);
+	if (err < 0)
+		return err;
+
 	priv->modulus = ntohl(nla_get_be32(tb[NFTA_HASH_MODULUS]));
 	if (priv->modulus < 1)
 		return -ERANGE;
@@ -161,9 +162,8 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 		get_random_bytes(&priv->seed, sizeof(priv->seed));
 	}
 
-	return nft_validate_register_load(priv->sreg, len) &&
-	       nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, sizeof(u32));
+	return nft_parse_register_store(ctx, tb[NFTA_HASH_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, sizeof(u32));
 }
 
 static int nft_jhash_map_init(const struct nft_ctx *ctx,
@@ -193,8 +193,6 @@ static int nft_symhash_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_HASH_OFFSET])
 		priv->offset = ntohl(nla_get_be32(tb[NFTA_HASH_OFFSET]));
 
-	priv->dreg = nft_parse_register(tb[NFTA_HASH_DREG]);
-
 	priv->modulus = ntohl(nla_get_be32(tb[NFTA_HASH_MODULUS]));
 	if (priv->modulus < 1)
 		return -ERANGE;
@@ -202,8 +200,9 @@ static int nft_symhash_init(const struct nft_ctx *ctx,
 	if (priv->offset + priv->modulus - 1 < priv->offset)
 		return -EOVERFLOW;
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, sizeof(u32));
+	return nft_parse_register_store(ctx, tb[NFTA_HASH_DREG],
+					&priv->dreg, NULL, NFT_DATA_VALUE,
+					sizeof(u32));
 }
 
 static int nft_symhash_map_init(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 3f6d1d2a6281..af4e2a4bce93 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -50,9 +50,9 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 
 	priv->dlen = desc.len;
 
-	priv->dreg = nft_parse_register(tb[NFTA_IMMEDIATE_DREG]);
-	err = nft_validate_register_store(ctx, priv->dreg, &priv->data,
-					  desc.type, desc.len);
+	err = nft_parse_register_store(ctx, tb[NFTA_IMMEDIATE_DREG],
+				       &priv->dreg, &priv->data, desc.type,
+				       desc.len);
 	if (err < 0)
 		goto err1;
 
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index cb9e937a5ce0..3c380fb32651 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -20,8 +20,8 @@
 
 struct nft_lookup {
 	struct nft_set			*set;
-	enum nft_registers		sreg:8;
-	enum nft_registers		dreg:8;
+	u8				sreg;
+	u8				dreg;
 	bool				invert;
 	struct nft_set_binding		binding;
 };
@@ -76,8 +76,8 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	priv->sreg = nft_parse_register(tb[NFTA_LOOKUP_SREG]);
-	err = nft_validate_register_load(priv->sreg, set->klen);
+	err = nft_parse_register_load(tb[NFTA_LOOKUP_SREG], &priv->sreg,
+				      set->klen);
 	if (err < 0)
 		return err;
 
@@ -100,9 +100,9 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
 		if (!(set->flags & NFT_SET_MAP))
 			return -EINVAL;
 
-		priv->dreg = nft_parse_register(tb[NFTA_LOOKUP_DREG]);
-		err = nft_validate_register_store(ctx, priv->dreg, NULL,
-						  set->dtype, set->dlen);
+		err = nft_parse_register_store(ctx, tb[NFTA_LOOKUP_DREG],
+					       &priv->dreg, NULL, set->dtype,
+					       set->dlen);
 		if (err < 0)
 			return err;
 	} else if (set->flags & NFT_SET_MAP)
diff --git a/net/netfilter/nft_masq.c b/net/netfilter/nft_masq.c
index 9d8655bc1bea..4ecfebc2fdc4 100644
--- a/net/netfilter/nft_masq.c
+++ b/net/netfilter/nft_masq.c
@@ -53,19 +53,15 @@ int nft_masq_init(const struct nft_ctx *ctx,
 	}
 
 	if (tb[NFTA_MASQ_REG_PROTO_MIN]) {
-		priv->sreg_proto_min =
-			nft_parse_register(tb[NFTA_MASQ_REG_PROTO_MIN]);
-
-		err = nft_validate_register_load(priv->sreg_proto_min, plen);
+		err = nft_parse_register_load(tb[NFTA_MASQ_REG_PROTO_MIN],
+					      &priv->sreg_proto_min, plen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_MASQ_REG_PROTO_MAX]) {
-			priv->sreg_proto_max =
-				nft_parse_register(tb[NFTA_MASQ_REG_PROTO_MAX]);
-
-			err = nft_validate_register_load(priv->sreg_proto_max,
-							 plen);
+			err = nft_parse_register_load(tb[NFTA_MASQ_REG_PROTO_MAX],
+						      &priv->sreg_proto_max,
+						      plen);
 			if (err < 0)
 				return err;
 		} else {
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 297fe7d97c18..061a29bd3066 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -30,8 +30,8 @@
 struct nft_meta {
 	enum nft_meta_keys	key:8;
 	union {
-		enum nft_registers	dreg:8;
-		enum nft_registers	sreg:8;
+		u8		dreg;
+		u8		sreg;
 	};
 };
 
@@ -358,9 +358,8 @@ static int nft_meta_get_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_META_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_META_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 static int nft_meta_get_validate(const struct nft_ctx *ctx,
@@ -448,8 +447,7 @@ static int nft_meta_set_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->sreg = nft_parse_register(tb[NFTA_META_SREG]);
-	err = nft_validate_register_load(priv->sreg, len);
+	err = nft_parse_register_load(tb[NFTA_META_SREG], &priv->sreg, len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index 2c3d7ff6f58a..aa6149cc8c87 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -27,10 +27,10 @@
 #include <net/ip.h>
 
 struct nft_nat {
-	enum nft_registers      sreg_addr_min:8;
-	enum nft_registers      sreg_addr_max:8;
-	enum nft_registers      sreg_proto_min:8;
-	enum nft_registers      sreg_proto_max:8;
+	u8			sreg_addr_min;
+	u8			sreg_addr_max;
+	u8			sreg_proto_min;
+	u8			sreg_proto_max;
 	enum nf_nat_manip_type  type:8;
 	u8			family;
 	u16			flags;
@@ -160,18 +160,15 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	priv->family = family;
 
 	if (tb[NFTA_NAT_REG_ADDR_MIN]) {
-		priv->sreg_addr_min =
-			nft_parse_register(tb[NFTA_NAT_REG_ADDR_MIN]);
-		err = nft_validate_register_load(priv->sreg_addr_min, alen);
+		err = nft_parse_register_load(tb[NFTA_NAT_REG_ADDR_MIN],
+					      &priv->sreg_addr_min, alen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_NAT_REG_ADDR_MAX]) {
-			priv->sreg_addr_max =
-				nft_parse_register(tb[NFTA_NAT_REG_ADDR_MAX]);
-
-			err = nft_validate_register_load(priv->sreg_addr_max,
-							 alen);
+			err = nft_parse_register_load(tb[NFTA_NAT_REG_ADDR_MAX],
+						      &priv->sreg_addr_max,
+						      alen);
 			if (err < 0)
 				return err;
 		} else {
@@ -181,19 +178,15 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 
 	plen = FIELD_SIZEOF(struct nf_nat_range, min_addr.all);
 	if (tb[NFTA_NAT_REG_PROTO_MIN]) {
-		priv->sreg_proto_min =
-			nft_parse_register(tb[NFTA_NAT_REG_PROTO_MIN]);
-
-		err = nft_validate_register_load(priv->sreg_proto_min, plen);
+		err = nft_parse_register_load(tb[NFTA_NAT_REG_PROTO_MIN],
+					      &priv->sreg_proto_min, plen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_NAT_REG_PROTO_MAX]) {
-			priv->sreg_proto_max =
-				nft_parse_register(tb[NFTA_NAT_REG_PROTO_MAX]);
-
-			err = nft_validate_register_load(priv->sreg_proto_max,
-							 plen);
+			err = nft_parse_register_load(tb[NFTA_NAT_REG_PROTO_MAX],
+						      &priv->sreg_proto_max,
+						      plen);
 			if (err < 0)
 				return err;
 		} else {
diff --git a/net/netfilter/nft_numgen.c b/net/netfilter/nft_numgen.c
index 3cc1b3dc3c3c..8ff82f17ecba 100644
--- a/net/netfilter/nft_numgen.c
+++ b/net/netfilter/nft_numgen.c
@@ -20,7 +20,7 @@
 static DEFINE_PER_CPU(struct rnd_state, nft_numgen_prandom_state);
 
 struct nft_ng_inc {
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u32			modulus;
 	atomic_t		counter;
 	u32			offset;
@@ -70,11 +70,10 @@ static int nft_ng_inc_init(const struct nft_ctx *ctx,
 	if (priv->offset + priv->modulus - 1 < priv->offset)
 		return -EOVERFLOW;
 
-	priv->dreg = nft_parse_register(tb[NFTA_NG_DREG]);
 	atomic_set(&priv->counter, priv->modulus - 1);
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, sizeof(u32));
+	return nft_parse_register_store(ctx, tb[NFTA_NG_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, sizeof(u32));
 }
 
 static int nft_ng_dump(struct sk_buff *skb, enum nft_registers dreg,
@@ -104,7 +103,7 @@ static int nft_ng_inc_dump(struct sk_buff *skb, const struct nft_expr *expr)
 }
 
 struct nft_ng_random {
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u32			modulus;
 	u32			offset;
 };
@@ -144,10 +143,8 @@ static int nft_ng_random_init(const struct nft_ctx *ctx,
 
 	prandom_init_once(&nft_numgen_prandom_state);
 
-	priv->dreg = nft_parse_register(tb[NFTA_NG_DREG]);
-
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, sizeof(u32));
+	return nft_parse_register_store(ctx, tb[NFTA_NG_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, sizeof(u32));
 }
 
 static int nft_ng_random_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index eff2173db7e4..615f0fcf711c 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -97,7 +97,7 @@ static const struct nft_expr_ops nft_objref_ops = {
 
 struct nft_objref_map {
 	struct nft_set		*set;
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	struct nft_set_binding	binding;
 };
 
@@ -139,8 +139,8 @@ static int nft_objref_map_init(const struct nft_ctx *ctx,
 	if (!(set->flags & NFT_SET_OBJECT))
 		return -EINVAL;
 
-	priv->sreg = nft_parse_register(tb[NFTA_OBJREF_SET_SREG]);
-	err = nft_validate_register_load(priv->sreg, set->klen);
+	err = nft_parse_register_load(tb[NFTA_OBJREF_SET_SREG], &priv->sreg,
+				      set->klen);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index 4fac2d9a4b88..af2ce7a8c587 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -5,7 +5,7 @@
 #include <linux/netfilter/nfnetlink_osf.h>
 
 struct nft_osf {
-	enum nft_registers	dreg:8;
+	u8			dreg;
 };
 
 static const struct nla_policy nft_osf_policy[NFTA_OSF_MAX + 1] = {
@@ -55,9 +55,9 @@ static int nft_osf_init(const struct nft_ctx *ctx,
 	if (!tb[NFTA_OSF_DREG])
 		return -EINVAL;
 
-	priv->dreg = nft_parse_register(tb[NFTA_OSF_DREG]);
-	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFT_DATA_VALUE, NFT_OSF_MAXGENRELEN);
+	err = nft_parse_register_store(ctx, tb[NFTA_OSF_DREG], &priv->dreg,
+				       NULL, NFT_DATA_VALUE,
+				       NFT_OSF_MAXGENRELEN);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 5732b32ab932..77cfd5182784 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -135,10 +135,10 @@ static int nft_payload_init(const struct nft_ctx *ctx,
 	priv->base   = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_BASE]));
 	priv->offset = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_OFFSET]));
 	priv->len    = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_LEN]));
-	priv->dreg   = nft_parse_register(tb[NFTA_PAYLOAD_DREG]);
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, priv->len);
+	return nft_parse_register_store(ctx, tb[NFTA_PAYLOAD_DREG],
+					&priv->dreg, NULL, NFT_DATA_VALUE,
+					priv->len);
 }
 
 static int nft_payload_dump(struct sk_buff *skb, const struct nft_expr *expr)
@@ -338,7 +338,6 @@ static int nft_payload_set_init(const struct nft_ctx *ctx,
 	priv->base        = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_BASE]));
 	priv->offset      = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_OFFSET]));
 	priv->len         = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_LEN]));
-	priv->sreg        = nft_parse_register(tb[NFTA_PAYLOAD_SREG]);
 
 	if (tb[NFTA_PAYLOAD_CSUM_TYPE])
 		csum_type = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_CSUM_TYPE]));
@@ -369,7 +368,8 @@ static int nft_payload_set_init(const struct nft_ctx *ctx,
 	}
 	priv->csum_type = csum_type;
 
-	return nft_validate_register_load(priv->sreg, priv->len);
+	return nft_parse_register_load(tb[NFTA_PAYLOAD_SREG], &priv->sreg,
+				       priv->len);
 }
 
 static int nft_payload_set_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/netfilter/nft_queue.c b/net/netfilter/nft_queue.c
index 98613658d4ac..de5f1bda9d6f 100644
--- a/net/netfilter/nft_queue.c
+++ b/net/netfilter/nft_queue.c
@@ -22,10 +22,10 @@
 static u32 jhash_initval __read_mostly;
 
 struct nft_queue {
-	enum nft_registers	sreg_qnum:8;
-	u16			queuenum;
-	u16			queues_total;
-	u16			flags;
+	u8	sreg_qnum;
+	u16	queuenum;
+	u16	queues_total;
+	u16	flags;
 };
 
 static void nft_queue_eval(const struct nft_expr *expr,
@@ -114,8 +114,8 @@ static int nft_queue_sreg_init(const struct nft_ctx *ctx,
 	struct nft_queue *priv = nft_expr_priv(expr);
 	int err;
 
-	priv->sreg_qnum = nft_parse_register(tb[NFTA_QUEUE_SREG_QNUM]);
-	err = nft_validate_register_load(priv->sreg_qnum, sizeof(u32));
+	err = nft_parse_register_load(tb[NFTA_QUEUE_SREG_QNUM],
+				      &priv->sreg_qnum, sizeof(u32));
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_range.c b/net/netfilter/nft_range.c
index 2e1d2ec2f52a..a5f74e5b8184 100644
--- a/net/netfilter/nft_range.c
+++ b/net/netfilter/nft_range.c
@@ -18,7 +18,7 @@
 struct nft_range_expr {
 	struct nft_data		data_from;
 	struct nft_data		data_to;
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	u8			len;
 	enum nft_range_ops	op:8;
 };
@@ -90,8 +90,8 @@ static int nft_range_init(const struct nft_ctx *ctx, const struct nft_expr *expr
 		goto err2;
 	}
 
-	priv->sreg = nft_parse_register(tb[NFTA_RANGE_SREG]);
-	err = nft_validate_register_load(priv->sreg, desc_from.len);
+	err = nft_parse_register_load(tb[NFTA_RANGE_SREG], &priv->sreg,
+				      desc_from.len);
 	if (err < 0)
 		goto err2;
 
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index c64cbe78dee7..08a05bd1e817 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -49,19 +49,15 @@ int nft_redir_init(const struct nft_ctx *ctx,
 
 	plen = FIELD_SIZEOF(struct nf_nat_range, min_addr.all);
 	if (tb[NFTA_REDIR_REG_PROTO_MIN]) {
-		priv->sreg_proto_min =
-			nft_parse_register(tb[NFTA_REDIR_REG_PROTO_MIN]);
-
-		err = nft_validate_register_load(priv->sreg_proto_min, plen);
+		err = nft_parse_register_load(tb[NFTA_REDIR_REG_PROTO_MIN],
+					      &priv->sreg_proto_min, plen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_REDIR_REG_PROTO_MAX]) {
-			priv->sreg_proto_max =
-				nft_parse_register(tb[NFTA_REDIR_REG_PROTO_MAX]);
-
-			err = nft_validate_register_load(priv->sreg_proto_max,
-							 plen);
+			err = nft_parse_register_load(tb[NFTA_REDIR_REG_PROTO_MAX],
+						      &priv->sreg_proto_max,
+						      plen);
 			if (err < 0)
 				return err;
 		} else {
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index 76dba9f6b6f6..edce109ef4b0 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -18,7 +18,7 @@
 
 struct nft_rt {
 	enum nft_rt_keys	key:8;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 };
 
 static u16 get_tcpmss(const struct nft_pktinfo *pkt, const struct dst_entry *skbdst)
@@ -134,9 +134,8 @@ static int nft_rt_get_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_RT_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_RT_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 static int nft_rt_get_dump(struct sk_buff *skb,
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 4026ec38526f..7e4f7063f481 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -10,7 +10,7 @@
 struct nft_socket {
 	enum nft_socket_keys		key:8;
 	union {
-		enum nft_registers	dreg:8;
+		u8			dreg;
 	};
 };
 
@@ -119,9 +119,8 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_SOCKET_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_SOCKET_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 static int nft_socket_dump(struct sk_buff *skb,
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index a0e30bf4a845..db780b5985ab 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -13,9 +13,9 @@
 #endif
 
 struct nft_tproxy {
-	enum nft_registers      sreg_addr:8;
-	enum nft_registers      sreg_port:8;
-	u8			family;
+	u8	sreg_addr;
+	u8	sreg_port;
+	u8	family;
 };
 
 static void nft_tproxy_eval_v4(const struct nft_expr *expr,
@@ -254,15 +254,15 @@ static int nft_tproxy_init(const struct nft_ctx *ctx,
 	}
 
 	if (tb[NFTA_TPROXY_REG_ADDR]) {
-		priv->sreg_addr = nft_parse_register(tb[NFTA_TPROXY_REG_ADDR]);
-		err = nft_validate_register_load(priv->sreg_addr, alen);
+		err = nft_parse_register_load(tb[NFTA_TPROXY_REG_ADDR],
+					      &priv->sreg_addr, alen);
 		if (err < 0)
 			return err;
 	}
 
 	if (tb[NFTA_TPROXY_REG_PORT]) {
-		priv->sreg_port = nft_parse_register(tb[NFTA_TPROXY_REG_PORT]);
-		err = nft_validate_register_load(priv->sreg_port, sizeof(u16));
+		err = nft_parse_register_load(tb[NFTA_TPROXY_REG_PORT],
+					      &priv->sreg_port, sizeof(u16));
 		if (err < 0)
 			return err;
 	}
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 3fc55c81f16a..ab69a34210a8 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -14,7 +14,7 @@
 
 struct nft_tunnel {
 	enum nft_tunnel_keys	key:8;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 };
 
 static void nft_tunnel_get_eval(const struct nft_expr *expr,
@@ -72,10 +72,8 @@ static int nft_tunnel_get_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_TUNNEL_DREG]);
-
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_TUNNEL_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 static int nft_tunnel_get_dump(struct sk_buff *skb,
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 6867158656b8..c73784b7b67d 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1983,7 +1983,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
-	if (nlk->cb_running &&
+	if (READ_ONCE(nlk->cb_running) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
 		ret = netlink_dump(sk);
 		if (ret) {
@@ -2265,7 +2265,7 @@ static int netlink_dump(struct sock *sk)
 	if (cb->done)
 		cb->done(cb);
 
-	nlk->cb_running = false;
+	WRITE_ONCE(nlk->cb_running, false);
 	module = cb->module;
 	skb = cb->skb;
 	mutex_unlock(nlk->cb_mutex);
@@ -2325,7 +2325,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 			goto error_put;
 	}
 
-	nlk->cb_running = true;
+	WRITE_ONCE(nlk->cb_running, true);
 	nlk->dump_done_errno = INT_MAX;
 
 	mutex_unlock(nlk->cb_mutex);
@@ -2631,7 +2631,7 @@ static int netlink_seq_show(struct seq_file *seq, void *v)
 			   nlk->groups ? (u32)nlk->groups[0] : 0,
 			   sk_rmem_alloc_get(s),
 			   sk_wmem_alloc_get(s),
-			   nlk->cb_running,
+			   READ_ONCE(nlk->cb_running),
 			   refcount_read(&s->sk_refcnt),
 			   atomic_read(&s->sk_drops),
 			   sock_i_ino(s)
diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index 1a30e165eeb4..a5fa25555d7e 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -80,13 +80,12 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 				       netdev_features_t features)
 {
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
+	u16 mac_offset = skb->mac_header;
 	unsigned int nsh_len, mac_len;
 	__be16 proto;
-	int nhoff;
 
 	skb_reset_network_header(skb);
 
-	nhoff = skb->network_header - skb->mac_header;
 	mac_len = skb->mac_len;
 
 	if (unlikely(!pskb_may_pull(skb, NSH_BASE_HDR_LEN)))
@@ -111,15 +110,14 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 	segs = skb_mac_gso_segment(skb, features);
 	if (IS_ERR_OR_NULL(segs)) {
 		skb_gso_error_unwind(skb, htons(ETH_P_NSH), nsh_len,
-				     skb->network_header - nhoff,
-				     mac_len);
+				     mac_offset, mac_len);
 		goto out;
 	}
 
 	for (skb = segs; skb; skb = skb->next) {
 		skb->protocol = htons(ETH_P_NSH);
 		__skb_push(skb, nsh_len);
-		skb_set_mac_header(skb, -nhoff);
+		skb->mac_header = mac_offset;
 		skb->network_header = skb->mac_header + mac_len;
 		skb->mac_len = mac_len;
 	}
diff --git a/net/socket.c b/net/socket.c
index a5167f03c31d..ce70c01eb2f3 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2555,7 +2555,7 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 		 * error to return on the next call or if the
 		 * app asks about it using getsockopt(SO_ERROR).
 		 */
-		sock->sk->sk_err = -err;
+		WRITE_ONCE(sock->sk->sk_err, -err);
 	}
 out_put:
 	fput_light(sock->file, fput_needed);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e79c32942796..b0dcbb08e60d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -536,7 +536,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	/* Clear state */
 	unix_state_lock(sk);
 	sock_orphan(sk);
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	path	     = u->path;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
@@ -554,7 +554,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 		if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET) {
 			unix_state_lock(skpair);
 			/* No more writes */
-			skpair->sk_shutdown = SHUTDOWN_MASK;
+			WRITE_ONCE(skpair->sk_shutdown, SHUTDOWN_MASK);
 			if (!skb_queue_empty(&sk->sk_receive_queue) || embrion)
 				skpair->sk_err = ECONNRESET;
 			unix_state_unlock(skpair);
@@ -1232,7 +1232,7 @@ static long unix_wait_for_peer(struct sock *other, long timeo)
 
 	sched = !sock_flag(other, SOCK_DEAD) &&
 		!(other->sk_shutdown & RCV_SHUTDOWN) &&
-		unix_recvq_full(other);
+		unix_recvq_full_lockless(other);
 
 	unix_state_unlock(other);
 
@@ -2551,7 +2551,7 @@ static int unix_shutdown(struct socket *sock, int mode)
 	++mode;
 
 	unix_state_lock(sk);
-	sk->sk_shutdown |= mode;
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | mode);
 	other = unix_peer(sk);
 	if (other)
 		sock_hold(other);
@@ -2568,7 +2568,7 @@ static int unix_shutdown(struct socket *sock, int mode)
 		if (mode&SEND_SHUTDOWN)
 			peer_mode |= RCV_SHUTDOWN;
 		unix_state_lock(other);
-		other->sk_shutdown |= peer_mode;
+		WRITE_ONCE(other->sk_shutdown, other->sk_shutdown | peer_mode);
 		unix_state_unlock(other);
 		other->sk_state_change(other);
 		if (peer_mode == SHUTDOWN_MASK)
@@ -2687,16 +2687,18 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask;
+	u8 shutdown;
 
 	sock_poll_wait(file, sock, wait);
 	mask = 0;
+	shutdown = READ_ONCE(sk->sk_shutdown);
 
 	/* exceptional events? */
 	if (sk->sk_err)
 		mask |= EPOLLERR;
-	if (sk->sk_shutdown == SHUTDOWN_MASK)
+	if (shutdown == SHUTDOWN_MASK)
 		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
 
 	/* readable? */
@@ -2724,18 +2726,20 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
 	struct sock *sk = sock->sk, *other;
 	unsigned int writable;
 	__poll_t mask;
+	u8 shutdown;
 
 	sock_poll_wait(file, sock, wait);
 	mask = 0;
+	shutdown = READ_ONCE(sk->sk_shutdown);
 
 	/* exceptional events? */
 	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPRI : 0);
 
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
-	if (sk->sk_shutdown == SHUTDOWN_MASK)
+	if (shutdown == SHUTDOWN_MASK)
 		mask |= EPOLLHUP;
 
 	/* readable? */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d55a47858d6d..0dfa2dfcb4bc 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1240,7 +1240,7 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
 			vsock_transport_cancel_pkt(vsk);
 			vsock_remove_connected(vsk);
 			goto out_wait;
-		} else if (timeout == 0) {
+		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
 			err = -ETIMEDOUT;
 			sk->sk_state = TCP_CLOSE;
 			sock->state = SS_UNCONNECTED;
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index d3e61dcc6129..ae1ae7c86d0c 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -132,6 +132,7 @@ uwrite(int const fd, void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
+	void *p = NULL;
 
 	file_updated = 1;
 
@@ -139,7 +140,10 @@ uwrite(int const fd, void const *const buf, size_t const count)
 		off_t aoffset = (file_ptr + count) - file_end;
 
 		if (aoffset > file_append_size) {
-			file_append = realloc(file_append, aoffset);
+			p = realloc(file_append, aoffset);
+			if (!p)
+				free(file_append);
+			file_append = p;
 			file_append_size = aoffset;
 		}
 		if (!file_append) {
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ff263ad19230..f4b07dc6f1cc 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1159,8 +1159,8 @@ static bool path_has_mixer(struct hda_codec *codec, int path_idx, int ctl_type)
 	return path && path->ctls[ctl_type];
 }
 
-static const char * const channel_name[4] = {
-	"Front", "Surround", "CLFE", "Side"
+static const char * const channel_name[] = {
+	"Front", "Surround", "CLFE", "Side", "Back",
 };
 
 /* give some appropriate ctl name prefix for the given line out channel */
@@ -1186,7 +1186,7 @@ static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
 
 	/* multi-io channels */
 	if (ch >= cfg->line_outs)
-		return channel_name[ch];
+		goto fixed_name;
 
 	switch (cfg->line_out_type) {
 	case AUTO_PIN_SPEAKER_OUT:
@@ -1238,6 +1238,7 @@ static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
 	if (cfg->line_outs == 1 && !spec->multi_ios)
 		return "Line Out";
 
+ fixed_name:
 	if (ch >= ARRAY_SIZE(channel_name)) {
 		snd_BUG();
 		return "PCM";
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9f0e6bbc523c..ca3c9f161829 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1070,6 +1070,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
+	SND_PCI_QUIRK(0x3842, 0x104b, "EVGA X299 Dark", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1055, "EVGA Z390 DARK", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
 	{}
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index be9f1c4295cd..e3f0326d81c2 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3937,6 +3937,11 @@ HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009e, "GPU 9e HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009f, "GPU 9f HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a0, "GPU a0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a3, "GPU a3 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a4, "GPU a4 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a5, "GPU a5 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a6, "GPU a6 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a7, "GPU a7 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",	patch_via_hdmi),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 546872e72427..e5d85887759b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -956,7 +956,7 @@ struct alc_codec_rename_pci_table {
 	const char *name;
 };
 
-static struct alc_codec_rename_table rename_tbl[] = {
+static const struct alc_codec_rename_table rename_tbl[] = {
 	{ 0x10ec0221, 0xf00f, 0x1003, "ALC231" },
 	{ 0x10ec0269, 0xfff0, 0x3010, "ALC277" },
 	{ 0x10ec0269, 0xf0f0, 0x2010, "ALC259" },
@@ -977,7 +977,7 @@ static struct alc_codec_rename_table rename_tbl[] = {
 	{ } /* terminator */
 };
 
-static struct alc_codec_rename_pci_table rename_pci_tbl[] = {
+static const struct alc_codec_rename_pci_table rename_pci_tbl[] = {
 	{ 0x10ec0280, 0x1028, 0, "ALC3220" },
 	{ 0x10ec0282, 0x1028, 0, "ALC3221" },
 	{ 0x10ec0283, 0x1028, 0, "ALC3223" },
@@ -3116,7 +3116,7 @@ static void alc269_shutup(struct hda_codec *codec)
 	alc_shutup_pins(codec);
 }
 
-static struct coef_fw alc282_coefs[] = {
+static const struct coef_fw alc282_coefs[] = {
 	WRITE_COEF(0x03, 0x0002), /* Power Down Control */
 	UPDATE_COEF(0x05, 0xff3f, 0x0700), /* FIFO and filter clock */
 	WRITE_COEF(0x07, 0x0200), /* DMIC control */
@@ -3228,7 +3228,7 @@ static void alc282_shutup(struct hda_codec *codec)
 	alc_write_coef_idx(codec, 0x78, coef78);
 }
 
-static struct coef_fw alc283_coefs[] = {
+static const struct coef_fw alc283_coefs[] = {
 	WRITE_COEF(0x03, 0x0002), /* Power Down Control */
 	UPDATE_COEF(0x05, 0xff3f, 0x0700), /* FIFO and filter clock */
 	WRITE_COEF(0x07, 0x0200), /* DMIC control */
@@ -4235,7 +4235,7 @@ static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 	}
 }
 
-static struct coef_fw alc225_pre_hsmode[] = {
+static const struct coef_fw alc225_pre_hsmode[] = {
 	UPDATE_COEF(0x4a, 1<<8, 0),
 	UPDATE_COEFEX(0x57, 0x05, 1<<14, 0),
 	UPDATE_COEF(0x63, 3<<14, 3<<14),
@@ -4248,7 +4248,7 @@ static struct coef_fw alc225_pre_hsmode[] = {
 
 static void alc_headset_mode_unplugged(struct hda_codec *codec)
 {
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEF(0x1b, 0x0c0b), /* LDO and MISC control */
 		WRITE_COEF(0x45, 0xd089), /* UAJ function set to menual mode */
 		UPDATE_COEFEX(0x57, 0x05, 1<<14, 0), /* Direct Drive HP Amp control(Set to verb control)*/
@@ -4256,7 +4256,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		WRITE_COEFEX(0x57, 0x03, 0x8aa6), /* Direct Drive HP Amp control */
 		{}
 	};
-	static struct coef_fw coef0256[] = {
+	static const struct coef_fw coef0256[] = {
 		WRITE_COEF(0x1b, 0x0c4b), /* LDO and MISC control */
 		WRITE_COEF(0x45, 0xd089), /* UAJ function set to menual mode */
 		WRITE_COEF(0x06, 0x6104), /* Set MIC2 Vref gate with HP */
@@ -4264,7 +4264,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		UPDATE_COEFEX(0x57, 0x05, 1<<14, 0), /* Direct Drive HP Amp control(Set to verb control)*/
 		{}
 	};
-	static struct coef_fw coef0233[] = {
+	static const struct coef_fw coef0233[] = {
 		WRITE_COEF(0x1b, 0x0c0b),
 		WRITE_COEF(0x45, 0xc429),
 		UPDATE_COEF(0x35, 0x4000, 0),
@@ -4274,7 +4274,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		WRITE_COEF(0x32, 0x42a3),
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x4f, 0xfcc0, 0xc400),
 		UPDATE_COEF(0x50, 0x2000, 0x2000),
 		UPDATE_COEF(0x56, 0x0006, 0x0006),
@@ -4282,18 +4282,18 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		UPDATE_COEF(0x67, 0x2000, 0),
 		{}
 	};
-	static struct coef_fw coef0298[] = {
+	static const struct coef_fw coef0298[] = {
 		UPDATE_COEF(0x19, 0x1300, 0x0300),
 		{}
 	};
-	static struct coef_fw coef0292[] = {
+	static const struct coef_fw coef0292[] = {
 		WRITE_COEF(0x76, 0x000e),
 		WRITE_COEF(0x6c, 0x2400),
 		WRITE_COEF(0x18, 0x7308),
 		WRITE_COEF(0x6b, 0xc429),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		UPDATE_COEF(0x10, 7<<8, 6<<8), /* SET Line1 JD to 0 */
 		UPDATE_COEFEX(0x57, 0x05, 1<<15|1<<13, 0x0), /* SET charge pump by verb */
 		UPDATE_COEFEX(0x57, 0x03, 1<<10, 1<<10), /* SET EN_OSW to 1 */
@@ -4302,16 +4302,16 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		UPDATE_COEF(0x4a, 0x000f, 0x000e), /* Combo Jack auto detect */
 		{}
 	};
-	static struct coef_fw coef0668[] = {
+	static const struct coef_fw coef0668[] = {
 		WRITE_COEF(0x15, 0x0d40),
 		WRITE_COEF(0xb7, 0x802b),
 		{}
 	};
-	static struct coef_fw coef0225[] = {
+	static const struct coef_fw coef0225[] = {
 		UPDATE_COEF(0x63, 3<<14, 0),
 		{}
 	};
-	static struct coef_fw coef0274[] = {
+	static const struct coef_fw coef0274[] = {
 		UPDATE_COEF(0x4a, 0x0100, 0),
 		UPDATE_COEFEX(0x57, 0x05, 0x4000, 0),
 		UPDATE_COEF(0x6b, 0xf000, 0x5000),
@@ -4376,25 +4376,25 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
 				    hda_nid_t mic_pin)
 {
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEFEX(0x57, 0x03, 0x8aa6),
 		WRITE_COEF(0x06, 0x6100), /* Set MIC2 Vref gate to normal */
 		{}
 	};
-	static struct coef_fw coef0256[] = {
+	static const struct coef_fw coef0256[] = {
 		UPDATE_COEFEX(0x57, 0x05, 1<<14, 1<<14), /* Direct Drive HP Amp control(Set to verb control)*/
 		WRITE_COEFEX(0x57, 0x03, 0x09a3),
 		WRITE_COEF(0x06, 0x6100), /* Set MIC2 Vref gate to normal */
 		{}
 	};
-	static struct coef_fw coef0233[] = {
+	static const struct coef_fw coef0233[] = {
 		UPDATE_COEF(0x35, 0, 1<<14),
 		WRITE_COEF(0x06, 0x2100),
 		WRITE_COEF(0x1a, 0x0021),
 		WRITE_COEF(0x26, 0x008c),
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x4f, 0x00c0, 0),
 		UPDATE_COEF(0x50, 0x2000, 0),
 		UPDATE_COEF(0x56, 0x0006, 0),
@@ -4403,30 +4403,30 @@ static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
 		UPDATE_COEF(0x67, 0x2000, 0x2000),
 		{}
 	};
-	static struct coef_fw coef0292[] = {
+	static const struct coef_fw coef0292[] = {
 		WRITE_COEF(0x19, 0xa208),
 		WRITE_COEF(0x2e, 0xacf0),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		UPDATE_COEFEX(0x57, 0x05, 0, 1<<15|1<<13), /* SET charge pump by verb */
 		UPDATE_COEFEX(0x57, 0x03, 1<<10, 0), /* SET EN_OSW to 0 */
 		UPDATE_COEF(0x1a, 1<<3, 0), /* Combo JD gating without LINE1-VREFO */
 		{}
 	};
-	static struct coef_fw coef0688[] = {
+	static const struct coef_fw coef0688[] = {
 		WRITE_COEF(0xb7, 0x802b),
 		WRITE_COEF(0xb5, 0x1040),
 		UPDATE_COEF(0xc3, 0, 1<<12),
 		{}
 	};
-	static struct coef_fw coef0225[] = {
+	static const struct coef_fw coef0225[] = {
 		UPDATE_COEFEX(0x57, 0x05, 1<<14, 1<<14),
 		UPDATE_COEF(0x4a, 3<<4, 2<<4),
 		UPDATE_COEF(0x63, 3<<14, 0),
 		{}
 	};
-	static struct coef_fw coef0274[] = {
+	static const struct coef_fw coef0274[] = {
 		UPDATE_COEFEX(0x57, 0x05, 0x4000, 0x4000),
 		UPDATE_COEF(0x4a, 0x0010, 0),
 		UPDATE_COEF(0x6b, 0xf000, 0),
@@ -4512,7 +4512,7 @@ static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
 
 static void alc_headset_mode_default(struct hda_codec *codec)
 {
-	static struct coef_fw coef0225[] = {
+	static const struct coef_fw coef0225[] = {
 		UPDATE_COEF(0x45, 0x3f<<10, 0x30<<10),
 		UPDATE_COEF(0x45, 0x3f<<10, 0x31<<10),
 		UPDATE_COEF(0x49, 3<<8, 0<<8),
@@ -4521,14 +4521,14 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 		UPDATE_COEF(0x67, 0xf000, 0x3000),
 		{}
 	};
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEF(0x45, 0xc089),
 		WRITE_COEF(0x45, 0xc489),
 		WRITE_COEFEX(0x57, 0x03, 0x8ea6),
 		WRITE_COEF(0x49, 0x0049),
 		{}
 	};
-	static struct coef_fw coef0256[] = {
+	static const struct coef_fw coef0256[] = {
 		WRITE_COEF(0x45, 0xc489),
 		WRITE_COEFEX(0x57, 0x03, 0x0da3),
 		WRITE_COEF(0x49, 0x0049),
@@ -4536,12 +4536,12 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 		WRITE_COEF(0x06, 0x6100),
 		{}
 	};
-	static struct coef_fw coef0233[] = {
+	static const struct coef_fw coef0233[] = {
 		WRITE_COEF(0x06, 0x2100),
 		WRITE_COEF(0x32, 0x4ea3),
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x4f, 0xfcc0, 0xc400), /* Set to TRS type */
 		UPDATE_COEF(0x50, 0x2000, 0x2000),
 		UPDATE_COEF(0x56, 0x0006, 0x0006),
@@ -4549,26 +4549,26 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 		UPDATE_COEF(0x67, 0x2000, 0),
 		{}
 	};
-	static struct coef_fw coef0292[] = {
+	static const struct coef_fw coef0292[] = {
 		WRITE_COEF(0x76, 0x000e),
 		WRITE_COEF(0x6c, 0x2400),
 		WRITE_COEF(0x6b, 0xc429),
 		WRITE_COEF(0x18, 0x7308),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		UPDATE_COEF(0x4a, 0x000f, 0x000e), /* Combo Jack auto detect */
 		WRITE_COEF(0x45, 0xC429), /* Set to TRS type */
 		UPDATE_COEF(0x1a, 1<<3, 0), /* Combo JD gating without LINE1-VREFO */
 		{}
 	};
-	static struct coef_fw coef0688[] = {
+	static const struct coef_fw coef0688[] = {
 		WRITE_COEF(0x11, 0x0041),
 		WRITE_COEF(0x15, 0x0d40),
 		WRITE_COEF(0xb7, 0x802b),
 		{}
 	};
-	static struct coef_fw coef0274[] = {
+	static const struct coef_fw coef0274[] = {
 		WRITE_COEF(0x45, 0x4289),
 		UPDATE_COEF(0x4a, 0x0010, 0x0010),
 		UPDATE_COEF(0x6b, 0x0f00, 0),
@@ -4631,53 +4631,53 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 {
 	int val;
 
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEF(0x45, 0xd489), /* Set to CTIA type */
 		WRITE_COEF(0x1b, 0x0c2b),
 		WRITE_COEFEX(0x57, 0x03, 0x8ea6),
 		{}
 	};
-	static struct coef_fw coef0256[] = {
+	static const struct coef_fw coef0256[] = {
 		WRITE_COEF(0x45, 0xd489), /* Set to CTIA type */
 		WRITE_COEF(0x1b, 0x0e6b),
 		{}
 	};
-	static struct coef_fw coef0233[] = {
+	static const struct coef_fw coef0233[] = {
 		WRITE_COEF(0x45, 0xd429),
 		WRITE_COEF(0x1b, 0x0c2b),
 		WRITE_COEF(0x32, 0x4ea3),
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x50, 0x2000, 0x2000),
 		UPDATE_COEF(0x56, 0x0006, 0x0006),
 		UPDATE_COEF(0x66, 0x0008, 0),
 		UPDATE_COEF(0x67, 0x2000, 0),
 		{}
 	};
-	static struct coef_fw coef0292[] = {
+	static const struct coef_fw coef0292[] = {
 		WRITE_COEF(0x6b, 0xd429),
 		WRITE_COEF(0x76, 0x0008),
 		WRITE_COEF(0x18, 0x7388),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		WRITE_COEF(0x45, 0xd429), /* Set to ctia type */
 		UPDATE_COEF(0x10, 7<<8, 7<<8), /* SET Line1 JD to 1 */
 		{}
 	};
-	static struct coef_fw coef0688[] = {
+	static const struct coef_fw coef0688[] = {
 		WRITE_COEF(0x11, 0x0001),
 		WRITE_COEF(0x15, 0x0d60),
 		WRITE_COEF(0xc3, 0x0000),
 		{}
 	};
-	static struct coef_fw coef0225_1[] = {
+	static const struct coef_fw coef0225_1[] = {
 		UPDATE_COEF(0x45, 0x3f<<10, 0x35<<10),
 		UPDATE_COEF(0x63, 3<<14, 2<<14),
 		{}
 	};
-	static struct coef_fw coef0225_2[] = {
+	static const struct coef_fw coef0225_2[] = {
 		UPDATE_COEF(0x45, 0x3f<<10, 0x35<<10),
 		UPDATE_COEF(0x63, 3<<14, 1<<14),
 		{}
@@ -4749,48 +4749,48 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 /* Nokia type */
 static void alc_headset_mode_omtp(struct hda_codec *codec)
 {
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEF(0x45, 0xe489), /* Set to OMTP Type */
 		WRITE_COEF(0x1b, 0x0c2b),
 		WRITE_COEFEX(0x57, 0x03, 0x8ea6),
 		{}
 	};
-	static struct coef_fw coef0256[] = {
+	static const struct coef_fw coef0256[] = {
 		WRITE_COEF(0x45, 0xe489), /* Set to OMTP Type */
 		WRITE_COEF(0x1b, 0x0e6b),
 		{}
 	};
-	static struct coef_fw coef0233[] = {
+	static const struct coef_fw coef0233[] = {
 		WRITE_COEF(0x45, 0xe429),
 		WRITE_COEF(0x1b, 0x0c2b),
 		WRITE_COEF(0x32, 0x4ea3),
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x50, 0x2000, 0x2000),
 		UPDATE_COEF(0x56, 0x0006, 0x0006),
 		UPDATE_COEF(0x66, 0x0008, 0),
 		UPDATE_COEF(0x67, 0x2000, 0),
 		{}
 	};
-	static struct coef_fw coef0292[] = {
+	static const struct coef_fw coef0292[] = {
 		WRITE_COEF(0x6b, 0xe429),
 		WRITE_COEF(0x76, 0x0008),
 		WRITE_COEF(0x18, 0x7388),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		WRITE_COEF(0x45, 0xe429), /* Set to omtp type */
 		UPDATE_COEF(0x10, 7<<8, 7<<8), /* SET Line1 JD to 1 */
 		{}
 	};
-	static struct coef_fw coef0688[] = {
+	static const struct coef_fw coef0688[] = {
 		WRITE_COEF(0x11, 0x0001),
 		WRITE_COEF(0x15, 0x0d50),
 		WRITE_COEF(0xc3, 0x0000),
 		{}
 	};
-	static struct coef_fw coef0225[] = {
+	static const struct coef_fw coef0225[] = {
 		UPDATE_COEF(0x45, 0x3f<<10, 0x39<<10),
 		UPDATE_COEF(0x63, 3<<14, 2<<14),
 		{}
@@ -4850,17 +4850,17 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 	int val;
 	bool is_ctia = false;
 	struct alc_spec *spec = codec->spec;
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEF(0x45, 0xd089), /* combo jack auto switch control(Check type)*/
 		WRITE_COEF(0x49, 0x0149), /* combo jack auto switch control(Vref
  conteol) */
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x4f, 0xfcc0, 0xd400), /* Check Type */
 		{}
 	};
-	static struct coef_fw coef0298[] = {
+	static const struct coef_fw coef0298[] = {
 		UPDATE_COEF(0x50, 0x2000, 0x2000),
 		UPDATE_COEF(0x56, 0x0006, 0x0006),
 		UPDATE_COEF(0x66, 0x0008, 0),
@@ -4868,19 +4868,19 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 		UPDATE_COEF(0x19, 0x1300, 0x1300),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		UPDATE_COEF(0x4a, 0x000f, 0x0008), /* Combo Jack auto detect */
 		WRITE_COEF(0x45, 0xD429), /* Set to ctia type */
 		{}
 	};
-	static struct coef_fw coef0688[] = {
+	static const struct coef_fw coef0688[] = {
 		WRITE_COEF(0x11, 0x0001),
 		WRITE_COEF(0xb7, 0x802b),
 		WRITE_COEF(0x15, 0x0d60),
 		WRITE_COEF(0xc3, 0x0c00),
 		{}
 	};
-	static struct coef_fw coef0274[] = {
+	static const struct coef_fw coef0274[] = {
 		UPDATE_COEF(0x4a, 0x0010, 0),
 		UPDATE_COEF(0x4a, 0x8000, 0),
 		WRITE_COEF(0x45, 0xd289),
@@ -5165,7 +5165,7 @@ static void alc_fixup_headset_mode_no_hp_mic(struct hda_codec *codec,
 static void alc255_set_default_jack_type(struct hda_codec *codec)
 {
 	/* Set to iphone type */
-	static struct coef_fw alc255fw[] = {
+	static const struct coef_fw alc255fw[] = {
 		WRITE_COEF(0x1b, 0x880b),
 		WRITE_COEF(0x45, 0xd089),
 		WRITE_COEF(0x1b, 0x080b),
@@ -5173,7 +5173,7 @@ static void alc255_set_default_jack_type(struct hda_codec *codec)
 		WRITE_COEF(0x1b, 0x0c0b),
 		{}
 	};
-	static struct coef_fw alc256fw[] = {
+	static const struct coef_fw alc256fw[] = {
 		WRITE_COEF(0x1b, 0x884b),
 		WRITE_COEF(0x45, 0xd089),
 		WRITE_COEF(0x1b, 0x084b),
@@ -8511,7 +8511,92 @@ static void alc662_fixup_usi_headset_mic(struct hda_codec *codec,
 	}
 }
 
-static struct coef_fw alc668_coefs[] = {
+static void alc662_aspire_ethos_mute_speakers(struct hda_codec *codec,
+					struct hda_jack_callback *cb)
+{
+	/* surround speakers at 0x1b already get muted automatically when
+	 * headphones are plugged in, but we have to mute/unmute the remaining
+	 * channels manually:
+	 * 0x15 - front left/front right
+	 * 0x18 - front center/ LFE
+	 */
+	if (snd_hda_jack_detect_state(codec, 0x1b) == HDA_JACK_PRESENT) {
+		snd_hda_set_pin_ctl_cache(codec, 0x15, 0);
+		snd_hda_set_pin_ctl_cache(codec, 0x18, 0);
+	} else {
+		snd_hda_set_pin_ctl_cache(codec, 0x15, PIN_OUT);
+		snd_hda_set_pin_ctl_cache(codec, 0x18, PIN_OUT);
+	}
+}
+
+static void alc662_fixup_aspire_ethos_hp(struct hda_codec *codec,
+					const struct hda_fixup *fix, int action)
+{
+    /* Pin 0x1b: shared headphones jack and surround speakers */
+	if (!is_jack_detectable(codec, 0x1b))
+		return;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_jack_detect_enable_callback(codec, 0x1b,
+				alc662_aspire_ethos_mute_speakers);
+		/* subwoofer needs an extra GPIO setting to become audible */
+		alc_setup_gpio(codec, 0x02);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		/* Make sure to start in a correct state, i.e. if
+		 * headphones have been plugged in before powering up the system
+		 */
+		alc662_aspire_ethos_mute_speakers(codec, NULL);
+		break;
+	}
+}
+
+static void alc671_fixup_hp_headset_mic2(struct hda_codec *codec,
+					     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x19, 0x02a11040 }, /* use as headset mic, with its own jack detect */
+		{ 0x1b, 0x0181304f },
+		{ }
+	};
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->gen.mixer_nid = 0;
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		alc_write_coef_idx(codec, 0x19, 0xa054);
+		break;
+	}
+}
+
+static void alc897_hp_automute_hook(struct hda_codec *codec,
+					 struct hda_jack_callback *jack)
+{
+	struct alc_spec *spec = codec->spec;
+	int vref;
+
+	snd_hda_gen_hp_automute(codec, jack);
+	vref = spec->gen.hp_jack_present ? (PIN_HP | AC_PINCTL_VREF_100) : PIN_HP;
+	snd_hda_codec_write(codec, 0x1b, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			    vref);
+}
+
+static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->gen.hp_automute_hook = alc897_hp_automute_hook;
+	}
+}
+
+static const struct coef_fw alc668_coefs[] = {
 	WRITE_COEF(0x01, 0xbebe), WRITE_COEF(0x02, 0xaaaa), WRITE_COEF(0x03,    0x0),
 	WRITE_COEF(0x04, 0x0180), WRITE_COEF(0x06,    0x0), WRITE_COEF(0x07, 0x0f80),
 	WRITE_COEF(0x08, 0x0031), WRITE_COEF(0x0a, 0x0060), WRITE_COEF(0x0b,    0x0),
@@ -8582,6 +8667,17 @@ enum {
 	ALC662_FIXUP_USI_FUNC,
 	ALC662_FIXUP_USI_HEADSET_MODE,
 	ALC662_FIXUP_LENOVO_MULTI_CODECS,
+	ALC669_FIXUP_ACER_ASPIRE_ETHOS,
+	ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET,
+	ALC671_FIXUP_HP_HEADSET_MIC2,
+	ALC662_FIXUP_ACER_X2660G_HEADSET_MODE,
+	ALC662_FIXUP_ACER_NITRO_HEADSET_MODE,
+	ALC668_FIXUP_ASUS_NO_HEADSET_MIC,
+	ALC668_FIXUP_HEADSET_MIC,
+	ALC668_FIXUP_MIC_DET_COEF,
+	ALC897_FIXUP_LENOVO_HEADSET_MIC,
+	ALC897_FIXUP_HEADSET_MIC_PIN,
+	ALC897_FIXUP_HP_HSMIC_VERB,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -8908,6 +9004,87 @@ static const struct hda_fixup alc662_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc233_alc662_fixup_lenovo_dual_codecs,
 	},
+	[ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc662_fixup_aspire_ethos_hp,
+	},
+	[ALC669_FIXUP_ACER_ASPIRE_ETHOS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x15, 0x92130110 }, /* front speakers */
+			{ 0x18, 0x99130111 }, /* center/subwoofer */
+			{ 0x1b, 0x11130012 }, /* surround plus jack for HP */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET
+	},
+	[ALC671_FIXUP_HP_HEADSET_MIC2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc671_fixup_hp_headset_mic2,
+	},
+	[ALC662_FIXUP_ACER_X2660G_HEADSET_MODE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x02a1113c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC662_FIXUP_USI_FUNC
+	},
+	[ALC662_FIXUP_ACER_NITRO_HEADSET_MODE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x01a11140 }, /* use as headset mic, without its own jack detect */
+			{ 0x1b, 0x0221144f },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC662_FIXUP_USI_FUNC
+	},
+	[ALC668_FIXUP_ASUS_NO_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x04a1112c },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC668_FIXUP_HEADSET_MIC
+	},
+	[ALC668_FIXUP_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_headset_mic,
+		.chained = true,
+		.chain_id = ALC668_FIXUP_MIC_DET_COEF
+	},
+	[ALC668_FIXUP_MIC_DET_COEF] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x15 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0d60 },
+			{}
+		},
+	},
+	[ALC897_FIXUP_LENOVO_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc897_fixup_lenovo_headset_mic,
+	},
+	[ALC897_FIXUP_HEADSET_MIC_PIN] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x03a11050 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC897_FIXUP_LENOVO_HEADSET_MIC
+	},
+	[ALC897_FIXUP_HP_HSMIC_VERB] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -8919,6 +9096,8 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0349, "eMachines eM250", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x034a, "Gateway LT27", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
+	SND_PCI_QUIRK(0x1025, 0x123c, "Acer Nitro N50-600", ALC662_FIXUP_ACER_NITRO_HEADSET_MODE),
+	SND_PCI_QUIRK(0x1025, 0x124e, "Acer 2660G", ALC662_FIXUP_ACER_X2660G_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1028, 0x05d8, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05db, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05fe, "Dell XPS 15", ALC668_FIXUP_DELL_XPS13),
@@ -8930,6 +9109,9 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0698, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x069f, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
+	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_ASUS_Nx50),
 	SND_PCI_QUIRK(0x1043, 0x13df, "Asus N550JX", ALC662_FIXUP_BASS_1A),
@@ -8939,6 +9121,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x15a7, "ASUS UX51VZH", ALC662_FIXUP_BASS_16),
 	SND_PCI_QUIRK(0x1043, 0x177d, "ASUS N551", ALC668_FIXUP_ASUS_Nx51),
 	SND_PCI_QUIRK(0x1043, 0x17bd, "ASUS N751", ALC668_FIXUP_ASUS_Nx51),
+	SND_PCI_QUIRK(0x1043, 0x185d, "ASUS G551JW", ALC668_FIXUP_ASUS_NO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1963, "ASUS X71SL", ALC662_FIXUP_ASUS_MODE8),
 	SND_PCI_QUIRK(0x1043, 0x1b73, "ASUS N55SF", ALC662_FIXUP_BASS_16),
 	SND_PCI_QUIRK(0x1043, 0x1bf3, "ASUS N76VZ", ALC662_FIXUP_BASS_MODE4_CHMAP),
@@ -8947,12 +9130,17 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc051, "Samsung R720", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x14cd, 0x5003, "USI", ALC662_FIXUP_USI_HEADSET_MODE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC662_FIXUP_LENOVO_MULTI_CODECS),
+	SND_PCI_QUIRK(0x17aa, 0x32ca, "Lenovo ThinkCentre M80", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x1849, 0x5892, "ASRock B150M", ALC892_FIXUP_ASROCK_MOBO),
 	SND_PCI_QUIRK(0x19da, 0xa130, "Zotac Z68", ALC662_FIXUP_ZOTAC_Z68),
 	SND_PCI_QUIRK(0x1b0a, 0x01b8, "ACER Veriton", ALC662_FIXUP_ACER_VERITON),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
+	SND_PCI_QUIRK(0x1025, 0x0566, "Acer Aspire Ethos 8951G", ALC669_FIXUP_ACER_ASPIRE_ETHOS),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
@@ -9045,6 +9233,7 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
 	{.id = ALC892_FIXUP_ASROCK_MOBO, .name = "asrock-mobo"},
 	{.id = ALC662_FIXUP_USI_HEADSET_MODE, .name = "usi-headset"},
 	{.id = ALC662_FIXUP_LENOVO_MULTI_CODECS, .name = "dual-codecs"},
+	{.id = ALC669_FIXUP_ACER_ASPIRE_ETHOS, .name = "aspire-ethos"},
 	{}
 };
 
@@ -9087,6 +9276,23 @@ static const struct snd_hda_pin_quirk alc662_pin_fixup_tbl[] = {
 		{0x12, 0x90a60130},
 		{0x14, 0x90170110},
 		{0x15, 0x0321101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0671, 0x103c, "HP cPC", ALC671_FIXUP_HP_HEADSET_MIC2,
+		{0x14, 0x01014010},
+		{0x17, 0x90170150},
+		{0x19, 0x02a11060},
+		{0x1b, 0x01813030},
+		{0x21, 0x02211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0671, 0x103c, "HP cPC", ALC671_FIXUP_HP_HEADSET_MIC2,
+		{0x14, 0x01014010},
+		{0x18, 0x01a19040},
+		{0x1b, 0x01813030},
+		{0x21, 0x02211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0671, 0x103c, "HP cPC", ALC671_FIXUP_HP_HEADSET_MIC2,
+		{0x14, 0x01014020},
+		{0x17, 0x90170110},
+		{0x18, 0x01a19050},
+		{0x1b, 0x01813040},
+		{0x21, 0x02211030}),
 	{}
 };
 
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index d7c2a6d13dea..2221e43c63ce 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -67,8 +67,8 @@ static int max_freq_mode;
  */
 static unsigned long max_frequency;
 
-static unsigned long long tsc_at_measure_start;
-static unsigned long long tsc_at_measure_end;
+static unsigned long long *tsc_at_measure_start;
+static unsigned long long *tsc_at_measure_end;
 static unsigned long long *mperf_previous_count;
 static unsigned long long *aperf_previous_count;
 static unsigned long long *mperf_current_count;
@@ -131,7 +131,7 @@ static int mperf_get_count_percent(unsigned int id, double *percent,
 	aperf_diff = aperf_current_count[cpu] - aperf_previous_count[cpu];
 
 	if (max_freq_mode == MAX_FREQ_TSC_REF) {
-		tsc_diff = tsc_at_measure_end - tsc_at_measure_start;
+		tsc_diff = tsc_at_measure_end[cpu] - tsc_at_measure_start[cpu];
 		*percent = 100.0 * mperf_diff / tsc_diff;
 		dprint("%s: TSC Ref - mperf_diff: %llu, tsc_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, tsc_diff);
@@ -168,7 +168,7 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 
 	if (max_freq_mode == MAX_FREQ_TSC_REF) {
 		/* Calculate max_freq from TSC count */
-		tsc_diff = tsc_at_measure_end - tsc_at_measure_start;
+		tsc_diff = tsc_at_measure_end[cpu] - tsc_at_measure_start[cpu];
 		time_diff = timespec_diff_us(time_start, time_end);
 		max_frequency = tsc_diff / time_diff;
 	}
@@ -187,33 +187,27 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 static int mperf_start(void)
 {
 	int cpu;
-	unsigned long long dbg;
 
 	clock_gettime(CLOCK_REALTIME, &time_start);
-	mperf_get_tsc(&tsc_at_measure_start);
 
-	for (cpu = 0; cpu < cpu_count; cpu++)
+	for (cpu = 0; cpu < cpu_count; cpu++) {
+		mperf_get_tsc(&tsc_at_measure_start[cpu]);
 		mperf_init_stats(cpu);
+	}
 
-	mperf_get_tsc(&dbg);
-	dprint("TSC diff: %llu\n", dbg - tsc_at_measure_start);
 	return 0;
 }
 
 static int mperf_stop(void)
 {
-	unsigned long long dbg;
 	int cpu;
 
-	for (cpu = 0; cpu < cpu_count; cpu++)
+	for (cpu = 0; cpu < cpu_count; cpu++) {
 		mperf_measure_stats(cpu);
+		mperf_get_tsc(&tsc_at_measure_end[cpu]);
+	}
 
-	mperf_get_tsc(&tsc_at_measure_end);
 	clock_gettime(CLOCK_REALTIME, &time_end);
-
-	mperf_get_tsc(&dbg);
-	dprint("TSC diff: %llu\n", dbg - tsc_at_measure_end);
-
 	return 0;
 }
 
@@ -311,7 +305,8 @@ struct cpuidle_monitor *mperf_register(void)
 	aperf_previous_count = calloc(cpu_count, sizeof(unsigned long long));
 	mperf_current_count = calloc(cpu_count, sizeof(unsigned long long));
 	aperf_current_count = calloc(cpu_count, sizeof(unsigned long long));
-
+	tsc_at_measure_start = calloc(cpu_count, sizeof(unsigned long long));
+	tsc_at_measure_end = calloc(cpu_count, sizeof(unsigned long long));
 	mperf_monitor.name_len = strlen(mperf_monitor.name);
 	return &mperf_monitor;
 }
@@ -322,6 +317,8 @@ void mperf_unregister(void)
 	free(aperf_previous_count);
 	free(mperf_current_count);
 	free(aperf_current_count);
+	free(tsc_at_measure_start);
+	free(tsc_at_measure_end);
 	free(is_valid);
 }
 
diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index b018e835737d..cda63164d9d3 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -22,6 +22,7 @@
 #include <linux/falloc.h>
 #include <linux/fcntl.h>
 #include <linux/memfd.h>
+#include <linux/types.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
