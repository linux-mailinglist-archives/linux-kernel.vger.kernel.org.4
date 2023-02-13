Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E87693F44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjBMH6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBMH61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:58:27 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DCB12847
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676275101; x=1707811101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ES7z2AGJUYYSi8+q2JnrnEZVheTtSStbFLmnP3Q4p4=;
  b=BhyVwuQgQ6iOAM7pjt+LEF9UBhvVSerTGLvqRLnp/vsWv/HZMHYDpNMN
   etJbLDYCmcDZtaxN6PAZry44DTsZm4mOgtjj7jZS19h3r8EjPVQrtfg61
   3jo3/0M1LrGKGeqnFyH05zvxmnrRIvqcJRNNTs+2RMUvZYEZCIIGi0qM+
   ZLf/e4l21N3/IHowE43o+vbdR/s3gUH2mWnjexguNKhC+RFMKMrJwRIb3
   QmKU7svGwUdER1ipQFOILZrRqZbOPyxG6G7mo77pPIGd3C2bceIr3Mr7d
   M8d3R9mahBRLqmRfR7EHdVLfV1I/QHODFaIOewnfUysJHBImVzG/gUXKH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="417058786"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="417058786"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 23:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="842684811"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="842684811"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2023 23:58:18 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/4] iommu: Remove unnecessary device_lock()
Date:   Mon, 13 Feb 2023 15:49:40 +0800
Message-Id: <20230213074941.919324-4-baolu.lu@linux.intel.com>
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

device_lock() was used in iommu_group_store_type() to prevent the
devices in an iommu group from being attached by any device driver.
On the other hand, in order to avoid lock race between group->mutex
and device_lock(), it limited the usage scenario to the singleton
groups.

We have used the DMA ownership framework to avoid driver attachment
and ensured that device ops are always valid, there's no need to
lock device anymore. Remove use of device_lock() and the singleton
group limitation.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 78 ++++---------------------------------------
 1 file changed, 6 insertions(+), 72 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6547cb38480c..1e69def20a67 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2786,8 +2786,6 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
  * Changes the default domain of an iommu group that has *only* one device
  *
  * @group: The group for which the default domain should be changed
- * @prev_dev: The device in the group (this is used to make sure that the device
- *	 hasn't changed after the caller has called this function)
  * @type: The type of the new default domain that gets associated with the group
  *
  * Returns 0 on success and error code on failure
@@ -2797,8 +2795,7 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
  *    group's default domain type through /sys/kernel/iommu_groups/<grp_id>/type
  *    Please take a closer look if intended to use for other purposes.
  */
-static int iommu_change_dev_def_domain(struct iommu_group *group,
-				       struct device *prev_dev, int type)
+static int iommu_change_dev_def_domain(struct iommu_group *group, int type)
 {
 	struct iommu_domain *prev_dom;
 	struct group_device *grp_dev;
@@ -2821,7 +2818,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	 * waiting for T1 to release other device locks.
 	 */
 	if (iommu_group_device_count(group) != 1) {
-		dev_err_ratelimited(prev_dev, "Cannot change default domain: Group has more than one device\n");
+		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2830,12 +2827,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	grp_dev = list_first_entry(&group->devices, struct group_device, list);
 	dev = grp_dev->dev;
 
-	if (prev_dev != dev) {
-		dev_err_ratelimited(prev_dev, "Cannot change default domain: Device has been changed\n");
-		ret = -EBUSY;
-		goto out;
-	}
-
 	prev_dom = group->default_domain;
 	if (!prev_dom) {
 		ret = -EINVAL;
@@ -2851,8 +2842,8 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		 */
 		type = dev_def_dom ? : iommu_def_domain_type;
 	} else if (dev_def_dom && type != dev_def_dom) {
-		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
-				    iommu_domain_type_str(type));
+		pr_err_ratelimited("Device cannot be in %s domain\n",
+				   iommu_domain_type_str(type));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2959,15 +2950,11 @@ static void iommu_group_unfreeze_dev_ops(struct iommu_group *group)
  * transition. Return failure if this isn't met.
  *
  * We need to consider the race between this and the device release path.
- * device_lock(dev) is used here to guarantee that the device release path
- * will not be entered at the same time.
  */
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
 	bool group_owner_claimed = false;
-	struct group_device *grp_dev;
-	struct device *dev;
 	int ret, req_type;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
@@ -2995,66 +2982,13 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		group_owner_claimed = true;
 	}
 
-	/*
-	 * Lock/Unlock the group mutex here before device lock to
-	 * 1. Make sure that the iommu group has only one device (this is a
-	 *    prerequisite for step 2)
-	 * 2. Get struct *dev which is needed to lock device
-	 */
-	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
-		mutex_unlock(&group->mutex);
-		if (group_owner_claimed)
-			iommu_group_release_dma_owner(group);
-		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
-		return -EINVAL;
-	}
-
-	/* Since group has only one device */
-	grp_dev = list_first_entry(&group->devices, struct group_device, list);
-	dev = grp_dev->dev;
-	get_device(dev);
-
-	/*
-	 * Don't hold the group mutex because taking group mutex first and then
-	 * the device lock could potentially cause a deadlock as below. Assume
-	 * two threads T1 and T2. T1 is trying to change default domain of an
-	 * iommu group and T2 is trying to hot unplug a device or release [1] VF
-	 * of a PCIe device which is in the same iommu group. T1 takes group
-	 * mutex and before it could take device lock assume T2 has taken device
-	 * lock and is yet to take group mutex. Now, both the threads will be
-	 * waiting for the other thread to release lock. Below, lock order was
-	 * suggested.
-	 * device_lock(dev);
-	 *	mutex_lock(&group->mutex);
-	 *		iommu_change_dev_def_domain();
-	 *	mutex_unlock(&group->mutex);
-	 * device_unlock(dev);
-	 *
-	 * [1] Typical device release path
-	 * device_lock() from device/driver core code
-	 *  -> bus_notifier()
-	 *   -> iommu_bus_notifier()
-	 *    -> iommu_release_device()
-	 *     -> ops->release_device() vendor driver calls back iommu core code
-	 *      -> mutex_lock() from iommu core code
-	 */
-	mutex_unlock(&group->mutex);
-
 	iommu_group_freeze_dev_ops(group);
-
-	device_lock(dev);
-
-	ret = iommu_change_dev_def_domain(group, dev, req_type);
-	ret = ret ?: count;
-
-	device_unlock(dev);
+	ret = iommu_change_dev_def_domain(group, req_type);
 	iommu_group_unfreeze_dev_ops(group);
-	put_device(dev);
 	if (group_owner_claimed)
 		iommu_group_release_dma_owner(group);
 
-	return ret;
+	return ret ?: count;
 }
 
 static bool iommu_is_default_domain(struct iommu_group *group)
-- 
2.34.1

