Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC11D69A8AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjBQJ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjBQJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:56:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7562FF2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676627776; x=1708163776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svzPQoaIiOVo1++kdQiL9mjZd3QRrwDo4zYQS1l6NZs=;
  b=L8PL5LIfdTA32AiWtGMez2yqtM0W+MfFCuUw7O2xE/hoU9R33JtJ9las
   DhaxIhK5k/uPijXGeB6VzegP7oTR0M+NJ5mLueRXiGbosSrLr+zmlGBul
   Zd1+/Nva01STpQJHRk9hyKL8CdTM1Qor+wNUoqEWOwP4E2DMmxjPCgieT
   WnACZ8JcTBvLUY87t2Hj+E5on66Q6EKafpPan2yyeg+Bwr7RDQFqtF/M+
   RWoEo9yfqUxJen5x8ihAzNHWpHbEv/JWrMg6kPz8Ijs/wMqBBido9NSTj
   JlHLpTaKNfWMyOnQsI3JMXvuJjCUVlSg6Ni699gW026PjhaoXXm8mMslt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331955232"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331955232"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:56:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999391225"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="999391225"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2023 01:56:13 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 3/6] iommu: Same critical region for device release and removal
Date:   Fri, 17 Feb 2023 17:47:33 +0800
Message-Id: <20230217094736.159005-4-baolu.lu@linux.intel.com>
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

In a non-driver context, it is crucial to ensure the consistency of a
device's iommu ops. Otherwise, it may result in a situation where a
device is released but it's iommu ops are still used.

Put the ops->release_device and __iommu_group_remove_device() in a some
group->mutext critical region, so that, as long as group->mutex is held
and the device is in its group's device list, its iommu ops are always
consistent.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6247883991e2..093692308b80 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -101,6 +101,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
+static struct group_device *
+__iommu_group_remove_device(struct iommu_group *group, struct device *dev);
+static void __iommu_group_release_device(struct iommu_group *group,
+					 struct group_device *grp_dev);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -466,18 +470,25 @@ int iommu_probe_device(struct device *dev)
 
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
 	ops = dev_iommu_ops(dev);
 	if (ops->release_device)
 		ops->release_device(dev);
+	device = __iommu_group_remove_device(group, dev);
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

