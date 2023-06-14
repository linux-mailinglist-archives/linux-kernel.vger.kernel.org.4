Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D8970FC87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjEXRUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEXRUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D5B130;
        Wed, 24 May 2023 10:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F5A563738;
        Wed, 24 May 2023 17:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9281CC4339E;
        Wed, 24 May 2023 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684948829;
        bh=cV8vbF/Z7GyVnwjO5jCfOpL2UeT8YwG1HR4CLpn3dsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwcKvp9ifiQRYkKo7Xx53+fmxeljknhVJTzwu2u5wbj02wgfX+RG9jNFctKoH4KK+
         JzeaL8kzhuHilgbzp816EDzYNDSF763xjL7dQ7QHo05ekIdZ/wllEAi487wZzQNvvZ
         /5579+ffTNkRnJJVlvQJsQ5DlKYr9gF2BNyvH7jU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.113
Date:   Wed, 24 May 2023 18:20:14 +0100
Message-Id: <2023052413-elevator-pummel-5831@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023052413-zombie-sublevel-14e7@gregkh>
References: <2023052413-zombie-sublevel-14e7@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 283a12cd3e14..4b2cd556483c 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -64,6 +64,18 @@ properties:
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
     minItems: 2
     maxItems: 2
diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3d2155c744..95374d582574 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8568,7 +8568,7 @@ F:	drivers/net/wireless/intersil/hostap/
 HP COMPAQ TC1100 TABLET WMI EXTRAS DRIVER
 L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
-F:	drivers/platform/x86/tc1100-wmi.c
+F:	drivers/platform/x86/hp/tc1100-wmi.c
 
 HPET:	High Precision Event Timers driver
 M:	Clemens Ladisch <clemens@ladisch.de>
@@ -10838,7 +10838,7 @@ M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained
 F:	Documentation/misc-devices/lis3lv02d.rst
 F:	drivers/misc/lis3lv02d/
-F:	drivers/platform/x86/hp_accel.c
+F:	drivers/platform/x86/hp/hp_accel.c
 
 LIST KUNIT TEST
 M:	David Gow <davidgow@google.com>
