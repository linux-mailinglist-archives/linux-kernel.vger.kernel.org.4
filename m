Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D0470DBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbjEWLox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjEWLov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:44:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B34133
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:44:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25394160fd3so2747065a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684842286; x=1687434286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3rczHRL3TEcFNjM2ZeD6JpzC77rZYfh2AJXBPeYfd8=;
        b=bp8lf+1+H9fcwybE8qO4s8I/GtGAMvmZalhQczwbTuLF1Ex6EAG4jwj9MEdLvTHq3b
         XpZftOWpwmFa/6JKSJfY73W4J3gciDjQLUeRNC0HEE5r9B8igCCXr26hiWcTRGQhy5/k
         VypACVomDcZ1QuEdFoP0QvyAwWjLwvesRETYkoirbpHytFasF+Y0pGYTB9X0FPpINZ+l
         0FtY4jLAjC1SYF2+I5Q4MNgbN735IEYQUIoG0G07c2BAZrDLw5w+P21hUb0pRg+Rtbgp
         /i4WOdSD1pUxMwGhWmcjJ63FjC2OfJY07JQOE7bjXUKT8ggjyqATki1pTpLbEY752GUf
         zs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684842286; x=1687434286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3rczHRL3TEcFNjM2ZeD6JpzC77rZYfh2AJXBPeYfd8=;
        b=UPr7b5b8NYt5398jRqmzWjwCsM5kpxaAPKSgShGSOhVLk9bRRtBFaNrrI/2S2VOx6K
         3qAV7nQkkiBkIL6DFzFNVyYxo7lPBSQwDYqN4Og6UkgHTwPZZwkU0rYkgB2+MRGwGHac
         ojP/mbtqvdhljTUXdijpOm7OwN+QQ47sY/DhikEy9JpnuD8oIULJDx4035kE4y7Mrds2
         NV82FCbHcnFJ+MISJyfCnJOB6Dx6r8TvNqKeNH2ynFWSdsrYDd0TxrdCuGM3FzgPfjO2
         h6kW4DYy+NKmMVcAccg4jGLJC6axmXebtnId3w3uNdyL+YEw+fB1iejCVdfjZ0ulDxw5
         MLpQ==
X-Gm-Message-State: AC+VfDzbTijNsbjQw1eltBjzEQE8a61Fe1r8N6A9R55Ad4NRYHxF2HVq
        v2ayRsc0EvyiTwY0j0rQK7xg7n9H5sQCZi6GX7s=
X-Google-Smtp-Source: ACHHUZ7Hr+NNN8YO0/gt2hWGVWjb7XQrffZsu/IxO8xn0StMXDdH+Ezd1MRob72HQ3uK4lxg0hCzgUQAyPezhGGwETE=
X-Received: by 2002:a17:90b:38c8:b0:255:949b:b50d with SMTP id
 nn8-20020a17090b38c800b00255949bb50dmr3390020pjb.4.1684842286203; Tue, 23 May
 2023 04:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230523031933.13421-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20230523031933.13421-1-qiang.zhang1211@gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 23 May 2023 19:44:34 +0800
Message-ID: <CALm+0cX+1B942PytjP9bBuq6SWUQfLG8yC9xZoZLDAubn0mFSw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix warning triggered when nr_running is
 checked in worker_enter_idle()
To:     tj@kernel.org, jiangshanlai@gmail.com, naresh.kamboju@linaro.org,
        qiang.zhang1211@gmail.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
>          ->pool->nr_running--;  (0)
>            ....
>        ->wq_worker_running()
>            ....
>            CPU0 by interrupt:
>            wq_worker_tick()
>            ->worker_set_flags(worker, WORKER_CPU_INTENSIVE);
>              ->pool->nr_running--;  (-1)
>              ->worker->flags |= WORKER_CPU_INTENSIVE;
>            ....
>          ->if (!(worker->flags & WORKER_NOT_RUNNING))
>            ->pool->nr_running++;    (will not execute)
>            ....
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
> This commit therefore add irq protection in wq_worker_running() to
> block timer tick modify nr_running.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230519/testrun/17078554/suite/boot/test/clang-nightly-lkftconfig/log
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/workqueue.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9c5c1cfa478f..f8d739fef311 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1060,10 +1060,9 @@ void wq_worker_running(struct task_struct *task)
>          * and leave with an unexpected pool->nr_running == 1 on the newly unbound
>          * pool. Protect against such race.
>          */
> -       preempt_disable();

Sorry, Here can still be interrupted by wq_worker_tick() before invoke
local_irq_disbale().
will resend v2.

> +       local_irq_disable();
>         if (!(worker->flags & WORKER_NOT_RUNNING))
>                 worker->pool->nr_running++;
> -       preempt_enable();
>
>         /*
>          * CPU intensive auto-detection cares about how long a work item hogged
> @@ -1072,6 +1071,7 @@ void wq_worker_running(struct task_struct *task)
>         worker->current_at = worker->task->se.sum_exec_runtime;
>
>         worker->sleeping = 0;
> +       local_irq_enable();
>  }
>
>  /**
> --
> 2.17.1
>
