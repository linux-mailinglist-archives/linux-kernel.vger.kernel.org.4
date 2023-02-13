Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB6A693F45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBMH6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBMH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:58:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B07212F17
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676275104; x=1707811104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qmT4qJz3GuvC6rtOcQlp46cw8Mqcw48l+c2mWYJTzmI=;
  b=n4pQ3LrxvEqna4gcl/CW/KgPEFT9lOcqOoZpG4lNmL350secm2U+at1Y
   zGnYSQ6nsMRrRkSowr3TnpLwqfDhGcSPwFfpcnBNs5B78ksSW9ZqTZ/VX
   xZtfb0NIl9hUgwk2jy8ieahAKpL4WagSKWHKg/wQmATP0HazKQXIT6IDS
   lwcecFvSZPZefP/0RjLC6GYiA1tDaWOyf9pCqNeFmxHEkqjwVjA+Q8ZJk
   7879odm7DdpDWqy5OQZsh67kK8fMBw1lMgXdhFIkR7lvGUXJWQZaywNko
   6XI9VosIOPwGvxiKhqbwnENWL07H8CVmWzPkEJrl9MpFJa7UUZjw90ru7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="417058801"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="417058801"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 23:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="842684816"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="842684816"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2023 23:58:21 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/4] iommu: Cleanup iommu_change_dev_def_domain()
Date:   Mon, 13 Feb 2023 15:49:41 +0800
Message-Id: <20230213074941.919324-5-baolu.lu@linux.intel.com>
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

As the singleton group limitation has been removed, cleanup the code
in iommu_change_dev_def_domain() accordingly.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 41 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1e69def20a67..67b978403a05 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2783,7 +2783,7 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 
 /*
- * Changes the default domain of an iommu group that has *only* one device
+ * Changes the default domain of an iommu group
  *
  * @group: The group for which the default domain should be changed
  * @type: The type of the new default domain that gets associated with the group
@@ -2797,33 +2797,14 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
  */
 static int iommu_change_dev_def_domain(struct iommu_group *group, int type)
 {
+	struct __group_domain_type gtype = {NULL, 0};
 	struct iommu_domain *prev_dom;
 	struct group_device *grp_dev;
-	int ret, dev_def_dom;
 	struct device *dev;
+	int ret;
 
 	mutex_lock(&group->mutex);
 
-	/*
-	 * iommu group wasn't locked while acquiring device lock in
-	 * iommu_group_store_type(). So, make sure that the device count hasn't
-	 * changed while acquiring device lock.
-	 *
-	 * Changing default domain of an iommu group with two or more devices
-	 * isn't supported because there could be a potential deadlock. Consider
-	 * the following scenario. T1 is trying to acquire device locks of all
-	 * the devices in the group and before it could acquire all of them,
-	 * there could be another thread T2 (from different sub-system and use
-	 * case) that has already acquired some of the device locks and might be
-	 * waiting for T1 to release other device locks.
-	 */
-	if (iommu_group_device_count(group) != 1) {
-		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* Since group has only one device */
 	grp_dev = list_first_entry(&group->devices, struct group_device, list);
 	dev = grp_dev->dev;
 
@@ -2833,15 +2814,16 @@ static int iommu_change_dev_def_domain(struct iommu_group *group, int type)
 		goto out;
 	}
 
-	dev_def_dom = iommu_get_def_domain_type(dev);
+	__iommu_group_for_each_dev(group, &gtype,
+				   probe_get_default_domain_type);
 	if (!type) {
 		/*
 		 * If the user hasn't requested any specific type of domain and
 		 * if the device supports both the domains, then default to the
 		 * domain the device was booted with
 		 */
-		type = dev_def_dom ? : iommu_def_domain_type;
-	} else if (dev_def_dom && type != dev_def_dom) {
+		type = gtype.type ? : iommu_def_domain_type;
+	} else if (gtype.type && type != gtype.type) {
 		pr_err_ratelimited("Device cannot be in %s domain\n",
 				   iommu_domain_type_str(type));
 		ret = -EINVAL;
@@ -2870,16 +2852,14 @@ static int iommu_change_dev_def_domain(struct iommu_group *group, int type)
 	if (ret)
 		goto out;
 
-	ret = iommu_create_device_direct_mappings(group, dev);
+	ret = iommu_group_create_direct_mappings(group);
 	if (ret)
 		goto free_new_domain;
 
-	ret = __iommu_attach_device(group->default_domain, dev);
+	ret = __iommu_attach_group(group->default_domain, group);
 	if (ret)
 		goto free_new_domain;
 
-	group->domain = group->default_domain;
-
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
 	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
@@ -2889,7 +2869,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group, int type)
 	mutex_unlock(&group->mutex);
 
 	/* Make sure dma_ops is appropriatley set */
-	iommu_group_do_probe_finalize(dev, group->default_domain);
+	__iommu_group_dma_finalize(group);
 	iommu_domain_free(prev_dom);
 	return 0;
 
@@ -2897,7 +2877,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group, int type)
 	iommu_domain_free(group->default_domain);
 	group->default_domain = prev_dom;
 	group->domain = prev_dom;
-
 out:
 	mutex_unlock(&group->mutex);
 
-- 
2.34.1

