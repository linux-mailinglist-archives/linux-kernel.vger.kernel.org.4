Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F567429E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjASTU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjASTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:20:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37E819EE20
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:19:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9188B1BB2;
        Thu, 19 Jan 2023 11:19:24 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D00E3F67D;
        Thu, 19 Jan 2023 11:18:42 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     hch@lst.de, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] iommu: Validate that devices match domains
Date:   Thu, 19 Jan 2023 19:18:20 +0000
Message-Id: <3690e5e6b53f6bfecd56f2e0aa77d2915f2e2588.1673978700.git.robin.murphy@arm.com>
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

Before we can allow drivers to coexist, we need to make sure that one
driver's domain ops can't misinterpret another driver's dev_iommu_priv
data. To that end, add a token to the domain so we can remember how it
was allocated - for now this may as well be the device ops. We can trust
ourselves for internal default domain attachment, so add the check where
it covers both the external attach interfaces.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 13 +++++++++----
 include/linux/iommu.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a77d58e1b976..bc53ffbba4de 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1941,20 +1941,22 @@ EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type)
 {
+	const struct iommu_ops *ops = bus ? bus->iommu_ops : NULL;
 	struct iommu_domain *domain;
 
-	if (bus == NULL || bus->iommu_ops == NULL)
+	if (!ops)
 		return NULL;
 
-	domain = bus->iommu_ops->domain_alloc(type);
+	domain = ops->domain_alloc(type);
 	if (!domain)
 		return NULL;
 
 	domain->type = type;
+	domain->owner = ops;
 	/* Assume all sizes by default; the driver may override this later */
-	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
+	domain->pgsize_bitmap = ops->pgsize_bitmap;
 	if (!domain->ops)
-		domain->ops = bus->iommu_ops->default_domain_ops;
+		domain->ops = ops->default_domain_ops;
 
 	if (iommu_is_dma_domain(domain) && iommu_get_dma_cookie(domain)) {
 		iommu_domain_free(domain);
@@ -2128,6 +2130,9 @@ static int iommu_group_do_attach_device(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
 
+	if (dev_iommu_ops(dev) != domain->owner)
+		return -EINVAL;
+
 	return __iommu_attach_device(domain, dev);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d37bf28faf82..35af9d4e3969 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -95,6 +95,7 @@ struct iommu_domain_geometry {
 struct iommu_domain {
 	unsigned type;
 	const struct iommu_domain_ops *ops;
+	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
-- 
2.36.1.dirty

