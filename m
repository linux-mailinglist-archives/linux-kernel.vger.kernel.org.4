Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F670EC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbjEXDxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbjEXDxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:53:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31570E8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:53:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d2ca9ef0cso273707b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684900427; x=1687492427;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijO+PW0Fv+KmH7hprPn+mrn2AVRTYcdaTxH1iBBdTRU=;
        b=nd67p1H+gvYCQ0IN2kqm0xbetKLMomHymgAyIacGbw/MWe8KcYisOuEc3D+wglTTID
         ef5UlKlvqERCl930c8tMJvLTFHJyT7Fhq4xpOCDF4jMv9gKG5xwsGTgAo+RjXa1SM7cR
         SiWwjW5l0+FVDrekIT14CWOSAUbke0Mddd8W9T55C1xD+hmERSedcDKAdOeFvOBq1OY3
         S9Gzm9V2HRxyp+LL+R0hjRnFUjVOYtYJ4b9+TenPiHY7y3gretM2mGK3ZK9em6olArMc
         /uRj8mrgLcUB98vAnWaTmZ3fh5nUHXznhOuYDpamCddDEtAMW4vIaTRJH7WQbrLQPjGe
         h3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684900427; x=1687492427;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijO+PW0Fv+KmH7hprPn+mrn2AVRTYcdaTxH1iBBdTRU=;
        b=B5O+ZqMlt38LHwfjFUmQdWYI2ZqUxFi3ars7CoVDDigC0wemZN9sAfwR3WgH4brHcH
         avLUrg/Csk0q+mBF/t5ATg353efHSgeD5lukpxA2GrES7pkoe909W/fvfmgz45lGwNrc
         FUIoHXUwJ2p7WkZNLUBwuuhRhc3SoTBbaa5KxbrHXCpSyMX5gLwmmZIozpSgjMuuddBX
         rH+uLLY6tdlGMZgfGfDjNMsZOfY8IkHqAKh0lEo/d3mwH/8rYlQwwCyGHtFs8/cSk9Fj
         Xfx2u6F21+bg7HzTgHcw5JAYpcwlnFcFcpMd9bORWbbiI295wJiqY3GwrWgJtSmNXgRG
         oCAg==
X-Gm-Message-State: AC+VfDxP7dCOg25hrdAZgyJDyb0D9OhgOKXsOv40v+h34iBe+iYcrtNa
        GVA3LpyLktwUV5c55XsFro8=
X-Google-Smtp-Source: ACHHUZ674TWMevtFMfkhWKghZ2hn0RQMhslKLlDZqDWmwMTCd4Yk5m4EYKXceZayysZkUpKfY22zgg==
X-Received: by 2002:a05:6a00:3911:b0:64a:2dd6:4f18 with SMTP id fh17-20020a056a00391100b0064a2dd64f18mr1435216pfb.13.1684900427610;
        Tue, 23 May 2023 20:53:47 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id x10-20020a056a00270a00b00640e64aa9b7sm6690296pfv.10.2023.05.23.20.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 20:53:46 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, naresh.kamboju@linaro.org,
        qiang.zhang1211@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] workqueue: Fix WARN_ON_ONCE() triggers in worker_enter_idle()
Date:   Wed, 24 May 2023 11:53:39 +0800
Message-Id: <20230524035339.25185-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the nr_running can be modified from timer tick, that means
the timer tick can run in not-irq-protected critical section to modify
nr_runnig, consider the following scenario:

