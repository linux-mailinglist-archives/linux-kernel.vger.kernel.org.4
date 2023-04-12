Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDE96DE95F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjDLCSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLCS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:18:28 -0400
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C761BC8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 19:18:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681265905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W/v2ryAK8CZAUHZdTuLslXGytUbsEmu0tAq5CoDbGJs=;
        b=EVpb+ENN6jARMNpd9ix9+37hPTwMi456eyAuIvSLabLqBeRfKRmP6p6QyuVbSN2FEoJ9kN
        bQ1+GzDLNdrLqAhkz5QLTZcMPzYdNw8qDfLrXWPI1mOTVkDEhMD9kwGwRe3Dzv7cxRiumv
        yUWTnwmeTyd2PPTkQ5z1D8UEeOfd4cI=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/rmap: convert __page_{set, check}_anon_rmap() to folios
Date:   Wed, 12 Apr 2023 10:18:11 +0800
Message-Id: <20230412021811.1503281-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2nd parameter in __page_set_anon_rmap() is only used by
SetPageAnonExclusive(), so there is no need to put
SetPageAnonExclusive() in  __page_set_anon_rmap().

Remove SetPageAnonExclusive() from __page_set_anon_rmap() and modify
__page_set_anon_rmap() to __folio_set_anon_rmap().

Since __page_check_anon_rmap() needs a folio, we can directly use
and change it to __folio_check_anon_rmap().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/rmap.c | 54 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index ba901c416785..8dc71caa208f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1129,14 +1129,13 @@ void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
 }
 
 /**
- * __page_set_anon_rmap - set up new anonymous rmap
- * @folio:	Folio which contains page.
- * @page:	Page to add to rmap.
+ * __folio_set_anon_rmap - set up new anonymous rmap
+ * @folio:	Folio to add to rmap.
  * @vma:	VM area to add page to.
  * @address:	User virtual address of the mapping	
  * @exclusive:	the page is exclusively owned by the current process
  */
-static void __page_set_anon_rmap(struct folio *folio, struct page *page,
+static void __folio_set_anon_rmap(struct folio *folio,
 	struct vm_area_struct *vma, unsigned long address, int exclusive)
 {
 	struct anon_vma *anon_vma = vma->anon_vma;
@@ -1144,7 +1143,7 @@ static void __page_set_anon_rmap(struct folio *folio, struct page *page,
 	BUG_ON(!anon_vma);
 
 	if (folio_test_anon(folio))
-		goto out;
+		return;
 
 	/*
 	 * If the page isn't exclusively mapped into this vma,
@@ -1163,21 +1162,17 @@ static void __page_set_anon_rmap(struct folio *folio, struct page *page,
 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 	WRITE_ONCE(folio->mapping, (struct address_space *) anon_vma);
 	folio->index = linear_page_index(vma, address);
-out:
-	if (exclusive)
-		SetPageAnonExclusive(page);
 }
 
 /**
- * __page_check_anon_rmap - sanity check anonymous rmap addition
- * @page:	the page to add the mapping to
+ * __folio_check_anon_rmap - sanity check anonymous rmap addition
+ * @folio:	the folio to add the mapping to
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
  */
-static void __page_check_anon_rmap(struct page *page,
+static void __folio_check_anon_rmap(struct folio *folio,
 	struct vm_area_struct *vma, unsigned long address)
 {
-	struct folio *folio = page_folio(page);
 	/*
 	 * The page's anon-rmap details (mapping and index) are guaranteed to
 	 * be set up correctly at this point.
@@ -1191,8 +1186,8 @@ static void __page_check_anon_rmap(struct page *page,
 	 */
 	VM_BUG_ON_FOLIO(folio_anon_vma(folio)->root != vma->anon_vma->root,
 			folio);
-	VM_BUG_ON_PAGE(page_to_pgoff(page) != linear_page_index(vma, address),
-		       page);
+	VM_BUG_ON_FOLIO(folio_pgoff(folio) != linear_page_index(vma, address),
+		       folio);
 }
 
 /**
@@ -1214,6 +1209,7 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	int nr = 0, nr_pmdmapped = 0;
 	bool compound = flags & RMAP_COMPOUND;
+	bool exclusive = !!(flags & RMAP_EXCLUSIVE);
 	bool first = true;
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
@@ -1243,7 +1239,7 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		}
 	}
 
-	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
+	VM_BUG_ON_PAGE(!first && exclusive, page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
 
 	if (nr_pmdmapped)
@@ -1253,11 +1249,12 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 
 	if (likely(!folio_test_ksm(folio))) {
 		/* address might be in next vma when migration races vma_merge */
-		if (first)
-			__page_set_anon_rmap(folio, page, vma, address,
-					     !!(flags & RMAP_EXCLUSIVE));
-		else
-			__page_check_anon_rmap(page, vma, address);
+		if (first) {
+			__folio_set_anon_rmap(folio, vma, address, exclusive);
+			if (exclusive)
+				SetPageAnonExclusive(page);
+		} else
+			__folio_check_anon_rmap(folio, vma, address);
 	}
 
 	mlock_vma_folio(folio, vma, compound);
@@ -1297,7 +1294,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	}
 
 	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
-	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
+	__folio_set_anon_rmap(folio, vma, address, 1);
+	SetPageAnonExclusive(&folio->page);
 }
 
 /**
@@ -2533,17 +2531,20 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 {
 	struct folio *folio = page_folio(page);
 	struct anon_vma *anon_vma = vma->anon_vma;
+	bool exclusive = !!(flags & RMAP_EXCLUSIVE);
 	int first;
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(!anon_vma);
 	/* address might be in next vma when migration races vma_merge */
 	first = atomic_inc_and_test(&folio->_entire_mapcount);
-	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
+	VM_BUG_ON_PAGE(!first && exclusive, page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
-	if (first)
-		__page_set_anon_rmap(folio, page, vma, address,
-				     !!(flags & RMAP_EXCLUSIVE));
+	if (first) {
+		__folio_set_anon_rmap(folio, vma, address, exclusive);
+		if (exclusive)
+			SetPageAnonExclusive(page);
+	}
 }
 
 void hugepage_add_new_anon_rmap(struct folio *folio,
@@ -2553,6 +2554,7 @@ void hugepage_add_new_anon_rmap(struct folio *folio,
 	/* increment count (starts at -1) */
 	atomic_set(&folio->_entire_mapcount, 0);
 	folio_clear_hugetlb_restore_reserve(folio);
-	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
+	__folio_set_anon_rmap(folio, vma, address, 1);
+	SetPageAnonExclusive(&folio->page);
 }
 #endif /* CONFIG_HUGETLB_PAGE */
-- 
2.25.1

