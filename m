Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85436667888
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbjALPFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbjALPFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:05:05 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1858FAB;
        Thu, 12 Jan 2023 06:53:58 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id az20so26295085ejc.1;
        Thu, 12 Jan 2023 06:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgKyV2yOeD64hEuElG6M2z/hau3FihzgfJPFqSOxxc0=;
        b=70q2aDzwTU3jzSdOpPMa/rFqLQAryNv1b7NOxv4DVqTCrkw0f6HNLSG7JZTj3MofHl
         wzRjU0AgVrJxF20slZty/C7Bqa89k9rKk3/ZlLMGv7gOKpt8UVOoXn63Dcc15IAJAs5i
         50T/GXd7qC2IF99ws0HlDfBj8SpPB1SP1pUfZs6DQXMj9GLpiV3LIWafF8rJZP1iwYAq
         9G3oW1qnlxcmLTax+5uLER/KEjp9wG9STO3g8MK0Zwy2ALTXurrsj/AtQtuwjCOBTVOi
         HGoRuQqboRjkmnBVMU7uvNP8ZrjRYuwCssfT7a7g53W1jwdc/AQQs3K6+7u5rTqAB+AN
         eYFA==
X-Gm-Message-State: AFqh2kq34X+M77zSl0s7q4Yam6K1NCUiM8k3bsGDKDqPBsRBS6gU3b9E
        IJlVCZTSyYxDuLlzFcwK2Q31+kWImaXl6zJCoXw=
X-Google-Smtp-Source: AMrXdXvWb2jV/bGqYjyEgd4DCxWSw+jwTNTRfw+b+/JRVbGXLBgw6IqzWqeUnPc2koeVTnEQsNwmOv1bpQ7ZmJtoNmM=
X-Received: by 2002:a17:907:c203:b0:867:77a9:db77 with SMTP id
 ti3-20020a170907c20300b0086777a9db77mr200551ejc.209.1673535237018; Thu, 12
 Jan 2023 06:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com> <20221129233419.4022830-3-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20221129233419.4022830-3-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 15:53:45 +0100
Message-ID: <CAJZ5v0jSL3bbEHJLxpn_Liu4DcNeMFG=iQJA_AgophmtXpzMGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] powercap: idle_inject: Add prepare/complete callbacks
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, amitk@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:34 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The actual idle percentage can be less than the desired because of
> interrupts.

This is somewhat unclear.

> Since the objective for CPU Idle injection is for thermal
> control, there should be some way to compensate for lost idle percentage.

What does "lost idle percentage" mean here?

> Some architectures provide interface to get actual idle percent observed
> by the hardware. So, the idle percent can be adjusted using the hardware
> feedback. For example, Intel CPUs provides package idle counters, which
> is currently used by intel powerclamp driver to adjust idle time.
>
> The only way this can be done currently is by monitoring hardware idle
> percent from a different software thread. This can be avoided by adding
> callbacks.
>
> Add a capability to register a prepare and complete callback during idle
> inject registry. Add a new register function idle_inject_register_full()
> which also allows to register callbacks.
>
> If they are not NULL, then prepare callback is called before calling
> play_idle_precise() and complete callback is called after calling
> play_idle_precise().
>
> If prepare callback is present and returns non 0 value then
> play_idle_precise() is not called to avoid over compensation.

