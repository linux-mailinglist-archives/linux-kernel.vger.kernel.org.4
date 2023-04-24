Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2176ED631
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjDXUfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjDXUfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964459D5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682368483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JN1IGL/TaESrMi+upCkUrmzEl8WBGHXt7c8jLIqZUK4=;
        b=c3URa2zASgz7rI5eQ148w7rq07zcVbWQuzZOP1ozCFihp5lsBs5CTsULIca5Qyv8PFQyRT
        ZuTYbpycUdr7AbJ9K2MPVFcHONqStQCdNmnfLvY3uTIkwxYDmnnmDt7zI62ZXJR8DZl0jJ
        F63v5qKIWzyAOERUl1rHhzirJAi4+sU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-1rYZtWY9PZebnbjoGOVfXw-1; Mon, 24 Apr 2023 16:34:41 -0400
X-MC-Unique: 1rYZtWY9PZebnbjoGOVfXw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2473661358eso4860183a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368481; x=1684960481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN1IGL/TaESrMi+upCkUrmzEl8WBGHXt7c8jLIqZUK4=;
        b=lYW7+Wk4gFiGW4HBWfU2y7ygCSzKWPllBDhq6LUjmklQjPOnupLucVJxvb/B08Th/1
         h/TpS1Jg/MXE5A6WscItZ7wb01+elS3mkvPUEgCK6K1RHT0g8laXZnpfvAJ24p0YLhTZ
         FwL/fY7JKcSHtbr3XMuqxqFS2SP3N34mZHWmfoMqTR6lJ/K3TEdo8spzOC1cCQCBrAMR
         1jCaOj8BkH1Vl+5H7DLDBrfj4m11rUJw2QfwOfLwEAbXniYvpC86aRXeqtq7sreQqfnG
         jl19AyRRjanCFCoiME/qUwGtKMHIcVWoIRA8GP99+UM1WrOXIta+DpS0nDXK638gQ3+T
         Z6wA==
X-Gm-Message-State: AAQBX9cZbIOlSTQSrgFy5YtTeeZDwYLOfS5UJMLqpHmefidk8Y4YA8pe
        lkcFoFLgIBPBoCelx8c+orptQQSSH9IhtjP19cQcXwOPUBtpgBZfnQI+Vz/ryebT8AU618pcTje
        qMZQAa50tYmrlstv7/Z92bvWxRnRfVmcLoijO1Gks
X-Received: by 2002:a17:90b:1957:b0:23d:376a:c2bc with SMTP id nk23-20020a17090b195700b0023d376ac2bcmr14048412pjb.5.1682368480743;
        Mon, 24 Apr 2023 13:34:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y6F7Wy3ZTaIemiiFddkpMr0+bZ/PTNM6b7RU8b78z+au5DlrI/36+Ow5jv/PW/Zgt6p+FD39n2PLobojWfK3Q=
X-Received: by 2002:a17:90b:1957:b0:23d:376a:c2bc with SMTP id
 nk23-20020a17090b195700b0023d376ac2bcmr14048395pjb.5.1682368480486; Mon, 24
 Apr 2023 13:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230414125532.14958-1-wander@redhat.com> <20230414125532.14958-3-wander@redhat.com>
 <9ff7ea3a-b48b-4cff-851e-179713393531@paulmck-laptop> <CAAq0SUk_-yNgKTyY47+n2oKQ3KF1VYgp2zdScF9fJ5jWP5wKpQ@mail.gmail.com>
 <105084b0-9d65-4896-97e4-35ef3c6f1fae@paulmck-laptop>
In-Reply-To: <105084b0-9d65-4896-97e4-35ef3c6f1fae@paulmck-laptop>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 24 Apr 2023 17:34:29 -0300
Message-ID: <CAAq0SUkJQtBzhrTiHEHH3LnL8nM7j7ebh_OsRhNUr9mNfrbROA@mail.gmail.com>
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

On Mon, Apr 24, 2023 at 3:52=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Apr 24, 2023 at 03:43:09PM -0300, Wander Lairson Costa wrote:
> > On Mon, Apr 24, 2023 at 3:09=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Fri, Apr 14, 2023 at 09:55:28AM -0300, Wander Lairson Costa wrote:
> > > > Due to the possibility of indirectly acquiring sleeping locks, it i=
s
> > > > unsafe to call put_task_struct() in atomic contexts when the kernel=
 is
