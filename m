Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04507437DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjF3I7o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjF3I7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:59:36 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A3F359E;
        Fri, 30 Jun 2023 01:59:33 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-98e1fc9d130so45589366b.0;
        Fri, 30 Jun 2023 01:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688115571; x=1690707571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2MBUi7x9l7mMbhDLy13JZfd2Q6j84WVOfBVWYNME0M=;
        b=U+xtwWtKZRL4a9wAZKZGnnE6qw59x55TjUASpetMfI+rYlti+E5bE4LS6JOk8NPnde
         K6Br/I8QHqVANkV0090JQUuu+yD3PBitXaWQ8Z1u9Q8t4IHBQgloGpS/ogGY00agCfZ6
         dQWjaQEpT7IUGofP2RVzLozcF4sjS9ZcqRRqq5O5zpARdIJdFnlbyOxJD1MvlZ8+VZPW
         KWrgUX91nVzTt05y97suuhK0ABDWoez1jykp827ao5SBwYp1TrR0hMeRT2DbDarsKoJL
         IDJaEuAL529gBulGuKZVzCl5WsiKCY+7BIDDEYsXHp3bspmOzlGFgNDbzi7tJCb1vUWg
         2F7g==
X-Gm-Message-State: ABy/qLbZ6eyGNnw0f/fppgF3A7NBTZrAleLW6otp3UVsmM9ayb4y+PoW
        iM5FnssrH9It165K+9WL0a26zy9qEOrWMOPalyzH4USf
X-Google-Smtp-Source: APBJJlHzbhhmzpKuxQdyMwB5fE8BfeYtL4juLmqsqi14Ay87YjPpOXL3wvEm1ZEJydQbHMQp8aE7H9ePdUhvkCvAqZ4=
X-Received: by 2002:a17:906:ccc3:b0:98d:b10f:f3cd with SMTP id
 ot3-20020a170906ccc300b0098db10ff3cdmr1393351ejb.7.1688115571326; Fri, 30 Jun
 2023 01:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230629194509.4094455-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230629194509.4094455-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 10:59:20 +0200
Message-ID: <CAJZ5v0ju6ffS3yWD97h1r0A1AzxoX+xLiXEN7YhGotD8SJv13Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Fix scaling for hybrid capable
 system with disabled E-cores
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 29, 2023 at 9:45 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Some system BIOS configuration may provide option to disable E-cores.
> As part of this change, CPUID feature for hybrid (Leaf 7 sub leaf 0,
> EDX[15] = 0) may not be set. But HWP performance limits will still be
> using a scaling factor like any other hybrid enabled system.
>
> The current check for applying scaling factor will fail when hybrid
> CPUID feature is not set. Only way to make sure that scaling should be
> applied by checking CPPC nominal frequency and nominal performance. If
> CPPC nominal frequency and nominal performance is defined and nominal
> frequency is not in multiples of 100MHz of nominal performance, then use
> hybrid scaling factor.
>
> The above check will fail for non hybrid capable systems as they don't
> publish nominal frequency field in CPPC, so this function can be used
> for all HWP systems without additional cpu model check.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> Compile errors reported by kernel test robot and Rafael for the case
> when CONFIG_ACPI is not defined
>
>  drivers/cpufreq/intel_pstate.c | 58 ++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2548ec92faa2..7e18999be46a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -302,6 +302,13 @@ static bool hwp_forced __read_mostly;
>
>  static struct cpufreq_driver *intel_pstate_driver __read_mostly;
>
> +#define HYBRID_SCALING_FACTOR  78741
> +
> +static inline int core_get_scaling(void)
> +{
> +       return 100000;
> +}
> +
>  #ifdef CONFIG_ACPI
>  static bool acpi_ppc;
>  #endif
> @@ -400,6 +407,25 @@ static int intel_pstate_get_cppc_guaranteed(int cpu)
>
>         return cppc_perf.nominal_perf;
>  }
> +
> +static int intel_pstate_cppc_get_scaling(int cpu)
> +{
> +       struct cppc_perf_caps cppc_perf;
> +       int ret;
> +
> +       ret = cppc_get_perf_caps(cpu, &cppc_perf);
> +
> +       /*
> +        * Check if nominal frequency is multiples of 100 MHz, if
> +        * not return hybrid scaling factor.
> +        */
> +       if (!ret && cppc_perf.nominal_perf && cppc_perf.nominal_freq &&
> +           (cppc_perf.nominal_perf * 100 != cppc_perf.nominal_freq))
> +               return HYBRID_SCALING_FACTOR;
> +
> +       return core_get_scaling();
> +}
> +
>  #else /* CONFIG_ACPI_CPPC_LIB */
>  static inline void intel_pstate_set_itmt_prio(int cpu)
>  {
> @@ -492,6 +518,11 @@ static inline int intel_pstate_get_cppc_guaranteed(int cpu)
>  {
>         return -ENOTSUPP;
>  }
> +
> +static int intel_pstate_cppc_get_scaling(int cpu)
> +{
> +       return core_get_scaling();
> +}
>  #endif /* CONFIG_ACPI_CPPC_LIB */
>
>  /**
> @@ -1895,11 +1926,6 @@ static int core_get_turbo_pstate(int cpu)
>         return ret;
>  }
>
> -static inline int core_get_scaling(void)
> -{
> -       return 100000;
> -}
> -
>  static u64 core_get_val(struct cpudata *cpudata, int pstate)
>  {
>         u64 val;
> @@ -1936,16 +1962,29 @@ static void hybrid_get_type(void *data)
>         *cpu_type = get_this_hybrid_cpu_type();
>  }
>
> -static int hybrid_get_cpu_scaling(int cpu)
> +static int hwp_get_cpu_scaling(int cpu)
>  {
>         u8 cpu_type = 0;
>
>         smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
>         /* P-cores have a smaller perf level-to-freqency scaling factor. */
>         if (cpu_type == 0x40)
> -               return 78741;
> +               return HYBRID_SCALING_FACTOR;
>
> -       return core_get_scaling();
> +       /* Use default core scaling for E-cores */
> +       if (cpu_type == 0x20)
> +               return core_get_scaling();
> +
> +       /*
> +        * If reached here, it means that, this system is either non
> +        * hybrid system (like Tiger Lake) or hybrid capable system (like
> +        * Alder Lake or Raptor Lake) with no E cores (CPUID for hybrid
> +        * support is 0).
> +        * All non hybrid systems, don't publish nominal_frequency
> +        * field (means nominal frequency = 0), In that case
> +        * the legacy core scaling is used.
> +        */
> +       return intel_pstate_cppc_get_scaling(cpu);
>  }
>
>  static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
> @@ -3393,8 +3432,7 @@ static int __init intel_pstate_init(void)
>                         if (!default_driver)
>                                 default_driver = &intel_pstate;
>
> -                       if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
> -                               pstate_funcs.get_cpu_scaling = hybrid_get_cpu_scaling;
> +                       pstate_funcs.get_cpu_scaling = hwp_get_cpu_scaling;
>
>                         goto hwp_cpu_matched;
>                 }
> --

Applied as 6.5-rc material with some adjustments.  Please check the
bleeding-edge branch.

Thanks!
