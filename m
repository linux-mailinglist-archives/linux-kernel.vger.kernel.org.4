Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA8667267
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjALMkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjALMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:39:58 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110B4C714
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:39:56 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso11075093wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzzwgU7cL1S3yrZYwQo4q/k5xxGCQFJxxgRUv/K0pH4=;
        b=n8EE3Cb2JfnWTzG4MJhE0B1dNRpL1plv7AbMVzjwdAR0IbmS406ltS0bMekXlMgDci
         Kw6I00n4S1VRINQq0T9M9r1eZj2W1FVguyD0YN9Ebht6Q0iR3l2YxxBAKqpqoaE9921H
         l+soCbWuASlNv18kTfujG38iXeZnBsTHLkewaVOIAPOnCD4UaSzkLZiW31QHYWDf3TRn
         IS8+hf+EWiPma6bwq7gAqfwrmim5fI3L+jtk390FTDLoKBRX1cE8naBqmS60CfvFt4EO
         WmwVmLE95Vt0H2uTPz/0SMuoD6C7K2F5pErxIRW0dCDfn7e0fjrDkmoB9oRwHPj0urEW
         TZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzzwgU7cL1S3yrZYwQo4q/k5xxGCQFJxxgRUv/K0pH4=;
        b=XmGqmjS+q7/J0RemCIQvG+BGO3EkSLEyUF9xOFei6R0HhMcF0pZS0LaT0w2OoqGRJJ
         YRyZ3BZ9dyoStK6KgbYtVZXkcSoaHQKq5bJDFxJJ/rjh2IH5gzXAJIEHvbe6T0PZHind
         Z6GnbAJf2AadGoJ5raM9TUGG/aNYMo2KGBkC2Xpbq+KmHMUJ8sNkauHHkzspzOM6AnI5
         4UVDQrRhq7hS7pH1pPPM++Wh1DAxsNAEDcgpyw7qICc9zFCDNSsUmYWfThi3J/TMBu+N
         foXvz0xB1I9KzwoictxbuFGfAvNR4IUkXewvp9xx7SA8xCEBGnx0RCfGBmDyad84EzvV
         bLTg==
X-Gm-Message-State: AFqh2koavqcO+SzcYm8PO4JZwRi4qHlW9NE3a/YcZIsLnivSOONPkSLY
        YDWmFwKKr9xOCgQIve2c60nXTl+S+34=
X-Google-Smtp-Source: AMrXdXvQ4A1GidzT/hoCP/gbDJCNd7tsj0vC2hrKM007vjoyrql5Pw7uMJ08X3qLsepiliM/g4pcqQ==
X-Received: by 2002:a05:600c:4d14:b0:3d3:5c7d:a5f3 with SMTP id u20-20020a05600c4d1400b003d35c7da5f3mr58831252wmp.37.1673527194910;
        Thu, 12 Jan 2023 04:39:54 -0800 (PST)
Received: from lucifer.home (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.googlemail.com with ESMTPSA id q1-20020a1ce901000000b003b3307fb98fsm20890797wmc.24.2023.01.12.04.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:39:54 -0800 (PST)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 4/5] mm: mlock: update the interface to use folios
Date:   Thu, 12 Jan 2023 12:39:31 +0000
Message-Id: <cba12777c5544305014bc0cbec56bb4cc71477d8.1673526881.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673526881.git.lstoakes@gmail.com>
References: <cover.1673526881.git.lstoakes@gmail.com>
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

This patch updates the mlock interface to accept folios rather than pages,
bringing the interface in line with the internal implementation.

munlock_vma_page() still requires a page_folio() conversion, however this
is consistent with the existent mlock_vma_page() implementation and a
product of rmap still dealing in pages rather than folios.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/internal.h   | 38 ++++++++++++++++++++++----------------
 mm/migrate.c    |  2 +-
 mm/mlock.c      | 38 ++++++++++++++++++--------------------
 mm/page_alloc.c |  2 +-
 mm/rmap.c       |  4 ++--
 mm/swap.c       | 10 +++++-----
 6 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index c0a02fcb7745..2d09a7a0600a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -533,10 +533,9 @@ extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
  * should be called with vma's mmap_lock held for read or write,
  * under page table lock for the pte/pmd being added or removed.
  *
