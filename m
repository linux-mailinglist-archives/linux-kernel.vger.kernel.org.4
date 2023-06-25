Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AECF73D1BA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFYPfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFYPfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:35:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE40C4;
        Sun, 25 Jun 2023 08:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95F3B60BA8;
        Sun, 25 Jun 2023 15:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04274C433C8;
        Sun, 25 Jun 2023 15:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687707341;
        bh=mmvd5X7DDRh2tjM27EjT3YqBdHmMVA5hXWhIzEfMWys=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=XZznjq/u64Yn7vp0X0tVte7In01zvReuR8GBL+jv02S+3U+nvjIMrmJybRwVqD95Y
         QFllfewRHJNtZFHWSqg++JYMPmjP+pbiI9JpEYqdh82WqYrDZ3oIozbMQdbrSxKic5
         UYAChygVDY7SwyJzpJrJmMRAQW21LD8LaMG+HXYXWuFjQd7AeMmqkQIU3/hfhNk0eP
         QR6Z0DO6W5/8psswHcAH6mWATwIffX4UZNFVl6jHcdURpaa0SA6nwBulo6D3YxvAut
         lo/Kqe1bjs5ilnnI/2duHi33S11gpvPBYYc4+YvTNIUCgnD/N+aBP1MgtRgp+XINqc
         Heu6GqecdL9Aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 98DBCCE39D8; Sun, 25 Jun 2023 08:35:40 -0700 (PDT)
Date:   Sun, 25 Jun 2023 08:35:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org
Subject: [GIT PULL] RCU changes for v6.5
Message-ID: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.06.22a
  # HEAD: 2e31da752c6d0e892f2a9232e18da816d04ee691: Merge branches 'doc.2023.05.10a', 'fixes.2023.05.11a', 'kvfree.2023.05.10a', 'nocb.2023.05.11a', 'rcu-tasks.2023.05.10a', 'torture.2023.05.15a' and 'rcu-urgent.2023.06.06a' into HEAD (2023-06-07 13:44:06 -0700)

----------------------------------------------------------------
RCU pull request for v6.5

This pull contains the following branches:

doc.2023.05.10a: Documentation updates

fixes.2023.05.11a: Miscellaneous fixes, perhaps most notably:

o	Remove RCU_NONIDLE().  The new visibility of most of the idle
	loop to RCU has obsoleted this API.

o	Make the RCU_SOFTIRQ callback-invocation time limit also apply
	to the rcuc kthreads that invoke callbacks for CONFIG_PREEMPT_RT.

o	Add a jiffies-based callback-invocation time limit to handle
	long-running callbacks.  (The local_clock() function is only
	invoked once per 32 callbacks due to its high overhead.)

o	Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs,
	which fixes a bug that can occur on systems with non-contiguous
	CPU numbering.

kvfree.2023.05.10a: kvfree_rcu updates

o	Eliminate the single-argument variant of k[v]free_rcu() now
	that all uses have been converted to k[v]free_rcu_mightsleep().

o	Add WARN_ON_ONCE() checks for k[v]free_rcu*() freeing callbacks
	too soon.  Yes, this is closing the barn door after the horse
	has escaped, but Murphy says that there will be more horses.

nocb.2023.05.11a: Callback-offloading updates

o	Fix a number of bugs involving the shrinker and lazy callbacks.

rcu-tasks.2023.05.10a: Tasks RCU updates

torture.2023.05.15a: Torture-test updates

rcu-urgent.2023.06.06a: Urgent SRCU fix (already pulled)

----------------------------------------------------------------
Chen-Yu Tsai (1):
      notifier: Initialize new struct srcu_usage field

Frederic Weisbecker (4):
      rcu/nocb: Protect lazy shrinker against concurrent (de-)offloading
      rcu/nocb: Fix shrinker race against callback enqueuer
      rcu/nocb: Recheck lazy callbacks under the ->nocb_lock from shrinker
      rcu/nocb: Make shrinker iterate only over NOCB CPUs

Paul E. McKenney (14):
      doc: Get rcutree module parameters back into alpha order
      doc: Document the rcutree.rcu_resched_ns module parameter
      srcu: Remove extraneous parentheses from srcu_read_lock() etc.
      rcu/kvfree: Add debug to check grace periods
      rcu: Add more RCU files to kernel-api.rst
      rcu: Check callback-invocation time limit for rcuc kthreads
      rcu: Employ jiffies-based backstop to callback time limit
      rcu: Mark additional concurrent load from ->cpu_no_qs.b.exp
      rcu: Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work
      rcu: Make rcu_cpu_starting() rely on interrupts being disabled
      rcu-tasks: Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs
      locktorture: Add long_hold to adjust lock-hold delays
      rcutorture: Correct name of use_softirq module parameter
      Merge branches 'doc.2023.05.10a', 'fixes.2023.05.11a', 'kvfree.2023.05.10a', 'nocb.2023.05.11a', 'rcu-tasks.2023.05.10a', 'torture.2023.05.15a' and 'rcu-urgent.2023.06.06a' into HEAD

Peter Zijlstra (1):
      rcu: Remove RCU_NONIDLE()

Qiuxu Zhuo (2):
      rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
      rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale

Shigeru Yoshida (1):
      rcu-tasks: Avoid pr_info() with spin lock in cblist_init_generic()

Uladzislau Rezki (Sony) (3):
      rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
      rcu/kvfree: Add debug check for GP complete for kfree_rcu_cpu list
      rcu/kvfree: Do not run a page work if a cache is disabled

Zhouyi Zhou (1):
      torture: Remove duplicated argument -enable-kvm for ppc64

Zqiang (7):
      MAINTAINERS: Update qiang1.zhang@intel.com to qiang.zhang1211@gmail.com
      rcu/kvfree: Invoke debug_rcu_bhead_unqueue() after checking bnode->gp_snap
      rcu/kvfree: Use consistent krcp when growing kfree_rcu() page cache
      rcu/kvfree: Make fill page cache start from krcp->nr_bkv_objs
      rcu/kvfree: Make drain_page_cache() take early return if cache is disabled
      rcu-tasks: Clarify the cblist_init_generic() function's pr_info() output
      doc/rcutorture: Add description of rcutorture.stall_cpu_block

 .../RCU/Design/Requirements/Requirements.rst       |  36 +---
 Documentation/RCU/whatisRCU.rst                    |   1 -
 Documentation/admin-guide/kernel-parameters.txt    | 140 ++++++++-------
 Documentation/core-api/kernel-api.rst              |  12 ++
 MAINTAINERS                                        |   2 +-
 include/linux/notifier.h                           |  10 ++
 include/linux/rcupdate.h                           |  54 +-----
 include/linux/srcu.h                               |   8 +-
 kernel/locking/locktorture.c                       |  51 +++---
 kernel/rcu/Kconfig                                 |  18 ++
 kernel/rcu/rcu.h                                   |   6 +
 kernel/rcu/rcuscale.c                              | 199 +++++++++++----------
 kernel/rcu/tasks.h                                 |  12 +-
 kernel/rcu/tree.c                                  | 131 +++++++++-----
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_nocb.h                             |  52 +++++-
 kernel/rcu/tree_plugin.h                           |   4 +-
 .../testing/selftests/rcutorture/bin/functions.sh  |   2 +-
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot       |   2 +-
 .../selftests/rcutorture/configs/rcu/TREE03.boot   |   2 +-
 20 files changed, 412 insertions(+), 332 deletions(-)
