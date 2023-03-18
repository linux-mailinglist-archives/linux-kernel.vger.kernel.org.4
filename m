Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D386BF98E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 12:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCRLPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 07:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRLPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 07:15:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F653288
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:15:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso4784405wmo.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679138130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZlYT4yL6gG4aiu138Y6FqESLQRK9cKcNW+GTnQ4unA=;
        b=L6ZXj/o770m/a9MHhvqQP482KOTn/Lj9NjwPG2bsh3o+0lng/DLoGaGTRkkVC48X0U
         SEE5gUJVG4i9Bf2BJXChg2NvzUjyZNhT4dxwYM5inETsttenJ7OqCzo4V0NO0IhfbvHo
         kMmW5nJI0TFVYuNdPATbt+lnGhuqOdor7VhBo+1NePZK+MDnfikpIj79rkSQ/xLIewnJ
         ubaMjhza6pr7HR9PLLkoemCwGs9j9AgO0eY2zP3v+FEfbkC714K8Mdrz4SSKnhCqGRRr
         FjCF+Gyzb1n7CdbTvdUHInG6dD/JzL6dppEcUlk05fR99qnjWTFMtAcaf4lZUT4587Zb
         VcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679138130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZlYT4yL6gG4aiu138Y6FqESLQRK9cKcNW+GTnQ4unA=;
        b=vtvwnd5MjeiqvQWJof/0Gi/xnKGrdWueYfiVS6Z3azPBClDwwED/CEd3hOXMwbdFA/
         NKD6p2XcXTzL2S4i1hpM1DgVs2SBjyEfqfRBTqa0wjSOdwWLgmZ0qScVpfU17Yz4OwG+
         nkMUMzdjax6WwucsnzPFnFiTUHjHSBan30LjtvH9KZzLzJZk4evop/RzN6UqHihTkf23
         rhlw5L2c9twor3ub9+/QwQhLFxffR9cK7+KIyCtzWCQ7RYeHjJx6BX1WEPEdXMd2FZl7
         GzCajNKPDDFSRKChZ5Uzq0gWzY+qRisED5Sh4xTTFQyjAOPX2favAq0zKagzomZPcNbJ
         R3yQ==
X-Gm-Message-State: AO0yUKU+/8b/pyGH7NdnFxEwEcGpD9Ji6AM+TqryrgZMsWWUrY2+UpLj
        fhT1s+NQh81+u6hbWDmMSo4=
X-Google-Smtp-Source: AK7set/YBLlL51zfnZDvz3OnlvanbGT7LLpQQGQ8vQCU9BZh2LlMpZHdR/PxwGEXulU3Mw93kCFDbg==
X-Received: by 2002:a05:600c:3aca:b0:3ed:6049:a5ae with SMTP id d10-20020a05600c3aca00b003ed6049a5aemr4655107wms.4.1679138129676;
        Sat, 18 Mar 2023 04:15:29 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id n23-20020a1c7217000000b003eb68bb61c8sm4849965wmc.3.2023.03.18.04.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 04:15:28 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 2/4] mm/mmap/vma_merge: set next to NULL if not applicable
Date:   Sat, 18 Mar 2023 11:13:19 +0000
Message-Id: <4d717269303d8a6fe1d837968c252eeb6ff1d7e5.1679137163.git.lstoakes@gmail.com>
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

We are only interested in next if end == next->vm_start (in which case we
check to see if we can set merge_next), so perform this check alongside
checking whether curr should be set.

This groups all of the simple range checks together and establishes the
invariant that, if prev, curr or next are non-NULL then their positions are
as expected.

Additionally, use the abstract 'vma' object to look up the possible curr or
next VMA in order to avoid any confusion as to what these variables
represent - now curr and next are assigned once and only once.

This has no functional impact.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c9834364ac98..66893fc72e03 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -930,15 +930,53 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
-	curr = find_vma(mm, prev ? prev->vm_end : 0);
-	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
-		next = find_vma(mm, curr->vm_end);
-	else
-		next = curr;
+	/*
+	 * If there is a previous VMA specified, find the next, otherwise find
+	 * the first.
+	 */
+	vma = find_vma(mm, prev ? prev->vm_end : 0);
+
+	/*
+	 * Does the input range span an existing VMA? If so, we designate this
+	 * VMA 'curr'. The caller will have ensured that curr->vm_start == addr.
+	 *
+	 * Cases 5 - 8.
+	 */
+	if (vma && end > vma->vm_start) {
+		curr = vma;
 
-	/* In cases 1 - 4 there's no CCCC vma */
-	if (curr && end <= curr->vm_start)
+		/*
+		 * If the addr - end range spans this VMA entirely, then we
+		 * check to see if another VMA follows it.
+		 *
+		 * If it is _immediately_ adjacent (checked below), then we
+		 * designate it 'next' (cases 6 - 8).
+		 */
+		if (curr->vm_end == end)
+			vma = find_vma(mm, curr->vm_end);
+		else
+			/* Case 5. */
+			vma = NULL;
+	} else {
+		/*
+		 * The addr - end range either spans the end of prev or spans no
+		 * VMA at all - in either case we dispense with 'curr' and
+		 * maintain only 'prev' and (possibly) 'next'.
+		 *
+		 * Cases 1 - 4.
+		 */
 		curr = NULL;
+	}
+
+	/*
+	 * We only actually examine the next VMA if it is immediately adjacent
+	 * to end which sits either at the end of a hole (cases 1 - 3), PPPP
+	 * (case 4) or CCCC (cases 6 - 8).
+	 */
+	if (vma && end == vma->vm_start)
+		next = vma;
+	else
+		next = NULL;
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
@@ -959,11 +997,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
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

