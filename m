Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A6C5B52B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 04:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiILCyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 22:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiILCyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 22:54:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA7D24F06
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 19:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662951258; x=1694487258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o9A5RBW+HGfiJnZuEp4q1NvzXtY2izQmYjW0jhImg7A=;
  b=kMjK9+r0dANAlO8a1kSL5DNw79jAdXW5397y15kQRiACnUosmTz9eOgu
   aDmpiyqdffwlTuqL9vBJqTDrY6mjDi0abl42Z/LdvK3cRJOEmM1nnzKD4
   8Q1CfPhIx8vYCAUneTUL7ub0D0/BDk1RQssYiNMtizvcwxI0oELBolDj8
   p873uWm6Sd79SO3SkWfTmw1zHZBiJ84HMkJPTl5xW7yHm1qHvgzJN7Hp5
   VFHYRYqd4eH024bUHlUjUaZFilb1dzKQsfh2DoTmCfx6pv5Ml7TEoZuGq
   2risJSsuVUR0JZcpDlPYDl+BQSEjx1Q15K+RBCe401ZgqC4FNb11HAvxI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="361726295"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="361726295"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 19:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="646278973"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 11 Sep 2022 19:54:15 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
Date:   Mon, 12 Sep 2022 10:48:26 +0800
Message-Id: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously PASID supports on both IOMMU and PCI devices are enabled in the
iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) path. It's functionally
correct as the SVA is the only feature that requires PASID setup. However,
looking ahead, we will add more features that need to enable pasid (for
example, kernel DMA with PASID, SIOV, VM guest SVA, etc.). It makes more
sense to enable PASID during iommu probing device.

This enables PASID during iommu probing device and deprecates the
intel_iommu_enable_pasid() helper. This is safe because the IOMMU hardware
will block any PCI TLP with a PASID prefix if there is no IOMMU domain
attached to the PASID of the device.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 74 +++++++------------------------------
 drivers/iommu/intel/Kconfig |  4 +-
 3 files changed, 16 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index fae45bbb0c7f..ce5f343ca864 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -737,7 +737,6 @@ extern int dmar_ir_support(void);
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
-int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7cca030a508e..69357c7c8c39 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -231,6 +231,11 @@ static inline void context_set_domain_id(struct context_entry *context,
 	context->hi |= (value & ((1 << 16) - 1)) << 8;
 }
 
+static inline void context_set_pasid(struct context_entry *context)
+{
+	context->lo |= CONTEXT_PASIDE;
+}
+
 static inline int context_domain_id(struct context_entry *c)
 {
 	return((c->hi >> 8) & 0xffff);
@@ -1341,20 +1346,17 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 }
 
 static struct device_domain_info *
-iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
-			u8 bus, u8 devfn)
+domain_lookup_dev_info(struct dmar_domain *domain,
+		       struct intel_iommu *iommu, u8 bus, u8 devfn)
 {
 	struct device_domain_info *info;
 
-	if (!iommu->qi)
-		return NULL;
-
 	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->iommu == iommu && info->bus == bus &&
 		    info->devfn == devfn) {
 			spin_unlock(&domain->lock);
-			return info->ats_supported ? info : NULL;
+			return info;
 		}
 	}
 	spin_unlock(&domain->lock);
@@ -1401,7 +1403,6 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 		info->pfsid = pci_dev_id(pf_pdev);
 	}
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
 	/* The PCIe spec, in its wisdom, declares that the behaviour of
 	   the device if you enable PASID support after ATS support is
 	   undefined. So always enable PASID support on devices which
@@ -1414,7 +1415,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
 	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
 		info->pri_enabled = 1;
-#endif
+
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
@@ -1437,16 +1438,16 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 		info->ats_enabled = 0;
 		domain_update_iotlb(info->domain);
 	}
-#ifdef CONFIG_INTEL_IOMMU_SVM
+
 	if (info->pri_enabled) {
 		pci_disable_pri(pdev);
 		info->pri_enabled = 0;
 	}
+
 	if (info->pasid_enabled) {
 		pci_disable_pasid(pdev);
 		info->pasid_enabled = 0;
 	}
-#endif
 }
 
 static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
@@ -1890,7 +1891,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 				      u8 bus, u8 devfn)
 {
 	struct device_domain_info *info =
-			iommu_support_dev_iotlb(domain, iommu, bus, devfn);
+			domain_lookup_dev_info(domain, iommu, bus, devfn);
 	u16 did = domain_id_iommu(domain, iommu);
 	int translation = CONTEXT_TT_MULTI_LEVEL;
 	struct context_entry *context;
@@ -1961,6 +1962,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			context_set_sm_dte(context);
 		if (info && info->pri_supported)
 			context_set_sm_pre(context);
+		if (info && info->pasid_supported)
+			context_set_pasid(context);
 	} else {
 		struct dma_pte *pgd = domain->pgd;
 		int agaw;
@@ -4566,52 +4569,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	list_add_tail(&reg->list, head);
 }
 
-int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct context_entry *context;
-	struct dmar_domain *domain;
-	u64 ctx_lo;
-	int ret;
-
-	domain = info->domain;
-	if (!domain)
-		return -EINVAL;
-
-	spin_lock(&iommu->lock);
-	ret = -EINVAL;
-	if (!info->pasid_supported)
-		goto out;
-
-	context = iommu_context_addr(iommu, info->bus, info->devfn, 0);
-	if (WARN_ON(!context))
-		goto out;
-
-	ctx_lo = context[0].lo;
-
-	if (!(ctx_lo & CONTEXT_PASIDE)) {
-		ctx_lo |= CONTEXT_PASIDE;
-		context[0].lo = ctx_lo;
-		wmb();
-		iommu->flush.flush_context(iommu,
-					   domain_id_iommu(domain, iommu),
-					   PCI_DEVID(info->bus, info->devfn),
-					   DMA_CCMD_MASK_NOBIT,
-					   DMA_CCMD_DEVICE_INVL);
-	}
-
-	/* Enable PASID support in the device, if it wasn't already */
-	if (!info->pasid_enabled)
-		iommu_enable_dev_iotlb(info);
-
-	ret = 0;
-
- out:
-	spin_unlock(&iommu->lock);
-
-	return ret;
-}
-
 static struct iommu_group *intel_iommu_device_group(struct device *dev)
 {
 	if (dev_is_pci(dev))
@@ -4635,9 +4592,6 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
 		return -ENODEV;
 
-	if (intel_iommu_enable_pasid(iommu, dev))
-		return -ENODEV;
-
 	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
 		return -EINVAL;
 
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 39a06d245f12..b3f40375f214 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -21,6 +21,8 @@ config INTEL_IOMMU
 	select IOASID
 	select IOMMU_DMA
 	select PCI_ATS
+	select PCI_PRI
+	select PCI_PASID
 	help
 	  DMA remapping (DMAR) devices support enables independent address
 	  translations for Direct Memory Access (DMA) from devices.
@@ -48,8 +50,6 @@ config INTEL_IOMMU_DEBUGFS
 config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
 	depends on X86_64
-	select PCI_PASID
-	select PCI_PRI
 	select MMU_NOTIFIER
 	select IOASID
 	select IOMMU_SVA
-- 
2.25.1

