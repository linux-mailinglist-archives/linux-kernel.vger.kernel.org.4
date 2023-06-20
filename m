Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B119C736557
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjFTHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjFTHwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:52:11 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558071BCD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:51:43 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bc40d4145feso4394966276.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687247485; x=1689839485;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jUseASXhwGaNM4F6CkFzwvn2Dk1xhlzNLQjSeyjV8Y=;
        b=yMZZZ71UME7oK4yGdGKbgAGJwHWifsRBUE1ty8JHuL5GZamUEZ4PagH7+CA+ACRuXJ
         sVYkjhp9M9lk4smKqdKCXO0MTjpP1EkTbYT8MDDYBlSiF5OQTuGuvrMV46BD/K8KMf/8
         VOuKBB/cMCFRHgkyZqVnyK9Ko9EAea3S5WqfjuYhhZ6hhTM9p4DwQdnfw6MNXWL2d4va
         sxwz/XIyotH6XV5mKGrc5rIq2+19pPbxhawaqiUWsN1AbxSzM+rTQINZrSJH0bvVIXEy
         SnNN73ZM1CD0WeufHS2IZ+FCcyXO+JAYLl5u8OigLfNh6mFqqNG2vS4i+tU2O9Fk9zM/
         R+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247485; x=1689839485;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jUseASXhwGaNM4F6CkFzwvn2Dk1xhlzNLQjSeyjV8Y=;
        b=izqGHFCtim8TpUppIjMZsXQKezGCohNK4ClZ+mLa0146JTIs2c1YTaj4S3OCbItFEx
         jLVN2UO22nZPToEu37XJgfdQ5N9zPZf85fRrfowiqDsVl8FRDeGYO/5sHZydc1PKwMcC
         0IHfgDzRLXUAZR38ueMRYlWFSVma9ql74wz3Cyob9L0BorZT67eIq/lhgL7RHwmcG/74
         2Q5Z2n69ys5f3siWq/N3lKNXuZJRsCRGR853wWzLdcowb2bdh1uTuOjcMwAhF27RikB6
         ZikHeU3K+6nNtlh0ctweOaYLx58OB0zD3fbWyVW0YwMPqNLt4G/XvSGCklVoIQjs54Ik
         E6ZA==
X-Gm-Message-State: AC+VfDwUcJCkhNAA37hihMae5CL4iqZxnhVV99oKP74EzTbv0qnZYAPt
        WxTRVqob2MJH3hcAmncl/pdaJw==
X-Google-Smtp-Source: ACHHUZ5V40k+FwqrX2L16LirpEKemNO0AwOCEL4uHyPeS6tT3McwesGGFGOm1IWTgWqHC9fJk3bo5g==
X-Received: by 2002:a25:b296:0:b0:ba8:7122:2917 with SMTP id k22-20020a25b296000000b00ba871222917mr8863514ybj.0.1687247484917;
        Tue, 20 Jun 2023 00:51:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o195-20020a2541cc000000b00bb21aeddeffsm258356yba.18.2023.06.20.00.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:51:24 -0700 (PDT)
Date:   Tue, 20 Jun 2023 00:51:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
Message-ID: <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
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

Add s390-specific pte_free_defer(), to call pte_free() via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This precedes
the generic version to avoid build breakage from incompatible pgtable_t.

This version is more complicated than others: because s390 fits two 2K
page tables into one 4K page (so page->rcu_head must be shared between
both halves), and already uses page->lru (which page->rcu_head overlays)
to list any free halves; with clever management by page->_refcount bits.

Build upon the existing management, adjusted to follow a new rule: that
a page is not linked to mm_context_t::pgtable_list while either half is
pending free, by either tlb_remove_table() or pte_free_defer(); but is
afterwards either relinked to the list (if other half is allocated), or
freed (if other half is free): by __tlb_remove_table() in both cases.

