Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BB363C88F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiK2TiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbiK2ThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DD132070
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669750538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oh9DqPSDqDrKnK09kN0HQudmWQU6fy0ZbcaOAGSajb0=;
        b=PgzLfkJNxZ5d9+Yym5+DzY7RUvi8UjALwBt/Kotvz/PUfG98cfxnki0sKSd2iXeD5IORqu
        215/yP8l8aviOV1tEGUsFJFZ5KhbsGbmUQw5gxQ/gotCFDpooWrIPr234jOxs8egttJDM0
        DcbbkFt4uWMMgx6hgZ1vus1t6cUdL/A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-BzWUi0sAMuaB9OIsoZw15A-1; Tue, 29 Nov 2022 14:35:37 -0500
X-MC-Unique: BzWUi0sAMuaB9OIsoZw15A-1
Received: by mail-qk1-f198.google.com with SMTP id i17-20020a05620a249100b006fa2e10a2ecso31818911qkn.16
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oh9DqPSDqDrKnK09kN0HQudmWQU6fy0ZbcaOAGSajb0=;
        b=fYsesGuO3X6DKk+bZXR1ph/Oc+rQBzHlbkIVrHdqTKpcmk2z6wu2g+HuBVahdSNrEv
         tjv/jvB8aLVlI3D0wI3pQ6fNZ4wz8CujnyYRovVdMF17drIyl8sitaMsroe2TSAbhT5U
         0hs1Uxqwqxpp2+JaL0wirplPOorfgSNpaAjr4IgYpnxqIkBCc/SRD24RQ9fvShYq/nBu
         X9Nz66wQumk/HmsT5oz+aRseO9kG3rNw6zKQT3Ly8WhscejviAGZ/c27YKWZYCn8Hdxr
         +RYEdtFC3sTPr+1R/5TkO8tdc2kimyLVuYc8StFkkS9uKJpjOl82eF/kS8ndFlxMfVRY
         +Ftg==
X-Gm-Message-State: ANoB5pnS4jbEklCd/VBsTAII3kKZjv0WaMtPsZnGrddD3MO2uBYI1THa
        r0znETUnD5QhO1YknmTCsGbh13SwxKagC0xJVsz9HJtw7znShDXwG96H7xTHQ8ADzJZS0j/HYwS
        Md5N+355JmuIuGYj6nY+DxSIL
X-Received: by 2002:a05:620a:a07:b0:6fa:438d:c86f with SMTP id i7-20020a05620a0a0700b006fa438dc86fmr51165974qka.712.1669750536642;
        Tue, 29 Nov 2022 11:35:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Qnx+lO3miKOv0SAxOpvSfR8Gl6/yU1joyymWA5kdQHFi+xLjYS0g8rLLDUu4CbTX0G4JdDw==
X-Received: by 2002:a05:620a:a07:b0:6fa:438d:c86f with SMTP id i7-20020a05620a0a0700b006fa438dc86fmr51165954qka.712.1669750536397;
        Tue, 29 Nov 2022 11:35:36 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm11313013qkp.15.2022.11.29.11.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:35:36 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 04/10] mm/hugetlb: Move swap entry handling into vma lock when faulted
Date:   Tue, 29 Nov 2022 14:35:20 -0500
Message-Id: <20221129193526.3588187-5-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h |  6 ++++--
 mm/hugetlb.c            | 32 +++++++++++++++-----------------
 mm/migrate.c            | 25 +++++++++++++++++++++----
 3 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 27ade4f22abb..09b22b169a71 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -335,7 +335,8 @@ extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 #ifdef CONFIG_HUGETLB_PAGE
-extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
+extern void __migration_entry_wait_huge(struct vm_area_struct *vma,
+					pte_t *ptep, spinlock_t *ptl);
 extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
 #endif	/* CONFIG_HUGETLB_PAGE */
 #else  /* CONFIG_MIGRATION */
@@ -364,7 +365,8 @@ static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
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
index dfe677fadaf8..776e34ccf029 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5826,22 +5826,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -5888,8 +5872,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
index 267ad0d073ae..c13c828d34f3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -326,24 +326,41 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
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

