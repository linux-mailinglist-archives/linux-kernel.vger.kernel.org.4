Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583716338DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiKVJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiKVJmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:42:11 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D8E4FFA7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:42:10 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z6so8908006qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtRRKej5/9yOCimTMhlLaKPup3+BU7GKT4Qoy8ygbuM=;
        b=IxWfCfWX5pFR+HboAXEJRyomLXkrfim1eewbFErf5shbc3RbgMKZ9e2pdS56GDfZvi
         /jNXDOJGkbp7PojNVFZ0hTyNbQyqEv8MrkqYNAtYVXUZUecdtSTwQXdFmi0TRsy7aXVC
         6s8QP7y+F+yUMQaxK5Dl5iCbK0l/7trqng5mO4U8nmYlfevBeUT75ZnN2z4ygq8KdIDk
         KUoEoUvJUbWKImIt6bxqO/vfHj8G08p3I+yOVM5BBfwmm+NnRwg2jocctN4RihZT3wY6
         DdnfARzBKA6cWWrMRQYg3/jTE65//uOagmLhRIJNYRxCgdrvjjhJqs9kE77Km8vLN+2u
         6/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtRRKej5/9yOCimTMhlLaKPup3+BU7GKT4Qoy8ygbuM=;
        b=H2nWxzSnHzo7VcMaifiT3lP1FxnVKEb4JP/UYFv7UBSEOx6YdID7Mvb2JlJpkcXbha
         HwDQtwOyzUJLFHpPZoieC8IXY9sYjwypv2xtgJKBHfYci6Jt7ErZEgrhmvFosN+4kD1s
         dnODSLqD5ZkkvKL3RZ7sXztQW+6MbUcoly+Hup+otK6zKpOtakevQPKfmFpOqpMi6Zdi
         Hw5qAIZy9z+Qh0EGEl2Q7BT4UiOXfkUYZmxXgP7HTQFRzzCGOcYN+OVUSP35MOTSRrMc
         TwBCSEHUhMUDTiOHpY6zOJkmY4u9YpuUKYyeuRefo5Sg9igxss77XmPlBsR3lk2s5TC+
         5fdw==
X-Gm-Message-State: ANoB5plvUXX98UIyMLjRom0U4fa2rBD4CUO21THlTCaF7LLiL1ohXRZ9
        AhcOlloUzBJUMlzoTwMHPRlZrQ==
X-Google-Smtp-Source: AA0mqf4dcRJnLHIxNKUIi1sLgVrJ6nhH7YyI5kDqocGQMo/fw/eoYPkITzeXm36BbTbALbddKnNhjA==
X-Received: by 2002:ac8:7595:0:b0:3a5:226e:2677 with SMTP id s21-20020ac87595000000b003a5226e2677mr21290782qtq.141.1669110128172;
        Tue, 22 Nov 2022 01:42:08 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006b9c9b7db8bsm9816817qkj.82.2022.11.22.01.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:42:07 -0800 (PST)
Date:   Tue, 22 Nov 2022 01:42:04 -0800 (PST)
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
        Zach O'Keefe <zokeefe@google.com>, Yu Zhao <yuzhao@google.com>,
        Dan Carpenter <error27@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 1/3] mm,thp,rmap: subpages_mapcount of PTE-mapped
 subpages
In-Reply-To: <a5849eca-22f1-3517-bf29-95d982242742@google.com>
Message-ID: <eec17e16-4e1-7c59-f1bc-5bca90dac919@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <a5849eca-22f1-3517-bf29-95d982242742@google.com>
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

Following suggestion from Linus, instead of counting every PTE map of a
compound page in subpages_mapcount, just count how many of its subpages
are PTE-mapped: this yields the exact number needed for NR_ANON_MAPPED
and NR_FILE_MAPPED stats, without any need for a locked scan of subpages;
and requires updating the count less often.

