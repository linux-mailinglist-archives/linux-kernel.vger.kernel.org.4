Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D80663A37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbjAJHyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjAJHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:54:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DC01CB1D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673337240; x=1704873240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+JXFxO9igzjBIvznA/wHPFCJpglE8nncKGoF1baKSuw=;
  b=WqPn9YDC+dd6mUMiidwjIunRCgPOAdhVdpnSlUzMBipBKA8pg4elfl8K
   /r4WbLlYj0HuXeXqKdr+HegC+KIisZA7rqkgDCEs6+d6u/xi64+cXCsiD
   qm3Ou4BjzDGKK65QlYypwlUnJnvK58IfWSPQEZNRfMyAoeu2/1kaPD2AI
   mIs9tOC1CDJdMPSPaXdSr3qSHOyEQFelNd7qzGSiET3WUlLpgSjZrWaRV
   dQqkIncEYxOFeCejpDe8Xf/QVmeDEXjM/Svo4+SATTajPJIOkDomWVM9F
   fJFRqveRBBIfgQGAEe8vF6G2DA1oCsTp8l8VtKhdeZpN/RFlfk2q4IzHj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="303449376"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="303449376"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 23:53:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902287180"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="902287180"
Received: from juxinli-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.254.214.35])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 23:53:56 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: [PATCH -v2 8/9] migrate_pages: batch flushing TLB
Date:   Tue, 10 Jan 2023 15:53:26 +0800
Message-Id: <20230110075327.590514-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230110075327.590514-1-ying.huang@intel.com>
References: <20230110075327.590514-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TLB flushing will cost quite some CPU cycles during the folio
migration in some situations.  For example, when migrate a folio of a
process with multiple active threads that run on multiple CPUs.  After
batching the _unmap and _move in migrate_pages(), the TLB flushing can
be batched easily with the existing TLB flush batching mechanism.
This patch implements that.

We use the following test case to test the patch.

On a 2-socket Intel server,

- Run pmbench memory accessing benchmark

- Run `migratepages` to migrate pages of pmbench between node 0 and
  node 1 back and forth.

With the patch, the TLB flushing IPI reduces 99.1% during the test and
the number of pages migrated successfully per second increases 291.7%.

NOTE: TLB flushing is batched only for normal folios, not for THP
folios.  Because the overhead of TLB flushing for THP folios is much
lower than that for normal folios (about 1/512 on x86 platform).

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: haoxin <xhao@linux.alibaba.com>
---
 mm/migrate.c |  4 +++-
 mm/rmap.c    | 20 +++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6c721b897efd..6adaea05b80a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1230,7 +1230,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 		/* Establish migration ptes */
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
-		try_to_migrate(src, 0);
+		try_to_migrate(src, TTU_BATCH_FLUSH);
 		page_was_mapped = 1;
 	}
 
@@ -1773,6 +1773,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 move:
+	try_to_unmap_flush();
+
 	retry = 1;
 	for (pass = 0;
 	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
diff --git a/mm/rmap.c b/mm/rmap.c
index b616870a09be..2e125f3e462e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1976,7 +1976,21 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		} else {
 			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
 			/* Nuke the page table entry. */
-			pteval = ptep_clear_flush(vma, address, pvmw.pte);
+			if (should_defer_flush(mm, flags)) {
+				/*
+				 * We clear the PTE but do not flush so potentially
+				 * a remote CPU could still be writing to the folio.
+				 * If the entry was previously clean then the
+				 * architecture must guarantee that a clear->dirty
+				 * transition on a cached TLB entry is written through
+				 * and traps if the PTE is unmapped.
+				 */
+				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
+
+				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+			} else {
+				pteval = ptep_clear_flush(vma, address, pvmw.pte);
+			}
 		}
 
 		/* Set the dirty flag on the folio now the pte is gone. */
@@ -2148,10 +2162,10 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 
 	/*
 	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED and
-	 * TTU_SPLIT_HUGE_PMD and TTU_SYNC flags.
+	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC, and TTU_BATCH_FLUSH flags.
 	 */
 	if (WARN_ON_ONCE(flags & ~(TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
-					TTU_SYNC)))
+					TTU_SYNC | TTU_BATCH_FLUSH)))
 		return;
 
 	if (folio_is_zone_device(folio) &&
-- 
2.35.1

