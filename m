Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8570DEDD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjEWOMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbjEWOMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:12:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E351AE
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:12:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae4c5e1388so70758635ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684851124; x=1687443124;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOv8NfcQjNQA77R6r5WpnsvLvT0EoI9tnHd1ASgA//M=;
        b=NvdjK01a3xo4nQVj/srjU9AzEk3tK1ASeQXNfLF+9Bq4q0PsxrsG1cb1xFA97XaFJT
         K0EKk5nOHdfpF4Ne913j63t+l/wIHqxA5jRiaikboXplBRa7ndTXRKOLQzvIo0OTjokB
         JnkvdB/P9w/aQI5eOL/q8OlnlO81iZs9k7MYdEF3ErBa/TtoGAR/F+7Z9mMij0vlUW5A
         lWLik/xV6XaHdbyVwicUSr8k5vTXQFJydaAkdd7JxkGEIDorVFLtcEDd895qnsy8/yL6
         j2+NQfLdZv+fC/5JI5mYI1kT5yeyCTY1hLOZbvCSidUr+tMmF/kdWv4NDWOaqNnrjGoI
         GPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851124; x=1687443124;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOv8NfcQjNQA77R6r5WpnsvLvT0EoI9tnHd1ASgA//M=;
        b=ZLUHZjIQhZEMMiNIcHOQkmqA8t0LERnvOGtTiGAEht5DiP+JahAboYGQAVPBnMTc++
         a8RgobxnwNZGRYKTAzMspXApXPa5cdENKXLetKiF/EzOpSkXj+BW9FyiBwDudlcb9BjW
         mVh9mn/DzDgqPmElImk9AIWoGbluWe8nJnci0Wh1RbQ+CQg/RcMauiYt5Yx1d1oaOD7h
         gsSapOXHeb1Utu6+tu/yaG+k5NeTB2ESscO4qYWQDORhNbTGqcRqFrSWsEXOTI0QaNMr
         MvGVn8L64R+viqfkbbaIdG9pI1yDFUazNukzgvTh/Qh64sP5XcA/q781Eyewj+FfXadH
         QHDw==
X-Gm-Message-State: AC+VfDxZ78o6ij8T7YQL1uK9kb+4tjQeCGHFdwLNP9UM+DNKfTHaaP55
        HYYy0eb0xJjv9qEZ6v19pN8=
X-Google-Smtp-Source: ACHHUZ6HrjWU1CF0VhgPjXJNlZHb6MbE97XjzyUOPvxDc0pZMB6O1X3FG652/Ma4XaVVxayKZ6O6Eg==
X-Received: by 2002:a17:903:1251:b0:1ac:451d:34a with SMTP id u17-20020a170903125100b001ac451d034amr16957690plh.33.1684851123743;
        Tue, 23 May 2023 07:12:03 -0700 (PDT)
Received: from localhost.localdomain ([124.126.151.211])
        by smtp.gmail.com with ESMTPSA id jl1-20020a170903134100b00194caf3e975sm6789013plb.208.2023.05.23.07.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:12:03 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, naresh.kamboju@linaro.org,
        qiang.zhang1211@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: Fix warning triggered when nr_running is checked in worker_enter_idle()
Date:   Tue, 23 May 2023 22:09:41 +0800
Message-Id: <20230523140942.18679-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

This commit therefore add the check of worker->sleeping in
wq_worker_tick(), if the worker->sleeping is not zero, directly return.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230519/testrun/17078554/suite/boot/test/clang-nightly-lkftconfig/log
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9c5c1cfa478f..329b84c42062 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1144,13 +1144,12 @@ void wq_worker_tick(struct task_struct *task)
 	 * longer than wq_cpu_intensive_thresh_us, it's automatically marked
 	 * CPU_INTENSIVE to avoid stalling other concurrency-managed work items.
 	 */
-	if ((worker->flags & WORKER_NOT_RUNNING) ||
+	if ((worker->flags & WORKER_NOT_RUNNING) || worker->sleeping ||
 	    worker->task->se.sum_exec_runtime - worker->current_at <
 	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
 		return;
 
 	raw_spin_lock(&pool->lock);
-
 	worker_set_flags(worker, WORKER_CPU_INTENSIVE);
 	wq_cpu_intensive_report(worker->current_func);
 	pwq->stats[PWQ_STAT_CPU_INTENSIVE]++;
-- 
2.17.1

