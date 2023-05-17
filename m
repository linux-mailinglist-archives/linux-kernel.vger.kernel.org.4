Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F145A7070FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjEQSlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEQSlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:41:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C145FC4;
        Wed, 17 May 2023 11:41:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso11405325e9.2;
        Wed, 17 May 2023 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684348861; x=1686940861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekzd9ykcWrQOgqzX/JwQtGZ8le07mwTGWPLkenw5T0A=;
        b=CKpZI810bSF3vZ6M77dq0q0tvFQ3oBcOiPJ4IH0shOSgLeiQfyzLEeuXZYzrhDcirh
         F3yj94jTS0xo7+1bgZ1Kotssi1Gb3Vz+ySb7LpQRLdGZUVuG5D4lxVDrdf4dPF6Di219
         I0p4BCdqTI9rgdh0XS/vxEzVcTpiMlymw3OF8aM9lu3epk3u8UuavHWXap0ujWq+88Jp
         qorhopGE4QHdoS7Tg8TTXVlE142BJa8sImw94ZqAfoiqdqjYF7qYCi3VaX9B29efPxCW
         vWCzH/+8Ob2AGY4cd5T5htscFyMJEvsjLXrDv3fAUP5GCiG+/7mXULV9z3c924BkgWxP
         HAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348861; x=1686940861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekzd9ykcWrQOgqzX/JwQtGZ8le07mwTGWPLkenw5T0A=;
        b=B+Ch9oaPa/PEp/c686WSnqcAYo7qFLoke8B4Awhp+/0334gsvjwj4nd3cIpU4rB4Np
         93i8o0STKCLY9HqUVW+suf8keO5oKdYXjo/tc68cDx6tIt6i8QnTbx47f+5GRrHOCxpJ
         GaLqmNT2X2ojIGUJvGCuyBCL7dtn3QOOaqvQJrS3+rr6Vgnd7H7Ubi1USyODIkK0blm4
         oPKRvvSnvkMKo8zAKrskfieycvLYNXc+Loy7yt/0ru7ukBDh9YsDuSm6kuXs6/CiipRl
         GTu2mub0uTHVy1qEnY5b2wZFKtyN+R57SabeYxhsuwXD0dkKKJjSMIeZanXWEx117nZO
         0Gng==
X-Gm-Message-State: AC+VfDxNEDY91WwiJEtJpto33Eyt8Cr4rJTFg0wkQwXv0okdL0tYQbUQ
        tynWCOsWSFpE+WeyHK/SsWln4ffGPBqCDw==
X-Google-Smtp-Source: ACHHUZ5w0132rEXA52wnoj6C+2IapoXe21N4e/7mZr4YoZA/CbJHgWn7BiG9bdWDQlHLjIYFEZCGsQ==
X-Received: by 2002:a1c:4c19:0:b0:3f4:27ff:7d52 with SMTP id z25-20020a1c4c19000000b003f427ff7d52mr24093698wmf.2.1684348861270;
        Wed, 17 May 2023 11:41:01 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id s22-20020a1cf216000000b003f080b2f9f4sm3043074wmc.27.2023.05.17.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:41:00 -0700 (PDT)
Date:   Wed, 17 May 2023 19:40:59 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts
 part of vma
Message-ID: <99566f92-9b97-4b2b-b75b-860532e851fd@lucifer.local>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-2-peterx@redhat.com>
 <4a68aee6-68d9-4d17-bb7f-cda3910f6f1f@lucifer.local>
 <ZGUe9f/niO03t7lC@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGUe9f/niO03t7lC@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:37:41PM -0400, Peter Xu wrote:
> On Wed, May 17, 2023 at 06:20:55PM +0100, Lorenzo Stoakes wrote:
> > On Wed, May 17, 2023 at 11:04:07AM -0400, Peter Xu wrote:
> > > It seems vma merging with uffd paths is broken with either
> > > register/unregister, where right now we can feed wrong parameters to
> > > vma_merge() and it's found by recent patch which moved asserts upwards in
> > > vma_merge() by Lorenzo Stoakes:
> > >
> > > https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> > >
> > > The problem is in the current code base we didn't fixup "prev" for the case
> > > where "start" address can be within the "prev" vma section.  In that case
> > > we should have "prev" points to the current vma rather than the previous
> > > one when feeding to vma_merge().
> >
> > This doesn't seem quite correct, perhaps - "where start is contained within vma
> > but not clamped to its start. We need to convert this into case 4 which permits
> > subdivision of prev by assigning vma to prev. As we loop, each subsequent VMA
> > will be clamped to the start."
>
> I think it covers more than case 4 - it can also be case 0 where no merge
> will happen?

Ugh please let's not call a case that doesn't merge by a number :P but sure of
course it might also not merge.

>
> >
> > >
> > > This patch will eliminate the report and make sure vma_merge() calls will
> > > become legal again.
> > >
> > > One thing to mention is that the "Fixes: 29417d292bd0" below is there only
> > > to help explain where the warning can start to trigger, the real commit to
> > > fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
> > > issue, but unfortunately we may want to keep it in Fixes too just to ease
> > > kernel backporters for easier tracking.
> > >
> > > Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > > Fixes: 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
> > > Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
> > > Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> > > Cc: linux-stable <stable@vger.kernel.org>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  fs/userfaultfd.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index 0fd96d6e39ce..17c8c345dac4 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -1459,6 +1459,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >
> > >  	vma_iter_set(&vmi, start);
> > >  	prev = vma_prev(&vmi);
> > > +	if (vma->vm_start < start)
> > > +		prev = vma;
> > >
> > >  	ret = 0;
> > >  	for_each_vma_range(vmi, vma, end) {
> > > @@ -1625,6 +1627,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > >
> > >  	vma_iter_set(&vmi, start);
> > >  	prev = vma_prev(&vmi);
> > > +	if (vma->vm_start < start)
> > > +		prev = vma;
> > > +
> > >  	ret = 0;
> > >  	for_each_vma_range(vmi, vma, end) {
> > >  		cond_resched();
> > > --
> > > 2.39.1
> > >
> >
> > Other than that looks good:-
> >
> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> Thanks to both on the quick reviews!

No problem!

>
> --
> Peter Xu
>
