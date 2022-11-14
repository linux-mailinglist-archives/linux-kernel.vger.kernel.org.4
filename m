Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254E16274D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiKNDG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKNDG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:06:26 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7272624A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:06:24 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id x15so7138474qvp.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlV/hH4vsUo/M2zZnxys0KFW2u/I8znQr8wRA6yRb/Q=;
        b=weo1k3bYO7OZ3DZVr8WFZGrK+J5E7Ds/YA+WdPzvWF7eogeR3b1+poKUVNSYqU5ml3
         5FgsMeEjg3n2Xf/gKd25aMD0Ys/UiKXGYU8jqZF1ojfJ+9ZMgwB0verBf8TVzjwsJ0XK
         i+oRrAhh9a5Ms8kKS+xx82JcJukdIzWc1vtOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlV/hH4vsUo/M2zZnxys0KFW2u/I8znQr8wRA6yRb/Q=;
        b=jZEX3nCH5CoQloogxyLxEBXQzqTHzXjrwPVr8bEp+aWbZdImOto/Afco0KLIRBFC2Y
         n6Cxf6OVY1L2IjWi9B+xIuMpyH136qwLvDQ8QYeA0tyRlxUMb22UfI0i9RmfUZc7BeJn
         VTeb9uGp3XUF7v3xNr6/GxmFe7DwvDekHOWpkvqjeczLMbkVud2eyfKejZwmkPpgDF04
         V2SfUwOgxSxpqrWQ9Kmb5S1fLQr2hUo8F67r2r6sLx1okXJDHnjrRrRHvxLGyilsc3EK
         fYGR9K1UCFkFoi77gDp1OB3zoK+wYOVozzoqQrDjaSsgPJ4tt8EhtCiHI9yIN8y/OO+9
         bjKg==
X-Gm-Message-State: ANoB5pk8xGlDTR8mPD3y37vMV61C0r97+Gta7yovabhjSSFGFKl8K0Z2
        j46PC6O+e9OzfUgVXyuCdcAi8Q==
X-Google-Smtp-Source: AA0mqf4phua86Wp0oQB3meRFz8YNGPp8/kh2m4vjJ/cMQ3uDo2opjlgNjhaEtCcisjfPSoT5By+eXg==
X-Received: by 2002:a05:6214:3c89:b0:4bb:8572:999f with SMTP id ok9-20020a0562143c8900b004bb8572999fmr10817404qvb.6.1668395183882;
        Sun, 13 Nov 2022 19:06:23 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bk40-20020a05620a1a2800b006fa4b111c76sm5738183qkb.36.2022.11.13.19.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 19:06:23 -0800 (PST)
Date:   Mon, 14 Nov 2022 03:06:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, riel@redhat.com
Subject: Re: [PATCH v8 1/9] sched/fair: fix unfairness at wakeup
Message-ID: <Y3Gwr2p5BcofuZ8e@google.com>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110175009.18458-2-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DIET_1,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Thu, Nov 10, 2022 at 06:50:01PM +0100, Vincent Guittot wrote:
> At wake up, the vruntime of a task is updated to not be more older than
> a sched_latency period behind the min_vruntime. This prevents long sleeping
> task to get unlimited credit at wakeup.
> Such waking task should preempt current one to use its CPU bandwidth but
> wakeup_gran() can be larger than sched_latency, filter out the
> wakeup preemption and as a results steals some CPU bandwidth to
> the waking task.

Just a thought: one can argue that this also hurts the running task because
wakeup_gran() is expected to not preempt the running task for a certain
minimum amount of time right?

So for example, if I set sysctl_sched_wakeup_granularity to a high value, I
expect the current task to not be preempted for that long, even if the
sched_latency cap in place_entity() makes the delta smaller than
wakeup_gran(). The place_entity() in current code is used to cap the sleep
credit, it does not really talk about preemption.

I don't mind this change, but it does change the meaning a bit of
sysctl_sched_wakeup_granularity I think.

> Make sure that a task, which vruntime has been capped, will preempt current
> task and use its CPU bandwidth even if wakeup_gran() is in the same range
> as sched_latency.

nit: I would prefer we say, instead of "is in the same range", "is greater
than". Because it got confusing a bit for me.

> If the waking task failed to preempt current it could to wait up to
> sysctl_sched_min_granularity before preempting it during next tick.
> 
> Strictly speaking, we should use cfs->min_vruntime instead of
> curr->vruntime but it doesn't worth the additional overhead and complexity
> as the vruntime of current should be close to min_vruntime if not equal.

Could we add here,
Reported-by: Youssef Esmat <youssefesmat@chromium.org>

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Just a few more comments below:

