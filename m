Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FDB5B96F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIOJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIOJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:04:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E298751
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663232647; x=1694768647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9M27XnR5jj/g8J/Y6Lm5NfNMQ64DQGoHMfvzYu/z+HI=;
  b=Q1/968+IdxtK6qJZzxmos+WxOwf2sM7dP0rkGS48t4mngKXNAR/+THZl
   VYK86Y0KmHfIx3Hmfc+PRozhBpa3V1qFSNojrWQ/NniiHrxWG4jzT/YHI
   ElDwYXLRc+9biPTft1Yrgr/0FjJRfXYfA22Jbl/S/LpXAqseNDq8TCXUU
   Zgu6exIhAp4nT3psqcJzkKvoFXjv2OTG/302dFSLOn99kQxnqF1Afb0tH
   1v3k8pmttIy7oT2zGvGv+W4mGj/FlVSekteglleOvamkIqkQZhjeKbqM6
   yCXac9CxfikzblNLasUMmx1GDrrPH8uaEP/6KCnTXCjNWisQkTfPCOaZl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324920221"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="324920221"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 02:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="720914303"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga002.fm.intel.com with ESMTP; 15 Sep 2022 02:04:05 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Decouple PASID & PRI enabling from SVA
Date:   Thu, 15 Sep 2022 16:58:14 +0800
Message-Id: <20220915085814.2261409-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the PCI PASID and PRI capabilities are enabled in the path of
iommu device probe only if INTEL_IOMMU_SVM is configured and the device
supports ATS. As we've already decoupled the I/O page fault handler from
SVA, we could also decouple PASID and PRI enabling from it to make room
for growth of new features like kernel DMA with PASID, SIOV and nested
translation.

At the same time, the iommu_enable_dev_iotlb() helper is also called in
iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) path. It's unnecessary
and duplicate. This cleanups this helper to make the code neat.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 78 ++++++++-----------------------------
 drivers/iommu/intel/Kconfig |  5 +--
 3 files changed, 18 insertions(+), 66 deletions(-)

Changelog:
v2:
 - Rephrase the commit message to make it accurate.
 - Rename iommu_enable_dev_iotlb().

v1: https://lore.kernel.org/linux-iommu/20220912024826.1684913-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 352f05e92f6f..b11069a71640 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -740,7 +740,6 @@ extern int dmar_ir_support(void);
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
-int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 18a75c74c38c..7fb91ab27311 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -199,6 +199,11 @@ static inline void context_set_domain_id(struct context_entry *context,
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
@@ -1350,21 +1355,18 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 }
 
 static struct device_domain_info *
-iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
-			u8 bus, u8 devfn)
+domain_lookup_dev_info(struct dmar_domain *domain,
+		       struct intel_iommu *iommu, u8 bus, u8 devfn)
 {
 	struct device_domain_info *info;
 	unsigned long flags;
 
-	if (!iommu->qi)
-		return NULL;
-
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->iommu == iommu && info->bus == bus &&
 		    info->devfn == devfn) {
 			spin_unlock_irqrestore(&domain->lock, flags);
-			return info->ats_supported ? info : NULL;
+			return info;
 		}
 	}
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -1389,7 +1391,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
-static void iommu_enable_dev_iotlb(struct device_domain_info *info)
+static void iommu_enable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
@@ -1412,7 +1414,6 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 		info->pfsid = pci_dev_id(pf_pdev);
 	}
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
 	/* The PCIe spec, in its wisdom, declares that the behaviour of
 	   the device if you enable PASID support after ATS support is
 	   undefined. So always enable PASID support on devices which
@@ -1425,7 +1426,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
 	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
 		info->pri_enabled = 1;
-#endif
+
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
@@ -1448,16 +1449,16 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
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
@@ -1907,7 +1908,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 				      u8 bus, u8 devfn)
 {
 	struct device_domain_info *info =
-			iommu_support_dev_iotlb(domain, iommu, bus, devfn);
+			domain_lookup_dev_info(domain, iommu, bus, devfn);
 	u16 did = domain_id_iommu(domain, iommu);
 	int translation = CONTEXT_TT_MULTI_LEVEL;
 	struct context_entry *context;
@@ -1980,6 +1981,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			context_set_sm_dte(context);
 		if (info && info->pri_supported)
 			context_set_sm_pre(context);
+		if (info && info->pasid_supported)
+			context_set_pasid(context);
 	} else {
 		struct dma_pte *pgd = domain->pgd;
 		int agaw;
@@ -2037,7 +2040,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
-	iommu_enable_dev_iotlb(info);
+	iommu_enable_pci_caps(info);
 
 	ret = 0;
 
@@ -4551,52 +4554,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
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
@@ -4620,9 +4577,6 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
 		return -ENODEV;
 
-	if (intel_iommu_enable_pasid(iommu, dev))
-		return -ENODEV;
-
 	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
 		return -EINVAL;
 
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index c48005147ac5..b7dff5092fd2 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -20,6 +20,8 @@ config INTEL_IOMMU
 	select SWIOTLB
 	select IOASID
 	select PCI_ATS
+	select PCI_PRI
+	select PCI_PASID
 	help
 	  DMA remapping (DMAR) devices support enables independent address
 	  translations for Direct Memory Access (DMA) from devices.
@@ -47,10 +49,7 @@ config INTEL_IOMMU_DEBUGFS
 config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
 	depends on X86_64
-	select PCI_PASID
-	select PCI_PRI
 	select MMU_NOTIFIER
-	select IOASID
 	select IOMMU_SVA
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
-- 
2.34.1

