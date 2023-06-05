Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727977225EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjFEMdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjFEMcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:32:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117601BF2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:31:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25632c99eecso1818505a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685968300; x=1688560300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7VSwkm9EV97sp37CCVx+t2dQXFFWOHLRBJNQDLTrO60=;
        b=TZpzq/Y357YqSlwobEndO2QrxAytiXjaIAY+5DOE/ZJMB0ny5S1uLLnFdd7SxpvEmu
         kgIXzSV8is/maHNvYcbMdxzkg35VnV6T7EcGu7pBg3Ij38ITjNg+75jzUzx9JXDVQBB3
         ozDdHq3Yaed2M+rkRBEwwAHZAkJ2VCkfzIhZIIuNdVa39T7xJynXTTHtZ0Po/EGOM9p+
         +ou9+LEZVNppZODGxsZs0xLeyGz+e/7oCxSqEq0FgCw/c+GZKvy/Et4BHfWQ0an15lRT
         S+A6knXxFLqnl9KYGvfKdguoVvUjfRgLna97PkWwDeMXxAndP7WBjdnu8ga/sXHx5DIu
         BHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685968300; x=1688560300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VSwkm9EV97sp37CCVx+t2dQXFFWOHLRBJNQDLTrO60=;
        b=lWBy2nchEohIdqh+/99cXZ2shkdS4xlB4n7P5ctjiEehF8qD31+yU81NnBJX/tAA8z
         mpIeRlT2QYzyYoo2Feavk238g6zO9wWe1VEdQj7/R3pBBnIc5X2gCQ32OKlwqGMd7QJA
         YXlueIo9dQSspKuwKFN1DkvTJB2hWBiH4O5Rr/X9hKyxMqoVRfvLLAWiOHa/EKHHJyi+
         pyaruhHmUpLV83800FdujtnqyWsXk7MfRNfFV7BkwR3SA+6+o9R+AurF3sxv+BZglJAr
         n1dEohyOnM/FNY6TlT03hTeKAIF97CVjFiCIQR8G0h0kizHyG2B39zsUv+LvsM+rNkZc
         lXtQ==
X-Gm-Message-State: AC+VfDx48anA+wJVPaGYF7ZllpKFlOqij8ZfsPJqT6J15Krzesrv6qCI
        vqBH67wWpxzg/o8tPU2V43BJqJEKPAelSde/RviPvQ==
X-Google-Smtp-Source: ACHHUZ5c+NDAu4+a65Ma22bs9kPx6Cne3jY1p70IWjw6w3MpLlvvIAQ5WsyY+0gExe8MrHhDHf3fqc6KSRj672WmZ90=
X-Received: by 2002:a17:90a:cc0e:b0:253:440b:7aed with SMTP id
 b14-20020a17090acc0e00b00253440b7aedmr2986938pju.32.1685968300308; Mon, 05
 Jun 2023 05:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230515115735.296329-1-dietmar.eggemann@arm.com> <20230515115735.296329-3-dietmar.eggemann@arm.com>
