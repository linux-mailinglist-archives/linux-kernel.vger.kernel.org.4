Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6138872B8B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjFLHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjFLHhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:37:40 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA4E173A;
        Mon, 12 Jun 2023 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686555330;
  x=1718091330;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=GQRdgktJSgoBra8xnN5+347fk+XcPhSW44tQp4xuYhs=;
  b=Br2i1hM5V4ZlFgLIPQa4awu3BfVcYMOHjHH+l6PlqZ4aO9s61p8Gph33
   IpWuuvo9dZ/J+41BUyU56RlTB8QiqViUmo46mKMd60Hbjha8kWS+bFkfw
   7DuNq00YjQiTAccAVIruLjxnVa8ir2+t49Ny7jPFS3c8DHrB/wseiako8
   Art43SQOWlXFQCBE02UD/we2jUwfCr0dwcHWa2/7oTIgI1izFXZ+w5f8X
   Gt82YaBdf1yHiIOrSyU4Ul8qX+nvepX+f9k3Ebi+I51DvZgrbfzjLfyWw
   Utc11GktEdBtlMM4vPtvD0OHNqYHnyVrWsCqy1/AsYFuuPj54wOIV1uBi
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Mon, 12 Jun 2023 09:26:48 +0200
Subject: [PATCH v2] watchdog/mm: Allow dumping memory info in pretimeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230608-pretimeout-oom-v2-1-581f0ad0e4f3@axis.com>
X-B4-Tracking: v=1; b=H4sIALfIhmQC/3WNQQ6CMBAAv0L27Jq2VARP/sNwKGWRPcCSFgmG8
 HcLd48zyWQ2iBSYIjyyDQItHFnGBOaSge/d+CbkNjEYZXJVqBKnQDMPJJ8ZRQasKm1Lm5dOtx2
 kqHGRsAlu9P2RdSLroVPV8Xp+XnXinuMs4XtuF33Yv4dFo8abNd5XWhWmvT/dyvHqZYB63/cf3
 3VwpsIAAAA=
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my (embedded) systems, the most common cause of hitting the watchdog
(pre)timeout is due to thrashing.  Diagnosing these problems is hard
without knowing the memory state at the point of the watchdog hit.  In
order to make this information available, add a module parameter to the
watchdog pretimeout panic governor to ask it to dump memory info and the
OOM task list (using a new helper in the OOM code) before triggering the
panic.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
Changes in v2:
- Add missing static to fix warning reported by kernel test robot.
- Export __show_mem to fix error reported by kernel test robot.
- Link to v1: https://lore.kernel.org/r/20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com
---
 drivers/watchdog/pretimeout_panic.c | 15 +++++++++++
 include/linux/oom.h                 |  5 ++++
 include/linux/sched/task.h          |  5 ++++
 lib/show_mem.c                      |  1 +
 mm/oom_kill.c                       | 54 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
index 2cc3c41d2be5b..52d686fa541c7 100644
--- a/drivers/watchdog/pretimeout_panic.c
+++ b/drivers/watchdog/pretimeout_panic.c
@@ -5,10 +5,15 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/oom.h>
 #include <linux/watchdog.h>
 
 #include "watchdog_pretimeout.h"
 
+static unsigned long dump_min_rss_bytes;
+module_param(dump_min_rss_bytes, ulong, 0644);
+
 /**
  * pretimeout_panic - Panic on watchdog pretimeout event
  * @wdd - watchdog_device
@@ -17,6 +22,16 @@
  */
 static void pretimeout_panic(struct watchdog_device *wdd)
 {
+	/*
+	 * Since the root cause is not certain to be low memory, only print
+	 * tasks with RSS above a configurable limit, to avoid losing
+	 * potentially more important messages from the log.
+	 */
+	if (dump_min_rss_bytes) {
+		show_mem(SHOW_MEM_FILTER_NODES, NULL);
+		oom_dump_tasks(DIV_ROUND_UP(dump_min_rss_bytes, PAGE_SIZE));
+	}
+
 	panic("watchdog pretimeout event\n");
 }
 
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7d0c9c48a0c54..1451fe2c38d78 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -52,6 +52,9 @@ struct oom_control {
 
 	/* Used to print the constraint info. */
 	enum oom_constraint constraint;
+
+	bool dump_trylock;
+	unsigned long dump_min_rss_pages;
 };
 
 extern struct mutex oom_lock;
