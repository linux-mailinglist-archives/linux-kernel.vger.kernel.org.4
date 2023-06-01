Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C703719B56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjFAL5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjFAL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:56:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1833FC;
        Thu,  1 Jun 2023 04:56:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7B9E1063;
        Thu,  1 Jun 2023 04:57:41 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 156C23F7D8;
        Thu,  1 Jun 2023 04:56:53 -0700 (PDT)
Message-ID: <6ba5e4bc-dfb9-dccf-d075-f7bde831acf6@arm.com>
Date:   Thu, 1 Jun 2023 13:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 1/2] sched/deadline: Fix bandwidth reclaim equation in
 GRUB
Content-Language: en-US
To:     Vineeth Pillai <vineeth@bitbyteword.org>,
        luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230530135526.2385378-1-vineeth@bitbyteword.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230530135526.2385378-1-vineeth@bitbyteword.org>
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

On 30/05/2023 15:55, Vineeth Pillai wrote:

[...]

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 71b24371a6f7..dfb59a363560 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1260,43 +1260,39 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
>  }
>  
>  /*
> - * This function implements the GRUB accounting rule:
> - * according to the GRUB reclaiming algorithm, the runtime is
> - * not decreased as "dq = -dt", but as
> - * "dq = -max{u / Umax, (1 - Uinact - Uextra)} dt",
> + * This function implements the GRUB accounting rule. According to the
> + * GRUB reclaiming algorithm, the runtime is not decreased as "dq = -dt",
> + * but as "dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt",
>   * where u is the utilization of the task, Umax is the maximum reclaimable
>   * utilization, Uinact is the (per-runqueue) inactive utilization, computed
>   * as the difference between the "total runqueue utilization" and the
> - * runqueue active utilization, and Uextra is the (per runqueue) extra
> + * "runqueue active utilization", and Uextra is the (per runqueue) extra
>   * reclaimable utilization.
> - * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations
> - * multiplied by 2^BW_SHIFT, the result has to be shifted right by
> - * BW_SHIFT.
> - * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT,
> - * dl_bw is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.
> - * Since delta is a 64 bit variable, to have an overflow its value
> - * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
> - * So, overflow is not an issue here.
> + * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations multiplied
> + * by 2^BW_SHIFT, the result has to be shifted right by BW_SHIFT.
> + * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT, dl_bw
> + * is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.

nit-pick:

s/multiped/multiplied

> + * Since delta is a 64 bit variable, to have an overflow its value should be
> + * larger than 2^(64 - 20 - 8), which is more than 64 seconds. So, overflow is
> + * not an issue here.
>   */
>  static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
>  {
> -	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
>  	u64 u_act;
> -	u64 u_act_min = (dl_se->dl_bw * rq->dl.bw_ratio) >> RATIO_SHIFT;
> +	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
>  
>  	/*
> -	 * Instead of computing max{u * bw_ratio, (1 - u_inact - u_extra)},
> -	 * we compare u_inact + rq->dl.extra_bw with
> -	 * 1 - (u * rq->dl.bw_ratio >> RATIO_SHIFT), because
> -	 * u_inact + rq->dl.extra_bw can be larger than
> -	 * 1 * (so, 1 - u_inact - rq->dl.extra_bw would be negative
> -	 * leading to wrong results)
> +	 * Instead of computing max{u, (u_max - u_inact - u_extra)}, we
> +	 * compare u_inact + u_extra with u_max - u, because u_inact + u_extra
> +	 * can be larger than u_max. So, u_max - u_inact - u_extra would be
> +	 * negative leading to wrong results.
>  	 */
> -	if (u_inact + rq->dl.extra_bw > BW_UNIT - u_act_min)
> -		u_act = u_act_min;
> +	if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
> +		u_act = dl_se->dl_bw;
>  	else
> -		u_act = BW_UNIT - u_inact - rq->dl.extra_bw;
> +		u_act = rq->dl.max_bw - u_inact - rq->dl.extra_bw;
>  
> +	u_act = (u_act * rq->dl.bw_ratio) >> RATIO_SHIFT;
>  	return (delta * u_act) >> BW_SHIFT;
>  }
>  
> @@ -2784,12 +2780,12 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
>  {
>  	if (global_rt_runtime() == RUNTIME_INF) {
>  		dl_rq->bw_ratio = 1 << RATIO_SHIFT;
> -		dl_rq->extra_bw = 1 << BW_SHIFT;
> +		dl_rq->max_bw = dl_rq->extra_bw = 1 << BW_SHIFT;
>  	} else {
>  		dl_rq->bw_ratio = to_ratio(global_rt_runtime(),
>  			  global_rt_period()) >> (BW_SHIFT - RATIO_SHIFT);
> -		dl_rq->extra_bw = to_ratio(global_rt_period(),
> -						    global_rt_runtime());
> +		dl_rq->max_bw = dl_rq->extra_bw =
> +			to_ratio(global_rt_period(), global_rt_runtime());
>  	}
>  }
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3e8df6d31c1e..73027c2806dc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -753,6 +753,12 @@ struct dl_rq {
>  	u64			this_bw;
>  	u64			extra_bw;
>  
> +	/*
> +	 * Maximum available bandwidth for reclaiming by SCHED_FLAG_RECLAIM
> +	 * tasks of this rq. Used in calculation of reclaimable bandwidth(GRUB).
> +	 */
> +	u64			max_bw;
> +
>  	/*
>  	 * Inverse of the fraction of CPU utilization that can be reclaimed
>  	 * by the GRUB algorithm.

Not related to this patch directly but I still can't see how `GRUB-PA`
with schedutil CPUfreq governor should work together with GRUB reclaiming.

CPU frequency is influenced by Uact (rq->dl.running_bw):

sugov_get_util() -> effective_cpu_util() -> cpu_bw_dl() ->

      return rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT

But the extra GRUB reclaim runtime is calculated based on rq->dl.max_bw
and AFAICS, Uact is not adjusted by scaled_delta_exec?

