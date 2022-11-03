Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B7A617681
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKCGA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiKCGAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:00:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAF4192B8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667455229; x=1698991229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QiRpo85cqFxjJ5iqjYeKDVL1Wbqll0BYbdczDs6g2tI=;
  b=LQI0xOI9afimDO727BrC7yvR9N/5/2QRDC2f6dIgF92DUuTcgidqPZMD
   N2jnwFjmgso5U/9n5eX0EmYtnSncZWXiErH3Ys+L4lDAm4Q6ZqmaDL4EA
   25LFmu4XqrPZ/FL31LHMWXidPWiUUoAbsPcICzmrqcvNYGSfWDh4f+bFK
   SSNrRUImv/6bM7uTzDexaLwaiJs5hD6Q6kExvc3CZMVWFCndX3snZ5zKy
   rX37FUxaDqVaqyn6rSzt6OHqzJvmR2lxVQ7cDj1T0Vk8A5SL/Fzf8Xvdv
   4Su6zIdCVbo+Tm0DDVCMn3jpi0SxG4c3XdNhz3e855iiIW9bWRzgH2kRv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="311322528"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="311322528"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 23:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723819324"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723819324"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 23:00:26 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 6/7] iommu/vt-d: Remove unnecessary domain_context_mapped()
Date:   Thu,  3 Nov 2022 13:53:28 +0800
Message-Id: <20221103055329.633052-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103055329.633052-1-baolu.lu@linux.intel.com>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_domain_info::domain accurately records the domain attached to
the device. It is unnecessary to check whether the context is present in
the attach_dev path. Remove it to make the code neat.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 47 +++----------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6ec5dd4e461b..5c7a574fad38 100644
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
@@ -2100,30 +2087,6 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
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
@@ -4247,6 +4210,7 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
 	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
@@ -4255,13 +4219,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
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

