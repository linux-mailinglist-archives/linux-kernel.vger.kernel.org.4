Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63F86C57D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCVUkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjCVUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:40:30 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBD72B291
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:32:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e21so7692641ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679517160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO8gjHQRXv2Un29P2Y8lUFkK9dWM8KuuH6aA4Tbj+3k=;
        b=EeQFWNrkiOs4TCDOHiEpuRynMUPCBEsj6uhBA2gbY9LlfsEkkbvugaMZHbMAHfwg91
         B+Rjy8B+OvnQCRORQ6wEu4auDzSxFBTCuCCwEr2W+bQCrn6icNih/3vVbkkQ1pYkiGj5
         Uk5G5ACj135Y4xqeAUVUYoqCmDjvqIqAkuLlxh74fMM72kHbwHdc+Y1AQ8Xtkx84WrR1
         tSeTJn35S530JA9o1tnCVMDHlOanv+Fgsb3904IP2ruzhU/kWx8Zm/S889kTL3/Dcdk2
         KQ6IvjkhRIZE/JN0rb7ax9KdguTDufb7MdNwdBQB2m/SLRKOHI63qiBlTn5dciegqJoI
         Y9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679517160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO8gjHQRXv2Un29P2Y8lUFkK9dWM8KuuH6aA4Tbj+3k=;
        b=dVPlZcdr+PG69WP5TGoIGykeQSL75mKFw7Wdbc5lrnHZgOjw+ev73qfucAtt6Ggw/b
         Rt+HINRgVfXT9cShcaSVlsf1AQDxirHB6S/yf3L9upHR4lLhC0hd2gotj54EAoqbdExM
         OHpeyjShZPm67NbxZikK1e905vecG9dSHksZqwm+miJgwQkb7vjzANuSOQM56MP5k/Fn
         eTd/h8Ou47FCyEjo2uI74aBSxKSEu/YE9m5qfwZUH6aVRXpBpK+Okj3Wwx/5akQEOU7J
         rmsXf0y7yd8Z6r9fBrH1co7LmzlhnsyOtVYxm5+ycD4cRlSqbvhjzMrp+wwp0TzMAYWA
         tieA==
X-Gm-Message-State: AO0yUKWbI+PHyXLLdnF5IAGpNzWNBDPUznm+PS72HU7jB1kknKd71IR9
        ydxvmN84bXp33LIUCPiT2BRMK4oxHKQ=
X-Google-Smtp-Source: AKy350ZLTIGfCV6fdBxFd0X0dP8OaZ/Cl+FnHq0weu4JUEjS5hyROEdcB6yDw7AwuS5EnTjGfz8ewA==
X-Received: by 2002:adf:f552:0:b0:2cf:f0c3:79ba with SMTP id j18-20020adff552000000b002cff0c379bamr770127wrp.67.1679516346246;
        Wed, 22 Mar 2023 13:19:06 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e4-20020a5d4e84000000b002ceac2ccc4asm14570690wru.23.2023.03.22.13.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:19:05 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v5 2/4] mm/mmap/vma_merge: fold curr, next assignment logic
Date:   Wed, 22 Mar 2023 20:18:58 +0000
Message-Id: <c6d960641b4ba58fa6ad3d07bf68c27d847963c8.1679516210.git.lstoakes@gmail.com>
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

Use find_vma_intersection() and vma_lookup() to both simplify the logic and
to fold the end == next->vm_start condition into one block.

This groups all of the simple range checks together and establishes the
invariant that, if prev, curr or next are non-NULL then their positions are
as expected.

This has no functional impact.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c9834364ac98..dbdbb92493b2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -930,15 +930,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
-	curr = find_vma(mm, prev ? prev->vm_end : 0);
-	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
-		next = find_vma(mm, curr->vm_end);
-	else
-		next = curr;
+	/* Does the input range span an existing VMA? (cases 5 - 8) */
+	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
 
-	/* In cases 1 - 4 there's no CCCC vma */
-	if (curr && end <= curr->vm_start)
-		curr = NULL;
+	if (!curr ||			/* cases 1 - 4 */
+	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
+		next = vma_lookup(mm, end);
+	else
+		next = NULL;		/* case 5 */
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
@@ -959,11 +958,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		}
 	}
 	/* Can we merge the successor? */
-	if (next && end == next->vm_start &&
-			mpol_equal(policy, vma_policy(next)) &&
-			can_vma_merge_before(next, vm_flags,
-					     anon_vma, file, pgoff+pglen,
-					     vm_userfaultfd_ctx, anon_name)) {
+	if (next && mpol_equal(policy, vma_policy(next)) &&
+	    can_vma_merge_before(next, vm_flags,
+				 anon_vma, file, pgoff+pglen,
+				 vm_userfaultfd_ctx, anon_name)) {
 		merge_next = true;
 	}
 
-- 
2.39.2

