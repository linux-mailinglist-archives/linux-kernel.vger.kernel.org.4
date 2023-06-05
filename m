Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC078722F92
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbjFETQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjFETQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CB12A;
        Mon,  5 Jun 2023 12:16:21 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qV12sIK+dTEZk9yvJGtxGftiso3dDXEttu5OK2fo7LI=;
        b=KVarS9/FSyPeDPQWiWW0gHdLiyRLje9AymyVAHQxvj6DWGG6JaS7HRqUoi35sxvCnD8mIa
        MCroJABppjDzj36IVPDaRvF/1HqLMwLjNxHqopi+PGJSGcV9iPsZTGVzyGhbGNi/uWpoCI
        Dvi389UT3JpoN1xIYjP0hNUpnzVf5iBUyBCdDrFKlK4mJPhOmgcZ23abqOB3A3+XoYe9/R
        WiqcJGQ1whN//mldJzYiX6qh16BFQPkWrpxtkIOJkRHDJfV1wcCIa50chBd8RsD35tNYX6
        xLqr3KBEaNohmO8QtBg1Oamf/WVUzaasadkgqTDKgJQeLgaY8MUI/AElqSEXoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qV12sIK+dTEZk9yvJGtxGftiso3dDXEttu5OK2fo7LI=;
        b=EyLpy3JzlVWOJmp8V9x9qN2YmW9JsKFVze9gUW6t1pPuYLA23Y6fqLZkAVsefKP+DdY7kQ
        fbPAmeDuVH2lZkBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64/arch_timer: Provide noinstr
 sched_clock_read() functions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.435618812@infradead.org>
References: <20230519102715.435618812@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257881.404.5741830687039428221.tip-bot2@tip-bot2>
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

Commit-ID:     24ee7607b286b44a5112ced38652df14cd80d5e2
Gitweb:        https://git.kernel.org/tip/24ee7607b286b44a5112ced38652df14cd80d5e2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:05 +02:00

arm64/arch_timer: Provide noinstr sched_clock_read() functions

With the intent to provide local_clock_noinstr(), a variant of
local_clock() that's safe to be called from noinstr code (with the
assumption that any such code will already be non-preemptible),
prepare for things by providing a noinstr sched_clock_read() function.

Specifically, preempt_enable_*() calls out to schedule(), which upsets
noinstr validation efforts.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.435618812@infradead.org
---
 arch/arm64/include/asm/arch_timer.h  |  8 +----
 drivers/clocksource/arm_arch_timer.c | 54 ++++++++++++++++++++-------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index af1fafb..934c658 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -88,13 +88,7 @@ static inline notrace u64 arch_timer_read_cntvct_el0(void)
 
 #define arch_timer_reg_read_stable(reg)					\
 	({								\
-		u64 _val;						\
-									\
-		preempt_disable_notrace();				\
-		_val = erratum_handler(read_ ## reg)();			\
-		preempt_enable_notrace();				\
-									\
-		_val;							\
+		erratum_handler(read_ ## reg)();			\
 	})
 
 /*
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e09d442..b23d23b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -191,22 +191,40 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 	return val;
 }
 
-static notrace u64 arch_counter_get_cntpct_stable(void)
+static noinstr u64 raw_counter_get_cntpct_stable(void)
 {
 	return __arch_counter_get_cntpct_stable();
 }
 
-static notrace u64 arch_counter_get_cntpct(void)
+static notrace u64 arch_counter_get_cntpct_stable(void)
+{
+	u64 val;
+	preempt_disable_notrace();
+	val = __arch_counter_get_cntpct_stable();
+	preempt_enable_notrace();
+	return val;
+}
+
+static noinstr u64 arch_counter_get_cntpct(void)
 {
 	return __arch_counter_get_cntpct();
 }
 
-static notrace u64 arch_counter_get_cntvct_stable(void)
+static noinstr u64 raw_counter_get_cntvct_stable(void)
 {
 	return __arch_counter_get_cntvct_stable();
 }
 
-static notrace u64 arch_counter_get_cntvct(void)
+static notrace u64 arch_counter_get_cntvct_stable(void)
+{
+	u64 val;
+	preempt_disable_notrace();
+	val = __arch_counter_get_cntvct_stable();
+	preempt_enable_notrace();
+	return val;
+}
+
+static noinstr u64 arch_counter_get_cntvct(void)
 {
 	return __arch_counter_get_cntvct();
 }
@@ -753,14 +771,14 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
 	return 0;
 }
 
-static u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
+static noinstr u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
 {
 	u32 cnt_lo, cnt_hi, tmp_hi;
 
 	do {
-		cnt_hi = readl_relaxed(t->base + offset_lo + 4);
-		cnt_lo = readl_relaxed(t->base + offset_lo);
-		tmp_hi = readl_relaxed(t->base + offset_lo + 4);
+		cnt_hi = __raw_readl(t->base + offset_lo + 4);
+		cnt_lo = __raw_readl(t->base + offset_lo);
+		tmp_hi = __raw_readl(t->base + offset_lo + 4);
 	} while (cnt_hi != tmp_hi);
 
 	return ((u64) cnt_hi << 32) | cnt_lo;
@@ -1060,7 +1078,7 @@ bool arch_timer_evtstrm_available(void)
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
 
-static u64 arch_counter_get_cntvct_mem(void)
+static noinstr u64 arch_counter_get_cntvct_mem(void)
 {
 	return arch_counter_get_cnt_mem(arch_timer_mem, CNTVCT_LO);
 }
@@ -1074,6 +1092,7 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
 
 static void __init arch_counter_register(unsigned type)
 {
+	u64 (*scr)(void);
 	u64 start_count;
 	int width;
 
@@ -1083,21 +1102,28 @@ static void __init arch_counter_register(unsigned type)
 
 		if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
 		    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
-			if (arch_timer_counter_has_wa())
+			if (arch_timer_counter_has_wa()) {
 				rd = arch_counter_get_cntvct_stable;
-			else
+				scr = raw_counter_get_cntvct_stable;
+			} else {
 				rd = arch_counter_get_cntvct;
+				scr = arch_counter_get_cntvct;
+			}
 		} else {
-			if (arch_timer_counter_has_wa())
+			if (arch_timer_counter_has_wa()) {
 				rd = arch_counter_get_cntpct_stable;
-			else
+				scr = raw_counter_get_cntpct_stable;
+			} else {
 				rd = arch_counter_get_cntpct;
+				scr = arch_counter_get_cntpct;
+			}
 		}
 
 		arch_timer_read_counter = rd;
 		clocksource_counter.vdso_clock_mode = vdso_default;
 	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
+		scr = arch_counter_get_cntvct_mem;
 	}
 
 	width = arch_counter_get_width();
@@ -1113,7 +1139,7 @@ static void __init arch_counter_register(unsigned type)
 	timecounter_init(&arch_timer_kvm_info.timecounter,
 			 &cyclecounter, start_count);
 
-	sched_clock_register(arch_timer_read_counter, width, arch_timer_rate);
+	sched_clock_register(scr, width, arch_timer_rate);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
