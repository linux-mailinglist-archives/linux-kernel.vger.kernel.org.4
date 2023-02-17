Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4A269AFD1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBQPyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjBQPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:54:18 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A9D642F0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:54:16 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-53656e9326bso18059347b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lH86Zid2dZm5bnTlKuYHBL+UBFHGqixgoyFrzinN6Ms=;
        b=b3DiNrjlfqW1fEnQXBFb6r3/6ssYOYFmb07YdJ57aCoZgGF7z0cSlFp6LNvq0nlO9T
         h7MQwVLJHgbKiFwZZnwcEW43LlrllCq4xINr3/5ByMHFSkzVTwD0ec1uud4lk2QUxJJf
         S69FzFOpllxouNLN8H3PgzXaSkTdVhd46LsGMpHYh5L5MOJ97JDTrRU8MUhBzY/9ZNNz
         GtpgFyxBGBNhqKcVmCB7lXv7APqJKgNWYk+cgBG24fA+uR7dIeiMyU1HboAIFZEnBPuP
         ozgg4fNv6nMmWSBGnpWjhn36QNV5wp5RLqFu4rS04Uz2NPVfLutpOQHPA8Ea49wLkew+
         ljYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lH86Zid2dZm5bnTlKuYHBL+UBFHGqixgoyFrzinN6Ms=;
        b=Vkrv5Mn3leqaB5NUHTIfjBDqMOTPi29eT+jclw3THKZSxXt7Sr9DcUiP8Md2Gfn+4Z
         26PTEu+A9EdfjzcOHsr8OUDguAucitWkQyJ+uxSqqwVo1wpiXX6hHiwwVC8E9V9i+l1W
         0Abgj3NUQWSOhRew9PS6bdblgH7SowH7Zw9vf0n+9wB7Cp4CZW5RoknWOoiAySnPdvIp
         auppC37ZfD2zTlBQGknRrgwVk3zd34uSk6QZjJdvZXbKYnSuO60Pg8GYXlyjdF7rhFu/
         NSMgw//0/X7n2KRpwB5BaZwxvaGdKxSFtlhFprUkj++NzrXMUKBNz56+y6UYaFozhRNE
         ug5g==
X-Gm-Message-State: AO0yUKWA0VgTPkzHppoCakaNhDIJlUu/Ov2nZ/f+oKmUUxIvEOkvSnO/
        BF8oHK2qZT/+4rerK70pOS4sLS53/OgZIg9dUyPf5Q==
X-Google-Smtp-Source: AK7set8xo9es7N+pYGqxpm5ZGXh1uiEPHw0Au1RV6e1ob6blTwBLvHlxWY896OShiLQCNh8oO9NcmsY5tue+lwdwTZ8=
X-Received: by 2002:a05:690c:c90:b0:52f:184a:da09 with SMTP id
 cm16-20020a05690c0c9000b0052f184ada09mr323598ywb.2.1676649255794; Fri, 17 Feb
 2023 07:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-22-surenb@google.com>
 <20230216153405.zo4l2lqpnc2agdzg@revolver> <CAJuCfpEkujbHNxNWcWr8bmrsMhXGcpDyraOfQaPAcOH=RQPv5A@mail.gmail.com>
 <20230217145052.y526nmjudi6t2ael@revolver>
