Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061B0670D00
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjAQXPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjAQXNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:13:35 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F27A24B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:57:59 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id e130so6170697yba.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nNX5YwNB62Cr4mPdPksUy7ZFxJz80e5EP+vDe3CToes=;
        b=UJW1FUoXBMJDeWsaN1k6oDrmr67QWLZqnIBJQh4PRlEesBk3tMiIkorIvA8FJBfO3J
         2yfftCQymRobA0fqZ3eS51nFr5UzM2Cq8hseu0uwO24QqY6pttuPkfNz3B0D2bM+8cQJ
         hrr8t4f0iV2D0N+JFF6eJ9UdDbJAw07cN0sEOCaUwAveqe9Qasg0WIQ4AQvZjbCNFRFf
         n7ADIVjMgqK9ddiVy7LpnVId2Ph4+X+JMGhSvCvPPeRbvgwz5zXyZeESZBnXaszCtyKP
         AM4f/andSFYwbNHDumyMa1HT7RMe/o5/qOtc+sxFbvcQj4VZud5TTfMFUGXr1wMMcRtQ
         Yriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNX5YwNB62Cr4mPdPksUy7ZFxJz80e5EP+vDe3CToes=;
        b=hobu4GGCbDzynJ9Q572MbTP68Tk2bHhgJwcUDAq0iwiqELedqtTa1nPTEjL0Sud5Nz
         ytVbU7op0yBVKckfxda2Sc2VJcvZqSTis0iz8urKQvKD/1HAX3FmllJvt2IZU+A/Ar0h
         YxmYXIG7+m8U4bGtFcyPRhRv/awcyzTmULYLFjycDPSYnizpCyFyvnLRXlflpexW6vIL
         FJ/aEQDj6mdytS+YxC2l+D/DcZ3MIyPnvL/uC1lF+C5xdvQeY8vcs0xcGpjkECDjhAqH
         puWkbqk6lun69JOKDrZ5+JvSCEYoPZHX+jasv2r+6VtkZpw6osEN7nxWN8fVuKREktVp
         xMXA==
X-Gm-Message-State: AFqh2kpN/L5UlenBqU5AznbdaOUlaOrwiGTn7+gAREBrsC2wPRB+CLhL
        U8PMN/KNXSzsoosqBE8z0QdYn6TOg+U6abXD6lU7pg==
X-Google-Smtp-Source: AMrXdXs706D7/Bu5iVfntQjoEJSNf8iye2tX48bplVHdlFbOfH7GJJD8B26WAHLzz8/nxZjbM/p4TlPO6wtoFHaiJ6w=
X-Received: by 2002:a25:ceca:0:b0:7e4:115c:9cf6 with SMTP id
 x193-20020a25ceca000000b007e4115c9cf6mr586280ybe.316.1673989078773; Tue, 17
 Jan 2023 12:57:58 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-33-surenb@google.com>
 <CAG48ez0Z-wnBLzCNDHgTviV0Ws+s4grX-sFRZ-43dxhJg+GzfA@mail.gmail.com> <CAG48ez1J2YC=_wu82p1BCgR+igd3aF_rwi5WmLJX9MjYM-BUsw@mail.gmail.com>
In-Reply-To: <CAG48ez1J2YC=_wu82p1BCgR+igd3aF_rwi5WmLJX9MjYM-BUsw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 12:57:47 -0800
Message-ID: <CAJuCfpHfJaowYqz9Ls-S_FwR1JUOsZ1XPwvj6m-CVUnFX_us6Q@mail.gmail.com>
Subject: Re: [PATCH 32/41] mm: prevent userfaults to be handled under per-vma lock
To:     Jann Horn <jannh@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
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

On Tue, Jan 17, 2023 at 12:36 PM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Jan 17, 2023 at 8:51 PM Jann Horn <jannh@google.com> wrote:
> > On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > Due to the possibility of handle_userfault dropping mmap_lock, avoid fault
> > > handling under VMA lock and retry holding mmap_lock. This can be handled
> > > more gracefully in the future.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Suggested-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  mm/memory.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 20806bc8b4eb..12508f4d845a 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -5273,6 +5273,13 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > >         if (!vma->anon_vma)
> > >                 goto inval;
> > >
> > > +       /*
> > > +        * Due to the possibility of userfault handler dropping mmap_lock, avoid
> > > +        * it for now and fall back to page fault handling under mmap_lock.
> > > +        */
> > > +       if (userfaultfd_armed(vma))
> > > +               goto inval;
> >
> > This looks racy wrt concurrent userfaultfd_register(). I think you'll
> > want to do the userfaultfd_armed(vma) check _after_ locking the VMA,
>
> I still think this change is needed...

Yes, I think you are right. I'll move the check after locking the VMA. Thanks!

>
> > and ensure that the userfaultfd code write-locks the VMA before
> > changing the __VM_UFFD_FLAGS in vma->vm_flags.
>
> Ah, but now I see you already took care of this half of the issue with
> the reset_vm_flags() change in
> https://lore.kernel.org/linux-mm/20230109205336.3665937-16-surenb@google.com/
> .
>
>
> > >         if (!vma_read_trylock(vma))
> > >                 goto inval;
> > >
> > > --
> > > 2.39.0
> > >
