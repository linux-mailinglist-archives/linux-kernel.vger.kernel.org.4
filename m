Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE98F653A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 02:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiLVBPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 20:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVBPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 20:15:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F6D13D60
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:15:36 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 24-20020aa79118000000b00580476432deso179076pfh.23
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7s8WxSVe5kYllMFW59R9oo3Uz5L7Gc36+20dWCgSI7g=;
        b=BNdURllP5wDQ0YVyaN1RG1ZeA002wR0MSOy503FetgH2lReaHQ4F0/3O6/s6OLxieQ
         HykIf8bMi9qs2BY+7o4Rucc2hCY/EIy2muE59PSIlbuLWMypfaia7pM/+N5ltRRzO0Ka
         IDqUXKhO37WJevYKVy0eAH6dY/1P0HAN6AB2v3AMAxLENsCiC9E9rnd6AqKRhw6b+jpd
         asvvY3IrWGSH3nN4ZrFsww4qv/fpEeIBQfjZDpXF0mMsWRBedmcqtHZMbjAJLoKSCxT0
         gbssQS2nQVzNEH6oOc/UIXEvh2Jr12s1n4VoiHn9AmXlejoHUoiAzOOojdGhRpAiTNg1
         blNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7s8WxSVe5kYllMFW59R9oo3Uz5L7Gc36+20dWCgSI7g=;
        b=EREVi4xK3jwQO0RuKFb1vJ6FiE3/Gvyxypdh4JWPGiSWhB8pBABEhqivYr1w0wn1x1
         Chv2R31VcYCqrFIB61PR+gAxr6g92AwyyOWQIg52WjbSTkbO0u2TuiOY15vXJywrmDG/
         efZhXH9dWPKG1y/H0Rr88mEtRl1rQGWjA007KQ1njKurpB2DvruQd+zCZ+sk7vj65yxW
         1kOmZXN3KxPIYYBFhcJ285v7PXLaBI1bMBa9uSfg3Ryqvx4LyINJ7YP8J49AufKYaDna
         PNjwDIsCj0vX+a3hxS0M/t2qEqJSxe1NU+Zh8rPlMtmGPHFMLUw/fmJnQUNJWmARR084
         tsKg==
X-Gm-Message-State: AFqh2krN0ZYXJrtGk6PhecyroNw9iru78ZPM6E9aAf6wmmV4lkoPnKj8
        wPwAcsaAcUkzDFzewM6TaCVVzdHQU1Qb
X-Google-Smtp-Source: AMrXdXvA6RU3Y6CIpQmmyh29VCl5x1vaGzuP2rtA36Ce97qyoFPx2KUHqs2UbGiTKS5CNfAo9ZR4YtMDvd/F
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a05:6a00:26d3:b0:576:8015:8540 with SMTP
 id p19-20020a056a0026d300b0057680158540mr239844pfw.26.1671671735743; Wed, 21
 Dec 2022 17:15:35 -0800 (PST)
Date:   Thu, 22 Dec 2022 01:15:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222011529.3471280-1-dhavale@google.com>
Subject: [PATCH] EROFS: Replace erofs_unzipd workqueue with per-cpu threads
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
variation is reduced as per-cpu threads are SCHED_FIFO kthread_workers.

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
 fs/erofs/zdata.c | 84 +++++++++++++++++++++++++++++++++++-------------
 fs/erofs/zdata.h |  4 ++-
 2 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ccf7c55d477f..646667dbe615 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -8,6 +8,7 @@
 #include "compress.h"
 #include <linux/prefetch.h>
 #include <linux/psi.h>
+#include <linux/slab.h>
 
 #include <trace/events/erofs.h>
 
@@ -184,26 +185,56 @@ typedef tagptr1_t compressed_page_t;
 #define tag_compressed_page_justfound(page) \
 	tagptr_fold(compressed_page_t, page, 1)
 
-static struct workqueue_struct *z_erofs_workqueue __read_mostly;
+static struct kthread_worker **z_erofs_kthread_pool;
 
