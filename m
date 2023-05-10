Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD86FD408
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjEJDIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjEJDIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:08:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9182444AF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:08:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ab05018381so62725345ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 20:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683688102; x=1686280102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwgkguvpSnGm83N4U2DPooUrumJMaqldum6A19BOm74=;
        b=o25BnL7rFVCMlOF12w0bBvvhEOgdgObZsWQXerm0DVdwmoA+tsHN//bHUK8XTJD27z
         kH5riqZQRgagqpaCe6hmAY0j2IYjGSWh6Ouk6ClsSWK8kaaavTdIgPifeuczeG9c9Ono
         ziD2k6fw8MfpDqf9S/DO+VpCeqBM9M7EJsPjZAiZYq2u7bC8SwgDasHIkmxjbEXX75GZ
         oiHbWBtShq0sWNxFF65hzfYqveLATSwd4s0rvQBqKpkgytzXgT1RykrPhjZOvVShQXDg
         OApFlCnNJuGtDk41xZrb9sKeH8qTRWSAT/U0qdXGzzFsUSC6th7xQQ3JI687HLyFMJyp
         sbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683688102; x=1686280102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JwgkguvpSnGm83N4U2DPooUrumJMaqldum6A19BOm74=;
        b=fDDacVtSAFlJeRAVAhBYYX+ezhVBaN4vtXSlQc1MbKfdMGL0E/IEa8znMP6QF2g39J
         ZoYif3zS6kXFOZOFyl/LS8adkmDY8vg43nOJMBq9Vlk3XHunr3pNrqNmHhV2+Z42nzNN
         0rzhix8JA/d8JxiZAWjknsuVBT/Y22Tke3W0ZtkNH47XLcTymGeXoGPIc49kmX9uJsG2
         m+wLlXkyB3mo0o79qy7TrPQgA6cQQQkUZEynSf5FIz0BLQYQnjY88kbP5xNw21/1BDJB
         So19dfobTc34+n5qeVOxZdXO5NdLu1s014gm/gQp2mAR3d++fF1naXwXsWmvwlBWx76r
         zlqg==
X-Gm-Message-State: AC+VfDwZJFmiyxqfdul+QT8UoZ+Il25xRwx48WI+2dvD9tu+S5NotlXQ
        OFstcw4u1YIfQ2fY3e5sURw=
X-Google-Smtp-Source: ACHHUZ5Tx0pUUUrTX2f/f0j6sQYYY7XiZppmi5dZ45Y68VGiJ32II8qi3Vp87afyb7DU5isNJAHxbg==
X-Received: by 2002:a17:902:f7d3:b0:1a6:dfb3:5f4b with SMTP id h19-20020a170902f7d300b001a6dfb35f4bmr15204318plw.55.1683688101685;
        Tue, 09 May 2023 20:08:21 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001a19f3a661esm2429233plg.138.2023.05.09.20.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:08:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] workqueue: Add pwq->stats[] and a monitoring script
Date:   Tue,  9 May 2023 17:07:52 -1000
Message-Id: <20230510030752.542340-7-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510030752.542340-1-tj@kernel.org>
References: <20230510030752.542340-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the only way to peer into workqueue operations is through
tracing. While possible, it isn't easy or convenient to monitor
per-workqueue behaviors over time this way. Let's add pwq->stats[] that
track relevant events and a drgn monitoring script -
tools/workqueue/wq_monitor.py.

It's arguable whether this needs to be configurable. However, it currently
only has seven counters and the runtime overhead shouldn't be noticeable
given that they're on pwq's which are per-cpu on per-cpu workqueues and
per-numa-node on unbound ones. Let's keep it simple for the time being.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 Documentation/core-api/workqueue.rst |  30 ++++++
 kernel/workqueue.c                   |  29 +++++-
 tools/workqueue/wq_monitor.py        | 148 +++++++++++++++++++++++++++
 3 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 tools/workqueue/wq_monitor.py

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 8ec4d6270b24..a4bb2208100e 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -348,6 +348,35 @@ Guidelines
   level of locality in wq operations and work item execution.
 
 
