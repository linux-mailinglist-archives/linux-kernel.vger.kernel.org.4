Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174E56DD0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjDKEZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKEZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:25:21 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C501F10E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u11-20020a17090341cb00b001a22d27406bso3238957ple.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187119; x=1683779119;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txw2P2xHcqOfak5X3xQeip1kj1VePBIj5nW+3JRRlo4=;
        b=ZiGtEPjDeCcXyUNRMclNkCMETIOKY7XR7Gdi38Yt9XItUtjNEP20ZnL7heskcMpirF
         Px7JVD1DlR7rYBPaAI1W7EBFaFeLP/ha5zwCNzqsjge1SxG0fC15lMtPdFkvy6K6PXW9
         uQ/EnAdHoLw+II1Ub++jJacDLL6ESyZgsOa5AKLMgu8HuJnfDqNyRMckaun/uKOE26Wz
         iPCbqEJXZ2giLaS9CNBCjV3bR+1a5FI5XOvzXYvyNbdSmUKEACRG0yt6CRZEmN+vG8UA
         1G/Us8Lxg4NnMaKVTEj4nxHfv+oBxaoCYgBilCQhV7gcFQwyTUS5mnvza6RPpw0iG5Im
         tOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187119; x=1683779119;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txw2P2xHcqOfak5X3xQeip1kj1VePBIj5nW+3JRRlo4=;
        b=owfjO95I6ZKGQa9R9O2V9zzguMDx52+UCD+HKOvl8bw/3doKvGL+ZhlT7D/VMh6Wyf
         g7xKJO1/3CM1IIzI+DNAW4wUASDxRP/VcsHjklpsN9VQTtwcC+/2rpzocK148xy+yI8S
         pYam7EmF/U0v1OTHBkyhM9dCrVQNuuPHV62ubNt69euxh0kQyRhgWrKlszozS1S+P0Ij
         3rvhj/0aSruKc6KJB9GcecoHQEXeGEzGU61x4CiQCB/UCu6bgqZ4q6koqZq+/xIAmE5J
         eh5g+W7hl5XzU20NmQhzch3gvjVdjJAIPmwx97m/TzMa9xEt6KuO9dmWMTaaDDldLl7+
         L38g==
X-Gm-Message-State: AAQBX9f+LFVudDy4zcpk3lHkY/ZpgXePnMSBUK4QTM15qLANdk3RP/hi
        3bX/35BGwh+Pt6JRNUVQo0czdhAIVjjk1isWi6MHo7aPJNAeMrCwOM1WaLUttTCCe1G7RfsbucN
        A62uD0maTemEnuw43sAJ7o+BA+tvgRwhHPkszMhnunNnvV/9a3a6kTRLHKfsu6FusJGjtriI=
X-Google-Smtp-Source: AKy350ZnGFPUcxG1yLuGte2kr1+3bz8ta4e16g8EnrNEKwJbVNW49fENM8NSVoKBEkEjmdfrvF0g8ZotJeaD
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:9008:b0:1a0:440e:ecf9 with SMTP id
 a8-20020a170902900800b001a0440eecf9mr4467044plp.5.1681187119142; Mon, 10 Apr
 2023 21:25:19 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:24:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-1-jstultz@google.com>
Subject: [PATCH v3 00/14] Generalized Priority Inheritance via Proxy Execution v3
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
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned last time, this Proxy Execution series has a long history:
First described in a paper[1] by Watkins, Straub, Niehaus, then from
patches from Peter Zijlstra, extended with lots of work by Juri Lelli,
Valentin Schneider, and Connor O'Brien. (and thank you to Steven Rostedt
for providing additional details here!)

So again, many thanks to those above, as all the credit for this series
really is due to them - while the mistakes are likely mine.

Overview:
=E2=80=94----------
Proxy Execution is a generalized form of priority inheritance. Classic
priority inheritance works well for real-time tasks where there is a
straight forward priority order to how things are run. But it breaks
down when used between CFS tasks, as there are lots of parameters
involved outside of just the task=E2=80=99s nice value when selecting the n=
ext
task to run (via pick_next_task()).  So ideally we want to imbue the
mutex holder with all the scheduler attributes of the blocked waiting
task.

Proxy Execution does this via a few changes:
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
case, the task which owns the mutex is what we then choose to run,
allowing it to release the mutex.

This means that instead of just tracking =E2=80=9Ccurr=E2=80=9D, the schedu=
ler needs to
track both the scheduler context (what was picked and all the state used
for scheduling decisions), and the execution context (what we=E2=80=99re
running)

In this way, the mutex owner is run =E2=80=9Con behalf=E2=80=9D of the bloc=
ked task
that was picked to run, essentially inheriting the scheduler context of
the blocked task.

As Connor outlined in a previous submission of this patch series,  this
raises a number of complicated situations:  The mutex owner might itself
be blocked on another mutex, or it could be sleeping, running on a
different CPU, in the process of migrating between CPUs, etc.

But the functionality provided is useful, as in Android we have a number
of cases where we are seeing priority inversion (not unbounded, but
longer than we=E2=80=99d like) between =E2=80=9Cforeground=E2=80=9D and =E2=
=80=9Cbackground=E2=80=9D
SCHED_NORMAL applications, so having a generalized solution would be
very useful.

