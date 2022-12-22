Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299D76546E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiLVTs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLVTst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:48:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3939D1838D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:48:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y16so2700065wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLkOKeT4uIbBG6ss89Hd1tlt6NrDYEFm7lc6id39hK0=;
        b=qaVTeJBr0AB0s3zFjlbBmH6X/y6e0XSR+iRAd0acuOKDc0gLhdkkp4b0e6i0+x6SVZ
         bTVRoj29yr3mjHORwcggnN8TK8ejdSwcJb/PMMRNz1VUf0Bk8jC4xTqW9Sl6TbHEOq7q
         +mag8pB/j9H7bNZgiBJjgYCe4IkYcuMfpiaedTzbN3o0MxeA1HAqc0/PmSiDVsF+pthU
         OV4fY9Ildjb3u0DXp7/W7QKRrOKexJaGdnn+D/DwQz8VncM77pYGYjtlnQVezc8OxQgk
         XMao8+aSfs7jz7UC871WOzc+CQXp+pl/Na/F5uk+t815ejTt3kCbHCPvtXXg1n4b8qtr
         18RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLkOKeT4uIbBG6ss89Hd1tlt6NrDYEFm7lc6id39hK0=;
        b=mlyhoAes4dp7z8zd8wW47ZPir7lekhCkTqYTd3JjJw3brSi4d1hUTgHYKWdWRPxfwF
         AnmrOfFLxiS9QakeFAXA3w9XTW/f+2IHj7XW7df5aPabXRe4SYwCuiBHdFZDcbrObUMo
         MzfTLoAPu/2dyjPBYv2sycJil/2NDeXoNMibcb2c0Y+QfiomXj7POcsDRnXo5+xiCNVN
         B7NcEytCAadHlpwnOJp9GS2X1FRGWqAOLyDMBouRYg6RsT685TCnmq6A3vFSV2W4Cyt5
         WRCXlEuPA1qACv0ddKv/cNv7cLAxwRDu++V1MfoTwUmvW1rw1CnzegNZgPBMhE7WRI37
         KhKQ==
X-Gm-Message-State: AFqh2kqyEMpw8KyBIH6Wm8rAYRty6zujOt37+2zAWOI62XHDZi0tjH4z
        wUTYMz3+kqGJOg66CbTFVGPnrbxMziNENw==
X-Google-Smtp-Source: AMrXdXuGSfcyX4JBZQVgEBq/oTLCneSYDqqUl8X2gg7SriuUfyRTav7lultTztWm9vrEl6sdsCDt8g==
X-Received: by 2002:a5d:4568:0:b0:242:803:537f with SMTP id a8-20020a5d4568000000b002420803537fmr4497291wrc.18.1671738522730;
        Thu, 22 Dec 2022 11:48:42 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id i1-20020adfb641000000b002425787c5easm1349317wre.96.2022.12.22.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:48:41 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 2/4] mm: mlock: use folios and a folio batch internally
Date:   Thu, 22 Dec 2022 19:48:31 +0000
Message-Id: <fd11472e8bf1a88c109de9252a634891c4af7958.1671738120.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671738120.git.lstoakes@gmail.com>
References: <cover.1671738120.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings mlock in line with the folio batches declared in mm/swap.c and
makes the code more consistent across the two.

The existing mechanism for identifying which operation each folio in the
batch is undergoing is maintained, i.e. using the lower 2 bits of the
struct folio address (previously struct page address). This should continue
to function correctly as folios remain at least system word-aligned.

All invoctions of mlock() pass either a non-compound page or the head of a
THP-compound page and no tail pages need updating so this functionality
works with struct folios being used internally rather than struct pages.

In this patch the external interface is kept identical to before in order
to maintain separation between patches in the series, using a rather
awkward conversion from struct page to struct folio in relevant functions.

