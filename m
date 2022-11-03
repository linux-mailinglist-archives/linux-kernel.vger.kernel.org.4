Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40761767D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKCGA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKCGAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:00:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418AB1789D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667455220; x=1698991220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lAGSG0xkmW0fDJOPqIRiT6oxympP8oIZwjeDYfOHHo0=;
  b=QGpbTfMeHJ8vAniq9lZxGQrpQyxJSqdi0pqDT6v7XS+MaGCWNF3Ur0r8
   WEFNpMSPb7SbiaYKsNMFOPKbT1DtdqwUBhnGOcqoOurBnVqQrTKJlT/s1
   KTaQQmKMv1/q0XsDijloeLzVMQU59DtRiElLY13f0gyN4BOU97E4MSkPB
   hnZBrnrBfAEkqo+JurKFB3utHLDzu2PgUw4zBr1ZmAsbFSt85xvmtGXbR
   yUXSrh6IuvpLNd3olUJvjVBYnBRLhijiPCVf7DyShIRGPsPGbY4r6r6bv
   R0eE/HDlqoi+iqLKP5xwLz3+IPAnxAnxZNrvOpk7AwFRxJOYN2YAUSTYJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="311322491"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="311322491"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 23:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723819300"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723819300"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 23:00:17 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/7] iommu/vt-d: Add blocking domain support
Date:   Thu,  3 Nov 2022 13:53:24 +0800
Message-Id: <20221103055329.633052-3-baolu.lu@linux.intel.com>
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

The Intel IOMMU hardwares support blocking DMA transactions by clearing
the translation table entries. This implements a real blocking domain to
avoid using an empty UNMANAGED domain. The detach_dev callback of the
domain ops is not used in any path. Remove it to avoid dead code as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 56 +++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e28faba1095f..7374a03cbe27 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -278,6 +278,7 @@ static LIST_HEAD(dmar_satc_units);
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
 static void dmar_remove_one_dev_info(struct device *dev);
+static void intel_iommu_domain_free(struct iommu_domain *domain);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -4132,12 +4133,58 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	return 0;
 }
 
+/*
+ * Clear the page table pointer in context or pasid table entries so that
+ * all DMA requests without PASID from the device are blocked. If the page
+ * table has been set, clean up the data structures.
+ */
+static void device_block_translation(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+
+	if (!dev_is_real_dma_subdevice(dev)) {
+		if (sm_supported(iommu))
+			intel_pasid_tear_down_entry(iommu, dev,
+						    PASID_RID2PASID, false);
+		else
+			domain_context_clear(info);
+	}
+
+	if (!info->domain)
+		return;
+
+	spin_lock_irqsave(&info->domain->lock, flags);
+	list_del(&info->link);
+	spin_unlock_irqrestore(&info->domain->lock, flags);
+
+	domain_detach_iommu(info->domain, iommu);
+	info->domain = NULL;
+}
+
+static int blocking_domain_attach_dev(struct iommu_domain *domain,
+				      struct device *dev)
+{
+	device_block_translation(dev);
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev,
+		.free		= intel_iommu_domain_free
+	}
+};
+
 static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
 
 	switch (type) {
+	case IOMMU_DOMAIN_BLOCKED:
+		return &blocking_domain;
 	case IOMMU_DOMAIN_DMA:
 	case IOMMU_DOMAIN_DMA_FQ:
 	case IOMMU_DOMAIN_UNMANAGED:
@@ -4172,7 +4219,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
-	if (domain != &si_domain->domain)
+	if (domain != &si_domain->domain && domain != &blocking_domain)
 		domain_exit(to_dmar_domain(domain));
 }
 
@@ -4246,12 +4293,6 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	return domain_add_dev_info(to_dmar_domain(domain), dev);
 }
 
-static void intel_iommu_detach_device(struct iommu_domain *domain,
-				      struct device *dev)
-{
-	dmar_remove_one_dev_info(dev);
-}
-
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot, gfp_t gfp)
@@ -4759,7 +4800,6 @@ const struct iommu_ops intel_iommu_ops = {
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
-		.detach_dev		= intel_iommu_detach_device,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
 		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
-- 
2.34.1

