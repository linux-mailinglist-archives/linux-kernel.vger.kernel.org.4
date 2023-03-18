Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6038C6BF990
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 12:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCRLPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCRLPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 07:15:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762BE366A3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:15:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w11so3671756wmo.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679138133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGH+7XD9CZf7riiQs7tokzcrN5LQH5VfpFAGRw9yBzQ=;
        b=TNBn6zG1hdBUOTzqqLTQiTtEN0JRMCO/ZKWzRMNFgj98uLt+q4k8ghjew+1pvNNue0
         WwuBPWByIjGO6uz6yW0hfU/p/UBnFVzOKoUSjnAJjKSqgICoaJmKntHF+CK5laaQom3b
         1s/U5zrnWwkkTUXUeSuRY3AQEcLUewaUMMA+mlEsxedaVkkwOotRV04GT9Lo+B5HTSnS
         WEHauh80WAubtJWn7pTBHLj2ioyNwyVm3yLeSNxz7YYMVYY3uIoL9rZGI8ai495/0CVU
         jNKdhGVgyJ0bjR8u3rwu4aVVaVpzSZg9TPbaRJ2RZbZ2iRsUekHAW24kpm90Ip/zFoXW
         ubfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679138133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGH+7XD9CZf7riiQs7tokzcrN5LQH5VfpFAGRw9yBzQ=;
        b=sTYHkpCUfnY7dYWOmDsvNfJloMKlUHzLGpq4/wefccoYLP2Yv41rOOTpf9o77lUsKQ
         pYlN5+wknw2nGVnx1fcIBk17qY241BmTi9XQ3UyB4jY8Po4Kl7n+LtQ89Spk2CYErRqf
         iOwLZ5D62UDX2zSxAz7TQnDASinWggCSwMjFd7fZHryb/eaH+NqFfcqRJ0qhEQpX3AEW
         Of79oduYT7pCVahYqvPXti74z0nL2WeVag5EOGCiQopWjbUNgg2xUH2ZLjWM55bEdtoq
         yPAAGUOsTpIgEF68rf6HCtM1gFbVWI08YbkwExrRzW3S8WcxOEhsSvymPprWVpekT99y
         euOQ==
X-Gm-Message-State: AO0yUKVP6cwewdqpn99Ur5SK5k5audXYslAUWENkyZ0H39KpZsAEpD8c
        MKh7U/Bwmnl3dezoWEobTSWr/kugvlE=
X-Google-Smtp-Source: AK7set8EFNhOT1+VWTHfriGxmv6FTPoHw/mhcihpxX6H7XQbmsH1Imd3c4T2RUMnWGoOhIvwMJ06xw==
X-Received: by 2002:a1c:ed16:0:b0:3ed:a45d:aee9 with SMTP id l22-20020a1ced16000000b003eda45daee9mr1705649wmh.39.1679138132644;
        Sat, 18 Mar 2023 04:15:32 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id n23-20020a1c7217000000b003eb68bb61c8sm4849965wmc.3.2023.03.18.04.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 04:15:31 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 4/4] mm/mmap/vma_merge: be explicit about the non-mergeable case
Date:   Sat, 18 Mar 2023 11:13:21 +0000
Message-Id: <d5fae254dc394e96860f41327f24b6ffd20cdf22.1679137163.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679137163.git.lstoakes@gmail.com>
References: <cover.1679137163.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than setting err = -1 and only resetting if we hit merge cases,
explicitly check the non-mergeable case to make it abundantly clear that we
only proceed with the rest if something is mergeable, default err to 0 and
only update if an error might occur.

Additionally set merge_next directly as there is no need for an if() {}
statement assigning a boolean.

This has no functional impact.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e60c637f4e49..2ac43b2b9a00 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -913,7 +913,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	pgoff_t vma_pgoff;
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
-	int err = -1;
+	int err = 0;
 	bool merge_prev = false;
 	bool merge_next = false;
 	bool vma_expanded = false;
@@ -1002,12 +1002,15 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	}
 
 	/* Can we merge the successor? */
-	if (next && mpol_equal(policy, vma_policy(next)) &&
-	    can_vma_merge_before(next, vm_flags,
-				 anon_vma, file, pgoff+pglen,
-				 vm_userfaultfd_ctx, anon_name)) {
-		merge_next = true;
-	}
+	merge_next = next &&
+		mpol_equal(policy, vma_policy(next)) &&
+		can_vma_merge_before(next, vm_flags,
+				     anon_vma, file, pgoff+pglen,
+				     vm_userfaultfd_ctx, anon_name);
+
+	/* Not mergeable. */
+	if (!merge_prev && !merge_next)
+		return NULL;
 
 	remove = remove2 = adjust = NULL;
 	/* Can we merge both the predecessor and the successor? */
@@ -1023,7 +1026,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				err = dup_anon_vma(prev, curr);
 		}
 	} else if (merge_prev) {
-		err = 0;				/* case 2 */
+							/* case 2 */
 		if (curr) {
 			err = dup_anon_vma(prev, curr);
 			if (end == curr->vm_end) {	/* case 7 */
@@ -1033,7 +1036,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				adj_start = (end - curr->vm_start);
 			}
 		}
-	} else if (merge_next) {
+	} else { /* merge_next */
 		res = next;
 		if (prev && addr < prev->vm_end) {	/* case 4 */
 			vma_end = addr;
@@ -1049,7 +1052,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_start = addr;
 			vma_end = next->vm_end;
 			vma_pgoff = next->vm_pgoff;
-			err = 0;
+
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
 				remove = curr;
@@ -1058,7 +1061,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		}
 	}
 
-	/* Cannot merge or error in anon_vma clone */
+	/* Error in anon_vma clone. */
 	if (err)
 		return NULL;
 
-- 
2.39.2

