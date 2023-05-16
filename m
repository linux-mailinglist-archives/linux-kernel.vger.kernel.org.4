Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DCB7051AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjEPPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjEPPHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AFD19A4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684249605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1pdTTn0GgAfPkKqIGiR17DtqFOjsK0BumYalKsvnh6E=;
        b=CyqfNiDy34h+TYHPej2YEWDmOECFLu4IZVttHGB7k8ddu7LRmG8nYLDQyQCID6KOHIWdJs
        qSSdlO0KqtJAm6D19WD9PWBdkQ04RQcP57quYu1zN6dxhehCUC0K4Tsi8OS9CJ+5gkIGIw
        Z1L29lAj9bCIseOLeQpoDWQ2LIoGkCE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-DcnMcRyaPniHU2XhYL7dgg-1; Tue, 16 May 2023 11:06:43 -0400
X-MC-Unique: DcnMcRyaPniHU2XhYL7dgg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-61b5f341341so18533336d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684249603; x=1686841603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pdTTn0GgAfPkKqIGiR17DtqFOjsK0BumYalKsvnh6E=;
        b=C4b9wrFCZq1ffuj6nVqo0fUzjuipUW6YZ40U1zzu1hlxpxB67I5NuRfaJ7vF8BziGX
         h8VV7ZJY2egANRAEBlbdrEUQWFjXykLFCZIdcDLcRwoKACPWYfMRg9t8W1btpGODHBoV
         2GDzXurgvX1PMs7FmYXnTFSoHfdpTO2Pp6ZPiE9hzINl958lRgrRg24ZpKZL2GKTfjNy
         Gk5wBq2WguhBb2ttOYi9eT2g3G1mQXQUKZ4BAV8SBYiXbMndb0himIs5dzJPjhpXBMbv
         1k0+O6oo6bTtcNnWMjRZr+o3x8Mdatt9byvuKIA6wKvFed9npezgaO6ME+JYVyXH4tvq
         Bs3g==
X-Gm-Message-State: AC+VfDzlyeKhkNC2Gsve5bJhpkxuwTgqDVoG8KoxNR39o5LFORq+vpcg
        bzC+W5pfeJrgh72ISEcQ/AOAX/8+1u6i28l2v/taL0554c4vgi8+xA+X9ShKu0rQtclL6UD17Vg
        pyN6sa8aPgrCXfMn56QDPup30
X-Received: by 2002:a05:6214:528b:b0:621:4549:106 with SMTP id kj11-20020a056214528b00b0062145490106mr4697610qvb.2.1684249603302;
        Tue, 16 May 2023 08:06:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CavSgxsS4xlf3pNo2ffqNC/Opoi5tUpqoywQFyRwEVQETWS3+buPZiqG2xiZ9HcQMPb6OQA==
X-Received: by 2002:a05:6214:528b:b0:621:4549:106 with SMTP id kj11-20020a056214528b00b0062145490106mr4697557qvb.2.1684249602809;
        Tue, 16 May 2023 08:06:42 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id x25-20020a05620a14b900b0075941df3365sm645630qkj.52.2023.05.16.08.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 08:06:41 -0700 (PDT)
Date:   Tue, 16 May 2023 11:06:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <ZGOcAOFOjx3XPGqO@x1n>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 12:07:11AM +0100, Lorenzo Stoakes wrote:
> On Mon, May 15, 2023 at 11:04:27PM +0100, Lorenzo Stoakes wrote:
> [snip]
> > > Could you explain a bit why we don't need to merge in this case?
> > >
> > > I'm considering, for example, when we have:
> > >
> > >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> > >
> > > Then someone unregisters uffd on range (5-9), iiuc it should become:
> > >
> > >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> > >
> > > But if no merge here it's:
> > >
> > >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> > >
> > > Maybe I missed something?
> > >
> >
> > There's something really, really wrong with this. It simply isn't valid to
> > invoke vma_merge() over an existing VMA that != prev where you're not
> > specifying addr = vma->vm_start, end == vma->vm_end.
> >
> > This seems like you're relying on:-
> >
> >   ***
> > CCCCCNNNNN -> CCNNNNNNNN

I had a closer look today, I still think this patch is not really the right
one.  The split/merge order is something we use everywhere and I am not
convinced it must change as drastic.  At least so far it still seems to me
if we do with what current patch proposed we can have vma fragmentations.

I think I see what you meant, but here I think it's a legal case where we
should have PPPP rather than CCCC (PPPPPNNNN --> PPNNNNNNNN).

To be explicit, for register I think it _should_ be the case 0 where we
cannot merge (note: the current code is indeed wrong though, see below):

   ****
  PPPPPPNNNNNN
  cannot merge

While for the unregister case here it's case 4:

    ****
  PPPPPPNNNNNN
  might become
  PPNNNNNNNNNN
  case 4 below

Here the problem is not that we need to do split then merge (I think it'll
have the problem of vma defragmentation here), the problem is we simply
passed in the wrong "prev" vma pointer, IMHO.  I've patches attached
showing what I meant.

I checked the original commit from Andrea and I found that it _was_ correct:

commit 86039bd3b4e6a1129318cbfed4e0a6e001656635
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Fri Sep 4 15:46:31 2015 -0700

    userfaultfd: add new syscall to provide memory externalization

I had a feeling that it's broken during the recent rework on vma (or maybe
even not that close), but I'm not yet sure and need to further check.

