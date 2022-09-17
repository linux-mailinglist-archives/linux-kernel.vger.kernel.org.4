Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536C85BBAE7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 00:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIQW7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 18:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIQW67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 18:58:59 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF28D2C12C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 15:58:57 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k2so26348702vsk.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fQCRqwRwSbH5iwt/zl8RAPBM4K0Cy36tb7dQhI6/CV8=;
        b=WbAKpcTH79LH4dLkR9XbQgQXap0ap2tJlFozCDO9hEbAOwmV5EgVXOIycau5GNpoq4
         HA2iK8+1KOCdKN3TWWqJTfIa6p7KVDzdekyr0fEwVBGbNBZYl1brt0gnU3AODSt+dHzv
         qRzPnb6Yw9icblmY7DQgzD0IUQCBeze5E/pqVgmxDVVfwNBCpt9kOcWsuYR4CLJthoFn
         K08rY3TWdBnubw+4Lm5DmGFxA90LaSOzbwxgYAqD63YMGVysMtl0/0D+o8NyXZbLlw6R
         +JNdVgDFnWto5flXF8FPgMSlnHZCM+J+cSebS2B0eJB0l6lBSZY7fVZkNOhwPXYegOQh
         Ap9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fQCRqwRwSbH5iwt/zl8RAPBM4K0Cy36tb7dQhI6/CV8=;
        b=M5jqoD4T/YXrACXfgNqBKcawdxw/ENLoOg85duvSAKpWwblqVbjd80qx8WxaLY0ARk
         wThhc8JOwAuYr3JE92AIY4Bx505AAoB4QkZzA2srT7+oJKDJZY/uIurKqW/Q+m5UYgKB
         Z57YywykI94v+DZFadqrqiXeRhw7amjADCP29zK5lr5tgNr/zX2QOTCiw3uWVXpLzsVE
         aKoTw8lvFRmUH+96nHuuRXQdftrxM+rCzyIklBRIg94OvE00aRrLZ1CiICgF49IOJ4kC
         QVg4c8vSZ8M9xFWFqVm95eNlpTDLWD2bpTZHJIAalkMJYQMj84WvPmqQvLGQFbpKlm7W
         4orQ==
X-Gm-Message-State: ACrzQf2E/2fmkkamK+c8Ll/N0IcShRRJXUEUZbxjgBL2reTaOoQB0aEA
        1ndO6HaWAuIBtUD+o7HcjZgM717FWb0Cvn7M+FSQpg==
X-Google-Smtp-Source: AMsMyM4wvjcKmFtu6ZSCW2m9MyjJq1q1Q0jMjMoMNCsK9rlv90y8TVMIoQv9crgEyph1x5NkbIxDT9LE149uF06dk+c=
X-Received: by 2002:a05:6102:3d82:b0:398:b79e:dda6 with SMTP id
 h2-20020a0561023d8200b00398b79edda6mr4333493vsv.39.1663455536940; Sat, 17 Sep
 2022 15:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164411.2496380-1-kajetan.puchalski@arm.com> <20220915164411.2496380-2-kajetan.puchalski@arm.com>
In-Reply-To: <20220915164411.2496380-2-kajetan.puchalski@arm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sat, 17 Sep 2022 15:58:47 -0700
Message-ID: <CAAYoRsV2_gmbd84GCfAZk2ueRDPXczNgVAaqX7QbLf2Ljp=fBg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] cpuidle: teo: Add optional util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 9:45 AM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Modern interactive systems, such as recent Android phones, tend to have
> power efficient shallow idle states. Selecting deeper idle states on a
> device while a latency-sensitive workload is running can adversely impact
> performance due to increased latency. Additionally, if the CPU wakes up
> from a deeper sleep before its target residency as is often the case, it
> results in a waste of energy on top of that.
>
> This patch extends the TEO governor with an optional mechanism adding
> util-awareness, effectively providing a way for the governor to switch
> between only selecting the shallowest idle state when the cpu is being
> utilized over a certain threshold and trying to select the deepest possible
> state using TEO's metrics when the cpu is not being utilized. This is now
> possible since the CPU utilization is exported from the scheduler with the
> sched_cpu_util function and already used e.g. in the thermal governor IPA.
>
> This can provide drastically decreased latency and performance benefits in
> certain types of mobile workloads that are sensitive to latency,
> such as Geekbench 5.
>
> Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> ---
>  drivers/cpuidle/Kconfig         | 12 +++++
>  drivers/cpuidle/governors/teo.c | 86 +++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
>
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index ff71dd662880..6b66ee88a2b2 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -33,6 +33,18 @@ config CPU_IDLE_GOV_TEO
>           Some workloads benefit from using it and it generally should be safe
>           to use.  Say Y here if you are not happy with the alternatives.
>
> +config CPU_IDLE_GOV_TEO_UTIL_AWARE
> +       bool "Util-awareness mechanism for TEO"
> +       depends on CPU_IDLE_GOV_TEO
> +       help
> +         Util-awareness mechanism for the TEO governor. With this enabled,
> +         the governor will choose the shallowest available state when the
> +         CPU's average util is above a certain threshold and default to
> +         using the metrics-based approach when it's not.
> +
> +         Some latency-sensitive workloads on interactive devices can benefit
> +         from using it.
> +
>  config CPU_IDLE_GOV_HALTPOLL
>         bool "Haltpoll governor (for virtualized systems)"
>         depends on KVM_GUEST
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index d9262db79cae..fd5b2eb750be 100644
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
> @@ -99,14 +104,48 @@
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
> + * be woken up to do more work soon and so the shallowest idle state should be
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
> + * util to the precomputed util threhsold. If it's below, it defaults to the

