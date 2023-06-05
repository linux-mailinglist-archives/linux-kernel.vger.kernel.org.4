Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F395722490
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjFEL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFEL3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:29:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08CA3DF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:29:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32B1ED75;
        Mon,  5 Jun 2023 04:30:25 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C71C3F587;
        Mon,  5 Jun 2023 04:29:38 -0700 (PDT)
Message-ID: <2d4ead34-3023-aac9-3e1d-97703c7200a0@arm.com>
Date:   Mon, 5 Jun 2023 13:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
 <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
 <48db3f08-a066-c078-bfc9-bf20f66e067a@arm.com>
 <20230531182243.r4d5teuijiadwp2c@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230531182243.r4d5teuijiadwp2c@airbuntu>
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

On 31/05/2023 20:22, Qais Yousef wrote:
> Hi Lukasz!
> 
> Sorry for late response..
> 
> On 05/22/23 09:30, Lukasz Luba wrote:
>> Hi Qais,
>>
>> I have a question regarding the 'soft cpu affinity'.
> 
> [...]
> 
>>> IIUC I'm not seeing this being a problem. The goal of capping with uclamp_max
>>> is two folds:
>>>
>>> 	1. Prevent tasks from consuming energy.
>>> 	2. Keep them away from expensive CPUs.
>>>
>>> 2 is actually very important for 2 reasons:
>>>
>>> 	a. Because of max aggregation - any uncapped tasks that wakes up will
>>> 	   cause a frequency spike on this 'expensive' cpu. We don't have
>>> 	   a mechanism to downmigrate it - which is another thing I'm working
>>> 	   on.
>>> 	b. It is desired to keep these bigger cpu idle ready for more important
>>> 	   work.
>>>
>>> For 2, generally we don't want these tasks to steal bandwidth from these CPUs
>>> that we'd like to preserve for other type of work.
>>
>> I'm a bit afraid about such 'strong force'. That means the task would
>> not go via EAS if we set uclamp_max e.g. 90, while the little capacity
>> is 125. Or am I missing something?
> 
> We should go via EAS, actually that's the whole point.
> 
> Why do you think we won't go via EAS? The logic should be is we give a hint to
> prefer the little core, but we still can pick something else if it's more
> energy efficient.
> 
> What uclamp_max enables us is to still consider that little core even if it's
> utilization says it doesn't fit there. We need to merge these patches first
> though as it's broken at the moment. if little capacity is 125 and utilization
> of the task is 125, then even if uclamp_max is 0, EAS will skip the whole
> little cluster as apotential candidate because there's no spare_capacity there.
> Even if the whole little cluster is idle.

I'm not against letting uclamp_max force fit the placement of p. I'm
just worried that using the EM (especially in it's current state) for
that is wrong and will only work in certain scenarios like the one you
picked.

I did show a counter-example (Juno-r0 [446 1024 1024 446 446 446] with 6
8ms/16ms uclamp_max=440). The issue is that once we have no idle time
left, the decisions of the EM are simply wrong and we shouldn't enforce
those decisions.

There is a related issue. E.g. on Pixel6 with its 4 little CPUs with
cpu_cap_orig = 124. If you admit a task with p->util_avg > cpu_cap_orig
it doesn't even fit onto a CPU. But we then do an energy calculation
taking the values of the whole little PD into consideration. This makes
no sense. The EM is not uclamp_max aware right now.

What about using `sis() -> sic()` for uclamp_max constrained tasks? We
would just have to iterate over the CPUs in cpu_cap_orig order. (1)

Or the EM has to be made uclamp_max aware. (2)

Your example is the idle system with 1 task p waking up. This task has a
util_avg which excludes the little CPUs from being the new task_cpu(p).
But p's uclamp_max value would allow this. But we can't just consider
the placement of 1 task here.

>> This might effectively use more energy for those tasks which can run on
>> any CPU and EAS would figure a good energy placement. I'm worried
>> about this, since we have L3+littles in one DVFS domain and the L3
>> would be only bigger in future.
> 
> It's a bias that will enable the search algorithm in EAS to still consider the
> little core for big tasks. This bias will depend on the uclamp_max value chosen
> by userspace (so they have some control on how hard to cap the task), and what
> else is happening in the system at the time it wakes up.

To teach the EM about such tricky dependencies is IMHO outside the scope
of `how to select a CPU for a uclamp_max constrained task`. (3)

>> IMO to keep the big cpus more in idle, we should give them big energy
>> wake up cost. That's my 3rd feature to the EM presented in OSPM2023.
> 
> Considering the wake up cost in EAS would be a great addition to have :)

I see this one as unrelated to (3) as well.

>>> Of course userspace has control by selecting the right uclamp_max value. They
>>> can increase it to allow a spill to next pd - or keep it low to steer them more
>>> strongly on a specific pd.
>>
>> This would we be interesting to see in practice. I think we need such
>> experiment, for such changes.
> 
> I'm not sure what you mean by 'such changes'. I hope you don't mean these
> patches as they are not the key. They fix an obvious bug where task placement
> hint won't work at all. They don't modify any behavior that shouldn't have
> already been there. Nor introduce new limitation. I have to say I am
> disappointed that these patches aren't considered an important fix for an
> obvious breakage.

To me it's a dead-end to go this way. We need to see the full picture
including something like (1) or (2) or patches you have mentioned, like
the `down-migration in load-balance` thing.

Maybe we can at least list all the use cases for uclamp_max capping here:

It was mentioned:

(A) `soft affinity for tasks w/ util_avg > uclamp_max`.

Are there more?
