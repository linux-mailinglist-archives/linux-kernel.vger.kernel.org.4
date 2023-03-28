Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31326CBBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjC1KBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC1KBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:01:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D36A66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:01:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso1101983pjc.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679997669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SDvTTs++Tl/6sukBJzxMXeMKSCf5v5GcYSyRxrfzCLs=;
        b=Icg9NdI/nzbMg0bujHJC18V75S+kNOVGPZ6vcaDDPbP3SR6/ZBnwBRcG96GwGMpzLd
         wJP9zdBmhOg2NicX7ECGQrWcNOScBkWjlJ5COSC7mtJRLg4Bv3ksPh1Oun2XIXwm6SAe
         /7pH0WHFvhoUZB+VbYXweLCTyqQuYYhKw8Kh7eQTE8bouAd2KyVLgwfpDXxvemhWk4qN
         29PMb3kKepshWCopzApQ+bURVt10wOdt2t2hBr6KQWEfHJAaDaQoEv9jOaOGouInKBsJ
         9+Na8qLqDhT6NiLA1sCP1NFHOUdWyWLuMIK9a5QJxmyEfHfRxScU5qcVyhhHWzJ2Vz89
         6FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDvTTs++Tl/6sukBJzxMXeMKSCf5v5GcYSyRxrfzCLs=;
        b=X7UL7ve0LyTDYeKEj5JLGVJUB2XSB9KU0HxqWq5TLJy5BCDIIqfoYi4//lbbKmm7NI
         bLS6wPDeICt24KAj9xRF2p62OkOzLLJm8q5siQA5pcX2NjqhyxuWvYj9j1wESO7SfK6w
         sQIvKQZ3VFgjd/kVs5sb3x2AxAycZp22FoSfcp8HNBTmxMmWI4XJlombyv8ZV9qO0KsE
         NfkRVxNIKuTXt60+8pwwdSZ2Xyuwio11ZDIMeQZk+VXfcaPPSPSd++vLXn9GiVJxce4r
         90CIJ4lv4RxHBZWh5zDFHHYmKkuVw2jaVkEWGaIwVfkL91fMFKmd0hu+wPIqi+aqH003
         J+EA==
X-Gm-Message-State: AAQBX9fYQnHqOvb/t+EWIMKK3m+t4TZfuhCGwH116ZsPZ4/cBJBrizVW
        EK5cSYdVdl8Iva5JW+n+pzrsyfk9CK5WcXV2jHwJnA==
X-Google-Smtp-Source: AKy350Ya5zYneiZ66QZMuQBV3q55Oh/SmKYKifrWFzI1yFb8tF7oFRd8be+B8ESoy4teg7cKVneVjze6A6ZXr/Q1A4A=
X-Received: by 2002:a17:903:482:b0:1a0:5402:b17b with SMTP id
 jj2-20020a170903048200b001a05402b17bmr5446452plb.0.1679997669347; Tue, 28 Mar
 2023 03:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com> <20230207051105.11575-8-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207051105.11575-8-ricardo.neri-calderon@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 28 Mar 2023 12:00:58 +0200
Message-ID: <CAKfTPtB_jZ6q0+9cWxjNZD9gLi-Ts_o_HfBZdiebZz89rHA6iw@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] sched/fair: Compute IPC class scores for load balancing
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2023 at 06:01, Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Compute the joint total (both current and prospective) IPC class score of
> a scheduling group and the local scheduling group.
>
> These IPCC statistics are used during idle load balancing. The candidate
> scheduling group will have one fewer busy CPU after load balancing. This
> observation is important for cores with SMT support.
>
> The IPCC score of scheduling groups composed of SMT siblings needs to
> consider that the siblings share CPU resources. When computing the total
> IPCC score of the scheduling group, divide score of each sibling by the
> number of busy siblings.
>
> Collect IPCC statistics for asym_packing and fully_busy scheduling groups.

IPCC statistics collect scores of current tasks, so they are
meaningful only when trying to migrate one of those running tasks.
Using such score when pulling other tasks is just meaningless. And I
don't see how you ensure such correct use of ipcc score

> When picking a busiest group, they are used to break ties between otherwise
> identical groups.
>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  * Also collect IPCC stats for fully_busy sched groups.

Why have you added fully_busy case ? it's worth explaining the
rational because there is a lot of change to use the ipcc score of the
wrong task to take the decision

