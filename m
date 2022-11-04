Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B69F619ABB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiKDO7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiKDO6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:58:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555122EF7B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:58:00 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667573879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kvCElohZyUyNJGM2JneGjqwOan7vBCE2nbaLgbbE24=;
        b=0tuI8buTxcQd683GsIeTB2XnvF+yOTjJCOWEzNfR1pfDAmxN20GCUlC36qmFby74aWOo0b
        Jp1pe1Q7/zkmL1fCF/v8jjHO/UnzxZdHgcX30pQ1tKzk6X8wc2gLBVlzbzXJjm2b2EIBat
        3X/5b3IX+EnjHS62nyFo7zcHS6aH4obDW2HKWCTptp8wZmLJ7xSwvEUJWpmr2mrBsM4TWl
        UGgmRmBnZYt7IehlzhAi2yyc0IIs/QMzUu8oK2fbAVu2DNu+Eks43tEEvRG6Zjhkz8Tn8l
        Ytxjkl84wObu9x6ASDBdLLk7xl4tToDtB8igF2/YNn2ShanmE65Dc86xxB7fUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667573879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kvCElohZyUyNJGM2JneGjqwOan7vBCE2nbaLgbbE24=;
        b=XvrogLHg8qBegViDEiUEOPcLE9nQosfe7dI6/vK+t49B/gbCFUaDJ8+tS/0F7HBSAJperm
        ZSI2edb40Ftv/oCg==
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
        "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v4 13/16] tick/sched: Split out jiffies update helper function
Date:   Fri,  4 Nov 2022 15:57:34 +0100
Message-Id: <20221104145737.71236-14-anna-maria@linutronix.de>
In-Reply-To: <20221104145737.71236-1-anna-maria@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
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

From: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>

The logic to get the time of the last jiffies update will be needed by
the timer pull model as well.

Move the code into a global funtion in anticipation of the new caller.

No functional change.

Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/tick-sched.c    | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 7b65abc9d803..8f99e35e75b4 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -158,6 +158,7 @@ static inline void tick_nohz_init(void) { }
 #ifdef CONFIG_NO_HZ_COMMON
 extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
+extern u64 get_jiffies_update(unsigned long *basej);
 # ifdef CONFIG_SMP
 extern struct static_key_false timers_migration_enabled;
 # endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 7f7bfe8b498d..868679ff3421 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -782,19 +782,31 @@ static inline bool local_timer_softirq_pending(void)
 	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
 }
 
-static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
+/*
+ * Read jiffies and the time when jiffies were updated last
+ */
+u64 get_jiffies_update(unsigned long *basej)
 {
-	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
-	u64 basemono, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
+	u64 basemono;
 
-	/* Read jiffies and the time when jiffies were updated last */
 	do {
 		seq = read_seqcount_begin(&jiffies_seq);
 		basemono = last_jiffies_update;
 		basejiff = jiffies;
 	} while (read_seqcount_retry(&jiffies_seq, seq));
+	*basej = basejiff;
+	return basemono;
+}
+
+static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
+{
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
+	u64 basemono, delta, expires;
+	unsigned long basejiff;
+
+	basemono = get_jiffies_update(&basejiff);
 	ts->last_jiffies = basejiff;
 	ts->timer_expires_base = basemono;
 
-- 
2.30.2

