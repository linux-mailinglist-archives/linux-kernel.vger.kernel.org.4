Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93996BF98F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 12:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCRLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 07:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCRLPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 07:15:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB6653705
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:15:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so4779300wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679138131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNIdJ6Vt6KcFvn7hpLjquLcVPqIZMiCegIYHYyxVYMQ=;
        b=YMQqEVZicnvPGmZNhsvLOxCWnnQ4bjhFqhJ82RSQUi0l0UVsKNSk3G7LWahwyS905J
         swwajsI070tAoW5Lm6cSP7fXTIC4aTibf8W/tNdetrlBGyPiIq+HIZ7DLScmCKjLOTby
         nttJ+XmxMdfwYloG/jxJxQR/KmIjTQxvdQOFDnI7HKBupIH9vOALsYdb4cVJnJxRJwuo
         Onw484Ikw64e8ppcyEHnXW7y2q1jTAKZWcB9r0n0onaKB7xG7uUr1ZvhzjE892amjNLs
         4i/8D/ciyaHtYYQF0XluT6STyjKEr6PUmgcjpPhiJLBjKSEvzfheFEii0uC8cUJfoDx7
         ALIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679138131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNIdJ6Vt6KcFvn7hpLjquLcVPqIZMiCegIYHYyxVYMQ=;
        b=OeGkq8s4A2ow/4iSJrawXouc2QafEXZVvlCcmCJqGSE1YIdlPDsFZAs3WhP0rWahbE
         e/htEHEfQXm19Xmcrse8hzBfujWAqx6JFg3wQCuJWLpGwbfKkIrFQxFqomDui0mnSV2+
         SN/hKTPdZ9B1ZxUrVBFFhoc9YvaFTi+3Pt/qH+rXC3RY01p/zV0vxfWAke/gE5KB+aqJ
         f58eNd24rQQ4o3B5ncvJKq/rEDXAO2+u5MfJNmVl0nIOKf65wA6q+ays/1FaZfQU1HXe
         0/RuX03fWKPmarl558yccK/q39H6FVivtsx7+2G+f0ZKGufufCJpBDkg8Uu2UZupAELM
         Q8Hw==
X-Gm-Message-State: AO0yUKV6LuI6O95websDde8nqxLWC5i8SpIYB6TA9AYSqD9luq/HUIA6
        wMuee1UEMo0fwjBKYevnJz4=
X-Google-Smtp-Source: AK7set94PT/Q7iAywBf0Cb7oTqcOQNbpnm2Aipfhodna7X7JLeaBkzyN1dtmmLsIFyBtm6OTuR62Qw==
X-Received: by 2002:a05:600c:46d2:b0:3ed:46e2:85fb with SMTP id q18-20020a05600c46d200b003ed46e285fbmr7951903wmo.33.1679138131106;
        Sat, 18 Mar 2023 04:15:31 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id n23-20020a1c7217000000b003eb68bb61c8sm4849965wmc.3.2023.03.18.04.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 04:15:30 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 3/4] mm/mmap/vma_merge: extend invariants, avoid invalid res, vma
Date:   Sat, 18 Mar 2023 11:13:20 +0000
Message-Id: <0b7d3e6c770a2bdc2c307ddde268561135ef3395.1679137163.git.lstoakes@gmail.com>
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

Previously, vma was an uninitialised variable which was only definitely
assigned as a result of the logic covering all possible input cases - for
it to have remained uninitialised, prev would have to be NULL, and next
would _have_ to be mergeable.

We now reuse vma to assign curr and next, so to be absolutely explicit,
ensure this variable is _always_ assigned, and while we're at it remove the
redundant assignment of both res and vma (if prev is NULL then we simply
assign to NULL).

In addition, we absolutely do rely on addr == curr->vm_start should curr
exist, so assert as much.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 66893fc72e03..e60c637f4e49 100644
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
@@ -978,14 +978,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	else
 		next = NULL;
 
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
@@ -996,6 +1000,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_prev(vmi);
 		}
 	}
+
 	/* Can we merge the successor? */
 	if (next && mpol_equal(policy, vma_policy(next)) &&
 	    can_vma_merge_before(next, vm_flags,
@@ -1036,6 +1041,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
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

