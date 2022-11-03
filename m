Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6CC61767C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKCGAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKCGAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:00:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0474011145
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667455218; x=1698991218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JboFRltoczbXP4x/urgFAYiKbX2mR+qR0k/5T6o9tzA=;
  b=icdIz2XuAtpL2Rj1cR+rBLAJtS/desmlTYNnrFeAAoYD1ousUOUnp4Mm
   aD6YpZuiyUsYhznHMpTxLePu2Wt/j/IpmxH17kjj8m/09EAPFlhSfKlMT
   JC4iiIdGW9gYEH9Z1hLC2mNhi7cTZc1pxXpf8G6OM5KrTIT8W4eRWQkB0
   aCzFxyNTahPODYBY61FIoFb4/FOg2orOQ/dOA6Yc9hTUqK/Uk28GLEnHu
   x/ZZlX4Bd/9+VcUqWJqizGUAaqdfYJtzCqjCebb4nwm8sPfWzP9WGeVwQ
   7sdnCWxyl8OSno+PK/bcGS88D0zuhXS7rlpSgZxbQkqm/0dq9Qq5JA2bV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="311322481"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="311322481"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 23:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723819282"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723819282"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 23:00:15 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/7] iommu/vt-d: Allocate pasid table in device probe path
Date:   Thu,  3 Nov 2022 13:53:23 +0800
Message-Id: <20221103055329.633052-2-baolu.lu@linux.intel.com>
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

Whether or not a domain is attached to the device, the pasid table should
always be valid as long as it has been probed. This moves the pasid table
allocation from the domain attaching device path to device probe path and
frees it in the device release path.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a934a46bb9e6..e28faba1095f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2477,13 +2477,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
-		ret = intel_pasid_alloc_table(dev);
-		if (ret) {
-			dev_err(dev, "PASID table allocation failed\n");
-			dmar_remove_one_dev_info(dev);
-			return ret;
-		}
-
 		/* Setup the PASID entry for requests without PASID: */
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
@@ -4108,7 +4101,6 @@ static void dmar_remove_one_dev_info(struct device *dev)
 
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
-		intel_pasid_free_table(info->dev);
 	}
 
 	spin_lock_irqsave(&domain->lock, flags);
@@ -4470,6 +4462,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
+	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu || !iommu->iommu.ops)
@@ -4513,6 +4506,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, info);
 
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
+		ret = intel_pasid_alloc_table(dev);
+		if (ret) {
+			dev_err(dev, "PASID table allocation failed\n");
+			dev_iommu_priv_set(dev, NULL);
+			kfree(info);
+			return ERR_PTR(ret);
+		}
+	}
+
 	return &iommu->iommu;
 }
 
@@ -4521,6 +4524,7 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
 	dmar_remove_one_dev_info(dev);
+	intel_pasid_free_table(dev);
 	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 	set_dma_ops(dev, NULL);
-- 
2.34.1

