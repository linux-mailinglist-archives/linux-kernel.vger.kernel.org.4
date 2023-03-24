Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407E86C7CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCXKq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCXKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:46:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6671A241F0;
        Fri, 24 Mar 2023 03:46:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B9F411FB;
        Fri, 24 Mar 2023 03:47:10 -0700 (PDT)
Received: from [10.57.18.195] (unknown [10.57.18.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51003F6C4;
        Fri, 24 Mar 2023 03:46:23 -0700 (PDT)
Message-ID: <09ea63b7-7294-a143-c797-95eba87c765e@arm.com>
Date:   Fri, 24 Mar 2023 10:46:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] cpufreq: schedutil: Combine two loops into one in
 sugov_start()
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, mingo@redhat.com, vschneid@redhat.com,
        bristot@redhat.com, bsegall@google.com, juri.lelli@redhat.com,
        peterz@infradead.org, mgorman@suse.de, viresh.kumar@linaro.org,
        rafael@kernel.org
References: <20230324100023.900616-1-yajun.deng@linux.dev>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230324100023.900616-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yajun,

On 3/24/23 10:00, Yajun Deng wrote:
> The sugov_start() function currently contains two for loops that
> traverse the CPU list and perform some initialization tasks. The first
> loop initializes each sugov_cpu struct and assigns the CPU number and
> sugov_policy pointer. The second loop sets up the update_util hook for
> each CPU based on the policy type.
> 
> Since both loops operate on the same CPU list, it is possible to combine
> them into a single for loop. This simplifies the code and reduces the
> number of times the CPU list needs to be traversed, which can improve
> performance.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>   kernel/sched/cpufreq_schedutil.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e3211455b203..9a28ebbb9c1e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -766,14 +766,6 @@ static int sugov_start(struct cpufreq_policy *policy)
>   
>   	sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
>   
> -	for_each_cpu(cpu, policy->cpus) {
> -		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> -
> -		memset(sg_cpu, 0, sizeof(*sg_cpu));
> -		sg_cpu->cpu			= cpu;
> -		sg_cpu->sg_policy		= sg_policy;
> -	}
> -
>   	if (policy_is_shared(policy))
>   		uu = sugov_update_shared;
>   	else if (policy->fast_switch_enabled && cpufreq_driver_has_adjust_perf())
> @@ -784,6 +776,10 @@ static int sugov_start(struct cpufreq_policy *policy)
>   	for_each_cpu(cpu, policy->cpus) {
>   		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
>   
> +		memset(sg_cpu, 0, sizeof(*sg_cpu));
> +		sg_cpu->cpu			= cpu;
> +		sg_cpu->sg_policy		= sg_policy;
> +
>   		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
>   	}
>   	return 0;

IMO the change might cause a race.
There is a call to set scheduler hook in the 2nd loop.
If you combine two loops that hook might be used
from other CPU in the meantime, while still the rest CPUs are not
finished.
The first loop makes sure all CPUs in the 'policy->cpus' get a clean
context 'sg_cpu' and proper 'cpu' values first (and 'sg_policy' as
well). When the two loops are combined, there might be fast usage
from scheduler on other CPU the sugov code path.

If the policy is shared for many CPUs and any of them is able to
change the freq, then some CPU can enter this code flow, where
remotely wants to check the other CPUs' utilization:

sugov_next_freq_shared()
	for each cpu in policy->cpus:
		sugov_get_util()
			where the 'sg_cpu->cpu' is used


Therefore, IMO this optimization in a start function (which is
only called once and is not part of the 'hot path') is not
worth the race risk.

Regards
Lukasz
