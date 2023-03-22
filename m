Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E686C43E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCVHNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCVHNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:13:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83812C15D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:13:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l27so7627366wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679469194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvFBIxJBVhEXBKtp0GyumQnQIP5EEIPfuNuIT/IqlfQ=;
        b=WU0Up1Atx5XiF6ihkQphvxLDKelfbEV7zI44fcBWhRcywxkEM9D8YFzEkjv/AuAiSE
         MqLuw8erhiWW04wTbEzZ5evEJmnIRqwxU+3w13Ww3I7m9FvHsLxWUnw3Ov4P8s6axbpS
         khizdR1MTgf1kxPKJXIUZHB77i2iQ5h5xK/dm92xIu/Qx/DY25UH356zxAK+dROABkAD
         9ZxBYOeCn5YByRWL4dodJBXu8gUviS1Gp+OJnEAl3x64LdrGo2FvpKPZRZHeSN2OgXlj
         8rA0dDPLB0PeBAO2AlSTcBXL8xQNquF2RiUOYf3qq/qFE1MvTSOLwzhUlhHQHyT8EsyR
         Aszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679469194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvFBIxJBVhEXBKtp0GyumQnQIP5EEIPfuNuIT/IqlfQ=;
        b=wKk+MnzFsXgwB5Wo1xwWMkEFw5xXKIu4z27tsI/xuUT7Sr0ECGTdwXUN7FLnRDy9WB
         pCC5halqEzEfZxY3pgxyoNigA82W/StvQdt03Rrj70asX/UWHIB1y7xpvRDRHZWLOerV
         oZ8AvlkPI5KLGGEXYnduBgJBZa/1CbsbHHdmMdwIC23iOvH7B+WjMH/g6jyXT79Zkbrg
         BGBOtOVLY93t6plLxgdB7wPOYkojeZHcRGBdvLrVMeDmITTnL6p4ydWTVjYbYm141ltO
         M2cgHfdLYnlMYyQ0wbqcqqww903yVsk5tIZBbJTdv248Sg0MfFpUsITZLbeXMeDH0WB0
         dq3g==
X-Gm-Message-State: AO0yUKWLUwX/KjTCopU67msgirUr39mkSItHP1gFwrxqMwWUckeaAHkV
        u9UXu0l0JxLy2SZCqTdzFf8=
X-Google-Smtp-Source: AK7set8jNLy29ur/RroRVTTwctIeW0rEOeiVjYe/lX9TZQAL5pa7DOsvlPVneVSIl0I9sWTIMHaTFg==
X-Received: by 2002:a5d:4c84:0:b0:2da:45b6:a1d5 with SMTP id z4-20020a5d4c84000000b002da45b6a1d5mr1025831wrs.3.1679469194044;
        Wed, 22 Mar 2023 00:13:14 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id u4-20020a5d4344000000b002c5526234d2sm13290279wrr.8.2023.03.22.00.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 00:13:13 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 4/4] mm/mmap/vma_merge: init cleanup, be explicit about the non-mergeable case
Date:   Wed, 22 Mar 2023 07:13:04 +0000
Message-Id: <ae4845250ae9e7d000ca28fe90e64a331f664ce2.1679468982.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679468982.git.lstoakes@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than setting err = -1 and only resetting if we hit merge cases,
explicitly check the non-mergeable case to make it abundantly clear that we
only proceed with the rest if something is mergeable, default err to 0 and
only update if an error might occur.

Move the merge_prev, merge_next cases closer to the logic determining curr,
next and reorder initial variables so they are more logically grouped.

This has no functional impact.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 57 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2a4f63716231..642f3d063be1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -909,18 +909,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
 			struct anon_vma_name *anon_name)
 {
-	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
-	pgoff_t vma_pgoff;
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
-	int err = -1;
+	struct vma_prepare vp;
+	pgoff_t vma_pgoff;
+	int err = 0;
 	bool merge_prev = false;
 	bool merge_next = false;
 	bool vma_expanded = false;
-	struct vma_prepare vp;
+	unsigned long vma_start = addr;
 	unsigned long vma_end = end;
+	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	long adj_start = 0;
-	unsigned long vma_start = addr;
 
 	validate_mm(mm);
 	/*
@@ -939,36 +939,38 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	else
 		next = NULL;		/* case 5 */
 
-	/*
-	 * By default, we return prev. Cases 3, 4, 8 will instead return next
-	 * and cases 3, 8 will also update vma to point at next.
-	 */
-	res = vma = prev;
-
-	/* Verify some invariant that must be enforced by the caller. */
-	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
-	VM_WARN_ON(addr >= end);
-
 	if (prev) {
 		vma_start = prev->vm_start;
 		vma_pgoff = prev->vm_pgoff;
+
 		/* Can we merge the predecessor? */
-		if (prev->vm_end == addr && mpol_equal(vma_policy(prev), policy)
+		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
 		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
-				   pgoff, vm_userfaultfd_ctx, anon_name)) {
+					   pgoff, vm_userfaultfd_ctx, anon_name)) {
 			merge_prev = true;
 			vma_prev(vmi);
 		}
 	}
 
 	/* Can we merge the successor? */
-	if (next && mpol_equal(policy, vma_policy(next)) &&
-	    can_vma_merge_before(next, vm_flags,
-				 anon_vma, file, pgoff+pglen,
-				 vm_userfaultfd_ctx, anon_name)) {
-		merge_next = true;
-	}
+	merge_next = next && mpol_equal(policy, vma_policy(next)) &&
+		can_vma_merge_before(next, vm_flags,
+				     anon_vma, file, pgoff+pglen,
+				     vm_userfaultfd_ctx, anon_name);
+
+	if (!merge_prev && !merge_next)
+		return NULL; /* Not mergeable. */
+
+	/*
+	 * By default, we return prev. Cases 3, 4, 8 will instead return next
+	 * and cases 3, 8 will also update vma to point at next.
+	 */
+	res = vma = prev;
+
+	/* Verify some invariant that must be enforced by the caller. */
+	VM_WARN_ON(prev && addr <= prev->vm_start);
+	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
+	VM_WARN_ON(addr >= end);
 
 	remove = remove2 = adjust = NULL;
 	/* Can we merge both the predecessor and the successor? */
@@ -984,7 +986,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				err = dup_anon_vma(prev, curr);
 		}
 	} else if (merge_prev) {
-		err = 0;				/* case 2 */
+							/* case 2 */
 		if (curr) {
 			err = dup_anon_vma(prev, curr);
 			if (end == curr->vm_end) {	/* case 7 */
@@ -994,7 +996,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				adj_start = (end - curr->vm_start);
 			}
 		}
-	} else if (merge_next) {
+	} else { /* merge_next */
 		res = next;
 		if (prev && addr < prev->vm_end) {	/* case 4 */
 			vma_end = addr;
@@ -1010,7 +1012,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_start = addr;
 			vma_end = next->vm_end;
 			vma_pgoff = next->vm_pgoff;
-			err = 0;
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
 				remove = curr;
@@ -1019,7 +1020,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		}
 	}
 
-	/* Cannot merge or error in anon_vma clone */
+	/* Error in anon_vma clone. */
 	if (err)
 		return NULL;
 
-- 
2.39.2

