Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598FF638FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiKYS1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKYS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:27:28 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0638610572;
        Fri, 25 Nov 2022 10:27:26 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id h24so2962353qta.9;
        Fri, 25 Nov 2022 10:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaVyuL7mKrfx/MfLG1wi9jTgElLj4sZF7DF2LjomlCU=;
        b=Qq+bNtSFgwqiCgKqhrM60vZiq6Zys6JdgcDM7jL3vJDruOy9L5/gDA8+fXcpmYgfMX
         vyIlKom+rvJzQ3AtleYaHIUKQ51RZ54GHlOLPMmxRE5ZQMRaI1NvbO9uBmfRM3DZFGlP
         P+7IeoXRz/pgKqC7OKgdrtmWa1bTnSRht5DjWfRgg8aqDqr/eMUoTk6TRLmjV4HJFfPZ
         QQmaiDthDFTaqglmLFWBa2XeUS/matlDeB63wBX6B/EWiUQyqV8gzh2yYjqXPIO68kHx
         DMUJiwPzyltT/3Nb0mcPwoAFveRUKhvhnLcIrnZDUogb+9u2rmYZtAoHZG65qFh/A5VN
         vyjQ==
X-Gm-Message-State: ANoB5pkK+ZrR7ICkWcSLwtgYyahxbahGfAVFD0LCk46w9nrni69Setdg
        J+aiAe+cBXKmUQPp0i+WnpzVlGPR93TRGpOpG8E=
X-Google-Smtp-Source: AA0mqf6UlCs0QIUDn50HzsSvOw/6dL0421WXAcMOobtGBuidsFBscyjKb25hb/w6Xo+O60UEY50+QeEOXUP0XtbJITc=
X-Received: by 2002:ac8:1482:0:b0:3a5:1e6f:7e05 with SMTP id
 l2-20020ac81482000000b003a51e6f7e05mr19290235qtj.357.1669400845061; Fri, 25
 Nov 2022 10:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20221031121314.1381472-1-kajetan.puchalski@arm.com> <20221031121314.1381472-3-kajetan.puchalski@arm.com>
In-Reply-To: <20221031121314.1381472-3-kajetan.puchalski@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Nov 2022 19:27:13 +0100
Message-ID: <CAJZ5v0hHvf-033Oa-nW7UEZq=9cTFzn6e_znccPXBUeNa=YY+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] cpuidle: teo: Introduce util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 1:14 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Modern interactive systems, such as recent Android phones, tend to have
> power efficient shallow idle states. Selecting deeper idle states on a
> device while a latency-sensitive workload is running can adversely impact
> performance due to increased latency. Additionally, if the CPU wakes up
> from a deeper sleep before its target residency as is often the case, it
> results in a waste of energy on top of that.
>
> This patch extends the TEO governor with a mechanism adding util-awareness,
> effectively providing a way for the governor to reduce the selected idle
> state by 1 when the CPU is being utilized over a certain threshold while
> still trying to select the deepest possible state using TEO's metrics when
> the CPU is not being utilized. This is now possible since the CPU
> utilization is exported from the scheduler with the sched_cpu_util function
> and already used e.g. in the thermal governor IPA.
>
> Under this implementation, when the CPU is being utilised and the
> selected candidate state is C1, it will be reduced to C0 as long as C0
> is not a polling state. This effectively should make the patch have no
> effect on most Intel systems.
>
> This can provide drastically decreased latency and performance benefits in
> certain types of mobile workloads that are sensitive to latency,
> such as Geekbench 5.
>
> Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> ---
>  drivers/cpuidle/governors/teo.c | 84 ++++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index e2864474a98d..0f38b3ecab3c 100644
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
> @@ -99,14 +104,49 @@
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
> + * TEO metrics mechanism. If it's above and the currently selected candidate is
> + * C1, the idle state will be reduced to C0 as long as C0 is not a polling state.
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
> + * the utilized threshold
> + */
> +#define UTIL_THRESHOLD_SHIFT 6

Why is this particular number regarded as the best one?

> +
> +
>  /*
>   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
>   * is used for decreasing metrics on a regular basis.
> @@ -137,9 +177,11 @@ struct teo_bin {
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
> @@ -148,10 +190,24 @@ struct teo_cpu {
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
> +       unsigned long util = sched_cpu_util(dev->cpu);
> +
> +       cpu_data->utilized = util > cpu_data->util_threshold;

Why exactly do you need the local variable here?

Then, if there's only one caller, maybe this could be folded into it?

> +}
> +
>  /**
>   * teo_update - Update CPU metrics after wakeup.
>   * @drv: cpuidle driver containing state data.
> @@ -303,7 +359,9 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         int i;
>
>         if (dev->last_state_idx >= 0) {
> -               teo_update(drv, dev);
> +               /* don't update metrics if the cpu was utilized during the last sleep */

Why?

The metrics are related to idle duration and cpu_data->utilized
indicates whether or not latency should be reduced.  These are
different things.

Moreover, this is just one data point and there may not be any direct
connection between it and the decision made in this particular cycle.

> +               if (!cpu_data->utilized)
> +                       teo_update(drv, dev);
>                 dev->last_state_idx = -1;
>         }
>
> @@ -323,6 +381,21 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                         goto end;
>         }
>
> +       teo_get_util(dev, cpu_data);
> +       /* the cpu is being utilized and there's only 2 states to choose from */
> +       /* no need to consider metrics, choose the shallowest non-polling state and exit */

A proper kernel-coding-style 2-line comment, please!

Also I would say "utilized beyond the threshold" instead of just
"utilized" and "there are only 2 states" (plural).

> +       if (drv->state_count < 3 && cpu_data->utilized) {
> +               for (i = 0; i < drv->state_count; ++i) {
> +                       if (dev->states_usage[i].disable ||
> +                                       drv->states[i].flags & CPUIDLE_FLAG_POLLING)
> +                               continue;
> +                       break;

This looks odd.  It would be more straightforward to do

if (!dev->states_usage[i].disable && !(drv->states[i].flags &
CPUIDLE_FLAG_POLLING)) {
        idx = i;
        goto end;
}

without the "break" and "continue".

> +               }
> +
> +               idx = i;
> +               goto end;
> +       }
> +
>         /*
>          * Find the deepest idle state whose target residency does not exceed
>          * the current sleep length and the deepest idle state not deeper than
> @@ -454,6 +527,11 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         if (idx > constraint_idx)
>                 idx = constraint_idx;
>
> +       /* if the CPU is being utilized and C1 is the selected candidate */
> +       /* choose a shallower non-polling state to improve latency */

Again, the kernel coding style for multi-line comments is different
from the above.

> +       if (cpu_data->utilized && idx == 1)

I've changed my mind with respect to adding the idx == 1 check to
this.  If the goal is to reduce latency for the "loaded" CPUs, this
applies to deeper idle states too.

> +               idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
> +
>  end:
>         /*
>          * Don't stop the tick if the selected state is a polling one or if the
> @@ -510,9 +588,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
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
