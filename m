Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841376C4320
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCVGZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCVGZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:25:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5948153735
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:25:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso12339411wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679466355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9XKHKg28SX/0LVxj0Ew+2k2WgxMDKd2HShHur6TSwk=;
        b=pPrbd+fFtq6a4QHo3W9HNyj5LySYxI8tUZLf+eGbwSL7lElwFyOnyN5GGONrbUx4Qy
         9h03XlQWRTpC+p996NXqzVLtXT74Q/ul632DgXkrPyrsAhCiFg/CUKxM8Tk+8twtSLH+
         qqF+IW4IPtuU0al+bC4/WJlJcKsXIgaVGq1if1EIOcilM2k+7VJWijoei7DiJjraTUGh
         HP2gnamk4+oWqbyL7iKHPeGpgkeU4KK8m1t1sAdUQfo4ha/zDiZsesRwSt1SMtNjckA3
         XYOgPDobClf6yDnNCAXBDNF1CMD+D1lLCk7USCFEjsp7ZfnnVTzr835zk039qRoXEF2b
         mCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679466355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9XKHKg28SX/0LVxj0Ew+2k2WgxMDKd2HShHur6TSwk=;
        b=prMoAlxgD+VpD52nf8K1YTBQs+ykpj3s2SY5olTLOCa+57ijMMYJAiRjCsuPLjzc/P
         LUiqcHZe4evmK5zp37W5crTwJ4I1q5d2R5PP1SFbj34jh8ZBjpnSLESseM/75c7HygP9
         pRIFhQPxOO4ss/fPNmkqU1n0fteTaKUoSIcXPhQ0bAeyFHMxCEg7M5zCkrvFrgwAsSxw
         i4CxUsU5eQdMkb1kuWPP92wy3chlX98zHqz3bYqcp8SSxPIa849l2XPn7gR89yqvbasb
         ulvjSutWJzg0XW3NemPM4h8vgRSlTGMqDOK4ivwUmzRGcLK/f7IaZWgTHeZXUJ1rLQlG
         944A==
X-Gm-Message-State: AO0yUKV8HmWoMJf3HPD47L/kYboTQa8PeG+4qmWCw3FRc1zv+j3tvS7M
        9QEUVSh+f+qwUsf4zWZhgMs=
X-Google-Smtp-Source: AK7set/GgXqF/frcQXZ1HiDYhZtDGcAsnFpYy16NV+2VdNP+1Cb9XKHo9VcdXRSfyCahR33ZNG++dw==
X-Received: by 2002:a1c:7311:0:b0:3ea:d611:f8 with SMTP id d17-20020a1c7311000000b003ead61100f8mr4670082wmb.38.1679466354645;
        Tue, 21 Mar 2023 23:25:54 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bca55000000b003ee697ecefdsm275772wml.45.2023.03.21.23.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:25:53 -0700 (PDT)
Date:   Wed, 22 Mar 2023 06:23:43 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH v2 2/4] mm/mmap/vma_merge: set next to NULL if not
 applicable
Message-ID: <467b6158-5c91-4c95-b05b-ea9331f7f563@lucifer.local>
References: <cover.1679431180.git.lstoakes@gmail.com>
 <3506997a8146a287ec13ee7a53cf916707537bf8.1679431180.git.lstoakes@gmail.com>
 <20230322014232.4iixbwn5urfo6t2y@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322014232.4iixbwn5urfo6t2y@revolver>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:42:32PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [230321 16:51]:
> > We are only interested in next if end == next->vm_start (in which case we
> > check to see if we can set merge_next), so perform this check alongside
> > checking whether curr should be set.
> >
> > This groups all of the simple range checks together and establishes the
> > invariant that, if prev, curr or next are non-NULL then their positions are
> > as expected.
> >
> > This has no functional impact.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  mm/mmap.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index c9834364ac98..6361baf75601 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -930,15 +930,15 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  	if (vm_flags & VM_SPECIAL)
> >  		return NULL;
> >
> > -	curr = find_vma(mm, prev ? prev->vm_end : 0);
> > -	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
> > -		next = find_vma(mm, curr->vm_end);
> > -	else
> > -		next = curr;
> > +	/* Does the input range span an existing VMA? (cases 5 - 8) */
> > +	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
> >
> > -	/* In cases 1 - 4 there's no CCCC vma */
> > -	if (curr && end <= curr->vm_start)
> > -		curr = NULL;
> > +	if (curr && end == curr->vm_end)
> > +		/* Is there is a VMA immediately adjacent (cases 6 - 8)? */
> > +		next = vma_lookup(mm, curr->vm_end);
>
> Since end == curr->vm_end, this lookup is the same as below so these two
> statements can be combined.

I can't believe I didn't see this :) wood for the trees + a great example as to
the benefit of code review.

>
> I also think you may need to initialize next to null since it may not be
> set for the 'cannot merge' case.

You're right, will fix.

>
> Something like:
> 	if ((!curr) ||		    /* case 1-4 */
> 	     (end == curr->vm_end)) /* Case 6-8, adjacent vma */
> 		next = vma_lookup(mm, end);
> 	else
> 		next = NULL
>

This is really turning out to be quite nicely succinct now I think! Will do.

>
> > +	else if (!curr)
> > +		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
> > +		next = vma_lookup(mm, end);
>
> Nit, can we have braces for comments that make the if/else look like
> it's unguarded?
>

Ack will fix in respin.

> >
> >  	/* verify some invariant that must be enforced by the caller */
> >  	VM_WARN_ON(prev && addr <= prev->vm_start);
> > @@ -959,11 +959,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
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
> > --
> > 2.39.2
> >
