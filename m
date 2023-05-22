Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A7A70B438
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEVEvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEVEvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:51:11 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F0B132
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:51:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9a7e639656so10757891276.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731064; x=1687323064;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANcMmc9BeTTDRJseGPHLnYq8DMAivc7OJ7zKS5AkOEU=;
        b=suZ7/fWyjgtDmmUUG368PhOQSIoqVmOnxBEGz1k9zCkGOxssorwZrFR60X+8a4DQqr
         7u71fp8c7x68EiyyW8ZSDwzHkHiPONOn7yDOgmy63jiQBTyUNcqNciC9w+0U347zF4Gf
         qZEb5FQPLn1+cE60AE8Q2hbQucuksdSO++m5CDyyBTN/iGnKQo4gRrU//els8iIiBdS7
         ovYLm7Yj3qMDE0Qoy1tWZGPaThqr4eXUwvzaDxInjjwEGGfg2sUxlTqNWk6AaZWuz+i8
         FTUjVygqWWxTs+smOosRSftvUI/03MEA0EZ3L2DHmfVjXa6bRJ1mwd0Lc0WFnRQmYQLX
         GTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731064; x=1687323064;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANcMmc9BeTTDRJseGPHLnYq8DMAivc7OJ7zKS5AkOEU=;
        b=cIQnZDEAno+Dh2HM1nAaFnzgKtnED2E4c/IqYJ2q+O4ZBmU+sct4cYRCr1quYEBDxn
         hIO4XON1ZNNZ1HH3FKt6FvPpBiN2RBXTe0n3Jc59nFLZqNCaGglmTCIVAKvvrZ2Hccdt
         6lOwXdRXAH9WpWZ5Kv5HWe5dqdOeI7jE/WQbfhHCHs+nAbpdfI8ptpdB87nAaypXwV9i
         sYDcSHATxrC0dUWH71xE74J5vuwoKCnctZS2Fe4gqhVVXj/uGQC1RUt+CC5UB87xaN8B
         3B5xNB17I0ssMPGTlddTSN9WYOzpfylsBmh5shZQjwryWuv9hFyOee32Hetls+NOD16C
         lCDg==
X-Gm-Message-State: AC+VfDyFO2lXBsy8e5pyyIW5PKwA5cBFBF65jwSM19hoZ2nPxrHIe+W4
        L8kV4PgPzs6CrW9OXE4AgvwYwg==
X-Google-Smtp-Source: ACHHUZ6jO0XEKla2wlyWHkLbd6267BBIAu3WYemOi2dKQNM0AlHnDzPyGpw7fyb0X8v56kZQVrFU2A==
X-Received: by 2002:a25:1042:0:b0:ba8:1807:9d7f with SMTP id 63-20020a251042000000b00ba818079d7fmr9116239ybq.58.1684731064262;
        Sun, 21 May 2023 21:51:04 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a11-20020a81bb4b000000b0054e82b6a95esm1808098ywl.42.2023.05.21.21.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:51:04 -0700 (PDT)
Date:   Sun, 21 May 2023 21:51:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 02/31] mm/migrate: remove cruft from
 migration_entry_wait()s
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <1659568-468a-6d36-c26-6a52a335ab59@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
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

migration_entry_wait_on_locked() does not need to take a mapped pte
pointer, its callers can do the unmap first.  Annotate it with
__releases(ptl) to reduce sparse warnings.

Fold __migration_entry_wait_huge() into migration_entry_wait_huge().
Fold __migration_entry_wait() into migration_entry_wait(), preferring
the tighter pte_offset_map_lock() to pte_offset_map() and pte_lockptr().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/migrate.h |  4 ++--
 include/linux/swapops.h | 17 +++--------------
 mm/filemap.c            | 13 ++++---------
 mm/migrate.c            | 37 +++++++++++++------------------------
 4 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 6241a1596a75..affea3063473 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -75,8 +75,8 @@ bool isolate_movable_page(struct page *page, isolate_mode_t mode);
 
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 		struct folio *dst, struct folio *src);
-void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
-				spinlock_t *ptl);
+void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
+		__releases(ptl);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
 void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 3a451b7afcb3..4c932cb45e0b 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -332,15 +332,9 @@ static inline bool is_migration_entry_dirty(swp_entry_t entry)
 	return false;
 }
 
-extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
-					spinlock_t *ptl);
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
-#ifdef CONFIG_HUGETLB_PAGE
-extern void __migration_entry_wait_huge(struct vm_area_struct *vma,
-					pte_t *ptep, spinlock_t *ptl);
 extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
