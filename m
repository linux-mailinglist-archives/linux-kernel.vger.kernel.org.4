Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C998621D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKHTls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKHTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:41:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF0A7057F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:41:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D07F6173F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59062C433D6;
        Tue,  8 Nov 2022 19:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667936502;
        bh=h11BLOABoRmeXTPU3NUF80nlJbZBLsLoS32EJ3aGj64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z07aI4M7Omdci6AhIi1Bee8aSVhAyN6srxOMIGaK70Vzw8ghAoUJW/H/x0TOxTGBp
         Muw8GdFF+7I7cNqqPG3yjFtHAgutHZHWGP3xLI3xlSZ64ODp0E60utlU3igmnX6PXq
         W6BHQUPqSpbe8u0Yqh1lQX6N9+qY7tmM/3I0h6Iw=
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH 4/4] mm: delay page_remove_rmap() until after the TLB has been flushed
Date:   Tue,  8 Nov 2022 11:41:39 -0800
Message-Id: <20221108194139.57604-4-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.38.1.284.gfd9468d787
In-Reply-To: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we remove a page table entry, we are very careful to only free the
page after we have flushed the TLB, because other CPUs could still be
using the page through stale TLB entries until after the flush.

However, we have removed the rmap entry for that page early, which means
that functions like folio_mkclean() would end up not serializing with
the page table lock because the page had already been made invisible to
rmap.

And that is a problem, because while the TLB entry exists, we could end
up with the following situation:

 (a) one CPU could come in and clean it, never seeing our mapping of the
     page

 (b) another CPU could continue to use the stale and dirty TLB entry and
     continue to write to said page

resulting in a page that has been dirtied, but then marked clean again,
all while another CPU might have dirtied it some more.

End result: possibly lost dirty data.

This extends our current TLB gather infrastructure to optionally track a
"should I do a delayed page_remove_rmap() for this page after flushing
the TLB".  It uses the newly introduced 'encoded page pointer' to do
that without having to keep separate data around.

Note, this is complicated by a couple of issues:

 - s390 has its own mmu_gather model that doesn't delay TLB flushing,
   and as a result also does not want the delayed rmap

 - we want to delay the rmap removal, but not past the page table lock

 - we can track an enormous number of pages in our mmu_gather structure,
   with MAX_GATHER_BATCH_COUNT batches of MAX_TABLE_BATCH pages each,
   all set up to be approximately 10k pending pages.

   We do not want to have a huge number of batched pages that we then
   need to check for delayed rmap handling inside the page table lock.

Particularly that last point results in a noteworthy detail, where the
normal page batch gathering is limited once we have delayed rmaps
pending, in such a way that only the last batch (the so-called "active
batch") in the mmu_gather structure can have any delayed entries.

NOTE! While the "possibly lost dirty data" sounds catastrophic, for this
all to happen you need to have a user thread doing either madvise() with
MADV_DONTNEED or a full re-mmap() of the area concurrently with another
thread continuing to use said mapping.

So arguably this is about user space doing crazy things, but from a VM
consistency standpoint it's better if we track the dirty bit properly
even when user space goes off the rails.

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Link: https://lore.kernel.org/all/B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com/
Cc: Will Deacon <will@kernel.org>
Cc: Aneesh Kumar <aneesh.kumar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com> # s390
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/s390/include/asm/tlb.h | 21 +++++++++++++++++++--
 include/asm-generic/tlb.h   | 21 +++++++++++++++++----
 mm/memory.c                 | 23 +++++++++++++++++------
 mm/mmu_gather.c             | 35 +++++++++++++++++++++++++++++++++--
 4 files changed, 86 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 3a5c8fb590e5..e5903ee2f1ca 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -25,7 +25,8 @@
 void __tlb_remove_table(void *_table);
 static inline void tlb_flush(struct mmu_gather *tlb);
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-					  struct page *page, int page_size);
+					  struct page *page, int page_size,
+					  unsigned int flags);
 
 #define tlb_flush tlb_flush
 #define pte_free_tlb pte_free_tlb
@@ -36,13 +37,24 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 #include <asm/tlbflush.h>
 #include <asm-generic/tlb.h>
 
+/*
+ * s390 never needs to delay page_remove_rmap, because
+ * the ptep_get_and_clear_full() will have flushed the
+ * TLB across CPUs
+ */
+static inline bool tlb_delay_rmap(struct mmu_gather *tlb)
+{
+	return false;
+}
+
 /*
  * Release the page cache reference for a pte removed by
  * tlb_ptep_clear_flush. In both flush modes the tlb for a page cache page
  * has already been freed, so just do free_page_and_swap_cache.
  */
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-					  struct page *page, int page_size)
+					  struct page *page, int page_size,
+					  unsigned int flags)
 {
 	free_page_and_swap_cache(page);
 	return false;
@@ -53,6 +65,11 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	__tlb_flush_mm_lazy(tlb->mm);
 }
 
