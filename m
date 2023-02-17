Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371B269A8AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjBQJ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBQJ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:56:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4317863BC7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676627782; x=1708163782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=01MCM7/CfCIc4vbPRZlHWfdd2YRE/Y7v2MezR4PvnGo=;
  b=FTPUjJI5z7cfFY7HwLN7oFa546KxeZxAw7qoXeUEO/wFI0eJdUWNcxa7
   WAqk4NnZHnRG9DqE0yCD/ZIuADrFN9RO3fUkLDlyZzoaXjeW3bgZmgU/7
   trPP5mWxRmVcpfGsoQY3agY6877mpDzEui/b3/y9ia7jLjPmiqhBeD5d2
   ksfvJFoaD/lU6Rd2hZShScz3WeWiDw5IiJSGimUzCnLm2fkTdq6sHNBKB
   AiWs7OzBLi7eiluS/+5C3nYo4bw3S8Lst/TKgNWYgjFBuN/2YOESxUhYQ
   YHXHBbgJGjxPvrV21y+7oPqCPbn4ecvzjeo2mZr1OtAhRlefu+jL/iLnx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331955279"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331955279"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:56:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999391235"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="999391235"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2023 01:56:17 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 5/6] iommu: Replace device_lock() with group->mutex
Date:   Fri, 17 Feb 2023 17:47:35 +0800
Message-Id: <20230217094736.159005-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217094736.159005-1-baolu.lu@linux.intel.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
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

We already have the DMA ownership scheme to avoid driver attachment
and group->mutex ensures that device ops are always valid, there's
no need for device_lock() anymore. Remove device_lock() and the
singleton group limitation.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 78 +++++++++----------------------------------
 1 file changed, 16 insertions(+), 62 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e1ae1eb4faf0..18dac155a178 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2958,14 +2958,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		goto out;
 	}
 
-	/* We can bring up a flush queue without tearing down the domain */
-	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
-		ret = iommu_dma_init_fq(prev_dom);
-		if (!ret)
-			prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
-		goto out;
-	}
-
 	/* Sets group->default_domain to the newly allocated domain */
 	ret = iommu_group_alloc_default_domain(group, dev, type);
 	if (ret)
@@ -2998,7 +2990,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
  * transition. Return failure if this isn't met.
  *
  * We need to consider the race between this and the device release path.
- * device_lock(dev) is used here to guarantee that the device release path
+ * group->mutex is used here to guarantee that the device release path
  * will not be entered at the same time.
  */
 static ssize_t iommu_group_store_type(struct iommu_group *group,
@@ -3024,60 +3016,27 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	else
 		return -EINVAL;
 
-	/*
-	 * Lock/Unlock the group mutex here before device lock to
-	 * 1. Make sure that the iommu group has only one device (this is a
-	 *    prerequisite for step 2)
-	 * 2. Get struct *dev which is needed to lock device
-	 */
 	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
+	/* We can bring up a flush queue without tearing down the domain. */
+	if (req_type == IOMMU_DOMAIN_DMA_FQ &&
+	    group->default_domain->type == IOMMU_DOMAIN_DMA) {
+		ret = iommu_dma_init_fq(group->default_domain);
+		if (!ret)
+			group->default_domain->type = IOMMU_DOMAIN_DMA_FQ;
 		mutex_unlock(&group->mutex);
-		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
-		return -EINVAL;
+
+		return ret ?: count;
 	}
 
-	/* Since group has only one device */
+	/* Otherwise, ensure that device exists and no driver is bound. */
 	dev = iommu_group_first_dev(group);
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
-	/* Check if the device in the group still has a driver bound to it */
-	device_lock(dev);
-	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
-	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
-		pr_err_ratelimited("Device is still bound to driver\n");
-		ret = -EBUSY;
-		goto out;
+	if (!dev || group->owner_cnt) {
+		mutex_unlock(&group->mutex);
+		return -EPERM;
 	}
 
-	mutex_lock(&group->mutex);
 	ret = iommu_change_dev_def_domain(group, dev, req_type);
+
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
 	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
@@ -3088,14 +3047,9 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	/* Make sure dma_ops is appropriatley set */
 	if (!ret)
-		iommu_group_do_probe_finalize(dev, group->default_domain);
-	ret = ret ?: count;
-
-out:
-	device_unlock(dev);
-	put_device(dev);
+		__iommu_group_dma_finalize(group);
 
-	return ret;
+	return ret ?: count;
 }
 
 static bool iommu_is_default_domain(struct iommu_group *group)
-- 
2.34.1