In-Reply-To: <20230515115735.296329-3-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 5 Jun 2023 14:31:29 +0200
Message-ID: <CAKfTPtA+eyRBMU=-ccuPDkAQKQpz5z1inTGz9SW=cEMjB-6p+A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] sched/fair, cpufreq: Introduce 'runnable boosting'
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 at 13:57, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> The responsiveness of the Per Entity Load Tracking (PELT) util_avg in
> mobile devices is still considered too low for utilization changes
> during task ramp-up.
>
> In Android this manifests in the fact that the first frames of a UI
> activity are very prone to be jankframes (a frame which doesn't meet
> the required frame rendering time, e.g. 16ms@60Hz) since the CPU
> frequency is normally low at this point and has to ramp up quickly.
>
> The beginning of an UI activity is also characterized by the occurrence
> of CPU contention, especially on little CPUs. Current little CPUs can
> have an original CPU capacity of only ~ 150 which means that the actual
> CPU capacity at lower frequency can even be much smaller.
>
> Schedutil maps CPU util_avg into CPU frequency request via:
>
>   util = effective_cpu_util(..., cpu_util_cfs(cpu), ...) ->
>   util = map_util_perf(util) -> freq = map_util_freq(util, ...)
>
> CPU contention for CFS tasks can be detected by 'CPU runnable > CPU
> utililization' in cpu_util_cfs_boost() -> cpu_util(..., boost = 1).
> Schedutil uses 'runnable boosting' by calling cpu_util_cfs_boost().
>
> To be in sync with schedutil's CPU frequency selection, Energy Aware
> Scheduling (EAS) also calls cpu_util(..., boost = 1) during max util
> detection.
>
> Moreover, 'runnable boosting' is also used in load-balance for busiest
> CPU selection when the migration type is 'migrate_util', i.e. only at
> sched domains which don't have the SD_SHARE_PKG_RESOURCES flag set.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/cpufreq_schedutil.c |  3 ++-
>  kernel/sched/fair.c              | 38 +++++++++++++++++++++++++-------
>  kernel/sched/sched.h             |  1 +
>  3 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e3211455b203..4492608b7d7f 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -155,10 +155,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>
>  static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
> +       unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu);
>         struct rq *rq = cpu_rq(sg_cpu->cpu);
>
>         sg_cpu->bw_dl = cpu_bw_dl(rq);
> -       sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
> +       sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
>                                           FREQUENCY_UTIL, NULL);
>  }
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9874e28d5e38..3b5b6186f2b9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7150,6 +7150,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   * @cpu: the CPU to get the utilization for
>   * @p: task for which the CPU utilization should be predicted or NULL
>   * @dst_cpu: CPU @p migrates to, -1 if @p moves from @cpu or @p == NULL
> + * @boost: 1 to enable boosting, otherwise 0
>   *
>   * The unit of the return value must be the same as the one of CPU capacity
>   * so that CPU utilization can be compared with CPU capacity.
> @@ -7167,6 +7168,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   * be when a long-sleeping task wakes up. The contribution to CPU utilization
>   * of such a task would be significantly decayed at this point of time.
>   *
> + * Boosted CPU utilization is defined as max(CPU runnable, CPU utilization).
> + * CPU contention for CFS tasks can be detected by CPU runnable > CPU
> + * utilization. Boosting is implemented in cpu_util() so that internal
> + * users (e.g. EAS) can use it next to external users (e.g. schedutil),
> + * latter via cpu_util_cfs_boost().
> + *
>   * CPU utilization can be higher than the current CPU capacity
>   * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because
>   * of rounding errors as well as task migrations or wakeups of new tasks.
> @@ -7177,12 +7184,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   * though since this is useful for predicting the CPU capacity required
>   * after task migrations (scheduler-driven DVFS).
>   *
> - * Return: (Estimated) utilization for the specified CPU.
> + * Return: (Boosted) (estimated) utilization for the specified CPU.
>   */
> -static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
> +static unsigned long
> +cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>  {
>         struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
>         unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
> +       unsigned long runnable;
> +
> +       if (boost) {
> +               runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
> +               util = max(util, runnable);
> +       }
>
>         /*
>          * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its
> @@ -7200,6 +7214,9 @@ static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
>
>                 util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
>
> +               if (boost)
> +                       util_est = max(util_est, runnable);
> +
>                 /*
>                  * During wake-up @p isn't enqueued yet and doesn't contribute
>                  * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
> @@ -7239,7 +7256,12 @@ static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
>
>  unsigned long cpu_util_cfs(int cpu)
>  {
> -       return cpu_util(cpu, NULL, -1);
> +       return cpu_util(cpu, NULL, -1, 0);
> +}
> +
> +unsigned long cpu_util_cfs_boost(int cpu)
> +{
> +       return cpu_util(cpu, NULL, -1, 1);
>  }
>
>  /*
> @@ -7261,7 +7283,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
>         if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
>                 p = NULL;
>
> -       return cpu_util(cpu, p, -1);
> +       return cpu_util(cpu, p, -1, 0);
>  }
>
>  /*
> @@ -7329,7 +7351,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
>         int cpu;
>
>         for_each_cpu(cpu, pd_cpus) {
> -               unsigned long util = cpu_util(cpu, p, -1);
> +               unsigned long util = cpu_util(cpu, p, -1, 0);
>
>                 busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
>         }
> @@ -7353,7 +7375,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
>
>         for_each_cpu(cpu, pd_cpus) {
>                 struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
> -               unsigned long util = cpu_util(cpu, p, dst_cpu);
> +               unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
>                 unsigned long cpu_util;
>
>                 /*
> @@ -7499,7 +7521,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                         if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>                                 continue;
>
> -                       util = cpu_util(cpu, p, cpu);
> +                       util = cpu_util(cpu, p, cpu, 0);
>                         cpu_cap = capacity_of(cpu);
>
>                         /*
> @@ -10559,7 +10581,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                         break;
>
>                 case migrate_util:
> -                       util = cpu_util_cfs(i);
> +                       util = cpu_util_cfs_boost(i);
>
>                         /*
>                          * Don't try to pull utilization from a CPU with one
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f78c0f85cc76..5861e236adc6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2948,6 +2948,7 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
>
>
>  extern unsigned long cpu_util_cfs(int cpu);
> +extern unsigned long cpu_util_cfs_boost(int cpu);
>
>  static inline unsigned long cpu_util_rt(struct rq *rq)
>  {
> --
> 2.25.1
>
