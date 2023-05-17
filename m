Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC8706A34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjEQNve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEQNvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9F55BB3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684331435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TI0VZH+WSVrN44Kmcp1GvtC02E21cPAJ7dTSUpnucn8=;
        b=MAw9vLQhPYQs0gaNnmleeGeT6uQ6XAPT6/WXDS5YJPAVhzwHQGA32FWRvbTXfQ096Eexxd
        T6y1smYkoqq6MQsTh5ey2hmR31LS2sVuzTE6ekYkkFK2jUJnow592rDyCg5u3B8Fq3JojF
        YrbA24jRUGRTwBTcNSY5bKfeazjXLfg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-8Qg-RmMXP5CSddtNwVKIcA-1; Wed, 17 May 2023 09:50:33 -0400
X-MC-Unique: 8Qg-RmMXP5CSddtNwVKIcA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62387ccd3bdso1031626d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684331433; x=1686923433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TI0VZH+WSVrN44Kmcp1GvtC02E21cPAJ7dTSUpnucn8=;
        b=UVZayoXONNguI403Voz/wIQeDbXu2gMEdV/nsbGf8NEaKaVleggIOYU3onorKqkjoG
         O6ldOUb4ohM+rGBl/3Nf1wh8tyRWJ5eMIBCW8xpLJKBg1Z1ve++jmaBOwD3kij3L70LP
         loZs/A0rtxBa5OU23k4tghgLe0SD0jJhfLgJs4DKXRTQ1k983xEri5Hm/KNzlCAsNMJU
         rOUPb4bcRqs938SYRyikTRbrZRIICGUATpskZg/BEKPgLlgnpOKBbhP0uwHWhvvVaMgt
         CIGV4qzqWk/+Hh0dKTyEPUdtIwCt+V5rpX5zCkYnj75UdwynHU/YKYp3LpnVa4wq0uY/
         THGw==
X-Gm-Message-State: AC+VfDzO4TpxAxNTMlBn8Jru1Rzdk0sN1a+LRhD12JJSoQkBeonoPbMM
        NTb88NjOV2JBKdHWFT21qPA77enzv/rw9sSVIkxA7fkpDon9CDwHdIuDDcrRfqasuuQFNFc86/P
        rWE5/1dGAy0OqtVNJ6xarP3j0
X-Received: by 2002:a05:6214:20ef:b0:532:141d:3750 with SMTP id 15-20020a05621420ef00b00532141d3750mr5081489qvk.2.1684331433425;
        Wed, 17 May 2023 06:50:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4uif3GRV4sMIoeC771Xly3pxTm+CaxTaWQYnbtcEJVhqzuAylyTOfP3N5RygXm6HOL/k0lLg==
X-Received: by 2002:a05:6214:20ef:b0:532:141d:3750 with SMTP id 15-20020a05621420ef00b00532141d3750mr5081439qvk.2.1684331433047;
        Wed, 17 May 2023 06:50:33 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id l18-20020a0ce512000000b006215c5bb2e9sm4911247qvm.70.2023.05.17.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:50:32 -0700 (PDT)
Date:   Wed, 17 May 2023 09:50:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <ZGTbp9LLNYG4ILXk@x1n>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <20230516164907.5bf2qe7nn5bo7iaa@revolver>
 <ZGPjlVOV5R7x4CV7@x1n>
 <20230516225251.xwmz2oyebo7k56ys@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230516225251.xwmz2oyebo7k56ys@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 06:52:51PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [230516 16:12]:
