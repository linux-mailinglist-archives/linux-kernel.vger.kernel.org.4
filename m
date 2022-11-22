Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408BA63316B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiKVAhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiKVAhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:37:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27FEC6D15
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669077422; x=1700613422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Jv3x8HF8iyBg2+XPw8GVEDuKMcTJ8Vysh0iMn4ChJY=;
  b=dwnwGxOFmxx3aKYg/cEXly0Vto3tnJglsizbdg1S9i2tP7jsGEk1N6ak
   aR8a3gCBZt7i15/y0v/v/VAuKO+mjQhSQdmZz6xMqIWSaFL2WVno24C8F
   02epWQXK0DYhlJsst5W2CZG/CnCckQFcp06qsg+zv1dx2aEHE5utBo164
   89LUaeGdIqAl1lVIkEF/sdFzkCKkPwHUcLveGsr/erxbiuMW+5SQAkd8Z
   xoIKUJWYwJ7OL/1IUOXxgpdJKee0Bi8Akd9IP3quPmZpJyVOCPQcsvjep
   l0pRycsBsS57SuvFhJgsqS8Qh5LG3dwbnu/4BSRXa+irApw1y6eYkfblQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="311325680"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="311325680"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="619018435"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="619018435"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2022 16:37:01 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] iommu/vt-d: Remove unnecessary domain_context_mapped()
Date:   Tue, 22 Nov 2022 08:29:48 +0800
Message-Id: <20221122002949.148140-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122002949.148140-1-baolu.lu@linux.intel.com>
References: <20221122002949.148140-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
Link: https://lore.kernel.org/r/20221118132451.114406-7-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 47 +++----------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4484da88f917..3a05cfbc252a 100644
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
@@ -2097,30 +2084,6 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
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
@@ -4267,6 +4230,7 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
 	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
@@ -4275,13 +4239,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
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

