Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9970FC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbjEXRVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEXRVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:21:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E2E9;
        Wed, 24 May 2023 10:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32F7A63C6C;
        Wed, 24 May 2023 17:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81401C433EF;
        Wed, 24 May 2023 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684948837;
        bh=xgDQ1TkEh9HB4EVVpW3owkg23y88VhfFDeJ09NYgNIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B70RZj55fUJRXiJWL6XQFpp1O97SvOlZPxT/5nw5ak/B1JUHdLb+qQ7WgwiE7mxSG
         uw0XFrr+tJVweZOpNulGTWya+T92WK2zRznHQ+PNjqb0fmZR5ZA3291v+7lrtXhzgy
         2ux37orNhPz8uyUyD/xM8ZKZjmTGHgNkRjpTm5HU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.30
Date:   Wed, 24 May 2023 18:20:20 +0100
Message-Id: <2023052419-entryway-fondly-b697@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023052419-unviable-secluding-137b@gregkh>
References: <2023052419-unviable-secluding-137b@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 808ade4cc008..55492fea4427 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -170,6 +170,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERRATUM   |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | T241 GICv3/4.x  | T241-FABRIC-4   | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
index 9b31f864e071..71364c6081ff 100644
--- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
+++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
@@ -32,7 +32,7 @@ properties:
     maxItems: 1
 
   iommus:
-    maxItems: 1
+    maxItems: 4
 
   power-domains:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 6c5b4783812a..2fa1759e74d9 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -65,6 +65,18 @@ properties:
       Indicates if the DSI controller is driving a panel which needs
       2 DSI links.
 
+  qcom,master-dsi:
+    type: boolean
+    description: |
+      Indicates if the DSI controller is the master DSI controller when
+      qcom,dual-dsi-mode enabled.
+
+  qcom,sync-dual-dsi:
+    type: boolean
+    description: |
+      Indicates if the DSI controller needs to sync the other DSI controller
+      with MIPI DCS commands when qcom,dual-dsi-mode enabled.
+
   assigned-clocks:
     maxItems: 2
     description: |
diff --git a/MAINTAINERS b/MAINTAINERS
index 350d7e3ba94f..301b9ba6af79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9362,7 +9362,7 @@ F:	drivers/net/wireless/intersil/hostap/
 HP COMPAQ TC1100 TABLET WMI EXTRAS DRIVER
 L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
-F:	drivers/platform/x86/tc1100-wmi.c
+F:	drivers/platform/x86/hp/tc1100-wmi.c
 
 HPET:	High Precision Event Timers driver
 M:	Clemens Ladisch <clemens@ladisch.de>
@@ -11858,7 +11858,7 @@ M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained
 F:	Documentation/misc-devices/lis3lv02d.rst
 F:	drivers/misc/lis3lv02d/
-F:	drivers/platform/x86/hp_accel.c
+F:	drivers/platform/x86/hp/hp_accel.c
 
 LIST KUNIT TEST
 M:	David Gow <davidgow@google.com>
diff --git a/Makefile b/Makefile
index f02f6e1ac574..aeb58c7a4baa 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 29
+SUBLEVEL = 30
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
index 1dbe98948ce3..9627c4cf3e41 100644
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  *  arch/arm/mac-sa1100/jornada720_ssp.c
  *
  *  Copyright (C) 2006/2007 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
@@ -26,6 +26,7 @@ static unsigned long jornada_ssp_flags;
 
 /**
  * jornada_ssp_reverse - reverses input byte
+ * @byte: input byte to reverse
  *
  * we need to reverse all data we receive from the mcu due to its physical location
  * returns : 01110111 -> 11101110
@@ -46,6 +47,7 @@ EXPORT_SYMBOL(jornada_ssp_reverse);
 
 /**
  * jornada_ssp_byte - waits for ready ssp bus and sends byte
+ * @byte: input byte to transmit
  *
  * waits for fifo buffer to clear and then transmits, if it doesn't then we will
  * timeout after <timeout> rounds. Needs mcu running before its called.
@@ -77,6 +79,7 @@ EXPORT_SYMBOL(jornada_ssp_byte);
 
 /**
  * jornada_ssp_inout - decide if input is command or trading byte
+ * @byte: input byte to send (may be %TXDUMMY)
  *
  * returns : (jornada_ssp_byte(byte)) on success
  *         : %-ETIMEDOUT on timeout failure
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index ae08556b2ef2..1499d5d8bbc0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1299,7 +1299,6 @@ &usb_dwc3_0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	dr_mode = "otg";
-	snps,dis_u3_susphy_quirk;
 	usb-role-switch;
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 67b87915d822..9f8910054201 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2979,8 +2979,11 @@ usb3_dwc3: usb@6a00000 {
 				interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,hird-threshold = /bits/ 8 <0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,is-utmi-l1-suspend;
+				tx-fifo-resize;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index f98259489679..74c6832e0598 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -731,8 +731,6 @@ &wifi {
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
-
-	qcom,snoc-host-cap-skip-quirk;
 	status = "okay";
 };
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 84a085d536f8..e20af03b4cdf 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -72,13 +72,10 @@ void mte_sync_tags(pte_t old_pte, pte_t pte)
 		return;
 
 	/* if PG_mte_tagged is set, tags have already been initialised */
-	for (i = 0; i < nr_pages; i++, page++) {
-		if (!page_mte_tagged(page)) {
+	for (i = 0; i < nr_pages; i++, page++)
+		if (!page_mte_tagged(page))
 			mte_sync_page_tags(page, old_pte, check_swap,
 					   pte_is_tagged);
-			set_page_mte_tagged(page);
-		}
-	}
 
 	/* ensure the tags are visible before the PTE is set */
 	smp_wmb();
diff --git a/arch/parisc/include/asm/pdc.h b/arch/parisc/include/asm/pdc.h
index fcbcf9a96c11..77622558bf65 100644
--- a/arch/parisc/include/asm/pdc.h
+++ b/arch/parisc/include/asm/pdc.h
@@ -80,6 +80,7 @@ int pdc_do_firm_test_reset(unsigned long ftc_bitmap);
 int pdc_do_reset(void);
 int pdc_soft_power_info(unsigned long *power_reg);
 int pdc_soft_power_button(int sw_control);
+int pdc_soft_power_button_panic(int sw_control);
 void pdc_io_reset(void);
 void pdc_io_reset_devices(void);
 int pdc_iodc_getc(void);
diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware.c
index bd325f2b5349..3e051a973e9b 100644
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -1232,15 +1232,18 @@ int __init pdc_soft_power_info(unsigned long *power_reg)
 }
 
 /*
- * pdc_soft_power_button - Control the soft power button behaviour
- * @sw_control: 0 for hardware control, 1 for software control 
+ * pdc_soft_power_button{_panic} - Control the soft power button behaviour
+ * @sw_control: 0 for hardware control, 1 for software control
  *
  *
  * This PDC function places the soft power button under software or
  * hardware control.
- * Under software control the OS may control to when to allow to shut 
- * down the system. Under hardware control pressing the power button 
+ * Under software control the OS may control to when to allow to shut
+ * down the system. Under hardware control pressing the power button
  * powers off the system immediately.
+ *
+ * The _panic version relies on spin_trylock to prevent deadlock
+ * on panic path.
  */
 int pdc_soft_power_button(int sw_control)
 {
@@ -1254,6 +1257,22 @@ int pdc_soft_power_button(int sw_control)
 	return retval;
 }
 
+int pdc_soft_power_button_panic(int sw_control)
+{
+	int retval;
+	unsigned long flags;
+
+	if (!spin_trylock_irqsave(&pdc_lock, flags)) {
+		pr_emerg("Couldn't enable soft power button\n");
+		return -EBUSY; /* ignored by the panic notifier */
+	}
+
+	retval = mem_pdc_call(PDC_SOFT_POWER, PDC_SOFT_POWER_ENABLE, __pa(pdc_result), sw_control);
+	spin_unlock_irqrestore(&pdc_lock, flags);
+
+	return retval;
+}
+
 /*
  * pdc_io_reset - Hack to avoid overlapping range registers of Bridges devices.
  * Primarily a problem on T600 (which parisc-linux doesn't support) but
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 038ce8d9061d..8920862ffd79 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -144,7 +144,7 @@ static bool dma_iommu_bypass_supported(struct device *dev, u64 mask)
 /* We support DMA to/from any memory page via the iommu */
 int dma_iommu_dma_supported(struct device *dev, u64 mask)
 {
-	struct iommu_table *tbl = get_iommu_table_base(dev);
+	struct iommu_table *tbl;
 
 	if (dev_is_pci(dev) && dma_iommu_bypass_supported(dev, mask)) {
 		/*
@@ -162,6 +162,8 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		return 1;
 	}
 
+	tbl = get_iommu_table_base(dev);
+
 	if (!tbl) {
 		dev_err(dev, "Warning: IOMMU dma not supported: mask 0x%08llx, table unavailable\n", mask);
 		return 0;
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index ee95937bdaf1..b8b7a189cd3c 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -517,7 +517,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		/* Convert entry to a dma_addr_t */
 		entry += tbl->it_offset;
 		dma_addr = entry << tbl->it_page_shift;
-		dma_addr |= (s->offset & ~IOMMU_PAGE_MASK(tbl));
+		dma_addr |= (vaddr & ~IOMMU_PAGE_MASK(tbl));
 
 		DBG("  - %lu pages, entry: %lx, dma_addr: %lx\n",
 			    npages, entry, dma_addr);
@@ -904,6 +904,7 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	unsigned int order;
 	unsigned int nio_pages, io_order;
 	struct page *page;
+	int tcesize = (1 << tbl->it_page_shift);
 
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
@@ -930,7 +931,8 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	memset(ret, 0, size);
 
 	/* Set up tces to cover the allocated range */
-	nio_pages = size >> tbl->it_page_shift;
+	nio_pages = IOMMU_PAGE_ALIGN(size, tbl) >> tbl->it_page_shift;
+
 	io_order = get_iommu_order(size, tbl);
 	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
 			      mask >> tbl->it_page_shift, io_order, 0);
@@ -938,7 +940,8 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 		free_pages((unsigned long)ret, order);
 		return NULL;
 	}
-	*dma_handle = mapping;
+
+	*dma_handle = mapping | ((u64)ret & (tcesize - 1));
 	return ret;
 }
 
@@ -949,7 +952,7 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 		unsigned int nio_pages;
 
 		size = PAGE_ALIGN(size);
-		nio_pages = size >> tbl->it_page_shift;
+		nio_pages = IOMMU_PAGE_ALIGN(size, tbl) >> tbl->it_page_shift;
 		iommu_free(tbl, dma_handle, nio_pages);
 		size = PAGE_ALIGN(size);
 		free_pages((unsigned long)vaddr, get_order(size));
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 26245aaf12b8..2297aa764ecd 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1040,8 +1040,8 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
 				  pte_t entry, unsigned long address, int psize)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
-					      _PAGE_RW | _PAGE_EXEC);
+	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_SOFT_DIRTY |
+					      _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
 
 	unsigned long change = pte_val(entry) ^ pte_val(*ptep);
 	/*
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 561adac69022..efba867017e2 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -85,19 +85,24 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 static void iommu_pseries_free_group(struct iommu_table_group *table_group,
 		const char *node_name)
 {
-	struct iommu_table *tbl;
-
 	if (!table_group)
 		return;
 
-	tbl = table_group->tables[0];
 #ifdef CONFIG_IOMMU_API
 	if (table_group->group) {
 		iommu_group_put(table_group->group);
 		BUG_ON(table_group->group);
 	}
 #endif
-	iommu_tce_table_put(tbl);
+
+	/* Default DMA window table is at index 0, while DDW at 1. SR-IOV
+	 * adapters only have table on index 1.
+	 */
+	if (table_group->tables[0])
+		iommu_tce_table_put(table_group->tables[0]);
+
+	if (table_group->tables[1])
+		iommu_tce_table_put(table_group->tables[1]);
 
 	kfree(table_group);
 }
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index 7f0840dcc31b..90dea3abdbb2 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook_trampoline.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/s390/crypto/chacha-glue.c b/arch/s390/crypto/chacha-glue.c
index 7752bd314558..5fae187f947a 100644
--- a/arch/s390/crypto/chacha-glue.c
+++ b/arch/s390/crypto/chacha-glue.c
@@ -82,7 +82,7 @@ void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src,
 	 * it cannot handle a block of data or less, but otherwise
 	 * it can handle data of arbitrary size
 	 */
-	if (bytes <= CHACHA_BLOCK_SIZE || nrounds != 20)
+	if (bytes <= CHACHA_BLOCK_SIZE || nrounds != 20 || !MACHINE_HAS_VX)
 		chacha_crypt_generic(state, dst, src, bytes, nrounds);
 	else
 		chacha20_crypt_s390(state, dst, src, bytes,
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 5e6a23299790..7d92aa57715a 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -10,6 +10,7 @@ CFLAGS_REMOVE_ftrace.o		= $(CC_FLAGS_FTRACE)
 
 # Do not trace early setup code
 CFLAGS_REMOVE_early.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook.o		= $(CC_FLAGS_FTRACE)
 
 endif
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f901658d9f7c..42b5540dac58 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -17,6 +17,7 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
+CFLAGS_REMOVE_rethook.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ff9d23889415..52eb79d60a3f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -637,6 +637,8 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
 					sched_data->service_tree[i].wsum;
 			}
 		}
+		if (!wsum)
+			continue;
 		limit = DIV_ROUND_CLOSEST(limit * entity->weight, wsum);
 		if (entity->allocated >= limit) {
 			bfq_log_bfqq(bfqq->bfqd, bfqq,
diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index 2d115bec15ae..b9edfaa51b27 100644
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -37,6 +37,7 @@
  * DAMAGE.
  */
 
+#include <linux/fips.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -59,11 +60,6 @@ void jent_zfree(void *ptr)
 	kfree_sensitive(ptr);
 }
 
-void jent_panic(char *s)
-{
-	panic("%s", s);
-}
-
 void jent_memcpy(void *dest, const void *src, unsigned int n)
 {
 	memcpy(dest, src, n);
@@ -102,7 +98,6 @@ void jent_get_nstime(__u64 *out)
 struct jitterentropy {
 	spinlock_t jent_lock;
 	struct rand_data *entropy_collector;
-	unsigned int reset_cnt;
 };
 
 static int jent_kcapi_init(struct crypto_tfm *tfm)
@@ -138,32 +133,30 @@ static int jent_kcapi_random(struct crypto_rng *tfm,
 
 	spin_lock(&rng->jent_lock);
 
-	/* Return a permanent error in case we had too many resets in a row. */
-	if (rng->reset_cnt > (1<<10)) {
-		ret = -EFAULT;
-		goto out;
-	}
-
 	ret = jent_read_entropy(rng->entropy_collector, rdata, dlen);
 
-	/* Reset RNG in case of health failures */
-	if (ret < -1) {
-		pr_warn_ratelimited("Reset Jitter RNG due to health test failure: %s failure\n",
-				    (ret == -2) ? "Repetition Count Test" :
-						  "Adaptive Proportion Test");
-
-		rng->reset_cnt++;
-
+	if (ret == -3) {
+		/* Handle permanent health test error */
+		/*
+		 * If the kernel was booted with fips=1, it implies that
+		 * the entire kernel acts as a FIPS 140 module. In this case
+		 * an SP800-90B permanent health test error is treated as
+		 * a FIPS module error.
+		 */
+		if (fips_enabled)
+			panic("Jitter RNG permanent health test failure\n");
+
+		pr_err("Jitter RNG permanent health test failure\n");
+		ret = -EFAULT;
+	} else if (ret == -2) {
+		/* Handle intermittent health test error */
+		pr_warn_ratelimited("Reset Jitter RNG due to intermittent health test failure\n");
 		ret = -EAGAIN;
-	} else {
-		rng->reset_cnt = 0;
-
-		/* Convert the Jitter RNG error into a usable error code */
-		if (ret == -1)
-			ret = -EINVAL;
+	} else if (ret == -1) {
+		/* Handle other errors */
+		ret = -EINVAL;
 	}
 
-out:
 	spin_unlock(&rng->jent_lock);
 
 	return ret;
@@ -197,6 +190,10 @@ static int __init jent_mod_init(void)
 
 	ret = jent_entropy_init();
 	if (ret) {
+		/* Handle permanent health test error */
+		if (fips_enabled)
+			panic("jitterentropy: Initialization failed with host not compliant with requirements: %d\n", ret);
+
 		pr_info("jitterentropy: Initialization failed with host not compliant with requirements: %d\n", ret);
 		return -EFAULT;
 	}
diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 93bff3213823..22f48bf4c6f5 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -85,10 +85,14 @@ struct rand_data {
 				      * bit generation */
 
 	/* Repetition Count Test */
-	int rct_count;			/* Number of stuck values */
+	unsigned int rct_count;			/* Number of stuck values */
 
-	/* Adaptive Proportion Test for a significance level of 2^-30 */
+	/* Intermittent health test failure threshold of 2^-30 */
+#define JENT_RCT_CUTOFF		30	/* Taken from SP800-90B sec 4.4.1 */
 #define JENT_APT_CUTOFF		325	/* Taken from SP800-90B sec 4.4.2 */
+	/* Permanent health test failure threshold of 2^-60 */
+#define JENT_RCT_CUTOFF_PERMANENT	60
+#define JENT_APT_CUTOFF_PERMANENT	355
 #define JENT_APT_WINDOW_SIZE	512	/* Data window size */
 	/* LSB of time stamp to process */
 #define JENT_APT_LSB		16
@@ -97,8 +101,6 @@ struct rand_data {
 	unsigned int apt_count;		/* APT counter */
 	unsigned int apt_base;		/* APT base reference */
 	unsigned int apt_base_set:1;	/* APT base reference set? */
-
-	unsigned int health_failure:1;	/* Permanent health failure */
 };
 
 /* Flags that can be used to initialize the RNG */
@@ -169,19 +171,26 @@ static void jent_apt_insert(struct rand_data *ec, unsigned int delta_masked)
 		return;
 	}
 
-	if (delta_masked == ec->apt_base) {
+	if (delta_masked == ec->apt_base)
 		ec->apt_count++;
 
-		if (ec->apt_count >= JENT_APT_CUTOFF)
-			ec->health_failure = 1;
-	}
-
 	ec->apt_observations++;
 
 	if (ec->apt_observations >= JENT_APT_WINDOW_SIZE)
 		jent_apt_reset(ec, delta_masked);
 }
 
+/* APT health test failure detection */
+static int jent_apt_permanent_failure(struct rand_data *ec)
+{
+	return (ec->apt_count >= JENT_APT_CUTOFF_PERMANENT) ? 1 : 0;
+}
+
+static int jent_apt_failure(struct rand_data *ec)
+{
+	return (ec->apt_count >= JENT_APT_CUTOFF) ? 1 : 0;
+}
+
 /***************************************************************************
  * Stuck Test and its use as Repetition Count Test
  *
@@ -206,55 +215,14 @@ static void jent_apt_insert(struct rand_data *ec, unsigned int delta_masked)
  */
 static void jent_rct_insert(struct rand_data *ec, int stuck)
 {
-	/*
-	 * If we have a count less than zero, a previous RCT round identified
-	 * a failure. We will not overwrite it.
-	 */
-	if (ec->rct_count < 0)
-		return;
-
 	if (stuck) {
 		ec->rct_count++;
-
-		/*
-		 * The cutoff value is based on the following consideration:
-		 * alpha = 2^-30 as recommended in FIPS 140-2 IG 9.8.
-		 * In addition, we require an entropy value H of 1/OSR as this
-		 * is the minimum entropy required to provide full entropy.
-		 * Note, we collect 64 * OSR deltas for inserting them into
-		 * the entropy pool which should then have (close to) 64 bits
-		 * of entropy.
-		 *
-		 * Note, ec->rct_count (which equals to value B in the pseudo
-		 * code of SP800-90B section 4.4.1) starts with zero. Hence
-		 * we need to subtract one from the cutoff value as calculated
-		 * following SP800-90B.
-		 */
-		if ((unsigned int)ec->rct_count >= (31 * ec->osr)) {
-			ec->rct_count = -1;
-			ec->health_failure = 1;
-		}
 	} else {
+		/* Reset RCT */
 		ec->rct_count = 0;
 	}
 }
 
-/*
- * Is there an RCT health test failure?
- *
- * @ec [in] Reference to entropy collector
- *
- * @return
- * 	0 No health test failure
- * 	1 Permanent health test failure
- */
-static int jent_rct_failure(struct rand_data *ec)
-{
-	if (ec->rct_count < 0)
-		return 1;
-	return 0;
-}
-
 static inline __u64 jent_delta(__u64 prev, __u64 next)
 {
 #define JENT_UINT64_MAX		(__u64)(~((__u64) 0))
@@ -303,18 +271,26 @@ static int jent_stuck(struct rand_data *ec, __u64 current_delta)
 	return 0;
 }
 
-/*
- * Report any health test failures
- *
- * @ec [in] Reference to entropy collector
- *
- * @return
- * 	0 No health test failure
- * 	1 Permanent health test failure
- */
+/* RCT health test failure detection */
+static int jent_rct_permanent_failure(struct rand_data *ec)
+{
+	return (ec->rct_count >= JENT_RCT_CUTOFF_PERMANENT) ? 1 : 0;
+}
+
+static int jent_rct_failure(struct rand_data *ec)
+{
+	return (ec->rct_count >= JENT_RCT_CUTOFF) ? 1 : 0;
+}
+
+/* Report of health test failures */
 static int jent_health_failure(struct rand_data *ec)
 {
-	return ec->health_failure;
+	return jent_rct_failure(ec) | jent_apt_failure(ec);
+}
+
+static int jent_permanent_health_failure(struct rand_data *ec)
+{
+	return jent_rct_permanent_failure(ec) | jent_apt_permanent_failure(ec);
 }
 
 /***************************************************************************
@@ -600,8 +576,8 @@ static void jent_gen_entropy(struct rand_data *ec)
  *
  * The following error codes can occur:
  *	-1	entropy_collector is NULL
- *	-2	RCT failed
- *	-3	APT test failed
+ *	-2	Intermittent health failure
+ *	-3	Permanent health failure
  */
 int jent_read_entropy(struct rand_data *ec, unsigned char *data,
 		      unsigned int len)
@@ -616,39 +592,23 @@ int jent_read_entropy(struct rand_data *ec, unsigned char *data,
 
 		jent_gen_entropy(ec);
 
-		if (jent_health_failure(ec)) {
-			int ret;
-
-			if (jent_rct_failure(ec))
-				ret = -2;
-			else
-				ret = -3;
-
+		if (jent_permanent_health_failure(ec)) {
 			/*
-			 * Re-initialize the noise source
-			 *
-			 * If the health test fails, the Jitter RNG remains
-			 * in failure state and will return a health failure
-			 * during next invocation.
+			 * At this point, the Jitter RNG instance is considered
+			 * as a failed instance. There is no rerun of the
+			 * startup test any more, because the caller
+			 * is assumed to not further use this instance.
 			 */
-			if (jent_entropy_init())
-				return ret;
-
-			/* Set APT to initial state */
-			jent_apt_reset(ec, 0);
-			ec->apt_base_set = 0;
-
-			/* Set RCT to initial state */
-			ec->rct_count = 0;
-
-			/* Re-enable Jitter RNG */
-			ec->health_failure = 0;
-
+			return -3;
+		} else if (jent_health_failure(ec)) {
 			/*
-			 * Return the health test failure status to the
-			 * caller as the generated value is not appropriate.
+			 * Perform startup health tests and return permanent
+			 * error if it fails.
 			 */
-			return ret;
+			if (jent_entropy_init())
+				return -3;
+
+			return -2;
 		}
 
 		if ((DATA_SIZE_BITS / 8) < len)
diff --git a/crypto/jitterentropy.h b/crypto/jitterentropy.h
index b7397b617ef0..5cc583f6bc6b 100644
--- a/crypto/jitterentropy.h
+++ b/crypto/jitterentropy.h
@@ -2,7 +2,6 @@
 
 extern void *jent_zalloc(unsigned int len);
 extern void jent_zfree(void *ptr);
-extern void jent_panic(char *s);
 extern void jent_memcpy(void *dest, const void *src, unsigned int n);
 extern void jent_get_nstime(__u64 *out);
 
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 814d2dc87d7e..56c39a0c9495 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -852,12 +852,50 @@ static int prepare_keybuf(const u8 *key, unsigned int ksize,
 
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 
+/*
+ * The fuzz tests use prandom instead of the normal Linux RNG since they don't
+ * need cryptographically secure random numbers.  This greatly improves the
+ * performance of these tests, especially if they are run before the Linux RNG
+ * has been initialized or if they are run on a lockdep-enabled kernel.
+ */
+
+static inline void init_rnd_state(struct rnd_state *rng)
+{
+	prandom_seed_state(rng, get_random_u64());
+}
+
+static inline u8 prandom_u8(struct rnd_state *rng)
+{
+	return prandom_u32_state(rng);
+}
+
+static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
+{
+	/*
+	 * This is slightly biased for non-power-of-2 values of 'ceil', but this
+	 * isn't important here.
+	 */
+	return prandom_u32_state(rng) % ceil;
+}
+
+static inline bool prandom_bool(struct rnd_state *rng)
+{
+	return prandom_u32_below(rng, 2);
+}
+
+static inline u32 prandom_u32_inclusive(struct rnd_state *rng,
+					u32 floor, u32 ceil)
+{
+	return floor + prandom_u32_below(rng, ceil - floor + 1);
+}
+
 /* Generate a random length in range [0, max_len], but prefer smaller values */
-static unsigned int generate_random_length(unsigned int max_len)
+static unsigned int generate_random_length(struct rnd_state *rng,
+					   unsigned int max_len)
 {
-	unsigned int len = prandom_u32_max(max_len + 1);
+	unsigned int len = prandom_u32_below(rng, max_len + 1);
 
-	switch (prandom_u32_max(4)) {
+	switch (prandom_u32_below(rng, 4)) {
 	case 0:
 		return len % 64;
 	case 1:
@@ -870,43 +908,44 @@ static unsigned int generate_random_length(unsigned int max_len)
 }
 
 /* Flip a random bit in the given nonempty data buffer */
-static void flip_random_bit(u8 *buf, size_t size)
+static void flip_random_bit(struct rnd_state *rng, u8 *buf, size_t size)
 {
 	size_t bitpos;
 
-	bitpos = prandom_u32_max(size * 8);
+	bitpos = prandom_u32_below(rng, size * 8);
 	buf[bitpos / 8] ^= 1 << (bitpos % 8);
 }
 
 /* Flip a random byte in the given nonempty data buffer */
-static void flip_random_byte(u8 *buf, size_t size)
+static void flip_random_byte(struct rnd_state *rng, u8 *buf, size_t size)
 {
-	buf[prandom_u32_max(size)] ^= 0xff;
+	buf[prandom_u32_below(rng, size)] ^= 0xff;
 }
 
 /* Sometimes make some random changes to the given nonempty data buffer */
-static void mutate_buffer(u8 *buf, size_t size)
+static void mutate_buffer(struct rnd_state *rng, u8 *buf, size_t size)
 {
 	size_t num_flips;
 	size_t i;
 
 	/* Sometimes flip some bits */
-	if (prandom_u32_max(4) == 0) {
-		num_flips = min_t(size_t, 1 << prandom_u32_max(8), size * 8);
+	if (prandom_u32_below(rng, 4) == 0) {
+		num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8),
+				  size * 8);
 		for (i = 0; i < num_flips; i++)
-			flip_random_bit(buf, size);
+			flip_random_bit(rng, buf, size);
 	}
 
 	/* Sometimes flip some bytes */
-	if (prandom_u32_max(4) == 0) {
-		num_flips = min_t(size_t, 1 << prandom_u32_max(8), size);
+	if (prandom_u32_below(rng, 4) == 0) {
+		num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8), size);
 		for (i = 0; i < num_flips; i++)
-			flip_random_byte(buf, size);
+			flip_random_byte(rng, buf, size);
 	}
 }
 
 /* Randomly generate 'count' bytes, but sometimes make them "interesting" */
-static void generate_random_bytes(u8 *buf, size_t count)
+static void generate_random_bytes(struct rnd_state *rng, u8 *buf, size_t count)
 {
 	u8 b;
 	u8 increment;
@@ -915,11 +954,11 @@ static void generate_random_bytes(u8 *buf, size_t count)
 	if (count == 0)
 		return;
 
-	switch (prandom_u32_max(8)) { /* Choose a generation strategy */
+	switch (prandom_u32_below(rng, 8)) { /* Choose a generation strategy */
 	case 0:
 	case 1:
 		/* All the same byte, plus optional mutations */
-		switch (prandom_u32_max(4)) {
+		switch (prandom_u32_below(rng, 4)) {
 		case 0:
 			b = 0x00;
 			break;
@@ -927,28 +966,28 @@ static void generate_random_bytes(u8 *buf, size_t count)
 			b = 0xff;
 			break;
 		default:
-			b = get_random_u8();
+			b = prandom_u8(rng);
 			break;
 		}
 		memset(buf, b, count);
-		mutate_buffer(buf, count);
+		mutate_buffer(rng, buf, count);
 		break;
 	case 2:
 		/* Ascending or descending bytes, plus optional mutations */
-		increment = get_random_u8();
-		b = get_random_u8();
+		increment = prandom_u8(rng);
+		b = prandom_u8(rng);
 		for (i = 0; i < count; i++, b += increment)
 			buf[i] = b;
-		mutate_buffer(buf, count);
+		mutate_buffer(rng, buf, count);
 		break;
 	default:
 		/* Fully random bytes */
-		for (i = 0; i < count; i++)
-			buf[i] = get_random_u8();
+		prandom_bytes_state(rng, buf, count);
 	}
 }
 
-static char *generate_random_sgl_divisions(struct test_sg_division *divs,
+static char *generate_random_sgl_divisions(struct rnd_state *rng,
+					   struct test_sg_division *divs,
 					   size_t max_divs, char *p, char *end,
 					   bool gen_flushes, u32 req_flags)
 {
@@ -959,24 +998,26 @@ static char *generate_random_sgl_divisions(struct test_sg_division *divs,
 		unsigned int this_len;
 		const char *flushtype_str;
 
-		if (div == &divs[max_divs - 1] || prandom_u32_max(2) == 0)
+		if (div == &divs[max_divs - 1] || prandom_bool(rng))
 			this_len = remaining;
 		else
-			this_len = 1 + prandom_u32_max(remaining);
+			this_len = prandom_u32_inclusive(rng, 1, remaining);
 		div->proportion_of_total = this_len;
 
-		if (prandom_u32_max(4) == 0)
-			div->offset = (PAGE_SIZE - 128) + prandom_u32_max(128);
-		else if (prandom_u32_max(2) == 0)
-			div->offset = prandom_u32_max(32);
+		if (prandom_u32_below(rng, 4) == 0)
+			div->offset = prandom_u32_inclusive(rng,
+							    PAGE_SIZE - 128,
+							    PAGE_SIZE - 1);
+		else if (prandom_bool(rng))
+			div->offset = prandom_u32_below(rng, 32);
 		else
-			div->offset = prandom_u32_max(PAGE_SIZE);
-		if (prandom_u32_max(8) == 0)
+			div->offset = prandom_u32_below(rng, PAGE_SIZE);
+		if (prandom_u32_below(rng, 8) == 0)
 			div->offset_relative_to_alignmask = true;
 
 		div->flush_type = FLUSH_TYPE_NONE;
 		if (gen_flushes) {
-			switch (prandom_u32_max(4)) {
+			switch (prandom_u32_below(rng, 4)) {
 			case 0:
 				div->flush_type = FLUSH_TYPE_REIMPORT;
 				break;
@@ -988,7 +1029,7 @@ static char *generate_random_sgl_divisions(struct test_sg_division *divs,
 
 		if (div->flush_type != FLUSH_TYPE_NONE &&
 		    !(req_flags & CRYPTO_TFM_REQ_MAY_SLEEP) &&
-		    prandom_u32_max(2) == 0)
+		    prandom_bool(rng))
 			div->nosimd = true;
 
 		switch (div->flush_type) {
@@ -1023,7 +1064,8 @@ static char *generate_random_sgl_divisions(struct test_sg_division *divs,
 }
 
 /* Generate a random testvec_config for fuzz testing */
-static void generate_random_testvec_config(struct testvec_config *cfg,
+static void generate_random_testvec_config(struct rnd_state *rng,
+					   struct testvec_config *cfg,
 					   char *name, size_t max_namelen)
 {
 	char *p = name;
@@ -1035,7 +1077,7 @@ static void generate_random_testvec_config(struct testvec_config *cfg,
 
 	p += scnprintf(p, end - p, "random:");
 
-	switch (prandom_u32_max(4)) {
+	switch (prandom_u32_below(rng, 4)) {
 	case 0:
 	case 1:
 		cfg->inplace_mode = OUT_OF_PLACE;
@@ -1050,12 +1092,12 @@ static void generate_random_testvec_config(struct testvec_config *cfg,
 		break;
 	}
 
-	if (prandom_u32_max(2) == 0) {
+	if (prandom_bool(rng)) {
 		cfg->req_flags |= CRYPTO_TFM_REQ_MAY_SLEEP;
 		p += scnprintf(p, end - p, " may_sleep");
 	}
 
-	switch (prandom_u32_max(4)) {
+	switch (prandom_u32_below(rng, 4)) {
 	case 0:
 		cfg->finalization_type = FINALIZATION_TYPE_FINAL;
 		p += scnprintf(p, end - p, " use_final");
@@ -1070,36 +1112,37 @@ static void generate_random_testvec_config(struct testvec_config *cfg,
 		break;
 	}
 
-	if (!(cfg->req_flags & CRYPTO_TFM_REQ_MAY_SLEEP) &&
-	    prandom_u32_max(2) == 0) {
+	if (!(cfg->req_flags & CRYPTO_TFM_REQ_MAY_SLEEP) && prandom_bool(rng)) {
 		cfg->nosimd = true;
 		p += scnprintf(p, end - p, " nosimd");
 	}
 
 	p += scnprintf(p, end - p, " src_divs=[");
-	p = generate_random_sgl_divisions(cfg->src_divs,
+	p = generate_random_sgl_divisions(rng, cfg->src_divs,
 					  ARRAY_SIZE(cfg->src_divs), p, end,
 					  (cfg->finalization_type !=
 					   FINALIZATION_TYPE_DIGEST),
 					  cfg->req_flags);
 	p += scnprintf(p, end - p, "]");
 
-	if (cfg->inplace_mode == OUT_OF_PLACE && prandom_u32_max(2) == 0) {
+	if (cfg->inplace_mode == OUT_OF_PLACE && prandom_bool(rng)) {
 		p += scnprintf(p, end - p, " dst_divs=[");
-		p = generate_random_sgl_divisions(cfg->dst_divs,
+		p = generate_random_sgl_divisions(rng, cfg->dst_divs,
 						  ARRAY_SIZE(cfg->dst_divs),
 						  p, end, false,
 						  cfg->req_flags);
 		p += scnprintf(p, end - p, "]");
 	}
 
-	if (prandom_u32_max(2) == 0) {
-		cfg->iv_offset = 1 + prandom_u32_max(MAX_ALGAPI_ALIGNMASK);
+	if (prandom_bool(rng)) {
+		cfg->iv_offset = prandom_u32_inclusive(rng, 1,
+						       MAX_ALGAPI_ALIGNMASK);
 		p += scnprintf(p, end - p, " iv_offset=%u", cfg->iv_offset);
 	}
 
-	if (prandom_u32_max(2) == 0) {
-		cfg->key_offset = 1 + prandom_u32_max(MAX_ALGAPI_ALIGNMASK);
+	if (prandom_bool(rng)) {
+		cfg->key_offset = prandom_u32_inclusive(rng, 1,
+							MAX_ALGAPI_ALIGNMASK);
 		p += scnprintf(p, end - p, " key_offset=%u", cfg->key_offset);
 	}
 
@@ -1612,11 +1655,14 @@ static int test_hash_vec(const struct hash_testvec *vec, unsigned int vec_num,
 
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 	if (!noextratests) {
+		struct rnd_state rng;
 		struct testvec_config cfg;
 		char cfgname[TESTVEC_CONFIG_NAMELEN];
 
+		init_rnd_state(&rng);
+
 		for (i = 0; i < fuzz_iterations; i++) {
-			generate_random_testvec_config(&cfg, cfgname,
+			generate_random_testvec_config(&rng, &cfg, cfgname,
 						       sizeof(cfgname));
 			err = test_hash_vec_cfg(vec, vec_name, &cfg,
 						req, desc, tsgl, hashstate);
@@ -1634,15 +1680,16 @@ static int test_hash_vec(const struct hash_testvec *vec, unsigned int vec_num,
  * Generate a hash test vector from the given implementation.
  * Assumes the buffers in 'vec' were already allocated.
  */
-static void generate_random_hash_testvec(struct shash_desc *desc,
+static void generate_random_hash_testvec(struct rnd_state *rng,
+					 struct shash_desc *desc,
 					 struct hash_testvec *vec,
 					 unsigned int maxkeysize,
 					 unsigned int maxdatasize,
 					 char *name, size_t max_namelen)
 {
 	/* Data */
-	vec->psize = generate_random_length(maxdatasize);
-	generate_random_bytes((u8 *)vec->plaintext, vec->psize);
+	vec->psize = generate_random_length(rng, maxdatasize);
+	generate_random_bytes(rng, (u8 *)vec->plaintext, vec->psize);
 
 	/*
 	 * Key: length in range [1, maxkeysize], but usually choose maxkeysize.
@@ -1652,9 +1699,9 @@ static void generate_random_hash_testvec(struct shash_desc *desc,
 	vec->ksize = 0;
 	if (maxkeysize) {
 		vec->ksize = maxkeysize;
-		if (prandom_u32_max(4) == 0)
-			vec->ksize = 1 + prandom_u32_max(maxkeysize);
-		generate_random_bytes((u8 *)vec->key, vec->ksize);
+		if (prandom_u32_below(rng, 4) == 0)
+			vec->ksize = prandom_u32_inclusive(rng, 1, maxkeysize);
+		generate_random_bytes(rng, (u8 *)vec->key, vec->ksize);
 
 		vec->setkey_error = crypto_shash_setkey(desc->tfm, vec->key,
 							vec->ksize);
@@ -1688,6 +1735,7 @@ static int test_hash_vs_generic_impl(const char *generic_driver,
 	const unsigned int maxdatasize = (2 * PAGE_SIZE) - TESTMGR_POISON_LEN;
 	const char *algname = crypto_hash_alg_common(tfm)->base.cra_name;
 	const char *driver = crypto_ahash_driver_name(tfm);
+	struct rnd_state rng;
 	char _generic_driver[CRYPTO_MAX_ALG_NAME];
 	struct crypto_shash *generic_tfm = NULL;
 	struct shash_desc *generic_desc = NULL;
@@ -1701,6 +1749,8 @@ static int test_hash_vs_generic_impl(const char *generic_driver,
 	if (noextratests)
 		return 0;
 
+	init_rnd_state(&rng);
+
 	if (!generic_driver) { /* Use default naming convention? */
 		err = build_generic_driver_name(algname, _generic_driver);
 		if (err)
@@ -1769,10 +1819,11 @@ static int test_hash_vs_generic_impl(const char *generic_driver,
 	}
 
 	for (i = 0; i < fuzz_iterations * 8; i++) {
-		generate_random_hash_testvec(generic_desc, &vec,
+		generate_random_hash_testvec(&rng, generic_desc, &vec,
 					     maxkeysize, maxdatasize,
 					     vec_name, sizeof(vec_name));
-		generate_random_testvec_config(cfg, cfgname, sizeof(cfgname));
+		generate_random_testvec_config(&rng, cfg, cfgname,
+					       sizeof(cfgname));
 
 		err = test_hash_vec_cfg(&vec, vec_name, cfg,
 					req, desc, tsgl, hashstate);
@@ -2174,11 +2225,14 @@ static int test_aead_vec(int enc, const struct aead_testvec *vec,
 
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 	if (!noextratests) {
+		struct rnd_state rng;
 		struct testvec_config cfg;
 		char cfgname[TESTVEC_CONFIG_NAMELEN];
 
+		init_rnd_state(&rng);
+
 		for (i = 0; i < fuzz_iterations; i++) {
-			generate_random_testvec_config(&cfg, cfgname,
+			generate_random_testvec_config(&rng, &cfg, cfgname,
 						       sizeof(cfgname));
 			err = test_aead_vec_cfg(enc, vec, vec_name,
 						&cfg, req, tsgls);
@@ -2194,6 +2248,7 @@ static int test_aead_vec(int enc, const struct aead_testvec *vec,
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 
 struct aead_extra_tests_ctx {
+	struct rnd_state rng;
 	struct aead_request *req;
 	struct crypto_aead *tfm;
 	const struct alg_test_desc *test_desc;
@@ -2212,24 +2267,26 @@ struct aead_extra_tests_ctx {
  * here means the full ciphertext including the authentication tag.  The
  * authentication tag (and hence also the ciphertext) is assumed to be nonempty.
  */
-static void mutate_aead_message(struct aead_testvec *vec, bool aad_iv,
+static void mutate_aead_message(struct rnd_state *rng,
+				struct aead_testvec *vec, bool aad_iv,
 				unsigned int ivsize)
 {
 	const unsigned int aad_tail_size = aad_iv ? ivsize : 0;
 	const unsigned int authsize = vec->clen - vec->plen;
 
-	if (prandom_u32_max(2) == 0 && vec->alen > aad_tail_size) {
+	if (prandom_bool(rng) && vec->alen > aad_tail_size) {
 		 /* Mutate the AAD */
-		flip_random_bit((u8 *)vec->assoc, vec->alen - aad_tail_size);
-		if (prandom_u32_max(2) == 0)
+		flip_random_bit(rng, (u8 *)vec->assoc,
+				vec->alen - aad_tail_size);
+		if (prandom_bool(rng))
 			return;
 	}
-	if (prandom_u32_max(2) == 0) {
+	if (prandom_bool(rng)) {
 		/* Mutate auth tag (assuming it's at the end of ciphertext) */
-		flip_random_bit((u8 *)vec->ctext + vec->plen, authsize);
+		flip_random_bit(rng, (u8 *)vec->ctext + vec->plen, authsize);
 	} else {
 		/* Mutate any part of the ciphertext */
-		flip_random_bit((u8 *)vec->ctext, vec->clen);
+		flip_random_bit(rng, (u8 *)vec->ctext, vec->clen);
 	}
 }
 
@@ -2240,7 +2297,8 @@ static void mutate_aead_message(struct aead_testvec *vec, bool aad_iv,
  */
 #define MIN_COLLISION_FREE_AUTHSIZE 8
 
-static void generate_aead_message(struct aead_request *req,
+static void generate_aead_message(struct rnd_state *rng,
+				  struct aead_request *req,
 				  const struct aead_test_suite *suite,
 				  struct aead_testvec *vec,
 				  bool prefer_inauthentic)
@@ -2249,17 +2307,18 @@ static void generate_aead_message(struct aead_request *req,
 	const unsigned int ivsize = crypto_aead_ivsize(tfm);
 	const unsigned int authsize = vec->clen - vec->plen;
 	const bool inauthentic = (authsize >= MIN_COLLISION_FREE_AUTHSIZE) &&
-				 (prefer_inauthentic || prandom_u32_max(4) == 0);
+				 (prefer_inauthentic ||
+				  prandom_u32_below(rng, 4) == 0);
 
 	/* Generate the AAD. */
-	generate_random_bytes((u8 *)vec->assoc, vec->alen);
+	generate_random_bytes(rng, (u8 *)vec->assoc, vec->alen);
 	if (suite->aad_iv && vec->alen >= ivsize)
 		/* Avoid implementation-defined behavior. */
 		memcpy((u8 *)vec->assoc + vec->alen - ivsize, vec->iv, ivsize);
 
-	if (inauthentic && prandom_u32_max(2) == 0) {
+	if (inauthentic && prandom_bool(rng)) {
 		/* Generate a random ciphertext. */
-		generate_random_bytes((u8 *)vec->ctext, vec->clen);
+		generate_random_bytes(rng, (u8 *)vec->ctext, vec->clen);
 	} else {
 		int i = 0;
 		struct scatterlist src[2], dst;
@@ -2271,7 +2330,7 @@ static void generate_aead_message(struct aead_request *req,
 		if (vec->alen)
 			sg_set_buf(&src[i++], vec->assoc, vec->alen);
 		if (vec->plen) {
-			generate_random_bytes((u8 *)vec->ptext, vec->plen);
+			generate_random_bytes(rng, (u8 *)vec->ptext, vec->plen);
 			sg_set_buf(&src[i++], vec->ptext, vec->plen);
 		}
 		sg_init_one(&dst, vec->ctext, vec->alen + vec->clen);
@@ -2291,7 +2350,7 @@ static void generate_aead_message(struct aead_request *req,
 		 * Mutate the authentic (ciphertext, AAD) pair to get an
 		 * inauthentic one.
 		 */
-		mutate_aead_message(vec, suite->aad_iv, ivsize);
+		mutate_aead_message(rng, vec, suite->aad_iv, ivsize);
 	}
 	vec->novrfy = 1;
 	if (suite->einval_allowed)
@@ -2305,7 +2364,8 @@ static void generate_aead_message(struct aead_request *req,
  * If 'prefer_inauthentic' is true, then this function will generate inauthentic
  * test vectors (i.e. vectors with 'vec->novrfy=1') more often.
  */
-static void generate_random_aead_testvec(struct aead_request *req,
+static void generate_random_aead_testvec(struct rnd_state *rng,
+					 struct aead_request *req,
 					 struct aead_testvec *vec,
 					 const struct aead_test_suite *suite,
 					 unsigned int maxkeysize,
@@ -2321,18 +2381,18 @@ static void generate_random_aead_testvec(struct aead_request *req,
 
 	/* Key: length in [0, maxkeysize], but usually choose maxkeysize */
 	vec->klen = maxkeysize;
-	if (prandom_u32_max(4) == 0)
-		vec->klen = prandom_u32_max(maxkeysize + 1);
-	generate_random_bytes((u8 *)vec->key, vec->klen);
+	if (prandom_u32_below(rng, 4) == 0)
+		vec->klen = prandom_u32_below(rng, maxkeysize + 1);
+	generate_random_bytes(rng, (u8 *)vec->key, vec->klen);
 	vec->setkey_error = crypto_aead_setkey(tfm, vec->key, vec->klen);
 
 	/* IV */
-	generate_random_bytes((u8 *)vec->iv, ivsize);
+	generate_random_bytes(rng, (u8 *)vec->iv, ivsize);
 
 	/* Tag length: in [0, maxauthsize], but usually choose maxauthsize */
 	authsize = maxauthsize;
-	if (prandom_u32_max(4) == 0)
-		authsize = prandom_u32_max(maxauthsize + 1);
+	if (prandom_u32_below(rng, 4) == 0)
+		authsize = prandom_u32_below(rng, maxauthsize + 1);
 	if (prefer_inauthentic && authsize < MIN_COLLISION_FREE_AUTHSIZE)
 		authsize = MIN_COLLISION_FREE_AUTHSIZE;
 	if (WARN_ON(authsize > maxdatasize))
@@ -2341,11 +2401,11 @@ static void generate_random_aead_testvec(struct aead_request *req,
 	vec->setauthsize_error = crypto_aead_setauthsize(tfm, authsize);
 
 	/* AAD, plaintext, and ciphertext lengths */
-	total_len = generate_random_length(maxdatasize);
-	if (prandom_u32_max(4) == 0)
+	total_len = generate_random_length(rng, maxdatasize);
+	if (prandom_u32_below(rng, 4) == 0)
 		vec->alen = 0;
 	else
-		vec->alen = generate_random_length(total_len);
+		vec->alen = generate_random_length(rng, total_len);
 	vec->plen = total_len - vec->alen;
 	vec->clen = vec->plen + authsize;
 
@@ -2356,7 +2416,7 @@ static void generate_random_aead_testvec(struct aead_request *req,
 	vec->novrfy = 0;
 	vec->crypt_error = 0;
 	if (vec->setkey_error == 0 && vec->setauthsize_error == 0)
-		generate_aead_message(req, suite, vec, prefer_inauthentic);
+		generate_aead_message(rng, req, suite, vec, prefer_inauthentic);
 	snprintf(name, max_namelen,
 		 "\"random: alen=%u plen=%u authsize=%u klen=%u novrfy=%d\"",
 		 vec->alen, vec->plen, authsize, vec->klen, vec->novrfy);
@@ -2368,7 +2428,7 @@ static void try_to_generate_inauthentic_testvec(
 	int i;
 
 	for (i = 0; i < 10; i++) {
-		generate_random_aead_testvec(ctx->req, &ctx->vec,
+		generate_random_aead_testvec(&ctx->rng, ctx->req, &ctx->vec,
 					     &ctx->test_desc->suite.aead,
 					     ctx->maxkeysize, ctx->maxdatasize,
 					     ctx->vec_name,
@@ -2399,7 +2459,8 @@ static int test_aead_inauthentic_inputs(struct aead_extra_tests_ctx *ctx)
 		 */
 		try_to_generate_inauthentic_testvec(ctx);
 		if (ctx->vec.novrfy) {
-			generate_random_testvec_config(&ctx->cfg, ctx->cfgname,
+			generate_random_testvec_config(&ctx->rng, &ctx->cfg,
+						       ctx->cfgname,
 						       sizeof(ctx->cfgname));
 			err = test_aead_vec_cfg(DECRYPT, &ctx->vec,
 						ctx->vec_name, &ctx->cfg,
@@ -2489,12 +2550,13 @@ static int test_aead_vs_generic_impl(struct aead_extra_tests_ctx *ctx)
 	 * the other implementation against them.
 	 */
 	for (i = 0; i < fuzz_iterations * 8; i++) {
-		generate_random_aead_testvec(generic_req, &ctx->vec,
+		generate_random_aead_testvec(&ctx->rng, generic_req, &ctx->vec,
 					     &ctx->test_desc->suite.aead,
 					     ctx->maxkeysize, ctx->maxdatasize,
 					     ctx->vec_name,
 					     sizeof(ctx->vec_name), false);
-		generate_random_testvec_config(&ctx->cfg, ctx->cfgname,
+		generate_random_testvec_config(&ctx->rng, &ctx->cfg,
+					       ctx->cfgname,
 					       sizeof(ctx->cfgname));
 		if (!ctx->vec.novrfy) {
 			err = test_aead_vec_cfg(ENCRYPT, &ctx->vec,
@@ -2533,6 +2595,7 @@ static int test_aead_extra(const struct alg_test_desc *test_desc,
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
+	init_rnd_state(&ctx->rng);
 	ctx->req = req;
 	ctx->tfm = crypto_aead_reqtfm(req);
 	ctx->test_desc = test_desc;
@@ -2922,11 +2985,14 @@ static int test_skcipher_vec(int enc, const struct cipher_testvec *vec,
 
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 	if (!noextratests) {
+		struct rnd_state rng;
 		struct testvec_config cfg;
 		char cfgname[TESTVEC_CONFIG_NAMELEN];
 
+		init_rnd_state(&rng);
+
 		for (i = 0; i < fuzz_iterations; i++) {
-			generate_random_testvec_config(&cfg, cfgname,
+			generate_random_testvec_config(&rng, &cfg, cfgname,
 						       sizeof(cfgname));
 			err = test_skcipher_vec_cfg(enc, vec, vec_name,
 						    &cfg, req, tsgls);
@@ -2944,7 +3010,8 @@ static int test_skcipher_vec(int enc, const struct cipher_testvec *vec,
  * Generate a symmetric cipher test vector from the given implementation.
  * Assumes the buffers in 'vec' were already allocated.
  */
-static void generate_random_cipher_testvec(struct skcipher_request *req,
+static void generate_random_cipher_testvec(struct rnd_state *rng,
+					   struct skcipher_request *req,
 					   struct cipher_testvec *vec,
 					   unsigned int maxdatasize,
 					   char *name, size_t max_namelen)
@@ -2958,17 +3025,17 @@ static void generate_random_cipher_testvec(struct skcipher_request *req,
 
 	/* Key: length in [0, maxkeysize], but usually choose maxkeysize */
 	vec->klen = maxkeysize;
-	if (prandom_u32_max(4) == 0)
-		vec->klen = prandom_u32_max(maxkeysize + 1);
-	generate_random_bytes((u8 *)vec->key, vec->klen);
+	if (prandom_u32_below(rng, 4) == 0)
+		vec->klen = prandom_u32_below(rng, maxkeysize + 1);
+	generate_random_bytes(rng, (u8 *)vec->key, vec->klen);
 	vec->setkey_error = crypto_skcipher_setkey(tfm, vec->key, vec->klen);
 
 	/* IV */
-	generate_random_bytes((u8 *)vec->iv, ivsize);
+	generate_random_bytes(rng, (u8 *)vec->iv, ivsize);
 
 	/* Plaintext */
-	vec->len = generate_random_length(maxdatasize);
-	generate_random_bytes((u8 *)vec->ptext, vec->len);
+	vec->len = generate_random_length(rng, maxdatasize);
+	generate_random_bytes(rng, (u8 *)vec->ptext, vec->len);
 
 	/* If the key couldn't be set, no need to continue to encrypt. */
 	if (vec->setkey_error)
@@ -3010,6 +3077,7 @@ static int test_skcipher_vs_generic_impl(const char *generic_driver,
 	const unsigned int maxdatasize = (2 * PAGE_SIZE) - TESTMGR_POISON_LEN;
 	const char *algname = crypto_skcipher_alg(tfm)->base.cra_name;
 	const char *driver = crypto_skcipher_driver_name(tfm);
+	struct rnd_state rng;
 	char _generic_driver[CRYPTO_MAX_ALG_NAME];
 	struct crypto_skcipher *generic_tfm = NULL;
 	struct skcipher_request *generic_req = NULL;
@@ -3027,6 +3095,8 @@ static int test_skcipher_vs_generic_impl(const char *generic_driver,
 	if (strncmp(algname, "kw(", 3) == 0)
 		return 0;
 
+	init_rnd_state(&rng);
+
 	if (!generic_driver) { /* Use default naming convention? */
 		err = build_generic_driver_name(algname, _generic_driver);
 		if (err)
@@ -3111,9 +3181,11 @@ static int test_skcipher_vs_generic_impl(const char *generic_driver,
 	}
 
 	for (i = 0; i < fuzz_iterations * 8; i++) {
-		generate_random_cipher_testvec(generic_req, &vec, maxdatasize,
+		generate_random_cipher_testvec(&rng, generic_req, &vec,
+					       maxdatasize,
 					       vec_name, sizeof(vec_name));
-		generate_random_testvec_config(cfg, cfgname, sizeof(cfgname));
+		generate_random_testvec_config(&rng, cfg, cfgname,
+					       sizeof(cfgname));
 
 		err = test_skcipher_vec_cfg(ENCRYPT, &vec, vec_name,
 					    cfg, req, tsgls);
diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 3bbe2276cac7..80f945cbec8a 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -83,6 +83,8 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (!acpi_dev_get_property(adev, "clk-name", ACPI_TYPE_STRING, &obj)) {
 		clk_data->name = devm_kzalloc(&adev->dev, obj->string.length,
 					      GFP_KERNEL);
+		if (!clk_data->name)
+			return -ENOMEM;
 
 		strcpy(clk_data->name, obj->string.pointer);
 	} else {
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 3615e1a6efd8..b91155ea9c34 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -652,6 +652,9 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
 		object_info =
 		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
 
+		if (!object_info)
+			return (AE_NO_MEMORY);
+
 		/* Walk the namespace from the root */
 
 		(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 0aa735d3b93c..77076da2029d 100644
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
index 9751b84c1b22..ee4c812c8f6c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1121,6 +1121,7 @@ static void acpi_ec_remove_query_handlers(struct acpi_ec *ec,
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	acpi_ec_remove_query_handlers(ec, false, query_bit);
+	flush_workqueue(ec_query_wq);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0556c4720d3f..b6d429a2bcb6 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -130,12 +130,6 @@ static int video_detect_force_native(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int video_detect_force_none(const struct dmi_system_id *d)
-{
-	acpi_backlight_dmi = acpi_backlight_none;
-	return 0;
-}
-
 static const struct dmi_system_id video_detect_dmi_table[] = {
 	/*
 	 * Models which should use the vendor backlight interface,
@@ -752,35 +746,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
 		},
 	},
-
-	/*
-	 * Desktops which falsely report a backlight and which our heuristics
-	 * for this do not catch.
-	 */
-	{
-	 .callback = video_detect_force_none,
-	 /* Dell OptiPlex 9020M */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M"),
-		},
-	},
-	{
-	 .callback = video_detect_force_none,
-	 /* GIGABYTE GB-BXBT-2807 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
-		},
-	},
-	{
-	 .callback = video_detect_force_none,
-	 /* MSI MS-7721 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "MSI"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "MS-7721"),
-		},
-	},
 	{ },
 };
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 51bb2289865c..3a06c214ca1c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1416,7 +1416,9 @@ static void platform_remove(struct device *_dev)
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 
-	if (drv->remove) {
+	if (drv->remove_new) {
+		drv->remove_new(dev);
+	} else if (drv->remove) {
 		int ret = drv->remove(dev);
 
 		if (ret)
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 362e043e26d8..8031007b4887 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -349,6 +349,9 @@ int regcache_sync(struct regmap *map)
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
@@ -418,6 +421,9 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e379ccc63c52..888a6abb50f5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -325,6 +325,9 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	if (blk_validate_block_size(blksize))
 		return -EINVAL;
 
+	if (bytesize < 0)
+		return -EINVAL;
+
 	nbd->config->bytesize = bytesize;
 	nbd->config->blksize_bits = __ffs(blksize);
 
@@ -1110,6 +1113,9 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct nbd_sock *nsock;
 	int err;
 
+	/* Arg will be cast to int, check it to avoid overflow */
+	if (arg > INT_MAX)
+		return -EINVAL;
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index af419af9a0f4..c45d09a9a942 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1945,6 +1945,11 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 
 static int null_validate_conf(struct nullb_device *dev)
 {
+	if (dev->queue_mode == NULL_Q_RQ) {
+		pr_err("legacy IO path is no longer available\n");
+		return -EINVAL;
+	}
+
 	dev->blocksize = round_down(dev->blocksize, 512);
 	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
 
diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 43e98a598bd9..de2ea589aa49 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2015  Intel Corporation
  */
 
+#include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/dmi.h>
@@ -34,6 +35,43 @@
 /* For kmalloc-ing the fw-name array instead of putting it on the stack */
 typedef char bcm_fw_name[BCM_FW_NAME_LEN];
 
+#ifdef CONFIG_EFI
+static int btbcm_set_bdaddr_from_efi(struct hci_dev *hdev)
+{
+	efi_guid_t guid = EFI_GUID(0x74b00bd9, 0x805a, 0x4d61, 0xb5, 0x1f,
+				   0x43, 0x26, 0x81, 0x23, 0xd1, 0x13);
+	bdaddr_t efi_bdaddr, bdaddr;
+	efi_status_t status;
+	unsigned long len;
+	int ret;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return -EOPNOTSUPP;
+
+	len = sizeof(efi_bdaddr);
+	status = efi.get_variable(L"BDADDR", &guid, NULL, &len, &efi_bdaddr);
+	if (status != EFI_SUCCESS)
+		return -ENXIO;
+
+	if (len != sizeof(efi_bdaddr))
+		return -EIO;
+
+	baswap(&bdaddr, &efi_bdaddr);
+
+	ret = btbcm_set_bdaddr(hdev, &bdaddr);
+	if (ret)
+		return ret;
+
+	bt_dev_info(hdev, "BCM: Using EFI device address (%pMR)", &bdaddr);
+	return 0;
+}
+#else
+static int btbcm_set_bdaddr_from_efi(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -87,9 +125,12 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
-		bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
-			    &bda->bdaddr);
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		/* Try falling back to BDADDR EFI variable */
+		if (btbcm_set_bdaddr_from_efi(hdev) != 0) {
+			bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
+				    &bda->bdaddr);
+			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		}
 	}
 
 	kfree_skb(skb);
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index f6b4b7a1be4c..bbad1207cdfd 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2553,9 +2553,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
-		/* Valid LE States quirk for GfP */
-		if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
-			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+		/* Apply LE States quirk from solar onwards */
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev,
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index fb52313a1d45..ead632595ce0 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -17,19 +17,25 @@
 
 #define VERSION "0.1"
 
+#define RTL_CHIP_8723CS_CG	3
+#define RTL_CHIP_8723CS_VF	4
+#define RTL_CHIP_8723CS_XX	5
 #define RTL_EPATCH_SIGNATURE	"Realtech"
+#define RTL_ROM_LMP_8703B	0x8703
 #define RTL_ROM_LMP_8723A	0x1200
 #define RTL_ROM_LMP_8723B	0x8723
 #define RTL_ROM_LMP_8821A	0x8821
 #define RTL_ROM_LMP_8761A	0x8761
 #define RTL_ROM_LMP_8822B	0x8822
 #define RTL_ROM_LMP_8852A	0x8852
+#define RTL_ROM_LMP_8851B	0x8851
 #define RTL_CONFIG_MAGIC	0x8723ab55
 
 #define IC_MATCH_FL_LMPSUBV	(1 << 0)
 #define IC_MATCH_FL_HCIREV	(1 << 1)
 #define IC_MATCH_FL_HCIVER	(1 << 2)
 #define IC_MATCH_FL_HCIBUS	(1 << 3)
+#define IC_MATCH_FL_CHIP_TYPE	(1 << 4)
 #define IC_INFO(lmps, hcir, hciv, bus) \
 	.match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV | \
 		       IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS, \
@@ -51,6 +57,7 @@ enum btrtl_chip_id {
 	CHIP_ID_8852A = 18,
 	CHIP_ID_8852B = 20,
 	CHIP_ID_8852C = 25,
+	CHIP_ID_8851B = 36,
 };
 
 struct id_table {
@@ -59,6 +66,7 @@ struct id_table {
 	__u16 hci_rev;
 	__u8 hci_ver;
 	__u8 hci_bus;
+	__u8 chip_type;
 	bool config_needed;
 	bool has_rom_version;
 	bool has_msft_ext;
@@ -99,6 +107,39 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8723b_config" },
 
+	/* 8723CS-CG */
+	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_CHIP_TYPE |
+			 IC_MATCH_FL_HCIBUS,
+	  .lmp_subver = RTL_ROM_LMP_8703B,
+	  .chip_type = RTL_CHIP_8723CS_CG,
+	  .hci_bus = HCI_UART,
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8723cs_cg_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723cs_cg_config" },
+
+	/* 8723CS-VF */
+	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_CHIP_TYPE |
+			 IC_MATCH_FL_HCIBUS,
+	  .lmp_subver = RTL_ROM_LMP_8703B,
+	  .chip_type = RTL_CHIP_8723CS_VF,
+	  .hci_bus = HCI_UART,
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8723cs_vf_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723cs_vf_config" },
+
+	/* 8723CS-XX */
+	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_CHIP_TYPE |
+			 IC_MATCH_FL_HCIBUS,
+	  .lmp_subver = RTL_ROM_LMP_8703B,
+	  .chip_type = RTL_CHIP_8723CS_XX,
+	  .hci_bus = HCI_UART,
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8723cs_xx_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723cs_xx_config" },
+
 	/* 8723D */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
 	  .config_needed = true,
@@ -205,10 +246,19 @@ static const struct id_table ic_id_table[] = {
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8852cu_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8852cu_config" },
+
+	/* 8851B */
+	{ IC_INFO(RTL_ROM_LMP_8851B, 0xb, 0xc, HCI_USB),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .has_msft_ext = false,
+	  .fw_name  = "rtl_bt/rtl8851bu_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8851bu_config" },
 	};
 
 static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
-					     u8 hci_ver, u8 hci_bus)
+					     u8 hci_ver, u8 hci_bus,
+					     u8 chip_type)
 {
 	int i;
 
@@ -225,6 +275,9 @@ static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
 		if ((ic_id_table[i].match_flags & IC_MATCH_FL_HCIBUS) &&
 		    (ic_id_table[i].hci_bus != hci_bus))
 			continue;
+		if ((ic_id_table[i].match_flags & IC_MATCH_FL_CHIP_TYPE) &&
+		    (ic_id_table[i].chip_type != chip_type))
+			continue;
 
 		break;
 	}
@@ -307,6 +360,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		{ RTL_ROM_LMP_8723B, 1 },
 		{ RTL_ROM_LMP_8821A, 2 },
 		{ RTL_ROM_LMP_8761A, 3 },
+		{ RTL_ROM_LMP_8703B, 7 },
 		{ RTL_ROM_LMP_8822B, 8 },
 		{ RTL_ROM_LMP_8723B, 9 },	/* 8723D */
 		{ RTL_ROM_LMP_8821A, 10 },	/* 8821C */
@@ -315,6 +369,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		{ RTL_ROM_LMP_8852A, 18 },	/* 8852A */
 		{ RTL_ROM_LMP_8852A, 20 },	/* 8852B */
 		{ RTL_ROM_LMP_8852A, 25 },	/* 8852C */
+		{ RTL_ROM_LMP_8851B, 36 },	/* 8851B */
 	};
 
 	min_size = sizeof(struct rtl_epatch_header) + sizeof(extension_sig) + 3;
@@ -587,6 +642,48 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 	return ret;
 }
 
+static bool rtl_has_chip_type(u16 lmp_subver)
+{
+	switch (lmp_subver) {
+	case RTL_ROM_LMP_8703B:
+		return true;
+	default:
+		break;
+	}
+
+	return  false;
+}
+
+static int rtl_read_chip_type(struct hci_dev *hdev, u8 *type)
+{
+	struct rtl_chip_type_evt *chip_type;
+	struct sk_buff *skb;
+	const unsigned char cmd_buf[] = {0x00, 0x94, 0xa0, 0x00, 0xb0};
+
+	/* Read RTL chip type command */
+	skb = __hci_cmd_sync(hdev, 0xfc61, 5, cmd_buf, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		rtl_dev_err(hdev, "Read chip type failed (%ld)",
+			    PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	chip_type = skb_pull_data(skb, sizeof(*chip_type));
+	if (!chip_type) {
+		rtl_dev_err(hdev, "RTL chip type event length mismatch");
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	rtl_dev_info(hdev, "chip_type status=%x type=%x",
+		     chip_type->status, chip_type->type);
+
+	*type = chip_type->type & 0x0f;
+
+	kfree_skb(skb);
+	return 0;
+}
+
 void btrtl_free(struct btrtl_device_info *btrtl_dev)
 {
 	kvfree(btrtl_dev->fw_data);
@@ -603,7 +700,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	struct hci_rp_read_local_version *resp;
 	char cfg_name[40];
 	u16 hci_rev, lmp_subver;
-	u8 hci_ver;
+	u8 hci_ver, chip_type = 0;
 	int ret;
 	u16 opcode;
 	u8 cmd[2];
@@ -629,8 +726,14 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	hci_rev = le16_to_cpu(resp->hci_rev);
 	lmp_subver = le16_to_cpu(resp->lmp_subver);
 
+	if (rtl_has_chip_type(lmp_subver)) {
+		ret = rtl_read_chip_type(hdev, &chip_type);
+		if (ret)
+			goto err_free;
+	}
+
 	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
-					    hdev->bus);
+					    hdev->bus, chip_type);
 
 	if (!btrtl_dev->ic_info)
 		btrtl_dev->drop_fw = true;
@@ -673,7 +776,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		lmp_subver = le16_to_cpu(resp->lmp_subver);
 
 		btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
-						    hdev->bus);
+						    hdev->bus, chip_type);
 	}
 out_free:
 	kfree_skb(skb);
@@ -755,6 +858,8 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	case RTL_ROM_LMP_8761A:
 	case RTL_ROM_LMP_8822B:
 	case RTL_ROM_LMP_8852A:
+	case RTL_ROM_LMP_8703B:
+	case RTL_ROM_LMP_8851B:
 		return btrtl_setup_rtl8723b(hdev, btrtl_dev);
 	default:
 		rtl_dev_info(hdev, "assuming no firmware upload needed");
@@ -779,6 +884,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8852A:
 	case CHIP_ID_8852B:
 	case CHIP_ID_8852C:
+	case CHIP_ID_8851B:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 		hci_set_aosp_capable(hdev);
@@ -788,6 +894,22 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 		rtl_dev_dbg(hdev, "WBS supported not enabled.");
 		break;
 	}
+
+	if (!btrtl_dev->ic_info)
+		return;
+
+	switch (btrtl_dev->ic_info->lmp_subver) {
+	case RTL_ROM_LMP_8703B:
+		/* 8723CS reports two pages for local ext features,
+		 * but it doesn't support any features from page 2 -
+		 * it either responds with garbage or with error status
+		 */
+		set_bit(HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2,
+			&hdev->quirks);
+		break;
+	default:
+		break;
+	}
 }
 EXPORT_SYMBOL_GPL(btrtl_set_quirks);
 
@@ -946,6 +1068,12 @@ MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723bs_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723bs_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_cg_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_cg_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_vf_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_vf_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_xx_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_xx_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
@@ -960,3 +1088,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8851bu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8851bu_config.bin");
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 2c441bda390a..1c6282241d2d 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -14,6 +14,11 @@
 
 struct btrtl_device_info;
 
+struct rtl_chip_type_evt {
+	__u8 status;
+	__u8 type;
+} __packed;
+
 struct rtl_download_cmd {
 	__u8 index;
 	__u8 data[RTL_FRAG_LEN];
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 90b85dcb138d..faad19b396d5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -549,6 +549,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x043e, 0x310c), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3801), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional MediaTek MT7668 Bluetooth devices */
 	{ USB_DEVICE(0x043e, 0x3109), .driver_info = BTUSB_MEDIATEK |
@@ -4016,6 +4019,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_ACTIONS_SEMI) {
 		/* Support is advertised, but not implemented */
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 	}
 
 	if (!reset)
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 6455bc4fb5bb..e90670955df2 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -936,6 +936,8 @@ static int h5_btrtl_setup(struct h5 *h5)
 	err = btrtl_download_firmware(h5->hu->hdev, btrtl_dev);
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
+	if (err)
+		goto out_free;
 
 	btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
 
@@ -1100,6 +1102,8 @@ static const struct of_device_id rtl_bluetooth_of_match[] = {
 	  .data = (const void *)&h5_data_rtl8822cs },
 	{ .compatible = "realtek,rtl8723bs-bt",
 	  .data = (const void *)&h5_data_rtl8723bs },
+	{ .compatible = "realtek,rtl8723cs-bt",
+	  .data = (const void *)&h5_data_rtl8723bs },
 	{ .compatible = "realtek,rtl8723ds-bt",
 	  .data = (const void *)&h5_data_rtl8723bs },
 #endif
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index ed5dabd3c72d..4be19d8f3ca9 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -83,6 +83,22 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
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
 
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1e1a51510e83..f9040bd61081 100644
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
@@ -301,8 +303,6 @@ int sdei_mask_local_cpu(void)
 {
 	int err;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PE_MASK, 0, 0, 0, 0, 0, NULL);
 	if (err && err != -EIO) {
 		pr_warn_once("failed to mask CPU[%u]: %d\n",
@@ -315,6 +315,7 @@ int sdei_mask_local_cpu(void)
 
 static void _ipi_mask_cpu(void *ignored)
 {
+	WARN_ON_ONCE(preemptible());
 	sdei_mask_local_cpu();
 }
 
@@ -322,8 +323,6 @@ int sdei_unmask_local_cpu(void)
 {
 	int err;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PE_UNMASK, 0, 0, 0, 0, 0, NULL);
 	if (err && err != -EIO) {
 		pr_warn_once("failed to unmask CPU[%u]: %d\n",
@@ -336,6 +335,7 @@ int sdei_unmask_local_cpu(void)
 
 static void _ipi_unmask_cpu(void *ignored)
 {
+	WARN_ON_ONCE(preemptible());
 	sdei_unmask_local_cpu();
 }
 
@@ -343,6 +343,8 @@ static void _ipi_private_reset(void *ignored)
 {
 	int err;
 
+	WARN_ON_ONCE(preemptible());
+
 	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PRIVATE_RESET, 0, 0, 0, 0, 0,
 			     NULL);
 	if (err && err != -EIO)
@@ -389,8 +391,6 @@ static void _local_event_enable(void *data)
 	int err;
 	struct sdei_crosscall_args *arg = data;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = sdei_api_event_enable(arg->event->event_num);
 
 	sdei_cross_call_return(arg, err);
@@ -479,8 +479,6 @@ static void _local_event_unregister(void *data)
 	int err;
 	struct sdei_crosscall_args *arg = data;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = sdei_api_event_unregister(arg->event->event_num);
 
 	sdei_cross_call_return(arg, err);
@@ -561,8 +559,6 @@ static void _local_event_register(void *data)
 	struct sdei_registered_event *reg;
 	struct sdei_crosscall_args *arg = data;
 
-	WARN_ON(preemptible());
-
 	reg = per_cpu_ptr(arg->event->private_registered, smp_processor_id());
 	err = sdei_api_event_register(arg->event->event_num, sdei_entry_point,
 				      reg, 0, 0);
@@ -717,6 +713,8 @@ static int sdei_pm_notifier(struct notifier_block *nb, unsigned long action,
 {
 	int rv;
 
+	WARN_ON_ONCE(preemptible());
+
 	switch (action) {
 	case CPU_PM_ENTER:
 		rv = sdei_mask_local_cpu();
@@ -765,7 +763,7 @@ static int sdei_device_freeze(struct device *dev)
 	int err;
 
 	/* unregister private events */
-	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
+	cpuhp_remove_state(sdei_entry_point);
 
 	err = sdei_unregister_shared();
 	if (err)
@@ -786,12 +784,15 @@ static int sdei_device_thaw(struct device *dev)
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
@@ -823,7 +824,7 @@ static int sdei_reboot_notifier(struct notifier_block *nb, unsigned long action,
 	 * We are going to reset the interface, after this there is no point
 	 * doing work when we take CPUs offline.
 	 */
-	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
+	cpuhp_remove_state(sdei_hp_state);
 
 	sdei_platform_reset();
 
@@ -1003,13 +1004,15 @@ static int sdei_probe(struct platform_device *pdev)
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
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index 60ccf3e90d7d..db818f9dcb8e 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -17,9 +17,13 @@ static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
 
 bool __ro_after_init smccc_trng_available = false;
 u64 __ro_after_init smccc_has_sve_hint = false;
+s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
+s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
 
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 {
+	struct arm_smccc_res res;
+
 	smccc_version = version;
 	smccc_conduit = conduit;
 
@@ -27,6 +31,18 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    smccc_version >= ARM_SMCCC_VERSION_1_3)
 		smccc_has_sve_hint = true;
+
+	if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
+	    (smccc_conduit != SMCCC_CONDUIT_NONE)) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				     ARM_SMCCC_ARCH_SOC_ID, &res);
+		if ((s32)res.a0 >= 0) {
+			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
+			smccc_soc_id_version = (s32)res.a0;
+			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
+			smccc_soc_id_revision = (s32)res.a0;
+		}
+	}
 }
 
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
@@ -44,6 +60,16 @@ u32 arm_smccc_get_version(void)
 }
 EXPORT_SYMBOL_GPL(arm_smccc_get_version);
 
+s32 arm_smccc_get_soc_id_version(void)
+{
+	return smccc_soc_id_version;
+}
+
+s32 arm_smccc_get_soc_id_revision(void)
+{
+	return smccc_soc_id_revision;
+}
+
 static int __init smccc_devices_init(void)
 {
 	struct platform_device *pdev;
diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
index dd7c3d5e8b0b..890eb454599a 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -42,41 +42,23 @@ static int __init smccc_soc_init(void)
 	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
 		return 0;
 
-	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
-		pr_err("%s: invalid SMCCC conduit\n", __func__);
-		return -EOPNOTSUPP;
-	}
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-			     ARM_SMCCC_ARCH_SOC_ID, &res);
-
-	if ((int)res.a0 == SMCCC_RET_NOT_SUPPORTED) {
+	soc_id_version = arm_smccc_get_soc_id_version();
+	if (soc_id_version == SMCCC_RET_NOT_SUPPORTED) {
 		pr_info("ARCH_SOC_ID not implemented, skipping ....\n");
 		return 0;
 	}
 
-	if ((int)res.a0 < 0) {
-		pr_info("ARCH_FEATURES(ARCH_SOC_ID) returned error: %lx\n",
-			res.a0);
-		return -EINVAL;
-	}
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
-	if ((int)res.a0 < 0) {
+	if (soc_id_version < 0) {
 		pr_err("ARCH_SOC_ID(0) returned error: %lx\n", res.a0);
 		return -EINVAL;
 	}
 
-	soc_id_version = res.a0;
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
-	if ((int)res.a0 < 0) {
+	soc_id_rev = arm_smccc_get_soc_id_revision();
+	if (soc_id_rev < 0) {
 		pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
 		return -EINVAL;
 	}
 
-	soc_id_rev = res.a0;
-
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 3380daf42da8..b803e785d3af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -683,9 +683,11 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 		if (r)
 			return r;
 
-		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
-		if (r)
-			goto late_fini;
+		if (adev->gfx.cp_ecc_error_irq.funcs) {
+			r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
+			if (r)
+				goto late_fini;
+		}
 	} else {
 		amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 82e27bd4f038..7e8b7171068d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1432,13 +1432,31 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 	struct amdgpu_firmware_info *info;
 	char ucode_prefix[30];
 	char fw_name[40];
+	bool need_retry = false;
 	int r;
 
-	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
-		ucode_prefix,
-		pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
+				       sizeof(ucode_prefix));
+	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) {
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
+			 ucode_prefix,
+			 pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
+		need_retry = true;
+	} else {
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
+			 ucode_prefix,
+			 pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
+	}
+
 	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
+	if (r && need_retry && pipe == AMDGPU_MES_SCHED_PIPE) {
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
+			 ucode_prefix);
+		DRM_INFO("try to fall back to %s\n", fw_name);
+		r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
+					 fw_name);
+	}
+
 	if (r)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index af94ac580d3e..2127aab74a68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8236,8 +8236,14 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 7):
+		if (!enable)
+			amdgpu_gfx_off_ctrl(adev, false);
+
 		gfx_v10_cntl_pg(adev, enable);
-		amdgpu_gfx_off_ctrl(adev, enable);
+
+		if (enable)
+			amdgpu_gfx_off_ctrl(adev, true);
+
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0dd2fe4f071e..bc65fc1350f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4641,13 +4641,29 @@ static int gfx_v11_0_post_soft_reset(void *handle)
 static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
+	uint64_t clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
+
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		mutex_lock(&adev->gfx.gpu_clock_mutex);
+		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
+		clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+		clock_counter_hi_after = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
+		if (clock_counter_hi_pre != clock_counter_hi_after)
+			clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+		mutex_unlock(&adev->gfx.gpu_clock_mutex);
+		amdgpu_gfx_off_ctrl(adev, true);
+	} else {
+		preempt_disable();
+		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+		clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+		clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+		if (clock_counter_hi_pre != clock_counter_hi_after)
+			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+		preempt_enable();
+	}
+	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
 
-	amdgpu_gfx_off_ctrl(adev, false);
-	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	clock = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER) |
-		((uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER) << 32ULL);
-	mutex_unlock(&adev->gfx.gpu_clock_mutex);
-	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
 }
 
@@ -5085,8 +5101,14 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
+		if (!enable)
+			amdgpu_gfx_off_ctrl(adev, false);
+
 		gfx_v11_cntl_pg(adev, enable);
-		amdgpu_gfx_off_ctrl(adev, enable);
+
+		if (enable)
+			amdgpu_gfx_off_ctrl(adev, true);
+
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 2d11e8e7e123..7124347d2b6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -31,6 +31,8 @@
 #include "umc_v8_10.h"
 #include "athub/athub_3_0_0_sh_mask.h"
 #include "athub/athub_3_0_0_offset.h"
+#include "dcn/dcn_3_2_0_offset.h"
+#include "dcn/dcn_3_2_0_sh_mask.h"
 #include "oss/osssys_6_0_0_offset.h"
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 #include "navi10_enum.h"
@@ -523,7 +525,24 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 
 static unsigned gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
-	return 0;
+	u32 d1vga_control = RREG32_SOC15(DCE, 0, regD1VGA_CONTROL);
+	unsigned size;
+
+	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
+	} else {
+		u32 viewport;
+		u32 pitch;
+
+		viewport = RREG32_SOC15(DCE, 0, regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
+		pitch = RREG32_SOC15(DCE, 0, regHUBPREQ0_DCSURF_SURFACE_PITCH);
+		size = (REG_GET_FIELD(viewport,
+					HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
+				REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
+				4);
+	}
+
+	return size;
 }
 
 static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e3168149ca8f..08766b678436 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -33,13 +33,20 @@
 #include "mes_v11_api_def.h"
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
 
 static int mes_v11_0_hw_fini(void *handle);
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 77d5a6f30409..5b251d009467 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1908,7 +1908,7 @@ static int sdma_v4_0_sw_fini(void *handle)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
 
-	if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 0) ||
+	if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) ||
             adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 4, 0))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 074e70a5c458..e507d2e1410b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -516,11 +516,8 @@ static enum bp_result get_gpio_i2c_info(
 	info->i2c_slave_address = record->i2c_slave_addr;
 
 	/* TODO: check how to get register offset for en, Y, etc. */
-	info->gpio_info.clk_a_register_index =
-			le16_to_cpu(
-			header->gpio_pin[table_index].data_a_reg_index);
-	info->gpio_info.clk_a_shift =
-			header->gpio_pin[table_index].gpio_bitshift;
+	info->gpio_info.clk_a_register_index = le16_to_cpu(pin->data_a_reg_index);
+	info->gpio_info.clk_a_shift = pin->gpio_bitshift;
 
 	return BP_RESULT_OK;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0541e87e4f38..a461e9463534 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -764,7 +764,8 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 					!pipe->top_pipe && !pipe->prev_odm_pipe &&
 					pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				populate_subvp_cmd_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
-			} else if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_NONE) {
+			} else if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_NONE &&
+				    !pipe->top_pipe && !pipe->prev_odm_pipe) {
 				// Don't need to check for ActiveDRAMClockChangeMargin < 0, not valid in cases where
 				// we run through DML without calculating "natural" P-state support
 				populate_subvp_cmd_vblank_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index d9fd4ec60588..670d5ab9d998 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -1009,7 +1009,7 @@ static void dce_transform_set_pixel_storage_depth(
 		color_depth = COLOR_DEPTH_101010;
 		pixel_depth = 0;
 		expan_mode  = 1;
-		BREAK_TO_DEBUGGER();
+		DC_LOG_DC("The pixel depth %d is not valid, set COLOR_DEPTH_101010 instead.", depth);
 		break;
 	}
 
@@ -1023,8 +1023,7 @@ static void dce_transform_set_pixel_storage_depth(
 	if (!(xfm_dce->lb_pixel_depth_supported & depth)) {
 		/*we should use unsupported capabilities
 		 *  unless it is required by w/a*/
-		DC_LOG_WARNING("%s: Capability not supported",
-			__func__);
+		DC_LOG_DC("%s: Capability not supported", __func__);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index c20e9f76f021..a1b312483d7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -629,7 +629,8 @@ void dcn30_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	//if softmax is enabled then hardmax will be set by a different call
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index bdf101547484..d4ee533deff3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -284,7 +284,7 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index e9188bce62e0..2f4afe40f3e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -970,7 +970,7 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 49da8119b28e..861f32b3248e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -4866,7 +4866,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NoUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index b612edb14417..cf8f3d690fa6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -4305,11 +4305,11 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->AudioSampleRate[k],
 							v->AudioSampleLayout[k],
 							v->ODMCombineEnablePerState[i][k]);
-				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp) {
+				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_dp2p0) {
 					if (v->DSCEnable[k] == true) {
 						v->RequiresDSC[i][k] = true;
 						v->LinkDSCEnable = true;
-						if (v->Output[k] == dm_dp) {
+						if (v->Output[k] == dm_dp || v->Output[k] == dm_dp2p0) {
 							v->RequiresFEC[i][k] = true;
 						} else {
 							v->RequiresFEC[i][k] = false;
@@ -4317,107 +4317,201 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					} else {
 						v->RequiresDSC[i][k] = false;
 						v->LinkDSCEnable = false;
-						v->RequiresFEC[i][k] = false;
-					}
-
-					v->Outbpp = BPP_INVALID;
-					if (v->PHYCLKPerState[i] >= 270.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 2700,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 5400,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 8100,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 10000.0 / 18) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 10000,
-								4,
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "10x4";
+						if (v->Output[k] == dm_dp2p0) {
+							v->RequiresFEC[i][k] = true;
+						} else {
+							v->RequiresFEC[i][k] = false;
+						}
 					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 12000.0 / 18) {
-						v->Outbpp = TruncToValidBPP(
-								12000,
-								4,
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "12x4";
+					if (v->Output[k] == dm_dp2p0) {
+						v->Outbpp = BPP_INVALID;
+						if ((v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr10) &&
+							v->PHYCLKD18PerState[k] >= 10000.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 10000,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[k] < 13500.0 / 18.0 &&
+								v->DSCEnable[k] == true && v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 10000,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR10"
+						}
+						if (v->Outbpp == BPP_INVALID &&
+							(v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr13p5) &&
+							v->PHYCLKD18PerState[k] >= 13500.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 13500,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[k] < 20000.0 / 18.0 &&
+								v->DSCEnable[k] == true && v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 13500,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR13p5"
+						}
+						if (v->Outbpp == BPP_INVALID &&
+							(v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr20) &&
+							v->PHYCLKD18PerState[k] >= 20000.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 20000,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->DSCEnable[k] == true &&
+								v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 20000,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR20"
+						}
+					} else {
+						v->Outbpp = BPP_INVALID;
+						if (v->PHYCLKPerState[i] >= 270.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 2700,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
+						}
+						if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 5400,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
+						}
+						if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 8100,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
+						}
 					}
 				}
 			} else {
@@ -5095,7 +5189,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NotUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 4f91e6475423..bf77e56c3f3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -310,6 +310,10 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 				pipe->plane_state->src_rect.width < pipe->plane_state->dst_rect.width))
 			upscaled = true;
 
+		/* Apply HostVM policy - either based on hypervisor globally enabled, or rIOMMU active */
+		if (dc->debug.dml_hostvm_override == DML_HOSTVM_NO_OVERRIDE)
+			pipes[i].pipe.src.hostvm = dc->vm_pa_config.is_hvm_enabled || dc->res_pool->hubbub->riommu_active;
+
 		/*
 		 * Immediate flip can be set dynamically after enabling the plane.
 		 * We need to require support for immediate flip or underflow can be
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 3afd3c80e6da..4998b211ccac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -4403,11 +4403,11 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 							v->AudioSampleRate[k],
 							v->AudioSampleLayout[k],
 							v->ODMCombineEnablePerState[i][k]);
-				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp) {
+				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_dp2p0) {
 					if (v->DSCEnable[k] == true) {
 						v->RequiresDSC[i][k] = true;
 						v->LinkDSCEnable = true;
-						if (v->Output[k] == dm_dp) {
+						if (v->Output[k] == dm_dp || v->Output[k] == dm_dp2p0) {
 							v->RequiresFEC[i][k] = true;
 						} else {
 							v->RequiresFEC[i][k] = false;
@@ -4415,107 +4415,201 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 					} else {
 						v->RequiresDSC[i][k] = false;
 						v->LinkDSCEnable = false;
-						v->RequiresFEC[i][k] = false;
-					}
-
-					v->Outbpp = BPP_INVALID;
-					if (v->PHYCLKPerState[i] >= 270.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 2700,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 5400,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 8100,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 10000.0 / 18) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 10000,
-								4,
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "10x4";
+						if (v->Output[k] == dm_dp2p0) {
+							v->RequiresFEC[i][k] = true;
+						} else {
+							v->RequiresFEC[i][k] = false;
+						}
 					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 12000.0 / 18) {
-						v->Outbpp = TruncToValidBPP(
-								12000,
-								4,
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "12x4";
+					if (v->Output[k] == dm_dp2p0) {
+						v->Outbpp = BPP_INVALID;
+						if ((v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr10) &&
+							v->PHYCLKD18PerState[k] >= 10000.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 10000,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[k] < 13500.0 / 18.0 &&
+								v->DSCEnable[k] == true && v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 10000,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR10"
+						}
+						if (v->Outbpp == BPP_INVALID &&
+							(v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr13p5) &&
+							v->PHYCLKD18PerState[k] >= 13500.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 13500,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[k] < 20000.0 / 18.0 &&
+								v->DSCEnable[k] == true && v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 13500,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR13p5"
+						}
+						if (v->Outbpp == BPP_INVALID &&
+							(v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr20) &&
+							v->PHYCLKD18PerState[k] >= 20000.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 20000,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->DSCEnable[k] == true &&
+								v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 20000,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR20"
+						}
+					} else {
+						v->Outbpp = BPP_INVALID;
+						if (v->PHYCLKPerState[i] >= 270.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 2700,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
+						}
+						if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 5400,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
+						}
+						if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 8100,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
+						}
 					}
 				}
 			} else {
@@ -5192,7 +5286,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NotUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index e02e9d4b04a9..2bb768413c92 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3333,7 +3333,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							/* Output */
 							&mode_lib->vba.UrgentBurstFactorCursorPre[k],
 							&mode_lib->vba.UrgentBurstFactorLumaPre[k],
-							&mode_lib->vba.UrgentBurstFactorChroma[k],
+							&mode_lib->vba.UrgentBurstFactorChromaPre[k],
 							&mode_lib->vba.NotUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6d03459de561..91dfc229e34d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -723,6 +723,24 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
+	/*
+	 * Explicitly notify PMFW the power mode the system in. Since
+	 * the PMFW may boot the ASIC with a different mode.
+	 * For those supporting ACDC switch via gpio, PMFW will
+	 * handle the switch automatically. Driver involvement
+	 * is unnecessary.
+	 */
+	if (!smu->dc_controlled_by_gpio) {
+		ret = smu_set_power_source(smu,
+					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
+					   SMU_POWER_SOURCE_DC);
+		if (ret) {
+			dev_err(adev->dev, "Failed to switch to %s mode!\n",
+				adev->pm.ac_power ? "AC" : "DC");
+			return ret;
+		}
+	}
+
 	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 1)) ||
 	    (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 3)))
 		return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 0bcd4fe0ef17..ca278280865f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3406,26 +3406,8 @@ static int navi10_post_smu_init(struct smu_context *smu)
 		return 0;
 
 	ret = navi10_run_umc_cdr_workaround(smu);
-	if (ret) {
+	if (ret)
 		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
-		return ret;
-	}
-
-	if (!smu->dc_controlled_by_gpio) {
-		/*
-		 * For Navi1X, manually switch it to AC mode as PMFW
-		 * may boot it with DC mode.
-		 */
-		ret = smu_v11_0_set_power_source(smu,
-						 adev->pm.ac_power ?
-						 SMU_POWER_SOURCE_AC :
-						 SMU_POWER_SOURCE_DC);
-		if (ret) {
-			dev_err(adev->dev, "Failed to switch to %s mode!\n",
-					adev->pm.ac_power ? "AC" : "DC");
-			return ret;
-		}
-	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index ea4ec937f52e..9dd92bbdcefd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1767,6 +1767,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.enable_mgpu_fan_boost = smu_v13_0_7_enable_mgpu_fan_boost,
 	.get_power_limit = smu_v13_0_7_get_power_limit,
 	.set_power_limit = smu_v13_0_set_power_limit,
+	.set_power_source = smu_v13_0_set_power_source,
 	.get_power_profile_mode = smu_v13_0_7_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_7_set_power_profile_mode,
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
diff --git a/drivers/gpu/drm/drm_displayid.c b/drivers/gpu/drm/drm_displayid.c
index 38ea8203df45..7d03159dc146 100644
--- a/drivers/gpu/drm/drm_displayid.c
+++ b/drivers/gpu/drm/drm_displayid.c
@@ -7,13 +7,28 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_print.h>
 
+static const struct displayid_header *
+displayid_get_header(const u8 *displayid, int length, int index)
+{
+	const struct displayid_header *base;
+
+	if (sizeof(*base) > length - index)
+		return ERR_PTR(-EINVAL);
+
+	base = (const struct displayid_header *)&displayid[index];
+
+	return base;
+}
+
 static int validate_displayid(const u8 *displayid, int length, int idx)
 {
 	int i, dispid_length;
 	u8 csum = 0;
 	const struct displayid_header *base;
 
-	base = (const struct displayid_header *)&displayid[idx];
+	base = displayid_get_header(displayid, length, idx);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	DRM_DEBUG_KMS("base revision 0x%x, length %d, %d %d\n",
 		      base->rev, base->bytes, base->prod_id, base->ext_count);
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 06cd2f8c2773..76e46713b2f0 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -708,19 +708,27 @@ static void drm_fb_helper_damage(struct fb_info *info, u32 x, u32 y,
 static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off, size_t len,
 					       struct drm_rect *clip)
 {
+	u32 line_length = info->fix.line_length;
+	u32 fb_height = info->var.yres;
 	off_t end = off + len;
 	u32 x1 = 0;
-	u32 y1 = off / info->fix.line_length;
+	u32 y1 = off / line_length;
 	u32 x2 = info->var.xres;
-	u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
+	u32 y2 = DIV_ROUND_UP(end, line_length);
+
+	/* Don't allow any of them beyond the bottom bound of display area */
+	if (y1 > fb_height)
+		y1 = fb_height;
+	if (y2 > fb_height)
+		y2 = fb_height;
 
 	if ((y2 - y1) == 1) {
 		/*
 		 * We've only written to a single scanline. Try to reduce
 		 * the number of horizontal pixels that need an update.
 		 */
-		off_t bit_off = (off % info->fix.line_length) * 8;
-		off_t bit_end = (end % info->fix.line_length) * 8;
+		off_t bit_off = (off % line_length) * 8;
+		off_t bit_end = (end % line_length) * 8;
 
 		x1 = bit_off / info->var.bits_per_pixel;
 		x2 = DIV_ROUND_UP(bit_end, info->var.bits_per_pixel);
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index f25ddfe37498..853208e8dd73 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -221,7 +221,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 		return dsi;
 	}
 
-	dsi->dev.of_node = info->node;
+	device_set_node(&dsi->dev, of_fwnode_handle(info->node));
 	dsi->channel = info->channel;
 	strlcpy(dsi->name, info->type, sizeof(dsi->name));
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.h b/drivers/gpu/drm/exynos/exynos_drm_g2d.h
index 74ea3c26dead..1a5ae781b56c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.h
@@ -34,11 +34,11 @@ static inline int exynos_g2d_exec_ioctl(struct drm_device *dev, void *data,
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
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 3a6e176d77aa..6b10868ec72f 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -54,23 +54,34 @@ config DRM_I915
 	  If "M" is selected, the module will be called i915.
 
 config DRM_I915_FORCE_PROBE
-	string "Force probe driver for selected new Intel hardware"
+	string "Force probe i915 for selected Intel hardware IDs"
 	depends on DRM_I915
 	help
 	  This is the default value for the i915.force_probe module
 	  parameter. Using the module parameter overrides this option.
 
-	  Force probe the driver for new Intel graphics devices that are
-	  recognized but not properly supported by this kernel version. It is
-	  recommended to upgrade to a kernel version with proper support as soon
-	  as it is available.
+	  Force probe the i915 driver for Intel graphics devices that are
+	  recognized but not properly supported by this kernel version. Force
+	  probing an unsupported device taints the kernel. It is recommended to
+	  upgrade to a kernel version with proper support as soon as it is
+	  available.
+
+	  It can also be used to block the probe of recognized and fully
+	  supported devices.
 
 	  Use "" to disable force probe. If in doubt, use this.
 
-	  Use "<pci-id>[,<pci-id>,...]" to force probe the driver for listed
+	  Use "<pci-id>[,<pci-id>,...]" to force probe the i915 for listed
 	  devices. For example, "4500" or "4500,4571".
 
-	  Use "*" to force probe the driver for all known devices.
+	  Use "*" to force probe the driver for all known devices. Not
+	  recommended.
+
+	  Use "!" right before the ID to block the probe of the device. For
+	  example, "4500,!4571" forces the probe of 4500 and blocks the probe of
+	  4571.
+
+	  Use "!*" to block the probe of the driver for all known devices.
 
 config DRM_I915_CAPTURE_ERROR
 	bool "Enable capturing GPU state following a hang"
diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index aaa6708256d5..82826454b5e8 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -988,7 +988,7 @@ intel_prepare_plane_fb(struct drm_plane *_plane,
 	int ret;
 
 	if (old_obj) {
-		const struct intel_crtc_state *crtc_state =
+		const struct intel_crtc_state *new_crtc_state =
 			intel_atomic_get_new_crtc_state(state,
 							to_intel_crtc(old_plane_state->hw.crtc));
 
@@ -1003,7 +1003,7 @@ intel_prepare_plane_fb(struct drm_plane *_plane,
 		 * This should only fail upon a hung GPU, in which case we
 		 * can safely continue.
 		 */
-		if (intel_crtc_needs_modeset(crtc_state)) {
+		if (new_crtc_state && intel_crtc_needs_modeset(new_crtc_state)) {
 			ret = i915_sw_fence_await_reservation(&state->commit_ready,
 							      old_obj->base.resv, NULL,
 							      false, 0,
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 2e09899f2f92..b1653308f145 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1512,6 +1512,11 @@ static int intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
 		pipe_config->dsc.slice_count =
 			drm_dp_dsc_sink_max_slice_count(intel_dp->dsc_dpcd,
 							true);
+		if (!pipe_config->dsc.slice_count) {
+			drm_dbg_kms(&dev_priv->drm, "Unsupported Slice Count %d\n",
+				    pipe_config->dsc.slice_count);
+			return -EINVAL;
+		}
 	} else {
 		u16 dsc_max_output_bpp;
 		u8 dsc_dp_slice_count;
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
index 1e1fa20fb41c..18a8466f8591 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
@@ -30,12 +30,14 @@
 	{ FORCEWAKE_MT,             0,      0, "FORCEWAKE" }
 
 #define COMMON_GEN9BASE_GLOBAL \
-	{ GEN8_FAULT_TLB_DATA0,     0,      0, "GEN8_FAULT_TLB_DATA0" }, \
-	{ GEN8_FAULT_TLB_DATA1,     0,      0, "GEN8_FAULT_TLB_DATA1" }, \
 	{ ERROR_GEN6,               0,      0, "ERROR_GEN6" }, \
 	{ DONE_REG,                 0,      0, "DONE_REG" }, \
 	{ HSW_GTT_CACHE_EN,         0,      0, "HSW_GTT_CACHE_EN" }
 
+#define GEN9_GLOBAL \
+	{ GEN8_FAULT_TLB_DATA0,     0,      0, "GEN8_FAULT_TLB_DATA0" }, \
+	{ GEN8_FAULT_TLB_DATA1,     0,      0, "GEN8_FAULT_TLB_DATA1" }
+
 #define COMMON_GEN12BASE_GLOBAL \
 	{ GEN12_FAULT_TLB_DATA0,    0,      0, "GEN12_FAULT_TLB_DATA0" }, \
 	{ GEN12_FAULT_TLB_DATA1,    0,      0, "GEN12_FAULT_TLB_DATA1" }, \
@@ -136,6 +138,7 @@ static const struct __guc_mmio_reg_descr xe_lpd_blt_inst_regs[] = {
 static const struct __guc_mmio_reg_descr default_global_regs[] = {
 	COMMON_BASE_GLOBAL,
 	COMMON_GEN9BASE_GLOBAL,
+	GEN9_GLOBAL,
 };
 
 static const struct __guc_mmio_reg_descr default_rc_class_regs[] = {
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index d1e4d528cb17..5b24dd50fb6a 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -122,7 +122,7 @@ i915_param_named_unsafe(enable_psr2_sel_fetch, bool, 0400,
 	"Default: 0");
 
 i915_param_named_unsafe(force_probe, charp, 0400,
-	"Force probe the driver for specified devices. "
+	"Force probe options for specified supported devices. "
 	"See CONFIG_DRM_I915_FORCE_PROBE for details.");
 
 i915_param_named_unsafe(disable_power_well, int, 0400,
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index a2efc0b9d50c..efa80475fbfe 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -1252,7 +1252,7 @@ static void i915_pci_remove(struct pci_dev *pdev)
 }
 
 /* is device_id present in comma separated list of ids */
-static bool force_probe(u16 device_id, const char *devices)
+static bool device_id_in_list(u16 device_id, const char *devices, bool negative)
 {
 	char *s, *p, *tok;
 	bool ret;
@@ -1261,7 +1261,9 @@ static bool force_probe(u16 device_id, const char *devices)
 		return false;
 
 	/* match everything */
-	if (strcmp(devices, "*") == 0)
+	if (negative && strcmp(devices, "!*") == 0)
+		return true;
+	if (!negative && strcmp(devices, "*") == 0)
 		return true;
 
 	s = kstrdup(devices, GFP_KERNEL);
@@ -1271,6 +1273,12 @@ static bool force_probe(u16 device_id, const char *devices)
 	for (p = s, ret = false; (tok = strsep(&p, ",")) != NULL; ) {
 		u16 val;
 
+		if (negative && tok[0] == '!')
+			tok++;
+		else if ((negative && tok[0] != '!') ||
+			 (!negative && tok[0] == '!'))
+			continue;
+
 		if (kstrtou16(tok, 16, &val) == 0 && val == device_id) {
 			ret = true;
 			break;
@@ -1282,6 +1290,16 @@ static bool force_probe(u16 device_id, const char *devices)
 	return ret;
 }
 
+static bool id_forced(u16 device_id)
+{
+	return device_id_in_list(device_id, i915_modparams.force_probe, false);
+}
+
+static bool id_blocked(u16 device_id)
+{
+	return device_id_in_list(device_id, i915_modparams.force_probe, true);
+}
+
 bool i915_pci_resource_valid(struct pci_dev *pdev, int bar)
 {
 	if (!pci_resource_flags(pdev, bar))
@@ -1309,10 +1327,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		(struct intel_device_info *) ent->driver_data;
 	int err;
 
-	if (intel_info->require_force_probe &&
-	    !force_probe(pdev->device, i915_modparams.force_probe)) {
+	if (intel_info->require_force_probe && !id_forced(pdev->device)) {
 		dev_info(&pdev->dev,
-			 "Your graphics device %04x is not properly supported by the driver in this\n"
+			 "Your graphics device %04x is not properly supported by i915 in this\n"
 			 "kernel version. To force driver probe anyway, use i915.force_probe=%04x\n"
 			 "module parameter or CONFIG_DRM_I915_FORCE_PROBE=%04x configuration option,\n"
 			 "or (recommended) check for kernel updates.\n",
@@ -1320,6 +1337,18 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENODEV;
 	}
 
+	if (id_blocked(pdev->device)) {
+		dev_info(&pdev->dev, "I915 probe blocked for Device ID %04x.\n",
+			 pdev->device);
+		return -ENODEV;
+	}
+
+	if (intel_info->require_force_probe) {
+		dev_info(&pdev->dev, "Force probing unsupported Device ID %04x, tainting kernel\n",
+			 pdev->device);
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+	}
+
 	/* Only bind to function 0 of the device. Early generations
 	 * used function 1 as a placeholder for multi-head. This causes
 	 * us confusion instead, especially on the systems where both
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index cf1b6d84c18a..75e1b89c9eac 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -15,7 +15,7 @@
 
 /*
  * Register offsets in MDSS register file for the interrupt registers
- * w.r.t. to the MDP base
+ * w.r.t. the MDP base
  */
 #define MDP_SSPP_TOP0_OFF		0x0
 #define MDP_INTF_0_OFF			0x6A000
@@ -24,6 +24,9 @@
 #define MDP_INTF_3_OFF			0x6B800
 #define MDP_INTF_4_OFF			0x6C000
 #define MDP_INTF_5_OFF			0x6C800
+#define INTF_INTR_EN			0x1c0
+#define INTF_INTR_STATUS		0x1c4
+#define INTF_INTR_CLEAR			0x1c8
 #define MDP_AD4_0_OFF			0x7C000
 #define MDP_AD4_1_OFF			0x7D000
 #define MDP_AD4_INTR_EN_OFF		0x41c
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 7ce66bf3f4c8..b2a94b9a3e98 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -56,11 +56,6 @@
 #define   INTF_TPG_RGB_MAPPING          0x11C
 #define   INTF_PROG_FETCH_START         0x170
 #define   INTF_PROG_ROT_START           0x174
-
-#define   INTF_FRAME_LINE_COUNT_EN      0x0A8
-#define   INTF_FRAME_COUNT              0x0AC
-#define   INTF_LINE_COUNT               0x0B0
-
 #define   INTF_MUX                      0x25C
 
 #define INTF_CFG_ACTIVE_H_EN	BIT(29)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
index 2d28afdf860e..a3e413d27717 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
@@ -61,6 +61,7 @@ static const struct dpu_wb_cfg *_wb_offset(enum dpu_wb wb,
 	for (i = 0; i < m->wb_count; i++) {
 		if (wb == m->wb[i].id) {
 			b->blk_addr = addr + m->wb[i].base;
+			b->log_mask = DPU_DBG_MASK_WB;
 			return &m->wb[i];
 		}
 	}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h
index c8156ed4b7fb..93081e82c6d7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h
@@ -20,9 +20,6 @@
 #define HIST_INTR_EN                    0x01c
 #define HIST_INTR_STATUS                0x020
 #define HIST_INTR_CLEAR                 0x024
-#define INTF_INTR_EN                    0x1C0
-#define INTF_INTR_STATUS                0x1C4
-#define INTF_INTR_CLEAR                 0x1C8
 #define SPLIT_DISPLAY_EN                0x2F4
 #define SPLIT_DISPLAY_UPPER_PIPE_CTRL   0x2F8
 #define DSPP_IGC_COLOR0_RAM_LUTN        0x300
diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 6666783e1468..1245c7aa49df 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -593,6 +593,18 @@ static struct hdmi_codec_pdata codec_data = {
 	.i2s = 1,
 };
 
+void dp_unregister_audio_driver(struct device *dev, struct dp_audio *dp_audio)
+{
+	struct dp_audio_private *audio_priv;
+
+	audio_priv = container_of(dp_audio, struct dp_audio_private, dp_audio);
+
+	if (audio_priv->audio_pdev) {
+		platform_device_unregister(audio_priv->audio_pdev);
+		audio_priv->audio_pdev = NULL;
+	}
+}
+
 int dp_register_audio_driver(struct device *dev,
 		struct dp_audio *dp_audio)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_audio.h b/drivers/gpu/drm/msm/dp/dp_audio.h
index 84e5f4a5d26b..4ab78880af82 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.h
+++ b/drivers/gpu/drm/msm/dp/dp_audio.h
@@ -53,6 +53,8 @@ struct dp_audio *dp_audio_get(struct platform_device *pdev,
 int dp_register_audio_driver(struct device *dev,
 		struct dp_audio *dp_audio);
 
+void dp_unregister_audio_driver(struct device *dev, struct dp_audio *dp_audio);
+
 /**
  * dp_audio_put()
  *
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index cc3efed593aa..84f9e3e5f964 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -162,47 +162,6 @@ static ssize_t dp_aux_cmd_fifo_rx(struct dp_aux_private *aux,
 	return i;
 }
 
-static void dp_aux_native_handler(struct dp_aux_private *aux, u32 isr)
-{
-	if (isr & DP_INTR_AUX_I2C_DONE)
-		aux->aux_error_num = DP_AUX_ERR_NONE;
-	else if (isr & DP_INTR_WRONG_ADDR)
-		aux->aux_error_num = DP_AUX_ERR_ADDR;
-	else if (isr & DP_INTR_TIMEOUT)
-		aux->aux_error_num = DP_AUX_ERR_TOUT;
-	if (isr & DP_INTR_NACK_DEFER)
-		aux->aux_error_num = DP_AUX_ERR_NACK;
-	if (isr & DP_INTR_AUX_ERROR) {
-		aux->aux_error_num = DP_AUX_ERR_PHY;
-		dp_catalog_aux_clear_hw_interrupts(aux->catalog);
-	}
-}
-
-static void dp_aux_i2c_handler(struct dp_aux_private *aux, u32 isr)
-{
-	if (isr & DP_INTR_AUX_I2C_DONE) {
-		if (isr & (DP_INTR_I2C_NACK | DP_INTR_I2C_DEFER))
-			aux->aux_error_num = DP_AUX_ERR_NACK;
-		else
-			aux->aux_error_num = DP_AUX_ERR_NONE;
-	} else {
-		if (isr & DP_INTR_WRONG_ADDR)
-			aux->aux_error_num = DP_AUX_ERR_ADDR;
-		else if (isr & DP_INTR_TIMEOUT)
-			aux->aux_error_num = DP_AUX_ERR_TOUT;
-		if (isr & DP_INTR_NACK_DEFER)
-			aux->aux_error_num = DP_AUX_ERR_NACK_DEFER;
-		if (isr & DP_INTR_I2C_NACK)
-			aux->aux_error_num = DP_AUX_ERR_NACK;
-		if (isr & DP_INTR_I2C_DEFER)
-			aux->aux_error_num = DP_AUX_ERR_DEFER;
-		if (isr & DP_INTR_AUX_ERROR) {
-			aux->aux_error_num = DP_AUX_ERR_PHY;
-			dp_catalog_aux_clear_hw_interrupts(aux->catalog);
-		}
-	}
-}
-
 static void dp_aux_update_offset_and_segment(struct dp_aux_private *aux,
 					     struct drm_dp_aux_msg *input_msg)
 {
@@ -427,13 +386,42 @@ void dp_aux_isr(struct drm_dp_aux *dp_aux)
 	if (!isr)
 		return;
 
-	if (!aux->cmd_busy)
+	if (!aux->cmd_busy) {
+		DRM_ERROR("Unexpected DP AUX IRQ %#010x when not busy\n", isr);
 		return;
+	}
 
-	if (aux->native)
-		dp_aux_native_handler(aux, isr);
-	else
-		dp_aux_i2c_handler(aux, isr);
+	/*
+	 * The logic below assumes only one error bit is set (other than "done"
+	 * which can apparently be set at the same time as some of the other
+	 * bits). Warn if more than one get set so we know we need to improve
+	 * the logic.
+	 */
+	if (hweight32(isr & ~DP_INTR_AUX_XFER_DONE) > 1)
+		DRM_WARN("Some DP AUX interrupts unhandled: %#010x\n", isr);
+
+	if (isr & DP_INTR_AUX_ERROR) {
+		aux->aux_error_num = DP_AUX_ERR_PHY;
+		dp_catalog_aux_clear_hw_interrupts(aux->catalog);
+	} else if (isr & DP_INTR_NACK_DEFER) {
+		aux->aux_error_num = DP_AUX_ERR_NACK_DEFER;
+	} else if (isr & DP_INTR_WRONG_ADDR) {
+		aux->aux_error_num = DP_AUX_ERR_ADDR;
+	} else if (isr & DP_INTR_TIMEOUT) {
+		aux->aux_error_num = DP_AUX_ERR_TOUT;
+	} else if (!aux->native && (isr & DP_INTR_I2C_NACK)) {
+		aux->aux_error_num = DP_AUX_ERR_NACK;
+	} else if (!aux->native && (isr & DP_INTR_I2C_DEFER)) {
+		if (isr & DP_INTR_AUX_XFER_DONE)
+			aux->aux_error_num = DP_AUX_ERR_NACK;
+		else
+			aux->aux_error_num = DP_AUX_ERR_DEFER;
+	} else if (isr & DP_INTR_AUX_XFER_DONE) {
+		aux->aux_error_num = DP_AUX_ERR_NONE;
+	} else {
+		DRM_WARN("Unexpected interrupt: %#010x\n", isr);
+		return;
+	}
 
 	complete(&aux->comp);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 676279d0ca8d..421391755427 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -27,7 +27,7 @@
 #define DP_INTF_CONFIG_DATABUS_WIDEN     BIT(4)
 
 #define DP_INTERRUPT_STATUS1 \
-	(DP_INTR_AUX_I2C_DONE| \
+	(DP_INTR_AUX_XFER_DONE| \
 	DP_INTR_WRONG_ADDR | DP_INTR_TIMEOUT | \
 	DP_INTR_NACK_DEFER | DP_INTR_WRONG_DATA_CNT | \
 	DP_INTR_I2C_NACK | DP_INTR_I2C_DEFER | \
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 1f717f45c115..f36b7b372a06 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -13,7 +13,7 @@
 
 /* interrupts */
 #define DP_INTR_HPD		BIT(0)
-#define DP_INTR_AUX_I2C_DONE	BIT(3)
+#define DP_INTR_AUX_XFER_DONE	BIT(3)
 #define DP_INTR_WRONG_ADDR	BIT(6)
 #define DP_INTR_TIMEOUT		BIT(9)
 #define DP_INTR_NACK_DEFER	BIT(12)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c9d9b384ddd0..57b82e5d0ab1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -323,6 +323,7 @@ static void dp_display_unbind(struct device *dev, struct device *master,
 	kthread_stop(dp->ev_tsk);
 
 	dp_power_client_deinit(dp->power);
+	dp_unregister_audio_driver(dev, dp->audio);
 	dp_aux_unregister(dp->aux);
 	dp->drm_dev = NULL;
 	dp->aux->drm_dev = NULL;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index d8c9d184190b..d6162561141c 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -709,7 +709,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_msm_gem_submit *args = data;
 	struct msm_file_private *ctx = file->driver_priv;
-	struct msm_gem_submit *submit;
+	struct msm_gem_submit *submit = NULL;
 	struct msm_gpu *gpu = priv->gpu;
 	struct msm_gpu_submitqueue *queue;
 	struct msm_ringbuffer *ring;
@@ -756,13 +756,15 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
 		if (out_fence_fd < 0) {
 			ret = out_fence_fd;
-			return ret;
+			goto out_post_unlock;
 		}
 	}
 
 	submit = submit_create(dev, gpu, queue, args->nr_bos, args->nr_cmds);
-	if (IS_ERR(submit))
-		return PTR_ERR(submit);
+	if (IS_ERR(submit)) {
+		ret = PTR_ERR(submit);
+		goto out_post_unlock;
+	}
 
 	trace_msm_gpu_submit(pid_nr(submit->pid), ring->id, submit->ident,
 		args->nr_bos, args->nr_cmds);
@@ -945,11 +947,20 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (has_ww_ticket)
 		ww_acquire_fini(&submit->ticket);
 out_unlock:
-	if (ret && (out_fence_fd >= 0))
-		put_unused_fd(out_fence_fd);
 	mutex_unlock(&queue->lock);
 out_post_unlock:
-	msm_gem_submit_put(submit);
+	if (ret && (out_fence_fd >= 0))
+		put_unused_fd(out_fence_fd);
+
+	if (!IS_ERR_OR_NULL(submit)) {
+		msm_gem_submit_put(submit);
+	} else {
+		/*
+		 * If the submit hasn't yet taken ownership of the queue
+		 * then we need to drop the reference ourself:
+		 */
+		msm_submitqueue_put(queue);
+	}
 	if (!IS_ERR_OR_NULL(post_deps)) {
 		for (i = 0; i < args->nr_out_syncobjs; ++i) {
 			kfree(post_deps[i].chain);
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 2f4b8f64cbad..ae857bf8bd62 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -640,6 +640,7 @@ static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
 
 	dw_hdmi_unbind(hdmi->hdmi);
+	drm_encoder_cleanup(&hdmi->encoder.encoder);
 	clk_disable_unprepare(hdmi->ref_clk);
 
 	regulator_disable(hdmi->avdd_1v8);
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 8af632740673..77723d5f1d3f 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1153,7 +1153,7 @@ static int tegra_sor_compute_config(struct tegra_sor *sor,
 				    struct drm_dp_link *link)
 {
 	const u64 f = 100000, link_rate = link->rate * 1000;
-	const u64 pclk = mode->clock * 1000;
+	const u64 pclk = (u64)mode->clock * 1000;
 	u64 input, output, watermark, num;
 	struct tegra_sor_params params;
 	u32 num_syms_per_line;
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index c671ce94671c..37b2ce9b50fe 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -854,14 +854,16 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO),
-		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
+			APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
 			APPLE_RDESC_JIS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO),
-		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
+			APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
 			APPLE_RDESC_JIS },
@@ -880,7 +882,8 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO),
-		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
+			APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
 			APPLE_RDESC_JIS },
@@ -921,31 +924,31 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
 		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO),
-		.driver_data = APPLE_HAS_FN },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_JIS),
 		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI),
 		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ISO),
-		.driver_data = APPLE_HAS_FN },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_JIS),
 		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI),
 		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_ISO),
-		.driver_data = APPLE_HAS_FN },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_JIS),
 		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI),
 		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4_ISO),
-		.driver_data = APPLE_HAS_FN },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4_JIS),
 		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4A_ANSI),
 		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4A_ISO),
-		.driver_data = APPLE_HAS_FN },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS),
 		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI),
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2235d78784b1..53c6692d7771 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -415,6 +415,7 @@
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_15	0x2817
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_13_AW0020NG  0x29DF
 #define I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN 0x2BC8
+#define I2C_DEVICE_ID_ASUS_GV301RA_TOUCHSCREEN 0x2C82
 #define USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN	0x2544
 #define USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN	0x2706
 #define I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN	0x261A
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c3f80b516f39..3acaaca888ac 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -372,6 +372,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_GV301RA_TOUCHSCREEN),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN),
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index e906ee375298..b2cd7527de19 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -838,8 +838,7 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
-		 hdev->product, &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
 	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
 
 	name = hidpp_unifying_get_name(hidpp);
@@ -932,6 +931,54 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
 	return 0;
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
@@ -4194,6 +4241,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
 		hidpp_unifying_init(hidpp);
+	else if (hid_is_usb(hidpp->hid_dev))
+		hidpp_serial_init(hidpp);
 
 	connected = hidpp_root_get_protocol_version(hidpp) == 0;
 	atomic_set(&hidpp->connected, connected);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0c6a82c665c1..d2f500242ed4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1963,18 +1963,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
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
@@ -1995,18 +1984,21 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
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
@@ -2022,18 +2014,15 @@ static void wacom_wac_battery_report(struct hid_device *hdev,
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
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..a29a426e4eed 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -35,6 +35,7 @@ config ARM_GIC_V3
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
+	select HAVE_ARM_SMCCC_DISCOVERY
 
 config ARM_GIC_V3_ITS
 	bool
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 34d58567b78d..2182f87d2d12 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -23,6 +23,9 @@
 #include <linux/irqchip/arm-gic-common.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/irq-partition-percpu.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/arm-smccc.h>
 
 #include <asm/cputype.h>
 #include <asm/exception.h>
@@ -46,6 +49,7 @@ struct redist_region {
 
 struct gic_chip_data {
 	struct fwnode_handle	*fwnode;
+	phys_addr_t		dist_phys_base;
 	void __iomem		*dist_base;
 	struct redist_region	*redist_regions;
 	struct rdists		rdists;
@@ -58,6 +62,10 @@ struct gic_chip_data {
 	struct partition_desc	**ppi_descs;
 };
 
+#define T241_CHIPS_MAX		4
+static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX] __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
@@ -187,6 +195,39 @@ static inline bool gic_irq_in_rdist(struct irq_data *d)
 	}
 }
 
+static inline void __iomem *gic_dist_base_alias(struct irq_data *d)
+{
+	if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		irq_hw_number_t hwirq = irqd_to_hwirq(d);
+		u32 chip;
+
+		/*
+		 * For the erratum T241-FABRIC-4, read accesses to GICD_In{E}
+		 * registers are directed to the chip that owns the SPI. The
+		 * the alias region can also be used for writes to the
+		 * GICD_In{E} except GICD_ICENABLERn. Each chip has support
+		 * for 320 {E}SPIs. Mappings for all 4 chips:
+		 *    Chip0 = 32-351
+		 *    Chip1 = 352-671
+		 *    Chip2 = 672-991
+		 *    Chip3 = 4096-4415
+		 */
+		switch (__get_intid_range(hwirq)) {
+		case SPI_RANGE:
+			chip = (hwirq - 32) / 320;
+			break;
+		case ESPI_RANGE:
+			chip = 3;
+			break;
+		default:
+			unreachable();
+		}
+		return t241_dist_base_alias[chip];
+	}
+
+	return gic_data.dist_base;
+}
+
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
@@ -345,7 +386,7 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
 	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
 	else
-		base = gic_data.dist_base;
+		base = gic_dist_base_alias(d);
 
 	return !!(readl_relaxed(base + offset + (index / 32) * 4) & mask);
 }
@@ -596,7 +637,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
 	else
-		base = gic_data.dist_base;
+		base = gic_dist_base_alias(d);
 
 	offset = convert_offset_index(d, GICD_ICFGR, &index);
 
@@ -1718,6 +1759,43 @@ static bool gic_enable_quirk_hip06_07(void *data)
 	return false;
 }
 
+#define T241_CHIPN_MASK		GENMASK_ULL(45, 44)
+#define T241_CHIP_GICDA_OFFSET	0x1580000
+#define SMCCC_SOC_ID_T241	0x036b0241
+
+static bool gic_enable_quirk_nvidia_t241(void *data)
+{
+	s32 soc_id = arm_smccc_get_soc_id_version();
+	unsigned long chip_bmask = 0;
+	phys_addr_t phys;
+	u32 i;
+
+	/* Check JEP106 code for NVIDIA T241 chip (036b:0241) */
+	if ((soc_id < 0) || (soc_id != SMCCC_SOC_ID_T241))
+		return false;
+
+	/* Find the chips based on GICR regions PHYS addr */
+	for (i = 0; i < gic_data.nr_redist_regions; i++) {
+		chip_bmask |= BIT(FIELD_GET(T241_CHIPN_MASK,
+				  (u64)gic_data.redist_regions[i].phys_base));
+	}
+
+	if (hweight32(chip_bmask) < 3)
+		return false;
+
+	/* Setup GICD alias regions */
+	for (i = 0; i < ARRAY_SIZE(t241_dist_base_alias); i++) {
+		if (chip_bmask & BIT(i)) {
+			phys = gic_data.dist_phys_base + T241_CHIP_GICDA_OFFSET;
+			phys |= FIELD_PREP(T241_CHIPN_MASK, i);
+			t241_dist_base_alias[i] = ioremap(phys, SZ_64K);
+			WARN_ON_ONCE(!t241_dist_base_alias[i]);
+		}
+	}
+	static_branch_enable(&gic_nvidia_t241_erratum);
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] = {
 	{
 		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1749,6 +1827,12 @@ static const struct gic_quirk gic_quirks[] = {
 		.mask	= 0xe8f00fff,
 		.init	= gic_enable_quirk_cavium_38539,
 	},
+	{
+		.desc	= "GICv3: NVIDIA erratum T241-FABRIC-4",
+		.iidr	= 0x0402043b,
+		.mask	= 0xffffffff,
+		.init	= gic_enable_quirk_nvidia_t241,
+	},
 	{
 	}
 };
@@ -1816,7 +1900,8 @@ static void gic_enable_nmi_support(void)
 		gic_chip.flags |= IRQCHIP_SUPPORTS_NMI;
 }
 
-static int __init gic_init_bases(void __iomem *dist_base,
+static int __init gic_init_bases(phys_addr_t dist_phys_base,
+				 void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
 				 u64 redist_stride,
@@ -1832,6 +1917,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 		pr_info("GIC: Using split EOI/Deactivate mode\n");
 
 	gic_data.fwnode = handle;
+	gic_data.dist_phys_base = dist_phys_base;
 	gic_data.dist_base = dist_base;
 	gic_data.redist_regions = rdist_regs;
 	gic_data.nr_redist_regions = nr_redist_regions;
@@ -1859,10 +1945,13 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
-	gic_data.rdists.has_rvpeid = true;
-	gic_data.rdists.has_vlpis = true;
-	gic_data.rdists.has_direct_lpi = true;
-	gic_data.rdists.has_vpend_valid_dirty = true;
+	if (!static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		/* Disable GICv4.x features for the erratum T241-FABRIC-4 */
+		gic_data.rdists.has_rvpeid = true;
+		gic_data.rdists.has_vlpis = true;
+		gic_data.rdists.has_direct_lpi = true;
+		gic_data.rdists.has_vpend_valid_dirty = true;
+	}
 
 	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
 		err = -ENOMEM;
@@ -2068,6 +2157,7 @@ static void __iomem *gic_of_iomap(struct device_node *node, int idx,
 
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
+	phys_addr_t dist_phys_base;
 	void __iomem *dist_base;
 	struct redist_region *rdist_regs;
 	struct resource res;
@@ -2081,6 +2171,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 		return PTR_ERR(dist_base);
 	}
 
+	dist_phys_base = res.start;
+
 	err = gic_validate_dist_version(dist_base);
 	if (err) {
 		pr_err("%pOF: no distributor detected, giving up\n", node);
@@ -2112,8 +2204,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	gic_enable_of_quirks(node, gic_quirks, &gic_data);
 
-	err = gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
-			     redist_stride, &node->fwnode);
+	err = gic_init_bases(dist_phys_base, dist_base, rdist_regs,
+			     nr_redist_regions, redist_stride, &node->fwnode);
 	if (err)
 		goto out_unmap_rdist;
 
@@ -2429,8 +2521,9 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 		goto out_redist_unmap;
 	}
 
-	err = gic_init_bases(acpi_data.dist_base, acpi_data.redist_regs,
-			     acpi_data.nr_redist_regions, 0, gsi_domain_handle);
+	err = gic_init_bases(dist->base_address, acpi_data.dist_base,
+			     acpi_data.redist_regs, acpi_data.nr_redist_regions,
+			     0, gsi_domain_handle);
 	if (err)
 		goto out_fwhandle_free;
 
diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index dc88232d9af8..53d9202ff9a7 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -31,7 +31,7 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret;
+	int ret, table_size;
 	unsigned long flags;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct priv), GFP_KERNEL);
@@ -90,7 +90,30 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index d5c362b1602b..bb73a541bb19 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8028,16 +8028,16 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 	} else if (resync > max_sectors) {
 		resync = max_sectors;
 	} else {
-		resync -= atomic_read(&mddev->recovery_active);
-		if (resync < MD_RESYNC_ACTIVE) {
-			/*
-			 * Resync has started, but the subtraction has
-			 * yielded one of the special values. Force it
-			 * to active to ensure the status reports an
-			 * active resync.
-			 */
+		res = atomic_read(&mddev->recovery_active);
+		/*
+		 * Resync has started, but the subtraction has overflowed or
+		 * yielded one of the special values. Force it to active to
+		 * ensure the status reports an active resync.
+		 */
+		if (resync < res || resync - res < MD_RESYNC_ACTIVE)
 			resync = MD_RESYNC_ACTIVE;
-		}
+		else
+			resync -= res;
 	}
 
 	if (resync == MD_RESYNC_NONE) {
diff --git a/drivers/media/pci/cx23885/cx23885-core.c b/drivers/media/pci/cx23885/cx23885-core.c
index 9232a966bcab..2ce2914576cf 100644
--- a/drivers/media/pci/cx23885/cx23885-core.c
+++ b/drivers/media/pci/cx23885/cx23885-core.c
@@ -1325,7 +1325,9 @@ void cx23885_free_buffer(struct cx23885_dev *dev, struct cx23885_buffer *buf)
 {
 	struct cx23885_riscmem *risc = &buf->risc;
 
-	dma_free_coherent(&dev->pci->dev, risc->size, risc->cpu, risc->dma);
+	if (risc->cpu)
+		dma_free_coherent(&dev->pci->dev, risc->size, risc->cpu, risc->dma);
+	memset(risc, 0, sizeof(*risc));
 }
 
 static void cx23885_tsport_reg_dump(struct cx23885_tsport *port)
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index 3d03f5e95786..671fc0588e43 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -342,6 +342,7 @@ static int queue_setup(struct vb2_queue *q,
 
 static int buffer_prepare(struct vb2_buffer *vb)
 {
+	int ret;
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct cx23885_dev *dev = vb->vb2_queue->drv_priv;
 	struct cx23885_buffer *buf =
@@ -358,12 +359,12 @@ static int buffer_prepare(struct vb2_buffer *vb)
 
 	switch (dev->field) {
 	case V4L2_FIELD_TOP:
-		cx23885_risc_buffer(dev->pci, &buf->risc,
+		ret = cx23885_risc_buffer(dev->pci, &buf->risc,
 				sgt->sgl, 0, UNSET,
 				buf->bpl, 0, dev->height);
 		break;
 	case V4L2_FIELD_BOTTOM:
-		cx23885_risc_buffer(dev->pci, &buf->risc,
+		ret = cx23885_risc_buffer(dev->pci, &buf->risc,
 				sgt->sgl, UNSET, 0,
 				buf->bpl, 0, dev->height);
 		break;
@@ -391,21 +392,21 @@ static int buffer_prepare(struct vb2_buffer *vb)
 			line0_offset = 0;
 			line1_offset = buf->bpl;
 		}
-		cx23885_risc_buffer(dev->pci, &buf->risc,
+		ret = cx23885_risc_buffer(dev->pci, &buf->risc,
 				sgt->sgl, line0_offset,
 				line1_offset,
 				buf->bpl, buf->bpl,
 				dev->height >> 1);
 		break;
 	case V4L2_FIELD_SEQ_TB:
-		cx23885_risc_buffer(dev->pci, &buf->risc,
+		ret = cx23885_risc_buffer(dev->pci, &buf->risc,
 				sgt->sgl,
 				0, buf->bpl * (dev->height >> 1),
 				buf->bpl, 0,
 				dev->height >> 1);
 		break;
 	case V4L2_FIELD_SEQ_BT:
-		cx23885_risc_buffer(dev->pci, &buf->risc,
+		ret = cx23885_risc_buffer(dev->pci, &buf->risc,
 				sgt->sgl,
 				buf->bpl * (dev->height >> 1), 0,
 				buf->bpl, 0,
@@ -418,7 +419,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 		buf, buf->vb.vb2_buf.index,
 		dev->width, dev->height, dev->fmt->depth, dev->fmt->fourcc,
 		(unsigned long)buf->risc.dma);
-	return 0;
+	return ret;
 }
 
 static void buffer_finish(struct vb2_buffer *vb)
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index 8287851b5ffd..aaa1d2dedebd 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -697,7 +697,7 @@ static void netup_unidvb_dma_fini(struct netup_unidvb_dev *ndev, int num)
 	netup_unidvb_dma_enable(dma, 0);
 	msleep(50);
 	cancel_work_sync(&dma->work);
-	del_timer(&dma->timeout);
+	del_timer_sync(&dma->timeout);
 }
 
 static int netup_unidvb_dma_setup(struct netup_unidvb_dev *ndev)
diff --git a/drivers/media/pci/tw68/tw68-video.c b/drivers/media/pci/tw68/tw68-video.c
index 0cbc5b038073..773a18702d36 100644
--- a/drivers/media/pci/tw68/tw68-video.c
+++ b/drivers/media/pci/tw68/tw68-video.c
@@ -437,6 +437,7 @@ static void tw68_buf_queue(struct vb2_buffer *vb)
  */
 static int tw68_buf_prepare(struct vb2_buffer *vb)
 {
+	int ret;
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct vb2_queue *vq = vb->vb2_queue;
 	struct tw68_dev *dev = vb2_get_drv_priv(vq);
@@ -452,30 +453,30 @@ static int tw68_buf_prepare(struct vb2_buffer *vb)
 	bpl = (dev->width * dev->fmt->depth) >> 3;
 	switch (dev->field) {
 	case V4L2_FIELD_TOP:
-		tw68_risc_buffer(dev->pci, buf, dma->sgl,
+		ret = tw68_risc_buffer(dev->pci, buf, dma->sgl,
 				 0, UNSET, bpl, 0, dev->height);
 		break;
 	case V4L2_FIELD_BOTTOM:
-		tw68_risc_buffer(dev->pci, buf, dma->sgl,
+		ret = tw68_risc_buffer(dev->pci, buf, dma->sgl,
 				 UNSET, 0, bpl, 0, dev->height);
 		break;
 	case V4L2_FIELD_SEQ_TB:
-		tw68_risc_buffer(dev->pci, buf, dma->sgl,
+		ret = tw68_risc_buffer(dev->pci, buf, dma->sgl,
 				 0, bpl * (dev->height >> 1),
 				 bpl, 0, dev->height >> 1);
 		break;
 	case V4L2_FIELD_SEQ_BT:
-		tw68_risc_buffer(dev->pci, buf, dma->sgl,
+		ret = tw68_risc_buffer(dev->pci, buf, dma->sgl,
 				 bpl * (dev->height >> 1), 0,
 				 bpl, 0, dev->height >> 1);
 		break;
 	case V4L2_FIELD_INTERLACED:
 	default:
-		tw68_risc_buffer(dev->pci, buf, dma->sgl,
+		ret = tw68_risc_buffer(dev->pci, buf, dma->sgl,
 				 0, bpl, bpl, bpl, dev->height >> 1);
 		break;
 	}
-	return 0;
+	return ret;
 }
 
 static void tw68_buf_finish(struct vb2_buffer *vb)
@@ -485,7 +486,8 @@ static void tw68_buf_finish(struct vb2_buffer *vb)
 	struct tw68_dev *dev = vb2_get_drv_priv(vq);
 	struct tw68_buf *buf = container_of(vbuf, struct tw68_buf, vb);
 
-	dma_free_coherent(&dev->pci->dev, buf->size, buf->cpu, buf->dma);
+	if (buf->cpu)
+		dma_free_coherent(&dev->pci->dev, buf->size, buf->cpu, buf->dma);
 }
 
 static int tw68_start_streaming(struct vb2_queue *q, unsigned int count)
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index c99705681a03..93fcea821001 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -735,6 +735,13 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 	}
 
 	if (*nplanes) {
+		if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
+			if (*nplanes != q_data->fmt->num_planes)
+				return -EINVAL;
+		} else {
+			if (*nplanes != 1)
+				return -EINVAL;
+		}
 		for (i = 0; i < *nplanes; i++) {
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drm.c b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
index c6f25200982c..7fe375b6322c 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
@@ -66,7 +66,9 @@ static int vsp1_du_insert_uif(struct vsp1_device *vsp1,
 			      struct vsp1_entity *prev, unsigned int prev_pad,
 			      struct vsp1_entity *next, unsigned int next_pad)
 {
-	struct v4l2_subdev_format format;
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
 	int ret;
 
 	if (!uif) {
@@ -82,8 +84,6 @@ static int vsp1_du_insert_uif(struct vsp1_device *vsp1,
 	prev->sink = uif;
 	prev->sink_pad = UIF_PAD_SINK;
 
-	memset(&format, 0, sizeof(format));
-	format.which = V4L2_SUBDEV_FORMAT_ACTIVE;
 	format.pad = prev_pad;
 
 	ret = v4l2_subdev_call(&prev->subdev, pad, get_fmt, NULL, &format);
@@ -118,8 +118,12 @@ static int vsp1_du_pipeline_setup_rpf(struct vsp1_device *vsp1,
 				      struct vsp1_entity *uif,
 				      unsigned int brx_input)
 {
-	struct v4l2_subdev_selection sel;
-	struct v4l2_subdev_format format;
+	struct v4l2_subdev_selection sel = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
 	const struct v4l2_rect *crop;
 	int ret;
 
@@ -129,8 +133,6 @@ static int vsp1_du_pipeline_setup_rpf(struct vsp1_device *vsp1,
 	 */
 	crop = &vsp1->drm->inputs[rpf->entity.index].crop;
 
-	memset(&format, 0, sizeof(format));
-	format.which = V4L2_SUBDEV_FORMAT_ACTIVE;
 	format.pad = RWPF_PAD_SINK;
 	format.format.width = crop->width + crop->left;
 	format.format.height = crop->height + crop->top;
@@ -147,8 +149,6 @@ static int vsp1_du_pipeline_setup_rpf(struct vsp1_device *vsp1,
 		__func__, format.format.width, format.format.height,
 		format.format.code, rpf->entity.index);
 
-	memset(&sel, 0, sizeof(sel));
-	sel.which = V4L2_SUBDEV_FORMAT_ACTIVE;
 	sel.pad = RWPF_PAD_SINK;
 	sel.target = V4L2_SEL_TGT_CROP;
 	sel.r = *crop;
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_entity.c b/drivers/media/platform/renesas/vsp1/vsp1_entity.c
index 4c3bd2b1ca28..c31f05a80bb5 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_entity.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_entity.c
@@ -184,15 +184,14 @@ vsp1_entity_get_pad_selection(struct vsp1_entity *entity,
 int vsp1_entity_init_cfg(struct v4l2_subdev *subdev,
 			 struct v4l2_subdev_state *sd_state)
 {
-	struct v4l2_subdev_format format;
 	unsigned int pad;
 
 	for (pad = 0; pad < subdev->entity.num_pads - 1; ++pad) {
-		memset(&format, 0, sizeof(format));
-
-		format.pad = pad;
-		format.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY
-			     : V4L2_SUBDEV_FORMAT_ACTIVE;
+		struct v4l2_subdev_format format = {
+			.pad = pad,
+			.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY
+			       : V4L2_SUBDEV_FORMAT_ACTIVE,
+		};
 
 		v4l2_subdev_call(subdev, pad, set_fmt, sd_state, &format);
 	}
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
index e3b95a2b7e04..beaee54ee73b 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
@@ -763,7 +763,10 @@ static int fimc_pipeline_try_format(struct fimc_ctx *ctx,
 	struct fimc_dev *fimc = ctx->fimc_dev;
 	struct fimc_pipeline *p = to_fimc_pipeline(fimc->vid_cap.ve.pipe);
 	struct v4l2_subdev *sd = p->subdevs[IDX_SENSOR];
-	struct v4l2_subdev_format sfmt;
+	struct v4l2_subdev_format sfmt = {
+		.which = set ? V4L2_SUBDEV_FORMAT_ACTIVE
+		       : V4L2_SUBDEV_FORMAT_TRY,
+	};
 	struct v4l2_mbus_framefmt *mf = &sfmt.format;
 	struct media_entity *me;
 	struct fimc_fmt *ffmt;
@@ -774,9 +777,7 @@ static int fimc_pipeline_try_format(struct fimc_ctx *ctx,
 	if (WARN_ON(!sd || !tfmt))
 		return -EINVAL;
 
-	memset(&sfmt, 0, sizeof(sfmt));
 	sfmt.format = *tfmt;
-	sfmt.which = set ? V4L2_SUBDEV_FORMAT_ACTIVE : V4L2_SUBDEV_FORMAT_TRY;
 
 	me = fimc_pipeline_get_head(&sd->entity);
 
diff --git a/drivers/media/platform/ti/am437x/am437x-vpfe.c b/drivers/media/platform/ti/am437x/am437x-vpfe.c
index 2dfae9bc0bba..dffac89cbd21 100644
--- a/drivers/media/platform/ti/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/ti/am437x/am437x-vpfe.c
@@ -1499,7 +1499,9 @@ static int vpfe_enum_size(struct file *file, void  *priv,
 			  struct v4l2_frmsizeenum *fsize)
 {
 	struct vpfe_device *vpfe = video_drvdata(file);
-	struct v4l2_subdev_frame_size_enum fse;
+	struct v4l2_subdev_frame_size_enum fse = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
 	struct v4l2_subdev *sd = vpfe->current_subdev->sd;
 	struct vpfe_fmt *fmt;
 	int ret;
@@ -1514,11 +1516,9 @@ static int vpfe_enum_size(struct file *file, void  *priv,
 
 	memset(fsize->reserved, 0x0, sizeof(fsize->reserved));
 
-	memset(&fse, 0x0, sizeof(fse));
 	fse.index = fsize->index;
 	fse.pad = 0;
 	fse.code = fmt->code;
-	fse.which = V4L2_SUBDEV_FORMAT_ACTIVE;
 	ret = v4l2_subdev_call(sd, pad, enum_frame_size, NULL, &fse);
 	if (ret)
 		return ret;
@@ -2146,7 +2146,6 @@ vpfe_async_bound(struct v4l2_async_notifier *notifier,
 {
 	struct vpfe_device *vpfe = container_of(notifier->v4l2_dev,
 					       struct vpfe_device, v4l2_dev);
-	struct v4l2_subdev_mbus_code_enum mbus_code;
 	struct vpfe_subdev_info *sdinfo;
 	struct vpfe_fmt *fmt;
 	int ret = 0;
@@ -2173,9 +2172,11 @@ vpfe_async_bound(struct v4l2_async_notifier *notifier,
 
 	vpfe->num_active_fmt = 0;
 	for (j = 0, i = 0; (ret != -EINVAL); ++j) {
-		memset(&mbus_code, 0, sizeof(mbus_code));
-		mbus_code.index = j;
-		mbus_code.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+		struct v4l2_subdev_mbus_code_enum mbus_code = {
+			.index = j,
+			.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		};
+
 		ret = v4l2_subdev_call(subdev, pad, enum_mbus_code,
 				       NULL, &mbus_code);
 		if (ret)
diff --git a/drivers/media/platform/ti/cal/cal-video.c b/drivers/media/platform/ti/cal/cal-video.c
index 4eade409d5d3..bbfd2719725a 100644
--- a/drivers/media/platform/ti/cal/cal-video.c
+++ b/drivers/media/platform/ti/cal/cal-video.c
@@ -811,7 +811,6 @@ static const struct v4l2_file_operations cal_fops = {
 
 static int cal_ctx_v4l2_init_formats(struct cal_ctx *ctx)
 {
-	struct v4l2_subdev_mbus_code_enum mbus_code;
 	struct v4l2_mbus_framefmt mbus_fmt;
 	const struct cal_format_info *fmtinfo;
 	unsigned int i, j, k;
@@ -826,10 +825,11 @@ static int cal_ctx_v4l2_init_formats(struct cal_ctx *ctx)
 	ctx->num_active_fmt = 0;
 
 	for (j = 0, i = 0; ; ++j) {
+		struct v4l2_subdev_mbus_code_enum mbus_code = {
+			.index = j,
+			.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		};
 
-		memset(&mbus_code, 0, sizeof(mbus_code));
-		mbus_code.index = j;
-		mbus_code.which = V4L2_SUBDEV_FORMAT_ACTIVE;
 		ret = v4l2_subdev_call(ctx->phy->source, pad, enum_mbus_code,
 				       NULL, &mbus_code);
 		if (ret == -EINVAL)
diff --git a/drivers/media/usb/dvb-usb/cxusb-analog.c b/drivers/media/usb/dvb-usb/cxusb-analog.c
index e93183ddd797..deba5224cb8d 100644
--- a/drivers/media/usb/dvb-usb/cxusb-analog.c
+++ b/drivers/media/usb/dvb-usb/cxusb-analog.c
@@ -1014,7 +1014,10 @@ static int cxusb_medion_try_s_fmt_vid_cap(struct file *file,
 {
 	struct dvb_usb_device *dvbdev = video_drvdata(file);
 	struct cxusb_medion_dev *cxdev = dvbdev->priv;
-	struct v4l2_subdev_format subfmt;
+	struct v4l2_subdev_format subfmt = {
+		.which = isset ? V4L2_SUBDEV_FORMAT_ACTIVE :
+			 V4L2_SUBDEV_FORMAT_TRY,
+	};
 	u32 field;
 	int ret;
 
@@ -1024,9 +1027,6 @@ static int cxusb_medion_try_s_fmt_vid_cap(struct file *file,
 	field = vb2_start_streaming_called(&cxdev->videoqueue) ?
 		cxdev->field_order : cxusb_medion_field_order(cxdev);
 
-	memset(&subfmt, 0, sizeof(subfmt));
-	subfmt.which = isset ? V4L2_SUBDEV_FORMAT_ACTIVE :
-		V4L2_SUBDEV_FORMAT_TRY;
 	subfmt.format.width = f->fmt.pix.width & ~1;
 	subfmt.format.height = f->fmt.pix.height & ~1;
 	subfmt.format.code = MEDIA_BUS_FMT_FIXED;
@@ -1464,7 +1464,9 @@ int cxusb_medion_analog_init(struct dvb_usb_device *dvbdev)
 					    .buf = tuner_analog_msg_data,
 					    .len =
 					    sizeof(tuner_analog_msg_data) };
-	struct v4l2_subdev_format subfmt;
+	struct v4l2_subdev_format subfmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
 	int ret;
 
 	/* switch tuner to analog mode so IF demod will become accessible */
@@ -1507,8 +1509,6 @@ int cxusb_medion_analog_init(struct dvb_usb_device *dvbdev)
 	v4l2_subdev_call(cxdev->tuner, video, s_std, cxdev->norm);
 	v4l2_subdev_call(cxdev->cx25840, video, s_std, cxdev->norm);
 
-	memset(&subfmt, 0, sizeof(subfmt));
-	subfmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
 	subfmt.format.width = cxdev->width;
 	subfmt.format.height = cxdev->height;
 	subfmt.format.code = MEDIA_BUS_FMT_FIXED;
diff --git a/drivers/media/usb/pvrusb2/Kconfig b/drivers/media/usb/pvrusb2/Kconfig
index f2b64e49c5a2..9501b10b31aa 100644
--- a/drivers/media/usb/pvrusb2/Kconfig
+++ b/drivers/media/usb/pvrusb2/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_PVRUSB2
 	tristate "Hauppauge WinTV-PVR USB2 support"
-	depends on VIDEO_DEV && I2C
+	depends on VIDEO_DEV && I2C && DVB_CORE
 	select VIDEO_TUNER
 	select VIDEO_TVEEPROM
 	select VIDEO_CX2341X
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 1d35d147552d..42bfc46842b8 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -829,7 +829,7 @@ static void r592_remove(struct pci_dev *pdev)
 	/* Stop the processing thread.
 	That ensures that we won't take any more requests */
 	kthread_stop(dev->io_thread);
-
+	del_timer_sync(&dev->detect_timer);
 	r592_enable_device(dev, false);
 
 	while (!error && dev->req) {
diff --git a/drivers/message/fusion/mptlan.c b/drivers/message/fusion/mptlan.c
index 142eb5d5d9df..de2e7bcf4784 100644
--- a/drivers/message/fusion/mptlan.c
+++ b/drivers/message/fusion/mptlan.c
@@ -1433,7 +1433,9 @@ mptlan_remove(struct pci_dev *pdev)
 {
 	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
 	struct net_device	*dev = ioc->netdev;
+	struct mpt_lan_priv *priv = netdev_priv(dev);
 
+	cancel_delayed_work_sync(&priv->post_buckets_task);
 	if(dev != NULL) {
 		unregister_netdev(dev);
 		free_netdev(dev);
diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 6cd0b0c752d6..c3149729cec2 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -827,6 +827,7 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
+	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index dde31c50a632..699f44ffff0e 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -447,6 +447,21 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x7e79), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7e7a), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7e7b), (kernel_ulong_t)&bxt_i2c_info },
+	/* MTP-S */
+	{ PCI_VDEVICE(INTEL, 0x7f28), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f29), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f2a), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f2b), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4c), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4d), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4e), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4f), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5c), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5d), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5e), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5f), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f7a), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f7b), (kernel_ulong_t)&bxt_i2c_info },
 	/* LKF */
 	{ PCI_VDEVICE(INTEL, 0x98a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x98a9), (kernel_ulong_t)&bxt_uart_info },
diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 9216f0d34206..a82b7cb661b7 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -159,11 +159,19 @@ static const struct dmi_system_id cht_wc_model_dmi_ids[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 		},
 	}, {
-		/* Lenovo Yoga Book X90F / X91F / X91L */
+		/* Lenovo Yoga Book X90F / X90L */
 		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YOGABOOK1,
 		.matches = {
-			/* Non exact match to match all versions */
-			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+		},
+	}, {
+		/* Lenovo Yoga Book X91F / X91L */
+		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YOGABOOK1,
+		.matches = {
+			/* Non exact match to match F + L versions */
+			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
 		},
 	},
 	{ }
diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index 025b133297a6..f1d022160913 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -43,12 +43,14 @@ static void noinstr check_stackleak_irqoff(void)
 	 * STACK_END_MAGIC, and in either casee something is seriously wrong.
 	 */
 	if (current_sp < task_stack_low || current_sp >= task_stack_high) {
+		instrumentation_begin();
 		pr_err("FAIL: current_stack_pointer (0x%lx) outside of task stack bounds [0x%lx..0x%lx]\n",
 		       current_sp, task_stack_low, task_stack_high - 1);
 		test_failed = true;
 		goto out;
 	}
 	if (lowest_sp < task_stack_low || lowest_sp >= task_stack_high) {
+		instrumentation_begin();
 		pr_err("FAIL: current->lowest_stack (0x%lx) outside of task stack bounds [0x%lx..0x%lx]\n",
 		       lowest_sp, task_stack_low, task_stack_high - 1);
 		test_failed = true;
@@ -86,11 +88,14 @@ static void noinstr check_stackleak_irqoff(void)
 		if (*(unsigned long *)poison_low == STACKLEAK_POISON)
 			continue;
 
+		instrumentation_begin();
 		pr_err("FAIL: non-poison value %lu bytes below poison boundary: 0x%lx\n",
 		       poison_high - poison_low, *(unsigned long *)poison_low);
 		test_failed = true;
+		goto out;
 	}
 
+	instrumentation_begin();
 	pr_info("stackleak stack usage:\n"
 		"  high offset: %lu bytes\n"
 		"  current:     %lu bytes\n"
@@ -113,6 +118,7 @@ static void noinstr check_stackleak_irqoff(void)
 	} else {
 		pr_info("OK: the rest of the thread stack is properly erased\n");
 	}
+	instrumentation_end();
 }
 
 static void lkdtm_STACKLEAK_ERASING(void)
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index c2d080fc4fc4..27cbe148f0db 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -84,6 +84,11 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+/* Limit the max delay range to 300s */
+static struct netlink_range_validation delay_range = {
+	.max = 300000,
+};
+
 static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_MODE]		= { .type = NLA_U8 },
 	[IFLA_BOND_ACTIVE_SLAVE]	= { .type = NLA_U32 },
@@ -114,7 +119,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_AD_ACTOR_SYSTEM]	= { .type = NLA_BINARY,
 					    .len  = ETH_ALEN },
 	[IFLA_BOND_TLB_DYNAMIC_LB]	= { .type = NLA_U8 },
-	[IFLA_BOND_PEER_NOTIF_DELAY]    = { .type = NLA_U32 },
+	[IFLA_BOND_PEER_NOTIF_DELAY]    = NLA_POLICY_FULL_RANGE(NLA_U32, &delay_range),
 	[IFLA_BOND_MISSED_MAX]		= { .type = NLA_U8 },
 	[IFLA_BOND_NS_IP6_TARGET]	= { .type = NLA_NESTED },
 };
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 3498db1c1b3c..5bb2c098bf4d 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -169,6 +169,12 @@ static const struct bond_opt_value bond_num_peer_notif_tbl[] = {
 	{ NULL,      -1,  0}
 };
 
+static const struct bond_opt_value bond_peer_notif_delay_tbl[] = {
+	{ "off",     0,   0},
+	{ "maxval",  300000, BOND_VALFLAG_MAX},
+	{ NULL,      -1,  0}
+};
+
 static const struct bond_opt_value bond_primary_reselect_tbl[] = {
 	{ "always",  BOND_PRI_RESELECT_ALWAYS,  BOND_VALFLAG_DEFAULT},
 	{ "better",  BOND_PRI_RESELECT_BETTER,  0},
@@ -488,7 +494,7 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.id = BOND_OPT_PEER_NOTIF_DELAY,
 		.name = "peer_notif_delay",
 		.desc = "Delay between each peer notification on failover event, in milliseconds",
-		.values = bond_intmax_tbl,
+		.values = bond_peer_notif_delay_tbl,
 		.set = bond_option_peer_notif_delay_set
 	}
 };
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 241ec636e91f..f6d05b3ef59a 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -54,7 +54,8 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	/* check flag whether this packet has to be looped back */
 	if (!(dev->flags & IFF_ECHO) ||
 	    (skb->protocol != htons(ETH_P_CAN) &&
-	     skb->protocol != htons(ETH_P_CANFD))) {
+	     skb->protocol != htons(ETH_P_CANFD) &&
+	     skb->protocol != htons(ETH_P_CANXL))) {
 		kfree_skb(skb);
 		return 0;
 	}
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index bcad11709bc9..956a4a57396f 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -71,10 +71,12 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_SYSID_BUILD_REG (KVASER_PCIEFD_SYSID_BASE + 0x14)
 /* Shared receive buffer registers */
 #define KVASER_PCIEFD_SRB_BASE 0x1f200
+#define KVASER_PCIEFD_SRB_FIFO_LAST_REG (KVASER_PCIEFD_SRB_BASE + 0x1f4)
 #define KVASER_PCIEFD_SRB_CMD_REG (KVASER_PCIEFD_SRB_BASE + 0x200)
 #define KVASER_PCIEFD_SRB_IEN_REG (KVASER_PCIEFD_SRB_BASE + 0x204)
 #define KVASER_PCIEFD_SRB_IRQ_REG (KVASER_PCIEFD_SRB_BASE + 0x20c)
 #define KVASER_PCIEFD_SRB_STAT_REG (KVASER_PCIEFD_SRB_BASE + 0x210)
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG (KVASER_PCIEFD_SRB_BASE + 0x214)
 #define KVASER_PCIEFD_SRB_CTRL_REG (KVASER_PCIEFD_SRB_BASE + 0x218)
 /* EPCS flash controller registers */
 #define KVASER_PCIEFD_SPI_BASE 0x1fc00
@@ -111,6 +113,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* DMA support */
 #define KVASER_PCIEFD_SRB_STAT_DMA BIT(24)
 
+/* SRB current packet level */
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK 0xff
+
 /* DMA Enable */
 #define KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE BIT(0)
 
@@ -526,7 +531,7 @@ static int kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 	      KVASER_PCIEFD_KCAN_IRQ_TOF | KVASER_PCIEFD_KCAN_IRQ_ABD |
 	      KVASER_PCIEFD_KCAN_IRQ_TAE | KVASER_PCIEFD_KCAN_IRQ_TAL |
 	      KVASER_PCIEFD_KCAN_IRQ_FDIC | KVASER_PCIEFD_KCAN_IRQ_BPP |
-	      KVASER_PCIEFD_KCAN_IRQ_TAR | KVASER_PCIEFD_KCAN_IRQ_TFD;
+	      KVASER_PCIEFD_KCAN_IRQ_TAR;
 
 	iowrite32(msk, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
@@ -554,6 +559,8 @@ static void kvaser_pciefd_setup_controller(struct kvaser_pciefd_can *can)
 
 	if (can->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		mode |= KVASER_PCIEFD_KCAN_MODE_LOM;
+	else
+		mode &= ~KVASER_PCIEFD_KCAN_MODE_LOM;
 
 	mode |= KVASER_PCIEFD_KCAN_MODE_EEN;
 	mode |= KVASER_PCIEFD_KCAN_MODE_EPEN;
@@ -572,7 +579,7 @@ static void kvaser_pciefd_start_controller_flush(struct kvaser_pciefd_can *can)
 
 	spin_lock_irqsave(&can->lock, irq);
 	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD | KVASER_PCIEFD_KCAN_IRQ_TFD,
+	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 		  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
 	status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
@@ -615,7 +622,7 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
 	iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 
-	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD | KVASER_PCIEFD_KCAN_IRQ_TFD,
+	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 		  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
 	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
@@ -719,6 +726,7 @@ static int kvaser_pciefd_stop(struct net_device *netdev)
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 		del_timer(&can->bec_poll_timer);
 	}
+	can->can.state = CAN_STATE_STOPPED;
 	close_candev(netdev);
 
 	return ret;
@@ -1007,8 +1015,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		SET_NETDEV_DEV(netdev, &pcie->pci->dev);
 
 		iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD |
-			  KVASER_PCIEFD_KCAN_IRQ_TFD,
+		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 			  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
 		pcie->can[i] = can;
@@ -1058,6 +1065,7 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 {
 	int i;
 	u32 srb_status;
+	u32 srb_packet_count;
 	dma_addr_t dma_addr[KVASER_PCIEFD_DMA_COUNT];
 
 	/* Disable the DMA */
@@ -1085,6 +1093,15 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 		  KVASER_PCIEFD_SRB_CMD_RDB1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
 
+	/* Empty Rx FIFO */
+	srb_packet_count = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG) &
+			   KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK;
+	while (srb_packet_count) {
+		/* Drop current packet in FIFO */
+		ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_FIFO_LAST_REG);
+		srb_packet_count--;
+	}
+
 	srb_status = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DI)) {
 		dev_err(&pcie->pci->dev, "DMA not idle before enabling\n");
@@ -1425,9 +1442,6 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
 		cmd = KVASER_PCIEFD_KCAN_CMD_AT;
 		cmd |= ++can->cmd_seq << KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT;
 		iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
-
-		iowrite32(KVASER_PCIEFD_KCAN_IRQ_TFD,
-			  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 	} else if (p->header[0] & KVASER_PCIEFD_SPACK_IDET &&
 		   p->header[0] & KVASER_PCIEFD_SPACK_IRM &&
 		   cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MSK) &&
@@ -1714,15 +1728,6 @@ static int kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 	if (irq & KVASER_PCIEFD_KCAN_IRQ_TOF)
 		netdev_err(can->can.dev, "Tx FIFO overflow\n");
 
-	if (irq & KVASER_PCIEFD_KCAN_IRQ_TFD) {
-		u8 count = ioread32(can->reg_base +
-				    KVASER_PCIEFD_KCAN_TX_NPACKETS_REG) & 0xff;
-
-		if (count == 0)
-			iowrite32(KVASER_PCIEFD_KCAN_CTRL_EFLUSH,
-				  can->reg_base + KVASER_PCIEFD_KCAN_CTRL_REG);
-	}
-
 	if (irq & KVASER_PCIEFD_KCAN_IRQ_BPP)
 		netdev_err(can->can.dev,
 			   "Fail to change bittiming, when not in reset mode\n");
@@ -1824,6 +1829,11 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_teardown_can_ctrls;
 
+	err = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
+			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
+	if (err)
+		goto err_teardown_can_ctrls;
+
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
 
@@ -1844,11 +1854,6 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
 
-	err = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
-			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
-	if (err)
-		goto err_teardown_can_ctrls;
-
 	err = kvaser_pciefd_reg_candev(pcie);
 	if (err)
 		goto err_free_irq;
@@ -1856,6 +1861,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
+	/* Disable PCI interrupts */
+	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_IEN_REG);
 	free_irq(pcie->pci->irq, pcie);
 
 err_teardown_can_ctrls:
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index cb04243f37c1..a91e22d9a6cb 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -276,7 +276,7 @@
 /* Offset 0x10: Extended Port Control Command */
 #define MV88E6393X_PORT_EPC_CMD		0x10
 #define MV88E6393X_PORT_EPC_CMD_BUSY	0x8000
-#define MV88E6393X_PORT_EPC_CMD_WRITE	0x0300
+#define MV88E6393X_PORT_EPC_CMD_WRITE	0x3000
 #define MV88E6393X_PORT_EPC_INDEX_PORT_ETYPE	0x02
 
 /* Offset 0x11: Extended Port Control Data */
diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index ed413d555bec..790e177e2aef 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -120,6 +120,22 @@ static void a5psw_port_mgmtfwd_set(struct a5psw *a5psw, int port, bool enable)
 	a5psw_port_pattern_set(a5psw, port, A5PSW_PATTERN_MGMTFWD, enable);
 }
 
+static void a5psw_port_tx_enable(struct a5psw *a5psw, int port, bool enable)
+{
+	u32 mask = A5PSW_PORT_ENA_TX(port);
+	u32 reg = enable ? mask : 0;
+
+	/* Even though the port TX is disabled through TXENA bit in the
+	 * PORT_ENA register, it can still send BPDUs. This depends on the tag
+	 * configuration added when sending packets from the CPU port to the
+	 * switch port. Indeed, when using forced forwarding without filtering,
+	 * even disabled ports will be able to send packets that are tagged.
+	 * This allows to implement STP support when ports are in a state where
+	 * forwarding traffic should be stopped but BPDUs should still be sent.
+	 */
+	a5psw_reg_rmw(a5psw, A5PSW_PORT_ENA, mask, reg);
+}
+
 static void a5psw_port_enable_set(struct a5psw *a5psw, int port, bool enable)
 {
 	u32 port_ena = 0;
@@ -292,6 +308,22 @@ static int a5psw_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	return 0;
 }
 
+static void a5psw_port_learning_set(struct a5psw *a5psw, int port, bool learn)
+{
+	u32 mask = A5PSW_INPUT_LEARN_DIS(port);
+	u32 reg = !learn ? mask : 0;
+
+	a5psw_reg_rmw(a5psw, A5PSW_INPUT_LEARN, mask, reg);
+}
+
+static void a5psw_port_rx_block_set(struct a5psw *a5psw, int port, bool block)
+{
+	u32 mask = A5PSW_INPUT_LEARN_BLOCK(port);
+	u32 reg = block ? mask : 0;
+
+	a5psw_reg_rmw(a5psw, A5PSW_INPUT_LEARN, mask, reg);
+}
+
 static void a5psw_flooding_set_resolution(struct a5psw *a5psw, int port,
 					  bool set)
 {
@@ -308,6 +340,14 @@ static void a5psw_flooding_set_resolution(struct a5psw *a5psw, int port,
 		a5psw_reg_writel(a5psw, offsets[i], a5psw->bridged_ports);
 }
 
+static void a5psw_port_set_standalone(struct a5psw *a5psw, int port,
+				      bool standalone)
+{
+	a5psw_port_learning_set(a5psw, port, !standalone);
+	a5psw_flooding_set_resolution(a5psw, port, !standalone);
+	a5psw_port_mgmtfwd_set(a5psw, port, standalone);
+}
+
 static int a5psw_port_bridge_join(struct dsa_switch *ds, int port,
 				  struct dsa_bridge bridge,
 				  bool *tx_fwd_offload,
@@ -323,8 +363,7 @@ static int a5psw_port_bridge_join(struct dsa_switch *ds, int port,
 	}
 
 	a5psw->br_dev = bridge.dev;
-	a5psw_flooding_set_resolution(a5psw, port, true);
-	a5psw_port_mgmtfwd_set(a5psw, port, false);
+	a5psw_port_set_standalone(a5psw, port, false);
 
 	return 0;
 }
@@ -334,8 +373,7 @@ static void a5psw_port_bridge_leave(struct dsa_switch *ds, int port,
 {
 	struct a5psw *a5psw = ds->priv;
 
-	a5psw_flooding_set_resolution(a5psw, port, false);
-	a5psw_port_mgmtfwd_set(a5psw, port, true);
+	a5psw_port_set_standalone(a5psw, port, true);
 
 	/* No more ports bridged */
 	if (a5psw->bridged_ports == BIT(A5PSW_CPU_PORT))
@@ -344,28 +382,35 @@ static void a5psw_port_bridge_leave(struct dsa_switch *ds, int port,
 
 static void a5psw_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
-	u32 mask = A5PSW_INPUT_LEARN_DIS(port) | A5PSW_INPUT_LEARN_BLOCK(port);
+	bool learning_enabled, rx_enabled, tx_enabled;
 	struct a5psw *a5psw = ds->priv;
-	u32 reg = 0;
 
 	switch (state) {
 	case BR_STATE_DISABLED:
 	case BR_STATE_BLOCKING:
-		reg |= A5PSW_INPUT_LEARN_DIS(port);
-		reg |= A5PSW_INPUT_LEARN_BLOCK(port);
-		break;
 	case BR_STATE_LISTENING:
-		reg |= A5PSW_INPUT_LEARN_DIS(port);
+		rx_enabled = false;
+		tx_enabled = false;
+		learning_enabled = false;
 		break;
 	case BR_STATE_LEARNING:
-		reg |= A5PSW_INPUT_LEARN_BLOCK(port);
+		rx_enabled = false;
+		tx_enabled = false;
+		learning_enabled = true;
 		break;
 	case BR_STATE_FORWARDING:
-	default:
+		rx_enabled = true;
+		tx_enabled = true;
+		learning_enabled = true;
 		break;
+	default:
+		dev_err(ds->dev, "invalid STP state: %d\n", state);
+		return;
 	}
 
-	a5psw_reg_rmw(a5psw, A5PSW_INPUT_LEARN, mask, reg);
+	a5psw_port_learning_set(a5psw, port, learning_enabled);
+	a5psw_port_rx_block_set(a5psw, port, !rx_enabled);
+	a5psw_port_tx_enable(a5psw, port, tx_enabled);
 }
 
 static void a5psw_port_fast_age(struct dsa_switch *ds, int port)
@@ -673,7 +718,7 @@ static int a5psw_setup(struct dsa_switch *ds)
 	}
 
 	/* Configure management port */
-	reg = A5PSW_CPU_PORT | A5PSW_MGMT_CFG_DISCARD;
+	reg = A5PSW_CPU_PORT | A5PSW_MGMT_CFG_ENABLE;
 	a5psw_reg_writel(a5psw, A5PSW_MGMT_CFG, reg);
 
 	/* Set pattern 0 to forward all frame to mgmt port */
@@ -722,13 +767,15 @@ static int a5psw_setup(struct dsa_switch *ds)
 		if (dsa_port_is_unused(dp))
 			continue;
 
-		/* Enable egress flooding for CPU port */
-		if (dsa_port_is_cpu(dp))
+		/* Enable egress flooding and learning for CPU port */
+		if (dsa_port_is_cpu(dp)) {
 			a5psw_flooding_set_resolution(a5psw, port, true);
+			a5psw_port_learning_set(a5psw, port, true);
+		}
 
-		/* Enable management forward only for user ports */
+		/* Enable standalone mode for user ports */
 		if (dsa_port_is_user(dp))
-			a5psw_port_mgmtfwd_set(a5psw, port, true);
+			a5psw_port_set_standalone(a5psw, port, true);
 	}
 
 	return 0;
diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index c67abd49c013..b869192eef3f 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -19,6 +19,7 @@
 #define A5PSW_PORT_OFFSET(port)		(0x400 * (port))
 
 #define A5PSW_PORT_ENA			0x8
+#define A5PSW_PORT_ENA_TX(port)		BIT(port)
 #define A5PSW_PORT_ENA_RX_SHIFT		16
 #define A5PSW_PORT_ENA_TX_RX(port)	(BIT((port) + A5PSW_PORT_ENA_RX_SHIFT) | \
 					 BIT(port))
@@ -36,7 +37,7 @@
 #define A5PSW_INPUT_LEARN_BLOCK(p)	BIT(p)
 
 #define A5PSW_MGMT_CFG			0x20
-#define A5PSW_MGMT_CFG_DISCARD		BIT(7)
+#define A5PSW_MGMT_CFG_ENABLE		BIT(6)
 
 #define A5PSW_MODE_CFG			0x24
 #define A5PSW_MODE_STATS_RESET		BIT(31)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 01b973bc509f..b2d531e014c5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2822,7 +2822,7 @@ static int bnxt_get_nvram_directory(struct net_device *dev, u32 len, u8 *data)
 	if (rc)
 		return rc;
 
-	buflen = dir_entries * entry_length;
+	buflen = mul_u32_u32(dir_entries, entry_length);
 	buf = hwrm_req_dma_slice(bp, req, buflen, &dma_handle);
 	if (!buf) {
 		hwrm_req_drop(bp, req);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index f679ed54b3ef..4da2becfa950 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3445,7 +3445,7 @@ static int bcmgenet_open(struct net_device *dev)
 	return ret;
 }
 
-static void bcmgenet_netif_stop(struct net_device *dev)
+static void bcmgenet_netif_stop(struct net_device *dev, bool stop_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
@@ -3460,7 +3460,8 @@ static void bcmgenet_netif_stop(struct net_device *dev)
 	/* Disable MAC transmit. TX DMA disabled must be done before this */
 	umac_enable_set(priv, CMD_TX_EN, false);
 
-	phy_stop(dev->phydev);
+	if (stop_phy)
+		phy_stop(dev->phydev);
 	bcmgenet_disable_rx_napi(priv);
 	bcmgenet_intr_disable(priv);
 
@@ -3481,7 +3482,7 @@ static int bcmgenet_close(struct net_device *dev)
 
 	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
 
-	bcmgenet_netif_stop(dev);
+	bcmgenet_netif_stop(dev, false);
 
 	/* Really kill the PHY state machine and disconnect from it */
 	phy_disconnect(dev->phydev);
@@ -4299,7 +4300,7 @@ static int bcmgenet_suspend(struct device *d)
 
 	netif_device_detach(dev);
 
-	bcmgenet_netif_stop(dev);
+	bcmgenet_netif_stop(dev, true);
 
 	if (!device_may_wakeup(d))
 		phy_suspend(dev->phydev);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 6f914180f479..33226a22d8a4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4168,9 +4168,11 @@ fec_drv_remove(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
-		return ret;
+		dev_err(&pdev->dev,
+			"Failed to resume device in remove callback (%pe)\n",
+			ERR_PTR(ret));
 
 	cancel_work_sync(&fep->tx_timeout_work);
 	fec_ptp_stop(pdev);
@@ -4183,8 +4185,13 @@ fec_drv_remove(struct platform_device *pdev)
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
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index d3e3ac242bfc..2e5e0a887270 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -239,19 +239,6 @@ static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 	bool reschedule = false;
 	int work_done = 0;
 
-	/* Clear PCI MSI-X Pending Bit Array (PBA)
-	 *
-	 * This bit is set if an interrupt event occurs while the vector is
-	 * masked. If this bit is set and we reenable the interrupt, it will
-	 * fire again. Since we're just about to poll the queue state, we don't
-	 * need it to fire again.
-	 *
-	 * Under high softirq load, it's possible that the interrupt condition
-	 * is triggered twice before we got the chance to process it.
-	 */
-	gve_write_irq_doorbell_dqo(priv, block,
-				   GVE_ITR_NO_UPDATE_DQO | GVE_ITR_CLEAR_PBA_BIT_DQO);
-
 	if (block->tx)
 		reschedule |= gve_tx_poll_dqo(block, /*do_clean=*/true);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
index f671a63cecde..c797d54f98ca 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
@@ -330,9 +330,25 @@ static int hclge_comm_cmd_csq_done(struct hclge_comm_hw *hw)
 	return head == hw->cmq.csq.next_to_use;
 }
 
-static void hclge_comm_wait_for_resp(struct hclge_comm_hw *hw,
+static u32 hclge_get_cmdq_tx_timeout(u16 opcode, u32 tx_timeout)
+{
+	static const struct hclge_cmdq_tx_timeout_map cmdq_tx_timeout_map[] = {
+		{HCLGE_OPC_CFG_RST_TRIGGER, HCLGE_COMM_CMDQ_TX_TIMEOUT_500MS},
+	};
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(cmdq_tx_timeout_map); i++)
+		if (cmdq_tx_timeout_map[i].opcode == opcode)
+			return cmdq_tx_timeout_map[i].tx_timeout;
+
+	return tx_timeout;
+}
+
+static void hclge_comm_wait_for_resp(struct hclge_comm_hw *hw, u16 opcode,
 				     bool *is_completed)
 {
+	u32 cmdq_tx_timeout = hclge_get_cmdq_tx_timeout(opcode,
+							hw->cmq.tx_timeout);
 	u32 timeout = 0;
 
 	do {
@@ -342,7 +358,7 @@ static void hclge_comm_wait_for_resp(struct hclge_comm_hw *hw,
 		}
 		udelay(1);
 		timeout++;
-	} while (timeout < hw->cmq.tx_timeout);
+	} while (timeout < cmdq_tx_timeout);
 }
 
 static int hclge_comm_cmd_convert_err_code(u16 desc_ret)
@@ -406,7 +422,8 @@ static int hclge_comm_cmd_check_result(struct hclge_comm_hw *hw,
 	 * if multi descriptors to be sent, use the first one to check
 	 */
 	if (HCLGE_COMM_SEND_SYNC(le16_to_cpu(desc->flag)))
-		hclge_comm_wait_for_resp(hw, &is_completed);
+		hclge_comm_wait_for_resp(hw, le16_to_cpu(desc->opcode),
+					 &is_completed);
 
 	if (!is_completed)
 		ret = -EBADE;
@@ -528,7 +545,7 @@ int hclge_comm_cmd_queue_init(struct pci_dev *pdev, struct hclge_comm_hw *hw)
 	cmdq->crq.desc_num = HCLGE_COMM_NIC_CMQ_DESC_NUM;
 
 	/* Setup Tx write back timeout */
-	cmdq->tx_timeout = HCLGE_COMM_CMDQ_TX_TIMEOUT;
+	cmdq->tx_timeout = HCLGE_COMM_CMDQ_TX_TIMEOUT_DEFAULT;
 
 	/* Setup queue rings */
 	ret = hclge_comm_alloc_cmd_queue(hw, HCLGE_COMM_TYPE_CSQ);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
index b1f9383b418f..2b2928c6dccf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
@@ -54,7 +54,8 @@
 #define HCLGE_COMM_NIC_SW_RST_RDY		BIT(HCLGE_COMM_NIC_SW_RST_RDY_B)
 #define HCLGE_COMM_NIC_CMQ_DESC_NUM_S		3
 #define HCLGE_COMM_NIC_CMQ_DESC_NUM		1024
-#define HCLGE_COMM_CMDQ_TX_TIMEOUT		30000
+#define HCLGE_COMM_CMDQ_TX_TIMEOUT_DEFAULT	30000
+#define HCLGE_COMM_CMDQ_TX_TIMEOUT_500MS	500000
 
 enum hclge_opcode_type {
 	/* Generic commands */
@@ -357,6 +358,11 @@ struct hclge_comm_caps_bit_map {
 	u16 local_bit;
 };
 
+struct hclge_cmdq_tx_timeout_map {
+	u32 opcode;
+	u32 tx_timeout;
+};
+
 struct hclge_comm_firmware_compat_cmd {
 	__le32 compat;
 	u8 rsv[20];
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 66feb23f7b7b..bcccd82a2620 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -130,7 +130,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.name = "tx_bd_queue",
 		.cmd = HNAE3_DBG_CMD_TX_BD,
 		.dentry = HNS3_DBG_DENTRY_TX_BD,
-		.buf_len = HNS3_DBG_READ_LEN_4MB,
+		.buf_len = HNS3_DBG_READ_LEN_5MB,
 		.init = hns3_dbg_bd_file_init,
 	},
 	{
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
index 97578eabb7d8..4a5ef8a90a10 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
@@ -10,6 +10,7 @@
 #define HNS3_DBG_READ_LEN_128KB	0x20000
 #define HNS3_DBG_READ_LEN_1MB	0x100000
 #define HNS3_DBG_READ_LEN_4MB	0x400000
+#define HNS3_DBG_READ_LEN_5MB	0x500000
 #define HNS3_DBG_WRITE_LEN	1024
 
 #define HNS3_DBG_DATA_STR_LEN	32
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 07ad5f35219e..50e956d6c3b2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -8053,12 +8053,15 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 	/* If it is not PF reset or FLR, the firmware will disable the MAC,
 	 * so it only need to stop phy here.
 	 */
-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) &&
-	    hdev->reset_type != HNAE3_FUNC_RESET &&
-	    hdev->reset_type != HNAE3_FLR_RESET) {
-		hclge_mac_stop_phy(hdev);
-		hclge_update_link_status(hdev);
-		return;
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state)) {
+		hclge_pfc_pause_en_cfg(hdev, HCLGE_PFC_TX_RX_DISABLE,
+				       HCLGE_PFC_DISABLE);
+		if (hdev->reset_type != HNAE3_FUNC_RESET &&
+		    hdev->reset_type != HNAE3_FLR_RESET) {
+			hclge_mac_stop_phy(hdev);
+			hclge_update_link_status(hdev);
+			return;
+		}
 	}
 
 	hclge_reset_tqp(handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 4a33f65190e2..922c0da3660c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -171,8 +171,8 @@ int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx)
 	return hclge_cmd_send(&hdev->hw, &desc, 1);
 }
 
-static int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
-				  u8 pfc_bitmap)
+int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
+			   u8 pfc_bitmap)
 {
 	struct hclge_desc desc;
 	struct hclge_pfc_en_cmd *pfc = (struct hclge_pfc_en_cmd *)desc.data;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 68f28a98e380..dd6f1fd486cf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -164,6 +164,9 @@ struct hclge_bp_to_qs_map_cmd {
 	u32 rsvd1;
 };
 
+#define HCLGE_PFC_DISABLE	0
+#define HCLGE_PFC_TX_RX_DISABLE	0
+
 struct hclge_pfc_en_cmd {
 	u8 tx_rx_en_bitmap;
 	u8 pri_en_bitmap;
@@ -235,6 +238,8 @@ void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc);
 void hclge_tm_pfc_info_update(struct hclge_dev *hdev);
 int hclge_tm_dwrr_cfg(struct hclge_dev *hdev);
 int hclge_tm_init_hw(struct hclge_dev *hdev, bool init);
+int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
+			   u8 pfc_bitmap);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
 int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
 void hclge_pfc_rx_stats_get(struct hclge_dev *hdev, u64 *stats);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index e84e5be8e59e..b1b14850e958 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1436,7 +1436,10 @@ static int hclgevf_reset_wait(struct hclgevf_dev *hdev)
 	 * might happen in case reset assertion was made by PF. Yes, this also
 	 * means we might end up waiting bit more even for VF reset.
 	 */
-	msleep(5000);
+	if (hdev->reset_type == HNAE3_VF_FULL_RESET)
+		msleep(5000);
+	else
+		msleep(500);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cfc57cfc46e4..6a50f8ba3940 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -573,7 +573,7 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	/* Disable VFs until reset is completed */
 	mutex_lock(&pf->vfs.table_lock);
 	ice_for_each_vf(pf, bkt, vf)
-		ice_set_vf_state_qs_dis(vf);
+		ice_set_vf_state_dis(vf);
 	mutex_unlock(&pf->vfs.table_lock);
 
 	if (ice_is_eswitch_mode_switchdev(pf)) {
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index b3849bc3d4fc..b8c31bf721ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -696,6 +696,21 @@ static void ice_sriov_free_vf(struct ice_vf *vf)
 	kfree_rcu(vf, rcu);
 }
 
+/**
+ * ice_sriov_clear_reset_state - clears VF Reset status register
+ * @vf: the vf to configure
+ */
+static void ice_sriov_clear_reset_state(struct ice_vf *vf)
+{
+	struct ice_hw *hw = &vf->pf->hw;
+
+	/* Clear the reset status register so that VF immediately sees that
+	 * the device is resetting, even if hardware hasn't yet gotten around
+	 * to clearing VFGEN_RSTAT for us.
+	 */
+	wr32(hw, VFGEN_RSTAT(vf->vf_id), VIRTCHNL_VFR_INPROGRESS);
+}
+
 /**
  * ice_sriov_clear_mbx_register - clears SRIOV VF's mailbox registers
  * @vf: the vf to configure
@@ -835,6 +850,7 @@ static void ice_sriov_post_vsi_rebuild(struct ice_vf *vf)
 static const struct ice_vf_ops ice_sriov_vf_ops = {
 	.reset_type = ICE_VF_RESET,
 	.free = ice_sriov_free_vf,
+	.clear_reset_state = ice_sriov_clear_reset_state,
 	.clear_mbx_register = ice_sriov_clear_mbx_register,
 	.trigger_reset_register = ice_sriov_trigger_reset_register,
 	.poll_reset_status = ice_sriov_poll_reset_status,
@@ -1224,7 +1240,7 @@ int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
 	if (!vf)
 		return -EINVAL;
 
-	ret = ice_check_vf_ready_for_cfg(vf);
+	ret = ice_check_vf_ready_for_reset(vf);
 	if (ret)
 		goto out_put_vf;
 
@@ -1339,7 +1355,7 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		goto out_put_vf;
 	}
 
-	ret = ice_check_vf_ready_for_cfg(vf);
+	ret = ice_check_vf_ready_for_reset(vf);
 	if (ret)
 		goto out_put_vf;
 
@@ -1393,7 +1409,7 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 		return -EOPNOTSUPP;
 	}
 
-	ret = ice_check_vf_ready_for_cfg(vf);
+	ret = ice_check_vf_ready_for_reset(vf);
 	if (ret)
 		goto out_put_vf;
 
@@ -1706,7 +1722,7 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 	if (!vf)
 		return -EINVAL;
 
-	ret = ice_check_vf_ready_for_cfg(vf);
+	ret = ice_check_vf_ready_for_reset(vf);
 	if (ret)
 		goto out_put_vf;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 1c51778db951..71047fc34139 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -185,6 +185,25 @@ int ice_check_vf_ready_for_cfg(struct ice_vf *vf)
 	return 0;
 }
 
+/**
+ * ice_check_vf_ready_for_reset - check if VF is ready to be reset
+ * @vf: VF to check if it's ready to be reset
+ *
+ * The purpose of this function is to ensure that the VF is not in reset,
+ * disabled, and is both initialized and active, thus enabling us to safely
+ * initialize another reset.
+ */
+int ice_check_vf_ready_for_reset(struct ice_vf *vf)
+{
+	int ret;
+
+	ret = ice_check_vf_ready_for_cfg(vf);
+	if (!ret && !test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+		ret = -EAGAIN;
+
+	return ret;
+}
+
 /**
  * ice_trigger_vf_reset - Reset a VF on HW
  * @vf: pointer to the VF structure
@@ -673,7 +692,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
  * ice_set_vf_state_qs_dis - Set VF queues state to disabled
  * @vf: pointer to the VF structure
  */
-void ice_set_vf_state_qs_dis(struct ice_vf *vf)
+static void ice_set_vf_state_qs_dis(struct ice_vf *vf)
 {
 	/* Clear Rx/Tx enabled queues flag */
 	bitmap_zero(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
@@ -681,6 +700,16 @@ void ice_set_vf_state_qs_dis(struct ice_vf *vf)
 	clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
 }
 
+/**
+ * ice_set_vf_state_dis - Set VF state to disabled
+ * @vf: pointer to the VF structure
+ */
+void ice_set_vf_state_dis(struct ice_vf *vf)
+{
+	ice_set_vf_state_qs_dis(vf);
+	vf->vf_ops->clear_reset_state(vf);
+}
+
 /* Private functions only accessed from other virtualization files */
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 52bd9a3816bf..e5bed8572462 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -56,6 +56,7 @@ struct ice_mdd_vf_events {
 struct ice_vf_ops {
 	enum ice_disq_rst_src reset_type;
 	void (*free)(struct ice_vf *vf);
+	void (*clear_reset_state)(struct ice_vf *vf);
 	void (*clear_mbx_register)(struct ice_vf *vf);
 	void (*trigger_reset_register)(struct ice_vf *vf, bool is_vflr);
 	bool (*poll_reset_status)(struct ice_vf *vf);
@@ -213,7 +214,8 @@ u16 ice_get_num_vfs(struct ice_pf *pf);
 struct ice_vsi *ice_get_vf_vsi(struct ice_vf *vf);
 bool ice_is_vf_disabled(struct ice_vf *vf);
 int ice_check_vf_ready_for_cfg(struct ice_vf *vf);
-void ice_set_vf_state_qs_dis(struct ice_vf *vf);
+int ice_check_vf_ready_for_reset(struct ice_vf *vf);
+void ice_set_vf_state_dis(struct ice_vf *vf);
 bool ice_is_any_vf_in_unicast_promisc(struct ice_pf *pf);
 void
 ice_vf_get_promisc_masks(struct ice_vf *vf, struct ice_vsi *vsi,
@@ -259,7 +261,7 @@ static inline int ice_check_vf_ready_for_cfg(struct ice_vf *vf)
 	return -EOPNOTSUPP;
 }
 
-static inline void ice_set_vf_state_qs_dis(struct ice_vf *vf)
+static inline void ice_set_vf_state_dis(struct ice_vf *vf)
 {
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 2b4c791b6cba..ef3c709d6a75 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3722,6 +3722,7 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
 		ice_vc_notify_vf_link_state(vf);
 		break;
 	case VIRTCHNL_OP_RESET_VF:
+		clear_bit(ICE_VF_STATE_ACTIVE, vf->vf_states);
 		ops->reset_vf(vf);
 		break;
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index 205d577bdbba..caf91c6f52b4 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -426,7 +426,7 @@ void igb_mta_set(struct e1000_hw *hw, u32 hash_value)
 static u32 igb_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
 {
 	u32 hash_value, hash_mask;
-	u8 bit_shift = 0;
+	u8 bit_shift = 1;
 
 	/* Register count multiplied by bits per register */
 	hash_mask = (hw->mac.mta_reg_count * 32) - 1;
@@ -434,7 +434,7 @@ static u32 igb_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
 	/* For a mc_filter_type of 0, bit_shift is the number of left-shifts
 	 * where 0xFF would still fall within the hash mask.
 	 */
-	while (hash_mask >> bit_shift != 0xFF)
+	while (hash_mask >> bit_shift != 0xFF && bit_shift < 4)
 		bit_shift++;
 
 	/* The portion of the address that is used for the hash table
diff --git a/drivers/net/ethernet/mscc/vsc7514_regs.c b/drivers/net/ethernet/mscc/vsc7514_regs.c
index 9d2d3e13cacf..66c428419614 100644
--- a/drivers/net/ethernet/mscc/vsc7514_regs.c
+++ b/drivers/net/ethernet/mscc/vsc7514_regs.c
@@ -252,15 +252,15 @@ const u32 vsc7514_sys_regmap[] = {
 	REG(SYS_COUNT_DROP_YELLOW_PRIO_4,		0x000218),
 	REG(SYS_COUNT_DROP_YELLOW_PRIO_5,		0x00021c),
 	REG(SYS_COUNT_DROP_YELLOW_PRIO_6,		0x000220),
-	REG(SYS_COUNT_DROP_YELLOW_PRIO_7,		0x000214),
-	REG(SYS_COUNT_DROP_GREEN_PRIO_0,		0x000218),
-	REG(SYS_COUNT_DROP_GREEN_PRIO_1,		0x00021c),
-	REG(SYS_COUNT_DROP_GREEN_PRIO_2,		0x000220),
-	REG(SYS_COUNT_DROP_GREEN_PRIO_3,		0x000224),
-	REG(SYS_COUNT_DROP_GREEN_PRIO_4,		0x000228),
-	REG(SYS_COUNT_DROP_GREEN_PRIO_5,		0x00022c),
-	REG(SYS_COUNT_DROP_GREEN_PRIO_6,		0x000230),
-	REG(SYS_COUNT_DROP_GREEN_PRIO_7,		0x000234),
+	REG(SYS_COUNT_DROP_YELLOW_PRIO_7,		0x000224),
+	REG(SYS_COUNT_DROP_GREEN_PRIO_0,		0x000228),
+	REG(SYS_COUNT_DROP_GREEN_PRIO_1,		0x00022c),
+	REG(SYS_COUNT_DROP_GREEN_PRIO_2,		0x000230),
+	REG(SYS_COUNT_DROP_GREEN_PRIO_3,		0x000234),
+	REG(SYS_COUNT_DROP_GREEN_PRIO_4,		0x000238),
+	REG(SYS_COUNT_DROP_GREEN_PRIO_5,		0x00023c),
+	REG(SYS_COUNT_DROP_GREEN_PRIO_6,		0x000240),
+	REG(SYS_COUNT_DROP_GREEN_PRIO_7,		0x000244),
 	REG(SYS_RESET_CFG,				0x000508),
 	REG(SYS_CMID,					0x00050c),
 	REG(SYS_VLAN_ETYPE_CFG,				0x000510),
diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index aaab590ef548..ed7dd0a04235 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1423,7 +1423,7 @@ static void pasemi_mac_queue_csdesc(const struct sk_buff *skb,
 	write_dma_reg(PAS_DMA_TXCHAN_INCR(txring->chan.chno), 2);
 }
 
-static int pasemi_mac_start_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t pasemi_mac_start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct pasemi_mac * const mac = netdev_priv(dev);
 	struct pasemi_mac_txring * const txring = tx_ring(mac);
diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
index ddcc325ed570..c6b9ba6803c8 100644
--- a/drivers/net/ethernet/sfc/ef100_netdev.c
+++ b/drivers/net/ethernet/sfc/ef100_netdev.c
@@ -372,7 +372,9 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
 	efx->net_dev = net_dev;
 	SET_NETDEV_DEV(net_dev, &efx->pci_dev->dev);
 
-	net_dev->features |= efx->type->offload_features;
+	/* enable all supported features except rx-fcs and rx-all */
+	net_dev->features |= efx->type->offload_features &
+			     ~(NETIF_F_RXFCS | NETIF_F_RXALL);
 	net_dev->hw_features |= efx->type->offload_features;
 	net_dev->hw_enc_features |= efx->type->offload_features;
 	net_dev->vlan_features |= NETIF_F_HW_CSUM | NETIF_F_SG |
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 71dad409f78b..12c0e60809f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -181,6 +181,7 @@ enum power_event {
 #define GMAC4_LPI_CTRL_STATUS	0xd0
 #define GMAC4_LPI_TIMER_CTRL	0xd4
 #define GMAC4_LPI_ENTRY_TIMER	0xd8
+#define GMAC4_MAC_ONEUS_TIC_COUNTER	0xdc
 
 /* LPI control and status defines */
 #define GMAC4_LPI_CTRL_STATUS_LPITCSE	BIT(21)	/* LPI Tx Clock Stop Enable */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 188a00065f66..84276eb681d7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -25,6 +25,7 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 	struct stmmac_priv *priv = netdev_priv(dev);
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONFIG);
+	u32 clk_rate;
 
 	value |= GMAC_CORE_INIT;
 
@@ -47,6 +48,10 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 
 	writel(value, ioaddr + GMAC_CONFIG);
 
+	/* Configure LPI 1us counter to number of CSR clock ticks in 1us - 1 */
+	clk_rate = clk_get_rate(priv->plat->stmmac_clk);
+	writel((clk_rate / 1000000) - 1, ioaddr + GMAC4_MAC_ONEUS_TIC_COUNTER);
+
 	/* Enable GMAC interrupts */
 	value = GMAC_INT_DEFAULT_ENABLE;
 
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 0aca193d9550..800956d5464b 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -5095,6 +5095,8 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		cas_shutdown(cp);
 	mutex_unlock(&cp->pm_mutex);
 
+	vfree(cp->fw_data);
+
 	pci_iounmap(pdev, cp->regs);
 
 
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index bb1c298c1e78..2de3bd3b0c27 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -436,6 +436,9 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
 		goto err;
 	}
 	skb_dst_set(skb, &rt->dst);
+
+	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+
 	err = ip_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		dev->stats.tx_errors++;
@@ -474,6 +477,9 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 		goto err;
 	}
 	skb_dst_set(skb, dst);
+
+	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+
 	err = ip6_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		dev->stats.tx_errors++;
diff --git a/drivers/net/mdio/mdio-mvusb.c b/drivers/net/mdio/mdio-mvusb.c
index d5eabddfdf51..11e048136ac2 100644
--- a/drivers/net/mdio/mdio-mvusb.c
+++ b/drivers/net/mdio/mdio-mvusb.c
@@ -73,6 +73,7 @@ static int mvusb_mdio_probe(struct usb_interface *interface,
 	struct device *dev = &interface->dev;
 	struct mvusb_mdio *mvusb;
 	struct mii_bus *mdio;
+	int ret;
 
 	mdio = devm_mdiobus_alloc_size(dev, sizeof(*mvusb));
 	if (!mdio)
@@ -93,7 +94,15 @@ static int mvusb_mdio_probe(struct usb_interface *interface,
 	mdio->write = mvusb_mdio_write;
 
 	usb_set_intfdata(interface, mvusb);
-	return of_mdiobus_register(mdio, dev->of_node);
+	ret = of_mdiobus_register(mdio, dev->of_node);
+	if (ret)
+		goto put_dev;
+
+	return 0;
+
+put_dev:
+	usb_put_dev(mvusb->udev);
+	return ret;
 }
 
 static void mvusb_mdio_disconnect(struct usb_interface *interface)
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index dd88624593c7..3f882bce37f4 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -881,7 +881,7 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 
 	switch (compat->an_mode) {
 	case DW_AN_C73:
-		if (phylink_autoneg_inband(mode)) {
+		if (test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, advertising)) {
 			ret = xpcs_config_aneg_c73(xpcs, compat);
 			if (ret)
 				return ret;
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index 9902fb182099..729db441797a 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -40,6 +40,11 @@ static inline int bcm_phy_write_exp_sel(struct phy_device *phydev,
 	return bcm_phy_write_exp(phydev, reg | MII_BCM54XX_EXP_SEL_ER, val);
 }
 
+static inline int bcm_phy_read_exp_sel(struct phy_device *phydev, u16 reg)
+{
+	return bcm_phy_read_exp(phydev, reg | MII_BCM54XX_EXP_SEL_ER);
+}
+
 int bcm54xx_auxctl_write(struct phy_device *phydev, u16 regnum, u16 val);
 int bcm54xx_auxctl_read(struct phy_device *phydev, u16 regnum);
 
diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 75593e7d1118..6cebf3aaa621 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -487,7 +487,7 @@ static int bcm7xxx_16nm_ephy_afe_config(struct phy_device *phydev)
 	bcm_phy_write_misc(phydev, 0x0038, 0x0002, 0xede0);
 
 	/* Read CORE_EXPA9 */
-	tmp = bcm_phy_read_exp(phydev, 0x00a9);
+	tmp = bcm_phy_read_exp_sel(phydev, 0x00a9);
 	/* CORE_EXPA9[6:1] is rcalcode[5:0] */
 	rcalcode = (tmp & 0x7e) / 2;
 	/* Correct RCAL code + 1 is -1% rprogr, LP: +16 */
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 7446d5c6c714..14990f8462ae 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -42,6 +42,7 @@
 #define DP83867_STRAP_STS1	0x006E
 #define DP83867_STRAP_STS2	0x006f
 #define DP83867_RGMIIDCTL	0x0086
+#define DP83867_DSP_FFE_CFG	0x012c
 #define DP83867_RXFCFG		0x0134
 #define DP83867_RXFPMD1	0x0136
 #define DP83867_RXFPMD2	0x0137
@@ -910,8 +911,27 @@ static int dp83867_phy_reset(struct phy_device *phydev)
 
 	usleep_range(10, 20);
 
-	return phy_modify(phydev, MII_DP83867_PHYCTRL,
+	err = phy_modify(phydev, MII_DP83867_PHYCTRL,
 			 DP83867_PHYCR_FORCE_LINK_GOOD, 0);
+	if (err < 0)
+		return err;
+
+	/* Configure the DSP Feedforward Equalizer Configuration register to
+	 * improve short cable (< 1 meter) performance. This will not affect
+	 * long cable performance.
+	 */
+	err = phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_DSP_FFE_CFG,
+			    0x0e81);
+	if (err < 0)
+		return err;
+
+	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESTART);
+	if (err < 0)
+		return err;
+
+	usleep_range(10, 20);
+
+	return 0;
 }
 
 static void dp83867_link_change_notify(struct phy_device *phydev)
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 760d8d1b6cba..3c468ef8f245 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -739,7 +739,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	/* Move network header to the right position for VLAN tagged packets */
 	if (eth_type_vlan(skb->protocol) &&
-	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
+	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
 	/* copy skb_ubuf_info for callback when skb has no error */
@@ -1180,7 +1180,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	/* Move network header to the right position for VLAN tagged packets */
 	if (eth_type_vlan(skb->protocol) &&
-	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
+	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
 	rcu_read_lock();
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 91d198aff2f9..7c8db8f6f661 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1748,7 +1748,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	u32 rxhash = 0;
 	int skb_xdp = 1;
 	bool frags = tun_napi_frags_enabled(tfile);
-	enum skb_drop_reason drop_reason;
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (!(tun->flags & IFF_NO_PI)) {
 		if (len < sizeof(pi))
@@ -1809,10 +1809,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * skb was created with generic XDP routine.
 		 */
 		skb = tun_build_skb(tun, tfile, from, &gso, len, &skb_xdp);
-		if (IS_ERR(skb)) {
-			dev_core_stats_rx_dropped_inc(tun->dev);
-			return PTR_ERR(skb);
-		}
+		err = PTR_ERR_OR_ZERO(skb);
+		if (err)
+			goto drop;
 		if (!skb)
 			return total_len;
 	} else {
@@ -1837,13 +1836,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 					    noblock);
 		}
 
-		if (IS_ERR(skb)) {
-			if (PTR_ERR(skb) != -EAGAIN)
-				dev_core_stats_rx_dropped_inc(tun->dev);
-			if (frags)
-				mutex_unlock(&tfile->napi_mutex);
-			return PTR_ERR(skb);
-		}
+		err = PTR_ERR_OR_ZERO(skb);
+		if (err)
+			goto drop;
 
 		if (zerocopy)
 			err = zerocopy_sg_from_iter(skb, from);
@@ -1853,27 +1848,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		if (err) {
 			err = -EFAULT;
 			drop_reason = SKB_DROP_REASON_SKB_UCOPY_FAULT;
-drop:
-			dev_core_stats_rx_dropped_inc(tun->dev);
-			kfree_skb_reason(skb, drop_reason);
-			if (frags) {
-				tfile->napi.skb = NULL;
-				mutex_unlock(&tfile->napi_mutex);
-			}
-
-			return err;
+			goto drop;
 		}
 	}
 
 	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun))) {
 		atomic_long_inc(&tun->rx_frame_errors);
-		kfree_skb(skb);
-		if (frags) {
-			tfile->napi.skb = NULL;
-			mutex_unlock(&tfile->napi_mutex);
-		}
-
-		return -EINVAL;
+		err = -EINVAL;
+		goto free_skb;
 	}
 
 	switch (tun->flags & TUN_TYPE_MASK) {
@@ -1889,9 +1871,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 				pi.proto = htons(ETH_P_IPV6);
 				break;
 			default:
-				dev_core_stats_rx_dropped_inc(tun->dev);
-				kfree_skb(skb);
-				return -EINVAL;
+				err = -EINVAL;
+				goto drop;
 			}
 		}
 
@@ -1933,11 +1914,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			if (ret != XDP_PASS) {
 				rcu_read_unlock();
 				local_bh_enable();
-				if (frags) {
-					tfile->napi.skb = NULL;
-					mutex_unlock(&tfile->napi_mutex);
-				}
-				return total_len;
+				goto unlock_frags;
 			}
 		}
 		rcu_read_unlock();
@@ -1994,6 +1971,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		int queue_len;
 
 		spin_lock_bh(&queue->lock);
+
+		if (unlikely(tfile->detached)) {
+			spin_unlock_bh(&queue->lock);
+			rcu_read_unlock();
+			err = -EBUSY;
+			goto free_skb;
+		}
+
 		__skb_queue_tail(queue, skb);
 		queue_len = skb_queue_len(queue);
 		spin_unlock(&queue->lock);
@@ -2017,6 +2002,22 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		tun_flow_update(tun, rxhash, tfile);
 
 	return total_len;
+
+drop:
+	if (err != -EAGAIN)
+		dev_core_stats_rx_dropped_inc(tun->dev);
+
+free_skb:
+	if (!IS_ERR_OR_NULL(skb))
+		kfree_skb_reason(skb, drop_reason);
+
+unlock_frags:
+	if (frags) {
+		tfile->napi.skb = NULL;
+		mutex_unlock(&tfile->napi_mutex);
+	}
+
+	return err ?: total_len;
 }
 
 static ssize_t tun_chr_write_iter(struct kiocb *iocb, struct iov_iter *from)
@@ -2513,6 +2514,13 @@ static int tun_xdp_one(struct tun_struct *tun,
 	if (tfile->napi_enabled) {
 		queue = &tfile->sk.sk_write_queue;
 		spin_lock(&queue->lock);
+
+		if (unlikely(tfile->detached)) {
+			spin_unlock(&queue->lock);
+			kfree_skb(skb);
+			return -EBUSY;
+		}
+
 		__skb_queue_tail(queue, skb);
 		spin_unlock(&queue->lock);
 		ret = 1;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9a612b13b4e4..47788f093551 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1697,6 +1697,38 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	return received;
 }
 
+static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
+{
+	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
+	napi_disable(&vi->rq[qp_index].napi);
+	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
+}
+
+static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
+{
+	struct net_device *dev = vi->dev;
+	int err;
+
+	err = xdp_rxq_info_reg(&vi->rq[qp_index].xdp_rxq, dev, qp_index,
+			       vi->rq[qp_index].napi.napi_id);
+	if (err < 0)
+		return err;
+
+	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
+					 MEM_TYPE_PAGE_SHARED, NULL);
+	if (err < 0)
+		goto err_xdp_reg_mem_model;
+
+	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
+	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
+
+	return 0;
+
+err_xdp_reg_mem_model:
+	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
+	return err;
+}
+
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -1710,22 +1742,20 @@ static int virtnet_open(struct net_device *dev)
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
 				schedule_delayed_work(&vi->refill, 0);
 
-		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i, vi->rq[i].napi.napi_id);
+		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
-			return err;
-
-		err = xdp_rxq_info_reg_mem_model(&vi->rq[i].xdp_rxq,
-						 MEM_TYPE_PAGE_SHARED, NULL);
-		if (err < 0) {
-			xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
-			return err;
-		}
-
-		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-		virtnet_napi_tx_enable(vi, vi->sq[i].vq, &vi->sq[i].napi);
+			goto err_enable_qp;
 	}
 
 	return 0;
+
+err_enable_qp:
+	disable_delayed_refill(vi);
+	cancel_delayed_work_sync(&vi->refill);
+
+	for (i--; i >= 0; i--)
+		virtnet_disable_queue_pair(vi, i);
+	return err;
 }
 
 static int virtnet_poll_tx(struct napi_struct *napi, int budget)
@@ -2157,11 +2187,8 @@ static int virtnet_close(struct net_device *dev)
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		napi_disable(&vi->rq[i].napi);
-		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
-		virtnet_napi_tx_disable(&vi->sq[i].napi);
-	}
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		virtnet_disable_queue_pair(vi, i);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
index f083fb9038c3..f02a308a9ffc 100644
--- a/drivers/net/wireless/ath/ath.h
+++ b/drivers/net/wireless/ath/ath.h
@@ -96,11 +96,13 @@ struct ath_keyval {
 	u8 kv_type;
 	u8 kv_pad;
 	u16 kv_len;
-	u8 kv_val[16]; /* TK */
-	u8 kv_mic[8]; /* Michael MIC key */
-	u8 kv_txmic[8]; /* Michael MIC TX key (used only if the hardware
-			 * supports both MIC keys in the same key cache entry;
-			 * in that case, kv_mic is the RX key) */
+	struct_group(kv_values,
+		u8 kv_val[16]; /* TK */
+		u8 kv_mic[8]; /* Michael MIC key */
+		u8 kv_txmic[8]; /* Michael MIC TX key (used only if the hardware
+				 * supports both MIC keys in the same key cache entry;
+				 * in that case, kv_mic is the RX key) */
+	);
 };
 
 enum ath_cipher {
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index f5156a7fbdd7..d070bcb3fe24 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -36,6 +36,7 @@ void ath11k_dp_peer_cleanup(struct ath11k *ar, int vdev_id, const u8 *addr)
 	}
 
 	ath11k_peer_rx_tid_cleanup(ar, peer);
+	peer->dp_setup_done = false;
 	crypto_free_shash(peer->tfm_mmic);
 	spin_unlock_bh(&ab->base_lock);
 }
@@ -72,7 +73,8 @@ int ath11k_dp_peer_setup(struct ath11k *ar, int vdev_id, const u8 *addr)
 	ret = ath11k_peer_rx_frag_setup(ar, addr, vdev_id);
 	if (ret) {
 		ath11k_warn(ab, "failed to setup rx defrag context\n");
-		return ret;
+		tid--;
+		goto peer_clean;
 	}
 
 	/* TODO: Setup other peer specific resource used in data path */
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index e964e1b72287..38be646bc021 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -389,10 +389,10 @@ int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
 			goto fail_free_skb;
 
 		spin_lock_bh(&rx_ring->idr_lock);
-		buf_id = idr_alloc(&rx_ring->bufs_idr, skb, 0,
-				   rx_ring->bufs_max * 3, GFP_ATOMIC);
+		buf_id = idr_alloc(&rx_ring->bufs_idr, skb, 1,
+				   (rx_ring->bufs_max * 3) + 1, GFP_ATOMIC);
 		spin_unlock_bh(&rx_ring->idr_lock);
-		if (buf_id < 0)
+		if (buf_id <= 0)
 			goto fail_dma_unmap;
 
 		desc = ath11k_hal_srng_src_get_next_entry(ab, srng);
@@ -2665,6 +2665,9 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 				   cookie);
 		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
 
+		if (unlikely(buf_id == 0))
+			continue;
+
 		ar = ab->pdevs[mac_id].ar;
 		rx_ring = &ar->dp.rx_refill_buf_ring;
 		spin_lock_bh(&rx_ring->idr_lock);
@@ -3138,6 +3141,7 @@ int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id
 	}
 
 	peer->tfm_mmic = tfm;
+	peer->dp_setup_done = true;
 	spin_unlock_bh(&ab->base_lock);
 
 	return 0;
@@ -3583,6 +3587,13 @@ static int ath11k_dp_rx_frag_h_mpdu(struct ath11k *ar,
 		ret = -ENOENT;
 		goto out_unlock;
 	}
+	if (!peer->dp_setup_done) {
+		ath11k_warn(ab, "The peer %pM [%d] has uninitialized datapath\n",
+			    peer->addr, peer_id);
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
 	rx_tid = &peer->rx_tid[tid];
 
 	if ((!skb_queue_empty(&rx_tid->rx_frags) && seqno != rx_tid->cur_sn) ||
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 6dd17bafe3a0..9bd385d0a38c 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -35,6 +35,7 @@ struct ath11k_peer {
 	u16 sec_type;
 	u16 sec_type_grp;
 	bool is_authorized;
+	bool dp_setup_done;
 };
 
 void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id);
diff --git a/drivers/net/wireless/ath/key.c b/drivers/net/wireless/ath/key.c
index 61b59a804e30..b7b61d4f02ba 100644
--- a/drivers/net/wireless/ath/key.c
+++ b/drivers/net/wireless/ath/key.c
@@ -503,7 +503,7 @@ int ath_key_config(struct ath_common *common,
 
 	hk.kv_len = key->keylen;
 	if (key->keylen)
-		memcpy(hk.kv_val, key->key, key->keylen);
+		memcpy(&hk.kv_values, key->key, key->keylen);
 
 	if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE)) {
 		switch (vif->type) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 2cc913acfc2d..ad5a8d61d938 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1351,13 +1351,14 @@ static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 067ea019b110..3b1277a8bd61 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -13,6 +13,7 @@
 #include <linux/bcma/bcma.h>
 #include <linux/sched.h>
 #include <linux/io.h>
+#include <linux/random.h>
 #include <asm/unaligned.h>
 
 #include <soc.h>
@@ -1631,6 +1632,13 @@ brcmf_pcie_init_share_ram_info(struct brcmf_pciedev_info *devinfo,
 	return 0;
 }
 
+struct brcmf_random_seed_footer {
+	__le32 length;
+	__le32 magic;
+};
+
+#define BRCMF_RANDOM_SEED_MAGIC		0xfeedc0de
+#define BRCMF_RANDOM_SEED_LENGTH	0x100
 
 static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 					const struct firmware *fw, void *nvram,
@@ -1667,6 +1675,30 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 			  nvram_len;
 		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
+
+		if (devinfo->otp.valid) {
+			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
+			struct brcmf_random_seed_footer footer = {
+				.length = cpu_to_le32(rand_len),
+				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
+			};
+			void *randbuf;
+
+			/* Some Apple chips/firmwares expect a buffer of random
+			 * data to be present before NVRAM
+			 */
+			brcmf_dbg(PCIE, "Download random seed\n");
+
+			address -= sizeof(footer);
+			memcpy_toio(devinfo->tcm + address, &footer,
+				    sizeof(footer));
+
+			address -= rand_len;
+			randbuf = kzalloc(rand_len, GFP_KERNEL);
+			get_random_bytes(randbuf, rand_len);
+			memcpy_toio(devinfo->tcm + address, randbuf, rand_len);
+			kfree(randbuf);
+		}
 	} else {
 		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
 			  devinfo->nvram_name);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
index cef43cf80620..8b01ab986cb1 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -1081,6 +1081,7 @@ static int iwlagn_send_sta_key(struct iwl_priv *priv,
 {
 	__le16 key_flags;
 	struct iwl_addsta_cmd sta_cmd;
+	size_t to_copy;
 	int i;
 
 	spin_lock_bh(&priv->sta_lock);
@@ -1100,7 +1101,9 @@ static int iwlagn_send_sta_key(struct iwl_priv *priv,
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
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index a02e5a67b706..585e8cd2d332 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -38,7 +38,7 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 	},
 	{ .ident = "ASUS",
 	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTek COMPUTER INC."),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		},
 	},
 	{}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 027360e63b92..3ef0b776b772 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1664,14 +1664,10 @@ static __le32 iwl_get_mon_reg(struct iwl_fw_runtime *fwrt, u32 alloc_id,
 }
 
 static void *
-iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt,
-			     struct iwl_dump_ini_region_data *reg_data,
+iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt, u32 alloc_id,
 			     struct iwl_fw_ini_monitor_dump *data,
 			     const struct iwl_fw_mon_regs *addrs)
 {
-	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
-	u32 alloc_id = le32_to_cpu(reg->dram_alloc_id);
-
 	if (!iwl_trans_grab_nic_access(fwrt->trans)) {
 		IWL_ERR(fwrt, "Failed to get monitor header\n");
 		return NULL;
@@ -1702,8 +1698,10 @@ iwl_dump_ini_mon_dram_fill_header(struct iwl_fw_runtime *fwrt,
 				  void *data, u32 data_len)
 {
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 alloc_id = le32_to_cpu(reg->dram_alloc_id);
 
-	return iwl_dump_ini_mon_fill_header(fwrt, reg_data, mon_dump,
+	return iwl_dump_ini_mon_fill_header(fwrt, alloc_id, mon_dump,
 					    &fwrt->trans->cfg->mon_dram_regs);
 }
 
@@ -1713,8 +1711,10 @@ iwl_dump_ini_mon_smem_fill_header(struct iwl_fw_runtime *fwrt,
 				  void *data, u32 data_len)
 {
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 alloc_id = le32_to_cpu(reg->internal_buffer.alloc_id);
 
-	return iwl_dump_ini_mon_fill_header(fwrt, reg_data, mon_dump,
+	return iwl_dump_ini_mon_fill_header(fwrt, alloc_id, mon_dump,
 					    &fwrt->trans->cfg->mon_smem_regs);
 }
 
@@ -1725,7 +1725,10 @@ iwl_dump_ini_mon_dbgi_fill_header(struct iwl_fw_runtime *fwrt,
 {
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
 
-	return iwl_dump_ini_mon_fill_header(fwrt, reg_data, mon_dump,
+	return iwl_dump_ini_mon_fill_header(fwrt,
+					    /* no offset calculation later */
+					    IWL_FW_INI_ALLOCATION_ID_DBGC1,
+					    mon_dump,
 					    &fwrt->trans->cfg->mon_dbgi_regs);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5de34edc51fe..887d0789c96c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1055,7 +1055,7 @@ static const struct dmi_system_id dmi_tas_approved_list[] = {
 	},
 		{ .ident = "LENOVO",
 	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Lenovo"),
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		},
 	},
 	{ .ident = "DELL",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a841268e0709..801098c5183b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3445,7 +3445,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_sta *mvmsta = NULL;
-	struct iwl_mvm_key_pn *ptk_pn;
+	struct iwl_mvm_key_pn *ptk_pn = NULL;
 	int keyidx = key->keyidx;
 	int ret, i;
 	u8 key_offset;
@@ -3590,6 +3590,10 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		if (ret) {
 			IWL_WARN(mvm, "set key failed\n");
 			key->hw_key_idx = STA_KEY_IDX_INVALID;
+			if (ptk_pn) {
+				RCU_INIT_POINTER(mvmsta->ptk_pn[keyidx], NULL);
+				kfree(ptk_pn);
+			}
 			/*
 			 * can't add key for RX, but we don't need it
 			 * in the device for TX so still return 0,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 6d18a1fd649b..fdf60afb0f3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -445,6 +445,11 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 		struct iwl_mcc_update_resp *mcc_resp = (void *)pkt->data;
 
 		n_channels =  __le32_to_cpu(mcc_resp->n_channels);
+		if (iwl_rx_packet_payload_len(pkt) !=
+		    struct_size(mcc_resp, channels, n_channels)) {
+			resp_cp = ERR_PTR(-EINVAL);
+			goto exit;
+		}
 		resp_len = sizeof(struct iwl_mcc_update_resp) +
 			   n_channels * sizeof(__le32);
 		resp_cp = kmemdup(mcc_resp, resp_len, GFP_KERNEL);
@@ -456,6 +461,11 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 		struct iwl_mcc_update_resp_v3 *mcc_resp_v3 = (void *)pkt->data;
 
 		n_channels =  __le32_to_cpu(mcc_resp_v3->n_channels);
+		if (iwl_rx_packet_payload_len(pkt) !=
+		    struct_size(mcc_resp_v3, channels, n_channels)) {
+			resp_cp = ERR_PTR(-EINVAL);
+			goto exit;
+		}
 		resp_len = sizeof(struct iwl_mcc_update_resp) +
 			   n_channels * sizeof(__le32);
 		resp_cp = kzalloc(resp_len, GFP_KERNEL);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 091225894037..02c2a0630107 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1975,7 +1975,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 				RCU_INIT_POINTER(mvm->csa_tx_blocked_vif, NULL);
 				/* Unblock BCAST / MCAST station */
 				iwl_mvm_modify_all_sta_disable_tx(mvm, mvmvif, false);
-				cancel_delayed_work_sync(&mvm->cs_tx_unblock_dwork);
+				cancel_delayed_work(&mvm->cs_tx_unblock_dwork);
 			}
 		}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ba944175546d..542cfcad6e0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -788,10 +788,11 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 				    struct ieee80211_sta *sta, unsigned int tid)
 {
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	enum nl80211_band band = mvmsta->vif->bss_conf.chandef.chan->band;
 	u8 ac = tid_to_mac80211_ac[tid];
+	enum nl80211_band band;
 	unsigned int txf;
-	int lmac = iwl_mvm_get_lmac_id(mvm->fw, band);
+	unsigned int val;
+	int lmac;
 
 	/* For HE redirect to trigger based fifos */
 	if (sta->deflink.he_cap.has_he && !WARN_ON(!iwl_mvm_has_new_tx_api(mvm)))
@@ -805,7 +806,37 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 	 * We also want to have the start of the next packet inside the
 	 * fifo to be able to send bursts.
 	 */
-	return min_t(unsigned int, mvmsta->max_amsdu_len,
+	val = mvmsta->max_amsdu_len;
+
+	if (hweight16(sta->valid_links) <= 1) {
+		if (sta->valid_links) {
+			struct ieee80211_bss_conf *link_conf;
+			unsigned int link = ffs(sta->valid_links) - 1;
+
+			rcu_read_lock();
+			link_conf = rcu_dereference(mvmsta->vif->link_conf[link]);
+			if (WARN_ON(!link_conf))
+				band = NL80211_BAND_2GHZ;
+			else
+				band = link_conf->chandef.chan->band;
+			rcu_read_unlock();
+		} else {
+			band = mvmsta->vif->bss_conf.chandef.chan->band;
+		}
+
+		lmac = iwl_mvm_get_lmac_id(mvm->fw, band);
+	} else if (fw_has_capa(&mvm->fw->ucode_capa,
+			       IWL_UCODE_TLV_CAPA_CDB_SUPPORT)) {
+		/* for real MLO restrict to both LMACs if they exist */
+		lmac = IWL_LMAC_5G_INDEX;
+		val = min_t(unsigned int, val,
+			    mvm->fwrt.smem_cfg.lmac[lmac].txfifo_size[txf] - 256);
+		lmac = IWL_LMAC_24G_INDEX;
+	} else {
+		lmac = IWL_LMAC_24G_INDEX;
+	}
+
+	return min_t(unsigned int, val,
 		     mvm->fwrt.smem_cfg.lmac[lmac].txfifo_size[txf] - 256);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 85fadd1ef1ff..03e8234d0352 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -504,6 +504,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Bz devices */
 	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
 #endif /* CONFIG_IWLMVM */
@@ -1685,6 +1686,9 @@ static void iwl_pci_remove(struct pci_dev *pdev)
 {
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
 
+	if (!trans)
+		return;
+
 	iwl_drv_stop(trans->drv);
 
 	iwl_trans_pcie_free(trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 54f11f60f11c..8e95225cdd60 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2852,7 +2852,7 @@ static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
 				  void *buf, ssize_t *size,
 				  ssize_t *bytes_copied)
 {
-	int buf_size_left = count - *bytes_copied;
+	ssize_t buf_size_left = count - *bytes_copied;
 
 	buf_size_left = buf_size_left - (buf_size_left % sizeof(u32));
 	if (*size > buf_size_left)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index f33171bcd343..c3b692eac6f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -163,7 +163,7 @@ enum {
 #define MT_TXS5_MPDU_TX_CNT		GENMASK(31, 23)
 
 #define MT_TXS6_MPDU_FAIL_CNT		GENMASK(31, 23)
-
+#define MT_TXS7_MPDU_RETRY_BYTE		GENMASK(22, 0)
 #define MT_TXS7_MPDU_RETRY_CNT		GENMASK(31, 23)
 
 /* RXD DW1 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 19f02b632a20..68511597599e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -570,7 +570,8 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	/* PPDU based reporting */
 	if (FIELD_GET(MT_TXS0_TXS_FORMAT, txs) > 1) {
 		stats->tx_bytes +=
-			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_BYTE);
+			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_BYTE) -
+			le32_get_bits(txs_data[7], MT_TXS7_MPDU_RETRY_BYTE);
 		stats->tx_packets +=
 			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_CNT);
 		stats->tx_failed +=
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 07578ccc4bab..62fb28f14c94 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -891,7 +891,7 @@ static void rtw_ops_sta_rc_update(struct ieee80211_hw *hw,
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 
 	if (changed & IEEE80211_RC_BW_CHANGED)
-		rtw_update_sta_info(rtwdev, si, true);
+		ieee80211_queue_work(rtwdev->hw, &si->rc_work);
 }
 
 const struct ieee80211_ops rtw_ops = {
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 67151dbf8384..8080ace5ed51 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -296,6 +296,17 @@ static u8 rtw_acquire_macid(struct rtw_dev *rtwdev)
 	return mac_id;
 }
 
+static void rtw_sta_rc_work(struct work_struct *work)
+{
+	struct rtw_sta_info *si = container_of(work, struct rtw_sta_info,
+					       rc_work);
+	struct rtw_dev *rtwdev = si->rtwdev;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw_update_sta_info(rtwdev, si, true);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		struct ieee80211_vif *vif)
 {
@@ -306,12 +317,14 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	if (si->mac_id >= RTW_MAX_MAC_ID_NUM)
 		return -ENOSPC;
 
+	si->rtwdev = rtwdev;
 	si->sta = sta;
 	si->vif = vif;
 	si->init_ra_lv = 1;
 	ewma_rssi_init(&si->avg_rssi);
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw_txq_init(rtwdev, sta->txq[i]);
+	INIT_WORK(&si->rc_work, rtw_sta_rc_work);
 
 	rtw_update_sta_info(rtwdev, si, true);
 	rtw_fw_media_status_report(rtwdev, si->mac_id, true);
@@ -330,6 +343,8 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 	int i;
 
+	cancel_work_sync(&si->rc_work);
+
 	rtw_release_macid(rtwdev, si->mac_id);
 	if (fw_exist)
 		rtw_fw_media_status_report(rtwdev, si->mac_id, false);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index cd9c068ae1a7..f8714f449244 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -734,6 +734,7 @@ struct rtw_txq {
 DECLARE_EWMA(rssi, 10, 16);
 
 struct rtw_sta_info {
+	struct rtw_dev *rtwdev;
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 
@@ -758,6 +759,8 @@ struct rtw_sta_info {
 
 	bool use_cfg_mask;
 	struct cfg80211_bitrate_mask *mask;
+
+	struct work_struct rc_work;
 };
 
 enum rtw_bfee_role {
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 1e6a47976642..8ccd4d26b906 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -565,24 +565,32 @@ static void ipc_imem_run_state_worker(struct work_struct *instance)
 	struct ipc_mux_config mux_cfg;
 	struct iosm_imem *ipc_imem;
 	u8 ctrl_chl_idx = 0;
+	int ret;
 
 	ipc_imem = container_of(instance, struct iosm_imem, run_state_worker);
 
 	if (ipc_imem->phase != IPC_P_RUN) {
 		dev_err(ipc_imem->dev,
 			"Modem link down. Exit run state worker.");
-		return;
+		goto err_out;
 	}
 
 	if (test_and_clear_bit(IOSM_DEVLINK_INIT, &ipc_imem->flag))
 		ipc_devlink_deinit(ipc_imem->ipc_devlink);
 
-	if (!ipc_imem_setup_cp_mux_cap_init(ipc_imem, &mux_cfg))
-		ipc_imem->mux = ipc_mux_init(&mux_cfg, ipc_imem);
+	ret = ipc_imem_setup_cp_mux_cap_init(ipc_imem, &mux_cfg);
+	if (ret < 0)
+		goto err_out;
+
+	ipc_imem->mux = ipc_mux_init(&mux_cfg, ipc_imem);
+	if (!ipc_imem->mux)
+		goto err_out;
+
+	ret = ipc_imem_wwan_channel_init(ipc_imem, mux_cfg.protocol);
+	if (ret < 0)
+		goto err_ipc_mux_deinit;
 
-	ipc_imem_wwan_channel_init(ipc_imem, mux_cfg.protocol);
-	if (ipc_imem->mux)
-		ipc_imem->mux->wwan = ipc_imem->wwan;
+	ipc_imem->mux->wwan = ipc_imem->wwan;
 
 	while (ctrl_chl_idx < IPC_MEM_MAX_CHANNELS) {
 		if (!ipc_chnl_cfg_get(&chnl_cfg_port, ctrl_chl_idx)) {
@@ -615,6 +623,13 @@ static void ipc_imem_run_state_worker(struct work_struct *instance)
 
 	/* Complete all memory stores after setting bit */
 	smp_mb__after_atomic();
+
+	return;
+
+err_ipc_mux_deinit:
+	ipc_mux_deinit(ipc_imem->mux);
+err_out:
+	ipc_uevent_send(ipc_imem->dev, UEVENT_CD_READY_LINK_DOWN);
 }
 
 static void ipc_imem_handle_irq(struct iosm_imem *ipc_imem, int irq)
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
index 66b90cc4c346..109cf8930488 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
@@ -77,8 +77,8 @@ int ipc_imem_sys_wwan_transmit(struct iosm_imem *ipc_imem,
 }
 
 /* Initialize wwan channel */
-void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
-				enum ipc_mux_protocol mux_type)
+int ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
+			       enum ipc_mux_protocol mux_type)
 {
 	struct ipc_chnl_cfg chnl_cfg = { 0 };
 
@@ -87,7 +87,7 @@ void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
 	/* If modem version is invalid (0xffffffff), do not initialize WWAN. */
 	if (ipc_imem->cp_version == -1) {
 		dev_err(ipc_imem->dev, "invalid CP version");
-		return;
+		return -EIO;
 	}
 
 	ipc_chnl_cfg_get(&chnl_cfg, ipc_imem->nr_of_channels);
@@ -104,9 +104,13 @@ void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
 
 	/* WWAN registration. */
 	ipc_imem->wwan = ipc_wwan_init(ipc_imem, ipc_imem->dev);
-	if (!ipc_imem->wwan)
+	if (!ipc_imem->wwan) {
 		dev_err(ipc_imem->dev,
 			"failed to register the ipc_wwan interfaces");
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 /* Map SKB to DMA for transfer */
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
index f8afb217d9e2..026c5bd0f999 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
@@ -91,9 +91,11 @@ int ipc_imem_sys_wwan_transmit(struct iosm_imem *ipc_imem, int if_id,
  *				MUX.
  * @ipc_imem:		Pointer to iosm_imem struct.
  * @mux_type:		Type of mux protocol.
+ *
+ * Return: 0 on success and failure value on error
  */
-void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
-				enum ipc_mux_protocol mux_type);
+int ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
+			       enum ipc_mux_protocol mux_type);
 
 /**
  * ipc_imem_sys_devlink_open - Open a Flash/CD Channel link to CP
diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
index 456776bd8ee6..6f5e5f0230d3 100644
--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -37,7 +37,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/reboot.h>
 #include <linux/sched/signal.h>
@@ -175,16 +174,21 @@ static void powerfail_interrupt(int code, void *x)
 
 
 
-/* parisc_panic_event() is called by the panic handler.
- * As soon as a panic occurs, our tasklets above will not be
- * executed any longer. This function then re-enables the 
- * soft-power switch and allows the user to switch off the system
+/*
+ * parisc_panic_event() is called by the panic handler.
+ *
+ * As soon as a panic occurs, our tasklets above will not
+ * be executed any longer. This function then re-enables
+ * the soft-power switch and allows the user to switch off
+ * the system. We rely in pdc_soft_power_button_panic()
+ * since this version spin_trylocks (instead of regular
+ * spinlock), preventing deadlocks on panic path.
  */
 static int parisc_panic_event(struct notifier_block *this,
 		unsigned long event, void *ptr)
 {
 	/* re-enable the soft-power switch */
-	pdc_soft_power_button(0);
+	pdc_soft_power_button_panic(0);
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
index 068160a34f5c..e30305b77f0d 100644
--- a/drivers/phy/st/phy-miphy28lp.c
+++ b/drivers/phy/st/phy-miphy28lp.c
@@ -9,6 +9,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -484,19 +485,11 @@ static inline void miphy28lp_pcie_config_gen(struct miphy28lp_phy *miphy_phy)
 
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
 
 
@@ -805,7 +798,6 @@ static inline void miphy28lp_configure_usb3(struct miphy28lp_phy *miphy_phy)
 
 static inline int miphy_is_ready(struct miphy28lp_phy *miphy_phy)
 {
-	unsigned long finish = jiffies + 5 * HZ;
 	u8 mask = HFC_PLL | HFC_RDY;
 	u8 val;
 
@@ -816,21 +808,14 @@ static inline int miphy_is_ready(struct miphy28lp_phy *miphy_phy)
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
@@ -839,17 +824,10 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
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
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b02a8125bc7d..1396a839dd8a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -424,24 +424,7 @@ config GPD_POCKET_FAN
 	  of the CPU temperature. Say Y or M if the kernel may be used on a
 	  GPD pocket.
 
-config HP_ACCEL
-	tristate "HP laptop accelerometer"
-	depends on INPUT && ACPI
-	depends on SERIO_I8042
-	select SENSORS_LIS3LV02D
-	select NEW_LEDS
-	select LEDS_CLASS
-	help
-	  This driver provides support for the "Mobile Data Protection System 3D"
-	  or "3D DriveGuard" feature of HP laptops. On such systems the driver
-	  should load automatically (via ACPI alias).
-
-	  Support for a led indicating disk protection will be provided as
-	  hp::hddprotect. For more information on the feature, refer to
-	  Documentation/misc-devices/lis3lv02d.rst.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called hp_accel.
+source "drivers/platform/x86/hp/Kconfig"
 
 config WIRELESS_HOTKEY
 	tristate "Wireless hotkey button"
@@ -455,30 +438,6 @@ config WIRELESS_HOTKEY
 	 To compile this driver as a module, choose M here: the module will
 	 be called wireless-hotkey.
 
-config HP_WMI
-	tristate "HP WMI extras"
-	depends on ACPI_WMI
-	depends on INPUT
-	depends on RFKILL || RFKILL = n
-	select INPUT_SPARSEKMAP
-	select ACPI_PLATFORM_PROFILE
-	select HWMON
-	help
-	 Say Y here if you want to support WMI-based hotkeys on HP laptops and
-	 to read data from WMI such as docking or ambient light sensor state.
-
-	 To compile this driver as a module, choose M here: the module will
-	 be called hp-wmi.
-
-config TC1100_WMI
-	tristate "HP Compaq TC1100 Tablet WMI Extras"
-	depends on !X86_64
-	depends on ACPI
-	depends on ACPI_WMI
-	help
-	  This is a driver for the WMI extensions (wireless and bluetooth power
-	  control) of the HP Compaq TC1100 tablet.
-
 config IBM_RTL
 	tristate "Device driver to enable PRTL support"
 	depends on PCI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 5a428caa654a..1d3d1b02541b 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -55,9 +55,7 @@ obj-$(CONFIG_FUJITSU_TABLET)	+= fujitsu-tablet.o
 obj-$(CONFIG_GPD_POCKET_FAN)	+= gpd-pocket-fan.o
 
 # Hewlett Packard
-obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
-obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
-obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
+obj-$(CONFIG_X86_PLATFORM_DRIVERS_HP)	+= hp/
 
 # Hewlett Packard Enterprise
 obj-$(CONFIG_UV_SYSFS)       += uv_sysfs.o
diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
deleted file mode 100644
index 4a3851332ef2..000000000000
--- a/drivers/platform/x86/hp-wmi.c
+++ /dev/null
@@ -1,1570 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * HP WMI hotkeys
- *
- * Copyright (C) 2008 Red Hat <mjg@redhat.com>
- * Copyright (C) 2010, 2011 Anssi Hannula <anssi.hannula@iki.fi>
- *
- * Portions based on wistron_btns.c:
- * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
- * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
- * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/input.h>
-#include <linux/input/sparse-keymap.h>
-#include <linux/platform_device.h>
-#include <linux/platform_profile.h>
-#include <linux/hwmon.h>
-#include <linux/acpi.h>
-#include <linux/rfkill.h>
-#include <linux/string.h>
-#include <linux/dmi.h>
-
-MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
-MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
-MODULE_LICENSE("GPL");
-
-MODULE_ALIAS("wmi:95F24279-4D7B-4334-9387-ACCDC67EF61C");
-MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
-
-#define HPWMI_EVENT_GUID "95F24279-4D7B-4334-9387-ACCDC67EF61C"
-#define HPWMI_BIOS_GUID "5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
-#define HP_OMEN_EC_THERMAL_PROFILE_OFFSET 0x95
-#define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
-
-/* DMI board names of devices that should use the omen specific path for
- * thermal profiles.
- * This was obtained by taking a look in the windows omen command center
- * app and parsing a json file that they use to figure out what capabilities
- * the device should have.
- * A device is considered an omen if the DisplayName in that list contains
- * "OMEN", and it can use the thermal profile stuff if the "Feature" array
- * contains "PerformanceControl".
- */
-static const char * const omen_thermal_profile_boards[] = {
-	"84DA", "84DB", "84DC", "8574", "8575", "860A", "87B5", "8572", "8573",
-	"8600", "8601", "8602", "8605", "8606", "8607", "8746", "8747", "8749",
-	"874A", "8603", "8604", "8748", "886B", "886C", "878A", "878B", "878C",
-	"88C8", "88CB", "8786", "8787", "8788", "88D1", "88D2", "88F4", "88FD",
-	"88F5", "88F6", "88F7", "88FE", "88FF", "8900", "8901", "8902", "8912",
-	"8917", "8918", "8949", "894A", "89EB"
-};
-
-/* DMI Board names of Omen laptops that are specifically set to be thermal
- * profile version 0 by the Omen Command Center app, regardless of what
- * the get system design information WMI call returns
- */
-static const char *const omen_thermal_profile_force_v0_boards[] = {
-	"8607", "8746", "8747", "8749", "874A", "8748"
-};
-
-enum hp_wmi_radio {
-	HPWMI_WIFI	= 0x0,
-	HPWMI_BLUETOOTH	= 0x1,
-	HPWMI_WWAN	= 0x2,
-	HPWMI_GPS	= 0x3,
-};
-
-enum hp_wmi_event_ids {
-	HPWMI_DOCK_EVENT		= 0x01,
-	HPWMI_PARK_HDD			= 0x02,
-	HPWMI_SMART_ADAPTER		= 0x03,
-	HPWMI_BEZEL_BUTTON		= 0x04,
-	HPWMI_WIRELESS			= 0x05,
-	HPWMI_CPU_BATTERY_THROTTLE	= 0x06,
-	HPWMI_LOCK_SWITCH		= 0x07,
-	HPWMI_LID_SWITCH		= 0x08,
-	HPWMI_SCREEN_ROTATION		= 0x09,
-	HPWMI_COOLSENSE_SYSTEM_MOBILE	= 0x0A,
-	HPWMI_COOLSENSE_SYSTEM_HOT	= 0x0B,
-	HPWMI_PROXIMITY_SENSOR		= 0x0C,
-	HPWMI_BACKLIT_KB_BRIGHTNESS	= 0x0D,
-	HPWMI_PEAKSHIFT_PERIOD		= 0x0F,
-	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
-	HPWMI_SANITIZATION_MODE		= 0x17,
-	HPWMI_OMEN_KEY			= 0x1D,
-	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
-};
-
-/*
- * struct bios_args buffer is dynamically allocated.  New WMI command types
- * were introduced that exceeds 128-byte data size.  Changes to handle
- * the data size allocation scheme were kept in hp_wmi_perform_qurey function.
- */
-struct bios_args {
-	u32 signature;
-	u32 command;
-	u32 commandtype;
-	u32 datasize;
-	u8 data[];
-};
-
-enum hp_wmi_commandtype {
-	HPWMI_DISPLAY_QUERY		= 0x01,
-	HPWMI_HDDTEMP_QUERY		= 0x02,
-	HPWMI_ALS_QUERY			= 0x03,
-	HPWMI_HARDWARE_QUERY		= 0x04,
-	HPWMI_WIRELESS_QUERY		= 0x05,
-	HPWMI_BATTERY_QUERY		= 0x07,
-	HPWMI_BIOS_QUERY		= 0x09,
-	HPWMI_FEATURE_QUERY		= 0x0b,
-	HPWMI_HOTKEY_QUERY		= 0x0c,
-	HPWMI_FEATURE2_QUERY		= 0x0d,
-	HPWMI_WIRELESS2_QUERY		= 0x1b,
-	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
-	HPWMI_SYSTEM_DEVICE_MODE	= 0x40,
-	HPWMI_THERMAL_PROFILE_QUERY	= 0x4c,
-};
-
-enum hp_wmi_gm_commandtype {
-	HPWMI_FAN_SPEED_GET_QUERY = 0x11,
-	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
-	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
-	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
-	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
-};
-
-enum hp_wmi_command {
-	HPWMI_READ	= 0x01,
-	HPWMI_WRITE	= 0x02,
-	HPWMI_ODM	= 0x03,
-	HPWMI_GM	= 0x20008,
-};
-
-enum hp_wmi_hardware_mask {
-	HPWMI_DOCK_MASK		= 0x01,
-	HPWMI_TABLET_MASK	= 0x04,
-};
-
-struct bios_return {
-	u32 sigpass;
-	u32 return_code;
-};
-
-enum hp_return_value {
-	HPWMI_RET_WRONG_SIGNATURE	= 0x02,
-	HPWMI_RET_UNKNOWN_COMMAND	= 0x03,
-	HPWMI_RET_UNKNOWN_CMDTYPE	= 0x04,
-	HPWMI_RET_INVALID_PARAMETERS	= 0x05,
-};
-
-enum hp_wireless2_bits {
-	HPWMI_POWER_STATE	= 0x01,
-	HPWMI_POWER_SOFT	= 0x02,
-	HPWMI_POWER_BIOS	= 0x04,
-	HPWMI_POWER_HARD	= 0x08,
-	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
-};
-
-enum hp_thermal_profile_omen_v0 {
-	HP_OMEN_V0_THERMAL_PROFILE_DEFAULT     = 0x00,
-	HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE = 0x01,
-	HP_OMEN_V0_THERMAL_PROFILE_COOL        = 0x02,
-};
-
-enum hp_thermal_profile_omen_v1 {
-	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	= 0x30,
-	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE	= 0x31,
-	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
-};
-
-enum hp_thermal_profile {
-	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
-	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
-	HP_THERMAL_PROFILE_COOL			= 0x02,
-	HP_THERMAL_PROFILE_QUIET		= 0x03,
-};
-
-#define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
-#define IS_SWBLOCKED(x) !(x & HPWMI_POWER_SOFT)
-
-struct bios_rfkill2_device_state {
-	u8 radio_type;
-	u8 bus_type;
-	u16 vendor_id;
-	u16 product_id;
-	u16 subsys_vendor_id;
-	u16 subsys_product_id;
-	u8 rfkill_id;
-	u8 power;
-	u8 unknown[4];
-};
-
-/* 7 devices fit into the 128 byte buffer */
-#define HPWMI_MAX_RFKILL2_DEVICES	7
-
-struct bios_rfkill2_state {
-	u8 unknown[7];
-	u8 count;
-	u8 pad[8];
-	struct bios_rfkill2_device_state device[HPWMI_MAX_RFKILL2_DEVICES];
-};
-
-static const struct key_entry hp_wmi_keymap[] = {
-	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
-	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
-	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
-	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
-	{ KE_KEY, 0x2142,  { KEY_MEDIA } },
-	{ KE_KEY, 0x213b,  { KEY_INFO } },
-	{ KE_KEY, 0x2169,  { KEY_ROTATE_DISPLAY } },
-	{ KE_KEY, 0x216a,  { KEY_SETUP } },
-	{ KE_KEY, 0x21a5,  { KEY_PROG2 } }, /* HP Omen Key */
-	{ KE_KEY, 0x21a7,  { KEY_FN_ESC } },
-	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
-	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
-	{ KE_KEY, 0x231b,  { KEY_HELP } },
-	{ KE_END, 0 }
-};
-
-static struct input_dev *hp_wmi_input_dev;
-static struct platform_device *hp_wmi_platform_dev;
-static struct platform_profile_handler platform_profile_handler;
-static bool platform_profile_support;
-static bool zero_insize_support;
-
-static struct rfkill *wifi_rfkill;
-static struct rfkill *bluetooth_rfkill;
-static struct rfkill *wwan_rfkill;
-
-struct rfkill2_device {
-	u8 id;
-	int num;
-	struct rfkill *rfkill;
-};
-
-static int rfkill2_count;
-static struct rfkill2_device rfkill2[HPWMI_MAX_RFKILL2_DEVICES];
-
-/*
- * Chassis Types values were obtained from SMBIOS reference
- * specification version 3.00. A complete list of system enclosures
- * and chassis types is available on Table 17.
- */
-static const char * const tablet_chassis_types[] = {
-	"30", /* Tablet*/
-	"31", /* Convertible */
-	"32"  /* Detachable */
-};
-
-#define DEVICE_MODE_TABLET	0x06
-
-/* map output size to the corresponding WMI method id */
-static inline int encode_outsize_for_pvsz(int outsize)
-{
-	if (outsize > 4096)
-		return -EINVAL;
-	if (outsize > 1024)
-		return 5;
-	if (outsize > 128)
-		return 4;
-	if (outsize > 4)
-		return 3;
-	if (outsize > 0)
-		return 2;
-	return 1;
-}
-
-/*
- * hp_wmi_perform_query
- *
- * query:	The commandtype (enum hp_wmi_commandtype)
- * write:	The command (enum hp_wmi_command)
- * buffer:	Buffer used as input and/or output
- * insize:	Size of input buffer
- * outsize:	Size of output buffer
- *
- * returns zero on success
- *         an HP WMI query specific error code (which is positive)
- *         -EINVAL if the query was not successful at all
- *         -EINVAL if the output buffer size exceeds buffersize
- *
- * Note: The buffersize must at least be the maximum of the input and output
- *       size. E.g. Battery info query is defined to have 1 byte input
- *       and 128 byte output. The caller would do:
- *       buffer = kzalloc(128, GFP_KERNEL);
- *       ret = hp_wmi_perform_query(HPWMI_BATTERY_QUERY, HPWMI_READ, buffer, 1, 128)
- */
-static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
-				void *buffer, int insize, int outsize)
-{
-	struct acpi_buffer input, output = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct bios_return *bios_return;
-	union acpi_object *obj = NULL;
-	struct bios_args *args = NULL;
-	int mid, actual_insize, actual_outsize;
-	size_t bios_args_size;
-	int ret;
-
-	mid = encode_outsize_for_pvsz(outsize);
-	if (WARN_ON(mid < 0))
-		return mid;
-
-	actual_insize = max(insize, 128);
-	bios_args_size = struct_size(args, data, actual_insize);
-	args = kmalloc(bios_args_size, GFP_KERNEL);
-	if (!args)
-		return -ENOMEM;
-
-	input.length = bios_args_size;
-	input.pointer = args;
-
-	args->signature = 0x55434553;
-	args->command = command;
-	args->commandtype = query;
-	args->datasize = insize;
-	memcpy(args->data, buffer, flex_array_size(args, data, insize));
-
-	ret = wmi_evaluate_method(HPWMI_BIOS_GUID, 0, mid, &input, &output);
-	if (ret)
-		goto out_free;
-
-	obj = output.pointer;
-	if (!obj) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-
-	if (obj->type != ACPI_TYPE_BUFFER) {
-		pr_warn("query 0x%x returned an invalid object 0x%x\n", query, ret);
-		ret = -EINVAL;
-		goto out_free;
-	}
-
-	bios_return = (struct bios_return *)obj->buffer.pointer;
-	ret = bios_return->return_code;
-
-	if (ret) {
-		if (ret != HPWMI_RET_UNKNOWN_COMMAND &&
-		    ret != HPWMI_RET_UNKNOWN_CMDTYPE)
-			pr_warn("query 0x%x returned error 0x%x\n", query, ret);
-		goto out_free;
-	}
-
-	/* Ignore output data of zero size */
-	if (!outsize)
-		goto out_free;
-
-	actual_outsize = min(outsize, (int)(obj->buffer.length - sizeof(*bios_return)));
-	memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual_outsize);
-	memset(buffer + actual_outsize, 0, outsize - actual_outsize);
-
-out_free:
-	kfree(obj);
-	kfree(args);
-	return ret;
-}
-
-static int hp_wmi_get_fan_speed(int fan)
-{
-	u8 fsh, fsl;
-	char fan_data[4] = { fan, 0, 0, 0 };
-
-	int ret = hp_wmi_perform_query(HPWMI_FAN_SPEED_GET_QUERY, HPWMI_GM,
-				       &fan_data, sizeof(char),
-				       sizeof(fan_data));
-
-	if (ret != 0)
-		return -EINVAL;
-
-	fsh = fan_data[2];
-	fsl = fan_data[3];
-
-	return (fsh << 8) | fsl;
-}
-
-static int hp_wmi_read_int(int query)
-{
-	int val = 0, ret;
-
-	ret = hp_wmi_perform_query(query, HPWMI_READ, &val,
-				   zero_if_sup(val), sizeof(val));
-
-	if (ret)
-		return ret < 0 ? ret : -EINVAL;
-
-	return val;
-}
-
-static int hp_wmi_get_dock_state(void)
-{
-	int state = hp_wmi_read_int(HPWMI_HARDWARE_QUERY);
-
-	if (state < 0)
-		return state;
-
-	return !!(state & HPWMI_DOCK_MASK);
-}
-
-static int hp_wmi_get_tablet_mode(void)
-{
-	char system_device_mode[4] = { 0 };
-	const char *chassis_type;
-	bool tablet_found;
-	int ret;
-
-	chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
-	if (!chassis_type)
-		return -ENODEV;
-
-	tablet_found = match_string(tablet_chassis_types,
-				    ARRAY_SIZE(tablet_chassis_types),
-				    chassis_type) >= 0;
-	if (!tablet_found)
-		return -ENODEV;
-
-	ret = hp_wmi_perform_query(HPWMI_SYSTEM_DEVICE_MODE, HPWMI_READ,
-				   system_device_mode, zero_if_sup(system_device_mode),
-				   sizeof(system_device_mode));
-	if (ret < 0)
-		return ret;
-
-	return system_device_mode[0] == DEVICE_MODE_TABLET;
-}
-
-static int omen_thermal_profile_set(int mode)
-{
-	char buffer[2] = {0, mode};
-	int ret;
-
-	ret = hp_wmi_perform_query(HPWMI_SET_PERFORMANCE_MODE, HPWMI_GM,
-				   &buffer, sizeof(buffer), 0);
-
-	if (ret)
-		return ret < 0 ? ret : -EINVAL;
-
-	return mode;
-}
-
-static bool is_omen_thermal_profile(void)
-{
-	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
-
-	if (!board_name)
-		return false;
-
-	return match_string(omen_thermal_profile_boards,
-			    ARRAY_SIZE(omen_thermal_profile_boards),
-			    board_name) >= 0;
-}
-
-static int omen_get_thermal_policy_version(void)
-{
-	unsigned char buffer[8] = { 0 };
-	int ret;
-
-	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
-
-	if (board_name) {
-		int matches = match_string(omen_thermal_profile_force_v0_boards,
-			ARRAY_SIZE(omen_thermal_profile_force_v0_boards),
-			board_name);
-		if (matches >= 0)
-			return 0;
-	}
-
-	ret = hp_wmi_perform_query(HPWMI_GET_SYSTEM_DESIGN_DATA, HPWMI_GM,
-				   &buffer, sizeof(buffer), sizeof(buffer));
-
-	if (ret)
-		return ret < 0 ? ret : -EINVAL;
-
-	return buffer[3];
-}
-
-static int omen_thermal_profile_get(void)
-{
-	u8 data;
-
-	int ret = ec_read(HP_OMEN_EC_THERMAL_PROFILE_OFFSET, &data);
-
-	if (ret)
-		return ret;
-
-	return data;
-}
-
-static int hp_wmi_fan_speed_max_set(int enabled)
-{
-	int ret;
-
-	ret = hp_wmi_perform_query(HPWMI_FAN_SPEED_MAX_SET_QUERY, HPWMI_GM,
-				   &enabled, sizeof(enabled), 0);
-
-	if (ret)
-		return ret < 0 ? ret : -EINVAL;
-
-	return enabled;
-}
-
-static int hp_wmi_fan_speed_max_get(void)
-{
-	int val = 0, ret;
-
-	ret = hp_wmi_perform_query(HPWMI_FAN_SPEED_MAX_GET_QUERY, HPWMI_GM,
-				   &val, zero_if_sup(val), sizeof(val));
-
-	if (ret)
-		return ret < 0 ? ret : -EINVAL;
-
-	return val;
-}
-
-static int __init hp_wmi_bios_2008_later(void)
-{
-	int state = 0;
-	int ret = hp_wmi_perform_query(HPWMI_FEATURE_QUERY, HPWMI_READ, &state,
-				       zero_if_sup(state), sizeof(state));
-	if (!ret)
-		return 1;
-
-	return (ret == HPWMI_RET_UNKNOWN_CMDTYPE) ? 0 : -ENXIO;
-}
-
-static int __init hp_wmi_bios_2009_later(void)
-{
-	u8 state[128];
-	int ret = hp_wmi_perform_query(HPWMI_FEATURE2_QUERY, HPWMI_READ, &state,
-				       zero_if_sup(state), sizeof(state));
-	if (!ret)
-		return 1;
-
-	return (ret == HPWMI_RET_UNKNOWN_CMDTYPE) ? 0 : -ENXIO;
-}
-
-static int __init hp_wmi_enable_hotkeys(void)
-{
-	int value = 0x6e;
-	int ret = hp_wmi_perform_query(HPWMI_BIOS_QUERY, HPWMI_WRITE, &value,
-				       sizeof(value), 0);
-
-	return ret <= 0 ? ret : -EINVAL;
-}
-
-static int hp_wmi_set_block(void *data, bool blocked)
-{
-	enum hp_wmi_radio r = (enum hp_wmi_radio) data;
-	int query = BIT(r + 8) | ((!blocked) << r);
-	int ret;
-
-	ret = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, HPWMI_WRITE,
-				   &query, sizeof(query), 0);
-
-	return ret <= 0 ? ret : -EINVAL;
-}
-
-static const struct rfkill_ops hp_wmi_rfkill_ops = {
-	.set_block = hp_wmi_set_block,
-};
-
-static bool hp_wmi_get_sw_state(enum hp_wmi_radio r)
-{
-	int mask = 0x200 << (r * 8);
-
-	int wireless = hp_wmi_read_int(HPWMI_WIRELESS_QUERY);
-
-	/* TBD: Pass error */
-	WARN_ONCE(wireless < 0, "error executing HPWMI_WIRELESS_QUERY");
-
-	return !(wireless & mask);
-}
-
-static bool hp_wmi_get_hw_state(enum hp_wmi_radio r)
-{
-	int mask = 0x800 << (r * 8);
-
-	int wireless = hp_wmi_read_int(HPWMI_WIRELESS_QUERY);
-
-	/* TBD: Pass error */
-	WARN_ONCE(wireless < 0, "error executing HPWMI_WIRELESS_QUERY");
-
-	return !(wireless & mask);
-}
-
-static int hp_wmi_rfkill2_set_block(void *data, bool blocked)
-{
-	int rfkill_id = (int)(long)data;
-	char buffer[4] = { 0x01, 0x00, rfkill_id, !blocked };
-	int ret;
-
-	ret = hp_wmi_perform_query(HPWMI_WIRELESS2_QUERY, HPWMI_WRITE,
-				   buffer, sizeof(buffer), 0);
-
-	return ret <= 0 ? ret : -EINVAL;
-}
-
-static const struct rfkill_ops hp_wmi_rfkill2_ops = {
-	.set_block = hp_wmi_rfkill2_set_block,
-};
-
-static int hp_wmi_rfkill2_refresh(void)
-{
-	struct bios_rfkill2_state state;
-	int err, i;
-
-	err = hp_wmi_perform_query(HPWMI_WIRELESS2_QUERY, HPWMI_READ, &state,
-				   zero_if_sup(state), sizeof(state));
-	if (err)
-		return err;
-
-	for (i = 0; i < rfkill2_count; i++) {
-		int num = rfkill2[i].num;
-		struct bios_rfkill2_device_state *devstate;
-
-		devstate = &state.device[num];
-
-		if (num >= state.count ||
-		    devstate->rfkill_id != rfkill2[i].id) {
-			pr_warn("power configuration of the wireless devices unexpectedly changed\n");
-			continue;
-		}
-
-		rfkill_set_states(rfkill2[i].rfkill,
-				  IS_SWBLOCKED(devstate->power),
-				  IS_HWBLOCKED(devstate->power));
-	}
-
-	return 0;
-}
-
-static ssize_t display_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	int value = hp_wmi_read_int(HPWMI_DISPLAY_QUERY);
-
-	if (value < 0)
-		return value;
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t hddtemp_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	int value = hp_wmi_read_int(HPWMI_HDDTEMP_QUERY);
-
-	if (value < 0)
-		return value;
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t als_show(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	int value = hp_wmi_read_int(HPWMI_ALS_QUERY);
-
-	if (value < 0)
-		return value;
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
-			 char *buf)
-{
-	int value = hp_wmi_get_dock_state();
-
-	if (value < 0)
-		return value;
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t tablet_show(struct device *dev, struct device_attribute *attr,
-			   char *buf)
-{
-	int value = hp_wmi_get_tablet_mode();
-
-	if (value < 0)
-		return value;
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t postcode_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	/* Get the POST error code of previous boot failure. */
-	int value = hp_wmi_read_int(HPWMI_POSTCODEERROR_QUERY);
-
-	if (value < 0)
-		return value;
-	return sprintf(buf, "0x%x\n", value);
-}
-
-static ssize_t als_store(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count)
-{
-	u32 tmp;
-	int ret;
-
-	ret = kstrtou32(buf, 10, &tmp);
-	if (ret)
-		return ret;
-
-	ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_WRITE, &tmp,
-				       sizeof(tmp), 0);
-	if (ret)
-		return ret < 0 ? ret : -EINVAL;
-
-	return count;
-}
-
-static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
-			      const char *buf, size_t count)
-{
-	u32 tmp = 1;
-	bool clear;
-	int ret;
-
-	ret = kstrtobool(buf, &clear);
-	if (ret)
-		return ret;
-
-	if (clear == false)
-		return -EINVAL;
-
-	/* Clear the POST error code. It is kept until cleared. */
-	ret = hp_wmi_perform_query(HPWMI_POSTCODEERROR_QUERY, HPWMI_WRITE, &tmp,
-				       sizeof(tmp), 0);
-	if (ret)
-		return ret < 0 ? ret : -EINVAL;
-
-	return count;
-}
-
-static DEVICE_ATTR_RO(display);
-static DEVICE_ATTR_RO(hddtemp);
-static DEVICE_ATTR_RW(als);
-static DEVICE_ATTR_RO(dock);
-static DEVICE_ATTR_RO(tablet);
-static DEVICE_ATTR_RW(postcode);
-
-static struct attribute *hp_wmi_attrs[] = {
-	&dev_attr_display.attr,
-	&dev_attr_hddtemp.attr,
-	&dev_attr_als.attr,
-	&dev_attr_dock.attr,
-	&dev_attr_tablet.attr,
-	&dev_attr_postcode.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(hp_wmi);
-
-static void hp_wmi_notify(u32 value, void *context)
-{
-	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
-	u32 event_id, event_data;
-	union acpi_object *obj;
-	acpi_status status;
-	u32 *location;
-	int key_code;
-
-	status = wmi_get_event_data(value, &response);
-	if (status != AE_OK) {
-		pr_info("bad event status 0x%x\n", status);
-		return;
-	}
-
-	obj = (union acpi_object *)response.pointer;
-
-	if (!obj)
-		return;
-	if (obj->type != ACPI_TYPE_BUFFER) {
-		pr_info("Unknown response received %d\n", obj->type);
-		kfree(obj);
-		return;
-	}
-
-	/*
-	 * Depending on ACPI version the concatenation of id and event data
-	 * inside _WED function will result in a 8 or 16 byte buffer.
-	 */
-	location = (u32 *)obj->buffer.pointer;
-	if (obj->buffer.length == 8) {
-		event_id = *location;
-		event_data = *(location + 1);
-	} else if (obj->buffer.length == 16) {
-		event_id = *location;
-		event_data = *(location + 2);
-	} else {
-		pr_info("Unknown buffer length %d\n", obj->buffer.length);
-		kfree(obj);
-		return;
-	}
-	kfree(obj);
-
-	switch (event_id) {
-	case HPWMI_DOCK_EVENT:
-		if (test_bit(SW_DOCK, hp_wmi_input_dev->swbit))
-			input_report_switch(hp_wmi_input_dev, SW_DOCK,
-					    hp_wmi_get_dock_state());
-		if (test_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit))
-			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
-					    hp_wmi_get_tablet_mode());
-		input_sync(hp_wmi_input_dev);
-		break;
-	case HPWMI_PARK_HDD:
-		break;
-	case HPWMI_SMART_ADAPTER:
-		break;
-	case HPWMI_BEZEL_BUTTON:
-	case HPWMI_OMEN_KEY:
-		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
-		if (key_code < 0)
-			break;
-
-		if (!sparse_keymap_report_event(hp_wmi_input_dev,
-						key_code, 1, true))
-			pr_info("Unknown key code - 0x%x\n", key_code);
-		break;
-	case HPWMI_WIRELESS:
-		if (rfkill2_count) {
-			hp_wmi_rfkill2_refresh();
-			break;
-		}
-
-		if (wifi_rfkill)
-			rfkill_set_states(wifi_rfkill,
-					  hp_wmi_get_sw_state(HPWMI_WIFI),
-					  hp_wmi_get_hw_state(HPWMI_WIFI));
-		if (bluetooth_rfkill)
-			rfkill_set_states(bluetooth_rfkill,
-					  hp_wmi_get_sw_state(HPWMI_BLUETOOTH),
-					  hp_wmi_get_hw_state(HPWMI_BLUETOOTH));
-		if (wwan_rfkill)
-			rfkill_set_states(wwan_rfkill,
-					  hp_wmi_get_sw_state(HPWMI_WWAN),
-					  hp_wmi_get_hw_state(HPWMI_WWAN));
-		break;
-	case HPWMI_CPU_BATTERY_THROTTLE:
-		pr_info("Unimplemented CPU throttle because of 3 Cell battery event detected\n");
-		break;
-	case HPWMI_LOCK_SWITCH:
-		break;
-	case HPWMI_LID_SWITCH:
-		break;
-	case HPWMI_SCREEN_ROTATION:
-		break;
-	case HPWMI_COOLSENSE_SYSTEM_MOBILE:
-		break;
-	case HPWMI_COOLSENSE_SYSTEM_HOT:
-		break;
-	case HPWMI_PROXIMITY_SENSOR:
-		break;
-	case HPWMI_BACKLIT_KB_BRIGHTNESS:
-		break;
-	case HPWMI_PEAKSHIFT_PERIOD:
-		break;
-	case HPWMI_BATTERY_CHARGE_PERIOD:
-		break;
-	case HPWMI_SANITIZATION_MODE:
-		break;
-	case HPWMI_SMART_EXPERIENCE_APP:
-		break;
-	default:
-		pr_info("Unknown event_id - %d - 0x%x\n", event_id, event_data);
-		break;
-	}
-}
-
-static int __init hp_wmi_input_setup(void)
-{
-	acpi_status status;
-	int err, val;
-
-	hp_wmi_input_dev = input_allocate_device();
-	if (!hp_wmi_input_dev)
-		return -ENOMEM;
-
-	hp_wmi_input_dev->name = "HP WMI hotkeys";
-	hp_wmi_input_dev->phys = "wmi/input0";
-	hp_wmi_input_dev->id.bustype = BUS_HOST;
-
-	__set_bit(EV_SW, hp_wmi_input_dev->evbit);
-
-	/* Dock */
-	val = hp_wmi_get_dock_state();
-	if (!(val < 0)) {
-		__set_bit(SW_DOCK, hp_wmi_input_dev->swbit);
-		input_report_switch(hp_wmi_input_dev, SW_DOCK, val);
-	}
-
-	/* Tablet mode */
-	val = hp_wmi_get_tablet_mode();
-	if (!(val < 0)) {
-		__set_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit);
-		input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE, val);
-	}
-
-	err = sparse_keymap_setup(hp_wmi_input_dev, hp_wmi_keymap, NULL);
-	if (err)
-		goto err_free_dev;
-
-	/* Set initial hardware state */
-	input_sync(hp_wmi_input_dev);
-
-	if (!hp_wmi_bios_2009_later() && hp_wmi_bios_2008_later())
-		hp_wmi_enable_hotkeys();
-
-	status = wmi_install_notify_handler(HPWMI_EVENT_GUID, hp_wmi_notify, NULL);
-	if (ACPI_FAILURE(status)) {
-		err = -EIO;
-		goto err_free_dev;
-	}
-
-	err = input_register_device(hp_wmi_input_dev);
-	if (err)
-		goto err_uninstall_notifier;
-
-	return 0;
-
- err_uninstall_notifier:
-	wmi_remove_notify_handler(HPWMI_EVENT_GUID);
- err_free_dev:
-	input_free_device(hp_wmi_input_dev);
-	return err;
-}
-
-static void hp_wmi_input_destroy(void)
-{
-	wmi_remove_notify_handler(HPWMI_EVENT_GUID);
-	input_unregister_device(hp_wmi_input_dev);
-}
-
-static int __init hp_wmi_rfkill_setup(struct platform_device *device)
-{
-	int err, wireless;
-
-	wireless = hp_wmi_read_int(HPWMI_WIRELESS_QUERY);
-	if (wireless < 0)
-		return wireless;
-
-	err = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, HPWMI_WRITE, &wireless,
-				   sizeof(wireless), 0);
-	if (err)
-		return err;
-
-	if (wireless & 0x1) {
-		wifi_rfkill = rfkill_alloc("hp-wifi", &device->dev,
-					   RFKILL_TYPE_WLAN,
-					   &hp_wmi_rfkill_ops,
-					   (void *) HPWMI_WIFI);
-		if (!wifi_rfkill)
-			return -ENOMEM;
-		rfkill_init_sw_state(wifi_rfkill,
-				     hp_wmi_get_sw_state(HPWMI_WIFI));
-		rfkill_set_hw_state(wifi_rfkill,
-				    hp_wmi_get_hw_state(HPWMI_WIFI));
-		err = rfkill_register(wifi_rfkill);
-		if (err)
-			goto register_wifi_error;
-	}
-
-	if (wireless & 0x2) {
-		bluetooth_rfkill = rfkill_alloc("hp-bluetooth", &device->dev,
-						RFKILL_TYPE_BLUETOOTH,
-						&hp_wmi_rfkill_ops,
-						(void *) HPWMI_BLUETOOTH);
-		if (!bluetooth_rfkill) {
-			err = -ENOMEM;
-			goto register_bluetooth_error;
-		}
-		rfkill_init_sw_state(bluetooth_rfkill,
-				     hp_wmi_get_sw_state(HPWMI_BLUETOOTH));
-		rfkill_set_hw_state(bluetooth_rfkill,
-				    hp_wmi_get_hw_state(HPWMI_BLUETOOTH));
-		err = rfkill_register(bluetooth_rfkill);
-		if (err)
-			goto register_bluetooth_error;
-	}
-
-	if (wireless & 0x4) {
-		wwan_rfkill = rfkill_alloc("hp-wwan", &device->dev,
-					   RFKILL_TYPE_WWAN,
-					   &hp_wmi_rfkill_ops,
-					   (void *) HPWMI_WWAN);
-		if (!wwan_rfkill) {
-			err = -ENOMEM;
-			goto register_wwan_error;
-		}
-		rfkill_init_sw_state(wwan_rfkill,
-				     hp_wmi_get_sw_state(HPWMI_WWAN));
-		rfkill_set_hw_state(wwan_rfkill,
-				    hp_wmi_get_hw_state(HPWMI_WWAN));
-		err = rfkill_register(wwan_rfkill);
-		if (err)
-			goto register_wwan_error;
-	}
-
-	return 0;
-
-register_wwan_error:
-	rfkill_destroy(wwan_rfkill);
-	wwan_rfkill = NULL;
-	if (bluetooth_rfkill)
-		rfkill_unregister(bluetooth_rfkill);
-register_bluetooth_error:
-	rfkill_destroy(bluetooth_rfkill);
-	bluetooth_rfkill = NULL;
-	if (wifi_rfkill)
-		rfkill_unregister(wifi_rfkill);
-register_wifi_error:
-	rfkill_destroy(wifi_rfkill);
-	wifi_rfkill = NULL;
-	return err;
-}
-
-static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
-{
-	struct bios_rfkill2_state state;
-	int err, i;
-
-	err = hp_wmi_perform_query(HPWMI_WIRELESS2_QUERY, HPWMI_READ, &state,
-				   zero_if_sup(state), sizeof(state));
-	if (err)
-		return err < 0 ? err : -EINVAL;
-
-	if (state.count > HPWMI_MAX_RFKILL2_DEVICES) {
-		pr_warn("unable to parse 0x1b query output\n");
-		return -EINVAL;
-	}
-
-	for (i = 0; i < state.count; i++) {
-		struct rfkill *rfkill;
-		enum rfkill_type type;
-		char *name;
-
-		switch (state.device[i].radio_type) {
-		case HPWMI_WIFI:
-			type = RFKILL_TYPE_WLAN;
-			name = "hp-wifi";
-			break;
-		case HPWMI_BLUETOOTH:
-			type = RFKILL_TYPE_BLUETOOTH;
-			name = "hp-bluetooth";
-			break;
-		case HPWMI_WWAN:
-			type = RFKILL_TYPE_WWAN;
-			name = "hp-wwan";
-			break;
-		case HPWMI_GPS:
-			type = RFKILL_TYPE_GPS;
-			name = "hp-gps";
-			break;
-		default:
-			pr_warn("unknown device type 0x%x\n",
-				state.device[i].radio_type);
-			continue;
-		}
-
-		if (!state.device[i].vendor_id) {
-			pr_warn("zero device %d while %d reported\n",
-				i, state.count);
-			continue;
-		}
-
-		rfkill = rfkill_alloc(name, &device->dev, type,
-				      &hp_wmi_rfkill2_ops, (void *)(long)i);
-		if (!rfkill) {
-			err = -ENOMEM;
-			goto fail;
-		}
-
-		rfkill2[rfkill2_count].id = state.device[i].rfkill_id;
-		rfkill2[rfkill2_count].num = i;
-		rfkill2[rfkill2_count].rfkill = rfkill;
-
-		rfkill_init_sw_state(rfkill,
-				     IS_SWBLOCKED(state.device[i].power));
-		rfkill_set_hw_state(rfkill,
-				    IS_HWBLOCKED(state.device[i].power));
-
-		if (!(state.device[i].power & HPWMI_POWER_BIOS))
-			pr_info("device %s blocked by BIOS\n", name);
-
-		err = rfkill_register(rfkill);
-		if (err) {
-			rfkill_destroy(rfkill);
-			goto fail;
-		}
-
-		rfkill2_count++;
-	}
-
-	return 0;
-fail:
-	for (; rfkill2_count > 0; rfkill2_count--) {
-		rfkill_unregister(rfkill2[rfkill2_count - 1].rfkill);
-		rfkill_destroy(rfkill2[rfkill2_count - 1].rfkill);
-	}
-	return err;
-}
-
-static int platform_profile_omen_get(struct platform_profile_handler *pprof,
-				     enum platform_profile_option *profile)
-{
-	int tp;
-
-	tp = omen_thermal_profile_get();
-	if (tp < 0)
-		return tp;
-
-	switch (tp) {
-	case HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE:
-	case HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE:
-		*profile = PLATFORM_PROFILE_PERFORMANCE;
-		break;
-	case HP_OMEN_V0_THERMAL_PROFILE_DEFAULT:
-	case HP_OMEN_V1_THERMAL_PROFILE_DEFAULT:
-		*profile = PLATFORM_PROFILE_BALANCED;
-		break;
-	case HP_OMEN_V0_THERMAL_PROFILE_COOL:
-	case HP_OMEN_V1_THERMAL_PROFILE_COOL:
-		*profile = PLATFORM_PROFILE_COOL;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int platform_profile_omen_set(struct platform_profile_handler *pprof,
-				     enum platform_profile_option profile)
-{
-	int err, tp, tp_version;
-
-	tp_version = omen_get_thermal_policy_version();
-
-	if (tp_version < 0 || tp_version > 1)
-		return -EOPNOTSUPP;
-
-	switch (profile) {
-	case PLATFORM_PROFILE_PERFORMANCE:
-		if (tp_version == 0)
-			tp = HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE;
-		else
-			tp = HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE;
-		break;
-	case PLATFORM_PROFILE_BALANCED:
-		if (tp_version == 0)
-			tp = HP_OMEN_V0_THERMAL_PROFILE_DEFAULT;
-		else
-			tp = HP_OMEN_V1_THERMAL_PROFILE_DEFAULT;
-		break;
-	case PLATFORM_PROFILE_COOL:
-		if (tp_version == 0)
-			tp = HP_OMEN_V0_THERMAL_PROFILE_COOL;
-		else
-			tp = HP_OMEN_V1_THERMAL_PROFILE_COOL;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	err = omen_thermal_profile_set(tp);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-static int thermal_profile_get(void)
-{
-	return hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
-}
-
-static int thermal_profile_set(int thermal_profile)
-{
-	return hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE, &thermal_profile,
-							   sizeof(thermal_profile), 0);
-}
-
-static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
-					enum platform_profile_option *profile)
-{
-	int tp;
-
-	tp = thermal_profile_get();
-	if (tp < 0)
-		return tp;
-
-	switch (tp) {
-	case HP_THERMAL_PROFILE_PERFORMANCE:
-		*profile =  PLATFORM_PROFILE_PERFORMANCE;
-		break;
-	case HP_THERMAL_PROFILE_DEFAULT:
-		*profile =  PLATFORM_PROFILE_BALANCED;
-		break;
-	case HP_THERMAL_PROFILE_COOL:
-		*profile =  PLATFORM_PROFILE_COOL;
-		break;
-	case HP_THERMAL_PROFILE_QUIET:
-		*profile = PLATFORM_PROFILE_QUIET;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
-					enum platform_profile_option profile)
-{
-	int err, tp;
-
-	switch (profile) {
-	case PLATFORM_PROFILE_PERFORMANCE:
-		tp =  HP_THERMAL_PROFILE_PERFORMANCE;
-		break;
-	case PLATFORM_PROFILE_BALANCED:
-		tp =  HP_THERMAL_PROFILE_DEFAULT;
-		break;
-	case PLATFORM_PROFILE_COOL:
-		tp =  HP_THERMAL_PROFILE_COOL;
-		break;
-	case PLATFORM_PROFILE_QUIET:
-		tp = HP_THERMAL_PROFILE_QUIET;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	err = thermal_profile_set(tp);
-	if (err)
-		return err;
-
-	return 0;
-}
-
-static int thermal_profile_setup(void)
-{
-	int err, tp;
-
-	if (is_omen_thermal_profile()) {
-		tp = omen_thermal_profile_get();
-		if (tp < 0)
-			return tp;
-
-		/*
-		 * call thermal profile write command to ensure that the
-		 * firmware correctly sets the OEM variables
-		 */
-
-		err = omen_thermal_profile_set(tp);
-		if (err < 0)
-			return err;
-
-		platform_profile_handler.profile_get = platform_profile_omen_get;
-		platform_profile_handler.profile_set = platform_profile_omen_set;
-	} else {
-		tp = thermal_profile_get();
-
-		if (tp < 0)
-			return tp;
-
-		/*
-		 * call thermal profile write command to ensure that the
-		 * firmware correctly sets the OEM variables for the DPTF
-		 */
-		err = thermal_profile_set(tp);
-		if (err)
-			return err;
-
-		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
-		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
-
-		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
-	}
-
-	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
-
-	err = platform_profile_register(&platform_profile_handler);
-	if (err)
-		return err;
-
-	platform_profile_support = true;
-
-	return 0;
-}
-
-static int hp_wmi_hwmon_init(void);
-
-static int __init hp_wmi_bios_setup(struct platform_device *device)
-{
-	int err;
-	/* clear detected rfkill devices */
-	wifi_rfkill = NULL;
-	bluetooth_rfkill = NULL;
-	wwan_rfkill = NULL;
-	rfkill2_count = 0;
-
-	/*
-	 * In pre-2009 BIOS, command 1Bh return 0x4 to indicate that
-	 * BIOS no longer controls the power for the wireless
-	 * devices. All features supported by this command will no
-	 * longer be supported.
-	 */
-	if (!hp_wmi_bios_2009_later()) {
-		if (hp_wmi_rfkill_setup(device))
-			hp_wmi_rfkill2_setup(device);
-	}
-
-	err = hp_wmi_hwmon_init();
-
-	if (err < 0)
-		return err;
-
-	thermal_profile_setup();
-
-	return 0;
-}
-
-static int __exit hp_wmi_bios_remove(struct platform_device *device)
-{
-	int i;
-
-	for (i = 0; i < rfkill2_count; i++) {
-		rfkill_unregister(rfkill2[i].rfkill);
-		rfkill_destroy(rfkill2[i].rfkill);
-	}
-
-	if (wifi_rfkill) {
-		rfkill_unregister(wifi_rfkill);
-		rfkill_destroy(wifi_rfkill);
-	}
-	if (bluetooth_rfkill) {
-		rfkill_unregister(bluetooth_rfkill);
-		rfkill_destroy(bluetooth_rfkill);
-	}
-	if (wwan_rfkill) {
-		rfkill_unregister(wwan_rfkill);
-		rfkill_destroy(wwan_rfkill);
-	}
-
-	if (platform_profile_support)
-		platform_profile_remove();
-
-	return 0;
-}
-
-static int hp_wmi_resume_handler(struct device *device)
-{
-	/*
-	 * Hardware state may have changed while suspended, so trigger
-	 * input events for the current state. As this is a switch,
-	 * the input layer will only actually pass it on if the state
-	 * changed.
-	 */
-	if (hp_wmi_input_dev) {
-		if (test_bit(SW_DOCK, hp_wmi_input_dev->swbit))
-			input_report_switch(hp_wmi_input_dev, SW_DOCK,
-					    hp_wmi_get_dock_state());
-		if (test_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit))
-			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
-					    hp_wmi_get_tablet_mode());
-		input_sync(hp_wmi_input_dev);
-	}
-
-	if (rfkill2_count)
-		hp_wmi_rfkill2_refresh();
-
-	if (wifi_rfkill)
-		rfkill_set_states(wifi_rfkill,
-				  hp_wmi_get_sw_state(HPWMI_WIFI),
-				  hp_wmi_get_hw_state(HPWMI_WIFI));
-	if (bluetooth_rfkill)
-		rfkill_set_states(bluetooth_rfkill,
-				  hp_wmi_get_sw_state(HPWMI_BLUETOOTH),
-				  hp_wmi_get_hw_state(HPWMI_BLUETOOTH));
-	if (wwan_rfkill)
-		rfkill_set_states(wwan_rfkill,
-				  hp_wmi_get_sw_state(HPWMI_WWAN),
-				  hp_wmi_get_hw_state(HPWMI_WWAN));
-
-	return 0;
-}
-
-static const struct dev_pm_ops hp_wmi_pm_ops = {
-	.resume  = hp_wmi_resume_handler,
-	.restore  = hp_wmi_resume_handler,
-};
-
-static struct platform_driver hp_wmi_driver = {
-	.driver = {
-		.name = "hp-wmi",
-		.pm = &hp_wmi_pm_ops,
-		.dev_groups = hp_wmi_groups,
-	},
-	.remove = __exit_p(hp_wmi_bios_remove),
-};
-
-static umode_t hp_wmi_hwmon_is_visible(const void *data,
-				       enum hwmon_sensor_types type,
-				       u32 attr, int channel)
-{
-	switch (type) {
-	case hwmon_pwm:
-		return 0644;
-	case hwmon_fan:
-		if (hp_wmi_get_fan_speed(channel) >= 0)
-			return 0444;
-		break;
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
-static int hp_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
-			     u32 attr, int channel, long *val)
-{
-	int ret;
-
-	switch (type) {
-	case hwmon_fan:
-		ret = hp_wmi_get_fan_speed(channel);
-
-		if (ret < 0)
-			return ret;
-		*val = ret;
-		return 0;
-	case hwmon_pwm:
-		switch (hp_wmi_fan_speed_max_get()) {
-		case 0:
-			/* 0 is automatic fan, which is 2 for hwmon */
-			*val = 2;
-			return 0;
-		case 1:
-			/* 1 is max fan, which is 0
-			 * (no fan speed control) for hwmon
-			 */
-			*val = 0;
-			return 0;
-		default:
-			/* shouldn't happen */
-			return -ENODATA;
-		}
-	default:
-		return -EINVAL;
-	}
-}
-
-static int hp_wmi_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
-			      u32 attr, int channel, long val)
-{
-	switch (type) {
-	case hwmon_pwm:
-		switch (val) {
-		case 0:
-			/* 0 is no fan speed control (max), which is 1 for us */
-			return hp_wmi_fan_speed_max_set(1);
-		case 2:
-			/* 2 is automatic speed control, which is 0 for us */
-			return hp_wmi_fan_speed_max_set(0);
-		default:
-			/* we don't support manual fan speed control */
-			return -EINVAL;
-		}
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-static const struct hwmon_channel_info *info[] = {
-	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT, HWMON_F_INPUT),
-	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_ENABLE),
-	NULL
-};
-
-static const struct hwmon_ops ops = {
-	.is_visible = hp_wmi_hwmon_is_visible,
-	.read = hp_wmi_hwmon_read,
-	.write = hp_wmi_hwmon_write,
-};
-
-static const struct hwmon_chip_info chip_info = {
-	.ops = &ops,
-	.info = info,
-};
-
-static int hp_wmi_hwmon_init(void)
-{
-	struct device *dev = &hp_wmi_platform_dev->dev;
-	struct device *hwmon;
-
-	hwmon = devm_hwmon_device_register_with_info(dev, "hp", &hp_wmi_driver,
-						     &chip_info, NULL);
-
-	if (IS_ERR(hwmon)) {
-		dev_err(dev, "Could not register hp hwmon device\n");
-		return PTR_ERR(hwmon);
-	}
-
-	return 0;
-}
-
-static int __init hp_wmi_init(void)
-{
-	int event_capable = wmi_has_guid(HPWMI_EVENT_GUID);
-	int bios_capable = wmi_has_guid(HPWMI_BIOS_GUID);
-	int err, tmp = 0;
-
-	if (!bios_capable && !event_capable)
-		return -ENODEV;
-
-	if (hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, HPWMI_READ, &tmp,
-				 sizeof(tmp), sizeof(tmp)) == HPWMI_RET_INVALID_PARAMETERS)
-		zero_insize_support = true;
-
-	if (event_capable) {
-		err = hp_wmi_input_setup();
-		if (err)
-			return err;
-	}
-
-	if (bios_capable) {
-		hp_wmi_platform_dev =
-			platform_device_register_simple("hp-wmi", PLATFORM_DEVID_NONE, NULL, 0);
-		if (IS_ERR(hp_wmi_platform_dev)) {
-			err = PTR_ERR(hp_wmi_platform_dev);
-			goto err_destroy_input;
-		}
-
-		err = platform_driver_probe(&hp_wmi_driver, hp_wmi_bios_setup);
-		if (err)
-			goto err_unregister_device;
-	}
-
-	return 0;
-
-err_unregister_device:
-	platform_device_unregister(hp_wmi_platform_dev);
-err_destroy_input:
-	if (event_capable)
-		hp_wmi_input_destroy();
-
-	return err;
-}
-module_init(hp_wmi_init);
-
-static void __exit hp_wmi_exit(void)
-{
-	if (wmi_has_guid(HPWMI_EVENT_GUID))
-		hp_wmi_input_destroy();
-
-	if (hp_wmi_platform_dev) {
-		platform_device_unregister(hp_wmi_platform_dev);
-		platform_driver_unregister(&hp_wmi_driver);
-	}
-}
-module_exit(hp_wmi_exit);
diff --git a/drivers/platform/x86/hp/Kconfig b/drivers/platform/x86/hp/Kconfig
new file mode 100644
index 000000000000..ae165955311c
--- /dev/null
+++ b/drivers/platform/x86/hp/Kconfig
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# X86 Platform Specific Drivers
+#
+menuconfig X86_PLATFORM_DRIVERS_HP
+	bool "HP X86 Platform Specific Device Drivers"
+	depends on X86_PLATFORM_DEVICES
+	help
+	  Say Y here to get to see options for device drivers for various
+	  HP x86 platforms, including vendor-specific laptop extension drivers.
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if X86_PLATFORM_DRIVERS_HP
+
+config HP_ACCEL
+	tristate "HP laptop accelerometer"
+	default m
+	depends on INPUT && ACPI
+	depends on SERIO_I8042
+	select SENSORS_LIS3LV02D
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	  This driver provides support for the "Mobile Data Protection System 3D"
+	  or "3D DriveGuard" feature of HP laptops. On such systems the driver
+	  should load automatically (via ACPI alias).
+
+	  Support for a led indicating disk protection will be provided as
+	  hp::hddprotect. For more information on the feature, refer to
+	  Documentation/misc-devices/lis3lv02d.rst.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called hp_accel.
+
+config HP_WMI
+	tristate "HP WMI extras"
+	default m
+	depends on ACPI_WMI
+	depends on INPUT
+	depends on RFKILL || RFKILL = n
+	select INPUT_SPARSEKMAP
+	select ACPI_PLATFORM_PROFILE
+	select HWMON
+	help
+	  Say Y here if you want to support WMI-based hotkeys on HP laptops and
+	  to read data from WMI such as docking or ambient light sensor state.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called hp-wmi.
+
+config TC1100_WMI
+	tristate "HP Compaq TC1100 Tablet WMI Extras"
+	default m
+	depends on !X86_64
+	depends on ACPI
+	depends on ACPI_WMI
+	help
+	  This is a driver for the WMI extensions (wireless and bluetooth power
+	  control) of the HP Compaq TC1100 tablet.
+
+endif # X86_PLATFORM_DRIVERS_HP
diff --git a/drivers/platform/x86/hp/Makefile b/drivers/platform/x86/hp/Makefile
new file mode 100644
index 000000000000..db1eed4cd7c7
--- /dev/null
+++ b/drivers/platform/x86/hp/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/x86/hp
+# HP x86 Platform-Specific Drivers
+#
+
+# Hewlett Packard
+obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
+obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
+obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
new file mode 100644
index 000000000000..94af7d398a1b
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -0,0 +1,1571 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HP WMI hotkeys
+ *
+ * Copyright (C) 2008 Red Hat <mjg@redhat.com>
+ * Copyright (C) 2010, 2011 Anssi Hannula <anssi.hannula@iki.fi>
+ *
+ * Portions based on wistron_btns.c:
+ * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
+ * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
+ * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/platform_device.h>
+#include <linux/platform_profile.h>
+#include <linux/hwmon.h>
+#include <linux/acpi.h>
+#include <linux/rfkill.h>
+#include <linux/string.h>
+#include <linux/dmi.h>
+
+MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
+MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS("wmi:95F24279-4D7B-4334-9387-ACCDC67EF61C");
+MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
+
+#define HPWMI_EVENT_GUID "95F24279-4D7B-4334-9387-ACCDC67EF61C"
+#define HPWMI_BIOS_GUID "5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
+#define HP_OMEN_EC_THERMAL_PROFILE_OFFSET 0x95
+#define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
+
+/* DMI board names of devices that should use the omen specific path for
+ * thermal profiles.
+ * This was obtained by taking a look in the windows omen command center
+ * app and parsing a json file that they use to figure out what capabilities
+ * the device should have.
+ * A device is considered an omen if the DisplayName in that list contains
+ * "OMEN", and it can use the thermal profile stuff if the "Feature" array
+ * contains "PerformanceControl".
+ */
+static const char * const omen_thermal_profile_boards[] = {
+	"84DA", "84DB", "84DC", "8574", "8575", "860A", "87B5", "8572", "8573",
+	"8600", "8601", "8602", "8605", "8606", "8607", "8746", "8747", "8749",
+	"874A", "8603", "8604", "8748", "886B", "886C", "878A", "878B", "878C",
+	"88C8", "88CB", "8786", "8787", "8788", "88D1", "88D2", "88F4", "88FD",
+	"88F5", "88F6", "88F7", "88FE", "88FF", "8900", "8901", "8902", "8912",
+	"8917", "8918", "8949", "894A", "89EB"
+};
+
+/* DMI Board names of Omen laptops that are specifically set to be thermal
+ * profile version 0 by the Omen Command Center app, regardless of what
+ * the get system design information WMI call returns
+ */
+static const char *const omen_thermal_profile_force_v0_boards[] = {
+	"8607", "8746", "8747", "8749", "874A", "8748"
+};
+
+enum hp_wmi_radio {
+	HPWMI_WIFI	= 0x0,
+	HPWMI_BLUETOOTH	= 0x1,
+	HPWMI_WWAN	= 0x2,
+	HPWMI_GPS	= 0x3,
+};
+
+enum hp_wmi_event_ids {
+	HPWMI_DOCK_EVENT		= 0x01,
+	HPWMI_PARK_HDD			= 0x02,
+	HPWMI_SMART_ADAPTER		= 0x03,
+	HPWMI_BEZEL_BUTTON		= 0x04,
+	HPWMI_WIRELESS			= 0x05,
+	HPWMI_CPU_BATTERY_THROTTLE	= 0x06,
+	HPWMI_LOCK_SWITCH		= 0x07,
+	HPWMI_LID_SWITCH		= 0x08,
+	HPWMI_SCREEN_ROTATION		= 0x09,
+	HPWMI_COOLSENSE_SYSTEM_MOBILE	= 0x0A,
+	HPWMI_COOLSENSE_SYSTEM_HOT	= 0x0B,
+	HPWMI_PROXIMITY_SENSOR		= 0x0C,
+	HPWMI_BACKLIT_KB_BRIGHTNESS	= 0x0D,
+	HPWMI_PEAKSHIFT_PERIOD		= 0x0F,
+	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
+	HPWMI_SANITIZATION_MODE		= 0x17,
+	HPWMI_OMEN_KEY			= 0x1D,
+	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
+};
+
+/*
+ * struct bios_args buffer is dynamically allocated.  New WMI command types
+ * were introduced that exceeds 128-byte data size.  Changes to handle
+ * the data size allocation scheme were kept in hp_wmi_perform_qurey function.
+ */
+struct bios_args {
+	u32 signature;
+	u32 command;
+	u32 commandtype;
+	u32 datasize;
+	u8 data[];
+};
+
+enum hp_wmi_commandtype {
+	HPWMI_DISPLAY_QUERY		= 0x01,
+	HPWMI_HDDTEMP_QUERY		= 0x02,
+	HPWMI_ALS_QUERY			= 0x03,
+	HPWMI_HARDWARE_QUERY		= 0x04,
+	HPWMI_WIRELESS_QUERY		= 0x05,
+	HPWMI_BATTERY_QUERY		= 0x07,
+	HPWMI_BIOS_QUERY		= 0x09,
+	HPWMI_FEATURE_QUERY		= 0x0b,
+	HPWMI_HOTKEY_QUERY		= 0x0c,
+	HPWMI_FEATURE2_QUERY		= 0x0d,
+	HPWMI_WIRELESS2_QUERY		= 0x1b,
+	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
+	HPWMI_SYSTEM_DEVICE_MODE	= 0x40,
+	HPWMI_THERMAL_PROFILE_QUERY	= 0x4c,
+};
+
+enum hp_wmi_gm_commandtype {
+	HPWMI_FAN_SPEED_GET_QUERY = 0x11,
+	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
+	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
+	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
+	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
+};
+
+enum hp_wmi_command {
+	HPWMI_READ	= 0x01,
+	HPWMI_WRITE	= 0x02,
+	HPWMI_ODM	= 0x03,
+	HPWMI_GM	= 0x20008,
+};
+
+enum hp_wmi_hardware_mask {
+	HPWMI_DOCK_MASK		= 0x01,
+	HPWMI_TABLET_MASK	= 0x04,
+};
+
+struct bios_return {
+	u32 sigpass;
+	u32 return_code;
+};
+
+enum hp_return_value {
+	HPWMI_RET_WRONG_SIGNATURE	= 0x02,
+	HPWMI_RET_UNKNOWN_COMMAND	= 0x03,
+	HPWMI_RET_UNKNOWN_CMDTYPE	= 0x04,
+	HPWMI_RET_INVALID_PARAMETERS	= 0x05,
+};
+
+enum hp_wireless2_bits {
+	HPWMI_POWER_STATE	= 0x01,
+	HPWMI_POWER_SOFT	= 0x02,
+	HPWMI_POWER_BIOS	= 0x04,
+	HPWMI_POWER_HARD	= 0x08,
+	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
+};
+
+enum hp_thermal_profile_omen_v0 {
+	HP_OMEN_V0_THERMAL_PROFILE_DEFAULT     = 0x00,
+	HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE = 0x01,
+	HP_OMEN_V0_THERMAL_PROFILE_COOL        = 0x02,
+};
+
+enum hp_thermal_profile_omen_v1 {
+	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	= 0x30,
+	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE	= 0x31,
+	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
+};
+
+enum hp_thermal_profile {
+	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
+	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
+	HP_THERMAL_PROFILE_COOL			= 0x02,
+	HP_THERMAL_PROFILE_QUIET		= 0x03,
+};
+
+#define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
+#define IS_SWBLOCKED(x) !(x & HPWMI_POWER_SOFT)
+
+struct bios_rfkill2_device_state {
+	u8 radio_type;
+	u8 bus_type;
+	u16 vendor_id;
+	u16 product_id;
+	u16 subsys_vendor_id;
+	u16 subsys_product_id;
+	u8 rfkill_id;
+	u8 power;
+	u8 unknown[4];
+};
+
+/* 7 devices fit into the 128 byte buffer */
+#define HPWMI_MAX_RFKILL2_DEVICES	7
+
+struct bios_rfkill2_state {
+	u8 unknown[7];
+	u8 count;
+	u8 pad[8];
+	struct bios_rfkill2_device_state device[HPWMI_MAX_RFKILL2_DEVICES];
+};
+
+static const struct key_entry hp_wmi_keymap[] = {
+	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x270,   { KEY_MICMUTE } },
+	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
+	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
+	{ KE_KEY, 0x2142,  { KEY_MEDIA } },
+	{ KE_KEY, 0x213b,  { KEY_INFO } },
+	{ KE_KEY, 0x2169,  { KEY_ROTATE_DISPLAY } },
+	{ KE_KEY, 0x216a,  { KEY_SETUP } },
+	{ KE_KEY, 0x21a5,  { KEY_PROG2 } }, /* HP Omen Key */
+	{ KE_KEY, 0x21a7,  { KEY_FN_ESC } },
+	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
+	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
+	{ KE_KEY, 0x231b,  { KEY_HELP } },
+	{ KE_END, 0 }
+};
+
+static struct input_dev *hp_wmi_input_dev;
+static struct platform_device *hp_wmi_platform_dev;
+static struct platform_profile_handler platform_profile_handler;
+static bool platform_profile_support;
+static bool zero_insize_support;
+
+static struct rfkill *wifi_rfkill;
+static struct rfkill *bluetooth_rfkill;
+static struct rfkill *wwan_rfkill;
+
+struct rfkill2_device {
+	u8 id;
+	int num;
+	struct rfkill *rfkill;
+};
+
+static int rfkill2_count;
+static struct rfkill2_device rfkill2[HPWMI_MAX_RFKILL2_DEVICES];
+
+/*
+ * Chassis Types values were obtained from SMBIOS reference
+ * specification version 3.00. A complete list of system enclosures
+ * and chassis types is available on Table 17.
+ */
+static const char * const tablet_chassis_types[] = {
+	"30", /* Tablet*/
+	"31", /* Convertible */
+	"32"  /* Detachable */
+};
+
+#define DEVICE_MODE_TABLET	0x06
+
+/* map output size to the corresponding WMI method id */
+static inline int encode_outsize_for_pvsz(int outsize)
+{
+	if (outsize > 4096)
+		return -EINVAL;
+	if (outsize > 1024)
+		return 5;
+	if (outsize > 128)
+		return 4;
+	if (outsize > 4)
+		return 3;
+	if (outsize > 0)
+		return 2;
+	return 1;
+}
+
+/*
+ * hp_wmi_perform_query
+ *
+ * query:	The commandtype (enum hp_wmi_commandtype)
+ * write:	The command (enum hp_wmi_command)
+ * buffer:	Buffer used as input and/or output
+ * insize:	Size of input buffer
+ * outsize:	Size of output buffer
+ *
+ * returns zero on success
+ *         an HP WMI query specific error code (which is positive)
+ *         -EINVAL if the query was not successful at all
+ *         -EINVAL if the output buffer size exceeds buffersize
+ *
+ * Note: The buffersize must at least be the maximum of the input and output
+ *       size. E.g. Battery info query is defined to have 1 byte input
+ *       and 128 byte output. The caller would do:
+ *       buffer = kzalloc(128, GFP_KERNEL);
+ *       ret = hp_wmi_perform_query(HPWMI_BATTERY_QUERY, HPWMI_READ, buffer, 1, 128)
+ */
+static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
+				void *buffer, int insize, int outsize)
+{
+	struct acpi_buffer input, output = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct bios_return *bios_return;
+	union acpi_object *obj = NULL;
+	struct bios_args *args = NULL;
+	int mid, actual_insize, actual_outsize;
+	size_t bios_args_size;
+	int ret;
+
+	mid = encode_outsize_for_pvsz(outsize);
+	if (WARN_ON(mid < 0))
+		return mid;
+
+	actual_insize = max(insize, 128);
+	bios_args_size = struct_size(args, data, actual_insize);
+	args = kmalloc(bios_args_size, GFP_KERNEL);
+	if (!args)
+		return -ENOMEM;
+
+	input.length = bios_args_size;
+	input.pointer = args;
+
+	args->signature = 0x55434553;
+	args->command = command;
+	args->commandtype = query;
+	args->datasize = insize;
+	memcpy(args->data, buffer, flex_array_size(args, data, insize));
+
+	ret = wmi_evaluate_method(HPWMI_BIOS_GUID, 0, mid, &input, &output);
+	if (ret)
+		goto out_free;
+
+	obj = output.pointer;
+	if (!obj) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		pr_warn("query 0x%x returned an invalid object 0x%x\n", query, ret);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	bios_return = (struct bios_return *)obj->buffer.pointer;
+	ret = bios_return->return_code;
+
+	if (ret) {
+		if (ret != HPWMI_RET_UNKNOWN_COMMAND &&
+		    ret != HPWMI_RET_UNKNOWN_CMDTYPE)
+			pr_warn("query 0x%x returned error 0x%x\n", query, ret);
+		goto out_free;
+	}
+
+	/* Ignore output data of zero size */
+	if (!outsize)
+		goto out_free;
+
+	actual_outsize = min(outsize, (int)(obj->buffer.length - sizeof(*bios_return)));
+	memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual_outsize);
+	memset(buffer + actual_outsize, 0, outsize - actual_outsize);
+
+out_free:
+	kfree(obj);
+	kfree(args);
+	return ret;
+}
+
+static int hp_wmi_get_fan_speed(int fan)
+{
+	u8 fsh, fsl;
+	char fan_data[4] = { fan, 0, 0, 0 };
+
+	int ret = hp_wmi_perform_query(HPWMI_FAN_SPEED_GET_QUERY, HPWMI_GM,
+				       &fan_data, sizeof(char),
+				       sizeof(fan_data));
+
+	if (ret != 0)
+		return -EINVAL;
+
+	fsh = fan_data[2];
+	fsl = fan_data[3];
+
+	return (fsh << 8) | fsl;
+}
+
+static int hp_wmi_read_int(int query)
+{
+	int val = 0, ret;
+
+	ret = hp_wmi_perform_query(query, HPWMI_READ, &val,
+				   zero_if_sup(val), sizeof(val));
+
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	return val;
+}
+
+static int hp_wmi_get_dock_state(void)
+{
+	int state = hp_wmi_read_int(HPWMI_HARDWARE_QUERY);
+
+	if (state < 0)
+		return state;
+
+	return !!(state & HPWMI_DOCK_MASK);
+}
+
+static int hp_wmi_get_tablet_mode(void)
+{
+	char system_device_mode[4] = { 0 };
+	const char *chassis_type;
+	bool tablet_found;
+	int ret;
+
+	chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
+	if (!chassis_type)
+		return -ENODEV;
+
+	tablet_found = match_string(tablet_chassis_types,
+				    ARRAY_SIZE(tablet_chassis_types),
+				    chassis_type) >= 0;
+	if (!tablet_found)
+		return -ENODEV;
+
+	ret = hp_wmi_perform_query(HPWMI_SYSTEM_DEVICE_MODE, HPWMI_READ,
+				   system_device_mode, zero_if_sup(system_device_mode),
+				   sizeof(system_device_mode));
+	if (ret < 0)
+		return ret;
+
+	return system_device_mode[0] == DEVICE_MODE_TABLET;
+}
+
+static int omen_thermal_profile_set(int mode)
+{
+	char buffer[2] = {0, mode};
+	int ret;
+
+	ret = hp_wmi_perform_query(HPWMI_SET_PERFORMANCE_MODE, HPWMI_GM,
+				   &buffer, sizeof(buffer), 0);
+
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	return mode;
+}
+
+static bool is_omen_thermal_profile(void)
+{
+	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
+
+	if (!board_name)
+		return false;
+
+	return match_string(omen_thermal_profile_boards,
+			    ARRAY_SIZE(omen_thermal_profile_boards),
+			    board_name) >= 0;
+}
+
+static int omen_get_thermal_policy_version(void)
+{
+	unsigned char buffer[8] = { 0 };
+	int ret;
+
+	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
+
+	if (board_name) {
+		int matches = match_string(omen_thermal_profile_force_v0_boards,
+			ARRAY_SIZE(omen_thermal_profile_force_v0_boards),
+			board_name);
+		if (matches >= 0)
+			return 0;
+	}
+
+	ret = hp_wmi_perform_query(HPWMI_GET_SYSTEM_DESIGN_DATA, HPWMI_GM,
+				   &buffer, sizeof(buffer), sizeof(buffer));
+
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	return buffer[3];
+}
+
+static int omen_thermal_profile_get(void)
+{
+	u8 data;
+
+	int ret = ec_read(HP_OMEN_EC_THERMAL_PROFILE_OFFSET, &data);
+
+	if (ret)
+		return ret;
+
+	return data;
+}
+
+static int hp_wmi_fan_speed_max_set(int enabled)
+{
+	int ret;
+
+	ret = hp_wmi_perform_query(HPWMI_FAN_SPEED_MAX_SET_QUERY, HPWMI_GM,
+				   &enabled, sizeof(enabled), 0);
+
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	return enabled;
+}
+
+static int hp_wmi_fan_speed_max_get(void)
+{
+	int val = 0, ret;
+
+	ret = hp_wmi_perform_query(HPWMI_FAN_SPEED_MAX_GET_QUERY, HPWMI_GM,
+				   &val, zero_if_sup(val), sizeof(val));
+
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	return val;
+}
+
+static int __init hp_wmi_bios_2008_later(void)
+{
+	int state = 0;
+	int ret = hp_wmi_perform_query(HPWMI_FEATURE_QUERY, HPWMI_READ, &state,
+				       zero_if_sup(state), sizeof(state));
+	if (!ret)
+		return 1;
+
+	return (ret == HPWMI_RET_UNKNOWN_CMDTYPE) ? 0 : -ENXIO;
+}
+
+static int __init hp_wmi_bios_2009_later(void)
+{
+	u8 state[128];
+	int ret = hp_wmi_perform_query(HPWMI_FEATURE2_QUERY, HPWMI_READ, &state,
+				       zero_if_sup(state), sizeof(state));
+	if (!ret)
+		return 1;
+
+	return (ret == HPWMI_RET_UNKNOWN_CMDTYPE) ? 0 : -ENXIO;
+}
+
+static int __init hp_wmi_enable_hotkeys(void)
+{
+	int value = 0x6e;
+	int ret = hp_wmi_perform_query(HPWMI_BIOS_QUERY, HPWMI_WRITE, &value,
+				       sizeof(value), 0);
+
+	return ret <= 0 ? ret : -EINVAL;
+}
+
+static int hp_wmi_set_block(void *data, bool blocked)
+{
+	enum hp_wmi_radio r = (enum hp_wmi_radio) data;
+	int query = BIT(r + 8) | ((!blocked) << r);
+	int ret;
+
+	ret = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, HPWMI_WRITE,
+				   &query, sizeof(query), 0);
+
+	return ret <= 0 ? ret : -EINVAL;
+}
+
+static const struct rfkill_ops hp_wmi_rfkill_ops = {
+	.set_block = hp_wmi_set_block,
+};
+
+static bool hp_wmi_get_sw_state(enum hp_wmi_radio r)
+{
+	int mask = 0x200 << (r * 8);
+
+	int wireless = hp_wmi_read_int(HPWMI_WIRELESS_QUERY);
+
+	/* TBD: Pass error */
+	WARN_ONCE(wireless < 0, "error executing HPWMI_WIRELESS_QUERY");
+
+	return !(wireless & mask);
+}
+
+static bool hp_wmi_get_hw_state(enum hp_wmi_radio r)
+{
+	int mask = 0x800 << (r * 8);
+
+	int wireless = hp_wmi_read_int(HPWMI_WIRELESS_QUERY);
+
+	/* TBD: Pass error */
+	WARN_ONCE(wireless < 0, "error executing HPWMI_WIRELESS_QUERY");
+
+	return !(wireless & mask);
+}
+
+static int hp_wmi_rfkill2_set_block(void *data, bool blocked)
+{
+	int rfkill_id = (int)(long)data;
+	char buffer[4] = { 0x01, 0x00, rfkill_id, !blocked };
+	int ret;
+
+	ret = hp_wmi_perform_query(HPWMI_WIRELESS2_QUERY, HPWMI_WRITE,
+				   buffer, sizeof(buffer), 0);
+
+	return ret <= 0 ? ret : -EINVAL;
+}
+
+static const struct rfkill_ops hp_wmi_rfkill2_ops = {
+	.set_block = hp_wmi_rfkill2_set_block,
+};
+
+static int hp_wmi_rfkill2_refresh(void)
+{
+	struct bios_rfkill2_state state;
+	int err, i;
+
+	err = hp_wmi_perform_query(HPWMI_WIRELESS2_QUERY, HPWMI_READ, &state,
+				   zero_if_sup(state), sizeof(state));
+	if (err)
+		return err;
+
+	for (i = 0; i < rfkill2_count; i++) {
+		int num = rfkill2[i].num;
+		struct bios_rfkill2_device_state *devstate;
+
+		devstate = &state.device[num];
+
+		if (num >= state.count ||
+		    devstate->rfkill_id != rfkill2[i].id) {
+			pr_warn("power configuration of the wireless devices unexpectedly changed\n");
+			continue;
+		}
+
+		rfkill_set_states(rfkill2[i].rfkill,
+				  IS_SWBLOCKED(devstate->power),
+				  IS_HWBLOCKED(devstate->power));
+	}
+
+	return 0;
+}
+
+static ssize_t display_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	int value = hp_wmi_read_int(HPWMI_DISPLAY_QUERY);
+
+	if (value < 0)
+		return value;
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t hddtemp_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	int value = hp_wmi_read_int(HPWMI_HDDTEMP_QUERY);
+
+	if (value < 0)
+		return value;
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t als_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	int value = hp_wmi_read_int(HPWMI_ALS_QUERY);
+
+	if (value < 0)
+		return value;
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	int value = hp_wmi_get_dock_state();
+
+	if (value < 0)
+		return value;
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t tablet_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	int value = hp_wmi_get_tablet_mode();
+
+	if (value < 0)
+		return value;
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t postcode_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	/* Get the POST error code of previous boot failure. */
+	int value = hp_wmi_read_int(HPWMI_POSTCODEERROR_QUERY);
+
+	if (value < 0)
+		return value;
+	return sprintf(buf, "0x%x\n", value);
+}
+
+static ssize_t als_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	u32 tmp;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &tmp);
+	if (ret)
+		return ret;
+
+	ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_WRITE, &tmp,
+				       sizeof(tmp), 0);
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	return count;
+}
+
+static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	u32 tmp = 1;
+	bool clear;
+	int ret;
+
+	ret = kstrtobool(buf, &clear);
+	if (ret)
+		return ret;
+
+	if (clear == false)
+		return -EINVAL;
+
+	/* Clear the POST error code. It is kept until cleared. */
+	ret = hp_wmi_perform_query(HPWMI_POSTCODEERROR_QUERY, HPWMI_WRITE, &tmp,
+				       sizeof(tmp), 0);
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	return count;
+}
+
+static DEVICE_ATTR_RO(display);
+static DEVICE_ATTR_RO(hddtemp);
+static DEVICE_ATTR_RW(als);
+static DEVICE_ATTR_RO(dock);
+static DEVICE_ATTR_RO(tablet);
+static DEVICE_ATTR_RW(postcode);
+
+static struct attribute *hp_wmi_attrs[] = {
+	&dev_attr_display.attr,
+	&dev_attr_hddtemp.attr,
+	&dev_attr_als.attr,
+	&dev_attr_dock.attr,
+	&dev_attr_tablet.attr,
+	&dev_attr_postcode.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(hp_wmi);
+
+static void hp_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	u32 event_id, event_data;
+	union acpi_object *obj;
+	acpi_status status;
+	u32 *location;
+	int key_code;
+
+	status = wmi_get_event_data(value, &response);
+	if (status != AE_OK) {
+		pr_info("bad event status 0x%x\n", status);
+		return;
+	}
+
+	obj = (union acpi_object *)response.pointer;
+
+	if (!obj)
+		return;
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		pr_info("Unknown response received %d\n", obj->type);
+		kfree(obj);
+		return;
+	}
+
+	/*
+	 * Depending on ACPI version the concatenation of id and event data
+	 * inside _WED function will result in a 8 or 16 byte buffer.
+	 */
+	location = (u32 *)obj->buffer.pointer;
+	if (obj->buffer.length == 8) {
+		event_id = *location;
+		event_data = *(location + 1);
+	} else if (obj->buffer.length == 16) {
+		event_id = *location;
+		event_data = *(location + 2);
+	} else {
+		pr_info("Unknown buffer length %d\n", obj->buffer.length);
+		kfree(obj);
+		return;
+	}
+	kfree(obj);
+
+	switch (event_id) {
+	case HPWMI_DOCK_EVENT:
+		if (test_bit(SW_DOCK, hp_wmi_input_dev->swbit))
+			input_report_switch(hp_wmi_input_dev, SW_DOCK,
+					    hp_wmi_get_dock_state());
+		if (test_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit))
+			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
+					    hp_wmi_get_tablet_mode());
+		input_sync(hp_wmi_input_dev);
+		break;
+	case HPWMI_PARK_HDD:
+		break;
+	case HPWMI_SMART_ADAPTER:
+		break;
+	case HPWMI_BEZEL_BUTTON:
+	case HPWMI_OMEN_KEY:
+		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
+		if (key_code < 0)
+			break;
+
+		if (!sparse_keymap_report_event(hp_wmi_input_dev,
+						key_code, 1, true))
+			pr_info("Unknown key code - 0x%x\n", key_code);
+		break;
+	case HPWMI_WIRELESS:
+		if (rfkill2_count) {
+			hp_wmi_rfkill2_refresh();
+			break;
+		}
+
+		if (wifi_rfkill)
+			rfkill_set_states(wifi_rfkill,
+					  hp_wmi_get_sw_state(HPWMI_WIFI),
+					  hp_wmi_get_hw_state(HPWMI_WIFI));
+		if (bluetooth_rfkill)
+			rfkill_set_states(bluetooth_rfkill,
+					  hp_wmi_get_sw_state(HPWMI_BLUETOOTH),
+					  hp_wmi_get_hw_state(HPWMI_BLUETOOTH));
+		if (wwan_rfkill)
+			rfkill_set_states(wwan_rfkill,
+					  hp_wmi_get_sw_state(HPWMI_WWAN),
+					  hp_wmi_get_hw_state(HPWMI_WWAN));
+		break;
+	case HPWMI_CPU_BATTERY_THROTTLE:
+		pr_info("Unimplemented CPU throttle because of 3 Cell battery event detected\n");
+		break;
+	case HPWMI_LOCK_SWITCH:
+		break;
+	case HPWMI_LID_SWITCH:
+		break;
+	case HPWMI_SCREEN_ROTATION:
+		break;
+	case HPWMI_COOLSENSE_SYSTEM_MOBILE:
+		break;
+	case HPWMI_COOLSENSE_SYSTEM_HOT:
+		break;
+	case HPWMI_PROXIMITY_SENSOR:
+		break;
+	case HPWMI_BACKLIT_KB_BRIGHTNESS:
+		break;
+	case HPWMI_PEAKSHIFT_PERIOD:
+		break;
+	case HPWMI_BATTERY_CHARGE_PERIOD:
+		break;
+	case HPWMI_SANITIZATION_MODE:
+		break;
+	case HPWMI_SMART_EXPERIENCE_APP:
+		break;
+	default:
+		pr_info("Unknown event_id - %d - 0x%x\n", event_id, event_data);
+		break;
+	}
+}
+
+static int __init hp_wmi_input_setup(void)
+{
+	acpi_status status;
+	int err, val;
+
+	hp_wmi_input_dev = input_allocate_device();
+	if (!hp_wmi_input_dev)
+		return -ENOMEM;
+
+	hp_wmi_input_dev->name = "HP WMI hotkeys";
+	hp_wmi_input_dev->phys = "wmi/input0";
+	hp_wmi_input_dev->id.bustype = BUS_HOST;
+
+	__set_bit(EV_SW, hp_wmi_input_dev->evbit);
+
+	/* Dock */
+	val = hp_wmi_get_dock_state();
+	if (!(val < 0)) {
+		__set_bit(SW_DOCK, hp_wmi_input_dev->swbit);
+		input_report_switch(hp_wmi_input_dev, SW_DOCK, val);
+	}
+
+	/* Tablet mode */
+	val = hp_wmi_get_tablet_mode();
+	if (!(val < 0)) {
+		__set_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit);
+		input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE, val);
+	}
+
+	err = sparse_keymap_setup(hp_wmi_input_dev, hp_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
+
+	/* Set initial hardware state */
+	input_sync(hp_wmi_input_dev);
+
+	if (!hp_wmi_bios_2009_later() && hp_wmi_bios_2008_later())
+		hp_wmi_enable_hotkeys();
+
+	status = wmi_install_notify_handler(HPWMI_EVENT_GUID, hp_wmi_notify, NULL);
+	if (ACPI_FAILURE(status)) {
+		err = -EIO;
+		goto err_free_dev;
+	}
+
+	err = input_register_device(hp_wmi_input_dev);
+	if (err)
+		goto err_uninstall_notifier;
+
+	return 0;
+
+ err_uninstall_notifier:
+	wmi_remove_notify_handler(HPWMI_EVENT_GUID);
+ err_free_dev:
+	input_free_device(hp_wmi_input_dev);
+	return err;
+}
+
+static void hp_wmi_input_destroy(void)
+{
+	wmi_remove_notify_handler(HPWMI_EVENT_GUID);
+	input_unregister_device(hp_wmi_input_dev);
+}
+
+static int __init hp_wmi_rfkill_setup(struct platform_device *device)
+{
+	int err, wireless;
+
+	wireless = hp_wmi_read_int(HPWMI_WIRELESS_QUERY);
+	if (wireless < 0)
+		return wireless;
+
+	err = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, HPWMI_WRITE, &wireless,
+				   sizeof(wireless), 0);
+	if (err)
+		return err;
+
+	if (wireless & 0x1) {
+		wifi_rfkill = rfkill_alloc("hp-wifi", &device->dev,
+					   RFKILL_TYPE_WLAN,
+					   &hp_wmi_rfkill_ops,
+					   (void *) HPWMI_WIFI);
+		if (!wifi_rfkill)
+			return -ENOMEM;
+		rfkill_init_sw_state(wifi_rfkill,
+				     hp_wmi_get_sw_state(HPWMI_WIFI));
+		rfkill_set_hw_state(wifi_rfkill,
+				    hp_wmi_get_hw_state(HPWMI_WIFI));
+		err = rfkill_register(wifi_rfkill);
+		if (err)
+			goto register_wifi_error;
+	}
+
+	if (wireless & 0x2) {
+		bluetooth_rfkill = rfkill_alloc("hp-bluetooth", &device->dev,
+						RFKILL_TYPE_BLUETOOTH,
+						&hp_wmi_rfkill_ops,
+						(void *) HPWMI_BLUETOOTH);
+		if (!bluetooth_rfkill) {
+			err = -ENOMEM;
+			goto register_bluetooth_error;
+		}
+		rfkill_init_sw_state(bluetooth_rfkill,
+				     hp_wmi_get_sw_state(HPWMI_BLUETOOTH));
+		rfkill_set_hw_state(bluetooth_rfkill,
+				    hp_wmi_get_hw_state(HPWMI_BLUETOOTH));
+		err = rfkill_register(bluetooth_rfkill);
+		if (err)
+			goto register_bluetooth_error;
+	}
+
+	if (wireless & 0x4) {
+		wwan_rfkill = rfkill_alloc("hp-wwan", &device->dev,
+					   RFKILL_TYPE_WWAN,
+					   &hp_wmi_rfkill_ops,
+					   (void *) HPWMI_WWAN);
+		if (!wwan_rfkill) {
+			err = -ENOMEM;
+			goto register_wwan_error;
+		}
+		rfkill_init_sw_state(wwan_rfkill,
+				     hp_wmi_get_sw_state(HPWMI_WWAN));
+		rfkill_set_hw_state(wwan_rfkill,
+				    hp_wmi_get_hw_state(HPWMI_WWAN));
+		err = rfkill_register(wwan_rfkill);
+		if (err)
+			goto register_wwan_error;
+	}
+
+	return 0;
+
+register_wwan_error:
+	rfkill_destroy(wwan_rfkill);
+	wwan_rfkill = NULL;
+	if (bluetooth_rfkill)
+		rfkill_unregister(bluetooth_rfkill);
+register_bluetooth_error:
+	rfkill_destroy(bluetooth_rfkill);
+	bluetooth_rfkill = NULL;
+	if (wifi_rfkill)
+		rfkill_unregister(wifi_rfkill);
+register_wifi_error:
+	rfkill_destroy(wifi_rfkill);
+	wifi_rfkill = NULL;
+	return err;
+}
+
+static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
+{
+	struct bios_rfkill2_state state;
+	int err, i;
+
+	err = hp_wmi_perform_query(HPWMI_WIRELESS2_QUERY, HPWMI_READ, &state,
+				   zero_if_sup(state), sizeof(state));
+	if (err)
+		return err < 0 ? err : -EINVAL;
+
+	if (state.count > HPWMI_MAX_RFKILL2_DEVICES) {
+		pr_warn("unable to parse 0x1b query output\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < state.count; i++) {
+		struct rfkill *rfkill;
+		enum rfkill_type type;
+		char *name;
+
+		switch (state.device[i].radio_type) {
+		case HPWMI_WIFI:
+			type = RFKILL_TYPE_WLAN;
+			name = "hp-wifi";
+			break;
+		case HPWMI_BLUETOOTH:
+			type = RFKILL_TYPE_BLUETOOTH;
+			name = "hp-bluetooth";
+			break;
+		case HPWMI_WWAN:
+			type = RFKILL_TYPE_WWAN;
+			name = "hp-wwan";
+			break;
+		case HPWMI_GPS:
+			type = RFKILL_TYPE_GPS;
+			name = "hp-gps";
+			break;
+		default:
+			pr_warn("unknown device type 0x%x\n",
+				state.device[i].radio_type);
+			continue;
+		}
+
+		if (!state.device[i].vendor_id) {
+			pr_warn("zero device %d while %d reported\n",
+				i, state.count);
+			continue;
+		}
+
+		rfkill = rfkill_alloc(name, &device->dev, type,
+				      &hp_wmi_rfkill2_ops, (void *)(long)i);
+		if (!rfkill) {
+			err = -ENOMEM;
+			goto fail;
+		}
+
+		rfkill2[rfkill2_count].id = state.device[i].rfkill_id;
+		rfkill2[rfkill2_count].num = i;
+		rfkill2[rfkill2_count].rfkill = rfkill;
+
+		rfkill_init_sw_state(rfkill,
+				     IS_SWBLOCKED(state.device[i].power));
+		rfkill_set_hw_state(rfkill,
+				    IS_HWBLOCKED(state.device[i].power));
+
+		if (!(state.device[i].power & HPWMI_POWER_BIOS))
+			pr_info("device %s blocked by BIOS\n", name);
+
+		err = rfkill_register(rfkill);
+		if (err) {
+			rfkill_destroy(rfkill);
+			goto fail;
+		}
+
+		rfkill2_count++;
+	}
+
+	return 0;
+fail:
+	for (; rfkill2_count > 0; rfkill2_count--) {
+		rfkill_unregister(rfkill2[rfkill2_count - 1].rfkill);
+		rfkill_destroy(rfkill2[rfkill2_count - 1].rfkill);
+	}
+	return err;
+}
+
+static int platform_profile_omen_get(struct platform_profile_handler *pprof,
+				     enum platform_profile_option *profile)
+{
+	int tp;
+
+	tp = omen_thermal_profile_get();
+	if (tp < 0)
+		return tp;
+
+	switch (tp) {
+	case HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE:
+	case HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case HP_OMEN_V0_THERMAL_PROFILE_DEFAULT:
+	case HP_OMEN_V1_THERMAL_PROFILE_DEFAULT:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case HP_OMEN_V0_THERMAL_PROFILE_COOL:
+	case HP_OMEN_V1_THERMAL_PROFILE_COOL:
+		*profile = PLATFORM_PROFILE_COOL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int platform_profile_omen_set(struct platform_profile_handler *pprof,
+				     enum platform_profile_option profile)
+{
+	int err, tp, tp_version;
+
+	tp_version = omen_get_thermal_policy_version();
+
+	if (tp_version < 0 || tp_version > 1)
+		return -EOPNOTSUPP;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		if (tp_version == 0)
+			tp = HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE;
+		else
+			tp = HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		if (tp_version == 0)
+			tp = HP_OMEN_V0_THERMAL_PROFILE_DEFAULT;
+		else
+			tp = HP_OMEN_V1_THERMAL_PROFILE_DEFAULT;
+		break;
+	case PLATFORM_PROFILE_COOL:
+		if (tp_version == 0)
+			tp = HP_OMEN_V0_THERMAL_PROFILE_COOL;
+		else
+			tp = HP_OMEN_V1_THERMAL_PROFILE_COOL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	err = omen_thermal_profile_set(tp);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int thermal_profile_get(void)
+{
+	return hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
+}
+
+static int thermal_profile_set(int thermal_profile)
+{
+	return hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE, &thermal_profile,
+							   sizeof(thermal_profile), 0);
+}
+
+static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
+					enum platform_profile_option *profile)
+{
+	int tp;
+
+	tp = thermal_profile_get();
+	if (tp < 0)
+		return tp;
+
+	switch (tp) {
+	case HP_THERMAL_PROFILE_PERFORMANCE:
+		*profile =  PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case HP_THERMAL_PROFILE_DEFAULT:
+		*profile =  PLATFORM_PROFILE_BALANCED;
+		break;
+	case HP_THERMAL_PROFILE_COOL:
+		*profile =  PLATFORM_PROFILE_COOL;
+		break;
+	case HP_THERMAL_PROFILE_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
+					enum platform_profile_option profile)
+{
+	int err, tp;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		tp =  HP_THERMAL_PROFILE_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		tp =  HP_THERMAL_PROFILE_DEFAULT;
+		break;
+	case PLATFORM_PROFILE_COOL:
+		tp =  HP_THERMAL_PROFILE_COOL;
+		break;
+	case PLATFORM_PROFILE_QUIET:
+		tp = HP_THERMAL_PROFILE_QUIET;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	err = thermal_profile_set(tp);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int thermal_profile_setup(void)
+{
+	int err, tp;
+
+	if (is_omen_thermal_profile()) {
+		tp = omen_thermal_profile_get();
+		if (tp < 0)
+			return tp;
+
+		/*
+		 * call thermal profile write command to ensure that the
+		 * firmware correctly sets the OEM variables
+		 */
+
+		err = omen_thermal_profile_set(tp);
+		if (err < 0)
+			return err;
+
+		platform_profile_handler.profile_get = platform_profile_omen_get;
+		platform_profile_handler.profile_set = platform_profile_omen_set;
+	} else {
+		tp = thermal_profile_get();
+
+		if (tp < 0)
+			return tp;
+
+		/*
+		 * call thermal profile write command to ensure that the
+		 * firmware correctly sets the OEM variables for the DPTF
+		 */
+		err = thermal_profile_set(tp);
+		if (err)
+			return err;
+
+		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
+		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
+
+		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
+	}
+
+	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
+
+	err = platform_profile_register(&platform_profile_handler);
+	if (err)
+		return err;
+
+	platform_profile_support = true;
+
+	return 0;
+}
+
+static int hp_wmi_hwmon_init(void);
+
+static int __init hp_wmi_bios_setup(struct platform_device *device)
+{
+	int err;
+	/* clear detected rfkill devices */
+	wifi_rfkill = NULL;
+	bluetooth_rfkill = NULL;
+	wwan_rfkill = NULL;
+	rfkill2_count = 0;
+
+	/*
+	 * In pre-2009 BIOS, command 1Bh return 0x4 to indicate that
+	 * BIOS no longer controls the power for the wireless
+	 * devices. All features supported by this command will no
+	 * longer be supported.
+	 */
+	if (!hp_wmi_bios_2009_later()) {
+		if (hp_wmi_rfkill_setup(device))
+			hp_wmi_rfkill2_setup(device);
+	}
+
+	err = hp_wmi_hwmon_init();
+
+	if (err < 0)
+		return err;
+
+	thermal_profile_setup();
+
+	return 0;
+}
+
+static int __exit hp_wmi_bios_remove(struct platform_device *device)
+{
+	int i;
+
+	for (i = 0; i < rfkill2_count; i++) {
+		rfkill_unregister(rfkill2[i].rfkill);
+		rfkill_destroy(rfkill2[i].rfkill);
+	}
+
+	if (wifi_rfkill) {
+		rfkill_unregister(wifi_rfkill);
+		rfkill_destroy(wifi_rfkill);
+	}
+	if (bluetooth_rfkill) {
+		rfkill_unregister(bluetooth_rfkill);
+		rfkill_destroy(bluetooth_rfkill);
+	}
+	if (wwan_rfkill) {
+		rfkill_unregister(wwan_rfkill);
+		rfkill_destroy(wwan_rfkill);
+	}
+
+	if (platform_profile_support)
+		platform_profile_remove();
+
+	return 0;
+}
+
+static int hp_wmi_resume_handler(struct device *device)
+{
+	/*
+	 * Hardware state may have changed while suspended, so trigger
+	 * input events for the current state. As this is a switch,
+	 * the input layer will only actually pass it on if the state
+	 * changed.
+	 */
+	if (hp_wmi_input_dev) {
+		if (test_bit(SW_DOCK, hp_wmi_input_dev->swbit))
+			input_report_switch(hp_wmi_input_dev, SW_DOCK,
+					    hp_wmi_get_dock_state());
+		if (test_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit))
+			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
+					    hp_wmi_get_tablet_mode());
+		input_sync(hp_wmi_input_dev);
+	}
+
+	if (rfkill2_count)
+		hp_wmi_rfkill2_refresh();
+
+	if (wifi_rfkill)
+		rfkill_set_states(wifi_rfkill,
+				  hp_wmi_get_sw_state(HPWMI_WIFI),
+				  hp_wmi_get_hw_state(HPWMI_WIFI));
+	if (bluetooth_rfkill)
+		rfkill_set_states(bluetooth_rfkill,
+				  hp_wmi_get_sw_state(HPWMI_BLUETOOTH),
+				  hp_wmi_get_hw_state(HPWMI_BLUETOOTH));
+	if (wwan_rfkill)
+		rfkill_set_states(wwan_rfkill,
+				  hp_wmi_get_sw_state(HPWMI_WWAN),
+				  hp_wmi_get_hw_state(HPWMI_WWAN));
+
+	return 0;
+}
+
+static const struct dev_pm_ops hp_wmi_pm_ops = {
+	.resume  = hp_wmi_resume_handler,
+	.restore  = hp_wmi_resume_handler,
+};
+
+static struct platform_driver hp_wmi_driver = {
+	.driver = {
+		.name = "hp-wmi",
+		.pm = &hp_wmi_pm_ops,
+		.dev_groups = hp_wmi_groups,
+	},
+	.remove = __exit_p(hp_wmi_bios_remove),
+};
+
+static umode_t hp_wmi_hwmon_is_visible(const void *data,
+				       enum hwmon_sensor_types type,
+				       u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_pwm:
+		return 0644;
+	case hwmon_fan:
+		if (hp_wmi_get_fan_speed(channel) >= 0)
+			return 0444;
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int hp_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long *val)
+{
+	int ret;
+
+	switch (type) {
+	case hwmon_fan:
+		ret = hp_wmi_get_fan_speed(channel);
+
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return 0;
+	case hwmon_pwm:
+		switch (hp_wmi_fan_speed_max_get()) {
+		case 0:
+			/* 0 is automatic fan, which is 2 for hwmon */
+			*val = 2;
+			return 0;
+		case 1:
+			/* 1 is max fan, which is 0
+			 * (no fan speed control) for hwmon
+			 */
+			*val = 0;
+			return 0;
+		default:
+			/* shouldn't happen */
+			return -ENODATA;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hp_wmi_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_pwm:
+		switch (val) {
+		case 0:
+			/* 0 is no fan speed control (max), which is 1 for us */
+			return hp_wmi_fan_speed_max_set(1);
+		case 2:
+			/* 2 is automatic speed control, which is 0 for us */
+			return hp_wmi_fan_speed_max_set(0);
+		default:
+			/* we don't support manual fan speed control */
+			return -EINVAL;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_channel_info *info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT, HWMON_F_INPUT),
+	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_ENABLE),
+	NULL
+};
+
+static const struct hwmon_ops ops = {
+	.is_visible = hp_wmi_hwmon_is_visible,
+	.read = hp_wmi_hwmon_read,
+	.write = hp_wmi_hwmon_write,
+};
+
+static const struct hwmon_chip_info chip_info = {
+	.ops = &ops,
+	.info = info,
+};
+
+static int hp_wmi_hwmon_init(void)
+{
+	struct device *dev = &hp_wmi_platform_dev->dev;
+	struct device *hwmon;
+
+	hwmon = devm_hwmon_device_register_with_info(dev, "hp", &hp_wmi_driver,
+						     &chip_info, NULL);
+
+	if (IS_ERR(hwmon)) {
+		dev_err(dev, "Could not register hp hwmon device\n");
+		return PTR_ERR(hwmon);
+	}
+
+	return 0;
+}
+
+static int __init hp_wmi_init(void)
+{
+	int event_capable = wmi_has_guid(HPWMI_EVENT_GUID);
+	int bios_capable = wmi_has_guid(HPWMI_BIOS_GUID);
+	int err, tmp = 0;
+
+	if (!bios_capable && !event_capable)
+		return -ENODEV;
+
+	if (hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, HPWMI_READ, &tmp,
+				 sizeof(tmp), sizeof(tmp)) == HPWMI_RET_INVALID_PARAMETERS)
+		zero_insize_support = true;
+
+	if (event_capable) {
+		err = hp_wmi_input_setup();
+		if (err)
+			return err;
+	}
+
+	if (bios_capable) {
+		hp_wmi_platform_dev =
+			platform_device_register_simple("hp-wmi", PLATFORM_DEVID_NONE, NULL, 0);
+		if (IS_ERR(hp_wmi_platform_dev)) {
+			err = PTR_ERR(hp_wmi_platform_dev);
+			goto err_destroy_input;
+		}
+
+		err = platform_driver_probe(&hp_wmi_driver, hp_wmi_bios_setup);
+		if (err)
+			goto err_unregister_device;
+	}
+
+	return 0;
+
+err_unregister_device:
+	platform_device_unregister(hp_wmi_platform_dev);
+err_destroy_input:
+	if (event_capable)
+		hp_wmi_input_destroy();
+
+	return err;
+}
+module_init(hp_wmi_init);
+
+static void __exit hp_wmi_exit(void)
+{
+	if (wmi_has_guid(HPWMI_EVENT_GUID))
+		hp_wmi_input_destroy();
+
+	if (hp_wmi_platform_dev) {
+		platform_device_unregister(hp_wmi_platform_dev);
+		platform_driver_unregister(&hp_wmi_driver);
+	}
+}
+module_exit(hp_wmi_exit);
diff --git a/drivers/platform/x86/hp/hp_accel.c b/drivers/platform/x86/hp/hp_accel.c
new file mode 100644
index 000000000000..6477591747cf
--- /dev/null
+++ b/drivers/platform/x86/hp/hp_accel.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  hp_accel.c - Interface between LIS3LV02DL driver and HP ACPI BIOS
+ *
+ *  Copyright (C) 2007-2008 Yan Burman
+ *  Copyright (C) 2008 Eric Piel
+ *  Copyright (C) 2008-2009 Pavel Machek
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/dmi.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/freezer.h>
+#include <linux/uaccess.h>
+#include <linux/leds.h>
+#include <linux/atomic.h>
+#include <linux/acpi.h>
+#include <linux/i8042.h>
+#include <linux/serio.h>
+#include "../../../misc/lis3lv02d/lis3lv02d.h"
+
+/* Delayed LEDs infrastructure ------------------------------------ */
+
+/* Special LED class that can defer work */
+struct delayed_led_classdev {
+	struct led_classdev led_classdev;
+	struct work_struct work;
+	enum led_brightness new_brightness;
+
+	unsigned int led;		/* For driver */
+	void (*set_brightness)(struct delayed_led_classdev *data, enum led_brightness value);
+};
+
+static inline void delayed_set_status_worker(struct work_struct *work)
+{
+	struct delayed_led_classdev *data =
+			container_of(work, struct delayed_led_classdev, work);
+
+	data->set_brightness(data, data->new_brightness);
+}
+
+static inline void delayed_sysfs_set(struct led_classdev *led_cdev,
+			      enum led_brightness brightness)
+{
+	struct delayed_led_classdev *data = container_of(led_cdev,
+			     struct delayed_led_classdev, led_classdev);
+	data->new_brightness = brightness;
+	schedule_work(&data->work);
+}
+
+/* HP-specific accelerometer driver ------------------------------------ */
+
+/* e0 25, e0 26, e0 27, e0 28 are scan codes that the accelerometer with acpi id
+ * HPQ6000 sends through the keyboard bus */
+#define ACCEL_1 0x25
+#define ACCEL_2 0x26
+#define ACCEL_3 0x27
+#define ACCEL_4 0x28
+
+/* For automatic insertion of the module */
+static const struct acpi_device_id lis3lv02d_device_ids[] = {
+	{"HPQ0004", 0}, /* HP Mobile Data Protection System PNP */
+	{"HPQ6000", 0}, /* HP Mobile Data Protection System PNP */
+	{"HPQ6007", 0}, /* HP Mobile Data Protection System PNP */
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, lis3lv02d_device_ids);
+
+/**
+ * lis3lv02d_acpi_init - initialize the device for ACPI
+ * @lis3: pointer to the device struct
+ *
+ * Returns 0 on success.
+ */
+static int lis3lv02d_acpi_init(struct lis3lv02d *lis3)
+{
+	return 0;
+}
+
+/**
+ * lis3lv02d_acpi_read - ACPI ALRD method: read a register
+ * @lis3: pointer to the device struct
+ * @reg:    the register to read
+ * @ret:    result of the operation
+ *
+ * Returns 0 on success.
+ */
+static int lis3lv02d_acpi_read(struct lis3lv02d *lis3, int reg, u8 *ret)
+{
+	struct acpi_device *dev = lis3->bus_priv;
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+	unsigned long long lret;
+	acpi_status status;
+
+	arg0.integer.value = reg;
+
+	status = acpi_evaluate_integer(dev->handle, "ALRD", &args, &lret);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+	*ret = lret;
+	return 0;
+}
+
+/**
+ * lis3lv02d_acpi_write - ACPI ALWR method: write to a register
+ * @lis3: pointer to the device struct
+ * @reg:    the register to write to
+ * @val:    the value to write
+ *
+ * Returns 0 on success.
+ */
+static int lis3lv02d_acpi_write(struct lis3lv02d *lis3, int reg, u8 val)
+{
+	struct acpi_device *dev = lis3->bus_priv;
+	unsigned long long ret; /* Not used when writting */
+	union acpi_object in_obj[2];
+	struct acpi_object_list args = { 2, in_obj };
+
+	in_obj[0].type          = ACPI_TYPE_INTEGER;
+	in_obj[0].integer.value = reg;
+	in_obj[1].type          = ACPI_TYPE_INTEGER;
+	in_obj[1].integer.value = val;
+
+	if (acpi_evaluate_integer(dev->handle, "ALWR", &args, &ret) != AE_OK)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int lis3lv02d_dmi_matched(const struct dmi_system_id *dmi)
+{
+	lis3_dev.ac = *((union axis_conversion *)dmi->driver_data);
+	pr_info("hardware type %s found\n", dmi->ident);
+
+	return 1;
+}
+
+/* Represents, for each axis seen by userspace, the corresponding hw axis (+1).
+ * If the value is negative, the opposite of the hw value is used. */
+#define DEFINE_CONV(name, x, y, z)			      \
+	static union axis_conversion lis3lv02d_axis_##name = \
+		{ .as_array = { x, y, z } }
+DEFINE_CONV(normal, 1, 2, 3);
+DEFINE_CONV(y_inverted, 1, -2, 3);
+DEFINE_CONV(x_inverted, -1, 2, 3);
+DEFINE_CONV(x_inverted_usd, -1, 2, -3);
+DEFINE_CONV(z_inverted, 1, 2, -3);
+DEFINE_CONV(xy_swap, 2, 1, 3);
+DEFINE_CONV(xy_rotated_left, -2, 1, 3);
+DEFINE_CONV(xy_rotated_left_usd, -2, 1, -3);
+DEFINE_CONV(xy_swap_inverted, -2, -1, 3);
+DEFINE_CONV(xy_rotated_right, 2, -1, 3);
+DEFINE_CONV(xy_swap_yz_inverted, 2, -1, -3);
+
+#define AXIS_DMI_MATCH(_ident, _name, _axis) {		\
+	.ident = _ident,				\
+	.callback = lis3lv02d_dmi_matched,		\
+	.matches = {					\
+		DMI_MATCH(DMI_PRODUCT_NAME, _name)	\
+	},						\
+	.driver_data = &lis3lv02d_axis_##_axis		\
+}
+
+#define AXIS_DMI_MATCH2(_ident, _class1, _name1,	\
+				_class2, _name2,	\
+				_axis) {		\
+	.ident = _ident,				\
+	.callback = lis3lv02d_dmi_matched,		\
+	.matches = {					\
+		DMI_MATCH(DMI_##_class1, _name1),	\
+		DMI_MATCH(DMI_##_class2, _name2),	\
+	},						\
+	.driver_data = &lis3lv02d_axis_##_axis		\
+}
+static const struct dmi_system_id lis3lv02d_dmi_ids[] = {
+	/* product names are truncated to match all kinds of a same model */
+	AXIS_DMI_MATCH("NC64x0", "HP Compaq nc64", x_inverted),
+	AXIS_DMI_MATCH("NC84x0", "HP Compaq nc84", z_inverted),
+	AXIS_DMI_MATCH("NX9420", "HP Compaq nx9420", x_inverted),
+	AXIS_DMI_MATCH("NW9440", "HP Compaq nw9440", x_inverted),
+	AXIS_DMI_MATCH("NC2510", "HP Compaq 2510", y_inverted),
+	AXIS_DMI_MATCH("NC2710", "HP Compaq 2710", xy_swap),
+	AXIS_DMI_MATCH("NC8510", "HP Compaq 8510", xy_swap_inverted),
+	AXIS_DMI_MATCH("HP2133", "HP 2133", xy_rotated_left),
+	AXIS_DMI_MATCH("HP2140", "HP 2140", xy_swap_inverted),
+	AXIS_DMI_MATCH("NC653x", "HP Compaq 653", xy_rotated_left_usd),
+	AXIS_DMI_MATCH("NC6730b", "HP Compaq 6730b", xy_rotated_left_usd),
+	AXIS_DMI_MATCH("NC6730s", "HP Compaq 6730s", xy_swap),
+	AXIS_DMI_MATCH("NC651xx", "HP Compaq 651", xy_rotated_right),
+	AXIS_DMI_MATCH("NC6710x", "HP Compaq 6710", xy_swap_yz_inverted),
+	AXIS_DMI_MATCH("NC6715x", "HP Compaq 6715", y_inverted),
+	AXIS_DMI_MATCH("NC693xx", "HP EliteBook 693", xy_rotated_right),
+	AXIS_DMI_MATCH("NC693xx", "HP EliteBook 853", xy_swap),
+	AXIS_DMI_MATCH("NC854xx", "HP EliteBook 854", y_inverted),
+	AXIS_DMI_MATCH("NC273xx", "HP EliteBook 273", y_inverted),
+	/* Intel-based HP Pavilion dv5 */
+	AXIS_DMI_MATCH2("HPDV5_I",
+			PRODUCT_NAME, "HP Pavilion dv5",
+			BOARD_NAME, "3603",
+			x_inverted),
+	/* AMD-based HP Pavilion dv5 */
+	AXIS_DMI_MATCH2("HPDV5_A",
+			PRODUCT_NAME, "HP Pavilion dv5",
+			BOARD_NAME, "3600",
+			y_inverted),
+	AXIS_DMI_MATCH("DV7", "HP Pavilion dv7", x_inverted),
+	AXIS_DMI_MATCH("HP8710", "HP Compaq 8710", y_inverted),
+	AXIS_DMI_MATCH("HDX18", "HP HDX 18", x_inverted),
+	AXIS_DMI_MATCH("HPB432x", "HP ProBook 432", xy_rotated_left),
+	AXIS_DMI_MATCH("HPB440G3", "HP ProBook 440 G3", x_inverted_usd),
+	AXIS_DMI_MATCH("HPB440G4", "HP ProBook 440 G4", x_inverted),
+	AXIS_DMI_MATCH("HPB442x", "HP ProBook 442", xy_rotated_left),
+	AXIS_DMI_MATCH("HPB450G0", "HP ProBook 450 G0", x_inverted),
+	AXIS_DMI_MATCH("HPB452x", "HP ProBook 452", y_inverted),
+	AXIS_DMI_MATCH("HPB522x", "HP ProBook 522", xy_swap),
+	AXIS_DMI_MATCH("HPB532x", "HP ProBook 532", y_inverted),
+	AXIS_DMI_MATCH("HPB655x", "HP ProBook 655", xy_swap_inverted),
+	AXIS_DMI_MATCH("Mini510x", "HP Mini 510", xy_rotated_left_usd),
+	AXIS_DMI_MATCH("HPB63xx", "HP ProBook 63", xy_swap),
+	AXIS_DMI_MATCH("HPB64xx", "HP ProBook 64", xy_swap),
+	AXIS_DMI_MATCH("HPB64xx", "HP EliteBook 84", xy_swap),
+	AXIS_DMI_MATCH("HPB65xx", "HP ProBook 65", x_inverted),
+	AXIS_DMI_MATCH("HPZBook15", "HP ZBook 15", x_inverted),
+	AXIS_DMI_MATCH("HPZBook17G5", "HP ZBook 17 G5", x_inverted),
+	AXIS_DMI_MATCH("HPZBook17", "HP ZBook 17", xy_swap_yz_inverted),
+	{ NULL, }
+/* Laptop models without axis info (yet):
+ * "NC6910" "HP Compaq 6910"
+ * "NC2400" "HP Compaq nc2400"
+ * "NX74x0" "HP Compaq nx74"
+ * "NX6325" "HP Compaq nx6325"
+ * "NC4400" "HP Compaq nc4400"
+ */
+};
+
+static void hpled_set(struct delayed_led_classdev *led_cdev, enum led_brightness value)
+{
+	struct acpi_device *dev = lis3_dev.bus_priv;
+	unsigned long long ret; /* Not used when writing */
+	union acpi_object in_obj[1];
+	struct acpi_object_list args = { 1, in_obj };
+
+	in_obj[0].type          = ACPI_TYPE_INTEGER;
+	in_obj[0].integer.value = !!value;
+
+	acpi_evaluate_integer(dev->handle, "ALED", &args, &ret);
+}
+
+static struct delayed_led_classdev hpled_led = {
+	.led_classdev = {
+		.name			= "hp::hddprotect",
+		.default_trigger	= "none",
+		.brightness_set		= delayed_sysfs_set,
+		.flags                  = LED_CORE_SUSPENDRESUME,
+	},
+	.set_brightness = hpled_set,
+};
+
+static bool hp_accel_i8042_filter(unsigned char data, unsigned char str,
+				  struct serio *port)
+{
+	static bool extended;
+
+	if (str & I8042_STR_AUXDATA)
+		return false;
+
+	if (data == 0xe0) {
+		extended = true;
+		return true;
+	} else if (unlikely(extended)) {
+		extended = false;
+
+		switch (data) {
+		case ACCEL_1:
+		case ACCEL_2:
+		case ACCEL_3:
+		case ACCEL_4:
+			return true;
+		default:
+			serio_interrupt(port, 0xe0, 0);
+			return false;
+		}
+	}
+
+	return false;
+}
+
+static int lis3lv02d_probe(struct platform_device *device)
+{
+	int ret;
+
+	lis3_dev.bus_priv = ACPI_COMPANION(&device->dev);
+	lis3_dev.init = lis3lv02d_acpi_init;
+	lis3_dev.read = lis3lv02d_acpi_read;
+	lis3_dev.write = lis3lv02d_acpi_write;
+
+	/* obtain IRQ number of our device from ACPI */
+	ret = platform_get_irq_optional(device, 0);
+	if (ret > 0)
+		lis3_dev.irq = ret;
+
+	/* If possible use a "standard" axes order */
+	if (lis3_dev.ac.x && lis3_dev.ac.y && lis3_dev.ac.z) {
+		pr_info("Using custom axes %d,%d,%d\n",
+			lis3_dev.ac.x, lis3_dev.ac.y, lis3_dev.ac.z);
+	} else if (dmi_check_system(lis3lv02d_dmi_ids) == 0) {
+		pr_info("laptop model unknown, using default axes configuration\n");
+		lis3_dev.ac = lis3lv02d_axis_normal;
+	}
+
+	/* call the core layer do its init */
+	ret = lis3lv02d_init_device(&lis3_dev);
+	if (ret)
+		return ret;
+
+	/* filter to remove HPQ6000 accelerometer data
+	 * from keyboard bus stream */
+	if (strstr(dev_name(&device->dev), "HPQ6000"))
+		i8042_install_filter(hp_accel_i8042_filter);
+
+	INIT_WORK(&hpled_led.work, delayed_set_status_worker);
+	ret = led_classdev_register(NULL, &hpled_led.led_classdev);
+	if (ret) {
+		i8042_remove_filter(hp_accel_i8042_filter);
+		lis3lv02d_joystick_disable(&lis3_dev);
+		lis3lv02d_poweroff(&lis3_dev);
+		flush_work(&hpled_led.work);
+		lis3lv02d_remove_fs(&lis3_dev);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int lis3lv02d_remove(struct platform_device *device)
+{
+	i8042_remove_filter(hp_accel_i8042_filter);
+	lis3lv02d_joystick_disable(&lis3_dev);
+	lis3lv02d_poweroff(&lis3_dev);
+
+	led_classdev_unregister(&hpled_led.led_classdev);
+	flush_work(&hpled_led.work);
+
+	lis3lv02d_remove_fs(&lis3_dev);
+	return 0;
+}
+
+static int __maybe_unused lis3lv02d_suspend(struct device *dev)
+{
+	/* make sure the device is off when we suspend */
+	lis3lv02d_poweroff(&lis3_dev);
+	return 0;
+}
+
+static int __maybe_unused lis3lv02d_resume(struct device *dev)
+{
+	lis3lv02d_poweron(&lis3_dev);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(hp_accel_pm, lis3lv02d_suspend, lis3lv02d_resume);
+
+/* For the HP MDPS aka 3D Driveguard */
+static struct platform_driver lis3lv02d_driver = {
+	.probe	= lis3lv02d_probe,
+	.remove	= lis3lv02d_remove,
+	.driver	= {
+		.name	= "hp_accel",
+		.pm	= &hp_accel_pm,
+		.acpi_match_table = lis3lv02d_device_ids,
+	},
+};
+module_platform_driver(lis3lv02d_driver);
+
+MODULE_DESCRIPTION("Glue between LIS3LV02Dx and HP ACPI BIOS and support for disk protection LED.");
+MODULE_AUTHOR("Yan Burman, Eric Piel, Pavel Machek");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/hp/tc1100-wmi.c b/drivers/platform/x86/hp/tc1100-wmi.c
new file mode 100644
index 000000000000..ded26213c420
--- /dev/null
+++ b/drivers/platform/x86/hp/tc1100-wmi.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HP Compaq TC1100 Tablet WMI Extras Driver
+ *
+ *  Copyright (C) 2007 Carlos Corbacho <carlos@strangeworlds.co.uk>
+ *  Copyright (C) 2004 Jamey Hicks <jamey.hicks@hp.com>
+ *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
+ *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+
+#define GUID "C364AC71-36DB-495A-8494-B439D472A505"
+
+#define TC1100_INSTANCE_WIRELESS		1
+#define TC1100_INSTANCE_JOGDIAL		2
+
+MODULE_AUTHOR("Jamey Hicks, Carlos Corbacho");
+MODULE_DESCRIPTION("HP Compaq TC1100 Tablet WMI Extras");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("wmi:C364AC71-36DB-495A-8494-B439D472A505");
+
+static struct platform_device *tc1100_device;
+
+struct tc1100_data {
+	u32 wireless;
+	u32 jogdial;
+};
+
+#ifdef CONFIG_PM
+static struct tc1100_data suspend_data;
+#endif
+
+/* --------------------------------------------------------------------------
+				Device Management
+   -------------------------------------------------------------------------- */
+
+static int get_state(u32 *out, u8 instance)
+{
+	u32 tmp;
+	acpi_status status;
+	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+
+	if (!out)
+		return -EINVAL;
+
+	if (instance > 2)
+		return -ENODEV;
+
+	status = wmi_query_block(GUID, instance, &result);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	obj = (union acpi_object *) result.pointer;
+	if (obj && obj->type == ACPI_TYPE_INTEGER) {
+		tmp = obj->integer.value;
+	} else {
+		tmp = 0;
+	}
+
+	if (result.length > 0)
+		kfree(result.pointer);
+
+	switch (instance) {
+	case TC1100_INSTANCE_WIRELESS:
+		*out = (tmp == 3) ? 1 : 0;
+		return 0;
+	case TC1100_INSTANCE_JOGDIAL:
+		*out = (tmp == 1) ? 0 : 1;
+		return 0;
+	default:
+		return -ENODEV;
+	}
+}
+
+static int set_state(u32 *in, u8 instance)
+{
+	u32 value;
+	acpi_status status;
+	struct acpi_buffer input;
+
+	if (!in)
+		return -EINVAL;
+
+	if (instance > 2)
+		return -ENODEV;
+
+	switch (instance) {
+	case TC1100_INSTANCE_WIRELESS:
+		value = (*in) ? 1 : 2;
+		break;
+	case TC1100_INSTANCE_JOGDIAL:
+		value = (*in) ? 0 : 1;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	input.length = sizeof(u32);
+	input.pointer = &value;
+
+	status = wmi_set_block(GUID, instance, &input);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+
+/* --------------------------------------------------------------------------
+				FS Interface (/sys)
+   -------------------------------------------------------------------------- */
+
+/*
+ * Read/ write bool sysfs macro
+ */
+#define show_set_bool(value, instance) \
+static ssize_t \
+show_bool_##value(struct device *dev, struct device_attribute *attr, \
+	char *buf) \
+{ \
+	u32 result; \
+	acpi_status status = get_state(&result, instance); \
+	if (ACPI_SUCCESS(status)) \
+		return sprintf(buf, "%d\n", result); \
+	return sprintf(buf, "Read error\n"); \
+} \
+\
+static ssize_t \
+set_bool_##value(struct device *dev, struct device_attribute *attr, \
+	const char *buf, size_t count) \
+{ \
+	u32 tmp = simple_strtoul(buf, NULL, 10); \
+	acpi_status status = set_state(&tmp, instance); \
+		if (ACPI_FAILURE(status)) \
+			return -EINVAL; \
+	return count; \
+} \
+static DEVICE_ATTR(value, S_IRUGO | S_IWUSR, \
+	show_bool_##value, set_bool_##value);
+
+show_set_bool(wireless, TC1100_INSTANCE_WIRELESS);
+show_set_bool(jogdial, TC1100_INSTANCE_JOGDIAL);
+
+static struct attribute *tc1100_attributes[] = {
+	&dev_attr_wireless.attr,
+	&dev_attr_jogdial.attr,
+	NULL
+};
+
+static const struct attribute_group tc1100_attribute_group = {
+	.attrs	= tc1100_attributes,
+};
+
+/* --------------------------------------------------------------------------
+				Driver Model
+   -------------------------------------------------------------------------- */
+
+static int __init tc1100_probe(struct platform_device *device)
+{
+	return sysfs_create_group(&device->dev.kobj, &tc1100_attribute_group);
+}
+
+
+static int tc1100_remove(struct platform_device *device)
+{
+	sysfs_remove_group(&device->dev.kobj, &tc1100_attribute_group);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tc1100_suspend(struct device *dev)
+{
+	int ret;
+
+	ret = get_state(&suspend_data.wireless, TC1100_INSTANCE_WIRELESS);
+	if (ret)
+		return ret;
+
+	ret = get_state(&suspend_data.jogdial, TC1100_INSTANCE_JOGDIAL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tc1100_resume(struct device *dev)
+{
+	int ret;
+
+	ret = set_state(&suspend_data.wireless, TC1100_INSTANCE_WIRELESS);
+	if (ret)
+		return ret;
+
+	ret = set_state(&suspend_data.jogdial, TC1100_INSTANCE_JOGDIAL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct dev_pm_ops tc1100_pm_ops = {
+	.suspend	= tc1100_suspend,
+	.resume		= tc1100_resume,
+	.freeze		= tc1100_suspend,
+	.restore	= tc1100_resume,
+};
+#endif
+
+static struct platform_driver tc1100_driver = {
+	.driver = {
+		.name = "tc1100-wmi",
+#ifdef CONFIG_PM
+		.pm = &tc1100_pm_ops,
+#endif
+	},
+	.remove = tc1100_remove,
+};
+
+static int __init tc1100_init(void)
+{
+	int error;
+
+	if (!wmi_has_guid(GUID))
+		return -ENODEV;
+
+	tc1100_device = platform_device_alloc("tc1100-wmi", PLATFORM_DEVID_NONE);
+	if (!tc1100_device)
+		return -ENOMEM;
+
+	error = platform_device_add(tc1100_device);
+	if (error)
+		goto err_device_put;
+
+	error = platform_driver_probe(&tc1100_driver, tc1100_probe);
+	if (error)
+		goto err_device_del;
+
+	pr_info("HP Compaq TC1100 Tablet WMI Extras loaded\n");
+	return 0;
+
+ err_device_del:
+	platform_device_del(tc1100_device);
+ err_device_put:
+	platform_device_put(tc1100_device);
+	return error;
+}
+
+static void __exit tc1100_exit(void)
+{
+	platform_device_unregister(tc1100_device);
+	platform_driver_unregister(&tc1100_driver);
+}
+
+module_init(tc1100_init);
+module_exit(tc1100_exit);
diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
deleted file mode 100644
index e9f852f7c27f..000000000000
--- a/drivers/platform/x86/hp_accel.c
+++ /dev/null
@@ -1,387 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  hp_accel.c - Interface between LIS3LV02DL driver and HP ACPI BIOS
- *
- *  Copyright (C) 2007-2008 Yan Burman
- *  Copyright (C) 2008 Eric Piel
- *  Copyright (C) 2008-2009 Pavel Machek
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/dmi.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/wait.h>
-#include <linux/poll.h>
-#include <linux/freezer.h>
-#include <linux/uaccess.h>
-#include <linux/leds.h>
-#include <linux/atomic.h>
-#include <linux/acpi.h>
-#include <linux/i8042.h>
-#include <linux/serio.h>
-#include "../../misc/lis3lv02d/lis3lv02d.h"
-
-/* Delayed LEDs infrastructure ------------------------------------ */
-
-/* Special LED class that can defer work */
-struct delayed_led_classdev {
-	struct led_classdev led_classdev;
-	struct work_struct work;
-	enum led_brightness new_brightness;
-
-	unsigned int led;		/* For driver */
-	void (*set_brightness)(struct delayed_led_classdev *data, enum led_brightness value);
-};
-
-static inline void delayed_set_status_worker(struct work_struct *work)
-{
-	struct delayed_led_classdev *data =
-			container_of(work, struct delayed_led_classdev, work);
-
-	data->set_brightness(data, data->new_brightness);
-}
-
-static inline void delayed_sysfs_set(struct led_classdev *led_cdev,
-			      enum led_brightness brightness)
-{
-	struct delayed_led_classdev *data = container_of(led_cdev,
-			     struct delayed_led_classdev, led_classdev);
-	data->new_brightness = brightness;
-	schedule_work(&data->work);
-}
-
-/* HP-specific accelerometer driver ------------------------------------ */
-
-/* e0 25, e0 26, e0 27, e0 28 are scan codes that the accelerometer with acpi id
- * HPQ6000 sends through the keyboard bus */
-#define ACCEL_1 0x25
-#define ACCEL_2 0x26
-#define ACCEL_3 0x27
-#define ACCEL_4 0x28
-
-/* For automatic insertion of the module */
-static const struct acpi_device_id lis3lv02d_device_ids[] = {
-	{"HPQ0004", 0}, /* HP Mobile Data Protection System PNP */
-	{"HPQ6000", 0}, /* HP Mobile Data Protection System PNP */
-	{"HPQ6007", 0}, /* HP Mobile Data Protection System PNP */
-	{"", 0},
-};
-MODULE_DEVICE_TABLE(acpi, lis3lv02d_device_ids);
-
-/**
- * lis3lv02d_acpi_init - initialize the device for ACPI
- * @lis3: pointer to the device struct
- *
- * Returns 0 on success.
- */
-static int lis3lv02d_acpi_init(struct lis3lv02d *lis3)
-{
-	return 0;
-}
-
-/**
- * lis3lv02d_acpi_read - ACPI ALRD method: read a register
- * @lis3: pointer to the device struct
- * @reg:    the register to read
- * @ret:    result of the operation
- *
- * Returns 0 on success.
- */
-static int lis3lv02d_acpi_read(struct lis3lv02d *lis3, int reg, u8 *ret)
-{
-	struct acpi_device *dev = lis3->bus_priv;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-	unsigned long long lret;
-	acpi_status status;
-
-	arg0.integer.value = reg;
-
-	status = acpi_evaluate_integer(dev->handle, "ALRD", &args, &lret);
-	if (ACPI_FAILURE(status))
-		return -EINVAL;
-	*ret = lret;
-	return 0;
-}
-
-/**
- * lis3lv02d_acpi_write - ACPI ALWR method: write to a register
- * @lis3: pointer to the device struct
- * @reg:    the register to write to
- * @val:    the value to write
- *
- * Returns 0 on success.
- */
-static int lis3lv02d_acpi_write(struct lis3lv02d *lis3, int reg, u8 val)
-{
-	struct acpi_device *dev = lis3->bus_priv;
-	unsigned long long ret; /* Not used when writting */
-	union acpi_object in_obj[2];
-	struct acpi_object_list args = { 2, in_obj };
-
-	in_obj[0].type          = ACPI_TYPE_INTEGER;
-	in_obj[0].integer.value = reg;
-	in_obj[1].type          = ACPI_TYPE_INTEGER;
-	in_obj[1].integer.value = val;
-
-	if (acpi_evaluate_integer(dev->handle, "ALWR", &args, &ret) != AE_OK)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int lis3lv02d_dmi_matched(const struct dmi_system_id *dmi)
-{
-	lis3_dev.ac = *((union axis_conversion *)dmi->driver_data);
-	pr_info("hardware type %s found\n", dmi->ident);
-
-	return 1;
-}
-
-/* Represents, for each axis seen by userspace, the corresponding hw axis (+1).
- * If the value is negative, the opposite of the hw value is used. */
-#define DEFINE_CONV(name, x, y, z)			      \
-	static union axis_conversion lis3lv02d_axis_##name = \
-		{ .as_array = { x, y, z } }
-DEFINE_CONV(normal, 1, 2, 3);
-DEFINE_CONV(y_inverted, 1, -2, 3);
-DEFINE_CONV(x_inverted, -1, 2, 3);
-DEFINE_CONV(x_inverted_usd, -1, 2, -3);
-DEFINE_CONV(z_inverted, 1, 2, -3);
-DEFINE_CONV(xy_swap, 2, 1, 3);
-DEFINE_CONV(xy_rotated_left, -2, 1, 3);
-DEFINE_CONV(xy_rotated_left_usd, -2, 1, -3);
-DEFINE_CONV(xy_swap_inverted, -2, -1, 3);
-DEFINE_CONV(xy_rotated_right, 2, -1, 3);
-DEFINE_CONV(xy_swap_yz_inverted, 2, -1, -3);
-
-#define AXIS_DMI_MATCH(_ident, _name, _axis) {		\
-	.ident = _ident,				\
-	.callback = lis3lv02d_dmi_matched,		\
-	.matches = {					\
-		DMI_MATCH(DMI_PRODUCT_NAME, _name)	\
-	},						\
-	.driver_data = &lis3lv02d_axis_##_axis		\
-}
-
-#define AXIS_DMI_MATCH2(_ident, _class1, _name1,	\
-				_class2, _name2,	\
-				_axis) {		\
-	.ident = _ident,				\
-	.callback = lis3lv02d_dmi_matched,		\
-	.matches = {					\
-		DMI_MATCH(DMI_##_class1, _name1),	\
-		DMI_MATCH(DMI_##_class2, _name2),	\
-	},						\
-	.driver_data = &lis3lv02d_axis_##_axis		\
-}
-static const struct dmi_system_id lis3lv02d_dmi_ids[] = {
-	/* product names are truncated to match all kinds of a same model */
-	AXIS_DMI_MATCH("NC64x0", "HP Compaq nc64", x_inverted),
-	AXIS_DMI_MATCH("NC84x0", "HP Compaq nc84", z_inverted),
-	AXIS_DMI_MATCH("NX9420", "HP Compaq nx9420", x_inverted),
-	AXIS_DMI_MATCH("NW9440", "HP Compaq nw9440", x_inverted),
-	AXIS_DMI_MATCH("NC2510", "HP Compaq 2510", y_inverted),
-	AXIS_DMI_MATCH("NC2710", "HP Compaq 2710", xy_swap),
-	AXIS_DMI_MATCH("NC8510", "HP Compaq 8510", xy_swap_inverted),
-	AXIS_DMI_MATCH("HP2133", "HP 2133", xy_rotated_left),
-	AXIS_DMI_MATCH("HP2140", "HP 2140", xy_swap_inverted),
-	AXIS_DMI_MATCH("NC653x", "HP Compaq 653", xy_rotated_left_usd),
-	AXIS_DMI_MATCH("NC6730b", "HP Compaq 6730b", xy_rotated_left_usd),
-	AXIS_DMI_MATCH("NC6730s", "HP Compaq 6730s", xy_swap),
-	AXIS_DMI_MATCH("NC651xx", "HP Compaq 651", xy_rotated_right),
-	AXIS_DMI_MATCH("NC6710x", "HP Compaq 6710", xy_swap_yz_inverted),
-	AXIS_DMI_MATCH("NC6715x", "HP Compaq 6715", y_inverted),
-	AXIS_DMI_MATCH("NC693xx", "HP EliteBook 693", xy_rotated_right),
-	AXIS_DMI_MATCH("NC693xx", "HP EliteBook 853", xy_swap),
-	AXIS_DMI_MATCH("NC854xx", "HP EliteBook 854", y_inverted),
-	AXIS_DMI_MATCH("NC273xx", "HP EliteBook 273", y_inverted),
-	/* Intel-based HP Pavilion dv5 */
-	AXIS_DMI_MATCH2("HPDV5_I",
-			PRODUCT_NAME, "HP Pavilion dv5",
-			BOARD_NAME, "3603",
-			x_inverted),
-	/* AMD-based HP Pavilion dv5 */
-	AXIS_DMI_MATCH2("HPDV5_A",
-			PRODUCT_NAME, "HP Pavilion dv5",
-			BOARD_NAME, "3600",
-			y_inverted),
-	AXIS_DMI_MATCH("DV7", "HP Pavilion dv7", x_inverted),
-	AXIS_DMI_MATCH("HP8710", "HP Compaq 8710", y_inverted),
-	AXIS_DMI_MATCH("HDX18", "HP HDX 18", x_inverted),
-	AXIS_DMI_MATCH("HPB432x", "HP ProBook 432", xy_rotated_left),
-	AXIS_DMI_MATCH("HPB440G3", "HP ProBook 440 G3", x_inverted_usd),
-	AXIS_DMI_MATCH("HPB440G4", "HP ProBook 440 G4", x_inverted),
-	AXIS_DMI_MATCH("HPB442x", "HP ProBook 442", xy_rotated_left),
-	AXIS_DMI_MATCH("HPB450G0", "HP ProBook 450 G0", x_inverted),
-	AXIS_DMI_MATCH("HPB452x", "HP ProBook 452", y_inverted),
-	AXIS_DMI_MATCH("HPB522x", "HP ProBook 522", xy_swap),
-	AXIS_DMI_MATCH("HPB532x", "HP ProBook 532", y_inverted),
-	AXIS_DMI_MATCH("HPB655x", "HP ProBook 655", xy_swap_inverted),
-	AXIS_DMI_MATCH("Mini510x", "HP Mini 510", xy_rotated_left_usd),
-	AXIS_DMI_MATCH("HPB63xx", "HP ProBook 63", xy_swap),
-	AXIS_DMI_MATCH("HPB64xx", "HP ProBook 64", xy_swap),
-	AXIS_DMI_MATCH("HPB64xx", "HP EliteBook 84", xy_swap),
-	AXIS_DMI_MATCH("HPB65xx", "HP ProBook 65", x_inverted),
-	AXIS_DMI_MATCH("HPZBook15", "HP ZBook 15", x_inverted),
-	AXIS_DMI_MATCH("HPZBook17G5", "HP ZBook 17 G5", x_inverted),
-	AXIS_DMI_MATCH("HPZBook17", "HP ZBook 17", xy_swap_yz_inverted),
-	{ NULL, }
-/* Laptop models without axis info (yet):
- * "NC6910" "HP Compaq 6910"
- * "NC2400" "HP Compaq nc2400"
- * "NX74x0" "HP Compaq nx74"
- * "NX6325" "HP Compaq nx6325"
- * "NC4400" "HP Compaq nc4400"
- */
-};
-
-static void hpled_set(struct delayed_led_classdev *led_cdev, enum led_brightness value)
-{
-	struct acpi_device *dev = lis3_dev.bus_priv;
-	unsigned long long ret; /* Not used when writing */
-	union acpi_object in_obj[1];
-	struct acpi_object_list args = { 1, in_obj };
-
-	in_obj[0].type          = ACPI_TYPE_INTEGER;
-	in_obj[0].integer.value = !!value;
-
-	acpi_evaluate_integer(dev->handle, "ALED", &args, &ret);
-}
-
-static struct delayed_led_classdev hpled_led = {
-	.led_classdev = {
-		.name			= "hp::hddprotect",
-		.default_trigger	= "none",
-		.brightness_set		= delayed_sysfs_set,
-		.flags                  = LED_CORE_SUSPENDRESUME,
-	},
-	.set_brightness = hpled_set,
-};
-
-static bool hp_accel_i8042_filter(unsigned char data, unsigned char str,
-				  struct serio *port)
-{
-	static bool extended;
-
-	if (str & I8042_STR_AUXDATA)
-		return false;
-
-	if (data == 0xe0) {
-		extended = true;
-		return true;
-	} else if (unlikely(extended)) {
-		extended = false;
-
-		switch (data) {
-		case ACCEL_1:
-		case ACCEL_2:
-		case ACCEL_3:
-		case ACCEL_4:
-			return true;
-		default:
-			serio_interrupt(port, 0xe0, 0);
-			return false;
-		}
-	}
-
-	return false;
-}
-
-static int lis3lv02d_probe(struct platform_device *device)
-{
-	int ret;
-
-	lis3_dev.bus_priv = ACPI_COMPANION(&device->dev);
-	lis3_dev.init = lis3lv02d_acpi_init;
-	lis3_dev.read = lis3lv02d_acpi_read;
-	lis3_dev.write = lis3lv02d_acpi_write;
-
-	/* obtain IRQ number of our device from ACPI */
-	ret = platform_get_irq_optional(device, 0);
-	if (ret > 0)
-		lis3_dev.irq = ret;
-
-	/* If possible use a "standard" axes order */
-	if (lis3_dev.ac.x && lis3_dev.ac.y && lis3_dev.ac.z) {
-		pr_info("Using custom axes %d,%d,%d\n",
-			lis3_dev.ac.x, lis3_dev.ac.y, lis3_dev.ac.z);
-	} else if (dmi_check_system(lis3lv02d_dmi_ids) == 0) {
-		pr_info("laptop model unknown, using default axes configuration\n");
-		lis3_dev.ac = lis3lv02d_axis_normal;
-	}
-
-	/* call the core layer do its init */
-	ret = lis3lv02d_init_device(&lis3_dev);
-	if (ret)
-		return ret;
-
-	/* filter to remove HPQ6000 accelerometer data
-	 * from keyboard bus stream */
-	if (strstr(dev_name(&device->dev), "HPQ6000"))
-		i8042_install_filter(hp_accel_i8042_filter);
-
-	INIT_WORK(&hpled_led.work, delayed_set_status_worker);
-	ret = led_classdev_register(NULL, &hpled_led.led_classdev);
-	if (ret) {
-		i8042_remove_filter(hp_accel_i8042_filter);
-		lis3lv02d_joystick_disable(&lis3_dev);
-		lis3lv02d_poweroff(&lis3_dev);
-		flush_work(&hpled_led.work);
-		lis3lv02d_remove_fs(&lis3_dev);
-		return ret;
-	}
-
-	return ret;
-}
-
-static int lis3lv02d_remove(struct platform_device *device)
-{
-	i8042_remove_filter(hp_accel_i8042_filter);
-	lis3lv02d_joystick_disable(&lis3_dev);
-	lis3lv02d_poweroff(&lis3_dev);
-
-	led_classdev_unregister(&hpled_led.led_classdev);
-	flush_work(&hpled_led.work);
-
-	lis3lv02d_remove_fs(&lis3_dev);
-	return 0;
-}
-
-static int __maybe_unused lis3lv02d_suspend(struct device *dev)
-{
-	/* make sure the device is off when we suspend */
-	lis3lv02d_poweroff(&lis3_dev);
-	return 0;
-}
-
-static int __maybe_unused lis3lv02d_resume(struct device *dev)
-{
-	lis3lv02d_poweron(&lis3_dev);
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(hp_accel_pm, lis3lv02d_suspend, lis3lv02d_resume);
-
-/* For the HP MDPS aka 3D Driveguard */
-static struct platform_driver lis3lv02d_driver = {
-	.probe	= lis3lv02d_probe,
-	.remove	= lis3lv02d_remove,
-	.driver	= {
-		.name	= "hp_accel",
-		.pm	= &hp_accel_pm,
-		.acpi_match_table = lis3lv02d_device_ids,
-	},
-};
-module_platform_driver(lis3lv02d_driver);
-
-MODULE_DESCRIPTION("Glue between LIS3LV02Dx and HP ACPI BIOS and support for disk protection LED.");
-MODULE_AUTHOR("Yan Burman, Eric Piel, Pavel Machek");
-MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/tc1100-wmi.c b/drivers/platform/x86/tc1100-wmi.c
deleted file mode 100644
index ded26213c420..000000000000
--- a/drivers/platform/x86/tc1100-wmi.c
+++ /dev/null
@@ -1,265 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  HP Compaq TC1100 Tablet WMI Extras Driver
- *
- *  Copyright (C) 2007 Carlos Corbacho <carlos@strangeworlds.co.uk>
- *  Copyright (C) 2004 Jamey Hicks <jamey.hicks@hp.com>
- *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
- *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/acpi.h>
-#include <linux/platform_device.h>
-
-#define GUID "C364AC71-36DB-495A-8494-B439D472A505"
-
-#define TC1100_INSTANCE_WIRELESS		1
-#define TC1100_INSTANCE_JOGDIAL		2
-
-MODULE_AUTHOR("Jamey Hicks, Carlos Corbacho");
-MODULE_DESCRIPTION("HP Compaq TC1100 Tablet WMI Extras");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("wmi:C364AC71-36DB-495A-8494-B439D472A505");
-
-static struct platform_device *tc1100_device;
-
-struct tc1100_data {
-	u32 wireless;
-	u32 jogdial;
-};
-
-#ifdef CONFIG_PM
-static struct tc1100_data suspend_data;
-#endif
-
-/* --------------------------------------------------------------------------
-				Device Management
-   -------------------------------------------------------------------------- */
-
-static int get_state(u32 *out, u8 instance)
-{
-	u32 tmp;
-	acpi_status status;
-	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-
-	if (!out)
-		return -EINVAL;
-
-	if (instance > 2)
-		return -ENODEV;
-
-	status = wmi_query_block(GUID, instance, &result);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	obj = (union acpi_object *) result.pointer;
-	if (obj && obj->type == ACPI_TYPE_INTEGER) {
-		tmp = obj->integer.value;
-	} else {
-		tmp = 0;
-	}
-
-	if (result.length > 0)
-		kfree(result.pointer);
-
-	switch (instance) {
-	case TC1100_INSTANCE_WIRELESS:
-		*out = (tmp == 3) ? 1 : 0;
-		return 0;
-	case TC1100_INSTANCE_JOGDIAL:
-		*out = (tmp == 1) ? 0 : 1;
-		return 0;
-	default:
-		return -ENODEV;
-	}
-}
-
-static int set_state(u32 *in, u8 instance)
-{
-	u32 value;
-	acpi_status status;
-	struct acpi_buffer input;
-
-	if (!in)
-		return -EINVAL;
-
-	if (instance > 2)
-		return -ENODEV;
-
-	switch (instance) {
-	case TC1100_INSTANCE_WIRELESS:
-		value = (*in) ? 1 : 2;
-		break;
-	case TC1100_INSTANCE_JOGDIAL:
-		value = (*in) ? 0 : 1;
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	input.length = sizeof(u32);
-	input.pointer = &value;
-
-	status = wmi_set_block(GUID, instance, &input);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	return 0;
-}
-
-/* --------------------------------------------------------------------------
-				FS Interface (/sys)
-   -------------------------------------------------------------------------- */
-
-/*
- * Read/ write bool sysfs macro
- */
-#define show_set_bool(value, instance) \
-static ssize_t \
-show_bool_##value(struct device *dev, struct device_attribute *attr, \
-	char *buf) \
-{ \
-	u32 result; \
-	acpi_status status = get_state(&result, instance); \
-	if (ACPI_SUCCESS(status)) \
-		return sprintf(buf, "%d\n", result); \
-	return sprintf(buf, "Read error\n"); \
-} \
-\
-static ssize_t \
-set_bool_##value(struct device *dev, struct device_attribute *attr, \
-	const char *buf, size_t count) \
-{ \
-	u32 tmp = simple_strtoul(buf, NULL, 10); \
-	acpi_status status = set_state(&tmp, instance); \
-		if (ACPI_FAILURE(status)) \
-			return -EINVAL; \
-	return count; \
-} \
-static DEVICE_ATTR(value, S_IRUGO | S_IWUSR, \
-	show_bool_##value, set_bool_##value);
-
-show_set_bool(wireless, TC1100_INSTANCE_WIRELESS);
-show_set_bool(jogdial, TC1100_INSTANCE_JOGDIAL);
-
-static struct attribute *tc1100_attributes[] = {
-	&dev_attr_wireless.attr,
-	&dev_attr_jogdial.attr,
-	NULL
-};
-
-static const struct attribute_group tc1100_attribute_group = {
-	.attrs	= tc1100_attributes,
-};
-
-/* --------------------------------------------------------------------------
-				Driver Model
-   -------------------------------------------------------------------------- */
-
-static int __init tc1100_probe(struct platform_device *device)
-{
-	return sysfs_create_group(&device->dev.kobj, &tc1100_attribute_group);
-}
-
-
-static int tc1100_remove(struct platform_device *device)
-{
-	sysfs_remove_group(&device->dev.kobj, &tc1100_attribute_group);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int tc1100_suspend(struct device *dev)
-{
-	int ret;
-
-	ret = get_state(&suspend_data.wireless, TC1100_INSTANCE_WIRELESS);
-	if (ret)
-		return ret;
-
-	ret = get_state(&suspend_data.jogdial, TC1100_INSTANCE_JOGDIAL);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int tc1100_resume(struct device *dev)
-{
-	int ret;
-
-	ret = set_state(&suspend_data.wireless, TC1100_INSTANCE_WIRELESS);
-	if (ret)
-		return ret;
-
-	ret = set_state(&suspend_data.jogdial, TC1100_INSTANCE_JOGDIAL);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static const struct dev_pm_ops tc1100_pm_ops = {
-	.suspend	= tc1100_suspend,
-	.resume		= tc1100_resume,
-	.freeze		= tc1100_suspend,
-	.restore	= tc1100_resume,
-};
-#endif
-
-static struct platform_driver tc1100_driver = {
-	.driver = {
-		.name = "tc1100-wmi",
-#ifdef CONFIG_PM
-		.pm = &tc1100_pm_ops,
-#endif
-	},
-	.remove = tc1100_remove,
-};
-
-static int __init tc1100_init(void)
-{
-	int error;
-
-	if (!wmi_has_guid(GUID))
-		return -ENODEV;
-
-	tc1100_device = platform_device_alloc("tc1100-wmi", PLATFORM_DEVID_NONE);
-	if (!tc1100_device)
-		return -ENOMEM;
-
-	error = platform_device_add(tc1100_device);
-	if (error)
-		goto err_device_put;
-
-	error = platform_driver_probe(&tc1100_driver, tc1100_probe);
-	if (error)
-		goto err_device_del;
-
-	pr_info("HP Compaq TC1100 Tablet WMI Extras loaded\n");
-	return 0;
-
- err_device_del:
-	platform_device_del(tc1100_device);
- err_device_put:
-	platform_device_put(tc1100_device);
-	return error;
-}
-
-static void __exit tc1100_exit(void)
-{
-	platform_device_unregister(tc1100_device);
-	platform_driver_unregister(&tc1100_driver);
-}
-
-module_init(tc1100_init);
-module_exit(tc1100_exit);
diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
index 123a4618db55..9178076d9d7d 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -265,6 +265,88 @@ static struct gpiod_lookup_table int3496_gpo2_pin22_gpios = {
 	},
 };
 
+static struct gpiod_lookup_table int3496_reference_gpios = {
+	.dev_id = "intel-int3496",
+	.table = {
+		GPIO_LOOKUP("INT33FC:01", 15, "vbus", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT33FC:02", 1, "mux", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT33FC:02", 18, "id", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+/* Acer Iconia One 7 B1-750 has an Android factory img with everything hardcoded */
+static const char * const acer_b1_750_mount_matrix[] = {
+	"-1", "0", "0",
+	"0", "1", "0",
+	"0", "0", "1"
+};
+
+static const struct property_entry acer_b1_750_bma250e_props[] = {
+	PROPERTY_ENTRY_STRING_ARRAY("mount-matrix", acer_b1_750_mount_matrix),
+	{ }
+};
+
+static const struct software_node acer_b1_750_bma250e_node = {
+	.properties = acer_b1_750_bma250e_props,
+};
+
+static const struct x86_i2c_client_info acer_b1_750_i2c_clients[] __initconst = {
+	{
+		/* Novatek NVT-ts touchscreen */
+		.board_info = {
+			.type = "NVT-ts",
+			.addr = 0x34,
+			.dev_name = "NVT-ts",
+		},
+		.adapter_path = "\\_SB_.I2C4",
+		.irq_data = {
+			.type = X86_ACPI_IRQ_TYPE_GPIOINT,
+			.chip = "INT33FC:02",
+			.index = 3,
+			.trigger = ACPI_EDGE_SENSITIVE,
+			.polarity = ACPI_ACTIVE_LOW,
+		},
+	}, {
+		/* BMA250E accelerometer */
+		.board_info = {
+			.type = "bma250e",
+			.addr = 0x18,
+			.swnode = &acer_b1_750_bma250e_node,
+		},
+		.adapter_path = "\\_SB_.I2C3",
+		.irq_data = {
+			.type = X86_ACPI_IRQ_TYPE_GPIOINT,
+			.chip = "INT33FC:02",
+			.index = 25,
+			.trigger = ACPI_LEVEL_SENSITIVE,
+			.polarity = ACPI_ACTIVE_HIGH,
+		},
+	},
+};
+
+static struct gpiod_lookup_table acer_b1_750_goodix_gpios = {
+	.dev_id = "i2c-NVT-ts",
+	.table = {
+		GPIO_LOOKUP("INT33FC:01", 26, "reset", GPIO_ACTIVE_LOW),
+		{ }
+	},
+};
+
+static struct gpiod_lookup_table * const acer_b1_750_gpios[] = {
+	&acer_b1_750_goodix_gpios,
+	&int3496_reference_gpios,
+	NULL
+};
+
+static const struct x86_dev_info acer_b1_750_info __initconst = {
+	.i2c_client_info = acer_b1_750_i2c_clients,
+	.i2c_client_count = ARRAY_SIZE(acer_b1_750_i2c_clients),
+	.pdev_info = int3496_pdevs,
+	.pdev_count = ARRAY_SIZE(int3496_pdevs),
+	.gpiod_lookup_tables = acer_b1_750_gpios,
+};
+
 /*
  * Advantech MICA-071
  * This is a standard Windows tablet, but it has an extra "quick launch" button
@@ -1298,17 +1380,8 @@ static const struct x86_i2c_client_info nextbook_ares8_i2c_clients[] __initconst
 	},
 };
 
-static struct gpiod_lookup_table nextbook_ares8_int3496_gpios = {
-	.dev_id = "intel-int3496",
-	.table = {
-		GPIO_LOOKUP("INT33FC:02", 1, "mux", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 18, "id", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
 static struct gpiod_lookup_table * const nextbook_ares8_gpios[] = {
-	&nextbook_ares8_int3496_gpios,
+	&int3496_reference_gpios,
 	NULL
 };
 
@@ -1435,6 +1508,14 @@ static const struct x86_dev_info xiaomi_mipad2_info __initconst = {
 };
 
 static const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
+	{
+		/* Acer Iconia One 7 B1-750 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VESPA2"),
+		},
+		.driver_data = (void *)&acer_b1_750_info,
+	},
 	{
 		/* Advantech MICA-071 */
 		.matches = {
diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 506ec9565716..dcd07a6a5e94 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -721,6 +721,191 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
 		dev_err(dev, "%s: failed (%d, err:%d)\n", __func__, vqid, err);
 }
 
+/*
+ * Custom memory copy implementation for i.MX DSP Cores
+ *
+ * The IRAM is part of the HiFi DSP.
+ * According to hw specs only 32-bits writes are allowed.
+ */
+static int imx_dsp_rproc_memcpy(void *dst, const void *src, size_t size)
+{
+	void __iomem *dest = (void __iomem *)dst;
+	const u8 *src_byte = src;
+	const u32 *source = src;
+	u32 affected_mask;
+	int i, q, r;
+	u32 tmp;
+
+	/* destination must be 32bit aligned */
+	if (!IS_ALIGNED((uintptr_t)dest, 4))
+		return -EINVAL;
+
+	q = size / 4;
+	r = size % 4;
+
+	/* copy data in units of 32 bits at a time */
+	for (i = 0; i < q; i++)
+		writel(source[i], dest + i * 4);
+
+	if (r) {
+		affected_mask = GENMASK(8 * r, 0);
+
+		/*
+		 * first read the 32bit data of dest, then change affected
+		 * bytes, and write back to dest.
+		 * For unaffected bytes, it should not be changed
+		 */
+		tmp = readl(dest + q * 4);
+		tmp &= ~affected_mask;
+
+		/* avoid reading after end of source */
+		for (i = 0; i < r; i++)
+			tmp |= (src_byte[q * 4 + i] << (8 * i));
+
+		writel(tmp, dest + q * 4);
+	}
+
+	return 0;
+}
+
+/*
+ * Custom memset implementation for i.MX DSP Cores
+ *
+ * The IRAM is part of the HiFi DSP.
+ * According to hw specs only 32-bits writes are allowed.
+ */
+static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
+{
+	void __iomem *tmp_dst = (void __iomem *)addr;
+	u32 tmp_val = value;
+	u32 affected_mask;
+	int q, r;
+	u32 tmp;
+
+	/* destination must be 32bit aligned */
+	if (!IS_ALIGNED((uintptr_t)addr, 4))
+		return -EINVAL;
+
+	tmp_val |= tmp_val << 8;
+	tmp_val |= tmp_val << 16;
+
+	q = size / 4;
+	r = size % 4;
+
+	while (q--)
+		writel(tmp_val, tmp_dst++);
+
+	if (r) {
+		affected_mask = GENMASK(8 * r, 0);
+
+		/*
+		 * first read the 32bit data of addr, then change affected
+		 * bytes, and write back to addr.
+		 * For unaffected bytes, it should not be changed
+		 */
+		tmp = readl(tmp_dst);
+		tmp &= ~affected_mask;
+
+		tmp |= (tmp_val & affected_mask);
+		writel(tmp, tmp_dst);
+	}
+
+	return 0;
+}
+
+/*
+ * imx_dsp_rproc_elf_load_segments() - load firmware segments to memory
+ * @rproc: remote processor which will be booted using these fw segments
+ * @fw: the ELF firmware image
+ *
+ * This function loads the firmware segments to memory, where the remote
+ * processor expects them.
+ *
+ * Return: 0 on success and an appropriate error code otherwise
+ */
+static int imx_dsp_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev = &rproc->dev;
+	const void *ehdr, *phdr;
+	int i, ret = 0;
+	u16 phnum;
+	const u8 *elf_data = fw->data;
+	u8 class = fw_elf_get_class(fw);
+	u32 elf_phdr_get_size = elf_size_of_phdr(class);
+
+	ehdr = elf_data;
+	phnum = elf_hdr_get_e_phnum(class, ehdr);
+	phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
+
+	/* go through the available ELF segments */
+	for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
+		u64 da = elf_phdr_get_p_paddr(class, phdr);
+		u64 memsz = elf_phdr_get_p_memsz(class, phdr);
+		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
+		u64 offset = elf_phdr_get_p_offset(class, phdr);
+		u32 type = elf_phdr_get_p_type(class, phdr);
+		void *ptr;
+
+		if (type != PT_LOAD || !memsz)
+			continue;
+
+		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
+			type, da, memsz, filesz);
+
+		if (filesz > memsz) {
+			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
+				filesz, memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (offset + filesz > fw->size) {
+			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
+				offset + filesz, fw->size);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (!rproc_u64_fit_in_size_t(memsz)) {
+			dev_err(dev, "size (%llx) does not fit in size_t type\n",
+				memsz);
+			ret = -EOVERFLOW;
+			break;
+		}
+
+		/* grab the kernel address for this device address */
+		ptr = rproc_da_to_va(rproc, da, memsz, NULL);
+		if (!ptr) {
+			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
+				memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		/* put the segment where the remote processor expects it */
+		if (filesz) {
+			ret = imx_dsp_rproc_memcpy(ptr, elf_data + offset, filesz);
+			if (ret) {
+				dev_err(dev, "memory copy failed for da 0x%llx memsz 0x%llx\n",
+					da, memsz);
+				break;
+			}
+		}
+
+		/* zero out remaining memory for this segment */
+		if (memsz > filesz) {
+			ret = imx_dsp_rproc_memset(ptr + filesz, 0, memsz - filesz);
+			if (ret) {
+				dev_err(dev, "memset failed for da 0x%llx memsz 0x%llx\n",
+					da, memsz);
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 {
 	if (rproc_elf_load_rsc_table(rproc, fw))
@@ -735,7 +920,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
 	.start		= imx_dsp_rproc_start,
 	.stop		= imx_dsp_rproc_stop,
 	.kick		= imx_dsp_rproc_kick,
-	.load		= rproc_elf_load_segments,
+	.load		= imx_dsp_rproc_elf_load_segments,
 	.parse_fw	= imx_dsp_rproc_parse_fw,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 23c1690b8d73..8746cbb1f168 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -291,8 +291,16 @@ static void stm32_rproc_mb_vq_work(struct work_struct *work)
 	struct stm32_mbox *mb = container_of(work, struct stm32_mbox, vq_work);
 	struct rproc *rproc = dev_get_drvdata(mb->client.dev);
 
+	mutex_lock(&rproc->lock);
+
+	if (rproc->state != RPROC_RUNNING)
+		goto unlock_mutex;
+
 	if (rproc_vq_interrupt(rproc, mb->vq_id) == IRQ_NONE)
 		dev_dbg(&rproc->dev, "no message found in vq%d\n", mb->vq_id);
+
+unlock_mutex:
+	mutex_unlock(&rproc->lock);
 }
 
 static void stm32_rproc_mb_callback(struct mbox_client *cl, void *data)
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index b20ce86b97b2..792e5d245bc3 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -127,6 +127,8 @@ static int prepare_itcw(struct itcw *, unsigned int, unsigned int, int,
 			struct dasd_device *, struct dasd_device *,
 			unsigned int, int, unsigned int, unsigned int,
 			unsigned int, unsigned int);
+static int dasd_eckd_query_pprc_status(struct dasd_device *,
+				       struct dasd_pprc_data_sc4 *);
 
 /* initial attempt at a probe function. this can be simplified once
  * the other detection code is gone */
@@ -3732,6 +3734,26 @@ static int count_exts(unsigned int from, unsigned int to, int trks_per_ext)
 	return count;
 }
 
+static int dasd_in_copy_relation(struct dasd_device *device)
+{
+	struct dasd_pprc_data_sc4 *temp;
+	int rc;
+
+	if (!dasd_eckd_pprc_enabled(device))
+		return 0;
+
+	temp = kzalloc(sizeof(*temp), GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	rc = dasd_eckd_query_pprc_status(device, temp);
+	if (!rc)
+		rc = temp->dev_info[0].state;
+
+	kfree(temp);
+	return rc;
+}
+
 /*
  * Release allocated space for a given range or an entire volume.
  */
@@ -3748,6 +3770,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	int cur_to_trk, cur_from_trk;
 	struct dasd_ccw_req *cqr;
 	u32 beg_cyl, end_cyl;
+	int copy_relation;
 	struct ccw1 *ccw;
 	int trks_per_ext;
 	size_t ras_size;
@@ -3759,6 +3782,10 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	if (dasd_eckd_ras_sanity_checks(device, first_trk, last_trk))
 		return ERR_PTR(-EINVAL);
 
+	copy_relation = dasd_in_copy_relation(device);
+	if (copy_relation < 0)
+		return ERR_PTR(copy_relation);
+
 	rq = req ? blk_mq_rq_to_pdu(req) : NULL;
 
 	features = &private->features;
@@ -3787,9 +3814,11 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	/*
 	 * This bit guarantees initialisation of tracks within an extent that is
 	 * not fully specified, but is only supported with a certain feature
-	 * subset.
+	 * subset and for devices not in a copy relation.
 	 */
-	ras_data->op_flags.guarantee_init = !!(features->feature[56] & 0x01);
+	if (features->feature[56] & 0x01 && !copy_relation)
+		ras_data->op_flags.guarantee_init = 1;
+
 	ras_data->lss = private->conf.ned->ID;
 	ras_data->dev_addr = private->conf.ned->unit_addr;
 	ras_data->nr_exts = nr_exts;
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 3b1cd0c96a74..ba4c69226c33 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1102,6 +1102,8 @@ static void io_subchannel_verify(struct subchannel *sch)
 	cdev = sch_get_cdev(sch);
 	if (cdev)
 		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+	else
+		css_schedule_eval(sch->schid);
 }
 
 static void io_subchannel_terminate_path(struct subchannel *sch, u8 mask)
diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index 5ea6249d8180..641f0dbb65a9 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -95,7 +95,7 @@ static inline int do_sqbs(u64 token, unsigned char state, int queue,
 		"	lgr	1,%[token]\n"
 		"	.insn	rsy,0xeb000000008a,%[qs],%[ccq],0(%[state])"
 		: [ccq] "+&d" (_ccq), [qs] "+&d" (_queuestart)
-		: [state] "d" ((unsigned long)state), [token] "d" (token)
+		: [state] "a" ((unsigned long)state), [token] "d" (token)
 		: "memory", "cc", "1");
 	*count = _ccq & 0xff;
 	*start = _queuestart & 0xff;
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index f5252e45a48a..3e365e5e194a 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2157,10 +2157,13 @@ lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
 	char mybuf[64];
 	char *pbuf;
 	int i;
+	size_t bsize;
 
 	memset(mybuf, 0, sizeof(mybuf));
 
-	if (copy_from_user(mybuf, buf, nbytes))
+	bsize = min(nbytes, (sizeof(mybuf) - 1));
+
+	if (copy_from_user(mybuf, buf, bsize))
 		return -EFAULT;
 	pbuf = &mybuf[0];
 
@@ -2181,7 +2184,7 @@ lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
 			qp->lock_conflict.wq_access = 0;
 		}
 	}
-	return nbytes;
+	return bsize;
 }
 #endif
 
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 863b2125fed6..ddd5949d8fc0 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5402,18 +5402,20 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	 * these conditions and release the RPI.
 	 */
 	if (phba->sli_rev == LPFC_SLI_REV4 &&
-	    (vport && vport->port_type == LPFC_NPIV_PORT) &&
-	    !(ndlp->fc4_xpt_flags & SCSI_XPT_REGD) &&
-	    ndlp->nlp_flag & NLP_RELEASE_RPI) {
-		if (ndlp->nlp_state !=  NLP_STE_PLOGI_ISSUE &&
-		    ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE) {
-			lpfc_sli4_free_rpi(phba, ndlp->nlp_rpi);
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
-			ndlp->nlp_flag &= ~NLP_RELEASE_RPI;
-			spin_unlock_irq(&ndlp->lock);
-			lpfc_drop_node(vport, ndlp);
+	    vport && vport->port_type == LPFC_NPIV_PORT &&
+	    !(ndlp->fc4_xpt_flags & SCSI_XPT_REGD)) {
+		if (ndlp->nlp_flag & NLP_RELEASE_RPI) {
+			if (ndlp->nlp_state != NLP_STE_PLOGI_ISSUE &&
+			    ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE) {
+				lpfc_sli4_free_rpi(phba, ndlp->nlp_rpi);
+				spin_lock_irq(&ndlp->lock);
+				ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
+				ndlp->nlp_flag &= ~NLP_RELEASE_RPI;
+				spin_unlock_irq(&ndlp->lock);
+			}
 		}
+
+		lpfc_drop_node(vport, ndlp);
 	}
 
 	/* Release the originating I/O reference. */
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index a0665bca54b9..5284f9a0b826 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1780,7 +1780,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
-	payload_sz = sizeof(cmd_request->mpb);
+	payload_sz = 0;
 
 	if (scsi_sg_count(scmnd)) {
 		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
@@ -1789,10 +1789,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		unsigned long hvpfn, hvpfns_to_add;
 		int j, i = 0, sg_count;
 
-		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
+		payload_sz = (hvpg_count * sizeof(u64) +
+			      sizeof(struct vmbus_packet_mpb_array));
 
-			payload_sz = (hvpg_count * sizeof(u64) +
-				      sizeof(struct vmbus_packet_mpb_array));
+		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
 			payload = kzalloc(payload_sz, GFP_ATOMIC);
 			if (!payload)
 				return SCSI_MLQUEUE_DEVICE_BUSY;
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 76515c33e639..4fd221d0cc81 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -571,9 +571,11 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_get_sync(&slave->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
+	}
 
 	ret = sdw_nread_no_pm(slave, addr, count, val);
 
@@ -595,9 +597,11 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 {
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_get_sync(&slave->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
+	}
 
 	ret = sdw_nwrite_no_pm(slave, addr, count, val);
 
@@ -1565,9 +1569,10 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 
 	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
+	ret = pm_runtime_get_sync(&slave->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err(&slave->dev, "Failed to resume device: %d\n", ret);
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
 	}
 
diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 7969881f126d..58ea013fa918 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -73,6 +73,23 @@ static const struct adr_remap hp_omen_16[] = {
 	{}
 };
 
+/*
+ * Intel NUC M15 LAPRC510 and LAPRC710
+ */
+static const struct adr_remap intel_rooks_county[] = {
+	/* rt711-sdca on link0 */
+	{
+		0x000020025d071100ull,
+		0x000030025d071101ull
+	},
+	/* rt1316-sdca on link2 */
+	{
+		0x000120025d071100ull,
+		0x000230025d131601ull
+	},
+	{}
+};
+
 static const struct dmi_system_id adr_remap_quirk_table[] = {
 	/* TGL devices */
 	{
@@ -98,6 +115,14 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_tgl_bios,
 	},
+	{
+		/* quirk used for NUC15 'Rooks County' LAPRC510 and LAPRC710 skews */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel(R) Client Systems"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LAPRC"),
+		},
+		.driver_data = (void *)intel_rooks_county,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 866026185c66..21c50972047f 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1209,6 +1209,9 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	ctrl->num_dout_ports = val;
 
 	nports = ctrl->num_dout_ports + ctrl->num_din_ports;
+	if (nports > QCOM_SDW_MAX_PORTS)
+		return -EINVAL;
+
 	/* Valid port numbers are from 1-14, so mask out port 0 explicitly */
 	set_bit(0, &ctrl->dout_port_mask);
 	set_bit(0, &ctrl->din_port_mask);
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index fbd7b354dd36..2c660a95c17e 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -253,6 +253,18 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
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
@@ -261,16 +273,16 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
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
diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index dfd2b357f484..0a85ea667a1b 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -103,17 +103,17 @@
  *           globals
  * ----------------------------
  */
-static int read_timeout = 1000; /* ms to wait before read() times out */
-static int write_timeout = 1000; /* ms to wait before write() times out */
+static long read_timeout = 1000; /* ms to wait before read() times out */
+static long write_timeout = 1000; /* ms to wait before write() times out */
 
 /* ----------------------------
  * module command-line arguments
  * ----------------------------
  */
 
-module_param(read_timeout, int, 0444);
+module_param(read_timeout, long, 0444);
 MODULE_PARM_DESC(read_timeout, "ms to wait before blocking read() timing out; set to -1 for no timeout");
-module_param(write_timeout, int, 0444);
+module_param(write_timeout, long, 0444);
 MODULE_PARM_DESC(write_timeout, "ms to wait before blocking write() timing out; set to -1 for no timeout");
 
 /* ----------------------------
@@ -384,9 +384,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
 			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-				 (read_timeout >= 0) ?
-				  msecs_to_jiffies(read_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+			read_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -528,9 +526,7 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
 			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
 				 >= words_to_write,
-				 (write_timeout >= 0) ?
-				  msecs_to_jiffies(write_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+			write_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -948,7 +944,17 @@ static struct platform_driver axis_fifo_driver = {
 
 static int __init axis_fifo_init(void)
 {
-	pr_info("axis-fifo driver loaded with parameters read_timeout = %i, write_timeout = %i\n",
+	if (read_timeout >= 0)
+		read_timeout = msecs_to_jiffies(read_timeout);
+	else
+		read_timeout = MAX_SCHEDULE_TIMEOUT;
+
+	if (write_timeout >= 0)
+		write_timeout = msecs_to_jiffies(write_timeout);
+	else
+		write_timeout = MAX_SCHEDULE_TIMEOUT;
+
+	pr_info("axis-fifo driver loaded with parameters read_timeout = %li, write_timeout = %li\n",
 		read_timeout, write_timeout);
 	return platform_driver_register(&axis_fifo_driver);
 }
diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 93ba09236010..5cc67786b916 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -501,14 +501,14 @@ static int capture_legacy_g_parm(struct file *file, void *fh,
 				 struct v4l2_streamparm *a)
 {
 	struct capture_priv *priv = video_drvdata(file);
-	struct v4l2_subdev_frame_interval fi;
+	struct v4l2_subdev_frame_interval fi = {
+		.pad = priv->src_sd_pad,
+	};
 	int ret;
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
 
-	memset(&fi, 0, sizeof(fi));
-	fi.pad = priv->src_sd_pad;
 	ret = v4l2_subdev_call(priv->src_sd, video, g_frame_interval, &fi);
 	if (ret < 0)
 		return ret;
@@ -523,14 +523,14 @@ static int capture_legacy_s_parm(struct file *file, void *fh,
 				 struct v4l2_streamparm *a)
 {
 	struct capture_priv *priv = video_drvdata(file);
-	struct v4l2_subdev_frame_interval fi;
+	struct v4l2_subdev_frame_interval fi = {
+		.pad = priv->src_sd_pad,
+	};
 	int ret;
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
 
-	memset(&fi, 0, sizeof(fi));
-	fi.pad = priv->src_sd_pad;
 	fi.interval = a->parm.capture.timeperframe;
 	ret = v4l2_subdev_call(priv->src_sd, video, s_frame_interval, &fi);
 	if (ret < 0)
diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index 3e7462112649..4985f21b4023 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -432,15 +432,15 @@ int imx_media_init_cfg(struct v4l2_subdev *sd,
 		       struct v4l2_subdev_state *sd_state)
 {
 	struct v4l2_mbus_framefmt *mf_try;
-	struct v4l2_subdev_format format;
 	unsigned int pad;
 	int ret;
 
 	for (pad = 0; pad < sd->entity.num_pads; pad++) {
-		memset(&format, 0, sizeof(format));
+		struct v4l2_subdev_format format = {
+			.pad = pad,
+			.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		};
 
-		format.pad = pad;
-		format.which = V4L2_SUBDEV_FORMAT_ACTIVE;
 		ret = v4l2_subdev_call(sd, pad, get_fmt, NULL, &format);
 		if (ret)
 			continue;
diff --git a/drivers/staging/media/omap4iss/iss_video.c b/drivers/staging/media/omap4iss/iss_video.c
index 60f3d84be828..8cc8b3ebab11 100644
--- a/drivers/staging/media/omap4iss/iss_video.c
+++ b/drivers/staging/media/omap4iss/iss_video.c
@@ -244,7 +244,9 @@ static int
 __iss_video_get_format(struct iss_video *video,
 		       struct v4l2_mbus_framefmt *format)
 {
-	struct v4l2_subdev_format fmt;
+	struct v4l2_subdev_format fmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
 	struct v4l2_subdev *subdev;
 	u32 pad;
 	int ret;
@@ -253,9 +255,7 @@ __iss_video_get_format(struct iss_video *video,
 	if (!subdev)
 		return -EINVAL;
 
-	memset(&fmt, 0, sizeof(fmt));
 	fmt.pad = pad;
-	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
 
 	mutex_lock(&video->mutex);
 	ret = v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index c1e50084172d..7e11364d718b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -48,9 +48,9 @@ static const struct rtl819x_ops rtl819xp_ops = {
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
index 7021f9c435d9..50f1ec78cc45 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -55,11 +55,6 @@
 #define IS_HARDWARE_TYPE_8192SE(_priv)		\
 	(((struct r8192_priv *)rtllib_priv(dev))->card_8192 == NIC_8192SE)
 
-#define RTL_PCI_DEVICE(vend, dev, cfg) \
-	.vendor = (vend), .device = (dev), \
-	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
-	.driver_data = (kernel_ulong_t)&(cfg)
-
 #define TOTAL_CAM_ENTRY		32
 #define CAM_CONTENT_COUNT	8
 
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 3f7a9f7f5f4e..07e196b44b91 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4531,6 +4531,9 @@ int iscsit_close_session(struct iscsit_session *sess, bool can_sleep)
 	iscsit_stop_time2retain_timer(sess);
 	spin_unlock_bh(&se_tpg->session_lock);
 
+	if (sess->sess_ops->ErrorRecoveryLevel == 2)
+		iscsit_free_connection_recovery_entries(sess);
+
 	/*
 	 * transport_deregister_session_configfs() will clear the
 	 * struct se_node_acl->nacl_sess pointer now as a iscsi_np process context
@@ -4554,9 +4557,6 @@ int iscsit_close_session(struct iscsit_session *sess, bool can_sleep)
 
 	transport_deregister_session(sess->se_sess);
 
-	if (sess->sess_ops->ErrorRecoveryLevel == 2)
-		iscsit_free_connection_recovery_entries(sess);
-
 	iscsit_free_all_ooo_cmdsns(sess);
 
 	spin_lock_bh(&se_tpg->session_lock);
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index cfebec107f3f..0a525f44ea31 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -54,6 +54,21 @@ static int ring_interrupt_index(const struct tb_ring *ring)
 	return bit;
 }
 
+static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring)
+{
+	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
+		return;
+	iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
+}
+
+static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)
+{
+	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
+		ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + ring);
+	else
+		iowrite32(~0, nhi->iobase + REG_RING_INT_CLEAR + ring);
+}
+
 /*
  * ring_interrupt_active() - activate/deactivate interrupts for a single ring
  *
@@ -61,8 +76,8 @@ static int ring_interrupt_index(const struct tb_ring *ring)
  */
 static void ring_interrupt_active(struct tb_ring *ring, bool active)
 {
-	int reg = REG_RING_INTERRUPT_BASE +
-		  ring_interrupt_index(ring) / 32 * 4;
+	int index = ring_interrupt_index(ring) / 32 * 4;
+	int reg = REG_RING_INTERRUPT_BASE + index;
 	int interrupt_bit = ring_interrupt_index(ring) & 31;
 	int mask = 1 << interrupt_bit;
 	u32 old, new;
@@ -123,7 +138,11 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
 					 "interrupt for %s %d is already %s\n",
 					 RING_TYPE(ring), ring->hop,
 					 active ? "enabled" : "disabled");
-	iowrite32(new, ring->nhi->iobase + reg);
+
+	if (active)
+		iowrite32(new, ring->nhi->iobase + reg);
+	else
+		nhi_mask_interrupt(ring->nhi, mask, index);
 }
 
 /*
@@ -136,11 +155,11 @@ static void nhi_disable_interrupts(struct tb_nhi *nhi)
 	int i = 0;
 	/* disable interrupts */
 	for (i = 0; i < RING_INTERRUPT_REG_COUNT(nhi); i++)
-		iowrite32(0, nhi->iobase + REG_RING_INTERRUPT_BASE + 4 * i);
+		nhi_mask_interrupt(nhi, ~0, 4 * i);
 
 	/* clear interrupt status bits */
 	for (i = 0; i < RING_NOTIFY_REG_COUNT(nhi); i++)
-		ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + 4 * i);
+		nhi_clear_interrupt(nhi, 4 * i);
 }
 
 /* ring helper methods */
diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_regs.h
index faef165a919c..6ba295815477 100644
--- a/drivers/thunderbolt/nhi_regs.h
+++ b/drivers/thunderbolt/nhi_regs.h
@@ -93,6 +93,8 @@ struct ring_desc {
 #define REG_RING_INTERRUPT_BASE	0x38200
 #define RING_INTERRUPT_REG_COUNT(nhi) ((31 + 2 * nhi->hop_count) / 32)
 
+#define REG_RING_INTERRUPT_MASK_CLEAR_BASE	0x38208
+
 #define REG_INT_THROTTLING_RATE	0x38c00
 
 /* Interrupt Vector Allocation */
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 36e31b96ef4a..ffc7f67e27e3 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1014,7 +1014,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	of_property_read_u32(np, "clock-frequency", &clk_rate);
 
 	/* See if a Baud clock has been specified */
-	baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
+	baud_mux_clk = devm_clk_get(dev, "sw_baud");
 	if (IS_ERR(baud_mux_clk)) {
 		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
@@ -1034,7 +1034,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	if (clk_rate == 0) {
 		dev_err(dev, "clock-frequency or clk not defined\n");
 		ret = -EINVAL;
-		goto release_dma;
+		goto err_clk_disable;
 	}
 
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
@@ -1121,6 +1121,8 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
+err_clk_disable:
+	clk_disable_unprepare(baud_mux_clk);
 release_dma:
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
@@ -1135,6 +1137,7 @@ static int brcmuart_remove(struct platform_device *pdev)
 	hrtimer_cancel(&priv->hrt);
 	serial8250_unregister_port(priv->line);
 	brcmuart_free_bufs(&pdev->dev, priv);
+	clk_disable_unprepare(priv->baud_mux_clk);
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 94fbf0add2ce..81a5dab1a828 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1157,6 +1157,7 @@ void serial8250_unregister_port(int line)
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
 		uart->capabilities = 0;
+		serial8250_init_port(uart);
 		serial8250_apply_quirks(uart);
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 64770c62bbec..b406cba10b0e 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -40,9 +40,13 @@
 #define PCI_DEVICE_ID_COMMTECH_4224PCIE		0x0020
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE		0x0021
 #define PCI_DEVICE_ID_COMMTECH_4222PCIE		0x0022
+
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
 
+#define PCI_SUBDEVICE_ID_USR_2980		0x0128
+#define PCI_SUBDEVICE_ID_USR_2981		0x0129
+
 #define PCI_DEVICE_ID_SEALEVEL_710xC		0x1001
 #define PCI_DEVICE_ID_SEALEVEL_720xC		0x1002
 #define PCI_DEVICE_ID_SEALEVEL_740xC		0x1004
@@ -829,6 +833,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 		(kernel_ulong_t)&bd			\
 	}
 
+#define USR_DEVICE(devid, sdevid, bd) {			\
+	PCI_DEVICE_SUB(					\
+		PCI_VENDOR_ID_USR,			\
+		PCI_DEVICE_ID_EXAR_##devid,		\
+		PCI_VENDOR_ID_EXAR,			\
+		PCI_SUBDEVICE_ID_USR_##sdevid), 0, 0,	\
+		(kernel_ulong_t)&bd			\
+	}
+
 static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
 	EXAR_DEVICE(ACCESSIO, COM_4S, pbn_exar_XR17C15x),
@@ -853,6 +866,10 @@ static const struct pci_device_id exar_pci_tbl[] = {
 
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
 
+	/* USRobotics USR298x-OEM PCI Modems */
+	USR_DEVICE(XR17C152, 2980, pbn_exar_XR17C15x),
+	USR_DEVICE(XR17C152, 2981, pbn_exar_XR17C15x),
+
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
 	EXAR_DEVICE(EXAR, XR17C152, pbn_exar_XR17C15x),
 	EXAR_DEVICE(EXAR, XR17C154, pbn_exar_XR17C15x),
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 8e9f247590bd..cd27821f54ec 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1940,6 +1940,8 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCI_SUBDEVICE_ID_SIIG_DUAL_30	0x2530
 #define PCI_VENDOR_ID_ADVANTECH		0x13fe
 #define PCI_DEVICE_ID_INTEL_CE4100_UART 0x2e66
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600	0x1600
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600_1611	0x1611
 #define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
 #define PCI_DEVICE_ID_ADVANTECH_PCI3618	0x3618
 #define PCI_DEVICE_ID_ADVANTECH_PCIf618	0xf618
@@ -4105,6 +4107,9 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
 			 pciserial_resume_one);
 
 static const struct pci_device_id serial_pci_tbl[] = {
+	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI1600,
+		PCI_DEVICE_ID_ADVANTECH_PCI1600_1611, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
 	/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
 	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
 		PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 2a65ea2660e1..f3ccc59d8c1f 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -607,10 +607,11 @@ static int arc_serial_probe(struct platform_device *pdev)
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
 
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7905935b9f1b..cf9dc2ddfe66 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1483,19 +1483,18 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, port);
 	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
 
-	ret = uart_add_one_port(drv, uport);
-	if (ret)
-		return ret;
-
 	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
 			IRQF_TRIGGER_HIGH, port->name, uport);
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
-		uart_remove_one_port(drv, uport);
 		return ret;
 	}
 
+	ret = uart_add_one_port(drv, uport);
+	if (ret)
+		return ret;
+
 	/*
 	 * Set pm_runtime status as ACTIVE so that wakeup_irq gets
 	 * enabled/disabled from dev_pm_arm_wake_irq during system
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 1dc07f9214d5..01c96537fa36 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -656,10 +656,17 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 			}
 		}
 
-		/* The vcs_size might have changed while we slept to grab
-		 * the user buffer, so recheck.
+		/* The vc might have been freed or vcs_size might have changed
+		 * while we slept to grab the user buffer, so recheck.
 		 * Return data written up to now on failure.
 		 */
+		vc = vcs_vc(inode, &viewed);
+		if (!vc) {
+			if (written)
+				break;
+			ret = -ENXIO;
+			goto unlock_out;
+		}
 		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d89ce7fb6b36..977bd4b9dd0b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9058,8 +9058,16 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 			 * that performance might be impacted.
 			 */
 			ret = ufshcd_urgent_bkops(hba);
-			if (ret)
+			if (ret) {
+				/*
+				 * If return err in suspend flow, IO will hang.
+				 * Trigger error handler and break suspend for
+				 * error recovery.
+				 */
+				ufshcd_force_error_recovery(hba);
+				ret = -EBUSY;
 				goto enable_scaling;
+			}
 		} else {
 			/* make sure that auto bkops is disabled */
 			ufshcd_disable_auto_bkops(hba);
diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 1c91f43e15c8..9c911787f84c 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -607,6 +607,7 @@ static const struct pci_device_id ufshcd_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x51FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x54FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x7E47), (kernel_ulong_t)&ufs_intel_mtl_hba_vops },
+	{ PCI_VDEVICE(INTEL, 0xA847), (kernel_ulong_t)&ufs_intel_mtl_hba_vops },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 4bb6d304eb4b..311007b1d904 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1928,6 +1928,8 @@ static int usbtmc_ioctl_request(struct usbtmc_device_data *data,
 
 	if (request.req.wLength > USBTMC_BUFSIZE)
 		return -EMSGSIZE;
+	if (request.req.wLength == 0)	/* Length-0 requests are never IN */
+		request.req.bRequestType &= ~USB_DIR_IN;
 
 	is_in = request.req.bRequestType & USB_DIR_IN;
 
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index 850df0e6bcab..f0ffd2e5c642 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -327,6 +327,11 @@ static int dwc3_lsp_show(struct seq_file *s, void *unused)
 	unsigned int		current_mode;
 	unsigned long		flags;
 	u32			reg;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_GSTS);
@@ -345,6 +350,8 @@ static int dwc3_lsp_show(struct seq_file *s, void *unused)
 	}
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -390,6 +397,11 @@ static int dwc3_mode_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = s->private;
 	unsigned long		flags;
 	u32			reg;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
@@ -409,6 +421,8 @@ static int dwc3_mode_show(struct seq_file *s, void *unused)
 		seq_printf(s, "UNKNOWN %08x\n", DWC3_GCTL_PRTCAP(reg));
 	}
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -458,6 +472,11 @@ static int dwc3_testmode_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = s->private;
 	unsigned long		flags;
 	u32			reg;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -488,6 +507,8 @@ static int dwc3_testmode_show(struct seq_file *s, void *unused)
 		seq_printf(s, "UNKNOWN %d\n", reg);
 	}
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -504,6 +525,7 @@ static ssize_t dwc3_testmode_write(struct file *file,
 	unsigned long		flags;
 	u32			testmode = 0;
 	char			buf[32];
+	int			ret;
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
@@ -521,10 +543,16 @@ static ssize_t dwc3_testmode_write(struct file *file,
 	else
 		testmode = 0;
 
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_gadget_set_test_mode(dwc, testmode);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return count;
 }
 
@@ -543,12 +571,18 @@ static int dwc3_link_state_show(struct seq_file *s, void *unused)
 	enum dwc3_link_state	state;
 	u32			reg;
 	u8			speed;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_GSTS);
 	if (DWC3_GSTS_CURMOD(reg) != DWC3_GSTS_CURMOD_DEVICE) {
 		seq_puts(s, "Not available\n");
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		pm_runtime_put_sync(dwc->dev);
 		return 0;
 	}
 
@@ -561,6 +595,8 @@ static int dwc3_link_state_show(struct seq_file *s, void *unused)
 		   dwc3_gadget_hs_link_string(state));
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -579,6 +615,7 @@ static ssize_t dwc3_link_state_write(struct file *file,
 	char			buf[32];
 	u32			reg;
 	u8			speed;
+	int			ret;
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
@@ -598,10 +635,15 @@ static ssize_t dwc3_link_state_write(struct file *file,
 	else
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_GSTS);
 	if (DWC3_GSTS_CURMOD(reg) != DWC3_GSTS_CURMOD_DEVICE) {
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		pm_runtime_put_sync(dwc->dev);
 		return -EINVAL;
 	}
 
@@ -611,12 +653,15 @@ static ssize_t dwc3_link_state_write(struct file *file,
 	if (speed < DWC3_DSTS_SUPERSPEED &&
 	    state != DWC3_LINK_STATE_RECOV) {
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		pm_runtime_put_sync(dwc->dev);
 		return -EINVAL;
 	}
 
 	dwc3_gadget_set_link_state(dwc, state);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return count;
 }
 
@@ -640,6 +685,11 @@ static int dwc3_tx_fifo_size_show(struct seq_file *s, void *unused)
 	unsigned long		flags;
 	u32			mdwidth;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_TXFIFO);
@@ -652,6 +702,8 @@ static int dwc3_tx_fifo_size_show(struct seq_file *s, void *unused)
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -662,6 +714,11 @@ static int dwc3_rx_fifo_size_show(struct seq_file *s, void *unused)
 	unsigned long		flags;
 	u32			mdwidth;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_RXFIFO);
@@ -674,6 +731,8 @@ static int dwc3_rx_fifo_size_show(struct seq_file *s, void *unused)
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -683,12 +742,19 @@ static int dwc3_tx_request_queue_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_TXREQQ);
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -698,12 +764,19 @@ static int dwc3_rx_request_queue_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_RXREQQ);
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -713,12 +786,19 @@ static int dwc3_rx_info_queue_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_RXINFOQ);
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -728,12 +808,19 @@ static int dwc3_descriptor_fetch_queue_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_DESCFETCHQ);
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -743,12 +830,19 @@ static int dwc3_event_queue_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	u32			val;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	val = dwc3_core_fifo_space(dep, DWC3_EVENTQ);
 	seq_printf(s, "%u\n", val);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -793,6 +887,11 @@ static int dwc3_trb_ring_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = dep->dwc;
 	unsigned long		flags;
 	int			i;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	if (dep->number <= 1) {
@@ -822,6 +921,8 @@ static int dwc3_trb_ring_show(struct seq_file *s, void *unused)
 out:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -834,6 +935,11 @@ static int dwc3_ep_info_register_show(struct seq_file *s, void *unused)
 	u32			lower_32_bits;
 	u32			upper_32_bits;
 	u32			reg;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = DWC3_GDBGLSPMUX_EPSELECT(dep->number);
@@ -846,6 +952,8 @@ static int dwc3_ep_info_register_show(struct seq_file *s, void *unused)
 	seq_printf(s, "0x%016llx\n", ep_info);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	pm_runtime_put_sync(dwc->dev);
+
 	return 0;
 }
 
@@ -905,6 +1013,7 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
 	dwc->regset->regs = dwc3_regs;
 	dwc->regset->nregs = ARRAY_SIZE(dwc3_regs);
 	dwc->regset->base = dwc->regs - DWC3_GLOBALS_REGS_START;
+	dwc->regset->dev = dwc->dev;
 
 	root = debugfs_create_dir(dev_name(dwc->dev), usb_debug_root);
 	dwc->debug_root = root;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index daa767383355..d12cb8f0d1f4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2587,6 +2587,21 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	return ret;
 }
 
+static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
+{
+	/*
+	 * In the Synopsys DWC_usb31 1.90a programming guide section
+	 * 4.1.9, it specifies that for a reconnect after a
+	 * device-initiated disconnect requires a core soft reset
+	 * (DCTL.CSftRst) before enabling the run/stop bit.
+	 */
+	dwc3_core_soft_reset(dwc);
+
+	dwc3_event_buffers_setup(dwc);
+	__dwc3_gadget_start(dwc);
+	return dwc3_gadget_run_stop(dwc, true);
+}
+
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -2625,21 +2640,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	synchronize_irq(dwc->irq_gadget);
 
-	if (!is_on) {
+	if (!is_on)
 		ret = dwc3_gadget_soft_disconnect(dwc);
-	} else {
-		/*
-		 * In the Synopsys DWC_usb31 1.90a programming guide section
-		 * 4.1.9, it specifies that for a reconnect after a
-		 * device-initiated disconnect requires a core soft reset
-		 * (DCTL.CSftRst) before enabling the run/stop bit.
-		 */
-		dwc3_core_soft_reset(dwc);
-
-		dwc3_event_buffers_setup(dwc);
-		__dwc3_gadget_start(dwc);
-		ret = dwc3_gadget_run_stop(dwc, true);
-	}
+	else
+		ret = dwc3_gadget_soft_connect(dwc);
 
 	pm_runtime_put(dwc->dev);
 
@@ -4555,42 +4559,39 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int ret;
 
 	if (!dwc->gadget_driver)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false);
+	ret = dwc3_gadget_soft_disconnect(dwc);
+	if (ret)
+		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
-	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
+
+err:
+	/*
+	 * Attempt to reset the controller's state. Likely no
+	 * communication can be established until the host
+	 * performs a port reset.
+	 */
+	if (dwc->softconnect)
+		dwc3_gadget_soft_connect(dwc);
+
+	return ret;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
 {
-	int			ret;
-
 	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
-	ret = __dwc3_gadget_start(dwc);
-	if (ret < 0)
-		goto err0;
-
-	ret = dwc3_gadget_run_stop(dwc, true);
-	if (ret < 0)
-		goto err1;
-
-	return 0;
-
-err1:
-	__dwc3_gadget_stop(dwc);
-
-err0:
-	return ret;
+	return dwc3_gadget_soft_connect(dwc);
 }
 
 void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index e06022873df1..1f420ff8f423 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -17,6 +17,7 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
+#include <linux/string_helpers.h>
 
 #include "u_ether.h"
 
@@ -978,6 +979,8 @@ int gether_get_host_addr_cdc(struct net_device *net, char *host_addr, int len)
 	dev = netdev_priv(net);
 	snprintf(host_addr, len, "%pm", dev->host_mac);
 
+	string_upper(host_addr, host_addr);
+
 	return strlen(host_addr);
 }
 EXPORT_SYMBOL_GPL(gether_get_host_addr_cdc);
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index e85706812d61..bf9878e1a72a 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -37,10 +37,6 @@ static struct bus_type gadget_bus_type;
  * @vbus: for udcs who care about vbus status, this value is real vbus status;
  * for udcs who do not care about vbus status, this value is always true
  * @started: the UDC's started state. True if the UDC had started.
- * @connect_lock: protects udc->vbus, udc->started, gadget->connect, gadget->deactivate related
- * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
- * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_gadget_udc_stop_locked are
- * called with this lock held.
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -52,7 +48,6 @@ struct usb_udc {
 	struct list_head		list;
 	bool				vbus;
 	bool				started;
-	struct mutex			connect_lock;
 };
 
 static struct class *udc_class;
@@ -665,9 +660,17 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
 
-/* Internal version of usb_gadget_connect needs to be called with connect_lock held. */
-static int usb_gadget_connect_locked(struct usb_gadget *gadget)
-	__must_hold(&gadget->udc->connect_lock)
+/**
+ * usb_gadget_connect - software-controlled connect to USB host
+ * @gadget:the peripheral being connected
+ *
+ * Enables the D+ (or potentially D-) pullup.  The host will start
+ * enumerating this gadget when the pullup is active and a VBUS session
+ * is active (the link is powered).
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_connect(struct usb_gadget *gadget)
 {
 	int ret = 0;
 
@@ -676,15 +679,10 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
 		goto out;
 	}
 
-	if (gadget->connected)
-		goto out;
-
-	if (gadget->deactivated || !gadget->udc->started) {
+	if (gadget->deactivated) {
 		/*
 		 * If gadget is deactivated we only save new state.
 		 * Gadget will be connected automatically after activation.
-		 *
-		 * udc first needs to be started before gadget can be pulled up.
 		 */
 		gadget->connected = true;
 		goto out;
@@ -699,32 +697,22 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(usb_gadget_connect);
 
 /**
- * usb_gadget_connect - software-controlled connect to USB host
- * @gadget:the peripheral being connected
+ * usb_gadget_disconnect - software-controlled disconnect from USB host
+ * @gadget:the peripheral being disconnected
  *
- * Enables the D+ (or potentially D-) pullup.  The host will start
- * enumerating this gadget when the pullup is active and a VBUS session
- * is active (the link is powered).
+ * Disables the D+ (or potentially D-) pullup, which the host may see
+ * as a disconnect (when a VBUS session is active).  Not all systems
+ * support software pullup controls.
+ *
+ * Following a successful disconnect, invoke the ->disconnect() callback
+ * for the current gadget driver so that UDC drivers don't need to.
  *
  * Returns zero on success, else negative errno.
  */
-int usb_gadget_connect(struct usb_gadget *gadget)
-{
-	int ret;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	ret = usb_gadget_connect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_connect);
-
-/* Internal version of usb_gadget_disconnect needs to be called with connect_lock held. */
-static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
-	__must_hold(&gadget->udc->connect_lock)
+int usb_gadget_disconnect(struct usb_gadget *gadget)
 {
 	int ret = 0;
 
@@ -736,12 +724,10 @@ static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
 	if (!gadget->connected)
 		goto out;
 
-	if (gadget->deactivated || !gadget->udc->started) {
+	if (gadget->deactivated) {
 		/*
 		 * If gadget is deactivated we only save new state.
 		 * Gadget will stay disconnected after activation.
-		 *
-		 * udc should have been started before gadget being pulled down.
 		 */
 		gadget->connected = false;
 		goto out;
@@ -761,30 +747,6 @@ static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
 
 	return ret;
 }
-
-/**
- * usb_gadget_disconnect - software-controlled disconnect from USB host
- * @gadget:the peripheral being disconnected
- *
- * Disables the D+ (or potentially D-) pullup, which the host may see
- * as a disconnect (when a VBUS session is active).  Not all systems
- * support software pullup controls.
- *
- * Following a successful disconnect, invoke the ->disconnect() callback
- * for the current gadget driver so that UDC drivers don't need to.
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_disconnect(struct usb_gadget *gadget)
-{
-	int ret;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	ret = usb_gadget_disconnect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
-
-	return ret;
-}
 EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
 
 /**
@@ -805,11 +767,10 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 	if (gadget->deactivated)
 		goto out;
 
-	mutex_lock(&gadget->udc->connect_lock);
 	if (gadget->connected) {
-		ret = usb_gadget_disconnect_locked(gadget);
+		ret = usb_gadget_disconnect(gadget);
 		if (ret)
-			goto unlock;
+			goto out;
 
 		/*
 		 * If gadget was being connected before deactivation, we want
@@ -819,8 +780,6 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 	}
 	gadget->deactivated = true;
 
-unlock:
-	mutex_unlock(&gadget->udc->connect_lock);
 out:
 	trace_usb_gadget_deactivate(gadget, ret);
 
@@ -844,7 +803,6 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 	if (!gadget->deactivated)
 		goto out;
 
-	mutex_lock(&gadget->udc->connect_lock);
 	gadget->deactivated = false;
 
 	/*
@@ -852,8 +810,7 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 	 * while it was being deactivated, we call usb_gadget_connect().
 	 */
 	if (gadget->connected)
-		ret = usb_gadget_connect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
+		ret = usb_gadget_connect(gadget);
 
 out:
 	trace_usb_gadget_activate(gadget, ret);
@@ -1094,13 +1051,12 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
 /* ------------------------------------------------------------------------- */
 
-/* Acquire connect_lock before calling this function. */
-static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
+static void usb_udc_connect_control(struct usb_udc *udc)
 {
-	if (udc->vbus && udc->started)
-		usb_gadget_connect_locked(udc->gadget);
+	if (udc->vbus)
+		usb_gadget_connect(udc->gadget);
 	else
-		usb_gadget_disconnect_locked(udc->gadget);
+		usb_gadget_disconnect(udc->gadget);
 }
 
 /**
@@ -1116,12 +1072,10 @@ void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 {
 	struct usb_udc *udc = gadget->udc;
 
-	mutex_lock(&udc->connect_lock);
 	if (udc) {
 		udc->vbus = status;
-		usb_udc_connect_control_locked(udc);
+		usb_udc_connect_control(udc);
 	}
-	mutex_unlock(&udc->connect_lock);
 }
 EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
 
@@ -1143,7 +1097,7 @@ void usb_gadget_udc_reset(struct usb_gadget *gadget,
 EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
 
 /**
- * usb_gadget_udc_start_locked - tells usb device controller to start up
+ * usb_gadget_udc_start - tells usb device controller to start up
  * @udc: The UDC to be started
  *
  * This call is issued by the UDC Class driver when it's about
@@ -1154,11 +1108,8 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
  * necessary to have it powered on.
  *
  * Returns zero on success, else negative errno.
- *
- * Caller should acquire connect_lock before invoking this function.
  */
-static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
-	__must_hold(&udc->connect_lock)
+static inline int usb_gadget_udc_start(struct usb_udc *udc)
 {
 	int ret;
 
@@ -1175,7 +1126,7 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
 }
 
 /**
- * usb_gadget_udc_stop_locked - tells usb device controller we don't need it anymore
+ * usb_gadget_udc_stop - tells usb device controller we don't need it anymore
  * @udc: The UDC to be stopped
  *
  * This call is issued by the UDC Class driver after calling
@@ -1184,11 +1135,8 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
  * The details are implementation specific, but it can go as
  * far as powering off UDC completely and disable its data
  * line pullups.
- *
- * Caller should acquire connect lock before invoking this function.
  */
-static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
-	__must_hold(&udc->connect_lock)
+static inline void usb_gadget_udc_stop(struct usb_udc *udc)
 {
 	if (!udc->started) {
 		dev_err(&udc->dev, "UDC had already stopped\n");
@@ -1347,7 +1295,6 @@ int usb_add_gadget(struct usb_gadget *gadget)
 
 	udc->gadget = gadget;
 	gadget->udc = udc;
-	mutex_init(&udc->connect_lock);
 
 	udc->started = false;
 
@@ -1549,15 +1496,11 @@ static int gadget_bind_driver(struct device *dev)
 	if (ret)
 		goto err_bind;
 
-	mutex_lock(&udc->connect_lock);
-	ret = usb_gadget_udc_start_locked(udc);
-	if (ret) {
-		mutex_unlock(&udc->connect_lock);
+	ret = usb_gadget_udc_start(udc);
+	if (ret)
 		goto err_start;
-	}
 	usb_gadget_enable_async_callbacks(udc);
-	usb_udc_connect_control_locked(udc);
-	mutex_unlock(&udc->connect_lock);
+	usb_udc_connect_control(udc);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
@@ -1588,14 +1531,12 @@ static void gadget_unbind_driver(struct device *dev)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
-	mutex_lock(&udc->connect_lock);
-	usb_gadget_disconnect_locked(gadget);
+	usb_gadget_disconnect(gadget);
 	usb_gadget_disable_async_callbacks(udc);
 	if (gadget->irq)
 		synchronize_irq(gadget->irq);
 	udc->driver->unbind(gadget);
-	usb_gadget_udc_stop_locked(udc);
-	mutex_unlock(&udc->connect_lock);
+	usb_gadget_udc_stop(udc);
 
 	mutex_lock(&udc_lock);
 	driver->is_bound = false;
@@ -1681,15 +1622,11 @@ static ssize_t soft_connect_store(struct device *dev,
 	}
 
 	if (sysfs_streq(buf, "connect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_udc_start_locked(udc);
-		usb_gadget_connect_locked(udc->gadget);
-		mutex_unlock(&udc->connect_lock);
+		usb_gadget_udc_start(udc);
+		usb_gadget_connect(udc->gadget);
 	} else if (sysfs_streq(buf, "disconnect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_disconnect_locked(udc->gadget);
-		usb_gadget_udc_stop_locked(udc);
-		mutex_unlock(&udc->connect_lock);
+		usb_gadget_disconnect(udc->gadget);
+		usb_gadget_udc_stop(udc);
 	} else {
 		dev_err(dev, "unsupported command '%s'\n", buf);
 		ret = -EINVAL;
diff --git a/drivers/usb/host/uhci-pci.c b/drivers/usb/host/uhci-pci.c
index 3592f757fe05..7bd2fddde770 100644
--- a/drivers/usb/host/uhci-pci.c
+++ b/drivers/usb/host/uhci-pci.c
@@ -119,11 +119,13 @@ static int uhci_pci_init(struct usb_hcd *hcd)
 
 	uhci->rh_numports = uhci_count_ports(hcd);
 
-	/* Intel controllers report the OverCurrent bit active on.
-	 * VIA controllers report it active off, so we'll adjust the
-	 * bit value.  (It's not standardized in the UHCI spec.)
+	/*
+	 * Intel controllers report the OverCurrent bit active on.  VIA
+	 * and ZHAOXIN controllers report it active off, so we'll adjust
+	 * the bit value.  (It's not standardized in the UHCI spec.)
 	 */
-	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_VIA)
+	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_VIA ||
+			to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_ZHAOXIN)
 		uhci->oc_low = 1;
 
 	/* HP's server management chip requires a longer port reset delay. */
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 232e175e4e96..6e4dac71c409 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/reset.h>
+#include <linux/suspend.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
@@ -194,7 +195,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
 		pdev->device == PCI_DEVICE_ID_AMD_RENOIR_XHCI)
-		xhci->quirks |= XHCI_BROKEN_D3COLD;
+		xhci->quirks |= XHCI_BROKEN_D3COLD_S2I;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
@@ -609,9 +610,16 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 	 * Systems with the TI redriver that loses port status change events
 	 * need to have the registers polled during D3, so avoid D3cold.
 	 */
-	if (xhci->quirks & (XHCI_COMP_MODE_QUIRK | XHCI_BROKEN_D3COLD))
+	if (xhci->quirks & XHCI_COMP_MODE_QUIRK)
 		pci_d3cold_disable(pdev);
 
+#ifdef CONFIG_SUSPEND
+	/* d3cold is broken, but only when s2idle is used */
+	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
+	    xhci->quirks & (XHCI_BROKEN_D3COLD_S2I))
+		pci_d3cold_disable(pdev);
+#endif
+
 	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
 		xhci_pme_quirk(hcd);
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index dce02d0aad8d..7a7ab525675b 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -276,6 +276,26 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	trace_xhci_inc_enq(ring);
 }
 
+static int xhci_num_trbs_to(struct xhci_segment *start_seg, union xhci_trb *start,
+			    struct xhci_segment *end_seg, union xhci_trb *end,
+			    unsigned int num_segs)
+{
+	union xhci_trb *last_on_seg;
+	int num = 0;
+	int i = 0;
+
+	do {
+		if (start_seg == end_seg && end >= start)
+			return num + (end - start);
+		last_on_seg = &start_seg->trbs[TRBS_PER_SEGMENT - 1];
+		num += last_on_seg - start;
+		start_seg = start_seg->next;
+		start = start_seg->trbs;
+	} while (i++ <= num_segs);
+
+	return -EINVAL;
+}
+
 /*
  * Check to see if there's room to enqueue num_trbs on the ring and make sure
  * enqueue pointer will not advance into dequeue segment. See rules above.
@@ -2141,6 +2161,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		     u32 trb_comp_code)
 {
 	struct xhci_ep_ctx *ep_ctx;
+	int trbs_freed;
 
 	ep_ctx = xhci_get_ep_ctx(xhci, ep->vdev->out_ctx, ep->ep_index);
 
@@ -2212,9 +2233,15 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	}
 
 	/* Update ring dequeue pointer */
+	trbs_freed = xhci_num_trbs_to(ep_ring->deq_seg, ep_ring->dequeue,
+				      td->last_trb_seg, td->last_trb,
+				      ep_ring->num_segs);
+	if (trbs_freed < 0)
+		xhci_dbg(xhci, "Failed to count freed trbs at TD finish\n");
+	else
+		ep_ring->num_trbs_free += trbs_freed;
 	ep_ring->dequeue = td->last_trb;
 	ep_ring->deq_seg = td->last_trb_seg;
-	ep_ring->num_trbs_free += td->num_trbs - 1;
 	inc_deq(xhci, ep_ring);
 
 	return xhci_td_cleanup(xhci, td, ep_ring, td->status);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index dcee7f3207ad..6348cacdc65e 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1895,7 +1895,7 @@ struct xhci_hcd {
 #define XHCI_DISABLE_SPARSE	BIT_ULL(38)
 #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
 #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
-#define XHCI_BROKEN_D3COLD	BIT_ULL(41)
+#define XHCI_BROKEN_D3COLD_S2I	BIT_ULL(41)
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 8931df5a85fd..c54e9805da53 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -406,22 +406,25 @@ static DEF_SCSI_QCMD(queuecommand)
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
 
@@ -444,6 +447,14 @@ static int command_abort(struct scsi_cmnd *srb)
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
@@ -455,6 +466,9 @@ static int device_reset(struct scsi_cmnd *srb)
 
 	usb_stor_dbg(us, "%s called\n", __func__);
 
+	/* abort any pending command before reset */
+	command_abort_matching(us, NULL);
+
 	/* lock the device pointers and do the reset */
 	mutex_lock(&(us->dev_mutex));
 	result = us->transport_reset(us);
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 4075c0d7e6a2..7cdf83f4c811 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -513,6 +513,10 @@ static ssize_t pin_assignment_show(struct device *dev,
 
 	mutex_unlock(&dp->lock);
 
+	/* get_current_pin_assignments can return 0 when no matching pin assignments are found */
+	if (len == 0)
+		len++;
+
 	buf[len - 1] = '\n';
 	return len;
 }
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 032d21a96779..524099634a1d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1514,7 +1514,21 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
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
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 62206a6b8ea7..217355f1f9b9 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #include "ucsi.h"
 
@@ -23,6 +24,7 @@ struct ucsi_acpi {
 	struct completion complete;
 	unsigned long flags;
 	guid_t guid;
+	u64 cmd;
 };
 
 static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
@@ -62,6 +64,7 @@ static int ucsi_acpi_async_write(struct ucsi *ucsi, unsigned int offset,
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 
 	memcpy(ua->base + offset, val, val_len);
+	ua->cmd = *(u64 *)val;
 
 	return ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_WRITE);
 }
@@ -93,13 +96,46 @@ static const struct ucsi_operations ucsi_acpi_ops = {
 	.async_write = ucsi_acpi_async_write
 };
 
+static int
+ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_len)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	if (offset == UCSI_VERSION || UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
+		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
+		if (ret)
+			return ret;
+	}
+
+	memcpy(val, ua->base + offset, val_len);
+
+	return 0;
+}
+
+static const struct ucsi_operations ucsi_zenbook_ops = {
+	.read = ucsi_zenbook_read,
+	.sync_write = ucsi_acpi_sync_write,
+	.async_write = ucsi_acpi_async_write
+};
+
+static const struct dmi_system_id zenbook_dmi_id[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
+		},
+	},
+	{ }
+};
+
 static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ucsi_acpi *ua = data;
 	u32 cci;
 	int ret;
 
-	ret = ucsi_acpi_read(ua->ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = ua->ucsi->ops->read(ua->ucsi, UCSI_CCI, &cci, sizeof(cci));
 	if (ret)
 		return;
 
@@ -114,6 +150,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 static int ucsi_acpi_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	const struct ucsi_operations *ops = &ucsi_acpi_ops;
 	struct ucsi_acpi *ua;
 	struct resource *res;
 	acpi_status status;
@@ -143,7 +180,10 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	init_completion(&ua->complete);
 	ua->dev = &pdev->dev;
 
-	ua->ucsi = ucsi_create(&pdev->dev, &ucsi_acpi_ops);
+	if (dmi_check_system(zenbook_dmi_id))
+		ops = &ucsi_zenbook_ops;
+
+	ua->ucsi = ucsi_create(&pdev->dev, ops);
 	if (IS_ERR(ua->ucsi))
 		return PTR_ERR(ua->ucsi);
 
diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 45e64016db32..024d0ee4f04f 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -523,7 +523,7 @@ static int arcfb_probe(struct platform_device *dev)
 
 	info = framebuffer_alloc(sizeof(struct arcfb_par), &dev->dev);
 	if (!info)
-		goto err;
+		goto err_fb_alloc;
 
 	info->screen_base = (char __iomem *)videomemory;
 	info->fbops = &arcfb_ops;
@@ -535,7 +535,7 @@ static int arcfb_probe(struct platform_device *dev)
 
 	if (!dio_addr || !cio_addr || !c2io_addr) {
 		printk(KERN_WARNING "no IO addresses supplied\n");
-		goto err1;
+		goto err_addr;
 	}
 	par->dio_addr = dio_addr;
 	par->cio_addr = cio_addr;
@@ -551,12 +551,12 @@ static int arcfb_probe(struct platform_device *dev)
 			printk(KERN_INFO
 				"arcfb: Failed req IRQ %d\n", par->irq);
 			retval = -EBUSY;
-			goto err1;
+			goto err_addr;
 		}
 	}
 	retval = register_framebuffer(info);
 	if (retval < 0)
-		goto err1;
+		goto err_register_fb;
 	platform_set_drvdata(dev, info);
 	fb_info(info, "Arc frame buffer device, using %dK of video memory\n",
 		videomemorysize >> 10);
@@ -580,9 +580,12 @@ static int arcfb_probe(struct platform_device *dev)
 	}
 
 	return 0;
-err1:
+
+err_register_fb:
+	free_irq(par->irq, info);
+err_addr:
 	framebuffer_release(info);
-err:
+err_fb_alloc:
 	vfree(videomemory);
 	return retval;
 }
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 87007203f130..0b236ebd989f 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1111,6 +1111,19 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
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
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 157d3c0e3cc7..6ec1a34738e2 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -428,8 +428,8 @@ struct smb_version_operations {
 	/* check for STATUS_NETWORK_SESSION_EXPIRED */
 	bool (*is_session_expired)(char *);
 	/* send oplock break response */
-	int (*oplock_response)(struct cifs_tcon *, struct cifs_fid *,
-			       struct cifsInodeInfo *);
+	int (*oplock_response)(struct cifs_tcon *tcon, __u64 persistent_fid, __u64 volatile_fid,
+			__u16 net_fid, struct cifsInodeInfo *cifs_inode);
 	/* query remote filesystem */
 	int (*queryfs)(const unsigned int, struct cifs_tcon *,
 		       struct cifs_sb_info *, struct kstatfs *);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 158a0a5f4007..9a4c33ffb75f 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -5086,9 +5086,9 @@ void cifs_oplock_break(struct work_struct *work)
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
 	int rc = 0;
-	bool purge_cache = false;
-	struct cifs_deferred_close *dclose;
-	bool is_deferred = false;
+	bool purge_cache = false, oplock_break_cancelled;
+	__u64 persistent_fid, volatile_fid;
+	__u16 net_fid;
 
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
@@ -5129,28 +5129,28 @@ void cifs_oplock_break(struct work_struct *work)
 	 * file handles but cached, then schedule deferred close immediately.
 	 * So, new open will not use cached handle.
 	 */
-	spin_lock(&CIFS_I(inode)->deferred_lock);
-	is_deferred = cifs_is_deferred_close(cfile, &dclose);
-	spin_unlock(&CIFS_I(inode)->deferred_lock);
 
-	if (!CIFS_CACHE_HANDLE(cinode) && is_deferred &&
-			cfile->deferred_close_scheduled && delayed_work_pending(&cfile->deferred)) {
+	if (!CIFS_CACHE_HANDLE(cinode) && !list_empty(&cinode->deferred_closes))
 		cifs_close_deferred_file(cinode);
-	}
 
+	persistent_fid = cfile->fid.persistent_fid;
+	volatile_fid = cfile->fid.volatile_fid;
+	net_fid = cfile->fid.netfid;
+	oplock_break_cancelled = cfile->oplock_break_cancelled;
+
+	_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 	/*
 	 * releasing stale oplock after recent reconnect of smb session using
 	 * a now incorrect file handle is not a data integrity issue but do
 	 * not bother sending an oplock release if session to server still is
 	 * disconnected since oplock already released by the server
 	 */
-	if (!cfile->oplock_break_cancelled) {
-		rc = tcon->ses->server->ops->oplock_response(tcon, &cfile->fid,
-							     cinode);
+	if (!oplock_break_cancelled) {
+		rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
+				volatile_fid, net_fid, cinode);
 		cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
 	}
 
-	_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 	cifs_done_oplock_break(cinode);
 }
 
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index abda6148be10..7d1b3fc014d9 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -897,12 +897,11 @@ cifs_close_dir(const unsigned int xid, struct cifs_tcon *tcon,
 }
 
 static int
-cifs_oplock_response(struct cifs_tcon *tcon, struct cifs_fid *fid,
-		     struct cifsInodeInfo *cinode)
+cifs_oplock_response(struct cifs_tcon *tcon, __u64 persistent_fid,
+		__u64 volatile_fid, __u16 net_fid, struct cifsInodeInfo *cinode)
 {
-	return CIFSSMBLock(0, tcon, fid->netfid, current->tgid, 0, 0, 0, 0,
-			   LOCKING_ANDX_OPLOCK_RELEASE, false,
-			   CIFS_CACHE_READ(cinode) ? 1 : 0);
+	return CIFSSMBLock(0, tcon, net_fid, current->tgid, 0, 0, 0, 0,
+			   LOCKING_ANDX_OPLOCK_RELEASE, false, CIFS_CACHE_READ(cinode) ? 1 : 0);
 }
 
 static int
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 7468f8baf499..d512440d35b6 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2383,15 +2383,14 @@ smb2_is_network_name_deleted(char *buf, struct TCP_Server_Info *server)
 }
 
 static int
-smb2_oplock_response(struct cifs_tcon *tcon, struct cifs_fid *fid,
-		     struct cifsInodeInfo *cinode)
+smb2_oplock_response(struct cifs_tcon *tcon, __u64 persistent_fid,
+		__u64 volatile_fid, __u16 net_fid, struct cifsInodeInfo *cinode)
 {
 	if (tcon->ses->server->capabilities & SMB2_GLOBAL_CAP_LEASING)
 		return SMB2_lease_break(0, tcon, cinode->lease_key,
 					smb2_get_lease_state(cinode));
 
-	return SMB2_oplock_break(0, tcon, fid->persistent_fid,
-				 fid->volatile_fid,
+	return SMB2_oplock_break(0, tcon, persistent_fid, volatile_fid,
 				 CIFS_CACHE_READ(cinode) ? 1 : 0);
 }
 
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 28de11a22e5f..dc5dcb78bc27 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -180,6 +180,7 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_MIN_BLOCK_SIZE		1024
 #define	EXT2_MAX_BLOCK_SIZE		4096
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define EXT2_MAX_BLOCK_LOG_SIZE		  16
 #define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
 #define EXT2_BLOCK_SIZE_BITS(s)		((s)->s_blocksize_bits)
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 03f2af98b1b4..3feea4b31fa7 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -945,6 +945,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
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
 
 	if (test_opt(sb, DAX)) {
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index f2c415f31b75..a38aa33af08e 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -319,6 +319,22 @@ static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
 	return (next_zero_bit < bitmap_size ? next_zero_bit : 0);
 }
 
+struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
+					    ext4_group_t group)
+{
+	 struct ext4_group_info **grp_info;
+	 long indexv, indexh;
+
+	 if (unlikely(group >= EXT4_SB(sb)->s_groups_count)) {
+		 ext4_error(sb, "invalid group %u", group);
+		 return NULL;
+	 }
+	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
+	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
+	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
+	 return grp_info[indexh];
+}
+
 /*
  * Return the block number which was discovered to be invalid, or 0 if
  * the block bitmap is valid.
@@ -393,7 +409,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 
 	if (buffer_verified(bh))
 		return 0;
-	if (EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
+	if (!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a2bc440743ae..2156d2a1a770 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2716,6 +2716,8 @@ extern void ext4_check_blocks_bitmap(struct super_block *);
 extern struct ext4_group_desc * ext4_get_group_desc(struct super_block * sb,
 						    ext4_group_t block_group,
 						    struct buffer_head ** bh);
+extern struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
+						   ext4_group_t group);
 extern int ext4_should_retry_alloc(struct super_block *sb, int *retries);
 
 extern struct buffer_head *ext4_read_block_bitmap_nowait(struct super_block *sb,
@@ -3322,19 +3324,6 @@ static inline void ext4_isize_set(struct ext4_inode *raw_inode, loff_t i_size)
 	raw_inode->i_size_high = cpu_to_le32(i_size >> 32);
 }
 
-static inline
-struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
-					    ext4_group_t group)
-{
-	 struct ext4_group_info **grp_info;
-	 long indexv, indexh;
-	 BUG_ON(group >= EXT4_SB(sb)->s_groups_count);
-	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
-	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
-	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
-	 return grp_info[indexh];
-}
-
 /*
  * Reading s_groups_count requires using smp_rmb() afterwards.  See
  * the locking protocol documented in the comments of ext4_group_add()
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e9bc46684106..e09c74927a43 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -91,7 +91,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 
 	if (buffer_verified(bh))
 		return 0;
-	if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+	if (!grp || EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
@@ -293,7 +293,7 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 	}
 	if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
 		grp = ext4_get_group_info(sb, block_group);
-		if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
+		if (!grp || unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
 			fatal = -EFSCORRUPTED;
 			goto error_return;
 		}
@@ -1047,7 +1047,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 			 * Skip groups with already-known suspicious inode
 			 * tables
 			 */
-			if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+			if (!grp || EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
 				goto next_group;
 		}
 
@@ -1185,6 +1185,10 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 
 		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
 			grp = ext4_get_group_info(sb, group);
+			if (!grp) {
+				err = -EFSCORRUPTED;
+				goto out;
+			}
 			down_read(&grp->alloc_sem); /*
 						     * protect vs itable
 						     * lazyinit
@@ -1528,7 +1532,7 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
 	}
 
 	gdp = ext4_get_group_desc(sb, group, &group_desc_bh);
-	if (!gdp)
+	if (!gdp || !grp)
 		goto out;
 
 	/*
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 912c4a1093fe..32d88757a780 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -745,6 +745,8 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 	MB_CHECK_ASSERT(e4b->bd_info->bb_fragments == fragments);
 
 	grp = ext4_get_group_info(sb, e4b->bd_group);
+	if (!grp)
+		return NULL;
 	list_for_each(cur, &grp->bb_prealloc_list) {
 		ext4_group_t groupnr;
 		struct ext4_prealloc_space *pa;
@@ -1060,9 +1062,9 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 
 static noinline_for_stack
 void ext4_mb_generate_buddy(struct super_block *sb,
-				void *buddy, void *bitmap, ext4_group_t group)
+			    void *buddy, void *bitmap, ext4_group_t group,
+			    struct ext4_group_info *grp)
 {
-	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
 	ext4_grpblk_t i = 0;
@@ -1183,6 +1185,8 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			break;
 
 		grinfo = ext4_get_group_info(sb, group);
+		if (!grinfo)
+			continue;
 		/*
 		 * If page is uptodate then we came here after online resize
 		 * which added some new uninitialized group info structs, so
@@ -1248,6 +1252,10 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 				group, page->index, i * blocksize);
 			trace_ext4_mb_buddy_bitmap_load(sb, group);
 			grinfo = ext4_get_group_info(sb, group);
+			if (!grinfo) {
+				err = -EFSCORRUPTED;
+				goto out;
+			}
 			grinfo->bb_fragments = 0;
 			memset(grinfo->bb_counters, 0,
 			       sizeof(*grinfo->bb_counters) *
@@ -1258,7 +1266,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			ext4_lock_group(sb, group);
 			/* init the buddy */
 			memset(data, 0xff, blocksize);
-			ext4_mb_generate_buddy(sb, data, incore, group);
+			ext4_mb_generate_buddy(sb, data, incore, group, grinfo);
 			ext4_unlock_group(sb, group);
 			incore = NULL;
 		} else {
@@ -1372,6 +1380,9 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	might_sleep();
 	mb_debug(sb, "init group %u\n", group);
 	this_grp = ext4_get_group_info(sb, group);
+	if (!this_grp)
+		return -EFSCORRUPTED;
+
 	/*
 	 * This ensures that we don't reinit the buddy cache
 	 * page which map to the group from which we are already
@@ -1446,6 +1457,8 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
 	grp = ext4_get_group_info(sb, group);
+	if (!grp)
+		return -EFSCORRUPTED;
 
 	e4b->bd_blkbits = sb->s_blocksize_bits;
 	e4b->bd_info = grp;
@@ -2162,7 +2175,9 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct ext4_free_extent ex;
 
-	if (!(ac->ac_flags & EXT4_MB_HINT_TRY_GOAL))
+	if (!grp)
+		return -EFSCORRUPTED;
+	if (!(ac->ac_flags & (EXT4_MB_HINT_TRY_GOAL | EXT4_MB_HINT_GOAL_ONLY)))
 		return 0;
 	if (grp->bb_free == 0)
 		return 0;
@@ -2386,7 +2401,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 
 	BUG_ON(cr < 0 || cr >= 4);
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
 		return false;
 
 	free = grp->bb_free;
@@ -2455,6 +2470,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	ext4_grpblk_t free;
 	int ret = 0;
 
+	if (!grp)
+		return -EFSCORRUPTED;
 	if (sbi->s_mb_stats)
 		atomic64_inc(&sbi->s_bal_cX_groups_considered[ac->ac_criteria]);
 	if (should_lock) {
@@ -2535,7 +2552,7 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 		 * prefetch once, so we avoid getblk() call, which can
 		 * be expensive.
 		 */
-		if (!EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
+		if (gdp && grp && !EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
 		    EXT4_MB_GRP_NEED_INIT(grp) &&
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
@@ -2579,7 +2596,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 		group--;
 		grp = ext4_get_group_info(sb, group);
 
-		if (EXT4_MB_GRP_NEED_INIT(grp) &&
+		if (grp && gdp && EXT4_MB_GRP_NEED_INIT(grp) &&
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
 		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
@@ -2838,6 +2855,8 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 		sizeof(struct ext4_group_info);
 
 	grinfo = ext4_get_group_info(sb, group);
+	if (!grinfo)
+		return 0;
 	/* Load the group info in memory only if not already loaded. */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grinfo))) {
 		err = ext4_mb_load_buddy(sb, group, &e4b);
@@ -2848,7 +2867,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 		buddy_loaded = 1;
 	}
 
-	memcpy(&sg, ext4_get_group_info(sb, group), i);
+	memcpy(&sg, grinfo, i);
 
 	if (buddy_loaded)
 		ext4_mb_unload_buddy(&e4b);
@@ -3210,8 +3229,12 @@ static int ext4_mb_init_backend(struct super_block *sb)
 
 err_freebuddy:
 	cachep = get_groupinfo_cache(sb->s_blocksize_bits);
-	while (i-- > 0)
-		kmem_cache_free(cachep, ext4_get_group_info(sb, i));
+	while (i-- > 0) {
+		struct ext4_group_info *grp = ext4_get_group_info(sb, i);
+
+		if (grp)
+			kmem_cache_free(cachep, grp);
+	}
 	i = sbi->s_group_info_size;
 	rcu_read_lock();
 	group_info = rcu_dereference(sbi->s_group_info);
@@ -3525,6 +3548,8 @@ int ext4_mb_release(struct super_block *sb)
 		for (i = 0; i < ngroups; i++) {
 			cond_resched();
 			grinfo = ext4_get_group_info(sb, i);
+			if (!grinfo)
+				continue;
 			mb_group_bb_bitmap_free(grinfo);
 			ext4_lock_group(sb, i);
 			count = ext4_mb_cleanup_pa(grinfo);
@@ -3993,6 +4018,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 				struct ext4_allocation_request *ar)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
 	ext4_lblk_t end;
 	loff_t size, start_off;
@@ -4188,18 +4214,21 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
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
 
@@ -4292,6 +4321,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
 	BUG_ON(start < pa->pa_pstart);
 	BUG_ON(end > pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len));
 	BUG_ON(pa->pa_free < len);
+	BUG_ON(ac->ac_b_ex.fe_len <= 0);
 	pa->pa_free -= len;
 
 	mb_debug(ac->ac_sb, "use %llu/%d from inode pa %p\n", start, len, pa);
@@ -4454,6 +4484,8 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 	struct ext4_free_data *entry;
 
 	grp = ext4_get_group_info(sb, group);
+	if (!grp)
+		return;
 	n = rb_first(&(grp->bb_free_root));
 
 	while (n) {
@@ -4481,6 +4513,9 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 	int preallocated = 0;
 	int len;
 
+	if (!grp)
+		return;
+
 	/* all form of preallocation discards first load group,
 	 * so the only competing code is preallocation use.
 	 * we don't need any locking here
@@ -4616,10 +4651,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa = ac->ac_pa;
 
 	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len) {
-		int winl;
-		int wins;
-		int win;
-		int offs;
+		int new_bex_start;
+		int new_bex_end;
 
 		/* we can't allocate as much as normalizer wants.
 		 * so, found space must get proper lstart
@@ -4627,26 +4660,40 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
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
@@ -4672,6 +4719,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
 	ei = EXT4_I(ac->ac_inode);
 	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
+	if (!grp)
+		return;
 
 	pa->pa_obj_lock = &ei->i_prealloc_lock;
 	pa->pa_inode = ac->ac_inode;
@@ -4725,6 +4774,8 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	atomic_add(pa->pa_free, &EXT4_SB(sb)->s_mb_preallocated);
 
 	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
+	if (!grp)
+		return;
 	lg = ac->ac_lg;
 	BUG_ON(lg == NULL);
 
@@ -4853,6 +4904,8 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	int err;
 	int free = 0;
 
+	if (!grp)
+		return 0;
 	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
 		goto out_dbg;
@@ -5090,6 +5143,9 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
 		struct ext4_prealloc_space *pa;
 		ext4_grpblk_t start;
 		struct list_head *cur;
+
+		if (!grp)
+			continue;
 		ext4_lock_group(sb, i);
 		list_for_each(cur, &grp->bb_prealloc_list) {
 			pa = list_entry(cur, struct ext4_prealloc_space,
@@ -5895,6 +5951,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	struct buffer_head *bitmap_bh = NULL;
 	struct super_block *sb = inode->i_sb;
 	struct ext4_group_desc *gdp;
+	struct ext4_group_info *grp;
 	unsigned int overflow;
 	ext4_grpblk_t bit;
 	struct buffer_head *gd_bh;
@@ -5920,8 +5977,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	overflow = 0;
 	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(
-			ext4_get_group_info(sb, block_group))))
+	grp = ext4_get_group_info(sb, block_group);
+	if (unlikely(!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		return;
 
 	/*
@@ -6523,6 +6580,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 
 	for (group = first_group; group <= last_group; group++) {
 		grp = ext4_get_group_info(sb, group);
+		if (!grp)
+			continue;
 		/* We only do this if the grp has never been initialized */
 		if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
 			ret = ext4_mb_init_group(sb, group, GFP_NOFS);
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 23930ed3cbda..24b3beddaf4b 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -296,6 +296,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (mmp_block < le32_to_cpu(es->s_first_data_block) ||
 	    mmp_block >= ext4_blocks_count(es)) {
 		ext4_warning(sb, "Invalid MMP block in superblock");
+		retval = -EINVAL;
 		goto failed;
 	}
 
@@ -321,6 +322,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	if (seq == EXT4_MMP_SEQ_FSCK) {
 		dump_mmp_msg(sb, mmp, "fsck is running on the filesystem");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -334,6 +336,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
 		ext4_warning(sb, "MMP startup interrupted, failing mount\n");
+		retval = -ETIMEDOUT;
 		goto failed;
 	}
 
@@ -344,6 +347,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (seq != le32_to_cpu(mmp->mmp_seq)) {
 		dump_mmp_msg(sb, mmp,
 			     "Device is already active on another node.");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -367,6 +371,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	 */
 	if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
 		ext4_warning(sb, "MMP startup interrupted, failing mount");
+		retval = -ETIMEDOUT;
 		goto failed;
 	}
 
@@ -377,6 +382,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (seq != le32_to_cpu(mmp->mmp_seq)) {
 		dump_mmp_msg(sb, mmp,
 			     "Device is already active on another node.");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -396,6 +402,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		EXT4_SB(sb)->s_mmp_tsk = NULL;
 		ext4_warning(sb, "Unable to create kmmpd thread for %s.",
 			     sb->s_id);
+		retval = -ENOMEM;
 		goto failed;
 	}
 
@@ -403,5 +410,5 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 failed:
 	brelse(bh);
-	return 1;
+	return retval;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d542f068ca99..bd2e803d653f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1049,6 +1049,8 @@ void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 	struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group, NULL);
 	int ret;
 
+	if (!grp || !gdp)
+		return;
 	if (flags & EXT4_GROUP_INFO_BBITMAP_CORRUPT) {
 		ret = ext4_test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT,
 					    &grp->bb_state);
@@ -5281,9 +5283,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			  ext4_has_feature_orphan_present(sb) ||
 			  ext4_has_feature_journal_needs_recovery(sb));
 
-	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb))
-		if (ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block)))
+	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb)) {
+		err = ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block));
+		if (err)
 			goto failed_mount3a;
+	}
 
 	/*
 	 * The first inode we look at is the journal inode.  Don't try
@@ -6337,6 +6341,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
+	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -6523,13 +6528,13 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			if (err)
 				goto restore_opts;
 
-			sb->s_flags &= ~SB_RDONLY;
-			if (ext4_has_feature_mmp(sb))
-				if (ext4_multi_mount_protect(sb,
-						le64_to_cpu(es->s_mmp_block))) {
-					err = -EROFS;
+			enable_rw = 1;
+			if (ext4_has_feature_mmp(sb)) {
+				err = ext4_multi_mount_protect(sb,
+						le64_to_cpu(es->s_mmp_block));
+				if (err)
 					goto restore_opts;
-				}
+			}
 #ifdef CONFIG_QUOTA
 			enable_quota = 1;
 #endif
@@ -6582,6 +6587,9 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
+	if (enable_rw)
+		sb->s_flags &= ~SB_RDONLY;
+
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
 
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0c82dae082aa..5df04ed010ca 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -322,8 +322,15 @@ static int __f2fs_write_meta_page(struct page *page,
 
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
@@ -1301,7 +1308,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 		if (!get_pages(sbi, type))
 			break;
 
-		if (unlikely(f2fs_cp_error(sbi)))
+		if (unlikely(f2fs_cp_error(sbi) &&
+			!is_sbi_flag_set(sbi, SBI_IS_CLOSE)))
 			break;
 
 		if (type == F2FS_DIRTY_META)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index de6b056f090b..36db9aab4779 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2788,7 +2788,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		 * don't drop any dirty dentry pages for keeping lastest
 		 * directory structure.
 		 */
-		if (S_ISDIR(inode->i_mode))
+		if (S_ISDIR(inode->i_mode) &&
+				!is_sbi_flag_set(sbi, SBI_IS_CLOSE))
 			goto redirty_out;
 		goto out;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a0a232551da9..8d7dc76e6f93 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4435,6 +4435,11 @@ static inline bool f2fs_hw_is_readonly(struct f2fs_sb_info *sbi)
 	return false;
 }
 
+static inline bool f2fs_dev_is_readonly(struct f2fs_sb_info *sbi)
+{
+	return f2fs_sb_has_readonly(sbi) || f2fs_hw_is_readonly(sbi);
+}
+
 static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 {
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5cd19fdc1059..7e497f5b349c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1811,6 +1811,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 	};
 	unsigned int skipped_round = 0, round = 0;
+	unsigned int upper_secs;
 
 	trace_f2fs_gc_begin(sbi->sb, gc_type, gc_control->no_bg_gc,
 				gc_control->nr_free_secs,
@@ -1896,8 +1897,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		}
 	}
 
-	/* Write checkpoint to reclaim prefree segments */
-	if (free_sections(sbi) < NR_CURSEG_PERSIST_TYPE &&
+	__get_secs_required(sbi, NULL, &upper_secs, NULL);
+
+	/*
+	 * Write checkpoint to reclaim prefree segments.
+	 * We need more three extra sections for writer's data/node/dentry.
+	 */
+	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS &&
 				prefree_segments(sbi)) {
 		ret = f2fs_write_checkpoint(sbi, &cpc);
 		if (ret)
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index ca84024b9c9e..47357101b03c 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -30,6 +30,8 @@
 /* Search max. number of dirty segments to select a victim segment */
 #define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
 
+#define NR_GC_CHECKPOINT_SECS (3)	/* data/node/dentry sections */
+
 struct f2fs_gc_kthread {
 	struct task_struct *f2fs_gc_task;
 	wait_queue_head_t gc_wait_queue_head;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index cd65778fc982..f3951e8ad394 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -608,8 +608,12 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 	return true;
 }
 
-static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
-					int freed, int needed)
+/*
+ * calculate needed sections for dirty node/dentry
+ * and call has_curseg_enough_space
+ */
+static inline void __get_secs_required(struct f2fs_sb_info *sbi,
+		unsigned int *lower_p, unsigned int *upper_p, bool *curseg_p)
 {
 	unsigned int total_node_blocks = get_pages(sbi, F2FS_DIRTY_NODES) +
 					get_pages(sbi, F2FS_DIRTY_DENTS) +
@@ -619,20 +623,37 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 	unsigned int dent_secs = total_dent_blocks / CAP_BLKS_PER_SEC(sbi);
 	unsigned int node_blocks = total_node_blocks % CAP_BLKS_PER_SEC(sbi);
 	unsigned int dent_blocks = total_dent_blocks % CAP_BLKS_PER_SEC(sbi);
-	unsigned int free, need_lower, need_upper;
+
+	if (lower_p)
+		*lower_p = node_secs + dent_secs;
+	if (upper_p)
+		*upper_p = node_secs + dent_secs +
+			(node_blocks ? 1 : 0) + (dent_blocks ? 1 : 0);
+	if (curseg_p)
+		*curseg_p = has_curseg_enough_space(sbi,
+				node_blocks, dent_blocks);
+}
+
+static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
+					int freed, int needed)
+{
+	unsigned int free_secs, lower_secs, upper_secs;
+	bool curseg_space;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		return false;
 
-	free = free_sections(sbi) + freed;
-	need_lower = node_secs + dent_secs + reserved_sections(sbi) + needed;
-	need_upper = need_lower + (node_blocks ? 1 : 0) + (dent_blocks ? 1 : 0);
+	__get_secs_required(sbi, &lower_secs, &upper_secs, &curseg_space);
+
+	free_secs = free_sections(sbi) + freed;
+	lower_secs += needed + reserved_sections(sbi);
+	upper_secs += needed + reserved_sections(sbi);
 
-	if (free > need_upper)
+	if (free_secs > upper_secs)
 		return false;
-	else if (free <= need_lower)
+	else if (free_secs <= lower_secs)
 		return true;
-	return !has_curseg_enough_space(sbi, node_blocks, dent_blocks);
+	return !curseg_space;
 }
 
 static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c46533d65372..b6dad389fa14 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2258,7 +2258,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (f2fs_readonly(sb) && (*flags & SB_RDONLY))
 		goto skip;
 
-	if (f2fs_sb_has_readonly(sbi) && !(*flags & SB_RDONLY)) {
+	if (f2fs_dev_is_readonly(sbi) && !(*flags & SB_RDONLY)) {
 		err = -EROFS;
 		goto restore_opts;
 	}
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index d78b61ecc1cd..7762483f5f20 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -393,6 +393,7 @@ static int inode_go_demote_ok(const struct gfs2_glock *gl)
 
 static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	const struct gfs2_dinode *str = buf;
 	struct timespec64 atime;
 	u16 height, depth;
@@ -439,7 +440,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	/* i_diskflags and i_eattr must be set before gfs2_set_inode_flags() */
 	gfs2_set_inode_flags(inode);
 	height = be16_to_cpu(str->di_height);
-	if (unlikely(height > GFS2_MAX_META_HEIGHT))
+	if (unlikely(height > sdp->sd_max_height))
 		goto corrupt;
 	ip->i_height = (u8)height;
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index b675581aa9d0..399a6354f0cc 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -511,7 +511,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
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
@@ -531,7 +535,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
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
 
@@ -562,6 +570,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		pr_err("bad catalog entry used to create inode\n");
 		res = -EIO;
 	}
+out:
 	return res;
 }
 
@@ -570,6 +579,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	struct inode *main_inode = inode;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
+	int res = 0;
 
 	if (HFSPLUS_IS_RSRC(inode))
 		main_inode = HFSPLUS_I(inode)->rsrc_inode;
@@ -588,7 +598,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
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
@@ -613,7 +627,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
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
@@ -634,7 +652,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
-	return 0;
+	return res;
 }
 
 int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa)
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index e3312fbf4c09..b371754540f9 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -353,7 +353,8 @@ int ksmbd_conn_handler_loop(void *p)
 			break;
 
 		/* 4 for rfc1002 length field */
-		size = pdu_size + 4;
+		/* 1 for implied bcc[0] */
+		size = pdu_size + 4 + 1;
 		conn->request_buf = kvmalloc(size, GFP_KERNEL);
 		if (!conn->request_buf)
 			break;
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index d7d47b82451d..c7466546e59b 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1449,11 +1449,12 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
  * smb2_find_context_vals() - find a particular context info in open request
  * @open_req:	buffer containing smb2 file open(create) request
  * @tag:	context name to search for
+ * @tag_len:	the length of tag
  *
  * Return:	pointer to requested context, NULL if @str context not found
  *		or error pointer if name length is invalid.
  */
-struct create_context *smb2_find_context_vals(void *open_req, const char *tag)
+struct create_context *smb2_find_context_vals(void *open_req, const char *tag, int tag_len)
 {
 	struct create_context *cc;
 	unsigned int next = 0;
@@ -1492,7 +1493,7 @@ struct create_context *smb2_find_context_vals(void *open_req, const char *tag)
 			return ERR_PTR(-EINVAL);
 
 		name = (char *)cc + name_off;
-		if (memcmp(name, tag, name_len) == 0)
+		if (name_len == tag_len && !memcmp(name, tag, name_len))
 			return cc;
 
 		remain_len -= next;
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index 09753448f779..4b0fe6da7694 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -118,7 +118,7 @@ void create_durable_v2_rsp_buf(char *cc, struct ksmbd_file *fp);
 void create_mxac_rsp_buf(char *cc, int maximal_access);
 void create_disk_id_rsp_buf(char *cc, __u64 file_id, __u64 vol_id);
 void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp);
-struct create_context *smb2_find_context_vals(void *open_req, const char *str);
+struct create_context *smb2_find_context_vals(void *open_req, const char *tag, int tag_len);
 struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 					  char *lease_key);
 int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index fbdde426dd01..0ffe663b7590 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -416,8 +416,11 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 
 		/*
 		 * Allow a message that padded to 8byte boundary.
+		 * Linux 4.19.217 with smb 3.0.2 are sometimes
+		 * sending messages where the cls_len is exactly
+		 * 8 bytes less than len.
 		 */
-		if (clc_len < len && (len - clc_len) < 8)
+		if (clc_len < len && (len - clc_len) <= 8)
 			goto validate_credit;
 
 		pr_err_ratelimited(
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 8f96b96dbac1..7684b31035d9 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1373,7 +1373,7 @@ static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
 	struct authenticate_message *authblob;
 	struct ksmbd_user *user;
 	char *name;
-	unsigned int auth_msg_len, name_off, name_len, secbuf_len;
+	unsigned int name_off, name_len, secbuf_len;
 
 	secbuf_len = le16_to_cpu(req->SecurityBufferLength);
 	if (secbuf_len < sizeof(struct authenticate_message)) {
@@ -1383,9 +1383,8 @@ static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
 	authblob = user_authblob(conn, req);
 	name_off = le32_to_cpu(authblob->UserName.BufferOffset);
 	name_len = le16_to_cpu(authblob->UserName.Length);
-	auth_msg_len = le16_to_cpu(req->SecurityBufferOffset) + secbuf_len;
 
-	if (auth_msg_len < (u64)name_off + name_len)
+	if (secbuf_len < (u64)name_off + name_len)
 		return NULL;
 
 	name = smb_strndup_from_utf16((const char *)authblob + name_off,
@@ -2479,7 +2478,7 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
 		return -ENOENT;
 
 	/* Parse SD BUFFER create contexts */
-	context = smb2_find_context_vals(req, SMB2_CREATE_SD_BUFFER);
+	context = smb2_find_context_vals(req, SMB2_CREATE_SD_BUFFER, 4);
 	if (!context)
 		return -ENOENT;
 	else if (IS_ERR(context))
@@ -2681,7 +2680,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	if (req->CreateContextsOffset) {
 		/* Parse non-durable handle create contexts */
-		context = smb2_find_context_vals(req, SMB2_CREATE_EA_BUFFER);
+		context = smb2_find_context_vals(req, SMB2_CREATE_EA_BUFFER, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
 			goto err_out1;
@@ -2701,7 +2700,7 @@ int smb2_open(struct ksmbd_work *work)
 		}
 
 		context = smb2_find_context_vals(req,
-						 SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST);
+						 SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
 			goto err_out1;
@@ -2712,7 +2711,7 @@ int smb2_open(struct ksmbd_work *work)
 		}
 
 		context = smb2_find_context_vals(req,
-						 SMB2_CREATE_TIMEWARP_REQUEST);
+						 SMB2_CREATE_TIMEWARP_REQUEST, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
 			goto err_out1;
@@ -2724,7 +2723,7 @@ int smb2_open(struct ksmbd_work *work)
 
 		if (tcon->posix_extensions) {
 			context = smb2_find_context_vals(req,
-							 SMB2_CREATE_TAG_POSIX);
+							 SMB2_CREATE_TAG_POSIX, 16);
 			if (IS_ERR(context)) {
 				rc = PTR_ERR(context);
 				goto err_out1;
@@ -3123,7 +3122,7 @@ int smb2_open(struct ksmbd_work *work)
 		struct create_alloc_size_req *az_req;
 
 		az_req = (struct create_alloc_size_req *)smb2_find_context_vals(req,
-					SMB2_CREATE_ALLOCATION_SIZE);
+					SMB2_CREATE_ALLOCATION_SIZE, 4);
 		if (IS_ERR(az_req)) {
 			rc = PTR_ERR(az_req);
 			goto err_out;
@@ -3150,7 +3149,7 @@ int smb2_open(struct ksmbd_work *work)
 					    err);
 		}
 
-		context = smb2_find_context_vals(req, SMB2_CREATE_QUERY_ON_DISK_ID);
+		context = smb2_find_context_vals(req, SMB2_CREATE_QUERY_ON_DISK_ID, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
 			goto err_out;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 232dd7b6cca1..f6e44efb58e1 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -917,6 +917,7 @@ void nilfs_evict_inode(struct inode *inode)
 	struct nilfs_transaction_info ti;
 	struct super_block *sb = inode->i_sb;
 	struct nilfs_inode_info *ii = NILFS_I(inode);
+	struct the_nilfs *nilfs;
 	int ret;
 
 	if (inode->i_nlink || !ii->i_root || unlikely(is_bad_inode(inode))) {
@@ -929,6 +930,23 @@ void nilfs_evict_inode(struct inode *inode)
 
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
diff --git a/fs/open.c b/fs/open.c
index 20717ec510c0..9541430ec5b3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1158,13 +1158,21 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	}
 
 	/*
-	 * In order to ensure programs get explicit errors when trying to use
-	 * O_TMPFILE on old kernels, O_TMPFILE is implemented such that it
-	 * looks like (O_DIRECTORY|O_RDWR & ~O_CREAT) to old kernels. But we
-	 * have to require userspace to explicitly set it.
+	 * Block bugs where O_DIRECTORY | O_CREAT created regular files.
+	 * Note, that blocking O_DIRECTORY | O_CREAT here also protects
+	 * O_TMPFILE below which requires O_DIRECTORY being raised.
 	 */
+	if ((flags & (O_DIRECTORY | O_CREAT)) == (O_DIRECTORY | O_CREAT))
+		return -EINVAL;
+
+	/* Now handle the creative implementation of O_TMPFILE. */
 	if (flags & __O_TMPFILE) {
-		if ((flags & O_TMPFILE_MASK) != O_TMPFILE)
+		/*
+		 * In order to ensure programs get explicit errors when trying
+		 * to use O_TMPFILE on old kernels we enforce that O_DIRECTORY
+		 * is raised alongside __O_TMPFILE.
+		 */
+		if (!(flags & O_DIRECTORY))
 			return -EINVAL;
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
diff --git a/fs/statfs.c b/fs/statfs.c
index 0ba34c135593..96d1c3edf289 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -130,6 +130,7 @@ static int do_statfs_native(struct kstatfs *st, struct statfs __user *p)
 	if (sizeof(buf) == sizeof(*st))
 		memcpy(&buf, st, sizeof(*st));
 	else {
+		memset(&buf, 0, sizeof(buf));
 		if (sizeof buf.f_blocks == 4) {
 			if ((st->f_blocks | st->f_bfree | st->f_bavail |
 			     st->f_bsize | st->f_frsize) &
@@ -158,7 +159,6 @@ static int do_statfs_native(struct kstatfs *st, struct statfs __user *p)
 		buf.f_namelen = st->f_namelen;
 		buf.f_frsize = st->f_frsize;
 		buf.f_flags = st->f_flags;
-		memset(buf.f_spare, 0, sizeof(buf.f_spare));
 	}
 	if (copy_to_user(p, &buf, sizeof(buf)))
 		return -EFAULT;
@@ -171,6 +171,7 @@ static int do_statfs64(struct kstatfs *st, struct statfs64 __user *p)
 	if (sizeof(buf) == sizeof(*st))
 		memcpy(&buf, st, sizeof(*st));
 	else {
+		memset(&buf, 0, sizeof(buf));
 		buf.f_type = st->f_type;
 		buf.f_bsize = st->f_bsize;
 		buf.f_blocks = st->f_blocks;
@@ -182,7 +183,6 @@ static int do_statfs64(struct kstatfs *st, struct statfs64 __user *p)
 		buf.f_namelen = st->f_namelen;
 		buf.f_frsize = st->f_frsize;
 		buf.f_flags = st->f_flags;
-		memset(buf.f_spare, 0, sizeof(buf.f_spare));
 	}
 	if (copy_to_user(p, &buf, sizeof(buf)))
 		return -EFAULT;
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 220c8c60e021..f196c19f8e55 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -226,6 +226,24 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);
 
 extern u64 smccc_has_sve_hint;
 
+/**
+ * arm_smccc_get_soc_id_version()
+ *
+ * Returns the SOC ID version.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID is not present, returns SMCCC_RET_NOT_SUPPORTED.
+ */
+s32 arm_smccc_get_soc_id_version(void);
+
+/**
+ * arm_smccc_get_soc_id_revision()
+ *
+ * Returns the SOC ID revision.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID is not present, returns SMCCC_RET_NOT_SUPPORTED.
+ */
+s32 arm_smccc_get_soc_id_revision(void);
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f61447913db9..2be2091c2b44 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -161,7 +161,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_CSTATE_STARTING,
 	CPUHP_AP_PERF_XTENSA_STARTING,
 	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
-	CPUHP_AP_ARM_SDEI_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
 	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
diff --git a/include/linux/dim.h b/include/linux/dim.h
index 6c5733981563..f343bc9aa2ec 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -236,8 +236,9 @@ void dim_park_tired(struct dim *dim);
  *
  * Calculate the delta between two samples (in data rates).
  * Takes into consideration counter wrap-around.
+ * Returned boolean indicates whether curr_stats are reliable.
  */
-void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 		    struct dim_stats *curr_stats);
 
 /**
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index e00c4ee81ff7..68b1c4133298 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -631,6 +631,23 @@ static inline __be16 vlan_get_protocol(const struct sk_buff *skb)
 	return __vlan_get_protocol(skb, skb->protocol, NULL);
 }
 
+/* This version of __vlan_get_protocol() also pulls mac header in skb->head */
+static inline __be16 vlan_get_protocol_and_depth(struct sk_buff *skb,
+						 __be16 type, int *depth)
+{
+	int maclen;
+
+	type = __vlan_get_protocol(skb, type, &maclen);
+
+	if (type) {
+		if (!pskb_may_pull(skb, maclen))
+			type = 0;
+		else if (depth)
+			*depth = maclen;
+	}
+	return type;
+}
+
 /* A getter for the SKB protocol field which will handle VLAN tags consistently
  * whether VLAN acceleration is enabled or not.
  */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b072449b0f1a..eac51e22a52a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2428,6 +2428,7 @@ static inline
 struct netdev_queue *netdev_get_tx_queue(const struct net_device *dev,
 					 unsigned int index)
 {
+	DEBUG_NET_WARN_ON_ONCE(index >= dev->num_tx_queues);
 	return &dev->_tx[index];
 }
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index b0d5a253156e..b845fd83f429 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -207,7 +207,18 @@ extern void platform_device_put(struct platform_device *pdev);
 
 struct platform_driver {
 	int (*probe)(struct platform_device *);
+
+	/*
+	 * Traditionally the remove callback returned an int which however is
+	 * ignored by the driver core. This led to wrong expectations by driver
+	 * authors who thought returning an error code was a valid error
+	 * handling strategy. To convert to a callback returning void, new
+	 * drivers should implement .remove_new() until the conversion it done
+	 * that eventually makes .remove() return void.
+	 */
 	int (*remove)(struct platform_device *);
+	void (*remove_new)(struct platform_device *);
+
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
 	int (*resume)(struct platform_device *);
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 5e799a47431e..f158b025c175 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -23,7 +23,7 @@ static __always_inline void *task_stack_page(const struct task_struct *task)
 
 #define setup_thread_stack(new,old)	do { } while(0)
 
-static inline unsigned long *end_of_stack(const struct task_struct *task)
+static __always_inline unsigned long *end_of_stack(const struct task_struct *task)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long *)((unsigned long)task->stack + THREAD_SIZE) - 1;
diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 24aa159d29a7..fbc4bd423b35 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -176,7 +176,7 @@ extern struct svc_rdma_recv_ctxt *
 extern void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_recv_ctxt *ctxt);
 extern void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma);
-extern void svc_rdma_release_rqst(struct svc_rqst *rqstp);
+extern void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *ctxt);
 extern int svc_rdma_recvfrom(struct svc_rqst *);
 
 /* svc_rdma_rw.c */
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index d42a75b3be10..e882fe16a500 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -23,7 +23,7 @@ struct svc_xprt_ops {
 	int		(*xpo_sendto)(struct svc_rqst *);
 	int		(*xpo_result_payload)(struct svc_rqst *, unsigned int,
 					      unsigned int);
-	void		(*xpo_release_rqst)(struct svc_rqst *);
+	void		(*xpo_release_ctxt)(struct svc_xprt *xprt, void *ctxt);
 	void		(*xpo_detach)(struct svc_xprt *);
 	void		(*xpo_free)(struct svc_xprt *);
 	void		(*xpo_secure_port)(struct svc_rqst *rqstp);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7a381fcef939..b350d92136c8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -294,6 +294,21 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG,
+
+	/* When this quirk is set, max_page for local extended features
+	 * is set to 1, even if controller reports higher number. Some
+	 * controllers (e.g. RTL8723CS) report more pages, but they
+	 * don't actually support features declared there.
+	 */
+	HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2,
+
+	/*
+	 * When this quirk is set, the HCI_OP_LE_SET_RPA_TIMEOUT command is
+	 * skipped during initialization. This is required for the Actions
+	 * Semiconductor ATS2851 based controllers, which erroneously claims
+	 * to support it.
+	 */
+	HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
 };
 
 /* HCI device flags */
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 768348008d0c..123729c0e1ee 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -235,7 +235,7 @@ struct bonding {
 	 */
 	spinlock_t mode_lock;
 	spinlock_t stats_lock;
-	u8	 send_peer_notif;
+	u32	 send_peer_notif;
 	u8       igmp_retrans;
 #ifdef CONFIG_PROC_FS
 	struct   proc_dir_entry *proc_entry;
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 1fca6a88114a..abc46f05762e 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -549,8 +549,10 @@ struct ip_vs_conn {
 	 */
 	struct ip_vs_app        *app;           /* bound ip_vs_app object */
 	void                    *app_data;      /* Application private data */
-	struct ip_vs_seq        in_seq;         /* incoming seq. struct */
-	struct ip_vs_seq        out_seq;        /* outgoing seq. struct */
+	struct_group(sync_conn_opt,
+		struct ip_vs_seq  in_seq;       /* incoming seq. struct */
+		struct ip_vs_seq  out_seq;      /* outgoing seq. struct */
+	);
 
 	const struct ip_vs_pe	*pe;
 	char			*pe_data;
diff --git a/include/net/sock.h b/include/net/sock.h
index 832a4a51de4d..beb1b747fb09 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2744,7 +2744,7 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 		__sock_recv_cmsgs(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
 		sock_write_timestamp(sk, skb->tstamp);
-	else if (unlikely(sk->sk_stamp == SK_DEFAULT_STAMP))
+	else if (unlikely(sock_read_timestamp(sk) == SK_DEFAULT_STAMP))
 		sock_write_timestamp(sk, 0);
 }
 
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 1ecdb911add8..80f37a0d40d7 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -91,7 +91,6 @@
 
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
-#define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
 
 #ifndef O_NDELAY
 #define O_NDELAY	O_NONBLOCK
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index f27fa5ba7d72..d9d88a2cda5e 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -51,11 +51,21 @@ owner_storage(struct bpf_local_storage_map *smap, void *owner)
 	return map->ops->map_owner_storage_ptr(owner);
 }
 
+static bool selem_linked_to_storage_lockless(const struct bpf_local_storage_elem *selem)
+{
+	return !hlist_unhashed_lockless(&selem->snode);
+}
+
 static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->snode);
 }
 
+static bool selem_linked_to_map_lockless(const struct bpf_local_storage_elem *selem)
+{
+	return !hlist_unhashed_lockless(&selem->map_node);
+}
+
 static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->map_node);
@@ -165,7 +175,7 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	bool free_local_storage = false;
 	unsigned long flags;
 
-	if (unlikely(!selem_linked_to_storage(selem)))
+	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
 		return;
 
@@ -199,7 +209,7 @@ void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
-	if (unlikely(!selem_linked_to_map(selem)))
+	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
 		return;
 
@@ -410,7 +420,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		err = check_flags(old_sdata, map_flags);
 		if (err)
 			return ERR_PTR(err);
-		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
+		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
 			copy_map_value_locked(&smap->map, old_sdata->data,
 					      value, false);
 			return old_sdata;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 872616107613..322a2ae8f88b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15133,6 +15133,10 @@ BTF_ID(func, migrate_enable)
 #if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
 BTF_ID(func, rcu_read_unlock_strict)
 #endif
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
+BTF_ID(func, preempt_count_add)
+BTF_ID(func, preempt_count_sub)
+#endif
 BTF_SET_END(btf_id_deny)
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 435c884c02b5..d49a9d66e000 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -795,7 +795,7 @@ ref_scale_cleanup(void)
 static int
 ref_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq, shutdown_start);
+	wait_event_idle(shutdown_wq, shutdown_start);
 
 	smp_mb(); // Wake before output.
 	ref_scale_cleanup();
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 60732264a7d0..e25321dbb068 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -800,9 +800,11 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 	int ndetected = 0;
 	struct task_struct *t;
 
-	if (!READ_ONCE(rnp->exp_tasks))
-		return 0;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	if (!rnp->exp_tasks) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return 0;
+	}
 	t = list_entry(rnp->exp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index f7fe6fe36173..0916cc9adb82 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -35,14 +35,15 @@ static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(tick_broadcast_lock);
 #ifdef CONFIG_TICK_ONESHOT
 static DEFINE_PER_CPU(struct clock_event_device *, tick_oneshot_wakeup_device);
 
-static void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
+static void tick_broadcast_setup_oneshot(struct clock_event_device *bc, bool from_periodic);
 static void tick_broadcast_clear_oneshot(int cpu);
 static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
 # ifdef CONFIG_HOTPLUG_CPU
 static void tick_broadcast_oneshot_offline(unsigned int cpu);
 # endif
 #else
-static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
+static inline void
+tick_broadcast_setup_oneshot(struct clock_event_device *bc, bool from_periodic) { BUG(); }
 static inline void tick_broadcast_clear_oneshot(int cpu) { }
 static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc) { }
 # ifdef CONFIG_HOTPLUG_CPU
@@ -264,7 +265,7 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 		if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC)
 			tick_broadcast_start_periodic(bc);
 		else
-			tick_broadcast_setup_oneshot(bc);
+			tick_broadcast_setup_oneshot(bc, false);
 		ret = 1;
 	} else {
 		/*
@@ -500,7 +501,7 @@ void tick_broadcast_control(enum tick_broadcast_mode mode)
 			if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC)
 				tick_broadcast_start_periodic(bc);
 			else
-				tick_broadcast_setup_oneshot(bc);
+				tick_broadcast_setup_oneshot(bc, false);
 		}
 	}
 out:
@@ -1016,48 +1017,101 @@ static inline ktime_t tick_get_next_period(void)
 /**
  * tick_broadcast_setup_oneshot - setup the broadcast device
  */
-static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
+static void tick_broadcast_setup_oneshot(struct clock_event_device *bc,
+					 bool from_periodic)
 {
 	int cpu = smp_processor_id();
+	ktime_t nexttick = 0;
 
 	if (!bc)
 		return;
 
-	/* Set it up only once ! */
-	if (bc->event_handler != tick_handle_oneshot_broadcast) {
-		int was_periodic = clockevent_state_periodic(bc);
-
-		bc->event_handler = tick_handle_oneshot_broadcast;
-
+	/*
+	 * When the broadcast device was switched to oneshot by the first
+	 * CPU handling the NOHZ change, the other CPUs will reach this
+	 * code via hrtimer_run_queues() -> tick_check_oneshot_change()
+	 * too. Set up the broadcast device only once!
+	 */
+	if (bc->event_handler == tick_handle_oneshot_broadcast) {
 		/*
-		 * We must be careful here. There might be other CPUs
-		 * waiting for periodic broadcast. We need to set the
-		 * oneshot_mask bits for those and program the
-		 * broadcast device to fire.
+		 * The CPU which switched from periodic to oneshot mode
+		 * set the broadcast oneshot bit for all other CPUs which
+		 * are in the general (periodic) broadcast mask to ensure
+		 * that CPUs which wait for the periodic broadcast are
+		 * woken up.
+		 *
+		 * Clear the bit for the local CPU as the set bit would
+		 * prevent the first tick_broadcast_enter() after this CPU
+		 * switched to oneshot state to program the broadcast
+		 * device.
+		 *
+		 * This code can also be reached via tick_broadcast_control(),
+		 * but this cannot avoid the tick_broadcast_clear_oneshot()
+		 * as that would break the periodic to oneshot transition of
+		 * secondary CPUs. But that's harmless as the below only
+		 * clears already cleared bits.
 		 */
+		tick_broadcast_clear_oneshot(cpu);
+		return;
+	}
+
+
+	bc->event_handler = tick_handle_oneshot_broadcast;
+	bc->next_event = KTIME_MAX;
+
+	/*
+	 * When the tick mode is switched from periodic to oneshot it must
+	 * be ensured that CPUs which are waiting for periodic broadcast
+	 * get their wake-up at the next tick.  This is achieved by ORing
+	 * tick_broadcast_mask into tick_broadcast_oneshot_mask.
+	 *
+	 * For other callers, e.g. broadcast device replacement,
+	 * tick_broadcast_oneshot_mask must not be touched as this would
+	 * set bits for CPUs which are already NOHZ, but not idle. Their
+	 * next tick_broadcast_enter() would observe the bit set and fail
+	 * to update the expiry time and the broadcast event device.
+	 */
+	if (from_periodic) {
 		cpumask_copy(tmpmask, tick_broadcast_mask);
+		/* Remove the local CPU as it is obviously not idle */
 		cpumask_clear_cpu(cpu, tmpmask);
-		cpumask_or(tick_broadcast_oneshot_mask,
-			   tick_broadcast_oneshot_mask, tmpmask);
+		cpumask_or(tick_broadcast_oneshot_mask, tick_broadcast_oneshot_mask, tmpmask);
 
-		if (was_periodic && !cpumask_empty(tmpmask)) {
-			ktime_t nextevt = tick_get_next_period();
+		/*
+		 * Ensure that the oneshot broadcast handler will wake the
+		 * CPUs which are still waiting for periodic broadcast.
+		 */
+		nexttick = tick_get_next_period();
+		tick_broadcast_init_next_event(tmpmask, nexttick);
 
-			clockevents_switch_state(bc, CLOCK_EVT_STATE_ONESHOT);
-			tick_broadcast_init_next_event(tmpmask, nextevt);
-			tick_broadcast_set_event(bc, cpu, nextevt);
-		} else
-			bc->next_event = KTIME_MAX;
-	} else {
 		/*
-		 * The first cpu which switches to oneshot mode sets
-		 * the bit for all other cpus which are in the general
-		 * (periodic) broadcast mask. So the bit is set and
-		 * would prevent the first broadcast enter after this
-		 * to program the bc device.
+		 * If the underlying broadcast clock event device is
+		 * already in oneshot state, then there is nothing to do.
+		 * The device was already armed for the next tick
+		 * in tick_handle_broadcast_periodic()
 		 */
-		tick_broadcast_clear_oneshot(cpu);
+		if (clockevent_state_oneshot(bc))
+			return;
 	}
+
+	/*
+	 * When switching from periodic to oneshot mode arm the broadcast
+	 * device for the next tick.
+	 *
+	 * If the broadcast device has been replaced in oneshot mode and
+	 * the oneshot broadcast mask is not empty, then arm it to expire
+	 * immediately in order to reevaluate the next expiring timer.
+	 * @nexttick is 0 and therefore in the past which will cause the
+	 * clockevent code to force an event.
+	 *
+	 * For both cases the programming can be avoided when the oneshot
+	 * broadcast mask is empty.
+	 *
+	 * tick_broadcast_set_event() implicitly switches the broadcast
+	 * device to oneshot state.
+	 */
+	if (!cpumask_empty(tick_broadcast_oneshot_mask))
+		tick_broadcast_set_event(bc, cpu, nexttick);
 }
 
 /*
@@ -1066,14 +1120,16 @@ static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
 void tick_broadcast_switch_to_oneshot(void)
 {
 	struct clock_event_device *bc;
+	enum tick_device_mode oldmode;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
 
+	oldmode = tick_broadcast_device.mode;
 	tick_broadcast_device.mode = TICKDEV_MODE_ONESHOT;
 	bc = tick_broadcast_device.evtdev;
 	if (bc)
-		tick_broadcast_setup_oneshot(bc);
+		tick_broadcast_setup_oneshot(bc, oldmode == TICKDEV_MODE_PERIODIC);
 
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 32c3dfdb4d6a..60f6cb2b486b 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -288,7 +288,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 	 * These loops must be protected from rethook_free_rcu() because those
 	 * are accessing 'rhn->rethook'.
 	 */
-	preempt_disable();
+	preempt_disable_notrace();
 
 	/*
 	 * Run the handler on the shadow stack. Do not unlink the list here because
@@ -321,7 +321,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 		first = first->next;
 		rethook_recycle(rhn);
 	}
-	preempt_enable();
+	preempt_enable_notrace();
 
 	return correct_ret_addr;
 }
diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index f08d9c56f712..e77f12bb3c77 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -232,7 +232,8 @@ void free_irq_cpu_rmap(struct cpu_rmap *rmap)
 
 	for (index = 0; index < rmap->used; index++) {
 		glue = rmap->obj[index];
-		irq_set_affinity_notifier(glue->notify.irq, NULL);
+		if (glue)
+			irq_set_affinity_notifier(glue->notify.irq, NULL);
 	}
 
 	cpu_rmap_put(rmap);
@@ -268,6 +269,7 @@ static void irq_cpu_rmap_release(struct kref *ref)
 		container_of(ref, struct irq_glue, notify.kref);
 
 	cpu_rmap_put(glue->rmap);
+	glue->rmap->obj[glue->index] = NULL;
 	kfree(glue);
 }
 
@@ -297,6 +299,7 @@ int irq_cpu_rmap_add(struct cpu_rmap *rmap, int irq)
 	rc = irq_set_affinity_notifier(irq, &glue->notify);
 	if (rc) {
 		cpu_rmap_put(glue->rmap);
+		rmap->obj[glue->index] = NULL;
 		kfree(glue);
 	}
 	return rc;
diff --git a/lib/dim/dim.c b/lib/dim/dim.c
index 38045d6d0538..e89aaf07bde5 100644
--- a/lib/dim/dim.c
+++ b/lib/dim/dim.c
@@ -54,7 +54,7 @@ void dim_park_tired(struct dim *dim)
 }
 EXPORT_SYMBOL(dim_park_tired);
 
-void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 		    struct dim_stats *curr_stats)
 {
 	/* u32 holds up to 71 minutes, should be enough */
@@ -66,7 +66,7 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 			     start->comp_ctr);
 
 	if (!delta_us)
-		return;
+		return false;
 
 	curr_stats->ppms = DIV_ROUND_UP(npkts * USEC_PER_MSEC, delta_us);
 	curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
@@ -79,5 +79,6 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 	else
 		curr_stats->cpe_ratio = 0;
 
+	return true;
 }
 EXPORT_SYMBOL(dim_calc_stats);
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 53f6b9c6e936..4e32f7aaac86 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -227,7 +227,8 @@ void net_dim(struct dim *dim, struct dim_sample end_sample)
 				  dim->start_sample.event_ctr);
 		if (nevents < DIM_NEVENTS)
 			break;
-		dim_calc_stats(&dim->start_sample, &end_sample, &curr_stats);
+		if (!dim_calc_stats(&dim->start_sample, &end_sample, &curr_stats))
+			break;
 		if (net_dim_decision(&curr_stats, dim)) {
 			dim->state = DIM_APPLY_NEW_PROFILE;
 			schedule_work(&dim->work);
diff --git a/lib/dim/rdma_dim.c b/lib/dim/rdma_dim.c
index 15462d54758d..88f779486707 100644
--- a/lib/dim/rdma_dim.c
+++ b/lib/dim/rdma_dim.c
@@ -88,7 +88,8 @@ void rdma_dim(struct dim *dim, u64 completions)
 		nevents = curr_sample->event_ctr - dim->start_sample.event_ctr;
 		if (nevents < DIM_NEVENTS)
 			break;
-		dim_calc_stats(&dim->start_sample, curr_sample, &curr_stats);
+		if (!dim_calc_stats(&dim->start_sample, curr_sample, &curr_stats))
+			break;
 		if (rdma_dim_decision(&curr_stats, dim)) {
 			dim->state = DIM_APPLY_NEW_PROFILE;
 			schedule_work(&dim->work);
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9fe25ce9937b..b72268848ade 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5338,15 +5338,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 
 	mt = mte_node_type(mas->node);
 	pivots = ma_pivots(mas_mn(mas), mt);
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
-
-	if (offset < mt_pivots[mt])
-		mas->max = pivots[offset];
-
-	if (mas->index < mas->min)
-		mas->index = mas->min;
-
+	min = mas_safe_min(mas, pivots, offset);
+	if (mas->index < min)
+		mas->index = min;
 	mas->last = mas->index + size - 1;
 	return 0;
 }
diff --git a/mm/zswap.c b/mm/zswap.c
index 2d48fd59cc7a..708b82dbe8a4 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1002,6 +1002,22 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		goto fail;
 
 	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
+		/*
+		 * Having a local reference to the zswap entry doesn't exclude
+		 * swapping from invalidating and recycling the swap slot. Once
+		 * the swapcache is secured against concurrent swapping to and
+		 * from the slot, recheck that the entry is still current before
+		 * writing.
+		 */
+		spin_lock(&tree->lock);
+		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
+			spin_unlock(&tree->lock);
+			delete_from_swap_cache(page_folio(page));
+			ret = -ENOMEM;
+			goto fail;
+		}
+		spin_unlock(&tree->lock);
+
 		/* decompress */
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 07e86d03d4ba..d3e511e1eba8 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -108,8 +108,8 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
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
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 42a3a19b111e..21416ccc30ab 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -881,8 +881,13 @@ static u8 hci_cc_read_local_ext_features(struct hci_dev *hdev, void *data,
 	if (rp->status)
 		return rp->status;
 
-	if (hdev->max_page < rp->max_page)
-		hdev->max_page = rp->max_page;
+	if (hdev->max_page < rp->max_page) {
+		if (test_bit(HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2,
+			     &hdev->quirks))
+			bt_dev_warn(hdev, "broken local ext features page 2");
+		else
+			hdev->max_page = rp->max_page;
+	}
 
 	if (rp->page < HCI_MAX_PAGES)
 		memcpy(hdev->features[rp->page], rp->features, 8);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9361fb3685cc..e8b78104a407 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4075,7 +4075,8 @@ static int hci_le_set_rpa_timeout_sync(struct hci_dev *hdev)
 {
 	__le16 timeout = cpu_to_le16(hdev->rpa_timeout);
 
-	if (!(hdev->commands[35] & 0x04))
+	if (!(hdev->commands[35] & 0x04) ||
+	    test_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_RPA_TIMEOUT,
@@ -4515,6 +4516,9 @@ static const struct {
 			 "HCI Set Event Filter command not supported."),
 	HCI_QUIRK_BROKEN(ENHANCED_SETUP_SYNC_CONN,
 			 "HCI Enhanced Setup Synchronous Connection command is "
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
+			 "HCI LE Set Random Private Address Timeout command is "
 			 "advertised, but not supported.")
 };
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e62dadad81b3..ee8f806534df 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4694,7 +4694,6 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan) {
-		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 02bb620d3b8d..bd54f17e3c3d 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -42,7 +42,7 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 	    eth_type_vlan(skb->protocol)) {
 		int depth;
 
-		if (!__vlan_get_protocol(skb, skb->protocol, &depth))
+		if (!vlan_get_protocol_and_depth(skb, skb->protocol, &depth))
 			goto drop;
 
 		skb_set_network_header(skb, depth);
diff --git a/net/bridge/br_private_tunnel.h b/net/bridge/br_private_tunnel.h
index 2b053289f016..efb096025151 100644
--- a/net/bridge/br_private_tunnel.h
+++ b/net/bridge/br_private_tunnel.h
@@ -27,6 +27,10 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
 int br_get_vlan_tunnel_info_size(struct net_bridge_vlan_group *vg);
 int br_fill_vlan_tunnel_info(struct sk_buff *skb,
 			     struct net_bridge_vlan_group *vg);
+bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
+			const struct net_bridge_vlan *v_last);
+int br_vlan_tunnel_info(const struct net_bridge_port *p, int cmd,
+			u16 vid, u32 tun_id, bool *changed);
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 /* br_vlan_tunnel.c */
@@ -43,10 +47,6 @@ void br_handle_ingress_vlan_tunnel(struct sk_buff *skb,
 				   struct net_bridge_vlan_group *vg);
 int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
 				 struct net_bridge_vlan *vlan);
-bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
-			const struct net_bridge_vlan *v_last);
-int br_vlan_tunnel_info(const struct net_bridge_port *p, int cmd,
-			u16 vid, u32 tun_id, bool *changed);
 #else
 static inline int vlan_tunnel_init(struct net_bridge_vlan_group *vg)
 {
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 5761d4ab839d..1af623839bff 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1106,7 +1106,7 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	struct isotp_sock *so = isotp_sk(sk);
 	int ret = 0;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
+	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
 	if (!so->bound)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index b670ba03a675..4fb3a99b5f67 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -798,7 +798,7 @@ static int j1939_sk_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct j1939_sk_buff_cb *skcb;
 	int ret = 0;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_ERRQUEUE))
+	if (flags & ~(MSG_DONTWAIT | MSG_ERRQUEUE | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
 	if (flags & MSG_ERRQUEUE)
diff --git a/net/core/datagram.c b/net/core/datagram.c
index e4ff2db40c98..8dabb9a74cb1 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -799,18 +799,21 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
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
@@ -819,10 +822,12 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 
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
index a25b8741b159..93d430693ca0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2549,6 +2549,8 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 	struct xps_map *map, *new_map;
 	unsigned int nr_ids;
 
+	WARN_ON_ONCE(index >= dev->num_tx_queues);
+
 	if (dev->num_tc) {
 		/* Do not allow XPS on subordinate device directly */
 		num_tc = dev->num_tc;
@@ -3350,7 +3352,7 @@ __be16 skb_network_protocol(struct sk_buff *skb, int *depth)
 		type = eth->h_proto;
 	}
 
-	return __vlan_get_protocol(skb, type, depth);
+	return vlan_get_protocol_and_depth(skb, type, depth);
 }
 
 /* openvswitch calls this on rx path, so we need a different check.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ccfd9053754a..47660002cada 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5053,7 +5053,7 @@ bool skb_partial_csum_set(struct sk_buff *skb, u16 start, u16 off)
 	u32 csum_end = (u32)start + (u32)off + sizeof(__sum16);
 	u32 csum_start = skb_headroom(skb) + (u32)start;
 
-	if (unlikely(csum_start > U16_MAX || csum_end > skb_headlen(skb))) {
+	if (unlikely(csum_start >= U16_MAX || csum_end > skb_headlen(skb))) {
 		net_warn_ratelimited("bad partial csum: csum=%u/%u headroom=%u headlen=%u\n",
 				     start, off, skb_headroom(skb), skb_headlen(skb));
 		return false;
@@ -5061,7 +5061,7 @@ bool skb_partial_csum_set(struct sk_buff *skb, u16 start, u16 off)
 	skb->ip_summed = CHECKSUM_PARTIAL;
 	skb->csum_start = csum_start;
 	skb->csum_offset = off;
-	skb_set_transport_header(skb, start);
+	skb->transport_header = csum_start;
 	return true;
 }
 EXPORT_SYMBOL_GPL(skb_partial_csum_set);
diff --git a/net/core/stream.c b/net/core/stream.c
index cbb268c15251..5b05b889d31a 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -73,8 +73,8 @@ int sk_stream_wait_connect(struct sock *sk, long *timeo_p)
 		add_wait_queue(sk_sleep(sk), &wait);
 		sk->sk_write_pending++;
 		done = sk_wait_event(sk, timeo_p,
-				     !sk->sk_err &&
-				     !((1 << sk->sk_state) &
+				     !READ_ONCE(sk->sk_err) &&
+				     !((1 << READ_ONCE(sk->sk_state)) &
 				       ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)), &wait);
 		remove_wait_queue(sk_sleep(sk), &wait);
 		sk->sk_write_pending--;
@@ -87,9 +87,9 @@ EXPORT_SYMBOL(sk_stream_wait_connect);
  * sk_stream_closing - Return 1 if we still have things to send in our buffers.
  * @sk: socket to verify
  */
-static inline int sk_stream_closing(struct sock *sk)
+static int sk_stream_closing(const struct sock *sk)
 {
-	return (1 << sk->sk_state) &
+	return (1 << READ_ONCE(sk->sk_state)) &
 	       (TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK);
 }
 
@@ -142,8 +142,8 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk->sk_write_pending++;
-		sk_wait_event(sk, &current_timeo, sk->sk_err ||
-						  (sk->sk_shutdown & SEND_SHUTDOWN) ||
+		sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) ||
+						  (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
 						  (sk_stream_memory_free(sk) &&
 						  !vm_wait), &wait);
 		sk->sk_write_pending--;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 5b19b77d5d75..5fd0ff5734e3 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -897,7 +897,7 @@ int inet_shutdown(struct socket *sock, int how)
 		   EPOLLHUP, even on eg. unconnected UDP sockets -- RR */
 		fallthrough;
 	default:
-		sk->sk_shutdown |= how;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | how);
 		if (sk->sk_prot->shutdown)
 			sk->sk_prot->shutdown(sk, how);
 		break;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6667c3538f2a..1fb67f819de4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -498,6 +498,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	__poll_t mask;
 	struct sock *sk = sock->sk;
 	const struct tcp_sock *tp = tcp_sk(sk);
+	u8 shutdown;
 	int state;
 
 	sock_poll_wait(file, sock, wait);
@@ -540,9 +541,10 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
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
@@ -559,7 +561,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 		if (tcp_stream_is_readable(sk, target))
 			mask |= EPOLLIN | EPOLLRDNORM;
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+		if (!(shutdown & SEND_SHUTDOWN)) {
 			if (__sk_stream_is_writeable(sk, 1)) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
@@ -2865,7 +2867,7 @@ void __tcp_close(struct sock *sk, long timeout)
 	int data_was_unread = 0;
 	int state;
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
@@ -3117,7 +3119,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 
 	inet_bhash2_reset_saddr(sk);
 
-	sk->sk_shutdown = 0;
+	WRITE_ONCE(sk->sk_shutdown, 0);
 	sock_reset_flag(sk, SOCK_DONE);
 	tp->srtt_us = 0;
 	tp->mdev_us = jiffies_to_usecs(TCP_TIMEOUT_INIT);
@@ -4645,7 +4647,7 @@ void tcp_done(struct sock *sk)
 	if (req)
 		reqsk_fastopen_remove(sk, req, false);
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk->sk_state_change(sk);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ebf917511937..2e9547467edb 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -168,7 +168,7 @@ static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	ret = sk_wait_event(sk, &timeo,
 			    !list_empty(&psock->ingress_msg) ||
-			    !skb_queue_empty(&sk->sk_receive_queue), &wait);
+			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
 	return ret;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0640453fce54..ac44edd6f52e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4361,7 +4361,7 @@ void tcp_fin(struct sock *sk)
 
 	inet_csk_schedule_ack(sk);
 
-	sk->sk_shutdown |= RCV_SHUTDOWN;
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 	sock_set_flag(sk, SOCK_DONE);
 
 	switch (sk->sk_state) {
@@ -6585,7 +6585,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			break;
 
 		tcp_set_state(sk, TCP_FIN_WAIT2);
-		sk->sk_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
 
 		sk_dst_confirm(sk);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ad0a5f185a69..b37c1bcb1509 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -829,6 +829,9 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 				   inet_twsk(sk)->tw_priority : sk->sk_priority;
 		transmit_time = tcp_transmit_time(sk);
 		xfrm_sk_clone_policy(ctl_sk, sk);
+	} else {
+		ctl_sk->sk_mark = 0;
+		ctl_sk->sk_priority = 0;
 	}
 	ip_send_unicast_reply(ctl_sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
@@ -836,7 +839,6 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 			      &arg, arg.iov[0].iov_len,
 			      transmit_time);
 
-	ctl_sk->sk_mark = 0;
 	xfrm_sk_free_policy(ctl_sk);
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
@@ -935,7 +937,6 @@ static void tcp_v4_send_ack(const struct sock *sk,
 			      &arg, arg.iov[0].iov_len,
 			      transmit_time);
 
-	ctl_sk->sk_mark = 0;
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	local_bh_enable();
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 4d5937af08ee..216b40ccadae 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1037,12 +1037,14 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
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
@@ -1065,24 +1067,25 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
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
 	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(atomic_fetch_inc(&t->o_seqno)));
 
 	/* TooBig packet may have updated dst->dev's mtu */
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 95edcbedf6ef..8c21de50eadf 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1940,7 +1940,8 @@ static u32 gen_reqid(struct net *net)
 }
 
 static int
-parse_ipsecrequest(struct xfrm_policy *xp, struct sadb_x_ipsecrequest *rq)
+parse_ipsecrequest(struct xfrm_policy *xp, struct sadb_x_policy *pol,
+		   struct sadb_x_ipsecrequest *rq)
 {
 	struct net *net = xp_net(xp);
 	struct xfrm_tmpl *t = xp->xfrm_vec + xp->xfrm_nr;
@@ -1958,9 +1959,12 @@ parse_ipsecrequest(struct xfrm_policy *xp, struct sadb_x_ipsecrequest *rq)
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
@@ -2002,7 +2006,7 @@ parse_ipsecrequests(struct xfrm_policy *xp, struct sadb_x_policy *pol)
 		    rq->sadb_x_ipsecrequest_len < sizeof(*rq))
 			return -EINVAL;
 
-		if ((err = parse_ipsecrequest(xp, rq)) < 0)
+		if ((err = parse_ipsecrequest(xp, pol, rq)) < 0)
 			return err;
 		len -= rq->sadb_x_ipsecrequest_len;
 		rq = (void*)((u8*)rq + rq->sadb_x_ipsecrequest_len);
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index da7fe94bea2e..9ffbc667be6c 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -583,7 +583,8 @@ static int llc_ui_wait_for_disc(struct sock *sk, long timeout)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
-		if (sk_wait_event(sk, &timeout, sk->sk_state == TCP_CLOSE, &wait))
+		if (sk_wait_event(sk, &timeout,
+				  READ_ONCE(sk->sk_state) == TCP_CLOSE, &wait))
 			break;
 		rc = -ERESTARTSYS;
 		if (signal_pending(current))
@@ -603,7 +604,8 @@ static bool llc_ui_wait_for_conn(struct sock *sk, long timeout)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
-		if (sk_wait_event(sk, &timeout, sk->sk_state != TCP_SYN_SENT, &wait))
+		if (sk_wait_event(sk, &timeout,
+				  READ_ONCE(sk->sk_state) != TCP_SYN_SENT, &wait))
 			break;
 		if (signal_pending(current) || !timeout)
 			break;
@@ -622,7 +624,7 @@ static int llc_ui_wait_for_busy_core(struct sock *sk, long timeout)
 	while (1) {
 		rc = 0;
 		if (sk_wait_event(sk, &timeout,
-				  (sk->sk_shutdown & RCV_SHUTDOWN) ||
+				  (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) ||
 				  (!llc_data_accept_state(llc->state) &&
 				   !llc->remote_busy_flag &&
 				   !llc->p_flag), &wait))
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e8beec0a0ae1..06b9df2fbcd7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1477,9 +1477,10 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		sdata_dereference(link->u.ap.unsol_bcast_probe_resp,
 				  sdata);
 
-	/* abort any running channel switch */
+	/* abort any running channel switch or color change */
 	mutex_lock(&local->mtx);
 	link_conf->csa_active = false;
+	link_conf->color_change_active = false;
 	if (link->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 9f4377566c42..c85367a4757a 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -67,7 +67,7 @@
 			__entry->min_freq_offset = (c)->chan ? (c)->chan->freq_offset : 0;	\
 			__entry->min_chan_width = (c)->width;				\
 			__entry->min_center_freq1 = (c)->center_freq1;			\
-			__entry->freq1_offset = (c)->freq1_offset;			\
+			__entry->min_freq1_offset = (c)->freq1_offset;			\
 			__entry->min_center_freq2 = (c)->center_freq2;
 #define MIN_CHANDEF_PR_FMT	" min_control:%d.%03d MHz min_width:%d min_center: %d.%03d/%d MHz"
 #define MIN_CHANDEF_PR_ARG	__entry->min_control_freq, __entry->min_freq_offset,	\
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6a1708db652f..763cefd0cc26 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3718,6 +3718,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	ieee80211_tx_result r;
 	struct ieee80211_vif *vif = txq->vif;
 	int q = vif->hw_queue[txq->ac];
+	unsigned long flags;
 	bool q_stopped;
 
 	WARN_ON_ONCE(softirq_count() == 0);
@@ -3726,9 +3727,9 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 		return NULL;
 
 begin:
-	spin_lock(&local->queue_stop_reason_lock);
+	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
 	q_stopped = local->queue_stop_reasons[q];
-	spin_unlock(&local->queue_stop_reason_lock);
+	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
 	if (unlikely(q_stopped)) {
 		/* mark for waking later */
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 6e80f0f6149e..55a7f72d547c 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -699,9 +699,11 @@ void nf_conntrack_destroy(struct nf_conntrack *nfct)
 
 	rcu_read_lock();
 	ct_hook = rcu_dereference(nf_ct_hook);
-	BUG_ON(ct_hook == NULL);
-	ct_hook->destroy(nfct);
+	if (ct_hook)
+		ct_hook->destroy(nfct);
 	rcu_read_unlock();
+
+	WARN_ON(!ct_hook);
 }
 EXPORT_SYMBOL(nf_conntrack_destroy);
 
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 4963fec815da..d4fe7bb4f853 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -603,7 +603,7 @@ static void ip_vs_sync_conn_v0(struct netns_ipvs *ipvs, struct ip_vs_conn *cp,
 	if (cp->flags & IP_VS_CONN_F_SEQ_MASK) {
 		struct ip_vs_sync_conn_options *opt =
 			(struct ip_vs_sync_conn_options *)&s[1];
-		memcpy(opt, &cp->in_seq, sizeof(*opt));
+		memcpy(opt, &cp->sync_conn_opt, sizeof(*opt));
 	}
 
 	m->nr_conns++;
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 460294bd4b60..52245dbfae31 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -1222,11 +1222,12 @@ static int __init nf_conntrack_standalone_init(void)
 	nf_conntrack_htable_size_user = nf_conntrack_htable_size;
 #endif
 
+	nf_conntrack_init_end();
+
 	ret = register_pernet_subsys(&nf_conntrack_net_ops);
 	if (ret < 0)
 		goto out_pernet;
 
-	nf_conntrack_init_end();
 	return 0;
 
 out_pernet:
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f663262df698..31775d54f4b4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3692,12 +3692,10 @@ static struct nft_rule *nft_rule_lookup_byid(const struct net *net,
 	struct nft_trans *trans;
 
 	list_for_each_entry(trans, &nft_net->commit_list, list) {
-		struct nft_rule *rule = nft_trans_rule(trans);
-
 		if (trans->msg_type == NFT_MSG_NEWRULE &&
 		    trans->ctx.chain == chain &&
 		    id == nft_trans_rule_id(trans))
-			return rule;
+			return nft_trans_rule(trans);
 	}
 	return ERR_PTR(-ENOENT);
 }
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index c3563f0be269..680fe557686e 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -344,6 +344,12 @@ static void nft_netdev_event(unsigned long event, struct net_device *dev,
 		return;
 	}
 
+	/* UNREGISTER events are also happening on netns exit.
+	 *
+	 * Although nf_tables core releases all tables/chains, only this event
+	 * handler provides guarantee that hook->ops.dev is still accessible,
+	 * so we cannot skip exiting net namespaces.
+	 */
 	__nft_release_basechain(ctx);
 }
 
@@ -362,9 +368,6 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 	    event != NETDEV_CHANGENAME)
 		return NOTIFY_DONE;
 
-	if (!check_net(ctx.net))
-		return NOTIFY_DONE;
-
 	nft_net = nft_pernet(ctx.net);
 	mutex_lock(&nft_net->commit_mutex);
 	list_for_each_entry(table, &nft_net->tables, list) {
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 19ea4d3c3553..2f114aa10f1a 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -221,7 +221,7 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
-	struct nft_rbtree_elem *rbe_prev;
+	struct nft_rbtree_elem *rbe_prev = NULL;
 	struct nft_set_gc_batch *gcb;
 
 	gcb = nft_set_gc_batch_check(set, NULL, GFP_ATOMIC);
@@ -229,17 +229,21 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
 		return -ENOMEM;
 
 	/* search for expired end interval coming before this element. */
-	do {
+	while (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
 		if (nft_rbtree_interval_end(rbe_prev))
 			break;
 
 		prev = rb_prev(prev);
-	} while (prev != NULL);
+	}
+
+	if (rbe_prev) {
+		rb_erase(&rbe_prev->node, &priv->root);
+		atomic_dec(&set->nelems);
+	}
 
-	rb_erase(&rbe_prev->node, &priv->root);
 	rb_erase(&rbe->node, &priv->root);
-	atomic_sub(2, &set->nelems);
+	atomic_dec(&set->nelems);
 
 	nft_set_gc_batch_add(gcb, rbe);
 	nft_set_gc_batch_complete(gcb);
@@ -268,7 +272,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			       struct nft_set_ext **ext)
 {
 	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL;
-	struct rb_node *node, *parent, **p, *first = NULL;
+	struct rb_node *node, *next, *parent, **p, *first = NULL;
 	struct nft_rbtree *priv = nft_set_priv(set);
 	u8 genmask = nft_genmask_next(net);
 	int d, err;
@@ -307,7 +311,9 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	 * Values stored in the tree are in reversed order, starting from
 	 * highest to lowest value.
 	 */
-	for (node = first; node != NULL; node = rb_next(node)) {
+	for (node = first; node != NULL; node = next) {
+		next = rb_next(node);
+
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
 
 		if (!nft_set_elem_active(&rbe->ext, genmask))
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index b1dcc536521b..d1b19618890b 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1979,7 +1979,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
-	if (nlk->cb_running &&
+	if (READ_ONCE(nlk->cb_running) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
 		ret = netlink_dump(sk);
 		if (ret) {
@@ -2293,7 +2293,7 @@ static int netlink_dump(struct sock *sk)
 	if (cb->done)
 		cb->done(cb);
 
-	nlk->cb_running = false;
+	WRITE_ONCE(nlk->cb_running, false);
 	module = cb->module;
 	skb = cb->skb;
 	mutex_unlock(nlk->cb_mutex);
@@ -2356,7 +2356,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 			goto error_put;
 	}
 
-	nlk->cb_running = true;
+	WRITE_ONCE(nlk->cb_running, true);
 	nlk->dump_done_errno = INT_MAX;
 
 	mutex_unlock(nlk->cb_mutex);
@@ -2681,7 +2681,7 @@ static int netlink_native_seq_show(struct seq_file *seq, void *v)
 			   nlk->groups ? (u32)nlk->groups[0] : 0,
 			   sk_rmem_alloc_get(s),
 			   sk_wmem_alloc_get(s),
-			   nlk->cb_running,
+			   READ_ONCE(nlk->cb_running),
 			   refcount_read(&s->sk_refcnt),
 			   atomic_read(&s->sk_drops),
 			   sock_i_ino(s)
diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index e9ca007718b7..0f23e5e8e03e 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -77,13 +77,12 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
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
@@ -108,15 +107,14 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
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
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 2af2ab924d64..67771b0f5771 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1936,10 +1936,8 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 	/* Move network header to the right position for VLAN tagged packets */
 	if (likely(skb->dev->type == ARPHRD_ETHER) &&
 	    eth_type_vlan(skb->protocol) &&
-	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0) {
-		if (pskb_may_pull(skb, depth))
-			skb_set_network_header(skb, depth);
-	}
+	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
+		skb_set_network_header(skb, depth);
 
 	skb_probe_transport_header(skb);
 }
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 31db7438857c..dbdf03e8aa5b 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -67,8 +67,8 @@ static void smc_close_stream_wait(struct smc_sock *smc, long timeout)
 
 		rc = sk_wait_event(sk, &timeout,
 				   !smc_tx_prepared_sends(&smc->conn) ||
-				   sk->sk_err == ECONNABORTED ||
-				   sk->sk_err == ECONNRESET ||
+				   READ_ONCE(sk->sk_err) == ECONNABORTED ||
+				   READ_ONCE(sk->sk_err) == ECONNRESET ||
 				   smc->conn.killed,
 				   &wait);
 		if (rc)
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 17c5aee7ee4f..ffcc9996a3da 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -263,9 +263,9 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	add_wait_queue(sk_sleep(sk), &wait);
 	rc = sk_wait_event(sk, timeo,
-			   sk->sk_err ||
+			   READ_ONCE(sk->sk_err) ||
 			   cflags->peer_conn_abort ||
-			   sk->sk_shutdown & RCV_SHUTDOWN ||
+			   READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN ||
 			   conn->killed ||
 			   fcrit(conn),
 			   &wait);
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index f4b6a71ac488..45128443f1f1 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -113,8 +113,8 @@ static int smc_tx_wait(struct smc_sock *smc, int flags)
 			break; /* at least 1 byte of free & no urgent data */
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk_wait_event(sk, &timeo,
-			      sk->sk_err ||
-			      (sk->sk_shutdown & SEND_SHUTDOWN) ||
+			      READ_ONCE(sk->sk_err) ||
+			      (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
 			      smc_cdc_rxed_any_close(conn) ||
 			      (atomic_read(&conn->sndbuf_space) &&
 			       !conn->urg_tx_pend),
diff --git a/net/socket.c b/net/socket.c
index 577079a8935f..c2e0a22f16d9 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2890,7 +2890,7 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 		 * error to return on the next call or if the
 		 * app asks about it using getsockopt(SO_ERROR).
 		 */
-		sock->sk->sk_err = -err;
+		WRITE_ONCE(sock->sk->sk_err, -err);
 	}
 out_put:
 	fput_light(sock->file, fput_needed);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9ee32e06f877..9b0b21cccca9 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1007,7 +1007,7 @@ static int __svc_register(struct net *net, const char *progname,
 #endif
 	}
 
-	trace_svc_register(progname, version, protocol, port, family, error);
+	trace_svc_register(progname, version, family, protocol, port, error);
 	return error;
 }
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index c2ce12538008..8117d0e08d5a 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -534,13 +534,23 @@ void svc_reserve(struct svc_rqst *rqstp, int space)
 }
 EXPORT_SYMBOL_GPL(svc_reserve);
 
+static void free_deferred(struct svc_xprt *xprt, struct svc_deferred_req *dr)
+{
+	if (!dr)
+		return;
+
+	xprt->xpt_ops->xpo_release_ctxt(xprt, dr->xprt_ctxt);
+	kfree(dr);
+}
+
 static void svc_xprt_release(struct svc_rqst *rqstp)
 {
 	struct svc_xprt	*xprt = rqstp->rq_xprt;
 
-	xprt->xpt_ops->xpo_release_rqst(rqstp);
+	xprt->xpt_ops->xpo_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
+	rqstp->rq_xprt_ctxt = NULL;
 
-	kfree(rqstp->rq_deferred);
+	free_deferred(xprt, rqstp->rq_deferred);
 	rqstp->rq_deferred = NULL;
 
 	pagevec_release(&rqstp->rq_pvec);
@@ -1059,7 +1069,7 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 	spin_unlock_bh(&serv->sv_lock);
 
 	while ((dr = svc_deferred_dequeue(xprt)) != NULL)
-		kfree(dr);
+		free_deferred(xprt, dr);
 
 	call_xpt_users(xprt);
 	svc_xprt_put(xprt);
@@ -1181,8 +1191,8 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
 	if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
 		spin_unlock(&xprt->xpt_lock);
 		trace_svc_defer_drop(dr);
+		free_deferred(xprt, dr);
 		svc_xprt_put(xprt);
-		kfree(dr);
 		return;
 	}
 	dr->xprt = NULL;
@@ -1227,14 +1237,14 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		dr->addrlen = rqstp->rq_addrlen;
 		dr->daddr = rqstp->rq_daddr;
 		dr->argslen = rqstp->rq_arg.len >> 2;
-		dr->xprt_ctxt = rqstp->rq_xprt_ctxt;
-		rqstp->rq_xprt_ctxt = NULL;
 
 		/* back up head to the start of the buffer and copy */
 		skip = rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
 		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base - skip,
 		       dr->argslen << 2);
 	}
+	dr->xprt_ctxt = rqstp->rq_xprt_ctxt;
+	rqstp->rq_xprt_ctxt = NULL;
 	trace_svc_defer(rqstp);
 	svc_xprt_get(rqstp->rq_xprt);
 	dr->xprt = rqstp->rq_xprt;
@@ -1267,6 +1277,8 @@ static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 	rqstp->rq_daddr       = dr->daddr;
 	rqstp->rq_respages    = rqstp->rq_pages;
 	rqstp->rq_xprt_ctxt   = dr->xprt_ctxt;
+
+	dr->xprt_ctxt = NULL;
 	svc_xprt_received(rqstp->rq_xprt);
 	return dr->argslen << 2;
 }
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 815baf308236..7107fbcbff34 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -111,27 +111,27 @@ static void svc_reclassify_socket(struct socket *sock)
 #endif
 
 /**
- * svc_tcp_release_rqst - Release transport-related resources
- * @rqstp: request structure with resources to be released
+ * svc_tcp_release_ctxt - Release transport-related resources
+ * @xprt: the transport which owned the context
+ * @ctxt: the context from rqstp->rq_xprt_ctxt or dr->xprt_ctxt
  *
  */
-static void svc_tcp_release_rqst(struct svc_rqst *rqstp)
+static void svc_tcp_release_ctxt(struct svc_xprt *xprt, void *ctxt)
 {
 }
 
 /**
- * svc_udp_release_rqst - Release transport-related resources
- * @rqstp: request structure with resources to be released
+ * svc_udp_release_ctxt - Release transport-related resources
+ * @xprt: the transport which owned the context
+ * @ctxt: the context from rqstp->rq_xprt_ctxt or dr->xprt_ctxt
  *
  */
-static void svc_udp_release_rqst(struct svc_rqst *rqstp)
+static void svc_udp_release_ctxt(struct svc_xprt *xprt, void *ctxt)
 {
-	struct sk_buff *skb = rqstp->rq_xprt_ctxt;
+	struct sk_buff *skb = ctxt;
 
-	if (skb) {
-		rqstp->rq_xprt_ctxt = NULL;
+	if (skb)
 		consume_skb(skb);
-	}
 }
 
 union svc_pktinfo_u {
@@ -559,7 +559,8 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	unsigned int sent;
 	int err;
 
-	svc_udp_release_rqst(rqstp);
+	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
+	rqstp->rq_xprt_ctxt = NULL;
 
 	svc_set_cmsg_data(rqstp, cmh);
 
@@ -631,7 +632,7 @@ static const struct svc_xprt_ops svc_udp_ops = {
 	.xpo_recvfrom = svc_udp_recvfrom,
 	.xpo_sendto = svc_udp_sendto,
 	.xpo_result_payload = svc_sock_result_payload,
-	.xpo_release_rqst = svc_udp_release_rqst,
+	.xpo_release_ctxt = svc_udp_release_ctxt,
 	.xpo_detach = svc_sock_detach,
 	.xpo_free = svc_sock_free,
 	.xpo_has_wspace = svc_udp_has_wspace,
@@ -1159,7 +1160,8 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	unsigned int sent;
 	int err;
 
-	svc_tcp_release_rqst(rqstp);
+	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
+	rqstp->rq_xprt_ctxt = NULL;
 
 	atomic_inc(&svsk->sk_sendqlen);
 	mutex_lock(&xprt->xpt_mutex);
@@ -1204,7 +1206,7 @@ static const struct svc_xprt_ops svc_tcp_ops = {
 	.xpo_recvfrom = svc_tcp_recvfrom,
 	.xpo_sendto = svc_tcp_sendto,
 	.xpo_result_payload = svc_sock_result_payload,
-	.xpo_release_rqst = svc_tcp_release_rqst,
+	.xpo_release_ctxt = svc_tcp_release_ctxt,
 	.xpo_detach = svc_tcp_sock_detach,
 	.xpo_free = svc_sock_free,
 	.xpo_has_wspace = svc_tcp_has_wspace,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 5242ad121450..53a7cb2f6c07 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -239,21 +239,20 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 }
 
 /**
- * svc_rdma_release_rqst - Release transport-specific per-rqst resources
- * @rqstp: svc_rqst being released
+ * svc_rdma_release_ctxt - Release transport-specific per-rqst resources
+ * @xprt: the transport which owned the context
+ * @vctxt: the context from rqstp->rq_xprt_ctxt or dr->xprt_ctxt
  *
  * Ensure that the recv_ctxt is released whether or not a Reply
  * was sent. For example, the client could close the connection,
  * or svc_process could drop an RPC, before the Reply is sent.
  */
-void svc_rdma_release_rqst(struct svc_rqst *rqstp)
+void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *vctxt)
 {
-	struct svc_rdma_recv_ctxt *ctxt = rqstp->rq_xprt_ctxt;
-	struct svc_xprt *xprt = rqstp->rq_xprt;
+	struct svc_rdma_recv_ctxt *ctxt = vctxt;
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 
-	rqstp->rq_xprt_ctxt = NULL;
 	if (ctxt)
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
 }
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 94b20fb47135..f776f0cb471f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -81,7 +81,7 @@ static const struct svc_xprt_ops svc_rdma_ops = {
 	.xpo_recvfrom = svc_rdma_recvfrom,
 	.xpo_sendto = svc_rdma_sendto,
 	.xpo_result_payload = svc_rdma_result_payload,
-	.xpo_release_rqst = svc_rdma_release_rqst,
+	.xpo_release_ctxt = svc_rdma_release_ctxt,
 	.xpo_detach = svc_rdma_detach,
 	.xpo_free = svc_rdma_free,
 	.xpo_has_wspace = svc_rdma_has_wspace,
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 35cac7733fd3..53881406e200 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -541,6 +541,19 @@ int tipc_bearer_mtu(struct net *net, u32 bearer_id)
 	return mtu;
 }
 
+int tipc_bearer_min_mtu(struct net *net, u32 bearer_id)
+{
+	int mtu = TIPC_MIN_BEARER_MTU;
+	struct tipc_bearer *b;
+
+	rcu_read_lock();
+	b = bearer_get(net, bearer_id);
+	if (b)
+		mtu += b->encap_hlen;
+	rcu_read_unlock();
+	return mtu;
+}
+
 /* tipc_bearer_xmit_skb - sends buffer to destination over bearer
  */
 void tipc_bearer_xmit_skb(struct net *net, u32 bearer_id,
@@ -1138,8 +1151,8 @@ int __tipc_nl_bearer_set(struct sk_buff *skb, struct genl_info *info)
 				return -EINVAL;
 			}
 #ifdef CONFIG_TIPC_MEDIA_UDP
-			if (tipc_udp_mtu_bad(nla_get_u32
-					     (props[TIPC_NLA_PROP_MTU]))) {
+			if (nla_get_u32(props[TIPC_NLA_PROP_MTU]) <
+			    b->encap_hlen + TIPC_MIN_BEARER_MTU) {
 				NL_SET_ERR_MSG(info->extack,
 					       "MTU value is out-of-range");
 				return -EINVAL;
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index 490ad6e5f7a3..bd0cc5c287ef 100644
--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -146,6 +146,7 @@ struct tipc_media {
  * @identity: array index of this bearer within TIPC bearer array
  * @disc: ptr to link setup request
  * @net_plane: network plane ('A' through 'H') currently associated with bearer
+ * @encap_hlen: encap headers length
  * @up: bearer up flag (bit 0)
  * @refcnt: tipc_bearer reference counter
  *
@@ -170,6 +171,7 @@ struct tipc_bearer {
 	u32 identity;
 	struct tipc_discoverer *disc;
 	char net_plane;
+	u16 encap_hlen;
 	unsigned long up;
 	refcount_t refcnt;
 };
@@ -232,6 +234,7 @@ int tipc_bearer_setup(void);
 void tipc_bearer_cleanup(void);
 void tipc_bearer_stop(struct net *net);
 int tipc_bearer_mtu(struct net *net, u32 bearer_id);
+int tipc_bearer_min_mtu(struct net *net, u32 bearer_id);
 bool tipc_bearer_bcast_support(struct net *net, u32 bearer_id);
 void tipc_bearer_xmit_skb(struct net *net, u32 bearer_id,
 			  struct sk_buff *skb,
diff --git a/net/tipc/link.c b/net/tipc/link.c
index b3ce24823f50..2eff1c7949cb 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -2200,7 +2200,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 	struct tipc_msg *hdr = buf_msg(skb);
 	struct tipc_gap_ack_blks *ga = NULL;
 	bool reply = msg_probe(hdr), retransmitted = false;
-	u32 dlen = msg_data_sz(hdr), glen = 0;
+	u32 dlen = msg_data_sz(hdr), glen = 0, msg_max;
 	u16 peers_snd_nxt =  msg_next_sent(hdr);
 	u16 peers_tol = msg_link_tolerance(hdr);
 	u16 peers_prio = msg_linkprio(hdr);
@@ -2239,6 +2239,9 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 	switch (mtyp) {
 	case RESET_MSG:
 	case ACTIVATE_MSG:
+		msg_max = msg_max_pkt(hdr);
+		if (msg_max < tipc_bearer_min_mtu(l->net, l->bearer_id))
+			break;
 		/* Complete own link name with peer's interface name */
 		if_name =  strrchr(l->name, ':') + 1;
 		if (sizeof(l->name) - (if_name - l->name) <= TIPC_MAX_IF_NAME)
@@ -2283,8 +2286,8 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 		l->peer_session = msg_session(hdr);
 		l->in_session = true;
 		l->peer_bearer_id = msg_bearer_id(hdr);
-		if (l->mtu > msg_max_pkt(hdr))
-			l->mtu = msg_max_pkt(hdr);
+		if (l->mtu > msg_max)
+			l->mtu = msg_max;
 		break;
 
 	case STATE_MSG:
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index ff5bb9e4731c..14027a7a7bef 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -313,9 +313,9 @@ static void tsk_rej_rx_queue(struct sock *sk, int error)
 		tipc_sk_respond(sk, skb, error);
 }
 
-static bool tipc_sk_connected(struct sock *sk)
+static bool tipc_sk_connected(const struct sock *sk)
 {
-	return sk->sk_state == TIPC_ESTABLISHED;
+	return READ_ONCE(sk->sk_state) == TIPC_ESTABLISHED;
 }
 
 /* tipc_sk_type_connectionless - check if the socket is datagram socket
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index c2bb818704c8..0a85244fd618 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -738,8 +738,8 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 			udp_conf.local_ip.s_addr = local.ipv4.s_addr;
 		udp_conf.use_udp_checksums = false;
 		ub->ifindex = dev->ifindex;
-		if (tipc_mtu_bad(dev, sizeof(struct iphdr) +
-				      sizeof(struct udphdr))) {
+		b->encap_hlen = sizeof(struct iphdr) + sizeof(struct udphdr);
+		if (tipc_mtu_bad(dev, b->encap_hlen)) {
 			err = -EINVAL;
 			goto err;
 		}
@@ -760,6 +760,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 		else
 			udp_conf.local_ip6 = local.ipv6;
 		ub->ifindex = dev->ifindex;
+		b->encap_hlen = sizeof(struct ipv6hdr) + sizeof(struct udphdr);
 		b->mtu = 1280;
 #endif
 	} else {
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b32c112984dd..f2e7302a4d96 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -111,7 +111,8 @@ int wait_on_pending_writer(struct sock *sk, long *timeo)
 			break;
 		}
 
-		if (sk_wait_event(sk, timeo, !sk->sk_write_pending, &wait))
+		if (sk_wait_event(sk, timeo,
+				  !READ_ONCE(sk->sk_write_pending), &wait))
 			break;
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7d17601ceee7..70eb3bc67126 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -602,7 +602,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	/* Clear state */
 	unix_state_lock(sk);
 	sock_orphan(sk);
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	path	     = u->path;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
@@ -627,7 +627,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 		if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET) {
 			unix_state_lock(skpair);
 			/* No more writes */
-			skpair->sk_shutdown = SHUTDOWN_MASK;
+			WRITE_ONCE(skpair->sk_shutdown, SHUTDOWN_MASK);
 			if (!skb_queue_empty(&sk->sk_receive_queue) || embrion)
 				skpair->sk_err = ECONNRESET;
 			unix_state_unlock(skpair);
@@ -1441,7 +1441,7 @@ static long unix_wait_for_peer(struct sock *other, long timeo)
 
 	sched = !sock_flag(other, SOCK_DEAD) &&
 		!(other->sk_shutdown & RCV_SHUTDOWN) &&
-		unix_recvq_full(other);
+		unix_recvq_full_lockless(other);
 
 	unix_state_unlock(other);
 
@@ -3007,7 +3007,7 @@ static int unix_shutdown(struct socket *sock, int mode)
 	++mode;
 
 	unix_state_lock(sk);
-	sk->sk_shutdown |= mode;
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | mode);
 	other = unix_peer(sk);
 	if (other)
 		sock_hold(other);
@@ -3027,7 +3027,7 @@ static int unix_shutdown(struct socket *sock, int mode)
 		if (mode&SEND_SHUTDOWN)
 			peer_mode |= RCV_SHUTDOWN;
 		unix_state_lock(other);
-		other->sk_shutdown |= peer_mode;
+		WRITE_ONCE(other->sk_shutdown, other->sk_shutdown | peer_mode);
 		unix_state_unlock(other);
 		other->sk_state_change(other);
 		if (peer_mode == SHUTDOWN_MASK)
@@ -3159,16 +3159,18 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
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
@@ -3202,18 +3204,20 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
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
index 884eca7f6743..8360c790a8a0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1427,7 +1427,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 			vsock_transport_cancel_pkt(vsk);
 			vsock_remove_connected(vsk);
 			goto out_wait;
-		} else if (timeout == 0) {
+		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
 			err = -ETIMEDOUT;
 			sk->sk_state = TCP_CLOSE;
 			sock->state = SS_UNCONNECTED;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 3d86482e83f5..6c2b73c0d36e 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -5,7 +5,7 @@
  * Copyright 2008 Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2016	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -543,6 +543,10 @@ static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 	/* skip the TBTT offset */
 	pos++;
 
+	/* ignore entries with invalid BSSID */
+	if (!is_valid_ether_addr(pos))
+		return -EINVAL;
+
 	memcpy(entry->bssid, pos, ETH_ALEN);
 	pos += ETH_ALEN;
 
diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
index 94a3609548b1..5a67b120c4db 100644
--- a/net/xfrm/xfrm_interface.c
+++ b/net/xfrm/xfrm_interface.c
@@ -310,52 +310,6 @@ static void xfrmi_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->mark = 0;
 }
 
-static int xfrmi_input(struct sk_buff *skb, int nexthdr, __be32 spi,
-		       int encap_type, unsigned short family)
-{
-	struct sec_path *sp;
-
-	sp = skb_sec_path(skb);
-	if (sp && (sp->len || sp->olen) &&
-	    !xfrm_policy_check(NULL, XFRM_POLICY_IN, skb, family))
-		goto discard;
-
-	XFRM_SPI_SKB_CB(skb)->family = family;
-	if (family == AF_INET) {
-		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
-		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
-	} else {
-		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
-		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = NULL;
-	}
-
-	return xfrm_input(skb, nexthdr, spi, encap_type);
-discard:
-	kfree_skb(skb);
-	return 0;
-}
-
-static int xfrmi4_rcv(struct sk_buff *skb)
-{
-	return xfrmi_input(skb, ip_hdr(skb)->protocol, 0, 0, AF_INET);
-}
-
-static int xfrmi6_rcv(struct sk_buff *skb)
-{
-	return xfrmi_input(skb, skb_network_header(skb)[IP6CB(skb)->nhoff],
-			   0, 0, AF_INET6);
-}
-
-static int xfrmi4_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
-{
-	return xfrmi_input(skb, nexthdr, spi, encap_type, AF_INET);
-}
-
-static int xfrmi6_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
-{
-	return xfrmi_input(skb, nexthdr, spi, encap_type, AF_INET6);
-}
-
 static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 {
 	const struct xfrm_mode *inner_mode;
@@ -983,8 +937,8 @@ static struct pernet_operations xfrmi_net_ops = {
 };
 
 static struct xfrm6_protocol xfrmi_esp6_protocol __read_mostly = {
-	.handler	=	xfrmi6_rcv,
-	.input_handler	=	xfrmi6_input,
+	.handler	=	xfrm6_rcv,
+	.input_handler	=	xfrm_input,
 	.cb_handler	=	xfrmi_rcv_cb,
 	.err_handler	=	xfrmi6_err,
 	.priority	=	10,
@@ -1034,8 +988,8 @@ static struct xfrm6_tunnel xfrmi_ip6ip_handler __read_mostly = {
 #endif
 
 static struct xfrm4_protocol xfrmi_esp4_protocol __read_mostly = {
-	.handler	=	xfrmi4_rcv,
-	.input_handler	=	xfrmi4_input,
+	.handler	=	xfrm4_rcv,
+	.input_handler	=	xfrm_input,
 	.cb_handler	=	xfrmi_rcv_cb,
 	.err_handler	=	xfrmi4_err,
 	.priority	=	10,
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7f49dab3b6b5..bc04cb83215f 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3637,12 +3637,6 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		}
 		xfrm_nr = ti;
 
-		if (net->xfrm.policy_default[dir] == XFRM_USERPOLICY_BLOCK &&
-		    !xfrm_nr) {
-			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
-			goto reject;
-		}
-
 		if (npols > 1) {
 			xfrm_tmpl_sort(stp, tpp, xfrm_nr, family);
 			tpp = stp;
@@ -3670,9 +3664,6 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 			goto reject;
 		}
 
-		if (if_id)
-			secpath_reset(skb);
-
 		xfrm_pols_put(pols, npols);
 		return 1;
 	}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 83f35ecacf24..2d68a173b227 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1743,7 +1743,7 @@ static void copy_templates(struct xfrm_policy *xp, struct xfrm_user_tmpl *ut,
 }
 
 static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family,
-			 struct netlink_ext_ack *extack)
+			 int dir, struct netlink_ext_ack *extack)
 {
 	u16 prev_family;
 	int i;
@@ -1769,6 +1769,10 @@ static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family,
 		switch (ut[i].mode) {
 		case XFRM_MODE_TUNNEL:
 		case XFRM_MODE_BEET:
+			if (ut[i].optional && dir == XFRM_POLICY_OUT) {
+				NL_SET_ERR_MSG(extack, "Mode in optional template not allowed in outbound policy");
+				return -EINVAL;
+			}
 			break;
 		default:
 			if (ut[i].family != prev_family) {
@@ -1806,7 +1810,7 @@ static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family,
 }
 
 static int copy_from_user_tmpl(struct xfrm_policy *pol, struct nlattr **attrs,
-			       struct netlink_ext_ack *extack)
+			       int dir, struct netlink_ext_ack *extack)
 {
 	struct nlattr *rt = attrs[XFRMA_TMPL];
 
@@ -1817,7 +1821,7 @@ static int copy_from_user_tmpl(struct xfrm_policy *pol, struct nlattr **attrs,
 		int nr = nla_len(rt) / sizeof(*utmpl);
 		int err;
 
-		err = validate_tmpl(nr, utmpl, pol->family, extack);
+		err = validate_tmpl(nr, utmpl, pol->family, dir, extack);
 		if (err)
 			return err;
 
@@ -1894,7 +1898,7 @@ static struct xfrm_policy *xfrm_policy_construct(struct net *net,
 	if (err)
 		goto error;
 
-	if (!(err = copy_from_user_tmpl(xp, attrs, extack)))
+	if (!(err = copy_from_user_tmpl(xp, attrs, p->dir, extack)))
 		err = copy_from_user_sec_ctx(xp, attrs);
 	if (err)
 		goto error;
@@ -3443,7 +3447,7 @@ static struct xfrm_policy *xfrm_compile_policy(struct sock *sk, int opt,
 		return NULL;
 
 	nr = ((len - sizeof(*p)) / sizeof(*ut));
-	if (validate_tmpl(nr, ut, p->sel.family, NULL))
+	if (validate_tmpl(nr, ut, p->sel.family, p->dir, NULL))
 		return NULL;
 
 	if (p->dir > XFRM_POLICY_OUT)
diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index 516fbac28b71..7f89700a17b6 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -315,6 +315,7 @@ static int run_bpf_prog(char *prog, int cg_id)
 		fout = fopen(fname, "w");
 		fprintf(fout, "id:%d\n", cg_id);
 		fprintf(fout, "ERROR: Could not lookup queue_stats\n");
+		fclose(fout);
 	} else if (stats_flag && qstats.lastPacketTime >
 		   qstats.firstPacketTime) {
 		long long delta_us = (qstats.lastPacketTime -
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index cce12e1971d8..ec692af8ce9e 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -102,6 +102,7 @@ static ssize_t uwrite(void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
+	void *p = NULL;
 
 	file_updated = 1;
 
@@ -109,7 +110,10 @@ static ssize_t uwrite(void const *const buf, size_t const count)
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
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index a15f55b0dce3..295163bb8abb 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -259,8 +259,10 @@ int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x)
 		return err;
 
 	err = init_stream(dg00x, &dg00x->tx_stream);
-	if (err < 0)
+	if (err < 0) {
 		destroy_stream(dg00x, &dg00x->rx_stream);
+		return err;
+	}
 
 	err = amdtp_domain_init(&dg00x->domain);
 	if (err < 0) {
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index fc114e522480..dbf7aa88e0e3 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1155,8 +1155,8 @@ static bool path_has_mixer(struct hda_codec *codec, int path_idx, int ctl_type)
 	return path && path->ctls[ctl_type];
 }
 
-static const char * const channel_name[4] = {
-	"Front", "Surround", "CLFE", "Side"
+static const char * const channel_name[] = {
+	"Front", "Surround", "CLFE", "Side", "Back",
 };
 
 /* give some appropriate ctl name prefix for the given line out channel */
@@ -1182,7 +1182,7 @@ static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
 
 	/* multi-io channels */
 	if (ch >= cfg->line_outs)
-		return channel_name[ch];
+		goto fixed_name;
 
 	switch (cfg->line_out_type) {
 	case AUTO_PIN_SPEAKER_OUT:
@@ -1234,6 +1234,7 @@ static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
 	if (cfg->line_outs == 1 && !spec->multi_ios)
 		return "Line Out";
 
+ fixed_name:
 	if (ch >= ARRAY_SIZE(channel_name)) {
 		snd_BUG();
 		return "PCM";
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 77a592f21947..881b2f3a1551 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2528,6 +2528,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* Meteorlake-P */
 	{ PCI_DEVICE(0x8086, 0x7e28),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Lunarlake-P */
+	{ PCI_DEVICE(0x8086, 0xa828),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5c6980394dce..be2c6cff7701 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4577,6 +4577,11 @@ HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI/DP",	patch_nvhdmi),
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
index 172ffc2c332b..c75760717736 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9363,7 +9363,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x802f, "HP Z240", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8077, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x103c, 0x8158, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
-	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x827f, "HP x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
@@ -9458,7 +9458,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa8, "HP EliteBook 640 G9 (MB 8AA6)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aab, "HP EliteBook 650 G9 (MB 8AA9)", ALC236_FIXUP_HP_GPIO_LED),
-	 SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b42, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
@@ -9469,8 +9469,13 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b47, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b5d, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8b63, "HP Elite Dragonfly 13.5 inch G4", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b65, "HP ProBook 455 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b66, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8b70, "HP EliteBook 835 G10", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8b72, "HP EliteBook 845 G10", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8b74, "HP EliteBook 845W G10", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8b77, "HP ElieBook 865 G10", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8b7a, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b7d, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b87, "HP", ALC236_FIXUP_HP_GPIO_LED),
@@ -9480,7 +9485,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b8f, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b92, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bf0, "HP", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c26, "HP HP EliteBook 800G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
@@ -9522,6 +9529,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
@@ -9618,6 +9626,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x7716, "Clevo NS50PU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x7717, "Clevo NS70PU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x7718, "Clevo L140PU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x7724, "Clevo L140AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8228, "Clevo NR40BU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8520, "Clevo NH50D[CD]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8521, "Clevo NH77D[CD]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -11663,6 +11672,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x103c, 0x870c, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0acdf0156f07..b9958e555367 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,6 +45,13 @@ static struct snd_soc_card acp6x_card = {
 };
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5525"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -178,6 +185,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21EN"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -262,6 +276,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16z-n000"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A42"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 4b8fe9b8be40..3a03f49452fa 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -712,7 +712,7 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to pcm register\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	fsl_micfil_dai.capture.formats = micfil->soc->formats;
@@ -722,9 +722,20 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register component %s\n",
 			fsl_micfil_component.name);
+		goto err_pm_disable;
 	}
 
 	return ret;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static void fsl_micfil_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
 }
 
 static int __maybe_unused fsl_micfil_runtime_suspend(struct device *dev)
@@ -785,6 +796,7 @@ static const struct dev_pm_ops fsl_micfil_pm_ops = {
 
 static struct platform_driver fsl_micfil_driver = {
 	.probe = fsl_micfil_probe,
+	.remove_new = fsl_micfil_remove,
 	.driver = {
 		.name = "fsl-micfil-dai",
 		.pm = &fsl_micfil_pm_ops,
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-clk.c b/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
index a6b4f29049bb..539e3a023bc4 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
@@ -644,9 +644,3 @@ int mt8186_init_clock(struct mtk_base_afe *afe)
 
 	return 0;
 }
-
-void mt8186_deinit_clock(void *priv)
-{
-	struct mtk_base_afe *afe = priv;
-	mt8186_audsys_clk_unregister(afe);
-}
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-clk.h b/sound/soc/mediatek/mt8186/mt8186-afe-clk.h
index d5988717d8f2..a9d59e506d9a 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-clk.h
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-clk.h
@@ -81,7 +81,6 @@ enum {
 struct mtk_base_afe;
 int mt8186_set_audio_int_bus_parent(struct mtk_base_afe *afe, int clk_id);
 int mt8186_init_clock(struct mtk_base_afe *afe);
-void mt8186_deinit_clock(void *priv);
 int mt8186_afe_enable_cgs(struct mtk_base_afe *afe);
 void mt8186_afe_disable_cgs(struct mtk_base_afe *afe);
 int mt8186_afe_enable_clock(struct mtk_base_afe *afe);
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index d7e94e6a19c7..0e3792ccd49f 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -2847,10 +2847,6 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev, mt8186_deinit_clock, (void *)afe);
-	if (ret)
-		return ret;
-
 	/* init memif */
 	afe->memif_32bit_supported = 0;
 	afe->memif_size = MT8186_MEMIF_NUM;
diff --git a/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
index 578969ca91c8..5666be6b1bd2 100644
--- a/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
+++ b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
@@ -84,6 +84,29 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
 	GATE_AUD2(CLK_AUD_ETDM_OUT1_BCLK, "aud_etdm_out1_bclk", "top_audio", 24),
 };
 
+static void mt8186_audsys_clk_unregister(void *data)
+{
+	struct mtk_base_afe *afe = data;
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	struct clk *clk;
+	struct clk_lookup *cl;
+	int i;
+
+	if (!afe_priv)
+		return;
+
+	for (i = 0; i < CLK_AUD_NR_CLK; i++) {
+		cl = afe_priv->lookup[i];
+		if (!cl)
+			continue;
+
+		clk = cl->clk;
+		clk_unregister_gate(clk);
+
+		clkdev_drop(cl);
+	}
+}
+
 int mt8186_audsys_clk_register(struct mtk_base_afe *afe)
 {
 	struct mt8186_afe_private *afe_priv = afe->platform_priv;
@@ -124,27 +147,6 @@ int mt8186_audsys_clk_register(struct mtk_base_afe *afe)
 		afe_priv->lookup[i] = cl;
 	}
 
-	return 0;
+	return devm_add_action_or_reset(afe->dev, mt8186_audsys_clk_unregister, afe);
 }
 
-void mt8186_audsys_clk_unregister(struct mtk_base_afe *afe)
-{
-	struct mt8186_afe_private *afe_priv = afe->platform_priv;
-	struct clk *clk;
-	struct clk_lookup *cl;
-	int i;
-
-	if (!afe_priv)
-		return;
-
-	for (i = 0; i < CLK_AUD_NR_CLK; i++) {
-		cl = afe_priv->lookup[i];
-		if (!cl)
-			continue;
-
-		clk = cl->clk;
-		clk_unregister_gate(clk);
-
-		clkdev_drop(cl);
-	}
-}
diff --git a/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
index b8d6a06e11e8..897a2914dc19 100644
--- a/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
+++ b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
@@ -10,6 +10,5 @@
 #define _MT8186_AUDSYS_CLK_H_
 
 int mt8186_audsys_clk_register(struct mtk_base_afe *afe);
-void mt8186_audsys_clk_unregister(struct mtk_base_afe *afe);
 
 #endif
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 6a0e7f3b5023..872e44408298 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -545,6 +545,10 @@ static int sof_copy_tuples(struct snd_sof_dev *sdev, struct snd_soc_tplg_vendor_
 				if (*num_copied_tuples == tuples_size)
 					return 0;
 			}
+
+			/* stop when we've found the required token instances */
+			if (found == num_tokens * token_instance_num)
+				return 0;
 		}
 
 		/* next array */
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 4b1c5ba121f3..ab5fed9f55b6 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -423,6 +423,7 @@ static int line6_parse_audio_format_rates_quirk(struct snd_usb_audio *chip,
 	case USB_ID(0x0e41, 0x4248): /* Line6 Helix >= fw 2.82 */
 	case USB_ID(0x0e41, 0x4249): /* Line6 Helix Rack >= fw 2.82 */
 	case USB_ID(0x0e41, 0x424a): /* Line6 Helix LT >= fw 2.82 */
+	case USB_ID(0x0e41, 0x424b): /* Line6 Pod Go */
 	case USB_ID(0x19f7, 0x0011): /* Rode Rodecaster Pro */
 		return set_fixed_rate(fp, 48000, SNDRV_PCM_RATE_48000);
 	}
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index b02c8e0f4057..1c7a0f6632c0 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -91,7 +91,6 @@
 
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
-#define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
 
 #ifndef O_NDELAY
 #define O_NDELAY	O_NONBLOCK
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index e7d48cb563c0..ae6af354a81d 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -70,8 +70,8 @@ static int max_freq_mode;
  */
 static unsigned long max_frequency;
 
-static unsigned long long tsc_at_measure_start;
-static unsigned long long tsc_at_measure_end;
+static unsigned long long *tsc_at_measure_start;
+static unsigned long long *tsc_at_measure_end;
 static unsigned long long *mperf_previous_count;
 static unsigned long long *aperf_previous_count;
 static unsigned long long *mperf_current_count;
@@ -169,7 +169,7 @@ static int mperf_get_count_percent(unsigned int id, double *percent,
 	aperf_diff = aperf_current_count[cpu] - aperf_previous_count[cpu];
 
 	if (max_freq_mode == MAX_FREQ_TSC_REF) {
-		tsc_diff = tsc_at_measure_end - tsc_at_measure_start;
+		tsc_diff = tsc_at_measure_end[cpu] - tsc_at_measure_start[cpu];
 		*percent = 100.0 * mperf_diff / tsc_diff;
 		dprint("%s: TSC Ref - mperf_diff: %llu, tsc_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, tsc_diff);
@@ -206,7 +206,7 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 
 	if (max_freq_mode == MAX_FREQ_TSC_REF) {
 		/* Calculate max_freq from TSC count */
-		tsc_diff = tsc_at_measure_end - tsc_at_measure_start;
+		tsc_diff = tsc_at_measure_end[cpu] - tsc_at_measure_start[cpu];
 		time_diff = timespec_diff_us(time_start, time_end);
 		max_frequency = tsc_diff / time_diff;
 	}
@@ -225,33 +225,27 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
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
 
@@ -353,7 +347,8 @@ struct cpuidle_monitor *mperf_register(void)
 	aperf_previous_count = calloc(cpu_count, sizeof(unsigned long long));
 	mperf_current_count = calloc(cpu_count, sizeof(unsigned long long));
 	aperf_current_count = calloc(cpu_count, sizeof(unsigned long long));
-
+	tsc_at_measure_start = calloc(cpu_count, sizeof(unsigned long long));
+	tsc_at_measure_end = calloc(cpu_count, sizeof(unsigned long long));
 	mperf_monitor.name_len = strlen(mperf_monitor.name);
 	return &mperf_monitor;
 }
@@ -364,6 +359,8 @@ void mperf_unregister(void)
 	free(aperf_previous_count);
 	free(mperf_current_count);
 	free(aperf_current_count);
+	free(tsc_at_measure_start);
+	free(tsc_at_measure_end);
 	free(is_valid);
 }
 
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 8833359556f3..fe4f9f430282 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -98,6 +98,11 @@ static int alloc_anon_50M_check(const char *cgroup, void *arg)
 	int ret = -1;
 
 	buf = malloc(size);
+	if (buf == NULL) {
+		fprintf(stderr, "malloc() failed\n");
+		return -1;
+	}
+
 	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
 		*ptr = 0;
 
@@ -211,6 +216,11 @@ static int alloc_anon_noexit(const char *cgroup, void *arg)
 	char *buf, *ptr;
 
 	buf = malloc(size);
+	if (buf == NULL) {
+		fprintf(stderr, "malloc() failed\n");
+		return -1;
+	}
+
 	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
 		*ptr = 0;
 
@@ -759,6 +769,11 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 	int ret = -1;
 
 	buf = malloc(size);
+	if (buf == NULL) {
+		fprintf(stderr, "malloc() failed\n");
+		return -1;
+	}
+
 	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
 		*ptr = 0;
 
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index a47b26ab48f2..0f5e88c8f4ff 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -2283,7 +2283,7 @@ EOF
 ################################################################################
 # main
 
-while getopts :t:pP46hv:w: o
+while getopts :t:pP46hvw: o
 do
 	case $o in
 		t) TESTS=$OPTARG;;
diff --git a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
index 1003119773e5..f96282362811 100755
--- a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
@@ -232,10 +232,14 @@ setup_rt_networking()
 	local nsname=rt-${rt}
 
 	ip netns add ${nsname}
+
+	ip netns exec ${nsname} sysctl -wq net.ipv6.conf.all.accept_dad=0
+	ip netns exec ${nsname} sysctl -wq net.ipv6.conf.default.accept_dad=0
+
 	ip link set veth-rt-${rt} netns ${nsname}
 	ip -netns ${nsname} link set veth-rt-${rt} name veth0
 
-	ip -netns ${nsname} addr add ${IPv6_RT_NETWORK}::${rt}/64 dev veth0
+	ip -netns ${nsname} addr add ${IPv6_RT_NETWORK}::${rt}/64 dev veth0 nodad
 	ip -netns ${nsname} link set veth0 up
 	ip -netns ${nsname} link set lo up
 
@@ -254,6 +258,12 @@ setup_hs()
 
 	# set the networking for the host
 	ip netns add ${hsname}
+
+	# disable the rp_filter otherwise the kernel gets confused about how
+	# to route decap ipv4 packets.
+	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
+	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.default.rp_filter=0
+
 	ip -netns ${hsname} link add veth0 type veth peer name ${rtveth}
 	ip -netns ${hsname} link set ${rtveth} netns ${rtname}
 	ip -netns ${hsname} addr add ${IPv4_HS_NETWORK}.${hs}/24 dev veth0
@@ -272,11 +282,6 @@ setup_hs()
 
 	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.${rtveth}.proxy_arp=1
 
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.${rtveth}.rp_filter=0
-
 	ip netns exec ${rtname} sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3a3c1bc3e303..de8e5eb6af10 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3947,18 +3947,19 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	}
 
 	vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
-	r = xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
-	BUG_ON(r == -EBUSY);
+	r = xa_reserve(&kvm->vcpu_array, vcpu->vcpu_idx, GFP_KERNEL_ACCOUNT);
 	if (r)
 		goto unlock_vcpu_destroy;
 
 	/* Now it's all set up, let userspace reach it */
 	kvm_get_kvm(kvm);
 	r = create_vcpu_fd(vcpu);
-	if (r < 0) {
-		xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
-		kvm_put_kvm_no_destroy(kvm);
-		goto unlock_vcpu_destroy;
+	if (r < 0)
+		goto kvm_put_xa_release;
+
+	if (KVM_BUG_ON(!!xa_store(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, 0), kvm)) {
+		r = -EINVAL;
+		goto kvm_put_xa_release;
 	}
 
 	/*
@@ -3973,6 +3974,9 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	kvm_create_vcpu_debugfs(vcpu);
 	return r;
 
+kvm_put_xa_release:
+	kvm_put_kvm_no_destroy(kvm);
+	xa_release(&kvm->vcpu_array, vcpu->vcpu_idx);
 unlock_vcpu_destroy:
 	mutex_unlock(&kvm->lock);
 	kvm_dirty_ring_free(&vcpu->dirty_ring);
