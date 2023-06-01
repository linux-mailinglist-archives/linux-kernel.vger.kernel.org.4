Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAAF7192D3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjFAF7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjFAF66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:58:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D779D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:58:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561eb6c66f6so6326567b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685599135; x=1688191135;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNixpi9Yaxy0FU7SrsjxkgqyMmaGvcuhBpCFYFENJEM=;
        b=dzi8Op5dsVxo1KrP2obOpcA402a/1ncdW73w70KnStaAHdoBCVaK8zUtjNw2yEvQbv
         qALC//VPvW2u3BN0hk3hVfWxecD4i7fTDr7O2ehZxV+6jR3AslubjOKv7RSruSx3S8jd
         rUmvtRbDZDOcu3uTjh6aDpwJEw2botF4UpgM3BOU7heMwYpEHlRaRSAgXsJ7G+z1XPR3
         1cWNMSgxmnGClIWeTaHudSCwSsuTjs8nKY3+8F/NHylR6fZKiFy8IT3uJEvU7+qIddtW
         2reMmrrYrzmus3ptksMbBrtp+zICZAr+PyVJoQSchKC67Vi/c5pXPksu96AlCtXEsnwe
         u2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599135; x=1688191135;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNixpi9Yaxy0FU7SrsjxkgqyMmaGvcuhBpCFYFENJEM=;
        b=iNkSqBLAAGjiK3TOZ2gxZSYeZ5z6g02c6twbFH/7asyiGqtO0nWy/nWC7dNzN7ajVM
         WXpSOIL1NxmtfaUO8OWSzTkdTiG3ArS8ni8RIEVxdyuBxeM/XqpRm2PqmSvGz8tut2LF
         LiQ06BY2THWt4jiuukBHMRZ0ET99IAPhqOXzu6lJO9mZ7vuboDqphnYHM5jGHcVVd+3c
         PgdRcpZdEsJpGMRPnlXY3iKsBFP99R1xIkPp/Jy+4djic5c8ZiyDy2PEOuhpM5Oa6aIY
         b/9xgQVI7TqjbaOu+hdJZDEmALdk4n267m32+t+puxunViuOwncpL1ITAxTKgZ2HGQ43
         al8g==
X-Gm-Message-State: AC+VfDxlKa6+LZw5sbZgHCkKMf8DS3ky4jWwsmgubzj8NngwAyRJ6Sqo
        FpNbLwkTV151CHIBzunroVehfgL3rn3S934LaShlthBPbr7fr52GK3dVXfM/YGpx3q/q2QuKvla
        iZxnrbbBLwbaLvYSyOATV3PMD3doGMc4uiRyTOUnS1kPD18ywy5dTYpQbbxWpRWy02v1l69A=
X-Google-Smtp-Source: ACHHUZ4PCDgSs3a2bQd5VYwishtGDOr/yovphbZuRcAEACE6FzSmCHDuBWCXGXc9CS5uaSQ0n1XeObhx4i0q
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:706:b0:565:e712:422c with SMTP id
 bs6-20020a05690c070600b00565e712422cmr4841951ywb.1.1685599135602; Wed, 31 May
 2023 22:58:55 -0700 (PDT)
Date:   Thu,  1 Jun 2023 05:58:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601055846.2349566-1-jstultz@google.com>
Subject: [PATCH v4 00/13] Generalized Priority Inheritance via Proxy Execution v3
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
        Youssef Esmat <youssefesmat@google.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After having to catch up on other work after OSPM[1], I've finally
gotten back to focusing on Proxy Execution and wanted to send out this
next iteration of the patch series for review, testing, and feedback.
(Many thanks to folks who provided feedback on the last revision!)

As mentioned previously, this Proxy Execution series has a long history:
First described in a paper[2] by Watkins, Straub, Niehaus, then from
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
down when used between CFS or DEADLINE tasks, as there are lots
of parameters involved outside of just the task=E2=80=99s nice value when
selecting the next task to run (via pick_next_task()).  So ideally we
want to imbue the mutex holder with all the scheduler attributes of=20
the blocked waiting task.

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

But the functionality provided by Proxy Execution is useful, as in
Android we have a number of cases where we are seeing priority inversion
(not unbounded, but longer than we=E2=80=99d like) between =E2=80=9Cforegro=
und=E2=80=9D and
=E2=80=9Cbackground=E2=80=9D SCHED_NORMAL applications, so having a general=
ized solution
would be very useful.

New in v4:
=E2=80=94------
* Fixed deadlock that was caused by wait/wound mutexes having circular
  blocked_on references by clearing the blocked_on pointer on the task
  we are waking to wound/die.=20

* Tried to resolve an issue Dietmar raised with RT balancing where the
  proxy migration and push_rt_task() were fighting ping-ponging tasks
  back and forth, caused by push_rt_task() migrating tasks even if they
  were in the chain that ends with the current running task. Though this
  likely needs more work, as this change resulted in different migration
  quirks (see below).

* Fixed a number of null-pointer traversals that the changes were
  occasionally tripping on

* Reworked patch that exposes __mutex_owner() to the scheduler to ensure
  it doesn=E2=80=99t expose it any more than necessary, as suggested by Pet=
er.=20

* To address some of Peter=E2=80=99s complaints, backed out the rq_curr()
  wrapper, and reworked rq_selected() to be a macro to avoid needing
  multiple accessors for READ_ONCE/rcu_dereference() type accesses.=20

* Removed verbose legacy comments from previous developers of the series
  as Dietmar was finding them distracting when reviewing the diffs
  (Though, to ensure I heed the warnings from previous experienced
  travelers, I=E2=80=99ve preserved the comments/questions in a separate pa=
tch
  in my own development tree).

