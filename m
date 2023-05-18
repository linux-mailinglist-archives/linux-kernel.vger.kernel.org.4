Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6880570784B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjERDBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjERDBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:01:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D71199A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:01:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64ab2a37812so13645602b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684378860; x=1686970860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuuKBNrzsKzOsdArC2h9Wd9NRa9otXooTrbKl9vYQZg=;
        b=hyVWZFX7Iwsc2do9pp4W91d+XLrhy9OrzKJL+sjijLDmoSaGgDe0XHz6rdeliV2P4i
         4B8thGj4Epms7QBbmb+QpomipuO3+dHJ40WEV4w9i0rOmQv9HqaTbMTjyg/e17W/vMBc
         8RbXl0mV3KDeX7VwxPauzLL80z+OCOIBQxgeb2vSfcQqIoUNgzooTWAqpFlnXfKPWHo4
         yPPgzvvW7Pgu3O6T5pPkUPPDdgLFXM+nbXCf+Yrhqk5k6eRUaUDCgFcwxvfqhVzE/ukV
         fZ4ThixvB1YXxSB3Axl3NRXEg7Excv/m5VYkGLm6NNpOWwsaCqCO9QCPZhap4JBfACvm
         XXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684378860; x=1686970860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RuuKBNrzsKzOsdArC2h9Wd9NRa9otXooTrbKl9vYQZg=;
        b=EZMVrPuQ1BHBEpxDjj5SJ99y7xT7k6II9VNzcbx3LgZU3b1EHrb2Cxx/5N15bRn8Fg
         f5MQnW5m4Rn2rXhP+MhJtA+xoyOAP7CAY2xyQGFcjqj4FTlyiKTtz4mOOcrOj7L0wlKp
         KWgaytB2mvS8WtPQN1ti3h3tMZgjLPoQp2Qg8ADF/3qAy1q93cWK//xfpncDQ5P7KQg3
         BhQGFBJn00cdkDHAJShK0ZvbXppG2Jb8MEd5jotMHnlM7lpfH1gTwgdQoYW/Q4I3zpCp
         wAGGn9Qtxda1YLznIGK3IIzN3E6H9rSnBw4LU+mohPJJM6ERuZxDSAIu4IAjSqdKwrku
         7KjQ==
X-Gm-Message-State: AC+VfDzi5FH9gCJcY8fBdSoZ7syYUUvM5VtpyAbImaj82W5pR9wF8meR
        jSSTvabStc2EvQxj0QLRIUE=
X-Google-Smtp-Source: ACHHUZ4vqS1J4WDm2nHP3CjFunQ9ff4v7IWHHOB2P/b0MJISJnjPVJeoBn7WyqB+OMp+tG4TWY+dWw==
X-Received: by 2002:a05:6a20:440d:b0:104:28d6:5db3 with SMTP id ce13-20020a056a20440d00b0010428d65db3mr453679pzb.29.1684378860340;
        Wed, 17 May 2023 20:01:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1c2f])
        by smtp.gmail.com with ESMTPSA id f2-20020a655502000000b0051baf3f1b3esm135649pgr.76.2023.05.17.20.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:01:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/7] workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism
Date:   Wed, 17 May 2023 17:00:32 -1000
Message-Id: <20230518030033.4163274-7-tj@kernel.org>
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

Workqueue now automatically marks per-cpu work items that hog CPU for too
long as CPU_INTENSIVE, which excludes them from concurrency management and
prevents stalling other concurrency-managed work items. If a work function
keeps running over the thershold, it likely needs to be switched to use an
unbound workqueue.

This patch adds a debug mechanism which tracks the work functions which
trigger the automatic CPU_INTENSIVE mechanism and report them using
pr_warn() with exponential backoff.

v3: Documentation update.

v2: Drop bouncing to kthread_worker for printing messages. It was to avoid
    introducing circular locking dependency through printk but not effective
    as it still had pool lock -> wci_lock -> printk -> pool lock loop. Let's
    just print directly using printk_deferred().

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 .../admin-guide/kernel-parameters.txt         |  5 +
 kernel/workqueue.c                            | 93 +++++++++++++++++++
 lib/Kconfig.debug                             | 13 +++
 3 files changed, 111 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1f2185cf2f0a..3ed7dda4c994 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6938,6 +6938,11 @@
 			them from noticeably delaying other per-cpu work
 			items. Default is 10000 (10ms).
 
+			If CONFIG_WQ_CPU_INTENSIVE_REPORT is set, the kernel
+			will report the work functions which violate this
+			threshold repeatedly. They are likely good
+			candidates for using WQ_UNBOUND workqueues instead.
+
 	workqueue.disable_numa
 			By default, all work items queued to unbound
 			workqueues are affine to the NUMA nodes they're
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3dc83d5eba50..4ca66384d288 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -948,6 +948,98 @@ static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
 			pool->nr_running++;
 }
 
