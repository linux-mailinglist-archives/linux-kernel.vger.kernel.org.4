Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C1706770
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjEQMCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjEQMBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C05B95;
        Wed, 17 May 2023 05:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8234464623;
        Wed, 17 May 2023 12:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB888C4339E;
        Wed, 17 May 2023 12:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324850;
        bh=nDQa+I3qAPLAegNDGY+KiM4hssQ6Zh6Reu04L1qsHLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzsEB8dvalQ//yhflecl1fq7Ax51nIO67i/k4gOhvnPNtOWoniXplIQDrB0owqkAo
         dw2bWn+pwrAImN9oSME6P+6nh9xmvz3g0jvc5spFpk9QsAMilKAL8NH7ZTNDsCCvls
         MbYABmMcS3qxzhJm9W2hgxs9/1R9zGmiSLOWciVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.112
Date:   Wed, 17 May 2023 14:00:40 +0200
Message-Id: <2023051739-nutty-buffing-a421@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023051739-leggings-reassure-a517@gregkh>
References: <2023051739-leggings-reassure-a517@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 4d0a49688376..774c2de28fa8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 111
+SUBLEVEL = 112
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index 47431307cb3c..fbfc04f9a04c 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -179,7 +179,7 @@ codec: audio-codec@1a {
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
 		clocks = <&pmu_system_controller 0>;
-		clock-names = "MCLK1";
+		clock-names = "mclk";
 		wlf,shared-lrclk;
 		#sound-dai-cells = <0>;
 	};
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index c5265f3ae31d..415d0f555858 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -582,7 +582,7 @@ csis0: csis@fa600000 {
 				interrupts = <29>;
 				clocks = <&clocks CLK_CSIS>,
 						<&clocks SCLK_CSIS>;
-				clock-names = "clk_csis",
+				clock-names = "csis",
 						"sclk_csis";
 				bus-width = <4>;
 				status = "disabled";
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f3a3a3ebebf5..d8f37034c092 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -714,6 +714,7 @@ static void __init setup_vm_final(void)
 {
 	uintptr_t va, map_size;
 	phys_addr_t pa, start, end;
+	unsigned long idx __maybe_unused;
 	u64 i;
 
 	/**
@@ -733,7 +734,7 @@ static void __init setup_vm_final(void)
 	 * directly in swapper_pg_dir in addition to the pgd entry that points
 	 * to fixmap_pte.
 	 */
-	unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
+	idx = pgd_index(__fix_to_virt(FIX_FDT));
 
 	set_pgd(&swapper_pg_dir[idx], early_pg_dir[idx]);
 #endif
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 86c56616e5de..ea3d61de065b 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -217,18 +217,26 @@ bool kernel_page_present(struct page *page)
 	pgd = pgd_offset_k(addr);
 	if (!pgd_present(*pgd))
 		return false;
+	if (pgd_leaf(*pgd))
+		return true;
 
 	p4d = p4d_offset(pgd, addr);
 	if (!p4d_present(*p4d))
 		return false;
+	if (p4d_leaf(*p4d))
+		return true;
 
 	pud = pud_offset(p4d, addr);
 	if (!pud_present(*pud))
 		return false;
+	if (pud_leaf(*pud))
+		return true;
 
 	pmd = pmd_offset(pud, addr);
 	if (!pmd_present(*pmd))
 		return false;
+	if (pmd_leaf(*pmd))
+		return true;
 
 	pte = pte_offset_kernel(pmd, addr);
 	return pte_present(*pte);
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 10290e5c1f43..c449e7c1b20f 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -15,7 +15,7 @@ config SH_STANDARD_BIOS
 
 config STACK_DEBUG
 	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && PRINTK
 	help
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit. Saying Y here will add overhead to
diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index 4adbd4ade319..b603b7968b38 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -64,7 +64,7 @@ ENTRY(_stext)
 	ldc	r0, r6_bank
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov	r4, r12		! Store device tree blob pointer in r12
 #endif
 	
@@ -315,7 +315,7 @@ ENTRY(_stext)
 10:		
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov.l	8f, r0		! Make flat device tree available early.
 	jsr	@r0
 	 mov	r12, r4
@@ -346,7 +346,7 @@ ENTRY(stack_start)
 5:	.long	start_kernel
 6:	.long	cpu_init
 7:	.long	init_thread_union
-#if defined(CONFIG_OF_FLATTREE)
+#if defined(CONFIG_OF_EARLY_FLATTREE)
 8:	.long	sh_fdt_init
 #endif
 
diff --git a/arch/sh/kernel/nmi_debug.c b/arch/sh/kernel/nmi_debug.c
index 11777867c6f5..a212b645b4cf 100644
--- a/arch/sh/kernel/nmi_debug.c
+++ b/arch/sh/kernel/nmi_debug.c
@@ -49,7 +49,7 @@ static int __init nmi_debug_setup(char *str)
 	register_die_notifier(&nmi_debug_nb);
 
 	if (*str != '=')
-		return 0;
+		return 1;
 
 	for (p = str + 1; *p; p = sep + 1) {
 		sep = strchr(p, ',');
@@ -70,6 +70,6 @@ static int __init nmi_debug_setup(char *str)
 			break;
 	}
 
-	return 0;
+	return 1;
 }
 __setup("nmi_debug", nmi_debug_setup);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 1fcb6659822a..af977ec4ca5e 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -244,7 +244,7 @@ void __init __weak plat_early_device_setup(void)
 {
 }
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
@@ -326,7 +326,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
 #else
diff --git a/arch/sh/math-emu/sfp-util.h b/arch/sh/math-emu/sfp-util.h
index 784f541344f3..bda50762b3d3 100644
--- a/arch/sh/math-emu/sfp-util.h
+++ b/arch/sh/math-emu/sfp-util.h
@@ -67,7 +67,3 @@
   } while (0)
 
 #define abort()	return 0
-
-#define __BYTE_ORDER __LITTLE_ENDIAN
-
-
diff --git a/crypto/algapi.c b/crypto/algapi.c
index c1af76ec65f5..3920c4b1e9c1 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -920,6 +920,9 @@ EXPORT_SYMBOL_GPL(crypto_enqueue_request);
 void crypto_enqueue_request_head(struct crypto_queue *queue,
 				 struct crypto_async_request *request)
 {
+	if (unlikely(queue->qlen >= queue->max_qlen))
+		queue->backlog = queue->backlog->prev;
+
 	queue->qlen++;
 	list_add(&request->list, &queue->list);
 }
diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index cff21f4e03e3..34effd4826c0 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -53,7 +53,8 @@ static void crypto_finalize_request(struct crypto_engine *engine,
 				dev_err(engine->dev, "failed to unprepare request\n");
 		}
 	}
-	req->complete(req, err);
+	lockdep_assert_in_softirq();
+	crypto_request_complete(req, err);
 
 	kthread_queue_work(engine->kworker, &engine->pump_requests);
 }
@@ -128,9 +129,6 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	if (!engine->retry_support)
 		engine->cur_req = async_req;
 
-	if (backlog)
-		backlog->complete(backlog, -EINPROGRESS);
-
 	if (engine->busy)
 		was_busy = true;
 	else
@@ -213,9 +211,12 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	}
 
 req_err_2:
-	async_req->complete(async_req, ret);
+	crypto_request_complete(async_req, ret);
 
 retry:
+	if (backlog)
+		crypto_request_complete(backlog, -EINPROGRESS);
+
 	/* If retry mechanism is supported, send new requests to engine */
 	if (engine->retry_support) {
 		spin_lock_irqsave(&engine->queue_lock, flags);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1f740e42e457..0104e101b0d7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1301,7 +1301,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 52c2f35a26a9..16da51130d1a 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -39,4 +39,4 @@ obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
 
 # MHI
-obj-$(CONFIG_MHI_BUS)		+= mhi/
+obj-y				+= mhi/
diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
index da5cd0c9fc62..4748df7f9cd5 100644
--- a/drivers/bus/mhi/Kconfig
+++ b/drivers/bus/mhi/Kconfig
@@ -2,30 +2,7 @@
 #
 # MHI bus
 #
-# Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+# Copyright (c) 2021, Linaro Ltd.
 #
 
-config MHI_BUS
-	tristate "Modem Host Interface (MHI) bus"
-	help
-	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
-	  communication protocol used by the host processors to control
-	  and communicate with modem devices over a high speed peripheral
-	  bus or shared memory.
-
-config MHI_BUS_DEBUG
-	bool "Debugfs support for the MHI bus"
-	depends on MHI_BUS && DEBUG_FS
-	help
-	  Enable debugfs support for use with the MHI transport. Allows
-	  reading and/or modifying some values within the MHI controller
-	  for debug and test purposes.
-
-config MHI_BUS_PCI_GENERIC
-	tristate "MHI PCI controller driver"
-	depends on MHI_BUS
-	depends on PCI
-	help
-	  This driver provides MHI PCI controller driver for devices such as
-	  Qualcomm SDX55 based PCIe modems.
-
+source "drivers/bus/mhi/host/Kconfig"
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index 0a2d778d6fb4..5f5708a249f5 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -1,6 +1,2 @@
-# core layer
-obj-y += core/
-
-obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
-mhi_pci_generic-y += pci_generic.o
-
+# Host MHI stack
+obj-y += host/
diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/core/Makefile
deleted file mode 100644
index c3feb4130aa3..000000000000
--- a/drivers/bus/mhi/core/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-$(CONFIG_MHI_BUS) += mhi.o
-
-mhi-y := init.o main.o pm.o boot.o
-mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
deleted file mode 100644
index 0a972620a403..000000000000
--- a/drivers/bus/mhi/core/boot.c
+++ /dev/null
@@ -1,533 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
-#include <linux/firmware.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/mhi.h>
-#include <linux/module.h>
-#include <linux/random.h>
-#include <linux/slab.h>
-#include <linux/wait.h>
-#include "internal.h"
-
-/* Setup RDDM vector table for RDDM transfer and program RXVEC */
-void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
-		      struct image_info *img_info)
-{
-	struct mhi_buf *mhi_buf = img_info->mhi_buf;
-	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
-	void __iomem *base = mhi_cntrl->bhie;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 sequence_id;
-	unsigned int i;
-
-	for (i = 0; i < img_info->entries - 1; i++, mhi_buf++, bhi_vec++) {
-		bhi_vec->dma_addr = mhi_buf->dma_addr;
-		bhi_vec->size = mhi_buf->len;
-	}
-
-	dev_dbg(dev, "BHIe programming for RDDM\n");
-
-	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_HIGH_OFFS,
-		      upper_32_bits(mhi_buf->dma_addr));
-
-	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_LOW_OFFS,
-		      lower_32_bits(mhi_buf->dma_addr));
-
-	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
-	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_RXVECSTATUS_SEQNUM_BMSK);
-
-	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
-			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
-			    sequence_id);
-
-	dev_dbg(dev, "Address: %p and len: 0x%zx sequence: %u\n",
-		&mhi_buf->dma_addr, mhi_buf->len, sequence_id);
-}
-
-/* Collect RDDM buffer during kernel panic */
-static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
-{
-	int ret;
-	u32 rx_status;
-	enum mhi_ee_type ee;
-	const u32 delayus = 2000;
-	u32 retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
-	const u32 rddm_timeout_us = 200000;
-	int rddm_retry = rddm_timeout_us / delayus;
-	void __iomem *base = mhi_cntrl->bhie;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	dev_dbg(dev, "Entered with pm_state:%s dev_state:%s ee:%s\n",
-		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-		TO_MHI_EXEC_STR(mhi_cntrl->ee));
-
-	/*
-	 * This should only be executing during a kernel panic, we expect all
-	 * other cores to shutdown while we're collecting RDDM buffer. After
-	 * returning from this function, we expect the device to reset.
-	 *
-	 * Normaly, we read/write pm_state only after grabbing the
-	 * pm_lock, since we're in a panic, skipping it. Also there is no
-	 * gurantee that this state change would take effect since
-	 * we're setting it w/o grabbing pm_lock
-	 */
-	mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
-	/* update should take the effect immediately */
-	smp_wmb();
-
-	/*
-	 * Make sure device is not already in RDDM. In case the device asserts
-	 * and a kernel panic follows, device will already be in RDDM.
-	 * Do not trigger SYS ERR again and proceed with waiting for
-	 * image download completion.
-	 */
-	ee = mhi_get_exec_env(mhi_cntrl);
-	if (ee == MHI_EE_MAX)
-		goto error_exit_rddm;
-
-	if (ee != MHI_EE_RDDM) {
-		dev_dbg(dev, "Trigger device into RDDM mode using SYS ERR\n");
-		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
-
-		dev_dbg(dev, "Waiting for device to enter RDDM\n");
-		while (rddm_retry--) {
-			ee = mhi_get_exec_env(mhi_cntrl);
-			if (ee == MHI_EE_RDDM)
-				break;
-
-			udelay(delayus);
-		}
-
-		if (rddm_retry <= 0) {
-			/* Hardware reset so force device to enter RDDM */
-			dev_dbg(dev,
-				"Did not enter RDDM, do a host req reset\n");
-			mhi_write_reg(mhi_cntrl, mhi_cntrl->regs,
-				      MHI_SOC_RESET_REQ_OFFSET,
-				      MHI_SOC_RESET_REQ);
-			udelay(delayus);
-		}
-
-		ee = mhi_get_exec_env(mhi_cntrl);
-	}
-
-	dev_dbg(dev,
-		"Waiting for RDDM image download via BHIe, current EE:%s\n",
-		TO_MHI_EXEC_STR(ee));
-
-	while (retry--) {
-		ret = mhi_read_reg_field(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS,
-					 BHIE_RXVECSTATUS_STATUS_BMSK,
-					 BHIE_RXVECSTATUS_STATUS_SHFT,
-					 &rx_status);
-		if (ret)
-			return -EIO;
-
-		if (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL)
-			return 0;
-
-		udelay(delayus);
-	}
-
-	ee = mhi_get_exec_env(mhi_cntrl);
-	ret = mhi_read_reg(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS, &rx_status);
-
-	dev_err(dev, "RXVEC_STATUS: 0x%x\n", rx_status);
-
-error_exit_rddm:
-	dev_err(dev, "RDDM transfer failed. Current EE: %s\n",
-		TO_MHI_EXEC_STR(ee));
-
-	return -EIO;
-}
-
-/* Download RDDM image from device */
-int mhi_download_rddm_image(struct mhi_controller *mhi_cntrl, bool in_panic)
-{
-	void __iomem *base = mhi_cntrl->bhie;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 rx_status;
-
-	if (in_panic)
-		return __mhi_download_rddm_in_panic(mhi_cntrl);
-
-	dev_dbg(dev, "Waiting for RDDM image download via BHIe\n");
-
-	/* Wait for the image download to complete */
-	wait_event_timeout(mhi_cntrl->state_event,
-			   mhi_read_reg_field(mhi_cntrl, base,
-					      BHIE_RXVECSTATUS_OFFS,
-					      BHIE_RXVECSTATUS_STATUS_BMSK,
-					      BHIE_RXVECSTATUS_STATUS_SHFT,
-					      &rx_status) || rx_status,
-			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	return (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
-}
-EXPORT_SYMBOL_GPL(mhi_download_rddm_image);
-
-static int mhi_fw_load_bhie(struct mhi_controller *mhi_cntrl,
-			    const struct mhi_buf *mhi_buf)
-{
-	void __iomem *base = mhi_cntrl->bhie;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
-	u32 tx_status, sequence_id;
-	int ret;
-
-	read_lock_bh(pm_lock);
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		read_unlock_bh(pm_lock);
-		return -EIO;
-	}
-
-	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_TXVECSTATUS_SEQNUM_BMSK);
-	dev_dbg(dev, "Starting image download via BHIe. Sequence ID: %u\n",
-		sequence_id);
-	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
-		      upper_32_bits(mhi_buf->dma_addr));
-
-	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_LOW_OFFS,
-		      lower_32_bits(mhi_buf->dma_addr));
-
-	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
-
-	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
-			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
-			    sequence_id);
-	read_unlock_bh(pm_lock);
-
-	/* Wait for the image download to complete */
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
-				 mhi_read_reg_field(mhi_cntrl, base,
-						   BHIE_TXVECSTATUS_OFFS,
-						   BHIE_TXVECSTATUS_STATUS_BMSK,
-						   BHIE_TXVECSTATUS_STATUS_SHFT,
-						   &tx_status) || tx_status,
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
-	    tx_status != BHIE_TXVECSTATUS_STATUS_XFER_COMPL)
-		return -EIO;
-
-	return (!ret) ? -ETIMEDOUT : 0;
-}
-
-static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
-			   dma_addr_t dma_addr,
-			   size_t size)
-{
-	u32 tx_status, val, session_id;
-	int i, ret;
-	void __iomem *base = mhi_cntrl->bhi;
-	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	struct {
-		char *name;
-		u32 offset;
-	} error_reg[] = {
-		{ "ERROR_CODE", BHI_ERRCODE },
-		{ "ERROR_DBG1", BHI_ERRDBG1 },
-		{ "ERROR_DBG2", BHI_ERRDBG2 },
-		{ "ERROR_DBG3", BHI_ERRDBG3 },
-		{ NULL },
-	};
-
-	read_lock_bh(pm_lock);
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		read_unlock_bh(pm_lock);
-		goto invalid_pm_state;
-	}
-
-	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
-	dev_dbg(dev, "Starting image download via BHI. Session ID: %u\n",
-		session_id);
-	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
-	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
-		      upper_32_bits(dma_addr));
-	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
-		      lower_32_bits(dma_addr));
-	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
-	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
-	read_unlock_bh(pm_lock);
-
-	/* Wait for the image download to complete */
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
-			   mhi_read_reg_field(mhi_cntrl, base, BHI_STATUS,
-					      BHI_STATUS_MASK, BHI_STATUS_SHIFT,
-					      &tx_status) || tx_status,
-			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
-		goto invalid_pm_state;
-
-	if (tx_status == BHI_STATUS_ERROR) {
-		dev_err(dev, "Image transfer failed\n");
-		read_lock_bh(pm_lock);
-		if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-			for (i = 0; error_reg[i].name; i++) {
-				ret = mhi_read_reg(mhi_cntrl, base,
-						   error_reg[i].offset, &val);
-				if (ret)
-					break;
-				dev_err(dev, "Reg: %s value: 0x%x\n",
-					error_reg[i].name, val);
-			}
-		}
-		read_unlock_bh(pm_lock);
-		goto invalid_pm_state;
-	}
-
-	return (!ret) ? -ETIMEDOUT : 0;
-
-invalid_pm_state:
-
-	return -EIO;
-}
-
-void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
-			 struct image_info *image_info)
-{
-	int i;
-	struct mhi_buf *mhi_buf = image_info->mhi_buf;
-
-	for (i = 0; i < image_info->entries; i++, mhi_buf++)
-		dma_free_coherent(mhi_cntrl->cntrl_dev, mhi_buf->len,
-				  mhi_buf->buf, mhi_buf->dma_addr);
-
-	kfree(image_info->mhi_buf);
-	kfree(image_info);
-}
-
-int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
-			 struct image_info **image_info,
-			 size_t alloc_size)
-{
-	size_t seg_size = mhi_cntrl->seg_len;
-	int segments = DIV_ROUND_UP(alloc_size, seg_size) + 1;
-	int i;
-	struct image_info *img_info;
-	struct mhi_buf *mhi_buf;
-
-	img_info = kzalloc(sizeof(*img_info), GFP_KERNEL);
-	if (!img_info)
-		return -ENOMEM;
-
-	/* Allocate memory for entries */
-	img_info->mhi_buf = kcalloc(segments, sizeof(*img_info->mhi_buf),
-				    GFP_KERNEL);
-	if (!img_info->mhi_buf)
-		goto error_alloc_mhi_buf;
-
-	/* Allocate and populate vector table */
-	mhi_buf = img_info->mhi_buf;
-	for (i = 0; i < segments; i++, mhi_buf++) {
-		size_t vec_size = seg_size;
-
-		/* Vector table is the last entry */
-		if (i == segments - 1)
-			vec_size = sizeof(struct bhi_vec_entry) * i;
-
-		mhi_buf->len = vec_size;
-		mhi_buf->buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev,
-						  vec_size, &mhi_buf->dma_addr,
-						  GFP_KERNEL);
-		if (!mhi_buf->buf)
-			goto error_alloc_segment;
-	}
-
-	img_info->bhi_vec = img_info->mhi_buf[segments - 1].buf;
-	img_info->entries = segments;
-	*image_info = img_info;
-
-	return 0;
-
-error_alloc_segment:
-	for (--i, --mhi_buf; i >= 0; i--, mhi_buf--)
-		dma_free_coherent(mhi_cntrl->cntrl_dev, mhi_buf->len,
-				  mhi_buf->buf, mhi_buf->dma_addr);
-
-error_alloc_mhi_buf:
-	kfree(img_info);
-
-	return -ENOMEM;
-}
-
-static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
-			      const struct firmware *firmware,
-			      struct image_info *img_info)
-{
-	size_t remainder = firmware->size;
-	size_t to_cpy;
-	const u8 *buf = firmware->data;
-	struct mhi_buf *mhi_buf = img_info->mhi_buf;
-	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
-
-	while (remainder) {
-		to_cpy = min(remainder, mhi_buf->len);
-		memcpy(mhi_buf->buf, buf, to_cpy);
-		bhi_vec->dma_addr = mhi_buf->dma_addr;
-		bhi_vec->size = to_cpy;
-
-		buf += to_cpy;
-		remainder -= to_cpy;
-		bhi_vec++;
-		mhi_buf++;
-	}
-}
-
-void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
-{
-	const struct firmware *firmware = NULL;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	const char *fw_name;
-	void *buf;
-	dma_addr_t dma_addr;
-	size_t size;
-	int i, ret;
-
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev, "Device MHI is not in valid state\n");
-		return;
-	}
-
-	/* save hardware info from BHI */
-	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_SERIALNU,
-			   &mhi_cntrl->serial_number);
-	if (ret)
-		dev_err(dev, "Could not capture serial number via BHI\n");
-
-	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++) {
-		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_OEMPKHASH(i),
-				   &mhi_cntrl->oem_pk_hash[i]);
-		if (ret) {
-			dev_err(dev, "Could not capture OEM PK HASH via BHI\n");
-			break;
-		}
-	}
-
-	/* wait for ready on pass through or any other execution environment */
-	if (mhi_cntrl->ee != MHI_EE_EDL && mhi_cntrl->ee != MHI_EE_PBL)
-		goto fw_load_ready_state;
-
-	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
-		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
-
-	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
-						     !mhi_cntrl->seg_len))) {
-		dev_err(dev,
-			"No firmware image defined or !sbl_size || !seg_len\n");
-		goto error_fw_load;
-	}
-
-	ret = request_firmware(&firmware, fw_name, dev);
-	if (ret) {
-		dev_err(dev, "Error loading firmware: %d\n", ret);
-		goto error_fw_load;
-	}
-
-	size = (mhi_cntrl->fbc_download) ? mhi_cntrl->sbl_size : firmware->size;
-
-	/* SBL size provided is maximum size, not necessarily the image size */
-	if (size > firmware->size)
-		size = firmware->size;
-
-	buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev, size, &dma_addr,
-				 GFP_KERNEL);
-	if (!buf) {
-		release_firmware(firmware);
-		goto error_fw_load;
-	}
-
-	/* Download image using BHI */
-	memcpy(buf, firmware->data, size);
-	ret = mhi_fw_load_bhi(mhi_cntrl, dma_addr, size);
-	dma_free_coherent(mhi_cntrl->cntrl_dev, size, buf, dma_addr);
-
-	/* Error or in EDL mode, we're done */
-	if (ret) {
-		dev_err(dev, "MHI did not load image over BHI, ret: %d\n", ret);
-		release_firmware(firmware);
-		goto error_fw_load;
-	}
-
-	/* Wait for ready since EDL image was loaded */
-	if (fw_name == mhi_cntrl->edl_image) {
-		release_firmware(firmware);
-		goto fw_load_ready_state;
-	}
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	mhi_cntrl->dev_state = MHI_STATE_RESET;
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	/*
-	 * If we're doing fbc, populate vector tables while
-	 * device transitioning into MHI READY state
-	 */
-	if (mhi_cntrl->fbc_download) {
-		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
-					   firmware->size);
-		if (ret) {
-			release_firmware(firmware);
-			goto error_fw_load;
-		}
-
-		/* Load the firmware into BHIE vec table */
-		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
-	}
-
-	release_firmware(firmware);
-
-fw_load_ready_state:
-	/* Transitioning into MHI RESET->READY state */
-	ret = mhi_ready_state_transition(mhi_cntrl);
-	if (ret) {
-		dev_err(dev, "MHI did not enter READY state\n");
-		goto error_ready_state;
-	}
-
-	dev_info(dev, "Wait for device to enter SBL or Mission mode\n");
-	return;
-
-error_ready_state:
-	if (mhi_cntrl->fbc_download) {
-		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
-		mhi_cntrl->fbc_image = NULL;
-	}
-
-error_fw_load:
-	mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
-	wake_up_all(&mhi_cntrl->state_event);
-}
-
-int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
-{
-	struct image_info *image_info = mhi_cntrl->fbc_image;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int ret;
-
-	if (!image_info)
-		return -EIO;
-
-	ret = mhi_fw_load_bhie(mhi_cntrl,
-			       /* Vector table is the last entry */
-			       &image_info->mhi_buf[image_info->entries - 1]);
-	if (ret) {
-		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
-		mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
-		wake_up_all(&mhi_cntrl->state_event);
-	}
-
-	return ret;
-}
diff --git a/drivers/bus/mhi/core/debugfs.c b/drivers/bus/mhi/core/debugfs.c
deleted file mode 100644
index d818586c229d..000000000000
--- a/drivers/bus/mhi/core/debugfs.c
+++ /dev/null
@@ -1,413 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/debugfs.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/mhi.h>
-#include <linux/module.h>
-#include "internal.h"
-
-static int mhi_debugfs_states_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-
-	/* states */
-	seq_printf(m, "PM state: %s Device: %s MHI state: %s EE: %s wake: %s\n",
-		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		   mhi_is_active(mhi_cntrl) ? "Active" : "Inactive",
-		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-		   TO_MHI_EXEC_STR(mhi_cntrl->ee),
-		   mhi_cntrl->wake_set ? "true" : "false");
-
-	/* counters */
-	seq_printf(m, "M0: %u M2: %u M3: %u", mhi_cntrl->M0, mhi_cntrl->M2,
-		   mhi_cntrl->M3);
-
-	seq_printf(m, " device wake: %u pending packets: %u\n",
-		   atomic_read(&mhi_cntrl->dev_wake),
-		   atomic_read(&mhi_cntrl->pending_pkts));
-
-	return 0;
-}
-
-static int mhi_debugfs_events_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-	struct mhi_event *mhi_event;
-	struct mhi_event_ctxt *er_ctxt;
-	int i;
-
-	if (!mhi_is_active(mhi_cntrl)) {
-		seq_puts(m, "Device not ready\n");
-		return -ENODEV;
-	}
-
-	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings;
-						i++, er_ctxt++, mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		if (mhi_event->offload_ev) {
-			seq_printf(m, "Index: %d is an offload event ring\n",
-				   i);
-			continue;
-		}
-
-		seq_printf(m, "Index: %d intmod count: %lu time: %lu",
-			   i, (le32_to_cpu(er_ctxt->intmod) & EV_CTX_INTMODC_MASK) >>
-			   EV_CTX_INTMODC_SHIFT,
-			   (le32_to_cpu(er_ctxt->intmod) & EV_CTX_INTMODT_MASK) >>
-			   EV_CTX_INTMODT_SHIFT);
-
-		seq_printf(m, " base: 0x%0llx len: 0x%llx", le64_to_cpu(er_ctxt->rbase),
-			   le64_to_cpu(er_ctxt->rlen));
-
-		seq_printf(m, " rp: 0x%llx wp: 0x%llx", le64_to_cpu(er_ctxt->rp),
-			   le64_to_cpu(er_ctxt->wp));
-
-		seq_printf(m, " local rp: 0x%pK db: 0x%pad\n", ring->rp,
-			   &mhi_event->db_cfg.db_val);
-	}
-
-	return 0;
-}
-
-static int mhi_debugfs_channels_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-	struct mhi_chan *mhi_chan;
-	struct mhi_chan_ctxt *chan_ctxt;
-	int i;
-
-	if (!mhi_is_active(mhi_cntrl)) {
-		seq_puts(m, "Device not ready\n");
-		return -ENODEV;
-	}
-
-	mhi_chan = mhi_cntrl->mhi_chan;
-	chan_ctxt = mhi_cntrl->mhi_ctxt->chan_ctxt;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
-		struct mhi_ring *ring = &mhi_chan->tre_ring;
-
-		if (mhi_chan->offload_ch) {
-			seq_printf(m, "%s(%u) is an offload channel\n",
-				   mhi_chan->name, mhi_chan->chan);
-			continue;
-		}
-
-		if (!mhi_chan->mhi_dev)
-			continue;
-
-		seq_printf(m,
-			   "%s(%u) state: 0x%lx brstmode: 0x%lx pollcfg: 0x%lx",
-			   mhi_chan->name, mhi_chan->chan, (le32_to_cpu(chan_ctxt->chcfg) &
-			   CHAN_CTX_CHSTATE_MASK) >> CHAN_CTX_CHSTATE_SHIFT,
-			   (le32_to_cpu(chan_ctxt->chcfg) & CHAN_CTX_BRSTMODE_MASK) >>
-			   CHAN_CTX_BRSTMODE_SHIFT, (le32_to_cpu(chan_ctxt->chcfg) &
-			   CHAN_CTX_POLLCFG_MASK) >> CHAN_CTX_POLLCFG_SHIFT);
-
-		seq_printf(m, " type: 0x%x event ring: %u", le32_to_cpu(chan_ctxt->chtype),
-			   le32_to_cpu(chan_ctxt->erindex));
-
-		seq_printf(m, " base: 0x%llx len: 0x%llx rp: 0x%llx wp: 0x%llx",
-			   le64_to_cpu(chan_ctxt->rbase), le64_to_cpu(chan_ctxt->rlen),
-			   le64_to_cpu(chan_ctxt->rp), le64_to_cpu(chan_ctxt->wp));
-
-		seq_printf(m, " local rp: 0x%pK local wp: 0x%pK db: 0x%pad\n",
-			   ring->rp, ring->wp,
-			   &mhi_chan->db_cfg.db_val);
-	}
-
-	return 0;
-}
-
-static int mhi_device_info_show(struct device *dev, void *data)
-{
-	struct mhi_device *mhi_dev;
-
-	if (dev->bus != &mhi_bus_type)
-		return 0;
-
-	mhi_dev = to_mhi_device(dev);
-
-	seq_printf((struct seq_file *)data, "%s: type: %s dev_wake: %u",
-		   mhi_dev->name, mhi_dev->dev_type ? "Controller" : "Transfer",
-		   mhi_dev->dev_wake);
-
-	/* for transfer device types only */
-	if (mhi_dev->dev_type == MHI_DEVICE_XFER)
-		seq_printf((struct seq_file *)data, " channels: %u(UL)/%u(DL)",
-			   mhi_dev->ul_chan_id, mhi_dev->dl_chan_id);
-
-	seq_puts((struct seq_file *)data, "\n");
-
-	return 0;
-}
-
-static int mhi_debugfs_devices_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-
-	if (!mhi_is_active(mhi_cntrl)) {
-		seq_puts(m, "Device not ready\n");
-		return -ENODEV;
-	}
-
-	/* Show controller and client(s) info */
-	mhi_device_info_show(&mhi_cntrl->mhi_dev->dev, m);
-	device_for_each_child(&mhi_cntrl->mhi_dev->dev, m, mhi_device_info_show);
-
-	return 0;
-}
-
-static int mhi_debugfs_regdump_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-	enum mhi_state state;
-	enum mhi_ee_type ee;
-	int i, ret = -EIO;
-	u32 val;
-	void __iomem *mhi_base = mhi_cntrl->regs;
-	void __iomem *bhi_base = mhi_cntrl->bhi;
-	void __iomem *bhie_base = mhi_cntrl->bhie;
-	void __iomem *wake_db = mhi_cntrl->wake_db;
-	struct {
-		const char *name;
-		int offset;
-		void __iomem *base;
-	} regs[] = {
-		{ "MHI_REGLEN", MHIREGLEN, mhi_base},
-		{ "MHI_VER", MHIVER, mhi_base},
-		{ "MHI_CFG", MHICFG, mhi_base},
-		{ "MHI_CTRL", MHICTRL, mhi_base},
-		{ "MHI_STATUS", MHISTATUS, mhi_base},
-		{ "MHI_WAKE_DB", 0, wake_db},
-		{ "BHI_EXECENV", BHI_EXECENV, bhi_base},
-		{ "BHI_STATUS", BHI_STATUS, bhi_base},
-		{ "BHI_ERRCODE", BHI_ERRCODE, bhi_base},
-		{ "BHI_ERRDBG1", BHI_ERRDBG1, bhi_base},
-		{ "BHI_ERRDBG2", BHI_ERRDBG2, bhi_base},
-		{ "BHI_ERRDBG3", BHI_ERRDBG3, bhi_base},
-		{ "BHIE_TXVEC_DB", BHIE_TXVECDB_OFFS, bhie_base},
-		{ "BHIE_TXVEC_STATUS", BHIE_TXVECSTATUS_OFFS, bhie_base},
-		{ "BHIE_RXVEC_DB", BHIE_RXVECDB_OFFS, bhie_base},
-		{ "BHIE_RXVEC_STATUS", BHIE_RXVECSTATUS_OFFS, bhie_base},
-		{ NULL },
-	};
-
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
-		return ret;
-
-	seq_printf(m, "Host PM state: %s Device state: %s EE: %s\n",
-		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-		   TO_MHI_EXEC_STR(mhi_cntrl->ee));
-
-	state = mhi_get_mhi_state(mhi_cntrl);
-	ee = mhi_get_exec_env(mhi_cntrl);
-	seq_printf(m, "Device EE: %s state: %s\n", TO_MHI_EXEC_STR(ee),
-		   TO_MHI_STATE_STR(state));
-
-	for (i = 0; regs[i].name; i++) {
-		if (!regs[i].base)
-			continue;
-		ret = mhi_read_reg(mhi_cntrl, regs[i].base, regs[i].offset,
-				   &val);
-		if (ret)
-			continue;
-
-		seq_printf(m, "%s: 0x%x\n", regs[i].name, val);
-	}
-
-	return 0;
-}
-
-static int mhi_debugfs_device_wake_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
-
-	if (!mhi_is_active(mhi_cntrl)) {
-		seq_puts(m, "Device not ready\n");
-		return -ENODEV;
-	}
-
-	seq_printf(m,
-		   "Wake count: %d\n%s\n", mhi_dev->dev_wake,
-		   "Usage: echo get/put > device_wake to vote/unvote for M0");
-
-	return 0;
-}
-
-static ssize_t mhi_debugfs_device_wake_write(struct file *file,
-					     const char __user *ubuf,
-					     size_t count, loff_t *ppos)
-{
-	struct seq_file	*m = file->private_data;
-	struct mhi_controller *mhi_cntrl = m->private;
-	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
-	char buf[16];
-	int ret = -EINVAL;
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	if (!strncmp(buf, "get", 3)) {
-		ret = mhi_device_get_sync(mhi_dev);
-	} else if (!strncmp(buf, "put", 3)) {
-		mhi_device_put(mhi_dev);
-		ret = 0;
-	}
-
-	return ret ? ret : count;
-}
-
-static int mhi_debugfs_timeout_ms_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-
-	seq_printf(m, "%u ms\n", mhi_cntrl->timeout_ms);
-
-	return 0;
-}
-
-static ssize_t mhi_debugfs_timeout_ms_write(struct file *file,
-					    const char __user *ubuf,
-					    size_t count, loff_t *ppos)
-{
-	struct seq_file	*m = file->private_data;
-	struct mhi_controller *mhi_cntrl = m->private;
-	u32 timeout_ms;
-
-	if (kstrtou32_from_user(ubuf, count, 0, &timeout_ms))
-		return -EINVAL;
-
-	mhi_cntrl->timeout_ms = timeout_ms;
-
-	return count;
-}
-
-static int mhi_debugfs_states_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_states_show, inode->i_private);
-}
-
-static int mhi_debugfs_events_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_events_show, inode->i_private);
-}
-
-static int mhi_debugfs_channels_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_channels_show, inode->i_private);
-}
-
-static int mhi_debugfs_devices_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_devices_show, inode->i_private);
-}
-
-static int mhi_debugfs_regdump_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_regdump_show, inode->i_private);
-}
-
-static int mhi_debugfs_device_wake_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_device_wake_show, inode->i_private);
-}
-
-static int mhi_debugfs_timeout_ms_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_timeout_ms_show, inode->i_private);
-}
-
-static const struct file_operations debugfs_states_fops = {
-	.open = mhi_debugfs_states_open,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_events_fops = {
-	.open = mhi_debugfs_events_open,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_channels_fops = {
-	.open = mhi_debugfs_channels_open,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_devices_fops = {
-	.open = mhi_debugfs_devices_open,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_regdump_fops = {
-	.open = mhi_debugfs_regdump_open,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_device_wake_fops = {
-	.open = mhi_debugfs_device_wake_open,
-	.write = mhi_debugfs_device_wake_write,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_timeout_ms_fops = {
-	.open = mhi_debugfs_timeout_ms_open,
-	.write = mhi_debugfs_timeout_ms_write,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static struct dentry *mhi_debugfs_root;
-
-void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
-{
-	mhi_cntrl->debugfs_dentry =
-			debugfs_create_dir(dev_name(&mhi_cntrl->mhi_dev->dev),
-					   mhi_debugfs_root);
-
-	debugfs_create_file("states", 0444, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_states_fops);
-	debugfs_create_file("events", 0444, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_events_fops);
-	debugfs_create_file("channels", 0444, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_channels_fops);
-	debugfs_create_file("devices", 0444, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_devices_fops);
-	debugfs_create_file("regdump", 0444, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_regdump_fops);
-	debugfs_create_file("device_wake", 0644, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_device_wake_fops);
-	debugfs_create_file("timeout_ms", 0644, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_timeout_ms_fops);
-}
-
-void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl)
-{
-	debugfs_remove_recursive(mhi_cntrl->debugfs_dentry);
-	mhi_cntrl->debugfs_dentry = NULL;
-}
-
-void mhi_debugfs_init(void)
-{
-	mhi_debugfs_root = debugfs_create_dir(mhi_bus_type.name, NULL);
-}
-
-void mhi_debugfs_exit(void)
-{
-	debugfs_remove_recursive(mhi_debugfs_root);
-}
diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
deleted file mode 100644
index d8787aaa176b..000000000000
--- a/drivers/bus/mhi/core/init.c
+++ /dev/null
@@ -1,1431 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/debugfs.h>
-#include <linux/device.h>
-#include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
-#include <linux/idr.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/mhi.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/wait.h>
-#include "internal.h"
-
-static DEFINE_IDA(mhi_controller_ida);
-
-const char * const mhi_ee_str[MHI_EE_MAX] = {
-	[MHI_EE_PBL] = "PRIMARY BOOTLOADER",
-	[MHI_EE_SBL] = "SECONDARY BOOTLOADER",
-	[MHI_EE_AMSS] = "MISSION MODE",
-	[MHI_EE_RDDM] = "RAMDUMP DOWNLOAD MODE",
-	[MHI_EE_WFW] = "WLAN FIRMWARE",
-	[MHI_EE_PTHRU] = "PASS THROUGH",
-	[MHI_EE_EDL] = "EMERGENCY DOWNLOAD",
-	[MHI_EE_FP] = "FLASH PROGRAMMER",
-	[MHI_EE_DISABLE_TRANSITION] = "DISABLE",
-	[MHI_EE_NOT_SUPPORTED] = "NOT SUPPORTED",
-};
-
-const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
-	[DEV_ST_TRANSITION_PBL] = "PBL",
-	[DEV_ST_TRANSITION_READY] = "READY",
-	[DEV_ST_TRANSITION_SBL] = "SBL",
-	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION MODE",
-	[DEV_ST_TRANSITION_FP] = "FLASH PROGRAMMER",
-	[DEV_ST_TRANSITION_SYS_ERR] = "SYS ERROR",
-	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
-};
-
-const char * const mhi_state_str[MHI_STATE_MAX] = {
-	[MHI_STATE_RESET] = "RESET",
-	[MHI_STATE_READY] = "READY",
-	[MHI_STATE_M0] = "M0",
-	[MHI_STATE_M1] = "M1",
-	[MHI_STATE_M2] = "M2",
-	[MHI_STATE_M3] = "M3",
-	[MHI_STATE_M3_FAST] = "M3 FAST",
-	[MHI_STATE_BHI] = "BHI",
-	[MHI_STATE_SYS_ERR] = "SYS ERROR",
-};
-
-const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
-	[MHI_CH_STATE_TYPE_RESET] = "RESET",
-	[MHI_CH_STATE_TYPE_STOP] = "STOP",
-	[MHI_CH_STATE_TYPE_START] = "START",
-};
-
-static const char * const mhi_pm_state_str[] = {
-	[MHI_PM_STATE_DISABLE] = "DISABLE",
-	[MHI_PM_STATE_POR] = "POWER ON RESET",
-	[MHI_PM_STATE_M0] = "M0",
-	[MHI_PM_STATE_M2] = "M2",
-	[MHI_PM_STATE_M3_ENTER] = "M?->M3",
-	[MHI_PM_STATE_M3] = "M3",
-	[MHI_PM_STATE_M3_EXIT] = "M3->M0",
-	[MHI_PM_STATE_FW_DL_ERR] = "Firmware Download Error",
-	[MHI_PM_STATE_SYS_ERR_DETECT] = "SYS ERROR Detect",
-	[MHI_PM_STATE_SYS_ERR_PROCESS] = "SYS ERROR Process",
-	[MHI_PM_STATE_SHUTDOWN_PROCESS] = "SHUTDOWN Process",
-	[MHI_PM_STATE_LD_ERR_FATAL_DETECT] = "Linkdown or Error Fatal Detect",
-};
-
-const char *to_mhi_pm_state_str(u32 state)
-{
-	int index;
-
-	if (state)
-		index = __fls(state);
-
-	if (!state || index >= ARRAY_SIZE(mhi_pm_state_str))
-		return "Invalid State";
-
-	return mhi_pm_state_str[index];
-}
-
-static ssize_t serial_number_show(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-
-	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
-			mhi_cntrl->serial_number);
-}
-static DEVICE_ATTR_RO(serial_number);
-
-static ssize_t oem_pk_hash_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	int i, cnt = 0;
-
-	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++)
-		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
-				"OEMPKHASH[%d]: 0x%x\n", i,
-				mhi_cntrl->oem_pk_hash[i]);
-
-	return cnt;
-}
-static DEVICE_ATTR_RO(oem_pk_hash);
-
-static struct attribute *mhi_dev_attrs[] = {
-	&dev_attr_serial_number.attr,
-	&dev_attr_oem_pk_hash.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(mhi_dev);
-
-/* MHI protocol requires the transfer ring to be aligned with ring length */
-static int mhi_alloc_aligned_ring(struct mhi_controller *mhi_cntrl,
-				  struct mhi_ring *ring,
-				  u64 len)
-{
-	ring->alloc_size = len + (len - 1);
-	ring->pre_aligned = dma_alloc_coherent(mhi_cntrl->cntrl_dev, ring->alloc_size,
-					       &ring->dma_handle, GFP_KERNEL);
-	if (!ring->pre_aligned)
-		return -ENOMEM;
-
-	ring->iommu_base = (ring->dma_handle + (len - 1)) & ~(len - 1);
-	ring->base = ring->pre_aligned + (ring->iommu_base - ring->dma_handle);
-
-	return 0;
-}
-
-void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
-{
-	int i;
-	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-
-		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
-	}
-
-	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
-}
-
-int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
-	int i, ret;
-
-	/* if controller driver has set irq_flags, use it */
-	if (mhi_cntrl->irq_flags)
-		irq_flags = mhi_cntrl->irq_flags;
-
-	/* Setup BHI_INTVEC IRQ */
-	ret = request_threaded_irq(mhi_cntrl->irq[0], mhi_intvec_handler,
-				   mhi_intvec_threaded_handler,
-				   irq_flags,
-				   "bhi", mhi_cntrl);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-
-		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
-			dev_err(dev, "irq %d not available for event ring\n",
-				mhi_event->irq);
-			ret = -EINVAL;
-			goto error_request;
-		}
-
-		ret = request_irq(mhi_cntrl->irq[mhi_event->irq],
-				  mhi_irq_handler,
-				  irq_flags,
-				  "mhi", mhi_event);
-		if (ret) {
-			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
-				mhi_cntrl->irq[mhi_event->irq], i);
-			goto error_request;
-		}
-	}
-
-	return 0;
-
-error_request:
-	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
-		if (mhi_event->offload_ev)
-			continue;
-
-		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
-	}
-	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
-
-	return ret;
-}
-
-void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
-{
-	int i;
-	struct mhi_ctxt *mhi_ctxt = mhi_cntrl->mhi_ctxt;
-	struct mhi_cmd *mhi_cmd;
-	struct mhi_event *mhi_event;
-	struct mhi_ring *ring;
-
-	mhi_cmd = mhi_cntrl->mhi_cmd;
-	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++) {
-		ring = &mhi_cmd->ring;
-		dma_free_coherent(mhi_cntrl->cntrl_dev, ring->alloc_size,
-				  ring->pre_aligned, ring->dma_handle);
-		ring->base = NULL;
-		ring->iommu_base = 0;
-	}
-
-	dma_free_coherent(mhi_cntrl->cntrl_dev,
-			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
-			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
-
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-
-		ring = &mhi_event->ring;
-		dma_free_coherent(mhi_cntrl->cntrl_dev, ring->alloc_size,
-				  ring->pre_aligned, ring->dma_handle);
-		ring->base = NULL;
-		ring->iommu_base = 0;
-	}
-
-	dma_free_coherent(mhi_cntrl->cntrl_dev, sizeof(*mhi_ctxt->er_ctxt) *
-			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
-			  mhi_ctxt->er_ctxt_addr);
-
-	dma_free_coherent(mhi_cntrl->cntrl_dev, sizeof(*mhi_ctxt->chan_ctxt) *
-			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
-			  mhi_ctxt->chan_ctxt_addr);
-
-	kfree(mhi_ctxt);
-	mhi_cntrl->mhi_ctxt = NULL;
-}
-
-int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_ctxt *mhi_ctxt;
-	struct mhi_chan_ctxt *chan_ctxt;
-	struct mhi_event_ctxt *er_ctxt;
-	struct mhi_cmd_ctxt *cmd_ctxt;
-	struct mhi_chan *mhi_chan;
-	struct mhi_event *mhi_event;
-	struct mhi_cmd *mhi_cmd;
-	u32 tmp;
-	int ret = -ENOMEM, i;
-
-	atomic_set(&mhi_cntrl->dev_wake, 0);
-	atomic_set(&mhi_cntrl->pending_pkts, 0);
-
-	mhi_ctxt = kzalloc(sizeof(*mhi_ctxt), GFP_KERNEL);
-	if (!mhi_ctxt)
-		return -ENOMEM;
-
-	/* Setup channel ctxt */
-	mhi_ctxt->chan_ctxt = dma_alloc_coherent(mhi_cntrl->cntrl_dev,
-						 sizeof(*mhi_ctxt->chan_ctxt) *
-						 mhi_cntrl->max_chan,
-						 &mhi_ctxt->chan_ctxt_addr,
-						 GFP_KERNEL);
-	if (!mhi_ctxt->chan_ctxt)
-		goto error_alloc_chan_ctxt;
-
-	mhi_chan = mhi_cntrl->mhi_chan;
-	chan_ctxt = mhi_ctxt->chan_ctxt;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
-		/* Skip if it is an offload channel */
-		if (mhi_chan->offload_ch)
-			continue;
-
-		tmp = le32_to_cpu(chan_ctxt->chcfg);
-		tmp &= ~CHAN_CTX_CHSTATE_MASK;
-		tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
-		tmp &= ~CHAN_CTX_BRSTMODE_MASK;
-		tmp |= (mhi_chan->db_cfg.brstmode << CHAN_CTX_BRSTMODE_SHIFT);
-		tmp &= ~CHAN_CTX_POLLCFG_MASK;
-		tmp |= (mhi_chan->db_cfg.pollcfg << CHAN_CTX_POLLCFG_SHIFT);
-		chan_ctxt->chcfg = cpu_to_le32(tmp);
-
-		chan_ctxt->chtype = cpu_to_le32(mhi_chan->type);
-		chan_ctxt->erindex = cpu_to_le32(mhi_chan->er_index);
-
-		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
-		mhi_chan->tre_ring.db_addr = (void __iomem *)&chan_ctxt->wp;
-	}
-
-	/* Setup event context */
-	mhi_ctxt->er_ctxt = dma_alloc_coherent(mhi_cntrl->cntrl_dev,
-					       sizeof(*mhi_ctxt->er_ctxt) *
-					       mhi_cntrl->total_ev_rings,
-					       &mhi_ctxt->er_ctxt_addr,
-					       GFP_KERNEL);
-	if (!mhi_ctxt->er_ctxt)
-		goto error_alloc_er_ctxt;
-
-	er_ctxt = mhi_ctxt->er_ctxt;
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
-		     mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		/* Skip if it is an offload event */
-		if (mhi_event->offload_ev)
-			continue;
-
-		tmp = le32_to_cpu(er_ctxt->intmod);
-		tmp &= ~EV_CTX_INTMODC_MASK;
-		tmp &= ~EV_CTX_INTMODT_MASK;
-		tmp |= (mhi_event->intmod << EV_CTX_INTMODT_SHIFT);
-		er_ctxt->intmod = cpu_to_le32(tmp);
-
-		er_ctxt->ertype = cpu_to_le32(MHI_ER_TYPE_VALID);
-		er_ctxt->msivec = cpu_to_le32(mhi_event->irq);
-		mhi_event->db_cfg.db_mode = true;
-
-		ring->el_size = sizeof(struct mhi_tre);
-		ring->len = ring->el_size * ring->elements;
-		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
-		if (ret)
-			goto error_alloc_er;
-
-		/*
-		 * If the read pointer equals to the write pointer, then the
-		 * ring is empty
-		 */
-		ring->rp = ring->wp = ring->base;
-		er_ctxt->rbase = cpu_to_le64(ring->iommu_base);
-		er_ctxt->rp = er_ctxt->wp = er_ctxt->rbase;
-		er_ctxt->rlen = cpu_to_le64(ring->len);
-		ring->ctxt_wp = &er_ctxt->wp;
-	}
-
-	/* Setup cmd context */
-	ret = -ENOMEM;
-	mhi_ctxt->cmd_ctxt = dma_alloc_coherent(mhi_cntrl->cntrl_dev,
-						sizeof(*mhi_ctxt->cmd_ctxt) *
-						NR_OF_CMD_RINGS,
-						&mhi_ctxt->cmd_ctxt_addr,
-						GFP_KERNEL);
-	if (!mhi_ctxt->cmd_ctxt)
-		goto error_alloc_er;
-
-	mhi_cmd = mhi_cntrl->mhi_cmd;
-	cmd_ctxt = mhi_ctxt->cmd_ctxt;
-	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
-		struct mhi_ring *ring = &mhi_cmd->ring;
-
-		ring->el_size = sizeof(struct mhi_tre);
-		ring->elements = CMD_EL_PER_RING;
-		ring->len = ring->el_size * ring->elements;
-		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
-		if (ret)
-			goto error_alloc_cmd;
-
-		ring->rp = ring->wp = ring->base;
-		cmd_ctxt->rbase = cpu_to_le64(ring->iommu_base);
-		cmd_ctxt->rp = cmd_ctxt->wp = cmd_ctxt->rbase;
-		cmd_ctxt->rlen = cpu_to_le64(ring->len);
-		ring->ctxt_wp = &cmd_ctxt->wp;
-	}
-
-	mhi_cntrl->mhi_ctxt = mhi_ctxt;
-
-	return 0;
-
-error_alloc_cmd:
-	for (--i, --mhi_cmd; i >= 0; i--, mhi_cmd--) {
-		struct mhi_ring *ring = &mhi_cmd->ring;
-
-		dma_free_coherent(mhi_cntrl->cntrl_dev, ring->alloc_size,
-				  ring->pre_aligned, ring->dma_handle);
-	}
-	dma_free_coherent(mhi_cntrl->cntrl_dev,
-			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
-			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
-	i = mhi_cntrl->total_ev_rings;
-	mhi_event = mhi_cntrl->mhi_event + i;
-
-error_alloc_er:
-	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		if (mhi_event->offload_ev)
-			continue;
-
-		dma_free_coherent(mhi_cntrl->cntrl_dev, ring->alloc_size,
-				  ring->pre_aligned, ring->dma_handle);
-	}
-	dma_free_coherent(mhi_cntrl->cntrl_dev, sizeof(*mhi_ctxt->er_ctxt) *
-			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
-			  mhi_ctxt->er_ctxt_addr);
-
-error_alloc_er_ctxt:
-	dma_free_coherent(mhi_cntrl->cntrl_dev, sizeof(*mhi_ctxt->chan_ctxt) *
-			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
-			  mhi_ctxt->chan_ctxt_addr);
-
-error_alloc_chan_ctxt:
-	kfree(mhi_ctxt);
-
-	return ret;
-}
-
-int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
-{
-	u32 val;
-	int i, ret;
-	struct mhi_chan *mhi_chan;
-	struct mhi_event *mhi_event;
-	void __iomem *base = mhi_cntrl->regs;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	struct {
-		u32 offset;
-		u32 mask;
-		u32 shift;
-		u32 val;
-	} reg_info[] = {
-		{
-			CCABAP_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
-		},
-		{
-			CCABAP_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
-		},
-		{
-			ECABAP_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
-		},
-		{
-			ECABAP_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
-		},
-		{
-			CRCBAP_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
-		},
-		{
-			CRCBAP_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
-		},
-		{
-			MHICFG, MHICFG_NER_MASK, MHICFG_NER_SHIFT,
-			mhi_cntrl->total_ev_rings,
-		},
-		{
-			MHICFG, MHICFG_NHWER_MASK, MHICFG_NHWER_SHIFT,
-			mhi_cntrl->hw_ev_rings,
-		},
-		{
-			MHICTRLBASE_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->iova_start),
-		},
-		{
-			MHICTRLBASE_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->iova_start),
-		},
-		{
-			MHIDATABASE_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->iova_start),
-		},
-		{
-			MHIDATABASE_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->iova_start),
-		},
-		{
-			MHICTRLLIMIT_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->iova_stop),
-		},
-		{
-			MHICTRLLIMIT_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->iova_stop),
-		},
-		{
-			MHIDATALIMIT_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->iova_stop),
-		},
-		{
-			MHIDATALIMIT_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->iova_stop),
-		},
-		{ 0, 0, 0 }
-	};
-
-	dev_dbg(dev, "Initializing MHI registers\n");
-
-	/* Read channel db offset */
-	ret = mhi_read_reg_field(mhi_cntrl, base, CHDBOFF, CHDBOFF_CHDBOFF_MASK,
-				 CHDBOFF_CHDBOFF_SHIFT, &val);
-	if (ret) {
-		dev_err(dev, "Unable to read CHDBOFF register\n");
-		return -EIO;
-	}
-
-	/* Setup wake db */
-	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
-	mhi_cntrl->wake_set = false;
-
-	/* Setup channel db address for each channel in tre_ring */
-	mhi_chan = mhi_cntrl->mhi_chan;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, val += 8, mhi_chan++)
-		mhi_chan->tre_ring.db_addr = base + val;
-
-	/* Read event ring db offset */
-	ret = mhi_read_reg_field(mhi_cntrl, base, ERDBOFF, ERDBOFF_ERDBOFF_MASK,
-				 ERDBOFF_ERDBOFF_SHIFT, &val);
-	if (ret) {
-		dev_err(dev, "Unable to read ERDBOFF register\n");
-		return -EIO;
-	}
-
-	/* Setup event db address for each ev_ring */
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-
-		mhi_event->ring.db_addr = base + val;
-	}
-
-	/* Setup DB register for primary CMD rings */
-	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
-
-	/* Write to MMIO registers */
-	for (i = 0; reg_info[i].offset; i++)
-		mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
-				    reg_info[i].mask, reg_info[i].shift,
-				    reg_info[i].val);
-
-	return 0;
-}
-
-void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
-			  struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *buf_ring;
-	struct mhi_ring *tre_ring;
-	struct mhi_chan_ctxt *chan_ctxt;
-	u32 tmp;
-
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
-
-	if (!chan_ctxt->rbase) /* Already uninitialized */
-		return;
-
-	dma_free_coherent(mhi_cntrl->cntrl_dev, tre_ring->alloc_size,
-			  tre_ring->pre_aligned, tre_ring->dma_handle);
-	vfree(buf_ring->base);
-
-	buf_ring->base = tre_ring->base = NULL;
-	tre_ring->ctxt_wp = NULL;
-	chan_ctxt->rbase = 0;
-	chan_ctxt->rlen = 0;
-	chan_ctxt->rp = 0;
-	chan_ctxt->wp = 0;
-
-	tmp = le32_to_cpu(chan_ctxt->chcfg);
-	tmp &= ~CHAN_CTX_CHSTATE_MASK;
-	tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
-	chan_ctxt->chcfg = cpu_to_le32(tmp);
-
-	/* Update to all cores */
-	smp_wmb();
-}
-
-int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
-		       struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *buf_ring;
-	struct mhi_ring *tre_ring;
-	struct mhi_chan_ctxt *chan_ctxt;
-	u32 tmp;
-	int ret;
-
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-	tre_ring->el_size = sizeof(struct mhi_tre);
-	tre_ring->len = tre_ring->el_size * tre_ring->elements;
-	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
-	ret = mhi_alloc_aligned_ring(mhi_cntrl, tre_ring, tre_ring->len);
-	if (ret)
-		return -ENOMEM;
-
-	buf_ring->el_size = sizeof(struct mhi_buf_info);
-	buf_ring->len = buf_ring->el_size * buf_ring->elements;
-	buf_ring->base = vzalloc(buf_ring->len);
-
-	if (!buf_ring->base) {
-		dma_free_coherent(mhi_cntrl->cntrl_dev, tre_ring->alloc_size,
-				  tre_ring->pre_aligned, tre_ring->dma_handle);
-		return -ENOMEM;
-	}
-
-	tmp = le32_to_cpu(chan_ctxt->chcfg);
-	tmp &= ~CHAN_CTX_CHSTATE_MASK;
-	tmp |= (MHI_CH_STATE_ENABLED << CHAN_CTX_CHSTATE_SHIFT);
-	chan_ctxt->chcfg = cpu_to_le32(tmp);
-
-	chan_ctxt->rbase = cpu_to_le64(tre_ring->iommu_base);
-	chan_ctxt->rp = chan_ctxt->wp = chan_ctxt->rbase;
-	chan_ctxt->rlen = cpu_to_le64(tre_ring->len);
-	tre_ring->ctxt_wp = &chan_ctxt->wp;
-
-	tre_ring->rp = tre_ring->wp = tre_ring->base;
-	buf_ring->rp = buf_ring->wp = buf_ring->base;
-	mhi_chan->db_cfg.db_mode = 1;
-
-	/* Update to all cores */
-	smp_wmb();
-
-	return 0;
-}
-
-static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
-			const struct mhi_controller_config *config)
-{
-	struct mhi_event *mhi_event;
-	const struct mhi_event_config *event_cfg;
-	struct device *dev = mhi_cntrl->cntrl_dev;
-	int i, num;
-
-	num = config->num_events;
-	mhi_cntrl->total_ev_rings = num;
-	mhi_cntrl->mhi_event = kcalloc(num, sizeof(*mhi_cntrl->mhi_event),
-				       GFP_KERNEL);
-	if (!mhi_cntrl->mhi_event)
-		return -ENOMEM;
-
-	/* Populate event ring */
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < num; i++) {
-		event_cfg = &config->event_cfg[i];
-
-		mhi_event->er_index = i;
-		mhi_event->ring.elements = event_cfg->num_elements;
-		mhi_event->intmod = event_cfg->irq_moderation_ms;
-		mhi_event->irq = event_cfg->irq;
-
-		if (event_cfg->channel != U32_MAX) {
-			/* This event ring has a dedicated channel */
-			mhi_event->chan = event_cfg->channel;
-			if (mhi_event->chan >= mhi_cntrl->max_chan) {
-				dev_err(dev,
-					"Event Ring channel not available\n");
-				goto error_ev_cfg;
-			}
-
-			mhi_event->mhi_chan =
-				&mhi_cntrl->mhi_chan[mhi_event->chan];
-		}
-
-		/* Priority is fixed to 1 for now */
-		mhi_event->priority = 1;
-
-		mhi_event->db_cfg.brstmode = event_cfg->mode;
-		if (MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
-			goto error_ev_cfg;
-
-		if (mhi_event->db_cfg.brstmode == MHI_DB_BRST_ENABLE)
-			mhi_event->db_cfg.process_db = mhi_db_brstmode;
-		else
-			mhi_event->db_cfg.process_db = mhi_db_brstmode_disable;
-
-		mhi_event->data_type = event_cfg->data_type;
-
-		switch (mhi_event->data_type) {
-		case MHI_ER_DATA:
-			mhi_event->process_event = mhi_process_data_event_ring;
-			break;
-		case MHI_ER_CTRL:
-			mhi_event->process_event = mhi_process_ctrl_ev_ring;
-			break;
-		default:
-			dev_err(dev, "Event Ring type not supported\n");
-			goto error_ev_cfg;
-		}
-
-		mhi_event->hw_ring = event_cfg->hardware_event;
-		if (mhi_event->hw_ring)
-			mhi_cntrl->hw_ev_rings++;
-		else
-			mhi_cntrl->sw_ev_rings++;
-
-		mhi_event->cl_manage = event_cfg->client_managed;
-		mhi_event->offload_ev = event_cfg->offload_channel;
-		mhi_event++;
-	}
-
-	return 0;
-
-error_ev_cfg:
-
-	kfree(mhi_cntrl->mhi_event);
-	return -EINVAL;
-}
-
-static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
-			const struct mhi_controller_config *config)
-{
-	const struct mhi_channel_config *ch_cfg;
-	struct device *dev = mhi_cntrl->cntrl_dev;
-	int i;
-	u32 chan;
-
-	mhi_cntrl->max_chan = config->max_channels;
-
-	/*
-	 * The allocation of MHI channels can exceed 32KB in some scenarios,
-	 * so to avoid any memory possible allocation failures, vzalloc is
-	 * used here
-	 */
-	mhi_cntrl->mhi_chan = vzalloc(mhi_cntrl->max_chan *
-				      sizeof(*mhi_cntrl->mhi_chan));
-	if (!mhi_cntrl->mhi_chan)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&mhi_cntrl->lpm_chans);
-
-	/* Populate channel configurations */
-	for (i = 0; i < config->num_channels; i++) {
-		struct mhi_chan *mhi_chan;
-
-		ch_cfg = &config->ch_cfg[i];
-
-		chan = ch_cfg->num;
-		if (chan >= mhi_cntrl->max_chan) {
-			dev_err(dev, "Channel %d not available\n", chan);
-			goto error_chan_cfg;
-		}
-
-		mhi_chan = &mhi_cntrl->mhi_chan[chan];
-		mhi_chan->name = ch_cfg->name;
-		mhi_chan->chan = chan;
-
-		mhi_chan->tre_ring.elements = ch_cfg->num_elements;
-		if (!mhi_chan->tre_ring.elements)
-			goto error_chan_cfg;
-
-		/*
-		 * For some channels, local ring length should be bigger than
-		 * the transfer ring length due to internal logical channels
-		 * in device. So host can queue much more buffers than transfer
-		 * ring length. Example, RSC channels should have a larger local
-		 * channel length than transfer ring length.
-		 */
-		mhi_chan->buf_ring.elements = ch_cfg->local_elements;
-		if (!mhi_chan->buf_ring.elements)
-			mhi_chan->buf_ring.elements = mhi_chan->tre_ring.elements;
-		mhi_chan->er_index = ch_cfg->event_ring;
-		mhi_chan->dir = ch_cfg->dir;
-
-		/*
-		 * For most channels, chtype is identical to channel directions.
-		 * So, if it is not defined then assign channel direction to
-		 * chtype
-		 */
-		mhi_chan->type = ch_cfg->type;
-		if (!mhi_chan->type)
-			mhi_chan->type = (enum mhi_ch_type)mhi_chan->dir;
-
-		mhi_chan->ee_mask = ch_cfg->ee_mask;
-		mhi_chan->db_cfg.pollcfg = ch_cfg->pollcfg;
-		mhi_chan->lpm_notify = ch_cfg->lpm_notify;
-		mhi_chan->offload_ch = ch_cfg->offload_channel;
-		mhi_chan->db_cfg.reset_req = ch_cfg->doorbell_mode_switch;
-		mhi_chan->pre_alloc = ch_cfg->auto_queue;
-		mhi_chan->wake_capable = ch_cfg->wake_capable;
-
-		/*
-		 * If MHI host allocates buffers, then the channel direction
-		 * should be DMA_FROM_DEVICE
-		 */
-		if (mhi_chan->pre_alloc && mhi_chan->dir != DMA_FROM_DEVICE) {
-			dev_err(dev, "Invalid channel configuration\n");
-			goto error_chan_cfg;
-		}
-
-		/*
-		 * Bi-directional and direction less channel must be an
-		 * offload channel
-		 */
-		if ((mhi_chan->dir == DMA_BIDIRECTIONAL ||
-		     mhi_chan->dir == DMA_NONE) && !mhi_chan->offload_ch) {
-			dev_err(dev, "Invalid channel configuration\n");
-			goto error_chan_cfg;
-		}
-
-		if (!mhi_chan->offload_ch) {
-			mhi_chan->db_cfg.brstmode = ch_cfg->doorbell;
-			if (MHI_INVALID_BRSTMODE(mhi_chan->db_cfg.brstmode)) {
-				dev_err(dev, "Invalid Door bell mode\n");
-				goto error_chan_cfg;
-			}
-		}
-
-		if (mhi_chan->db_cfg.brstmode == MHI_DB_BRST_ENABLE)
-			mhi_chan->db_cfg.process_db = mhi_db_brstmode;
-		else
-			mhi_chan->db_cfg.process_db = mhi_db_brstmode_disable;
-
-		mhi_chan->configured = true;
-
-		if (mhi_chan->lpm_notify)
-			list_add_tail(&mhi_chan->node, &mhi_cntrl->lpm_chans);
-	}
-
-	return 0;
-
-error_chan_cfg:
-	vfree(mhi_cntrl->mhi_chan);
-
-	return -EINVAL;
-}
-
-static int parse_config(struct mhi_controller *mhi_cntrl,
-			const struct mhi_controller_config *config)
-{
-	int ret;
-
-	/* Parse MHI channel configuration */
-	ret = parse_ch_cfg(mhi_cntrl, config);
-	if (ret)
-		return ret;
-
-	/* Parse MHI event configuration */
-	ret = parse_ev_cfg(mhi_cntrl, config);
-	if (ret)
-		goto error_ev_cfg;
-
-	mhi_cntrl->timeout_ms = config->timeout_ms;
-	if (!mhi_cntrl->timeout_ms)
-		mhi_cntrl->timeout_ms = MHI_TIMEOUT_MS;
-
-	mhi_cntrl->bounce_buf = config->use_bounce_buf;
-	mhi_cntrl->buffer_len = config->buf_len;
-	if (!mhi_cntrl->buffer_len)
-		mhi_cntrl->buffer_len = MHI_MAX_MTU;
-
-	/* By default, host is allowed to ring DB in both M0 and M2 states */
-	mhi_cntrl->db_access = MHI_PM_M0 | MHI_PM_M2;
-	if (config->m2_no_db)
-		mhi_cntrl->db_access &= ~MHI_PM_M2;
-
-	return 0;
-
-error_ev_cfg:
-	vfree(mhi_cntrl->mhi_chan);
-
-	return ret;
-}
-
-int mhi_register_controller(struct mhi_controller *mhi_cntrl,
-			    const struct mhi_controller_config *config)
-{
-	struct mhi_event *mhi_event;
-	struct mhi_chan *mhi_chan;
-	struct mhi_cmd *mhi_cmd;
-	struct mhi_device *mhi_dev;
-	u32 soc_info;
-	int ret, i;
-
-	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
-	    !mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
-	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
-	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs ||
-	    !mhi_cntrl->irq || !mhi_cntrl->reg_len)
-		return -EINVAL;
-
-	ret = parse_config(mhi_cntrl, config);
-	if (ret)
-		return -EINVAL;
-
-	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS,
-				     sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
-	if (!mhi_cntrl->mhi_cmd) {
-		ret = -ENOMEM;
-		goto err_free_event;
-	}
-
-	INIT_LIST_HEAD(&mhi_cntrl->transition_list);
-	mutex_init(&mhi_cntrl->pm_mutex);
-	rwlock_init(&mhi_cntrl->pm_lock);
-	spin_lock_init(&mhi_cntrl->transition_lock);
-	spin_lock_init(&mhi_cntrl->wlock);
-	INIT_WORK(&mhi_cntrl->st_worker, mhi_pm_st_worker);
-	init_waitqueue_head(&mhi_cntrl->state_event);
-
-	mhi_cntrl->hiprio_wq = alloc_ordered_workqueue("mhi_hiprio_wq", WQ_HIGHPRI);
-	if (!mhi_cntrl->hiprio_wq) {
-		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate workqueue\n");
-		ret = -ENOMEM;
-		goto err_free_cmd;
-	}
-
-	mhi_cmd = mhi_cntrl->mhi_cmd;
-	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++)
-		spin_lock_init(&mhi_cmd->lock);
-
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		/* Skip for offload events */
-		if (mhi_event->offload_ev)
-			continue;
-
-		mhi_event->mhi_cntrl = mhi_cntrl;
-		spin_lock_init(&mhi_event->lock);
-		if (mhi_event->data_type == MHI_ER_CTRL)
-			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
-				     (ulong)mhi_event);
-		else
-			tasklet_init(&mhi_event->task, mhi_ev_task,
-				     (ulong)mhi_event);
-	}
-
-	mhi_chan = mhi_cntrl->mhi_chan;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
-		mutex_init(&mhi_chan->mutex);
-		init_completion(&mhi_chan->completion);
-		rwlock_init(&mhi_chan->lock);
-
-		/* used in setting bei field of TRE */
-		mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
-		mhi_chan->intmod = mhi_event->intmod;
-	}
-
-	if (mhi_cntrl->bounce_buf) {
-		mhi_cntrl->map_single = mhi_map_single_use_bb;
-		mhi_cntrl->unmap_single = mhi_unmap_single_use_bb;
-	} else {
-		mhi_cntrl->map_single = mhi_map_single_no_bb;
-		mhi_cntrl->unmap_single = mhi_unmap_single_no_bb;
-	}
-
-	/* Read the MHI device info */
-	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs,
-			   SOC_HW_VERSION_OFFS, &soc_info);
-	if (ret)
-		goto err_destroy_wq;
-
-	mhi_cntrl->family_number = (soc_info & SOC_HW_VERSION_FAM_NUM_BMSK) >>
-					SOC_HW_VERSION_FAM_NUM_SHFT;
-	mhi_cntrl->device_number = (soc_info & SOC_HW_VERSION_DEV_NUM_BMSK) >>
-					SOC_HW_VERSION_DEV_NUM_SHFT;
-	mhi_cntrl->major_version = (soc_info & SOC_HW_VERSION_MAJOR_VER_BMSK) >>
-					SOC_HW_VERSION_MAJOR_VER_SHFT;
-	mhi_cntrl->minor_version = (soc_info & SOC_HW_VERSION_MINOR_VER_BMSK) >>
-					SOC_HW_VERSION_MINOR_VER_SHFT;
-
-	mhi_cntrl->index = ida_alloc(&mhi_controller_ida, GFP_KERNEL);
-	if (mhi_cntrl->index < 0) {
-		ret = mhi_cntrl->index;
-		goto err_destroy_wq;
-	}
-
-	/* Register controller with MHI bus */
-	mhi_dev = mhi_alloc_device(mhi_cntrl);
-	if (IS_ERR(mhi_dev)) {
-		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate MHI device\n");
-		ret = PTR_ERR(mhi_dev);
-		goto err_ida_free;
-	}
-
-	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
-	mhi_dev->mhi_cntrl = mhi_cntrl;
-	dev_set_name(&mhi_dev->dev, "mhi%d", mhi_cntrl->index);
-	mhi_dev->name = dev_name(&mhi_dev->dev);
-
-	/* Init wakeup source */
-	device_init_wakeup(&mhi_dev->dev, true);
-
-	ret = device_add(&mhi_dev->dev);
-	if (ret)
-		goto err_release_dev;
-
-	mhi_cntrl->mhi_dev = mhi_dev;
-
-	mhi_create_debugfs(mhi_cntrl);
-
-	return 0;
-
-err_release_dev:
-	put_device(&mhi_dev->dev);
-err_ida_free:
-	ida_free(&mhi_controller_ida, mhi_cntrl->index);
-err_destroy_wq:
-	destroy_workqueue(mhi_cntrl->hiprio_wq);
-err_free_cmd:
-	kfree(mhi_cntrl->mhi_cmd);
-err_free_event:
-	kfree(mhi_cntrl->mhi_event);
-	vfree(mhi_cntrl->mhi_chan);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_register_controller);
-
-void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
-	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
-	unsigned int i;
-
-	mhi_destroy_debugfs(mhi_cntrl);
-
-	destroy_workqueue(mhi_cntrl->hiprio_wq);
-	kfree(mhi_cntrl->mhi_cmd);
-	kfree(mhi_cntrl->mhi_event);
-
-	/* Drop the references to MHI devices created for channels */
-	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
-		if (!mhi_chan->mhi_dev)
-			continue;
-
-		put_device(&mhi_chan->mhi_dev->dev);
-	}
-	vfree(mhi_cntrl->mhi_chan);
-
-	device_del(&mhi_dev->dev);
-	put_device(&mhi_dev->dev);
-
-	ida_free(&mhi_controller_ida, mhi_cntrl->index);
-}
-EXPORT_SYMBOL_GPL(mhi_unregister_controller);
-
-struct mhi_controller *mhi_alloc_controller(void)
-{
-	struct mhi_controller *mhi_cntrl;
-
-	mhi_cntrl = kzalloc(sizeof(*mhi_cntrl), GFP_KERNEL);
-
-	return mhi_cntrl;
-}
-EXPORT_SYMBOL_GPL(mhi_alloc_controller);
-
-void mhi_free_controller(struct mhi_controller *mhi_cntrl)
-{
-	kfree(mhi_cntrl);
-}
-EXPORT_SYMBOL_GPL(mhi_free_controller);
-
-int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
-{
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 bhi_off, bhie_off;
-	int ret;
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-
-	ret = mhi_init_dev_ctxt(mhi_cntrl);
-	if (ret)
-		goto error_dev_ctxt;
-
-	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &bhi_off);
-	if (ret) {
-		dev_err(dev, "Error getting BHI offset\n");
-		goto error_reg_offset;
-	}
-
-	if (bhi_off >= mhi_cntrl->reg_len) {
-		dev_err(dev, "BHI offset: 0x%x is out of range: 0x%zx\n",
-			bhi_off, mhi_cntrl->reg_len);
-		ret = -EINVAL;
-		goto error_reg_offset;
-	}
-	mhi_cntrl->bhi = mhi_cntrl->regs + bhi_off;
-
-	if (mhi_cntrl->fbc_download || mhi_cntrl->rddm_size) {
-		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIEOFF,
-				   &bhie_off);
-		if (ret) {
-			dev_err(dev, "Error getting BHIE offset\n");
-			goto error_reg_offset;
-		}
-
-		if (bhie_off >= mhi_cntrl->reg_len) {
-			dev_err(dev,
-				"BHIe offset: 0x%x is out of range: 0x%zx\n",
-				bhie_off, mhi_cntrl->reg_len);
-			ret = -EINVAL;
-			goto error_reg_offset;
-		}
-		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
-	}
-
-	if (mhi_cntrl->rddm_size) {
-		/*
-		 * This controller supports RDDM, so we need to manually clear
-		 * BHIE RX registers since POR values are undefined.
-		 */
-		memset_io(mhi_cntrl->bhie + BHIE_RXVECADDR_LOW_OFFS,
-			  0, BHIE_RXVECSTATUS_OFFS - BHIE_RXVECADDR_LOW_OFFS +
-			  4);
-		/*
-		 * Allocate RDDM table for debugging purpose if specified
-		 */
-		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
-				     mhi_cntrl->rddm_size);
-		if (mhi_cntrl->rddm_image)
-			mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
-	}
-
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-
-	return 0;
-
-error_reg_offset:
-	mhi_deinit_dev_ctxt(mhi_cntrl);
-
-error_dev_ctxt:
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_prepare_for_power_up);
-
-void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
-{
-	if (mhi_cntrl->fbc_image) {
-		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
-		mhi_cntrl->fbc_image = NULL;
-	}
-
-	if (mhi_cntrl->rddm_image) {
-		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->rddm_image);
-		mhi_cntrl->rddm_image = NULL;
-	}
-
-	mhi_cntrl->bhi = NULL;
-	mhi_cntrl->bhie = NULL;
-
-	mhi_deinit_dev_ctxt(mhi_cntrl);
-}
-EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
-
-static void mhi_release_device(struct device *dev)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-
-	/*
-	 * We need to set the mhi_chan->mhi_dev to NULL here since the MHI
-	 * devices for the channels will only get created if the mhi_dev
-	 * associated with it is NULL. This scenario will happen during the
-	 * controller suspend and resume.
-	 */
-	if (mhi_dev->ul_chan)
-		mhi_dev->ul_chan->mhi_dev = NULL;
-
-	if (mhi_dev->dl_chan)
-		mhi_dev->dl_chan->mhi_dev = NULL;
-
-	kfree(mhi_dev);
-}
-
-struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_device *mhi_dev;
-	struct device *dev;
-
-	mhi_dev = kzalloc(sizeof(*mhi_dev), GFP_KERNEL);
-	if (!mhi_dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev = &mhi_dev->dev;
-	device_initialize(dev);
-	dev->bus = &mhi_bus_type;
-	dev->release = mhi_release_device;
-
-	if (mhi_cntrl->mhi_dev) {
-		/* for MHI client devices, parent is the MHI controller device */
-		dev->parent = &mhi_cntrl->mhi_dev->dev;
-	} else {
-		/* for MHI controller device, parent is the bus device (e.g. pci device) */
-		dev->parent = mhi_cntrl->cntrl_dev;
-	}
-
-	mhi_dev->mhi_cntrl = mhi_cntrl;
-	mhi_dev->dev_wake = 0;
-
-	return mhi_dev;
-}
-
-static int mhi_driver_probe(struct device *dev)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct device_driver *drv = dev->driver;
-	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
-	struct mhi_event *mhi_event;
-	struct mhi_chan *ul_chan = mhi_dev->ul_chan;
-	struct mhi_chan *dl_chan = mhi_dev->dl_chan;
-	int ret;
-
-	/* Bring device out of LPM */
-	ret = mhi_device_get_sync(mhi_dev);
-	if (ret)
-		return ret;
-
-	ret = -EINVAL;
-
-	if (ul_chan) {
-		/*
-		 * If channel supports LPM notifications then status_cb should
-		 * be provided
-		 */
-		if (ul_chan->lpm_notify && !mhi_drv->status_cb)
-			goto exit_probe;
-
-		/* For non-offload channels then xfer_cb should be provided */
-		if (!ul_chan->offload_ch && !mhi_drv->ul_xfer_cb)
-			goto exit_probe;
-
-		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
-	}
-
-	ret = -EINVAL;
-	if (dl_chan) {
-		/*
-		 * If channel supports LPM notifications then status_cb should
-		 * be provided
-		 */
-		if (dl_chan->lpm_notify && !mhi_drv->status_cb)
-			goto exit_probe;
-
-		/* For non-offload channels then xfer_cb should be provided */
-		if (!dl_chan->offload_ch && !mhi_drv->dl_xfer_cb)
-			goto exit_probe;
-
-		mhi_event = &mhi_cntrl->mhi_event[dl_chan->er_index];
-
-		/*
-		 * If the channel event ring is managed by client, then
-		 * status_cb must be provided so that the framework can
-		 * notify pending data
-		 */
-		if (mhi_event->cl_manage && !mhi_drv->status_cb)
-			goto exit_probe;
-
-		dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
-	}
-
-	/* Call the user provided probe function */
-	ret = mhi_drv->probe(mhi_dev, mhi_dev->id);
-	if (ret)
-		goto exit_probe;
-
-	mhi_device_put(mhi_dev);
-
-	return ret;
-
-exit_probe:
-	mhi_unprepare_from_transfer(mhi_dev);
-
-	mhi_device_put(mhi_dev);
-
-	return ret;
-}
-
-static int mhi_driver_remove(struct device *dev)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-	struct mhi_driver *mhi_drv = to_mhi_driver(dev->driver);
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan;
-	enum mhi_ch_state ch_state[] = {
-		MHI_CH_STATE_DISABLED,
-		MHI_CH_STATE_DISABLED
-	};
-	int dir;
-
-	/* Skip if it is a controller device */
-	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
-		return 0;
-
-	/* Reset both channels */
-	for (dir = 0; dir < 2; dir++) {
-		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
-
-		if (!mhi_chan)
-			continue;
-
-		/* Wake all threads waiting for completion */
-		write_lock_irq(&mhi_chan->lock);
-		mhi_chan->ccs = MHI_EV_CC_INVALID;
-		complete_all(&mhi_chan->completion);
-		write_unlock_irq(&mhi_chan->lock);
-
-		/* Set the channel state to disabled */
-		mutex_lock(&mhi_chan->mutex);
-		write_lock_irq(&mhi_chan->lock);
-		ch_state[dir] = mhi_chan->ch_state;
-		mhi_chan->ch_state = MHI_CH_STATE_SUSPENDED;
-		write_unlock_irq(&mhi_chan->lock);
-
-		/* Reset the non-offload channel */
-		if (!mhi_chan->offload_ch)
-			mhi_reset_chan(mhi_cntrl, mhi_chan);
-
-		mutex_unlock(&mhi_chan->mutex);
-	}
-
-	mhi_drv->remove(mhi_dev);
-
-	/* De-init channel if it was enabled */
-	for (dir = 0; dir < 2; dir++) {
-		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
-
-		if (!mhi_chan)
-			continue;
-
-		mutex_lock(&mhi_chan->mutex);
-
-		if ((ch_state[dir] == MHI_CH_STATE_ENABLED ||
-		     ch_state[dir] == MHI_CH_STATE_STOP) &&
-		    !mhi_chan->offload_ch)
-			mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
-
-		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
-
-		mutex_unlock(&mhi_chan->mutex);
-	}
-
-	while (mhi_dev->dev_wake)
-		mhi_device_put(mhi_dev);
-
-	return 0;
-}
-
-int __mhi_driver_register(struct mhi_driver *mhi_drv, struct module *owner)
-{
-	struct device_driver *driver = &mhi_drv->driver;
-
-	if (!mhi_drv->probe || !mhi_drv->remove)
-		return -EINVAL;
-
-	driver->bus = &mhi_bus_type;
-	driver->owner = owner;
-	driver->probe = mhi_driver_probe;
-	driver->remove = mhi_driver_remove;
-
-	return driver_register(driver);
-}
-EXPORT_SYMBOL_GPL(__mhi_driver_register);
-
-void mhi_driver_unregister(struct mhi_driver *mhi_drv)
-{
-	driver_unregister(&mhi_drv->driver);
-}
-EXPORT_SYMBOL_GPL(mhi_driver_unregister);
-
-static int mhi_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-
-	return add_uevent_var(env, "MODALIAS=" MHI_DEVICE_MODALIAS_FMT,
-					mhi_dev->name);
-}
-
-static int mhi_match(struct device *dev, struct device_driver *drv)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
-	const struct mhi_device_id *id;
-
-	/*
-	 * If the device is a controller type then there is no client driver
-	 * associated with it
-	 */
-	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
-		return 0;
-
-	for (id = mhi_drv->id_table; id->chan[0]; id++)
-		if (!strcmp(mhi_dev->name, id->chan)) {
-			mhi_dev->id = id;
-			return 1;
-		}
-
-	return 0;
-};
-
-struct bus_type mhi_bus_type = {
-	.name = "mhi",
-	.dev_name = "mhi",
-	.match = mhi_match,
-	.uevent = mhi_uevent,
-	.dev_groups = mhi_dev_groups,
-};
-
-static int __init mhi_init(void)
-{
-	mhi_debugfs_init();
-	return bus_register(&mhi_bus_type);
-}
-
-static void __exit mhi_exit(void)
-{
-	mhi_debugfs_exit();
-	bus_unregister(&mhi_bus_type);
-}
-
-postcore_initcall(mhi_init);
-module_exit(mhi_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("MHI Host Interface");
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
deleted file mode 100644
index 71f181402be9..000000000000
--- a/drivers/bus/mhi/core/internal.h
+++ /dev/null
@@ -1,718 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#ifndef _MHI_INT_H
-#define _MHI_INT_H
-
-#include <linux/mhi.h>
-
-extern struct bus_type mhi_bus_type;
-
-#define MHIREGLEN (0x0)
-#define MHIREGLEN_MHIREGLEN_MASK (0xFFFFFFFF)
-#define MHIREGLEN_MHIREGLEN_SHIFT (0)
-
-#define MHIVER (0x8)
-#define MHIVER_MHIVER_MASK (0xFFFFFFFF)
-#define MHIVER_MHIVER_SHIFT (0)
-
-#define MHICFG (0x10)
-#define MHICFG_NHWER_MASK (0xFF000000)
-#define MHICFG_NHWER_SHIFT (24)
-#define MHICFG_NER_MASK (0xFF0000)
-#define MHICFG_NER_SHIFT (16)
-#define MHICFG_NHWCH_MASK (0xFF00)
-#define MHICFG_NHWCH_SHIFT (8)
-#define MHICFG_NCH_MASK (0xFF)
-#define MHICFG_NCH_SHIFT (0)
-
-#define CHDBOFF (0x18)
-#define CHDBOFF_CHDBOFF_MASK (0xFFFFFFFF)
-#define CHDBOFF_CHDBOFF_SHIFT (0)
-
-#define ERDBOFF (0x20)
-#define ERDBOFF_ERDBOFF_MASK (0xFFFFFFFF)
-#define ERDBOFF_ERDBOFF_SHIFT (0)
-
-#define BHIOFF (0x28)
-#define BHIOFF_BHIOFF_MASK (0xFFFFFFFF)
-#define BHIOFF_BHIOFF_SHIFT (0)
-
-#define BHIEOFF (0x2C)
-#define BHIEOFF_BHIEOFF_MASK (0xFFFFFFFF)
-#define BHIEOFF_BHIEOFF_SHIFT (0)
-
-#define DEBUGOFF (0x30)
-#define DEBUGOFF_DEBUGOFF_MASK (0xFFFFFFFF)
-#define DEBUGOFF_DEBUGOFF_SHIFT (0)
-
-#define MHICTRL (0x38)
-#define MHICTRL_MHISTATE_MASK (0x0000FF00)
-#define MHICTRL_MHISTATE_SHIFT (8)
-#define MHICTRL_RESET_MASK (0x2)
-#define MHICTRL_RESET_SHIFT (1)
-
-#define MHISTATUS (0x48)
-#define MHISTATUS_MHISTATE_MASK (0x0000FF00)
-#define MHISTATUS_MHISTATE_SHIFT (8)
-#define MHISTATUS_SYSERR_MASK (0x4)
-#define MHISTATUS_SYSERR_SHIFT (2)
-#define MHISTATUS_READY_MASK (0x1)
-#define MHISTATUS_READY_SHIFT (0)
-
-#define CCABAP_LOWER (0x58)
-#define CCABAP_LOWER_CCABAP_LOWER_MASK (0xFFFFFFFF)
-#define CCABAP_LOWER_CCABAP_LOWER_SHIFT (0)
-
-#define CCABAP_HIGHER (0x5C)
-#define CCABAP_HIGHER_CCABAP_HIGHER_MASK (0xFFFFFFFF)
-#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT (0)
-
-#define ECABAP_LOWER (0x60)
-#define ECABAP_LOWER_ECABAP_LOWER_MASK (0xFFFFFFFF)
-#define ECABAP_LOWER_ECABAP_LOWER_SHIFT (0)
-
-#define ECABAP_HIGHER (0x64)
-#define ECABAP_HIGHER_ECABAP_HIGHER_MASK (0xFFFFFFFF)
-#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT (0)
-
-#define CRCBAP_LOWER (0x68)
-#define CRCBAP_LOWER_CRCBAP_LOWER_MASK (0xFFFFFFFF)
-#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT (0)
-
-#define CRCBAP_HIGHER (0x6C)
-#define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK (0xFFFFFFFF)
-#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT (0)
-
-#define CRDB_LOWER (0x70)
-#define CRDB_LOWER_CRDB_LOWER_MASK (0xFFFFFFFF)
-#define CRDB_LOWER_CRDB_LOWER_SHIFT (0)
-
-#define CRDB_HIGHER (0x74)
-#define CRDB_HIGHER_CRDB_HIGHER_MASK (0xFFFFFFFF)
-#define CRDB_HIGHER_CRDB_HIGHER_SHIFT (0)
-
-#define MHICTRLBASE_LOWER (0x80)
-#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK (0xFFFFFFFF)
-#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT (0)
-
-#define MHICTRLBASE_HIGHER (0x84)
-#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK (0xFFFFFFFF)
-#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT (0)
-
-#define MHICTRLLIMIT_LOWER (0x88)
-#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK (0xFFFFFFFF)
-#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT (0)
-
-#define MHICTRLLIMIT_HIGHER (0x8C)
-#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK (0xFFFFFFFF)
-#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT (0)
-
-#define MHIDATABASE_LOWER (0x98)
-#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK (0xFFFFFFFF)
-#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT (0)
-
-#define MHIDATABASE_HIGHER (0x9C)
-#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK (0xFFFFFFFF)
-#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT (0)
-
-#define MHIDATALIMIT_LOWER (0xA0)
-#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK (0xFFFFFFFF)
-#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT (0)
-
-#define MHIDATALIMIT_HIGHER (0xA4)
-#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK (0xFFFFFFFF)
-#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT (0)
-
-/* Host request register */
-#define MHI_SOC_RESET_REQ_OFFSET (0xB0)
-#define MHI_SOC_RESET_REQ BIT(0)
-
-/* MHI BHI offfsets */
-#define BHI_BHIVERSION_MINOR (0x00)
-#define BHI_BHIVERSION_MAJOR (0x04)
-#define BHI_IMGADDR_LOW (0x08)
-#define BHI_IMGADDR_HIGH (0x0C)
-#define BHI_IMGSIZE (0x10)
-#define BHI_RSVD1 (0x14)
-#define BHI_IMGTXDB (0x18)
-#define BHI_TXDB_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHI_TXDB_SEQNUM_SHFT (0)
-#define BHI_RSVD2 (0x1C)
-#define BHI_INTVEC (0x20)
-#define BHI_RSVD3 (0x24)
-#define BHI_EXECENV (0x28)
-#define BHI_STATUS (0x2C)
-#define BHI_ERRCODE (0x30)
-#define BHI_ERRDBG1 (0x34)
-#define BHI_ERRDBG2 (0x38)
-#define BHI_ERRDBG3 (0x3C)
-#define BHI_SERIALNU (0x40)
-#define BHI_SBLANTIROLLVER (0x44)
-#define BHI_NUMSEG (0x48)
-#define BHI_MSMHWID(n) (0x4C + (0x4 * (n)))
-#define BHI_OEMPKHASH(n) (0x64 + (0x4 * (n)))
-#define BHI_RSVD5 (0xC4)
-#define BHI_STATUS_MASK (0xC0000000)
-#define BHI_STATUS_SHIFT (30)
-#define BHI_STATUS_ERROR (3)
-#define BHI_STATUS_SUCCESS (2)
-#define BHI_STATUS_RESET (0)
-
-/* MHI BHIE offsets */
-#define BHIE_MSMSOCID_OFFS (0x0000)
-#define BHIE_TXVECADDR_LOW_OFFS (0x002C)
-#define BHIE_TXVECADDR_HIGH_OFFS (0x0030)
-#define BHIE_TXVECSIZE_OFFS (0x0034)
-#define BHIE_TXVECDB_OFFS (0x003C)
-#define BHIE_TXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_TXVECDB_SEQNUM_SHFT (0)
-#define BHIE_TXVECSTATUS_OFFS (0x0044)
-#define BHIE_TXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_TXVECSTATUS_SEQNUM_SHFT (0)
-#define BHIE_TXVECSTATUS_STATUS_BMSK (0xC0000000)
-#define BHIE_TXVECSTATUS_STATUS_SHFT (30)
-#define BHIE_TXVECSTATUS_STATUS_RESET (0x00)
-#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL (0x02)
-#define BHIE_TXVECSTATUS_STATUS_ERROR (0x03)
-#define BHIE_RXVECADDR_LOW_OFFS (0x0060)
-#define BHIE_RXVECADDR_HIGH_OFFS (0x0064)
-#define BHIE_RXVECSIZE_OFFS (0x0068)
-#define BHIE_RXVECDB_OFFS (0x0070)
-#define BHIE_RXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_RXVECDB_SEQNUM_SHFT (0)
-#define BHIE_RXVECSTATUS_OFFS (0x0078)
-#define BHIE_RXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_RXVECSTATUS_SEQNUM_SHFT (0)
-#define BHIE_RXVECSTATUS_STATUS_BMSK (0xC0000000)
-#define BHIE_RXVECSTATUS_STATUS_SHFT (30)
-#define BHIE_RXVECSTATUS_STATUS_RESET (0x00)
-#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL (0x02)
-#define BHIE_RXVECSTATUS_STATUS_ERROR (0x03)
-
-#define SOC_HW_VERSION_OFFS (0x224)
-#define SOC_HW_VERSION_FAM_NUM_BMSK (0xF0000000)
-#define SOC_HW_VERSION_FAM_NUM_SHFT (28)
-#define SOC_HW_VERSION_DEV_NUM_BMSK (0x0FFF0000)
-#define SOC_HW_VERSION_DEV_NUM_SHFT (16)
-#define SOC_HW_VERSION_MAJOR_VER_BMSK (0x0000FF00)
-#define SOC_HW_VERSION_MAJOR_VER_SHFT (8)
-#define SOC_HW_VERSION_MINOR_VER_BMSK (0x000000FF)
-#define SOC_HW_VERSION_MINOR_VER_SHFT (0)
-
-#define EV_CTX_RESERVED_MASK GENMASK(7, 0)
-#define EV_CTX_INTMODC_MASK GENMASK(15, 8)
-#define EV_CTX_INTMODC_SHIFT 8
-#define EV_CTX_INTMODT_MASK GENMASK(31, 16)
-#define EV_CTX_INTMODT_SHIFT 16
-struct mhi_event_ctxt {
-	__le32 intmod;
-	__le32 ertype;
-	__le32 msivec;
-
-	__le64 rbase __packed __aligned(4);
-	__le64 rlen __packed __aligned(4);
-	__le64 rp __packed __aligned(4);
-	__le64 wp __packed __aligned(4);
-};
-
-#define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
-#define CHAN_CTX_CHSTATE_SHIFT 0
-#define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
-#define CHAN_CTX_BRSTMODE_SHIFT 8
-#define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
-#define CHAN_CTX_POLLCFG_SHIFT 10
-#define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
-struct mhi_chan_ctxt {
-	__le32 chcfg;
-	__le32 chtype;
-	__le32 erindex;
-
-	__le64 rbase __packed __aligned(4);
-	__le64 rlen __packed __aligned(4);
-	__le64 rp __packed __aligned(4);
-	__le64 wp __packed __aligned(4);
-};
-
-struct mhi_cmd_ctxt {
-	__le32 reserved0;
-	__le32 reserved1;
-	__le32 reserved2;
-
-	__le64 rbase __packed __aligned(4);
-	__le64 rlen __packed __aligned(4);
-	__le64 rp __packed __aligned(4);
-	__le64 wp __packed __aligned(4);
-};
-
-struct mhi_ctxt {
-	struct mhi_event_ctxt *er_ctxt;
-	struct mhi_chan_ctxt *chan_ctxt;
-	struct mhi_cmd_ctxt *cmd_ctxt;
-	dma_addr_t er_ctxt_addr;
-	dma_addr_t chan_ctxt_addr;
-	dma_addr_t cmd_ctxt_addr;
-};
-
-struct mhi_tre {
-	__le64 ptr;
-	__le32 dword[2];
-};
-
-struct bhi_vec_entry {
-	u64 dma_addr;
-	u64 size;
-};
-
-enum mhi_cmd_type {
-	MHI_CMD_NOP = 1,
-	MHI_CMD_RESET_CHAN = 16,
-	MHI_CMD_STOP_CHAN = 17,
-	MHI_CMD_START_CHAN = 18,
-};
-
-/* No operation command */
-#define MHI_TRE_CMD_NOOP_PTR (0)
-#define MHI_TRE_CMD_NOOP_DWORD0 (0)
-#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(MHI_CMD_NOP << 16))
-
-/* Channel reset command */
-#define MHI_TRE_CMD_RESET_PTR (0)
-#define MHI_TRE_CMD_RESET_DWORD0 (0)
-#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32((chid << 24) | \
-					(MHI_CMD_RESET_CHAN << 16)))
-
-/* Channel stop command */
-#define MHI_TRE_CMD_STOP_PTR (0)
-#define MHI_TRE_CMD_STOP_DWORD0 (0)
-#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32((chid << 24) | \
-				       (MHI_CMD_STOP_CHAN << 16)))
-
-/* Channel start command */
-#define MHI_TRE_CMD_START_PTR (0)
-#define MHI_TRE_CMD_START_DWORD0 (0)
-#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32((chid << 24) | \
-					(MHI_CMD_START_CHAN << 16)))
-
-#define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
-#define MHI_TRE_GET_CMD_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
-#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
-
-/* Event descriptor macros */
-#define MHI_TRE_EV_PTR(ptr) (cpu_to_le64(ptr))
-#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32((code << 24) | len))
-#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32((chid << 24) | (type << 16)))
-#define MHI_TRE_GET_EV_PTR(tre) (le64_to_cpu((tre)->ptr))
-#define MHI_TRE_GET_EV_CODE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_LEN(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFFFF)
-#define MHI_TRE_GET_EV_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
-#define MHI_TRE_GET_EV_STATE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_EXECENV(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_SEQ(tre) MHI_TRE_GET_DWORD(tre, 0)
-#define MHI_TRE_GET_EV_TIME(tre) (MHI_TRE_GET_EV_PTR(tre))
-#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
-#define MHI_TRE_GET_EV_VEID(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 16) & 0xFF)
-#define MHI_TRE_GET_EV_LINKSPEED(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_LINKWIDTH(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
-
-/* Transfer descriptor macros */
-#define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
-#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(len & MHI_MAX_MTU))
-#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32((2 << 16) | (bei << 10) \
-	| (ieot << 9) | (ieob << 8) | chain))
-
-/* RSC transfer descriptor macros */
-#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(((u64)len << 48) | ptr))
-#define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
-#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16))
-
-enum mhi_pkt_type {
-	MHI_PKT_TYPE_INVALID = 0x0,
-	MHI_PKT_TYPE_NOOP_CMD = 0x1,
-	MHI_PKT_TYPE_TRANSFER = 0x2,
-	MHI_PKT_TYPE_COALESCING = 0x8,
-	MHI_PKT_TYPE_RESET_CHAN_CMD = 0x10,
-	MHI_PKT_TYPE_STOP_CHAN_CMD = 0x11,
-	MHI_PKT_TYPE_START_CHAN_CMD = 0x12,
-	MHI_PKT_TYPE_STATE_CHANGE_EVENT = 0x20,
-	MHI_PKT_TYPE_CMD_COMPLETION_EVENT = 0x21,
-	MHI_PKT_TYPE_TX_EVENT = 0x22,
-	MHI_PKT_TYPE_RSC_TX_EVENT = 0x28,
-	MHI_PKT_TYPE_EE_EVENT = 0x40,
-	MHI_PKT_TYPE_TSYNC_EVENT = 0x48,
-	MHI_PKT_TYPE_BW_REQ_EVENT = 0x50,
-	MHI_PKT_TYPE_STALE_EVENT, /* internal event */
-};
-
-/* MHI transfer completion events */
-enum mhi_ev_ccs {
-	MHI_EV_CC_INVALID = 0x0,
-	MHI_EV_CC_SUCCESS = 0x1,
-	MHI_EV_CC_EOT = 0x2, /* End of transfer event */
-	MHI_EV_CC_OVERFLOW = 0x3,
-	MHI_EV_CC_EOB = 0x4, /* End of block event */
-	MHI_EV_CC_OOB = 0x5, /* Out of block event */
-	MHI_EV_CC_DB_MODE = 0x6,
-	MHI_EV_CC_UNDEFINED_ERR = 0x10,
-	MHI_EV_CC_BAD_TRE = 0x11,
-};
-
-enum mhi_ch_state {
-	MHI_CH_STATE_DISABLED = 0x0,
-	MHI_CH_STATE_ENABLED = 0x1,
-	MHI_CH_STATE_RUNNING = 0x2,
-	MHI_CH_STATE_SUSPENDED = 0x3,
-	MHI_CH_STATE_STOP = 0x4,
-	MHI_CH_STATE_ERROR = 0x5,
-};
-
-enum mhi_ch_state_type {
-	MHI_CH_STATE_TYPE_RESET,
-	MHI_CH_STATE_TYPE_STOP,
-	MHI_CH_STATE_TYPE_START,
-	MHI_CH_STATE_TYPE_MAX,
-};
-
-extern const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX];
-#define TO_CH_STATE_TYPE_STR(state) (((state) >= MHI_CH_STATE_TYPE_MAX) ? \
-				     "INVALID_STATE" : \
-				     mhi_ch_state_type_str[(state)])
-
-#define MHI_INVALID_BRSTMODE(mode) (mode != MHI_DB_BRST_DISABLE && \
-				    mode != MHI_DB_BRST_ENABLE)
-
-extern const char * const mhi_ee_str[MHI_EE_MAX];
-#define TO_MHI_EXEC_STR(ee) (((ee) >= MHI_EE_MAX) ? \
-			     "INVALID_EE" : mhi_ee_str[ee])
-
-#define MHI_IN_PBL(ee) (ee == MHI_EE_PBL || ee == MHI_EE_PTHRU || \
-			ee == MHI_EE_EDL)
-
-#define MHI_IN_MISSION_MODE(ee) (ee == MHI_EE_AMSS || ee == MHI_EE_WFW || \
-				 ee == MHI_EE_FP)
-
-enum dev_st_transition {
-	DEV_ST_TRANSITION_PBL,
-	DEV_ST_TRANSITION_READY,
-	DEV_ST_TRANSITION_SBL,
-	DEV_ST_TRANSITION_MISSION_MODE,
-	DEV_ST_TRANSITION_FP,
-	DEV_ST_TRANSITION_SYS_ERR,
-	DEV_ST_TRANSITION_DISABLE,
-	DEV_ST_TRANSITION_MAX,
-};
-
-extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
-#define TO_DEV_STATE_TRANS_STR(state) (((state) >= DEV_ST_TRANSITION_MAX) ? \
-				"INVALID_STATE" : dev_state_tran_str[state])
-
-extern const char * const mhi_state_str[MHI_STATE_MAX];
-#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
-				  !mhi_state_str[state]) ? \
-				"INVALID_STATE" : mhi_state_str[state])
-
-/* internal power states */
-enum mhi_pm_state {
-	MHI_PM_STATE_DISABLE,
-	MHI_PM_STATE_POR,
-	MHI_PM_STATE_M0,
-	MHI_PM_STATE_M2,
-	MHI_PM_STATE_M3_ENTER,
-	MHI_PM_STATE_M3,
-	MHI_PM_STATE_M3_EXIT,
-	MHI_PM_STATE_FW_DL_ERR,
-	MHI_PM_STATE_SYS_ERR_DETECT,
-	MHI_PM_STATE_SYS_ERR_PROCESS,
-	MHI_PM_STATE_SHUTDOWN_PROCESS,
-	MHI_PM_STATE_LD_ERR_FATAL_DETECT,
-	MHI_PM_STATE_MAX
-};
-
-#define MHI_PM_DISABLE			BIT(0)
-#define MHI_PM_POR			BIT(1)
-#define MHI_PM_M0			BIT(2)
-#define MHI_PM_M2			BIT(3)
-#define MHI_PM_M3_ENTER			BIT(4)
-#define MHI_PM_M3			BIT(5)
-#define MHI_PM_M3_EXIT			BIT(6)
-/* firmware download failure state */
-#define MHI_PM_FW_DL_ERR		BIT(7)
-#define MHI_PM_SYS_ERR_DETECT		BIT(8)
-#define MHI_PM_SYS_ERR_PROCESS		BIT(9)
-#define MHI_PM_SHUTDOWN_PROCESS		BIT(10)
-/* link not accessible */
-#define MHI_PM_LD_ERR_FATAL_DETECT	BIT(11)
-
-#define MHI_REG_ACCESS_VALID(pm_state) ((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
-		MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
-		MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
-		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
-#define MHI_PM_IN_ERROR_STATE(pm_state) (pm_state >= MHI_PM_FW_DL_ERR)
-#define MHI_PM_IN_FATAL_STATE(pm_state) (pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
-#define MHI_DB_ACCESS_VALID(mhi_cntrl) (mhi_cntrl->pm_state & \
-					mhi_cntrl->db_access)
-#define MHI_WAKE_DB_CLEAR_VALID(pm_state) (pm_state & (MHI_PM_M0 | \
-						MHI_PM_M2 | MHI_PM_M3_EXIT))
-#define MHI_WAKE_DB_SET_VALID(pm_state) (pm_state & MHI_PM_M2)
-#define MHI_WAKE_DB_FORCE_SET_VALID(pm_state) MHI_WAKE_DB_CLEAR_VALID(pm_state)
-#define MHI_EVENT_ACCESS_INVALID(pm_state) (pm_state == MHI_PM_DISABLE || \
-					    MHI_PM_IN_ERROR_STATE(pm_state))
-#define MHI_PM_IN_SUSPEND_STATE(pm_state) (pm_state & \
-					   (MHI_PM_M3_ENTER | MHI_PM_M3))
-
-#define NR_OF_CMD_RINGS			1
-#define CMD_EL_PER_RING			128
-#define PRIMARY_CMD_RING		0
-#define MHI_DEV_WAKE_DB			127
-#define MHI_MAX_MTU			0xffff
-#define MHI_RANDOM_U32_NONZERO(bmsk)	(prandom_u32_max(bmsk) + 1)
-
-enum mhi_er_type {
-	MHI_ER_TYPE_INVALID = 0x0,
-	MHI_ER_TYPE_VALID = 0x1,
-};
-
-struct db_cfg {
-	bool reset_req;
-	bool db_mode;
-	u32 pollcfg;
-	enum mhi_db_brst_mode brstmode;
-	dma_addr_t db_val;
-	void (*process_db)(struct mhi_controller *mhi_cntrl,
-			   struct db_cfg *db_cfg, void __iomem *io_addr,
-			   dma_addr_t db_val);
-};
-
-struct mhi_pm_transitions {
-	enum mhi_pm_state from_state;
-	u32 to_states;
-};
-
-struct state_transition {
-	struct list_head node;
-	enum dev_st_transition state;
-};
-
-struct mhi_ring {
-	dma_addr_t dma_handle;
-	dma_addr_t iommu_base;
-	__le64 *ctxt_wp; /* point to ctxt wp */
-	void *pre_aligned;
-	void *base;
-	void *rp;
-	void *wp;
-	size_t el_size;
-	size_t len;
-	size_t elements;
-	size_t alloc_size;
-	void __iomem *db_addr;
-};
-
-struct mhi_cmd {
-	struct mhi_ring ring;
-	spinlock_t lock;
-};
-
-struct mhi_buf_info {
-	void *v_addr;
-	void *bb_addr;
-	void *wp;
-	void *cb_buf;
-	dma_addr_t p_addr;
-	size_t len;
-	enum dma_data_direction dir;
-	bool used; /* Indicates whether the buffer is used or not */
-	bool pre_mapped; /* Already pre-mapped by client */
-};
-
-struct mhi_event {
-	struct mhi_controller *mhi_cntrl;
-	struct mhi_chan *mhi_chan; /* dedicated to channel */
-	u32 er_index;
-	u32 intmod;
-	u32 irq;
-	int chan; /* this event ring is dedicated to a channel (optional) */
-	u32 priority;
-	enum mhi_er_data_type data_type;
-	struct mhi_ring ring;
-	struct db_cfg db_cfg;
-	struct tasklet_struct task;
-	spinlock_t lock;
-	int (*process_event)(struct mhi_controller *mhi_cntrl,
-			     struct mhi_event *mhi_event,
-			     u32 event_quota);
-	bool hw_ring;
-	bool cl_manage;
-	bool offload_ev; /* managed by a device driver */
-};
-
-struct mhi_chan {
-	const char *name;
-	/*
-	 * Important: When consuming, increment tre_ring first and when
-	 * releasing, decrement buf_ring first. If tre_ring has space, buf_ring
-	 * is guranteed to have space so we do not need to check both rings.
-	 */
-	struct mhi_ring buf_ring;
-	struct mhi_ring tre_ring;
-	u32 chan;
-	u32 er_index;
-	u32 intmod;
-	enum mhi_ch_type type;
-	enum dma_data_direction dir;
-	struct db_cfg db_cfg;
-	enum mhi_ch_ee_mask ee_mask;
-	enum mhi_ch_state ch_state;
-	enum mhi_ev_ccs ccs;
-	struct mhi_device *mhi_dev;
-	void (*xfer_cb)(struct mhi_device *mhi_dev, struct mhi_result *result);
-	struct mutex mutex;
-	struct completion completion;
-	rwlock_t lock;
-	struct list_head node;
-	bool lpm_notify;
-	bool configured;
-	bool offload_ch;
-	bool pre_alloc;
-	bool wake_capable;
-};
-
-/* Default MHI timeout */
-#define MHI_TIMEOUT_MS (1000)
-
-/* debugfs related functions */
-#ifdef CONFIG_MHI_BUS_DEBUG
-void mhi_create_debugfs(struct mhi_controller *mhi_cntrl);
-void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl);
-void mhi_debugfs_init(void);
-void mhi_debugfs_exit(void);
-#else
-static inline void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
-{
-}
-
-static inline void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl)
-{
-}
-
-static inline void mhi_debugfs_init(void)
-{
-}
-
-static inline void mhi_debugfs_exit(void)
-{
-}
-#endif
-
-struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl);
-
-int mhi_destroy_device(struct device *dev, void *data);
-void mhi_create_devices(struct mhi_controller *mhi_cntrl);
-
-int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
-			 struct image_info **image_info, size_t alloc_size);
-void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
-			 struct image_info *image_info);
-
-/* Power management APIs */
-enum mhi_pm_state __must_check mhi_tryset_pm_state(
-					struct mhi_controller *mhi_cntrl,
-					enum mhi_pm_state state);
-const char *to_mhi_pm_state_str(u32 state);
-int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
-			       enum dev_st_transition state);
-void mhi_pm_st_worker(struct work_struct *work);
-void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl);
-int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
-int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
-void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
-int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
-int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl);
-int mhi_send_cmd(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
-		 enum mhi_cmd_type cmd);
-int mhi_download_amss_image(struct mhi_controller *mhi_cntrl);
-static inline bool mhi_is_active(struct mhi_controller *mhi_cntrl)
-{
-	return (mhi_cntrl->dev_state >= MHI_STATE_M0 &&
-		mhi_cntrl->dev_state <= MHI_STATE_M3_FAST);
-}
-
-static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
-{
-	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
-	mhi_cntrl->runtime_get(mhi_cntrl);
-	mhi_cntrl->runtime_put(mhi_cntrl);
-}
-
-/* Register access methods */
-void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct db_cfg *db_cfg,
-		     void __iomem *db_addr, dma_addr_t db_val);
-void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
-			     struct db_cfg *db_mode, void __iomem *db_addr,
-			     dma_addr_t db_val);
-int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
-			      void __iomem *base, u32 offset, u32 *out);
-int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
-				    void __iomem *base, u32 offset, u32 mask,
-				    u32 shift, u32 *out);
-int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
-				    void __iomem *base, u32 offset, u32 mask,
-				    u32 shift, u32 val, u32 delayus);
-void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
-		   u32 offset, u32 val);
-void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
-			 u32 offset, u32 mask, u32 shift, u32 val);
-void mhi_ring_er_db(struct mhi_event *mhi_event);
-void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
-		  dma_addr_t db_val);
-void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd);
-void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
-		      struct mhi_chan *mhi_chan);
-
-/* Initialization methods */
-int mhi_init_mmio(struct mhi_controller *mhi_cntrl);
-int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl);
-void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl);
-int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl);
-void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl);
-void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
-		      struct image_info *img_info);
-void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl);
-int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
-			struct mhi_chan *mhi_chan);
-int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
-		       struct mhi_chan *mhi_chan);
-void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
-			  struct mhi_chan *mhi_chan);
-void mhi_reset_chan(struct mhi_controller *mhi_cntrl,
-		    struct mhi_chan *mhi_chan);
-
-/* Event processing methods */
-void mhi_ctrl_ev_task(unsigned long data);
-void mhi_ev_task(unsigned long data);
-int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
-				struct mhi_event *mhi_event, u32 event_quota);
-int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
-			     struct mhi_event *mhi_event, u32 event_quota);
-
-/* ISR handlers */
-irqreturn_t mhi_irq_handler(int irq_number, void *dev);
-irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
-irqreturn_t mhi_intvec_handler(int irq_number, void *dev);
-
-int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
-		struct mhi_buf_info *info, enum mhi_flags flags);
-int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
-			 struct mhi_buf_info *buf_info);
-int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
-			  struct mhi_buf_info *buf_info);
-void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
-			    struct mhi_buf_info *buf_info);
-void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
-			     struct mhi_buf_info *buf_info);
-
-#endif /* _MHI_INT_H */
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
deleted file mode 100644
index 9a94b8d66f57..000000000000
--- a/drivers/bus/mhi/core/main.c
+++ /dev/null
@@ -1,1673 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/mhi.h>
-#include <linux/module.h>
-#include <linux/skbuff.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
-			      void __iomem *base, u32 offset, u32 *out)
-{
-	return mhi_cntrl->read_reg(mhi_cntrl, base + offset, out);
-}
-
-int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
-				    void __iomem *base, u32 offset,
-				    u32 mask, u32 shift, u32 *out)
-{
-	u32 tmp;
-	int ret;
-
-	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
-	if (ret)
-		return ret;
-
-	*out = (tmp & mask) >> shift;
-
-	return 0;
-}
-
-int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
-				    void __iomem *base, u32 offset,
-				    u32 mask, u32 shift, u32 val, u32 delayus)
-{
-	int ret;
-	u32 out, retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
-
-	while (retry--) {
-		ret = mhi_read_reg_field(mhi_cntrl, base, offset, mask, shift,
-					 &out);
-		if (ret)
-			return ret;
-
-		if (out == val)
-			return 0;
-
-		fsleep(delayus);
-	}
-
-	return -ETIMEDOUT;
-}
-
-void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
-		   u32 offset, u32 val)
-{
-	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
-}
-
-void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
-			 u32 offset, u32 mask, u32 shift, u32 val)
-{
-	int ret;
-	u32 tmp;
-
-	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
-	if (ret)
-		return;
-
-	tmp &= ~mask;
-	tmp |= (val << shift);
-	mhi_write_reg(mhi_cntrl, base, offset, tmp);
-}
-
-void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
-		  dma_addr_t db_val)
-{
-	mhi_write_reg(mhi_cntrl, db_addr, 4, upper_32_bits(db_val));
-	mhi_write_reg(mhi_cntrl, db_addr, 0, lower_32_bits(db_val));
-}
-
-void mhi_db_brstmode(struct mhi_controller *mhi_cntrl,
-		     struct db_cfg *db_cfg,
-		     void __iomem *db_addr,
-		     dma_addr_t db_val)
-{
-	if (db_cfg->db_mode) {
-		db_cfg->db_val = db_val;
-		mhi_write_db(mhi_cntrl, db_addr, db_val);
-		db_cfg->db_mode = 0;
-	}
-}
-
-void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
-			     struct db_cfg *db_cfg,
-			     void __iomem *db_addr,
-			     dma_addr_t db_val)
-{
-	db_cfg->db_val = db_val;
-	mhi_write_db(mhi_cntrl, db_addr, db_val);
-}
-
-void mhi_ring_er_db(struct mhi_event *mhi_event)
-{
-	struct mhi_ring *ring = &mhi_event->ring;
-
-	mhi_event->db_cfg.process_db(mhi_event->mhi_cntrl, &mhi_event->db_cfg,
-				     ring->db_addr, le64_to_cpu(*ring->ctxt_wp));
-}
-
-void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd)
-{
-	dma_addr_t db;
-	struct mhi_ring *ring = &mhi_cmd->ring;
-
-	db = ring->iommu_base + (ring->wp - ring->base);
-	*ring->ctxt_wp = cpu_to_le64(db);
-	mhi_write_db(mhi_cntrl, ring->db_addr, db);
-}
-
-void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
-		      struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *ring = &mhi_chan->tre_ring;
-	dma_addr_t db;
-
-	db = ring->iommu_base + (ring->wp - ring->base);
-
-	/*
-	 * Writes to the new ring element must be visible to the hardware
-	 * before letting h/w know there is new element to fetch.
-	 */
-	dma_wmb();
-	*ring->ctxt_wp = cpu_to_le64(db);
-
-	mhi_chan->db_cfg.process_db(mhi_cntrl, &mhi_chan->db_cfg,
-				    ring->db_addr, db);
-}
-
-enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl)
-{
-	u32 exec;
-	int ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_EXECENV, &exec);
-
-	return (ret) ? MHI_EE_MAX : exec;
-}
-EXPORT_SYMBOL_GPL(mhi_get_exec_env);
-
-enum mhi_state mhi_get_mhi_state(struct mhi_controller *mhi_cntrl)
-{
-	u32 state;
-	int ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
-				     MHISTATUS_MHISTATE_MASK,
-				     MHISTATUS_MHISTATE_SHIFT, &state);
-	return ret ? MHI_STATE_MAX : state;
-}
-EXPORT_SYMBOL_GPL(mhi_get_mhi_state);
-
-void mhi_soc_reset(struct mhi_controller *mhi_cntrl)
-{
-	if (mhi_cntrl->reset) {
-		mhi_cntrl->reset(mhi_cntrl);
-		return;
-	}
-
-	/* Generic MHI SoC reset */
-	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, MHI_SOC_RESET_REQ_OFFSET,
-		      MHI_SOC_RESET_REQ);
-}
-EXPORT_SYMBOL_GPL(mhi_soc_reset);
-
-int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
-			 struct mhi_buf_info *buf_info)
-{
-	buf_info->p_addr = dma_map_single(mhi_cntrl->cntrl_dev,
-					  buf_info->v_addr, buf_info->len,
-					  buf_info->dir);
-	if (dma_mapping_error(mhi_cntrl->cntrl_dev, buf_info->p_addr))
-		return -ENOMEM;
-
-	return 0;
-}
-
-int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
-			  struct mhi_buf_info *buf_info)
-{
-	void *buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev, buf_info->len,
-				       &buf_info->p_addr, GFP_ATOMIC);
-
-	if (!buf)
-		return -ENOMEM;
-
-	if (buf_info->dir == DMA_TO_DEVICE)
-		memcpy(buf, buf_info->v_addr, buf_info->len);
-
-	buf_info->bb_addr = buf;
-
-	return 0;
-}
-
-void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
-			    struct mhi_buf_info *buf_info)
-{
-	dma_unmap_single(mhi_cntrl->cntrl_dev, buf_info->p_addr, buf_info->len,
-			 buf_info->dir);
-}
-
-void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
-			     struct mhi_buf_info *buf_info)
-{
-	if (buf_info->dir == DMA_FROM_DEVICE)
-		memcpy(buf_info->v_addr, buf_info->bb_addr, buf_info->len);
-
-	dma_free_coherent(mhi_cntrl->cntrl_dev, buf_info->len,
-			  buf_info->bb_addr, buf_info->p_addr);
-}
-
-static int get_nr_avail_ring_elements(struct mhi_controller *mhi_cntrl,
-				      struct mhi_ring *ring)
-{
-	int nr_el;
-
-	if (ring->wp < ring->rp) {
-		nr_el = ((ring->rp - ring->wp) / ring->el_size) - 1;
-	} else {
-		nr_el = (ring->rp - ring->base) / ring->el_size;
-		nr_el += ((ring->base + ring->len - ring->wp) /
-			  ring->el_size) - 1;
-	}
-
-	return nr_el;
-}
-
-static void *mhi_to_virtual(struct mhi_ring *ring, dma_addr_t addr)
-{
-	return (addr - ring->iommu_base) + ring->base;
-}
-
-static void mhi_add_ring_element(struct mhi_controller *mhi_cntrl,
-				 struct mhi_ring *ring)
-{
-	ring->wp += ring->el_size;
-	if (ring->wp >= (ring->base + ring->len))
-		ring->wp = ring->base;
-	/* smp update */
-	smp_wmb();
-}
-
-static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
-				 struct mhi_ring *ring)
-{
-	ring->rp += ring->el_size;
-	if (ring->rp >= (ring->base + ring->len))
-		ring->rp = ring->base;
-	/* smp update */
-	smp_wmb();
-}
-
-static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
-{
-	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
-}
-
-int mhi_destroy_device(struct device *dev, void *data)
-{
-	struct mhi_chan *ul_chan, *dl_chan;
-	struct mhi_device *mhi_dev;
-	struct mhi_controller *mhi_cntrl;
-	enum mhi_ee_type ee = MHI_EE_MAX;
-
-	if (dev->bus != &mhi_bus_type)
-		return 0;
-
-	mhi_dev = to_mhi_device(dev);
-	mhi_cntrl = mhi_dev->mhi_cntrl;
-
-	/* Only destroy virtual devices thats attached to bus */
-	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
-		return 0;
-
-	ul_chan = mhi_dev->ul_chan;
-	dl_chan = mhi_dev->dl_chan;
-
-	/*
-	 * If execution environment is specified, remove only those devices that
-	 * started in them based on ee_mask for the channels as we move on to a
-	 * different execution environment
-	 */
-	if (data)
-		ee = *(enum mhi_ee_type *)data;
-
-	/*
-	 * For the suspend and resume case, this function will get called
-	 * without mhi_unregister_controller(). Hence, we need to drop the
-	 * references to mhi_dev created for ul and dl channels. We can
-	 * be sure that there will be no instances of mhi_dev left after
-	 * this.
-	 */
-	if (ul_chan) {
-		if (ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
-			return 0;
-
-		put_device(&ul_chan->mhi_dev->dev);
-	}
-
-	if (dl_chan) {
-		if (ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
-			return 0;
-
-		put_device(&dl_chan->mhi_dev->dev);
-	}
-
-	dev_dbg(&mhi_cntrl->mhi_dev->dev, "destroy device for chan:%s\n",
-		 mhi_dev->name);
-
-	/* Notify the client and remove the device from MHI bus */
-	device_del(dev);
-	put_device(dev);
-
-	return 0;
-}
-
-int mhi_get_free_desc_count(struct mhi_device *mhi_dev,
-				enum dma_data_direction dir)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ?
-		mhi_dev->ul_chan : mhi_dev->dl_chan;
-	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
-
-	return get_nr_avail_ring_elements(mhi_cntrl, tre_ring);
-}
-EXPORT_SYMBOL_GPL(mhi_get_free_desc_count);
-
-void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason)
-{
-	struct mhi_driver *mhi_drv;
-
-	if (!mhi_dev->dev.driver)
-		return;
-
-	mhi_drv = to_mhi_driver(mhi_dev->dev.driver);
-
-	if (mhi_drv->status_cb)
-		mhi_drv->status_cb(mhi_dev, cb_reason);
-}
-EXPORT_SYMBOL_GPL(mhi_notify);
-
-/* Bind MHI channels to MHI devices */
-void mhi_create_devices(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_chan *mhi_chan;
-	struct mhi_device *mhi_dev;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int i, ret;
-
-	mhi_chan = mhi_cntrl->mhi_chan;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
-		if (!mhi_chan->configured || mhi_chan->mhi_dev ||
-		    !(mhi_chan->ee_mask & BIT(mhi_cntrl->ee)))
-			continue;
-		mhi_dev = mhi_alloc_device(mhi_cntrl);
-		if (IS_ERR(mhi_dev))
-			return;
-
-		mhi_dev->dev_type = MHI_DEVICE_XFER;
-		switch (mhi_chan->dir) {
-		case DMA_TO_DEVICE:
-			mhi_dev->ul_chan = mhi_chan;
-			mhi_dev->ul_chan_id = mhi_chan->chan;
-			break;
-		case DMA_FROM_DEVICE:
-			/* We use dl_chan as offload channels */
-			mhi_dev->dl_chan = mhi_chan;
-			mhi_dev->dl_chan_id = mhi_chan->chan;
-			break;
-		default:
-			dev_err(dev, "Direction not supported\n");
-			put_device(&mhi_dev->dev);
-			return;
-		}
-
-		get_device(&mhi_dev->dev);
-		mhi_chan->mhi_dev = mhi_dev;
-
-		/* Check next channel if it matches */
-		if ((i + 1) < mhi_cntrl->max_chan && mhi_chan[1].configured) {
-			if (!strcmp(mhi_chan[1].name, mhi_chan->name)) {
-				i++;
-				mhi_chan++;
-				if (mhi_chan->dir == DMA_TO_DEVICE) {
-					mhi_dev->ul_chan = mhi_chan;
-					mhi_dev->ul_chan_id = mhi_chan->chan;
-				} else {
-					mhi_dev->dl_chan = mhi_chan;
-					mhi_dev->dl_chan_id = mhi_chan->chan;
-				}
-				get_device(&mhi_dev->dev);
-				mhi_chan->mhi_dev = mhi_dev;
-			}
-		}
-
-		/* Channel name is same for both UL and DL */
-		mhi_dev->name = mhi_chan->name;
-		dev_set_name(&mhi_dev->dev, "%s_%s",
-			     dev_name(&mhi_cntrl->mhi_dev->dev),
-			     mhi_dev->name);
-
-		/* Init wakeup source if available */
-		if (mhi_dev->dl_chan && mhi_dev->dl_chan->wake_capable)
-			device_init_wakeup(&mhi_dev->dev, true);
-
-		ret = device_add(&mhi_dev->dev);
-		if (ret)
-			put_device(&mhi_dev->dev);
-	}
-}
-
-irqreturn_t mhi_irq_handler(int irq_number, void *dev)
-{
-	struct mhi_event *mhi_event = dev;
-	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
-	struct mhi_event_ctxt *er_ctxt =
-		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
-	struct mhi_ring *ev_ring = &mhi_event->ring;
-	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
-	void *dev_rp;
-
-	if (!is_valid_ring_ptr(ev_ring, ptr)) {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Event ring rp points outside of the event ring\n");
-		return IRQ_HANDLED;
-	}
-
-	dev_rp = mhi_to_virtual(ev_ring, ptr);
-
-	/* Only proceed if event ring has pending events */
-	if (ev_ring->rp == dev_rp)
-		return IRQ_HANDLED;
-
-	/* For client managed event ring, notify pending data */
-	if (mhi_event->cl_manage) {
-		struct mhi_chan *mhi_chan = mhi_event->mhi_chan;
-		struct mhi_device *mhi_dev = mhi_chan->mhi_dev;
-
-		if (mhi_dev)
-			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
-	} else {
-		tasklet_schedule(&mhi_event->task);
-	}
-
-	return IRQ_HANDLED;
-}
-
-irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
-{
-	struct mhi_controller *mhi_cntrl = priv;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	enum mhi_state state;
-	enum mhi_pm_state pm_state = 0;
-	enum mhi_ee_type ee;
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		goto exit_intvec;
-	}
-
-	state = mhi_get_mhi_state(mhi_cntrl);
-	ee = mhi_get_exec_env(mhi_cntrl);
-	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
-		TO_MHI_EXEC_STR(mhi_cntrl->ee),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-		TO_MHI_EXEC_STR(ee), TO_MHI_STATE_STR(state));
-
-	if (state == MHI_STATE_SYS_ERR) {
-		dev_dbg(dev, "System error detected\n");
-		pm_state = mhi_tryset_pm_state(mhi_cntrl,
-					       MHI_PM_SYS_ERR_DETECT);
-	}
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	if (pm_state != MHI_PM_SYS_ERR_DETECT || ee == mhi_cntrl->ee)
-		goto exit_intvec;
-
-	switch (ee) {
-	case MHI_EE_RDDM:
-		/* proceed if power down is not already in progress */
-		if (mhi_cntrl->rddm_image && mhi_is_active(mhi_cntrl)) {
-			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
-			mhi_cntrl->ee = ee;
-			wake_up_all(&mhi_cntrl->state_event);
-		}
-		break;
-	case MHI_EE_PBL:
-	case MHI_EE_EDL:
-	case MHI_EE_PTHRU:
-		mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_FATAL_ERROR);
-		mhi_cntrl->ee = ee;
-		wake_up_all(&mhi_cntrl->state_event);
-		mhi_pm_sys_err_handler(mhi_cntrl);
-		break;
-	default:
-		wake_up_all(&mhi_cntrl->state_event);
-		mhi_pm_sys_err_handler(mhi_cntrl);
-		break;
-	}
-
-exit_intvec:
-
-	return IRQ_HANDLED;
-}
-
-irqreturn_t mhi_intvec_handler(int irq_number, void *dev)
-{
-	struct mhi_controller *mhi_cntrl = dev;
-
-	/* Wake up events waiting for state change */
-	wake_up_all(&mhi_cntrl->state_event);
-
-	return IRQ_WAKE_THREAD;
-}
-
-static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
-					struct mhi_ring *ring)
-{
-	dma_addr_t ctxt_wp;
-
-	/* Update the WP */
-	ring->wp += ring->el_size;
-	ctxt_wp = le64_to_cpu(*ring->ctxt_wp) + ring->el_size;
-
-	if (ring->wp >= (ring->base + ring->len)) {
-		ring->wp = ring->base;
-		ctxt_wp = ring->iommu_base;
-	}
-
-	*ring->ctxt_wp = cpu_to_le64(ctxt_wp);
-
-	/* Update the RP */
-	ring->rp += ring->el_size;
-	if (ring->rp >= (ring->base + ring->len))
-		ring->rp = ring->base;
-
-	/* Update to all cores */
-	smp_wmb();
-}
-
-static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
-			    struct mhi_tre *event,
-			    struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *buf_ring, *tre_ring;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	struct mhi_result result;
-	unsigned long flags = 0;
-	u32 ev_code;
-
-	ev_code = MHI_TRE_GET_EV_CODE(event);
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-
-	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
-		-EOVERFLOW : 0;
-
-	/*
-	 * If it's a DB Event then we need to grab the lock
-	 * with preemption disabled and as a write because we
-	 * have to update db register and there are chances that
-	 * another thread could be doing the same.
-	 */
-	if (ev_code >= MHI_EV_CC_OOB)
-		write_lock_irqsave(&mhi_chan->lock, flags);
-	else
-		read_lock_bh(&mhi_chan->lock);
-
-	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
-		goto end_process_tx_event;
-
-	switch (ev_code) {
-	case MHI_EV_CC_OVERFLOW:
-	case MHI_EV_CC_EOB:
-	case MHI_EV_CC_EOT:
-	{
-		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
-		struct mhi_tre *local_rp, *ev_tre;
-		void *dev_rp;
-		struct mhi_buf_info *buf_info;
-		u16 xfer_len;
-
-		if (!is_valid_ring_ptr(tre_ring, ptr)) {
-			dev_err(&mhi_cntrl->mhi_dev->dev,
-				"Event element points outside of the tre ring\n");
-			break;
-		}
-		/* Get the TRB this event points to */
-		ev_tre = mhi_to_virtual(tre_ring, ptr);
-
-		dev_rp = ev_tre + 1;
-		if (dev_rp >= (tre_ring->base + tre_ring->len))
-			dev_rp = tre_ring->base;
-
-		result.dir = mhi_chan->dir;
-
-		local_rp = tre_ring->rp;
-		while (local_rp != dev_rp) {
-			buf_info = buf_ring->rp;
-			/* If it's the last TRE, get length from the event */
-			if (local_rp == ev_tre)
-				xfer_len = MHI_TRE_GET_EV_LEN(event);
-			else
-				xfer_len = buf_info->len;
-
-			/* Unmap if it's not pre-mapped by client */
-			if (likely(!buf_info->pre_mapped))
-				mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
-
-			result.buf_addr = buf_info->cb_buf;
-
-			/* truncate to buf len if xfer_len is larger */
-			result.bytes_xferd =
-				min_t(u16, xfer_len, buf_info->len);
-			mhi_del_ring_element(mhi_cntrl, buf_ring);
-			mhi_del_ring_element(mhi_cntrl, tre_ring);
-			local_rp = tre_ring->rp;
-
-			/* notify client */
-			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
-
-			if (mhi_chan->dir == DMA_TO_DEVICE) {
-				atomic_dec(&mhi_cntrl->pending_pkts);
-				/* Release the reference got from mhi_queue() */
-				mhi_cntrl->runtime_put(mhi_cntrl);
-			}
-
-			/*
-			 * Recycle the buffer if buffer is pre-allocated,
-			 * if there is an error, not much we can do apart
-			 * from dropping the packet
-			 */
-			if (mhi_chan->pre_alloc) {
-				if (mhi_queue_buf(mhi_chan->mhi_dev,
-						  mhi_chan->dir,
-						  buf_info->cb_buf,
-						  buf_info->len, MHI_EOT)) {
-					dev_err(dev,
-						"Error recycling buffer for chan:%d\n",
-						mhi_chan->chan);
-					kfree(buf_info->cb_buf);
-				}
-			}
-		}
-		break;
-	} /* CC_EOT */
-	case MHI_EV_CC_OOB:
-	case MHI_EV_CC_DB_MODE:
-	{
-		unsigned long pm_lock_flags;
-
-		mhi_chan->db_cfg.db_mode = 1;
-		read_lock_irqsave(&mhi_cntrl->pm_lock, pm_lock_flags);
-		if (tre_ring->wp != tre_ring->rp &&
-		    MHI_DB_ACCESS_VALID(mhi_cntrl)) {
-			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-		}
-		read_unlock_irqrestore(&mhi_cntrl->pm_lock, pm_lock_flags);
-		break;
-	}
-	case MHI_EV_CC_BAD_TRE:
-	default:
-		dev_err(dev, "Unknown event 0x%x\n", ev_code);
-		break;
-	} /* switch(MHI_EV_READ_CODE(EV_TRB_CODE,event)) */
-
-end_process_tx_event:
-	if (ev_code >= MHI_EV_CC_OOB)
-		write_unlock_irqrestore(&mhi_chan->lock, flags);
-	else
-		read_unlock_bh(&mhi_chan->lock);
-
-	return 0;
-}
-
-static int parse_rsc_event(struct mhi_controller *mhi_cntrl,
-			   struct mhi_tre *event,
-			   struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *buf_ring, *tre_ring;
-	struct mhi_buf_info *buf_info;
-	struct mhi_result result;
-	int ev_code;
-	u32 cookie; /* offset to local descriptor */
-	u16 xfer_len;
-
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-
-	ev_code = MHI_TRE_GET_EV_CODE(event);
-	cookie = MHI_TRE_GET_EV_COOKIE(event);
-	xfer_len = MHI_TRE_GET_EV_LEN(event);
-
-	/* Received out of bound cookie */
-	WARN_ON(cookie >= buf_ring->len);
-
-	buf_info = buf_ring->base + cookie;
-
-	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
-		-EOVERFLOW : 0;
-
-	/* truncate to buf len if xfer_len is larger */
-	result.bytes_xferd = min_t(u16, xfer_len, buf_info->len);
-	result.buf_addr = buf_info->cb_buf;
-	result.dir = mhi_chan->dir;
-
-	read_lock_bh(&mhi_chan->lock);
-
-	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
-		goto end_process_rsc_event;
-
-	WARN_ON(!buf_info->used);
-
-	/* notify the client */
-	mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
-
-	/*
-	 * Note: We're arbitrarily incrementing RP even though, completion
-	 * packet we processed might not be the same one, reason we can do this
-	 * is because device guaranteed to cache descriptors in order it
-	 * receive, so even though completion event is different we can re-use
-	 * all descriptors in between.
-	 * Example:
-	 * Transfer Ring has descriptors: A, B, C, D
-	 * Last descriptor host queue is D (WP) and first descriptor
-	 * host queue is A (RP).
-	 * The completion event we just serviced is descriptor C.
-	 * Then we can safely queue descriptors to replace A, B, and C
-	 * even though host did not receive any completions.
-	 */
-	mhi_del_ring_element(mhi_cntrl, tre_ring);
-	buf_info->used = false;
-
-end_process_rsc_event:
-	read_unlock_bh(&mhi_chan->lock);
-
-	return 0;
-}
-
-static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
-				       struct mhi_tre *tre)
-{
-	dma_addr_t ptr = MHI_TRE_GET_EV_PTR(tre);
-	struct mhi_cmd *cmd_ring = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
-	struct mhi_ring *mhi_ring = &cmd_ring->ring;
-	struct mhi_tre *cmd_pkt;
-	struct mhi_chan *mhi_chan;
-	u32 chan;
-
-	if (!is_valid_ring_ptr(mhi_ring, ptr)) {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Event element points outside of the cmd ring\n");
-		return;
-	}
-
-	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
-
-	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
-
-	if (chan < mhi_cntrl->max_chan &&
-	    mhi_cntrl->mhi_chan[chan].configured) {
-		mhi_chan = &mhi_cntrl->mhi_chan[chan];
-		write_lock_bh(&mhi_chan->lock);
-		mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
-		complete(&mhi_chan->completion);
-		write_unlock_bh(&mhi_chan->lock);
-	} else {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Completion packet for invalid channel ID: %d\n", chan);
-	}
-
-	mhi_del_ring_element(mhi_cntrl, mhi_ring);
-}
-
-int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
-			     struct mhi_event *mhi_event,
-			     u32 event_quota)
-{
-	struct mhi_tre *dev_rp, *local_rp;
-	struct mhi_ring *ev_ring = &mhi_event->ring;
-	struct mhi_event_ctxt *er_ctxt =
-		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
-	struct mhi_chan *mhi_chan;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 chan;
-	int count = 0;
-	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
-
-	/*
-	 * This is a quick check to avoid unnecessary event processing
-	 * in case MHI is already in error state, but it's still possible
-	 * to transition to error state while processing events
-	 */
-	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
-		return -EIO;
-
-	if (!is_valid_ring_ptr(ev_ring, ptr)) {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Event ring rp points outside of the event ring\n");
-		return -EIO;
-	}
-
-	dev_rp = mhi_to_virtual(ev_ring, ptr);
-	local_rp = ev_ring->rp;
-
-	while (dev_rp != local_rp) {
-		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
-
-		switch (type) {
-		case MHI_PKT_TYPE_BW_REQ_EVENT:
-		{
-			struct mhi_link_info *link_info;
-
-			link_info = &mhi_cntrl->mhi_link_info;
-			write_lock_irq(&mhi_cntrl->pm_lock);
-			link_info->target_link_speed =
-				MHI_TRE_GET_EV_LINKSPEED(local_rp);
-			link_info->target_link_width =
-				MHI_TRE_GET_EV_LINKWIDTH(local_rp);
-			write_unlock_irq(&mhi_cntrl->pm_lock);
-			dev_dbg(dev, "Received BW_REQ event\n");
-			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_BW_REQ);
-			break;
-		}
-		case MHI_PKT_TYPE_STATE_CHANGE_EVENT:
-		{
-			enum mhi_state new_state;
-
-			new_state = MHI_TRE_GET_EV_STATE(local_rp);
-
-			dev_dbg(dev, "State change event to state: %s\n",
-				TO_MHI_STATE_STR(new_state));
-
-			switch (new_state) {
-			case MHI_STATE_M0:
-				mhi_pm_m0_transition(mhi_cntrl);
-				break;
-			case MHI_STATE_M1:
-				mhi_pm_m1_transition(mhi_cntrl);
-				break;
-			case MHI_STATE_M3:
-				mhi_pm_m3_transition(mhi_cntrl);
-				break;
-			case MHI_STATE_SYS_ERR:
-			{
-				enum mhi_pm_state pm_state;
-
-				dev_dbg(dev, "System error detected\n");
-				write_lock_irq(&mhi_cntrl->pm_lock);
-				pm_state = mhi_tryset_pm_state(mhi_cntrl,
-							MHI_PM_SYS_ERR_DETECT);
-				write_unlock_irq(&mhi_cntrl->pm_lock);
-				if (pm_state == MHI_PM_SYS_ERR_DETECT)
-					mhi_pm_sys_err_handler(mhi_cntrl);
-				break;
-			}
-			default:
-				dev_err(dev, "Invalid state: %s\n",
-					TO_MHI_STATE_STR(new_state));
-			}
-
-			break;
-		}
-		case MHI_PKT_TYPE_CMD_COMPLETION_EVENT:
-			mhi_process_cmd_completion(mhi_cntrl, local_rp);
-			break;
-		case MHI_PKT_TYPE_EE_EVENT:
-		{
-			enum dev_st_transition st = DEV_ST_TRANSITION_MAX;
-			enum mhi_ee_type event = MHI_TRE_GET_EV_EXECENV(local_rp);
-
-			dev_dbg(dev, "Received EE event: %s\n",
-				TO_MHI_EXEC_STR(event));
-			switch (event) {
-			case MHI_EE_SBL:
-				st = DEV_ST_TRANSITION_SBL;
-				break;
-			case MHI_EE_WFW:
-			case MHI_EE_AMSS:
-				st = DEV_ST_TRANSITION_MISSION_MODE;
-				break;
-			case MHI_EE_FP:
-				st = DEV_ST_TRANSITION_FP;
-				break;
-			case MHI_EE_RDDM:
-				mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
-				write_lock_irq(&mhi_cntrl->pm_lock);
-				mhi_cntrl->ee = event;
-				write_unlock_irq(&mhi_cntrl->pm_lock);
-				wake_up_all(&mhi_cntrl->state_event);
-				break;
-			default:
-				dev_err(dev,
-					"Unhandled EE event: 0x%x\n", type);
-			}
-			if (st != DEV_ST_TRANSITION_MAX)
-				mhi_queue_state_transition(mhi_cntrl, st);
-
-			break;
-		}
-		case MHI_PKT_TYPE_TX_EVENT:
-			chan = MHI_TRE_GET_EV_CHID(local_rp);
-
-			WARN_ON(chan >= mhi_cntrl->max_chan);
-
-			/*
-			 * Only process the event ring elements whose channel
-			 * ID is within the maximum supported range.
-			 */
-			if (chan < mhi_cntrl->max_chan) {
-				mhi_chan = &mhi_cntrl->mhi_chan[chan];
-				if (!mhi_chan->configured)
-					break;
-				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
-				event_quota--;
-			}
-			break;
-		default:
-			dev_err(dev, "Unhandled event type: %d\n", type);
-			break;
-		}
-
-		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
-		local_rp = ev_ring->rp;
-
-		ptr = le64_to_cpu(er_ctxt->rp);
-		if (!is_valid_ring_ptr(ev_ring, ptr)) {
-			dev_err(&mhi_cntrl->mhi_dev->dev,
-				"Event ring rp points outside of the event ring\n");
-			return -EIO;
-		}
-
-		dev_rp = mhi_to_virtual(ev_ring, ptr);
-		count++;
-	}
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
-		mhi_ring_er_db(mhi_event);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return count;
-}
-
-int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
-				struct mhi_event *mhi_event,
-				u32 event_quota)
-{
-	struct mhi_tre *dev_rp, *local_rp;
-	struct mhi_ring *ev_ring = &mhi_event->ring;
-	struct mhi_event_ctxt *er_ctxt =
-		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
-	int count = 0;
-	u32 chan;
-	struct mhi_chan *mhi_chan;
-	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
-
-	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
-		return -EIO;
-
-	if (!is_valid_ring_ptr(ev_ring, ptr)) {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Event ring rp points outside of the event ring\n");
-		return -EIO;
-	}
-
-	dev_rp = mhi_to_virtual(ev_ring, ptr);
-	local_rp = ev_ring->rp;
-
-	while (dev_rp != local_rp && event_quota > 0) {
-		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
-
-		chan = MHI_TRE_GET_EV_CHID(local_rp);
-
-		WARN_ON(chan >= mhi_cntrl->max_chan);
-
-		/*
-		 * Only process the event ring elements whose channel
-		 * ID is within the maximum supported range.
-		 */
-		if (chan < mhi_cntrl->max_chan &&
-		    mhi_cntrl->mhi_chan[chan].configured) {
-			mhi_chan = &mhi_cntrl->mhi_chan[chan];
-
-			if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
-				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
-				event_quota--;
-			} else if (type == MHI_PKT_TYPE_RSC_TX_EVENT) {
-				parse_rsc_event(mhi_cntrl, local_rp, mhi_chan);
-				event_quota--;
-			}
-		}
-
-		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
-		local_rp = ev_ring->rp;
-
-		ptr = le64_to_cpu(er_ctxt->rp);
-		if (!is_valid_ring_ptr(ev_ring, ptr)) {
-			dev_err(&mhi_cntrl->mhi_dev->dev,
-				"Event ring rp points outside of the event ring\n");
-			return -EIO;
-		}
-
-		dev_rp = mhi_to_virtual(ev_ring, ptr);
-		count++;
-	}
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
-		mhi_ring_er_db(mhi_event);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return count;
-}
-
-void mhi_ev_task(unsigned long data)
-{
-	struct mhi_event *mhi_event = (struct mhi_event *)data;
-	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
-
-	/* process all pending events */
-	spin_lock_bh(&mhi_event->lock);
-	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
-	spin_unlock_bh(&mhi_event->lock);
-}
-
-void mhi_ctrl_ev_task(unsigned long data)
-{
-	struct mhi_event *mhi_event = (struct mhi_event *)data;
-	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	enum mhi_state state;
-	enum mhi_pm_state pm_state = 0;
-	int ret;
-
-	/*
-	 * We can check PM state w/o a lock here because there is no way
-	 * PM state can change from reg access valid to no access while this
-	 * thread being executed.
-	 */
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		/*
-		 * We may have a pending event but not allowed to
-		 * process it since we are probably in a suspended state,
-		 * so trigger a resume.
-		 */
-		mhi_trigger_resume(mhi_cntrl);
-
-		return;
-	}
-
-	/* Process ctrl events events */
-	ret = mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
-
-	/*
-	 * We received an IRQ but no events to process, maybe device went to
-	 * SYS_ERR state? Check the state to confirm.
-	 */
-	if (!ret) {
-		write_lock_irq(&mhi_cntrl->pm_lock);
-		state = mhi_get_mhi_state(mhi_cntrl);
-		if (state == MHI_STATE_SYS_ERR) {
-			dev_dbg(dev, "System error detected\n");
-			pm_state = mhi_tryset_pm_state(mhi_cntrl,
-						       MHI_PM_SYS_ERR_DETECT);
-		}
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		if (pm_state == MHI_PM_SYS_ERR_DETECT)
-			mhi_pm_sys_err_handler(mhi_cntrl);
-	}
-}
-
-static bool mhi_is_ring_full(struct mhi_controller *mhi_cntrl,
-			     struct mhi_ring *ring)
-{
-	void *tmp = ring->wp + ring->el_size;
-
-	if (tmp >= (ring->base + ring->len))
-		tmp = ring->base;
-
-	return (tmp == ring->rp);
-}
-
-static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
-		     enum dma_data_direction dir, enum mhi_flags mflags)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
-							     mhi_dev->dl_chan;
-	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
-	unsigned long flags;
-	int ret;
-
-	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
-		return -EIO;
-
-	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
-
-	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
-	if (unlikely(ret)) {
-		ret = -EAGAIN;
-		goto exit_unlock;
-	}
-
-	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, buf_info, mflags);
-	if (unlikely(ret))
-		goto exit_unlock;
-
-	/* Packet is queued, take a usage ref to exit M3 if necessary
-	 * for host->device buffer, balanced put is done on buffer completion
-	 * for device->host buffer, balanced put is after ringing the DB
-	 */
-	mhi_cntrl->runtime_get(mhi_cntrl);
-
-	/* Assert dev_wake (to exit/prevent M1/M2)*/
-	mhi_cntrl->wake_toggle(mhi_cntrl);
-
-	if (mhi_chan->dir == DMA_TO_DEVICE)
-		atomic_inc(&mhi_cntrl->pending_pkts);
-
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
-		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-
-	if (dir == DMA_FROM_DEVICE)
-		mhi_cntrl->runtime_put(mhi_cntrl);
-
-exit_unlock:
-	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
-
-	return ret;
-}
-
-int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
-		  struct sk_buff *skb, size_t len, enum mhi_flags mflags)
-{
-	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
-							     mhi_dev->dl_chan;
-	struct mhi_buf_info buf_info = { };
-
-	buf_info.v_addr = skb->data;
-	buf_info.cb_buf = skb;
-	buf_info.len = len;
-
-	if (unlikely(mhi_chan->pre_alloc))
-		return -EINVAL;
-
-	return mhi_queue(mhi_dev, &buf_info, dir, mflags);
-}
-EXPORT_SYMBOL_GPL(mhi_queue_skb);
-
-int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
-		  struct mhi_buf *mhi_buf, size_t len, enum mhi_flags mflags)
-{
-	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
-							     mhi_dev->dl_chan;
-	struct mhi_buf_info buf_info = { };
-
-	buf_info.p_addr = mhi_buf->dma_addr;
-	buf_info.cb_buf = mhi_buf;
-	buf_info.pre_mapped = true;
-	buf_info.len = len;
-
-	if (unlikely(mhi_chan->pre_alloc))
-		return -EINVAL;
-
-	return mhi_queue(mhi_dev, &buf_info, dir, mflags);
-}
-EXPORT_SYMBOL_GPL(mhi_queue_dma);
-
-int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
-			struct mhi_buf_info *info, enum mhi_flags flags)
-{
-	struct mhi_ring *buf_ring, *tre_ring;
-	struct mhi_tre *mhi_tre;
-	struct mhi_buf_info *buf_info;
-	int eot, eob, chain, bei;
-	int ret;
-
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-
-	buf_info = buf_ring->wp;
-	WARN_ON(buf_info->used);
-	buf_info->pre_mapped = info->pre_mapped;
-	if (info->pre_mapped)
-		buf_info->p_addr = info->p_addr;
-	else
-		buf_info->v_addr = info->v_addr;
-	buf_info->cb_buf = info->cb_buf;
-	buf_info->wp = tre_ring->wp;
-	buf_info->dir = mhi_chan->dir;
-	buf_info->len = info->len;
-
-	if (!info->pre_mapped) {
-		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
-		if (ret)
-			return ret;
-	}
-
-	eob = !!(flags & MHI_EOB);
-	eot = !!(flags & MHI_EOT);
-	chain = !!(flags & MHI_CHAIN);
-	bei = !!(mhi_chan->intmod);
-
-	mhi_tre = tre_ring->wp;
-	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
-	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
-	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
-
-	/* increment WP */
-	mhi_add_ring_element(mhi_cntrl, tre_ring);
-	mhi_add_ring_element(mhi_cntrl, buf_ring);
-
-	return 0;
-}
-
-int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
-		  void *buf, size_t len, enum mhi_flags mflags)
-{
-	struct mhi_buf_info buf_info = { };
-
-	buf_info.v_addr = buf;
-	buf_info.cb_buf = buf;
-	buf_info.len = len;
-
-	return mhi_queue(mhi_dev, &buf_info, dir, mflags);
-}
-EXPORT_SYMBOL_GPL(mhi_queue_buf);
-
-bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ?
-					mhi_dev->ul_chan : mhi_dev->dl_chan;
-	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
-
-	return mhi_is_ring_full(mhi_cntrl, tre_ring);
-}
-EXPORT_SYMBOL_GPL(mhi_queue_is_full);
-
-int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
-		 struct mhi_chan *mhi_chan,
-		 enum mhi_cmd_type cmd)
-{
-	struct mhi_tre *cmd_tre = NULL;
-	struct mhi_cmd *mhi_cmd = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
-	struct mhi_ring *ring = &mhi_cmd->ring;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int chan = 0;
-
-	if (mhi_chan)
-		chan = mhi_chan->chan;
-
-	spin_lock_bh(&mhi_cmd->lock);
-	if (!get_nr_avail_ring_elements(mhi_cntrl, ring)) {
-		spin_unlock_bh(&mhi_cmd->lock);
-		return -ENOMEM;
-	}
-
-	/* prepare the cmd tre */
-	cmd_tre = ring->wp;
-	switch (cmd) {
-	case MHI_CMD_RESET_CHAN:
-		cmd_tre->ptr = MHI_TRE_CMD_RESET_PTR;
-		cmd_tre->dword[0] = MHI_TRE_CMD_RESET_DWORD0;
-		cmd_tre->dword[1] = MHI_TRE_CMD_RESET_DWORD1(chan);
-		break;
-	case MHI_CMD_STOP_CHAN:
-		cmd_tre->ptr = MHI_TRE_CMD_STOP_PTR;
-		cmd_tre->dword[0] = MHI_TRE_CMD_STOP_DWORD0;
-		cmd_tre->dword[1] = MHI_TRE_CMD_STOP_DWORD1(chan);
-		break;
-	case MHI_CMD_START_CHAN:
-		cmd_tre->ptr = MHI_TRE_CMD_START_PTR;
-		cmd_tre->dword[0] = MHI_TRE_CMD_START_DWORD0;
-		cmd_tre->dword[1] = MHI_TRE_CMD_START_DWORD1(chan);
-		break;
-	default:
-		dev_err(dev, "Command not supported\n");
-		break;
-	}
-
-	/* queue to hardware */
-	mhi_add_ring_element(mhi_cntrl, ring);
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
-		mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-	spin_unlock_bh(&mhi_cmd->lock);
-
-	return 0;
-}
-
-static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
-				    struct mhi_chan *mhi_chan,
-				    enum mhi_ch_state_type to_state)
-{
-	struct device *dev = &mhi_chan->mhi_dev->dev;
-	enum mhi_cmd_type cmd = MHI_CMD_NOP;
-	int ret;
-
-	dev_dbg(dev, "%d: Updating channel state to: %s\n", mhi_chan->chan,
-		TO_CH_STATE_TYPE_STR(to_state));
-
-	switch (to_state) {
-	case MHI_CH_STATE_TYPE_RESET:
-		write_lock_irq(&mhi_chan->lock);
-		if (mhi_chan->ch_state != MHI_CH_STATE_STOP &&
-		    mhi_chan->ch_state != MHI_CH_STATE_ENABLED &&
-		    mhi_chan->ch_state != MHI_CH_STATE_SUSPENDED) {
-			write_unlock_irq(&mhi_chan->lock);
-			return -EINVAL;
-		}
-		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
-		write_unlock_irq(&mhi_chan->lock);
-
-		cmd = MHI_CMD_RESET_CHAN;
-		break;
-	case MHI_CH_STATE_TYPE_STOP:
-		if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
-			return -EINVAL;
-
-		cmd = MHI_CMD_STOP_CHAN;
-		break;
-	case MHI_CH_STATE_TYPE_START:
-		if (mhi_chan->ch_state != MHI_CH_STATE_STOP &&
-		    mhi_chan->ch_state != MHI_CH_STATE_DISABLED)
-			return -EINVAL;
-
-		cmd = MHI_CMD_START_CHAN;
-		break;
-	default:
-		dev_err(dev, "%d: Channel state update to %s not allowed\n",
-			mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
-		return -EINVAL;
-	}
-
-	/* bring host and device out of suspended states */
-	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
-	if (ret)
-		return ret;
-	mhi_cntrl->runtime_get(mhi_cntrl);
-
-	reinit_completion(&mhi_chan->completion);
-	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, cmd);
-	if (ret) {
-		dev_err(dev, "%d: Failed to send %s channel command\n",
-			mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
-		goto exit_channel_update;
-	}
-
-	ret = wait_for_completion_timeout(&mhi_chan->completion,
-				       msecs_to_jiffies(mhi_cntrl->timeout_ms));
-	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS) {
-		dev_err(dev,
-			"%d: Failed to receive %s channel command completion\n",
-			mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
-		ret = -EIO;
-		goto exit_channel_update;
-	}
-
-	ret = 0;
-
-	if (to_state != MHI_CH_STATE_TYPE_RESET) {
-		write_lock_irq(&mhi_chan->lock);
-		mhi_chan->ch_state = (to_state == MHI_CH_STATE_TYPE_START) ?
-				      MHI_CH_STATE_ENABLED : MHI_CH_STATE_STOP;
-		write_unlock_irq(&mhi_chan->lock);
-	}
-
-	dev_dbg(dev, "%d: Channel state change to %s successful\n",
-		mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
-
-exit_channel_update:
-	mhi_cntrl->runtime_put(mhi_cntrl);
-	mhi_device_put(mhi_cntrl->mhi_dev);
-
-	return ret;
-}
-
-static void mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
-				  struct mhi_chan *mhi_chan)
-{
-	int ret;
-	struct device *dev = &mhi_chan->mhi_dev->dev;
-
-	mutex_lock(&mhi_chan->mutex);
-
-	if (!(BIT(mhi_cntrl->ee) & mhi_chan->ee_mask)) {
-		dev_dbg(dev, "Current EE: %s Required EE Mask: 0x%x\n",
-			TO_MHI_EXEC_STR(mhi_cntrl->ee), mhi_chan->ee_mask);
-		goto exit_unprepare_channel;
-	}
-
-	/* no more processing events for this channel */
-	ret = mhi_update_channel_state(mhi_cntrl, mhi_chan,
-				       MHI_CH_STATE_TYPE_RESET);
-	if (ret)
-		dev_err(dev, "%d: Failed to reset channel, still resetting\n",
-			mhi_chan->chan);
-
-exit_unprepare_channel:
-	write_lock_irq(&mhi_chan->lock);
-	mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
-	write_unlock_irq(&mhi_chan->lock);
-
-	if (!mhi_chan->offload_ch) {
-		mhi_reset_chan(mhi_cntrl, mhi_chan);
-		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
-	}
-	dev_dbg(dev, "%d: successfully reset\n", mhi_chan->chan);
-
-	mutex_unlock(&mhi_chan->mutex);
-}
-
-int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
-			struct mhi_chan *mhi_chan)
-{
-	int ret = 0;
-	struct device *dev = &mhi_chan->mhi_dev->dev;
-
-	if (!(BIT(mhi_cntrl->ee) & mhi_chan->ee_mask)) {
-		dev_err(dev, "Current EE: %s Required EE Mask: 0x%x\n",
-			TO_MHI_EXEC_STR(mhi_cntrl->ee), mhi_chan->ee_mask);
-		return -ENOTCONN;
-	}
-
-	mutex_lock(&mhi_chan->mutex);
-
-	/* Check of client manages channel context for offload channels */
-	if (!mhi_chan->offload_ch) {
-		ret = mhi_init_chan_ctxt(mhi_cntrl, mhi_chan);
-		if (ret)
-			goto error_init_chan;
-	}
-
-	ret = mhi_update_channel_state(mhi_cntrl, mhi_chan,
-				       MHI_CH_STATE_TYPE_START);
-	if (ret)
-		goto error_pm_state;
-
-	/* Pre-allocate buffer for xfer ring */
-	if (mhi_chan->pre_alloc) {
-		int nr_el = get_nr_avail_ring_elements(mhi_cntrl,
-						       &mhi_chan->tre_ring);
-		size_t len = mhi_cntrl->buffer_len;
-
-		while (nr_el--) {
-			void *buf;
-			struct mhi_buf_info info = { };
-			buf = kmalloc(len, GFP_KERNEL);
-			if (!buf) {
-				ret = -ENOMEM;
-				goto error_pre_alloc;
-			}
-
-			/* Prepare transfer descriptors */
-			info.v_addr = buf;
-			info.cb_buf = buf;
-			info.len = len;
-			ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &info, MHI_EOT);
-			if (ret) {
-				kfree(buf);
-				goto error_pre_alloc;
-			}
-		}
-
-		read_lock_bh(&mhi_cntrl->pm_lock);
-		if (MHI_DB_ACCESS_VALID(mhi_cntrl)) {
-			read_lock_irq(&mhi_chan->lock);
-			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-			read_unlock_irq(&mhi_chan->lock);
-		}
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-	}
-
-	mutex_unlock(&mhi_chan->mutex);
-
-	return 0;
-
-error_pm_state:
-	if (!mhi_chan->offload_ch)
-		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
-
-error_init_chan:
-	mutex_unlock(&mhi_chan->mutex);
-
-	return ret;
-
-error_pre_alloc:
-	mutex_unlock(&mhi_chan->mutex);
-	mhi_unprepare_channel(mhi_cntrl, mhi_chan);
-
-	return ret;
-}
-
-static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
-				  struct mhi_event *mhi_event,
-				  struct mhi_event_ctxt *er_ctxt,
-				  int chan)
-
-{
-	struct mhi_tre *dev_rp, *local_rp;
-	struct mhi_ring *ev_ring;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	unsigned long flags;
-	dma_addr_t ptr;
-
-	dev_dbg(dev, "Marking all events for chan: %d as stale\n", chan);
-
-	ev_ring = &mhi_event->ring;
-
-	/* mark all stale events related to channel as STALE event */
-	spin_lock_irqsave(&mhi_event->lock, flags);
-
-	ptr = le64_to_cpu(er_ctxt->rp);
-	if (!is_valid_ring_ptr(ev_ring, ptr)) {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Event ring rp points outside of the event ring\n");
-		dev_rp = ev_ring->rp;
-	} else {
-		dev_rp = mhi_to_virtual(ev_ring, ptr);
-	}
-
-	local_rp = ev_ring->rp;
-	while (dev_rp != local_rp) {
-		if (MHI_TRE_GET_EV_TYPE(local_rp) == MHI_PKT_TYPE_TX_EVENT &&
-		    chan == MHI_TRE_GET_EV_CHID(local_rp))
-			local_rp->dword[1] = MHI_TRE_EV_DWORD1(chan,
-					MHI_PKT_TYPE_STALE_EVENT);
-		local_rp++;
-		if (local_rp == (ev_ring->base + ev_ring->len))
-			local_rp = ev_ring->base;
-	}
-
-	dev_dbg(dev, "Finished marking events as stale events\n");
-	spin_unlock_irqrestore(&mhi_event->lock, flags);
-}
-
-static void mhi_reset_data_chan(struct mhi_controller *mhi_cntrl,
-				struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *buf_ring, *tre_ring;
-	struct mhi_result result;
-
-	/* Reset any pending buffers */
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-	result.transaction_status = -ENOTCONN;
-	result.bytes_xferd = 0;
-	while (tre_ring->rp != tre_ring->wp) {
-		struct mhi_buf_info *buf_info = buf_ring->rp;
-
-		if (mhi_chan->dir == DMA_TO_DEVICE) {
-			atomic_dec(&mhi_cntrl->pending_pkts);
-			/* Release the reference got from mhi_queue() */
-			mhi_cntrl->runtime_put(mhi_cntrl);
-		}
-
-		if (!buf_info->pre_mapped)
-			mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
-
-		mhi_del_ring_element(mhi_cntrl, buf_ring);
-		mhi_del_ring_element(mhi_cntrl, tre_ring);
-
-		if (mhi_chan->pre_alloc) {
-			kfree(buf_info->cb_buf);
-		} else {
-			result.buf_addr = buf_info->cb_buf;
-			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
-		}
-	}
-}
-
-void mhi_reset_chan(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan)
-{
-	struct mhi_event *mhi_event;
-	struct mhi_event_ctxt *er_ctxt;
-	int chan = mhi_chan->chan;
-
-	/* Nothing to reset, client doesn't queue buffers */
-	if (mhi_chan->offload_ch)
-		return;
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
-	er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_chan->er_index];
-
-	mhi_mark_stale_events(mhi_cntrl, mhi_event, er_ctxt, chan);
-
-	mhi_reset_data_chan(mhi_cntrl, mhi_chan);
-
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-}
-
-/* Move channel to start state */
-int mhi_prepare_for_transfer(struct mhi_device *mhi_dev)
-{
-	int ret, dir;
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan;
-
-	for (dir = 0; dir < 2; dir++) {
-		mhi_chan = dir ? mhi_dev->dl_chan : mhi_dev->ul_chan;
-		if (!mhi_chan)
-			continue;
-
-		ret = mhi_prepare_channel(mhi_cntrl, mhi_chan);
-		if (ret)
-			goto error_open_chan;
-	}
-
-	return 0;
-
-error_open_chan:
-	for (--dir; dir >= 0; dir--) {
-		mhi_chan = dir ? mhi_dev->dl_chan : mhi_dev->ul_chan;
-		if (!mhi_chan)
-			continue;
-
-		mhi_unprepare_channel(mhi_cntrl, mhi_chan);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer);
-
-void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan;
-	int dir;
-
-	for (dir = 0; dir < 2; dir++) {
-		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
-		if (!mhi_chan)
-			continue;
-
-		mhi_unprepare_channel(mhi_cntrl, mhi_chan);
-	}
-}
-EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
-
-int mhi_poll(struct mhi_device *mhi_dev, u32 budget)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan = mhi_dev->dl_chan;
-	struct mhi_event *mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
-	int ret;
-
-	spin_lock_bh(&mhi_event->lock);
-	ret = mhi_event->process_event(mhi_cntrl, mhi_event, budget);
-	spin_unlock_bh(&mhi_event->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_poll);
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
deleted file mode 100644
index 1a87b9c6c2f8..000000000000
--- a/drivers/bus/mhi/core/pm.c
+++ /dev/null
@@ -1,1261 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/mhi.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/wait.h>
-#include "internal.h"
-
-/*
- * Not all MHI state transitions are synchronous. Transitions like Linkdown,
- * SYS_ERR, and shutdown can happen anytime asynchronously. This function will
- * transition to a new state only if we're allowed to.
- *
- * Priority increases as we go down. For instance, from any state in L0, the
- * transition can be made to states in L1, L2 and L3. A notable exception to
- * this rule is state DISABLE.  From DISABLE state we can only transition to
- * POR state. Also, while in L2 state, user cannot jump back to previous
- * L1 or L0 states.
- *
- * Valid transitions:
- * L0: DISABLE <--> POR
- *     POR <--> POR
- *     POR -> M0 -> M2 --> M0
- *     POR -> FW_DL_ERR
- *     FW_DL_ERR <--> FW_DL_ERR
- *     M0 <--> M0
- *     M0 -> FW_DL_ERR
- *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
- * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
- * L2: SHUTDOWN_PROCESS -> LD_ERR_FATAL_DETECT
- *     SHUTDOWN_PROCESS -> DISABLE
- * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
- *     LD_ERR_FATAL_DETECT -> DISABLE
- */
-static struct mhi_pm_transitions const dev_state_transitions[] = {
-	/* L0 States */
-	{
-		MHI_PM_DISABLE,
-		MHI_PM_POR
-	},
-	{
-		MHI_PM_POR,
-		MHI_PM_POR | MHI_PM_DISABLE | MHI_PM_M0 |
-		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_FW_DL_ERR
-	},
-	{
-		MHI_PM_M0,
-		MHI_PM_M0 | MHI_PM_M2 | MHI_PM_M3_ENTER |
-		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_FW_DL_ERR
-	},
-	{
-		MHI_PM_M2,
-		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	{
-		MHI_PM_M3_ENTER,
-		MHI_PM_M3 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	{
-		MHI_PM_M3,
-		MHI_PM_M3_EXIT | MHI_PM_SYS_ERR_DETECT |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	{
-		MHI_PM_M3_EXIT,
-		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	{
-		MHI_PM_FW_DL_ERR,
-		MHI_PM_FW_DL_ERR | MHI_PM_SYS_ERR_DETECT |
-		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	/* L1 States */
-	{
-		MHI_PM_SYS_ERR_DETECT,
-		MHI_PM_SYS_ERR_PROCESS | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	{
-		MHI_PM_SYS_ERR_PROCESS,
-		MHI_PM_POR | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	/* L2 States */
-	{
-		MHI_PM_SHUTDOWN_PROCESS,
-		MHI_PM_DISABLE | MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	/* L3 States */
-	{
-		MHI_PM_LD_ERR_FATAL_DETECT,
-		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_DISABLE
-	},
-};
-
-enum mhi_pm_state __must_check mhi_tryset_pm_state(struct mhi_controller *mhi_cntrl,
-						   enum mhi_pm_state state)
-{
-	unsigned long cur_state = mhi_cntrl->pm_state;
-	int index = find_last_bit(&cur_state, 32);
-
-	if (unlikely(index >= ARRAY_SIZE(dev_state_transitions)))
-		return cur_state;
-
-	if (unlikely(dev_state_transitions[index].from_state != cur_state))
-		return cur_state;
-
-	if (unlikely(!(dev_state_transitions[index].to_states & state)))
-		return cur_state;
-
-	mhi_cntrl->pm_state = state;
-	return mhi_cntrl->pm_state;
-}
-
-void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum mhi_state state)
-{
-	if (state == MHI_STATE_RESET) {
-		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				    MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 1);
-	} else {
-		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				    MHICTRL_MHISTATE_MASK,
-				    MHICTRL_MHISTATE_SHIFT, state);
-	}
-}
-
-/* NOP for backward compatibility, host allowed to ring DB in M2 state */
-static void mhi_toggle_dev_wake_nop(struct mhi_controller *mhi_cntrl)
-{
-}
-
-static void mhi_toggle_dev_wake(struct mhi_controller *mhi_cntrl)
-{
-	mhi_cntrl->wake_get(mhi_cntrl, false);
-	mhi_cntrl->wake_put(mhi_cntrl, true);
-}
-
-/* Handle device ready state transition */
-int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_event *mhi_event;
-	enum mhi_pm_state cur_state;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 interval_us = 25000; /* poll register field every 25 milliseconds */
-	int ret, i;
-
-	/* Check if device entered error state */
-	if (MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev, "Device link is not accessible\n");
-		return -EIO;
-	}
-
-	/* Wait for RESET to be cleared and READY bit to be set by the device */
-	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
-				 interval_us);
-	if (ret) {
-		dev_err(dev, "Device failed to clear MHI Reset\n");
-		return ret;
-	}
-
-	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
-				 MHISTATUS_READY_MASK, MHISTATUS_READY_SHIFT, 1,
-				 interval_us);
-	if (ret) {
-		dev_err(dev, "Device failed to enter MHI Ready\n");
-		return ret;
-	}
-
-	dev_dbg(dev, "Device in READY State\n");
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_POR);
-	mhi_cntrl->dev_state = MHI_STATE_READY;
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	if (cur_state != MHI_PM_POR) {
-		dev_err(dev, "Error moving to state %s from %s\n",
-			to_mhi_pm_state_str(MHI_PM_POR),
-			to_mhi_pm_state_str(cur_state));
-		return -EIO;
-	}
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		dev_err(dev, "Device registers not accessible\n");
-		goto error_mmio;
-	}
-
-	/* Configure MMIO registers */
-	ret = mhi_init_mmio(mhi_cntrl);
-	if (ret) {
-		dev_err(dev, "Error configuring MMIO registers\n");
-		goto error_mmio;
-	}
-
-	/* Add elements to all SW event rings */
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		/* Skip if this is an offload or HW event */
-		if (mhi_event->offload_ev || mhi_event->hw_ring)
-			continue;
-
-		ring->wp = ring->base + ring->len - ring->el_size;
-		*ring->ctxt_wp = cpu_to_le64(ring->iommu_base + ring->len - ring->el_size);
-		/* Update all cores */
-		smp_wmb();
-
-		/* Ring the event ring db */
-		spin_lock_irq(&mhi_event->lock);
-		mhi_ring_er_db(mhi_event);
-		spin_unlock_irq(&mhi_event->lock);
-	}
-
-	/* Set MHI to M0 state */
-	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return 0;
-
-error_mmio:
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return -EIO;
-}
-
-int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
-{
-	enum mhi_pm_state cur_state;
-	struct mhi_chan *mhi_chan;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int i;
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	mhi_cntrl->dev_state = MHI_STATE_M0;
-	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M0);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-	if (unlikely(cur_state != MHI_PM_M0)) {
-		dev_err(dev, "Unable to transition to M0 state\n");
-		return -EIO;
-	}
-	mhi_cntrl->M0++;
-
-	/* Wake up the device */
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	mhi_cntrl->wake_get(mhi_cntrl, true);
-
-	/* Ring all event rings and CMD ring only if we're in mission mode */
-	if (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) {
-		struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-		struct mhi_cmd *mhi_cmd =
-			&mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
-
-		for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-			if (mhi_event->offload_ev)
-				continue;
-
-			spin_lock_irq(&mhi_event->lock);
-			mhi_ring_er_db(mhi_event);
-			spin_unlock_irq(&mhi_event->lock);
-		}
-
-		/* Only ring primary cmd ring if ring is not empty */
-		spin_lock_irq(&mhi_cmd->lock);
-		if (mhi_cmd->ring.rp != mhi_cmd->ring.wp)
-			mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
-		spin_unlock_irq(&mhi_cmd->lock);
-	}
-
-	/* Ring channel DB registers */
-	mhi_chan = mhi_cntrl->mhi_chan;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
-		struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
-
-		if (mhi_chan->db_cfg.reset_req) {
-			write_lock_irq(&mhi_chan->lock);
-			mhi_chan->db_cfg.db_mode = true;
-			write_unlock_irq(&mhi_chan->lock);
-		}
-
-		read_lock_irq(&mhi_chan->lock);
-
-		/* Only ring DB if ring is not empty */
-		if (tre_ring->base && tre_ring->wp  != tre_ring->rp &&
-		    mhi_chan->ch_state == MHI_CH_STATE_ENABLED)
-			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-		read_unlock_irq(&mhi_chan->lock);
-	}
-
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-	wake_up_all(&mhi_cntrl->state_event);
-
-	return 0;
-}
-
-/*
- * After receiving the MHI state change event from the device indicating the
- * transition to M1 state, the host can transition the device to M2 state
- * for keeping it in low power state.
- */
-void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl)
-{
-	enum mhi_pm_state state;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M2);
-	if (state == MHI_PM_M2) {
-		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M2);
-		mhi_cntrl->dev_state = MHI_STATE_M2;
-
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-
-		mhi_cntrl->M2++;
-		wake_up_all(&mhi_cntrl->state_event);
-
-		/* If there are any pending resources, exit M2 immediately */
-		if (unlikely(atomic_read(&mhi_cntrl->pending_pkts) ||
-			     atomic_read(&mhi_cntrl->dev_wake))) {
-			dev_dbg(dev,
-				"Exiting M2, pending_pkts: %d dev_wake: %d\n",
-				atomic_read(&mhi_cntrl->pending_pkts),
-				atomic_read(&mhi_cntrl->dev_wake));
-			read_lock_bh(&mhi_cntrl->pm_lock);
-			mhi_cntrl->wake_get(mhi_cntrl, true);
-			mhi_cntrl->wake_put(mhi_cntrl, true);
-			read_unlock_bh(&mhi_cntrl->pm_lock);
-		} else {
-			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_IDLE);
-		}
-	} else {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-	}
-}
-
-/* MHI M3 completion handler */
-int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl)
-{
-	enum mhi_pm_state state;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	mhi_cntrl->dev_state = MHI_STATE_M3;
-	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-	if (state != MHI_PM_M3) {
-		dev_err(dev, "Unable to transition to M3 state\n");
-		return -EIO;
-	}
-
-	mhi_cntrl->M3++;
-	wake_up_all(&mhi_cntrl->state_event);
-
-	return 0;
-}
-
-/* Handle device Mission Mode transition */
-static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_event *mhi_event;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	enum mhi_ee_type ee = MHI_EE_MAX, current_ee = mhi_cntrl->ee;
-	int i, ret;
-
-	dev_dbg(dev, "Processing Mission Mode transition\n");
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
-		ee = mhi_get_exec_env(mhi_cntrl);
-
-	if (!MHI_IN_MISSION_MODE(ee)) {
-		mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		wake_up_all(&mhi_cntrl->state_event);
-		return -EIO;
-	}
-	mhi_cntrl->ee = ee;
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	wake_up_all(&mhi_cntrl->state_event);
-
-	device_for_each_child(&mhi_cntrl->mhi_dev->dev, &current_ee,
-			      mhi_destroy_device);
-	mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_MISSION_MODE);
-
-	/* Force MHI to be in M0 state before continuing */
-	ret = __mhi_device_get_sync(mhi_cntrl);
-	if (ret)
-		return ret;
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		ret = -EIO;
-		goto error_mission_mode;
-	}
-
-	/* Add elements to all HW event rings */
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		if (mhi_event->offload_ev || !mhi_event->hw_ring)
-			continue;
-
-		ring->wp = ring->base + ring->len - ring->el_size;
-		*ring->ctxt_wp = cpu_to_le64(ring->iommu_base + ring->len - ring->el_size);
-		/* Update to all cores */
-		smp_wmb();
-
-		spin_lock_irq(&mhi_event->lock);
-		if (MHI_DB_ACCESS_VALID(mhi_cntrl))
-			mhi_ring_er_db(mhi_event);
-		spin_unlock_irq(&mhi_event->lock);
-	}
-
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	/*
-	 * The MHI devices are only created when the client device switches its
-	 * Execution Environment (EE) to either SBL or AMSS states
-	 */
-	mhi_create_devices(mhi_cntrl);
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-
-error_mission_mode:
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return ret;
-}
-
-/* Handle shutdown transitions */
-static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
-{
-	enum mhi_pm_state cur_state;
-	struct mhi_event *mhi_event;
-	struct mhi_cmd_ctxt *cmd_ctxt;
-	struct mhi_cmd *mhi_cmd;
-	struct mhi_event_ctxt *er_ctxt;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int ret, i;
-
-	dev_dbg(dev, "Processing disable transition with PM state: %s\n",
-		to_mhi_pm_state_str(mhi_cntrl->pm_state));
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-
-	/* Trigger MHI RESET so that the device will not access host memory */
-	if (!MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
-		dev_dbg(dev, "Triggering MHI Reset in device\n");
-		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
-
-		/* Wait for the reset bit to be cleared by the device */
-		ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
-				 25000);
-		if (ret)
-			dev_err(dev, "Device failed to clear MHI Reset\n");
-
-		/*
-		 * Device will clear BHI_INTVEC as a part of RESET processing,
-		 * hence re-program it
-		 */
-		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
-	}
-
-	dev_dbg(dev,
-		 "Waiting for all pending event ring processing to complete\n");
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
-		tasklet_kill(&mhi_event->task);
-	}
-
-	/* Release lock and wait for all pending threads to complete */
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-	dev_dbg(dev, "Waiting for all pending threads to complete\n");
-	wake_up_all(&mhi_cntrl->state_event);
-
-	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
-	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-
-	WARN_ON(atomic_read(&mhi_cntrl->dev_wake));
-	WARN_ON(atomic_read(&mhi_cntrl->pending_pkts));
-
-	/* Reset the ev rings and cmd rings */
-	dev_dbg(dev, "Resetting EV CTXT and CMD CTXT\n");
-	mhi_cmd = mhi_cntrl->mhi_cmd;
-	cmd_ctxt = mhi_cntrl->mhi_ctxt->cmd_ctxt;
-	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
-		struct mhi_ring *ring = &mhi_cmd->ring;
-
-		ring->rp = ring->base;
-		ring->wp = ring->base;
-		cmd_ctxt->rp = cmd_ctxt->rbase;
-		cmd_ctxt->wp = cmd_ctxt->rbase;
-	}
-
-	mhi_event = mhi_cntrl->mhi_event;
-	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
-		     mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		/* Skip offload events */
-		if (mhi_event->offload_ev)
-			continue;
-
-		ring->rp = ring->base;
-		ring->wp = ring->base;
-		er_ctxt->rp = er_ctxt->rbase;
-		er_ctxt->wp = er_ctxt->rbase;
-	}
-
-	/* Move to disable state */
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_DISABLE);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-	if (unlikely(cur_state != MHI_PM_DISABLE))
-		dev_err(dev, "Error moving from PM state: %s to: %s\n",
-			to_mhi_pm_state_str(cur_state),
-			to_mhi_pm_state_str(MHI_PM_DISABLE));
-
-	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
-		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
-
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-}
-
-/* Handle system error transitions */
-static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
-{
-	enum mhi_pm_state cur_state, prev_state;
-	enum dev_st_transition next_state;
-	struct mhi_event *mhi_event;
-	struct mhi_cmd_ctxt *cmd_ctxt;
-	struct mhi_cmd *mhi_cmd;
-	struct mhi_event_ctxt *er_ctxt;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int ret, i;
-
-	dev_dbg(dev, "Transitioning from PM state: %s to: %s\n",
-		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		to_mhi_pm_state_str(MHI_PM_SYS_ERR_PROCESS));
-
-	/* We must notify MHI control driver so it can clean up first */
-	mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_SYS_ERROR);
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	prev_state = mhi_cntrl->pm_state;
-	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_SYS_ERR_PROCESS);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	if (cur_state != MHI_PM_SYS_ERR_PROCESS) {
-		dev_err(dev, "Failed to transition from PM state: %s to: %s\n",
-			to_mhi_pm_state_str(cur_state),
-			to_mhi_pm_state_str(MHI_PM_SYS_ERR_PROCESS));
-		goto exit_sys_error_transition;
-	}
-
-	mhi_cntrl->ee = MHI_EE_DISABLE_TRANSITION;
-	mhi_cntrl->dev_state = MHI_STATE_RESET;
-
-	/* Wake up threads waiting for state transition */
-	wake_up_all(&mhi_cntrl->state_event);
-
-	/* Trigger MHI RESET so that the device will not access host memory */
-	if (MHI_REG_ACCESS_VALID(prev_state)) {
-		u32 in_reset = -1;
-		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
-
-		dev_dbg(dev, "Triggering MHI Reset in device\n");
-		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
-
-		/* Wait for the reset bit to be cleared by the device */
-		ret = wait_event_timeout(mhi_cntrl->state_event,
-					 mhi_read_reg_field(mhi_cntrl,
-							    mhi_cntrl->regs,
-							    MHICTRL,
-							    MHICTRL_RESET_MASK,
-							    MHICTRL_RESET_SHIFT,
-							    &in_reset) ||
-					!in_reset, timeout);
-		if (!ret || in_reset) {
-			dev_err(dev, "Device failed to exit MHI Reset state\n");
-			goto exit_sys_error_transition;
-		}
-
-		/*
-		 * Device will clear BHI_INTVEC as a part of RESET processing,
-		 * hence re-program it
-		 */
-		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
-	}
-
-	dev_dbg(dev,
-		"Waiting for all pending event ring processing to complete\n");
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-		tasklet_kill(&mhi_event->task);
-	}
-
-	/* Release lock and wait for all pending threads to complete */
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-	dev_dbg(dev, "Waiting for all pending threads to complete\n");
-	wake_up_all(&mhi_cntrl->state_event);
-
-	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
-	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-
-	WARN_ON(atomic_read(&mhi_cntrl->dev_wake));
-	WARN_ON(atomic_read(&mhi_cntrl->pending_pkts));
-
-	/* Reset the ev rings and cmd rings */
-	dev_dbg(dev, "Resetting EV CTXT and CMD CTXT\n");
-	mhi_cmd = mhi_cntrl->mhi_cmd;
-	cmd_ctxt = mhi_cntrl->mhi_ctxt->cmd_ctxt;
-	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
-		struct mhi_ring *ring = &mhi_cmd->ring;
-
-		ring->rp = ring->base;
-		ring->wp = ring->base;
-		cmd_ctxt->rp = cmd_ctxt->rbase;
-		cmd_ctxt->wp = cmd_ctxt->rbase;
-	}
-
-	mhi_event = mhi_cntrl->mhi_event;
-	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
-	     mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		/* Skip offload events */
-		if (mhi_event->offload_ev)
-			continue;
-
-		ring->rp = ring->base;
-		ring->wp = ring->base;
-		er_ctxt->rp = er_ctxt->rbase;
-		er_ctxt->wp = er_ctxt->rbase;
-	}
-
-	/* Transition to next state */
-	if (MHI_IN_PBL(mhi_get_exec_env(mhi_cntrl))) {
-		write_lock_irq(&mhi_cntrl->pm_lock);
-		cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_POR);
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		if (cur_state != MHI_PM_POR) {
-			dev_err(dev, "Error moving to state %s from %s\n",
-				to_mhi_pm_state_str(MHI_PM_POR),
-				to_mhi_pm_state_str(cur_state));
-			goto exit_sys_error_transition;
-		}
-		next_state = DEV_ST_TRANSITION_PBL;
-	} else {
-		next_state = DEV_ST_TRANSITION_READY;
-	}
-
-	mhi_queue_state_transition(mhi_cntrl, next_state);
-
-exit_sys_error_transition:
-	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
-		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
-
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-}
-
-/* Queue a new work item and schedule work */
-int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
-			       enum dev_st_transition state)
-{
-	struct state_transition *item = kmalloc(sizeof(*item), GFP_ATOMIC);
-	unsigned long flags;
-
-	if (!item)
-		return -ENOMEM;
-
-	item->state = state;
-	spin_lock_irqsave(&mhi_cntrl->transition_lock, flags);
-	list_add_tail(&item->node, &mhi_cntrl->transition_list);
-	spin_unlock_irqrestore(&mhi_cntrl->transition_lock, flags);
-
-	queue_work(mhi_cntrl->hiprio_wq, &mhi_cntrl->st_worker);
-
-	return 0;
-}
-
-/* SYS_ERR worker */
-void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl)
-{
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	/* skip if controller supports RDDM */
-	if (mhi_cntrl->rddm_image) {
-		dev_dbg(dev, "Controller supports RDDM, skip SYS_ERROR\n");
-		return;
-	}
-
-	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_SYS_ERR);
-}
-
-/* Device State Transition worker */
-void mhi_pm_st_worker(struct work_struct *work)
-{
-	struct state_transition *itr, *tmp;
-	LIST_HEAD(head);
-	struct mhi_controller *mhi_cntrl = container_of(work,
-							struct mhi_controller,
-							st_worker);
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	spin_lock_irq(&mhi_cntrl->transition_lock);
-	list_splice_tail_init(&mhi_cntrl->transition_list, &head);
-	spin_unlock_irq(&mhi_cntrl->transition_lock);
-
-	list_for_each_entry_safe(itr, tmp, &head, node) {
-		list_del(&itr->node);
-		dev_dbg(dev, "Handling state transition: %s\n",
-			TO_DEV_STATE_TRANS_STR(itr->state));
-
-		switch (itr->state) {
-		case DEV_ST_TRANSITION_PBL:
-			write_lock_irq(&mhi_cntrl->pm_lock);
-			if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
-				mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
-			write_unlock_irq(&mhi_cntrl->pm_lock);
-			mhi_fw_load_handler(mhi_cntrl);
-			break;
-		case DEV_ST_TRANSITION_SBL:
-			write_lock_irq(&mhi_cntrl->pm_lock);
-			mhi_cntrl->ee = MHI_EE_SBL;
-			write_unlock_irq(&mhi_cntrl->pm_lock);
-			/*
-			 * The MHI devices are only created when the client
-			 * device switches its Execution Environment (EE) to
-			 * either SBL or AMSS states
-			 */
-			mhi_create_devices(mhi_cntrl);
-			if (mhi_cntrl->fbc_download)
-				mhi_download_amss_image(mhi_cntrl);
-			break;
-		case DEV_ST_TRANSITION_MISSION_MODE:
-			mhi_pm_mission_mode_transition(mhi_cntrl);
-			break;
-		case DEV_ST_TRANSITION_FP:
-			write_lock_irq(&mhi_cntrl->pm_lock);
-			mhi_cntrl->ee = MHI_EE_FP;
-			write_unlock_irq(&mhi_cntrl->pm_lock);
-			mhi_create_devices(mhi_cntrl);
-			break;
-		case DEV_ST_TRANSITION_READY:
-			mhi_ready_state_transition(mhi_cntrl);
-			break;
-		case DEV_ST_TRANSITION_SYS_ERR:
-			mhi_pm_sys_error_transition(mhi_cntrl);
-			break;
-		case DEV_ST_TRANSITION_DISABLE:
-			mhi_pm_disable_transition(mhi_cntrl);
-			break;
-		default:
-			break;
-		}
-		kfree(itr);
-	}
-}
-
-int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_chan *itr, *tmp;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	enum mhi_pm_state new_state;
-	int ret;
-
-	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
-		return -EINVAL;
-
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
-		return -EIO;
-
-	/* Return busy if there are any pending resources */
-	if (atomic_read(&mhi_cntrl->dev_wake) ||
-	    atomic_read(&mhi_cntrl->pending_pkts))
-		return -EBUSY;
-
-	/* Take MHI out of M2 state */
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	mhi_cntrl->wake_get(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
-				 mhi_cntrl->dev_state == MHI_STATE_M1 ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev,
-			"Could not enter M0/M1 state");
-		return -EIO;
-	}
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-
-	if (atomic_read(&mhi_cntrl->dev_wake) ||
-	    atomic_read(&mhi_cntrl->pending_pkts)) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		return -EBUSY;
-	}
-
-	dev_dbg(dev, "Allowing M3 transition\n");
-	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_ENTER);
-	if (new_state != MHI_PM_M3_ENTER) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		dev_err(dev,
-			"Error setting to PM state: %s from: %s\n",
-			to_mhi_pm_state_str(MHI_PM_M3_ENTER),
-			to_mhi_pm_state_str(mhi_cntrl->pm_state));
-		return -EIO;
-	}
-
-	/* Set MHI to M3 and wait for completion */
-	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-	dev_dbg(dev, "Waiting for M3 completion\n");
-
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->dev_state == MHI_STATE_M3 ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev,
-			"Did not enter M3 state, MHI state: %s, PM state: %s\n",
-			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-			to_mhi_pm_state_str(mhi_cntrl->pm_state));
-		return -EIO;
-	}
-
-	/* Notify clients about entering LPM */
-	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
-		mutex_lock(&itr->mutex);
-		if (itr->mhi_dev)
-			mhi_notify(itr->mhi_dev, MHI_CB_LPM_ENTER);
-		mutex_unlock(&itr->mutex);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mhi_pm_suspend);
-
-static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
-{
-	struct mhi_chan *itr, *tmp;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	enum mhi_pm_state cur_state;
-	int ret;
-
-	dev_dbg(dev, "Entered with PM state: %s, MHI state: %s\n",
-		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
-
-	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
-		return 0;
-
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
-		return -EIO;
-
-	if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3) {
-		dev_warn(dev, "Resuming from non M3 state (%s)\n",
-			 TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
-		if (!force)
-			return -EINVAL;
-	}
-
-	/* Notify clients about exiting LPM */
-	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
-		mutex_lock(&itr->mutex);
-		if (itr->mhi_dev)
-			mhi_notify(itr->mhi_dev, MHI_CB_LPM_EXIT);
-		mutex_unlock(&itr->mutex);
-	}
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_EXIT);
-	if (cur_state != MHI_PM_M3_EXIT) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		dev_info(dev,
-			 "Error setting to PM state: %s from: %s\n",
-			 to_mhi_pm_state_str(MHI_PM_M3_EXIT),
-			 to_mhi_pm_state_str(mhi_cntrl->pm_state));
-		return -EIO;
-	}
-
-	/* Set MHI to M0 and wait for completion */
-	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
-				 mhi_cntrl->dev_state == MHI_STATE_M2 ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev,
-			"Did not enter M0 state, MHI state: %s, PM state: %s\n",
-			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-			to_mhi_pm_state_str(mhi_cntrl->pm_state));
-		return -EIO;
-	}
-
-	return 0;
-}
-
-int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
-{
-	return __mhi_pm_resume(mhi_cntrl, false);
-}
-EXPORT_SYMBOL_GPL(mhi_pm_resume);
-
-int mhi_pm_resume_force(struct mhi_controller *mhi_cntrl)
-{
-	return __mhi_pm_resume(mhi_cntrl, true);
-}
-EXPORT_SYMBOL_GPL(mhi_pm_resume_force);
-
-int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
-{
-	int ret;
-
-	/* Wake up the device */
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-		return -EIO;
-	}
-	mhi_cntrl->wake_get(mhi_cntrl, true);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->pm_state == MHI_PM_M0 ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		read_lock_bh(&mhi_cntrl->pm_lock);
-		mhi_cntrl->wake_put(mhi_cntrl, false);
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/* Assert device wake db */
-static void mhi_assert_dev_wake(struct mhi_controller *mhi_cntrl, bool force)
-{
-	unsigned long flags;
-
-	/*
-	 * If force flag is set, then increment the wake count value and
-	 * ring wake db
-	 */
-	if (unlikely(force)) {
-		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
-		atomic_inc(&mhi_cntrl->dev_wake);
-		if (MHI_WAKE_DB_FORCE_SET_VALID(mhi_cntrl->pm_state) &&
-		    !mhi_cntrl->wake_set) {
-			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
-			mhi_cntrl->wake_set = true;
-		}
-		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
-	} else {
-		/*
-		 * If resources are already requested, then just increment
-		 * the wake count value and return
-		 */
-		if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, 1, 0)))
-			return;
-
-		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
-		if ((atomic_inc_return(&mhi_cntrl->dev_wake) == 1) &&
-		    MHI_WAKE_DB_SET_VALID(mhi_cntrl->pm_state) &&
-		    !mhi_cntrl->wake_set) {
-			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
-			mhi_cntrl->wake_set = true;
-		}
-		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
-	}
-}
-
-/* De-assert device wake db */
-static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
-				  bool override)
-{
-	unsigned long flags;
-
-	/*
-	 * Only continue if there is a single resource, else just decrement
-	 * and return
-	 */
-	if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, -1, 1)))
-		return;
-
-	spin_lock_irqsave(&mhi_cntrl->wlock, flags);
-	if ((atomic_dec_return(&mhi_cntrl->dev_wake) == 0) &&
-	    MHI_WAKE_DB_CLEAR_VALID(mhi_cntrl->pm_state) && !override &&
-	    mhi_cntrl->wake_set) {
-		mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 0);
-		mhi_cntrl->wake_set = false;
-	}
-	spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
-}
-
-int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
-{
-	enum mhi_state state;
-	enum mhi_ee_type current_ee;
-	enum dev_st_transition next_state;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 interval_us = 25000; /* poll register field every 25 milliseconds */
-	int ret;
-
-	dev_info(dev, "Requested to power ON\n");
-
-	/* Supply default wake routines if not provided by controller driver */
-	if (!mhi_cntrl->wake_get || !mhi_cntrl->wake_put ||
-	    !mhi_cntrl->wake_toggle) {
-		mhi_cntrl->wake_get = mhi_assert_dev_wake;
-		mhi_cntrl->wake_put = mhi_deassert_dev_wake;
-		mhi_cntrl->wake_toggle = (mhi_cntrl->db_access & MHI_PM_M2) ?
-			mhi_toggle_dev_wake_nop : mhi_toggle_dev_wake;
-	}
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-	mhi_cntrl->pm_state = MHI_PM_DISABLE;
-
-	/* Setup BHI INTVEC */
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
-	mhi_cntrl->pm_state = MHI_PM_POR;
-	mhi_cntrl->ee = MHI_EE_MAX;
-	current_ee = mhi_get_exec_env(mhi_cntrl);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	/* Confirm that the device is in valid exec env */
-	if (!MHI_IN_PBL(current_ee) && current_ee != MHI_EE_AMSS) {
-		dev_err(dev, "%s is not a valid EE for power on\n",
-			TO_MHI_EXEC_STR(current_ee));
-		ret = -EIO;
-		goto error_exit;
-	}
-
-	state = mhi_get_mhi_state(mhi_cntrl);
-	dev_dbg(dev, "Attempting power on with EE: %s, state: %s\n",
-		TO_MHI_EXEC_STR(current_ee), TO_MHI_STATE_STR(state));
-
-	if (state == MHI_STATE_SYS_ERR) {
-		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
-		ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
-				 interval_us);
-		if (ret) {
-			dev_info(dev, "Failed to reset MHI due to syserr state\n");
-			goto error_exit;
-		}
-
-		/*
-		 * device cleares INTVEC as part of RESET processing,
-		 * re-program it
-		 */
-		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
-	}
-
-	ret = mhi_init_irq_setup(mhi_cntrl);
-	if (ret)
-		goto error_exit;
-
-	/* Transition to next state */
-	next_state = MHI_IN_PBL(current_ee) ?
-		DEV_ST_TRANSITION_PBL : DEV_ST_TRANSITION_READY;
-
-	mhi_queue_state_transition(mhi_cntrl, next_state);
-
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-
-	dev_info(dev, "Power on setup success\n");
-
-	return 0;
-
-error_exit:
-	mhi_cntrl->pm_state = MHI_PM_DISABLE;
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_async_power_up);
-
-void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
-{
-	enum mhi_pm_state cur_state, transition_state;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	cur_state = mhi_cntrl->pm_state;
-	if (cur_state == MHI_PM_DISABLE) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		mutex_unlock(&mhi_cntrl->pm_mutex);
-		return; /* Already powered down */
-	}
-
-	/* If it's not a graceful shutdown, force MHI to linkdown state */
-	transition_state = (graceful) ? MHI_PM_SHUTDOWN_PROCESS :
-			   MHI_PM_LD_ERR_FATAL_DETECT;
-
-	cur_state = mhi_tryset_pm_state(mhi_cntrl, transition_state);
-	if (cur_state != transition_state) {
-		dev_err(dev, "Failed to move to state: %s from: %s\n",
-			to_mhi_pm_state_str(transition_state),
-			to_mhi_pm_state_str(mhi_cntrl->pm_state));
-		/* Force link down or error fatal detected state */
-		mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
-	}
-
-	/* mark device inactive to avoid any further host processing */
-	mhi_cntrl->ee = MHI_EE_DISABLE_TRANSITION;
-	mhi_cntrl->dev_state = MHI_STATE_RESET;
-
-	wake_up_all(&mhi_cntrl->state_event);
-
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-
-	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
-
-	/* Wait for shutdown to complete */
-	flush_work(&mhi_cntrl->st_worker);
-
-	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
-}
-EXPORT_SYMBOL_GPL(mhi_power_down);
-
-int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
-{
-	int ret = mhi_async_power_up(mhi_cntrl);
-
-	if (ret)
-		return ret;
-
-	wait_event_timeout(mhi_cntrl->state_event,
-			   MHI_IN_MISSION_MODE(mhi_cntrl->ee) ||
-			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
-	if (ret)
-		mhi_power_down(mhi_cntrl, false);
-
-	return ret;
-}
-EXPORT_SYMBOL(mhi_sync_power_up);
-
-int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl)
-{
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int ret;
-
-	/* Check if device is already in RDDM */
-	if (mhi_cntrl->ee == MHI_EE_RDDM)
-		return 0;
-
-	dev_dbg(dev, "Triggering SYS_ERR to force RDDM state\n");
-	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
-
-	/* Wait for RDDM event */
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->ee == MHI_EE_RDDM,
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-	ret = ret ? 0 : -EIO;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_force_rddm_mode);
-
-void mhi_device_get(struct mhi_device *mhi_dev)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-
-	mhi_dev->dev_wake++;
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
-
-	mhi_cntrl->wake_get(mhi_cntrl, true);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-}
-EXPORT_SYMBOL_GPL(mhi_device_get);
-
-int mhi_device_get_sync(struct mhi_device *mhi_dev)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	int ret;
-
-	ret = __mhi_device_get_sync(mhi_cntrl);
-	if (!ret)
-		mhi_dev->dev_wake++;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_device_get_sync);
-
-void mhi_device_put(struct mhi_device *mhi_dev)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-
-	mhi_dev->dev_wake--;
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
-
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-}
-EXPORT_SYMBOL_GPL(mhi_device_put);
diff --git a/drivers/bus/mhi/host/Kconfig b/drivers/bus/mhi/host/Kconfig
new file mode 100644
index 000000000000..da5cd0c9fc62
--- /dev/null
+++ b/drivers/bus/mhi/host/Kconfig
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# MHI bus
+#
+# Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+#
+
+config MHI_BUS
+	tristate "Modem Host Interface (MHI) bus"
+	help
+	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
+	  communication protocol used by the host processors to control
+	  and communicate with modem devices over a high speed peripheral
+	  bus or shared memory.
+
+config MHI_BUS_DEBUG
+	bool "Debugfs support for the MHI bus"
+	depends on MHI_BUS && DEBUG_FS
+	help
+	  Enable debugfs support for use with the MHI transport. Allows
+	  reading and/or modifying some values within the MHI controller
+	  for debug and test purposes.
+
+config MHI_BUS_PCI_GENERIC
+	tristate "MHI PCI controller driver"
+	depends on MHI_BUS
+	depends on PCI
+	help
+	  This driver provides MHI PCI controller driver for devices such as
+	  Qualcomm SDX55 based PCIe modems.
+
diff --git a/drivers/bus/mhi/host/Makefile b/drivers/bus/mhi/host/Makefile
new file mode 100644
index 000000000000..859c2f38451c
--- /dev/null
+++ b/drivers/bus/mhi/host/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_MHI_BUS) += mhi.o
+mhi-y := init.o main.o pm.o boot.o
+mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
+
+obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
+mhi_pci_generic-y += pci_generic.o
diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
new file mode 100644
index 000000000000..c9dfb1a48ad6
--- /dev/null
+++ b/drivers/bus/mhi/host/boot.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include "internal.h"
+
+/* Setup RDDM vector table for RDDM transfer and program RXVEC */
+void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
+		      struct image_info *img_info)
+{
+	struct mhi_buf *mhi_buf = img_info->mhi_buf;
+	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
+	void __iomem *base = mhi_cntrl->bhie;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 sequence_id;
+	unsigned int i;
+
+	for (i = 0; i < img_info->entries - 1; i++, mhi_buf++, bhi_vec++) {
+		bhi_vec->dma_addr = mhi_buf->dma_addr;
+		bhi_vec->size = mhi_buf->len;
+	}
+
+	dev_dbg(dev, "BHIe programming for RDDM\n");
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
+	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_RXVECSTATUS_SEQNUM_BMSK);
+
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
+			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
+			    sequence_id);
+
+	dev_dbg(dev, "Address: %p and len: 0x%zx sequence: %u\n",
+		&mhi_buf->dma_addr, mhi_buf->len, sequence_id);
+}
+
+/* Collect RDDM buffer during kernel panic */
+static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	u32 rx_status;
+	enum mhi_ee_type ee;
+	const u32 delayus = 2000;
+	u32 retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
+	const u32 rddm_timeout_us = 200000;
+	int rddm_retry = rddm_timeout_us / delayus;
+	void __iomem *base = mhi_cntrl->bhie;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	dev_dbg(dev, "Entered with pm_state:%s dev_state:%s ee:%s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	/*
+	 * This should only be executing during a kernel panic, we expect all
+	 * other cores to shutdown while we're collecting RDDM buffer. After
+	 * returning from this function, we expect the device to reset.
+	 *
+	 * Normaly, we read/write pm_state only after grabbing the
+	 * pm_lock, since we're in a panic, skipping it. Also there is no
+	 * gurantee that this state change would take effect since
+	 * we're setting it w/o grabbing pm_lock
+	 */
+	mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
+	/* update should take the effect immediately */
+	smp_wmb();
+
+	/*
+	 * Make sure device is not already in RDDM. In case the device asserts
+	 * and a kernel panic follows, device will already be in RDDM.
+	 * Do not trigger SYS ERR again and proceed with waiting for
+	 * image download completion.
+	 */
+	ee = mhi_get_exec_env(mhi_cntrl);
+	if (ee == MHI_EE_MAX)
+		goto error_exit_rddm;
+
+	if (ee != MHI_EE_RDDM) {
+		dev_dbg(dev, "Trigger device into RDDM mode using SYS ERR\n");
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
+
+		dev_dbg(dev, "Waiting for device to enter RDDM\n");
+		while (rddm_retry--) {
+			ee = mhi_get_exec_env(mhi_cntrl);
+			if (ee == MHI_EE_RDDM)
+				break;
+
+			udelay(delayus);
+		}
+
+		if (rddm_retry <= 0) {
+			/* Hardware reset so force device to enter RDDM */
+			dev_dbg(dev,
+				"Did not enter RDDM, do a host req reset\n");
+			mhi_write_reg(mhi_cntrl, mhi_cntrl->regs,
+				      MHI_SOC_RESET_REQ_OFFSET,
+				      MHI_SOC_RESET_REQ);
+			udelay(delayus);
+		}
+
+		ee = mhi_get_exec_env(mhi_cntrl);
+	}
+
+	dev_dbg(dev,
+		"Waiting for RDDM image download via BHIe, current EE:%s\n",
+		TO_MHI_EXEC_STR(ee));
+
+	while (retry--) {
+		ret = mhi_read_reg_field(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS,
+					 BHIE_RXVECSTATUS_STATUS_BMSK,
+					 BHIE_RXVECSTATUS_STATUS_SHFT,
+					 &rx_status);
+		if (ret)
+			return -EIO;
+
+		if (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL)
+			return 0;
+
+		udelay(delayus);
+	}
+
+	ee = mhi_get_exec_env(mhi_cntrl);
+	ret = mhi_read_reg(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS, &rx_status);
+
+	dev_err(dev, "RXVEC_STATUS: 0x%x\n", rx_status);
+
+error_exit_rddm:
+	dev_err(dev, "RDDM transfer failed. Current EE: %s\n",
+		TO_MHI_EXEC_STR(ee));
+
+	return -EIO;
+}
+
+/* Download RDDM image from device */
+int mhi_download_rddm_image(struct mhi_controller *mhi_cntrl, bool in_panic)
+{
+	void __iomem *base = mhi_cntrl->bhie;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 rx_status;
+
+	if (in_panic)
+		return __mhi_download_rddm_in_panic(mhi_cntrl);
+
+	dev_dbg(dev, "Waiting for RDDM image download via BHIe\n");
+
+	/* Wait for the image download to complete */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   mhi_read_reg_field(mhi_cntrl, base,
+					      BHIE_RXVECSTATUS_OFFS,
+					      BHIE_RXVECSTATUS_STATUS_BMSK,
+					      BHIE_RXVECSTATUS_STATUS_SHFT,
+					      &rx_status) || rx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	return (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
+}
+EXPORT_SYMBOL_GPL(mhi_download_rddm_image);
+
+static int mhi_fw_load_bhie(struct mhi_controller *mhi_cntrl,
+			    const struct mhi_buf *mhi_buf)
+{
+	void __iomem *base = mhi_cntrl->bhie;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	u32 tx_status, sequence_id;
+	int ret;
+
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		return -EIO;
+	}
+
+	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_TXVECSTATUS_SEQNUM_BMSK);
+	dev_dbg(dev, "Starting image download via BHIe. Sequence ID: %u\n",
+		sequence_id);
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
+
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
+			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
+			    sequence_id);
+	read_unlock_bh(pm_lock);
+
+	/* Wait for the image download to complete */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+				 mhi_read_reg_field(mhi_cntrl, base,
+						   BHIE_TXVECSTATUS_OFFS,
+						   BHIE_TXVECSTATUS_STATUS_BMSK,
+						   BHIE_TXVECSTATUS_STATUS_SHFT,
+						   &tx_status) || tx_status,
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+	    tx_status != BHIE_TXVECSTATUS_STATUS_XFER_COMPL)
+		return -EIO;
+
+	return (!ret) ? -ETIMEDOUT : 0;
+}
+
+static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
+			   dma_addr_t dma_addr,
+			   size_t size)
+{
+	u32 tx_status, val, session_id;
+	int i, ret;
+	void __iomem *base = mhi_cntrl->bhi;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct {
+		char *name;
+		u32 offset;
+	} error_reg[] = {
+		{ "ERROR_CODE", BHI_ERRCODE },
+		{ "ERROR_DBG1", BHI_ERRDBG1 },
+		{ "ERROR_DBG2", BHI_ERRDBG2 },
+		{ "ERROR_DBG3", BHI_ERRDBG3 },
+		{ NULL },
+	};
+
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		goto invalid_pm_state;
+	}
+
+	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
+	dev_dbg(dev, "Starting image download via BHI. Session ID: %u\n",
+		session_id);
+	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
+		      upper_32_bits(dma_addr));
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
+		      lower_32_bits(dma_addr));
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
+	read_unlock_bh(pm_lock);
+
+	/* Wait for the image download to complete */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base, BHI_STATUS,
+					      BHI_STATUS_MASK, BHI_STATUS_SHIFT,
+					      &tx_status) || tx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		goto invalid_pm_state;
+
+	if (tx_status == BHI_STATUS_ERROR) {
+		dev_err(dev, "Image transfer failed\n");
+		read_lock_bh(pm_lock);
+		if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+			for (i = 0; error_reg[i].name; i++) {
+				ret = mhi_read_reg(mhi_cntrl, base,
+						   error_reg[i].offset, &val);
+				if (ret)
+					break;
+				dev_err(dev, "Reg: %s value: 0x%x\n",
+					error_reg[i].name, val);
+			}
+		}
+		read_unlock_bh(pm_lock);
+		goto invalid_pm_state;
+	}
+
+	return (!ret) ? -ETIMEDOUT : 0;
+
+invalid_pm_state:
+
+	return -EIO;
+}
+
+void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info *image_info)
+{
+	int i;
+	struct mhi_buf *mhi_buf = image_info->mhi_buf;
+
+	for (i = 0; i < image_info->entries; i++, mhi_buf++)
+		dma_free_coherent(mhi_cntrl->cntrl_dev, mhi_buf->len,
+				  mhi_buf->buf, mhi_buf->dma_addr);
+
+	kfree(image_info->mhi_buf);
+	kfree(image_info);
+}
+
+int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info **image_info,
+			 size_t alloc_size)
+{
+	size_t seg_size = mhi_cntrl->seg_len;
+	int segments = DIV_ROUND_UP(alloc_size, seg_size) + 1;
+	int i;
+	struct image_info *img_info;
+	struct mhi_buf *mhi_buf;
+
+	img_info = kzalloc(sizeof(*img_info), GFP_KERNEL);
+	if (!img_info)
+		return -ENOMEM;
+
+	/* Allocate memory for entries */
+	img_info->mhi_buf = kcalloc(segments, sizeof(*img_info->mhi_buf),
+				    GFP_KERNEL);
+	if (!img_info->mhi_buf)
+		goto error_alloc_mhi_buf;
+
+	/* Allocate and populate vector table */
+	mhi_buf = img_info->mhi_buf;
+	for (i = 0; i < segments; i++, mhi_buf++) {
+		size_t vec_size = seg_size;
+
+		/* Vector table is the last entry */
+		if (i == segments - 1)
+			vec_size = sizeof(struct bhi_vec_entry) * i;
+
+		mhi_buf->len = vec_size;
+		mhi_buf->buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev,
+						  vec_size, &mhi_buf->dma_addr,
+						  GFP_KERNEL);
+		if (!mhi_buf->buf)
+			goto error_alloc_segment;
+	}
+
+	img_info->bhi_vec = img_info->mhi_buf[segments - 1].buf;
+	img_info->entries = segments;
+	*image_info = img_info;
+
+	return 0;
+
+error_alloc_segment:
+	for (--i, --mhi_buf; i >= 0; i--, mhi_buf--)
+		dma_free_coherent(mhi_cntrl->cntrl_dev, mhi_buf->len,
+				  mhi_buf->buf, mhi_buf->dma_addr);
+
+error_alloc_mhi_buf:
+	kfree(img_info);
+
+	return -ENOMEM;
+}
+
+static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
+			      const struct firmware *firmware,
+			      struct image_info *img_info)
+{
+	size_t remainder = firmware->size;
+	size_t to_cpy;
+	const u8 *buf = firmware->data;
+	struct mhi_buf *mhi_buf = img_info->mhi_buf;
+	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
+
+	while (remainder) {
+		to_cpy = min(remainder, mhi_buf->len);
+		memcpy(mhi_buf->buf, buf, to_cpy);
+		bhi_vec->dma_addr = mhi_buf->dma_addr;
+		bhi_vec->size = to_cpy;
+
+		buf += to_cpy;
+		remainder -= to_cpy;
+		bhi_vec++;
+		mhi_buf++;
+	}
+}
+
+void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
+{
+	const struct firmware *firmware = NULL;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
+	const char *fw_name;
+	void *buf;
+	dma_addr_t dma_addr;
+	size_t size;
+	int i, ret;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev, "Device MHI is not in valid state\n");
+		return;
+	}
+
+	/* save hardware info from BHI */
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_SERIALNU,
+			   &mhi_cntrl->serial_number);
+	if (ret)
+		dev_err(dev, "Could not capture serial number via BHI\n");
+
+	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++) {
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_OEMPKHASH(i),
+				   &mhi_cntrl->oem_pk_hash[i]);
+		if (ret) {
+			dev_err(dev, "Could not capture OEM PK HASH via BHI\n");
+			break;
+		}
+	}
+
+	/* wait for ready on pass through or any other execution environment */
+	if (mhi_cntrl->ee != MHI_EE_EDL && mhi_cntrl->ee != MHI_EE_PBL)
+		goto fw_load_ready_state;
+
+	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
+		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
+
+	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
+						     !mhi_cntrl->seg_len))) {
+		dev_err(dev,
+			"No firmware image defined or !sbl_size || !seg_len\n");
+		goto error_fw_load;
+	}
+
+	ret = request_firmware(&firmware, fw_name, dev);
+	if (ret) {
+		dev_err(dev, "Error loading firmware: %d\n", ret);
+		goto error_fw_load;
+	}
+
+	size = (mhi_cntrl->fbc_download) ? mhi_cntrl->sbl_size : firmware->size;
+
+	/* SBL size provided is maximum size, not necessarily the image size */
+	if (size > firmware->size)
+		size = firmware->size;
+
+	buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev, size, &dma_addr,
+				 GFP_KERNEL);
+	if (!buf) {
+		release_firmware(firmware);
+		goto error_fw_load;
+	}
+
+	/* Download image using BHI */
+	memcpy(buf, firmware->data, size);
+	ret = mhi_fw_load_bhi(mhi_cntrl, dma_addr, size);
+	dma_free_coherent(mhi_cntrl->cntrl_dev, size, buf, dma_addr);
+
+	/* Error or in EDL mode, we're done */
+	if (ret) {
+		dev_err(dev, "MHI did not load image over BHI, ret: %d\n", ret);
+		release_firmware(firmware);
+		goto error_fw_load;
+	}
+
+	/* Wait for ready since EDL image was loaded */
+	if (fw_name == mhi_cntrl->edl_image) {
+		release_firmware(firmware);
+		goto fw_load_ready_state;
+	}
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_RESET;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/*
+	 * If we're doing fbc, populate vector tables while
+	 * device transitioning into MHI READY state
+	 */
+	if (mhi_cntrl->fbc_download) {
+		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
+					   firmware->size);
+		if (ret) {
+			release_firmware(firmware);
+			goto error_fw_load;
+		}
+
+		/* Load the firmware into BHIE vec table */
+		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
+	}
+
+	release_firmware(firmware);
+
+fw_load_ready_state:
+	/* Transitioning into MHI RESET->READY state */
+	ret = mhi_ready_state_transition(mhi_cntrl);
+	if (ret) {
+		dev_err(dev, "MHI did not enter READY state\n");
+		goto error_ready_state;
+	}
+
+	dev_info(dev, "Wait for device to enter SBL or Mission mode\n");
+	return;
+
+error_ready_state:
+	if (mhi_cntrl->fbc_download) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+		mhi_cntrl->fbc_image = NULL;
+	}
+
+error_fw_load:
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_FW_DL_ERR);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (new_state == MHI_PM_FW_DL_ERR)
+		wake_up_all(&mhi_cntrl->state_event);
+}
+
+int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
+{
+	struct image_info *image_info = mhi_cntrl->fbc_image;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
+	int ret;
+
+	if (!image_info)
+		return -EIO;
+
+	ret = mhi_fw_load_bhie(mhi_cntrl,
+			       /* Vector table is the last entry */
+			       &image_info->mhi_buf[image_info->entries - 1]);
+	if (ret) {
+		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_FW_DL_ERR);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (new_state == MHI_PM_FW_DL_ERR)
+			wake_up_all(&mhi_cntrl->state_event);
+	}
+
+	return ret;
+}
diff --git a/drivers/bus/mhi/host/debugfs.c b/drivers/bus/mhi/host/debugfs.c
new file mode 100644
index 000000000000..d818586c229d
--- /dev/null
+++ b/drivers/bus/mhi/host/debugfs.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include "internal.h"
+
+static int mhi_debugfs_states_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+
+	/* states */
+	seq_printf(m, "PM state: %s Device: %s MHI state: %s EE: %s wake: %s\n",
+		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		   mhi_is_active(mhi_cntrl) ? "Active" : "Inactive",
+		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		   TO_MHI_EXEC_STR(mhi_cntrl->ee),
+		   mhi_cntrl->wake_set ? "true" : "false");
+
+	/* counters */
+	seq_printf(m, "M0: %u M2: %u M3: %u", mhi_cntrl->M0, mhi_cntrl->M2,
+		   mhi_cntrl->M3);
+
+	seq_printf(m, " device wake: %u pending packets: %u\n",
+		   atomic_read(&mhi_cntrl->dev_wake),
+		   atomic_read(&mhi_cntrl->pending_pkts));
+
+	return 0;
+}
+
+static int mhi_debugfs_events_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+	struct mhi_event *mhi_event;
+	struct mhi_event_ctxt *er_ctxt;
+	int i;
+
+	if (!mhi_is_active(mhi_cntrl)) {
+		seq_puts(m, "Device not ready\n");
+		return -ENODEV;
+	}
+
+	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings;
+						i++, er_ctxt++, mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev) {
+			seq_printf(m, "Index: %d is an offload event ring\n",
+				   i);
+			continue;
+		}
+
+		seq_printf(m, "Index: %d intmod count: %lu time: %lu",
+			   i, (le32_to_cpu(er_ctxt->intmod) & EV_CTX_INTMODC_MASK) >>
+			   EV_CTX_INTMODC_SHIFT,
+			   (le32_to_cpu(er_ctxt->intmod) & EV_CTX_INTMODT_MASK) >>
+			   EV_CTX_INTMODT_SHIFT);
+
+		seq_printf(m, " base: 0x%0llx len: 0x%llx", le64_to_cpu(er_ctxt->rbase),
+			   le64_to_cpu(er_ctxt->rlen));
+
+		seq_printf(m, " rp: 0x%llx wp: 0x%llx", le64_to_cpu(er_ctxt->rp),
+			   le64_to_cpu(er_ctxt->wp));
+
+		seq_printf(m, " local rp: 0x%pK db: 0x%pad\n", ring->rp,
+			   &mhi_event->db_cfg.db_val);
+	}
+
+	return 0;
+}
+
+static int mhi_debugfs_channels_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+	struct mhi_chan *mhi_chan;
+	struct mhi_chan_ctxt *chan_ctxt;
+	int i;
+
+	if (!mhi_is_active(mhi_cntrl)) {
+		seq_puts(m, "Device not ready\n");
+		return -ENODEV;
+	}
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	chan_ctxt = mhi_cntrl->mhi_ctxt->chan_ctxt;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
+		struct mhi_ring *ring = &mhi_chan->tre_ring;
+
+		if (mhi_chan->offload_ch) {
+			seq_printf(m, "%s(%u) is an offload channel\n",
+				   mhi_chan->name, mhi_chan->chan);
+			continue;
+		}
+
+		if (!mhi_chan->mhi_dev)
+			continue;
+
+		seq_printf(m,
+			   "%s(%u) state: 0x%lx brstmode: 0x%lx pollcfg: 0x%lx",
+			   mhi_chan->name, mhi_chan->chan, (le32_to_cpu(chan_ctxt->chcfg) &
+			   CHAN_CTX_CHSTATE_MASK) >> CHAN_CTX_CHSTATE_SHIFT,
+			   (le32_to_cpu(chan_ctxt->chcfg) & CHAN_CTX_BRSTMODE_MASK) >>
+			   CHAN_CTX_BRSTMODE_SHIFT, (le32_to_cpu(chan_ctxt->chcfg) &
+			   CHAN_CTX_POLLCFG_MASK) >> CHAN_CTX_POLLCFG_SHIFT);
+
+		seq_printf(m, " type: 0x%x event ring: %u", le32_to_cpu(chan_ctxt->chtype),
+			   le32_to_cpu(chan_ctxt->erindex));
+
+		seq_printf(m, " base: 0x%llx len: 0x%llx rp: 0x%llx wp: 0x%llx",
+			   le64_to_cpu(chan_ctxt->rbase), le64_to_cpu(chan_ctxt->rlen),
+			   le64_to_cpu(chan_ctxt->rp), le64_to_cpu(chan_ctxt->wp));
+
+		seq_printf(m, " local rp: 0x%pK local wp: 0x%pK db: 0x%pad\n",
+			   ring->rp, ring->wp,
+			   &mhi_chan->db_cfg.db_val);
+	}
+
+	return 0;
+}
+
+static int mhi_device_info_show(struct device *dev, void *data)
+{
+	struct mhi_device *mhi_dev;
+
+	if (dev->bus != &mhi_bus_type)
+		return 0;
+
+	mhi_dev = to_mhi_device(dev);
+
+	seq_printf((struct seq_file *)data, "%s: type: %s dev_wake: %u",
+		   mhi_dev->name, mhi_dev->dev_type ? "Controller" : "Transfer",
+		   mhi_dev->dev_wake);
+
+	/* for transfer device types only */
+	if (mhi_dev->dev_type == MHI_DEVICE_XFER)
+		seq_printf((struct seq_file *)data, " channels: %u(UL)/%u(DL)",
+			   mhi_dev->ul_chan_id, mhi_dev->dl_chan_id);
+
+	seq_puts((struct seq_file *)data, "\n");
+
+	return 0;
+}
+
+static int mhi_debugfs_devices_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+
+	if (!mhi_is_active(mhi_cntrl)) {
+		seq_puts(m, "Device not ready\n");
+		return -ENODEV;
+	}
+
+	/* Show controller and client(s) info */
+	mhi_device_info_show(&mhi_cntrl->mhi_dev->dev, m);
+	device_for_each_child(&mhi_cntrl->mhi_dev->dev, m, mhi_device_info_show);
+
+	return 0;
+}
+
+static int mhi_debugfs_regdump_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+	enum mhi_state state;
+	enum mhi_ee_type ee;
+	int i, ret = -EIO;
+	u32 val;
+	void __iomem *mhi_base = mhi_cntrl->regs;
+	void __iomem *bhi_base = mhi_cntrl->bhi;
+	void __iomem *bhie_base = mhi_cntrl->bhie;
+	void __iomem *wake_db = mhi_cntrl->wake_db;
+	struct {
+		const char *name;
+		int offset;
+		void __iomem *base;
+	} regs[] = {
+		{ "MHI_REGLEN", MHIREGLEN, mhi_base},
+		{ "MHI_VER", MHIVER, mhi_base},
+		{ "MHI_CFG", MHICFG, mhi_base},
+		{ "MHI_CTRL", MHICTRL, mhi_base},
+		{ "MHI_STATUS", MHISTATUS, mhi_base},
+		{ "MHI_WAKE_DB", 0, wake_db},
+		{ "BHI_EXECENV", BHI_EXECENV, bhi_base},
+		{ "BHI_STATUS", BHI_STATUS, bhi_base},
+		{ "BHI_ERRCODE", BHI_ERRCODE, bhi_base},
+		{ "BHI_ERRDBG1", BHI_ERRDBG1, bhi_base},
+		{ "BHI_ERRDBG2", BHI_ERRDBG2, bhi_base},
+		{ "BHI_ERRDBG3", BHI_ERRDBG3, bhi_base},
+		{ "BHIE_TXVEC_DB", BHIE_TXVECDB_OFFS, bhie_base},
+		{ "BHIE_TXVEC_STATUS", BHIE_TXVECSTATUS_OFFS, bhie_base},
+		{ "BHIE_RXVEC_DB", BHIE_RXVECDB_OFFS, bhie_base},
+		{ "BHIE_RXVEC_STATUS", BHIE_RXVECSTATUS_OFFS, bhie_base},
+		{ NULL },
+	};
+
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		return ret;
+
+	seq_printf(m, "Host PM state: %s Device state: %s EE: %s\n",
+		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		   TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	state = mhi_get_mhi_state(mhi_cntrl);
+	ee = mhi_get_exec_env(mhi_cntrl);
+	seq_printf(m, "Device EE: %s state: %s\n", TO_MHI_EXEC_STR(ee),
+		   TO_MHI_STATE_STR(state));
+
+	for (i = 0; regs[i].name; i++) {
+		if (!regs[i].base)
+			continue;
+		ret = mhi_read_reg(mhi_cntrl, regs[i].base, regs[i].offset,
+				   &val);
+		if (ret)
+			continue;
+
+		seq_printf(m, "%s: 0x%x\n", regs[i].name, val);
+	}
+
+	return 0;
+}
+
+static int mhi_debugfs_device_wake_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
+
+	if (!mhi_is_active(mhi_cntrl)) {
+		seq_puts(m, "Device not ready\n");
+		return -ENODEV;
+	}
+
+	seq_printf(m,
+		   "Wake count: %d\n%s\n", mhi_dev->dev_wake,
+		   "Usage: echo get/put > device_wake to vote/unvote for M0");
+
+	return 0;
+}
+
+static ssize_t mhi_debugfs_device_wake_write(struct file *file,
+					     const char __user *ubuf,
+					     size_t count, loff_t *ppos)
+{
+	struct seq_file	*m = file->private_data;
+	struct mhi_controller *mhi_cntrl = m->private;
+	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
+	char buf[16];
+	int ret = -EINVAL;
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (!strncmp(buf, "get", 3)) {
+		ret = mhi_device_get_sync(mhi_dev);
+	} else if (!strncmp(buf, "put", 3)) {
+		mhi_device_put(mhi_dev);
+		ret = 0;
+	}
+
+	return ret ? ret : count;
+}
+
+static int mhi_debugfs_timeout_ms_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+
+	seq_printf(m, "%u ms\n", mhi_cntrl->timeout_ms);
+
+	return 0;
+}
+
+static ssize_t mhi_debugfs_timeout_ms_write(struct file *file,
+					    const char __user *ubuf,
+					    size_t count, loff_t *ppos)
+{
+	struct seq_file	*m = file->private_data;
+	struct mhi_controller *mhi_cntrl = m->private;
+	u32 timeout_ms;
+
+	if (kstrtou32_from_user(ubuf, count, 0, &timeout_ms))
+		return -EINVAL;
+
+	mhi_cntrl->timeout_ms = timeout_ms;
+
+	return count;
+}
+
+static int mhi_debugfs_states_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_states_show, inode->i_private);
+}
+
+static int mhi_debugfs_events_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_events_show, inode->i_private);
+}
+
+static int mhi_debugfs_channels_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_channels_show, inode->i_private);
+}
+
+static int mhi_debugfs_devices_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_devices_show, inode->i_private);
+}
+
+static int mhi_debugfs_regdump_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_regdump_show, inode->i_private);
+}
+
+static int mhi_debugfs_device_wake_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_device_wake_show, inode->i_private);
+}
+
+static int mhi_debugfs_timeout_ms_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_timeout_ms_show, inode->i_private);
+}
+
+static const struct file_operations debugfs_states_fops = {
+	.open = mhi_debugfs_states_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_events_fops = {
+	.open = mhi_debugfs_events_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_channels_fops = {
+	.open = mhi_debugfs_channels_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_devices_fops = {
+	.open = mhi_debugfs_devices_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_regdump_fops = {
+	.open = mhi_debugfs_regdump_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_device_wake_fops = {
+	.open = mhi_debugfs_device_wake_open,
+	.write = mhi_debugfs_device_wake_write,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_timeout_ms_fops = {
+	.open = mhi_debugfs_timeout_ms_open,
+	.write = mhi_debugfs_timeout_ms_write,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static struct dentry *mhi_debugfs_root;
+
+void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
+{
+	mhi_cntrl->debugfs_dentry =
+			debugfs_create_dir(dev_name(&mhi_cntrl->mhi_dev->dev),
+					   mhi_debugfs_root);
+
+	debugfs_create_file("states", 0444, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_states_fops);
+	debugfs_create_file("events", 0444, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_events_fops);
+	debugfs_create_file("channels", 0444, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_channels_fops);
+	debugfs_create_file("devices", 0444, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_devices_fops);
+	debugfs_create_file("regdump", 0444, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_regdump_fops);
+	debugfs_create_file("device_wake", 0644, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_device_wake_fops);
+	debugfs_create_file("timeout_ms", 0644, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_timeout_ms_fops);
+}
+
+void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl)
+{
+	debugfs_remove_recursive(mhi_cntrl->debugfs_dentry);
+	mhi_cntrl->debugfs_dentry = NULL;
+}
+
+void mhi_debugfs_init(void)
+{
+	mhi_debugfs_root = debugfs_create_dir(mhi_bus_type.name, NULL);
+}
+
+void mhi_debugfs_exit(void)
+{
+	debugfs_remove_recursive(mhi_debugfs_root);
+}
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
new file mode 100644
index 000000000000..829d4fca7ddc
--- /dev/null
+++ b/drivers/bus/mhi/host/init.c
@@ -0,0 +1,1443 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/wait.h>
+#include "internal.h"
+
+static DEFINE_IDA(mhi_controller_ida);
+
+const char * const mhi_ee_str[MHI_EE_MAX] = {
+	[MHI_EE_PBL] = "PRIMARY BOOTLOADER",
+	[MHI_EE_SBL] = "SECONDARY BOOTLOADER",
+	[MHI_EE_AMSS] = "MISSION MODE",
+	[MHI_EE_RDDM] = "RAMDUMP DOWNLOAD MODE",
+	[MHI_EE_WFW] = "WLAN FIRMWARE",
+	[MHI_EE_PTHRU] = "PASS THROUGH",
+	[MHI_EE_EDL] = "EMERGENCY DOWNLOAD",
+	[MHI_EE_FP] = "FLASH PROGRAMMER",
+	[MHI_EE_DISABLE_TRANSITION] = "DISABLE",
+	[MHI_EE_NOT_SUPPORTED] = "NOT SUPPORTED",
+};
+
+const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
+	[DEV_ST_TRANSITION_PBL] = "PBL",
+	[DEV_ST_TRANSITION_READY] = "READY",
+	[DEV_ST_TRANSITION_SBL] = "SBL",
+	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION MODE",
+	[DEV_ST_TRANSITION_FP] = "FLASH PROGRAMMER",
+	[DEV_ST_TRANSITION_SYS_ERR] = "SYS ERROR",
+	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
+};
+
+const char * const mhi_state_str[MHI_STATE_MAX] = {
+	[MHI_STATE_RESET] = "RESET",
+	[MHI_STATE_READY] = "READY",
+	[MHI_STATE_M0] = "M0",
+	[MHI_STATE_M1] = "M1",
+	[MHI_STATE_M2] = "M2",
+	[MHI_STATE_M3] = "M3",
+	[MHI_STATE_M3_FAST] = "M3 FAST",
+	[MHI_STATE_BHI] = "BHI",
+	[MHI_STATE_SYS_ERR] = "SYS ERROR",
+};
+
+const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
+	[MHI_CH_STATE_TYPE_RESET] = "RESET",
+	[MHI_CH_STATE_TYPE_STOP] = "STOP",
+	[MHI_CH_STATE_TYPE_START] = "START",
+};
+
+static const char * const mhi_pm_state_str[] = {
+	[MHI_PM_STATE_DISABLE] = "DISABLE",
+	[MHI_PM_STATE_POR] = "POWER ON RESET",
+	[MHI_PM_STATE_M0] = "M0",
+	[MHI_PM_STATE_M2] = "M2",
+	[MHI_PM_STATE_M3_ENTER] = "M?->M3",
+	[MHI_PM_STATE_M3] = "M3",
+	[MHI_PM_STATE_M3_EXIT] = "M3->M0",
+	[MHI_PM_STATE_FW_DL_ERR] = "Firmware Download Error",
+	[MHI_PM_STATE_SYS_ERR_DETECT] = "SYS ERROR Detect",
+	[MHI_PM_STATE_SYS_ERR_PROCESS] = "SYS ERROR Process",
+	[MHI_PM_STATE_SHUTDOWN_PROCESS] = "SHUTDOWN Process",
+	[MHI_PM_STATE_LD_ERR_FATAL_DETECT] = "Linkdown or Error Fatal Detect",
+};
+
+const char *to_mhi_pm_state_str(u32 state)
+{
+	int index;
+
+	if (state)
+		index = __fls(state);
+
+	if (!state || index >= ARRAY_SIZE(mhi_pm_state_str))
+		return "Invalid State";
+
+	return mhi_pm_state_str[index];
+}
+
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
+			mhi_cntrl->serial_number);
+}
+static DEVICE_ATTR_RO(serial_number);
+
+static ssize_t oem_pk_hash_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int i, cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++)
+		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
+				"OEMPKHASH[%d]: 0x%x\n", i,
+				mhi_cntrl->oem_pk_hash[i]);
+
+	return cnt;
+}
+static DEVICE_ATTR_RO(oem_pk_hash);
+
+static struct attribute *mhi_dev_attrs[] = {
+	&dev_attr_serial_number.attr,
+	&dev_attr_oem_pk_hash.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(mhi_dev);
+
+/* MHI protocol requires the transfer ring to be aligned with ring length */
+static int mhi_alloc_aligned_ring(struct mhi_controller *mhi_cntrl,
+				  struct mhi_ring *ring,
+				  u64 len)
+{
+	ring->alloc_size = len + (len - 1);
+	ring->pre_aligned = dma_alloc_coherent(mhi_cntrl->cntrl_dev, ring->alloc_size,
+					       &ring->dma_handle, GFP_KERNEL);
+	if (!ring->pre_aligned)
+		return -ENOMEM;
+
+	ring->iommu_base = (ring->dma_handle + (len - 1)) & ~(len - 1);
+	ring->base = ring->pre_aligned + (ring->iommu_base - ring->dma_handle);
+
+	return 0;
+}
+
+void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
+	}
+
+	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+}
+
+int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
+	int i, ret;
+
+	/* if controller driver has set irq_flags, use it */
+	if (mhi_cntrl->irq_flags)
+		irq_flags = mhi_cntrl->irq_flags;
+
+	/* Setup BHI_INTVEC IRQ */
+	ret = request_threaded_irq(mhi_cntrl->irq[0], mhi_intvec_handler,
+				   mhi_intvec_threaded_handler,
+				   irq_flags,
+				   "bhi", mhi_cntrl);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
+			dev_err(dev, "irq %d not available for event ring\n",
+				mhi_event->irq);
+			ret = -EINVAL;
+			goto error_request;
+		}
+
+		ret = request_irq(mhi_cntrl->irq[mhi_event->irq],
+				  mhi_irq_handler,
+				  irq_flags,
+				  "mhi", mhi_event);
+		if (ret) {
+			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
+				mhi_cntrl->irq[mhi_event->irq], i);
+			goto error_request;
+		}
+	}
+
+	return 0;
+
+error_request:
+	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
+	}
+	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+
+	return ret;
+}
+
+void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_ctxt *mhi_ctxt = mhi_cntrl->mhi_ctxt;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_event *mhi_event;
+	struct mhi_ring *ring;
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++) {
+		ring = &mhi_cmd->ring;
+		dma_free_coherent(mhi_cntrl->cntrl_dev, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+		ring->base = NULL;
+		ring->iommu_base = 0;
+	}
+
+	dma_free_coherent(mhi_cntrl->cntrl_dev,
+			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
+			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		ring = &mhi_event->ring;
+		dma_free_coherent(mhi_cntrl->cntrl_dev, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+		ring->base = NULL;
+		ring->iommu_base = 0;
+	}
+
+	dma_free_coherent(mhi_cntrl->cntrl_dev, sizeof(*mhi_ctxt->er_ctxt) *
+			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
+			  mhi_ctxt->er_ctxt_addr);
+
+	dma_free_coherent(mhi_cntrl->cntrl_dev, sizeof(*mhi_ctxt->chan_ctxt) *
+			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
+			  mhi_ctxt->chan_ctxt_addr);
+
+	kfree(mhi_ctxt);
+	mhi_cntrl->mhi_ctxt = NULL;
+}
+
+int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_ctxt *mhi_ctxt;
+	struct mhi_chan_ctxt *chan_ctxt;
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	struct mhi_chan *mhi_chan;
+	struct mhi_event *mhi_event;
+	struct mhi_cmd *mhi_cmd;
+	u32 tmp;
+	int ret = -ENOMEM, i;
+
+	atomic_set(&mhi_cntrl->dev_wake, 0);
+	atomic_set(&mhi_cntrl->pending_pkts, 0);
+
+	mhi_ctxt = kzalloc(sizeof(*mhi_ctxt), GFP_KERNEL);
+	if (!mhi_ctxt)
+		return -ENOMEM;
+
+	/* Setup channel ctxt */
+	mhi_ctxt->chan_ctxt = dma_alloc_coherent(mhi_cntrl->cntrl_dev,
+						 sizeof(*mhi_ctxt->chan_ctxt) *
+						 mhi_cntrl->max_chan,
+						 &mhi_ctxt->chan_ctxt_addr,
+						 GFP_KERNEL);
+	if (!mhi_ctxt->chan_ctxt)
+		goto error_alloc_chan_ctxt;
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	chan_ctxt = mhi_ctxt->chan_ctxt;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
+		/* Skip if it is an offload channel */
+		if (mhi_chan->offload_ch)
+			continue;
+
+		tmp = le32_to_cpu(chan_ctxt->chcfg);
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
+		tmp &= ~CHAN_CTX_BRSTMODE_MASK;
+		tmp |= (mhi_chan->db_cfg.brstmode << CHAN_CTX_BRSTMODE_SHIFT);
+		tmp &= ~CHAN_CTX_POLLCFG_MASK;
+		tmp |= (mhi_chan->db_cfg.pollcfg << CHAN_CTX_POLLCFG_SHIFT);
+		chan_ctxt->chcfg = cpu_to_le32(tmp);
+
+		chan_ctxt->chtype = cpu_to_le32(mhi_chan->type);
+		chan_ctxt->erindex = cpu_to_le32(mhi_chan->er_index);
+
+		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+		mhi_chan->tre_ring.db_addr = (void __iomem *)&chan_ctxt->wp;
+	}
+
+	/* Setup event context */
+	mhi_ctxt->er_ctxt = dma_alloc_coherent(mhi_cntrl->cntrl_dev,
+					       sizeof(*mhi_ctxt->er_ctxt) *
+					       mhi_cntrl->total_ev_rings,
+					       &mhi_ctxt->er_ctxt_addr,
+					       GFP_KERNEL);
+	if (!mhi_ctxt->er_ctxt)
+		goto error_alloc_er_ctxt;
+
+	er_ctxt = mhi_ctxt->er_ctxt;
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
+		     mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* Skip if it is an offload event */
+		if (mhi_event->offload_ev)
+			continue;
+
+		tmp = le32_to_cpu(er_ctxt->intmod);
+		tmp &= ~EV_CTX_INTMODC_MASK;
+		tmp &= ~EV_CTX_INTMODT_MASK;
+		tmp |= (mhi_event->intmod << EV_CTX_INTMODT_SHIFT);
+		er_ctxt->intmod = cpu_to_le32(tmp);
+
+		er_ctxt->ertype = cpu_to_le32(MHI_ER_TYPE_VALID);
+		er_ctxt->msivec = cpu_to_le32(mhi_event->irq);
+		mhi_event->db_cfg.db_mode = true;
+
+		ring->el_size = sizeof(struct mhi_tre);
+		ring->len = ring->el_size * ring->elements;
+		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
+		if (ret)
+			goto error_alloc_er;
+
+		/*
+		 * If the read pointer equals to the write pointer, then the
+		 * ring is empty
+		 */
+		ring->rp = ring->wp = ring->base;
+		er_ctxt->rbase = cpu_to_le64(ring->iommu_base);
+		er_ctxt->rp = er_ctxt->wp = er_ctxt->rbase;
+		er_ctxt->rlen = cpu_to_le64(ring->len);
+		ring->ctxt_wp = &er_ctxt->wp;
+	}
+
+	/* Setup cmd context */
+	ret = -ENOMEM;
+	mhi_ctxt->cmd_ctxt = dma_alloc_coherent(mhi_cntrl->cntrl_dev,
+						sizeof(*mhi_ctxt->cmd_ctxt) *
+						NR_OF_CMD_RINGS,
+						&mhi_ctxt->cmd_ctxt_addr,
+						GFP_KERNEL);
+	if (!mhi_ctxt->cmd_ctxt)
+		goto error_alloc_er;
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	cmd_ctxt = mhi_ctxt->cmd_ctxt;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		ring->el_size = sizeof(struct mhi_tre);
+		ring->elements = CMD_EL_PER_RING;
+		ring->len = ring->el_size * ring->elements;
+		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
+		if (ret)
+			goto error_alloc_cmd;
+
+		ring->rp = ring->wp = ring->base;
+		cmd_ctxt->rbase = cpu_to_le64(ring->iommu_base);
+		cmd_ctxt->rp = cmd_ctxt->wp = cmd_ctxt->rbase;
+		cmd_ctxt->rlen = cpu_to_le64(ring->len);
+		ring->ctxt_wp = &cmd_ctxt->wp;
+	}
+
+	mhi_cntrl->mhi_ctxt = mhi_ctxt;
+
+	return 0;
+
+error_alloc_cmd:
+	for (--i, --mhi_cmd; i >= 0; i--, mhi_cmd--) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		dma_free_coherent(mhi_cntrl->cntrl_dev, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+	}
+	dma_free_coherent(mhi_cntrl->cntrl_dev,
+			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
+			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
+	i = mhi_cntrl->total_ev_rings;
+	mhi_event = mhi_cntrl->mhi_event + i;
+
+error_alloc_er:
+	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev)
+			continue;
+
+		dma_free_coherent(mhi_cntrl->cntrl_dev, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+	}
+	dma_free_coherent(mhi_cntrl->cntrl_dev, sizeof(*mhi_ctxt->er_ctxt) *
+			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
+			  mhi_ctxt->er_ctxt_addr);
+
+error_alloc_er_ctxt:
+	dma_free_coherent(mhi_cntrl->cntrl_dev, sizeof(*mhi_ctxt->chan_ctxt) *
+			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
+			  mhi_ctxt->chan_ctxt_addr);
+
+error_alloc_chan_ctxt:
+	kfree(mhi_ctxt);
+
+	return ret;
+}
+
+int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
+{
+	u32 val;
+	int i, ret;
+	struct mhi_chan *mhi_chan;
+	struct mhi_event *mhi_event;
+	void __iomem *base = mhi_cntrl->regs;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct {
+		u32 offset;
+		u32 mask;
+		u32 shift;
+		u32 val;
+	} reg_info[] = {
+		{
+			CCABAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
+		},
+		{
+			CCABAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
+		},
+		{
+			ECABAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
+		},
+		{
+			ECABAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
+		},
+		{
+			CRCBAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
+		},
+		{
+			CRCBAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
+		},
+		{
+			MHICFG, MHICFG_NER_MASK, MHICFG_NER_SHIFT,
+			mhi_cntrl->total_ev_rings,
+		},
+		{
+			MHICFG, MHICFG_NHWER_MASK, MHICFG_NHWER_SHIFT,
+			mhi_cntrl->hw_ev_rings,
+		},
+		{
+			MHICTRLBASE_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHICTRLBASE_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHIDATABASE_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHIDATABASE_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHICTRLLIMIT_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHICTRLLIMIT_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHIDATALIMIT_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHIDATALIMIT_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_stop),
+		},
+		{ 0, 0, 0 }
+	};
+
+	dev_dbg(dev, "Initializing MHI registers\n");
+
+	/* Read channel db offset */
+	ret = mhi_read_reg_field(mhi_cntrl, base, CHDBOFF, CHDBOFF_CHDBOFF_MASK,
+				 CHDBOFF_CHDBOFF_SHIFT, &val);
+	if (ret) {
+		dev_err(dev, "Unable to read CHDBOFF register\n");
+		return -EIO;
+	}
+
+	if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
+		dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
+			val, mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB));
+		return -ERANGE;
+	}
+
+	/* Setup wake db */
+	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
+	mhi_cntrl->wake_set = false;
+
+	/* Setup channel db address for each channel in tre_ring */
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, val += 8, mhi_chan++)
+		mhi_chan->tre_ring.db_addr = base + val;
+
+	/* Read event ring db offset */
+	ret = mhi_read_reg_field(mhi_cntrl, base, ERDBOFF, ERDBOFF_ERDBOFF_MASK,
+				 ERDBOFF_ERDBOFF_SHIFT, &val);
+	if (ret) {
+		dev_err(dev, "Unable to read ERDBOFF register\n");
+		return -EIO;
+	}
+
+	if (val >= mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings)) {
+		dev_err(dev, "ERDB offset: 0x%x is out of range: 0x%zx\n",
+			val, mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings));
+		return -ERANGE;
+	}
+
+	/* Setup event db address for each ev_ring */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_event->ring.db_addr = base + val;
+	}
+
+	/* Setup DB register for primary CMD rings */
+	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
+
+	/* Write to MMIO registers */
+	for (i = 0; reg_info[i].offset; i++)
+		mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
+				    reg_info[i].mask, reg_info[i].shift,
+				    reg_info[i].val);
+
+	return 0;
+}
+
+void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
+			  struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring;
+	struct mhi_ring *tre_ring;
+	struct mhi_chan_ctxt *chan_ctxt;
+	u32 tmp;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
+
+	if (!chan_ctxt->rbase) /* Already uninitialized */
+		return;
+
+	dma_free_coherent(mhi_cntrl->cntrl_dev, tre_ring->alloc_size,
+			  tre_ring->pre_aligned, tre_ring->dma_handle);
+	vfree(buf_ring->base);
+
+	buf_ring->base = tre_ring->base = NULL;
+	tre_ring->ctxt_wp = NULL;
+	chan_ctxt->rbase = 0;
+	chan_ctxt->rlen = 0;
+	chan_ctxt->rp = 0;
+	chan_ctxt->wp = 0;
+
+	tmp = le32_to_cpu(chan_ctxt->chcfg);
+	tmp &= ~CHAN_CTX_CHSTATE_MASK;
+	tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
+	chan_ctxt->chcfg = cpu_to_le32(tmp);
+
+	/* Update to all cores */
+	smp_wmb();
+}
+
+int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
+		       struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring;
+	struct mhi_ring *tre_ring;
+	struct mhi_chan_ctxt *chan_ctxt;
+	u32 tmp;
+	int ret;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	tre_ring->el_size = sizeof(struct mhi_tre);
+	tre_ring->len = tre_ring->el_size * tre_ring->elements;
+	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
+	ret = mhi_alloc_aligned_ring(mhi_cntrl, tre_ring, tre_ring->len);
+	if (ret)
+		return -ENOMEM;
+
+	buf_ring->el_size = sizeof(struct mhi_buf_info);
+	buf_ring->len = buf_ring->el_size * buf_ring->elements;
+	buf_ring->base = vzalloc(buf_ring->len);
+
+	if (!buf_ring->base) {
+		dma_free_coherent(mhi_cntrl->cntrl_dev, tre_ring->alloc_size,
+				  tre_ring->pre_aligned, tre_ring->dma_handle);
+		return -ENOMEM;
+	}
+
+	tmp = le32_to_cpu(chan_ctxt->chcfg);
+	tmp &= ~CHAN_CTX_CHSTATE_MASK;
+	tmp |= (MHI_CH_STATE_ENABLED << CHAN_CTX_CHSTATE_SHIFT);
+	chan_ctxt->chcfg = cpu_to_le32(tmp);
+
+	chan_ctxt->rbase = cpu_to_le64(tre_ring->iommu_base);
+	chan_ctxt->rp = chan_ctxt->wp = chan_ctxt->rbase;
+	chan_ctxt->rlen = cpu_to_le64(tre_ring->len);
+	tre_ring->ctxt_wp = &chan_ctxt->wp;
+
+	tre_ring->rp = tre_ring->wp = tre_ring->base;
+	buf_ring->rp = buf_ring->wp = buf_ring->base;
+	mhi_chan->db_cfg.db_mode = 1;
+
+	/* Update to all cores */
+	smp_wmb();
+
+	return 0;
+}
+
+static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
+			const struct mhi_controller_config *config)
+{
+	struct mhi_event *mhi_event;
+	const struct mhi_event_config *event_cfg;
+	struct device *dev = mhi_cntrl->cntrl_dev;
+	int i, num;
+
+	num = config->num_events;
+	mhi_cntrl->total_ev_rings = num;
+	mhi_cntrl->mhi_event = kcalloc(num, sizeof(*mhi_cntrl->mhi_event),
+				       GFP_KERNEL);
+	if (!mhi_cntrl->mhi_event)
+		return -ENOMEM;
+
+	/* Populate event ring */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < num; i++) {
+		event_cfg = &config->event_cfg[i];
+
+		mhi_event->er_index = i;
+		mhi_event->ring.elements = event_cfg->num_elements;
+		mhi_event->intmod = event_cfg->irq_moderation_ms;
+		mhi_event->irq = event_cfg->irq;
+
+		if (event_cfg->channel != U32_MAX) {
+			/* This event ring has a dedicated channel */
+			mhi_event->chan = event_cfg->channel;
+			if (mhi_event->chan >= mhi_cntrl->max_chan) {
+				dev_err(dev,
+					"Event Ring channel not available\n");
+				goto error_ev_cfg;
+			}
+
+			mhi_event->mhi_chan =
+				&mhi_cntrl->mhi_chan[mhi_event->chan];
+		}
+
+		/* Priority is fixed to 1 for now */
+		mhi_event->priority = 1;
+
+		mhi_event->db_cfg.brstmode = event_cfg->mode;
+		if (MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
+			goto error_ev_cfg;
+
+		if (mhi_event->db_cfg.brstmode == MHI_DB_BRST_ENABLE)
+			mhi_event->db_cfg.process_db = mhi_db_brstmode;
+		else
+			mhi_event->db_cfg.process_db = mhi_db_brstmode_disable;
+
+		mhi_event->data_type = event_cfg->data_type;
+
+		switch (mhi_event->data_type) {
+		case MHI_ER_DATA:
+			mhi_event->process_event = mhi_process_data_event_ring;
+			break;
+		case MHI_ER_CTRL:
+			mhi_event->process_event = mhi_process_ctrl_ev_ring;
+			break;
+		default:
+			dev_err(dev, "Event Ring type not supported\n");
+			goto error_ev_cfg;
+		}
+
+		mhi_event->hw_ring = event_cfg->hardware_event;
+		if (mhi_event->hw_ring)
+			mhi_cntrl->hw_ev_rings++;
+		else
+			mhi_cntrl->sw_ev_rings++;
+
+		mhi_event->cl_manage = event_cfg->client_managed;
+		mhi_event->offload_ev = event_cfg->offload_channel;
+		mhi_event++;
+	}
+
+	return 0;
+
+error_ev_cfg:
+
+	kfree(mhi_cntrl->mhi_event);
+	return -EINVAL;
+}
+
+static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
+			const struct mhi_controller_config *config)
+{
+	const struct mhi_channel_config *ch_cfg;
+	struct device *dev = mhi_cntrl->cntrl_dev;
+	int i;
+	u32 chan;
+
+	mhi_cntrl->max_chan = config->max_channels;
+
+	/*
+	 * The allocation of MHI channels can exceed 32KB in some scenarios,
+	 * so to avoid any memory possible allocation failures, vzalloc is
+	 * used here
+	 */
+	mhi_cntrl->mhi_chan = vzalloc(mhi_cntrl->max_chan *
+				      sizeof(*mhi_cntrl->mhi_chan));
+	if (!mhi_cntrl->mhi_chan)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&mhi_cntrl->lpm_chans);
+
+	/* Populate channel configurations */
+	for (i = 0; i < config->num_channels; i++) {
+		struct mhi_chan *mhi_chan;
+
+		ch_cfg = &config->ch_cfg[i];
+
+		chan = ch_cfg->num;
+		if (chan >= mhi_cntrl->max_chan) {
+			dev_err(dev, "Channel %d not available\n", chan);
+			goto error_chan_cfg;
+		}
+
+		mhi_chan = &mhi_cntrl->mhi_chan[chan];
+		mhi_chan->name = ch_cfg->name;
+		mhi_chan->chan = chan;
+
+		mhi_chan->tre_ring.elements = ch_cfg->num_elements;
+		if (!mhi_chan->tre_ring.elements)
+			goto error_chan_cfg;
+
+		/*
+		 * For some channels, local ring length should be bigger than
+		 * the transfer ring length due to internal logical channels
+		 * in device. So host can queue much more buffers than transfer
+		 * ring length. Example, RSC channels should have a larger local
+		 * channel length than transfer ring length.
+		 */
+		mhi_chan->buf_ring.elements = ch_cfg->local_elements;
+		if (!mhi_chan->buf_ring.elements)
+			mhi_chan->buf_ring.elements = mhi_chan->tre_ring.elements;
+		mhi_chan->er_index = ch_cfg->event_ring;
+		mhi_chan->dir = ch_cfg->dir;
+
+		/*
+		 * For most channels, chtype is identical to channel directions.
+		 * So, if it is not defined then assign channel direction to
+		 * chtype
+		 */
+		mhi_chan->type = ch_cfg->type;
+		if (!mhi_chan->type)
+			mhi_chan->type = (enum mhi_ch_type)mhi_chan->dir;
+
+		mhi_chan->ee_mask = ch_cfg->ee_mask;
+		mhi_chan->db_cfg.pollcfg = ch_cfg->pollcfg;
+		mhi_chan->lpm_notify = ch_cfg->lpm_notify;
+		mhi_chan->offload_ch = ch_cfg->offload_channel;
+		mhi_chan->db_cfg.reset_req = ch_cfg->doorbell_mode_switch;
+		mhi_chan->pre_alloc = ch_cfg->auto_queue;
+		mhi_chan->wake_capable = ch_cfg->wake_capable;
+
+		/*
+		 * If MHI host allocates buffers, then the channel direction
+		 * should be DMA_FROM_DEVICE
+		 */
+		if (mhi_chan->pre_alloc && mhi_chan->dir != DMA_FROM_DEVICE) {
+			dev_err(dev, "Invalid channel configuration\n");
+			goto error_chan_cfg;
+		}
+
+		/*
+		 * Bi-directional and direction less channel must be an
+		 * offload channel
+		 */
+		if ((mhi_chan->dir == DMA_BIDIRECTIONAL ||
+		     mhi_chan->dir == DMA_NONE) && !mhi_chan->offload_ch) {
+			dev_err(dev, "Invalid channel configuration\n");
+			goto error_chan_cfg;
+		}
+
+		if (!mhi_chan->offload_ch) {
+			mhi_chan->db_cfg.brstmode = ch_cfg->doorbell;
+			if (MHI_INVALID_BRSTMODE(mhi_chan->db_cfg.brstmode)) {
+				dev_err(dev, "Invalid Door bell mode\n");
+				goto error_chan_cfg;
+			}
+		}
+
+		if (mhi_chan->db_cfg.brstmode == MHI_DB_BRST_ENABLE)
+			mhi_chan->db_cfg.process_db = mhi_db_brstmode;
+		else
+			mhi_chan->db_cfg.process_db = mhi_db_brstmode_disable;
+
+		mhi_chan->configured = true;
+
+		if (mhi_chan->lpm_notify)
+			list_add_tail(&mhi_chan->node, &mhi_cntrl->lpm_chans);
+	}
+
+	return 0;
+
+error_chan_cfg:
+	vfree(mhi_cntrl->mhi_chan);
+
+	return -EINVAL;
+}
+
+static int parse_config(struct mhi_controller *mhi_cntrl,
+			const struct mhi_controller_config *config)
+{
+	int ret;
+
+	/* Parse MHI channel configuration */
+	ret = parse_ch_cfg(mhi_cntrl, config);
+	if (ret)
+		return ret;
+
+	/* Parse MHI event configuration */
+	ret = parse_ev_cfg(mhi_cntrl, config);
+	if (ret)
+		goto error_ev_cfg;
+
+	mhi_cntrl->timeout_ms = config->timeout_ms;
+	if (!mhi_cntrl->timeout_ms)
+		mhi_cntrl->timeout_ms = MHI_TIMEOUT_MS;
+
+	mhi_cntrl->bounce_buf = config->use_bounce_buf;
+	mhi_cntrl->buffer_len = config->buf_len;
+	if (!mhi_cntrl->buffer_len)
+		mhi_cntrl->buffer_len = MHI_MAX_MTU;
+
+	/* By default, host is allowed to ring DB in both M0 and M2 states */
+	mhi_cntrl->db_access = MHI_PM_M0 | MHI_PM_M2;
+	if (config->m2_no_db)
+		mhi_cntrl->db_access &= ~MHI_PM_M2;
+
+	return 0;
+
+error_ev_cfg:
+	vfree(mhi_cntrl->mhi_chan);
+
+	return ret;
+}
+
+int mhi_register_controller(struct mhi_controller *mhi_cntrl,
+			    const struct mhi_controller_config *config)
+{
+	struct mhi_event *mhi_event;
+	struct mhi_chan *mhi_chan;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_device *mhi_dev;
+	u32 soc_info;
+	int ret, i;
+
+	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
+	    !mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
+	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
+	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs ||
+	    !mhi_cntrl->irq || !mhi_cntrl->reg_len)
+		return -EINVAL;
+
+	ret = parse_config(mhi_cntrl, config);
+	if (ret)
+		return -EINVAL;
+
+	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS,
+				     sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
+	if (!mhi_cntrl->mhi_cmd) {
+		ret = -ENOMEM;
+		goto err_free_event;
+	}
+
+	INIT_LIST_HEAD(&mhi_cntrl->transition_list);
+	mutex_init(&mhi_cntrl->pm_mutex);
+	rwlock_init(&mhi_cntrl->pm_lock);
+	spin_lock_init(&mhi_cntrl->transition_lock);
+	spin_lock_init(&mhi_cntrl->wlock);
+	INIT_WORK(&mhi_cntrl->st_worker, mhi_pm_st_worker);
+	init_waitqueue_head(&mhi_cntrl->state_event);
+
+	mhi_cntrl->hiprio_wq = alloc_ordered_workqueue("mhi_hiprio_wq", WQ_HIGHPRI);
+	if (!mhi_cntrl->hiprio_wq) {
+		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate workqueue\n");
+		ret = -ENOMEM;
+		goto err_free_cmd;
+	}
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++)
+		spin_lock_init(&mhi_cmd->lock);
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		/* Skip for offload events */
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_event->mhi_cntrl = mhi_cntrl;
+		spin_lock_init(&mhi_event->lock);
+		if (mhi_event->data_type == MHI_ER_CTRL)
+			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
+				     (ulong)mhi_event);
+		else
+			tasklet_init(&mhi_event->task, mhi_ev_task,
+				     (ulong)mhi_event);
+	}
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		mutex_init(&mhi_chan->mutex);
+		init_completion(&mhi_chan->completion);
+		rwlock_init(&mhi_chan->lock);
+
+		/* used in setting bei field of TRE */
+		mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+		mhi_chan->intmod = mhi_event->intmod;
+	}
+
+	if (mhi_cntrl->bounce_buf) {
+		mhi_cntrl->map_single = mhi_map_single_use_bb;
+		mhi_cntrl->unmap_single = mhi_unmap_single_use_bb;
+	} else {
+		mhi_cntrl->map_single = mhi_map_single_no_bb;
+		mhi_cntrl->unmap_single = mhi_unmap_single_no_bb;
+	}
+
+	/* Read the MHI device info */
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs,
+			   SOC_HW_VERSION_OFFS, &soc_info);
+	if (ret)
+		goto err_destroy_wq;
+
+	mhi_cntrl->family_number = (soc_info & SOC_HW_VERSION_FAM_NUM_BMSK) >>
+					SOC_HW_VERSION_FAM_NUM_SHFT;
+	mhi_cntrl->device_number = (soc_info & SOC_HW_VERSION_DEV_NUM_BMSK) >>
+					SOC_HW_VERSION_DEV_NUM_SHFT;
+	mhi_cntrl->major_version = (soc_info & SOC_HW_VERSION_MAJOR_VER_BMSK) >>
+					SOC_HW_VERSION_MAJOR_VER_SHFT;
+	mhi_cntrl->minor_version = (soc_info & SOC_HW_VERSION_MINOR_VER_BMSK) >>
+					SOC_HW_VERSION_MINOR_VER_SHFT;
+
+	mhi_cntrl->index = ida_alloc(&mhi_controller_ida, GFP_KERNEL);
+	if (mhi_cntrl->index < 0) {
+		ret = mhi_cntrl->index;
+		goto err_destroy_wq;
+	}
+
+	/* Register controller with MHI bus */
+	mhi_dev = mhi_alloc_device(mhi_cntrl);
+	if (IS_ERR(mhi_dev)) {
+		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate MHI device\n");
+		ret = PTR_ERR(mhi_dev);
+		goto err_ida_free;
+	}
+
+	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
+	mhi_dev->mhi_cntrl = mhi_cntrl;
+	dev_set_name(&mhi_dev->dev, "mhi%d", mhi_cntrl->index);
+	mhi_dev->name = dev_name(&mhi_dev->dev);
+
+	/* Init wakeup source */
+	device_init_wakeup(&mhi_dev->dev, true);
+
+	ret = device_add(&mhi_dev->dev);
+	if (ret)
+		goto err_release_dev;
+
+	mhi_cntrl->mhi_dev = mhi_dev;
+
+	mhi_create_debugfs(mhi_cntrl);
+
+	return 0;
+
+err_release_dev:
+	put_device(&mhi_dev->dev);
+err_ida_free:
+	ida_free(&mhi_controller_ida, mhi_cntrl->index);
+err_destroy_wq:
+	destroy_workqueue(mhi_cntrl->hiprio_wq);
+err_free_cmd:
+	kfree(mhi_cntrl->mhi_cmd);
+err_free_event:
+	kfree(mhi_cntrl->mhi_event);
+	vfree(mhi_cntrl->mhi_chan);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_register_controller);
+
+void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
+	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
+	unsigned int i;
+
+	mhi_destroy_debugfs(mhi_cntrl);
+
+	destroy_workqueue(mhi_cntrl->hiprio_wq);
+	kfree(mhi_cntrl->mhi_cmd);
+	kfree(mhi_cntrl->mhi_event);
+
+	/* Drop the references to MHI devices created for channels */
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		if (!mhi_chan->mhi_dev)
+			continue;
+
+		put_device(&mhi_chan->mhi_dev->dev);
+	}
+	vfree(mhi_cntrl->mhi_chan);
+
+	device_del(&mhi_dev->dev);
+	put_device(&mhi_dev->dev);
+
+	ida_free(&mhi_controller_ida, mhi_cntrl->index);
+}
+EXPORT_SYMBOL_GPL(mhi_unregister_controller);
+
+struct mhi_controller *mhi_alloc_controller(void)
+{
+	struct mhi_controller *mhi_cntrl;
+
+	mhi_cntrl = kzalloc(sizeof(*mhi_cntrl), GFP_KERNEL);
+
+	return mhi_cntrl;
+}
+EXPORT_SYMBOL_GPL(mhi_alloc_controller);
+
+void mhi_free_controller(struct mhi_controller *mhi_cntrl)
+{
+	kfree(mhi_cntrl);
+}
+EXPORT_SYMBOL_GPL(mhi_free_controller);
+
+int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 bhi_off, bhie_off;
+	int ret;
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	ret = mhi_init_dev_ctxt(mhi_cntrl);
+	if (ret)
+		goto error_dev_ctxt;
+
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &bhi_off);
+	if (ret) {
+		dev_err(dev, "Error getting BHI offset\n");
+		goto error_reg_offset;
+	}
+
+	if (bhi_off >= mhi_cntrl->reg_len) {
+		dev_err(dev, "BHI offset: 0x%x is out of range: 0x%zx\n",
+			bhi_off, mhi_cntrl->reg_len);
+		ret = -EINVAL;
+		goto error_reg_offset;
+	}
+	mhi_cntrl->bhi = mhi_cntrl->regs + bhi_off;
+
+	if (mhi_cntrl->fbc_download || mhi_cntrl->rddm_size) {
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIEOFF,
+				   &bhie_off);
+		if (ret) {
+			dev_err(dev, "Error getting BHIE offset\n");
+			goto error_reg_offset;
+		}
+
+		if (bhie_off >= mhi_cntrl->reg_len) {
+			dev_err(dev,
+				"BHIe offset: 0x%x is out of range: 0x%zx\n",
+				bhie_off, mhi_cntrl->reg_len);
+			ret = -EINVAL;
+			goto error_reg_offset;
+		}
+		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
+	}
+
+	if (mhi_cntrl->rddm_size) {
+		/*
+		 * This controller supports RDDM, so we need to manually clear
+		 * BHIE RX registers since POR values are undefined.
+		 */
+		memset_io(mhi_cntrl->bhie + BHIE_RXVECADDR_LOW_OFFS,
+			  0, BHIE_RXVECSTATUS_OFFS - BHIE_RXVECADDR_LOW_OFFS +
+			  4);
+		/*
+		 * Allocate RDDM table for debugging purpose if specified
+		 */
+		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
+				     mhi_cntrl->rddm_size);
+		if (mhi_cntrl->rddm_image)
+			mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
+	}
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return 0;
+
+error_reg_offset:
+	mhi_deinit_dev_ctxt(mhi_cntrl);
+
+error_dev_ctxt:
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_prepare_for_power_up);
+
+void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
+{
+	if (mhi_cntrl->fbc_image) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+		mhi_cntrl->fbc_image = NULL;
+	}
+
+	if (mhi_cntrl->rddm_image) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->rddm_image);
+		mhi_cntrl->rddm_image = NULL;
+	}
+
+	mhi_cntrl->bhi = NULL;
+	mhi_cntrl->bhie = NULL;
+
+	mhi_deinit_dev_ctxt(mhi_cntrl);
+}
+EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
+
+static void mhi_release_device(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+
+	/*
+	 * We need to set the mhi_chan->mhi_dev to NULL here since the MHI
+	 * devices for the channels will only get created if the mhi_dev
+	 * associated with it is NULL. This scenario will happen during the
+	 * controller suspend and resume.
+	 */
+	if (mhi_dev->ul_chan)
+		mhi_dev->ul_chan->mhi_dev = NULL;
+
+	if (mhi_dev->dl_chan)
+		mhi_dev->dl_chan->mhi_dev = NULL;
+
+	kfree(mhi_dev);
+}
+
+struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_device *mhi_dev;
+	struct device *dev;
+
+	mhi_dev = kzalloc(sizeof(*mhi_dev), GFP_KERNEL);
+	if (!mhi_dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &mhi_dev->dev;
+	device_initialize(dev);
+	dev->bus = &mhi_bus_type;
+	dev->release = mhi_release_device;
+
+	if (mhi_cntrl->mhi_dev) {
+		/* for MHI client devices, parent is the MHI controller device */
+		dev->parent = &mhi_cntrl->mhi_dev->dev;
+	} else {
+		/* for MHI controller device, parent is the bus device (e.g. pci device) */
+		dev->parent = mhi_cntrl->cntrl_dev;
+	}
+
+	mhi_dev->mhi_cntrl = mhi_cntrl;
+	mhi_dev->dev_wake = 0;
+
+	return mhi_dev;
+}
+
+static int mhi_driver_probe(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct device_driver *drv = dev->driver;
+	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
+	struct mhi_event *mhi_event;
+	struct mhi_chan *ul_chan = mhi_dev->ul_chan;
+	struct mhi_chan *dl_chan = mhi_dev->dl_chan;
+	int ret;
+
+	/* Bring device out of LPM */
+	ret = mhi_device_get_sync(mhi_dev);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
+
+	if (ul_chan) {
+		/*
+		 * If channel supports LPM notifications then status_cb should
+		 * be provided
+		 */
+		if (ul_chan->lpm_notify && !mhi_drv->status_cb)
+			goto exit_probe;
+
+		/* For non-offload channels then xfer_cb should be provided */
+		if (!ul_chan->offload_ch && !mhi_drv->ul_xfer_cb)
+			goto exit_probe;
+
+		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
+	}
+
+	ret = -EINVAL;
+	if (dl_chan) {
+		/*
+		 * If channel supports LPM notifications then status_cb should
+		 * be provided
+		 */
+		if (dl_chan->lpm_notify && !mhi_drv->status_cb)
+			goto exit_probe;
+
+		/* For non-offload channels then xfer_cb should be provided */
+		if (!dl_chan->offload_ch && !mhi_drv->dl_xfer_cb)
+			goto exit_probe;
+
+		mhi_event = &mhi_cntrl->mhi_event[dl_chan->er_index];
+
+		/*
+		 * If the channel event ring is managed by client, then
+		 * status_cb must be provided so that the framework can
+		 * notify pending data
+		 */
+		if (mhi_event->cl_manage && !mhi_drv->status_cb)
+			goto exit_probe;
+
+		dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
+	}
+
+	/* Call the user provided probe function */
+	ret = mhi_drv->probe(mhi_dev, mhi_dev->id);
+	if (ret)
+		goto exit_probe;
+
+	mhi_device_put(mhi_dev);
+
+	return ret;
+
+exit_probe:
+	mhi_unprepare_from_transfer(mhi_dev);
+
+	mhi_device_put(mhi_dev);
+
+	return ret;
+}
+
+static int mhi_driver_remove(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_driver *mhi_drv = to_mhi_driver(dev->driver);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	enum mhi_ch_state ch_state[] = {
+		MHI_CH_STATE_DISABLED,
+		MHI_CH_STATE_DISABLED
+	};
+	int dir;
+
+	/* Skip if it is a controller device */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	/* Reset both channels */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		/* Wake all threads waiting for completion */
+		write_lock_irq(&mhi_chan->lock);
+		mhi_chan->ccs = MHI_EV_CC_INVALID;
+		complete_all(&mhi_chan->completion);
+		write_unlock_irq(&mhi_chan->lock);
+
+		/* Set the channel state to disabled */
+		mutex_lock(&mhi_chan->mutex);
+		write_lock_irq(&mhi_chan->lock);
+		ch_state[dir] = mhi_chan->ch_state;
+		mhi_chan->ch_state = MHI_CH_STATE_SUSPENDED;
+		write_unlock_irq(&mhi_chan->lock);
+
+		/* Reset the non-offload channel */
+		if (!mhi_chan->offload_ch)
+			mhi_reset_chan(mhi_cntrl, mhi_chan);
+
+		mutex_unlock(&mhi_chan->mutex);
+	}
+
+	mhi_drv->remove(mhi_dev);
+
+	/* De-init channel if it was enabled */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		mutex_lock(&mhi_chan->mutex);
+
+		if ((ch_state[dir] == MHI_CH_STATE_ENABLED ||
+		     ch_state[dir] == MHI_CH_STATE_STOP) &&
+		    !mhi_chan->offload_ch)
+			mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+
+		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+
+		mutex_unlock(&mhi_chan->mutex);
+	}
+
+	while (mhi_dev->dev_wake)
+		mhi_device_put(mhi_dev);
+
+	return 0;
+}
+
+int __mhi_driver_register(struct mhi_driver *mhi_drv, struct module *owner)
+{
+	struct device_driver *driver = &mhi_drv->driver;
+
+	if (!mhi_drv->probe || !mhi_drv->remove)
+		return -EINVAL;
+
+	driver->bus = &mhi_bus_type;
+	driver->owner = owner;
+	driver->probe = mhi_driver_probe;
+	driver->remove = mhi_driver_remove;
+
+	return driver_register(driver);
+}
+EXPORT_SYMBOL_GPL(__mhi_driver_register);
+
+void mhi_driver_unregister(struct mhi_driver *mhi_drv)
+{
+	driver_unregister(&mhi_drv->driver);
+}
+EXPORT_SYMBOL_GPL(mhi_driver_unregister);
+
+static int mhi_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+
+	return add_uevent_var(env, "MODALIAS=" MHI_DEVICE_MODALIAS_FMT,
+					mhi_dev->name);
+}
+
+static int mhi_match(struct device *dev, struct device_driver *drv)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
+	const struct mhi_device_id *id;
+
+	/*
+	 * If the device is a controller type then there is no client driver
+	 * associated with it
+	 */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	for (id = mhi_drv->id_table; id->chan[0]; id++)
+		if (!strcmp(mhi_dev->name, id->chan)) {
+			mhi_dev->id = id;
+			return 1;
+		}
+
+	return 0;
+};
+
+struct bus_type mhi_bus_type = {
+	.name = "mhi",
+	.dev_name = "mhi",
+	.match = mhi_match,
+	.uevent = mhi_uevent,
+	.dev_groups = mhi_dev_groups,
+};
+
+static int __init mhi_init(void)
+{
+	mhi_debugfs_init();
+	return bus_register(&mhi_bus_type);
+}
+
+static void __exit mhi_exit(void)
+{
+	mhi_debugfs_exit();
+	bus_unregister(&mhi_bus_type);
+}
+
+postcore_initcall(mhi_init);
+module_exit(mhi_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MHI Host Interface");
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
new file mode 100644
index 000000000000..71f181402be9
--- /dev/null
+++ b/drivers/bus/mhi/host/internal.h
@@ -0,0 +1,718 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#ifndef _MHI_INT_H
+#define _MHI_INT_H
+
+#include <linux/mhi.h>
+
+extern struct bus_type mhi_bus_type;
+
+#define MHIREGLEN (0x0)
+#define MHIREGLEN_MHIREGLEN_MASK (0xFFFFFFFF)
+#define MHIREGLEN_MHIREGLEN_SHIFT (0)
+
+#define MHIVER (0x8)
+#define MHIVER_MHIVER_MASK (0xFFFFFFFF)
+#define MHIVER_MHIVER_SHIFT (0)
+
+#define MHICFG (0x10)
+#define MHICFG_NHWER_MASK (0xFF000000)
+#define MHICFG_NHWER_SHIFT (24)
+#define MHICFG_NER_MASK (0xFF0000)
+#define MHICFG_NER_SHIFT (16)
+#define MHICFG_NHWCH_MASK (0xFF00)
+#define MHICFG_NHWCH_SHIFT (8)
+#define MHICFG_NCH_MASK (0xFF)
+#define MHICFG_NCH_SHIFT (0)
+
+#define CHDBOFF (0x18)
+#define CHDBOFF_CHDBOFF_MASK (0xFFFFFFFF)
+#define CHDBOFF_CHDBOFF_SHIFT (0)
+
+#define ERDBOFF (0x20)
+#define ERDBOFF_ERDBOFF_MASK (0xFFFFFFFF)
+#define ERDBOFF_ERDBOFF_SHIFT (0)
+
+#define BHIOFF (0x28)
+#define BHIOFF_BHIOFF_MASK (0xFFFFFFFF)
+#define BHIOFF_BHIOFF_SHIFT (0)
+
+#define BHIEOFF (0x2C)
+#define BHIEOFF_BHIEOFF_MASK (0xFFFFFFFF)
+#define BHIEOFF_BHIEOFF_SHIFT (0)
+
+#define DEBUGOFF (0x30)
+#define DEBUGOFF_DEBUGOFF_MASK (0xFFFFFFFF)
+#define DEBUGOFF_DEBUGOFF_SHIFT (0)
+
+#define MHICTRL (0x38)
+#define MHICTRL_MHISTATE_MASK (0x0000FF00)
+#define MHICTRL_MHISTATE_SHIFT (8)
+#define MHICTRL_RESET_MASK (0x2)
+#define MHICTRL_RESET_SHIFT (1)
+
+#define MHISTATUS (0x48)
+#define MHISTATUS_MHISTATE_MASK (0x0000FF00)
+#define MHISTATUS_MHISTATE_SHIFT (8)
+#define MHISTATUS_SYSERR_MASK (0x4)
+#define MHISTATUS_SYSERR_SHIFT (2)
+#define MHISTATUS_READY_MASK (0x1)
+#define MHISTATUS_READY_SHIFT (0)
+
+#define CCABAP_LOWER (0x58)
+#define CCABAP_LOWER_CCABAP_LOWER_MASK (0xFFFFFFFF)
+#define CCABAP_LOWER_CCABAP_LOWER_SHIFT (0)
+
+#define CCABAP_HIGHER (0x5C)
+#define CCABAP_HIGHER_CCABAP_HIGHER_MASK (0xFFFFFFFF)
+#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT (0)
+
+#define ECABAP_LOWER (0x60)
+#define ECABAP_LOWER_ECABAP_LOWER_MASK (0xFFFFFFFF)
+#define ECABAP_LOWER_ECABAP_LOWER_SHIFT (0)
+
+#define ECABAP_HIGHER (0x64)
+#define ECABAP_HIGHER_ECABAP_HIGHER_MASK (0xFFFFFFFF)
+#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT (0)
+
+#define CRCBAP_LOWER (0x68)
+#define CRCBAP_LOWER_CRCBAP_LOWER_MASK (0xFFFFFFFF)
+#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT (0)
+
+#define CRCBAP_HIGHER (0x6C)
+#define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK (0xFFFFFFFF)
+#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT (0)
+
+#define CRDB_LOWER (0x70)
+#define CRDB_LOWER_CRDB_LOWER_MASK (0xFFFFFFFF)
+#define CRDB_LOWER_CRDB_LOWER_SHIFT (0)
+
+#define CRDB_HIGHER (0x74)
+#define CRDB_HIGHER_CRDB_HIGHER_MASK (0xFFFFFFFF)
+#define CRDB_HIGHER_CRDB_HIGHER_SHIFT (0)
+
+#define MHICTRLBASE_LOWER (0x80)
+#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK (0xFFFFFFFF)
+#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT (0)
+
+#define MHICTRLBASE_HIGHER (0x84)
+#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK (0xFFFFFFFF)
+#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT (0)
+
+#define MHICTRLLIMIT_LOWER (0x88)
+#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK (0xFFFFFFFF)
+#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT (0)
+
+#define MHICTRLLIMIT_HIGHER (0x8C)
+#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK (0xFFFFFFFF)
+#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT (0)
+
+#define MHIDATABASE_LOWER (0x98)
+#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK (0xFFFFFFFF)
+#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT (0)
+
+#define MHIDATABASE_HIGHER (0x9C)
+#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK (0xFFFFFFFF)
+#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT (0)
+
+#define MHIDATALIMIT_LOWER (0xA0)
+#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK (0xFFFFFFFF)
+#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT (0)
+
+#define MHIDATALIMIT_HIGHER (0xA4)
+#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK (0xFFFFFFFF)
+#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT (0)
+
+/* Host request register */
+#define MHI_SOC_RESET_REQ_OFFSET (0xB0)
+#define MHI_SOC_RESET_REQ BIT(0)
+
+/* MHI BHI offfsets */
+#define BHI_BHIVERSION_MINOR (0x00)
+#define BHI_BHIVERSION_MAJOR (0x04)
+#define BHI_IMGADDR_LOW (0x08)
+#define BHI_IMGADDR_HIGH (0x0C)
+#define BHI_IMGSIZE (0x10)
+#define BHI_RSVD1 (0x14)
+#define BHI_IMGTXDB (0x18)
+#define BHI_TXDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHI_TXDB_SEQNUM_SHFT (0)
+#define BHI_RSVD2 (0x1C)
+#define BHI_INTVEC (0x20)
+#define BHI_RSVD3 (0x24)
+#define BHI_EXECENV (0x28)
+#define BHI_STATUS (0x2C)
+#define BHI_ERRCODE (0x30)
+#define BHI_ERRDBG1 (0x34)
+#define BHI_ERRDBG2 (0x38)
+#define BHI_ERRDBG3 (0x3C)
+#define BHI_SERIALNU (0x40)
+#define BHI_SBLANTIROLLVER (0x44)
+#define BHI_NUMSEG (0x48)
+#define BHI_MSMHWID(n) (0x4C + (0x4 * (n)))
+#define BHI_OEMPKHASH(n) (0x64 + (0x4 * (n)))
+#define BHI_RSVD5 (0xC4)
+#define BHI_STATUS_MASK (0xC0000000)
+#define BHI_STATUS_SHIFT (30)
+#define BHI_STATUS_ERROR (3)
+#define BHI_STATUS_SUCCESS (2)
+#define BHI_STATUS_RESET (0)
+
+/* MHI BHIE offsets */
+#define BHIE_MSMSOCID_OFFS (0x0000)
+#define BHIE_TXVECADDR_LOW_OFFS (0x002C)
+#define BHIE_TXVECADDR_HIGH_OFFS (0x0030)
+#define BHIE_TXVECSIZE_OFFS (0x0034)
+#define BHIE_TXVECDB_OFFS (0x003C)
+#define BHIE_TXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_TXVECDB_SEQNUM_SHFT (0)
+#define BHIE_TXVECSTATUS_OFFS (0x0044)
+#define BHIE_TXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_TXVECSTATUS_SEQNUM_SHFT (0)
+#define BHIE_TXVECSTATUS_STATUS_BMSK (0xC0000000)
+#define BHIE_TXVECSTATUS_STATUS_SHFT (30)
+#define BHIE_TXVECSTATUS_STATUS_RESET (0x00)
+#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL (0x02)
+#define BHIE_TXVECSTATUS_STATUS_ERROR (0x03)
+#define BHIE_RXVECADDR_LOW_OFFS (0x0060)
+#define BHIE_RXVECADDR_HIGH_OFFS (0x0064)
+#define BHIE_RXVECSIZE_OFFS (0x0068)
+#define BHIE_RXVECDB_OFFS (0x0070)
+#define BHIE_RXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_RXVECDB_SEQNUM_SHFT (0)
+#define BHIE_RXVECSTATUS_OFFS (0x0078)
+#define BHIE_RXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_RXVECSTATUS_SEQNUM_SHFT (0)
+#define BHIE_RXVECSTATUS_STATUS_BMSK (0xC0000000)
+#define BHIE_RXVECSTATUS_STATUS_SHFT (30)
+#define BHIE_RXVECSTATUS_STATUS_RESET (0x00)
+#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL (0x02)
+#define BHIE_RXVECSTATUS_STATUS_ERROR (0x03)
+
+#define SOC_HW_VERSION_OFFS (0x224)
+#define SOC_HW_VERSION_FAM_NUM_BMSK (0xF0000000)
+#define SOC_HW_VERSION_FAM_NUM_SHFT (28)
+#define SOC_HW_VERSION_DEV_NUM_BMSK (0x0FFF0000)
+#define SOC_HW_VERSION_DEV_NUM_SHFT (16)
+#define SOC_HW_VERSION_MAJOR_VER_BMSK (0x0000FF00)
+#define SOC_HW_VERSION_MAJOR_VER_SHFT (8)
+#define SOC_HW_VERSION_MINOR_VER_BMSK (0x000000FF)
+#define SOC_HW_VERSION_MINOR_VER_SHFT (0)
+
+#define EV_CTX_RESERVED_MASK GENMASK(7, 0)
+#define EV_CTX_INTMODC_MASK GENMASK(15, 8)
+#define EV_CTX_INTMODC_SHIFT 8
+#define EV_CTX_INTMODT_MASK GENMASK(31, 16)
+#define EV_CTX_INTMODT_SHIFT 16
+struct mhi_event_ctxt {
+	__le32 intmod;
+	__le32 ertype;
+	__le32 msivec;
+
+	__le64 rbase __packed __aligned(4);
+	__le64 rlen __packed __aligned(4);
+	__le64 rp __packed __aligned(4);
+	__le64 wp __packed __aligned(4);
+};
+
+#define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
+#define CHAN_CTX_CHSTATE_SHIFT 0
+#define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
+#define CHAN_CTX_BRSTMODE_SHIFT 8
+#define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
+#define CHAN_CTX_POLLCFG_SHIFT 10
+#define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
+struct mhi_chan_ctxt {
+	__le32 chcfg;
+	__le32 chtype;
+	__le32 erindex;
+
+	__le64 rbase __packed __aligned(4);
+	__le64 rlen __packed __aligned(4);
+	__le64 rp __packed __aligned(4);
+	__le64 wp __packed __aligned(4);
+};
+
+struct mhi_cmd_ctxt {
+	__le32 reserved0;
+	__le32 reserved1;
+	__le32 reserved2;
+
+	__le64 rbase __packed __aligned(4);
+	__le64 rlen __packed __aligned(4);
+	__le64 rp __packed __aligned(4);
+	__le64 wp __packed __aligned(4);
+};
+
+struct mhi_ctxt {
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_chan_ctxt *chan_ctxt;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	dma_addr_t er_ctxt_addr;
+	dma_addr_t chan_ctxt_addr;
+	dma_addr_t cmd_ctxt_addr;
+};
+
+struct mhi_tre {
+	__le64 ptr;
+	__le32 dword[2];
+};
+
+struct bhi_vec_entry {
+	u64 dma_addr;
+	u64 size;
+};
+
+enum mhi_cmd_type {
+	MHI_CMD_NOP = 1,
+	MHI_CMD_RESET_CHAN = 16,
+	MHI_CMD_STOP_CHAN = 17,
+	MHI_CMD_START_CHAN = 18,
+};
+
+/* No operation command */
+#define MHI_TRE_CMD_NOOP_PTR (0)
+#define MHI_TRE_CMD_NOOP_DWORD0 (0)
+#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(MHI_CMD_NOP << 16))
+
+/* Channel reset command */
+#define MHI_TRE_CMD_RESET_PTR (0)
+#define MHI_TRE_CMD_RESET_DWORD0 (0)
+#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32((chid << 24) | \
+					(MHI_CMD_RESET_CHAN << 16)))
+
+/* Channel stop command */
+#define MHI_TRE_CMD_STOP_PTR (0)
+#define MHI_TRE_CMD_STOP_DWORD0 (0)
+#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32((chid << 24) | \
+				       (MHI_CMD_STOP_CHAN << 16)))
+
+/* Channel start command */
+#define MHI_TRE_CMD_START_PTR (0)
+#define MHI_TRE_CMD_START_DWORD0 (0)
+#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32((chid << 24) | \
+					(MHI_CMD_START_CHAN << 16)))
+
+#define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
+#define MHI_TRE_GET_CMD_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
+#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
+
+/* Event descriptor macros */
+#define MHI_TRE_EV_PTR(ptr) (cpu_to_le64(ptr))
+#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32((code << 24) | len))
+#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32((chid << 24) | (type << 16)))
+#define MHI_TRE_GET_EV_PTR(tre) (le64_to_cpu((tre)->ptr))
+#define MHI_TRE_GET_EV_CODE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_LEN(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFFFF)
+#define MHI_TRE_GET_EV_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
+#define MHI_TRE_GET_EV_STATE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_EXECENV(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_SEQ(tre) MHI_TRE_GET_DWORD(tre, 0)
+#define MHI_TRE_GET_EV_TIME(tre) (MHI_TRE_GET_EV_PTR(tre))
+#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
+#define MHI_TRE_GET_EV_VEID(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 16) & 0xFF)
+#define MHI_TRE_GET_EV_LINKSPEED(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_LINKWIDTH(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
+
+/* Transfer descriptor macros */
+#define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
+#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(len & MHI_MAX_MTU))
+#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32((2 << 16) | (bei << 10) \
+	| (ieot << 9) | (ieob << 8) | chain))
+
+/* RSC transfer descriptor macros */
+#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(((u64)len << 48) | ptr))
+#define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
+#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16))
+
+enum mhi_pkt_type {
+	MHI_PKT_TYPE_INVALID = 0x0,
+	MHI_PKT_TYPE_NOOP_CMD = 0x1,
+	MHI_PKT_TYPE_TRANSFER = 0x2,
+	MHI_PKT_TYPE_COALESCING = 0x8,
+	MHI_PKT_TYPE_RESET_CHAN_CMD = 0x10,
+	MHI_PKT_TYPE_STOP_CHAN_CMD = 0x11,
+	MHI_PKT_TYPE_START_CHAN_CMD = 0x12,
+	MHI_PKT_TYPE_STATE_CHANGE_EVENT = 0x20,
+	MHI_PKT_TYPE_CMD_COMPLETION_EVENT = 0x21,
+	MHI_PKT_TYPE_TX_EVENT = 0x22,
+	MHI_PKT_TYPE_RSC_TX_EVENT = 0x28,
+	MHI_PKT_TYPE_EE_EVENT = 0x40,
+	MHI_PKT_TYPE_TSYNC_EVENT = 0x48,
+	MHI_PKT_TYPE_BW_REQ_EVENT = 0x50,
+	MHI_PKT_TYPE_STALE_EVENT, /* internal event */
+};
+
+/* MHI transfer completion events */
+enum mhi_ev_ccs {
+	MHI_EV_CC_INVALID = 0x0,
+	MHI_EV_CC_SUCCESS = 0x1,
+	MHI_EV_CC_EOT = 0x2, /* End of transfer event */
+	MHI_EV_CC_OVERFLOW = 0x3,
+	MHI_EV_CC_EOB = 0x4, /* End of block event */
+	MHI_EV_CC_OOB = 0x5, /* Out of block event */
+	MHI_EV_CC_DB_MODE = 0x6,
+	MHI_EV_CC_UNDEFINED_ERR = 0x10,
+	MHI_EV_CC_BAD_TRE = 0x11,
+};
+
+enum mhi_ch_state {
+	MHI_CH_STATE_DISABLED = 0x0,
+	MHI_CH_STATE_ENABLED = 0x1,
+	MHI_CH_STATE_RUNNING = 0x2,
+	MHI_CH_STATE_SUSPENDED = 0x3,
+	MHI_CH_STATE_STOP = 0x4,
+	MHI_CH_STATE_ERROR = 0x5,
+};
+
+enum mhi_ch_state_type {
+	MHI_CH_STATE_TYPE_RESET,
+	MHI_CH_STATE_TYPE_STOP,
+	MHI_CH_STATE_TYPE_START,
+	MHI_CH_STATE_TYPE_MAX,
+};
+
+extern const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX];
+#define TO_CH_STATE_TYPE_STR(state) (((state) >= MHI_CH_STATE_TYPE_MAX) ? \
+				     "INVALID_STATE" : \
+				     mhi_ch_state_type_str[(state)])
+
+#define MHI_INVALID_BRSTMODE(mode) (mode != MHI_DB_BRST_DISABLE && \
+				    mode != MHI_DB_BRST_ENABLE)
+
+extern const char * const mhi_ee_str[MHI_EE_MAX];
+#define TO_MHI_EXEC_STR(ee) (((ee) >= MHI_EE_MAX) ? \
+			     "INVALID_EE" : mhi_ee_str[ee])
+
+#define MHI_IN_PBL(ee) (ee == MHI_EE_PBL || ee == MHI_EE_PTHRU || \
+			ee == MHI_EE_EDL)
+
+#define MHI_IN_MISSION_MODE(ee) (ee == MHI_EE_AMSS || ee == MHI_EE_WFW || \
+				 ee == MHI_EE_FP)
+
+enum dev_st_transition {
+	DEV_ST_TRANSITION_PBL,
+	DEV_ST_TRANSITION_READY,
+	DEV_ST_TRANSITION_SBL,
+	DEV_ST_TRANSITION_MISSION_MODE,
+	DEV_ST_TRANSITION_FP,
+	DEV_ST_TRANSITION_SYS_ERR,
+	DEV_ST_TRANSITION_DISABLE,
+	DEV_ST_TRANSITION_MAX,
+};
+
+extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
+#define TO_DEV_STATE_TRANS_STR(state) (((state) >= DEV_ST_TRANSITION_MAX) ? \
+				"INVALID_STATE" : dev_state_tran_str[state])
+
+extern const char * const mhi_state_str[MHI_STATE_MAX];
+#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
+				  !mhi_state_str[state]) ? \
+				"INVALID_STATE" : mhi_state_str[state])
+
+/* internal power states */
+enum mhi_pm_state {
+	MHI_PM_STATE_DISABLE,
+	MHI_PM_STATE_POR,
+	MHI_PM_STATE_M0,
+	MHI_PM_STATE_M2,
+	MHI_PM_STATE_M3_ENTER,
+	MHI_PM_STATE_M3,
+	MHI_PM_STATE_M3_EXIT,
+	MHI_PM_STATE_FW_DL_ERR,
+	MHI_PM_STATE_SYS_ERR_DETECT,
+	MHI_PM_STATE_SYS_ERR_PROCESS,
+	MHI_PM_STATE_SHUTDOWN_PROCESS,
+	MHI_PM_STATE_LD_ERR_FATAL_DETECT,
+	MHI_PM_STATE_MAX
+};
+
+#define MHI_PM_DISABLE			BIT(0)
+#define MHI_PM_POR			BIT(1)
+#define MHI_PM_M0			BIT(2)
+#define MHI_PM_M2			BIT(3)
+#define MHI_PM_M3_ENTER			BIT(4)
+#define MHI_PM_M3			BIT(5)
+#define MHI_PM_M3_EXIT			BIT(6)
+/* firmware download failure state */
+#define MHI_PM_FW_DL_ERR		BIT(7)
+#define MHI_PM_SYS_ERR_DETECT		BIT(8)
+#define MHI_PM_SYS_ERR_PROCESS		BIT(9)
+#define MHI_PM_SHUTDOWN_PROCESS		BIT(10)
+/* link not accessible */
+#define MHI_PM_LD_ERR_FATAL_DETECT	BIT(11)
+
+#define MHI_REG_ACCESS_VALID(pm_state) ((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
+		MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
+#define MHI_PM_IN_ERROR_STATE(pm_state) (pm_state >= MHI_PM_FW_DL_ERR)
+#define MHI_PM_IN_FATAL_STATE(pm_state) (pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
+#define MHI_DB_ACCESS_VALID(mhi_cntrl) (mhi_cntrl->pm_state & \
+					mhi_cntrl->db_access)
+#define MHI_WAKE_DB_CLEAR_VALID(pm_state) (pm_state & (MHI_PM_M0 | \
+						MHI_PM_M2 | MHI_PM_M3_EXIT))
+#define MHI_WAKE_DB_SET_VALID(pm_state) (pm_state & MHI_PM_M2)
+#define MHI_WAKE_DB_FORCE_SET_VALID(pm_state) MHI_WAKE_DB_CLEAR_VALID(pm_state)
+#define MHI_EVENT_ACCESS_INVALID(pm_state) (pm_state == MHI_PM_DISABLE || \
+					    MHI_PM_IN_ERROR_STATE(pm_state))
+#define MHI_PM_IN_SUSPEND_STATE(pm_state) (pm_state & \
+					   (MHI_PM_M3_ENTER | MHI_PM_M3))
+
+#define NR_OF_CMD_RINGS			1
+#define CMD_EL_PER_RING			128
+#define PRIMARY_CMD_RING		0
+#define MHI_DEV_WAKE_DB			127
+#define MHI_MAX_MTU			0xffff
+#define MHI_RANDOM_U32_NONZERO(bmsk)	(prandom_u32_max(bmsk) + 1)
+
+enum mhi_er_type {
+	MHI_ER_TYPE_INVALID = 0x0,
+	MHI_ER_TYPE_VALID = 0x1,
+};
+
+struct db_cfg {
+	bool reset_req;
+	bool db_mode;
+	u32 pollcfg;
+	enum mhi_db_brst_mode brstmode;
+	dma_addr_t db_val;
+	void (*process_db)(struct mhi_controller *mhi_cntrl,
+			   struct db_cfg *db_cfg, void __iomem *io_addr,
+			   dma_addr_t db_val);
+};
+
+struct mhi_pm_transitions {
+	enum mhi_pm_state from_state;
+	u32 to_states;
+};
+
+struct state_transition {
+	struct list_head node;
+	enum dev_st_transition state;
+};
+
+struct mhi_ring {
+	dma_addr_t dma_handle;
+	dma_addr_t iommu_base;
+	__le64 *ctxt_wp; /* point to ctxt wp */
+	void *pre_aligned;
+	void *base;
+	void *rp;
+	void *wp;
+	size_t el_size;
+	size_t len;
+	size_t elements;
+	size_t alloc_size;
+	void __iomem *db_addr;
+};
+
+struct mhi_cmd {
+	struct mhi_ring ring;
+	spinlock_t lock;
+};
+
+struct mhi_buf_info {
+	void *v_addr;
+	void *bb_addr;
+	void *wp;
+	void *cb_buf;
+	dma_addr_t p_addr;
+	size_t len;
+	enum dma_data_direction dir;
+	bool used; /* Indicates whether the buffer is used or not */
+	bool pre_mapped; /* Already pre-mapped by client */
+};
+
+struct mhi_event {
+	struct mhi_controller *mhi_cntrl;
+	struct mhi_chan *mhi_chan; /* dedicated to channel */
+	u32 er_index;
+	u32 intmod;
+	u32 irq;
+	int chan; /* this event ring is dedicated to a channel (optional) */
+	u32 priority;
+	enum mhi_er_data_type data_type;
+	struct mhi_ring ring;
+	struct db_cfg db_cfg;
+	struct tasklet_struct task;
+	spinlock_t lock;
+	int (*process_event)(struct mhi_controller *mhi_cntrl,
+			     struct mhi_event *mhi_event,
+			     u32 event_quota);
+	bool hw_ring;
+	bool cl_manage;
+	bool offload_ev; /* managed by a device driver */
+};
+
+struct mhi_chan {
+	const char *name;
+	/*
+	 * Important: When consuming, increment tre_ring first and when
+	 * releasing, decrement buf_ring first. If tre_ring has space, buf_ring
+	 * is guranteed to have space so we do not need to check both rings.
+	 */
+	struct mhi_ring buf_ring;
+	struct mhi_ring tre_ring;
+	u32 chan;
+	u32 er_index;
+	u32 intmod;
+	enum mhi_ch_type type;
+	enum dma_data_direction dir;
+	struct db_cfg db_cfg;
+	enum mhi_ch_ee_mask ee_mask;
+	enum mhi_ch_state ch_state;
+	enum mhi_ev_ccs ccs;
+	struct mhi_device *mhi_dev;
+	void (*xfer_cb)(struct mhi_device *mhi_dev, struct mhi_result *result);
+	struct mutex mutex;
+	struct completion completion;
+	rwlock_t lock;
+	struct list_head node;
+	bool lpm_notify;
+	bool configured;
+	bool offload_ch;
+	bool pre_alloc;
+	bool wake_capable;
+};
+
+/* Default MHI timeout */
+#define MHI_TIMEOUT_MS (1000)
+
+/* debugfs related functions */
+#ifdef CONFIG_MHI_BUS_DEBUG
+void mhi_create_debugfs(struct mhi_controller *mhi_cntrl);
+void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl);
+void mhi_debugfs_init(void);
+void mhi_debugfs_exit(void);
+#else
+static inline void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
+{
+}
+
+static inline void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl)
+{
+}
+
+static inline void mhi_debugfs_init(void)
+{
+}
+
+static inline void mhi_debugfs_exit(void)
+{
+}
+#endif
+
+struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl);
+
+int mhi_destroy_device(struct device *dev, void *data);
+void mhi_create_devices(struct mhi_controller *mhi_cntrl);
+
+int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info **image_info, size_t alloc_size);
+void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info *image_info);
+
+/* Power management APIs */
+enum mhi_pm_state __must_check mhi_tryset_pm_state(
+					struct mhi_controller *mhi_cntrl,
+					enum mhi_pm_state state);
+const char *to_mhi_pm_state_str(u32 state);
+int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
+			       enum dev_st_transition state);
+void mhi_pm_st_worker(struct work_struct *work);
+void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl);
+int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
+int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
+void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
+int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
+int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl);
+int mhi_send_cmd(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
+		 enum mhi_cmd_type cmd);
+int mhi_download_amss_image(struct mhi_controller *mhi_cntrl);
+static inline bool mhi_is_active(struct mhi_controller *mhi_cntrl)
+{
+	return (mhi_cntrl->dev_state >= MHI_STATE_M0 &&
+		mhi_cntrl->dev_state <= MHI_STATE_M3_FAST);
+}
+
+static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
+{
+	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
+	mhi_cntrl->runtime_get(mhi_cntrl);
+	mhi_cntrl->runtime_put(mhi_cntrl);
+}
+
+/* Register access methods */
+void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct db_cfg *db_cfg,
+		     void __iomem *db_addr, dma_addr_t db_val);
+void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
+			     struct db_cfg *db_mode, void __iomem *db_addr,
+			     dma_addr_t db_val);
+int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *base, u32 offset, u32 *out);
+int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
+				    void __iomem *base, u32 offset, u32 mask,
+				    u32 shift, u32 *out);
+int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
+				    void __iomem *base, u32 offset, u32 mask,
+				    u32 shift, u32 val, u32 delayus);
+void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
+		   u32 offset, u32 val);
+void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
+			 u32 offset, u32 mask, u32 shift, u32 val);
+void mhi_ring_er_db(struct mhi_event *mhi_event);
+void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
+		  dma_addr_t db_val);
+void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd);
+void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
+		      struct mhi_chan *mhi_chan);
+
+/* Initialization methods */
+int mhi_init_mmio(struct mhi_controller *mhi_cntrl);
+int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl);
+void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl);
+int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl);
+void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl);
+void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
+		      struct image_info *img_info);
+void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl);
+int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
+			struct mhi_chan *mhi_chan);
+int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
+		       struct mhi_chan *mhi_chan);
+void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
+			  struct mhi_chan *mhi_chan);
+void mhi_reset_chan(struct mhi_controller *mhi_cntrl,
+		    struct mhi_chan *mhi_chan);
+
+/* Event processing methods */
+void mhi_ctrl_ev_task(unsigned long data);
+void mhi_ev_task(unsigned long data);
+int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
+				struct mhi_event *mhi_event, u32 event_quota);
+int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
+			     struct mhi_event *mhi_event, u32 event_quota);
+
+/* ISR handlers */
+irqreturn_t mhi_irq_handler(int irq_number, void *dev);
+irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
+irqreturn_t mhi_intvec_handler(int irq_number, void *dev);
+
+int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
+		struct mhi_buf_info *info, enum mhi_flags flags);
+int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
+			 struct mhi_buf_info *buf_info);
+int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
+			  struct mhi_buf_info *buf_info);
+void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
+			    struct mhi_buf_info *buf_info);
+void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
+			     struct mhi_buf_info *buf_info);
+
+#endif /* _MHI_INT_H */
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
new file mode 100644
index 000000000000..6b3668999942
--- /dev/null
+++ b/drivers/bus/mhi/host/main.c
@@ -0,0 +1,1673 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *base, u32 offset, u32 *out)
+{
+	return mhi_cntrl->read_reg(mhi_cntrl, base + offset, out);
+}
+
+int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
+				    void __iomem *base, u32 offset,
+				    u32 mask, u32 shift, u32 *out)
+{
+	u32 tmp;
+	int ret;
+
+	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
+	if (ret)
+		return ret;
+
+	*out = (tmp & mask) >> shift;
+
+	return 0;
+}
+
+int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
+				    void __iomem *base, u32 offset,
+				    u32 mask, u32 shift, u32 val, u32 delayus)
+{
+	int ret;
+	u32 out, retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
+
+	while (retry--) {
+		ret = mhi_read_reg_field(mhi_cntrl, base, offset, mask, shift,
+					 &out);
+		if (ret)
+			return ret;
+
+		if (out == val)
+			return 0;
+
+		fsleep(delayus);
+	}
+
+	return -ETIMEDOUT;
+}
+
+void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
+		   u32 offset, u32 val)
+{
+	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
+}
+
+void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
+			 u32 offset, u32 mask, u32 shift, u32 val)
+{
+	int ret;
+	u32 tmp;
+
+	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
+	if (ret)
+		return;
+
+	tmp &= ~mask;
+	tmp |= (val << shift);
+	mhi_write_reg(mhi_cntrl, base, offset, tmp);
+}
+
+void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
+		  dma_addr_t db_val)
+{
+	mhi_write_reg(mhi_cntrl, db_addr, 4, upper_32_bits(db_val));
+	mhi_write_reg(mhi_cntrl, db_addr, 0, lower_32_bits(db_val));
+}
+
+void mhi_db_brstmode(struct mhi_controller *mhi_cntrl,
+		     struct db_cfg *db_cfg,
+		     void __iomem *db_addr,
+		     dma_addr_t db_val)
+{
+	if (db_cfg->db_mode) {
+		db_cfg->db_val = db_val;
+		mhi_write_db(mhi_cntrl, db_addr, db_val);
+		db_cfg->db_mode = 0;
+	}
+}
+
+void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
+			     struct db_cfg *db_cfg,
+			     void __iomem *db_addr,
+			     dma_addr_t db_val)
+{
+	db_cfg->db_val = db_val;
+	mhi_write_db(mhi_cntrl, db_addr, db_val);
+}
+
+void mhi_ring_er_db(struct mhi_event *mhi_event)
+{
+	struct mhi_ring *ring = &mhi_event->ring;
+
+	mhi_event->db_cfg.process_db(mhi_event->mhi_cntrl, &mhi_event->db_cfg,
+				     ring->db_addr, le64_to_cpu(*ring->ctxt_wp));
+}
+
+void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd)
+{
+	dma_addr_t db;
+	struct mhi_ring *ring = &mhi_cmd->ring;
+
+	db = ring->iommu_base + (ring->wp - ring->base);
+	*ring->ctxt_wp = cpu_to_le64(db);
+	mhi_write_db(mhi_cntrl, ring->db_addr, db);
+}
+
+void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
+		      struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *ring = &mhi_chan->tre_ring;
+	dma_addr_t db;
+
+	db = ring->iommu_base + (ring->wp - ring->base);
+
+	/*
+	 * Writes to the new ring element must be visible to the hardware
+	 * before letting h/w know there is new element to fetch.
+	 */
+	dma_wmb();
+	*ring->ctxt_wp = cpu_to_le64(db);
+
+	mhi_chan->db_cfg.process_db(mhi_cntrl, &mhi_chan->db_cfg,
+				    ring->db_addr, db);
+}
+
+enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl)
+{
+	u32 exec;
+	int ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_EXECENV, &exec);
+
+	return (ret) ? MHI_EE_MAX : exec;
+}
+EXPORT_SYMBOL_GPL(mhi_get_exec_env);
+
+enum mhi_state mhi_get_mhi_state(struct mhi_controller *mhi_cntrl)
+{
+	u32 state;
+	int ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
+				     MHISTATUS_MHISTATE_MASK,
+				     MHISTATUS_MHISTATE_SHIFT, &state);
+	return ret ? MHI_STATE_MAX : state;
+}
+EXPORT_SYMBOL_GPL(mhi_get_mhi_state);
+
+void mhi_soc_reset(struct mhi_controller *mhi_cntrl)
+{
+	if (mhi_cntrl->reset) {
+		mhi_cntrl->reset(mhi_cntrl);
+		return;
+	}
+
+	/* Generic MHI SoC reset */
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, MHI_SOC_RESET_REQ_OFFSET,
+		      MHI_SOC_RESET_REQ);
+}
+EXPORT_SYMBOL_GPL(mhi_soc_reset);
+
+int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
+			 struct mhi_buf_info *buf_info)
+{
+	buf_info->p_addr = dma_map_single(mhi_cntrl->cntrl_dev,
+					  buf_info->v_addr, buf_info->len,
+					  buf_info->dir);
+	if (dma_mapping_error(mhi_cntrl->cntrl_dev, buf_info->p_addr))
+		return -ENOMEM;
+
+	return 0;
+}
+
+int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
+			  struct mhi_buf_info *buf_info)
+{
+	void *buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev, buf_info->len,
+				       &buf_info->p_addr, GFP_ATOMIC);
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (buf_info->dir == DMA_TO_DEVICE)
+		memcpy(buf, buf_info->v_addr, buf_info->len);
+
+	buf_info->bb_addr = buf;
+
+	return 0;
+}
+
+void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
+			    struct mhi_buf_info *buf_info)
+{
+	dma_unmap_single(mhi_cntrl->cntrl_dev, buf_info->p_addr, buf_info->len,
+			 buf_info->dir);
+}
+
+void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
+			     struct mhi_buf_info *buf_info)
+{
+	if (buf_info->dir == DMA_FROM_DEVICE)
+		memcpy(buf_info->v_addr, buf_info->bb_addr, buf_info->len);
+
+	dma_free_coherent(mhi_cntrl->cntrl_dev, buf_info->len,
+			  buf_info->bb_addr, buf_info->p_addr);
+}
+
+static int get_nr_avail_ring_elements(struct mhi_controller *mhi_cntrl,
+				      struct mhi_ring *ring)
+{
+	int nr_el;
+
+	if (ring->wp < ring->rp) {
+		nr_el = ((ring->rp - ring->wp) / ring->el_size) - 1;
+	} else {
+		nr_el = (ring->rp - ring->base) / ring->el_size;
+		nr_el += ((ring->base + ring->len - ring->wp) /
+			  ring->el_size) - 1;
+	}
+
+	return nr_el;
+}
+
+static void *mhi_to_virtual(struct mhi_ring *ring, dma_addr_t addr)
+{
+	return (addr - ring->iommu_base) + ring->base;
+}
+
+static void mhi_add_ring_element(struct mhi_controller *mhi_cntrl,
+				 struct mhi_ring *ring)
+{
+	ring->wp += ring->el_size;
+	if (ring->wp >= (ring->base + ring->len))
+		ring->wp = ring->base;
+	/* smp update */
+	smp_wmb();
+}
+
+static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
+				 struct mhi_ring *ring)
+{
+	ring->rp += ring->el_size;
+	if (ring->rp >= (ring->base + ring->len))
+		ring->rp = ring->base;
+	/* smp update */
+	smp_wmb();
+}
+
+static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
+{
+	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
+}
+
+int mhi_destroy_device(struct device *dev, void *data)
+{
+	struct mhi_chan *ul_chan, *dl_chan;
+	struct mhi_device *mhi_dev;
+	struct mhi_controller *mhi_cntrl;
+	enum mhi_ee_type ee = MHI_EE_MAX;
+
+	if (dev->bus != &mhi_bus_type)
+		return 0;
+
+	mhi_dev = to_mhi_device(dev);
+	mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	/* Only destroy virtual devices thats attached to bus */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	ul_chan = mhi_dev->ul_chan;
+	dl_chan = mhi_dev->dl_chan;
+
+	/*
+	 * If execution environment is specified, remove only those devices that
+	 * started in them based on ee_mask for the channels as we move on to a
+	 * different execution environment
+	 */
+	if (data)
+		ee = *(enum mhi_ee_type *)data;
+
+	/*
+	 * For the suspend and resume case, this function will get called
+	 * without mhi_unregister_controller(). Hence, we need to drop the
+	 * references to mhi_dev created for ul and dl channels. We can
+	 * be sure that there will be no instances of mhi_dev left after
+	 * this.
+	 */
+	if (ul_chan) {
+		if (ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
+			return 0;
+
+		put_device(&ul_chan->mhi_dev->dev);
+	}
+
+	if (dl_chan) {
+		if (ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
+			return 0;
+
+		put_device(&dl_chan->mhi_dev->dev);
+	}
+
+	dev_dbg(&mhi_cntrl->mhi_dev->dev, "destroy device for chan:%s\n",
+		 mhi_dev->name);
+
+	/* Notify the client and remove the device from MHI bus */
+	device_del(dev);
+	put_device(dev);
+
+	return 0;
+}
+
+int mhi_get_free_desc_count(struct mhi_device *mhi_dev,
+				enum dma_data_direction dir)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ?
+		mhi_dev->ul_chan : mhi_dev->dl_chan;
+	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+
+	return get_nr_avail_ring_elements(mhi_cntrl, tre_ring);
+}
+EXPORT_SYMBOL_GPL(mhi_get_free_desc_count);
+
+void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason)
+{
+	struct mhi_driver *mhi_drv;
+
+	if (!mhi_dev->dev.driver)
+		return;
+
+	mhi_drv = to_mhi_driver(mhi_dev->dev.driver);
+
+	if (mhi_drv->status_cb)
+		mhi_drv->status_cb(mhi_dev, cb_reason);
+}
+EXPORT_SYMBOL_GPL(mhi_notify);
+
+/* Bind MHI channels to MHI devices */
+void mhi_create_devices(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_chan *mhi_chan;
+	struct mhi_device *mhi_dev;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int i, ret;
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		if (!mhi_chan->configured || mhi_chan->mhi_dev ||
+		    !(mhi_chan->ee_mask & BIT(mhi_cntrl->ee)))
+			continue;
+		mhi_dev = mhi_alloc_device(mhi_cntrl);
+		if (IS_ERR(mhi_dev))
+			return;
+
+		mhi_dev->dev_type = MHI_DEVICE_XFER;
+		switch (mhi_chan->dir) {
+		case DMA_TO_DEVICE:
+			mhi_dev->ul_chan = mhi_chan;
+			mhi_dev->ul_chan_id = mhi_chan->chan;
+			break;
+		case DMA_FROM_DEVICE:
+			/* We use dl_chan as offload channels */
+			mhi_dev->dl_chan = mhi_chan;
+			mhi_dev->dl_chan_id = mhi_chan->chan;
+			break;
+		default:
+			dev_err(dev, "Direction not supported\n");
+			put_device(&mhi_dev->dev);
+			return;
+		}
+
+		get_device(&mhi_dev->dev);
+		mhi_chan->mhi_dev = mhi_dev;
+
+		/* Check next channel if it matches */
+		if ((i + 1) < mhi_cntrl->max_chan && mhi_chan[1].configured) {
+			if (!strcmp(mhi_chan[1].name, mhi_chan->name)) {
+				i++;
+				mhi_chan++;
+				if (mhi_chan->dir == DMA_TO_DEVICE) {
+					mhi_dev->ul_chan = mhi_chan;
+					mhi_dev->ul_chan_id = mhi_chan->chan;
+				} else {
+					mhi_dev->dl_chan = mhi_chan;
+					mhi_dev->dl_chan_id = mhi_chan->chan;
+				}
+				get_device(&mhi_dev->dev);
+				mhi_chan->mhi_dev = mhi_dev;
+			}
+		}
+
+		/* Channel name is same for both UL and DL */
+		mhi_dev->name = mhi_chan->name;
+		dev_set_name(&mhi_dev->dev, "%s_%s",
+			     dev_name(&mhi_cntrl->mhi_dev->dev),
+			     mhi_dev->name);
+
+		/* Init wakeup source if available */
+		if (mhi_dev->dl_chan && mhi_dev->dl_chan->wake_capable)
+			device_init_wakeup(&mhi_dev->dev, true);
+
+		ret = device_add(&mhi_dev->dev);
+		if (ret)
+			put_device(&mhi_dev->dev);
+	}
+}
+
+irqreturn_t mhi_irq_handler(int irq_number, void *dev)
+{
+	struct mhi_event *mhi_event = dev;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
+	void *dev_rp;
+
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		return IRQ_HANDLED;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
+
+	/* Only proceed if event ring has pending events */
+	if (ev_ring->rp == dev_rp)
+		return IRQ_HANDLED;
+
+	/* For client managed event ring, notify pending data */
+	if (mhi_event->cl_manage) {
+		struct mhi_chan *mhi_chan = mhi_event->mhi_chan;
+		struct mhi_device *mhi_dev = mhi_chan->mhi_dev;
+
+		if (mhi_dev)
+			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
+	} else {
+		tasklet_schedule(&mhi_event->task);
+	}
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
+{
+	struct mhi_controller *mhi_cntrl = priv;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state state;
+	enum mhi_pm_state pm_state = 0;
+	enum mhi_ee_type ee;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		goto exit_intvec;
+	}
+
+	state = mhi_get_mhi_state(mhi_cntrl);
+	ee = mhi_get_exec_env(mhi_cntrl);
+	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
+		TO_MHI_EXEC_STR(mhi_cntrl->ee),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		TO_MHI_EXEC_STR(ee), TO_MHI_STATE_STR(state));
+
+	if (state == MHI_STATE_SYS_ERR) {
+		dev_dbg(dev, "System error detected\n");
+		pm_state = mhi_tryset_pm_state(mhi_cntrl,
+					       MHI_PM_SYS_ERR_DETECT);
+	}
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	if (pm_state != MHI_PM_SYS_ERR_DETECT)
+		goto exit_intvec;
+
+	switch (ee) {
+	case MHI_EE_RDDM:
+		/* proceed if power down is not already in progress */
+		if (mhi_cntrl->rddm_image && mhi_is_active(mhi_cntrl)) {
+			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
+			mhi_cntrl->ee = ee;
+			wake_up_all(&mhi_cntrl->state_event);
+		}
+		break;
+	case MHI_EE_PBL:
+	case MHI_EE_EDL:
+	case MHI_EE_PTHRU:
+		mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_FATAL_ERROR);
+		mhi_cntrl->ee = ee;
+		wake_up_all(&mhi_cntrl->state_event);
+		mhi_pm_sys_err_handler(mhi_cntrl);
+		break;
+	default:
+		wake_up_all(&mhi_cntrl->state_event);
+		mhi_pm_sys_err_handler(mhi_cntrl);
+		break;
+	}
+
+exit_intvec:
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t mhi_intvec_handler(int irq_number, void *dev)
+{
+	struct mhi_controller *mhi_cntrl = dev;
+
+	/* Wake up events waiting for state change */
+	wake_up_all(&mhi_cntrl->state_event);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
+					struct mhi_ring *ring)
+{
+	dma_addr_t ctxt_wp;
+
+	/* Update the WP */
+	ring->wp += ring->el_size;
+	ctxt_wp = le64_to_cpu(*ring->ctxt_wp) + ring->el_size;
+
+	if (ring->wp >= (ring->base + ring->len)) {
+		ring->wp = ring->base;
+		ctxt_wp = ring->iommu_base;
+	}
+
+	*ring->ctxt_wp = cpu_to_le64(ctxt_wp);
+
+	/* Update the RP */
+	ring->rp += ring->el_size;
+	if (ring->rp >= (ring->base + ring->len))
+		ring->rp = ring->base;
+
+	/* Update to all cores */
+	smp_wmb();
+}
+
+static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
+			    struct mhi_tre *event,
+			    struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_result result;
+	unsigned long flags = 0;
+	u32 ev_code;
+
+	ev_code = MHI_TRE_GET_EV_CODE(event);
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+
+	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
+		-EOVERFLOW : 0;
+
+	/*
+	 * If it's a DB Event then we need to grab the lock
+	 * with preemption disabled and as a write because we
+	 * have to update db register and there are chances that
+	 * another thread could be doing the same.
+	 */
+	if (ev_code >= MHI_EV_CC_OOB)
+		write_lock_irqsave(&mhi_chan->lock, flags);
+	else
+		read_lock_bh(&mhi_chan->lock);
+
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
+		goto end_process_tx_event;
+
+	switch (ev_code) {
+	case MHI_EV_CC_OVERFLOW:
+	case MHI_EV_CC_EOB:
+	case MHI_EV_CC_EOT:
+	{
+		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
+		struct mhi_tre *local_rp, *ev_tre;
+		void *dev_rp;
+		struct mhi_buf_info *buf_info;
+		u16 xfer_len;
+
+		if (!is_valid_ring_ptr(tre_ring, ptr)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event element points outside of the tre ring\n");
+			break;
+		}
+		/* Get the TRB this event points to */
+		ev_tre = mhi_to_virtual(tre_ring, ptr);
+
+		dev_rp = ev_tre + 1;
+		if (dev_rp >= (tre_ring->base + tre_ring->len))
+			dev_rp = tre_ring->base;
+
+		result.dir = mhi_chan->dir;
+
+		local_rp = tre_ring->rp;
+		while (local_rp != dev_rp) {
+			buf_info = buf_ring->rp;
+			/* If it's the last TRE, get length from the event */
+			if (local_rp == ev_tre)
+				xfer_len = MHI_TRE_GET_EV_LEN(event);
+			else
+				xfer_len = buf_info->len;
+
+			/* Unmap if it's not pre-mapped by client */
+			if (likely(!buf_info->pre_mapped))
+				mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
+
+			result.buf_addr = buf_info->cb_buf;
+
+			/* truncate to buf len if xfer_len is larger */
+			result.bytes_xferd =
+				min_t(u16, xfer_len, buf_info->len);
+			mhi_del_ring_element(mhi_cntrl, buf_ring);
+			mhi_del_ring_element(mhi_cntrl, tre_ring);
+			local_rp = tre_ring->rp;
+
+			/* notify client */
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+			if (mhi_chan->dir == DMA_TO_DEVICE) {
+				atomic_dec(&mhi_cntrl->pending_pkts);
+				/* Release the reference got from mhi_queue() */
+				mhi_cntrl->runtime_put(mhi_cntrl);
+			}
+
+			/*
+			 * Recycle the buffer if buffer is pre-allocated,
+			 * if there is an error, not much we can do apart
+			 * from dropping the packet
+			 */
+			if (mhi_chan->pre_alloc) {
+				if (mhi_queue_buf(mhi_chan->mhi_dev,
+						  mhi_chan->dir,
+						  buf_info->cb_buf,
+						  buf_info->len, MHI_EOT)) {
+					dev_err(dev,
+						"Error recycling buffer for chan:%d\n",
+						mhi_chan->chan);
+					kfree(buf_info->cb_buf);
+				}
+			}
+		}
+		break;
+	} /* CC_EOT */
+	case MHI_EV_CC_OOB:
+	case MHI_EV_CC_DB_MODE:
+	{
+		unsigned long pm_lock_flags;
+
+		mhi_chan->db_cfg.db_mode = 1;
+		read_lock_irqsave(&mhi_cntrl->pm_lock, pm_lock_flags);
+		if (tre_ring->wp != tre_ring->rp &&
+		    MHI_DB_ACCESS_VALID(mhi_cntrl)) {
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		}
+		read_unlock_irqrestore(&mhi_cntrl->pm_lock, pm_lock_flags);
+		break;
+	}
+	case MHI_EV_CC_BAD_TRE:
+	default:
+		dev_err(dev, "Unknown event 0x%x\n", ev_code);
+		break;
+	} /* switch(MHI_EV_READ_CODE(EV_TRB_CODE,event)) */
+
+end_process_tx_event:
+	if (ev_code >= MHI_EV_CC_OOB)
+		write_unlock_irqrestore(&mhi_chan->lock, flags);
+	else
+		read_unlock_bh(&mhi_chan->lock);
+
+	return 0;
+}
+
+static int parse_rsc_event(struct mhi_controller *mhi_cntrl,
+			   struct mhi_tre *event,
+			   struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	struct mhi_buf_info *buf_info;
+	struct mhi_result result;
+	int ev_code;
+	u32 cookie; /* offset to local descriptor */
+	u16 xfer_len;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+
+	ev_code = MHI_TRE_GET_EV_CODE(event);
+	cookie = MHI_TRE_GET_EV_COOKIE(event);
+	xfer_len = MHI_TRE_GET_EV_LEN(event);
+
+	/* Received out of bound cookie */
+	WARN_ON(cookie >= buf_ring->len);
+
+	buf_info = buf_ring->base + cookie;
+
+	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
+		-EOVERFLOW : 0;
+
+	/* truncate to buf len if xfer_len is larger */
+	result.bytes_xferd = min_t(u16, xfer_len, buf_info->len);
+	result.buf_addr = buf_info->cb_buf;
+	result.dir = mhi_chan->dir;
+
+	read_lock_bh(&mhi_chan->lock);
+
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
+		goto end_process_rsc_event;
+
+	WARN_ON(!buf_info->used);
+
+	/* notify the client */
+	mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+	/*
+	 * Note: We're arbitrarily incrementing RP even though, completion
+	 * packet we processed might not be the same one, reason we can do this
+	 * is because device guaranteed to cache descriptors in order it
+	 * receive, so even though completion event is different we can re-use
+	 * all descriptors in between.
+	 * Example:
+	 * Transfer Ring has descriptors: A, B, C, D
+	 * Last descriptor host queue is D (WP) and first descriptor
+	 * host queue is A (RP).
+	 * The completion event we just serviced is descriptor C.
+	 * Then we can safely queue descriptors to replace A, B, and C
+	 * even though host did not receive any completions.
+	 */
+	mhi_del_ring_element(mhi_cntrl, tre_ring);
+	buf_info->used = false;
+
+end_process_rsc_event:
+	read_unlock_bh(&mhi_chan->lock);
+
+	return 0;
+}
+
+static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
+				       struct mhi_tre *tre)
+{
+	dma_addr_t ptr = MHI_TRE_GET_EV_PTR(tre);
+	struct mhi_cmd *cmd_ring = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+	struct mhi_ring *mhi_ring = &cmd_ring->ring;
+	struct mhi_tre *cmd_pkt;
+	struct mhi_chan *mhi_chan;
+	u32 chan;
+
+	if (!is_valid_ring_ptr(mhi_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event element points outside of the cmd ring\n");
+		return;
+	}
+
+	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
+
+	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
+
+	if (chan < mhi_cntrl->max_chan &&
+	    mhi_cntrl->mhi_chan[chan].configured) {
+		mhi_chan = &mhi_cntrl->mhi_chan[chan];
+		write_lock_bh(&mhi_chan->lock);
+		mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
+		complete(&mhi_chan->completion);
+		write_unlock_bh(&mhi_chan->lock);
+	} else {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Completion packet for invalid channel ID: %d\n", chan);
+	}
+
+	mhi_del_ring_element(mhi_cntrl, mhi_ring);
+}
+
+int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
+			     struct mhi_event *mhi_event,
+			     u32 event_quota)
+{
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct mhi_chan *mhi_chan;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 chan;
+	int count = 0;
+	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
+
+	/*
+	 * This is a quick check to avoid unnecessary event processing
+	 * in case MHI is already in error state, but it's still possible
+	 * to transition to error state while processing events
+	 */
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
+		return -EIO;
+
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		return -EIO;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
+	local_rp = ev_ring->rp;
+
+	while (dev_rp != local_rp) {
+		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
+
+		switch (type) {
+		case MHI_PKT_TYPE_BW_REQ_EVENT:
+		{
+			struct mhi_link_info *link_info;
+
+			link_info = &mhi_cntrl->mhi_link_info;
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			link_info->target_link_speed =
+				MHI_TRE_GET_EV_LINKSPEED(local_rp);
+			link_info->target_link_width =
+				MHI_TRE_GET_EV_LINKWIDTH(local_rp);
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			dev_dbg(dev, "Received BW_REQ event\n");
+			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_BW_REQ);
+			break;
+		}
+		case MHI_PKT_TYPE_STATE_CHANGE_EVENT:
+		{
+			enum mhi_state new_state;
+
+			new_state = MHI_TRE_GET_EV_STATE(local_rp);
+
+			dev_dbg(dev, "State change event to state: %s\n",
+				TO_MHI_STATE_STR(new_state));
+
+			switch (new_state) {
+			case MHI_STATE_M0:
+				mhi_pm_m0_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_M1:
+				mhi_pm_m1_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_M3:
+				mhi_pm_m3_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_SYS_ERR:
+			{
+				enum mhi_pm_state pm_state;
+
+				dev_dbg(dev, "System error detected\n");
+				write_lock_irq(&mhi_cntrl->pm_lock);
+				pm_state = mhi_tryset_pm_state(mhi_cntrl,
+							MHI_PM_SYS_ERR_DETECT);
+				write_unlock_irq(&mhi_cntrl->pm_lock);
+				if (pm_state == MHI_PM_SYS_ERR_DETECT)
+					mhi_pm_sys_err_handler(mhi_cntrl);
+				break;
+			}
+			default:
+				dev_err(dev, "Invalid state: %s\n",
+					TO_MHI_STATE_STR(new_state));
+			}
+
+			break;
+		}
+		case MHI_PKT_TYPE_CMD_COMPLETION_EVENT:
+			mhi_process_cmd_completion(mhi_cntrl, local_rp);
+			break;
+		case MHI_PKT_TYPE_EE_EVENT:
+		{
+			enum dev_st_transition st = DEV_ST_TRANSITION_MAX;
+			enum mhi_ee_type event = MHI_TRE_GET_EV_EXECENV(local_rp);
+
+			dev_dbg(dev, "Received EE event: %s\n",
+				TO_MHI_EXEC_STR(event));
+			switch (event) {
+			case MHI_EE_SBL:
+				st = DEV_ST_TRANSITION_SBL;
+				break;
+			case MHI_EE_WFW:
+			case MHI_EE_AMSS:
+				st = DEV_ST_TRANSITION_MISSION_MODE;
+				break;
+			case MHI_EE_FP:
+				st = DEV_ST_TRANSITION_FP;
+				break;
+			case MHI_EE_RDDM:
+				mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
+				write_lock_irq(&mhi_cntrl->pm_lock);
+				mhi_cntrl->ee = event;
+				write_unlock_irq(&mhi_cntrl->pm_lock);
+				wake_up_all(&mhi_cntrl->state_event);
+				break;
+			default:
+				dev_err(dev,
+					"Unhandled EE event: 0x%x\n", type);
+			}
+			if (st != DEV_ST_TRANSITION_MAX)
+				mhi_queue_state_transition(mhi_cntrl, st);
+
+			break;
+		}
+		case MHI_PKT_TYPE_TX_EVENT:
+			chan = MHI_TRE_GET_EV_CHID(local_rp);
+
+			WARN_ON(chan >= mhi_cntrl->max_chan);
+
+			/*
+			 * Only process the event ring elements whose channel
+			 * ID is within the maximum supported range.
+			 */
+			if (chan < mhi_cntrl->max_chan) {
+				mhi_chan = &mhi_cntrl->mhi_chan[chan];
+				if (!mhi_chan->configured)
+					break;
+				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
+				event_quota--;
+			}
+			break;
+		default:
+			dev_err(dev, "Unhandled event type: %d\n", type);
+			break;
+		}
+
+		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+		local_rp = ev_ring->rp;
+
+		ptr = le64_to_cpu(er_ctxt->rp);
+		if (!is_valid_ring_ptr(ev_ring, ptr)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event ring rp points outside of the event ring\n");
+			return -EIO;
+		}
+
+		dev_rp = mhi_to_virtual(ev_ring, ptr);
+		count++;
+	}
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+		mhi_ring_er_db(mhi_event);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return count;
+}
+
+int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
+				struct mhi_event *mhi_event,
+				u32 event_quota)
+{
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	int count = 0;
+	u32 chan;
+	struct mhi_chan *mhi_chan;
+	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
+
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
+		return -EIO;
+
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		return -EIO;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
+	local_rp = ev_ring->rp;
+
+	while (dev_rp != local_rp && event_quota > 0) {
+		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
+
+		chan = MHI_TRE_GET_EV_CHID(local_rp);
+
+		WARN_ON(chan >= mhi_cntrl->max_chan);
+
+		/*
+		 * Only process the event ring elements whose channel
+		 * ID is within the maximum supported range.
+		 */
+		if (chan < mhi_cntrl->max_chan &&
+		    mhi_cntrl->mhi_chan[chan].configured) {
+			mhi_chan = &mhi_cntrl->mhi_chan[chan];
+
+			if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
+				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
+				event_quota--;
+			} else if (type == MHI_PKT_TYPE_RSC_TX_EVENT) {
+				parse_rsc_event(mhi_cntrl, local_rp, mhi_chan);
+				event_quota--;
+			}
+		}
+
+		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+		local_rp = ev_ring->rp;
+
+		ptr = le64_to_cpu(er_ctxt->rp);
+		if (!is_valid_ring_ptr(ev_ring, ptr)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event ring rp points outside of the event ring\n");
+			return -EIO;
+		}
+
+		dev_rp = mhi_to_virtual(ev_ring, ptr);
+		count++;
+	}
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+		mhi_ring_er_db(mhi_event);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return count;
+}
+
+void mhi_ev_task(unsigned long data)
+{
+	struct mhi_event *mhi_event = (struct mhi_event *)data;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+
+	/* process all pending events */
+	spin_lock_bh(&mhi_event->lock);
+	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
+	spin_unlock_bh(&mhi_event->lock);
+}
+
+void mhi_ctrl_ev_task(unsigned long data)
+{
+	struct mhi_event *mhi_event = (struct mhi_event *)data;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state state;
+	enum mhi_pm_state pm_state = 0;
+	int ret;
+
+	/*
+	 * We can check PM state w/o a lock here because there is no way
+	 * PM state can change from reg access valid to no access while this
+	 * thread being executed.
+	 */
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		/*
+		 * We may have a pending event but not allowed to
+		 * process it since we are probably in a suspended state,
+		 * so trigger a resume.
+		 */
+		mhi_trigger_resume(mhi_cntrl);
+
+		return;
+	}
+
+	/* Process ctrl events events */
+	ret = mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
+
+	/*
+	 * We received an IRQ but no events to process, maybe device went to
+	 * SYS_ERR state? Check the state to confirm.
+	 */
+	if (!ret) {
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		state = mhi_get_mhi_state(mhi_cntrl);
+		if (state == MHI_STATE_SYS_ERR) {
+			dev_dbg(dev, "System error detected\n");
+			pm_state = mhi_tryset_pm_state(mhi_cntrl,
+						       MHI_PM_SYS_ERR_DETECT);
+		}
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (pm_state == MHI_PM_SYS_ERR_DETECT)
+			mhi_pm_sys_err_handler(mhi_cntrl);
+	}
+}
+
+static bool mhi_is_ring_full(struct mhi_controller *mhi_cntrl,
+			     struct mhi_ring *ring)
+{
+	void *tmp = ring->wp + ring->el_size;
+
+	if (tmp >= (ring->base + ring->len))
+		tmp = ring->base;
+
+	return (tmp == ring->rp);
+}
+
+static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
+		     enum dma_data_direction dir, enum mhi_flags mflags)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
+							     mhi_dev->dl_chan;
+	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+	unsigned long flags;
+	int ret;
+
+	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
+		return -EIO;
+
+	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
+
+	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
+	if (unlikely(ret)) {
+		ret = -EAGAIN;
+		goto exit_unlock;
+	}
+
+	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, buf_info, mflags);
+	if (unlikely(ret))
+		goto exit_unlock;
+
+	/* Packet is queued, take a usage ref to exit M3 if necessary
+	 * for host->device buffer, balanced put is done on buffer completion
+	 * for device->host buffer, balanced put is after ringing the DB
+	 */
+	mhi_cntrl->runtime_get(mhi_cntrl);
+
+	/* Assert dev_wake (to exit/prevent M1/M2)*/
+	mhi_cntrl->wake_toggle(mhi_cntrl);
+
+	if (mhi_chan->dir == DMA_TO_DEVICE)
+		atomic_inc(&mhi_cntrl->pending_pkts);
+
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+
+	if (dir == DMA_FROM_DEVICE)
+		mhi_cntrl->runtime_put(mhi_cntrl);
+
+exit_unlock:
+	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+
+	return ret;
+}
+
+int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
+		  struct sk_buff *skb, size_t len, enum mhi_flags mflags)
+{
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
+							     mhi_dev->dl_chan;
+	struct mhi_buf_info buf_info = { };
+
+	buf_info.v_addr = skb->data;
+	buf_info.cb_buf = skb;
+	buf_info.len = len;
+
+	if (unlikely(mhi_chan->pre_alloc))
+		return -EINVAL;
+
+	return mhi_queue(mhi_dev, &buf_info, dir, mflags);
+}
+EXPORT_SYMBOL_GPL(mhi_queue_skb);
+
+int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
+		  struct mhi_buf *mhi_buf, size_t len, enum mhi_flags mflags)
+{
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
+							     mhi_dev->dl_chan;
+	struct mhi_buf_info buf_info = { };
+
+	buf_info.p_addr = mhi_buf->dma_addr;
+	buf_info.cb_buf = mhi_buf;
+	buf_info.pre_mapped = true;
+	buf_info.len = len;
+
+	if (unlikely(mhi_chan->pre_alloc))
+		return -EINVAL;
+
+	return mhi_queue(mhi_dev, &buf_info, dir, mflags);
+}
+EXPORT_SYMBOL_GPL(mhi_queue_dma);
+
+int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
+			struct mhi_buf_info *info, enum mhi_flags flags)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	struct mhi_tre *mhi_tre;
+	struct mhi_buf_info *buf_info;
+	int eot, eob, chain, bei;
+	int ret;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+
+	buf_info = buf_ring->wp;
+	WARN_ON(buf_info->used);
+	buf_info->pre_mapped = info->pre_mapped;
+	if (info->pre_mapped)
+		buf_info->p_addr = info->p_addr;
+	else
+		buf_info->v_addr = info->v_addr;
+	buf_info->cb_buf = info->cb_buf;
+	buf_info->wp = tre_ring->wp;
+	buf_info->dir = mhi_chan->dir;
+	buf_info->len = info->len;
+
+	if (!info->pre_mapped) {
+		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
+		if (ret)
+			return ret;
+	}
+
+	eob = !!(flags & MHI_EOB);
+	eot = !!(flags & MHI_EOT);
+	chain = !!(flags & MHI_CHAIN);
+	bei = !!(mhi_chan->intmod);
+
+	mhi_tre = tre_ring->wp;
+	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
+	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
+	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
+
+	/* increment WP */
+	mhi_add_ring_element(mhi_cntrl, tre_ring);
+	mhi_add_ring_element(mhi_cntrl, buf_ring);
+
+	return 0;
+}
+
+int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
+		  void *buf, size_t len, enum mhi_flags mflags)
+{
+	struct mhi_buf_info buf_info = { };
+
+	buf_info.v_addr = buf;
+	buf_info.cb_buf = buf;
+	buf_info.len = len;
+
+	return mhi_queue(mhi_dev, &buf_info, dir, mflags);
+}
+EXPORT_SYMBOL_GPL(mhi_queue_buf);
+
+bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ?
+					mhi_dev->ul_chan : mhi_dev->dl_chan;
+	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+
+	return mhi_is_ring_full(mhi_cntrl, tre_ring);
+}
+EXPORT_SYMBOL_GPL(mhi_queue_is_full);
+
+int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
+		 struct mhi_chan *mhi_chan,
+		 enum mhi_cmd_type cmd)
+{
+	struct mhi_tre *cmd_tre = NULL;
+	struct mhi_cmd *mhi_cmd = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+	struct mhi_ring *ring = &mhi_cmd->ring;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int chan = 0;
+
+	if (mhi_chan)
+		chan = mhi_chan->chan;
+
+	spin_lock_bh(&mhi_cmd->lock);
+	if (!get_nr_avail_ring_elements(mhi_cntrl, ring)) {
+		spin_unlock_bh(&mhi_cmd->lock);
+		return -ENOMEM;
+	}
+
+	/* prepare the cmd tre */
+	cmd_tre = ring->wp;
+	switch (cmd) {
+	case MHI_CMD_RESET_CHAN:
+		cmd_tre->ptr = MHI_TRE_CMD_RESET_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_RESET_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_RESET_DWORD1(chan);
+		break;
+	case MHI_CMD_STOP_CHAN:
+		cmd_tre->ptr = MHI_TRE_CMD_STOP_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_STOP_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_STOP_DWORD1(chan);
+		break;
+	case MHI_CMD_START_CHAN:
+		cmd_tre->ptr = MHI_TRE_CMD_START_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_START_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_START_DWORD1(chan);
+		break;
+	default:
+		dev_err(dev, "Command not supported\n");
+		break;
+	}
+
+	/* queue to hardware */
+	mhi_add_ring_element(mhi_cntrl, ring);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+		mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	spin_unlock_bh(&mhi_cmd->lock);
+
+	return 0;
+}
+
+static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
+				    struct mhi_chan *mhi_chan,
+				    enum mhi_ch_state_type to_state)
+{
+	struct device *dev = &mhi_chan->mhi_dev->dev;
+	enum mhi_cmd_type cmd = MHI_CMD_NOP;
+	int ret;
+
+	dev_dbg(dev, "%d: Updating channel state to: %s\n", mhi_chan->chan,
+		TO_CH_STATE_TYPE_STR(to_state));
+
+	switch (to_state) {
+	case MHI_CH_STATE_TYPE_RESET:
+		write_lock_irq(&mhi_chan->lock);
+		if (mhi_chan->ch_state != MHI_CH_STATE_STOP &&
+		    mhi_chan->ch_state != MHI_CH_STATE_ENABLED &&
+		    mhi_chan->ch_state != MHI_CH_STATE_SUSPENDED) {
+			write_unlock_irq(&mhi_chan->lock);
+			return -EINVAL;
+		}
+		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+		write_unlock_irq(&mhi_chan->lock);
+
+		cmd = MHI_CMD_RESET_CHAN;
+		break;
+	case MHI_CH_STATE_TYPE_STOP:
+		if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
+			return -EINVAL;
+
+		cmd = MHI_CMD_STOP_CHAN;
+		break;
+	case MHI_CH_STATE_TYPE_START:
+		if (mhi_chan->ch_state != MHI_CH_STATE_STOP &&
+		    mhi_chan->ch_state != MHI_CH_STATE_DISABLED)
+			return -EINVAL;
+
+		cmd = MHI_CMD_START_CHAN;
+		break;
+	default:
+		dev_err(dev, "%d: Channel state update to %s not allowed\n",
+			mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
+		return -EINVAL;
+	}
+
+	/* bring host and device out of suspended states */
+	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
+	if (ret)
+		return ret;
+	mhi_cntrl->runtime_get(mhi_cntrl);
+
+	reinit_completion(&mhi_chan->completion);
+	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, cmd);
+	if (ret) {
+		dev_err(dev, "%d: Failed to send %s channel command\n",
+			mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
+		goto exit_channel_update;
+	}
+
+	ret = wait_for_completion_timeout(&mhi_chan->completion,
+				       msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS) {
+		dev_err(dev,
+			"%d: Failed to receive %s channel command completion\n",
+			mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
+		ret = -EIO;
+		goto exit_channel_update;
+	}
+
+	ret = 0;
+
+	if (to_state != MHI_CH_STATE_TYPE_RESET) {
+		write_lock_irq(&mhi_chan->lock);
+		mhi_chan->ch_state = (to_state == MHI_CH_STATE_TYPE_START) ?
+				      MHI_CH_STATE_ENABLED : MHI_CH_STATE_STOP;
+		write_unlock_irq(&mhi_chan->lock);
+	}
+
+	dev_dbg(dev, "%d: Channel state change to %s successful\n",
+		mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
+
+exit_channel_update:
+	mhi_cntrl->runtime_put(mhi_cntrl);
+	mhi_device_put(mhi_cntrl->mhi_dev);
+
+	return ret;
+}
+
+static void mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
+				  struct mhi_chan *mhi_chan)
+{
+	int ret;
+	struct device *dev = &mhi_chan->mhi_dev->dev;
+
+	mutex_lock(&mhi_chan->mutex);
+
+	if (!(BIT(mhi_cntrl->ee) & mhi_chan->ee_mask)) {
+		dev_dbg(dev, "Current EE: %s Required EE Mask: 0x%x\n",
+			TO_MHI_EXEC_STR(mhi_cntrl->ee), mhi_chan->ee_mask);
+		goto exit_unprepare_channel;
+	}
+
+	/* no more processing events for this channel */
+	ret = mhi_update_channel_state(mhi_cntrl, mhi_chan,
+				       MHI_CH_STATE_TYPE_RESET);
+	if (ret)
+		dev_err(dev, "%d: Failed to reset channel, still resetting\n",
+			mhi_chan->chan);
+
+exit_unprepare_channel:
+	write_lock_irq(&mhi_chan->lock);
+	mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+	write_unlock_irq(&mhi_chan->lock);
+
+	if (!mhi_chan->offload_ch) {
+		mhi_reset_chan(mhi_cntrl, mhi_chan);
+		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+	}
+	dev_dbg(dev, "%d: successfully reset\n", mhi_chan->chan);
+
+	mutex_unlock(&mhi_chan->mutex);
+}
+
+int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
+			struct mhi_chan *mhi_chan)
+{
+	int ret = 0;
+	struct device *dev = &mhi_chan->mhi_dev->dev;
+
+	if (!(BIT(mhi_cntrl->ee) & mhi_chan->ee_mask)) {
+		dev_err(dev, "Current EE: %s Required EE Mask: 0x%x\n",
+			TO_MHI_EXEC_STR(mhi_cntrl->ee), mhi_chan->ee_mask);
+		return -ENOTCONN;
+	}
+
+	mutex_lock(&mhi_chan->mutex);
+
+	/* Check of client manages channel context for offload channels */
+	if (!mhi_chan->offload_ch) {
+		ret = mhi_init_chan_ctxt(mhi_cntrl, mhi_chan);
+		if (ret)
+			goto error_init_chan;
+	}
+
+	ret = mhi_update_channel_state(mhi_cntrl, mhi_chan,
+				       MHI_CH_STATE_TYPE_START);
+	if (ret)
+		goto error_pm_state;
+
+	/* Pre-allocate buffer for xfer ring */
+	if (mhi_chan->pre_alloc) {
+		int nr_el = get_nr_avail_ring_elements(mhi_cntrl,
+						       &mhi_chan->tre_ring);
+		size_t len = mhi_cntrl->buffer_len;
+
+		while (nr_el--) {
+			void *buf;
+			struct mhi_buf_info info = { };
+			buf = kmalloc(len, GFP_KERNEL);
+			if (!buf) {
+				ret = -ENOMEM;
+				goto error_pre_alloc;
+			}
+
+			/* Prepare transfer descriptors */
+			info.v_addr = buf;
+			info.cb_buf = buf;
+			info.len = len;
+			ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &info, MHI_EOT);
+			if (ret) {
+				kfree(buf);
+				goto error_pre_alloc;
+			}
+		}
+
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		if (MHI_DB_ACCESS_VALID(mhi_cntrl)) {
+			read_lock_irq(&mhi_chan->lock);
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+			read_unlock_irq(&mhi_chan->lock);
+		}
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+	}
+
+	mutex_unlock(&mhi_chan->mutex);
+
+	return 0;
+
+error_pm_state:
+	if (!mhi_chan->offload_ch)
+		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+
+error_init_chan:
+	mutex_unlock(&mhi_chan->mutex);
+
+	return ret;
+
+error_pre_alloc:
+	mutex_unlock(&mhi_chan->mutex);
+	mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+
+	return ret;
+}
+
+static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
+				  struct mhi_event *mhi_event,
+				  struct mhi_event_ctxt *er_ctxt,
+				  int chan)
+
+{
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring *ev_ring;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	unsigned long flags;
+	dma_addr_t ptr;
+
+	dev_dbg(dev, "Marking all events for chan: %d as stale\n", chan);
+
+	ev_ring = &mhi_event->ring;
+
+	/* mark all stale events related to channel as STALE event */
+	spin_lock_irqsave(&mhi_event->lock, flags);
+
+	ptr = le64_to_cpu(er_ctxt->rp);
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		dev_rp = ev_ring->rp;
+	} else {
+		dev_rp = mhi_to_virtual(ev_ring, ptr);
+	}
+
+	local_rp = ev_ring->rp;
+	while (dev_rp != local_rp) {
+		if (MHI_TRE_GET_EV_TYPE(local_rp) == MHI_PKT_TYPE_TX_EVENT &&
+		    chan == MHI_TRE_GET_EV_CHID(local_rp))
+			local_rp->dword[1] = MHI_TRE_EV_DWORD1(chan,
+					MHI_PKT_TYPE_STALE_EVENT);
+		local_rp++;
+		if (local_rp == (ev_ring->base + ev_ring->len))
+			local_rp = ev_ring->base;
+	}
+
+	dev_dbg(dev, "Finished marking events as stale events\n");
+	spin_unlock_irqrestore(&mhi_event->lock, flags);
+}
+
+static void mhi_reset_data_chan(struct mhi_controller *mhi_cntrl,
+				struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	struct mhi_result result;
+
+	/* Reset any pending buffers */
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	result.transaction_status = -ENOTCONN;
+	result.bytes_xferd = 0;
+	while (tre_ring->rp != tre_ring->wp) {
+		struct mhi_buf_info *buf_info = buf_ring->rp;
+
+		if (mhi_chan->dir == DMA_TO_DEVICE) {
+			atomic_dec(&mhi_cntrl->pending_pkts);
+			/* Release the reference got from mhi_queue() */
+			mhi_cntrl->runtime_put(mhi_cntrl);
+		}
+
+		if (!buf_info->pre_mapped)
+			mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
+
+		mhi_del_ring_element(mhi_cntrl, buf_ring);
+		mhi_del_ring_element(mhi_cntrl, tre_ring);
+
+		if (mhi_chan->pre_alloc) {
+			kfree(buf_info->cb_buf);
+		} else {
+			result.buf_addr = buf_info->cb_buf;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+		}
+	}
+}
+
+void mhi_reset_chan(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan)
+{
+	struct mhi_event *mhi_event;
+	struct mhi_event_ctxt *er_ctxt;
+	int chan = mhi_chan->chan;
+
+	/* Nothing to reset, client doesn't queue buffers */
+	if (mhi_chan->offload_ch)
+		return;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+	er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_chan->er_index];
+
+	mhi_mark_stale_events(mhi_cntrl, mhi_event, er_ctxt, chan);
+
+	mhi_reset_data_chan(mhi_cntrl, mhi_chan);
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+
+/* Move channel to start state */
+int mhi_prepare_for_transfer(struct mhi_device *mhi_dev)
+{
+	int ret, dir;
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->dl_chan : mhi_dev->ul_chan;
+		if (!mhi_chan)
+			continue;
+
+		ret = mhi_prepare_channel(mhi_cntrl, mhi_chan);
+		if (ret)
+			goto error_open_chan;
+	}
+
+	return 0;
+
+error_open_chan:
+	for (--dir; dir >= 0; dir--) {
+		mhi_chan = dir ? mhi_dev->dl_chan : mhi_dev->ul_chan;
+		if (!mhi_chan)
+			continue;
+
+		mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer);
+
+void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	int dir;
+
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+		if (!mhi_chan)
+			continue;
+
+		mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+	}
+}
+EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
+
+int mhi_poll(struct mhi_device *mhi_dev, u32 budget)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = mhi_dev->dl_chan;
+	struct mhi_event *mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+	int ret;
+
+	spin_lock_bh(&mhi_event->lock);
+	ret = mhi_event->process_event(mhi_cntrl, mhi_event, budget);
+	spin_unlock_bh(&mhi_event->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_poll);
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
new file mode 100644
index 000000000000..b780990faf80
--- /dev/null
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -0,0 +1,1146 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MHI PCI driver - MHI over PCI controller driver
+ *
+ * This module is a generic driver for registering MHI-over-PCI devices,
+ * such as PCIe QCOM modems.
+ *
+ * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
+ */
+
+#include <linux/aer.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+
+#define MHI_PCI_DEFAULT_BAR_NUM 0
+
+#define MHI_POST_RESET_DELAY_MS 2000
+
+#define HEALTH_CHECK_PERIOD (HZ * 2)
+
+/**
+ * struct mhi_pci_dev_info - MHI PCI device specific information
+ * @config: MHI controller configuration
+ * @name: name of the PCI module
+ * @fw: firmware path (if any)
+ * @edl: emergency download mode firmware path (if any)
+ * @bar_num: PCI base address register to use for MHI MMIO register space
+ * @dma_data_width: DMA transfer word size (32 or 64 bits)
+ * @mru_default: default MRU size for MBIM network packets
+ * @sideband_wake: Devices using dedicated sideband GPIO for wakeup instead
+ *		   of inband wake support (such as sdx24)
+ */
+struct mhi_pci_dev_info {
+	const struct mhi_controller_config *config;
+	const char *name;
+	const char *fw;
+	const char *edl;
+	unsigned int bar_num;
+	unsigned int dma_data_width;
+	unsigned int mru_default;
+	bool sideband_wake;
+};
+
+#define MHI_CHANNEL_CONFIG_UL(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_TO_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_AMSS),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+	}						\
+
+#define MHI_CHANNEL_CONFIG_DL(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_FROM_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_AMSS),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+	}
+
+#define MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_FROM_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_AMSS),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+		.auto_queue = true,			\
+	}
+
+#define MHI_EVENT_CONFIG_CTRL(ev_ring, el_count) \
+	{					\
+		.num_elements = el_count,	\
+		.irq_moderation_ms = 0,		\
+		.irq = (ev_ring) + 1,		\
+		.priority = 1,			\
+		.mode = MHI_DB_BRST_DISABLE,	\
+		.data_type = MHI_ER_CTRL,	\
+		.hardware_event = false,	\
+		.client_managed = false,	\
+		.offload_channel = false,	\
+	}
+
+#define MHI_CHANNEL_CONFIG_HW_UL(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_TO_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_AMSS),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_ENABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = true,		\
+	}						\
+
+#define MHI_CHANNEL_CONFIG_HW_DL(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_FROM_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_AMSS),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_ENABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = true,		\
+	}
+
+#define MHI_CHANNEL_CONFIG_UL_SBL(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_TO_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_SBL),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+	}						\
+
+#define MHI_CHANNEL_CONFIG_DL_SBL(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_FROM_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_SBL),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+	}
+
+#define MHI_CHANNEL_CONFIG_UL_FP(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_TO_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_FP),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+	}						\
+
+#define MHI_CHANNEL_CONFIG_DL_FP(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_FROM_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_FP),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+	}
+
+#define MHI_EVENT_CONFIG_DATA(ev_ring, el_count) \
+	{					\
+		.num_elements = el_count,	\
+		.irq_moderation_ms = 5,		\
+		.irq = (ev_ring) + 1,		\
+		.priority = 1,			\
+		.mode = MHI_DB_BRST_DISABLE,	\
+		.data_type = MHI_ER_DATA,	\
+		.hardware_event = false,	\
+		.client_managed = false,	\
+		.offload_channel = false,	\
+	}
+
+#define MHI_EVENT_CONFIG_HW_DATA(ev_ring, el_count, ch_num) \
+	{					\
+		.num_elements = el_count,	\
+		.irq_moderation_ms = 1,		\
+		.irq = (ev_ring) + 1,		\
+		.priority = 1,			\
+		.mode = MHI_DB_BRST_DISABLE,	\
+		.data_type = MHI_ER_DATA,	\
+		.hardware_event = true,		\
+		.client_managed = false,	\
+		.offload_channel = false,	\
+		.channel = ch_num,		\
+	}
+
+static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
+	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
+	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 4, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 4, 0),
+	MHI_CHANNEL_CONFIG_UL(14, "QMI", 4, 0),
+	MHI_CHANNEL_CONFIG_DL(15, "QMI", 4, 0),
+	MHI_CHANNEL_CONFIG_UL(20, "IPCR", 8, 0),
+	MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(21, "IPCR", 8, 0),
+	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
+	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 2),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 3),
+};
+
+static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
+	/* first ring is control+data ring */
+	MHI_EVENT_CONFIG_CTRL(0, 64),
+	/* DIAG dedicated event ring */
+	MHI_EVENT_CONFIG_DATA(1, 128),
+	/* Hardware channels request dedicated hardware event rings */
+	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
+	MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101)
+};
+
+static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
+	.max_channels = 128,
+	.timeout_ms = 8000,
+	.num_channels = ARRAY_SIZE(modem_qcom_v1_mhi_channels),
+	.ch_cfg = modem_qcom_v1_mhi_channels,
+	.num_events = ARRAY_SIZE(modem_qcom_v1_mhi_events),
+	.event_cfg = modem_qcom_v1_mhi_events,
+};
+
+static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
+	.name = "qcom-sdx65m",
+	.fw = "qcom/sdx65m/xbl.elf",
+	.edl = "qcom/sdx65m/edl.mbn",
+	.config = &modem_qcom_v1_mhiv_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.sideband_wake = false,
+};
+
+static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
+	.name = "qcom-sdx55m",
+	.fw = "qcom/sdx55m/sbl1.mbn",
+	.edl = "qcom/sdx55m/edl.mbn",
+	.config = &modem_qcom_v1_mhiv_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+};
+
+static const struct mhi_pci_dev_info mhi_qcom_sdx24_info = {
+	.name = "qcom-sdx24",
+	.edl = "qcom/prog_firehose_sdx24.mbn",
+	.config = &modem_qcom_v1_mhiv_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.sideband_wake = true,
+};
+
+static const struct mhi_channel_config mhi_quectel_em1xx_channels[] = {
+	MHI_CHANNEL_CONFIG_UL(0, "NMEA", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(1, "NMEA", 32, 0),
+	MHI_CHANNEL_CONFIG_UL_SBL(2, "SAHARA", 32, 0),
+	MHI_CHANNEL_CONFIG_DL_SBL(3, "SAHARA", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 32, 1),
+	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 32, 1),
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
+	/* The EDL firmware is a flash-programmer exposing firehose protocol */
+	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
+	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
+};
+
+static struct mhi_event_config mhi_quectel_em1xx_events[] = {
+	MHI_EVENT_CONFIG_CTRL(0, 128),
+	MHI_EVENT_CONFIG_DATA(1, 128),
+	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
+	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101)
+};
+
+static const struct mhi_controller_config modem_quectel_em1xx_config = {
+	.max_channels = 128,
+	.timeout_ms = 20000,
+	.num_channels = ARRAY_SIZE(mhi_quectel_em1xx_channels),
+	.ch_cfg = mhi_quectel_em1xx_channels,
+	.num_events = ARRAY_SIZE(mhi_quectel_em1xx_events),
+	.event_cfg = mhi_quectel_em1xx_events,
+};
+
+static const struct mhi_pci_dev_info mhi_quectel_em1xx_info = {
+	.name = "quectel-em1xx",
+	.edl = "qcom/prog_firehose_sdx24.mbn",
+	.config = &modem_quectel_em1xx_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = true,
+};
+
+static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
+	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 32, 1),
+	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 32, 1),
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
+};
+
+static struct mhi_event_config mhi_foxconn_sdx55_events[] = {
+	MHI_EVENT_CONFIG_CTRL(0, 128),
+	MHI_EVENT_CONFIG_DATA(1, 128),
+	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
+	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101)
+};
+
+static const struct mhi_controller_config modem_foxconn_sdx55_config = {
+	.max_channels = 128,
+	.timeout_ms = 20000,
+	.num_channels = ARRAY_SIZE(mhi_foxconn_sdx55_channels),
+	.ch_cfg = mhi_foxconn_sdx55_channels,
+	.num_events = ARRAY_SIZE(mhi_foxconn_sdx55_events),
+	.event_cfg = mhi_foxconn_sdx55_events,
+};
+
+static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
+	.name = "foxconn-sdx55",
+	.fw = "qcom/sdx55m/sbl1.mbn",
+	.edl = "qcom/sdx55m/edl.mbn",
+	.config = &modem_foxconn_sdx55_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+};
+
+static const struct mhi_channel_config mhi_mv31_channels[] = {
+	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 64, 0),
+	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 64, 0),
+	/* MBIM Control Channel */
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 64, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 64, 0),
+	/* MBIM Data Channel */
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 512, 2),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 512, 3),
+};
+
+static struct mhi_event_config mhi_mv31_events[] = {
+	MHI_EVENT_CONFIG_CTRL(0, 256),
+	MHI_EVENT_CONFIG_DATA(1, 256),
+	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
+	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101),
+};
+
+static const struct mhi_controller_config modem_mv31_config = {
+	.max_channels = 128,
+	.timeout_ms = 20000,
+	.num_channels = ARRAY_SIZE(mhi_mv31_channels),
+	.ch_cfg = mhi_mv31_channels,
+	.num_events = ARRAY_SIZE(mhi_mv31_events),
+	.event_cfg = mhi_mv31_events,
+};
+
+static const struct mhi_pci_dev_info mhi_mv31_info = {
+	.name = "cinterion-mv31",
+	.config = &modem_mv31_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+};
+
+static const struct mhi_channel_config mhi_telit_fn980_hw_v1_channels[] = {
+	MHI_CHANNEL_CONFIG_UL(14, "QMI", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(15, "QMI", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(20, "IPCR", 16, 0),
+	MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(21, "IPCR", 16, 0),
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 1),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 2),
+};
+
+static struct mhi_event_config mhi_telit_fn980_hw_v1_events[] = {
+	MHI_EVENT_CONFIG_CTRL(0, 128),
+	MHI_EVENT_CONFIG_HW_DATA(1, 1024, 100),
+	MHI_EVENT_CONFIG_HW_DATA(2, 2048, 101)
+};
+
+static struct mhi_controller_config modem_telit_fn980_hw_v1_config = {
+	.max_channels = 128,
+	.timeout_ms = 20000,
+	.num_channels = ARRAY_SIZE(mhi_telit_fn980_hw_v1_channels),
+	.ch_cfg = mhi_telit_fn980_hw_v1_channels,
+	.num_events = ARRAY_SIZE(mhi_telit_fn980_hw_v1_events),
+	.event_cfg = mhi_telit_fn980_hw_v1_events,
+};
+
+static const struct mhi_pci_dev_info mhi_telit_fn980_hw_v1_info = {
+	.name = "telit-fn980-hwv1",
+	.fw = "qcom/sdx55m/sbl1.mbn",
+	.edl = "qcom/sdx55m/edl.mbn",
+	.config = &modem_telit_fn980_hw_v1_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+};
+
+static const struct mhi_channel_config mhi_telit_fn990_channels[] = {
+	MHI_CHANNEL_CONFIG_UL_SBL(2, "SAHARA", 32, 0),
+	MHI_CHANNEL_CONFIG_DL_SBL(3, "SAHARA", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 64, 1),
+	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 64, 1),
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
+};
+
+static struct mhi_event_config mhi_telit_fn990_events[] = {
+	MHI_EVENT_CONFIG_CTRL(0, 128),
+	MHI_EVENT_CONFIG_DATA(1, 128),
+	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
+	MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101)
+};
+
+static const struct mhi_controller_config modem_telit_fn990_config = {
+	.max_channels = 128,
+	.timeout_ms = 20000,
+	.num_channels = ARRAY_SIZE(mhi_telit_fn990_channels),
+	.ch_cfg = mhi_telit_fn990_channels,
+	.num_events = ARRAY_SIZE(mhi_telit_fn990_events),
+	.event_cfg = mhi_telit_fn990_events,
+};
+
+static const struct mhi_pci_dev_info mhi_telit_fn990_info = {
+	.name = "telit-fn990",
+	.config = &modem_telit_fn990_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.sideband_wake = false,
+	.mru_default = 32768,
+};
+
+static const struct pci_device_id mhi_pci_id_table[] = {
+	/* Telit FN980 hardware revision v1 */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, 0x1C5D, 0x2000),
+		.driver_data = (kernel_ulong_t) &mhi_telit_fn980_hw_v1_info },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0306),
+		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx55_info },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
+		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
+	/* Telit FN990 */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2010),
+		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
+	{ PCI_DEVICE(0x1eac, 0x1001), /* EM120R-GL (sdx24) */
+		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
+	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
+		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
+		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
+	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+	/* DW5930e (sdx55), With eSIM, It's also T99W175 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b0),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+	/* DW5930e (sdx55), Non-eSIM, It's also T99W175 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b1),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+	/* MV31-W (Cinterion) */
+	{ PCI_DEVICE(0x1269, 0x00b3),
+		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
+	{  }
+};
+MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
+
+enum mhi_pci_device_status {
+	MHI_PCI_DEV_STARTED,
+	MHI_PCI_DEV_SUSPENDED,
+};
+
+struct mhi_pci_device {
+	struct mhi_controller mhi_cntrl;
+	struct pci_saved_state *pci_state;
+	struct work_struct recovery_work;
+	struct timer_list health_check_timer;
+	unsigned long status;
+};
+
+static int mhi_pci_read_reg(struct mhi_controller *mhi_cntrl,
+			    void __iomem *addr, u32 *out)
+{
+	*out = readl(addr);
+	return 0;
+}
+
+static void mhi_pci_write_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *addr, u32 val)
+{
+	writel(val, addr);
+}
+
+static void mhi_pci_status_cb(struct mhi_controller *mhi_cntrl,
+			      enum mhi_callback cb)
+{
+	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
+
+	/* Nothing to do for now */
+	switch (cb) {
+	case MHI_CB_FATAL_ERROR:
+	case MHI_CB_SYS_ERROR:
+		dev_warn(&pdev->dev, "firmware crashed (%u)\n", cb);
+		pm_runtime_forbid(&pdev->dev);
+		break;
+	case MHI_CB_EE_MISSION_MODE:
+		pm_runtime_allow(&pdev->dev);
+		break;
+	default:
+		break;
+	}
+}
+
+static void mhi_pci_wake_get_nop(struct mhi_controller *mhi_cntrl, bool force)
+{
+	/* no-op */
+}
+
+static void mhi_pci_wake_put_nop(struct mhi_controller *mhi_cntrl, bool override)
+{
+	/* no-op */
+}
+
+static void mhi_pci_wake_toggle_nop(struct mhi_controller *mhi_cntrl)
+{
+	/* no-op */
+}
+
+static bool mhi_pci_is_alive(struct mhi_controller *mhi_cntrl)
+{
+	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
+	u16 vendor = 0;
+
+	if (pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor))
+		return false;
+
+	if (vendor == (u16) ~0 || vendor == 0)
+		return false;
+
+	return true;
+}
+
+static int mhi_pci_claim(struct mhi_controller *mhi_cntrl,
+			 unsigned int bar_num, u64 dma_mask)
+{
+	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
+	int err;
+
+	err = pci_assign_resource(pdev, bar_num);
+	if (err)
+		return err;
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable pci device: %d\n", err);
+		return err;
+	}
+
+	err = pcim_iomap_regions(pdev, 1 << bar_num, pci_name(pdev));
+	if (err) {
+		dev_err(&pdev->dev, "failed to map pci region: %d\n", err);
+		return err;
+	}
+	mhi_cntrl->regs = pcim_iomap_table(pdev)[bar_num];
+	mhi_cntrl->reg_len = pci_resource_len(pdev, bar_num);
+
+	err = pci_set_dma_mask(pdev, dma_mask);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot set proper DMA mask\n");
+		return err;
+	}
+
+	err = pci_set_consistent_dma_mask(pdev, dma_mask);
+	if (err) {
+		dev_err(&pdev->dev, "set consistent dma mask failed\n");
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+
+static int mhi_pci_get_irqs(struct mhi_controller *mhi_cntrl,
+			    const struct mhi_controller_config *mhi_cntrl_config)
+{
+	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
+	int nr_vectors, i;
+	int *irq;
+
+	/*
+	 * Alloc one MSI vector for BHI + one vector per event ring, ideally...
+	 * No explicit pci_free_irq_vectors required, done by pcim_release.
+	 */
+	mhi_cntrl->nr_irqs = 1 + mhi_cntrl_config->num_events;
+
+	nr_vectors = pci_alloc_irq_vectors(pdev, 1, mhi_cntrl->nr_irqs, PCI_IRQ_MSI);
+	if (nr_vectors < 0) {
+		dev_err(&pdev->dev, "Error allocating MSI vectors %d\n",
+			nr_vectors);
+		return nr_vectors;
+	}
+
+	if (nr_vectors < mhi_cntrl->nr_irqs) {
+		dev_warn(&pdev->dev, "using shared MSI\n");
+
+		/* Patch msi vectors, use only one (shared) */
+		for (i = 0; i < mhi_cntrl_config->num_events; i++)
+			mhi_cntrl_config->event_cfg[i].irq = 0;
+		mhi_cntrl->nr_irqs = 1;
+	}
+
+	irq = devm_kcalloc(&pdev->dev, mhi_cntrl->nr_irqs, sizeof(int), GFP_KERNEL);
+	if (!irq)
+		return -ENOMEM;
+
+	for (i = 0; i < mhi_cntrl->nr_irqs; i++) {
+		int vector = i >= nr_vectors ? (nr_vectors - 1) : i;
+
+		irq[i] = pci_irq_vector(pdev, vector);
+	}
+
+	mhi_cntrl->irq = irq;
+
+	return 0;
+}
+
+static int mhi_pci_runtime_get(struct mhi_controller *mhi_cntrl)
+{
+	/* The runtime_get() MHI callback means:
+	 *    Do whatever is requested to leave M3.
+	 */
+	return pm_runtime_get(mhi_cntrl->cntrl_dev);
+}
+
+static void mhi_pci_runtime_put(struct mhi_controller *mhi_cntrl)
+{
+	/* The runtime_put() MHI callback means:
+	 *    Device can be moved in M3 state.
+	 */
+	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+	pm_runtime_put(mhi_cntrl->cntrl_dev);
+}
+
+static void mhi_pci_recovery_work(struct work_struct *work)
+{
+	struct mhi_pci_device *mhi_pdev = container_of(work, struct mhi_pci_device,
+						       recovery_work);
+	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
+	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
+	int err;
+
+	dev_warn(&pdev->dev, "device recovery started\n");
+
+	del_timer(&mhi_pdev->health_check_timer);
+	pm_runtime_forbid(&pdev->dev);
+
+	/* Clean up MHI state */
+	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
+		mhi_power_down(mhi_cntrl, false);
+		mhi_unprepare_after_power_down(mhi_cntrl);
+	}
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_load_saved_state(pdev, mhi_pdev->pci_state);
+	pci_restore_state(pdev);
+
+	if (!mhi_pci_is_alive(mhi_cntrl))
+		goto err_try_reset;
+
+	err = mhi_prepare_for_power_up(mhi_cntrl);
+	if (err)
+		goto err_try_reset;
+
+	err = mhi_sync_power_up(mhi_cntrl);
+	if (err)
+		goto err_unprepare;
+
+	dev_dbg(&pdev->dev, "Recovery completed\n");
+
+	set_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status);
+	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
+	return;
+
+err_unprepare:
+	mhi_unprepare_after_power_down(mhi_cntrl);
+err_try_reset:
+	if (pci_reset_function(pdev))
+		dev_err(&pdev->dev, "Recovery failed\n");
+}
+
+static void health_check(struct timer_list *t)
+{
+	struct mhi_pci_device *mhi_pdev = from_timer(mhi_pdev, t, health_check_timer);
+	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
+
+	if (!test_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status) ||
+			test_bit(MHI_PCI_DEV_SUSPENDED, &mhi_pdev->status))
+		return;
+
+	if (!mhi_pci_is_alive(mhi_cntrl)) {
+		dev_err(mhi_cntrl->cntrl_dev, "Device died\n");
+		queue_work(system_long_wq, &mhi_pdev->recovery_work);
+		return;
+	}
+
+	/* reschedule in two seconds */
+	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
+}
+
+static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info *) id->driver_data;
+	const struct mhi_controller_config *mhi_cntrl_config;
+	struct mhi_pci_device *mhi_pdev;
+	struct mhi_controller *mhi_cntrl;
+	int err;
+
+	dev_dbg(&pdev->dev, "MHI PCI device found: %s\n", info->name);
+
+	/* mhi_pdev.mhi_cntrl must be zero-initialized */
+	mhi_pdev = devm_kzalloc(&pdev->dev, sizeof(*mhi_pdev), GFP_KERNEL);
+	if (!mhi_pdev)
+		return -ENOMEM;
+
+	INIT_WORK(&mhi_pdev->recovery_work, mhi_pci_recovery_work);
+	timer_setup(&mhi_pdev->health_check_timer, health_check, 0);
+
+	mhi_cntrl_config = info->config;
+	mhi_cntrl = &mhi_pdev->mhi_cntrl;
+
+	mhi_cntrl->cntrl_dev = &pdev->dev;
+	mhi_cntrl->iova_start = 0;
+	mhi_cntrl->iova_stop = (dma_addr_t)DMA_BIT_MASK(info->dma_data_width);
+	mhi_cntrl->fw_image = info->fw;
+	mhi_cntrl->edl_image = info->edl;
+
+	mhi_cntrl->read_reg = mhi_pci_read_reg;
+	mhi_cntrl->write_reg = mhi_pci_write_reg;
+	mhi_cntrl->status_cb = mhi_pci_status_cb;
+	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
+	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
+	mhi_cntrl->mru = info->mru_default;
+
+	if (info->sideband_wake) {
+		mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
+		mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
+		mhi_cntrl->wake_toggle = mhi_pci_wake_toggle_nop;
+	}
+
+	err = mhi_pci_claim(mhi_cntrl, info->bar_num, DMA_BIT_MASK(info->dma_data_width));
+	if (err)
+		return err;
+
+	err = mhi_pci_get_irqs(mhi_cntrl, mhi_cntrl_config);
+	if (err)
+		return err;
+
+	pci_set_drvdata(pdev, mhi_pdev);
+
+	/* Have stored pci confspace at hand for restore in sudden PCI error.
+	 * cache the state locally and discard the PCI core one.
+	 */
+	pci_save_state(pdev);
+	mhi_pdev->pci_state = pci_store_saved_state(pdev);
+	pci_load_saved_state(pdev, NULL);
+
+	pci_enable_pcie_error_reporting(pdev);
+
+	err = mhi_register_controller(mhi_cntrl, mhi_cntrl_config);
+	if (err)
+		goto err_disable_reporting;
+
+	/* MHI bus does not power up the controller by default */
+	err = mhi_prepare_for_power_up(mhi_cntrl);
+	if (err) {
+		dev_err(&pdev->dev, "failed to prepare MHI controller\n");
+		goto err_unregister;
+	}
+
+	err = mhi_sync_power_up(mhi_cntrl);
+	if (err) {
+		dev_err(&pdev->dev, "failed to power up MHI controller\n");
+		goto err_unprepare;
+	}
+
+	set_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status);
+
+	/* start health check */
+	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
+
+	/* Only allow runtime-suspend if PME capable (for wakeup) */
+	if (pci_pme_capable(pdev, PCI_D3hot)) {
+		pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_runtime_mark_last_busy(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+	}
+
+	return 0;
+
+err_unprepare:
+	mhi_unprepare_after_power_down(mhi_cntrl);
+err_unregister:
+	mhi_unregister_controller(mhi_cntrl);
+err_disable_reporting:
+	pci_disable_pcie_error_reporting(pdev);
+
+	return err;
+}
+
+static void mhi_pci_remove(struct pci_dev *pdev)
+{
+	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
+	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
+
+	del_timer_sync(&mhi_pdev->health_check_timer);
+	cancel_work_sync(&mhi_pdev->recovery_work);
+
+	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
+		mhi_power_down(mhi_cntrl, true);
+		mhi_unprepare_after_power_down(mhi_cntrl);
+	}
+
+	/* balancing probe put_noidle */
+	if (pci_pme_capable(pdev, PCI_D3hot))
+		pm_runtime_get_noresume(&pdev->dev);
+
+	mhi_unregister_controller(mhi_cntrl);
+	pci_disable_pcie_error_reporting(pdev);
+}
+
+static void mhi_pci_shutdown(struct pci_dev *pdev)
+{
+	mhi_pci_remove(pdev);
+	pci_set_power_state(pdev, PCI_D3hot);
+}
+
+static void mhi_pci_reset_prepare(struct pci_dev *pdev)
+{
+	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
+	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
+
+	dev_info(&pdev->dev, "reset\n");
+
+	del_timer(&mhi_pdev->health_check_timer);
+
+	/* Clean up MHI state */
+	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
+		mhi_power_down(mhi_cntrl, false);
+		mhi_unprepare_after_power_down(mhi_cntrl);
+	}
+
+	/* cause internal device reset */
+	mhi_soc_reset(mhi_cntrl);
+
+	/* Be sure device reset has been executed */
+	msleep(MHI_POST_RESET_DELAY_MS);
+}
+
+static void mhi_pci_reset_done(struct pci_dev *pdev)
+{
+	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
+	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
+	int err;
+
+	/* Restore initial known working PCI state */
+	pci_load_saved_state(pdev, mhi_pdev->pci_state);
+	pci_restore_state(pdev);
+
+	/* Is device status available ? */
+	if (!mhi_pci_is_alive(mhi_cntrl)) {
+		dev_err(&pdev->dev, "reset failed\n");
+		return;
+	}
+
+	err = mhi_prepare_for_power_up(mhi_cntrl);
+	if (err) {
+		dev_err(&pdev->dev, "failed to prepare MHI controller\n");
+		return;
+	}
+
+	err = mhi_sync_power_up(mhi_cntrl);
+	if (err) {
+		dev_err(&pdev->dev, "failed to power up MHI controller\n");
+		mhi_unprepare_after_power_down(mhi_cntrl);
+		return;
+	}
+
+	set_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status);
+	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
+}
+
+static pci_ers_result_t mhi_pci_error_detected(struct pci_dev *pdev,
+					       pci_channel_state_t state)
+{
+	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
+	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
+
+	dev_err(&pdev->dev, "PCI error detected, state = %u\n", state);
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	/* Clean up MHI state */
+	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
+		mhi_power_down(mhi_cntrl, false);
+		mhi_unprepare_after_power_down(mhi_cntrl);
+	} else {
+		/* Nothing to do */
+		return PCI_ERS_RESULT_RECOVERED;
+	}
+
+	pci_disable_device(pdev);
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t mhi_pci_slot_reset(struct pci_dev *pdev)
+{
+	if (pci_enable_device(pdev)) {
+		dev_err(&pdev->dev, "Cannot re-enable PCI device after reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void mhi_pci_io_resume(struct pci_dev *pdev)
+{
+	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
+
+	dev_err(&pdev->dev, "PCI slot reset done\n");
+
+	queue_work(system_long_wq, &mhi_pdev->recovery_work);
+}
+
+static const struct pci_error_handlers mhi_pci_err_handler = {
+	.error_detected = mhi_pci_error_detected,
+	.slot_reset = mhi_pci_slot_reset,
+	.resume = mhi_pci_io_resume,
+	.reset_prepare = mhi_pci_reset_prepare,
+	.reset_done = mhi_pci_reset_done,
+};
+
+static int  __maybe_unused mhi_pci_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct mhi_pci_device *mhi_pdev = dev_get_drvdata(dev);
+	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
+	int err;
+
+	if (test_and_set_bit(MHI_PCI_DEV_SUSPENDED, &mhi_pdev->status))
+		return 0;
+
+	del_timer(&mhi_pdev->health_check_timer);
+	cancel_work_sync(&mhi_pdev->recovery_work);
+
+	if (!test_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status) ||
+			mhi_cntrl->ee != MHI_EE_AMSS)
+		goto pci_suspend; /* Nothing to do at MHI level */
+
+	/* Transition to M3 state */
+	err = mhi_pm_suspend(mhi_cntrl);
+	if (err) {
+		dev_err(&pdev->dev, "failed to suspend device: %d\n", err);
+		clear_bit(MHI_PCI_DEV_SUSPENDED, &mhi_pdev->status);
+		return -EBUSY;
+	}
+
+pci_suspend:
+	pci_disable_device(pdev);
+	pci_wake_from_d3(pdev, true);
+
+	return 0;
+}
+
+static int __maybe_unused mhi_pci_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct mhi_pci_device *mhi_pdev = dev_get_drvdata(dev);
+	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
+	int err;
+
+	if (!test_and_clear_bit(MHI_PCI_DEV_SUSPENDED, &mhi_pdev->status))
+		return 0;
+
+	err = pci_enable_device(pdev);
+	if (err)
+		goto err_recovery;
+
+	pci_set_master(pdev);
+	pci_wake_from_d3(pdev, false);
+
+	if (!test_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status) ||
+			mhi_cntrl->ee != MHI_EE_AMSS)
+		return 0; /* Nothing to do at MHI level */
+
+	/* Exit M3, transition to M0 state */
+	err = mhi_pm_resume(mhi_cntrl);
+	if (err) {
+		dev_err(&pdev->dev, "failed to resume device: %d\n", err);
+		goto err_recovery;
+	}
+
+	/* Resume health check */
+	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
+
+	/* It can be a remote wakeup (no mhi runtime_get), update access time */
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+
+err_recovery:
+	/* Do not fail to not mess up our PCI device state, the device likely
+	 * lost power (d3cold) and we simply need to reset it from the recovery
+	 * procedure, trigger the recovery asynchronously to prevent system
+	 * suspend exit delaying.
+	 */
+	queue_work(system_long_wq, &mhi_pdev->recovery_work);
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+}
+
+static int  __maybe_unused mhi_pci_suspend(struct device *dev)
+{
+	pm_runtime_disable(dev);
+	return mhi_pci_runtime_suspend(dev);
+}
+
+static int __maybe_unused mhi_pci_resume(struct device *dev)
+{
+	int ret;
+
+	/* Depending the platform, device may have lost power (d3cold), we need
+	 * to resume it now to check its state and recover when necessary.
+	 */
+	ret = mhi_pci_runtime_resume(dev);
+	pm_runtime_enable(dev);
+
+	return ret;
+}
+
+static int __maybe_unused mhi_pci_freeze(struct device *dev)
+{
+	struct mhi_pci_device *mhi_pdev = dev_get_drvdata(dev);
+	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
+
+	/* We want to stop all operations, hibernation does not guarantee that
+	 * device will be in the same state as before freezing, especially if
+	 * the intermediate restore kernel reinitializes MHI device with new
+	 * context.
+	 */
+	flush_work(&mhi_pdev->recovery_work);
+	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
+		mhi_power_down(mhi_cntrl, true);
+		mhi_unprepare_after_power_down(mhi_cntrl);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused mhi_pci_restore(struct device *dev)
+{
+	struct mhi_pci_device *mhi_pdev = dev_get_drvdata(dev);
+
+	/* Reinitialize the device */
+	queue_work(system_long_wq, &mhi_pdev->recovery_work);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mhi_pci_pm_ops = {
+	SET_RUNTIME_PM_OPS(mhi_pci_runtime_suspend, mhi_pci_runtime_resume, NULL)
+#ifdef CONFIG_PM_SLEEP
+	.suspend = mhi_pci_suspend,
+	.resume = mhi_pci_resume,
+	.freeze = mhi_pci_freeze,
+	.thaw = mhi_pci_restore,
+	.poweroff = mhi_pci_freeze,
+	.restore = mhi_pci_restore,
+#endif
+};
+
+static struct pci_driver mhi_pci_driver = {
+	.name		= "mhi-pci-generic",
+	.id_table	= mhi_pci_id_table,
+	.probe		= mhi_pci_probe,
+	.remove		= mhi_pci_remove,
+	.shutdown	= mhi_pci_shutdown,
+	.err_handler	= &mhi_pci_err_handler,
+	.driver.pm	= &mhi_pci_pm_ops
+};
+module_pci_driver(mhi_pci_driver);
+
+MODULE_AUTHOR("Loic Poulain <loic.poulain@linaro.org>");
+MODULE_DESCRIPTION("Modem Host Interface (MHI) PCI controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
new file mode 100644
index 000000000000..1a87b9c6c2f8
--- /dev/null
+++ b/drivers/bus/mhi/host/pm.c
@@ -0,0 +1,1261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include "internal.h"
+
+/*
+ * Not all MHI state transitions are synchronous. Transitions like Linkdown,
+ * SYS_ERR, and shutdown can happen anytime asynchronously. This function will
+ * transition to a new state only if we're allowed to.
+ *
+ * Priority increases as we go down. For instance, from any state in L0, the
+ * transition can be made to states in L1, L2 and L3. A notable exception to
+ * this rule is state DISABLE.  From DISABLE state we can only transition to
+ * POR state. Also, while in L2 state, user cannot jump back to previous
+ * L1 or L0 states.
+ *
+ * Valid transitions:
+ * L0: DISABLE <--> POR
+ *     POR <--> POR
+ *     POR -> M0 -> M2 --> M0
+ *     POR -> FW_DL_ERR
+ *     FW_DL_ERR <--> FW_DL_ERR
+ *     M0 <--> M0
+ *     M0 -> FW_DL_ERR
+ *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
+ * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
+ * L2: SHUTDOWN_PROCESS -> LD_ERR_FATAL_DETECT
+ *     SHUTDOWN_PROCESS -> DISABLE
+ * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
+ *     LD_ERR_FATAL_DETECT -> DISABLE
+ */
+static struct mhi_pm_transitions const dev_state_transitions[] = {
+	/* L0 States */
+	{
+		MHI_PM_DISABLE,
+		MHI_PM_POR
+	},
+	{
+		MHI_PM_POR,
+		MHI_PM_POR | MHI_PM_DISABLE | MHI_PM_M0 |
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_FW_DL_ERR
+	},
+	{
+		MHI_PM_M0,
+		MHI_PM_M0 | MHI_PM_M2 | MHI_PM_M3_ENTER |
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_FW_DL_ERR
+	},
+	{
+		MHI_PM_M2,
+		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3_ENTER,
+		MHI_PM_M3 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3,
+		MHI_PM_M3_EXIT | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3_EXIT,
+		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_FW_DL_ERR,
+		MHI_PM_FW_DL_ERR | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L1 States */
+	{
+		MHI_PM_SYS_ERR_DETECT,
+		MHI_PM_SYS_ERR_PROCESS | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_SYS_ERR_PROCESS,
+		MHI_PM_POR | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L2 States */
+	{
+		MHI_PM_SHUTDOWN_PROCESS,
+		MHI_PM_DISABLE | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L3 States */
+	{
+		MHI_PM_LD_ERR_FATAL_DETECT,
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_DISABLE
+	},
+};
+
+enum mhi_pm_state __must_check mhi_tryset_pm_state(struct mhi_controller *mhi_cntrl,
+						   enum mhi_pm_state state)
+{
+	unsigned long cur_state = mhi_cntrl->pm_state;
+	int index = find_last_bit(&cur_state, 32);
+
+	if (unlikely(index >= ARRAY_SIZE(dev_state_transitions)))
+		return cur_state;
+
+	if (unlikely(dev_state_transitions[index].from_state != cur_state))
+		return cur_state;
+
+	if (unlikely(!(dev_state_transitions[index].to_states & state)))
+		return cur_state;
+
+	mhi_cntrl->pm_state = state;
+	return mhi_cntrl->pm_state;
+}
+
+void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum mhi_state state)
+{
+	if (state == MHI_STATE_RESET) {
+		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+				    MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 1);
+	} else {
+		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+				    MHICTRL_MHISTATE_MASK,
+				    MHICTRL_MHISTATE_SHIFT, state);
+	}
+}
+
+/* NOP for backward compatibility, host allowed to ring DB in M2 state */
+static void mhi_toggle_dev_wake_nop(struct mhi_controller *mhi_cntrl)
+{
+}
+
+static void mhi_toggle_dev_wake(struct mhi_controller *mhi_cntrl)
+{
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	mhi_cntrl->wake_put(mhi_cntrl, true);
+}
+
+/* Handle device ready state transition */
+int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_event *mhi_event;
+	enum mhi_pm_state cur_state;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 interval_us = 25000; /* poll register field every 25 milliseconds */
+	int ret, i;
+
+	/* Check if device entered error state */
+	if (MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev, "Device link is not accessible\n");
+		return -EIO;
+	}
+
+	/* Wait for RESET to be cleared and READY bit to be set by the device */
+	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
+				 interval_us);
+	if (ret) {
+		dev_err(dev, "Device failed to clear MHI Reset\n");
+		return ret;
+	}
+
+	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
+				 MHISTATUS_READY_MASK, MHISTATUS_READY_SHIFT, 1,
+				 interval_us);
+	if (ret) {
+		dev_err(dev, "Device failed to enter MHI Ready\n");
+		return ret;
+	}
+
+	dev_dbg(dev, "Device in READY State\n");
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_POR);
+	mhi_cntrl->dev_state = MHI_STATE_READY;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	if (cur_state != MHI_PM_POR) {
+		dev_err(dev, "Error moving to state %s from %s\n",
+			to_mhi_pm_state_str(MHI_PM_POR),
+			to_mhi_pm_state_str(cur_state));
+		return -EIO;
+	}
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		dev_err(dev, "Device registers not accessible\n");
+		goto error_mmio;
+	}
+
+	/* Configure MMIO registers */
+	ret = mhi_init_mmio(mhi_cntrl);
+	if (ret) {
+		dev_err(dev, "Error configuring MMIO registers\n");
+		goto error_mmio;
+	}
+
+	/* Add elements to all SW event rings */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* Skip if this is an offload or HW event */
+		if (mhi_event->offload_ev || mhi_event->hw_ring)
+			continue;
+
+		ring->wp = ring->base + ring->len - ring->el_size;
+		*ring->ctxt_wp = cpu_to_le64(ring->iommu_base + ring->len - ring->el_size);
+		/* Update all cores */
+		smp_wmb();
+
+		/* Ring the event ring db */
+		spin_lock_irq(&mhi_event->lock);
+		mhi_ring_er_db(mhi_event);
+		spin_unlock_irq(&mhi_event->lock);
+	}
+
+	/* Set MHI to M0 state */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return 0;
+
+error_mmio:
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return -EIO;
+}
+
+int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum mhi_pm_state cur_state;
+	struct mhi_chan *mhi_chan;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int i;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_M0;
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M0);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (unlikely(cur_state != MHI_PM_M0)) {
+		dev_err(dev, "Unable to transition to M0 state\n");
+		return -EIO;
+	}
+	mhi_cntrl->M0++;
+
+	/* Wake up the device */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, true);
+
+	/* Ring all event rings and CMD ring only if we're in mission mode */
+	if (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) {
+		struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+		struct mhi_cmd *mhi_cmd =
+			&mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+
+		for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+			if (mhi_event->offload_ev)
+				continue;
+
+			spin_lock_irq(&mhi_event->lock);
+			mhi_ring_er_db(mhi_event);
+			spin_unlock_irq(&mhi_event->lock);
+		}
+
+		/* Only ring primary cmd ring if ring is not empty */
+		spin_lock_irq(&mhi_cmd->lock);
+		if (mhi_cmd->ring.rp != mhi_cmd->ring.wp)
+			mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
+		spin_unlock_irq(&mhi_cmd->lock);
+	}
+
+	/* Ring channel DB registers */
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+
+		if (mhi_chan->db_cfg.reset_req) {
+			write_lock_irq(&mhi_chan->lock);
+			mhi_chan->db_cfg.db_mode = true;
+			write_unlock_irq(&mhi_chan->lock);
+		}
+
+		read_lock_irq(&mhi_chan->lock);
+
+		/* Only ring DB if ring is not empty */
+		if (tre_ring->base && tre_ring->wp  != tre_ring->rp &&
+		    mhi_chan->ch_state == MHI_CH_STATE_ENABLED)
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		read_unlock_irq(&mhi_chan->lock);
+	}
+
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	wake_up_all(&mhi_cntrl->state_event);
+
+	return 0;
+}
+
+/*
+ * After receiving the MHI state change event from the device indicating the
+ * transition to M1 state, the host can transition the device to M2 state
+ * for keeping it in low power state.
+ */
+void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum mhi_pm_state state;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M2);
+	if (state == MHI_PM_M2) {
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M2);
+		mhi_cntrl->dev_state = MHI_STATE_M2;
+
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+
+		mhi_cntrl->M2++;
+		wake_up_all(&mhi_cntrl->state_event);
+
+		/* If there are any pending resources, exit M2 immediately */
+		if (unlikely(atomic_read(&mhi_cntrl->pending_pkts) ||
+			     atomic_read(&mhi_cntrl->dev_wake))) {
+			dev_dbg(dev,
+				"Exiting M2, pending_pkts: %d dev_wake: %d\n",
+				atomic_read(&mhi_cntrl->pending_pkts),
+				atomic_read(&mhi_cntrl->dev_wake));
+			read_lock_bh(&mhi_cntrl->pm_lock);
+			mhi_cntrl->wake_get(mhi_cntrl, true);
+			mhi_cntrl->wake_put(mhi_cntrl, true);
+			read_unlock_bh(&mhi_cntrl->pm_lock);
+		} else {
+			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_IDLE);
+		}
+	} else {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+	}
+}
+
+/* MHI M3 completion handler */
+int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum mhi_pm_state state;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_M3;
+	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (state != MHI_PM_M3) {
+		dev_err(dev, "Unable to transition to M3 state\n");
+		return -EIO;
+	}
+
+	mhi_cntrl->M3++;
+	wake_up_all(&mhi_cntrl->state_event);
+
+	return 0;
+}
+
+/* Handle device Mission Mode transition */
+static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_event *mhi_event;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_ee_type ee = MHI_EE_MAX, current_ee = mhi_cntrl->ee;
+	int i, ret;
+
+	dev_dbg(dev, "Processing Mission Mode transition\n");
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		ee = mhi_get_exec_env(mhi_cntrl);
+
+	if (!MHI_IN_MISSION_MODE(ee)) {
+		mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		wake_up_all(&mhi_cntrl->state_event);
+		return -EIO;
+	}
+	mhi_cntrl->ee = ee;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	wake_up_all(&mhi_cntrl->state_event);
+
+	device_for_each_child(&mhi_cntrl->mhi_dev->dev, &current_ee,
+			      mhi_destroy_device);
+	mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_MISSION_MODE);
+
+	/* Force MHI to be in M0 state before continuing */
+	ret = __mhi_device_get_sync(mhi_cntrl);
+	if (ret)
+		return ret;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		ret = -EIO;
+		goto error_mission_mode;
+	}
+
+	/* Add elements to all HW event rings */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev || !mhi_event->hw_ring)
+			continue;
+
+		ring->wp = ring->base + ring->len - ring->el_size;
+		*ring->ctxt_wp = cpu_to_le64(ring->iommu_base + ring->len - ring->el_size);
+		/* Update to all cores */
+		smp_wmb();
+
+		spin_lock_irq(&mhi_event->lock);
+		if (MHI_DB_ACCESS_VALID(mhi_cntrl))
+			mhi_ring_er_db(mhi_event);
+		spin_unlock_irq(&mhi_event->lock);
+	}
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	/*
+	 * The MHI devices are only created when the client device switches its
+	 * Execution Environment (EE) to either SBL or AMSS states
+	 */
+	mhi_create_devices(mhi_cntrl);
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+
+error_mission_mode:
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return ret;
+}
+
+/* Handle shutdown transitions */
+static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum mhi_pm_state cur_state;
+	struct mhi_event *mhi_event;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_event_ctxt *er_ctxt;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret, i;
+
+	dev_dbg(dev, "Processing disable transition with PM state: %s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state));
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	/* Trigger MHI RESET so that the device will not access host memory */
+	if (!MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
+		dev_dbg(dev, "Triggering MHI Reset in device\n");
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
+
+		/* Wait for the reset bit to be cleared by the device */
+		ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
+				 25000);
+		if (ret)
+			dev_err(dev, "Device failed to clear MHI Reset\n");
+
+		/*
+		 * Device will clear BHI_INTVEC as a part of RESET processing,
+		 * hence re-program it
+		 */
+		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	}
+
+	dev_dbg(dev,
+		 "Waiting for all pending event ring processing to complete\n");
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
+		tasklet_kill(&mhi_event->task);
+	}
+
+	/* Release lock and wait for all pending threads to complete */
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+	dev_dbg(dev, "Waiting for all pending threads to complete\n");
+	wake_up_all(&mhi_cntrl->state_event);
+
+	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
+	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	WARN_ON(atomic_read(&mhi_cntrl->dev_wake));
+	WARN_ON(atomic_read(&mhi_cntrl->pending_pkts));
+
+	/* Reset the ev rings and cmd rings */
+	dev_dbg(dev, "Resetting EV CTXT and CMD CTXT\n");
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	cmd_ctxt = mhi_cntrl->mhi_ctxt->cmd_ctxt;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		ring->rp = ring->base;
+		ring->wp = ring->base;
+		cmd_ctxt->rp = cmd_ctxt->rbase;
+		cmd_ctxt->wp = cmd_ctxt->rbase;
+	}
+
+	mhi_event = mhi_cntrl->mhi_event;
+	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
+		     mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* Skip offload events */
+		if (mhi_event->offload_ev)
+			continue;
+
+		ring->rp = ring->base;
+		ring->wp = ring->base;
+		er_ctxt->rp = er_ctxt->rbase;
+		er_ctxt->wp = er_ctxt->rbase;
+	}
+
+	/* Move to disable state */
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_DISABLE);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (unlikely(cur_state != MHI_PM_DISABLE))
+		dev_err(dev, "Error moving from PM state: %s to: %s\n",
+			to_mhi_pm_state_str(cur_state),
+			to_mhi_pm_state_str(MHI_PM_DISABLE));
+
+	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+}
+
+/* Handle system error transitions */
+static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum mhi_pm_state cur_state, prev_state;
+	enum dev_st_transition next_state;
+	struct mhi_event *mhi_event;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_event_ctxt *er_ctxt;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret, i;
+
+	dev_dbg(dev, "Transitioning from PM state: %s to: %s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		to_mhi_pm_state_str(MHI_PM_SYS_ERR_PROCESS));
+
+	/* We must notify MHI control driver so it can clean up first */
+	mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_SYS_ERROR);
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	prev_state = mhi_cntrl->pm_state;
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_SYS_ERR_PROCESS);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	if (cur_state != MHI_PM_SYS_ERR_PROCESS) {
+		dev_err(dev, "Failed to transition from PM state: %s to: %s\n",
+			to_mhi_pm_state_str(cur_state),
+			to_mhi_pm_state_str(MHI_PM_SYS_ERR_PROCESS));
+		goto exit_sys_error_transition;
+	}
+
+	mhi_cntrl->ee = MHI_EE_DISABLE_TRANSITION;
+	mhi_cntrl->dev_state = MHI_STATE_RESET;
+
+	/* Wake up threads waiting for state transition */
+	wake_up_all(&mhi_cntrl->state_event);
+
+	/* Trigger MHI RESET so that the device will not access host memory */
+	if (MHI_REG_ACCESS_VALID(prev_state)) {
+		u32 in_reset = -1;
+		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
+
+		dev_dbg(dev, "Triggering MHI Reset in device\n");
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
+
+		/* Wait for the reset bit to be cleared by the device */
+		ret = wait_event_timeout(mhi_cntrl->state_event,
+					 mhi_read_reg_field(mhi_cntrl,
+							    mhi_cntrl->regs,
+							    MHICTRL,
+							    MHICTRL_RESET_MASK,
+							    MHICTRL_RESET_SHIFT,
+							    &in_reset) ||
+					!in_reset, timeout);
+		if (!ret || in_reset) {
+			dev_err(dev, "Device failed to exit MHI Reset state\n");
+			goto exit_sys_error_transition;
+		}
+
+		/*
+		 * Device will clear BHI_INTVEC as a part of RESET processing,
+		 * hence re-program it
+		 */
+		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	}
+
+	dev_dbg(dev,
+		"Waiting for all pending event ring processing to complete\n");
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+		tasklet_kill(&mhi_event->task);
+	}
+
+	/* Release lock and wait for all pending threads to complete */
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+	dev_dbg(dev, "Waiting for all pending threads to complete\n");
+	wake_up_all(&mhi_cntrl->state_event);
+
+	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
+	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	WARN_ON(atomic_read(&mhi_cntrl->dev_wake));
+	WARN_ON(atomic_read(&mhi_cntrl->pending_pkts));
+
+	/* Reset the ev rings and cmd rings */
+	dev_dbg(dev, "Resetting EV CTXT and CMD CTXT\n");
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	cmd_ctxt = mhi_cntrl->mhi_ctxt->cmd_ctxt;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		ring->rp = ring->base;
+		ring->wp = ring->base;
+		cmd_ctxt->rp = cmd_ctxt->rbase;
+		cmd_ctxt->wp = cmd_ctxt->rbase;
+	}
+
+	mhi_event = mhi_cntrl->mhi_event;
+	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
+	     mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* Skip offload events */
+		if (mhi_event->offload_ev)
+			continue;
+
+		ring->rp = ring->base;
+		ring->wp = ring->base;
+		er_ctxt->rp = er_ctxt->rbase;
+		er_ctxt->wp = er_ctxt->rbase;
+	}
+
+	/* Transition to next state */
+	if (MHI_IN_PBL(mhi_get_exec_env(mhi_cntrl))) {
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_POR);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (cur_state != MHI_PM_POR) {
+			dev_err(dev, "Error moving to state %s from %s\n",
+				to_mhi_pm_state_str(MHI_PM_POR),
+				to_mhi_pm_state_str(cur_state));
+			goto exit_sys_error_transition;
+		}
+		next_state = DEV_ST_TRANSITION_PBL;
+	} else {
+		next_state = DEV_ST_TRANSITION_READY;
+	}
+
+	mhi_queue_state_transition(mhi_cntrl, next_state);
+
+exit_sys_error_transition:
+	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+}
+
+/* Queue a new work item and schedule work */
+int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
+			       enum dev_st_transition state)
+{
+	struct state_transition *item = kmalloc(sizeof(*item), GFP_ATOMIC);
+	unsigned long flags;
+
+	if (!item)
+		return -ENOMEM;
+
+	item->state = state;
+	spin_lock_irqsave(&mhi_cntrl->transition_lock, flags);
+	list_add_tail(&item->node, &mhi_cntrl->transition_list);
+	spin_unlock_irqrestore(&mhi_cntrl->transition_lock, flags);
+
+	queue_work(mhi_cntrl->hiprio_wq, &mhi_cntrl->st_worker);
+
+	return 0;
+}
+
+/* SYS_ERR worker */
+void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	/* skip if controller supports RDDM */
+	if (mhi_cntrl->rddm_image) {
+		dev_dbg(dev, "Controller supports RDDM, skip SYS_ERROR\n");
+		return;
+	}
+
+	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_SYS_ERR);
+}
+
+/* Device State Transition worker */
+void mhi_pm_st_worker(struct work_struct *work)
+{
+	struct state_transition *itr, *tmp;
+	LIST_HEAD(head);
+	struct mhi_controller *mhi_cntrl = container_of(work,
+							struct mhi_controller,
+							st_worker);
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	spin_lock_irq(&mhi_cntrl->transition_lock);
+	list_splice_tail_init(&mhi_cntrl->transition_list, &head);
+	spin_unlock_irq(&mhi_cntrl->transition_lock);
+
+	list_for_each_entry_safe(itr, tmp, &head, node) {
+		list_del(&itr->node);
+		dev_dbg(dev, "Handling state transition: %s\n",
+			TO_DEV_STATE_TRANS_STR(itr->state));
+
+		switch (itr->state) {
+		case DEV_ST_TRANSITION_PBL:
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+				mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			mhi_fw_load_handler(mhi_cntrl);
+			break;
+		case DEV_ST_TRANSITION_SBL:
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			mhi_cntrl->ee = MHI_EE_SBL;
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			/*
+			 * The MHI devices are only created when the client
+			 * device switches its Execution Environment (EE) to
+			 * either SBL or AMSS states
+			 */
+			mhi_create_devices(mhi_cntrl);
+			if (mhi_cntrl->fbc_download)
+				mhi_download_amss_image(mhi_cntrl);
+			break;
+		case DEV_ST_TRANSITION_MISSION_MODE:
+			mhi_pm_mission_mode_transition(mhi_cntrl);
+			break;
+		case DEV_ST_TRANSITION_FP:
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			mhi_cntrl->ee = MHI_EE_FP;
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			mhi_create_devices(mhi_cntrl);
+			break;
+		case DEV_ST_TRANSITION_READY:
+			mhi_ready_state_transition(mhi_cntrl);
+			break;
+		case DEV_ST_TRANSITION_SYS_ERR:
+			mhi_pm_sys_error_transition(mhi_cntrl);
+			break;
+		case DEV_ST_TRANSITION_DISABLE:
+			mhi_pm_disable_transition(mhi_cntrl);
+			break;
+		default:
+			break;
+		}
+		kfree(itr);
+	}
+}
+
+int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_chan *itr, *tmp;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
+	int ret;
+
+	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
+		return -EINVAL;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	/* Return busy if there are any pending resources */
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_cntrl->pending_pkts))
+		return -EBUSY;
+
+	/* Take MHI out of M2 state */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 mhi_cntrl->dev_state == MHI_STATE_M1 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev,
+			"Could not enter M0/M1 state");
+		return -EIO;
+	}
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_cntrl->pending_pkts)) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		return -EBUSY;
+	}
+
+	dev_dbg(dev, "Allowing M3 transition\n");
+	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_ENTER);
+	if (new_state != MHI_PM_M3_ENTER) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		dev_err(dev,
+			"Error setting to PM state: %s from: %s\n",
+			to_mhi_pm_state_str(MHI_PM_M3_ENTER),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* Set MHI to M3 and wait for completion */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	dev_dbg(dev, "Waiting for M3 completion\n");
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M3 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev,
+			"Did not enter M3 state, MHI state: %s, PM state: %s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* Notify clients about entering LPM */
+	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
+		mutex_lock(&itr->mutex);
+		if (itr->mhi_dev)
+			mhi_notify(itr->mhi_dev, MHI_CB_LPM_ENTER);
+		mutex_unlock(&itr->mutex);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhi_pm_suspend);
+
+static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
+{
+	struct mhi_chan *itr, *tmp;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state cur_state;
+	int ret;
+
+	dev_dbg(dev, "Entered with PM state: %s, MHI state: %s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+
+	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
+		return 0;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3) {
+		dev_warn(dev, "Resuming from non M3 state (%s)\n",
+			 TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
+		if (!force)
+			return -EINVAL;
+	}
+
+	/* Notify clients about exiting LPM */
+	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
+		mutex_lock(&itr->mutex);
+		if (itr->mhi_dev)
+			mhi_notify(itr->mhi_dev, MHI_CB_LPM_EXIT);
+		mutex_unlock(&itr->mutex);
+	}
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_EXIT);
+	if (cur_state != MHI_PM_M3_EXIT) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		dev_info(dev,
+			 "Error setting to PM state: %s from: %s\n",
+			 to_mhi_pm_state_str(MHI_PM_M3_EXIT),
+			 to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* Set MHI to M0 and wait for completion */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 mhi_cntrl->dev_state == MHI_STATE_M2 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev,
+			"Did not enter M0 state, MHI state: %s, PM state: %s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
+{
+	return __mhi_pm_resume(mhi_cntrl, false);
+}
+EXPORT_SYMBOL_GPL(mhi_pm_resume);
+
+int mhi_pm_resume_force(struct mhi_controller *mhi_cntrl)
+{
+	return __mhi_pm_resume(mhi_cntrl, true);
+}
+EXPORT_SYMBOL_GPL(mhi_pm_resume_force);
+
+int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+
+	/* Wake up the device */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+	mhi_cntrl->wake_get(mhi_cntrl, true);
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->pm_state == MHI_PM_M0 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		mhi_cntrl->wake_put(mhi_cntrl, false);
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Assert device wake db */
+static void mhi_assert_dev_wake(struct mhi_controller *mhi_cntrl, bool force)
+{
+	unsigned long flags;
+
+	/*
+	 * If force flag is set, then increment the wake count value and
+	 * ring wake db
+	 */
+	if (unlikely(force)) {
+		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+		atomic_inc(&mhi_cntrl->dev_wake);
+		if (MHI_WAKE_DB_FORCE_SET_VALID(mhi_cntrl->pm_state) &&
+		    !mhi_cntrl->wake_set) {
+			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
+			mhi_cntrl->wake_set = true;
+		}
+		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+	} else {
+		/*
+		 * If resources are already requested, then just increment
+		 * the wake count value and return
+		 */
+		if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, 1, 0)))
+			return;
+
+		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+		if ((atomic_inc_return(&mhi_cntrl->dev_wake) == 1) &&
+		    MHI_WAKE_DB_SET_VALID(mhi_cntrl->pm_state) &&
+		    !mhi_cntrl->wake_set) {
+			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
+			mhi_cntrl->wake_set = true;
+		}
+		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+	}
+}
+
+/* De-assert device wake db */
+static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
+				  bool override)
+{
+	unsigned long flags;
+
+	/*
+	 * Only continue if there is a single resource, else just decrement
+	 * and return
+	 */
+	if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, -1, 1)))
+		return;
+
+	spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+	if ((atomic_dec_return(&mhi_cntrl->dev_wake) == 0) &&
+	    MHI_WAKE_DB_CLEAR_VALID(mhi_cntrl->pm_state) && !override &&
+	    mhi_cntrl->wake_set) {
+		mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 0);
+		mhi_cntrl->wake_set = false;
+	}
+	spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+}
+
+int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
+{
+	enum mhi_state state;
+	enum mhi_ee_type current_ee;
+	enum dev_st_transition next_state;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 interval_us = 25000; /* poll register field every 25 milliseconds */
+	int ret;
+
+	dev_info(dev, "Requested to power ON\n");
+
+	/* Supply default wake routines if not provided by controller driver */
+	if (!mhi_cntrl->wake_get || !mhi_cntrl->wake_put ||
+	    !mhi_cntrl->wake_toggle) {
+		mhi_cntrl->wake_get = mhi_assert_dev_wake;
+		mhi_cntrl->wake_put = mhi_deassert_dev_wake;
+		mhi_cntrl->wake_toggle = (mhi_cntrl->db_access & MHI_PM_M2) ?
+			mhi_toggle_dev_wake_nop : mhi_toggle_dev_wake;
+	}
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	mhi_cntrl->pm_state = MHI_PM_DISABLE;
+
+	/* Setup BHI INTVEC */
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	mhi_cntrl->pm_state = MHI_PM_POR;
+	mhi_cntrl->ee = MHI_EE_MAX;
+	current_ee = mhi_get_exec_env(mhi_cntrl);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/* Confirm that the device is in valid exec env */
+	if (!MHI_IN_PBL(current_ee) && current_ee != MHI_EE_AMSS) {
+		dev_err(dev, "%s is not a valid EE for power on\n",
+			TO_MHI_EXEC_STR(current_ee));
+		ret = -EIO;
+		goto error_exit;
+	}
+
+	state = mhi_get_mhi_state(mhi_cntrl);
+	dev_dbg(dev, "Attempting power on with EE: %s, state: %s\n",
+		TO_MHI_EXEC_STR(current_ee), TO_MHI_STATE_STR(state));
+
+	if (state == MHI_STATE_SYS_ERR) {
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
+		ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
+				 interval_us);
+		if (ret) {
+			dev_info(dev, "Failed to reset MHI due to syserr state\n");
+			goto error_exit;
+		}
+
+		/*
+		 * device cleares INTVEC as part of RESET processing,
+		 * re-program it
+		 */
+		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	}
+
+	ret = mhi_init_irq_setup(mhi_cntrl);
+	if (ret)
+		goto error_exit;
+
+	/* Transition to next state */
+	next_state = MHI_IN_PBL(current_ee) ?
+		DEV_ST_TRANSITION_PBL : DEV_ST_TRANSITION_READY;
+
+	mhi_queue_state_transition(mhi_cntrl, next_state);
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	dev_info(dev, "Power on setup success\n");
+
+	return 0;
+
+error_exit:
+	mhi_cntrl->pm_state = MHI_PM_DISABLE;
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_async_power_up);
+
+void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
+{
+	enum mhi_pm_state cur_state, transition_state;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_cntrl->pm_state;
+	if (cur_state == MHI_PM_DISABLE) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		mutex_unlock(&mhi_cntrl->pm_mutex);
+		return; /* Already powered down */
+	}
+
+	/* If it's not a graceful shutdown, force MHI to linkdown state */
+	transition_state = (graceful) ? MHI_PM_SHUTDOWN_PROCESS :
+			   MHI_PM_LD_ERR_FATAL_DETECT;
+
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, transition_state);
+	if (cur_state != transition_state) {
+		dev_err(dev, "Failed to move to state: %s from: %s\n",
+			to_mhi_pm_state_str(transition_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		/* Force link down or error fatal detected state */
+		mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
+	}
+
+	/* mark device inactive to avoid any further host processing */
+	mhi_cntrl->ee = MHI_EE_DISABLE_TRANSITION;
+	mhi_cntrl->dev_state = MHI_STATE_RESET;
+
+	wake_up_all(&mhi_cntrl->state_event);
+
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
+
+	/* Wait for shutdown to complete */
+	flush_work(&mhi_cntrl->st_worker);
+
+	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+}
+EXPORT_SYMBOL_GPL(mhi_power_down);
+
+int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
+{
+	int ret = mhi_async_power_up(mhi_cntrl);
+
+	if (ret)
+		return ret;
+
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_IN_MISSION_MODE(mhi_cntrl->ee) ||
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
+	if (ret)
+		mhi_power_down(mhi_cntrl, false);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_sync_power_up);
+
+int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret;
+
+	/* Check if device is already in RDDM */
+	if (mhi_cntrl->ee == MHI_EE_RDDM)
+		return 0;
+
+	dev_dbg(dev, "Triggering SYS_ERR to force RDDM state\n");
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
+
+	/* Wait for RDDM event */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->ee == MHI_EE_RDDM,
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	ret = ret ? 0 : -EIO;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_force_rddm_mode);
+
+void mhi_device_get(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	mhi_dev->dev_wake++;
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
+
+	mhi_cntrl->wake_get(mhi_cntrl, true);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+EXPORT_SYMBOL_GPL(mhi_device_get);
+
+int mhi_device_get_sync(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int ret;
+
+	ret = __mhi_device_get_sync(mhi_cntrl);
+	if (!ret)
+		mhi_dev->dev_wake++;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_device_get_sync);
+
+void mhi_device_put(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	mhi_dev->dev_wake--;
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
+
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+EXPORT_SYMBOL_GPL(mhi_device_put);
diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
deleted file mode 100644
index b780990faf80..000000000000
--- a/drivers/bus/mhi/pci_generic.c
+++ /dev/null
@@ -1,1146 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * MHI PCI driver - MHI over PCI controller driver
- *
- * This module is a generic driver for registering MHI-over-PCI devices,
- * such as PCIe QCOM modems.
- *
- * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
- */
-
-#include <linux/aer.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/mhi.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/pm_runtime.h>
-#include <linux/timer.h>
-#include <linux/workqueue.h>
-
-#define MHI_PCI_DEFAULT_BAR_NUM 0
-
-#define MHI_POST_RESET_DELAY_MS 2000
-
-#define HEALTH_CHECK_PERIOD (HZ * 2)
-
-/**
- * struct mhi_pci_dev_info - MHI PCI device specific information
- * @config: MHI controller configuration
- * @name: name of the PCI module
- * @fw: firmware path (if any)
- * @edl: emergency download mode firmware path (if any)
- * @bar_num: PCI base address register to use for MHI MMIO register space
- * @dma_data_width: DMA transfer word size (32 or 64 bits)
- * @mru_default: default MRU size for MBIM network packets
- * @sideband_wake: Devices using dedicated sideband GPIO for wakeup instead
- *		   of inband wake support (such as sdx24)
- */
-struct mhi_pci_dev_info {
-	const struct mhi_controller_config *config;
-	const char *name;
-	const char *fw;
-	const char *edl;
-	unsigned int bar_num;
-	unsigned int dma_data_width;
-	unsigned int mru_default;
-	bool sideband_wake;
-};
-
-#define MHI_CHANNEL_CONFIG_UL(ch_num, ch_name, el_count, ev_ring) \
-	{						\
-		.num = ch_num,				\
-		.name = ch_name,			\
-		.num_elements = el_count,		\
-		.event_ring = ev_ring,			\
-		.dir = DMA_TO_DEVICE,			\
-		.ee_mask = BIT(MHI_EE_AMSS),		\
-		.pollcfg = 0,				\
-		.doorbell = MHI_DB_BRST_DISABLE,	\
-		.lpm_notify = false,			\
-		.offload_channel = false,		\
-		.doorbell_mode_switch = false,		\
-	}						\
-
-#define MHI_CHANNEL_CONFIG_DL(ch_num, ch_name, el_count, ev_ring) \
-	{						\
-		.num = ch_num,				\
-		.name = ch_name,			\
-		.num_elements = el_count,		\
-		.event_ring = ev_ring,			\
-		.dir = DMA_FROM_DEVICE,			\
-		.ee_mask = BIT(MHI_EE_AMSS),		\
-		.pollcfg = 0,				\
-		.doorbell = MHI_DB_BRST_DISABLE,	\
-		.lpm_notify = false,			\
-		.offload_channel = false,		\
-		.doorbell_mode_switch = false,		\
-	}
-
-#define MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(ch_num, ch_name, el_count, ev_ring) \
-	{						\
-		.num = ch_num,				\
-		.name = ch_name,			\
-		.num_elements = el_count,		\
-		.event_ring = ev_ring,			\
-		.dir = DMA_FROM_DEVICE,			\
-		.ee_mask = BIT(MHI_EE_AMSS),		\
-		.pollcfg = 0,				\
-		.doorbell = MHI_DB_BRST_DISABLE,	\
-		.lpm_notify = false,			\
-		.offload_channel = false,		\
-		.doorbell_mode_switch = false,		\
-		.auto_queue = true,			\
-	}
-
-#define MHI_EVENT_CONFIG_CTRL(ev_ring, el_count) \
-	{					\
-		.num_elements = el_count,	\
-		.irq_moderation_ms = 0,		\
-		.irq = (ev_ring) + 1,		\
-		.priority = 1,			\
-		.mode = MHI_DB_BRST_DISABLE,	\
-		.data_type = MHI_ER_CTRL,	\
-		.hardware_event = false,	\
-		.client_managed = false,	\
-		.offload_channel = false,	\
-	}
-
-#define MHI_CHANNEL_CONFIG_HW_UL(ch_num, ch_name, el_count, ev_ring) \
-	{						\
-		.num = ch_num,				\
-		.name = ch_name,			\
-		.num_elements = el_count,		\
-		.event_ring = ev_ring,			\
-		.dir = DMA_TO_DEVICE,			\
-		.ee_mask = BIT(MHI_EE_AMSS),		\
-		.pollcfg = 0,				\
-		.doorbell = MHI_DB_BRST_ENABLE,	\
-		.lpm_notify = false,			\
-		.offload_channel = false,		\
-		.doorbell_mode_switch = true,		\
-	}						\
-
-#define MHI_CHANNEL_CONFIG_HW_DL(ch_num, ch_name, el_count, ev_ring) \
-	{						\
-		.num = ch_num,				\
-		.name = ch_name,			\
-		.num_elements = el_count,		\
-		.event_ring = ev_ring,			\
-		.dir = DMA_FROM_DEVICE,			\
-		.ee_mask = BIT(MHI_EE_AMSS),		\
-		.pollcfg = 0,				\
-		.doorbell = MHI_DB_BRST_ENABLE,	\
-		.lpm_notify = false,			\
-		.offload_channel = false,		\
-		.doorbell_mode_switch = true,		\
-	}
-
-#define MHI_CHANNEL_CONFIG_UL_SBL(ch_num, ch_name, el_count, ev_ring) \
-	{						\
-		.num = ch_num,				\
-		.name = ch_name,			\
-		.num_elements = el_count,		\
-		.event_ring = ev_ring,			\
-		.dir = DMA_TO_DEVICE,			\
-		.ee_mask = BIT(MHI_EE_SBL),		\
-		.pollcfg = 0,				\
-		.doorbell = MHI_DB_BRST_DISABLE,	\
-		.lpm_notify = false,			\
-		.offload_channel = false,		\
-		.doorbell_mode_switch = false,		\
-	}						\
-
-#define MHI_CHANNEL_CONFIG_DL_SBL(ch_num, ch_name, el_count, ev_ring) \
-	{						\
-		.num = ch_num,				\
-		.name = ch_name,			\
-		.num_elements = el_count,		\
-		.event_ring = ev_ring,			\
-		.dir = DMA_FROM_DEVICE,			\
-		.ee_mask = BIT(MHI_EE_SBL),		\
-		.pollcfg = 0,				\
-		.doorbell = MHI_DB_BRST_DISABLE,	\
-		.lpm_notify = false,			\
-		.offload_channel = false,		\
-		.doorbell_mode_switch = false,		\
-	}
-
-#define MHI_CHANNEL_CONFIG_UL_FP(ch_num, ch_name, el_count, ev_ring) \
-	{						\
-		.num = ch_num,				\
-		.name = ch_name,			\
-		.num_elements = el_count,		\
-		.event_ring = ev_ring,			\
-		.dir = DMA_TO_DEVICE,			\
-		.ee_mask = BIT(MHI_EE_FP),		\
-		.pollcfg = 0,				\
-		.doorbell = MHI_DB_BRST_DISABLE,	\
-		.lpm_notify = false,			\
-		.offload_channel = false,		\
-		.doorbell_mode_switch = false,		\
-	}						\
-
-#define MHI_CHANNEL_CONFIG_DL_FP(ch_num, ch_name, el_count, ev_ring) \
-	{						\
-		.num = ch_num,				\
-		.name = ch_name,			\
-		.num_elements = el_count,		\
-		.event_ring = ev_ring,			\
-		.dir = DMA_FROM_DEVICE,			\
-		.ee_mask = BIT(MHI_EE_FP),		\
-		.pollcfg = 0,				\
-		.doorbell = MHI_DB_BRST_DISABLE,	\
-		.lpm_notify = false,			\
-		.offload_channel = false,		\
-		.doorbell_mode_switch = false,		\
-	}
-
-#define MHI_EVENT_CONFIG_DATA(ev_ring, el_count) \
-	{					\
-		.num_elements = el_count,	\
-		.irq_moderation_ms = 5,		\
-		.irq = (ev_ring) + 1,		\
-		.priority = 1,			\
-		.mode = MHI_DB_BRST_DISABLE,	\
-		.data_type = MHI_ER_DATA,	\
-		.hardware_event = false,	\
-		.client_managed = false,	\
-		.offload_channel = false,	\
-	}
-
-#define MHI_EVENT_CONFIG_HW_DATA(ev_ring, el_count, ch_num) \
-	{					\
-		.num_elements = el_count,	\
-		.irq_moderation_ms = 1,		\
-		.irq = (ev_ring) + 1,		\
-		.priority = 1,			\
-		.mode = MHI_DB_BRST_DISABLE,	\
-		.data_type = MHI_ER_DATA,	\
-		.hardware_event = true,		\
-		.client_managed = false,	\
-		.offload_channel = false,	\
-		.channel = ch_num,		\
-	}
-
-static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
-	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
-	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
-	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 4, 0),
-	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 4, 0),
-	MHI_CHANNEL_CONFIG_UL(14, "QMI", 4, 0),
-	MHI_CHANNEL_CONFIG_DL(15, "QMI", 4, 0),
-	MHI_CHANNEL_CONFIG_UL(20, "IPCR", 8, 0),
-	MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(21, "IPCR", 8, 0),
-	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
-	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
-	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 2),
-	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 3),
-};
-
-static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
-	/* first ring is control+data ring */
-	MHI_EVENT_CONFIG_CTRL(0, 64),
-	/* DIAG dedicated event ring */
-	MHI_EVENT_CONFIG_DATA(1, 128),
-	/* Hardware channels request dedicated hardware event rings */
-	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
-	MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101)
-};
-
-static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
-	.max_channels = 128,
-	.timeout_ms = 8000,
-	.num_channels = ARRAY_SIZE(modem_qcom_v1_mhi_channels),
-	.ch_cfg = modem_qcom_v1_mhi_channels,
-	.num_events = ARRAY_SIZE(modem_qcom_v1_mhi_events),
-	.event_cfg = modem_qcom_v1_mhi_events,
-};
-
-static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
-	.name = "qcom-sdx65m",
-	.fw = "qcom/sdx65m/xbl.elf",
-	.edl = "qcom/sdx65m/edl.mbn",
-	.config = &modem_qcom_v1_mhiv_config,
-	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32,
-	.sideband_wake = false,
-};
-
-static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
-	.name = "qcom-sdx55m",
-	.fw = "qcom/sdx55m/sbl1.mbn",
-	.edl = "qcom/sdx55m/edl.mbn",
-	.config = &modem_qcom_v1_mhiv_config,
-	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32,
-	.mru_default = 32768,
-	.sideband_wake = false,
-};
-
-static const struct mhi_pci_dev_info mhi_qcom_sdx24_info = {
-	.name = "qcom-sdx24",
-	.edl = "qcom/prog_firehose_sdx24.mbn",
-	.config = &modem_qcom_v1_mhiv_config,
-	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32,
-	.sideband_wake = true,
-};
-
-static const struct mhi_channel_config mhi_quectel_em1xx_channels[] = {
-	MHI_CHANNEL_CONFIG_UL(0, "NMEA", 32, 0),
-	MHI_CHANNEL_CONFIG_DL(1, "NMEA", 32, 0),
-	MHI_CHANNEL_CONFIG_UL_SBL(2, "SAHARA", 32, 0),
-	MHI_CHANNEL_CONFIG_DL_SBL(3, "SAHARA", 32, 0),
-	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 32, 1),
-	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 32, 1),
-	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
-	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
-	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
-	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
-	/* The EDL firmware is a flash-programmer exposing firehose protocol */
-	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
-	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
-	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
-	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
-};
-
-static struct mhi_event_config mhi_quectel_em1xx_events[] = {
-	MHI_EVENT_CONFIG_CTRL(0, 128),
-	MHI_EVENT_CONFIG_DATA(1, 128),
-	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
-	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101)
-};
-
-static const struct mhi_controller_config modem_quectel_em1xx_config = {
-	.max_channels = 128,
-	.timeout_ms = 20000,
-	.num_channels = ARRAY_SIZE(mhi_quectel_em1xx_channels),
-	.ch_cfg = mhi_quectel_em1xx_channels,
-	.num_events = ARRAY_SIZE(mhi_quectel_em1xx_events),
-	.event_cfg = mhi_quectel_em1xx_events,
-};
-
-static const struct mhi_pci_dev_info mhi_quectel_em1xx_info = {
-	.name = "quectel-em1xx",
-	.edl = "qcom/prog_firehose_sdx24.mbn",
-	.config = &modem_quectel_em1xx_config,
-	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32,
-	.mru_default = 32768,
-	.sideband_wake = true,
-};
-
-static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
-	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 32, 0),
-	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 32, 0),
-	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 32, 1),
-	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 32, 1),
-	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
-	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
-	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
-	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
-	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
-	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
-};
-
-static struct mhi_event_config mhi_foxconn_sdx55_events[] = {
-	MHI_EVENT_CONFIG_CTRL(0, 128),
-	MHI_EVENT_CONFIG_DATA(1, 128),
-	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
-	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101)
-};
-
-static const struct mhi_controller_config modem_foxconn_sdx55_config = {
-	.max_channels = 128,
-	.timeout_ms = 20000,
-	.num_channels = ARRAY_SIZE(mhi_foxconn_sdx55_channels),
-	.ch_cfg = mhi_foxconn_sdx55_channels,
-	.num_events = ARRAY_SIZE(mhi_foxconn_sdx55_events),
-	.event_cfg = mhi_foxconn_sdx55_events,
-};
-
-static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
-	.name = "foxconn-sdx55",
-	.fw = "qcom/sdx55m/sbl1.mbn",
-	.edl = "qcom/sdx55m/edl.mbn",
-	.config = &modem_foxconn_sdx55_config,
-	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32,
-	.mru_default = 32768,
-	.sideband_wake = false,
-};
-
-static const struct mhi_channel_config mhi_mv31_channels[] = {
-	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 64, 0),
-	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 64, 0),
-	/* MBIM Control Channel */
-	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 64, 0),
-	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 64, 0),
-	/* MBIM Data Channel */
-	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 512, 2),
-	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 512, 3),
-};
-
-static struct mhi_event_config mhi_mv31_events[] = {
-	MHI_EVENT_CONFIG_CTRL(0, 256),
-	MHI_EVENT_CONFIG_DATA(1, 256),
-	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
-	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101),
-};
-
-static const struct mhi_controller_config modem_mv31_config = {
-	.max_channels = 128,
-	.timeout_ms = 20000,
-	.num_channels = ARRAY_SIZE(mhi_mv31_channels),
-	.ch_cfg = mhi_mv31_channels,
-	.num_events = ARRAY_SIZE(mhi_mv31_events),
-	.event_cfg = mhi_mv31_events,
-};
-
-static const struct mhi_pci_dev_info mhi_mv31_info = {
-	.name = "cinterion-mv31",
-	.config = &modem_mv31_config,
-	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32,
-	.mru_default = 32768,
-};
-
-static const struct mhi_channel_config mhi_telit_fn980_hw_v1_channels[] = {
-	MHI_CHANNEL_CONFIG_UL(14, "QMI", 32, 0),
-	MHI_CHANNEL_CONFIG_DL(15, "QMI", 32, 0),
-	MHI_CHANNEL_CONFIG_UL(20, "IPCR", 16, 0),
-	MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(21, "IPCR", 16, 0),
-	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 1),
-	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 2),
-};
-
-static struct mhi_event_config mhi_telit_fn980_hw_v1_events[] = {
-	MHI_EVENT_CONFIG_CTRL(0, 128),
-	MHI_EVENT_CONFIG_HW_DATA(1, 1024, 100),
-	MHI_EVENT_CONFIG_HW_DATA(2, 2048, 101)
-};
-
-static struct mhi_controller_config modem_telit_fn980_hw_v1_config = {
-	.max_channels = 128,
-	.timeout_ms = 20000,
-	.num_channels = ARRAY_SIZE(mhi_telit_fn980_hw_v1_channels),
-	.ch_cfg = mhi_telit_fn980_hw_v1_channels,
-	.num_events = ARRAY_SIZE(mhi_telit_fn980_hw_v1_events),
-	.event_cfg = mhi_telit_fn980_hw_v1_events,
-};
-
-static const struct mhi_pci_dev_info mhi_telit_fn980_hw_v1_info = {
-	.name = "telit-fn980-hwv1",
-	.fw = "qcom/sdx55m/sbl1.mbn",
-	.edl = "qcom/sdx55m/edl.mbn",
-	.config = &modem_telit_fn980_hw_v1_config,
-	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32,
-	.mru_default = 32768,
-	.sideband_wake = false,
-};
-
-static const struct mhi_channel_config mhi_telit_fn990_channels[] = {
-	MHI_CHANNEL_CONFIG_UL_SBL(2, "SAHARA", 32, 0),
-	MHI_CHANNEL_CONFIG_DL_SBL(3, "SAHARA", 32, 0),
-	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 64, 1),
-	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 64, 1),
-	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
-	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
-	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
-	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
-	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
-	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
-};
-
-static struct mhi_event_config mhi_telit_fn990_events[] = {
-	MHI_EVENT_CONFIG_CTRL(0, 128),
-	MHI_EVENT_CONFIG_DATA(1, 128),
-	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
-	MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101)
-};
-
-static const struct mhi_controller_config modem_telit_fn990_config = {
-	.max_channels = 128,
-	.timeout_ms = 20000,
-	.num_channels = ARRAY_SIZE(mhi_telit_fn990_channels),
-	.ch_cfg = mhi_telit_fn990_channels,
-	.num_events = ARRAY_SIZE(mhi_telit_fn990_events),
-	.event_cfg = mhi_telit_fn990_events,
-};
-
-static const struct mhi_pci_dev_info mhi_telit_fn990_info = {
-	.name = "telit-fn990",
-	.config = &modem_telit_fn990_config,
-	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32,
-	.sideband_wake = false,
-	.mru_default = 32768,
-};
-
-static const struct pci_device_id mhi_pci_id_table[] = {
-	/* Telit FN980 hardware revision v1 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, 0x1C5D, 0x2000),
-		.driver_data = (kernel_ulong_t) &mhi_telit_fn980_hw_v1_info },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0306),
-		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx55_info },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
-		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
-	/* Telit FN990 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2010),
-		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
-	{ PCI_DEVICE(0x1eac, 0x1001), /* EM120R-GL (sdx24) */
-		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
-	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
-		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
-		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
-	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
-	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
-	/* DW5930e (sdx55), With eSIM, It's also T99W175 */
-	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b0),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
-	/* DW5930e (sdx55), Non-eSIM, It's also T99W175 */
-	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b1),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
-	/* MV31-W (Cinterion) */
-	{ PCI_DEVICE(0x1269, 0x00b3),
-		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
-	{  }
-};
-MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
-
-enum mhi_pci_device_status {
-	MHI_PCI_DEV_STARTED,
-	MHI_PCI_DEV_SUSPENDED,
-};
-
-struct mhi_pci_device {
-	struct mhi_controller mhi_cntrl;
-	struct pci_saved_state *pci_state;
-	struct work_struct recovery_work;
-	struct timer_list health_check_timer;
-	unsigned long status;
-};
-
-static int mhi_pci_read_reg(struct mhi_controller *mhi_cntrl,
-			    void __iomem *addr, u32 *out)
-{
-	*out = readl(addr);
-	return 0;
-}
-
-static void mhi_pci_write_reg(struct mhi_controller *mhi_cntrl,
-			      void __iomem *addr, u32 val)
-{
-	writel(val, addr);
-}
-
-static void mhi_pci_status_cb(struct mhi_controller *mhi_cntrl,
-			      enum mhi_callback cb)
-{
-	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
-
-	/* Nothing to do for now */
-	switch (cb) {
-	case MHI_CB_FATAL_ERROR:
-	case MHI_CB_SYS_ERROR:
-		dev_warn(&pdev->dev, "firmware crashed (%u)\n", cb);
-		pm_runtime_forbid(&pdev->dev);
-		break;
-	case MHI_CB_EE_MISSION_MODE:
-		pm_runtime_allow(&pdev->dev);
-		break;
-	default:
-		break;
-	}
-}
-
-static void mhi_pci_wake_get_nop(struct mhi_controller *mhi_cntrl, bool force)
-{
-	/* no-op */
-}
-
-static void mhi_pci_wake_put_nop(struct mhi_controller *mhi_cntrl, bool override)
-{
-	/* no-op */
-}
-
-static void mhi_pci_wake_toggle_nop(struct mhi_controller *mhi_cntrl)
-{
-	/* no-op */
-}
-
-static bool mhi_pci_is_alive(struct mhi_controller *mhi_cntrl)
-{
-	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
-	u16 vendor = 0;
-
-	if (pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor))
-		return false;
-
-	if (vendor == (u16) ~0 || vendor == 0)
-		return false;
-
-	return true;
-}
-
-static int mhi_pci_claim(struct mhi_controller *mhi_cntrl,
-			 unsigned int bar_num, u64 dma_mask)
-{
-	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
-	int err;
-
-	err = pci_assign_resource(pdev, bar_num);
-	if (err)
-		return err;
-
-	err = pcim_enable_device(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable pci device: %d\n", err);
-		return err;
-	}
-
-	err = pcim_iomap_regions(pdev, 1 << bar_num, pci_name(pdev));
-	if (err) {
-		dev_err(&pdev->dev, "failed to map pci region: %d\n", err);
-		return err;
-	}
-	mhi_cntrl->regs = pcim_iomap_table(pdev)[bar_num];
-	mhi_cntrl->reg_len = pci_resource_len(pdev, bar_num);
-
-	err = pci_set_dma_mask(pdev, dma_mask);
-	if (err) {
-		dev_err(&pdev->dev, "Cannot set proper DMA mask\n");
-		return err;
-	}
-
-	err = pci_set_consistent_dma_mask(pdev, dma_mask);
-	if (err) {
-		dev_err(&pdev->dev, "set consistent dma mask failed\n");
-		return err;
-	}
-
-	pci_set_master(pdev);
-
-	return 0;
-}
-
-static int mhi_pci_get_irqs(struct mhi_controller *mhi_cntrl,
-			    const struct mhi_controller_config *mhi_cntrl_config)
-{
-	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
-	int nr_vectors, i;
-	int *irq;
-
-	/*
-	 * Alloc one MSI vector for BHI + one vector per event ring, ideally...
-	 * No explicit pci_free_irq_vectors required, done by pcim_release.
-	 */
-	mhi_cntrl->nr_irqs = 1 + mhi_cntrl_config->num_events;
-
-	nr_vectors = pci_alloc_irq_vectors(pdev, 1, mhi_cntrl->nr_irqs, PCI_IRQ_MSI);
-	if (nr_vectors < 0) {
-		dev_err(&pdev->dev, "Error allocating MSI vectors %d\n",
-			nr_vectors);
-		return nr_vectors;
-	}
-
-	if (nr_vectors < mhi_cntrl->nr_irqs) {
-		dev_warn(&pdev->dev, "using shared MSI\n");
-
-		/* Patch msi vectors, use only one (shared) */
-		for (i = 0; i < mhi_cntrl_config->num_events; i++)
-			mhi_cntrl_config->event_cfg[i].irq = 0;
-		mhi_cntrl->nr_irqs = 1;
-	}
-
-	irq = devm_kcalloc(&pdev->dev, mhi_cntrl->nr_irqs, sizeof(int), GFP_KERNEL);
-	if (!irq)
-		return -ENOMEM;
-
-	for (i = 0; i < mhi_cntrl->nr_irqs; i++) {
-		int vector = i >= nr_vectors ? (nr_vectors - 1) : i;
-
-		irq[i] = pci_irq_vector(pdev, vector);
-	}
-
-	mhi_cntrl->irq = irq;
-
-	return 0;
-}
-
-static int mhi_pci_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	/* The runtime_get() MHI callback means:
-	 *    Do whatever is requested to leave M3.
-	 */
-	return pm_runtime_get(mhi_cntrl->cntrl_dev);
-}
-
-static void mhi_pci_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-	/* The runtime_put() MHI callback means:
-	 *    Device can be moved in M3 state.
-	 */
-	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-	pm_runtime_put(mhi_cntrl->cntrl_dev);
-}
-
-static void mhi_pci_recovery_work(struct work_struct *work)
-{
-	struct mhi_pci_device *mhi_pdev = container_of(work, struct mhi_pci_device,
-						       recovery_work);
-	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
-	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
-	int err;
-
-	dev_warn(&pdev->dev, "device recovery started\n");
-
-	del_timer(&mhi_pdev->health_check_timer);
-	pm_runtime_forbid(&pdev->dev);
-
-	/* Clean up MHI state */
-	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
-		mhi_power_down(mhi_cntrl, false);
-		mhi_unprepare_after_power_down(mhi_cntrl);
-	}
-
-	pci_set_power_state(pdev, PCI_D0);
-	pci_load_saved_state(pdev, mhi_pdev->pci_state);
-	pci_restore_state(pdev);
-
-	if (!mhi_pci_is_alive(mhi_cntrl))
-		goto err_try_reset;
-
-	err = mhi_prepare_for_power_up(mhi_cntrl);
-	if (err)
-		goto err_try_reset;
-
-	err = mhi_sync_power_up(mhi_cntrl);
-	if (err)
-		goto err_unprepare;
-
-	dev_dbg(&pdev->dev, "Recovery completed\n");
-
-	set_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status);
-	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
-	return;
-
-err_unprepare:
-	mhi_unprepare_after_power_down(mhi_cntrl);
-err_try_reset:
-	if (pci_reset_function(pdev))
-		dev_err(&pdev->dev, "Recovery failed\n");
-}
-
-static void health_check(struct timer_list *t)
-{
-	struct mhi_pci_device *mhi_pdev = from_timer(mhi_pdev, t, health_check_timer);
-	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
-
-	if (!test_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status) ||
-			test_bit(MHI_PCI_DEV_SUSPENDED, &mhi_pdev->status))
-		return;
-
-	if (!mhi_pci_is_alive(mhi_cntrl)) {
-		dev_err(mhi_cntrl->cntrl_dev, "Device died\n");
-		queue_work(system_long_wq, &mhi_pdev->recovery_work);
-		return;
-	}
-
-	/* reschedule in two seconds */
-	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
-}
-
-static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-{
-	const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info *) id->driver_data;
-	const struct mhi_controller_config *mhi_cntrl_config;
-	struct mhi_pci_device *mhi_pdev;
-	struct mhi_controller *mhi_cntrl;
-	int err;
-
-	dev_dbg(&pdev->dev, "MHI PCI device found: %s\n", info->name);
-
-	/* mhi_pdev.mhi_cntrl must be zero-initialized */
-	mhi_pdev = devm_kzalloc(&pdev->dev, sizeof(*mhi_pdev), GFP_KERNEL);
-	if (!mhi_pdev)
-		return -ENOMEM;
-
-	INIT_WORK(&mhi_pdev->recovery_work, mhi_pci_recovery_work);
-	timer_setup(&mhi_pdev->health_check_timer, health_check, 0);
-
-	mhi_cntrl_config = info->config;
-	mhi_cntrl = &mhi_pdev->mhi_cntrl;
-
-	mhi_cntrl->cntrl_dev = &pdev->dev;
-	mhi_cntrl->iova_start = 0;
-	mhi_cntrl->iova_stop = (dma_addr_t)DMA_BIT_MASK(info->dma_data_width);
-	mhi_cntrl->fw_image = info->fw;
-	mhi_cntrl->edl_image = info->edl;
-
-	mhi_cntrl->read_reg = mhi_pci_read_reg;
-	mhi_cntrl->write_reg = mhi_pci_write_reg;
-	mhi_cntrl->status_cb = mhi_pci_status_cb;
-	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
-	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
-	mhi_cntrl->mru = info->mru_default;
-
-	if (info->sideband_wake) {
-		mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
-		mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
-		mhi_cntrl->wake_toggle = mhi_pci_wake_toggle_nop;
-	}
-
-	err = mhi_pci_claim(mhi_cntrl, info->bar_num, DMA_BIT_MASK(info->dma_data_width));
-	if (err)
-		return err;
-
-	err = mhi_pci_get_irqs(mhi_cntrl, mhi_cntrl_config);
-	if (err)
-		return err;
-
-	pci_set_drvdata(pdev, mhi_pdev);
-
-	/* Have stored pci confspace at hand for restore in sudden PCI error.
-	 * cache the state locally and discard the PCI core one.
-	 */
-	pci_save_state(pdev);
-	mhi_pdev->pci_state = pci_store_saved_state(pdev);
-	pci_load_saved_state(pdev, NULL);
-
-	pci_enable_pcie_error_reporting(pdev);
-
-	err = mhi_register_controller(mhi_cntrl, mhi_cntrl_config);
-	if (err)
-		goto err_disable_reporting;
-
-	/* MHI bus does not power up the controller by default */
-	err = mhi_prepare_for_power_up(mhi_cntrl);
-	if (err) {
-		dev_err(&pdev->dev, "failed to prepare MHI controller\n");
-		goto err_unregister;
-	}
-
-	err = mhi_sync_power_up(mhi_cntrl);
-	if (err) {
-		dev_err(&pdev->dev, "failed to power up MHI controller\n");
-		goto err_unprepare;
-	}
-
-	set_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status);
-
-	/* start health check */
-	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
-
-	/* Only allow runtime-suspend if PME capable (for wakeup) */
-	if (pci_pme_capable(pdev, PCI_D3hot)) {
-		pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
-		pm_runtime_use_autosuspend(&pdev->dev);
-		pm_runtime_mark_last_busy(&pdev->dev);
-		pm_runtime_put_noidle(&pdev->dev);
-	}
-
-	return 0;
-
-err_unprepare:
-	mhi_unprepare_after_power_down(mhi_cntrl);
-err_unregister:
-	mhi_unregister_controller(mhi_cntrl);
-err_disable_reporting:
-	pci_disable_pcie_error_reporting(pdev);
-
-	return err;
-}
-
-static void mhi_pci_remove(struct pci_dev *pdev)
-{
-	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
-	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
-
-	del_timer_sync(&mhi_pdev->health_check_timer);
-	cancel_work_sync(&mhi_pdev->recovery_work);
-
-	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
-		mhi_power_down(mhi_cntrl, true);
-		mhi_unprepare_after_power_down(mhi_cntrl);
-	}
-
-	/* balancing probe put_noidle */
-	if (pci_pme_capable(pdev, PCI_D3hot))
-		pm_runtime_get_noresume(&pdev->dev);
-
-	mhi_unregister_controller(mhi_cntrl);
-	pci_disable_pcie_error_reporting(pdev);
-}
-
-static void mhi_pci_shutdown(struct pci_dev *pdev)
-{
-	mhi_pci_remove(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
-}
-
-static void mhi_pci_reset_prepare(struct pci_dev *pdev)
-{
-	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
-	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
-
-	dev_info(&pdev->dev, "reset\n");
-
-	del_timer(&mhi_pdev->health_check_timer);
-
-	/* Clean up MHI state */
-	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
-		mhi_power_down(mhi_cntrl, false);
-		mhi_unprepare_after_power_down(mhi_cntrl);
-	}
-
-	/* cause internal device reset */
-	mhi_soc_reset(mhi_cntrl);
-
-	/* Be sure device reset has been executed */
-	msleep(MHI_POST_RESET_DELAY_MS);
-}
-
-static void mhi_pci_reset_done(struct pci_dev *pdev)
-{
-	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
-	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
-	int err;
-
-	/* Restore initial known working PCI state */
-	pci_load_saved_state(pdev, mhi_pdev->pci_state);
-	pci_restore_state(pdev);
-
-	/* Is device status available ? */
-	if (!mhi_pci_is_alive(mhi_cntrl)) {
-		dev_err(&pdev->dev, "reset failed\n");
-		return;
-	}
-
-	err = mhi_prepare_for_power_up(mhi_cntrl);
-	if (err) {
-		dev_err(&pdev->dev, "failed to prepare MHI controller\n");
-		return;
-	}
-
-	err = mhi_sync_power_up(mhi_cntrl);
-	if (err) {
-		dev_err(&pdev->dev, "failed to power up MHI controller\n");
-		mhi_unprepare_after_power_down(mhi_cntrl);
-		return;
-	}
-
-	set_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status);
-	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
-}
-
-static pci_ers_result_t mhi_pci_error_detected(struct pci_dev *pdev,
-					       pci_channel_state_t state)
-{
-	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
-	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
-
-	dev_err(&pdev->dev, "PCI error detected, state = %u\n", state);
-
-	if (state == pci_channel_io_perm_failure)
-		return PCI_ERS_RESULT_DISCONNECT;
-
-	/* Clean up MHI state */
-	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
-		mhi_power_down(mhi_cntrl, false);
-		mhi_unprepare_after_power_down(mhi_cntrl);
-	} else {
-		/* Nothing to do */
-		return PCI_ERS_RESULT_RECOVERED;
-	}
-
-	pci_disable_device(pdev);
-
-	return PCI_ERS_RESULT_NEED_RESET;
-}
-
-static pci_ers_result_t mhi_pci_slot_reset(struct pci_dev *pdev)
-{
-	if (pci_enable_device(pdev)) {
-		dev_err(&pdev->dev, "Cannot re-enable PCI device after reset.\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-
-	return PCI_ERS_RESULT_RECOVERED;
-}
-
-static void mhi_pci_io_resume(struct pci_dev *pdev)
-{
-	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
-
-	dev_err(&pdev->dev, "PCI slot reset done\n");
-
-	queue_work(system_long_wq, &mhi_pdev->recovery_work);
-}
-
-static const struct pci_error_handlers mhi_pci_err_handler = {
-	.error_detected = mhi_pci_error_detected,
-	.slot_reset = mhi_pci_slot_reset,
-	.resume = mhi_pci_io_resume,
-	.reset_prepare = mhi_pci_reset_prepare,
-	.reset_done = mhi_pci_reset_done,
-};
-
-static int  __maybe_unused mhi_pci_runtime_suspend(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct mhi_pci_device *mhi_pdev = dev_get_drvdata(dev);
-	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
-	int err;
-
-	if (test_and_set_bit(MHI_PCI_DEV_SUSPENDED, &mhi_pdev->status))
-		return 0;
-
-	del_timer(&mhi_pdev->health_check_timer);
-	cancel_work_sync(&mhi_pdev->recovery_work);
-
-	if (!test_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status) ||
-			mhi_cntrl->ee != MHI_EE_AMSS)
-		goto pci_suspend; /* Nothing to do at MHI level */
-
-	/* Transition to M3 state */
-	err = mhi_pm_suspend(mhi_cntrl);
-	if (err) {
-		dev_err(&pdev->dev, "failed to suspend device: %d\n", err);
-		clear_bit(MHI_PCI_DEV_SUSPENDED, &mhi_pdev->status);
-		return -EBUSY;
-	}
-
-pci_suspend:
-	pci_disable_device(pdev);
-	pci_wake_from_d3(pdev, true);
-
-	return 0;
-}
-
-static int __maybe_unused mhi_pci_runtime_resume(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct mhi_pci_device *mhi_pdev = dev_get_drvdata(dev);
-	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
-	int err;
-
-	if (!test_and_clear_bit(MHI_PCI_DEV_SUSPENDED, &mhi_pdev->status))
-		return 0;
-
-	err = pci_enable_device(pdev);
-	if (err)
-		goto err_recovery;
-
-	pci_set_master(pdev);
-	pci_wake_from_d3(pdev, false);
-
-	if (!test_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status) ||
-			mhi_cntrl->ee != MHI_EE_AMSS)
-		return 0; /* Nothing to do at MHI level */
-
-	/* Exit M3, transition to M0 state */
-	err = mhi_pm_resume(mhi_cntrl);
-	if (err) {
-		dev_err(&pdev->dev, "failed to resume device: %d\n", err);
-		goto err_recovery;
-	}
-
-	/* Resume health check */
-	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
-
-	/* It can be a remote wakeup (no mhi runtime_get), update access time */
-	pm_runtime_mark_last_busy(dev);
-
-	return 0;
-
-err_recovery:
-	/* Do not fail to not mess up our PCI device state, the device likely
-	 * lost power (d3cold) and we simply need to reset it from the recovery
-	 * procedure, trigger the recovery asynchronously to prevent system
-	 * suspend exit delaying.
-	 */
-	queue_work(system_long_wq, &mhi_pdev->recovery_work);
-	pm_runtime_mark_last_busy(dev);
-
-	return 0;
-}
-
-static int  __maybe_unused mhi_pci_suspend(struct device *dev)
-{
-	pm_runtime_disable(dev);
-	return mhi_pci_runtime_suspend(dev);
-}
-
-static int __maybe_unused mhi_pci_resume(struct device *dev)
-{
-	int ret;
-
-	/* Depending the platform, device may have lost power (d3cold), we need
-	 * to resume it now to check its state and recover when necessary.
-	 */
-	ret = mhi_pci_runtime_resume(dev);
-	pm_runtime_enable(dev);
-
-	return ret;
-}
-
-static int __maybe_unused mhi_pci_freeze(struct device *dev)
-{
-	struct mhi_pci_device *mhi_pdev = dev_get_drvdata(dev);
-	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
-
-	/* We want to stop all operations, hibernation does not guarantee that
-	 * device will be in the same state as before freezing, especially if
-	 * the intermediate restore kernel reinitializes MHI device with new
-	 * context.
-	 */
-	flush_work(&mhi_pdev->recovery_work);
-	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
-		mhi_power_down(mhi_cntrl, true);
-		mhi_unprepare_after_power_down(mhi_cntrl);
-	}
-
-	return 0;
-}
-
-static int __maybe_unused mhi_pci_restore(struct device *dev)
-{
-	struct mhi_pci_device *mhi_pdev = dev_get_drvdata(dev);
-
-	/* Reinitialize the device */
-	queue_work(system_long_wq, &mhi_pdev->recovery_work);
-
-	return 0;
-}
-
-static const struct dev_pm_ops mhi_pci_pm_ops = {
-	SET_RUNTIME_PM_OPS(mhi_pci_runtime_suspend, mhi_pci_runtime_resume, NULL)
-#ifdef CONFIG_PM_SLEEP
-	.suspend = mhi_pci_suspend,
-	.resume = mhi_pci_resume,
-	.freeze = mhi_pci_freeze,
-	.thaw = mhi_pci_restore,
-	.poweroff = mhi_pci_freeze,
-	.restore = mhi_pci_restore,
-#endif
-};
-
-static struct pci_driver mhi_pci_driver = {
-	.name		= "mhi-pci-generic",
-	.id_table	= mhi_pci_id_table,
-	.probe		= mhi_pci_probe,
-	.remove		= mhi_pci_remove,
-	.shutdown	= mhi_pci_shutdown,
-	.err_handler	= &mhi_pci_err_handler,
-	.driver.pm	= &mhi_pci_pm_ops
-};
-module_pci_driver(mhi_pci_driver);
-
-MODULE_AUTHOR("Loic Poulain <loic.poulain@linaro.org>");
-MODULE_DESCRIPTION("Modem Host Interface (MHI) PCI controller driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 005eefecfdf5..0cc8cafdde27 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -132,7 +132,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
 		}
 		rctx->p_iv[i] = a;
 		/* we need to setup all others IVs only in the decrypt way */
-		if (rctx->op_dir & SS_ENCRYPTION)
+		if (rctx->op_dir == SS_ENCRYPTION)
 			return 0;
 		todo = min(len, sg_dma_len(sg));
 		len -= todo;
diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index ae7b44599914..4bf9eaab4456 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -42,6 +42,9 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 	/* Read the interrupt status: */
 	status = ioread32(psp->io_regs + psp->vdata->intsts_reg);
 
+	/* Clear the interrupt status by writing the same value we read. */
+	iowrite32(status, psp->io_regs + psp->vdata->intsts_reg);
+
 	/* invoke subdevice interrupt handlers */
 	if (status) {
 		if (psp->sev_irq_handler)
@@ -51,9 +54,6 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 			psp->tee_irq_handler(irq, psp->tee_irq_data, status);
 	}
 
-	/* Clear the interrupt status by writing the same value we read. */
-	iowrite32(status, psp->io_regs + psp->vdata->intsts_reg);
-
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f51789d9818..b0d9c47cc381 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4368,7 +4368,11 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 	dev_info(adev->dev, "recover vram bo from shadow start\n");
 	mutex_lock(&adev->shadow_list_lock);
 	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
-		shadow = &vmbo->bo;
+		/* If vm is compute context or adev is APU, shadow will be NULL */
+		if (!vmbo->shadow)
+			continue;
+		shadow = vmbo->shadow;
+
 		/* No need to recover an evicted BO */
 		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index b7d861ed5284..88f986a61c93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -66,6 +66,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 {
 	struct fd f = fdget(fd);
 	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_ctx_mgr *mgr;
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
 	int r;
@@ -79,8 +80,11 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 		return r;
 	}
 
-	idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
+	mgr = &fpriv->ctx_mgr;
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
 		amdgpu_ctx_priority_override(ctx, priority);
+	mutex_unlock(&mgr->lock);
 
 	fdput(f);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 16cbae04078a..5f325ded7f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4018,7 +4018,8 @@ static int gfx_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 70d24b522df8..342e540410b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1819,7 +1819,6 @@ static int gmc_v9_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f14f7bb3cf0c..0fad9258e096 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2044,9 +2044,11 @@ static int sdma_v4_0_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+		}
 	}
 
 	sdma_v4_0_ctx_switch_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1e0ddf7722cd..fa4f0a205127 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8944,6 +8944,13 @@ static void amdgpu_dm_commit_cursors(struct drm_atomic_state *state)
 			handle_cursor_update(plane, old_plane_state);
 }
 
+static inline uint32_t get_mem_type(struct drm_framebuffer *fb)
+{
+	struct amdgpu_bo *abo = gem_to_amdgpu_bo(fb->obj[0]);
+
+	return abo->tbo.resource ? abo->tbo.resource->mem_type : 0;
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct dc_state *dc_state,
 				    struct drm_device *dev,
@@ -9013,6 +9020,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			continue;
 
 		dc_plane = dm_new_plane_state->dc_state;
+		if (!dc_plane)
+			continue;
 
 		bundle->surface_updates[planes_count].surface = dc_plane;
 		if (new_pcrtc_state->color_mgmt_changed) {
@@ -9064,11 +9073,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		/*
 		 * Only allow immediate flips for fast updates that don't
-		 * change FB pitch, DCC state, rotation or mirroing.
+		 * change memory domain, FB pitch, DCC state, rotation or
+		 * mirroring.
 		 */
 		bundle->flip_addrs[planes_count].flip_immediate =
 			crtc->state->async_flip &&
-			acrtc_state->update_type == UPDATE_TYPE_FAST;
+			acrtc_state->update_type == UPDATE_TYPE_FAST &&
+			get_mem_type(old_plane_state->fb) == get_mem_type(fb);
 
 		timestamp_ns = ktime_get_ns();
 		bundle->flip_addrs[planes_count].flip_timestamp_in_us = div_u64(timestamp_ns, 1000);
@@ -10541,8 +10552,9 @@ static int dm_update_plane_state(struct dc *dc,
 			return -EINVAL;
 		}
 
+		if (dm_old_plane_state->dc_state)
+			dc_plane_state_release(dm_old_plane_state->dc_state);
 
-		dc_plane_state_release(dm_old_plane_state->dc_state);
 		dm_new_plane_state->dc_state = NULL;
 
 		*lock_and_validation_needed = true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 188556e41b9d..fa4d671b5b2c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1434,6 +1434,9 @@ bool dc_remove_plane_from_context(
 	struct dc_stream_status *stream_status = NULL;
 	struct resource_pool *pool = dc->res_pool;
 
+	if (!plane_state)
+		return true;
+
 	for (i = 0; i < context->stream_count; i++)
 		if (context->streams[i] == stream) {
 			stream_status = &context->stream_status[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c655d03ef754..73457c32f3e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3211,13 +3211,11 @@ void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data)
 
 static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 {
-	struct pipe_ctx *test_pipe;
+	struct pipe_ctx *test_pipe, *split_pipe;
 	const struct scaler_data *scl_data = &pipe_ctx->plane_res.scl_data;
-	const struct rect *r1 = &scl_data->recout, *r2;
-	int r1_r = r1->x + r1->width, r1_b = r1->y + r1->height, r2_r, r2_b;
+	struct rect r1 = scl_data->recout, r2, r2_half;
+	int r1_r = r1.x + r1.width, r1_b = r1.y + r1.height, r2_r, r2_b;
 	int cur_layer = pipe_ctx->plane_state->layer_index;
-	bool upper_pipe_exists = false;
-	struct fixed31_32 one = dc_fixpt_from_int(1);
 
 	/**
 	 * Disable the cursor if there's another pipe above this with a
@@ -3226,26 +3224,35 @@ static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 	 */
 	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
 	     test_pipe = test_pipe->top_pipe) {
-		if (!test_pipe->plane_state->visible)
+		// Skip invisible layer and pipe-split plane on same layer
+		if (!test_pipe->plane_state ||
+		    !test_pipe->plane_state->visible ||
+		    test_pipe->plane_state->layer_index == cur_layer)
 			continue;
 
-		r2 = &test_pipe->plane_res.scl_data.recout;
-		r2_r = r2->x + r2->width;
-		r2_b = r2->y + r2->height;
+		r2 = test_pipe->plane_res.scl_data.recout;
+		r2_r = r2.x + r2.width;
+		r2_b = r2.y + r2.height;
+		split_pipe = test_pipe;
 
-		if (r1->x >= r2->x && r1->y >= r2->y && r1_r <= r2_r && r1_b <= r2_b)
-			return true;
+		/**
+		 * There is another half plane on same layer because of
+		 * pipe-split, merge together per same height.
+		 */
+		for (split_pipe = pipe_ctx->top_pipe; split_pipe;
+		     split_pipe = split_pipe->top_pipe)
+			if (split_pipe->plane_state->layer_index == test_pipe->plane_state->layer_index) {
+				r2_half = split_pipe->plane_res.scl_data.recout;
+				r2.x = (r2_half.x < r2.x) ? r2_half.x : r2.x;
+				r2.width = r2.width + r2_half.width;
+				r2_r = r2.x + r2.width;
+				break;
+			}
 
-		if (test_pipe->plane_state->layer_index < cur_layer)
-			upper_pipe_exists = true;
+		if (r1.x >= r2.x && r1.y >= r2.y && r1_r <= r2_r && r1_b <= r2_b)
+			return true;
 	}
 
-	// if plane scaled, assume an upper plane can handle cursor if it exists.
-	if (upper_pipe_exists &&
-			(scl_data->ratios.horz.value != one.value ||
-			scl_data->ratios.vert.value != one.value))
-		return true;
-
 	return false;
 }
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 96808190250d..d3fd76a0a34a 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -494,7 +494,6 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
-			  MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_LPM |
 			  MIPI_DSI_MODE_NO_EOT_PACKET;
 
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 00e53de4812b..584d3a73db96 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -198,8 +198,6 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	if (ret)
 		drm_warn(dev, "Failed to update vram location.\n");
 
-	hv->dirt_needed = true;
-
 	ret = hyperv_mode_config_init(hv);
 	if (ret)
 		goto err_vmbus_close;
diff --git a/drivers/gpu/drm/i915/display/intel_snps_phy.c b/drivers/gpu/drm/i915/display/intel_snps_phy.c
index 536b319ffe5b..170690fc735b 100644
--- a/drivers/gpu/drm/i915/display/intel_snps_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_snps_phy.c
@@ -582,6 +582,1177 @@ static const struct intel_mpllb_state dg2_hdmi_148_5 = {
 		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
 };
 
+/* values in the below table are calculted using the algo */
+static const struct intel_mpllb_state dg2_hdmi_25200 = {
+	.clock = 25200,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 7) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 5) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 128) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 41943) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 2621),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_27027 = {
+	.clock = 27027,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 5) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 140) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 31876) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 46555),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_28320 = {
+	.clock = 28320,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 5) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 148) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 40894) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 30408),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_30240 = {
+	.clock = 30240,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 5) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 160) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 50331) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 42466),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_31500 = {
+	.clock = 31500,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 7) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 4) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 68) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 26214) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 26214),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_36000 = {
+	.clock = 36000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 4) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 82) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 39321) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 39320),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_40000 = {
+	.clock = 40000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 4) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 2),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 96) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 0),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_49500 = {
+	.clock = 49500,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 4) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 1),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 126) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 13107) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 13107),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_50000 = {
+	.clock = 50000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 4) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 1),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 128) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 0),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_57284 = {
+	.clock = 57284,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 4) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 150) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 42886) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 49701),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_58000 = {
+	.clock = 58000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 4) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 152) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 52428) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 52427),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_65000 = {
+	.clock = 65000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 7) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 72) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 0),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_71000 = {
+	.clock = 71000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 80) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 52428) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 52427),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_74176 = {
+	.clock = 74176,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 86) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 22334) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 43829),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_75000 = {
+	.clock = 75000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 88) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 0),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_78750 = {
+	.clock = 78750,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 2),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 94) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 0),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_85500 = {
+	.clock = 85500,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 2),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 104) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 26214) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 26214),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_88750 = {
+	.clock = 88750,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 7) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 15) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 1),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 110) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 0),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_106500 = {
+	.clock = 106500,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 138) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 13107) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 13107),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_108000 = {
+	.clock = 108000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 140) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 26214) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 26214),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_115500 = {
+	.clock = 115500,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 152) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 26214) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 26214),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_119000 = {
+	.clock = 119000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 3) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 158) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 13107) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 13107),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_135000 = {
+	.clock = 135000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 7) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 15) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 76) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 0),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_138500 = {
+	.clock = 138500,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 78) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 26214) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 26214),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_147160 = {
+	.clock = 147160,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 84) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 56623) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 6815),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_148352 = {
+	.clock = 148352,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 86) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 22334) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 43829),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_154000 = {
+	.clock = 154000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 13) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 2),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 90) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 39321) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 39320),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_162000 = {
+	.clock = 162000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 2),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 96) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 52428) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 52427),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_209800 = {
+	.clock = 209800,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 7) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 134) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 60293) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 7864),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_262750 = {
+	.clock = 262750,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 7) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 72) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 36044) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 52427),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_267300 = {
+	.clock = 267300,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 7) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 74) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 30146) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 36699),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_268500 = {
+	.clock = 268500,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 7) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 74) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 45875) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 13107),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_296703 = {
+	.clock = 296703,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 86) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 22321) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 36804),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_241500 = {
+	.clock = 241500,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 160) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 39321) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 39320),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_319890 = {
+	.clock = 319890,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 2),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 94) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 64094) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 13631),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_497750 = {
+	.clock = 497750,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 15) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 0),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 166) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 36044) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 52427),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_592000 = {
+	.clock = 592000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 86) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 13107) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 13107),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_593407 = {
+	.clock = 593407,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 0) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 86) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 22328) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 7549),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
+static const struct intel_mpllb_state dg2_hdmi_297 = {
+	.clock = 297000,
+	.ref_control =
+		REG_FIELD_PREP(SNPS_PHY_REF_CONTROL_REF_RANGE, 3),
+	.mpllb_cp =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT, 6) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP, 14) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_INT_GS, 64) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_CP_PROP_GS, 124),
+	.mpllb_div =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_DIV5_CLK_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_TX_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_PMIX_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_V2I, 2) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FREQ_VCO, 3),
+	.mpllb_div2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_REF_CLK_DIV, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_MULTIPLIER, 86) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_HDMI_DIV, 1),
+	.mpllb_fracn1 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_CGG_UPDATE_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_EN, 1) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_DEN, 65535),
+	.mpllb_fracn2 =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_QUOT, 26214) |
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_FRACN_REM, 26214),
+	.mpllb_sscen =
+		REG_FIELD_PREP(SNPS_PHY_MPLLB_SSC_UP_SPREAD, 1),
+};
+
 static const struct intel_mpllb_state dg2_hdmi_594 = {
 	.clock = 594000,
 	.ref_control =
@@ -616,7 +1787,46 @@ static const struct intel_mpllb_state *dg2_hdmi_tables[] = {
 	&dg2_hdmi_27_0,
 	&dg2_hdmi_74_25,
 	&dg2_hdmi_148_5,
+	&dg2_hdmi_297,
 	&dg2_hdmi_594,
+	&dg2_hdmi_25200,
+	&dg2_hdmi_27027,
+	&dg2_hdmi_28320,
+	&dg2_hdmi_30240,
+	&dg2_hdmi_31500,
+	&dg2_hdmi_36000,
+	&dg2_hdmi_40000,
+	&dg2_hdmi_49500,
+	&dg2_hdmi_50000,
+	&dg2_hdmi_57284,
+	&dg2_hdmi_58000,
+	&dg2_hdmi_65000,
+	&dg2_hdmi_71000,
+	&dg2_hdmi_74176,
+	&dg2_hdmi_75000,
+	&dg2_hdmi_78750,
+	&dg2_hdmi_85500,
+	&dg2_hdmi_88750,
+	&dg2_hdmi_106500,
+	&dg2_hdmi_108000,
+	&dg2_hdmi_115500,
+	&dg2_hdmi_119000,
+	&dg2_hdmi_135000,
+	&dg2_hdmi_138500,
+	&dg2_hdmi_147160,
+	&dg2_hdmi_148352,
+	&dg2_hdmi_154000,
+	&dg2_hdmi_162000,
+	&dg2_hdmi_209800,
+	&dg2_hdmi_241500,
+	&dg2_hdmi_262750,
+	&dg2_hdmi_267300,
+	&dg2_hdmi_268500,
+	&dg2_hdmi_296703,
+	&dg2_hdmi_319890,
+	&dg2_hdmi_497750,
+	&dg2_hdmi_592000,
+	&dg2_hdmi_593407,
 	NULL,
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
index c9d11d57aed6..1aa39aa73e74 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
@@ -107,7 +107,7 @@ reset_set(void *data, u64 val)
 	 * try to reset an active GPU.
 	 */
 
-	mutex_lock(&dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	release_firmware(adreno_gpu->fw[ADRENO_FW_PM4]);
 	adreno_gpu->fw[ADRENO_FW_PM4] = NULL;
@@ -133,7 +133,7 @@ reset_set(void *data, u64 val)
 	gpu->funcs->recover(gpu);
 
 	pm_runtime_put_sync(&gpu->pdev->dev);
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 3eb914665344..6749ea7669b9 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -406,20 +406,21 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
-		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
 		DRM_DEV_ERROR(dev->dev, "Couldn't power up the GPU: %d\n", ret);
-		return NULL;
+		goto err_disable_rpm;
 	}
 
-	mutex_lock(&dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 	ret = msm_gpu_hw_init(gpu);
-	mutex_unlock(&dev->struct_mutex);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	mutex_unlock(&gpu->lock);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "gpu hw init failed: %d\n", ret);
-		return NULL;
+		goto err_put_rpm;
 	}
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 #ifdef CONFIG_DEBUG_FS
 	if (gpu->funcs->debugfs_init) {
 		gpu->funcs->debugfs_init(gpu, dev->primary);
@@ -428,6 +429,13 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 #endif
 
 	return gpu;
+
+err_put_rpm:
+	pm_runtime_put_sync_suspend(&pdev->dev);
+err_disable_rpm:
+	pm_runtime_disable(&pdev->dev);
+
+	return NULL;
 }
 
 static void set_gpu_pdev(struct drm_device *dev,
diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index dee13fedee3b..f970a14b6633 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -29,14 +29,14 @@ static int msm_gpu_show(struct seq_file *m, void *arg)
 	struct msm_gpu *gpu = priv->gpu;
 	int ret;
 
-	ret = mutex_lock_interruptible(&show_priv->dev->struct_mutex);
+	ret = mutex_lock_interruptible(&gpu->lock);
 	if (ret)
 		return ret;
 
 	drm_printf(&p, "%s Status:\n", gpu->name);
 	gpu->funcs->show(gpu, show_priv->state, &p);
 
-	mutex_unlock(&show_priv->dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	return 0;
 }
@@ -48,9 +48,9 @@ static int msm_gpu_release(struct inode *inode, struct file *file)
 	struct msm_drm_private *priv = show_priv->dev->dev_private;
 	struct msm_gpu *gpu = priv->gpu;
 
-	mutex_lock(&show_priv->dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 	gpu->funcs->gpu_state_put(show_priv->state);
-	mutex_unlock(&show_priv->dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	kfree(show_priv);
 
@@ -72,7 +72,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 	if (!show_priv)
 		return -ENOMEM;
 
-	ret = mutex_lock_interruptible(&dev->struct_mutex);
+	ret = mutex_lock_interruptible(&gpu->lock);
 	if (ret)
 		goto free_priv;
 
@@ -81,7 +81,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 	show_priv->state = gpu->funcs->gpu_state_get(gpu);
 	pm_runtime_put_sync(&gpu->pdev->dev);
 
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	if (IS_ERR(show_priv->state)) {
 		ret = PTR_ERR(show_priv->state);
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 6c4d519450b9..e238d2beb7ab 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -359,13 +359,16 @@ static int msm_drm_uninit(struct device *dev)
 		msm_fbdev_free(ddev);
 #endif
 
-	msm_disp_snapshot_destroy(ddev);
+	if (kms)
+		msm_disp_snapshot_destroy(ddev);
 
 	drm_mode_config_cleanup(ddev);
 
-	pm_runtime_get_sync(dev);
-	msm_irq_uninstall(ddev);
-	pm_runtime_put_sync(dev);
+	if (kms) {
+		pm_runtime_get_sync(dev);
+		msm_irq_uninstall(ddev);
+		pm_runtime_put_sync(dev);
+	}
 
 	if (kms && kms->funcs)
 		kms->funcs->destroy(kms);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index b01d0a521c90..a2f21b89d077 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -150,7 +150,7 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
 {
 	int ret;
 
-	WARN_ON(!mutex_is_locked(&gpu->dev->struct_mutex));
+	WARN_ON(!mutex_is_locked(&gpu->lock));
 
 	if (!gpu->needs_hw_init)
 		return 0;
@@ -361,7 +361,7 @@ static void recover_worker(struct kthread_work *work)
 	char *comm = NULL, *cmd = NULL;
 	int i;
 
-	mutex_lock(&dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	DRM_DEV_ERROR(dev->dev, "%s: hangcheck recover!\n", gpu->name);
 
@@ -442,7 +442,7 @@ static void recover_worker(struct kthread_work *work)
 		}
 	}
 
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	msm_gpu_retire(gpu);
 }
@@ -450,12 +450,11 @@ static void recover_worker(struct kthread_work *work)
 static void fault_worker(struct kthread_work *work)
 {
 	struct msm_gpu *gpu = container_of(work, struct msm_gpu, fault_work);
-	struct drm_device *dev = gpu->dev;
 	struct msm_gem_submit *submit;
 	struct msm_ringbuffer *cur_ring = gpu->funcs->active_ring(gpu);
 	char *comm = NULL, *cmd = NULL;
 
-	mutex_lock(&dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	submit = find_submit(cur_ring, cur_ring->memptrs->fence + 1);
 	if (submit && submit->fault_dumped)
@@ -490,7 +489,7 @@ static void fault_worker(struct kthread_work *work)
 	memset(&gpu->fault_info, 0, sizeof(gpu->fault_info));
 	gpu->aspace->mmu->funcs->resume_translation(gpu->aspace->mmu);
 
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 }
 
 static void hangcheck_timer_reset(struct msm_gpu *gpu)
@@ -734,7 +733,7 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned long flags;
 
-	WARN_ON(!mutex_is_locked(&dev->struct_mutex));
+	WARN_ON(!mutex_is_locked(&gpu->lock));
 
 	pm_runtime_get_sync(&gpu->pdev->dev);
 
@@ -849,6 +848,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	INIT_LIST_HEAD(&gpu->active_list);
 	mutex_init(&gpu->active_lock);
+	mutex_init(&gpu->lock);
 	kthread_init_work(&gpu->retire_work, retire_worker);
 	kthread_init_work(&gpu->recover_work, recover_worker);
 	kthread_init_work(&gpu->fault_work, fault_worker);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 2e2424066e70..461ff5a5aa5b 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -143,13 +143,23 @@ struct msm_gpu {
 	 */
 	struct list_head active_list;
 
+	/**
+	 * lock:
+	 *
+	 * General lock for serializing all the gpu things.
+	 *
+	 * TODO move to per-ring locking where feasible (ie. submit/retire
+	 * path, etc)
+	 */
+	struct mutex lock;
+
 	/**
 	 * active_submits:
 	 *
 	 * The number of submitted but not yet retired submits, used to
 	 * determine transitions between active and idle.
 	 *
-	 * Protected by lock
+	 * Protected by active_lock
 	 */
 	int active_submits;
 
@@ -530,28 +540,28 @@ static inline struct msm_gpu_state *msm_gpu_crashstate_get(struct msm_gpu *gpu)
 {
 	struct msm_gpu_state *state = NULL;
 
-	mutex_lock(&gpu->dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	if (gpu->crashstate) {
 		kref_get(&gpu->crashstate->ref);
 		state = gpu->crashstate;
 	}
 
-	mutex_unlock(&gpu->dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	return state;
 }
 
 static inline void msm_gpu_crashstate_put(struct msm_gpu *gpu)
 {
-	mutex_lock(&gpu->dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	if (gpu->crashstate) {
 		if (gpu->funcs->gpu_state_put(gpu->crashstate))
 			gpu->crashstate = NULL;
 	}
 
-	mutex_unlock(&gpu->dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/msm_perf.c b/drivers/gpu/drm/msm/msm_perf.c
index 3a27153eef08..3d3da79fec2a 100644
--- a/drivers/gpu/drm/msm/msm_perf.c
+++ b/drivers/gpu/drm/msm/msm_perf.c
@@ -155,9 +155,12 @@ static int perf_open(struct inode *inode, struct file *file)
 	struct msm_gpu *gpu = priv->gpu;
 	int ret = 0;
 
-	mutex_lock(&dev->struct_mutex);
+	if (!gpu)
+		return -ENODEV;
 
-	if (perf->open || !gpu) {
+	mutex_lock(&gpu->lock);
+
+	if (perf->open) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -171,7 +174,7 @@ static int perf_open(struct inode *inode, struct file *file)
 	perf->next_jiffies = jiffies + SAMPLE_TIME;
 
 out:
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index e3f0dd4a3679..15a44491a42c 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -86,7 +86,7 @@ struct msm_rd_state {
 	struct msm_gem_submit *submit;
 
 	/* fifo access is synchronized on the producer side by
-	 * struct_mutex held by submit code (otherwise we could
+	 * gpu->lock held by submit code (otherwise we could
 	 * end up w/ cmds logged in different order than they
 	 * were executed).  And read_lock synchronizes the reads
 	 */
@@ -181,9 +181,12 @@ static int rd_open(struct inode *inode, struct file *file)
 	uint32_t gpu_id;
 	int ret = 0;
 
-	mutex_lock(&dev->struct_mutex);
+	if (!gpu)
+		return -ENODEV;
 
-	if (rd->open || !gpu) {
+	mutex_lock(&gpu->lock);
+
+	if (rd->open) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -203,7 +206,7 @@ static int rd_open(struct inode *inode, struct file *file)
 	rd_write_section(rd, RD_GPU_ID, &gpu_id, sizeof(gpu_id));
 
 out:
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 	return ret;
 }
 
@@ -343,11 +346,10 @@ static void snapshot_buf(struct msm_rd_state *rd,
 	msm_gem_unlock(&obj->base);
 }
 
-/* called under struct_mutex */
+/* called under gpu->lock */
 void msm_rd_dump_submit(struct msm_rd_state *rd, struct msm_gem_submit *submit,
 		const char *fmt, ...)
 {
-	struct drm_device *dev = submit->dev;
 	struct task_struct *task;
 	char msg[256];
 	int i, n;
@@ -358,7 +360,7 @@ void msm_rd_dump_submit(struct msm_rd_state *rd, struct msm_gem_submit *submit,
 	/* writing into fifo is serialized by caller, and
 	 * rd->read_lock is used to serialize the reads
 	 */
-	WARN_ON(!mutex_is_locked(&dev->struct_mutex));
+	WARN_ON(!mutex_is_locked(&submit->gpu->lock));
 
 	if (fmt) {
 		va_list args;
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index bd54c1412649..a2314b75962f 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -32,11 +32,11 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 	pm_runtime_get_sync(&gpu->pdev->dev);
 
 	/* TODO move submit path over to using a per-ring lock.. */
-	mutex_lock(&gpu->dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	msm_gpu_submit(gpu, submit);
 
-	mutex_unlock(&gpu->dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	pm_runtime_put(&gpu->pdev->dev);
 
diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index f80b44a8a700..f8dbccd55033 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -444,7 +444,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 		       DRM_MODE_CONNECTOR_DSI);
 
 	ctx->bl_dev = devm_backlight_device_register(dev, dev_name(dev),
-						     dsi->host->dev, ctx,
+						     dev, ctx,
 						     &otm8009a_backlight_ops,
 						     NULL);
 	if (IS_ERR(ctx->bl_dev)) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 546aaaaec016..b4bdb532a0a4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1272,6 +1272,9 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 
 	struct input_dev *pen_input = wacom->pen_input;
 	unsigned char *data = wacom->data;
+	int number_of_valid_frames = 0;
+	int time_interval = 15000000;
+	ktime_t time_packet_received = ktime_get();
 	int i;
 
 	if (wacom->features.type == INTUOSP2_BT ||
@@ -1292,12 +1295,30 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 		wacom->id[0] |= (wacom->serial[0] >> 32) & 0xFFFFF;
 	}
 
+	/* number of valid frames */
 	for (i = 0; i < pen_frames; i++) {
 		unsigned char *frame = &data[i*pen_frame_len + 1];
 		bool valid = frame[0] & 0x80;
+
+		if (valid)
+			number_of_valid_frames++;
+	}
+
+	if (number_of_valid_frames) {
+		if (wacom->hid_data.time_delayed)
+			time_interval = ktime_get() - wacom->hid_data.time_delayed;
+		time_interval /= number_of_valid_frames;
+		wacom->hid_data.time_delayed = time_packet_received;
+	}
+
+	for (i = 0; i < number_of_valid_frames; i++) {
+		unsigned char *frame = &data[i*pen_frame_len + 1];
+		bool valid = frame[0] & 0x80;
 		bool prox = frame[0] & 0x40;
 		bool range = frame[0] & 0x20;
 		bool invert = frame[0] & 0x10;
+		int frames_number_reversed = number_of_valid_frames - i - 1;
+		int event_timestamp = time_packet_received - frames_number_reversed * time_interval;
 
 		if (!valid)
 			continue;
@@ -1310,6 +1331,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 			wacom->tool[0] = 0;
 			wacom->id[0] = 0;
 			wacom->serial[0] = 0;
+			wacom->hid_data.time_delayed = 0;
 			return;
 		}
 
@@ -1346,6 +1368,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 						 get_unaligned_le16(&frame[11]));
 			}
 		}
+
 		if (wacom->tool[0]) {
 			input_report_abs(pen_input, ABS_PRESSURE, get_unaligned_le16(&frame[5]));
 			if (wacom->features.type == INTUOSP2_BT ||
@@ -1369,6 +1392,9 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 
 		wacom->shared->stylus_in_proximity = prox;
 
+		/* add timestamp to unpack the frames */
+		input_set_timestamp(pen_input, event_timestamp);
+
 		input_sync(pen_input);
 	}
 }
@@ -1857,6 +1883,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int resolution_code = code;
+	int resolution = hidinput_calc_abs_res(field, resolution_code);
 
 	if (equivalent_usage == HID_DG_TWIST) {
 		resolution_code = ABS_RZ;
@@ -1877,8 +1904,15 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	switch (type) {
 	case EV_ABS:
 		input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
-		input_abs_set_res(input, code,
-				  hidinput_calc_abs_res(field, resolution_code));
+
+		/* older tablet may miss physical usage */
+		if ((code == ABS_X || code == ABS_Y) && !resolution) {
+			resolution = WACOM_INTUOS_RES;
+			hid_warn(input,
+				 "Wacom usage (%d) missing resolution \n",
+				 code);
+		}
+		input_abs_set_res(input, code, resolution);
 		break;
 	case EV_KEY:
 	case EV_MSC:
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 44e0763a0ede..dbf23e71aa72 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -321,6 +321,7 @@ struct hid_data {
 	int bat_connected;
 	int ps_connected;
 	bool pad_input_event_flag;
+	int time_delayed;
 };
 
 struct wacom_remote_data {
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 05e36229622e..be06de791c54 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -110,7 +110,7 @@ struct zynqmp_ipi_pdata {
 	unsigned int method;
 	u32 local_id;
 	int num_mboxes;
-	struct zynqmp_ipi_mbox *ipi_mboxes;
+	struct zynqmp_ipi_mbox ipi_mboxes[];
 };
 
 static struct device_driver zynqmp_ipi_mbox_driver = {
@@ -634,8 +634,13 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
 
-	num_mboxes = of_get_child_count(np);
-	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
+	num_mboxes = of_get_available_child_count(np);
+	if (num_mboxes == 0) {
+		dev_err(dev, "mailbox nodes not available\n");
+		return -EINVAL;
+	}
+
+	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
 			     GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -649,8 +654,6 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	}
 
 	pdata->num_mboxes = num_mboxes;
-	pdata->ipi_mboxes = (struct zynqmp_ipi_mbox *)
-			    ((char *)pdata + sizeof(*pdata));
 
 	mbox = pdata->ipi_mboxes;
 	for_each_available_child_of_node(np, nc) {
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index dfea2ab0c297..e7a551570cf3 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -441,9 +441,9 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
 		else
 			ssc_delta = 0x87;
 		if (priv->id == ID_MT7621) {
-			/* PLL frequency: 150MHz: 1.2GBit */
+			/* PLL frequency: 125MHz: 1.0GBit */
 			if (xtal == HWTRAP_XTAL_40MHZ)
-				ncpo1 = 0x0780;
+				ncpo1 = 0x0640;
 			if (xtal == HWTRAP_XTAL_25MHZ)
 				ncpo1 = 0x0a00;
 		} else { /* PLL frequency: 250MHz: 2.0Gbit */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index bc363fca2895..b33aee4404de 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4575,6 +4575,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
+	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index ba51fb381f0c..4e9cb1deaf81 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1270,7 +1270,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		int index;
 
 		index = enetc_get_free_index(priv);
-		if (sfi->handle < 0) {
+		if (index < 0) {
 			NL_SET_ERR_MSG_MOD(extack, "No Stream Filter resource!");
 			err = -ENOSPC;
 			goto free_fmi;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 2898931d5260..9690ac01f02c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL(otx2_mbox_init);
  */
 int otx2_mbox_regions_init(struct otx2_mbox *mbox, void **hwbase,
 			   struct pci_dev *pdev, void *reg_base,
-			   int direction, int ndevs)
+			   int direction, int ndevs, unsigned long *pf_bmap)
 {
 	struct otx2_mbox_dev *mdev;
 	int devid, err;
@@ -169,6 +169,9 @@ int otx2_mbox_regions_init(struct otx2_mbox *mbox, void **hwbase,
 	mbox->hwbase = hwbase[0];
 
 	for (devid = 0; devid < ndevs; devid++) {
+		if (!test_bit(devid, pf_bmap))
+			continue;
+
 		mdev = &mbox->dev[devid];
 		mdev->mbase = hwbase[devid];
 		mdev->hwbase = hwbase[devid];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index c6643c7db1fc..2b6cbd5af100 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -96,9 +96,10 @@ void otx2_mbox_destroy(struct otx2_mbox *mbox);
 int otx2_mbox_init(struct otx2_mbox *mbox, void __force *hwbase,
 		   struct pci_dev *pdev, void __force *reg_base,
 		   int direction, int ndevs);
+
 int otx2_mbox_regions_init(struct otx2_mbox *mbox, void __force **hwbase,
 			   struct pci_dev *pdev, void __force *reg_base,
-			   int direction, int ndevs);
+			   int direction, int ndevs, unsigned long *bmap);
 void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_busy_poll_for_rsp(struct otx2_mbox *mbox, int devid);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index bd33b90aaa67..f64509b1d120 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2196,7 +2196,7 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 }
 
 static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
-				int num, int type)
+				int num, int type, unsigned long *pf_bmap)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	int region;
@@ -2208,6 +2208,9 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	 */
 	if (type == TYPE_AFVF) {
 		for (region = 0; region < num; region++) {
+			if (!test_bit(region, pf_bmap))
+				continue;
+
 			if (hw->cap.per_pf_mbox_regs) {
 				bar4 = rvu_read64(rvu, BLKADDR_RVUM,
 						  RVU_AF_PFX_BAR4_ADDR(0)) +
@@ -2229,6 +2232,9 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	 * RVU_AF_PF_BAR4_ADDR register.
 	 */
 	for (region = 0; region < num; region++) {
+		if (!test_bit(region, pf_bmap))
+			continue;
+
 		if (hw->cap.per_pf_mbox_regs) {
 			bar4 = rvu_read64(rvu, BLKADDR_RVUM,
 					  RVU_AF_PFX_BAR4_ADDR(region));
@@ -2257,20 +2263,41 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	int err = -EINVAL, i, dir, dir_up;
 	void __iomem *reg_base;
 	struct rvu_work *mwork;
+	unsigned long *pf_bmap;
 	void **mbox_regions;
 	const char *name;
+	u64 cfg;
 
-	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
-	if (!mbox_regions)
+	pf_bmap = bitmap_zalloc(num, GFP_KERNEL);
+	if (!pf_bmap)
 		return -ENOMEM;
 
+	/* RVU VFs */
+	if (type == TYPE_AFVF)
+		bitmap_set(pf_bmap, 0, num);
+
+	if (type == TYPE_AFPF) {
+		/* Mark enabled PFs in bitmap */
+		for (i = 0; i < num; i++) {
+			cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(i));
+			if (cfg & BIT_ULL(20))
+				set_bit(i, pf_bmap);
+		}
+	}
+
+	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	if (!mbox_regions) {
+		err = -ENOMEM;
+		goto free_bitmap;
+	}
+
 	switch (type) {
 	case TYPE_AFPF:
 		name = "rvu_afpf_mailbox";
 		dir = MBOX_DIR_AFPF;
 		dir_up = MBOX_DIR_AFPF_UP;
 		reg_base = rvu->afreg_base;
-		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFPF);
+		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFPF, pf_bmap);
 		if (err)
 			goto free_regions;
 		break;
@@ -2279,7 +2306,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		dir = MBOX_DIR_PFVF;
 		dir_up = MBOX_DIR_PFVF_UP;
 		reg_base = rvu->pfreg_base;
-		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFVF);
+		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFVF, pf_bmap);
 		if (err)
 			goto free_regions;
 		break;
@@ -2310,16 +2337,19 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	}
 
 	err = otx2_mbox_regions_init(&mw->mbox, mbox_regions, rvu->pdev,
-				     reg_base, dir, num);
+				     reg_base, dir, num, pf_bmap);
 	if (err)
 		goto exit;
 
 	err = otx2_mbox_regions_init(&mw->mbox_up, mbox_regions, rvu->pdev,
-				     reg_base, dir_up, num);
+				     reg_base, dir_up, num, pf_bmap);
 	if (err)
 		goto exit;
 
 	for (i = 0; i < num; i++) {
+		if (!test_bit(i, pf_bmap))
+			continue;
+
 		mwork = &mw->mbox_wrk[i];
 		mwork->rvu = rvu;
 		INIT_WORK(&mwork->work, mbox_handler);
@@ -2328,8 +2358,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		mwork->rvu = rvu;
 		INIT_WORK(&mwork->work, mbox_up_handler);
 	}
-	kfree(mbox_regions);
-	return 0;
+	goto free_regions;
 
 exit:
 	destroy_workqueue(mw->mbox_wq);
@@ -2338,6 +2367,8 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		iounmap((void __iomem *)mbox_regions[num]);
 free_regions:
 	kfree(mbox_regions);
+free_bitmap:
+	bitmap_free(pf_bmap);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 46a41cfff575..25713287a288 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -60,13 +60,14 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 			   u64 iova, u64 *lmt_addr)
 {
 	u64 pa, val, pf;
-	int err;
+	int err = 0;
 
 	if (!iova) {
 		dev_err(rvu->dev, "%s Requested Null address for transulation\n", __func__);
 		return -EINVAL;
 	}
 
+	mutex_lock(&rvu->rsrc_lock);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_REQ, iova);
 	pf = rvu_get_pf(pcifunc) & 0x1F;
 	val = BIT_ULL(63) | BIT_ULL(14) | BIT_ULL(13) | pf << 8 |
@@ -76,12 +77,13 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 	err = rvu_poll_reg(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_RSP_STS, BIT_ULL(0), false);
 	if (err) {
 		dev_err(rvu->dev, "%s LMTLINE iova transulation failed\n", __func__);
-		return err;
+		goto exit;
 	}
 	val = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_RSP_STS);
 	if (val & ~0x1ULL) {
 		dev_err(rvu->dev, "%s LMTLINE iova transulation failed err:%llx\n", __func__, val);
-		return -EIO;
+		err = -EIO;
+		goto exit;
 	}
 	/* PA[51:12] = RVU_AF_SMMU_TLN_FLIT0[57:18]
 	 * PA[11:0] = IOVA[11:0]
@@ -89,8 +91,9 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 	pa = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_TLN_FLIT0) >> 18;
 	pa &= GENMASK_ULL(39, 0);
 	*lmt_addr = (pa << 12) | (iova  & 0xFFF);
-
-	return 0;
+exit:
+	mutex_unlock(&rvu->rsrc_lock);
+	return err;
 }
 
 static int rvu_update_lmtaddr(struct rvu *rvu, u16 pcifunc, u64 lmt_addr)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ab291c2c3014..a987ae9d6a28 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1761,13 +1761,22 @@ int otx2_open(struct net_device *netdev)
 		otx2_dmacflt_reinstall_flows(pf);
 
 	err = otx2_rxtx_enable(pf, true);
-	if (err)
+	/* If a mbox communication error happens at this point then interface
+	 * will end up in a state such that it is in down state but hardware
+	 * mcam entries are enabled to receive the packets. Hence disable the
+	 * packet I/O.
+	 */
+	if (err == EIO)
+		goto err_disable_rxtx;
+	else if (err)
 		goto err_tx_stop_queues;
 
 	otx2_do_set_rx_mode(pf);
 
 	return 0;
 
+err_disable_rxtx:
+	otx2_rxtx_enable(pf, false);
 err_tx_stop_queues:
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 9822db362c88..e69b0e2729cb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -630,7 +630,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	err = otx2vf_realloc_msix_vectors(vf);
 	if (err)
-		goto err_mbox_destroy;
+		goto err_detach_rsrc;
 
 	err = otx2_set_real_num_queues(netdev, qcount, qcount);
 	if (err)
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
index c7d0e195d176..5c06decc868c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
@@ -65,6 +65,8 @@ struct ionic *ionic_devlink_alloc(struct device *dev)
 	struct devlink *dl;
 
 	dl = devlink_alloc(&ionic_dl_ops, sizeof(struct ionic), dev);
+	if (!dl)
+		return NULL;
 
 	return devlink_priv(dl);
 }
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 3de1a03839e2..2fa116c3694c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -724,7 +724,7 @@ static int ionic_get_rxnfc(struct net_device *netdev,
 		info->data = lif->nxqs;
 		break;
 	default:
-		netdev_err(netdev, "Command parameter %d is not supported\n",
+		netdev_dbg(netdev, "Command parameter %d is not supported\n",
 			   info->cmd);
 		err = -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/sfc/mcdi_port_common.c b/drivers/net/ethernet/sfc/mcdi_port_common.c
index c4fe3c48ac46..eccb97a5d938 100644
--- a/drivers/net/ethernet/sfc/mcdi_port_common.c
+++ b/drivers/net/ethernet/sfc/mcdi_port_common.c
@@ -974,12 +974,15 @@ static u32 efx_mcdi_phy_module_type(struct efx_nic *efx)
 
 	/* A QSFP+ NIC may actually have an SFP+ module attached.
 	 * The ID is page 0, byte 0.
+	 * QSFP28 is of type SFF_8636, however, this is treated
+	 * the same by ethtool, so we can also treat them the same.
 	 */
 	switch (efx_mcdi_phy_get_module_eeprom_byte(efx, 0, 0)) {
-	case 0x3:
+	case 0x3: /* SFP */
 		return MC_CMD_MEDIA_SFP_PLUS;
-	case 0xc:
-	case 0xd:
+	case 0xc: /* QSFP */
+	case 0xd: /* QSFP+ */
+	case 0x11: /* QSFP28 */
 		return MC_CMD_MEDIA_QSFP_PLUS;
 	default:
 		return 0;
@@ -1077,7 +1080,7 @@ int efx_mcdi_phy_get_module_info(struct efx_nic *efx, struct ethtool_modinfo *mo
 
 	case MC_CMD_MEDIA_QSFP_PLUS:
 		modinfo->type = ETH_MODULE_SFF_8436;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		break;
 
 	default:
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index cf6941b1d280..579524cb5d9b 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -199,6 +199,7 @@
 #define OCP_EEE_AR		0xa41a
 #define OCP_EEE_DATA		0xa41c
 #define OCP_PHY_STATUS		0xa420
+#define OCP_INTR_EN		0xa424
 #define OCP_NCTL_CFG		0xa42c
 #define OCP_POWER_CFG		0xa430
 #define OCP_EEE_CFG		0xa432
@@ -620,6 +621,9 @@ enum spd_duplex {
 #define PHY_STAT_LAN_ON		3
 #define PHY_STAT_PWRDN		5
 
+/* OCP_INTR_EN */
+#define INTR_SPEED_FORCE	BIT(3)
+
 /* OCP_NCTL_CFG */
 #define PGA_RETURN_EN		BIT(1)
 
@@ -3016,12 +3020,16 @@ static int rtl_enable(struct r8152 *tp)
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, ocp_data);
 
 	switch (tp->version) {
-	case RTL_VER_08:
-	case RTL_VER_09:
-	case RTL_VER_14:
-		r8153b_rx_agg_chg_indicate(tp);
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_03:
+	case RTL_VER_04:
+	case RTL_VER_05:
+	case RTL_VER_06:
+	case RTL_VER_07:
 		break;
 	default:
+		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	}
 
@@ -3075,7 +3083,6 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 			       640 / 8);
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
 			       ocp_data);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 
 	default:
@@ -3109,7 +3116,6 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 	case RTL_VER_15:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 8);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -5979,6 +5985,25 @@ static void rtl8153_disable(struct r8152 *tp)
 	r8153_aldps_en(tp, true);
 }
 
+static u32 fc_pause_on_auto(struct r8152 *tp)
+{
+	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 6 * 1024);
+}
+
+static u32 fc_pause_off_auto(struct r8152 *tp)
+{
+	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 14 * 1024);
+}
+
+static void r8156_fc_parameter(struct r8152 *tp)
+{
+	u32 pause_on = tp->fc_pause_on ? tp->fc_pause_on : fc_pause_on_auto(tp);
+	u32 pause_off = tp->fc_pause_off ? tp->fc_pause_off : fc_pause_off_auto(tp);
+
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, pause_on / 16);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, pause_off / 16);
+}
+
 static int rtl8156_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -5987,6 +6012,7 @@ static int rtl8156_enable(struct r8152 *tp)
 	if (test_bit(RTL8152_UNPLUG, &tp->flags))
 		return -ENODEV;
 
+	r8156_fc_parameter(tp);
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 	r8153_set_rx_early_timeout(tp);
@@ -6018,9 +6044,24 @@ static int rtl8156_enable(struct r8152 *tp)
 		ocp_write_word(tp, MCU_TYPE_USB, USB_L1_CTRL, ocp_data);
 	}
 
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
+	ocp_data &= ~FC_PATCH_TASK;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+	usleep_range(1000, 2000);
+	ocp_data |= FC_PATCH_TASK;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+
 	return rtl_enable(tp);
 }
 
+static void rtl8156_disable(struct r8152 *tp)
+{
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, 0);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, 0);
+
+	rtl8153_disable(tp);
+}
+
 static int rtl8156b_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -6422,25 +6463,6 @@ static void rtl8153c_up(struct r8152 *tp)
 	r8153b_u1u2en(tp, true);
 }
 
-static inline u32 fc_pause_on_auto(struct r8152 *tp)
-{
-	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 6 * 1024);
-}
-
-static inline u32 fc_pause_off_auto(struct r8152 *tp)
-{
-	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 14 * 1024);
-}
-
-static void r8156_fc_parameter(struct r8152 *tp)
-{
-	u32 pause_on = tp->fc_pause_on ? tp->fc_pause_on : fc_pause_on_auto(tp);
-	u32 pause_off = tp->fc_pause_off ? tp->fc_pause_off : fc_pause_off_auto(tp);
-
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, pause_on / 16);
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, pause_off / 16);
-}
-
 static void rtl8156_change_mtu(struct r8152 *tp)
 {
 	u32 rx_max_size = mtu_to_size(tp->netdev->mtu);
@@ -7531,6 +7553,11 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 				      ((swap_a & 0x1f) << 8) |
 				      ((swap_a >> 8) & 0x1f));
 		}
+
+		/* Notify the MAC when the speed is changed to force mode. */
+		data = ocp_reg_read(tp, OCP_INTR_EN);
+		data |= INTR_SPEED_FORCE;
+		ocp_reg_write(tp, OCP_INTR_EN, data);
 		break;
 	default:
 		break;
@@ -7926,6 +7953,11 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		break;
 	}
 
+	/* Notify the MAC when the speed is changed to force mode. */
+	data = ocp_reg_read(tp, OCP_INTR_EN);
+	data |= INTR_SPEED_FORCE;
+	ocp_reg_write(tp, OCP_INTR_EN, data);
+
 	if (rtl_phy_patch_request(tp, true, true))
 		return;
 
@@ -9366,7 +9398,7 @@ static int rtl_ops_init(struct r8152 *tp)
 	case RTL_VER_10:
 		ops->init		= r8156_init;
 		ops->enable		= rtl8156_enable;
-		ops->disable		= rtl8153_disable;
+		ops->disable		= rtl8156_disable;
 		ops->up			= rtl8156_up;
 		ops->down		= rtl8156_down;
 		ops->unload		= rtl8153_unload;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8a380086ac25..9f2d691908b4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2814,6 +2814,27 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 			put_page(vi->rq[i].alloc_frag.page);
 }
 
+static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
+{
+	if (!is_xdp_frame(buf))
+		dev_kfree_skb(buf);
+	else
+		xdp_return_frame(ptr_to_xdp(buf));
+}
+
+static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int i = vq2rxq(vq);
+
+	if (vi->mergeable_rx_bufs)
+		put_page(virt_to_head_page(buf));
+	else if (vi->big_packets)
+		give_pages(&vi->rq[i], buf);
+	else
+		put_page(virt_to_head_page(buf));
+}
+
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
@@ -2821,26 +2842,16 @@ static void free_unused_bufs(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->sq[i].vq;
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (!is_xdp_frame(buf))
-				dev_kfree_skb(buf);
-			else
-				xdp_return_frame(ptr_to_xdp(buf));
-		}
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_sq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
-
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (vi->mergeable_rx_bufs) {
-				put_page(virt_to_head_page(buf));
-			} else if (vi->big_packets) {
-				give_pages(&vi->rq[i], buf);
-			} else {
-				put_page(virt_to_head_page(buf));
-			}
-		}
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_rq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 897da3ed2f02..280602a34fe6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -40,7 +40,7 @@ static int rtw8821c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 
 	map = (struct rtw8821c_efuse *)log_map;
 
-	efuse->rfe_option = map->rfe_option;
+	efuse->rfe_option = map->rfe_option & 0x1f;
 	efuse->rf_board_option = map->rf_board_option;
 	efuse->crystal_cap = map->xtal_k;
 	efuse->pa_type_2g = map->pa_type;
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 69ba2c518261..90aee8b87bbe 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -327,6 +327,22 @@ static const struct ts_dmi_data dexp_ursus_7w_data = {
 	.properties	= dexp_ursus_7w_props,
 };
 
+static const struct property_entry dexp_ursus_kx210i_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 5),
+	PROPERTY_ENTRY_U32("touchscreen-min-y",  2),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1137),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-dexp-ursus-kx210i.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data dexp_ursus_kx210i_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= dexp_ursus_kx210i_props,
+};
+
 static const struct property_entry digma_citi_e200_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
@@ -381,6 +397,11 @@ static const struct ts_dmi_data glavey_tm800a550l_data = {
 	.properties	= glavey_tm800a550l_props,
 };
 
+static const struct ts_dmi_data gdix1002_00_upside_down_data = {
+	.acpi_name	= "GDIX1002:00",
+	.properties	= gdix1001_upside_down_props,
+};
+
 static const struct property_entry gp_electronic_t701_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 960),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 640),
@@ -1161,6 +1182,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "7W"),
 		},
 	},
+	{
+		/* DEXP Ursus KX210i */
+		.driver_data = (void *)&dexp_ursus_kx210i_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "INSYDE Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S107I"),
+		},
+	},
 	{
 		/* Digma Citi E200 */
 		.driver_data = (void *)&digma_citi_e200_data,
@@ -1280,6 +1309,18 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
 		},
 	},
+	{
+		/* Juno Tablet */
+		.driver_data = (void *)&gdix1002_00_upside_down_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
+			/* Both product- and board-name being "Default string" is somewhat rare */
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			/* Above matches are too generic, add partial bios-version match */
+			DMI_MATCH(DMI_BIOS_VERSION, "JP2V1."),
+		},
+	},
 	{
 		/* Mediacom WinPad 7.0 W700 (same hw as Wintron surftab 7") */
 		.driver_data = (void *)&trekstor_surftab_wintron70_data,
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index e8a170ad43c1..c4e1ad813e09 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -452,6 +452,7 @@ static int imx_rproc_prepare(struct rproc *rproc)
 
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(priv->dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -464,10 +465,12 @@ static int imx_rproc_prepare(struct rproc *rproc)
 					   imx_rproc_mem_alloc, imx_rproc_mem_release,
 					   it.node->name);
 
-		if (mem)
+		if (mem) {
 			rproc_coredump_add_segment(rproc, da, rmem->size);
-		else
+		} else {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 	}
diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index a3268d95a50e..e6bd3c7a950a 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -129,6 +129,7 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -150,8 +151,10 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index b643efcf995a..a0fabc3f13dc 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -223,11 +223,13 @@ static int stm32_rproc_prepare(struct rproc *rproc)
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
 		if (stm32_rproc_pa_to_da(rproc, rmem->base, &da) < 0) {
+			of_node_put(it.node);
 			dev_err(dev, "memory region not valid %pa\n",
 				&rmem->base);
 			return -EINVAL;
@@ -254,8 +256,10 @@ static int stm32_rproc_prepare(struct rproc *rproc)
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index a117d11f2b07..e0096fc5927e 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2455,6 +2455,9 @@ static void __qedi_remove(struct pci_dev *pdev, int mode)
 		qedi_ops->ll2->stop(qedi->cdev);
 	}
 
+	cancel_delayed_work_sync(&qedi->recovery_work);
+	cancel_delayed_work_sync(&qedi->board_disable_work);
+
 	qedi_free_iscsi_pf_param(qedi);
 
 	rval = qedi_ops->common->update_drv_state(qedi->cdev, false);
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b3abc29aa927..bb1a98c97adf 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -349,6 +349,13 @@ static inline void serial8250_do_prepare_rx_dma(struct uart_8250_port *p)
 	if (dma->prepare_rx_dma)
 		dma->prepare_rx_dma(p);
 }
+
+static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	return dma && dma->tx_running;
+}
 #else
 static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
@@ -364,6 +371,11 @@ static inline int serial8250_request_dma(struct uart_8250_port *p)
 	return -1;
 }
 static inline void serial8250_release_dma(struct uart_8250_port *p) { }
+
+static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
+{
+	return false;
+}
 #endif
 
 static inline int ns16550a_goto_highspeed(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5939f510cb0c..bfdd9ecc2baf 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1988,19 +1988,25 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int result = 0;
 	unsigned long flags;
 	unsigned int lsr;
 
 	serial8250_rpm_get(up);
 
 	spin_lock_irqsave(&port->lock, flags);
-	lsr = serial_port_in(port, UART_LSR);
-	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	if (!serial8250_tx_dma_running(up)) {
+		lsr = serial_port_in(port, UART_LSR);
+		up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+
+		if ((lsr & BOTH_EMPTY) == BOTH_EMPTY)
+			result = TIOCSER_TEMT;
+	}
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	serial8250_rpm_put(up);
 
-	return (lsr & BOTH_EMPTY) == BOTH_EMPTY ? TIOCSER_TEMT : 0;
+	return result;
 }
 
 unsigned int serial8250_do_get_mctrl(struct uart_port *port)
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index cd578843277e..498c1c403fc9 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -637,7 +637,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = dw_wdt_init_timeouts(dw_wdt, dev);
 	if (ret)
-		goto out_disable_clk;
+		goto out_assert_rst;
 
 	wdd = &dw_wdt->wdd;
 	wdd->ops = &dw_wdt_ops;
@@ -668,12 +668,15 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = watchdog_register_device(wdd);
 	if (ret)
-		goto out_disable_pclk;
+		goto out_assert_rst;
 
 	dw_wdt_dbgfs_init(dw_wdt);
 
 	return 0;
 
+out_assert_rst:
+	reset_control_assert(dw_wdt->rst);
+
 out_disable_pclk:
 	clk_disable_unprepare(dw_wdt->pclk);
 
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 04a6226e0388..aff09ffddb32 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -121,7 +121,8 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 	} else {
 		num_bytes = 0;
 	}
-	if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
+	if (qgroup_to_release_ret &&
+	    block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
 		qgroup_to_release = block_rsv->qgroup_rsv_reserved -
 				    block_rsv->qgroup_rsv_size;
 		block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index fb7e331b6975..a31986ca9224 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4189,10 +4189,12 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 {
 	struct btrfs_key key;
+	struct btrfs_key orig_key;
 	struct btrfs_disk_key found_key;
 	int ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
+	orig_key = key;
 
 	if (key.offset > 0) {
 		key.offset--;
@@ -4209,8 +4211,36 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 
 	btrfs_release_path(path);
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
+	if (ret <= 0)
 		return ret;
+
+	/*
+	 * Previous key not found. Even if we were at slot 0 of the leaf we had
+	 * before releasing the path and calling btrfs_search_slot(), we now may
+	 * be in a slot pointing to the same original key - this can happen if
+	 * after we released the path, one of more items were moved from a
+	 * sibling leaf into the front of the leaf we had due to an insertion
+	 * (see push_leaf_right()).
+	 * If we hit this case and our slot is > 0 and just decrement the slot
+	 * so that the caller does not process the same key again, which may or
+	 * may not break the caller, depending on its logic.
+	 */
+	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
+		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
+		ret = comp_keys(&found_key, &orig_key);
+		if (ret == 0) {
+			if (path->slots[0] > 0) {
+				path->slots[0]--;
+				return 0;
+			}
+			/*
+			 * At slot 0, same key as before, it means orig_key is
+			 * the lowest, leftmost, key in the tree. We're done.
+			 */
+			return 1;
+		}
+	}
+
 	btrfs_item_key(path->nodes[0], &found_key, 0);
 	ret = comp_keys(&found_key, &key);
 	/*
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 161a69d7e117..dd8b02a2a14a 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -47,13 +47,13 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	u64 start, end, i_size;
 	int ret;
 
+	spin_lock(&inode->lock);
 	i_size = new_i_size ?: i_size_read(&inode->vfs_inode);
 	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
 		inode->disk_i_size = i_size;
-		return;
+		goto out_unlock;
 	}
 
-	spin_lock(&inode->lock);
 	ret = find_contiguous_extent_bit(&inode->file_extent_tree, 0, &start,
 					 &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
@@ -61,6 +61,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	else
 		i_size = 0;
 	inode->disk_i_size = i_size;
+out_unlock:
 	spin_unlock(&inode->lock);
 }
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 529907ea3825..9161bc4f4064 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -825,15 +825,16 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			}
 			spin_lock(&ctl->tree_lock);
 			ret = link_free_space(ctl, e);
-			ctl->total_bitmaps++;
-			recalculate_thresholds(ctl);
-			spin_unlock(&ctl->tree_lock);
 			if (ret) {
+				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
+			ctl->total_bitmaps++;
+			recalculate_thresholds(ctl);
+			spin_unlock(&ctl->tree_lock);
 			list_add_tail(&e->list, &bitmaps);
 		}
 
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index aae1027bd76a..0757f133e302 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -147,10 +147,10 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
 			pr_cont("shared data backref parent %llu count %u\n",
 			       offset, btrfs_shared_data_ref_count(eb, sref));
 			/*
-			 * offset is supposed to be a tree block which
-			 * must be aligned to nodesize.
+			 * Offset is supposed to be a tree block which must be
+			 * aligned to sectorsize.
 			 */
-			if (!IS_ALIGNED(offset, eb->fs_info->nodesize))
+			if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
 				pr_info(
 			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
 				     offset, eb->fs_info->sectorsize);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index dbb75c2995e9..8c858f31bdbc 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1014,12 +1014,12 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 		return -ERANGE;
 
 	/* All the zones are conventional */
-	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
+	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
 		return 0;
 
 	/* All the zones are sequential and empty */
-	if (find_next_zero_bit(zinfo->seq_zones, begin, end) == end &&
-	    find_next_zero_bit(zinfo->empty_zones, begin, end) == end)
+	if (find_next_zero_bit(zinfo->seq_zones, end, begin) == end &&
+	    find_next_zero_bit(zinfo->empty_zones, end, begin) == end)
 		return 0;
 
 	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
@@ -1347,11 +1347,11 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	    !list_empty(&eb->release_list))
 		return;
 
+	memzero_extent_buffer(eb, 0, eb->len);
+	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
 			       eb->start + eb->len - 1, EXTENT_DIRTY);
-	memzero_extent_buffer(eb, 0, eb->len);
-	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 
 	spin_lock(&trans->releasing_ebs_lock);
 	list_add_tail(&eb->release_list, &trans->releasing_ebs);
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 26f87437b2dd..c9481289266c 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -715,6 +715,7 @@ static void cifs_umount_begin(struct super_block *sb)
 		tcon->tidStatus = CifsExiting;
 	spin_unlock(&cifs_tcp_ses_lock);
 
+	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
@@ -730,6 +731,20 @@ static void cifs_umount_begin(struct super_block *sb)
 	return;
 }
 
+static int cifs_freeze(struct super_block *sb)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
+	struct cifs_tcon *tcon;
+
+	if (cifs_sb == NULL)
+		return 0;
+
+	tcon = cifs_sb_master_tcon(cifs_sb);
+
+	cifs_close_all_deferred_files(tcon);
+	return 0;
+}
+
 #ifdef CONFIG_CIFS_STATS2
 static int cifs_show_stats(struct seq_file *s, struct dentry *root)
 {
@@ -761,6 +776,7 @@ static const struct super_operations cifs_super_ops = {
 	as opens */
 	.show_options = cifs_show_options,
 	.umount_begin   = cifs_umount_begin,
+	.freeze_fs      = cifs_freeze,
 #ifdef CONFIG_CIFS_STATS2
 	.show_stats = cifs_show_stats,
 #endif
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index f6c41265fdfd..a521c705b0d7 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2474,6 +2474,13 @@ cifs_match_super(struct super_block *sb, void *data)
 
 	spin_lock(&cifs_tcp_ses_lock);
 	cifs_sb = CIFS_SB(sb);
+
+	/* We do not want to use a superblock that has been shutdown */
+	if (CIFS_MOUNT_SHUTDOWN & cifs_sb->mnt_cifs_flags) {
+		spin_unlock(&cifs_tcp_ses_lock);
+		return 0;
+	}
+
 	tlink = cifs_get_tlink(cifs_sb_master_tlink(cifs_sb));
 	if (tlink == NULL) {
 		/* can not match superblock if tlink were ever null */
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index fab582933909..54058a9ada74 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1893,7 +1893,7 @@ smb2_copychunk_range(const unsigned int xid,
 		pcchunk->SourceOffset = cpu_to_le64(src_off);
 		pcchunk->TargetOffset = cpu_to_le64(dest_off);
 		pcchunk->Length =
-			cpu_to_le32(min_t(u32, len, tcon->max_bytes_chunk));
+			cpu_to_le32(min_t(u64, len, tcon->max_bytes_chunk));
 
 		/* Request server copy to target from src identified by key */
 		kfree(retbuf);
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index f9a79053f03a..05ff34e92562 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -303,6 +303,22 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 	return desc;
 }
 
+static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
+						    ext4_group_t block_group,
+						    struct buffer_head *bh)
+{
+	ext4_grpblk_t next_zero_bit;
+	unsigned long bitmap_size = sb->s_blocksize * 8;
+	unsigned int offset = num_clusters_in_group(sb, block_group);
+
+	if (bitmap_size <= offset)
+		return 0;
+
+	next_zero_bit = ext4_find_next_zero_bit(bh->b_data, bitmap_size, offset);
+
+	return (next_zero_bit < bitmap_size ? next_zero_bit : 0);
+}
+
 /*
  * Return the block number which was discovered to be invalid, or 0 if
  * the block bitmap is valid.
@@ -401,6 +417,15 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		return -EFSCORRUPTED;
 	}
+	blk = ext4_valid_block_bitmap_padding(sb, block_group, bh);
+	if (unlikely(blk != 0)) {
+		ext4_unlock_group(sb, block_group);
+		ext4_error(sb, "bg %u: block %llu: padding at end of block bitmap is not set",
+			   block_group, blk);
+		ext4_mark_group_bitmap_corrupted(sb, block_group,
+						 EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		return -EFSCORRUPTED;
+	}
 	set_buffer_verified(bh);
 verified:
 	ext4_unlock_group(sb, block_group);
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index aa99a3659edf..fee54ab42bba 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -269,14 +269,12 @@ static void __es_find_extent_range(struct inode *inode,
 
 	/* see if the extent has been cached */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u) %llu %x\n",
-				 lblk, es1->es_lblk, es1->es_len,
-				 ext4_es_pblock(es1), ext4_es_status(es1));
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u) %llu %x\n",
+			 lblk, es1->es_lblk, es1->es_len,
+			 ext4_es_pblock(es1), ext4_es_status(es1));
+		goto out;
 	}
 
 	es1 = __es_tree_search(&tree->root, lblk);
@@ -295,7 +293,7 @@ static void __es_find_extent_range(struct inode *inode,
 	}
 
 	if (es1 && matching_fn(es1)) {
-		tree->cache_es = es1;
+		WRITE_ONCE(tree->cache_es, es1);
 		es->es_lblk = es1->es_lblk;
 		es->es_len = es1->es_len;
 		es->es_pblk = es1->es_pblk;
@@ -934,14 +932,12 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	/* find extent in cache firstly */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u)\n",
-				 lblk, es1->es_lblk, es1->es_len);
-			found = 1;
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u)\n",
+			 lblk, es1->es_lblk, es1->es_len);
+		found = 1;
+		goto out;
 	}
 
 	node = tree->root.rb_node;
diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index f34f4176c1e7..3b03e6b061db 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -277,7 +277,11 @@ static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 	}
 	default:
 		hinfo->hash = 0;
-		return -1;
+		hinfo->minor_hash = 0;
+		ext4_warning(dir->i_sb,
+			     "invalid/unsupported hash tree version %u",
+			     hinfo->hash_version);
+		return -EINVAL;
 	}
 	hash = hash & ~1;
 	if (hash == (EXT4_HTREE_EOF_32BIT << 1))
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 6473786c44fe..6fe665de1b20 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -33,6 +33,7 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	struct ext4_inode *raw_inode;
+	void *end;
 	int free, min_offs;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
@@ -56,14 +57,23 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	raw_inode = ext4_raw_inode(iloc);
 	header = IHDR(inode, raw_inode);
 	entry = IFIRST(header);
+	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 
 	/* Compute min_offs. */
-	for (; !IS_LAST_ENTRY(entry); entry = EXT4_XATTR_NEXT(entry)) {
+	while (!IS_LAST_ENTRY(entry)) {
+		void *next = EXT4_XATTR_NEXT(entry);
+
+		if (next >= end) {
+			EXT4_ERROR_INODE(inode,
+					 "corrupt xattr in inline inode");
+			return 0;
+		}
 		if (!entry->e_value_inum && entry->e_value_size) {
 			size_t offs = le16_to_cpu(entry->e_value_offs);
 			if (offs < min_offs)
 				min_offs = offs;
 		}
+		entry = next;
 	}
 	free = min_offs -
 		((void *)entry - (void *)IFIRST(header)) - sizeof(__u32);
@@ -350,7 +360,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 
 	error = ext4_xattr_ibody_get(inode, i.name_index, i.name,
 				     value, len);
-	if (error == -ENODATA)
+	if (error < 0)
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
@@ -1185,6 +1195,7 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 		ext4_initialize_dirent_tail(dir_block,
 					    inode->i_sb->s_blocksize);
 	set_buffer_uptodate(dir_block);
+	unlock_buffer(dir_block);
 	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
 	if (err)
 		return err;
@@ -1259,6 +1270,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	if (!S_ISDIR(inode->i_mode)) {
 		memcpy(data_bh->b_data, buf, inline_size);
 		set_buffer_uptodate(data_bh);
+		unlock_buffer(data_bh);
 		error = ext4_handle_dirty_metadata(handle,
 						   inode, data_bh);
 	} else {
@@ -1266,7 +1278,6 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 						       buf, inline_size);
 	}
 
-	unlock_buffer(data_bh);
 out_restore:
 	if (error)
 		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 20b446a23e23..41cd92083e2e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3478,7 +3478,7 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
 	 */
 	flags &= ~IOMAP_WRITE;
 	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
-	WARN_ON_ONCE(iomap->type != IOMAP_MAPPED);
+	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
 	return ret;
 }
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e6718bfc6c55..0e0226b30db6 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4832,7 +4832,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 	trace_ext4_mb_release_group_pa(sb, pa);
 	BUG_ON(pa->pa_deleted == 0);
 	ext4_get_group_no_and_offset(sb, pa->pa_pstart, &group, &bit);
-	BUG_ON(group != e4b->bd_group && pa->pa_len != 0);
+	if (unlikely(group != e4b->bd_group && pa->pa_len != 0)) {
+		ext4_warning(sb, "bad group: expected %u, group %u, pa_start %llu",
+			     e4b->bd_group, group, pa->pa_pstart);
+		return 0;
+	}
 	mb_free_blocks(pa->pa_inode, e4b, bit, pa->pa_len);
 	atomic_add(pa->pa_len, &EXT4_SB(sb)->s_mb_discarded);
 	trace_ext4_mballoc_discard(sb, NULL, group, bit, pa->pa_len);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0c47e1e3cba4..b87269bae4fb 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -674,7 +674,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 				len = de->name_len;
 				if (!IS_ENCRYPTED(dir)) {
 					/* Directory is not encrypted */
-					ext4fs_dirhash(dir, de->name,
+					(void) ext4fs_dirhash(dir, de->name,
 						de->name_len, &h);
 					printk("%*.s:(U)%x.%u ", len,
 					       name, h.hash,
@@ -709,8 +709,9 @@ static struct stats dx_show_leaf(struct inode *dir,
 					if (IS_CASEFOLDED(dir))
 						h.hash = EXT4_DIRENT_HASH(de);
 					else
-						ext4fs_dirhash(dir, de->name,
-						       de->name_len, &h);
+						(void) ext4fs_dirhash(dir,
+							de->name,
+							de->name_len, &h);
 					printk("%*.s:(E)%x.%u ", len, name,
 					       h.hash, (unsigned) ((char *) de
 								   - base));
@@ -720,7 +721,8 @@ static struct stats dx_show_leaf(struct inode *dir,
 #else
 				int len = de->name_len;
 				char *name = de->name;
-				ext4fs_dirhash(dir, de->name, de->name_len, &h);
+				(void) ext4fs_dirhash(dir, de->name,
+						      de->name_len, &h);
 				printk("%*.s:%x.%u ", len, name, h.hash,
 				       (unsigned) ((char *) de - base));
 #endif
@@ -849,8 +851,14 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	hinfo->seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 	/* hash is already computed for encrypted casefolded directory */
 	if (fname && fname_name(fname) &&
-				!(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)))
-		ext4fs_dirhash(dir, fname_name(fname), fname_len(fname), hinfo);
+	    !(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir))) {
+		int ret = ext4fs_dirhash(dir, fname_name(fname),
+					 fname_len(fname), hinfo);
+		if (ret < 0) {
+			ret_err = ERR_PTR(ret);
+			goto fail;
+		}
+	}
 	hash = hinfo->hash;
 
 	if (root->info.unused_flags & 1) {
@@ -1111,7 +1119,12 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 				hinfo->minor_hash = 0;
 			}
 		} else {
-			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			err = ext4fs_dirhash(dir, de->name,
+					     de->name_len, hinfo);
+			if (err < 0) {
+				count = err;
+				goto errout;
+			}
 		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
@@ -1313,8 +1326,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 		if (de->name_len && de->inode) {
 			if (ext4_hash_in_dirent(dir))
 				h.hash = EXT4_DIRENT_HASH(de);
-			else
-				ext4fs_dirhash(dir, de->name, de->name_len, &h);
+			else {
+				int err = ext4fs_dirhash(dir, de->name,
+						     de->name_len, &h);
+				if (err < 0)
+					return err;
+			}
 			map_tail--;
 			map_tail->hash = h.hash;
 			map_tail->offs = ((char *) de - base)>>2;
@@ -1452,10 +1469,9 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	hinfo->hash_version = DX_HASH_SIPHASH;
 	hinfo->seed = NULL;
 	if (cf_name->name)
-		ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
+		return ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
 	else
-		ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
-	return 0;
+		return ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
 }
 #endif
 
@@ -2298,10 +2314,15 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	fname->hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 
 	/* casefolded encrypted hashes are computed on fname setup */
-	if (!ext4_hash_in_dirent(dir))
-		ext4fs_dirhash(dir, fname_name(fname),
-				fname_len(fname), &fname->hinfo);
-
+	if (!ext4_hash_in_dirent(dir)) {
+		int err = ext4fs_dirhash(dir, fname_name(fname),
+					 fname_len(fname), &fname->hinfo);
+		if (err < 0) {
+			brelse(bh2);
+			brelse(bh);
+			return err;
+		}
+	}
 	memset(frames, 0, sizeof(frames));
 	frame = frames;
 	frame->entries = entries;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6df4da084190..e6cd2bf9508e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2836,11 +2836,9 @@ static __le16 ext4_group_desc_csum(struct super_block *sb, __u32 block_group,
 	crc = crc16(crc, (__u8 *)gdp, offset);
 	offset += sizeof(gdp->bg_checksum); /* skip checksum */
 	/* for checksum of struct ext4_group_desc do the rest...*/
-	if (ext4_has_feature_64bit(sb) &&
-	    offset < le16_to_cpu(sbi->s_es->s_desc_size))
+	if (ext4_has_feature_64bit(sb) && offset < sbi->s_desc_size)
 		crc = crc16(crc, (__u8 *)gdp + offset,
-			    le16_to_cpu(sbi->s_es->s_desc_size) -
-				offset);
+			    sbi->s_desc_size - offset);
 
 out:
 	return cpu_to_le16(crc);
@@ -5987,9 +5985,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 
 #ifdef CONFIG_QUOTA
-	/* Release old quota file names */
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
-		kfree(old_opts.s_qf_names[i]);
 	if (enable_quota) {
 		if (sb_any_quota_suspended(sb))
 			dquot_resume(sb, -1);
@@ -5999,6 +5994,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 				goto restore_opts;
 		}
 	}
+	/* Release old quota file names */
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(old_opts.s_qf_names[i]);
 #endif
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
@@ -6019,6 +6017,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 
 restore_opts:
+	/*
+	 * If there was a failing r/w to ro transition, we may need to
+	 * re-enable quota
+	 */
+	if ((sb->s_flags & SB_RDONLY) && !(old_sb_flags & SB_RDONLY) &&
+	    sb_any_quota_suspended(sb))
+		dquot_resume(sb, -1);
 	sb->s_flags = old_sb_flags;
 	sbi->s_mount_opt = old_opts.s_mount_opt;
 	sbi->s_mount_opt2 = old_opts.s_mount_opt2;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7ef49e4b1c17..3a4f73333e8b 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2563,6 +2563,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 		.in_inode = !!entry->e_value_inum,
 	};
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
+	int needs_kvfree = 0;
 	int error;
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
@@ -2585,7 +2586,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 			error = -ENOMEM;
 			goto out;
 		}
-
+		needs_kvfree = 1;
 		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
 		if (error)
 			goto out;
@@ -2624,7 +2625,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 out:
 	kfree(b_entry_name);
-	if (entry->e_value_inum && buffer)
+	if (needs_kvfree && buffer)
 		kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 7a86a8dcf4f1..f3b7ed54f402 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -991,12 +991,20 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out;
 	}
 
+	/*
+	 * Copied from ext4_rename: we need to protect against old.inode
+	 * directory getting converted from inline directory format into
+	 * a normal one.
+	 */
+	if (S_ISDIR(old_inode->i_mode))
+		inode_lock_nested(old_inode, I_MUTEX_NONDIR2);
+
 	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
 			err = PTR_ERR(old_page);
-		goto out;
+		goto out_unlock_old;
 	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
@@ -1104,6 +1112,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	f2fs_unlock_op(sbi);
 
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
+
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		f2fs_sync_fs(sbi->sb, 1);
 
@@ -1118,6 +1129,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_put_page(old_dir_page, 0);
 out_old:
 	f2fs_put_page(old_page, 0);
+out_unlock_old:
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
 out:
 	if (whiteout)
 		iput(whiteout);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index fbc3f0ef38c0..c76537a6826a 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -825,7 +825,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 		 * is okay.  The main goal is avoiding keeping an inode on
 		 * the wrong wb for an extended period of time.
 		 */
-		if (hweight32(history) > WB_FRN_HIST_THR_SLOTS)
+		if (hweight16(history) > WB_FRN_HIST_THR_SLOTS)
 			inode_switch_wbs(inode, max_id);
 	}
 
diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index b962b16e5aeb..59d205946746 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -120,8 +120,8 @@ static int ksmbd_gen_sess_key(struct ksmbd_session *sess, char *hash,
 	return rc;
 }
 
-static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
-			    char *dname)
+static int calc_ntlmv2_hash(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+			    char *ntlmv2_hash, char *dname)
 {
 	int ret, len, conv_len;
 	wchar_t *domain = NULL;
@@ -157,7 +157,7 @@ static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
 	}
 
 	conv_len = smb_strtoUTF16(uniname, user_name(sess->user), len,
-				  sess->conn->local_nls);
+				  conn->local_nls);
 	if (conv_len < 0 || conv_len > len) {
 		ret = -EINVAL;
 		goto out;
@@ -181,7 +181,7 @@ static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
 	}
 
 	conv_len = smb_strtoUTF16((__le16 *)domain, dname, len,
-				  sess->conn->local_nls);
+				  conn->local_nls);
 	if (conv_len < 0 || conv_len > len) {
 		ret = -EINVAL;
 		goto out;
@@ -214,27 +214,28 @@ static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
  *
  * Return:	0 on success, error number on error
  */
-int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
-		      int blen, char *domain_name)
+int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+		      struct ntlmv2_resp *ntlmv2, int blen, char *domain_name,
+		      char *cryptkey)
 {
 	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
 	char ntlmv2_rsp[CIFS_HMAC_MD5_HASH_SIZE];
-	struct ksmbd_crypto_ctx *ctx;
+	struct ksmbd_crypto_ctx *ctx = NULL;
 	char *construct = NULL;
 	int rc, len;
 
+	rc = calc_ntlmv2_hash(conn, sess, ntlmv2_hash, domain_name);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not get v2 hash rc %d\n", rc);
+		goto out;
+	}
+
 	ctx = ksmbd_crypto_ctx_find_hmacmd5();
 	if (!ctx) {
 		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5\n");
 		return -ENOMEM;
 	}
 
-	rc = calc_ntlmv2_hash(sess, ntlmv2_hash, domain_name);
-	if (rc) {
-		ksmbd_debug(AUTH, "could not get v2 hash rc %d\n", rc);
-		goto out;
-	}
-
 	rc = crypto_shash_setkey(CRYPTO_HMACMD5_TFM(ctx),
 				 ntlmv2_hash,
 				 CIFS_HMAC_MD5_HASH_SIZE);
@@ -256,7 +257,7 @@ int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
 		goto out;
 	}
 
-	memcpy(construct, sess->ntlmssp.cryptkey, CIFS_CRYPTO_KEY_SIZE);
+	memcpy(construct, cryptkey, CIFS_CRYPTO_KEY_SIZE);
 	memcpy(construct + CIFS_CRYPTO_KEY_SIZE, &ntlmv2->blob_signature, blen);
 
 	rc = crypto_shash_update(CRYPTO_HMACMD5(ctx), construct, len);
@@ -270,6 +271,8 @@ int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
 		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
 		goto out;
 	}
+	ksmbd_release_crypto_ctx(ctx);
+	ctx = NULL;
 
 	rc = ksmbd_gen_sess_key(sess, ntlmv2_hash, ntlmv2_rsp);
 	if (rc) {
@@ -280,7 +283,8 @@ int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
 	if (memcmp(ntlmv2->ntlmv2_hash, ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE) != 0)
 		rc = -EINVAL;
 out:
-	ksmbd_release_crypto_ctx(ctx);
+	if (ctx)
+		ksmbd_release_crypto_ctx(ctx);
 	kfree(construct);
 	return rc;
 }
@@ -295,7 +299,8 @@ int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
  * Return:	0 on success, error number on error
  */
 int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
-				   int blob_len, struct ksmbd_session *sess)
+				   int blob_len, struct ksmbd_conn *conn,
+				   struct ksmbd_session *sess)
 {
 	char *domain_name;
 	unsigned int nt_off, dn_off;
@@ -325,16 +330,17 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 
 	/* TODO : use domain name that imported from configuration file */
 	domain_name = smb_strndup_from_utf16((const char *)authblob + dn_off,
-					     dn_len, true, sess->conn->local_nls);
+					     dn_len, true, conn->local_nls);
 	if (IS_ERR(domain_name))
 		return PTR_ERR(domain_name);
 
 	/* process NTLMv2 authentication */
 	ksmbd_debug(AUTH, "decode_ntlmssp_authenticate_blob dname%s\n",
 		    domain_name);
-	ret = ksmbd_auth_ntlmv2(sess, (struct ntlmv2_resp *)((char *)authblob + nt_off),
+	ret = ksmbd_auth_ntlmv2(conn, sess,
+				(struct ntlmv2_resp *)((char *)authblob + nt_off),
 				nt_len - CIFS_ENCPWD_SIZE,
-				domain_name);
+				domain_name, conn->ntlmssp.cryptkey);
 	kfree(domain_name);
 	return ret;
 }
@@ -348,7 +354,7 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
  *
  */
 int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
-				  int blob_len, struct ksmbd_session *sess)
+				  int blob_len, struct ksmbd_conn *conn)
 {
 	if (blob_len < sizeof(struct negotiate_message)) {
 		ksmbd_debug(AUTH, "negotiate blob len %d too small\n",
@@ -362,7 +368,7 @@ int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
 		return -EINVAL;
 	}
 
-	sess->ntlmssp.client_flags = le32_to_cpu(negblob->NegotiateFlags);
+	conn->ntlmssp.client_flags = le32_to_cpu(negblob->NegotiateFlags);
 	return 0;
 }
 
@@ -376,14 +382,14 @@ int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
  */
 unsigned int
 ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
-				   struct ksmbd_session *sess)
+				   struct ksmbd_conn *conn)
 {
 	struct target_info *tinfo;
 	wchar_t *name;
 	__u8 *target_name;
 	unsigned int flags, blob_off, blob_len, type, target_info_len = 0;
 	int len, uni_len, conv_len;
-	int cflags = sess->ntlmssp.client_flags;
+	int cflags = conn->ntlmssp.client_flags;
 
 	memcpy(chgblob->Signature, NTLMSSP_SIGNATURE, 8);
 	chgblob->MessageType = NtLmChallenge;
@@ -404,7 +410,7 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 	if (cflags & NTLMSSP_REQUEST_TARGET)
 		flags |= NTLMSSP_REQUEST_TARGET;
 
-	if (sess->conn->use_spnego &&
+	if (conn->use_spnego &&
 	    (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC))
 		flags |= NTLMSSP_NEGOTIATE_EXTENDED_SEC;
 
@@ -415,7 +421,7 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 		return -ENOMEM;
 
 	conv_len = smb_strtoUTF16((__le16 *)name, ksmbd_netbios_name(), len,
-				  sess->conn->local_nls);
+				  conn->local_nls);
 	if (conv_len < 0 || conv_len > len) {
 		kfree(name);
 		return -EINVAL;
@@ -431,8 +437,8 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 	chgblob->TargetName.BufferOffset = cpu_to_le32(blob_off);
 
 	/* Initialize random conn challenge */
-	get_random_bytes(sess->ntlmssp.cryptkey, sizeof(__u64));
-	memcpy(chgblob->Challenge, sess->ntlmssp.cryptkey,
+	get_random_bytes(conn->ntlmssp.cryptkey, sizeof(__u64));
+	memcpy(chgblob->Challenge, conn->ntlmssp.cryptkey,
 	       CIFS_CRYPTO_KEY_SIZE);
 
 	/* Add Target Information to security buffer */
@@ -632,8 +638,9 @@ struct derivation {
 	bool binding;
 };
 
-static int generate_key(struct ksmbd_session *sess, struct kvec label,
-			struct kvec context, __u8 *key, unsigned int key_size)
+static int generate_key(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+			struct kvec label, struct kvec context, __u8 *key,
+			unsigned int key_size)
 {
 	unsigned char zero = 0x0;
 	__u8 i[4] = {0, 0, 0, 1};
@@ -693,8 +700,8 @@ static int generate_key(struct ksmbd_session *sess, struct kvec label,
 		goto smb3signkey_ret;
 	}
 
-	if (sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
-	    sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
 		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L256, 4);
 	else
 		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L128, 4);
@@ -729,17 +736,17 @@ static int generate_smb3signingkey(struct ksmbd_session *sess,
 	if (!chann)
 		return 0;
 
-	if (sess->conn->dialect >= SMB30_PROT_ID && signing->binding)
+	if (conn->dialect >= SMB30_PROT_ID && signing->binding)
 		key = chann->smb3signingkey;
 	else
 		key = sess->smb3signingkey;
 
-	rc = generate_key(sess, signing->label, signing->context, key,
+	rc = generate_key(conn, sess, signing->label, signing->context, key,
 			  SMB3_SIGN_KEY_SIZE);
 	if (rc)
 		return rc;
 
-	if (!(sess->conn->dialect >= SMB30_PROT_ID && signing->binding))
+	if (!(conn->dialect >= SMB30_PROT_ID && signing->binding))
 		memcpy(chann->smb3signingkey, key, SMB3_SIGN_KEY_SIZE);
 
 	ksmbd_debug(AUTH, "dumping generated AES signing keys\n");
@@ -793,30 +800,31 @@ struct derivation_twin {
 	struct derivation decryption;
 };
 
-static int generate_smb3encryptionkey(struct ksmbd_session *sess,
+static int generate_smb3encryptionkey(struct ksmbd_conn *conn,
+				      struct ksmbd_session *sess,
 				      const struct derivation_twin *ptwin)
 {
 	int rc;
 
-	rc = generate_key(sess, ptwin->encryption.label,
+	rc = generate_key(conn, sess, ptwin->encryption.label,
 			  ptwin->encryption.context, sess->smb3encryptionkey,
 			  SMB3_ENC_DEC_KEY_SIZE);
 	if (rc)
 		return rc;
 
-	rc = generate_key(sess, ptwin->decryption.label,
+	rc = generate_key(conn, sess, ptwin->decryption.label,
 			  ptwin->decryption.context,
 			  sess->smb3decryptionkey, SMB3_ENC_DEC_KEY_SIZE);
 	if (rc)
 		return rc;
 
 	ksmbd_debug(AUTH, "dumping generated AES encryption keys\n");
-	ksmbd_debug(AUTH, "Cipher type   %d\n", sess->conn->cipher_type);
+	ksmbd_debug(AUTH, "Cipher type   %d\n", conn->cipher_type);
 	ksmbd_debug(AUTH, "Session Id    %llu\n", sess->id);
 	ksmbd_debug(AUTH, "Session Key   %*ph\n",
 		    SMB2_NTLMV2_SESSKEY_SIZE, sess->sess_key);
-	if (sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
-	    sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM) {
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM) {
 		ksmbd_debug(AUTH, "ServerIn Key  %*ph\n",
 			    SMB3_GCM256_CRYPTKEY_SIZE, sess->smb3encryptionkey);
 		ksmbd_debug(AUTH, "ServerOut Key %*ph\n",
@@ -830,7 +838,8 @@ static int generate_smb3encryptionkey(struct ksmbd_session *sess,
 	return 0;
 }
 
-int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess)
+int ksmbd_gen_smb30_encryptionkey(struct ksmbd_conn *conn,
+				  struct ksmbd_session *sess)
 {
 	struct derivation_twin twin;
 	struct derivation *d;
@@ -847,10 +856,11 @@ int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess)
 	d->context.iov_base = "ServerIn ";
 	d->context.iov_len = 10;
 
-	return generate_smb3encryptionkey(sess, &twin);
+	return generate_smb3encryptionkey(conn, sess, &twin);
 }
 
-int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess)
+int ksmbd_gen_smb311_encryptionkey(struct ksmbd_conn *conn,
+				   struct ksmbd_session *sess)
 {
 	struct derivation_twin twin;
 	struct derivation *d;
@@ -867,7 +877,7 @@ int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess)
 	d->context.iov_base = sess->Preauth_HashValue;
 	d->context.iov_len = 64;
 
-	return generate_smb3encryptionkey(sess, &twin);
+	return generate_smb3encryptionkey(conn, sess, &twin);
 }
 
 int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
diff --git a/fs/ksmbd/auth.h b/fs/ksmbd/auth.h
index 9c2d4badd05d..25b772653de0 100644
--- a/fs/ksmbd/auth.h
+++ b/fs/ksmbd/auth.h
@@ -38,16 +38,17 @@ struct kvec;
 int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
 			unsigned int nvec, int enc);
 void ksmbd_copy_gss_neg_header(void *buf);
-int ksmbd_auth_ntlm(struct ksmbd_session *sess, char *pw_buf);
-int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
-		      int blen, char *domain_name);
+int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+		      struct ntlmv2_resp *ntlmv2, int blen, char *domain_name,
+		      char *cryptkey);
 int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
-				   int blob_len, struct ksmbd_session *sess);
+				   int blob_len, struct ksmbd_conn *conn,
+				   struct ksmbd_session *sess);
 int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
-				  int blob_len, struct ksmbd_session *sess);
+				  int blob_len, struct ksmbd_conn *conn);
 unsigned int
 ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
-				   struct ksmbd_session *sess);
+				   struct ksmbd_conn *conn);
 int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
 			    int in_len,	char *out_blob, int *out_len);
 int ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
@@ -58,8 +59,10 @@ int ksmbd_gen_smb30_signingkey(struct ksmbd_session *sess,
 			       struct ksmbd_conn *conn);
 int ksmbd_gen_smb311_signingkey(struct ksmbd_session *sess,
 				struct ksmbd_conn *conn);
-int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess);
-int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess);
+int ksmbd_gen_smb30_encryptionkey(struct ksmbd_conn *conn,
+				  struct ksmbd_session *sess);
+int ksmbd_gen_smb311_encryptionkey(struct ksmbd_conn *conn,
+				   struct ksmbd_session *sess);
 int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
 				     __u8 *pi_hash);
 int ksmbd_gen_sd_hash(struct ksmbd_conn *conn, char *sd_buf, int len,
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 21cda82f156d..b4c79359ef8b 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -36,6 +36,7 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	list_del(&conn->conns_list);
 	write_unlock(&conn_list_lock);
 
+	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
 	kfree(conn);
@@ -66,12 +67,12 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 
 	init_waitqueue_head(&conn->req_running_q);
 	INIT_LIST_HEAD(&conn->conns_list);
-	INIT_LIST_HEAD(&conn->sessions);
 	INIT_LIST_HEAD(&conn->requests);
 	INIT_LIST_HEAD(&conn->async_requests);
 	spin_lock_init(&conn->request_lock);
 	spin_lock_init(&conn->credits_lock);
 	ida_init(&conn->async_ida);
+	xa_init(&conn->sessions);
 
 	spin_lock_init(&conn->llist_lock);
 	INIT_LIST_HEAD(&conn->lock_list);
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 4b15c5e673d9..89eb41bbd160 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -20,13 +20,6 @@
 
 #define KSMBD_SOCKET_BACKLOG		16
 
-/*
- * WARNING
- *
- * This is nothing but a HACK. Session status should move to channel
- * or to session. As of now we have 1 tcp_conn : 1 ksmbd_session, but
- * we need to change it to 1 tcp_conn : N ksmbd_sessions.
- */
 enum {
 	KSMBD_SESS_NEW = 0,
 	KSMBD_SESS_GOOD,
@@ -55,7 +48,7 @@ struct ksmbd_conn {
 	struct nls_table		*local_nls;
 	struct list_head		conns_list;
 	/* smb session 1 per user */
-	struct list_head		sessions;
+	struct xarray			sessions;
 	unsigned long			last_active;
 	/* How many request are running currently */
 	atomic_t			req_running;
@@ -72,12 +65,7 @@ struct ksmbd_conn {
 	int				connection_type;
 	struct ksmbd_stats		stats;
 	char				ClientGUID[SMB2_CLIENT_GUID_SIZE];
-	union {
-		/* pending trans request table */
-		struct trans_state	*recent_trans;
-		/* Used by ntlmssp */
-		char			*ntlmssp_cryptkey;
-	};
+	struct ntlmssp_auth		ntlmssp;
 
 	spinlock_t			llist_lock;
 	struct list_head		lock_list;
diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index 940385c6a913..dd262daa2c4a 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -16,7 +16,8 @@
 #include "user_session.h"
 
 struct ksmbd_tree_conn_status
-ksmbd_tree_conn_connect(struct ksmbd_session *sess, char *share_name)
+ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+			char *share_name)
 {
 	struct ksmbd_tree_conn_status status = {-ENOENT, NULL};
 	struct ksmbd_tree_connect_response *resp = NULL;
@@ -41,7 +42,7 @@ ksmbd_tree_conn_connect(struct ksmbd_session *sess, char *share_name)
 		goto out_error;
 	}
 
-	peer_addr = KSMBD_TCP_PEER_SOCKADDR(sess->conn);
+	peer_addr = KSMBD_TCP_PEER_SOCKADDR(conn);
 	resp = ksmbd_ipc_tree_connect_request(sess,
 					      sc,
 					      tree_conn,
diff --git a/fs/ksmbd/mgmt/tree_connect.h b/fs/ksmbd/mgmt/tree_connect.h
index 18e2a996e0aa..71e50271dccf 100644
--- a/fs/ksmbd/mgmt/tree_connect.h
+++ b/fs/ksmbd/mgmt/tree_connect.h
@@ -12,6 +12,7 @@
 
 struct ksmbd_share_config;
 struct ksmbd_user;
+struct ksmbd_conn;
 
 struct ksmbd_tree_connect {
 	int				id;
@@ -40,7 +41,8 @@ static inline int test_tree_conn_flag(struct ksmbd_tree_connect *tree_conn,
 struct ksmbd_session;
 
 struct ksmbd_tree_conn_status
-ksmbd_tree_conn_connect(struct ksmbd_session *sess, char *share_name);
+ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+			char *share_name);
 
 int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 			       struct ksmbd_tree_connect *tree_conn);
diff --git a/fs/ksmbd/mgmt/user_config.c b/fs/ksmbd/mgmt/user_config.c
index 1019d3677d55..279d00feff21 100644
--- a/fs/ksmbd/mgmt/user_config.c
+++ b/fs/ksmbd/mgmt/user_config.c
@@ -67,3 +67,13 @@ int ksmbd_anonymous_user(struct ksmbd_user *user)
 		return 1;
 	return 0;
 }
+
+bool ksmbd_compare_user(struct ksmbd_user *u1, struct ksmbd_user *u2)
+{
+	if (strcmp(u1->name, u2->name))
+		return false;
+	if (memcmp(u1->passkey, u2->passkey, u1->passkey_sz))
+		return false;
+
+	return true;
+}
diff --git a/fs/ksmbd/mgmt/user_config.h b/fs/ksmbd/mgmt/user_config.h
index aff80b029579..6a44109617f1 100644
--- a/fs/ksmbd/mgmt/user_config.h
+++ b/fs/ksmbd/mgmt/user_config.h
@@ -64,4 +64,5 @@ struct ksmbd_user *ksmbd_login_user(const char *account);
 struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp);
 void ksmbd_free_user(struct ksmbd_user *user);
 int ksmbd_anonymous_user(struct ksmbd_user *user);
+bool ksmbd_compare_user(struct ksmbd_user *u1, struct ksmbd_user *u2);
 #endif /* __USER_CONFIG_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 0fa467f2c897..92b1603b5abe 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -32,11 +32,13 @@ static void free_channel_list(struct ksmbd_session *sess)
 {
 	struct channel *chann, *tmp;
 
+	write_lock(&sess->chann_lock);
 	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
 				 chann_list) {
 		list_del(&chann->chann_list);
 		kfree(chann);
 	}
+	write_unlock(&sess->chann_lock);
 }
 
 static void __session_rpc_close(struct ksmbd_session *sess,
@@ -151,11 +153,6 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
 	if (!sess)
 		return;
 
-	if (!atomic_dec_and_test(&sess->refcnt))
-		return;
-
-	list_del(&sess->sessions_entry);
-
 	down_write(&sessions_table_lock);
 	hash_del(&sess->hlist);
 	up_write(&sessions_table_lock);
@@ -183,53 +180,70 @@ static struct ksmbd_session *__session_lookup(unsigned long long id)
 	return NULL;
 }
 
-void ksmbd_session_register(struct ksmbd_conn *conn,
-			    struct ksmbd_session *sess)
+int ksmbd_session_register(struct ksmbd_conn *conn,
+			   struct ksmbd_session *sess)
 {
-	sess->conn = conn;
-	list_add(&sess->sessions_entry, &conn->sessions);
+	sess->dialect = conn->dialect;
+	memcpy(sess->ClientGUID, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
+	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
 }
 
-void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
+static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
-	struct ksmbd_session *sess;
-
-	while (!list_empty(&conn->sessions)) {
-		sess = list_entry(conn->sessions.next,
-				  struct ksmbd_session,
-				  sessions_entry);
+	struct channel *chann, *tmp;
 
-		ksmbd_session_destroy(sess);
+	write_lock(&sess->chann_lock);
+	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
+				 chann_list) {
+		if (chann->conn == conn) {
+			list_del(&chann->chann_list);
+			kfree(chann);
+			write_unlock(&sess->chann_lock);
+			return 0;
+		}
 	}
-}
+	write_unlock(&sess->chann_lock);
 
-static bool ksmbd_session_id_match(struct ksmbd_session *sess,
-				   unsigned long long id)
-{
-	return sess->id == id;
+	return -ENOENT;
 }
 
-struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
-					   unsigned long long id)
+void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 {
-	struct ksmbd_session *sess = NULL;
+	struct ksmbd_session *sess;
 
-	list_for_each_entry(sess, &conn->sessions, sessions_entry) {
-		if (ksmbd_session_id_match(sess, id))
-			return sess;
+	if (conn->binding) {
+		int bkt;
+
+		down_write(&sessions_table_lock);
+		hash_for_each(sessions_table, bkt, sess, hlist) {
+			if (!ksmbd_chann_del(conn, sess)) {
+				up_write(&sessions_table_lock);
+				goto sess_destroy;
+			}
+		}
+		up_write(&sessions_table_lock);
+	} else {
+		unsigned long id;
+
+		xa_for_each(&conn->sessions, id, sess) {
+			if (!ksmbd_chann_del(conn, sess))
+				goto sess_destroy;
+		}
 	}
-	return NULL;
-}
 
-int get_session(struct ksmbd_session *sess)
-{
-	return atomic_inc_not_zero(&sess->refcnt);
+	return;
+
+sess_destroy:
+	if (list_empty(&sess->ksmbd_chann_list)) {
+		xa_erase(&conn->sessions, sess->id);
+		ksmbd_session_destroy(sess);
+	}
 }
 
-void put_session(struct ksmbd_session *sess)
+struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
+					   unsigned long long id)
 {
-	if (atomic_dec_and_test(&sess->refcnt))
-		pr_err("get/%s seems to be mismatched.", __func__);
+	return xa_load(&conn->sessions, id);
 }
 
 struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
@@ -238,10 +252,6 @@ struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
-	if (sess) {
-		if (!get_session(sess))
-			sess = NULL;
-	}
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -255,6 +265,8 @@ struct ksmbd_session *ksmbd_session_lookup_all(struct ksmbd_conn *conn,
 	sess = ksmbd_session_lookup(conn, id);
 	if (!sess && conn->binding)
 		sess = ksmbd_session_lookup_slowpath(id);
+	if (sess && sess->state != SMB2_SESSION_VALID)
+		sess = NULL;
 	return sess;
 }
 
@@ -316,12 +328,11 @@ static struct ksmbd_session *__session_create(int protocol)
 		goto error;
 
 	set_session_flag(sess, protocol);
-	INIT_LIST_HEAD(&sess->sessions_entry);
 	xa_init(&sess->tree_conns);
 	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
 	INIT_LIST_HEAD(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
-	atomic_set(&sess->refcnt, 1);
+	rwlock_init(&sess->chann_lock);
 
 	switch (protocol) {
 	case CIFDS_SESSION_FLAG_SMB2:
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 82289c3cbd2b..8934b8ee275b 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -33,8 +33,10 @@ struct preauth_session {
 struct ksmbd_session {
 	u64				id;
 
+	__u16				dialect;
+	char				ClientGUID[SMB2_CLIENT_GUID_SIZE];
+
 	struct ksmbd_user		*user;
-	struct ksmbd_conn		*conn;
 	unsigned int			sequence_number;
 	unsigned int			flags;
 
@@ -45,10 +47,10 @@ struct ksmbd_session {
 	int				state;
 	__u8				*Preauth_HashValue;
 
-	struct ntlmssp_auth		ntlmssp;
 	char				sess_key[CIFS_KEY_SIZE];
 
 	struct hlist_node		hlist;
+	rwlock_t			chann_lock;
 	struct list_head		ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
@@ -58,9 +60,7 @@ struct ksmbd_session {
 	__u8				smb3decryptionkey[SMB3_ENC_DEC_KEY_SIZE];
 	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
 
-	struct list_head		sessions_entry;
 	struct ksmbd_file_table		file_table;
-	atomic_t			refcnt;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
@@ -85,8 +85,8 @@ void ksmbd_session_destroy(struct ksmbd_session *sess);
 struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id);
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 					   unsigned long long id);
-void ksmbd_session_register(struct ksmbd_conn *conn,
-			    struct ksmbd_session *sess);
+int ksmbd_session_register(struct ksmbd_conn *conn,
+			   struct ksmbd_session *sess);
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn);
 struct ksmbd_session *ksmbd_session_lookup_all(struct ksmbd_conn *conn,
 					       unsigned long long id);
@@ -101,6 +101,4 @@ void ksmbd_release_tree_conn_id(struct ksmbd_session *sess, int id);
 int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name);
 void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id);
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id);
-int get_session(struct ksmbd_session *sess);
-void put_session(struct ksmbd_session *sess);
 #endif /* __USER_SESSION_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index f9dae6ef2115..3f759f9123ea 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -30,6 +30,7 @@ static DEFINE_RWLOCK(lease_list_lock);
 static struct oplock_info *alloc_opinfo(struct ksmbd_work *work,
 					u64 id, __u16 Tid)
 {
+	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	struct oplock_info *opinfo;
 
@@ -38,7 +39,7 @@ static struct oplock_info *alloc_opinfo(struct ksmbd_work *work,
 		return NULL;
 
 	opinfo->sess = sess;
-	opinfo->conn = sess->conn;
+	opinfo->conn = conn;
 	opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
 	opinfo->op_state = OPLOCK_STATE_NONE;
 	opinfo->pending_break = 0;
@@ -972,7 +973,7 @@ int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 	}
 
 	list_for_each_entry(lb, &lease_table_list, l_entry) {
-		if (!memcmp(lb->client_guid, sess->conn->ClientGUID,
+		if (!memcmp(lb->client_guid, sess->ClientGUID,
 			    SMB2_CLIENT_GUID_SIZE))
 			goto found;
 	}
@@ -988,7 +989,7 @@ int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 		rcu_read_unlock();
 		if (opinfo->o_fp->f_ci == ci)
 			goto op_next;
-		err = compare_guid_key(opinfo, sess->conn->ClientGUID,
+		err = compare_guid_key(opinfo, sess->ClientGUID,
 				       lctx->lease_key);
 		if (err) {
 			err = -EINVAL;
@@ -1122,7 +1123,7 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 		struct oplock_info *m_opinfo;
 
 		/* is lease already granted ? */
-		m_opinfo = same_client_has_lease(ci, sess->conn->ClientGUID,
+		m_opinfo = same_client_has_lease(ci, sess->ClientGUID,
 						 lctx);
 		if (m_opinfo) {
 			copy_lease(m_opinfo, opinfo);
@@ -1240,7 +1241,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 {
 	struct oplock_info *op, *brk_op;
 	struct ksmbd_inode *ci;
-	struct ksmbd_conn *conn = work->sess->conn;
+	struct ksmbd_conn *conn = work->conn;
 
 	if (!test_share_config_flag(work->tcon->share_conf,
 				    KSMBD_SHARE_FLAG_OPLOCKS))
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 22d9fcb5f7ca..51d495688f45 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -595,10 +595,12 @@ int smb2_check_user_session(struct ksmbd_work *work)
 	return -EINVAL;
 }
 
-static void destroy_previous_session(struct ksmbd_user *user, u64 id)
+static void destroy_previous_session(struct ksmbd_conn *conn,
+				     struct ksmbd_user *user, u64 id)
 {
 	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
 	struct ksmbd_user *prev_user;
+	struct channel *chann;
 
 	if (!prev_sess)
 		return;
@@ -608,13 +610,14 @@ static void destroy_previous_session(struct ksmbd_user *user, u64 id)
 	if (!prev_user ||
 	    strcmp(user->name, prev_user->name) ||
 	    user->passkey_sz != prev_user->passkey_sz ||
-	    memcmp(user->passkey, prev_user->passkey, user->passkey_sz)) {
-		put_session(prev_sess);
+	    memcmp(user->passkey, prev_user->passkey, user->passkey_sz))
 		return;
-	}
 
-	put_session(prev_sess);
-	ksmbd_session_destroy(prev_sess);
+	prev_sess->state = SMB2_SESSION_EXPIRED;
+	write_lock(&prev_sess->chann_lock);
+	list_for_each_entry(chann, &prev_sess->ksmbd_chann_list, chann_list)
+		chann->conn->status = KSMBD_SESS_EXITING;
+	write_unlock(&prev_sess->chann_lock);
 }
 
 /**
@@ -1316,7 +1319,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 	int sz, rc;
 
 	ksmbd_debug(SMB, "negotiate phase\n");
-	rc = ksmbd_decode_ntlmssp_neg_blob(negblob, negblob_len, work->sess);
+	rc = ksmbd_decode_ntlmssp_neg_blob(negblob, negblob_len, work->conn);
 	if (rc)
 		return rc;
 
@@ -1326,7 +1329,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 	memset(chgblob, 0, sizeof(struct challenge_message));
 
 	if (!work->conn->use_spnego) {
-		sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->sess);
+		sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->conn);
 		if (sz < 0)
 			return -ENOMEM;
 
@@ -1342,7 +1345,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 		return -ENOMEM;
 
 	chgblob = (struct challenge_message *)neg_blob;
-	sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->sess);
+	sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->conn);
 	if (sz < 0) {
 		rc = -ENOMEM;
 		goto out;
@@ -1452,29 +1455,35 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 	/* Check for previous session */
 	prev_id = le64_to_cpu(req->PreviousSessionId);
 	if (prev_id && prev_id != sess->id)
-		destroy_previous_session(user, prev_id);
+		destroy_previous_session(conn, user, prev_id);
 
 	if (sess->state == SMB2_SESSION_VALID) {
 		/*
 		 * Reuse session if anonymous try to connect
 		 * on reauthetication.
 		 */
-		if (ksmbd_anonymous_user(user)) {
+		if (conn->binding == false && ksmbd_anonymous_user(user)) {
 			ksmbd_free_user(user);
 			return 0;
 		}
-		ksmbd_free_user(sess->user);
+
+		if (!ksmbd_compare_user(sess->user, user)) {
+			ksmbd_free_user(user);
+			return -EPERM;
+		}
+		ksmbd_free_user(user);
+	} else {
+		sess->user = user;
 	}
 
-	sess->user = user;
-	if (user_guest(sess->user)) {
+	if (conn->binding == false && user_guest(sess->user)) {
 		rsp->SessionFlags = SMB2_SESSION_FLAG_IS_GUEST_LE;
 	} else {
 		struct authenticate_message *authblob;
 
 		authblob = user_authblob(conn, req);
 		sz = le16_to_cpu(req->SecurityBufferLength);
-		rc = ksmbd_decode_ntlmssp_auth_blob(authblob, sz, sess);
+		rc = ksmbd_decode_ntlmssp_auth_blob(authblob, sz, conn, sess);
 		if (rc) {
 			set_user_flag(sess->user, KSMBD_USER_FLAG_BAD_PASSWORD);
 			ksmbd_debug(SMB, "authentication failed\n");
@@ -1500,7 +1509,7 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 	if (smb3_encryption_negotiated(conn) &&
 			!(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
-		rc = conn->ops->generate_encryptionkey(sess);
+		rc = conn->ops->generate_encryptionkey(conn, sess);
 		if (rc) {
 			ksmbd_debug(SMB,
 					"SMB3 encryption key generation failed\n");
@@ -1517,7 +1526,9 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 binding_session:
 	if (conn->dialect >= SMB30_PROT_ID) {
+		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
+		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
@@ -1525,7 +1536,9 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 			chann->conn = conn;
 			INIT_LIST_HEAD(&chann->chann_list);
+			write_lock(&sess->chann_lock);
 			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
+			write_unlock(&sess->chann_lock);
 		}
 	}
 
@@ -1569,7 +1582,7 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	/* Check previous session */
 	prev_sess_id = le64_to_cpu(req->PreviousSessionId);
 	if (prev_sess_id && prev_sess_id != sess->id)
-		destroy_previous_session(sess->user, prev_sess_id);
+		destroy_previous_session(conn, sess->user, prev_sess_id);
 
 	if (sess->state == SMB2_SESSION_VALID)
 		ksmbd_free_user(sess->user);
@@ -1588,7 +1601,7 @@ static int krb5_authenticate(struct ksmbd_work *work)
 		sess->sign = true;
 
 	if (smb3_encryption_negotiated(conn)) {
-		retval = conn->ops->generate_encryptionkey(sess);
+		retval = conn->ops->generate_encryptionkey(conn, sess);
 		if (retval) {
 			ksmbd_debug(SMB,
 				    "SMB3 encryption key generation failed\n");
@@ -1600,7 +1613,9 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	}
 
 	if (conn->dialect >= SMB30_PROT_ID) {
+		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
+		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
@@ -1608,7 +1623,9 @@ static int krb5_authenticate(struct ksmbd_work *work)
 
 			chann->conn = conn;
 			INIT_LIST_HEAD(&chann->chann_list);
+			write_lock(&sess->chann_lock);
 			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
+			write_unlock(&sess->chann_lock);
 		}
 	}
 
@@ -1658,7 +1675,9 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 		rsp->hdr.SessionId = cpu_to_le64(sess->id);
-		ksmbd_session_register(conn, sess);
+		rc = ksmbd_session_register(conn, sess);
+		if (rc)
+			goto out_err;
 	} else if (conn->dialect >= SMB30_PROT_ID &&
 		   (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
 		   req->Flags & SMB2_SESSION_REQ_FLAG_BINDING) {
@@ -1670,7 +1689,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
-		if (conn->dialect != sess->conn->dialect) {
+		if (conn->dialect != sess->dialect) {
 			rc = -EINVAL;
 			goto out_err;
 		}
@@ -1680,7 +1699,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
-		if (strncmp(conn->ClientGUID, sess->conn->ClientGUID,
+		if (strncmp(conn->ClientGUID, sess->ClientGUID,
 			    SMB2_CLIENT_GUID_SIZE)) {
 			rc = -ENOENT;
 			goto out_err;
@@ -1701,6 +1720,11 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
+		if (user_guest(sess->user)) {
+			rc = -EOPNOTSUPP;
+			goto out_err;
+		}
+
 		conn->binding = true;
 	} else if ((conn->dialect < SMB30_PROT_ID ||
 		    server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
@@ -1812,6 +1836,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		rsp->hdr.Status = STATUS_NETWORK_SESSION_EXPIRED;
 	else if (rc == -ENOMEM)
 		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+	else if (rc == -EOPNOTSUPP)
+		rsp->hdr.Status = STATUS_NOT_SUPPORTED;
 	else if (rc)
 		rsp->hdr.Status = STATUS_LOGON_FAILURE;
 
@@ -1839,6 +1865,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			if (sess->user && sess->user->flags & KSMBD_USER_FLAG_DELAY_SESSION)
 				try_delay = true;
 
+			xa_erase(&conn->sessions, sess->id);
 			ksmbd_session_destroy(sess);
 			work->sess = NULL;
 			if (try_delay)
@@ -1884,7 +1911,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "tree connect request for tree %s treename %s\n",
 		    name, treename);
 
-	status = ksmbd_tree_conn_connect(sess, name);
+	status = ksmbd_tree_conn_connect(conn, sess, name);
 	if (status.ret == KSMBD_TREE_CONN_STATUS_OK)
 		rsp->hdr.Id.SyncId.TreeId = cpu_to_le32(status.tree_conn->id);
 	else
@@ -2071,9 +2098,6 @@ int smb2_session_logoff(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "request\n");
 
-	/* Got a valid session, set connection state */
-	WARN_ON(sess->conn != conn);
-
 	/* setting CifsExiting here may race with start_tcp_sess */
 	ksmbd_conn_set_need_reconnect(work);
 	ksmbd_close_session_fds(work);
@@ -4875,7 +4899,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 				    struct smb2_query_info_rsp *rsp, void *rsp_org)
 {
 	struct ksmbd_session *sess = work->sess;
-	struct ksmbd_conn *conn = sess->conn;
+	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_share_config *share = work->tcon->share_conf;
 	int fsinfoclass = 0;
 	struct kstatfs stfs;
@@ -5811,7 +5835,7 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 next:
 	return smb2_rename(work, fp, user_ns, rename_info,
-			   work->sess->conn->local_nls);
+			   work->conn->local_nls);
 }
 
 static int set_file_disposition_info(struct ksmbd_file *fp,
@@ -5945,7 +5969,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		return smb2_create_link(work, work->tcon->share_conf,
 					(struct smb2_file_link_info *)req->Buffer,
 					buf_len, fp->filp,
-					work->sess->conn->local_nls);
+					work->conn->local_nls);
 	}
 	case FILE_DISPOSITION_INFORMATION:
 	{
@@ -7302,6 +7326,8 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		nii_rsp->IfIndex = cpu_to_le32(netdev->ifindex);
 
 		nii_rsp->Capability = 0;
+		if (netdev->real_num_tx_queues > 1)
+			nii_rsp->Capability |= cpu_to_le32(RSS_CAPABLE);
 		if (ksmbd_rdma_capable_netdev(netdev))
 			nii_rsp->Capability |= cpu_to_le32(RDMA_CAPABLE);
 
@@ -8378,10 +8404,14 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
+		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, conn);
-		if (!chann)
+		if (!chann) {
+			read_unlock(&work->sess->chann_lock);
 			return 0;
+		}
 		signing_key = chann->smb3signingkey;
+		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key) {
@@ -8441,10 +8471,14 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
+		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, work->conn);
-		if (!chann)
+		if (!chann) {
+			read_unlock(&work->sess->chann_lock);
 			return;
+		}
 		signing_key = chann->smb3signingkey;
+		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key)
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index b9fe3fa149c2..48cbaa032140 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -454,7 +454,7 @@ struct smb_version_ops {
 	int (*check_sign_req)(struct ksmbd_work *work);
 	void (*set_sign_rsp)(struct ksmbd_work *work);
 	int (*generate_signingkey)(struct ksmbd_session *sess, struct ksmbd_conn *conn);
-	int (*generate_encryptionkey)(struct ksmbd_session *sess);
+	int (*generate_encryptionkey)(struct ksmbd_conn *conn, struct ksmbd_session *sess);
 	bool (*is_transform_hdr)(void *buf);
 	int (*decrypt_req)(struct ksmbd_work *work);
 	int (*encrypt_resp)(struct ksmbd_work *work);
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 5d40a00fbce5..52cc6a9627ed 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -483,12 +483,11 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written)
 {
-	struct ksmbd_session *sess = work->sess;
 	struct file *filp;
 	loff_t	offset = *pos;
 	int err = 0;
 
-	if (sess->conn->connection_type) {
+	if (work->conn->connection_type) {
 		if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
 			pr_err("no right to write(%pd)\n",
 			       fp->filp->f_path.dentry);
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 8b873d92d785..0df8467af39a 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -570,7 +570,7 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	atomic_set(&fp->refcount, 1);
 
 	fp->filp		= filp;
-	fp->conn		= work->sess->conn;
+	fp->conn		= work->conn;
 	fp->tcon		= work->tcon;
 	fp->volatile_id		= KSMBD_NO_FID;
 	fp->persistent_id	= KSMBD_NO_FID;
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index d1a64daa0171..b0530f75b274 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -65,7 +65,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	struct fsnotify_event *fsn_event;
 	struct fsnotify_group *group = inode_mark->group;
 	int ret;
-	int len = 0;
+	int len = 0, wd;
 	int alloc_len = sizeof(struct inotify_event_info);
 	struct mem_cgroup *old_memcg;
 
@@ -80,6 +80,13 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	i_mark = container_of(inode_mark, struct inotify_inode_mark,
 			      fsn_mark);
 
+	/*
+	 * We can be racing with mark being detached. Don't report event with
+	 * invalid wd.
+	 */
+	wd = READ_ONCE(i_mark->wd);
+	if (wd == -1)
+		return 0;
 	/*
 	 * Whoever is interested in the event, pays for the allocation. Do not
 	 * trigger OOM killer in the target monitoring memcg as it may have
@@ -110,7 +117,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	fsn_event = &event->fse;
 	fsnotify_init_event(fsn_event);
 	event->mask = mask;
-	event->wd = i_mark->wd;
+	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 2a63793f522d..3261b69cdac3 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -666,7 +666,8 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 	if (!wnd->bits_last)
 		wnd->bits_last = wbits;
 
-	wnd->free_bits = kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
+	wnd->free_bits =
+		kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
 	if (!wnd->free_bits)
 		return -ENOMEM;
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index bc741213ad84..bff1934e044e 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -86,6 +86,16 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		__putname(uni);
 	}
 
+	/*
+	 * Check for a null pointer
+	 * If the MFT record of ntfs inode is not a base record, inode->i_op can be NULL.
+	 * This causes null pointer dereference in d_splice_alias().
+	 */
+	if (!IS_ERR_OR_NULL(inode) && !inode->i_op) {
+		iput(inode);
+		inode = ERR_PTR(-EINVAL);
+	}
+
 	return d_splice_alias(inode, dentry);
 }
 
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 9cc396b117bf..0f38d558169a 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -436,9 +436,6 @@ static inline u64 attr_svcn(const struct ATTRIB *attr)
 	return attr->non_res ? le64_to_cpu(attr->nres.svcn) : 0;
 }
 
-/* The size of resident attribute by its resident size. */
-#define BYTES_PER_RESIDENT(b) (0x18 + (b))
-
 static_assert(sizeof(struct ATTRIB) == 0x48);
 static_assert(sizeof(((struct ATTRIB *)NULL)->res) == 0x08);
 static_assert(sizeof(((struct ATTRIB *)NULL)->nres) == 0x38);
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 7717d23906db..6a054df8b991 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -68,13 +68,14 @@ static int inherit_flags(const struct inode *dir, umode_t mode)
  * @c: UBIFS file-system description object
  * @dir: parent directory inode
  * @mode: inode mode flags
+ * @is_xattr: whether the inode is xattr inode
  *
  * This function finds an unused inode number, allocates new inode and
  * initializes it. Returns new inode in case of success and an error code in
  * case of failure.
  */
 struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
-			      umode_t mode)
+			      umode_t mode, bool is_xattr)
 {
 	int err;
 	struct inode *inode;
@@ -99,10 +100,12 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 			 current_time(inode);
 	inode->i_mapping->nrpages = 0;
 
-	err = fscrypt_prepare_new_inode(dir, inode, &encrypted);
-	if (err) {
-		ubifs_err(c, "fscrypt_prepare_new_inode failed: %i", err);
-		goto out_iput;
+	if (!is_xattr) {
+		err = fscrypt_prepare_new_inode(dir, inode, &encrypted);
+		if (err) {
+			ubifs_err(c, "fscrypt_prepare_new_inode failed: %i", err);
+			goto out_iput;
+		}
 	}
 
 	switch (mode & S_IFMT) {
@@ -309,7 +312,7 @@ static int ubifs_create(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_fname;
@@ -355,7 +358,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	umode_t mode = S_IFCHR | WHITEOUT_MODE;
 	struct inode *inode;
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
-	struct fscrypt_name nm;
 
 	/*
 	 * Create an inode('nlink = 1') for whiteout without updating journal,
@@ -366,11 +368,7 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
 		dentry, mode, dir->i_ino);
 
-	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
-	if (err)
-		return ERR_PTR(err);
-
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_free;
@@ -392,7 +390,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	make_bad_inode(inode);
 	iput(inode);
 out_free:
-	fscrypt_free_filename(&nm);
 	ubifs_err(c, "cannot create whiteout file, error %d", err);
 	return ERR_PTR(err);
 }
@@ -462,7 +459,7 @@ static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		return err;
 	}
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_budg;
@@ -1005,7 +1002,7 @@ static int ubifs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, S_IFDIR | mode);
+	inode = ubifs_new_inode(c, dir, S_IFDIR | mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_fname;
@@ -1092,7 +1089,7 @@ static int ubifs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		kfree(dev);
 		err = PTR_ERR(inode);
@@ -1174,7 +1171,7 @@ static int ubifs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, S_IFLNK | S_IRWXUGO);
+	inode = ubifs_new_inode(c, dir, S_IFLNK | S_IRWXUGO, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_fname;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index efbb4554a4a6..398551bef598 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2002,7 +2002,7 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time, int flags);
 
 /* dir.c */
 struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
-			      umode_t mode);
+			      umode_t mode, bool is_xattr);
 int ubifs_getattr(struct user_namespace *mnt_userns, const struct path *path, struct kstat *stat,
 		  u32 request_mask, unsigned int flags);
 int ubifs_check_dir_empty(struct inode *dir);
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index e4f193eae4b2..9ff2614bdeca 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -110,7 +110,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
 	if (err)
 		return err;
 
-	inode = ubifs_new_inode(c, host, S_IFREG | S_IRWXUGO);
+	inode = ubifs_new_inode(c, host, S_IFREG | S_IRWXUGO, true);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_budg;
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 5f6841c73e5a..0ffd61930e18 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -256,4 +256,11 @@ enum {
 	CRYPTO_MSG_ALG_LOADED,
 };
 
+static inline void crypto_request_complete(struct crypto_async_request *req,
+					   int err)
+{
+	crypto_completion_t complete = req->complete;
+	complete(req, err);
+}
+
 #endif	/* _CRYPTO_ALGAPI_H */
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 855869e1fd32..987eeb94bb70 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -167,6 +167,7 @@ struct crypto_async_request;
 struct crypto_tfm;
 struct crypto_type;
 
+typedef struct crypto_async_request crypto_completion_data_t;
 typedef void (*crypto_completion_t)(struct crypto_async_request *req, int err);
 
 /**
@@ -586,6 +587,11 @@ struct crypto_wait {
 /*
  * Async ops completion helper functioons
  */
+static inline void *crypto_get_completion_data(crypto_completion_data_t *req)
+{
+	return req->data;
+}
+
 void crypto_req_done(struct crypto_async_request *req, int err);
 
 static inline int crypto_wait_req(int err, struct crypto_wait *wait)
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 181df0452ae2..cb9be3632205 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -616,6 +616,7 @@ void snd_pcm_stream_unlock(struct snd_pcm_substream *substream);
 void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream);
 void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream);
 unsigned long _snd_pcm_stream_lock_irqsave(struct snd_pcm_substream *substream);
+unsigned long _snd_pcm_stream_lock_irqsave_nested(struct snd_pcm_substream *substream);
 
 /**
  * snd_pcm_stream_lock_irqsave - Lock the PCM stream
@@ -634,6 +635,20 @@ unsigned long _snd_pcm_stream_lock_irqsave(struct snd_pcm_substream *substream);
 void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
 				      unsigned long flags);
 
+/**
+ * snd_pcm_stream_lock_irqsave_nested - Single-nested PCM stream locking
+ * @substream: PCM substream
+ * @flags: irq flags
+ *
+ * This locks the PCM stream like snd_pcm_stream_lock_irqsave() but with
+ * the single-depth lockdep subclass.
+ */
+#define snd_pcm_stream_lock_irqsave_nested(substream, flags)		\
+	do {								\
+		typecheck(unsigned long, flags);			\
+		flags = _snd_pcm_stream_lock_irqsave_nested(substream); \
+	} while (0)
+
 /**
  * snd_pcm_group_for_each_entry - iterate over the linked substreams
  * @s: the iterator
diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index e296a3949b18..d963f3b60848 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -101,6 +101,8 @@ struct snd_soc_dpcm_runtime {
 	enum snd_soc_dpcm_state state;
 
 	int trigger_pending; /* trigger cmd + 1 if pending, 0 if not */
+
+	int be_start; /* refcount protected by BE stream pcm lock */
 };
 
 #define for_each_dpcm_fe(be, stream, _dpcm)				\
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8e6dd8a257c5..5872a8864f3b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -893,8 +893,6 @@ struct snd_soc_card {
 	struct mutex pcm_mutex;
 	enum snd_soc_pcm_subclass pcm_subclass;
 
-	spinlock_t dpcm_lock;
-
 	int (*probe)(struct snd_soc_card *card);
 	int (*late_probe)(struct snd_soc_card *card);
 	int (*remove)(struct snd_soc_card *card);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index de375feada51..f0287a16b4ec 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1221,7 +1221,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-static inline int __down_read_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
 	int ret = 0;
 	long count;
@@ -1239,17 +1239,17 @@ static inline int __down_read_common(struct rw_semaphore *sem, int state)
 	return ret;
 }
 
-static inline void __down_read(struct rw_semaphore *sem)
+static __always_inline void __down_read(struct rw_semaphore *sem)
 {
 	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_read_interruptible(struct rw_semaphore *sem)
+static __always_inline int __down_read_interruptible(struct rw_semaphore *sem)
 {
 	return __down_read_common(sem, TASK_INTERRUPTIBLE);
 }
 
-static inline int __down_read_killable(struct rw_semaphore *sem)
+static __always_inline int __down_read_killable(struct rw_semaphore *sem)
 {
 	return __down_read_common(sem, TASK_KILLABLE);
 }
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bacd1f87f941..83046c6443f1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5295,6 +5295,9 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 
+/* Flag to ensure proper resetting of atomic variables */
+#define RESET_BIT	(1 << 30)
+
 /**
  * ring_buffer_reset_cpu - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
@@ -5311,20 +5314,27 @@ void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 	for_each_online_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
-		atomic_inc(&cpu_buffer->resize_disabled);
+		atomic_add(RESET_BIT, &cpu_buffer->resize_disabled);
 		atomic_inc(&cpu_buffer->record_disabled);
 	}
 
 	/* Make sure all commits have finished */
 	synchronize_rcu();
 
-	for_each_online_buffer_cpu(buffer, cpu) {
+	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
+		/*
+		 * If a CPU came online during the synchronize_rcu(), then
+		 * ignore it.
+		 */
+		if (!(atomic_read(&cpu_buffer->resize_disabled) & RESET_BIT))
+			continue;
+
 		reset_disabled_cpu_buffer(cpu_buffer);
 
 		atomic_dec(&cpu_buffer->record_disabled);
-		atomic_dec(&cpu_buffer->resize_disabled);
+		atomic_sub(RESET_BIT, &cpu_buffer->resize_disabled);
 	}
 
 	mutex_unlock(&buffer->mutex);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 939c63d6e74b..53e2ef6ada8f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -568,8 +568,8 @@ static int ethtool_get_link_ksettings(struct net_device *dev,
 static int ethtool_set_link_ksettings(struct net_device *dev,
 				      void __user *useraddr)
 {
+	struct ethtool_link_ksettings link_ksettings = {};
 	int err;
-	struct ethtool_link_ksettings link_ksettings;
 
 	ASSERT_RTNL();
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index d4cdc2b1b468..3bc02ab9ceac 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1101,12 +1101,13 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 
 static void ipip6_tunnel_bind_dev(struct net_device *dev)
 {
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 	struct net_device *tdev = NULL;
-	struct ip_tunnel *tunnel;
+	int hlen = LL_MAX_HEADER;
 	const struct iphdr *iph;
 	struct flowi4 fl4;
 
-	tunnel = netdev_priv(dev);
 	iph = &tunnel->parms.iph;
 
 	if (iph->daddr) {
@@ -1129,14 +1130,15 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 		tdev = __dev_get_by_index(tunnel->net, tunnel->parms.link);
 
 	if (tdev && !netif_is_l3_master(tdev)) {
-		int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 		int mtu;
 
 		mtu = tdev->mtu - t_hlen;
 		if (mtu < IPV6_MIN_MTU)
 			mtu = IPV6_MIN_MTU;
 		WRITE_ONCE(dev->mtu, mtu);
+		hlen = tdev->hard_header_len + tdev->needed_headroom;
 	}
+	dev->needed_headroom = t_hlen + hlen;
 }
 
 static void ipip6_tunnel_update(struct ip_tunnel *t, struct ip_tunnel_parm *p,
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index b635c194f0a8..62fb1031763d 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -165,6 +165,7 @@ static int ncsi_aen_handler_cr(struct ncsi_dev_priv *ndp,
 	nc->state = NCSI_CHANNEL_INACTIVE;
 	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
 	spin_unlock_irqrestore(&ndp->lock, flags);
+	nc->modes[NCSI_MODE_TX_ENABLE].enable = 0;
 
 	return ncsi_process_next_channel(ndp);
 }
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 0db871edd3a1..f5d430bd372c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1999,7 +1999,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		goto retry;
 	}
 
-	if (!dev_validate_header(dev, skb->data, len)) {
+	if (!dev_validate_header(dev, skb->data, len) || !skb->len) {
 		err = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index d4e4e94f4f98..71e40f91dd39 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -736,7 +736,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		fallthrough;
 	case 1:
 		if (p.call.timeouts.hard > 0) {
-			j = msecs_to_jiffies(p.call.timeouts.hard);
+			j = p.call.timeouts.hard * HZ;
 			now = jiffies;
 			j += now;
 			WRITE_ONCE(call->expect_term_by, j);
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 6f39789d9d14..97cd4b2377d6 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -261,7 +261,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 		goto out;
 	}
 
-	if (unlikely(!(dev->flags & IFF_UP))) {
+	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
 		goto out;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 62ce6981942b..501e05943f02 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1465,6 +1465,7 @@ static int tcf_block_bind(struct tcf_block *block,
 
 err_unroll:
 	list_for_each_entry_safe(block_cb, next, &bo->cb_list, list) {
+		list_del(&block_cb->driver_list);
 		if (i-- > 0) {
 			list_del(&block_cb->list);
 			tcf_block_playback_offloads(block, block_cb->cb,
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 44e06ef4ff0b..3b87f6cb5bb0 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -172,6 +172,19 @@ unsigned long _snd_pcm_stream_lock_irqsave(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave);
 
+unsigned long _snd_pcm_stream_lock_irqsave_nested(struct snd_pcm_substream *substream)
+{
+	unsigned long flags = 0;
+	if (substream->pcm->nonatomic)
+		mutex_lock_nested(&substream->self_group.mutex,
+				  SINGLE_DEPTH_NESTING);
+	else
+		spin_lock_irqsave_nested(&substream->self_group.lock, flags,
+					 SINGLE_DEPTH_NESTING);
+	return flags;
+}
+EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave_nested);
+
 /**
  * snd_pcm_stream_unlock_irqrestore - Unlock the PCM stream
  * @substream: PCM substream
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index c2703a7598dd..256e45001f85 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -589,6 +589,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 			return ret;
 		}
 
+		/* inherit atomicity from DAI link */
+		be_pcm->nonatomic = rtd->dai_link->nonatomic;
+
 		rtd->pcm = be_pcm;
 		rtd->fe_compr = 1;
 		if (rtd->dai_link->dpcm_playback)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1b1749b920f4..a5b3ee69fb88 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2339,7 +2339,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
 	mutex_init(&card->pcm_mutex);
-	spin_lock_init(&card->dpcm_lock);
 
 	return snd_soc_bind_card(card);
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 6f616ac4490f..76c807372ef5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -27,6 +27,37 @@
 #include <sound/soc-link.h>
 #include <sound/initval.h>
 
+static inline void snd_soc_dpcm_mutex_lock(struct snd_soc_pcm_runtime *rtd)
+{
+	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+}
+
+static inline void snd_soc_dpcm_mutex_unlock(struct snd_soc_pcm_runtime *rtd)
+{
+	mutex_unlock(&rtd->card->pcm_mutex);
+}
+
+#define snd_soc_dpcm_mutex_assert_held(rtd) \
+	lockdep_assert_held(&(rtd)->card->pcm_mutex)
+
+static inline void snd_soc_dpcm_stream_lock_irq(struct snd_soc_pcm_runtime *rtd,
+						int stream)
+{
+	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(rtd, stream));
+}
+
+#define snd_soc_dpcm_stream_lock_irqsave_nested(rtd, stream, flags) \
+	snd_pcm_stream_lock_irqsave_nested(snd_soc_dpcm_get_substream(rtd, stream), flags)
+
+static inline void snd_soc_dpcm_stream_unlock_irq(struct snd_soc_pcm_runtime *rtd,
+						  int stream)
+{
+	snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(rtd, stream));
+}
+
+#define snd_soc_dpcm_stream_unlock_irqrestore(rtd, stream, flags) \
+	snd_pcm_stream_unlock_irqrestore(snd_soc_dpcm_get_substream(rtd, stream), flags)
+
 #define DPCM_MAX_BE_USERS	8
 
 static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *rtd)
@@ -73,7 +104,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_pcm_hw_params *params = &fe->dpcm[stream].hw_params;
 	struct snd_soc_dpcm *dpcm;
 	ssize_t offset = 0;
-	unsigned long flags;
 
 	/* FE state */
 	offset += scnprintf(buf + offset, size - offset,
@@ -101,7 +131,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 		goto out;
 	}
 
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		params = &dpcm->hw_params;
@@ -122,7 +151,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 					   params_channels(params),
 					   params_rate(params));
 	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 out:
 	return offset;
 }
@@ -145,11 +173,13 @@ static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
+	snd_soc_dpcm_mutex_lock(fe);
 	for_each_pcm_streams(stream)
 		if (snd_soc_dai_stream_valid(asoc_rtd_to_cpu(fe, 0), stream))
 			offset += dpcm_show_state(fe, stream,
 						  buf + offset,
 						  out_count - offset);
+	snd_soc_dpcm_mutex_unlock(fe);
 
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
 
@@ -221,14 +251,14 @@ static void dpcm_set_fe_update_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_pcm_substream *substream =
 		snd_soc_dpcm_get_substream(fe, stream);
 
-	snd_pcm_stream_lock_irq(substream);
+	snd_soc_dpcm_stream_lock_irq(fe, stream);
 	if (state == SND_SOC_DPCM_UPDATE_NO && fe->dpcm[stream].trigger_pending) {
 		dpcm_fe_dai_do_trigger(substream,
 				       fe->dpcm[stream].trigger_pending - 1);
 		fe->dpcm[stream].trigger_pending = 0;
 	}
 	fe->dpcm[stream].runtime_update = state;
-	snd_pcm_stream_unlock_irq(substream);
+	snd_soc_dpcm_stream_unlock_irq(fe, stream);
 }
 
 static void dpcm_set_be_update_state(struct snd_soc_pcm_runtime *be,
@@ -256,7 +286,7 @@ void snd_soc_runtime_action(struct snd_soc_pcm_runtime *rtd,
 	struct snd_soc_dai *dai;
 	int i;
 
-	lockdep_assert_held(&rtd->card->pcm_mutex);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	for_each_rtd_dais(rtd, i, dai)
 		snd_soc_dai_action(dai, stream, action);
@@ -309,6 +339,8 @@ int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 {
 	struct snd_soc_dpcm *dpcm;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
 	for_each_dpcm_be(fe, dir, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
@@ -646,14 +678,14 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
+static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
+			 struct snd_pcm_substream *substream, int rollback)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 	int i;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	if (!rollback)
 		snd_soc_runtime_deactivate(rtd, substream->stream);
@@ -665,9 +697,6 @@ static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
 
 	soc_pcm_components_close(substream, rollback);
 
-
-	mutex_unlock(&rtd->card->pcm_mutex);
-
 	snd_soc_pcm_component_pm_runtime_put(rtd, substream, rollback);
 
 	for_each_rtd_components(rtd, i, component)
@@ -682,9 +711,21 @@ static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
  * freed here. The cpu DAI, codec DAI, machine and components are also
  * shutdown.
  */
+static int __soc_pcm_close(struct snd_soc_pcm_runtime *rtd,
+			   struct snd_pcm_substream *substream)
+{
+	return soc_pcm_clean(rtd, substream, 0);
+}
+
+/* PCM close ops for non-DPCM streams */
 static int soc_pcm_close(struct snd_pcm_substream *substream)
 {
-	return soc_pcm_clean(substream, 0);
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	__soc_pcm_close(rtd, substream);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return 0;
 }
 
 static int soc_hw_sanity_check(struct snd_pcm_substream *substream)
@@ -730,21 +771,21 @@ static int soc_hw_sanity_check(struct snd_pcm_substream *substream)
  * then initialized and any private data can be allocated. This also calls
  * startup for the cpu DAI, component, machine and codec DAI.
  */
-static int soc_pcm_open(struct snd_pcm_substream *substream)
+static int __soc_pcm_open(struct snd_soc_pcm_runtime *rtd,
+			  struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 	int i, ret = 0;
 
+	snd_soc_dpcm_mutex_assert_held(rtd);
+
 	for_each_rtd_components(rtd, i, component)
 		pinctrl_pm_select_default_state(component->dev);
 
 	ret = snd_soc_pcm_component_pm_runtime_get(rtd, substream);
 	if (ret < 0)
-		goto pm_err;
-
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+		goto err;
 
 	ret = soc_pcm_components_open(substream);
 	if (ret < 0)
@@ -786,16 +827,26 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	snd_soc_runtime_activate(rtd, substream->stream);
 	ret = 0;
 err:
-	mutex_unlock(&rtd->card->pcm_mutex);
-pm_err:
 	if (ret < 0) {
-		soc_pcm_clean(substream, 1);
+		soc_pcm_clean(rtd, substream, 1);
 		dev_err(rtd->dev, "%s() failed (%d)", __func__, ret);
 	}
 
 	return ret;
 }
 
+/* PCM open ops for non-DPCM streams */
+static int soc_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_open(rtd, substream);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
+}
+
 static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
 {
 	/*
@@ -811,13 +862,13 @@ static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
  * rate, etc.  This function is non atomic and can be called multiple times,
  * it can refer to the runtime info.
  */
-static int soc_pcm_prepare(struct snd_pcm_substream *substream)
+static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *dai;
 	int i, ret = 0;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	ret = snd_soc_link_prepare(substream);
 	if (ret < 0)
@@ -845,14 +896,24 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		snd_soc_dai_digital_mute(dai, 0, substream->stream);
 
 out:
-	mutex_unlock(&rtd->card->pcm_mutex);
-
 	if (ret < 0)
 		dev_err(rtd->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
 
 	return ret;
 }
 
+/* PCM prepare ops for non-DPCM streams */
+static int soc_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_prepare(rtd, substream);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
+}
+
 static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
 				       unsigned int mask)
 {
@@ -864,13 +925,13 @@ static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
 	interval->max = channels;
 }
 
-static int soc_pcm_hw_clean(struct snd_pcm_substream *substream, int rollback)
+static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_substream *substream, int rollback)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *dai;
 	int i;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	/* clear the corresponding DAIs parameters when going to be inactive */
 	for_each_rtd_dais(rtd, i, dai) {
@@ -900,16 +961,28 @@ static int soc_pcm_hw_clean(struct snd_pcm_substream *substream, int rollback)
 		snd_soc_dai_hw_free(dai, substream, rollback);
 	}
 
-	mutex_unlock(&rtd->card->pcm_mutex);
 	return 0;
 }
 
 /*
  * Frees resources allocated by hw_params, can be called multiple times
  */
+static int __soc_pcm_hw_free(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_pcm_substream *substream)
+{
+	return soc_pcm_hw_clean(rtd, substream, 0);
+}
+
+/* hw_free PCM ops for non-DPCM streams */
 static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	return soc_pcm_hw_clean(substream, 0);
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_hw_free(rtd, substream);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
 }
 
 /*
@@ -917,15 +990,15 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
  * function can also be called multiple times and can allocate buffers
  * (using snd_pcm_lib_* ). It's non-atomic.
  */
-static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
+			       struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i, ret = 0;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	ret = soc_pcm_params_symmetry(substream, params);
 	if (ret)
@@ -997,16 +1070,27 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_pcm_component_hw_params(substream, params);
 out:
-	mutex_unlock(&rtd->card->pcm_mutex);
-
 	if (ret < 0) {
-		soc_pcm_hw_clean(substream, 1);
+		soc_pcm_hw_clean(rtd, substream, 1);
 		dev_err(rtd->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
 	}
 
 	return ret;
 }
 
+/* hw_params PCM ops for non-DPCM streams */
+static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_hw_params(rtd, substream, params);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
+}
+
 static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
@@ -1123,8 +1207,11 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
+	struct snd_pcm_substream *fe_substream;
+	struct snd_pcm_substream *be_substream;
 	struct snd_soc_dpcm *dpcm;
-	unsigned long flags;
+
+	snd_soc_dpcm_mutex_assert_held(fe);
 
 	/* only add new dpcms */
 	for_each_dpcm_be(fe, stream, dpcm) {
@@ -1132,7 +1219,21 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			return 0;
 	}
 
-	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_KERNEL);
+	fe_substream = snd_soc_dpcm_get_substream(fe, stream);
+	be_substream = snd_soc_dpcm_get_substream(be, stream);
+
+	if (!fe_substream->pcm->nonatomic && be_substream->pcm->nonatomic) {
+		dev_err(be->dev, "%s: FE is atomic but BE is nonatomic, invalid configuration\n",
+			__func__);
+		return -EINVAL;
+	}
+	if (fe_substream->pcm->nonatomic && !be_substream->pcm->nonatomic) {
+		dev_warn(be->dev, "%s: FE is nonatomic but BE is not, forcing BE as nonatomic\n",
+			 __func__);
+		be_substream->pcm->nonatomic = 1;
+	}
+
+	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_ATOMIC);
 	if (!dpcm)
 		return -ENOMEM;
 
@@ -1140,10 +1241,10 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	dpcm->fe = fe;
 	be->dpcm[stream].runtime = fe->dpcm[stream].runtime;
 	dpcm->state = SND_SOC_DPCM_LINK_STATE_NEW;
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+	snd_soc_dpcm_stream_lock_irq(fe, stream);
 	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
 	list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+	snd_soc_dpcm_stream_unlock_irq(fe, stream);
 
 	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
 			stream ? "capture" : "playback",  fe->dai_link->name,
@@ -1188,8 +1289,11 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
 void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm, *d;
-	unsigned long flags;
+	LIST_HEAD(deleted_dpcms);
+
+	snd_soc_dpcm_mutex_assert_held(fe);
 
+	snd_soc_dpcm_stream_lock_irq(fe, stream);
 	for_each_dpcm_be_safe(fe, stream, dpcm, d) {
 		dev_dbg(fe->dev, "ASoC: BE %s disconnect check for %s\n",
 				stream ? "capture" : "playback",
@@ -1205,12 +1309,16 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 		/* BEs still alive need new FE */
 		dpcm_be_reparent(fe, dpcm->be, stream);
 
-		dpcm_remove_debugfs_state(dpcm);
-
-		spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 		list_del(&dpcm->list_be);
+		list_move(&dpcm->list_fe, &deleted_dpcms);
+	}
+	snd_soc_dpcm_stream_unlock_irq(fe, stream);
+
+	while (!list_empty(&deleted_dpcms)) {
+		dpcm = list_first_entry(&deleted_dpcms, struct snd_soc_dpcm,
+					list_fe);
 		list_del(&dpcm->list_fe);
-		spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+		dpcm_remove_debugfs_state(dpcm);
 		kfree(dpcm);
 	}
 }
@@ -1231,6 +1339,9 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		if (!be->dai_link->no_pcm)
 			continue;
 
+		if (!snd_soc_dpcm_get_substream(be, stream))
+			continue;
+
 		for_each_rtd_dais(be, i, dai) {
 			w = snd_soc_dai_get_widget(dai, stream);
 
@@ -1426,12 +1537,9 @@ int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
 void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm_set_be_update_state(dpcm->be, stream, SND_SOC_DPCM_UPDATE_NO);
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 }
 
 void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
@@ -1467,12 +1575,12 @@ void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
 				continue;
 
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) {
-				soc_pcm_hw_free(be_substream);
+				__soc_pcm_hw_free(be, be_substream);
 				be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
 			}
 		}
 
-		soc_pcm_close(be_substream);
+		__soc_pcm_close(be, be_substream);
 		be_substream->runtime = NULL;
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 	}
@@ -1520,7 +1628,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			stream ? "capture" : "playback", be->dai_link->name);
 
 		be_substream->runtime = be->dpcm[stream].runtime;
-		err = soc_pcm_open(be_substream);
+		err = __soc_pcm_open(be, be_substream);
 		if (err < 0) {
 			be->dpcm[stream].users--;
 			if (be->dpcm[stream].users < 0)
@@ -1531,7 +1639,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 			goto unwind;
 		}
-
+		be->dpcm[stream].be_start = 0;
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
 		count++;
 	}
@@ -1768,7 +1876,7 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 	dev_dbg(fe->dev, "ASoC: open FE %s\n", fe->dai_link->name);
 
 	/* start the DAI frontend */
-	ret = soc_pcm_open(fe_substream);
+	ret = __soc_pcm_open(fe, fe_substream);
 	if (ret < 0)
 		goto unwind;
 
@@ -1799,6 +1907,8 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int stream = substream->stream;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
 
 	/* shutdown the BEs */
@@ -1807,7 +1917,7 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 	dev_dbg(fe->dev, "ASoC: close FE %s\n", fe->dai_link->name);
 
 	/* now shutdown the frontend */
-	soc_pcm_close(substream);
+	__soc_pcm_close(fe, substream);
 
 	/* run the stream stop event */
 	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
@@ -1852,7 +1962,7 @@ void dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: hw_free BE %s\n",
 			be->dai_link->name);
 
-		soc_pcm_hw_free(be_substream);
+		__soc_pcm_hw_free(be, be_substream);
 
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
 	}
@@ -1863,13 +1973,13 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int stream = substream->stream;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
 
 	dev_dbg(fe->dev, "ASoC: hw_free FE %s\n", fe->dai_link->name);
 
 	/* call hw_free on the frontend */
-	soc_pcm_hw_free(substream);
+	soc_pcm_hw_clean(fe, substream, 0);
 
 	/* only hw_params backends that are either sinks or sources
 	 * to this frontend DAI */
@@ -1878,7 +1988,7 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
 
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 	return 0;
 }
 
@@ -1922,7 +2032,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: hw_params BE %s\n",
 			be->dai_link->name);
 
-		ret = soc_pcm_hw_params(be_substream, &dpcm->hw_params);
+		ret = __soc_pcm_hw_params(be, be_substream, &dpcm->hw_params);
 		if (ret < 0)
 			goto unwind;
 
@@ -1952,7 +2062,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		   (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
 			continue;
 
-		soc_pcm_hw_free(be_substream);
+		__soc_pcm_hw_free(be, be_substream);
 	}
 
 	return ret;
@@ -1964,7 +2074,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int ret, stream = substream->stream;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
 
 	memcpy(&fe->dpcm[stream].hw_params, params,
@@ -1978,7 +2088,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 			params_channels(params), params_format(params));
 
 	/* call hw_params on the frontend */
-	ret = soc_pcm_hw_params(substream, params);
+	ret = __soc_pcm_hw_params(fe, substream, params);
 	if (ret < 0)
 		dpcm_be_dai_hw_free(fe, stream);
 	else
@@ -1986,7 +2096,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 
 out:
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s failed (%d)\n", __func__, ret);
@@ -1999,6 +2109,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 {
 	struct snd_soc_pcm_runtime *be;
 	struct snd_soc_dpcm *dpcm;
+	unsigned long flags;
 	int ret = 0;
 
 	for_each_dpcm_be(fe, stream, dpcm) {
@@ -2007,89 +2118,128 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 		be = dpcm->be;
 		be_substream = snd_soc_dpcm_get_substream(be, stream);
 
+		snd_soc_dpcm_stream_lock_irqsave_nested(be, stream, flags);
+
 		/* is this op for this BE ? */
 		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
-			continue;
+			goto next;
 
 		dev_dbg(be->dev, "ASoC: trigger BE %s cmd %d\n",
 			be->dai_link->name, cmd);
 
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
+			if (!be->dpcm[stream].be_start &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
+
+			be->dpcm[stream].be_start++;
+			if (be->dpcm[stream].be_start != 1)
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
-				goto end;
+			if (ret) {
+				be->dpcm[stream].be_start--;
+				goto next;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_RESUME:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
-				continue;
+				goto next;
+
+			be->dpcm[stream].be_start++;
+			if (be->dpcm[stream].be_start != 1)
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
-				goto end;
+			if (ret) {
+				be->dpcm[stream].be_start--;
+				goto next;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+			if (!be->dpcm[stream].be_start &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+				goto next;
+
+			be->dpcm[stream].be_start++;
+			if (be->dpcm[stream].be_start != 1)
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
-				goto end;
+			if (ret) {
+				be->dpcm[stream].be_start--;
+				goto next;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+			if (be->dpcm[stream].state == SND_SOC_DPCM_STATE_START)
+				be->dpcm[stream].be_start--;
+
+			if (be->dpcm[stream].be_start != 0)
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
-				goto end;
+			if (ret) {
+				if (be->dpcm[stream].state == SND_SOC_DPCM_STATE_START)
+					be->dpcm[stream].be_start++;
+				goto next;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 			break;
 		case SNDRV_PCM_TRIGGER_SUSPEND:
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
-				continue;
+				goto next;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+			be->dpcm[stream].be_start--;
+			if (be->dpcm[stream].be_start != 0)
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
-				goto end;
+			if (ret) {
+				be->dpcm[stream].be_start++;
+				goto next;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
-				continue;
+				goto next;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+			be->dpcm[stream].be_start--;
+			if (be->dpcm[stream].be_start != 0)
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
-				goto end;
+			if (ret) {
+				be->dpcm[stream].be_start++;
+				goto next;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
 			break;
 		}
+next:
+		snd_soc_dpcm_stream_unlock_irqrestore(be, stream, flags);
+		if (ret)
+			break;
 	}
-end:
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s() failed at %s (%d)\n",
 			__func__, be->dai_link->name, ret);
@@ -2257,7 +2407,7 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
 			be->dai_link->name);
 
-		ret = soc_pcm_prepare(be_substream);
+		ret = __soc_pcm_prepare(be, be_substream);
 		if (ret < 0)
 			break;
 
@@ -2275,7 +2425,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int stream = substream->stream, ret = 0;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 
 	dev_dbg(fe->dev, "ASoC: prepare FE %s\n", fe->dai_link->name);
 
@@ -2294,7 +2444,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 		goto out;
 
 	/* call prepare on the frontend */
-	ret = soc_pcm_prepare(substream);
+	ret = __soc_pcm_prepare(fe, substream);
 	if (ret < 0)
 		goto out;
 
@@ -2302,7 +2452,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 
 out:
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
@@ -2353,7 +2503,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	struct snd_soc_dpcm *dpcm;
 	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
 	int ret = 0;
-	unsigned long flags;
 
 	dev_dbg(fe->dev, "ASoC: runtime %s open on FE %s\n",
 			stream ? "capture" : "playback", fe->dai_link->name);
@@ -2422,7 +2571,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	dpcm_be_dai_shutdown(fe, stream);
 disconnect:
 	/* disconnect any pending BEs */
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 
@@ -2434,7 +2582,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			be->dpcm[stream].state == SND_SOC_DPCM_STATE_NEW)
 				dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
@@ -2509,7 +2656,7 @@ int snd_soc_dpcm_runtime_update(struct snd_soc_card *card)
 	struct snd_soc_pcm_runtime *fe;
 	int ret = 0;
 
-	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	mutex_lock_nested(&card->pcm_mutex, card->pcm_subclass);
 	/* shutdown all old paths first */
 	for_each_card_rtds(card, fe) {
 		ret = soc_dpcm_fe_runtime_update(fe, 0);
@@ -2525,7 +2672,7 @@ int snd_soc_dpcm_runtime_update(struct snd_soc_card *card)
 	}
 
 out:
-	mutex_unlock(&card->mutex);
+	mutex_unlock(&card->pcm_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_runtime_update);
@@ -2536,6 +2683,8 @@ static void dpcm_fe_dai_cleanup(struct snd_pcm_substream *fe_substream)
 	struct snd_soc_dpcm *dpcm;
 	int stream = fe_substream->stream;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
 	/* mark FE's links ready to prune */
 	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
@@ -2550,12 +2699,12 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(fe_substream);
 	int ret;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	ret = dpcm_fe_dai_shutdown(fe_substream);
 
 	dpcm_fe_dai_cleanup(fe_substream);
 
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 	return ret;
 }
 
@@ -2566,7 +2715,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	int ret;
 	int stream = fe_substream->stream;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	fe->dpcm[stream].runtime = fe_substream->runtime;
 
 	ret = dpcm_path_get(fe, stream, &list);
@@ -2583,7 +2732,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	dpcm_clear_pending_state(fe, stream);
 	dpcm_path_put(&list);
 open_end:
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 	return ret;
 }
 
@@ -2844,10 +2993,8 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dpcm *dpcm;
 	int state;
 	int ret = 1;
-	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
@@ -2861,7 +3008,6 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
 			}
 		}
 	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	/* it's safe to do this BE DAI */
 	return ret;
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 1e2cf2f08eec..84f26dce7f5d 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -804,6 +804,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 
 	default:
 		/* no input methods supported on this device */
+		ret = -EINVAL;
 		goto exit_free_idev;
 	}
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0b709e3ead2a..efae2998a472 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -405,36 +405,33 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 
 static int read_affinity_counters(struct timespec *rs)
 {
-	struct evsel *counter;
-	struct affinity affinity;
-	int i, ncpus, cpu;
+	struct evlist_cpu_iterator evlist_cpu_itr;
+	struct affinity saved_affinity, *affinity;
 
 	if (all_counters_use_bpf)
 		return 0;
 
-	if (affinity__setup(&affinity) < 0)
+	if (!target__has_cpu(&target) || target__has_per_thread(&target))
+		affinity = NULL;
+	else if (affinity__setup(&saved_affinity) < 0)
 		return -1;
+	else
+		affinity = &saved_affinity;
 
-	ncpus = perf_cpu_map__nr(evsel_list->core.all_cpus);
-	if (!target__has_cpu(&target) || target__has_per_thread(&target))
-		ncpus = 1;
-	evlist__for_each_cpu(evsel_list, i, cpu) {
-		if (i >= ncpus)
-			break;
-		affinity__set(&affinity, cpu);
+	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
+		struct evsel *counter = evlist_cpu_itr.evsel;
 
-		evlist__for_each_entry(evsel_list, counter) {
-			if (evsel__cpu_iter_skip(counter, cpu))
-				continue;
-			if (evsel__is_bpf(counter))
-				continue;
-			if (!counter->err) {
-				counter->err = read_counter_cpu(counter, rs,
-								counter->cpu_iter - 1);
-			}
+		if (evsel__is_bpf(counter))
+			continue;
+
+		if (!counter->err) {
+			counter->err = read_counter_cpu(counter, rs,
+							evlist_cpu_itr.cpu_map_idx);
 		}
 	}
-	affinity__cleanup(&affinity);
+	if (affinity)
+		affinity__cleanup(&saved_affinity);
+
 	return 0;
 }
 
@@ -771,8 +768,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int i, cpu, err;
+	int err;
 	bool second_pass = false;
 
 	if (forks) {
@@ -793,106 +791,101 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		counter->reset_group = false;
 		if (bpf_counter__load(counter, &target))
 			return -1;
-		if (!evsel__is_bpf(counter))
+		if (!(evsel__is_bperf(counter)))
 			all_counters_use_bpf = false;
 	}
 
-	evlist__for_each_cpu (evsel_list, i, cpu) {
+	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+		counter = evlist_cpu_itr.evsel;
+
 		/*
 		 * bperf calls evsel__open_per_cpu() in bperf__load(), so
 		 * no need to call it again here.
 		 */
 		if (target.use_bpf)
 			break;
-		affinity__set(&affinity, cpu);
 
-		evlist__for_each_entry(evsel_list, counter) {
-			if (evsel__cpu_iter_skip(counter, cpu))
+		if (counter->reset_group || counter->errored)
+			continue;
+		if (evsel__is_bperf(counter))
+			continue;
+try_again:
+		if (create_perf_stat_counter(counter, &stat_config, &target,
+					     evlist_cpu_itr.cpu_map_idx) < 0) {
+
+			/*
+			 * Weak group failed. We cannot just undo this here
+			 * because earlier CPUs might be in group mode, and the kernel
+			 * doesn't support mixing group and non group reads. Defer
+			 * it to later.
+			 * Don't close here because we're in the wrong affinity.
+			 */
+			if ((errno == EINVAL || errno == EBADF) &&
+				evsel__leader(counter) != counter &&
+				counter->weak_group) {
+				evlist__reset_weak_group(evsel_list, counter, false);
+				assert(counter->reset_group);
+				second_pass = true;
+				continue;
+			}
+
+			switch (stat_handle_error(counter)) {
+			case COUNTER_FATAL:
+				return -1;
+			case COUNTER_RETRY:
+				goto try_again;
+			case COUNTER_SKIP:
+				continue;
+			default:
+				break;
+			}
+
+		}
+		counter->supported = true;
+	}
+
+	if (second_pass) {
+		/*
+		 * Now redo all the weak group after closing them,
+		 * and also close errored counters.
+		 */
+
+		/* First close errored or weak retry */
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+			counter = evlist_cpu_itr.evsel;
+
+			if (!counter->reset_group && !counter->errored)
 				continue;
-			if (counter->reset_group || counter->errored)
+
+			perf_evsel__close_cpu(&counter->core, evlist_cpu_itr.cpu_map_idx);
+		}
+		/* Now reopen weak */
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+			counter = evlist_cpu_itr.evsel;
+
+			if (!counter->reset_group && !counter->errored)
 				continue;
-			if (evsel__is_bpf(counter))
+			if (!counter->reset_group)
 				continue;
-try_again:
+try_again_reset:
+			pr_debug2("reopening weak %s\n", evsel__name(counter));
 			if (create_perf_stat_counter(counter, &stat_config, &target,
-						     counter->cpu_iter - 1) < 0) {
-
-				/*
-				 * Weak group failed. We cannot just undo this here
-				 * because earlier CPUs might be in group mode, and the kernel
-				 * doesn't support mixing group and non group reads. Defer
-				 * it to later.
-				 * Don't close here because we're in the wrong affinity.
-				 */
-				if ((errno == EINVAL || errno == EBADF) &&
-				    evsel__leader(counter) != counter &&
-				    counter->weak_group) {
-					evlist__reset_weak_group(evsel_list, counter, false);
-					assert(counter->reset_group);
-					second_pass = true;
-					continue;
-				}
+						     evlist_cpu_itr.cpu_map_idx) < 0) {
 
 				switch (stat_handle_error(counter)) {
 				case COUNTER_FATAL:
 					return -1;
 				case COUNTER_RETRY:
-					goto try_again;
+					goto try_again_reset;
 				case COUNTER_SKIP:
 					continue;
 				default:
 					break;
 				}
-
 			}
 			counter->supported = true;
 		}
 	}
-
-	if (second_pass) {
-		/*
-		 * Now redo all the weak group after closing them,
-		 * and also close errored counters.
-		 */
-
-		evlist__for_each_cpu(evsel_list, i, cpu) {
-			affinity__set(&affinity, cpu);
-			/* First close errored or weak retry */
-			evlist__for_each_entry(evsel_list, counter) {
-				if (!counter->reset_group && !counter->errored)
-					continue;
-				if (evsel__cpu_iter_skip_no_inc(counter, cpu))
-					continue;
-				perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
-			}
-			/* Now reopen weak */
-			evlist__for_each_entry(evsel_list, counter) {
-				if (!counter->reset_group && !counter->errored)
-					continue;
-				if (evsel__cpu_iter_skip(counter, cpu))
-					continue;
-				if (!counter->reset_group)
-					continue;
-try_again_reset:
-				pr_debug2("reopening weak %s\n", evsel__name(counter));
-				if (create_perf_stat_counter(counter, &stat_config, &target,
-							     counter->cpu_iter - 1) < 0) {
-
-					switch (stat_handle_error(counter)) {
-					case COUNTER_FATAL:
-						return -1;
-					case COUNTER_RETRY:
-						goto try_again_reset;
-					case COUNTER_SKIP:
-						continue;
-					default:
-						break;
-					}
-				}
-				counter->supported = true;
-			}
-		}
-	}
 	affinity__cleanup(&affinity);
 
 	evlist__for_each_entry(evsel_list, counter) {
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 3f69422c21f9..f10bd554521a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -1417,7 +1417,7 @@
   {
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
-    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only. "
+    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only."
   },
   {
     "EventCode": "0x201E8",
@@ -2017,7 +2017,7 @@
   {
     "EventCode": "0xC0BC",
     "EventName": "PM_LSU_FLUSH_OTHER",
-    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the “bad dval” back and flush all younger ops)"
+    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the 'bad dval' back and flush all younger ops)"
   },
   {
     "EventCode": "0x5094",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
index d0265f255de2..723bffa41c44 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
@@ -442,7 +442,7 @@
   {
     "EventCode": "0x4D052",
     "EventName": "PM_2FLOP_CMPL",
-    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg "
+    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg"
   },
   {
     "EventCode": "0x1F142",
diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 66452a8ec358..ed6f614f2724 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -11,7 +11,7 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
-from __future__ import print_function
+from __future__ import division, print_function
 
 import os
 import sys
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5f92319ce258..39d294f6c321 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -342,36 +342,65 @@ static int evlist__nr_threads(struct evlist *evlist, struct evsel *evsel)
 		return perf_thread_map__nr(evlist->core.threads);
 }
 
-void evlist__cpu_iter_start(struct evlist *evlist)
-{
-	struct evsel *pos;
-
-	/*
-	 * Reset the per evsel cpu_iter. This is needed because
-	 * each evsel's cpumap may have a different index space,
-	 * and some operations need the index to modify
-	 * the FD xyarray (e.g. open, close)
-	 */
-	evlist__for_each_entry(evlist, pos)
-		pos->cpu_iter = 0;
-}
+struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity)
+{
+	struct evlist_cpu_iterator itr = {
+		.container = evlist,
+		.evsel = evlist__first(evlist),
+		.cpu_map_idx = 0,
+		.evlist_cpu_map_idx = 0,
+		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
+		.cpu = -1,
+		.affinity = affinity,
+	};
 
-bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu)
-{
-	if (ev->cpu_iter >= ev->core.cpus->nr)
-		return true;
-	if (cpu >= 0 && ev->core.cpus->map[ev->cpu_iter] != cpu)
-		return true;
-	return false;
+	if (itr.affinity) {
+		itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
+		affinity__set(itr.affinity, itr.cpu);
+		itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
+		/*
+		 * If this CPU isn't in the evsel's cpu map then advance through
+		 * the list.
+		 */
+		if (itr.cpu_map_idx == -1)
+			evlist_cpu_iterator__next(&itr);
+	}
+	return itr;
+}
+
+void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr)
+{
+	while (evlist_cpu_itr->evsel != evlist__last(evlist_cpu_itr->container)) {
+		evlist_cpu_itr->evsel = evsel__next(evlist_cpu_itr->evsel);
+		evlist_cpu_itr->cpu_map_idx =
+			perf_cpu_map__idx(evlist_cpu_itr->evsel->core.cpus,
+					  evlist_cpu_itr->cpu);
+		if (evlist_cpu_itr->cpu_map_idx != -1)
+			return;
+	}
+	evlist_cpu_itr->evlist_cpu_map_idx++;
+	if (evlist_cpu_itr->evlist_cpu_map_idx < evlist_cpu_itr->evlist_cpu_map_nr) {
+		evlist_cpu_itr->evsel = evlist__first(evlist_cpu_itr->container);
+		evlist_cpu_itr->cpu =
+			perf_cpu_map__cpu(evlist_cpu_itr->container->core.all_cpus,
+					  evlist_cpu_itr->evlist_cpu_map_idx);
+		if (evlist_cpu_itr->affinity)
+			affinity__set(evlist_cpu_itr->affinity, evlist_cpu_itr->cpu);
+		evlist_cpu_itr->cpu_map_idx =
+			perf_cpu_map__idx(evlist_cpu_itr->evsel->core.cpus,
+					  evlist_cpu_itr->cpu);
+		/*
+		 * If this CPU isn't in the evsel's cpu map then advance through
+		 * the list.
+		 */
+		if (evlist_cpu_itr->cpu_map_idx == -1)
+			evlist_cpu_iterator__next(evlist_cpu_itr);
+	}
 }
 
-bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
+bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr)
 {
-	if (!evsel__cpu_iter_skip_no_inc(ev, cpu)) {
-		ev->cpu_iter++;
-		return false;
-	}
-	return true;
+	return evlist_cpu_itr->evlist_cpu_map_idx >= evlist_cpu_itr->evlist_cpu_map_nr;
 }
 
 static int evsel__strcmp(struct evsel *pos, char *evsel_name)
@@ -400,31 +429,26 @@ static int evlist__is_enabled(struct evlist *evlist)
 static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int cpu, i, imm = 0;
 	bool has_imm = false;
 
 	if (affinity__setup(&affinity) < 0)
 		return;
 
 	/* Disable 'immediate' events last */
-	for (imm = 0; imm <= 1; imm++) {
-		evlist__for_each_cpu(evlist, i, cpu) {
-			affinity__set(&affinity, cpu);
-
-			evlist__for_each_entry(evlist, pos) {
-				if (evsel__strcmp(pos, evsel_name))
-					continue;
-				if (evsel__cpu_iter_skip(pos, cpu))
-					continue;
-				if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
-					continue;
-				if (pos->immediate)
-					has_imm = true;
-				if (pos->immediate != imm)
-					continue;
-				evsel__disable_cpu(pos, pos->cpu_iter - 1);
-			}
+	for (int imm = 0; imm <= 1; imm++) {
+		evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+			pos = evlist_cpu_itr.evsel;
+			if (evsel__strcmp(pos, evsel_name))
+				continue;
+			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			if (pos->immediate)
+				has_imm = true;
+			if (pos->immediate != imm)
+				continue;
+			evsel__disable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 		}
 		if (!has_imm)
 			break;
@@ -462,24 +486,19 @@ void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
 static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int cpu, i;
 
 	if (affinity__setup(&affinity) < 0)
 		return;
 
-	evlist__for_each_cpu(evlist, i, cpu) {
-		affinity__set(&affinity, cpu);
-
-		evlist__for_each_entry(evlist, pos) {
-			if (evsel__strcmp(pos, evsel_name))
-				continue;
-			if (evsel__cpu_iter_skip(pos, cpu))
-				continue;
-			if (!evsel__is_group_leader(pos) || !pos->core.fd)
-				continue;
-			evsel__enable_cpu(pos, pos->cpu_iter - 1);
-		}
+	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+		pos = evlist_cpu_itr.evsel;
+		if (evsel__strcmp(pos, evsel_name))
+			continue;
+		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+			continue;
+		evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 	}
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
@@ -1264,8 +1283,8 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel)
 void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int cpu, i;
 
 	/*
 	 * With perf record core.cpus is usually NULL.
@@ -1279,15 +1298,12 @@ void evlist__close(struct evlist *evlist)
 
 	if (affinity__setup(&affinity) < 0)
 		return;
-	evlist__for_each_cpu(evlist, i, cpu) {
-		affinity__set(&affinity, cpu);
 
-		evlist__for_each_entry_reverse(evlist, evsel) {
-			if (evsel__cpu_iter_skip(evsel, cpu))
-			    continue;
-			perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
-		}
+	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+		perf_evsel__close_cpu(&evlist_cpu_itr.evsel->core,
+				      evlist_cpu_itr.cpu_map_idx);
 	}
+
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry_reverse(evlist, evsel) {
 		perf_evsel__free_fd(&evsel->core);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 97bfb8d0be4f..ec177f783ee6 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -325,17 +325,53 @@ void evlist__to_front(struct evlist *evlist, struct evsel *move_evsel);
 #define evlist__for_each_entry_safe(evlist, tmp, evsel) \
 	__evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
 
-#define evlist__for_each_cpu(evlist, index, cpu)	\
-	evlist__cpu_iter_start(evlist);			\
-	perf_cpu_map__for_each_cpu (cpu, index, (evlist)->core.all_cpus)
+/** Iterator state for evlist__for_each_cpu */
+struct evlist_cpu_iterator {
+	/** The list being iterated through. */
+	struct evlist *container;
+	/** The current evsel of the iterator. */
+	struct evsel *evsel;
+	/** The CPU map index corresponding to the evsel->core.cpus for the current CPU. */
+	int cpu_map_idx;
+	/**
+	 * The CPU map index corresponding to evlist->core.all_cpus for the
+	 * current CPU.  Distinct from cpu_map_idx as the evsel's cpu map may
+	 * contain fewer entries.
+	 */
+	int evlist_cpu_map_idx;
+	/** The number of CPU map entries in evlist->core.all_cpus. */
+	int evlist_cpu_map_nr;
+	/** The current CPU of the iterator. */
+	int cpu;
+	/** If present, used to set the affinity when switching between CPUs. */
+	struct affinity *affinity;
+};
+
+/**
+ * evlist__for_each_cpu - without affinity, iterate over the evlist. With
+ *                        affinity, iterate over all CPUs and then the evlist
+ *                        for each evsel on that CPU. When switching between
+ *                        CPUs the affinity is set to the CPU to avoid IPIs
+ *                        during syscalls.
+ * @evlist_cpu_itr: the iterator instance.
+ * @evlist: evlist instance to iterate.
+ * @affinity: NULL or used to set the affinity to the current CPU.
+ */
+#define evlist__for_each_cpu(evlist_cpu_itr, evlist, affinity)		\
+	for ((evlist_cpu_itr) = evlist__cpu_begin(evlist, affinity);	\
+	     !evlist_cpu_iterator__end(&evlist_cpu_itr);		\
+	     evlist_cpu_iterator__next(&evlist_cpu_itr))
+
+/** Returns an iterator set to the first CPU/evsel of evlist. */
+struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity);
+/** Move to next element in iterator, updating CPU, evsel and the affinity. */
+void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr);
+/** Returns true when iterator is at the end of the CPUs and evlist. */
+bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr);
 
 struct evsel *evlist__get_tracking_event(struct evlist *evlist);
 void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
 
-void evlist__cpu_iter_start(struct evlist *evlist);
-bool evsel__cpu_iter_skip(struct evsel *ev, int cpu);
-bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu);
-
 struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
 
 struct evsel *evlist__event2evsel(struct evlist *evlist, union perf_event *event);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f7edfa8568a..0492cafac443 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -119,7 +119,6 @@ struct evsel {
 	bool			errored;
 	struct hashmap		*per_pkg_mask;
 	int			err;
-	int			cpu_iter;
 	struct {
 		evsel__sb_cb_t	*cb;
 		void		*data;
@@ -249,6 +248,11 @@ static inline bool evsel__is_bpf(struct evsel *evsel)
 	return evsel->bpf_counter_ops != NULL;
 }
 
+static inline bool evsel__is_bperf(struct evsel *evsel)
+{
+	return evsel->bpf_counter_ops != NULL && list_empty(&evsel->bpf_counter_list);
+}
+
 #define EVSEL__MAX_ALIASES 8
 
 extern const char *evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES];
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 26c0b88cef4c..eafd80be6607 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1858,7 +1858,7 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
 	return 0;
 
 free_name:
-	zfree(caps->name);
+	zfree(&caps->name);
 free_caps:
 	free(caps);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index a111065b484e..a4f2ffe2bdb6 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -876,8 +876,7 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
 static int64_t
 sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct addr_map_symbol *from_l = &left->branch_info->from;
-	struct addr_map_symbol *from_r = &right->branch_info->from;
+	struct addr_map_symbol *from_l, *from_r;
 
 	if (!left->branch_info || !right->branch_info)
 		return cmp_null(left->branch_info, right->branch_info);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index fd42f768e584..bbc3a150597a 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -553,7 +553,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 				size_t sz = min(size, descsz);
 				memcpy(bf, ptr, sz);
 				memset(bf + sz, 0, size - sz);
-				err = descsz;
+				err = sz;
 				break;
 			}
 		}
diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
index aebaab8ce44c..441eededa031 100755
--- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
@@ -292,6 +292,11 @@ setup_hs()
 	ip netns exec ${hsname} sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec ${hsname} sysctl -wq net.ipv6.conf.default.accept_dad=0
 
+	# disable the rp_filter otherwise the kernel gets confused about how
+	# to route decap ipv4 packets.
+	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
+	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.default.rp_filter=0
+
 	ip -netns ${hsname} link add veth0 type veth peer name ${rtveth}
 	ip -netns ${hsname} link set ${rtveth} netns ${rtname}
 	ip -netns ${hsname} addr add ${IPv6_HS_NETWORK}::${hs}/64 dev veth0 nodad
@@ -316,11 +321,6 @@ setup_hs()
 	ip netns exec ${rtname} sysctl -wq net.ipv6.conf.${rtveth}.proxy_ndp=1
 	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.${rtveth}.proxy_arp=1
 
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.${rtveth}.rp_filter=0
-
 	ip netns exec ${rtname} sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
 }
 
