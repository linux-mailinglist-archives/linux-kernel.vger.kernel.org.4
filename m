Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96638709E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjESR4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESR4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:56:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7771E110;
        Fri, 19 May 2023 10:56:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED4EC1FB;
        Fri, 19 May 2023 10:57:26 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7E5F3F59C;
        Fri, 19 May 2023 10:56:39 -0700 (PDT)
Message-ID: <f5801f5b-6ee8-6b84-b6bb-46e89b165091@arm.com>
Date:   Fri, 19 May 2023 19:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
Content-Language: en-US
To:     Vineeth Pillai <vineeth@bitbyteword.org>,
        luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
 <20230515025716.316888-3-vineeth@bitbyteword.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230515025716.316888-3-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineeth,

On 15/05/2023 04:57, Vineeth Pillai wrote:
> In a multi-processor system, bandwidth usage is divided equally to
> all cpus. This causes issues with reclaiming free bandwidth on a cpu.
> "Uextra" is same on all cpus in a root domain and running_bw would be
> different based on the reserved bandwidth of tasks running on the cpu.
> This causes disproportionate reclaiming - task with lesser bandwidth
> reclaims less even if its the only task running on that cpu.
> 
> Following is a small test with three tasks with reservations (8,10)
> (1,10) and (1, 100). These three tasks run on different cpus. But
> since the reclamation logic calculates available bandwidth as a factor
> of globally available bandwidth, tasks with lesser bandwidth reclaims
> only little compared to higher bandwidth even if cpu has free and
> available bandwidth to be reclaimed.
> 
> TID[730]: RECLAIM=1, (r=8ms, d=10ms, p=10ms), Util: 95.05
> TID[731]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 31.34
> TID[732]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 3.16

What does this 'Util: X' value stand for? I assume it's the utilization
of the task? How do you obtain it?

I see that e.g. TID[731] should run 1ms each 10ms w/o grub and with grub
the runtime could be potentially longer since 'scaled_delta_exec < delta'.

I don't get this comment in update_curr_dl():

1325    /*
1326     * For tasks that participate in GRUB, we implement GRUB-PA: the
1327     * spare reclaimed bandwidth is used to clock down frequency.
1328     *

It looks like dl_se->runtime is affected and with 'scaled_delta_exec <
delta' the task runs longer than dl_se->dl_runtime?

> Fix: use the available bandwidth on each cpu to calculate reclaimable
> bandwidth. Admission control takes care of total bandwidth and hence
> using the available bandwidth on a specific cpu would not break the
> deadline guarentees.
> 
> With this fix, the above test behaves as follows:
> TID[586]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.24
> TID[585]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 95.01
> TID[584]: RECLAIM=1, (r=8ms, d=10ms, p=10ms), Util: 95.01
> 
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> ---
>  kernel/sched/deadline.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 91451c1c7e52..85902c4c484b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1272,7 +1272,7 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
>   *	Umax:		Max usable bandwidth for DL. Currently
>   *			= sched_rt_runtime_us / sched_rt_period_us
>   *	Uextra:		Extra bandwidth not reserved:
> - *			= Umax - \Sum(u_i / #cpus in the root domain)
> + *			= Umax - this_bw
>   *	u_i:		Bandwidth of an admitted dl task in the
>   *			root domain.
>   *
> @@ -1286,22 +1286,14 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
>   */
>  static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
>  {
> -	u64 u_act;
> -	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
> -
>  	/*
> -	 * Instead of computing max{u, (rq->dl.max_bw - u_inact - u_extra)},
> -	 * we compare u_inact + rq->dl.extra_bw with
> -	 * rq->dl.max_bw - u, because u_inact + rq->dl.extra_bw can be larger
> -	 * than rq->dl.max_bw (so, rq->dl.max_bw - u_inact - rq->dl.extra_bw
> -	 * would be negative leading to wrong results)
> +	 * max{u, Umax - Uinact - Uextra}
> +	 * = max{u, max_bw - (this_bw - running_bw) + (this_bw - running_bw)}
> +	 * = max{u, running_bw} = running_bw
> +	 * So dq = -(max{u, Umax - Uinact - Uextra} / Umax) dt
> +	 *       = -(running_bw / max_bw) dt
>  	 */
> -	if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
> -		u_act = dl_se->dl_bw;
> -	else
> -		u_act = rq->dl.max_bw - u_inact - rq->dl.extra_bw;
> -
> -	return div64_u64(delta * u_act, rq->dl.max_bw);
> +	return div64_u64(delta * rq->dl.running_bw, rq->dl.max_bw);

I did the test discussed later in this thread with:

3 [3/100] tasks (dl_se->dl_bw = (3 << 20)/100 = 31457) on 3 CPUs

factor = scaled_delta_exec/delta

- existing grub

rq->dl.bw_ratio = ( 100 << 8 ) / 95 = 269
rq->dl.extra_bw = ( 95 << 20 ) / 100 = 996147

cpu=2 curr->[thread0-2 1715] delta=2140100 this_bw=31457
running_bw=31457 extra_bw=894788 u_inact=0 u_act_min=33054 u_act=153788
scaled_delta_exec=313874 factor=0.14

- your solution patch [1-2]

cpu=2 curr->[thread0-0 1676] delta=157020 running_bw=31457 max_bw=996147
res=4958 factor=0.03

You say that GRUB calculation is inaccurate and that this inaccuracy
gets larger as the bandwidth of tasks becomes smaller.

Could you explain this inaccuracy on this example?
