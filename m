Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F496C25B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCTXhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCTXhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:37:33 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8E312CF6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i36-20020a635424000000b0050f93a35888so779308pgb.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679355451;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFH+ciYuTQzx5Nk1oX1odRhD1AqCKchXXVpM5UqdETA=;
        b=WSGq8b1LzKL0lYoPuZ44BGDmNsLYB6V/ky63PH362uVgZlorv8Gr/MrcQPasMFjlAd
         4wrVnRPT+1mS2T8kbQxSUb21R+jgGLfJ5lDwtiiT7Nl1XcN0Br8w9QKJNzFtTXiLgXbT
         36vfh9tmNu6ez0U2bCauxBEIGmAQQ937h3b6EB71JH04E9BJpazLlREdBYkQzCYMjz8T
         HGF3c2dYomoRqcGHExy0zES4SFH30x/DdcayVwJuOfEqg7PQzOcsyslxHrWke4WFj3r2
         egsQVPdBu/7WZwq4JOAHr1SJ9q9ibwIXMSVRe5BF6Vju6/yreRkZzu0qZBAaDlmu+qDV
         yAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355451;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFH+ciYuTQzx5Nk1oX1odRhD1AqCKchXXVpM5UqdETA=;
        b=WaduZTsH+7Qdc0sBtLqv6lHBAbFOO74S8tBoea1b9O5vp+Vh09nrOf7/xVB73DHpCA
         Tg8uUqdfBZh7yB5r8R5p/E0SLudFkSoNz6ibXh9tjMKzuFB9+W7sUgs4fuhz8nS9nGTr
         GsJcIfKskhNkWhDAob2ks12l4vVY3zOyxKmMqPPros1YeT969F/opBIwDf7BUXdtPud3
         MbH3+OCGyasaScBYfQfb9ni9wPwqnmwrmVNiJUjAxijz2yfoAOjj3y0uzhTGjWqYqqBf
         RlngTQ/2PuA6OMfHQvhAZYqDxip83R2XKUKdayjlCQ+pnuVE5rBzKSLzZnliEVYq3JNV
         eGTQ==
X-Gm-Message-State: AO0yUKXkucfpABQepufZbV9SSjn+mYymu5dl352rhJyKtH2Pi4xycx9i
        LzUFJgzl0spoPLJ2dGwNu/Flocbrl2X6BmtGJ4QLX/F+c03o36hix0gIs9SechjBpHr8d6AkstX
        76GRBETmxxnhLaiH6wJjpMFVXJvfcCMMRQtJGj4WGcK++9FHUqt5pjy+OE02KRZiTe0k4pbM=
X-Google-Smtp-Source: AK7set+D65m8DKzKliyblvsinlfGOLoZjgBAU/Hq3ImHluY+29Eux36Tx2HR+V4hFOEKt6pOtjRPSneK9OhW
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:218f:b0:622:c6ad:b373 with SMTP
 id h15-20020a056a00218f00b00622c6adb373mr289713pfi.3.1679355451149; Mon, 20
 Mar 2023 16:37:31 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:37:08 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320233720.3488453-1-jstultz@google.com>
Subject: [PATCH v2 00/12] Reviving the Proxy Execution Series v2
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey All,

I=E2=80=99ve recently picked up the proxy execution effort, so I wanted to =
send
this out to share the current state of the patch series.

So first of all, this Proxy Execution series has a long history.
Starting from initial patches from Peter Zijlstra, then extended with
lots of work by Juri Lelli, Valentin Schneider, and Connor O'Brien.=20

So all the credit for this series really is due to the developers
above, while the mistakes are likely mine. :)  I wanted to particularly
appreciate Connor=E2=80=99s recent efforts, as I worked closely with him an=
d
it=E2=80=99s only due to his knowledge, patience, and clear explanations of=
 the
changes and issues that I was able to come to my current understanding
of the series so quickly.

Overview:
---------
I like to think of Proxy Execution as a generalized form of priority
inheritance. Classic priority inheritance works well for real-time tasks
where there is a straight forward priority order to how things are run.
But it breaks down when used between CFS tasks, as there are lots of
parameters involved outside of just the task=E2=80=99s nice value when sele=
cting
the next task to run (via pick_next_task()). So ideally we want to imbue
the mutex holder with all the scheduler attributes of the waiting task.

