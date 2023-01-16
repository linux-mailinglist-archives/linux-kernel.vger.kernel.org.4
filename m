Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730BB66B77B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjAPGcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjAPGcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:32:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4324EDD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673850701; x=1705386701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3J9a3YKiHmKyIA98tevHEicLgJhEATSgMLt7yTqcfnY=;
  b=UOZiXzIFZmarHiv1iwJrS7zikIqIYdQmT34BJQx3BBhU92M59ZG99/ns
   MF8YB7fhQmh5xePrEqaBzb6QrZ4JAc4KqDdubkQ6pIjPeniw2K+n7kHij
   Ezam8xh8Ry0FfYgs40xN97bnTI8NxPVv9MT74x/PGcXBGwwDuSpsQVknv
   5okv4ehJHuiPmmyi6C2wVqdrK2yTGnqRDKnG6hwQEDQWhEs/SjsRax2+x
   vnWeHC8Wq/O14f74aWBE81kthdVbxL0FFyQ0nKe+rthU+MtWwQFcGk4rV
   4xO5Ujujvpf7NYfX4rdbP6PzfSvThv1aTslKtOcvgNeRz/Kl8MqeLTJIn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="388892244"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="388892244"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:31:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="801286715"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="801286715"
Received: from tiangeng-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.220])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:31:37 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        haoxin <xhao@linux.alibaba.com>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH -v3 9/9] migrate_pages: move THP/hugetlb migration support check to simplify code
Date:   Mon, 16 Jan 2023 14:30:57 +0800
Message-Id: <20230116063057.653862-10-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230116063057.653862-1-ying.huang@intel.com>
References: <20230116063057.653862-1-ying.huang@intel.com>
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

This is a code cleanup patch, no functionality change is expected.
After the change, the line number reduces especially in the long
migrate_pages_batch().

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Alistair Popple <apopple@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: haoxin <xhao@linux.alibaba.com>
Cc: Minchan Kim <minchan@kernel.org>
---
 mm/migrate.c | 83 +++++++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 47 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8ccb61c49188..9d390368cf3f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1099,9 +1099,6 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 	bool locked = false;
 	bool dst_locked = false;
 
-	if (!thp_migration_supported() && folio_test_transhuge(src))
-		return -ENOSYS;
-
 	if (folio_ref_count(src) == 1) {
 		/* Folio was freed from under us. So we are done. */
 		folio_clear_active(src);
@@ -1358,16 +1355,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 
-	/*
-	 * Migratability of hugepages depends on architectures and their size.
-	 * This check is necessary because some callers of hugepage migration
-	 * like soft offline and memory hotremove don't walk through page
-	 * tables or check whether the hugepage is pmd-based or not before
-	 * kicking migration.
-	 */
-	if (!hugepage_migration_supported(page_hstate(hpage)))
-		return -ENOSYS;
-
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
 		putback_active_hugepage(hpage);
@@ -1534,6 +1521,20 @@ static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
 
 			cond_resched();
 
+			/*
+			 * Migratability of hugepages depends on architectures and
+			 * their size.  This check is necessary because some callers
+			 * of hugepage migration like soft offline and memory
+			 * hotremove don't walk through page tables or check whether
+			 * the hugepage is pmd-based or not before kicking migration.
+			 */
+			if (!hugepage_migration_supported(folio_hstate(folio))) {
+				nr_failed++;
+				stats->nr_failed_pages += nr_pages;
+				list_move_tail(&folio->lru, ret_folios);
+				continue;
+			}
+
 			rc = unmap_and_move_huge_page(get_new_page,
 						      put_new_page, private,
 						      &folio->page, pass > 2, mode,
@@ -1543,16 +1544,9 @@ static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
 			 *	Success: hugetlb folio will be put back
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
-			 *	-ENOSYS: stay on the from list
 			 *	Other errno: put on ret_folios list
 			 */
 			switch(rc) {
-			case -ENOSYS:
-				/* Hugetlb migration is unsupported */
-				nr_failed++;
-				stats->nr_failed_pages += nr_pages;
-				list_move_tail(&folio->lru, ret_folios);
-				break;
 			case -ENOMEM:
 				/*
 				 * When memory is low, don't bother to try to migrate
@@ -1638,6 +1632,28 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 
 			cond_resched();
 
+			/*
+			 * Large folio migration might be unsupported or
+			 * the allocation might be failed so we should retry
+			 * on the same folio with the large folio split
+			 * to normal folios.
+			 *
+			 * Split folios are put in split_folios, and
+			 * we will migrate them after the rest of the
+			 * list is processed.
+			 */
+			if (!thp_migration_supported() && is_thp) {
+				nr_large_failed++;
+				stats->nr_thp_failed++;
+				if (!try_split_folio(folio, &split_folios)) {
+					stats->nr_thp_split++;
+					continue;
+				}
+				stats->nr_failed_pages += nr_pages;
+				list_move_tail(&folio->lru, ret_folios);
+				continue;
+			}
+
 			rc = migrate_folio_unmap(get_new_page, put_new_page, private,
 						 folio, &dst, pass > 2, force_lock,
 						 mode, reason, ret_folios);
@@ -1649,36 +1665,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			 *	-EAGAIN: stay on the from list
 			 *	-EDEADLOCK: stay on the from list
 			 *	-ENOMEM: stay on the from list
-			 *	-ENOSYS: stay on the from list
 			 *	Other errno: put on ret_folios list
 			 */
 			switch(rc) {
-			/*
-			 * Large folio migration might be unsupported or
-			 * the allocation could've failed so we should retry
-			 * on the same folio with the large folio split
-			 * to normal folios.
-			 *
-			 * Split folios are put in split_folios, and
-			 * we will migrate them after the rest of the
-			 * list is processed.
-			 */
-			case -ENOSYS:
-				/* Large folio migration is unsupported */
-				if (is_large) {
-					nr_large_failed++;
-					stats->nr_thp_failed += is_thp;
-					if (!try_split_folio(folio, &split_folios)) {
-						stats->nr_thp_split += is_thp;
-						break;
-					}
-				} else if (!no_split_folio_counting) {
-					nr_failed++;
-				}
-
-				stats->nr_failed_pages += nr_pages;
-				list_move_tail(&folio->lru, ret_folios);
-				break;
 			case -ENOMEM:
 				/*
 				 * When memory is low, don't bother to try to migrate
-- 
2.35.1

