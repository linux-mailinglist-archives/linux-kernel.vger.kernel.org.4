Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4E95BCBF0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiISMiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiISMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:37:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A561ADB0;
        Mon, 19 Sep 2022 05:37:55 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:37:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663591073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XH4I0jTFrbufD+BBp8QN9e4gkHlZnnwx3tR0yPNF7Qg=;
        b=efIqCAPyQAot8CrbSCiu2FXeUNwafw1CFrGG92mNlQKeaHQaTh9+2ZcWsed4jHKJghclfa
        cgaLViIIMdhUzoJRusR4sNUxS+9FY1NYO1RGfmCeQgbsBN0+xkWdbyNvo6a+kO0VGuQTc8
        NiA4HOJyCGHC6jgXiSlQws1fRlNszgdHCfyFCh7aF1v9eMOeh3/jzyp0n+PSu2Y9JHjpin
        DUwd5PRKG96yaxqbNJQ7iLAK6KefVpyG3a8UHE4gKvY8MbhMJwUPjazIm46fCpOq5g1qtY
        Jh37AhmObtwJ9zdGqmH9xLGeONx2l0+UqjNHIOL1o/Ewtw4i2TXMlSLRPMj6zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663591073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XH4I0jTFrbufD+BBp8QN9e4gkHlZnnwx3tR0yPNF7Qg=;
        b=RoCsp02QQYHBfBWC6eqc7lnTubsYlcidQZ3QzwSGMitsG+4vvGcF8HS1B547zskhIRO0za
        aXWW1o2MsEOELtBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] u64_stats: Streamline the implementation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164131.402717-9-bigeasy@linutronix.de>
References: <20220825164131.402717-9-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359107135.401.12356374475532329007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     44b0c2957adc62b86fcd51adeaf8e993171bc319
Gitweb:        https://git.kernel.org/tip/44b0c2957adc62b86fcd51adeaf8e993171bc319
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 25 Aug 2022 18:41:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 14:35:08 +02:00

u64_stats: Streamline the implementation

The u64 stats code handles 3 different cases:

  - 32bit UP
  - 32bit SMP
  - 64bit

with an unreadable #ifdef maze, which was recently expanded with PREEMPT_RT
conditionals.

Reduce it to two cases (32bit and 64bit) and drop the optimization for
32bit UP as suggested by Linus.

Use the new preempt_disable/enable_nested() helpers to get rid of the
CONFIG_PREEMPT_RT conditionals.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220825164131.402717-9-bigeasy@linutronix.de

---
 include/linux/u64_stats_sync.h | 145 ++++++++++++++------------------
 1 file changed, 64 insertions(+), 81 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 6ad4e90..46040d6 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -8,7 +8,7 @@
  *
  * Key points :
  *
- * -  Use a seqcount on 32-bit SMP, only disable preemption for 32-bit UP.
+ * -  Use a seqcount on 32-bit
  * -  The whole thing is a no-op on 64-bit architectures.
  *
  * Usage constraints:
@@ -20,7 +20,8 @@
  *    writer and also spin forever.
  *
  * 3) Write side must use the _irqsave() variant if other writers, or a reader,
- *    can be invoked from an IRQ context.
+ *    can be invoked from an IRQ context. On 64bit systems this variant does not
+ *    disable interrupts.
  *
  * 4) If reader fetches several counters, there is no guarantee the whole values
  *    are consistent w.r.t. each other (remember point #2: seqcounts are not
@@ -29,11 +30,6 @@
  * 5) Readers are allowed to sleep or be preempted/interrupted: they perform
  *    pure reads.
  *
- * 6) Readers must use both u64_stats_fetch_{begin,retry}_irq() if the stats
- *    might be updated from a hardirq or softirq context (remember point #1:
- *    seqcounts are not used for UP kernels). 32-bit UP stat readers could read
- *    corrupted 64-bit values otherwise.
- *
  * Usage :
  *
  * Stats producer (writer) should use following template granted it already got
@@ -66,7 +62,7 @@
 #include <linux/seqlock.h>
 
 struct u64_stats_sync {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
+#if BITS_PER_LONG == 32
 	seqcount_t	seq;
 #endif
 };
@@ -98,7 +94,22 @@ static inline void u64_stats_inc(u64_stats_t *p)
 	local64_inc(&p->v);
 }
 
