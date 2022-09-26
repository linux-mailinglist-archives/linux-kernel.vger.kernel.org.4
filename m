Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4336E5EA938
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiIZOzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiIZOyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:54:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6670B93784
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664198495; x=1695734495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sdksnCzyeOLKr/bm2XXYYY4lKlJEMlbXE8c0TLgwxP4=;
  b=gC1gF+WDhCjQTJn4GS1sHvKgXv66W7iGb5Bat8NO6pETlDm47QKkpF8+
   fm3r84Pel1RtUH4r5Upqij8EpmYEGmMeskdcP2FOBZ9x97r7mkjjdx5z9
   /5jZnjEE9NPTP6l66oi4BtXLRB7d/r4S7USvYakAEYxKEfBxfAs6BhidH
   NLRsvBUytUqsW2B7QglhIsfRANH862fuRzDyrjG94UQkPHQVUcXgX1cfo
   fvqtANB4SyXKvBI/fEv5oCqXZKhtIbPapXZ8g6f5LwJbupmG6ydI141SI
   Ej6UlSvu1KSGTs+7UNfqTgO7Hlg4q6prw4T1CDp+5Z9F0PdZxBJfUJnp8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280750290"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="280750290"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="683525654"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="683525654"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2022 06:21:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] iommu/vt-d: Decouple PASID & PRI enabling from SVA
Date:   Mon, 26 Sep 2022 21:15:25 +0800
Message-Id: <20220926131529.4045281-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
References: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220915085814.2261409-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 78 ++++++++-----------------------------
 drivers/iommu/intel/Kconfig |  5 +--
 3 files changed, 18 insertions(+), 66 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b5fb7706e97c..8f29a183467d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -742,7 +742,6 @@ extern int dmar_ir_support(void);
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
-int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 31bc50e538a3..af17177b6d76 100644
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
 
@@ -4574,52 +4577,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
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
@@ -4643,9 +4600,6 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
 		return -ENODEV;
 
-	if (intel_iommu_enable_pasid(iommu, dev))
-		return -ENODEV;
-
 	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
 		return -EINVAL;
 
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 39a06d245f12..cd0ec7ed48b6 100644
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
@@ -48,10 +50,7 @@ config INTEL_IOMMU_DEBUGFS
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

