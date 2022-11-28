Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1378363A19F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiK1Gzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiK1GzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:55:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789FC14D3A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618502; x=1701154502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m//sYgF0rdstnqtGp6Wm1Z2gWE/E1AcAWpWObxb6y14=;
  b=JkAvuSbrURZd+lm2Jo/aWR0HUZQ4Gu+EsKVoEqXHMSsP2ElGXIZ+QV+z
   qZbHA4y7v1j0WJzpW2cUyRBIgdOOvIunwMA1oLZW+2YDUZO/aNqDW9TXS
   TqVIDIRKNm5PaqpTtBfuQQH6DcoGRf62W7EE6PYLMr5sZrqhOmVDqTY1p
   OyV4Yo6QMB32LbVPgH498TlJp3nCwS4bbkRW26oDZqTztZLIkbl/19ztu
   2ZFs+wRsSvh9FzghABvEFXzmHa83yKp/2BhsEzE3rs+p02/AXuXBcv887
   hDD5LeA8jeiPFl5oHh687M1Q1u+eP5CCOy/z6XrpOynD0gCj1dhxfxpIS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="294462491"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="294462491"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674120857"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674120857"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:54:55 -0800
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
Subject: [PATCH v3 08/20] iommu/sprd: Remove detach_dev callback
Date:   Mon, 28 Nov 2022 14:46:36 +0800
Message-Id: <20221128064648.1934720-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
 drivers/iommu/sprd-iommu.c | 16 ----------------
 1 file changed, 16 deletions(-)

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
-- 
2.34.1

