Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9AB6FF96C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbjEKSTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbjEKSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:19:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2533040ED
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6439df6c268so5629248b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683829178; x=1686421178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nDUioqnzKbpPmnws2aJ7UXESX8vQy0kJwI44IzqgUo=;
        b=A4Jz+dPFoAkbSpYUNmHUl2WYuA2WEPyFnHj32rFAl2XuvsPIKUfIfGXoDoPyEJXKun
         hbri3vFZ9KWUsstoplUSqICpYRmt4e+a24aJP9kdFjNS09Cloca5XkMIhB2pcEp5+aiX
         hjbLWIuOcdbuAToGn4jpPSEZkS46c6nqS+UcScMmnac1vAJaLU1SQT3NMV6a7G7Q9tkf
         uU/wDKra8QjPW4DuPEOGb258niWCEQLhA3EW/DCSKZs5Q30D4JPW6EkAwUmtHvveEoTo
         Q6+9XexvTw617RkKDGI7fsHDmfscT8GkWd4MiQ8UnXLmkMLIn7EcTUiDezWA4Smzmbak
         7OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829178; x=1686421178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5nDUioqnzKbpPmnws2aJ7UXESX8vQy0kJwI44IzqgUo=;
        b=b/2V8jZTZ+4Oe5ZNrWWBG/B2ts0fg8joUTPzAmSBFP86Myjq7U6Jx/MObhAo3Mm9dy
         BckyY6YIYxHT0HarE+5bc/Lax/Tda6M9V/Q4ktNcSN/oWmupqNRWST3N1Wvmunc8Gapk
         Y1OXltSZ2WKKyiBZH4gSpBq27ToeXQoG/l78f1bEbhoz3gjNSRvF0PCewlZe05IU63Ks
         r7NT2oi45YZueBC1zaYxG4cHSvbA9zbWyTgrtiHxi8nghrIRqlpa6kHApgfYeJWUwNYL
         nCS8rs4a7dia7mcIqA0Rh+MamEItpjhj8+2OdnsNXMu27u5bDEuldz2McQ8PNIdTJPhF
         kpvA==
X-Gm-Message-State: AC+VfDwvwAHStt8P/5hCRCQ0JYBTnZDpbEew18qTX0Y5/Wu4X5ij41fN
        WE8lh3OVt1Qbp2zcDgrPu2M=
X-Google-Smtp-Source: ACHHUZ7GkSBGV9F0hwF57c5yIaBhckzzHDv5w4TWVUfDLyIivbu1iD/WwtVJxD9pJ1qBntOSNMQM8A==
X-Received: by 2002:a05:6a20:54a2:b0:100:8592:9a7f with SMTP id i34-20020a056a2054a200b0010085929a7fmr20152423pzk.45.1683829178247;
        Thu, 11 May 2023 11:19:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s4-20020a62e704000000b0063b8d21be5asm5772885pfh.147.2023.05.11.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:19:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/7] workqueue: Add pwq->stats[] and a monitoring script
Date:   Thu, 11 May 2023 08:19:25 -1000
Message-Id: <20230511181931.869812-2-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511181931.869812-1-tj@kernel.org>
References: <20230511181931.869812-1-tj@kernel.org>
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
 tools/workqueue/wq_monitor.py        | 151 +++++++++++++++++++++++++++
 3 files changed, 206 insertions(+), 1 deletion(-)
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
index 4666a1a92a31..33ddfaacdf29 100644
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
 
@@ -2163,6 +2181,7 @@ static void send_mayday(struct work_struct *work)
 		get_pwq(pwq);
 		list_add_tail(&pwq->mayday_node, &wq->maydays);
 		wake_up_process(wq->rescuer->task);
+		pwq->stats[PWQ_STAT_MAYDAY]++;
 	}
 }
 
@@ -2401,6 +2420,7 @@ __acquires(&pool->lock)
 	 * workqueues), so hiding them isn't a problem.
 	 */
 	lockdep_invariant_state(true);
+	pwq->stats[PWQ_STAT_STARTED]++;
 	trace_workqueue_execute_start(work);
 	worker->current_func(work);
 	/*
@@ -2408,6 +2428,7 @@ __acquires(&pool->lock)
 	 * point will only record its address.
 	 */
 	trace_workqueue_execute_end(work, worker->current_func);
+	pwq->stats[PWQ_STAT_COMPLETED]++;
 	lock_map_release(&lockdep_map);
 	lock_map_release(&pwq->wq->lockdep_map);
 
@@ -2651,6 +2672,7 @@ static int rescuer_thread(void *__rescuer)
 				if (first)
 					pool->watchdog_ts = jiffies;
 				move_linked_works(work, scheduled, &n);
+				pwq->stats[PWQ_STAT_RESCUED]++;
 			}
 			first = false;
 		}
diff --git a/tools/workqueue/wq_monitor.py b/tools/workqueue/wq_monitor.py
new file mode 100644
index 000000000000..94435fd14c98
--- /dev/null
+++ b/tools/workqueue/wq_monitor.py
@@ -0,0 +1,151 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2023 Tejun Heo <tj@kernel.org>
+# Copyright (C) 2023 Meta Platforms, Inc. and affiliates.
+
+desc = """
+
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

