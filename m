Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8FB70EEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbjEXHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239804AbjEXHHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:07:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A503DFC
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:07:00 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684912019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5ghRq1p1UzQMeOe2kb9B0X1weJSuecItqx6Ppb2A0s=;
        b=2WjbYAAV6lbiLJ7V0U3sea1cyaYFl/TwuQaIWaGpI+OU2Z7fWTKSIC80eyHe7aLx1fL9kD
        jPpHpVJMr6UJIt15OB9iEZJIFXv1ZTS+jnkaoFk8YgGjh4B8CKX7N+BOvvMt7N6LtZcOyM
        kZ11fSAH3zJY1NuCS7d3Ms4jjw17WweDB8lWYUQMcJIQA+wLrQ36SehwsuiY96QAb00ROR
        c2RGtT7WJG4T7ODze3SjqrVV8ez5psTj/LHMHDChPJrWJnl5SliMnrQI8qcnLBQuxLlXos
        wzxFw2x2z02YRz1x9W+6OxvSARzVl1LzXL332lDXqMBuwW2fvZ/XVN1CtN9LZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684912019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5ghRq1p1UzQMeOe2kb9B0X1weJSuecItqx6Ppb2A0s=;
        b=JVr0tIqLMcWr2kJTnV1Dpt+Euh05MXC73CvKJbxWlZr9gT7yeSneT2L6w6+7X1drsNAr7U
        b1hvvIv2dm5FiUDA==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v7 07/21] timers: Introduce add_timer() variants which modify timer flags
Date:   Wed, 24 May 2023 09:06:15 +0200
Message-Id: <20230524070629.6377-8-anna-maria@linutronix.de>
In-Reply-To: <20230524070629.6377-1-anna-maria@linutronix.de>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timer might be used as pinned timer (using add_timer_on()) and later on as
non pinned timers using add_timer(). When the NOHZ timer pull at expiry
model is in place, TIMER_PINNED flag is required to be used whenever a
timer needs to expire on a dedicated CPU. Flag must no be set, if
expiration on a dedicated CPU is not required.

add_timer_on()'s behavior will be changed during the preparation patches
for the NOHZ timer pull at expiry model to unconditionally set TIMER_PINNED
flag. To be able to reset/set the flag when queueing a timer, two variants
of add_timer() are introduced.

This is a preparatory patch and has no functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
New in v6
---
 include/linux/timer.h |  2 ++
 kernel/time/timer.c   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 9162f275819a..6f96661480dd 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -180,6 +180,8 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 #define NEXT_TIMER_MAX_DELTA	((1UL << 30) - 1)
 
 extern void add_timer(struct timer_list *timer);
+extern void add_timer_local(struct timer_list *timer);
+extern void add_timer_global(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1522fb81887e..ab9a8bb11a8a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1242,6 +1242,40 @@ void add_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(add_timer);
 
+/**
+ * add_timer_local - Start a timer on the local CPU
+ * @timer:	The timer to be started
+ *
+ * Same as add_timer() except that the timer flag TIMER_PINNED is set.
+ *
+ * See add_timer() for further details.
+ */
+void add_timer_local(struct timer_list *timer)
+{
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
+	timer->flags |= TIMER_PINNED;
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
+}
+EXPORT_SYMBOL(add_timer_local);
+
+/**
+ * add_timer_global - Start a timer without TIMER_PINNED flag set
+ * @timer:	The timer to be started
+ *
+ * Same as add_timer() except that the timer flag TIMER_PINNED is unset.
+ *
+ * See add_timer() for further details.
+ */
+void add_timer_global(struct timer_list *timer)
+{
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
+	timer->flags &= ~TIMER_PINNED;
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
+}
+EXPORT_SYMBOL(add_timer_global);
+
 /**
  * add_timer_on - Start a timer on a particular CPU
  * @timer:	The timer to be started
-- 
2.30.2