Proxy Execution tries to do this via a few changes:
* Keeping tasks that are blocked on a mutex *on* the runqueue
* Keeping additional tracking of which mutex a task is blocked on, and
  which task holds a specific mutex.
* Special handling for when we select a blocked task to run, so that we
  instead run the mutex holder.=20

The first of these is the most difficult to grasp (I do get the mental
friction here: blocked tasks on the *run*queue sounds like nonsense!
Personally I like to think of the runqueue in this model more like a
=E2=80=9Ctask-selection queue=E2=80=9D).

By leaving blocked tasks on the runqueue, we allow pick_next_task() to
choose the task that should run next (even if it=E2=80=99s blocked waiting =
on a
mutex). If we do select a blocked task, we look at the task=E2=80=99s block=
ed_on
mutex and from there look at the mutex=E2=80=99s owner task. And in the sim=
ple
case, the task which owns the mutex is what we then run, allowing it to
release the mutex.

This means that instead of just tracking =E2=80=9Ccurr=E2=80=9D, the schedu=
ler needs to
track both the scheduler context (what was picked and all the state used
for scheduling decisions), and the execution context (what we=E2=80=99re
running)

In this way, the mutex owner is run =E2=80=9Con behalf=E2=80=9D of the bloc=
ked task
that was picked to run, essentially inheriting the scheduler context of
the blocked task.

As Connor outlined in a previous submission[1] of this patch series,
this raises a number of complicated situations:  The mutex owner might
itself be blocked on another mutex, or it could be sleeping, running on
a different CPU, in the process of migrating between CPUs, etc.

But the functionality provided is useful, as in Android we have a number
of cases where we are seeing priority inversion (not unbounded, but
longer than we=E2=80=99d like) between =E2=80=9Cforeground=E2=80=9D and =E2=
=80=9Cbackground=E2=80=9D
SCHED_NORMAL applications, so having a generalized solution would be
great.


Issues still to address:
------------------------
The last time this patch series was submitted, a number of issues were
identified that need to be addressed:
* cputime accounting is a little unintuitive, as time used by the proxy
  was being charged to the blocked task. Connor began work to address
  this but it was not complete, so it is not included in this version of
  the series.
* RT/DL load balancing. There is a scheduling invariant that we always
  need to run the top N highest priority RT tasks across the N cpus.
  However keeping blocked tasks on the runqueue greatly complicates the
  load balancing for this. Connor took an initial stab at this with
  =E2=80=9Cchain level balancing=E2=80=9D included in this series. Feedback=
 on this
  would be appreciated!
* CFS load balancing. Blocked tasks may carry forward load (PELT) to the
  lock owner's CPU, so CPU may look like it is overloaded.
* Terminology/BikeShedding: I think much of the terminology makes these
  changes harder to reason about.
  - As noted above, blocked-tasks on the run-queue breaks some mental
    models
  - The =E2=80=9Cproxy=E2=80=9D relationship seems a bit inverted.  Peter=
=E2=80=99s =E2=80=9CSplit
    scheduler execution context=E2=80=9D describes the proxy as the schedul=
er
    context, and curr being the execution context (the blocked task
    being the =E2=80=9Cscheduler proxy=E2=80=9D for the lock-holder). Perso=
nally, I
    think of proxies as those who do-on-others-behalf, so to me it would
    make more sense to have rq_curr() be the selected task (scheduler
    context) and rq_proxy() be the run task (execution context), as its
    running on behalf of the selected but blocked task. Unless folks
    object, I=E2=80=99ll likely change this in a future submission.
  - Also, the rq_curr() and rq_proxy() distinction is easily confused. I
    think it=E2=80=99s sane to try to keep close to the existing curr based
    logic, but swapping rq_proxy in for some cases makes the change
    smaller, but the resulting code less clear. I worry folks focused on
    the !CONFIG_PROXY_EXEC case might easily mix up which to use when
    creating new logic.
* Resolving open questions in comments: I=E2=80=99ve left these in for now,=
 but
  I hope to review and try to make some choices where there are open
  questions. If folks have specific feedback or suggestions here, it
  would be great!

