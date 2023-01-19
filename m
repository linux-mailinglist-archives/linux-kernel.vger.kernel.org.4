Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16556742A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjASTVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjASTUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:20:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE63F966F7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:19:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E3611C00;
        Thu, 19 Jan 2023 11:19:33 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E1103F67D;
        Thu, 19 Jan 2023 11:18:50 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     hch@lst.de, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] iommu: Pass device through ops->domain_alloc
Date:   Thu, 19 Jan 2023 19:18:26 +0000
Message-Id: <893b2ef069fad5276d015a7606c01a0da315f9da.1673978700.git.robin.murphy@arm.com>
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

With __iommu_domain_alloc() now aware of a device, we can propagate that
through to the drivers so that they can also pick up their instance data
without having to wait until they see the device attach.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/iommu.c                   | 3 ++-
 drivers/iommu/apple-dart.c                  | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ++-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 3 ++-
 drivers/iommu/exynos-iommu.c                | 3 ++-
 drivers/iommu/fsl_pamu_domain.c             | 3 ++-
 drivers/iommu/intel/iommu.c                 | 3 ++-
 drivers/iommu/iommu.c                       | 4 ++--
 drivers/iommu/ipmmu-vmsa.c                  | 3 ++-
 drivers/iommu/msm_iommu.c                   | 3 ++-
 drivers/iommu/mtk_iommu.c                   | 3 ++-
 drivers/iommu/mtk_iommu_v1.c                | 3 ++-
 drivers/iommu/omap-iommu.c                  | 3 ++-
 drivers/iommu/rockchip-iommu.c              | 3 ++-
 drivers/iommu/s390-iommu.c                  | 3 ++-
 drivers/iommu/sprd-iommu.c                  | 3 ++-
 drivers/iommu/sun50i-iommu.c                | 3 ++-
 drivers/iommu/tegra-gart.c                  | 3 ++-
 drivers/iommu/tegra-smmu.c                  | 3 ++-
 drivers/iommu/virtio-iommu.c                | 3 ++-
 include/linux/iommu.h                       | 3 ++-
 22 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..f5bc61a4c3d4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2084,7 +2084,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	return NULL;
 }
 
-static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *amd_iommu_domain_alloc(struct device *dev,
+						   unsigned type)
 {
 	struct protection_domain *domain;
 
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 4f4a323be0d0..95f3aa323a99 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -576,7 +576,8 @@ static void apple_dart_release_device(struct device *dev)
 	kfree(cfg);
 }
 