This mechanism isn't particularly straightforward, but maybe there's
no better way.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2
> - Replace begin/end with prepare/complete
> - Add new interface idle_inject_register_full with callbacks
> - Update kernel doc
> - Update commit description
>
>  drivers/powercap/idle_inject.c | 62 +++++++++++++++++++++++++++++++---
>  include/linux/idle_inject.h    |  4 +++
>  2 files changed, 62 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index dfa989182e71..f48e71501429 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -63,13 +63,31 @@ struct idle_inject_thread {
>   * @idle_duration_us: duration of CPU idle time to inject
>   * @run_duration_us: duration of CPU run time to allow
>   * @latency_us: max allowed latency
> + * @prepare: Callback function which is called before calling
> + *             play_idle_precise()
> + * @complete: Callback function which is called after calling
> + *             play_idle_precise()

What about:

@prepare: Optional callback deciding whether or not to skip idle
injection in the given cycle.
@complete: Optional callback updating the state after idle injection.

>   * @cpumask: mask of CPUs affected by idle injection
> + *
> + * This structure is used to define per instance idle inject device data. Each
> + * instance has an idle duration, a run duration and mask of CPUs to inject
> + * idle.
> + * Actual idle is injected by calling kernel scheduler interface
> + * play_idle_precise(). There are two optional callbacks which the caller can
> + * register by calling idle_inject_register_full():
> + * prepare() - This callback is called just before calling play_idle_precise()
> + *             If this callback returns non zero value then
> + *             play_idle_precise() is not called. This means skip injecting
> + *             idle during this period.
> + * complete() - This callback is called after calling play_idle_precise().

I would keep the format of the comment more consistent with the
general information at the top and the member descriptions at the
bottom.

>   */
>  struct idle_inject_device {
>         struct hrtimer timer;
>         unsigned int idle_duration_us;
>         unsigned int run_duration_us;
>         unsigned int latency_us;
> +       int (*prepare)(unsigned int cpu);

Can it be bool?

> +       void (*complete)(unsigned int cpu);
>         unsigned long cpumask[];
>  };
>
> @@ -132,6 +150,7 @@ static void idle_inject_fn(unsigned int cpu)
>  {
>         struct idle_inject_device *ii_dev;
>         struct idle_inject_thread *iit;
> +       int ret;

This is redundant.

>
>         ii_dev = per_cpu(idle_inject_device, cpu);
>         iit = per_cpu_ptr(&idle_inject_thread, cpu);
> @@ -141,8 +160,18 @@ static void idle_inject_fn(unsigned int cpu)
>          */
>         iit->should_run = 0;
>
> +       if (ii_dev->prepare) {
> +               ret = ii_dev->prepare(cpu);
> +               if (ret)
> +                       goto skip;
> +       }

Because the above can be written as

if (ii_dev->prepare && ii_dev->prepare(cpu))
         goto skip;

> +
>         play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
>                           READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
> +
> +skip:
> +       if (ii_dev->complete)
> +               ii_dev->complete(cpu);
>  }
>
>  /**
> @@ -295,17 +324,23 @@ static int idle_inject_should_run(unsigned int cpu)
>  }
>
>  /**
> - * idle_inject_register - initialize idle injection on a set of CPUs
> + * idle_inject_register_full - initialize idle injection on a set of CPUs
>   * @cpumask: CPUs to be affected by idle injection
> + * @prepare: callback called before calling play_idle_precise()
> + * @complete: callback called after calling play_idle_precise()

IMO it would be slightly cleaner to say "invoked" instead of "called".

>   *
>   * This function creates an idle injection control device structure for the
> - * given set of CPUs and initializes the timer associated with it.  It does not
> - * start any injection cycles.
> + * given set of CPUs and initializes the timer associated with it. This
> + * function also allows to register prepare() and complete() callbacks.
> + * It does not start any injection cycles.
>   *
>   * Return: NULL if memory allocation fails, idle injection control device
>   * pointer on success.
>   */
> -struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
> +
> +struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
> +                                                    int (*prepare)(unsigned int cpu),
> +                                                    void (*complete)(unsigned int cpu))
>  {
>         struct idle_inject_device *ii_dev;
>         int cpu, cpu_rb;
> @@ -318,6 +353,8 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>         hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         ii_dev->timer.function = idle_inject_timer_fn;
>         ii_dev->latency_us = UINT_MAX;
> +       ii_dev->prepare = prepare;
> +       ii_dev->complete = complete;
>
>         for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>
> @@ -342,6 +379,23 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>
>         return NULL;
>  }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_register_full, IDLE_INJECT);
> +
> +/**
> + * idle_inject_register - initialize idle injection on a set of CPUs
> + * @cpumask: CPUs to be affected by idle injection
> + *
> + * This function creates an idle injection control device structure for the
> + * given set of CPUs and initializes the timer associated with it.  It does not
> + * start any injection cycles.
> + *
> + * Return: NULL if memory allocation fails, idle injection control device
> + * pointer on success.

It would be sufficient to say "Pass @cpumask to
idle_inject_register_full() to initialize idle injection on a set of
CPUs".

> + */
> +struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
> +{
> +       return idle_inject_register_full(cpumask, NULL, NULL);
> +}
>  EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
>
>  /**
> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
> index fb88e23a99d3..e18d89793490 100644
> --- a/include/linux/idle_inject.h
> +++ b/include/linux/idle_inject.h
> @@ -13,6 +13,10 @@ struct idle_inject_device;
>
>  struct idle_inject_device *idle_inject_register(struct cpumask *cpumask);
>
> +struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
> +                                                    int (*prepare)(unsigned int cpu),
> +                                                    void (*complete)(unsigned int cpu));
> +
>  void idle_inject_unregister(struct idle_inject_device *ii_dev);
>
>  int idle_inject_start(struct idle_inject_device *ii_dev);
> --
