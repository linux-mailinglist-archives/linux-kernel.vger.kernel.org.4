Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B576A1D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBXOMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBXOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:12:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654C6C64F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677247939; x=1708783939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CZw3zTaszsFTuJAllktsjeXaRcVC/hbLzU4WTsAVGdY=;
  b=Oz0JiF4m1K01jpcNo4vIjiohFTTzVk/ZFFJKMRfnsoSnsha6nXuUKxaQ
   HGSGdiCYI0V4r46mokMj0rwDzOsbgXnYeSec33ZzChMorcnJBZ6JFRe0N
   IiygUdHwmQqUqikD/40+WZVdzTx+7k3w+kS+ZqDb4VbwCoR7SWaTlNm3p
   fLIdf/06mrRVHb77TKNEE9POjoP79on9pB5fMuzUtm4dwanFZkpl/N7Jc
   9JrzMwoH5x+qCJaEli8qavSJsm5s6QjZYk5idFFocH5P4RHn8/dJYBOHK
   m4Cd/RTQgaYmYoxt/xrz52+xj0iH0YDr59aiqZMU2uIyflU8ChONBSgK+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="332167711"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="332167711"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:12:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="741684659"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="741684659"
Received: from bingqili-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.19])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:12:15 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/3] migrate_pages: move split folios processing out of migrate_pages_batch()
Date:   Fri, 24 Feb 2023 22:11:44 +0800
Message-Id: <20230224141145.96814-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224141145.96814-1-ying.huang@intel.com>
References: <20230224141145.96814-1-ying.huang@intel.com>
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

To simplify the code logic and reduce the line number.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: "Xu, Pengfei" <pengfei.xu@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: Tejun Heo <tj@kernel.org>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/migrate.c | 76 ++++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 50 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7ac37dbbf307..91198b487e49 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1605,9 +1605,10 @@ static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
 static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
 		enum migrate_mode mode, int reason, struct list_head *ret_folios,
-		struct migrate_pages_stats *stats)
+		struct list_head *split_folios, struct migrate_pages_stats *stats,
+		int nr_pass)
 {
-	int retry;
+	int retry = 1;
 	int large_retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
@@ -1617,19 +1618,12 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	bool is_large = false;
 	bool is_thp = false;
 	struct folio *folio, *folio2, *dst = NULL, *dst2;
-	int rc, rc_saved, nr_pages;
-	LIST_HEAD(split_folios);
+	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
-	bool no_split_folio_counting = false;
 
-retry:
-	rc_saved = 0;
-	retry = 1;
-	for (pass = 0;
-	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
-	     pass++) {
+	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
 		retry = 0;
 		large_retry = 0;
 		thp_retry = 0;
@@ -1660,7 +1654,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			if (!thp_migration_supported() && is_thp) {
 				nr_large_failed++;
 				stats->nr_thp_failed++;
-				if (!try_split_folio(folio, &split_folios)) {
+				if (!try_split_folio(folio, split_folios)) {
 					stats->nr_thp_split++;
 					continue;
 				}
@@ -1692,7 +1686,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 					stats->nr_thp_failed += is_thp;
 					/* Large folio NUMA faulting doesn't split to retry. */
 					if (!nosplit) {
-						int ret = try_split_folio(folio, &split_folios);
+						int ret = try_split_folio(folio, split_folios);
 
 						if (!ret) {
 							stats->nr_thp_split += is_thp;
@@ -1709,18 +1703,11 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 							break;
 						}
 					}
-				} else if (!no_split_folio_counting) {
+				} else {
 					nr_failed++;
 				}
 
 				stats->nr_failed_pages += nr_pages + nr_retry_pages;
-				/*
-				 * There might be some split folios of fail-to-migrate large
-				 * folios left in split_folios list. Move them to ret_folios
-				 * list so that they could be put back to the right list by
-				 * the caller otherwise the folio refcnt will be leaked.
-				 */
-				list_splice_init(&split_folios, ret_folios);
 				/* nr_failed isn't updated for not used */
 				nr_large_failed += large_retry;
 				stats->nr_thp_failed += thp_retry;
@@ -1733,7 +1720,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				if (is_large) {
 					large_retry++;
 					thp_retry += is_thp;
-				} else if (!no_split_folio_counting) {
+				} else {
 					retry++;
 				}
 				nr_retry_pages += nr_pages;
@@ -1756,7 +1743,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				if (is_large) {
 					nr_large_failed++;
 					stats->nr_thp_failed += is_thp;
-				} else if (!no_split_folio_counting) {
+				} else {
 					nr_failed++;
 				}
 
@@ -1774,9 +1761,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	try_to_unmap_flush();
 
 	retry = 1;
-	for (pass = 0;
-	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
-	     pass++) {
+	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
 		retry = 0;
 		large_retry = 0;
 		thp_retry = 0;
@@ -1805,7 +1790,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				if (is_large) {
 					large_retry++;
 					thp_retry += is_thp;
-				} else if (!no_split_folio_counting) {
+				} else {
 					retry++;
 				}
 				nr_retry_pages += nr_pages;
@@ -1818,7 +1803,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				if (is_large) {
 					nr_large_failed++;
 					stats->nr_thp_failed += is_thp;
-				} else if (!no_split_folio_counting) {
+				} else {
 					nr_failed++;
 				}
 
@@ -1855,27 +1840,6 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		dst2 = list_next_entry(dst, lru);
 	}
 
-	/*
-	 * Try to migrate split folios of fail-to-migrate large folios, no
-	 * nr_failed counting in this round, since all split folios of a
-	 * large folio is counted as 1 failure in the first round.
-	 */
-	if (rc >= 0 && !list_empty(&split_folios)) {
-		/*
-		 * Move non-migrated folios (after NR_MAX_MIGRATE_PAGES_RETRY
-		 * retries) to ret_folios to avoid migrating them again.
-		 */
-		list_splice_init(from, ret_folios);
-		list_splice_init(&split_folios, from);
-		/*
-		 * Force async mode to avoid to wait lock or bit when we have
-		 * locked more than one folios.
-		 */
-		mode = MIGRATE_ASYNC;
-		no_split_folio_counting = true;
-		goto retry;
-	}
-
 	return rc;
 }
 
@@ -1914,6 +1878,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	struct folio *folio, *folio2;
 	LIST_HEAD(folios);
 	LIST_HEAD(ret_folios);
+	LIST_HEAD(split_folios);
 	struct migrate_pages_stats stats;
 
 	trace_mm_migrate_pages_start(mode, reason);
@@ -1947,12 +1912,23 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	else
 		list_splice_init(from, &folios);
 	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
-				 mode, reason, &ret_folios, &stats);
+				 mode, reason, &ret_folios, &split_folios, &stats,
+				 NR_MAX_MIGRATE_PAGES_RETRY);
 	list_splice_tail_init(&folios, &ret_folios);
 	if (rc < 0) {
 		rc_gather = rc;
+		list_splice_tail(&split_folios, &ret_folios);
 		goto out;
 	}
+	if (!list_empty(&split_folios)) {
+		/*
+		 * Failure isn't counted since all split folios of a large folio
+		 * is counted as 1 failure already.
+		 */
+		migrate_pages_batch(&split_folios, get_new_page, put_new_page, private,
+				    MIGRATE_ASYNC, reason, &ret_folios, NULL, &stats, 1);
+		list_splice_tail_init(&split_folios, &ret_folios);
+	}
 	rc_gather += rc;
 	if (!list_empty(from))
 		goto again;
-- 
2.39.1

