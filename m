Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D23647C31
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLICXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLICXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:23:16 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FD223155
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:23:15 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c15so2660465qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JtcB/4lYpW1SLnxMLD/1me3PkmWUoS+GQLFXxnk8CJo=;
        b=ZMmFWn7ywd29ywmNCVYZZh9HbEGsuO+guWkEqSwMej0NvN9W2eu08gDCSKMU9BLj/3
         LH2B9F4gEfixuVeXiYmFeOhvr7v+Iw51SSGWbTmR73k7MRAn/AOeAcL35K6VFt5wXfRN
         ccAoRuHj2dUqw3L2a1p3L8H4Gv/PENeqvo3Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtcB/4lYpW1SLnxMLD/1me3PkmWUoS+GQLFXxnk8CJo=;
        b=7w4dXDl9bU30/RahCZi9W26gzhV35FTxkoTIiCgPolv0773hfK3+7ULPZkqo7/ZpIe
         9/SWfnAeb0hC8wPUA5Rxk0IszIPKPX+Agi3mqZq46bMOq9z6jdYpgW4f9M2ZtypLneKF
         mgbBTCqQ53hoTkneryEeeDRRoUKSK8svS9fRaT7n4T0eOYtZ8BW6jbHnYL6pbEmx2PUo
         TLJ+rq+WpdHHFxhArvYKDtG1cZdt2KeTGldxvbFu/i64qM12ckiQLNR3DT5QIMiumMfh
         O5RjeZoR58xsUKMsy+qG8UwGbhooMWHgHZCScezkRIqEEmUQvMl8gDrE4YkLYmtzFYuP
         HWOw==
X-Gm-Message-State: ANoB5plu7n/NvfXpaj/X9/ZBdFr9R1U7eXZXuvW7a17301Ky12uS3hUN
        1HiE19Fjw3rFCUfuoYY/j5YASaPNU5c3wlqy
X-Google-Smtp-Source: AA0mqf6SEpkkp0ooBhcT64vBhBfhZS3CeS3R39yNRxLc6V8wDNjO1JSCaUoBiwSHgQo314qYMJ6Wqw==
X-Received: by 2002:ac8:74d9:0:b0:3a7:eb36:5cb1 with SMTP id j25-20020ac874d9000000b003a7eb365cb1mr5772720qtr.36.1670552593708;
        Thu, 08 Dec 2022 18:23:13 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id dm15-20020a05620a1d4f00b006feb0007217sm129812qkb.65.2022.12.08.18.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 18:23:12 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Subject: [PATCH v2 1/2] locktorture: Allow non-rtmutex lock types to be boosted
Date:   Fri,  9 Dec 2022 02:23:04 +0000
Message-Id: <20221209022305.321149-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
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
index bc3557677eed..8968fd65a90d 100644
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
 torture_param(int, nlocks, 1,
@@ -129,15 +131,49 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
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
@@ -181,7 +217,7 @@ __releases(torture_spinlock)
 static struct lock_torture_ops spin_lock_ops = {
 	.writelock	= torture_spin_lock_write_lock,
 	.write_delay	= torture_spin_lock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_spin_lock_write_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -208,7 +244,7 @@ __releases(torture_spinlock)
 static struct lock_torture_ops spin_lock_irq_ops = {
 	.writelock	= torture_spin_lock_write_lock_irq,
 	.write_delay	= torture_spin_lock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_lock_spin_write_unlock_irq,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -277,7 +313,7 @@ __releases(torture_rwlock)
 static struct lock_torture_ops rw_lock_ops = {
 	.writelock	= torture_rwlock_write_lock,
 	.write_delay	= torture_rwlock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_rwlock_write_unlock,
 	.readlock       = torture_rwlock_read_lock,
 	.read_delay     = torture_rwlock_read_delay,
@@ -320,7 +356,7 @@ __releases(torture_rwlock)
 static struct lock_torture_ops rw_lock_irq_ops = {
 	.writelock	= torture_rwlock_write_lock_irq,
 	.write_delay	= torture_rwlock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_rwlock_write_unlock_irq,
 	.readlock       = torture_rwlock_read_lock_irq,
 	.read_delay     = torture_rwlock_read_delay,
@@ -362,7 +398,7 @@ __releases(torture_mutex)
 static struct lock_torture_ops mutex_lock_ops = {
 	.writelock	= torture_mutex_lock,
 	.write_delay	= torture_mutex_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_mutex_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -460,7 +496,7 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 	.exit		= torture_ww_mutex_exit,
 	.writelock	= torture_ww_mutex_lock,
 	.write_delay	= torture_mutex_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_ww_mutex_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -478,37 +514,6 @@ __acquires(torture_rtmutex)
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
@@ -534,10 +539,18 @@ __releases(torture_rtmutex)
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
@@ -604,7 +617,7 @@ __releases(torture_rwsem)
 static struct lock_torture_ops rwsem_lock_ops = {
 	.writelock	= torture_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_rwsem_up_write,
 	.readlock       = torture_rwsem_down_read,
 	.read_delay     = torture_rwsem_read_delay,
@@ -656,7 +669,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.exit		= torture_percpu_rwsem_exit,
 	.writelock	= torture_percpu_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_percpu_rwsem_up_write,
 	.readlock       = torture_percpu_rwsem_down_read,
 	.read_delay     = torture_rwsem_read_delay,
-- 
2.39.0.rc1.256.g54fd8350bd-goog

