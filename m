Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4663369E036
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjBUMVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjBUMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:21:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EC5F29E3C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:21:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71695FEC;
        Tue, 21 Feb 2023 04:11:27 -0800 (PST)
Received: from [10.57.14.135] (unknown [10.57.14.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1F263F703;
        Tue, 21 Feb 2023 04:10:42 -0800 (PST)
Message-ID: <c61990d8-cdc5-2b70-178d-694c187afd45@arm.com>
Date:   Tue, 21 Feb 2023 12:10:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/3] sched/tp: Add new tracepoint to track compute
 energy computation
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-4-qyousef@layalina.io>
 <d99b1097-1d77-1547-30bf-860756d4952f@arm.com>
 <20230221120832.x642tqohxv5nascr@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230221120832.x642tqohxv5nascr@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/23 12:08, Qais Yousef wrote:
> On 02/20/23 11:22, Lukasz Luba wrote:
>> Hi Qais,
>>
>> On 2/5/23 22:43, Qais Yousef wrote:
>>> It was useful to track feec() placement decision and debug the spare
>>> capacity and optimization issues vs uclamp_max.
>>>
>>> Signed-off-by: Qais Yousef <qyousef@layalina.io>
>>> ---
>>>    include/trace/events/sched.h | 4 ++++
>>>    kernel/sched/core.c          | 1 +
>>>    kernel/sched/fair.c          | 7 ++++++-
>>>    3 files changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
>>> index fbb99a61f714..20cc884f72ff 100644
>>> --- a/include/trace/events/sched.h
>>> +++ b/include/trace/events/sched.h
>>> @@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
>>>    	TP_PROTO(struct rq *rq, int change),
>>>    	TP_ARGS(rq, change));
>>> +DECLARE_TRACE(sched_compute_energy_tp,
>>> +	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy),
>>> +	TP_ARGS(p, dst_cpu, energy));
>>> +
>>>    #endif /* _TRACE_SCHED_H */
>>>    /* This part must be outside protection */
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 4580fe3e1d0c..5f6dde9b892b 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -110,6 +110,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>>>    EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
>>>    EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>>>    EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>>> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>>>    DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index a8c3d92ff3f6..801e903c4307 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -7295,11 +7295,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
>>>    {
>>>    	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
>>>    	unsigned long busy_time = eenv->pd_busy_time;
>>> +	unsigned long energy;
>>>    	if (dst_cpu >= 0)
>>>    		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
>>> -	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
>>> +	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
>>> +
>>> +	trace_sched_compute_energy_tp(p, dst_cpu, energy);
>>
>> Could we also dump the max_util and busy_time?
> 
> We certainly can :)

Great, thanks!

