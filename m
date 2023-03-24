Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613E86C7D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjCXLLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjCXLLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:11:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01F6919127
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:11:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC58E11FB;
        Fri, 24 Mar 2023 04:12:18 -0700 (PDT)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D5AD3F6C4;
        Fri, 24 Mar 2023 04:11:33 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2] iommu/rockchip: Add missing set_platform_dma_ops callback
Date:   Fri, 24 Mar 2023 11:11:27 +0000
Message-Id: <20230324111127.221640-1-steven.price@arm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to exynos, we need a set_platform_dma_ops() callback for proper
operation on ARM 32 bit after recent changes in the IOMMU framework
(detach ops removal). But also the use of a NULL domain is confusing.

Rework the code to have a singleton rk_identity_domain which is assigned
to domain when using an identity mapping rather than "detaching". This
makes the code easier to reason about.

Signed-off-by: Steven Price <steven.price@arm.com>
---
Changes since v1[1]:

 * Reworked the code to avoid a NULL domain, instead a singleton
   rk_identity_domain is used instead. The 'detach' language is no
   longer used.

[1] https://lore.kernel.org/r/20230315164152.333251-1-steven.price%40arm.com

 drivers/iommu/rockchip-iommu.c | 50 ++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index f30db22ea5d7..437541004994 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -124,6 +124,7 @@ struct rk_iommudata {
 
 static struct device *dma_dev;
 static const struct rk_iommu_ops *rk_ops;
+static struct iommu_domain rk_identity_domain;
 
 static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
 				  unsigned int count)
@@ -980,26 +981,27 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 	return ret;
 }
 
-static void rk_iommu_detach_device(struct iommu_domain *domain,
-				   struct device *dev)
+static int rk_iommu_identity_attach(struct iommu_domain *identity_domain,
+				    struct device *dev)
 {
 	struct rk_iommu *iommu;
-	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	struct rk_iommu_domain *rk_domain;
 	unsigned long flags;
 	int ret;
 
 	/* Allow 'virtual devices' (eg drm) to detach from domain */
 	iommu = rk_iommu_from_dev(dev);
 	if (!iommu)
-		return;
+		return -ENODEV;
+
+	rk_domain = to_rk_domain(iommu->domain);
 
 	dev_dbg(dev, "Detaching from iommu domain\n");
 
-	/* iommu already detached */
-	if (iommu->domain != domain)
-		return;
+	if (iommu->domain == identity_domain)
+		return 0;
 
-	iommu->domain = NULL;
+	iommu->domain = identity_domain;
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_del_init(&iommu->node);
@@ -1011,7 +1013,25 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 		rk_iommu_disable(iommu);
 		pm_runtime_put(iommu->dev);
 	}
+
+	return 0;
+}
+
+static struct iommu_domain_ops rk_identity_ops = {
+	.attach_dev = rk_iommu_identity_attach,
+};
+
+static struct iommu_domain rk_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &rk_identity_ops,
+};
+
+#ifdef CONFIG_ARM
+static void rk_iommu_set_platform_dma(struct device *dev)
+{
+	WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
 }
+#endif
 
 static int rk_iommu_attach_device(struct iommu_domain *domain,
 		struct device *dev)
@@ -1035,8 +1055,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (iommu->domain == domain)
 		return 0;
 
-	if (iommu->domain)
-		rk_iommu_detach_device(iommu->domain, dev);
+	ret = rk_iommu_identity_attach(&rk_identity_domain, dev);
+	if (ret)
+		return ret;
 
 	iommu->domain = domain;
 
@@ -1050,7 +1071,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	ret = rk_iommu_enable(iommu);
 	if (ret)
-		rk_iommu_detach_device(iommu->domain, dev);
+		WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
 
 	pm_runtime_put(iommu->dev);
 
@@ -1061,6 +1082,9 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 {
 	struct rk_iommu_domain *rk_domain;
 
+	if (type == IOMMU_DOMAIN_IDENTITY)
+		return &rk_identity_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
@@ -1176,6 +1200,7 @@ static int rk_iommu_of_xlate(struct device *dev,
 	iommu_dev = of_find_device_by_node(args->np);
 
 	data->iommu = platform_get_drvdata(iommu_dev);
+	data->iommu->domain = &rk_identity_domain;
 	dev_iommu_priv_set(dev, data);
 
 	platform_device_put(iommu_dev);
@@ -1188,6 +1213,9 @@ static const struct iommu_ops rk_iommu_ops = {
 	.probe_device = rk_iommu_probe_device,
 	.release_device = rk_iommu_release_device,
 	.device_group = rk_iommu_device_group,
+#ifdef CONFIG_ARM
+	.set_platform_dma_ops = rk_iommu_set_platform_dma,
+#endif
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.39.2

