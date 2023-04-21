Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1A6EABFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjDUNpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDUNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:44:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E814E4B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:44:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b5490c6f0so1992539a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682084686; x=1684676686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOuUvGYa1UY7aV7SDI82JrZqTwaMJovJYXLXCJsoqaY=;
        b=Ven6OvEm3yGyfd415NbqzUDqeUaje9Pw9UV+0yMmzKnGCou6giojsgwyFsuHPtmEnq
         NgF9xcRLvUdmOZYFVY8p8xrsfbq0hU9EEJJxsis3VFiCjWfcBHUl4NRLwpVlLkn1Qr/u
         9PDQEGW/M04Umq1ZtC/Jqx+w/d8lNJaYWK71RqYKJfdNKNQyIsA2wl6C+FqWW5zvUupc
         j1Lukzt1VLxusm0ElhGTYPGWTbVF0ABypfNbFxRJJb9lxYgHtQSTAhU+4T/uPjaZg3rH
         5/Mmn43G+JTt6lC9FpGdsT8wj7pTUvgxCjGkTI9DrDlajAlALUauy1BGOgs07xg4HAwo
         Y0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682084686; x=1684676686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOuUvGYa1UY7aV7SDI82JrZqTwaMJovJYXLXCJsoqaY=;
        b=g25tBSw1EI5UMaUOF1TZwXrnieTXE69te+3WpKxTenvHJu3bMrZjGmjB1V5eR0s/ZK
         JWPJH0edz4h+o5OaGO+JoIeVca+SdJT9C5IILYllZwNQ6aM0ouIDklgmt9R0idHJ+mvZ
         eSJkr2l2JmRKBS5bIsf9CBoMaTCWh0gXOeWQYosQ0C++uSKkE1JWTJojwTINpYi1Opeq
         DMnPp1PFZWqmXgYTd8aSiVdxqwAmXJNNanfp3ZmcmuP3kM3MMqNUaSzcp5cuW8JlldPI
         1NWnMYrhLG552IUo7vG+2qRMrs4qYuikLUSsoVkUNx4hFKaKz1HC/RoZz8zpF1q0e2Cy
         B7Eg==
X-Gm-Message-State: AAQBX9cHwebNgtHJT0dah/kMZFys/tfVCR70SWcZ/WXAmbeRL7t162W6
        vU1ZF3VxT957qX9K8pJcoMGIxaPfgpk8ktRpqwqTZQ==
X-Google-Smtp-Source: AKy350bZGEbr7NzA4yB7Y30WbAnF8N2CCkCSCXBRQmpYW2zCtsxiyJndezqWFID6sXsAfvYkTQAOQnox2HPZ1OXZGPI=
X-Received: by 2002:a17:90a:ff91:b0:23b:38b2:f0bd with SMTP id
 hf17-20020a17090aff9100b0023b38b2f0bdmr5302216pjb.15.1682084685872; Fri, 21
 Apr 2023 06:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230410081206.23441-1-jiahao.os@bytedance.com> <20230410081206.23441-3-jiahao.os@bytedance.com>
In-Reply-To: <20230410081206.23441-3-jiahao.os@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Apr 2023 15:44:34 +0200
Message-ID: <CAKfTPtDaG12qb4piQahJNNrEgAM3ouTKCzHA8BsAAYg015Ggpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/core: Avoid double calling update_rq_clock()
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
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

On Mon, 10 Apr 2023 at 10:12, Hao Jia <jiahao.os@bytedance.com> wrote:
>
> There are some double rq clock update warnings are triggered.
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 17 PID: 138 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  __balance_push_cpu_stop+0x146/0x180
>  ? migration_cpu_stop+0x2a0/0x2a0
>  cpu_stopper_thread+0xa3/0x140
>  smpboot_thread_fn+0x14f/0x210
>  ? sort_range+0x20/0x20
>  kthread+0xe6/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 54 PID: 0 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  unthrottle_cfs_rq+0x4b/0x300
>  __cfsb_csd_unthrottle+0xe0/0x100
>  __flush_smp_call_function_queue+0xaf/0x1d0
>  flush_smp_call_function_queue+0x49/0x90
>  do_idle+0x17c/0x270
>  cpu_startup_entry+0x19/0x20
>  start_secondary+0xfa/0x120
>  secondary_startup_64_no_verify+0xce/0xdb
>
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  unthrottle_cfs_rq+0x4b/0x300
>  rq_offline_fair+0x89/0x90
>  set_rq_offline.part.118+0x28/0x60

So this is generated by patch 1, isn't it ?

