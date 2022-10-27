Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636D060F342
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiJ0JKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiJ0JKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D511D326
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC4F262240
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3DEC433D6;
        Thu, 27 Oct 2022 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861815;
        bh=v5nxiY4I8yxea4BPZ1V36MIq3Ss/7dC0lP06N7ysZtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqudOp8GfKFqE/ZT9UeMZz8CN5Us/af+7iNJbRCpDOOZaqoIeV/cPD+RGpYe5IhG+
         KVu4PxbHdB/MhQ9TGXfgmL1WAnbkufBAwIBscmnBmH99yQ9XbD8oksF4pkD8xECn6b
         2rfK/TDE3VVRdvgD7DjGYwl8jkZoVoqdv7qwlRBjY/s6dcEUy205uQAkrBzt9aFjet
         CC6c60I5Afk2F4MXjqAb5wOhyrP4v9uSmxUvGZm638JeGXla4zSJ+ahJFivkQiU9LN
         DEQOBBlgT/jS2vleIteDaJFtPm0M/8F/ix6PCMvJ2Cj/7ZRrqKKxrVrSGT/VgTm9FN
         jQTXmC+Fc96VQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 02/15] habanalabs: allow setting HBM BAR to other regions
Date:   Thu, 27 Oct 2022 12:09:54 +0300
Message-Id: <20221027091007.664797-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027091007.664797-1-ogabbay@kernel.org>
References: <20221027091007.664797-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Up until now the use-case in the driver was that the HBM is accessed
using the HBM BAR, yet the BAR sometimes cannot cover the whole HBM and
so we needed to set the BAR to other HBM offset.
Now we are facing the need to access other PCI memory regions that can
be covered by the HBM BAR.
To answer that we are allowing the caller to determine if the HBM BAR
need to be set or not regardless of the PCI memory region.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 29 ++++++++++++---------
 drivers/misc/habanalabs/common/habanalabs.h |  2 ++
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index dd01be5c4ba3..0026fe42b3d2 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -32,6 +32,7 @@ enum dma_alloc_type {
  * @hdev: pointer to habanalabs device structure.
  * @addr: the address the caller wants to access.
  * @region: the PCI region.
+ * @new_bar_region_base: the new BAR region base address.
  *
  * @return: the old BAR base address on success, U64_MAX for failure.
  *	    The caller should set it back to the old address after use.
@@ -41,7 +42,8 @@ enum dma_alloc_type {
  * This function can be called also if the bar doesn't need to be set,
  * in that case it just won't change the base.
  */
-static u64 hl_set_dram_bar(struct hl_device *hdev, u64 addr, struct pci_mem_region *region)
+static u64 hl_set_dram_bar(struct hl_device *hdev, u64 addr, struct pci_mem_region *region,
+				u64 *new_bar_region_base)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64 bar_base_addr, old_base;
@@ -55,27 +57,28 @@ static u64 hl_set_dram_bar(struct hl_device *hdev, u64 addr, struct pci_mem_regi
 	old_base = hdev->asic_funcs->set_dram_bar_base(hdev, bar_base_addr);
 
 	/* in case of success we need to update the new BAR base */
-	if (old_base != U64_MAX)
-		region->region_base = bar_base_addr;
+	if ((old_base != U64_MAX) && new_bar_region_base)
+		*new_bar_region_base = bar_base_addr;
 
 	return old_base;
 }
 
-static int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val,
-	enum debugfs_access_type acc_type, enum pci_region region_type)
+int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val,
+	enum debugfs_access_type acc_type, enum pci_region region_type, bool set_dram_bar)
 {
 	struct pci_mem_region *region = &hdev->pci_mem_region[region_type];
+	u64 old_base = 0, rc, new_bar_region_base = 0;
 	void __iomem *acc_addr;
-	u64 old_base = 0, rc;
 
-	if (region_type == PCI_REGION_DRAM) {
-		old_base = hl_set_dram_bar(hdev, addr, region);
+	if (set_dram_bar) {
+		old_base = hl_set_dram_bar(hdev, addr, region, &new_bar_region_base);
 		if (old_base == U64_MAX)
 			return -EIO;
 	}
 
-	acc_addr = hdev->pcie_bar[region->bar_id] + addr - region->region_base +
-			region->offset_in_bar;
+	acc_addr = hdev->pcie_bar[region->bar_id] + region->offset_in_bar +
+			(addr - new_bar_region_base);
+
 	switch (acc_type) {
 	case DEBUGFS_READ8:
 		*val = readb(acc_addr);
@@ -97,8 +100,8 @@ static int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val
 		break;
 	}
 
-	if (region_type == PCI_REGION_DRAM) {
-		rc = hl_set_dram_bar(hdev, old_base, region);
+	if (set_dram_bar) {
+		rc = hl_set_dram_bar(hdev, old_base, region, NULL);
 		if (rc == U64_MAX)
 			return -EIO;
 	}
@@ -283,7 +286,7 @@ int hl_access_dev_mem(struct hl_device *hdev, enum pci_region region_type,
 	case PCI_REGION_SRAM:
 	case PCI_REGION_DRAM:
 		return hl_access_sram_dram_region(hdev, addr, val, acc_type,
-			region_type);
+				region_type, (region_type == PCI_REGION_DRAM));
 	default:
 		return -EFAULT;
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 4913197c433e..c8347eac09ed 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3486,6 +3486,8 @@ void hl_asic_dma_pool_free_caller(struct hl_device *hdev, void *vaddr, dma_addr_
 int hl_dma_map_sgtable(struct hl_device *hdev, struct sg_table *sgt, enum dma_data_direction dir);
 void hl_dma_unmap_sgtable(struct hl_device *hdev, struct sg_table *sgt,
 				enum dma_data_direction dir);
+int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val,
+	enum debugfs_access_type acc_type, enum pci_region region_type, bool set_dram_bar);
 int hl_access_cfg_region(struct hl_device *hdev, u64 addr, u64 *val,
 	enum debugfs_access_type acc_type);
 int hl_access_dev_mem(struct hl_device *hdev, enum pci_region region_type,
-- 
2.25.1

