Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7813A604DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJSQxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJSQxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:53:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FAE1CCCD2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:53:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v1so866246wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJqcUaEfyUZwn6pTiSS93/f/0FPtZ0fu3Eyg9YXfKqo=;
        b=WHed+CdKJvOUbRKXnKL3lHB9KS8cKZU+JzGE7y7rBgbyKaA/ybzeH0f5sSE5WqRLgs
         DNdDvoYQkcv4M5K15c8EQHIzB24p4KrU9YvaAsPrOnY40eu5bEoAq4e8pA/JjdZNk9Rh
         RF4inGeHh3XnfCT0Aie9xiBwPn2KCmIuEHzA5jHxljgk3mPvsEo6KhTvq9ygkTLWl/uN
         CCAM8oZuPrEmT6YpoXUSOTVrTg36/EDuBTbSPfl2qNZV5d3WZpFt6eGdXLtNNz9J4ToV
         y/5go5/quwHeQ/JbIgP/TRQKWX+MXKEmEY3Slb3rYRU+P5D56MKk1SoPX2JlvQZ+ZkA3
         1Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJqcUaEfyUZwn6pTiSS93/f/0FPtZ0fu3Eyg9YXfKqo=;
        b=SZyIddka+/U19R/rueld62wMzna7viNlD8hTN8oI7surB7OnCZ5JYcMDeAMA1ZuS5u
         U567FBkDevEeADfmgfFJ1AxCaxqoKL+ynTj0lyBYi4aqyIaNzlw4Wvs3VIzSNzVQ7V9m
         HQgKdkdRMOtGJe1hzthGRoYXaV5Z5iozhpETx78Tr0S7EBXPTAnWscKMIwf4abd5Rmfe
         vzoitXgxoMUaUegrBQlNDYyg0hpA0fp0PXDARvCDjRFF2aA388EoTRoZon+EH7OPVft4
         jYcrmucUosCJYz3IZbLU9aK8mKUE78SyZI64kjWhmLtaF9Uhqhpzr+NROzwRDNLcYFjo
         2BEw==
X-Gm-Message-State: ACrzQf2dVufDDLZ39ejd1sINt6+edEiqSusqle6Xo1CZ6wKy6jNAXiZc
        dNTjCwl+nrlq0m69DpTTFb0y7w==
X-Google-Smtp-Source: AMsMyM7xKOMopO3PAEg/ou7mAKzMePH7sQk+SYqvcvhxQK9ShAJRb29F3nMOVwNIvL4UFqcSHjcsQA==
X-Received: by 2002:a5d:4dd0:0:b0:22e:33dc:3bf3 with SMTP id f16-20020a5d4dd0000000b0022e33dc3bf3mr6007056wru.214.1666198413371;
        Wed, 19 Oct 2022 09:53:33 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:9591:f4e4:5cdb:f4fd])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a403954c3sm14443064wrt.42.2022.10.19.09.53.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Oct 2022 09:53:32 -0700 (PDT)
Date:   Wed, 19 Oct 2022 18:53:30 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Youssef Esmat <youssefesmat@chromium.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, joel@joelfernandes.org
Subject: Re: [PATCH v5 7/7] sched/fair: Add latency list
Message-ID: <20221019165330.GA13530@vingu-book>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-8-vincent.guittot@linaro.org>
 <CA+q576OoP6Ebax8aGM234JRf+WOJFEwChs25qB9M_rt7+r1wuA@mail.gmail.com>
 <CAKfTPtAh30v=XoJPvAeFxu274CDW0uf2UY4Z8ySJz123ko5xgw@mail.gmail.com>
 <CA+q576Po0bskXfBP3EXUGG9jFLAP66iH6EamXfPUg9LC6qQyCg@mail.gmail.com>
 <20221012152130.GA20993@vingu-book>
 <CA+q576N+NeKPTn7Ekw1rOcnA4+4PkGrw1mHD33SYTh=eAdHpsw@mail.gmail.com>
 <CAKfTPtCb4mxCJnX4JpYY7_3r-ZCHpT4j-4h+YcJyHcMLU7S1Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtCb4mxCJnX4JpYY7_3r-ZCHpT4j-4h+YcJyHcMLU7S1Vw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DIET_1,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 14 oct. 2022 � 17:22:35 (+0200), Vincent Guittot a �crit :