+Monitoring
+==========
+
+Use tools/workqueue/wq_monitor.py to monitor workqueue operations: ::
+
+  $ tools/workqueue/wq_monitor.py events
+                              total  infl  CPUtime  CPUhog  CMwake  mayday rescued
+  events                      18545     0      6.1       0       5       -       -
+  events_highpri                  8     0      0.0       0       0       -       -
+  events_long                     3     0      0.0       0       0       -       -
+  events_unbound              38306     0      0.1       -       -       -       -
+  events_freezable                0     0      0.0       0       0       -       -
+  events_power_efficient      29598     0      0.2       0       0       -       -
+  events_freezable_power_        10     0      0.0       0       0       -       -
+  sock_diag_events                0     0      0.0       0       0       -       -
+
+                              total  infl  CPUtime  CPUhog  CMwake  mayday rescued
+  events                      18548     0      6.1       0       5       -       -
+  events_highpri                  8     0      0.0       0       0       -       -
+  events_long                     3     0      0.0       0       0       -       -
+  events_unbound              38322     0      0.1       -       -       -       -
+  events_freezable                0     0      0.0       0       0       -       -
+  events_power_efficient      29603     0      0.2       0       0       -       -
+  events_freezable_power_        10     0      0.0       0       0       -       -
+  sock_diag_events                0     0      0.0       0       0       -       -
+
+  ...
+
+
 Debugging
 =========
 
@@ -387,6 +416,7 @@ For the second type of problems it should be possible to just check
 The work item's function should be trivially visible in the stack
 trace.
 
+
 Non-reentrance Conditions
 =========================
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fa535d820093..09cbe85947cd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -199,6 +199,22 @@ struct worker_pool {
 	struct rcu_head		rcu;
 };
 
+/*
+ * Per-pool_workqueue statistics. These can be monitored using
+ * tools/workqueue/wq_monitor.py.
+ */
+enum pool_workqueue_stats {
+	PWQ_STAT_STARTED,	/* work items started execution */
+	PWQ_STAT_COMPLETED,	/* work items completed execution */
+	PWQ_STAT_CPU_TIME,	/* total CPU time consumed */
+	PWQ_STAT_CPU_INTENSIVE,	/* wq_cpu_intensive_thresh_us expirations */
+	PWQ_STAT_CM_WAKEUP,	/* concurrency-management worker wakeups */
+	PWQ_STAT_MAYDAY,	/* maydays to rescuer */
+	PWQ_STAT_RESCUED,	/* linked work items executed by rescuer */
+
+	PWQ_NR_STATS,
+};
+
 /*
  * The per-pool workqueue.  While queued, the lower WORK_STRUCT_FLAG_BITS
  * of work_struct->data are used for flags and the remaining high bits
@@ -236,6 +252,8 @@ struct pool_workqueue {
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
 
+	u64			stats[PWQ_NR_STATS];
+
 	/*
 	 * Release of unbound pwq is punted to system_wq.  See put_pwq()
 	 * and pwq_unbound_release_workfn() for details.  pool_workqueue
@@ -1127,6 +1145,7 @@ void notrace wq_worker_stopping(struct task_struct *task, bool voluntary)
 		 */
 		raw_spin_lock_irq(&pool->lock);
 		worker_set_flags(worker, WORKER_CPU_INTENSIVE);
