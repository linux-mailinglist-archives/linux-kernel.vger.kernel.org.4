Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75107680147
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 21:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjA2UEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 15:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjA2UEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 15:04:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8CB1B57A
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 12:04:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q10so9315880wrm.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 12:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJdSLrm62OXsHa1vS2UwymBoPitLjdvJ3yZjxHg8IsU=;
        b=x7cAkHc8AmiRkUr5Kr57JzOaQui9GXrzM6lh6r+PphJ2vYQMBJzHgZ/4gxIeQezzJJ
         urII0ETErVFlqt+SrEOzz5n6h4ICT+uY9hRLt8qxpWPpa/Zx7E4qMfUgWx4Ww/oAmCtp
         +d+O3m7VjcDs2vIkLMz5n1q+wohgRPNv09eO1Nx380L0kpG3yDjq7xVO+396g55tB4y1
         vZsVUPTLvPZ3dYW2hpz7nD1W2GOrVLMrjS242cGrWkrerDZtYmxyu007oqY1TaA+tZSg
         S5bDACfWIvFsJoqZnybxImKrxBbNGe98xtr/rA+emQBfi90mCL6zfIWyB8ZDTZpRlKok
         0wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJdSLrm62OXsHa1vS2UwymBoPitLjdvJ3yZjxHg8IsU=;
        b=8QGcKr+7MPqJ8BAA63Fhe+opgvdBMFHSAo0Q0xkKMs2r1x1dwUOpWbWCnTubUZOtq0
         yMLCgw16f6hEmvV4TScKrAWyzRr8DbgVzsIorRIwqv9npOaVoIzA/f46hxhh7pRqjO2t
         zYK3fvq8kaoGb+X5M2t4yrbkmVUW4nnv+rokq+zmWhUmqXSoRNfMZiZi+8/YA9JoF7bI
         BrvrnBDiF/9dQBRdx8lsA38hFQGUFBaqGVvhr6V5FVyH6wLYfIib4zlCt0lrYL6QPdyN
         9jnv3O38r2dCaGqw664KCDnURvYEDx1pwhnO1nMr/cZy7Ebrgx15mkF0lq1JJZw4MRhT
         ungw==
X-Gm-Message-State: AO0yUKWkEsL8AXH8eEn1U2zAcLzj5/sQoKGD9GMsibFh/5VUSQ/lQrbI
        0v/y1DVWpUqrKDEb3XyGFQjlZQ==
X-Google-Smtp-Source: AK7set913VYbEi/YORn7oXlOgK8lK6bnhDIkjPhHMWS8PL2EVR5snx5DEvJ7oB8HHs9/oEdtx2tSwA==
X-Received: by 2002:a05:6000:1448:b0:2bf:decb:ecac with SMTP id v8-20020a056000144800b002bfdecbecacmr6989266wrx.11.1675022640893;
        Sun, 29 Jan 2023 12:04:00 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id o6-20020adfe806000000b002bdf8dd6a8bsm9731963wrm.80.2023.01.29.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 12:04:00 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:03:59 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230129200359.nkgi2aqreo5wx6c7@airbuntu>
References: <20230129161444.1674958-1-qyousef@layalina.io>
 <20230129161444.1674958-2-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230129161444.1674958-2-qyousef@layalina.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/23 16:14, Qais Yousef wrote:
> When uclamp_max is being used, the util of the task could be higher than
> the spare capacity of the CPU, but due to uclamp_max value we force fit
> it there.
> 
> The way the condition for checking for max_spare_cap in
> find_energy_efficient_cpu() was constructed; it ignored any CPU that has
> its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
> max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
> hence ending up never performing compute_energy() for this cluster and
> missing an opportunity for a better energy efficient placement to honour
> uclamp_max setting.
> 
> 	max_spare_cap = 0;
> 	cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high
> 
> 	...
> 
> 	util_fits_cpu(...);		// will return true if uclamp_max forces it to fit
> 
> 	...
> 
> 	// this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
> 	if (cpu_cap > max_spare_cap) {
> 		max_spare_cap = cpu_cap;
> 		max_spare_cap_cpu = cpu;
> 	}
> 
> prev_spare_cap suffers from a similar problem.
> 
> Fix the logic by treating -1UL value as 'not populated' instead of
> 0 which is a viable and correct spare capacity value.
> 
> Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e29e9ea4cde8..ca2c389d3180 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7390,9 +7390,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	for (; pd; pd = pd->next) {
>  		unsigned long util_min = p_util_min, util_max = p_util_max;
>  		unsigned long cpu_cap, cpu_thermal_cap, util;
> -		unsigned long cur_delta, max_spare_cap = 0;
> +		unsigned long cur_delta, max_spare_cap = -1UL;
>  		unsigned long rq_util_min, rq_util_max;
> -		unsigned long prev_spare_cap = 0;
> +		unsigned long prev_spare_cap = -1UL;
>  		int max_spare_cap_cpu = -1;
>  		unsigned long base_energy;
>  		int fits, max_fits = -1;
> @@ -7457,7 +7457,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  				prev_spare_cap = cpu_cap;
>  				prev_fits = fits;
>  			} else if ((fits > max_fits) ||
> -				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> +				   ((fits == max_fits) &&
> +				   (cpu_cap > max_spare_cap || max_spare_cap == -1UL) {

Oops. Sorry I just realized I bodged this while rebasing and preparing the
patches for posting. There are missing termination parenthesis that will cause
compilation errors.

Apologies..


--
Qais Yousef

>  				/*
>  				 * Find the CPU with the maximum spare capacity
>  				 * among the remaining CPUs in the performance
> @@ -7469,7 +7470,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			}
>  		}
>  
> -		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
> +		if (max_spare_cap_cpu < 0 && prev_spare_cap == -1UL)
>  			continue;
>  
>  		eenv_pd_busy_time(&eenv, cpus, p);
> @@ -7477,7 +7478,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
>  
>  		/* Evaluate the energy impact of using prev_cpu. */
> -		if (prev_spare_cap > 0) {
> +		if (prev_spare_cap != -1UL) {
>  			prev_delta = compute_energy(&eenv, pd, cpus, p,
>  						    prev_cpu);
>  			/* CPU utilization has changed */
> @@ -7489,7 +7490,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		}
>  
>  		/* Evaluate the energy impact of using max_spare_cap_cpu. */
> -		if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
> +		if (max_spare_cap_cpu >= 0 &&
> +		    (max_spare_cap > prev_spare_cap || prev_spare_cap == -1UL)) {
>  			/* Current best energy cpu fits better */
>  			if (max_fits < best_fits)
>  				continue;
> -- 
> 2.25.1
> 
