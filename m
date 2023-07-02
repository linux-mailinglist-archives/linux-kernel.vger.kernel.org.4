Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7446C744C35
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 06:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjGBEc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 00:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBEcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 00:32:55 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D5E7B
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 21:32:53 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c4dd86f5d78so722277276.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 21:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688272372; x=1690864372;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xe3TLuq66vmKQRW9SGz/9upotsvCI1LmaDBtWx+p5E=;
        b=GpDC38QTgtqfZzzYwnrcJmcSIvgJdk1ZwaEv8ci0n7S2I5a30ukFYJ1DS3mr5g8XTd
         tH1u77DcjxTGOEHjCPqsotBXC+52xqSZqGWweLtM7/QldOcKnmK5CVuXHTQDfBIno2jq
         HEZ80ORpLd/MB/9Bqp0atjFwKSrAuhghI1ntAPjccvWLUe7LaebWw3qprpYJa1bIFqcG
         rzWJmXe1vItvGwo7KP3dNgVp4TRsCzrBz1I45xSfI7WW87iMYzFcTzKZHzn2dX0d4+D8
         I6ohe5c0VClf82eiVCoxsyfjyWaHBhEIe0afAlr8re4wd/cO8zQDn13fzQ07Mpr0QyA/
         0Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688272372; x=1690864372;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xe3TLuq66vmKQRW9SGz/9upotsvCI1LmaDBtWx+p5E=;
        b=WIQksuRsAom2p9a0q/2SjQ2q0UW9TUvTWkVYVnRhG+hRH8+66hj+pdLLiazhOZ/bOK
         gsC1wIoFcxtz1OwkiqlmvmOOeG8EtGN4ej5tckXtLxacs7EHu/Q7Ot+h9sCKzxjagTNA
         0VCYxHNdaWwRhPfTplJVohWXP8R20VYa2buzPi2JBND8c+X8c9+x5sYGQ+zYrRHpDNTU
         hRB5ZEoxIQIA/aCpJnGvMHSkpL+nGQqhly+/aj0XWE0Rt5HhKomt1XORXzIkslS+lvFD
         xiQMUrwmr8t+fbbqJpD/s410qsO7HwkS+FPUqNTQy9RT8B3jB9Orezg/6ERiz5UIIn6N
         Zz0A==
X-Gm-Message-State: ABy/qLbMpmc9JpYmzOK6YloI7bP4uX4roxIb4W6XJ76yy0+WzU5ARCwj
        u1/dGmaYLLF4p/DQahbNvFcQ1g==
X-Google-Smtp-Source: APBJJlGl8n+Vflh4Nic7lcmL47faSllrN8Rxws0soLuAss+tixz88El1gH4Rh9D/YEn41GP92GfeYA==
X-Received: by 2002:a25:3d5:0:b0:bc7:7fe4:afbc with SMTP id 204-20020a2503d5000000b00bc77fe4afbcmr12032215ybd.20.1688272372370;
        Sat, 01 Jul 2023 21:32:52 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p134-20020a25748c000000b00c4dba44c1fasm337790ybc.23.2023.07.01.21.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 21:32:51 -0700 (PDT)
Date:   Sat, 1 Jul 2023 21:32:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Zack Rusin <zackr@vmware.com>,
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
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <edaa96f-80c1-1252-acbb-71c4f045b035@google.com>
Message-ID: <7bef5695-fa4a-7215-7e9d-d4a83161c7ab@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com> <20230628211624.531cdc58@thinkpad-T15> <cd7c2851-1440-7220-6c53-16b343b1474@google.com> <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca> <20230629175645.7654d0a8@thinkpad-T15>
 <edaa96f-80c1-1252-acbb-71c4f045b035@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,BODY_ENHANCEMENT2,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023, Hugh Dickins wrote:
> 
> I've grown to dislike the (ab)use of pt_frag_refcount even more, to the
> extent that I've not even tried to verify it; but I think I do get the
> point now, that we need further info than just PPHHAA to know whether
> the page is on the list or not.  But I think that if we move where the
> call_rcu() is done, then the page can stay on or off the list by same
> rules as before (but need to check HH bits along with PP when deciding
> whether to allocate, and whether to list_add_tail() when freeing).

No, not quite the same rules as before: I came to realize that using
list_add_tail() for the HH pages would be liable to put a page on the
list which forever blocked reuse of PP list_add_tail() pages after it
(could be solved by a list_move() somewhere, but we have agreed to
prefer simplicity).

I've dropped the HH bits, I'm using PageActive like we did on powerpc,
I've dropped most of the pte_free_*() helpers, and list_del_init() is
an easier way of dealing with those "is it on the list" questions.
I expect that we shall be close to reaching agreement on...

[PATCH v? 07/12] s390: add pte_free_defer() for pgtables sharing page

Add s390-specific pte_free_defer(), to free table page via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This precedes
the generic version to avoid build breakage from incompatible pgtable_t.

This version is more complicated than others: because s390 fits two 2K
page tables into one 4K page (so page->rcu_head must be shared between
both halves), and already uses page->lru (which page->rcu_head overlays)
to list any free halves; with clever management by page->_refcount bits.

Build upon the existing management, adjusted to follow a new rule: that
a page is never on the free list if pte_free_defer() was used on either
half (marked by PageActive).  And for simplicity, delay calling RCU until
both halves are freed.