+		worker->current_pwq->stats[PWQ_STAT_CPU_INTENSIVE]++;
 		wq_cpu_intensive_report(worker->current_func);
 	} else {
 		/*
@@ -1156,8 +1175,10 @@ void notrace wq_worker_stopping(struct task_struct *task, bool voluntary)
 		pool->nr_running--;
 	}
 
-	if (need_more_worker(pool))
+	if (need_more_worker(pool)) {
+		worker->current_pwq->stats[PWQ_STAT_CM_WAKEUP]++;
 		wake_up_worker(pool);
+	}
 	raw_spin_unlock_irq(&pool->lock);
 }
 
@@ -2336,6 +2357,7 @@ static void send_mayday(struct work_struct *work)
 		get_pwq(pwq);
 		list_add_tail(&pwq->mayday_node, &wq->maydays);
 		wake_up_process(wq->rescuer->task);
+		pwq->stats[PWQ_STAT_MAYDAY]++;
 	}
 }
 
@@ -2574,6 +2596,7 @@ __acquires(&pool->lock)
 	 * workqueues), so hiding them isn't a problem.
 	 */
 	lockdep_invariant_state(true);
+	pwq->stats[PWQ_STAT_STARTED]++;
 	trace_workqueue_execute_start(work);
 	worker->current_func(work);
 	/*
@@ -2581,6 +2604,9 @@ __acquires(&pool->lock)
 	 * point will only record its address.
 	 */
 	trace_workqueue_execute_end(work, worker->current_func);
+	pwq->stats[PWQ_STAT_COMPLETED]++;
+	pwq->stats[PWQ_STAT_CPU_TIME] +=
+		worker->task->se.sum_exec_runtime - worker->current_at;
 	lock_map_release(&lockdep_map);
 	lock_map_release(&pwq->wq->lockdep_map);
 
@@ -2827,6 +2853,7 @@ static int rescuer_thread(void *__rescuer)
 				if (first)
 					pool->watchdog_ts = jiffies;
 				move_linked_works(work, scheduled, &n);
+				pwq->stats[PWQ_STAT_RESCUED]++;
 			}
 			first = false;
 		}
