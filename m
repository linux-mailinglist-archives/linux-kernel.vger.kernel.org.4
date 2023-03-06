Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75CD6AD23E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCFXAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCFXAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:00:20 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0896580E9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 15:00:12 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c525d470so117563117b3.18
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 15:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678143612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0jScJs8gPXRLiSO6nJC4f1UlDdjOsBUk8woW1tgEqwQ=;
        b=CA7NJzzABDuyMIx39yOVjD21ZazHLorgmgYJs4KgfHCpwfeQmmuT82P7+v0L3PDuOx
         +K+K6CXCu5109HuQycvHX4rNE+5yUkqzz7V5wjda3TF59JpZBwR5LMmISRtqmwD/HN+T
         ZdW0MWMPZEpd7l8FJtBIGTBAXEg57BN5Mc5nCohnUPmoUs3BwPLkTWyvSCp8TfhkrJ3N
         aEH2Pet/7Pykpn6PU2oKL/9mdp5vBBduTXvq9sgjipXTJycSyVdMfrIpWUQoivnDKfpT
         pLKYm+C7JsL/ywpCGZh8qcyRRbEaMfY+ds2x/8xEHrZ5RzxgvfbXGS0JaZN4c7kW+S1S
         iorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jScJs8gPXRLiSO6nJC4f1UlDdjOsBUk8woW1tgEqwQ=;
        b=UiKY+R73TQk5TNJ5b37zulWFj49TFeolq6y0W4C6bZX7UX4NtZ5Tq5t/3g8V7bGGU+
         Oh08dpSpqbicLgLTkBVnyZTlNQxcojnFY/pCCkzlxOB8DtEPZ5kitfdw9dBEBNpM7uCz
         zRokz6Pzudy5UrtJSTjTNIw0FYYySFv1zZ75jtSmc/lFaB4LPckBBWDJeJXR2Dju+XxJ
         pNg4jnvWx4MkoY0In0x6842xL66hzX1ie2D/Mh18gSNfjj8fBFRcZ1itlSSV5hGhtwd9
         H04UspnlOa6mwY3hDMHSnw8rLrRftxG6ZhXOr6De2sqsJymrmUDyeA2Q9bHbBsVRdkk8
         9iNg==
X-Gm-Message-State: AO0yUKUidfHt5YzXKrhT8lfSUExeerqyNcLR53fDBjUQKJCApaYCG5wK
        9xtPKHX4o9SmNWd4Fzw9K4KHIEkaA5BKZOif
X-Google-Smtp-Source: AK7set8+h6XVzMynblTqho9bgX5+xF0hOFYOMqIT0/C64hcBJetdsYtWLYMthVmrbzbpZLQWnVDBI1Sfi4C4coRB
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:1cb:0:b0:aa2:475c:2982 with SMTP id
 f11-20020a5b01cb000000b00aa2475c2982mr5814442ybp.1.1678143611858; Mon, 06 Mar
 2023 15:00:11 -0800 (PST)
Date:   Mon,  6 Mar 2023 23:00:03 +0000
In-Reply-To: <20230306230004.1387007-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230306230004.1387007-1-jthoughton@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306230004.1387007-2-jthoughton@google.com>
Subject: [PATCH 1/2] mm: rmap: make hugetlb pages participate in _nr_pages_mapped
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For compound mappings (compound=true), _nr_pages_mapped will now be
incremented by COMPOUND_MAPPED when the first compound mapping is
created.

For small mappings, _nr_pages_mapped is incremented by 1 when the
particular small page is mapped for the first time. This is incompatible
with HPageVmemmapOptimize()ed folios, as most of the tail page structs
will be mapped read-only.

Currently HugeTLB always passes compound=true, but in the future,
HugeTLB pages may be mapped with small mappings.

To implement this change:
 1. Replace most of HugeTLB's calls to page_dup_file_rmap() with
    page_add_file_rmap(). The call in copy_hugetlb_page_range() is kept.
 2. Update page_add_file_rmap() and page_remove_rmap() to support
    HugeTLB folios.
 3. Update hugepage_add_anon_rmap() and hugepage_add_new_anon_rmap() to
    also increment _nr_pages_mapped properly.

With these changes, folio_large_is_mapped() no longer needs to check
_entire_mapcount.

HugeTLB doesn't use LRU or mlock, so page_add_file_rmap() and
page_remove_rmap() excludes those pieces. It is also important that
the folio_test_pmd_mappable() check is removed (or changed), as it's
possible to have a HugeTLB page whose order is not >= HPAGE_PMD_ORDER,
like arm64's CONT_PTE_SIZE HugeTLB pages.

