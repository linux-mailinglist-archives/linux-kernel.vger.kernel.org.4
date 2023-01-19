Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64866743C6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjASU5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjASUzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:55:40 -0500
Received: from galois.linutronix.de (unknown [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5121523C79
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:54:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674161627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EWtBqF1zcJDZerK6PL/ZNIRR4wUuEq1ydE1wWa2rzqw=;
        b=R84T16LI4E3eWl8eJTaVPXD9BxuZLU7mz2J46TTHXM6IfkQnqBqKKHfqAC4gh+4XVmif4z
        VDUNi3r1/CVqfGPBUYV7n9uBp3i+MDX4JtwSQDqR82Ofa2uXz8fnQ5IRxrmbV2fYYjXvq1
        /m55Bzx/HcjpLPtVOnakIP3e/CxF1Y53V0H6v+qjGbULluBMhYAG4UK5us5chrACggCFVU
        qiUsVqYgyjAKoUX4Y5x4BDfrGapSgw5xK58cyAKXX88LHx6zf219Ix9gDejLR5HUx25Lmr
        GUerpKWHOqQG8hQwY3b7HKmf8n9qVavoKIHRsSi4GtzOANDbTKceWLPXSAjPfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674161627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EWtBqF1zcJDZerK6PL/ZNIRR4wUuEq1ydE1wWa2rzqw=;
        b=3ux97f/C300cfX5uKoHhzWVumpkNZiZ1j/8TrqHEFgeJDaB3kmX4sEXKcn98wWEtFd93Dy
        HuIMRQWP273V2UAA==
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rtmutex: ensure we wake up the top waiter
In-Reply-To: <CAAq0SUkN38V00HqV3Hk3ee_-=vfkKxG9xtR3n=4gAT+zCs+=Zg@mail.gmail.com>
References: <20230117172649.52465-1-wander@redhat.com> <875yd4k8qd.ffs@tglx>
 <CAAq0SUkN38V00HqV3Hk3ee_-=vfkKxG9xtR3n=4gAT+zCs+=Zg@mail.gmail.com>
Date:   Thu, 19 Jan 2023 21:53:46 +0100
Message-ID: <87fsc6i6ud.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wander!

On Wed, Jan 18 2023 at 15:49, Wander Lairson Costa wrote:
> On Tue, Jan 17, 2023 at 9:05 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Tue, Jan 17 2023 at 14:26, Wander Lairson Costa wrote:
>> > rt_mutex_adjust_prio_chain() acquires the wait_lock. In the requeue
>> > phase, waiter may be initially in the top of the queue, but after
>> > dequeued and requeued it may no longer be true.
>>
>> That's related to your above argumentation in which way?
>>
>
> I think I made the mistake of not explicitly saying at least three
> tasks are involved:
>
> - A Task T1 that currently holds the mutex
> - A Task T2 that is the top waiter
> - A Task T3 that changes the top waiter
>
> T3 tries to acquire the mutex, but as T1 holds it, it calls
> task_blocked_on_lock() and saves the owner. It eventually calls
> rt_mutex_adjust_prio_chain(), but it releases the wait lock before
> doing so. This opens a window for T1 to release the mutex and wake up
> T2. Before T2 runs, T3 acquires the wait lock again inside
> rt_mutex_adjust_prio_chain(). If the "dequeue/requeue" piece of code
> changes the top waiter, then 1) When T2 runs, it will verify that it
> is no longer the top waiter and comes back to sleep 2) As you observed
> below, the waiter doesn't point to the top waiter and, therefore, it
> will wake up the wrong task.

This is still confusing as hell because the wait locks you are talking
about belong to different rtmutexes.  So there is no drops wait lock and
reacquires wait lock window.

There must be (multiple) lock chains involved, but I couldn't figure out
yet what the actaul scenario is in the case of a pure rt_spinlock clock
chain:

> Another piece of information I forgot: I spotted the bug in the
> spinlock_rt, which uses a rtmutex under the hood. It has a different
> code path in the lock scenario, and there is no call to
> remove_waiter() (or I am missing something).

Correct. But this still might be a lock chain issue where a non
rt_spinlock which allows early removal.

> Anyway, you summed it up pretty well here: "@waiter is no longer the
> top waiter due to the requeue operation". I tried (and failed) to
> explain the call chain that ends up in the buggy scenario, but now I
> think I should just describe the fundamental problem (the waiter
> doesn't point to the top waiter).

You really want to provide the information WHY this case can happen at
all. If it's not the removal case and related to some other obscure lock
chain problem, then we really need to understand the scenario because
that lets us analyze whether there are other holes we did not think
about yet.

If you have traces which show the sequence of lock events leading to
this problem, then you should be able to decode the scenario. If you
fail to extract the information, then please provide the traces so we
can stare at them.

Thanks,

        tglx
