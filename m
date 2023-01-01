Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6036865AC5B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 00:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjAAXBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 18:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAXBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 18:01:08 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D3C101F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 15:01:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-45c1b233dd7so280652957b3.20
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 15:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KIoFTjTTjDz9d1b1yxyyUqxAJ41QzJduAZlhlKAINmQ=;
        b=QaXUiWn3XNUQEd6ip4vKheFQ35b9GlV46CrIuxtdTNeswfec+k/oSdlTKQJTDN7laS
         IXWJ84jgV80eS0dFPfxIK9buoMDZri3O1HyL8J3CvF+RGrFVhngmPoLHGwHlrLXDHT+W
         6GMJ+zRQMhOyC8Dnd5ktYf2ujXYes76nARhGdQj/ZVMKhLQGWvNYqV6A8hBMZmxlPDdT
         Hxt98MeLSanNiBXBhi+ypdRnxFptGyezj8WV6BzlPslY7fuHXAGpzj3tDkvUtgsBz6zH
         h0TvosJg0ov2IxUEC24zMpQicQzUeWMR9gwaVEXy8nQ08c+3cb5sUSic/HIVU7zs0iuz
         YuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIoFTjTTjDz9d1b1yxyyUqxAJ41QzJduAZlhlKAINmQ=;
        b=E1VDkyIrj3cy95Xfor8rv1LOLb5CAwD4QXobWOfP+WgPPeJPlw//ZTAAaryx4JF4pP
         2TwHKqofSpPW4s3fcLi8a9GAHHgEhTD6ncPRe6vZVfVlBGAMNPHM94aVsqyobFzd2lGw
         zp97Ttez60ibeyOFZqrp6l/agr5mCpaj2ZOAhM/9yjgZjUgqebG2v/cuRTVeNofcjcw3
         52vYtmrdskgJ63Zqk1ktYI+jmH6aySUEqxOdkwUfzSVjdrS3AgvbQpkWxyJ8kkGBmipm
         bO6x1rWnq/j97i0+6jydydUhkA0uRX56afcpeW6D5/5uDzHzj2b2d9v6Sb6O3f3NAjNt
         Ak5g==
X-Gm-Message-State: AFqh2kpAPjNfkvh1e9hJf9Re21aqobj+CGZ3OUDEzf9pDRm6ay79sD1T
        gE4MwyqM68d8eowYWGPvLXMz4Kn+EvVh9pNe
X-Google-Smtp-Source: AMrXdXtqLpmC78soBcB8I1zQEwTynK8DAlqR/NEcP2QFzw0OMk8ECD9RqgeIJpwa8I6bqpXFoQ1rPVNSvTlCUnSQ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:79f:b0:3c4:1f67:a2a2 with SMTP
 id bw31-20020a05690c079f00b003c41f67a2a2mr4768867ywb.234.1672614064278; Sun,
 01 Jan 2023 15:01:04 -0800 (PST)
Date:   Sun,  1 Jan 2023 23:00:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230101230042.244286-1-jthoughton@google.com>
Subject: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
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

In some (most?) cases, this is a non-issue, like userfaultfd_register
and mprotect, where PMDs are unshared before anything is done. However,
mbind() and madvise() (like MADV_DONTDUMP) can cause a split without
unsharing first.

It might seem ideal to unshare in hugetlb_vm_op_open, but that would
only unshare PMDs in the new VMA.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b39b74e0591a..bf7a1f628357 100644
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
@@ -4828,6 +4830,23 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	if (addr & ~(huge_page_mask(hstate_vma(vma))))
 		return -EINVAL;
+
+	/* We require PUD_SIZE VMA alignment for PMD sharing. */
+	if (addr & ~PUD_MASK) {
+		/*
+		 * hugetlb_vm_op_split is called right before we attempt to
+		 * split the VMA. We will need to unshare PMDs in the old and
+		 * new VMAs, so let's unshare before we split.
+		 */
+		unsigned long floor = addr & PUD_MASK;
+		unsigned long ceil = floor + PUD_SIZE;
+
+		if (floor < vma->vm_start || ceil >= vma->vm_end)
+			/* PMD sharing is already impossible. */
+			return 0;
+		hugetlb_unshare_pmds(vma, floor, ceil);
+	}
+
 	return 0;
 }
 
@@ -7313,26 +7332,21 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
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
 
@@ -7364,6 +7378,16 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
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