> On Thu, 13 Oct 2022 at 19:19, Youssef Esmat <youssefesmat@chromium.org> wrote:
> >
> > On Wed, Oct 12, 2022 at 10:21 AM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > Le mardi 11 oct. 2022 � 18:54:27 (-0500), Youssef Esmat a �crit :
> > > > Hi Vincent,
> > > >
> > > > On Tue, Oct 11, 2022 at 12:10 PM Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > >
> > > ...
> > >
> > > > > > >               latency 0    latency -20
> > > > > > > Min Latencies:    60           61
> > > > > > > Avg Latencies:  1077           86
> > > > > > > Max Latencies: 87311          444
> > > > > > > 50% latencies:    92           85
> > > > > > > 75% latencies:   554           90
> > > > > > > 85% latencies:  1019           93
> > > > > > > 90% latencies:  1346           96
> > > > > > > 95% latencies:  5400          100
> > > > > > > 99% latencies: 19044          110
> > > > > > >
> > > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > > ---
> > > > > >
> > > > > > The ability to boost the latency sensitivity of a task seems very
> > > > > > interesting. I have been playing around with these changes and have
> > > > > > some observations.
> > > > > >
> > > > > > I tried 2 bursty tasks affinitized to the same CPU. The tasks sleep
> > > > > > for 1ms and run for 10ms in a loop. I first tried it without adjusting
> > > > > > the latency_nice value and took perf sched traces:
> > > > >
> > > > > The CPU is overloaded almost all the time as it can't run the 2 tasks
> > > > > (2*10ms every 11ms)
> > > > >
> > > > > >
> > > > > > latency_test:7040     |   2447.137 ms |        8 | avg:   6.546 ms |
> > > > > > max:  10.674 ms | max start:   353.809487 s | max end:   353.820161 s
> > > > > > latency_test:7028     |   2454.777 ms |        7 | avg:   4.494 ms |
> > > > > > max:  10.609 ms | max start:   354.804386 s | max end:   354.814995 s
> > > > > >
> > > > > > Everything looked as expected, for a 5s run they had similar runtime
> > > > > > and latency.
> > > > > >
> > > > > > I then adjusted one task to have a latency_nice of -20 (pid 8614
> > > > > > below) and took another set of traces:
> > > > > >
> > > > > > latency_test:8618     |   1845.534 ms |      131 | avg:   9.764 ms |
> > > > > > max:  10.686 ms | max start:  1405.737905 s | max end:  1405.748592 s
> > > > > > latency_test:8614     |   3033.635 ms |       16 | avg:   3.559 ms |
> > > > > > max:  10.467 ms | max start:  1407.594751 s | max end:  1407.605218 s
> > > > > >
> > > > > > The task with -20 latency_nice had significantly more runtime. The
> > > > > > average latency was improved but the max roughly stayed the same. As
> > > > > > expected the one with latency_nice value of 0 experienced more
> > > > > > switches, but so did the one with latency_nice of -20.
> > > > >
> > > > > Your results look unexpected because the vruntime of the tasks is not
> > > > > modified. So I can imagine that the thread with the low latency runs
> > > > > first up to the offset at the beg of the test but then they should
> > > > > switch regularly. I have tried a similar test with a modified rt-app
> > > > > and the result seems ok. I have a small difference but not the
> > > > > difference that you see.
> > > > >
> > > > > Could you share more details about your setup ? I'm going to try to
> > > > > reproduce your sequence
> > > >
> > > > I was using an intel core i7 with this frequency details:
> > > > CPU MHz:                         4200.000
> > > > CPU max MHz:                  4800.0000
> > > > CPU min MHz:                   400.0000
> > > >
> > > > This is a snippet of the test I was using:
> > > >
> > > > struct sched_attr attr;
> > > > memset(&attr, 0, sizeof(struct sched_attr));
> > > > attr.size = sizeof(struct sched_attr);
> > > > attr.sched_latency_nice = nice_latency;
> > > > attr.sched_flags = SCHED_FLAG_LATENCY_NICE;
> > > >
> > > > // set nice latency value
> > > > int res = syscall(__NR_sched_setattr, 0, &attr, 0);
> > > >
> > > > while(1){
> > > >   // wake up every ms
> > > >   usleep(1000);
> > > >   for(int i = 0; i < 40000000; i++){}
> > > > }
> > >
> > > Between v2 and v3, the sched_feat(GENTLE_FAIR_SLEEPERS) has diseappeared when
> > > I moved the computation of latency_offset at the setting of the latency prio
> > > instead of runtime. As a result, the latency nice task can preempt up to
> > > (sysctl_sched_latency - sysctl_sched_wakeup_granularity) but other threads are
> > > cap to half of sysctl_sched_latency at wakeup.
> > >
> > > Could you try the patch below ?
> >
> > Thanks Vincent. That improved the runtime for the tests above.
> >
> > Running two bursty tasks (1ms sleep and 10ms running loop) one of
> > which had a latency_nice of -20 (pid 9209) and the other 0:
> >
> > latency_test:9205     |   2429.467 ms |       14 | avg:   6.293 ms |
> > max:  11.340 ms | max start:   209.543482 s | max end:   209.554821 s
> > latency_test:9209     |   2467.423 ms |       17 | avg:   3.346 ms |
> > max:  11.475 ms | max start:   208.374517 s | max end:   208.385992 s
> >
> > The task with -20 latency_nice had an improved average latency, but
> > the max roughly stayed the same.
> 
> This is expected because there is not enough cpu time to run both
> tasks in your UC. Task with -20 latency will run 1st whenever it has
> not used all its bandwidth but a some point, It will have to let the
> other task runs 1st to not get an unfair amount of cpu bandwidth
> 
> TL is task with -20 latency
> TO is the ther task
> 
> TO wakes up and start to run
> After 3ms TL wakes  up
> TL preempts TO because 3ms delta +12ms latency offset > 4ms
> sched_akeup_granularity
> TL  runs for 10ms then go to sleep
> TL  vruntime is +7ms vs TO
> TO starts to run
> 1ms later TL wakeup
> TL preempts TO because delta -6ms delta +12ms latency offset > 4ms
> sched_akeup_granularity
> TL  runs for 10ms then go to sleep
> TL  vruntime is +16ms vs TO
> TO starts to run
> 1ms later TL wakeup
> TL can't preempt TO because delta -15ms delta +12ms latency offset <
> 4ms sched_wakeup_granularity
> 
> TL has exhausted its cpu bandwidth and will wait like other cfs task
> 
> I will look more deeply on the use cases below

