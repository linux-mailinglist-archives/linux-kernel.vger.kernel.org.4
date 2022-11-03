Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615BF6173E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiKCBxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiKCBxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:53:50 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66BE12088
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:53:48 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id n18so242256qvt.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 18:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YaZpQ1NHF9SZF0mEIhoOoKnncw6CNJmcKDpma4F+zIs=;
        b=SKqhVVUHvO2nz4PX9ddUD3aF0byEKITNSot13ZaBLWE43cTnUYtrfR/1i4wY7iUSXV
         Ft+GBgQmx8TMyT9T82dol+QurGp1qqc67fdJ8qlOF/cwu8Gl6BOgHgnv/UJy6RmWdLCR
         iIZkh7dDi99iEh5KvDb3/GI/5CCmoQh/Ei3K01Ihfxoil+0SuZUdGjXMVuhPk2z5Glj/
         sHzH5tpvcuB4YG/Nzn5aYTMuBgP/5wg0hvQ6QNsebTPCI47J9fl2h03EnHbcmexsdsZA
         hrrbyw/2jA2apIz6VguO6pO6kJNt2kWYt6i2mlQ2FYDajhr/+L1riPTp3gkeaETDsNWy
         HF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaZpQ1NHF9SZF0mEIhoOoKnncw6CNJmcKDpma4F+zIs=;
        b=2njJiLwrwpxo/dRaFv+USWVuqCFuQD32sP1/fJpSJawyQFO2dn/WC+hzH/EXQLCfXf
         A295MKX+Rm+b+w8GpUu4K6qNOVzxX4iSMJ3jmYxThI/flxJVq3miMi/WLUWIVVVwgnix
         xJXV2XZQl3irZRx5mUF4eGhcqtSQozes0Rcv1pAgXC4KGkjRdTEE8iiOZuyHv7VnsvQa
         HZnr0FyExALED+1HGtQC+RyYHBF02AxzFml6Wu3Fv3IZeaIE6Rl72DBR1fCV62MdQWK6
         4qokdKnmpqsuMdR4gXHgiqJNgidDdbD2G2zgXBgIKFXevpd2SaHMfaUr1QVcPh2dlVHG
         pPXw==
X-Gm-Message-State: ACrzQf3E8vvWRE4H4fSwEORGrLHdeGorQP8T/w5rgJfwFHw6g92LWAyu
        uXhGCkwa1g+8kaZAOeovt2SYCA==
X-Google-Smtp-Source: AMsMyM4oqiNtKpHPpFISw7Zpmc7jfCOIF8i+PjH1PkaTWO+VWyIabiX5q9xl4kvjtt5bnsuMnFbnUg==
X-Received: by 2002:a05:6214:c85:b0:4bb:693e:6ed3 with SMTP id r5-20020a0562140c8500b004bb693e6ed3mr24386626qvr.110.1667440427669;
        Wed, 02 Nov 2022 18:53:47 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z63-20020a37b042000000b006f9e103260dsm9564070qke.91.2022.11.02.18.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 18:53:47 -0700 (PDT)
Date:   Wed, 2 Nov 2022 18:53:45 -0700 (PDT)
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
Subject: [PATCH 3/3] mm,thp,rmap: lock_compound_mapcounts() on THP
 mapcounts
In-Reply-To: <5f52de70-975-e94f-f141-543765736181@google.com>
Message-ID: <1b42bd1a-8223-e827-602f-d466c2db7d3c@google.com>
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

Fix the races in maintaining compound_mapcount, subpages_mapcount and
subpage _mapcount by using PG_locked in the first tail of any compound
page for a bit_spin_lock() on such modifications; skipping the usual
atomic operations on those fields in this case.

Bring page_remove_file_rmap() and page_remove_anon_compound_rmap()
back into page_remove_rmap() itself.  Rearrange page_add_anon_rmap()
and page_add_file_rmap() and page_remove_rmap() to follow the same
"if (compound) {lock} else if (PageCompound) {lock} else {atomic}"
pattern (with a PageTransHuge in the compound test, like before, to
avoid BUG_ONs and optimize away that block when THP is not configured).
Move all the stats updates outside, after the bit_spin_locked section,
so that it is sure to be a leaf lock.

