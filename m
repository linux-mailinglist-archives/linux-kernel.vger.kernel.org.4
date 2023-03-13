Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF76B8033
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCMSRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMSRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:17:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C32957C9EF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:17:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB32D4B3;
        Mon, 13 Mar 2023 11:17:57 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AD403F67D;
        Mon, 13 Mar 2023 11:17:12 -0700 (PDT)
Message-ID: <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com>
Date:   Mon, 13 Mar 2023 19:17:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Content-Language: en-US
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net>
 <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
In-Reply-To: <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 10:06, Dietmar Eggemann wrote:
> On 10/03/2023 15:29, Vincent Guittot wrote:
>> Le jeudi 09 mars 2023 ï¿½ 16:14:38 (+0100), Vincent Guittot a ï¿½crit :
>>> On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>> On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
>>>>> On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:

[...]

> Looks to me that this patch brings back the old numbers:
> 
> model name	: Intel(R) Xeon(R) Silver 4314 CPU @ 2.40GHz
> 
> perf stat --null --repeat 10 -- perf bench sched messaging -g 50 -l 5000
> 
> tip sched/core
> 
> a2e90611b9f4 - sched/fair: Remove capacity inversion detection
> (2023-02-11 Vincent Guittot)
> 
>   5.7295 +- 0.0219 seconds time elapsed  ( +-  0.38% )
> 
> 829c1651e9c4 - sched/fair: sanitize vruntime of entity being placed
> (2023-02-11 Zhang Qiao)
> 
>   6.0961 +- 0.0297 seconds time elapsed  ( +-  0.49% )
> 
> this patch on top 829c1651e9c4
> 
>   5.7165 +- 0.0231 seconds time elapsed  ( +-  0.40% )
> 
> [...]

Couldn't we not just defer setting `se->exec_start = 0` until the end of
place_entity() for ENQUEUE_MIGRATED instead to avoid this extra se flag
`migrated`?

-->8--

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0c70c558b12c..4df2b3e76b30 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -550,7 +550,6 @@ struct sched_entity {
        struct rb_node                  run_node;
        struct list_head                group_node;
        unsigned int                    on_rq;
-       unsigned int                    migrated;
 
        u64                             exec_start;
        u64                             sum_exec_runtime;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8aa8cd3c745..365ee548e9f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1057,7 +1057,6 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
        /*
         * We are starting a new run period:
         */
-       se->migrated = 0;
        se->exec_start = rq_clock_task(rq_of(cfs_rq));
 }
 
@@ -4649,8 +4648,8 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #endif
 }
 
-static void
-place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
+static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
+                        int flags, int initial)
 {
        u64 vruntime = cfs_rq->min_vruntime;
        u64 sleep_time;
@@ -4705,6 +4704,9 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
                se->vruntime = vruntime;
        else
                se->vruntime = max_vruntime(se->vruntime, vruntime);
+
+       if (flags & ENQUEUE_MIGRATED)
+               se->exec_start = 0;
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
@@ -4780,7 +4782,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
        account_entity_enqueue(cfs_rq, se);
 
        if (flags & ENQUEUE_WAKEUP)
-               place_entity(cfs_rq, se, 0);
+               place_entity(cfs_rq, se, flags, 0);
 
        check_schedstat_required();
        update_stats_enqueue_fair(cfs_rq, se, flags);
@@ -7668,9 +7670,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
        /* Tell new CPU we are migrated */
        se->avg.last_update_time = 0;
 
-       /* We have migrated, no longer consider this task hot */
-       se->migrated = 1;
-
        update_scan_period(p, new_cpu);
 }
 
@@ -8355,9 +8354,6 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
        if (sysctl_sched_migration_cost == 0)
                return 0;
 
-       if (p->se.migrated)
-               return 0;
-
        delta = rq_clock_task(env->src_rq) - p->se.exec_start;
 
        return delta < (s64)sysctl_sched_migration_cost;
@@ -11999,7 +11995,7 @@ static void task_fork_fair(struct task_struct *p)
                update_curr(cfs_rq);
                se->vruntime = curr->vruntime;
        }
-       place_entity(cfs_rq, se, 1);
+       place_entity(cfs_rq, se, 0, 1);
 
        if (sysctl_sched_child_runs_first && curr && entity_before(curr, se)) {
                /*
@@ -12144,7 +12140,7 @@ static void detach_task_cfs_rq(struct task_struct *p)
                 * Fix up our vruntime so that the current sleep doesn't
                 * cause 'unlimited' sleep bonus.
                 */
-               place_entity(cfs_rq, se, 0);
+               place_entity(cfs_rq, se, 0, 0);
                se->vruntime -= cfs_rq->min_vruntime;
        }


