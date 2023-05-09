Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0432F6FCD98
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjEISTD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 14:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEISTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:19:01 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6129610D4;
        Tue,  9 May 2023 11:19:00 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-96a03fb32ecso18998166b.1;
        Tue, 09 May 2023 11:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656339; x=1686248339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMig7cacqxM0M8QLTQgaR5qkIFniI4eAWPY9butqi+Y=;
        b=RMyrgN/vVYlYZipNkJQet8wTXUVdn1xUEq7pnt4x01P1u6zO0SK/EP6lCZ2ysoN6BL
         UR4D4tHztongFPQ3viJ+H8iyIN70e66PbJbZ4R8/Et6N/XrsMACMpiThqqrYKEQX1Wlp
         GQRzcPfjxXGF+DF4Mc3IFtYUDAmAuu6Bf7C/d6NGYlpNq0STsEpp3WPHk9ZqiQRtTDzC
         30GGCjeg9cSLBzZndJxaCSOR2W7im3p0lK6pPHfoaHjwc9J8nG0cvplN1Ht4GwCbsnes
         AvVD1oy4yrGae64YLYslAQAkBRDJF3babXXdSNSplbSB518OiEiUSZJycXoAEd2oy2DI
         fwsw==
X-Gm-Message-State: AC+VfDwWiTa2zGW8ih6Zz63fuAydT3UsPNt6p6aGUQXmiTBOpfytL6ve
        ZFKF3UZNK+sQ1RvOO7qeEiboKV4srJ37rP7IwO8=
X-Google-Smtp-Source: ACHHUZ4iSSYVCLu+15PxIFH72JvTZ6U7pJ2wh0zj5eqPtBmYWsgXPaMbWLMqUBG1x/hPO6VcEKTHLHcuvv3O771/zO0=
X-Received: by 2002:a17:906:1045:b0:929:b101:937d with SMTP id
 j5-20020a170906104500b00929b101937dmr11112333ejj.1.1683656338676; Tue, 09 May
 2023 11:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230509180503.739208-1-wyes.karny@amd.com> <20230509180503.739208-2-wyes.karny@amd.com>
In-Reply-To: <20230509180503.739208-2-wyes.karny@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 May 2023 20:18:47 +0200
Message-ID: <CAJZ5v0hN7AxkSf7=8-xP1Pb_7bA2Ba6nGUiK45q01uo_MFa1qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpufreq/schedutil: Remove fast_switch_possible
 flag if driver doesn't set fast_switch
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
        srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        joel@joelfernandes.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 8:06 PM Wyes Karny <wyes.karny@amd.com> wrote:
>
> The set value of `fast_switch_enabled` indicates that fast_switch
> callback is set. For some drivers such as amd_pstate and intel_pstate,
> the adjust_perf callback is used but it still sets
> `fast_switch_possible` flag. This is because this flag also decides
> whether schedutil governor selects adjust_perf function for frequency
> update. This condition in the schedutil governor forces the scaling
> driver to set the `fast_switch_possible` flag.
>
> Remove `fast_switch_enabled` check when schedutil decides to select
> adjust_perf function for frequency update. Thus removing this drivers
> are now free to remove `fast_switch_possible` flag if they don't use
> fast_switch callback.
>
> This issue becomes apparent when aperf/mperf overflow occurs.  When this
> happens, kernel disables frequency invariance calculation which causes
> schedutil to fallback to sugov_update_single_freq which currently relies
> on the fast_switch callback.
>
> Normal flow:
>   sugov_update_single_perf
>     cpufreq_driver_adjust_perf
>       cpufreq_driver->adjust_perf
>
> Error case flow:
>   sugov_update_single_perf
>     sugov_update_single_freq  <-- This is chosen because the freq invariant is disabled due to aperf/mperf overflow
>       cpufreq_driver_fast_switch
>          cpufreq_driver->fast_switch <-- Here NULL pointer dereference is happening, because fast_switch is not set

So you need to set fast_switch.

Please read the comment in sugov_update_single_perf().  It explains
why adjust_perf is not used when scale invariance is not enabled: the
mapping between the performance levels and frequency are not generally
defined in that case and it is up to the driver to figure out what
perf level to use to get the given frequency.  And this is exactly why
fast_switch is not optional: because scale invariance may be disabled.

