Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC1E73452B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 08:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjFRG5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 02:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFRG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 02:57:51 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43534170D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:57:48 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b5035b777aso9836735ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687071468; x=1689663468;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oanGJOi49vWQXpa4IjH+jDiLL++ZEmTeHQBHHmuT7VA=;
        b=rH0WngdQ9qGwOTu5WrjlK1rnzw05zNL66bEcgUgP3iNz4EUwU+eCnXuO9WbWh7zHrw
         uyKNYmYd1KVIuhtK+FNqLglXeQplda4K7X/H3P4fdi4IBTXt7UUZjGDx5qkt4PYlJlVX
         QQV+Ja4OJrZZPV1NZVDMwlFpNQVFU4QTlU7xBd4Ln25EM3zLX/cIrtJT19SBisW1f49j
         dWo7CLm2vOUnhnDJjNquR3dJ8P/hsC4LicLALz0+95GS9wOJGTFMfIMePDIBO1jV2Wr1
         a2k0lCROHwVNnJ3aWz2hMbfbR1UlTBISh7jWF7GPPux317ZRN0iJ1IXyMIJ1gBcvRdzR
         g0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687071468; x=1689663468;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oanGJOi49vWQXpa4IjH+jDiLL++ZEmTeHQBHHmuT7VA=;
        b=C/975wnfC7OBcG8SQKvS4OurAuDvMNrlHIfPCtoDIhCv7PjPloFiLL+dFBVxNrWrBk
         mGwLA7GGg+RPePLYh5fa0+CbYqA+MpPfjL+hdLrvVQfIUTh/2q3tgrEBApUSXbMYetvh
         l1gwEWnC06568RzSy651yP6w2gSj9S6rqkD0sA7b3mW6sp6ClsKh6lZLfQU6mVvwPPS+
         qcnc51FRDuKuh7pAmQLM9kTyjQKgOx8/I6MvudyvSubvC4jV9FbTyJHBh1Uvd4ks00Zr
         vFWlXTmB99IzoCxTCOIM0P/+pT64tTfZnL4MdIdG2eZi62ZEr0UxmFqscgMvVYvjihjK
         or0A==
X-Gm-Message-State: AC+VfDzQOTSsuxppoG1yckkXQPkPTSoke6tidAslpwWe4Ecrt1VUZeeb
        toISqe6FCo5ofxncJHUPTVQUv5mfq5LU5mSy
X-Google-Smtp-Source: ACHHUZ7zI80tZWV5iOBCFxt/C3skgJDGur2XXYSwYbOumwZHh2yV2/ujoz5PHR4er5XS5dl1vtUHZQGNl8svUw+t
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:481:b0:1b3:f6e2:d156 with SMTP
 id jj1-20020a170903048100b001b3f6e2d156mr1040951plb.3.1687071467571; Sat, 17
 Jun 2023 23:57:47 -0700 (PDT)
