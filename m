Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C568366A539
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjAMVkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjAMVkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:40:00 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D4B851
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:39:58 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4db05a4db9bso80162137b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yzardt2FwxVZJ2DLRLd08YoMu52l4Jh0UvvdOlCjplY=;
        b=iQhKtL//flevk+6/GtQbGu8Xu7LsQCBFmA0aDjZHOnt61jKeEU9gB0YLspV/MazHxT
         KrHu4enP10I2nUWw1hgYajR6OToC1jmU8vCOEcY518ydHc25eOmG1R2cQZiLEH5T3ybc
         e8ssePUWA3E7hXlV84SNK0Zj25DLk3Op0A7pNWvppIzpQmn76o+tdCLj1BsnKZMz+yov
         G+w+jbd19wF2VTvKfQkmBoicmKcrxBgjRKy7Eq5LBM4sKuYBFen3+GAUnXYIAS/94NDJ
         eHO11cgriEurn4ieb5tG4oWw6QAaqvHgcE5eKOA4sUsSdu+0lt0itgNo4/7o5zLbT41g
         IMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzardt2FwxVZJ2DLRLd08YoMu52l4Jh0UvvdOlCjplY=;
        b=SkzuNpTxsPhLV73PUp4Ksepct+C1ggVC/ucMMzCPmRfAidiY2CgB+LD83KAUl+hBvl
         nOr0VO3Pj95DENY91utsbZd6ATxTsgjTzVclB6229mNgfKS5zb7eJ9TlhIxlf1hwH55W
         QmOC+CSlVuiKEL7iqzPuYhsp4O9ctR1CFS+5e5Z89bNgrqj6JarmbT3nTBqA+RdLBe0e
         mRIVfPu7rwlhnmZnMolhkpqxdNP23hILInCQ5a+iKWpsAEjgrDWFeMloAMZCIBguqTQs
         zeLimsagv5+2J3qmKHHnlp6uV8lXncGYGW/M3TlppS/kkAsTqJsgfj5Gmf5Obm/t6BNa
         vkJQ==
X-Gm-Message-State: AFqh2kpU7dgBewqUAnaBRdjqyz2KBOLeBZHgRVbVmFVbiAt7po+L9AI/
        J6/afpIgXn5JEUTHqdGUf/vRx9DQ52yKcZigUdhXzQAE0cQ=
X-Google-Smtp-Source: AMrXdXvqaBu1ymnZDBo8FrrhNrNPpRPqiSpOwjb2/qXu0kGwbt7CZ4WEItfhIo7LDXlirPTsfyKOrmH/6QmgM3c0HK0=
X-Received: by 2002:a05:690c:e21:b0:4d0:f843:c376 with SMTP id
 cp33-20020a05690c0e2100b004d0f843c376mr1927433ywb.63.1673645997872; Fri, 13
 Jan 2023 13:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20230110213010.2683185-1-avagin@google.com> <20230110213010.2683185-3-avagin@google.com>
 <Y7+4S9umCo5I+Ty7@chenyu5-mobl1>