diff --git a/tools/workqueue/wq_monitor.py b/tools/workqueue/wq_monitor.py
new file mode 100644
index 000000000000..faea81df431c
--- /dev/null
+++ b/tools/workqueue/wq_monitor.py
@@ -0,0 +1,148 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2023 Tejun Heo <tj@kernel.org>
+# Copyright (C) 2023 Meta Platforms, Inc. and affiliates.
+
+desc = """
+This is a drgn script to monitor workqueues.
+See the definition of pool_workqueue_stats enums.
+For drgn, visit https://github.com/osandov/drgn.
+"""
+
+import sys
+import signal
+import os
+import re
+import time
+import json
+
+import drgn
+from drgn.helpers.linux.list import list_for_each_entry,list_empty
+from drgn.helpers.linux.cpumask import for_each_possible_cpu
+
+import argparse
+parser = argparse.ArgumentParser(description=desc,
+                                 formatter_class=argparse.RawTextHelpFormatter)
+parser.add_argument('workqueue', metavar='REGEX', nargs='*',
+                    help='Target workqueue name patterns (all if empty)')
+parser.add_argument('-i', '--interval', metavar='SECS', type=float, default=1,
+                    help='Monitoring interval (0 to print once and exit)')
+parser.add_argument('-j', '--json', action='store_true',
+                    help='Output in json')
+args = parser.parse_args()
+
+def err(s):
+    print(s, file=sys.stderr, flush=True)
+    sys.exit(1)
+
+workqueues              = prog['workqueues']
+
+WQ_UNBOUND              = prog['WQ_UNBOUND']
+WQ_MEM_RECLAIM          = prog['WQ_MEM_RECLAIM']
+
+PWQ_STAT_STARTED        = prog['PWQ_STAT_STARTED']      # work items started execution
+PWQ_STAT_COMPLETED      = prog['PWQ_STAT_COMPLETED']	# work items completed execution
+PWQ_STAT_CPU_TIME       = prog['PWQ_STAT_CPU_TIME']     # total CPU time consumed
+PWQ_STAT_CPU_INTENSIVE  = prog['PWQ_STAT_CPU_INTENSIVE'] # wq_cpu_intensive_thresh_us expirations
+PWQ_STAT_CM_WAKEUP      = prog['PWQ_STAT_CM_WAKEUP']    # concurrency-management worker wakeups
+PWQ_STAT_MAYDAY         = prog['PWQ_STAT_MAYDAY']	# maydays to rescuer
+PWQ_STAT_RESCUED        = prog['PWQ_STAT_RESCUED']	# linked work items executed by rescuer
+PWQ_NR_STATS            = prog['PWQ_NR_STATS']
+
+class WqStats:
+    def __init__(self, wq):
+        self.name = wq.name.string_().decode()
+        self.unbound = wq.flags & WQ_UNBOUND != 0
+        self.mem_reclaim = wq.flags & WQ_MEM_RECLAIM != 0
+        self.stats = [0] * PWQ_NR_STATS
+        for pwq in list_for_each_entry('struct pool_workqueue', wq.pwqs.address_of_(), 'pwqs_node'):
+            for i in range(PWQ_NR_STATS):
+                self.stats[i] += int(pwq.stats[i])
+
+    def dict(self, now):
+        return { 'timestamp'            : now,
+                 'name'                 : self.name,
+                 'unbound'              : self.unbound,
+                 'mem_reclaim'          : self.mem_reclaim,
+                 'started'              : self.stats[PWQ_STAT_STARTED],
+                 'completed'            : self.stats[PWQ_STAT_COMPLETED],
+                 'cputime'              : self.stats[PWQ_STAT_CPU_TIME],
+                 'cpu_intensive'        : self.stats[PWQ_STAT_CPU_INTENSIVE],
+                 'cm_wakeup'            : self.stats[PWQ_STAT_CM_WAKEUP],
+                 'mayday'               : self.stats[PWQ_STAT_MAYDAY],
+                 'rescued'              : self.stats[PWQ_STAT_RESCUED], }
+
+    def table_header_str():
+        return f'{"":>24} {"total":>8} {"infl":>5} {"CPUtime":>8} {"CPUhog":>7} ' \
+            f'{"CMwake":>7} {"mayday":>7} {"rescued":>7}'
+
+    def table_row_str(self):
+        cpu_intensive = '-'
+        cm_wakeup = '-'
+        mayday = '-'
+        rescued = '-'
+
+        if not self.unbound:
+            cpu_intensive = str(self.stats[PWQ_STAT_CPU_INTENSIVE])
+            cm_wakeup = str(self.stats[PWQ_STAT_CM_WAKEUP])
+
+        if self.mem_reclaim:
+            mayday = str(self.stats[PWQ_STAT_MAYDAY])
+            rescued = str(self.stats[PWQ_STAT_RESCUED])
+
+        out = f'{self.name[-24:]:24} ' \
+              f'{self.stats[PWQ_STAT_STARTED]:8} ' \
+              f'{max(self.stats[PWQ_STAT_STARTED] - self.stats[PWQ_STAT_COMPLETED], 0):5} ' \
+              f'{self.stats[PWQ_STAT_CPU_TIME] / 1000000000:8.1f} ' \
+              f'{cpu_intensive:>7} ' \
+              f'{cm_wakeup:>7} ' \
+              f'{mayday:>7} ' \
+              f'{rescued:>7} '
+        return out.rstrip(':')
+
+exit_req = False
+
+def sigint_handler(signr, frame):
+    global exit_req
+    exit_req = True
+
+def main():
+    # handle args
+    table_fmt = not args.json
+    interval = args.interval
+
+    re_str = None
+    if args.workqueue:
+        for r in args.workqueue:
+            if re_str is None:
+                re_str = r
+            else:
+                re_str += '|' + r
+
+    filter_re = re.compile(re_str) if re_str else None
+
+    # monitoring loop
+    signal.signal(signal.SIGINT, sigint_handler)
+
+    while not exit_req:
+        now = time.time()
+
+        if table_fmt:
+            print()
+            print(WqStats.table_header_str())
+
+        for wq in list_for_each_entry('struct workqueue_struct', workqueues.address_of_(), 'list'):
+            stats = WqStats(wq)
+            if filter_re and not filter_re.search(stats.name):
+                continue
+            if table_fmt:
+                print(stats.table_row_str())
+            else:
+                print(stats.dict(now))
+
+        if interval == 0:
+            break
+        time.sleep(interval)
+
+if __name__ == "__main__":
+    main()
-- 
2.40.1

