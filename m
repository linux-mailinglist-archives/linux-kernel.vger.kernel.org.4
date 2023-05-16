Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBE705937
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjEPVBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEPVBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:01:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB059FB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:01:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307a8386946so6291235f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270869; x=1686862869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQqCTjoQUL1lQZoHW6boklmlGLzu4MlvfFMZaYOaWpY=;
        b=rZ5cNIibOT2+khGvh2QFBkT6PB7qCiivSJDdLSbV3ysrp9CBrVuI8Cj97SLMrHV3SH
         oKl6Ge6D8Xcl7q1k8tOThX5HQTcGHsIhPakhJDc7xA+ZvuQa6YXtzM6IlneT3I7OvOVx
         w5ZAbBMdWoLJPk54hFewKBr0vSF4oicVABs7nxAYJjEcD+847nw9gH32sLi9kwjcB/WU
         TpgD1P0yvYE8uP+ev0Mq1B2C2Drz6igzAHtrmbNNdhPytDHT2fekJ0YoVp24X9yAXQrz
         VQVRs3VDXgEIZQkI0MCflKk4WRZlG5ikq33HURoWzx2841GGcA2Y/X3uFWyqQYy17jNV
         3zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270869; x=1686862869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQqCTjoQUL1lQZoHW6boklmlGLzu4MlvfFMZaYOaWpY=;
        b=JCbJjELgB09A494SJWXXPaHwEL5/e8cwy9sdO6MI/1npY0w89aR85IJ20Lischm2BQ
         lIt6TkvblUR6cPAbXtB4uf67TZo06tg3dtrnRaJONeLvxkGKjbw620Ec7sw3Vg7IlOve
         OZVAzhFH1NBR+RtSa0poSEuTIRwF5OXvz2vQKg7fW98QDOyih5Vc/lBNfSbbauzmWwL8
         ATL4zuBeOjdHmG7tt27t2J9uxJTBbcBG7tTif8QavZipsv9TQzwJTwlSedOo6fV9Q0Xn
         4Grq6sRdWSrZkE7DswZRHi1R4uOHMwt8rcYZ8A6H+kRT9t9ePVB3PSI9prWgE4Qfarz6
         T92A==
X-Gm-Message-State: AC+VfDxS6BlStkHyoYsdGG3cgBNs5w2cUlJ7yOePxLTDGWqQ1YCdVB9W
        wI9yHw+Ql54vy7BnDhX4wWQ=
X-Google-Smtp-Source: ACHHUZ4Nx2hOgy0xAG4+aa/bb6NVZWOiXRtkUT5J2m1jEV9ouhEk1UOAqtaTWH8IA4g8Ki10HCBBQQ==
X-Received: by 2002:a5d:560a:0:b0:304:6d32:d589 with SMTP id l10-20020a5d560a000000b003046d32d589mr26145452wrv.18.1684270868475;
        Tue, 16 May 2023 14:01:08 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id g6-20020adfe406000000b003093946ea60sm452816wrm.46.2023.05.16.14.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:01:07 -0700 (PDT)
Date:   Tue, 16 May 2023 22:01:06 +0100
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
Message-ID: <e90c2b38-805b-4df1-abdd-8ee460b12b72@lucifer.local>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <9739133c-3ee7-4e94-a6a8-783045a50ac6@lucifer.local>
 <ZGPn00ZqqQqdmk2e@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGPn00ZqqQqdmk2e@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 04:30:11PM -0400, Peter Xu wrote:
