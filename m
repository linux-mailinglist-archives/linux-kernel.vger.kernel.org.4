Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95385EB9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiI0Fhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiI0Fhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:37:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1580E87
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 22:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664257056; x=1695793056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7n8/pm9p/moUSr7C8YMvou6ucbHrBBJ1XUPQ8J3bV68=;
  b=d3o1XzBMqTXAOtcgolyAlXg8S/FYcszRGZqhOE73uFAV7A2LdgU8lsdE
   cx5CpMtL/mqZaNIF2Eoa2I/x8daAMvZZinLNRDgyh9QDP626yKoe01IEg
   TghW80NNvEH1hXgeG+zT+HS8q53Gx9dLYqb6UvTzSzY1HNNj5Te9QHdxW
   eedifBFd24FWBuk4O/QPoH7vx8Jjb64vEP2eKbW6d2zt6pMQYYEHUMnJ3
   ha5jl0UdBsp1R7XjTBsInZCwj4fyMt7rpUe386g2ljzIMeOrgG4aJi0SY
   SxSWD6va8xuEM34v9ZyCRlRAtSQ/MLlSYxo5Z6CdwCweC0zQ8bbqxgigQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302706774"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="302706774"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 22:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="623633352"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="623633352"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2022 22:37:16 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/2] iommu: Add gfp parameter to iommu_alloc_resv_region
Date:   Tue, 27 Sep 2022 13:31:08 +0800
Message-Id: <20220927053109.4053662-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
References: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gfp parameter to iommu_alloc_resv_region() for the callers to specify
the memory allocation behavior. Thus iommu_alloc_resv_region() could also
be available in critical contexts.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
index b788a38d8fdf..f1964261ceca 100644
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