- * mlock is usually called at the end of page_add_*_rmap(),
- * munlock at the end of page_remove_rmap(); but new anon
- * pages are managed by lru_cache_add_inactive_or_unevictable()
- * calling mlock_new_page().
+ * mlock is usually called at the end of page_add_*_rmap(), munlock at
+ * the end of page_remove_rmap(); but new anon folios are managed by
+ * folio_add_lru_vma() calling mlock_new_folio().
  *
  * @compound is used to include pmd mappings of THPs, but filter out
  * pte mappings of THPs, which cannot be consistently counted: a pte
@@ -565,18 +564,25 @@ static inline void mlock_vma_page(struct page *page,
 	mlock_vma_folio(page_folio(page), vma, compound);
 }
 
-void munlock_page(struct page *page);
-static inline void munlock_vma_page(struct page *page,
+void munlock_folio(struct folio *folio);
+
+static inline void munlock_vma_folio(struct folio *folio,
 			struct vm_area_struct *vma, bool compound)
 {
 	if (unlikely(vma->vm_flags & VM_LOCKED) &&
-	    (compound || !PageTransCompound(page)))
-		munlock_page(page);
+	    (compound || !folio_test_large(folio)))
+		munlock_folio(folio);
+}
+
+static inline void munlock_vma_page(struct page *page,
+			struct vm_area_struct *vma, bool compound)
+{
+	munlock_vma_folio(page_folio(page), vma, compound);
 }
-void mlock_new_page(struct page *page);
-bool need_mlock_page_drain(int cpu);
-void mlock_page_drain_local(void);
-void mlock_page_drain_remote(int cpu);
+void mlock_new_folio(struct folio *folio);
+bool need_mlock_drain(int cpu);
+void mlock_drain_local(void);
+void mlock_drain_remote(int cpu);
 
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
@@ -665,10 +671,10 @@ static inline void mlock_vma_page(struct page *page,
 			struct vm_area_struct *vma, bool compound) { }
 static inline void munlock_vma_page(struct page *page,
 			struct vm_area_struct *vma, bool compound) { }
-static inline void mlock_new_page(struct page *page) { }
-static inline bool need_mlock_page_drain(int cpu) { return false; }
-static inline void mlock_page_drain_local(void) { }
-static inline void mlock_page_drain_remote(int cpu) { }
+static inline void mlock_new_folio(struct folio *folio) { }
+static inline bool need_mlock_drain(int cpu) { return false; }
+static inline void mlock_drain_local(void) { }
+static inline void mlock_drain_remote(int cpu) { }
 static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index a314373c62b7..4d8c8a51f1b8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -265,7 +265,7 @@ static bool remove_migration_pte(struct folio *folio,
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		}
 		if (vma->vm_flags & VM_LOCKED)
-			mlock_page_drain_local();
+			mlock_drain_local();
 
 		trace_remove_migration_pte(pvmw.address, pte_val(pte),
 					   compound_order(new));
diff --git a/mm/mlock.c b/mm/mlock.c
index f8e8d30ab08a..9e9c8be58277 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -210,7 +210,7 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 	folio_batch_reinit(fbatch);
 }
 
-void mlock_page_drain_local(void)
+void mlock_drain_local(void)
 {
 	struct folio_batch *fbatch;
 
@@ -221,7 +221,7 @@ void mlock_page_drain_local(void)
 	local_unlock(&mlock_fbatch.lock);
 }
 
-void mlock_page_drain_remote(int cpu)
+void mlock_drain_remote(int cpu)
 {
 	struct folio_batch *fbatch;
 
@@ -231,7 +231,7 @@ void mlock_page_drain_remote(int cpu)
 		mlock_folio_batch(fbatch);
 }
 
-bool need_mlock_page_drain(int cpu)
+bool need_mlock_drain(int cpu)
 {
 	return folio_batch_count(&per_cpu(mlock_fbatch.fbatch, cpu));
 }
@@ -262,13 +262,12 @@ void mlock_folio(struct folio *folio)
 }
 
 /**
- * mlock_new_page - mlock a newly allocated page not yet on LRU
- * @page: page to be mlocked, either a normal page or a THP head.
+ * mlock_new_folio - mlock a newly allocated folio not yet on LRU
+ * @folio: folio to be mlocked, either normal or a THP head.
  */
-void mlock_new_page(struct page *page)
+void mlock_new_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
-	struct folio *folio = page_folio(page);
 	int nr_pages = folio_nr_pages(folio);
 
 	local_lock(&mlock_fbatch.lock);
