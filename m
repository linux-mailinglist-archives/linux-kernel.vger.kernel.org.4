Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73D70B435
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjEVEtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjEVEtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:49:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CCDE0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:49:49 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-babb985f9c8so3605725276.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684730989; x=1687322989;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPDEzBR49R6dDlw5Ac4B9CyjOOF4I7QDHwXmKNSpbHY=;
        b=jjqeukn26805nHVLC5nBwMgzM4/Jmq9nujdcXAsHlTTa0MF+m2phch6zZaIztXO6Dz
         fns/H0GYdXEsi480XLUtkShE3/SCYxhfBiTmi4a8mWlPCmy6IGq/VUwbfbhJIIoyZO7w
         TE3oj47MvYeZYWdEl1lce5yvexgSm//EOtHJ9GZeQN0nTG0k7iqmz6ivXvrQT6/vTILo
         r9ZBlahSUgKAO7KElSgVquCd8eytGkW3ohhN44RmnSrwXqOowlkCJVfPWiZAiA+rPaIg
         Hemws7mTvH+9rnEvzhcxuWU8gWDXFk8QvfENWQsXDu8/h+u8uj+2BFe5jHCcgno98BaD
         /dgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684730989; x=1687322989;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPDEzBR49R6dDlw5Ac4B9CyjOOF4I7QDHwXmKNSpbHY=;
        b=LW3beiwCABOqDmgARfC59I7VCuKQQP34QlzvfNdrA5CWh+XFCBMdIM6b5j+hrqAnyI
         kwCTgXEMA6aty1KBh+yryO2OwD42BQdfEjmAb3r1R2POJ5CJD0Uas3yRjM6wdZOz6YNz
         Zavp6CVjX2M6/zKljzN2Mm3cns6FhF6jJ7889FGLCn0OUGnUnB4MnKbwEbXGHTLtjJag
         DVGf+tcxPrF88GI9XyS5kPW7+5UwxaxTtmiC5wirsQX62aMuGRzhpoqWIPFxD+cvRfP3
         xCECxgJQtQp6O2+F+HppQmvpsAuQt6E87YIk6el/ZU81G5sTWK/UGr6el7Hbo1y1icKM
         Vo0A==
X-Gm-Message-State: AC+VfDwnXMjDML0c1vymHSaTtPGpTZH0bT95+6stWEjHTIK9ooYIy8TI
        rPE+Xoh0A5yW8nwIv+Yflrx00A==
X-Google-Smtp-Source: ACHHUZ5ZcQphQAL7jjAMB8ykWMW22wF1U8iyf27N7XhXamyXhJP6vomdj/dc7m8k3wKxzVaO0p10GA==
X-Received: by 2002:a25:d242:0:b0:b9a:66b7:673e with SMTP id j63-20020a25d242000000b00b9a66b7673emr11337327ybg.43.1684730988606;
        Sun, 21 May 2023 21:49:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b206-20020a0dd9d7000000b00560f6704ee1sm1809847ywe.26.2023.05.21.21.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:49:48 -0700 (PDT)
Date:   Sun, 21 May 2023 21:49:45 -0700 (PDT)
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
Subject: [PATCH 01/31] mm: use pmdp_get_lockless() without surplus
 barrier()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <34467cca-58b6-3e64-1ee7-e3dc43257a@google.com>
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

Use pmdp_get_lockless() in preference to READ_ONCE(*pmdp), to get a more
reliable result with PAE (or READ_ONCE as before without PAE); and remove
the unnecessary extra barrier()s which got left behind in its callers.

HOWEVER: Note the small print in linux/pgtable.h, where it was designed
specifically for fast GUP, and depends on interrupts being disabled for
its full guarantee: most callers which have been added (here and before)
do NOT have interrupts disabled, so there is still some need for caution.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/userfaultfd.c        | 10 +---------
 include/linux/pgtable.h | 17 -----------------
 mm/gup.c                |  6 +-----
 mm/hmm.c                |  2 +-
 mm/khugepaged.c         |  5 -----
 mm/ksm.c                |  3 +--
 mm/memory.c             | 14 ++------------
 mm/mprotect.c           |  5 -----
 mm/page_vma_mapped.c    |  2 +-
 9 files changed, 7 insertions(+), 57 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..f7a0817b1ec0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -349,15 +349,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	if (!pud_present(*pud))
 		goto out;
 	pmd = pmd_offset(pud, address);
