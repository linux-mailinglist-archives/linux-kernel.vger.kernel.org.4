Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372DE6F82BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjEEMOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjEEMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:14:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83244A9
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:13:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-643990c5319so1000894b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683288822; x=1685880822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPPnwS+gGPaq28WwhSna8FCrr8buoZKoYRGo6QsXgZo=;
        b=JHKeP75qjUYnVVkRSBMjkZxBLp8w9/z32ffdPfWwLljZBGeWgyPyyF4XKDZmkfwQuT
         oFJoMz7nZrnekb1W9SMsV9KU7HcIlLKkA1sH7N69s6AaEPsvNdS9yqQBycg1147EA6IY
         qGxxImzWd5J+4P4jgEFFXbA2fQqhl5mO/OTYiqkYGPL9Q1yDBImJ3J/oT/P06hRNYaTY
         6i9DetOzF53Zhp3QOSor8xEzQ865u5X+f22fPlifmCxWd6f6UhP7rljQ/4m1z7by3Eir
         QLTUqBMCWbXsDzM1HfZob6+O8doZyC4C3Y91RzuYcDFCzDKyVKkTh01aubDVW+QZwLDk
         +9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683288822; x=1685880822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SPPnwS+gGPaq28WwhSna8FCrr8buoZKoYRGo6QsXgZo=;
        b=F+gp9meoywle5ghv5vB3GeeW/cAqY225IVL0ZFVh2edQt9ZAJXKC1wRnYY3oXMFybt
         GAfOE1ehqVb6i1owbi6bzpUC3Opi9Dbwq0+E2SH3HlJlA+v6oYo+KZ2emquAOG5eHBCE
         E5SJz4iI2nGzfNzu39X3VSkQZ5VARj0eLCSFIEjEeT6ogo4CouAAjZcJS1XVbakHlmOv
         +gXN6quhu43xUcgDtXPG3bSYxu1pi3bnO8Wahf1FAcPQIq/o75IpBTETMSlV65TTIjak
         7UHLFAaE5YZVIkQsEcFLaowwUO7bqlN5Nfm7ZbhRHRHZU4MxkkluWu8Lc7vorJWors1F
         uUhA==
X-Gm-Message-State: AC+VfDwp1/tx9yXkl7SN3A+hWl/PAF1s0kJJZjBWqFYK3CloeH/m5DSl
        WlAnYbeULhk0alHgKTCVc8hdJQ==
X-Google-Smtp-Source: ACHHUZ6/ly1hmPPFPD5DjFYoK3bcxjL1JJBG0b8qpXr7RMTLwWpqDRAHEFtaoJRiuJkiXr9bVyAbnQ==
X-Received: by 2002:a05:6a00:10d3:b0:63b:5496:7afa with SMTP id d19-20020a056a0010d300b0063b54967afamr1967642pfu.11.1683288821600;
        Fri, 05 May 2023 05:13:41 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id j1-20020a62b601000000b0062dbafced27sm1548174pff.27.2023.05.05.05.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 05:13:41 -0700 (PDT)
Message-ID: <140948e1-63d5-1647-9911-181abbe6bd2f@bytedance.com>
Date:   Fri, 5 May 2023 20:13:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH 2/2] sched/core: Avoid double calling
 update_rq_clock()
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20230410081206.23441-1-jiahao.os@bytedance.com>
 <20230410081206.23441-3-jiahao.os@bytedance.com>
 <CAKfTPtDaG12qb4piQahJNNrEgAM3ouTKCzHA8BsAAYg015Ggpw@mail.gmail.com>
 <28cacb73-73d7-778a-24ca-9053702f6af7@bytedance.com>
 <ZFPXSbjA7EQe4M1G@vingu-book>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <ZFPXSbjA7EQe4M1G@vingu-book>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/5 Vincent Guittot wrote:

>>>>    rq_attach_root+0xc4/0xd0
>>>>    cpu_attach_domain+0x3dc/0x7f0
>>>>    partition_sched_domains_locked+0x2a5/0x3c0
>>>>    rebuild_sched_domains_locked+0x477/0x830
>>>>    rebuild_sched_domains+0x1b/0x30
>>>>    cpuset_hotplug_workfn+0x2ca/0xc90
>>>>    ? balance_push+0x56/0xf0
>>>>    ? _raw_spin_unlock+0x15/0x30
>>>>    ? finish_task_switch+0x98/0x2f0
>>>>    ? __switch_to+0x291/0x410
>>>>    ? __schedule+0x65e/0x1310
>>>>    process_one_work+0x1bc/0x3d0
>>>>    worker_thread+0x4c/0x380
>>>>    ? preempt_count_add+0x92/0xa0
>>>>    ? rescuer_thread+0x310/0x310
>>>>    kthread+0xe6/0x110
>>>>    ? kthread_complete_and_exit+0x20/0x20
>>>>    ret_from_fork+0x1f/0x30
>>>>
>>>> For the __balance_push_cpu_stop() case, we remove update_rq_clock() from
>>>> the __migrate_task() function to avoid double updating the rq clock.
>>>> And in order to avoid missing rq clock update, add update_rq_clock()
>>>> call before migration_cpu_stop() calls __migrate_task().
> 
> Can we do the opposite ?
> AFAICT, update_rq_clock() in __balance_push_cpu_stop() is only there for
> __migrate_task(). I prefer to keep the update_rq_clock() as close as possible
> to the user

