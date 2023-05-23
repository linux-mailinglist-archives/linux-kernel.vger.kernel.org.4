Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EC670DACA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbjEWKqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjEWKqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:46:12 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1ECFD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:46:10 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-783eb20d96cso2401361241.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684838768; x=1687430768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xdTEzdz4s8gaM6GZPylU3voq2R/tog3ouCgnxTKH+p0=;
        b=nc8VTvvouaTH4YpqGURfop8p31BEv3pVHWcTYtp2IE89Iez4BwbVpOixlh8v2cDmJA
         LvxXT1meU98WGn0MXU8+myQZmVjVcTYLN53RIHLiR3w/1DSbIgHOyKFGW+6iStghNf+7
         aIX+RRd2/3nSXa+ILNW3JUgOkTcxtfEOSdDA04vWNuqY2EsEgkag/kcvFUTF0HcAS2e1
         iYMag4KVubN7BGzTGXc94pu2hIhPEZlz4kiYqRGFdN5cYgIQecQQQwz6tTolHAGCwepV
         1ayDXMEG4jVAVbk3r61clwZV4d/3BCN/VG95cT6g1D9ubBhDxw9s2WJU+wPG44MBIvIz
         ufKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684838768; x=1687430768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdTEzdz4s8gaM6GZPylU3voq2R/tog3ouCgnxTKH+p0=;
        b=OkAlb/V3SRDg/KKQRzfdAaVcMBSwfUZNf58GO3d/XsN0YhVPAEF2IbjBiO3Sro2IjQ
         ngJkTlboD4TFARwj4qlVCHfZ7YwXNmNQ2pcMTR2cHeUcsLZAMI92ItwIv6vBBND+sx0a
         F7c7mCRJNia9WaXxLj5LC+Nmbylneu9N/MGuM59IucU8TJt0lg/Tutov14M1+twcn82Q
         Be4jn65If6fu5IgGVIdOCow5k/PhckjPE6qRgHTkjD2Cn8Q8kKtu753MNi37gChEYDrH
         93GRR/ubJ5F+kuc46l/Yd+Voi0qlFIjqSfKC5DoRcq5N6oNp6xeomRQQTLe41H2wY8Zf
         U4pA==
X-Gm-Message-State: AC+VfDwbDXGtdT4j2mSc7ePTVfQiROS1epkwpnSvzNKNpOyYPEac6bWX
        0h3YCoSQrE/P179AAxZcpqBVRscSiY1gN9Zc8tmEZQ==
X-Google-Smtp-Source: ACHHUZ58RmQPx5uVh0pl/tOMHbUZtpeh/padztHN4HjPKvT8Rh30z8jgOJn40MWg0I7JWipCrjeYlIy5NCB5OVfsqd8=
X-Received: by 2002:a1f:ec46:0:b0:44f:94da:c32e with SMTP id
 k67-20020a1fec46000000b0044f94dac32emr4101120vkh.12.1684838767904; Tue, 23
 May 2023 03:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230523031933.13421-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20230523031933.13421-1-qiang.zhang1211@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 May 2023 16:15:56 +0530
Message-ID: <CA+G9fYvdv4wJiE=Eb=daswxMybQ7Ui11-p8i+eRKUrpdfQEnJw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix warning triggered when nr_running is
 checked in worker_enter_idle()
To:     Zqiang <qiang.zhang1211@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zqiang,

On Tue, 23 May 2023 at 08:49, Zqiang <qiang.zhang1211@gmail.com> wrote:
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

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>


This proposed fix patch applied on top of Linux next and tested
for more than 100 times and reported issues has been fixed.

Thank you.

- Naresh

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
