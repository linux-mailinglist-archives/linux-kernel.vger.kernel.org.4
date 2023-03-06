Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861A86AB4D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCFC73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCFC7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:59:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F871114C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678071562; x=1709607562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=23OLppNDX/QUue37RTrJRL+8G3hSt1KtGJZMXHrLeEU=;
  b=J0+weIw6Mci7I/ufJQBR/7s3vJ+jZYM32NCgzjSl6TN2jE8mvQgZ8Qpj
   LHh6V6c8K+v1mVXZH8yb8VXofw/V8NKv/7virFc+avbZq50m8g3Q34awR
   o2xwiZkyaM90FTKipEr5xW33gt0h91yFLXK+GNs2DBsCXunNt9re710ub
   a+0DY+18bsXsivsI/AZQeLq0/nJWqqCQnpYI8thvO3ngeS0nCvV2gYsC8
   xpxC91gFvThvZQyGyLKQeYDss8e8/55lAjIIRNVqbuZd9KQH3N7YQkUzF
   ya/M/u8qLUwPKPIJ05jKp1YO9jwggI8zJ5RL+wHNYifV3DoJ/2aCMOPbh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="363071513"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="363071513"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 18:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="765072478"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="765072478"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2023 18:59:20 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 3/6] iommu: Same critical region for device release and removal
Date:   Mon,  6 Mar 2023 10:58:01 +0800
Message-Id: <20230306025804.13912-4-baolu.lu@linux.intel.com>
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

In a non-driver context, it is crucial to ensure the consistency of a
device's iommu ops. Otherwise, it may result in a situation where a
device is released but it's iommu ops are still used.

Put the ops->release_device and __iommu_group_remove_device() in a some
group->mutext critical region, so that, as long as group->mutex is held
and the device is in its group's device list, its iommu ops are always
consistent. Add check of group ownership if the released device is the
last one.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bd9b293e07a8..0bcd9625090d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -507,18 +507,44 @@ static void __iommu_group_release_device(struct iommu_group *group,
 
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

