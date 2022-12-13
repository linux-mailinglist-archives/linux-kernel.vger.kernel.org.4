Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63E64BE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiLMUsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbiLMUsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:48:47 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE34175AA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:48:44 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z12so906797qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgB8o7r5q35ufkQfTVEI1g6ta2jLelpUzptLG5w6In4=;
        b=D+kO/iR7y9EiLfw2ghUa2eLjJOuj2TVXIaYhzIHlfLueijDowkxBcWTHwLbzkg8NSu
         zvhJ9QqgDIVBoZZNwirnaTUg6BbomKH2yuhYljYbWrBpk6Qllh5Cd4HB0PfMOYMpt9VM
         2WZCZuvIYejfh4A5IQ2IjyKRrN/nHXj8tP+dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgB8o7r5q35ufkQfTVEI1g6ta2jLelpUzptLG5w6In4=;
        b=ypJF3GCoI53P2qElKJmYUazKIbBQ0NyTyw/fstQVy0tkwPgmb30ziq3e/U49sg18MQ
         3A4ZvaBcnODmt0/n7peW1FFwYBbcweSM6PBa0j/02JmK4KxlM3lX4EjzD9+RfKrcWu8t
         Km+ji2syhe/C6Wu2ATaJjOWQb27lWRgWjh3NpwMBRpCdZuJ0TBB+NDblQRUTw1dF77Ap
         GBtudP1bmGLzgq5NXbrhsQwVe3QLQJc7AfwTO/qliuFwO5xPljQjd3DU6Q0T/Sfb6yrK
         +qUcnoV3/gJ1GE+B16q5hwFg3FXx22O923rM1rkwFTywMgkGOCiwejQntndtl49Z45jv
         7ICw==
X-Gm-Message-State: ANoB5pm0o5+UhDURCt6JjxER9IxlCIEhskwMrjl1ol4SnM3Y3RRa0ukh
        kwKmAiQ6h0XCk+mmdL4sV+vJj6GfyPm9aArc
X-Google-Smtp-Source: AA0mqf5cnanCMQPwlbQAedBXFJ/TiioaUyby/c5MhJ0ZKix8MUewm+FgZgdW7zncCqjjO3uqi6QehA==
X-Received: by 2002:ac8:534c:0:b0:3a4:ea5c:6fc2 with SMTP id d12-20020ac8534c000000b003a4ea5c6fc2mr6670731qto.52.1670964523400;
        Tue, 13 Dec 2022 12:48:43 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a400300b006fc447eebe5sm8562757qko.27.2022.12.13.12.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:48:42 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Subject: [PATCH v3 rcu/dev 1/2] locktorture: Allow non-rtmutex lock types to be boosted
Date:   Tue, 13 Dec 2022 20:48:38 +0000
Message-Id: <20221213204839.321027-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

For the rtmutex test, rt_boost is always enabled even if disabling is
requested.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/locking/locktorture.c | 99 ++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 43 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9c2fb613a55d..e2271e8fc302 100644
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
2.39.0.314.g84b9a713c41-goog

