Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DD76C42A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjCVGJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVGJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:09:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8C32E76
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:09:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h17so15828703wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679465387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvjMFKouzMGD9RKqt33OnSeBDLHBYhIAGSylF79gu5Q=;
        b=ZUDcg4zOXbE2dv8/jyQLpHSsG7dDHcpPYMGv3MVqVNF5VT7rNnACF8uaThCuwHLsnE
         r8Bt4X+mNWQJ4t2v7VSUlrW6zlEspRdoPXHD7t1qOZ2b+JN9d/hAoJqDCC1TPGABfJJ4
         D5+uc3ZkQSbGDZe/P1DIvk2zDdNkTm4cduJzryhdc00QxYbwnScD8bJ++FnVOyG2CxuK
         sOQmk6eHRjnP95OYvsNHzCrWsX27nmxbCHOm/iipmp85uscq2Pz6RaUsc3M/VOMCz+dL
         LfxOinYprIHXRm2UHq0DH0pF1MnopXHl/tbpa1Fc9Q8PvLsjVhLy5d9v9jFErkcDAOmA
         bjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679465387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvjMFKouzMGD9RKqt33OnSeBDLHBYhIAGSylF79gu5Q=;
        b=SyGTgwY5ZMA21jx75UBQCn+cf6b1iKyvJArvVdns8lAGY7z8gIcrCz+Ivsn7rwCeDd
         SWC4bOdpMH0rWAOq5P7a6onVnZ+ne5YZloT71W/z5J6kxDPrD6rbLeLGH2n3FIoVBlOm
         X+NpiJu4yXo0Vcf5Fid2U4+75K7rKIJ8qhbrAmHsiFdXYP1P29k3zwTwHMsMpeDdnBSl
         kUPE3YNBqeqzGjPDvOmhfes0cywk8jEqVNy9AFn/EylrEAcp2/OUaQJOTlZLsjDRoFT1
         G2IcvEXUMtQYwMIi9dgrOCGq5hg5jMBUXU2nljzgJq9/hwDaDUU/0Tz4WqZ1V9/v/Ctx
         ghuw==
X-Gm-Message-State: AO0yUKXh4NsGD1LMRMjLYZAM7CGkzouhd/Q/6YVtN7/V3SJs/Rih81zJ
        n94tNPDOYFO5l535xb+Q4Jo=
X-Google-Smtp-Source: AK7set8y6o2EV7n6CNBK6TLR8rdVei4DkUckGcIOfXJpfDktQHWW4uq02p4KSucFzmEb4AJUtk7OYA==
X-Received: by 2002:a5d:4ec1:0:b0:2ce:a68a:86fe with SMTP id s1-20020a5d4ec1000000b002cea68a86femr4081178wrv.69.1679465387322;
        Tue, 21 Mar 2023 23:09:47 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b003dc434b39c7sm1301175wms.0.2023.03.21.23.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:09:46 -0700 (PDT)
Date:   Wed, 22 Mar 2023 06:07:35 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/mmap/vma_merge: init cleanup, be explicit
 about the non-mergeable case
Message-ID: <35e1582a-a64f-44c2-983f-bb1cde6dd98a@lucifer.local>
References: <cover.1679431180.git.lstoakes@gmail.com>
 <f5e27d1bb9259b7ef7a45099a838e47fbaaad3ab.1679431180.git.lstoakes@gmail.com>
 <20230322020858.msvpvit63sb437ze@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322020858.msvpvit63sb437ze@revolver>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:08:58PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [230321 16:46]:
> > Reorder the initial variables sensibly and set vma_start and vm_pgoff there
> 								^vma_pgoff
> 	Indicating it is used for the vm_area_struct *vma
>
> > rather than later so all initial values are set at the same time meaning we
> > don't have to set these later.
>
> I did these later to reduce the number of times we were checking prev.
> With this patch, we check prev 3 times, but before we were checking it
> once.  The compiler might do something clever here to reduce the
> checking?
>

Apologies for undoing your work! Which obviously wasn't my intention :)

I suspect the compiler would, but we probably shouldn't rely on it.

> I'm also not sure adding the conditional operator in the init helps your
> goal of cleaning it up.

The purpose was to group everything together, reduce indentation in the
prev case, have it resemble the next case more closely, reduce LoC and to
have the prev if block be solely concerned with merging the predecessor
rather than both setting these values and then checking to see if we can
merge the predecessor.

However, on second thoughts I think avoiding repeatedly checking it trumps
that so I will revert to the previous approach.

