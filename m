Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9801E6DB436
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjDGT2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDGT21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:28:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57753D50B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680895662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZMQfhCDf4kXNQDtpELqzwplHn46HrfhwJZb97xtqY8M=;
        b=tRl+ssyFGrmSbr+U98CMn5DWnXwTMwCvWiL6Is6N3QMk+oQKIoaAuQf7kKgtF7E2rmQ4d+
        vu8zxOBF9i8mbbRqYEkqk0cV098tSZTcQVrQwKtKGKxTEMKYzWTrdnkvr0xMmyzg/1d2lP
        wLxr0214/YbazFosYJ/KsEfLKwVf0XMmFBK6pW6YJman4fX8KPeL5jYye3O+ink6q4JtBh
        qoJdaAOfpo7kYAlibVM91fHmkI+Vzp5NhB9v8ibpyeR3DezRME+b7hWMUN6bJHK1ldwvfg
        3COcFpmgzGV2sp8DzYeAsmL9xfj7aLfwbhDd1wCQFhp8tHyYoMiEsrhUlC34jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680895662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZMQfhCDf4kXNQDtpELqzwplHn46HrfhwJZb97xtqY8M=;
        b=AuMDKiic5w2MJhO313t4sA2tmTXvyUZ0P4meKwmQHnJHEuDZhcojokyldLtfp2ILBt4Obz
        UMWdptj8BV4XQOBA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in timer_wait_running
In-Reply-To: <ZDBin2ZQwc69hGX4@lothringen>
References: <87h6tsred7.ffs@tglx> <874jpsqdy1.ffs@tglx>
 <ZDADdMnY0oW2k5BV@lothringen> <87lej3twhv.ffs@tglx>
 <ZDBin2ZQwc69hGX4@lothringen>
Date:   Fri, 07 Apr 2023 21:27:40 +0200
Message-ID: <87ile7trv7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07 2023 at 20:36, Frederic Weisbecker wrote:

> On Fri, Apr 07, 2023 at 07:47:40PM +0200, Thomas Gleixner wrote:
>> On Fri, Apr 07 2023 at 13:50, Frederic Weisbecker wrote:
>> > On Fri, Apr 07, 2023 at 10:44:22AM +0200, Thomas Gleixner wrote:
>> >> Now memory came back. The problem with posix CPU timers is that it is
>> >> not really known to the other side which task is actually doing the
>> >> expiry. For process wide timers this could be any task in the process.
>> >> 
>> >> For hrtimers this works because the expiring context is known.
>> >
>> > So if posix_cpu_timer_del() were to clear ctmr->pid to NULL and then
>> > delay put_pid() with RCU, we could retrieve that information without
>> > holding the timer lock (with appropriate RCU accesses all around).
>> 
>> No, you can't. This only gives you the process, but the expiry might run
>> on any task of that. To make that work you need a mutex in sighand.
>
> Duh right missed that. Ok will try.

But that's nasty as well as this can race against exec/exit and you can't
hold sighand lock when acquiring the mutex.

The mutex needs to be per task and held by the task which runs the
expiry task work.

Something like the completely untested below. You get the idea though.

Thanks,

        tglx
---
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/alarmtimer.h>
 #include <linux/timerqueue.h>
 