I have finally got time to look at the use cases. See my comment below

> 
> >
> > Running the same test with 3 bursty tasks, one of which had a
> > latency_nice of -20 and the other two with latency_nice = 0. The
> > results for this case roughly stayed the same after the changes:
> >
> > latency_test:26088    |   1641.458 ms |      158 | avg:  19.613 ms |
> > max:  33.000 ms | max start:   871.707231 s | max end:   871.740231 s
> > latency_test:26295    |   1639.766 ms |      238 | avg:  10.259 ms |
> > max:  24.289 ms | max start:   873.917231 s | max end:   873.941519 s
> > latency_test:26401    |   1643.580 ms |      241 | avg:  10.200 ms |
> > max:  22.124 ms | max start:   876.289233 s | max end:   876.311357 s
> >
> > The task with latency_nice -20 seemed to have the highest average and
> > max latencies.
> >
> > I also tried an additional test where we had a task that was cpu bound
> > (while(1){}) and a task that ran for 1ms and slept for 1ms. The cpu
> > bound task had the latency_nice value of -20 and the bursty had
> > latency_nice of 0.
> >
> > latency_test:17353    |   4557.699 ms |      356 | avg:   1.058 ms |
> > max:   1.181 ms | max start:  4324.806123 s | max end:  4324.807304 s
> > latency_test:17452    |    377.804 ms |        1 | avg:   0.000 ms |
> > max:   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
> >
> > The cpu bound task (pid 17353 above) had significantly more runtime.
> > If I reran the test with latency_nice = 0 for both:
> >
> > latency_test:20748    |   2478.014 ms |     2367 | avg:   1.037 ms |
> > max:   1.182 ms | max start:  4460.769240 s | max end:  4460.770423 s
> > latency_test:20972    |   2455.888 ms |        3 | avg:   0.001 ms |
> > max:   0.002 ms | max start:  4460.628756 s | max end:  4460.628758 s
> >
> > Would decreasing the latency_offset as the task runs and increasing it
> > as it sleeps help here?

