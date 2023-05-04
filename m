Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967366F6F89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjEDQDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEDQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:03:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351BB46B9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:03:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f192c23fffso5247575e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683216206; x=1685808206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g77C5xMmDKhc9PT1zPm9Qa8o5cPlsilTSb8jO/iHRps=;
        b=at+kHsdzyTymlO32OXLqm6dvSB2+JHS58kdnj+8uBsBIqnKqG/ymVunQONRQjQmqwl
         vng/nu94RoBlAG+xLx87VauOASapekNDjQEvMF2c139cMagCb//cQLpnhoIs442FBpR7
         8DjSYBKJNOUpN8OfAwDImwMMvW8t4AlY7BGPpaulI6Hxyafq+irmNi/h9rI/PAreS/rI
         +Omf9w/SouiqMkeCPyc8Lu00GKR1w+5q14VWwQ4u3nRiXsY+H3LnH6Qs9oPMEX7O/JbN
         jwO5b/5pvxmeYM2K+doGpDenRU1fFuPUdAT1PQxGweNKDLLCO5s2rXe6Y8V/OPOpO2hr
         0DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683216206; x=1685808206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g77C5xMmDKhc9PT1zPm9Qa8o5cPlsilTSb8jO/iHRps=;
        b=MjIMz5ZOg7UnmU9+uQAe/YpEWTPi1MaaDiXBd7xYcUHEqFkwC4WPvK1qJ5To7kusTd
         m5NcJ2RbljtHAzlrRtu/NhB4JtiDlFWVqJN51ELmpV7LB1jkDrStrS8foJgHOJBwkWau
         7qgJoHRvVd/7L69k2HkjHWPIKZsRrB+xRFiaao7Q/i//IzOmOrZAvAAd3vbfzCKYeDs1
         ekhRknx2/qrJ1D/FSkAtwhH+aR/YDlYNwf/e8oZNurGI1j1WUkEQIA8SPjcWeVXWG4JG
         57dmP/UR1DShUWxZJ0Q44+IEbpkvlcJwuDrFXPjBt1qaXnTj5MEFYl92xjirzf28rON3
         gPww==
X-Gm-Message-State: AC+VfDxE3PC7k/MzNTyiyD7c9dTwIwFzg4GdEf26kn8P2Ci/d6cUVw8Z
        buFPClh48fq1DjJXRrvfAs2Tmw==
X-Google-Smtp-Source: ACHHUZ4nIMNyilxtTVi1ejMvFuZ3licfizBOc+5uF4l/dQnLQj4AdWKqPQGY6zl1z50J8oK+l1PV5g==
X-Received: by 2002:a7b:c399:0:b0:3f1:6527:df05 with SMTP id s25-20020a7bc399000000b003f16527df05mr113017wmj.22.1683216206328;
        Thu, 04 May 2023 09:03:26 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:cd60:e249:480d:9183])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003f173419e7asm5269958wme.43.2023.05.04.09.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:03:25 -0700 (PDT)
Date:   Thu, 4 May 2023 18:03:21 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH 2/2] sched/core: Avoid double calling
 update_rq_clock()
Message-ID: <ZFPXSbjA7EQe4M1G@vingu-book>
References: <20230410081206.23441-1-jiahao.os@bytedance.com>
 <20230410081206.23441-3-jiahao.os@bytedance.com>
 <CAKfTPtDaG12qb4piQahJNNrEgAM3ouTKCzHA8BsAAYg015Ggpw@mail.gmail.com>
 <28cacb73-73d7-778a-24ca-9053702f6af7@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28cacb73-73d7-778a-24ca-9053702f6af7@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 02 mai 2023 à 18:22:56 (+0800), Hao Jia a écrit :
> 
> 
> On 2023/4/21 Vincent Guittot wrote:
> > On Mon, 10 Apr 2023 at 10:12, Hao Jia <jiahao.os@bytedance.com> wrote:
> > > 
> > > There are some double rq clock update warnings are triggered.
> > > ------------[ cut here ]------------
> > > rq->clock_update_flags & RQCF_UPDATED
> > > WARNING: CPU: 17 PID: 138 at kernel/sched/core.c:741
> > > update_rq_clock+0xaf/0x180
> > > Call Trace:
> > >   <TASK>
> > >   __balance_push_cpu_stop+0x146/0x180
> > >   ? migration_cpu_stop+0x2a0/0x2a0
> > >   cpu_stopper_thread+0xa3/0x140
> > >   smpboot_thread_fn+0x14f/0x210
> > >   ? sort_range+0x20/0x20
> > >   kthread+0xe6/0x110
> > >   ? kthread_complete_and_exit+0x20/0x20
> > >   ret_from_fork+0x1f/0x30
> > > 
> > > ------------[ cut here ]------------
> > > rq->clock_update_flags & RQCF_UPDATED
> > > WARNING: CPU: 54 PID: 0 at kernel/sched/core.c:741
> > > update_rq_clock+0xaf/0x180
> > > Call Trace:
> > >   <TASK>
> > >   unthrottle_cfs_rq+0x4b/0x300
> > >   __cfsb_csd_unthrottle+0xe0/0x100
> > >   __flush_smp_call_function_queue+0xaf/0x1d0
> > >   flush_smp_call_function_queue+0x49/0x90
> > >   do_idle+0x17c/0x270
> > >   cpu_startup_entry+0x19/0x20
> > >   start_secondary+0xfa/0x120
> > >   secondary_startup_64_no_verify+0xce/0xdb
> > > 
> > > ------------[ cut here ]------------
> > > rq->clock_update_flags & RQCF_UPDATED
> > > WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
> > > update_rq_clock+0xaf/0x180
> > > Call Trace:
> > >   <TASK>
> > >   unthrottle_cfs_rq+0x4b/0x300
> > >   rq_offline_fair+0x89/0x90
> > >   set_rq_offline.part.118+0x28/0x60
> > 
> > So this is generated by patch 1, isn't it ?
> 
> Sorry for the late reply, I just got back from a long term.
> 
> IIRC, this is not generated by patch1.

