Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8342963340B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiKVDls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiKVDlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:41:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B9927CE8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669088504; x=1700624504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PTzYkU4N5hBIC7qgiTBBdpFbvgItOs7Ji9ERs06HXeE=;
  b=MakYrq0FRuiQZUCPoiduYvYfqPIQYL6/fDZ1GHBnm3Y/y6KMt2oMjfxr
   eldK/vYJmQYsuggHdnQDFxDMDwOx8VpPPg9Cn3U1NHKfeIA/lM2NuXx0r
   v9TjrdTR7ttrFEEOPepCV4kYsus13AYrZCqmGw25KEN+u6647QNbutdWZ
   PYXORcqKlm8KgAxDG7jW49SZtf7mNlPJ/d4zG+RQK165TTGC/ZUUxNW7D
   Co7ndnKHBW9OGdDwJS1gGxElV10Rhl5ft14FUHzUYYzqoj+oW2TxZM11N
   /29BKz4O182XCO1KluVjLYeAtF9T2xbmrVFAHMbRgsmCmQuzo8deo7HaJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315540250"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="315540250"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 19:41:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="704810940"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="704810940"
Received: from otc-nc-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.110])
  by fmsmga008.fm.intel.com with ESMTP; 21 Nov 2022 19:41:43 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yuzhang Luo <yuzhang.luo@intel.com>
Subject: [PATCH] iommu/vt-d: Add a fix for devices need extra dtlb flush
Date:   Mon, 21 Nov 2022 19:45:29 -0800
Message-Id: <20221122034529.3311562-1-jacob.jun.pan@linux.intel.com>
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

QAT devices on Intel Sapphire Rapids and Emerald Rapids has a defect in
address translation service (ATS). These devices may inadvertently issue
ATS invalidation completion before posted writes initiated with
translated address that utilized translations matching the invalidation
address range, violating the invalidation completion ordering.

An additional device TLB invalidation is needed to ensure no more posted
writes with translated address following the invalidation completion.

Without this fix, DMA writes with translated address can happen after
device TLB invalidation is completed. Random data corruption can occur
as the DMA buffer gets reused after invalidation.

This patch adds a flag to mark the need for an extra flush based on given
device IDs, this flag is set during initialization when ATS support is
enabled.

At runtime, this flag is used to control the extra dTLB flush. The
overhead of checking this unlikely true flag is smaller than checking
PCI device IDs every time.

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
---
 drivers/iommu/intel/iommu.c | 100 +++++++++++++++++++++++++++++-------
 drivers/iommu/intel/iommu.h |   3 ++
 drivers/iommu/intel/svm.c   |   4 +-
 3 files changed, 87 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 996a8b5ee5ee..6254788330b8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1396,6 +1396,39 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
+/*
+ * Check that the device does not live on an external facing PCI port that is
+ * marked as untrusted. Such devices should not be able to apply quirks and
+ * thus not be able to bypass the IOMMU restrictions.
+ */
+static bool risky_device(struct pci_dev *pdev)
+{
+	if (pdev->untrusted) {
+		pci_info(pdev,
+			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
+			 pdev->vendor, pdev->device);
+		pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");
+		return true;
+	}
+	return false;
+}
+
+/* Impacted QAT device IDs ranging from 0x4940 to 0x4943 */
+#define BUGGY_QAT_DEVID_MASK 0x494c
+static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
+{
+	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
+		return false;
+
+	if ((pdev->device & 0xfffc) != BUGGY_QAT_DEVID_MASK)
+		return false;
+
+	if (risky_device(pdev))
+		return false;
+
+	return true;
+}
+
 static void iommu_enable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
@@ -1478,6 +1511,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 	qdep = info->ats_qdep;
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 			   qdep, addr, mask);
+	quirk_dev_tlb(info, addr, mask, PASID_RID2PASID, qdep);
 }
 
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
@@ -4490,9 +4524,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
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
@@ -4680,23 +4715,6 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
 	return translation_pre_enabled(info->iommu) && !info->domain;
 }
 
-/*
- * Check that the device does not live on an external facing PCI port that is
- * marked as untrusted. Such devices should not be able to apply quirks and
- * thus not be able to bypass the IOMMU restrictions.
- */
-static bool risky_device(struct pci_dev *pdev)
-{
-	if (pdev->untrusted) {
-		pci_info(pdev,
-			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
-			 pdev->vendor, pdev->device);
-		pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");
-		return true;
-	}
-	return false;
-}
-
 static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				       unsigned long iova, size_t size)
 {
@@ -4931,3 +4949,47 @@ static void __init check_tylersburg_isoch(void)
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

