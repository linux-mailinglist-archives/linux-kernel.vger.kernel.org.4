Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3A6C438B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCVGt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCVGtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:49:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A482B367DE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679467784; x=1711003784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hPoFlztxY1xJolSJngRYhbNVr0XuleACaIwXyUztnXE=;
  b=aBG04VrZKokFBcyU+1BnPnYUTzhzioux6cvGYIBESxAHe/OhgAQvYKSD
   XUOCzliuCpMqUYC68C2iuMDVQz/ynD0WwHnl+Xpi3QoENSXKuzk6R/hn7
   UbZkZtK/0UBLaBiBjZ5mY+P3SdTRjwHw7N1vK7gIu1sYhzm9OcAqzJTXL
   xrhG0LIbr6epBSnhUkEQ43DxYJCINvdSa6N+KPsyLPmkLocwTgr5l1J2K
   hifFuCmpBRr7w2kg/kaKEjvq0PKd6tX86lQMmVOu9f4KP/jmZ8sVNhuQw
   W6cyKaRvkyvTMnvV/o9TqhC9xWh3pysq5NCScg3kKdsT1BNRMI7BGwnlD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="337866752"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="337866752"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="659080417"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="659080417"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2023 23:49:41 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 3/6] iommu: Same critical region for device release and removal
Date:   Wed, 22 Mar 2023 14:49:53 +0800
Message-Id: <20230322064956.263419-4-baolu.lu@linux.intel.com>
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

In a non-driver context, it is crucial to ensure the consistency of a
device's iommu ops. Otherwise, it may result in a situation where a
device is released but it's iommu ops are still used.

Put the ops->release_device and __iommu_group_remove_device() in a same
group->mutext critical region, so that, as long as group->mutex is held
and the device is in its group's device list, its iommu ops are always
consistent. Add check of group ownership if the released device is the
last one.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 43db48323370..6d27fd585e75 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -495,18 +495,44 @@ static void __iommu_group_release_device(struct iommu_group *group,
 
 void iommu_release_device(struct device *dev)
 {
+	struct iommu_group *group = dev->iommu_group;
+	struct group_device *device;
 	const struct iommu_ops *ops;
 
-	if (!dev->iommu)
+	if (!dev->iommu || !group)
 		return;
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
+	mutex_lock(&group->mutex);
+	device = __iommu_group_remove_device(group, dev);
+
+	/*
+	 * If the group has become empty then ownership must have been released,
+	 * and the current domain must be set back to NULL or the default
+	 * domain.
+	 */
+	if (list_empty(&group->devices))
+		WARN_ON(group->owner_cnt ||
+			group->domain != group->default_domain);
+
+	/*
+	 * release_device() must stop using any attached domain on the device.
+	 * If there are still other devices in the group they are not effected
+	 * by this callback.
+	 *
+	 * The IOMMU driver must set the device to either an identity or
+	 * blocking translation and stop using any domain pointer, as it is
+	 * going to be freed.
+	 */
 	ops = dev_iommu_ops(dev);
 	if (ops->release_device)
 		ops->release_device(dev);
+	mutex_unlock(&group->mutex);
+
+	if (device)
+		__iommu_group_release_device(group, device);
 
-	iommu_group_remove_device(dev);
 	module_put(ops->owner);
 	dev_iommu_free(dev);
 }
-- 
2.34.1

