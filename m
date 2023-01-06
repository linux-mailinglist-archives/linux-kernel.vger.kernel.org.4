Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834FC65F9C1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjAFC6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjAFC5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:57:48 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E84C34D6E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:57:47 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id om16-20020a17090b3a9000b002216006cbffso2234690pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 18:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+2uVQp4GeViZVidtzozH943JaNl2USF3QmdcfCDGznk=;
        b=Suzkt9XP/IQeHCvQXJZZF/v6jBGRXq6PdvaopLgta+thHpXYtnlNbWnjHVjlogR2C8
         qK2stLY84SkDLyeNQbsSEu7Mp200Q1NP+Fig5ClRjFVCh74+gWSX8LUjfWTrzfyWve0Z
         mTC+eMKk9I9wH1dua7EyCyUnVw+KkpdaGuMKFG9CJxGfsG6Uqr7n5UZ3r3yau5fLul+b
         fXy2PL1mmdxNJSY0lpOFm8egXwuE5GFn4MXaWW3CQD9kpTMsnmyVqvk15/WWz05RB9Yh
         a4VW1PpoWkfdShgO8npLgXOJsqcty98XL7FXL33N1G7wcKdzNO3NEH6xmqSUOpq2xsJy
         HOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2uVQp4GeViZVidtzozH943JaNl2USF3QmdcfCDGznk=;
        b=r8Bc3Hy15lH7nP9ZNIHs2JOqw6HkXQu5T2/0+QpL0sZNT/GBAWZqTPw2jjjylflf1G
         Mj/Ug10eLLsh5NGu7/9eEX5BzjUEFndo3QbxTS+WleDacL5cjo3WguwqW6LYwQWry33A
         QvuW5hdDNq6mF/YXNT0gAWZvZeoogGFxAZnPxS7GMPWfHlQaK5bwsd3dNZ50sPot/SI1
         MD7FAmIlYS+KjqLjdy2fP07no9u75Os511LZXHytfHAU+rFsrm9gYOTVlxRr0lTaOJWn
         TxVY3z3xqa7ZzTEAqV/qbdmBK/OTMAGMrRsFAVb0KmL/k7o0YWcJ4vM0+B5AYfzL1c91
         rvxw==
X-Gm-Message-State: AFqh2kpzW6YRlyOeVHdI/1PiofxKX3sgxA+gPwMQzJzZ1es31V0tiYVx
        GTvnecJsMh8hKYeiZanHQTpiMAkqvqG5
X-Google-Smtp-Source: AMrXdXtbVtFLqDOvBcyJ10nyDdXDpuWnkckQvT/RJMoBvD+hCVRfaTDNhtSf0eb7tD7/OMe4uXpsgf9RW5NC
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a63:40c6:0:b0:4a2:81eb:e65e with SMTP id
 n189-20020a6340c6000000b004a281ebe65emr1108148pga.615.1672973866853; Thu, 05
 Jan 2023 18:57:46 -0800 (PST)
Date:   Fri,  6 Jan 2023 02:57:18 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106025719.3870252-1-dhavale@google.com>
Subject: [PATCH v2] erofs: replace erofs_unzipd workqueue with per-cpu threads
From:   Sandeep Dhavale <dhavale@google.com>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     Sandeep Dhavale <dhavale@google.com>, kernel-team@android.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using per-cpu thread pool we can reduce the scheduling latency compared
to workqueue implementation. With this patch scheduling latency and
variation is reduced as per-cpu threads are high priority kthread_workers.

The results were evaluated on arm64 Android devices running 5.10 kernel.

The table below shows resulting improvements of total scheduling latency
for the same app launch benchmark runs with 50 iterations. Scheduling
latency is the latency between when the task (workqueue kworker vs
kthread_worker) became eligible to run to when it actually started
running.
+-------------------------+-----------+----------------+---------+
|                         | workqueue | kthread_worker |  diff   |
+-------------------------+-----------+----------------+---------+
| Average (us)            |     15253 |           2914 | -80.89% |
| Median (us)             |     14001 |           2912 | -79.20% |
| Minimum (us)            |      3117 |           1027 | -67.05% |
| Maximum (us)            |     30170 |           3805 | -87.39% |
| Standard deviation (us) |      7166 |            359 |         |
+-------------------------+-----------+----------------+---------+

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
V1 -> V2
* Changed name of kthread_workers from z_erofs to erofs_worker
* Added kernel configuration to run kthread_workers at normal or
  high priority
* Added cpu hotplug support
* Added wrapped kthread_workers under worker_pool
* Added one unbound thread in a pool to handle a context where
  we already stopped per-cpu kthread worker
* Updated commit message

Background: Boot times and cold app launch benchmarks are very
important to android ecosystem as they directly translate to
responsiveness from user point of view. While erofs provides
lot of important features like space savings, we saw some
performance penalty in cold app launch benchmarks in few scenarios.
Analysis showed that the significant variance was coming from the
scheduling cost while decompression cost was more or less the same.

Having per-cpu thread pool we can see from above table that this
variation is reduced by ~80% on average. Link to LPC 2022 slides and
talk at [1]

