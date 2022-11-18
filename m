Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE562F0C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbiKRJOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241831AbiKRJOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:14:31 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FFB7FC32
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:14:21 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w9so2727997qtv.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+R4+JsMdAsj8lhbAosLbJ972kPmHJQgJWoN2i2aS51c=;
        b=YOyiEySv8T3J5rwa4G6sIiW4rOJU1VBsv/769AIHVUdyr6xNYE3C3A73DU7k3fZeTo
         sHt5bR2J76LMyfIR9UNDS6hhwavzQRAxJgKsoFog4Nj9rwjFBVGBMYk58PRggAHRBXtt
         If5dDsarj6ZEtueURmJmmzS4K/7wit4Z0I0qWyQXpxH79Cx9haY1nS/rYYGlTnuVSqOb
         37n5HrF9L1OE+EyACsDrAtoN8vj9TzC21rG8lYzJGsuXhZlGHPxZGEE7lU5VKEP/lCPo
         EVJ8MtpppWJ9d/wnm+J/aWOjOYtqVW+hcu76/quOn1Tbz1z7iaq8NSfpYiREKa4pAyUJ
         3STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+R4+JsMdAsj8lhbAosLbJ972kPmHJQgJWoN2i2aS51c=;
        b=ajE6QkUFhBFTfi9dQ+H5hFJFzMZLPDYmZTJFB/NQ8cKg09UMuCK+DEkShYWRaiEr/p
         wJccNp5whtYDFi0IaoBI5KoxbDR3Cr68pv5+MgSYER3l2CtmmjkUT7K107V1B11iMeMQ
         B+VmNwAa1kPHNmt2SKc6uRnRyQssEMfsV1brCWhgs9ZpRMmtv4qWfTcKJUedAiwUQgDU
         YUBtcLbZvmdUyW2udyMZCn/fsZqkfNqF/XWEQGcKHm9WJb7jjm6cXIyr2a90kDFz0bjh
         Rjlyim6C7ggE8ZXpTZXPE6J85cwkNUETGJT3EGQVKCxXFTFLfNtOOUIvG1LFPb5D8W8A
         prAg==
X-Gm-Message-State: ANoB5pkyqw56FpR5txOMUhoMN9zB26EQTy41peLBJNKNeUch54r6nTob
        rVnHUThjltQUvElh9C083Q6yjw==
X-Google-Smtp-Source: AA0mqf5ku6dpsngK00LG30OiC3zS8GsQdrRwC77k7gRH0jS8VUnX94NqVgHhlX/Q6rUe3F8sgeJj0g==
X-Received: by 2002:a05:622a:1144:b0:3a5:2307:9f23 with SMTP id f4-20020a05622a114400b003a523079f23mr5552851qty.514.1668762860368;
        Fri, 18 Nov 2022 01:14:20 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id fp19-20020a05622a509300b00359961365f1sm1720785qtb.68.2022.11.18.01.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:14:20 -0800 (PST)
Date:   Fri, 18 Nov 2022 01:14:17 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Subject: [PATCH 2/3] mm,thp,rmap: subpages_mapcount COMPOUND_MAPPED if
 PMD-mapped
In-Reply-To: <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
Message-ID: <25a09a7a-81a9-e9c2-7567-c94ce18ac2@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
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

Can the lock_compound_mapcount() bit_spin_lock apparatus be removed now?
Yes.  Not by atomic64_t or cmpxchg games, those get difficult on 32-bit;
but if we slightly abuse subpages_mapcount by additionally demanding that
one bit be set there when the compound page is PMD-mapped, then a cascade
of two atomic ops is able to maintain the stats without bit_spin_lock.

This is harder to reason about than when bit_spin_locked, but I believe
safe; and no drift in stats detected when testing.  When there are racing
removes and adds, of course the sequence of operations is less well-
defined; but each operation on subpages_mapcount is atomically good.
What might be disastrous, is if subpages_mapcount could ever fleetingly
appear negative: but the pte lock (or pmd lock) these rmap functions are
called under, ensures that a last remove cannot race ahead of a first add.

Continue to make an exception for hugetlb (PageHuge) pages, though that
exception can be easily removed by a further commit if necessary: leave
subpages_mapcount 0, don't bother with COMPOUND_MAPPED in its case, just
carry on checking compound_mapcount too in folio_mapped(), page_mapped().

