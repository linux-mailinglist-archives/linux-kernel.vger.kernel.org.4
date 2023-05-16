Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD6C705708
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjEPTZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEPTZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:25:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C1F7DA7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:25:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3063891d61aso13891895f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684265115; x=1686857115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/lEQ/IxjkAHBzjS7pPyUe2O2fy004pHzdBxS9b2Y0Y=;
        b=fzPcKqehspIzdoifXtkLU1DB/yfuDvRwLgCyPkNU367n5SUS7rFix9jXcrKR+tcZfj
         AJzC3vv7FpDCgPatwpiGxpRpgln9isgqo3fKSJQzDaxYseyDNtyQF3GpiIFwH5EP7xh3
         V83QyEHhGLRbKeKdF8b0iKKA2WAlPs/xDoZab7NhbNh3xyArTgp1RQ6gfn99/56DeGqz
         9kKr8l5i3Re77TUH7f2au6ZlSGTrODbj/cTGW9QrPAuoAXo/5hJyRMVtRdw/9/SAHTuG
         meLyyRprvygmJd/JHJjz+/YXMO6lZWMmslSPH+9kpSLcY2rAIsKmoSOcu5o4++K3QoCR
         6Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684265115; x=1686857115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/lEQ/IxjkAHBzjS7pPyUe2O2fy004pHzdBxS9b2Y0Y=;
        b=Rp8y3S/CoKvedG4F3qay9mFmy2AYxeAbIYaAR0th7r8DUh1mRKg6Pn2+yy9GrZumdr
         K9ZeDx9LJBk2I1aL45UPFJ+21TpdlIlOXH60xw8y1Yb69Asfp5NobzNY0s8DFv1lJwFs
         h6iXI9gTm2yiBeOd/uCwZN1oWMgVY1ALO45WXdO/w+n+zGgTGHPRzBuBnm9/W+CvtE1N
         urmbj6lo6ZbUBH0W8KU1Ria4Xhf0MLUENGV6XqK+8gyfixcy/mjWB0o7vwiQn7dy4pVL
         R69255gJGQ8zoYRWg5Ei793TgkEZpbRJM8HsXe4M+lUDOzFYeAUy3oCltIoT0t0RigDF
         5vaQ==
X-Gm-Message-State: AC+VfDzYJ4UDSztUuhm6OH6mK7g4Aq62/VXR+VAor3EZb1qdq+DaO+cR
        V2Y+FWk257A9c5Vnve7Uu94=
X-Google-Smtp-Source: ACHHUZ7roro9vpaszQqDJvdZwJL3ArC7J+WFDebVEi16EnDgkJK9z5U+cF0ev/Af0ZdI1mGQLG8AqQ==
X-Received: by 2002:a5d:5003:0:b0:306:3408:f9a8 with SMTP id e3-20020a5d5003000000b003063408f9a8mr27670798wrt.11.1684265115288;
        Tue, 16 May 2023 12:25:15 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6848000000b002ceacff44c7sm267720wrw.83.2023.05.16.12.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:25:14 -0700 (PDT)
Date:   Tue, 16 May 2023 20:25:13 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <9739133c-3ee7-4e94-a6a8-783045a50ac6@lucifer.local>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGOcAOFOjx3XPGqO@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 11:06:40AM -0400, Peter Xu wrote:
> On Tue, May 16, 2023 at 12:07:11AM +0100, Lorenzo Stoakes wrote:
> > On Mon, May 15, 2023 at 11:04:27PM +0100, Lorenzo Stoakes wrote:
> > [snip]
> > > > Could you explain a bit why we don't need to merge in this case?
> > > >
> > > > I'm considering, for example, when we have:
> > > >
> > > >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> > > >
> > > > Then someone unregisters uffd on range (5-9), iiuc it should become:
> > > >
> > > >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> > > >
> > > > But if no merge here it's:
> > > >
> > > >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> > > >
> > > > Maybe I missed something?
> > > >
> > >
> > > There's something really, really wrong with this. It simply isn't valid to
> > > invoke vma_merge() over an existing VMA that != prev where you're not
> > > specifying addr = vma->vm_start, end == vma->vm_end.
> > >
> > > This seems like you're relying on:-
> > >
> > >   ***
> > > CCCCCNNNNN -> CCNNNNNNNN
>
> I had a closer look today, I still think this patch is not really the right
> one.  The split/merge order is something we use everywhere and I am not
> convinced it must change as drastic.  At least so far it still seems to me
> if we do with what current patch proposed we can have vma fragmentations.

