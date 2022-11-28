Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E363A1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiK1G5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiK1G4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:56:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C202B15826
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618577; x=1701154577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2u7/GIfAe0DIonm/0hJIJlmbZhf+CBwAyKoVx4wlxOs=;
  b=bZDvXmg33vtWikJdBBjf8FS/AKg5ydS+avyP9b74slaqHwNHfGqyLSjA
   0ZAN5mtyoGWT/T868EM1b26pgRDIA4+x+hX8T5eyhae53gVsW/J4Kmh6L
   21p6y+eRxiPnMtyFlF2op1VCh8vtuJb8w6aHkYJWmdoIiDmcu0WeR9aw2
   nZbzFaPULH8MMjoOhNuCXdsKRMFmnRAY4z0RIlBaWFxvOtLNfn6+3rdQL
   8i26w0GHpaIKyGe7Knr92WnGjRtV5ZCwAGe1649NCGcaXc4Uo7yI+iokX
   RQACHuwiJN3+kAMrvysnqay0hOC+FtrSynvXs/7Sf9ziV+a/kSCL5qQWy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="379016449"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="379016449"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674121303"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674121303"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:56:05 -0800
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
Subject: [PATCH v3 18/20] iommu: Call set_platform_dma if default domain is unavailable
Date:   Mon, 28 Nov 2022 14:46:46 +0800
Message-Id: <20221128064648.1934720-19-baolu.lu@linux.intel.com>
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

If the IOMMU driver has no default domain support, call set_platform_dma
explicitly to return the kernel DMA control back to the platform DMA ops.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7c99d8eb3182..e4966f088184 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2040,16 +2040,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	return 0;
 }
 
-static void __iommu_detach_device(struct iommu_domain *domain,
-				  struct device *dev)
-{
-	if (iommu_is_attach_deferred(dev))
-		return;
-
-	domain->ops->detach_dev(domain, dev);
-	trace_detach_device_from_domain(dev);
-}
-
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2154,11 +2144,12 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
-static int iommu_group_do_detach_device(struct device *dev, void *data)
+static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
 {
-	struct iommu_domain *domain = data;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	__iommu_detach_device(domain, dev);
+	if (!WARN_ON(!ops->set_platform_dma))
+		ops->set_platform_dma(dev);
 
 	return 0;
 }
@@ -2172,15 +2163,12 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 		return 0;
 
 	/*
-	 * New drivers should support default domains and so the detach_dev() op
-	 * will never be called. Otherwise the NULL domain represents some
-	 * platform specific behavior.
+	 * New drivers should support default domains. Otherwise the NULL
+	 * domain represents returning control back to the platform DMA.
 	 */
 	if (!new_domain) {
-		if (WARN_ON(!group->domain->ops->detach_dev))
-			return -EINVAL;
-		__iommu_group_for_each_dev(group, group->domain,
-					   iommu_group_do_detach_device);
+		__iommu_group_for_each_dev(group, NULL,
+					   iommu_group_do_set_platform_dma);
 		group->domain = NULL;
 		return 0;
 	}
-- 
2.34.1

