Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF65E5652
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIUWl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiIUWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:41:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F2A8A2613
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:41:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A64D5143D;
        Wed, 21 Sep 2022 15:41:59 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A9D23F73B;
        Wed, 21 Sep 2022 15:41:49 -0700 (PDT)
Message-ID: <04c65f4f-5072-2a07-cbe0-63046a7bc58f@arm.com>
Date:   Thu, 22 Sep 2022 00:41:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/8] sched/fair: Take into account latency priority at
 wakeup
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-6-vincent.guittot@linaro.org>
 <073938c4-ab23-2270-8e60-291f2901e230@arm.com>
 <CAKfTPtCWE5O4TeTBG8hgar8w56-WzvmX7aR9D7dXN_vJ5LCLyQ@mail.gmail.com>
 <b02452b2-900c-89da-c7b7-40a61268065e@arm.com>
 <CAKfTPtDvWsq8YUEzK=xm+S22p=f1kR87a4hT38Ni_t4ZfZ0Zag@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtDvWsq8YUEzK=xm+S22p=f1kR87a4hT38Ni_t4ZfZ0Zag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 17:49, Vincent Guittot wrote:
> On Tue, 20 Sept 2022 at 15:18, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 19/09/2022 17:39, Vincent Guittot wrote:
>>> On Mon, 19 Sept 2022 at 12:05, Dietmar Eggemann
>>> <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 16/09/2022 10:03, Vincent Guittot wrote:

[...]

>>>>> +      * the idle thread and don't set next buddy as a candidate for being
>>>>> +      * picked in priority.
>>>>> +      * In case of simultaneous wakeup from idle, the latency sensitive tasks
>>>>> +      * lost opportunity to preempt non sensitive tasks which woke up
>>>>> +      * simultaneously.
>>>>> +      */
>>>>
>>>> The position of this comment block within this function is somehow
>>>> misleading since it describes the reason for the function rather then a
>>>> particular condition within this function. Wouldn't it be more readable
>>>> when it would be a function header comment instead?
>>>
>>> I put it after the usual early return tests to put the comment close
>>> to the useful part: the use of next buddy and __pick_first_entity()
>>
>> So you want to have the `wakeup_preempt_entity(se, pse) == 1` condition
>> from check_preempt_wakeup() also for cfs_task woken up by others.
> 
> I wake the wakeup_preempt_entity(cfs_rq->next, left) < 1 in
> pick_next_entity() to pick the task with highest latency constraint
> when another class is running while waking up

That's correct. This is where you potentially pick this task since it is
the next_buddy.
All I wanted to say is that check_preempt_from_others() and its `next &&
wakeup_preempt_entity(next, se) == 1` is the counterpart of the
`wakeup_preempt_entity(se, pse) == 1` in check_preempt_wakeup() to be
able to set next_buddy even curr is from an other class than CFS.

[...]

>>>> I still don't get the rationale behind why when either one (se or curr)
>>>> of the latency_nice values is negative, we use the diff between them but
>>>> if not, we only care about se's value. Why don't you always use the diff
>>>> between se and curr? Since we have a range [-20 ... 19] why shouldn't we
>>>> use the difference between let's say se = 19 and curr = 5?
>>>> You discussed this with Tao Zhou on the v1 but I didn't understand it fully.
>>>
>>> Let say that current has a latency nice prio of 19 and a task A with a
>>> latency nice of 10 wakes up. Both tasks don't care about scheduling
>>> latency (current more than task A). If we use the diff, the output of
>>> wakeup_latency_gran() would be negative (-10ms) which reflects the
>>> fact that the waking task is sensitive to the latency and wants to
>>> preempt current even if its vruntime is after. But obviously both
>>> current and task A don't care to preempt at wakeup.
>>
>> OK, I understand but there is a certain level of unsteadiness here.
>>
>> If p has >0 it gets treated differently in case current has >=0 and case
> 
> "If p >=0"; 0 has same behavior than [1..19]
> 
>> current has <0.

Not quite. It depends on curr. With sysctl_sched_latency = 24ms:

(1) p = 10 curr =  19 -> wakeup_latency_gran() returns 12ms

(2) p = 10 curr = -10 -> wakeup_latency_gran() returns 24ms

In (1) only p's own latency counts whereas in (2) we take the diff,

In (A) we 'punish' p even though it competes against curr which has an
even lower latency requirement than p,

>> Do we expect that tasks set their value to [1..19] in this case, when
>> the default 0 already indicates a 'don't care'?
> 
> I'm not sure that I understand your concern as [0..19] are treated in
> the same way. Only tasks (curr or se) with offset <0 need a relative
> comparison to the other. If curr and se has both a latency nice of
> -19, se should not blindly preempt curr but only if curr already run
> for its amount of time

With p = -19 and curr = -19 we would take the diff, so 0ms.

With p = 19 and curr = 19, if we would use `latency_offset -=
curr->latency_offset` wakeup_latency_gran() would return 973/1024*24ms -
973/1024*24ms = 0ms and nothing will shift.

OTHA, in case (1) wakeup_latency_gran() would return 512/1024*24ms -
973/1024*24ms = - 10.80ms. So p would gain an advantage here instead of
a penalty.

Essentially using the full [-20 .. 19] nice scope for `se vs. curr`
comparison.