> On Tue, May 16, 2023 at 08:25:13PM +0100, Lorenzo Stoakes wrote:
> > On Tue, May 16, 2023 at 11:06:40AM -0400, Peter Xu wrote:
> > > On Tue, May 16, 2023 at 12:07:11AM +0100, Lorenzo Stoakes wrote:
> > > > On Mon, May 15, 2023 at 11:04:27PM +0100, Lorenzo Stoakes wrote:
> > > > [snip]
> > > > > > Could you explain a bit why we don't need to merge in this case?
> > > > > >
> > > > > > I'm considering, for example, when we have:
> > > > > >
> > > > > >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> > > > > >
> > > > > > Then someone unregisters uffd on range (5-9), iiuc it should become:
> > > > > >
> > > > > >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> > > > > >
> > > > > > But if no merge here it's:
> > > > > >
> > > > > >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> > > > > >
> > > > > > Maybe I missed something?
> > > > > >
> > > > >
> > > > > There's something really, really wrong with this. It simply isn't valid to
> > > > > invoke vma_merge() over an existing VMA that != prev where you're not
> > > > > specifying addr = vma->vm_start, end == vma->vm_end.
> > > > >
> > > > > This seems like you're relying on:-
> > > > >
> > > > >   ***
> > > > > CCCCCNNNNN -> CCNNNNNNNN
> > >
> > > I had a closer look today, I still think this patch is not really the right
> > > one.  The split/merge order is something we use everywhere and I am not
> > > convinced it must change as drastic.  At least so far it still seems to me
> > > if we do with what current patch proposed we can have vma fragmentations.
> >
> > 'something we use everywhere' is not an argument (speak to Willy about
> > folios), vma_merge() expects valid input, relying on it _happening_ to be
>
> I still think it's an argument.
>
> I believe Matthew tried hard to justify he's correct in that aspect when
> changing "something we used everywhere". Blindly referencing it doesn't
> help much on a technical discussion.
>
> If we have similar code that handles similar things, IMHO you need a reason
> to modify one of them to not like the other.
>
> If you think what you proposed is better, please consider (1) justify why
> it's better, and then (2) also apply it to all the rest places where
> applicable.  Please refer to my reply to Liam on the other use cases of
> vma_merge().
>
> Said that, I apprecaite a lot on your assert patch that found this problem.
>
> > ok or to fail in ways that _happen_ not to cause big problems is not right.
> >
> > This is just further evidence that the vma_merge() interface is
> > fundamentally broken. Implicitly assuming you will only get a partial prev
> > overlap merge is far from intuitive.
> >
> > I am definitely going to try to do a series addressing vma_merge() horrors
> > because I feel like we need a generic means of doing this split/merge pattern.
>
> It'll be great if you can make it better.
>
> >
> > >
> > > I think I see what you meant, but here I think it's a legal case where we
> > > should have PPPP rather than CCCC (PPPPPNNNN --> PPNNNNNNNN).
> > >
> > > To be explicit, for register I think it _should_ be the case 0 where we
> > > cannot merge (note: the current code is indeed wrong though, see below):
> > >
> > >    ****
> > >   PPPPPPNNNNNN
> > >   cannot merge
> > >
> > > While for the unregister case here it's case 4:
> > >
> > >     ****
> > >   PPPPPPNNNNNN
> > >   might become
> > >   PPNNNNNNNNNN
> > >   case 4 below
> > >
> > > Here the problem is not that we need to do split then merge (I think it'll
> > > have the problem of vma defragmentation here), the problem is we simply
> > > passed in the wrong "prev" vma pointer, IMHO.  I've patches attached
> > > showing what I meant.
> >
> > Yeah if you do it with prev = vma this form should _probably_ work, that's
> > a good point. This _is_ a case (see https://ljs.io/vma_merge_cases.png for
> > nice diagram of cases btw :), like 5, where we actually do split and merge
> > at the same time.
>
> It's not something I came up with myself, it's just that I started looking
> back to see what people did and trying to understand why they did it.
> Normally people did things with good reasons.
>

Yup, it's an iffy pattern in each case. I can see why you chose to do it,
it's not a criticism of that, it's just that the incorrect (but
accidentally ok to be incorrect seemingly) input is made more obvious by
recent changes.

> So far it seems clearer at least to me to keep this pattern of "merge then
> split".  But I'm happy to be proven wrong anytime.

But you're not, you're doing a vma_merge() and (without it being clear)
hoping it does a merge AND SPLIT in case in an instance where that might be
required followed by you doing any further splits required.

But it's _not your fault_ that this is the standard approach, it's the
interface that's wrong absolutely.

To me doing this is quite a bit less clear than simply 'splitting so this
is mergable first then try to merge' but obviously this current patch does
not avoid the previously introduced fragmentation. However it does maintain
existing behaviour.

>
> >
> > Liam's raised some issues with the safety of your patches, let me look at
> > them when I get a chance, nasty headcold = brain less functional atm.
>
> Sure, no need to rush.
>
> >
> > I would say for now this fix resolves the issue in a way that should
> > emphatically avoid invalid input to vma_merge(), the fragmentation existed
> > before so this is not a new issue, so for the time being I think it's ok to
> > stay as-is.
>
> So far I would still suggest having uffd code the same as the rest if
> possible.
>

Absolutely, but in the immediate term, we are seeing VM_WARN_ON()'s here
and not from other callers (which is actually surprising).

Again, we absolutely do need an abstracted solution for the whole. And
that's something I'll try to work on!

