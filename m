Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD86FE314
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbjEJRMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbjEJRMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:12:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6AA210C;
        Wed, 10 May 2023 10:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33E69633E3;
        Wed, 10 May 2023 17:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997ABC433EF;
        Wed, 10 May 2023 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738760;
        bh=EJI43WlF+/lFEI5jOxAQoTqVyh0G3qhOIj0R1r1mM+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uA5OM24tJnpFS9Jhogj/3ud6BbjLH9YhNF9h4Y+CLA9AkXbQZ8m3FuwwZExmaRDeq
         PuTV4SNxp3Prj8hkRSHCxJsIc24iPiJTYgJGrFrHPgfr2rr6jNPgEzH06P1iPT084U
         nEfxLiAXYWX2qnIA0DJE20i2KDVZKHPB6norRAAcsdhl1PXw1gQWmUhUuMwzJDThtJ
         Lzj6iMkij6zrsFviQPU1/1gzdGeWRBjmRyTIb/4m5RaLw1/y2FE8qS53a4c3/AIfVC
         Pxhd7L/FNin7azLYySzsYxDaweHVA+dv9IOuAEtSAdT3wBQbewJPUpgEXvAnS/o2HB
         yq4B919higa8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 51D39CE126E; Wed, 10 May 2023 10:12:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/6] locktorture: Add long_hold to adjust lock-hold delays
Date:   Wed, 10 May 2023 10:12:33 -0700
Message-Id: <20230510171238.2189921-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a long_hold module parameter to allow testing diagnostics
for excessive lock-hold times.  Also adjust torture_param() invocations
for longer line length while in the area.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 51 ++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 153ddc4c47ef..949d3deae506 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -33,24 +33,19 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
-torture_param(int, nwriters_stress, -1,
-	     "Number of write-locking stress-test threads");
-torture_param(int, nreaders_stress, -1,
-	     "Number of read-locking stress-test threads");
+torture_param(int, nwriters_stress, -1, "Number of write-locking stress-test threads");
+torture_param(int, nreaders_stress, -1, "Number of read-locking stress-test threads");
+torture_param(int, long_hold, 100, "Do occasional long hold of lock (ms), 0=disable");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
-torture_param(int, onoff_interval, 0,
-	     "Time between CPU hotplugs (s), 0=disable");
-torture_param(int, shuffle_interval, 3,
-	     "Number of jiffies between shuffles, 0=disable");
+torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (s), 0=disable");
+torture_param(int, shuffle_interval, 3, "Number of jiffies between shuffles, 0=disable");
 torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
-torture_param(int, stat_interval, 60,
-	     "Number of seconds between stats printk()s");
+torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
 torture_param(int, rt_boost, 2,
-		"Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
+		   "Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
 torture_param(int, rt_boost_factor, 50, "A factor determining how often rt-boost happens.");
-torture_param(int, verbose, 1,
-	     "Enable verbose debugging printk()s");
+torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, nested_locks, 0, "Number of nested locks (max = 8)");
 /* Going much higher trips "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!" errors */
 #define MAX_NESTED_LOCKS 8
