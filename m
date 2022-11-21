Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A994C63184D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 02:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKUBth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 20:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUBtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 20:49:35 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5632E17425
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 17:49:34 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso12169384fac.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 17:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOvvz7AC03HY016IBZ0+39+PkZE1ENiZuuxYp2MLBKU=;
        b=dbljst5T32wd1IQF2Y4/Zd9FvfVSnCtLJO01/RSJcARo62r8ypIbNLPTXLwJHcgn+K
         jZdy6j+WVsZ6zhKZIhpE7WHh0dgbs731WYlfnHqz7Wb2BDk2Ici0OFmKgTULAh4tPCoS
         yxcG82yLeCdGyUU5zqP6nUIMhQmJ+x2Hy+jd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOvvz7AC03HY016IBZ0+39+PkZE1ENiZuuxYp2MLBKU=;
        b=YqEJGtnM0tuQqW/tbYPjTI4BR9SUoQC7V5dDWacES/UHpLlclFWsVtBX0CltkIWvRn
         rLxFBg8myKS8yFsFLAvFWgWEVORDTpG0ZFnMYw2dYAGE7PVjlLl6bUMaMqqNbOvmfNAU
         nzWzJmN8z4Fnb4qtb5Cz+L1GxqBXxm8X+Y81v4vEPIR5s5FDfQxg9Bzvb8fEQWaFsHtB
         nabVZlMyrP6W+HN/UPCCElDVgq/RTvQq+U5cXMzRvf6KfjxPtwYpHbjGm8c0gglPAIL/
         DRQZJyQu61VnUoJ/b3wpcWKcOyWBF62D4HVFEo57G41UGnq+OCDh6Um+ZKFmRlCfJpo1
         RixQ==
X-Gm-Message-State: ANoB5pm6mbzaYt1oWkSu7vkW/tXUo/TW7KlcU3mFET/xDz3P/AHDaHaF
        EqNQeJ6QM67ru2VmZigf0A2d7T1OWXMzVG9AHt7lwg==
X-Google-Smtp-Source: AA0mqf5cstt90roCgS8hiW0S+VE9VOx+SQacfgyXFkoFOWe2ZEPALG6b8fg3FLjGINpO13gnU94wCLFFLVXLLniGWvU=
X-Received: by 2002:a05:6870:591:b0:13b:bbbb:1623 with SMTP id
 m17-20020a056870059100b0013bbbbb1623mr1813123oap.115.1668995373270; Sun, 20
 Nov 2022 17:49:33 -0800 (PST)
MIME-Version: 1.0
References: <dab347c1-3724-8ac6-c051-9d2caea20101@arm.com> <34B2D8B9-A0C1-4280-944D-17224FB24339@joelfernandes.org>
 <4e396924-c3be-1932-91a3-5f458cc843fe@arm.com> <Y2ANPi7y5HhHvelr@google.com>
 <4ec6ab79-9f0f-e14b-dd06-d2840a1bf71a@arm.com> <Y3rEq7IFKjYA+/bj@google.com>
In-Reply-To: <Y3rEq7IFKjYA+/bj@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 20 Nov 2022 20:49:22 -0500
Message-ID: <CAEXW_YRwwiq=ZquiMqSvaTEDw=07H-GSaZKV2rrO9wv_TRyBHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Connor O'Brien" <connoro@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 7:22 PM Joel Fernandes <joel@joelfernandes.org> wro=
te:
>
> Hello Dietmar,
>
> On Fri, Nov 04, 2022 at 06:09:26PM +0100, Dietmar Eggemann wrote:
> > On 31/10/2022 19:00, Joel Fernandes wrote:
> > > On Mon, Oct 31, 2022 at 05:39:45PM +0100, Dietmar Eggemann wrote:
> > >> On 29/10/2022 05:31, Joel Fernandes wrote:
> > >>> Hello Dietmar,
> > >>>
> > >>>> On Oct 24, 2022, at 6:13 AM, Dietmar Eggemann <dietmar.eggemann@ar=
m.com> wrote:
> > >>>>
> > >>>> =EF=BB=BFOn 03/10/2022 23:44, Connor O'Brien wrote:
> > >>>>> From: Peter Zijlstra <peterz@infradead.org>
> >
> > [...]
> >
> > >>>>> +    rq_unpin_lock(rq, rf);
> > >>>>> +    raw_spin_rq_unlock(rq);
> > >>>>
> > >>>> Don't we run into rq_pin_lock()'s:
> > >>>>
> > >>>> SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=3D
> > >>>> &balance_push_callback)
> > >>>>
> > >>>> by releasing rq lock between queue_balance_callback(, push_rt/dl_t=
asks)
> > >>>> and __balance_callbacks()?
> > >>>
> > >>> Apologies, I=E2=80=99m a bit lost here. The code you are responding=
 to inline does not call rq_pin_lock, it calls rq_unpin_lock.  So what scen=
