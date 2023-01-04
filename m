Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1B465E0AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjADW5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjADW4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8F347309
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672872927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8KxT0fw2Kti4PKRWkIZPhnz1STfAelBM/L1tGxVI0U=;
        b=MOITBMECp9zVkGJmoUvi91eYFk5JfQkkr6MyFm/Ua8P3Fx4rJphpSD4zEb8L8z5J3d1pvR
        54jc1q1TqchdaC50QbU1U4UOe3dPDTJUmTiBJzvqrJbsHrb++P0myb2ain4J3uw5URhjbG
        6Z5S8uC9+yeGI2aPY6DcX5U2cYzrjz4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-472-pG8ygPPxPoi4tIKZskSTOg-1; Wed, 04 Jan 2023 17:52:18 -0500
X-MC-Unique: pG8ygPPxPoi4tIKZskSTOg-1
Received: by mail-qk1-f200.google.com with SMTP id az39-20020a05620a172700b006ff85c3b19eso24037206qkb.18
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8KxT0fw2Kti4PKRWkIZPhnz1STfAelBM/L1tGxVI0U=;
        b=YopcAdPmjsLnv/qVC5cXcEUEgw6wQuMAYvvKVSzw+YFg09+kT6hbSL/LDrviWXG63v
         6Vv0i6pALTjK53+bNKaz3nmJ/3TcC0IKcGj0OXyUVQ6qdwPWX+RCePwJnp95VBaMsloB
         GK3ScltY/H6URu4C3FekA92K2IrO2Syo+dGkBhwrXUCgUH0bJezenzIDoD2Dr3YvpdLa
         QzBx+YvwjerlArhb8BYG2lpQDVCStKMkrdMxhsTa5D1W2dXZ0DvrwdtmotV917l6MFGY
         NE27U38OFA29ChLuNje3EdJCgsDZ49I403NFJgTuNiD2XY37boQ/wM1L2xNhn4Neeb//
         fWsQ==
X-Gm-Message-State: AFqh2kqy2BY5YKVF2kUaK5es5hnRCv8z0GG9EveMs9VQSlGtb6PiV5KZ
        Po+wry++uWX7ON5hof3NBpChp5fK4nTaBKU80zsyhp2Khx+a+fYndBI8R1fbIEx9Ml3CPT8M/jb
        8Z0t5yLKUlVlB062+wNNNkxWG
X-Received: by 2002:a05:6214:8e3:b0:521:ae4d:ea6a with SMTP id dr3-20020a05621408e300b00521ae4dea6amr65901329qvb.20.1672872737446;
        Wed, 04 Jan 2023 14:52:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu3dqYKFJ4Eo3TV1tw30PJqBr+Re6V+2aX8VJI591b6bZwEcKu5VZE1Ef0m6xJeQKmWoMv59Q==
X-Received: by 2002:a05:6214:8e3:b0:521:ae4d:ea6a with SMTP id dr3-20020a05621408e300b00521ae4dea6amr65901311qvb.20.1672872737186;
        Wed, 04 Jan 2023 14:52:17 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a298100b006eeb3165565sm24654710qkp.80.2023.01.04.14.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:52:16 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] mm/uffd: Detect pgtable allocation failures
Date:   Wed,  4 Jan 2023 17:52:07 -0500
Message-Id: <20230104225207.1066932-4-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230104225207.1066932-1-peterx@redhat.com>
References: <20230104225207.1066932-1-peterx@redhat.com>
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

Before this patch, when there's any pgtable allocation issues happened
during change_protection(), the error will be ignored from the syscall.
For shmem, there will be an error dumped into the host dmesg.  Two issues
with that:

  (1) Doing a trace dump when allocation fails is not anything close to
      grace..

  (2) The user should be notified with any kind of such error, so the user
      can trap it and decide what to do next, either by retrying, or stop
      the process properly, or anything else.

