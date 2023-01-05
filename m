Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A37465EFAA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjAEPHn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Jan 2023 10:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjAEPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:07:26 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C74D4B7;
        Thu,  5 Jan 2023 07:07:25 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id i15so53261843edf.2;
        Thu, 05 Jan 2023 07:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EvzQ9NReWTpvxEbf/MJbNj6JET40H8uLRnczHNCAzo=;
        b=FbrB2eUJIR0UXaKJyPxtGPfSgqcsG3YqVUGQvi2KTUZcaIl4NC+uOuvDmj+EqAzQ+l
         iqEZyx2DoboG6JOl4byDMhMOoiwaTRdtBh99wmsEiJ7CzrkA4IiUa/2daqGqMlYi5bHU
         fcX1H7+rSPwDVA2i/EykmduKkuJ9Q6fBBfNOLt0w6AZ5+kgOVx1ZGRT400y2jnP/yNyt
         h/3Q8tzk+1znKTFoujgcQVmzh1DXCrbpyFLUiT7PIqr9DGsxbL6JOdH6vlSuj0cil5nD
         0/hAEEbAICkLoN6E+aU1c9NjfZXBEbcEIxH4u1sA7c1Z/fs6KY+8qaYaDs+WEFxJAKC3
         ZaCg==
X-Gm-Message-State: AFqh2koxld65M4jnhW5Scwc648JCLvK3Vdn3N3QPywC1pUblk0i3NBc7
        nIvgqSAMWpvlhMizhq/c0YDdqtY6mBiF6fiI7oTDx6pEArc=
X-Google-Smtp-Source: AMrXdXvkeM789B+NasjEEU44Lf5naWzH6LjbZNQI+D1WdBIdhCKsSa2YkVYe6EC9yWutBUmMAxxBZ/eu+LJMSEU7FCs=
X-Received: by 2002:a50:ab4b:0:b0:46a:b1a9:c34e with SMTP id
 t11-20020a50ab4b000000b0046ab1a9c34emr7037774edc.212.1672931243573; Thu, 05
 Jan 2023 07:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com> <20230105145159.1089531-3-kajetan.puchalski@arm.com>
