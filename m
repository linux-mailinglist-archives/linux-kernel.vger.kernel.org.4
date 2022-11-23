Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEE634CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiKWBVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiKWBVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:21:20 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13173D8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:21:19 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z6so10450546qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtElyjrt1s1nmV78/tq8sM5iYOsbz+FSac/YAvZjzfY=;
        b=FeWKJLVgavtLMAmkacg3nndLLRX3v5gjRpFC0Pvsl6Tjzl2psoWHhpo+MXDXYXNHYL
         CfF3y36WuiB0WuNkYGPtOyBLiDpWU0Oo+9AnYz0ibA2m9CGi3S8fN7tzPoPnFN3BO6ad
         3wAYQbtsrcAEoSEtuag95BJWifgzzKIJQxrvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtElyjrt1s1nmV78/tq8sM5iYOsbz+FSac/YAvZjzfY=;
        b=K1djOJtzfzqm7Xb0ZZXWElIlN96zxZb2cR+g4j0QDzulaVrKm0bvG4qTshojRFl3TE
         rV8aKKxpwBEm9GkIEZQg+DA6MBsyyoRNp8Ky8mz6px06WQMBwsYQGqX1PdXmFf6JGBIP
         7Xtmg4/pWLSU1rF/QO2pUqD1+muH8pfaZL4j9tcO2hBQ/XIJaq67DoYKwOScVVvltmYU
         j/NpfAwt3hi5p022BrckeAuwda1iaGFyWgOGkp4QCR6vSUa7MgAHqCSEALl4nMRwRObI
         rYJQBrp60ZrVhPndZf2Ac4RkgTIpQpc69ZkLHKPfSY1D5xF/ni+gXFZTuh0m70qLcjd1
         vC4g==
X-Gm-Message-State: ANoB5pn8L72SmcfBJ/NdYFPzcBS8TEU6XmQk7EfHzePXezDHOX2jErDq
        D5j/zNZfuVQr72SRma1TWnXZyumnw+SFPA==
X-Google-Smtp-Source: AA0mqf78RcsF5kXE9EyATFRoC96kRCwekCycihHv9lCsxitfRfZ9GBr1gXiCvR+h38OKBZACSr09kA==
X-Received: by 2002:a05:622a:5a0c:b0:3a5:1dde:dcee with SMTP id fy12-20020a05622a5a0c00b003a51ddedceemr24264139qtb.639.1669166477975;
        Tue, 22 Nov 2022 17:21:17 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id gc7-20020a05622a59c700b0035ce8965045sm9096026qtb.42.2022.11.22.17.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:21:17 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Connor O'Brien" <connoro@google.com>
Subject: [PATCH RFC 2/3] locktorture: Allow non-rtmutex lock types to be boosted
Date:   Wed, 23 Nov 2022 01:21:03 +0000
Message-Id: <20221123012104.3317665-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123012104.3317665-1-joel@joelfernandes.org>
References: <20221123012104.3317665-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/locking/locktorture.c | 91 +++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index bc3557677eed..5a388ac96a9b 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -46,6 +46,7 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
 torture_param(int, stat_interval, 60,
 	     "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
+torture_param(int, rt_boost, 0, "Perform an rt-boost from the writer, always 1 for rtmutex_lock");
 torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
 torture_param(int, nlocks, 1,
@@ -129,15 +130,44 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
 	  /* BUGGY, do not use in real life!!! */
 }
 
-static void torture_boost_dummy(struct torture_random_state *trsp)
+static void torture_rt_boost(struct torture_random_state *trsp)
 {
-	/* Only rtmutexes care about priority */
+	const unsigned int factor = 50000; /* yes, quite arbitrary */
+
+	if (!rt_boost)
+		return;
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
 }
 
 static struct lock_torture_ops lock_busted_ops = {
 	.writelock	= torture_lock_busted_write_lock,
 	.write_delay	= torture_lock_busted_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_lock_busted_write_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -181,7 +211,7 @@ __releases(torture_spinlock)
 static struct lock_torture_ops spin_lock_ops = {
 	.writelock	= torture_spin_lock_write_lock,
 	.write_delay	= torture_spin_lock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_spin_lock_write_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -208,7 +238,7 @@ __releases(torture_spinlock)
 static struct lock_torture_ops spin_lock_irq_ops = {
 	.writelock	= torture_spin_lock_write_lock_irq,
 	.write_delay	= torture_spin_lock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_lock_spin_write_unlock_irq,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -277,7 +307,7 @@ __releases(torture_rwlock)
 static struct lock_torture_ops rw_lock_ops = {
 	.writelock	= torture_rwlock_write_lock,
 	.write_delay	= torture_rwlock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_rwlock_write_unlock,
 	.readlock       = torture_rwlock_read_lock,
 	.read_delay     = torture_rwlock_read_delay,
@@ -320,7 +350,7 @@ __releases(torture_rwlock)
 static struct lock_torture_ops rw_lock_irq_ops = {
 	.writelock	= torture_rwlock_write_lock_irq,
 	.write_delay	= torture_rwlock_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_rwlock_write_unlock_irq,
 	.readlock       = torture_rwlock_read_lock_irq,
 	.read_delay     = torture_rwlock_read_delay,
@@ -362,7 +392,7 @@ __releases(torture_mutex)
 static struct lock_torture_ops mutex_lock_ops = {
 	.writelock	= torture_mutex_lock,
 	.write_delay	= torture_mutex_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_mutex_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -460,7 +490,7 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 	.exit		= torture_ww_mutex_exit,
 	.writelock	= torture_ww_mutex_lock,
 	.write_delay	= torture_mutex_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_ww_mutex_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -471,6 +501,11 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 #ifdef CONFIG_RT_MUTEXES
 static DEFINE_RT_MUTEX(torture_rtmutex);
 
+static void torture_rtmutex_init(void)
+{
+	rt_boost = 1;
+}
+
 static int torture_rtmutex_lock(int tid __maybe_unused)
 __acquires(torture_rtmutex)
 {
@@ -478,37 +513,6 @@ __acquires(torture_rtmutex)
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
@@ -535,9 +539,10 @@ __releases(torture_rtmutex)
 }
 
 static struct lock_torture_ops rtmutex_lock_ops = {
+	.init		= torture_rtmutex_init,
 	.writelock	= torture_rtmutex_lock,
 	.write_delay	= torture_rtmutex_delay,
-	.task_boost     = torture_rtmutex_boost,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_rtmutex_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
@@ -604,7 +609,7 @@ __releases(torture_rwsem)
 static struct lock_torture_ops rwsem_lock_ops = {
 	.writelock	= torture_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_rwsem_up_write,
 	.readlock       = torture_rwsem_down_read,
 	.read_delay     = torture_rwsem_read_delay,
@@ -656,7 +661,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.exit		= torture_percpu_rwsem_exit,
 	.writelock	= torture_percpu_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
-	.task_boost     = torture_boost_dummy,
+	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_percpu_rwsem_up_write,
 	.readlock       = torture_percpu_rwsem_down_read,
 	.read_delay     = torture_rwsem_read_delay,
-- 
2.38.1.584.g0f3c55d4c2-goog