>  * Restrict use of IPCC stats to SD_ASYM_PACKING. (Ionela)
>  * Handle errors of arch_get_ipcc_score(). (Ionela)
>
> Changes since v1:
>  * Implemented cleanups and reworks from PeterZ. I took all his
>    suggestions, except the computation of the  IPC score before and after
>    load balancing. We are computing not the average score, but the *total*.
>  * Check for the SD_SHARE_CPUCAPACITY to compute the throughput of the SMT
>    siblings of a physical core.
>  * Used the new interface names.
>  * Reworded commit message for clarity.
> ---
>  kernel/sched/fair.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d773380a95b3..b6165aa8a376 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8901,6 +8901,8 @@ struct sg_lb_stats {
>         unsigned long min_score; /* Min(score(rq->curr->ipcc)) */
>         unsigned short min_ipcc; /* Class of the task with the minimum IPCC score in the rq */
>         unsigned long sum_score; /* Sum(score(rq->curr->ipcc)) */
> +       long ipcc_score_after; /* Prospective IPCC score after load balancing */
> +       unsigned long ipcc_score_before; /* IPCC score before load balancing */
>  #endif
>  };
>
> @@ -9287,6 +9289,62 @@ static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
>         }
>  }
>
> +static void update_sg_lb_stats_scores(struct sg_lb_stats *sgs,
> +                                     struct sched_group *sg,
> +                                     struct lb_env *env)
> +{
> +       unsigned long score_on_dst_cpu, before;
> +       int busy_cpus;
> +       long after;
> +
> +       if (!sched_ipcc_enabled())
> +               return;
> +
> +       /*
> +        * IPCC scores are only useful during idle load balancing. For now,
> +        * only asym_packing uses IPCC scores.
> +        */
> +       if (!(env->sd->flags & SD_ASYM_PACKING) ||
> +           env->idle == CPU_NOT_IDLE)
> +               return;
> +
> +       /*
> +        * IPCC scores are used to break ties only between these types of
> +        * groups.
> +        */
> +       if (sgs->group_type != group_fully_busy &&
> +           sgs->group_type != group_asym_packing)
> +               return;
> +
> +       busy_cpus = sgs->group_weight - sgs->idle_cpus;
> +
> +       /* No busy CPUs in the group. No tasks to move. */
> +       if (!busy_cpus)
> +               return;
> +
> +       score_on_dst_cpu = arch_get_ipcc_score(sgs->min_ipcc, env->dst_cpu);
> +
> +       /*
> +        * Do not use IPC scores. sgs::ipcc_score_{after, before} will be zero
> +        * and not used.
> +        */
> +       if (IS_ERR_VALUE(score_on_dst_cpu))
> +               return;
> +
> +       before = sgs->sum_score;
> +       after = before - sgs->min_score;

IIUC, you assume that you will select the cpu with the min score.
How do you ensure this ? otherwise all your comparisong are useless

> +
> +       /* SMT siblings share throughput. */
> +       if (busy_cpus > 1 && sg->flags & SD_SHARE_CPUCAPACITY) {
> +               before /= busy_cpus;
> +               /* One sibling will become idle after load balance. */
> +               after /= busy_cpus - 1;
> +       }
> +
> +       sgs->ipcc_score_after = after + score_on_dst_cpu;
> +       sgs->ipcc_score_before = before;

I'm not sure to understand why you are computing the sum_score,
ipcc_score_before and ipcc_score_after ?
Why is it not sufficient to check if score_on_dst_cpu will be higher
than current min_score ?

> +}
> +
>  #else /* CONFIG_IPC_CLASSES */
>  static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
>                                     struct rq *rq)
> @@ -9296,6 +9354,13 @@ static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
>  static void init_rq_ipcc_stats(struct sg_lb_stats *sgs)
>  {
>  }
> +
> +static void update_sg_lb_stats_scores(struct sg_lb_stats *sgs,
> +                                     struct sched_group *sg,
> +                                     struct lb_env *env)
> +{
> +}
> +
>  #endif /* CONFIG_IPC_CLASSES */
>
>  /**
> @@ -9457,6 +9522,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>
>         sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
>
> +       if (!local_group)
> +               update_sg_lb_stats_scores(sgs, group, env);
> +
>         /* Computing avg_load makes sense only when group is overloaded */
>         if (sgs->group_type == group_overloaded)
>                 sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
> --
> 2.25.1
>
