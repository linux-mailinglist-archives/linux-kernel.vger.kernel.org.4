Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4376AB4D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCFC7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCFC7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:59:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEE912069
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678071570; x=1709607570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Taiw2o2chkLGjTGNeAmtwqU/UhEE9L3oW9AzQ9w2d3I=;
  b=mAtgoytfVraoykZ6qVCf+TvF0IPuLGw/txjzRvN9GMVa0YVXwtQIM2AB
   X1XvLgvuS/oEwOgEMgOoruQeV+Duc7D34CTZWZHbPCPSH52d+Mndgt/vt
   jjcpLXFNK4I9Hf2JVqOpOLqJiJHdTlimGljngkM2EkpK/G8WUNE1u3zHW
   wbrTT8rRdDQR3NZNSog324A1qMp4j5LH+Q4XBzhEBVpxT+4u7xQcmjh6r
   qCcHsd5yJ/COq0y+dku6r3isu0SIym40aUAJcyqZnoBtukpDjmyUV/xjX
   G6vc0rutLwDFTF+RN44LRKWx/T6OpnLmnpHwkr1EL/JrbIjIH2DjaAwSr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="363071543"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="363071543"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 18:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="765072490"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="765072490"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2023 18:59:27 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 6/6] iommu: Cleanup iommu_change_dev_def_domain()
Date:   Mon,  6 Mar 2023 10:58:04 +0800
Message-Id: <20230306025804.13912-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306025804.13912-1-baolu.lu@linux.intel.com>
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
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

As the singleton group limitation has been removed, cleanup the code
in iommu_change_dev_def_domain() accordingly.

Documentation is also updated.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c                         | 81 +++++--------------
 .../ABI/testing/sysfs-kernel-iommu_groups     |  1 -
 2 files changed, 21 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9fe6d149f281..735554ccc04b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2924,11 +2924,10 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 
 /*
- * Changes the default domain of an iommu group that has *only* one device
+ * Changes the default domain of an iommu group
  *
  * @group: The group for which the default domain should be changed
- * @prev_dev: The device in the group (this is used to make sure that the device
- *	 hasn't changed after the caller has called this function)
+ * @dev: The first device in the group
  * @type: The type of the new default domain that gets associated with the group
  *
  * Returns 0 on success and error code on failure
@@ -2939,101 +2938,63 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
  *    Please take a closer look if intended to use for other purposes.
  */
 static int iommu_change_dev_def_domain(struct iommu_group *group,
-				       struct device *prev_dev, int type)
+				       struct device *dev, int type)
 {
+	struct __group_domain_type gtype = {NULL, 0};
 	struct iommu_domain *prev_dom;
-	int ret, dev_def_dom;
-	struct device *dev;
+	int ret;
 
 	lockdep_assert_held(&group->mutex);
 
-	if (group->default_domain != group->domain) {
-		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
-		ret = -EBUSY;
-		goto out;
-	}
-
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
-		dev_err_ratelimited(prev_dev, "Cannot change default domain: Group has more than one device\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* Since group has only one device */
-	dev = iommu_group_first_dev(group);
-
-	if (prev_dev != dev) {
-		dev_err_ratelimited(prev_dev, "Cannot change default domain: Device has been changed\n");
-		ret = -EBUSY;
-		goto out;
-	}
-
 	prev_dom = group->default_domain;
-	if (!prev_dom) {
-		ret = -EINVAL;
-		goto out;
-	}
-
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
-		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
+		type = gtype.type ? : iommu_def_domain_type;
+	} else if (gtype.type && type != gtype.type) {
+		dev_err_ratelimited(dev, "Device cannot be in %s domain\n",
 				    iommu_domain_type_str(type));
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/*
 	 * Switch to a new domain only if the requested domain type is different
 	 * from the existing default domain type
 	 */
-	if (prev_dom->type == type) {
-		ret = 0;
-		goto out;
-	}
+	if (prev_dom->type == type)
+		return 0;
+
+	group->default_domain = NULL;
+	group->domain = NULL;
 
 	/* Sets group->default_domain to the newly allocated domain */
 	ret = iommu_group_alloc_default_domain(group, dev, type);
 	if (ret)
-		goto out;
+		goto restore_old_domain;
 
-	ret = iommu_create_device_direct_mappings(group, dev);
+	ret = iommu_group_create_direct_mappings(group);
 	if (ret)
 		goto free_new_domain;
 
-	ret = __iommu_attach_device(group->default_domain, dev);
+	ret = __iommu_attach_group(group->default_domain, group);
 	if (ret)
 		goto free_new_domain;
 
-	group->domain = group->default_domain;
 	iommu_domain_free(prev_dom);
 
 	return 0;
 
 free_new_domain:
 	iommu_domain_free(group->default_domain);
+restore_old_domain:
 	group->default_domain = prev_dom;
 	group->domain = prev_dom;
-out:
+
 	return ret;
 }
 
diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index b15af6a5bc08..a42d4383d999 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -53,7 +53,6 @@ Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
 
 		The default domain type of a group may be modified only when
 
-		- The group has only one device.
 		- The device in the group is not bound to any device driver.
 		  So, the users must unbind the appropriate driver before
 		  changing the default domain type.
-- 
2.34.1

