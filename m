Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9B172B53B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 03:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjFLB5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 21:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFLB5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:57:43 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C6C1B9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 18:57:42 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-56d1ca11031so8701287b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1686535061; x=1689127061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WRMXdRW88ppStcWyJhaZVvKNZHentgg2ibSVuxx6Lo=;
        b=mSLZo/xpDq+9c41jd0JrFqDGC2y1MRW9jDU5zBd/Z1C/glv4zVNwe/Ts0Smx0HxO50
         1OivTvwliQlRmAZWI+x227wNDn1jEzKL2Vpa4Q6SIBdxbiLUwNBirNvZf2ZhWqDJuVHS
         4N2ForEszKRtYYuUzF3o6+hwpfXG+6Y9+tNmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686535061; x=1689127061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WRMXdRW88ppStcWyJhaZVvKNZHentgg2ibSVuxx6Lo=;
        b=MxMZSFfQ7ZnLLVIhMQHsSzW1gN1QJ0drRrempunj/q5wK54ER24rqkxQ2vCTJXp1jn
         CF/hQPHhBbeFJ56VqSdRAE8bcA0thmEirPjHXeL7wCG/eYZ/408RHTIdiWsgEhB414e1
         qfiDn8qp3HQX97OFz38lY0RoVF988A1xAH+LiNlMoW6Znf1BWjyJJrc6Xd5ef719VdVw
         yaXtkgQo7JOzFaC+Qd/YtM+FEQczbKdlHiZ2TnQN28ykSNhE7jBKyNpLYuEiTl1rggEi
         jX+cmziJgw9Cn/Iddz9D35TW1eNC6uGwKoRRbTk5u58n1r4fVmrp2q21K63EOvI0gzdz
         lhOQ==
X-Gm-Message-State: AC+VfDxR2a05ZHfBWaf8yzu0hMdjBXdAA3bUu1plplyzm2+v3ILX5ku6
        rQVoax4k0THyTvqWThonTviLHiXTqAZe6s+3XayBwQ==
X-Google-Smtp-Source: ACHHUZ7V49fwhWWTGIFvEFVvZ59Lsxy+B9IIL32srDHwf9YcSIvjHpZmra7QX/H/GlM2KcgoJQdjEDjqOgneh+ceoBQ=
X-Received: by 2002:a0d:f9c4:0:b0:565:a8dd:c6f4 with SMTP id
 j187-20020a0df9c4000000b00565a8ddc6f4mr8953716ywf.33.1686535061205; Sun, 11
 Jun 2023 18:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686239016.git.bristot@kernel.org> <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
In-Reply-To: <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 11 Jun 2023 21:57:35 -0400
Message-ID: <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 8, 2023 at 11:58=E2=80=AFAM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> From: Juri Lelli <juri.lelli@redhat.com>
>
> Starting deadline server for lower priority classes right away when
> first task is enqueued might break guarantees, as tasks belonging to
> intermediate priority classes could be uselessly preempted. E.g., a well
> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
> there are still CPU cycles available for NORMAL tasks to run, as they'll
> be running inside the fair deadline server for some period of time.
>
> To prevent this issue, implement a starvation monitor mechanism that
> starts the deadline server only if a (fair in this case) task hasn't
> been scheduled for some interval of time after it has been enqueued.
> Use pick/put functions to manage starvation monitor status.

Me and Vineeth were discussing that another way of resolving this
issue is to use a DL-server for RT as well, and then using a smaller
deadline  for RT. That way the RT is more likely to be selected due to
its earlier deadline/period.

Another approach could be to implement the 0-laxity scheduling as a
general SCHED_DEADLINE feature, perhaps through a flag. And allow DL
tasks to opt-in to 0-laxity scheduling unless there are idle cycles.
And then opt-in the feature for the CFS deadline server task.

Lastly, if the goal is to remove RT throttling code eventually, are
you also planning to remove RT group scheduling as well? Are there
users of RT group scheduling that might be impacted? On the other
hand, RT throttling / group scheduling code can be left as it is
(perhaps documenting it as deprecated) and the server stuff can be
implemented via a CONFIG option.

 - Joel

> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  kernel/sched/fair.c  | 57 ++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/sched.h |  4 ++++
>  2 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f493f05c1f84..75eadd85e2b3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6315,6 +6315,53 @@ static int sched_idle_cpu(int cpu)
>  }
>  #endif
>
> +
> +static void fair_server_watchdog(struct timer_list *list)
> +{
> +       struct rq *rq =3D container_of(list, struct rq, fair_server_wd);
> +       struct rq_flags rf;
> +
> +       rq_lock_irqsave(rq, &rf);
> +       rq->fair_server_wd_running =3D 0;
> +
> +       if (!rq->cfs.h_nr_running)
> +               goto out;
> +
> +       update_rq_clock(rq);
> +       dl_server_start(&rq->fair_server);
> +       rq->fair_server_active =3D 1;
> +       resched_curr(rq);
> +
> +out:
> +       rq_unlock_irqrestore(rq, &rf);
> +}
> +
> +static inline void fair_server_watchdog_start(struct rq *rq)
> +{
> +       if (rq->fair_server_wd_running || rq->fair_server_active)
> +               return;
> +
> +       timer_setup(&rq->fair_server_wd, fair_server_watchdog, 0);
> +       rq->fair_server_wd.expires =3D jiffies + FAIR_SERVER_WATCHDOG_INT=
ERVAL;
> +       add_timer_on(&rq->fair_server_wd, cpu_of(rq));
> +       rq->fair_server_active =3D 0;
> +       rq->fair_server_wd_running =3D 1;
> +}
> +
> +static inline void fair_server_watchdog_stop(struct rq *rq, bool stop_se=
rver)
> +{
> +       if (!rq->fair_server_wd_running && !stop_server)
> +               return;
> +
> +       del_timer(&rq->fair_server_wd);
> +       rq->fair_server_wd_running =3D 0;
> +
> +       if (stop_server && rq->fair_server_active) {
> +               dl_server_stop(&rq->fair_server);
> +               rq->fair_server_active =3D 0;
> +       }
> +}
> +
>  /*
>   * The enqueue_task method is called before nr_running is
>   * increased. Here we update the fair scheduling stats and
> @@ -6337,7 +6384,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct=
 *p, int flags)
>         util_est_enqueue(&rq->cfs, p);
>
>         if (!rq->cfs.h_nr_running)
> -               dl_server_start(&rq->fair_server);
> +               fair_server_watchdog_start(rq);
>
>         /*
>          * If in_iowait is set, the code below may not trigger any cpufre=
q
> @@ -6484,7 +6531,7 @@ static void dequeue_task_fair(struct rq *rq, struct=
 task_struct *p, int flags)
>
>  dequeue_throttle:
>         if (!rq->cfs.h_nr_running)
> -               dl_server_stop(&rq->fair_server);
> +               fair_server_watchdog_stop(rq, true);
>
>         util_est_update(&rq->cfs, p, task_sleep);
>         hrtick_update(rq);
> @@ -8193,6 +8240,7 @@ done: __maybe_unused;
>                 hrtick_start_fair(rq, p);
>
>         update_misfit_status(p, rq);
> +       fair_server_watchdog_stop(rq, false);
>
>         return p;
>
> @@ -8248,6 +8296,8 @@ void fair_server_init(struct rq *rq)
>         dl_se->dl_period =3D 20 * TICK_NSEC;
>
>         dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick=
);
> +
> +       rq->fair_server_wd_running =3D 0;
>  }
>
>  /*
> @@ -8262,6 +8312,9 @@ static void put_prev_task_fair(struct rq *rq, struc=
t task_struct *prev)
>                 cfs_rq =3D cfs_rq_of(se);
>                 put_prev_entity(cfs_rq, se);
>         }
> +
> +       if (rq->cfs.h_nr_running)
> +               fair_server_watchdog_start(rq);
>  }
>
>  /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d4a7c0823c53..cab5d2b1e71f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -353,6 +353,7 @@ extern void dl_server_init(struct sched_dl_entity *dl=
_se, struct rq *rq,
>                     dl_server_has_tasks_f has_tasks,
>                     dl_server_pick_f pick);
>
> +#define FAIR_SERVER_WATCHDOG_INTERVAL (HZ >> 1)
>  extern void fair_server_init(struct rq *);
>
>  #ifdef CONFIG_CGROUP_SCHED
> @@ -1018,6 +1019,9 @@ struct rq {
>         struct dl_rq            dl;
>
>         struct sched_dl_entity  fair_server;
> +       int                     fair_server_active;
> +       struct timer_list       fair_server_wd;
> +       int                     fair_server_wd_running;
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         /* list of leaf cfs_rq on this CPU: */
> --
> 2.40.1
>
