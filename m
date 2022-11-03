Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8647A61767E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKCGAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKCGAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:00:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE85193E6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667455222; x=1698991222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aM0hjyh9mfWlQ4E49BdI7O/4F+S//PSRVfW2yc2UlB0=;
  b=Zm6jWa/rfmz3M/Kf/dCQPwsvdu/WlskLHEguUJ/DnIhpFxGOXxcMtB+6
   LVxKvD6gBAKAeGZFfxc3E1sVyq/ejdo2HcWCDWBE26rrYpg+FHaHY/iNO
   g9zadLvT5uuUw9ofOJl2B7bwMtl3hBfe2HLeIlSpCfAzKHYMd2fCBmR4y
   SDjCwDoJLbpMRvemAAanhM6kYTcKyiUE7+SqZQBXXi44n+aSpa19vsEtS
   5rrXxTjmonsGvcD7GPCiYy1evkvo/cT2Mhh6Gs6Un48htsw+EeGYUz1Xp
   c/5x6FaWnFVk7oBJfZr2fTpWUaCKt25hYdPvpUQyKJ0M0FfLj3osQDJWV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="311322498"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="311322498"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 23:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723819305"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723819305"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 23:00:20 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/7] iommu/vt-d: Use device_block_translation() in dev_attach error path
Date:   Thu,  3 Nov 2022 13:53:25 +0800
Message-Id: <20221103055329.633052-4-baolu.lu@linux.intel.com>
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

If domain attaching to device fails, the IOMMU driver should bring the
device to blocking DMA state. The upper layer is expected to recover it
by attaching a new domain. Use device_block_translation() in the error
path of dev_attach to make the behavior specific.

The difference between device_block_translation() and the previous
dmar_remove_one_dev_info() is that the latter disables PCIe ATS and the
related PCIe features. This is unnecessary as these features are not per
domain capabilities, disabling them during domain switching is
unnecessary.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7374a03cbe27..b956c411f2bb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -277,8 +277,8 @@ static LIST_HEAD(dmar_satc_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
-static void dmar_remove_one_dev_info(struct device *dev);
 static void intel_iommu_domain_free(struct iommu_domain *domain);
+static void device_block_translation(struct device *dev);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -2490,7 +2490,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 					dev, PASID_RID2PASID);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
-			dmar_remove_one_dev_info(dev);
+			device_block_translation(dev);
 			return ret;
 		}
 	}
@@ -2498,7 +2498,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	ret = domain_context_mapping(domain, dev);
 	if (ret) {
 		dev_err(dev, "Domain context map failed\n");
-		dmar_remove_one_dev_info(dev);
+		device_block_translation(dev);
 		return ret;
 	}
 
@@ -4283,7 +4283,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		struct device_domain_info *info = dev_iommu_priv_get(dev);
 
 		if (info->domain)
-			dmar_remove_one_dev_info(dev);
+			device_block_translation(dev);
 	}
 
 	ret = prepare_domain_attach_device(domain, dev);
-- 
2.34.1