Please feel free to update the documentation to clarify this, but the
way to fix the issue is to implement fast_switch in the driver.

> Fixes: a61dec744745 ("cpufreq: schedutil: Avoid missing updates for one-CPU policies")
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/cpufreq/amd-pstate.c     | 10 +++++++---
>  drivers/cpufreq/cpufreq.c        | 20 +++++++++++++++++++-
>  drivers/cpufreq/intel_pstate.c   |  3 +--
>  include/linux/cpufreq.h          |  1 +
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  5 files changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5a3d4aa0f45a..007bfe724a6a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -671,8 +671,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>         /* It will be updated by governor */
>         policy->cur = policy->cpuinfo.min_freq;
>
> +       /**
> +        * For shared memory system frequency update takes time that's why
> +        * do this in deferred kthread context.
> +        */
>         if (boot_cpu_has(X86_FEATURE_CPPC))
> -               policy->fast_switch_possible = true;
> +               current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
> +       else
> +               current_pstate_driver->adjust_perf = NULL;
>
>         ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
>                                    FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> @@ -697,8 +703,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>         policy->driver_data = cpudata;
>
>         amd_pstate_boost_init(cpudata);
> -       if (!current_pstate_driver->adjust_perf)
> -               current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>
>         return 0;
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6b52ebe5a890..366747012104 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -501,6 +501,13 @@ void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
>         if (!policy->fast_switch_possible)
>                 return;
>
> +       /**
> +        * It's not expected driver's fast_switch callback is not set
> +        * even fast_switch_possible is true.
> +        */
> +       if (WARN_ON(!cpufreq_driver_has_fast_switch()))
> +               return;
> +
>         mutex_lock(&cpufreq_fast_switch_lock);
>         if (cpufreq_fast_switch_count >= 0) {
>                 cpufreq_fast_switch_count++;
> @@ -2143,6 +2150,17 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>
> +/**
> + * cpufreq_driver_has_fast_switch - Check "fast switch" callback.
> + *
> + * Return 'true' if the ->fast_switch callback is present for the
> + * current driver or 'false' otherwise.
> + */
> +bool cpufreq_driver_has_fast_switch(void)
> +{
> +       return !!cpufreq_driver->fast_switch;
> +}
> +
>  /**
>   * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
>   * @cpu: Target CPU.
> @@ -2157,7 +2175,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>   * and it is expected to select a suitable performance level equal to or above
>   * @min_perf and preferably equal to or below @target_perf.
>   *
> - * This function must not be called if policy->fast_switch_enabled is unset.
> + * By default this function takes the fast frequency update path.
>   *
>   * Governors calling this function must guarantee that it will never be invoked
>   * twice in parallel for the same CPU and that it will never be called in
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2548ec92faa2..007893514c87 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2698,8 +2698,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
>
>         intel_pstate_init_acpi_perf_limits(policy);
>
> -       policy->fast_switch_possible = true;
> -
>         return 0;
>  }
>
> @@ -2955,6 +2953,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
>         if (ret)
>                 return ret;
>
> +       policy->fast_switch_possible = true;
>         policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
>         /* This reflects the intel_pstate_get_cpu_pstates() setting. */
>         policy->cur = policy->cpuinfo.min_freq;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 26e2eb399484..7a32cfca26c9 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -604,6 +604,7 @@ struct cpufreq_governor {
>  /* Pass a target to the cpufreq driver */
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>                                         unsigned int target_freq);
> +bool cpufreq_driver_has_fast_switch(void);
>  void cpufreq_driver_adjust_perf(unsigned int cpu,
>                                 unsigned long min_perf,
>                                 unsigned long target_perf,
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e3211455b203..f993ecf731a9 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -776,7 +776,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>
>         if (policy_is_shared(policy))
>                 uu = sugov_update_shared;
> -       else if (policy->fast_switch_enabled && cpufreq_driver_has_adjust_perf())
> +       else if (cpufreq_driver_has_adjust_perf())
>                 uu = sugov_update_single_perf;
>         else
>                 uu = sugov_update_single_freq;
> --
> 2.34.1
>
