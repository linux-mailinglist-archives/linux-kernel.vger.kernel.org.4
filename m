Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6FB70DB33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjEWLIj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 07:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbjEWLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:08:37 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86B7119;
        Tue, 23 May 2023 04:08:34 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso94182866b.0;
        Tue, 23 May 2023 04:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684840113; x=1687432113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9roFzv4yIEYa5BN3UGyJbDrPntuKP11hI31tLXaG1jE=;
        b=D9sqhec0BlcoFWRWGS5hay0t7t/DA25O2sRdGjyjsjToy4ue6v8EVm2KuSMu3E1KHG
         cUJviCnpSCgbTVLXHjgtEQWF4w3AEw6ANkPrivPCm+o9/ihtZV9G1h4HukAvOxee/Ssg
         GY8g5AYrpJHWtjlelcE5D1xObYEyAWn87VUH4Rqt0oo7GGmGF3cFqDN3VfS16dqWL0b+
         bZsrcV7vaFa3YYucnsu5fir16kaSRt1Cu301HKDFsQV3TGfSHmTvw+e2nJV7Fdi0FptV
         khZJVoy+49clxU2MUWnDwLRR5qhZ+qiEr4OM8icVTYEvkbCte5yNtRBgLw9UR6ehhZAa
         MuYQ==
X-Gm-Message-State: AC+VfDzHhaxNhlm4hsE3khFOibKI/2swSEgfFDXg+9DKjyQfa4RyuxeZ
        SH9FFqCmDFn++Prje+tWhnNsd9cLgy2/mCCd6DBE5TJ7
X-Google-Smtp-Source: ACHHUZ5HfyJ4lutZHFx+qYCbOugl8UnjWShhO1rvliwSvePLyQvG6ckTMeX20d4+ruTphAMtMNYSiihT3lpUP7QraCU=
X-Received: by 2002:a17:906:5189:b0:96f:469d:19ba with SMTP id
 y9-20020a170906518900b0096f469d19bamr12975253ejk.2.1684840113141; Tue, 23 May
 2023 04:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230523085045.29391-1-kweifat@gmail.com>
