Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EFC708CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjESAS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjESAS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEC919B3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2a889722so596464b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455481; x=1687047481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYx5gYM0HbxwulP742OJ8NlqhmKf0e7AcKBB2W8ZJjI=;
        b=hC6z5lDmk55NJOfz5REWpFaKiBciThnPyQ7hAXP8JZCm+1OENLdpIdJhE0sr4kwc3e
         eOyzVp/N4Ub2t9GMq1dMQzml9YN20/pNPbUqLoJgzxRkR9u/w3RoNiZkJHk7d2vNInOc
         fBjMdv3y1GqGZ43MTb39bWypBGAiR/yHCDzjBheynTjRDViP57NH/m1asJMCxsx4Af80
         dMbD3yDvr0ZIzYNowOpytePkRcORAOoQYnk0TC67XRxfqJfKRar+yvtfyo/91Kdv9GWc
         c82skRkiL7viwYCmaseb33BiGMDaiS6goysvOmHf6I8K19AQKpbjmBDbm7sKr8tpW+WX
         bRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455481; x=1687047481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYx5gYM0HbxwulP742OJ8NlqhmKf0e7AcKBB2W8ZJjI=;
        b=Urq/QcYz3SMbmfZhbXXdLF+PQU3nTxT/Q4ws4cFtXhfDs043U4k+b/5GEkGgu51xOu
         ewSjslhNIWGAYo3ikCpXREL5f06cr5fhgpkDfDGbUcCe8DNJYvcz27lZISTZuDqt3b2O
         oZBk2AjfRbsIZlxPDO9l8Bn1cO77uaJmeqe2kYd4AvmUnP8lanVNU13k6F/eOYXhF6ZC
         Quf+zUEfqepg24GiuFaMWMsaWoS1LIGhD6JU1ftveTaQZVIknYye5FuyRlPBNGxMkd7U
         iZ3NoezbAz0gGljLmFb2FalxdRu2z3LhtmMmdegwaUT+ws+DvOPkfg3PbPbSPaXAH3er
         YsHg==
X-Gm-Message-State: AC+VfDwH0JwW0QXTCj+kKJuMegIVYzc9huDcHZL3Ehb4l1fH9pnABS2e
        ebkqNMrM5pYkiWvKabEba6TU04mBJ9c=
X-Google-Smtp-Source: ACHHUZ5qPxBNSo8DOQV6WVm2WP+BuOtPa2Z2LHbqsPr+/BhInwp6MXuVW68/x9AWK8ueirlJtAAxug==
X-Received: by 2002:a05:6a00:1689:b0:64c:c5f9:1533 with SMTP id k9-20020a056a00168900b0064cc5f91533mr686486pfc.33.1684455480515;
        Thu, 18 May 2023 17:18:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k3-20020aa78203000000b0063f0ef3b421sm1933970pfi.14.2023.05.18.17.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/24] workqueue: Initialize unbound CPU pods later in the boot
Date:   Thu, 18 May 2023 14:16:58 -1000
Message-Id: <20230519001709.2563-14-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
References: <20230519001709.2563-1-tj@kernel.org>
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

During boot, to initialize unbound CPU pods, wq_pod_init() was called from
workqueue_init(). This is early enough for NUMA nodes to be set up but
before SMP is brought up and CPU topology information is populated.

Workqueue is in the process of improving CPU locality for unbound workqueues
and will need access to topology information during pod init. This adds a
new init function workqueue_init_topology() which is called after CPU
topology information is available and replaces wq_pod_init().

As unbound CPU pods are now initialized after workqueues are activated, we
need to revisit the workqueues to apply the pod configuration. Workqueues
which are created before workqueue_init_topology() are set up so that they
always use the default worker pool. After pods are set up in
workqueue_init_topology(), wq_update_pod() is called on all existing
workqueues to update the pool associations accordingly.

Note that wq_update_pod_attrs_buf allocation is moved to
workqueue_init_early(). This isn't necessary right now but enables further
generalization of pod handling in the future.

This patch changes the initialization sequence but the end result should be
the same.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h |  1 +
 init/main.c               |  1 +
 kernel/workqueue.c        | 68 +++++++++++++++++++++++----------------
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 8cc9b86d3256..b8961c8ea5b3 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -709,5 +709,6 @@ int workqueue_offline_cpu(unsigned int cpu);
 
 void __init workqueue_init_early(void);
 void __init workqueue_init(void);
+void __init workqueue_init_topology(void);
 
 #endif
diff --git a/init/main.c b/init/main.c
index af50044deed5..6bd5fffce2e6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1565,6 +1565,7 @@ static noinline void __init kernel_init_freeable(void)
 	smp_init();
 	sched_init_smp();
 
+	workqueue_init_topology();
 	padata_init();
 	page_alloc_init_late();
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 914a69f83d59..add6f5fc799b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6222,17 +6222,15 @@ static inline void wq_watchdog_init(void) { }
 
 #endif	/* CONFIG_WQ_WATCHDOG */
 
