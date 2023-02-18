Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E2169BB84
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 20:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBRTGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 14:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBRTGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 14:06:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1CB14E89;
        Sat, 18 Feb 2023 11:06:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22E35B808BF;
        Sat, 18 Feb 2023 19:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80FDC433EF;
        Sat, 18 Feb 2023 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676747203;
        bh=tDnOSgmeKEukAjBU54pIc4km4vcB8vmwy0IJMLjDDzc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=M3fJkgKTYKnkCFYdl7gZ7SMIN0rZnewU0fC64WnoPcjYE+B5PY3VQEGfe2QILWBxE
         nnMyixFn2KovU3XOHVNmZ284ABqEOHly0tRCZ6I+5Btoeo2f4EFFWXGVP5lcgQKPbU
         3cxZad04GCMYZ+siM184RvMKPqVKg5BowoA1+smpyJLa041/wMKmeK0PlUbofXPZpL
         vIXakcZ4+HngI2jMnXj40zMTet7r5Cfwv7hG+kGqQJEJMxpWrbSmYdcnL9+DrTFGhI
         Wy5ZhBw6fO8LhjtZnjNwZtrSBvl7/28OfTzlDJMysPs+fXSWMAsVKMpE+iZnZsKK02
         covcGAnFaflmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 757045C0ACF; Sat, 18 Feb 2023 11:06:41 -0800 (PST)
Date:   Sat, 18 Feb 2023 11:06:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
        joel@joelfernandes.org, boqun.feng@gmail.com, frederic@kernel.org,
        quic_neeraju@quicinc.com, urezki@gmail.com
Subject: [GIT PULL] RCU changes for v6.3
Message-ID: <20230218190641.GA1215210@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.02.10a
  # HEAD: bba8d3d17dc2678f9647962900aa421a18c25320: Merge branch 'stall.2023.01.09a' into HEAD (2023-02-02 16:40:07 -0800)

This pull request contains this commit:
	dc7c31b07ade ("drivers/base: Remove CONFIG_SRCU")
Which conflicted in -next with this commit:
        3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
Stephen Rothwell's proposed resolution work for me:
        https://lore.kernel.org/lkml/20230210124818.2caaa77f@canb.auug.org.au
The -rcu tree contains a sample resolution merge commit at branch
conflict-resolution.2023.02.10a.

----------------------------------------------------------------
RCU pull request for v6.3

This pull request contains the following branches:

doc.2023.01.05a: Documentation updates.

fixes.2023.01.23a: Miscellaneous fixes, perhaps most notably:

o	Throttling callback invocation based on the number of callbacks
	that are now ready to invoke instead of on the total number
	of callbacks.

o	Several patches that suppress false-positive boot-time
	diagnostics, for example, due to lockdep not yet being
	initialized.

o	Make expedited RCU CPU stall warnings dump stacks of any tasks
	that are blocking the stalled grace period.  (Normal RCU CPU
	stall warnings have doen this for mnay years.)

o	Lazy-callback fixes to avoid delays during boot, suspend, and
	resume.  (Note that lazy callbacks must be explicitly enabled,
	so this should not (yet) affect production use cases.)

kvfree.2023.01.03a: Cause kfree_rcu() and friends to take advantage of
	polled grace periods, thus reducing memory footprint by almost
	two orders of magnitude, admittedly on a microbenchmark.
	This series also begins the transition from kfree_rcu(p) to
	kfree_rcu_mightsleep(p).  This transition was motivated by bugs
	where kfree_rcu(p), which can block, was typed instead of the
	intended kfree_rcu(p, rh).

srcu.2023.01.03a: SRCU updates, perhaps most notably fixing a bug that
	causes SRCU to fail when booted on a system with a non-zero boot
	CPU.  This surprising situation actually happens for kdump kernels
	on the powerpc architecture.  It also adds an srcu_down_read()
	and srcu_up_read(), which act like srcu_read_lock() and
	srcu_read_unlock(), but allow an SRCU read-side critical section
	to be handed off from one task to another.

srcu-always.2023.02.02a: Cleans up the now-useless SRCU Kconfig option.
	There are a few more commits that are not yet acked or pulled
	into maintainer trees, and these will be in a pull request for
	a later merge window.

tasks.2023.01.03a: RCU-tasks updates, perhaps most notably these fixes:

o	A strange interaction between PID-namespace unshare and the
	RCU-tasks grace period that results in a low-probability but
	very real hang.

o	A race between an RCU tasks rude grace period on a single-CPU
	system and CPU-hotplug addition of the second CPU that can result
	in a too-short grace period.

