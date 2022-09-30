Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2EF5F02EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiI3CoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiI3CoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:44:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497E91397F9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 19:44:01 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MdvZt1HNPzWh7j;
        Fri, 30 Sep 2022 10:39:50 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 10:43:58 +0800
Message-ID: <5126b2dc-8624-babc-2e1e-58ac27927c31@huawei.com>
Date:   Fri, 30 Sep 2022 10:43:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] sched/cputime: Fix the time backward issue about
 /proc/stat
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <hucool.lihua@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20220928033402.181530-1-zhengzucheng@huawei.com>
 <YzQB8afi2rCPvuC1@hirez.programming.kicks-ass.net>
 <20220928121134.GA233658@lothringen>
From:   zhengzucheng <zhengzucheng@huawei.com>
In-Reply-To: <20220928121134.GA233658@lothringen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/28 20:11, Frederic Weisbecker 写道:
> On Wed, Sep 28, 2022 at 10:12:33AM +0200, Peter Zijlstra wrote:
>> On Wed, Sep 28, 2022 at 11:34:02AM +0800, Zucheng Zheng wrote:
>>> From: Zheng Zucheng <zhengzucheng@huawei.com>
>>>
>>> The cputime of cpuN read from /proc/stat has an issue of cputime descent.
>>> For example, the phenomenon of cputime descent of user is as followed:
>>>
>>> The value read first is 319, and the value read again is 318. As follows:
>>> first:
>>>   cat /proc/stat |  grep cpu1
>>>   cpu1    319    0    496    41665    0    0    0    0    0    0
>>> again:
>>>   cat /proc/stat |  grep cpu1
>>>   cpu1    318    0    497    41674    0    0    0    0    0    0
>>>
>>> The value read from /proc/stat should be monotonically increasing. Otherwise
>>> user may get incorrect CPU usage.
>>>
>>> The root cause of this problem is that, in the implementation of
>>> kcpustat_cpu_fetch_vtime, vtime->utime + delta is added to the stack variable
>>> cpustat instantaneously. If the task is switched between two times, the value
>>> added to cpustat for the second time may be smaller than that for the first time.
>>>
>>> 				CPU0						CPU1
>>> First:
>>> show_stat()
>>>   ->kcpustat_cpu_fetch()
>>>    ->kcpustat_cpu_fetch_vtime()
>>>     ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu) + vtime->utime + delta       rq->curr is task A
>>>                                                                              A switch to B，and A->vtime->utime is less than 1 tick
>>> Then:
>>> show_stat()
>>>   ->kcpustat_cpu_fetch()
>>>    ->kcpustat_cpu_fetch_vtime()
>>>     ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu) + vtime->utime + delta;     rq->curr is task B
>> You're still not explaining where the time gets lost. And the patch is a
>> horrible band-aid.
>>
>> What I think you're saying; after staring at this for a while, is that:
>>
>>    vtime_task_switch_generic()
>>      __vtime_account_kernel(prev, vtime)
>>        vtime_account_{guest,system}(tsk, vtime)
>>          vtime->*time += get_vtime_delta()
>> 	if (vtime->*time >= TICK_NSEC)
>> 	  account_*_time()
>> 	    account_system_index_time()
>> 	      task_group_account_field()
>> 	        __this_cpu_add(kernel_cpustat.cpustat[index], tmp);        <---- here
>>
>> is not folding time into kernel_cpustat when the task vtime isn't at
>> least a tick's worth. And then when we switch to another task, we leak
>> time.
> Looks right. Last time the patch was posted I misunderstood the issue.
>
>> There's another problem here, vtime_task_switch_generic() should use a
>> single call to sched_clock() to compute the old vtime_delta and set the
>> new vtime->starttime, otherwise there's a time hole there as well.
> Right, but does it really matter? It's just a few nanosecs ignored
> between two tasks switching.
>
>> This is all quite the maze and it really wants cleaning up, not be made
>> worse.
>>
>> So I think you want to do two things:
>>
>>   - pull kernel_cpustat updates out of task_group_account_field()
>>     and put them into vtime_task_switch_generic() to be purely
>>     vtime->starttime based.
> So you want to force the update on all context switches? We used that TICK_NSEC
> limit before updating in order to lower some overhead.
>
> There is also user <-> kernel involved.
>
> How about handling that from the read side? (below untested)
>
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 78a233d43757..f0f1af337e49 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -814,9 +814,9 @@ u64 task_gtime(struct task_struct *t)
>   	do {
>   		seq = read_seqcount_begin(&vtime->seqcount);
>   
> -		gtime = t->gtime;
> +		gtime = t->gtime + vtime->gtime;
>   		if (vtime->state == VTIME_GUEST)
> -			gtime += vtime->gtime + vtime_delta(vtime);
> +			gtime += vtime_delta(vtime);
>   
>   	} while (read_seqcount_retry(&vtime->seqcount, seq));
>   
> @@ -845,8 +845,8 @@ bool task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
>   		ret = false;
>   		seq = read_seqcount_begin(&vtime->seqcount);
>   
> -		*utime = t->utime;
> -		*stime = t->stime;
> +		*utime = t->utime + vtime->utime;
> +		*stime = t->stime + vtime->stime;
>   
>   		/* Task is sleeping or idle, nothing to add */
>   		if (vtime->state < VTIME_SYS)
> @@ -860,9 +860,9 @@ bool task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
>   		 * add pending nohz time to the right place.
>   		 */
>   		if (vtime->state == VTIME_SYS)
> -			*stime += vtime->stime + delta;
> +			*stime += delta;
>   		else
> -			*utime += vtime->utime + delta;
> +			*utime += delta;
>   	} while (read_seqcount_retry(&vtime->seqcount, seq));
>   
>   	return ret;
> @@ -896,11 +896,22 @@ static int vtime_state_fetch(struct vtime *vtime, int cpu)
>   
>   static u64 kcpustat_user_vtime(struct vtime *vtime)
>   {
> -	if (vtime->state == VTIME_USER)
> -		return vtime->utime + vtime_delta(vtime);
> -	else if (vtime->state == VTIME_GUEST)
> -		return vtime->gtime + vtime_delta(vtime);
> -	return 0;
> +	u64 delta = vtime->utime + vtime->gtime;
> +
> +	if (vtime->state == VTIME_USER || vtime->state == VTIME_GUEST)
> +		delta += vtime_delta(vtime);
> +
> +	return delta;
> +}
> +
> +static u64 kcpustat_guest_vtime(struct vtime *vtime)
> +{
> +	u64 delta = vtime->gtime;
> +
> +	if (vtime->state == VTIME_GUEST)
> +		delta += vtime_delta(vtime);
> +
> +	return delta;
>   }
>   
>   static int kcpustat_field_vtime(u64 *cpustat,
> @@ -931,8 +942,9 @@ static int kcpustat_field_vtime(u64 *cpustat,
>   		 */
>   		switch (usage) {
>   		case CPUTIME_SYSTEM:
> +			*val += vtime->stime;
>   			if (state == VTIME_SYS)
> -				*val += vtime->stime + vtime_delta(vtime);
> +				*val += vtime_delta(vtime);
>   			break;
>   		case CPUTIME_USER:
>   			if (task_nice(tsk) <= 0)
> @@ -943,12 +955,12 @@ static int kcpustat_field_vtime(u64 *cpustat,
>   				*val += kcpustat_user_vtime(vtime);
>   			break;
>   		case CPUTIME_GUEST:
> -			if (state == VTIME_GUEST && task_nice(tsk) <= 0)
> -				*val += vtime->gtime + vtime_delta(vtime);
> +			if (task_nice(tsk) <= 0)
> +				*val += kcpustat_guest_vtime(vtime);
>   			break;
>   		case CPUTIME_GUEST_NICE:
> -			if (state == VTIME_GUEST && task_nice(tsk) > 0)
> -				*val += vtime->gtime + vtime_delta(vtime);
> +			if (task_nice(tsk) > 0)
> +				*val += kcpustat_guest_vtime(vtime);
>   			break;
>   		default:
>   			break;
> @@ -1013,6 +1025,15 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
>   		*dst = *src;
>   		cpustat = dst->cpustat;
>   
> +		cpustat[CPUTIME_SYSTEM] += vtime->stime;
> +		if (task_nice(tsk) > 0) {
> +			cpustat[CPUTIME_NICE] += vtime->utime + vtime->gtime;
> +			cpustat[CPUTIME_GUEST_NICE] += vtime->gtime;
> +		} else {
> +			cpustat[CPUTIME_USER] += vtime->utime + vtime->gtime;
> +			cpustat[CPUTIME_GUEST] += vtime->gtime;
> +		}
> +
>   		/* Task is sleeping, dead or idle, nothing to add */
>   		if (state < VTIME_SYS)
>   			continue;
> @@ -1024,20 +1045,20 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
>   		 * add pending nohz time to the right place.
>   		 */
>   		if (state == VTIME_SYS) {
> -			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
> +			cpustat[CPUTIME_SYSTEM] += delta;
>   		} else if (state == VTIME_USER) {
>   			if (task_nice(tsk) > 0)
> -				cpustat[CPUTIME_NICE] += vtime->utime + delta;
> +				cpustat[CPUTIME_NICE] += delta;
>   			else
> -				cpustat[CPUTIME_USER] += vtime->utime + delta;
> +				cpustat[CPUTIME_USER] += delta;
“delta” has the same problem as vtime->utime, which varies with 
different tasks. switching between different tasks may cause time 
statistics to be reversed.
>   		} else {
>   			WARN_ON_ONCE(state != VTIME_GUEST);
>   			if (task_nice(tsk) > 0) {
> -				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
> -				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
> +				cpustat[CPUTIME_GUEST_NICE] += delta;
> +				cpustat[CPUTIME_NICE] += delta;
>   			} else {
> -				cpustat[CPUTIME_GUEST] += vtime->gtime + delta;
> -				cpustat[CPUTIME_USER] += vtime->gtime + delta;
> +				cpustat[CPUTIME_GUEST] += delta;
> +				cpustat[CPUTIME_USER] += delta;
>   			}
>   		}
>   	} while (read_seqcount_retry(&vtime->seqcount, seq));
> .
