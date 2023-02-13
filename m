Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6BB6945E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjBMMfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjBMMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:35:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D0413DE7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676291719; x=1707827719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+3xR+mdu+KvJS/5Kh2raKgnX+cbZNTvoyGmwX5GiZQ=;
  b=CaMvGrMqgnuNtHfoh4Fc/aM0MTBBJkTYBvukPSk5olh/W0S9pvwxDzuo
   ud8zmctUcC0OQbUViryuDgtLr/4J4rp1+jO8j366TrjfC1g8pcfneeBVP
   CvxpM97vnIK24e9sgSRySmGgLtN7YQM1DrOd/XNAoUl6SxRwmAT9ZCSsk
   jvdMBYFX6Kc2mtPmT5ouwXSpwSrtz+T3BW7i3Id6TjNzu9AM1UalvkJ9p
   R7u0eeyH+dPws6VVCArAlMhkanz64vmWtQFjQ/pyteo5rT5fnUHrczkqN
   n+mqdss4XcI5QwgHdKjFL4dv0IRS1jjFps/W3cv9mJ5Htlopyty0z0Nuw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="310513150"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310513150"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 04:35:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="646366593"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="646366593"
Received: from changxin-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.171])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 04:35:15 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH -v5 1/9] migrate_pages: organize stats with struct migrate_pages_stats
Date:   Mon, 13 Feb 2023 20:34:36 +0800
Message-Id: <20230213123444.155149-2-ying.huang@intel.com>
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

Define struct migrate_pages_stats to organize the various statistics
in migrate_pages().  This makes it easier to collect and consume the
statistics in multiple functions.  This will be needed in the
following patches in the series.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/migrate.c | 60 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5b40b9040ba6..1a9cfcf857d2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1414,6 +1414,16 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
 	return rc;
 }
 
+struct migrate_pages_stats {
+	int nr_succeeded;	/* Normal and large folios migrated successfully, in
+				   units of base pages */
+	int nr_failed_pages;	/* Normal and large folios failed to be migrated, in
+				   units of base pages.  Untried folios aren't counted */
+	int nr_thp_succeeded;	/* THP migrated successfully */
+	int nr_thp_failed;	/* THP failed to be migrated */
+	int nr_thp_split;	/* THP split before migrating */
+};
+
 /*
  * migrate_pages - migrate the folios specified in a list, to the free folios
  *		   supplied as the target for the page migration
@@ -1448,13 +1458,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int large_retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
-	int nr_failed_pages = 0;
 	int nr_retry_pages = 0;
-	int nr_succeeded = 0;
-	int nr_thp_succeeded = 0;
 	int nr_large_failed = 0;
-	int nr_thp_failed = 0;
-	int nr_thp_split = 0;
 	int pass = 0;
 	bool is_large = false;
 	bool is_thp = false;
@@ -1464,9 +1469,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	LIST_HEAD(split_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
 	bool no_split_folio_counting = false;
+	struct migrate_pages_stats stats;
 
 	trace_mm_migrate_pages_start(mode, reason);
 
+	memset(&stats, 0, sizeof(stats));
 split_folio_migration:
 	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
 		retry = 0;
@@ -1520,9 +1527,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				/* Large folio migration is unsupported */
 				if (is_large) {
 					nr_large_failed++;
-					nr_thp_failed += is_thp;
+					stats.nr_thp_failed += is_thp;
 					if (!try_split_folio(folio, &split_folios)) {
-						nr_thp_split += is_thp;
+						stats.nr_thp_split += is_thp;
 						break;
 					}
 				/* Hugetlb migration is unsupported */
@@ -1530,7 +1537,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_pages;
+				stats.nr_failed_pages += nr_pages;
 				list_move_tail(&folio->lru, &ret_folios);
 				break;
 			case -ENOMEM:
@@ -1540,13 +1547,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				if (is_large) {
 					nr_large_failed++;
-					nr_thp_failed += is_thp;
+					stats.nr_thp_failed += is_thp;
 					/* Large folio NUMA faulting doesn't split to retry. */
 					if (!nosplit) {
 						int ret = try_split_folio(folio, &split_folios);
 
 						if (!ret) {
-							nr_thp_split += is_thp;
+							stats.nr_thp_split += is_thp;
 							break;
 						} else if (reason == MR_LONGTERM_PIN &&
 							   ret == -EAGAIN) {
@@ -1564,7 +1571,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_pages + nr_retry_pages;
+				stats.nr_failed_pages += nr_pages + nr_retry_pages;
 				/*
 				 * There might be some split folios of fail-to-migrate large
 				 * folios left in split_folios list. Move them back to migration
@@ -1574,7 +1581,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				list_splice_init(&split_folios, from);
 				/* nr_failed isn't updated for not used */
 				nr_large_failed += large_retry;
-				nr_thp_failed += thp_retry;
+				stats.nr_thp_failed += thp_retry;
 				goto out;
 			case -EAGAIN:
 				if (is_large) {
@@ -1586,8 +1593,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				nr_retry_pages += nr_pages;
 				break;
 			case MIGRATEPAGE_SUCCESS:
-				nr_succeeded += nr_pages;
-				nr_thp_succeeded += is_thp;
+				stats.nr_succeeded += nr_pages;
+				stats.nr_thp_succeeded += is_thp;
 				break;
 			default:
 				/*
@@ -1598,20 +1605,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				if (is_large) {
 					nr_large_failed++;
-					nr_thp_failed += is_thp;
+					stats.nr_thp_failed += is_thp;
 				} else if (!no_split_folio_counting) {
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_pages;
+				stats.nr_failed_pages += nr_pages;
 				break;
 			}
 		}
 	}
 	nr_failed += retry;
 	nr_large_failed += large_retry;
-	nr_thp_failed += thp_retry;
-	nr_failed_pages += nr_retry_pages;
+	stats.nr_thp_failed += thp_retry;
+	stats.nr_failed_pages += nr_retry_pages;
 	/*
 	 * Try to migrate split folios of fail-to-migrate large folios, no
 	 * nr_failed counting in this round, since all split folios of a
@@ -1644,16 +1651,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (list_empty(from))
 		rc = 0;
 
-	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
-	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
-	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
-	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
-	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
-	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
-			       nr_thp_failed, nr_thp_split, mode, reason);
+	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
+	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
+	count_vm_events(THP_MIGRATION_SUCCESS, stats.nr_thp_succeeded);
+	count_vm_events(THP_MIGRATION_FAIL, stats.nr_thp_failed);
+	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
+	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
+			       stats.nr_thp_succeeded, stats.nr_thp_failed,
+			       stats.nr_thp_split, mode, reason);
 
 	if (ret_succeeded)
-		*ret_succeeded = nr_succeeded;
+		*ret_succeeded = stats.nr_succeeded;
 
 	return rc;
 }
-- 
2.35.1

