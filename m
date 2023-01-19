Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8688B67429D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjASTUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjASTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:20:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3752F9EE07
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:19:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B3E41758;
        Thu, 19 Jan 2023 11:19:23 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 312DD3F67D;
        Thu, 19 Jan 2023 11:18:41 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     hch@lst.de, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Date:   Thu, 19 Jan 2023 19:18:19 +0000
Message-Id: <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
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

Much as I'd like to remove iommu_present(), the final remaining users
are proving stubbornly difficult to clean up, so kick that can down
the road and just rework it to preserve the current behaviour without
depending on bus ops.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b189ed345057..a77d58e1b976 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1871,9 +1871,24 @@ int bus_iommu_probe(struct bus_type *bus)
 	return ret;
 }
 
+static int __iommu_present(struct device *dev, void *unused)
+{
+	return device_iommu_mapped(dev);
+}
+
+/**
+ * iommu_present() - make platform-specific assumptions about an IOMMU
+ * @bus: bus to check
+ *
+ * Do not use this function. You want device_iommu_mapped() instead.
+ *
+ * Return: true if some IOMMU is present for some device on the given bus. In
+ * general it may not be the only IOMMU, and it may not be for the device you
+ * are ultimately interested in.
+ */
 bool iommu_present(struct bus_type *bus)
 {
-	return bus->iommu_ops != NULL;
+	return bus_for_each_dev(bus, NULL, NULL, __iommu_present) > 0;
 }
 EXPORT_SYMBOL_GPL(iommu_present);
 
-- 
2.36.1.dirty

