Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254C26C5776
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCVU0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjCVU0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:26:01 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21076A768B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:16:00 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso13757355wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679515768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7U4rZ5ngeaMtEfGvEeiH442bzXxl021xaQINSP+F4Q=;
        b=Yy6NlxAp+t90djnlr0eKV1vtFIoIX7OHUPxsR1HJ3ftdUyCMx5/khrzPHAD+d7jdEU
         G1DSXbJK+DDYqs2RNZh6JIuYiiPX4CgTuYuqAQSpIOIwIJMTEdzfyevhTmxuUEND5sRs
         pE00bBiFEGLKsqOVZZqyzdT27HdQB6Sf/4cW5TDg5bF6QlfhtVkb3X6wkamlU8KVxnWP
         gLdPGDEP9tkOEHjadj8mtZX53YWG0SkG9NomSe7bBrOW0aL4eTJKLtXVk8Q9OgcB/Xk5
         82T7/PMyibkSk76+S5r3k2MQx+RgqKpw+hUpCdqCrCm1Y69ZY7d5nM4XLYL0U56k7LaT
         jZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7U4rZ5ngeaMtEfGvEeiH442bzXxl021xaQINSP+F4Q=;
        b=f0RBVJqiPnh9DUyyjgXYYFTc7Pr05TTQQJ9uiCOs3zLxoF1l7LilTvJvNBhNlA5IPZ
         Vuf6fwpeBqZvkd1kgGTU1DzA2s39dGUYoAAfMw3TBagMO4KuEZam4lJAMtpQlwBriA3N
         FqewundQ1EOBogQWD8+LHqFbveytzG3ygzuI52OaMLqjtTH+qBkFloeUgXc+fchjyaYQ
         68SNbV1HW/FI5KQgnCHJiBZMZNE6WWmS1FYHmoXg1U/1lb4Iy4SU4SmOVynOFzu8yGw6
         chBBZHQEvNFaZgZpt9kI91j6QFJaPv6IATNSiWfM64PTfVovyj18IOiG0Ewt6zwvKFqP
         uHVA==
X-Gm-Message-State: AO0yUKUI/XzUZwziGeam+OuwqSZlYuQCNrlM2MZO0nhB0Zz08GWn+6Re
        fXP10WUr0be3HbzCP88VAvg=
X-Google-Smtp-Source: AK7set+f58badNiN6DJ4tP10METXdPN2qjZAcVNqZ75G88ztSZtS34CbtuPl8EyvVLqkvQBmyrqXHQ==
X-Received: by 2002:a7b:ce16:0:b0:3ee:d7f:6676 with SMTP id m22-20020a7bce16000000b003ee0d7f6676mr565890wmc.11.1679515768327;
        Wed, 22 Mar 2023 13:09:28 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm14664342wrq.76.2023.03.22.13.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:09:27 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 1/4] mm/mmap/vma_merge: further improve prev/next VMA naming
Date:   Wed, 22 Mar 2023 20:09:19 +0000
Message-Id: <98e8a31ab0f72e8fc31d6045efbc7eeac1c07e0a.1679515236.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679515236.git.lstoakes@gmail.com>
References: <cover.1679515236.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the ASCII diagram above vma_merge() and the accompanying
variable naming was rather confusing, however recent efforts by Liam
Howlett and Vlastimil Babka have significantly improved matters.

This patch goes a little further - replacing 'A' with '*' as it is clearer,
'X' with 'N', which feels more natural as this represents the _next_ VMA
and infalyl 'N' with 'C' which represents the current VMA.

No word quite describes a VMA that has coincident start as the input span,
however 'concurrent' (or more simply 'current') abbreviated to 'curr' fits
intuitions well alongside prev and next.

This has no functional impact.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 86 +++++++++++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 042d22e63528..c9834364ac98 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -861,44 +861,44 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  * this area are about to be changed to vm_flags - and the no-change
  * case has already been eliminated.
  *
- * The following mprotect cases have to be considered, where AAAA is
+ * The following mprotect cases have to be considered, where **** is
  * the area passed down from mprotect_fixup, never extending beyond one
- * vma, PPPP is the previous vma, NNNN is a vma that starts at the same
- * address as AAAA and is of the same or larger span, and XXXX the next
- * vma after AAAA:
+ * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
+ * at the same address as **** and is of the same or larger span, and
+ * NNNN the next vma after ****:
  *
- *     AAAA             AAAA                   AAAA
- *    PPPPPPXXXXXX    PPPPPPXXXXXX       PPPPPPNNNNNN
+ *     ****             ****                   ****
+ *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
  *    cannot merge    might become       might become
- *                    PPXXXXXXXXXX       PPPPPPPPPPNN
+ *                    PPNNNNNNNNNN       PPPPPPPPPPCC
  *    mmap, brk or    case 4 below       case 5 below
  *    mremap move:
