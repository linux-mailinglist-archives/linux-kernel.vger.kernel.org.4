Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30F6C3C24
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCUUqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCUUql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:46:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A80E52F5F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:46:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i9so15026153wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679431585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3A7zhEdmBF2TYjJBu5Iah25JwVoEB2AzBhKfUOeukc=;
        b=Si1QRuxn5Wu2XpFAVHrpMm1EIBmuD13xyfMdQ3T0gsrkBCvpixAW/BB8wP+A+sV7n3
         raxCrwZ/uVQ6B/Yr02ncqpG5sVrOxxR9G9eX1kO2NJx0UwhhMJ56+9mcSAwx5KmHhhrx
         OmvKgHySY1tnqYuaI483mHiNOomaeG/w7rcfgzX41Rh8GYzd9Oc4+UW0T+HCJ4dXnj0R
         x0eQLjTkQezRhA2mi6Kl+ZSZi/X6ar/jV+W/jamlBwfbBchWUS60IORb7tbIO6YoP35p
         fgIcKI2i54YcmMelvTnmdF0RW8x5EXzwMNZaCLICviJ1bDe4404u2iJKJuHMMOf/N4mP
         jeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679431585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3A7zhEdmBF2TYjJBu5Iah25JwVoEB2AzBhKfUOeukc=;
        b=D0qPba9W4Sn7XWSE+gulf3ve1ReKkdOpWHUUtc1d5RZeDwowvsOjK9vd9OMnXgV0yn
         K9w7A2OHP7ZJB2pS0HCyOvy0v9C004EeYdo0jur8AbD4PUSwp7R1bYi8TOtBJcRAL4qV
         9GTQii9TFYwXaY4KydEasLkgEdGkI6yaHIDi3lk0UMgj9/zrgyjGb3QbtdfkeVOnz9c1
         9J6px9sAYW5XR7sfSaXjXbgxpRdtB5726lmF6GGtJi3gx858JFJT+Cnu4AyJxUMgcgdP
         UdBqIQNt++xvbs8bHzz9TUIYJmMeXsjBlm0ZNQuu+BOjlplJgKdULdD3VkQCptM7pYQP
         NRRg==
X-Gm-Message-State: AO0yUKV5zEFJKM7ewuUWTqmmQp26Foa9Il2wwyT2RQGDCAJxq1SAGhpA
        mE6f3aW1htUWl3dg4FufM8U=
X-Google-Smtp-Source: AK7set9W3aHUuRXYHcQuSsj9Z5fSBCLJOdxD6jMlO9xE5od0fFzPTWifeNMKlIUHmt3vnU5vOUODNw==
X-Received: by 2002:a05:6000:152:b0:2cf:e3a9:c189 with SMTP id r18-20020a056000015200b002cfe3a9c189mr3835805wrx.3.1679431585581;
        Tue, 21 Mar 2023 13:46:25 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id a4-20020adffb84000000b002d322b9a7f5sm12142491wrr.88.2023.03.21.13.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:46:24 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 4/4] mm/mmap/vma_merge: init cleanup, be explicit about the non-mergeable case
Date:   Tue, 21 Mar 2023 20:45:58 +0000
Message-Id: <f5e27d1bb9259b7ef7a45099a838e47fbaaad3ab.1679431180.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679431180.git.lstoakes@gmail.com>
References: <cover.1679431180.git.lstoakes@gmail.com>
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

Reorder the initial variables sensibly and set vma_start and vm_pgoff there
rather than later so all initial values are set at the same time meaning we
don't have to set these later.

Rather than setting err = -1 and only resetting if we hit merge cases,
explicitly check the non-mergeable case to make it abundantly clear that we
only proceed with the rest if something is mergeable, default err to 0 and
only update if an error might occur.

Move the merge_prev, merge_next cases closer to the logic determining curr,
next.

This has no functional impact.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 55 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7aec49c3bc74..d60cb0b7ae15 100644
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
+	int err = 0;
 	bool merge_prev = false;
 	bool merge_next = false;
 	bool vma_expanded = false;
-	struct vma_prepare vp;
+	unsigned long vma_start = prev ? prev->vm_start : addr;
 	unsigned long vma_end = end;
+	pgoff_t vma_pgoff = prev ? prev->vm_pgoff : 0;
+	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	long adj_start = 0;
-	unsigned long vma_start = addr;
 
 	validate_mm(mm);
 	/*
@@ -940,6 +940,23 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
 		next = vma_lookup(mm, end);
 
+	/* Can we merge the predecessor? */
+	if (prev && addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
+	    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
+				   pgoff, vm_userfaultfd_ctx, anon_name)) {
+		merge_prev = true;
+		vma_prev(vmi);
+	}
+
+	/* Can we merge the successor? */
+	merge_next = next && mpol_equal(policy, vma_policy(next)) &&
+		can_vma_merge_before(next, vm_flags,
+				     anon_vma, file, pgoff+pglen,
+				     vm_userfaultfd_ctx, anon_name);
+
+	if (!merge_prev && !merge_next)
+		return NULL; /* Not mergeable. */
+
 	/*
 	 * By default, we return prev. Cases 3, 4, 8 will instead return next
 	 * and cases 3, 8 will also update vma to point at next.
@@ -951,26 +968,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
 	VM_WARN_ON(addr >= end);
 
-	if (prev) {
-		vma_start = prev->vm_start;
-		vma_pgoff = prev->vm_pgoff;
-		/* Can we merge the predecessor? */
-		if (prev->vm_end == addr && mpol_equal(vma_policy(prev), policy)
-		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
-				   pgoff, vm_userfaultfd_ctx, anon_name)) {
-			merge_prev = true;
-			vma_prev(vmi);
-		}
-	}
-
-	/* Can we merge the successor? */
-	if (next && mpol_equal(policy, vma_policy(next)) &&
-	    can_vma_merge_before(next, vm_flags,
-				 anon_vma, file, pgoff+pglen,
-				 vm_userfaultfd_ctx, anon_name)) {
-		merge_next = true;
-	}
-
 	remove = remove2 = adjust = NULL;
 	/* Can we merge both the predecessor and the successor? */
 	if (merge_prev && merge_next &&
@@ -985,7 +982,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				err = dup_anon_vma(prev, curr);
 		}
 	} else if (merge_prev) {
-		err = 0;				/* case 2 */
+							/* case 2 */
 		if (curr) {
 			err = dup_anon_vma(prev, curr);
 			if (end == curr->vm_end) {	/* case 7 */
@@ -995,7 +992,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				adj_start = (end - curr->vm_start);
 			}
 		}
-	} else if (merge_next) {
+	} else { /* merge_next */
 		res = next;
 		if (prev && addr < prev->vm_end) {	/* case 4 */
 			vma_end = addr;
@@ -1011,7 +1008,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_start = addr;
 			vma_end = next->vm_end;
 			vma_pgoff = next->vm_pgoff;
-			err = 0;
+
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
 				remove = curr;
@@ -1020,7 +1017,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		}
 	}
 
-	/* Cannot merge or error in anon_vma clone */
+	/* Error in anon_vma clone. */
 	if (err)
 		return NULL;
 
-- 
2.39.2

