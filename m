Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27A47040B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343499AbjEOWHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245757AbjEOWGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:06:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710AD14343
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:05:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so4486575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684188270; x=1686780270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cSvPVoiCn57nMsLWzPvcPZUA4BS16HWMDqe9J36ZX7E=;
        b=EcIdARgDpRT19hPj2649Ozz+EIo53L3HBq475wpPPO0sAqX6K7urmGJ7Vddaw8loQZ
         tdk2xFKp/+mZ4fOqxLD3i8rsxRqrbZYPmM9yDZgy/wQ9V5igAUCqVK6pELt1HJi+kPGZ
         Wc/M7np7cF3qAPg0kpLDMt2Y/1fZGj/MLR8gVW0Fs+KuHxf25PWZWP02EBrKquIOt4ub
         q/GExDLqFFKRbORDh/Bzfh01L+br8CTlJRi+Bw4cHfHotX9OGADSGh3AEMUxzbGpAVHe
         s9y/6xKsRQgGLKDAdD6ywTlGt2tFALBbR36UGd61l/VDtH0+3ZepH/jYpCS8B8s+UC3I
         eEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684188270; x=1686780270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSvPVoiCn57nMsLWzPvcPZUA4BS16HWMDqe9J36ZX7E=;
        b=WedA8rLeZ6szH6cDIzhRmOygKHXpcLvjmVezGrbLe4sqel1AIYHweBnk/p/pfCjeYS
         q8hLdCtR6S6G1BoxGKnFoHFMVC4ZRf9k66/3dqe5EMUj4aL2Mpb2lsS+IfvZ9VKdT1AG
         Ik/j13HciCytVOWcirNFBmTpmtQ5ihTZ6fWM8Y3JkDs/pJhhxd1modpDbr+z8Fo571EA
         FWZXa/WQ/YRAAtkOmpHuPz8ZSY9dAd4aHLNbe+7+p0e//WllfpN7HpjCRmAWM9ycokCs
         AAbOHufNWu1p4tZoZMYFRrHOKQh2m4xLELHHOert/qER5zd3gcIXJ8PD7Q97F2D1sHzz
         0Ing==
X-Gm-Message-State: AC+VfDy1jsz7jGyAuALA0mye91c+SB7ctY4/RwClNApjnV2SnaA98mle
        lzZYKfyRXKkRfJJ/2lOUboU=
X-Google-Smtp-Source: ACHHUZ4HQVJ7rpyJAny7K16ChneTORoAUS58g1bFlXJC/ClNMdCF1AlbsQl0SIKy49NG2tlUVOKRnA==
X-Received: by 2002:a5d:4085:0:b0:307:f75:f581 with SMTP id o5-20020a5d4085000000b003070f75f581mr27321983wrp.18.1684188269337;
        Mon, 15 May 2023 15:04:29 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id c9-20020a056000104900b00306c5900c10sm428193wrx.9.2023.05.15.15.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:04:28 -0700 (PDT)
Date:   Mon, 15 May 2023 23:04:27 +0100
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
Message-ID: <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKjvceDfpKMxtfb@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 05:27:25PM -0400, Peter Xu wrote:
> On Mon, May 15, 2023 at 08:32:32PM +0100, Lorenzo Stoakes wrote:
> > The userfaultfd_[un]register() functions will knowingly pass an invalid
> > address range to vma_merge(), then rely on it failing to merge to indicate
> > that the VMA should be split into a valid one.
> >
> > This is not something that should be relied upon,
>
> Is there any real issue pop up to show that it's something that we cannot
> rely upon before b0729ae0ae67?  Because normally if something broke with a
> commit I'll say "commit xxx breaks yyy" unless there's more valid reason.. :)

I mean firstly this is triggering warnings in the kernel as referenced in thread
[1], this is reason enough :)

However, vma_merge() assumes that you won't give it an invalid input range (in
this instance, because you provide start that occurs prior to the beginning of
the VMA).

Giving an invalid input range like this is disasterous, as it could result in a
situation such as e.g.:-

- addr == prev->vm_end
- addr != vma->vm_start (i.e. there is a gap)
- prev and vma are otherwise compatible

This would then trigger the merge_prev cases and you'll end up with something
very broken.

I expect this is simply not possible because the input will never be like this
(it's clamped to be _within_ a VMA anyway and if the prev was compatible it'd
already have been merged), but that is relying on an implementation detail.