This does then revert total_mapcount() and folio_mapcount() to needing a
scan of subpages; but they are inherently racy, and need no locking, so
Linus is right that the scans are much better done there.  Plus (unlike
in 6.1 and previous) subpages_mapcount lets us avoid the scan in the
common case of no PTE maps.  And page_mapped() and folio_mapped() remain
scanless and just as efficient with the new meaning of subpages_mapcount:
those are the functions which I most wanted to remove the scan from.

The updated page_dup_compound_rmap() is no longer suitable for use by
anon THP's __split_huge_pmd_locked(); but page_add_anon_rmap() can be
used for that, so long as its VM_BUG_ON_PAGE(!PageLocked) is deleted.

Evidence is that this way goes slightly faster than the previous
implementation for most cases; but significantly faster in the (now
scanless) pmds after ptes case, which started out at 870ms and was
brought down to 495ms by the previous series, now takes around 105ms.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v2: fix uninitialized 'first', reported by Yu Zhao and Dan Carpenter
    moved "mapped by PTE" comments above the !compound tests, per Kirill
    removed a newline (which goes away in the next patch), per Kirill

 Documentation/mm/transhuge.rst |   3 +-
 include/linux/mm.h             |  52 ++++++-----
 include/linux/rmap.h           |   9 +-
 mm/huge_memory.c               |   2 +-
 mm/rmap.c                      | 160 ++++++++++++++-------------------
 5 files changed, 107 insertions(+), 119 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index 1e2a637cc607..af4c9d70321d 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -122,7 +122,8 @@ pages:
 
   - map/unmap of sub-pages with PTE entry increment/decrement ->_mapcount
     on relevant sub-page of the compound page, and also increment/decrement
-    ->subpages_mapcount, stored in first tail page of the compound page.
+    ->subpages_mapcount, stored in first tail page of the compound page, when
+    _mapcount goes from -1 to 0 or 0 to -1: counting sub-pages mapped by PTE.
     In order to have race-free accounting of sub-pages mapped, changes to
     sub-page ->_mapcount, ->subpages_mapcount and ->compound_mapcount are
     are all locked by bit_spin_lock of PG_locked in the first tail ->flags.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8fe6276d8cc2..c9e46d4d46f2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -828,7 +828,7 @@ static inline int head_compound_mapcount(struct page *head)
 }
 
 /*
- * Sum of mapcounts of sub-pages, does not include compound mapcount.
+ * Number of sub-pages mapped by PTE, does not include compound mapcount.
  * Must be called only on head of compound page.
  */
 static inline int head_subpages_mapcount(struct page *head)
@@ -864,23 +864,7 @@ static inline int page_mapcount(struct page *page)
 	return head_compound_mapcount(page) + mapcount;
 }
 
