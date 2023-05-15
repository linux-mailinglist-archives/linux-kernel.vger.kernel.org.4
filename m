Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09D4702E22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbjEONaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbjEON3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:29:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35E2113
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:29:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64ab2a37812so19930209b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684157377; x=1686749377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=daWFTCzXYNP37TZCyt1FtBu2+Y3iU+ze2p6PRsjDKu4=;
        b=OmiN2l6iOfB+MzU3nTtg54iDntG8Z/RUrSmPKFWasOLxuYzT3AcWXeup6PvTmZeMAr
         w2ml1KF77ZoZSm+/w4dzJ6SP+ckzj986MDBb7rgIO4tZ/fFcHNC3cTJEjnBeas8s3lQA
         A7t8F+SfSpVew7s4ifN/gocSfdWcfKXG2/d65L8ZWL4MNHsWYx32RswIlQUVEWH2i79k
         ZZz8nGuDdAHs0hQIRiAYcVyBokRtZl+LbnL9RG3llZRhnJKq7Edl6vr2ZyD/oEN9nDKM
         oBhpSQr1NKnzy7ZzdmnxNK9KTeF433qCAiTBepkk/V5Kbk+wVwhnYMaKT7sESFJuqmg0
         0u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684157377; x=1686749377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daWFTCzXYNP37TZCyt1FtBu2+Y3iU+ze2p6PRsjDKu4=;
        b=WVQcolDdsNI9tn68loUITMIgzoPjHYPerrfK216/Z8PCdIs9QlpXhv5eGbP0ch2iko
         tMPpueo5bYy+RK+8npRqUAMWsLqGTBEwydkqiQZJj93Dzzx+BozV9xj+CRsx2b6/h/Mw
         TZXiU+KpnT4FCd7qh96d7lsQFwiKrzSEIvawmA9uNHwA2IOxAgGpsKkmtujjjXzTSvgb
         K8d5PpLi1KIZTEph+CCy6OrpmlZm5GVduhf4ngi/M5bfv/iBYDIUFPu3mflPO6nVBctA
         LXATD0UUycWyBmvATeMvclrlbgto9rGmrWqwrMlu5QrXXiZ4tzTubLUt7eucDgzkGtNr
         gNWg==
X-Gm-Message-State: AC+VfDzv/GetR2wh6MjDVzoNi/n5vBZTNfVwlbG87PIdDlUX51ikOxHi
        8En9GEzgHyT2spVKYOU6hLORCo5j/urGQ1uKzZXuXvT/Xj3z4u0/
X-Google-Smtp-Source: ACHHUZ4hE0/JitoNA1nRR8b430pLPPMRX5PYa4dQrrB9YNGkYw3vAu3J98lFyXPqJ+nfAxJYx4LMLfpituRsYQHY/SU=
X-Received: by 2002:a17:90b:3ece:b0:24e:3413:c7ff with SMTP id
 rm14-20020a17090b3ece00b0024e3413c7ffmr47846613pjb.7.1684157377631; Mon, 15
 May 2023 06:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230515063848.77947-1-jiahao.os@bytedance.com> <20230515063848.77947-2-jiahao.os@bytedance.com>
In-Reply-To: <20230515063848.77947-2-jiahao.os@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 15 May 2023 15:29:26 +0200
Message-ID: <CAKfTPtC=dEoXoZoM2srixgdgV66-wbJAUP_SvTkXpWFVH6s1SQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] sched/core: Fixed missing rq clock update before
 calling set_rq_offline()
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
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

On Mon, 15 May 2023 at 08:39, Hao Jia <jiahao.os@bytedance.com> wrote:
>
> This is triggered during cpu offline when CONFIG_CPU_FREQ is enabled
> and cpufreq is set to powersave:
> ------------[ cut here ]------------
> rq->clock_update_flags < RQCF_ACT_SKIP
> WARNING: CPU: 24 PID: 754 at kernel/sched/sched.h:1496
> enqueue_top_rt_rq+0x139/0x160
> Call Trace:
>  <TASK>
>  ? intel_pstate_update_util+0x3b0/0x3b0
>  rq_offline_rt+0x1b7/0x250
>  set_rq_offline.part.120+0x28/0x60
>  rq_attach_root+0xc4/0xd0
>  cpu_attach_domain+0x3dc/0x7f0
>  ? __schedule+0x65e/0x1310
>  partition_sched_domains_locked+0x2a5/0x3c0
>  rebuild_sched_domains_locked+0x477/0x830
>  ? percpu_rwsem_wait+0x140/0x140
>  rebuild_sched_domains+0x1b/0x30
>  cpuset_hotplug_workfn+0x2ca/0xc90
>  ? balance_push+0x56/0x120
>  ? _raw_spin_unlock+0x15/0x30
>  ? finish_task_switch+0x98/0x2f0
>  ? __switch_to+0x116/0x410
>  ? __schedule+0x65e/0x1310 ? internal_add_timer+0x42/0x60
>  ? _raw_spin_unlock_irqrestore+0x23/0x40
>  ? add_timer_on+0xd5/0x130
>  process_one_work+0x1bc/0x3d0
>  worker_thread+0x4c/0x380
>  ? preempt_count_add+0x56/0xa0
>  ? rescuer_thread+0x310/0x310
>  kthread+0xe6/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>
> More detailed key function call graph:
> rq_offline_rt()
>   __disable_runtime()
>     sched_rt_rq_enqueue()
>       enqueue_top_rt_rq()
>         cpufreq_update_util() <-- depends on CONFIG_CPU_FREQ
>           data->func(data, *rq_clock(rq)*, flags)
>             intel_pstate_update_util() <-- powersave policy callback function
>
> Before calling set_rq_offline() we need to update the rq clock to avoid
> using the old rq clock, and use rq_lock_irqsave()/rq_unlock_irqrestore()
> to replace raw_spin_rq_lock_irqsave()/raw_spin_rq_unlock_irqrestore() to
> ensure that rq->clock_update_flags are cleared before updating the rq
> clock.
>
> Steps to reproduce:
> 1. Enable CONFIG_SMP and CONFIG_CPU_FREQ when compiling the kernel
> 2. echo 1 > /sys/kernel/debug/clear_warn_once
> 3. cpupower -c all frequency-set -g powersave
> 4. Run some rt tasks e.g. Create 5*n rt (100% running) tasks (on a
>    system with n CPUs)
> 5. Offline cpu one by one until the warninng is triggered
>
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/topology.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6682535e37c8..b89497696880 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -487,15 +487,17 @@ static void free_rootdomain(struct rcu_head *rcu)
>  void rq_attach_root(struct rq *rq, struct root_domain *rd)
>  {
>         struct root_domain *old_rd = NULL;
> -       unsigned long flags;
> +       struct rq_flags rf;
>
> -       raw_spin_rq_lock_irqsave(rq, flags);
> +       rq_lock_irqsave(rq, &rf);
>
>         if (rq->rd) {
>                 old_rd = rq->rd;
>
> -               if (cpumask_test_cpu(rq->cpu, old_rd->online))
> +               if (cpumask_test_cpu(rq->cpu, old_rd->online)) {
> +                       update_rq_clock(rq);
>                         set_rq_offline(rq);
> +               }
>
>                 cpumask_clear_cpu(rq->cpu, old_rd->span);
>
> @@ -515,7 +517,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
>         if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
>                 set_rq_online(rq);
>
> -       raw_spin_rq_unlock_irqrestore(rq, flags);
> +       rq_unlock_irqrestore(rq, &rf);
>
>         if (old_rd)
>                 call_rcu(&old_rd->rcu, free_rootdomain);
> --
> 2.37.0
>
