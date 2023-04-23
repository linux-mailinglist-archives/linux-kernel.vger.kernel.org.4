Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8F96EBC99
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 05:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjDWDXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 23:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWDXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 23:23:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B436C1986
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 20:23:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2471214cdd3so2326793a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 20:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682220221; x=1684812221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQw/RXBRI4iijeNa7gxmqJ2SwQ6c2Jk7nBS5K6sS+PM=;
        b=HdCv7FJA8aV0c+UaECTX3vMGkcK8fMlNrwgOnBjI6cH+WjFxOPVWq4i/4rnJJer4Np
         mGAXaK4obfw5hvD82/36SXhSZTpGrxBha3Trj4z73bEeODxVGe8clsxQMqYzjQ1YbEDs
         nTjZ51CrNoEr3IM+zTCxITC0OZGztrgQNtDE4Y1ShjMIYgYNeQ+yGFRf278ZZhA2+Noj
         y9hVqMaql+Vy2BacopUmmyd/W+OQIsVdaF8yS/E/JuYZwjibKU++hr32yvVUeGRrIteB
         rkatcApj2uBlAH+UHV5C7dYJa9GDrFue1Iq7zKENSMI0exPbRv3/BvbLeV+7uSkIYZ0a
         UIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682220221; x=1684812221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQw/RXBRI4iijeNa7gxmqJ2SwQ6c2Jk7nBS5K6sS+PM=;
        b=l0c1d5O6GBjydJSzOa7jPZvhq0iIpXehutyHtfkq/AzIzLnCuhafzc5uDAy/bYwiHJ
         0aCgZHpfuXuJBKFRPQgmrdLmJLRApIoXP9OHGDqYCN7hpa+uaooT0dLdRQM3wUe9mDXB
         iWHNEgL4WRlKi75bx77eT/8e4wGp7W5bca/AQp456FNQ91XnCsEZj5SoDhr4PJRngkOz
         szM36ytOm/9JNMvI1RmTjFvmMTeetU0Y3U7ggBGYc9aPAiMeC6VjZq01siBKNNXrt/g/
         Ii/U+wqcnBJIZY/gKvk55Zo2chCUWmCLyNV+rLclxGRXwpeGGxOR6s4I/07DjugvVEU/
         +LIw==
X-Gm-Message-State: AAQBX9cwsyPd2dCfb+xA/1HO8POAgth2fif3C20hL44u0lf1lOT1rpl/
        Ckoi6bUy8eB+KB521ciPNyVenrbLHEmNKs9VG9ElS3njkCo=
X-Google-Smtp-Source: AKy350byjVH89EM5YB+LNJmVsKH1BbMNmYCPJWNgitSuC9pouIW+SCUpjK5gEfHUuMc6u24nfYC06Op6j/wtEJi0Gxk=
X-Received: by 2002:a17:90b:4381:b0:247:5352:69da with SMTP id
 in1-20020a17090b438100b00247535269damr5211395pjb.24.1682220221036; Sat, 22
 Apr 2023 20:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230418205159.724789-1-tj@kernel.org> <20230418205159.724789-5-tj@kernel.org>
In-Reply-To: <20230418205159.724789-5-tj@kernel.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sun, 23 Apr 2023 11:23:28 +0800
Message-ID: <CAJhGHyDWJAZj6AYKHpJvTPdRCZa7Yvi00x1n+AtRm1qa_2PmOw@mail.gmail.com>
Subject: Re: [PATCH 4/5] workqueue: Automatically mark CPU-hogging work items CPU_INTENSIVE
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 4:52=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> If a per-cpu work item hogs the CPU, it can prevent other work items from
> starting through concurrency management. A per-cpu workqueue which intend=
s
> to host such CPU-hogging work items can choose to not participate in
> concurrency management by setting %WQ_CPU_INTENSIVE; however, this can be
> error-prone and difficult to debug when missed.
>
> This patch adds an automatic CPU usage based detection. If a
> concurrency-managed work item consumes more CPU time than the threshold (=
5ms
> by default), it's marked CPU_INTENSIVE automatically on schedule-out.
>
> The mechanism isn't foolproof in that the 5ms detection delays can add up=
 if
> many CPU-hogging work items are queued at the same time. However, in such
> situations, the bigger problem likely is the CPU being saturated with
> per-cpu work items and the solution would be making them UNBOUND.
>
> For occasional CPU hogging, the new automatic mechanism should provide
> reasonable protection with minimal increase in code complexity.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> ---
>  kernel/workqueue.c          | 77 ++++++++++++++++++++++++++-----------
>  kernel/workqueue_internal.h |  1 +
>  2 files changed, 56 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index b9e8dc54272d..d24b887ddd86 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -306,6 +306,14 @@ static struct kmem_cache *pwq_cache;
>  static cpumask_var_t *wq_numa_possible_cpumask;
>                                         /* possible CPUs of each node */
>
> +/*
> + * Per-cpu work items which run for longer than the following threshold =
are
> + * automatically considered CPU intensive and excluded from concurrency
> + * management to prevent them from noticeably delaying other per-cpu wor=
k items.
> + */
> +static unsigned long wq_cpu_intensive_thresh_us =3D 5000;
> +module_param_named(cpu_intensive_thresh_us, wq_cpu_intensive_thresh_us, =
ulong, 0644);
> +
>  static bool wq_disable_numa;
>  module_param_named(disable_numa, wq_disable_numa, bool, 0444);
>
> @@ -951,9 +959,6 @@ void wq_worker_stopping(struct task_struct *task)
>         struct worker *worker =3D kthread_data(task);
>         struct worker_pool *pool;
>
> -       if (task_is_running(task))
> -               return;
> -
>         /*
>          * Rescuers, which may not have all the fields set up like normal
>          * workers, also reach here, let's not access anything before
> @@ -964,24 +969,49 @@ void wq_worker_stopping(struct task_struct *task)
>
>         pool =3D worker->pool;
>
> -       /* Return if preempted before wq_worker_running() was reached */
> -       if (worker->sleeping)
> -               return;
> +       if (task_is_running(task)) {
> +               /*
> +                * Concurrency-managed @worker is still RUNNING. See if t=
he
> +                * current work is hogging CPU stalling other per-cpu wor=
k
> +                * items. If so, mark @worker CPU_INTENSIVE to exclude it=
 from
> +                * concurrency management. @worker->current_* are stable =
as they
> +                * can only be modified by @task which is %current.

Hello

wq_worker_stopping() and sched_submit_work() are only called from
schedule() and are not called for other various kinds of scheduling,
such as schedule_rtlock(), preempt_schedule_*(), __cond_resched().

A work item hogging CPU may not call the bare schedule().  To make
the new wq_worker_stopping() works, it has to be added to other kinds
of scheduling, IMO.

Thanks
Lai
