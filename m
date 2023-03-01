Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292DC6A6E38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCAOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCAOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA962E822
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:07 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdbSgLslPmcPgItz29y18IhXxIbpFPnnUkwjNqQj+/I=;
        b=kdRAvwzm4OaR9OSE+hCZ2Z+1tZkRsCTw9fEsGRaVm904YQvE4Yv5DCAdiAinJ3CBWXni5G
        iWU1J6V+GxlQez5MunpLVnxD+vcDBXMHLkFkJ1pVmQgZwXkUHIuoWbKGxQylzq295cfskn
        oNHtGxGsDTeKITFP6Pg8lxTPeUGrxzinv3Swe9ScFCNgoyEUPUGu+Cz3DlrLugJEsM7aDf
        RTHSMYZqxmX2StmvWJwIPsVwsL2j1uFbBpfgsI6MLl0ZN60X3W4d11gfpfgUnAdVrLeRIV
        NHL2skas4RnRubw+cLaPtKjtWO4PdeSO5+8YniwOg2UPey7a2UW2kWTgLghxjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdbSgLslPmcPgItz29y18IhXxIbpFPnnUkwjNqQj+/I=;
        b=aGnRgYH9dOdbi+nZxO3yuGEPkIGWxsbkVMmrXvXUkzA3XkjWHaYujIebGohEXaCFdSqWHE
        qEf8jXH30jlQ0vCQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v5 07/18] timers: Ease code in run_local_timers()
Date:   Wed,  1 Mar 2023 15:17:33 +0100
Message-Id: <20230301141744.16063-8-anna-maria@linutronix.de>
In-Reply-To: <20230301141744.16063-1-anna-maria@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic for raising a softirq the way it is implemented right now, is
readable for two timer bases. When increasing numbers of timer bases, code
gets harder to read. With the introduction of the timer migration
hierarchy, there will be three timer bases.

Therefore ease the code. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v5: New patch to decrease patch size of follow up patches
---
 kernel/time/timer.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d74d538e06a2..d3e1776b505b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2058,16 +2058,14 @@ static void run_local_timers(void)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	hrtimer_run_queues();
-	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->next_expiry)) {
-		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
-			return;
-		/* CPU is awake, so check the deferrable base. */
-		base++;
-		if (time_before(jiffies, base->next_expiry))
+
+	for (int i = 0; i < NR_BASES; i++, base++) {
+		/* Raise the softirq only if required. */
+		if (time_after_eq(jiffies, base->next_expiry)) {
+			raise_softirq(TIMER_SOFTIRQ);
 			return;
+		}
 	}
-	raise_softirq(TIMER_SOFTIRQ);
 }
 
 /*
-- 
2.30.2

