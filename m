Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE070CBB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjEVU4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjEVU4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403DCCA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC879600E1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0233C433D2;
        Mon, 22 May 2023 20:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684788976;
        bh=nuY45qVrwi5Vr9irJ7j4aWh7djwvnqNlkF9mxEhuJh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lrcvsrg3AyMu+EmrF8C4ZBe6v6C2/Rbkxg88uemOTafccbiNGm+YgwmJcfHGrKyWC
         76NT5ErfVGAWNJ5Z6Z5J1pHSWmWz70tzi0M+SVbvkTYdDpo0n+kfKZiuCn5zRuXHbU
         GwyU6B6D1lZDC5oRHooCEtdsw+pm49Wc9l9nyFcQ=
Date:   Mon, 22 May 2023 13:56:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap: refactor mlock_future_check()
Message-Id: <20230522135615.b53241a49e960281e3598898@linux-foundation.org>
In-Reply-To: <fbbba8cd-77d1-44c3-ba70-18beae5719d1@lucifer.local>
References: <20230522082412.56685-1-lstoakes@gmail.com>
        <20230522132851.ccc9fafac91d7eb9ba922e94@linux-foundation.org>
        <fbbba8cd-77d1-44c3-ba70-18beae5719d1@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 21:34:31 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> On Mon, May 22, 2023 at 01:28:51PM -0700, Andrew Morton wrote:
> > On Mon, 22 May 2023 09:24:12 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> >
> > > In all but one instance, mlock_future_check() is treated as a boolean
> > > function despite returning an error code. In one instance, this error code
> > > is ignored and replaced with -ENOMEM.
> > >
> > > This is confusing, and the inversion of true -> failure, false -> success
> > > is not warranted. Convert the function to a bool, lightly refactor and
> > > return true if the check passes, false if not.
> >
> > Yup.
> >
> > I don't think the name does a good job of conveying the
> > function's use.
> >
> > > -	if (mlock_future_check(mm, vm_flags, len))
> > > +	if (!mlock_future_check(mm, vm_flags, len))
> > >  		return -EAGAIN;
> >
> > 	if (!may_mlock_future(...))
> >
> > or
> >
> > 	if (!mlock_future_ok(...))
> >
> > ?
> >
> >
> 
> Yeah I struggled with this, because the check only triggers if VM_LOCKED. I was
> originally toying with can_mlock_future() but of course, it also returns true if
> !VM_LOCKED...
> 
> I think your suggestion of mlock_future_ok() works well, could you change it to
> that? Thanks!

Sure.  I'll make it a separate patch.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/mlock: rename mlock_future_check() to mlock_future_ok()
Date: Mon May 22 01:52:10 PM PDT 2023

It is felt that the name mlock_future_check() is vague - it doesn't
particularly convey the function's operation.  mlock_future_ok() is a
clearer name for a predicate function.

Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/internal.h  |    2 +-
 mm/mmap.c      |    8 ++++----
 mm/mremap.c    |    2 +-
 mm/secretmem.c |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

--- a/mm/internal.h~mm-mlock-rename-mlock_future_check-to-mlock_future_ok
+++ a/mm/internal.h
@@ -576,7 +576,7 @@ extern long populate_vma_page_range(stru
 extern long faultin_vma_page_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end,
 				   bool write, int *locked);
-extern bool mlock_future_check(struct mm_struct *mm, unsigned long flags,
+extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
 			       unsigned long bytes);
 /*
  * mlock_vma_folio() and munlock_vma_folio():
--- a/mm/mmap.c~mm-mlock-rename-mlock_future_check-to-mlock_future_ok
+++ a/mm/mmap.c
@@ -182,7 +182,7 @@ static int check_brk_limits(unsigned lon
 	if (IS_ERR_VALUE(mapped_addr))
 		return mapped_addr;
 
-	return mlock_future_check(current->mm, current->mm->def_flags, len)
+	return mlock_future_ok(current->mm, current->mm->def_flags, len)
 		? 0 : -EAGAIN;
 }
 static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
@@ -1149,7 +1149,7 @@ static inline unsigned long round_hint_t
 	return hint;
 }
 
-bool mlock_future_check(struct mm_struct *mm, unsigned long flags,
+bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
 			unsigned long bytes)
 {
 	unsigned long locked_pages, limit_pages;
@@ -1275,7 +1275,7 @@ unsigned long do_mmap(struct file *file,
 		if (!can_do_mlock())
 			return -EPERM;
 
-	if (!mlock_future_check(mm, vm_flags, len))
+	if (!mlock_future_ok(mm, vm_flags, len))
 		return -EAGAIN;
 
 	if (file) {
@@ -1927,7 +1927,7 @@ static int acct_stack_growth(struct vm_a
 		return -ENOMEM;
 
 	/* mlock limit tests */
-	if (!mlock_future_check(mm, vma->vm_flags, grow << PAGE_SHIFT))
+	if (!mlock_future_ok(mm, vma->vm_flags, grow << PAGE_SHIFT))
 		return -ENOMEM;
 
 	/* Check to ensure the stack will not grow into a hugetlb-only region */
--- a/mm/mremap.c~mm-mlock-rename-mlock_future_check-to-mlock_future_ok
+++ a/mm/mremap.c
@@ -775,7 +775,7 @@ static struct vm_area_struct *vma_to_res
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
 		return ERR_PTR(-EFAULT);
 
-	if (!mlock_future_check(mm, vma->vm_flags, new_len - old_len))
+	if (!mlock_future_ok(mm, vma->vm_flags, new_len - old_len))
 		return ERR_PTR(-EAGAIN);
 
 	if (!may_expand_vm(mm, vma->vm_flags,
--- a/mm/secretmem.c~mm-mlock-rename-mlock_future_check-to-mlock_future_ok
+++ a/mm/secretmem.c
@@ -125,7 +125,7 @@ static int secretmem_mmap(struct file *f
 	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
-	if (!mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
 		return -EAGAIN;
 
 	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
_

