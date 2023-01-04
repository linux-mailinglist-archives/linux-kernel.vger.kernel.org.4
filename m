Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D965E0EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjADX0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjADXZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:25:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD344365
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 15:19:24 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-45e2e1d6d2fso358665617b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 15:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hsTeCtDlD4kOcnEo+TQdmsNYr+o2yfE7y3Ola08DhEw=;
        b=Ua1Z5pOjsPwoBKo57uGgeQCHC1YUvPLHUZcDo9RH+vMEkr5v0R1UhMNZ4BvJBT/0NK
         ix8Hf2D0krQcl7Ux30RbnMLFcwvniN6q5lcsbaSJQBvCGBaU1lOWQ6HBflcMmudrZRaC
         uIBh6bt0DuuJ2Jihyku+CPw1gVStE+8gqVQcqACmfczzhoxdXH9uQbDg2V6cQFVD8f3R
         6rlO+E5zXn0LQm4yPfAyTpJwQGGARUOKDfUd/qFDIXiyPV1hgxcqrfUgQAOxYs4CoX8B
         z8hdgnEznug7GJtO22B5TiETOSHrsge9pczW7fda3vXPRIRhCfFqSiyr3wY+gc532q9j
         jo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsTeCtDlD4kOcnEo+TQdmsNYr+o2yfE7y3Ola08DhEw=;
        b=QAwedwbFOe7+1htNfk3ZMsT1cJQIzYCfjuCzd6uj0BqjZkOh/rDCnGmot7YTHPkt/O
         FgP7WBNiNfuPUtcubIUSoa/7JU7fz8sgnXdxwZdR/NBgZu0O4pWjRAjPhpqwwxRINKMJ
         MIT7cIdb7yfXnA34twGd9lOtTsZafJFZ2zpE279opdG6lEG0meHPOtq4QPXBT8CR9lPK
         rrgG84EuyFwewUm/tPkkuNtoNUBwvVrNNS2mPY8PRnRIT0fNmAqmvuei8GjbdGjoaJKf
         P4ROg9K2AvC7zcRqztgxpiFlisJUmNnegUVcVCXKvDx5W9HsVt95ZdjMwK6kg3SyMYh3
         KZsg==
X-Gm-Message-State: AFqh2kpY0vKx8GR6CyNpDRBMc2CuDPrNmG/7JVLOGblz/tXzhUyP5/UJ
        6FntYPsfvsc1eaKCc6bfgOqM6A0hBDX03kKa
X-Google-Smtp-Source: AMrXdXsv1fwnxSmx96jF1r3m7J1UJjdBH9+gQsfU8IsTxGlJloYYZautPOjaDrGIKAu/GMjNbJVjicFYIQSwthmm
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:17d5:0:b0:480:fa10:459e with SMTP
 id 204-20020a8117d5000000b00480fa10459emr2376956ywx.283.1672874363730; Wed,
 04 Jan 2023 15:19:23 -0800 (PST)
Date:   Wed,  4 Jan 2023 23:19:10 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104231910.1464197-1-jthoughton@google.com>
Subject: [PATCH v2] hugetlb: unshare some PMDs when splitting VMAs
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMD sharing can only be done in PUD_SIZE-aligned pieces of VMAs;
however, it is possible that HugeTLB VMAs are split without unsharing
the PMDs first.

Without this fix, it is possible to hit the uffd-wp-related WARN_ON_ONCE
in hugetlb_change_protection [1]. The key there is that
hugetlb_unshare_all_pmds will not attempt to unshare PMDs in
non-PUD_SIZE-aligned sections of the VMA.

It might seem ideal to unshare in hugetlb_vm_op_open, but we need to
unshare in both the new and old VMAs, so unsharing in
hugetlb_vm_op_split seems natural.

[1]: https://lore.kernel.org/linux-mm/CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com/

Fixes: 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when register wp")
Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b39b74e0591a..b6976da0fa4d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -94,6 +94,8 @@ static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
+static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -4828,6 +4830,25 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	if (addr & ~(huge_page_mask(hstate_vma(vma))))
 		return -EINVAL;
+
+	/*
+	 * PMD sharing is only possible for PUD_SIZE-aligned address ranges
+	 * in HugeTLB VMAs. If we will lose PUD_SIZE alignment due to this
+	 * split, unshare PMDs in the PUD_SIZE interval surrounding addr now.
+	 */
+	if (addr & ~PUD_MASK) {
+		/*
+		 * hugetlb_vm_op_split is called right before we attempt to
+		 * split the VMA. We will need to unshare PMDs in the old and
+		 * new VMAs, so let's unshare before we split.
+		 */
+		unsigned long floor = addr & PUD_MASK;
+		unsigned long ceil = floor + PUD_SIZE;
+
+		if (floor >= vma->vm_start && ceil <= vma->vm_end)
+			hugetlb_unshare_pmds(vma, floor, ceil);
+	}
+
 	return 0;
 }
 
@@ -7313,26 +7334,21 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
 	}
 }
 
-/*
- * This function will unconditionally remove all the shared pmd pgtable entries
- * within the specific vma for a hugetlbfs memory range.
- */
-void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
+static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
+				   unsigned long start,
+				   unsigned long end)
 {
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
 	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_notifier_range range;
-	unsigned long address, start, end;
+	unsigned long address;
 	spinlock_t *ptl;
 	pte_t *ptep;
 
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return;
 
-	start = ALIGN(vma->vm_start, PUD_SIZE);
-	end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
-
 	if (start >= end)
 		return;
 
@@ -7364,6 +7380,16 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	mmu_notifier_invalidate_range_end(&range);
 }
 
+/*
+ * This function will unconditionally remove all the shared pmd pgtable entries
+ * within the specific vma for a hugetlbfs memory range.
+ */
+void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
+{
+	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
+			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
+}
+
 #ifdef CONFIG_CMA
 static bool cma_reserve_called __initdata;
 
-- 
2.39.0.314.g84b9a713c41-goog

