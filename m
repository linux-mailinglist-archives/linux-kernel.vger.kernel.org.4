Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D469620A88
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiKHHmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiKHHlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD4DB2C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893284; x=1699429284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUAcn7l+zVrrpUEV4zCmZzIi0Xm0VFhOC2KqG1FORZo=;
  b=df3MqkMyZb8+QG/e4ekStc29GsgsF+/9LENJZkLaIZrQ4ekoZ4Xpkprz
   /nPqa2PyukeT/ChkD2nHPZKW4GzysQs7Iut+EMIDJeM0WGlpwcHmLwvGU
   syvJTVmU4nIU7q9nNGjhPSX+zKWGFvYIV/4I+Uk5AL8+SVHsC9NoSru50
   /qkUp/VrS+Eep5v3OU+MLSvY12g1NtKnzCgLDr3JwUYbmoGpjjFGbYYM3
   kciHD+bHDqWwBKTPmZ7CdoGvFfB8H3u3Q1E+e3EKka0WcQIAwkD4FXq+S
   OcLh2ZXW18Pzi61n88twCZESx4Vg6xN8wLW/GqfmcMkmKtfme++499vq1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="309339920"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="309339920"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:41:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699821909"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699821909"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 23:41:08 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 4/8] iommu/vt-d: Add blocking domain support
Date:   Tue,  8 Nov 2022 15:34:04 +0800
Message-Id: <20221108073408.1005721-5-baolu.lu@linux.intel.com>
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

The Intel IOMMU hardwares support blocking DMA transactions by clearing
the translation table entries. This implements a real blocking domain to
avoid using an empty UNMANAGED domain. The detach_dev callback of the
domain ops is not used in any path. Remove it to avoid dead code as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a5d0e6c88180..5d5d08192c2c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -278,6 +278,7 @@ static LIST_HEAD(dmar_satc_units);
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
 static void device_block_translation(struct device *dev);
+static void intel_iommu_domain_free(struct iommu_domain *domain);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -4198,12 +4199,28 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	return 0;
 }
 
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
@@ -4238,7 +4255,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
-	if (domain != &si_domain->domain)
+	if (domain != &si_domain->domain && domain != &blocking_domain)
 		domain_exit(to_dmar_domain(domain));
 }
 
@@ -4308,12 +4325,6 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
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
@@ -4821,7 +4832,6 @@ const struct iommu_ops intel_iommu_ops = {
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
-		.detach_dev		= intel_iommu_detach_device,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
 		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
-- 
2.34.1

