Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907EE5F211C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 05:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJBDKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBDKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 23:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402502C66F;
        Sat,  1 Oct 2022 20:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF64A60C3A;
        Sun,  2 Oct 2022 03:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363B7C433D7;
        Sun,  2 Oct 2022 03:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664680247;
        bh=uSKctew27OMSEqlEKC59gBsdzDXIGF0js0N/xW6Lgqw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=YdIyqYfjUOi8V67hV9+XlxZBHV+jlS86xmrkEWev3VsCDOP0UJ/UDrXGTqw7+7ZPo
         zfI0DY1hRJynnqVJ7KPl7u0l8YOnAhn39MJlKoXIoqC8a745yPk1JwNTsoUpUPDOa1
         IWY5Era6dPvpO9CexoGgwyWHBWRd/ttgVZzeCTItogZofDzz9kl8K5PGqeaZeZbbzO
         RAX8/2vwP3jbGuz+PBpsvhMoaq6chCK2KSwjClsDfYuiQaL1VJJBWp2XAbtX6m64ej
         qW7gVJL6amF/L6f7/D2RDW4KOlEwSA4zPVN5ul+VqipkGDvCTJHKbdYm7hWtVjre+y
         9m5+Dd5zu+w9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C100B5C05B1; Sat,  1 Oct 2022 20:10:46 -0700 (PDT)
Date:   Sat, 1 Oct 2022 20:10:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com
Subject: [GIT PULL] RCU changes for v6.1
Message-ID: <20221002031046.GA3511311@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu.2022.09.30a
  # HEAD: 5c0ec4900497f7c9cc12f393c329a52e67bc6b8b Merge branches 'doc.2022.08.31b', 'fixes.2022.08.31b', 'kvfree.2022.08.31b', 'nocb.2022.09.01a', 'poll.2022.08.31b', 'poll-srcu.2022.08.31b' and 'tasks.2022.08.31b' into HEAD

----------------------------------------------------------------

RCU pull request for v6.1

This pull request contains the following branches:

doc.2022.08.31b: Documentation updates.  This is the first in a series
	from an ongoing review of the RCU documentation.  "Why are people
	thinking -that- about RCU?  Oh.  Because that is an entirely
	reasonable interpretation of its documentation."

fixes.2022.08.31b: Miscellaneous fixes.

kvfree.2022.08.31b: Improved memory allocation and heuristics.

nocb.2022.09.01a: Improve rcu_nocbs diagnostic output.

poll.2022.08.31b: Add full-sized polled RCU grace period state values.
	These are the same size as an rcu_head structure, which is double
	that of the traditional unsigned long state values that may still
	be obtained from et_state_synchronize_rcu().  The added size
	avoids missing overlapping grace periods.  This benefit is that
	call_rcu() can be replaced by polling, which can be attractive
	in situations where RCU-protected data is aged out of memory.

	Early in the series, the size of this state value is three
	unsigned longs.  Later in the series, the synchronize_rcu() and
	synchronize_rcu_expedited() fastpaths are reworked to permit
	the full state to be represented by only two unsigned longs.
	This reworking slows these two functions down in SMP kernels
	running either on single-CPU systems or on systems with all but
	one CPU offlined, but this should not be a significant problem.
	And if it somehow becomes a problem in some yet-as-unforeseen
	situations, three-value state values can be provided for only
	those situations.

	Finally, a pair of functions named same_state_synchronize_rcu()
	and same_state_synchronize_rcu_full() allow grace-period state
	values to be compared for equality.  This permits users to
	maintain lists of data structures having the same state value,
	removing the need for per-data-structure grace-period state
	values, thus decreasing memory footprint.

poll-srcu.2022.08.31b: Polled SRCU grace-period updates, including
	adding tests to rcutorture and reducing the incidence of Tiny
	SRCU grace-period-state counter wrap.

tasks.2022.08.31b: Improve Tasks RCU diagnostics and quiescent-state
	detection.

----------------------------------------------------------------
Joel Fernandes (Google) (1):
      rcu/kfree: Fix kfree_rcu_shrink_count() return value

Michal Hocko (1):
      rcu: Back off upon fill_page_cache_func() allocation failure

