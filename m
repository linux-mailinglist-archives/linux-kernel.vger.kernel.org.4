Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004236945F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjBMMg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBMMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:36:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6D630F9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676291753; x=1707827753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dO4m0t0CfUL8xaVC72bSSWz5Mdmx3h1ISiajGHuEsMg=;
  b=Dqz+Iq6QvFlShoq9lUTXk9kEJFYnPxppIrrDva3iQYz9ftLhP3LNDm2M
   4/lh6mctT/GI3rrpFQeG9X8j21AWUYtueCsBEX8DmL1C+hcqz1uIm1AaR
   B7GGOjiaUv0Ocml0aSPy/DooOiJiDcj5qJc5cRIstJju+mCKdA3quFbB5
   fto8S+xQeDOPy2vKmRQW6qfXIDbnvlJpr9GfFD/Ivcw7GgoO10DDJbzyd
   qyhn6eQAy2zeZDjDZ1CzKAymqjP6q5/vl52vA3uA5/T0kZ/9C9FcE4Y5s
   upslzSwwjLfACG0SYWpSNf3InapwD+rLwYRlLu1QHXwcDRcUsVPiC1Cu4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="310513330"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310513330"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 04:35:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="646366670"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="646366670"
Received: from changxin-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.171])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 04:35:47 -0800
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
        Xin Hao <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH -v5 9/9] migrate_pages: move THP/hugetlb migration support check to simplify code
Date:   Mon, 13 Feb 2023 20:34:44 +0800
Message-Id: <20230213123444.155149-10-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230213123444.155149-1-ying.huang@intel.com>
References: <20230213123444.155149-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/migrate.c | 83 +++++++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 47 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2fa420e4f68c..ef68a1aff35c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1117,9 +1117,6 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 	bool locked = false;
 	bool dst_locked = false;
 
-	if (!thp_migration_supported() && folio_test_transhuge(src))
-		return -ENOSYS;
-
 	if (folio_ref_count(src) == 1) {
 		/* Folio was freed from under us. So we are done. */
 		folio_clear_active(src);
@@ -1380,16 +1377,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
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
 		folio_putback_active_hugetlb(src);
@@ -1556,6 +1543,20 @@ static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
 
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
@@ -1565,16 +1566,9 @@ static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
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
@@ -1664,6 +1658,28 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 
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
 						 folio, &dst, pass > 2, avoid_force_lock,
 						 mode, reason, ret_folios);
@@ -1675,36 +1691,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
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

