Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48857722F86
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjFETQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjFETQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA4210D;
        Mon,  5 Jun 2023 12:16:18 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1a/01dM1jlM9/hWx8Tbav/ajzPef+VpZihlbX0Kl8p4=;
        b=SJrZ2BnXDag3CsS54ajOt+GJMk+aMOEVUZALVrBDZ1LYLY/J5+CxwpK60KSvnpVdfRm2yL
        5I/H/hqgq3oi7kX/21QSPF3oTuLjiOwa5gOV8TE66bPAWh8I4eg8ntKawp4n6J4+HTAHAh
        1AVM1+TbjCmvYmVqhEFjIKWNCJCUbm1PQomQMO9my6AAAVdOCygnlXnyaSUIY9CYLO+WlT
        tIVXQ+aoDnfH1wKuPBdn0N268Z2yFvJ5TNZI5Ada8ZCaNt4gMxT5FUG2TgMkdc0NNfIKt3
        WZXlu6YCb9QZez3M0yO9k6vnYabx0Pu0j9+Gcfh8zmAkADlxeuJ5toh42nP+gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1a/01dM1jlM9/hWx8Tbav/ajzPef+VpZihlbX0Kl8p4=;
        b=p679FeGB8DHQeYjxXCG5vOqBoufcKBMSrIPK4s0bEo18XYU8ViY3K5vj+n0TOOXV3JFZkf
        LB0e5yZdwSoTT5Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] clocksource: hyper-v: Provide noinstr sched_clock()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.843039089@infradead.org>
References: <20230519102715.843039089@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257652.404.1607636577154012352.tip-bot2@tip-bot2>
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

Commit-ID:     e39acc37db34f6688e2c16e958fb1d662c422c81
Gitweb:        https://git.kernel.org/tip/e39acc37db34f6688e2c16e958fb1d662c422c81
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:08 +02:00

clocksource: hyper-v: Provide noinstr sched_clock()

With the intent to provide local_clock_noinstr(), a variant of
local_clock() that's safe to be called from noinstr code (with the
assumption that any such code will already be non-preemptible),
prepare for things by making the Hyper-V TSC and MSR sched_clock
implementations noinstr.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.843039089@infradead.org
---
 arch/x86/include/asm/mshyperv.h    |  5 +++++-
 drivers/clocksource/hyperv_timer.c | 32 ++++++++++++++++-------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 49bb4f2..88d9ef9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -257,6 +257,11 @@ void hv_set_register(unsigned int reg, u64 value);
 u64 hv_get_non_nested_register(unsigned int reg);
 void hv_set_non_nested_register(unsigned int reg, u64 value);
 
+static __always_inline u64 hv_raw_get_register(unsigned int reg)
+{
+	return __rdmsr(reg);
+}
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index c643bfe..d851970 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -365,6 +365,20 @@ void hv_stimer_global_cleanup(void)
 }
 EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 
+static __always_inline u64 read_hv_clock_msr(void)
+{
+	/*
+	 * Read the partition counter to get the current tick count. This count
+	 * is set to 0 when the partition is created and is incremented in 100
+	 * nanosecond units.
+	 *
+	 * Use hv_raw_get_register() because this function is used from
+	 * noinstr. Notable; while HV_REGISTER_TIME_REF_COUNT is a synthetic
+	 * register it doesn't need the GHCB path.
+	 */
+	return hv_raw_get_register(HV_REGISTER_TIME_REF_COUNT);
+}
+
 /*
  * Code and definitions for the Hyper-V clocksources.  Two
  * clocksources are defined: one that reads the Hyper-V defined MSR, and
@@ -393,7 +407,7 @@ struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
-static notrace u64 read_hv_clock_tsc(void)
+static __always_inline u64 read_hv_clock_tsc(void)
 {
 	u64 cur_tsc, time;
 
@@ -404,7 +418,7 @@ static notrace u64 read_hv_clock_tsc(void)
 	 * to the MSR in case the TSC page indicates unavailability.
 	 */
 	if (!hv_read_tsc_page_tsc(tsc_page, &cur_tsc, &time))
-		time = hv_get_register(HV_REGISTER_TIME_REF_COUNT);
+		time = read_hv_clock_msr();
 
 	return time;
 }
@@ -414,7 +428,7 @@ static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
 	return read_hv_clock_tsc();
 }
 
-static u64 notrace read_hv_sched_clock_tsc(void)
+static u64 noinstr read_hv_sched_clock_tsc(void)
 {
 	return (read_hv_clock_tsc() - hv_sched_clock_offset) *
 		(NSEC_PER_SEC / HV_CLOCK_HZ);
@@ -466,22 +480,12 @@ static struct clocksource hyperv_cs_tsc = {
 #endif
 };
 
-static u64 notrace read_hv_clock_msr(void)
-{
-	/*
-	 * Read the partition counter to get the current tick count. This count
-	 * is set to 0 when the partition is created and is incremented in
-	 * 100 nanosecond units.
-	 */
-	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
-}
-
 static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
 {
 	return read_hv_clock_msr();
 }
 
-static u64 notrace read_hv_sched_clock_msr(void)
+static u64 noinstr read_hv_sched_clock_msr(void)
 {
 	return (read_hv_clock_msr() - hv_sched_clock_offset) *
 		(NSEC_PER_SEC / HV_CLOCK_HZ);
