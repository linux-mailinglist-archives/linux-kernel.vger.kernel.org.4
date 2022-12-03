Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2053B6412F0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiLCBLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiLCBLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:11:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA7BD20A9;
        Fri,  2 Dec 2022 17:11:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFC1F6247A;
        Sat,  3 Dec 2022 01:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3053EC433D6;
        Sat,  3 Dec 2022 01:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670029908;
        bh=eZp9JU1cNITlKz5eTnc4xE9oQLxGs+SZmnkZbiNAp8k=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=FaAUezm9H8AWnJ+v5HmK6gWVlk838Y+KbrgY2o+DvOgjDJKlW/X+IXxh7F3Dhew1r
         lis1gKzzj5SJ4pz/D6JJF1TuSGPr4yWchXYDjOxzUDfzst2iOr7m/4NlPmdO1mbWAM
         yki1nuOxaiPFYEdcHgvUTWyaBiGQG2KxfQn20+2fgvO8z+RPzQGiMGgzzGPvtV7zDt
         MlqX9Val8SunWJbUIi156vuYRC4SVFkmeB7svxjD5MSFfasdA+kLdO/B8jU7R6BxVa
         S9MJzGOHBdEYB8cRGYzAIy60WiEO+aaE55Sy0loVhWiPXSdJQR1vZsgU5/75BfZ9Zb
         ZqXukkDwpI7lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C0C215C095D; Fri,  2 Dec 2022 17:11:47 -0800 (PST)
Date:   Fri, 2 Dec 2022 17:11:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@meta.com
Subject: [GIT PULL] RCU changes for v6.2
Message-ID: <20221203011147.GA1815487@paulmck-ThinkPad-P17-Gen-1>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.12.02a
  # HEAD: 87492c06e68d802852c7ba76b4d3fde50807d72a Merge branches 'doc.2022.10.20a', 'fixes.2022.10.21a', 'lazy.2022.11.30a', 'srcunmisafe.2022.11.09a', 'torture.2022.10.18c' and 'torturescript.2022.10.20a' into HEAD (2022-11-30 13:20:05 -0800)

----------------------------------------------------------------
RCU pull request for v6.2

This pull request contains the following branches:

doc.2022.10.20a: Documentation updates.  This is the second
	in a series from an ongoing review of the RCU documentation.

fixes.2022.10.21a: Miscellaneous fixes.

lazy.2022.11.30a: Introduces a default-off Kconfig option that depends
	on RCU_NOCB_CPU that, on CPUs mentioned in the nohz_full or
	rcu_nocbs boot-argument CPU lists, causes call_rcu() to introduce
	delays.  These delays result in significant power savings on
	nearly idle Android and ChromeOS systems.  These savings range
	from a few percent to more than ten percent.

	This series also includes several commits that change call_rcu()
	to a new call_rcu_hurry() function that avoids these delays in
	a few cases, for example, where timely wakeups are required.
	Several of these are outside of RCU and thus have acks and
	reviews from the relevant maintainers.

srcunmisafe.2022.11.09a: Creates an srcu_read_lock_nmisafe() and an
	srcu_read_unlock_nmisafe() for architectures that support NMIs,
	but which do not provide NMI-safe this_cpu_inc().  These NMI-safe
	SRCU functions are required by the upcoming lockless printk()
	work by John Ogness et al.

	That printk() series depends on these commits, so if you pull
	the printk() series before this one, you will have already
	pulled in this branch, plus two more SRCU commits:

	0cd7e350abc4 ("rcu: Make SRCU mandatory")
	51f5f78a4f80 ("srcu: Make Tiny synchronize_srcu() check for readers")

	These two commits appear to work well, but do not have
	sufficient testing exposure over a long enough time for me to
	feel comfortable pushing them unless something in mainline is
	definitely going to use them immediately, and currently only
	the new printk() work uses them.

torture.2022.10.18c: Changes providing minor but important increases
	in test coverage for the new RCU polled-grace-period APIs.

torturescript.2022.10.20a: Changes that avoid redundant kernel builds,
	thus providing about a 30% speedup for the torture.sh acceptance
	test.

----------------------------------------------------------------
Eric Dumazet (1):
      net: devinet: Reduce refcount before grace period

Frederic Weisbecker (4):
      rcu: Fix missing nocb gp wake on rcu_barrier()
      srcu: Warn when NMI-unsafe API is used in NMI
      srcu: Explain the reason behind the read side critical section on GP start
      srcu: Debug NMI safety even on archs that don't require it

Joel Fernandes (Google) (10):
      rcu: Use READ_ONCE() for lockless read of rnp->qsmask
      rcu: Fix late wakeup when flush of bypass cblist happens
      rcu: Make call_rcu() lazy to save power
      rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
      rcuscale: Add laziness and kfree tests
      rcu/sync: Use call_rcu_hurry() instead of call_rcu
      rcu/rcuscale: Use call_rcu_hurry() for async reader test
      rcu/rcutorture: Use call_rcu_hurry() where needed
      percpu-refcount: Use call_rcu_hurry() for atomic switch
      net: Use call_rcu_hurry() for dst_release()

John Ogness (1):
      rcu: Implement lockdep_rcu_enabled for !CONFIG_DEBUG_LOCK_ALLOC