New in v3:
=E2=80=94------
* While not a functional change, the biggest rework in this version is
  probably my renaming of the rq->proxy (or rq_proxy() in v2) pointer to
  rq_selected() as I think it helps clarify the patch. Previously it was
  using =E2=80=9Cproxy=E2=80=9D as the name for the scheduler context, whic=
h is sort of
  inverted from how the idea is explained - the proxy in proxy execution
  should be the task running on behalf of the selected blocked task.=20

* Fix for cpu runtime accounting issue Joel Fernandes demonstrated in
  Connor=E2=80=99s earlier submission[2].  We now charge the running task f=
or
  cputime, but the vruntime accounting is charged to the selected task
  we=E2=80=99re running on behalf.

* As Deitmar earlier noticed[3], rq_pin_lock() was complaining w/
  SCHED_WARN when calls from pick_next_task() would queue callbacks,
  which would not be handled before the next call to rq_pin_lock().
  I=E2=80=99ve added extra calls to __balance_callbacks to address this and
  resolve the warnings.

* Re-added =E2=80=9Clocking/mutex: make mutex::wait_lock irq safe=E2=80=9D =
as in
  earlier review it was questioned if it was necessary, so I had dropped
  it in v2, but further testing found it tripping up lockdep pretty
  quickly.

* Fixed null pointer crashes in the deadline load balancing rework that
  additional testing uncovered.

* Build fixups Reported-by: kernel test robot <lkp@intel.com>


Issues still to address:
=E2=80=94----------
In preparation for OSPM next week, I wanted to go ahead and share the
patch series now, but there is still more to work on:

* Recently I=E2=80=99ve been tripping over a deadlock caused by what looks =
like
  a circular blocked_on relationship, which appears to be due to
  misaccounting the blocked_on pointer somewhere. I=E2=80=99m still digging=
 on
  this.

* RT/DL load balancing. There is a scheduling invariant that we always
  need to run the top N highest priority RT tasks across the N cpus.
  However keeping blocked tasks on the runqueue greatly complicates the
  load balancing for this. Connor took an initial stab at this with
  =E2=80=9Cchain level balancing=E2=80=9D included in this series. Feedback=
 on this
  would be appreciated!

* CFS load balancing.  Blocked tasks may carry forward load (PELT) to
  the lock owner's CPU, so CPU may look like it is overloaded.

* The cfs_rq->curr gets set in pick_next_task_fair() which means it
  points to the selected task, not the task to be run.  This muddies
  things as cfs_rq->curr and rq_curr() may point to different tasks.
  I suspect further renaming or pushing down the split context awareness
  will be needed for this to be cleaner.

* Resolving open questions in comments: I=E2=80=99ve left these in for now,=
 but
  I hope to review and try to make some choices where there are open
  questions. If folks have specific feedback or suggestions here, it
  would be great!

Performance:
=E2=80=94----------
This patch series switches mutexes to use handoff mode rather than
optimistic spinning. This is a potential concern where locks are under
high contention. However, so far in our initial performance analysis (on
both x86 and mobile devices) we=E2=80=99ve not seen any major regressions. =
That
said, Chenyu did report a regression[4], which we=E2=80=99ll need to look
further into.

Review and feedback would be greatly appreciated!

If folks find it easier to test/tinker with, this patch series can also
be found here:
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v3-6.3-rc6

Thanks so much!
-john

[1] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf
[2] https://lore.kernel.org/lkml/Y0y8iURTSAv7ZspC@google.com/
[3] https://lore.kernel.org/lkml/dab347c1-3724-8ac6-c051-9d2caea20101@arm.c=
om/
[4] https://lore.kernel.org/lkml/Y7vVqE0M%2FAoDoVbj@chenyu5-mobl1/

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

Connor O'Brien (1):
  sched: Attempt to fix rt/dl load balancing via chain level balance

John Stultz (3):
  sched: Replace rq->curr access w/ rq_curr(rq)
  sched: Unnest ttwu_runnable in prep for proxy-execution
  sched: Fix runtime accounting w/ proxy-execution

Juri Lelli (2):
  locking/mutex: make mutex::wait_lock irq safe
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
 kernel/locking/mutex.c       | 117 ++++-
 kernel/locking/ww_mutex.h    |  32 +-
 kernel/sched/core.c          | 802 ++++++++++++++++++++++++++++++++---
 kernel/sched/core_sched.c    |   2 +-
 kernel/sched/cpudeadline.c   |  12 +-
 kernel/sched/cpudeadline.h   |   3 +-
 kernel/sched/cpupri.c        |  29 +-
 kernel/sched/cpupri.h        |   6 +-
 kernel/sched/cputime.c       |   4 +-
 kernel/sched/deadline.c      | 220 ++++++----
 kernel/sched/debug.c         |   2 +-
 kernel/sched/fair.c          | 127 ++++--
 kernel/sched/idle.c          |   4 +-
 kernel/sched/membarrier.c    |  22 +-
 kernel/sched/pelt.h          |   2 +-
 kernel/sched/rt.c            | 301 +++++++++----
 kernel/sched/sched.h         | 282 +++++++++++-
 kernel/sched/stop_task.c     |  13 +-
 26 files changed, 1664 insertions(+), 370 deletions(-)

--=20
2.40.0.577.gac1e443424-goog

