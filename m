Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2BB620A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiKHHmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiKHHle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11A519C15
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893289; x=1699429289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ep5gv4HQh3IeTSkgo8d8/6BbYjkn45qw1zPvzJClMNA=;
  b=R/hb0zhBN0+NFEufgrFAC/EVhgn2pMHjijHiJ526hOoHdqbCvzoLqjez
   bjl+ZaU31Hh+ymNaZ6hPQZegfTutv37oP+mOBFoAEexbC4M/QvA9gZQXV
   VSWaTiSRPaqbYnWvZwwk7IP9B3K8t+S2zQQo1WrtJp+1zRPRFaLK4h2hv
   tGXeG9p9PQFgkdXgLAgco5sRZvPu/HEJus9Lsjg7S+9mndT7VOYCHmmYZ
   qv7jspp4E01S4McrCO0KKvad8Fhf/PcfDN2kWw0IAyjT/QefVzCGH2cB5
   pxmqLAwf+DKlhPEP2905jNVfJ1rDBP7ey3dNjphKvbQYVqxqd6gNQovla
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="309340003"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="309340003"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699821971"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699821971"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 23:41:15 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 7/8] iommu/vt-d: Remove unnecessary domain_context_mapped()
Date:   Tue,  8 Nov 2022 15:34:07 +0800
Message-Id: <20221108073408.1005721-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
References: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
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

The device_domain_info::domain accurately records the domain attached to
the device. It is unnecessary to check whether the context is present in
the attach_dev path. Remove it to make the code neat.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 47 +++----------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 88af8e4194de..f8f6092ea23c 100644
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
@@ -2136,30 +2123,6 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
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
@@ -4279,6 +4242,7 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
 	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
@@ -4287,13 +4251,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
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

