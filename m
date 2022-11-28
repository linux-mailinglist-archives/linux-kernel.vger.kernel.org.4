Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0776163A1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiK1G5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiK1G4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:56:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AC214D3F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618580; x=1701154580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gUstT2MwrHgpmVm8ozwibpzvZnHb5hlxoDudunwPD3E=;
  b=HTpz60m8rlzWUVmqlblS+YZM5Owt4SyRuQGZpUU0wgHUb/EcQa0zx04A
   6k4neojNOq1mezpmhiv4Q+OQWmjR/BoBovEBIFzERiwUT64Ljw5RlUe31
   wfmUDyWv5A8YEfN0h/xxgETazv7/VdPyJVYBp3rMgVARuC3A6nX3ijxYj
   +Pt+iO2gAY4FHi9SePvX7YFRPlMeyyowaWbJHFtFgr7KhoHXvEtgHHmVn
   p2Y8DPmaKBU1jgc8/T1pR5sB6g96NWxk9TJUYtkul9PFOKc30Ur26jaRA
   DPMiRQkXmnC1arNHrzJbuN5jPh9FgF/uPolK39UQKr7vtrrLqOxFUodMn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="313459237"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="313459237"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:56:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674121339"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674121339"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:56:12 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
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
Subject: [PATCH v3 19/20] iommu: Retire detach_dev callback
Date:   Mon, 28 Nov 2022 14:46:47 +0800
Message-Id: <20221128064648.1934720-20-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The detach_dev callback of domain ops is not used in the IOMMU core.
Remove this callback to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h           | 2 --
 drivers/iommu/fsl_pamu_domain.c | 1 -
 drivers/iommu/msm_iommu.c       | 1 -
 drivers/iommu/mtk_iommu_v1.c    | 1 -
 drivers/iommu/omap-iommu.c      | 1 -
 drivers/iommu/s390-iommu.c      | 1 -
 drivers/iommu/tegra-gart.c      | 1 -
 drivers/iommu/tegra-smmu.c      | 1 -
 8 files changed, 9 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3542461558fa..4c0491e5708c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -294,7 +294,6 @@ struct iommu_ops {
  * * EBUSY	- device is attached to a domain and cannot be changed
  * * ENODEV	- device specific errors, not able to be attached
  * * <others>	- treated as ENODEV by the caller. Use is discouraged
- * @detach_dev: detach an iommu domain from a device
  * @set_dev_pasid: set an iommu domain to a pasid of device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
@@ -315,7 +314,6 @@ struct iommu_ops {
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
-	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
 			     ioasid_t pasid);
 
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index b8c716e7c424..272d88e415c6 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -463,7 +463,6 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.set_platform_dma = fsl_pamu_set_platform_dma;
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= fsl_pamu_attach_device,
-		.detach_dev	= fsl_pamu_detach_device,
 		.iova_to_phys	= fsl_pamu_iova_to_phys,
 		.free		= fsl_pamu_domain_free,
 	}
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3eb1bc668cad..564f9dc0140d 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -691,7 +691,6 @@ static struct iommu_ops msm_iommu_ops = {
 	.of_xlate = qcom_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
-		.detach_dev	= msm_iommu_detach_dev,
 		.map_pages	= msm_iommu_map,
 		.unmap_pages	= msm_iommu_unmap,
 		/*
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 6a815da8a020..c2d80b7a377f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -597,7 +597,6 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_v1_attach_device,
-		.detach_dev	= mtk_iommu_v1_detach_device,
 		.map_pages	= mtk_iommu_v1_map,
 		.unmap_pages	= mtk_iommu_v1_unmap,
 		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index aa3858a48bbf..c3eedab00038 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1749,7 +1749,6 @@ static const struct iommu_ops omap_iommu_ops = {
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= omap_iommu_attach_dev,
-		.detach_dev	= omap_iommu_detach_dev,
 		.map		= omap_iommu_map,
 		.unmap		= omap_iommu_unmap,
 		.iova_to_phys	= omap_iommu_iova_to_phys,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 507bbc2c9b58..33dba5ee5e20 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -448,7 +448,6 @@ static const struct iommu_ops s390_iommu_ops = {
 	.get_resv_regions = s390_iommu_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
-		.detach_dev	= s390_iommu_detach_device,
 		.map_pages	= s390_iommu_map_pages,
 		.unmap_pages	= s390_iommu_unmap_pages,
 		.flush_iotlb_all = s390_iommu_flush_iotlb_all,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index f56e40b5c47a..a532b333233f 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -283,7 +283,6 @@ static const struct iommu_ops gart_iommu_ops = {
 	.of_xlate	= gart_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= gart_iommu_attach_dev,
-		.detach_dev	= gart_iommu_detach_dev,
 		.map		= gart_iommu_map,
 		.unmap		= gart_iommu_unmap,
 		.iova_to_phys	= gart_iommu_iova_to_phys,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index a36e163e5cc1..247d485904c1 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -978,7 +978,6 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= tegra_smmu_attach_dev,
-		.detach_dev	= tegra_smmu_detach_dev,
 		.map		= tegra_smmu_map,
 		.unmap		= tegra_smmu_unmap,
 		.iova_to_phys	= tegra_smmu_iova_to_phys,
-- 
2.34.1