'something we use everywhere' is not an argument (speak to Willy about
folios), vma_merge() expects valid input, relying on it _happening_ to be
ok or to fail in ways that _happen_ not to cause big problems is not right.

This is just further evidence that the vma_merge() interface is
fundamentally broken. Implicitly assuming you will only get a partial prev
overlap merge is far from intuitive.

I am definitely going to try to do a series addressing vma_merge() horrors
because I feel like we need a generic means of doing this split/merge pattern.

>
> I think I see what you meant, but here I think it's a legal case where we
> should have PPPP rather than CCCC (PPPPPNNNN --> PPNNNNNNNN).
>
> To be explicit, for register I think it _should_ be the case 0 where we
> cannot merge (note: the current code is indeed wrong though, see below):
>
>    ****
>   PPPPPPNNNNNN
>   cannot merge
>
> While for the unregister case here it's case 4:
>
>     ****
>   PPPPPPNNNNNN
>   might become
>   PPNNNNNNNNNN
>   case 4 below
>
> Here the problem is not that we need to do split then merge (I think it'll
> have the problem of vma defragmentation here), the problem is we simply
> passed in the wrong "prev" vma pointer, IMHO.  I've patches attached
> showing what I meant.

Yeah if you do it with prev = vma this form should _probably_ work, that's
a good point. This _is_ a case (see https://ljs.io/vma_merge_cases.png for
nice diagram of cases btw :), like 5, where we actually do split and merge
at the same time.

Liam's raised some issues with the safety of your patches, let me look at
them when I get a chance, nasty headcold = brain less functional atm.

I would say for now this fix resolves the issue in a way that should
emphatically avoid invalid input to vma_merge(), the fragmentation existed
before so this is not a new issue, so for the time being I think it's ok to
stay as-is.

