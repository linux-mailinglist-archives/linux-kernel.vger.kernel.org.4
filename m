Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61D6A7DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCBJgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCBJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:36:20 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D76D38660
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:36:16 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PS5Wf09jhz16NxT;
        Thu,  2 Mar 2023 17:33:34 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 17:36:13 +0800
Message-ID: <1cd19d3f-18c4-92f9-257a-378cc18cfbc7@huawei.com>
Date:   Thu, 2 Mar 2023 17:36:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
To:     Vincent Guittot <vincent.guittot@linaro.org>
References: <20230209193107.1432770-1-rkagan@amazon.de>
 <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
 <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtCDxdVEmPQf=6g7n7Y+bkozXAJT1NG92wDc_quNaDiHMg@mail.gmail.com>
 <Y/xtDWYTKLutOqrM@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtAq3yBYBxpR=RO8zxrQduOymqkdAEhigjfCuGfsY1uHsg@mail.gmail.com>
CC:     Roman Kagan <rkagan@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <CAKfTPtAq3yBYBxpR=RO8zxrQduOymqkdAEhigjfCuGfsY1uHsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/2/27 22:37, Vincent Guittot 写道:
> On Mon, 27 Feb 2023 at 09:43, Roman Kagan <rkagan@amazon.de> wrote:
>>
>> On Tue, Feb 21, 2023 at 06:26:11PM +0100, Vincent Guittot wrote:
>>> On Tue, 21 Feb 2023 at 17:57, Roman Kagan <rkagan@amazon.de> wrote:
>>>> What scares me, though, is that I've got a message from the test robot
>>>> that this commit drammatically affected hackbench results, see the quote
>>>> below.  I expected the commit not to affect any benchmarks.
>>>>
>>>> Any idea what could have caused this change?
>>>
>>> Hmm, It's most probably because se->exec_start is reset after a
>>> migration and the condition becomes true for newly migrated task
>>> whereas its vruntime should be after min_vruntime.
>>>
>>> We have missed this condition
>>
>> Makes sense to me.
>>
>> But what would then be the reliable way to detect a sched_entity which
>> has slept for long and risks overflowing in .vruntime comparison?
> 
> For now I don't have a better idea than adding the same check in
> migrate_task_rq_fair()

Hi, Vincent，
I fixed this condition as you said, and the test results are as follows.

testcase: hackbench -g 44 -f 20 --process --pipe -l 60000 -s 100
version1: v6.2
version2: v6.2 + commit 829c1651e9c4
version3: v6.2 + commit 829c1651e9c4 + this patch

-------------------------------------------------
	version1	version2	version3
test1	81.0 		118.1 		82.1
test2	82.1 		116.9 		80.3
test3	83.2 		103.9 		83.3
avg(s)	82.1 		113.0 		81.9

-------------------------------------------------
After deal with the task migration case, the hackbench result has restored.

The patch as follow, how does this look?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff4dbbae3b10..3a88d20fd29e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4648,6 +4648,26 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #endif
 }

+static inline u64 sched_sleeper_credit(struct sched_entity *se)
+{
+
+       unsigned long thresh;
+
+       if (se_is_idle(se))
+               thresh = sysctl_sched_min_granularity;
+       else
+               thresh = sysctl_sched_latency;
+
+       /*
+        * Halve their sleep time's effect, to allow
+        * for a gentler effect of sleepers:
+        */
+       if (sched_feat(GENTLE_FAIR_SLEEPERS))
+               thresh >>= 1;
+
+       return thresh;
+}
+
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
@@ -4664,23 +4684,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
                vruntime += sched_vslice(cfs_rq, se);

        /* sleeps up to a single latency don't count. */
-       if (!initial) {
-               unsigned long thresh;
-
-               if (se_is_idle(se))
-                       thresh = sysctl_sched_min_granularity;
-               else
-                       thresh = sysctl_sched_latency;
-
-               /*
-                * Halve their sleep time's effect, to allow
-                * for a gentler effect of sleepers:
-                */
-               if (sched_feat(GENTLE_FAIR_SLEEPERS))
-                       thresh >>= 1;
-
-               vruntime -= thresh;
-       }
+       if (!initial)
+               vruntime -= sched_sleeper_credit(se);

        /*
         * Pull vruntime of the entity being placed to the base level of
@@ -4690,7 +4695,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
         * inversed due to s64 overflow.
         */
        sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
-       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
+       if (se->exec_start != 0 && (s64)sleep_time > 60LL * NSEC_PER_SEC)
                se->vruntime = vruntime;
        else
                se->vruntime = max_vruntime(se->vruntime, vruntime);
@@ -7634,8 +7639,12 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
         */
        if (READ_ONCE(p->__state) == TASK_WAKING) {
                struct cfs_rq *cfs_rq = cfs_rq_of(se);
+               u64 sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;

-               se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
+               if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
+                       se->vruntime = -sched_sleeper_credit(se);
+               else
+                       se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
        }

        if (!task_on_rq_migrating(p)) {



Thanks.
Zhang Qiao.

> 
>>
>> Thanks,
>> Roman.
>>
>>
>>
>> Amazon Development Center Germany GmbH
>> Krausenstr. 38
>> 10117 Berlin
>> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
>> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
>> Sitz: Berlin
>> Ust-ID: DE 289 237 879
>>
>>
>>
> .
> 
