Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62E694736
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjBMNkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjBMNkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:40:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D84E7EDE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:40:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80D494B3;
        Mon, 13 Feb 2023 05:41:22 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A2C93F881;
        Mon, 13 Feb 2023 05:40:36 -0800 (PST)
Message-ID: <3a41995b-c39c-7346-e04b-7f13433b51c2@arm.com>
Date:   Mon, 13 Feb 2023 14:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 04/10] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
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

On 07/02/2023 05:58, Ricardo Neri wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 80c86462c6f6..c9d0ddfd11f2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10436,11 +10436,20 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		    nr_running == 1)
>  			continue;
>  
> -		/* Make sure we only pull tasks from a CPU of lower priority */
> +		/*
> +		 * Make sure we only pull tasks from a CPU of lower priority
> +		 * when balancing between SMT siblings.
> +		 *
> +		 * If balancing between cores, let lower priority CPUs help
> +		 * SMT cores with more than one busy sibling.
> +		 */
>  		if ((env->sd->flags & SD_ASYM_PACKING) &&
>  		    sched_asym_prefer(i, env->dst_cpu) &&
> -		    nr_running == 1)
> -			continue;
> +		    nr_running == 1) {
> +			if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> +			    (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && is_core_idle(i)))
> +				continue;

is_core_idle(i) returns true for !CONFIG_SCHED_SMP. So far it was always
guarded by `flags & SD_SHARE_CPUCAPACITY` which is only set for
CONFIG_SCHED_SMP.

Here it's different but still depends on `flags & SD_ASYM_PACKING`.

Can we have SD_ASYM_PACKING w/o CONFIG_SCHED_SMP? The comment just says
`If balancing between cores (MC), let lower priority CPUs help SMT cores
with more than one busy sibling.`

So this only mentions your specific asymmetric e-cores w/o SMT and
p-cores w/ SMT case.

I'm asking since numa_idle_core(), the only user of is_core_idle() so
far has an extra `!static_branch_likely(&sched_smt_present)` condition
before calling it.

> +		}
>  
>  		switch (env->migration_type) {
>  		case migrate_load:
> @@ -10530,8 +10539,20 @@ asym_active_balance(struct lb_env *env)
>  	 * lower priority CPUs in order to pack all tasks in the
>  	 * highest priority CPUs.
>  	 */
> -	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> -	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
> +	if (env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING)) {
> +		/* Always obey priorities between SMT siblings. */
> +		if (env->sd->flags & SD_SHARE_CPUCAPACITY)
> +			return sched_asym_prefer(env->dst_cpu, env->src_cpu);
> +
> +		/*
> +		 * A lower priority CPU can help an SMT core with more than one
> +		 * busy sibling.
> +		 */
> +		return sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
> +		       !is_core_idle(env->src_cpu);

Here it is similar.

> +	}
> +
> +	return false;

