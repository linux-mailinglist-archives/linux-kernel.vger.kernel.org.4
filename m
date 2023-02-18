Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF369B6B6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBRA3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjBRA2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:28:50 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184F35D3DC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:49 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53659386dc8so20702647b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nelWhEWWDb3ok6PYl3fRG2FGkHP98SSg6vQYnhj1QJk=;
        b=UvLBkxS6HWSvm6F/1ZojF9oUJKGMsoR6TJYUH52tIUGTUnHPSS4OjC8ZKXvwZwASAV
         tHFCfrP/r3B6sftGO2ROO6qyp0hWV5ssCNe8BVzZ/8UYiB4V6Kh8RSM5cqHAivyWBXpO
         lalg+riEaU3qUCklp3VFoj3s+ykjm2m5yzWRFdOAwMvlFIaPzMq9C6wMUYVDqXxeAYN4
         ydi5/oNHHp4Z8bFgiq0SG1+hakJtq3Bas6/hdi8e26/G9KknLRZXzrhTcc3TXa9yzpwQ
         m8r8Qx+aRsi+iePo4b0oOe0PRXw52ZFZExKevE8Zt1tK+nMw9eyeE3g+fji1JRRzlVBM
         Sb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nelWhEWWDb3ok6PYl3fRG2FGkHP98SSg6vQYnhj1QJk=;
        b=quRgufxWyMhwKPm5XptNlcLylFb7dMsE2Zl8L+/6tHn6rru8rRZOrKznOokuR/i2OP
         xYySJfAcP8s+iXOm1K7cyHhFtKCjCQDI9Nui/7g62uvSJ62kXBf4QzCWzIKbjgh0JbQS
         4PG71p6DxktD9QVDAP+rQd/GPPUQhjJxs+Sg+9dgcvNFmN3FKnwcX8hlP/+2PYxEI0iY
         +1+IGFstgoja0Om4y3AoDHOwNDwprlljIlB6PqHKtZa90fMe73s/VkNcZnATAVkbpayq
         yKdfwV1L19Y/Nnka7qku3inlAMaFHiXWsvnoRCFlXZSOnlP9s/G3tgqeXN3MouXe9CEw
         zfWg==
X-Gm-Message-State: AO0yUKXCrSMAk/0akckQIHPYxgwYvqJNIIm63L95NeqZIe0X5fhcFfLp
        1tMO7AyeoP7HxiUSN04gLyyPWkr84by35lDz
X-Google-Smtp-Source: AK7set/Hqt7/tFdWTqNQyJko4/eRErfrIERd8YtMlK8cdL7HORy0LZ2CmPBJNFYLl26tfN06LjHCnVCVpHyEbeAH
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:b705:0:b0:534:d71f:14e6 with SMTP
 id v5-20020a81b705000000b00534d71f14e6mr53479ywh.9.1676680128284; Fri, 17 Feb
 2023 16:28:48 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:38 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-6-jthoughton@google.com>
Subject: [PATCH v2 05/46] rmap: hugetlb: switch from page_dup_file_rmap to page_add_file_rmap
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
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

This only applies to file-backed HugeTLB, and it should be a no-op until
high-granularity mapping is possible. Also update page_remove_rmap to
support the eventual case where !compound && folio_test_hugetlb().

HugeTLB doesn't use LRU or mlock, so we avoid those bits. This also
means we don't need to use subpage_mapcount; if we did, it would
overflow with only a few mappings.

There is still one caller of page_dup_file_rmap left: copy_present_pte,
and it is always called with compound=false in this case.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 08004371cfed..6c008c9de80e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5077,7 +5077,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * sleep during the process.
 			 */
 			if (!PageAnon(ptepage)) {
-				page_dup_file_rmap(ptepage, true);
+				page_add_file_rmap(ptepage, src_vma, true);
 			} else if (page_try_dup_anon_rmap(ptepage, true,
 							  src_vma)) {
 				pte_t src_pte_old = entry;
@@ -5910,7 +5910,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	if (anon_rmap)
 		hugepage_add_new_anon_rmap(folio, vma, haddr);
 	else
-		page_dup_file_rmap(&folio->page, true);
+		page_add_file_rmap(&folio->page, vma, true);
 	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
 	/*
@@ -6301,7 +6301,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
-		page_dup_file_rmap(&folio->page, true);
+		page_add_file_rmap(&folio->page, dst_vma, true);
 	else
 		hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index d3964c414010..b0f87f19b536 100644
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
index 15ae24585fc4..c010d0af3a82 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1318,21 +1318,21 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 	int nr = 0, nr_pmdmapped = 0;
 	bool first;
 
-	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
+	VM_BUG_ON_PAGE(compound && !PageTransHuge(page)
+				&& !folio_test_hugetlb(folio), page);
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
 	if (likely(!compound)) {
 		first = atomic_inc_and_test(&page->_mapcount);
 		nr = first;
-		if (first && folio_test_large(folio)) {
+		if (first && folio_test_large(folio)
+			  && !folio_test_hugetlb(folio)) {
 			nr = atomic_inc_return_relaxed(mapped);
 			nr = (nr < COMPOUND_MAPPED);
 		}
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
+	} else {
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
-		if (first) {
+		if (first && !folio_test_hugetlb(folio)) {
 			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
 			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
 				nr_pmdmapped = folio_nr_pages(folio);
@@ -1347,6 +1347,9 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 		}
 	}
 
+	if (folio_test_hugetlb(folio))
+		return;
+
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
 			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
@@ -1376,8 +1379,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
 	/* Hugetlb pages are not counted in NR_*MAPPED */
-	if (unlikely(folio_test_hugetlb(folio))) {
-		/* hugetlb pages are always mapped with pmds */
+	if (unlikely(folio_test_hugetlb(folio)) && compound) {
 		atomic_dec(&folio->_entire_mapcount);
 		return;
 	}
@@ -1386,15 +1388,14 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 	if (likely(!compound)) {
 		last = atomic_add_negative(-1, &page->_mapcount);
 		nr = last;
-		if (last && folio_test_large(folio)) {
+		if (last && folio_test_large(folio)
+			 && !folio_test_hugetlb(folio)) {
 			nr = atomic_dec_return_relaxed(mapped);
 			nr = (nr < COMPOUND_MAPPED);
 		}
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
+	} else {
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
-		if (last) {
+		if (last && !folio_test_hugetlb(folio)) {
 			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
 			if (likely(nr < COMPOUND_MAPPED)) {
 				nr_pmdmapped = folio_nr_pages(folio);
@@ -1409,6 +1410,9 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		}
 	}
 
+	if (folio_test_hugetlb(folio))
+		return;
+
 	if (nr_pmdmapped) {
 		if (folio_test_anon(folio))
 			idx = NR_ANON_THPS;
-- 
2.39.2.637.g21b0678d19-goog

