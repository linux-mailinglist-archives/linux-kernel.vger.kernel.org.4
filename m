Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B643A6C5795
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCVU3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCVU3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:29:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98397FF2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:20:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v1so12247684wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679516349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y03ABEGM1iKLlme/gXEiM5NZEzoEuVUqbJDwPp/dx0w=;
        b=JuadwNsIZE2z/zJh7KttoUHsZSOV64bXHf0wYV3NZRNw5P46APeVp2CD4NtQ/UNFTD
         lXrA+LRbhk9k2I23hap3SdJ90UMtx27o1hpcOQ+E0v8OsA6ztAd10VE7wDFuG1PnVb8J
         OyEMM8C0lVxo86bSnXgbpTyxmeTW34oOYu6U5MhfG0xdl7V7x16YSoIGdkFexrHIp1Dy
         kDv1lJ6sWMoFMZIYcBvT07cPXsPHRZ5utbgYPAdba1yjeP3JSnWVG548i+FYJI0YDVSz
         BWK9c4xb0xohwyvPbD/QU6s1alH+WhC112pmLlMbykAMnICx14EfTpYTP5tYgXQFrbDT
         GsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679516349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y03ABEGM1iKLlme/gXEiM5NZEzoEuVUqbJDwPp/dx0w=;
        b=c2ALxr4BMSArcce01mwN3RvNGo1hvkUQh/lVPcxZevhFuv/Ag28gJndNptkw4268gc
         YonZNXD282J5woSzU8yTjT7N/vmlGTo63y2HNi+XOvwn0ka3e7HaY0JCqBVmesd36Xgq
         j4oX1gKGyfSGgfSf/1Y6oZO9EpupT8xn+OiT53Slr/gZDvwOIdnWp35TfTY0ZMTHzS1D
         CxFqSAnoE30KrBC/aTiFqFtytpuhJHl2FpmwVo9Yipc58Vc/Z+deNW97REZbwWdq/US6
         TLb/PVOfEOaewNJhkVDjnzs+dZ2kmoTE4xxqzyy29AVKtTIaRhxiDf4qCR/cVpOcCbU4
         c7Rw==
X-Gm-Message-State: AAQBX9fokiu9LWqBeRifVNsmXxwatzFAYz4nSM1w5MRxp8fjA9eK67Xc
        NWJmLH0sSiAYKc1CoAhQaYo=
X-Google-Smtp-Source: AKy350YjSXpKJOG/me9kHcIbf3a1DDS+FBHwNhe1vy7I5CQPb9fmUP37fZXOYz52TdKxRyZGjr1yuQ==
X-Received: by 2002:a5d:640b:0:b0:2cf:ee9d:ce2f with SMTP id z11-20020a5d640b000000b002cfee9dce2fmr923855wru.19.1679516349137;
        Wed, 22 Mar 2023 13:19:09 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e4-20020a5d4e84000000b002ceac2ccc4asm14570690wru.23.2023.03.22.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:19:08 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v5 4/4] mm/mmap/vma_merge: init cleanup, be explicit about the non-mergeable case
Date:   Wed, 22 Mar 2023 20:19:00 +0000
Message-Id: <99259fbc6403e80e270e1cc4612abbc8620b121b.1679516210.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679516210.git.lstoakes@gmail.com>
References: <cover.1679516210.git.lstoakes@gmail.com>
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
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2a4f63716231..1064e6341a7a 100644
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
@@ -939,24 +939,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
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
@@ -964,13 +954,22 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 
 	/* Can we merge the successor? */
 	if (next && mpol_equal(policy, vma_policy(next)) &&
-	    can_vma_merge_before(next, vm_flags,
-				 anon_vma, file, pgoff+pglen,
+	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
 				 vm_userfaultfd_ctx, anon_name)) {
 		merge_next = true;
 	}
 
+	if (!merge_prev && !merge_next)
+		return NULL; /* Not mergeable. */
+
+	res = vma = prev;
 	remove = remove2 = adjust = NULL;
+
+	/* Verify some invariant that must be enforced by the caller. */
+	VM_WARN_ON(prev && addr <= prev->vm_start);
+	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
+	VM_WARN_ON(addr >= end);
+
 	/* Can we merge both the predecessor and the successor? */
 	if (merge_prev && merge_next &&
 	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
@@ -983,8 +982,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			if (!next->anon_vma)
 				err = dup_anon_vma(prev, curr);
 		}
-	} else if (merge_prev) {
-		err = 0;				/* case 2 */
+	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
 			err = dup_anon_vma(prev, curr);
 			if (end == curr->vm_end) {	/* case 7 */
@@ -994,7 +992,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				adj_start = (end - curr->vm_start);
 			}
 		}
-	} else if (merge_next) {
+	} else { /* merge_next */
 		res = next;
 		if (prev && addr < prev->vm_end) {	/* case 4 */
 			vma_end = addr;
@@ -1010,7 +1008,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_start = addr;
 			vma_end = next->vm_end;
 			vma_pgoff = next->vm_pgoff;
-			err = 0;
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
 				remove = curr;
@@ -1019,7 +1016,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		}
 	}
 
-	/* Cannot merge or error in anon_vma clone */
+	/* Error in anon_vma clone. */
 	if (err)
 		return NULL;
 
-- 
2.39.2

