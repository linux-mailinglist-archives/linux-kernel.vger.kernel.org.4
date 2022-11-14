Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DBB627441
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiKNBsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKNBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:48:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D69ADFE8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668390482; x=1699926482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wb1pQx3gsfHkkziEvcEAu8qE9SzfW0QUG/+y6jvyTe0=;
  b=UzxnfhdICCJ6EzJgQVqF3yLtKV0KXgLWjW/tS741W6VCUKBCkoBV+LZp
   H3of70JFbDO18AMeF0J4l5xQumsoPtbCJP/ACNgI6DMkGU+lHCSIkXEzV
   94o6OZmZf7CBLnvNX9s2CSraGreVzaOem5Dg08/oigvo92OA8hHjluLVP
   r3KQGO61qeTrVY2fGuCMPjK0fZhoA+FX3sIuIHqTc5fh9UgiEmOuZLcQ0
   lKtPBZeYEd8YNq4ufPRyScggMhoF1DrgsttRQIQSb8bV7P7bH/zwx9MYq
   egrDOzniQR3LGHaCoalflQOoZd/ratVdjUskLBkaCEjGivdAj9SJQNGnv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313006699"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313006699"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 17:48:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="707124247"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="707124247"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2022 17:47:59 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 6/7] iommu/vt-d: Remove unnecessary domain_context_mapped()
Date:   Mon, 14 Nov 2022 09:40:48 +0800
Message-Id: <20221114014049.3959-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114014049.3959-1-baolu.lu@linux.intel.com>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_domain_info::domain accurately records the domain attached to
the device. It is unnecessary to check whether the context is present in
the attach_dev path. Remove it to make the code neat.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 47 +++----------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6a2a77fce0f8..83d941b792f2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -780,19 +780,6 @@ static void domain_flush_cache(struct dmar_domain *domain,
 		clflush_cache_range(addr, size);
 }
 
-static int device_context_mapped(struct intel_iommu *iommu, u8 bus, u8 devfn)
-{
-	struct context_entry *context;
-	int ret = 0;
-
-	spin_lock(&iommu->lock);
-	context = iommu_context_addr(iommu, bus, devfn, 0);
-	if (context)
-		ret = context_present(context);
-	spin_unlock(&iommu->lock);
-	return ret;
-}
-
 static void free_context_table(struct intel_iommu *iommu)
 {
 	struct context_entry *context;
@@ -2099,30 +2086,6 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 				      &domain_context_mapping_cb, &data);
 }
 
-static int domain_context_mapped_cb(struct pci_dev *pdev,
-				    u16 alias, void *opaque)
-{
-	struct intel_iommu *iommu = opaque;
-
-	return !device_context_mapped(iommu, PCI_BUS_NUM(alias), alias & 0xff);
-}
-
-static int domain_context_mapped(struct device *dev)
-{
-	struct intel_iommu *iommu;
-	u8 bus, devfn;
-
-	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
-		return -ENODEV;
-
-	if (!dev_is_pci(dev))
-		return device_context_mapped(iommu, bus, devfn);
-
-	return !pci_for_each_dma_alias(to_pci_dev(dev),
-				       domain_context_mapped_cb, iommu);
-}
-
 /* Returns a number of VTD pages, but aligned to MM page size */
 static inline unsigned long aligned_nrpages(unsigned long host_addr,
 					    size_t size)
@@ -4245,6 +4208,7 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
 	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
@@ -4253,13 +4217,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		return -EPERM;
 	}
 
-	/* normally dev is not mapped */
-	if (unlikely(domain_context_mapped(dev))) {
-		struct device_domain_info *info = dev_iommu_priv_get(dev);
-
-		if (info->domain)
-			device_block_translation(dev);
-	}
+	if (info->domain)
+		device_block_translation(dev);
 
 	ret = prepare_domain_attach_device(domain, dev);
 	if (ret)
-- 
2.34.1

