Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE45728D4E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbjFIBwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbjFIBwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:52:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADFA1FDF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:52:23 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bad05c6b389so1366147276.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686275542; x=1688867542;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MICzT8g6d2gbosF05gYeCNQyYA3E/PyjzMQZ3kC9KOI=;
        b=PYctsQ9b4HrQorKzO7zX+fdJyjXUiN8i4W2q9bIpl7bYnCcy9KOZVUhjq8Som0kotl
         8hN3DheRVe/kgHsmckj1HIHUS7QkhDrduKAtxjWrJ7uPd3Z1kPi0K/a74/drhVMrEv5N
         iyFn0O/U0PF+LJj7jEIWaYX3IwAMgIU4MQFfWd5rKkg5CQiQ4VOa9f2TnjccivpRjNpe
         MLfjrjWUH5cF/6qTPBYKfnjLb/mQJxgyL/APasFw6ccuLxdD/9qF0oXkbHPENouaIFKL
         go5KxwidvL12GJkGeTVlF7tb8Sm8kZvi4Yzd/FTjpbEMUsi8U+HBiLJXyA+0bfuLk/Ed
         ypDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686275542; x=1688867542;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MICzT8g6d2gbosF05gYeCNQyYA3E/PyjzMQZ3kC9KOI=;
        b=E5nK6VNSd2JVpdRHj6mGK8T+J1i1SS0VwADD7oaIIA1s6aa0+vDoXS7OEtZS+/D+cC
         Sc1kY2PmVNtqjEY6G1gUtesUYPwZ/jaGIll+vOPfmlh+jfuGfR3vQ+7/cOEbA2E73C5u
         B0kqr4ebkvvTQpH2AFZiVLs2A9PF1zewO9zsU9jjpmRuJkGi6q4c3SWS24J2GhM/W/H+
         YarSknjebkegQEDUJ6lz+dTPr+12jczzi8JIlFy4WQD6bSX4XX3R7hTFuVCSZZ2hX5fE
         z2XQRD80qGQtm4nXaMfEzJU0uzomEjXx+DvNTYZwX3GJfQVWGntqY00R5ME1bbGTVuUJ
         v0HQ==
X-Gm-Message-State: AC+VfDymIVjUDNA8Mg7V96qeFBhv3JEgkm21bcETmKuWgKjNtlAXXT0F
        Sqtb0llfsjEb97pok3r4h6UO3g==
X-Google-Smtp-Source: ACHHUZ4s2iHF1O1eWsJO+RR6O7kpy/Z7YTwwVNBnE8hanvEwdCoqR2iged2HkuPKJixJaGakJ6Kn7w==
X-Received: by 2002:a0d:cf86:0:b0:559:ed0a:96c4 with SMTP id r128-20020a0dcf86000000b00559ed0a96c4mr1168635ywd.44.1686275542179;
        Thu, 08 Jun 2023 18:52:22 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j81-20020a816e54000000b00569e7cbcd56sm300407ywc.69.2023.06.08.18.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:52:21 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:52:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 31/32] mm/swap: swap_vma_readahead() do the
 pte_offset_map()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <b7c64ab3-9e44-aac0-d2b-c57de578af1c@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap_vma_readahead() has been proceeding in an unconventional way, its
preliminary swap_ra_info() doing the pte_offset_map() and pte_unmap(),
then relying on that pte pointer even after the pte_unmap() - in its
CONFIG_64BIT case (I think !CONFIG_HIGHPTE was intended; whereas 32-bit
copied ptes to stack while they were mapped, but had to limit how many).

Though it would be difficult to construct a failing testcase, accessing
page table after pte_unmap() will become bad practice, even on 64-bit:
an rcu_read_unlock() in pte_unmap() will allow page table to be freed.

Move relevant definitions from include/linux/swap.h to mm/swap_state.c,
nothing else used them.  Delete the CONFIG_64BIT distinction and buffer,
delete all reference to ptes from swap_ra_info(), use pte_offset_map()
repeatedly in swap_vma_readahead(), breaking from the loop if it fails.

(Will the repeated "map" and "unmap" show up as a slowdown anywhere?
If so, maybe modify __read_swap_cache_async() to do the pte_unmap()
only when it does not find the page already in the swapcache.)

Use ptep_get_lockless(), mainly for its READ_ONCE().  Correctly advance
the address passed down to each call of __read__swap_cache_async().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/swap.h | 19 -------------------
 mm/swap_state.c      | 45 +++++++++++++++++++++++---------------------
 2 files changed, 24 insertions(+), 40 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3c69cb653cb9..1b9f2d92fc10 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -337,25 +337,6 @@ struct swap_info_struct {
 					   */
 };
 