This rule ensures that page->lru is no longer in use while page->rcu_head
may be needed for use by pte_free_defer().  And a fortuitous byproduct of
following this rule is that page_table_free() no longer needs its curious
two-step manipulation of _refcount - read commit c2c224932fd0 ("s390/mm:
fix 2KB pgtable release race") for what to think of there.  But it does
not solve the problem that two halves may need rcu_head at the same time.

For that, add HHead bits between s390's AAllocated and PPending bits in
the upper byte of page->_refcount: then the second pte_free_defer() can
see that rcu_head is already in use, and the RCU callee pte_free_half()
can see that it needs to make a further call_rcu() for that other half.

page_table_alloc() set the page->pt_mm field, so __tlb_remove_table()
knows where to link the freed half while its other half is allocated.
But linking to the list needs mm->context.lock: and although AA bit set
guarantees that pt_mm must still be valid, it does not guarantee that mm
is still valid an instant later: so acquiring mm->context.lock would not
be safe.  For now, use a static global mm_pgtable_list_lock instead:
then a soon-to-follow commit will split it per-mm as before (probably by
using a SLAB_TYPESAFE_BY_RCU structure for the list head and its lock);
and update the commentary on the pgtable_list.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/s390/include/asm/pgalloc.h |   4 +
 arch/s390/mm/pgalloc.c          | 205 +++++++++++++++++++++++---------
 include/linux/mm_types.h        |   2 +-
 3 files changed, 154 insertions(+), 57 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 17eb618f1348..89a9d5ef94f8 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -143,6 +143,10 @@ static inline void pmd_populate(struct mm_struct *mm,
 #define pte_free_kernel(mm, pte) page_table_free(mm, (unsigned long *) pte)
 #define pte_free(mm, pte) page_table_free(mm, (unsigned long *) pte)
 
+/* arch use pte_free_defer() implementation in arch/s390/mm/pgalloc.c */
+#define pte_free_defer pte_free_defer
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 void vmem_map_init(void);
 void *vmem_crst_alloc(unsigned long val);
 pte_t *vmem_pte_alloc(void);
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 66ab68db9842..11983a3ff95a 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -159,6 +159,11 @@ void page_table_free_pgste(struct page *page)
 
 #endif /* CONFIG_PGSTE */
 
+/*
+ * Temporarily use a global spinlock instead of mm->context.lock.
+ * This will be replaced by a per-mm spinlock in a followup commit.
+ */
+static DEFINE_SPINLOCK(mm_pgtable_list_lock);
 /*
  * A 2KB-pgtable is either upper or lower half of a normal page.
  * The second half of the page may be unused or used as another
@@ -172,7 +177,7 @@ void page_table_free_pgste(struct page *page)
  * When a parent page gets fully allocated it contains 2KB-pgtables in both
  * upper and lower halves and is removed from mm_context_t::pgtable_list.
  *
- * When 2KB-pgtable is freed from to fully allocated parent page that
+ * When 2KB-pgtable is freed from the fully allocated parent page that
  * page turns partially allocated and added to mm_context_t::pgtable_list.
  *
  * If 2KB-pgtable is freed from the partially allocated parent page that
@@ -182,16 +187,24 @@ void page_table_free_pgste(struct page *page)
  * As follows from the above, no unallocated or fully allocated parent
  * pages are contained in mm_context_t::pgtable_list.
  *
+ * NOTE NOTE NOTE: The commentary above and below has not yet been updated:
+ * the new rule is that a page is not linked to mm_context_t::pgtable_list
+ * while either half is pending free by any method; but afterwards is
+ * either relinked to it, or freed, by __tlb_remove_table().  This allows
+ * pte_free_defer() to use the page->rcu_head (which overlays page->lru).
+ *
  * The upper byte (bits 24-31) of the parent page _refcount is used
  * for tracking contained 2KB-pgtables and has the following format:
  *
- *   PP  AA
- * 01234567    upper byte (bits 24-31) of struct page::_refcount
- *   ||  ||
- *   ||  |+--- upper 2KB-pgtable is allocated
- *   ||  +---- lower 2KB-pgtable is allocated
- *   |+------- upper 2KB-pgtable is pending for removal
- *   +-------- lower 2KB-pgtable is pending for removal
+ *   PPHHAA
+ * 76543210    upper byte (bits 24-31) of struct page::_refcount
+ *   ||||||
+ *   |||||+--- lower 2KB-pgtable is allocated
+ *   ||||+---- upper 2KB-pgtable is allocated
+ *   |||+----- lower 2KB-pgtable is pending free by page->rcu_head
+ *   ||+------ upper 2KB-pgtable is pending free by page->rcu_head
+ *   |+------- lower 2KB-pgtable is pending free by any method
+ *   +-------- upper 2KB-pgtable is pending free by any method
  *
  * (See commit 620b4e903179 ("s390: use _refcount for pgtables") on why
  * using _refcount is possible).
@@ -200,7 +213,7 @@ void page_table_free_pgste(struct page *page)
  * The parent page is either:
  *   - added to mm_context_t::pgtable_list in case the second half of the
  *     parent page is still unallocated;
- *   - removed from mm_context_t::pgtable_list in case both hales of the
+ *   - removed from mm_context_t::pgtable_list in case both halves of the
  *     parent page are allocated;
  * These operations are protected with mm_context_t::lock.
  *
@@ -239,32 +252,22 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	/* Try to get a fragment of a 4K page as a 2K page table */
 	if (!mm_alloc_pgste(mm)) {
 		table = NULL;
-		spin_lock_bh(&mm->context.lock);
+		spin_lock_bh(&mm_pgtable_list_lock);
 		if (!list_empty(&mm->context.pgtable_list)) {
 			page = list_first_entry(&mm->context.pgtable_list,
 						struct page, lru);
 			mask = atomic_read(&page->_refcount) >> 24;
-			/*
-			 * The pending removal bits must also be checked.
-			 * Failure to do so might lead to an impossible
-			 * value of (i.e 0x13 or 0x23) written to _refcount.
-			 * Such values violate the assumption that pending and
-			 * allocation bits are mutually exclusive, and the rest
-			 * of the code unrails as result. That could lead to
-			 * a whole bunch of races and corruptions.
-			 */
-			mask = (mask | (mask >> 4)) & 0x03U;
-			if (mask != 0x03U) {
-				table = (unsigned long *) page_to_virt(page);
-				bit = mask & 1;		/* =1 -> second 2K */
-				if (bit)
-					table += PTRS_PER_PTE;
-				atomic_xor_bits(&page->_refcount,
-							0x01U << (bit + 24));
-				list_del(&page->lru);
-			}
+			/* Cannot be on this list if either half pending free */
+			WARN_ON_ONCE(mask & ~0x03U);
+			/* One or other half must be available, but not both */
+			WARN_ON_ONCE(mask == 0x00U || mask == 0x03U);
+			table = (unsigned long *)page_to_virt(page);
+			bit = mask & 0x01U;	/* =1 -> second 2K available */
+			table += bit * PTRS_PER_PTE;
+			atomic_xor_bits(&page->_refcount, 0x01U << (bit + 24));
+			list_del(&page->lru);
 		}
-		spin_unlock_bh(&mm->context.lock);
+		spin_unlock_bh(&mm_pgtable_list_lock);
 		if (table)
 			return table;
 	}
@@ -278,6 +281,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	}
 	arch_set_page_dat(page, 0);
 	/* Initialize page table */
+	page->pt_mm = mm;
 	table = (unsigned long *) page_to_virt(page);
 	if (mm_alloc_pgste(mm)) {
 		/* Return 4K page table with PGSTEs */
@@ -288,14 +292,14 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 		/* Return the first 2K fragment of the page */
 		atomic_xor_bits(&page->_refcount, 0x01U << 24);
 		memset64((u64 *)table, _PAGE_INVALID, 2 * PTRS_PER_PTE);
-		spin_lock_bh(&mm->context.lock);
+		spin_lock_bh(&mm_pgtable_list_lock);
 		list_add(&page->lru, &mm->context.pgtable_list);
-		spin_unlock_bh(&mm->context.lock);
+		spin_unlock_bh(&mm_pgtable_list_lock);
 	}
 	return table;
 }
 
