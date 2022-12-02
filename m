Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DEE6408D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiLBO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiLBO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:57:39 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB8C100D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:57:35 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c7so3186917iof.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x4xtfWqm0VBdxXINhuzVFH0cJGa0pOD8BzSG440kVww=;
        b=Sgko14KGjslS+9wNiiOvq4rSW4EOqC3A6uGWr1jhRwDCpFGeJh0zNWBjps/e+e5I6g
         U0wMdM6GAtM3B0QKruxdxeyCgtZ+Ty7vT+B4vxOe6JfW2kK5QS8stKNJ0ON/cbRCazpW
         zfwNbDPLhkgcygKUd7VkLdft/rewDoonz+iXHKpv9kBLwm5mN3AepeErq3Idjldr/vQK
         QsFIl52HytP3bX8rXf8ko1NGdUwLnsFMfuu/RQ6kdprb++SwdjjYIWhxcmZDSOi8WPbT
         Of+kfkSp5tpb8I1S6/gNFayMceSvz074qIHR3uUTsyLW3/eOmPGyPMizNSzbUJqxG4fD
         rXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4xtfWqm0VBdxXINhuzVFH0cJGa0pOD8BzSG440kVww=;
        b=Ww3Azl6cUNXEquhe8/YJK7D7NEYxAs5HXfXJ6TqGy1z5oVptNDG1++mThJNFY79TIv
         w/Kkp/O/PzOzM1mg/91m7mB5uMLpaLePVPo0OH9kor/JxWseg2YLMFSBHeTK0G0kDW6q
         X9pH6ciQOb5cW0illSaQLdCOP43fGVIBJjPbnPt2zhBqye2EgffzPfEyvyEtOhVnFQQb
         2arLs0XyhH8jTzZqoxXczRPWP0Iz6M+5jgI4i+7LEVDcleUr/3RB2nbIwbr30zBlT7Gk
         suDowJNvq3eJuEadkjX6Twr0soA0eC60AoEcWwlaY7ndKDD2k8mmVf4Hr3A/huyyyaXt
         S1Fw==
X-Gm-Message-State: ANoB5pmSWGkJhh09ldPkUJrTahzL6i9IW7ZUGPFINQqM0xtedPSs+eex
        mmc63nJPlVzbTrSCakZAsp40EXEZHf20Msp3MHIWFA==
X-Google-Smtp-Source: AA0mqf4QY3SlD0WC3ohtBGQXShjnq8KTAp1lFR2uzP+wJsgxgSseTME2s3tDT7eTQiBIwftv5gcrSxKEK+aI5yxas/g=
X-Received: by 2002:a6b:e714:0:b0:6df:7332:70f0 with SMTP id
 b20-20020a6be714000000b006df733270f0mr14036957ioh.154.1669993054658; Fri, 02
 Dec 2022 06:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20221127141742.1644023-1-qyousef@layalina.io> <20221127141742.1644023-4-qyousef@layalina.io>
In-Reply-To: <20221127141742.1644023-4-qyousef@layalina.io>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 2 Dec 2022 15:57:21 +0100
Message-ID: <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
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

On Sun, 27 Nov 2022 at 15:18, Qais Yousef <qyousef@layalina.io> wrote:
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

So you are looping all cpufreq policy (and before the perf domain) in
the period load balance. That' really not something we should or want
to do


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
