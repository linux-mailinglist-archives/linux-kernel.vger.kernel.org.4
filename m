Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516FB621D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKHTlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKHTlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:41:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A722716CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:41:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9F316177A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42FAC433B5;
        Tue,  8 Nov 2022 19:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667936501;
        bh=KtnZVT0YbwzWMG53hT3URF7/oRWr49RGvTuDrC8WUTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Puc8twx3+crexM3+XlAfoAfXJdSqnXG5mTkZTE+eK9SWgd99KLHzzfjSjbwlSR9rG
         vIvyljiUS7yb8ThC0QbXeHTUFZEce/ro/TougawWiPy/s00uFg52Nlje34u8jvC+9q
         toltFhsioCZg7qZXVfUpy2pFWEDN+3iUD9ECCCus=
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/4] mm: mmu_gather: prepare to gather encoded page pointers with flags
Date:   Tue,  8 Nov 2022 11:41:38 -0800
Message-Id: <20221108194139.57604-3-torvalds@linux-foundation.org>
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

This is purely a preparatory patch that makes all the data structures
ready for encoding flags with the mmu_gather page pointers.

The code currently always sets the flag to zero and doesn't use it yet,
but now it's tracking the type state along.  The next step will be to
actually start using it.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/asm-generic/tlb.h |  2 +-
 include/linux/swap.h      |  2 +-
 mm/mmu_gather.c           |  4 ++--
 mm/swap_state.c           | 11 ++++-------
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 492dce43236e..faca23e87278 100644
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
index add4244e5790..57b7850c1b5e 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -48,7 +48,7 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 	struct mmu_gather_batch *batch;
 
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		struct page **pages = batch->pages;
+		struct encoded_page **pages = batch->encoded_pages;
 
 		do {
 			/*
@@ -92,7 +92,7 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 	 * Add the page and check if we are full. If so
 	 * force a flush.
 	 */
-	batch->pages[batch->nr++] = page;
+	batch->encoded_pages[batch->nr++] = encode_page(page, 0);
 	if (batch->nr == batch->max) {
 		if (!tlb_next_batch(tlb))
 			return true;
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

