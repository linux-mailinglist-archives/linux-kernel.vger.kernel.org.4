Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC1F6D43B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjDCLkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:40:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55ACE35AF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:40:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B0981063;
        Mon,  3 Apr 2023 04:41:20 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9D1F3F6C4;
        Mon,  3 Apr 2023 04:40:33 -0700 (PDT)
Message-ID: <e3aa7e66-27d0-034b-7bdf-f4fab1c2df25@arm.com>
Date:   Mon, 3 Apr 2023 13:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 1/6] sched/fair: Add util_guest for tasks
Content-Language: en-US
To:     David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
References: <20230330224348.1006691-1-davidai@google.com>
 <20230330224348.1006691-2-davidai@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230330224348.1006691-2-davidai@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 31/03/2023 00:43, David Dai wrote:
> For virtualization usecases, util_est and util_avg currently tracked
> on the host aren't sufficient to accurately represent the workload on
> vCPU threads, which results in poor frequency selection and performance.
> For example, when a large workload migrates from a busy vCPU thread to
> an idle vCPU thread, it incurs additional DVFS ramp-up latencies
> as util accumulates.
> 
> Introduce a new "util_guest" member as an additional PELT signal that's
> independently updated by the guest. When used, it's max aggregated to
> provide a boost to both task_util and task_util_est.
> 
> Updating task_util and task_util_est will ensure:
> -Better task placement decisions for vCPU threads on the host
> -Correctly updating util_est.ewma during dequeue
> -Additive util with other threads on the same runqueue for more
> accurate frequency responses
> 
> Co-developed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: David Dai <davidai@google.com>
> ---

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6986ea31c984..998649554344 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4276,14 +4276,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
>  
>  static inline unsigned long task_util(struct task_struct *p)
>  {
> -	return READ_ONCE(p->se.avg.util_avg);
> +	return max(READ_ONCE(p->se.avg.util_avg),
> +			READ_ONCE(p->se.avg.util_guest));
>  }
>  
>  static inline unsigned long _task_util_est(struct task_struct *p)
>  {
>  	struct util_est ue = READ_ONCE(p->se.avg.util_est);
>  
> -	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
> +	return max_t(unsigned long, READ_ONCE(p->se.avg.util_guest),
> +			max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED)));
>  }

I can't see why the existing p->uclamp_req[UCLAMP_MIN].value can't be
used here instead p->se.avg.util_guest.

I do understand the issue of inheriting uclamp values at fork but don't
get the not being `additive` thing. We are at task level here.

The fact that you have to max util_avg and util_est directly in
task_util() and _task_util_est() tells me that there are places where
this helps and uclamp_task_util() is not called there.

When you say in the cover letter that you tried uclamp_min, how exactly
did you use it? Did you run the existing mainline or did you use
uclamp_min as a replacement for util_guest in this patch here?

>  static inline unsigned long task_util_est(struct task_struct *p)
> @@ -6242,6 +6244,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 */
>  	util_est_enqueue(&rq->cfs, p);
>  
> +	/*
> +	 * The normal code path for host thread enqueue doesn't take into
> +	 * account guest task migrations when updating cpufreq util.
> +	 * So, always update the cpufreq when a vCPU thread has a
> +	 * non-zero util_guest value.
> +	 */
> +	if (READ_ONCE(p->se.avg.util_guest))
> +		cpufreq_update_util(rq, 0);


This is because enqueue_entity() -> update_load_avg() ->
attach_entity_load_avg() -> cfs_rq_util_change() requires root run-queue
(&rq->cfs == cfs_rq) to call cpufreq_update_util()?

[...]
