Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C20862AE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKOWgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiKOWgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:36:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75FDC23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:36:28 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y13so15661394pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EnzZ3PrFvRLw0UV1tZc+lKh8LoWZRdWTxPKs/T6B6Tg=;
        b=EA3BaYEhAV3qIo8x8scHhNeqORyHYn0UN1sSuf4eNZoh70u8+/8VR9hNPBgZcGO85M
         ov/A9rANCd0bayZZRfGdedsEfnBf7dAGzqRMCxVAx0OxxvGHk0hybhJNDsrAja3cI/R2
         EkPbxC2fyN0bBeg0K5QCPCadSCqho74cxEAYlZfBN6/5CIUdvhew5lPSWsIG+0IpU/1H
         LjReW6NceacrDBaBq9SB/lXvkVz2DqHgYHbhJGm2ZroTnoYCEeWwCaNnbvc5Qb/dXpWE
         CqGMFAPg+fitNencffz5F9qggHCRLB/g4ze+5iY1euegysA6NPCg2vHLWHNXKE/qNxSF
         9Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnzZ3PrFvRLw0UV1tZc+lKh8LoWZRdWTxPKs/T6B6Tg=;
        b=3jGvi4qU1hKNZRrnDB9XrXH1uEwoWZ0o9VLykTVSCr6SgcfspBhAeDhhPlHrsoBRd0
         Ih9dHQg1RQ+jnJTA9jDoHZLQzpsliUBbjCAtXjO24tHk5JujbYfOELARPwnMOH0ho8yK
         /WhMviHWU4vwUhyruwzyiCzo/jxw7P8QRBtD3Pd7XVoX6YJ0wHSKLaccfafVWXP8s+BI
         U/PYLteoN0p4pE+ixN/RENtt98THyWCPhPWmGYyYMwAz0X8V8nvbZorg68x2usDhQnEy
         rFcKXFBzJn4LT0PcVnum2sNL/kYRjfkM/1yEokFtPAS2jmCKfnBoVJOwEgluHy/3ohmt
         DgaA==
X-Gm-Message-State: ANoB5pkSxwPQZDMBC7BlvZ3UWIjsoUkJhhpf717Eb/nyaVOR+Dj7WUJw
        1CRVVKJ7q3ZCNgDSbEEFMz5SBucehawoakqnXP27jg==
X-Google-Smtp-Source: AA0mqf7XBLZZKyFqDsGtGIXnKG2kv31n4SF41AI/zqtzj3xKIaWDkenaobC4ToELTJnD9bAEWFOgU5DBt43SRRbpg3U=
X-Received: by 2002:a63:4d16:0:b0:46f:9c0c:8673 with SMTP id
 a22-20020a634d16000000b0046f9c0c8673mr18391223pgb.154.1668551788055; Tue, 15
 Nov 2022 14:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20221110195732.1382314-1-wusamuel@google.com>
In-Reply-To: <20221110195732.1382314-1-wusamuel@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 15 Nov 2022 14:35:51 -0800
Message-ID: <CAGETcx_aAynvykDSL4aue3zf5Pv7+hELUHQ=MWOzBbyZBPySDA@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to sugov_policy"
To:     Sam Wu <wusamuel@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 11:57 AM Sam Wu <wusamuel@google.com> wrote:
>
> This reverts commit 6d5afdc97ea71958287364a1f1d07e59ef151b11.
>
> On a Pixel 6 device, it is observed that this commit increases
> latency by approximately 50ms, or 20%, in migrating a task
> that requires full CPU utilization from a LITTLE CPU to Fmax
> on a big CPU. Reverting this change restores the latency back
> to its original baseline value.
>
> Fixes: 6d5afdc97ea7 ("cpufreq: schedutil: Move max CPU capacity to sugov_policy")
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Isaac J. Manjarres <isaacmanjarres@google.com>
> Signed-off-by: Sam Wu <wusamuel@google.com>

Rafael, can we pick this up please?

Lukasz, no objections to the idea itself, but it's causing regression
and we'd like to revert and then fix it.

-Saravana

