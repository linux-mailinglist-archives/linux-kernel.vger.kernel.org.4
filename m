Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB360373D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJSAvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJSAvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:51:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D21AE85E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666140677; x=1697676677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O8SgalDcLyJd4IbAX0q7EC2IARrdcdPwcMMNK5wsxVo=;
  b=XpcBbEzO5P9azqdvltzWIjDBq7vICw9VnXT77srHFjIgU1g0mB9LGGcw
   lwVdpiDBrJARfGkn08kUSOcXsgeIbMYlAeKNXmABdsunLtYyBorNbHYP3
   9S4x8AsgqwJ0ndbB9FdrIh1gQJho1rtoRLs6yfdW31mYpTETzktUuGL+P
   q031MCPIb1RfDDUIopEbVQG7+7Rbugn2jU5F20ghvtA8lUl4ckGKQH9uG
   p933onAyjNN5T+yxOg4+304yvXi1IFiFZ/QZfn40gy8pdh8kxN/xiYQxu
   kmtpgALRctC5Ku3EtAe4b173y5f3DUVVL2PtlVJ3QapWc4/RQFSudAs2k
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="289591509"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="289591509"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="606824801"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="606824801"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2022 17:51:15 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Charlotte Tan <charlotte@extrahop.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu: Add gfp parameter to iommu_alloc_resv_region
Date:   Wed, 19 Oct 2022 08:44:44 +0800
Message-Id: <20221019004447.4563-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019004447.4563-1-baolu.lu@linux.intel.com>
References: <20221019004447.4563-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gfp parameter to iommu_alloc_resv_region() for the callers to specify
the memory allocation behavior. Thus iommu_alloc_resv_region() could also
be available in critical contexts.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20220927053109.4053662-2-baolu.lu@linux.intel.com
---
 include/linux/iommu.h                       | 2 +-
 drivers/acpi/arm64/iort.c                   | 3 ++-
 drivers/iommu/amd/iommu.c                   | 7 ++++---
 drivers/iommu/apple-dart.c                  | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 2 +-
 drivers/iommu/intel/iommu.c                 | 8 +++++---
 drivers/iommu/iommu.c                       | 7 ++++---
 drivers/iommu/mtk_iommu.c                   | 3 ++-
 drivers/iommu/virtio-iommu.c                | 9 ++++++---
 10 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a325532aeab5..3c9da1f8979e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -455,7 +455,7 @@ extern void iommu_set_default_translated(bool cmd_line);
 extern bool iommu_default_passthrough(void);
 extern struct iommu_resv_region *
 iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
-			enum iommu_resv_type type);
+			enum iommu_resv_type type, gfp_t gfp);
 extern int iommu_get_group_resv_regions(struct iommu_group *group,
 					struct list_head *head);
 
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ca2aed86b540..8059baf4ef27 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1142,7 +1142,8 @@ static void iort_iommu_msi_get_resv_regions(struct device *dev,
 			struct iommu_resv_region *region;
 
 			region = iommu_alloc_resv_region(base + SZ_64K, SZ_64K,
-							 prot, IOMMU_RESV_MSI);
+							 prot, IOMMU_RESV_MSI,
+							 GFP_KERNEL);
 			if (region)
 				list_add_tail(&region->list, head);
 		}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 65856e401949..d3b39d0416fa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2330,7 +2330,8 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 			type = IOMMU_RESV_RESERVED;
 
 		region = iommu_alloc_resv_region(entry->address_start,
-						 length, prot, type);
+						 length, prot, type,
+						 GFP_KERNEL);
 		if (!region) {
 			dev_err(dev, "Out of memory allocating dm-regions\n");
 			return;
@@ -2340,14 +2341,14 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 
 	region = iommu_alloc_resv_region(MSI_RANGE_START,
 					 MSI_RANGE_END - MSI_RANGE_START + 1,
-					 0, IOMMU_RESV_MSI);
+					 0, IOMMU_RESV_MSI, GFP_KERNEL);
 	if (!region)
 		return;
 	list_add_tail(&region->list, head);
 
 	region = iommu_alloc_resv_region(HT_RANGE_START,
 					 HT_RANGE_END - HT_RANGE_START + 1,
-					 0, IOMMU_RESV_RESERVED);
+					 0, IOMMU_RESV_RESERVED, GFP_KERNEL);
 	if (!region)
 		return;
 	list_add_tail(&region->list, head);
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 4526575b999e..4f4a323be0d0 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -758,7 +758,7 @@ static void apple_dart_get_resv_regions(struct device *dev,
 
 		region = iommu_alloc_resv_region(DOORBELL_ADDR,
 						 PAGE_SIZE, prot,
-						 IOMMU_RESV_MSI);
+						 IOMMU_RESV_MSI, GFP_KERNEL);
 		if (!region)
 			return;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ba47c73f5b8c..6d5df91c5c46 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2757,7 +2757,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI);