-	/*
-	 * READ_ONCE must function as a barrier with narrower scope
-	 * and it must be equivalent to:
-	 *	_pmd = *pmd; barrier();
-	 *
-	 * This is to deal with the instability (as in
-	 * pmd_trans_unstable) of the pmd.
-	 */
-	_pmd = READ_ONCE(*pmd);
+	_pmd = pmdp_get_lockless(pmd);
 	if (pmd_none(_pmd))
 		goto out;
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c5a51481bbb9..8ec27fe69dc8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1344,23 +1344,6 @@ static inline int pud_trans_unstable(pud_t *pud)
 static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
 {
 	pmd_t pmdval = pmdp_get_lockless(pmd);
-	/*
-	 * The barrier will stabilize the pmdval in a register or on
-	 * the stack so that it will stop changing under the code.
-	 *
-	 * When CONFIG_TRANSPARENT_HUGEPAGE=y on x86 32bit PAE,
-	 * pmdp_get_lockless is allowed to return a not atomic pmdval
-	 * (for example pointing to an hugepage that has never been
-	 * mapped in the pmd). The below checks will only care about
-	 * the low part of the pmd with 32bit PAE x86 anyway, with the
-	 * exception of pmd_none(). So the important thing is that if
-	 * the low part of the pmd is found null, the high part will
-	 * be also null or the pmd_none() check below would be
-	 * confused.
-	 */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	barrier();
-#endif
 	/*
 	 * !pmd_present() checks for pmd migration entries
 	 *
diff --git a/mm/gup.c b/mm/gup.c
index bbe416236593..3bd5d3854c51 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -653,11 +653,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	pmd = pmd_offset(pudp, address);
-	/*
-	 * The READ_ONCE() will stabilize the pmdval in a register or
-	 * on the stack so that it will stop changing under the code.
-	 */
-	pmdval = READ_ONCE(*pmd);
+	pmdval = pmdp_get_lockless(pmd);
 	if (pmd_none(pmdval))
 		return no_page_table(vma, flags);
 	if (!pmd_present(pmdval))
diff --git a/mm/hmm.c b/mm/hmm.c
index 6a151c09de5e..e23043345615 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -332,7 +332,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	pmd_t pmd;
 
 again:
-	pmd = READ_ONCE(*pmdp);
+	pmd = pmdp_get_lockless(pmdp);
 	if (pmd_none(pmd))
 		return hmm_vma_walk_hole(start, end, -1, walk);
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b9d39d65b73..732f9ac393fc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -961,11 +961,6 @@ static int find_pmd_or_thp_or_none(struct mm_struct *mm,
 		return SCAN_PMD_NULL;
 
 	pmde = pmdp_get_lockless(*pmd);
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	/* See comments in pmd_none_or_trans_huge_or_clear_bad() */
-	barrier();
-#endif
 	if (pmd_none(pmde))
 		return SCAN_PMD_NONE;
 	if (!pmd_present(pmde))
diff --git a/mm/ksm.c b/mm/ksm.c
index 0156bded3a66..df2aa281d49d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1194,8 +1194,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	 * without holding anon_vma lock for write.  So when looking for a
 	 * genuine pmde (in which to find pte), test present and !THP together.
 	 */
-	pmde = *pmd;
-	barrier();
+	pmde = pmdp_get_lockless(pmd);
 	if (!pmd_present(pmde) || pmd_trans_huge(pmde))
 		goto out;
 
diff --git a/mm/memory.c b/mm/memory.c
index f69fbc251198..2eb54c0d5d3c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4925,18 +4925,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * So now it's safe to run pte_offset_map().
 		 */
 		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
-		vmf->orig_pte = *vmf->pte;
+		vmf->orig_pte = ptep_get_lockless(vmf->pte);
 		vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;
 
-		/*
-		 * some architectures can have larger ptes than wordsize,
-		 * e.g.ppc44x-defconfig has CONFIG_PTE_64BIT=y and
-		 * CONFIG_32BIT=y, so READ_ONCE cannot guarantee atomic
-		 * accesses.  The code below just needs a consistent view
-		 * for the ifs and we later double check anyway with the
-		 * ptl lock held. So here a barrier will do.
-		 */
-		barrier();
 		if (pte_none(vmf->orig_pte)) {
 			pte_unmap(vmf->pte);
 			vmf->pte = NULL;
@@ -5060,9 +5051,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
 	} else {
-		vmf.orig_pmd = *vmf.pmd;
+		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
 
-		barrier();
 		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
 			VM_BUG_ON(thp_migration_supported() &&
 					  !is_pmd_migration_entry(vmf.orig_pmd));
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 92d3d3ca390a..c5a13c0f1017 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -309,11 +309,6 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 {
 	pmd_t pmdval = pmdp_get_lockless(pmd);
 
-	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	barrier();
-#endif
-
 	if (pmd_none(pmdval))
 		return 1;
 	if (pmd_trans_huge(pmdval))
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 4e448cfbc6ef..64aff6718bdb 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -210,7 +210,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 * compiler and used as a stale value after we've observed a
 		 * subsequent update.
 		 */
-		pmde = READ_ONCE(*pvmw->pmd);
+		pmde = pmdp_get_lockless(pvmw->pmd);
 
 		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
 		    (pmd_present(pmde) && pmd_devmap(pmde))) {
-- 
2.35.3

