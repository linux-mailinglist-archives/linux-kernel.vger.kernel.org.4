Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA845622E4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiKIOsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKIOsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:48:31 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343A3B75;
        Wed,  9 Nov 2022 06:48:25 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id n18so12396062qvt.11;
        Wed, 09 Nov 2022 06:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wivt87LRUJv+IMWcTlOiEICiAr3gHOSSqbBgupcxf9A=;
        b=31s4E95a3G3qY1b2h9KyfpdptPZsLUSdh0+O7GRhBqeg8LxFyyTF2CfaKwsqZbThr1
         RoBTkIj0TUb8xq6PP3GRP1CeafdchU+A5zXitD3lXjnDSXsc2wVtySBpKG70Tq3QvYZP
         l1qWzU5F+yUksk4r9dlWwu1+4ct9vjck1ry0By+8r1romi+eEg1SFaqsy1AxBK4bhEUY
         FAOtryiHjCNCln3eyYo2GqtxsQyrBc7bo3Cfp2R6TGUiOjoBZqs0cMxQj7nfXM++x51H
         H6m9iApI3kaLb3w6jykP/Omt/JbJ61Y2b4H5K2G4VrlhgJaYqXyqRo9Rje3iHQVkeBba
         PzAg==
X-Gm-Message-State: ACrzQf3CSBXXDUOAUG6OjWUPkEBV7MeNOly45CboPsJHXq1VZX8R9x12
        C3racbzjWA26nPjrVqhlpurzAOZpUBCqLzsjn74=
X-Google-Smtp-Source: AMsMyM6Xxkf1II4nkVA7jgVVxaAxHxUzGkbQIMeCFILdMSKennv6TFQcIUIDK5t2fXSlacho9ildVqA7n9peopX83hw=
X-Received: by 2002:a0c:c684:0:b0:4bb:fc53:5ad9 with SMTP id
 d4-20020a0cc684000000b004bbfc535ad9mr46056330qvj.3.1668005304254; Wed, 09 Nov
 2022 06:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20221108030342.1127216-1-srinivas.pandruvada@linux.intel.com> <20221108030342.1127216-3-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20221108030342.1127216-3-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 15:48:13 +0100
Message-ID: <CAJZ5v0jD-a__naERH3MsB1yDQwNkwKcL=aSP3JEdiD11s76gDA@mail.gmail.com>
Subject: Re: [PATCH 2/4] powercap: idle_inject: Add begin/end callbacks
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rui.zhang@intel.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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

On Tue, Nov 8, 2022 at 4:04 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The actual CPU Idle percent can be different than what can be observed
> from the hardware.

Can you expand this a bit, please?  It is not clear what the "CPU idle
percent" and "observed from the hardware" phrases mean here.

> Since the objective for CPU Idle injection is for
> thermal control, the idle percent observed by the hardware is more
> relevant.
>
> To account for hardware feedback the actual runtime/idle time should be
> adjusted.
>
> Add a capability to register a begin and end callback during call to

I would call them "prepare" and "complete" without the "idle_inject_" prefix.

> idle_inject_register(). If they are not NULL, then begin callback is
> called before calling play_idle_precise() and end callback is called
> after play_idle_precise().
>
> If begin callback is present and returns non 0 value then
> play_idle_precise() is not called as it means there is some over
> compensation.

This behavior needs to be documented somewhere other than the patch changelog.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/powercap/idle_inject.c    | 19 ++++++++++++++++++-
>  drivers/thermal/cpuidle_cooling.c |  2 +-
>  include/linux/idle_inject.h       |  4 +++-
>  3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index e73885bd9065..14968b0ff133 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -70,6 +70,8 @@ struct idle_inject_device {
>         unsigned int idle_duration_us;
>         unsigned int run_duration_us;
>         unsigned int latency_us;
> +       int (*idle_inject_begin)(unsigned int cpu);
> +       void (*idle_inject_end)(unsigned int cpu);

The comment above needs to be updated.  Also please see the remark
above regarding callback names.

>         unsigned long cpumask[];
>  };
>
> @@ -132,6 +134,7 @@ static void idle_inject_fn(unsigned int cpu)
>  {
>         struct idle_inject_device *ii_dev;
>         struct idle_inject_thread *iit;
> +       int ret;
>
>         ii_dev = per_cpu(idle_inject_device, cpu);
>         iit = per_cpu_ptr(&idle_inject_thread, cpu);
> @@ -141,8 +144,18 @@ static void idle_inject_fn(unsigned int cpu)
>          */
>         iit->should_run = 0;
>
> +       if (ii_dev->idle_inject_begin) {
> +               ret = ii_dev->idle_inject_begin(cpu);
> +               if (ret)
> +                       goto skip;
> +       }
> +
>         play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
>                           READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
> +
> +skip:
> +       if (ii_dev->idle_inject_end)
> +               ii_dev->idle_inject_end(cpu);
>  }
>
>  /**
> @@ -302,7 +315,9 @@ static int idle_inject_should_run(unsigned int cpu)
>   * Return: NULL if memory allocation fails, idle injection control device
>   * pointer on success.
>   */
> -struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
> +struct idle_inject_device *idle_inject_register(struct cpumask *cpumask,
> +                                               int (*idle_inject_begin)(unsigned int cpu),
> +                                               void (*idle_inject_end)(unsigned int cpu))

Instead of modifying this, I would add something like
idle_inject_register_full() that will take the callback arguments and
will be called internally by idle_inject_register().

>  {
>         struct idle_inject_device *ii_dev;
>         int cpu, cpu_rb;
> @@ -315,6 +330,8 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>         hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         ii_dev->timer.function = idle_inject_timer_fn;
>         ii_dev->latency_us = UINT_MAX;
> +       ii_dev->idle_inject_begin = idle_inject_begin;
> +       ii_dev->idle_inject_end = idle_inject_end;
>
>         for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>
> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> index 4f41102e8b16..e8b35b3b5767 100644
> --- a/drivers/thermal/cpuidle_cooling.c
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -184,7 +184,7 @@ static int __cpuidle_cooling_register(struct device_node *np,
>                 goto out;
>         }
>
> -       ii_dev = idle_inject_register(drv->cpumask);
> +       ii_dev = idle_inject_register(drv->cpumask, NULL, NULL);

So this change would not be necessary any more.

>         if (!ii_dev) {
>                 ret = -EINVAL;
>                 goto out_kfree;
> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
> index fb88e23a99d3..73f3414fafe2 100644
> --- a/include/linux/idle_inject.h
> +++ b/include/linux/idle_inject.h
> @@ -11,7 +11,9 @@
>  /* private idle injection device structure */
>  struct idle_inject_device;
>
> -struct idle_inject_device *idle_inject_register(struct cpumask *cpumask);
> +struct idle_inject_device *idle_inject_register(struct cpumask *cpumask,
> +                                               int (*idle_inject_begin)(unsigned int cpu),
> +                                               void (*idle_inject_end)(unsigned int cpu));
>
>  void idle_inject_unregister(struct idle_inject_device *ii_dev);
>
> --
