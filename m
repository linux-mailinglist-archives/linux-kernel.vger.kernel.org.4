Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6161A197
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKDTvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiKDTvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:51:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F9D22CDC0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:51:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A0371FB;
        Fri,  4 Nov 2022 12:51:56 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 216DD3F5A1;
        Fri,  4 Nov 2022 12:51:48 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] iommu: Avoid races around device probe
Date:   Fri,  4 Nov 2022 19:51:43 +0000
Message-Id: <1946ef9f774851732eed78760a78ec40dbc6d178.1667591503.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have 3 different ways that __iommu_probe_device() may be
called, but no real guarantee that multiple callers can't tread on each
other, especially once asynchronous driver probe gets involved. It would
likely have taken a fair bit of luck to hit this previously, but commit
57365a04c921 ("iommu: Move bus setup to IOMMU device registration") ups
the odds since now it's not just omap-iommu that may trigger multiple
bus_iommu_probe() calls in parallel if probing asynchronously.

Add a lock to ensure we can't try to double-probe a device, and also
close some possible race windows to make sure we're truly robust against
trying to double-initialise a group via two different member devices.

Reported-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 65a3b3d886dc..959d895fc1df 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -283,13 +283,23 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
+	static DEFINE_MUTEX(iommu_probe_device_lock);
 	int ret;
 
 	if (!ops)
 		return -ENODEV;
-
-	if (!dev_iommu_get(dev))
-		return -ENOMEM;
+	/*
+	 * Serialise to avoid races between IOMMU drivers registering in
+	 * parallel and/or the "replay" calls from ACPI/OF code via client
+	 * driver probe. Once the latter have been cleaned up we should
+	 * probably be able to use device_lock() here to minimise the scope,
+	 * but for now enforcing a simple global ordering is fine.
+	 */
+	mutex_lock(&iommu_probe_device_lock);
+	if (!dev_iommu_get(dev)) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
 
 	if (!try_module_get(ops->owner)) {
 		ret = -EINVAL;
@@ -309,11 +319,14 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		ret = PTR_ERR(group);
 		goto out_release;
 	}
-	iommu_group_put(group);
 
+	mutex_lock(&group->mutex);
 	if (group_list && !group->default_domain && list_empty(&group->entry))
 		list_add_tail(&group->entry, group_list);
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
 
+	mutex_unlock(&iommu_probe_device_lock);
 	iommu_device_link(iommu_dev, dev);
 
 	return 0;
@@ -328,6 +341,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 err_free:
 	dev_iommu_free(dev);
 
+err_unlock:
+	mutex_unlock(&iommu_probe_device_lock);
+
 	return ret;
 }
 
@@ -1799,11 +1815,11 @@ int bus_iommu_probe(struct bus_type *bus)
 		return ret;
 
 	list_for_each_entry_safe(group, next, &group_list, entry) {
+		mutex_lock(&group->mutex);
+
 		/* Remove item from the list */
 		list_del_init(&group->entry);
 
-		mutex_lock(&group->mutex);
-
 		/* Try to allocate default domain */
 		probe_alloc_default_domain(bus, group);
 
-- 
2.36.1.dirty