> ---
>  kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 9161d1136d01..1207c78f85c1 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -25,9 +25,6 @@ struct sugov_policy {
>         unsigned int            next_freq;
>         unsigned int            cached_raw_freq;
>
> -       /* max CPU capacity, which is equal for all CPUs in freq. domain */
> -       unsigned long           max;
> -
>         /* The next fields are only needed if fast switch cannot be used: */
>         struct                  irq_work irq_work;
>         struct                  kthread_work work;
> @@ -51,6 +48,7 @@ struct sugov_cpu {
>
>         unsigned long           util;
>         unsigned long           bw_dl;
> +       unsigned long           max;
>
>         /* The field below is for single-CPU policies only: */
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -160,6 +158,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>         struct rq *rq = cpu_rq(sg_cpu->cpu);
>
> +       sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
>         sg_cpu->bw_dl = cpu_bw_dl(rq);
>         sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
>                                           FREQUENCY_UTIL, NULL);
> @@ -254,7 +253,6 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>   */
>  static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
>  {
> -       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         unsigned long boost;
>
>         /* No boost currently required */
> @@ -282,8 +280,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
>          * sg_cpu->util is already in capacity scale; convert iowait_boost
>          * into the same scale so we can compare.
>          */
> -       boost = sg_cpu->iowait_boost * sg_policy->max;
> -       boost >>= SCHED_CAPACITY_SHIFT;
> +       boost = (sg_cpu->iowait_boost * sg_cpu->max) >> SCHED_CAPACITY_SHIFT;
>         boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
>         if (sg_cpu->util < boost)
>                 sg_cpu->util = boost;
> @@ -340,7 +337,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>         if (!sugov_update_single_common(sg_cpu, time, flags))
>                 return;
>
> -       next_f = get_next_freq(sg_policy, sg_cpu->util, sg_policy->max);
> +       next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
>         /*
>          * Do not reduce the frequency if the CPU has not been idle
>          * recently, as the reduction is likely to be premature then.
> @@ -376,7 +373,6 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>                                      unsigned int flags)
>  {
>         struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> -       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         unsigned long prev_util = sg_cpu->util;
>
>         /*
> @@ -403,8 +399,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>                 sg_cpu->util = prev_util;
>
>         cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
> -                                  map_util_perf(sg_cpu->util),
> -                                  sg_policy->max);
> +                                  map_util_perf(sg_cpu->util), sg_cpu->max);
>
>         sg_cpu->sg_policy->last_freq_update_time = time;
>  }
> @@ -413,19 +408,25 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  {
>         struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         struct cpufreq_policy *policy = sg_policy->policy;
> -       unsigned long util = 0;
> +       unsigned long util = 0, max = 1;
>         unsigned int j;
>
>         for_each_cpu(j, policy->cpus) {
>                 struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> +               unsigned long j_util, j_max;
>
>                 sugov_get_util(j_sg_cpu);
>                 sugov_iowait_apply(j_sg_cpu, time);
> +               j_util = j_sg_cpu->util;
> +               j_max = j_sg_cpu->max;
>
> -               util = max(j_sg_cpu->util, util);
> +               if (j_util * max > j_max * util) {
> +                       util = j_util;
> +                       max = j_max;
> +               }
>         }
>
> -       return get_next_freq(sg_policy, util, sg_policy->max);
> +       return get_next_freq(sg_policy, util, max);
>  }
>
>  static void
> @@ -751,7 +752,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>  {
>         struct sugov_policy *sg_policy = policy->governor_data;
>         void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
> -       unsigned int cpu = cpumask_first(policy->cpus);
> +       unsigned int cpu;
>
>         sg_policy->freq_update_delay_ns = sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
>         sg_policy->last_freq_update_time        = 0;
> @@ -759,7 +760,6 @@ static int sugov_start(struct cpufreq_policy *policy)
>         sg_policy->work_in_progress             = false;
>         sg_policy->limits_changed               = false;
>         sg_policy->cached_raw_freq              = 0;
> -       sg_policy->max                          = arch_scale_cpu_capacity(cpu);
>
>         sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
>
> --
> 2.38.1.431.g37b22c650d-goog
>