o	A race between shrinking RCU tasks down to a single callback list
	and queuing a new callback to some other CPU, but where that
	queuing is delayed for more than an RCU grace period.  This can
	result in that callback being stranded on the non-boot CPU.

torture.2023.01.05a: Torture-test updates and fixes.

torturescript.2023.01.03a: Torture-test scripting updates and fixes.

stall.2023.01.09a: Provide additional RCU CPU stall-warning information
	in kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y, and
	restore the full five-minute timeout limit for expedited RCU
	CPU stall warnings.

----------------------------------------------------------------
Akira Yokosawa (2):
      docs/RCU/rcubarrier: Adjust 'Answer' parts of QQs as definition-lists
      docs/RCU/rcubarrier: Right-adjust line numbers in code snippets

Frederic Weisbecker (3):
      rcu-tasks: Improve comments explaining tasks_rcu_exit_srcu purpose
      rcu-tasks: Remove preemption disablement around srcu_read_[un]lock() calls
      rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()

Joel Fernandes (Google) (5):
      locktorture: Allow non-rtmutex lock types to be boosted
      locktorture: Make the rt_boost factor a tunable
      torture: Fix hang during kthread shutdown phase
      rcu: Track laziness during boot and suspend
      rcu: Disable laziness if lazy-tracking says so

Paul E. McKenney (44):
      doc: Further updates to RCU's lockdep.rst
      doc: Update NMI-RCU.rst
      doc: Update rcubarrier.rst
      doc: Update rcu_dereference.rst
      rcu: Consolidate initialization and CPU-hotplug code
      rcu: Throttle callback invocation based on number of ready callbacks
      rcu: Upgrade header comment for poll_state_synchronize_rcu()
      rcu: Make RCU_LOCKDEP_WARN() avoid early lockdep checks
      rcu: Suppress smp_processor_id() complaint in synchronize_rcu_expedited_wait()
      rcu: Test synchronous RCU grace periods at the end of rcu_init()
      rcu: Allow expedited RCU CPU stall warnings to dump task stacks
      rcu: Add srcu_down_read() and srcu_up_read()
      rcu: Add test code for semaphore-like SRCU readers
      srcu: Yet more detail for srcu_readers_active_idx_check() comments
      srcu: Update comment after the index flip
      torture: Seed torture_random_state on CPU
      refscale: Provide for initialization failure
      torture: make kvm-find-errors.sh check for compressed vmlinux files
      torture: Permit double-quoted-string Kconfig options
      rcu: Permit string-valued Kconfig options in kvm.sh
      doc: Update and wordsmith rculist_nulls.rst
      doc: Update rcu.rst
      doc: Update stallwarn.rst
      doc: Update torture.rst
      doc: Update UP.rst
      doc: Update rcu.rst URL to RCU publications
      doc: Update whatisRCU.rst
      refscale: Add tests using SLAB_TYPESAFE_BY_RCU
      rcutorture: Drop sparse lock-acquisition annotations
      rcu: Allow up to five minutes expedited RCU CPU stall-warning timeouts
      drivers/base: Remove CONFIG_SRCU
      drivers/dax: Remove "select SRCU"
      drivers/hwtracing/stm: Remove "select SRCU"
      drivers/md: Remove "select SRCU"
      drivers/net: Remove "select SRCU"
      drivers/pci/controller: Remove "select SRCU"
      fs: Remove CONFIG_SRCU
      fs/btrfs: Remove "select SRCU"
      fs/notify: Remove "select SRCU"
      fs/quota: Remove "select SRCU"
      init: Remove "select SRCU"
      kernel/notifier: Remove CONFIG_SRCU
      Merge branches 'doc.2023.01.05a', 'fixes.2023.01.23a', 'kvfree.2023.01.03a', 'srcu.2023.01.03a', 'srcu-always.2023.02.02a', 'tasks.2023.01.03a', 'torture.2023.01.05a' and 'torturescript.2023.01.03a' into HEAD
      Merge branch 'stall.2023.01.09a' into HEAD

Pingfan Liu (4):
      srcu: Delegate work to the boot cpu if using SRCU_SIZE_SMALL
      srcu: Fix a misspelling in comment
      srcu: Fix the comparision in srcu_invl_snp_seq()
      srcu: Remove needless rcu_seq_done() check while holding read lock

Tiezhu Yang (1):
      selftests: rcutorture: Use "grep -E" instead of "egrep"