diff --git a/Makefile b/Makefile
index 774c2de28fa8..19f8af8266bb 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 112
+SUBLEVEL = 113
 EXTRAVERSION =
 NAME = Trick or Treat
 
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
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index b22d3c8db3b3..cd66bb16c739 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2595,8 +2595,11 @@ usb3_dwc3: dwc3@6a00000 {
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
 
diff --git a/arch/parisc/include/asm/pdc.h b/arch/parisc/include/asm/pdc.h
index b388d8176588..2f48e0a80d9c 100644
--- a/arch/parisc/include/asm/pdc.h
+++ b/arch/parisc/include/asm/pdc.h
@@ -81,6 +81,7 @@ int pdc_do_firm_test_reset(unsigned long ftc_bitmap);
 int pdc_do_reset(void);
 int pdc_soft_power_info(unsigned long *power_reg);
 int pdc_soft_power_button(int sw_control);
+int pdc_soft_power_button_panic(int sw_control);
 void pdc_io_reset(void);
 void pdc_io_reset_devices(void);
 int pdc_iodc_getc(void);
diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware.c
index 8e5a906df917..5385e0fe9842 100644
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -1158,15 +1158,18 @@ int __init pdc_soft_power_info(unsigned long *power_reg)
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
@@ -1180,6 +1183,22 @@ int pdc_soft_power_button(int sw_control)
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
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index feb24313e2e3..1d9d7efacbc7 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1045,8 +1045,8 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
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
index 8322ca86d5ac..33a9102b7cab 100644
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
index fbe2ba05c82a..1c862940cc5b 100644
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
index 4e583a8cb562..472418a0e0ca 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1101,6 +1101,7 @@ static void acpi_ec_remove_query_handlers(struct acpi_ec *ec,
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	acpi_ec_remove_query_handlers(ec, false, query_bit);
+	flush_workqueue(ec_query_wq);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index f2469d3435ca..0b517a83c449 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -343,6 +343,9 @@ int regcache_sync(struct regmap *map)
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
@@ -412,6 +415,9 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ade8b839e445..394355f12d4e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -326,6 +326,9 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
 		return -EINVAL;
 
+	if (bytesize < 0)
+		return -EINVAL;
+
 	nbd->config->bytesize = bytesize;
 	nbd->config->blksize_bits = __ffs(blksize);
 
@@ -1048,6 +1051,9 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct nbd_sock *nsock;
 	int err;
 
+	/* Arg will be cast to int, check it to avoid overflow */
+	if (arg > INT_MAX)
+		return -EINVAL;
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 033b0f64f2b9..686ec6bcdef3 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1744,6 +1744,11 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 
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
index a18f289d7346..f228cdbccaee 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2015  Intel Corporation
  */
 
+#include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/dmi.h>
@@ -33,6 +34,43 @@
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
@@ -86,9 +124,12 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
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
index d707aa63e944..2a4cc5d8c2d4 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2381,9 +2381,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
-		/* Valid LE States quirk for GfP */
-		if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
-			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+		/* Apply LE States quirk from solar onwards */
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev,
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index e53164c82808..dfb463ee7ca1 100644
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
 
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index d246a39a6b4f..cc57ababc882 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -18,24 +18,24 @@
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
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 1d86fd5610c0..228f098e5d88 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -406,11 +406,8 @@ static enum bp_result get_gpio_i2c_info(
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
 
diff --git a/drivers/gpu/drm/drm_displayid.c b/drivers/gpu/drm/drm_displayid.c
index 32da557b960f..82b7f0bb4409 100644
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
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 19fb1d93a4f0..0c806e99e869 100644
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
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 64a15b636e8d..6cc125857808 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1231,6 +1231,11 @@ static int intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
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
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index 2e816f232e85..ac0c221f8aa1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -12,7 +12,7 @@
 
 /**
  * Register offsets in MDSS register file for the interrupt registers
- * w.r.t. to the MDP base
+ * w.r.t. the MDP base
  */
 #define MDP_SSPP_TOP0_OFF		0x0
 #define MDP_INTF_0_OFF			0x6A000
@@ -20,6 +20,10 @@
 #define MDP_INTF_2_OFF			0x6B000
 #define MDP_INTF_3_OFF			0x6B800
 #define MDP_INTF_4_OFF			0x6C000
+#define MDP_INTF_5_OFF			0x6C800
+#define INTF_INTR_EN			0x1c0
+#define INTF_INTR_STATUS		0x1c4
+#define INTF_INTR_CLEAR			0x1c8
 #define MDP_AD4_0_OFF			0x7C000
 #define MDP_AD4_1_OFF			0x7D000
 #define MDP_AD4_INTR_EN_OFF		0x41c
@@ -87,6 +91,11 @@ static const struct dpu_intr_reg dpu_intr_set[] = {
 		MDP_INTF_4_OFF+INTF_INTR_EN,
 		MDP_INTF_4_OFF+INTF_INTR_STATUS
 	},
+	{
+		MDP_INTF_5_OFF+INTF_INTR_CLEAR,
+		MDP_INTF_5_OFF+INTF_INTR_EN,
+		MDP_INTF_5_OFF+INTF_INTR_STATUS
+	},
 	{
 		MDP_AD4_0_OFF + MDP_AD4_INTR_CLEAR_OFF,
 		MDP_AD4_0_OFF + MDP_AD4_INTR_EN_OFF,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index ac83c1159815..d90dac77c26f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -22,6 +22,7 @@ enum dpu_hw_intr_reg {
 	MDP_INTF2_INTR,
 	MDP_INTF3_INTR,
 	MDP_INTF4_INTR,
+	MDP_INTF5_INTR,
 	MDP_AD4_0_INTR,
 	MDP_AD4_1_INTR,
 	MDP_INTF0_7xxx_INTR,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 284f5610dc35..916e2a4756c0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -53,11 +53,6 @@
 #define   INTF_TPG_RGB_MAPPING          0x11C
 #define   INTF_PROG_FETCH_START         0x170
 #define   INTF_PROG_ROT_START           0x174
-
-#define   INTF_FRAME_LINE_COUNT_EN      0x0A8
-#define   INTF_FRAME_COUNT              0x0AC
-#define   INTF_LINE_COUNT               0x0B0
-
 #define   INTF_MUX                      0x25C
 
 static const struct dpu_intf_cfg *_intf_offset(enum dpu_intf intf,
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
index d7e4a39a904e..0eaaaa94563a 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -577,6 +577,18 @@ static struct hdmi_codec_pdata codec_data = {
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
index 7b8d4ba868eb..4742aca2af48 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -161,47 +161,6 @@ static ssize_t dp_aux_cmd_fifo_rx(struct dp_aux_private *aux,
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
@@ -410,13 +369,42 @@ void dp_aux_isr(struct drm_dp_aux *dp_aux)
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
index 9ef24ced6586..8df5dfd6ad17 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -34,7 +34,7 @@
 #define MSM_DP_CONTROLLER_P0_SIZE	0x0400
 
 #define DP_INTERRUPT_STATUS1 \
-	(DP_INTR_AUX_I2C_DONE| \
+	(DP_INTR_AUX_XFER_DONE| \
 	DP_INTR_WRONG_ADDR | DP_INTR_TIMEOUT | \
 	DP_INTR_NACK_DEFER | DP_INTR_WRONG_DATA_CNT | \
 	DP_INTR_I2C_NACK | DP_INTR_I2C_DEFER | \
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 6965afa81aad..32d3e14c98f7 100644
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
index 15e38ad7aefb..38d37345c216 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -267,6 +267,7 @@ static void dp_display_unbind(struct device *dev, struct device *master,
 	kthread_stop(dp->ev_tsk);
 
 	dp_power_client_deinit(dp->power);
+	dp_unregister_audio_driver(dev, dp->audio);
 	dp_aux_unregister(dp->aux);
 	priv->dp = NULL;
 }
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 0ea320c1092b..f2f76a0897a8 100644
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
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 601ab673727d..baa68ae9b9ef 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -834,8 +834,7 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
-		 hdev->product, &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
 	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
 
 	name = hidpp_unifying_get_name(hidpp);
@@ -928,6 +927,54 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
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
@@ -4141,6 +4188,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
 		hidpp_unifying_init(hidpp);
+	else if (hid_is_usb(hidpp->hid_dev))
+		hidpp_serial_init(hidpp);
 
 	connected = hidpp_root_get_protocol_version(hidpp) == 0;
 	atomic_set(&hidpp->connected, connected);
diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 203d27d198b8..3f8b24a57014 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -91,6 +91,7 @@
 #include <linux/leds.h>
 #include <linux/usb/input.h>
 #include <linux/power_supply.h>
+#include <linux/timer.h>
 #include <asm/unaligned.h>
 
 /*
@@ -167,6 +168,7 @@ struct wacom {
 	struct delayed_work init_work;
 	struct wacom_remote *remote;
 	struct work_struct mode_change_work;
+	struct timer_list idleprox_timer;
 	bool generic_has_leds;
 	struct wacom_leds {
 		struct wacom_group_leds *groups;
@@ -239,4 +241,5 @@ struct wacom_led *wacom_led_find(struct wacom *wacom, unsigned int group,
 struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur);
 int wacom_equivalent_usage(int usage);
 int wacom_initialize_leds(struct wacom *wacom);
+void wacom_idleprox_timeout(struct timer_list *list);
 #endif
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2b6388da545e..d29773a799b4 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2787,6 +2787,7 @@ static int wacom_probe(struct hid_device *hdev,
 	INIT_WORK(&wacom->battery_work, wacom_battery_work);
 	INIT_WORK(&wacom->remote_work, wacom_remote_work);
 	INIT_WORK(&wacom->mode_change_work, wacom_mode_change_work);
+	timer_setup(&wacom->idleprox_timer, &wacom_idleprox_timeout, TIMER_DEFERRABLE);
 
 	/* ask for the report descriptor to be loaded by HID */
 	error = hid_parse(hdev);
@@ -2832,6 +2833,7 @@ static void wacom_remove(struct hid_device *hdev)
 	cancel_work_sync(&wacom->battery_work);
 	cancel_work_sync(&wacom->remote_work);
 	cancel_work_sync(&wacom->mode_change_work);
+	del_timer_sync(&wacom->idleprox_timer);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index b4bdb532a0a4..a7c91671a004 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -11,6 +11,7 @@
 #include "wacom_wac.h"
 #include "wacom.h"
 #include <linux/input/mt.h>
+#include <linux/jiffies.h>
 
 /* resolution for penabled devices */
 #define WACOM_PL_RES		20
@@ -41,6 +42,43 @@ static int wacom_numbered_button_to_key(int n);
 
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
@@ -675,11 +713,14 @@ static int wacom_intuos_get_tool_type(int tool_id)
 	case 0x802: /* Intuos4/5 13HD/24HD General Pen */
 	case 0x8e2: /* IntuosHT2 pen */
 	case 0x022:
+	case 0x200: /* Pro Pen 3 */
+	case 0x04200: /* Pro Pen 3 */
 	case 0x10842: /* MobileStudio Pro Pro Pen slim */
 	case 0x14802: /* Intuos4/5 13HD/24HD Classic Pen */
 	case 0x16802: /* Cintiq 13HD Pro Pen */
 	case 0x18802: /* DTH2242 Pen */
 	case 0x10802: /* Intuos4/5 13HD/24HD General Pen */
+	case 0x80842: /* Intuos Pro and Cintiq Pro 3D Pen */
 		tool_type = BTN_TOOL_PEN;
 		break;
 
@@ -1925,18 +1966,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
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
@@ -1957,18 +1987,21 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
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
@@ -1984,18 +2017,15 @@ static void wacom_wac_battery_report(struct hid_device *hdev,
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
@@ -2350,6 +2380,7 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 		value = field->logical_maximum - value;
 		break;
 	case HID_DG_INRANGE:
+		mod_timer(&wacom->idleprox_timer, jiffies + msecs_to_jiffies(100));
 		wacom_wac->hid_data.inrange_state = value;
 		if (!(features->quirks & WACOM_QUIRK_SENSE))
 			wacom_wac->hid_data.sense_state = value;
@@ -4843,6 +4874,10 @@ static const struct wacom_features wacom_features_0x3c6 =
 static const struct wacom_features wacom_features_0x3c8 =
 	{ "Wacom Intuos BT M", 21600, 13500, 4095, 63,
 	  INTUOSHT3_BT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4 };
+static const struct wacom_features wacom_features_0x3dd =
+	{ "Wacom Intuos Pro S", 31920, 19950, 8191, 63,
+	  INTUOSP2S_BT, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 7,
+	  .touch_max = 10 };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
 	{ "Wacom HID", .type = HID_GENERIC, .oVid = HID_ANY_ID, .oPid = HID_ANY_ID };
@@ -5022,6 +5057,7 @@ const struct hid_device_id wacom_ids[] = {
 	{ BT_DEVICE_WACOM(0x393) },
 	{ BT_DEVICE_WACOM(0x3c6) },
 	{ BT_DEVICE_WACOM(0x3c8) },
+	{ BT_DEVICE_WACOM(0x3dd) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x4004) },
 	{ USB_DEVICE_WACOM(0x5000) },
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 98cb594cd9a6..a61c9ede4338 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -131,6 +131,11 @@ struct ib_umad_packet {
 	struct ib_user_mad mad;
 };
 
+struct ib_rmpp_mad_hdr {
+	struct ib_mad_hdr	mad_hdr;
+	struct ib_rmpp_hdr      rmpp_hdr;
+} __packed;
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/ib_umad.h>
 
@@ -494,11 +499,11 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 			     size_t count, loff_t *pos)
 {
 	struct ib_umad_file *file = filp->private_data;
+	struct ib_rmpp_mad_hdr *rmpp_mad_hdr;
 	struct ib_umad_packet *packet;
 	struct ib_mad_agent *agent;
 	struct rdma_ah_attr ah_attr;
 	struct ib_ah *ah;
-	struct ib_rmpp_mad *rmpp_mad;
 	__be64 *tid;
 	int ret, data_len, hdr_len, copy_offset, rmpp_active;
 	u8 base_version;
@@ -506,7 +511,7 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 	if (count < hdr_size(file) + IB_MGMT_RMPP_HDR)
 		return -EINVAL;
 
-	packet = kzalloc(sizeof *packet + IB_MGMT_RMPP_HDR, GFP_KERNEL);
+	packet = kzalloc(sizeof(*packet) + IB_MGMT_RMPP_HDR, GFP_KERNEL);
 	if (!packet)
 		return -ENOMEM;
 
@@ -560,13 +565,13 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 		goto err_up;
 	}
 
-	rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;
-	hdr_len = ib_get_mad_data_offset(rmpp_mad->mad_hdr.mgmt_class);
+	rmpp_mad_hdr = (struct ib_rmpp_mad_hdr *)packet->mad.data;
+	hdr_len = ib_get_mad_data_offset(rmpp_mad_hdr->mad_hdr.mgmt_class);
 
-	if (ib_is_mad_class_rmpp(rmpp_mad->mad_hdr.mgmt_class)
+	if (ib_is_mad_class_rmpp(rmpp_mad_hdr->mad_hdr.mgmt_class)
 	    && ib_mad_kernel_rmpp_agent(agent)) {
 		copy_offset = IB_MGMT_RMPP_HDR;
-		rmpp_active = ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
+		rmpp_active = ib_get_rmpp_flags(&rmpp_mad_hdr->rmpp_hdr) &
 						IB_MGMT_RMPP_FLAG_ACTIVE;
 	} else {
 		copy_offset = IB_MGMT_MAD_HDR;
@@ -615,12 +620,12 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 		tid = &((struct ib_mad_hdr *) packet->msg->mad)->tid;
 		*tid = cpu_to_be64(((u64) agent->hi_tid) << 32 |
 				   (be64_to_cpup(tid) & 0xffffffff));
-		rmpp_mad->mad_hdr.tid = *tid;
+		rmpp_mad_hdr->mad_hdr.tid = *tid;
 	}
 
 	if (!ib_mad_kernel_rmpp_agent(agent)
-	   && ib_is_mad_class_rmpp(rmpp_mad->mad_hdr.mgmt_class)
-	   && (ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE)) {
+	    && ib_is_mad_class_rmpp(rmpp_mad_hdr->mad_hdr.mgmt_class)
+	    && (ib_get_rmpp_flags(&rmpp_mad_hdr->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE)) {
 		spin_lock_irq(&file->send_lock);
 		list_add_tail(&packet->list, &file->send_list);
 		spin_unlock_irq(&file->send_lock);
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index dbfabd229a7c..a7af9b56e338 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -493,6 +493,9 @@ struct xboxone_init_packet {
 	}
 
 
+#define GIP_WIRED_INTF_DATA 0
+#define GIP_WIRED_INTF_AUDIO 1
+
 /*
  * This packet is required for all Xbox One pads with 2015
  * or later firmware installed (or present from the factory).
@@ -1821,7 +1824,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	}
 
 	if (xpad->xtype == XTYPE_XBOXONE &&
-	    intf->cur_altsetting->desc.bInterfaceNumber != 0) {
+	    intf->cur_altsetting->desc.bInterfaceNumber != GIP_WIRED_INTF_DATA) {
 		/*
 		 * The Xbox One controller lists three interfaces all with the
 		 * same interface class, subclass and protocol. Differentiate by
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e7da4a47ce52..bcdb2cbdda97 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -154,6 +154,18 @@ static void queue_inc_cons(struct arm_smmu_ll_queue *q)
 	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
 }
 
+static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
+{
+	struct arm_smmu_ll_queue *llq = &q->llq;
+
+	if (likely(Q_OVF(llq->prod) == Q_OVF(llq->cons)))
+		return;
+
+	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
+		      Q_IDX(llq, llq->cons);
+	queue_sync_cons_out(q);
+}
+
 static int queue_sync_prod_in(struct arm_smmu_queue *q)
 {
 	u32 prod;
@@ -1564,8 +1576,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		    Q_IDX(llq, llq->cons);
+	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
 }
 
@@ -1623,9 +1634,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		      Q_IDX(llq, llq->cons);
-	queue_sync_cons_out(q);
+	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index c998960495b4..50453d38400c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -247,12 +247,26 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
-	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	unsigned int last_s2cr;
 	u32 reg;
 	u32 smr;
 	int i;
 
+	/*
+	 * Some platforms support more than the Arm SMMU architected maximum of
+	 * 128 stream matching groups. For unknown reasons, the additional
+	 * groups don't exhibit the same behavior as the architected registers,
+	 * so limit the groups to 128 until the behavior is fixed for the other
+	 * groups.
+	 */
+	if (smmu->num_mapping_groups > 128) {
+		dev_notice(smmu->dev, "\tLimiting the stream matching groups to 128\n");
+		smmu->num_mapping_groups = 128;
+	}
+
+	last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+
 	/*
 	 * With some firmware versions writes to S2CR of type FAULT are
 	 * ignored, and writing BYPASS will end up written as FAULT in the
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 27ac818b0354..723940e84161 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -151,13 +151,6 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 	return &dom->domain;
 }
 
-static void sprd_iommu_domain_free(struct iommu_domain *domain)
-{
-	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
-
-	kfree(dom);
-}
-
 static void sprd_iommu_first_vpn(struct sprd_iommu_domain *dom)
 {
 	struct sprd_iommu_device *sdev = dom->sdev;
@@ -230,6 +223,28 @@ static void sprd_iommu_hw_en(struct sprd_iommu_device *sdev, bool en)
 	sprd_iommu_update_bits(sdev, reg_cfg, mask, 0, val);
 }
 
+static void sprd_iommu_cleanup(struct sprd_iommu_domain *dom)
+{
+	size_t pgt_size;
+
+	/* Nothing need to do if the domain hasn't been attached */
+	if (!dom->sdev)
+		return;
+
+	pgt_size = sprd_iommu_pgt_size(&dom->domain);
+	dma_free_coherent(dom->sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
+	dom->sdev = NULL;
+	sprd_iommu_hw_en(dom->sdev, false);
+}
+
+static void sprd_iommu_domain_free(struct iommu_domain *domain)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+
+	sprd_iommu_cleanup(dom);
+	kfree(dom);
+}
+
 static int sprd_iommu_attach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
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
 
diff --git a/drivers/media/pci/cx23885/cx23885-core.c b/drivers/media/pci/cx23885/cx23885-core.c
index a07b18f2034e..8019cdf5dbae 100644
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
index a380e0920a21..b01499f81069 100644
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
index 77bae1468551..a71814e2772d 100644
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
index fe94944d0531..0d1120abc647 100644
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
diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
index 1c9cb9e05fdf..c1ce93efc655 100644
--- a/drivers/media/platform/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/am437x/am437x-vpfe.c
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
diff --git a/drivers/media/platform/exynos4-is/fimc-capture.c b/drivers/media/platform/exynos4-is/fimc-capture.c
index 7ff4024003f4..0b3cf01e9537 100644
--- a/drivers/media/platform/exynos4-is/fimc-capture.c
+++ b/drivers/media/platform/exynos4-is/fimc-capture.c
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
 
diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
index 3e936a2ca36c..d87177d04e92 100644
--- a/drivers/media/platform/ti-vpe/cal-video.c
+++ b/drivers/media/platform/ti-vpe/cal-video.c
@@ -814,7 +814,6 @@ static const struct v4l2_file_operations cal_fops = {
 
 static int cal_ctx_v4l2_init_formats(struct cal_ctx *ctx)
 {
-	struct v4l2_subdev_mbus_code_enum mbus_code;
 	struct v4l2_mbus_framefmt mbus_fmt;
 	const struct cal_format_info *fmtinfo;
 	unsigned int i, j, k;
@@ -829,10 +828,11 @@ static int cal_ctx_v4l2_init_formats(struct cal_ctx *ctx)
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
diff --git a/drivers/media/platform/vsp1/vsp1_drm.c b/drivers/media/platform/vsp1/vsp1_drm.c
index 06f74d410973..706d48601bf2 100644
--- a/drivers/media/platform/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/vsp1/vsp1_drm.c
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
diff --git a/drivers/media/platform/vsp1/vsp1_entity.c b/drivers/media/platform/vsp1/vsp1_entity.c
index 823c15facd1b..b40926270c14 100644
--- a/drivers/media/platform/vsp1/vsp1_entity.c
+++ b/drivers/media/platform/vsp1/vsp1_entity.c
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
index 3261cac762de..ec3ee356078d 100644
--- a/drivers/message/fusion/mptlan.c
+++ b/drivers/message/fusion/mptlan.c
@@ -1427,7 +1427,9 @@ mptlan_remove(struct pci_dev *pdev)
 {
 	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
 	struct net_device	*dev = ioc->netdev;
+	struct mpt_lan_priv *priv = netdev_priv(dev);
 
+	cancel_delayed_work_sync(&priv->post_buckets_task);
 	if(dev != NULL) {
 		unregister_netdev(dev);
 		free_netdev(dev);
diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 852129ea0766..fc65f9e25fda 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -836,6 +836,7 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
+	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index eb74cdf26b88..477bc56b1206 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -70,10 +70,12 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
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
@@ -110,6 +112,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* DMA support */
 #define KVASER_PCIEFD_SRB_STAT_DMA BIT(24)
 
+/* SRB current packet level */
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK 0xff
+
 /* DMA Enable */
 #define KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE BIT(0)
 
@@ -528,7 +533,7 @@ static int kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 	      KVASER_PCIEFD_KCAN_IRQ_TOF | KVASER_PCIEFD_KCAN_IRQ_ABD |
 	      KVASER_PCIEFD_KCAN_IRQ_TAE | KVASER_PCIEFD_KCAN_IRQ_TAL |
 	      KVASER_PCIEFD_KCAN_IRQ_FDIC | KVASER_PCIEFD_KCAN_IRQ_BPP |
-	      KVASER_PCIEFD_KCAN_IRQ_TAR | KVASER_PCIEFD_KCAN_IRQ_TFD;
+	      KVASER_PCIEFD_KCAN_IRQ_TAR;
 
 	iowrite32(msk, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
@@ -556,6 +561,8 @@ static void kvaser_pciefd_setup_controller(struct kvaser_pciefd_can *can)
 
 	if (can->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		mode |= KVASER_PCIEFD_KCAN_MODE_LOM;
+	else
+		mode &= ~KVASER_PCIEFD_KCAN_MODE_LOM;
 
 	mode |= KVASER_PCIEFD_KCAN_MODE_EEN;
 	mode |= KVASER_PCIEFD_KCAN_MODE_EPEN;
@@ -574,7 +581,7 @@ static void kvaser_pciefd_start_controller_flush(struct kvaser_pciefd_can *can)
 
 	spin_lock_irqsave(&can->lock, irq);
 	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD | KVASER_PCIEFD_KCAN_IRQ_TFD,
+	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 		  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
 	status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
@@ -617,7 +624,7 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
 	iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 
-	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD | KVASER_PCIEFD_KCAN_IRQ_TFD,
+	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 		  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
 	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
@@ -721,6 +728,7 @@ static int kvaser_pciefd_stop(struct net_device *netdev)
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 		del_timer(&can->bec_poll_timer);
 	}
+	can->can.state = CAN_STATE_STOPPED;
 	close_candev(netdev);
 
 	return ret;
@@ -1003,8 +1011,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		SET_NETDEV_DEV(netdev, &pcie->pci->dev);
 
 		iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD |
-			  KVASER_PCIEFD_KCAN_IRQ_TFD,
+		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 			  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
 		pcie->can[i] = can;
@@ -1054,6 +1061,7 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 {
 	int i;
 	u32 srb_status;
+	u32 srb_packet_count;
 	dma_addr_t dma_addr[KVASER_PCIEFD_DMA_COUNT];
 
 	/* Disable the DMA */
@@ -1081,6 +1089,15 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
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
@@ -1423,9 +1440,6 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
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
index 03382b66f800..3e68d534eaca 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -267,7 +267,7 @@
 /* Offset 0x10: Extended Port Control Command */
 #define MV88E6393X_PORT_EPC_CMD		0x10
 #define MV88E6393X_PORT_EPC_CMD_BUSY	0x8000
-#define MV88E6393X_PORT_EPC_CMD_WRITE	0x0300
+#define MV88E6393X_PORT_EPC_CMD_WRITE	0x3000
 #define MV88E6393X_PORT_EPC_INDEX_PORT_ETYPE	0x02
 
 /* Offset 0x11: Extended Port Control Data */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index bc9812a0a91c..3c9ba116d5af 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2709,7 +2709,7 @@ static int bnxt_get_nvram_directory(struct net_device *dev, u32 len, u8 *data)
 	if (rc)
 		return rc;
 
-	buflen = dir_entries * entry_length;
+	buflen = mul_u32_u32(dir_entries, entry_length);
 	buf = hwrm_req_dma_slice(bp, req, buflen, &dma_handle);
 	if (!buf) {
 		hwrm_req_drop(bp, req);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 92cd2916e801..9d4f406408c9 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3401,7 +3401,7 @@ static int bcmgenet_open(struct net_device *dev)
 	return ret;
 }
 
-static void bcmgenet_netif_stop(struct net_device *dev)
+static void bcmgenet_netif_stop(struct net_device *dev, bool stop_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
@@ -3416,7 +3416,8 @@ static void bcmgenet_netif_stop(struct net_device *dev)
 	/* Disable MAC transmit. TX DMA disabled must be done before this */
 	umac_enable_set(priv, CMD_TX_EN, false);
 
-	phy_stop(dev->phydev);
+	if (stop_phy)
+		phy_stop(dev->phydev);
 	bcmgenet_disable_rx_napi(priv);
 	bcmgenet_intr_disable(priv);
 
@@ -3442,7 +3443,7 @@ static int bcmgenet_close(struct net_device *dev)
 
 	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
 
-	bcmgenet_netif_stop(dev);
+	bcmgenet_netif_stop(dev, false);
 
 	/* Really kill the PHY state machine and disconnect from it */
 	phy_disconnect(dev->phydev);
@@ -4242,7 +4243,7 @@ static int bcmgenet_suspend(struct device *d)
 
 	netif_device_detach(dev);
 
-	bcmgenet_netif_stop(dev);
+	bcmgenet_netif_stop(dev, true);
 
 	if (!device_may_wakeup(d))
 		phy_suspend(dev->phydev);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index afb30d679a47..c0c96de7a9de 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4054,9 +4054,11 @@ fec_drv_remove(struct platform_device *pdev)
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
@@ -4069,8 +4071,13 @@ fec_drv_remove(struct platform_device *pdev)
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
index 49850cf7cfaf..c0ea1b185e1b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -233,19 +233,6 @@ static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
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
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 15ce1a33649e..3158c08a3aa9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -123,7 +123,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.name = "tx_bd_queue",
 		.cmd = HNAE3_DBG_CMD_TX_BD,
 		.dentry = HNS3_DBG_DENTRY_TX_BD,
-		.buf_len = HNS3_DBG_READ_LEN_4MB,
+		.buf_len = HNS3_DBG_READ_LEN_5MB,
 		.init = hns3_dbg_bd_file_init,
 	},
 	{
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
index 814f7491ca08..fb0c907cec85 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
@@ -8,6 +8,7 @@
 #define HNS3_DBG_READ_LEN_128KB	0x20000
 #define HNS3_DBG_READ_LEN_1MB	0x100000
 #define HNS3_DBG_READ_LEN_4MB	0x400000
+#define HNS3_DBG_READ_LEN_5MB	0x500000
 #define HNS3_DBG_WRITE_LEN	1024
 
 #define HNS3_DBG_DATA_STR_LEN	32
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f4d58fcdba27..bfdc021f4a19 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -8134,12 +8134,15 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
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
index afc47c9b5ec4..97a6864f60ef 100644
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
index 5df18cc3ee55..2c5256d7f996 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -155,6 +155,9 @@ struct hclge_bp_to_qs_map_cmd {
 	u32 rsvd1;
 };
 
+#define HCLGE_PFC_DISABLE	0
+#define HCLGE_PFC_TX_RX_DISABLE	0
+
 struct hclge_pfc_en_cmd {
 	u8 tx_rx_en_bitmap;
 	u8 pri_en_bitmap;
@@ -226,6 +229,8 @@ void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc);
 void hclge_tm_pfc_info_update(struct hclge_dev *hdev);
 int hclge_tm_dwrr_cfg(struct hclge_dev *hdev);
 int hclge_tm_init_hw(struct hclge_dev *hdev, bool init);
+int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
+			   u8 pfc_bitmap);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
 int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
 void hclge_pfc_rx_stats_get(struct hclge_dev *hdev, u64 *stats);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 3c1ff3313221..bc140e3620d6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1885,7 +1885,10 @@ static int hclgevf_reset_wait(struct hclgevf_dev *hdev)
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
diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index 1277c5c7d099..7be0c7ce9394 100644
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
diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index 7e096b2888b9..b223488318ad 100644
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index fb9ff4ce9453..c9e88df9e866 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -298,6 +298,11 @@ static void get_arttime(struct mii_bus *mii, int intel_adhoc_addr,
 	*art_time = ns;
 }
 
+static int stmmac_cross_ts_isr(struct stmmac_priv *priv)
+{
+	return (readl(priv->ioaddr + GMAC_INT_STATUS) & GMAC_INT_TSIE);
+}
+
 static int intel_crosststamp(ktime_t *device,
 			     struct system_counterval_t *system,
 			     void *ctx)
@@ -313,8 +318,6 @@ static int intel_crosststamp(ktime_t *device,
 	u32 num_snapshot;
 	u32 gpio_value;
 	u32 acr_value;
-	int ret;
-	u32 v;
 	int i;
 
 	if (!boot_cpu_has(X86_FEATURE_ART))
@@ -328,6 +331,8 @@ static int intel_crosststamp(ktime_t *device,
 	if (priv->plat->ext_snapshot_en)
 		return -EBUSY;
 
+	priv->plat->int_snapshot_en = 1;
+
 	mutex_lock(&priv->aux_ts_lock);
 	/* Enable Internal snapshot trigger */
 	acr_value = readl(ptpaddr + PTP_ACR);
@@ -347,6 +352,7 @@ static int intel_crosststamp(ktime_t *device,
 		break;
 	default:
 		mutex_unlock(&priv->aux_ts_lock);
+		priv->plat->int_snapshot_en = 0;
 		return -EINVAL;
 	}
 	writel(acr_value, ptpaddr + PTP_ACR);
@@ -368,13 +374,12 @@ static int intel_crosststamp(ktime_t *device,
 	gpio_value |= GMAC_GPO1;
 	writel(gpio_value, ioaddr + GMAC_GPIO_STATUS);
 
-	/* Poll for time sync operation done */
-	ret = readl_poll_timeout(priv->ioaddr + GMAC_INT_STATUS, v,
-				 (v & GMAC_INT_TSIE), 100, 10000);
-
-	if (ret == -ETIMEDOUT) {
-		pr_err("%s: Wait for time sync operation timeout\n", __func__);
-		return ret;
+	/* Time sync done Indication - Interrupt method */
+	if (!wait_event_interruptible_timeout(priv->tstamp_busy_wait,
+					      stmmac_cross_ts_isr(priv),
+					      HZ / 100)) {
+		priv->plat->int_snapshot_en = 0;
+		return -ETIMEDOUT;
 	}
 
 	num_snapshot = (readl(ioaddr + GMAC_TIMESTAMP_STATUS) &
@@ -392,6 +397,7 @@ static int intel_crosststamp(ktime_t *device,
 	}
 
 	system->cycles *= intel_priv->crossts_adj;
+	priv->plat->int_snapshot_en = 0;
 
 	return 0;
 }
@@ -576,6 +582,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	plat->has_crossts = true;
 	plat->crosststamp = intel_crosststamp;
+	plat->int_snapshot_en = 0;
 
 	/* Setup MSI vector offset specific to Intel mGbE controller */
 	plat->msi_mac_vec = 29;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 462ca7ed095a..12c0e60809f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -150,7 +150,8 @@
 #define	GMAC_PCS_IRQ_DEFAULT	(GMAC_INT_RGSMIIS | GMAC_INT_PCS_LINK |	\
 				 GMAC_INT_PCS_ANE)
 
-#define	GMAC_INT_DEFAULT_ENABLE	(GMAC_INT_PMT_EN | GMAC_INT_LPI_EN)
+#define	GMAC_INT_DEFAULT_ENABLE	(GMAC_INT_PMT_EN | GMAC_INT_LPI_EN | \
+				 GMAC_INT_TSIE)
 
 enum dwmac4_irq_status {
 	time_stamp_irq = 0x00001000,
@@ -180,6 +181,7 @@ enum power_event {
 #define GMAC4_LPI_CTRL_STATUS	0xd0
 #define GMAC4_LPI_TIMER_CTRL	0xd4
 #define GMAC4_LPI_ENTRY_TIMER	0xd8
+#define GMAC4_MAC_ONEUS_TIC_COUNTER	0xdc
 
 /* LPI control and status defines */
 #define GMAC4_LPI_CTRL_STATUS_LPITCSE	BIT(21)	/* LPI Tx Clock Stop Enable */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index cd85a2d076c9..29480314a486 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -23,8 +23,10 @@
 static void dwmac4_core_init(struct mac_device_info *hw,
 			     struct net_device *dev)
 {
+	struct stmmac_priv *priv = netdev_priv(dev);
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONFIG);
+	u32 clk_rate;
 
 	value |= GMAC_CORE_INIT;
 
@@ -47,6 +49,10 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 
 	writel(value, ioaddr + GMAC_CONFIG);
 
+	/* Configure LPI 1us counter to number of CSR clock ticks in 1us - 1 */
+	clk_rate = clk_get_rate(priv->plat->stmmac_clk);
+	writel((clk_rate / 1000000) - 1, ioaddr + GMAC4_MAC_ONEUS_TIC_COUNTER);
+
 	/* Enable GMAC interrupts */
 	value = GMAC_INT_DEFAULT_ENABLE;
 
@@ -58,6 +64,9 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 		value |= GMAC_INT_FPE_EN;
 
 	writel(value, ioaddr + GMAC_INT_EN);
+
+	if (GMAC_INT_DEFAULT_ENABLE & GMAC_INT_TSIE)
+		init_waitqueue_head(&priv->tstamp_busy_wait);
 }
 
 static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 05b5371ca036..f03779205ade 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -265,6 +265,7 @@ struct stmmac_priv {
 	spinlock_t ptp_lock;
 	/* Protects auxiliary snapshot registers from concurrent access. */
 	struct mutex aux_ts_lock;
+	wait_queue_head_t tstamp_busy_wait;
 
 	void __iomem *mmcaddr;
 	void __iomem *ptpaddr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 4538e4fd8189..2c6245b2281c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -180,6 +180,11 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 	u64 ptp_time;
 	int i;
 
+	if (priv->plat->int_snapshot_en) {
+		wake_up(&priv->tstamp_busy_wait);
+		return;
+	}
+
 	tsync_int = readl(priv->ioaddr + GMAC_INT_STATUS) & GMAC_INT_TSIE;
 
 	if (!tsync_int)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 487418ef9b4f..e6221c33572d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -175,11 +175,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 	struct stmmac_priv *priv =
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	void __iomem *ptpaddr = priv->ptpaddr;
-	void __iomem *ioaddr = priv->hw->pcsr;
 	struct stmmac_pps_cfg *cfg;
-	u32 intr_value, acr_value;
 	int ret = -EOPNOTSUPP;
 	unsigned long flags;
+	u32 acr_value;
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_PEROUT:
@@ -213,19 +212,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 			netdev_dbg(priv->dev, "Auxiliary Snapshot %d enabled.\n",
 				   priv->plat->ext_snapshot_num >>
 				   PTP_ACR_ATSEN_SHIFT);
-			/* Enable Timestamp Interrupt */
-			intr_value = readl(ioaddr + GMAC_INT_EN);
-			intr_value |= GMAC_INT_TSIE;
-			writel(intr_value, ioaddr + GMAC_INT_EN);
-
 		} else {
 			netdev_dbg(priv->dev, "Auxiliary Snapshot %d disabled.\n",
 				   priv->plat->ext_snapshot_num >>
 				   PTP_ACR_ATSEN_SHIFT);
-			/* Disable Timestamp Interrupt */
-			intr_value = readl(ioaddr + GMAC_INT_EN);
-			intr_value &= ~GMAC_INT_TSIE;
-			writel(intr_value, ioaddr + GMAC_INT_EN);
 		}
 		writel(acr_value, ptpaddr + PTP_ACR);
 		mutex_unlock(&priv->aux_ts_lock);
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 6472425539e1..21e4df8466c9 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -5123,6 +5123,8 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		cas_shutdown(cp);
 	mutex_unlock(&cp->pm_mutex);
 
+	vfree(cp->fw_data);
+
 	pci_iounmap(pdev, cp->regs);
 
 
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index d7fb6302d699..1f5125698e83 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -437,6 +437,9 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
 		goto err;
 	}
 	skb_dst_set(skb, &rt->dst);
+
+	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+
 	err = ip_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		dev->stats.tx_errors++;
@@ -475,6 +478,9 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
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
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 783e30451e30..6230dd5e2990 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -41,6 +41,7 @@
 #define DP83867_STRAP_STS1	0x006E
 #define DP83867_STRAP_STS2	0x006f
 #define DP83867_RGMIIDCTL	0x0086
+#define DP83867_DSP_FFE_CFG	0x012c
 #define DP83867_RXFCFG		0x0134
 #define DP83867_RXFPMD1	0x0136
 #define DP83867_RXFPMD2	0x0137
@@ -841,8 +842,27 @@ static int dp83867_phy_reset(struct phy_device *phydev)
 
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
index 854ed2f21d32..663ce0e09c2d 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -714,7 +714,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	/* Move network header to the right position for VLAN tagged packets */
 	if (eth_type_vlan(skb->protocol) &&
-	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
+	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
 	rcu_read_lock();
@@ -1163,7 +1163,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	/* Move network header to the right position for VLAN tagged packets */
 	if (eth_type_vlan(skb->protocol) &&
-	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
+	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
 	rcu_read_lock();
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9f2d691908b4..0351f86494f1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1604,6 +1604,38 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
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
@@ -1617,22 +1649,20 @@ static int virtnet_open(struct net_device *dev)
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
@@ -1998,11 +2028,8 @@ static int virtnet_close(struct net_device *dev)
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
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 3c64d33d0133..357abd87d549 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -354,10 +354,10 @@ int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
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
@@ -2602,6 +2602,9 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 				   cookie);
 		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
 
+		if (unlikely(buf_id == 0))
+			continue;
+
 		ar = ab->pdevs[mac_id].ar;
 		rx_ring = &ar->dp.rx_refill_buf_ring;
 		spin_lock_bh(&rx_ring->idr_lock);
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
index 5a1b01db02e6..b14c54da56ed 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1350,13 +1350,14 @@ static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
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
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
index ddc14059b07d..7c3168145e58 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -1086,6 +1086,7 @@ static int iwlagn_send_sta_key(struct iwl_priv *priv,
 {
 	__le16 key_flags;
 	struct iwl_addsta_cmd sta_cmd;
+	size_t to_copy;
 	int i;
 
 	spin_lock_bh(&priv->sta_lock);
@@ -1105,7 +1106,9 @@ static int iwlagn_send_sta_key(struct iwl_priv *priv,
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
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index da705fcaf0fc..8a9732b5b965 100644
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
index efccdd3f3377..49c28c96fdf2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1907,7 +1907,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 				RCU_INIT_POINTER(mvm->csa_tx_blocked_vif, NULL);
 				/* Unblock BCAST / MCAST station */
 				iwl_mvm_modify_all_sta_disable_tx(mvm, mvmvif, false);
-				cancel_delayed_work_sync(&mvm->cs_tx_unblock_dwork);
+				cancel_delayed_work(&mvm->cs_tx_unblock_dwork);
 			}
 		}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 3b974388d834..5d324d64c879 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1380,6 +1380,9 @@ static void iwl_pci_remove(struct pci_dev *pdev)
 {
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
 
+	if (!trans)
+		return;
+
 	iwl_drv_stop(trans->drv);
 
 	iwl_trans_pcie_free(trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index ee325950de9d..04e1f3829e96 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2778,7 +2778,7 @@ static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
 				  void *buf, ssize_t *size,
 				  ssize_t *bytes_copied)
 {
-	int buf_size_left = count - *bytes_copied;
+	ssize_t buf_size_left = count - *bytes_copied;
 
 	buf_size_left = buf_size_left - (buf_size_left % sizeof(u32));
 	if (*size > buf_size_left)
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
index 61186829d1f6..50abcf0c483c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -389,24 +389,7 @@ config GPD_POCKET_FAN
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
@@ -420,29 +403,6 @@ config WIRELESS_HOTKEY
 	 To compile this driver as a module, choose M here: the module will
 	 be called wireless-hotkey.
 
-config HP_WMI
-	tristate "HP WMI extras"
-	depends on ACPI_WMI
-	depends on INPUT
-	depends on RFKILL || RFKILL = n
-	select INPUT_SPARSEKMAP
-	select ACPI_PLATFORM_PROFILE
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
index 2734a771d1f0..5dba9fe23fb1 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -52,9 +52,7 @@ obj-$(CONFIG_FUJITSU_TABLET)	+= fujitsu-tablet.o
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
index 1e390dcee561..000000000000
--- a/drivers/platform/x86/hp-wmi.c
+++ /dev/null
@@ -1,1135 +0,0 @@
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
-#include <linux/acpi.h>
-#include <linux/rfkill.h>
-#include <linux/string.h>
-
-MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
-MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
-MODULE_LICENSE("GPL");
-
-MODULE_ALIAS("wmi:95F24279-4D7B-4334-9387-ACCDC67EF61C");
-MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
-
-static int enable_tablet_mode_sw = -1;
-module_param(enable_tablet_mode_sw, int, 0444);
-MODULE_PARM_DESC(enable_tablet_mode_sw, "Enable SW_TABLET_MODE reporting (-1=auto, 0=no, 1=yes)");
-
-#define HPWMI_EVENT_GUID "95F24279-4D7B-4334-9387-ACCDC67EF61C"
-#define HPWMI_BIOS_GUID "5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
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
-	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
-};
-
-struct bios_args {
-	u32 signature;
-	u32 command;
-	u32 commandtype;
-	u32 datasize;
-	u8 data[128];
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
-	HPWMI_THERMAL_PROFILE_QUERY	= 0x4c,
-};
-
-enum hp_wmi_command {
-	HPWMI_READ	= 0x01,
-	HPWMI_WRITE	= 0x02,
-	HPWMI_ODM	= 0x03,
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
-enum hp_thermal_profile {
-	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
-	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
-	HP_THERMAL_PROFILE_COOL			= 0x02
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
-	{ KE_KEY, 0x02,   { KEY_BRIGHTNESSUP } },
-	{ KE_KEY, 0x03,   { KEY_BRIGHTNESSDOWN } },
-	{ KE_KEY, 0x20e6, { KEY_PROG1 } },
-	{ KE_KEY, 0x20e8, { KEY_MEDIA } },
-	{ KE_KEY, 0x2142, { KEY_MEDIA } },
-	{ KE_KEY, 0x213b, { KEY_INFO } },
-	{ KE_KEY, 0x2169, { KEY_ROTATE_DISPLAY } },
-	{ KE_KEY, 0x216a, { KEY_SETUP } },
-	{ KE_KEY, 0x231b, { KEY_HELP } },
-	{ KE_END, 0 }
-};
-
-static struct input_dev *hp_wmi_input_dev;
-static struct platform_device *hp_wmi_platform_dev;
-static struct platform_profile_handler platform_profile_handler;
-static bool platform_profile_support;
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
-	int mid;
-	struct bios_return *bios_return;
-	int actual_outsize;
-	union acpi_object *obj;
-	struct bios_args args = {
-		.signature = 0x55434553,
-		.command = command,
-		.commandtype = query,
-		.datasize = insize,
-		.data = { 0 },
-	};
-	struct acpi_buffer input = { sizeof(struct bios_args), &args };
-	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	int ret = 0;
-
-	mid = encode_outsize_for_pvsz(outsize);
-	if (WARN_ON(mid < 0))
-		return mid;
-
-	if (WARN_ON(insize > sizeof(args.data)))
-		return -EINVAL;
-	memcpy(&args.data[0], buffer, insize);
-
-	wmi_evaluate_method(HPWMI_BIOS_GUID, 0, mid, &input, &output);
-
-	obj = output.pointer;
-
-	if (!obj)
-		return -EINVAL;
-
-	if (obj->type != ACPI_TYPE_BUFFER) {
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
-	return ret;
-}
-
-static int hp_wmi_read_int(int query)
-{
-	int val = 0, ret;
-
-	ret = hp_wmi_perform_query(query, HPWMI_READ, &val,
-				   sizeof(val), sizeof(val));
-
-	if (ret)
-		return ret < 0 ? ret : -EINVAL;
-
-	return val;
-}
-
-static int hp_wmi_hw_state(int mask)
-{
-	int state = hp_wmi_read_int(HPWMI_HARDWARE_QUERY);
-
-	if (state < 0)
-		return state;
-
-	return !!(state & mask);
-}
-
-static int __init hp_wmi_bios_2008_later(void)
-{
-	int state = 0;
-	int ret = hp_wmi_perform_query(HPWMI_FEATURE_QUERY, HPWMI_READ, &state,
-				       sizeof(state), sizeof(state));
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
-				       sizeof(state), sizeof(state));
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
-				   sizeof(state), sizeof(state));
-	if (err)
-		return err;
-
-	for (i = 0; i < rfkill2_count; i++) {
-		int num = rfkill2[i].num;
-		struct bios_rfkill2_device_state *devstate;
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
-	if (value < 0)
-		return value;
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t hddtemp_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	int value = hp_wmi_read_int(HPWMI_HDDTEMP_QUERY);
-	if (value < 0)
-		return value;
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t als_show(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	int value = hp_wmi_read_int(HPWMI_ALS_QUERY);
-	if (value < 0)
-		return value;
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
-			 char *buf)
-{
-	int value = hp_wmi_hw_state(HPWMI_DOCK_MASK);
-	if (value < 0)
-		return value;
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t tablet_show(struct device *dev, struct device_attribute *attr,
-			   char *buf)
-{
-	int value = hp_wmi_hw_state(HPWMI_TABLET_MASK);
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
-				       sizeof(tmp), sizeof(tmp));
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
-	/* Clear the POST error code. It is kept until until cleared. */
-	ret = hp_wmi_perform_query(HPWMI_POSTCODEERROR_QUERY, HPWMI_WRITE, &tmp,
-				       sizeof(tmp), sizeof(tmp));
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
-					    hp_wmi_hw_state(HPWMI_DOCK_MASK));
-		if (test_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit))
-			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
-					    hp_wmi_hw_state(HPWMI_TABLET_MASK));
-		input_sync(hp_wmi_input_dev);
-		break;
-	case HPWMI_PARK_HDD:
-		break;
-	case HPWMI_SMART_ADAPTER:
-		break;
-	case HPWMI_BEZEL_BUTTON:
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
-	val = hp_wmi_hw_state(HPWMI_DOCK_MASK);
-	if (!(val < 0)) {
-		__set_bit(SW_DOCK, hp_wmi_input_dev->swbit);
-		input_report_switch(hp_wmi_input_dev, SW_DOCK, val);
-	}
-
-	/* Tablet mode */
-	if (enable_tablet_mode_sw > 0) {
-		val = hp_wmi_hw_state(HPWMI_TABLET_MASK);
-		if (val >= 0) {
-			__set_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit);
-			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE, val);
-		}
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
-				   sizeof(state), sizeof(state));
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
-static int platform_profile_get(struct platform_profile_handler *pprof,
-				enum platform_profile_option *profile)
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
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int platform_profile_set(struct platform_profile_handler *pprof,
-				enum platform_profile_option profile)
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
-	tp = thermal_profile_get();
-	if (tp < 0)
-		return tp;
-
-	/*
-	 * call thermal profile write command to ensure that the firmware correctly
-	 * sets the OEM variables for the DPTF
-	 */
-	err = thermal_profile_set(tp);
-	if (err)
-		return err;
-
-	platform_profile_handler.profile_get = platform_profile_get,
-	platform_profile_handler.profile_set = platform_profile_set,
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
-static int __init hp_wmi_bios_setup(struct platform_device *device)
-{
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
-					    hp_wmi_hw_state(HPWMI_DOCK_MASK));
-		if (test_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit))
-			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
-					    hp_wmi_hw_state(HPWMI_TABLET_MASK));
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
-static int __init hp_wmi_init(void)
-{
-	int event_capable = wmi_has_guid(HPWMI_EVENT_GUID);
-	int bios_capable = wmi_has_guid(HPWMI_BIOS_GUID);
-	int err;
-
-	if (!bios_capable && !event_capable)
-		return -ENODEV;
-
-	if (event_capable) {
-		err = hp_wmi_input_setup();
-		if (err)
-			return err;
-	}
-
-	if (bios_capable) {
-		hp_wmi_platform_dev =
-			platform_device_register_simple("hp-wmi", -1, NULL, 0);
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
index 000000000000..8c845d263429
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -0,0 +1,1138 @@
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
+#include <linux/acpi.h>
+#include <linux/rfkill.h>
+#include <linux/string.h>
+
+MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
+MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS("wmi:95F24279-4D7B-4334-9387-ACCDC67EF61C");
+MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
+
+static int enable_tablet_mode_sw = -1;
+module_param(enable_tablet_mode_sw, int, 0444);
+MODULE_PARM_DESC(enable_tablet_mode_sw, "Enable SW_TABLET_MODE reporting (-1=auto, 0=no, 1=yes)");
+
+#define HPWMI_EVENT_GUID "95F24279-4D7B-4334-9387-ACCDC67EF61C"
+#define HPWMI_BIOS_GUID "5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
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
+	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
+};
+
+struct bios_args {
+	u32 signature;
+	u32 command;
+	u32 commandtype;
+	u32 datasize;
+	u8 data[128];
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
+	HPWMI_THERMAL_PROFILE_QUERY	= 0x4c,
+};
+
+enum hp_wmi_command {
+	HPWMI_READ	= 0x01,
+	HPWMI_WRITE	= 0x02,
+	HPWMI_ODM	= 0x03,
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
+enum hp_thermal_profile {
+	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
+	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
+	HP_THERMAL_PROFILE_COOL			= 0x02
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
+	int mid;
+	struct bios_return *bios_return;
+	int actual_outsize;
+	union acpi_object *obj;
+	struct bios_args args = {
+		.signature = 0x55434553,
+		.command = command,
+		.commandtype = query,
+		.datasize = insize,
+		.data = { 0 },
+	};
+	struct acpi_buffer input = { sizeof(struct bios_args), &args };
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	int ret = 0;
+
+	mid = encode_outsize_for_pvsz(outsize);
+	if (WARN_ON(mid < 0))
+		return mid;
+
+	if (WARN_ON(insize > sizeof(args.data)))
+		return -EINVAL;
+	memcpy(&args.data[0], buffer, insize);
+
+	wmi_evaluate_method(HPWMI_BIOS_GUID, 0, mid, &input, &output);
+
+	obj = output.pointer;
+
+	if (!obj)
+		return -EINVAL;
+
+	if (obj->type != ACPI_TYPE_BUFFER) {
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
+	return ret;
+}
+
+static int hp_wmi_read_int(int query)
+{
+	int val = 0, ret;
+
+	ret = hp_wmi_perform_query(query, HPWMI_READ, &val,
+				   sizeof(val), sizeof(val));
+
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	return val;
+}
+
+static int hp_wmi_hw_state(int mask)
+{
+	int state = hp_wmi_read_int(HPWMI_HARDWARE_QUERY);
+
+	if (state < 0)
+		return state;
+
+	return !!(state & mask);
+}
+
+static int __init hp_wmi_bios_2008_later(void)
+{
+	int state = 0;
+	int ret = hp_wmi_perform_query(HPWMI_FEATURE_QUERY, HPWMI_READ, &state,
+				       sizeof(state), sizeof(state));
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
+				       sizeof(state), sizeof(state));
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
+				   sizeof(state), sizeof(state));
+	if (err)
+		return err;
+
+	for (i = 0; i < rfkill2_count; i++) {
+		int num = rfkill2[i].num;
+		struct bios_rfkill2_device_state *devstate;
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
+	if (value < 0)
+		return value;
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t hddtemp_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	int value = hp_wmi_read_int(HPWMI_HDDTEMP_QUERY);
+	if (value < 0)
+		return value;
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t als_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	int value = hp_wmi_read_int(HPWMI_ALS_QUERY);
+	if (value < 0)
+		return value;
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	int value = hp_wmi_hw_state(HPWMI_DOCK_MASK);
+	if (value < 0)
+		return value;
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t tablet_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	int value = hp_wmi_hw_state(HPWMI_TABLET_MASK);
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
+				       sizeof(tmp), sizeof(tmp));
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
+	/* Clear the POST error code. It is kept until until cleared. */
+	ret = hp_wmi_perform_query(HPWMI_POSTCODEERROR_QUERY, HPWMI_WRITE, &tmp,
+				       sizeof(tmp), sizeof(tmp));
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
+					    hp_wmi_hw_state(HPWMI_DOCK_MASK));
+		if (test_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit))
+			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
+					    hp_wmi_hw_state(HPWMI_TABLET_MASK));
+		input_sync(hp_wmi_input_dev);
+		break;
+	case HPWMI_PARK_HDD:
+		break;
+	case HPWMI_SMART_ADAPTER:
+		break;
+	case HPWMI_BEZEL_BUTTON:
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
+	val = hp_wmi_hw_state(HPWMI_DOCK_MASK);
+	if (!(val < 0)) {
+		__set_bit(SW_DOCK, hp_wmi_input_dev->swbit);
+		input_report_switch(hp_wmi_input_dev, SW_DOCK, val);
+	}
+
+	/* Tablet mode */
+	if (enable_tablet_mode_sw > 0) {
+		val = hp_wmi_hw_state(HPWMI_TABLET_MASK);
+		if (val >= 0) {
+			__set_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit);
+			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE, val);
+		}
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
+				   sizeof(state), sizeof(state));
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
+static int platform_profile_get(struct platform_profile_handler *pprof,
+				enum platform_profile_option *profile)
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
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int platform_profile_set(struct platform_profile_handler *pprof,
+				enum platform_profile_option profile)
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
+	tp = thermal_profile_get();
+	if (tp < 0)
+		return tp;
+
+	/*
+	 * call thermal profile write command to ensure that the firmware correctly
+	 * sets the OEM variables for the DPTF
+	 */
+	err = thermal_profile_set(tp);
+	if (err)
+		return err;
+
+	platform_profile_handler.profile_get = platform_profile_get,
+	platform_profile_handler.profile_set = platform_profile_set,
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
+static int __init hp_wmi_bios_setup(struct platform_device *device)
+{
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
+					    hp_wmi_hw_state(HPWMI_DOCK_MASK));
+		if (test_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit))
+			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
+					    hp_wmi_hw_state(HPWMI_TABLET_MASK));
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
+static int __init hp_wmi_init(void)
+{
+	int event_capable = wmi_has_guid(HPWMI_EVENT_GUID);
+	int bios_capable = wmi_has_guid(HPWMI_BIOS_GUID);
+	int err;
+
+	if (!bios_capable && !event_capable)
+		return -ENODEV;
+
+	if (event_capable) {
+		err = hp_wmi_input_setup();
+		if (err)
+			return err;
+	}
+
+	if (bios_capable) {
+		hp_wmi_platform_dev =
+			platform_device_register_simple("hp-wmi", -1, NULL, 0);
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
index 000000000000..62a1d9346475
--- /dev/null
+++ b/drivers/platform/x86/hp/hp_accel.c
@@ -0,0 +1,405 @@
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
+	return lis3lv02d_remove_fs(&lis3_dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int lis3lv02d_suspend(struct device *dev)
+{
+	/* make sure the device is off when we suspend */
+	lis3lv02d_poweroff(&lis3_dev);
+	return 0;
+}
+
+static int lis3lv02d_resume(struct device *dev)
+{
+	lis3lv02d_poweron(&lis3_dev);
+	return 0;
+}
+
+static int lis3lv02d_restore(struct device *dev)
+{
+	lis3lv02d_poweron(&lis3_dev);
+	return 0;
+}
+
+static const struct dev_pm_ops hp_accel_pm = {
+	.suspend = lis3lv02d_suspend,
+	.resume = lis3lv02d_resume,
+	.freeze = lis3lv02d_suspend,
+	.thaw = lis3lv02d_resume,
+	.poweroff = lis3lv02d_suspend,
+	.restore = lis3lv02d_restore,
+};
+
+#define HP_ACCEL_PM (&hp_accel_pm)
+#else
+#define HP_ACCEL_PM NULL
+#endif
+
+/* For the HP MDPS aka 3D Driveguard */
+static struct platform_driver lis3lv02d_driver = {
+	.probe	= lis3lv02d_probe,
+	.remove	= lis3lv02d_remove,
+	.driver	= {
+		.name	= "hp_accel",
+		.pm	= HP_ACCEL_PM,
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
index 000000000000..9072eb302618
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
+	tc1100_device = platform_device_alloc("tc1100-wmi", -1);
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
index ef24f53753c6..000000000000
--- a/drivers/platform/x86/hp_accel.c
+++ /dev/null
@@ -1,405 +0,0 @@
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
-	return lis3lv02d_remove_fs(&lis3_dev);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int lis3lv02d_suspend(struct device *dev)
-{
-	/* make sure the device is off when we suspend */
-	lis3lv02d_poweroff(&lis3_dev);
-	return 0;
-}
-
-static int lis3lv02d_resume(struct device *dev)
-{
-	lis3lv02d_poweron(&lis3_dev);
-	return 0;
-}
-
-static int lis3lv02d_restore(struct device *dev)
-{
-	lis3lv02d_poweron(&lis3_dev);
-	return 0;
-}
-
-static const struct dev_pm_ops hp_accel_pm = {
-	.suspend = lis3lv02d_suspend,
-	.resume = lis3lv02d_resume,
-	.freeze = lis3lv02d_suspend,
-	.thaw = lis3lv02d_resume,
-	.poweroff = lis3lv02d_suspend,
-	.restore = lis3lv02d_restore,
-};
-
-#define HP_ACCEL_PM (&hp_accel_pm)
-#else
-#define HP_ACCEL_PM NULL
-#endif
-
-/* For the HP MDPS aka 3D Driveguard */
-static struct platform_driver lis3lv02d_driver = {
-	.probe	= lis3lv02d_probe,
-	.remove	= lis3lv02d_remove,
-	.driver	= {
-		.name	= "hp_accel",
-		.pm	= HP_ACCEL_PM,
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
index 9072eb302618..000000000000
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
-	tc1100_device = platform_device_alloc("tc1100-wmi", -1);
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
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index a0fabc3f13dc..aba3df1d1bf5 100644
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
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 61cde02b23fe..b21fa57d1a46 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1116,6 +1116,8 @@ static void io_subchannel_verify(struct subchannel *sch)
 	cdev = sch_get_cdev(sch);
 	if (cdev)
 		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+	else
+		css_schedule_eval(sch->schid);
 }
 
 static void io_subchannel_terminate_path(struct subchannel *sch, u8 mask)
diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index 99c2212dc6a6..a3230c5093b0 100644
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
index 8e8bbe734e87..560b2504e674 100644
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
 
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 83a3d9f085d8..c9b1500c2ab8 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1843,7 +1843,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
-	payload_sz = sizeof(cmd_request->mpb);
+	payload_sz = 0;
 
 	if (sg_count) {
 		unsigned int hvpgoff, hvpfns_to_add;
@@ -1851,10 +1851,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
 		u64 hvpfn;
 
-		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
+		payload_sz = (hvpg_count * sizeof(u64) +
+			      sizeof(struct vmbus_packet_mpb_array));
 
-			payload_sz = (hvpg_count * sizeof(u64) +
-				      sizeof(struct vmbus_packet_mpb_array));
+		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
 			payload = kzalloc(payload_sz, GFP_ATOMIC);
 			if (!payload)
 				return SCSI_MLQUEUE_DEVICE_BUSY;
diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
index e892b9feffb1..0920530a72d2 100644
--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -596,6 +596,7 @@ static const struct pci_device_id ufshcd_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x51FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x54FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x7E47), (kernel_ulong_t)&ufs_intel_mtl_hba_vops },
+	{ PCI_VDEVICE(INTEL, 0xA847), (kernel_ulong_t)&ufs_intel_mtl_hba_vops },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index bc2b16701a11..d00d263705e1 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8756,8 +8756,16 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
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
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 52d0e4164c6b..2ba0911f5d0c 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1142,6 +1142,9 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	ctrl->num_dout_ports = val;
 
 	nports = ctrl->num_dout_ports + ctrl->num_din_ports;
+	if (nports > QCOM_SDW_MAX_PORTS)
+		return -EINVAL;
+
 	/* Valid port numbers are from 1-14, so mask out port 0 explicitly */
 	set_bit(0, &ctrl->dout_port_mask);
 	set_bit(0, &ctrl->din_port_mask);
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 2f06f2840d61..f201653931d8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -247,6 +247,18 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
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
@@ -255,16 +267,16 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
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
index 6f90acf9c725..49ba521dd9ed 100644
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
index d0da083deed5..801e145ea976 100644
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
index 48c696df8d01..52d7dc5b2905 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -49,9 +49,9 @@ static const struct rtl819x_ops rtl819xp_ops = {
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
index 698552a92100..197f1e3d7aca 100644
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
index 9c6b98438f98..686a9e5918e2 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4387,6 +4387,9 @@ int iscsit_close_session(struct iscsi_session *sess, bool can_sleep)
 	iscsit_stop_time2retain_timer(sess);
 	spin_unlock_bh(&se_tpg->session_lock);
 
+	if (sess->sess_ops->ErrorRecoveryLevel == 2)
+		iscsit_free_connection_recovery_entries(sess);
+
 	/*
 	 * transport_deregister_session_configfs() will clear the
 	 * struct se_node_acl->nacl_sess pointer now as a iscsi_np process context
@@ -4410,9 +4413,6 @@ int iscsit_close_session(struct iscsi_session *sess, bool can_sleep)
 
 	transport_deregister_session(sess->se_sess);
 
-	if (sess->sess_ops->ErrorRecoveryLevel == 2)
-		iscsit_free_connection_recovery_entries(sess);
-
 	iscsit_free_all_ooo_cmdsns(sess);
 
 	spin_lock_bh(&se_tpg->session_lock);
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index f1e4f39bda2d..0e61c1c70247 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -51,6 +51,21 @@ static int ring_interrupt_index(const struct tb_ring *ring)
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
@@ -58,8 +73,8 @@ static int ring_interrupt_index(const struct tb_ring *ring)
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
@@ -120,7 +135,11 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
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
@@ -133,11 +152,11 @@ static void nhi_disable_interrupts(struct tb_nhi *nhi)
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
index 87ff28a3a94c..f95047160b4d 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1016,7 +1016,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	of_property_read_u32(np, "clock-frequency", &clk_rate);
 
 	/* See if a Baud clock has been specified */
-	baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
+	baud_mux_clk = devm_clk_get(dev, "sw_baud");
 	if (IS_ERR(baud_mux_clk)) {
 		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
@@ -1036,7 +1036,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	if (clk_rate == 0) {
 		dev_err(dev, "clock-frequency or clk not defined\n");
 		ret = -EINVAL;
-		goto release_dma;
+		goto err_clk_disable;
 	}
 
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
@@ -1123,6 +1123,8 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
+err_clk_disable:
+	clk_disable_unprepare(baud_mux_clk);
 release_dma:
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
@@ -1137,6 +1139,7 @@ static int brcmuart_remove(struct platform_device *pdev)
 	hrtimer_cancel(&priv->hrt);
 	serial8250_unregister_port(priv->line);
 	brcmuart_free_bufs(&pdev->dev, priv);
+	clk_disable_unprepare(priv->baud_mux_clk);
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f3bfaa1a794b..1890f342f090 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1156,6 +1156,7 @@ void serial8250_unregister_port(int line)
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
 		uart->capabilities = 0;
+		serial8250_init_port(uart);
 		serial8250_apply_quirks(uart);
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index c767636d9bb0..0b1976ceb01f 100644
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
@@ -818,6 +822,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
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
@@ -842,6 +855,10 @@ static const struct pci_device_id exar_pci_tbl[] = {
 
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
 
+	/* USRobotics USR298x-OEM PCI Modems */
+	USR_DEVICE(XR17C152, 2980, pbn_exar_XR17C15x),
+	USR_DEVICE(XR17C152, 2981, pbn_exar_XR17C15x),
+
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
 	EXAR_DEVICE(EXAR, XR17C152, pbn_exar_XR17C15x),
 	EXAR_DEVICE(EXAR, XR17C154, pbn_exar_XR17C15x),
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 8f0dafbab3bf..980ce0b5e5e6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2047,6 +2047,8 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCI_SUBDEVICE_ID_SIIG_DUAL_30	0x2530
 #define PCI_VENDOR_ID_ADVANTECH		0x13fe
 #define PCI_DEVICE_ID_INTEL_CE4100_UART 0x2e66
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600	0x1600
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600_1611	0x1611
 #define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
 #define PCI_DEVICE_ID_ADVANTECH_PCI3618	0x3618
 #define PCI_DEVICE_ID_ADVANTECH_PCIf618	0xf618
@@ -4393,6 +4395,9 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
 			 pciserial_resume_one);
 
 static const struct pci_device_id serial_pci_tbl[] = {
+	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI1600,
+		PCI_DEVICE_ID_ADVANTECH_PCI1600_1611, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
 	/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
 	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
 		PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 596217d10d5c..4d0e992f7844 100644
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
index ce1c81731a2a..5157ddffaf68 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1443,19 +1443,18 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
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
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index ef253599dcf9..116dbc2ae04d 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -18,6 +18,7 @@
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
 #include <linux/etherdevice.h>
+#include <linux/string_helpers.h>
 
 #include "u_ether.h"
 
@@ -976,6 +977,8 @@ int gether_get_host_addr_cdc(struct net_device *net, char *host_addr, int len)
 	dev = netdev_priv(net);
 	snprintf(host_addr, len, "%pm", dev->host_mac);
 
+	string_upper(host_addr, host_addr);
+
 	return strlen(host_addr);
 }
 EXPORT_SYMBOL_GPL(gether_get_host_addr_cdc);
diff --git a/drivers/usb/host/uhci-pci.c b/drivers/usb/host/uhci-pci.c
index 9b88745d247f..3316533b8bc2 100644
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
index 7308b388c92b..131a6dc2ecff 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/reset.h>
+#include <linux/suspend.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
@@ -195,7 +196,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
 		pdev->device == PCI_DEVICE_ID_AMD_RENOIR_XHCI)
-		xhci->quirks |= XHCI_BROKEN_D3COLD;
+		xhci->quirks |= XHCI_BROKEN_D3COLD_S2I;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
@@ -610,9 +611,16 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
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
index 220d836428d2..73f2ff83e1ad 100644
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
@@ -2207,6 +2227,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		     u32 trb_comp_code)
 {
 	struct xhci_ep_ctx *ep_ctx;
+	int trbs_freed;
 
 	ep_ctx = xhci_get_ep_ctx(xhci, ep->vdev->out_ctx, ep->ep_index);
 
@@ -2278,9 +2299,15 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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
index b8ad9676312b..0b22e8580863 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1902,7 +1902,7 @@ struct xhci_hcd {
 #define XHCI_DISABLE_SPARSE	BIT_ULL(38)
 #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
 #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
-#define XHCI_BROKEN_D3COLD	BIT_ULL(41)
+#define XHCI_BROKEN_D3COLD_S2I	BIT_ULL(41)
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index e5a971b83e3f..b8e1109f0e0d 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -407,22 +407,25 @@ static DEF_SCSI_QCMD(queuecommand)
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
 
@@ -445,6 +448,14 @@ static int command_abort(struct scsi_cmnd *srb)
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
@@ -456,6 +467,9 @@ static int device_reset(struct scsi_cmnd *srb)
 
 	usb_stor_dbg(us, "%s called\n", __func__);
 
+	/* abort any pending command before reset */
+	command_abort_matching(us, NULL);
+
 	/* lock the device pointers and do the reset */
 	mutex_lock(&(us->dev_mutex));
 	result = us->transport_reset(us);
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 9378b44e0628..8f0c6da27dd1 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -512,6 +512,10 @@ static ssize_t pin_assignment_show(struct device *dev,
 
 	mutex_unlock(&dp->lock);
 
+	/* get_current_pin_assignments can return 0 when no matching pin assignments are found */
+	if (len == 0)
+		len++;
+
 	buf[len - 1] = '\n';
 	return len;
 }
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 81329605757f..c6e5991b3868 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1506,7 +1506,21 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
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
index b512c82f9ccd..f7dd1dfd07f2 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1028,6 +1028,19 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
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
index 0f1b9c48838c..2ee67a27020d 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -394,8 +394,8 @@ struct smb_version_operations {
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
index ebf2877dbe76..872aebac9f68 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4869,9 +4869,9 @@ void cifs_oplock_break(struct work_struct *work)
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
@@ -4912,28 +4912,28 @@ void cifs_oplock_break(struct work_struct *work)
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
index 3b83839fc2c2..41e468d06b5b 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -864,12 +864,11 @@ cifs_close_dir(const unsigned int xid, struct cifs_tcon *tcon,
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
index 54058a9ada74..560c4ababfe1 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2570,15 +2570,14 @@ smb2_is_network_name_deleted(char *buf, struct TCP_Server_Info *server)
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
index 3be9dd6412b7..a610c096f3a9 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -179,6 +179,7 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_MIN_BLOCK_SIZE		1024
 #define	EXT2_MAX_BLOCK_SIZE		4096
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define EXT2_MAX_BLOCK_LOG_SIZE		  16
 #define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
 #define EXT2_BLOCK_SIZE_BITS(s)		((s)->s_blocksize_bits)
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 02d82f8fe85d..486a43e34795 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -947,6 +947,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
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
index 05ff34e92562..fadcb94e80fa 100644
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
index 80f0942fa165..b6e2bb6a736b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2699,6 +2699,8 @@ extern void ext4_check_blocks_bitmap(struct super_block *);
 extern struct ext4_group_desc * ext4_get_group_desc(struct super_block * sb,
 						    ext4_group_t block_group,
 						    struct buffer_head ** bh);
+extern struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
+						   ext4_group_t group);
 extern int ext4_should_retry_alloc(struct super_block *sb, int *retries);
 
 extern struct buffer_head *ext4_read_block_bitmap_nowait(struct super_block *sb,
@@ -3346,19 +3348,6 @@ static inline void ext4_isize_set(struct ext4_inode *raw_inode, loff_t i_size)
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
index 208b87ce8858..745d781da891 100644
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
@@ -1048,7 +1048,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 			 * Skip groups with already-known suspicious inode
 			 * tables
 			 */
-			if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+			if (!grp || EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
 				goto next_group;
 		}
 
@@ -1186,6 +1186,10 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 
 		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
 			grp = ext4_get_group_info(sb, group);
+			if (!grp) {
+				err = -EFSCORRUPTED;
+				goto out;
+			}
 			down_read(&grp->alloc_sem); /*
 						     * protect vs itable
 						     * lazyinit
@@ -1529,7 +1533,7 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
 	}
 
 	gdp = ext4_get_group_desc(sb, group, &group_desc_bh);
-	if (!gdp)
+	if (!gdp || !grp)
 		goto out;
 
 	/*
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0e0226b30db6..e8f5f05bddb3 100644
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
@@ -1110,9 +1112,9 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 
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
@@ -1233,6 +1235,8 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			break;
 
 		grinfo = ext4_get_group_info(sb, group);
+		if (!grinfo)
+			continue;
 		/*
 		 * If page is uptodate then we came here after online resize
 		 * which added some new uninitialized group info structs, so
@@ -1298,6 +1302,10 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
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
@@ -1308,7 +1316,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			ext4_lock_group(sb, group);
 			/* init the buddy */
 			memset(data, 0xff, blocksize);
-			ext4_mb_generate_buddy(sb, data, incore, group);
+			ext4_mb_generate_buddy(sb, data, incore, group, grinfo);
 			ext4_unlock_group(sb, group);
 			incore = NULL;
 		} else {
@@ -1422,6 +1430,9 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	might_sleep();
 	mb_debug(sb, "init group %u\n", group);
 	this_grp = ext4_get_group_info(sb, group);
+	if (!this_grp)
+		return -EFSCORRUPTED;
+
 	/*
 	 * This ensures that we don't reinit the buddy cache
 	 * page which map to the group from which we are already
@@ -1496,6 +1507,8 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
 	grp = ext4_get_group_info(sb, group);
+	if (!grp)
+		return -EFSCORRUPTED;
 
 	e4b->bd_blkbits = sb->s_blocksize_bits;
 	e4b->bd_info = grp;
@@ -2206,7 +2219,9 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct ext4_free_extent ex;
 
-	if (!(ac->ac_flags & EXT4_MB_HINT_TRY_GOAL))
+	if (!grp)
+		return -EFSCORRUPTED;
+	if (!(ac->ac_flags & (EXT4_MB_HINT_TRY_GOAL | EXT4_MB_HINT_GOAL_ONLY)))
 		return 0;
 	if (grp->bb_free == 0)
 		return 0;
@@ -2430,7 +2445,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 
 	BUG_ON(cr < 0 || cr >= 4);
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
 		return false;
 
 	free = grp->bb_free;
@@ -2499,6 +2514,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	ext4_grpblk_t free;
 	int ret = 0;
 
+	if (!grp)
+		return -EFSCORRUPTED;
 	if (sbi->s_mb_stats)
 		atomic64_inc(&sbi->s_bal_cX_groups_considered[ac->ac_criteria]);
 	if (should_lock) {
@@ -2579,7 +2596,7 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 		 * prefetch once, so we avoid getblk() call, which can
 		 * be expensive.
 		 */
-		if (!EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
+		if (gdp && grp && !EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
 		    EXT4_MB_GRP_NEED_INIT(grp) &&
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
@@ -2623,7 +2640,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 		group--;
 		grp = ext4_get_group_info(sb, group);
 
-		if (EXT4_MB_GRP_NEED_INIT(grp) &&
+		if (grp && gdp && EXT4_MB_GRP_NEED_INIT(grp) &&
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
 		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
@@ -2883,6 +2900,8 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 		sizeof(struct ext4_group_info);
 
 	grinfo = ext4_get_group_info(sb, group);
+	if (!grinfo)
+		return 0;
 	/* Load the group info in memory only if not already loaded. */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grinfo))) {
 		err = ext4_mb_load_buddy(sb, group, &e4b);
@@ -2893,7 +2912,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 		buddy_loaded = 1;
 	}
 
-	memcpy(&sg, ext4_get_group_info(sb, group), i);
+	memcpy(&sg, grinfo, i);
 
 	if (buddy_loaded)
 		ext4_mb_unload_buddy(&e4b);
@@ -3265,8 +3284,12 @@ static int ext4_mb_init_backend(struct super_block *sb)
 
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
@@ -3562,6 +3585,8 @@ int ext4_mb_release(struct super_block *sb)
 		for (i = 0; i < ngroups; i++) {
 			cond_resched();
 			grinfo = ext4_get_group_info(sb, i);
+			if (!grinfo)
+				continue;
 			mb_group_bb_bitmap_free(grinfo);
 			ext4_lock_group(sb, i);
 			count = ext4_mb_cleanup_pa(grinfo);
@@ -4020,6 +4045,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 				struct ext4_allocation_request *ar)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
 	ext4_lblk_t end;
 	loff_t size, start_off;
@@ -4200,18 +4226,21 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
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
 
@@ -4304,6 +4333,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
 	BUG_ON(start < pa->pa_pstart);
 	BUG_ON(end > pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len));
 	BUG_ON(pa->pa_free < len);
+	BUG_ON(ac->ac_b_ex.fe_len <= 0);
 	pa->pa_free -= len;
 
 	mb_debug(ac->ac_sb, "use %llu/%d from inode pa %p\n", start, len, pa);
@@ -4466,6 +4496,8 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 	struct ext4_free_data *entry;
 
 	grp = ext4_get_group_info(sb, group);
+	if (!grp)
+		return;
 	n = rb_first(&(grp->bb_free_root));
 
 	while (n) {
@@ -4493,6 +4525,9 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 	int preallocated = 0;
 	int len;
 
+	if (!grp)
+		return;
+
 	/* all form of preallocation discards first load group,
 	 * so the only competing code is preallocation use.
 	 * we don't need any locking here
@@ -4628,10 +4663,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
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
@@ -4639,26 +4672,40 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
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
@@ -4684,6 +4731,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
 	ei = EXT4_I(ac->ac_inode);
 	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
+	if (!grp)
+		return;
 
 	pa->pa_obj_lock = &ei->i_prealloc_lock;
 	pa->pa_inode = ac->ac_inode;
@@ -4737,6 +4786,8 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	atomic_add(pa->pa_free, &EXT4_SB(sb)->s_mb_preallocated);
 
 	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
+	if (!grp)
+		return;
 	lg = ac->ac_lg;
 	BUG_ON(lg == NULL);
 
@@ -4865,6 +4916,8 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	int err;
 	int free = 0;
 
+	if (!grp)
+		return 0;
 	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
 		goto out_dbg;
@@ -5102,6 +5155,9 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
 		struct ext4_prealloc_space *pa;
 		ext4_grpblk_t start;
 		struct list_head *cur;
+
+		if (!grp)
+			continue;
 		ext4_lock_group(sb, i);
 		list_for_each(cur, &grp->bb_prealloc_list) {
 			pa = list_entry(cur, struct ext4_prealloc_space,
@@ -5908,6 +5964,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	struct buffer_head *bitmap_bh = NULL;
 	struct super_block *sb = inode->i_sb;
 	struct ext4_group_desc *gdp;
+	struct ext4_group_info *grp;
 	unsigned int overflow;
 	ext4_grpblk_t bit;
 	struct buffer_head *gd_bh;
@@ -5933,8 +5990,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	overflow = 0;
 	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(
-			ext4_get_group_info(sb, block_group))))
+	grp = ext4_get_group_info(sb, block_group);
+	if (unlikely(!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		return;
 
 	/*
@@ -6537,6 +6594,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 
 	for (group = first_group; group <= last_group; group++) {
 		grp = ext4_get_group_info(sb, group);
+		if (!grp)
+			continue;
 		/* We only do this if the grp has never been initialized */
 		if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
 			ret = ext4_mb_init_group(sb, group, GFP_NOFS);
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index cebea4270817..3e8bce19ad16 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -39,28 +39,36 @@ static void ext4_mmp_csum_set(struct super_block *sb, struct mmp_struct *mmp)
  * Write the MMP block using REQ_SYNC to try to get the block on-disk
  * faster.
  */
-static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+static int write_mmp_block_thawed(struct super_block *sb,
+				  struct buffer_head *bh)
 {
 	struct mmp_struct *mmp = (struct mmp_struct *)(bh->b_data);
 
-	/*
-	 * We protect against freezing so that we don't create dirty buffers
-	 * on frozen filesystem.
-	 */
-	sb_start_write(sb);
 	ext4_mmp_csum_set(sb, mmp);
 	lock_buffer(bh);
 	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);
 	submit_bh(REQ_OP_WRITE, REQ_SYNC | REQ_META | REQ_PRIO, bh);
 	wait_on_buffer(bh);
-	sb_end_write(sb);
 	if (unlikely(!buffer_uptodate(bh)))
 		return -EIO;
-
 	return 0;
 }
 
+static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+{
+	int err;
+
+	/*
+	 * We protect against freezing so that we don't create dirty buffers
+	 * on frozen filesystem.
+	 */
+	sb_start_write(sb);
+	err = write_mmp_block_thawed(sb, bh);
+	sb_end_write(sb);
+	return err;
+}
+
 /*
  * Read the MMP block. It _must_ be read from disk and hence we clear the
  * uptodate flag on the buffer.
@@ -290,6 +298,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (mmp_block < le32_to_cpu(es->s_first_data_block) ||
 	    mmp_block >= ext4_blocks_count(es)) {
 		ext4_warning(sb, "Invalid MMP block in superblock");
+		retval = -EINVAL;
 		goto failed;
 	}
 
@@ -315,6 +324,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	if (seq == EXT4_MMP_SEQ_FSCK) {
 		dump_mmp_msg(sb, mmp, "fsck is running on the filesystem");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -328,6 +338,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
 		ext4_warning(sb, "MMP startup interrupted, failing mount\n");
+		retval = -ETIMEDOUT;
 		goto failed;
 	}
 
@@ -338,6 +349,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (seq != le32_to_cpu(mmp->mmp_seq)) {
 		dump_mmp_msg(sb, mmp,
 			     "Device is already active on another node.");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -348,7 +360,11 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	seq = mmp_new_seq();
 	mmp->mmp_seq = cpu_to_le32(seq);
 
-	retval = write_mmp_block(sb, bh);
+	/*
+	 * On mount / remount we are protected against fs freezing (by s_umount
+	 * semaphore) and grabbing freeze protection upsets lockdep
+	 */
+	retval = write_mmp_block_thawed(sb, bh);
 	if (retval)
 		goto failed;
 
@@ -357,6 +373,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	 */
 	if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
 		ext4_warning(sb, "MMP startup interrupted, failing mount");
+		retval = -ETIMEDOUT;
 		goto failed;
 	}
 
@@ -367,6 +384,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (seq != le32_to_cpu(mmp->mmp_seq)) {
 		dump_mmp_msg(sb, mmp,
 			     "Device is already active on another node.");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -383,6 +401,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		EXT4_SB(sb)->s_mmp_tsk = NULL;
 		ext4_warning(sb, "Unable to create kmmpd thread for %s.",
 			     sb->s_id);
+		retval = -ENOMEM;
 		goto failed;
 	}
 
@@ -390,5 +409,5 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 failed:
 	brelse(bh);
-	return 1;
+	return retval;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e6cd2bf9508e..bf8a780cd69b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1017,6 +1017,8 @@ void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 	struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group, NULL);
 	int ret;
 
+	if (!grp || !gdp)
+		return;
 	if (flags & EXT4_GROUP_INFO_BBITMAP_CORRUPT) {
 		ret = ext4_test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT,
 					    &grp->bb_state);
@@ -4646,9 +4648,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -5742,10 +5746,11 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	unsigned long old_sb_flags, vfs_flags;
 	struct ext4_mount_options old_opts;
-	int enable_quota = 0;
 	ext4_group_t g;
 	int err = 0;
+	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
+	int enable_quota = 0;
 	int i, j;
 	char *to_free[EXT4_MAXQUOTAS];
 #endif
@@ -5944,14 +5949,16 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
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
+#ifdef CONFIG_QUOTA
 			enable_quota = 1;
+#endif
 		}
 	}
 
@@ -6001,6 +6008,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
+	if (enable_rw)
+		sb->s_flags &= ~SB_RDONLY;
+
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
 
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c68f1f8000f1..d6ae6de35af2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -312,8 +312,15 @@ static int __f2fs_write_meta_page(struct page *page,
 
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
@@ -1298,7 +1305,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 		if (!get_pages(sbi, type))
 			break;
 
-		if (unlikely(f2fs_cp_error(sbi)))
+		if (unlikely(f2fs_cp_error(sbi) &&
+			!is_sbi_flag_set(sbi, SBI_IS_CLOSE)))
 			break;
 
 		if (type == F2FS_DIRTY_META)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d38bffe28b03..3956852ad1de 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2764,7 +2764,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
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
index 7424470c68cb..5c0920e11e4b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4284,6 +4284,11 @@ static inline bool f2fs_hw_is_readonly(struct f2fs_sb_info *sbi)
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
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4cc9b948139a..5c0b2b300aa1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2225,7 +2225,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (f2fs_readonly(sb) && (*flags & SB_RDONLY))
 		goto skip;
 
-	if (f2fs_sb_has_readonly(sbi) && !(*flags & SB_RDONLY)) {
+	if (f2fs_dev_is_readonly(sbi) && !(*flags & SB_RDONLY)) {
 		err = -EROFS;
 		goto restore_opts;
 	}
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 450032b4c886..558932ad89d5 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -394,6 +394,7 @@ static int inode_go_demote_ok(const struct gfs2_glock *gl)
 
 static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	const struct gfs2_dinode *str = buf;
 	struct timespec64 atime;
 	u16 height, depth;
@@ -440,7 +441,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	/* i_diskflags and i_eattr must be set before gfs2_set_inode_flags() */
 	gfs2_set_inode_flags(inode);
 	height = be16_to_cpu(str->di_height);
-	if (unlikely(height > GFS2_MAX_META_HEIGHT))
+	if (unlikely(height > sdp->sd_max_height))
 		goto corrupt;
 	ip->i_height = (u8)height;
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index bf6f75f569e4..87bc222dc906 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -509,7 +509,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
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
@@ -529,7 +533,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
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
 
@@ -560,6 +568,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		pr_err("bad catalog entry used to create inode\n");
 		res = -EIO;
 	}
+out:
 	return res;
 }
 
@@ -568,6 +577,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	struct inode *main_inode = inode;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
+	int res = 0;
 
 	if (HFSPLUS_IS_RSRC(inode))
 		main_inode = HFSPLUS_I(inode)->rsrc_inode;
@@ -586,7 +596,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
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
@@ -611,7 +625,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
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
@@ -632,7 +650,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
-	return 0;
+	return res;
 }
 
 int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa)
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index b4c79359ef8b..cab274b77727 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -320,7 +320,8 @@ int ksmbd_conn_handler_loop(void *p)
 			break;
 
 		/* 4 for rfc1002 length field */
-		size = pdu_size + 4;
+		/* 1 for implied bcc[0] */
+		size = pdu_size + 4 + 1;
 		conn->request_buf = kvmalloc(size, GFP_KERNEL);
 		if (!conn->request_buf)
 			break;
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 3f759f9123ea..2e2df6ede583 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1446,11 +1446,12 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
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
@@ -1489,7 +1490,7 @@ struct create_context *smb2_find_context_vals(void *open_req, const char *tag)
 			return ERR_PTR(-EINVAL);
 
 		name = (char *)cc + name_off;
-		if (memcmp(name, tag, name_len) == 0)
+		if (name_len == tag_len && !memcmp(name, tag, name_len))
 			return cc;
 
 		remain_len -= next;
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index 119b8047cfbd..2c4f4a0512b7 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -120,7 +120,7 @@ void create_durable_v2_rsp_buf(char *cc, struct ksmbd_file *fp);
 void create_mxac_rsp_buf(char *cc, int maximal_access);
 void create_disk_id_rsp_buf(char *cc, __u64 file_id, __u64 vol_id);
 void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp);
-struct create_context *smb2_find_context_vals(void *open_req, const char *str);
+struct create_context *smb2_find_context_vals(void *open_req, const char *tag, int tag_len);
 struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 					  char *lease_key);
 int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index c579d0e09c13..33a927df64f1 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -422,8 +422,11 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 
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
index 51d495688f45..c73cf11223f7 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1387,7 +1387,7 @@ static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
 	struct authenticate_message *authblob;
 	struct ksmbd_user *user;
 	char *name;
-	unsigned int auth_msg_len, name_off, name_len, secbuf_len;
+	unsigned int name_off, name_len, secbuf_len;
 
 	secbuf_len = le16_to_cpu(req->SecurityBufferLength);
 	if (secbuf_len < sizeof(struct authenticate_message)) {
@@ -1397,9 +1397,8 @@ static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
 	authblob = user_authblob(conn, req);
 	name_off = le32_to_cpu(authblob->UserName.BufferOffset);
 	name_len = le16_to_cpu(authblob->UserName.Length);
-	auth_msg_len = le16_to_cpu(req->SecurityBufferOffset) + secbuf_len;
 
-	if (auth_msg_len < (u64)name_off + name_len)
+	if (secbuf_len < (u64)name_off + name_len)
 		return NULL;
 
 	name = smb_strndup_from_utf16((const char *)authblob + name_off,
@@ -2473,7 +2472,7 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
 		return -ENOENT;
 
 	/* Parse SD BUFFER create contexts */
-	context = smb2_find_context_vals(req, SMB2_CREATE_SD_BUFFER);
+	context = smb2_find_context_vals(req, SMB2_CREATE_SD_BUFFER, 4);
 	if (!context)
 		return -ENOENT;
 	else if (IS_ERR(context))
@@ -2674,7 +2673,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	if (req->CreateContextsOffset) {
 		/* Parse non-durable handle create contexts */
-		context = smb2_find_context_vals(req, SMB2_CREATE_EA_BUFFER);
+		context = smb2_find_context_vals(req, SMB2_CREATE_EA_BUFFER, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
 			goto err_out1;
@@ -2694,7 +2693,7 @@ int smb2_open(struct ksmbd_work *work)
 		}
 
 		context = smb2_find_context_vals(req,
-						 SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST);
+						 SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
 			goto err_out1;
@@ -2705,7 +2704,7 @@ int smb2_open(struct ksmbd_work *work)
 		}
 
 		context = smb2_find_context_vals(req,
-						 SMB2_CREATE_TIMEWARP_REQUEST);
+						 SMB2_CREATE_TIMEWARP_REQUEST, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
 			goto err_out1;
@@ -2717,7 +2716,7 @@ int smb2_open(struct ksmbd_work *work)
 
 		if (tcon->posix_extensions) {
 			context = smb2_find_context_vals(req,
-							 SMB2_CREATE_TAG_POSIX);
+							 SMB2_CREATE_TAG_POSIX, 16);
 			if (IS_ERR(context)) {
 				rc = PTR_ERR(context);
 				goto err_out1;
@@ -3122,7 +3121,7 @@ int smb2_open(struct ksmbd_work *work)
 		struct create_alloc_size_req *az_req;
 
 		az_req = (struct create_alloc_size_req *)smb2_find_context_vals(req,
-					SMB2_CREATE_ALLOCATION_SIZE);
+					SMB2_CREATE_ALLOCATION_SIZE, 4);
 		if (IS_ERR(az_req)) {
 			rc = PTR_ERR(az_req);
 			goto err_out;
@@ -3149,7 +3148,7 @@ int smb2_open(struct ksmbd_work *work)
 					    err);
 		}
 
-		context = smb2_find_context_vals(req, SMB2_CREATE_QUERY_ON_DISK_ID);
+		context = smb2_find_context_vals(req, SMB2_CREATE_QUERY_ON_DISK_ID, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
 			goto err_out;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index f4e74fac2c51..c1ab0bfc3ed5 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -921,6 +921,7 @@ void nilfs_evict_inode(struct inode *inode)
 	struct nilfs_transaction_info ti;
 	struct super_block *sb = inode->i_sb;
 	struct nilfs_inode_info *ii = NILFS_I(inode);
+	struct the_nilfs *nilfs;
 	int ret;
 
 	if (inode->i_nlink || !ii->i_root || unlikely(is_bad_inode(inode))) {
@@ -933,6 +934,23 @@ void nilfs_evict_inode(struct inode *inode)
 
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
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index cdeb0b51f0ba..d24e12d348d4 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -101,7 +101,7 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
 		ni_delete_all(ni);
 
 	al_destroy(ni);
@@ -3189,6 +3189,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		return 0;
 	}
 
+	if (!ni->mi.mrec)
+		goto out;
+
 	if (is_rec_inuse(ni->mi.mrec) &&
 	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING) && inode->i_nlink) {
 		bool modified = false;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 4a97a28cb8f2..3c823613de97 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1686,6 +1686,7 @@ struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST rno, bool dir)
 
 out:
 	if (err) {
+		make_bad_inode(inode);
 		iput(inode);
 		ni = ERR_PTR(err);
 	}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index f62e0df7a7b4..1ae3b310869d 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -934,6 +934,7 @@ struct INDEX_ROOT *indx_get_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct ATTRIB *a;
 	const struct INDEX_NAMES *in = &s_index_names[indx->type];
+	struct INDEX_ROOT *root = NULL;
 
 	a = ni_find_attr(ni, NULL, &le, ATTR_ROOT, in->name, in->name_len, NULL,
 			 mi);
@@ -943,7 +944,15 @@ struct INDEX_ROOT *indx_get_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (attr)
 		*attr = a;
 
-	return resident_data_ex(a, sizeof(struct INDEX_ROOT));
+	root = resident_data_ex(a, sizeof(struct INDEX_ROOT));
+
+	/* length check */
+	if (root && offsetof(struct INDEX_ROOT, ihdr) + le32_to_cpu(root->ihdr.used) >
+			le32_to_cpu(a->res.data_size)) {
+		return NULL;
+	}
+
+	return root;
 }
 
 static int indx_write(struct ntfs_index *indx, struct ntfs_inode *ni,
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 359eff346910..2034c0ae6549 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -98,6 +98,12 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	/* Record should contain $I30 root. */
 	is_dir = rec->flags & RECORD_FLAG_DIR;
 
+	/* MFT_REC_MFT is not a dir */
+	if (is_dir && ino == MFT_REC_MFT) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	inode->i_generation = le16_to_cpu(rec->seq);
 
 	/* Enumerate all struct Attributes MFT. */
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index fd342da398be..41f6e578966b 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -220,11 +220,6 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 		}
 
-		if (off + asize < off) {
-			/* overflow check */
-			return NULL;
-		}
-
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
@@ -247,8 +242,8 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	if ((t32 & 0xf) || (t32 > 0x100))
 		return NULL;
 
-	/* Check boundary. */
-	if (off + asize > used)
+	/* Check overflow and boundary. */
+	if (off + asize < off || off + asize > used)
 		return NULL;
 
 	/* Check size of attribute. */
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
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index c88ccc48877d..dbca858ffa6d 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -159,7 +159,6 @@ enum cpuhp_state {
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
index 41a518336673..4e7e72f3da5b 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -626,6 +626,23 @@ static inline __be16 vlan_get_protocol(const struct sk_buff *skb)
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
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 1009b6b5ce40..879a5c8f930b 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -23,7 +23,7 @@ static __always_inline void *task_stack_page(const struct task_struct *task)
 
 #define setup_thread_stack(new,old)	do { } while(0)
 
-static inline unsigned long *end_of_stack(const struct task_struct *task)
+static __always_inline unsigned long *end_of_stack(const struct task_struct *task)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long *)((unsigned long)task->stack + THREAD_SIZE) - 1;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index cc338c6c7495..24bc3f7967c3 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -260,6 +260,7 @@ struct plat_stmmacenet_data {
 	bool has_crossts;
 	int int_snapshot_num;
 	int ext_snapshot_num;
+	bool int_snapshot_en;
 	bool ext_snapshot_en;
 	bool multi_msi_en;
 	int msi_mac_vec;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 045f34add206..664a54e330af 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -246,7 +246,6 @@ struct svc_rqst {
 	void *			rq_xprt_ctxt;	/* transport specific context ptr */
 	struct svc_deferred_req*rq_deferred;	/* deferred request we are replaying */
 
-	size_t			rq_xprt_hlen;	/* xprt header len */
 	struct xdr_buf		rq_arg;
 	struct xdr_stream	rq_arg_stream;
 	struct xdr_stream	rq_res_stream;
@@ -386,7 +385,6 @@ struct svc_deferred_req {
 	size_t			daddrlen;
 	void			*xprt_ctxt;
 	struct cache_deferred_req handle;
-	size_t			xprt_hlen;
 	int			argslen;
 	__be32			args[];
 };
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
index 571f605bc91e..154eee6bc6a0 100644
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
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 7cb5a1aace40..59f8412de45a 100644
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
index 3a4e81399edc..0309d2311487 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2623,7 +2623,7 @@ static inline void sock_recv_ts_and_drops(struct msghdr *msg, struct sock *sk,
 		__sock_recv_ts_and_drops(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
 		sock_write_timestamp(sk, skb->tstamp);
-	else if (unlikely(sk->sk_stamp == SK_DEFAULT_STAMP))
+	else if (unlikely(sock_read_timestamp(sk) == SK_DEFAULT_STAMP))
 		sock_write_timestamp(sk, 0);
 }
 
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 04939b2d2f19..26ec024c3d58 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_sockaddr
+#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
+
 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field)	\
 		((void *)(&__entry->__rel_loc_##field) +	\
@@ -37,6 +40,9 @@
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
 
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
+
 #undef __perf_count
 #define __perf_count(c)	(c)
 
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 2a598fb45bf4..f09bbb6c918e 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1923,19 +1923,17 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
 	TP_STRUCT__entry(
 		__field(const void *, dr)
 		__field(u32, xid)
-		__array(__u8, addr, INET6_ADDRSTRLEN + 10)
+		__sockaddr(addr, dr->addrlen)
 	),
 
 	TP_fast_assign(
 		__entry->dr = dr;
-		__entry->xid = be32_to_cpu(*(__be32 *)(dr->args +
-						       (dr->xprt_hlen>>2)));
-		snprintf(__entry->addr, sizeof(__entry->addr) - 1,
-			 "%pISpc", (struct sockaddr *)&dr->addr);
+		__entry->xid = be32_to_cpu(*(__be32 *)dr->args);
+		__assign_sockaddr(addr, &dr->addr, dr->addrlen);
 	),
 
-	TP_printk("addr=%s dr=%p xid=0x%08x", __entry->addr, __entry->dr,
-		__entry->xid)
+	TP_printk("addr=%pISpc dr=%p xid=0x%08x", __get_sockaddr(addr),
+		__entry->dr, __entry->xid)
 );
 
 #define DEFINE_SVC_DEFERRED_EVENT(name) \
diff --git a/include/trace/perf.h b/include/trace/perf.h
index 5d48c46a3008..5800d13146c3 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_sockaddr
+#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
+
 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field)	\
 		((void *)__entry +					\
@@ -38,6 +41,9 @@
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
 
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
+
 #undef __perf_count
 #define __perf_count(c)	(__count = (c))
 
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 7f0b91dfb532..e6b19ab35781 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -108,6 +108,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len) u32 __rel_loc_##item;
 
@@ -120,6 +123,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)
 
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
 #undef TP_STRUCT__entry
 #define TP_STRUCT__entry(args...) args
 
@@ -212,11 +218,14 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
-#undef __string_len
-#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len)	u32 item;
@@ -230,6 +239,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 	struct trace_event_data_offsets_##call {			\
@@ -349,6 +361,12 @@ TRACE_MAKE_SYSTEM_STR();
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
 
+#undef __get_sockaddr
+#define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(field))
+
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field)	((struct sockaddr *)__get_rel_dynamic_array(field))
+
 #undef __print_flags
 #define __print_flags(flag, delim, flag_array...)			\
 	({								\
@@ -520,6 +538,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(_type, _item, _len) {			\
 	.type = "__rel_loc " #_type "[]", .name = #_item,		\
@@ -535,6 +556,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
 static struct trace_event_fields trace_event_fields_##call[] = {	\
@@ -626,6 +650,12 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item,	\
 					 __bitmask_size_in_longs(nr_bits))
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 static inline notrace int trace_event_get_offsets_##call(		\
@@ -790,6 +820,15 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define __assign_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
+#undef __get_sockaddr
+#define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(field))
+
+#define __assign_sockaddr(dest, src, len)					\
+	memcpy(__get_dynamic_array(dest), src, len)
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len)				\
 	__entry->__rel_loc_##item = __data_offsets.item;
@@ -821,6 +860,16 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define __assign_rel_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field)	((struct sockaddr *)__get_rel_dynamic_array(field))
+
+#define __assign_rel_sockaddr(dest, src, len)					\
+	memcpy(__get_rel_dynamic_array(dest), src, len)
+
+
 #undef TP_fast_assign
 #define TP_fast_assign(args...) args
 
@@ -885,10 +934,12 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef __get_dynamic_array_len
 #undef __get_str
 #undef __get_bitmask
+#undef __get_sockaddr
 #undef __get_rel_dynamic_array
 #undef __get_rel_dynamic_array_len
 #undef __get_rel_str
 #undef __get_rel_bitmask
+#undef __get_rel_sockaddr
 #undef __print_array
 #undef __print_hex_dump
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 6c2d39a3d558..5ef8eaf4985e 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -48,11 +48,21 @@ owner_storage(struct bpf_local_storage_map *smap, void *owner)
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
@@ -142,7 +152,7 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
 	bool free_local_storage = false;
 	unsigned long flags;
 
-	if (unlikely(!selem_linked_to_storage(selem)))
+	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
 		return;
 
@@ -170,7 +180,7 @@ void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
-	if (unlikely(!selem_linked_to_map(selem)))
+	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
 		return;
 
@@ -373,7 +383,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		err = check_flags(old_sdata, map_flags);
 		if (err)
 			return ERR_PTR(err);
-		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
+		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
 			copy_map_value_locked(&smap->map, old_sdata->data,
 					      value, false);
 			return old_sdata;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 261c2ed3adb1..d0db1c7e2645 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13645,6 +13645,10 @@ BTF_ID(func, migrate_enable)
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
index 66dc14cf5687..5abb0cf52803 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -777,7 +777,7 @@ ref_scale_cleanup(void)
 static int
 ref_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq, shutdown_start);
+	wait_event_idle(shutdown_wq, shutdown_start);
 
 	smp_mb(); // Wake before output.
 	ref_scale_cleanup();
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f9fb2793b019..f46c0c1a5eb3 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -708,9 +708,11 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
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
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index b6d456c7952e..3d0f0d0a323b 100644
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
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 446343348329..f01b77b03787 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4694,7 +4694,6 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan) {
-		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index ec646656dbf1..3d69ad5463a9 100644
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
index 2a891f47b815..ca69ca39c8fd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1018,7 +1018,7 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	int noblock = flags & MSG_DONTWAIT;
 	int ret = 0;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
+	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
 	if (!so->bound)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 41016aff21c5..d1d4bdc1de46 100644
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
index 28e5f921dcaf..1ff8241217a9 100644
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
index 7fc8ae7f3cd5..56a3bff7249d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2574,6 +2574,8 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 	struct xps_map *map, *new_map;
 	unsigned int nr_ids;
 
+	WARN_ON_ONCE(index >= dev->num_tx_queues);
+
 	if (dev->num_tc) {
 		/* Do not allow XPS on subordinate device directly */
 		num_tc = dev->num_tc;
@@ -3314,7 +3316,7 @@ __be16 skb_network_protocol(struct sk_buff *skb, int *depth)
 		type = eth->h_proto;
 	}
 
-	return __vlan_get_protocol(skb, type, depth);
+	return vlan_get_protocol_and_depth(skb, type, depth);
 }
 
 /**
diff --git a/net/core/stream.c b/net/core/stream.c
index cd60746877b1..422ee97e4f2b 100644
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
index 91710e5eedff..7fa1b0a45176 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -890,7 +890,7 @@ int inet_shutdown(struct socket *sock, int how)
 		   EPOLLHUP, even on eg. unconnected UDP sockets -- RR */
 		fallthrough;
 	default:
-		sk->sk_shutdown |= how;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | how);
 		if (sk->sk_prot->shutdown)
 			sk->sk_prot->shutdown(sk, how);
 		break;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 51f34560a9d6..b91ddd2a2f96 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -502,6 +502,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	__poll_t mask;
 	struct sock *sk = sock->sk;
 	const struct tcp_sock *tp = tcp_sk(sk);
+	u8 shutdown;
 	int state;
 
 	sock_poll_wait(file, sock, wait);
@@ -544,9 +545,10 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
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
@@ -562,7 +564,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 		if (tcp_stream_is_readable(sk, target))
 			mask |= EPOLLIN | EPOLLRDNORM;
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+		if (!(shutdown & SEND_SHUTDOWN)) {
 			if (__sk_stream_is_writeable(sk, 1)) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
@@ -2740,7 +2742,7 @@ void __tcp_close(struct sock *sk, long timeout)
 	int data_was_unread = 0;
 	int state;
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
@@ -3006,7 +3008,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
 		inet_reset_saddr(sk);
 
-	sk->sk_shutdown = 0;
+	WRITE_ONCE(sk->sk_shutdown, 0);
 	sock_reset_flag(sk, SOCK_DONE);
 	tp->srtt_us = 0;
 	tp->mdev_us = jiffies_to_usecs(TCP_TIMEOUT_INIT);
@@ -4453,7 +4455,7 @@ void tcp_done(struct sock *sk)
 	if (req)
 		reqsk_fastopen_remove(sk, req, false);
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk->sk_state_change(sk);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 20ad554af369..e3a9477293ce 100644
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
index 102a0436eb29..65f5d07cd83d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4353,7 +4353,7 @@ void tcp_fin(struct sock *sk)
 
 	inet_csk_schedule_ack(sk);
 
-	sk->sk_shutdown |= RCV_SHUTDOWN;
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 	sock_set_flag(sk, SOCK_DONE);
 
 	switch (sk->sk_state) {
@@ -6531,7 +6531,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			break;
 
 		tcp_set_state(sk, TCP_FIN_WAIT2);
-		sk->sk_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
 
 		sk_dst_confirm(sk);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 63472c9b39ae..db05ab4287e3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -820,6 +820,9 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 				   inet_twsk(sk)->tw_priority : sk->sk_priority;
 		transmit_time = tcp_transmit_time(sk);
 		xfrm_sk_clone_policy(ctl_sk, sk);
+	} else {
+		ctl_sk->sk_mark = 0;
+		ctl_sk->sk_priority = 0;
 	}
 	ip_send_unicast_reply(ctl_sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
@@ -827,7 +830,6 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 			      &arg, arg.iov[0].iov_len,
 			      transmit_time);
 
-	ctl_sk->sk_mark = 0;
 	xfrm_sk_free_policy(ctl_sk);
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
@@ -926,7 +928,6 @@ static void tcp_v4_send_ack(const struct sock *sk,
 			      &arg, arg.iov[0].iov_len,
 			      transmit_time);
 
-	ctl_sk->sk_mark = 0;
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	local_bh_enable();
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index a91f93ec7d2b..0b041ab79ad9 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1015,12 +1015,14 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
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
@@ -1043,24 +1045,25 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
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
index 1d6ae1df3886..d34fed1a484a 100644
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
index 99305aadaa08..8b9a10d10036 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -581,7 +581,8 @@ static int llc_ui_wait_for_disc(struct sock *sk, long timeout)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
-		if (sk_wait_event(sk, &timeout, sk->sk_state == TCP_CLOSE, &wait))
+		if (sk_wait_event(sk, &timeout,
+				  READ_ONCE(sk->sk_state) == TCP_CLOSE, &wait))
 			break;
 		rc = -ERESTARTSYS;
 		if (signal_pending(current))
@@ -601,7 +602,8 @@ static bool llc_ui_wait_for_conn(struct sock *sk, long timeout)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
-		if (sk_wait_event(sk, &timeout, sk->sk_state != TCP_SYN_SENT, &wait))
+		if (sk_wait_event(sk, &timeout,
+				  READ_ONCE(sk->sk_state) != TCP_SYN_SENT, &wait))
 			break;
 		if (signal_pending(current) || !timeout)
 			break;
@@ -620,7 +622,7 @@ static int llc_ui_wait_for_busy_core(struct sock *sk, long timeout)
 	while (1) {
 		rc = 0;
 		if (sk_wait_event(sk, &timeout,
-				  (sk->sk_shutdown & RCV_SHUTDOWN) ||
+				  (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) ||
 				  (!llc_data_accept_state(llc->state) &&
 				   !llc->remote_busy_flag &&
 				   !llc->p_flag), &wait))
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 9e8381bef7ed..8a9b62f6e923 100644
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
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index cca0762a9010..8eed6536e7e7 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -675,9 +675,11 @@ void nf_conntrack_destroy(struct nf_conntrack *nfct)
 
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
index a56fd0b5a430..0d89e68dc9d1 100644
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
index 338f02a12076..7515705583bc 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -1229,11 +1229,12 @@ static int __init nf_conntrack_standalone_init(void)
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
index 091df8a7cb1e..f20244a91d78 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3595,12 +3595,10 @@ static struct nft_rule *nft_rule_lookup_byid(const struct net *net,
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
index 3ced0eb6b7c3..5b02408a920b 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -342,6 +342,12 @@ static void nft_netdev_event(unsigned long event, struct net_device *dev,
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
 
@@ -360,9 +366,6 @@ static int nf_tables_netdev_event(struct notifier_block *this,
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
index 84a7a29be49d..998c736d3ae8 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2000,7 +2000,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
-	if (nlk->cb_running &&
+	if (READ_ONCE(nlk->cb_running) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
 		ret = netlink_dump(sk);
 		if (ret) {
@@ -2312,7 +2312,7 @@ static int netlink_dump(struct sock *sk)
 	if (cb->done)
 		cb->done(cb);
 
-	nlk->cb_running = false;
+	WRITE_ONCE(nlk->cb_running, false);
 	module = cb->module;
 	skb = cb->skb;
 	mutex_unlock(nlk->cb_mutex);
@@ -2375,7 +2375,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 			goto error_put;
 	}
 
-	nlk->cb_running = true;
+	WRITE_ONCE(nlk->cb_running, true);
 	nlk->dump_done_errno = INT_MAX;
 
 	mutex_unlock(nlk->cb_mutex);
@@ -2661,7 +2661,7 @@ static int netlink_native_seq_show(struct seq_file *seq, void *v)
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
index f5d430bd372c..ce484305be88 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1900,10 +1900,8 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
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
index 84102db5bb31..149a59ecd299 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -64,8 +64,8 @@ static void smc_close_stream_wait(struct smc_sock *smc, long timeout)
 
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
index 45b0575520da..5b63c250ba60 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -204,9 +204,9 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
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
index 31ee76131a79..a878ea084dbd 100644
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
index 73666b878f2c..5c49074ef7f2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2820,7 +2820,7 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 		 * error to return on the next call or if the
 		 * app asks about it using getsockopt(SO_ERROR).
 		 */
-		sock->sk->sk_err = -err;
+		WRITE_ONCE(sock->sk->sk_err, -err);
 	}
 out_put:
 	fput_light(sock->file, fput_needed);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 74a1c9116a78..36a3ad9336d6 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1024,7 +1024,7 @@ static int __svc_register(struct net *net, const char *progname,
 #endif
 	}
 
-	trace_svc_register(progname, version, protocol, port, family, error);
+	trace_svc_register(progname, version, family, protocol, port, error);
 	return error;
 }
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 935bba065636..5ff8f902f14d 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -530,13 +530,23 @@ void svc_reserve(struct svc_rqst *rqstp, int space)
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
@@ -1054,7 +1064,7 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 	spin_unlock_bh(&serv->sv_lock);
 
 	while ((dr = svc_deferred_dequeue(xprt)) != NULL)
-		kfree(dr);
+		free_deferred(xprt, dr);
 
 	call_xpt_users(xprt);
 	svc_xprt_put(xprt);
@@ -1166,8 +1176,8 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
 	if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
 		spin_unlock(&xprt->xpt_lock);
 		trace_svc_defer_drop(dr);
+		free_deferred(xprt, dr);
 		svc_xprt_put(xprt);
-		kfree(dr);
 		return;
 	}
 	dr->xprt = NULL;
@@ -1212,15 +1222,14 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		dr->addrlen = rqstp->rq_addrlen;
 		dr->daddr = rqstp->rq_daddr;
 		dr->argslen = rqstp->rq_arg.len >> 2;
-		dr->xprt_hlen = rqstp->rq_xprt_hlen;
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
@@ -1240,22 +1249,23 @@ static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 	trace_svc_defer_recv(dr);
 
 	/* setup iov_base past transport header */
-	rqstp->rq_arg.head[0].iov_base = dr->args + (dr->xprt_hlen>>2);
+	rqstp->rq_arg.head[0].iov_base = dr->args;
 	/* The iov_len does not include the transport header bytes */
-	rqstp->rq_arg.head[0].iov_len = (dr->argslen<<2) - dr->xprt_hlen;
+	rqstp->rq_arg.head[0].iov_len = dr->argslen << 2;
 	rqstp->rq_arg.page_len = 0;
 	/* The rq_arg.len includes the transport header bytes */
-	rqstp->rq_arg.len     = dr->argslen<<2;
+	rqstp->rq_arg.len     = dr->argslen << 2;
 	rqstp->rq_prot        = dr->prot;
 	memcpy(&rqstp->rq_addr, &dr->addr, dr->addrlen);
 	rqstp->rq_addrlen     = dr->addrlen;
 	/* Save off transport header len in case we get deferred again */
-	rqstp->rq_xprt_hlen   = dr->xprt_hlen;
 	rqstp->rq_daddr       = dr->daddr;
 	rqstp->rq_respages    = rqstp->rq_pages;
 	rqstp->rq_xprt_ctxt   = dr->xprt_ctxt;
+
+	dr->xprt_ctxt = NULL;
 	svc_xprt_received(rqstp->rq_xprt);
-	return (dr->argslen<<2) - dr->xprt_hlen;
+	return dr->argslen << 2;
 }
 
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 6ea3d87e1147..6fc7a8c52369 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -111,36 +111,27 @@ static void svc_reclassify_socket(struct socket *sock)
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
-	struct sk_buff *skb = rqstp->rq_xprt_ctxt;
-
-	if (skb) {
-		struct svc_sock *svsk =
-			container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
-
-		rqstp->rq_xprt_ctxt = NULL;
-		skb_free_datagram_locked(svsk->sk_sk, skb);
-	}
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
@@ -259,8 +250,6 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 	ssize_t len;
 	size_t t;
 
-	rqstp->rq_xprt_hlen = 0;
-
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 
 	for (i = 0, t = 0; t < buflen; i++, t += PAGE_SIZE) {
@@ -570,7 +559,8 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	unsigned int sent;
 	int err;
 
-	svc_udp_release_rqst(rqstp);
+	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
+	rqstp->rq_xprt_ctxt = NULL;
 
 	svc_set_cmsg_data(rqstp, cmh);
 
@@ -639,7 +629,7 @@ static const struct svc_xprt_ops svc_udp_ops = {
 	.xpo_recvfrom = svc_udp_recvfrom,
 	.xpo_sendto = svc_udp_sendto,
 	.xpo_result_payload = svc_sock_result_payload,
-	.xpo_release_rqst = svc_udp_release_rqst,
+	.xpo_release_ctxt = svc_udp_release_ctxt,
 	.xpo_detach = svc_sock_detach,
 	.xpo_free = svc_sock_free,
 	.xpo_has_wspace = svc_udp_has_wspace,
@@ -1167,7 +1157,8 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	unsigned int sent;
 	int err;
 
-	svc_tcp_release_rqst(rqstp);
+	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
+	rqstp->rq_xprt_ctxt = NULL;
 
 	atomic_inc(&svsk->sk_sendqlen);
 	mutex_lock(&xprt->xpt_mutex);
@@ -1212,7 +1203,7 @@ static const struct svc_xprt_ops svc_tcp_ops = {
 	.xpo_recvfrom = svc_tcp_recvfrom,
 	.xpo_sendto = svc_tcp_sendto,
 	.xpo_result_payload = svc_sock_result_payload,
-	.xpo_release_rqst = svc_tcp_release_rqst,
+	.xpo_release_ctxt = svc_tcp_release_ctxt,
 	.xpo_detach = svc_tcp_sock_detach,
 	.xpo_free = svc_sock_free,
 	.xpo_has_wspace = svc_tcp_has_wspace,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 387a5da09daf..3ad4291148a6 100644
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
@@ -826,7 +825,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		goto out_err;
 	if (ret == 0)
 		goto out_drop;
-	rqstp->rq_xprt_hlen = 0;
 
 	if (svc_rdma_is_reverse_direction_reply(xprt, ctxt))
 		goto out_backchannel;
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
index b0ad61b4b101..1048607a1528 100644
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
index 57c6a1a719e2..483f90958857 100644
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
index 8fdd3b23bd12..655a2e1b6dfe 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -2199,7 +2199,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 	struct tipc_msg *hdr = buf_msg(skb);
 	struct tipc_gap_ack_blks *ga = NULL;
 	bool reply = msg_probe(hdr), retransmitted = false;
-	u32 dlen = msg_data_sz(hdr), glen = 0;
+	u32 dlen = msg_data_sz(hdr), glen = 0, msg_max;
 	u16 peers_snd_nxt =  msg_next_sent(hdr);
 	u16 peers_tol = msg_link_tolerance(hdr);
 	u16 peers_prio = msg_linkprio(hdr);
@@ -2238,6 +2238,9 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 	switch (mtyp) {
 	case RESET_MSG:
 	case ACTIVATE_MSG:
+		msg_max = msg_max_pkt(hdr);
+		if (msg_max < tipc_bearer_min_mtu(l->net, l->bearer_id))
+			break;
 		/* Complete own link name with peer's interface name */
 		if_name =  strrchr(l->name, ':') + 1;
 		if (sizeof(l->name) - (if_name - l->name) <= TIPC_MAX_IF_NAME)
@@ -2282,8 +2285,8 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
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
index f1c3b8eb4b3d..b34857217fde 100644
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
index abd0c4557cb9..20b8ba4d1dfc 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -92,7 +92,8 @@ int wait_on_pending_writer(struct sock *sk, long *timeo)
 			break;
 		}
 
-		if (sk_wait_event(sk, timeo, !sk->sk_write_pending, &wait))
+		if (sk_wait_event(sk, timeo,
+				  !READ_ONCE(sk->sk_write_pending), &wait))
 			break;
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a96026dbdf94..d326540e4938 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -538,7 +538,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	/* Clear state */
 	unix_state_lock(sk);
 	sock_orphan(sk);
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	path	     = u->path;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
@@ -563,7 +563,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 		if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET) {
 			unix_state_lock(skpair);
 			/* No more writes */
-			skpair->sk_shutdown = SHUTDOWN_MASK;
+			WRITE_ONCE(skpair->sk_shutdown, SHUTDOWN_MASK);
 			if (!skb_queue_empty(&sk->sk_receive_queue) || embrion)
 				skpair->sk_err = ECONNRESET;
 			unix_state_unlock(skpair);
@@ -1307,7 +1307,7 @@ static long unix_wait_for_peer(struct sock *other, long timeo)
 
 	sched = !sock_flag(other, SOCK_DEAD) &&
 		!(other->sk_shutdown & RCV_SHUTDOWN) &&
-		unix_recvq_full(other);
+		unix_recvq_full_lockless(other);
 
 	unix_state_unlock(other);
 
@@ -2894,7 +2894,7 @@ static int unix_shutdown(struct socket *sock, int mode)
 	++mode;
 
 	unix_state_lock(sk);
-	sk->sk_shutdown |= mode;
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | mode);
 	other = unix_peer(sk);
 	if (other)
 		sock_hold(other);
@@ -2914,7 +2914,7 @@ static int unix_shutdown(struct socket *sock, int mode)
 		if (mode&SEND_SHUTDOWN)
 			peer_mode |= RCV_SHUTDOWN;
 		unix_state_lock(other);
-		other->sk_shutdown |= peer_mode;
+		WRITE_ONCE(other->sk_shutdown, other->sk_shutdown | peer_mode);
 		unix_state_unlock(other);
 		other->sk_state_change(other);
 		if (peer_mode == SHUTDOWN_MASK)
@@ -3046,16 +3046,18 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
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
@@ -3089,18 +3091,20 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
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
index dc36a46ce0e7..9a65a2f19585 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1415,7 +1415,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 			vsock_transport_cancel_pkt(vsk);
 			vsock_remove_connected(vsk);
 			goto out_wait;
-		} else if (timeout == 0) {
+		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
 			err = -ETIMEDOUT;
 			sk->sk_state = TCP_CLOSE;
 			sock->state = SS_UNCONNECTED;
diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
index 694eec6ca147..1e8b26eecb3f 100644
--- a/net/xfrm/xfrm_interface.c
+++ b/net/xfrm/xfrm_interface.c
@@ -207,52 +207,6 @@ static void xfrmi_scrub_packet(struct sk_buff *skb, bool xnet)
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
@@ -820,8 +774,8 @@ static struct pernet_operations xfrmi_net_ops = {
 };
 
 static struct xfrm6_protocol xfrmi_esp6_protocol __read_mostly = {
-	.handler	=	xfrmi6_rcv,
-	.input_handler	=	xfrmi6_input,
+	.handler	=	xfrm6_rcv,
+	.input_handler	=	xfrm_input,
 	.cb_handler	=	xfrmi_rcv_cb,
 	.err_handler	=	xfrmi6_err,
 	.priority	=	10,
@@ -871,8 +825,8 @@ static struct xfrm6_tunnel xfrmi_ip6ip_handler __read_mostly = {
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
index 0540e9f72b2f..c15ef8003caa 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3636,12 +3636,6 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
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
@@ -3669,9 +3663,6 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 			goto reject;
 		}
 
-		if (if_id)
-			secpath_reset(skb);
-
 		xfrm_pols_put(pols, npols);
 		return 1;
 	}
diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index b0c18efe7928..a271099603fe 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -308,6 +308,7 @@ static int run_bpf_prog(char *prog, int cg_id)
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
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8ed66c416c0e..8ed5a499af4b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4385,6 +4385,11 @@ HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI/DP",	patch_nvhdmi),
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
index 86d07d06bd0c..ac0ccfd73f69 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9008,7 +9008,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x802f, "HP Z240", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8077, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x103c, 0x8158, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
-	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x827f, "HP x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
@@ -9121,6 +9121,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
@@ -9214,6 +9215,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x7716, "Clevo NS50PU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x7717, "Clevo NS70PU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x7718, "Clevo L140PU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x7724, "Clevo L140AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8228, "Clevo NR40BU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8520, "Clevo NH50D[CD]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8521, "Clevo NH77D[CD]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -11245,6 +11247,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x103c, 0x870c, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 38d4d1b7cfe3..acc820da46eb 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -763,7 +763,7 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to pcm register\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_micfil_component,
@@ -771,9 +771,20 @@ static int fsl_micfil_probe(struct platform_device *pdev)
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
@@ -834,6 +845,7 @@ static const struct dev_pm_ops fsl_micfil_pm_ops = {
 
 static struct platform_driver fsl_micfil_driver = {
 	.probe = fsl_micfil_probe,
+	.remove_new = fsl_micfil_remove,
 	.driver = {
 		.name = "fsl-micfil-dai",
 		.pm = &fsl_micfil_pm_ops,
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
 
