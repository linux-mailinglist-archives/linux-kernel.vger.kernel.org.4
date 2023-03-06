Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9413A6AB4CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCFC7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCFC7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:59:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617C81165B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678071560; x=1709607560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r1yKdk6UOO9yO9Ew/Jiy3oqCAhgo4LhD3eUDU5kx0jM=;
  b=X72YTi6zFCO9TMth5sEwh5m4Np/LDHk3q9Mq3BvHlJo++2+mKA5p00r4
   n0jIXkZn9kEkYC25nhWkVbLirvf1bfK/Bs8D3h4MHsg8r4WCvLdCD+bZe
   RBHI6HYI2lJ40eUwjfgaF7ATBWl/th3ShkqLbzE9we9+WRKMFbQXslPg8
   BK5O8v1/NSyOZ0qqdlnlMq0FTXvR7APccetXZ6li24yl3Xq93Q+V1aDz8
   2r5TXP0FxcpLbgTtQajPhAPShU+rqdSpHzSVEJHJKtq9Wv1zmUTskm81v
   T5M3PYQckj5S6MtTAnDH8Vv0nVDteJ63XGWLDl2aXnpeGSt3mBkVNHKO4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="363071488"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="363071488"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 18:59:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="765072474"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="765072474"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2023 18:59:17 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 2/6] iommu: Split iommu_group_remove_device() into helpers
Date:   Mon,  6 Mar 2023 10:58:00 +0800
Message-Id: <20230306025804.13912-3-baolu.lu@linux.intel.com>
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

So that code could be re-used by iommu_release_device() in the subsequent
change. No intention for functionality change.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 64 +++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 80211bf08c0d..bd9b293e07a8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -465,6 +465,46 @@ int iommu_probe_device(struct device *dev)
 
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
@@ -1080,7 +1120,7 @@ EXPORT_SYMBOL_GPL(iommu_group_add_device);
 void iommu_group_remove_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
-	struct group_device *tmp_device, *device = NULL;
+	struct group_device *device;
 
 	if (!group)
 		return;
@@ -1088,27 +1128,11 @@ void iommu_group_remove_device(struct device *dev)
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

