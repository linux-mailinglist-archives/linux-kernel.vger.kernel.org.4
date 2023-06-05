Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C3C722F7A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjFETQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjFETQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2428DED;
        Mon,  5 Jun 2023 12:16:18 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2cLY1ozMTw4KDVSAVub6jpX7BafSFI8k9ZI7soaBJY=;
        b=DBWlsNUwZWkW4ynyACghcZ+XqiumyBWfzJQ75HnKPKMm2nvUkFX/XtlnPKaflxTAzMKwW7
        s/hOcmorgJzdAYfkx7Gu4s+PpSJPivBRHJ5VTsPhbkH9MgP0FzFkgGd8FwbV2Ee3HxlVXc
        G+DDtMJsHlExoqdyP3uPntRuR/LBXM0twXP7Xu8lYD2sINb+mKTINYt1uXcG+mtWoJ4C9J
        gp+4b7syTjV4ktOFjJ/RMQpTD1X2B8alvrDKIOBc5hpJYGAaphf14wd3quMnEB6AG2dFw9
        GmFYsGChPhDOrFWmCf7dj2qt/7+M9DiAkrEtyEw04ZKyn3TnQg7Qh1vxmuwXAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2cLY1ozMTw4KDVSAVub6jpX7BafSFI8k9ZI7soaBJY=;
        b=e3Zl6FoYoF6kCrsYUNZgoIjdMEwU59aW8cCHyUMei4JhMwT0NHkkqrapofNIGE13nqD3Jf
        egGpLY/+R+e+ffDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle: Use local_clock_noinstr()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102716.045980863@infradead.org>
References: <20230519102716.045980863@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257519.404.12817417791147203587.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e6a15fa9ea8372ad4db973191233f743ae1081d5
Gitweb:        https://git.kernel.org/tip/e6a15fa9ea8372ad4db973191233f743ae1081d5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:09 +02:00

cpuidle: Use local_clock_noinstr()

With the introduction of local_clock_noinstr(), local_clock() itself
is no longer marked noinstr, use the correct function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102716.045980863@infradead.org
---
 drivers/cpuidle/cpuidle.c    | 8 ++++----
 drivers/cpuidle/poll_state.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 8e929f6..737a026 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -145,7 +145,7 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
 
 	instrumentation_begin();
 
-	time_start = ns_to_ktime(local_clock());
+	time_start = ns_to_ktime(local_clock_noinstr());
 
 	tick_freeze();
 	/*
@@ -169,7 +169,7 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
 	tick_unfreeze();
 	start_critical_timings();
 
-	time_end = ns_to_ktime(local_clock());
+	time_end = ns_to_ktime(local_clock_noinstr());
 
 	dev->states_usage[index].s2idle_time += ktime_us_delta(time_end, time_start);
 	dev->states_usage[index].s2idle_usage++;
@@ -243,7 +243,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 	sched_idle_set_state(target_state);
 
 	trace_cpu_idle(index, dev->cpu);
-	time_start = ns_to_ktime(local_clock());
+	time_start = ns_to_ktime(local_clock_noinstr());
 
 	stop_critical_timings();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE)) {
@@ -276,7 +276,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
-	time_end = ns_to_ktime(local_clock());
+	time_end = ns_to_ktime(local_clock_noinstr());
 	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* The cpu is no longer idle or about to enter idle. */
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index bdcfeae..9b6d90a 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -15,7 +15,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 {
 	u64 time_start;
 
-	time_start = local_clock();
+	time_start = local_clock_noinstr();
 
 	dev->poll_time_limit = false;
 
@@ -32,7 +32,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 				continue;
 
 			loop_count = 0;
-			if (local_clock() - time_start > limit) {
+			if (local_clock_noinstr() - time_start > limit) {
 				dev->poll_time_limit = true;
 				break;
 			}
