Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062D1620A87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiKHHmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiKHHld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156CE1A384
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893287; x=1699429287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zTZb7UZzftplWCVlQbHsdD95SGetcv/Zvq7nWlgOBsA=;
  b=bExh9GIjyKScMrxBk7bupD2oRPwhM09NFVtr8pj3Cf4h//bvgcZuJluD
   VpDbH2DizupXiLFeykZA3yo+q1DrVH71l0WbdjJWfChsG91n86u6rSDCI
   elL8V6Wn//TjKXn++ewylkaxiINqFLMjtEnQXL1cLTiGTRK58pRc7IK/+
   PKox+2btsextZMi65UTLSkT8aXNFzXHVevJTED8pSMFJC+xTgL1g4PYpc
   Lqej/DKlTEqvgIvvNVo7+nXoUV3sS85odBjQNPQ2c/inNRHcm6i0ZDCRD
   uM9yNXaY4uYVXaJJyrIbRprDGp5oiZupv5dT1YQwwdumzgBtyBVhGKBrV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="309339948"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="309339948"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:41:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699821940"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699821940"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 23:41:10 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 5/8] iommu/vt-d: Fold dmar_remove_one_dev_info() into its caller
Date:   Tue,  8 Nov 2022 15:34:05 +0800
Message-Id: <20221108073408.1005721-6-baolu.lu@linux.intel.com>
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

Fold dmar_remove_one_dev_info() into intel_iommu_release_device() which
is its only caller. Replace most of the code with
device_block_translation() to make the code neat and tidy.

Rename iommu_disable_dev_iotlb() to iommu_disable_pci_caps() to pair with
iommu_enable_pci_caps().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5d5d08192c2c..8bbe516f7d21 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1479,7 +1479,7 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	}
 }
 
-static void iommu_disable_dev_iotlb(struct device_domain_info *info)
+static void iommu_disable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
@@ -4124,30 +4124,6 @@ static void domain_context_clear(struct device_domain_info *info)
 			       &domain_context_clear_one_cb, info);
 }
 
-static void dmar_remove_one_dev_info(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
-	struct intel_iommu *iommu = info->iommu;
-	unsigned long flags;
-
-	if (!dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
-			intel_pasid_tear_down_entry(iommu, info->dev,
-					PASID_RID2PASID, false);
-
-		iommu_disable_dev_iotlb(info);
-		domain_context_clear(info);
-	}
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_del(&info->link);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	domain_detach_iommu(domain, iommu);
-	info->domain = NULL;
-}
-
 /*
  * Clear the page table pointer in context or pasid table entries so that
  * all DMA requests without PASID from the device are blocked. If the page
@@ -4596,7 +4572,10 @@ static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
-	dmar_remove_one_dev_info(dev);
+	iommu_disable_pci_caps(info);
+	domain_context_clear(info);
+	device_block_translation(dev);
+
 	intel_pasid_free_table(dev);
 	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
-- 
2.34.1