Add page_dup_compound_rmap() to manage compound locking versus atomics
in sync with the rest.  In particular, hugetlb pages are still using
the atomics: to avoid unnecessary interference there, and because they
never have subpage mappings; but this exception can easily be changed.
Conveniently, page_dup_compound_rmap() turns out to suit an anon THP's
__split_huge_pmd_locked() too.

bit_spin_lock() is not popular with PREEMPT_RT folks: but PREEMPT_RT
sensibly excludes TRANSPARENT_HUGEPAGE already, so its only exposure
is to the non-hugetlb non-THP pte-mapped compound pages (with large
folios being currently dependent on TRANSPARENT_HUGEPAGE).  There is
never any scan of subpages in this case; but we have chosen to use
PageCompound tests rather than PageTransCompound tests to gate the
use of lock_compound_mapcounts(), so that page_mapped() is correct on
all compound pages, whether or not TRANSPARENT_HUGEPAGE is enabled:
could that be a problem for PREEMPT_RT, when there is contention on
the lock - under heavy concurrent forking for example?  If so, then it
can be turned into a sleeping lock (like folio_lock()) when PREEMPT_RT.

A simple 100 X munmap(mmap(2GB, MAP_SHARED|MAP_POPULATE, tmpfs), 2GB)
took 18 seconds on small pages, and used to take 1 second on huge pages,
but now takes 115 milliseconds on huge pages.  Mapping by pmds a second
time used to take 860ms and now takes 86ms; mapping by pmds after mapping
by ptes (when the scan is needed) used to take 870ms and now takes 495ms.
Mapping huge pages by ptes is largely unaffected but variable: between 5%
faster and 5% slower in what I've recorded.  Contention on the lock is
likely to behave worse than contention on the atomics behaved.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 Documentation/mm/transhuge.rst |  16 +-
 include/linux/rmap.h           |  14 +-
 mm/huge_memory.c               |   3 +-
 mm/rmap.c                      | 333 +++++++++++++++++++--------------
 4 files changed, 204 insertions(+), 162 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index a560e0c01b16..1e2a637cc607 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -117,13 +117,15 @@ pages:
   - ->_refcount in tail pages is always zero: get_page_unless_zero() never
     succeeds on tail pages.
 
-  - map/unmap of the pages with PTE entry increment/decrement ->_mapcount
-    on relevant sub-page of the compound page.
-
-  - map/unmap of the whole compound page is accounted for in compound_mapcount
-    (stored in first tail page). For file huge pages, we also increment
-    ->_mapcount of all sub-pages in order to have race-free detection of
-    last unmap of subpages.
+  - map/unmap of PMD entry for the whole compound page increment/decrement
+    ->compound_mapcount, stored in the first tail page of the compound page.
+
+  - map/unmap of sub-pages with PTE entry increment/decrement ->_mapcount
+    on relevant sub-page of the compound page, and also increment/decrement
+    ->subpages_mapcount, stored in first tail page of the compound page.
+    In order to have race-free accounting of sub-pages mapped, changes to
+    sub-page ->_mapcount, ->subpages_mapcount and ->compound_mapcount are
+    are all locked by bit_spin_lock of PG_locked in the first tail ->flags.
 
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 1973649e8f93..011a7530dc76 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -204,16 +204,14 @@ void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address);
 
-static inline void __page_dup_rmap(struct page *page, bool compound)
-{
-	if (!compound && PageCompound(page))
-		atomic_inc(subpages_mapcount_ptr(compound_head(page)));
-	atomic_inc(compound ? compound_mapcount_ptr(page) : &page->_mapcount);
-}
+void page_dup_compound_rmap(struct page *page, bool compound);
 
 static inline void page_dup_file_rmap(struct page *page, bool compound)
 {
-	__page_dup_rmap(page, compound);
+	if (PageCompound(page))
+		page_dup_compound_rmap(page, compound);
+	else
+		atomic_inc(&page->_mapcount);
 }
 
 /**
@@ -262,7 +260,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
 	 * the page R/O into both processes.
 	 */
 dup:
