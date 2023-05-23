Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F470D249
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjEWDTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjEWDTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:19:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E490
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:19:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25343f0c693so4678734a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684811983; x=1687403983;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyH0W6DJZjpRDDDSjv6qa9noG3PE0QyQNSULfSparfs=;
        b=HW2B75lLxyMGCv4mkCrH4Sqyc5BxN34tMEWRTl84JtRFdMGKjvV2Xep5NzgHvgB8qO
         ndOMEC6a/RtDk/6lEGzYyImVU8Jmi3yuDIuFhGfZcKgJsGMUMsgXuv0xBzfU1XYsDt90
         VX6YEcTXvniIFijqpbWXPmTfS7VbmSIPh+satyy2kwJir2B963L0z8jsTZGuAEvCOINC
         lOgwiArNaUsbXtswMxrBPkdapegcPkUpl4CkIbIn+8UTiqcDFnUL46NlIAPrwyYPz6SF
         P5q7CUr7qmXGyTav3EBYqKwJKwRHNH0vsctFSuhopP01hzl6AH+sHOBtcnsWsAiNYEMB
         55jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684811983; x=1687403983;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyH0W6DJZjpRDDDSjv6qa9noG3PE0QyQNSULfSparfs=;
        b=fefMJZtIs1y/RxRuIOADzaV1fEqYsobNR4BYynhHm3S6LCnswud+Jne+ScIV31HEGb
         CkPhPW61F6tfSrPrl3RCfOCznDuWYLOiLC9PIvnmQYi2JyEsiDIvYU3rDXYLYuDln3zb
         v6Y4tMHExngZKHc0cQ2w8E/H2EdkyS5ZUQOjDIBWor/DRhYIEi6TTtdhisd3U5ubYLgV
         7wyaoMpYKuxJg2DQeOhOUEiHvtgS6i9ILNt51f+fSFA7Wfg9eq2QZq4ZtrbkYCsftOvl
         ssgwzs133ARG77J+shb5pvD7rX8/fzlDf1h89LCcPpSJFyZdkAIFm26iqFd2d7u7HpwC
         x3Zg==
X-Gm-Message-State: AC+VfDyhcVtGM7874ADhhowZBHIt70bmJrLIas+j8ZSfg5ZV19RdqsbF
        kk6UYqQn/wCcY/IvJbO4Lao=
X-Google-Smtp-Source: ACHHUZ7dASrrOFpaWDe+9Y2ISWKW7w7p6eNXDx7UOpjJPx2IlifXydzoltXcuX0Spaz1vMILZEZr3A==
X-Received: by 2002:a17:90b:170e:b0:23f:83de:7e4a with SMTP id ko14-20020a17090b170e00b0023f83de7e4amr12066082pjb.7.1684811982957;
        Mon, 22 May 2023 20:19:42 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090aac0a00b002467717fa60sm4802675pjq.16.2023.05.22.20.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 20:19:42 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, naresh.kamboju@linaro.org,
        qiang.zhang1211@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Fix warning triggered when nr_running is checked in worker_enter_idle()
Date:   Tue, 23 May 2023 11:19:33 +0800
Message-Id: <20230523031933.13421-1-qiang.zhang1211@gmail.com>
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

This commit therefore add irq protection in wq_worker_running() to
block timer tick modify nr_running.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230519/testrun/17078554/suite/boot/test/clang-nightly-lkftconfig/log
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9c5c1cfa478f..f8d739fef311 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1060,10 +1060,9 @@ void wq_worker_running(struct task_struct *task)
 	 * and leave with an unexpected pool->nr_running == 1 on the newly unbound
 	 * pool. Protect against such race.
 	 */
-	preempt_disable();
+	local_irq_disable();
 	if (!(worker->flags & WORKER_NOT_RUNNING))
 		worker->pool->nr_running++;
-	preempt_enable();
 
 	/*
 	 * CPU intensive auto-detection cares about how long a work item hogged
@@ -1072,6 +1071,7 @@ void wq_worker_running(struct task_struct *task)
 	worker->current_at = worker->task->se.sum_exec_runtime;
 
 	worker->sleeping = 0;
+	local_irq_enable();
 }
 
 /**
-- 
2.17.1

