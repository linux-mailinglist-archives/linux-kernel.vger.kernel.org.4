Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2836C438F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCVGuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCVGt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:49:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1E5BC8C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679467789; x=1711003789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Il0exbOKWwaeUfCP7sZnohPbX01OZ44X03V9nAnokQM=;
  b=UedqOQ66rrzQSu7kZL34CBz3UN+8XCCxdBgPrAsz4i5CrEL7x5EmUFh7
   QekXPqGUygSMG5xnt/XYHHLFDoWprxhTBimsF4RNISvhBQmLV6bQ2zZkS
   j1aieGbyL0mlAWDHGgr4+KIW6MF4FyizEjErB1uKHWliIkCQXbVnGeZPm
   PJ+iVPreWps1+iUfDmByu/dy15fnNQ1MzKW7djsajFQ2XPbPKVLDrtUqR
   TxMNr3YsefAbkvuUQKjDgl0xdLCoSRzhChf9w/FQ1Cvj1wBrvMEx0nY1X
   5E8AhKP4cvTojNeyrgvElsMDkfY/YzkBo9PXB6iVs8i+Ic5Id3bbl+RkC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="337866775"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="337866775"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="659080448"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="659080448"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2023 23:49:46 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 5/6] iommu: Replace device_lock() with group->mutex
Date:   Wed, 22 Mar 2023 14:49:55 +0800
Message-Id: <20230322064956.263419-6-baolu.lu@linux.intel.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 81 ++++++++++---------------------------------
 1 file changed, 18 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 54a5bd79d21b..b780cdddf415 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2956,14 +2956,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
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
 	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
 	if (ret)
@@ -2996,7 +2988,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
  * transition. Return failure if this isn't met.
  *
  * We need to consider the race between this and the device release path.
- * device_lock(dev) is used here to guarantee that the device release path
+ * group->mutex is used here to guarantee that the device release path
  * will not be entered at the same time.
  */
 static ssize_t iommu_group_store_type(struct iommu_group *group,
@@ -3023,61 +3015,29 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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
+	}
+
+	/* Otherwise, ensure that device exists and no driver is bound. */
+	if (list_empty(&group->devices) || group->owner_cnt) {
+		mutex_unlock(&group->mutex);
+		return -EPERM;
 	}
 
-	/* Since group has only one device */
 	grp_dev = list_first_entry(&group->devices, struct group_device, list);
 	dev = grp_dev->dev;
-	get_device(dev);
 
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
-	}
-
-	mutex_lock(&group->mutex);
 	ret = iommu_change_dev_def_domain(group, dev, req_type);
+
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
 	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
@@ -3088,14 +3048,9 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
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

