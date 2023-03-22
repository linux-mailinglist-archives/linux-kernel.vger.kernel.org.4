Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA7C6C4391
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCVGu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCVGuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:50:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DC32B9EA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679467792; x=1711003792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5/QtRJNGbVy0gqEC5sJtBu3RE6LTB+TTy8zzoXdzsNA=;
  b=YtPG9MeTu8t46wv4wJrQqSXA6SDKhO9V9yjOsVm/ILmBHgM1I2hYNOlu
   ulHfTmfjJ3gFDKxWVLxVxEFDO/6bZV4Y7MPPaSf707mZX83cOQpNUzupo
   Yz9775Ir1NNjpb0owfDawmPqe+VVNbhvEHKW83XkrnBvARbaEX4IG2Bnt
   lMBftsHtquAaoqhMerBPRcQ+9V874O6QM0dowY2WdmIsDK9tGV+WQa68J
   2PS/Rn9PQZoOu5ZfQMuDA5/pdyjpnQGyemzOdxLe0/msqr3PqhUvDsVAR
   BuyzGrxp+F1s1MTD2qA1JPyax6nQcADzNONFV48Tzr/eBMJTwD/KyjWZV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="337866787"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="337866787"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:49:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="659080461"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="659080461"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2023 23:49:49 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 6/6] iommu: Cleanup iommu_change_dev_def_domain()
Date:   Wed, 22 Mar 2023 14:49:56 +0800
Message-Id: <20230322064956.263419-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322064956.263419-1-baolu.lu@linux.intel.com>
References: <20230322064956.263419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the singleton group limitation has been removed, cleanup the code
in iommu_change_dev_def_domain() accordingly.

Documentation is also updated.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c                         | 83 +++++--------------
 .../ABI/testing/sysfs-kernel-iommu_groups     |  1 -
 2 files changed, 21 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b780cdddf415..a38b9f279c5d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2867,11 +2867,10 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
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
@@ -2882,103 +2881,63 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
  *    Please take a closer look if intended to use for other purposes.
  */
 static int iommu_change_dev_def_domain(struct iommu_group *group,
-				       struct device *prev_dev, int type)
+				       struct device *dev, int type)
 {
+	struct __group_domain_type gtype = {NULL, 0};
 	struct iommu_domain *prev_dom;
-	struct group_device *grp_dev;
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
-	grp_dev = list_first_entry(&group->devices, struct group_device, list);
-	dev = grp_dev->dev;
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
 	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
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

