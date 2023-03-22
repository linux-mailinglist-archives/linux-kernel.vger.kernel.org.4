Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5713C6C57C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCVUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjCVUfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:35:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B58A54D6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:27:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b20so45030727edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679516831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y03ABEGM1iKLlme/gXEiM5NZEzoEuVUqbJDwPp/dx0w=;
        b=AieqBZhZMkpzi7l8Xgosf+G/LZdAL0XEMXs4cyJOInXcfpx9+8LiBmQhK9QkxTdCr/
         Ze7zOBvK5HyUg+blniEH7fx2zlA9be/AaWA72NcaS0PauUJyFpavYmxGMynNDTzRfotU
         qqVsXgYwm7ePZoj1caewYJiPn8cW89WRes4Y2GgXkvk0tBSyKrjM5VfMz0JzzSIVFFZc
         MsHex2914d5u+bX8mPH8itnPhFMoDylKRiq36dOF60WY6XyC13GOhVnZWaoX/LZk3OMs
         Jdnn6JRlNH7jv0WhI8Nml/sTJyBGN+Cv99v8VLQWGojPGrH4eIkMak2R8rFQbaRAYKBt
         O6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679516831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y03ABEGM1iKLlme/gXEiM5NZEzoEuVUqbJDwPp/dx0w=;
        b=qHVn9zQ1V50Opuwg8FrHQUApYzLC+zqp7RVtJyVTQp+mOcyJowlYJmZqehsOSeMRUu
         wTqcWCzmRdKshNT6jVLyCO6/ByIxTHHxzVcz+4VVFWgzd/YK20wrHotisu60GBPEz1e3
         Is92dlg8PkFSCSemEuWGrMh1lAwccRraDjsb1lwfdDApz2hVPJAfJOZ+OaR1oaEAvcmN
         WHptSKc+OIn1R/i8A1GqOE2cXucwlLyXBQMFZQd1FQ2nruKS+xLIh61+sVPgk8E0HWsL
         BitQRafXQXrChlg68ZuUWlqOApJABZx4/cbhczugiC4XAcvHt1QuYVqYY5wD3ZRf+Sit
         LCGA==
X-Gm-Message-State: AO0yUKUWAULHEjv8RapMKbnuKP5pdRnadvwahaXbBFb4aicW0QdrAnQ3
        xlSaFUXOAgtKAcevPiuaBK0coVJ8BsM=
X-Google-Smtp-Source: AK7set+ATbzj/eQLxtCrE9dHPBKvwKXL3pNhGaIh1/xzV/CmmQiXekthknCewslVcVuOxIMnzPtpcQ==
X-Received: by 2002:a1c:6a08:0:b0:3ed:8780:f265 with SMTP id f8-20020a1c6a08000000b003ed8780f265mr561473wmc.21.1679515772745;
        Wed, 22 Mar 2023 13:09:32 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm14664342wrq.76.2023.03.22.13.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:09:31 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 4/4] mm/mmap/vma_merge: init cleanup, be explicit about the non-mergeable case
Date:   Wed, 22 Mar 2023 20:09:22 +0000
Message-Id: <d8e42182cbb879dabf49c69e86bfea80b2b5fc79.1679515236.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679515236.git.lstoakes@gmail.com>
References: <cover.1679515236.git.lstoakes@gmail.com>
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

