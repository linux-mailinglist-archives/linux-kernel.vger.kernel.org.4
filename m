Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258F06A1D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBXOMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjBXOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:12:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C87169AF6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677247943; x=1708783943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dxby7yNPzwalm19ztka4+4UYeHwqmfCE4JJYZx6x6X0=;
  b=FVryWDEezEQUTH30h6wK5CQXpb+8MAttxCZ+JGNizUmjiL8DxHqOj+WP
   VBjCfKNgok2ybcUXSCGhJZXAXaUKm+ifcki8ZlyXpWRDnmnlTyl46ljXv
   TTCSq6zXrpkJ22vs/D74lnPAAFHpa7cnrPl8EoG3Ob1w3BOBBdILPbOXW
   +3xX6swV7hmPWYJl2JR0TZ3PP851aCjtez6HN7kHidufiiYcmckHngEFc
   UFWPHH6coAqGwLGmezIvatptI+2Jk50CWvrSnGwo5oyn8fWUUIlZvuFOl
   Mc1vuGdATYGNA0h5gOGvEQn9ByuwQam/2O7ogPRnZ2MGTsQhFXWveq5nt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="332167736"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="332167736"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:12:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="741684670"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="741684670"
Received: from bingqili-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.19])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:12:19 -0800
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
Subject: [PATCH 3/3] migrate_pages: try migrate in batch asynchronously firstly
Date:   Fri, 24 Feb 2023 22:11:45 +0800
Message-Id: <20230224141145.96814-4-ying.huang@intel.com>
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
 mm/migrate.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 91198b487e49..c17ce5ee8d92 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1843,6 +1843,51 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
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
+				 NR_MAX_MIGRATE_PAGES_RETRY);
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
+					 split_folios, stats, NR_MAX_MIGRATE_PAGES_RETRY);
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
@@ -1874,7 +1919,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
 {
 	int rc, rc_gather;
-	int nr_pages, batch;
+	int nr_pages;
 	struct folio *folio, *folio2;
 	LIST_HEAD(folios);
 	LIST_HEAD(ret_folios);
@@ -1890,10 +1935,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (rc_gather < 0)
 		goto out;
 
-	if (mode == MIGRATE_ASYNC)
-		batch = NR_MAX_BATCHED_MIGRATION;
-	else
-		batch = 1;
 again:
 	nr_pages = 0;
 	list_for_each_entry_safe(folio, folio2, from, lru) {
@@ -1904,16 +1945,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
2.39.1