> I think I'll wait for the other discussion to settle on patch 2 to see
> whether I should post a formal patchset.

My suggestion is that it's ok to proceed as-is, not because this is the
final change that should be applied, but rather because it resolves the
issue while maintaining existing behaviour.

I will be more than happy to see patches land after this one that replace
it if necessary but I think it's safe for this to land as a mainline fixup,
even if temporary, is all I am saying :)

>
> >
> > >
> > > I checked the original commit from Andrea and I found that it _was_ correct:
> > >
> > > commit 86039bd3b4e6a1129318cbfed4e0a6e001656635
> > > Author: Andrea Arcangeli <aarcange@redhat.com>
> > > Date:   Fri Sep 4 15:46:31 2015 -0700
> > >
> > >     userfaultfd: add new syscall to provide memory externalization
> > >
> > > I had a feeling that it's broken during the recent rework on vma (or maybe
> > > even not that close), but I'm not yet sure and need to further check.
> > >
> > > > >
> > > > > By specifying parameters that are compatible with N even though you're only
> > > > > partially spanning C?
> > > > >
> > > > > This is crazy, and isn't how this should be used. vma_merge() is not
> > > > > supposed to do partial merges. If it works (presumably it does) this is not
> > > > > by design unless I've lost my mind and I (and others) have somehow not
> > > > > noticed this??
> > > > >
> > > > > I think you're right that now we'll end up with more fragmentation, but
> > > > > what you're suggesting is not how vma_merge() is supposed to work.
> > > > >
> > > > > As I said above, giving vma_merge() invalid parameters is very dangerous as
> > > > > you could end up merging over empty ranges in theory (and could otherwise
> > > > > have corruption).
> > > > >
> > > > > I guess we should probably be passing 0 to the last parameter in
> > > > > split_vma() here then to ensure we do a merge pass too. Will experiment
> > > > > with this.
> > > > >
> > > > > I'm confused as to how the remove from case 8 is not proceeding. I'll look
> > > > > into this some more...
> > > > >
> > > > > Happy to be corrected if I'm misconstruing this!
> > > > >
> > > >
> > > > OK, so I wrote a small program to do perform exactly this case [0] and it seems
> > > > that the outcome is the same before and after this patch - vma_merge() is
> > > > clearly rejecting the case 8 merge (phew!) and in both instances you end up with
> > > > 3 VMAs.
> > > >
> > > > So this patch doesn't change this behaviour and everything is as it was
> > > > before. Ideally we'd let it go for another pass, so maybe we should change the
> > > > split to add a new VMA _afterwards_. Will experiment with that, separately.
> > > >
> > > > But looks like the patch is good as it is.
> > > >
> > > > (if you notice something wrong with the repro, etc. do let me know!)
> > > >
> > > > [0]: https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e
> > >
> > > I think your test case is fine, but... no, this is still not expected. The
> > > vma should just merge.
> > >
> > > So I have another closer look on this specific issue, it seems we have a
> > > long standing bug on pgoff calculation here when passing that to
> > > vma_merge().  I've got another patch attached to show what I meant.
> > >
> > > To summarize.. now I've got two patches attached:
> > >
> > > Patch 1 is something I'd like to propose to replace this patch that fixes
> > > incorrect use of vma_merge() so it should also eliminate the assertion
> > > being triggered (I still think this is a regression but I need to check
> > > which I will do later; I'm not super familiar with maple tree work, maybe
> > > you or Liam can quickly spot).
> > >
> > > Patch 2 fixes the long standing issue of vma not being able to merge in
> > > above case, and with patch 2 applied it should start merging all right.
> > >
> > > Please have a look, thanks.
> > >
> > > ---8<---
> > > From 6bc39028bba246394bb0bafdaeaab7b8dfd1694f Mon Sep 17 00:00:00 2001
> > > From: Peter Xu <peterx@redhat.com>
> > > Date: Tue, 16 May 2023 09:03:22 -0400
> > > Subject: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts part of
> > >  vma
> > >
> > > It seems vma merging with uffd paths is broken with either
> > > register/unregister, where right now we can feed wrong parameters to
> > > vma_merge() and it's found by recent patch which moved asserts upwards in
> > > vma_merge():
> > >
> > > https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> > >
> > > The problem is in the current code base we didn't fixup "prev" for the case
> > > where "start" address can be within the "prev" vma section.  In that case
> > > we should have "prev" points to the current vma rather than the previous
> > > one when feeding to vma_merge().
> > >
> > > This will eliminate the report and make sure vma_merge() calls will become
> > > legal again.
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  fs/userfaultfd.c | 27 +++++++++++++++++++++------
> > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index 0fd96d6e39ce..7eb88bc74d00 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -1458,10 +1458,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >  	BUG_ON(!found);
> > >
> > >  	vma_iter_set(&vmi, start);
> > > -	prev = vma_prev(&vmi);
> > > +	vma = vma_find(&vmi, end);
> > > +	if (!vma)
> > > +		goto out_unlock;
> > > +
> > > +	if (vma->vm_start < start)
> > > +		prev = vma;
> > > +	else
> > > +		prev = vma_prev(&vmi);
> > >
> > >  	ret = 0;
> > > -	for_each_vma_range(vmi, vma, end) {
> > > +	do {
> > >  		cond_resched();
> > >
> > >  		BUG_ON(!vma_can_userfault(vma, vm_flags));
> > > @@ -1517,7 +1524,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >  	skip:
> > >  		prev = vma;
> > >  		start = vma->vm_end;
> > > -	}
> > > +	} for_each_vma_range(vmi, vma, end);
> > >
> > >  out_unlock:
> > >  	mmap_write_unlock(mm);
> > > @@ -1624,9 +1631,17 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > >  	BUG_ON(!found);
> > >
> > >  	vma_iter_set(&vmi, start);
> > > -	prev = vma_prev(&vmi);
> > > +	vma = vma_find(&vmi, end);
> > > +	if (!vma)
> > > +		goto out_unlock;
> > > +
> > > +	if (vma->vm_start < start)
> > > +		prev = vma;
> > > +	else
> > > +		prev = vma_prev(&vmi);
> > > +
> > >  	ret = 0;
> > > -	for_each_vma_range(vmi, vma, end) {
> > > +	do {
> > >  		cond_resched();
> > >
> > >  		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> > > @@ -1692,7 +1707,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > >  	skip:
> > >  		prev = vma;
> > >  		start = vma->vm_end;
> > > -	}
> > > +	} for_each_vma_range(vmi, vma, end);
> > >
> > >  out_unlock:
> > >  	mmap_write_unlock(mm);
> > > --
> > > 2.39.1
> > >
> > > From bf61f3c937e9e2ab96ab2bed0005cb7dc74db231 Mon Sep 17 00:00:00 2001
> > > From: Peter Xu <peterx@redhat.com>
> > > Date: Tue, 16 May 2023 09:39:38 -0400
> > > Subject: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
> > >
> > > We used to not pass in the pgoff correctly when register/unregister uffd
> > > regions, it caused incorrect behavior on vma merging.
> > >
> > > For example, when we have:
> > >
> > >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> > >
> > > Then someone unregisters uffd on range (5-9), it should become:
> > >
> > >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> > >
> > > But with current code it's:
> > >
> > >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> > >
> > > This patch allows such merge to happen correctly.
> > >
> > > This behavior seems to have existed since the 1st day of uffd, keep it just
> > > as a performance optmization and not copy stable.
> > >
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  fs/userfaultfd.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index 7eb88bc74d00..891048b4799f 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >  	bool basic_ioctls;
> > >  	unsigned long start, end, vma_end;
> > >  	struct vma_iterator vmi;
> > > +	pgoff_t pgoff;
> > >
> > >  	user_uffdio_register = (struct uffdio_register __user *) arg;
> > >
> > > @@ -1489,8 +1490,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >  		vma_end = min(end, vma->vm_end);
> > >
> > >  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> > > +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > >  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > > -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > > +				 vma->anon_vma, vma->vm_file, pgoff,
> > >  				 vma_policy(vma),
> > >  				 ((struct vm_userfaultfd_ctx){ ctx }),
> > >  				 anon_vma_name(vma));
> > > @@ -1570,6 +1572,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > >  	unsigned long start, end, vma_end;
> > >  	const void __user *buf = (void __user *)arg;
> > >  	struct vma_iterator vmi;
> > > +	pgoff_t pgoff;
> > >
> > >  	ret = -EFAULT;
> > >  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> > > @@ -1677,8 +1680,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > >  			uffd_wp_range(vma, start, vma_end - start, false);
> > >
> > >  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> > > +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > >  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > > -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > > +				 vma->anon_vma, vma->vm_file, pgoff,
> > >  				 vma_policy(vma),
> > >  				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> > >  		if (prev) {
> > > --
> > > 2.39.1
> > > ---8<---
> > >
> > > --
> > > Peter Xu
> > >
> >
>
> --
> Peter Xu
>
>