In fact, the problem above is not only linked to latency nice and you can
face similar problem with nice priority. As an example, if the 2 tasks have
a nice priority of 5 (without latency nice prio), the task that runs 1ms then
sleep 1 ms, will get only a 1/8 of the bandwidth whereas it should get 50%.

The problem comes from the fact that a task that wakes up with a
vruntime == min_vruntime - sched_latency and doesn't preempt current, will
lose some bandwidth because its vruntime is already capped to the max oldest
vruntime and the new waiting time will be lost at next wakeup because
vrutime is capped at min_vruntime - sched_latency

The patch below fixes the problem for both:

---
 kernel/sched/fair.c  | 54 +++++++++++++++++++++++---------------------
 kernel/sched/sched.h | 19 ++++++++++++++++
 2 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d80fb154bb80..2c4a95633192 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4415,33 +4415,17 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = cfs_rq->min_vruntime;

-	/*
-	 * The 'current' period is already promised to the current tasks,
-	 * however the extra weight of the new task will slow them down a
-	 * little, place the new task so that it fits in the slot that
-	 * stays open at the end.
-	 */
-	if (initial && sched_feat(START_DEBIT))
-		vruntime += sched_vslice(cfs_rq, se);
-
-	/* sleeps up to a single latency don't count. */
-	if (!initial) {
-		unsigned long thresh;
-
-		if (se_is_idle(se))
-			thresh = sysctl_sched_min_granularity;
-		else
-			thresh = sysctl_sched_latency;
-
+	if (!initial)
+		/* sleeps up to a single latency don't count. */
+		vruntime -= get_sched_latency(se_is_idle(se));
+	else if (sched_feat(START_DEBIT))
 		/*
-		 * Halve their sleep time's effect, to allow
-		 * for a gentler effect of sleepers:
+		 * The 'current' period is already promised to the current tasks,
+		 * however the extra weight of the new task will slow them down a
+		 * little, place the new task so that it fits in the slot that
+		 * stays open at the end.
 		 */
-		if (sched_feat(GENTLE_FAIR_SLEEPERS))
-			thresh >>= 1;
-
-		vruntime -= thresh;
-	}
+		vruntime += sched_vslice(cfs_rq, se);

 	/* ensure we never gain time by being placed backwards. */
 	se->vruntime = max_vruntime(se->vruntime, vruntime);