In-Reply-To: <Y7+4S9umCo5I+Ty7@chenyu5-mobl1>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 13 Jan 2023 13:39:46 -0800
Message-ID: <CANaxB-wcpKS64q6_0+r+OwoZupRN-A-PQvPRiVsMmEgB1TRSrw@mail.gmail.com>
Subject: Re: [PATCH 2/5] sched: add WF_CURRENT_CPU and externise ttwu
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Andrei Vagin <avagin@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 11:36 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> On 2023-01-10 at 13:30:07 -0800, Andrei Vagin wrote:
> > From: Peter Oskolkov <posk@google.com>
> >
> > Add WF_CURRENT_CPU wake flag that advices the scheduler to
> > move the wakee to the current CPU. This is useful for fast on-CPU
> > context switching use cases.
> >
> > In addition, make ttwu external rather than static so that
> > the flag could be passed to it from outside of sched/core.c.
> >
> > Signed-off-by: Peter Oskolkov <posk@google.com>
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > @@ -7380,6 +7380,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> >       if (wake_flags & WF_TTWU) {
> >               record_wakee(p);
> >
> > +             if ((wake_flags & WF_CURRENT_CPU) &&
> > +                 cpumask_test_cpu(cpu, p->cpus_ptr))
> > +                     return cpu;
> I agree that cross-CPU wake up brings pain to fast context switching
> use cases,  especially on high core count system. We suffered from this
> issue as well, so previously we presented this issue as well. The difference
> is that we used some dynamic "WF_CURRENT_CPU" mechanism[1] to deal with it.
> That is, if the waker/wakee are both short duration tasks, let the waker wakes up
> the wakee on current CPU. So not only seccomp but also other components/workloads
> could benefit from this without having to set the WF_CURRENT_CPU flag.
>
> Link [1]:
> https://lore.kernel.org/lkml/cover.1671158588.git.yu.c.chen@intel.com/

Thanks for the link. I like the idea, but this change has no impact on the
seccom notify case.  I used the benchmark from the fifth patch. It is
a ping-pong
benchmark in which one process triggers system calls, and another process
handles them. It measures the number of system calls that can be processed
within a specified time slice.

$ cd tools/testing/selftests/seccomp/
$ make
$ ./seccomp_bpf  2>&1| grep user_notification_sync
#  RUN           global.user_notification_sync ...
# seccomp_bpf.c:4281:user_notification_sync:basic: 8489 nsec/syscall
# seccomp_bpf.c:4281:user_notification_sync:sync: 3078 nsec/syscall
#            OK  global.user_notification_sync
ok 51 global.user_notification_sync

The results are the same with and without your change. I expected that
your change improves
the basic case so that it reaches the sync one.

I did some experiments and found that we can achieve the desirable
outcome if we move the "short-task" checks prior to considering waking
up on prev_cpu.

For example, with this patch:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f89e44e237d..af20b58e3972 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6384,6 +6384,11 @@ static int wake_wide(struct task_struct *p)
 static int
 wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 {
+       /* The only running task is a short duration one. */
+       if (cpu_rq(this_cpu)->nr_running == 1 &&
+           is_short_task(cpu_curr(this_cpu)))
+               return this_cpu;
+
        /*
         * If this_cpu is idle, it implies the wakeup is from interrupt
         * context. Only allow the move if cache is shared. Otherwise an
@@ -6405,11 +6410,6 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
        if (available_idle_cpu(prev_cpu))
                return prev_cpu;

-       /* The only running task is a short duration one. */
-       if (cpu_rq(this_cpu)->nr_running == 1 &&
-           is_short_task(cpu_curr(this_cpu)))
-               return this_cpu;
-
        return nr_cpumask_bits;
 }

@@ -6897,6 +6897,10 @@ static int select_idle_sibling(struct
task_struct *p, int prev, int target)
            asym_fits_cpu(task_util, util_min, util_max, target))
                return target;

+       if (!has_idle_core && cpu_rq(target)->nr_running == 1 &&
+           is_short_task(cpu_curr(target)) && is_short_task(p))
+               return target;
+
        /*
         * If the previous CPU is cache affine and idle, don't be stupid:
         */


the basic test case shows almost the same results as the sync one:

$ ./seccomp_bpf  2>&1| grep user_notification_sync
#  RUN           global.user_notification_sync ...
# seccomp_bpf.c:4281:user_notification_sync:basic: 3082 nsec/syscall
# seccomp_bpf.c:4281:user_notification_sync:sync: 2690 nsec/syscall
#            OK  global.user_notification_sync
ok 51 global.user_notification_sync

If you want to do any experiments, you can find my tree here:
[1] https://github.com/avagin/linux-task-diag/tree/wip/seccom-notify-sync-and-shed-short-task

Thanks,
Andrei
