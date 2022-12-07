Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC80646268
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiLGUcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLGUbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF924BC1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XK/5vqUd1QlikRxebc+rXesIul2oExyAtkR9smyGVX0=;
        b=MJ9GIlhHC0W0yphgEWSNW8wi9F3K6AnBmB08kLAgZ8GI4/7otMvRiiAxKZZKDwuZI/tzZD
        83pOlvm487qYVOwR1oJP5+bGw0TvdydguztNieu7IrEGFu4Ym+rXbnzrGReERDIBxYeKws
        r27sn3WY2TQz4/hq7JCPtj4eTU0X0OM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-324-EgF7b9GtO0Cg090C2qIeFQ-1; Wed, 07 Dec 2022 15:30:45 -0500
X-MC-Unique: EgF7b9GtO0Cg090C2qIeFQ-1
Received: by mail-qv1-f69.google.com with SMTP id jh2-20020a0562141fc200b004c74bbb0affso24904196qvb.21
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK/5vqUd1QlikRxebc+rXesIul2oExyAtkR9smyGVX0=;
        b=Rt9cXZCJ4yPKSx2wrfp/fFqLSoJacIQkF9tibIs0IJ1wzDivbhie1brSd/lXzVjrgs
         QofU8Kqh2uBFaaDZsxrAWq72IYdQSUaIQ20f2bm94hfOCE+9jTNAxac7yG5b3W9l6WbJ
         cfoIxwtSzS0u3jcEzmQsJ0R2cdlTn20Ho5UmniFywfopRUBeMsYf5X8b0GuNBig6GwC7
         0soGWivmn7VHdhnctIqwxFiu7VHZabBWnZF6jAcufn4vI9a/hWvuOiOUUpOMyO2nRST/
         4PS2NcT/eKZFup4YptshKZRjh3JePwq3jkuv8IgWT+GcBSgn5O/IxlfxR13mfq0jcFCW
         4Xkw==
X-Gm-Message-State: ANoB5pnM6WBR4waytnOibtEcrraIIma07HWtFE6FplpXCGrLFUBwUcr+
        47oUN4AHavwfDfdWMyNkoSWKMz8z+4blqsh5mrz5M54rjpTS4AqeQcBb85b1H6GXxsbfz9vOu+Q
        doxmRhPjHbihge8qKzly0ij/G
X-Received: by 2002:ac8:57cd:0:b0:3a6:7b53:9b20 with SMTP id w13-20020ac857cd000000b003a67b539b20mr2152370qta.12.1670445044512;
        Wed, 07 Dec 2022 12:30:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5LbXfVhI/+vq/w+LG4yNKtnSGIgip174q5+ZLxE8DPe02Msdaz4r+WtR6QivWpqpG5VnnIiA==
X-Received: by 2002:ac8:57cd:0:b0:3a6:7b53:9b20 with SMTP id w13-20020ac857cd000000b003a67b539b20mr2152353qta.12.1670445044228;
        Wed, 07 Dec 2022 12:30:44 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dc53-20020a05620a523500b006fefa5f7fcesm855594qkb.10.2022.12.07.12.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:30:43 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 04/10] mm/hugetlb: Move swap entry handling into vma lock when faulted
Date:   Wed,  7 Dec 2022 15:30:28 -0500
Message-Id: <20221207203034.650899-5-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221207203034.650899-1-peterx@redhat.com>
References: <20221207203034.650899-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hugetlb_fault(), there used to have a special path to handle swap entry
at the entrance using huge_pte_offset().  That's unsafe because
huge_pte_offset() for a pmd sharable range can access freed pgtables if
without any lock to protect the pgtable from being freed after pmd unshare.

Here the simplest solution to make it safe is to move the swap handling to
be after the vma lock being held.  We may need to take the fault mutex on
either migration or hwpoison entries now (also the vma lock, but that's
really needed), however neither of them is hot path.

Note that the vma lock cannot be released in hugetlb_fault() when the
migration entry is detected, because in migration_entry_wait_huge() the
pgtable page will be used again (by taking the pgtable lock), so that also
need to be protected by the vma lock.  Modify migration_entry_wait_huge()
so that it must be called with vma read lock held, and properly release the
lock in __migration_entry_wait_huge().

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h |  6 ++++--
 mm/hugetlb.c            | 36 +++++++++++++++---------------------
 mm/migrate.c            | 25 +++++++++++++++++++++----
 3 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index a70b5c3a68d7..b134c5eb75cb 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -337,7 +337,8 @@ extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 #ifdef CONFIG_HUGETLB_PAGE
-extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
+extern void __migration_entry_wait_huge(struct vm_area_struct *vma,
+					pte_t *ptep, spinlock_t *ptl);
 extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
 #endif	/* CONFIG_HUGETLB_PAGE */
 #else  /* CONFIG_MIGRATION */
@@ -366,7 +367,8 @@ static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					 unsigned long address) { }
 #ifdef CONFIG_HUGETLB_PAGE
-static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
+static inline void __migration_entry_wait_huge(struct vm_area_struct *vma,
+					       pte_t *ptep, spinlock_t *ptl) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
 #endif	/* CONFIG_HUGETLB_PAGE */
 static inline int is_writable_migration_entry(swp_entry_t entry)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c8a6673fe5b4..49f73677a418 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5824,22 +5824,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
 
-	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
-	if (ptep) {
-		/*
-		 * Since we hold no locks, ptep could be stale.  That is
-		 * OK as we are only making decisions based on content and
-		 * not actually modifying content here.
-		 */
-		entry = huge_ptep_get(ptep);
-		if (unlikely(is_hugetlb_entry_migration(entry))) {
-			migration_entry_wait_huge(vma, ptep);
-			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
-			return VM_FAULT_HWPOISON_LARGE |
-				VM_FAULT_SET_HINDEX(hstate_index(h));
-	}
-
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
@@ -5854,10 +5838,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * Acquire vma lock before calling huge_pte_alloc and hold
 	 * until finished with ptep.  This prevents huge_pmd_unshare from
 	 * being called elsewhere and making the ptep no longer valid.
-	 *
-	 * ptep could have already be assigned via huge_pte_offset.  That
-	 * is OK, as huge_pte_alloc will return the same value unless
-	 * something has changed.
 	 */
 	hugetlb_vma_lock_read(vma);
 	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
@@ -5886,8 +5866,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
 	 * properly handle it.
 	 */
-	if (!pte_present(entry))
+	if (!pte_present(entry)) {
+		if (unlikely(is_hugetlb_entry_migration(entry))) {
+			/*
+			 * Release fault lock first because the vma lock is
+			 * needed to guard the huge_pte_lockptr() later in
+			 * migration_entry_wait_huge().  The vma lock will
+			 * be released there.
+			 */
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			migration_entry_wait_huge(vma, ptep);
+			return 0;
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
+			ret = VM_FAULT_HWPOISON_LARGE |
+			    VM_FAULT_SET_HINDEX(hstate_index(h));
 		goto out_mutex;
+	}
 
 	/*
 	 * If we are going to COW/unshare the mapping later, we examine the
diff --git a/mm/migrate.c b/mm/migrate.c
index 48584b032ea9..d14f1f3ab073 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -333,24 +333,41 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
+void __migration_entry_wait_huge(struct vm_area_struct *vma,
+				 pte_t *ptep, spinlock_t *ptl)
 {
 	pte_t pte;
 
+	/*
+	 * The vma read lock must be taken, which will be released before
+	 * the function returns.  It makes sure the pgtable page (along
+	 * with its spin lock) not be freed in parallel.
+	 */
+	hugetlb_vma_assert_locked(vma);
+
 	spin_lock(ptl);
 	pte = huge_ptep_get(ptep);
 
-	if (unlikely(!is_hugetlb_entry_migration(pte)))
+	if (unlikely(!is_hugetlb_entry_migration(pte))) {
 		spin_unlock(ptl);
-	else
+		hugetlb_vma_unlock_read(vma);
+	} else {
+		/*
+		 * If migration entry existed, safe to release vma lock
+		 * here because the pgtable page won't be freed without the
+		 * pgtable lock released.  See comment right above pgtable
+		 * lock release in migration_entry_wait_on_locked().
+		 */
+		hugetlb_vma_unlock_read(vma);
 		migration_entry_wait_on_locked(pte_to_swp_entry(pte), NULL, ptl);
+	}
 }
 
 void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
 {
 	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
 
-	__migration_entry_wait_huge(pte, ptl);
+	__migration_entry_wait_huge(vma, pte, ptl);
 }
 #endif
 
-- 
2.37.3

