Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D91668ABEE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjBDSmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjBDSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:42:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054A2D49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:42:36 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so4597971wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 10:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdb620AZnZs8abG3FIgOEjaZsK8BXRLssSIT/ju2/0M=;
        b=6JkYEFgZVNnGRW7vwrrG1unHZYikgxQ9gwvM0dAcC1RIaynhCz4Al/vRz2sm5cEFNr
         51UcvuaUDuzGD/DnXh4dftMaZE6bXBMm50gkgEsxyba6K4fqsLrJny197X0Sz50YxoIt
         kcmaGL1K1d3nziVaVQBYjgLrlvMmBLPh5KVaaFtubsEJf15jtid4z9xFBKWTBH4su6J5
         l708Bsy3s1RM4ZA8cZP2LbdsElv3vEU0DShmKlCHGhhQxpMzmTrbUrX9fiH7iBWC5sYd
         De41jwNUrXSYtKrUZjuh2hLJ4lIr9Uxt9zbvTsGTwaoLoAMnikjyHZlTFjDUGZ3MMpjr
         p93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wdb620AZnZs8abG3FIgOEjaZsK8BXRLssSIT/ju2/0M=;
        b=o6Igj1UI4VZ/kwiBCU16JKDh0QTBoGWEmmcU6N2uGrjX924dAJoNKJWRMnsikTCEvn
         xNDg8R3ck+9u4uzRf5vKXEjdT+4v2WfYmzQ7IkAb8F2F/ekZgdRhItUeJr4QI8DjTRi/
         G1xOZbv6vp/sfsHAW5/lWa4VxDQxfz08xHcQsTsq8aE6b4dCHZJegrs53OkeXCuXlYMk
         dtZOWkaOb/KC+oXKjTk+1xq9PkeILlaM6O1SUqZN5+pS7DzU/0Zur1tAVvH/zw5ZfVQ1
         Juofif5+6jObt2osPxp4MdGQOgR9PmyoftPecmAM0oKZ3Ok7qYdOEAcIz690bqOvjQ5t
         IGRw==
X-Gm-Message-State: AO0yUKW9yS8EtXAqrlARw8kCpol5j31g6KThPkDjXKyYtsjpHalYJrBq
        wN58qmkVARU+ooaHb6G1CWNpXQ==
X-Google-Smtp-Source: AK7set8/VzR5bwmAjEbVHAJBf/pvpnZeh3D/YvQNTDeL4+JTMgW0UOKDzazYUKLHmmkZkvj19O3Xbg==
X-Received: by 2002:a1c:4b15:0:b0:3dd:1b6f:4f30 with SMTP id y21-20020a1c4b15000000b003dd1b6f4f30mr16785727wma.3.1675536154317;
        Sat, 04 Feb 2023 10:42:34 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003dc54344764sm12329782wmo.48.2023.02.04.10.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 10:42:33 -0800 (PST)
Date:   Sat, 4 Feb 2023 18:42:31 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kajetan.puchalski@arm.com, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH 2/2 v5] sched/fair: Remove capacity inversion detection
Message-ID: <20230204184231.zx6oo52r5q2nvij7@airbuntu>
References: <20230201143628.270912-1-vincent.guittot@linaro.org>
 <20230201143628.270912-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230201143628.270912-3-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/23 15:36, Vincent Guittot wrote:
> Remove the capacity inversion detection which is now handled by
> util_fits_cpu() returning -1 when we need to continue to look for a
> potential CPU with better performance.
> 
> This ends up almost reverting patches below except for some comments:

nit: I think this comment must be removed/reworeded though

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 691a2f9c4efa..c6c8e7f52935 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4476,10 +4476,6 @@ static inline int util_fits_cpu(unsigned long util,
         *
         * For uclamp_max, we can tolerate a drop in performance level as the
         * goal is to cap the task. So it's okay if it's getting less.
-        *
-        * In case of capacity inversion, which is not handled yet, we should
-        * honour the inverted capacity for both uclamp_min and uclamp_max all
-        * the time.
         */
        capacity_orig = capacity_orig_of(cpu);
        capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);

> commit da07d2f9c153 ("sched/fair: Fixes for capacity inversion detection")
> commit aa69c36f31aa ("sched/fair: Consider capacity inversion in util_fits_cpu()")
> commit 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Apart from that, LGTM.

Reviewed-by: Qais Yousef <qyousef@layalina.io>


Thanks!

--
Qais Yousef