@@ -120,7 +115,7 @@ static int torture_lock_busted_write_lock(int tid __maybe_unused)
 
 static void torture_lock_busted_write_delay(struct torture_random_state *trsp)
 {
-	const unsigned long longdelay_ms = 100;
+	const unsigned long longdelay_ms = long_hold ? long_hold : ULONG_MAX;
 
 	/* We want a long delay occasionally to force massive contention.  */
 	if (!(torture_random(trsp) %
@@ -198,16 +193,18 @@ __acquires(torture_spinlock)
 static void torture_spin_lock_write_delay(struct torture_random_state *trsp)
 {
 	const unsigned long shortdelay_us = 2;
-	const unsigned long longdelay_ms = 100;
+	const unsigned long longdelay_ms = long_hold ? long_hold : ULONG_MAX;
+	unsigned long j;
 
 	/* We want a short delay mostly to emulate likely code, and
 	 * we want a long delay occasionally to force massive contention.
 	 */
-	if (!(torture_random(trsp) %
-	      (cxt.nrealwriters_stress * 2000 * longdelay_ms)))
+	if (!(torture_random(trsp) % (cxt.nrealwriters_stress * 2000 * longdelay_ms))) {
+		j = jiffies;
 		mdelay(longdelay_ms);
-	if (!(torture_random(trsp) %
-	      (cxt.nrealwriters_stress * 2 * shortdelay_us)))
+		pr_alert("%s: delay = %lu jiffies.\n", __func__, jiffies - j);
+	}
+	if (!(torture_random(trsp) % (cxt.nrealwriters_stress * 200 * shortdelay_us)))
 		udelay(shortdelay_us);
 	if (!(torture_random(trsp) % (cxt.nrealwriters_stress * 20000)))
 		torture_preempt_schedule();  /* Allow test to be preempted. */
@@ -322,7 +319,7 @@ __acquires(torture_rwlock)
 static void torture_rwlock_write_delay(struct torture_random_state *trsp)
 {
 	const unsigned long shortdelay_us = 2;
-	const unsigned long longdelay_ms = 100;
+	const unsigned long longdelay_ms = long_hold ? long_hold : ULONG_MAX;
 
 	/* We want a short delay mostly to emulate likely code, and
 	 * we want a long delay occasionally to force massive contention.
@@ -455,14 +452,12 @@ __acquires(torture_mutex)
 
 static void torture_mutex_delay(struct torture_random_state *trsp)
 {
-	const unsigned long longdelay_ms = 100;
+	const unsigned long longdelay_ms = long_hold ? long_hold : ULONG_MAX;
 
 	/* We want a long delay occasionally to force massive contention.  */
 	if (!(torture_random(trsp) %
 	      (cxt.nrealwriters_stress * 2000 * longdelay_ms)))
 		mdelay(longdelay_ms * 5);
-	else
-		mdelay(longdelay_ms / 5);
 	if (!(torture_random(trsp) % (cxt.nrealwriters_stress * 20000)))
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
@@ -630,7 +625,7 @@ __acquires(torture_rtmutex)
 static void torture_rtmutex_delay(struct torture_random_state *trsp)
 {
 	const unsigned long shortdelay_us = 2;
-	const unsigned long longdelay_ms = 100;
+	const unsigned long longdelay_ms = long_hold ? long_hold : ULONG_MAX;
 
 	/*
 	 * We want a short delay mostly to emulate likely code, and
@@ -640,7 +635,7 @@ static void torture_rtmutex_delay(struct torture_random_state *trsp)
 	      (cxt.nrealwriters_stress * 2000 * longdelay_ms)))
 		mdelay(longdelay_ms);
 	if (!(torture_random(trsp) %
-	      (cxt.nrealwriters_stress * 2 * shortdelay_us)))
+	      (cxt.nrealwriters_stress * 200 * shortdelay_us)))
 		udelay(shortdelay_us);
 	if (!(torture_random(trsp) % (cxt.nrealwriters_stress * 20000)))
 		torture_preempt_schedule();  /* Allow test to be preempted. */
@@ -695,14 +690,12 @@ __acquires(torture_rwsem)
 
 static void torture_rwsem_write_delay(struct torture_random_state *trsp)
 {
-	const unsigned long longdelay_ms = 100;
+	const unsigned long longdelay_ms = long_hold ? long_hold : ULONG_MAX;
 
 	/* We want a long delay occasionally to force massive contention.  */
 	if (!(torture_random(trsp) %
 	      (cxt.nrealwriters_stress * 2000 * longdelay_ms)))
 		mdelay(longdelay_ms * 10);
-	else
-		mdelay(longdelay_ms / 10);
 	if (!(torture_random(trsp) % (cxt.nrealwriters_stress * 20000)))
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
@@ -848,8 +841,8 @@ static int lock_torture_writer(void *arg)
 
 			lwsp->n_lock_acquired++;
 		}
-		cxt.cur_ops->write_delay(&rand);
 		if (!skip_main_lock) {
+			cxt.cur_ops->write_delay(&rand);
 			lock_is_write_held = false;
 			WRITE_ONCE(last_lock_release, jiffies);
 			cxt.cur_ops->writeunlock(tid);
-- 
2.40.1

