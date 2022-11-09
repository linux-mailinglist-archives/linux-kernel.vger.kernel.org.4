Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD862349B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKIUbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiKIUbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:31:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72C61DA5E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:31:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D012B82004
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 20:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A720C433D6;
        Wed,  9 Nov 2022 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668025857;
        bh=DygGn50YiKaYslenqOtWfgKtrp8wBO+gru+y3RImfHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ySqgloro4f7St7rg/4K9JaWDGH7EOeNkCuvbjH4JdIdaIRJEnUcBpyRM3YFWo+irM
         ++y2qAF5OTta6iis+zsLtX6WcDEzyPgNkuw3WUffwdkgEOeP5UMWgI33yc8KWAP3Im
         0WsEo4j21ZVYtUzF9cA3A6yiPiM/fLuoUgX5XJY8=
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
Date:   Wed,  9 Nov 2022 12:30:51 -0800
Message-Id: <20221109203051.1835763-4-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.38.1.284.gfd9468d787
In-Reply-To: <20221109203051.1835763-1-torvalds@linux-foundation.org>
References: <20221109203051.1835763-1-torvalds@linux-foundation.org>
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

 - we want to delay the rmap removal, but not past the page table lock,
   because that simplifies the memcg accounting

 - only SMP configurations want to delay TLB flushing, since on UP
   there are obviously no remote TLBs to worry about, and the page
   table lock means there are no preemption issues either

 - s390 has its own mmu_gather model that doesn't delay TLB flushing,
   and as a result also does not want the delayed rmap. As such, we can
   treat S390 like the UP case and use a common fallback for the "no
   delays" case.

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

Reported-and-tested-by: Nadav Amit <nadav.amit@gmail.com>
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
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com> # s390
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/s390/include/asm/tlb.h |  3 +++
 include/asm-generic/tlb.h   | 31 +++++++++++++++++++++++++++++--
 mm/memory.c                 | 23 +++++++++++++++++------
 mm/mmu_gather.c             | 31 +++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 05142226d65d..b91f4a9b044c 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -41,6 +41,9 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
  * Release the page cache reference for a pte removed by
  * tlb_ptep_clear_flush. In both flush modes the tlb for a page cache page
  * has already been freed, so just do free_page_and_swap_cache.
+ *
+ * s390 doesn't delay rmap removal, so there is nothing encoded in
+ * the page pointer.
  */
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 					  struct encoded_page *page,
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index e5cd34393372..154c774d6307 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -259,6 +259,28 @@ struct mmu_gather_batch {
 extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
 				   struct encoded_page *page,
 				   int page_size);
+
+#ifdef CONFIG_SMP
+/*
+ * This both sets 'delayed_rmap', and returns true. It would be an inline
+ * function, except we define it before the 'struct mmu_gather'.
+ */
+#define tlb_delay_rmap(tlb) (((tlb)->delayed_rmap = 1), true)
+extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
+#endif
+
+#endif
+
+/*
+ * We have a no-op version of the rmap removal that doesn't
+ * delay anything. That is used on S390, which flushes remote
+ * TLBs synchronously, and on UP, which doesn't have any
+ * remote TLBs to flush and is not preemptible due to this
+ * all happening under the page table lock.
+ */
+#ifndef tlb_delay_rmap
+#define tlb_delay_rmap(tlb) (false)
+static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
 #endif
 
 /*
@@ -291,6 +313,11 @@ struct mmu_gather {
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
@@ -436,9 +463,9 @@ static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 		tlb_flush_mmu(tlb);
 }
 
-static inline bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+static __always_inline bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page, unsigned int flags)
 {
-	return __tlb_remove_page_size(tlb, encode_page(page, 0), PAGE_SIZE);
+	return __tlb_remove_page_size(tlb, encode_page(page, flags), PAGE_SIZE);
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
index f44cc8a5b581..38592fba3826 100644
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
@@ -286,6 +316,7 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	tlb->active     = &tlb->local;
 	tlb->batch_count = 0;
 #endif
+	tlb->delayed_rmap = 0;
 
 	tlb_table_init(tlb);
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
-- 
2.38.1.284.gfd9468d787

