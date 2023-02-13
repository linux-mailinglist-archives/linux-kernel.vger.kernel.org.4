Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4617C693F43
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBMH6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBMH6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:58:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC684EE8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676275099; x=1707811099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AazWd96xxOSoSDyvZpaQLi9s44x2C1YOu7YcySHmaWw=;
  b=njK/FKk/1ET1BQz9vbmL0Z9czc4Xl6Cj4ohlu9cQZRun3c42H+mEwGZO
   tbC4L231KL63zRk3GsWhskmEoIzHekbV0YMr65T4dtV13KWjQDLfUefpO
   2k7lOlSV6rNuVbqQ/MEfb3o1CONqlalImg2TVtXBtM226OFCpBRiSLQN2
   N64nSFY12Am8dRZ6Ew+JfsLsRjzgaWXhWrNMU5AR1OkezFKsBfB7CyWe6
   zomoY8RIZOAlT/soDH83ywrIWhQVo8G5w3IqTwSTNesdIXckrFaYcDxKM
   1dayHrQsIDIDD6f7mYGtO46+uaAPWEdoYtfTSLs9bMq1mLab0jO/n7VLC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="417058772"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="417058772"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 23:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="842684807"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="842684807"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2023 23:58:16 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/4] iommu: Use group ownership to avoid driver attachment
Date:   Mon, 13 Feb 2023 15:49:39 +0800
Message-Id: <20230213074941.919324-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213074941.919324-1-baolu.lu@linux.intel.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
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

The iommu_group_store_type() requires the devices in the iommu group are
not bound to any device driver during the whole operation. The existing
code locks the device with device_lock(dev) and use device_is_bound() to
check whether any driver is bound to device.

In fact, this can be achieved through the DMA ownership helpers. Replace
them with iommu_group_claim/release_dma_owner() helpers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f71dcd2621b..6547cb38480c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2807,12 +2807,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 
 	mutex_lock(&group->mutex);
 
-	if (group->default_domain != group->domain) {
-		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
-		ret = -EBUSY;
-		goto out;
-	}
-
 	/*
 	 * iommu group wasn't locked while acquiring device lock in
 	 * iommu_group_store_type(). So, make sure that the device count hasn't
@@ -2971,6 +2965,7 @@ static void iommu_group_unfreeze_dev_ops(struct iommu_group *group)
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
+	bool group_owner_claimed = false;
 	struct group_device *grp_dev;
 	struct device *dev;
 	int ret, req_type;
@@ -2992,6 +2987,14 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	else
 		return -EINVAL;
 
+	if (req_type != IOMMU_DOMAIN_DMA_FQ ||
+	    group->default_domain->type != IOMMU_DOMAIN_DMA) {
+		ret = iommu_group_claim_dma_owner(group, (void *)buf);
+		if (ret)
+			return ret;
+		group_owner_claimed = true;
+	}
+
 	/*
 	 * Lock/Unlock the group mutex here before device lock to
 	 * 1. Make sure that the iommu group has only one device (this is a
@@ -3001,6 +3004,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	mutex_lock(&group->mutex);
 	if (iommu_group_device_count(group) != 1) {
 		mutex_unlock(&group->mutex);
+		if (group_owner_claimed)
+			iommu_group_release_dma_owner(group);
 		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
 		return -EINVAL;
 	}
@@ -3038,22 +3043,16 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	iommu_group_freeze_dev_ops(group);
 
-	/* Check if the device in the group still has a driver bound to it */
 	device_lock(dev);
-	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
-	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
-		pr_err_ratelimited("Device is still bound to driver\n");
-		ret = -EBUSY;
-		goto out;
-	}
 
 	ret = iommu_change_dev_def_domain(group, dev, req_type);
 	ret = ret ?: count;
 
-out:
 	device_unlock(dev);
 	iommu_group_unfreeze_dev_ops(group);
 	put_device(dev);
+	if (group_owner_claimed)
+		iommu_group_release_dma_owner(group);
 
 	return ret;
 }
-- 
2.34.1

