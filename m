Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E954669DC71
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjBUI7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBUI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:59:31 -0500
Received: from out-59.mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6212D1B31E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:59:29 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676969967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6LLYYj+4EDN3EITgWE7yjfrzPho+WEZBUlLZnSwu/kU=;
        b=N6pZTSQsdS1lgxPbuJr6cw74S1jUDX7OaVOdQgqLVqmX4TaUynhrwNlmKqJgUSACVY47YS
        F11eSK3d0sFA0ug7RsY1LN471LEX3Tfg/3Ii4+ARjCTRjfliiaY4kTwdld5LaODJCEL4LN
        n7NU9atHzol5IMTGSJbpe5D2joEA0ys=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm/hwpoison: convert TTU_IGNORE_HWPOISON to TTU_HWPOISON
Date:   Tue, 21 Feb 2023 17:59:05 +0900
Message-Id: <20230221085905.1465385-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

After a memory error happens on a clean folio, a process unexpectedly
receives SIGBUS when it accesses to the error page.  This SIGBUS killing
is pointless and simply degrades the level of RAS of the system, because
the clean folio can be dropped without any data lost on memory error
handling as we do for a clean pagecache.

When memory_failure() is called on a clean folio, try_to_unmap() is called
twice (one from split_huge_page() and one from hwpoison_user_mappings()).
The root cause of the issue is that pte conversion to hwpoisoned entry is
now done in the first call of try_to_unmap() because PageHWPoison is already
set at this point, while it's actually expected to be done in the second
call.  This behavior disturbs the error handling operation like removing
pagecache, which results in the malfunction described above.

So convert TTU_IGNORE_HWPOISON into TTU_HWPOISON and set TTU_HWPOISON only
when we really intend to convert pte to hwpoison entry.  This can prevent
other callers of try_to_unmap() from accidentally converting to hwpoison
entries.

Fixes: a42634a6c07d ("readahead: Use a folio in read_pages()")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: stable@vger.kernel.org # 5.18+
---
 include/linux/rmap.h | 2 +-
 mm/memory-failure.c  | 8 ++++----
 mm/rmap.c            | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index a4570da03e58..b87d01660412 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -94,7 +94,7 @@ enum ttu_flags {
 	TTU_SPLIT_HUGE_PMD	= 0x4,	/* split huge PMD if any */
 	TTU_IGNORE_MLOCK	= 0x8,	/* ignore mlock */
 	TTU_SYNC		= 0x10,	/* avoid racy checks with PVMW_SYNC */
-	TTU_IGNORE_HWPOISON	= 0x20,	/* corrupted page is recoverable */
+	TTU_HWPOISON		= 0x20,	/* do convert pte to hwpoison entry */
 	TTU_BATCH_FLUSH		= 0x40,	/* Batch TLB flushes where possible
 					 * and caller guarantees they will
 					 * do a final flush if necessary */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a1ede7bdce95..fae9baf3be16 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1069,7 +1069,7 @@ static int me_pagecache_dirty(struct page_state *ps, struct page *p)
  * cache and swap cache(ie. page is freshly swapped in). So it could be
  * referenced concurrently by 2 types of PTEs:
  * normal PTEs and swap PTEs. We try to handle them consistently by calling
- * try_to_unmap(TTU_IGNORE_HWPOISON) to convert the normal PTEs to swap PTEs,
+ * try_to_unmap(!TTU_HWPOISON) to convert the normal PTEs to swap PTEs,
  * and then
  *      - clear dirty bit to prevent IO
  *      - remove from LRU
@@ -1486,7 +1486,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 				  int flags, struct page *hpage)
 {
 	struct folio *folio = page_folio(hpage);
-	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC;
+	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC | TTU_HWPOISON;
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
 	bool unmap_success;
@@ -1516,7 +1516,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 
 	if (PageSwapCache(p)) {
 		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
-		ttu |= TTU_IGNORE_HWPOISON;
+		ttu &= ~TTU_HWPOISON;
 	}
 
 	/*
@@ -1531,7 +1531,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		if (page_mkclean(hpage)) {
 			SetPageDirty(hpage);
 		} else {
-			ttu |= TTU_IGNORE_HWPOISON;
+			ttu &= ~TTU_HWPOISON;
 			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
 				pfn);
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index 15ae24585fc4..8632e02661ac 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1602,7 +1602,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
-		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
+		if (PageHWPoison(subpage) && (flags & TTU_HWPOISON)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(folio_nr_pages(folio), mm);
-- 
2.25.1

