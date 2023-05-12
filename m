Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B67A700F68
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbjELTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbjELTmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:42:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BEA6EBF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:42:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so72160075ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683920564; x=1686512564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+O245Wv8RVTPjiOvohK4Fe7rvfoJ7bvB8+/tCKzuCb8=;
        b=U8agXBDOWhZnlTwe68IFYK38YfmMgxS65YnYs3VHshzOVHu5F++w93j/Ha3QvdRiR0
         9NRcjWnESGGNz+5a3yhmsesonO/crUMwUz1XWpdpnk8IuWd0Oz1EqUka4n+7lf3QWeN5
         EruRSDRF3GmUcF7q8p8tizLCOIbSQZdgAMstMDokd+rKiwoifvI/PY4PCbdgY6JMSHNt
         eLiYhuCR9WTTD7S/Tx6M643J6U+25/oiaTTk9gR92v1/Md3SzIKRBn8G0GiT5HfLOrta
         SVgojjlj3MaSmwY4e8hQx/P66+wjWBlGpPD0niwlovWfvzmN0PyOeB3NpyEG3rVQEu8B
         qjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920564; x=1686512564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O245Wv8RVTPjiOvohK4Fe7rvfoJ7bvB8+/tCKzuCb8=;
        b=CRSnFREuK7JqGSr1EtOKf8bNudvCE1bLdxifDL2t66F8MWpCAFdUPCXlg17CaxqrnJ
         JoXNuhhJCP7BCRl/5WQCDEWqDY1drqiLhOFTXNZpq2fkOdBKL+FoiBUHs5ODml6cw0uS
         KbOK95rO13icO8ypGtVIu4J0uHFxb7G1bk3srSxLheZe8a0aXfKZ+dXzlATGnCHib9ag
         CX4CbAxhEFjXKgMMVUOz/KdUdF5gA5MWMZcMzx+x+EhxvztrsgEQ7f0DFyUTfxCc8/wo
         ieuIl/BYOvURfMb942Pq9mjg/BacFw++18COnfLgcRsBaV5BiznphAkuE4hE4ZvENZXq
         Kyyw==
X-Gm-Message-State: AC+VfDy3cJ97bMoPoERnbZbTOjrJGeVYgdVn1BTmS8XJsPvRqGrbVtif
        XKgV9G6SwbeDVxKLF4leKdM=
X-Google-Smtp-Source: ACHHUZ6mfY9rmnxnSDVWNYMos90bVWiPBIAtoULMleIvqcbOX7D5v6vktXH8GcYsecgvbF+eio/8RA==
X-Received: by 2002:a17:903:22cd:b0:1aa:ee36:4095 with SMTP id y13-20020a17090322cd00b001aaee364095mr32663350plg.43.1683920563583;
        Fri, 12 May 2023 12:42:43 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e85100b0019309be03e7sm8296233plg.66.2023.05.12.12.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:42:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 12 May 2023 09:42:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 6/7] workqueue: Report work funcs that trigger automatic
 CPU_INTENSIVE mechanism
Message-ID: <ZF6WsSVGX3O1d0pL@slm.duckdns.org>
References: <20230511181931.869812-1-tj@kernel.org>
 <20230511181931.869812-7-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511181931.869812-7-tj@kernel.org>
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

v2: Drop bouncing through kthread_worker for printing messages. It was to
    avoid introducing circular locking dependency but wasn't effective as it
    still had pool lock -> wci_lock -> printk -> pool lock loop. Let's just
    print directly using printk_deferred().

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/workqueue.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug  |   13 +++++++
 2 files changed, 106 insertions(+)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -948,6 +948,98 @@ static inline void worker_clr_flags(stru
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
@@ -1057,6 +1149,7 @@ void wq_worker_tick(struct task_struct *
 	raw_spin_lock(&pool->lock);
 
 	worker_set_flags(worker, WORKER_CPU_INTENSIVE);
+	wq_cpu_intensive_report(worker->current_func);
 	pwq->stats[PWQ_STAT_CPU_INTENSIVE]++;
 
 	if (need_more_worker(pool)) {
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
