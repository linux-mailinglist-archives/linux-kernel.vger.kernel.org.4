Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F325F763E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJGJ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJGJ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:28:26 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE473B56DF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 02:28:24 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v134so4859057oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JxLAH+bnod0VfWRdnLNFFaWOZptJDJqV0Gq0f68hNdc=;
        b=Lld1GrctRhHOLbNsUNrujKK+MA6Gux6LyL6cFvYmqezas+x2uXUh0neHffeKlflrpg
         dZkxx8hziJWp3N7O/T/3HPCuk+wbLZG0pbMfhDNLxG9i7Pulwx7P45z/gUbRlk7cHsWM
         OULqzB+Sd9lowQX+RG4FzxkPt0m5B6fPgGT1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxLAH+bnod0VfWRdnLNFFaWOZptJDJqV0Gq0f68hNdc=;
        b=XvdaKTTxD3PAcceaTWLJkjQ2SxNiXy6tQT6gUcfWNZIkgbBflAazAsAF/DzqYE8DL0
         /z9xZiF6HWFEa3zXsq8qJTTogQpO11nZgElAj6nmetkk3glLJ8sjn+SrseT9rXiU/sge
         7mRT15rFcMqP4tWaYhhPizgYk7XK/gZiQ7k8b5bqbwElfZWvS7fGveVJPCmPjoYBR1xB
         4sK+evqBA68t/X3QfkDnja+ZX6wWh5EvmoJP/vaMNH/21ByNOhPojCV+LP+p1MoypYf1
         8PoV/yT80mLoyzsY480KsrQEPN8ek77SGmLCZTOF8oCzj9UupyDSzKgYgyicRV8Zpe8v
         RG7Q==
X-Gm-Message-State: ACrzQf0T2cDbT0XVSuw5uMBeYVi5UOQnkC1WshsfIWN5K2hGjxMP5MeG
        2/YLYAZb2aWL/5TqoX8RWoBSxcExq13xDxrNRoaXXA==
X-Google-Smtp-Source: AMsMyM4iCHqpCD5g3MdwdOFmIgnP809IboqOPrt054xZ791CkiY/TmbkuiTtOrcsRVDaXZe6VZnDY559987elRnrgWI=
X-Received: by 2002:a05:6808:e8c:b0:354:2751:69ae with SMTP id
 k12-20020a0568080e8c00b00354275169aemr2402247oil.228.1665134904319; Fri, 07
 Oct 2022 02:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
 <CADnq5_Of-8ZyBxee0fZ=0x-eV-2NX_+e9sd-9nmuHdLugSHp2g@mail.gmail.com>
 <CAHk-=wi43xD06UgO2McDT3R=ze_aHgOGjcDOoggSwmQRv2kA+A@mail.gmail.com>
 <CADnq5_N0Ef+1VUoDLdpHfJXqZFuPYbx5Lq+94NWciHcQC+VrMg@mail.gmail.com>
 <CAPM=9tyAOnzwXyyPuoceZ1mimAkzxR-63YmKfVtcQX=swywNvg@mail.gmail.com>
 <CAHk-=wgghR4N-4XWjoK18NDkvjBL7i00ab8+otQg955pNGG_dQ@mail.gmail.com> <CAKMK7uF_fKs=Ge5b3sCxa3YgWFaJsLBdCQVj+fDn6ukh9GvKKA@mail.gmail.com>
In-Reply-To: <CAKMK7uF_fKs=Ge5b3sCxa3YgWFaJsLBdCQVj+fDn6ukh9GvKKA@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 7 Oct 2022 11:28:12 +0200
Message-ID: <CAKMK7uHsZejvVN1RcS23YsFhb4JvuScpHys17Vn+A7PirE+q1A@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to add Andrey as scheduler maintainer.
-Daniel

On Fri, 7 Oct 2022 at 10:16, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Fri, 7 Oct 2022 at 01:45, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Oct 6, 2022 at 1:25 PM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > >
> > > [ 1234.778760] BUG: kernel NULL pointer dereference, address: 0000000000000088
> > > [ 1234.778813] RIP: 0010:drm_sched_job_done.isra.0+0xc/0x140 [gpu_sched]
> >
> > As far as I can tell, that's the line
> >
> >         struct drm_gpu_scheduler *sched = s_fence->sched;
> >
> > where 's_fence' is NULL. The code is
> >
> >    0: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
> >    5: 41 54                push   %r12
> >    7: 55                    push   %rbp
> >    8: 53                    push   %rbx
> >    9: 48 89 fb              mov    %rdi,%rbx
> >    c:* 48 8b af 88 00 00 00 mov    0x88(%rdi),%rbp <-- trapping instruction
> >   13: f0 ff 8d f0 00 00 00 lock decl 0xf0(%rbp)
> >   1a: 48 8b 85 80 01 00 00 mov    0x180(%rbp),%rax
> >
> > and that next 'lock decl' instruction would have been the
> >
> >         atomic_dec(&sched->hw_rq_count);
> >
> > at the top of drm_sched_job_done().
> >
> > Now, as to *why* you'd have a NULL s_fence, it would seem that
> > drm_sched_job_cleanup() was called with an active job. Looking at that
> > code, it does
> >
> >         if (kref_read(&job->s_fence->finished.refcount)) {
> >                 /* drm_sched_job_arm() has been called */
> >                 dma_fence_put(&job->s_fence->finished);
> >         ...
> >
> > but then it does
> >
> >         job->s_fence = NULL;
> >
> > anyway, despite the job still being active. The logic of that kind of
> > "fake refcount" escapes me. The above looks fundamentally racy, not to
> > say pointless and wrong (a refcount is a _count_, not a flag, so there
> > could be multiple references to it, what says that you can just
> > decrement one of them and say "I'm done").
>
> Just figured I'll clarify this, because it's indeed a bit wtf and the
> comment doesn't explain much. drm_sched_job_cleanup can be called both
> when a real job is being cleaned up (which holds a full reference on
> job->s_fence and needs to drop it) and to simplify error path in job
> constructions (and the "is this refcount initialized already" signals
> what exactly needs to be cleaned up or not). So no race, because the
> only times this check goes different is when job construction has
> failed before the job struct is visible by any other thread.
>
> But yeah the comment could actually explain what's going on here :-)
>
> And yeah the patch Dave reverted screws up the cascade of references
> that ensures this all stays alive until drm_sched_job_cleanup is
> called on active jobs, so looks all reasonable to me. Some Kunit tests
> maybe to exercise these corners? Not the first time pure scheduler
> code blew up, so proably worth the effort.
> -Daniel
>
> >
> > Now, _why_ any of that happens, I have no idea. I'm just looking at
> > the immediate "that pointer is NULL" thing, and reacting to what looks
> > like a completely bogus refcount pattern.
> >
> > But that odd refcount pattern isn't new, so it's presumably some user
> > on the amd gpu side that changed.
> >
> > The problem hasn't happened again for me, but that's not saying a lot,
> > since it was very random to begin with.
> >
> >                  Linus
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