+static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+	/* Nothing to do, s390 does not delay rmaps */
+}
+
 /*
  * pte_free_tlb frees a pte table and clears the CRSTE for the
  * page table from the tlb.
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index faca23e87278..9df513e5ad28 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -257,7 +257,15 @@ struct mmu_gather_batch {
 #define MAX_GATHER_BATCH_COUNT	(10000UL/MAX_GATHER_BATCH)
 
 extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
-				   int page_size);
+				   int page_size, unsigned int flags);
+extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
+
+/*
+ * This both sets 'delayed_rmap', and returns true. It would be an inline
+ * function, except we define it before the 'struct mmu_gather'.
+ */
+#define tlb_delay_rmap(tlb) (((tlb)->delayed_rmap = 1), true)
+
 #endif
 
 /*
@@ -290,6 +298,11 @@ struct mmu_gather {
 	 */
 	unsigned int		freed_tables : 1;
 
+	/*
+	 * Do we have pending delayed rmap removals?
+	 */
+	unsigned int		delayed_rmap : 1;
+
 	/*
 	 * at which levels have we cleared entries?
 	 */
@@ -431,13 +444,13 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
-	if (__tlb_remove_page_size(tlb, page, page_size))
+	if (__tlb_remove_page_size(tlb, page, page_size, 0))
 		tlb_flush_mmu(tlb);
 }
 
-static inline bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+static inline bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page, unsigned int flags)
 {
-	return __tlb_remove_page_size(tlb, page, PAGE_SIZE);
+	return __tlb_remove_page_size(tlb, page, PAGE_SIZE, flags);
 }
 
 /* tlb_remove_page
diff --git a/mm/memory.c b/mm/memory.c
index f88c351aecd4..60a0f44f6e72 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1432,6 +1432,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		if (pte_present(ptent)) {
+			unsigned int delay_rmap;
+
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
@@ -1443,20 +1445,26 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (unlikely(!page))
 				continue;
 
+			delay_rmap = 0;
 			if (!PageAnon(page)) {
 				if (pte_dirty(ptent)) {
-					force_flush = 1;
 					set_page_dirty(page);
+					if (tlb_delay_rmap(tlb)) {
+						delay_rmap = 1;
+						force_flush = 1;
+					}
 				}
 				if (pte_young(ptent) &&
 				    likely(!(vma->vm_flags & VM_SEQ_READ)))
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
-			page_remove_rmap(page, vma, false);
-			if (unlikely(page_mapcount(page) < 0))
-				print_bad_pte(vma, addr, ptent, page);
-			if (unlikely(__tlb_remove_page(tlb, page))) {
+			if (!delay_rmap) {
+				page_remove_rmap(page, vma, false);
+				if (unlikely(page_mapcount(page) < 0))
+					print_bad_pte(vma, addr, ptent, page);
+			}
+			if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
 				force_flush = 1;
 				addr += PAGE_SIZE;
 				break;
@@ -1513,8 +1521,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_leave_lazy_mmu_mode();
 
 	/* Do the actual TLB flush before dropping ptl */
-	if (force_flush)
+	if (force_flush) {
 		tlb_flush_mmu_tlbonly(tlb);
+		if (tlb->delayed_rmap)
+			tlb_flush_rmaps(tlb, vma);
+	}
 	pte_unmap_unlock(start_pte, ptl);
 
 	/*
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 57b7850c1b5e..136f5fad43e3 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -9,6 +9,7 @@
 #include <linux/rcupdate.h>
 #include <linux/smp.h>
 #include <linux/swap.h>
+#include <linux/rmap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -19,6 +20,10 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
 
+	/* No more batching if we have delayed rmaps pending */
+	if (tlb->delayed_rmap)
+		return false;
+
 	batch = tlb->active;
 	if (batch->next) {
 		tlb->active = batch->next;
@@ -43,6 +48,31 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 	return true;
 }
 
+/**
+ * tlb_flush_rmaps - do pending rmap removals after we have flushed the TLB
+ * @tlb: the current mmu_gather
+ *
+ * Note that because of how tlb_next_batch() above works, we will
+ * never start new batches with pending delayed rmaps, so we only
+ * need to walk through the current active batch.
+ */
+void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+	struct mmu_gather_batch *batch;
+
+	batch = tlb->active;
+	for (int i = 0; i < batch->nr; i++) {
+		struct encoded_page *enc = batch->encoded_pages[i];
+
+		if (encoded_page_flags(enc)) {
+			struct page *page = encoded_page_ptr(enc);
+			page_remove_rmap(page, vma, false);
+		}
+	}
+
+	tlb->delayed_rmap = 0;
+}
+
 static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
@@ -77,7 +107,7 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
 	tlb->local.next = NULL;
 }
 
-bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size, unsigned int flags)
 {
 	struct mmu_gather_batch *batch;
 
@@ -92,7 +122,7 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 	 * Add the page and check if we are full. If so
 	 * force a flush.
 	 */
-	batch->encoded_pages[batch->nr++] = encode_page(page, 0);
+	batch->encoded_pages[batch->nr++] = encode_page(page, flags);
 	if (batch->nr == batch->max) {
 		if (!tlb_next_batch(tlb))
 			return true;
@@ -286,6 +316,7 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	tlb->active     = &tlb->local;
 	tlb->batch_count = 0;
 #endif
+	tlb->delayed_rmap = 0;
 
 	tlb_table_init(tlb);
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
-- 
2.38.1.284.gfd9468d787