-static void wq_pod_init(void);
-
 /**
  * workqueue_init_early - early init for workqueue subsystem
  *
- * This is the first half of two-staged workqueue subsystem initialization
- * and invoked as soon as the bare basics - memory allocation, cpumasks and
- * idr are up.  It sets up all the data structures and system workqueues
- * and allows early boot code to create workqueues and queue/cancel work
- * items.  Actual work item execution starts only after kthreads can be
- * created and scheduled right before early initcalls.
+ * This is the first step of three-staged workqueue subsystem initialization and
+ * invoked as soon as the bare basics - memory allocation, cpumasks and idr are
+ * up. It sets up all the data structures and system workqueues and allows early
+ * boot code to create workqueues and queue/cancel work items. Actual work item
+ * execution starts only after kthreads can be created and scheduled right
+ * before early initcalls.
  */
 void __init workqueue_init_early(void)
 {
@@ -6247,6 +6245,9 @@ void __init workqueue_init_early(void)
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
+	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
+	BUG_ON(!wq_update_pod_attrs_buf);
+
 	/* initialize CPU pools */
 	for_each_possible_cpu(cpu) {
 		struct worker_pool *pool;
@@ -6305,11 +6306,11 @@ void __init workqueue_init_early(void)
 /**
  * workqueue_init - bring workqueue subsystem fully online
  *
- * This is the latter half of two-staged workqueue subsystem initialization
- * and invoked as soon as kthreads can be created and scheduled.
- * Workqueues have been created and work items queued on them, but there
- * are no kworkers executing the work items yet.  Populate the worker pools
- * with the initial workers and enable future kworker creations.
+ * This is the second step of three-staged workqueue subsystem initialization
+ * and invoked as soon as kthreads can be created and scheduled. Workqueues have
+ * been created and work items queued on them, but there are no kworkers
+ * executing the work items yet. Populate the worker pools with the initial
+ * workers and enable future kworker creations.
  */
 void __init workqueue_init(void)
 {
@@ -6320,18 +6321,12 @@ void __init workqueue_init(void)
 	pwq_release_worker = kthread_create_worker(0, "pool_workqueue_release");
 	BUG_ON(IS_ERR(pwq_release_worker));
 
-	/*
-	 * It'd be simpler to initialize pods in workqueue_init_early() but CPU
-	 * to node mapping may not be available that early on some archs such as
-	 * power and arm64. As per-cpu pools created previously could be missing
-	 * node hint and unbound pool pod affinity, fix them up.
-	 *
-	 * Also, while iterating workqueues, create rescuers if requested.
-	 */
-	wq_pod_init();
-
 	mutex_lock(&wq_pool_mutex);
 
+	/*
+	 * Per-cpu pools created earlier could be missing node hint. Fix them
+	 * up. Also, create a rescuer for workqueues that requested it.
+	 */
 	for_each_possible_cpu(cpu) {
 		for_each_cpu_worker_pool(pool, cpu) {
 			pool->node = cpu_to_node(cpu);
@@ -6339,7 +6334,6 @@ void __init workqueue_init(void)
 	}
 
 	list_for_each_entry(wq, &workqueues, list) {
-		wq_update_pod(wq, smp_processor_id(), true);
 		WARN(init_rescuer(wq),
 		     "workqueue: failed to create early rescuer for %s",
 		     wq->name);
@@ -6362,8 +6356,16 @@ void __init workqueue_init(void)
 	wq_watchdog_init();
 }
 
-static void __init wq_pod_init(void)
+/**
+ * workqueue_init_topology - initialize CPU pods for unbound workqueues
+ *
+ * This is the third step of there-staged workqueue subsystem initialization and
+ * invoked after SMP and topology information are fully initialized. It
+ * initializes the unbound CPU pods accordingly.
+ */
+void __init workqueue_init_topology(void)
 {
+	struct workqueue_struct *wq;
 	cpumask_var_t *tbl;
 	int node, cpu;
 
@@ -6377,8 +6379,7 @@ static void __init wq_pod_init(void)
 		}
 	}
 
-	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
-	BUG_ON(!wq_update_pod_attrs_buf);
+	mutex_lock(&wq_pool_mutex);
 
 	/*
 	 * We want masks of possible CPUs of each node which isn't readily
@@ -6399,6 +6400,19 @@ static void __init wq_pod_init(void)
 
 	wq_pod_cpus = tbl;
 	wq_pod_enabled = true;
+
+	/*
+	 * Workqueues allocated earlier would have all CPUs sharing the default
+	 * worker pool. Explicitly call wq_update_pod() on all workqueue and CPU
+	 * combinations to apply per-pod sharing.
+	 */
+	list_for_each_entry(wq, &workqueues, list) {
+		for_each_online_cpu(cpu) {
+			wq_update_pod(wq, cpu, true);
+		}
+	}
+
+	mutex_unlock(&wq_pool_mutex);
 }
 
 /*
-- 
2.40.1

