Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A5F5B325C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiIIIwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiIIIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8D12D1B8;
        Fri,  9 Sep 2022 01:52:38 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcZEiW6YAwffMNAG0gPYTx4oGYctLUW1q7FQgwqbhpw=;
        b=UnPyteJI4gmesE2d/Dqk1RxF2KPYK5WKz8eUUrhWqFUVH3AUDGx7xkyUQavVeitYf8WKlB
        QyxwjDmV37O0DNgydIyjEF5uVrWKzzNAM/087yKiDDVV3zKPLbWXNMUIw3a0MQ++1lhY2s
        uG5KEDDva9C7ly8vzD1SS/6KdvPhcJ+RH6zV3LJHxIk3gz94Unhun4FbWjDAm98Oo2YLeO
        MqGMFXw+4g0D41ZZzOLIC7W3dxycNieYfVM5VILCXR5Rr2RO/R91Fr5XjYhEyfh9Nk4bON
        il1cggFAIE46xttsHzztOyNPvlc6FB72eLJzj2PlAT4kM7aDR7urmA7+v78n3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcZEiW6YAwffMNAG0gPYTx4oGYctLUW1q7FQgwqbhpw=;
        b=/avlYTuve1q66K2+ak7h1RKqTP0XW61SoI1eERbWV9fbPUtoiL5MhusIfZemsGkAdlG2LH
        4i/EXkCJvUxS+zBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Remove x86_pmu::update_topdown_event
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829101321.771635301@infradead.org>
References: <20220829101321.771635301@infradead.org>
MIME-Version: 1.0
Message-ID: <166271355629.401.13151405069131291937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1acab2e01c9c5df00f2fddf3473014dea89dcb5f
Gitweb:        https://git.kernel.org/tip/1acab2e01c9c5df00f2fddf3473014dea89dcb5f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 11 May 2022 17:02:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:03 +02:00

perf/x86/intel: Remove x86_pmu::update_topdown_event

Now that it is all internal to the intel driver, remove
x86_pmu::update_topdown_event.

Assumes that is_topdown_count(event) can only be true when the
hardware has topdown stuff and the function is set.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220829101321.771635301@infradead.org
---
 arch/x86/events/intel/core.c | 22 ++++++++++++----------
 arch/x86/events/perf_event.h |  1 -
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 75400ed..1e429e8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2673,6 +2673,7 @@ static u64 adl_update_topdown_event(struct perf_event *event)
 	return icl_update_topdown_event(event);
 }
 
+DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
 
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
@@ -2684,7 +2685,7 @@ static void intel_pmu_read_topdown_event(struct perf_event *event)
 		return;
 
 	perf_pmu_disable(event->pmu);
-	x86_pmu.update_topdown_event(event);
+	static_call(intel_pmu_update_topdown_event)(event);
 	perf_pmu_enable(event->pmu);
 }
 
@@ -2692,7 +2693,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 {
 	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 		intel_pmu_auto_reload_read(event);
-	else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
+	else if (is_topdown_count(event))
 		intel_pmu_read_topdown_event(event);
 	else
 		x86_perf_event_update(event);
@@ -2821,9 +2822,8 @@ static int intel_pmu_set_period(struct perf_event *event)
 
 static u64 intel_pmu_update(struct perf_event *event)
 {
-	if (unlikely(is_topdown_count(event)) &&
-	    x86_pmu.update_topdown_event)
-		return x86_pmu.update_topdown_event(event);
+	if (unlikely(is_topdown_count(event)))
+		return static_call(intel_pmu_update_topdown_event)(event);
 
 	return x86_perf_event_update(event);
 }
@@ -2990,8 +2990,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
 		handled++;
-		if (x86_pmu.update_topdown_event)
-			x86_pmu.update_topdown_event(NULL);
+		static_call(intel_pmu_update_topdown_event)(NULL);
 	}
 
 	/*
@@ -6292,7 +6291,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.num_topdown_events = 4;
-		x86_pmu.update_topdown_event = icl_update_topdown_event;
+		static_call_update(intel_pmu_update_topdown_event,
+				   &icl_update_topdown_event);
 		static_call_update(intel_pmu_set_topdown_event_period,
 				   &icl_set_topdown_event_period);
 		pr_cont("Icelake events, ");
@@ -6331,7 +6331,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.num_topdown_events = 8;
-		x86_pmu.update_topdown_event = icl_update_topdown_event;
+		static_call_update(intel_pmu_update_topdown_event,
+				   &icl_update_topdown_event);
 		static_call_update(intel_pmu_set_topdown_event_period,
 				   &icl_set_topdown_event_period);
 		pr_cont("Sapphire Rapids events, ");
@@ -6369,7 +6370,8 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_adl();
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
 		x86_pmu.num_topdown_events = 8;
-		x86_pmu.update_topdown_event = adl_update_topdown_event;
+		static_call_update(intel_pmu_update_topdown_event,
+				   &adl_update_topdown_event);
 		static_call_update(intel_pmu_set_topdown_event_period,
 				   &adl_set_topdown_event_period);
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index be27ead..386ebfa 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -889,7 +889,6 @@ struct x86_pmu {
 	 * Intel perf metrics
 	 */
 	int		num_topdown_events;
-	u64		(*update_topdown_event)(struct perf_event *event);
 
 	/*
 	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
