Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418796173DF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKCBvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKCBvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:51:44 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933811462
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:51:42 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id x15so266944qvp.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 18:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrl6S05W22u20FHCCunI78BM8DeB3M7AjvD0RR/SjhU=;
        b=qOWmQ7WW6uvqdHABUpFe1kaB03SbJVt0Q5fJ91YUE4+gax+G9jYWzshfF0Ayt3qwS2
         pe50gQUYXuJ70Fb+eCy2Jfpd0M+aZ3P/JOUP/bsgMCG1Z9fbFOwJxs7WuQb5+DYRr4Kv
         aA9bJ9e3aK9iZMYKC4CEyFSt9SUC6ocJl2fzrMQ8ntB0E/L/7Ixof5wdF+zIIshT1sTZ
         HxUtmeNScX4WQf3kqzGXS43gvpwkfh49DRnoKgXYiMtlU+f30raJTPXVsMSt/0SCmvmn
         AvmlTDFrFiItDuWyzVVSFQvd9sqmLVas6X31lvp0lIWINKvziEavwsb+/cjJurxSpftR
         YDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrl6S05W22u20FHCCunI78BM8DeB3M7AjvD0RR/SjhU=;
        b=ZGpElerBAxUvKsHzYgoYQjTMU0gDKfvg4M62vAlyUwS7I04+k6N/gIrgd3wSH0Do15
         k5PTjCgqZK/d4HmgpjxTR/q8oxVBtRzVLWqiiM/kdyj3oOgMOX4Tl6M9fQPp/dw7+RZ0
         19kcI27ZhUgIJ+ayKNzoizqYsrzZF0KxUhmgxRxA/ZniiHAqhVRVp3bi8ul6ACsiMJQV
         FTWaRuYbkZHfaY66SWu55iEC247KNyXFnyF11MZg+ApOffyph3+xRqVGaOAj6fb9dd+L
         eefBRvgohnU1jTivt2U1Ss6cPrsNnnmjFGX+L/T5uokviLYmne2nH680UHJNt7nqORsw
         zgpQ==
X-Gm-Message-State: ACrzQf2JN8rloQJrsNGhijC5d6Z0zjggAtWkLOJdTQmj6CCcey0PZySB
        r2gq4/IBUVUHu2Wkd3S2vHx+2w==
X-Google-Smtp-Source: AMsMyM5yofnhAKFjSqf5630o2cZc3m8jkM0vU/myDS4CcOWeE2eq5rMvnFVybJQj8isIORuXK1zoKg==
X-Received: by 2002:a05:6214:27c1:b0:4b4:9f69:dd5e with SMTP id ge1-20020a05621427c100b004b49f69dd5emr24354308qvb.56.1667440301045;
        Wed, 02 Nov 2022 18:51:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x13-20020ac86b4d000000b003988b3d5280sm7499601qts.70.2022.11.02.18.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 18:51:40 -0700 (PDT)
Date:   Wed, 2 Nov 2022 18:51:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/3] mm,thp,rmap: simplify compound page mapcount handling
In-Reply-To: <5f52de70-975-e94f-f141-543765736181@google.com>
Message-ID: <47ad693-717-79c8-e1ba-46c3a6602e48@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compound page (folio) mapcount calculations have been different for
anon and file (or shmem) THPs, and involved the obscure PageDoubleMap
flag.  And each huge mapping and unmapping of a file (or shmem) THP
involved atomically incrementing and decrementing the mapcount of every
subpage of that huge page, dirtying many struct page cachelines.

Add subpages_mapcount field to the struct folio and first tail page,
so that the total of subpage mapcounts is available in one place near
the head: then page_mapcount() and total_mapcount() and page_mapped(),
and their folio equivalents, are so quick that anon and file and hugetlb
don't need to be optimized differently. Delete the unloved PageDoubleMap.

page_add and page_remove rmap functions must now maintain the
subpages_mapcount as well as the subpage _mapcount, when dealing with
pte mappings of huge pages; and correct maintenance of NR_ANON_MAPPED
and NR_FILE_MAPPED statistics still needs reading through the subpages,
using nr_subpages_unmapped() - but only when first or last pmd mapping
finds subpages_mapcount raised (double-map case, not the common case).