threshold

> + * TEO metrics mechanism. If it's above, it simply selects the shallowest
> + * enabled idle state.
>   */
>
>  #include <linux/cpuidle.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/sched.h>

I think it also needs this line:

+#include <linux/sched/topology.h>

At least for me, it didn't compile without it.

>  #include <linux/sched/clock.h>
>  #include <linux/tick.h>
>
> +/*
> + * The number of bits to shift the cpu's capacity by in order to determine
> + * the utilized threshold
> + */
> +#define UTIL_THRESHOLD_SHIFT 6
> +
> +
>  /*
>   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
>   * is used for decreasing metrics on a regular basis.
> @@ -140,6 +179,8 @@ struct teo_bin {
>   * @total: Grand total of the "intercepts" and "hits" mertics for all bins.

metrics

>   * @next_recent_idx: Index of the next @recent_idx entry to update.
>   * @recent_idx: Indices of bins corresponding to recent "intercepts".
> + * @util_threshold: Threshold above which the CPU is considered utilized
> + * @utilized: Whether the last sleep on the CPU happened while utilized
>   */
>  struct teo_cpu {
>         s64 time_span_ns;
> @@ -148,10 +189,28 @@ struct teo_cpu {
>         unsigned int total;
>         int next_recent_idx;
>         int recent_idx[NR_RECENT];
> +#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
> +       unsigned long util_threshold;
> +       bool utilized;
> +#endif
>  };
>
>  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
>
> +#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
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
> +}
> +#endif
> +
>  /**
>   * teo_update - Update CPU metrics after wakeup.
>   * @drv: cpuidle driver containing state data.
> @@ -301,7 +360,13 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         int i;
>
>         if (dev->last_state_idx >= 0) {
> +#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
> +               /* don't update metrics if the cpu was utilized during the last sleep */
> +               if (!cpu_data->utilized)
> +                       teo_update(drv, dev);
> +#else
>                 teo_update(drv, dev);
> +#endif
>                 dev->last_state_idx = -1;
>         }
>
> @@ -321,6 +386,21 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                         goto end;
>         }
>
> +#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
> +       teo_get_util(dev, cpu_data);
> +       /* if the cpu is being utilized, choose the shallowest state and exit */
> +       if (cpu_data->utilized) {
> +               for (i = 0; i < drv->state_count; ++i) {
> +                       if (dev->states_usage[i].disable)
> +                               continue;
> +                       break;
> +               }
> +
> +               idx = i;
> +               goto end;
> +       }
> +#endif
> +
>         /*
>          * Find the deepest idle state whose target residency does not exceed
>          * the current sleep length and the deepest idle state not deeper than
> @@ -508,9 +588,15 @@ static int teo_enable_device(struct cpuidle_driver *drv,
>                              struct cpuidle_device *dev)
>  {
>         struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> +#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
> +       unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
> +#endif
>         int i;
>
>         memset(cpu_data, 0, sizeof(*cpu_data));
> +#ifdef CONFIG_CPU_IDLE_GOV_TEO_UTIL_AWARE
> +       cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> +#endif
>
>         for (i = 0; i < NR_RECENT; i++)
>                 cpu_data->recent_idx[i] = -1;
> --
> 2.37.1
>
