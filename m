Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3466E8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjAQVmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjAQVjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:39:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BA939BAA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673985703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5BQpAmV2pgCsbRtNwN3ZnWFBsEHFptUi8fvWmjdDRno=;
        b=f4ViyFJo9bm2gGXEirnVK5YbRXyoUDPB3ZN4Z4pm6dwkEln+evIEyNYR8+M+2qdJwx3NhI
        TTP+AQ+KjX23HqLGCuRG3VMwA4Ea9dOSQpPrdSIsvOJQc4Omd/ZP/N+VPIP4iYJYSWEa2V
        RsZpV1phOuuGyCN8hFKnZ3oFU9PHMqo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-59-klB90QffOEy2H6RLqjJFug-1; Tue, 17 Jan 2023 15:01:42 -0500
X-MC-Unique: klB90QffOEy2H6RLqjJFug-1
Received: by mail-pg1-f198.google.com with SMTP id e11-20020a63d94b000000b0048988ed9a6cso14341018pgj.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BQpAmV2pgCsbRtNwN3ZnWFBsEHFptUi8fvWmjdDRno=;
        b=17+Kr7rnJx3Vwe7JTHLBLti5lI0yiTmy+63BaqsckM/YgimX4SVl/NHNIBNEMMb+Us
         scSAmyMCjNcMvFn3xj/piaEzHCKsArV2kw1yvfjIfBqYHV2ARiNv/W/IgIBKbFNoR8Zc
         MKWOzP+oxpQD7WEYjB/lfWGBkhCl7PRxAm++qs+4/MLpPmpwiP3vEl6SEgQY9WdlV39j
         TyBjQcmCd/qRUQuey8VqT5o0WUE53g7Y3htQVtQ8kfHYx8mJzOj4GEWgZTFFaw7VjmYN
         VUQMBeeMUjPXE4jqbihyW9SGqBorTn+HJYTWdSGqBalMkoS72P8G0I3tuyyF+/qwd/vZ
         PSJQ==
X-Gm-Message-State: AFqh2krBN4QqwAtOEWfUrTPfohkvPIO5+//aSKINXHAdiSxpw1nnW3OJ
        Xqv1lfQ2+u+X4pXaepZYbiTZh/9HA49w07Sb7Qaq5/3/WrDUuGC3yIED2pHIjnQt0hGtZCHzlhp
        nx/X9zUZReJIYujASDIK2tzzpewlNPLJMXUazn+66
X-Received: by 2002:a65:66c9:0:b0:498:84f3:85f0 with SMTP id c9-20020a6566c9000000b0049884f385f0mr352190pgw.558.1673985701322;
        Tue, 17 Jan 2023 12:01:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtHYYJpgy7FdEJ+EH+RwomrMrCtFcWjgc7VlFOeecPjKBJUj8aIvEzhLgoedJ6OJHbSouXvFbRou0kQJ68mgNE=
X-Received: by 2002:a65:66c9:0:b0:498:84f3:85f0 with SMTP id
 c9-20020a6566c9000000b0049884f385f0mr352185pgw.558.1673985701039; Tue, 17 Jan
 2023 12:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20230117172649.52465-1-wander@redhat.com> <23a15414-927c-ba0d-eb6a-58f6191ce17b@redhat.com>
 <c7cae935-c378-24bf-7e9c-bbf5feb4185a@redhat.com>
In-Reply-To: <c7cae935-c378-24bf-7e9c-bbf5feb4185a@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Tue, 17 Jan 2023 17:01:29 -0300
Message-ID: <CAAq0SUmNTvdvhp+67XW+OV6N2DSDjLR5M_CFWBaAAG354kWiMg@mail.gmail.com>
Subject: Re: [PATCH] rtmutex: ensure we wake up the top waiter
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 4:40 PM Waiman Long <longman@redhat.com> wrote:
>
> On 1/17/23 14:32, Waiman Long wrote:
> > On 1/17/23 12:26, Wander Lairson Costa wrote:
> >> In task_blocked_on_lock() we save the owner, release the wait_lock and
> >> call rt_mutex_adjust_prio_chain(). Before we acquire the wait_lock
> >> again, the owner may release the lock and deboost.
> > Are you referring to task_blocks_on_rt_mutex(), not
> > task_blocked_on_lock()?
> >>
> >> rt_mutex_adjust_prio_chain() acquires the wait_lock. In the requeue
> >> phase, waiter may be initially in the top of the queue, but after
> >> dequeued and requeued it may no longer be true.
> >>
> >> This scenario ends up waking the wrong task, which will verify it is no
> >> the top waiter and comes back to sleep. Now we have a situation in which
> >> no task is holding the lock but no one acquires it.
> >>
> >> We can reproduce the bug in PREEMPT_RT with stress-ng:
> >>
> >> while true; do
> >>      stress-ng --sched deadline --sched-period 1000000000 \
> >>              --sched-runtime 800000000 --sched-deadline \
> >>              1000000000 --mmapfork 23 -t 20
> >> done
> >>
> >> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> >> ---
> >>   kernel/locking/rtmutex.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> >> index 010cf4e6d0b8..728f434de2bb 100644
> >> --- a/kernel/locking/rtmutex.c
> >> +++ b/kernel/locking/rtmutex.c
> >> @@ -901,8 +901,9 @@ static int __sched
> >> rt_mutex_adjust_prio_chain(struct task_struct *task,
> >>            * then we need to wake the new top waiter up to try
> >>            * to get the lock.
> >>            */
> >> -        if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
> >> -            wake_up_state(waiter->task, waiter->wake_state);
> >> +        top_waiter = rt_mutex_top_waiter(lock);
> >> +        if (prerequeue_top_waiter != top_waiter)
> >> +            wake_up_state(top_waiter->task, top_waiter->wake_state);
> >>           raw_spin_unlock_irq(&lock->wait_lock);
> >>           return 0;
> >>       }
> >
> > I would say that if a rt_mutex has no owner but have waiters, we
> > should always wake up the top waiter whether or not it is the current
> > waiter. So what is the result of the stress-ng run above? Is it a
> > hang? It is not clear from your patch description.
>
> BTW, if it is a hang. What arch has this problem? x86 or arm64? There is
> a recent report of some rt_mutex locking issue in arm64, I believe. I
> don't know if it will be related. So it is important to know in what
> arch you see this problem.
>

x86_64. Notice, at least in my test case, it only manifested under PREEMPT_RT.

> Cheers,
> Longman
>

