Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE4462743F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiKNBsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiKNBsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:48:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26540DFC3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668390477; x=1699926477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2i7NS4jJ8/ISC5Wd85I3fce+lIQh/XAYJASCa5qbM8k=;
  b=hAOb7q5i/q19ZW8Bw+QvnCjUHXbaDEY1kmdPySjhyJJTzZ14MEslADqM
   0jUAU0KauyAmHABR/IiG6bza46v9nnrqkE1kMEQFBKwn/4R5MjKTukJV8
   sPi4RF8ZFT00oUs9GDfviULJ8MXTZTGVIPr8p345MXhbR0xEIwW1F1zRE
   UIHb+34PjMkEOsTpXrokhgrIGYs8VgJsyQhAwaRkcaWqAG9BZcIkcHyla
   s7aR+okYyfuCtka7pcPS5GBj7FPD9cJwF1cN6TluGpKV+W+tSuqkMUv0J
   cmkUGAt9rJbIeD9T6bGd4aMF9IBJcjOpwRwI1FU5pWGa5+Iw46YY90/b3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313006690"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313006690"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 17:47:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="707124225"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="707124225"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2022 17:47:54 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into its caller
Date:   Mon, 14 Nov 2022 09:40:46 +0800
Message-Id: <20221114014049.3959-5-baolu.lu@linux.intel.com>
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

Fold dmar_remove_one_dev_info() into intel_iommu_release_device() which
is its only caller. Replace most of the code with
device_block_translation() to make the code neat and tidy.

Rename iommu_disable_dev_iotlb() to iommu_disable_pci_caps() to pair with
iommu_enable_pci_caps().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3d3fa182fcb1..f165e0d37bab 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1443,7 +1443,7 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	}
 }
 
-static void iommu_disable_dev_iotlb(struct device_domain_info *info)
+static void iommu_disable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
@@ -4089,30 +4089,6 @@ static void domain_context_clear(struct device_domain_info *info)
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
@@ -4124,7 +4100,7 @@ static void device_block_translation(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 
-	iommu_disable_dev_iotlb(info);
+	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
@@ -4562,7 +4538,10 @@ static void intel_iommu_release_device(struct device *dev)
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

