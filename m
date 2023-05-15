Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3AC70250A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbjEOGlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbjEOGlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E13114
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E9F260E8B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C259BC433EF;
        Mon, 15 May 2023 06:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684132864;
        bh=90nfYyKZYy7ckcCwJAbM9ZsaLtxOr/tA8/EOpxCc+Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ju4QNzqn7rtY5ee/fl+UyxVA/jHCEnpVdiAJraM97ffhN2YlyPfA1yB7Ug8aykSZt
         NkUxo4gvz5QP6+nI08Qz1rbQ32jtC9zl5ZM8TfWo35Gq2/WYY7HBhLJ4VKNt9V5gxq
         W7RAne6Txu9244BZhk7DiWDF+PcUy748mTRrp5XtTVsneDS0hAp/FJcz4g94JaK0op
         R2k/dqP2DHMEZHH/qLASp+hk8Rehjo+o8oj7WcSyFRvJAtn6Ko4yTXcBToy/noCy98
         eeQX+4CS3Xfu6eNxOMAi3DfDXx1vw8Ye7g7cdL6YHyEV1Kajv15EGQ3oDo7gPSQea1
         mbjOWEtUjGTEQ==
Date:   Mon, 15 May 2023 09:40:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH for 6.4-rcX] mm: userfaultfd: avoid passing an invalid
 range to vma_merge()
Message-ID: <ZGHT8q7TIsDWyXzK@kernel.org>
References: <20230514172731.134188-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514172731.134188-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 06:27:31PM +0100, Lorenzo Stoakes wrote:
> The userfaultfd_[un]register() functions will knowingly pass an invalid
> address range to vma_merge(), then rely on it failing to merge to indicate
> that the VMA should be split into a valid one.
> 
> This is not something that should be relied upon, as vma_merge() implicitly
> assumes in cases 5-8 that curr->vm_start == addr. This is now enforced
> since commit b0729ae0ae67 ("mm/mmap/vma_merge: explicitly assign res, vma,
> extend invariants") with an explicit VM_WARN_ON() check.
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
>  fs/userfaultfd.c | 111 +++++++++++++++++++++++++++--------------------
>  1 file changed, 63 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 0fd96d6e39ce..4453e7040157 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1319,6 +1319,35 @@ static __always_inline int validate_range(struct mm_struct *mm,
>  	return 0;
>  }
> 
> +static int split_range(struct vma_iterator *vmi,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start,
> +		       unsigned long end,
> +		       bool *can_merge)

Maybe clamp_range()?
I'd also prefer to fill lines with parameters, rather than have each on a
separate line.

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
> @@ -1330,7 +1359,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	unsigned long vm_flags, new_flags;
>  	bool found;
>  	bool basic_ioctls;
> -	unsigned long start, end, vma_end;
> +	unsigned long start, end;
>  	struct vma_iterator vmi;
> 
>  	user_uffdio_register = (struct uffdio_register __user *) arg;
> @@ -1462,6 +1491,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> 
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
> +		bool can_merge;
> +
>  		cond_resched();
> 
>  		BUG_ON(!vma_can_userfault(vma, vm_flags));
> @@ -1477,32 +1508,22 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		    (vma->vm_flags & vm_flags) == vm_flags)
>  			goto skip;
> 
> -		if (vma->vm_start > start)
> -			start = vma->vm_start;

I don't think this can be removed. Consider a request to register uffd for
a range that spans two disjoint VMAs. Then on the second iteration start
will be equal to vm_end of the first VMA, so it should be clamped to
vm_start of the second VMA.

> -		vma_end = min(end, vma->vm_end);
> +		ret = split_range(&vmi, vma, start, end, &can_merge);
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
> @@ -1560,7 +1581,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	struct uffdio_range uffdio_unregister;
>  	unsigned long new_flags;
>  	bool found;
> -	unsigned long start, end, vma_end;
> +	unsigned long start, end;
>  	const void __user *buf = (void __user *)arg;
>  	struct vma_iterator vmi;
> 
> @@ -1627,6 +1648,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	prev = vma_prev(&vmi);
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
> +		bool can_merge;
> +
>  		cond_resched();
> 
>  		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> @@ -1640,9 +1663,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> 
>  		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> 
> -		if (vma->vm_start > start)
> -			start = vma->vm_start;

Ditto

> -		vma_end = min(end, vma->vm_end);
> +		ret = split_range(&vmi, vma, start, end, &can_merge);
> +		if (ret)
> +			break;
> 
>  		if (userfaultfd_missing(vma)) {
>  			/*
> @@ -1652,35 +1675,27 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
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

-- 
Sincerely yours,
Mike.
