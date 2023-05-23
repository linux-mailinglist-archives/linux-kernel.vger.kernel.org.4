Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F0370E363
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbjEWRaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbjEWRaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:30:17 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC2CA;
        Tue, 23 May 2023 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684863008;
        bh=yJD3V+XKnuW7qcW9kbIcITyLh2Ag4ia05ODFERJV1PQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QZ5cUxpkb5fkT0Ee+/2qZd+avvLRM5YcnyH7aM5T9zugt7GpkMFe9b6g39fWCPOQh
         If3LDG3c8Cvb33UcQSC1vq411FQ1X/pDsuJOBkjJLecM4ag/TU5mYhCcUnpRx4zsYf
         QNnMdc/fvmHwUbmca3TA6gOYIQOwPJ+3h5o4cq7IR3KpYnIv2RBMb5nOYEOUVL0ztm
         dQlAgoMegAxP2gZS+leCl9XUQ3BY74IqDsOT3JuwJh1N/MyGqJeipDSQRXzFuT738c
         j861cpVKrbrZbocHKJwppQPSEFnRAG3L24dgzcKZkPXV7l5noP8sXLvNiLcuRv1huV
         c8MjGxdQ41O/w==
Received: from [172.16.0.117] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QQhCg5qqkz13TT;
        Tue, 23 May 2023 13:30:07 -0400 (EDT)
Message-ID: <21f3d5e4-44ba-65de-5180-f059c145deef@efficios.com>
Date:   Tue, 23 May 2023 13:30:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/4] rseq: Add sched_state field to struct rseq
Content-Language: en-US
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Weimer <fweimer@redhat.com>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
 <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
 <CAFUsyfJ49mE+7p1ywEHetRHqr=DWY7aiFYzfva9Mtqp3_XYncg@mail.gmail.com>
 <cdac8821-a298-aced-8084-8da3ba64a1be@efficios.com>
 <CAFUsyf+L6JF=pZ6QstQhdGGPVM7e7ML2a5LEbzmP6sTs3cwJng@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAFUsyf+L6JF=pZ6QstQhdGGPVM7e7ML2a5LEbzmP6sTs3cwJng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-23 12:32, Noah Goldstein wrote:
> On Tue, May 23, 2023 at 7:49 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2023-05-19 16:51, Noah Goldstein wrote:
>>> On Wed, May 17, 2023 at 10:28 AM Mathieu Desnoyers via Libc-alpha
>>> <libc-alpha@sourceware.org> wrote:
>>>>
>>>> Expose the "on-cpu" state for each thread through struct rseq to allow
>>>> adaptative mutexes to decide more accurately between busy-waiting and
>>>> calling sys_futex() to release the CPU, based on the on-cpu state of the
>>>> mutex owner.
>>>>
>>>> It is only provided as an optimization hint, because there is no
>>>> guarantee that the page containing this field is in the page cache, and
>>>> therefore the scheduler may very well fail to clear the on-cpu state on
>>>> preemption. This is expected to be rare though, and is resolved as soon
>>>> as the task returns to user-space.
>>>>
>>>> The goal is to improve use-cases where the duration of the critical
>>>> sections for a given lock follows a multi-modal distribution, preventing
>>>> statistical guesses from doing a good job at choosing between busy-wait
>>>> and futex wait behavior.
>>>>
>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
>>>> Cc: Carlos O'Donell <carlos@redhat.com>
>>>> Cc: Florian Weimer <fweimer@redhat.com>
>>>> Cc: libc-alpha@sourceware.org
>>>> ---
>>>>    include/linux/sched.h     | 12 ++++++++++++
>>>>    include/uapi/linux/rseq.h | 17 +++++++++++++++++
>>>>    kernel/rseq.c             | 14 ++++++++++++++
>>>>    3 files changed, 43 insertions(+)
>>>>
>>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>>> index eed5d65b8d1f..c7e9248134c1 100644
>>>> --- a/include/linux/sched.h
>>>> +++ b/include/linux/sched.h
>>>> @@ -2351,11 +2351,20 @@ static inline void rseq_signal_deliver(struct ksignal *ksig,
>>>>           rseq_handle_notify_resume(ksig, regs);
>>>>    }
>>>>
>>>> +void __rseq_set_sched_state(struct task_struct *t, unsigned int state);
>>>> +
>>>> +static inline void rseq_set_sched_state(struct task_struct *t, unsigned int state)
>>>> +{
>>>> +       if (t->rseq)
>>>> +               __rseq_set_sched_state(t, state);
>>>> +}
>>>> +
>>>>    /* rseq_preempt() requires preemption to be disabled. */
>>>>    static inline void rseq_preempt(struct task_struct *t)
>>>>    {
>>>>           __set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
>>>>           rseq_set_notify_resume(t);
>>>> +       rseq_set_sched_state(t, 0);
>>>
>>> Should rseq_migrate also be made to update the cpu_id of the new core?
>>> I imagine the usage of this will be something along the lines of:
>>>
>>> if(!on_cpu(mutex->owner_rseq_struct) &&
>>>      cpu(mutex->owner_rseq_struct) == this_threads_cpu)
>>>      // goto futex
>>>
>>> So I would think updating on migrate would be useful as well.
>>
>> I don't think we want to act differently based on the cpu on which the
>> owner is queued.
>>
>> If the mutex owner is not on-cpu, and queued on the same cpu as the
>> current thread, we indeed want to call sys_futex WAIT.
>>
>> If the mutex owner is not on-cpu, but queued on a different cpu than the
>> current thread, we *still* want to call sys_futex WAIT, because
>> busy-waiting for a thread which is queued but not currently running is
>> wasteful.
>>
> I think this is less clear. In some cases sure but not always. Going
> to the futex
> has more latency that userland waits, and if the system is not busy (other than
> the one process) most likely less latency that yield. Also going to the futex
> requires a syscall on unlock.
> 
> For example if the critical section is expected to be very small, it
> would be easy
> to imagine the lock be better implemented with:
> while(is_locked)
>    if (owner->on_cpu || owner->cpu != my_cpu)
>      exponential backoff
>    else
>      yield
> 
> Its not that "just go to futex" doesn't ever make sense, but I don't
> think its fair
> to say that *always* the case.
> 
> Looking at the kernel code, it doesn't seem to be a particularly high cost to
> keep the CPU field updated during migration so seems like a why not
> kind of question.

We already have the owner rseq_abi cpu_id field populated on every 
return-to-userspace. I wonder if it's really relevant that migration 
populates an updated value in this field immediately ? It's another case 
where this would be provided as a hint updated only if the struct rseq 
is in the page cache, because AFAIU the scheduler migration path cannot 
take a page fault.

Also, if a thread bounces around many runqueues before being scheduled 
again, we would be adding those useless stores to the rseq_abi structure 
at each migration between runqueues.

Given this would add some complexity to the scheduler migration code, I 
would want to see metrics/benchmarks showing that it indeed improves 
real-world use-cases before adding this to the rseq ABI.

It's not only a question of added lines of code as of today, but also a 
question of added userspace ABI guarantees which can prevent future 
scheduler optimizations. I'm *very* careful about keeping those to a 
strict minimum, which I hope Peter Zijlstra appreciates.

Thanks,

Mathieu


>> Or am I missing something ?
>>
>> Thanks,
>>
>> Mathieu
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

