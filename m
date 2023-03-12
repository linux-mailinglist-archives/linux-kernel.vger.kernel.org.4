Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F0B6B6B57
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCLUnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjCLUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:42:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129AB3B668;
        Sun, 12 Mar 2023 13:42:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so177644pjz.1;
        Sun, 12 Mar 2023 13:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678653763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsq0RBbnJAmMfF8oeFhuiCUGc8EVlJtKASulhInC9Fo=;
        b=I19nr1BjrNFdIiHNB3SBvsQGNIs0trZfyTXlJ6JtMDUREtUxjEzlhJWGtxyJvY1leq
         qJlSJb2LVlEulygH326A3UpGB2umDkbSIZf5dWEpWDVVxYqYID3swTN7btiIoFAAtnm6
         Q3/liPcPkHN/xtD68HJm/qb+H+Pytwan1YhAunbXHdCWx/MzubUP4CJvjzDZK5WVz0VB
         kr9wKAVoRY4hHuWnWUupSv3kypmHVJ/zDHxo3UM8512o9EDDDBIykagT8d7QWRyFkmYr
         GXyHLnLpdXoHHuWetRIpV15ONxDKS890jF4Qej7r4p4VFil/mci/SrrY1SkSBvmVk6d7
         Ej+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsq0RBbnJAmMfF8oeFhuiCUGc8EVlJtKASulhInC9Fo=;
        b=6zTnux8Eq2J7ZLoZab10T3SbVE7WyQ3Exw0P2Y2Cdqw+s9vcdoe6mdVbRosuej9YRM
         NOayo39wmqJTxGNywsLMUKtma12uNv3BR51lu2dWzZCwSGQiMm5WK0xettsoRwGqTVRN
         PtDRWOqZj8ohExtPPJHZX2VMSE2XkUrnelZgxofSlXaS9tNDXCZ0m4lwCagGYngWrreM
         ohYR08KdC6+aFw0cC60BVhjNz+WPkK/2wLhxxm9eUdB39tH668Pc7tsy1/Y/q+OzhQaW
         9XpVY8pViTNU+FFVa1aaDzVTeZTVM1lC3YgzBnWxo5DKW7/thRYBLgWpEQade0OKTGxS
         V4nA==
X-Gm-Message-State: AO0yUKXbF4YyrG8Q55KfS+7Q8/BzdfQhk9NW2v/VwlYaVG1Wr2/Tkm2D
        k8KEqOXKKTqtsy17H1dWRCY=
X-Google-Smtp-Source: AK7set9cyGq2v1hLUmqTs3Af2ocaV7/huFXQhBX3lgkZSIjpVaGQ6/TKBpGSHRf1tO8GG3wvSJi61g==
X-Received: by 2002:a17:903:11c8:b0:19f:1bd9:505 with SMTP id q8-20020a17090311c800b0019f1bd90505mr8899218plh.36.1678653763149;
        Sun, 12 Mar 2023 13:42:43 -0700 (PDT)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709026b4100b0019a96d3b456sm3268608plt.44.2023.03.12.13.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:42:42 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 08/13] PM / QoS: Fix constraints alloc vs reclaim locking
Date:   Sun, 12 Mar 2023 13:41:36 -0700
Message-Id: <20230312204150.1353517-9-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312204150.1353517-1-robdclark@gmail.com>
References: <20230312204150.1353517-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