-#else
+static inline void u64_stats_init(struct u64_stats_sync *syncp) { }
+static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp) { }
+static inline void __u64_stats_update_end(struct u64_stats_sync *syncp) { }
+static inline unsigned long __u64_stats_irqsave(void) { return 0; }
+static inline void __u64_stats_irqrestore(unsigned long flags) { }
+static inline unsigned int __u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
+{
+	return 0;
+}
+static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
+					   unsigned int start)
+{
+	return false;
+}
+
+#else /* 64 bit */
 
 typedef struct {
 	u64		v;
@@ -123,123 +134,95 @@ static inline void u64_stats_inc(u64_stats_t *p)
 {
 	p->v++;
 }
-#endif
 
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
-#define u64_stats_init(syncp)	seqcount_init(&(syncp)->seq)
-#else
 static inline void u64_stats_init(struct u64_stats_sync *syncp)
 {
+	seqcount_init(&syncp->seq);
 }
-#endif
 
-static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
+static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 	write_seqcount_begin(&syncp->seq);
-#endif
 }
 
-static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
+static inline void __u64_stats_update_end(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 	write_seqcount_end(&syncp->seq);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
-#endif
+	preempt_enable_nested();
 }
 
-static inline unsigned long
-u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
+static inline unsigned long __u64_stats_irqsave(void)
 {
-	unsigned long flags = 0;
+	unsigned long flags;
 
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
-	else
-		local_irq_save(flags);
-	write_seqcount_begin(&syncp->seq);
-#endif
+	local_irq_save(flags);
 	return flags;
 }
 
-static inline void
-u64_stats_update_end_irqrestore(struct u64_stats_sync *syncp,
-				unsigned long flags)
+static inline void __u64_stats_irqrestore(unsigned long flags)
 {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
-	write_seqcount_end(&syncp->seq);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
-	else
-		local_irq_restore(flags);
-#endif
+	local_irq_restore(flags);
 }
 
 static inline unsigned int __u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 	return read_seqcount_begin(&syncp->seq);
-#else
-	return 0;
-#endif
 }
 
-static inline unsigned int u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
+static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
+					   unsigned int start)
 {
-#if BITS_PER_LONG == 32 && (!defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT))
-	preempt_disable();
-#endif
-	return __u64_stats_fetch_begin(syncp);
+	return read_seqcount_retry(&syncp->seq, start);
 }
+#endif /* !64 bit */
 
-static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
-					 unsigned int start)
+static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
-	return read_seqcount_retry(&syncp->seq, start);
-#else
-	return false;
-#endif
+	__u64_stats_update_begin(syncp);
+}
+
+static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
+{
+	__u64_stats_update_end(syncp);
+}
+
+static inline unsigned long u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
+{
+	unsigned long flags = __u64_stats_irqsave();
+
+	__u64_stats_update_begin(syncp);
+	return flags;
+}
+
+static inline void u64_stats_update_end_irqrestore(struct u64_stats_sync *syncp,
+						   unsigned long flags)
+{
+	__u64_stats_update_end(syncp);
+	__u64_stats_irqrestore(flags);
+}
+
+static inline unsigned int u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
+{
+	return __u64_stats_fetch_begin(syncp);
 }
 
 static inline bool u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 					 unsigned int start)
 {
-#if BITS_PER_LONG == 32 && (!defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT))
-	preempt_enable();
-#endif
 	return __u64_stats_fetch_retry(syncp, start);
 }
 
-/*
- * In case irq handlers can update u64 counters, readers can use following helpers
- * - SMP 32bit arches use seqcount protection, irq safe.
- * - UP 32bit must disable irqs.
- * - 64bit have no problem atomically reading u64 values, irq safe.
- */
+/* Obsolete interfaces */
 static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && defined(CONFIG_PREEMPT_RT)
-	preempt_disable();
-#elif BITS_PER_LONG == 32 && !defined(CONFIG_SMP)
-	local_irq_disable();
-#endif
-	return __u64_stats_fetch_begin(syncp);
+	return u64_stats_fetch_begin(syncp);
 }
 
 static inline bool u64_stats_fetch_retry_irq(const struct u64_stats_sync *syncp,
 					     unsigned int start)
 {
-#if BITS_PER_LONG == 32 && defined(CONFIG_PREEMPT_RT)
-	preempt_enable();
-#elif BITS_PER_LONG == 32 && !defined(CONFIG_SMP)
-	local_irq_enable();
-#endif
-	return __u64_stats_fetch_retry(syncp, start);
+	return u64_stats_fetch_retry(syncp, start);
 }
 
 #endif /* _LINUX_U64_STATS_SYNC_H */
