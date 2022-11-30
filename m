Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3E63DD89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiK3S2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiK3S2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:28:10 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1C431227;
        Wed, 30 Nov 2022 10:28:08 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id q10so12544151qvt.10;
        Wed, 30 Nov 2022 10:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0EPxSHKLwUkp9GfQcmrWQus4zn97Y8+iM+7ar1o1NI=;
        b=U+6kGX4z8NqRonIy2fnNn4BaS7V0xm1vLc+EayXtFUu+s7+ZVUfyUjNV1AgP/kyjEs
         AOtbmxAFeSEEXaewNBgFLMu/3hEauETt9YIEMozW26/sJvbWydCugzjZGWLZsi2nG/nz
         dXIOlg3Wn51ANv5TrPC0Ax2jc1SaEU9DDNZeNwEUfhtNjttVekeERqSwavTJh0pM+GeB
         0z02V44gUmVtw1IXDabElOj4I+436haiyw0Tw7muHRricmZ9S+0B6yCR0bZf4Xbxj2Cb
         81fmTJpL5mwksruRH8cY+mgEnwEetgtgQe/w9DnBiXc8O4qdY87uavhx07hp2fFQjgMm
         4hrw==
X-Gm-Message-State: ANoB5pkdlehrQ4BlaN7xxMpriK2Ts51yOX3e/Egv57Utm+yZ2lGu6JSZ
        MUmJBkTyBatkRN0hbzWVhjyVY0cdt+9fUojylS0=
X-Google-Smtp-Source: AA0mqf7iKJsG2tfIdtRsRPZ/mBT5XS9NuLsM3E/fHiwUqiTx7KAS29G5ozAABSA8UNm8u7h+1Kp535NolvbJK/4hzjI=
X-Received: by 2002:a0c:c589:0:b0:4b1:a9ac:21de with SMTP id
 a9-20020a0cc589000000b004b1a9ac21demr39706799qvj.119.1669832887399; Wed, 30
 Nov 2022 10:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20221127141742.1644023-1-qyousef@layalina.io> <20221127141742.1644023-4-qyousef@layalina.io>
In-Reply-To: <20221127141742.1644023-4-qyousef@layalina.io>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Nov 2022 19:27:52 +0100
Message-ID: <CAJZ5v0iew=_pTq-v-2EdZN==8QY3donu9YUBtRYWdL18KBxs4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
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

On Sun, Nov 27, 2022 at 3:18 PM Qais Yousef <qyousef@layalina.io> wrote:
>
> We used performance domains to traverse the list of domains that share
> the same cpufreq policy to detect when this domain is severely impacted
> by thermal pressure to cause it to be lower than another domain in the
> system - capacity inversion.
>
> Since performance domains are only available for when energy model or
> schedutil are present, this makes the detection mechanism unavailable
> for Capacity Aware Scheduling (CAS).
>
> Since we only care about traversing the capacity_orig() of any cpu
> within that domain; export for_each_active_policy() to traverse the
> cpufreq policies instead of performance domains.
>
> Introduce a new for_each_active_policy_safe() to protect against races
> with deletion. Races against additions are fine since we can't
> eliminate the race without having to do heavy handed locking which is
> unacceptable in this path. The policy should be visible in the next
> tick if we missed it.
>
> Fixes: 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>
> Rafael, Viresh, I hope it's okay to export these macros in the public header.
> And that my usage is okay; I'm not sure if I missed important locking rules.
>
>
>  drivers/cpufreq/cpufreq.c | 12 +-----------
>  include/linux/cpufreq.h   | 26 ++++++++++++++++++++++++++
>  kernel/sched/fair.c       | 13 +++++--------
>  3 files changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 69b3d61852ac..b11e7c545fc1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -31,17 +31,7 @@
>  #include <linux/units.h>
>  #include <trace/events/power.h>
>
> -static LIST_HEAD(cpufreq_policy_list);
> -
> -/* Macros to iterate over CPU policies */
> -#define for_each_suitable_policy(__policy, __active)                    \
> -       list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
> -               if ((__active) == !policy_is_inactive(__policy))
> -
> -#define for_each_active_policy(__policy)               \
> -       for_each_suitable_policy(__policy, true)
> -#define for_each_inactive_policy(__policy)             \
> -       for_each_suitable_policy(__policy, false)
> +LIST_HEAD(cpufreq_policy_list);
>
>  /* Iterate over governors */
>  static LIST_HEAD(cpufreq_governor_list);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d5595d57f4e5..c3c79d4ad821 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -780,6 +780,32 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
>                         continue;                                               \
>                 else
>
> +#ifdef CONFIG_CPU_FREQ
> +extern struct list_head cpufreq_policy_list;
> +
> +/* Macros to iterate over CPU policies */
> +#define for_each_suitable_policy(__policy, __active)                    \
> +       list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
> +               if ((__active) == !policy_is_inactive(__policy))
> +
> +#define for_each_suitable_policy_safe(__policy, __n, __active)                    \
> +       list_for_each_entry_safe(__policy, __n, &cpufreq_policy_list, policy_list) \
> +               if ((__active) == !policy_is_inactive(__policy))
> +#else
> +#define for_each_suitable_policy(__policy, __active)           while (0)
> +#define for_each_suitable_policy_safe(__policy, __n, __active) while (0)
> +#endif
> +
> +#define for_each_active_policy(__policy)               \
> +       for_each_suitable_policy(__policy, true)
> +#define for_each_inactive_policy(__policy)             \
> +       for_each_suitable_policy(__policy, false)
> +
> +#define for_each_active_policy_safe(__policy, __n)             \
> +       for_each_suitable_policy_safe(__policy, __n, true)
> +#define for_each_inactive_policy_safe(__policy, __n)           \
> +       for_each_suitable_policy_safe(__policy, __n, false)
> +
>
>  int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>                                     struct cpufreq_frequency_table *table);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7c0dd57e562a..4bbbca85134b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>          *   * Thermal pressure will impact all cpus in this perf domain
>          *     equally.
>          */
> -       if (sched_energy_enabled()) {
> +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
>                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> +               struct cpufreq_policy *policy, __maybe_unused *policy_n;
>
>                 rq->cpu_capacity_inverted = 0;
>
> -               SCHED_WARN_ON(!rcu_read_lock_held());
> -
> -               for (; pd; pd = pd->next) {
> -                       struct cpumask *pd_span = perf_domain_span(pd);
> +               for_each_active_policy_safe(policy, policy_n) {

1. Is the "safe" part sufficient for protection against concurrent
deletion and freeing of list entries?  cpufreq driver removal can do
that AFAICS.
2. For a casual reader of this code it may not be clear why cpufreq
policies matter here.

>                         unsigned long pd_cap_orig, pd_cap;
>
>                         /* We can't be inverted against our own pd */
> -                       if (cpumask_test_cpu(cpu_of(rq), pd_span))
> +                       if (cpumask_test_cpu(cpu_of(rq), policy->cpus))
>                                 continue;
>
> -                       cpu = cpumask_any(pd_span);
> +                       cpu = cpumask_any(policy->cpus);
>                         pd_cap_orig = arch_scale_cpu_capacity(cpu);
>
>                         if (capacity_orig < pd_cap_orig)
> --
> 2.25.1
>
