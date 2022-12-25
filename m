Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DB8655D13
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 13:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiLYMAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 07:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiLYL7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 06:59:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399E65A8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:59:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 228E9B8069A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 11:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04B3C433F0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671969555;
        bh=W3qgNgTh4U9hFUT4NYtpWuqxWT8935HcdJ8dljod1ww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YfuVCCIBUfBTPoIJqgxjH0US7SIkebJpaFuGOPi/U0+7wlUcayTKT6/jd7xDEeg+k
         bJzimrQvPK3vOa1dys7DCFj46GGfp10smFjekIfjK4TPyIs14NKjSdvp6eOcSzRUwB
         9Q0fAU7DdpCsLFTomuP7N3PZuYTYHEcaCGXNsJw54WKcXXdi4brhkgswU5kjz5ETpV
         /MoVIo0zrrJaxRc6U0o8uq+kAtG0EH2B9RzA9qVPhL7nH8LwEcaSn1BQ2HqJ9LUeIn
         LCcNwhgUEY51hgfYacmmYWgeArh/V3yS1AH89yD3apFnYXY+IX2KMjthAspKN6eHrl
         hppQhRgm7CMOw==
Received: by mail-ej1-f51.google.com with SMTP id t17so21438091eju.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:59:15 -0800 (PST)
X-Gm-Message-State: AFqh2kpEft8tE/hHYlFTpJxaY+F4USorGB3FJEwvyQlAPuB6YOCc2Ufk
        9EAxw02PJvxPW0S3nRHYO2wl8J5tGBzcFWE68S8=
X-Google-Smtp-Source: AMrXdXuMsFKZGCLmTSbtaix5H2EsCpTi+6s3KM0Pfi/VMWtBPu/iIpe7478VgJQMFyhpM5+fAhCXao8OFr7eFV/A/ZA=
X-Received: by 2002:a17:906:33d4:b0:7c0:f7af:7c5e with SMTP id
 w20-20020a17090633d400b007c0f7af7c5emr1056071eja.406.1671969553982; Sun, 25
 Dec 2022 03:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20221224120545.262989-1-guoren@kernel.org> <08ce1ab6-4678-74ce-43cc-2d3f04d1525d@redhat.com>
 <CAJF2gTS52jBm7_3c=9i1uPjmV90=42xs4dOs6woA4NnHf4RHgQ@mail.gmail.com>
 <b01060ba-6069-d33e-5151-22a7d9577f13@redhat.com> <e30f671d-8e74-d5b9-cdba-472d7297f257@redhat.com>
