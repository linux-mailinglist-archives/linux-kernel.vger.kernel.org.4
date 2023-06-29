Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0243A7422BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjF2IyZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjF2IyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:54:14 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F65132;
        Thu, 29 Jun 2023 01:54:13 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-98502b12fd4so11503366b.1;
        Thu, 29 Jun 2023 01:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688028851; x=1690620851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h81lSLoSxEDR7BgV0xLmtf+f7OOXbVC7LxGK66ZCiI4=;
        b=NUlCTNRrpMVlc3i5L6QWPIStSxjH39muAirh8zWoZRdLWGZ9WpArmSXjNRJ3rXIZ9P
         W0fS05UOfPnjun1UrhGF55QziI+QbxaNZo44NjXCYpqb6lt0oc27eMT3VyaWu4T2P8V4
         Wabg1fH0J4qr2uR1aRXYmaQvHRacyGLP8idXSN8hyDkKJPgNEVntc8H8xc22F75kYKuT
         KYNb/30eLKu8A6BIogVoaIh60Eh7X6e63Q4RtWQH5gooc58ha+oqhqtu6ZH+bv26SL9D
         SYGu+9rB15m1KT1LdAMm64YVa+kdeK0hrUd3jT3hzdBkPD7P/MFW9w4SuSZN2xDyh6vM
         bPRA==
X-Gm-Message-State: AC+VfDyHGGK8e5mV1zKB6CVhiwmTXZOYttXpPGhMGD6/E1ELGpOFMMeD
        Y4Rf+vcL4ftLUlrIItuuLGoFUKjlmYoLLPE4fgw=
X-Google-Smtp-Source: APBJJlH7yVtHj6laFxsvvMyRyj0GiURQrI8vXUEX4KU0WYnMSlLFro8rhQA9Nvv1dg350lgdQDmt+MVgLeAk6Y7sv34=
X-Received: by 2002:a17:906:64d5:b0:982:9a08:60 with SMTP id
 p21-20020a17090664d500b009829a080060mr1526508ejn.3.1688028851414; Thu, 29 Jun
 2023 01:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230628225341.3718351-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230628225341.3718351-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 10:54:00 +0200
Message-ID: <CAJZ5v0jT9wwRneF2R1cADzktPe1DVq_U2dOZWzMowg-sjqnFtw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix scaling for hybrid capable
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

On Thu, Jun 29, 2023 at 12:54 AM Srinivas Pandruvada
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
>  drivers/cpufreq/intel_pstate.c | 59 ++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2548ec92faa2..b562ed7c4f37 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -330,6 +330,13 @@ static bool intel_pstate_get_ppc_enable_status(void)
>         return acpi_ppc;
>  }
>
> +#define HYBRID_SCALING_FACTOR  78741
> +
> +static inline int core_get_scaling(void)
> +{
> +       return 100000;
> +}

The above should be defined outside #ifdef CONFIG_ACPI.

> +
>  #ifdef CONFIG_ACPI_CPPC_LIB
>
>  /* The work item is needed to avoid CPU hotplug locking issues */
> @@ -400,10 +407,35 @@ static int intel_pstate_get_cppc_guaranteed(int cpu)
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
>  }
> +
> +static int intel_pstate_cppc_get_scaling(int cpu)
> +{
> +       return core_get_scaling();
> +}
> +
>  #endif /* CONFIG_ACPI_CPPC_LIB */
>
>  static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
> @@ -1895,11 +1927,6 @@ static int core_get_turbo_pstate(int cpu)
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
> @@ -1936,16 +1963,29 @@ static void hybrid_get_type(void *data)
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
> @@ -3393,8 +3433,7 @@ static int __init intel_pstate_init(void)
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
> 2.31.1
>