In-Reply-To: <20230523085045.29391-1-kweifat@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 13:08:21 +0200
Message-ID: <CAJZ5v0ifp1088wY7o=7pnBVBm=_3H0M4sfq6=gmyChZD6R9g1g@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Avoid initializing variables prematurely
To:     Fieah Lim <kweifat@gmail.com>
Cc:     srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, May 23, 2023 at 10:51 AM Fieah Lim <kweifat@gmail.com> wrote:
>
> We should avoid initializing some rather expensive data
> when the function has a chance to bail out earlier
> before actually using it.
> This applies to the following initializations:
>
>  - cpudata *cpu = all_cpu_data; (in everywhere)
>  - this_cpu = smp_processor_id(); (in notify_hwp_interrupt)
>  - hwp_cap = READ_ONCE(cpu->hwp_cap_cached); (in intel_pstate_hwp_boost_up)
>
> These initializations are premature because there is a chance
> that the function will bail out before actually using the data.
> I think this qualifies as a micro-optimization,
> especially in such a hot path.
>
> While at it, tidy up how and when we initialize
> all of the cpu_data pointers, for the sake of consistency.
>
> A side note on the intel_pstate_cpu_online change:
> we simply don't have to initialize cpudata just
> for the pr_debug, while policy->cpu is being there.
>
> Signed-off-by: Fieah Lim <kweifat@gmail.com>
> ---
> V1 -> V2: Rewrite changelog for better explanation.
> ---
>  drivers/cpufreq/intel_pstate.c | 35 +++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2548ec92faa2..b85e340520d9 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -464,9 +464,8 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
>
>  static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
>  {
> -       struct cpudata *cpu;
> +       struct cpudata *cpu = all_cpu_data[policy->cpu];
>
> -       cpu = all_cpu_data[policy->cpu];

This particular change has nothing to do with any optimization.  It is
a coding style change, nothing more, and I'm not actually sure that it
is useful.

>         if (!cpu->valid_pss_table)
>                 return;
>
> @@ -539,9 +538,8 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
>  static inline void update_turbo_state(void)
>  {
>         u64 misc_en;
> -       struct cpudata *cpu;
> +       struct cpudata *cpu = all_cpu_data[0];
>
> -       cpu = all_cpu_data[0];
>         rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
>         global.turbo_disabled =
>                 (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
> @@ -769,7 +767,7 @@ static struct cpufreq_driver intel_pstate;
>  static ssize_t store_energy_performance_preference(
>                 struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
> -       struct cpudata *cpu = all_cpu_data[policy->cpu];
> +       struct cpudata *cpu;
>         char str_preference[21];
>         bool raw = false;
>         ssize_t ret;
> @@ -802,6 +800,8 @@ static ssize_t store_energy_performance_preference(
>         if (!intel_pstate_driver)
>                 return -EAGAIN;
>
> +       cpu = all_cpu_data[policy->cpu];
> +

This is sysfs attribute handling, not any hot path at all.

>         mutex_lock(&intel_pstate_limits_lock);
>
>         if (intel_pstate_driver == &intel_pstate) {
> @@ -1297,7 +1297,7 @@ static void update_qos_request(enum freq_qos_req_type type)
>         int i;
>
>         for_each_possible_cpu(i) {
> -               struct cpudata *cpu = all_cpu_data[i];
> +               struct cpudata *cpu;
>                 unsigned int freq, perf_pct;
>
>                 policy = cpufreq_cpu_get(i);
> @@ -1310,6 +1310,8 @@ static void update_qos_request(enum freq_qos_req_type type)
>                 if (!req)
>                         continue;
>
> +               cpu = all_cpu_data[i];
> +
>                 if (hwp_active)
>                         intel_pstate_get_hwp_cap(cpu);

This one kind of makes sense, even though this isn't any hot path at
all too (again, it is only used in sysfs attribute handling), but it
may qualify as a code cleanup.

>
> @@ -1579,7 +1581,7 @@ static cpumask_t hwp_intr_enable_mask;
>
>  void notify_hwp_interrupt(void)
>  {
> -       unsigned int this_cpu = smp_processor_id();
> +       unsigned int this_cpu;
>         struct cpudata *cpudata;
>         unsigned long flags;
>         u64 value;
> @@ -1591,6 +1593,8 @@ void notify_hwp_interrupt(void)
>         if (!(value & 0x01))
>                 return;
>
> +       this_cpu = smp_processor_id();
> +
>         spin_lock_irqsave(&hwp_notify_lock, flags);
>
>         if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))

This is a place where it may really matter for performance, but how
much?  Can you actually estimate this?

> @@ -2024,8 +2028,8 @@ static int hwp_boost_hold_time_ns = 3 * NSEC_PER_MSEC;
>
>  static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
>  {
> +       u64 hwp_cap;
>         u64 hwp_req = READ_ONCE(cpu->hwp_req_cached);
> -       u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
>         u32 max_limit = (hwp_req & 0xff00) >> 8;
>         u32 min_limit = (hwp_req & 0xff);
>         u32 boost_level1;
> @@ -2052,6 +2056,7 @@ static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
>                 cpu->hwp_boost_min = min_limit;
>
>         /* level at half way mark between min and guranteed */
> +       hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
>         boost_level1 = (HWP_GUARANTEED_PERF(hwp_cap) + min_limit) >> 1;
>
>         if (cpu->hwp_boost_min < boost_level1)

For clarity, the original code is much better than the new one and the
only case where hwp_cap is not used is when that single read doesn't
matter.  Moreover, the compiler is free to optimize it too.

> @@ -2389,9 +2394,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
>
>  static int intel_pstate_init_cpu(unsigned int cpunum)
>  {
> -       struct cpudata *cpu;
> -
> -       cpu = all_cpu_data[cpunum];
> +       struct cpudata *cpu = all_cpu_data[cpunum];
>
>         if (!cpu) {
>                 cpu = kzalloc(sizeof(*cpu), GFP_KERNEL);
> @@ -2431,11 +2434,13 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>
>  static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
>  {
> -       struct cpudata *cpu = all_cpu_data[cpu_num];
> +       struct cpudata *cpu;
>
>         if (hwp_active && !hwp_boost)
>                 return;
>
> +       cpu = all_cpu_data[cpu_num];
> +
>         if (cpu->update_util_set)
>                 return;
>

This isn't a hot path.

> @@ -2638,9 +2643,7 @@ static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>
>  static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
>  {
> -       struct cpudata *cpu = all_cpu_data[policy->cpu];
> -
> -       pr_debug("CPU %d going online\n", cpu->cpu);
> +       pr_debug("CPU %d going online\n", policy->cpu);
>
>         intel_pstate_init_acpi_perf_limits(policy);
>
> @@ -2649,6 +2652,8 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
>                  * Re-enable HWP and clear the "suspended" flag to let "resume"
>                  * know that it need not do that.
>                  */
> +               struct cpudata *cpu = all_cpu_data[policy->cpu];
> +
>                 intel_pstate_hwp_reenable(cpu);
>                 cpu->suspended = false;

Same here and I don't see why the change matters.

>         }
> --

There is one piece in this patch that may be regarded as useful.
Please send it separately.
