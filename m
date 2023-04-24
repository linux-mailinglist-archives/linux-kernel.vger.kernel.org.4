Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B576A6ED4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjDXSoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjDXSoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F9F6183
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682361804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzfkRQJBM4MmbV2JBtc9KiZMKD+rx5eFNORnbfXZFvs=;
        b=Kt5wGxDR7DPAqBvRdyJDynDlIpWlB9aEMVkUCTqOOdboYOeNpUqHmqxOAO2bnNmNqUNbK9
        eGGrk17AUOmB6JX4LZEZXwC4D3EnKwsDVljvLQpLc+cgsJlluJGSTuUd2plbfecfnkm2AP
        E0hcs8ORDvOxLg/4YFG1f/ciYYrIMoM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-wJ7iHbDkNIOb4aYWSfTeRA-1; Mon, 24 Apr 2023 14:43:22 -0400
X-MC-Unique: wJ7iHbDkNIOb4aYWSfTeRA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2473661358eso4774478a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682361801; x=1684953801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzfkRQJBM4MmbV2JBtc9KiZMKD+rx5eFNORnbfXZFvs=;
        b=jVFdYc+inIfvYFIgjU0bIA2LEmL0gJbJcmnr+QO6HNdymZifaSd35EV3XtAbpfCbFD
         DR5Y9dR88wutFLhRFkQ6ri9IvUpJ0vSsRO6G+Ae/FxymacTk+rVvhkfDBAuzWWR6oSuM
         Qzi6AjklZMg1EWqej4te/CYDfbpkIr9zhdrRUqyKKbrXhu2UIxyvLBHBsOb2tgzE2pyw
         OspiIsScQ3/qx73uMTtsJhk+fWUDwK091GTgcd6tL41a/ARhoevQyCCdxAvbNiyOxlMv
         IiGf1gKRUpD1UIz/LysITVTbAXuVXQdsyPRPQxTE4ZD7I9VbJPiGWAyzDsu+6uIlJx08
         eeoQ==
X-Gm-Message-State: AAQBX9fObcMTkuOcITZDJdw0P4YLcqFF6y46DCtVTOxTqdhJpY4SuPX0
        KmDhKjmFPg9NgNoGOlXDv19a9zxN6uTXaHMF612UesqPCHkEAHwihXimdlvRvzjo/ZYpE3IhJN/
        LAfp1cBrLMN1tNYkTUySVaq4295o206B0xO0tKKWH
X-Received: by 2002:a17:90a:688e:b0:22b:b832:d32 with SMTP id a14-20020a17090a688e00b0022bb8320d32mr13936267pjd.9.1682361801464;
        Mon, 24 Apr 2023 11:43:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yk6OLILapJx0UkzZ2GOWu3Ep1E0dcem2aYG45zkD6xUJOT6EW8tVaCkQ26fJ0YWXJgut1Q2Hh5R8QyRX6jbb0=
X-Received: by 2002:a17:90a:688e:b0:22b:b832:d32 with SMTP id
 a14-20020a17090a688e00b0022bb8320d32mr13936242pjd.9.1682361801207; Mon, 24
 Apr 2023 11:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230414125532.14958-1-wander@redhat.com> <20230414125532.14958-3-wander@redhat.com>
 <9ff7ea3a-b48b-4cff-851e-179713393531@paulmck-laptop>
In-Reply-To: <9ff7ea3a-b48b-4cff-851e-179713393531@paulmck-laptop>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 24 Apr 2023 15:43:09 -0300
Message-ID: <CAAq0SUk_-yNgKTyY47+n2oKQ3KF1VYgp2zdScF9fJ5jWP5wKpQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] sched/task: Add the put_task_struct_atomic_safe() function
To:     paulmck@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, Hu Chunyu <chuhu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 3:09=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Apr 14, 2023 at 09:55:28AM -0300, Wander Lairson Costa wrote:
> > Due to the possibility of indirectly acquiring sleeping locks, it is
> > unsafe to call put_task_struct() in atomic contexts when the kernel is
> > compiled with PREEMPT_RT.
> >
> > To mitigate this issue, this commit introduces
> > put_task_struct_atomic_safe(), which schedules __put_task_struct()
> > through call_rcu() when PREEMPT_RT is enabled. While a workqueue would
> > be a more natural approach, we cannot allocate dynamic memory from
> > atomic context in PREEMPT_RT, making the code more complex.
> >
> > This implementation ensures safe execution in atomic contexts and
> > avoids any potential issues that may arise from using the non-atomic
> > version.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > Reported-by: Hu Chunyu <chuhu@redhat.com>
> > Cc: Paul McKenney <paulmck@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  include/linux/sched/task.h | 31 +++++++++++++++++++++++++++++++
> >  kernel/fork.c              |  8 ++++++++
> >  2 files changed, 39 insertions(+)
> >
> > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> > index b597b97b1f8f..5c13b83d7008 100644
> > --- a/include/linux/sched/task.h
> > +++ b/include/linux/sched/task.h
> > @@ -141,6 +141,37 @@ static inline void put_task_struct_many(struct tas=
k_struct *t, int nr)
> >
> >  void put_task_struct_rcu_user(struct task_struct *task);
> >
> > +extern void __delayed_put_task_struct(struct rcu_head *rhp);
> > +
> > +static inline void put_task_struct_atomic_safe(struct task_struct *tas=
k)
> > +{
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +             /*
> > +              * Decrement the refcount explicitly to avoid unnecessari=
ly
> > +              * calling call_rcu.
> > +              */
> > +             if (refcount_dec_and_test(&task->usage))
> > +                     /*
> > +                      * under PREEMPT_RT, we can't call put_task_struc=
t
> > +                      * in atomic context because it will indirectly
> > +                      * acquire sleeping locks.
> > +                      * call_rcu() will schedule delayed_put_task_stru=
ct_rcu()
> > +                      * to be called in process context.
> > +                      *
> > +                      * __put_task_struct() is called called when
> > +                      * refcount_dec_and_test(&t->usage) succeeds.
> > +                      *
> > +                      * This means that it can't "conflict" with
> > +                      * put_task_struct_rcu_user() which abuses ->rcu =
the same
> > +                      * way; rcu_users has a reference so task->usage =
can't be
> > +                      * zero after rcu_users 1 -> 0 transition.
> > +                      */
> > +                     call_rcu(&task->rcu, __delayed_put_task_struct);
>
> This will invoke __delayed_put_task_struct() with softirqs disabled.
> Or do softirq-disabled contexts count as non-atomic in PREEMPT_RT?
>

softirqs execute in thread context in PREEMPT_RT. We are good here.

>                                                         Thanx, Paul
>
> > +     } else {
> > +             put_task_struct(task);
> > +     }
> > +}
> > +
> >  /* Free all architecture-specific resources held by a thread. */
> >  void release_thread(struct task_struct *dead_task);
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 0c92f224c68c..9884794fe4b8 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -854,6 +854,14 @@ void __put_task_struct(struct task_struct *tsk)
> >  }
> >  EXPORT_SYMBOL_GPL(__put_task_struct);
> >
> > +void __delayed_put_task_struct(struct rcu_head *rhp)
> > +{
> > +     struct task_struct *task =3D container_of(rhp, struct task_struct=
, rcu);
> > +
> > +     __put_task_struct(task);
> > +}
> > +EXPORT_SYMBOL_GPL(__delayed_put_task_struct);
> > +
> >  void __init __weak arch_task_cache_init(void) { }
> >
> >  /*
> > --
> > 2.39.2
> >
>