[1] https://lpc.events/event/16/contributions/1338/
---
 fs/erofs/Kconfig |  11 +++
 fs/erofs/zdata.c | 201 +++++++++++++++++++++++++++++++++++++++++------
 fs/erofs/zdata.h |   4 +-
 3 files changed, 192 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 85490370e0ca..879f493c6641 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -108,3 +108,14 @@ config EROFS_FS_ONDEMAND
 	  read support.
 
 	  If unsure, say N.
+
+config EROFS_FS_KTHREAD_HIPRI
+	bool "EROFS high priority percpu kthread workers"
+	depends on EROFS_FS
+	default n
+	help
+	  EROFS uses per cpu kthread workers pool to carry out async work.
+	  This permits EROFS to configure per cpu kthread workers to run
+	  at higher priority.
+
+	  If unsure, say N.
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ccf7c55d477f..5df2e1eb7f54 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -8,6 +8,8 @@
 #include "compress.h"
 #include <linux/prefetch.h>
 #include <linux/psi.h>
+#include <linux/slab.h>
+#include <linux/cpuhotplug.h>
 
 #include <trace/events/erofs.h>
 
@@ -184,26 +186,152 @@ typedef tagptr1_t compressed_page_t;
 #define tag_compressed_page_justfound(page) \
 	tagptr_fold(compressed_page_t, page, 1)
 
-static struct workqueue_struct *z_erofs_workqueue __read_mostly;
+struct erofs_kthread_worker_pool {
+	struct kthread_worker __rcu **workers;
+	struct kthread_worker *unbound_worker;
+};
 
-void z_erofs_exit_zip_subsystem(void)
+static struct erofs_kthread_worker_pool worker_pool;
+DEFINE_SPINLOCK(worker_pool_lock);
+
+void erofs_destroy_worker_pool(void)
 {
-	destroy_workqueue(z_erofs_workqueue);
-	z_erofs_destroy_pcluster_pool();
+	unsigned int cpu;
+	struct kthread_worker *worker;
+
+	for_each_possible_cpu(cpu) {
+		worker = rcu_dereference_protected(
+				worker_pool.workers[cpu],
+				1);
+		rcu_assign_pointer(worker_pool.workers[cpu], NULL);
+
+		if (worker)
+			kthread_destroy_worker(worker);
+	}
+
+	if (worker_pool.unbound_worker)
+		kthread_destroy_worker(worker_pool.unbound_worker);
+
+	kfree(worker_pool.workers);
 }
 
-static inline int z_erofs_init_workqueue(void)
+static inline void erofs_set_worker_priority(struct kthread_worker *worker)
 {
-	const unsigned int onlinecpus = num_possible_cpus();
+#ifdef CONFIG_EROFS_FS_KTHREAD_HIPRI
+	sched_set_fifo_low(worker->task);
+#else
+	sched_set_normal(worker->task, 0);
+#endif
+}
 
-	/*
-	 * no need to spawn too many threads, limiting threads could minimum
-	 * scheduling overhead, perhaps per-CPU threads should be better?
-	 */
-	z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
-					    WQ_UNBOUND | WQ_HIGHPRI,
-					    onlinecpus + onlinecpus / 4);
-	return z_erofs_workqueue ? 0 : -ENOMEM;
+static int erofs_create_kthread_workers(void)
+{
+	unsigned int cpu;
+	struct kthread_worker *worker;
+
+	for_each_online_cpu(cpu) {
+		worker = kthread_create_worker_on_cpu(cpu, 0, "erofs_worker/%u", cpu);
+		if (IS_ERR(worker)) {
+			erofs_destroy_worker_pool();
+			return -ENOMEM;
+		}
+		erofs_set_worker_priority(worker);
+		rcu_assign_pointer(worker_pool.workers[cpu], worker);
+	}
+
+	worker = kthread_create_worker(0, "erofs_unbound_worker");
+	if (IS_ERR(worker)) {
+		erofs_destroy_worker_pool();
+		return PTR_ERR(worker);
+	}
+	erofs_set_worker_priority(worker);
+	worker_pool.unbound_worker = worker;
+
+	return 0;
+}
+
+static int erofs_init_worker_pool(void)
+{
+	int err;
+
+	worker_pool.workers = kcalloc(num_possible_cpus(),
+			sizeof(struct kthread_worker *), GFP_ATOMIC);
+	if (!worker_pool.workers)
+		return -ENOMEM;
+	err = erofs_create_kthread_workers();
+
+	return err;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static enum cpuhp_state erofs_cpuhp_state;
+static int erofs_cpu_online(unsigned int cpu)
+{
+	struct kthread_worker *worker;
+
+	worker = kthread_create_worker_on_cpu(cpu, 0, "erofs_worker/%u", cpu);
+	if (IS_ERR(worker))
+		return -ENOMEM;
+
+	erofs_set_worker_priority(worker);
+
+	spin_lock(&worker_pool_lock);
+	rcu_assign_pointer(worker_pool.workers[cpu], worker);
+	spin_unlock(&worker_pool_lock);
+
+	synchronize_rcu();
+
+	return 0;
+}
+
+static int erofs_cpu_offline(unsigned int cpu)
+{
+	struct kthread_worker *worker;
+
+	spin_lock(&worker_pool_lock);
+	worker = rcu_dereference_protected(worker_pool.workers[cpu],
+			lockdep_is_held(&worker_pool_lock));
+	rcu_assign_pointer(worker_pool.workers[cpu], NULL);
+	spin_unlock(&worker_pool_lock);
+
+	synchronize_rcu();
+
+	if (worker)
+		kthread_destroy_worker(worker);
+
+	return 0;
+}
+
+static int erofs_cpu_hotplug_init(void)
+{
+	int state;
+
+	state = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+			"fs/erofs:online",
+			erofs_cpu_online, erofs_cpu_offline);
+	if (state < 0)
+		return state;
+
+	erofs_cpuhp_state = state;
+
+	return 0;
+}
+
+static void erofs_cpu_hotplug_destroy(void)
+{
+	if (erofs_cpuhp_state)
+		cpuhp_remove_state_nocalls(erofs_cpuhp_state);
+}
+#else /* !CONFIG_HOTPLUG_CPU */
+static inline int erofs_cpu_hotplug_init(void) { return 0; }
+static inline void erofs_cpu_hotplug_destroy(void) {}
+#endif
+
+void z_erofs_exit_zip_subsystem(void)
+{
+	erofs_cpu_hotplug_destroy();
+	erofs_destroy_worker_pool();
+	z_erofs_destroy_pcluster_pool();
 }
 
 int __init z_erofs_init_zip_subsystem(void)