>
> >
> > Rather than setting err = -1 and only resetting if we hit merge cases,
> > explicitly check the non-mergeable case to make it abundantly clear that we
> > only proceed with the rest if something is mergeable, default err to 0 and
> > only update if an error might occur.
> >
> > Move the merge_prev, merge_next cases closer to the logic determining curr,
> > next.
> >
> > This has no functional impact.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  mm/mmap.c | 55 ++++++++++++++++++++++++++-----------------------------
> >  1 file changed, 26 insertions(+), 29 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 7aec49c3bc74..d60cb0b7ae15 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -909,18 +909,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> >  			struct anon_vma_name *anon_name)
> >  {
> > -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> > -	pgoff_t vma_pgoff;
> >  	struct vm_area_struct *curr, *next, *res;
> >  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> > -	int err = -1;
> > +	struct vma_prepare vp;
> > +	int err = 0;
> >  	bool merge_prev = false;
> >  	bool merge_next = false;
> >  	bool vma_expanded = false;
> > -	struct vma_prepare vp;
> > +	unsigned long vma_start = prev ? prev->vm_start : addr;
> >  	unsigned long vma_end = end;
> > +	pgoff_t vma_pgoff = prev ? prev->vm_pgoff : 0;
> > +	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> >  	long adj_start = 0;
> > -	unsigned long vma_start = addr;
> >
> >  	validate_mm(mm);
> >  	/*
> > @@ -940,6 +940,23 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
> >  		next = vma_lookup(mm, end);
> >
> > +	/* Can we merge the predecessor? */
> > +	if (prev && addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
> > +	    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> > +				   pgoff, vm_userfaultfd_ctx, anon_name)) {
> > +		merge_prev = true;
> > +		vma_prev(vmi);
> > +	}
> > +
> > +	/* Can we merge the successor? */
> > +	merge_next = next && mpol_equal(policy, vma_policy(next)) &&
> > +		can_vma_merge_before(next, vm_flags,
> > +				     anon_vma, file, pgoff+pglen,
> > +				     vm_userfaultfd_ctx, anon_name);
> > +
> > +	if (!merge_prev && !merge_next)
> > +		return NULL; /* Not mergeable. */
> > +
> >  	/*
> >  	 * By default, we return prev. Cases 3, 4, 8 will instead return next
> >  	 * and cases 3, 8 will also update vma to point at next.
> > @@ -951,26 +968,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> >  	VM_WARN_ON(addr >= end);
> >
> > -	if (prev) {
> > -		vma_start = prev->vm_start;
> > -		vma_pgoff = prev->vm_pgoff;
> > -		/* Can we merge the predecessor? */
> > -		if (prev->vm_end == addr && mpol_equal(vma_policy(prev), policy)
> > -		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> > -				   pgoff, vm_userfaultfd_ctx, anon_name)) {
> > -			merge_prev = true;
> > -			vma_prev(vmi);
> > -		}
> > -	}
> > -
> > -	/* Can we merge the successor? */
> > -	if (next && mpol_equal(policy, vma_policy(next)) &&
> > -	    can_vma_merge_before(next, vm_flags,
> > -				 anon_vma, file, pgoff+pglen,
> > -				 vm_userfaultfd_ctx, anon_name)) {
> > -		merge_next = true;
> > -	}
> > -
> >  	remove = remove2 = adjust = NULL;
> >  	/* Can we merge both the predecessor and the successor? */
> >  	if (merge_prev && merge_next &&
> > @@ -985,7 +982,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  				err = dup_anon_vma(prev, curr);
> >  		}
> >  	} else if (merge_prev) {
> > -		err = 0;				/* case 2 */
> > +							/* case 2 */
> >  		if (curr) {
> >  			err = dup_anon_vma(prev, curr);
> >  			if (end == curr->vm_end) {	/* case 7 */
> > @@ -995,7 +992,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  				adj_start = (end - curr->vm_start);
> >  			}
> >  		}
> > -	} else if (merge_next) {
> > +	} else { /* merge_next */
> >  		res = next;
> >  		if (prev && addr < prev->vm_end) {	/* case 4 */
> >  			vma_end = addr;
> > @@ -1011,7 +1008,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  			vma_start = addr;
> >  			vma_end = next->vm_end;
> >  			vma_pgoff = next->vm_pgoff;
> > -			err = 0;
> > +
>
> Was this blank line intentional?  I assume so, to give a gap for the
> comment below?  It's probably worth having.
>
> >  			if (curr) {			/* case 8 */
> >  				vma_pgoff = curr->vm_pgoff;
> >  				remove = curr;
> > @@ -1020,7 +1017,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  		}
> >  	}
> >
> > -	/* Cannot merge or error in anon_vma clone */
> > +	/* Error in anon_vma clone. */
> >  	if (err)
> >  		return NULL;
> >
> > --
> > 2.39.2
> >
> >