-static inline int total_mapcount(struct page *page)
-{
-	if (likely(!PageCompound(page)))
-		return atomic_read(&page->_mapcount) + 1;
-	page = compound_head(page);
-	return head_compound_mapcount(page) + head_subpages_mapcount(page);
-}
-
-/*
- * Return true if this page is mapped into pagetables.
- * For compound page it returns true if any subpage of compound page is mapped,
- * even if this particular subpage is not itself mapped by any PTE or PMD.
- */
-static inline bool page_mapped(struct page *page)
-{
-	return total_mapcount(page) > 0;
-}
+int total_compound_mapcount(struct page *head);
 
 /**
  * folio_mapcount() - Calculate the number of mappings of this folio.
@@ -897,8 +881,20 @@ static inline int folio_mapcount(struct folio *folio)
 {
 	if (likely(!folio_test_large(folio)))
 		return atomic_read(&folio->_mapcount) + 1;
-	return atomic_read(folio_mapcount_ptr(folio)) + 1 +
-		atomic_read(folio_subpages_mapcount_ptr(folio));
+	return total_compound_mapcount(&folio->page);
+}
+
+static inline int total_mapcount(struct page *page)
+{
+	if (likely(!PageCompound(page)))
+		return atomic_read(&page->_mapcount) + 1;
+	return total_compound_mapcount(compound_head(page));
+}
+
+static inline bool folio_large_is_mapped(struct folio *folio)
+{
+	return atomic_read(folio_mapcount_ptr(folio)) +
+		atomic_read(folio_subpages_mapcount_ptr(folio)) >= 0;
 }
 
 /**
@@ -909,7 +905,21 @@ static inline int folio_mapcount(struct folio *folio)
  */
 static inline bool folio_mapped(struct folio *folio)
 {
-	return folio_mapcount(folio) > 0;
+	if (likely(!folio_test_large(folio)))
+		return atomic_read(&folio->_mapcount) >= 0;
+	return folio_large_is_mapped(folio);
+}
+
+/*
+ * Return true if this page is mapped into pagetables.
+ * For compound page it returns true if any sub-page of compound page is mapped,
+ * even if this particular sub-page is not itself mapped by any PTE or PMD.
+ */
+static inline bool page_mapped(struct page *page)
+{
+	if (likely(!PageCompound(page)))
+		return atomic_read(&page->_mapcount) >= 0;
+	return folio_large_is_mapped(page_folio(page));
 }
 
 static inline struct page *virt_to_head_page(const void *x)
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 011a7530dc76..5dadb9a3e010 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -204,14 +204,15 @@ void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address);
 
-void page_dup_compound_rmap(struct page *page, bool compound);
+void page_dup_compound_rmap(struct page *page);
 
 static inline void page_dup_file_rmap(struct page *page, bool compound)
 {
-	if (PageCompound(page))
-		page_dup_compound_rmap(page, compound);
-	else
+	/* Is page being mapped by PTE? */
+	if (likely(!compound))
 		atomic_inc(&page->_mapcount);
+	else
+		page_dup_compound_rmap(page);
 }
 
 /**
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 30056efc79ad..3dee8665c585 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2215,7 +2215,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, entry);
 		if (!pmd_migration)
-			page_dup_compound_rmap(page + i, false);
+			page_add_anon_rmap(page + i, vma, addr, false);
 		pte_unmap(pte);
 	}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 4833d28c5e1a..e813785da613 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1117,55 +1117,36 @@ static void unlock_compound_mapcounts(struct page *head,
 	bit_spin_unlock(PG_locked, &head[1].flags);
 }
 
-/*
- * When acting on a compound page under lock_compound_mapcounts(), avoid the
- * unnecessary overhead of an actual atomic operation on its subpage mapcount.
- * Return true if this is the first increment or the last decrement
- * (remembering that page->_mapcount -1 represents logical mapcount 0).
- */
-static bool subpage_mapcount_inc(struct page *page)
-{
-	int orig_mapcount = atomic_read(&page->_mapcount);
-
-	atomic_set(&page->_mapcount, orig_mapcount + 1);
-	return orig_mapcount < 0;
-}
-
-static bool subpage_mapcount_dec(struct page *page)
-{
-	int orig_mapcount = atomic_read(&page->_mapcount);
-
-	atomic_set(&page->_mapcount, orig_mapcount - 1);
-	return orig_mapcount == 0;
-}
-
-/*
- * When mapping a THP's first pmd, or unmapping its last pmd, if that THP
- * also has pte mappings, then those must be discounted: in order to maintain
- * NR_ANON_MAPPED and NR_FILE_MAPPED statistics exactly, without any drift,
- * and to decide when an anon THP should be put on the deferred split queue.
- * This function must be called between lock_ and unlock_compound_mapcounts().
- */
-static int nr_subpages_unmapped(struct page *head, int nr_subpages)
+int total_compound_mapcount(struct page *head)
 {
-	int nr = nr_subpages;
+	int mapcount = head_compound_mapcount(head);
+	int nr_subpages;
 	int i;
 
-	/* Discount those subpages mapped by pte */
+	/* In the common case, avoid the loop when no subpages mapped by PTE */
+	if (head_subpages_mapcount(head) == 0)
+		return mapcount;
+	/*
+	 * Add all the PTE mappings of those subpages mapped by PTE.
+	 * Limit the loop, knowing that only subpages_mapcount are mapped?
+	 * Perhaps: given all the raciness, that may be a good or a bad idea.
+	 */
+	nr_subpages = thp_nr_pages(head);
 	for (i = 0; i < nr_subpages; i++)
-		if (atomic_read(&head[i]._mapcount) >= 0)
-			nr--;
-	return nr;
+		mapcount += atomic_read(&head[i]._mapcount);
+
+	/* But each of those _mapcounts was based on -1 */
+	mapcount += nr_subpages;
+	return mapcount;
 }
 
 /*
- * page_dup_compound_rmap(), used when copying mm, or when splitting pmd,
+ * page_dup_compound_rmap(), used when copying mm,
  * provides a simple example of using lock_ and unlock_compound_mapcounts().
  */