But are those counts (used to decide when to split an anon THP, and
in vmscan's pagecache_reclaimable heuristic) correctly maintained?
Not quite: since page_remove_rmap() (and also split_huge_pmd()) is
often called without page lock, there can be races when a subpage pte
mapcount 0<->1 while compound pmd mapcount 0<->1 is scanning - races
which the previous implementation had prevented. The statistics might
become inaccurate, and even drift down until they underflow through 0.
That is not good enough, but is better dealt with in a followup patch.

Update a few comments on first and second tail page overlaid fields.
hugepage_add_new_anon_rmap() has to "increment" compound_mapcount, but
subpages_mapcount and compound_pincount are already correctly at 0,
so delete its reinitialization of compound_pincount.

A simple 100 X munmap(mmap(2GB, MAP_SHARED|MAP_POPULATE, tmpfs), 2GB)
took 18 seconds on small pages, and used to take 1 second on huge pages,
but now takes 119 milliseconds on huge pages.  Mapping by pmds a second
time used to take 860ms and now takes 92ms; mapping by pmds after mapping
by ptes (when the scan is needed) used to take 870ms and now takes 495ms.
But there might be some benchmarks which would show a slowdown, because
tail struct pages now fall out of cache until final freeing checks them.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 Documentation/mm/transhuge.rst |  18 -----
 include/linux/mm.h             |  85 ++++++++++++++------
 include/linux/mm_types.h       |  21 ++++-
 include/linux/page-flags.h     |  21 -----
 include/linux/rmap.h           |   2 +
 mm/debug.c                     |   5 +-
 mm/folio-compat.c              |   6 --
 mm/huge_memory.c               |  36 ++-------
 mm/hugetlb.c                   |   2 +
 mm/khugepaged.c                |  11 +--
 mm/page_alloc.c                |  27 ++++---
 mm/rmap.c                      | 142 +++++++++++++++++++--------------
 mm/util.c                      |  79 ------------------
 13 files changed, 194 insertions(+), 261 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index 216db1d67d04..a560e0c01b16 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -125,24 +125,6 @@ pages:
     ->_mapcount of all sub-pages in order to have race-free detection of
     last unmap of subpages.
 
-PageDoubleMap() indicates that the page is *possibly* mapped with PTEs.
-
-For anonymous pages, PageDoubleMap() also indicates ->_mapcount in all
-subpages is offset up by one. This additional reference is required to
-get race-free detection of unmap of subpages when we have them mapped with
-both PMDs and PTEs.
-
-This optimization is required to lower the overhead of per-subpage mapcount
-tracking. The alternative is to alter ->_mapcount in all subpages on each
-map/unmap of the whole compound page.
-
-For anonymous pages, we set PG_double_map when a PMD of the page is split
-for the first time, but still have a PMD mapping. The additional references
-go away with the last compound_mapcount.
-
-File pages get PG_double_map set on the first map of the page with PTE and
-goes away when the page gets evicted from the page cache.
-
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
 structures. It can be done easily for refcounts taken by page table
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 25ff9a14a777..5b99e3216a23 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -818,8 +818,8 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 /*
  * How many times the entire folio is mapped as a single unit (eg by a
  * PMD or PUD entry).  This is probably not what you want, except for
- * debugging purposes; look at folio_mapcount() or page_mapcount()
- * instead.
+ * debugging purposes - it does not include PTE-mapped sub-pages; look
+ * at folio_mapcount() or page_mapcount() or total_mapcount() instead.
  */
 static inline int folio_entire_mapcount(struct folio *folio)
 {
@@ -829,12 +829,20 @@ static inline int folio_entire_mapcount(struct folio *folio)
 
 /*
  * Mapcount of compound page as a whole, does not include mapped sub-pages.
- *
- * Must be called only for compound pages.
+ * Must be called only on head of compound page.
  */
-static inline int compound_mapcount(struct page *page)
+static inline int head_compound_mapcount(struct page *head)
 {
-	return folio_entire_mapcount(page_folio(page));
+	return atomic_read(compound_mapcount_ptr(head)) + 1;
+}
+
+/*
+ * Sum of mapcounts of sub-pages, does not include compound mapcount.
+ * Must be called only on head of compound page.
+ */
+static inline int head_subpages_mapcount(struct page *head)
+{
+	return atomic_read(subpages_mapcount_ptr(head));
 }
 
 /*
@@ -847,11 +855,9 @@ static inline void page_mapcount_reset(struct page *page)
 	atomic_set(&(page)->_mapcount, -1);
 }
 
-int __page_mapcount(struct page *page);
-
 /*
  * Mapcount of 0-order page; when compound sub-page, includes
- * compound_mapcount().
+ * compound_mapcount of compound_head of page.
  *
  * Result is undefined for pages which cannot be mapped into userspace.
  * For example SLAB or special types of pages. See function page_has_type().
@@ -859,25 +865,61 @@ int __page_mapcount(struct page *page);
  */
 static inline int page_mapcount(struct page *page)
 {
-	if (unlikely(PageCompound(page)))
-		return __page_mapcount(page);
-	return atomic_read(&page->_mapcount) + 1;
-}
+	int mapcount = atomic_read(&page->_mapcount) + 1;
 
-int folio_mapcount(struct folio *folio);
+	if (likely(!PageCompound(page)))
+		return mapcount;
+	page = compound_head(page);
+	return head_compound_mapcount(page) + mapcount;
+}
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int total_mapcount(struct page *page)
 {
-	return folio_mapcount(page_folio(page));
+	if (likely(!PageCompound(page)))
+		return atomic_read(&page->_mapcount) + 1;
+	page = compound_head(page);
+	return head_compound_mapcount(page) + head_subpages_mapcount(page);
 }
 
-#else
-static inline int total_mapcount(struct page *page)
+/*
+ * Return true if this page is mapped into pagetables.
+ * For compound page it returns true if any subpage of compound page is mapped,
+ * even if this particular subpage is not itself mapped by any PTE or PMD.
+ */
+static inline bool page_mapped(struct page *page)
 {
-	return page_mapcount(page);
+	return total_mapcount(page) > 0;
+}
+
+/**
+ * folio_mapcount() - Calculate the number of mappings of this folio.
+ * @folio: The folio.
+ *
+ * A large folio tracks both how many times the entire folio is mapped,
+ * and how many times each individual page in the folio is mapped.
+ * This function calculates the total number of times the folio is
+ * mapped.
+ *
+ * Return: The number of times this folio is mapped.
+ */
+static inline int folio_mapcount(struct folio *folio)
+{
+	if (likely(!folio_test_large(folio)))
+		return atomic_read(&folio->_mapcount) + 1;
+	return atomic_read(folio_mapcount_ptr(folio)) + 1 +
+		atomic_read(folio_subpages_mapcount_ptr(folio));
+}
+
+/**
+ * folio_mapped - Is this folio mapped into userspace?
+ * @folio: The folio.
+ *
+ * Return: True if any page in this folio is referenced by user page tables.
+ */
+static inline bool folio_mapped(struct folio *folio)
+{
+	return folio_mapcount(folio) > 0;
 }
-#endif
 
 static inline struct page *virt_to_head_page(const void *x)
 {
@@ -1770,9 +1812,6 @@ static inline pgoff_t page_index(struct page *page)
 	return page->index;
 }
 
-bool page_mapped(struct page *page);
-bool folio_mapped(struct folio *folio);
-
 /*
  * Return true only if the page has been allocated with
  * ALLOC_NO_WATERMARKS and the low watermark was not
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 728eb6089bba..069620826a19 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -142,6 +142,7 @@ struct page {
 			unsigned char compound_dtor;
 			unsigned char compound_order;
 			atomic_t compound_mapcount;
+			atomic_t subpages_mapcount;
 			atomic_t compound_pincount;
 #ifdef CONFIG_64BIT
 			unsigned int compound_nr; /* 1 << compound_order */
@@ -270,7 +271,8 @@ struct page {
  * @_head_1: Points to the folio.  Do not use.
  * @_folio_dtor: Which destructor to use for this folio.
  * @_folio_order: Do not use directly, call folio_order().
- * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
+ * @_compound_mapcount: Do not use directly, call folio_entire_mapcount().
+ * @_subpages_mapcount: Do not use directly, call folio_mapcount().
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
@@ -321,7 +323,8 @@ struct folio {
 			unsigned long _head_1;
 			unsigned char _folio_dtor;
 			unsigned char _folio_order;
-			atomic_t _total_mapcount;
+			atomic_t _compound_mapcount;
+			atomic_t _subpages_mapcount;
 			atomic_t _pincount;
 #ifdef CONFIG_64BIT
 			unsigned int _folio_nr_pages;
@@ -363,7 +366,8 @@ FOLIO_MATCH(flags, _flags_1);
 FOLIO_MATCH(compound_head, _head_1);
 FOLIO_MATCH(compound_dtor, _folio_dtor);
 FOLIO_MATCH(compound_order, _folio_order);
-FOLIO_MATCH(compound_mapcount, _total_mapcount);
+FOLIO_MATCH(compound_mapcount, _compound_mapcount);
+FOLIO_MATCH(subpages_mapcount, _subpages_mapcount);
 FOLIO_MATCH(compound_pincount, _pincount);
 #ifdef CONFIG_64BIT
 FOLIO_MATCH(compound_nr, _folio_nr_pages);
@@ -386,11 +390,22 @@ static inline atomic_t *folio_mapcount_ptr(struct folio *folio)
 	return &tail->compound_mapcount;
 }
 
+static inline atomic_t *folio_subpages_mapcount_ptr(struct folio *folio)
+{
+	struct page *tail = &folio->page + 1;
+	return &tail->subpages_mapcount;
+}
+
 static inline atomic_t *compound_mapcount_ptr(struct page *page)
 {
 	return &page[1].compound_mapcount;
 }
 
+static inline atomic_t *subpages_mapcount_ptr(struct page *page)
+{
+	return &page[1].subpages_mapcount;
+}
+
 static inline atomic_t *compound_pincount_ptr(struct page *page)
 {
 	return &page[1].compound_pincount;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0b0ae5084e60..e42c55a7e012 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -176,9 +176,6 @@ enum pageflags {
 	/* SLOB */
 	PG_slob_free = PG_private,
 
-	/* Compound pages. Stored in first tail page's flags */
-	PG_double_map = PG_workingset,
-
 #ifdef CONFIG_MEMORY_FAILURE
 	/*
 	 * Compound pages. Stored in first tail page's flags.
@@ -874,29 +871,11 @@ static inline int PageTransTail(struct page *page)
 {
 	return PageTail(page);
 }
-
-/*
- * PageDoubleMap indicates that the compound page is mapped with PTEs as well
- * as PMDs.
- *
- * This is required for optimization of rmap operations for THP: we can postpone
- * per small page mapcount accounting (and its overhead from atomic operations)
- * until the first PMD split.
- *
- * For the page PageDoubleMap means ->_mapcount in all sub-pages is offset up
- * by one. This reference will go away with last compound_mapcount.
- *
- * See also __split_huge_pmd_locked() and page_remove_anon_compound_rmap().
- */
-PAGEFLAG(DoubleMap, double_map, PF_SECOND)
-	TESTSCFLAG(DoubleMap, double_map, PF_SECOND)
 #else
 TESTPAGEFLAG_FALSE(TransHuge, transhuge)
 TESTPAGEFLAG_FALSE(TransCompound, transcompound)
 TESTPAGEFLAG_FALSE(TransCompoundMap, transcompoundmap)
 TESTPAGEFLAG_FALSE(TransTail, transtail)
-PAGEFLAG_FALSE(DoubleMap, double_map)
-	TESTSCFLAG_FALSE(DoubleMap, double_map)
 #endif
 
 #if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index bd3504d11b15..1973649e8f93 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -206,6 +206,8 @@ void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 
 static inline void __page_dup_rmap(struct page *page, bool compound)
 {
+	if (!compound && PageCompound(page))
+		atomic_inc(subpages_mapcount_ptr(compound_head(page)));
 	atomic_inc(compound ? compound_mapcount_ptr(page) : &page->_mapcount);
 }
 
diff --git a/mm/debug.c b/mm/debug.c
index 0fd15ba70d16..7f8e5f744e42 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -94,9 +94,10 @@ static void __dump_page(struct page *page)
 			page, page_ref_count(head), mapcount, mapping,
 			page_to_pgoff(page), page_to_pfn(page));
 	if (compound) {
-		pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
+		pr_warn("head:%p order:%u compound_mapcount:%d subpages_mapcount:%d compound_pincount:%d\n",
 				head, compound_order(head),
-				folio_entire_mapcount(folio),
+				head_compound_mapcount(head),
+				head_subpages_mapcount(head),
 				head_compound_pincount(head));
 	}
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index bac2a366aada..cbfe51091c39 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -39,12 +39,6 @@ void wait_for_stable_page(struct page *page)
 }
 EXPORT_SYMBOL_GPL(wait_for_stable_page);
 
-bool page_mapped(struct page *page)
-{
-	return folio_mapped(page_folio(page));
-}
-EXPORT_SYMBOL(page_mapped);
-
 void mark_page_accessed(struct page *page)
 {
 	folio_mark_accessed(page_folio(page));
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a524db74e9e6..23ff175768c3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2093,6 +2093,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
 		VM_BUG_ON_PAGE(!page_count(page), page);
 		page_ref_add(page, HPAGE_PMD_NR - 1);
+		atomic_add(HPAGE_PMD_NR, subpages_mapcount_ptr(page));
 
 		/*
 		 * Without "freeze", we'll simply split the PMD, propagating the
@@ -2173,33 +2174,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		pte_unmap(pte);
 	}
 
-	if (!pmd_migration) {
-		/*
-		 * Set PG_double_map before dropping compound_mapcount to avoid
-		 * false-negative page_mapped().
-		 */
-		if (compound_mapcount(page) > 1 &&
-		    !TestSetPageDoubleMap(page)) {
-			for (i = 0; i < HPAGE_PMD_NR; i++)
-				atomic_inc(&page[i]._mapcount);
-		}
-
-		lock_page_memcg(page);
-		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
-			/* Last compound_mapcount is gone. */
-			__mod_lruvec_page_state(page, NR_ANON_THPS,
-						-HPAGE_PMD_NR);
-			if (TestClearPageDoubleMap(page)) {
-				/* No need in mapcount reference anymore */
-				for (i = 0; i < HPAGE_PMD_NR; i++)
-					atomic_dec(&page[i]._mapcount);
-			}
-		}
-		unlock_page_memcg(page);
-
-		/* Above is effectively page_remove_rmap(page, vma, true) */
-		munlock_vma_page(page, vma, true);
-	}
+	if (!pmd_migration)
+		page_remove_rmap(page, vma, true);
 
 	smp_wmb(); /* make pte visible before pmd */
 	pmd_populate(mm, pmd, pgtable);
@@ -2401,7 +2377,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			 (1L << PG_dirty) |
 			 LRU_GEN_MASK | LRU_REFS_MASK));
 