Evidence is that this way goes slightly faster than the previous
implementation in all cases (pmds after ptes now taking around 103ms);
and relieves us of worrying about contention on the bit_spin_lock.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 Documentation/mm/transhuge.rst |   7 +-
 include/linux/mm.h             |  19 ++++-
 include/linux/rmap.h           |  12 ++--
 mm/debug.c                     |   2 +-
 mm/rmap.c                      | 124 +++++++--------------------------
 5 files changed, 52 insertions(+), 112 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index af4c9d70321d..ec3dc5b04226 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -118,15 +118,14 @@ pages:
     succeeds on tail pages.
 
   - map/unmap of PMD entry for the whole compound page increment/decrement
-    ->compound_mapcount, stored in the first tail page of the compound page.
+    ->compound_mapcount, stored in the first tail page of the compound page;
+    and also increment/decrement ->subpages_mapcount (also in the first tail)
+    by COMPOUND_MAPPED when compound_mapcount goes from -1 to 0 or 0 to -1.
 
   - map/unmap of sub-pages with PTE entry increment/decrement ->_mapcount
     on relevant sub-page of the compound page, and also increment/decrement
     ->subpages_mapcount, stored in first tail page of the compound page, when
     _mapcount goes from -1 to 0 or 0 to -1: counting sub-pages mapped by PTE.
-    In order to have race-free accounting of sub-pages mapped, changes to
-    sub-page ->_mapcount, ->subpages_mapcount and ->compound_mapcount are
-    are all locked by bit_spin_lock of PG_locked in the first tail ->flags.
 
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9e46d4d46f2..a2bfb5e4be62 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -828,7 +828,16 @@ static inline int head_compound_mapcount(struct page *head)
 }
 
 /*
- * Number of sub-pages mapped by PTE, does not include compound mapcount.
+ * If a 16GB hugetlb page were mapped by PTEs of all of its 4kB sub-pages,
+ * its subpages_mapcount would be 0x400000: choose the COMPOUND_MAPPED bit
+ * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE).  Hugetlb currently
+ * leaves subpages_mapcount at 0, but avoid surprise if it participates later.
+ */
+#define COMPOUND_MAPPED	0x800000
+#define SUBPAGES_MAPPED	(COMPOUND_MAPPED - 1)
+
+/*
+ * Number of sub-pages mapped by PTE, plus COMPOUND_MAPPED if compound mapped.
  * Must be called only on head of compound page.
  */
 static inline int head_subpages_mapcount(struct page *head)
@@ -893,8 +902,12 @@ static inline int total_mapcount(struct page *page)
 
 static inline bool folio_large_is_mapped(struct folio *folio)
 {
-	return atomic_read(folio_mapcount_ptr(folio)) +
-		atomic_read(folio_subpages_mapcount_ptr(folio)) >= 0;
+	/*
+	 * Reading folio_mapcount_ptr() below could be omitted if hugetlb
+	 * participated in incrementing subpages_mapcount when compound mapped.
+	 */
+	return atomic_read(folio_mapcount_ptr(folio)) >= 0 ||
+		atomic_read(folio_subpages_mapcount_ptr(folio)) > 0;
 }
 
 /**
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 860f558126ac..bd3504d11b15 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -204,14 +204,14 @@ void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address);
 
-void page_dup_compound_rmap(struct page *page);
+static inline void __page_dup_rmap(struct page *page, bool compound)
+{
+	atomic_inc(compound ? compound_mapcount_ptr(page) : &page->_mapcount);
+}
 
 static inline void page_dup_file_rmap(struct page *page, bool compound)
 {
-	if (likely(!compound /* page is mapped by PTE */))
-		atomic_inc(&page->_mapcount);
-	else
-		page_dup_compound_rmap(page);
+	__page_dup_rmap(page, compound);
 }
 
 /**
@@ -260,7 +260,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
 	 * the page R/O into both processes.
 	 */
 dup:
-	page_dup_file_rmap(page, compound);
+	__page_dup_rmap(page, compound);
 	return 0;
 }
 
