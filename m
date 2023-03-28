Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641416CBD26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjC1LIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjC1LHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39D37EEE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kQG2l/tKeYJT6zXifHihyhG77ZWdoGPsh4TIiXCPCIM=; b=lbu36IMjlnbZ2kmncp4XjiFD4S
        i3J0R2TMJ6Tb4BEUJrGw6WRS0uq/qns36hVsnHPE8jKj46BT53O/mrq/aoeKyThcg5llGdZQI4bA2
        mZLeqDFN8rvhncnZXd8/ViPxsT2441z1IOb5LrTAnMa07YRzKV/88YGt2Rzmp4vVA9lPbx0MxGRzd
        sEMG5dzn4SsyKVRZdJy2NqPNPUEDzhw4kjKmf3NbpCemlCedJ8wIkMUI+atWrQwjM6PHOFShG7pLn
        W2/doO/rgzSzrXb27d18r5M8WYR3rS8/02+a+fJjE0l8PSb1CI1M05nbH2McX+pskO+28pVj8Yf/a
        QZsg6WYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ph79m-008MDF-5D; Tue, 28 Mar 2023 11:06:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6994F303128;
        Tue, 28 Mar 2023 13:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 117D32CB8D7A2; Tue, 28 Mar 2023 13:06:21 +0200 (CEST)
Message-ID: <20230328110354.712296502@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Subject: [PATCH 16/17] [RFC] sched/eevdf: Minimal vavg option
References: <20230328092622.062917921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alternative means of tracking min_vruntime to minimize the deltas
going into avg_vruntime -- note that because vavg move backwards this
is all sorts of tricky.

Also more expensive because of extra divisions... Not found this
convincing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   51 ++++++++++++++++++++++++++++--------------------
 kernel/sched/features.h |    2 +
 2 files changed, 32 insertions(+), 21 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -732,28 +732,37 @@ static u64 __update_min_vruntime(struct
 
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
-	struct sched_entity *se = __pick_first_entity(cfs_rq);
-	struct sched_entity *curr = cfs_rq->curr;
-
-	u64 vruntime = cfs_rq->min_vruntime;
-
-	if (curr) {
-		if (curr->on_rq)
-			vruntime = curr->vruntime;
-		else
-			curr = NULL;
+	if (sched_feat(MINIMAL_VA)) {
+		u64 vruntime = avg_vruntime(cfs_rq);
+		s64 delta = (s64)(vruntime - cfs_rq->min_vruntime);
+
+		avg_vruntime_update(cfs_rq, delta);
+
+		u64_u32_store(cfs_rq->min_vruntime, vruntime);
+	} else {
+		struct sched_entity *se = __pick_first_entity(cfs_rq);
+		struct sched_entity *curr = cfs_rq->curr;
+
+		u64 vruntime = cfs_rq->min_vruntime;
+
+		if (curr) {
+			if (curr->on_rq)
+				vruntime = curr->vruntime;
+			else
+				curr = NULL;
+		}
+
+		if (se) {
+			if (!curr)
+				vruntime = se->vruntime;
+			else
+				vruntime = min_vruntime(vruntime, se->vruntime);
+		}
+
+		/* ensure we never gain time by being placed backwards. */
+		u64_u32_store(cfs_rq->min_vruntime,
+				__update_min_vruntime(cfs_rq, vruntime));
 	}
-
-	if (se) {
-		if (!curr)
-			vruntime = se->vruntime;
-		else
-			vruntime = min_vruntime(vruntime, se->vruntime);
-	}
-
-	/* ensure we never gain time by being placed backwards. */
-	u64_u32_store(cfs_rq->min_vruntime,
-		      __update_min_vruntime(cfs_rq, vruntime));
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -9,6 +9,8 @@ SCHED_FEAT(PLACE_FUDGE, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 SCHED_FEAT(PLACE_BONUS, false)
 
+SCHED_FEAT(MINIMAL_VA, false)
+
 /*
  * Prefer to schedule the task we woke last (assuming it failed
  * wakeup-preemption), since its likely going to consume data we


