Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AFD702582
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbjEOG4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240548AbjEOG4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:56:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E536420C
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:55:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so64356645e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684133701; x=1686725701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txIEkaJxNsUXZY32mj0SNE7DB1iM3liYdI1GT66Ej1w=;
        b=lduHuKuUc3/mLwsLIg3WrLQAquZp6rMRhdo4iF9Vt2mqUm1rN/PZkqQK1xuvXi48Zp
         bJSZsi5U8zTsjlRRU1ngQo8EtMGrkrQUWUwvKVNFXpojVh1y9UqAmnCCyOtvIHryCEfk
         rBe2WcADGSHbZjlsdcL3gsvuBX3VW9s6ipCCTWWfV9LT8T1PUrURjokZDNSpEQuOWm+m
         aAizNIPQpTJALbuAi7gs/GuGpaaDwBStN1NDabKDIJGq9RR/eykHQsPd5UxfXDu87Zah
         J2ZgkdfIKzxZcJLc9hvU8+KoXlt0SpEUVSvawJpT34kuVlNc49NrPbZCIDygU/9qwIYy
         nxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684133701; x=1686725701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txIEkaJxNsUXZY32mj0SNE7DB1iM3liYdI1GT66Ej1w=;
        b=d49/TE15ULPkaV6evPj46Y+iJv6vA2px0X6Sw7b0eXZGbMdoIO3ZtqS1uASPIKH+5G
         oiPaq/qgFEzvE/tp7WOR2C2qmnGGbwZTv3XmA5T65v+m62sF384CuUQjTUZ2hb57bJsU
         Hy3uMJ2Pj0+wgUZN2ly1NTYHqBObK3O3uBVIVbFEtDWVsaSLQ0dQn1JZVbMDFA8kHVT/
         JnlSA+pVrWwnplG+EVdnRrZxnwouFWJyHoCiXfWYwZXeJpd6iEBgeveLQdvwHVHALh6G
         uS895S1ZwZLoTUQ/AAnat5hcEZb9kS5E3nVAPBEyaZrIkqHxwy5O0BxpUhUvUuuyt3DR
         /Shg==
X-Gm-Message-State: AC+VfDw4rR6tsyz9T8cs6aIx8sb/6t4eUnscWZxjDMyJQ4H5/pOl3KiD
        hu+ba6WishHSfKYelKy+2SA=
X-Google-Smtp-Source: ACHHUZ4oxpNS3xTa9W0HiDLQjWh20E1/3f6bvn3I1qPWGwn6LN/VBJMmURzCAUJfmUNyjbUUJYSl8w==
X-Received: by 2002:a05:600c:1149:b0:3f5:e7f:5327 with SMTP id z9-20020a05600c114900b003f50e7f5327mr511144wmz.10.1684133700805;
        Sun, 14 May 2023 23:55:00 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003f4e47c6504sm13540041wmg.21.2023.05.14.23.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:54:59 -0700 (PDT)
Date:   Mon, 15 May 2023 07:54:58 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH for 6.4-rcX] mm: userfaultfd: avoid passing an invalid
 range to vma_merge()
Message-ID: <c066827c-5ce0-41c6-b165-38ade487c580@lucifer.local>
References: <20230514172731.134188-1-lstoakes@gmail.com>
 <ZGHT8q7TIsDWyXzK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGHT8q7TIsDWyXzK@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:40:50AM +0300, Mike Rapoport wrote:
> On Sun, May 14, 2023 at 06:27:31PM +0100, Lorenzo Stoakes wrote:
> > The userfaultfd_[un]register() functions will knowingly pass an invalid
> > address range to vma_merge(), then rely on it failing to merge to indicate
> > that the VMA should be split into a valid one.
> >
> > This is not something that should be relied upon, as vma_merge() implicitly
> > assumes in cases 5-8 that curr->vm_start == addr. This is now enforced
> > since commit b0729ae0ae67 ("mm/mmap/vma_merge: explicitly assign res, vma,
> > extend invariants") with an explicit VM_WARN_ON() check.
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
> >  fs/userfaultfd.c | 111 +++++++++++++++++++++++++++--------------------
> >  1 file changed, 63 insertions(+), 48 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 0fd96d6e39ce..4453e7040157 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1319,6 +1319,35 @@ static __always_inline int validate_range(struct mm_struct *mm,
> >  	return 0;
> >  }
> >
> > +static int split_range(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start,
> > +		       unsigned long end,
> > +		       bool *can_merge)
>
> Maybe clamp_range()?
> I'd also prefer to fill lines with parameters, rather than have each on a
> separate line.

Sure on both. You know I very nearly called it clamp_range() to start with
but then thought perhaps it wasn't clear that it'd split the VMAs, but
naming is... hard :)

Will fix both on next respin.

>
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
> > @@ -1330,7 +1359,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  	unsigned long vm_flags, new_flags;
> >  	bool found;
> >  	bool basic_ioctls;
> > -	unsigned long start, end, vma_end;
> > +	unsigned long start, end;
> >  	struct vma_iterator vmi;
> >
> >  	user_uffdio_register = (struct uffdio_register __user *) arg;
> > @@ -1462,6 +1491,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >
> >  	ret = 0;
> >  	for_each_vma_range(vmi, vma, end) {
> > +		bool can_merge;
> > +
> >  		cond_resched();
> >
> >  		BUG_ON(!vma_can_userfault(vma, vm_flags));
> > @@ -1477,32 +1508,22 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  		    (vma->vm_flags & vm_flags) == vm_flags)
> >  			goto skip;
> >
> > -		if (vma->vm_start > start)
> > -			start = vma->vm_start;
>
> I don't think this can be removed. Consider a request to register uffd for
> a range that spans two disjoint VMAs. Then on the second iteration start
> will be equal to vm_end of the first VMA, so it should be clamped to
> vm_start of the second VMA.
>

All references to start from here on in are replaced with references to
vma->vm_start, so this is implicit in the logic.

In effect the existing code was clamping to the range anyway, this patch
actually helps clarify that I feel.

> > -		vma_end = min(end, vma->vm_end);
> > +		ret = split_range(&vmi, vma, start, end, &can_merge);
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
> > @@ -1560,7 +1581,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  	struct uffdio_range uffdio_unregister;
> >  	unsigned long new_flags;
> >  	bool found;
> > -	unsigned long start, end, vma_end;
> > +	unsigned long start, end;
> >  	const void __user *buf = (void __user *)arg;
> >  	struct vma_iterator vmi;
> >
> > @@ -1627,6 +1648,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  	prev = vma_prev(&vmi);
> >  	ret = 0;
> >  	for_each_vma_range(vmi, vma, end) {
> > +		bool can_merge;
> > +
> >  		cond_resched();
> >
> >  		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> > @@ -1640,9 +1663,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >
> >  		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> >
> > -		if (vma->vm_start > start)
> > -			start = vma->vm_start;
>
> Ditto

Same comment as above, we no longer refer to start only vma->vm_start after this point.

>
> > -		vma_end = min(end, vma->vm_end);
> > +		ret = split_range(&vmi, vma, start, end, &can_merge);
> > +		if (ret)
> > +			break;
> >
> >  		if (userfaultfd_missing(vma)) {
> >  			/*
> > @@ -1652,35 +1675,27 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
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
>
> --
> Sincerely yours,
> Mike.
