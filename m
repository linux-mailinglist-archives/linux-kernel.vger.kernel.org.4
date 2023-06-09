Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C2B728D15
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbjFIBa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjFIBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:30:55 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35D1716
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:30:53 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565bd368e19so10851917b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274253; x=1688866253;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GAfzbPNj/2rvKRevzngE24N05kydgFSIoMtFyLCrv4=;
        b=gJAMMykaIEU9PkjyCIdSz3ODq0ftmm75epqTVf1DDwNHXYM11vOXndav/A+j1kRFEc
         9zEcP31A1kA13aWMOjns1R75xfAWzNDi1gHKk68ewQgq0whuvZDJ2IOLlB+uSUVd5Hp8
         svpukbwsNHcvaTpeSeeB57vhMGo3aoLUGSbQC4vDY82UJZYh6UFZthAmKEZpoO6CrQsj
         zIurR6IMYJtElj3ek8vexr06I8pOIvm9uDnN6jHks/XrVIB5jV9tJeQ4OkFBFlzOLvfn
         TFupD/LP2R58aC1XHY0D8ruvxKPXB9C8uw3aB2kdOGhPoyncXso5dO85F2PIfWP2s5CT
         /ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274253; x=1688866253;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GAfzbPNj/2rvKRevzngE24N05kydgFSIoMtFyLCrv4=;
        b=UoDHPYELmYDszENOUZtkICjSsXsJj7AMDraPu7kXEMmN8ZUpTEUqoxfDZ1OIj7mzho
         7Qlp+EfCQzSBNp/Zo0q0VM8V2/a0fJ7awSJBb9Gwt4TGhLzaBUqURHbSKs2Ye0pAxS2H
         3dCsPVmYQ77EjuK7BIUCSAA4jFABAHzAfF6bVmto4vQZClWnfxJReZXbYgKlubIMBbL8
         ZsTDSEmQxixAZl9kY/rXKTQRyTH9esFfGu3aa/1jeWiQsARit/BU9T0Oxv2GSB8EyVz+
         Q3rcZWSG98YdtsFiegUTXn0k1XqZYWgk/GGog8uv+IKS2METQMegKwNy/PM0X0EerPe3
         kvYA==
X-Gm-Message-State: AC+VfDys4OLmLXD9ezvX7BIaKGQX0MVeaevgFFqW8Sp9xee65ECAaPXs
        C2DGf55jZxEr4weyT2KojnPHTw==
X-Google-Smtp-Source: ACHHUZ4zYAZPyewfaoixPaut1Ay+u+IP9P5gVJt0aeUL3XpkhLRU1BODxkde89jUMQkygUDst/++Nw==
X-Received: by 2002:a0d:ea8b:0:b0:559:d3a0:4270 with SMTP id t133-20020a0dea8b000000b00559d3a04270mr1322987ywe.34.1686274252865;
        Thu, 08 Jun 2023 18:30:52 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y206-20020a817dd7000000b0055a881abfc3sm277355ywc.135.2023.06.08.18.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:30:52 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:30:48 -0700 (PDT)
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
Subject: [PATCH v2 18/32] mm/mprotect: delete
 pmd_none_or_clear_bad_unless_trans_huge()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <725a42a9-91e9-c868-925-e3a5fd40bb4f@google.com>
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

