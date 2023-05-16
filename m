Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE027058E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjEPUbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjEPUbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF21797
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684269018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OZUKvvsmUzRdElk0fG3u+iDLTdf9wU2zJwy5SM85VOk=;
        b=X2HH6z408er+pUoYSn4t4FJyt4wSJ0a04EtlYv9BR65/9QWlhKjpLR15FCfR9Pt2U8pFEV
        xK/s5Lk4lmL5C54nAS6b0aL7u7jgJAGeLz1xTAEq+JWQICuFZ+yLQOxk/VCe9L/qT05Hh4
        m4xAgad7onmoW7Ive0QrPQmeAOyzqvs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-X5eEDHl3OHSPB9ojuM26mQ-1; Tue, 16 May 2023 16:30:15 -0400
X-MC-Unique: X5eEDHl3OHSPB9ojuM26mQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-61a3c7657aeso23178376d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269015; x=1686861015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZUKvvsmUzRdElk0fG3u+iDLTdf9wU2zJwy5SM85VOk=;
        b=PEmzHhjdtSjIQx+y3938KtIdiKGHuyY8MsqKcrO51FtuFqPQK6IsWMBBQ0uDQ/KbdP
         9YV1/WXZDsxE+I13xUC2c7RP8Wf7RdJNk8O1bHmN/Ntvw59ihGfVY9p0NiwPiCWf7QeO
         Yf0oC4T5FFAD9V7LgUTYj5V7W7PmkNsGtQWL/ao9lVo0g6v3kBu8qDMwtlh2BZpDRB5N
         6q+fLqWXaeO7BcdIXwg36Tbu3kDs0VeISDewnV83TELxfpUQ36ulpygjqSxVGhHttdWC
         7a3p8Hd1GVuXb3Wb1KSKE3Oc9SOyUnQxVbNF8aHzigOMrdZYQ7/BDkxvTojBz2r0OcDF
         UYkw==
X-Gm-Message-State: AC+VfDwXy5+Kx8k65FO8miHi1NcAvusRPzJsilaF4+0i+o1KRGoKkmAL
        OhSzCB/wiOs/6ienJYmS2zpEe/y2yQ823V9DGfoB+Xe6OjKY/UfL7RgP28iA036bALInyuwPHe3
        EFfltmXxMAdZ1Cev7KcKVIUFi
X-Received: by 2002:a05:6214:2126:b0:5ed:c96e:ca4a with SMTP id r6-20020a056214212600b005edc96eca4amr1223667qvc.1.1684269014608;
        Tue, 16 May 2023 13:30:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6XUY1xct8QrMY8iEgQp72wBXJIOCnKV6pAxzeC2tgY//IF7b/rhTCBm2rWVmhUTxDN01WbTQ==
X-Received: by 2002:a05:6214:2126:b0:5ed:c96e:ca4a with SMTP id r6-20020a056214212600b005edc96eca4amr1223573qvc.1.1684269013802;
        Tue, 16 May 2023 13:30:13 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id f8-20020a0cf3c8000000b0061b67ae2ff9sm5879903qvm.121.2023.05.16.13.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:30:13 -0700 (PDT)