>  rq_attach_root+0xc4/0xd0
>  cpu_attach_domain+0x3dc/0x7f0
>  partition_sched_domains_locked+0x2a5/0x3c0
>  rebuild_sched_domains_locked+0x477/0x830
>  rebuild_sched_domains+0x1b/0x30
>  cpuset_hotplug_workfn+0x2ca/0xc90
>  ? balance_push+0x56/0xf0
>  ? _raw_spin_unlock+0x15/0x30
>  ? finish_task_switch+0x98/0x2f0
>  ? __switch_to+0x291/0x410
>  ? __schedule+0x65e/0x1310
>  process_one_work+0x1bc/0x3d0
>  worker_thread+0x4c/0x380
>  ? preempt_count_add+0x92/0xa0
>  ? rescuer_thread+0x310/0x310
>  kthread+0xe6/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>
> For the __balance_push_cpu_stop() case, we remove update_rq_clock() from
> the __migrate_task() function to avoid double updating the rq clock.
> And in order to avoid missing rq clock update, add update_rq_clock()
> call before migration_cpu_stop() calls __migrate_task().
>
> This also works for unthrottle_cfs_rq(), so we also removed
> update_rq_clock() from the unthrottle_cfs_rq() function to avoid
> warnings caused by calling it multiple times, such as
> __cfsb_csd_unthrottle() and unthrottle_offline_cfs_rqs(). and
> in order to avoid missing rq clock update, we correspondingly add
> update_rq_clock() calls before unthrottle_cfs_rq() runs.
>
> Note that the rq clock has been updated before the set_rq_offline()
> function runs, so we don't need to add update_rq_clock() call in
> unthrottle_offline_cfs_rqs().
>
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> ---
>  kernel/sched/core.c | 11 +++++++----
>  kernel/sched/fair.c |  9 ++++++---
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0d18c3969f90..c1abd88ec1ed 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2376,7 +2376,6 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
>         if (!is_cpu_allowed(p, dest_cpu))
>                 return rq;
>
> -       update_rq_clock(rq);
>         rq = move_queued_task(rq, rf, p, dest_cpu);
>
>         return rq;
> @@ -2434,10 +2433,12 @@ static int migration_cpu_stop(void *data)
>                                 goto out;
>                 }
>
> -               if (task_on_rq_queued(p))
> +               if (task_on_rq_queued(p)) {
> +                       update_rq_clock(rq);
>                         rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
> -               else
> +               } else {
>                         p->wake_cpu = arg->dest_cpu;
> +               }
>
>                 /*
>                  * XXX __migrate_task() can fail, at which point we might end
> @@ -10759,8 +10760,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>                 cfs_rq->runtime_enabled = runtime_enabled;
>                 cfs_rq->runtime_remaining = 0;
>
> -               if (cfs_rq->throttled)
> +               if (cfs_rq->throttled) {
> +                       update_rq_clock(rq);
>                         unthrottle_cfs_rq(cfs_rq);
> +               }
>                 rq_unlock_irq(rq, &rf);
>         }
>         if (runtime_was_enabled && !runtime_enabled)
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6986ea31c984..03ced34e992e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5438,8 +5438,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>
>         cfs_rq->throttled = 0;
>
> -       update_rq_clock(rq);
> -
>         raw_spin_lock(&cfs_b->lock);
>         cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
>         list_del_rcu(&cfs_rq->throttled_list);
> @@ -5518,6 +5516,7 @@ static void __cfsb_csd_unthrottle(void *arg)
>         struct rq_flags rf;
>
>         rq_lock(rq, &rf);
> +       update_rq_clock(rq);
>
>         /*
>          * Since we hold rq lock we're safe from concurrent manipulation of
> @@ -5547,6 +5546,7 @@ static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
>         bool first;
>
>         if (rq == this_rq()) {
> +               update_rq_clock(rq);
>                 unthrottle_cfs_rq(cfs_rq);
>                 return;
>         }
> @@ -5563,6 +5563,7 @@ static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
>  #else
>  static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
>  {
> +       update_rq_clock(rq_of(cfs_rq));
>         unthrottle_cfs_rq(cfs_rq);
>  }
>  #endif
> @@ -5640,8 +5641,10 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
>         if (local_unthrottle) {
>                 rq = cpu_rq(this_cpu);
>                 rq_lock_irqsave(rq, &rf);
> -               if (cfs_rq_throttled(local_unthrottle))
> +               if (cfs_rq_throttled(local_unthrottle)) {
> +                       update_rq_clock(rq);
>                         unthrottle_cfs_rq(local_unthrottle);
> +               }
>                 rq_unlock_irqrestore(rq, &rf);
>         }
>
> --
> 2.37.0
>
