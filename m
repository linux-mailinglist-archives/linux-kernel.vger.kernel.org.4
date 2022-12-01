Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E4863E8C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLAEI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiLAEIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:08:52 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1EE8EE7E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669867730; x=1701403730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u5/DKb3gXHXITPU9e9Cfgq1VlJoRaQkY34dpdDM/E2k=;
  b=OXUsdtJzIyyUGu7fOwlNL555smAqVs3idlfHbZmXb/ZAZZkNq9G2thhL
   n8LDueeYliosq1TaiTKLEIv2DE5RjEWg4vVXdoACSwaxJlGmdxuXTt1Ei
   Ajxio0n0KPx2SaLUzXFfCbrtd4ctZpPMFf5X5ICFRkt4Cq9CCQY2AtKcu
   SEJN0gHf2PtOYm0cdl55HbNTkboao0aIMMuWMNxHzfsO5Xmbt4tPFT/2s
   NfyqSA60xf8+vv/PxWGr7R2lSsuZS3TcrQYU+4pFDwM2WQq0Pl+AEE4nw
   V8nnBWHQH1UswlXR2Yftb8zerUus/5xuCCLSYG7Ke+4//h2zSSB3V1D93
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377745729"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="377745729"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707911655"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="707911655"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 20:08:43 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/vt-d: Add a fix for devices need extra dtlb flush
Date:   Thu,  1 Dec 2022 12:01:24 +0800
Message-Id: <20221201040127.1962750-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
References: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

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
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lore.kernel.org/r/20221130062449.1360063-1-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  4 +++
 drivers/iommu/intel/iommu.c | 69 +++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/svm.c   |  5 ++-
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 92023dff9513..db9df7c3790c 100644
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
@@ -728,6 +729,9 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			      u32 pasid, u16 qdep, u64 addr,
 			      unsigned int size_order);
+void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
+			       unsigned long address, unsigned long pages,
+			       u32 pasid, u16 qdep);
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 			  u32 pasid);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 996a8b5ee5ee..587eebe39820 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1396,6 +1396,24 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
+/*
+ * The extra devTLB flush quirk impacts those QAT devices with PCI device
+ * IDs ranging from 0x4940 to 0x4943. It is exempted from risky_device()
+ * check because it applies only to the built-in QAT devices and it doesn't
+ * grant additional privileges.
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
@@ -1478,6 +1496,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 	qdep = info->ats_qdep;
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 			   qdep, addr, mask);
+	quirk_extra_dev_tlb_flush(info, addr, mask, PASID_RID2PASID, qdep);
 }
 
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
@@ -4490,9 +4509,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
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
@@ -4931,3 +4951,48 @@ static void __init check_tylersburg_isoch(void)
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
+void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
+			       unsigned long address, unsigned long mask,
+			       u32 pasid, u16 qdep)
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
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7d08eb034f2d..fe615c53479c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -184,10 +184,13 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
 		return;
 
 	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
-	if (info->ats_enabled)
+	if (info->ats_enabled) {
 		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
 					 svm->pasid, sdev->qdep, address,
 					 order_base_2(pages));
+		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
+					  svm->pasid, sdev->qdep);
+	}
 }
 
 static void intel_flush_svm_range_dev(struct intel_svm *svm,
-- 
2.34.1

