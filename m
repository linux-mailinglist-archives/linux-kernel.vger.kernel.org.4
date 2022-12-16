Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6141B64EE31
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiLPPwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLPPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A2566C1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vsQ4xrOeNHA8Em2t3SYPnGMugJW9C8Z5spFzSFBIRTk=;
        b=UZv+jF8Kz+8bGvGETFWTE+EZR1w/nrRz4jiObH3ORAHn7dx/aTN8scjsIas7aPAEUmekvf
        7+RvbbwdI74ki/Q2Zt8ai8GdU4N6t+dsX0pko724+OjD3xALvzEOSh5ue+me73VnVALZkw
        cEzJcdl+naKpME6RYeVVUCULoi3Dlws=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424-806yTOPjMzm4KEE3-uOTVg-1; Fri, 16 Dec 2022 10:51:17 -0500
X-MC-Unique: 806yTOPjMzm4KEE3-uOTVg-1
Received: by mail-qt1-f200.google.com with SMTP id fg11-20020a05622a580b00b003a7eaa5cb47so1770855qtb.15
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsQ4xrOeNHA8Em2t3SYPnGMugJW9C8Z5spFzSFBIRTk=;
        b=VFHNc0nt/IJDAHSjtcxmKtJmhoi8E61D3v9fBUQWQR6YldEPM8UvutFxp1RepM8erM
         Ogt6v4FzvAezI0dxXRJy/qYScaNNxif1Y4Yce5HJT5uvHsLOTIliSuXz3MUwAxxiBjNQ
         7waKeVWRieYTa0ETzqEaCLmvPnCKs8IpkP6iH/ekfypZHLyxeCY7mby+lR6/24Ea8fXE
         RwCii4vWFp0ZDV/9MGxjZ9Z96UMbWe0XNwKr3eaeNwqlM+l1+Kv2xf9wZCFrkq4Htuyc
         6C9f7hmmQDj8wluklFrzUfr/XgyrflYeFtatdErPpSdUpkQdXJmSne5R/pwIdAc/Q7wN
         JrMA==
X-Gm-Message-State: AFqh2krXGgQpXwCmoP62gXD0DsnaqRqlYr6lfSqmeoBwef0NBwgvcRUp
        voiTFQ7zyW2i9MWf8DEexjj9zb6k4lskpYVk+/LFwSgHtbG94NSEhvhqTN0nfkqV1vkhjBe3EKT
        CcDt/wU/loPlC+YhbQPyqHFuQE8Oylhhxv5HVXCcW0ErAWguSGEAVwmk5XdAQYCo4c+jBcn8DkA
        ==
X-Received: by 2002:a05:6214:3787:b0:4f3:7d92:13a9 with SMTP id ni7-20020a056214378700b004f37d9213a9mr8375891qvb.15.1671205875754;
        Fri, 16 Dec 2022 07:51:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuI37Cnbiq7WTJZi91OO/hWpXTz/+s2VaXzLPKoSNSCTyQ3nllT7XSFGoanS+lfNocZLgfsog==
X-Received: by 2002:a05:6214:3787:b0:4f3:7d92:13a9 with SMTP id ni7-20020a056214378700b004f37d9213a9mr8375847qvb.15.1671205875427;
        Fri, 16 Dec 2022 07:51:15 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id s81-20020a37a954000000b006eeb3165554sm1682297qke.19.2022.12.16.07.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:51:14 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        James Houghton <jthoughton@google.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v4 4/9] mm/hugetlb: Move swap entry handling into vma lock when faulted
Date:   Fri, 16 Dec 2022 10:50:55 -0500
Message-Id: <20221216155100.2043537-5-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221216155100.2043537-1-peterx@redhat.com>
References: <20221216155100.2043537-1-peterx@redhat.com>
MIME-Version: 1.0
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
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h |  6 ++++--
 mm/hugetlb.c            | 37 ++++++++++++++++---------------------
 mm/migrate.c            | 25 +++++++++++++++++++++----
 3 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index b982dd614572..3a451b7afcb3 100644
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
index 8ccd55f9fbd3..64512a151567 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5972,22 +5972,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -6002,10 +5986,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -6034,8 +6014,23 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
 	 * properly handle it.
 	 */
-	if (!pte_present(entry))
+	if (!pte_present(entry)) {
+		if (unlikely(is_hugetlb_entry_migration(entry))) {
+			/*
+			 * Release the hugetlb fault lock now, but retain
+			 * the vma lock, because it is needed to guard the
+			 * huge_pte_lockptr() later in
+			 * migration_entry_wait_huge(). The vma lock will
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
index a4d3fc65085f..98de7ce2b576 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -329,24 +329,41 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
+/*
+ * The vma read lock must be held upon entry. Holding that lock prevents either
+ * the pte or the ptl from being freed.
+ *
+ * This function will release the vma lock before returning.
+ */
+void __migration_entry_wait_huge(struct vm_area_struct *vma,
+				 pte_t *ptep, spinlock_t *ptl)
 {
 	pte_t pte;
 
+	hugetlb_vma_assert_locked(vma);
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

