Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986CB6AB4D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCFC7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCFC7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:59:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4C31286F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678071567; x=1709607567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e5onQTPUwerLr2g9cgW3cFZ0Fra9mu+whj+aXFchN2A=;
  b=aIMH4XtB2Vjg52Vbj7Ee5xXusDUd3/4vGa96f+q9JC2HtgbaDszM9bn7
   yDnT2hSXX7Ov0AoONFg8hFd4c9FdcL/K31BlnGEyTv/pMXJaqKINFussi
   fNdul/oNjGA9ZbQRxA4ieKiX4wQ/6UF1lgkcfOLtObynEwBwjJ2p/WcUm
   PV9MX/1ZfGAI2npdltIsM1JmeMlw61/4SKUdtFLBR6lY8AFv1b2oysd1s
   hyTUlG1XuwKDUjNuZlVkQ71h/xo3aFupGLxpS+XpjezChmHMVRqE7T9l1
   lIPSxu5KCtFb+Y+7PXyXuihs6QNM4Ly60LXTF9FCYvRtkuLZXxRdQJOSB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="363071534"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="363071534"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 18:59:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="765072487"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="765072487"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2023 18:59:25 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 5/6] iommu: Replace device_lock() with group->mutex
Date:   Mon,  6 Mar 2023 10:58:03 +0800
Message-Id: <20230306025804.13912-6-baolu.lu@linux.intel.com>
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
index f8f400548a10..9fe6d149f281 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3011,14 +3011,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
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
@@ -3051,7 +3043,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
  * transition. Return failure if this isn't met.
  *
  * We need to consider the race between this and the device release path.
- * device_lock(dev) is used here to guarantee that the device release path
+ * group->mutex is used here to guarantee that the device release path
  * will not be entered at the same time.
  */
 static ssize_t iommu_group_store_type(struct iommu_group *group,
@@ -3077,60 +3069,27 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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
@@ -3141,14 +3100,9 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
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