-static void page_table_release_check(struct page *page, void *table,
+static void page_table_release_check(struct page *page, unsigned long *table,
 				     unsigned int half, unsigned int mask)
 {
 	char msg[128];
@@ -317,21 +321,18 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	if (!mm_alloc_pgste(mm)) {
 		/* Free 2K page table fragment of a 4K page */
 		bit = ((unsigned long) table & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t));
-		spin_lock_bh(&mm->context.lock);
+		spin_lock_bh(&mm_pgtable_list_lock);
 		/*
-		 * Mark the page for delayed release. The actual release
-		 * will happen outside of the critical section from this
-		 * function or from __tlb_remove_table()
+		 * Mark the page for release. The actual release will happen
+		 * below from this function, or later from __tlb_remove_table().
 		 */
-		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
+		mask = atomic_xor_bits(&page->_refcount, 0x01U << (bit + 24));
 		mask >>= 24;
-		if (mask & 0x03U)
+		if (mask & 0x03U)		/* other half is allocated */
 			list_add(&page->lru, &mm->context.pgtable_list);
-		else
+		else if (!(mask & 0x30U))	/* other half not pending */
 			list_del(&page->lru);
-		spin_unlock_bh(&mm->context.lock);
-		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
-		mask >>= 24;
+		spin_unlock_bh(&mm_pgtable_list_lock);
 		if (mask != 0x00U)
 			return;
 		half = 0x01U << bit;
@@ -362,19 +363,17 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 		return;
 	}
 	bit = ((unsigned long) table & ~PAGE_MASK) / (PTRS_PER_PTE*sizeof(pte_t));
-	spin_lock_bh(&mm->context.lock);
+	spin_lock_bh(&mm_pgtable_list_lock);
 	/*
-	 * Mark the page for delayed release. The actual release will happen
-	 * outside of the critical section from __tlb_remove_table() or from
-	 * page_table_free()
+	 * Mark the page for delayed release.
+	 * The actual release will happen later, from __tlb_remove_table().
 	 */
 	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 	mask >>= 24;
-	if (mask & 0x03U)
-		list_add_tail(&page->lru, &mm->context.pgtable_list);
-	else
+	/* Other half not allocated? Other half not already pending free? */
+	if ((mask & 0x03U) == 0x00U && (mask & 0x30U) != 0x30U)
 		list_del(&page->lru);
-	spin_unlock_bh(&mm->context.lock);
+	spin_unlock_bh(&mm_pgtable_list_lock);
 	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
 	tlb_remove_table(tlb, table);
 }