@@ -7318,7 +7302,25 @@ static unsigned long wakeup_gran(struct sched_entity *se)
 static int
 wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 {
-	s64 gran, vdiff = curr->vruntime - se->vruntime;
+	struct cfs_rq *cfs_rq = cfs_rq_of(curr);
+	s64 min_vdiff, period, gran, vdiff;
+
+	min_vdiff = cfs_rq->min_vruntime - se->vruntime;
+
+	/*
+	 * At wake up, the vuntime of a task is updated to not be more older
+	 * than a sched_latency period behind the min_vruntime. This prevents
+	 * long sleeping task to get unlimited credit at wakeup.
+	 * Such waking up task should then preempt current to use it CPU
+	 * bandwidth.
+	 */
+	period = get_sched_latency(false);
+	period -= sysctl_sched_min_granularity;
+	if (min_vdiff >= period)
+		return 1;
+
+	/* Take into account latency priority */
+	vdiff = curr->vruntime - se->vruntime;

 	/* Take into account latency priority */
 	vdiff -= wakeup_latency_gran(curr, se);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76bca172585c..d1534a96f476 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2483,6 +2483,25 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 #endif

+static inline unsigned long  get_sched_latency(bool idle)
+{
+	unsigned long thresh;
+
+	if (idle)
+		thresh = sysctl_sched_min_granularity;
+	else
+		thresh = sysctl_sched_latency;
+
+	/*
+	 * Halve their sleep time's effect, to allow
+	 * for a gentler effect of sleepers:
+	 */
+	if (sched_feat(GENTLE_FAIR_SLEEPERS))
+		thresh >>= 1;
+
+	return thresh;
+}
+
 #ifdef CONFIG_SCHED_HRTICK

 /*
--
2.17.1


> >
> >
> > >
> > > ---
> > >  kernel/sched/core.c | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 8b44685ae247..68f9a83d7089 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1287,11 +1287,15 @@ static void set_load_weight(struct task_struct *p, bool update_load)
> > >  static void set_latency_offset(struct task_struct *p)
> > >  {
> > >         long weight = sched_latency_to_weight[p->latency_prio];
> > > +       unsigned long period = sysctl_sched_latency;
> > >         s64 offset;
> > >
> > > -       offset = sysctl_sched_latency * weight;
> > > +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > > +               period >>= 1;
> > > +       offset = period * weight;
> > >         offset = div_s64(offset, NICE_LATENCY_WEIGHT_MAX);
> > >         p->se.latency_offset = (long)offset;
> > > +       trace_printk("set_latency_offset pid %d offset %ld", p->pid, offset);
> > >  }
> > >
> > >  #ifdef CONFIG_UCLAMP_TASK
> > > @@ -10894,12 +10898,17 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
> > >  static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
> > >                                     struct cftype *cft)
> > >  {
> > > +       unsigned long period = sysctl_sched_latency;
> > >         int last_delta = INT_MAX;
> > >         int prio, delta;
> > >         s64 weight;
> > >
> > > +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > > +               period >>= 1;
> > > +
> > >         weight = css_tg(css)->latency_offset * NICE_LATENCY_WEIGHT_MAX;
> > > -       weight = div_s64(weight, sysctl_sched_latency);
> > > +       period = sysctl_sched_latency;
> > > +       weight = div_s64(weight, period);
> > >
> > >         /* Find the closest nice value to the current weight */
> > >         for (prio = 0; prio < ARRAY_SIZE(sched_latency_to_weight); prio++) {
> > > @@ -10915,6 +10924,7 @@ static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
> > >  static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
> > >                                      struct cftype *cft, s64 nice)
> > >  {
> > > +       unsigned long period;
> > >         s64 latency_offset;
> > >         long weight;
> > >         int idx;
> > > @@ -10926,7 +10936,10 @@ static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
> > >         idx = array_index_nospec(idx, LATENCY_NICE_WIDTH);
> > >         weight = sched_latency_to_weight[idx];
> > >
> > > -       latency_offset = sysctl_sched_latency * weight;
> > > +       period = sysctl_sched_latency;
> > > +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > > +               period >>= 1;
> > > +       latency_offset = period * weight;
> > >         latency_offset = div_s64(latency_offset, NICE_LATENCY_WEIGHT_MAX);
> > >
> > >         return sched_group_set_latency(css_tg(css), latency_offset);
> > > --
> > > 2.17.1
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Also tried running the same test but instead of using latency nice I
> > > > > > adjusted the nice value as a comparison. In that case one task had a
> > > > > > nice of -5 and the other was 0.
> > > > > >
> > > > > > nice_test:25219       |   1216.839 ms |      242 | avg:  10.295 ms |
> > > > > > max:  11.927 ms | max start:  5877.881279 s | max end:  5877.893206 s
> > > > > > nice_test:25235       |   3711.788 ms |        6 | avg:   1.026 ms |
> > > > > > max:   6.143 ms | max start:  5875.603741 s | max end:  5875.609883 s
> > > > > >
> > > > > > As expected the one with a nice value of -5 had more runtime but also
> > > > > > had better latency numbers than in the previous case of using
> > > > > > latency_nice.
> > > > > >
> > > > > > I also tried a similar test with 3 bursty tasks instead of two. In
> > > > > > this case all tasks had a latency_nice of 0:
> > > > > >
> > > > > > latency_test:11467    |   1641.131 ms |      161 | avg:  17.489 ms |
> > > > > > max:  21.011 ms | max start:  1542.656275 s | max end:  1542.677286 s
> > > > > > latency_test:11463    |   1644.809 ms |      161 | avg:  11.994 ms |
> > > > > > max:  25.012 ms | max start:  1545.657776 s | max end:  1545.682788 s
> > > > > > latency_test:11478    |   1643.211 ms |      160 | avg:  11.465 ms |
> > > > > > max:  21.012 ms | max start:  1546.159026 s | max end:  1546.180038 s
> > > > > >
> > > > > > Next I tried two tasks with a latency_nice of 0 and a third one had a
> > > > > > latency_nice of -20 (pid 11763 below):
> > > > > >
> > > > > > latency_test:11763    |   1645.482 ms |      159 | avg:  19.634 ms |
> > > > > > max:  31.016 ms | max start:  1623.834862 s | max end:  1623.865877 s
> > > > > > latency_test:11750    |   1644.276 ms |      259 | avg:   9.985 ms |
> > > > > > max:  21.012 ms | max start:  1623.953921 s | max end:  1623.974933 s
> > > > > > latency_test:11747    |   1642.745 ms |      262 | avg:   9.079 ms |
> > > > > > max:  25.013 ms | max start:  1620.980435 s | max end:  1621.005447 s
> > > > > >
> > > > > > In this case it seemed like the runtime was not affected by the
> > > > > > latency_nice value, but strangely the task with the latency nice of
> > > > > > -20 had a worse average and max latency than the other two. The
> > > > > > context switch times are also increased from the previous case.
> > > > > >
> > > > > > Have we considered an approach where the task that is marked as
> > > > > > latency sensitive gets a boosted nice value when it sleeps and is
> > > > > > either scaled down exponentially as it runs, or immediately reset to
> > > > > > its default when it runs for one tick?
> > > > > >
> > > > > > Thanks,
> > > > > > Youssef
> > > > > >
> > > > > >
> > > > > > >  include/linux/sched.h |  2 +
> > > > > > >  kernel/sched/fair.c   | 96 +++++++++++++++++++++++++++++++++++++++++--
> > > > > > >  kernel/sched/sched.h  |  1 +
> > > > > > >  3 files changed, 96 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > > > index a74cad08e91e..0b92674e3664 100644
> > > > > > > --- a/include/linux/sched.h
> > > > > > > +++ b/include/linux/sched.h
> > > > > > > @@ -547,6 +547,8 @@ struct sched_entity {
> > > > > > >         /* For load-balancing: */
> > > > > > >         struct load_weight              load;
> > > > > > >         struct rb_node                  run_node;
> > > > > > > +       struct rb_node                  latency_node;
> > > > > > > +       unsigned int                    on_latency;
> > > > > > >         struct list_head                group_node;
> > > > > > >         unsigned int                    on_rq;
> > > > > > >
> > > > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > > > index e524e892d118..1a72f34136d8 100644
> > > > > > > --- a/kernel/sched/fair.c
> > > > > > > +++ b/kernel/sched/fair.c
> > > > > > > @@ -664,7 +664,77 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
> > > > > > >
> > > > > > >         return __node_2_se(last);
> > > > > > >  }
> > > > > > > +#endif
> > > > > > >
> > > > > > > +/**************************************************************
> > > > > > > + * Scheduling class tree data structure manipulation methods:
> > > > > > > + * for latency
> > > > > > > + */
> > > > > > > +
> > > > > > > +static inline bool latency_before(struct sched_entity *a,
> > > > > > > +                               struct sched_entity *b)
> > > > > > > +{
> > > > > > > +       return (s64)(a->vruntime + a->latency_offset - b->vruntime - b->latency_offset) < 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +#define __latency_node_2_se(node) \
> > > > > > > +       rb_entry((node), struct sched_entity, latency_node)
> > > > > > > +
> > > > > > > +static inline bool __latency_less(struct rb_node *a, const struct rb_node *b)
> > > > > > > +{
> > > > > > > +       return latency_before(__latency_node_2_se(a), __latency_node_2_se(b));
> > > > > > > +}
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Enqueue an entity into the latency rb-tree:
> > > > > > > + */
> > > > > > > +static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > > > > > > +{
> > > > > > > +
> > > > > > > +       /* Only latency sensitive entity can be added to the list */
> > > > > > > +       if (se->latency_offset >= 0)
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       if (se->on_latency)
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * An execution time less than sysctl_sched_min_granularity means that
> > > > > > > +        * the entity has been preempted by a higher sched class or an entity
> > > > > > > +        * with higher latency constraint.
> > > > > > > +        * Put it back in the list so it gets a chance to run 1st during the
> > > > > > > +        * next slice.
> > > > > > > +        */
> > > > > > > +       if (!(flags & ENQUEUE_WAKEUP)) {
> > > > > > > +               u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> > > > > > > +
> > > > > > > +               if (delta_exec >= sysctl_sched_min_granularity)
> > > > > > > +                       return;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
> > > > > > > +       se->on_latency = 1;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void __dequeue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > > > > > +{
> > > > > > > +       if (se->on_latency) {
> > > > > > > +               rb_erase_cached(&se->latency_node, &cfs_rq->latency_timeline);
> > > > > > > +               se->on_latency = 0;
> > > > > > > +       }
> > > > > > > +}
> > > > > > > +
> > > > > > > +static struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
> > > > > > > +{
> > > > > > > +       struct rb_node *left = rb_first_cached(&cfs_rq->latency_timeline);
> > > > > > > +
> > > > > > > +       if (!left)
> > > > > > > +               return NULL;
> > > > > > > +
> > > > > > > +       return __latency_node_2_se(left);
> > > > > > > +}
> > > > > > > +
> > > > > > > +#ifdef CONFIG_SCHED_DEBUG
> > > > > > >  /**************************************************************
> > > > > > >   * Scheduling class statistics methods:
> > > > > > >   */
> > > > > > > @@ -4455,8 +4525,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > > > > > >         check_schedstat_required();
> > > > > > >         update_stats_enqueue_fair(cfs_rq, se, flags);
> > > > > > >         check_spread(cfs_rq, se);
> > > > > > > -       if (!curr)
> > > > > > > +       if (!curr) {
> > > > > > >                 __enqueue_entity(cfs_rq, se);
> > > > > > > +               __enqueue_latency(cfs_rq, se, flags);
> > > > > > > +       }
> > > > > > >         se->on_rq = 1;
> > > > > > >
> > > > > > >         if (cfs_rq->nr_running == 1) {
> > > > > > > @@ -4542,8 +4614,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > > > > > >
> > > > > > >         clear_buddies(cfs_rq, se);
> > > > > > >
> > > > > > > -       if (se != cfs_rq->curr)
> > > > > > > +       if (se != cfs_rq->curr) {
> > > > > > >                 __dequeue_entity(cfs_rq, se);
> > > > > > > +               __dequeue_latency(cfs_rq, se);
> > > > > > > +       }
> > > > > > >         se->on_rq = 0;
> > > > > > >         account_entity_dequeue(cfs_rq, se);
> > > > > > >
> > > > > > > @@ -4631,6 +4705,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > > > > >                  */
> > > > > > >                 update_stats_wait_end_fair(cfs_rq, se);
> > > > > > >                 __dequeue_entity(cfs_rq, se);
> > > > > > > +               __dequeue_latency(cfs_rq, se);
> > > > > > >                 update_load_avg(cfs_rq, se, UPDATE_TG);
> > > > > > >         }
> > > > > > >
> > > > > > > @@ -4669,7 +4744,7 @@ static struct sched_entity *
> > > > > > >  pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > > > > > >  {
> > > > > > >         struct sched_entity *left = __pick_first_entity(cfs_rq);
> > > > > > > -       struct sched_entity *se;
> > > > > > > +       struct sched_entity *latency, *se;
> > > > > > >
> > > > > > >         /*
> > > > > > >          * If curr is set we have to see if its left of the leftmost entity
> > > > > > > @@ -4711,6 +4786,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > > > > > >                 se = cfs_rq->last;
> > > > > > >         }
> > > > > > >
> > > > > > > +       /* Check for latency sensitive entity waiting for running */
> > > > > > > +       latency = __pick_first_latency(cfs_rq);
> > > > > > > +       if (latency && (latency != se) &&
> > > > > > > +           wakeup_preempt_entity(latency, se) < 1)
> > > > > > > +               se = latency;
> > > > > > > +
> > > > > > >         return se;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -4734,6 +4815,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
> > > > > > >                 update_stats_wait_start_fair(cfs_rq, prev);
> > > > > > >                 /* Put 'current' back into the tree. */
> > > > > > >                 __enqueue_entity(cfs_rq, prev);
> > > > > > > +               __enqueue_latency(cfs_rq, prev, 0);
> > > > > > >                 /* in !on_rq case, update occurred at dequeue */
> > > > > > >                 update_load_avg(cfs_rq, prev, 0);
> > > > > > >         }
> > > > > > > @@ -11717,6 +11799,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> > > > > > >  void init_cfs_rq(struct cfs_rq *cfs_rq)
> > > > > > >  {
> > > > > > >         cfs_rq->tasks_timeline = RB_ROOT_CACHED;
> > > > > > > +       cfs_rq->latency_timeline = RB_ROOT_CACHED;
> > > > > > >         u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
> > > > > > >  #ifdef CONFIG_SMP
> > > > > > >         raw_spin_lock_init(&cfs_rq->removed.lock);
> > > > > > > @@ -12025,8 +12108,15 @@ int sched_group_set_latency(struct task_group *tg, s64 latency)
> > > > > > >
> > > > > > >         for_each_possible_cpu(i) {
> > > > > > >                 struct sched_entity *se = tg->se[i];
> > > > > > > +               struct rq *rq = cpu_rq(i);
> > > > > > > +               struct rq_flags rf;
> > > > > > > +
> > > > > > > +               rq_lock_irqsave(rq, &rf);
> > > > > > >
> > > > > > > +               __dequeue_latency(se->cfs_rq, se);
> > > > > > >                 WRITE_ONCE(se->latency_offset, latency);
> > > > > > > +
> > > > > > > +               rq_unlock_irqrestore(rq, &rf);
> > > > > > >         }
> > > > > > >
> > > > > > >         mutex_unlock(&shares_mutex);
> > > > > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > > > > index a15fb955092c..76bca172585c 100644
> > > > > > > --- a/kernel/sched/sched.h
> > > > > > > +++ b/kernel/sched/sched.h
> > > > > > > @@ -599,6 +599,7 @@ struct cfs_rq {
> > > > > > >  #endif
> > > > > > >
> > > > > > >         struct rb_root_cached   tasks_timeline;
> > > > > > > +       struct rb_root_cached   latency_timeline;
> > > > > > >
> > > > > > >         /*
> > > > > > >          * 'curr' points to currently running entity on this cfs_rq.
> > > > > > > --
> > > > > > > 2.17.1
> > > > > > >
> > > > > > >
> > > > > > >