For userfault users, this will change the API of UFFDIO_WRITEPROTECT when
pgtable allocation failure happened.  It should not normally break anyone,
though.  If it breaks, then in good ways.

One man-page update will be on the way to introduce the new -ENOMEM for
UFFDIO_WRITEPROTECT.  Not marking stable so we keep the old behavior on the
5.19-till-now kernels.

Reported-by: James Houghton <jthoughton@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h |  2 +-
 mm/hugetlb.c                  |  6 ++-
 mm/mempolicy.c                |  2 +-
 mm/mprotect.c                 | 69 +++++++++++++++++++++++------------
 mm/userfaultfd.c              | 16 +++++---
 5 files changed, 62 insertions(+), 33 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 9df0b9a762cc..3767f18114ef 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -73,7 +73,7 @@ extern ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long dst_start,
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
 			       bool enable_wp, atomic_t *mmap_changing);
-extern void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *vma,
+extern long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *vma,
 			  unsigned long start, unsigned long len, bool enable_wp);
 
 /* mm helpers */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 84bc665c7c86..d82d97e03eae 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6658,8 +6658,10 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			 * pre-allocations to install pte markers.
 			 */
 			ptep = huge_pte_alloc(mm, vma, address, psize);
-			if (!ptep)
+			if (!ptep) {
+				pages = -ENOMEM;
 				break;
+			}
 		}
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, vma, address, ptep)) {
@@ -6749,7 +6751,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	hugetlb_vma_unlock_write(vma);
 	mmu_notifier_invalidate_range_end(&range);
 
-	return pages << h->order;
+	return pages > 0 ? (pages << h->order) : pages;
 }
 
 /* Return true if reservation was successful, false otherwise.  */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a86b8f15e2f0..85a34f1f3ab8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -636,7 +636,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
 	nr_updated = change_protection(&tlb, vma, addr, end, MM_CP_PROT_NUMA);
-	if (nr_updated)
+	if (nr_updated > 0)
 		count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
 
 	tlb_finish_mmu(&tlb);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0af22ab59ea8..ade0d5f85a36 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -330,28 +330,34 @@ uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
 /*
  * If wr-protecting the range for file-backed, populate pgtable for the case
  * when pgtable is empty but page cache exists.  When {pte|pmd|...}_alloc()
- * failed it means no memory, we don't have a better option but stop.
+ * failed we treat it the same way as pgtable allocation failures during
+ * page faults by kicking OOM and returning error.
  */
 #define  change_pmd_prepare(vma, pmd, cp_flags)				\
-	do {								\
+	({								\
+		long err = 0;						\
 		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
-			if (WARN_ON_ONCE(pte_alloc(vma->vm_mm, pmd)))	\
-				break;					\
+			if (pte_alloc(vma->vm_mm, pmd))			\
+				err = -ENOMEM;				\
 		}							\
-	} while (0)
+		err;							\
+	})
+
 /*
  * This is the general pud/p4d/pgd version of change_pmd_prepare(). We need to
  * have separate change_pmd_prepare() because pte_alloc() returns 0 on success,
  * while {pmd|pud|p4d}_alloc() returns the valid pointer on success.
  */
 #define  change_prepare(vma, high, low, addr, cp_flags)			\
-	do {								\
-		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
-			low##_t *p = low##_alloc(vma->vm_mm, high, addr); \
-			if (WARN_ON_ONCE(p == NULL))			\
-				break;					\
-		}							\
-	} while (0)
+	  ({								\
+		  long err = 0;						\
+		  if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
+			  low##_t *p = low##_alloc(vma->vm_mm, high, addr); \
+			  if (p == NULL)				\
+				  err = -ENOMEM;			\
+		  }							\
+		  err;							\
+	  })
 
 static inline long change_pmd_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pud_t *pud, unsigned long addr,
@@ -367,11 +373,15 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		long this_pages;
+		long ret;
 
 		next = pmd_addr_end(addr, end);
 
