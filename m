Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817C070B460
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjEVFMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEVFMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:12:14 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF10EA1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:12:12 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-561c1768bacso74710487b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732332; x=1687324332;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GAfzbPNj/2rvKRevzngE24N05kydgFSIoMtFyLCrv4=;
        b=Xury70gJk/Ie7HEmpym3Ju1gfiqnvb3lYbEkOk+qdASbHtYcBtM6f7yvCnD5Qi5hF5
         Xqo4lAQiP6+GN4sGJVvV6KOkXQkulHhobtYfAhUe9/l/2KsHbHtH2T86CZpNKlWRl63d
         IzMkj8FLns70Ingn1LKVytPrfZjfNvxgPvDTj2KhwHoFQ8Kx+CJ4VG6UzypdkQqqJSvO
         YWMudU4lJeyeTAt+pPO1YgidnSwVn5tO3duE8/EWyOVS7vVgZwJSIiPPVnzLsKahA0qM
         ZlEnIC4jzz74OlvLVDlS2OOEGCjrtDJzReiTZcHJL2Ft7dpNZsKSmX1OuM4OkIMXn0/q
         hnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732332; x=1687324332;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GAfzbPNj/2rvKRevzngE24N05kydgFSIoMtFyLCrv4=;
        b=LiJ6FVxUb5/H7vEheyNkoeGlcqFK4OZc0ItURGDdUJIDFho+rAFiNthtoX575hxln9
         xUm4LD7B9RhCcjb7qJl8r66ZMaZZejNoryE7pbiWOsVDLjjqdLRiLM5OWQra+fIcqN3H
         sfx9/FuLVepHWd0wvT06Opua98aD6ou49X53ZfES3xbeG59szChJeryh5QUAL+MTFhGv
         /dwAaZfPU0dSZQuF+MaHk9o+igYB3YsRWhF5+ixClAuxLoPb11acC226xvh4i/7ES/+c
         GR6z1kYuwfMEo3rC9Qd9Teq/vW3ZlRyldEweYPGnuOgWFTm01EeG0Hhj77GVoWu2neVN
         FScw==
X-Gm-Message-State: AC+VfDy+W7ytacL4VYSlIkC/FepYn+PcDHuLYCAFFpWq6Oqabs8Q7SO0
        QhZxpncTPqi/VV4c4o269EczYA==
X-Google-Smtp-Source: ACHHUZ5YOFvYflvdD4FMdNwpV45kv2pl6g6+I95eOvlzunuPKVoSDfQex4to1CKCQVwtCrNkcGYjoQ==
X-Received: by 2002:a0d:d107:0:b0:561:b4e3:5fc8 with SMTP id t7-20020a0dd107000000b00561b4e35fc8mr9743269ywd.37.1684732331752;
        Sun, 21 May 2023 22:12:11 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o80-20020a0dcc53000000b00559f03541c6sm1814009ywd.132.2023.05.21.22.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:12:11 -0700 (PDT)
Date:   Sun, 21 May 2023 22:12:08 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 18/31] mm/mprotect: delete
 pmd_none_or_clear_bad_unless_trans_huge()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <4a834932-9064-9ed7-3cd1-99466f549486@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
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

change_pmd_range() had special pmd_none_or_clear_bad_unless_trans_huge(),
required to avoid "bad" choices when setting automatic NUMA hinting under
mmap_read_lock(); but most of that is already covered in pte_offset_map()
now.  change_pmd_range() just wants a pmd_none() check before wasting
time on MMU notifiers, then checks on the read-once _pmd value to work
out what's needed for huge cases.  If change_pte_range() returns -EAGAIN
to retry if pte_offset_map_lock() fails, nothing more special is needed.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mprotect.c | 74 ++++++++++++---------------------------------------
 1 file changed, 17 insertions(+), 57 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index c5a13c0f1017..64e1df0af514 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -93,22 +93,9 @@ static long change_pte_range(struct mmu_gather *tlb,
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
-
-	/*
-	 * Can be called with only the mmap_lock for reading by
-	 * prot_numa so we must check the pmd isn't constantly
-	 * changing from under us from pmd_none to pmd_trans_huge
-	 * and/or the other way around.
-	 */
-	if (pmd_trans_unstable(pmd))
-		return 0;
-
-	/*
-	 * The pmd points to a regular pte so the pmd can't change
-	 * from under us even if the mmap_lock is only hold for
-	 * reading.
-	 */
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return -EAGAIN;
 
 	/* Get target node for single threaded private VMAs */
 	if (prot_numa && !(vma->vm_flags & VM_SHARED) &&
@@ -301,26 +288,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-/*
- * Used when setting automatic NUMA hinting protection where it is
- * critical that a numa hinting PMD is not confused with a bad PMD.
- */
-static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
-{
-	pmd_t pmdval = pmdp_get_lockless(pmd);
-
-	if (pmd_none(pmdval))
-		return 1;
-	if (pmd_trans_huge(pmdval))
-		return 0;
-	if (unlikely(pmd_bad(pmdval))) {
-		pmd_clear_bad(pmd);
-		return 1;
-	}
-
-	return 0;
-}
-
 /*
  * Return true if we want to split THPs into PTE mappings in change
  * protection procedure, false otherwise.
@@ -398,7 +365,8 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		long ret;
-
+		pmd_t _pmd;
+again:
 		next = pmd_addr_end(addr, end);
 
 		ret = change_pmd_prepare(vma, pmd, cp_flags);
@@ -406,16 +374,8 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			pages = ret;
 			break;
 		}
-		/*
-		 * Automatic NUMA balancing walks the tables with mmap_lock
-		 * held for read. It's possible a parallel update to occur
-		 * between pmd_trans_huge() and a pmd_none_or_clear_bad()
-		 * check leading to a false positive and clearing.
-		 * Hence, it's necessary to atomically read the PMD value
-		 * for all the checks.
-		 */
-		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
-		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
+
+		if (pmd_none(*pmd))
 			goto next;
 
 		/* invoke the mmu notifier if the pmd is populated */
@@ -426,7 +386,8 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		_pmd = pmdp_get_lockless(pmd);
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
@@ -441,15 +402,10 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 					break;
 				}
 			} else {
-				/*
-				 * change_huge_pmd() does not defer TLB flushes,
-				 * so no need to propagate the tlb argument.
-				 */
-				int nr_ptes = change_huge_pmd(tlb, vma, pmd,
+				ret = change_huge_pmd(tlb, vma, pmd,
 						addr, newprot, cp_flags);
-
-				if (nr_ptes) {
-					if (nr_ptes == HPAGE_PMD_NR) {
+				if (ret) {
+					if (ret == HPAGE_PMD_NR) {
 						pages += HPAGE_PMD_NR;
 						nr_huge_updates++;
 					}
@@ -460,8 +416,12 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		pages += change_pte_range(tlb, vma, pmd, addr, next,
-					  newprot, cp_flags);
+
+		ret = change_pte_range(tlb, vma, pmd, addr, next, newprot,
+				       cp_flags);
+		if (ret < 0)
+			goto again;
+		pages += ret;
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
-- 
2.35.3