-void z_erofs_exit_zip_subsystem(void)
+static void z_erofs_destroy_kthread_pool(void)
 {
-	destroy_workqueue(z_erofs_workqueue);
-	z_erofs_destroy_pcluster_pool();
+	unsigned long cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (z_erofs_kthread_pool[cpu]) {
+			kthread_destroy_worker(z_erofs_kthread_pool[cpu]);
+			z_erofs_kthread_pool[cpu] = NULL;
+		}
+	}
+	kfree(z_erofs_kthread_pool);
 }
 
-static inline int z_erofs_init_workqueue(void)
+static int z_erofs_create_kthread_workers(void)
 {
-	const unsigned int onlinecpus = num_possible_cpus();
+	unsigned long cpu;
+	struct kthread_worker *worker;
+
+	for_each_possible_cpu(cpu) {
+		worker = kthread_create_worker_on_cpu(cpu, 0, "z_erofs/%ld", cpu);
+		if (IS_ERR(worker)) {
+			z_erofs_destroy_kthread_pool();
+			return -ENOMEM;
+		}
+		sched_set_fifo(worker->task);
+		z_erofs_kthread_pool[cpu] = worker;
+	}
+	return 0;
+}
 
-	/*
-	 * no need to spawn too many threads, limiting threads could minimum
-	 * scheduling overhead, perhaps per-CPU threads should be better?
-	 */
-	z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
-					    WQ_UNBOUND | WQ_HIGHPRI,
-					    onlinecpus + onlinecpus / 4);
-	return z_erofs_workqueue ? 0 : -ENOMEM;
+static int z_erofs_init_kthread_pool(void)
+{
+	int err;
+
+	z_erofs_kthread_pool = kcalloc(num_possible_cpus(),
+			sizeof(struct kthread_worker *), GFP_ATOMIC);
+	if (!z_erofs_kthread_pool)
+		return -ENOMEM;
+	err = z_erofs_create_kthread_workers();
+
+	return err;
+}
+
+
+void z_erofs_exit_zip_subsystem(void)
+{
+	z_erofs_destroy_kthread_pool();
+	z_erofs_destroy_pcluster_pool();
 }
 
 int __init z_erofs_init_zip_subsystem(void)
@@ -211,10 +242,16 @@ int __init z_erofs_init_zip_subsystem(void)
 	int err = z_erofs_create_pcluster_pool();
 
 	if (err)
-		return err;
-	err = z_erofs_init_workqueue();
+		goto out_error_pcluster_pool;
+
+	err = z_erofs_init_kthread_pool();
 	if (err)
-		z_erofs_destroy_pcluster_pool();
+		goto out_error_kthread_pool;
+
+	return err;
+out_error_kthread_pool:
+	z_erofs_destroy_pcluster_pool();
+out_error_pcluster_pool:
 	return err;
 }
 
@@ -1143,7 +1180,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 	}
 }
 
-static void z_erofs_decompressqueue_work(struct work_struct *work)
+static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
 {
 	struct z_erofs_decompressqueue *bgq =
 		container_of(work, struct z_erofs_decompressqueue, u.work);
@@ -1170,15 +1207,16 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	/* Use workqueue and sync decompression for atomic contexts only */
+	/* Use kthread_workers and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
-		queue_work(z_erofs_workqueue, &io->u.work);
+		kthread_queue_work(z_erofs_kthread_pool[raw_smp_processor_id()],
+			       &io->u.work);
 		/* enable sync decompression for readahead */
 		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
 			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
 		return;
 	}
-	z_erofs_decompressqueue_work(&io->u.work);
+	z_erofs_decompressqueue_kthread_work(&io->u.work);
 }
 
 static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
@@ -1306,7 +1344,7 @@ jobqueue_init(struct super_block *sb,
 			*fg = true;
 			goto fg_out;
 		}
-		INIT_WORK(&q->u.work, z_erofs_decompressqueue_work);
+		kthread_init_work(&q->u.work, z_erofs_decompressqueue_kthread_work);
 	} else {
 fg_out:
 		q = fgq;
@@ -1500,7 +1538,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 
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