-#ifdef CONFIG_64BIT
-#define SWAP_RA_ORDER_CEILING	5
-#else
-/* Avoid stack overflow, because we need to save part of page table */
-#define SWAP_RA_ORDER_CEILING	3
-#define SWAP_RA_PTE_CACHE_SIZE	(1 << SWAP_RA_ORDER_CEILING)
-#endif
-
-struct vma_swap_readahead {
-	unsigned short win;
-	unsigned short offset;
-	unsigned short nr_pte;
-#ifdef CONFIG_64BIT
-	pte_t *ptes;
-#else
-	pte_t ptes[SWAP_RA_PTE_CACHE_SIZE];
-#endif
-};
-
 static inline swp_entry_t folio_swap_entry(struct folio *folio)
 {
 	swp_entry_t entry = { .val = page_private(&folio->page) };
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b76a65ac28b3..a43b41975da2 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -698,6 +698,14 @@ void exit_swap_address_space(unsigned int type)
 	swapper_spaces[type] = NULL;
 }
 
+#define SWAP_RA_ORDER_CEILING	5
+
+struct vma_swap_readahead {
+	unsigned short win;
+	unsigned short offset;
+	unsigned short nr_pte;
+};
+
 static void swap_ra_info(struct vm_fault *vmf,
 			 struct vma_swap_readahead *ra_info)
 {
@@ -705,11 +713,7 @@ static void swap_ra_info(struct vm_fault *vmf,
 	unsigned long ra_val;
 	unsigned long faddr, pfn, fpfn, lpfn, rpfn;
 	unsigned long start, end;
-	pte_t *pte, *orig_pte;
 	unsigned int max_win, hits, prev_win, win;
-#ifndef CONFIG_64BIT
-	pte_t *tpte;
-#endif
 
 	max_win = 1 << min_t(unsigned int, READ_ONCE(page_cluster),
 			     SWAP_RA_ORDER_CEILING);
@@ -728,12 +732,9 @@ static void swap_ra_info(struct vm_fault *vmf,
 					       max_win, prev_win);
 	atomic_long_set(&vma->swap_readahead_info,
 			SWAP_RA_VAL(faddr, win, 0));
-
 	if (win == 1)
 		return;
 
-	/* Copy the PTEs because the page table may be unmapped */
-	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
 	if (fpfn == pfn + 1) {
 		lpfn = fpfn;
 		rpfn = fpfn + win;
@@ -753,15 +754,6 @@ static void swap_ra_info(struct vm_fault *vmf,
 
 	ra_info->nr_pte = end - start;
 	ra_info->offset = fpfn - start;
-	pte -= ra_info->offset;
-#ifdef CONFIG_64BIT
-	ra_info->ptes = pte;
-#else
-	tpte = ra_info->ptes;
-	for (pfn = start; pfn != end; pfn++)
-		*tpte++ = *pte++;
-#endif
-	pte_unmap(orig_pte);
 }
 
 /**
@@ -785,7 +777,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	struct swap_iocb *splug = NULL;
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
-	pte_t *pte, pentry;
+	pte_t *pte = NULL, pentry;
+	unsigned long addr;
 	swp_entry_t entry;
 	unsigned int i;
 	bool page_allocated;
@@ -797,17 +790,25 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	if (ra_info.win == 1)
 		goto skip;
 
+	addr = vmf->address - (ra_info.offset * PAGE_SIZE);
+
 	blk_start_plug(&plug);
-	for (i = 0, pte = ra_info.ptes; i < ra_info.nr_pte;
-	     i++, pte++) {
-		pentry = *pte;
+	for (i = 0; i < ra_info.nr_pte; i++, addr += PAGE_SIZE) {
+		if (!pte++) {
+			pte = pte_offset_map(vmf->pmd, addr);
+			if (!pte)
+				break;
+		}
+		pentry = ptep_get_lockless(pte);
 		if (!is_swap_pte(pentry))
 			continue;
 		entry = pte_to_swp_entry(pentry);
 		if (unlikely(non_swap_entry(entry)))
 			continue;
+		pte_unmap(pte);
+		pte = NULL;
 		page = __read_swap_cache_async(entry, gfp_mask, vma,
-					       vmf->address, &page_allocated);
+					       addr, &page_allocated);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -819,6 +820,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		}
 		put_page(page);
 	}
+	if (pte)
+		pte_unmap(pte);
 	blk_finish_plug(&plug);
 	swap_read_unplug(splug);
 	lru_add_drain();
-- 
2.35.3

