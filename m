Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47F765D3D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbjADNI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbjADNIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:08:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5427A3E0F7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837652; x=1704373652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xleto1bNcJbkoJR+rItuVcszZ5LEAV28VIm/LQTaL2s=;
  b=KGG6mN+8e5MPITVi6+TTaycglDqIk8rdmnQBtz5eyjFryRSn0WYo7YPO
   mwyLCmLTSCSnKR5s1Bfof9kcdLOpqF02OpkOqN4t/YH5PmGZoMlZfMGTb
   GCjsbtx0EOqVn+g2Y2IRyCn25BS13P9SZajq7cgOgZ0s4DlZhzhwpN6bn
   IzHVvV9aBTy5tQUtkYTfhTp8qddDZjl3P/hEQ6AoCv7Ilxv5PtpEhx/nN
   YoUdIeCq3nsxHtj/i7Bwk71jInHEq4N7F/ZzpSvBGS19wai5SsJG0Cpkq
   6gkwvwkXWDYKvQfJFsf/ydyxawbq8VOrCcVSaW8dkVpHqb046Kly6/ZC6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320640234"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="320640234"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:07:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529180"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529180"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:07:00 -0800
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
Subject: [PATCH v4 16/19] iommu/gart: Add set_platform_dma_ops callback
Date:   Wed,  4 Jan 2023 20:57:22 +0800
Message-Id: <20230104125725.271850-17-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104125725.271850-1-baolu.lu@linux.intel.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
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

This IOMMU driver doesn't support default domain. Add the implementation
of set_platform_dma_ops callback so that the IOMMU core could return the
DMA control. With set_platform_dma_ops implemented, there's no need for
detach_dev. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/tegra-gart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
-- 
2.34.1

