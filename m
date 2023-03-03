Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E804C6A8FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCCDCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjCCDCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:02:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F240258B61
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 19:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677812553; x=1709348553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6dOm2+hfvH1d/Mz6q4OoqdRr+NjQWevzknZQQER47XU=;
  b=CtOZoioXJ7ASFdPyhQbdxb7bWJykIGEU8SMPqp+ZB4xvPIqIA50DgwVS
   9WEjCgimanjZmsRs7yziHcSSzN8ZacUj3zhwaFkZNtxfA74z0lSnVRYEq
   d0YifGQaqnlBJzmohpkJi+GjhdRe0TE0qR+tUndEWXFFieW4QRZlUx9Iu
   ULHo+cOFAtRU25duC9urve/K3oWw09Td8RuT+nvsUnXpJSdzQLWl+sXj6
   /nfoSHI1nT3mXuMdB0bEXWSqi4tdwSJTTSzc0a05DLEThVQai5Sh2pjN7
   L51f5H7ity70JA6DIjIP0nmTvC87jd2SWzTGUkH42lMREGoq9DAGY0CHo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="421207150"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="421207150"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 19:02:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="668497706"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="668497706"
Received: from xinyumao-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.231])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 19:02:29 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH -V2 3/3] migrate_pages: try migrate in batch asynchronously firstly
Date:   Fri,  3 Mar 2023 11:01:55 +0800
Message-Id: <20230303030155.160983-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303030155.160983-1-ying.huang@intel.com>
References: <20230303030155.160983-1-ying.huang@intel.com>
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

When we have locked more than one folios, we cannot wait the lock or
bit (e.g., page lock, buffer head lock, writeback bit) synchronously.
Otherwise deadlock may be triggered.  This make it hard to batch the
synchronous migration directly.

This patch re-enables batching synchronous migration via trying to
migrate in batch asynchronously firstly.  And any folios that are
failed to be migrated asynchronously will be migrated synchronously
one by one.

Test shows that this can restore the TLB flushing batching performance
for synchronous migration effectively.

Fixes: 5dfab109d519 ("migrate_pages: batch _unmap and _move")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Tested-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Xu, Pengfei" <pengfei.xu@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: Tejun Heo <tj@kernel.org>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/migrate.c | 80 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 61009e2ae2be..ae86345e12a5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1115,9 +1115,8 @@ static void migrate_folio_done(struct folio *src,
 /* Obtain the lock on page, remove all ptes. */
 static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
 			       unsigned long private, struct folio *src,