Date:   Tue, 16 May 2023 16:30:11 -0400
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
Message-ID: <ZGPn00ZqqQqdmk2e@x1n>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <9739133c-3ee7-4e94-a6a8-783045a50ac6@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9739133c-3ee7-4e94-a6a8-783045a50ac6@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 08:25:13PM +0100, Lorenzo Stoakes wrote:
> On Tue, May 16, 2023 at 11:06:40AM -0400, Peter Xu wrote:
> > On Tue, May 16, 2023 at 12:07:11AM +0100, Lorenzo Stoakes wrote:
> > > On Mon, May 15, 2023 at 11:04:27PM +0100, Lorenzo Stoakes wrote:
> > > [snip]
> > > > > Could you explain a bit why we don't need to merge in this case?
> > > > >
> > > > > I'm considering, for example, when we have:
> > > > >
> > > > >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> > > > >
> > > > > Then someone unregisters uffd on range (5-9), iiuc it should become:
> > > > >
> > > > >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> > > > >
> > > > > But if no merge here it's:
> > > > >
> > > > >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> > > > >
> > > > > Maybe I missed something?
> > > > >
> > > >
> > > > There's something really, really wrong with this. It simply isn't valid to
> > > > invoke vma_merge() over an existing VMA that != prev where you're not
> > > > specifying addr = vma->vm_start, end == vma->vm_end.
> > > >
> > > > This seems like you're relying on:-
> > > >
> > > >   ***
> > > > CCCCCNNNNN -> CCNNNNNNNN
> >
> > I had a closer look today, I still think this patch is not really the right
> > one.  The split/merge order is something we use everywhere and I am not
> > convinced it must change as drastic.  At least so far it still seems to me
> > if we do with what current patch proposed we can have vma fragmentations.
> 
> 'something we use everywhere' is not an argument (speak to Willy about
> folios), vma_merge() expects valid input, relying on it _happening_ to be

I still think it's an argument.

I believe Matthew tried hard to justify he's correct in that aspect when
changing "something we used everywhere". Blindly referencing it doesn't
help much on a technical discussion.

If we have similar code that handles similar things, IMHO you need a reason
to modify one of them to not like the other.

If you think what you proposed is better, please consider (1) justify why
it's better, and then (2) also apply it to all the rest places where
applicable.  Please refer to my reply to Liam on the other use cases of
vma_merge().

Said that, I apprecaite a lot on your assert patch that found this problem.

> ok or to fail in ways that _happen_ not to cause big problems is not right.
> 
> This is just further evidence that the vma_merge() interface is
> fundamentally broken. Implicitly assuming you will only get a partial prev
> overlap merge is far from intuitive.
> 
> I am definitely going to try to do a series addressing vma_merge() horrors
> because I feel like we need a generic means of doing this split/merge pattern.

It'll be great if you can make it better.

> 
> >
> > I think I see what you meant, but here I think it's a legal case where we
> > should have PPPP rather than CCCC (PPPPPNNNN --> PPNNNNNNNN).
> >
> > To be explicit, for register I think it _should_ be the case 0 where we
> > cannot merge (note: the current code is indeed wrong though, see below):
> >
> >    ****
> >   PPPPPPNNNNNN
> >   cannot merge
> >
> > While for the unregister case here it's case 4:
> >
> >     ****
> >   PPPPPPNNNNNN
> >   might become
> >   PPNNNNNNNNNN
> >   case 4 below
> >
> > Here the problem is not that we need to do split then merge (I think it'll
> > have the problem of vma defragmentation here), the problem is we simply
> > passed in the wrong "prev" vma pointer, IMHO.  I've patches attached
> > showing what I meant.
> 
> Yeah if you do it with prev = vma this form should _probably_ work, that's
> a good point. This _is_ a case (see https://ljs.io/vma_merge_cases.png for
> nice diagram of cases btw :), like 5, where we actually do split and merge
> at the same time.

It's not something I came up with myself, it's just that I started looking
back to see what people did and trying to understand why they did it.
Normally people did things with good reasons.

So far it seems clearer at least to me to keep this pattern of "merge then
split".  But I'm happy to be proven wrong anytime.

> 
> Liam's raised some issues with the safety of your patches, let me look at
> them when I get a chance, nasty headcold = brain less functional atm.

Sure, no need to rush.

> 
> I would say for now this fix resolves the issue in a way that should
> emphatically avoid invalid input to vma_merge(), the fragmentation existed
> before so this is not a new issue, so for the time being I think it's ok to
> stay as-is.

So far I would still suggest having uffd code the same as the rest if
possible.

I think I'll wait for the other discussion to settle on patch 2 to see
whether I should post a formal patchset.

