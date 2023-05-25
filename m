Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728C4710B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjEYL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241108AbjEYL4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:56:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5944710B;
        Thu, 25 May 2023 04:55:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEFEC1042;
        Thu, 25 May 2023 04:56:34 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 609B33F762;
        Thu, 25 May 2023 04:55:47 -0700 (PDT)
Message-ID: <01579005-e5d3-4c53-9331-45324542ca34@arm.com>
Date:   Thu, 25 May 2023 13:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
Content-Language: en-US
To:     Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc:     luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, youssefesmat@google.com
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
 <20230515025716.316888-3-vineeth@bitbyteword.org>
 <f5801f5b-6ee8-6b84-b6bb-46e89b165091@arm.com>
 <CAO7JXPhVcFJ2+8dpw8Ns4xVr622G8puqdcbSjy23THpahJTmUA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAO7JXPhVcFJ2+8dpw8Ns4xVr622G8puqdcbSjy23THpahJTmUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Vineeth,

On 20/05/2023 04:15, Vineeth Remanan Pillai wrote:
> Hi Dietmar,
> 
> On Fri, May 19, 2023 at 1:56 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
> 
>>> TID[730]: RECLAIM=1, (r=8ms, d=10ms, p=10ms), Util: 95.05
>>> TID[731]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 31.34
>>> TID[732]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 3.16
>>
>> What does this 'Util: X' value stand for? I assume it's the utilization
>> of the task? How do you obtain it?
>>
> Yes, it is the utilization of the task. I calculate it by dividing the
> cputime with elapsed time(using clock_gettime(2)).

Makes, sense, I guess what I missed here in the first place is the fact
that those DL tasks want to run 100%.

>> I see that e.g. TID[731] should run 1ms each 10ms w/o grub and with grub
>> the runtime could be potentially longer since 'scaled_delta_exec < delta'.
>>
> Yes correct. GRUB(Greedy Reclamation of Unused Bandwidth) algorithm
> is used here for deadline tasks that needs to run longer than their
> runtime when needed. sched_setattr allows a flag SCHED_FLAG_RECLAIM
> to indicate that the task would like to reclaim unused bandwidth of a
> cpu if available. For those tasks, 'runtime' is depreciated using the
> GRUB formula and it allows it to run for longer and reclaim the free
> bandwidth of the cpu. The GRUB implementation in linux allows a task
> to reclaim upto RT capacity(95%) and depends on the free bandwidth
> of the cpu. So TID[731] theoretically should run for 95ms as it is
> the only task in the cpu, but it doesn't get to run that long.

Correct.

>> I don't get this comment in update_curr_dl():
>>
>> 1325    /*
>> 1326     * For tasks that participate in GRUB, we implement GRUB-PA: the
>> 1327     * spare reclaimed bandwidth is used to clock down frequency.
>> 1328     *
>>
>> It looks like dl_se->runtime is affected and with 'scaled_delta_exec <
>> delta' the task runs longer than dl_se->dl_runtime?
>>
> Yes. As mentioned above, GRUB allows the task to run longer by slowing
> down the depreciation of "dl_se->dl_runtime". scaled_delta_exec is
> calculated by the GRUB formula explained in the paper [1] & [2].

What I didn't understand was this `GRUB-PA` and `the spare reclaimed
bandwidth is used to clock down frequency` in relation to GRUB task
runtime depreciation.

But now I think I get it. `GRUB-PA` means that in case we run with the
schedutil CPUfreq governor, the CPU frequency is influenced by Uact
(rq->dl.running_bw) via:

sugov_get_util() -> effective_cpu_util() -> cpu_bw_dl() ->

      return rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT

and on top of this we do GRUB reclaiming for those SCHED_FLAG_RECLAIM
tasks, i.e. task runtime depreciation.

>> I did the test discussed later in this thread with:
>>
>> 3 [3/100] tasks (dl_se->dl_bw = (3 << 20)/100 = 31457) on 3 CPUs
>>
>> factor = scaled_delta_exec/delta
>>
>> - existing grub
>>
>> rq->dl.bw_ratio = ( 100 << 8 ) / 95 = 269
>> rq->dl.extra_bw = ( 95 << 20 ) / 100 = 996147
>>
>> cpu=2 curr->[thread0-2 1715] delta=2140100 this_bw=31457
>> running_bw=31457 extra_bw=894788 u_inact=0 u_act_min=33054 u_act=153788
>> scaled_delta_exec=313874 factor=0.14
>>
>> - your solution patch [1-2]
>>
>> cpu=2 curr->[thread0-0 1676] delta=157020 running_bw=31457 max_bw=996147
>> res=4958 factor=0.03
>>
>> You say that GRUB calculation is inaccurate and that this inaccuracy
>> gets larger as the bandwidth of tasks becomes smaller.
>>
>> Could you explain this inaccuracy on this example?
>>
> According to GRUB, we should be able to reclaim the unused bandwidth
> for the running task upto RT limits(95%). In this example we have a
> task with 3ms runtime and 100ms runtime on a cpu. So it is supposed
> to run for 95ms before it is throttled.

Correct.

> Existing implementation's factor = 0.14 and 3ms is depreciated by
> this factor. So it gets to run for "3 / 0.14 ~= 22ms". This is the
> inaccuracy that the patch is trying to solve. With the patch, the
> factor is .03166 and runtime = "3 / 0.03166 ~= 95ms"

My tests were wrong since I was using DL task with dl_runtime=3ms and
dl_period = 100ms with an actual runtime=3ms whereas your tasks probably
want to run 100%.

> Hope this clarifies.

yes, it did, thanks!