-	/* ->mapping in first tail page is compound_mapcount */
+	/* ->mapping in first and second tail page is replaced by other uses */
 	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
 			page_tail);
 	page_tail->mapping = head->mapping;
@@ -2411,6 +2387,10 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	 * page->private should not be set in tail pages with the exception
 	 * of swap cache pages that store the swp_entry_t in tail pages.
 	 * Fix up and warn once if private is unexpectedly set.
+	 *
+	 * What of 32-bit systems, on which head[1].compound_pincount overlays
+	 * head[1].private?  No problem: THP_SWAP is not enabled on 32-bit, and
+	 * compound_pincount must be 0 for folio_ref_freeze() to have succeeded.
 	 */
 	if (!folio_test_swapcache(page_folio(head))) {
 		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, page_tail);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b27caef538f9..f8355360b3cd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1333,6 +1333,7 @@ static void __destroy_compound_gigantic_page(struct page *page,
 	struct page *p;
 
 	atomic_set(compound_mapcount_ptr(page), 0);
+	atomic_set(subpages_mapcount_ptr(page), 0);
 	atomic_set(compound_pincount_ptr(page), 0);
 
 	for (i = 1; i < nr_pages; i++) {
@@ -1850,6 +1851,7 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 			set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
+	atomic_set(subpages_mapcount_ptr(page), 0);
 	atomic_set(compound_pincount_ptr(page), 0);
 	return true;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ea0d186bc9d4..564f996c388d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1242,15 +1242,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		/*
 		 * Check if the page has any GUP (or other external) pins.
 		 *
-		 * Here the check is racy it may see total_mapcount > refcount
-		 * in some cases.
-		 * For example, one process with one forked child process.
-		 * The parent has the PMD split due to MADV_DONTNEED, then
-		 * the child is trying unmap the whole PMD, but khugepaged
-		 * may be scanning the parent between the child has
-		 * PageDoubleMap flag cleared and dec the mapcount.  So
-		 * khugepaged may see total_mapcount > refcount.
-		 *
+		 * Here the check may be racy:
+		 * it may see total_mapcount > refcount in some cases?
 		 * But such case is ephemeral we could always retry collapse
 		 * later.  However it may report false positive if the page
 		 * has excessive GUP pins (i.e. 512).  Anyway the same check
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7192ded44ad0..f7a63684e6c4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -798,6 +798,7 @@ static void prep_compound_head(struct page *page, unsigned int order)
 	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
 	set_compound_order(page, order);
 	atomic_set(compound_mapcount_ptr(page), -1);
+	atomic_set(subpages_mapcount_ptr(page), 0);
 	atomic_set(compound_pincount_ptr(page), 0);
 }
 
@@ -1324,11 +1325,19 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 	}
 	switch (page - head_page) {
 	case 1:
-		/* the first tail page: ->mapping may be compound_mapcount() */
-		if (unlikely(compound_mapcount(page))) {
+		/* the first tail page: these may be in place of ->mapping */
+		if (unlikely(head_compound_mapcount(head_page))) {
 			bad_page(page, "nonzero compound_mapcount");
 			goto out;
 		}
+		if (unlikely(head_subpages_mapcount(head_page))) {
+			bad_page(page, "nonzero subpages_mapcount");
+			goto out;
+		}
+		if (unlikely(head_compound_pincount(head_page))) {
+			bad_page(page, "nonzero compound_pincount");
+			goto out;
+		}
 		break;
 	case 2:
 		/*
@@ -1433,10 +1442,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 		VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
 
-		if (compound) {
-			ClearPageDoubleMap(page);
+		if (compound)
 			ClearPageHasHWPoisoned(page);
-		}
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
@@ -6871,13 +6878,11 @@ static void __ref memmap_init_compound(struct page *head,
 		set_page_count(page, 0);
 
 		/*
-		 * The first tail page stores compound_mapcount_ptr() and
-		 * compound_order() and the second tail page stores
-		 * compound_pincount_ptr(). Call prep_compound_head() after
-		 * the first and second tail pages have been initialized to
-		 * not have the data overwritten.
+		 * The first tail page stores important compound page info.
+		 * Call prep_compound_head() after the first tail page has
+		 * been initialized, to not have the data overwritten.
 		 */
-		if (pfn == head_pfn + 2)
+		if (pfn == head_pfn + 1)
 			prep_compound_head(head, order);
 	}
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 3b2d18bbdc44..f43339ea4970 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1085,6 +1085,24 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 	return page_vma_mkclean_one(&pvmw);
 }
 
+/*
+ * When mapping a THP's first pmd, or unmapping its last pmd, if that THP
+ * also has pte mappings, then those must be discounted: in order to maintain
+ * NR_ANON_MAPPED and NR_FILE_MAPPED statistics exactly, without any drift,
+ * and to decide when an anon THP should be put on the deferred split queue.
+ */
+static int nr_subpages_unmapped(struct page *head, int nr_subpages)
+{
+	int nr = nr_subpages;
+	int i;
+
+	/* Discount those subpages mapped by pte */
+	for (i = 0; i < nr_subpages; i++)
+		if (atomic_read(&head[i]._mapcount) >= 0)
+			nr--;
+	return nr;
+}
+
 /**
  * page_move_anon_rmap - move a page to our anon_vma
  * @page:	the page to move to our anon_vma
@@ -1194,6 +1212,7 @@ static void __page_check_anon_rmap(struct page *page,
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address, rmap_t flags)
 {
+	int nr, nr_pages;
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
 
@@ -1202,28 +1221,32 @@ void page_add_anon_rmap(struct page *page,
 	else
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 
-	if (compound) {
+	if (compound && PageTransHuge(page)) {
 		atomic_t *mapcount;
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		mapcount = compound_mapcount_ptr(page);
 		first = atomic_inc_and_test(mapcount);
+
+		nr = nr_pages = thp_nr_pages(page);
+		if (first && head_subpages_mapcount(page))
+			nr = nr_subpages_unmapped(page, nr_pages);
 	} else {
+		nr = 1;
+		if (PageTransCompound(page)) {
+			struct page *head = compound_head(page);
+
+			atomic_inc(subpages_mapcount_ptr(head));
+			nr = !head_compound_mapcount(head);
+		}
 		first = atomic_inc_and_test(&page->_mapcount);
 	}
+
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
 
 	if (first) {
-		int nr = compound ? thp_nr_pages(page) : 1;
-		/*
-		 * We use the irq-unsafe __{inc|mod}_zone_page_stat because
-		 * these counters are not modified in interrupt context, and
-		 * pte lock(a spinlock) is held, which implies preemption
-		 * disabled.
-		 */
 		if (compound)
-			__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
+			__mod_lruvec_page_state(page, NR_ANON_THPS, nr_pages);
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	}
 
