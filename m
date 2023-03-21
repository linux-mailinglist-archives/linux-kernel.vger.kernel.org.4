Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED20D6C3C21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCUUqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCUUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:46:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D17A52F60
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:46:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o7so15041633wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679431581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtTyPgAyyTCsuj6xg05jXpazWd4/Ojg4wA/2tNBdu1s=;
        b=FNfoY1JZqKacVO45/DDOogtTW4PW0fxKgBlLXtoiWkvTUfS6IQ/FQnbJJ1CFoPs0b5
         /1h8esRSWXRteL8326UpIcdEO/vAxUnsB2isAMecO/hT8OeEfGvKMWOJEuP8g0X75MGE
         zxz0EHrS/YMqvpJ5j+Vt9TNN+z2FWaady0aFglC5LJB3F2JeohyRkNpOf7t3jeBsJptx
         eQXpN1UQY8fja8NW4R6y0uTgYuN58Cw2fGTVXz/zYzDc5FfMd7xFVLzkQktNvY257Lp5
         A7PUORfPoYfC1KBNoGCr4oDKeV/9AqZt1oGH5A6SfKMOpGg+Qx5yGymyuwcPoEapxVrQ
         lQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679431581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtTyPgAyyTCsuj6xg05jXpazWd4/Ojg4wA/2tNBdu1s=;
        b=hAyvc88jGxXdwHFtfsgCUcCFiNrXZ0OQXOP3oMLdAAkH7ImwyYdpMJ/yCLY2n0Or2m
         wp/faFx1EJgJPjCZbiNBhDPxGo+Rekdl6AbFDhRF7ZyVV5traKSelkVpK9OGKr9MFqrU
         sasOnDdEh1RtcdAO3AkwNch5CotUptnITTfnDABiUv+sLgBlZnXTseITUep0V0/Q32s6
         IjTVD56vRoTQ+D8gCjIxc0bHqNnwUKMU7p5UHN5RxLjrolVqCKtmWzHdeBCCPnkGa+aE
         U/j0oCafpKBVsoSYSw5Azi3rtl+L1C5IWH3CSvaW+VYBTB4bSORl1+8NEKYR7oD5/30P
         D1XQ==
X-Gm-Message-State: AO0yUKURHdiwIkpQtzFh8KVzUdL1nPrRt32anxjQLmpT4faAw0dFqb27
        yz97A3Bj0S9cZJMjuFRtakY=
X-Google-Smtp-Source: AK7set9BnZ4bM/xxg7ypwfZc8P2cRwJfe18HibEQw4HhoYPbGmd/BqiU8iQBnCtCF4L78CAscq6zRQ==
X-Received: by 2002:a05:6000:136d:b0:2ce:a828:b248 with SMTP id q13-20020a056000136d00b002cea828b248mr3169695wrz.71.1679431581454;
        Tue, 21 Mar 2023 13:46:21 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id a4-20020adffb84000000b002d322b9a7f5sm12142491wrr.88.2023.03.21.13.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:46:20 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 1/4] mm/mmap/vma_merge: further improve prev/next VMA naming
Date:   Tue, 21 Mar 2023 20:45:55 +0000
Message-Id: <6001e08fa7e119470cbb1d2b6275ad8d742ff9a7.1679431180.git.lstoakes@gmail.com>
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

Previously the ASCII diagram above vma_merge() and the accompanying
variable naming was rather confusing, however recent efforts by Liam
Howlett and Vlastimil Babka have significantly improved matters.

This patch goes a little further - replacing 'X' with 'N' which feels a lot
more natural and replacing what was 'N' with 'C' which stands for
'concurrent' VMA.

No word quite describes a VMA that has coincident start as the input span,
concurrent, abbreviated to 'curr' (and which can be thought of also as
'current') however fits intuitions well alongside prev and next.

This has no functional impact.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
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

