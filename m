Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C685BAF10
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiIPOPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIPOPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:15:50 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592B28E988
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:15:49 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28GEFkln074983;
        Fri, 16 Sep 2022 23:15:46 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Fri, 16 Sep 2022 23:15:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28GEFjsk074980
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 16 Sep 2022 23:15:46 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d5393b0e-a296-3296-d376-c9178669747b@I-love.SAKURA.ne.jp>
Date:   Fri, 16 Sep 2022 23:15:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@sifive.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        John Ogness <john.ogness@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH (repost)] locking/lockdep: add debug_show_all_lock_holders()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, check_hung_uninterruptible_tasks() reports details of locks
held in the system. Also, lockdep_print_held_locks() does not report
details of locks held by a thread if that thread is in TASK_RUNNING state.
Several years of experience of debugging without vmcore tells me that
these limitations have been a barrier for understanding what went wrong
in syzbot's "INFO: task hung in" reports.

I initially thought that the cause of "INFO: task hung in" reports is
due to over-stressing. But I understood that over-stressing is unlikely.
I now consider that there likely is a deadlock/livelock bug where lockdep
cannot report as a deadlock when "INFO: task hung in" is reported.

A typical case is that thread-1 is waiting for something to happen (e.g.
wait_event_*()) with a lock held. When thread-2 tries to hold that lock
using e.g. mutex_lock(), check_hung_uninterruptible_tasks() reports that
thread-2 is hung and thread-1 is holding a lock which thread-2 is trying
to hold. But currently check_hung_uninterruptible_tasks() cannot report
the exact location of thread-1 which gives us an important hint for
understanding why thread-1 is holding that lock for so long period.

When check_hung_uninterruptible_tasks() reports a thread waiting for a
lock, it is important to report backtrace of threads which already held
that lock. Therefore, allow check_hung_uninterruptible_tasks() to report
the exact location of threads which is holding any lock.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
This is repost of https://lkml.kernel.org/r/82af40cc-bf85-2b53-b8f9-dfc12e66a781@I-love.SAKURA.ne.jp .
I think there was no critical objection which blocks this change.

I wish that lockdep continues tracking locks (i.e. debug_locks remains 1)
even after something went wrong, for recently I sometimes encounter problems
that disable lockdep during boot stage.

It would be noisy to report possibility of e.g. circular locking dependency
every time due to keeping debug_locks enabled. But tracking locks even after
something went wrong will help debug_show_all_lock_holders() to survive
problems during boot stage.

I'm not expecting lockdep to report the same problem forever.
Reporting possibility of each problem pattern (e.g. circular locking dependency)
up to once, by using cmpxchg() inside reporting functions that call printk(),
would be enough.

I'm expecting lockdep to continue working without calling printk() even after
one of problem patterns (e.g. circular locking dependency) was printk()ed, so that
debug_show_all_locks()/debug_show_all_lock_holders() can call printk() when needed.

Changing debug_locks behavior is a future patch. For now, this patch alone
will help debugging Greg's usb.git#usb-testing tree which is generating
many "INFO: task hung in" reports.

 include/linux/debug_locks.h |  5 +++++
 kernel/hung_task.c          |  2 +-
 kernel/locking/lockdep.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index dbb409d..0567d5c 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -50,6 +50,7 @@ static __always_inline int __debug_locks_off(void)
 #ifdef CONFIG_LOCKDEP
 extern void debug_show_all_locks(void);
 extern void debug_show_held_locks(struct task_struct *task);
+extern void debug_show_all_lock_holders(void);
 extern void debug_check_no_locks_freed(const void *from, unsigned long len);
 extern void debug_check_no_locks_held(void);
 #else
@@ -61,6 +62,10 @@ static inline void debug_show_held_locks(struct task_struct *task)
 {
 }
 
+static inline void debug_show_all_lock_holders(void)
+{
+}
+
 static inline void
 debug_check_no_locks_freed(const void *from, unsigned long len)
 {
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index bb2354f..18e22bb 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -205,7 +205,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
  unlock:
 	rcu_read_unlock();
 	if (hung_task_show_lock)
-		debug_show_all_locks();
+		debug_show_all_lock_holders();
 
 	if (hung_task_show_all_bt) {
 		hung_task_show_all_bt = false;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 64a13eb..d062541 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -55,6 +55,7 @@
 #include <linux/rcupdate.h>
 #include <linux/kprobes.h>
 #include <linux/lockdep.h>
+#include <linux/sched/debug.h>
 
 #include <asm/sections.h>
 
@@ -6509,6 +6510,37 @@ void debug_show_all_locks(void)
 	pr_warn("=============================================\n\n");
 }
 EXPORT_SYMBOL_GPL(debug_show_all_locks);
+
+void debug_show_all_lock_holders(void)
+{
+	struct task_struct *g, *p;
+
+	if (unlikely(!debug_locks)) {
+		pr_warn("INFO: lockdep is turned off.\n");
+		return;
+	}
+	pr_warn("\nShowing all threads with locks held in the system:\n");
+
+	rcu_read_lock();
+	for_each_process_thread(g, p) {
+		if (!p->lockdep_depth)
+			continue;
+		/*
+		 * Assuming that the caller of this function is in a process
+		 * context without any locks held, skip current thread which is
+		 * holding only RCU read lock.
+		 */
+		if (p == current)
+			continue;
+		sched_show_task(p);
+		lockdep_print_held_locks(p);
+		touch_nmi_watchdog();
+		touch_all_softlockup_watchdogs();
+	}
+	rcu_read_unlock();
+	pr_warn("\n");
+	pr_warn("=============================================\n\n");
+}
 #endif
 
 /*
-- 
1.8.3.1
