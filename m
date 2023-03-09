Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD716B2B38
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCIQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCIQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:52:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A0759E6A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GRVPI14NC52xGPNBb0OzUpGXGdMf1Fo9BV1RVYAMcbA=; b=lmVjmrMni9P/eh4B1Zn4jXQswk
        P6bve4FxaRnFa7RMbh108sdCgBAsFAQKy1iHKj6Db9UfUGY9cxkbb75K/E/YjhhkLvwbTRIsxpmYc
        5inkbyrjpfrNau8VucllqPjs7CyJeunsjroAr/PAGvhFuzJzT1fGucXRS557ZqzsjEjF0cbfLIaS0
        nmqTNyimxj/epkfDxAvb8lRnPLnxC+PswF0eh2lGYk/HPp4tbFXdUhZ7s06bsRBfokUvUNGQU7HOC
        y+FnhyaLTyWPRLSYeTzL/hWnPatEKHU2+NjHmL+Ra/e1lE3r5WreapNCNc7VNbC8z+btug0mcDj2d
        2qqBCT9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paJLp-008b5d-Qj; Thu, 09 Mar 2023 16:42:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBAAC300410;
        Thu,  9 Mar 2023 17:42:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C0B120E406C4; Thu,  9 Mar 2023 17:42:42 +0100 (CET)
Date:   Thu, 9 Mar 2023 17:42:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Subject: Re: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
Message-ID: <ZAoMgmMOYXBA4Mzs@hirez.programming.kicks-ass.net>
References: <20230306132521.968182689@infradead.org>
 <20230306141502.810909205@infradead.org>
 <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
 <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
 <20230309090633.GK2017917@hirez.programming.kicks-ass.net>
 <ZAnUnSEJ92bKpim7@hirez.programming.kicks-ass.net>
 <ZAn7QAjQvw5q6aI5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAn7QAjQvw5q6aI5@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:29:04PM +0100, Peter Zijlstra wrote:

> So if I add TICK_NSEC based sleeper bonus (/2 for gentle), then starve
> works -- this is the absolutely minimal amount required. It sucks a bit
> it's HZ dependent, but alas.

Fixes starve, sucks for schbench and hackbench :/

Clearly more thinking is required...

root@ivb-ep:~/bench# echo NO_FAIR_SLEEPERS > /debug/sched/features
root@ivb-ep:~/bench# ./doit-schbench.sh ; ./doit-hackbench-series.sh
Latency percentiles (usec)
50.0000th: 83
75.0000th: 102
90.0000th: 109
95.0000th: 114
*99.0000th: 450
99.5000th: 723
99.9000th: 985
min=0, max=1067
1:            0.55355 +- 0.00290 seconds time elapsed  ( +-  0.52% )
2:            0.79591 +- 0.00545 seconds time elapsed  ( +-  0.68% )
5:             1.5804 +- 0.0102 seconds time elapsed  ( +-  0.65% )
10:             2.5674 +- 0.0110 seconds time elapsed  ( +-  0.43% )
20:             4.6116 +- 0.0160 seconds time elapsed  ( +-  0.35% )
40:             9.5965 +- 0.0167 seconds time elapsed  ( +-  0.17% )
root@ivb-ep:~/bench# time taskset -c 3 ./starve/starve 1000000
expecting to receive 1000000 signals
^C

real    0m32.999s
user    0m0.000s
sys     0m0.719s
root@ivb-ep:~/bench# echo FAIR_SLEEPERS > /debug/sched/features
root@ivb-ep:~/bench# ./doit-schbench.sh ; ./doit-hackbench-series.sh
Latency percentiles (usec)
50.0000th: 87
75.0000th: 103
90.0000th: 111
95.0000th: 116
*99.0000th: 163
99.5000th: 697
99.9000th: 1110
min=0, max=1522
1:            0.59076 +- 0.00577 seconds time elapsed  ( +-  0.98% )
2:            0.86093 +- 0.00407 seconds time elapsed  ( +-  0.47% )
5:             2.1018 +- 0.0129 seconds time elapsed  ( +-  0.61% )
10:             3.6378 +- 0.0395 seconds time elapsed  ( +-  1.09% )
20:            5.56884 +- 0.00979 seconds time elapsed  ( +-  0.18% )
40:            10.8570 +- 0.0207 seconds time elapsed  ( +-  0.19% )
root@ivb-ep:~/bench# time taskset -c 3 ./starve/starve 1000000
expecting to receive 1000000 signals

real    0m5.651s
user    0m0.604s
sys     0m4.047s


---

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4938,17 +4938,22 @@ place_entity(struct cfs_rq *cfs_rq, stru
 {
 	u64 vruntime = avg_vruntime(cfs_rq);
 
+	if (sched_feat(PRESERVE_LAG))
+		vruntime -= se->lag;
+
 	if (sched_feat(FAIR_SLEEPERS)) {
-		u64 sleep_time;
+//		u64 sleep_time;
 
 		/* sleeps up to a single latency don't count. */
 		if (!initial) {
-			unsigned long thresh;
+			unsigned long thresh = TICK_NSEC;
 
-			if (se_is_idle(se))
-				thresh = sysctl_sched_min_granularity;
-			else
-				thresh = sysctl_sched_latency;
+			if (!sched_feat(EEVDF)) {
+				if (se_is_idle(se))
+					thresh = sysctl_sched_min_granularity;
+				else
+					thresh = sysctl_sched_latency;
+			}
 
 			/*
 			 * Halve their sleep time's effect, to allow
@@ -4957,7 +4962,7 @@ place_entity(struct cfs_rq *cfs_rq, stru
 			if (sched_feat(GENTLE_FAIR_SLEEPERS))
 				thresh >>= 1;
 
-			vruntime -= thresh;
+			vruntime -= calc_delta_fair(thresh, se);
 		}
 
 		/*
@@ -4966,15 +4971,12 @@ place_entity(struct cfs_rq *cfs_rq, stru
 		 * slept for a long time, don't even try to compare its vruntime with
 		 * the base as it may be too far off and the comparison may get
 		 * inversed due to s64 overflow.
-		 */
 		sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
 		if ((s64)sleep_time < 60LL * NSEC_PER_SEC)
+		 */
 			vruntime = max_vruntime(se->vruntime, vruntime);
 	}
 
-	if (sched_feat(PRESERVE_LAG))
-		vruntime -= se->lag;
-
 	se->vruntime = vruntime;
 	set_slice(cfs_rq, se);
 }