>
> I checked the original commit from Andrea and I found that it _was_ correct:
>
> commit 86039bd3b4e6a1129318cbfed4e0a6e001656635
> Author: Andrea Arcangeli <aarcange@redhat.com>
> Date:   Fri Sep 4 15:46:31 2015 -0700
>
>     userfaultfd: add new syscall to provide memory externalization
>
> I had a feeling that it's broken during the recent rework on vma (or maybe
> even not that close), but I'm not yet sure and need to further check.
>
> > >
> > > By specifying parameters that are compatible with N even though you're only
> > > partially spanning C?
> > >
> > > This is crazy, and isn't how this should be used. vma_merge() is not
> > > supposed to do partial merges. If it works (presumably it does) this is not
> > > by design unless I've lost my mind and I (and others) have somehow not
> > > noticed this??
> > >
> > > I think you're right that now we'll end up with more fragmentation, but
> > > what you're suggesting is not how vma_merge() is supposed to work.
> > >
> > > As I said above, giving vma_merge() invalid parameters is very dangerous as
> > > you could end up merging over empty ranges in theory (and could otherwise
> > > have corruption).
> > >
> > > I guess we should probably be passing 0 to the last parameter in
> > > split_vma() here then to ensure we do a merge pass too. Will experiment
> > > with this.
> > >
> > > I'm confused as to how the remove from case 8 is not proceeding. I'll look
> > > into this some more...
> > >
> > > Happy to be corrected if I'm misconstruing this!
> > >
> >
> > OK, so I wrote a small program to do perform exactly this case [0] and it seems
> > that the outcome is the same before and after this patch - vma_merge() is
> > clearly rejecting the case 8 merge (phew!) and in both instances you end up with
> > 3 VMAs.
> >
> > So this patch doesn't change this behaviour and everything is as it was
> > before. Ideally we'd let it go for another pass, so maybe we should change the
> > split to add a new VMA _afterwards_. Will experiment with that, separately.
> >
> > But looks like the patch is good as it is.
> >
> > (if you notice something wrong with the repro, etc. do let me know!)
> >
> > [0]: https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e
>
> I think your test case is fine, but... no, this is still not expected. The
> vma should just merge.
>
> So I have another closer look on this specific issue, it seems we have a
> long standing bug on pgoff calculation here when passing that to
> vma_merge().  I've got another patch attached to show what I meant.
>
> To summarize.. now I've got two patches attached:
>
> Patch 1 is something I'd like to propose to replace this patch that fixes
> incorrect use of vma_merge() so it should also eliminate the assertion
> being triggered (I still think this is a regression but I need to check
> which I will do later; I'm not super familiar with maple tree work, maybe
> you or Liam can quickly spot).
>
> Patch 2 fixes the long standing issue of vma not being able to merge in
> above case, and with patch 2 applied it should start merging all right.
>
> Please have a look, thanks.
>
> ---8<---
> From 6bc39028bba246394bb0bafdaeaab7b8dfd1694f Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 16 May 2023 09:03:22 -0400
> Subject: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts part of
>  vma
>
> It seems vma merging with uffd paths is broken with either
> register/unregister, where right now we can feed wrong parameters to
> vma_merge() and it's found by recent patch which moved asserts upwards in
> vma_merge():
>
> https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
>
> The problem is in the current code base we didn't fixup "prev" for the case
> where "start" address can be within the "prev" vma section.  In that case
> we should have "prev" points to the current vma rather than the previous
> one when feeding to vma_merge().
>
> This will eliminate the report and make sure vma_merge() calls will become
> legal again.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 0fd96d6e39ce..7eb88bc74d00 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1458,10 +1458,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	BUG_ON(!found);
>
>  	vma_iter_set(&vmi, start);
> -	prev = vma_prev(&vmi);
> +	vma = vma_find(&vmi, end);
> +	if (!vma)
> +		goto out_unlock;
> +
> +	if (vma->vm_start < start)
> +		prev = vma;
> +	else
> +		prev = vma_prev(&vmi);
>
>  	ret = 0;
> -	for_each_vma_range(vmi, vma, end) {
> +	do {
>  		cond_resched();
>
>  		BUG_ON(!vma_can_userfault(vma, vm_flags));
> @@ -1517,7 +1524,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	skip:
>  		prev = vma;
>  		start = vma->vm_end;
> -	}
> +	} for_each_vma_range(vmi, vma, end);
>
>  out_unlock:
>  	mmap_write_unlock(mm);
> @@ -1624,9 +1631,17 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	BUG_ON(!found);
>
>  	vma_iter_set(&vmi, start);
> -	prev = vma_prev(&vmi);
> +	vma = vma_find(&vmi, end);
> +	if (!vma)
> +		goto out_unlock;
> +
> +	if (vma->vm_start < start)
> +		prev = vma;
> +	else
> +		prev = vma_prev(&vmi);
> +
>  	ret = 0;
> -	for_each_vma_range(vmi, vma, end) {
> +	do {
>  		cond_resched();
>
>  		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> @@ -1692,7 +1707,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	skip:
>  		prev = vma;
>  		start = vma->vm_end;
> -	}
> +	} for_each_vma_range(vmi, vma, end);
>
>  out_unlock:
>  	mmap_write_unlock(mm);
> --
> 2.39.1
>
> From bf61f3c937e9e2ab96ab2bed0005cb7dc74db231 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 16 May 2023 09:39:38 -0400
> Subject: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
>
> We used to not pass in the pgoff correctly when register/unregister uffd
> regions, it caused incorrect behavior on vma merging.
>
> For example, when we have:
>
>   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
>
> Then someone unregisters uffd on range (5-9), it should become:
>
>   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
>
> But with current code it's:
>
>   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
>
> This patch allows such merge to happen correctly.
>
> This behavior seems to have existed since the 1st day of uffd, keep it just
> as a performance optmization and not copy stable.
>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 7eb88bc74d00..891048b4799f 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	bool basic_ioctls;
>  	unsigned long start, end, vma_end;
>  	struct vma_iterator vmi;
> +	pgoff_t pgoff;
>
>  	user_uffdio_register = (struct uffdio_register __user *) arg;
>
> @@ -1489,8 +1490,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		vma_end = min(end, vma->vm_end);
>
>  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> +				 vma->anon_vma, vma->vm_file, pgoff,
>  				 vma_policy(vma),
>  				 ((struct vm_userfaultfd_ctx){ ctx }),
>  				 anon_vma_name(vma));
> @@ -1570,6 +1572,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	unsigned long start, end, vma_end;
>  	const void __user *buf = (void __user *)arg;
>  	struct vma_iterator vmi;
> +	pgoff_t pgoff;
>
>  	ret = -EFAULT;
>  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> @@ -1677,8 +1680,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			uffd_wp_range(vma, start, vma_end - start, false);
>
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> +				 vma->anon_vma, vma->vm_file, pgoff,
>  				 vma_policy(vma),
>  				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
>  		if (prev) {
> --
> 2.39.1
> ---8<---
>
> --
> Peter Xu
>
