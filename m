Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBFF70F813
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjEXNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjEXNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:53:30 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3682BE7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:53:29 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-456f1cc1791so370864e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684936408; x=1687528408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gwD6u1FQmyHWNrVCzQVq2EupUkbSzu1n+bmMUn2xors=;
        b=x/OZhZZmSq2dRD6mNfeySJSSo5YA2o1iEYhRSagkWYS+paY/sFf+hH4dawfGRb6O3D
         2YSJSG2OMaxH4TOVaFT/323ksWvRuysQnKioxonW9WK8dz7/3Y/Pn4QGyt3wZs1cnxhR
         bITZjBEWzrDMCMhKRykdkq6mjKXNd7WtpMAA3qsmcnw/tzyGAaxsilF/CwwTXEVhg2qL
         TK07U+VsK6baeyFZyEP9sVAiAKKUySIt9MAj+VZe63dQQOcpfvDqxws6IEDWTK4Q8X3e
         Do//jn2rCILhv9VPcHzNw3b/cLcytyFUxpM/GsUuwFt8B4riooXcCIaePYgNzpvMEXGL
         WKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684936408; x=1687528408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwD6u1FQmyHWNrVCzQVq2EupUkbSzu1n+bmMUn2xors=;
        b=IP21DAJ4xQPpQSJyaZ43uz9tN9O18dPjpyIXF+fDHDddiwu2mo4sKMoXYZ4vzQ3IOS
         EUJd/MKXM7xvSvSOrNlad5agHRsqf8fFjO+dnDmdzVgxv8PIhiV58NhtujmTsFemublj
         npSzF1QcDzKwT3U9KddzT8TrPL5pVrn0tfwp0cZpux+JFYkSqYnG7aVGysFRVM6EcMgZ
         UXMePnX2kZdDVrK4I2Xzw3qA2VLYzEIDucEif/Gxm4EQi9maNrynITuCSxA9mpn9PUPu
         PqYhnQoOiEjvZx1Kfjd7u/TY6hPqJbiI6SkaBhGTb9mN/Tcx3fEgzdHZGWGHcZf/IqYB
         uXsQ==
X-Gm-Message-State: AC+VfDyYgNOczfnIpvl6VjFjBK73mIA77QTT+DTvwYXYCs4jxm8Yve5S
        TWhPvA8YypqdhaILzAGLNbY9VfkkeuaFxksRVEpN2Q==
X-Google-Smtp-Source: ACHHUZ5hKnnbNmvZwSmfJRv7UockG0+EXF9t2SP/QqfNqqmViCdG/K2WYajE36GExnQ2HykigEf0KdRa65oxKj0Nn9g=
X-Received: by 2002:a1f:438d:0:b0:44f:ef57:c49a with SMTP id
 q135-20020a1f438d000000b0044fef57c49amr5770132vka.11.1684936408028; Wed, 24
 May 2023 06:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230524035339.25185-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20230524035339.25185-1-qiang.zhang1211@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 24 May 2023 19:23:16 +0530
Message-ID: <CA+G9fYtXCMWObuaS64qb3FofiokK_nrq2tm8b8g2xDd8tyKTxw@mail.gmail.com>
Subject: Re: [PATCH v3] workqueue: Fix WARN_ON_ONCE() triggers in worker_enter_idle()
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Anders, LKFT