-	__page_dup_rmap(page, compound);
+	page_dup_file_rmap(page, compound);
 	return 0;
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 23ff175768c3..2c4c668eee6c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2093,7 +2093,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
 		VM_BUG_ON_PAGE(!page_count(page), page);
 		page_ref_add(page, HPAGE_PMD_NR - 1);
-		atomic_add(HPAGE_PMD_NR, subpages_mapcount_ptr(page));
 
 		/*
 		 * Without "freeze", we'll simply split the PMD, propagating the
@@ -2170,7 +2169,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, entry);
 		if (!pmd_migration)
-			atomic_inc(&page[i]._mapcount);
+			page_dup_compound_rmap(page + i, false);
 		pte_unmap(pte);
 	}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index f43339ea4970..512e53cae2ca 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1085,11 +1085,66 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 	return page_vma_mkclean_one(&pvmw);
 }
 
+struct compound_mapcounts {
+	unsigned int compound_mapcount;
+	unsigned int subpages_mapcount;
+};
+
+/*
+ * lock_compound_mapcounts() first locks, then copies subpages_mapcount and
+ * compound_mapcount from head[1].compound_mapcount and subpages_mapcount,
+ * converting from struct page's internal representation to logical count
+ * (that is, adding 1 to compound_mapcount to hide its offset by -1).
+ */
+static void lock_compound_mapcounts(struct page *head,
+		struct compound_mapcounts *local)
+{
+	bit_spin_lock(PG_locked, &head[1].flags);
+	local->compound_mapcount = atomic_read(compound_mapcount_ptr(head)) + 1;
+	local->subpages_mapcount = atomic_read(subpages_mapcount_ptr(head));
+}
+
+/*
+ * After caller has updated subpage._mapcount, local subpages_mapcount and
+ * local compound_mapcount, as necessary, unlock_compound_mapcounts() converts
+ * and copies them back to the compound head[1] fields, and then unlocks.
+ */
+static void unlock_compound_mapcounts(struct page *head,
+		struct compound_mapcounts *local)
+{
+	atomic_set(compound_mapcount_ptr(head), local->compound_mapcount - 1);
+	atomic_set(subpages_mapcount_ptr(head), local->subpages_mapcount);
+	bit_spin_unlock(PG_locked, &head[1].flags);
+}
+
+/*
+ * When acting on a compound page under lock_compound_mapcounts(), avoid the
+ * unnecessary overhead of an actual atomic operation on its subpage mapcount.
+ * Return true if this is the first increment or the last decrement
+ * (remembering that page->_mapcount -1 represents logical mapcount 0).
+ */
+static bool subpage_mapcount_inc(struct page *page)
+{
+	int orig_mapcount = atomic_read(&page->_mapcount);
+
+	atomic_set(&page->_mapcount, orig_mapcount + 1);
+	return orig_mapcount < 0;
+}
+
+static bool subpage_mapcount_dec(struct page *page)
+{
+	int orig_mapcount = atomic_read(&page->_mapcount);
+
+	atomic_set(&page->_mapcount, orig_mapcount - 1);
+	return orig_mapcount == 0;
+}
+
 /*
  * When mapping a THP's first pmd, or unmapping its last pmd, if that THP
  * also has pte mappings, then those must be discounted: in order to maintain
  * NR_ANON_MAPPED and NR_FILE_MAPPED statistics exactly, without any drift,
  * and to decide when an anon THP should be put on the deferred split queue.
+ * This function must be called between lock_ and unlock_compound_mapcounts().
  */
 static int nr_subpages_unmapped(struct page *head, int nr_subpages)
 {
@@ -1103,6 +1158,40 @@ static int nr_subpages_unmapped(struct page *head, int nr_subpages)
 	return nr;
 }
 
