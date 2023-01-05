Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62A865E1FA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjAEAts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjAEAsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:48:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953394731B;
        Wed,  4 Jan 2023 16:45:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1816FB81987;
        Thu,  5 Jan 2023 00:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ED2C433A4;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879503;
        bh=O1cvLXslwasqBFvrGBgEFY2X2iW5lbp1qzrBi1HIquQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XoBSKmKMCpBx6dipT4sHYSHxYlTMCXPOOKc9PNEE9r+T5VtnYkWvPE5uqmXDcUdLy
         GiwF+7wtiCbhh2uCMOIFdBV1ZvUKuHjxQ0BMokq6L2vPTm36Xuhq2KdLafaHbIrVS9
         EGpXoJ82b0K3T8QT9GVqAY2wQPdxYneOwP/gCupvvQkx/15+fMPx8LDCP43qvp1RBs
         nw45YtXTYbTLxCPWBpMgunw6wOsMCxOk8KmlVdA1T9Tw+8/6/Lvzbq7gdNFzv5UfjX
         lUAcoP3JjZqBD8ZDzMH7Y9hWLzkttUAqG51nn/WamxGmAOyHzMvNGbfoYeDzDAlwww
         mpxubPcIpu0+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E4E175C1AE0; Wed,  4 Jan 2023 16:45:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/7] locktorture: Allow non-rtmutex lock types to be boosted
Date:   Wed,  4 Jan 2023 16:44:55 -0800
Message-Id: <20230105004501.1771332-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
References: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Currently RT boosting is only done for rtmutex_lock, however with proxy
execution, we also have the mutex_lock participating in priorities. To
exercise the testing better, add RT boosting to other lock testing types
as well, using a new knob (rt_boost).

