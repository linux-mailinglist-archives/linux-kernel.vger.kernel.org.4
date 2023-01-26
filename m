Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2E67C943
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjAZK4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbjAZK4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:56:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EFE4C6EF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:56:21 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so2481414lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7zOHCJG/zldQ4ZvU6SDQUgDOBhZVd1AwPuOd2MQ49rs=;
        b=rHurrhFVTylUXxRwnQUhveauRUtuHE4yaXE7/Qw5H0sxXiEzs/nNECJdNukPyiGhd5
         jcjnkWMXck8aP3vTLw13cBHcC/D/4vm9Sq8Pg5vfikSFOA+wlqZZzUFP87VodV6/ttxu
         Uq2Wc8CDJPFN3sLOjEo2jgn98JPffByVX+5f9qRMWOszLPvhuFcR/jM3F4Ffq1GG66jX
         hkZ8vA8Kl93iD6MawZEW62ZXaj2R2IquYfGH8AfH6SvATW98snQPSV5OP2rIK42Msvpc
         e+KeHT/S9+E7vzQkkToTfEA9OXSXzc86ziRginTQagsKUrcGBIe9muH1VgbzGstcqNHS
         QbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zOHCJG/zldQ4ZvU6SDQUgDOBhZVd1AwPuOd2MQ49rs=;
        b=MRIt0vtvBrTVQ2z/y+gO5Wa5JMb/9mHzHTqLvuqVIWsp7My4xwODu2jjVHRse3GwLj
         R4cjiwuSlbF+gayCMdxbCUysYTWHBabgmrunbYh0Zlbfb0YR7aJUvlRzGVko6++i3OQ5
         l0ztjUrRRxF1DPHzq4dLm9Y+Knc3T7XgVZuN5WpsRxKuTzrcL6CMj2+JzcQLq9rCJyEF
         zN/xvcg1axb+xPsqCHIuWulVE340WZrRaTqFRH4F75vemogQZwnDOsnOcuk/JCGNEDEJ
         uFvxMBDnrSPIRT9xpAFgrT1T0QlvbzAwow1u7C7171mrydQHqiLMC3iwYPhB2LGDX69T
         j2ZQ==
X-Gm-Message-State: AFqh2kqpcCmSWrVo8V1R5q8lxHRXVw6JAmnM1R89+leHd1BpxfzogCy9
        Sx0glXuHW2CxcPcVKG+CxgwMPpi/nOtXYLXhEgG0xg==
X-Google-Smtp-Source: AMrXdXuVV0yfBBer5XUVf47/brh4xbY8T+52ETFCmggN/6zTEZLNh8RyDU6jVMaPDM/oDml/aPMB/jP48NGZn9/0pk0=
X-Received: by 2002:ac2:592e:0:b0:4d3:cf94:ab07 with SMTP id
 v14-20020ac2592e000000b004d3cf94ab07mr1506369lfi.179.1674730579195; Thu, 26
 Jan 2023 02:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20221216171807.760147-1-dvyukov@google.com> <20230112112411.813356-1-dvyukov@google.com>
 <20230125124304.GA13746@redhat.com> <20230125151717.GB13746@redhat.com>
 <CACT4Y+YKy_4mBLYomr49+fTm31Y6Q_kXhJz8O-_RTjMe=B-6eg@mail.gmail.com> <20230125163137.GC13746@redhat.com>
In-Reply-To: <20230125163137.GC13746@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 26 Jan 2023 11:56:06 +0100
Message-ID: <CACT4Y+Y9ZRAzKS=nY57_xoGL-Fy2JjZT-2BasMHMcONcxnBcyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] posix-timers: Support delivery of signals to the
 current thread
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, 25 Jan 2023 at 17:31, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 01/25, Dmitry Vyukov wrote:
> >
> > > diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> > > index 5dead89308b7..e38b53a0f814 100644
> > > --- a/kernel/time/posix-timers.c
> > > +++ b/kernel/time/posix-timers.c
> > > @@ -336,6 +336,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
> > >  int posix_timer_event(struct k_itimer *timr, int si_private)
> > >  {
> > >         enum pid_type type;
> > > +       struct pid *pid;
> > >         int ret;
> > >         /*
> > >          * FIXME: if ->sigq is queued we can race with
> > > @@ -350,8 +351,9 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
> > >          */
> > >         timr->sigq->info.si_sys_private = si_private;
> > >
> > > -       type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
> > > -       ret = send_sigqueue(timr->sigq, timr->it_pid, type);
> > > +       type = (timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_PID : PIDTYPE_TGID;
> > > +       pid = (type == PIDTYPE_PID) ? timr->it_pid : task_pid(current);
> > > +       ret = send_sigqueue(timr->sigq, pid, type);
> > >         /* If we failed to send the signal the timer stops. */
> > >         return ret > 0;
> > >  }
> >
> > Hi Oleg,
> >
> > This is indeed much simpler!
> >
> > Do I understand correctly that:
> > 1. I would need to use SIGEV_SIGNAL (without SIGEV_THREAD_ID)
>
> Yes,
>
> > 2. The signal is still queued into process shared_pending
>
> Yes. But just in case, please note that if this signal is not realtime
> (sigev_signo < SIGRTMIN) and it is already queued, it will be dropped.
> And I do not know if this can work for you.
>
> However this is what we already have with SIGEV_SIGNAL w/o SIGEV_THREAD_ID,
> and the same is true for SIGEV_THREAD_ID if the signal is already pending in
> target_task->pending.
>
> > 3. If the current task has not blocked the signal (it shouldn't), then
> > it won't kick any other task
>
> Yes,
>
> > 4. The current task will likely deliver the signal right on the timer
> > interrupt return to userspace
> > ?
>
> Yes.
>
> But! I just noticed send_sigqueue() does pid_task(pid, type), so the patch
> above needs another change
>
>
>         --- a/kernel/signal.c
>         +++ b/kernel/signal.c
>         @@ -1970,7 +1970,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>
>                 ret = -1;
>                 rcu_read_lock();
>         -       t = pid_task(pid, type);
>         +       // comment to explain why don't we use "type"
>         +       t = pid_task(pid, PIDTYPE_PID);
>                 if (!t || !likely(lock_task_sighand(t, &flags)))
>                         goto ret;
>
>
>
> > This changes the existing behavior (the "average bear" may be surprised :))
> > https://elixir.bootlin.com/linux/v6.2-rc5/source/kernel/signal.c#L1007
>
> this comment looks a bit misleading, s/main thread/target thread/
>
> > But currnently it's also queued into shared_pending and any thread
> > could get the signal anyway. So I think this should be fine.
>
> Yes.
>
> > On the positive side: it should improve performance. Delivering to the
> > currently running task is better on all fronts (no kicking,
> > rescheduling, IPIs, better locality), right?
>
> Well, iiuc this was the goal of your patch ? ;)

No, it actually is not. The actual goal is sampling activity of
threads. For CLOCK_PROCESS_CPUTIME_ID timers you get signals
proportional to the total activity of all threads (good), but all
signals are delivered to the main thread w/o even indication of what
thread caused the signal (questionable).