+/*
+ * page_dup_compound_rmap(), used when copying mm, or when splitting pmd,
+ * provides a simple example of using lock_ and unlock_compound_mapcounts().
+ */
+void page_dup_compound_rmap(struct page *page, bool compound)
+{
+	struct compound_mapcounts mapcounts;
+	struct page *head;
+
+	/*
+	 * Hugetlb pages could use lock_compound_mapcounts(), like THPs do;
+	 * but at present they are still being managed by atomic operations:
+	 * which are likely to be somewhat faster, so don't rush to convert
+	 * them over without evaluating the effect.
+	 *
+	 * Note that hugetlb does not call page_add_file_rmap():
+	 * here is where hugetlb shared page mapcount is raised.
+	 */
+	if (PageHuge(page)) {
+		atomic_inc(compound_mapcount_ptr(page));
+		return;
+	}
+
+	head = compound_head(page);
+	lock_compound_mapcounts(head, &mapcounts);
+	if (compound) {
+		mapcounts.compound_mapcount++;
+	} else {
+		mapcounts.subpages_mapcount++;
+		subpage_mapcount_inc(page);
+	}
+	unlock_compound_mapcounts(head, &mapcounts);
+}
+
 /**
  * page_move_anon_rmap - move a page to our anon_vma
  * @page:	the page to move to our anon_vma
@@ -1212,7 +1301,8 @@ static void __page_check_anon_rmap(struct page *page,
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address, rmap_t flags)
 {
-	int nr, nr_pages;
+	struct compound_mapcounts mapcounts;
+	int nr = 0, nr_pmdmapped = 0;
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
 
@@ -1222,33 +1312,37 @@ void page_add_anon_rmap(struct page *page,
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 
 	if (compound && PageTransHuge(page)) {
-		atomic_t *mapcount;
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		mapcount = compound_mapcount_ptr(page);
-		first = atomic_inc_and_test(mapcount);
+		lock_compound_mapcounts(page, &mapcounts);
+		first = !mapcounts.compound_mapcount;
+		mapcounts.compound_mapcount++;
+		if (first) {
+			nr = nr_pmdmapped = thp_nr_pages(page);
+			if (mapcounts.subpages_mapcount)
+				nr = nr_subpages_unmapped(page, nr_pmdmapped);
+		}
+		unlock_compound_mapcounts(page, &mapcounts);
 
-		nr = nr_pages = thp_nr_pages(page);
-		if (first && head_subpages_mapcount(page))
-			nr = nr_subpages_unmapped(page, nr_pages);
-	} else {
-		nr = 1;
-		if (PageTransCompound(page)) {
-			struct page *head = compound_head(page);
+	} else if (PageCompound(page)) {
+		struct page *head = compound_head(page);
 
-			atomic_inc(subpages_mapcount_ptr(head));
-			nr = !head_compound_mapcount(head);
-		}
+		lock_compound_mapcounts(head, &mapcounts);
+		mapcounts.subpages_mapcount++;
+		first = subpage_mapcount_inc(page);
+		nr = first && !mapcounts.compound_mapcount;
+		unlock_compound_mapcounts(head, &mapcounts);
+
+	} else {
 		first = atomic_inc_and_test(&page->_mapcount);
+		nr = first;
 	}
 
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
 
-	if (first) {
-		if (compound)
-			__mod_lruvec_page_state(page, NR_ANON_THPS, nr_pages);
+	if (nr_pmdmapped)
+		__mod_lruvec_page_state(page, NR_ANON_THPS, nr_pmdmapped);
+	if (nr)
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
-	}
 
 	if (unlikely(PageKsm(page)))
 		unlock_page_memcg(page);
@@ -1308,39 +1402,41 @@ void page_add_new_anon_rmap(struct page *page,
 void page_add_file_rmap(struct page *page,
 	struct vm_area_struct *vma, bool compound)
 {
-	int nr = 0;
+	struct compound_mapcounts mapcounts;
+	int nr = 0, nr_pmdmapped = 0;
+	bool first;
 
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
 	lock_page_memcg(page);
+
 	if (compound && PageTransHuge(page)) {
-		int nr_pages;
+		lock_compound_mapcounts(page, &mapcounts);
+		first = !mapcounts.compound_mapcount;
+		mapcounts.compound_mapcount++;
+		if (first) {
+			nr = nr_pmdmapped = thp_nr_pages(page);
+			if (mapcounts.subpages_mapcount)
+				nr = nr_subpages_unmapped(page, nr_pmdmapped);
+		}
+		unlock_compound_mapcounts(page, &mapcounts);
 
-		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
-			goto out;
+	} else if (PageCompound(page)) {
+		struct page *head = compound_head(page);
 
-		nr = nr_pages = thp_nr_pages(page);
-		if (head_subpages_mapcount(page))
-			nr = nr_subpages_unmapped(page, nr_pages);
+		lock_compound_mapcounts(head, &mapcounts);
+		mapcounts.subpages_mapcount++;
+		first = subpage_mapcount_inc(page);
+		nr = first && !mapcounts.compound_mapcount;
+		unlock_compound_mapcounts(head, &mapcounts);
 
-		if (PageSwapBacked(page))
-			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
-						nr_pages);
-		else
-			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
-						nr_pages);
 	} else {
-		bool pmd_mapped = false;
-
-		if (PageTransCompound(page)) {
-			struct page *head = compound_head(page);
-
-			atomic_inc(subpages_mapcount_ptr(head));
-			pmd_mapped = head_compound_mapcount(head);
-		}
-		if (atomic_inc_and_test(&page->_mapcount) && !pmd_mapped)
-			nr++;
+		first = atomic_inc_and_test(&page->_mapcount);
+		nr = first;
 	}
-out:
+
+	if (nr_pmdmapped)
+		__mod_lruvec_page_state(page, PageSwapBacked(page) ?
+			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
 	if (nr)
 		__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
 	unlock_page_memcg(page);
@@ -1348,137 +1444,84 @@ void page_add_file_rmap(struct page *page,
 	mlock_vma_page(page, vma, compound);
 }
 
-static void page_remove_file_rmap(struct page *page, bool compound)
+/**
+ * page_remove_rmap - take down pte mapping from a page
+ * @page:	page to remove mapping from
+ * @vma:	the vm area from which the mapping is removed
+ * @compound:	uncharge the page as compound or small page
+ *
+ * The caller needs to hold the pte lock.
+ */
+void page_remove_rmap(struct page *page,
+	struct vm_area_struct *vma, bool compound)
 {
-	int nr = 0;
+	struct compound_mapcounts mapcounts;
+	int nr = 0, nr_pmdmapped = 0;
+	bool last;
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
-	/* Hugepages are not counted in NR_FILE_MAPPED for now. */
+	/* Hugetlb pages are not counted in NR_*MAPPED */
 	if (unlikely(PageHuge(page))) {
 		/* hugetlb pages are always mapped with pmds */
 		atomic_dec(compound_mapcount_ptr(page));
 		return;
 	}
 
+	lock_page_memcg(page);
+
 	/* page still mapped by someone else? */
 	if (compound && PageTransHuge(page)) {
-		int nr_pages;
+		lock_compound_mapcounts(page, &mapcounts);
+		mapcounts.compound_mapcount--;
+		last = !mapcounts.compound_mapcount;
+		if (last) {
+			nr = nr_pmdmapped = thp_nr_pages(page);
+			if (mapcounts.subpages_mapcount)
+				nr = nr_subpages_unmapped(page, nr_pmdmapped);
+		}
+		unlock_compound_mapcounts(page, &mapcounts);
 
-		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
-			return;
+	} else if (PageCompound(page)) {
+		struct page *head = compound_head(page);
 
-		nr = nr_pages = thp_nr_pages(page);
-		if (head_subpages_mapcount(page))
-			nr = nr_subpages_unmapped(page, nr_pages);
+		lock_compound_mapcounts(head, &mapcounts);
+		mapcounts.subpages_mapcount--;
+		last = subpage_mapcount_dec(page);
+		nr = last && !mapcounts.compound_mapcount;
+		unlock_compound_mapcounts(head, &mapcounts);
 
-		if (PageSwapBacked(page))
-			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
-						-nr_pages);
-		else
-			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
-						-nr_pages);
 	} else {
-		bool pmd_mapped = false;
-
-		if (PageTransCompound(page)) {
-			struct page *head = compound_head(page);
-
-			atomic_dec(subpages_mapcount_ptr(head));
-			pmd_mapped = head_compound_mapcount(head);
-		}
-		if (atomic_add_negative(-1, &page->_mapcount) && !pmd_mapped)
-			nr++;
+		last = atomic_add_negative(-1, &page->_mapcount);
+		nr = last;
 	}
 
