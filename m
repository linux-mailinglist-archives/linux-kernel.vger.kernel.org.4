Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465F86C4389
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCVGty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCVGts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:49:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E61425E16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679467782; x=1711003782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uNsJ5iL/12Ebvb4ULP39bZOjdt78s0sC7JK9D/nWeI8=;
  b=nsUX9bYD2DpX7olHGN04k+04liza5iIcQfq0BRWVcWWhhCq2CmWOXP16
   OM2cFxwEihXAl5nRufdgKlSoKYqYQ5UiW3C7IiUKD3EMpQR6wcTCoxB+x
   8QTCvOQEQrJf4COt5f3zQmjgDrdWPYriI1cQULiGLcwtvj7IMjK956871
   ZKP8be7Ixiqi5o237sdILGvQWIfzRcvPj7udQr/l6jgZwzKVRK+SRC1mr
   81MNRIZqXjOuoF+NIqSosgyo+siLs9kaBW452Z1R4iknzyAkWIpNpscFz
   hEOYLOE9KNH65T3Nz7Q27EgOzezOrQ0GH8/8vdB/nbsMzNbA/L46V3vii
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="337866739"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="337866739"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="659080394"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="659080394"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2023 23:49:39 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 2/6] iommu: Split iommu_group_remove_device() into helpers
Date:   Wed, 22 Mar 2023 14:49:52 +0800
Message-Id: <20230322064956.263419-3-baolu.lu@linux.intel.com>
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

So that code could be re-used by iommu_release_device() in the subsequent
change. No intention for functionality change.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 64 +++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10db680acaed..43db48323370 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -453,6 +453,46 @@ int iommu_probe_device(struct device *dev)
 
 }
 
+/*
+ * Remove a device from a group's device list and return the group device
+ * if successful.
+ */
+static struct group_device *
+__iommu_group_remove_device(struct iommu_group *group, struct device *dev)
+{
+	struct group_device *device;
+
+	lockdep_assert_held(&group->mutex);
+	list_for_each_entry(device, &group->devices, list) {
+		if (device->dev == dev) {
+			list_del(&device->list);
+			return device;
+		}
+	}
+
+	return NULL;
+}
+
+/*
+ * Release a device from its group and decrements the iommu group reference
+ * count.
+ */
+static void __iommu_group_release_device(struct iommu_group *group,
+					 struct group_device *grp_dev)
+{
+	struct device *dev = grp_dev->dev;
+
+	sysfs_remove_link(group->devices_kobj, grp_dev->name);
+	sysfs_remove_link(&dev->kobj, "iommu_group");
+
+	trace_remove_device_from_group(group->id, dev);
+
+	kfree(grp_dev->name);
+	kfree(grp_dev);
+	dev->iommu_group = NULL;
+	kobject_put(group->devices_kobj);
+}
+
 void iommu_release_device(struct device *dev)
 {
 	const struct iommu_ops *ops;
@@ -1068,7 +1108,7 @@ EXPORT_SYMBOL_GPL(iommu_group_add_device);
 void iommu_group_remove_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
-	struct group_device *tmp_device, *device = NULL;
+	struct group_device *device;
 
 	if (!group)
 		return;
@@ -1076,27 +1116,11 @@ void iommu_group_remove_device(struct device *dev)
 	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
 	mutex_lock(&group->mutex);
-	list_for_each_entry(tmp_device, &group->devices, list) {
-		if (tmp_device->dev == dev) {
-			device = tmp_device;
-			list_del(&device->list);
-			break;
-		}
-	}
+	device = __iommu_group_remove_device(group, dev);
 	mutex_unlock(&group->mutex);
 
-	if (!device)
-		return;
-
-	sysfs_remove_link(group->devices_kobj, device->name);
-	sysfs_remove_link(&dev->kobj, "iommu_group");
-
-	trace_remove_device_from_group(group->id, dev);
-
-	kfree(device->name);
-	kfree(device);
-	dev->iommu_group = NULL;
-	kobject_put(group->devices_kobj);
+	if (device)
+		__iommu_group_release_device(group, device);
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-- 
2.34.1

