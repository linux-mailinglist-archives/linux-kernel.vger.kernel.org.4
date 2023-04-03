Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B18C6D4E49
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjDCQrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjDCQrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:47:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F945171E;
        Mon,  3 Apr 2023 09:47:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08CFBFEC;
        Mon,  3 Apr 2023 09:47:51 -0700 (PDT)
Received: from [10.57.20.195] (unknown [10.57.20.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1DEC3F6C4;
        Mon,  3 Apr 2023 09:47:03 -0700 (PDT)
Message-ID: <bdaebc90-ca39-1301-c7ba-e367f8406d09@arm.com>
Date:   Mon, 3 Apr 2023 17:47:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] sched/tp: Add new tracepoint to track uclamp set from
 user-space
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
References: <20230322151843.14390-1-lukasz.luba@arm.com>
 <20230322151843.14390-2-lukasz.luba@arm.com>
 <20230403134606.amdxfmr5fb544xnv@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230403134606.amdxfmr5fb544xnv@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 4/3/23 14:46, Qais Yousef wrote:
> Hi Lukasz!
> 
> On 03/22/23 15:18, Lukasz Luba wrote:
>> The user-space can set uclamp value for a given task. It impacts task
>> placement decisions made by the scheduler. This is very useful information
>> and helps to understand the system behavior or track improvements in
>> middleware and applications which start using uclamp mechanisms and report
>> better performance in tests.
> 
> We do have uclamp trace events in sched_tp, why are they not sufficient?
> 
> 	https://github.com/qais-yousef/sched_tp/blob/main/sched_events.h#L233
> 
> Do you really want to know the exact time the value has changed?

Yes, that's why these new are triggered instantly after userspace wanted
to set the new uclamp values. We are going to have a few different
uclamp implementations: one in mainline and X in Android vendor kernels.
The goal is to have only one... We will have to experiment to find
the behavior of those algorithms and understand the differences. Since
uclamp is part of this 'control-chain' of CPU frequency and also
task placement - it would be really tricky to figure our everything.
The analysis on traces are crucial for this.

> 
> Would it make sense to introduce a generic sched_setscheduler tracepoint
> instead? Although this might not be necessary as I think we can use
> register_kprobe() to register a callback and create a new event without any
> additional tracepoint. sched_setscheduler() is not inlined so should be easy to
> hook into and create events, no?

This looks very complex and we already have our LISA tool with the
module to change the tracepoints into trace events and build them.
I wanted to be aligned with that design, which might look a bit
old-fashion but is simple IMO.

The 'sched_setscheduler tracepoint' might be a too big for this
purpose.

Thanks for the comments :)
Lukasz

> 
> 
> Thanks
> 
> --
> Qais Yousef
> 
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/trace/events/sched.h | 4 ++++
>>   kernel/sched/core.c          | 5 +++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
>> index fbb99a61f714..dbfb30809f15 100644
>> --- a/include/trace/events/sched.h
>> +++ b/include/trace/events/sched.h
>> @@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
>>   	TP_PROTO(struct rq *rq, int change),
>>   	TP_ARGS(rq, change));
>>   
>> +DECLARE_TRACE(uclamp_update_tsk_tp,
>> +	TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
>> +	TP_ARGS(tsk, uclamp_id, value));
>> +
>>   #endif /* _TRACE_SCHED_H */
>>   
>>   /* This part must be outside protection */
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 488655f2319f..882c92e3ccf0 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -110,6 +110,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>>   EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
>>   EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>>   EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(uclamp_update_tsk_tp);
>>   
>>   DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>>   
>> @@ -1936,12 +1937,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
>>   	    attr->sched_util_min != -1) {
>>   		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>>   			      attr->sched_util_min, true);
>> +		trace_uclamp_update_tsk_tp(p, UCLAMP_MIN,
>> +					   attr->sched_util_min);
>>   	}
>>   
>>   	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
>>   	    attr->sched_util_max != -1) {
>>   		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
>>   			      attr->sched_util_max, true);
>> +		trace_uclamp_update_tsk_tp(p, UCLAMP_MAX,
>> +					   attr->sched_util_max);
>>   	}
>>   }
>>   
>> -- 
>> 2.17.1
>>
