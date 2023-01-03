Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFA765C56B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbjACRx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjACRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:53:25 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7896DFF8;
        Tue,  3 Jan 2023 09:53:23 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id c17so44884550edj.13;
        Tue, 03 Jan 2023 09:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yg2p20sRPsdHsHMZt9NiS74vzGodLyKsz6n52FTmH/s=;
        b=LW9p7PSmfhgwxpNkBRbpT4AfOz5kfhPQZ6d7Gjmz6MCst4j0C5iqEt7JySZLmhnGNR
         /INLf+gDrX8kHkhOBuSn1IED76rZZ6537PX46UARNpmBZ8M1a4wlr69Jj1zg78cvkNTe
         WXsRR33iigcH5lYDhkkB5hKIS7k8WgsA2MlkV0BqLGheM8J52PORnW11+omQaF0MRR9P
         5K0RuVdp+Ppz1o+Kn0z26sSZ+qpzH6Y0v4N6UGjQK6QrhWFHtgVKKOecDJNS7NeSfdC5
         6ZUx8AVUkcKSgYgL8MBXr3RLS+JRzsItFd4BdI/2OWkceX9QcFLknWagm+fKIxeXVfL6
         p7DA==
X-Gm-Message-State: AFqh2krTZTM3c2Oau379//gqJh7n9XVvjDJ5qGHkn+uh190Ebr48gawt
        iAarsUFc/Ul1Ji7yuJHixuh6AKZXGY3gOAmkfHs=
X-Google-Smtp-Source: AMrXdXvCDZdcEaQwBFOAJ2W0evUrm0fMInxFF0og1wfC3h5y0D/XQ3CsYmaQQWSQFpD2AoA1ydGcCsnHjhqjbJppuz0=
X-Received: by 2002:a50:d0d1:0:b0:47c:4498:67b1 with SMTP id
 g17-20020a50d0d1000000b0047c449867b1mr4646537edf.26.1672768402078; Tue, 03
 Jan 2023 09:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20221130153204.2085591-1-kajetan.puchalski@arm.com> <20221130153204.2085591-3-kajetan.puchalski@arm.com>
In-Reply-To: <20221130153204.2085591-3-kajetan.puchalski@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Jan 2023 18:53:10 +0100
Message-ID: <CAJZ5v0jXkKTUsA1Pdis7T9qzYZBiRFnpJ+AwE3zEuAHNR_=K3A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] cpuidle: teo: Introduce util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 4:33 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Modern interactive systems, such as recent Android phones, tend to have power
> efficient shallow idle states. Selecting deeper idle states on a device while a
> latency-sensitive workload is running can adversely impact performance due to
> increased latency. Additionally, if the CPU wakes up from a deeper sleep before
> its target residency as is often the case, it results in a waste of energy on
> top of that.
>
> At the moment, all the available idle governors operate mainly based on their
> own past correctness metrics along with timer events without taking into account
> any scheduling information.

I still don't quite agree with the above statement.

It would be accurate enough to state the fact that currently cpuidle
governors don't take scheduling information into account.

> Especially on interactive systems, this results in
> them frequently selecting a deeper idle state and then waking up before its
> target residency is hit, thus leading to increased wakeup latency and lower
> performance with no power saving. For 'menu' while web browsing on Android for
> instance, those types of wakeups ('too deep') account for over 24% of all
> wakeups.

I don't think that you can convincingly establish a cause-and-effect
relationship between not taking scheduling information into account
and overestimating the idle duration.

It would be just fine to say something like "They also tend to
overestimate the idle duration quite often, which causes them to
select excessively deep idle states, which leads to ...".

> At the same time, on some platforms C0 can be power efficient enough to warrant
> wanting to prefer it over C1.

If you say C0 or C1, a casual reader may think about x86 which
probably is not your intention.

I would say "idle state 0" and "idle state 1" instead.  I would also
say that this is on systems where idle state 0 is not a polling state.

