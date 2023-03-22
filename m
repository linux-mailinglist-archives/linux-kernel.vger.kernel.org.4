Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486D6C5792
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjCVU3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCVU3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:29:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D75297B43
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:20:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j24so9453250wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679516347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY15Fh9kVTomLumjnxR3TB6ZLQ5YugEBgBi/gOE3sug=;
        b=ZQ6PceejuylFAZeuWprGOFSoRDVt0Iwj0nUsFklSXWKCRwXvK1cUrXL/yzWQmnjwIn
         UsqZpRbd5923H0NMAm7+A7U5N6kHp3t2BXNw8SC9cJEQWD0gkcM97TQhZKCfKYSUQn1T
         wG0MZXb9BHtfKctHehr2f7LcZKeCGruNh2Gm6/YXFUgPkOlg9dTJqo6TMayiqyAl5u+v
         f1To7VuIkEMcA4pUamUWWXEcuo8STCn8hIgVWmXUSBiOclE1dhsVfHjCADWsqYePiNOm
         AGA0+B349DQV2hdKN8o9a+dDst5P/Aqo1cRaXKsmKd4vlsFJnsOh7RvrWkbEFd7Q7iIj
         dg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679516347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY15Fh9kVTomLumjnxR3TB6ZLQ5YugEBgBi/gOE3sug=;
        b=hOm2VKZDsAEKQFqVCGY5iNEB5EJPtA44ASKaHafgxYNdVttMKkiwH1Q+d0ywGu+UrH
         YQvvdDjpT0cmsGUviwf0oPaQb5h0KdPqrvzP74JXjhkrAVh4zP8h28RvmuR0lTmER+fY
         8pxEhfV3Em5Rbp1TEKapv2XyHKgxAdxYuxklZedi+qT+7nhboWhnxyb6RQ7WN+afbdFo
         R5hIj//KbfkTXJid0MhjP/JKCfyDbHsuUHqU2zrJDJU++zXI8hR7pUiOnrn7Vi0oA2il
         RXJ6agHSxukg+iIkGObnxRkwTtuMr75pVxJR8Jgs7U0N+nVYbQkAtKfdG4A8+zxjKmKH
         GXUw==
X-Gm-Message-State: AAQBX9dfsRR5AXqgo5T9N3dxS8DQ4k2R5DjB0h2vBaQBo41PqXqE8mi2
        QdyrdrUJCr97G9GKd99se5Y=
X-Google-Smtp-Source: AKy350Z5g0xenT3KiCNPHUDl44KA69rJ6VJV0MowkeC8iAVBhljpy06Ixf24x7DC4V2Tem2gpJYoOA==
X-Received: by 2002:a5d:5083:0:b0:2ce:a0e1:f2bb with SMTP id a3-20020a5d5083000000b002cea0e1f2bbmr810767wrt.22.1679516347721;
        Wed, 22 Mar 2023 13:19:07 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e4-20020a5d4e84000000b002ceac2ccc4asm14570690wru.23.2023.03.22.13.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:19:06 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v5 3/4] mm/mmap/vma_merge: explicitly assign res, vma, extend invariants
Date:   Wed, 22 Mar 2023 20:18:59 +0000
Message-Id: <83938bed24422cbe5954bbf491341674becfe567.1679516210.git.lstoakes@gmail.com>
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

Previously, vma was an uninitialised variable which was only definitely
assigned as a result of the logic covering all possible input cases - for
it to have remained uninitialised, prev would have to be NULL, and next
would _have_ to be mergeable.

The value of res defaults to NULL, so we can neatly eliminate the
assignment to res and vma in the if (prev) block and ensure that both res
and vma are both explicitly assigned, by just setting both to prev.

In addition we add an explanation as to under what circumstances both might
change, and since we absolutely do rely on addr == curr->vm_start should
curr exist, assert that this is the case.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dbdbb92493b2..2a4f63716231 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -911,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	pgoff_t vma_pgoff;
-	struct vm_area_struct *curr, *next, *res = NULL;
+	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	int err = -1;
 	bool merge_prev = false;
@@ -939,14 +939,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	else
 		next = NULL;		/* case 5 */
 
-	/* verify some invariant that must be enforced by the caller */
+	/*
+	 * By default, we return prev. Cases 3, 4, 8 will instead return next
+	 * and cases 3, 8 will also update vma to point at next.
+	 */
+	res = vma = prev;
+
+	/* Verify some invariant that must be enforced by the caller. */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && end > curr->vm_end);
+	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
 	VM_WARN_ON(addr >= end);
 
 	if (prev) {
-		res = prev;
-		vma = prev;
 		vma_start = prev->vm_start;
 		vma_pgoff = prev->vm_pgoff;
 		/* Can we merge the predecessor? */
@@ -957,6 +961,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_prev(vmi);
 		}
 	}
+
 	/* Can we merge the successor? */
 	if (next && mpol_equal(policy, vma_policy(next)) &&
 	    can_vma_merge_before(next, vm_flags,
@@ -997,6 +1002,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			adj_start = -(prev->vm_end - addr);
 			err = dup_anon_vma(next, prev);
 		} else {
+			/*
+			 * Note that cases 3 and 8 are the ONLY ones where prev
+			 * is permitted to be (but is not necessarily) NULL.
+			 */
 			vma = next;			/* case 3 */
 			vma_start = addr;
 			vma_end = next->vm_end;
-- 
2.39.2

