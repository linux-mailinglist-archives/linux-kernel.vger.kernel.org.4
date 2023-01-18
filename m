Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC567277B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjARSv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjARSv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:51:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D225421A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674067866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8WAlP8B66I5tb7fPfxSgpp0jqfCeWEECxb5EHCZvLs4=;
        b=Ow4NWnlFU4kOLlWHhPjUKWrqTicEdg2To6NExsQfMP97KgJ2WjsVgiH6YyQXuOQWIBu0JG
        soddtzvsSy/1iBF2IsjD+8fnP9/1wxxEFy6VwPXjAyeiGy6A+wdwDvHWjM9sTXhNhFHDm9
        qDk4X01i9zOO9TnvfFbJCzy4h5cNawU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-TR8wGlluPuKLRizGNu4UQA-1; Wed, 18 Jan 2023 13:49:50 -0500
X-MC-Unique: TR8wGlluPuKLRizGNu4UQA-1
Received: by mail-pj1-f69.google.com with SMTP id om10-20020a17090b3a8a00b002299e350deaso1950331pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WAlP8B66I5tb7fPfxSgpp0jqfCeWEECxb5EHCZvLs4=;
        b=4Np6Zq30A2dbx1o5mWvO/qRMP54lzj80wM6t4rJ+cnP+YE2dNeIzMk/sRmCmhF4aKd
         7aeVX5o7wPojPJ+5AQ0E3ertmR9BvFSxMk5PSbZxmyRxZu2doHj/F4SbJqlkr64+qh0Q
         oScD2NomRtu2nJnvYIHD9PyqKe4zzWlHOxSF5P7f+YCx04IiH0UsYIfBCeBIrMwnTpej
         x22FsQmpo1HL7Ho4jhbPD3pT4cLffIrLjfkF6nTsZ80xRwLkFwaKdTDXKvleSKxF60P9
         IlbBDNid6J+A5tTCV+Ot6V6G9MULBfv71lJvbBixW/mlyhI5Q5+MG9ScfU9bMcN7FyRk
         r5ag==
X-Gm-Message-State: AFqh2kowVTf54eOQX78GYRtSOkSF15tnMJvMAdEk7pA7tjZHvTmLFYab
        jA59RmAjP2n8FntNTweAErxDsX9F334sQLoNZhpq8InYHNlPYJgCIPE8y67HuEiJW96141lZS7v
        pPAyUDFYiU+8nC2qS6kv/IqaD5YUD2VcY6pdeGjtt
X-Received: by 2002:aa7:8602:0:b0:576:b4ce:42b4 with SMTP id p2-20020aa78602000000b00576b4ce42b4mr768495pfn.61.1674067789124;
        Wed, 18 Jan 2023 10:49:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv6F6hQyxY0MjeFbXI35oPjHV+cXzxRlNG/f3aV5rcWjp346prf28GNPnspJI02eD8dcvOHx/Sic2WBXsZt0uk=
X-Received: by 2002:aa7:8602:0:b0:576:b4ce:42b4 with SMTP id
 p2-20020aa78602000000b00576b4ce42b4mr768492pfn.61.1674067788798; Wed, 18 Jan
 2023 10:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20230117172649.52465-1-wander@redhat.com> <875yd4k8qd.ffs@tglx>
In-Reply-To: <875yd4k8qd.ffs@tglx>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Wed, 18 Jan 2023 15:49:37 -0300
Message-ID: <CAAq0SUkN38V00HqV3Hk3ee_-=vfkKxG9xtR3n=4gAT+zCs+=Zg@mail.gmail.com>
Subject: Re: [PATCH] rtmutex: ensure we wake up the top waiter
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>,
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