@@ -211,10 +339,23 @@ int __init z_erofs_init_zip_subsystem(void)
 	int err = z_erofs_create_pcluster_pool();
 
 	if (err)
-		return err;
-	err = z_erofs_init_workqueue();
+		goto out_error_pcluster_pool;
+
+	err = erofs_init_worker_pool();
 	if (err)
-		z_erofs_destroy_pcluster_pool();
+		goto out_error_worker_pool;
+
+	err = erofs_cpu_hotplug_init();
+	if (err < 0)
+		goto out_error_cpuhp_init;
+
+	return err;
+
+out_error_cpuhp_init:
+	erofs_destroy_worker_pool();
+out_error_worker_pool:
+	z_erofs_destroy_pcluster_pool();
+out_error_pcluster_pool:
 	return err;
 }
 
@@ -1143,7 +1284,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 	}
 }
 
-static void z_erofs_decompressqueue_work(struct work_struct *work)
+static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
 {
 	struct z_erofs_decompressqueue *bgq =
 		container_of(work, struct z_erofs_decompressqueue, u.work);
@@ -1156,6 +1297,20 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
 	kvfree(bgq);
 }
 
+static void erofs_schedule_kthread_work(struct kthread_work *work)
+{
+	struct kthread_worker *worker;
+	unsigned int cpu = raw_smp_processor_id();
+
+	rcu_read_lock();
+	worker = rcu_dereference(worker_pool.workers[cpu]);
+	if (!worker)
+		worker = worker_pool.unbound_worker;
+
+	kthread_queue_work(worker, work);
+	rcu_read_unlock();
+}
+
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
 {
@@ -1170,15 +1325,15 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	/* Use workqueue and sync decompression for atomic contexts only */
+	/* Use kthread_workers and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
-		queue_work(z_erofs_workqueue, &io->u.work);
+		erofs_schedule_kthread_work(&io->u.work);
 		/* enable sync decompression for readahead */
 		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
 			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
 		return;
 	}
-	z_erofs_decompressqueue_work(&io->u.work);
+	z_erofs_decompressqueue_kthread_work(&io->u.work);
 }
 
 static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
@@ -1306,7 +1461,7 @@ jobqueue_init(struct super_block *sb,
 			*fg = true;
 			goto fg_out;
 		}
-		INIT_WORK(&q->u.work, z_erofs_decompressqueue_work);
+		kthread_init_work(&q->u.work, z_erofs_decompressqueue_kthread_work);
 	} else {
 fg_out:
 		q = fgq;
@@ -1500,7 +1655,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 
 	/*
 	 * although background is preferred, no one is pending for submission.
-	 * don't issue workqueue for decompression but drop it directly instead.
+	 * don't issue kthread_work for decompression but drop it directly instead.
 	 */
 	if (!*force_fg && !nr_bios) {
 		kvfree(q[JQ_SUBMIT]);
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index d98c95212985..808bbbf71b7b 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -6,6 +6,8 @@
 #ifndef __EROFS_FS_ZDATA_H
 #define __EROFS_FS_ZDATA_H
 
+#include <linux/kthread.h>
+
 #include "internal.h"
 #include "tagptr.h"
 
@@ -107,7 +109,7 @@ struct z_erofs_decompressqueue {
 
 	union {
 		struct completion done;
-		struct work_struct work;
+		struct kthread_work work;
 	} u;
 
 	bool eio;
-- 
2.39.0.314.g84b9a713c41-goog

