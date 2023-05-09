Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199686FCB47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjEIQ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:26:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A14210
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:26:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6436e004954so6299785b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683649611; x=1686241611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQrqhqUBIXv7HSbRNg3AyrnGFHGqI4R6PzL64+leruQ=;
        b=dAb8fER36vjJVRGOEobNg7WgEQcTB7z1OwZy8ZeqJIDy0Snlz0ZP2PnIfIDGZKRioQ
         YecRk/lyVILmEWIvBQtHpduFKn7XbCaoUKL4YK9wo0bFPORftIS83hXQlZS4eXy4NB1G
         JkiWtQZd1zCXFYZAdh6XD3Hm5myVP4lU4yTXcD/ZOClhIDJuOIhCwxESnj5EpLzem4aI
         qq6oF3G2bVH00rcZuApjv7kei9eZG+yllTZJZS1MFDVB+eSs+K0fGzDO0EAHrQrVq2ej
         OGj8vwh/Njz9hn1fX1ulf/LGT9W/TJFvIwLzleN/kMBb5xtOmI31ghOO9UnJiRQkbQHk
         3J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683649611; x=1686241611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQrqhqUBIXv7HSbRNg3AyrnGFHGqI4R6PzL64+leruQ=;
        b=gK+wuMDIHL+01P1+6yVnqBXol6DoseOVo8gZYAfZJn0DXp/kxcfzexftDtEPX6548x
         klxhw7KXk+at0TKcKAvPZEuK2uHKRfGtnQrGhiuWpMNHaOZu0JFqQdUbxVT+BcTfaR6J
         SoGZOPzZylJ0jABjkLTBCZVE9Fe4qH8ENHhVchz7XFKYXh2kr+GegqfbgumXniqLhVA4
         ny3Dc2P+AIOMawrtw8oEgQ6bxy5AV6ecXW7FHUjVTu8Q22rdnU/tBWpsP3nIxoDltUfY
         gLmy+odnamFn/4J0zQh3P7mMLcMCA3PXRibrdp8Pi998YKaMheNRquQrJjp77cyFLKjF
         YA5A==
X-Gm-Message-State: AC+VfDyEiMJVlcMbBwYDqIw178+tEh/dyzHqFHzLIzYcIGfw3bY0HaIC
        tHoPqTq0xYcpRJEbTjm7M0aZZg/9FBQudf9KvR/lCQ==
X-Google-Smtp-Source: ACHHUZ7vrUKjUYDcHs6X2O42psRtTMTg+CmzJ2Rb5HGUkWBgLvJVrzjl9U/z/e1UeZKtAjHBNYhUtjc3NSXlY+P2KDU=
X-Received: by 2002:a05:6a20:914a:b0:ef:f659:8623 with SMTP id
 x10-20020a056a20914a00b000eff6598623mr19851043pzc.21.1683649611462; Tue, 09
 May 2023 09:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230410081206.23441-1-jiahao.os@bytedance.com>
 <20230410081206.23441-3-jiahao.os@bytedance.com> <CAKfTPtDaG12qb4piQahJNNrEgAM3ouTKCzHA8BsAAYg015Ggpw@mail.gmail.com>
 <28cacb73-73d7-778a-24ca-9053702f6af7@bytedance.com> <ZFPXSbjA7EQe4M1G@vingu-book>
 <140948e1-63d5-1647-9911-181abbe6bd2f@bytedance.com>
In-Reply-To: <140948e1-63d5-1647-9911-181abbe6bd2f@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 May 2023 18:26:40 +0200
Message-ID: <CAKfTPtAvuOrJVr1p58Pf0+r86ctGfZtsuJZeJgUji5tAdjb0BA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/2] sched/core: Avoid double calling update_rq_clock()
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

On Fri, 5 May 2023 at 14:13, Hao Jia <jiahao.os@bytedance.com> wrote:
>
>
>
> On 2023/5/5 Vincent Guittot wrote:
>
> >>>>    rq_attach_root+0xc4/0xd0
> >>>>    cpu_attach_domain+0x3dc/0x7f0
> >>>>    partition_sched_domains_locked+0x2a5/0x3c0
> >>>>    rebuild_sched_domains_locked+0x477/0x830
> >>>>    rebuild_sched_domains+0x1b/0x30
> >>>>    cpuset_hotplug_workfn+0x2ca/0xc90
> >>>>    ? balance_push+0x56/0xf0
> >>>>    ? _raw_spin_unlock+0x15/0x30
> >>>>    ? finish_task_switch+0x98/0x2f0
> >>>>    ? __switch_to+0x291/0x410
> >>>>    ? __schedule+0x65e/0x1310
> >>>>    process_one_work+0x1bc/0x3d0
> >>>>    worker_thread+0x4c/0x380
> >>>>    ? preempt_count_add+0x92/0xa0
> >>>>    ? rescuer_thread+0x310/0x310
> >>>>    kthread+0xe6/0x110
> >>>>    ? kthread_complete_and_exit+0x20/0x20
> >>>>    ret_from_fork+0x1f/0x30
> >>>>
> >>>> For the __balance_push_cpu_stop() case, we remove update_rq_clock() from
> >>>> the __migrate_task() function to avoid double updating the rq clock.
> >>>> And in order to avoid missing rq clock update, add update_rq_clock()
> >>>> call before migration_cpu_stop() calls __migrate_task().
> >
> > Can we do the opposite ?
> > AFAICT, update_rq_clock() in __balance_push_cpu_stop() is only there for
> > __migrate_task(). I prefer to keep the update_rq_clock() as close as possible
> > to the user
>
> I'm afraid not, the rq clock also needs to be updated before
> select_fallback_rq() is called.

