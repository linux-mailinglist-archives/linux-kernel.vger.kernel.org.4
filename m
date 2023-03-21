Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690906C272D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCUBP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCUBPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:15:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411281723;
        Mon, 20 Mar 2023 18:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2DB4CE173A;
        Tue, 21 Mar 2023 01:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE06EC433D2;
        Tue, 21 Mar 2023 01:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360903;
        bh=uSsX1ZvgRVBLO8H+BAEIu1n8SjGIyCfDv98BmXxjux4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EK/v/p5IiBMG55HVdcdUoESFXohrde/JzV4TzhFoU0Sic/8u3Cu5ZRUgJDVS01lrj
         LgQCUAT2FiX3kRBil2LRXZMqZNlAnWEpfyQ92PAw1hVN/iPjevBZG96/1hJQ66y7C2
         b/5DAnwWtf4CBSnCRc7FDnKZa/HSQXAxVr0rgaNYYV9iFNW/ePZ60doLKREIPW/ARt
         mg+Eth/hPIKa+dArSzrvEjbXw/lZbenglinEGujkFhmmaWDldDpuTs1wWtAItYhyiB
         mO254uSokdnMbUpHMypdKdUhAfI/lZep3f+qQkQCfA6++txm/X7N8bBoc6t3v2F1JZ
         eGGnwYnsH10sw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A6AB91540395; Mon, 20 Mar 2023 18:08:22 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com, Connor O'Brien <connoro@google.com>
Subject: [PATCH locktorture 1/5] locktorture: Add nested_[un]lock() hooks and nlocks parameter
Date:   Mon, 20 Mar 2023 18:08:17 -0700
Message-Id: <20230321010821.51601-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3679d2b2-bdb9-4fa3-8134-240a8d0f449b@paulmck-laptop>
References: <3679d2b2-bdb9-4fa3-8134-240a8d0f449b@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <jstultz@google.com>

In order to extend locktorture to support lock nesting, add
nested_lock() and nested_unlock() hooks to the torture ops.

These take a 32bit lockset mask which is generated at random,
so some number of locks will be taken before the main lock is
taken and released afterwards.

Additionally, add nested_locks module parameter to allow
specifying the number of nested locks to be used.

This has been helpful to uncover issues in the proxy-exec
series development.

This was inspired by locktorture extensions originally implemented
by Connor O'Brien, for stress testing the proxy-execution series:
  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Co-developed-by: Connor O'Brien <connoro@google.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index f04b1978899d..a8519af25ece 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -51,6 +51,9 @@ torture_param(int, rt_boost, 2,
 torture_param(int, rt_boost_factor, 50, "A factor determining how often rt-boost happens.");
 torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
+torture_param(int, nested_locks, 0, "Number of nested locks (max = 8)");
+/* Going much higher trips "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!" errors */
+#define MAX_NESTED_LOCKS 8
 
 static char *torture_type = "spin_lock";
 module_param(torture_type, charp, 0444);
@@ -79,10 +82,12 @@ static void lock_torture_cleanup(void);
 struct lock_torture_ops {
 	void (*init)(void);
 	void (*exit)(void);
+	int (*nested_lock)(int tid, u32 lockset);
 	int (*writelock)(int tid);
 	void (*write_delay)(struct torture_random_state *trsp);
 	void (*task_boost)(struct torture_random_state *trsp);
 	void (*writeunlock)(int tid);
+	void (*nested_unlock)(int tid, u32 lockset);
 	int (*readlock)(int tid);
 	void (*read_delay)(struct torture_random_state *trsp);
 	void (*readunlock)(int tid);
@@ -684,6 +689,7 @@ static int lock_torture_writer(void *arg)
 	struct lock_stress_stats *lwsp = arg;
 	int tid = lwsp - cxt.lwsa;
 	DEFINE_TORTURE_RANDOM(rand);
+	u32 lockset_mask;
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
 	set_user_nice(current, MAX_NICE);
@@ -692,7 +698,10 @@ static int lock_torture_writer(void *arg)
 		if ((torture_random(&rand) & 0xfffff) == 0)
 			schedule_timeout_uninterruptible(1);
 
+		lockset_mask = torture_random(&rand);
 		cxt.cur_ops->task_boost(&rand);
+		if (cxt.cur_ops->nested_lock)
+			cxt.cur_ops->nested_lock(tid, lockset_mask);
 		cxt.cur_ops->writelock(tid);
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lwsp->n_lock_fail++;
@@ -705,6 +714,8 @@ static int lock_torture_writer(void *arg)
 		lock_is_write_held = false;
 		WRITE_ONCE(last_lock_release, jiffies);
 		cxt.cur_ops->writeunlock(tid);
+		if (cxt.cur_ops->nested_unlock)
+			cxt.cur_ops->nested_unlock(tid, lockset_mask);
 
 		stutter_wait("lock_torture_writer");
 	} while (!torture_must_stop());
@@ -845,11 +856,11 @@ lock_torture_print_module_parms(struct lock_torture_ops *cur_ops,
 				const char *tag)
 {
 	pr_alert("%s" TORTURE_FLAG
-		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d\n",
+		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d nested_locks=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d\n",
 		 torture_type, tag, cxt.debug_lock ? " [debug]": "",
-		 cxt.nrealwriters_stress, cxt.nrealreaders_stress, stat_interval,
-		 verbose, shuffle_interval, stutter, shutdown_secs,
-		 onoff_interval, onoff_holdoff);
+		 cxt.nrealwriters_stress, cxt.nrealreaders_stress,
+		 nested_locks, stat_interval, verbose, shuffle_interval,
+		 stutter, shutdown_secs, onoff_interval, onoff_holdoff);
 }
 
 static void lock_torture_cleanup(void)
@@ -1068,6 +1079,10 @@ static int __init lock_torture_init(void)
 		}
 	}
 
+	/* cap nested_locks to MAX_NESTED_LOCKS */
+	if (nested_locks > MAX_NESTED_LOCKS)
+		nested_locks = MAX_NESTED_LOCKS;
+
 	if (cxt.cur_ops->readlock) {
 		reader_tasks = kcalloc(cxt.nrealreaders_stress,
 				       sizeof(reader_tasks[0]),
-- 
2.40.0.rc2

