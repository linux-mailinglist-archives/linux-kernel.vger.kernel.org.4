Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3F266E8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjAQVki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjAQVhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:37:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC54ED16
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673985649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r1PBXN1RQW1eq/aZTpuR9k40fNlrj7TN9GuVKy15iSY=;
        b=LiiAeB4nD+mOOoRLsb1MwAc/DdmRpmtMxUegf5vl0W7TZzBmzWWeHlUyyz5hcW7aOaCCRP
        SjpcodEGmVlWJB7ft4UpGO/sJClSm/tZTgFQPCQ7k5hhhST3GYyJjizZdyWlyRHah5/M91
        98lwqWFD6eI4dldAZDFt0C7xFLUM0uM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-1ESy8WkdPyOWI1SfjSpgNw-1; Tue, 17 Jan 2023 15:00:48 -0500
X-MC-Unique: 1ESy8WkdPyOWI1SfjSpgNw-1
Received: by mail-pj1-f70.google.com with SMTP id o16-20020a17090ac71000b00229ba85bc63so386671pjt.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1PBXN1RQW1eq/aZTpuR9k40fNlrj7TN9GuVKy15iSY=;
        b=TF1p+gKSJlE9aUiDstKITeRuS0dY0RT87hjXnCDSAXJ+Amr7fZ+2nyYU3worAmo2qF
         q0eOhXE2zWYYrGHeMOgdD4BOKBFn/Z9e9xCKA20g57YlI9jAOboAHXGbq4boJ8OPO0iP
         m+s5JGaJG8fu2mwjvLi65ImOWTrksLDypn4KvNJSP2doSz12x3Rs0KMKUxkePhptFfLc
         U7lXGaFbP3oBY9RudeyNGT7+xQoZlw5vVs21kgMf0+UqJscqWjDlfoaDn59JXB1qJscC
         GHkporDWS62JN2QVnfCMHA12vJUV855aTe4LPvNoUrvQyiNyLTmhcQD53QhhfC9lUdtU
         9piw==
X-Gm-Message-State: AFqh2krxYHbvJgFBIcn+L7hpbhR2RKumTEiPJJdxEbCsxk5eJ3sKLJbm
        0JIgd7e5aIy0CU13c1NaeRvQyTSSwn64dWQ1EB2BMzLljOrBzxC3H6r5pjFR9KhcWYMWpo9b7iY
        oZcqsf0a+uKMzUIq9nwSjwQNmFMWnabvzDG0V08tF
X-Received: by 2002:a63:1e02:0:b0:494:ae49:789c with SMTP id e2-20020a631e02000000b00494ae49789cmr448435pge.473.1673985647101;
        Tue, 17 Jan 2023 12:00:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtRxK3ZTF6S0d17/xZXz/KT/d+Gtd+9wxPTxMOgZTm1lIyql5WgwRm1Qz0HqIHPvsENx6wjtcMv/lE+8g1XVGg=
X-Received: by 2002:a63:1e02:0:b0:494:ae49:789c with SMTP id
 e2-20020a631e02000000b00494ae49789cmr448426pge.473.1673985646843; Tue, 17 Jan
 2023 12:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20230117172649.52465-1-wander@redhat.com> <23a15414-927c-ba0d-eb6a-58f6191ce17b@redhat.com>
In-Reply-To: <23a15414-927c-ba0d-eb6a-58f6191ce17b@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Tue, 17 Jan 2023 17:00:35 -0300
Message-ID: <CAAq0SUmYRHQLcGx2K73suEPDzpZeTU5gKeFvZb1Q+y56J5h+Tg@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 4:32 PM Waiman Long <longman@redhat.com> wrote:
>
> On 1/17/23 12:26, Wander Lairson Costa wrote:
> > In task_blocked_on_lock() we save the owner, release the wait_lock and
> > call rt_mutex_adjust_prio_chain(). Before we acquire the wait_lock
> > again, the owner may release the lock and deboost.
> Are you referring to task_blocks_on_rt_mutex(), not task_blocked_on_lock()?
> >
> > rt_mutex_adjust_prio_chain() acquires the wait_lock. In the requeue
> > phase, waiter may be initially in the top of the queue, but after
> > dequeued and requeued it may no longer be true.
> >
> > This scenario ends up waking the wrong task, which will verify it is no
> > the top waiter and comes back to sleep. Now we have a situation in which
> > no task is holding the lock but no one acquires it.
> >
> > We can reproduce the bug in PREEMPT_RT with stress-ng:
> >
> > while true; do
> >      stress-ng --sched deadline --sched-period 1000000000 \
> >           --sched-runtime 800000000 --sched-deadline \
> >           1000000000 --mmapfork 23 -t 20
> > done
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >   kernel/locking/rtmutex.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> > index 010cf4e6d0b8..728f434de2bb 100644
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -901,8 +901,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
> >                * then we need to wake the new top waiter up to try
> >                * to get the lock.
> >                */
> > -             if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
> > -                     wake_up_state(waiter->task, waiter->wake_state);
> > +             top_waiter = rt_mutex_top_waiter(lock);
> > +             if (prerequeue_top_waiter != top_waiter)
> > +                     wake_up_state(top_waiter->task, top_waiter->wake_state);
> >               raw_spin_unlock_irq(&lock->wait_lock);
> >               return 0;
> >       }
>
> I would say that if a rt_mutex has no owner but have waiters, we should
> always wake up the top waiter whether or not it is the current waiter.

In practice, there is this case in which the unlock code wakes up the
top waiter, but before it task awakes, a third running task changes
the top waiter.

> So what is the result of the stress-ng run above? Is it a hang? It is
> not clear from your patch description.

It manifests as a rcu_preempt stall.

>
> I am not that familiar with the rt_mutex code, I am cc'ing Thomas and
> Sebastian for their input.
>
> Cheers,
> Longman
>

