Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB069A8AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjBQJ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBQJ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:56:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761785F26D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676627774; x=1708163774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4ud28FUnLJpp84jaUtvJV6QcvsnVTvJ83pUv/Icsko=;
  b=l/a/eLMRDOuF+Z2hrozWDRCd33t83agHh7KXITgWApZvsZOtabGJ2UTp
   PFAloOlXW2j8RkqnPb56Wrzh35vQq9u0GpmV09O2sJpsJc2IitsBvN85H
   uUUxHdiKdFXcFVg1PRgFBtlmRWwG+ravDLV08vw17MepQUCIlz7JmGVcU
   yp64vg/30m5S6RkDQRribMUh1l/w+Gffxa2c9xAdXwlP0kjKolPsSapCw
   RJ7BU00SMM8MyDgtfPPx80Jb56jMgZyZ+tpNuLlJhotQB9KdTAJOOLXJX
   vI/WbT/tiOmrUV3rM+VDAc+IRu8eAP8R3ME5JqX5T0fINSvmGbNYNu/1b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331955202"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331955202"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999391218"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="999391218"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2023 01:56:10 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/6] iommu: Split iommu_group_remove_device() into helpers
Date:   Fri, 17 Feb 2023 17:47:32 +0800
Message-Id: <20230217094736.159005-3-baolu.lu@linux.intel.com>
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

So that code could be re-used by iommu_release_device() in the subsequent
change. No intention for functionality change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 64 +++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 28c6b088aedd..6247883991e2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1069,6 +1069,46 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
 
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
 /**
  * iommu_group_remove_device - remove a device from it's current group
  * @dev: device to be removed
@@ -1079,7 +1119,7 @@ EXPORT_SYMBOL_GPL(iommu_group_add_device);
 void iommu_group_remove_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
-	struct group_device *tmp_device, *device = NULL;
+	struct group_device *device;
 
 	if (!group)
 		return;
@@ -1087,27 +1127,11 @@ void iommu_group_remove_device(struct device *dev)
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

