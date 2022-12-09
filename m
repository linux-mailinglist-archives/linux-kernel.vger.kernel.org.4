Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF53F64872E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLIRC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiLIRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A337D06C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670605281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtv4yezaaEbF1bO1grzv/hp6hNuvFjuXz2keNbWJszA=;
        b=SzwF386cJGBdeKTN2cX+P6IhpBeNqRC2JLfZm7jdN+9McljOZSuiRjd5B3QrCMqJpbv4bZ
        jvdrWeT7VXOsRRkvQEp7fhLmOMjp9UzpvBTESLf2yNx1CUrWTLmw1Ak6/QEr9iRAUYab6c
        Q/y5zbvMNCq0kkrVZGNKtbMRrJGPGSk=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-JbRuyix0OF62SY8SwZm8lw-1; Fri, 09 Dec 2022 12:01:20 -0500
X-MC-Unique: JbRuyix0OF62SY8SwZm8lw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-143c7a3da8aso115247fac.23
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtv4yezaaEbF1bO1grzv/hp6hNuvFjuXz2keNbWJszA=;
        b=MbYb0QCBRbRCw6+8GOFYdoAOm+HxnYGLGtvOEvI9vn4/Dpwvg3iVWF7yYVawtLmsaH
         vSuMWGThonO2T1rlkKYI8G5vqNR4FUYqObdw0qFU06Q1UHDr1lB+UQ33v0shL/Xenpcz
         UxPbIlwCtNsww+GBI7TntIFMvxS+bmqwWpbt7nmeLn8CbGUQXk+t5SgbfOnf4igi789Y
         ymbVnQRQhVrksc2llNqYsjVqAYRLiX8sXIM23SSn4IHRpe339XooMrbr6C/wPic6z3e6
         a7LRnJPfYqrZJH43lu0NU8LhViapA7lYggAsEmPipuhw0S8UTBUP2RlRypPhzmmj/rgp
         7qpQ==
X-Gm-Message-State: ANoB5pn2O8tac7vWG/oZmqidvyjdsMkNUsdsYWQqKhbrfi8/VgE/oH/4
        44loorzo/1bbG1Clm1yb0j9oT26SjVnqRk6rE5+Uey8LaV3TJ0sTGM+BKdKgpDEYgek0LyXC/tA
        mu20vLoQimPMujT7UTXkSZXUF
X-Received: by 2002:a4a:aec6:0:b0:49f:96f:e6c0 with SMTP id v6-20020a4aaec6000000b0049f096fe6c0mr3915742oon.8.1670605279393;
        Fri, 09 Dec 2022 09:01:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Vuv1wv7YiysMsVS44h4EbTaETlm5u1UVAmf+zKytKpChDbeBgIigGDbiHmGXYIlQ2iKhB5w==
X-Received: by 2002:a4a:aec6:0:b0:49f:96f:e6c0 with SMTP id v6-20020a4aaec6000000b0049f096fe6c0mr3915632oon.8.1670605278011;
        Fri, 09 Dec 2022 09:01:18 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006cf38fd659asm178907qkl.103.2022.12.09.09.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:01:17 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 4/9] mm/hugetlb: Move swap entry handling into vma lock when faulted
Date:   Fri,  9 Dec 2022 12:00:55 -0500
Message-Id: <20221209170100.973970-5-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221209170100.973970-1-peterx@redhat.com>
References: <20221209170100.973970-1-peterx@redhat.com>
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
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h |  6 ++++--
 mm/hugetlb.c            | 37 ++++++++++++++++---------------------
 mm/migrate.c            | 25 +++++++++++++++++++++----
 3 files changed, 41 insertions(+), 27 deletions(-)

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
index c8a6673fe5b4..247702eb9f88 100644
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
@@ -5886,8 +5866,23 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
index 48584b032ea9..9c4e3a833449 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -333,24 +333,41 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
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