However, this maintenance of the existing interface is intended to be
temporary - the next patch in the series will update the interfaces to
accept folios directly.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mlock.c | 238 +++++++++++++++++++++++++++--------------------------
 1 file changed, 120 insertions(+), 118 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..e9ba47fe67ed 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -28,12 +28,12 @@
 
 #include "internal.h"
 
-struct mlock_pvec {
+struct mlock_fbatch {
 	local_lock_t lock;
-	struct pagevec vec;
+	struct folio_batch fbatch;
 };
 
-static DEFINE_PER_CPU(struct mlock_pvec, mlock_pvec) = {
+static DEFINE_PER_CPU(struct mlock_fbatch, mlock_fbatch) = {
 	.lock = INIT_LOCAL_LOCK(lock),
 };
 
@@ -48,192 +48,192 @@ bool can_do_mlock(void)
 EXPORT_SYMBOL(can_do_mlock);
 
 /*
- * Mlocked pages are marked with PageMlocked() flag for efficient testing
+ * Mlocked folios are marked with the PG_mlocked flag for efficient testing
  * in vmscan and, possibly, the fault path; and to support semi-accurate
  * statistics.
  *
- * An mlocked page [PageMlocked(page)] is unevictable.  As such, it will
- * be placed on the LRU "unevictable" list, rather than the [in]active lists.
- * The unevictable list is an LRU sibling list to the [in]active lists.
- * PageUnevictable is set to indicate the unevictable state.
+ * An mlocked folio [folio_test_mlocked(folio)] is unevictable.  As such, it
+ * will be ostensibly placed on the LRU "unevictable" list (actually no such
+ * list exists), rather than the [in]active lists. PG_unevictable is set to
+ * indicate the unevictable state.
  */
 
-static struct lruvec *__mlock_page(struct page *page, struct lruvec *lruvec)
+static struct lruvec *__mlock_folio(struct folio *folio, struct lruvec *lruvec)
 {
 	/* There is nothing more we can do while it's off LRU */
-	if (!TestClearPageLRU(page))
+	if (!folio_test_clear_lru(folio))
 		return lruvec;
 
-	lruvec = folio_lruvec_relock_irq(page_folio(page), lruvec);
+	lruvec = folio_lruvec_relock_irq(folio, lruvec);
 
-	if (unlikely(page_evictable(page))) {
+	if (unlikely(folio_evictable(folio))) {
 		/*
-		 * This is a little surprising, but quite possible:
-		 * PageMlocked must have got cleared already by another CPU.
-		 * Could this page be on the Unevictable LRU?  I'm not sure,
-		 * but move it now if so.
+		 * This is a little surprising, but quite possible: PG_mlocked
+		 * must have got cleared already by another CPU.  Could this
+		 * folio be unevictable?  I'm not sure, but move it now if so.
 		 */
-		if (PageUnevictable(page)) {
-			del_page_from_lru_list(page, lruvec);
-			ClearPageUnevictable(page);
-			add_page_to_lru_list(page, lruvec);
+		if (folio_test_unevictable(folio)) {
+			lruvec_del_folio(lruvec, folio);
+			folio_clear_unevictable(folio);
+			lruvec_add_folio(lruvec, folio);
+
 			__count_vm_events(UNEVICTABLE_PGRESCUED,
-					  thp_nr_pages(page));
+					  folio_nr_pages(folio));
 		}
 		goto out;
 	}
 
-	if (PageUnevictable(page)) {
-		if (PageMlocked(page))
-			page->mlock_count++;
+	if (folio_test_unevictable(folio)) {
+		if (folio_test_mlocked(folio))
+			folio->mlock_count++;
 		goto out;
 	}
 
-	del_page_from_lru_list(page, lruvec);
-	ClearPageActive(page);
-	SetPageUnevictable(page);
-	page->mlock_count = !!PageMlocked(page);
-	add_page_to_lru_list(page, lruvec);
-	__count_vm_events(UNEVICTABLE_PGCULLED, thp_nr_pages(page));
+	lruvec_del_folio(lruvec, folio);
+	folio_clear_active(folio);
+	folio_set_unevictable(folio);
+	folio->mlock_count = !!folio_test_mlocked(folio);
+	lruvec_add_folio(lruvec, folio);
+	__count_vm_events(UNEVICTABLE_PGCULLED, folio_nr_pages(folio));
 out:
-	SetPageLRU(page);
+	folio_set_lru(folio);
 	return lruvec;
 }
 
-static struct lruvec *__mlock_new_page(struct page *page, struct lruvec *lruvec)
+static struct lruvec *__mlock_new_folio(struct folio *folio, struct lruvec *lruvec)
 {
-	VM_BUG_ON_PAGE(PageLRU(page), page);
+	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
-	lruvec = folio_lruvec_relock_irq(page_folio(page), lruvec);
+	lruvec = folio_lruvec_relock_irq(folio, lruvec);
 
 	/* As above, this is a little surprising, but possible */
-	if (unlikely(page_evictable(page)))
+	if (unlikely(folio_evictable(folio)))
 		goto out;
 
-	SetPageUnevictable(page);
-	page->mlock_count = !!PageMlocked(page);
-	__count_vm_events(UNEVICTABLE_PGCULLED, thp_nr_pages(page));
+	folio_set_unevictable(folio);
+	folio->mlock_count = !!folio_test_mlocked(folio);
+	__count_vm_events(UNEVICTABLE_PGCULLED, folio_nr_pages(folio));
 out:
-	add_page_to_lru_list(page, lruvec);
-	SetPageLRU(page);
+	lruvec_add_folio(lruvec, folio);
+	folio_set_lru(folio);
 	return lruvec;
 }
 
-static struct lruvec *__munlock_page(struct page *page, struct lruvec *lruvec)
+static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec)
 {
-	int nr_pages = thp_nr_pages(page);
+	int nr_pages = folio_nr_pages(folio);
 	bool isolated = false;
 
-	if (!TestClearPageLRU(page))
+	if (!folio_test_clear_lru(folio))
 		goto munlock;
 
 	isolated = true;
-	lruvec = folio_lruvec_relock_irq(page_folio(page), lruvec);
+	lruvec = folio_lruvec_relock_irq(folio, lruvec);
 
-	if (PageUnevictable(page)) {
+	if (folio_test_unevictable(folio)) {
 		/* Then mlock_count is maintained, but might undercount */
-		if (page->mlock_count)
-			page->mlock_count--;
-		if (page->mlock_count)
+		if (folio->mlock_count)
+			folio->mlock_count--;
+		if (folio->mlock_count)
 			goto out;
 	}
 	/* else assume that was the last mlock: reclaim will fix it if not */
 
 munlock:
-	if (TestClearPageMlocked(page)) {
-		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
-		if (isolated || !PageUnevictable(page))
+	if (folio_test_clear_mlocked(folio)) {
+		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
+		if (isolated || !folio_test_unevictable(folio))
 			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
 		else
 			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
 	}
 
-	/* page_evictable() has to be checked *after* clearing Mlocked */
-	if (isolated && PageUnevictable(page) && page_evictable(page)) {
-		del_page_from_lru_list(page, lruvec);
-		ClearPageUnevictable(page);
-		add_page_to_lru_list(page, lruvec);
+	/* folio_evictable() has to be checked *after* clearing Mlocked */
+	if (isolated && folio_test_unevictable(folio) && folio_evictable(folio)) {
+		lruvec_del_folio(lruvec, folio);
+		folio_clear_unevictable(folio);
+		lruvec_add_folio(lruvec, folio);
 		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	}
 out:
 	if (isolated)
-		SetPageLRU(page);
+		folio_set_lru(folio);
 	return lruvec;
 }
 
 /*
- * Flags held in the low bits of a struct page pointer on the mlock_pvec.
+ * Flags held in the low bits of a struct folio pointer on the mlock_fbatch.
  */
 #define LRU_PAGE 0x1
 #define NEW_PAGE 0x2
-static inline struct page *mlock_lru(struct page *page)
+static inline struct folio *mlock_lru(struct folio *folio)
 {
-	return (struct page *)((unsigned long)page + LRU_PAGE);
+	return (struct folio *)((unsigned long)folio + LRU_PAGE);
 }
 
-static inline struct page *mlock_new(struct page *page)
+static inline struct folio *mlock_new(struct folio *folio)
 {
-	return (struct page *)((unsigned long)page + NEW_PAGE);
+	return (struct folio *)((unsigned long)folio + NEW_PAGE);
 }
 
 /*
- * mlock_pagevec() is derived from pagevec_lru_move_fn():
- * perhaps that can make use of such page pointer flags in future,
- * but for now just keep it for mlock.  We could use three separate
- * pagevecs instead, but one feels better (munlocking a full pagevec
- * does not need to drain mlocking pagevecs first).
+ * mlock_folio_batch() is derived from folio_batch_move_lru(): perhaps that can
+ * make use of such page pointer flags in future, but for now just keep it for
+ * mlock.  We could use three separate folio batches instead, but one feels
+ * better (munlocking a full folio batch does not need to drain mlocking folio
+ * batches first).
  */
-static void mlock_pagevec(struct pagevec *pvec)
+static void mlock_folio_batch(struct folio_batch *fbatch)
 {
 	struct lruvec *lruvec = NULL;
 	unsigned long mlock;
-	struct page *page;
+	struct folio *folio;
 	int i;
 
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		page = pvec->pages[i];
-		mlock = (unsigned long)page & (LRU_PAGE | NEW_PAGE);
-		page = (struct page *)((unsigned long)page - mlock);
-		pvec->pages[i] = page;
+	for (i = 0; i < folio_batch_count(fbatch); i++) {
+		folio = fbatch->folios[i];
+		mlock = (unsigned long)folio & (LRU_PAGE | NEW_PAGE);
+		folio = (struct folio *)((unsigned long)folio - mlock);
+		fbatch->folios[i] = folio;
 
 		if (mlock & LRU_PAGE)
-			lruvec = __mlock_page(page, lruvec);
+			lruvec = __mlock_folio(folio, lruvec);
 		else if (mlock & NEW_PAGE)
-			lruvec = __mlock_new_page(page, lruvec);
+			lruvec = __mlock_new_folio(folio, lruvec);
 		else
-			lruvec = __munlock_page(page, lruvec);
+			lruvec = __munlock_folio(folio, lruvec);
 	}
 
 	if (lruvec)
 		unlock_page_lruvec_irq(lruvec);
-	release_pages(pvec->pages, pvec->nr);
-	pagevec_reinit(pvec);
+	release_pages(fbatch->folios, fbatch->nr);
+	folio_batch_reinit(fbatch);
 }
 
 void mlock_page_drain_local(void)
 {
-	struct pagevec *pvec;
+	struct folio_batch *fbatch;
 
-	local_lock(&mlock_pvec.lock);
-	pvec = this_cpu_ptr(&mlock_pvec.vec);
-	if (pagevec_count(pvec))
-		mlock_pagevec(pvec);
-	local_unlock(&mlock_pvec.lock);
+	local_lock(&mlock_fbatch.lock);
+	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
+	if (folio_batch_count(fbatch))
+		mlock_folio_batch(fbatch);
+	local_unlock(&mlock_fbatch.lock);
 }
 
 void mlock_page_drain_remote(int cpu)
 {
-	struct pagevec *pvec;
+	struct folio_batch *fbatch;
 
 	WARN_ON_ONCE(cpu_online(cpu));
-	pvec = &per_cpu(mlock_pvec.vec, cpu);
-	if (pagevec_count(pvec))
-		mlock_pagevec(pvec);
+	fbatch = &per_cpu(mlock_fbatch.fbatch, cpu);
+	if (folio_batch_count(fbatch))
+		mlock_folio_batch(fbatch);
 }
 
 bool need_mlock_page_drain(int cpu)
 {
-	return pagevec_count(&per_cpu(mlock_pvec.vec, cpu));
+	return folio_batch_count(&per_cpu(mlock_fbatch.fbatch, cpu));
 }
 
 /**
@@ -242,10 +242,10 @@ bool need_mlock_page_drain(int cpu)
  */
 void mlock_folio(struct folio *folio)
 {
-	struct pagevec *pvec;
+	struct folio_batch *fbatch;
 
-	local_lock(&mlock_pvec.lock);
-	pvec = this_cpu_ptr(&mlock_pvec.vec);
+	local_lock(&mlock_fbatch.lock);
+	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
 
 	if (!folio_test_set_mlocked(folio)) {
 		int nr_pages = folio_nr_pages(folio);
@@ -255,10 +255,10 @@ void mlock_folio(struct folio *folio)
 	}
 
 	folio_get(folio);
-	if (!pagevec_add(pvec, mlock_lru(&folio->page)) ||
+	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
 	    folio_test_large(folio) || lru_cache_disabled())
-		mlock_pagevec(pvec);
-	local_unlock(&mlock_pvec.lock);
+		mlock_folio_batch(fbatch);
+	local_unlock(&mlock_fbatch.lock);
 }
 
 /**
@@ -267,20 +267,22 @@ void mlock_folio(struct folio *folio)
  */
 void mlock_new_page(struct page *page)
 {
-	struct pagevec *pvec;
-	int nr_pages = thp_nr_pages(page);
+	struct folio_batch *fbatch;
+	struct folio *folio = page_folio(page);
+	int nr_pages = folio_nr_pages(folio);
 
-	local_lock(&mlock_pvec.lock);
-	pvec = this_cpu_ptr(&mlock_pvec.vec);
-	SetPageMlocked(page);
-	mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
+	local_lock(&mlock_fbatch.lock);
+	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
+	folio_set_mlocked(folio);
+
+	zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
 	__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 
-	get_page(page);
-	if (!pagevec_add(pvec, mlock_new(page)) ||
-	    PageHead(page) || lru_cache_disabled())
-		mlock_pagevec(pvec);
-	local_unlock(&mlock_pvec.lock);
+	folio_get(folio);
+	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
+	    folio_test_large(folio) || lru_cache_disabled())
+		mlock_folio_batch(fbatch);
+	local_unlock(&mlock_fbatch.lock);
 }
 
 /**
@@ -289,20 +291,20 @@ void mlock_new_page(struct page *page)
  */
 void munlock_page(struct page *page)
 {
-	struct pagevec *pvec;
+	struct folio_batch *fbatch;
+	struct folio *folio = page_folio(page);
 
-	local_lock(&mlock_pvec.lock);
-	pvec = this_cpu_ptr(&mlock_pvec.vec);
+	local_lock(&mlock_fbatch.lock);
+	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
 	/*
-	 * TestClearPageMlocked(page) must be left to __munlock_page(),
-	 * which will check whether the page is multiply mlocked.
+	 * folio_test_clear_mlocked(folio) must be left to __munlock_folio(),
+	 * which will check whether the folio is multiply mlocked.
 	 */
-
-	get_page(page);
-	if (!pagevec_add(pvec, page) ||
-	    PageHead(page) || lru_cache_disabled())
-		mlock_pagevec(pvec);
-	local_unlock(&mlock_pvec.lock);
+	folio_get(folio);
+	if (!folio_batch_add(fbatch, folio) ||
+	    folio_test_large(folio) || lru_cache_disabled())
+		mlock_folio_batch(fbatch);
+	local_unlock(&mlock_fbatch.lock);
 }
 
 static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
-- 
2.39.0

