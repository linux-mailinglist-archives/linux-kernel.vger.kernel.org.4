Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544C66CBD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjC1LHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjC1LHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C872D40
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6jo/I+r1XZjfSV9hErqb9NOr5B8VgbE2esFe+ZOAMPE=; b=klW0hMjPWSwLhuCSR4NXBdMd4E
        PeJH63w9BozL4Qbyu7WF17R3BuOgQn9SZgdTVvbQ8S7Ub7O2mjQD6PVE/NsToESkN3bVr9sm3tV9p
        X/XlSOzw4ko0s1Jf7le/CO07cUjkE0ujiRsmrKN4BlnvJ3mgv44qUpEQHWoLCRl/eieMURadYHKFP
        utK+0enrC8OJ2FW9dzPDSDtcCDGSyjY32cOn/GHT/C+rH+1iV5d/xGp/XK1Cz+f93q1mTx7S50hqt
        PwQMtG6g1sWxz94rJHuHZ8yPyn60+auq1Pfxcv42gHWA6sQeJaNmCiaiNu8ztN5lkhciJwn7y+7de
        u6mwR+Uw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph79m-006XV7-14;
        Tue, 28 Mar 2023 11:06:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69A3C303229;
        Tue, 28 Mar 2023 13:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0317C2CB8D7AA; Tue, 28 Mar 2023 13:06:21 +0200 (CEST)
Message-ID: <20230328110354.562078801@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:36 +0200
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
Subject: [PATCH 14/17] sched/eevdf: Better handle mixed slice length
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

In the case where (due to latency-nice) there are different request
sizes in the tree, the smaller requests tend to be dominated by the
larger. Also note how the EEVDF lag limits are based on r_max.

Therefore; add a heuristic that for the mixed request size case, moves
smaller requests to placement strategy #2 which ensures they're
immidiately eligible and and due to their smaller (virtual) deadline
will cause preemption.

NOTE: this relies on update_entity_lag() to impose lag limits above
a single slice.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   14 ++++++++++++++
 kernel/sched/features.h |    1 +
 kernel/sched/sched.h    |    1 +
 3 files changed, 16 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -616,6 +616,7 @@ avg_vruntime_add(struct cfs_rq *cfs_rq,
 	s64 key = entity_key(cfs_rq, se);
 
 	cfs_rq->avg_vruntime += key * weight;
+	cfs_rq->avg_slice += se->slice * weight;
 	cfs_rq->avg_load += weight;
 }
 
@@ -626,6 +627,7 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq,
 	s64 key = entity_key(cfs_rq, se);
 
 	cfs_rq->avg_vruntime -= key * weight;
+	cfs_rq->avg_slice -= se->slice * weight;
 	cfs_rq->avg_load -= weight;
 }
 
@@ -4832,6 +4834,18 @@ place_entity(struct cfs_rq *cfs_rq, stru
 		lag = se->vlag;
 
 		/*
+		 * For latency sensitive tasks; those that have a shorter than
+		 * average slice and do not fully consume the slice, transition
+		 * to EEVDF placement strategy #2.
+		 */
+		if (sched_feat(PLACE_FUDGE) &&
+		    cfs_rq->avg_slice > se->slice * cfs_rq->avg_load) {
+			lag += vslice;
+			if (lag > 0)
+				lag = 0;
+		}
+
+		/*
 		 * If we want to place a task and preserve lag, we have to
 		 * consider the effect of the new entity on the weighted
 		 * average and compensate for this, otherwise lag can quickly
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -5,6 +5,7 @@
  * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
  */
 SCHED_FEAT(PLACE_LAG, true)
+SCHED_FEAT(PLACE_FUDGE, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -559,6 +559,7 @@ struct cfs_rq {
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
 	s64			avg_vruntime;
+	u64			avg_slice;
 	u64			avg_load;
 
 	u64			exec_clock;


