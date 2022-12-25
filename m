Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3F655C34
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 03:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLYC6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 21:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYC6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 21:58:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357DF6335
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 18:58:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02AD9B80159
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 02:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD68C433D2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 02:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671937081;
        bh=avDAMGC+C1j5faAVBkpdXk6pN0WVvxqBtHjZ+6nv4jY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uniNRo6e5YZ6dQOHP5zrsLSuKQGUATTZzwAo0iiBMkEz5gmt1yyjjpcpqd1F55h/y
         wEM9AIRebaDNcGo3xxPOccW+6XpEs4OosGK9vMUCOjXyhWDWFeN6QaAXafRstvl5Pb
         uwTk1t5h73ukCY0AxE6RVNSQVZ0wN8uc0K/624BeuKzne2U7LHR82JTX7eRkzi/zRa
         PNCBQ1vHq8u5qKR/u8IhgQxUF8OxRzHWTMdT3o3Ng2zZ0iEkAUUfbht6Azs5hieoty
         wR6Z5WRGsoqOvN2j5bmUU1UIB0BcFn176jnIKkJhjo4/74IhF//79JDYlKHpYObB4s
         TfKYoChi97s/Q==
Received: by mail-ej1-f46.google.com with SMTP id u19so20058482ejm.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 18:58:01 -0800 (PST)
X-Gm-Message-State: AFqh2kpLHjh9xXu1FWt/2jrOScCwoxNjlpt/tCp9rp7wa7sebHA79uhn
        syquVywv7ubkjUv9BWEcq8PzYWEhE7fOGJhhWXc=
X-Google-Smtp-Source: AMrXdXsJDQE0dHO3yhvMFKCrsqoG/PiR1JOEixHikS4/ThIqbpILclKBv+bM+28Qt1EZtYDWGPXTSJNF7EA8AUUDDhk=
X-Received: by 2002:a17:907:1de4:b0:7c0:dab0:d722 with SMTP id
 og36-20020a1709071de400b007c0dab0d722mr789731ejc.353.1671937079971; Sat, 24
 Dec 2022 18:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20221224120545.262989-1-guoren@kernel.org> <08ce1ab6-4678-74ce-43cc-2d3f04d1525d@redhat.com>
In-Reply-To: <08ce1ab6-4678-74ce-43cc-2d3f04d1525d@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 25 Dec 2022 10:57:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS52jBm7_3c=9i1uPjmV90=42xs4dOs6woA4NnHf4RHgQ@mail.gmail.com>
Message-ID: <CAJF2gTS52jBm7_3c=9i1uPjmV90=42xs4dOs6woA4NnHf4RHgQ@mail.gmail.com>
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

On Sun, Dec 25, 2022 at 9:55 AM Waiman Long <longman@redhat.com> wrote:
>
> On 12/24/22 07:05, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > When we're pending, we only care about lock value. The xchg_tail
> > wouldn't affect the pending state. That means the hardware thread
> > could stay in a sleep state and leaves the rest execution units'
> > resources of pipeline to other hardware threads. This optimization
> > may work only for SMT scenarios because the granularity between
> > cores is cache-block.
Please have a look at the comment I've written.

> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > ---
> >   kernel/locking/qspinlock.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > index 2b23378775fe..ebe6b8ec7cb3 100644
> > --- a/kernel/locking/qspinlock.c
> > +++ b/kernel/locking/qspinlock.c
> > @@ -371,7 +371,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >       /*
> >        * We're pending, wait for the owner to go away.
> >        *
> > -      * 0,1,1 -> 0,1,0
> > +      * 0,1,1 -> *,1,0
> >        *
> >        * this wait loop must be a load-acquire such that we match the
> >        * store-release that clears the locked bit and create lock
> Yes, we don't care about the tail.
> > @@ -380,7 +380,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >        * barriers.
> >        */
> >       if (val & _Q_LOCKED_MASK)
> > -             atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
> > +             smp_cond_load_acquire(&lock->locked, !VAL);
> >
> >       /*
> >        * take ownership and clear the pending bit.
>
> We may save an AND operation here which may be a cycle or two.  I
> remember that it may be more costly to load a byte instead of an integer
> in some arches. So it doesn't seem like that much of an optimization
> from my point of view.
The reason is, of course, not here. See my commit comment.

> I know that arm64 will enter a low power state in
> this *cond_load_acquire() loop, but I believe any change in the state of
> the the lock cacheline will wake it up. So it doesn't really matter if
> you are checking a byte or an int.
The situation is the SMT scenarios in the same core. Not an entering
low-power state situation. Of course, the granularity between cores is
"cacheline", but the granularity between SMT hw threads of the same
core could be "byte" which internal LSU handles. For example, when a
hw-thread yields the resources of the core to other hw-threads, this
patch could help the hw-thread stay in the sleep state and prevent it
from being woken up by other hw-threads xchg_tail.

Finally, from the software semantic view, does the patch make it more
accurate? (We don't care about the tail here.)

>
> Do you have any other data point to support your optimization claim?
>
> Cheers,
> Longman
>


-- 
Best Regards
 Guo Ren
