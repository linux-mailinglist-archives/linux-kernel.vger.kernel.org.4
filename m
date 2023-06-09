Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C93728CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbjFIBHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFIBHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:07:06 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D55E47
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:07:04 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-568ba7abc11so11400877b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686272824; x=1688864824;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYWG+Dmea1iVO9u1anz9ea+vH7b9XYdNpJnPYqrcQ8g=;
        b=F4iPSaqGVauSHCN3PPx1HPCWJrbnjh20XWi+31Rxj6kybI3XEkrDo9g8TlN/DUHnID
         cA24qUKu4G6Vj7NJbRdZASctuqFdhdFDB+bQFh7yqdfrUkggC5zThxCrXeltsHoErZDt
         xA3Doa45fnOu6mBH+w4Zu0i9kibQ9g3niiOe6jmkqXtnnKBsq4Rlqd1i923q7ctcGoK9
         NpGckUH03ViLvNgz5x9NiKAf8htS6SXGATYEGV3wZ9h6z7DQULhRQ42RGKscWpa7yH/X
         UrzgAwS5xf827WDV7tLvd4mt4ZGJ4FS3qwkbBLtNfkKh0VkQABmVM7ywrrTk/wDqi4Mi
         rRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686272824; x=1688864824;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYWG+Dmea1iVO9u1anz9ea+vH7b9XYdNpJnPYqrcQ8g=;
        b=hi+mtgluv+dLiMQ20HBArXgNH8AwbgZXVXkDJUiWPmJK3Z23Dl5DYts2FTFPYBOePj
         mKJWVJird4PgB1/AOv8lUsfmH7qZMIYzM/l8pguUdna1mVHhAfB/sB/8YbWzkCfjNznL
         g+gkN7RRsIxq+JHPOeK+9ojHHoZ7Lq49XZosB2Dv+MhAIV9E4NPa8s0JgwKp0NkZf5Em
         XuDu/BI6gMnvXUCoHtn5KhtO057DN370MrszUr00Espu2Yv6QZ2ijfONEOcBHX4o2HLQ
         K9Jg/M39Sw0NRKmwKQexb+6h7pZ9koHXEaCCgEoCbyTkxvgEsnmHrvdYbWlxkpfKFYUp
         +aNA==
X-Gm-Message-State: AC+VfDxDSR6kjCr9hZtSG/O2D/xbBWZ1fG3KW77AtbI3fewCtDbO5nVJ
        iutW29kw5L0PdRDTe+wrXQbuxw==
X-Google-Smtp-Source: ACHHUZ4e9gtItKHo/uKH6fckN0QfmcYW2cVTmMNzekmPXGojmR2zjeAFUImej/93RTPFo775/xnN5A==
X-Received: by 2002:a81:7b0b:0:b0:561:afca:5b4d with SMTP id w11-20020a817b0b000000b00561afca5b4dmr1387844ywc.3.1686272823636;
        Thu, 08 Jun 2023 18:07:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y4-20020a81a104000000b00566e949fb9esm282673ywg.82.2023.06.08.18.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:07:02 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:06:53 -0700 (PDT)
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
Subject: [PATCH v2 01/32] mm: use pmdp_get_lockless() without surplus
 barrier()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <f35279a9-9ac0-de22-d245-591afbfb4dc@google.com>
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

Use pmdp_get_lockless() in preference to READ_ONCE(*pmdp), to get a more
reliable result with PAE (or READ_ONCE as before without PAE); and remove
the unnecessary extra barrier()s which got left behind in its callers.

HOWEVER: Note the small print in linux/pgtable.h, where it was designed
specifically for fast GUP, and depends on interrupts being disabled for
its full guarantee: most callers which have been added (here and before)
do NOT have interrupts disabled, so there is still some need for caution.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Yu Zhao <yuzhao@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
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

