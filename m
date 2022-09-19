Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320515BC602
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiISKFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiISKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:05:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A89DB4A5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:05:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 759071424;
        Mon, 19 Sep 2022 03:05:54 -0700 (PDT)
Received: from [192.168.178.82] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F405E3F73B;
        Mon, 19 Sep 2022 03:05:44 -0700 (PDT)
Message-ID: <073938c4-ab23-2270-8e60-291f2901e230@arm.com>
Date:   Mon, 19 Sep 2022 12:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/8] sched/fair: Take into account latency priority at
 wakeup
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-6-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220916080305.29574-6-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 10:03, Vincent Guittot wrote:

[...]

> @@ -4512,7 +4519,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  	p->prio = current->normal_prio;
>  
>  	/* Propagate the parent's latency requirements to the child as well */
> -	p->latency_nice = current->latency_nice;
> +	p->latency_prio = current->latency_prio;

Isn't here a `set_latency_offset(p)` missing here?

>  
>  	uclamp_fork(p);
>  

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e8c1b889dcbb..a20eadb0af97 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4574,6 +4574,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  		update_idle_cfs_rq_clock_pelt(cfs_rq);
>  }
>  
> +static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se);

minor: `struct sched_entity *curr` ... doesn't have to be current
(cfs_rq->curr). Isn't this more like `struct sched_entity *sea, struct
sched_entity *seb`? Anyway, it's already the case for
`wakeup_preempt_entity`.

[...]

> @@ -5732,6 +5735,35 @@ static int sched_idle_cpu(int cpu)
>  }
>  #endif
>  
> +static void set_next_buddy(struct sched_entity *se);
> +
> +static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)

minor: Why `struct cfs_rq *cfs` and not `struct cfs_rq *cfs_rq` ?

Using `cfs_rq` would make it more consistent when looking for things
like `cfs_rq->nr_running` for example.

> +{
> +	struct sched_entity *next;
> +
> +	if (se->latency_offset >= 0)
> +		return;
> +
> +	if (cfs->nr_running <= 1)
> +		return;
> +	/*
> +	 * When waking from idle, we don't need to check to preempt at wakeup

s/idle/others ?

> +	 * the idle thread and don't set next buddy as a candidate for being
> +	 * picked in priority.
> +	 * In case of simultaneous wakeup from idle, the latency sensitive tasks
> +	 * lost opportunity to preempt non sensitive tasks which woke up
> +	 * simultaneously.
> +	 */

The position of this comment block within this function is somehow
misleading since it describes the reason for the function rather then a
particular condition within this function. Wouldn't it be more readable
when it would be a function header comment instead?

[...]

> @@ -7148,6 +7181,22 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  }
>  #endif /* CONFIG_SMP */
>  
> +static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se)
> +{
> +	long latency_offset = se->latency_offset;
> +
> +	/*
> +	 * A negative latency weigth means that the sched_entity has latency

s/weigth/latency_offset ?


> +	 * requirement that needs to be evaluated versus other entity.
> +	 * Otherwise, use the latency weight to evaluate how much scheduling
> +	 * delay is acceptable by se.
> +	 */
> +	if ((se->latency_offset < 0) || (curr->latency_offset < 0))
> +		latency_offset -= curr->latency_offset;

I still don't get the rationale behind why when either one (se or curr)
of the latency_nice values is negative, we use the diff between them but
if not, we only care about se's value. Why don't you always use the diff
between se and curr? Since we have a range [-20 ... 19] why shouldn't we
use the difference between let's say se = 19 and curr = 5?
You discussed this with Tao Zhou on the v1 but I didn't understand it fully.

[...]
