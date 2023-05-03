Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36AE6F5BC3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjECQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjECQJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:09:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE273768D
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:09:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24e015fcf3dso2880362a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683130146; x=1685722146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZDdatLr9Kvf/xQg29g4xwilb8XRSZtLq7UI9qb+lSQ=;
        b=wN4Ofq31wxQK8CinxYqLXgkrSOUBxKmsLSjDATVIUe29vB5Li/Qagdpkxzx1HyH2G4
         oaYq5qNv0NOSEu7+W5B9vPRklatihpzXkxux6AKkKyfelkThJxTel0DpY8N3ZSkE8svE
         u9WBVThjsMeyBv7VChy8zMHDeFEpoioaZMNchFW9hUiXFANfGj9cR3Ia4GxM5Qg5iWd0
         GsgyblKBNeR7OuqohuR7nDrgG65FfRfnzGmTKLIHCz552yW4l3syDNwUpDnUkr14OCzw
         MxyV7KDVSbsHR4IkM3/kDUi+W7CBXEI0wzvJKW0Jew5Ro3QZXojRWHUh4vYv6IerjvT8
         koZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683130146; x=1685722146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZDdatLr9Kvf/xQg29g4xwilb8XRSZtLq7UI9qb+lSQ=;
        b=H+UP9q2y5fgTTEcGlqVw854XcYa4rSpahDGqRHuBnhUd4PzWnefUmRYURtjdVmO38A
         NKx814ZvuXqg1uZOhYUBk8vtE9XANrv7knx2+zbDweoKMVhkfvy6Rcr8egEFGtaHQF+b
         Us3bl69q3lwQo/wrw0YIgvpc+MXLGrnTWMnUZMrAOVPPaDGWLoE5+qzfWH5WdLglt8lc
         v2UAQrrj0pQRMFOYt39HpEliCzGwYLoGlZwXIuu3IBj1V+U8a/MV/XU6JdA4ySm/vXVG
         tamyNqbSDiBdpm5JnZdh9Kvj2VqDsJyHSzy6+TX1z5d2HHUS2arK+ejUELvIavsCUaiv
         /Dfw==
X-Gm-Message-State: AC+VfDyLgea+qXZgrN7yLt7eZSIzMluRKp5weOFgnNORmJDLqBCQcV7q
        ZPliLVTOju64J2tvl6MBJ2J5sYMUPf8jIUqo/wPWpg==
X-Google-Smtp-Source: ACHHUZ5PflWmh7z7LtOg46UQhHWeXA6EsXnJUq5hv7oo07JFwMwyAk0mgC0c4lHRcYaTv2vkJVQw1XMSv1js4DloFUE=
X-Received: by 2002:a17:90a:fb83:b0:24d:e3d3:91d7 with SMTP id
 cp3-20020a17090afb8300b0024de3d391d7mr14554325pjb.27.1683130146306; Wed, 03
 May 2023 09:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com> <20230406155030.1989554-2-dietmar.eggemann@arm.com>
In-Reply-To: <20230406155030.1989554-2-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 May 2023 18:08:54 +0200
Message-ID: <CAKfTPtDh_aQn15to7E9JypVXarFVcEL+jiWJMV6J7-Gijj9SyQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 at 17:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Use new cpu_boosted_util_cfs() instead of cpu_util_cfs().
>
> The former returns max(util_avg, runnable_avg) capped by max CPU
> capacity. CPU contention is thereby considered through runnable_avg.
>
> The change in load-balance only affects migration type `migrate_util`.

would be good to get some figures to show the benefit

>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c |  3 ++-
>  kernel/sched/fair.c              |  2 +-
>  kernel/sched/sched.h             | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e3211455b203..728b186cd367 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -158,7 +158,8 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>         struct rq *rq = cpu_rq(sg_cpu->cpu);
>
>         sg_cpu->bw_dl = cpu_bw_dl(rq);
> -       sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
> +       sg_cpu->util = effective_cpu_util(sg_cpu->cpu,
> +                                         cpu_boosted_util_cfs(sg_cpu->cpu),

Shouldn't we have a similar change in feec to estimate correctly which
OPP/ freq will be selected by schedutil ?


>                                           FREQUENCY_UTIL, NULL);
>  }
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc358dc4faeb..5ae36224a1c2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10481,7 +10481,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                         break;
>
>                 case migrate_util:
> -                       util = cpu_util_cfs(i);
> +                       util = cpu_boosted_util_cfs(i);
>
>                         /*
>                          * Don't try to pull utilization from a CPU with one
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 060616944d7a..f42c859579d9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2994,6 +2994,25 @@ static inline unsigned long cpu_util_cfs(int cpu)
>         return min(util, capacity_orig_of(cpu));
>  }
>
> +/*
> + * cpu_boosted_util_cfs() - Estimates the amount of CPU capacity used by
> + *                          CFS tasks.
> + *
> + * Similar to cpu_util_cfs() but also take possible CPU contention into
> + * consideration.
> + */
> +static inline unsigned long cpu_boosted_util_cfs(int cpu)
> +{
> +       unsigned long runnable;
> +       struct cfs_rq *cfs_rq;
> +
> +       cfs_rq = &cpu_rq(cpu)->cfs;
> +       runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
> +       runnable = min(runnable, capacity_orig_of(cpu));
> +
> +       return max(cpu_util_cfs(cpu), runnable);
> +}
> +
>  static inline unsigned long cpu_util_rt(struct rq *rq)
>  {
>         return READ_ONCE(rq->avg_rt.util_avg);
> --
> 2.25.1
>