> ---
>  kernel/sched/fair.c  | 84 +++-----------------------------------------
>  kernel/sched/sched.h | 19 ----------
>  2 files changed, 5 insertions(+), 98 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 074742f107c0..c6c8e7f52935 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4476,17 +4476,9 @@ static inline int util_fits_cpu(unsigned long util,
>  	 *
>  	 * For uclamp_max, we can tolerate a drop in performance level as the
>  	 * goal is to cap the task. So it's okay if it's getting less.
> -	 *
> -	 * In case of capacity inversion we should honour the inverted capacity
> -	 * for both uclamp_min and uclamp_max all the time.
>  	 */
> -	capacity_orig = cpu_in_capacity_inversion(cpu);
> -	if (capacity_orig) {
> -		capacity_orig_thermal = capacity_orig;
> -	} else {
> -		capacity_orig = capacity_orig_of(cpu);
> -		capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> -	}
> +	capacity_orig = capacity_orig_of(cpu);
> +	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
>  
>  	/*
>  	 * We want to force a task to fit a cpu as implied by uclamp_max.
> @@ -9027,82 +9019,16 @@ static unsigned long scale_rt_capacity(int cpu)
>  
>  static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>  {
> -	unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
>  	unsigned long capacity = scale_rt_capacity(cpu);
>  	struct sched_group *sdg = sd->groups;
> -	struct rq *rq = cpu_rq(cpu);
>  
> -	rq->cpu_capacity_orig = capacity_orig;
> +	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
>  
>  	if (!capacity)
>  		capacity = 1;
>  
> -	rq->cpu_capacity = capacity;
> -
> -	/*
> -	 * Detect if the performance domain is in capacity inversion state.
> -	 *
> -	 * Capacity inversion happens when another perf domain with equal or
> -	 * lower capacity_orig_of() ends up having higher capacity than this
> -	 * domain after subtracting thermal pressure.
> -	 *
> -	 * We only take into account thermal pressure in this detection as it's
> -	 * the only metric that actually results in *real* reduction of
> -	 * capacity due to performance points (OPPs) being dropped/become
> -	 * unreachable due to thermal throttling.
> -	 *
> -	 * We assume:
> -	 *   * That all cpus in a perf domain have the same capacity_orig
> -	 *     (same uArch).
> -	 *   * Thermal pressure will impact all cpus in this perf domain
> -	 *     equally.
> -	 */
> -	if (sched_energy_enabled()) {
> -		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> -		struct perf_domain *pd;
> -
> -		rcu_read_lock();
> -
> -		pd = rcu_dereference(rq->rd->pd);
> -		rq->cpu_capacity_inverted = 0;
> -
> -		for (; pd; pd = pd->next) {
> -			struct cpumask *pd_span = perf_domain_span(pd);
> -			unsigned long pd_cap_orig, pd_cap;
> -
> -			/* We can't be inverted against our own pd */
> -			if (cpumask_test_cpu(cpu_of(rq), pd_span))
> -				continue;
> -
> -			cpu = cpumask_any(pd_span);
> -			pd_cap_orig = arch_scale_cpu_capacity(cpu);
> -
> -			if (capacity_orig < pd_cap_orig)
> -				continue;
> -
> -			/*
> -			 * handle the case of multiple perf domains have the
> -			 * same capacity_orig but one of them is under higher
> -			 * thermal pressure. We record it as capacity
> -			 * inversion.
> -			 */
> -			if (capacity_orig == pd_cap_orig) {
> -				pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
> -
> -				if (pd_cap > inv_cap) {
> -					rq->cpu_capacity_inverted = inv_cap;
> -					break;
> -				}
> -			} else if (pd_cap_orig > inv_cap) {
> -				rq->cpu_capacity_inverted = inv_cap;
> -				break;
> -			}
> -		}
> -
> -		rcu_read_unlock();
> -	}
> -
> -	trace_sched_cpu_capacity_tp(rq);
> +	cpu_rq(cpu)->cpu_capacity = capacity;
> +	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
>  
>  	sdg->sgc->capacity = capacity;
>  	sdg->sgc->min_capacity = capacity;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1072502976df..3e8df6d31c1e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1044,7 +1044,6 @@ struct rq {
>  
>  	unsigned long		cpu_capacity;
>  	unsigned long		cpu_capacity_orig;
> -	unsigned long		cpu_capacity_inverted;
>  
>  	struct balance_callback *balance_callback;
>  
> @@ -2899,24 +2898,6 @@ static inline unsigned long capacity_orig_of(int cpu)
>  	return cpu_rq(cpu)->cpu_capacity_orig;
>  }
>  
> -/*
> - * Returns inverted capacity if the CPU is in capacity inversion state.
> - * 0 otherwise.
> - *
> - * Capacity inversion detection only considers thermal impact where actual
> - * performance points (OPPs) gets dropped.
> - *
> - * Capacity inversion state happens when another performance domain that has
> - * equal or lower capacity_orig_of() becomes effectively larger than the perf
> - * domain this CPU belongs to due to thermal pressure throttling it hard.
> - *
> - * See comment in update_cpu_capacity().
> - */
> -static inline unsigned long cpu_in_capacity_inversion(int cpu)
> -{
> -	return cpu_rq(cpu)->cpu_capacity_inverted;
> -}
> -
>  /**
>   * enum cpu_util_type - CPU utilization type
>   * @FREQUENCY_UTIL:	Utilization used to select frequency
> -- 
> 2.34.1
> 