diff --git a/mm/debug.c b/mm/debug.c
index 7f8e5f744e42..1ef2ff6a05cb 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -97,7 +97,7 @@ static void __dump_page(struct page *page)
 		pr_warn("head:%p order:%u compound_mapcount:%d subpages_mapcount:%d compound_pincount:%d\n",
 				head, compound_order(head),
 				head_compound_mapcount(head),
-				head_subpages_mapcount(head),
+				head_subpages_mapcount(head) & SUBPAGES_MAPPED,
 				head_compound_pincount(head));
 	}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 66be8cae640f..5e4ce0a6d6f1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1085,38 +1085,6 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 	return page_vma_mkclean_one(&pvmw);
 }
 
-struct compound_mapcounts {
-	unsigned int compound_mapcount;
-	unsigned int subpages_mapcount;
-};
-
-/*
- * lock_compound_mapcounts() first locks, then copies subpages_mapcount and
- * compound_mapcount from head[1].compound_mapcount and subpages_mapcount,
- * converting from struct page's internal representation to logical count
- * (that is, adding 1 to compound_mapcount to hide its offset by -1).
- */
-static void lock_compound_mapcounts(struct page *head,
-		struct compound_mapcounts *local)
-{
-	bit_spin_lock(PG_locked, &head[1].flags);
-	local->compound_mapcount = atomic_read(compound_mapcount_ptr(head)) + 1;
-	local->subpages_mapcount = atomic_read(subpages_mapcount_ptr(head));
-}
-
-/*
- * After caller has updated subpage._mapcount, local subpages_mapcount and
- * local compound_mapcount, as necessary, unlock_compound_mapcounts() converts
- * and copies them back to the compound head[1] fields, and then unlocks.
- */
-static void unlock_compound_mapcounts(struct page *head,
-		struct compound_mapcounts *local)
-{
-	atomic_set(compound_mapcount_ptr(head), local->compound_mapcount - 1);
-	atomic_set(subpages_mapcount_ptr(head), local->subpages_mapcount);
-	bit_spin_unlock(PG_locked, &head[1].flags);
-}
-
 int total_compound_mapcount(struct page *head)
 {
 	int mapcount = head_compound_mapcount(head);
@@ -1124,7 +1092,7 @@ int total_compound_mapcount(struct page *head)
 	int i;
 
 	/* In the common case, avoid the loop when no subpages mapped by PTE */
-	if (head_subpages_mapcount(head) == 0)
+	if ((head_subpages_mapcount(head) & SUBPAGES_MAPPED) == 0)
 		return mapcount;
 	/*
 	 * Add all the PTE mappings of those subpages mapped by PTE.
@@ -1140,35 +1108,6 @@ int total_compound_mapcount(struct page *head)
 	return mapcount;
 }
 
-/*
- * page_dup_compound_rmap(), used when copying mm,
- * provides a simple example of using lock_ and unlock_compound_mapcounts().
- */
-void page_dup_compound_rmap(struct page *head)
-{
-	struct compound_mapcounts mapcounts;
-
-	/*
-	 * Hugetlb pages could use lock_compound_mapcounts(), like THPs do;
-	 * but at present they are still being managed by atomic operations:
-	 * which are likely to be somewhat faster, so don't rush to convert
-	 * them over without evaluating the effect.
-	 *
-	 * Note that hugetlb does not call page_add_file_rmap():
-	 * here is where hugetlb shared page mapcount is raised.
-	 */
-	if (PageHuge(head)) {
-		atomic_inc(compound_mapcount_ptr(head));
-
-	} else if (PageTransHuge(head)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
-		lock_compound_mapcounts(head, &mapcounts);
-		mapcounts.compound_mapcount++;
-		unlock_compound_mapcounts(head, &mapcounts);
-	}
-}
-
 /**
  * page_move_anon_rmap - move a page to our anon_vma
  * @page:	the page to move to our anon_vma
@@ -1278,7 +1217,7 @@ static void __page_check_anon_rmap(struct page *page,
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address, rmap_t flags)
 {
-	struct compound_mapcounts mapcounts;
+	atomic_t *mapped;
 	int nr = 0, nr_pmdmapped = 0;
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
@@ -1290,24 +1229,20 @@ void page_add_anon_rmap(struct page *page,
 		first = atomic_inc_and_test(&page->_mapcount);
 		nr = first;
 		if (first && PageCompound(page)) {
-			struct page *head = compound_head(page);
-
-			lock_compound_mapcounts(head, &mapcounts);
-			mapcounts.subpages_mapcount++;
-			nr = !mapcounts.compound_mapcount;
-			unlock_compound_mapcounts(head, &mapcounts);
+			mapped = subpages_mapcount_ptr(compound_head(page));
+			nr = atomic_inc_return_relaxed(mapped);
+			nr = !(nr & COMPOUND_MAPPED);
 		}
 	} else if (PageTransHuge(page)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
-		lock_compound_mapcounts(page, &mapcounts);
-		first = !mapcounts.compound_mapcount;
-		mapcounts.compound_mapcount++;
+		first = atomic_inc_and_test(compound_mapcount_ptr(page));
 		if (first) {
+			mapped = subpages_mapcount_ptr(page);
+			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
 			nr_pmdmapped = thp_nr_pages(page);
-			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
+			nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
 		}
-		unlock_compound_mapcounts(page, &mapcounts);
 	}
 
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
@@ -1360,6 +1295,7 @@ void page_add_new_anon_rmap(struct page *page,
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		/* increment count (starts at -1) */
 		atomic_set(compound_mapcount_ptr(page), 0);
+		atomic_set(subpages_mapcount_ptr(page), COMPOUND_MAPPED);
 		nr = thp_nr_pages(page);
 		__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
 	}
