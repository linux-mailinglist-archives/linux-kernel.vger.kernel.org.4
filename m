Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9E6A6E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCAOTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCAOSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC68B302AA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:10 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+mcuo9SHWn+iEcKKGd8AZLU0jiixo7TxXcneH/7+TQ=;
        b=SrPf7y1vkX+RuYby2o5l5l7a3LdDvkkNtYZsyBDAaS9XNWnv0qcE+OLxuSn8c8RXvYcg68
        2TZM+b/ZTEU/og9uvEgZR+YsaHtaS2JwIl8BSjXZgu8ASFMPCKZTypgVcGHZcX9a5rI8bo
        PpFSnaJ2D9D0Wrpyo4cvOVa9bVDGoHpsDZvirMhaYjW3HMJAJiTuSHne61WhDyf/20LNxq
        QZbAXa6Xhw/wNJKFlM32PqWP7aq3qVqiylmBrvaoi3+FFbyrmJPltkwhnsrtdwwQOFIXC1
        vv+RlNPnpjVQbpX9mEc8bytaUgpgBRNj55EjZwBEEoe0V6eoLfmZEDOvb3qOVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+mcuo9SHWn+iEcKKGd8AZLU0jiixo7TxXcneH/7+TQ=;
        b=kuAwiw+dM7gcSLkt/DagJPiL3KKlgmAfEhHTLwbVH///lMraK+wXG6CQ8QRcYLtKvXXxCr
        m9CHzzGTRqPzDyDg==
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
Subject: [PATCH v5 15/18] tick/sched: Split out jiffies update helper function
Date:   Wed,  1 Mar 2023 15:17:41 +0100
Message-Id: <20230301141744.16063-16-anna-maria@linutronix.de>
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

From: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>

The logic to get the time of the last jiffies update will be needed by
the timer pull model as well.

Move the code into a global funtion in anticipation of the new caller.

No functional change.

Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/tick-sched.c    | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 28471c8f8c9c..296cd06bbb24 100644
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
index 7ffdc7ba19b4..1075697f2aa8 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -782,18 +782,30 @@ static inline bool local_timer_softirq_pending(void)
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

