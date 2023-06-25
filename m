Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A54073CE17
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjFYClZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjFYClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:41:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963D8EA
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687660883; x=1719196883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TAows7OAcmxGvx49AoU/i5mLwi1QDRE6TshwUYSLvtg=;
  b=mFX4GO8s/RSOzEAwziFh3+ggnOMeERe5wlaB9jnr1DUnx8oCa73AVpmj
   tYm5JK7sXULfsoBccDXmZm2Hn1GVxFnPonXFFglva+nQJ67IHNEHJu6rU
   Azjw0IenWuPERmR3+J30oU1AMLvdqKaV9t5Q5DPrLXJv1AlnCDu14WAPv
   9i1lpD6mFaJJ2jUOxVlRdIhNPdtLxn0uTyuXpjpdRex2m8/P3Pg5nkwP+
   k/71hFOQmW6pa4rOUI9GOcG/mDUfp8B9KcCy8R1R7Vwl20AstTRknTLNl
   eOPRJzKgR10TzoXKvJ8ADhkUNVoI1X1NflbHi9SvUTpnc+/adkpTNwjzV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="391148606"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="391148606"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 19:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="860285839"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="860285839"
Received: from cascade.sh.intel.com ([10.239.48.162])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2023 19:41:20 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian@vger.kernel.org, Kevin <kevin.tian@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH] iommu/vt-d: debugfs: Increment the reference count of page table page
Date:   Sun, 25 Jun 2023 10:28:08 +0800
Message-Id: <20230625022808.42942-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be a race with iommu_unmap() interface when traversing a page
table.

When debugfs traverses an IOMMU page table, iommu_unmap() may clear
entries and free the page table pages pointed to by the entries.
So debugfs may read invalid or freed pages.

To avoid this, increment the refcount of a page table page before
traversing the page, and decrement its refcount after traversing it.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 36 +++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 1f925285104e..d228e1580aec 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -333,9 +333,41 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 		path[level] = pde->val;
 		if (dma_pte_superpage(pde) || level == 1)
 			dump_page_info(m, start, path);
-		else
-			pgtable_walk_level(m, phys_to_virt(dma_pte_addr(pde)),
+		else {
+			struct page *pg;
+			u64 pte_addr;
+
+			/*
+			 * The entry references a Page-Directory Table
+			 * or a Page Table.
+			 */
+retry:
+			pte_addr = dma_pte_addr(pde);
+			pg = pfn_to_page(pte_addr >> PAGE_SHIFT);
+			if (!get_page_unless_zero(pg))
+				/*
+				 * If this page has a refcount of zero,
+				 * it has been freed, or will be freed.
+				 */
+				continue;
+
+			/* Check if the value of the entry is changed. */
+			if (pde->val != path[level]) {
+				put_page(pg);
+
+				if (!dma_pte_present(pde))
+					/* The entry is invalid. Skip it. */
+					continue;
+
+				/* The entry has been updated. */
+				path[level] = pde->val;
+				goto retry;
+			}
+
+			pgtable_walk_level(m, phys_to_virt(pte_addr),
 					   level - 1, start, path);
+			put_page(pg);
+		}
 		path[level] = 0;
 	}
 }
-- 
2.21.3

