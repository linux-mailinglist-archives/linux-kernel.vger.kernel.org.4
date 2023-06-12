Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E772CADC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbjFLP73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbjFLP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:59:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F3B2BB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:59:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 219FD1FB;
        Mon, 12 Jun 2023 08:59:52 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0A283F5A1;
        Mon, 12 Jun 2023 08:59:04 -0700 (PDT)
Message-ID: <e4672cee-6bec-d20e-bfcf-f701fc6a45c6@arm.com>
Date:   Mon, 12 Jun 2023 17:58:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] sched/fair: rename variable cpu_util eff_util
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20230611122535.183654-1-trix@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230611122535.183654-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2023 14:25, Tom Rix wrote:
> cppcheck reports
> kernel/sched/fair.c:7436:17: style: Local variable 'cpu_util' shadows outer function [shadowFunction]
>   unsigned long cpu_util;
>                 ^
> 
> Clean this up by renaming the variable to eff_util
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6189d1a45635..7666dbc2b788 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7433,7 +7433,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
>  	for_each_cpu(cpu, pd_cpus) {
>  		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
>  		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
> -		unsigned long cpu_util;
> +		unsigned long eff_util;
>  
>  		/*
>  		 * Performance domain frequency: utilization clamping
> @@ -7442,8 +7442,8 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
>  		 * NOTE: in case RT tasks are running, by default the
>  		 * FREQUENCY_UTIL's utilization can be max OPP.
>  		 */
> -		cpu_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
> -		max_util = max(max_util, cpu_util);
> +		eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
> +		max_util = max(max_util, eff_util);
>  	}
>  
>  	return min(max_util, eenv->cpu_cap);

I forgot to check this in patch 'sched/fair: Refactor CPU utilization
functions' when I replaced cpu_util_next() with cpu_util().

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>


