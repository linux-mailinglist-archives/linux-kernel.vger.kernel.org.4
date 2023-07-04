Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6623747295
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGDNUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjGDNUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:20:06 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BE91732
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:19:46 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so91065551fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1688476784; x=1691068784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBGvKJ2raiXHwqCxo5f1RgualxPoi7vbtFSakbXU4rI=;
        b=MIwhp176yCo2oeFytKDt/P81xuVIswC3q98hyWwlSTNc3bMZ9encq9LC83jA8/4hEy
         wIUuiLUP1P2PFT30Vb2nJKvAf5xnKpRcH0clAOJ9VMgZ3AqIQSIUxAQ/D/MMEP0bktbS
         b/ek8LQXuCih/Ex9SFtyRH7nLMkB5vT9IJmzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688476784; x=1691068784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBGvKJ2raiXHwqCxo5f1RgualxPoi7vbtFSakbXU4rI=;
        b=TFdN+VoW3phFZSVAUZOhT9LuZxJNf2jBlWhL6e+Qwm99G8Qxa/eAQC6U9VbSk77nUG
         CyTslvvtAq6IN/35Do5jjx9PT3jMMz6xM2xW15i22E/jy7JPna0UMoBnX0oroIz+6hC5
         Apas1ATWqiJn4hJVyE8zSGZ2meV1GOzoz8W8pKt4UXw7fzIyJhLaw+LNiEWzJZb2xEZD
         3o05KvkH3rgDSeL1PT3BY102WwIx7ONcSVMcIvYdDa/Fxg3XmVIdn++wB4vhafe7dGr+
         QQhmuyysOAdcqV5uzsDTWjY0M6VaQW5OWgbgrhcAeiM6rr6u1TavDWS5Y6t7VokU6Di6
         ma7Q==
X-Gm-Message-State: ABy/qLZpj6R4ytfBP1j9Lbz3XvNkNXy9qRCsiTL3ZiXA30oSteBfWUP8
        wxsPMMuw3K2MSkYy7w+WXvBX3afwnaCscNfTSO5Omw==
X-Google-Smtp-Source: APBJJlF/Id93QzmcWeur89f4EyZYN//iy5DLKx1CS2z+nh8M7OSy5VE5SnDBJ4YaSz+AZ8t+AzIvmTvm1JMd9+eGdJA=
X-Received: by 2002:a2e:9d86:0:b0:2b6:cf0f:1fbf with SMTP id
 c6-20020a2e9d86000000b002b6cf0f1fbfmr8910419ljj.42.1688476783946; Tue, 04 Jul
 2023 06:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com> <20230704053946.GA658436@ziqianlu-dell>
In-Reply-To: <20230704053946.GA658436@ziqianlu-dell>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 4 Jul 2023 09:19:32 -0400
Message-ID: <CAEXW_YQpv8Ha5Yx=OthBiELt0BovuuLTe1kO9=R2PptkWsHHvA@mail.gmail.com>
Subject: Re: [PATCH v3] sched/core: introduce sched_core_idle_cpu()
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Cruz Zhao <CruzZhao@linux.alibaba.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, boqun.feng@gmail.com,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, jstultz@google.com,
        clingutla@codeaurora.org, nsaenzju@redhat.com, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 1:40=E2=80=AFAM Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Thu, Jun 29, 2023 at 12:02:04PM +0800, Cruz Zhao wrote:
> > As core scheduling introduced, a new state of idle is defined as
> > force idle, running idle task but nr_running greater than zero.
> >
> > If a cpu is in force idle state, idle_cpu() will return zero. This
> > result makes sense in some scenarios, e.g., load balance,
> > showacpu when dumping, and judge the RCU boost kthread is starving.
> >
> > But this will cause error in other scenarios, e.g., tick_irq_exit():
> > When force idle, rq->curr =3D=3D rq->idle but rq->nr_running > 0, resul=
ts
> > that idle_cpu() returns 0. In function tick_irq_exit(), if idle_cpu()
> > is 0, tick_nohz_irq_exit() will not be called, and ts->idle_active will
> > not become 1, which became 0 in tick_nohz_irq_enter().
> > ts->idle_sleeptime won't update in function update_ts_time_stats(), if
> > ts->idle_active is 0, which should be 1. And this bug will result that
> > ts->idle_sleeptime is less than the actual value, and finally will
> > result that the idle time in /proc/stat is less than the actual value.
> >
> > To solve this problem, we introduce sched_core_idle_cpu(), which
> > returns 1 when force idle. We audit all users of idle_cpu(), and
> > change idle_cpu() into sched_core_idle_cpu() in function
> > tick_irq_exit().
> >
> > v2-->v3: Only replace idle_cpu() with sched_core_idle_cpu() in
> > function tick_irq_exit(). And modify the corresponding commit log.
> >
> > Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> > Reviewed-by: Peter Zijlstra <peterz@infradead.org>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Reviewed-by: Joel Fernandes <joel@joelfernandes.org>
> > Link: https://lore.kernel.org/lkml/1687631295-126383-1-git-send-email-C=
ruzZhao@linux.alibaba.com
> > ---
> >  include/linux/sched.h |  2 ++
> >  kernel/sched/core.c   | 13 +++++++++++++
> >  kernel/softirq.c      |  2 +-
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index b09a83bfad8b..73e61c0f10a7 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2430,9 +2430,11 @@ extern void sched_core_free(struct task_struct *=
tsk);
> >  extern void sched_core_fork(struct task_struct *p);
> >  extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_=
type type,
> >                               unsigned long uaddr);
> > +extern int sched_core_idle_cpu(int cpu);
> >  #else
> >  static inline void sched_core_free(struct task_struct *tsk) { }
> >  static inline void sched_core_fork(struct task_struct *p) { }
> > +static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu);=
 }
> >  #endif
> >
> >  extern void sched_set_stop_task(int cpu, struct task_struct *stop);
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 71c1a0f232b4..c80088956987 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7286,6 +7286,19 @@ struct task_struct *idle_task(int cpu)
> >       return cpu_rq(cpu)->idle;
> >  }
> >
> > +#ifdef CONFIG_SCHED_CORE
> > +int sched_core_idle_cpu(int cpu)
> > +{
> > +     struct rq *rq =3D cpu_rq(cpu);
> > +
> > +     if (sched_core_enabled(rq) && rq->curr =3D=3D rq->idle)
> > +             return 1;
>
> If the intention is to consider forced idle cpus as idle, then should
> the above condition written as:
>
>         if (sched_core_enabled(rq) && rq->core->core_forceidle_count)
>                 return 1;
> ?
>
> Or as long as a single cookied task is running, all normal idle cpus are
> regarded forced idle here and 1 is returned while previously, idle_cpu()
> is called for those cpus and if they have wakeup task pending, they are
> not regarded as idle so looks like a behaviour change.
>

Ah you're right, great insight. _sigh_ I should not have missed that
during review. It will change idle_cpu() behavior if core sched is
enabled...

 - Joel