+					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
 	if (!region)
 		return;
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6c1114a4d6cc..30dab1418e3f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1534,7 +1534,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI);
+					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
 	if (!region)
 		return;
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a8b36c3fddf1..d5965b4f8b60 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4552,7 +4552,8 @@ static void intel_iommu_get_resv_regions(struct device *device,
 				IOMMU_RESV_DIRECT_RELAXABLE : IOMMU_RESV_DIRECT;
 
 			resv = iommu_alloc_resv_region(rmrr->base_address,
-						       length, prot, type);
+						       length, prot, type,
+						       GFP_KERNEL);
 			if (!resv)
 				break;
 
@@ -4567,7 +4568,8 @@ static void intel_iommu_get_resv_regions(struct device *device,
 
 		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
 			reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
-						   IOMMU_RESV_DIRECT_RELAXABLE);
+					IOMMU_RESV_DIRECT_RELAXABLE,
+					GFP_KERNEL);
 			if (reg)
 				list_add_tail(&reg->list, head);
 		}
@@ -4576,7 +4578,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 
 	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
 				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
-				      0, IOMMU_RESV_MSI);
+				      0, IOMMU_RESV_MSI, GFP_KERNEL);
 	if (!reg)
 		return;
 	list_add_tail(&reg->list, head);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4893c2429ca5..65a3b3d886dc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -504,7 +504,7 @@ static int iommu_insert_resv_region(struct iommu_resv_region *new,
 	LIST_HEAD(stack);
 
 	nr = iommu_alloc_resv_region(new->start, new->length,
-				     new->prot, new->type);
+				     new->prot, new->type, GFP_KERNEL);
 	if (!nr)
 		return -ENOMEM;
 
@@ -2579,11 +2579,12 @@ EXPORT_SYMBOL(iommu_put_resv_regions);
 
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 						  size_t length, int prot,
-						  enum iommu_resv_type type)
+						  enum iommu_resv_type type,
+						  gfp_t gfp)
 {
 	struct iommu_resv_region *region;
 
-	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	region = kzalloc(sizeof(*region), gfp);
 	if (!region)
 		return NULL;
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5a4e00e4bbbc..2ab2ecfe01f8 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -917,7 +917,8 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
 			continue;
 
 		region = iommu_alloc_resv_region(resv->iova_base, resv->size,
-						 prot, IOMMU_RESV_RESERVED);
+						 prot, IOMMU_RESV_RESERVED,
+						 GFP_KERNEL);
 		if (!region)
 			return;
 
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index b7c22802f57c..8b1b5c270e50 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -490,11 +490,13 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 		fallthrough;
 	case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
 		region = iommu_alloc_resv_region(start, size, 0,
-						 IOMMU_RESV_RESERVED);
+						 IOMMU_RESV_RESERVED,
+						 GFP_KERNEL);
 		break;
 	case VIRTIO_IOMMU_RESV_MEM_T_MSI:
 		region = iommu_alloc_resv_region(start, size, prot,
-						 IOMMU_RESV_MSI);
+						 IOMMU_RESV_MSI,
+						 GFP_KERNEL);
 		break;
 	}
 	if (!region)
@@ -909,7 +911,8 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 	 */
 	if (!msi) {
 		msi = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					      prot, IOMMU_RESV_SW_MSI);
+					      prot, IOMMU_RESV_SW_MSI,
+					      GFP_KERNEL);
 		if (!msi)
 			return;
 
-- 
2.34.1

