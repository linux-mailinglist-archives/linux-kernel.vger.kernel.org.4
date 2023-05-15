Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28A3703FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245537AbjEOV3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbjEOV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F05C76BF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684186050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLAGWZc9r370dTDbuAW3pDpGBMgjfCMZQFVPRnk8LJs=;
        b=CJiBsnpLUsiFxsyW/4z3l29eDVw5BrFzGMPhLhBbgzR2zP/9vt+RU0V9/2N8jpWOSMkuYJ
        U5mFRbl0dSWGF09QH7rbWRSyRm39JqEEEzzUn3j/jYQ0JsmLRbWZiqVb5tcNKPcW/fVo7+
        CMt3hdAL/r0VXiVkFuyaeWgFMyW1ISs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-cF_H0g0IOHyMM7H1WkS-CQ-1; Mon, 15 May 2023 17:27:28 -0400
X-MC-Unique: cF_H0g0IOHyMM7H1WkS-CQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-61b636b5f90so13680936d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684186048; x=1686778048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLAGWZc9r370dTDbuAW3pDpGBMgjfCMZQFVPRnk8LJs=;
        b=ReEkiK6hrTzOflNCoA3rnzN4Z32TG5IbXjaLtXzLSs3js8CNZISs6/RlAa52ZA6Bbl
         wIDpY4sKQ0y1XsijIQzuy6+kaQZQP55Ox+qP5qUgEg0XFFYH+UpTc/ljkTpWiv80a2ZM
         36OetePQ2EnyvV9K4MKAwm6XvnlsNBYEnHaGuOcd+FfCLBhtMBc/cqmY9UQ150515rIe
         DQSwguSlhZ975gpnPgz051qvWWUUDUbj3dKOjQiai6RKuyrX9RLzT+cYY3F8v58IogZj
         GLgCTgvNnx07mDN36PaG3MhVozUpHd5ObEPvhjr6exXinjotN5nGGNYmPq4YwOsvdNtM
         xZ1w==
X-Gm-Message-State: AC+VfDwb4BqrbLAsHCR4Kh4th1FPyriRNKRTnRaaTKFTngujWjbJAOLj
        3gi/DMnXu2Nd7FLlZdkBgKg1hyFG8zBeXEcvSUw/p47yM767U2rcTn5fhbYG2w0qZTeumhxUtlj
        0/gkp9w12pKdFPlUyOW8ZpsLH
X-Received: by 2002:a05:6214:4013:b0:623:5678:1285 with SMTP id kd19-20020a056214401300b0062356781285mr1064852qvb.2.1684186048369;
        Mon, 15 May 2023 14:27:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Y/sNMTjAwPK7uyFeaJyLlFymLHqHl/htDJX4fwerRRnvxfxCp9itMwnVX1HXpanMw2QvgQQ==
X-Received: by 2002:a05:6214:4013:b0:623:5678:1285 with SMTP id kd19-20020a056214401300b0062356781285mr1064816qvb.2.1684186047972;
        Mon, 15 May 2023 14:27:27 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a15d500b007579f89c0ccsm102432qkm.29.2023.05.15.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 14:27:27 -0700 (PDT)
Date:   Mon, 15 May 2023 17:27:25 -0400
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
Message-ID: <ZGKjvceDfpKMxtfb@x1n>
References: <20230515193232.67552-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515193232.67552-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 08:32:32PM +0100, Lorenzo Stoakes wrote:
> The userfaultfd_[un]register() functions will knowingly pass an invalid
> address range to vma_merge(), then rely on it failing to merge to indicate
> that the VMA should be split into a valid one.
> 
> This is not something that should be relied upon,

Is there any real issue pop up to show that it's something that we cannot
rely upon before b0729ae0ae67?  Because normally if something broke with a
commit I'll say "commit xxx breaks yyy" unless there's more valid reason.. :)

> as vma_merge() implicitly assumes in cases 5-8 that curr->vm_start ==
> addr. This is now enforced since commit b0729ae0ae67 ("mm/mmap/vma_merge:
> explicitly assign res, vma, extend invariants") with an explicit
> VM_WARN_ON() check.

Doing vma_merge() before vma_split() makes some sense to me (and I noticed
that mostly all vma_merge() paths are doing so), because if a merge
happened, we 100% doesn't need a split (vma_merge took care of everything).
It's not the other way round, since if we split, we could still need a
merge.

So it fundamentally avoids unnecessary calls to split, it seems, if we
always call merge before splits.

> 
> Since commit 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
> this check is performed unconditionally, which caused this assert to arise
> in tests performed by Mark [1].
> 
> This patch fixes the issue by performing the split operations before
> attempting to merge VMAs in both instances. The problematic operation is
> splitting the start of the VMA since we were clamping to the end of the VMA
> in any case, however it is useful to group both of the split operations
> together to avoid egregious goto's and to abstract the code between the
> functions.
> 
> As well as fixing the repro described in [1] this also continues to pass
> uffd unit tests.
> 
> [1]:https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  fs/userfaultfd.c | 108 ++++++++++++++++++++++++++---------------------
>  1 file changed, 60 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 0fd96d6e39ce..ef5d667ea804 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1319,6 +1319,32 @@ static __always_inline int validate_range(struct mm_struct *mm,
>  	return 0;
>  }
>  
> +static int clamp_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +		       unsigned long start, unsigned long end, bool *can_merge)
> +{
> +	int ret;
> +	bool merge = true;
> +
> +	/* The range must always be clamped to the start of a VMA. */
> +	if (vma->vm_start < start) {
> +		ret = split_vma(vmi, vma, start, 1);
> +		if (ret)
> +			return ret;
> +
> +		merge = false;

Could you explain a bit why we don't need to merge in this case?

I'm considering, for example, when we have:

  vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)

Then someone unregisters uffd on range (5-9), iiuc it should become:

  vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)