yeah, that's in the cfs loop

> 
> In the unthrottle_offline_cfs_rqs() function, we traverse task_groups
> through list_for_each_entry_rcu, so unthrottle_cfs_rq() may be called
> multiple times, resulting in multiple updates to the rq clock.
> 
> Thanks,
> Hao
> > 
> > >   rq_attach_root+0xc4/0xd0
> > >   cpu_attach_domain+0x3dc/0x7f0
> > >   partition_sched_domains_locked+0x2a5/0x3c0
> > >   rebuild_sched_domains_locked+0x477/0x830
> > >   rebuild_sched_domains+0x1b/0x30
> > >   cpuset_hotplug_workfn+0x2ca/0xc90
> > >   ? balance_push+0x56/0xf0
> > >   ? _raw_spin_unlock+0x15/0x30
> > >   ? finish_task_switch+0x98/0x2f0
> > >   ? __switch_to+0x291/0x410
> > >   ? __schedule+0x65e/0x1310
> > >   process_one_work+0x1bc/0x3d0
> > >   worker_thread+0x4c/0x380
> > >   ? preempt_count_add+0x92/0xa0
> > >   ? rescuer_thread+0x310/0x310
> > >   kthread+0xe6/0x110
> > >   ? kthread_complete_and_exit+0x20/0x20
> > >   ret_from_fork+0x1f/0x30
> > > 
> > > For the __balance_push_cpu_stop() case, we remove update_rq_clock() from
> > > the __migrate_task() function to avoid double updating the rq clock.
> > > And in order to avoid missing rq clock update, add update_rq_clock()
> > > call before migration_cpu_stop() calls __migrate_task().

Can we do the opposite ?
AFAICT, update_rq_clock() in __balance_push_cpu_stop() is only there for
__migrate_task(). I prefer to keep the update_rq_clock() as close as possible
to the user

> > > 
> > > This also works for unthrottle_cfs_rq(), so we also removed
> > > update_rq_clock() from the unthrottle_cfs_rq() function to avoid
> > > warnings caused by calling it multiple times, such as
> > > __cfsb_csd_unthrottle() and unthrottle_offline_cfs_rqs(). and

This happens with the for loop added by
commit: 8ad075c2eb1f ("sched: Async unthrottling for cfs bandwidth")

> > > in order to avoid missing rq clock update, we correspondingly add
> > > update_rq_clock() calls before unthrottle_cfs_rq() runs.

These are special cases that happen because of the for_each.
As said above, I would prefer keeping update_rq_clock close the their user

could we use something similar to rq_clock_skip_update() for those list ?

Something like the below:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 898fa3bc2765..7495b6fb229d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9386,8 +9386,6 @@ static int __balance_push_cpu_stop(void *arg)
        raw_spin_lock_irq(&p->pi_lock);
        rq_lock(rq, &rf);

-       update_rq_clock(rq);
-
        if (task_rq(p) == rq && task_on_rq_queued(p)) {
                cpu = select_fallback_rq(rq->cpu, p);
                rq = __migrate_task(rq, &rf, p, cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 503b7617d7e1..a1d47d907360 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5518,6 +5518,12 @@ static void __cfsb_csd_unthrottle(void *arg)
        struct rq_flags rf;

        rq_lock(rq, &rf);
+       /*
+        * Iterating over the list can trigger several call to update_rq_clock.
+        * Do it once and skip the potential next ones.
+        */
+       update_rq_clock(rq);
+       rq_clock_loop_update(rq);

        /*
         * Since we hold rq lock we're safe from concurrent manipulation of
@@ -6058,6 +6064,13 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)

        lockdep_assert_rq_held(rq);

+       /*
+        * Iterating over the list can trigger several call to update_rq_clock.
+        * Do it once and skip the potential next ones.
+        */
+       update_rq_clock(rq);
+       rq_clock_loop_update(rq);
+
        rcu_read_lock();
        list_for_each_entry_rcu(tg, &task_groups, list) {
                struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 66bacd50d381..681924367891 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1536,6 +1536,19 @@ static inline void rq_clock_skip_update(struct rq *rq)
        rq->clock_update_flags |= RQCF_REQ_SKIP;
 }

+/*
+ * During cpu offlining and rq wide unthrottling, we can trigger
+ * an update_rq_clock() for several cfs and rt runqueues (Typically
+ * when using list_for_each_entry_*)
+ * rq_clock_loop_update() can be called after updating the clock once
+ * and before iterating over the list to prevent multiple update.
+ */
+static inline void rq_clock_loop_update(struct rq *rq)
+{
+       lockdep_assert_rq_held(rq);
+       rq->clock_update_flags |= RQCF_ACT_SKIP;
+}
+
 /*
  * See rt task throttling, which is the only time a skip
  * request is canceled.


> > > 
> > > Note that the rq clock has been updated before the set_rq_offline()
> > > function runs, so we don't need to add update_rq_clock() call in
> > > unthrottle_offline_cfs_rqs().
> > > 
> 
> 
> 
