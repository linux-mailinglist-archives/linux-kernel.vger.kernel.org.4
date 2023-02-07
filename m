Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AAA68D42F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjBGK36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjBGK3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:29:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A632E26CED
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:29:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6861D106F;
        Tue,  7 Feb 2023 02:30:27 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1A213F8C6;
        Tue,  7 Feb 2023 02:29:42 -0800 (PST)
Message-ID: <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
Date:   Tue, 7 Feb 2023 11:29:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qyousef@layalina.io>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 16:49, Peter Zijlstra wrote:
> On Tue, Nov 08, 2022 at 07:48:43PM +0000, Qais Yousef wrote:
>> On 11/07/22 14:41, Peter Zijlstra wrote:
>>> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:

[...]

> So one thing that was key to that hack I proposed is that it is
> per-task. This means we can either set or detect the task activation
> period and use that to select an appropriate PELT multiplier.
> 
> But please explain; once tasks are in a steady state (60HZ, 90HZ or god
> forbit higher), the utilization should be the same between the various
> PELT window sizes, provided the activation period isn't *much* larger
> than the window.
> 
> Are these things running a ton of single shot tasks or something daft
> like that?

This investigation tries to answer these questions. The results can
be found in chapter (B) and (C).

I ran 'util_est_faster' with delta equal to 'duration of the current 
activation'. I.e. the following patch is needed:

https://lkml.kernel.org/r/ec049fd9b635f76a9e1d1ad380fd9184ebeeca53.1671158588.git.yu.c.chen@intel.com 

The testcase is Jankbench on Android 12 on Pixel6, CPU orig capacity 
= [124 124 124 124 427 427 1024 1024], w/ mainline v5.18 kernel and 
forward ported task scheduler patches.

(A) *** 'util_est_faster' vs. 'scaled util_est_faster' ***

The initial approach didn't scale the runtime duration. It is based
on task clock and not PELT clock but it should be scaled by uArch
and frequency to align with the PELT time used for util tracking.

Although the original approach shows better results than the scaled 
one. Even more aggressive boosting on non-big CPUs helps to raise the 
frequency even quicker in the scenario described under (B). 

All tests ran 10 iterations of all Jankbench sub-tests.

Max_frame_duration:
+------------------------+------------+
|             kernel     |    value   |
+------------------------+------------+
|   base-a30b17f016b0    | 147.571352 |
|    util_est_faster     | 84.834999  |
| scaled_util_est_faster | 127.72855  |
+------------------------+------------+

Mean_frame_duration:
+------------------------+-------+-----------+
|             kernel     | value | perc_diff |
+------------------------+-------+-----------+
|   base-a30b17f016b0    | 14.7  |   0.0%    |
|    util_est_faster     | 12.6  |  -14.01%  |
| scaled_util_est_faster | 13.5  |  -8.45%   |
+------------------------+-------------------+

Jank percentage (Jank deadline 16ms):
+------------------------+-------+-----------+
|             kernel     | value | perc_diff |
+------------------------+-------+-----------+
|   base-a30b17f016b0    |  1.8  |   0.0%    |
|    util_est_faster     |  0.8  |  -57.8%   |
| scaled_util_est_faster |  1.4  |  -25.89%  |
+------------------------+-------+-----------+

Power usage [mW] (total - all CPUs):
+------------------------+-------+-----------+
|             kernel     | value | perc_diff |
+------------------------+-------+-----------+
|   base-a30b17f016b0    | 144.4 |   0.0%    |
|    util_est_faster     | 150.9 |   4.45%   |
| scaled_util_est_faster | 152.2 |   5.4%    |
+------------------------+-------+-----------+

'scaled util_est_faster' is used as the base for all following tests. 

(B) *** Where does util_est_faster help exactly? ***

It turns out that the score improvement comes from the more aggressive 
DVFS request ('_freq') (1) due to the CPU util boost in sugov_get_util() 
-> effective_cpu_util(..., cpu_util_cfs(), ...).

