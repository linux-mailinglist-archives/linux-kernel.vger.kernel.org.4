Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356D767D422
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjAZS0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjAZS0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:26:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B767559B46
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:26:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53EA3C14;
        Thu, 26 Jan 2023 10:27:16 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 613063F71E;
        Thu, 26 Jan 2023 10:26:33 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de,
        jgg@nvidia.com, baolu.lu@linux.intel.com
Subject: [PATCH v2 4/8] iommu: Factor out some helpers
Date:   Thu, 26 Jan 2023 18:26:19 +0000
Message-Id: <959a1e8d598c0a82f94123e017cafb273784f848.1674753627.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1674753627.git.robin.murphy@arm.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern for picking the first device out of the group list is
repeated a few times now, so it's clearly worth factoring out to hide
the group_device detail from places that don't need to know. Similarly,
the safety check for dev_iommu_ops() at public interfaces starts looking
a bit repetitive, and might not be completely obvious at first glance,
so let's factor that out for clarity as well, in preparation for more
uses of both.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: - Add dev_iommu_ops_valid() helper
    - Add lockdep assertion [Jason]

 drivers/iommu/iommu.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 77f076030995..440bb3b7bded 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -284,6 +284,12 @@ static void dev_iommu_free(struct device *dev)
 	kfree(param);
 }
 
+/* Only needed in public APIs which allow unchecked devices for convenience */
+static bool dev_iommu_ops_valid(struct device *dev)
+{
+	return dev->iommu && dev->iommu->iommu_dev;
+}
+
 static u32 dev_iommu_get_max_pasids(struct device *dev)
 {
 	u32 max_pasids = 0, bits = 0;
@@ -1096,6 +1102,12 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
+static struct device *iommu_group_first_dev(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
+	return list_first_entry(&group->devices, struct group_device, list)->dev;
+}
+
 static int iommu_group_device_count(struct iommu_group *group)
 {
 	struct group_device *entry;
@@ -1907,7 +1919,7 @@ bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	const struct iommu_ops *ops;
 
-	if (!dev->iommu || !dev->iommu->iommu_dev)
+	if (!dev_iommu_ops_valid(dev))
 		return false;
 
 	ops = dev_iommu_ops(dev);
@@ -2770,8 +2782,8 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
  */
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-	if (dev->iommu && dev->iommu->iommu_dev) {
-		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
+	if (dev_iommu_ops_valid(dev)) {
+		const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 		if (ops->dev_enable_feat)
 			return ops->dev_enable_feat(dev, feat);
@@ -2786,8 +2798,8 @@ EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
  */
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-	if (dev->iommu && dev->iommu->iommu_dev) {
-		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
+	if (dev_iommu_ops_valid(dev)) {
+		const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 		if (ops->dev_disable_feat)
 			return ops->dev_disable_feat(dev, feat);
@@ -2816,7 +2828,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 				       struct device *prev_dev, int type)
 {
 	struct iommu_domain *prev_dom;
-	struct group_device *grp_dev;
 	int ret, dev_def_dom;
 	struct device *dev;
 
@@ -2848,8 +2859,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	}
 
 	/* Since group has only one device */
-	grp_dev = list_first_entry(&group->devices, struct group_device, list);
-	dev = grp_dev->dev;
+	dev = iommu_group_first_dev(group);
 
 	if (prev_dev != dev) {
 		dev_err_ratelimited(prev_dev, "Cannot change default domain: Device has been changed\n");
@@ -2946,7 +2956,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
-	struct group_device *grp_dev;
 	struct device *dev;
 	int ret, req_type;
 
@@ -2981,8 +2990,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	}
 
 	/* Since group has only one device */
-	grp_dev = list_first_entry(&group->devices, struct group_device, list);
-	dev = grp_dev->dev;
+	dev = iommu_group_first_dev(group);
 	get_device(dev);
 
 	/*
@@ -3107,21 +3115,18 @@ void iommu_device_unuse_default_domain(struct device *dev)
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 {
-	struct group_device *dev =
-		list_first_entry(&group->devices, struct group_device, list);
+	struct device *dev = iommu_group_first_dev(group);
 
 	if (group->blocking_domain)
 		return 0;
 
-	group->blocking_domain =
-		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
+	group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_BLOCKED);
 	if (!group->blocking_domain) {
 		/*
 		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
 		 * create an empty domain instead.
 		 */
-		group->blocking_domain = __iommu_domain_alloc(
-			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
+		group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
 		if (!group->blocking_domain)
 			return -EINVAL;
 	}
-- 
2.36.1.dirty

