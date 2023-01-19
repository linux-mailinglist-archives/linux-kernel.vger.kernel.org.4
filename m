Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A07D67429F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjASTUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjASTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:20:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 376A89EE12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:19:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF9001BCB;
        Thu, 19 Jan 2023 11:19:26 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AAC73F67D;
        Thu, 19 Jan 2023 11:18:44 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     hch@lst.de, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] iommu: Switch __iommu_domain_alloc() to device ops
Date:   Thu, 19 Jan 2023 19:18:22 +0000
Message-Id: <25ea8128b9228f9893507ad5a764ff25db5961a0.1673978700.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1673978700.git.robin.murphy@arm.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all the places we allocate default domains, we have (or can easily
get hold of) a device from which to resolve the right IOMMU ops; only
the public iommu_domain_alloc() interface actually depends on bus ops.
Reworking the public API is a big enough mission in its own right, but
in the meantime we can still decouple it from bus ops internally to move
forward.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 57 ++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5b37766a09e2..1a31d94adff5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -88,7 +88,7 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
-static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
+static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
@@ -1620,15 +1620,15 @@ static int iommu_get_def_domain_type(struct device *dev)
 	return 0;
 }
 
-static int iommu_group_alloc_default_domain(struct bus_type *bus,
-					    struct iommu_group *group,
+static int iommu_group_alloc_default_domain(struct iommu_group *group,
+					    struct device *dev,
 					    unsigned int type)
 {
 	struct iommu_domain *dom;
 
-	dom = __iommu_domain_alloc(bus, type);
+	dom = __iommu_domain_alloc(dev, type);
 	if (!dom && type != IOMMU_DOMAIN_DMA) {
-		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
+		dom = __iommu_domain_alloc(dev, IOMMU_DOMAIN_DMA);
 		if (dom)
 			pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
 				type, group->name);
@@ -1653,7 +1653,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 
 	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
 
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
+	return iommu_group_alloc_default_domain(group, dev, type);
 }
 
 /**
@@ -1766,8 +1766,7 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
 	return 0;
 }
 
-static void probe_alloc_default_domain(struct bus_type *bus,
-				       struct iommu_group *group)
+static void probe_alloc_default_domain(struct iommu_group *group)
 {
 	struct __group_domain_type gtype;
 
@@ -1777,10 +1776,12 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 	__iommu_group_for_each_dev(group, &gtype,
 				   probe_get_default_domain_type);
 
-	if (!gtype.type)
+	if (!gtype.type) {
 		gtype.type = iommu_def_domain_type;
+		gtype.dev = iommu_group_first_dev(group);
+	}
 
-	iommu_group_alloc_default_domain(bus, group, gtype.type);
+	iommu_group_alloc_default_domain(group, gtype.dev, gtype.type);
 
 }
 
@@ -1854,7 +1855,7 @@ int bus_iommu_probe(struct bus_type *bus)
 		list_del_init(&group->entry);
 
 		/* Try to allocate default domain */
-		probe_alloc_default_domain(bus, group);
+		probe_alloc_default_domain(group);
 
 		if (!group->default_domain) {
 			mutex_unlock(&group->mutex);
@@ -1943,15 +1944,12 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
-static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
+static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
 						 unsigned type)
 {
-	const struct iommu_ops *ops = bus ? bus->iommu_ops : NULL;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
-	if (!ops)
-		return NULL;
-
 	domain = ops->domain_alloc(type);
 	if (!domain)
 		return NULL;
@@ -1970,9 +1968,28 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	return domain;
 }
 
+static int __iommu_domain_alloc_dev(struct device *dev, void *data)
+{
+	struct device **alloc_dev = data;
+
+	if (!device_iommu_mapped(dev))
+		return 0;
+
+	WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) != dev_iommu_ops(*alloc_dev),
+		"Multiple IOMMU drivers present, which the public IOMMU API can't fully support yet. This may not work as expected, sorry!\n");
+
+	*alloc_dev = dev;
+	return 0;
+}
+
 struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 {
-	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
+	struct device *dev = NULL;
+
+	if (bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev))
+		return NULL;
+
+	return __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
@@ -2918,7 +2935,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	}
 
 	/* Sets group->default_domain to the newly allocated domain */
-	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
+	ret = iommu_group_alloc_default_domain(group, dev, type);
 	if (ret)
 		goto out;
 
@@ -3132,13 +3149,13 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 	if (group->blocking_domain)
 		return 0;
 
-	group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_BLOCKED);
+	group->blocking_domain = __iommu_domain_alloc(dev, IOMMU_DOMAIN_BLOCKED);
 	if (!group->blocking_domain) {
 		/*
 		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
 		 * create an empty domain instead.
 		 */
-		group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
+		group->blocking_domain = __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
 		if (!group->blocking_domain)
 			return -EINVAL;
 	}
-- 
2.36.1.dirty

