Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06F76F2524
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjD2O6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjD2O6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 10:58:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861F419B9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WMMg8gaLhy5BBYqYM/sO21lSHJif5YE9iDZe/pL1PXM=; b=rQAbLjOQ+CydoGgYXpSxcZi9Z5
        9W0k0oyPZAdfV0U63InhWKRaHkJMgyJF0R3lfExetnu+Rp26qFaV/WqIOQde/g27F5cMNBXfosoDM
        kBWz/PktsObHw6AdwdLoPUZAtgU9/SnATtQX3eNcV8MJgRy9IjZcgqsWsl4tvAntIWosVIya2U68y
        2auTxoXX2B+ukh5SB1czS5a5okVTAL0aU8xDPfHdof1UliSwsi0mk7qW8aK8PaYnZcJdFaVkb8Vuj
        X4PPXd9DpQM7rEsBl1wkP82XWLJfQC6scKhfSGAgIwSp2QUvzu+NH0T/qaZPofivYIzz8YY8p/Sei
        2cDjOk9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1psm1u-005bDF-GW; Sat, 29 Apr 2023 14:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B31D1300379;
        Sat, 29 Apr 2023 16:58:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34DC13102F8F5; Sat, 29 Apr 2023 16:58:29 +0200 (CEST)
Date:   Sat, 29 Apr 2023 16:58:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
Message-ID: <20230429145829.GB1495785@hirez.programming.kicks-ass.net>
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
 <20230406155030.1989554-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406155030.1989554-2-dietmar.eggemann@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 05:50:30PM +0200, Dietmar Eggemann wrote:
> Use new cpu_boosted_util_cfs() instead of cpu_util_cfs().
> 
> The former returns max(util_avg, runnable_avg) capped by max CPU
> capacity. CPU contention is thereby considered through runnable_avg.
> 
> The change in load-balance only affects migration type `migrate_util`.

But why, and how does it affect? That is, isn't this Changelog a wee bit
sparse?

> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c |  3 ++-
>  kernel/sched/fair.c              |  2 +-
>  kernel/sched/sched.h             | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e3211455b203..728b186cd367 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -158,7 +158,8 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
>  
>  	sg_cpu->bw_dl = cpu_bw_dl(rq);
> -	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
> +	sg_cpu->util = effective_cpu_util(sg_cpu->cpu,
> +					  cpu_boosted_util_cfs(sg_cpu->cpu),
>  					  FREQUENCY_UTIL, NULL);
>  }
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc358dc4faeb..5ae36224a1c2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10481,7 +10481,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  			break;
>  
>  		case migrate_util:
> -			util = cpu_util_cfs(i);
> +			util = cpu_boosted_util_cfs(i);
>  
>  			/*
>  			 * Don't try to pull utilization from a CPU with one
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 060616944d7a..f42c859579d9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2994,6 +2994,25 @@ static inline unsigned long cpu_util_cfs(int cpu)
>  	return min(util, capacity_orig_of(cpu));
>  }
>  
> +/*
> + * cpu_boosted_util_cfs() - Estimates the amount of CPU capacity used by
> + *                          CFS tasks.
> + *
> + * Similar to cpu_util_cfs() but also take possible CPU contention into
> + * consideration.
> + */
> +static inline unsigned long cpu_boosted_util_cfs(int cpu)
> +{
> +	unsigned long runnable;
> +	struct cfs_rq *cfs_rq;
> +
> +	cfs_rq = &cpu_rq(cpu)->cfs;
> +	runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
> +	runnable = min(runnable, capacity_orig_of(cpu));
> +
> +	return max(cpu_util_cfs(cpu), runnable);
> +}
> +
>  static inline unsigned long cpu_util_rt(struct rq *rq)
>  {
>  	return READ_ONCE(rq->avg_rt.util_avg);
> -- 
> 2.25.1
> 
