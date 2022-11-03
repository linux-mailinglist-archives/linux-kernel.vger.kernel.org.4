Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A04618754
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKCSUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKCSUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:20:00 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959CF12633;
        Thu,  3 Nov 2022 11:19:59 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id i9so1683479qki.10;
        Thu, 03 Nov 2022 11:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TLcpb+iCvLZOd/QMzRc0iBoGSARI75zWWPSuf5F76c=;
        b=M9KCMo64TwyvQW/znAhmwF83eghX2V7oKeZq9VAU73c4+hBaBGxP+Tf4jJNS6aeTQH
         9rl/bWi0a1hOUWQ4Hu85LjSYkGKFIJRp+3hsH1FF3Vy/AWxb/0z9Vyi7ynpG33PFyf5c
         Au6LEMc4qI2GldL6KNjuj03jpFsWYovTNrIeopYs0pt2+aFwQ+uK3805pZFPPkHOT6D1
         NURaEqG/xMkof33qOP+bjP1t/BWZa4qtaxQPcQz68O/Fp73JLHF+Y5nqHL4KYRNFPaxs
         d2tCyWWvTlWU/sAjCbFW53qgoJ+FSKfDJJB6RZMSxTnNlWUPAjv3RPEXiZ2z2oZbpLAY
         yLFg==
X-Gm-Message-State: ACrzQf095cefVWSBSqp/oCV5z0jZ2jvW1SCTkfLskhpmwUENLCjb+TNJ
        lZZb/0jakXGw2oWr6aN+UZ5Jgvau+LP+joVus6M=
X-Google-Smtp-Source: AMsMyM4vqgEAH9OPc7S7MhURJsCmLThGF2sLAxVw6AfK5up6ttfDcphRecizCSKnQYPUVAvQNPAXCjJ3aeogAKA5lOM=
X-Received: by 2002:a37:c4e:0:b0:6fa:c1c:6fc0 with SMTP id 75-20020a370c4e000000b006fa0c1c6fc0mr23461428qkm.501.1667499598727;
 Thu, 03 Nov 2022 11:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221102195957.82871-1-stuart.w.hayes@gmail.com>
In-Reply-To: <20221102195957.82871-1-stuart.w.hayes@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:19:47 +0100
Message-ID: <CAJZ5v0iM28y2YSWOv81VCB9vqh2xwJcz36wnR7PujDehvrkN-Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Defer setting boost MSRs
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Meyer <kyle.meyer@hpe.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 9:01 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> When acpi-cpufreq is loaded, boost is enabled on every CPU (by setting an
> MSR) before the driver is registered with cpufreq.  This can be very time
> consuming, because it is done with a CPU hotplug startup callback, and
> cpuhp_setup_state() schedules the callback (cpufreq_boost_online()) to run
> on each CPU one at a time, waiting for each to run before calling the next.
>
> If cpufreq_register_driver() fails--if, for example, there are no ACPI
> P-states present--this is wasted time.
>
> Since cpufreq already sets up a CPU hotplug startup callback if and when
> acpi-cpufreq is registered, set the boost MSRs in acpi_cpufreq_cpu_init(),
> which is called by the cpufreq cpuhp callback.  This allows acpi-cpufreq to
> exit quickly if it is loaded but not needed.
>
> On one system with 192 CPUs, this patch speeds up boot by about 30 seconds.
>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 31 +++----------------------------
>  1 file changed, 3 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 1bb2b90ebb21..cb167263de72 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -535,15 +535,6 @@ static void free_acpi_perf_data(void)
>         free_percpu(acpi_perf_data);
>  }
>
> -static int cpufreq_boost_online(unsigned int cpu)
> -{
> -       /*
> -        * On the CPU_UP path we simply keep the boost-disable flag
> -        * in sync with the current global state.
> -        */
> -       return boost_set_msr(acpi_cpufreq_driver.boost_enabled);
> -}
> -
>  static int cpufreq_boost_down_prep(unsigned int cpu)
>  {
>         /*
> @@ -897,6 +888,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>         if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
>                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
>
> +       set_boost(policy, acpi_cpufreq_driver.boost_enabled);
> +
>         return result;
>
>  err_unreg:
> @@ -916,6 +909,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>
>         pr_debug("%s\n", __func__);
>
> +       cpufreq_boost_down_prep(policy->cpu);
>         policy->fast_switch_possible = false;
>         policy->driver_data = NULL;
>         acpi_processor_unregister_performance(data->acpi_perf_cpu);
> @@ -972,25 +966,9 @@ static void __init acpi_cpufreq_boost_init(void)
>         acpi_cpufreq_driver.set_boost = set_boost;
>         acpi_cpufreq_driver.boost_enabled = boost_state(0);
>
> -       /*
> -        * This calls the online callback on all online cpu and forces all
> -        * MSRs to the same value.
> -        */
> -       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "cpufreq/acpi:online",
> -                               cpufreq_boost_online, cpufreq_boost_down_prep);
> -       if (ret < 0) {
> -               pr_err("acpi_cpufreq: failed to register hotplug callbacks\n");
> -               return;
> -       }
>         acpi_cpufreq_online = ret;
>  }
>
> -static void acpi_cpufreq_boost_exit(void)
> -{
> -       if (acpi_cpufreq_online > 0)
> -               cpuhp_remove_state_nocalls(acpi_cpufreq_online);
> -}
> -
>  static int __init acpi_cpufreq_init(void)
>  {
>         int ret;
> @@ -1032,7 +1010,6 @@ static int __init acpi_cpufreq_init(void)
>         ret = cpufreq_register_driver(&acpi_cpufreq_driver);
>         if (ret) {
>                 free_acpi_perf_data();
> -               acpi_cpufreq_boost_exit();
>         }
>         return ret;
>  }
> @@ -1041,8 +1018,6 @@ static void __exit acpi_cpufreq_exit(void)
>  {
>         pr_debug("%s\n", __func__);
>
> -       acpi_cpufreq_boost_exit();
> -
>         cpufreq_unregister_driver(&acpi_cpufreq_driver);
>
>         free_acpi_perf_data();
> --

Applied as 6.2 material, thanks!
