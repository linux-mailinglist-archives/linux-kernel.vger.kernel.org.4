Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04266663797
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjAJDCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjAJDCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:02:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1214102E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673319734; x=1704855734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKTg2AhHtJU8Mk4diYz1OLa+rxghCz1GjIZU/8Rz5yw=;
  b=HPEJinNyMxewIla0psNrSKj2/01US/xY20AdDDqXwJLnWEcxRdoEgToH
   5AzCQBhkwyOIHE+1yBGYL3WMfnJnDYbrdShE7P7C76wt00+AUB1ZIKNmb
   4WuIBNM5USpmEY6TigmjgM87CaP9CETu9+93vhjXbQCSzBtQIbcIQNStS
   XndgDPCdkgn8uuybQHtRWRvtWntsRO2nFk3stZ+153LgRMqeQQgZZ6nZi
   zqLwCK/JHTDR+tyieI+WAuXn+NW/uQeYYSgB/7lFwfzG+Vo8xyVc27E7J
   oNNr9gQUutUAPL7AnewtOZ2ArDpyU6AQTcQzaRPRA8HMZZFo5hmo+0e0v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324289072"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324289072"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 19:02:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="830841923"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="830841923"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2023 19:02:06 -0800
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
Subject: [PATCH v5 1/5] iommu: Remove detach_dev callbacks
Date:   Tue, 10 Jan 2023 10:54:04 +0800
Message-Id: <20230110025408.667767-2-baolu.lu@linux.intel.com>
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

The iommu core calls the driver's detach_dev domain op callback only when
a device is finished assigning to user space and
iommu_group_release_dma_owner() is called to return the device to the
kernel, where iommu core wants to set the default domain to the device but
the driver didn't provide one.

In other words, if any iommu driver provides default domain support, the
.detach_dev callback will never be called. This removes the detach_dev
callbacks in those IOMMU drivers that support default domain.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Sven Peter <sven@svenpeter.dev> # apple-dart
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com> # sprd
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com> # amd
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/iommu.c               | 26 -------------------------
 drivers/iommu/apple-dart.c              | 24 -----------------------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 23 ----------------------
 drivers/iommu/exynos-iommu.c            |  1 -
 drivers/iommu/ipmmu-vmsa.c              | 16 ---------------
 drivers/iommu/mtk_iommu.c               |  9 ---------
 drivers/iommu/rockchip-iommu.c          |  1 -
 drivers/iommu/sprd-iommu.c              | 16 ---------------
 drivers/iommu/sun50i-iommu.c            |  1 -
 9 files changed, 117 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..92319c9b877c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2126,31 +2126,6 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	protection_domain_free(domain);
 }
 
-static void amd_iommu_detach_device(struct iommu_domain *dom,
-				    struct device *dev)
-{
-	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	struct amd_iommu *iommu;
-
-	if (!check_device(dev))
-		return;
-
-	if (dev_data->domain != NULL)
-		detach_device(dev);
-
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return;
-
-#ifdef CONFIG_IRQ_REMAP
-	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    (dom->type == IOMMU_DOMAIN_UNMANAGED))
-		dev_data->use_vapic = 0;
-#endif
-
-	iommu_completion_wait(iommu);
-}
-
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
@@ -2416,7 +2391,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
-		.detach_dev	= amd_iommu_detach_device,
 		.map_pages	= amd_iommu_map_pages,
 		.unmap_pages	= amd_iommu_unmap_pages,
 		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 4f4a323be0d0..96843d468801 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -486,13 +486,6 @@ static int apple_dart_domain_add_streams(struct apple_dart_domain *domain,
 				      true);
 }
 
-static int apple_dart_domain_remove_streams(struct apple_dart_domain *domain,
-					    struct apple_dart_master_cfg *cfg)
-{
-	return apple_dart_mod_streams(domain->stream_maps, cfg->stream_maps,
-				      false);
-}
-
 static int apple_dart_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
@@ -535,22 +528,6 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
 	return ret;
 }
 
-static void apple_dart_detach_dev(struct iommu_domain *domain,
-				  struct device *dev)
-{
-	int i;
-	struct apple_dart_stream_map *stream_map;
-	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
-	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
-
-	for_each_stream_map(i, cfg, stream_map)
-		apple_dart_hw_disable_dma(stream_map);
-
-	if (domain->type == IOMMU_DOMAIN_DMA ||
-	    domain->type == IOMMU_DOMAIN_UNMANAGED)
-		apple_dart_domain_remove_streams(dart_domain, cfg);
-}
-
 static struct iommu_device *apple_dart_probe_device(struct device *dev)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
