Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2A6CBBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjC1KEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjC1KEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:04:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420D56A7D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:04:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o11so11165829ple.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679997850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KxWO7xZCpZy/QjDSfmiWAP83Yc5YWXIyhWWtxZPMVEw=;
        b=hN008miUyq4MP/sgibqJJlMmfh8gH3r8syzVXMiCVNpJu7bFv+86OoVc8hvtcrJq9l
         TgURfR0jeZOVO3+o0wxzcpEQN+V9QOtwDglhz8jZWBw+o+TmXtKp+JGTru3i1fPcajoJ
         xbGkAnHZiK57fucBmJwx1BMnwvU/cW2JC/SaqYeaMj6ixkpSa/MFlrcIfQ+rlptOxt33
         CNQOyU5QyW0NWD/JtFg2wERWJVCKnTg8JGBAWilW+mHgaloVS9mPVnEosdtlrEQjOmQS
         ++BxlWRuy85Ulv4UPEvKXvL0Rk6K9N8bJgdFo1CJPCSX/rUAlgBs0/OzDDaVhL3H9/Z7
         16eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxWO7xZCpZy/QjDSfmiWAP83Yc5YWXIyhWWtxZPMVEw=;
        b=cEBXrARfGF4BaR02fA5Fsegul9qCBM4arWhOwKr0XBSy84uRPGK5ysYqVD/C+PnI0d
         SeN9lhrHLlWqe/3yswDRYH1dkvU3/XFKHIbHJGH56zs2QkbLB3d9Oj2jqTzUX+AJWcsT
         ZtAOgbHngydM8xiS2L7pW0VSNHShRbp7ePu804bPgPxfTDu/5t2fQhW+TVFghYoeQryp
         HAVPm/7ICA5kHCW2dMo+jglS+hQUDsP+SNS6W0rUUmsXmxTx1PhLZX0kl79lTTOclfWa
         mNQrxrhBx/KYZAn0tUuGGnGLpvEQ++ta4i6taH6WVl1g2Gc0PAa58zpwd2ZHMWHHCk2B
         gF6w==
X-Gm-Message-State: AAQBX9eRVXVMQqOVBhSEzFpS1zMpmf+HQ1E9Ss02AAulgKMiZvZDqjsX
        /7opL4eBZO2NpPwL94GK1X4dwhaQdmiZxWMEejtTZg==
X-Google-Smtp-Source: AKy350Z2K54gIuz3a2WlczjWFC5hAW3ydoLsfQD5zWkB2qMCTp+k60kvFzz827Gr9gz3s/3zbMgQUhkvIw3Fta2qLxs=
X-Received: by 2002:a17:902:9b88:b0:1a1:c523:a9bd with SMTP id
 y8-20020a1709029b8800b001a1c523a9bdmr5428987plp.0.1679997849712; Tue, 28 Mar
 2023 03:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com> <20230207051105.11575-11-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207051105.11575-11-ricardo.neri-calderon@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 28 Mar 2023 12:03:58 +0200
Message-ID: <CAKfTPtAciJr-ZQWcJN3bHZHyHmjmSOuDYZz9UwfK2EnMVPX6aQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/24] sched/fair: Use IPCC scores to select a busiest runqueue
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
> For two runqueues of equal priority and equal number of running of tasks,
> select the one whose current task would have the highest IPC class score
> if placed on the destination CPU.

You failed to explain why it make sense to compare current task score
whereas we will most probably not pull this task at the end
>
> For now, use IPCC scores only for scheduling domains with the
> SD_ASYM_PACKING flag.
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
>  * Only use IPCC scores to break ties if the sched domain uses
>    asym_packing. (Ionela)
>  * Handle errors of arch_get_ipcc_score(). (Ionela)
>
> Changes since v1:
>  * Fixed a bug when selecting a busiest runqueue: when comparing two
>    runqueues with equal nr_running, we must compute the IPCC score delta
>    of both.
>  * Renamed local variables to improve the layout of the code block.
>    (PeterZ)
>  * Used the new interface names.
> ---
>  kernel/sched/fair.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 72d88270b320..d3c22dc145f7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9399,6 +9399,37 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
>         return sched_asym_ipcc_prefer(a_stats, b_stats);
>  }
>
> +/**
> + * ipcc_score_delta - Get the IPCC score delta wrt the load balance's dst_cpu
> + * @p:         A task
> + * @env:       Load balancing environment
> + *
> + * Returns: The IPCC score delta that @p would get if placed in the destination
> + * CPU of @env. LONG_MIN to indicate that the delta should not be used.
> + */
> +static long ipcc_score_delta(struct task_struct *p, struct lb_env *env)
> +{
> +       unsigned long score_src, score_dst;
> +       unsigned short ipcc = p->ipcc;
> +
> +       if (!sched_ipcc_enabled())
> +               return LONG_MIN;
> +
> +       /* Only asym_packing uses IPCC scores at the moment. */
> +       if (!(env->sd->flags & SD_ASYM_PACKING))
> +               return LONG_MIN;
> +
> +       score_dst = arch_get_ipcc_score(ipcc, env->dst_cpu);
> +       if (IS_ERR_VALUE(score_dst))
> +               return LONG_MIN;
> +
> +       score_src = arch_get_ipcc_score(ipcc, task_cpu(p));
> +       if (IS_ERR_VALUE(score_src))
> +               return LONG_MIN;
> +
> +       return score_dst - score_src;
> +}
> +
>  #else /* CONFIG_IPC_CLASSES */
>  static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
>                                     struct rq *rq)
> @@ -9429,6 +9460,11 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
>         return false;
>  }
>
> +static long ipcc_score_delta(struct task_struct *p, struct lb_env *env)
> +{
> +       return LONG_MIN;
> +}
> +
>  #endif /* CONFIG_IPC_CLASSES */
>
>  /**
> @@ -10589,6 +10625,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  {
>         struct rq *busiest = NULL, *rq;
>         unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
> +       long busiest_ipcc_delta = LONG_MIN;
>         unsigned int busiest_nr = 0;
>         int i;
>
> @@ -10705,8 +10742,35 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>
>                 case migrate_task:
>                         if (busiest_nr < nr_running) {
> +                               struct task_struct *curr;
> +
>                                 busiest_nr = nr_running;
>                                 busiest = rq;
> +
> +                               /*
> +                                * Remember the IPCC score delta of busiest::curr.
> +                                * We may need it to break a tie with other queues
> +                                * with equal nr_running.
> +                                */
> +                               curr = rcu_dereference(busiest->curr);
> +                               busiest_ipcc_delta = ipcc_score_delta(curr, env);

Hmm, i don't like this at all

Also, curr is the least probable task to be pulled which means that
all this his useless

> +                       /*
> +                        * If rq and busiest have the same number of running
> +                        * tasks and IPC classes are supported, pick rq if doing
> +                        * so would give rq::curr a bigger IPC boost on dst_cpu.
> +                        */
> +                       } else if (busiest_nr == nr_running) {
> +                               struct task_struct *curr;
> +                               long delta;
> +
> +                               curr = rcu_dereference(rq->curr);
> +                               delta = ipcc_score_delta(curr, env);
> +
> +                               if (busiest_ipcc_delta < delta) {
> +                                       busiest_ipcc_delta = delta;
> +                                       busiest_nr = nr_running;
> +                                       busiest = rq;
> +                               }
>                         }
>                         break;
>
> --
> 2.25.1
>
