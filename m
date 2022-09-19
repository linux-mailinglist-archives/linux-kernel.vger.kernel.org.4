Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF885BCBF9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiISMil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiISMiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:38:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941EC2DABE;
        Mon, 19 Sep 2022 05:38:01 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:37:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663591080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9+DmRLo6FQ1BHsjnz0nCbP6aY7Xhz8oqe7ztOlilD0=;
        b=OSWbFZDP1GZzOSnJk9PmLtwRiv5ByticHwI0keCZZpx6IGCGYJjBkpigfu7uduLjUv2klf
        m6IRxZML76uD/EJZl/DjdM+dxHFOSHnLmfDWFCtVKaCC4U/jikrcST2JKbRuXzh7n7qb6y
        LeHXRoY1A83AsGumy/Wv3u5cbNL+W5bfDHi6b/OqTuJFmNb8NgJRcwau/6j/kmXxkUzutj
        x6F8kGqYMjvyVoGqxTa7pbQDtwZ10QxPJBlnmcJGQ6Jq2TOZPjLO0qBjUEz8I/mCTw6eSZ
        Hg31PH7ClbTm/H5vFAUwd6YqEsbAE0ztGeHnWopuL+WcIu0WKzv7G60k3l441g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663591080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9+DmRLo6FQ1BHsjnz0nCbP6aY7Xhz8oqe7ztOlilD0=;
        b=a38A3lvkPOfjweAax/dyMD3ynQ8cGIYK/5iHAxPm4cJ0bWS2UYtI/mkd1iY4YugZQ4lBN4
        J+y85T27mWmmoADQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] preempt: Provide preempt_[dis|en]able_nested()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164131.402717-2-bigeasy@linutronix.de>
References: <20220825164131.402717-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359107896.401.2211439257484206458.tip-bot2@tip-bot2>
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

Commit-ID:     555bb4ccd1dd78d0263eae31629fe1fdd65c1fb5
Gitweb:        https://git.kernel.org/tip/555bb4ccd1dd78d0263eae31629fe1fdd65c1fb5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 25 Aug 2022 18:41:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 14:35:07 +02:00

preempt: Provide preempt_[dis|en]able_nested()

On PREEMPT_RT enabled kernels, spinlocks and rwlocks are neither disabling
preemption nor interrupts. Though there are a few places which depend on
the implicit preemption/interrupt disable of those locks, e.g. seqcount
write sections, per CPU statistics updates etc.

To avoid sprinkling CONFIG_PREEMPT_RT conditionals all over the place, add
preempt_disable_nested() and preempt_enable_nested() which should be
descriptive enough.

Add a lockdep assertion for the !PREEMPT_RT case to catch callers which
do not have preemption disabled.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220825164131.402717-2-bigeasy@linutronix.de

---
 include/linux/preempt.h | 42 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index b4381f2..0df425b 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -421,4 +421,46 @@ static inline void migrate_enable(void) { }
 
 #endif /* CONFIG_SMP */
 
+/**
+ * preempt_disable_nested - Disable preemption inside a normally preempt disabled section
+ *
+ * Use for code which requires preemption protection inside a critical
+ * section which has preemption disabled implicitly on non-PREEMPT_RT
+ * enabled kernels, by e.g.:
+ *  - holding a spinlock/rwlock
+ *  - soft interrupt context
+ *  - regular interrupt handlers
+ *
+ * On PREEMPT_RT enabled kernels spinlock/rwlock held sections, soft
+ * interrupt context and regular interrupt handlers are preemptible and
+ * only prevent migration. preempt_disable_nested() ensures that preemption
+ * is disabled for cases which require CPU local serialization even on
+ * PREEMPT_RT. For non-PREEMPT_RT kernels this is a NOP.
+ *
+ * The use cases are code sequences which are not serialized by a
+ * particular lock instance, e.g.:
+ *  - seqcount write side critical sections where the seqcount is not
+ *    associated to a particular lock and therefore the automatic
+ *    protection mechanism does not work. This prevents a live lock
+ *    against a preempting high priority reader.
+ *  - RMW per CPU variable updates like vmstat.
+ */
+/* Macro to avoid header recursion hell vs. lockdep */
+#define preempt_disable_nested()				\
+do {								\
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		preempt_disable();				\
+	else							\
+		lockdep_assert_preemption_disabled();		\
+} while (0)
+
+/**
+ * preempt_enable_nested - Undo the effect of preempt_disable_nested()
+ */
+static __always_inline void preempt_enable_nested(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+}
+
 #endif /* __LINUX_PREEMPT_H */