Performance:
------------
With the current patch series the mutexes are handed off, instead of
using optimistic spinning. This is a potential concern where locks are
under high contention. However, so far in our performance analysis (on
both x86 and mobile devices) we=E2=80=99ve not seen any major regressions. =
=20

Changes since Connor=E2=80=99s last submission:
---------------------------------------
* Connor took a swing at addressing the RT/DL load balancing issue=20
* Connor fixed a number of issues found in testing
* I added rq_curr() and rq_proxy() accessors to abstract rq->curr and
  rq->proxy references (so it collapses in the !CONFIG_PROXY_EXECUTION
  case)
* I=E2=80=99ve gone through the series trying to split up the larger functi=
ons
  and better conditionalize the logic on CONFIG_PROXY_EXECUTION
* I=E2=80=99ve broken out some of the logic in larger patches into separate
  patches, as well as split out small prep changes to the logic so the
  patches are easier to review.
* I=E2=80=99ve also found and addressed a few edge cases in locking and mut=
ex
  owner handling.
* I dropped the patch changing mutex::wait_lock to always save/restore irq
  flags (as Joel raised a concern that the patch wasn=E2=80=99t actually
  necessary).=20
* I=E2=80=99ve folded a number of fixes down into the relevant patches.=20

For the most part, my changes have been mechanical reworking of the
logic, avoiding any changes in behavior. Though after this, I=E2=80=99ll li=
kely
start trying to rework some of the logic further.

So while there is still more to do, I wanted to send this series out so
folks could see work is continuing, and be able to get some additional
review on recent changes.  Review and feedback would be greatly
appreciated!

If folks find it easier to test/tinker with, this patch series can also
be found here:
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v2-6.3-rc

Thanks so much!
-john

[1] https://lore.kernel.org/lkml/20221003214501.2050087-1-connoro@google.co=
m/

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com

Connor O'Brien (1):
  sched: Attempt to fix rt/dl load balancing via chain level balance

John Stultz (2):
  sched: Replace rq->curr access w/ rq_curr(rq)
  sched: Unnest ttwu_runnable in prep for proxy-execution

Juri Lelli (1):
  locking/mutex: Expose mutex_owner()

Peter Zijlstra (6):
  locking/ww_mutex: Remove wakeups from under mutex::wait_lock
  locking/mutex: Rework task_struct::blocked_on
  locking/mutex: Add task_struct::blocked_lock to serialize changes to
    the blocked_on state
  sched: Unify runtime accounting across classes
  sched: Split scheduler execution context
  sched: Add proxy execution

Valentin Schneider (2):
  locking/mutex: Add p->blocked_on wrappers
  sched/rt: Fix proxy/current (push,pull)ability

 include/linux/mutex.h        |   2 +
 include/linux/sched.h        |  24 +-
 include/linux/ww_mutex.h     |   3 +
 init/Kconfig                 |   7 +
 init/init_task.c             |   1 +
 kernel/Kconfig.locks         |   2 +-
 kernel/fork.c                |   6 +-
 kernel/locking/mutex-debug.c |   9 +-
 kernel/locking/mutex.c       | 103 ++++-
 kernel/locking/ww_mutex.h    |  10 +-
 kernel/sched/core.c          | 787 ++++++++++++++++++++++++++++++++---
 kernel/sched/core_sched.c    |   2 +-
 kernel/sched/cpudeadline.c   |  12 +-
 kernel/sched/cpudeadline.h   |   3 +-
 kernel/sched/cpupri.c        |  29 +-
 kernel/sched/cpupri.h        |   6 +-
 kernel/sched/deadline.c      | 213 ++++++----
 kernel/sched/debug.c         |   2 +-
 kernel/sched/fair.c          | 109 +++--
 kernel/sched/membarrier.c    |   8 +-
 kernel/sched/pelt.h          |   2 +-
 kernel/sched/rt.c            | 301 +++++++++-----
 kernel/sched/sched.h         | 286 ++++++++++++-
 kernel/sched/stop_task.c     |  13 +-
 24 files changed, 1599 insertions(+), 341 deletions(-)

--=20
2.40.0.rc1.284.g88254d51c5-goog