ario does the warning trigger according to you?
> > >>
> > >> True, but the code which sneaks in between proxy()'s
> > >> raw_spin_rq_unlock(rq) and raw_spin_rq_lock(rq) does.
> > >>
> > >
> > > Got it now, thanks a lot for clarifying. Can this be fixed by do a
> > > __balance_callbacks() at:
> >
> > I tried the:
> >
> >    head =3D splice_balance_callbacks(rq)
> >    task_rq_unlock(rq, p, &rf);
> >    ...
> >    balance_callbacks(rq, head);
> >
> > separation known from __sched_setscheduler() in __schedule() (right
> > after pick_next_task()) but it doesn't work. Lot of `BUG: scheduling
> > while atomic:`
>
> How about something like the following? This should exclude concurrent
> balance callback queues from other CPUs and let us release the rq lock ea=
rly
> in proxy(). I ran locktorture with your diff to make writer threads RT, a=
nd I
> cannot reproduce any crash with it:
>
> ---8<-----------------------
>
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] Exclude balance callback queuing during proxy's migrate
>
> In commit 565790d28b1e ("sched: Fix balance_callback()"), it is clear tha=
t rq
> lock needs to be held when __balance_callbacks() in schedule() is called.
> However, it is possible that because rq lock is dropped in proxy(), anoth=
er
> CPU, say in __sched_setscheduler() can queue balancing callbacks and caus=
e
> issues.
>
> To remedy this, exclude balance callback queuing on other CPUs, during th=
e
> proxy().
>
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/core.c  | 15 +++++++++++++++
>  kernel/sched/sched.h |  3 +++
>  2 files changed, 18 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 88a5fa34dc06..f1dac21fcd90 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6739,6 +6739,10 @@ proxy(struct rq *rq, struct task_struct *next, str=
uct rq_flags *rf)
>                 p->wake_cpu =3D wake_cpu;
>         }
>
> +       // Prevent other CPUs from queuing balance callbacks while we mig=
rate
> +       // tasks in the migrate_list with the rq lock released.
> +       raw_spin_lock(&rq->balance_lock);
> +
>         rq_unpin_lock(rq, rf);
>         raw_spin_rq_unlock(rq);
>         raw_spin_rq_lock(that_rq);
> @@ -6758,7 +6762,18 @@ proxy(struct rq *rq, struct task_struct *next, str=
uct rq_flags *rf)
>         }
>
>         raw_spin_rq_unlock(that_rq);
> +
> +       // This may make lockdep unhappy as we acquire rq->lock with bala=
nce_lock
> +       // held. But that should be a false positive, as the following pa=
ttern
> +       // happens only on the current CPU with interrupts disabled:
> +       // rq_lock()
> +       // balance_lock();
> +       // rq_unlock();
> +       // rq_lock();
>         raw_spin_rq_lock(rq);

Hmm, I think there's still a chance of deadlock here. I need to
rethink it a bit, but that's the idea I was going for.

thanks,

 - Joel


> +
> +       raw_spin_unlock(&rq->balance_lock);
> +
>         rq_repin_lock(rq, rf);
>
>         return NULL; /* Retry task selection on _this_ CPU. */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 354e75587fed..932d32bf9571 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1057,6 +1057,7 @@ struct rq {
>         unsigned long           cpu_capacity_orig;
>
>         struct callback_head    *balance_callback;
> +       raw_spinlock_t          balance_lock;
>
>         unsigned char           nohz_idle_balance;
>         unsigned char           idle_balance;
> @@ -1748,6 +1749,7 @@ queue_balance_callback(struct rq *rq,
>                        void (*func)(struct rq *rq))
>  {
>         lockdep_assert_rq_held(rq);
> +       raw_spin_lock(&rq->balance_lock);
>
>         /*
>          * Don't (re)queue an already queued item; nor queue anything whe=
n
> @@ -1760,6 +1762,7 @@ queue_balance_callback(struct rq *rq,
>         head->func =3D (void (*)(struct callback_head *))func;
>         head->next =3D rq->balance_callback;
>         rq->balance_callback =3D head;
> +       raw_spin_unlock(&rq->balance_lock);
>  }
>
>  #define rcu_dereference_check_sched_domain(p) \
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