Uladzislau Rezki (Sony) (9):
      rcu: Refactor kvfree_call_rcu() and high-level helpers
      rcu/kvfree: Switch to a generic linked list API
      rcu/kvfree: Move bulk/list reclaim to separate functions
      rcu/kvfree: Move need_offload_krc() out of krcp->lock
      rcu/kvfree: Use a polled API to speedup a reclaim process
      rcu/kvfree: Use READ_ONCE() when access to krcp->head
      rcu/kvfree: Carefully reset number of objects in krcp
      rcu/kvfree: Split ready for reclaim objects from a batch
      rcu/kvfree: Add kvfree_rcu_mightsleep() and kfree_rcu_mightsleep()

Zhao Mengmeng (1):
      rcu: Use hlist_nulls_next_rcu() in hlist_nulls_add_tail_rcu()

Zhen Lei (7):
      genirq: Fix the return type of kstat_cpu_irqs_sum()
      doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
      doc: Fix htmldocs build warnings of stallwarn.rst
      sched: Add helper kstat_cpu_softirqs_sum()
      sched: Add helper nr_context_switches_cpu()
      rcu: Add RCU stall diagnosis information
      rcu: Align the output of RCU CPU stall warning messages

Zqiang (6):
      rcu: Make rcu_blocking_is_gp() stop early-boot might_sleep()
      srcu: Release early_srcu resources when no longer in use
      rcu-tasks: Use accurate runstart time for RCU Tasks boot-time testing
      rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
      rcu-tasks: Handle queue-shrink/callback-enqueue race condition
      rcu: Remove redundant call to rcu_boost_kthread_setaffinity()

 Documentation/RCU/NMI-RCU.rst                      |   4 +-
 Documentation/RCU/UP.rst                           |  13 +-
 Documentation/RCU/lockdep.rst                      |  13 +-
 Documentation/RCU/rcu.rst                          |   6 +-
 Documentation/RCU/rcu_dereference.rst              |  21 +-
 Documentation/RCU/rcubarrier.rst                   | 357 +++++------
 Documentation/RCU/rculist_nulls.rst                | 109 ++--
 Documentation/RCU/stallwarn.rst                    | 135 ++++-
 Documentation/RCU/torture.rst                      |  89 ++-
 Documentation/RCU/whatisRCU.rst                    | 193 +++---
 Documentation/admin-guide/kernel-parameters.txt    |  11 +
 drivers/base/core.c                                |  42 --
 drivers/dax/Kconfig                                |   1 -
 drivers/hwtracing/stm/Kconfig                      |   1 -
 drivers/md/Kconfig                                 |   1 -
 drivers/net/Kconfig                                |   1 -
 drivers/pci/controller/Kconfig                     |   2 +-
 fs/btrfs/Kconfig                                   |   1 -
 fs/locks.c                                         |  25 -
 fs/notify/Kconfig                                  |   1 -
 fs/quota/Kconfig                                   |   1 -
 include/linux/kernel_stat.h                        |  14 +-
 include/linux/rculist_nulls.h                      |   2 +-
 include/linux/rcupdate.h                           |  19 +-
 include/linux/rcutiny.h                            |  12 +-
 include/linux/rcutree.h                            |   2 +-
 include/linux/srcu.h                               |  45 ++
 include/linux/srcutree.h                           |   2 +-
 init/Kconfig                                       |   1 -
 kernel/locking/locktorture.c                       | 101 ++--
 kernel/notifier.c                                  |   3 -
 kernel/pid_namespace.c                             |  17 +
 kernel/rcu/Kconfig.debug                           |  15 +-
 kernel/rcu/rcu.h                                   |   8 +
 kernel/rcu/rcu_segcblist.c                         |   2 +-
 kernel/rcu/rcu_segcblist.h                         |   2 +
 kernel/rcu/rcutorture.c                            |  12 +-
 kernel/rcu/refscale.c                              | 250 +++++++-
 kernel/rcu/srcutree.c                              |  98 ++-
 kernel/rcu/tasks.h                                 |  85 ++-
 kernel/rcu/tiny.c                                  |   9 +-
 kernel/rcu/tree.c                                  | 657 ++++++++++++---------
 kernel/rcu/tree.h                                  |  19 +
 kernel/rcu/tree_exp.h                              |  43 ++
 kernel/rcu/tree_stall.h                            |  37 +-
 kernel/rcu/update.c                                |  49 +-
 kernel/sched/core.c                                |   5 +
 kernel/torture.c                                   |   4 +-
 .../selftests/rcutorture/bin/configcheck.sh        |   5 +-
 .../selftests/rcutorture/bin/console-badness.sh    |   2 +-
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |   4 +-
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   6 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   6 +-
 .../selftests/rcutorture/bin/parse-console.sh      |  10 +-
 54 files changed, 1734 insertions(+), 839 deletions(-)
