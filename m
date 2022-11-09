Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6891362349A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiKIUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiKIUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:30:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CB0B4B4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9553E61CCC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 20:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BA4C433C1;
        Wed,  9 Nov 2022 20:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668025856;
        bh=9qnPfKu+ea9PpoXLpkszgFs1oCfj0WSOJLlCNmwflk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwJZxzRCX83iGs+iws+YZjXJsPg0sQJi3yu9tC5b/48iMIwFlDbBrhivKre2Xpon0
         4plCoOTe0Z2d74jMZmcOu9hQTyZeD+MztCQC7QMfDBLa5E7RRWm77+esvvw8dWkEa7
         oiSboib4EnilVP+ctGl8S4QC26wBQnwBILQOwAXs=
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/4] mm: mmu_gather: prepare to gather encoded page pointers with flags
Date:   Wed,  9 Nov 2022 12:30:50 -0800
Message-Id: <20221109203051.1835763-3-torvalds@linux-foundation.org>
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

This is purely a preparatory patch that makes all the data structures
ready for encoding flags with the mmu_gather page pointers.

The code currently always sets the flag to zero and doesn't use it yet,
but now it's tracking the type state along.  The next step will be to
actually start using it.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/s390/include/asm/tlb.h |  8 +++++---
 include/asm-generic/tlb.h   |  9 +++++----
 include/linux/swap.h        |  2 +-
 mm/mmu_gather.c             |  8 ++++----
 mm/swap_state.c             | 11 ++++-------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 3a5c8fb590e5..05142226d65d 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -25,7 +25,8 @@
 void __tlb_remove_table(void *_table);
 static inline void tlb_flush(struct mmu_gather *tlb);
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-					  struct page *page, int page_size);
+					  struct encoded_page *page,
+					  int page_size);
 
 #define tlb_flush tlb_flush
 #define pte_free_tlb pte_free_tlb
@@ -42,9 +43,10 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
  * has already been freed, so just do free_page_and_swap_cache.
  */
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-					  struct page *page, int page_size)
+					  struct encoded_page *page,
+					  int page_size)
 {
-	free_page_and_swap_cache(page);
+	free_page_and_swap_cache(encoded_page_ptr(page));
 	return false;
 }
 
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 492dce43236e..e5cd34393372 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -242,7 +242,7 @@ struct mmu_gather_batch {
 	struct mmu_gather_batch	*next;
 	unsigned int		nr;
 	unsigned int		max;
-	struct page		*pages[];
+	struct encoded_page	*encoded_pages[];
 };
 
 #define MAX_GATHER_BATCH	\
@@ -256,7 +256,8 @@ struct mmu_gather_batch {
  */
 #define MAX_GATHER_BATCH_COUNT	(10000UL/MAX_GATHER_BATCH)
 
-extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
+extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
+				   struct encoded_page *page,
 				   int page_size);
 #endif
 
@@ -431,13 +432,13 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
-	if (__tlb_remove_page_size(tlb, page, page_size))
+	if (__tlb_remove_page_size(tlb, encode_page(page, 0), page_size))
 		tlb_flush_mmu(tlb);
 }
 
 static inline bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 {
-	return __tlb_remove_page_size(tlb, page, PAGE_SIZE);
+	return __tlb_remove_page_size(tlb, encode_page(page, 0), PAGE_SIZE);
 }
 
 /* tlb_remove_page
diff --git a/include/linux/swap.h b/include/linux/swap.h
index a18cf4b7c724..40e418e3461b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -470,7 +470,7 @@ static inline unsigned long total_swapcache_pages(void)
 
 extern void free_swap_cache(struct page *page);
 extern void free_page_and_swap_cache(struct page *);
-extern void free_pages_and_swap_cache(struct page **, int);
+extern void free_pages_and_swap_cache(struct encoded_page **, int);
 /* linux/mm/swapfile.c */
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index add4244e5790..f44cc8a5b581 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -48,7 +48,7 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 	struct mmu_gather_batch *batch;
 
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		struct page **pages = batch->pages;
+		struct encoded_page **pages = batch->encoded_pages;
 
 		do {
 			/*
@@ -77,7 +77,7 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
 	tlb->local.next = NULL;
 }
 
-bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct encoded_page *page, int page_size)
 {
 	struct mmu_gather_batch *batch;
 
@@ -92,13 +92,13 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 	 * Add the page and check if we are full. If so
 	 * force a flush.
 	 */
-	batch->pages[batch->nr++] = page;
+	batch->encoded_pages[batch->nr++] = page;
 	if (batch->nr == batch->max) {
 		if (!tlb_next_batch(tlb))
 			return true;
 		batch = tlb->active;
 	}
-	VM_BUG_ON_PAGE(batch->nr > batch->max, page);
+	VM_BUG_ON_PAGE(batch->nr > batch->max, encoded_page_ptr(page));
 
 	return false;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 438d0676c5be..8bf08c313872 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -303,15 +303,12 @@ void free_page_and_swap_cache(struct page *page)
  * Passed an array of pages, drop them all from swapcache and then release
  * them.  They are removed from the LRU and freed if this is their last use.
  */
-void free_pages_and_swap_cache(struct page **pages, int nr)
+void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
 {
-	struct page **pagep = pages;
-	int i;
-
 	lru_add_drain();
-	for (i = 0; i < nr; i++)
-		free_swap_cache(pagep[i]);
-	release_pages(pagep, nr);
+	for (int i = 0; i < nr; i++)
+		free_swap_cache(encoded_page_ptr(pages[i]));
+	release_pages(pages, nr);
 }
 
 static inline bool swap_use_vma_readahead(void)
-- 
2.38.1.284.gfd9468d787

