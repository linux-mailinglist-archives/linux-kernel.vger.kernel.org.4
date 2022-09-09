Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3683C5B3260
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiIIIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiIIIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5744812D1A3;
        Fri,  9 Sep 2022 01:52:43 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CucUCmT2BgEXx4S+SjKXcoK6Z7ijrmAalaf7ZnD4ovA=;
        b=0vYpzfGnzuem0TNmUN0qJ3+j4GE1TdNlja/3dentxbXYddLYL0nYOdM32EmukFFtevIONC
        HT0I5cOKbxy8a26Zp2FGzmG8rrnH++eP82V89vidJsbRdePF2BOXsyP8qn/o5nckWA6Xds
        aSOq/XaP7mqSbFxcu4eskM0N8Wh66X0nMQofBP+lV/Q0RW+h7CVKr+DLmBVKVQlcAfLxUR
        tk2UIY1IebfZ9sirSRlY8EOnc0zp5e79UVIi4rzK8C53Lu25rbHz5Gjtxy2X5PzV4b0A0/
        K/axr8zNIHmPmTj9Txw5ix4dj+KTKhLfjvcXFczawPx03ww4wAmjCFXwvpM1Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CucUCmT2BgEXx4S+SjKXcoK6Z7ijrmAalaf7ZnD4ovA=;
        b=yVKRo83Yz9AMx99jiA4naThJNOlIa9m1vAUWEiMU25cVoqZYT1VF6DXoUIQZi6XgTp15Hx
        eDyk+rWg7Qv8OBBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Move the topdown stuff into the intel driver
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829101321.505933457@infradead.org>
References: <20220829101321.505933457@infradead.org>
MIME-Version: 1.0
Message-ID: <166271356078.401.9490676054948431011.tip-bot2@tip-bot2>
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

Commit-ID:     e577bb17a1eaa35b86ee873a786e603be768d668
Gitweb:        https://git.kernel.org/tip/e577bb17a1eaa35b86ee873a786e603be768d668
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 May 2022 21:28:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:02 +02:00

perf/x86/intel: Move the topdown stuff into the intel driver

Use the new x86_pmu::{set_period,update}() methods to push the topdown
stuff into the Intel driver, where it belongs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220829101321.505933457@infradead.org
---
 arch/x86/events/core.c       |  7 -------
 arch/x86/events/intel/core.c | 26 +++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index bb559b7..b074e71 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -119,9 +119,6 @@ u64 x86_perf_event_update(struct perf_event *event)
 	if (unlikely(!hwc->event_base))
 		return 0;
 
-	if (unlikely(is_topdown_count(event)) && x86_pmu.update_topdown_event)
-		return x86_pmu.update_topdown_event(event);
-
 	/*
 	 * Careful: an NMI might modify the previous event value.
 	 *
@@ -1373,10 +1370,6 @@ int x86_perf_event_set_period(struct perf_event *event)
 	if (unlikely(!hwc->event_base))
 		return 0;
 
-	if (unlikely(is_topdown_count(event)) &&
-	    x86_pmu.set_topdown_event_period)
-		return x86_pmu.set_topdown_event_period(event);
-
 	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ba101c2..feed732 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2302,7 +2302,7 @@ static void intel_pmu_nhm_workaround(void)
 	for (i = 0; i < 4; i++) {
 		event = cpuc->events[i];
 		if (event)
-			x86_perf_event_update(event);
+			static_call(x86_pmu_update)(event);
 	}
 
 	for (i = 0; i < 4; i++) {
@@ -2317,7 +2317,7 @@ static void intel_pmu_nhm_workaround(void)
 		event = cpuc->events[i];
 
 		if (event) {
-			x86_perf_event_set_period(event);
+			static_call(x86_pmu_set_period)(event);
 			__x86_pmu_enable_event(&event->hw,
 					ARCH_PERFMON_EVENTSEL_ENABLE);
 		} else
@@ -2794,7 +2794,7 @@ static void intel_pmu_add_event(struct perf_event *event)
  */
 int intel_pmu_save_and_restart(struct perf_event *event)
 {
-	x86_perf_event_update(event);
+	static_call(x86_pmu_update)(event);
 	/*
 	 * For a checkpointed counter always reset back to 0.  This
 	 * avoids a situation where the counter overflows, aborts the
@@ -2806,9 +2806,27 @@ int intel_pmu_save_and_restart(struct perf_event *event)
 		wrmsrl(event->hw.event_base, 0);
 		local64_set(&event->hw.prev_count, 0);
 	}
+	return static_call(x86_pmu_set_period)(event);
+}
+
+static int intel_pmu_set_period(struct perf_event *event)
+{
+	if (unlikely(is_topdown_count(event)) &&
+	    x86_pmu.set_topdown_event_period)
+		return x86_pmu.set_topdown_event_period(event);
+
 	return x86_perf_event_set_period(event);
 }
 
+static u64 intel_pmu_update(struct perf_event *event)
+{
+	if (unlikely(is_topdown_count(event)) &&
+	    x86_pmu.update_topdown_event)
+		return x86_pmu.update_topdown_event(event);
+
+	return x86_perf_event_update(event);
+}
+
 static void intel_pmu_reset(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
@@ -4786,6 +4804,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.add			= intel_pmu_add_event,
 	.del			= intel_pmu_del_event,
 	.read			= intel_pmu_read_event,
+	.set_period		= intel_pmu_set_period,
+	.update			= intel_pmu_update,
 	.hw_config		= intel_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