CPU0
kworker/0:2 (events)
   worker_clr_flags(worker, WORKER_PREP | WORKER_REBOUND);
   ->pool->nr_running++;  (1)

   process_one_work()
   ->worker->current_func(work);
     ->schedule()
       ->wq_worker_sleeping()
         ->worker->sleeping = 1;
         ->pool->nr_running--;  (0)
           ....
       ->wq_worker_running()
               ....
               CPU0 by interrupt:
               wq_worker_tick()
               ->worker_set_flags(worker, WORKER_CPU_INTENSIVE);
                 ->pool->nr_running--;  (-1)
	         ->worker->flags |= WORKER_CPU_INTENSIVE;
               ....
         ->if (!(worker->flags & WORKER_NOT_RUNNING))
           ->pool->nr_running++;    (will not execute)
         ->worker->sleeping = 0;
         ....
    ->worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
      ->pool->nr_running++;  (0)
    ....
    worker_set_flags(worker, WORKER_PREP);
    ->pool->nr_running--;   (-1)
    ....
    worker_enter_idle()
    ->WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);

if the nr_workers is equal to nr_idle, due to the nr_running is not zero,
will trigger WARN_ON_ONCE().

[    2.460602] WARNING: CPU: 0 PID: 63 at kernel/workqueue.c:1999 worker_enter_idle+0xb2/0xc0
[    2.462163] Modules linked in:
[    2.463401] CPU: 0 PID: 63 Comm: kworker/0:2 Not tainted 6.4.0-rc2-next-20230519 #1
[    2.463771] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
[    2.465127] Workqueue:  0x0 (events)
[    2.465678] RIP: 0010:worker_enter_idle+0xb2/0xc0
...
[    2.472614] Call Trace:
[    2.473152]  <TASK>
[    2.474182]  worker_thread+0x71/0x430
[    2.474992]  ? _raw_spin_unlock_irqrestore+0x28/0x50
[    2.475263]  kthread+0x103/0x120
[    2.475493]  ? __pfx_worker_thread+0x10/0x10
[    2.476355]  ? __pfx_kthread+0x10/0x10
[    2.476635]  ret_from_fork+0x2c/0x50
[    2.477051]  </TASK>

This commit therefore add the check of worker->sleeping in wq_worker_tick(),
if the worker->sleeping is not zero, directly return.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230519/testrun/17078554/suite/boot/test/clang-nightly-lkftconfig/log
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9c5c1cfa478f..a028b851333e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1051,7 +1051,7 @@ void wq_worker_running(struct task_struct *task)
 {
 	struct worker *worker = kthread_data(task);
 
-	if (!worker->sleeping)
+	if (!READ_ONCE(worker->sleeping))
 		return;
 
 	/*
@@ -1071,7 +1071,7 @@ void wq_worker_running(struct task_struct *task)
 	 */
 	worker->current_at = worker->task->se.sum_exec_runtime;
 
-	worker->sleeping = 0;
+	WRITE_ONCE(worker->sleeping, 0);
 }
 
 /**
@@ -1097,10 +1097,10 @@ void wq_worker_sleeping(struct task_struct *task)
 	pool = worker->pool;
 
 	/* Return if preempted before wq_worker_running() was reached */
-	if (worker->sleeping)
+	if (READ_ONCE(worker->sleeping))
 		return;
 
-	worker->sleeping = 1;
+	WRITE_ONCE(worker->sleeping, 1);
 	raw_spin_lock_irq(&pool->lock);
 
 	/*
@@ -1143,8 +1143,13 @@ void wq_worker_tick(struct task_struct *task)
 	 * If the current worker is concurrency managed and hogged the CPU for
 	 * longer than wq_cpu_intensive_thresh_us, it's automatically marked
 	 * CPU_INTENSIVE to avoid stalling other concurrency-managed work items.
+	 *
+	 * The worker->sleeping is true means that the worker doing voluntary
+	 * switch and will not hogged the CPU, or the worker is running again
+	 * but the worker->sleeping has not been reset, in the process of executing
+	 * wq_worker_running().
 	 */
-	if ((worker->flags & WORKER_NOT_RUNNING) ||
+	if ((worker->flags & WORKER_NOT_RUNNING) || READ_ONCE(worker->sleeping) ||
 	    worker->task->se.sum_exec_runtime - worker->current_at <
 	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
 		return;
-- 
2.17.1

