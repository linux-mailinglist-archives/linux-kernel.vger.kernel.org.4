Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC36B66379A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjAJDDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjAJDCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:02:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9C741A7C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673319748; x=1704855748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nWlE5jqY0RFETPEIbA+ayORhmSr2X7ec+EjS3p4oMbk=;
  b=mYWTFIgciuA0eySSqfTSy3KH2Q7/SY5v964vvC8uLLyIO1kf1452av7K
   lgKNR57BBSFCXkSYTW8Z3iFPscNXhRTiwwlzClFThBEytE3UQ0xNbt/nN
   rYqRbYNz/BKQd9BjyHpQPJImeE/9GVa+UhGGVUORX/2kIJwxOGexpXQ87
   R4ybt3uFecJ0CpmexThNVeNbx7uoejNATewZl+eecXdPHNnVsdu6cCJmD
   dgbXeXgL/2Akjh8HY8o/4yvd112iVkNR5fqO9b2HZ8CY3M4R68nu3P1/c
   9A5IDOLviaILigjgKembzvnNTpQtI7Q7yEl7St71bVZstpAuNMy3pMZOZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324289147"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324289147"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 19:02:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="830841954"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="830841954"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2023 19:02:20 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 3/5] iommu: Add set_platform_dma_ops callbacks
Date:   Tue, 10 Jan 2023 10:54:06 +0800
Message-Id: <20230110025408.667767-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110025408.667767-1-baolu.lu@linux.intel.com>
References: <20230110025408.667767-1-baolu.lu@linux.intel.com>
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

For those IOMMU drivers that don't provide default domain support, add an
implementation of set_platform_dma_ops callback so that the IOMMU core
could return the DMA control to platform DMA ops. At the same time, with
the set_platform_dma_ops implemented, there is no need for detach_dev.
Remove it to avoid dead code.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/fsl_pamu_domain.c | 6 +++---
 drivers/iommu/msm_iommu.c       | 6 +++---
 drivers/iommu/mtk_iommu_v1.c    | 4 ++--
 drivers/iommu/omap-iommu.c      | 6 +++---
 drivers/iommu/s390-iommu.c      | 7 ++-----
 drivers/iommu/tegra-gart.c      | 6 +++---
 drivers/iommu/tegra-smmu.c      | 5 +++--
 7 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 4408ac3c49b6..e123161c211a 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -283,9 +283,9 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
