Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5C7246EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbjFFOzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbjFFOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:54:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1161730
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:54:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2568fc3d8a9so2428960a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686063264; x=1688655264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkn2qOx+4ZFOJEINEoCybhXIsIsc5PC4FVtFg15qs6M=;
        b=MvwF+2tEegJlHjJDHthm3zHSfBAAFm4OYaqTMS9hb0udpdHA6IwHPQEzCTVyqemdfI
         FzxL8Tsa4UCr6Mi2EHd8VJ0vqAdyG9cwXlreDxnE4zs3KlrkWk+f333UfjGcfWyiqgYF
         jX+IpkHZK2V083gpK6nZzxiGpExNpfCCrqQGhbpPp5daFnF9Rjr/oyNUwYJGafVVZdI0
         m0AC/oTFAhe0be6r5SM5JMMnUypee9WkO6RYIp7M+Hnm3esQVRx5cak5rvxSsg8bhl13
         CaQT9ZBs6hulHXihvWv+cqR6NihG4qk91/c0AYTHOpGkpPquRaheDSh3FJmqXAdhXzQJ
         HLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063264; x=1688655264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qkn2qOx+4ZFOJEINEoCybhXIsIsc5PC4FVtFg15qs6M=;
        b=Ib9ghfT3PVbVF+p9DVCWGDjhgin5TibIE2j1qulTUUVmdYvfmAha6bgNTfTlPbBp9g
         vQyimgE2cwWEtMK63nkyRixLeMZPdnLWUKxU8gafJ+2DiIptsoO/CqH1kchbW+twPeXa
         LCH6oikZJeDKAiXbiMT449GPEBKKl0RPwbjcrNvqgghnWVqdwux2D0IzAh96aBDfrTPs
         kyasf6GCwIekNsApjU608EWh09+Jl/iw9TvFttXnMn2SNiD2fKJSy1td5SYXzojbX43k
         2jubEuU8B/EGFo7jC6f28j+f1xJ2uVUiSBNnzbWRxzKLIkviEnuuZ7jTuazUPrSG0xNd
         pb3w==
X-Gm-Message-State: AC+VfDyUbBMzhiS+7sZ5UKcyhP0FQWEceHBUUJkdTXIjEAplOdqq5BeE
        WoSGvQEZvjIL5/128ynCs3L4sd+V2FuiVLCwcRkSng==
X-Google-Smtp-Source: ACHHUZ6uq0xQ8Su6w42VlS6bjdxNqfQ27Izp1RfinIt8dXpOvOchlKF2a0VKspm+9KeLro1/K610iKzmUmZe+sFBZgQ=
X-Received: by 2002:a17:90a:c58e:b0:256:5abf:105c with SMTP id
 l14-20020a17090ac58e00b002565abf105cmr607489pjt.46.1686063264613; Tue, 06 Jun
 2023 07:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115839.089944915@infradead.org> <20230531124604.477939524@infradead.org>
In-Reply-To: <20230531124604.477939524@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Jun 2023 16:54:13 +0200
Message-ID: <CAKfTPtCvsy9rUXiAQ=zm=5DiAgJ1EegEkJ5iOkgro5Mnwsvfog@mail.gmail.com>
Subject: Re: [RFC][PATCH 13/15] sched/fair: Implement latency-nice
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
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

On Wed, 31 May 2023 at 14:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Implement latency-nice as a modulation of the EEVDF r_i parameter,
> specifically apply the inverse sched_prio_to_weight[] relation on
> base_slice.
>
> Given a base slice of 3 [ms], this gives a range of:
>
>   latency-nice  19: 3*1024 / 15    ~= 204.8 [ms]
>   latency-nice -20: 3*1024 / 88761 ~= 0.034 [ms]

I have reread the publication. I have question about

Theorem 1: The lag of any active client k in a steady system is
bounded as follows,
    -rmax < lagk (d) < max(rmax ; q);

and

Corollary 2: Consider a steady system and a client k such that no
request of client k is larger than a
time quantum. Then at any time t, the lag of client k is bounded as follows:
    -q < lagk (t) < q

q being the time quanta a task can run
and rmax the maximum slice of active task