In the process of adding lockdep annotation for drm GPU scheduler's
job_run() to detect potential deadlock against shrinker/reclaim, I hit
this lockdep splat:

   ======================================================
   WARNING: possible circular locking dependency detected
   6.2.0-rc8-debug+ #558 Tainted: G        W
   ------------------------------------------------------
   ring0/125 is trying to acquire lock:
   ffffffd6d6ce0f28 (dev_pm_qos_mtx){+.+.}-{3:3}, at: dev_pm_qos_update_request+0x38/0x68

   but task is already holding lock:
   ffffff8087239208 (&gpu->active_lock){+.+.}-{3:3}, at: msm_gpu_submit+0xec/0x178

   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:

   -> #4 (&gpu->active_lock){+.+.}-{3:3}:
          __mutex_lock+0xcc/0x3c8
          mutex_lock_nested+0x30/0x44
          msm_gpu_submit+0xec/0x178
          msm_job_run+0x78/0x150
          drm_sched_main+0x290/0x370
          kthread+0xf0/0x100
          ret_from_fork+0x10/0x20

   -> #3 (dma_fence_map){++++}-{0:0}:
          __dma_fence_might_wait+0x74/0xc0
          dma_resv_lockdep+0x1f4/0x2f4
          do_one_initcall+0x104/0x2bc
          kernel_init_freeable+0x344/0x34c
          kernel_init+0x30/0x134
          ret_from_fork+0x10/0x20

   -> #2 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
          fs_reclaim_acquire+0x80/0xa8
          slab_pre_alloc_hook.constprop.0+0x40/0x25c
          __kmem_cache_alloc_node+0x60/0x1cc
          __kmalloc+0xd8/0x100
          topology_parse_cpu_capacity+0x8c/0x178
          get_cpu_for_node+0x88/0xc4
          parse_cluster+0x1b0/0x28c
          parse_cluster+0x8c/0x28c
          init_cpu_topology+0x168/0x188
          smp_prepare_cpus+0x24/0xf8
          kernel_init_freeable+0x18c/0x34c
          kernel_init+0x30/0x134
          ret_from_fork+0x10/0x20

   -> #1 (fs_reclaim){+.+.}-{0:0}:
          __fs_reclaim_acquire+0x3c/0x48
          fs_reclaim_acquire+0x54/0xa8
          slab_pre_alloc_hook.constprop.0+0x40/0x25c
          __kmem_cache_alloc_node+0x60/0x1cc
          kmalloc_trace+0x50/0xa8
          dev_pm_qos_constraints_allocate+0x38/0x100
          __dev_pm_qos_add_request+0xb0/0x1e8
          dev_pm_qos_add_request+0x58/0x80
          dev_pm_qos_expose_latency_limit+0x60/0x13c
          register_cpu+0x12c/0x130
          topology_init+0xac/0xbc
          do_one_initcall+0x104/0x2bc
          kernel_init_freeable+0x344/0x34c
          kernel_init+0x30/0x134
          ret_from_fork+0x10/0x20

   -> #0 (dev_pm_qos_mtx){+.+.}-{3:3}:
          __lock_acquire+0xe00/0x1060
          lock_acquire+0x1e0/0x2f8
          __mutex_lock+0xcc/0x3c8
          mutex_lock_nested+0x30/0x44
          dev_pm_qos_update_request+0x38/0x68
          msm_devfreq_boost+0x40/0x70
          msm_devfreq_active+0xc0/0xf0
          msm_gpu_submit+0x10c/0x178
          msm_job_run+0x78/0x150
          drm_sched_main+0x290/0x370
          kthread+0xf0/0x100
          ret_from_fork+0x10/0x20

   other info that might help us debug this:

   Chain exists of:
     dev_pm_qos_mtx --> dma_fence_map --> &gpu->active_lock

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     lock(&gpu->active_lock);
                                  lock(dma_fence_map);
                                  lock(&gpu->active_lock);
     lock(dev_pm_qos_mtx);

    *** DEADLOCK ***

   3 locks held by ring0/123:
    #0: ffffff8087251170 (&gpu->lock){+.+.}-{3:3}, at: msm_job_run+0x64/0x150
    #1: ffffffd00b0e57e8 (dma_fence_map){++++}-{0:0}, at: msm_job_run+0x68/0x150
    #2: ffffff8087251208 (&gpu->active_lock){+.+.}-{3:3}, at: msm_gpu_submit+0xec/0x178

   stack backtrace:
   CPU: 6 PID: 123 Comm: ring0 Not tainted 6.2.0-rc8-debug+ #559
   Hardware name: Google Lazor (rev1 - 2) with LTE (DT)
   Call trace:
    dump_backtrace.part.0+0xb4/0xf8
    show_stack+0x20/0x38
    dump_stack_lvl+0x9c/0xd0
    dump_stack+0x18/0x34
    print_circular_bug+0x1b4/0x1f0
    check_noncircular+0x78/0xac
    __lock_acquire+0xe00/0x1060
    lock_acquire+0x1e0/0x2f8
    __mutex_lock+0xcc/0x3c8
    mutex_lock_nested+0x30/0x44
    dev_pm_qos_update_request+0x38/0x68
    msm_devfreq_boost+0x40/0x70
    msm_devfreq_active+0xc0/0xf0
    msm_gpu_submit+0x10c/0x178
    msm_job_run+0x78/0x150
    drm_sched_main+0x290/0x370
    kthread+0xf0/0x100
    ret_from_fork+0x10/0x20

The issue is that dev_pm_qos_mtx is held in the runpm suspend/resume (or
freq change) path, but it is also held across allocations that could
recurse into shrinker.