-static void fsl_pamu_detach_device(struct iommu_domain *domain,
-				   struct device *dev)
+static void fsl_pamu_set_platform_dma(struct device *dev)
 {
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 	const u32 *prop;
 	int len;
@@ -452,9 +452,9 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.domain_alloc	= fsl_pamu_domain_alloc,
 	.probe_device	= fsl_pamu_probe_device,
 	.device_group   = fsl_pamu_device_group,
+	.set_platform_dma_ops = fsl_pamu_set_platform_dma;
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= fsl_pamu_attach_device,
-		.detach_dev	= fsl_pamu_detach_device,
 		.iova_to_phys	= fsl_pamu_iova_to_phys,
 		.free		= fsl_pamu_domain_free,
 	}
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index c60624910872..454f6331c889 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -443,9 +443,9 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 
-static void msm_iommu_detach_dev(struct iommu_domain *domain,
-				 struct device *dev)
+static void msm_iommu_set_platform_dma(struct device *dev)
 {
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct msm_priv *priv = to_msm_priv(domain);
 	unsigned long flags;
 	struct msm_iommu_dev *iommu;
@@ -678,11 +678,11 @@ static struct iommu_ops msm_iommu_ops = {
 	.domain_alloc = msm_iommu_domain_alloc,
 	.probe_device = msm_iommu_probe_device,
 	.device_group = generic_device_group,
+	.set_platform_dma_ops = msm_iommu_set_platform_dma,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
 	.of_xlate = qcom_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
-		.detach_dev	= msm_iommu_detach_dev,
 		.map_pages	= msm_iommu_map,
 		.unmap_pages	= msm_iommu_unmap,
 		/*
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 69682ee068d2..78d0a84c704f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -319,7 +319,7 @@ static int mtk_iommu_v1_attach_device(struct iommu_domain *domain, struct device
 	return 0;
 }
 
-static void mtk_iommu_v1_detach_device(struct iommu_domain *domain, struct device *dev)
+static void mtk_iommu_v1_set_platform_dma(struct device *dev)
 {
 	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
 
@@ -585,10 +585,10 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.def_domain_type = mtk_iommu_v1_def_domain_type,
 	.device_group	= generic_device_group,
 	.pgsize_bitmap	= MT2701_IOMMU_PAGE_SIZE,
+	.set_platform_dma_ops = mtk_iommu_v1_set_platform_dma,
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_v1_attach_device,
-		.detach_dev	= mtk_iommu_v1_detach_device,
 		.map_pages	= mtk_iommu_v1_map,
 		.unmap_pages	= mtk_iommu_v1_unmap,
 		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 2fd7702c6709..3ab078112a7c 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1556,9 +1556,9 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 	omap_domain->dev = NULL;
 }
 
-static void omap_iommu_detach_dev(struct iommu_domain *domain,
-				  struct device *dev)
+static void omap_iommu_set_platform_dma(struct device *dev)
 {
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 
 	spin_lock(&omap_domain->lock);
@@ -1737,10 +1737,10 @@ static const struct iommu_ops omap_iommu_ops = {
 	.probe_device	= omap_iommu_probe_device,
 	.release_device	= omap_iommu_release_device,
 	.device_group	= omap_iommu_device_group,
+	.set_platform_dma_ops = omap_iommu_set_platform_dma,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= omap_iommu_attach_dev,
-		.detach_dev	= omap_iommu_detach_dev,
 		.map		= omap_iommu_map,
 		.unmap		= omap_iommu_unmap,
 		.iova_to_phys	= omap_iommu_iova_to_phys,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index ed33c6cce083..5591dab99446 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -144,13 +144,10 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	return 0;
 }
 
-static void s390_iommu_detach_device(struct iommu_domain *domain,
-				     struct device *dev)
+static void s390_iommu_set_platform_dma(struct device *dev)
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 
-	WARN_ON(zdev->s390_domain != to_s390_domain(domain));
-
 	__s390_iommu_detach_device(zdev);
 	zpci_dma_init_device(zdev);
 }
@@ -435,11 +432,11 @@ static const struct iommu_ops s390_iommu_ops = {
 	.probe_device = s390_iommu_probe_device,
 	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
+	.set_platform_dma_ops = s390_iommu_set_platform_dma,
 	.pgsize_bitmap = SZ_4K,
 	.get_resv_regions = s390_iommu_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
-		.detach_dev	= s390_iommu_detach_device,
 		.map_pages	= s390_iommu_map_pages,
 		.unmap_pages	= s390_iommu_unmap_pages,
 		.flush_iotlb_all = s390_iommu_flush_iotlb_all,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index ed53279d1106..a482ff838b53 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -124,9 +124,9 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	return ret;
 }
 
-static void gart_iommu_detach_dev(struct iommu_domain *domain,
-				  struct device *dev)
+static void gart_iommu_set_platform_dma(struct device *dev)
 {
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct gart_device *gart = gart_handle;
 
 	spin_lock(&gart->dom_lock);
@@ -270,11 +270,11 @@ static const struct iommu_ops gart_iommu_ops = {
 	.domain_alloc	= gart_iommu_domain_alloc,
 	.probe_device	= gart_iommu_probe_device,
 	.device_group	= generic_device_group,
+	.set_platform_dma_ops = gart_iommu_set_platform_dma,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
 	.of_xlate	= gart_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= gart_iommu_attach_dev,
-		.detach_dev	= gart_iommu_detach_dev,
 		.map		= gart_iommu_map,
 		.unmap		= gart_iommu_unmap,
 		.iova_to_phys	= gart_iommu_iova_to_phys,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 5b1af40221ec..4c4ac22d5fb1 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -511,8 +511,9 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 	return err;
 }
 
-static void tegra_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
+static void tegra_smmu_set_platform_dma(struct device *dev)
 {
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	struct tegra_smmu *smmu = as->smmu;
@@ -965,11 +966,11 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.domain_alloc = tegra_smmu_domain_alloc,
 	.probe_device = tegra_smmu_probe_device,
 	.device_group = tegra_smmu_device_group,
+	.set_platform_dma_ops = tegra_smmu_set_platform_dma,
 	.of_xlate = tegra_smmu_of_xlate,
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= tegra_smmu_attach_dev,
-		.detach_dev	= tegra_smmu_detach_dev,
 		.map		= tegra_smmu_map,
 		.unmap		= tegra_smmu_unmap,
 		.iova_to_phys	= tegra_smmu_iova_to_phys,
-- 
2.34.1