- *                        AAAA               AAAA
- *                    PPPP    XXXX       PPPPNNNNXXXX
+ *                        ****               ****
+ *                    PPPP    NNNN       PPPPCCCCNNNN
  *                    might become       might become
  *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
- *                    PPPPPPPPXXXX 2 or  PPPPPPPPXXXX 7 or
- *                    PPPPXXXXXXXX 3     PPPPXXXXXXXX 8
+ *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
+ *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
  *
- * It is important for case 8 that the vma NNNN overlapping the
- * region AAAA is never going to extended over XXXX. Instead XXXX must
- * be extended in region AAAA and NNNN must be removed. This way in
+ * It is important for case 8 that the vma CCCC overlapping the
+ * region **** is never going to extended over NNNN. Instead NNNN must
+ * be extended in region **** and CCCC must be removed. This way in
  * all cases where vma_merge succeeds, the moment vma_merge drops the
  * rmap_locks, the properties of the merged vma will be already
  * correct for the whole merged range. Some of those properties like
  * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
  * be correct for the whole merged range immediately after the
- * rmap_locks are released. Otherwise if XXXX would be removed and
- * NNNN would be extended over the XXXX range, remove_migration_ptes
+ * rmap_locks are released. Otherwise if NNNN would be removed and
+ * CCCC would be extended over the NNNN range, remove_migration_ptes
  * or other rmap walkers (if working on addresses beyond the "end"
- * parameter) may establish ptes with the wrong permissions of NNNN
- * instead of the right permissions of XXXX.
+ * parameter) may establish ptes with the wrong permissions of CCCC
+ * instead of the right permissions of NNNN.
  *
  * In the code below:
  * PPPP is represented by *prev
- * NNNN is represented by *mid or not represented at all (NULL)
- * XXXX is represented by *next or not represented at all (NULL)
- * AAAA is not represented - it will be merged and the vma containing the
+ * CCCC is represented by *curr or not represented at all (NULL)
+ * NNNN is represented by *next or not represented at all (NULL)
+ * **** is not represented - it will be merged and the vma containing the
  *      area is returned, or the function will return NULL
  */
 struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
@@ -911,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	pgoff_t vma_pgoff;
-	struct vm_area_struct *mid, *next, *res = NULL;
+	struct vm_area_struct *curr, *next, *res = NULL;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	int err = -1;
 	bool merge_prev = false;
@@ -930,19 +930,19 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
-	mid = find_vma(mm, prev ? prev->vm_end : 0);
-	if (mid && mid->vm_end == end)			/* cases 6, 7, 8 */
-		next = find_vma(mm, mid->vm_end);
+	curr = find_vma(mm, prev ? prev->vm_end : 0);
+	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
+		next = find_vma(mm, curr->vm_end);
 	else
-		next = mid;
+		next = curr;
 
-	/* In cases 1 - 4 there's no NNNN vma */
-	if (mid && end <= mid->vm_start)
-		mid = NULL;
+	/* In cases 1 - 4 there's no CCCC vma */
+	if (curr && end <= curr->vm_start)
+		curr = NULL;
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(mid && end > mid->vm_end);
+	VM_WARN_ON(curr && end > curr->vm_end);
 	VM_WARN_ON(addr >= end);
 
 	if (prev) {
@@ -974,21 +974,21 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		remove = next;				/* case 1 */
 		vma_end = next->vm_end;
 		err = dup_anon_vma(prev, next);
-		if (mid) {				/* case 6 */
-			remove = mid;
+		if (curr) {				/* case 6 */
+			remove = curr;
 			remove2 = next;
 			if (!next->anon_vma)
-				err = dup_anon_vma(prev, mid);
+				err = dup_anon_vma(prev, curr);
 		}
 	} else if (merge_prev) {
 		err = 0;				/* case 2 */
-		if (mid) {
-			err = dup_anon_vma(prev, mid);
-			if (end == mid->vm_end) {	/* case 7 */
-				remove = mid;
+		if (curr) {
+			err = dup_anon_vma(prev, curr);
+			if (end == curr->vm_end) {	/* case 7 */
+				remove = curr;
 			} else {			/* case 5 */
-				adjust = mid;
-				adj_start = (end - mid->vm_start);
+				adjust = curr;
+				adj_start = (end - curr->vm_start);
 			}
 		}
 	} else if (merge_next) {
@@ -1004,10 +1004,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_end = next->vm_end;
 			vma_pgoff = next->vm_pgoff;
 			err = 0;
-			if (mid) {			/* case 8 */
-				vma_pgoff = mid->vm_pgoff;
-				remove = mid;
-				err = dup_anon_vma(next, mid);
+			if (curr) {			/* case 8 */
+				vma_pgoff = curr->vm_pgoff;
+				remove = curr;
+				err = dup_anon_vma(next, curr);
 			}
 		}
 	}
-- 
2.39.2

