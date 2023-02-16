Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14000698BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBPFUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBPFTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91EF42BCB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a1-20020a258701000000b008e1de4c1e7dso848079ybl.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=28uvo2IqceKOssyZjY7i8BHUgiXFo9Fj5hjouTFWFAM=;
        b=ZPrkg6AbbvOKBZi1SkD/IxKxJeFUcG0rgRJFt48c6bsRhM/elzC2zYFPNxVAX1Pb/y
         v8gEIUO6XL4wPMpxHAJU/jtJ7FTBRhHG6n1tq7RCpsfo3BvcbN99La419Vjdnmr4LZUg
         Gb+YjubKYslJ6dowNgphM8TvAV/LOX1cmszsmnXszpI4IFG2RXQTfj4jwXf+4wC/qln3
         8/CHWsl7LtqeSj/ymA2+araRUo+8VrDVeXfGOtKcUcgJXUwZ/d5G40s9s5ABK3v0GdSA
         ZKM8IbDd/wXIDY67hjDQxG31fd3mnWXrl8BZPhPKFflZXpp+nOaLG/s24K3lMQ1hF8se
         I12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28uvo2IqceKOssyZjY7i8BHUgiXFo9Fj5hjouTFWFAM=;
        b=tZZnuoU+6DGzX/CGijzGnY/iUPwL3wFTYD2DNuP2aSss06bywYwcoLbbFdJoY1QGT4
         Bd4G0HITtMVU6UzG3HFhfYTACD0Hj48ZyqrTCFQt7Kez5P75uw5qiXTiW3b9Yrxusb7I
         XmarJgOj2j6Kg+rWymZoNhQUP/m05/QYw127mhXTqzLuBPZeSl4wI1LGdhQB42kGPMYT
         P7S1kVN1YbK41P7TXp1X81JQnUKbAroPpMEEYfZg4KsovPCK0f1cCR52AeaYWrHFu/vU
         DAW0dMN9ii6EtOuSZ7pnbAYoFM6eqtBjt27RGXQYuVOI+vxUnR0wiFU/zWWgnEGLZuWm
         pstw==
X-Gm-Message-State: AO0yUKXU4bQj/n0NJG+6IX4yGxH1LWdVRoIVVgmpCF/9uZYwJHcLaDSo
        X6ItIgjNZeV9XB7OJ9WiLUdc4rF8lc8=
X-Google-Smtp-Source: AK7set9S4UPuY0Di9CvIunrawIij5qvY5UYsfRSe+cxMHLWbfH6TBfZEYx+EaVk4FGZlSlGHqCNzztV/E7o=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a5b:90d:0:b0:94a:ebba:cba1 with SMTP id
 a13-20020a5b090d000000b0094aebbacba1mr584331ybq.179.1676524713985; Wed, 15
 Feb 2023 21:18:33 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:31 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-17-surenb@google.com>
Subject: [PATCH v3 16/35] mm/mmap: write-lock VMAs before merging, splitting
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
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
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
index c5f2ddf17b87..ec2f8d0af280 100644
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

