Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C5722F90
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjFETQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjFETQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DDE123;
        Mon,  5 Jun 2023 12:16:20 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992578;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybhGghyQ5jl24URsD2QDWQaTnDgrborE8LFzQ+V4GNs=;
        b=pRHofzN7WzBDGbLKXJHpBrohxlqlVZMEfTlqUTGQkbTH/s4KX76xpwD2Ct0owtM+BPpEPc
        fO1ux/iEfqvg+wJUBH/SXzzp+W1dFPOTJv36JW08pYLRh5598h3Rvnj4kdk34D/ilu/MkH
        WE2vWsSGHxGCj/HefZcKK4UofPj5jGeCUHar4ysTuu0sMeIWE9J8Lfz8xknGoPuzMrMICI
        ZOy+J3CJWsps1EsEq7BFBnb9Ag4HSOTrTvpxDppK0Qst+h5v1JNrymtM2suy+gEGnJiJEY
        SNYdJ5QDz0Og3rGmg3OLwxgTcN8GMpZeQFEogqOyM2Hyx3M+at/1d/JUcMXnnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992578;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybhGghyQ5jl24URsD2QDWQaTnDgrborE8LFzQ+V4GNs=;
        b=v9r0DkhVsOD9Th9JpV5DHgMC7jbi0iYCRkRMyE4uJWwixMHf7mz1KSKCGmPbgudPKl8lGt
        T2LbboktVmsoITCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] s390/time: Provide sched_clock_noinstr()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.570170436@infradead.org>
References: <20230519102715.570170436@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257796.404.16564114401767634173.tip-bot2@tip-bot2>
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

Commit-ID:     91b41a237512b569746e1f560a42d9fba077261d
Gitweb:        https://git.kernel.org/tip/91b41a237512b569746e1f560a42d9fba077261d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:06 +02:00

s390/time: Provide sched_clock_noinstr()

With the intent to provide local_clock_noinstr(), a variant of
local_clock() that's safe to be called from noinstr code (with the
assumption that any such code will already be non-preemptible),
prepare for things by providing a noinstr sched_clock_noinstr()
function.

Specifically, preempt_enable_*() calls out to schedule(), which upsets
noinstr validation efforts.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.570170436@infradead.org
---
 arch/s390/include/asm/timex.h | 13 +++++++++----
 arch/s390/kernel/time.c       |  5 +++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index ce878e8..4d64665 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -63,7 +63,7 @@ static inline int store_tod_clock_ext_cc(union tod_clock *clk)
 	return cc;
 }
 
-static inline void store_tod_clock_ext(union tod_clock *tod)
+static __always_inline void store_tod_clock_ext(union tod_clock *tod)
 {
 	asm volatile("stcke %0" : "=Q" (*tod) : : "cc");
 }
@@ -177,7 +177,7 @@ static inline void local_tick_enable(unsigned long comp)
 
 typedef unsigned long cycles_t;
 
-static inline unsigned long get_tod_clock(void)
+static __always_inline unsigned long get_tod_clock(void)
 {
 	union tod_clock clk;
 
@@ -204,6 +204,11 @@ void init_cpu_timer(void);
 
 extern union tod_clock tod_clock_base;
 
+static __always_inline unsigned long __get_tod_clock_monotonic(void)
+{
+	return get_tod_clock() - tod_clock_base.tod;
+}
+
 /**
  * get_clock_monotonic - returns current time in clock rate units
  *
@@ -216,7 +221,7 @@ static inline unsigned long get_tod_clock_monotonic(void)
 	unsigned long tod;
 
 	preempt_disable_notrace();
-	tod = get_tod_clock() - tod_clock_base.tod;
+	tod = __get_tod_clock_monotonic();
 	preempt_enable_notrace();
 	return tod;
 }
@@ -240,7 +245,7 @@ static inline unsigned long get_tod_clock_monotonic(void)
  * -> ns = (th * 125) + ((tl * 125) >> 9);
  *
  */
-static inline unsigned long tod_to_ns(unsigned long todval)
+static __always_inline unsigned long tod_to_ns(unsigned long todval)
 {
 	return ((todval >> 9) * 125) + (((todval & 0x1ff) * 125) >> 9);
 }
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 6b7b6d5..2762781 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -102,6 +102,11 @@ void __init time_early_init(void)
 			((long) qui.old_leap * 4096000000L);
 }
 
+unsigned long long noinstr sched_clock_noinstr(void)
+{
+	return tod_to_ns(__get_tod_clock_monotonic());
+}
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
