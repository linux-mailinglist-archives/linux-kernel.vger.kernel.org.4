Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E520687F73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjBBOAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjBBN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:59:59 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB4A8FB4D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:59:52 -0800 (PST)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 312DxosL077687;
        Thu, 2 Feb 2023 22:59:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Thu, 02 Feb 2023 22:59:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 312Dxoom077683
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Feb 2023 22:59:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ed17797b-e732-0dd0-2b4e-dc293653c0ac@I-love.SAKURA.ne.jp>
Date:   Thu, 2 Feb 2023 22:59:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v3] locking/lockdep: add debug_show_all_lock_holders()
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

debug_show_all_lock_holders() skips current thread if the caller is
holding no lock, for reporting RCU lock taken inside that function is
generally useless.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v3:
  Unshare debug_show_all_lock_holders() and debug_show_all_locks(),
  suggested by Ingo Molnar <mingo@kernel.org>.

Changes in v2:
  Share debug_show_all_lock_holders() and debug_show_all_locks(),
  suggested by Waiman Long <longman@redhat.com>.

 include/linux/debug_locks.h |  5 +++++
 kernel/hung_task.c          |  2 +-
 kernel/locking/lockdep.c    | 28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index dbb409d77d4f..0567d5ce5b4a 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -50,6 +50,7 @@ extern int debug_locks_off(void);
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
index c71889f3f3fc..5fba784258b7 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -213,7 +213,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
  unlock:
 	rcu_read_unlock();
 	if (hung_task_show_lock)
-		debug_show_all_locks();
+		debug_show_all_lock_holders();
 
 	if (hung_task_show_all_bt) {
 		hung_task_show_all_bt = false;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e3375bc40dad..d9394de09b79 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -32,6 +32,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/task.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/debug.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
@@ -6511,6 +6512,33 @@ void debug_show_all_locks(void)
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
+		if (p == current && p->lockdep_depth == 1)
+			continue;
+		sched_show_task(p);
+		lockdep_print_held_locks(p);
+		touch_nmi_watchdog();
+		touch_all_softlockup_watchdogs();
+	}
+	rcu_read_unlock();
+
+	pr_warn("\n");
+	pr_warn("=============================================\n\n");
+}
 #endif
 
 /*
-- 
2.18.4
