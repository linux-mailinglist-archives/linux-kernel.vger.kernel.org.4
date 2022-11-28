Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CAF63A199
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiK1Gyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiK1Gyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:54:33 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF9F140F2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618468; x=1701154468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vVcsLAcU1x+PF9hn6JDVgVNAyf43Jf3te2XqSzSydEI=;
  b=akk2e6Cn8+BmPi5qcvivMy9PpVVTSuEo0yg/MzMD+4rCao4yCPopkAEK
   TQyxnkx+l7IU8rdPDe8rt3ihYkm0Z/5RsJB5ESC0fWT9az4W9mFuHtuP6
   kPxa/evAYhGxlHWhOUgLh/m2Ffo7QT/9/jOpqxuQ+nHQmV2rUGtQARW/N
   lMYrmpHhgQmoPhVkEHnHQFiKH+pT5WKnJCHeTKxp+3WnZjJiFGm78inQu
   3VGC9MW9swFiINN8R0/KdXGxAjEa+zPtBHvlViGUa2rzSO/3csHFctF+v
   dC3m9KGDCDJTzvVHOyApdfrb6KlAFcrv0PrBGRuJgso0fs9DILaOMGtpK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="376901409"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="376901409"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:54:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674120767"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674120767"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:54:21 -0800
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
Subject: [PATCH v3 03/20] iommu/qcom: Remove detach_dev callback
Date:   Mon, 28 Nov 2022 14:46:31 +0800
Message-Id: <20221128064648.1934720-4-baolu.lu@linux.intel.com>
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

The IOMMU driver supports default domain, so the detach_dev op will never
be called. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 23 -----------------------
 1 file changed, 23 deletions(-)

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
-- 
2.34.1

