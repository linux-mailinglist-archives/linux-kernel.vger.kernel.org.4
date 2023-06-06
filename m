Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15816724651
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbjFFOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbjFFOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08D610FA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:20 -0700 (PDT)
Message-ID: <20230606132949.068951363@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=SiZMAgy8WayQm8P/nt8AoFUB1EPuYFH+U4PN3t5WL4Q=;
        b=nVXoGI5j1b5CMSGCAML6jm/VZuX1vuQsfpAHTRDeSd6jDy08eCi94sBBZouR0SdJGXy2qm
        fvDwkCI2WQTpLttKsk3uLFjpdaH/qiw36hQSo+2NPOZ9BIiiONzrmpupxI/Gxw9mEVJcbs
        sUvf7B9STEpGtHxfOztdt1XvBdBzGfvW5V23YDHifwnVJFkVGTPdK0YhZcmVsawbNrn8GT
        O4JZD+TYX0hAuo0Kic7vic26ZdneA+Q2gXSGZnShYIG1t7bvSwvy/68yGE9Hr5utu2ocU1
        ymeYVwZzTFwHUBjelEKk0BiMKtw20rVvyLsO38G3qStU7mNjHAD1bGb/15+DIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=SiZMAgy8WayQm8P/nt8AoFUB1EPuYFH+U4PN3t5WL4Q=;
        b=JWR7Nma8jdzZ2vmDu4qdzXUP4UcYIGm/OAr8FOdgf4EhCi4HQiFe45zQEtw+XqusmQ8vCU
        JqwhOzuetxRB7NDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 00/45] posix-timers: Cure inconsistencies and the SIG_IGN mess
Date:   Tue,  6 Jun 2023 16:37:18 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My recent cleanup work made me reread a 15 years old comment about the
SIG_IGN problem:

 "FIXME: What we really want, is to stop this timer completely and restart
  it in case the SIG_IGN is removed. This is a non trivial change which
  involves sighand locking (sigh !), which we don't want to do late in the
  release cycle.  ...  A more complex fix which solves also another related
  inconsistency is already in the pipeline."

The embarrasing part was that I put that comment in back then. So I went
back and rumaged through old notes as I completely had forgotten why our
attempts to fix this back then failed.

It turned out that the comment is about right: sighand locking and life
time issues. So I sat down with the old notes and started to wrap my head
around this again.

The problem to solve:

Posix interval timers are not rearmed automatically by the kernel for
various reasons:

   1) To prevent DoS by extremly short intervals.
   2) To avoid timer overhead when a signal is pending and has not
      yet been delivered.

This is achieved by queueing the signal at timer expiry and rearming the
timer at signal delivery to user space. This puts the rearming basically
under scheduler control and the work happens in context of the task which
asked for the signal.

There is a problem with that vs. SIG_IGN. If a signal has SIG_IGN installed
as handler the related signals are discarded. So in case of posix interval
timers this means that such a timer is never rearmed even when SIG_IGN is
replaced later with a real handler (including SIG_DFL).

To work around that the kernel self rearms those timers and throttles them
when the interval is smaller than a tick to prevent a DoS.

That just keeps timers ticking, which obviously has effects on power and
just creates work for nothing.

So ideally these timers should be stopped and rearmed when SIG_IGN is
replaced, which aligns with the regular handling of posix timers.

Sounds trivial, but isn't:

  1) Lock ordering.

     The timer lock cannot be taken with sighand lock held which is
     problematic vs. the atomicity of sigaction().

  2) Life time rules

     The timer and the sigqueue are separate entities which requires a
     lookup of the timer ID in the signal rearm code. This can be handled,
     but the separate life time rules are not necessarily robust.

  3) Finding the relevant timers

     Obviosly it is possible to walk the posix timer list under sighand
     lock and handle it from there. That can be expensive especially in the
     case that there are no affected timers as the walk would just end up
     doing nothing.

The following series is a new and this time actually working attempt to
solve this. It addresses it by:

  1) Embedding the preallocated sigqueue into struct k_itimer, which makes
     the life time rules way simpler and just needs a trivial reference
     count.

  2) Having a separate list in task::signal on which ignored timers are
     queued.

     This avoids walking a potentially large timer list for nothing on a
     SIG_IGN to handler transition.

  3) Requeueing the timers signal in the relevant signal queue so the timer
     is rearmed when the signal is actually delivered

     That turned out to be the least complicated way to address the sighand
     lock vs. timer lock ordering issue.

With that timers which have their signal ignored are not longer self
rearmed and the relevant workarounds including throttling for DoS
prevention are removed.

Aside of the SIG_IGN issues it also addresses a few inconsistencies in
posix CPU timers and the general inconsistency of signal handling
vs. disarmed, reprogrammed and deleted timers.

To actually validate the fixes the posix timer self test has been expanded
with tests which cover not only the simple SIG IGN case but also more
complex scenarios which have never been handled correctly by the current
self rearming work around.

The series is based on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/posix

Thanks,

	tglx
---
 arch/x86/kernel/signal_32.c                   |    2 
 arch/x86/kernel/signal_64.c                   |    2 
 drivers/power/supply/charger-manager.c        |    3 
 fs/proc/base.c                                |   10 
 fs/signalfd.c                                 |    4 
 fs/timerfd.c                                  |    4 
 include/linux/alarmtimer.h                    |   10 
 include/linux/posix-timers.h                  |   69 ++
 include/linux/sched/signal.h                  |   11 
 include/uapi/asm-generic/siginfo.h            |    2 
 init/init_task.c                              |    5 
 kernel/fork.c                                 |    3 
 kernel/signal.c                               |  486 ++++++++++++--------
 kernel/time/alarmtimer.c                      |   82 ---
 kernel/time/itimer.c                          |   22 
 kernel/time/posix-cpu-timers.c                |  227 +++------
 kernel/time/posix-timers.c                    |  285 ++++++------
 kernel/time/posix-timers.h                    |    9 
 net/netfilter/xt_IDLETIMER.c                  |    4
 19 files changed, 642 insertions(+), 598 deletions(-)
 
 tools/testing/selftests/timers/posix_timers.c |  606 +++++++++++++++++++++-----
 1 file changed, 491 insertions(+), 115 deletions(-)