Paul E. McKenney (25):
      srcu: Convert ->srcu_lock_count and ->srcu_unlock_count to atomic
      doc: Remove arrayRCU.rst
      doc: Update checklist.txt
      rcutorture: Verify NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE
      rcutorture: Verify NUM_ACTIVE_RCU_POLL_OLDSTATE
      rcutorture: Add --bootargs parameter to kvm-again.sh
      torture: Use mktemp instead of guessing at unique names
      rcutorture: Make kvm-test-1-run-qemu.sh check for alternative output
      rcutorture: Make kvm-recheck.sh export TORTURE_SUITE
      rcutorture: Add --datestamp parameter to kvm-again.sh
      rcutorture: Avoid redundant builds for rcuscale and refscale in torture.sh
      doc: Update listRCU.rst
      doc: Update RCU's lockdep.rst
      srcu: Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe()
      srcu: Check for consistent per-CPU per-srcu_struct NMI safety
      srcu: Check for consistent global per-srcu_struct NMI safety
      arch/x86: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
      arch/arm64: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
      rcutorture: Avoid torture.sh compressing identical files
      torture: Make torture.sh create a properly formatted log file
      slab: Explain why SLAB_TYPESAFE_BY_RCU reference before locking
      rcu-tasks: Make grace-period-age message human-readable
      arch/loongarch: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
      arch/s390: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
      Merge branches 'doc.2022.10.20a', 'fixes.2022.10.21a', 'lazy.2022.11.30a', 'srcunmisafe.2022.11.09a', 'torture.2022.10.18c' and 'torturescript.2022.10.20a' into HEAD

Pingfan Liu (1):
      rcu: Synchronize ->qsmaskinitnext in rcu_boost_kthread_setaffinity()

Uladzislau Rezki (2):
      scsi/scsi_error: Use call_rcu_hurry() instead of call_rcu()
      workqueue: Make queue_rcu_work() use call_rcu_hurry()

Vineeth Pillai (1):
      rcu: Shrinker for lazy rcu

Yipeng Zou (1):
      rcu: Remove rcu_is_idle_cpu()

Zeng Heng (1):
      rcu: Remove unused 'cpu' in rcu_virt_note_context_switch()

Zhen Lei (1):
      rcu: Simplify rcu_init_nohz() cpumask handling

Zqiang (2):
      rcu: Remove duplicate RCU exp QS report from rcu_report_dead()
      rcu: Fix __this_cpu_read() lockdep warning in rcu_force_quiescent_state()

 Documentation/RCU/arrayRCU.rst                     | 165 -------------
 Documentation/RCU/checklist.rst                    | 244 +++++++++++--------
 Documentation/RCU/index.rst                        |   1 -
 Documentation/RCU/listRCU.rst                      | 174 ++++++++------
 Documentation/RCU/lockdep.rst                      |   4 +
 arch/Kconfig                                       |   3 +
 arch/arm64/Kconfig                                 |   1 +
 arch/loongarch/Kconfig                             |   1 +
 arch/s390/Kconfig                                  |   1 +
 arch/x86/Kconfig                                   |   1 +
 drivers/scsi/scsi_error.c                          |   2 +-
 include/linux/kvm_host.h                           |   2 +-
 include/linux/rcupdate.h                           |  14 ++
 include/linux/rcutiny.h                            |   4 +-
 include/linux/rcutree.h                            |   4 +-
 include/linux/slab.h                               |  11 +
 include/linux/srcu.h                               |  63 +++++
 include/linux/srcutree.h                           |   5 +-
 kernel/rcu/Kconfig                                 |  11 +
 kernel/rcu/rcu.h                                   |   8 +
 kernel/rcu/rcuscale.c                              |  69 +++++-
 kernel/rcu/rcutorture.c                            |  72 ++++--
 kernel/rcu/srcutree.c                              | 100 ++++++--
 kernel/rcu/sync.c                                  |   2 +-
 kernel/rcu/tasks.h                                 |   2 +-
 kernel/rcu/tiny.c                                  |   2 +-
 kernel/rcu/tree.c                                  | 152 +++++++-----
 kernel/rcu/tree.h                                  |  12 +-
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_nocb.h                             | 259 ++++++++++++++++-----
 kernel/rcu/tree_plugin.h                           |   5 +-
 kernel/workqueue.c                                 |   2 +-
 lib/percpu-refcount.c                              |   3 +-
 net/core/dst.c                                     |   2 +-
 net/ipv4/devinet.c                                 |  19 +-
 .../testing/selftests/rcutorture/bin/config2csv.sh |   3 +-
 .../selftests/rcutorture/bin/config_override.sh    |   3 +-
 .../selftests/rcutorture/bin/configcheck.sh        |   3 +-
 .../testing/selftests/rcutorture/bin/configinit.sh |   3 +-
 .../testing/selftests/rcutorture/bin/kvm-again.sh  |  49 +++-
 .../selftests/rcutorture/bin/kvm-assign-cpus.sh    |   3 +-
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |   3 +-
 .../selftests/rcutorture/bin/kvm-end-run-stats.sh  |   3 +-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |   2 +-
 .../testing/selftests/rcutorture/bin/kvm-remote.sh |  13 +-
 .../rcutorture/bin/kvm-test-1-run-batch.sh         |   3 +-
 .../rcutorture/bin/kvm-test-1-run-qemu.sh          |   5 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |   3 +-
 .../selftests/rcutorture/bin/kvm-transform.sh      |  68 +++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   3 +-
 .../selftests/rcutorture/bin/parse-build.sh        |   3 +-
 tools/testing/selftests/rcutorture/bin/torture.sh  | 145 ++++++++++--
 52 files changed, 1159 insertions(+), 578 deletions(-)
 delete mode 100644 Documentation/RCU/arrayRCU.rst