-		change_pmd_prepare(vma, pmd, cp_flags);
+		ret = change_pmd_prepare(vma, pmd, cp_flags);
+		if (ret) {
+			pages = ret;
+			break;
+		}
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
@@ -401,7 +411,11 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 				 * cleared; make sure pmd populated if
 				 * necessary, then fall-through to pte level.
 				 */
-				change_pmd_prepare(vma, pmd, cp_flags);
+				ret = change_pmd_prepare(vma, pmd, cp_flags);
+				if (ret) {
+					pages = ret;
+					break;
+				}
 			} else {
 				/*
 				 * change_huge_pmd() does not defer TLB flushes,
@@ -422,9 +436,8 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		this_pages = change_pte_range(tlb, vma, pmd, addr, next,
-					      newprot, cp_flags);
-		pages += this_pages;
+		pages += change_pte_range(tlb, vma, pmd, addr, next,
+					  newprot, cp_flags);
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
@@ -443,12 +456,14 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 {
 	pud_t *pud;
 	unsigned long next;
-	long pages = 0;
+	long pages = 0, ret;
 
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		change_prepare(vma, pud, pmd, addr, cp_flags);
+		ret = change_prepare(vma, pud, pmd, addr, cp_flags);
+		if (ret)
+			return ret;
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		pages += change_pmd_range(tlb, vma, pud, addr, next, newprot,
@@ -464,12 +479,14 @@ static inline long change_p4d_range(struct mmu_gather *tlb,
 {
 	p4d_t *p4d;
 	unsigned long next;
-	long pages = 0;
+	long pages = 0, ret;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
 		next = p4d_addr_end(addr, end);
-		change_prepare(vma, p4d, pud, addr, cp_flags);
+		ret = change_prepare(vma, p4d, pud, addr, cp_flags);
+		if (ret)
+			return ret;
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		pages += change_pud_range(tlb, vma, p4d, addr, next, newprot,
@@ -486,14 +503,18 @@ static long change_protection_range(struct mmu_gather *tlb,
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	unsigned long next;
-	long pages = 0;
+	long pages = 0, ret;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
 	tlb_start_vma(tlb, vma);
 	do {
 		next = pgd_addr_end(addr, end);
-		change_prepare(vma, pgd, p4d, addr, cp_flags);
+		ret = change_prepare(vma, pgd, p4d, addr, cp_flags);
+		if (ret) {
+			pages = ret;
+			break;
+		}
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		pages += change_p4d_range(tlb, vma, pgd, addr, next, newprot,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 65ad172add27..53c3d916ff66 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -710,11 +710,12 @@ ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long start,
 			      mmap_changing, 0);
 }
 
-void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
+long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
 		   unsigned long start, unsigned long len, bool enable_wp)
 {
 	unsigned int mm_cp_flags;
 	struct mmu_gather tlb;
+	long ret;
 
 	if (enable_wp)
 		mm_cp_flags = MM_CP_UFFD_WP;
@@ -730,8 +731,10 @@ void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
 	if (!enable_wp && vma_wants_manual_pte_write_upgrade(dst_vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
 	tlb_gather_mmu(&tlb, dst_mm);
-	change_protection(&tlb, dst_vma, start, start + len, mm_cp_flags);
+	ret = change_protection(&tlb, dst_vma, start, start + len, mm_cp_flags);
 	tlb_finish_mmu(&tlb);
+
+	return ret;
 }
 
 int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
@@ -740,7 +743,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 {
 	struct vm_area_struct *dst_vma;
 	unsigned long page_mask;
-	int err;
+	long err;
 
 	/*
 	 * Sanitize the command parameters:
@@ -779,9 +782,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			goto out_unlock;
 	}
 
-	uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
+	err = uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
+
+	/* Return 0 on success, <0 on failures */
+	if (err > 0)
+		err = 0;
 
-	err = 0;
 out_unlock:
 	mmap_read_unlock(dst_mm);
 	return err;
-- 
2.37.3

