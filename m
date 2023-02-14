Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0645D6963D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjBNMr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjBNMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:47:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B8DD24C8F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:47:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA5E11042;
        Tue, 14 Feb 2023 04:48:21 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D30A3F881;
        Tue, 14 Feb 2023 04:47:37 -0800 (PST)
Message-ID: <d7b319cc-5c02-df0f-44d5-cd3aa2bd2474@arm.com>
Date:   Tue, 14 Feb 2023 13:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/3] sched/uclamp: Ignore (util == 0) optimization in
 feec() when p_util_max = 0
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-3-qyousef@layalina.io>
 <CAKfTPtCf4+orEhYmFBg+tsMH7e5sV5zJZ1k8apjZkYwSAxAu+w@mail.gmail.com>
 <d7f29def-7004-b62d-9266-3ad997111e2f@arm.com>
 <20230211180119.4mbfn7j3skvoasop@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230211180119.4mbfn7j3skvoasop@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 19:01, Qais Yousef wrote:
> On 02/08/23 12:52, Dietmar Eggemann wrote:
>> On 07/02/2023 11:04, Vincent Guittot wrote:
>>> On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
>>>>
>>>> find_energy_efficient_cpu() bails out early if effective util of the
>>>> task is 0. When uclamp is being used, this could lead to wrong decisions
>>>> when uclamp_max is set to 0. Cater for that.
>>
>> IMHO this needs a little bit more explanation. Someone could argue that
>> 'util > 0, uclamp_min=0, uclamp_max=0' is a valid setup for a task which
>> should let it appear as a task with 0 util (capped to 0).
> 
> You want me to explain the purpose of the optimization then?
> 
> The optimization skips energy calculation when util is 0 because the delta will
> be 0. But when uclamp_max = 0 util is not really 0 - consequently  the delta

I would say:

s/really/necessarily
s/delta/energy delta

> will not be 0.
> 
> Would such an explanation clarify things better?

Yes. It key to understand that there is a 2-step process. First,
admittance to a possible target (util and uclamp) and second, energy
diff based target-selection (util).

>>>> Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
>>>> Signed-off-by: Qais Yousef <qyousef@layalina.io>
>>>> ---
>>>>  kernel/sched/fair.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 7a21ee74139f..a8c3d92ff3f6 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -7374,7 +7374,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>>>         target = prev_cpu;
>>>>
>>>>         sync_entity_load_avg(&p->se);
>>>> -       if (!uclamp_task_util(p, p_util_min, p_util_max))
>>>> +       if (!uclamp_task_util(p, p_util_min, p_util_max) && p_util_max != 0)
>>>
>>> The below should do the same without testing twice p_util_max:
>>> uclamp_task_util(p, p_util_min, ULONG_MAX)
>>
>> Since uclamp_task_util() is only used here and we don't want to test for
>> capping to 0 anymore, why not just get rid of this function and use:
>>
>>   !(task_util_est(p) || p_util_min)
> 
> That would be better, yes!
> 
> Question for you and Vincent. Do we really want this optimization? I started
> with removing it - then erred on the conservative side and kept it.

Hard to say ... at least we know that util=0 will have absolutely no
effect on task placement. So we can spare the heavy EAS algorithm in
this case for sure.

> I don't know how often we hit this case and I didn't see any benchmark run to
> be able to verify anything when I looked at the history.

There are very few EAS wakeups with `task_util_est(p) = 0`. Probably not
relevant.

> It seems helpful in theory - but why we save something if we ignore 0 but not
> 1 which I suspect will not produce a significant delta either.

True, it's hard to find the real line of significance here.

> I don't mind keeping it - but I think worth thinking if it is really adding
> much.

I would keep it and just remove uclamp_task_util(). We still have a lot
of uclamp/util related functions, we should try to keep the number as
low as possible. Just checked it, this check has been there from the
beginning of EAS.