-			       struct folio **dstp, int force,
-			       enum migrate_mode mode, enum migrate_reason reason,
-			       struct list_head *ret)
+			       struct folio **dstp, enum migrate_mode mode,
+			       enum migrate_reason reason, struct list_head *ret)
 {
 	struct folio *dst;
 	int rc = -EAGAIN;
@@ -1147,7 +1146,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 	dst->private = NULL;
 
 	if (!folio_trylock(src)) {
-		if (!force || mode == MIGRATE_ASYNC)
+		if (mode == MIGRATE_ASYNC)
 			goto out;
 
 		/*
@@ -1185,8 +1184,6 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 			rc = -EBUSY;
 			goto out;
 		}
-		if (!force)
-			goto out;
 		folio_wait_writeback(src);
 	}
 
@@ -1500,6 +1497,9 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
 #define NR_MAX_BATCHED_MIGRATION	512
 #endif
 #define NR_MAX_MIGRATE_PAGES_RETRY	10
+#define NR_MAX_MIGRATE_ASYNC_RETRY	3
+#define NR_MAX_MIGRATE_SYNC_RETRY					\
+	(NR_MAX_MIGRATE_PAGES_RETRY - NR_MAX_MIGRATE_ASYNC_RETRY)
 
 struct migrate_pages_stats {
 	int nr_succeeded;	/* Normal and large folios migrated successfully, in
@@ -1681,8 +1681,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			}
 
 			rc = migrate_folio_unmap(get_new_page, put_new_page, private,
-						 folio, &dst, pass > 2, mode,
-						 reason, ret_folios);
+						 folio, &dst, mode, reason, ret_folios);
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
@@ -1860,6 +1859,51 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	return rc;
 }
 
+static int migrate_pages_sync(struct list_head *from, new_page_t get_new_page,
+		free_page_t put_new_page, unsigned long private,
+		enum migrate_mode mode, int reason, struct list_head *ret_folios,
+		struct list_head *split_folios, struct migrate_pages_stats *stats)
+{
+	int rc, nr_failed = 0;
+	LIST_HEAD(folios);
+	struct migrate_pages_stats astats;
+
+	memset(&astats, 0, sizeof(astats));
+	/* Try to migrate in batch with MIGRATE_ASYNC mode firstly */
+	rc = migrate_pages_batch(from, get_new_page, put_new_page, private, MIGRATE_ASYNC,
+				 reason, &folios, split_folios, &astats,
+				 NR_MAX_MIGRATE_ASYNC_RETRY);
+	stats->nr_succeeded += astats.nr_succeeded;
+	stats->nr_thp_succeeded += astats.nr_thp_succeeded;
+	stats->nr_thp_split += astats.nr_thp_split;
+	if (rc < 0) {
+		stats->nr_failed_pages += astats.nr_failed_pages;
+		stats->nr_thp_failed += astats.nr_thp_failed;
+		list_splice_tail(&folios, ret_folios);
+		return rc;
+	}
+	stats->nr_thp_failed += astats.nr_thp_split;
+	nr_failed += astats.nr_thp_split;
+	/*
+	 * Fall back to migrate all failed folios one by one synchronously. All
+	 * failed folios except split THPs will be retried, so their failure
+	 * isn't counted
+	 */
+	list_splice_tail_init(&folios, from);
+	while (!list_empty(from)) {
+		list_move(from->next, &folios);
+		rc = migrate_pages_batch(&folios, get_new_page, put_new_page,
+					 private, mode, reason, ret_folios,
+					 split_folios, stats, NR_MAX_MIGRATE_SYNC_RETRY);
+		list_splice_tail_init(&folios, ret_folios);
+		if (rc < 0)
+			return rc;
+		nr_failed += rc;
+	}
+
+	return nr_failed;
+}
+
 /*
  * migrate_pages - migrate the folios specified in a list, to the free folios
  *		   supplied as the target for the page migration
@@ -1891,7 +1935,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
 {
 	int rc, rc_gather;
-	int nr_pages, batch;
+	int nr_pages;
 	struct folio *folio, *folio2;
 	LIST_HEAD(folios);
 	LIST_HEAD(ret_folios);
@@ -1907,10 +1951,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (rc_gather < 0)
 		goto out;
 
-	if (mode == MIGRATE_ASYNC)
-		batch = NR_MAX_BATCHED_MIGRATION;
-	else
-		batch = 1;
 again:
 	nr_pages = 0;
 	list_for_each_entry_safe(folio, folio2, from, lru) {
@@ -1921,16 +1961,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		}
 
 		nr_pages += folio_nr_pages(folio);
-		if (nr_pages >= batch)
+		if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
 			break;
 	}
-	if (nr_pages >= batch)
+	if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
 		list_cut_before(&folios, from, &folio2->lru);
 	else
 		list_splice_init(from, &folios);
-	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
-				 mode, reason, &ret_folios, &split_folios, &stats,
-				 NR_MAX_MIGRATE_PAGES_RETRY);
+	if (mode == MIGRATE_ASYNC)
+		rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
+					 mode, reason, &ret_folios, &split_folios, &stats,
+					 NR_MAX_MIGRATE_PAGES_RETRY);
+	else
+		rc = migrate_pages_sync(&folios, get_new_page, put_new_page, private,
+					mode, reason, &ret_folios, &split_folios, &stats);
 	list_splice_tail_init(&folios, &ret_folios);
 	if (rc < 0) {
 		rc_gather = rc;
-- 
2.39.2