Date:   Sun, 18 Jun 2023 06:57:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230618065744.1363948-1-yosryahmed@google.com>
Subject: [RFC PATCH 1/5] mm/mlock: rework mlock_count to use _mapcount for
 order-0 folios
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 07ca76067308 ("mm/munlock: maintain page->mlock_count while
unevictable") introduced mlock_count to keep track of how many times a
folio was mlocked to avoid having to walk the rmap during munlock() to
find out whether or not the folio is mlocked() by a different mapping.

page->mlock_count currently overlays page->lru for unevictable
mlocked folios. A side effect of this is that we lose the mlock_count
every time we isolate a folio. We have to re-initialize the mlock_count
every time we realize we notice that it's gone, and the initialization
is different in different places. Furthermore, we lose the unevictable
LRU (it became imaginary). While we never currently scan this LRU, it is
useful to have ~all user folios charged to a memcg in the LRUs for
future work.

Rework the mlock_count scheme. For order-0 pages, piggyback the
mlock_count with the mapcount for mlocked folios only. For mlocked
folios, we leave the 20 lower bits for the mapcount, and use the 11 next
bits for the mlock_count (we leave the highermost bit as the counter is
signed). We do not allow the mlock_count to overflow, we cap it at
2^11 - 1 (2047 mlocks). It is fine to underestimate the mlock_count, we
might end up clearing PG_mlocked early, but that's fine. Reclaim will
fix it for us.

The max mapcount allowed for mlocked order-0 pages is 2^20-1, a little
bit over a million. In the rare event that this is not enough, the
mapcount will become incorrect (underestimated) -- but we never allow it
to fall to 0 or 1, as these can have special meanings (unmapped or not
shared). Once the mapcount falls below 2^20-1 again it becomes correct.
For what it's worth, most code paths checking the mapcount either do not
apply to mlocked order-0 folios (MADV_FREE, MADV_COLD, reclaim, ..),
just compare the mapcount to 1 (which we make sure doesn't happen by
mistake), or compare the mapcount to the refcount to estimate if there
extra refs on the page (in which case we will mistakenly report extra
refs).

For higher order folios, we add a new atomic counter, _mlock_count, to
the second struct page, and do not need to handle the above complexity.
The complexity described above is hidden within mm/mlock.c, a new helper
folio_mlocked_mapcount() is introduced to handle read the mapcount of an
mlocked order-0 folio. The mlock_count is only modified within
mm/mlock.c, so this is already hidden from the rest of mm.

We increment the mlock_count when PG_mlocked is set (in
mlock_folio/mlock_new_folio), before the batched mlock operation. On the
other hand, we decrement the mlock_count in the batched munlock
operation when PG_mlocked is cleared. This correctly follows the pattern
of setting / clearing PG_mlocked, which we couldn't do before due to the
need to hold the lruvec lock when modifying mlock_count -- we don't need
this anymore.

The inc/dec/initialize logic is also simpler now, no need to check if
the mlock_count is maintained or not, it is always maintained now. No
need to re-initialize every time we add an isolated folio to the
unevictable LRU, or re-initialzie every time we find that it was cleared
during mlock/munlock. Furthermore, we get to update the mlock_count even
if we fail to isolate the folio, which we couldn't do when mlock_count
overlayed page->lru.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/mm.h       |  23 ++++++--
 include/linux/mm_types.h |  24 +-------
 mm/huge_memory.c         |   4 +-
 mm/mlock.c               | 121 ++++++++++++++++++++++++++++++++-------
 mm/swap.c                |   8 ---
 5 files changed, 122 insertions(+), 58 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..3994580772b3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1049,6 +1049,7 @@ unsigned long vmalloc_to_pfn(const void *addr);
 #ifdef CONFIG_MMU
 extern bool is_vmalloc_addr(const void *x);
 extern int is_vmalloc_or_module_addr(const void *x);
+extern int folio_mlocked_mapcount(struct folio *folio);
 #else
 static inline bool is_vmalloc_addr(const void *x)
 {
@@ -1058,6 +1059,10 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 {
 	return 0;
 }
+static inline int folio_mlocked_mapcount(struct folio *folio)
+{
+	return 0;
+}
 #endif
 
 /*
@@ -1100,6 +1105,8 @@ static inline int page_mapcount(struct page *page)
 
 	if (unlikely(PageCompound(page)))
 		mapcount += folio_entire_mapcount(page_folio(page));
+	else if (unlikely(PageMlocked(page)))
+		mapcount = folio_mlocked_mapcount(page_folio(page));
 
 	return mapcount;
 }
@@ -1119,16 +1126,20 @@ int folio_total_mapcount(struct folio *folio);
  */
 static inline int folio_mapcount(struct folio *folio)
 {
-	if (likely(!folio_test_large(folio)))
-		return atomic_read(&folio->_mapcount) + 1;
-	return folio_total_mapcount(folio);
+	if (unlikely(folio_test_large(folio)))
+		return folio_total_mapcount(folio);
+	if (unlikely(folio_test_mlocked(folio)))
+		return folio_mlocked_mapcount(folio);
+	return atomic_read(&folio->_mapcount) + 1;
 }
 
 static inline int total_mapcount(struct page *page)
 {
-	if (likely(!PageCompound(page)))
-		return atomic_read(&page->_mapcount) + 1;
-	return folio_total_mapcount(page_folio(page));
+	if (unlikely(PageCompound(page)))
+		return folio_total_mapcount(page_folio(page));
+	if (unlikely(PageMlocked(page)))
+		return folio_mlocked_mapcount(page_folio(page));
+	return atomic_read(&page->_mapcount) + 1;
 }
 
 static inline bool folio_large_is_mapped(struct folio *folio)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..8c8d524fb263 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -89,15 +89,6 @@ struct page {
 			 */
 			union {
 				struct list_head lru;
-
-				/* Or, for the Unevictable "LRU list" slot */
-				struct {
-					/* Always even, to negate PageTail */
-					void *__filler;
-					/* Count page's or folio's mlocks */
-					unsigned int mlock_count;
-				};
-
 				/* Or, free page */
 				struct list_head buddy_list;
 				struct list_head pcp_list;
@@ -266,7 +257,6 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
  * @lru: Least Recently Used list; tracks how recently this folio was used.
- * @mlock_count: Number of times this folio has been pinned by mlock().
  * @mapping: The file this page belongs to, or refers to the anon_vma for
  *    anonymous memory.
  * @index: Offset within the file, in units of pages.  For anonymous memory,
@@ -283,6 +273,7 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
  * @_nr_pages_mapped: Do not use directly, call folio_mapcount().
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
+ * @_mlock_count: Do not use directly, used exclusively in mm/mlock.c.
  * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
  * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
@@ -304,17 +295,7 @@ struct folio {
 		struct {
 	/* public: */
 			unsigned long flags;
-			union {
-				struct list_head lru;
-	/* private: avoid cluttering the output */
-				struct {
-					void *__filler;
-	/* public: */
-					unsigned int mlock_count;
-	/* private: */
-				};
-	/* public: */
-			};
+			struct list_head lru;
 			struct address_space *mapping;
 			pgoff_t index;
 			void *private;
@@ -337,6 +318,7 @@ struct folio {
 			atomic_t _entire_mapcount;
 			atomic_t _nr_pages_mapped;
 			atomic_t _pincount;
+			atomic_t _mlock_count;
 #ifdef CONFIG_64BIT
 			unsigned int _folio_nr_pages;
 #endif
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 624671aaa60d..0e5b58ca603f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2407,9 +2407,7 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
 	} else {
 		/* head is still on lru (and we have it frozen) */
 		VM_WARN_ON(!PageLRU(head));
-		if (PageUnevictable(tail))
-			tail->mlock_count = 0;
-		else
+		if (!PageUnevictable(tail))
 			list_add_tail(&tail->lru, &head->lru);
 		SetPageLRU(tail);
 	}
diff --git a/mm/mlock.c b/mm/mlock.c
index 40b43f8740df..5c5462627391 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -47,6 +47,98 @@ bool can_do_mlock(void)
 }
 EXPORT_SYMBOL(can_do_mlock);
 
+/*
+ * Keep track of the number of times an order-0 folio was mlock()'d by adding
+ * MLOCK_COUNT_BIAS to folio->_mapcount for each mlock operation.
+ * We leave the lower 20 bits for the mapcount, and we leave the higher most bit
+ * untouched as the counter is signed. This  means that we can count up to
+ * 2047 mlock()'s before overflowing. We do not allow overflowing to avoid
+ * making the mapcount negative. Instead, we cap the mlock_count at
+ * (INT_MAX >> MLOCK_COUNT_SHIFT). This means that the number of mlock()'s may
+ * be underestimated, but this is fine. Reclaim will fix it for us.
+ *
+ * For large folios, we have a dedicated _mlock_count field and don't need to
+ * worry about this.
+ *
+ * When reading the mapcount of an order-0 folio , if the folio is mlock()'d,
+ * we only look at the first 20 bits (MLOCK_MAPCOUNT_MASK). For the rare case
+ * where the number of mappings >= MLOCK_COUNT_BIAS:
+ * (1) The mapcount will be incorrect (underestimated). It will be correct again
+ * once the number of mappings falls below MLOCK_COUNT_BIAS.
+ * (2) munlock() can misinterpret the large number of mappings as an mlock_count
+ * and leave PG_mlocked set.
+ */
+#define MLOCK_COUNT_SHIFT 20
+#define MLOCK_COUNT_BIAS (1U << MLOCK_COUNT_SHIFT)
+#define MLOCK_MAPCOUNT_MASK (MLOCK_COUNT_BIAS - 1U)
+#define MLOCK_COUNT_MAX (INT_MAX >> MLOCK_COUNT_SHIFT)
+
+int folio_mlocked_mapcount(struct folio *folio)
+{
+	int mapcount, mlock_count;
+
+	VM_BUG_ON(!folio_test_mlocked(folio) || folio_test_large(folio));
+	/* always add 1 to folio->_mapcount when parsing it */
+	mapcount = atomic_read(&folio->_mapcount) + 1;
+	mlock_count = mapcount >> MLOCK_COUNT_SHIFT;
+	mapcount &= MLOCK_MAPCOUNT_MASK;
+
+	/*
+	 * If the mapcount overflows beyond the lower 20 bits, we will see
+	 * elevated mlock_count (at least 2), and extremely underestimated
+	 * mapcount (potentially 0 or 1). Make sure we at least return a value
+	 * higher than 1 (a mapcount of 1 usually signifies exclusive mapping).
+	 */
+	if (mlock_count > mapcount)
+		return mlock_count;
+	return mapcount;
+}
+
+static void folio_mlock_count_inc(struct folio *folio)
+{
+	int old, new, mlock_count;
+
+	if (folio_test_large(folio)) {
+		atomic_inc(&folio->_mlock_count);
+		return;
+	}
+
+	/*
+	 * When using the upper bits of _mapcount, make sure we do not overflow
+	 * into the sign bit. If we underestimate, reclaim will fix it.
+	 */
+	old = atomic_read(&folio->_mapcount);
+	do {
+		/* always add 1 to folio->_mapcount when parsing it */
+		mlock_count = (old + 1) >> MLOCK_COUNT_SHIFT;
+		if (mlock_count == MLOCK_COUNT_MAX)
+			return;
+		new = old + MLOCK_COUNT_BIAS;
+	} while (!atomic_try_cmpxchg(&folio->_mapcount, &old, new));
+}
+
+static int folio_mlock_count_dec(struct folio *folio)
+{
+	int old, new, mlock_count;
+
+	if (folio_test_large(folio))
+		return atomic_dec_return(&folio->_mlock_count);
+
+	/*
+	 * When using the upper bit of _mapcount, we may have underestimated the
+	 * mlock count before. Do not underflow.
+	 */
+	old = atomic_read(&folio->_mapcount);
+	do {
+		/* always add 1 to folio->_mapcount when parsing it */
+		mlock_count = (old + 1) >> MLOCK_COUNT_SHIFT;
+		if (mlock_count == 0)
+			return 0;
+		new = old - MLOCK_COUNT_BIAS;
+	} while (!atomic_try_cmpxchg(&folio->_mapcount, &old, new));
+	return mlock_count - 1;
+}
+
 /*
  * Mlocked folios are marked with the PG_mlocked flag for efficient testing
  * in vmscan and, possibly, the fault path; and to support semi-accurate
@@ -83,16 +175,12 @@ static struct lruvec *__mlock_folio(struct folio *folio, struct lruvec *lruvec)
 		goto out;
 	}
 
-	if (folio_test_unevictable(folio)) {
-		if (folio_test_mlocked(folio))
-			folio->mlock_count++;
+	if (folio_test_unevictable(folio))
 		goto out;
-	}
 
 	lruvec_del_folio(lruvec, folio);
 	folio_clear_active(folio);
 	folio_set_unevictable(folio);
-	folio->mlock_count = !!folio_test_mlocked(folio);
 	lruvec_add_folio(lruvec, folio);
 	__count_vm_events(UNEVICTABLE_PGCULLED, folio_nr_pages(folio));
 out:
@@ -111,7 +199,6 @@ static struct lruvec *__mlock_new_folio(struct folio *folio, struct lruvec *lruv
 		goto out;
 
 	folio_set_unevictable(folio);
-	folio->mlock_count = !!folio_test_mlocked(folio);
 	__count_vm_events(UNEVICTABLE_PGCULLED, folio_nr_pages(folio));
 out:
 	lruvec_add_folio(lruvec, folio);
@@ -124,22 +211,14 @@ static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec
 	int nr_pages = folio_nr_pages(folio);
 	bool isolated = false;
 
-	if (!folio_test_clear_lru(folio))
-		goto munlock;
-
-	isolated = true;
-	lruvec = folio_lruvec_relock_irq(folio, lruvec);
-
-	if (folio_test_unevictable(folio)) {
-		/* Then mlock_count is maintained, but might undercount */
-		if (folio->mlock_count)
-			folio->mlock_count--;
-		if (folio->mlock_count)
-			goto out;
+	if (folio_test_clear_lru(folio)) {
+		isolated = true;
+		lruvec = folio_lruvec_relock_irq(folio, lruvec);
 	}
-	/* else assume that was the last mlock: reclaim will fix it if not */
 
-munlock:
+	if (folio_mlock_count_dec(folio) > 0)
+		goto out;
+
 	if (folio_test_clear_mlocked(folio)) {
 		__zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
 		if (isolated || !folio_test_unevictable(folio))
@@ -254,6 +333,7 @@ void mlock_folio(struct folio *folio)
 		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 	}
 
+	folio_mlock_count_inc(folio);
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
 	    folio_test_large(folio) || lru_cache_disabled())
@@ -273,6 +353,7 @@ void mlock_new_folio(struct folio *folio)
 	local_lock(&mlock_fbatch.lock);
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
 	folio_set_mlocked(folio);
+	folio_mlock_count_inc(folio);
 
 	zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
 	__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
diff --git a/mm/swap.c b/mm/swap.c
index 423199ee8478..8b6f6e2fdc24 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -184,14 +184,6 @@ static void lru_add_fn(struct lruvec *lruvec, struct folio *folio)
 	} else {
 		folio_clear_active(folio);
 		folio_set_unevictable(folio);
-		/*
-		 * folio->mlock_count = !!folio_test_mlocked(folio)?
-		 * But that leaves __mlock_folio() in doubt whether another
-		 * actor has already counted the mlock or not.  Err on the
-		 * safe side, underestimate, let page reclaim fix it, rather
-		 * than leaving a page on the unevictable LRU indefinitely.
-		 */
-		folio->mlock_count = 0;
 		if (!was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
 	}
-- 
2.41.0.162.gfafddb0af9-goog

