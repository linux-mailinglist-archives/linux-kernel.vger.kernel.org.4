Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73186619AAE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiKDO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiKDO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:57:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4512ED53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:57:54 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667573872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=737pHEJJTSnxFKBYGuyt7Low3qBKlccPZgqWAab6Nsw=;
        b=BKauH494hFcnZM0i9+L7NP75p8LJLqtirQEx0VQ2rcVPKDdEsBG3B8i6m1m7FAe9Nns7Sv
        JqaQHM2KADQqpM+U0mMmCLdYS0PLM3TgQQzm/rdZXibxrGg3IvDN5+I1UhwU82cTNEniqH
        bvyZH0a+ZtIi6gYecloVfQ3BBFYSj46TlvnpxBAie+93g2MPy6blOkvp2Q1eXRF1U/bQUM
        KmvQmecjj9vK0zvOVEBil4iz0bV74/ZYOE5vX2UsO5phQVjNRbGg63nbTr64NSR54LpZgi
        HFtG/Z7eWfP4pwp/ix/R1y7tpfTusuwp/aQZmPbPyXsLFpuSNn1Ub/hQktQE7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667573872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=737pHEJJTSnxFKBYGuyt7Low3qBKlccPZgqWAab6Nsw=;
        b=tFbF+Od7EhPsotceQeFTEv9xGmdvPtRfg6QHKprLjpyTs8CISCQk0By9EAzcDvNUnzjQlp
        BI7dfLzCcXklX0Bw==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v4 00/16] timer: Move from a push remote at enqueue to a pull at expiry model
Date:   Fri,  4 Nov 2022 15:57:21 +0100
Message-Id: <20221104145737.71236-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Placing timers at enqueue time on a target CPU based on dubious heuristics
does not make any sense:

 1) Most timer wheel timers are canceled or rearmed before they expire.

 2) The heuristics to predict which CPU will be busy when the timer expires
    are wrong by definition.

So placing the timers at enqueue wastes precious cycles.

The proper solution to this problem is to always queue the timers on the
local CPU and allow the non pinned timers to be pulled onto a busy CPU at
expiry time.

Therefore split the timer storage into local pinned and global timers:
Local pinned timers are always expired on the CPU on which they have been
queued. Global timers can be expired on any CPU.

As long as a CPU is busy it expires both local and global timers. When a
CPU goes idle it arms for the first expiring local timer. If the first
expiring pinned (local) timer is before the first expiring movable timer,
then no action is required because the CPU will wake up before the first
movable timer expires. If the first expiring movable timer is before the
first expiring pinned (local) timer, then this timer is queued into a idle
timerqueue and eventually expired by some other active CPU.

To avoid global locking the timerqueues are implemented as a hierarchy. The
lowest level of the hierarchy holds the CPUs. The CPUs are associated to
groups of 8, which are seperated per node. If more than one CPU group
exist, then a second level in the hierarchy collects the groups. Depending
on the size of the system more than 2 levels are required. Each group has a
"migrator" which checks the timerqueue during the tick for remote expirable
timers.

If the last CPU in a group goes idle it reports the first expiring event in
the group up to the next group(s) in the hierarchy. If the last CPU goes
idle it arms its timer for the first system wide expiring timer to ensure
that no timer event is missed.


Testing
~~~~~~~

The impact of wasting cycles during enqueue by using the heuristic in
contrast to always queueing the timer on the local CPU was measured with a
micro benchmark. Therefore a timer is enqueued and dequeued in a loop with
1000 repetitions on a isolated CPU. The time the loop takes is measured. A
quater of the remaining CPUs was kept busy. This measurement was repeated
several times. With the patch queue the average duration was reduced by
approximately 25%.

	145ns	plain v6
	109ns	v6 with patch queue


Furthermore the impact of residence in deep idle states of an idle system
was investigated. The patch queue doesn't downgrade this behavior.


During testing on a mostly idle machine a ping pong game could be observed:
a process_timeout timer is expired remotely on a non idle CPU. Then the CPU
where the schedule_timeout() was executed to enqueue the timer comes out of
idle and restarts the timer using schedule_timeout() and goes back to idle
again. This is due to the fair scheduler which tries to keep the task on
the CPU which it previously executed on.


Next Steps
~~~~~~~~~~

Simple deferrable timers are no longer required as they can be converted to
global timers. If a CPU goes idle, a formerly deferrable timer will not
prevent the CPU to sleep as long as possible. Only the last migrator CPU
has to take care of them. Deferrable timers with timer pinned flags needs
to be expired on the specified CPU but must not prevent CPU from going
idle. They require their own timer base which is never taken into account
when calculating the next expiry time. This conversation and required
cleanup will be done in a follow up series.



v3..v4:
  - address review feedback of Frederic Weisbecker
  - address kernel test robot fallout
  - Move patch 16 "add_timer_on(): Make sure callers have TIMER_PINNED
    flag" at the begin of the queue to prevent timers to end up in global
    timer base when they were queued using add_timer_on()
  - Fix some comments and typos

v2..v3: https://lore.kernel.org/r/20170418111102.490432548@linutronix.de/
  - Minimize usage of locks by storing data using atomic_cmpxchg() for
    migrator information and information about active cpus.


Thanks,

	Anna-Maria





Anna-Maria Behnsen (13):
  tick-sched: Warn when next tick seems to be in the past
  timer: Move store of next event into __next_timer_interrupt()
  timer: Split next timer interrupt logic
  add_timer_on(): Make sure callers have TIMER_PINNED flag
  timer: Keep the pinned timers separate from the others
  timer: Retrieve next expiry of pinned/non-pinned timers seperately
  timer: Rename get_next_timer_interrupt()
  timer: Split out "get next timer interrupt" functionality
  timer: Add get next timer interrupt functionality for remote CPUs
  timer: Check if timers base is handled already
  timer: Implement the hierarchical pull model
  timer_migration: Add tracepoints
  timer: Always queue timers on the local CPU

Richard Cochran (linutronix GmbH) (2):
  timer: Restructure internal locking
  tick/sched: Split out jiffies update helper function

Thomas Gleixner (1):
  timer: Rework idle logic

 arch/x86/kernel/tsc_sync.c             |    3 +-
 drivers/char/random.c                  |    2 +-
 include/linux/cpuhotplug.h             |    1 +
 include/linux/timer.h                  |    5 +-
 include/trace/events/timer_migration.h |  277 ++++++
 kernel/time/Makefile                   |    3 +
 kernel/time/clocksource.c              |    2 +-
 kernel/time/tick-internal.h            |   12 +-
 kernel/time/tick-sched.c               |   50 +-
 kernel/time/timer.c                    |  372 +++++--
 kernel/time/timer_migration.c          | 1263 ++++++++++++++++++++++++
 kernel/time/timer_migration.h          |  123 +++
 kernel/workqueue.c                     |    7 +-
 13 files changed, 2011 insertions(+), 109 deletions(-)
 create mode 100644 include/trace/events/timer_migration.h
 create mode 100644 kernel/time/timer_migration.c
 create mode 100644 kernel/time/timer_migration.h

-- 
2.30.2

