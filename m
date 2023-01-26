Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B567D426
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjAZS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjAZS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:26:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DA1A6D347
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:26:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C36E1152B;
        Thu, 26 Jan 2023 10:27:22 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D28483F71E;
        Thu, 26 Jan 2023 10:26:39 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de,
        jgg@nvidia.com, baolu.lu@linux.intel.com
Subject: [PATCH v2 8/8] iommu: Clean up open-coded ownership checks
Date:   Thu, 26 Jan 2023 18:26:23 +0000
Message-Id: <af9d39475ac0811650e617983d7e7859c7b0e856.1674753627.git.robin.murphy@arm.com>
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

Some drivers already implement their own defence against the possibility
of being given someone else's device. Since this is now taken care of by
the core code (and via a slightly different path from the original
fwspec-based idea), let's clean them up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: No change, but I'll note here that it's really about the fwspec->ops
    checks; the !fwspec clauses are just going along for the ride where
    that's clearly impossible as well. I plan to sweep for other
    redundant checks in future when looking at the relevant flows.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  9 +--------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 14 ++------------
 drivers/iommu/mtk_iommu.c                   |  7 +------
 drivers/iommu/mtk_iommu_v1.c                |  3 ---
 drivers/iommu/sprd-iommu.c                  |  8 +-------
 drivers/iommu/virtio-iommu.c                |  3 ---
 7 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab160198edd6..cb05d9771192 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2642,9 +2642,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	struct arm_smmu_master *master;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!fwspec || fwspec->ops != &arm_smmu_ops)
-		return ERR_PTR(-ENODEV);
-
 	if (WARN_ON_ONCE(dev_iommu_priv_get(dev)))
 		return ERR_PTR(-EBUSY);
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 607f06af01b6..235550db0d59 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1118,11 +1118,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu;
 	int ret;
 
-	if (!fwspec || fwspec->ops != &arm_smmu_ops) {
-		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
-		return -ENXIO;
-	}
-
 	/*
 	 * FIXME: The arch/arm DMA API code tries to attach devices to its own
 	 * domains between of_xlate() and probe_device() - we have no way to cope
@@ -1352,10 +1347,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		fwspec = dev_iommu_fwspec_get(dev);
 		if (ret)
 			goto out_free;
-	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
-		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 	} else {
-		return ERR_PTR(-ENODEV);
+		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 	}
 
 	ret = -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index d7be3adee426..3fe02720ab29 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -79,16 +79,6 @@ static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
 
 static const struct iommu_ops qcom_iommu_ops;
 
-static struct qcom_iommu_dev * to_iommu(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (!fwspec || fwspec->ops != &qcom_iommu_ops)
-		return NULL;
-
-	return dev_iommu_priv_get(dev);
-}
-
 static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid)
 {
 	struct qcom_iommu_dev *qcom_iommu = d->iommu;
@@ -361,7 +351,7 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 
 static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
+	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	int ret;
 
@@ -486,7 +476,7 @@ static bool qcom_iommu_capable(struct device *dev, enum iommu_cap cap)
 
 static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
+	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
 	struct device_link *link;
 
 	if (!qcom_iommu)
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d5a4955910ff..ce19a2a21e2a 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -776,16 +776,11 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_data *data;
+	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct device_link *link;
 	struct device *larbdev;
 	unsigned int larbid, larbidx, i;
 
-	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
-		return ERR_PTR(-ENODEV); /* Not a iommu client device */
-
-	data = dev_iommu_priv_get(dev);
-
 	if (!MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
 		return &data->iommu;
 
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 78d0a84c704f..328833823181 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -478,9 +478,6 @@ static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
 		idx++;
 	}
 
-	if (!fwspec || fwspec->ops != &mtk_iommu_v1_ops)
-		return ERR_PTR(-ENODEV); /* Not a iommu client device */
-
 	data = dev_iommu_priv_get(dev);
 
 	/* Link the consumer device with the smi-larb device(supplier) */
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index ae94d74b73f4..85378f7cfd1f 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -358,13 +358,7 @@ static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
 
 static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct sprd_iommu_device *sdev;
-
-	if (!fwspec || fwspec->ops != &sprd_iommu_ops)
-		return ERR_PTR(-ENODEV);
-
-	sdev = dev_iommu_priv_get(dev);
+	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
 
 	return &sdev->iommu;
 }
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 5b8fe9bfa9a5..59f1abd6ee53 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -945,9 +945,6 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	struct viommu_dev *viommu = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!fwspec || fwspec->ops != &viommu_ops)
-		return ERR_PTR(-ENODEV);
-
 	viommu = viommu_get_by_fwnode(fwspec->iommu_fwnode);
 	if (!viommu)
 		return ERR_PTR(-ENODEV);
-- 
2.36.1.dirty

