Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8778760CE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiJYN7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiJYN7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:59:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25561B9CD;
        Tue, 25 Oct 2022 06:59:22 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666706361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsI07DTqXjWlRwYDoljjsPLtGx2xh4qIy28E4h8N7no=;
        b=T3EsepFnG1VEPakgQAPv6utfeISI5b9SCb3qu9nw9yeGr8jw8t1zR6Dx6ch73PUNFHVOGL
        oqi15SnAg6HRSDAkl4rHMmQDmCPs6a9Lv63YmgSPuSPwPNSps9UbplBD71AHpxg2pJhoxM
        FyKJ6I+g+ewtLZORJV916KEkkleW6We3dblqJb1P61KSpLSm5qD968Gg2KoZJ148/HVXoU
        TIw427aYJT6plp81tvDQn1+JvmlMVHx6z/OXTHK8T9S81zxHoAeP4HroqZjYTVa+HVrrka
        zTpa7evXpC5fGDXUF91xC6m66JO487MZ65rfWuv1Y0eNCYhcD7momR1AF1QKSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666706361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsI07DTqXjWlRwYDoljjsPLtGx2xh4qIy28E4h8N7no=;
        b=i7qAAP55lL27scwdgwJ3teCam7iQjkFLDDmuZcmI7LTkktrsPSWpugrETm6inYdHUHJQBi
        M/D/ekZWd+6fl2BQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 01/17] cpufreq: Prepare timer flags for hierarchical timer pull model
Date:   Tue, 25 Oct 2022 15:58:34 +0200
Message-Id: <20221025135850.51044-2-anna-maria@linutronix.de>
In-Reply-To: <20221025135850.51044-1-anna-maria@linutronix.de>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This is a proposal only. I was waiting on input how to change this
driver properly to use the already existing infrastructure. See therfore
the thread on linux-pm mailinglist:
https://lore.kernel.org/linux-pm/4c99f34b-40f1-e6cc-2669-7854b615b5fd@linutronix.de/

gpstates timer is the only timer using TIMER_PINNED and TIMER_DEFERRABLE
flag. When moving to hierarchical timer pull model, pinned and deferrable
timers are stored in separate bases.

To ensure gpstates timer always expires on the CPU where it is pinned to,
keep only TIMER_PINNED flag and drop TIMER_DEFERRABLE flag.

While at it, rewrite comment explaining the rule for timer expiry for the
next interval and fix whitespace damages.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/cpufreq/powernv-cpufreq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index fddbd1ea1635..08d6bd54539d 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -640,18 +640,18 @@ static inline int calc_global_pstate(unsigned int elapsed_time,
 		return highest_lpstate_idx + index_diff;
 }
 
-static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
+static inline void queue_gpstate_timer(struct global_pstate_info *gpstates)
 {
 	unsigned int timer_interval;
 
 	/*
-	 * Setting up timer to fire after GPSTATE_TIMER_INTERVAL ms, But
-	 * if it exceeds MAX_RAMP_DOWN_TIME ms for ramp down time.
-	 * Set timer such that it fires exactly at MAX_RAMP_DOWN_TIME
-	 * seconds of ramp down time.
+	 * Timer should expire next time after GPSTATE_TIMER_INTERVAL. If
+	 * the resulting interval (elapsed time + interval) between last
+	 * and next timer expiry is greater than MAX_RAMP_DOWN_TIME, ensure
+	 * it is maximum MAX_RAMP_DOWN_TIME when queueing the next timer.
 	 */
 	if ((gpstates->elapsed_time + GPSTATE_TIMER_INTERVAL)
-	     > MAX_RAMP_DOWN_TIME)
+	    > MAX_RAMP_DOWN_TIME)
 		timer_interval = MAX_RAMP_DOWN_TIME - gpstates->elapsed_time;
 	else
 		timer_interval = GPSTATE_TIMER_INTERVAL;
@@ -865,8 +865,7 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	/* initialize timer */
 	gpstates->policy = policy;
-	timer_setup(&gpstates->timer, gpstate_timer_handler,
-		    TIMER_PINNED | TIMER_DEFERRABLE);
+	timer_setup(&gpstates->timer, gpstate_timer_handler, TIMER_PINNED);
 	gpstates->timer.expires = jiffies +
 				msecs_to_jiffies(GPSTATE_TIMER_INTERVAL);
 	spin_lock_init(&gpstates->gpstate_lock);
-- 
2.30.2

