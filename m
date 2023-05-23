Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2747A70DCF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbjEWMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjEWMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:49:28 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A0DDD;
        Tue, 23 May 2023 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684846164;
        bh=kqceX5raYeRpBbahySDfiWhprDVkugQ30VzTL3JtJHI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=maaFn5bqaA9UiQCHRR3RVWDL86mZEIb1Gre8vZHAOY099bOQrRyXY4bZSVhOnH7Yw
         58OwEQD0tJ8XfJyhs5IxKsh/NAedwlDvtqWR6RqzkulFy4VWC4/V0zF4BpPDYYjL/s
         i9KSqJppSVm3vbgfF6Is+EZidbAGIhDYloH+r+WyyqcSt++QgNRaZQf7jJNoQomCvf
         pnbuaIYavya2q81VyJpQsktj74bZYQSZcAyPdP2zw7my13xKJNwZCsD39KTg+6zUTo
         oopFQfPwEQMSe9+eMZNLU3WEoyjB+i/khEe47uut/AioWohRpDP5f0YtcnwGMeP6D/
         HL7HTI0FCXdAQ==
Received: from [172.16.0.117] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QQYzl3zpSz13Kp;
        Tue, 23 May 2023 08:49:23 -0400 (EDT)
Message-ID: <cdac8821-a298-aced-8084-8da3ba64a1be@efficios.com>
Date:   Tue, 23 May 2023 08:49:33 -0400
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAFUsyfJ49mE+7p1ywEHetRHqr=DWY7aiFYzfva9Mtqp3_XYncg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-19 16:51, Noah Goldstein wrote:
> On Wed, May 17, 2023 at 10:28 AM Mathieu Desnoyers via Libc-alpha
> <libc-alpha@sourceware.org> wrote:
>>
>> Expose the "on-cpu" state for each thread through struct rseq to allow
>> adaptative mutexes to decide more accurately between busy-waiting and
>> calling sys_futex() to release the CPU, based on the on-cpu state of the
>> mutex owner.
>>
>> It is only provided as an optimization hint, because there is no
>> guarantee that the page containing this field is in the page cache, and
>> therefore the scheduler may very well fail to clear the on-cpu state on
>> preemption. This is expected to be rare though, and is resolved as soon
>> as the task returns to user-space.
>>
>> The goal is to improve use-cases where the duration of the critical
>> sections for a given lock follows a multi-modal distribution, preventing
>> statistical guesses from doing a good job at choosing between busy-wait
>> and futex wait behavior.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
>> Cc: Carlos O'Donell <carlos@redhat.com>
>> Cc: Florian Weimer <fweimer@redhat.com>
>> Cc: libc-alpha@sourceware.org
>> ---
>>   include/linux/sched.h     | 12 ++++++++++++
>>   include/uapi/linux/rseq.h | 17 +++++++++++++++++
>>   kernel/rseq.c             | 14 ++++++++++++++
>>   3 files changed, 43 insertions(+)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index eed5d65b8d1f..c7e9248134c1 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -2351,11 +2351,20 @@ static inline void rseq_signal_deliver(struct ksignal *ksig,
>>          rseq_handle_notify_resume(ksig, regs);
>>   }
>>
>> +void __rseq_set_sched_state(struct task_struct *t, unsigned int state);
>> +
>> +static inline void rseq_set_sched_state(struct task_struct *t, unsigned int state)
>> +{
>> +       if (t->rseq)
>> +               __rseq_set_sched_state(t, state);
>> +}
>> +
>>   /* rseq_preempt() requires preemption to be disabled. */
>>   static inline void rseq_preempt(struct task_struct *t)
>>   {
>>          __set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
>>          rseq_set_notify_resume(t);
>> +       rseq_set_sched_state(t, 0);
> 
> Should rseq_migrate also be made to update the cpu_id of the new core?
> I imagine the usage of this will be something along the lines of:
> 
> if(!on_cpu(mutex->owner_rseq_struct) &&
>     cpu(mutex->owner_rseq_struct) == this_threads_cpu)
>     // goto futex
> 
> So I would think updating on migrate would be useful as well.

I don't think we want to act differently based on the cpu on which the 
owner is queued.

If the mutex owner is not on-cpu, and queued on the same cpu as the 
current thread, we indeed want to call sys_futex WAIT.

If the mutex owner is not on-cpu, but queued on a different cpu than the 
current thread, we *still* want to call sys_futex WAIT, because 
busy-waiting for a thread which is queued but not currently running is 
wasteful.

Or am I missing something ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

