Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B696FD407
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjEJDIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjEJDIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:08:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085F84EC0
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:08:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6434e65d808so7070060b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683688100; x=1686280100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZD6tB6qrKbZp0glru+u2xn36IkADfJxXjSZrZl7HCM=;
        b=OlCoyzP8+UABQu+pTn2nMyr1GrNWqfogYroPLnmh14UxnerX2y9Fv3gkQ91T7Bq/Rl
         gmG58L6ojQQnJsOz6sMx1U3xR2GFJRZU82YaDe74A430uTpEPR2EAJ6Obo1OIoTzxY7a
         aRaGQ101Cs5QdrezPd0QfN3m8VAwniMfZWRU8FQnSxye+O7812JgbDQSCdO4swcgLKP8
         El8CGrz8totLXJFycdDRvsgVcSTln2WBOs3ZTOlnfcTiIPXSxf9PkL+roUi1sCxonId0
         lUnCed/0QhiZVoNPbtYtRdI6AM6jdRIhoU/MvRFgbuNEgOU6vF9h6uiA2S+2mzUo8W4u
         zLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683688100; x=1686280100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZD6tB6qrKbZp0glru+u2xn36IkADfJxXjSZrZl7HCM=;
        b=RFkgiq0s0SmD/NqnoN0BsbF13Tz/2L2unsiZgGN1HLg6yWoiqW5E4eSWXsjH9IGNTG
         2h04DFz50cx+RlIuKo7BExEIU8WuvLQXCF92e/tXJ1bY3i9YUooZZE7LDezYJUYHtnih
         nimn08m6/c+4NRYeUv84M9/jfp2apeBWO6NIKo3uOSYTlYfE/UKr8BtjB/lYLBcPliYS
         yHg9culpb3GQqmg4QkdY+jPcM4ymt9jGdm/JvNBEt3ugO3ponsrdIAe0etB6KUVAzqSD
         hDB4pB8A9itLWdDAAIq5MSPCqMyWq+nDUDl9+VVZUHKdGxHxM/f/z2RfHcZmgVw9ZG6V
         gNtg==
X-Gm-Message-State: AC+VfDzulFLJi03ZDZz9V/bph5n8YBoTgmD4nAQMVDSVONvl3cXtlpkH
        DWbKd0ANvEXVDrZisl8IVCQNg4BrMH4=
X-Google-Smtp-Source: ACHHUZ53rb1nhWvdvyVMvQqeng+0vrDsi5iKZUees5ghhtex3hXWjaLt1KWs0Nss2iCJQuyQlReR3w==
X-Received: by 2002:a05:6a20:8f07:b0:ef:70b:42fc with SMTP id b7-20020a056a208f0700b000ef070b42fcmr20451995pzk.38.1683688099978;
        Tue, 09 May 2023 20:08:19 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u19-20020aa78393000000b006242f4a8945sm2465228pfm.182.2023.05.09.20.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:08:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism
Date:   Tue,  9 May 2023 17:07:51 -1000
Message-Id: <20230510030752.542340-6-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510030752.542340-1-tj@kernel.org>
References: <20230510030752.542340-1-tj@kernel.org>
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
index b63bbd22f756..fa535d820093 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -954,6 +954,132 @@ void wq_worker_running(struct task_struct *task)
 	worker->sleeping = 0;
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
  * wq_worker_stopping - a worker is stopping
  * @task: task stopping
@@ -1001,6 +1127,7 @@ void notrace wq_worker_stopping(struct task_struct *task, bool voluntary)
 		 */
 		raw_spin_lock_irq(&pool->lock);
 		worker_set_flags(worker, WORKER_CPU_INTENSIVE);
+		wq_cpu_intensive_report(worker->current_func);
 	} else {
 		/*
 		 * Concurrency-managed @worker is sleeping. Decrement the
@@ -6421,6 +6548,7 @@ void __init workqueue_init(void)
 
 	wq_online = true;
 	wq_watchdog_init();
+	wq_cpu_intensive_report_init();
 }
 
 /*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce51d4dc6803..2f3619662840 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1134,6 +1134,19 @@ config WQ_WATCHDOG
 	  state.  This can be configured through kernel parameter
 	  "workqueue.watchdog_thresh" and its sysfs counterpart.
 
+config WQ_CPU_INTENSIVE_REPORT
+	bool "Report per-cpu work items which are CPU intensive"
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

