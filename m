Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559A46C1628
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjCTPCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjCTPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:01:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACA42A17D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:58:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r29so10626862wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679324305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1yGS1YiNMYe/NdaTEd2bd8nkPGKEIMSPxe8CGVin02c=;
        b=PGMwQ1ywFQ/NK+0AX3IbIsbgW0fk0RZfu2mlDh9yk+Kr4vQ+QIzD1HEaJDNi3ibMgl
         HDx3peBG8Cg+oMIV7LWGXfuxcvWJqmWjCxCuZ2kNlcHKkdappyGbARGH2+sOEGRv5xrt
         hF8XIkuiDoqdeXwtesotF0z0IeIGlxYHl6+Ks+tZu4FhRGk+6Pvl6Ivwr9qGK/Gu5EeH
         RVINS5Rol3i5lqzvCFMEey8JErR8YH4x/TR9p/udrzsh68wJyHRJxlaErK3dovJcrMSV
         lJozmusk0Sp1Mr1Kf0cfAV7TsaFh02aLBq6wx+d/qXW3pRjgJXoxYUwD2VX+LsMQWsqF
         4YiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679324305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yGS1YiNMYe/NdaTEd2bd8nkPGKEIMSPxe8CGVin02c=;
        b=aeaw9n6RUtMCyoP+XGpkRpO67opOt+MmmMDUjWgytsiTfgBt8nQSFTu3b6dJzEWXDG
         7uXA1kp7TBkx5OpKKYA0k124uDO3/2/l/rh1AdDiis+JKLCGipIDuxZjMtsS1HbbFkYm
         BCG1CU1JG66BS9D2Jg/7BKAWqW+/2XI3uwaEmKOf+WPjaAAwiSjfRtcT0+r+2wieoD3F
         y1yJUM1anERfzE+duPeM7aXbdld7o00/5T88Cy2EOitNgFXV3eo5A6PLOwEKD2E+Zjz7
         aIc9nqNlPdTCPiq8cTWzL6aHCIUVgc1EcjD9SOmWoXfb8gKhQ7F/tcGr0t4I/wK45+Ou
         aWVg==
X-Gm-Message-State: AO0yUKXUqOwoYKLx23hMdr1/iN7NsA06GuOtYqchiDDcF3s7fCz8nE5k
        Lfn8xZF5Z7BcKFE5Xv9Oa7U=
X-Google-Smtp-Source: AK7set8mG8h9++ybZp7nZllv5rbNabzYUIZZFk4oZSjlzkjFUbzUK1cdkCVHrFDfcv4RkXh4Q0ogEA==
X-Received: by 2002:adf:f607:0:b0:2cb:c474:7597 with SMTP id t7-20020adff607000000b002cbc4747597mr13382636wrp.66.1679324305181;
        Mon, 20 Mar 2023 07:58:25 -0700 (PDT)
Received: from localhost ([2a00:23ee:1938:1bcd:b99a:5dee:d658:4b02])
        by smtp.gmail.com with ESMTPSA id p17-20020adfcc91000000b002c71dd1109fsm9152912wrj.47.2023.03.20.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:58:24 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:58:22 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vernon Yang <vernon2gm@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/4] mm/mmap/vma_merge: set next to NULL if not applicable
Message-ID: <ZBh0jl2+IVOSB0SH@murray>
References: <cover.1679137163.git.lstoakes@gmail.com>
 <4d717269303d8a6fe1d837968c252eeb6ff1d7e5.1679137163.git.lstoakes@gmail.com>
 <ZBhpPFmAOKyohN0M@vernon-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBhpPFmAOKyohN0M@vernon-pc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:25:11PM +0800, Vernon Yang wrote:
> On Sat, Mar 18, 2023 at 11:13:19AM +0000, Lorenzo Stoakes wrote:
> > We are only interested in next if end == next->vm_start (in which case we
> > check to see if we can set merge_next), so perform this check alongside
> > checking whether curr should be set.
> >
> > This groups all of the simple range checks together and establishes the
> > invariant that, if prev, curr or next are non-NULL then their positions are
> > as expected.
> >
> > Additionally, use the abstract 'vma' object to look up the possible curr or
> > next VMA in order to avoid any confusion as to what these variables
> > represent - now curr and next are assigned once and only once.
>
> Hi Lorenzo,
>
> Due to the "vma" variable is used as an intermediate member, I feels a bit
> confusing, so cleanup this patch as below.

Hi Vernon, if you read the commit message you'll see what you're undoing
here is exactly what I have done on purpose. The point is to assign each of
curr and next once and only once after we've determined which of the two we
are assigning to.

You also delete some of the explanation which I added explicitly to make
the logic clearer and adjust _punctionation_ neither of which I feel are
positive changes.

The point is that existing logic treated either mid or curr as temporary
variables that might get reassigned.

By using a temporary value and explaining what we're doing, you can see
_why_ we are assigning it.

>
> If this cleanup patch is issue, please let me know, and then ignore it
> directly, thanks.

So I'm afraid I am not in favour of your change, though thank you for your
interest!

I am happy to get feedback on the change, though I'd suggest commenting on
anything you have issues with rather than attempting to rework my change as
if we start getting patches within patches it's going to end like inception
:)

Cheers, Lorenzo

