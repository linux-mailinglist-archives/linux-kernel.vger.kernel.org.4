Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1867EE9A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjA0Toa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjA0TnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4015312851
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5063c0b909eso64912297b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xM1gV9tZESxmDxiysmAmLZq38ZaKZXSlDI1GeX9HKic=;
        b=lE9qRR84U5+rYrRmzpPAw7Ud6uFSOEezLerrdXzskk/7N7IWEzIS+P8h33l5/GHLwm
         pzf0b8p0OfVWGzGLb/dMUWWv/4+TG3PN/VW/HgmJDf4GTYQxz4qhZvzGmSe6iwYXQbEv
         pmRWin5z3kTr/dQHGmOmQouL9X7gNxEvHMfX/Mw4+j3xs8bwN3ke4zv6/7Jpk/cXGw8a
         hnXfsAcVwtJnLNS//9cNJnJKu2XJduYEuopAyOxXqZTZsrcp23rvXM55Jk6t7ntayedf
         QFH2QchxeUajMjFYvRPLkdcrU5vfcJYPLkQ5Wb/mKP36Ds4BBv5V6MGo7zAGbp1SePYq
         xw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xM1gV9tZESxmDxiysmAmLZq38ZaKZXSlDI1GeX9HKic=;
        b=73GImSy7IXwMLb7/l1uQMMn730QaZUY2hwN3cv/BXAsFGU+VFcep1WFHEVFprIE8ma
         AM+QxCr6025GiRkn/dFaFC49Fgu6jdd8dz8jRJBlkld8WDOGeWa8dwPsRjbuiBwx/3pd
         C2RINAYmlDXlrHhn+x+lSDByJnheZGPe3BM9e/4whIdeKrXKPVQHuz2azjTJkqwk4e23
         kZWf+itTB97msJR8x3/Hgug04Ew7OoFlfEsth30QIe9DZEsYEV3hN0KoCedAFuXFMMB3
         TCV2kWFvKKKpcKw9R78wJvtGkblMaNeyfh9Em+u7UJbquxI5YLdnpcLmYLFSny/mKGap
         tvrw==
X-Gm-Message-State: AFqh2koSJTXsnCcicGEuDI+73eFPxZXGEG5rH3qONUUPHNF78i8OpfSG
        nGfml7JoA78HlNwP9i6WsAI0BXFP/ZI=
X-Google-Smtp-Source: AMrXdXsibCiIco7YlC7GUbshkOFJQAk8PpTkup371cElxWyegDeUsxNSE/XyOxE1JUpmHxGWPZOyG9ioimM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a25:b94d:0:b0:801:e503:dd0c with SMTP id
 s13-20020a25b94d000000b00801e503dd0cmr2559229ybm.384.1674848510225; Fri, 27
 Jan 2023 11:41:50 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:52 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-16-surenb@google.com>
Subject: [PATCH v2 15/33] mm/mmap: write-lock VMAs before merging, splitting
 or expanding them
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decisions about whether VMAs can be merged, split or expanded must be
made while VMAs are protected from the changes which can affect that
decision. For example, merge_vma uses vma->anon_vma in its decision
whether the VMA can be merged. Meanwhile, page fault handler changes
vma->anon_vma during COW operation.
Write-lock all VMAs which might be affected by a merge or split operation
before making decision how such operations should be performed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7467d691e357..6fff76334177 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -269,8 +269,11 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	 */
 	vma_iter_init(&vmi, mm, oldbrk);
 	next = vma_find(&vmi, newbrk + PAGE_SIZE + stack_guard_gap);
-	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
-		goto out;
+	if (next) {
+		vma_start_write(next);
+		if (newbrk + PAGE_SIZE > vm_start_gap(next))
+			goto out;
+	}
 
 	brkvma = vma_prev_limit(&vmi, mm->start_brk);
 	/* Ok, looks good - let it rip. */
@@ -912,10 +915,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
+	if (prev)
+		vma_start_write(prev);
 	next = find_vma(mm, prev ? prev->vm_end : 0);
+	if (next)
+		vma_start_write(next);
 	mid = next;
-	if (next && next->vm_end == end)		/* cases 6, 7, 8 */
+	if (next && next->vm_end == end) {		/* cases 6, 7, 8 */
 		next = find_vma(mm, next->vm_end);
+		if (next)
+			vma_start_write(next);
+	}
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
@@ -2163,6 +2173,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	WARN_ON(vma->vm_start >= addr);
 	WARN_ON(vma->vm_end <= addr);
 
+	vma_start_write(vma);
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err = vma->vm_ops->may_split(vma, addr);
 		if (err)
@@ -2518,6 +2529,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
+	if (next)
+		vma_start_write(next);
 	if (next && next->vm_start == end && !vma_policy(next) &&
 	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
 				 NULL_VM_UFFD_CTX, NULL)) {
@@ -2527,6 +2540,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Check prev */
+	if (prev)
+		vma_start_write(prev);
 	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
 	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
 				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
@@ -2900,6 +2915,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
+	if (vma)
+		vma_start_write(vma);
 	/*
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
-- 
2.39.1

