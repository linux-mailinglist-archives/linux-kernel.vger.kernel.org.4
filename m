Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C433728CD8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjFIBIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFIBI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:08:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF5CE47
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:08:25 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75d50f25cc9so105894385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686272905; x=1688864905;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=howkEJoV//tXil1Z2yV8DA3fQgmxIGa28HiuE8oWzhc=;
        b=4TUvz+8KoUFPjBrCAcYR59EYGfTLuV6CLia8XZUURQDZbunBGHJYb+jGkZmsygXgl3
         +15vELNZ2tt6xf6nRk+326C0YlS5yYQ2GCB6uL+UjODH+sl0FpGKeWODfJXUrOGUmWtC
         s13E9TqS54wkrJ0CBEm34+uvV622uJ8q5jR+3xcY9g99e07dWOHLQHDJc1AmZlHp7BF3
         G5Ij1yJL5CY3uB6yvHN60sdMB/duTTXIRCBGPDCpPIbQNiuj+9xk+3ynZo+U+EWgi22V
         hQAEa6GzzVBUVKOsI+w/Ikakst0ZV10IGK7MsNaGUrB0ra9/vx96mtgIfR6mIWCjP/h4
         L8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686272905; x=1688864905;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=howkEJoV//tXil1Z2yV8DA3fQgmxIGa28HiuE8oWzhc=;
        b=FgTjEAl0bUZCfGqT3gBsgiGLZ53wdgMngo1VyxEf1VjbbJzyoOxqw30hGPcFlwS/Lc
         MSwJdRnPn09Hi64jxgdFCxVp9a2f1P8j/3U0okbnI7ICoyF1Cl87JYDVwaRVdWGgQO5T
         sCIIXsTCehFSMuLtXmj3pMuvECWlCEjpnZK0KQ2Wi+8RM7oT9HoEGoX4MbdYLIBZ3Zpl
         STkN+m9tcBHvlbVotxMa9Yk0kWv0W+qKWdyjBMxrRGlk7PPGomF6WeBbXK3Wx7hOgZCN
         gi0OyOkcKXlmeEqa/AmZSikqs77EAQFEXIV+KDKr1LgJdFmI6OCgyVhokZMXCvaxQarp
         5hpQ==
X-Gm-Message-State: AC+VfDz09quqzkTQyWgRrlzV0oTMoWm6pK1gkdDZMm6Jqqkf+sI1HCx3
        E4cqOvLSKSkO/3OLCDBTFHtjyQ==
X-Google-Smtp-Source: ACHHUZ7/PxpX5u49rxcuOgTsJSbOZnLq1smZ1N/fcsjFrRWYRcflJMGjskZfjY8eigXMifdaD6g1aw==
X-Received: by 2002:a05:620a:84c6:b0:75d:5571:64c0 with SMTP id pq6-20020a05620a84c600b0075d557164c0mr6330539qkn.37.1686272904886;
        Thu, 08 Jun 2023 18:08:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x204-20020a81a0d5000000b00565de196516sm286345ywg.32.2023.06.08.18.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:08:24 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:08:20 -0700 (PDT)
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 02/32] mm/migrate: remove cruft from
 migration_entry_wait()s
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <b0e2a532-cdf2-561b-e999-f3b13b8d6d3@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
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
Reviewed-by: Alistair Popple <apopple@nvidia.com>
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

