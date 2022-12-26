Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C296560A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiLZHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiLZHJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:09:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7321AA
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:09:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l26so5558264wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvP9A6XKAl/v1o7+nXXmkZgCax5Ofzh4VaB88gRKyTM=;
        b=ky8mj0aMYqAH26amqbof509vhFcQfx/R9JD++pBJfS9LkQ5h7Ku50RfP+Qwr6uqUNV
         N6jemG0/tTfyufN/1FVlI2FBfR/4NQES9dCn1oBqKrt4hJDGUijI5JwJAsfPa6PZiHze
         8taysu/+hfy9TDEcqWUKrxtRdn1IaAA5UBZjBgEErAA4K9QvRPdGwQ/THSI5w+g5Q28o
         H86M3tygigaBd1IuDGha4O5hp6AbLl0034NdnOvrY8o9ciDPToSU1t3kPp5zPgi9Nu18
         7boxfKn+etohB+OD9Kz/HBTbZOmQeX/6V+/Bhvo7KUJ4VUWuzpRUDGrJk2mPHjZ61p9n
         +Ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvP9A6XKAl/v1o7+nXXmkZgCax5Ofzh4VaB88gRKyTM=;
        b=iYLFnLmSgih0fa1NEZunINR4GjUzYDmdL9EWolCd0KxBBr0hg38YDNC/9THSAJ0wM4
         H15EjA9uoKbII+7ezY2Cz/tYOR430qePbz9lmt+hfg+m9xiadgCQYZX5Od2kXz2/PySn
         q9IJg9l2qa2yC9K0Qr7hPOpBxCcNrFrxDGlOfqWU49arfehUZWtT3PnCYe8m1xKZckD3
         c6gZhxYSEPPK1HTrXeZm3hhXf0649UMepYadNL43bw7V27i04H5bqUxfSIe0OsWtXdkb
         S9L3etI6QdQ/62MCdJCrrQ08ggER13Ne1DE9xybj5Q+FpaN/M7WupTgjMZ3OqyxeCTOx
         T5wQ==
X-Gm-Message-State: AFqh2krhhWN7EHvoryEefYO20HNPZYXn2JzkeSmN3ZuHKZayqJXTasYv
        b+U6zUAHfwFgMtculOcXgBM=
X-Google-Smtp-Source: AMrXdXvP/oOJeqG/K19E0NDhr+3RSqXJeDQAjARpuQZuKzrvSV8HjWUvLNnrxYVZJF148QZamrvUcg==
X-Received: by 2002:a05:600c:4f55:b0:3d3:5166:2da4 with SMTP id m21-20020a05600c4f5500b003d351662da4mr12246298wmq.8.1672038538554;
        Sun, 25 Dec 2022 23:08:58 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e16-20020a05600c4e5000b003c21ba7d7d6sm13191456wmq.44.2022.12.25.23.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 23:08:57 -0800 (PST)
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
Subject: [PATCH v2 3/4] mm: mlock: update the interface to use folios
Date:   Mon, 26 Dec 2022 07:08:46 +0000
Message-Id: <555c36b91c4b34a5972f2614395e3c3831e8102f.1672038314.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672038314.git.lstoakes@gmail.com>
References: <cover.1672038314.git.lstoakes@gmail.com>
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
---
 mm/internal.h | 26 ++++++++++++++++----------
 mm/mlock.c    | 32 +++++++++++++++-----------------
 mm/swap.c     |  2 +-
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1d6f4e168510..8a6e83315369 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -515,10 +515,9 @@ extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
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
@@ -547,15 +546,22 @@ static inline void mlock_vma_page(struct page *page,
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
+void mlock_new_folio(struct folio *folio);
 bool need_mlock_page_drain(int cpu);
 void mlock_page_drain_local(void);
 void mlock_page_drain_remote(int cpu);
@@ -647,7 +653,7 @@ static inline void mlock_vma_page(struct page *page,
 			struct vm_area_struct *vma, bool compound) { }
 static inline void munlock_vma_page(struct page *page,
 			struct vm_area_struct *vma, bool compound) { }
-static inline void mlock_new_page(struct page *page) { }
+static inline void mlock_new_folio(struct folio *folio) { }
 static inline bool need_mlock_page_drain(int cpu) { return false; }
 static inline void mlock_page_drain_local(void) { }
 static inline void mlock_page_drain_remote(int cpu) { }
diff --git a/mm/mlock.c b/mm/mlock.c
index e9ba47fe67ed..0317b33c727f 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
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
+		folio = page_folio((struct page *)pmd_page(*pmd));
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
diff --git a/mm/swap.c b/mm/swap.c
index e54e2a252e27..7df297b143f9 100644
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
-- 
2.39.0