> 
> >
> > I checked the original commit from Andrea and I found that it _was_ correct:
> >
> > commit 86039bd3b4e6a1129318cbfed4e0a6e001656635
> > Author: Andrea Arcangeli <aarcange@redhat.com>
> > Date:   Fri Sep 4 15:46:31 2015 -0700
> >
> >     userfaultfd: add new syscall to provide memory externalization
> >
> > I had a feeling that it's broken during the recent rework on vma (or maybe
> > even not that close), but I'm not yet sure and need to further check.
> >
> > > >
> > > > By specifying parameters that are compatible with N even though you're only
> > > > partially spanning C?
> > > >
> > > > This is crazy, and isn't how this should be used. vma_merge() is not
> > > > supposed to do partial merges. If it works (presumably it does) this is not
> > > > by design unless I've lost my mind and I (and others) have somehow not
> > > > noticed this??
> > > >
> > > > I think you're right that now we'll end up with more fragmentation, but
> > > > what you're suggesting is not how vma_merge() is supposed to work.
> > > >
> > > > As I said above, giving vma_merge() invalid parameters is very dangerous as
> > > > you could end up merging over empty ranges in theory (and could otherwise
> > > > have corruption).
> > > >
> > > > I guess we should probably be passing 0 to the last parameter in
> > > > split_vma() here then to ensure we do a merge pass too. Will experiment
> > > > with this.
> > > >
> > > > I'm confused as to how the remove from case 8 is not proceeding. I'll look
> > > > into this some more...
> > > >
> > > > Happy to be corrected if I'm misconstruing this!
> > > >
> > >
> > > OK, so I wrote a small program to do perform exactly this case [0] and it seems
> > > that the outcome is the same before and after this patch - vma_merge() is
> > > clearly rejecting the case 8 merge (phew!) and in both instances you end up with
> > > 3 VMAs.
> > >
> > > So this patch doesn't change this behaviour and everything is as it was
> > > before. Ideally we'd let it go for another pass, so maybe we should change the
> > > split to add a new VMA _afterwards_. Will experiment with that, separately.
> > >
> > > But looks like the patch is good as it is.
> > >
> > > (if you notice something wrong with the repro, etc. do let me know!)
> > >
> > > [0]: https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e
> >
> > I think your test case is fine, but... no, this is still not expected. The
> > vma should just merge.
> >
> > So I have another closer look on this specific issue, it seems we have a
> > long standing bug on pgoff calculation here when passing that to
> > vma_merge().  I've got another patch attached to show what I meant.
> >
> > To summarize.. now I've got two patches attached:
> >
> > Patch 1 is something I'd like to propose to replace this patch that fixes
> > incorrect use of vma_merge() so it should also eliminate the assertion
> > being triggered (I still think this is a regression but I need to check
> > which I will do later; I'm not super familiar with maple tree work, maybe
> > you or Liam can quickly spot).
> >
> > Patch 2 fixes the long standing issue of vma not being able to merge in
> > above case, and with patch 2 applied it should start merging all right.
> >
> > Please have a look, thanks.
> >
> > ---8<---
> > From 6bc39028bba246394bb0bafdaeaab7b8dfd1694f Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Tue, 16 May 2023 09:03:22 -0400
> > Subject: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts part of
> >  vma
> >
> > It seems vma merging with uffd paths is broken with either
> > register/unregister, where right now we can feed wrong parameters to
> > vma_merge() and it's found by recent patch which moved asserts upwards in
> > vma_merge():
> >
> > https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> >
> > The problem is in the current code base we didn't fixup "prev" for the case
> > where "start" address can be within the "prev" vma section.  In that case
> > we should have "prev" points to the current vma rather than the previous
> > one when feeding to vma_merge().
> >
> > This will eliminate the report and make sure vma_merge() calls will become
> > legal again.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  fs/userfaultfd.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 0fd96d6e39ce..7eb88bc74d00 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1458,10 +1458,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  	BUG_ON(!found);
> >
> >  	vma_iter_set(&vmi, start);
> > -	prev = vma_prev(&vmi);
> > +	vma = vma_find(&vmi, end);
> > +	if (!vma)
> > +		goto out_unlock;
> > +
> > +	if (vma->vm_start < start)
> > +		prev = vma;
> > +	else
> > +		prev = vma_prev(&vmi);
> >
> >  	ret = 0;
> > -	for_each_vma_range(vmi, vma, end) {
> > +	do {
> >  		cond_resched();
> >
> >  		BUG_ON(!vma_can_userfault(vma, vm_flags));
> > @@ -1517,7 +1524,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  	skip:
> >  		prev = vma;
> >  		start = vma->vm_end;
> > -	}
> > +	} for_each_vma_range(vmi, vma, end);
> >
> >  out_unlock:
> >  	mmap_write_unlock(mm);
> > @@ -1624,9 +1631,17 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  	BUG_ON(!found);
> >
> >  	vma_iter_set(&vmi, start);
> > -	prev = vma_prev(&vmi);
> > +	vma = vma_find(&vmi, end);
> > +	if (!vma)
> > +		goto out_unlock;
> > +
> > +	if (vma->vm_start < start)
> > +		prev = vma;
> > +	else
> > +		prev = vma_prev(&vmi);
> > +
> >  	ret = 0;
> > -	for_each_vma_range(vmi, vma, end) {
> > +	do {
> >  		cond_resched();
> >
> >  		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> > @@ -1692,7 +1707,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  	skip:
> >  		prev = vma;
> >  		start = vma->vm_end;
> > -	}
> > +	} for_each_vma_range(vmi, vma, end);
> >
> >  out_unlock:
> >  	mmap_write_unlock(mm);
> > --
> > 2.39.1
> >
> > From bf61f3c937e9e2ab96ab2bed0005cb7dc74db231 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Tue, 16 May 2023 09:39:38 -0400
> > Subject: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
> >
> > We used to not pass in the pgoff correctly when register/unregister uffd
> > regions, it caused incorrect behavior on vma merging.
> >
> > For example, when we have:
> >
> >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> >
> > Then someone unregisters uffd on range (5-9), it should become:
> >
> >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> >
> > But with current code it's:
> >
> >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> >
> > This patch allows such merge to happen correctly.
> >
> > This behavior seems to have existed since the 1st day of uffd, keep it just
> > as a performance optmization and not copy stable.
> >
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  fs/userfaultfd.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 7eb88bc74d00..891048b4799f 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  	bool basic_ioctls;
> >  	unsigned long start, end, vma_end;
> >  	struct vma_iterator vmi;
> > +	pgoff_t pgoff;
> >
> >  	user_uffdio_register = (struct uffdio_register __user *) arg;
> >
> > @@ -1489,8 +1490,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  		vma_end = min(end, vma->vm_end);
> >
> >  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> > +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> >  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > +				 vma->anon_vma, vma->vm_file, pgoff,
> >  				 vma_policy(vma),
> >  				 ((struct vm_userfaultfd_ctx){ ctx }),
> >  				 anon_vma_name(vma));
> > @@ -1570,6 +1572,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  	unsigned long start, end, vma_end;
> >  	const void __user *buf = (void __user *)arg;
> >  	struct vma_iterator vmi;
> > +	pgoff_t pgoff;
> >
> >  	ret = -EFAULT;
> >  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> > @@ -1677,8 +1680,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  			uffd_wp_range(vma, start, vma_end - start, false);
> >
> >  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> > +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> >  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > +				 vma->anon_vma, vma->vm_file, pgoff,
> >  				 vma_policy(vma),
> >  				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> >  		if (prev) {
> > --
> > 2.39.1
> > ---8<---
> >
> > --
> > Peter Xu
> >
> 

-- 
Peter Xu