At the beginning of an episode (e.g. beginning of an image list view
fling) when the periodic tasks (~1/16ms (60Hz) at 'max uArch'/'max CPU
frequency') of the Android Graphics Pipeline (AGP) start to run, the
CPU Operating Performance Point (OPP) is often so low that those tasks
run more like 10/16ms which let the test application count a lot of
Jankframes at those moments.

And there is where this util_est_faster approach helps by boosting CPU
util according to the 'runtime of the current activation'.
Moreover it could also be that the tasks have simply more work to do in
these first activations at the beginning of an episode.

All the other places in which cpu_util_cfs() is used:

(2) CFS load balance ('_lb')
(3) CPU overutilization ('_ou')
(4) CFS fork/exec task placement ('_slowpath')

when tested individually don't show any improvement or even regression.

Max_frame_duration:
+---------------------------------+------------+
|             kernel              |    value   |
+---------------------------------+------------+
|     scaled_util_est_faster      | 127.72855  |
|   scaled_util_est_faster_freq   | 126.646506 |
|    scaled_util_est_faster_lb    | 162.596249 |
|    scaled_util_est_faster_ou    | 166.59519  |
| scaled_util_est_faster_slowpath | 153.966638 |
+---------------------------------+------------+

Mean_frame_duration:
+---------------------------------+-------+-----------+
|             kernel              | value | perc_diff |
+---------------------------------+-------+-----------+
|     scaled_util_est_faster      | 13.5  |   0.0%    |
|   scaled_util_est_faster_freq   | 13.7  |   1.79%   |
|    scaled_util_est_faster_lb    | 14.8  |   9.87%   |
|    scaled_util_est_faster_ou    | 14.5  |   7.46%   |
| scaled_util_est_faster_slowpath | 16.2  |  20.45%   |
+---------------------------------+-------+-----------+

Jank percentage (Jank deadline 16ms):
+---------------------------------+-------+-----------+
|             kernel              | value | perc_diff |
+---------------------------------+-------+-----------+
|     scaled_util_est_faster      |  1.4  |   0.0%    |
|   scaled_util_est_faster_freq   |  1.3  |  -2.34%   |
|    scaled_util_est_faster_lb    |  1.7  |  27.42%   |
|    scaled_util_est_faster_ou    |  2.1  |  50.33%   |
| scaled_util_est_faster_slowpath |  2.8  |  102.39%  |
+---------------------------------+-------+-----------+

Power usage [mW] (total - all CPUs):
+---------------------------------+-------+-----------+
|             kernel              | value | perc_diff |
+---------------------------------+-------+-----------+
|     scaled_util_est_faster      | 152.2 |   0.0%    |
|   scaled_util_est_faster_freq   | 132.3 |  -13.1%   |
|    scaled_util_est_faster_lb    | 137.1 |  -9.96%   |
|    scaled_util_est_faster_ou    | 132.4 |  -13.04%  |
| scaled_util_est_faster_slowpath | 141.3 |  -7.18%   |
+---------------------------------+-------+-----------+

(C) *** Which tasks contribute the most to the score improvement? ***

A trace_event capturing the cases in which task's util_est_fast trumps
CPU util was added to cpu_util_cfs(). This is 1 iteration of Jankbench
and the base is (1) 'scaled_util_est_faster_freq':

https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/util_est_faster_6.ipynb

'Cell [6]' shows the tasks of the Jankbench process
'[com.an]droid.benchmark' which are boosting the CPU frequency request.

Among them are 2 main threads of the AGP, '[com.an]droid.benchmark' and
'RenderThread'.
The spikes in util_est_fast are congruent with the aforementioned
beginning of an episode in which these periodic tasks are running and
when their runtime/period is rather ~10/16ms and not ~1-2/16ms since
the CPU OPP is still low. 

Very few other Jankbench tasks 'Cell [6] show the same behaviour. The
Surfaceflinger process 'Cell [8]' is not affected and from the kernel
tasks only kcompctd0 creates a mild boost 'Cell [9]'.

As expected, running a non-scaled version of (1) shows more aggressive 
boosting on non-big CPUs:

https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/util_est_faster_5.ipynb

Looks like that 'util_est_faster' can prevent Jankframes by boosting CPU
util when periodic tasks have a longer runtime compared to when they reach
steady-sate.

The results is very similar to PELT halflife reduction. The advantage is
that 'util_est_faster' is only activated selectively when the runtime of
the current task in its current activation is long enough to create this
CPU util boost.  

Original patch:
https://lkml.kernel.org/r/Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net

Changes applied:
- use 'duration of the current activation' as delta
- delta >>= 10
- uArch and frequency scaling of delta

-->%--

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index efdc29c42161..76d146d06bbe 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -97,6 +97,7 @@ SCHED_FEAT(WA_BIAS, true)
  */  
 SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
+SCHED_FEAT(UTIL_EST_FASTER, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 0f310768260c..13cd9e27ce3e 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -148,6 +148,22 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
        return periods;
 }
 
+/*
+ * Compute a pelt util_avg assuming no history and @delta runtime.
+ */
+unsigned long faster_est_approx(u64 delta)
+{
+       unsigned long contrib = (unsigned long)delta; /* p == 0 -> delta < 1024 */
+       u64 periods = delta / 1024;
+
+       if (periods) {
+               delta %= 1024;
+               contrib = __accumulate_pelt_segments(periods, 1024, delta);
+       }
+
+       return (contrib << SCHED_CAPACITY_SHIFT) / PELT_MIN_DIVIDER;
+}
+
 /*
  * We can represent the historical contribution to runnable average as the 
  * coefficients of a geometric series.  To do this we sub-divide our runnable
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1072502976df..7cb45f1d8062 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2961,6 +2961,8 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
        return READ_ONCE(rq->avg_dl.util_avg);
 }
 
+extern unsigned long faster_est_approx(u64 runtime);
+
 /** 
  * cpu_util_cfs() - Estimates the amount of CPU capacity used by CFS tasks.
  * @cpu: the CPU to get the utilization for.
@@ -2995,13 +2997,39 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
  */  
 static inline unsigned long cpu_util_cfs(int cpu)
 {
+       struct rq *rq = cpu_rq(cpu);
        struct cfs_rq *cfs_rq;
        unsigned long util;
 
-       cfs_rq = &cpu_rq(cpu)->cfs;
+       cfs_rq = &rq->cfs;
        util = READ_ONCE(cfs_rq->avg.util_avg);
 
        if (sched_feat(UTIL_EST)) {
+               if (sched_feat(UTIL_EST_FASTER)) {
+                       struct task_struct *curr;
+
+                       rcu_read_lock();
+                       curr = rcu_dereference(rq->curr);
+                       if (likely(curr->sched_class == &fair_sched_class)) {
+                               unsigned long util_est_fast;
+                               u64 delta;
+
+                               delta = curr->se.sum_exec_runtime -
+                                       curr->se.prev_sum_exec_runtime_vol;
+
+                               delta >>= 10;
+                               if (!delta)
+                                       goto unlock;
+
+                               delta = cap_scale(delta, arch_scale_cpu_capacity(cpu));
+                               delta = cap_scale(delta, arch_scale_freq_capacity(cpu));
+
+                               util_est_fast = faster_est_approx(delta * 2);
+                               util = max(util, util_est_fast);
+                       }
+unlock:
+                       rcu_read_unlock();
+               }
                util = max_t(unsigned long, util,
                             READ_ONCE(cfs_rq->avg.util_est.enqueued));
        }
