Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C264C73CF49
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjFYIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFYIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:23:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCC3E6F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687681409; x=1719217409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x8wOLMsJ+xY5lhzECQoNzvy9TUBhudomKGSjdZb+5Q8=;
  b=KgACDJf46rm364+1iuN5HWKUDJRCFXoi0hKxVZanTExsIyJ/2La6mW7y
   pu2kBmICvxVtl9U4CG/dmYZZXS7D9hcXkX6Lve/8K93Twmb2rsXwx2YP/
   +eJ6E/4qIieWbDM1cgFIGh4EyG6vaayV10qv9QTholkq6VD5rnwHC+S16
   08vVU2FWshspzP4GObSQz8ZiMITG6HD447BrdVHNltpwYkFmXrVHmm1Sr
   H8bHCXWEJTvAZNyQepNBLhqKJJO1mO//EL7QXBhVgwyWjM5hXcu2iJmPQ
   ATMIuJXHmlXrkgES8vevDHh8rV2UYWL4V8thlneh+VnTIz9WGifPJWTij
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="345793094"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="345793094"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 01:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="805666831"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="805666831"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 01:23:26 -0700
From:   Yanfei Xu <yanfei.xu@intel.com>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yanfei.xu@intel.com
Subject: [PATCH] iommu/vt-d: Fix to convert mm pfn to dma pfn
Date:   Sun, 25 Jun 2023 16:20:46 +0800
Message-Id: <20230625082046.979742-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the case that VT-d page is smaller than mm page, converting dma
pfn should be handled in two cases which are for start pfn and for
end pfn. Currently the calculation of end dma pfn is incorrect and
the result is less than real page frame number which is causing the
mapping of iova always misses some page frames.

Hence rename the mm_to_dma_pfn() to mm_to_dma_pfn_start() and add
a new helper for converting end dma pfn named mm_to_dma_pfn_end()

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
Found from reading VT-D codes.

 drivers/iommu/intel/iommu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8096273b034c..5ceb12b90c1b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -113,13 +113,17 @@ static inline unsigned long lvl_to_nr_pages(unsigned int lvl)
 
 /* VT-d pages must always be _smaller_ than MM pages. Otherwise things
    are never going to work. */
-static inline unsigned long mm_to_dma_pfn(unsigned long mm_pfn)
+static inline unsigned long mm_to_dma_pfn_start(unsigned long mm_pfn)
 {
 	return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
 }
+static inline unsigned long mm_to_dma_pfn_end(unsigned long mm_pfn)
+{
+	return ((mm_pfn + 1) << (PAGE_SHIFT - VTD_PAGE_SHIFT)) - 1;
+}
 static inline unsigned long page_to_dma_pfn(struct page *pg)
 {
-	return mm_to_dma_pfn(page_to_pfn(pg));
+	return mm_to_dma_pfn_start(page_to_pfn(pg));
 }
 static inline unsigned long virt_to_dma_pfn(void *p)
 {
@@ -2374,8 +2378,8 @@ static int __init si_domain_init(int hw)
 
 		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 			ret = iommu_domain_identity_map(si_domain,
-					mm_to_dma_pfn(start_pfn),
-					mm_to_dma_pfn(end_pfn));
+					mm_to_dma_pfn_start(start_pfn),
+					mm_to_dma_pfn_end(end_pfn));
 			if (ret)
 				return ret;
 		}
@@ -2396,8 +2400,8 @@ static int __init si_domain_init(int hw)
 				continue;
 
 			ret = iommu_domain_identity_map(si_domain,
-					mm_to_dma_pfn(start >> PAGE_SHIFT),
-					mm_to_dma_pfn(end >> PAGE_SHIFT));
+					mm_to_dma_pfn_start(start >> PAGE_SHIFT),
+					mm_to_dma_pfn_end(end >> PAGE_SHIFT));
 			if (ret)
 				return ret;
 		}
@@ -3567,8 +3571,8 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 				       unsigned long val, void *v)
 {
 	struct memory_notify *mhp = v;
-	unsigned long start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
-	unsigned long last_vpfn = mm_to_dma_pfn(mhp->start_pfn +
+	unsigned long start_vpfn = mm_to_dma_pfn_start(mhp->start_pfn);
+	unsigned long last_vpfn = mm_to_dma_pfn_end(mhp->start_pfn +
 			mhp->nr_pages - 1);
 
 	switch (val) {
@@ -4278,7 +4282,7 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 	unsigned long i;
 
 	nrpages = aligned_nrpages(gather->start, size);
-	start_pfn = mm_to_dma_pfn(iova_pfn);
+	start_pfn = mm_to_dma_pfn_start(iova_pfn);
 
 	xa_for_each(&dmar_domain->iommu_array, i, info)
 		iommu_flush_iotlb_psi(info->iommu, dmar_domain,
-- 
2.34.1