> ...
> 
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  fs/userfaultfd.c | 27 +++++++++++++++++++++------
> > > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index 0fd96d6e39ce..7eb88bc74d00 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -1458,10 +1458,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > >  	BUG_ON(!found);
> > > >  
> > > >  	vma_iter_set(&vmi, start);
> > > > -	prev = vma_prev(&vmi);
> > > > +	vma = vma_find(&vmi, end);
> > > > +	if (!vma)
> > > > +		goto out_unlock;
> > > > +
> > > > +	if (vma->vm_start < start)
> > > > +		prev = vma;
> > > > +	else
> > > > +		prev = vma_prev(&vmi);
> > > >  
> > > >  	ret = 0;
> > > > -	for_each_vma_range(vmi, vma, end) {
> > > > +	do {
> > > 
> > > The iterator may be off by one, depending on if vma_prev() is called or
> > > not.
> > > 
> > > Perhaps:
> > > 	prev = vma_prev(&vmi); /* could be wrong, or null */
> > > 	vma = vma_find(&vmi, end);
> > > 	if (!vma)
> > > 		goto out_unlock;
> > > 
> > > 	if (vma->vm_start < start)
> > > 		prev = vma;
> > > 
> > > now we know we are at vma with the iterator..
> > > 	ret = 0
> > > 	do{
> > > 	...
> > 
> > Will do, thanks.
> > 
> > I think I got trapped similarly when I was looking at xarray months ago
> > where xarray also had similar side effects to have off-by-one the iterator
> > behavior.
> > 
> > Do you think it'll make sense to have something describing such side
> > effects for maple tree (or the current vma api), or.. maybe there's already
> > some but I just didn't really know?
> 
> Well, it's an iterator so I though a position was implied.  But I think
> the documentation is lacking on the vma_iterator interface and I should
> fix that.

Thanks.

> 
> ...
> 
> > > > From: Peter Xu <peterx@redhat.com>
> > > > Date: Tue, 16 May 2023 09:39:38 -0400
> > > > Subject: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
> > > > 
> > > > We used to not pass in the pgoff correctly when register/unregister uffd
> > > > regions, it caused incorrect behavior on vma merging.
> > > > 
> > > > For example, when we have:
> > > > 
> > > >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> > > > 
> > > > Then someone unregisters uffd on range (5-9), it should become:
> > > > 
> > > >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> > > > 
> > > > But with current code it's:
> > > > 
> > > >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> > > > 
> > > > This patch allows such merge to happen correctly.
> > > > 
> > > > This behavior seems to have existed since the 1st day of uffd, keep it just
> > > > as a performance optmization and not copy stable.
> > > > 
> > > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  fs/userfaultfd.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index 7eb88bc74d00..891048b4799f 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > >  	bool basic_ioctls;
> > > >  	unsigned long start, end, vma_end;
> > > >  	struct vma_iterator vmi;
> > > > +	pgoff_t pgoff;
> > > >  
> > > >  	user_uffdio_register = (struct uffdio_register __user *) arg;
> > > >  
> > > > @@ -1489,8 +1490,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > >  		vma_end = min(end, vma->vm_end);
> > > >  
> > > >  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> > > > +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > > 
> > > I don't think this is safe.  You are telling vma_merge() something that
> > > is not true and will result in can_vma_merge_before() passing.  I mean,
> > > sure it will become true after you split (unless you can't?), but I
> > > don't know if you can just merge a VMA that doesn't pass
> > > can_vma_merge_before(), even for a short period?
> > 
> > I must admit I'm not really that handy yet to vma codes, so I could miss
> > something obvious.
> > 
> > My reasoning comes from two parts that this pgoff looks all fine:
> > 
> > 1) It's documented in vma_merge() in that:
> > 
> >  * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
> >  * figure out ...
> > 
> >   So fundamentally this pgoff is part of the mapping request paired with
> >   all the rest of the information.  AFAICT it means it must match with what
> >   "addr" is describing in VA address space.  That's why I think offseting
> >   it makes sense here.
> > 
> >   It also matches my understanding in vma_merge() code on how the pgoff is
> >   used.
> > 
> > 2) Uffd is nothing special in this regard, namely:
> > 
> >    mbind_range():
> > 
> > 	pgoff = vma->vm_pgoff + ((vmstart - vma->vm_start) >> PAGE_SHIFT);
> > 	merged = vma_merge(vmi, vma->vm_mm, *prev, vmstart, vmend, vma->vm_flags,
> > 			 vma->anon_vma, vma->vm_file, pgoff, new_pol,
> > 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > 
> >    mlock_fixup():
> >    
> > 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > 	*prev = vma_merge(vmi, mm, *prev, start, end, newflags,
> > 			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> > 			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > 
> >    mprotect_fixup():
> > 
> > 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > 	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
> > 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> > 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > 
> > I had a feeling that it's just something overlooked in the initial proposal
> > of uffd, but maybe I missed something important?
> 
> I think you are correct.  It's worth noting that all of these skip
> splitting if merging succeeds.

Yes, IIUC that's what we want because vma_merge() just handles everything
there (including split, or say, vma range adjustments) if any !NULL
returned.

> 
> We know it won't match case 1-4 (we have a current vma).  We then pass
> in vma_end = min(end, vma->vm_end);

Case 4 seems still possible and should be the case that mentioned in the
patch 2, iiuc.  But yes I think vma_end calculation is needed, afaik it is
to cover the last iteration, where that's the only place possible that we
may operate on "end" (where < vma->vm_end) rather than "vma->vm_end".  It
actually pairs with the initial "start" adjustment to me.

> 
> vma_lookup() will only be called if end == vma->vm_end, so next will not
> be set (and found) unless it is adjacent to the current vma and the vma
> in question does not need to be split anyways.
> 
> I also see that we use pgoff+pglen in the check, which avoids my concern
> above.

Right.

It seems so far all concerns are more or less ruled out.  I'll prepare a
formal patchset, we can continue the discussion there.

Thanks,

-- 
Peter Xu