@@ -1265,8 +1288,6 @@ void page_add_new_anon_rmap(struct page *page,
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		/* increment count (starts at -1) */
 		atomic_set(compound_mapcount_ptr(page), 0);
-		atomic_set(compound_pincount_ptr(page), 0);
-
 		__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
 	} else {
 		/* increment count (starts at -1) */
@@ -1287,29 +1308,19 @@ void page_add_new_anon_rmap(struct page *page,
 void page_add_file_rmap(struct page *page,
 	struct vm_area_struct *vma, bool compound)
 {
-	int i, nr = 0;
+	int nr = 0;
 
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
 	lock_page_memcg(page);
 	if (compound && PageTransHuge(page)) {
-		int nr_pages = thp_nr_pages(page);
+		int nr_pages;
 
-		for (i = 0; i < nr_pages; i++) {
-			if (atomic_inc_and_test(&page[i]._mapcount))
-				nr++;
-		}
 		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
 			goto out;
 
-		/*
-		 * It is racy to ClearPageDoubleMap in page_remove_file_rmap();
-		 * but page lock is held by all page_add_file_rmap() compound
-		 * callers, and SetPageDoubleMap below warns if !PageLocked:
-		 * so here is a place that DoubleMap can be safely cleared.
-		 */
-		VM_WARN_ON_ONCE(!PageLocked(page));
-		if (nr == nr_pages && PageDoubleMap(page))
-			ClearPageDoubleMap(page);
+		nr = nr_pages = thp_nr_pages(page);
+		if (head_subpages_mapcount(page))
+			nr = nr_subpages_unmapped(page, nr_pages);
 
 		if (PageSwapBacked(page))
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
@@ -1318,11 +1329,15 @@ void page_add_file_rmap(struct page *page,
 			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
 						nr_pages);
 	} else {
-		if (PageTransCompound(page) && page_mapping(page)) {
-			VM_WARN_ON_ONCE(!PageLocked(page));
-			SetPageDoubleMap(compound_head(page));
+		bool pmd_mapped = false;
+
+		if (PageTransCompound(page)) {
+			struct page *head = compound_head(page);
+
+			atomic_inc(subpages_mapcount_ptr(head));
+			pmd_mapped = head_compound_mapcount(head);
 		}
-		if (atomic_inc_and_test(&page->_mapcount))
+		if (atomic_inc_and_test(&page->_mapcount) && !pmd_mapped)
 			nr++;
 	}
 out:
@@ -1335,7 +1350,7 @@ void page_add_file_rmap(struct page *page,
 
 static void page_remove_file_rmap(struct page *page, bool compound)
 {
-	int i, nr = 0;
+	int nr = 0;
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
@@ -1348,14 +1363,15 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 
 	/* page still mapped by someone else? */
 	if (compound && PageTransHuge(page)) {
-		int nr_pages = thp_nr_pages(page);
+		int nr_pages;
 
-		for (i = 0; i < nr_pages; i++) {
-			if (atomic_add_negative(-1, &page[i]._mapcount))
-				nr++;
-		}
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
-			goto out;
+			return;
+
+		nr = nr_pages = thp_nr_pages(page);
+		if (head_subpages_mapcount(page))
+			nr = nr_subpages_unmapped(page, nr_pages);
+
 		if (PageSwapBacked(page))
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						-nr_pages);
@@ -1363,17 +1379,25 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
 						-nr_pages);
 	} else {
-		if (atomic_add_negative(-1, &page->_mapcount))
+		bool pmd_mapped = false;
+
+		if (PageTransCompound(page)) {
+			struct page *head = compound_head(page);
+
+			atomic_dec(subpages_mapcount_ptr(head));
+			pmd_mapped = head_compound_mapcount(head);
+		}
+		if (atomic_add_negative(-1, &page->_mapcount) && !pmd_mapped)
 			nr++;
 	}
-out:
+
 	if (nr)
 		__mod_lruvec_page_state(page, NR_FILE_MAPPED, -nr);
 }
 
 static void page_remove_anon_compound_rmap(struct page *page)
 {
-	int i, nr;
+	int nr, nr_pages;
 
 	if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
 		return;
@@ -1385,27 +1409,19 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return;
 
-	__mod_lruvec_page_state(page, NR_ANON_THPS, -thp_nr_pages(page));
+	nr = nr_pages = thp_nr_pages(page);
+	__mod_lruvec_page_state(page, NR_ANON_THPS, -nr);
 
-	if (TestClearPageDoubleMap(page)) {
-		/*
-		 * Subpages can be mapped with PTEs too. Check how many of
-		 * them are still mapped.
-		 */
-		for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
-			if (atomic_add_negative(-1, &page[i]._mapcount))
-				nr++;
-		}
+	if (head_subpages_mapcount(page)) {
+		nr = nr_subpages_unmapped(page, nr_pages);
 
 		/*
 		 * Queue the page for deferred split if at least one small
 		 * page of the compound page is unmapped, but at least one
 		 * small page is still mapped.
 		 */
-		if (nr && nr < thp_nr_pages(page))
+		if (nr && nr < nr_pages)
 			deferred_split_huge_page(page);
-	} else {
-		nr = thp_nr_pages(page);
 	}
 
 	if (nr)
@@ -1423,6 +1439,8 @@ static void page_remove_anon_compound_rmap(struct page *page)
 void page_remove_rmap(struct page *page,
 	struct vm_area_struct *vma, bool compound)
 {
+	bool pmd_mapped = false;
+
 	lock_page_memcg(page);
 
 	if (!PageAnon(page)) {
@@ -1435,15 +1453,17 @@ void page_remove_rmap(struct page *page,
 		goto out;
 	}
 
+	if (PageTransCompound(page)) {
+		struct page *head = compound_head(page);
+
+		atomic_dec(subpages_mapcount_ptr(head));
+		pmd_mapped = head_compound_mapcount(head);
+	}
+
 	/* page still mapped by someone else? */
-	if (!atomic_add_negative(-1, &page->_mapcount))
+	if (!atomic_add_negative(-1, &page->_mapcount) || pmd_mapped)
 		goto out;
 
-	/*
-	 * We use the irq-unsafe __{inc|mod}_zone_page_stat because
-	 * these counters are not modified in interrupt context, and
-	 * pte lock(a spinlock) is held, which implies preemption disabled.
-	 */
 	__dec_lruvec_page_state(page, NR_ANON_MAPPED);
 
 	if (PageTransCompound(page))
@@ -2569,8 +2589,8 @@ void hugepage_add_new_anon_rmap(struct page *page,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
+	/* increment count (starts at -1) */
 	atomic_set(compound_mapcount_ptr(page), 0);
-	atomic_set(compound_pincount_ptr(page), 0);
 	ClearHPageRestoreReserve(page);
 	__page_set_anon_rmap(page, vma, address, 1);
 }
diff --git a/mm/util.c b/mm/util.c
index 12984e76767e..b56c92fb910f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -717,32 +717,6 @@ void *page_rmapping(struct page *page)
 	return folio_raw_mapping(page_folio(page));
 }
 
-/**
- * folio_mapped - Is this folio mapped into userspace?
- * @folio: The folio.
- *
- * Return: True if any page in this folio is referenced by user page tables.
- */
-bool folio_mapped(struct folio *folio)
-{
-	long i, nr;
-
-	if (!folio_test_large(folio))
-		return atomic_read(&folio->_mapcount) >= 0;
-	if (atomic_read(folio_mapcount_ptr(folio)) >= 0)
-		return true;
-	if (folio_test_hugetlb(folio))
-		return false;
-
-	nr = folio_nr_pages(folio);
-	for (i = 0; i < nr; i++) {
-		if (atomic_read(&folio_page(folio, i)->_mapcount) >= 0)
-			return true;
-	}
-	return false;
-}
-EXPORT_SYMBOL(folio_mapped);
-
 struct anon_vma *folio_anon_vma(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
@@ -783,59 +757,6 @@ struct address_space *folio_mapping(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_mapping);
 
-/* Slow path of page_mapcount() for compound pages */
-int __page_mapcount(struct page *page)
-{
-	int ret;
-
-	ret = atomic_read(&page->_mapcount) + 1;
-	/*
-	 * For file THP page->_mapcount contains total number of mapping
-	 * of the page: no need to look into compound_mapcount.
-	 */
-	if (!PageAnon(page) && !PageHuge(page))
-		return ret;
-	page = compound_head(page);
-	ret += atomic_read(compound_mapcount_ptr(page)) + 1;
-	if (PageDoubleMap(page))
-		ret--;
-	return ret;
-}
-EXPORT_SYMBOL_GPL(__page_mapcount);
-
-/**
- * folio_mapcount() - Calculate the number of mappings of this folio.
- * @folio: The folio.
- *
- * A large folio tracks both how many times the entire folio is mapped,
- * and how many times each individual page in the folio is mapped.
- * This function calculates the total number of times the folio is
- * mapped.
- *
- * Return: The number of times this folio is mapped.
- */
-int folio_mapcount(struct folio *folio)
-{
-	int i, compound, nr, ret;
-
-	if (likely(!folio_test_large(folio)))
-		return atomic_read(&folio->_mapcount) + 1;
-
-	compound = folio_entire_mapcount(folio);
-	if (folio_test_hugetlb(folio))
-		return compound;
-	ret = compound;
-	nr = folio_nr_pages(folio);
-	for (i = 0; i < nr; i++)
-		ret += atomic_read(&folio_page(folio, i)->_mapcount) + 1;
-	/* File pages has compound_mapcount included in _mapcount */
-	if (!folio_test_anon(folio))
-		return ret - compound * nr;
-	if (folio_test_double_map(folio))
-		ret -= nr;
-	return ret;
-}
-
 /**
  * folio_copy - Copy the contents of one folio to another.
  * @dst: Folio to copy to.
-- 
2.35.3