In-Reply-To: <20230105145159.1089531-3-kajetan.puchalski@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jan 2023 16:07:09 +0100
Message-ID: <CAJZ5v0i1MrgkRPiMEPeZBuFmx24D-JaWTwmdCTeBVPmretL7VA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 3:52 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Modern interactive systems, such as recent Android phones, tend to have power
> efficient shallow idle states. Selecting deeper idle states on a device while a
> latency-sensitive workload is running can adversely impact performance due to
> increased latency. Additionally, if the CPU wakes up from a deeper sleep before
> its target residency as is often the case, it results in a waste of energy on
> top of that.
>
> At the moment, none of the available idle governors take any scheduling
> information into account. They also tend to overestimate the idle
> duration quite often, which causes them to select excessively deep idle
> states, thus leading to increased wakeup latency and lower performance with no
> power saving. For 'menu' while web browsing on Android for instance, those
> types of wakeups ('too deep') account for over 24% of all wakeups.
>
> At the same time, on some platforms idle state 0 can be power efficient
> enough to warrant wanting to prefer it over idle state 1. This is because
> the power usage of the two states can be so close that sufficient amounts
> of too deep state 1 sleeps can completely offset the state 1 power saving to the
> point where it would've been more power efficient to just use state 0 instead.
> This is of course for systems where state 0 is not a polling state, such as
> arm-based devices.
>
> Sleeps that happened in state 0 while they could have used state 1 ('too shallow') only
> save less power than they otherwise could have. Too deep sleeps, on the other
> hand, harm performance and nullify the potential power saving from using state 1 in
> the first place. While taking this into account, it is clear that on balance it
> is preferable for an idle governor to have more too shallow sleeps instead of
> more too deep sleeps on those kinds of platforms.
>
> This patch specifically tunes TEO to prefer shallower idle states in
> order to reduce wakeup latency and achieve better performance.
> To this end, before selecting the next idle state it uses the avg_util signal
> of a CPU's runqueue in order to determine to what extent the CPU is being utilized.
> This util value is then compared to a threshold defined as a percentage of the
> cpu's capacity (capacity >> 6 ie. ~1.5% in the current implementation). If the
> util is above the threshold, the idle state selected by TEO metrics will be
> reduced by 1, thus selecting a shallower state. If the util is below the threshold,
> the governor defaults to the TEO metrics mechanism to try to select the deepest
> available idle state based on the closest timer event and its own correctness.
>
> The main goal of this is to reduce latency and increase performance for some
> workloads. Under some workloads it will result in an increase in power usage
> (Geekbench 5) while for other workloads it will also result in a decrease in
> power usage compared to TEO (PCMark Web, Jankbench, Speedometer).
>
> It can provide drastically decreased latency and performance benefits in certain
> types of workloads that are sensitive to latency.
>
> Example test results:
>
> 1. GB5 (better score, latency & more power usage)
>
> | metric                                | menu           | teo               | teo-util-aware    |
> | ------------------------------------- | -------------- | ----------------- | ----------------- |
> | gmean score                           | 2826.5 (0.0%)  | 2764.8 (-2.18%)   | 2865 (1.36%)      |
> | gmean power usage [mW]                | 2551.4 (0.0%)  | 2606.8 (2.17%)    | 2722.3 (6.7%)     |
> | gmean too deep %                      | 14.99%         | 9.65%             | 4.02%             |
> | gmean too shallow %                   | 2.5%           | 5.96%             | 14.59%            |
> | gmean task wakeup latency (asynctask) | 78.16μs (0.0%) | 61.60μs (-21.19%) | 54.45μs (-30.34%) |
>
> 2. Jankbench (better score, latency & less power usage)
>
> | metric                                | menu           | teo               | teo-util-aware    |
> | ------------------------------------- | -------------- | ----------------- | ----------------- |
> | gmean frame duration                  | 13.9 (0.0%)    | 14.7 (6.0%)       | 12.6 (-9.0%)      |
> | gmean jank percentage                 | 1.5 (0.0%)     | 2.1 (36.99%)      | 1.3 (-17.37%)     |
> | gmean power usage [mW]                | 144.6 (0.0%)   | 136.9 (-5.27%)    | 121.3 (-16.08%)   |
> | gmean too deep %                      | 26.00%         | 11.00%            | 2.54%             |
> | gmean too shallow %                   | 4.74%          | 11.89%            | 21.93%            |
> | gmean wakeup latency (RenderThread)   | 139.5μs (0.0%) | 116.5μs (-16.49%) | 91.11μs (-34.7%)  |
> | gmean wakeup latency (surfaceflinger) | 124.0μs (0.0%) | 151.9μs (22.47%)  | 87.65μs (-29.33%) |
>
> Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>

This looks good enough for me.

There are still a couple of things I would change in it, but I may as
well do that when applying it, so never mind.

The most important question for now is what the scheduler people think
about calling sched_cpu_util() from a CPU idle governor.  Peter,
Vincent?