@@ -780,7 +757,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= apple_dart_attach_dev,
-		.detach_dev	= apple_dart_detach_dev,
 		.map_pages	= apple_dart_map_pages,
 		.unmap_pages	= apple_dart_unmap_pages,
 		.flush_iotlb_all = apple_dart_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 270c3d9128ba..d7be3adee426 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -387,28 +387,6 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 	return 0;
 }
 
-static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *dev)
-{
-	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
-	unsigned i;
-
-	if (WARN_ON(!qcom_domain->iommu))
-		return;
-
-	pm_runtime_get_sync(qcom_iommu->dev);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
-
-		/* Disable the context bank: */
-		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
-
-		ctx->domain = NULL;
-	}
-	pm_runtime_put_sync(qcom_iommu->dev);
-}
-
 static int qcom_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			  int prot, gfp_t gfp, size_t *mapped)
@@ -583,7 +561,6 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
-		.detach_dev	= qcom_iommu_detach_dev,
 		.map_pages	= qcom_iommu_map,
 		.unmap_pages	= qcom_iommu_unmap,
 		.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b0cde2211987..29ec713e8a21 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1404,7 +1404,6 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.of_xlate = exynos_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
-		.detach_dev	= exynos_iommu_detach_device,
 		.map		= exynos_iommu_map,
 		.unmap		= exynos_iommu_unmap,
 		.iova_to_phys	= exynos_iommu_iova_to_phys,
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index a003bd5fc65c..3112822ac7be 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -643,21 +643,6 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	return 0;
 }
 
-static void ipmmu_detach_device(struct iommu_domain *io_domain,
-				struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
-	unsigned int i;
-
-	for (i = 0; i < fwspec->num_ids; ++i)
-		ipmmu_utlb_disable(domain, fwspec->ids[i]);
-
-	/*
-	 * TODO: Optimize by disabling the context when no device is attached.
-	 */
-}
-
 static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
 		     phys_addr_t paddr, size_t pgsize, size_t pgcount,
 		     int prot, gfp_t gfp, size_t *mapped)
@@ -876,7 +861,6 @@ static const struct iommu_ops ipmmu_ops = {
 	.of_xlate = ipmmu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
-		.detach_dev	= ipmmu_detach_device,
 		.map_pages	= ipmmu_map,
 		.unmap_pages	= ipmmu_unmap,
 		.flush_iotlb_all = ipmmu_flush_iotlb_all,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2badd6acfb23..d5a4955910ff 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -710,14 +710,6 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
-static void mtk_iommu_detach_device(struct iommu_domain *domain,
-				    struct device *dev)
-{
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
-
-	mtk_iommu_config(data, dev, false, 0);
-}
-
 static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			 int prot, gfp_t gfp, size_t *mapped)
@@ -946,7 +938,6 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_attach_device,
-		.detach_dev	= mtk_iommu_detach_device,
 		.map_pages	= mtk_iommu_map,
 		.unmap_pages	= mtk_iommu_unmap,
 		.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index a68eadd64f38..f30db22ea5d7 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1192,7 +1192,6 @@ static const struct iommu_ops rk_iommu_ops = {
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= rk_iommu_attach_device,
-		.detach_dev	= rk_iommu_detach_device,
 		.map		= rk_iommu_map,
 		.unmap		= rk_iommu_unmap,
 		.iova_to_phys	= rk_iommu_iova_to_phys,
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 219bfa11f7f4..ae94d74b73f4 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -255,21 +255,6 @@ static int sprd_iommu_attach_device(struct iommu_domain *domain,
 	return 0;
 }
 
-static void sprd_iommu_detach_device(struct iommu_domain *domain,
-					     struct device *dev)
-{
-	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
-	struct sprd_iommu_device *sdev = dom->sdev;
-	size_t pgt_size = sprd_iommu_pgt_size(domain);
-
-	if (!sdev)
-		return;
-
-	dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
-	sprd_iommu_hw_en(sdev, false);
-	dom->sdev = NULL;
-}
-
 static int sprd_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			  int prot, gfp_t gfp, size_t *mapped)
@@ -414,7 +399,6 @@ static const struct iommu_ops sprd_iommu_ops = {
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= sprd_iommu_attach_device,
-		.detach_dev	= sprd_iommu_detach_device,
 		.map_pages	= sprd_iommu_map,
 		.unmap_pages	= sprd_iommu_unmap,
 		.iotlb_sync_map	= sprd_iommu_sync_map,
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 5b585eace3d4..2d993d0cea7d 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -834,7 +834,6 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.probe_device	= sun50i_iommu_probe_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= sun50i_iommu_attach_device,
-		.detach_dev	= sun50i_iommu_detach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
-- 
2.34.1