Solve this by changing dev_pm_qos_constraints_allocate() into a function
that can be called unconditionally before the device qos object is
needed and before aquiring dev_pm_qos_mtx.  This way the allocations can
be done without holding the mutex.  In the case that we raced with
another thread to allocate the qos object, detect this *after* acquiring
the dev_pm_qos_mtx and simply free the redundant allocations.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/base/power/qos.c | 60 +++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 8e93167f1783..f3e0c6b65635 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -185,18 +185,24 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 }
 
 /*
- * dev_pm_qos_constraints_allocate
+ * dev_pm_qos_constraints_ensure_allocated
  * @dev: device to allocate data for
  *
- * Called at the first call to add_request, for constraint data allocation
- * Must be called with the dev_pm_qos_mtx mutex held
+ * Called to ensure that devices qos is allocated, before acquiring
+ * dev_pm_qos_mtx.
  */
-static int dev_pm_qos_constraints_allocate(struct device *dev)
+static int dev_pm_qos_constraints_ensure_allocated(struct device *dev)
 {
 	struct dev_pm_qos *qos;
 	struct pm_qos_constraints *c;
 	struct blocking_notifier_head *n;
 
+	if (!dev)
+		return -ENODEV;
+
+	if (!IS_ERR_OR_NULL(dev->power.qos))
+		return 0;
+
 	qos = kzalloc(sizeof(*qos), GFP_KERNEL);
 	if (!qos)
 		return -ENOMEM;
@@ -227,10 +233,26 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 
 	INIT_LIST_HEAD(&qos->flags.list);
 
+	mutex_lock(&dev_pm_qos_mtx);
+
+	if (!IS_ERR_OR_NULL(dev->power.qos)) {
+		/*
+		 * We have raced with another task to create the qos.
+		 * No biggie, just free the resources we've allocated
+		 * outside of dev_pm_qos_mtx and move on with life.
+		 */
+		kfree(n);
+		kfree(qos);
+		goto unlock;
+	}
+
 	spin_lock_irq(&dev->power.lock);
 	dev->power.qos = qos;
 	spin_unlock_irq(&dev->power.lock);
 
+unlock:
+	mutex_unlock(&dev_pm_qos_mtx);
+
 	return 0;
 }
 
@@ -331,17 +353,15 @@ static int __dev_pm_qos_add_request(struct device *dev,
 {
 	int ret = 0;
 
-	if (!dev || !req || dev_pm_qos_invalid_req_type(dev, type))
+	if (!req || dev_pm_qos_invalid_req_type(dev, type))
 		return -EINVAL;
 
 	if (WARN(dev_pm_qos_request_active(req),
 		 "%s() called for already added request\n", __func__))
 		return -EINVAL;
 
-	if (IS_ERR(dev->power.qos))
+	if (IS_ERR_OR_NULL(dev->power.qos))
 		ret = -ENODEV;
-	else if (!dev->power.qos)
-		ret = dev_pm_qos_constraints_allocate(dev);
 
 	trace_dev_pm_qos_add_request(dev_name(dev), type, value);
 	if (ret)
@@ -390,6 +410,10 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 {
 	int ret;
 
+	ret = dev_pm_qos_constraints_ensure_allocated(dev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&dev_pm_qos_mtx);
 	ret = __dev_pm_qos_add_request(dev, req, type, value);
 	mutex_unlock(&dev_pm_qos_mtx);
@@ -537,15 +561,11 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 {
 	int ret = 0;
 
-	mutex_lock(&dev_pm_qos_mtx);
-
-	if (IS_ERR(dev->power.qos))
-		ret = -ENODEV;
-	else if (!dev->power.qos)
-		ret = dev_pm_qos_constraints_allocate(dev);
-
+	ret = dev_pm_qos_constraints_ensure_allocated(dev);
 	if (ret)
-		goto unlock;
+		return ret;
+
+	mutex_lock(&dev_pm_qos_mtx);
 
 	switch (type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
@@ -565,7 +585,6 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 		ret = -EINVAL;
 	}
 
-unlock:
 	mutex_unlock(&dev_pm_qos_mtx);
 	return ret;
 }
@@ -905,10 +924,13 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 {
 	int ret;
 
+	ret = dev_pm_qos_constraints_ensure_allocated(dev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&dev_pm_qos_mtx);
 
-	if (IS_ERR_OR_NULL(dev->power.qos)
-	    || !dev->power.qos->latency_tolerance_req) {
+	if (!dev->power.qos->latency_tolerance_req) {
 		struct dev_pm_qos_request *req;
 
 		if (val < 0) {
-- 
2.39.2