But if no merge here it's:

  vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)

Maybe I missed something?

> +	}
> +
> +	/* It must also be clamped to the end of a VMA. */
> +	if (vma->vm_end > end) {
> +		ret = split_vma(vmi, vma, end, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*can_merge = merge;
> +	return 0;
> +}
> +
>  static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  				unsigned long arg)
>  {
> @@ -1330,7 +1356,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	unsigned long vm_flags, new_flags;
>  	bool found;
>  	bool basic_ioctls;
> -	unsigned long start, end, vma_end;
> +	unsigned long start, end;
>  	struct vma_iterator vmi;
>  
>  	user_uffdio_register = (struct uffdio_register __user *) arg;
> @@ -1462,6 +1488,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
> +		bool can_merge;
> +
>  		cond_resched();
>  
>  		BUG_ON(!vma_can_userfault(vma, vm_flags));
> @@ -1477,32 +1505,22 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		    (vma->vm_flags & vm_flags) == vm_flags)
>  			goto skip;
>  
> -		if (vma->vm_start > start)
> -			start = vma->vm_start;
> -		vma_end = min(end, vma->vm_end);
> +		ret = clamp_range(&vmi, vma, start, end, &can_merge);
> +		if (ret)
> +			break;
>  
>  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> -				 vma_policy(vma),
> -				 ((struct vm_userfaultfd_ctx){ ctx }),
> -				 anon_vma_name(vma));
> -		if (prev) {
> +		if (can_merge) {
> +			prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end, new_flags,
> +					 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> +					 vma_policy(vma),
> +					 ((struct vm_userfaultfd_ctx){ ctx }),
> +					 anon_vma_name(vma));
> +
>  			/* vma_merge() invalidated the mas */
> -			vma = prev;
> -			goto next;
> -		}
> -		if (vma->vm_start < start) {
> -			ret = split_vma(&vmi, vma, start, 1);
> -			if (ret)
> -				break;
> -		}
> -		if (vma->vm_end > end) {
> -			ret = split_vma(&vmi, vma, end, 0);
> -			if (ret)
> -				break;
> +			if (prev)
> +				vma = prev;
>  		}
> -	next:
>  		/*
>  		 * In the vma_merge() successful mprotect-like case 8:
>  		 * the next vma was merged into the current one and
> @@ -1560,7 +1578,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	struct uffdio_range uffdio_unregister;
>  	unsigned long new_flags;
>  	bool found;
> -	unsigned long start, end, vma_end;
> +	unsigned long start, end;
>  	const void __user *buf = (void __user *)arg;
>  	struct vma_iterator vmi;
>  
> @@ -1627,6 +1645,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	prev = vma_prev(&vmi);
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
> +		bool can_merge;
> +
>  		cond_resched();
>  
>  		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> @@ -1640,9 +1660,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  
>  		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
>  
> -		if (vma->vm_start > start)
> -			start = vma->vm_start;
> -		vma_end = min(end, vma->vm_end);
> +		ret = clamp_range(&vmi, vma, start, end, &can_merge);
> +		if (ret)
> +			break;
>  
>  		if (userfaultfd_missing(vma)) {
>  			/*
> @@ -1652,35 +1672,27 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			 * UFFDIO_WAKE explicitly.
>  			 */
>  			struct userfaultfd_wake_range range;
> -			range.start = start;
> -			range.len = vma_end - start;
> +			range.start = vma->vm_start;
> +			range.len = vma->vm_end - vma->vm_start;
>  			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
>  		}
>  
>  		/* Reset ptes for the whole vma range if wr-protected */
>  		if (userfaultfd_wp(vma))
> -			uffd_wp_range(vma, start, vma_end - start, false);
> +			uffd_wp_range(vma, vma->vm_start,
> +				      vma->vm_end - vma->vm_start, false);
>  
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> -				 vma_policy(vma),
> -				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> -		if (prev) {
> -			vma = prev;
> -			goto next;
> -		}
> -		if (vma->vm_start < start) {
> -			ret = split_vma(&vmi, vma, start, 1);
> -			if (ret)
> -				break;
> -		}
> -		if (vma->vm_end > end) {
> -			ret = split_vma(&vmi, vma, end, 0);
> -			if (ret)
> -				break;
> +		if (can_merge) {
> +			prev = vma_merge(&vmi, mm, prev, vma->vm_start,
> +					 vma->vm_end, new_flags, vma->anon_vma,
> +					 vma->vm_file, vma->vm_pgoff,
> +					 vma_policy(vma),
> +					 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> +			/* vma_merge() invalidated the mas */
> +			if (prev)
> +				vma = prev;
>  		}
> -	next:
>  		/*
>  		 * In the vma_merge() successful mprotect-like case 8:
>  		 * the next vma was merged into the current one and
> -- 
> 2.40.1
> 

-- 
Peter Xu