> > > > compiled with PREEMPT_RT.
> > > >
> > > > To mitigate this issue, this commit introduces
> > > > put_task_struct_atomic_safe(), which schedules __put_task_struct()
> > > > through call_rcu() when PREEMPT_RT is enabled. While a workqueue wo=
uld
> > > > be a more natural approach, we cannot allocate dynamic memory from
> > > > atomic context in PREEMPT_RT, making the code more complex.
> > > >
> > > > This implementation ensures safe execution in atomic contexts and
> > > > avoids any potential issues that may arise from using the non-atomi=
c
> > > > version.
> > > >
> > > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > > Reported-by: Hu Chunyu <chuhu@redhat.com>
> > > > Cc: Paul McKenney <paulmck@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > ---
> > > >  include/linux/sched/task.h | 31 +++++++++++++++++++++++++++++++
> > > >  kernel/fork.c              |  8 ++++++++
> > > >  2 files changed, 39 insertions(+)
> > > >
> > > > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.=
h
> > > > index b597b97b1f8f..5c13b83d7008 100644
> > > > --- a/include/linux/sched/task.h
> > > > +++ b/include/linux/sched/task.h
> > > > @@ -141,6 +141,37 @@ static inline void put_task_struct_many(struct=
 task_struct *t, int nr)
> > > >
> > > >  void put_task_struct_rcu_user(struct task_struct *task);
> > > >
> > > > +extern void __delayed_put_task_struct(struct rcu_head *rhp);
> > > > +
> > > > +static inline void put_task_struct_atomic_safe(struct task_struct =
*task)
> > > > +{
> > > > +     if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > > +             /*
> > > > +              * Decrement the refcount explicitly to avoid unneces=
sarily
> > > > +              * calling call_rcu.
> > > > +              */
> > > > +             if (refcount_dec_and_test(&task->usage))
> > > > +                     /*
> > > > +                      * under PREEMPT_RT, we can't call put_task_s=
truct
> > > > +                      * in atomic context because it will indirect=
ly
> > > > +                      * acquire sleeping locks.
> > > > +                      * call_rcu() will schedule delayed_put_task_=
struct_rcu()
> > > > +                      * to be called in process context.
> > > > +                      *
> > > > +                      * __put_task_struct() is called called when
> > > > +                      * refcount_dec_and_test(&t->usage) succeeds.
> > > > +                      *
> > > > +                      * This means that it can't "conflict" with
> > > > +                      * put_task_struct_rcu_user() which abuses ->=
rcu the same
> > > > +                      * way; rcu_users has a reference so task->us=
age can't be
> > > > +                      * zero after rcu_users 1 -> 0 transition.
> > > > +                      */
> > > > +                     call_rcu(&task->rcu, __delayed_put_task_struc=
t);
> > >
> > > This will invoke __delayed_put_task_struct() with softirqs disabled.
> > > Or do softirq-disabled contexts count as non-atomic in PREEMPT_RT?
> >
> > softirqs execute in thread context in PREEMPT_RT. We are good here.
>
> So the sleeping lock is a spinlock rather than (say) a mutex?
>

Yes, under PREEMPT_RT, spinlocks are implemented in terms of rtmutex.

>                                                         Thanx, Paul
>
> > > > +     } else {
> > > > +             put_task_struct(task);
> > > > +     }
> > > > +}
> > > > +
> > > >  /* Free all architecture-specific resources held by a thread. */
> > > >  void release_thread(struct task_struct *dead_task);
> > > >
> > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > index 0c92f224c68c..9884794fe4b8 100644
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -854,6 +854,14 @@ void __put_task_struct(struct task_struct *tsk=
)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(__put_task_struct);
> > > >
> > > > +void __delayed_put_task_struct(struct rcu_head *rhp)
> > > > +{
> > > > +     struct task_struct *task =3D container_of(rhp, struct task_st=
ruct, rcu);
> > > > +
> > > > +     __put_task_struct(task);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(__delayed_put_task_struct);
> > > > +
> > > >  void __init __weak arch_task_cache_init(void) { }
> > > >
> > > >  /*
> > > > --
> > > > 2.39.2
> > > >
> > >
> >
>