>
> ----
> From 7dac3ed8c1b747c2edf2a6c867c4e6342c7447c3 Mon Sep 17 00:00:00 2001
> From: Vernon Yang <vernon2gm@gmail.com>
> Date: Mon, 20 Mar 2023 21:38:09 +0800
> Subject: [PATCH] mm/mmap/vma_merge: set next to NULL if not applicable-cleanup
>
> Make code logic simpler and more readable.
>
> Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
> ---
>  mm/mmap.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 45bd43225013..78cb96774602 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -921,7 +921,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	 * If there is a previous VMA specified, find the next, otherwise find
>  	 * the first.
>  	 */
> -	vma = find_vma(mm, prev ? prev->vm_end : 0);
> +	curr = find_vma(mm, prev ? prev->vm_end : 0);
>
>  	/*
>  	 * Does the input range span an existing VMA? If so, we designate this
> @@ -929,21 +929,19 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	 *
>  	 * Cases 5 - 8.
>  	 */
> -	if (vma && end > vma->vm_start) {
> -		curr = vma;
> -
> +	if (curr && end > curr->vm_start) {
>  		/*
>  		 * If the addr - end range spans this VMA entirely, then we
>  		 * check to see if another VMA follows it.
>  		 *
> -		 * If it is _immediately_ adjacent (checked below), then we
> +		 * If it is immediately adjacent (checked below), then we
>  		 * designate it 'next' (cases 6 - 8).
>  		 */
>  		if (curr->vm_end == end)
> -			vma = find_vma(mm, curr->vm_end);
> +			next = find_vma(mm, curr->vm_end);
>  		else
>  			/* Case 5. */
> -			vma = NULL;
> +			next = NULL;
>  	} else {
>  		/*
>  		 * The addr - end range either spans the end of prev or spans no
> @@ -952,19 +950,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		 *
>  		 * Cases 1 - 4.
>  		 */
> +		next = curr;
>  		curr = NULL;
>  	}
>
> -	/*
> -	 * We only actually examine the next VMA if it is immediately adjacent
> -	 * to end which sits either at the end of a hole (cases 1 - 3), PPPP
> -	 * (case 4) or CCCC (cases 6 - 8).
> -	 */
> -	if (vma && end == vma->vm_start)
> -		next = vma;
> -	else
> -		next = NULL;
> -
>  	/*
>  	 * By default, we return prev. Cases 3, 4, 8 will instead return next
>  	 * and cases 3, 8 will also update vma to point at next.
> --
> 2.34.1
>
>
> >
> > This has no functional impact.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  mm/mmap.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 49 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index c9834364ac98..66893fc72e03 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -930,15 +930,53 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  	if (vm_flags & VM_SPECIAL)
> >  		return NULL;
> >
> > -	curr = find_vma(mm, prev ? prev->vm_end : 0);
> > -	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
> > -		next = find_vma(mm, curr->vm_end);
> > -	else
> > -		next = curr;
> > +	/*
> > +	 * If there is a previous VMA specified, find the next, otherwise find
> > +	 * the first.
> > +	 */
> > +	vma = find_vma(mm, prev ? prev->vm_end : 0);
> > +
> > +	/*
> > +	 * Does the input range span an existing VMA? If so, we designate this
> > +	 * VMA 'curr'. The caller will have ensured that curr->vm_start == addr.
> > +	 *
> > +	 * Cases 5 - 8.
> > +	 */
> > +	if (vma && end > vma->vm_start) {
> > +		curr = vma;
> >
> > -	/* In cases 1 - 4 there's no CCCC vma */
> > -	if (curr && end <= curr->vm_start)
> > +		/*
> > +		 * If the addr - end range spans this VMA entirely, then we
> > +		 * check to see if another VMA follows it.
> > +		 *
> > +		 * If it is _immediately_ adjacent (checked below), then we
> > +		 * designate it 'next' (cases 6 - 8).
> > +		 */
> > +		if (curr->vm_end == end)
> > +			vma = find_vma(mm, curr->vm_end);
> > +		else
> > +			/* Case 5. */
> > +			vma = NULL;
> > +	} else {
> > +		/*
> > +		 * The addr - end range either spans the end of prev or spans no
> > +		 * VMA at all - in either case we dispense with 'curr' and
> > +		 * maintain only 'prev' and (possibly) 'next'.
> > +		 *
> > +		 * Cases 1 - 4.
> > +		 */
> >  		curr = NULL;
> > +	}
> > +
> > +	/*
> > +	 * We only actually examine the next VMA if it is immediately adjacent
> > +	 * to end which sits either at the end of a hole (cases 1 - 3), PPPP
> > +	 * (case 4) or CCCC (cases 6 - 8).
> > +	 */
> > +	if (vma && end == vma->vm_start)
> > +		next = vma;
> > +	else
> > +		next = NULL;
> >
> >  	/* verify some invariant that must be enforced by the caller */
> >  	VM_WARN_ON(prev && addr <= prev->vm_start);
> > @@ -959,11 +997,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  		}
> >  	}
> >  	/* Can we merge the successor? */
> > -	if (next && end == next->vm_start &&
> > -			mpol_equal(policy, vma_policy(next)) &&
> > -			can_vma_merge_before(next, vm_flags,
> > -					     anon_vma, file, pgoff+pglen,
> > -					     vm_userfaultfd_ctx, anon_name)) {
> > +	if (next && mpol_equal(policy, vma_policy(next)) &&
> > +	    can_vma_merge_before(next, vm_flags,
> > +				 anon_vma, file, pgoff+pglen,
> > +				 vm_userfaultfd_ctx, anon_name)) {
> >  		merge_next = true;
> >  	}
> >
> >
> > --
> > 2.39.2
> >