> >
> > By specifying parameters that are compatible with N even though you're only
> > partially spanning C?
> >
> > This is crazy, and isn't how this should be used. vma_merge() is not
> > supposed to do partial merges. If it works (presumably it does) this is not
> > by design unless I've lost my mind and I (and others) have somehow not
> > noticed this??
> >
> > I think you're right that now we'll end up with more fragmentation, but
> > what you're suggesting is not how vma_merge() is supposed to work.
> >
> > As I said above, giving vma_merge() invalid parameters is very dangerous as
> > you could end up merging over empty ranges in theory (and could otherwise
> > have corruption).
> >
> > I guess we should probably be passing 0 to the last parameter in
> > split_vma() here then to ensure we do a merge pass too. Will experiment
> > with this.
> >
> > I'm confused as to how the remove from case 8 is not proceeding. I'll look
> > into this some more...
> >
> > Happy to be corrected if I'm misconstruing this!
> >
> 
> OK, so I wrote a small program to do perform exactly this case [0] and it seems
> that the outcome is the same before and after this patch - vma_merge() is
> clearly rejecting the case 8 merge (phew!) and in both instances you end up with
> 3 VMAs.
> 
> So this patch doesn't change this behaviour and everything is as it was
> before. Ideally we'd let it go for another pass, so maybe we should change the
> split to add a new VMA _afterwards_. Will experiment with that, separately.
> 
> But looks like the patch is good as it is.
> 
> (if you notice something wrong with the repro, etc. do let me know!)
> 
> [0]: https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e

I think your test case is fine, but... no, this is still not expected. The
vma should just merge.

So I have another closer look on this specific issue, it seems we have a
long standing bug on pgoff calculation here when passing that to
vma_merge().  I've got another patch attached to show what I meant.

To summarize.. now I've got two patches attached:

Patch 1 is something I'd like to propose to replace this patch that fixes
incorrect use of vma_merge() so it should also eliminate the assertion
being triggered (I still think this is a regression but I need to check
which I will do later; I'm not super familiar with maple tree work, maybe
you or Liam can quickly spot).

Patch 2 fixes the long standing issue of vma not being able to merge in
above case, and with patch 2 applied it should start merging all right.

Please have a look, thanks.

---8<---
From 6bc39028bba246394bb0bafdaeaab7b8dfd1694f Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 16 May 2023 09:03:22 -0400
Subject: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts part of
 vma

It seems vma merging with uffd paths is broken with either
register/unregister, where right now we can feed wrong parameters to
vma_merge() and it's found by recent patch which moved asserts upwards in
vma_merge():

https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/

The problem is in the current code base we didn't fixup "prev" for the case
where "start" address can be within the "prev" vma section.  In that case
we should have "prev" points to the current vma rather than the previous
one when feeding to vma_merge().

This will eliminate the report and make sure vma_merge() calls will become
legal again.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..7eb88bc74d00 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1458,10 +1458,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	BUG_ON(!found);
 
 	vma_iter_set(&vmi, start);
-	prev = vma_prev(&vmi);
+	vma = vma_find(&vmi, end);
+	if (!vma)
+		goto out_unlock;
+
+	if (vma->vm_start < start)
+		prev = vma;
+	else
+		prev = vma_prev(&vmi);
 
 	ret = 0;
-	for_each_vma_range(vmi, vma, end) {
+	do {
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1517,7 +1524,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	skip:
 		prev = vma;
 		start = vma->vm_end;
-	}
+	} for_each_vma_range(vmi, vma, end);
 
 out_unlock:
 	mmap_write_unlock(mm);
@@ -1624,9 +1631,17 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	BUG_ON(!found);
 
 	vma_iter_set(&vmi, start);
-	prev = vma_prev(&vmi);
+	vma = vma_find(&vmi, end);
+	if (!vma)
+		goto out_unlock;
+
+	if (vma->vm_start < start)
+		prev = vma;
+	else
+		prev = vma_prev(&vmi);
+
 	ret = 0;
-	for_each_vma_range(vmi, vma, end) {
+	do {
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
@@ -1692,7 +1707,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	skip:
 		prev = vma;
 		start = vma->vm_end;
-	}
+	} for_each_vma_range(vmi, vma, end);
 
 out_unlock:
 	mmap_write_unlock(mm);
-- 
2.39.1

From bf61f3c937e9e2ab96ab2bed0005cb7dc74db231 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 16 May 2023 09:39:38 -0400
Subject: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible

We used to not pass in the pgoff correctly when register/unregister uffd
regions, it caused incorrect behavior on vma merging.

For example, when we have:

  vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)

Then someone unregisters uffd on range (5-9), it should become:

  vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)

But with current code it's:

  vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)

This patch allows such merge to happen correctly.

This behavior seems to have existed since the 1st day of uffd, keep it just
as a performance optmization and not copy stable.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7eb88bc74d00..891048b4799f 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
 	struct vma_iterator vmi;
+	pgoff_t pgoff;
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1489,8 +1490,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma_end = min(end, vma->vm_end);
 
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
+		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
+				 vma->anon_vma, vma->vm_file, pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
@@ -1570,6 +1572,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
+	pgoff_t pgoff;
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1677,8 +1680,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			uffd_wp_range(vma, start, vma_end - start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
+		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
+				 vma->anon_vma, vma->vm_file, pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
-- 
2.39.1
---8<---

-- 
Peter Xu