On Wed, 24 May 2023 at 09:23, Zqiang <qiang.zhang1211@gmail.com> wrote:
>
> Currently, the nr_running can be modified from timer tick, that means
> the timer tick can run in not-irq-protected critical section to modify
> nr_runnig, consider the following scenario:
>
> CPU0
> kworker/0:2 (events)
>    worker_clr_flags(worker, WORKER_PREP | WORKER_REBOUND);
>    ->pool->nr_running++;  (1)
>
>    process_one_work()
>    ->worker->current_func(work);
>      ->schedule()
>        ->wq_worker_sleeping()
>          ->worker->sleeping = 1;
>          ->pool->nr_running--;  (0)
>            ....
>        ->wq_worker_running()
>                ....
>                CPU0 by interrupt:
>                wq_worker_tick()
>                ->worker_set_flags(worker, WORKER_CPU_INTENSIVE);
>                  ->pool->nr_running--;  (-1)
>                  ->worker->flags |= WORKER_CPU_INTENSIVE;
>                ....
>          ->if (!(worker->flags & WORKER_NOT_RUNNING))
>            ->pool->nr_running++;    (will not execute)
>          ->worker->sleeping = 0;
>          ....
>     ->worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
>       ->pool->nr_running++;  (0)
>     ....
>     worker_set_flags(worker, WORKER_PREP);
>     ->pool->nr_running--;   (-1)
>     ....
>     worker_enter_idle()
>     ->WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
>
> if the nr_workers is equal to nr_idle, due to the nr_running is not zero,
> will trigger WARN_ON_ONCE().
>
> [    2.460602] WARNING: CPU: 0 PID: 63 at kernel/workqueue.c:1999 worker_enter_idle+0xb2/0xc0
> [    2.462163] Modules linked in:
> [    2.463401] CPU: 0 PID: 63 Comm: kworker/0:2 Not tainted 6.4.0-rc2-next-20230519 #1
> [    2.463771] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> [    2.465127] Workqueue:  0x0 (events)
> [    2.465678] RIP: 0010:worker_enter_idle+0xb2/0xc0
> ...
> [    2.472614] Call Trace:
> [    2.473152]  <TASK>
> [    2.474182]  worker_thread+0x71/0x430
> [    2.474992]  ? _raw_spin_unlock_irqrestore+0x28/0x50
> [    2.475263]  kthread+0x103/0x120
> [    2.475493]  ? __pfx_worker_thread+0x10/0x10
> [    2.476355]  ? __pfx_kthread+0x10/0x10
> [    2.476635]  ret_from_fork+0x2c/0x50
> [    2.477051]  </TASK>
>
> This commit therefore add the check of worker->sleeping in wq_worker_tick(),
> if the worker->sleeping is not zero, directly return.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230519/testrun/17078554/suite/boot/test/clang-nightly-lkftconfig/log
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>

Since the probability of occurrence of this problem is only 3%,
Anders took this up and applied this on top of Linux next and
tested for 500 boot tests and all looked good.
Thanks, Anders.

- Naresh

> ---
>  kernel/workqueue.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9c5c1cfa478f..a028b851333e 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1051,7 +1051,7 @@ void wq_worker_running(struct task_struct *task)
>  {
>         struct worker *worker = kthread_data(task);
>
> -       if (!worker->sleeping)
> +       if (!READ_ONCE(worker->sleeping))
>                 return;
>
>         /*
> @@ -1071,7 +1071,7 @@ void wq_worker_running(struct task_struct *task)
>          */
>         worker->current_at = worker->task->se.sum_exec_runtime;
>
> -       worker->sleeping = 0;
> +       WRITE_ONCE(worker->sleeping, 0);
>  }
>
>  /**
> @@ -1097,10 +1097,10 @@ void wq_worker_sleeping(struct task_struct *task)
>         pool = worker->pool;
>
>         /* Return if preempted before wq_worker_running() was reached */
> -       if (worker->sleeping)
> +       if (READ_ONCE(worker->sleeping))
>                 return;
>
> -       worker->sleeping = 1;
> +       WRITE_ONCE(worker->sleeping, 1);
>         raw_spin_lock_irq(&pool->lock);
>
>         /*
> @@ -1143,8 +1143,13 @@ void wq_worker_tick(struct task_struct *task)
>          * If the current worker is concurrency managed and hogged the CPU for
>          * longer than wq_cpu_intensive_thresh_us, it's automatically marked
>          * CPU_INTENSIVE to avoid stalling other concurrency-managed work items.
> +        *
> +        * The worker->sleeping is true means that the worker doing voluntary
> +        * switch and will not hogged the CPU, or the worker is running again
> +        * but the worker->sleeping has not been reset, in the process of executing
> +        * wq_worker_running().
>          */
> -       if ((worker->flags & WORKER_NOT_RUNNING) ||
> +       if ((worker->flags & WORKER_NOT_RUNNING) || READ_ONCE(worker->sleeping) ||
>             worker->task->se.sum_exec_runtime - worker->current_at <
>             wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
>                 return;
> --
> 2.17.1
>