-static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
+static struct iommu_domain *apple_dart_domain_alloc(struct device *dev,
+						    unsigned int type)
 {
 	struct apple_dart_domain *dart_domain;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index cb05d9771192..453e9dbf4920 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2005,7 +2005,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
+static struct iommu_domain *arm_smmu_domain_alloc(struct device *dev,
+						  unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 235550db0d59..86c9c6df18ae 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -851,7 +851,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	arm_smmu_rpm_put(smmu);
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
+static struct iommu_domain *arm_smmu_domain_alloc(struct device *dev,
+						  unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index b2d3d309be1e..7b9daacf1697 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -309,7 +309,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	return ret;
 }
 
-static struct iommu_domain *qcom_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *qcom_iommu_domain_alloc(struct device *dev,
+						    unsigned type)
 {
 	struct qcom_iommu_domain *qcom_domain;
 
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b0cde2211987..54f9d10a9fb1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -816,7 +816,8 @@ static inline void exynos_iommu_set_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
 				   DMA_TO_DEVICE);
 }
 
-static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *exynos_iommu_domain_alloc(struct device *dev,
+						      unsigned type)
 {
 	struct exynos_iommu_domain *domain;
 	dma_addr_t handle;
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 4408ac3c49b6..69578e574af0 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -192,7 +192,8 @@ static void fsl_pamu_domain_free(struct iommu_domain *domain)
 	kmem_cache_free(fsl_pamu_domain_cache, dma_domain);
 }
 
-static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
+static struct iommu_domain *fsl_pamu_domain_alloc(struct device *dev,
+						  unsigned type)
 {
 	struct fsl_dma_domain *dma_domain;
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..590594a0d6e1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4157,7 +4157,8 @@ static struct iommu_domain blocking_domain = {
 	}
 };
 
-static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *intel_iommu_domain_alloc(struct device *dev,
+						     unsigned type)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8997b8f2e79f..521f6f780294 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1955,7 +1955,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
-	domain = ops->domain_alloc(type);
+	domain = ops->domain_alloc(dev, type);
 	if (!domain)
 		return NULL;
 
@@ -3456,7 +3456,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
-	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+	domain = ops->domain_alloc(dev, IOMMU_DOMAIN_SVA);
 	if (!domain)
 		return NULL;
 
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 76e51d8e3732..7bb6c2fd3214 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -567,7 +567,8 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
  * IOMMU Operations
  */
 
-static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
+static struct iommu_domain *ipmmu_domain_alloc(struct device *dev,
+					       unsigned type)
 {
 	struct ipmmu_vmsa_domain *domain;
 
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index c60624910872..1d9704e7c75f 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -302,7 +302,8 @@ static void __program_context(void __iomem *base, int ctx,
 	SET_M(base, ctx, 1);
 }
 
-static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *msm_iommu_domain_alloc(struct device *dev,
+						   unsigned type)
 {
 	struct msm_priv *priv;
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 005136a4cc36..711716c8dcdf 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -632,7 +632,8 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 	return 0;
 }
 
-static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *mtk_iommu_domain_alloc(struct device *dev,
+						   unsigned type)
 {
 	struct mtk_iommu_domain *dom;
 
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index dff8ea0af884..3d1e0635f9b3 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -270,7 +270,8 @@ static int mtk_iommu_v1_domain_finalise(struct mtk_iommu_v1_data *data)
 	return 0;
 }
 
-static struct iommu_domain *mtk_iommu_v1_domain_alloc(unsigned type)
+static struct iommu_domain *mtk_iommu_v1_domain_alloc(struct device *dev,
+						      unsigned type)
 {
 	struct mtk_iommu_v1_domain *dom;
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 2fd7702c6709..19a22ba1860d 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1566,7 +1566,8 @@ static void omap_iommu_detach_dev(struct iommu_domain *domain,
 	spin_unlock(&omap_domain->lock);
 }
 
-static struct iommu_domain *omap_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *omap_iommu_domain_alloc(struct device *dev,
+						    unsigned type)
 {
 	struct omap_iommu_domain *omap_domain;
 
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index a68eadd64f38..50b17a096ea5 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1057,7 +1057,8 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
-static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *rk_iommu_domain_alloc(struct device *dev,
+						  unsigned type)
 {
 	struct rk_iommu_domain *rk_domain;
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index ed33c6cce083..a56e4e282469 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -41,7 +41,8 @@ static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
+static struct iommu_domain *s390_domain_alloc(struct device *dev,
+					      unsigned domain_type)
 {
 	struct s390_domain *s390_domain;
 
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 4cebccb6fc8b..32992cb07c4f 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -132,7 +132,8 @@ sprd_iommu_pgt_size(struct iommu_domain *domain)
 		SPRD_IOMMU_PAGE_SHIFT) * sizeof(u32);
 }
 
-static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
+static struct iommu_domain *sprd_iommu_domain_alloc(struct device *dev,
+						    unsigned int domain_type)
 {
 	struct sprd_iommu_domain *dom;
 
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 5b585eace3d4..10c7eb9c5f11 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -667,7 +667,8 @@ static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
 		sun50i_iova_get_page_offset(iova);
 }
 
-static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *sun50i_iommu_domain_alloc(struct device *dev,
+						      unsigned type)
 {
 	struct sun50i_iommu_domain *sun50i_domain;
 
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index ed53279d1106..75bcf191b091 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -141,7 +141,8 @@ static void gart_iommu_detach_dev(struct iommu_domain *domain,
 	spin_unlock(&gart->dom_lock);
 }
 
-static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *gart_iommu_domain_alloc(struct device *dev,
+						    unsigned type)
 {
 	struct iommu_domain *domain;
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 5b1af40221ec..c7c34d9f60ec 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -272,7 +272,8 @@ static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
 	clear_bit(id, smmu->asids);
 }
 
-static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
+static struct iommu_domain *tegra_smmu_domain_alloc(struct device *dev,
+						    unsigned type)
 {
 	struct tegra_smmu_as *as;
 
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 59f1abd6ee53..7f397767a8e2 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -637,7 +637,8 @@ static void viommu_event_handler(struct virtqueue *vq)
 
 /* IOMMU API */
 
-static struct iommu_domain *viommu_domain_alloc(unsigned type)
+static struct iommu_domain *viommu_domain_alloc(struct device *dev,
+						unsigned type)
 {
 	struct viommu_domain *vdomain;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 35af9d4e3969..3a8930d36046 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -252,7 +252,8 @@ struct iommu_ops {
 	bool (*capable)(struct device *dev, enum iommu_cap);
 
 	/* Domain allocation and freeing by the iommu driver */
-	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
+	struct iommu_domain *(*domain_alloc)(struct device *dev,
+					     unsigned iommu_domain_type);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.36.1.dirty

