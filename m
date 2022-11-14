Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C859B6288F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiKNTN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbiKNTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:13:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB5856319
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:13:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A63411FB;
        Mon, 14 Nov 2022 11:13:59 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6633F587;
        Mon, 14 Nov 2022 11:13:48 -0800 (PST)
Message-ID: <32f4a76d-103e-510f-de70-ba9dfe2356ce@arm.com>
Date:   Mon, 14 Nov 2022 20:13:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/9] sched/fair: fix unfairness at wakeup
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-2-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221110175009.18458-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 18:50, Vincent Guittot wrote:
> At wake up, the vruntime of a task is updated to not be more older than
> a sched_latency period behind the min_vruntime. This prevents long sleeping
> task to get unlimited credit at wakeup.
> Such waking task should preempt current one to use its CPU bandwidth but
> wakeup_gran() can be larger than sched_latency, filter out the
> wakeup preemption and as a results steals some CPU bandwidth to
> the waking task.
> 
> Make sure that a task, which vruntime has been capped, will preempt current
> task and use its CPU bandwidth even if wakeup_gran() is in the same range
> as sched_latency.

Looks like that gran can be nuch higher than sched_latency for extreme
cases?

> 
> If the waking task failed to preempt current it could to wait up to
> sysctl_sched_min_granularity before preempting it during next tick.
> 
> Strictly speaking, we should use cfs->min_vruntime instead of
> curr->vruntime but it doesn't worth the additional overhead and complexity
> as the vruntime of current should be close to min_vruntime if not equal.

^^^ Does this related to the `if (vdiff > gran) return 1` condition in
wakeup_preempt_entity()?

[...]

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

low priority task or taskgroup with low cpu.shares, right?

6 CPUs

sysctl_sched
  .sysctl_sched_latency              : 18.000000
  .sysctl_sched_min_granularity      : 2.250000
  .sysctl_sched_idle_min_granularity : 0.750000
  .sysctl_sched_wakeup_granularity   : 3.000000
  ...

p1 & p2 affine to CPUX

     '/'
     /\
   p1  p2

p1 & p2	nice=0	      - vdiff=9ms gran=3ms lat_max=6.75ms
p1 & p2	nice=4	      - vdiff=9ms gran=7.26ms lat_max=6.75ms
p1 & p2	nice=19	      - vdiff=9ms gran=204.79ms lat_max=6.75ms


     '/'
     /\
    A  B
   /    \
  p1    p2

A & B cpu.shares=1024 - vdiff=9ms gran=3ms lat_max=6.75ms
A & B cpu.shares=448  - vdiff=9ms gran=6.86ms lat_max=6.75ms
A & B cpu.shares=2    - vdiff=9ms gran=1536ms lat_max=6.75ms

> +	 * chance to preempt current.
> +	 */
> +	gran = min_t(s64, gran, get_latency_max());
> +

[...]

> @@ -2448,6 +2448,34 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
>  extern unsigned int sysctl_numa_balancing_scan_size;
>  #endif
>  
> +static inline unsigned long  get_sched_latency(bool idle)
                              ^^
2 white-spaces

[...]

> +
> +static inline unsigned long  get_latency_max(void)
                              ^^

[...]