Not adding back unallocated fragments to the list in pte_free_defer()
can result in wasting some amount of memory for pagetables, depending
on how long the allocated fragment will stay in use. In practice, this
effect is expected to be insignificant, and not justify a far more
complex approach, which might allow to add the fragments back later
in __tlb_remove_table(), where we might not have a stable mm any more.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/s390/include/asm/pgalloc.h |  4 ++
 arch/s390/mm/pgalloc.c          | 75 +++++++++++++++++++++++++++------
 2 files changed, 67 insertions(+), 12 deletions(-)

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
index 66ab68db9842..fd0c4312da16 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -229,6 +229,15 @@ void page_table_free_pgste(struct page *page)
  * logic described above. Both AA bits are set to 1 to denote a 4KB-pgtable
  * while the PP bits are never used, nor such a page is added to or removed
  * from mm_context_t::pgtable_list.
+ *
+ * pte_free_defer() overrides those rules: it takes the page off pgtable_list,
+ * and prevents both 2K fragments from being reused. pte_free_defer() has to
+ * guarantee that its pgtable cannot be reused before the RCU grace period
+ * has elapsed (which page_table_free_rcu() does not actually guarantee).
+ * But for simplicity, because page->rcu_head overlays page->lru, and because
+ * the RCU callback might not be called before the mm_context_t has been freed,
+ * pte_free_defer() in this implementation prevents both fragments from being
+ * reused, and delays making the call to RCU until both fragments are freed.
  */
 unsigned long *page_table_alloc(struct mm_struct *mm)
 {
@@ -261,7 +270,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 					table += PTRS_PER_PTE;
 				atomic_xor_bits(&page->_refcount,
 							0x01U << (bit + 24));
-				list_del(&page->lru);
+				list_del_init(&page->lru);
 			}
 		}
 		spin_unlock_bh(&mm->context.lock);
@@ -281,6 +290,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	table = (unsigned long *) page_to_virt(page);
 	if (mm_alloc_pgste(mm)) {
 		/* Return 4K page table with PGSTEs */
+		INIT_LIST_HEAD(&page->lru);
 		atomic_xor_bits(&page->_refcount, 0x03U << 24);
 		memset64((u64 *)table, _PAGE_INVALID, PTRS_PER_PTE);
 		memset64((u64 *)table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
@@ -300,7 +310,9 @@ static void page_table_release_check(struct page *page, void *table,
 {
 	char msg[128];
 
-	if (!IS_ENABLED(CONFIG_DEBUG_VM) || !mask)
+	if (!IS_ENABLED(CONFIG_DEBUG_VM))
+		return;
+	if (!mask && list_empty(&page->lru))
 		return;
 	snprintf(msg, sizeof(msg),
 		 "Invalid pgtable %p release half 0x%02x mask 0x%02x",
@@ -308,6 +320,15 @@ static void page_table_release_check(struct page *page, void *table,
 	dump_page(page, msg);
 }
 
+static void pte_free_now(struct rcu_head *head)
+{
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	pgtable_pte_page_dtor(page);
+	__free_page(page);
+}
+
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	unsigned int mask, bit, half;
@@ -325,10 +346,17 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 		 */
 		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 		mask >>= 24;
-		if (mask & 0x03U)
+		if ((mask & 0x03U) && !PageActive(page)) {
+			/*
+			 * Other half is allocated, and neither half has had
+			 * its free deferred: add page to head of list, to make
+			 * this freed half available for immediate reuse.
+			 */
 			list_add(&page->lru, &mm->context.pgtable_list);
-		else
-			list_del(&page->lru);
+		} else {
+			/* If page is on list, now remove it. */
+			list_del_init(&page->lru);
+		}
 		spin_unlock_bh(&mm->context.lock);
 		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
 		mask >>= 24;
@@ -342,8 +370,10 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	}
 
 	page_table_release_check(page, table, half, mask);
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	if (TestClearPageActive(page))
+		call_rcu(&page->rcu_head, pte_free_now);
+	else
+		pte_free_now(&page->rcu_head);
 }
 
 void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
@@ -370,10 +400,18 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 	 */
 	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 	mask >>= 24;
-	if (mask & 0x03U)
+	if ((mask & 0x03U) && !PageActive(page)) {
+		/*
+		 * Other half is allocated, and neither half has had
+		 * its free deferred: add page to end of list, to make
+		 * this freed half available for reuse once its pending
+		 * bit has been cleared by __tlb_remove_table().
+		 */
 		list_add_tail(&page->lru, &mm->context.pgtable_list);
-	else
-		list_del(&page->lru);
+	} else {
+		/* If page is on list, now remove it. */
+		list_del_init(&page->lru);
+	}
 	spin_unlock_bh(&mm->context.lock);
 	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
 	tlb_remove_table(tlb, table);
@@ -403,10 +441,23 @@ void __tlb_remove_table(void *_table)
 	}
 
 	page_table_release_check(page, table, half, mask);
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	if (TestClearPageActive(page))
+		call_rcu(&page->rcu_head, pte_free_now);
+	else
+		pte_free_now(&page->rcu_head);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	SetPageActive(page);
+	page_table_free(mm, (unsigned long *)pgtable);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * Base infrastructure required to generate basic asces, region, segment,
  * and page tables that do not make use of enhanced features like EDAT1.
-- 
2.35.3

