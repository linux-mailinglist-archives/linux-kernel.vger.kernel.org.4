Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0B072468A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbjFFOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbjFFOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:41:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82261170F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:39:25 -0700 (PDT)
Message-ID: <20230606142033.552409135@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nJRKWItHXWzejPb3W+5S3exZgj7E4NSZUyd430XhqCY=;
        b=mrU8sqCrn+7K5DAa7KyiaclT2cu1WFJxS9ck94DJpJt1eUDVdDcA1fYPWAnyQFamwfS/HC
        Gpak+zdw939IwtgcWduZb6bqN7FHZhnYejDlNgyWtsFeguHp8ZPl6aaFGD6Y1INMfFRySI
        ffwbT360ct3HKA2j2EUHzhwadvU1GksVv6JEDhDCN0kcdC4ZhPC63FtKz/R+9sBpwFIv8i
        hEYOD8SnRFPkDZWM9Yv5WF+SYKbeajRMAVIORQvm13OOe9/qgQN+us2/FhVvNT20N2W8g9
        XuMBrwUKbljR5tmWey+T8pNtnzBZg/ythb1eNvAIjc/3gNdjTiahhlt0ll9aHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nJRKWItHXWzejPb3W+5S3exZgj7E4NSZUyd430XhqCY=;
        b=67v7msoLNJB90fR2k7RuTb3wOWWZ8Z5Ef9sRYGHJay27sXrmhHV299B+LzdYRMEZ+/2eYW
        RByXcYSwhRAMa6Aw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 45/45] alarmtimers: Remove return value from alarm functions
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:30 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SIG_IGN problem is solved in the core code, the alarmtimer
callbacks do not require a return value anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/power/supply/charger-manager.c |    3 +--
 fs/timerfd.c                           |    4 +---
 include/linux/alarmtimer.h             |   10 ++--------
 kernel/time/alarmtimer.c               |   16 +++++-----------
 net/netfilter/xt_IDLETIMER.c           |    4 +---
 5 files changed, 10 insertions(+), 27 deletions(-)

--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1412,10 +1412,9 @@ static inline struct charger_desc *cm_ge
 	return dev_get_platdata(&pdev->dev);
 }
 
-static enum alarmtimer_restart cm_timer_func(struct alarm *alarm, ktime_t now)
+static void cm_timer_func(struct alarm *alarm, ktime_t now)
 {
 	cm_timer_set = false;
-	return ALARMTIMER_NORESTART;
 }
 
 static int charger_manager_probe(struct platform_device *pdev)
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -79,13 +79,11 @@ static enum hrtimer_restart timerfd_tmrp
 	return HRTIMER_NORESTART;
 }
 
-static enum alarmtimer_restart timerfd_alarmproc(struct alarm *alarm,
-	ktime_t now)
+static void timerfd_alarmproc(struct alarm *alarm, ktime_t now)
 {
 	struct timerfd_ctx *ctx = container_of(alarm, struct timerfd_ctx,
 					       t.alarm);
 	timerfd_triggered(ctx);
-	return ALARMTIMER_NORESTART;
 }
 
 /*
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -20,12 +20,6 @@ enum alarmtimer_type {
 	ALARM_BOOTTIME_FREEZER,
 };
 
-enum alarmtimer_restart {
-	ALARMTIMER_NORESTART,
-	ALARMTIMER_RESTART,
-};
-
-
 #define ALARMTIMER_STATE_INACTIVE	0x00
 #define ALARMTIMER_STATE_ENQUEUED	0x01
 
@@ -42,14 +36,14 @@ enum alarmtimer_restart {
 struct alarm {
 	struct timerqueue_node	node;
 	struct hrtimer		timer;
-	enum alarmtimer_restart	(*function)(struct alarm *, ktime_t now);
+	void			(*function)(struct alarm *, ktime_t now);
 	enum alarmtimer_type	type;
 	int			state;
 	void			*data;
 };
 
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-		enum alarmtimer_restart (*function)(struct alarm *, ktime_t));
+		void (*function)(struct alarm *, ktime_t));
 void alarm_start(struct alarm *alarm, ktime_t start);
 void alarm_start_relative(struct alarm *alarm, ktime_t start);
 void alarm_restart(struct alarm *alarm);
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -312,7 +312,7 @@ static int alarmtimer_resume(struct devi
 
 static void
 __alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-	     enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+	     void (*function)(struct alarm *, ktime_t))
 {
 	timerqueue_init(&alarm->node);
 	alarm->timer.function = alarmtimer_fired;
@@ -328,7 +328,7 @@ static void
  * @function: callback that is run when the alarm fires
  */
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-		enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+		void (*function)(struct alarm *, ktime_t))
 {
 	hrtimer_init(&alarm->timer, alarm_bases[type].base_clockid,
 		     HRTIMER_MODE_ABS);
@@ -521,7 +521,7 @@ static enum alarmtimer_type clock2alarm(
  *
  * Return: whether the timer is to be restarted
  */
-static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm, ktime_t now)
+static void alarm_handle_timer(struct alarm *alarm, ktime_t now)
 {
 	struct k_itimer *ptr = container_of(alarm, struct k_itimer, it.alarm.alarmtimer);
 	unsigned long flags;
@@ -529,8 +529,6 @@ static enum alarmtimer_restart alarm_han
 	spin_lock_irqsave(&ptr->it_lock, flags);
 	posix_timer_queue_signal(ptr);
 	spin_unlock_irqrestore(&ptr->it_lock, flags);
-
-	return ALARMTIMER_NORESTART;
 }
 
 /**
@@ -691,18 +689,14 @@ static int alarm_timer_create(struct k_i
  * @now: time at the timer expiration
  *
  * Wakes up the task that set the alarmtimer
- *
- * Return: ALARMTIMER_NORESTART
  */
-static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
-								ktime_t now)
+static void alarmtimer_nsleep_wakeup(struct alarm *alarm, ktime_t now)
 {
 	struct task_struct *task = (struct task_struct *)alarm->data;
 
 	alarm->data = NULL;
 	if (task)
 		wake_up_process(task);
-	return ALARMTIMER_NORESTART;
 }
 
 /**
@@ -754,7 +748,7 @@ static int alarmtimer_do_nsleep(struct a
 
 static void
 alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
-		    enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+		    void (*function)(struct alarm *, ktime_t))
 {
 	hrtimer_init_on_stack(&alarm->timer, alarm_bases[type].base_clockid,
 			      HRTIMER_MODE_ABS);
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -107,14 +107,12 @@ static void idletimer_tg_expired(struct
 	schedule_work(&timer->work);
 }
 
-static enum alarmtimer_restart idletimer_tg_alarmproc(struct alarm *alarm,
-							  ktime_t now)
+static void idletimer_tg_alarmproc(struct alarm *alarm, ktime_t now)
 {
 	struct idletimer_tg *timer = alarm->data;
 
 	pr_debug("alarm %s expired\n", timer->attr.attr.name);
 	schedule_work(&timer->work);
-	return ALARMTIMER_NORESTART;
 }
 
 static int idletimer_check_sysfs_name(const char *name, unsigned int size)

