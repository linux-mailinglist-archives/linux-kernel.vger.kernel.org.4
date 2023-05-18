Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22DA707848
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjERDBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjERDBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:01:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1B41BC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51f6461af24so994340a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684378850; x=1686970850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r+6B3Xxt7Xi/2/V6KvqAugArSC2ecFZdcxXJFl4a8s=;
        b=d85H+E1MYfx1W6j6lnXXqSHDl1krFVwrRu5AaO3mLOirQIGssjoO7us3Jo64k49apY
         hGXYBYQo9v8UaJxD6tvbo9RJ1e2N4tL+00wT2o6uSvgSRbqtdKt4PKfAehgBCqZx4LQ5
         tbkU2Awiwc3O3fW23pxoeW9KTUFQb6GZoou6ie/y8uSe4vK89OzDgVmjEMN9LqtL1EYf
         gsyHAmmM1KGPDjzFm7psmqUc74Zyhuqqk4SvY6+pS2/wlBsn3+vemvgxtNEHOeF3YYHI
         funw4Fmxk38c9f6rxBkINUM3V0G9afjbs+vB2HA9nxAklZxqLQPnNu+Hm+oxKYSzYf+5
         r73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684378850; x=1686970850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3r+6B3Xxt7Xi/2/V6KvqAugArSC2ecFZdcxXJFl4a8s=;
        b=jZ+4FEyvE+0e085j9YubWqbkZD7tvrHc9yR946e8/MWbIAiKBOT7+1w7+eOnpV+8by
         Vrq2N2PKM6iao1XyO3LtWu//28v5nSbbGDkNU6mhpofsxdS6kWCBMShKcZA6IFNLQbTW
         /0KNAY2VBDb3uoMsyyalLXB3gs0sZKMNKyYeza0i8VC3BUAo37Y88WQzn6U2cax7TbXd
         pcei++dfxBTQesp01AzXtLOSPJN6MNomV0yP04CNTNtwcw2obSDi8HuYFitxfD5Bk7BR
         MflwZtTBuYVHn/VMyK3bSjPKwpgxRAf9EWIkhXNIYFOUum+s2P84IKSt4azG3U+9QHeT
         Ybhg==
X-Gm-Message-State: AC+VfDy5Gk8rvWZ6b7ykeaD9AnWpyn/PJADZ0eu178/Nva/mktRuf/5P
        Y63x2Ji9QzOotAOOGcHXb28=
X-Google-Smtp-Source: ACHHUZ4IK/3t9dS4RkK31Y+GBoJDDO0VIpQ5/vTQCYkRi5wIC9Js38dVr7DZbPufD8DgIk9RXJiqaA==
X-Received: by 2002:a17:902:7297:b0:1ae:2e08:bacd with SMTP id d23-20020a170902729700b001ae2e08bacdmr1005018pll.14.1684378849437;
        Wed, 17 May 2023 20:00:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1c2f])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090341cf00b001ab12ccc2a7sm122725ple.98.2023.05.17.20.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:00:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/7] workqueue: Add pwq->stats[] and a monitoring script
Date:   Wed, 17 May 2023 17:00:27 -1000
Message-Id: <20230518030033.4163274-2-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518030033.4163274-1-tj@kernel.org>
References: <20230518030033.4163274-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
only has several counters and the runtime overhead shouldn't be noticeable
given that they're on pwq's which are per-cpu on per-cpu workqueues and
per-numa-node on unbound ones. Let's keep it simple for the time being.

v2: Patch reordered to earlier with fewer fields. Field will be added back
    gradually. Help message improved.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 Documentation/core-api/workqueue.rst |  32 ++++++
 kernel/workqueue.c                   |  24 ++++-
 tools/workqueue/wq_monitor.py        | 150 +++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 1 deletion(-)
 create mode 100644 tools/workqueue/wq_monitor.py

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 8ec4d6270b24..7e5c39310bbf 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -348,6 +348,37 @@ Guidelines
   level of locality in wq operations and work item execution.
 
 
+Monitoring
+==========
+
+Use tools/workqueue/wq_monitor.py to monitor workqueue operations: ::
+
+  $ tools/workqueue/wq_monitor.py events
+                              total  infl  CMwake  mayday rescued
+  events                      18545     0       5       -       -
+  events_highpri                  8     0       0       -       -
+  events_long                     3     0       0       -       -
+  events_unbound              38306     0       -       -       -
+  events_freezable                0     0       0       -       -
+  events_power_efficient      29598     0       0       -       -
+  events_freezable_power_        10     0       0       -       -
+  sock_diag_events                0     0       0       -       -
+
+                              total  infl  CMwake  mayday rescued
+  events                      18548     0       5       -       -
+  events_highpri                  8     0       0       -       -
+  events_long                     3     0       0       -       -
+  events_unbound              38322     0       -       -       -
+  events_freezable                0     0       0       -       -
+  events_power_efficient      29603     0       0       -       -
+  events_freezable_power_        10     0       0       -       -
+  sock_diag_events                0     0       0       -       -
+
+  ...
+
+See the command's help message for more info.
+
+
 Debugging
 =========
 
