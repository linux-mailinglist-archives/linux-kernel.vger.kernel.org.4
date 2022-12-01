Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561BF63FAAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiLAWjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiLAWjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:39:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22276BEC4A;
        Thu,  1 Dec 2022 14:39:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6156D2B;
        Thu,  1 Dec 2022 14:39:12 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AE193F73D;
        Thu,  1 Dec 2022 14:39:03 -0800 (PST)
Message-ID: <927e4ffc-8400-b615-2d58-9e88ee4bdc3c@arm.com>
Date:   Thu, 1 Dec 2022 23:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] sched/uclamp: Fix a uninitialized variable warnings
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-2-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221127141742.1644023-2-qyousef@layalina.io>
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

On 27/11/2022 15:17, Qais Yousef wrote:
> Addresses the following warnings:
> 
>> config: riscv-randconfig-m031-20221111
>> compiler: riscv64-linux-gcc (GCC) 12.1.0
>>
>> smatch warnings:
>> kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_min'.
>> kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_max'.
> 
> Fixes: 244226035a1f ("sched/uclamp: Fix fits_capacity() check in feec()")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4cc56c91e06e..89dadaafc1ec 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7217,10 +7217,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	eenv_task_busy_time(&eenv, p, prev_cpu);
>  
>  	for (; pd; pd = pd->next) {
> +		unsigned long util_min = p_util_min, util_max = p_util_max;
>  		unsigned long cpu_cap, cpu_thermal_cap, util;
>  		unsigned long cur_delta, max_spare_cap = 0;
>  		unsigned long rq_util_min, rq_util_max;
> -		unsigned long util_min, util_max;
>  		unsigned long prev_spare_cap = 0;
>  		int max_spare_cap_cpu = -1;
>  		unsigned long base_energy;
> @@ -7258,10 +7258,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			 * aligned with sched_cpu_util().
>  			 */
>  			if (uclamp_is_used()) {
> -				if (uclamp_rq_is_idle(cpu_rq(cpu))) {
> -					util_min = p_util_min;
> -					util_max = p_util_max;
> -				} else {
> +				if (!uclamp_rq_is_idle(cpu_rq(cpu))) {
>  					/*
>  					 * Open code uclamp_rq_util_with() except for
>  					 * the clamp() part. Ie: apply max aggregation

Can we use `struct rq *rq = cpu_rq(cpu)` to reduce nesting and comply
with 80 columns line length?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 89dadaafc1ec..6a2fc2ca5078 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7239,6 +7239,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		eenv.pd_cap = 0;
 
 		for_each_cpu(cpu, cpus) {
+			struct rq *rq = cpu_rq(cpu);
+
 			eenv.pd_cap += cpu_thermal_cap;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
@@ -7257,21 +7259,19 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * much capacity we can get out of the CPU; this is
 			 * aligned with sched_cpu_util().
 			 */
-			if (uclamp_is_used()) {
-				if (!uclamp_rq_is_idle(cpu_rq(cpu))) {
-					/*
-					 * Open code uclamp_rq_util_with() except for
-					 * the clamp() part. Ie: apply max aggregation
-					 * only. util_fits_cpu() logic requires to
-					 * operate on non clamped util but must use the
-					 * max-aggregated uclamp_{min, max}.
-					 */
-					rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
-					rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
-
-					util_min = max(rq_util_min, p_util_min);
-					util_max = max(rq_util_max, p_util_max);
-				}
+			if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
+				/*
+				 * Open code uclamp_rq_util_with() except for
+				 * the clamp() part. Ie: apply max aggregation
+				 * only. util_fits_cpu() logic requires to
+				 * operate on non clamped util but must use the
+				 * max-aggregated uclamp_{min, max}.
+				 */
+				rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
+				rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
+
+				util_min = max(rq_util_min, p_util_min);
+				util_max = max(rq_util_max, p_util_max);
 			}
 			if (!util_fits_cpu(util, util_min, util_max, cpu))
 				continue;
