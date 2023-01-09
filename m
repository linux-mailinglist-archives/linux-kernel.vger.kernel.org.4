Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D636631F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbjAIU4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbjAIUzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:55:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C23848F7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w15-20020a05690204ef00b007b966ba4410so7175454ybs.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ves4Zx76RBv25M18zzcj7gVloTdTuNMdyKmYC5DDvz0=;
        b=MKIFYUVg3C+KcUmk/DiJLvwQZvDLVNMlr8DQ0MCXFdkv6hN2eBfUWDzxIZ7BfVHp8I
         9ZQKQbnc3cjtIsfRVDcXo71Ba38rTMbcUdq5jPPQ/O/qUYTP0dyF6taFqjbQZ9FRkBHu
         4AhRyAaM/Xs1rNZHH4s644beTjAgsiLfyufSEIgttXRExgdKqL3ufxpDIm4mlvORyhtg
         8KPqhXKz4czDblD/OO3yCfwh5TQTP8fNUj9/04RnIZEyuuEXUuTlBqAldxaXV0tj/mD/
         bYzPmov2AWSWqL0UrgwZuK2hqucg36ElYTON5SUI9h/73LoxJPTGa7ERIj/8Aw4bHycM
         nzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ves4Zx76RBv25M18zzcj7gVloTdTuNMdyKmYC5DDvz0=;
        b=cKW5U6PtxhwR348hIPI16LT/msHQ3L7R4hiIO1BA0MCRzrTnS6IvePIpht9FiXpOax
         TFRWUWo6MzLbl1eQ2BoqA/GvbU2bQxkDmLUvg8U91I49DHmsuCo3UapsyREKyNPC7uHO
         NoYnDL8MxTHrOiNmdgFluTitEbl33jWVsY9Ci4i47ci6rAdhyaYKEJB3iIMF+uFHYri4
         vqWvSKUEKzAWlAoKlVQfF7ffMFfn0dfuGAu3TRWFaBp9OCxaLGgcpRzTNDf75BffHk97
         hnAC70rOy0OTPXCah4QeAun9aW0WSqBZwMZDKtJ3HeGmC20M4E1G0JZ7Ft3/zHah893G
         oGsw==
X-Gm-Message-State: AFqh2koVPSfy7cFw3J/Al13Q5l+X4YxnOUwStW73V6MoKOHFGuFcWEcc
        teWWgDxX1vK1oLfe8ZoRcOJRn2IyLiU=
X-Google-Smtp-Source: AMrXdXvMc8uw91kFZQ5TZdRrbkHWe3EKuKErf5QuBh5uD1fMXXAng4XpjPLPHBE1E+VnZgCLzgnV8hcsb8Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a81:a013:0:b0:4a9:884a:20c4 with SMTP id
 x19-20020a81a013000000b004a9884a20c4mr4780346ywg.139.1673297669408; Mon, 09
 Jan 2023 12:54:29 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:14 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-20-surenb@google.com>
Subject: [PATCH 19/41] mm/mmap: write-lock VMAs before merging, splitting or
 expanding them
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
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

Not sure if expansion really needs this, just being paranoid. Otherwise
mmap_region and vm_brk_flags might not locking.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 53d885e70a54..f6ca4a87f9e2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -254,8 +254,11 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	 */
 	mas_set(&mas, oldbrk);
 	next = mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
-	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
-		goto out;
+	if (next) {
+		vma_write_lock(next);
+		if (newbrk + PAGE_SIZE > vm_start_gap(next))
+			goto out;
+	}
 
 	brkvma = mas_prev(&mas, mm->start_brk);
 	/* Ok, looks good - let it rip. */
@@ -1017,10 +1020,17 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
+	if (prev)
+		vma_write_lock(prev);
 	next = find_vma(mm, prev ? prev->vm_end : 0);
 	mid = next;
-	if (next && next->vm_end == end)		/* cases 6, 7, 8 */
+	if (next)
+		vma_write_lock(next);
+	if (next && next->vm_end == end) {		/* cases 6, 7, 8 */
 		next = find_vma(mm, next->vm_end);
+		if (next)
+			vma_write_lock(next);
+	}
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
@@ -2198,6 +2208,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	int err;
 	validate_mm_mt(mm);
 
+	vma_write_lock(vma);
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err = vma->vm_ops->may_split(vma, addr);
 		if (err)
@@ -2564,6 +2575,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
+	if (next)
+		vma_write_lock(next);
 	if (next && next->vm_start == end && !vma_policy(next) &&
 	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
 				 NULL_VM_UFFD_CTX, NULL)) {
@@ -2573,6 +2586,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Check prev */
+	if (prev)
+		vma_write_lock(prev);
 	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
 	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
 				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
@@ -2942,6 +2957,8 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
+	if (vma)
+		vma_write_lock(vma);
 	/*
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
-- 
2.39.0