@@ -62,9 +63,10 @@ static inline int clockid_to_fd(const cl
  * cpu_timer - Posix CPU timer representation for k_itimer
  * @node:	timerqueue node to queue in the task/sig
  * @head:	timerqueue head on which this timer is queued
- * @task:	Pointer to target task
+ * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
 	struct timerqueue_node	node;
@@ -72,6 +74,7 @@ struct cpu_timer {
 	struct pid		*pid;
 	struct list_head	elist;
 	int			firing;
+	struct task_struct	*handling;
 };
 
 static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
@@ -135,10 +138,12 @@ struct posix_cputimers {
 /**
  * posix_cputimers_work - Container for task work based posix CPU timer expiry
  * @work:	The task work to be scheduled
+ * @mutex:	Mutex held around expiry in context of this task work
  * @scheduled:  @work has been scheduled already, no further processing
  */
 struct posix_cputimers_work {
 	struct callback_head	work;
+	struct mutex		mutex;
 	unsigned int		scheduled;
 };
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -846,6 +846,8 @@ static u64 collect_timerqueue(struct tim
 			return expires;
 
 		ctmr->firing = 1;
+		/* See posix_cpu_timer_wait_running() */
+		WRITE_ONCE(ctmr->handling, current);
 		cpu_timer_dequeue(ctmr);
 		list_add_tail(&ctmr->elist, firing);
 	}
@@ -1161,7 +1163,49 @@ static void handle_posix_cpu_timers(stru
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
 static void posix_cpu_timers_work(struct callback_head *work)
 {
+	struct posix_cputimers_work *cw = container_of(work, typeof(*cw), work);
+
+	mutex_lock(&cw->mutex);
 	handle_posix_cpu_timers(current);
+	mutex_unlock(&cw->mutex);
+}
+
+/*
+ * Invoked from the posix-timer core when a cancel operation failed because
+ * the timer is marked firing. The caller holds rcu_read_lock(), which
+ * protects the timer and the task which is expiring it from being freed.
+ */
+static void posix_cpu_timer_wait_running(struct k_itimer *timr)
+{
+	struct task_struct *tsk = READ_ONCE(timr->it.cpu.handling);
+
+	/* Has the handling task completed expiry already? */
+	if (!tsk)
+		return;
+
+	/* Ensure that the task cannot go away */
+	get_task_struct(tsk);
+	/* Now drop the RCU protection so the mutex can be locked */
+	rcu_read_unlock();
+	/* Wait on the expiry mutex */
+	mutex_lock(&tsk->posix_cputimers_work.mutex);
+	/* Release it immediately again. */
+	mutex_unlock(&tsk->posix_cputimers_work.mutex);
+	/* Drop the task reference. */
+	put_task_struct(tsk);
+	/* Relock RCU so the callsite is balanced */
+	rcu_read_lock();
+}
+
+static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
+{
+	/* Ensure that timr->it.cpu.handling task cannot go away */
+	rcu_read_lock();
+	spin_unlock_irq(&timr->it_lock);
+	posix_cpu_timer_wait_running(timr);
+	rcu_read_unlock();
+	/* @timrr is on stack and is valid */
+	spin_lock_irq(&timr->it_lock);
 }
 
 /*
@@ -1177,6 +1221,7 @@ void clear_posix_cputimers_work(struct t
 	       sizeof(p->posix_cputimers_work.work));
 	init_task_work(&p->posix_cputimers_work.work,
 		       posix_cpu_timers_work);
+	mutex_init(&p->posix_cputimers_work.mutex);
 	p->posix_cputimers_work.scheduled = false;
 }
 
@@ -1255,6 +1300,15 @@ static inline void __run_posix_cpu_timer
 	lockdep_posixtimer_exit();
 }
 
+static inline void posix_cpu_timer_wait_running(struct k_itimer *timr) { }
+
+static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
+{
+	spin_unlock_irq(&timer.it_lock);
+	cpu_relax();
+	spin_lock_irq(&timer.it_lock);
+}
+
 static inline bool posix_cpu_timers_work_scheduled(struct task_struct *tsk)
 {
 	return false;
@@ -1354,6 +1408,8 @@ static void handle_posix_cpu_timers(stru
 		 */
 		spin_lock(&timer->it_lock);
 		list_del_init(&timer->it.cpu.elist);
+		/* See posix_cpu_timer_wait_running() */
+		WRITE_ONCE(timer->it.cpu.handling, NULL);
 		cpu_firing = timer->it.cpu.firing;
 		timer->it.cpu.firing = 0;
 		/*
@@ -1497,23 +1553,16 @@ static int do_cpu_nanosleep(const clocki
 		expires = cpu_timer_getexpires(&timer.it.cpu);
 		error = posix_cpu_timer_set(&timer, 0, &zero_it, &it);
 		if (!error) {
-			/*
-			 * Timer is now unarmed, deletion can not fail.
-			 */
+			/* Timer is now unarmed, deletion can not fail. */
 			posix_cpu_timer_del(&timer);
+		} else {
+			while (error == TIMER_RETRY) {
+				posix_cpu_timer_wait_running_nsleep(&timer);
+				error = posix_cpu_timer_del(&timer);
+			}
 		}
-		spin_unlock_irq(&timer.it_lock);
 
-		while (error == TIMER_RETRY) {
-			/*
-			 * We need to handle case when timer was or is in the
-			 * middle of firing. In other cases we already freed
-			 * resources.
-			 */
-			spin_lock_irq(&timer.it_lock);
-			error = posix_cpu_timer_del(&timer);
-			spin_unlock_irq(&timer.it_lock);
-		}
+		spin_unlock_irq(&timer.it_lock);
 
 		if ((it.it_value.tv_sec | it.it_value.tv_nsec) == 0) {
 			/*
@@ -1623,6 +1672,7 @@ const struct k_clock clock_posix_cpu = {
 	.timer_del		= posix_cpu_timer_del,
 	.timer_get		= posix_cpu_timer_get,
 	.timer_rearm		= posix_cpu_timer_rearm,
+	.timer_wait_running	= posix_cpu_timer_wait_running,
 };
 
 const struct k_clock clock_process = {
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -846,6 +846,10 @@ static struct k_itimer *timer_wait_runni
 	rcu_read_lock();
 	unlock_timer(timer, *flags);
 
+	/*
+	 * kc->timer_wait_running() might drop RCU lock. So @timer
+	 * cannot be touched anymore after the function returns!
+	 */
 	if (!WARN_ON_ONCE(!kc->timer_wait_running))
 		kc->timer_wait_running(timer);
 