-#endif	/* CONFIG_HUGETLB_PAGE */
 #else  /* CONFIG_MIGRATION */
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
 {
@@ -362,15 +356,10 @@ static inline int is_migration_entry(swp_entry_t swp)
 	return 0;
 }
 
-static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
-					spinlock_t *ptl) { }
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
-					 unsigned long address) { }
-#ifdef CONFIG_HUGETLB_PAGE
-static inline void __migration_entry_wait_huge(struct vm_area_struct *vma,
-					       pte_t *ptep, spinlock_t *ptl) { }
-static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
-#endif	/* CONFIG_HUGETLB_PAGE */
+					unsigned long address) { }
+static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
+					pte_t *pte) { }
 static inline int is_writable_migration_entry(swp_entry_t entry)
 {
 	return 0;
diff --git a/mm/filemap.c b/mm/filemap.c
index b4c9bd368b7e..28b42ee848a4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1359,8 +1359,6 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 /**
  * migration_entry_wait_on_locked - Wait for a migration entry to be removed
  * @entry: migration swap entry.
- * @ptep: mapped pte pointer. Will return with the ptep unmapped. Only required
- *        for pte entries, pass NULL for pmd entries.
  * @ptl: already locked ptl. This function will drop the lock.
  *
  * Wait for a migration entry referencing the given page to be removed. This is
@@ -1369,13 +1367,13 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
  * should be called while holding the ptl for the migration entry referencing
  * the page.
  *
- * Returns after unmapping and unlocking the pte/ptl with pte_unmap_unlock().
+ * Returns after unlocking the ptl.
  *
  * This follows the same logic as folio_wait_bit_common() so see the comments
  * there.
  */
-void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
-				spinlock_t *ptl)
+void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
+	__releases(ptl)
 {
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
@@ -1409,10 +1407,7 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
 	 * a valid reference to the page, and it must take the ptl to remove the
 	 * migration entry. So the page is valid until the ptl is dropped.
 	 */
-	if (ptep)
-		pte_unmap_unlock(ptep, ptl);
-	else
-		spin_unlock(ptl);
+	spin_unlock(ptl);
 
 	for (;;) {
 		unsigned int flags;
diff --git a/mm/migrate.c b/mm/migrate.c
index 01cac26a3127..3ecb7a40075f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -296,14 +296,18 @@ void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
  * get to the page and wait until migration is finished.
  * When we return from this function the fault will be retried.
  */
-void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
-				spinlock_t *ptl)
+void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
+			  unsigned long address)
 {
+	spinlock_t *ptl;
+	pte_t *ptep;
 	pte_t pte;
 	swp_entry_t entry;
 
-	spin_lock(ptl);
+	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	pte = *ptep;
+	pte_unmap(ptep);
+
 	if (!is_swap_pte(pte))
 		goto out;
 
@@ -311,18 +315,10 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 	if (!is_migration_entry(entry))
 		goto out;
 
-	migration_entry_wait_on_locked(entry, ptep, ptl);
+	migration_entry_wait_on_locked(entry, ptl);
 	return;
 out:
-	pte_unmap_unlock(ptep, ptl);
-}
-
-void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
-				unsigned long address)
-{
-	spinlock_t *ptl = pte_lockptr(mm, pmd);
-	pte_t *ptep = pte_offset_map(pmd, address);
-	__migration_entry_wait(mm, ptep, ptl);
+	spin_unlock(ptl);
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -332,9 +328,9 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
  *
  * This function will release the vma lock before returning.
  */
-void __migration_entry_wait_huge(struct vm_area_struct *vma,
-				 pte_t *ptep, spinlock_t *ptl)
+void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *ptep)
 {
+	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, ptep);
 	pte_t pte;
 
 	hugetlb_vma_assert_locked(vma);
@@ -352,16 +348,9 @@ void __migration_entry_wait_huge(struct vm_area_struct *vma,
 		 * lock release in migration_entry_wait_on_locked().
 		 */
 		hugetlb_vma_unlock_read(vma);
-		migration_entry_wait_on_locked(pte_to_swp_entry(pte), NULL, ptl);
+		migration_entry_wait_on_locked(pte_to_swp_entry(pte), ptl);
 	}
 }
-
-void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
-{
-	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
-
-	__migration_entry_wait_huge(vma, pte, ptl);
-}
 #endif
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
@@ -372,7 +361,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 	ptl = pmd_lock(mm, pmd);
 	if (!is_pmd_migration_entry(*pmd))
 		goto unlock;
-	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), NULL, ptl);
+	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), ptl);
 	return;
 unlock:
 	spin_unlock(ptl);
-- 
2.35.3

