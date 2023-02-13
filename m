Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F66694619
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjBMMoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBMMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:44:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 790BD5FE6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:44:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C703C4B3;
        Mon, 13 Feb 2023 04:45:16 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBAE83F703;
        Mon, 13 Feb 2023 04:44:29 -0800 (PST)
Message-ID: <f8a75f47-0f7e-14cc-adf4-2854e235b26e@arm.com>
Date:   Mon, 13 Feb 2023 13:44:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 07/10] sched/fair: Do not even the number of busy CPUs
 via asym_packing
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
 <20230207045838.11243-8-ricardo.neri-calderon@linux.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230207045838.11243-8-ricardo.neri-calderon@linux.intel.com>
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

> @@ -9269,33 +9264,11 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
>  				    struct sched_group *sg)
>  {
>  #ifdef CONFIG_SCHED_SMT
> -	bool local_is_smt;
>  	int sg_busy_cpus;
>  
> -	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
>  	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
>  
> -	if (!local_is_smt) {
> -		/*
> -		 * If we are here, @dst_cpu is idle and does not have SMT
> -		 * siblings. Pull tasks if candidate group has two or more
> -		 * busy CPUs.
> -		 */
> -		if (sg_busy_cpus >= 2) /* implies sg_is_smt */
> -			return true;
> -
> -		/*
> -		 * @dst_cpu does not have SMT siblings. @sg may have SMT
> -		 * siblings and only one is busy. In such case, @dst_cpu
> -		 * can help if it has higher priority and is idle (i.e.,
> -		 * it has no running tasks).
> -		 */
> -		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> -	}
> -
>  	/*
> -	 * @dst_cpu has SMT siblings and are also idle.
> -	 *
>  	 * If the difference in the number of busy CPUs is two or more, let
>  	 * find_busiest_group() take care of it. We only care if @sg has
>  	 * exactly one busy CPU. This covers SMT and non-SMT sched groups.

Can't this be made lighter by removing asym_smt_can_pull_tasks() and
putting the logic to exclude the call to sched_asym_prefer() into
sched_asym() directly?
Not sure if we need the CONFIG_SCHED_SMT since it's all guarded by
`flags & SD_SHARE_CPUCAPACITY` already, which is only set under.
CONFIG_SCHED_SMT.

static inline bool
sched_asym(struct lb_env *env, struct sd_lb_stats *sds,
           struct sg_lb_stats *sgs, struct sched_group *group)
{
        bool local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;

        if (local_is_smt && !is_core_idle(env->dst_cpu))
                return false;

        if ((local_is_smt || group->flags & SD_SHARE_CPUCAPACITY)) {
                int sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;

                if (sg_busy_cpus != 1)
                        return false;
        }

        return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
}

[...]



















