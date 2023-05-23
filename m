Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559C270DF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbjEWOjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjEWOjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:39:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 037E5FA;
        Tue, 23 May 2023 07:39:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B54E2139F;
        Tue, 23 May 2023 07:40:14 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 722CD3F840;
        Tue, 23 May 2023 07:39:28 -0700 (PDT)
Message-ID: <79127e9c-8583-8356-a9db-b9af74b6a1b0@arm.com>
Date:   Tue, 23 May 2023 16:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sched/documentation: elaborate on uclamp limitations
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20230505152440.142265-1-hongyan.xia2@arm.com>
 <20230518113000.pvboekaba7vspjyn@airbuntu>
 <8035fedb-820b-2a98-a1af-3a4a8971bcd1@arm.com>
 <CAKfTPtAmV-0+2D5d8-CyQcowaFhWCB=C5xEUoEb0g1ObpmdegQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtAmV-0+2D5d8-CyQcowaFhWCB=C5xEUoEb0g1ObpmdegQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 11:23, Vincent Guittot wrote:
> On Thu, 18 May 2023 at 14:42, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>
>> Hi Qais,
>>
>> On 2023-05-18 12:30, Qais Yousef wrote:
>>> Please CC sched maintainers (Ingo + Peter) next time as they should pick this
>>> up ultimately and they won't see it from the list only.
>>
>> Will do. I was using the get_maintainers script and I thought that gave
>> me all the CCs.
>>
>>> On 05/05/23 16:24, Hongyan Xia wrote:

[...]

>>>> diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/scheduler/sched-util-clamp.rst
>>>> index 74d5b7c6431d..524df07bceba 100644
>>>> --- a/Documentation/scheduler/sched-util-clamp.rst
>>>> +++ b/Documentation/scheduler/sched-util-clamp.rst
>>>> @@ -669,6 +669,19 @@ but not proportional to Fmax/Fmin.
>>>>
>>>>           p0->util_avg = 300 + small_error
>>>>
>>>> +The reason why util_avg is around 300 even though it runs for 900 at Fmin is:
> 
> What does it mean running for 900 at Fmin ? util_avg is a ratio in the
> range [0:1024] without time unit
> 
>>>> +Although running at Fmin reduces the rate of rq_clock_pelt() to 1/3 thus
>>>> +accumulates util_sum at 1/3 of the rate at Fmax, the clock period
>>>> +(rq_clock_pelt() now minus previous rq_clock_pelt()) in:
>>>> +
>>>> +::
>>>> +
>>>> +        util_sum / clock period = util_avg
> 
> I don't get the meaning of the formula above ? There is no "clock
> period" (although I'm not sure what it means here) involved when
> computing util_avg

I also didn't get this one. IMHO. the relation between util_avg and
util_sum is `divider  = LOAD_AVG_MAX - 1024 + avg->period_contrib`. But
I can't see how this matters here.

The crucial point here is IMHO as long we have idle time (p->util_avg <
CPU (current) capacity) the util_avg will not raise to 1024 since at
wakeup util_avg will be only decayed (since the task was sleeping, i.e.
!!se->on_rq = 0). And we are scale invariant thanks to the functionality
in update_rq_clock_pelt() (which is executed when p is running).

The pelt clock update at this moment (wakeup) is setting clock_pelt to
clock_task since rq->curr is the idle task but IMHO that is not the
reason why p->util_avg behaves like this.

The moment `p->util_avg >= CPU (current) capacity` there is no idle time
left, i.e. no such `only decay` updates happens for p anymore (only
`accrue/decay` updates in tick) and the result is that p->util_avg goes
1024.

> Also, there is no linear relation between util_avg and Fmin/Fmax
> ratio. Fmin/Fmax ratio is meaningful in regards to the ratio between
> running time and period time of a periodic task. I understand the
> reference of pelt in this document as a quite simplified description
> of PELT so I'm not sure that adding a partial explanation will help.
> It will probably cause more confusion to people. The only thing that
> is sure, is that PELT expects some idle time to stay fully invariant
> for periodic task

+1 ... we have to be able to understand the code. BTW, schedutil.rst has
also paragraphs about PELT and `Frequency / CPU Invariance` and also
refers to kernel/sched/pelt.h:update_rq_clock_pelt() for details.

[...]