In-Reply-To: <e30f671d-8e74-d5b9-cdba-472d7297f257@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 25 Dec 2022 19:59:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTkLY+mUoG0oqw0mmJH0hK5bXYvrmYcLL1-zwNbzOb9TQ@mail.gmail.com>
Message-ID: <CAJF2gTTkLY+mUoG0oqw0mmJH0hK5bXYvrmYcLL1-zwNbzOb9TQ@mail.gmail.com>
Subject: Re: [PATCH] locking/qspinlock: Optimize pending state waiting for unlock
To:     Waiman Long <longman@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2022 at 11:31 AM Waiman Long <longman@redhat.com> wrote:
>
> On 12/24/22 22:29, Waiman Long wrote:
> > On 12/24/22 21:57, Guo Ren wrote:
> >> On Sun, Dec 25, 2022 at 9:55 AM Waiman Long <longman@redhat.com> wrote:
> >>> On 12/24/22 07:05, guoren@kernel.org wrote:
> >>>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>>
> >>>> When we're pending, we only care about lock value. The xchg_tail
> >>>> wouldn't affect the pending state. That means the hardware thread
> >>>> could stay in a sleep state and leaves the rest execution units'
> >>>> resources of pipeline to other hardware threads. This optimization
> >>>> may work only for SMT scenarios because the granularity between
> >>>> cores is cache-block.
> >> Please have a look at the comment I've written.
> >>
> >>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>>> Cc: Waiman Long <longman@redhat.com>
> >>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>> Cc: Boqun Feng <boqun.feng@gmail.com>
> >>>> Cc: Will Deacon <will@kernel.org>
> >>>> Cc: Ingo Molnar <mingo@redhat.com>
> >>>> ---
> >>>>    kernel/locking/qspinlock.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> >>>> index 2b23378775fe..ebe6b8ec7cb3 100644
> >>>> --- a/kernel/locking/qspinlock.c
> >>>> +++ b/kernel/locking/qspinlock.c
> >>>> @@ -371,7 +371,7 @@ void __lockfunc
> >>>> queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >>>>        /*
> >>>>         * We're pending, wait for the owner to go away.
> >>>>         *
> >>>> -      * 0,1,1 -> 0,1,0
> >>>> +      * 0,1,1 -> *,1,0
> >>>>         *
> >>>>         * this wait loop must be a load-acquire such that we match the
> >>>>         * store-release that clears the locked bit and create lock
> >>> Yes, we don't care about the tail.
> >>>> @@ -380,7 +380,7 @@ void __lockfunc
> >>>> queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >>>>         * barriers.
> >>>>         */
> >>>>        if (val & _Q_LOCKED_MASK)
> >>>> -             atomic_cond_read_acquire(&lock->val, !(VAL &
> >>>> _Q_LOCKED_MASK));
> >>>> +             smp_cond_load_acquire(&lock->locked, !VAL);
> >>>>
> >>>>        /*
> >>>>         * take ownership and clear the pending bit.
> >>> We may save an AND operation here which may be a cycle or two.  I
> >>> remember that it may be more costly to load a byte instead of an
> >>> integer
> >>> in some arches. So it doesn't seem like that much of an optimization
> >>> from my point of view.
> >> The reason is, of course, not here. See my commit comment.
> >>
> >>> I know that arm64 will enter a low power state in
> >>> this *cond_load_acquire() loop, but I believe any change in the
> >>> state of
> >>> the the lock cacheline will wake it up. So it doesn't really matter if
> >>> you are checking a byte or an int.
> >> The situation is the SMT scenarios in the same core. Not an entering
> >> low-power state situation. Of course, the granularity between cores is
> >> "cacheline", but the granularity between SMT hw threads of the same
> >> core could be "byte" which internal LSU handles. For example, when a
> >> hw-thread yields the resources of the core to other hw-threads, this
> >> patch could help the hw-thread stay in the sleep state and prevent it
> >> from being woken up by other hw-threads xchg_tail.
> >>
> >> Finally, from the software semantic view, does the patch make it more
> >> accurate? (We don't care about the tail here.)
> >
> > Thanks for the clarification.
> >
> > I am not arguing for the simplification part. I just want to clarify
> > my limited understanding of how the CPU hardware are actually dealing
> > with these conditions.
> >
> > With that, I am fine with this patch. It would be nice if you can
> > elaborate a bit more in your commit log.
> >
> > Acked-by: Waiman Long <longman@redhat.com>
> >
> BTW, have you actually observe any performance improvement with this patch?
Not yet. I'm researching how the hardware could satisfy qspinlock
better. Here are three points I concluded:
 1. Atomic forward progress guarantee: Prevent unnecessary LL/SC
retry, which may cause expensive bus transactions when crossing the
NUMA nodes.
 2. Sub-word atomic primitive: Enable freedom from interference
between locked, pending, and tail.
 3. Load-cond primitive: Prevent processor from wasting loop
operations for detection.

For points 2 & 3, I have a continuous proposal to add new
atomic_read_cond_mask & smp_load_cond_mask for Linux atomic primitives
[1].

[1]: https://lore.kernel.org/lkml/20221225115529.490378-1-guoren@kernel.org/



>
> Cheers,
> Longman
>


--
Best Regards
 Guo Ren