On Tue, Jan 17, 2023 at 9:05 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Wander!
>
> On Tue, Jan 17 2023 at 14:26, Wander Lairson Costa wrote:
> > In task_blocked_on_lock() we save the owner, release the wait_lock and
> > call rt_mutex_adjust_prio_chain(). Before we acquire the wait_lock
> > again, the owner may release the lock and deboost.
>
> This does not make sense in several aspects:
>
>   1) Who is 'we'? You, me, someone else? None of us does anything of the
>      above.
>
>         https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
>
>   2) What has task_blocked_on_lock() to do with the logic in
>      rt_mutex_adjust_prio_chain() which is called by other callsites
>      too?
>
>   3) If the owner releases the lock and deboosts then this has
>      absolutely nothing to do with the lock because the priority of a
>      the owner is determined by its own priority and the priority of the
>      top most waiter. If the owner releases the lock then it marks the
>      lock ownerless, wakes the top most waiter and deboosts itself. In
>      this owner deboost rt_mutex_adjust_prio_chain() is not involved at
>      all. Why?
>
>      Because the owner deboost does not affect the priority of the
>      waiters at all. It's the other way round: Waiter priority affects
>      the owner priority if the waiter priority is higher than the owner
>      priority.
>
> > rt_mutex_adjust_prio_chain() acquires the wait_lock. In the requeue
> > phase, waiter may be initially in the top of the queue, but after
> > dequeued and requeued it may no longer be true.
>
> That's related to your above argumentation in which way?
>

I think I made the mistake of not explicitly saying at least three
tasks are involved:

- A Task T1 that currently holds the mutex
- A Task T2 that is the top waiter
- A Task T3 that changes the top waiter

T3 tries to acquire the mutex, but as T1 holds it, it calls
task_blocked_on_lock() and saves the owner. It eventually calls
rt_mutex_adjust_prio_chain(), but it releases the wait lock before
doing so. This opens a window for T1 to release the mutex and wake up
T2. Before T2 runs, T3 acquires the wait lock again inside
rt_mutex_adjust_prio_chain(). If the "dequeue/requeue" piece of code
changes the top waiter, then 1) When T2 runs, it will verify that it
is no longer the top waiter and comes back to sleep 2) As you observed
below, the waiter doesn't point to the top waiter and, therefore, it
will wake up the wrong task.


> rt_mutex_adjust_prio_chain()
>
>         lock->wait_lock is held across the whole operation
>
>         prerequeue_top_waiter = rt_mutex_top_waiter(lock);
>
>   This saves the current top waiter before the dequeue()/enqueue()
>   sequence.
>
>         rt_mutex_dequeue(lock, waiter);
>         waiter_update_prio(waiter, task);
>         rt_mutex_enqueue(lock, waiter);
>
>         if (!rt_mutex_owner(lock)) {
>
>   This is the case where the lock has no owner, i.e. the previous owner
>   unlocked and the chainwalk cannot be continued.
>
>   Now the code checks whether the requeue changed the top waiter task:
>
>                 if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
>
>   What can make this condition true?
>
>     1) @waiter is the new top waiter due to the requeue operation
>
>     2) @waiter is not longer the top waiter due to the requeue operation
>
>   So in both cases the new top waiter must be woken up so it can take over
>   the ownerless lock.
>
>   Here is where the code is buggy. It only considers case #1, but not
>   case #2, right?
>
> So your patch is correct, but the explanation in your changelog has
> absolutely nothing to do with the problem.
>
> Why?
>
>   #2 is caused by a top waiter dropping out due to a signal or timeout
>      and thereby deboosting the whole lock chain.
>
>   So the relevant callchain which causes the problem originates from
>   remove_waiter()
>
> See?
>

Another piece of information I forgot: I spotted the bug in the
spinlock_rt, which uses a rtmutex under the hood. It has a different
code path in the lock scenario, and there is no call to
remove_waiter() (or I am missing something).
Anyway, you summed it up pretty well here: "@waiter is no longer the
top waiter due to the requeue operation". I tried (and failed) to
explain the call chain that ends up in the buggy scenario, but now I
think I should just describe the fundamental problem (the waiter
doesn't point to the top waiter).

> Thanks,
>
>         tglx
>