yes you're right

>
>
> >
> >>>>
> >>>> This also works for unthrottle_cfs_rq(), so we also removed
> >>>> update_rq_clock() from the unthrottle_cfs_rq() function to avoid
> >>>> warnings caused by calling it multiple times, such as
> >>>> __cfsb_csd_unthrottle() and unthrottle_offline_cfs_rqs(). and
> >
> > This happens with the for loop added by
> > commit: 8ad075c2eb1f ("sched: Async unthrottling for cfs bandwidth")
> >
>
> Yes, the warning caused by this commit.
>
> >>>> in order to avoid missing rq clock update, we correspondingly add
> >>>> update_rq_clock() calls before unthrottle_cfs_rq() runs.
> >
> > These are special cases that happen because of the for_each.
> > As said above, I would prefer keeping update_rq_clock close the their user
> >
> > could we use something similar to rq_clock_skip_update() for those list ?
> >
>
> I try to do it with the method you provided. Some things maybe like this?
>
> We also need to clear RQCF_ACT_SKIP after calling rq_clock_loop_update()
> to avoid some warnings.
>
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index efdab1489113..f48b5d912d8c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2420,7 +2420,6 @@ static struct rq *__migrate_task(struct rq *rq,
> struct rq_flags *rf,
>          if (!is_cpu_allowed(p, dest_cpu))
>                  return rq;
>
> -       update_rq_clock(rq);
>          rq = move_queued_task(rq, rf, p, dest_cpu);
>
>          return rq;
> @@ -2478,10 +2477,12 @@ static int migration_cpu_stop(void *data)
>                                  goto out;
>                  }
>
> -               if (task_on_rq_queued(p))
> +               if (task_on_rq_queued(p)) {
> +                       update_rq_clock(rq);
>                          rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
> -               else
> +               } else {
>                          p->wake_cpu = arg->dest_cpu;
> +               }
>
>                  /*
>                   * XXX __migrate_task() can fail, at which point we
> might end
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..1dcef273bebe 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5575,6 +5575,13 @@ static void __cfsb_csd_unthrottle(void *arg)
>          struct rq_flags rf;
>
>          rq_lock(rq, &rf);
> +       /*
> +        * Iterating over the list can trigger several call to
> update_rq_clock()
> +        * in unthrottle_cfs_rq().
> +        * Do it once and skip the potential next ones.
> +        */
> +       update_rq_clock(rq);
> +       rq_clock_loop_update(rq);
>
>          /*
>           * Since we hold rq lock we're safe from concurrent manipulation of
> @@ -5595,6 +5602,7 @@ static void __cfsb_csd_unthrottle(void *arg)
>
>          rcu_read_unlock();
>
> +       rq_clock_cancel_loop_update(rq);
>          rq_unlock(rq, &rf);
>   }
>
> @@ -6114,6 +6122,12 @@ static void __maybe_unused
> unthrottle_offline_cfs_rqs(struct rq *rq)
>          struct task_group *tg;
>
>          lockdep_assert_rq_held(rq);
> +       /*
> +        * The rq clock has already been updated before the
> +        * set_rq_offline() runs, so we should skip updating
> +        * the rq clock again in unthrottle_cfs_rq().
> +        */
> +       rq_clock_loop_update(rq);
>
>          rcu_read_lock();
>          list_for_each_entry_rcu(tg, &task_groups, list) {
> @@ -6137,6 +6151,7 @@ static void __maybe_unused
> unthrottle_offline_cfs_rqs(struct rq *rq)
>                          unthrottle_cfs_rq(cfs_rq);
>          }
>          rcu_read_unlock();
> +       rq_clock_cancel_loop_update(rq);
>   }
>
>   #else /* CONFIG_CFS_BANDWIDTH */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ec7b3e0a2b20..3d4981d354a9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1536,6 +1536,25 @@ static inline void rq_clock_skip_update(struct rq
> *rq)
>          rq->clock_update_flags |= RQCF_REQ_SKIP;
>   }
>
> +/*
> + * During cpu offlining and rq wide unthrottling, we can trigger
> + * an update_rq_clock() for several cfs and rt runqueues (Typically
> + * when using list_for_each_entry_*)
> + * rq_clock_loop_update() can be called after updating the clock once
> + * and before iterating over the list to prevent multiple update.
> + */
> +static inline void rq_clock_loop_update(struct rq *rq)

maybe use rq_clock_start_loop_update

> +{
> +       lockdep_assert_rq_held(rq);
> +       rq->clock_update_flags |= RQCF_ACT_SKIP;
> +}
> +
> +static inline void rq_clock_cancel_loop_update(struct rq *rq)

and rq_clock_stop_loop_update here

> +{
> +       lockdep_assert_rq_held(rq);
> +       rq->clock_update_flags &= ~RQCF_ACT_SKIP;
> +}
> +
>   /*
>    * See rt task throttling, which is the only time a skip