* Dropped patch that added *_task_blocked_on() wrappers to check locking
  correctness. Mostly as Peter didn=E2=80=99t seem happy with the wrappers =
in
  other patches, but I still think it's useful for testing (and the
  blocked_on locking still needs some work), so I=E2=80=99m carrying it in =
my
  personal development tree.

Issues still to address:
=E2=80=94----------
* Occasional getting null scheduler entities from pick_next_entity() in
  CFS. I=E2=80=99m a little stumped as to where this is going awry just yet=
, and
  delayed sending this out, but figured it was worth getting it out for
  review on the other issues while I chase this down.

* Better deadlock handling in proxy(): With the ww_mutex issues
  resolved, we shouldn=E2=80=99t see circular blocked_on references, but a
  number of the bugs I=E2=80=99ve been chasing recently come from getting s=
tuck
  with proxy() returning null forcing a reselection over and over. These
  are still bugs to address, but my current thinking is that if we get
  stuck like this, we can start to remove the selected mutex blocked
  tasks from the rq, and let them be woken from the mutex waiters list
  as is done currently? Thoughts here would be appreciated.

* More work on migration correctness (RT/DL load balancing,etc). I=E2=80=99=
m
  still seeing occasional trouble as cpu counts go up which seems to be
  due to a bunch of tasks being proxy migrated to a cpu, then having to
  migrate them all away at once (seeing lots of pick again iterations).
  This may actually be correct, due to chain migration, but it ends up
  looking similar to a deadlock.

* =E2=80=9Crq_selected()=E2=80=9D naming. Peter doesn=E2=80=99t like it, bu=
t I=E2=80=99ve not thought of
  a better name. Open to suggestions.

* As discussed at OSPM, I want to split pick_next_task() up into two
  phases selecting and setting the next tasks, as currently
  pick_next_task() assumes the returned task will be run which results
  in various side-effects in sched class logic when it=E2=80=99s run. This
  causes trouble should proxy() require us to re-select a task due to
  migration or other edge cases.

* CFS load balancing. Blocked tasks may carry forward load (PELT) to the
  lock owner's CPU, so CPU may look like it is overloaded.

* I still want to push down the split scheduler and execution context
  awareness further through the scheduling code, as lots of logic still
  assumes there=E2=80=99s only a single =E2=80=9Crq->curr=E2=80=9D task.

* Optimization to avoid migrating blocked tasks (allowing for optimistic
  spinning) if the runnable lock-owner at the end of the blocked_on chain
  is already running. =20


Performance:
=E2=80=94----------
This patch series switches mutexes to use handoff mode rather than
optimistic spinning. This is a potential concern where locks are under
high contention. However, so far in our initial performance analysis (on
both x86 and mobile devices) we=E2=80=99ve not seen major regressions. That
said, Chenyu did report a regression[3], which we=E2=80=99ll need to look
further into. As mentioned above, there may be some optimizations that
can help here, but my focus is on getting the code working well before I
spend time optimizing.

Review and feedback would be greatly appreciated!

If folks find it easier to test/tinker with, this patch series can also
be found here (along with some debug patches):
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v4-6.4-rc=
3

Thanks so much!
-john

[1] https://youtu.be/QEWqRhVS3lI (video of my OSPM talk)
[2] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf
[3] https://lore.kernel.org/lkml/Y7vVqE0M%2FAoDoVbj@chenyu5-mobl1/

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
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com

Connor O'Brien (1):
  sched: Attempt to fix rt/dl load balancing via chain level balance

John Stultz (3):
  sched: Unnest ttwu_runnable in prep for proxy-execution
  sched: Fix runtime accounting w/ proxy-execution
  sched: Fixups to find_exec_ctx

Juri Lelli (2):
  locking/mutex: make mutex::wait_lock irq safe
  locking/mutex: Expose __mutex_owner()

Peter Zijlstra (6):
  sched: Unify runtime accounting across classes
  locking/ww_mutex: Remove wakeups from under mutex::wait_lock
  locking/mutex: Rework task_struct::blocked_on
  locking/mutex: Add task_struct::blocked_lock to serialize changes to
    the blocked_on state
  sched: Split scheduler execution context
  sched: Add proxy execution

Valentin Schneider (1):
  sched/rt: Fix proxy/current (push,pull)ability

 include/linux/sched.h        |  10 +-
 include/linux/ww_mutex.h     |   3 +
 init/Kconfig                 |   7 +
 init/init_task.c             |   1 +
 kernel/Kconfig.locks         |   2 +-
 kernel/fork.c                |   6 +-
 kernel/locking/mutex-debug.c |   9 +-
 kernel/locking/mutex.c       | 113 ++++--
 kernel/locking/mutex.h       |  25 ++
 kernel/locking/ww_mutex.h    |  54 ++-
 kernel/sched/core.c          | 719 +++++++++++++++++++++++++++++++++--
 kernel/sched/cpudeadline.c   |  12 +-
 kernel/sched/cpudeadline.h   |   3 +-
 kernel/sched/cpupri.c        |  28 +-
 kernel/sched/cpupri.h        |   6 +-
 kernel/sched/deadline.c      | 187 +++++----
 kernel/sched/fair.c          |  99 +++--
 kernel/sched/rt.c            | 242 +++++++-----
 kernel/sched/sched.h         |  75 +++-
 kernel/sched/stop_task.c     |  13 +-
 20 files changed, 1284 insertions(+), 330 deletions(-)

--=20
2.41.0.rc0.172.g3f132b7071-goog