I wonder how it applies to us. What is our time quanta q ? I guess
that it's the tick because it is assumed that the algorithm evaluates
which task should run next for each q interval in order to fulfill the
fairness IIUC.So I don't think that we can assume a q shorter than the
tick (at least with current implementation) unless we trigger some
additional interrupts

Then asking for a request shorter than the tick also means that
scheduler must enqueue a new request (on behalf of the task) during
the tick and evaluate if the task is still the one to be scheduled
now. So similarly to q, the request size r should be at least a tick
in order to reevaluate which task will run next after the end of a
request. In fact, the real limit is : r/wi >= tick/(Sum wj)

On Arm64 system, tick is 4ms long and on arm32 it raises to 10ms

We can always not follow these assumptions made in the publication but
I wonder how we can then rely on its theorems and corollaries

>
> (which might not make sense)
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/core.c  |   14 ++++++++++----
>  kernel/sched/fair.c  |   22 +++++++++++++++-------
>  kernel/sched/sched.h |    2 ++
>  3 files changed, 27 insertions(+), 11 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1305,6 +1305,12 @@ static void set_load_weight(struct task_
>         }
>  }
>
> +static inline void set_latency_prio(struct task_struct *p, int prio)
> +{
> +       p->latency_prio = prio;
> +       set_latency_fair(&p->se, prio - MAX_RT_PRIO);
> +}
> +
>  #ifdef CONFIG_UCLAMP_TASK
>  /*
>   * Serializes updates of utilization clamp values
> @@ -4464,9 +4470,10 @@ static void __sched_fork(unsigned long c
>         p->se.nr_migrations             = 0;
>         p->se.vruntime                  = 0;
>         p->se.vlag                      = 0;
> -       p->se.slice                     = sysctl_sched_base_slice;
>         INIT_LIST_HEAD(&p->se.group_node);
>
> +       set_latency_prio(p, p->latency_prio);
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         p->se.cfs_rq                    = NULL;
>  #endif
> @@ -4718,8 +4725,7 @@ int sched_fork(unsigned long clone_flags
>
>                 p->prio = p->normal_prio = p->static_prio;
>                 set_load_weight(p, false);
> -
> -               p->latency_prio = NICE_TO_PRIO(0);
> +               set_latency_prio(p, NICE_TO_PRIO(0));
>
>                 /*
>                  * We don't need the reset flag anymore after the fork. It has
> @@ -7507,7 +7513,7 @@ static void __setscheduler_latency(struc
>                                    const struct sched_attr *attr)
>  {
>         if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> -               p->latency_prio = NICE_TO_PRIO(attr->sched_latency_nice);
> +               set_latency_prio(p, NICE_TO_PRIO(attr->sched_latency_nice));
>  }
>
>  /*
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -952,6 +952,21 @@ int sched_update_scaling(void)
>  }
>  #endif
>
> +void set_latency_fair(struct sched_entity *se, int prio)
> +{
> +       u32 weight = sched_prio_to_weight[prio];
> +       u64 base = sysctl_sched_base_slice;
> +
> +       /*
> +        * For EEVDF the virtual time slope is determined by w_i (iow.
> +        * nice) while the request time r_i is determined by
> +        * latency-nice.
> +        *
> +        * Smaller request gets better latency.
> +        */
> +       se->slice = div_u64(base << SCHED_FIXEDPOINT_SHIFT, weight);
> +}
> +
>  static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
>
>  /*
> @@ -964,13 +979,6 @@ static void update_deadline(struct cfs_r
>                 return;
>
>         /*
> -        * For EEVDF the virtual time slope is determined by w_i (iow.
> -        * nice) while the request time r_i is determined by
> -        * sysctl_sched_base_slice.
> -        */
> -       se->slice = sysctl_sched_base_slice;
> -
> -       /*
>          * EEVDF: vd_i = ve_i + r_i / w_i
>          */
>         se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2495,6 +2495,8 @@ extern unsigned int sysctl_numa_balancin
>  extern unsigned int sysctl_numa_balancing_hot_threshold;
>  #endif
>
> +extern void set_latency_fair(struct sched_entity *se, int prio);
> +
>  #ifdef CONFIG_SCHED_HRTICK
>
>  /*
>
>