@@ -382,17 +381,40 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 void __tlb_remove_table(void *_table)
 {
 	unsigned int mask = (unsigned long) _table & 0x03U, half = mask;
-	void *table = (void *)((unsigned long) _table ^ mask);
+	unsigned long *table = (unsigned long *)((unsigned long) _table ^ mask);
 	struct page *page = virt_to_page(table);
 
 	switch (half) {
 	case 0x00U:	/* pmd, pud, or p4d */
-		free_pages((unsigned long)table, CRST_ALLOC_ORDER);
+		__free_pages(page, CRST_ALLOC_ORDER);
 		return;
 	case 0x01U:	/* lower 2K of a 4K page table */
-	case 0x02U:	/* higher 2K of a 4K page table */
-		mask = atomic_xor_bits(&page->_refcount, mask << (4 + 24));
-		mask >>= 24;
+	case 0x02U:	/* upper 2K of a 4K page table */
+		/*
+		 * If the other half is marked as allocated, page->pt_mm must
+		 * still be valid, page->rcu_head no longer in use so page->lru
+		 * good for use, so now make the freed half available for reuse.
+		 * But be wary of races with that other half being freed.
+		 */
+		if (atomic_read(&page->_refcount) & (0x03U << 24)) {
+			struct mm_struct *mm = page->pt_mm;
+			/*
+			 * It is safe to use page->pt_mm when the other half
+			 * is seen allocated while holding pgtable_list lock;
+			 * but how will it be safe to acquire that spinlock?
+			 * Global mm_pgtable_list_lock is safe and easy for
+			 * now, then a followup commit will split it per-mm.
+			 */
+			spin_lock_bh(&mm_pgtable_list_lock);
+			mask = atomic_xor_bits(&page->_refcount, mask << 28);
+			mask >>= 24;
+			if (mask & 0x03U)
+				list_add(&page->lru, &mm->context.pgtable_list);
+			spin_unlock_bh(&mm_pgtable_list_lock);
+		} else {
+			mask = atomic_xor_bits(&page->_refcount, mask << 28);
+			mask >>= 24;
+		}
 		if (mask != 0x00U)
 			return;
 		break;
@@ -407,6 +429,77 @@ void __tlb_remove_table(void *_table)
 	__free_page(page);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void pte_free_now0(struct rcu_head *head);
+static void pte_free_now1(struct rcu_head *head);
+
+static void pte_free_pgste(struct rcu_head *head)
+{
+	unsigned long *table;
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	table = (unsigned long *)page_to_virt(page);
+	table = (unsigned long *)((unsigned long)table | 0x03U);
+	__tlb_remove_table(table);
+}
+
+static void pte_free_half(struct rcu_head *head, unsigned int bit)
+{
+	unsigned long *table;
+	struct page *page;
+	unsigned int mask;
+
+	page = container_of(head, struct page, rcu_head);
+	mask = atomic_xor_bits(&page->_refcount, 0x04U << (bit + 24));
+
+	table = (unsigned long *)page_to_virt(page);
+	table += bit * PTRS_PER_PTE;
+	table = (unsigned long *)((unsigned long)table | (0x01U << bit));
+	__tlb_remove_table(table);
+
+	/* If pte_free_defer() of the other half came in, queue it now */
+	if (mask & 0x0CU)
+		call_rcu(&page->rcu_head, bit ? pte_free_now0 : pte_free_now1);
+}
+
+static void pte_free_now0(struct rcu_head *head)
+{
+	pte_free_half(head, 0);
+}
+
+static void pte_free_now1(struct rcu_head *head)
+{
+	pte_free_half(head, 1);
+}
+
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	unsigned int bit, mask;
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	if (mm_alloc_pgste(mm)) {
+		call_rcu(&page->rcu_head, pte_free_pgste);
+		return;
+	}
+	bit = ((unsigned long)pgtable & ~PAGE_MASK) /
+			(PTRS_PER_PTE * sizeof(pte_t));
+
+	spin_lock_bh(&mm_pgtable_list_lock);
+	mask = atomic_xor_bits(&page->_refcount, 0x15U << (bit + 24));
+	mask >>= 24;
+	/* Other half not allocated? Other half not already pending free? */
+	if ((mask & 0x03U) == 0x00U && (mask & 0x30U) != 0x30U)
+		list_del(&page->lru);
+	spin_unlock_bh(&mm_pgtable_list_lock);
+
+	/* Do not relink on rcu_head if other half already linked on rcu_head */
+	if ((mask & 0x0CU) != 0x0CU)
+		call_rcu(&page->rcu_head, bit ? pte_free_now1 : pte_free_now0);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * Base infrastructure required to generate basic asces, region, segment,
  * and page tables that do not make use of enhanced features like EDAT1.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..1667a1bdb8a8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -146,7 +146,7 @@ struct page {
 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
-				struct mm_struct *pt_mm; /* x86 pgds only */
+				struct mm_struct *pt_mm; /* x86 pgd, s390 */
 				atomic_t pt_frag_refcount; /* powerpc */
 			};
 #if ALLOC_SPLIT_PTLOCKS
-- 
2.35.3