Tested with boot parameters:
locktorture.torture_type=mutex_lock
locktorture.onoff_interval=1
locktorture.nwriters_stress=8
locktorture.stutter=0
locktorture.rt_boost=1
locktorture.rt_boost_factor=1
locktorture.nlocks=3

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 99 ++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 43 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9c2fb613a55d2..e2271e8fc3027 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -46,6 +46,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
 torture_param(int, stat_interval, 60,
 	     "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
+torture_param(int, rt_boost, 2,
+		"Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
 torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
 
@@ -127,15 +129,49 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
 	  /* BUGGY, do not use in real life!!! */
 }
 
-static void torture_boost_dummy(struct torture_random_state *trsp)
+static void __torture_rt_boost(struct torture_random_state *trsp)
 {
-	/* Only rtmutexes care about priority */
+	const unsigned int factor = 50000; /* yes, quite arbitrary */
+
+	if (!rt_task(current)) {
+		/*
+		 * Boost priority once every ~50k operations. When the
+		 * task tries to take the lock, the rtmutex it will account
+		 * for the new priority, and do any corresponding pi-dance.
+		 */
+		if (trsp && !(torture_random(trsp) %
+			      (cxt.nrealwriters_stress * factor))) {
+			sched_set_fifo(current);
+		} else /* common case, do nothing */
+			return;
+	} else {
+		/*
+		 * The task will remain boosted for another ~500k operations,
+		 * then restored back to its original prio, and so forth.
+		 *
+		 * When @trsp is nil, we want to force-reset the task for
+		 * stopping the kthread.
+		 */
+		if (!trsp || !(torture_random(trsp) %
+			       (cxt.nrealwriters_stress * factor * 2))) {
+			sched_set_normal(current, 0);
+		} else /* common case, do nothing */
+			return;
+	}
+}
+
+static void torture_rt_boost(struct torture_random_state *trsp)
+{
+	if (rt_boost != 2)
+		return;
+
+	__torture_rt_boost(trsp);
 }
 
 static struct lock_torture_ops lock_busted_ops = {
 	.writelock	= torture_lock_busted_write_lock,
 	.write_delay	= torture_lock_busted_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_lock_busted_write_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -179,7 +215,7 @@ __releases(torture_spinlock)
 static struct lock_torture_ops spin_lock_ops = {
 	.writelock	= torture_spin_lock_write_lock,
 	.write_delay	= torture_spin_lock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_spin_lock_write_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -206,7 +242,7 @@ __releases(torture_spinlock)
 static struct lock_torture_ops spin_lock_irq_ops = {
 	.writelock	= torture_spin_lock_write_lock_irq,
 	.write_delay	= torture_spin_lock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_lock_spin_write_unlock_irq,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -275,7 +311,7 @@ __releases(torture_rwlock)
 static struct lock_torture_ops rw_lock_ops = {
 	.writelock	= torture_rwlock_write_lock,
 	.write_delay	= torture_rwlock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_rwlock_write_unlock,
 	.readlock       = torture_rwlock_read_lock,
 	.read_delay     = torture_rwlock_read_delay,
@@ -318,7 +354,7 @@ __releases(torture_rwlock)
 static struct lock_torture_ops rw_lock_irq_ops = {
 	.writelock	= torture_rwlock_write_lock_irq,
 	.write_delay	= torture_rwlock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_rwlock_write_unlock_irq,
 	.readlock       = torture_rwlock_read_lock_irq,
 	.read_delay     = torture_rwlock_read_delay,
@@ -358,7 +394,7 @@ __releases(torture_mutex)
 static struct lock_torture_ops mutex_lock_ops = {
 	.writelock	= torture_mutex_lock,
 	.write_delay	= torture_mutex_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_mutex_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -456,7 +492,7 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 	.exit		= torture_ww_mutex_exit,
 	.writelock	= torture_ww_mutex_lock,
 	.write_delay	= torture_mutex_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_ww_mutex_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -474,37 +510,6 @@ __acquires(torture_rtmutex)
 	return 0;
 }
 
-static void torture_rtmutex_boost(struct torture_random_state *trsp)
-{
-	const unsigned int factor = 50000; /* yes, quite arbitrary */
-
-	if (!rt_task(current)) {
-		/*
-		 * Boost priority once every ~50k operations. When the
-		 * task tries to take the lock, the rtmutex it will account
-		 * for the new priority, and do any corresponding pi-dance.
-		 */
-		if (trsp && !(torture_random(trsp) %
-			      (cxt.nrealwriters_stress * factor))) {
-			sched_set_fifo(current);
-		} else /* common case, do nothing */
-			return;
-	} else {
-		/*
-		 * The task will remain boosted for another ~500k operations,
-		 * then restored back to its original prio, and so forth.
-		 *
-		 * When @trsp is nil, we want to force-reset the task for
-		 * stopping the kthread.
-		 */
-		if (!trsp || !(torture_random(trsp) %
-			       (cxt.nrealwriters_stress * factor * 2))) {
-			sched_set_normal(current, 0);
-		} else /* common case, do nothing */
-			return;
-	}
-}
-
 static void torture_rtmutex_delay(struct torture_random_state *trsp)
 {
 	const unsigned long shortdelay_us = 2;
@@ -530,10 +535,18 @@ __releases(torture_rtmutex)
 	rt_mutex_unlock(&torture_rtmutex);
 }
 
+static void torture_rt_boost_rtmutex(struct torture_random_state *trsp)
+{
+	if (!rt_boost)
+		return;
+
+	__torture_rt_boost(trsp);
+}
+
 static struct lock_torture_ops rtmutex_lock_ops = {
 	.writelock	= torture_rtmutex_lock,
 	.write_delay	= torture_rtmutex_delay,
-	.task_boost     = torture_rtmutex_boost,
+	.task_boost     = torture_rt_boost_rtmutex,
 	.writeunlock	= torture_rtmutex_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -600,7 +613,7 @@ __releases(torture_rwsem)
 static struct lock_torture_ops rwsem_lock_ops = {
 	.writelock	= torture_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_rwsem_up_write,
 	.readlock       = torture_rwsem_down_read,
 	.read_delay     = torture_rwsem_read_delay,
@@ -652,7 +665,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.exit		= torture_percpu_rwsem_exit,
 	.writelock	= torture_percpu_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_percpu_rwsem_up_write,
 	.readlock       = torture_percpu_rwsem_down_read,
 	.read_delay     = torture_rwsem_read_delay,
-- 
2.31.1.189.g2e36527f23

