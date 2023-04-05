Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660936D7A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbjDEKvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjDEKu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:50:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49D0255A4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:50:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CF03175A;
        Wed,  5 Apr 2023 03:51:36 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AE113F73F;
        Wed,  5 Apr 2023 03:50:50 -0700 (PDT)
Message-ID: <0da58608-2958-fc6c-effb-2f73013c609f@arm.com>
Date:   Wed, 5 Apr 2023 12:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 1/6] sched/fair: Add util_guest for tasks
Content-Language: en-US
To:     David Dai <davidai@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20230330224348.1006691-1-davidai@google.com>
 <20230330224348.1006691-2-davidai@google.com>
 <e3aa7e66-27d0-034b-7bdf-f4fab1c2df25@arm.com>
 <CABN1KC+E5tdCBTDu8x_mNzk6L0=Yu8DfpyV-9rMddiRigOFrCQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CABN1KC+E5tdCBTDu8x_mNzk6L0=Yu8DfpyV-9rMddiRigOFrCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 03:11, David Dai wrote:
> On Mon, Apr 3, 2023 at 4:40 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> Hi David,
> Hi Dietmar, thanks for your comments.
>>
>> On 31/03/2023 00:43, David Dai wrote:

[...]

>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 6986ea31c984..998649554344 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -4276,14 +4276,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
>>>
>>>  static inline unsigned long task_util(struct task_struct *p)
>>>  {
>>> -     return READ_ONCE(p->se.avg.util_avg);
>>> +     return max(READ_ONCE(p->se.avg.util_avg),
>>> +                     READ_ONCE(p->se.avg.util_guest));
>>>  }
>>>
>>>  static inline unsigned long _task_util_est(struct task_struct *p)
>>>  {
>>>       struct util_est ue = READ_ONCE(p->se.avg.util_est);
>>>
>>> -     return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
>>> +     return max_t(unsigned long, READ_ONCE(p->se.avg.util_guest),
>>> +                     max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED)));
>>>  }
>>
>> I can't see why the existing p->uclamp_req[UCLAMP_MIN].value can't be
>> used here instead p->se.avg.util_guest.
> Using p->uclamp_req[UCLAMP_MIN].value would result in folding in
> uclamp values into task_util and task_util_est for all tasks that have
> uclamp values set. The intent of these patches isn’t to modify
> existing uclamp behaviour. Users would also override util values from
> the guest when they set uclamp values.
>>
>> I do understand the issue of inheriting uclamp values at fork but don't
>> get the not being `additive` thing. We are at task level here.

> Uclamp values are max aggregated with other tasks at the runqueue
> level when deciding CPU frequency. For example, a vCPU runqueue may
> have an util of 512 that results in setting 512 to uclamp_min on the
> vCPU task. This is insufficient to drive a frequency response if it
> shares the runqueue with another host task running with util of 512 as
> it would result in a clamped util value of 512 at the runqueue(Ex. If
> a guest thread had just migrated onto this vCPU).

OK, see your point now. You want an accurate per-task boost for this
vCPU task on the host run-queue.
And a scenario in which a vCPU can ask for 100% in these moments is not
sufficient I guess? In this case uclamp_min could work.

>> The fact that you have to max util_avg and util_est directly in
>> task_util() and _task_util_est() tells me that there are places where
>> this helps and uclamp_task_util() is not called there.
> Can you clarify on this point a bit more?

Sorry, I meant s/util_est/util_guest/.

The effect of the change in _task_util_est() you see via:

enqueue_task_fair()
  util_est_enqueue()
    cfs_rq->avg.util_est.enqueued += _task_util_est(p)

so that `sugov_get_util() -> cpu_util_cfs() ->
cfs_rq->avg.util_est.enqueued` can see the effect of util_guest?

Not sure about the change in task_util() yet.

>> When you say in the cover letter that you tried uclamp_min, how exactly
>> did you use it? Did you run the existing mainline or did you use
>> uclamp_min as a replacement for util_guest in this patch here?

> I called sched_setattr_nocheck() with .sched_flags =
> SCHED_FLAG_UTIL_CLAMP when updating uclamp_min and clamp_max is left
> at 1024. Uclamp_min was not aggregated with task_util and
> task_util_est during my testing. The only caveat there is that I added
> a change to only reset uclamp on fork when testing(I realize there is
> specifically a SCHED_FLAG_RESET_ON_FORK, but I didn’t want to reset
> other sched attributes).

OK, understood. It's essentially a util_est v2 for vCPU tasks on host.

>>>  static inline unsigned long task_util_est(struct task_struct *p)
>>> @@ -6242,6 +6244,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>        */
>>>       util_est_enqueue(&rq->cfs, p);
>>>
>>> +     /*
>>> +      * The normal code path for host thread enqueue doesn't take into
>>> +      * account guest task migrations when updating cpufreq util.
>>> +      * So, always update the cpufreq when a vCPU thread has a
>>> +      * non-zero util_guest value.
>>> +      */
>>> +     if (READ_ONCE(p->se.avg.util_guest))
>>> +             cpufreq_update_util(rq, 0);
>>
>>
>> This is because enqueue_entity() -> update_load_avg() ->
>> attach_entity_load_avg() -> cfs_rq_util_change() requires root run-queue
>> (&rq->cfs == cfs_rq) to call cpufreq_update_util()?
> The enqueue_entity() would not call into update_load_avg() due to the
> check for !se->avg.last_update_time. se->avg.last_update_time is
> non-zero because the vCPU task did not migrate before this enqueue.
> This enqueue path is reached when util_guest is updated for the vCPU
> task through the sched_setattr_nocheck call where we want to ensure a
> frequency update occurs.

OK, vCPU tasks are pinned so always !WF_MIGRATED wakeup I guess?
