Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3B6FD839
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjEJHau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjEJH3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:29:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7C87AB0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:29:34 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683703726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIGKIf4Z0AsCend9uaXIeTu+m62vPWVrk7haHbUMXy8=;
        b=QlhYI4/J5J2vKwJijQZrNRoGyUQTJeZX16KejNgtqq2JanWWzoQhlf7m4YjSHPtchOR3kp
        m4S3x7HM2XB8bNpHPPDcnu04SRkOxqq99qukvOmWBAfdYm/1jhVMaGSxCR4jLsSSN3p3Ic
        /tdrAIIuSpos3jHShREl+qyS7ezaUjnrCemqjJbLXCIRAyCnNy1RDPt5omaqWOYXsY7mTE
        jbBhXdViK0fa2YhwOEqLDrlJ/rH1aa4M3EQsG0yJD7wo+zTl87J9wKwS4AqyJQFfX5r1We
        hwRGKWZgYVoHdynwWSD9F6xQT63PAv7x+DdkQ7ijZO7vSFpqwFVD4P6mt2MAKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683703726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIGKIf4Z0AsCend9uaXIeTu+m62vPWVrk7haHbUMXy8=;
        b=G0Mzvhor2kV4GKNj/OHrSWqAZqgI1l7R9ATeyv1KZbjj29GcTxUXJvuwstvD9LMZjBFXY/
        x36BDWhBaH29kWAg==
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
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v6 18/21] tick/sched: Split out jiffies update helper function
Date:   Wed, 10 May 2023 09:28:14 +0200
Message-Id: <20230510072817.116056-19-anna-maria@linutronix.de>
In-Reply-To: <20230510072817.116056-1-anna-maria@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>

The logic to get the time of the last jiffies update will be needed by
the timer pull model as well.

Move the code into a global function in anticipation of the new caller.

No functional change.

Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/tick-sched.c    | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index c7bba0bb19d9..630ed43cd8d6 100644
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
index 62836490ba4d..847c459c01f2 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -787,18 +787,30 @@ static inline bool local_timer_softirq_pending(void)
 	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
 }
 
-static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
+/*
+ * Read jiffies and the time when jiffies were updated last
+ */
+u64 get_jiffies_update(unsigned long *basej)
 {
-	u64 basemono, next_tick, delta, expires;
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
+	u64 basemono, next_tick, delta, expires;
+	unsigned long basejiff;
+
+	basemono = get_jiffies_update(&basejiff);
 	ts->last_jiffies = basejiff;
 	ts->timer_expires_base = basemono;
 
-- 
2.30.2