>
> > as vma_merge() implicitly assumes in cases 5-8 that curr->vm_start ==
> > addr. This is now enforced since commit b0729ae0ae67 ("mm/mmap/vma_merge:
> > explicitly assign res, vma, extend invariants") with an explicit
> > VM_WARN_ON() check.
>
> Doing vma_merge() before vma_split() makes some sense to me (and I noticed
> that mostly all vma_merge() paths are doing so), because if a merge
> happened, we 100% doesn't need a split (vma_merge took care of everything).
> It's not the other way round, since if we split, we could still need a
> merge.
>

You only split if start/end are not clamped to the VMA, and in cases where you'd
need to split, you could not merge. So I don't think this is true.

> So it fundamentally avoids unnecessary calls to split, it seems, if we
> always call merge before splits.

No, because for the case of splitting the beginning of the VMA, you would have
given invalid input to vma_merge() and returned NULL, then had to split anyway.

For the case of splitting the end of the VMA, that part would have to be split
in any case, this just changes the ordering.

So I disagree that this adds work, it does the same thing only this time using
vma_merge() correctly.

(update after seeing below bit) - vma_merge() is not meant to do 'partial'
merges over a non-prev VMA, and relying on it to do so is broken.

>
> >
> > Since commit 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
> > this check is performed unconditionally, which caused this assert to arise
> > in tests performed by Mark [1].
> >
> > This patch fixes the issue by performing the split operations before
> > attempting to merge VMAs in both instances. The problematic operation is
> > splitting the start of the VMA since we were clamping to the end of the VMA
> > in any case, however it is useful to group both of the split operations
> > together to avoid egregious goto's and to abstract the code between the
> > functions.
> >
> > As well as fixing the repro described in [1] this also continues to pass
> > uffd unit tests.
> >
> > [1]:https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com
> >
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  fs/userfaultfd.c | 108 ++++++++++++++++++++++++++---------------------
> >  1 file changed, 60 insertions(+), 48 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 0fd96d6e39ce..ef5d667ea804 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1319,6 +1319,32 @@ static __always_inline int validate_range(struct mm_struct *mm,
> >  	return 0;
> >  }
> >
> > +static int clamp_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > +		       unsigned long start, unsigned long end, bool *can_merge)
> > +{
> > +	int ret;
> > +	bool merge = true;
> > +
> > +	/* The range must always be clamped to the start of a VMA. */
> > +	if (vma->vm_start < start) {
> > +		ret = split_vma(vmi, vma, start, 1);
> > +		if (ret)
> > +			return ret;
> > +
> > +		merge = false;
>
> Could you explain a bit why we don't need to merge in this case?
>
> I'm considering, for example, when we have:
>
>   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
>
> Then someone unregisters uffd on range (5-9), iiuc it should become:
>
>   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
>
> But if no merge here it's:
>
>   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
>
> Maybe I missed something?
>

There's something really, really wrong with this. It simply isn't valid to
invoke vma_merge() over an existing VMA that != prev where you're not
specifying addr = vma->vm_start, end == vma->vm_end.

This seems like you're relying on:-

  ***
CCCCCNNNNN -> CCNNNNNNNN

By specifying parameters that are compatible with N even though you're only
partially spanning C?

This is crazy, and isn't how this should be used. vma_merge() is not
supposed to do partial merges. If it works (presumably it does) this is not
by design unless I've lost my mind and I (and others) have somehow not
noticed this??

I think you're right that now we'll end up with more fragmentation, but
what you're suggesting is not how vma_merge() is supposed to work.

As I said above, giving vma_merge() invalid parameters is very dangerous as
you could end up merging over empty ranges in theory (and could otherwise
have corruption).

I guess we should probably be passing 0 to the last parameter in
split_vma() here then to ensure we do a merge pass too. Will experiment
with this.

I'm confused as to how the remove from case 8 is not proceeding. I'll look
into this some more...

Happy to be corrected if I'm misconstruing this!

> > +	}
> > +
> > +	/* It must also be clamped to the end of a VMA. */
> > +	if (vma->vm_end > end) {
> > +		ret = split_vma(vmi, vma, end, 0);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*can_merge = merge;
> > +	return 0;
> > +}
> > +
> >  static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  				unsigned long arg)
> >  {
> > @@ -1330,7 +1356,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  	unsigned long vm_flags, new_flags;
> >  	bool found;
> >  	bool basic_ioctls;
> > -	unsigned long start, end, vma_end;
> > +	unsigned long start, end;
> >  	struct vma_iterator vmi;
> >
> >  	user_uffdio_register = (struct uffdio_register __user *) arg;
> > @@ -1462,6 +1488,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >
> >  	ret = 0;
> >  	for_each_vma_range(vmi, vma, end) {
> > +		bool can_merge;
> > +
> >  		cond_resched();
> >
> >  		BUG_ON(!vma_can_userfault(vma, vm_flags));
> > @@ -1477,32 +1505,22 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  		    (vma->vm_flags & vm_flags) == vm_flags)
> >  			goto skip;
> >
> > -		if (vma->vm_start > start)
> > -			start = vma->vm_start;
> > -		vma_end = min(end, vma->vm_end);
> > +		ret = clamp_range(&vmi, vma, start, end, &can_merge);
> > +		if (ret)
> > +			break;
> >
> >  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> > -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > -				 vma_policy(vma),
> > -				 ((struct vm_userfaultfd_ctx){ ctx }),
> > -				 anon_vma_name(vma));
> > -		if (prev) {
> > +		if (can_merge) {
> > +			prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end, new_flags,
> > +					 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > +					 vma_policy(vma),
> > +					 ((struct vm_userfaultfd_ctx){ ctx }),
> > +					 anon_vma_name(vma));
> > +
> >  			/* vma_merge() invalidated the mas */
> > -			vma = prev;
> > -			goto next;
> > -		}
> > -		if (vma->vm_start < start) {
> > -			ret = split_vma(&vmi, vma, start, 1);
> > -			if (ret)
> > -				break;
> > -		}
> > -		if (vma->vm_end > end) {
> > -			ret = split_vma(&vmi, vma, end, 0);
> > -			if (ret)
> > -				break;
> > +			if (prev)
> > +				vma = prev;
> >  		}
> > -	next:
> >  		/*
> >  		 * In the vma_merge() successful mprotect-like case 8:
> >  		 * the next vma was merged into the current one and
> > @@ -1560,7 +1578,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  	struct uffdio_range uffdio_unregister;
> >  	unsigned long new_flags;
> >  	bool found;
> > -	unsigned long start, end, vma_end;
> > +	unsigned long start, end;
> >  	const void __user *buf = (void __user *)arg;
> >  	struct vma_iterator vmi;
> >
> > @@ -1627,6 +1645,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  	prev = vma_prev(&vmi);
> >  	ret = 0;
> >  	for_each_vma_range(vmi, vma, end) {
> > +		bool can_merge;
> > +
> >  		cond_resched();
> >
> >  		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> > @@ -1640,9 +1660,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >
> >  		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> >
> > -		if (vma->vm_start > start)
> > -			start = vma->vm_start;
> > -		vma_end = min(end, vma->vm_end);
> > +		ret = clamp_range(&vmi, vma, start, end, &can_merge);
> > +		if (ret)
> > +			break;
> >
> >  		if (userfaultfd_missing(vma)) {
> >  			/*
> > @@ -1652,35 +1672,27 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  			 * UFFDIO_WAKE explicitly.
> >  			 */
> >  			struct userfaultfd_wake_range range;
> > -			range.start = start;
> > -			range.len = vma_end - start;
> > +			range.start = vma->vm_start;
> > +			range.len = vma->vm_end - vma->vm_start;
> >  			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
> >  		}
> >
> >  		/* Reset ptes for the whole vma range if wr-protected */
> >  		if (userfaultfd_wp(vma))
> > -			uffd_wp_range(vma, start, vma_end - start, false);
> > +			uffd_wp_range(vma, vma->vm_start,
> > +				      vma->vm_end - vma->vm_start, false);
> >
> >  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> > -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > -				 vma_policy(vma),
> > -				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> > -		if (prev) {
> > -			vma = prev;
> > -			goto next;
> > -		}
> > -		if (vma->vm_start < start) {
> > -			ret = split_vma(&vmi, vma, start, 1);
> > -			if (ret)
> > -				break;
> > -		}
> > -		if (vma->vm_end > end) {
> > -			ret = split_vma(&vmi, vma, end, 0);
> > -			if (ret)
> > -				break;
> > +		if (can_merge) {
> > +			prev = vma_merge(&vmi, mm, prev, vma->vm_start,
> > +					 vma->vm_end, new_flags, vma->anon_vma,
> > +					 vma->vm_file, vma->vm_pgoff,
> > +					 vma_policy(vma),
> > +					 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> > +			/* vma_merge() invalidated the mas */
> > +			if (prev)
> > +				vma = prev;
> >  		}
> > -	next:
> >  		/*
> >  		 * In the vma_merge() successful mprotect-like case 8:
> >  		 * the next vma was merged into the current one and
> > --
> > 2.40.1
> >
>
> --
> Peter Xu
>