+#ifdef CONFIG_WQ_CPU_INTENSIVE_REPORT
+
+/*
+ * Concurrency-managed per-cpu work items that hog CPU for longer than
+ * wq_cpu_intensive_thresh_us trigger the automatic CPU_INTENSIVE mechanism,
+ * which prevents them from stalling other concurrency-managed work items. If a
+ * work function keeps triggering this mechanism, it's likely that the work item
+ * should be using an unbound workqueue instead.
+ *
+ * wq_cpu_intensive_report() tracks work functions which trigger such conditions
+ * and report them so that they can be examined and converted to use unbound
+ * workqueues as appropriate. To avoid flooding the console, each violating work
+ * function is tracked and reported with exponential backoff.
+ */
+#define WCI_MAX_ENTS 128
+
+struct wci_ent {
+	work_func_t		func;
+	atomic64_t		cnt;
+	struct hlist_node	hash_node;
+};
+
+static struct wci_ent wci_ents[WCI_MAX_ENTS];
+static int wci_nr_ents;
+static DEFINE_RAW_SPINLOCK(wci_lock);
+static DEFINE_HASHTABLE(wci_hash, ilog2(WCI_MAX_ENTS));
+
+static struct wci_ent *wci_find_ent(work_func_t func)
+{
+	struct wci_ent *ent;
+
+	hash_for_each_possible_rcu(wci_hash, ent, hash_node,
+				   (unsigned long)func) {
+		if (ent->func == func)
+			return ent;
+	}
+	return NULL;
+}
+
+static void wq_cpu_intensive_report(work_func_t func)
+{
+	struct wci_ent *ent;
+
+restart:
+	ent = wci_find_ent(func);
+	if (ent) {
+		u64 cnt;
+
+		/*
+		 * Start reporting from the fourth time and back off
+		 * exponentially.
+		 */
+		cnt = atomic64_inc_return_relaxed(&ent->cnt);
+		if (cnt >= 4 && is_power_of_2(cnt))
+			printk_deferred(KERN_WARNING "workqueue: %ps hogged CPU for >%luus %llu times, consider switching to WQ_UNBOUND\n",
+					ent->func, wq_cpu_intensive_thresh_us,
+					atomic64_read(&ent->cnt));
+		return;
+	}
+
+	/*
+	 * @func is a new violation. Allocate a new entry for it. If wcn_ents[]
+	 * is exhausted, something went really wrong and we probably made enough
+	 * noise already.
+	 */
+	if (wci_nr_ents >= WCI_MAX_ENTS)
+		return;
+
+	raw_spin_lock(&wci_lock);
+
+	if (wci_nr_ents >= WCI_MAX_ENTS) {
+		raw_spin_unlock(&wci_lock);
+		return;
+	}
+
+	if (wci_find_ent(func)) {
+		raw_spin_unlock(&wci_lock);
+		goto restart;
+	}
+
+	ent = &wci_ents[wci_nr_ents++];
+	ent->func = func;
+	atomic64_set(&ent->cnt, 1);
+	hash_add_rcu(wci_hash, &ent->hash_node, (unsigned long)func);
+
+	raw_spin_unlock(&wci_lock);
+}
+
+#else	/* CONFIG_WQ_CPU_INTENSIVE_REPORT */
+static void wq_cpu_intensive_report(work_func_t func) {}
+#endif	/* CONFIG_WQ_CPU_INTENSIVE_REPORT */
+
 /**
  * wq_worker_running - a worker is running again
  * @task: task waking up
@@ -1057,6 +1149,7 @@ void wq_worker_tick(struct task_struct *task)
 	raw_spin_lock(&pool->lock);
 
 	worker_set_flags(worker, WORKER_CPU_INTENSIVE);
+	wq_cpu_intensive_report(worker->current_func);
 	pwq->stats[PWQ_STAT_CPU_INTENSIVE]++;
 
 	if (need_more_worker(pool)) {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce51d4dc6803..97e880aa48d7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1134,6 +1134,19 @@ config WQ_WATCHDOG
 	  state.  This can be configured through kernel parameter
 	  "workqueue.watchdog_thresh" and its sysfs counterpart.
 
+config WQ_CPU_INTENSIVE_REPORT
+	bool "Report per-cpu work items which hog CPU for too long"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to enable reporting of concurrency-managed per-cpu work
+	  items that hog CPUs for longer than
+	  workqueue.cpu_intensive_threshold_us. Workqueue automatically
+	  detects and excludes them from concurrency management to prevent
+	  them from stalling other per-cpu work items. Occassional
+	  triggering may not necessarily indicate a problem. Repeated
+	  triggering likely indicates that the work item should be switched
+	  to use an unbound workqueue.
+
 config TEST_LOCKUP
 	tristate "Test module to generate lockups"
 	depends on m
-- 
2.40.1