> ---
>  drivers/cpuidle/governors/teo.c | 92 ++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index e2864474a98d..2a2be4f45b70 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -2,8 +2,13 @@
>  /*
>   * Timer events oriented CPU idle governor
>   *
> + * TEO governor:
>   * Copyright (C) 2018 - 2021 Intel Corporation
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> + *
> + * Util-awareness mechanism:
> + * Copyright (C) 2022 Arm Ltd.
> + * Author: Kajetan Puchalski <kajetan.puchalski@arm.com>
>   */
>
>  /**
> @@ -99,14 +104,55 @@
>   *      select the given idle state instead of the candidate one.
>   *
>   * 3. By default, select the candidate state.
> + *
> + * Util-awareness mechanism:
> + *
> + * The idea behind the util-awareness extension is that there are two distinct
> + * scenarios for the CPU which should result in two different approaches to idle
> + * state selection - utilized and not utilized.
> + *
> + * In this case, 'utilized' means that the average runqueue util of the CPU is
> + * above a certain threshold.
> + *
> + * When the CPU is utilized while going into idle, more likely than not it will
> + * be woken up to do more work soon and so a shallower idle state should be
> + * selected to minimise latency and maximise performance. When the CPU is not
> + * being utilized, the usual metrics-based approach to selecting the deepest
> + * available idle state should be preferred to take advantage of the power
> + * saving.
> + *
> + * In order to achieve this, the governor uses a utilization threshold.
> + * The threshold is computed per-cpu as a percentage of the CPU's capacity
> + * by bit shifting the capacity value. Based on testing, the shift of 6 (~1.56%)
> + * seems to be getting the best results.
> + *
> + * Before selecting the next idle state, the governor compares the current CPU
> + * util to the precomputed util threshold. If it's below, it defaults to the
> + * TEO metrics mechanism. If it's above, the idle state will be reduced to C0
> + * as long as C0 is not a polling state.
>   */
>
>  #include <linux/cpuidle.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/sched.h>
>  #include <linux/sched/clock.h>
> +#include <linux/sched/topology.h>
>  #include <linux/tick.h>
>
> +/*
> + * The number of bits to shift the cpu's capacity by in order to determine
> + * the utilized threshold.
> + *
> + * 6 was chosen based on testing as the number that achieved the best balance
> + * of power and performance on average.
> + *
> + * The resulting threshold is high enough to not be triggered by background
> + * noise and low enough to react quickly when activity starts to ramp up.
> + */
> +#define UTIL_THRESHOLD_SHIFT 6
> +
> +
>  /*
>   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
>   * is used for decreasing metrics on a regular basis.
> @@ -137,9 +183,11 @@ struct teo_bin {
>   * @time_span_ns: Time between idle state selection and post-wakeup update.
>   * @sleep_length_ns: Time till the closest timer event (at the selection time).
>   * @state_bins: Idle state data bins for this CPU.
> - * @total: Grand total of the "intercepts" and "hits" mertics for all bins.
> + * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
>   * @next_recent_idx: Index of the next @recent_idx entry to update.
>   * @recent_idx: Indices of bins corresponding to recent "intercepts".
> + * @util_threshold: Threshold above which the CPU is considered utilized
> + * @utilized: Whether the last sleep on the CPU happened while utilized
>   */
>  struct teo_cpu {
>         s64 time_span_ns;
> @@ -148,10 +196,29 @@ struct teo_cpu {
>         unsigned int total;
>         int next_recent_idx;
>         int recent_idx[NR_RECENT];
> +       unsigned long util_threshold;
> +       bool utilized;
>  };
>
>  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
>
> +/**
> + * teo_cpu_is_utilized - Check if the CPU's util is above the threshold
> + * @cpu: Target CPU
> + * @cpu_data: Governor CPU data for the target CPU
> + */
> +#ifdef CONFIG_SMP
> +static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
> +{
> +       return sched_cpu_util(cpu) > cpu_data->util_threshold;
> +}
> +#else
> +static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
> +{
> +       return false;
> +}
> +#endif
> +
>  /**
>   * teo_update - Update CPU metrics after wakeup.
>   * @drv: cpuidle driver containing state data.
> @@ -323,6 +390,20 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                         goto end;
>         }
>
> +       cpu_data->utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
> +       /*
> +        * The cpu is being utilized over the threshold there are only 2 states to choose from.
> +        * No need to consider metrics, choose the shallowest non-polling state and exit.
> +        */
> +       if (drv->state_count < 3 && cpu_data->utilized) {
> +               for (i = 0; i < drv->state_count; ++i) {
> +                       if (!dev->states_usage[i].disable && !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
> +                               idx = i;
> +                               goto end;
> +                       }
> +               }
> +       }
> +
>         /*
>          * Find the deepest idle state whose target residency does not exceed
>          * the current sleep length and the deepest idle state not deeper than
> @@ -454,6 +535,13 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         if (idx > constraint_idx)
>                 idx = constraint_idx;
>
> +       /*
> +        * If the CPU is being utilized over the threshold,
> +        * choose a shallower non-polling state to improve latency
> +        */
> +       if (cpu_data->utilized)
> +               idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
> +
>  end:
>         /*
>          * Don't stop the tick if the selected state is a polling one or if the
> @@ -510,9 +598,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
>                              struct cpuidle_device *dev)
>  {
>         struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> +       unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
>         int i;
>
>         memset(cpu_data, 0, sizeof(*cpu_data));
> +       cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
>
>         for (i = 0; i < NR_RECENT; i++)
>                 cpu_data->recent_idx[i] = -1;
> --
> 2.37.1
>
