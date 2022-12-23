Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37720655121
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiLWN5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:57:38 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD6C1CB08
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:57:36 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NdpYk4jKFzJpFF;
        Fri, 23 Dec 2022 21:53:46 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 23 Dec 2022 21:57:34 +0800
Message-ID: <df6135b6-7710-2fec-baea-4eaa5c63bf28@huawei.com>
Date:   Fri, 23 Dec 2022 21:57:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/22 20:45, Peter Zijlstra 写道:
> On Wed, Dec 21, 2022 at 11:19:31PM +0800, Zhang Qiao wrote:
>> hi folks,
>>
>>     I found problem about s64 overflow in max_vruntime().
>>
>>     I create a task group GROUPA (path: /system.slice/xxx/yyy/CGROUPA) and run a task in this
>> group on each cpu, these tasks is while loop and 100% cpu usage.
>>
>>     When unregister net devices, will queue a kwork on system_highpri_wq at flush_all_backlogs()
>> and wake up a high-priority kworker thread on each cpu. However, the kworker thread has been
>> waiting on the queue and has not been scheduled.
>>
>>     After parsing the vmcore, the vruntime of the kworker is 0x918fdb05287da7c3 and the
>> cfs_rq->min_vruntime is 0x124b17fd59db8d02.
>>
>>     why the difference between the cfs_rq->min_vruntime and kworker's vruntime is so large?
>>     1) the kworker of the system_highpri_wq sleep for long long time(about 300 days).
>>     2) cfs_rq->curr is the ancestor of the GROUPA, cfs->curr->load.weight is 2494, so when
>> the task belonging to the GROUPA run for a long time, its vruntime will increase by 420
>> times, cfs_rq->min_vruntime will also grow rapidly.
>>     3) when wakeup kworker thread, kworker will be set the maximum value between kworker's
>> vruntime and cfs_rq->min_vruntime. But at max_vruntime(), there will be a s64 overflow issue,
>> as follow:
>>
>> ---------
>>
>> static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
>> {
>> 	/*
>> 	 * vruntime=0x124b17fd59db8d02
>> 	 * min_vruntime=0x918fdb05287da7c3
>> 	 * vruntime - min_vruntime = 9276074894177461567 > s64_max, will s64 overflow
>> 	 */
>> 	s64 delta = (s64)(vruntime - min_vruntime);
>> 	if (delta < 0)
>> 		min_vruntime = vruntime;
>>
>> 	return min_vruntime;
>> }
>>
>> ----------
>>
>> max_vruntime() will return the kworker's old vruntime, it is incorrect and the correct result
>> shoud be cfs_rq->minvruntime. This incorrect result is greater than cfs_rq->min_vruntime and
>> will cause kworker thread starved.
>>
>>     Does anyone have a good suggestion for slove this problem? or bugfix patch.
> 
> I don't understand what you tihnk the problem is. Signed overflow is
> perfectly fine and works as designed here.

hi, Peter and Waiman,

This problem occurs in the production environment that deploy some dpdk services. When this probelm
occurs, the system will be unavailable(for example, many commands about network will be stuck)，so
i think it's a problem.

Because most network commands(such as "ip") require rtnl_mutex, but the rtnl_mutex's onwer is waiting for
the the kworker of the system_highpri_wq at flush_all_backlogs(), util this highpri kworker finished
flush the network packets.

However, this highpri kworker has been sleeping for long, the difference between the kworker's vruntime
and cfs_rq->min_vruntime is so big, when waking up it, it will be set its old vruntime due to s64 overflow
at max_vruntime(). Because the incorrect vruntime, the kworker might not be scheduled.

Is it necessary to deal with this problem in kernel?
If necessary, for fix this problem, when a tasks is sleeping long enough, we set its vruntime as
cfs_rq->min_vruntime when wakeup it, avoid the s64 overflow issue at max_vruntime, as follow:


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e16e9f0124b0..89df8d7bae66 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4336,10 +4336,14 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #endif
 }

+/* when a task sleep over 200 days, it's vruntime will be set as cfs_rq->min_vruntime. */
+#define WAKEUP_REINIT_THRESHOLD_NS     (200LL * 24 * 3600 * NSEC_PER_SEC)
+
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
        u64 vruntime = cfs_rq->min_vruntime;
+       struct rq *rq = rq_of(cfs_rq);

        /*
         * The 'current' period is already promised to the current tasks,
@@ -4364,8 +4368,11 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
                vruntime -= thresh;
        }

-       /* ensure we never gain time by being placed backwards. */
-       se->vruntime = max_vruntime(se->vruntime, vruntime);
+       if (unlikely(!initial && (s64)(rq_clock_task(rq) - se->exec_start) > WAKEUP_REINIT_THRESHOLD_NS))
+               se->vruntime = vruntime;
+       else
+               /* ensure we never gain time by being placed backwards. */
+               se->vruntime = max_vruntime(se->vruntime, vruntime);
 }

 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);



> 
> .
> 