> ---
>  kernel/sched/fair.c  | 46 ++++++++++++++++++++------------------------
>  kernel/sched/sched.h | 30 ++++++++++++++++++++++++++++-
>  2 files changed, 50 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5ffec4370602..eb04c83112a0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4345,33 +4345,17 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  {
>  	u64 vruntime = cfs_rq->min_vruntime;
>  
> -	/*
> -	 * The 'current' period is already promised to the current tasks,
> -	 * however the extra weight of the new task will slow them down a
> -	 * little, place the new task so that it fits in the slot that
> -	 * stays open at the end.
> -	 */
> -	if (initial && sched_feat(START_DEBIT))
> -		vruntime += sched_vslice(cfs_rq, se);
> -
> -	/* sleeps up to a single latency don't count. */
> -	if (!initial) {
> -		unsigned long thresh;
> -
> -		if (se_is_idle(se))
> -			thresh = sysctl_sched_min_granularity;
> -		else
> -			thresh = sysctl_sched_latency;
> -
> +	if (!initial)
> +		/* sleeps up to a single latency don't count. */
> +		vruntime -= get_sched_latency(se_is_idle(se));
> +	else if (sched_feat(START_DEBIT))
>  		/*
> -		 * Halve their sleep time's effect, to allow
> -		 * for a gentler effect of sleepers:
> +		 * The 'current' period is already promised to the current tasks,
> +		 * however the extra weight of the new task will slow them down a
> +		 * little, place the new task so that it fits in the slot that
> +		 * stays open at the end.
>  		 */
> -		if (sched_feat(GENTLE_FAIR_SLEEPERS))
> -			thresh >>= 1;
> -
> -		vruntime -= thresh;
> -	}
> +		vruntime += sched_vslice(cfs_rq, se);
>  
>  	/* ensure we never gain time by being placed backwards. */
>  	se->vruntime = max_vruntime(se->vruntime, vruntime);
> @@ -7187,6 +7171,18 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>  		return -1;
>  
>  	gran = wakeup_gran(se);
> +
> +	/*
> +	 * At wake up, the vruntime of a task is capped to not be older than
> +	 * a sched_latency period compared to min_vruntime. This prevents long
> +	 * sleeping task to get unlimited credit at wakeup. Such waking up task
> +	 * has to preempt current in order to not lose its share of CPU
> +	 * bandwidth but wakeup_gran() can become higher than scheduling period
> +	 * for low priority task. Make sure that long sleeping task will get a
> +	 * chance to preempt current.
> +	 */
> +	gran = min_t(s64, gran, get_latency_max());
> +

Can we move this to wakeup_gran(se)? IMO, it belongs there because you are
adjusting the wakeup_gran().

>  	if (vdiff > gran)
>  		return 1;
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1fc198be1ffd..14879d429919 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2432,9 +2432,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
>  extern const_debug unsigned int sysctl_sched_nr_migrate;
>  extern const_debug unsigned int sysctl_sched_migration_cost;
>  
> -#ifdef CONFIG_SCHED_DEBUG
>  extern unsigned int sysctl_sched_latency;
>  extern unsigned int sysctl_sched_min_granularity;
> +#ifdef CONFIG_SCHED_DEBUG
>  extern unsigned int sysctl_sched_idle_min_granularity;
>  extern unsigned int sysctl_sched_wakeup_granularity;
>  extern int sysctl_resched_latency_warn_ms;
> @@ -2448,6 +2448,34 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
>  extern unsigned int sysctl_numa_balancing_scan_size;
>  #endif
>  
> +static inline unsigned long  get_sched_latency(bool idle)
> +{

IMO, since there are other users of sysctl_sched_latency, it would be better
to call this get_max_sleep_credit() or something.

> +	unsigned long thresh;
> +
> +	if (idle)
> +		thresh = sysctl_sched_min_granularity;
> +	else
> +		thresh = sysctl_sched_latency;
> +
> +	/*
> +	 * Halve their sleep time's effect, to allow
> +	 * for a gentler effect of sleepers:
> +	 */
> +	if (sched_feat(GENTLE_FAIR_SLEEPERS))
> +		thresh >>= 1;
> +
> +	return thresh;
> +}
> +
> +static inline unsigned long  get_latency_max(void)
> +{
> +	unsigned long thresh = get_sched_latency(false);
> +
> +	thresh -= sysctl_sched_min_granularity;

Could you clarify, why are you subtracting sched_min_granularity here? Could
you add some comments here to make it clear?

thanks,

 - Joel


> +
> +	return thresh;
> +}
> +
>  #ifdef CONFIG_SCHED_HRTICK
>  
>  /*
> -- 
> 2.17.1
> 