In-Reply-To: <20230217145052.y526nmjudi6t2ael@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 17 Feb 2023 07:54:04 -0800
Message-ID: <CAJuCfpHJeO6L3HnsX8X=XwBSDbXfPubsWXcRdhm5SvT_u+doKg@mail.gmail.com>
Subject: Re: [PATCH v3 21/35] mm/mmap: write-lock adjacent VMAs if they can
 grow into unmapped area
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, peterz@infradead.org, ldufour@linux.ibm.com,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 6:51 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [230216 14:36]:
> > On Thu, Feb 16, 2023 at 7:34 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > >
> > >
> > > First, sorry I didn't see this before v3..
> >
> > Feedback at any time is highly appreciated!
> >
> > >
> > > * Suren Baghdasaryan <surenb@google.com> [230216 00:18]:
> > > > While unmapping VMAs, adjacent VMAs might be able to grow into the area
> > > > being unmapped. In such cases write-lock adjacent VMAs to prevent this
> > > > growth.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  mm/mmap.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 118b2246bba9..00f8c5798936 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -2399,11 +2399,13 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > > >        * down_read(mmap_lock) and collide with the VMA we are about to unmap.
> > > >        */
> > > >       if (downgrade) {
> > > > -             if (next && (next->vm_flags & VM_GROWSDOWN))
> > > > +             if (next && (next->vm_flags & VM_GROWSDOWN)) {
> > > > +                     vma_start_write(next);
> > > >                       downgrade = false;
> > >
> > > If the mmap write lock is insufficient to protect us from next/prev
> > > modifications then we need to move *most* of this block above the maple
> > > tree write operation, otherwise we have a race here.  When I say most, I
> > > mean everything besides the call to mmap_write_downgrade() needs to be
> > > moved.
> >
> > Which prior maple tree write operation are you referring to? I see
> > __split_vma() and munmap_sidetree() which both already lock the VMAs
> > they operate on, so page faults can't happen in those VMAs.
>
> The write that removes the VMAs from the maple tree a few lines above..
> /* Point of no return */
>
> If the mmap lock is not sufficient, then we need to move the
> vma_start_write() of prev/next to above the call to
> vma_iter_clear_gfp() in do_vmi_align_munmap().
>
> But I still think it IS enough.
>
> >
> > >
> > > If the mmap write lock is sufficient to protect us from next/prev
> > > modifications then we don't need to write lock the vmas themselves.
> >
> > mmap write lock is not sufficient because with per-VMA locks we do not
> > take mmap lock at all.
>
> Understood, but it also does not expand VMAs.
>
> >
> > >
> > > I believe this is for expand_stack() protection, so I believe it's okay
> > > to not vma write lock these vmas.. I don't think there are other areas
> > > where we can modify the vmas without holding the mmap lock, but others
> > > on the CC list please chime in if I've forgotten something.
> > >
> > > So, if I am correct, then you shouldn't lock next/prev and allow the
> > > vma locking fault method on these vmas.  This will work because
> > > lock_vma_under_rcu() uses mas_walk() on the faulting address.  That is,
> > > your lock_vma_under_rcu() will fail to find anything that needs to be
> > > grown and go back to mmap lock protection.  As it is written today, the
> > > vma locking fault handler will fail and we will wait for the mmap lock
> > > to be released even when the vma isn't going to expand.
> >
> > So, let's consider a case when the next VMA is not being removed (so
> > it was neither removed nor locked by munmap_sidetree()) and it is
> > found by lock_vma_under_rcu() in the page fault handling path.
>
> By this point next VMA is either NULL or outside the munmap area, so
> what you said here is always true.
>
> >Page
> > fault handler can now expand it and push into the area we are
> > unmapping in unmap_region(). That is the race I'm trying to prevent
> > here by locking the next/prev VMAs which can be expanded before
> > unmap_region() unmaps them. Am I missing something?
>
> Yes, I think the part you are missing (or I am missing..) is that
> expand_stack() will never be called without the mmap lock.  We don't use
> the vma locking to expand the stack.

Ah, yes, you are absolutely right. I missed that when the VMA explands
as a result of a page fault, lock_vma_under_rcu() can't find the
faulting VMA (the fault is outside of the area and hence the need to
expand) and will fall back to mmap read locking. Since
do_vmi_align_munmap() holds the mmap write lock and does not downgrade
it, the race will be avoided and expansion will wait until we drop the
mmap write lock.
Good catch Liam! We can drop this patch completely from the series.
Thanks,
Suren.

>
> ...
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
