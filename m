Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52ED6C1D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjCTRQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjCTRQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:16:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B7C20A27
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:12:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so9625134wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679332268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6hM6Lvhv87HAw4RvrkjFZdg7J8s1VPPzl4VJgkthUE=;
        b=Y/OfDbho9Rpcjz3vWiiKM1Mym9R9k/L0UETaR7VJvM0zLAXF4Y7LNiTRmR/iq8aNf3
         ArasbHETILNPYq/lTUM/E/G8xWvvfIROA3zOGJb0PzVFPUglWNvWfCT0cT65Mtz+h92S
         MPcpI0vWwR1xE1+Vt40NLQwvXPWpaycvv1DCOQ4LeVzQGJFgzX+3nmnj0ypzcp0bhEzD
         LeA9Kd9Y8RFMX3I9DtTziErzNSuifGnqz2zj4Y+S/ClgwkVk0bq3AhTvdFuaVdZB/oPx
         dqt2sBKGDnUBsMQRV5CwwJPnrnTNiBfodxaNtLOaXhdLc6ozoRz6gsejdnji5GoAzqJm
         733A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6hM6Lvhv87HAw4RvrkjFZdg7J8s1VPPzl4VJgkthUE=;
        b=Y92Fu7hqnvQDCrzE9gBpWdvu4dLjSm3zOaYtC+0V+zlNG6fenuultsbwACmuUUH7/w
         nocVA9HNmVGwxC2u6DgO+gxbGGjpyQPcEIPxSf6yHRlaOX5VlhERh7A1saH4xapMeSUx
         T3bJi9i26gm05nNM99g4D+iPK5JxTcJ8sJBSOb+WUZS+JVsXfY/8rOnFIM3T6Zx462l7
         kVJFGX1hdQpn1V0DU/SlnNMzObgVjaCyqnSf+EGaJOnq0Sa0IODSDTROPZGKhpSX0rzL
         Rss2Kkic54yVxNCTuldWjpdlGorbal82BSuJcJKPWbU+3831B1Wez5c4Dds/LUAKhkEy
         d5+w==
X-Gm-Message-State: AO0yUKWX2OzzRt7xHfkYefYfUHTta3liroPKepg7pV2SWSuVGbNIUudm
        rNCiyhi65ylKoDV/6TG95g4=
X-Google-Smtp-Source: AK7set9D2JCOPOq+Q3kqgYPbsRDk8SwPhwusBMHWz8EnIyW9aZ3DBESEGgcEQqc8GXB/PnCFv19vZg==
X-Received: by 2002:a05:600c:290:b0:3eb:37ce:4c3d with SMTP id 16-20020a05600c029000b003eb37ce4c3dmr187022wmk.38.1679332267628;
        Mon, 20 Mar 2023 10:11:07 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003e8dcc67bdesm17587266wms.30.2023.03.20.10.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:11:06 -0700 (PDT)
Date:   Mon, 20 Mar 2023 17:11:06 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/4] mm/mmap/vma_merge: set next to NULL if not applicable
Message-ID: <3d4bcc71-dfab-44c1-a3aa-c5d7437b6a0d@lucifer.local>
References: <cover.1679137163.git.lstoakes@gmail.com>
 <4d717269303d8a6fe1d837968c252eeb6ff1d7e5.1679137163.git.lstoakes@gmail.com>
 <20230320162708.xq64y4ig6f3sf747@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320162708.xq64y4ig6f3sf747@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:27:08PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [230318 07:15]:
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
>
> It might be better to set:
> curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
>
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
>
> You can change this to:
> next = vma_lookup(mm, curr->vm_end);
> Then you don't need to validate below, in this case.
>
> > +		else
> > +			/* Case 5. */
> > +			vma = NULL;
>
>
> > +	} else {
> > +		/*
> > +		 * The addr - end range either spans the end of prev or spans no
> > +		 * VMA at all - in either case we dispense with 'curr' and
> > +		 * maintain only 'prev' and (possibly) 'next'.
>
> Possibly next here would be:
> next = vma_lookup(mm, end);
> I think?
>
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
>
> If I'm correct above, then we can drop this next checking.
>
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
>
> I think we can keep this chunk with the next = vma_lookup() changes as
> well.
>
> >  		merge_next = true;
> >  	}
> >
> > --
> > 2.39.2
> >

Thanks, I will investigate all of these and will try to apply everything
that is workable from here + respin.