Paul E. McKenney (41):
      doc: Emphasize the need for explicit RCU read-side markers
      doc: Call out queue_rcu_work() for blocking RCU callbacks
      doc: Use rcu_barrier() to rate-limit RCU callbacks
      doc: Fix list: rcu_access_pointer() is not lockdep-checked
      doc: Update rcu_access_pointer() advice in rcu_dereference.rst
      doc: SLAB_TYPESAFE_BY_RCU uses cannot rely on spinlocks
      rcu: Document reason for rcu_all_qs() call to preempt_disable()
      rcu: Update rcu_access_pointer() header for rcu_dereference_protected()
      rcu: Exclude outgoing CPU when it is the last to leave
      rcu/nocb: Add CPU number to CPU-{,de}offload failure messages
      rcu: Add full-sized polling for get_completed*() and poll_state*()
      rcu: Add full-sized polling for get_state()
      rcutorture: Abstract synchronous and polled API testing
      rcutorture: Allow per-RCU-flavor polled double-GP check
      rcutorture: Verify RCU reader prevents full polling from completing
      rcutorture: Remove redundant RTWS_DEF_FREE check
      rcutorture: Verify long-running reader prevents full polling from completing
      rcu: Add full-sized polling for start_poll()
      rcu: Add full-sized polling for start_poll_expedited()
      rcu: Remove blank line from poll_state_synchronize_rcu() docbook header
      rcu: Add full-sized polling for cond_sync_full()
      rcu: Add full-sized polling for cond_sync_exp_full()
      rcu: Disable run-time single-CPU grace-period optimization
      rcu: Set rcu_data structures' initial ->gpwrap value to true
      rcu-tasks: Remove grace-period fast-path rcu-tasks helper
      rcu: Make synchronize_rcu() fast path update ->gp_seq counters
      rcu: Remove expedited grace-period fast-path forward-progress helper
      rcu: Make synchronize_rcu_expedited() fast path update .expedited_sequence
      rcu: Remove ->rgos_polled field from rcu_gp_oldstate structure
      rcutorture: Adjust rcu_poll_need_2gp() for rcu_gp_oldstate field removal
      rcu: Make synchronize_rcu() fastpath update only boot-CPU counters
      rcutorture: Use 1-suffixed variable in rcu_torture_write_types() check
      rcutorture: Expand rcu_torture_write_types() first "if" statement
      rcu: Add functions to compare grace-period state values
      rcutorture: Limit read-side polling-API testing
      rcutorture: Make "srcud" option also test polled grace-period API
      srcu: Add GP and maximum requested GP to Tiny SRCU rcutorture output
      srcu: Make Tiny SRCU poll_state_synchronize_srcu() more precise
      srcu: Make Tiny SRCU use full-sized grace-period counters
      rcu-tasks: Ensure RCU Tasks Trace loops have quiescent states
      Merge branches 'doc.2022.08.31b', 'fixes.2022.08.31b', 'kvfree.2022.08.31b', 'nocb.2022.09.01a', 'poll.2022.08.31b', 'poll-srcu.2022.08.31b' and 'tasks.2022.08.31b' into HEAD

Shao-Tse Hung (1):
      doc/rcu: Update LWN article URLs and add 2019 article

Uladzislau Rezki (Sony) (1):
      rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval

Zhen Lei (2):
      sched/debug: Try trigger_single_cpu_backtrace(cpu) in dump_cpu_task()
      sched/debug: Show the registers of 'current' in dump_cpu_task()

Zqiang (9):
      rcu: Fix rcu_read_unlock_strict() strict QS reporting
      rcu: Update rcu_preempt_deferred_qs() comments for !PREEMPT kernels
      rcu: Add QS check in rcu_exp_handler() for non-preemptible kernels
      rcu: Make tiny RCU support leak callbacks for debug-object errors
      rcu: Avoid triggering strict-GP irq-work when RCU is idle
      rcu/nocb: Choose the right rcuog/rcuop kthreads to output
      rcu-tasks: Convert RCU_LOCKDEP_WARN() to WARN_ONCE()
      rcu-tasks: Make RCU Tasks Trace check for userspace execution
      rcutorture: Use the barrier operation specified by cur_ops

 Documentation/RCU/checklist.rst       |  15 +-
 Documentation/RCU/rcu_dereference.rst |  14 +-
 Documentation/RCU/whatisRCU.rst       |  47 +++--
 include/linux/rcupdate.h              |  42 ++++-
 include/linux/rcutiny.h               |  50 ++++++
 include/linux/rcutree.h               |  40 +++++
 include/linux/srcutiny.h              |  10 +-
 kernel/rcu/rcutorture.c               | 290 +++++++++++++++++++++++++-----
 kernel/rcu/srcutiny.c                 |  14 +-
 kernel/rcu/tasks.h                    |   5 +-
 kernel/rcu/tiny.c                     |  27 ++-
 kernel/rcu/tree.c                     | 330 ++++++++++++++++++++++++++--------
 kernel/rcu/tree_exp.h                 |  57 +++++-
 kernel/rcu/tree_nocb.h                |  10 +-
 kernel/rcu/tree_plugin.h              |  26 +--
 kernel/rcu/tree_stall.h               |   5 +-
 kernel/sched/core.c                   |  14 ++
 kernel/smp.c                          |   3 +-
 18 files changed, 813 insertions(+), 186 deletions(-)