I'm afraid not, the rq clock also needs to be updated before 
select_fallback_rq() is called.


> 
>>>>
>>>> This also works for unthrottle_cfs_rq(), so we also removed
>>>> update_rq_clock() from the unthrottle_cfs_rq() function to avoid
>>>> warnings caused by calling it multiple times, such as
>>>> __cfsb_csd_unthrottle() and unthrottle_offline_cfs_rqs(). and
> 
> This happens with the for loop added by
> commit: 8ad075c2eb1f ("sched: Async unthrottling for cfs bandwidth")
> 

Yes, the warning caused by this commit.

>>>> in order to avoid missing rq clock update, we correspondingly add
>>>> update_rq_clock() calls before unthrottle_cfs_rq() runs.
> 
> These are special cases that happen because of the for_each.
> As said above, I would prefer keeping update_rq_clock close the their user
> 
> could we use something similar to rq_clock_skip_update() for those list ?
> 

I try to do it with the method you provided. Some things maybe like this?

We also need to clear RQCF_ACT_SKIP after calling rq_clock_loop_update() 
to avoid some warnings.


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index efdab1489113..f48b5d912d8c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2420,7 +2420,6 @@ static struct rq *__migrate_task(struct rq *rq, 
struct rq_flags *rf,
         if (!is_cpu_allowed(p, dest_cpu))
                 return rq;

-       update_rq_clock(rq);
         rq = move_queued_task(rq, rf, p, dest_cpu);

         return rq;
@@ -2478,10 +2477,12 @@ static int migration_cpu_stop(void *data)
                                 goto out;
                 }

-               if (task_on_rq_queued(p))
+               if (task_on_rq_queued(p)) {
+                       update_rq_clock(rq);
                         rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
-               else
+               } else {
                         p->wake_cpu = arg->dest_cpu;
+               }

                 /*
                  * XXX __migrate_task() can fail, at which point we 
might end
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..1dcef273bebe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5575,6 +5575,13 @@ static void __cfsb_csd_unthrottle(void *arg)
         struct rq_flags rf;

         rq_lock(rq, &rf);
+       /*
+        * Iterating over the list can trigger several call to 
update_rq_clock()
+        * in unthrottle_cfs_rq().
+        * Do it once and skip the potential next ones.
+        */
+       update_rq_clock(rq);
+       rq_clock_loop_update(rq);

         /*
          * Since we hold rq lock we're safe from concurrent manipulation of
@@ -5595,6 +5602,7 @@ static void __cfsb_csd_unthrottle(void *arg)

         rcu_read_unlock();

+       rq_clock_cancel_loop_update(rq);
         rq_unlock(rq, &rf);
  }

@@ -6114,6 +6122,12 @@ static void __maybe_unused 
unthrottle_offline_cfs_rqs(struct rq *rq)
         struct task_group *tg;

         lockdep_assert_rq_held(rq);
+       /*
+        * The rq clock has already been updated before the
+        * set_rq_offline() runs, so we should skip updating
+        * the rq clock again in unthrottle_cfs_rq().
+        */
+       rq_clock_loop_update(rq);

         rcu_read_lock();
         list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -6137,6 +6151,7 @@ static void __maybe_unused 
unthrottle_offline_cfs_rqs(struct rq *rq)
                         unthrottle_cfs_rq(cfs_rq);
         }
         rcu_read_unlock();
+       rq_clock_cancel_loop_update(rq);
  }

  #else /* CONFIG_CFS_BANDWIDTH */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..3d4981d354a9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1536,6 +1536,25 @@ static inline void rq_clock_skip_update(struct rq 
*rq)
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
+static inline void rq_clock_cancel_loop_update(struct rq *rq)
+{
+       lockdep_assert_rq_held(rq);
+       rq->clock_update_flags &= ~RQCF_ACT_SKIP;
+}
+
  /*
   * See rt task throttling, which is the only time a skip