-void page_dup_compound_rmap(struct page *page, bool compound)
+void page_dup_compound_rmap(struct page *head)
 {
 	struct compound_mapcounts mapcounts;
-	struct page *head;
 
 	/*
 	 * Hugetlb pages could use lock_compound_mapcounts(), like THPs do;
@@ -1176,20 +1157,15 @@ void page_dup_compound_rmap(struct page *page, bool compound)
 	 * Note that hugetlb does not call page_add_file_rmap():
 	 * here is where hugetlb shared page mapcount is raised.
 	 */
-	if (PageHuge(page)) {
-		atomic_inc(compound_mapcount_ptr(page));
-		return;
-	}
+	if (PageHuge(head)) {
+		atomic_inc(compound_mapcount_ptr(head));
+	} else if (PageTransHuge(head)) {
+		/* That test is redundant: it's for safety or to optimize out */
 
-	head = compound_head(page);
-	lock_compound_mapcounts(head, &mapcounts);
-	if (compound) {
+		lock_compound_mapcounts(head, &mapcounts);
 		mapcounts.compound_mapcount++;
-	} else {
-		mapcounts.subpages_mapcount++;
-		subpage_mapcount_inc(page);
+		unlock_compound_mapcounts(head, &mapcounts);
 	}
-	unlock_compound_mapcounts(head, &mapcounts);
 }
 
 /**
@@ -1304,35 +1280,34 @@ void page_add_anon_rmap(struct page *page,
 	struct compound_mapcounts mapcounts;
 	int nr = 0, nr_pmdmapped = 0;
 	bool compound = flags & RMAP_COMPOUND;
-	bool first;
+	bool first = true;
 
 	if (unlikely(PageKsm(page)))
 		lock_page_memcg(page);
-	else
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
 
-	if (likely(!PageCompound(page))) {
+	/* Is page being mapped by PTE? Is this its first map to be added? */
+	if (likely(!compound)) {
 		first = atomic_inc_and_test(&page->_mapcount);
 		nr = first;
+		if (first && PageCompound(page)) {
+			struct page *head = compound_head(page);
+
+			lock_compound_mapcounts(head, &mapcounts);
+			mapcounts.subpages_mapcount++;
+			nr = !mapcounts.compound_mapcount;
+			unlock_compound_mapcounts(head, &mapcounts);
+		}
+	} else if (PageTransHuge(page)) {
+		/* That test is redundant: it's for safety or to optimize out */
 
-	} else if (compound && PageTransHuge(page)) {
 		lock_compound_mapcounts(page, &mapcounts);
 		first = !mapcounts.compound_mapcount;
 		mapcounts.compound_mapcount++;
 		if (first) {
-			nr = nr_pmdmapped = thp_nr_pages(page);
-			if (mapcounts.subpages_mapcount)
-				nr = nr_subpages_unmapped(page, nr_pmdmapped);
+			nr_pmdmapped = thp_nr_pages(page);
+			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
 		}
 		unlock_compound_mapcounts(page, &mapcounts);
-	} else {
-		struct page *head = compound_head(page);
-
-		lock_compound_mapcounts(head, &mapcounts);
-		mapcounts.subpages_mapcount++;
-		first = subpage_mapcount_inc(page);
-		nr = first && !mapcounts.compound_mapcount;
-		unlock_compound_mapcounts(head, &mapcounts);
 	}
 
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
@@ -1411,28 +1386,29 @@ void page_add_file_rmap(struct page *page,
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
 	lock_page_memcg(page);
 
-	if (likely(!PageCompound(page))) {
+	/* Is page being mapped by PTE? Is this its first map to be added? */
+	if (likely(!compound)) {
 		first = atomic_inc_and_test(&page->_mapcount);
 		nr = first;
+		if (first && PageCompound(page)) {
+			struct page *head = compound_head(page);
+
+			lock_compound_mapcounts(head, &mapcounts);
+			mapcounts.subpages_mapcount++;
+			nr = !mapcounts.compound_mapcount;
+			unlock_compound_mapcounts(head, &mapcounts);
+		}
+	} else if (PageTransHuge(page)) {
+		/* That test is redundant: it's for safety or to optimize out */
 
-	} else if (compound && PageTransHuge(page)) {
 		lock_compound_mapcounts(page, &mapcounts);
 		first = !mapcounts.compound_mapcount;
 		mapcounts.compound_mapcount++;
 		if (first) {
-			nr = nr_pmdmapped = thp_nr_pages(page);
-			if (mapcounts.subpages_mapcount)
-				nr = nr_subpages_unmapped(page, nr_pmdmapped);
+			nr_pmdmapped = thp_nr_pages(page);
+			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
 		}
 		unlock_compound_mapcounts(page, &mapcounts);
-	} else {
-		struct page *head = compound_head(page);
-
-		lock_compound_mapcounts(head, &mapcounts);
-		mapcounts.subpages_mapcount++;
-		first = subpage_mapcount_inc(page);
-		nr = first && !mapcounts.compound_mapcount;
-		unlock_compound_mapcounts(head, &mapcounts);
 	}
 
 	if (nr_pmdmapped)
@@ -1471,29 +1447,29 @@ void page_remove_rmap(struct page *page,
 
 	lock_page_memcg(page);
 
-	/* page still mapped by someone else? */
-	if (likely(!PageCompound(page))) {
+	/* Is page being unmapped by PTE? Is this its last map to be removed? */
+	if (likely(!compound)) {
 		last = atomic_add_negative(-1, &page->_mapcount);
 		nr = last;
+		if (last && PageCompound(page)) {
+			struct page *head = compound_head(page);
+
+			lock_compound_mapcounts(head, &mapcounts);
+			mapcounts.subpages_mapcount--;
+			nr = !mapcounts.compound_mapcount;
+			unlock_compound_mapcounts(head, &mapcounts);
+		}
+	} else if (PageTransHuge(page)) {
+		/* That test is redundant: it's for safety or to optimize out */
 
-	} else if (compound && PageTransHuge(page)) {
 		lock_compound_mapcounts(page, &mapcounts);
 		mapcounts.compound_mapcount--;
 		last = !mapcounts.compound_mapcount;
 		if (last) {
-			nr = nr_pmdmapped = thp_nr_pages(page);
-			if (mapcounts.subpages_mapcount)
-				nr = nr_subpages_unmapped(page, nr_pmdmapped);
+			nr_pmdmapped = thp_nr_pages(page);
+			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
 		}
 		unlock_compound_mapcounts(page, &mapcounts);
-	} else {
-		struct page *head = compound_head(page);
-
-		lock_compound_mapcounts(head, &mapcounts);
-		mapcounts.subpages_mapcount--;
-		last = subpage_mapcount_dec(page);
-		nr = last && !mapcounts.compound_mapcount;
-		unlock_compound_mapcounts(head, &mapcounts);
 	}
 
 	if (nr_pmdmapped) {
-- 
2.35.3

