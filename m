Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A487561F484
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiKGNl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKGNly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:41:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67531CB31
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=frCwEg8y6Fhh91OaqNQd+dRhCvdE2X6bvJRY1xroZJs=; b=oaMTdDpdeCX5Xy30tDrJm9TS6N
        bTM2oMyh/Or3UD2vwOUleKB4CwlPMOFlnyXqS1aXc3sIZL0etpn7Gg5xY0pP5WAI4F6asJW7sYg1I
        LcKLkGXacnoI3z3DaLTaGIjrdec6w8AW2vhAqJ2qwtcluiDck4hk8Zs78l7fjVg4WEQp+QR8K7CTk
        uLgc61t+gvkBmSDmmefbVbkKGy73bv6mFk5MX1mArAuEbg6nHYVjwpaPTImfsi9RavK7lUVpX5n18
        0AJUWfkM/aiKS3ahZJ6atTIh035j57UGe03e7DCiQDRtI4uYRxjhP89whXnOyW7hAfmERK7d+QTZN
        Xktev++A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1os2NR-009ks1-6J; Mon, 07 Nov 2022 13:41:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4A0830026A;
        Mon,  7 Nov 2022 14:41:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA90020298A51; Mon,  7 Nov 2022 14:41:23 +0100 (CET)
Date:   Mon, 7 Nov 2022 14:41:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     Jian-Min Liu <jian-min.liu@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:

> Based on all the tests we've seen, jankbench or otherwise, the
> improvement can mainly be attributed to the faster ramp up of frequency
> caused by the shorter PELT window while using schedutil.

Would something terrible like the below help some?

If not, I suppose it could be modified to take the current state as
history. But basically it runs a faster pelt sum along side the regular
signal just for ramping up the frequency.

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..9ba07a1d19f6 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -96,6 +96,7 @@ SCHED_FEAT(WA_BIAS, true)
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
+	unsigned long contrib = (unsigned long)delta; /* p == 0 -> delta < 1024 */
+	u64 periods = delta / 1024;
+
+	if (periods) {
+		delta %= 1024;
+		contrib = __accumulate_pelt_segments(periods, 1024, delta);
+	}
+
+	return (contrib << SCHED_CAPACITY_SHIFT) / PELT_MIN_DIVIDER;
+}
+
 /*
  * We can represent the historical contribution to runnable average as the
  * coefficients of a geometric series.  To do this we sub-divide our runnable
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4a20046e586..99827d5dda27 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2922,6 +2922,8 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 	return READ_ONCE(rq->avg_dl.util_avg);
 }
 
+extern unsigned long faster_est_approx(u64 runtime);
+
 /**
  * cpu_util_cfs() - Estimates the amount of CPU capacity used by CFS tasks.
  * @cpu: the CPU to get the utilization for.
@@ -2956,13 +2958,26 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
  */
 static inline unsigned long cpu_util_cfs(int cpu)
 {
+	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq;
 	unsigned long util;
 
-	cfs_rq = &cpu_rq(cpu)->cfs;
+	cfs_rq = &rq->cfs;
 	util = READ_ONCE(cfs_rq->avg.util_avg);
 
 	if (sched_feat(UTIL_EST)) {
+		if (sched_feat(UTIL_EST_FASTER)) {
+			struct task_struct *curr;
+
+			rcu_read_lock();
+			curr = rcu_dereference(rq->curr);
+			if (likely(curr->sched_class == &fair_sched_class)) {
+				u64 runtime = curr->se.sum_exec_runtime - curr->se.exec_start;
+				util = max_t(unsigned long, util,
+					     faster_est_approx(runtime * 2));
+			}
+			rcu_read_unlock();
+		}
 		util = max_t(unsigned long, util,
 			     READ_ONCE(cfs_rq->avg.util_est.enqueued));
 	}