-	if (nr)
-		__mod_lruvec_page_state(page, NR_FILE_MAPPED, -nr);
-}
-
-static void page_remove_anon_compound_rmap(struct page *page)
-{
-	int nr, nr_pages;
-
-	if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
-		return;
-
-	/* Hugepages are not counted in NR_ANON_PAGES for now. */
-	if (unlikely(PageHuge(page)))
-		return;
-
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-		return;
-
-	nr = nr_pages = thp_nr_pages(page);
-	__mod_lruvec_page_state(page, NR_ANON_THPS, -nr);
-
-	if (head_subpages_mapcount(page)) {
-		nr = nr_subpages_unmapped(page, nr_pages);
-
+	if (nr_pmdmapped) {
+		__mod_lruvec_page_state(page, PageAnon(page) ? NR_ANON_THPS :
+				(PageSwapBacked(page) ? NR_SHMEM_PMDMAPPED :
+				NR_FILE_PMDMAPPED), -nr_pmdmapped);
+	}
+	if (nr) {
+		__mod_lruvec_page_state(page, PageAnon(page) ? NR_ANON_MAPPED :
+				NR_FILE_MAPPED, -nr);
 		/*
-		 * Queue the page for deferred split if at least one small
+		 * Queue anon THP for deferred split if at least one small
 		 * page of the compound page is unmapped, but at least one
 		 * small page is still mapped.
 		 */
-		if (nr && nr < nr_pages)
-			deferred_split_huge_page(page);
-	}
-
-	if (nr)
-		__mod_lruvec_page_state(page, NR_ANON_MAPPED, -nr);
-}
-
-/**
- * page_remove_rmap - take down pte mapping from a page
- * @page:	page to remove mapping from
- * @vma:	the vm area from which the mapping is removed
- * @compound:	uncharge the page as compound or small page
- *
- * The caller needs to hold the pte lock.
- */
-void page_remove_rmap(struct page *page,
-	struct vm_area_struct *vma, bool compound)
-{
-	bool pmd_mapped = false;
-
-	lock_page_memcg(page);
-
-	if (!PageAnon(page)) {
-		page_remove_file_rmap(page, compound);
-		goto out;
+		if (PageTransCompound(page) && PageAnon(page))
+			if (!compound || nr < nr_pmdmapped)
+				deferred_split_huge_page(compound_head(page));
 	}
 
-	if (compound) {
-		page_remove_anon_compound_rmap(page);
-		goto out;
-	}
-
-	if (PageTransCompound(page)) {
-		struct page *head = compound_head(page);
-
-		atomic_dec(subpages_mapcount_ptr(head));
-		pmd_mapped = head_compound_mapcount(head);
-	}
-
-	/* page still mapped by someone else? */
-	if (!atomic_add_negative(-1, &page->_mapcount) || pmd_mapped)
-		goto out;
-
-	__dec_lruvec_page_state(page, NR_ANON_MAPPED);
-
-	if (PageTransCompound(page))
-		deferred_split_huge_page(compound_head(page));
-
 	/*
-	 * It would be tidy to reset the PageAnon mapping here,
+	 * It would be tidy to reset PageAnon mapping when fully unmapped,
 	 * but that might overwrite a racing page_add_anon_rmap
 	 * which increments mapcount after us but sets mapping
-	 * before us: so leave the reset to free_unref_page,
+	 * before us: so leave the reset to free_pages_prepare,
 	 * and remember that it's only reliable while mapped.
-	 * Leaving it set also helps swapoff to reinstate ptes
-	 * faster for those pages still in swapcache.
 	 */
-out:
+
 	unlock_page_memcg(page);
 
 	munlock_vma_page(page, vma, compound);
-- 
2.35.3