> This is because the power usage of the two states
> can be so close that sufficient amounts of too deep C1 sleeps can completely
> offset the C1 power saving to the point where it would've been more power
> efficient to just use C0 instead.
>
> Sleeps that happened in C0 while they could have used C1 ('too shallow') only
> save less power than they otherwise could have. Too deep sleeps, on the other
> hand, harm performance and nullify the potential power saving from using C1 in
> the first place. While taking this into account, it is clear that on balance it
> is preferable for an idle governor to have more too shallow sleeps instead of
> more too deep sleeps on those kinds of platforms.

I don't think that the above paragraphs, while generally true, are
relevant for what the patch really does.

They would have been relevant if the patch had improved the
energy-efficiency, but it doesn't.  It sacrifices energy for
performance by reducing the CPU wakeup latency.

> This patch specifically tunes TEO to minimise too deep sleeps and minimise
> latency to achieve better performance.

I'm not sure if you can demonstrate that the number of "too deep
sleeps" is really reduced in all cases, but the reduction of latency
is readily demonstrable, so I would focus on that part.

> To this end, before selecting the next
> idle state it uses the avg_util signal of a CPU's runqueue in order to determine
> to what extent the CPU is being utilized. This util value is then compared to a
> threshold defined as a percentage of the cpu's capacity (capacity >> 6 ie. ~1.5%
> in the current implementation). If the util is above the threshold, the
> idle state selected by TEO metrics will be reduced by 1, thus selecting a
> shallower state. If the util is below the threshold, the governor defaults to
> the TEO metrics mechanism to try to select the deepest available idle state
> based on the closest timer event and its own correctness.
>
> The main goal of this is to reduce latency and increase performance for some
> workloads. Under some workloads it will result in an increase in power usage
> (Geekbench 5) while for other workloads it will also result in a decrease in
> power usage compared to TEO (PCMark Web, Jankbench, Speedometer).
>
> It can provide drastically decreased latency and performance benefits in certain
> types of workloads that are sensitive to latency.

And I would put some numbers from your cover letter in here.

> Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> ---
>  drivers/cpuidle/governors/teo.c | 85 ++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index e2864474a98d..2f85dde301d3 100644
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

I don't think the above change is really useful.  At least it is not
necessary for any practical purpose.

See the copyright notice in the schedutil governor, for example: it
hasn't changed since the introduction of it even though many people
have changed it substantially since then.

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

I would say "energy saving" instead of "power saving", as the former
is technically more accurate.

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

Again, I would avoid the C0 etc terminology here, because it may
confuse people easily enough.

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

Please spell CPU in capitals.

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

This spell fix is unrelated to the rest of the patch.  It should be
covered in the changelog at least, but IMV it;s just better to put it
into a separate patch.

>   * @next_recent_idx: Index of the next @recent_idx entry to update.
>   * @recent_idx: Indices of bins corresponding to recent "intercepts".
> + * @util_threshold: Threshold above which the CPU is considered utilized
> + * @utilized: Whether the last sleep on the CPU happened while utilized
>   */
>  struct teo_cpu {
>         s64 time_span_ns;
> @@ -148,10 +196,22 @@ struct teo_cpu {
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
> + * teo_get_util - Update the CPU utilized status
> + * @dev: Target CPU
> + * @cpu_data: Governor CPU data for the target CPU
> + */
> +static void teo_get_util(struct cpuidle_device *dev, struct teo_cpu *cpu_data)
> +{
> +       cpu_data->utilized = sched_cpu_util(dev->cpu) > cpu_data->util_threshold;
> +}
> +

This has been covered by the earlier message from today.

>  /**
>   * teo_update - Update CPU metrics after wakeup.
>   * @drv: cpuidle driver containing state data.
> @@ -323,6 +383,20 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                         goto end;
>         }
>
> +       teo_get_util(dev, cpu_data);

And this too.

> +       /*
> +        * The cpu is being utilized over the threshold there are only 2 states to choose from.

I would say "If the CPU is being utilized over the threshold and there
are only 2 states to choose from,"

> +        * No need to consider metrics, choose the shallowest non-polling state and exit.

"the shallower one can be returned right away as long as it is not a
polling one".

> +        */
> +       if (drv->state_count < 3 && cpu_data->utilized) {

I would reverse the order of checks here, so the code and the comment
match each other exactly.

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
> @@ -454,6 +528,13 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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
> @@ -510,9 +591,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
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
