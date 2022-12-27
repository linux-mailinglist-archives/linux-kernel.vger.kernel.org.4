Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B323A656641
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 01:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiL0A3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 19:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiL0A3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 19:29:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006C26D0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 16:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672100969; x=1703636969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ZlE1166uwC0o6eW3hBf1ccltW3myzWM3kgZ5n2OLo4=;
  b=cKxwry+cLm8VI9ohZvCIsd/+F6+V0lTrTv1l9us7A0tfVyiSzR6RwtK3
   m987HpeyuRnrcftcGXVXvnCV7sXskpoPHh5UZ2v3P8cph5Mm1x6PfWmQY
   3W8awnmY2AW3dmaMPcRPJGTy0vOjTErweLZzjiamCfIXbdPUamkdTS5KG
   bkpfOVYmJz0EaI6/PNcneWKo7qxqCUoSFQhkTQW8snFMRQ3/Gz+GbTUhO
   BubGUg/rWIiDkHzFwA7dzKXzYzOjTsg3c8+FIoWUoes5P4XaHw5ze/ZBF
   gl4rJTTnlcKs4/dE019XGuYjAvlkzlMwoK6fMhrorP1TN0sDByGfFKnTf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322597208"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="322597208"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 16:29:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="760172186"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="760172186"
Received: from yyang3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.254.212.104])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 16:29:21 -0800
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
Subject: [PATCH 1/8] migrate_pages: organize stats with struct migrate_pages_stats
Date:   Tue, 27 Dec 2022 08:28:52 +0800
Message-Id: <20221227002859.27740-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221227002859.27740-1-ying.huang@intel.com>
References: <20221227002859.27740-1-ying.huang@intel.com>
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

Define struct migrate_pages_stats to organize the various statistics
in migrate_pages().  This makes it easier to collect and consume the
statistics in multiple functions.  This will be needed in the
following patches in the series.

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
 mm/migrate.c | 58 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a4d3fc65085f..ec9263a33d38 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1396,6 +1396,14 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
 	return rc;
 }
 
+struct migrate_pages_stats {
+	int nr_succeeded;
+	int nr_failed_pages;
+	int nr_thp_succeeded;
+	int nr_thp_failed;
+	int nr_thp_split;
+};
+
 /*
  * migrate_pages - migrate the folios specified in a list, to the free folios
  *		   supplied as the target for the page migration
@@ -1430,13 +1438,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1446,9 +1449,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	LIST_HEAD(split_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
 	bool no_split_folio_counting = false;
+	struct migrate_pages_stats stats;
 
 	trace_mm_migrate_pages_start(mode, reason);
 
+	memset(&stats, 0, sizeof(stats));
 split_folio_migration:
 	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
 		retry = 0;
@@ -1502,9 +1507,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1512,7 +1517,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_pages;
+				stats.nr_failed_pages += nr_pages;
 				list_move_tail(&folio->lru, &ret_folios);
 				break;
 			case -ENOMEM:
@@ -1522,13 +1527,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1546,7 +1551,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_pages + nr_retry_pages;
+				stats.nr_failed_pages += nr_pages + nr_retry_pages;
 				/*
 				 * There might be some split folios of fail-to-migrate large
 				 * folios left in split_folios list. Move them back to migration
@@ -1556,7 +1561,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				list_splice_init(&split_folios, from);
 				/* nr_failed isn't updated for not used */
 				nr_large_failed += large_retry;
-				nr_thp_failed += thp_retry;
+				stats.nr_thp_failed += thp_retry;
 				goto out;
 			case -EAGAIN:
 				if (is_large) {
@@ -1568,8 +1573,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1580,20 +1585,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1626,16 +1631,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

