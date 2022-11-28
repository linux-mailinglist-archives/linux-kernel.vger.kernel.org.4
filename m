Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD8963AE45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiK1RBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiK1RAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:00:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD8A22BEE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669654839; x=1701190839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t8Bjbd/FJV0b3wHt4FA0sTYYiLYmpYfnvwHrv8Z/kaw=;
  b=ffpSQa/rs0+Mve5HGc1fRq2RTDl4l+Yk2aKOgvDaYjolrm2LsCF4fs9V
   PWI2V2UMlfLqes0ab3nt0yOOxcmz00H8/ZQrpzEr384A8tDyh1c2bDz7F
   nbGJOlezeUErDWUqeMuwqBXYJb3q05t/DTe8bmRTrYHE/3pQEGxH7umzv
   SSKPs+pwdjQC5Pqpn6AxOnqdQL4kOqMQqBPGIqOyQUkJdv54V2BPQokmP
   LVFhBma02MMl0D6lgabA1Srbvawa2jPQ/KsQRNS+K2QHA7vbi1gn5/4+n
   s75LuyzvEqCvHehIu7l6pepi+bb1V8sQbIX76075JKqlc0+5cnsZwsYyS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316722269"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="316722269"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="768108880"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="768108880"
Received: from otc-nc-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.110])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2022 09:00:23 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yuzhang Luo <yuzhang.luo@intel.com>
Subject: [PATCH v2] iommu/vt-d: Add a fix for devices need extra dtlb flush
Date:   Mon, 28 Nov 2022 09:04:10 -0800
Message-Id: <20221128170410.3830605-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QAT devices on Intel Sapphire Rapids and Emerald Rapids have a defect in
address translation service (ATS). These devices may inadvertently issue
ATS invalidation completion before posted writes initiated with
translated address that utilized translations matching the invalidation
address range, violating the invalidation completion ordering.

This patch adds an extra device TLB invalidation for the affected devices,
it is needed to ensure no more posted writes with translated address
following the invalidation completion. Therefore, the ordering is
preserved and data-corruption is prevented.

Device TLBs are invalidated under the following six conditions:
1. Device driver does DMA API unmap IOVA
2. Device driver unbind a PASID from a process, sva_unbind_device()
3. PASID is torn down, after PASID cache is flushed. e.g. process
exit_mmap() due to crash
4. Under SVA usage, called by mmu_notifier.invalidate_range() where
VM has to free pages that were unmapped
5. userspace driver unmaps a DMA buffer
6. Cache invalidation in vSVA usage (upcoming)

For #1 and #2, device drivers are responsible for stopping DMA traffic
before unmap/unbind. For #3, iommu driver gets mmu_notifier to
invalidate TLB the same way as normal user unmap which will do an extra
invalidation. The dTLB invalidation after PASID cache flush does not
need an extra invalidation.

Therefore, we only need to deal with #4 and #5 in this patch. #1 is also
covered by this patch due to common code path with #5.

Tested-by: Yuzhang Luo <yuzhang.luo@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
v2
- removed risky_device() check based on the review by Robin, added comments
  to explain the exemption.
- reworked commit message based on the review from Ashok
---
 drivers/iommu/intel/iommu.c | 67 +++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/iommu.h |  3 ++
 drivers/iommu/intel/svm.c   |  4 ++-
 3 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 996a8b5ee5ee..a97e9247037f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1396,6 +1396,23 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
+/*
+ * Impacted QAT device IDs ranging from 0x4940 to 0x4943.
+ * This quirk is exempted from risky_device() check because it applies only
+ * to the built-in QAT devices.
+ */
+#define BUGGY_QAT_DEVID_MASK 0x494c
+static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
+{
+	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
+		return false;
+
+	if ((pdev->device & 0xfffc) != BUGGY_QAT_DEVID_MASK)
+		return false;
+
+	return true;
+}
+
 static void iommu_enable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
@@ -1478,6 +1495,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 	qdep = info->ats_qdep;
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 			   qdep, addr, mask);
+	quirk_dev_tlb(info, addr, mask, PASID_RID2PASID, qdep);
 }
 
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
@@ -4490,9 +4508,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	if (dev_is_pci(dev)) {
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
-		    dmar_ats_supported(pdev, iommu))
+		    dmar_ats_supported(pdev, iommu)) {
 			info->ats_supported = 1;
-
+			info->dtlb_extra_inval = dev_needs_extra_dtlb_flush(pdev);
+		}
 		if (sm_supported(iommu)) {
 			if (pasid_supported(iommu)) {
 				int features = pci_pasid_features(pdev);
@@ -4931,3 +4950,47 @@ static void __init check_tylersburg_isoch(void)
 	pr_warn("Recommended TLB entries for ISOCH unit is 16; your BIOS set %d\n",
 	       vtisochctrl);
 }
+
+/*
+ * Here we deal with a device TLB defect where device may inadvertently issue ATS
+ * invalidation completion before posted writes initiated with translated address
+ * that utilized translations matching the invalidation address range, violating
+ * the invalidation completion ordering.
+ * Therefore, any use cases that cannot guarantee DMA is stopped before unmap is
+ * vulnerable to this defect. In other words, any dTLB invalidation initiated not
+ * under the control of the trusted/privileged host device driver must use this
+ * quirk.
+ * Device TLBs are invalidated under the following six conditions:
+ * 1. Device driver does DMA API unmap IOVA
+ * 2. Device driver unbind a PASID from a process, sva_unbind_device()
+ * 3. PASID is torn down, after PASID cache is flushed. e.g. process
+ *    exit_mmap() due to crash
+ * 4. Under SVA usage, called by mmu_notifier.invalidate_range() where
+ *    VM has to free pages that were unmapped
+ * 5. Userspace driver unmaps a DMA buffer
+ * 6. Cache invalidation in vSVA usage (upcoming)
+ *
+ * For #1 and #2, device drivers are responsible for stopping DMA traffic
+ * before unmap/unbind. For #3, iommu driver gets mmu_notifier to
+ * invalidate TLB the same way as normal user unmap which will use this quirk.
+ * The dTLB invalidation after PASID cache flush does not need this quirk.
+ *
+ * As a reminder, #6 will *NEED* this quirk as we enable nested translation.
+ */
+void quirk_dev_tlb(struct device_domain_info *info, unsigned long address,
+		   unsigned long mask, u32 pasid, u16 qdep)
+{
+	u16 sid;
+
+	if (likely(!info->dtlb_extra_inval))
+		return;
+
+	sid = PCI_DEVID(info->bus, info->devfn);
+	if (pasid == PASID_RID2PASID) {
+		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
+				   qdep, address, mask);
+	} else {
+		qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
+					 pasid, qdep, address, mask);
+	}
+}
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 92023dff9513..09b989bf545f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -623,6 +623,7 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
+	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
 	u8 ats_qdep;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
@@ -728,6 +729,8 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			      u32 pasid, u16 qdep, u64 addr,
 			      unsigned int size_order);
+void quirk_dev_tlb(struct device_domain_info *info, unsigned long address,
+		   unsigned long pages, u32 pasid, u16 qdep);
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 			  u32 pasid);
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7d08eb034f2d..117430b97ba9 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -184,10 +184,12 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
 		return;
 
 	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
-	if (info->ats_enabled)
+	if (info->ats_enabled) {
 		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
 					 svm->pasid, sdev->qdep, address,
 					 order_base_2(pages));
+		quirk_dev_tlb(info, address, order_base_2(pages), svm->pasid, sdev->qdep);
+	}
 }
 
 static void intel_flush_svm_range_dev(struct intel_svm *svm,
-- 
2.25.1