@@ -1379,7 +1315,7 @@ void page_add_new_anon_rmap(struct page *page,
 void page_add_file_rmap(struct page *page,
 	struct vm_area_struct *vma, bool compound)
 {
-	struct compound_mapcounts mapcounts;
+	atomic_t *mapped;
 	int nr = 0, nr_pmdmapped = 0;
 	bool first;
 
@@ -1390,24 +1326,20 @@ void page_add_file_rmap(struct page *page,
 		first = atomic_inc_and_test(&page->_mapcount);
 		nr = first;
 		if (first && PageCompound(page)) {
-			struct page *head = compound_head(page);
-
-			lock_compound_mapcounts(head, &mapcounts);
-			mapcounts.subpages_mapcount++;
-			nr = !mapcounts.compound_mapcount;
-			unlock_compound_mapcounts(head, &mapcounts);
+			mapped = subpages_mapcount_ptr(compound_head(page));
+			nr = atomic_inc_return_relaxed(mapped);
+			nr = !(nr & COMPOUND_MAPPED);
 		}
 	} else if (PageTransHuge(page)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
-		lock_compound_mapcounts(page, &mapcounts);
-		first = !mapcounts.compound_mapcount;
-		mapcounts.compound_mapcount++;
+		first = atomic_inc_and_test(compound_mapcount_ptr(page));
 		if (first) {
+			mapped = subpages_mapcount_ptr(page);
+			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
 			nr_pmdmapped = thp_nr_pages(page);
-			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
+			nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
 		}
-		unlock_compound_mapcounts(page, &mapcounts);
 	}
 
 	if (nr_pmdmapped)
@@ -1431,7 +1363,7 @@ void page_add_file_rmap(struct page *page,
 void page_remove_rmap(struct page *page,
 	struct vm_area_struct *vma, bool compound)
 {
-	struct compound_mapcounts mapcounts;
+	atomic_t *mapped;
 	int nr = 0, nr_pmdmapped = 0;
 	bool last;
 
@@ -1451,24 +1383,20 @@ void page_remove_rmap(struct page *page,
 		last = atomic_add_negative(-1, &page->_mapcount);
 		nr = last;
 		if (last && PageCompound(page)) {
-			struct page *head = compound_head(page);
-
-			lock_compound_mapcounts(head, &mapcounts);
-			mapcounts.subpages_mapcount--;
-			nr = !mapcounts.compound_mapcount;
-			unlock_compound_mapcounts(head, &mapcounts);
+			mapped = subpages_mapcount_ptr(compound_head(page));
+			nr = atomic_dec_return_relaxed(mapped);
+			nr = !(nr & COMPOUND_MAPPED);
 		}
 	} else if (PageTransHuge(page)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
-		lock_compound_mapcounts(page, &mapcounts);
-		mapcounts.compound_mapcount--;
-		last = !mapcounts.compound_mapcount;
+		last = atomic_add_negative(-1, compound_mapcount_ptr(page));
 		if (last) {
+			mapped = subpages_mapcount_ptr(page);
+			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
 			nr_pmdmapped = thp_nr_pages(page);
-			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
+			nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
 		}
-		unlock_compound_mapcounts(page, &mapcounts);
 	}
 
 	if (nr_pmdmapped) {
-- 
2.35.3

