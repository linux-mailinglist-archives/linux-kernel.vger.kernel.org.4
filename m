Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD8650AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiLSLdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiLSLdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:33:38 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D7F593;
        Mon, 19 Dec 2022 03:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WCC/V9Yu/nMjzbbYqIhxNrChn8ZYg+F2uWNBs44eS4Q=; b=INZ/MyI9huZjJE4LP9D+BscmdQ
        nYUeYu6SBz5yd14XlkaHA/XxE638RyBDux7zOtX6M/QaWk8Nk40i6a/LyC0SnSRUQ+qL0TA2pcMl3
        QQXelsY+oXvxD5oyU5lbWbDFzRp74QwqF+t/pXRn/FHR/v/9tnNOD7/p055hDslnjpOksVUncRc/x
        B66wtql9LzroVe893nC3G2BHBv0Qa2LJVmXzi4AcHpmyhhCp+/tb4u9l9EFGEtGjDm1FYlnKEJDJR
        jd0rFIEpPY3SIQmP8BZ1xnIC/Cx71gsLAo0Ym9HbEWSMDeLOGWjtZyKcle1WadsM7/PyiW0hTwwE3
        oc4idNug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p7EOZ-00CZ4g-35;
        Mon, 19 Dec 2022 11:33:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3F8E3001D6;
        Mon, 19 Dec 2022 12:33:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79D04202FE504; Mon, 19 Dec 2022 12:33:22 +0100 (CET)
Date:   Mon, 19 Dec 2022 12:33:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
Message-ID: <Y6BMAp6A731F8ZL4@hirez.programming.kicks-ass.net>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
 <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
 <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
 <20221216220748.GA1967978@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216220748.GA1967978@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:07:48PM +0100, Frederic Weisbecker wrote:
> On Fri, Dec 16, 2022 at 12:19:34PM +0100, Peter Zijlstra wrote:
> > On Thu, Dec 15, 2022 at 10:42:59AM -0800, Srinivas Pandruvada wrote:
> > > +		/* Give ksoftirqd 1 jiffy to get a chance to start its job */
> > > +		if (!READ_ONCE(it.done) && task_is_running(__this_cpu_read(ksoftirqd))) {
> > > +			__set_current_state(TASK_UNINTERRUPTIBLE);
> > > +			schedule_timeout(1);
> > > +		}
> > 
> > That's absolutely disgusting :-/
> 
> I know, and I hate checking task_is_running(__this_cpu_read(ksoftirqd))
> everywhere in idle. And in fact it doesn't work because some cpuidle drivers
> also do need_resched() checks.

quite a few indeed.

> I guess that either we assume that the idle injection is more important
> than serving softirqs and we shutdown the warnings accordingly, or we arrange
> for idle injection to have a lower prio than ksoftirqd.

ksoftirq is typically a CFS task while idle injection is required to be
a FIFO (typically FIFO-1) task -- so that would require lifting
ksoftirqd to FIFO and that has other problems.

I'm guessing the problem case is where idle injection comes in while
ksoftirq is running (and preempted), because in that case you cannot run
the softirq stuff in-place.

The 'right' thing to do would be to PI boost ksoftirqd in that case I
suppose. Perhaps something like so, it would boost ksoftirq when it's
running, and otherwise runs the ksoftirqd thing in-situ.

I've not really throught hard about this though, so perhaps I completely
wrecked things.


---
 include/linux/interrupt.h   |  3 +++
 kernel/sched/build_policy.c |  1 +
 kernel/sched/idle.c         |  4 ++++
 kernel/softirq.c            | 20 +++++++++++++++++---
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..a2db811d6947 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -606,6 +606,9 @@ extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
 
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
+DECLARE_PER_CPU(struct rt_mutex, ksoftirq_lock);
+
+extern bool __run_ksoftirqd(unsigned int cpu);
 
 static inline struct task_struct *this_cpu_ksoftirqd(void)
 {
diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index d9dc9ab3773f..731c595e551c 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -28,6 +28,7 @@
 #include <linux/suspend.h>
 #include <linux/tsacct_kern.h>
 #include <linux/vtime.h>
+#include <linux/interrupt.h>
 
 #include <uapi/linux/sched/types.h>
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f26ab2675f7d..093bfdfca2f1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -370,6 +370,10 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	WARN_ON_ONCE(!duration_ns);
 	WARN_ON_ONCE(current->mm);
 
+	rt_mutex_lock(&per_cpu(ksoftirq_lock, cpu));
+	__run_ksoftirqd(smp_processor_id());
+	rt_mutex_unlock(&per_cpu(ksoftirq_lock, cpu));
+
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913c067d..a2cb600383a4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -59,6 +59,7 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
 static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp;
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
+DEFINE_PER_CPU(struct rt_mutex, ksoftirq_lock);
 
 const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
@@ -912,6 +913,7 @@ void __init softirq_init(void)
 			&per_cpu(tasklet_vec, cpu).head;
 		per_cpu(tasklet_hi_vec, cpu).tail =
 			&per_cpu(tasklet_hi_vec, cpu).head;
+		rt_mutex_init(&per_cpu(ksoftirq_mutex, cpu));
 	}
 
 	open_softirq(TASKLET_SOFTIRQ, tasklet_action);
@@ -923,7 +925,7 @@ static int ksoftirqd_should_run(unsigned int cpu)
 	return local_softirq_pending();
 }
 
-static void run_ksoftirqd(unsigned int cpu)
+bool __run_ksoftirqd(unsigned int cpu)
 {
 	ksoftirqd_run_begin();
 	if (local_softirq_pending()) {
@@ -933,10 +935,22 @@ static void run_ksoftirqd(unsigned int cpu)
 		 */
 		__do_softirq();
 		ksoftirqd_run_end();
-		cond_resched();
-		return;
+		return true;
 	}
 	ksoftirqd_run_end();
+	return false;
+}
+
+static void run_ksoftirqd(unsigned int cpu)
+{
+	bool run;
+
+	rt_mutex_lock(&per_cpu(ksoftirq_lock, cpu));
+	ran = __run_ksoftirqd(cpu);
+	rt_mutex_unlock(&per_cpu(ksoftirq_lock, cpu));
+
+	if (ran)
+		cond_resched();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
