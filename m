Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0876FF970
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbjEKSUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbjEKST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:19:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6487A248
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643ac91c51fso5498140b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683829192; x=1686421192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTlE5rh9U2p4prvVBNqK5UgG3zfgJOt1FV4r5trtoPw=;
        b=EycSu/vj0nY37kNn+pr12cmZ7gAg9BJPB6B+hp3zWDwRnSBSuPwcaIC8rmfmFREueW
         3THfvkyhgE0vl2pXGtYqjUnVBP+T8O8jMVlisCw9uZkog0fnbHX/zg2coob3dqP3zV0x
         3QYRnjQsvW6JLOaP7cm5CqsHppg3XU1Y9jUPWi+5YQuGgCX0NSCWjXyWwny4LWFGBLd7
         21qlFjbJs+zU4WTGBvZeAAvzZJ5ACICJNhDoa9g3PkzPY24UYbbjpz7CjNLUzbcgUxa6
         EkRMkeOoU0fgJZLRS/gY7Lt36qOkVvOWmN3qmDMN4SW1GbRkKGgwUCvwvrQC17WdBc9f
         LjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829192; x=1686421192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kTlE5rh9U2p4prvVBNqK5UgG3zfgJOt1FV4r5trtoPw=;
        b=jp+rWaUF277cxxpg47cak+k6fiY0m0HGzQsM/Xr1Pm0uS0gm+RyKq3hJ9b/O6eQluH
         dcN36LCUYuHiqDWk6m2tyj3JjI3joX0ojAzxZ8Ytju0N1ztt3hlKqbk9sNU5NOtxuHyL
         w6ubt4EUAYPoJYrk2mgJlva+u5EnlYXX88GoWUVKUKjb6csZDDIr8NBn8ZHFT7LieZJ2
         oHT/k+E6fdVf+cd+n9nR2dCxA1KzRbwzJuamRiJBGrb3rQ9sln6Mh6vkCYYPlmo5p/EG
         DaP7R3xT+na+P3eeNFNvJI0aZ63PUCoLJ/jtrjnaMUJhSB3Vz3CLsjcSZ5aP/X+Wih16
         EdQw==
X-Gm-Message-State: AC+VfDxUR50gn2gcrEd0Rwim/jNQIfYI97OttT4MmDiBtnNroWG+MRjg
        O3PYjVLFXzcRGIBSrF5aVfA=
X-Google-Smtp-Source: ACHHUZ4WJ6J+YOr37aQmjc/l7mmn4aJIrscBRkrU2Y9p1dNrFdsMqr6igixtQm5WMDm4wb20FkNfvQ==
X-Received: by 2002:a05:6a00:2e0e:b0:63d:24c0:1223 with SMTP id fc14-20020a056a002e0e00b0063d24c01223mr32053103pfb.29.1683829191869;
        Thu, 11 May 2023 11:19:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b20-20020aa78714000000b0062dbafced27sm3682194pfo.27.2023.05.11.11.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:19:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/7] workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism
Date:   Thu, 11 May 2023 08:19:30 -1000
Message-Id: <20230511181931.869812-7-tj@kernel.org>
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

Workqueue now automatically marks per-cpu work items that hog CPU for too
long as CPU_INTENSIVE, which excludes them from concurrency management and
prevents stalling other concurrency-managed work items. If a work function
keeps running over the thershold, it likely needs to be switched to use an
unbound workqueue.

This patch adds a debug mechanism which tracks the work functions which
trigger the automatic CPU_INTENSIVE mechanism and report them using
pr_warn() with exponential backoff.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/workqueue.c | 128 +++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug  |  13 +++++
 2 files changed, 141 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 661acc5afcfd..b85d70f133f7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -948,6 +948,132 @@ static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
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
+	struct list_head	report_node;
+};
+
+static struct wci_ent wci_ents[WCI_MAX_ENTS];
+static int wci_nr_ents;
+static DEFINE_RAW_SPINLOCK(wci_lock);
+static DEFINE_HASHTABLE(wci_hash, ilog2(WCI_MAX_ENTS));
+static LIST_HEAD(wci_report_list);
+static struct kthread_worker *wci_report_worker;
+
+static void wci_report_workfn(struct kthread_work *work)
+{
+	struct wci_ent *ent, *n;
+
+	raw_spin_lock_irq(&wci_lock);
+	list_for_each_entry_safe(ent, n, &wci_report_list, report_node) {
+		pr_warn("workqueue: %ps hogged CPU for >%luus %llu times, consider switching to WQ_UNBOUND\n",
+			ent->func, wq_cpu_intensive_thresh_us,
+			atomic64_read(&ent->cnt));
+		list_del_init(&ent->report_node);
+	}
+	raw_spin_unlock_irq(&wci_lock);
+}
+
+static DEFINE_KTHREAD_WORK(wci_report_work, wci_report_workfn);
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
+		if (cnt < 4 || !is_power_of_2(cnt))
+			return;
+
+		raw_spin_lock(&wci_lock);
+		if (list_empty(&ent->report_node)) {
+			list_add_tail(&ent->report_node, &wci_report_list);
+			if (wci_report_worker)
+				kthread_queue_work(wci_report_worker,
+						   &wci_report_work);
+		}
+		raw_spin_unlock(&wci_lock);
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
+	INIT_LIST_HEAD(&ent->report_node);
+	hash_add_rcu(wci_hash, &ent->hash_node, (unsigned long)func);
+
+	raw_spin_unlock(&wci_lock);
+}
+
+static void __init wq_cpu_intensive_report_init(void)
+{
+	wci_report_worker = kthread_create_worker(0, "wq_cpu_intensive_report");
+	WARN_ON(!wci_report_worker);
+}
+
+#else	/* CONFIG_WQ_CPU_INTENSIVE_REPORT */
+static void wq_cpu_intensive_report(work_func_t func) {}
+static void __init wq_cpu_intensive_report_init(void) {}
+#endif	/* CONFIG_WQ_CPU_INTENSIVE_REPORT */
+
 /**
  * wq_worker_running - a worker is running again
  * @task: task waking up
@@ -1057,6 +1183,7 @@ void wq_worker_tick(struct task_struct *task)
 	raw_spin_lock(&pool->lock);
 
 	worker_set_flags(worker, WORKER_CPU_INTENSIVE);
+	wq_cpu_intensive_report(worker->current_func);
 	pwq->stats[PWQ_STAT_CPU_INTENSIVE]++;
 
 	if (need_more_worker(pool)) {
@@ -6458,6 +6585,7 @@ void __init workqueue_init(void)
 
 	wq_online = true;
 	wq_watchdog_init();
+	wq_cpu_intensive_report_init();
 }
 
 /*
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