@@ -102,6 +105,8 @@ long oom_badness(struct task_struct *p,
 
 extern bool out_of_memory(struct oom_control *oc);
 
+extern void oom_dump_tasks(unsigned long min_rss_pages);
+
 extern void exit_oom_victim(void);
 
 extern int register_oom_notifier(struct notifier_block *nb);
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index e0f5ac90a228b..e8a68b2a3e829 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -183,6 +183,11 @@ static inline void task_lock(struct task_struct *p)
 	spin_lock(&p->alloc_lock);
 }
 
+static inline int task_trylock(struct task_struct *p)
+{
+	return spin_trylock(&p->alloc_lock);
+}
+
 static inline void task_unlock(struct task_struct *p)
 {
 	spin_unlock(&p->alloc_lock);
diff --git a/lib/show_mem.c b/lib/show_mem.c
index 1485c87be9354..cf90d1c5182b7 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -35,3 +35,4 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
 }
+EXPORT_SYMBOL_GPL(__show_mem);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 044e1eed720ee..0fad1c6d3c90c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -149,6 +149,30 @@ struct task_struct *find_lock_task_mm(struct task_struct *p)
 	return t;
 }
 
+/*
+ * Identical to the above, except that we avoid tasks which we can't lock, to
+ * avoid deadlocks when called from an interrupt handler.
+ */
+static struct task_struct *find_trylock_task_mm(struct task_struct *p)
+{
+	struct task_struct *t;
+
+	rcu_read_lock();
+
+	for_each_thread(p, t) {
+		if (!task_trylock(t))
+			continue;
+		if (likely(t->mm))
+			goto found;
+		task_unlock(t);
+	}
+	t = NULL;
+found:
+	rcu_read_unlock();
+
+	return t;
+}
+
 /*
  * order == -1 means the oom kill is required by sysrq, otherwise only
  * for display purposes.
@@ -390,15 +414,26 @@ static int dump_task(struct task_struct *p, void *arg)
 	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
 		return 0;
 
-	task = find_lock_task_mm(p);
+	task = oc->dump_trylock ? find_trylock_task_mm(p) :
+				  find_lock_task_mm(p);
 	if (!task) {
 		/*
 		 * All of p's threads have already detached their mm's. There's
 		 * no need to report them; they can't be oom killed anyway.
+		 *
+		 * Or we got here from an interrupt and the task lock is
+		 * locked, in which case we're forced to ignore this task to
+		 * avoid deadlocks.
 		 */
 		return 0;
 	}
 
+	if (oc->dump_min_rss_pages &&
+	    get_mm_rss(task->mm) < oc->dump_min_rss_pages) {
+		task_unlock(task);
+		return 0;
+	}
+
 	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
 		task->pid, from_kuid(&init_user_ns, task_uid(task)),
 		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
@@ -437,6 +472,23 @@ static void dump_tasks(struct oom_control *oc)
 	}
 }
 
+void oom_dump_tasks(unsigned long min_rss_pages)
+{
+	const gfp_t gfp_mask = GFP_KERNEL;
+	struct oom_control oc = {
+		.zonelist = node_zonelist(first_memory_node, gfp_mask),
+		.nodemask = NULL,
+		.memcg = NULL,
+		.gfp_mask = gfp_mask,
+		.order = -1,
+		.dump_min_rss_pages = min_rss_pages,
+		.dump_trylock = in_interrupt(),
+	};
+
+	dump_tasks(&oc);
+}
+EXPORT_SYMBOL_GPL(oom_dump_tasks);
+
 static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
 {
 	/* one line summary of the oom killer context. */

---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230608-pretimeout-oom-99148438a1df

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

