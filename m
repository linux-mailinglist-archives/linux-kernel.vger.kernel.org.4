Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7BD6E9801
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjDTPF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjDTPF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:05:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214AF4EC4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oQkWp9N6HE3LxHxHGVq8WKI0wtaShJbXheOXQps3zYQ=; b=rX0HjSlJl2ElvLcW4kaL1LglSh
        UUNk8zy0+CQa4EOizZc28q8l9QKzIKCj4mnWzL1CM63Xb0Mkshi5fZsd2nqsz2rxDNfK675Y2me0P
        LDUI1DRKqbQi5dbJAH3y7R4DhQmDfYbbY40/wN+//6Ncwapm8fWErHxCFnghsptCEKVlHRJPtY/xc
        PNKDk6eV/gV4xJv4kIfUMqHoMrol+vjQ8eu6d+f6EfKMG8JRHQu1o7/czVrZT4WVGpqvvzDoM2CDb
        loZA8ta1ULJIv2a/gwy69py1tITocpDGI4ssKymTvK/7jZqHABxWSSyLCN1636TmDnyxuF9iMnFRW
        +vPTkBnQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ppVqt-003oOQ-0J;
        Thu, 20 Apr 2023 15:05:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFF31300244;
        Thu, 20 Apr 2023 17:05:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 938622417A098; Thu, 20 Apr 2023 17:05:37 +0200 (CEST)
Date:   Thu, 20 Apr 2023 17:05:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Mason <clm@meta.com>
Cc:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        gautham.shenoy@amd.com
Subject: Re: schbench v1.0
Message-ID: <20230420150537.GC4253@hirez.programming.kicks-ass.net>
References: <bc85a40c-1ea0-9b57-6ba3-b920c436a02c@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc85a40c-1ea0-9b57-6ba3-b920c436a02c@meta.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:10:25AM +0200, Chris Mason wrote:

> F128 N10                EEVDF    Linus
> Wakeup  (usec): 99.0th: 755      1,266
> Request (usec): 99.0th: 25,632   22,304
> RPS    (count): 50.0th: 4,280    4,376
> 
> F128 N10 no-locking     EEVDF    Linus
> Wakeup  (usec): 99.0th: 823      1,118
> Request (usec): 99.0th: 17,184   14,192
> RPS    (count): 50.0th: 4,440    4,456

With the below fixlet (against queue/sched/eevdf) on my measly IVB-EP
(2*10*2):

./schbench -F128 -n10 -C

Request Latencies percentiles (usec) runtime 30 (s) (153800 total samples)
	  90.0th: 6376       (35699 samples)
	* 99.0th: 6440       (9055 samples)
	  99.9th: 7048       (1345 samples)

CFS

schbench -m2 -F128 -n10	-r90	OTHER	BATCH
Wakeup  (usec): 99.0th:		6600	6328
Request (usec): 99.0th:		35904	14640
RPS    (count): 50.0th:		5368	6104

EEVDF base_slice = 3000[us] (default)

schbench -m2 -F128 -n10	-r90	OTHER	BATCH
Wakeup  (usec): 99.0th:		3820	6968
Request (usec): 99.0th:		30496	24608
RPS    (count): 50.0th:		3836	5496

EEVDF base_slice = 6440[us] (per the calibrate run)

schbench -m2 -F128 -n10	-r90	OTHER	BATCH
Wakeup  (usec): 99.0th:		9136	6232
Request (usec): 99.0th:		21984	12944
RPS    (count): 50.0th:		4968	6184


With base_slice >= request and BATCH (disables wakeup preemption), the
EEVDF thing should turn into FIFO-queue, which is close to ideal for
your workload.

For giggles:

echo 6440000 > /debug/sched/base_slice_ns
echo NO_PLACE_LAG > /debug/sched/features
chrt -b 0 ./schbench -m2 -F128 -n10 -r90

gets me:

Wakeup Latencies percentiles (usec) runtime 90 (s) (526553 total samples)
	  50.0th: 2084       (158080 samples)
	  90.0th: 5320       (210675 samples)
	* 99.0th: 6232       (47643 samples)
	  99.9th: 6648       (4297 samples)
	  min=1, max=13105
Request Latencies percentiles (usec) runtime 90 (s) (526673 total samples)
	  50.0th: 7544       (157171 samples)
	  90.0th: 10992      (210461 samples)
	* 99.0th: 12944      (48069 samples)
	  99.9th: 15088      (3716 samples)
	  min=3841, max=32882
RPS percentiles (requests) runtime 90 (s) (9 total samples)
	  20.0th: 6184       (9 samples)
	* 50.0th: 6184       (0 samples)
	  90.0th: 6184       (0 samples)
	  min=6173, max=6180
average rps: 6195.77

FWIW, your RPS stats are broken, note how all the buckets are over the
max value and the average is too.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 050e98c97ba3..931102b00786 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1071,6 +1071,8 @@ void set_latency_fair(struct sched_entity *se, int prio)
 	se->slice = div_u64(base << SCHED_FIXEDPOINT_SHIFT, weight);
 }
 
+static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
+
 /*
  * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
@@ -1084,6 +1086,14 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 * EEVDF: vd_i = ve_i + r_i / w_i
 	 */
 	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
+
+	/*
+	 * The task has consumed its request, reschedule.
+	 */
+	if (cfs_rq->nr_running > 1) {
+		resched_curr(rq_of(cfs_rq));
+		clear_buddies(cfs_rq, se);
+	}
 }
 
 #include "pelt.h"
@@ -3636,6 +3646,13 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		 * we need to scale se->vlag when w_i changes.
 		 */
 		se->vlag = div_s64(se->vlag * old_weight, weight);
+	} else {
+		/*
+		 * When the weight changes the virtual time slope changes and
+		 * we should adjust the virtual deadline. For now, punt and
+		 * simply reset.
+		 */
+		se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
 	}
 
 #ifdef CONFIG_SMP
@@ -5225,22 +5256,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
 
-/*
- * Preempt the current task with a newly woken task if needed:
- */
-static void
-check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
-{
-	if (pick_eevdf(cfs_rq) != curr) {
-		resched_curr(rq_of(cfs_rq));
-		/*
-		 * The current task ran long enough, ensure it doesn't get
-		 * re-elected due to buddy favours.
-		 */
-		clear_buddies(cfs_rq, curr);
-	}
-}
-
 static void
 set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
@@ -5353,9 +5384,6 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
 		return;
 #endif
-
-	if (cfs_rq->nr_running > 1)
-		check_preempt_tick(cfs_rq, curr);
 }
 
 