@@ -286,13 +285,12 @@ void mlock_new_page(struct page *page)
 }
 
 /**
- * munlock_page - munlock a page
- * @page: page to be munlocked, either a normal page or a THP head.
+ * munlock_folio - munlock a folio
+ * @folio: folio to be munlocked, either normal or a THP head.
  */
-void munlock_page(struct page *page)
+void munlock_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
-	struct folio *folio = page_folio(page);
 
 	local_lock(&mlock_fbatch.lock);
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
@@ -314,7 +312,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	spinlock_t *ptl;
 	pte_t *start_pte, *pte;
-	struct page *page;
+	struct folio *folio;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -322,11 +320,11 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 			goto out;
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
-		page = pmd_page(*pmd);
+		folio = page_folio(pmd_page(*pmd));
 		if (vma->vm_flags & VM_LOCKED)
-			mlock_folio(page_folio(page));
+			mlock_folio(folio);
 		else
-			munlock_page(page);
+			munlock_folio(folio);
 		goto out;
 	}
 
@@ -334,15 +332,15 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
-		page = vm_normal_page(vma, addr, *pte);
-		if (!page || is_zone_device_page(page))
+		folio = vm_normal_folio(vma, addr, *pte);
+		if (!folio || folio_is_zone_device(folio))
 			continue;
-		if (PageTransCompound(page))
+		if (folio_test_large(folio))
 			continue;
 		if (vma->vm_flags & VM_LOCKED)
-			mlock_folio(page_folio(page));
+			mlock_folio(folio);
 		else
-			munlock_page(page);
+			munlock_folio(folio);
 	}
 	pte_unmap(start_pte);
 out:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 41a239ce4692..7b36bda246cd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8610,7 +8610,7 @@ static int page_alloc_cpu_dead(unsigned int cpu)
 	struct zone *zone;
 
 	lru_add_drain_cpu(cpu);
-	mlock_page_drain_remote(cpu);
+	mlock_drain_remote(cpu);
 	drain_pages(cpu);
 
 	/*
diff --git a/mm/rmap.c b/mm/rmap.c
index 7f76fc40af9a..0e450e6bb963 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1764,7 +1764,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
 		if (vma->vm_flags & VM_LOCKED)
-			mlock_page_drain_local();
+			mlock_drain_local();
 		folio_put(folio);
 	}
 
@@ -2119,7 +2119,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
 		if (vma->vm_flags & VM_LOCKED)
-			mlock_page_drain_local();
+			mlock_drain_local();
 		folio_put(folio);
 	}
 
diff --git a/mm/swap.c b/mm/swap.c
index e54e2a252e27..42d67f9baa8c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -562,7 +562,7 @@ void folio_add_lru_vma(struct folio *folio, struct vm_area_struct *vma)
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
 	if (unlikely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED))
-		mlock_new_page(&folio->page);
+		mlock_new_folio(folio);
 	else
 		folio_add_lru(folio);
 }
@@ -781,7 +781,7 @@ void lru_add_drain(void)
 	local_lock(&cpu_fbatches.lock);
 	lru_add_drain_cpu(smp_processor_id());
 	local_unlock(&cpu_fbatches.lock);
-	mlock_page_drain_local();
+	mlock_drain_local();
 }
 
 /*
@@ -796,7 +796,7 @@ static void lru_add_and_bh_lrus_drain(void)
 	lru_add_drain_cpu(smp_processor_id());
 	local_unlock(&cpu_fbatches.lock);
 	invalidate_bh_lrus_cpu();
-	mlock_page_drain_local();
+	mlock_drain_local();
 }
 
 void lru_add_drain_cpu_zone(struct zone *zone)
@@ -805,7 +805,7 @@ void lru_add_drain_cpu_zone(struct zone *zone)
 	lru_add_drain_cpu(smp_processor_id());
 	drain_local_pages(zone);
 	local_unlock(&cpu_fbatches.lock);
-	mlock_page_drain_local();
+	mlock_drain_local();
 }
 
 #ifdef CONFIG_SMP
@@ -828,7 +828,7 @@ static bool cpu_needs_drain(unsigned int cpu)
 		folio_batch_count(&fbatches->lru_deactivate) ||
 		folio_batch_count(&fbatches->lru_lazyfree) ||
 		folio_batch_count(&fbatches->activate) ||
-		need_mlock_page_drain(cpu) ||
+		need_mlock_drain(cpu) ||
 		has_bh_in_lru(cpu, NULL);
 }
 
-- 
2.39.0

