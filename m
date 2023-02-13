Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EC0693F41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBMH6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjBMH6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:58:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA4125A5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676275096; x=1707811096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Rrie2bPqPi5V+Iz3CI03igARGPvTfvHLhvvVc+LOMs=;
  b=GoCPvHYsNojra/bYA3NVeNo5Yo/qftY+vxrdrpIH3yv25svsRcxr6uSz
   glq1zNSDZn+bzPqP5fngLpuBiPwRk2loSNlB4e2TCcz+jVs1etmzvYxJP
   kKYJq1GyE4+IPLAh0sHQvVKHnMScPOoik040buaUwRl6bgQeV9uH9UFvJ
   sGTUR+yDMbaOK0e4eXNxLQYqLDp3+beEufyTRrCH9Nzv3Ld1ZwRtOGFvl
   7wt+Y7ssKJlHH+w4nuvh25TPjtwMshNA5KmLRFjcJS8mjEnMAMbu0F41/
   k7xkbB57xlvrXgNVs/2vHImb0ILMHPWRqeFxKfvMJefD3pf/fStPerdcH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="417058757"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="417058757"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 23:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="842684803"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="842684803"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2023 23:58:13 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/4] iommu: Add dev_iommu->ops_rwsem
Date:   Mon, 13 Feb 2023 15:49:38 +0800
Message-Id: <20230213074941.919324-2-baolu.lu@linux.intel.com>
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

Add a RW semaphore to make sure that iommu_ops of a device is consistent
in any non-driver-oriented path, such as a store operation on the iommu
group sysfs node.

Add a pair of helpers to freeze and unfreeze the iommu ops of all devices
in an iommu group, and use them in iommu_group_store_type().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  3 +++
 drivers/iommu/iommu.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3589d1b8f922..a4204e1bfef3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -402,6 +402,8 @@ struct iommu_fault_param {
  * @fwspec:	 IOMMU fwspec data
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
+ * @ops_rwsem:	 RW semaphore to synchronize between device release
+ *		 path and the sysfs interfaces.
  * @max_pasids:  number of PASIDs this device can consume
  * @attach_deferred: the dma domain attachment is deferred
  *
@@ -415,6 +417,7 @@ struct dev_iommu {
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
+	struct rw_semaphore		ops_rwsem;
 	u32				max_pasids;
 	u32				attach_deferred:1;
 };
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5f1dc9aaba52..4f71dcd2621b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -267,6 +267,7 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 		return NULL;
 
 	mutex_init(&param->lock);
+	init_rwsem(&param->ops_rwsem);
 	dev->iommu = param;
 	return param;
 }
@@ -461,12 +462,19 @@ void iommu_release_device(struct device *dev)
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
+	/*
+	 * The device's iommu_ops will be released in .release_device
+	 * callback. Hold ops_rwsem to avoid use after release.
+	 */
+	down_write(&dev->iommu->ops_rwsem);
 	ops = dev_iommu_ops(dev);
 	if (ops->release_device)
 		ops->release_device(dev);
+	module_put(ops->owner);
+	dev->iommu->iommu_dev = NULL;
+	up_write(&dev->iommu->ops_rwsem);
 
 	iommu_group_remove_device(dev);
-	module_put(ops->owner);
 	dev_iommu_free(dev);
 }
 
@@ -2911,6 +2919,46 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	return ret;
 }
 
+static int iommu_group_freeze_dev_ops(struct iommu_group *group)
+{
+	struct group_device *device;
+	struct device *dev;
+
+	mutex_lock(&group->mutex);
+	list_for_each_entry(device, &group->devices, list) {
+		dev = device->dev;
+		down_read(&dev->iommu->ops_rwsem);
+		/* .release_device has been called. */
+		if (!dev->iommu->iommu_dev) {
+			up_read(&dev->iommu->ops_rwsem);
+			goto restore_out;
+		}
+	}
+	mutex_unlock(&group->mutex);
+
+	return 0;
+
+restore_out:
+	list_for_each_entry(device, &group->devices, list) {
+		if (device->dev == dev)
+			break;
+		up_read(&device->dev->iommu->ops_rwsem);
+	}
+	mutex_unlock(&group->mutex);
+
+	return -EINVAL;
+}
+
+static void iommu_group_unfreeze_dev_ops(struct iommu_group *group)
+{
+	struct group_device *device;
+
+	mutex_lock(&group->mutex);
+	list_for_each_entry(device, &group->devices, list)
+		up_read(&device->dev->iommu->ops_rwsem);
+	mutex_unlock(&group->mutex);
+}
+
 /*
  * Changing the default domain through sysfs requires the users to unbind the
  * drivers from the devices in the iommu group, except for a DMA -> DMA-FQ
@@ -2988,6 +3036,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	 */
 	mutex_unlock(&group->mutex);
 
+	iommu_group_freeze_dev_ops(group);
+
 	/* Check if the device in the group still has a driver bound to it */
 	device_lock(dev);
 	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
@@ -3002,6 +3052,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 out:
 	device_unlock(dev);
+	iommu_group_unfreeze_dev_ops(group);
 	put_device(dev);
 
 	return ret;
-- 
2.34.1

