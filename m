Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FE764174F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 15:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLCOcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 09:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiLCOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:32:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A27DF4
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 06:32:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o30so5525121wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 06:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/slI43YQ77BjkqjOhSgLj/8+/Ru84H0eXYANhuZ9jQ=;
        b=sxlWioTj2TBdkQ3JocqfqDrRDRe5ov/iJiMZpASubQ7a6fzpJ+D4o+zfYiZYNuJ9Vu
         TSdIV/tQvgCuxE/fSIuUxx6F/7GsBmezM7OnW2Hz9Pp7CN4S7Xbnz96LnJjqiZ/rGO8u
         44nT5iHEFwC9KWgRIoRp1e6xZOrK5JBDI8krxXt6LloAIoose8Wxm8HGscDuNsjqD4CT
         nNGee4ZMb42guH+HIvnkHQy7w+743VNqDKD807WHyOj2GdtMoj22L+B5TNLKzs83bhol
         S3CtRCW1PqtMi8KV4GBQhPgfa2fM6XcifI+xYc+s8EQ9A8a94S/i9H+1/gclteq/ISL1
         jXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/slI43YQ77BjkqjOhSgLj/8+/Ru84H0eXYANhuZ9jQ=;
        b=JGsqts01z3OquVCtkxGy2PehYTjh83+1H3gTopzAekChVwGTqcTEsTT2Yu0vHCP+Mc
         eCW9+TlXANX/SuHe/l88+4v5fu7G1Yuk+KOlLUb+9JC/QH/uA5t/yH/h4LXsMYYUPDsI
         hl9pVEcKgFf/F5NhSfICNjhzM6kmOt2oGoPM+Ex6UryaMtDguGICkekrxcPeWJtfpEIy
         7mQYBDTu2NsCQjIz13pemagaaKSbdaxzDsgicEQP1XV2MbuszEElWcPN9rMp3wBDakRB
         H5ioWZqexUlXDcrl6xR/aB/N/I2y0klOshr4KFlt6+qnKgYjHtQEMS7rXRbYyhFV8TI+
         8uiw==
X-Gm-Message-State: ANoB5pmJE9F6K5hIu/kFD+Gj/0EWB9pdeAcVmcG5tWYLzq94CmOds6db
        /WuAMU/Zj1wOarNp/FMdzs4X5g==
X-Google-Smtp-Source: AA0mqf5mbz6bxFw4RhOsBjOIwI5wF+k1H0fTKPeW2J+ipJId4fh329MyKu99sWaZGmS+5ELR6r8OCA==
X-Received: by 2002:a05:600c:4f51:b0:3b4:a6c4:70fb with SMTP id m17-20020a05600c4f5100b003b4a6c470fbmr41719758wmq.79.1670077956415;
        Sat, 03 Dec 2022 06:32:36 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id r2-20020a056000014200b002422bc69111sm11976885wrx.9.2022.12.03.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 06:32:36 -0800 (PST)
Date:   Sat, 3 Dec 2022 14:32:34 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 1/3] sched/uclamp: Fix a uninitialized variable warnings
Message-ID: <20221203143234.fbbdjoc6istwxkee@airbuntu>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-2-qyousef@layalina.io>
 <927e4ffc-8400-b615-2d58-9e88ee4bdc3c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <927e4ffc-8400-b615-2d58-9e88ee4bdc3c@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/22 23:38, Dietmar Eggemann wrote:
> On 27/11/2022 15:17, Qais Yousef wrote:
> > Addresses the following warnings:
> > 
> >> config: riscv-randconfig-m031-20221111
> >> compiler: riscv64-linux-gcc (GCC) 12.1.0
> >>
> >> smatch warnings:
> >> kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_min'.
> >> kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_max'.
> > 
> > Fixes: 244226035a1f ("sched/uclamp: Fix fits_capacity() check in feec()")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/fair.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4cc56c91e06e..89dadaafc1ec 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7217,10 +7217,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  	eenv_task_busy_time(&eenv, p, prev_cpu);
> >  
> >  	for (; pd; pd = pd->next) {
> > +		unsigned long util_min = p_util_min, util_max = p_util_max;
> >  		unsigned long cpu_cap, cpu_thermal_cap, util;
> >  		unsigned long cur_delta, max_spare_cap = 0;
> >  		unsigned long rq_util_min, rq_util_max;
> > -		unsigned long util_min, util_max;
> >  		unsigned long prev_spare_cap = 0;
> >  		int max_spare_cap_cpu = -1;
> >  		unsigned long base_energy;
> > @@ -7258,10 +7258,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  			 * aligned with sched_cpu_util().
> >  			 */
> >  			if (uclamp_is_used()) {
> > -				if (uclamp_rq_is_idle(cpu_rq(cpu))) {
> > -					util_min = p_util_min;
> > -					util_max = p_util_max;
> > -				} else {
> > +				if (!uclamp_rq_is_idle(cpu_rq(cpu))) {
> >  					/*
> >  					 * Open code uclamp_rq_util_with() except for
> >  					 * the clamp() part. Ie: apply max aggregation
> 
> Can we use `struct rq *rq = cpu_rq(cpu)` to reduce nesting and comply
> with 80 columns line length?

Yep, that's better!


Thanks!

--
Qais Yousef

> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 89dadaafc1ec..6a2fc2ca5078 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7239,6 +7239,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		eenv.pd_cap = 0;
>  
>  		for_each_cpu(cpu, cpus) {
> +			struct rq *rq = cpu_rq(cpu);
> +
>  			eenv.pd_cap += cpu_thermal_cap;
>  
>  			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
> @@ -7257,21 +7259,19 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			 * much capacity we can get out of the CPU; this is
>  			 * aligned with sched_cpu_util().
>  			 */
> -			if (uclamp_is_used()) {
> -				if (!uclamp_rq_is_idle(cpu_rq(cpu))) {
> -					/*
> -					 * Open code uclamp_rq_util_with() except for
> -					 * the clamp() part. Ie: apply max aggregation
> -					 * only. util_fits_cpu() logic requires to
> -					 * operate on non clamped util but must use the
> -					 * max-aggregated uclamp_{min, max}.
> -					 */
> -					rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> -					rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> -
> -					util_min = max(rq_util_min, p_util_min);
> -					util_max = max(rq_util_max, p_util_max);
> -				}
> +			if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
> +				/*
> +				 * Open code uclamp_rq_util_with() except for
> +				 * the clamp() part. Ie: apply max aggregation
> +				 * only. util_fits_cpu() logic requires to
> +				 * operate on non clamped util but must use the
> +				 * max-aggregated uclamp_{min, max}.
> +				 */
> +				rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
> +				rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
> +
> +				util_min = max(rq_util_min, p_util_min);
> +				util_max = max(rq_util_max, p_util_max);
>  			}
>  			if (!util_fits_cpu(util, util_min, util_max, cpu))
>  				continue;
