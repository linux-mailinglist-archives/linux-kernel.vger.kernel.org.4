Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62F05E68CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiIVQub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiIVQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:50:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD7C0B5A5E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:50:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DC9416F8;
        Thu, 22 Sep 2022 09:50:33 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD58A3F5A1;
        Thu, 22 Sep 2022 09:50:23 -0700 (PDT)
Message-ID: <0a437c9e-299d-574e-a393-f589c78ba2c7@arm.com>
Date:   Thu, 22 Sep 2022 18:50:00 +0200
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
 <04c65f4f-5072-2a07-cbe0-63046a7bc58f@arm.com>
 <CAKfTPtA1UFRGsDRVRNn_M2OEQ2G8A5MzWP_3GpmSsf1=B9+DdA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtA1UFRGsDRVRNn_M2OEQ2G8A5MzWP_3GpmSsf1=B9+DdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 09:12, Vincent Guittot wrote:
> On Thu, 22 Sept 2022 at 00:41, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 20/09/2022 17:49, Vincent Guittot wrote:
>>> On Tue, 20 Sept 2022 at 15:18, Dietmar Eggemann
>>> <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 19/09/2022 17:39, Vincent Guittot wrote:
>>>>> On Mon, 19 Sept 2022 at 12:05, Dietmar Eggemann
>>>>> <dietmar.eggemann@arm.com> wrote:
>>>>>>
>>>>>> On 16/09/2022 10:03, Vincent Guittot wrote:

[...]

> I thought you were speaking about priority 0 vs [1..19] as you made a
> difference in your previous comment below
> 
>>
>> (1) p = 10 curr =  19 -> wakeup_latency_gran() returns 12ms
>>
>> (2) p = 10 curr = -10 -> wakeup_latency_gran() returns 24ms
>>
>> In (1) only p's own latency counts whereas in (2) we take the diff,
> 
> Yes because  curr is latency sensitive in (2) whereas it's not in (1)
> 
>>
>> In (A) we 'punish' p even though it competes against curr which has an
>> even lower latency requirement than p,
> 
> What is (A) ?  Assuming you meant (1), having a positive nice latency

Sorry, yes I meant (1).

> means that you don't have latency requirement but you are tolerant to
> scheduling delay so we don't 'punish' p. P will preempt curr is we are
> above the tolerance

wakeup_preempt_entity() {

    vdiff = curr->vruntime - se->vruntime

    vdiff -= wakeup_latency_gran(curr, se)   <-- (3)

    if (vdiff <= 0)
        return -1;

    ...
}

Wouldn't it be more suitable to return 0 from wakeup_latency_gran() if
both have latency_nice >=0 in this case instead of se->latency_offset?

By `punish` I mean that vdiff (3) gets smaller in case we return (the
positive) `se->latency_offset` even `latency nice of curr` > `latency
nice of p`.

[...]

>> With p = -19 and curr = -19 we would take the diff, so 0ms.
>>
>> With p = 19 and curr = 19, if we would use `latency_offset -=
>> curr->latency_offset` wakeup_latency_gran() would return 973/1024*24ms -
>> 973/1024*24ms = 0ms and nothing will shift.
>>
>> OTHA, in case (1) wakeup_latency_gran() would return 512/1024*24ms -
>> 973/1024*24ms = - 10.80ms. So p would gain an advantage here instead of
>> a penalty.
> 
> And that's all the point. A priority >= 0 means that you don't care
> about scheduling delays so there is no reason to be more aggressive
> with a task that is also latency tolerant. We only have to ensure that
> the delay stays in the acceptable range

OK, I understand you model here but I'm still not convinced. Might be
interesting to hear what others think.