@@ -387,6 +418,7 @@ For the second type of problems it should be possible to just check
 The work item's function should be trivially visible in the stack
 trace.
 
+
 Non-reentrance Conditions
 =========================
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 36bccc1285b3..60d5b84cccb2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -199,6 +199,20 @@ struct worker_pool {
 	struct rcu_head		rcu;
 };
 
+/*
+ * Per-pool_workqueue statistics. These can be monitored using
+ * tools/workqueue/wq_monitor.py.
+ */
+enum pool_workqueue_stats {
+	PWQ_STAT_STARTED,	/* work items started execution */
+	PWQ_STAT_COMPLETED,	/* work items completed execution */
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
@@ -236,6 +250,8 @@ struct pool_workqueue {
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
 
+	u64			stats[PWQ_NR_STATS];
+
 	/*
 	 * Release of unbound pwq is punted to system_wq.  See put_pwq()
 	 * and pwq_unbound_release_workfn() for details.  pool_workqueue
@@ -929,8 +945,10 @@ void wq_worker_sleeping(struct task_struct *task)
 	}
 
 	pool->nr_running--;
-	if (need_more_worker(pool))
+	if (need_more_worker(pool)) {
+		worker->current_pwq->stats[PWQ_STAT_CM_WAKEUP]++;
 		wake_up_worker(pool);
+	}
 	raw_spin_unlock_irq(&pool->lock);
 }
 
@@ -2165,6 +2183,7 @@ static void send_mayday(struct work_struct *work)
 		get_pwq(pwq);
 		list_add_tail(&pwq->mayday_node, &wq->maydays);
 		wake_up_process(wq->rescuer->task);
+		pwq->stats[PWQ_STAT_MAYDAY]++;
 	}
 }
 
@@ -2403,6 +2422,7 @@ __acquires(&pool->lock)
 	 * workqueues), so hiding them isn't a problem.
 	 */
 	lockdep_invariant_state(true);
+	pwq->stats[PWQ_STAT_STARTED]++;
 	trace_workqueue_execute_start(work);
 	worker->current_func(work);
 	/*
@@ -2410,6 +2430,7 @@ __acquires(&pool->lock)
 	 * point will only record its address.
 	 */
 	trace_workqueue_execute_end(work, worker->current_func);
+	pwq->stats[PWQ_STAT_COMPLETED]++;
 	lock_map_release(&lockdep_map);
 	lock_map_release(&pwq->wq->lockdep_map);
 
@@ -2653,6 +2674,7 @@ static int rescuer_thread(void *__rescuer)
 				if (first)
 					pool->watchdog_ts = jiffies;
 				move_linked_works(work, scheduled, &n);
+				pwq->stats[PWQ_STAT_RESCUED]++;
 			}
 			first = false;
 		}
diff --git a/tools/workqueue/wq_monitor.py b/tools/workqueue/wq_monitor.py
new file mode 100644
index 000000000000..fc1643ba06b3
--- /dev/null
+++ b/tools/workqueue/wq_monitor.py
@@ -0,0 +1,150 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2023 Tejun Heo <tj@kernel.org>
+# Copyright (C) 2023 Meta Platforms, Inc. and affiliates.
+
+desc = """
+This is a drgn script to monitor workqueues. For more info on drgn, visit
+https://github.com/osandov/drgn.
+
+  total    Total number of work items executed by the workqueue.
+
+  infl     The number of currently in-flight work items.
+
+  CMwake   The number of concurrency-management wake-ups while executing a
+           work item of the workqueue.
+
+  mayday   The number of times the rescuer was requested while waiting for
+           new worker creation.
+
+  rescued  The number of work items executed by the rescuer.
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
+                 'cm_wakeup'            : self.stats[PWQ_STAT_CM_WAKEUP],
+                 'mayday'               : self.stats[PWQ_STAT_MAYDAY],
+                 'rescued'              : self.stats[PWQ_STAT_RESCUED], }
+
+    def table_header_str():
+        return f'{"":>24} {"total":>8} {"infl":>5} {"CMwake":>7} {"mayday":>7} {"rescued":>7}'
+
+    def table_row_str(self):
+        cm_wakeup = '-'
+        mayday = '-'
+        rescued = '-'
+
+        if not self.unbound:
+            cm_wakeup = str(self.stats[PWQ_STAT_CM_WAKEUP])
+
+        if self.mem_reclaim:
+            mayday = str(self.stats[PWQ_STAT_MAYDAY])
+            rescued = str(self.stats[PWQ_STAT_RESCUED])
+
+        out = f'{self.name[-24:]:24} ' \
+              f'{self.stats[PWQ_STAT_STARTED]:8} ' \
+              f'{max(self.stats[PWQ_STAT_STARTED] - self.stats[PWQ_STAT_COMPLETED], 0):5} ' \
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

