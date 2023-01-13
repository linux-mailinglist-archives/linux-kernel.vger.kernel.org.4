Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92877669751
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbjAMMf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241288AbjAMMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFBC551F9;
        Fri, 13 Jan 2023 04:31:13 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5aASUlsmHY4Tb7vV5s9XpNeSSH8kwWok/IurZ2z1MF8=;
        b=RXXwtJEIaiaiX0gkhyVfCR+bpFuIgB5DEejKPVThIPG8pk5V6ULQ15OgLVNQLHSbUSibaP
        oq5lRS/w2/0GjE83uci+sw9oPMW2l1tdZebucd643+39cqjdSdiCLENqsk3osKyru2fk0j
        h/mTCTRpeQ5SlEtRme+K9fwFy47W3rgAfdoDsaVzlP1Mb+v5azetHh0fGyLOCoxqhdmOtc
        4+2NDcYLcfwblRpoGwXf18vBOvcL8A77XX6zKe5z/QNE2dDSWo2paSjC1Oaw5yq5dlE68U
        oCtOc2L6Gpsg2Gu40cYWamoFAe2/RyKlIdFR4M25gh3Wfm6zHlJhWm0B3+UXxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5aASUlsmHY4Tb7vV5s9XpNeSSH8kwWok/IurZ2z1MF8=;
        b=icZDcXRD41zrMSRQAGJxtBwTegCLl4N03tlEXav4WfwxWJxOjJqFEWhCW9JRMV7eo6KvYi
        jaSP2nhch15ut8Dg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm, smp: Remove trace_.*_rcuidle() usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.743432118@infradead.org>
References: <20230112195540.743432118@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307155.4906.8563533169394574018.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     08a56e07cd3cb91dc700ba0a879d17e4879dd617
Gitweb:        https://git.kernel.org/tip/08a56e07cd3cb91dc700ba0a879d17e4879dd617
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:15 +01:00

arm, smp: Remove trace_.*_rcuidle() usage

None of these functions should ever be ran with RCU disabled anymore.

Specifically, do_handle_IPI() is only called from handle_IPI() which
explicitly does irq_enter()/irq_exit() which ensures RCU is watching.

The problem with smp_cross_call() was, per commit description:

   7c64cc0531fa ("arm: Use _rcuidle for smp_cross_call() tracepoints")

... that cpuidle_enter_state_coupled() already had RCU disabled, but that's
long been fixed by commit:

  1098582a0f6c ("sched,idle,rcu: Push rcu_idle deeper into the idle path")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.743432118@infradead.org
---
 arch/arm/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 36e6efa..0b8c257 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -638,7 +638,7 @@ static void do_handle_IPI(int ipinr)
 	unsigned int cpu = smp_processor_id();
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
+		trace_ipi_entry(ipi_types[ipinr]);
 
 	switch (ipinr) {
 	case IPI_WAKEUP:
@@ -685,7 +685,7 @@ static void do_handle_IPI(int ipinr)
 	}
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+		trace_ipi_exit(ipi_types[ipinr]);
 }
 
 /* Legacy version, should go away once all irqchips have been converted */
@@ -708,7 +708,7 @@ static irqreturn_t ipi_handler(int irq, void *data)
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
+	trace_ipi_raise(target, ipi_types[ipinr]);
 	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 