This patch limits HugeTLB pages to 16G in size. That limit can be
increased if COMPOUND_MAPPED is raised.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce1590933995..25c898c51129 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1143,12 +1143,7 @@ static inline int total_mapcount(struct page *page)
 
 static inline bool folio_large_is_mapped(struct folio *folio)
 {
-	/*
-	 * Reading _entire_mapcount below could be omitted if hugetlb
-	 * participated in incrementing nr_pages_mapped when compound mapped.
-	 */
-	return atomic_read(&folio->_nr_pages_mapped) > 0 ||
-		atomic_read(&folio->_entire_mapcount) >= 0;
+	return atomic_read(&folio->_nr_pages_mapped) > 0;
 }
 
 /**
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 07abcb6eb203..bf3d327cd1b9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5911,7 +5911,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	if (anon_rmap)
 		hugepage_add_new_anon_rmap(folio, vma, haddr);
 	else
-		page_dup_file_rmap(&folio->page, true);
+		page_add_file_rmap(&folio->page, vma, true);
 	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
 	/*
@@ -6293,7 +6293,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
-		page_dup_file_rmap(&folio->page, true);
+		page_add_file_rmap(&folio->page, dst_vma, true);
 	else
 		hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
 
diff --git a/mm/internal.h b/mm/internal.h
index fce94775819c..400451a4dd49 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -55,8 +55,7 @@ void page_writeback_init(void);
 /*
  * If a 16GB hugetlb folio were mapped by PTEs of all of its 4kB pages,
  * its nr_pages_mapped would be 0x400000: choose the COMPOUND_MAPPED bit
- * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE).  Hugetlb currently
- * leaves nr_pages_mapped at 0, but avoid surprise if it participates later.
+ * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE).
  */
 #define COMPOUND_MAPPED		0x800000
 #define FOLIO_PAGES_MAPPED	(COMPOUND_MAPPED - 1)
diff --git a/mm/migrate.c b/mm/migrate.c
index 476cd24e8f32..c95c1cbc7a47 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -254,7 +254,7 @@ static bool remove_migration_pte(struct folio *folio,
 				hugepage_add_anon_rmap(new, vma, pvmw.address,
 						       rmap_flags);
 			else
-				page_dup_file_rmap(new, true);
+				page_add_file_rmap(new, vma, true);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		} else
 #endif
diff --git a/mm/rmap.c b/mm/rmap.c
index ba901c416785..4a975429b91a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1316,19 +1316,21 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 	int nr = 0, nr_pmdmapped = 0;
 	bool first;
 
-	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
+	VM_BUG_ON_PAGE(compound && !PageTransHuge(page)
+				&& !folio_test_hugetlb(folio), page);
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
 	if (likely(!compound)) {
+		if (unlikely(folio_test_hugetlb(folio)))
+			VM_BUG_ON_PAGE(HPageVmemmapOptimized(&folio->page),
+				       page);
 		first = atomic_inc_and_test(&page->_mapcount);
 		nr = first;
 		if (first && folio_test_large(folio)) {
 			nr = atomic_inc_return_relaxed(mapped);
 			nr = (nr < COMPOUND_MAPPED);
 		}
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
+	} else {
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
@@ -1345,6 +1347,9 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 		}
 	}
 
+	if (folio_test_hugetlb(folio))
+		return;
+
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
 			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
@@ -1373,24 +1378,18 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
-	/* Hugetlb pages are not counted in NR_*MAPPED */
-	if (unlikely(folio_test_hugetlb(folio))) {
-		/* hugetlb pages are always mapped with pmds */
-		atomic_dec(&folio->_entire_mapcount);
-		return;
-	}
-
 	/* Is page being unmapped by PTE? Is this its last map to be removed? */
 	if (likely(!compound)) {
+		if (unlikely(folio_test_hugetlb(folio)))
+			VM_BUG_ON_PAGE(HPageVmemmapOptimized(&folio->page),
+				       page);
 		last = atomic_add_negative(-1, &page->_mapcount);
 		nr = last;
 		if (last && folio_test_large(folio)) {
 			nr = atomic_dec_return_relaxed(mapped);
 			nr = (nr < COMPOUND_MAPPED);
 		}
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
+	} else {
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
@@ -1407,6 +1406,9 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		}
 	}
 
+	if (folio_test_hugetlb(folio))
+		return;
+
 	if (nr_pmdmapped) {
 		if (folio_test_anon(folio))
 			idx = NR_ANON_THPS;
@@ -2541,9 +2543,11 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	first = atomic_inc_and_test(&folio->_entire_mapcount);
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
-	if (first)
+	if (first) {
+		atomic_add(COMPOUND_MAPPED, &folio->_nr_pages_mapped);
 		__page_set_anon_rmap(folio, page, vma, address,
 				     !!(flags & RMAP_EXCLUSIVE));
+	}
 }
 
 void hugepage_add_new_anon_rmap(struct folio *folio,
@@ -2552,6 +2556,7 @@ void hugepage_add_new_anon_rmap(struct folio *folio,
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	/* increment count (starts at -1) */
 	atomic_set(&folio->_entire_mapcount, 0);
+	atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
 	folio_clear_hugetlb_restore_reserve(folio);
 	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
 }
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

