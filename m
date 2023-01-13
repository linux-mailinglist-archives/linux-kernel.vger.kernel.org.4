Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0766974C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbjAMMeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbjAMMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A754718;
        Fri, 13 Jan 2023 04:31:12 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1fVilpW8JUakMiobShNqA/W9JfOYJfPNgyvLrDkhSo=;
        b=Oh1iQToz/9C1u6JgsDARO5cMj0jKcx8yeAsIzN75IiL29ZDtMq1lwUQR+qYHRozD2UvZaF
        F/gboa4THBylzuEztQCkYVtX8NfsKmoeotCHRHtA2Jm1aF4/w1tKKp9Anrh/xFWx4uzw85
        +ThpXsgT34E/su5q248tZ2Gw0QJVGI+IY8js6gZs/LwOiLl9LtVpKk/axUjK43sfRwr/je
        cISq33ESEOzvIW9RGCO+UvNR02DScy55ciUicOedHeRHHauU0z315bCRjthlI9V1ofXTfT
        pxgYW5FCQuakFRvAsCZo2kfDsDeRsGHCyKLBp3jTzMOYlL/6pCSlTaykvzcExA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1fVilpW8JUakMiobShNqA/W9JfOYJfPNgyvLrDkhSo=;
        b=PYCcmSyxNeHrjloObfH3mFVTd7T5U3PrtVUR4ueXli0ozOBhgsNCTroC7TWzVUssSTn1h3
        Wnb9DAED28WjSnDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] tracing: Remove trace_hardirqs_{on,off}_caller()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.355283994@infradead.org>
References: <20230112195541.355283994@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306852.4906.9955658883284890992.tip-bot2@tip-bot2>
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

Commit-ID:     dc7305606d480f34d9ed960fcaceac81d0f38436
Gitweb:        https://git.kernel.org/tip/dc7305606d480f34d9ed960fcaceac81d0f38436
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:16 +01:00

tracing: Remove trace_hardirqs_{on,off}_caller()

Per commit 56e62a737028 ("s390: convert to generic entry") the last
and only callers of trace_hardirqs_{on,off}_caller() went away, clean
up.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.355283994@infradead.org
---
 kernel/trace/trace_preemptirq.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 1e130da..629f285 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -84,35 +84,6 @@ void trace_hardirqs_off(void)
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 NOKPROBE_SYMBOL(trace_hardirqs_off);
-
-__visible void trace_hardirqs_on_caller(unsigned long caller_addr)
-{
-	if (this_cpu_read(tracing_irq_cpu)) {
-		if (!in_nmi())
-			trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
-		tracer_hardirqs_on(CALLER_ADDR0, caller_addr);
-		this_cpu_write(tracing_irq_cpu, 0);
-	}
-
-	lockdep_hardirqs_on_prepare();
-	lockdep_hardirqs_on(caller_addr);
-}
-EXPORT_SYMBOL(trace_hardirqs_on_caller);
-NOKPROBE_SYMBOL(trace_hardirqs_on_caller);
-
-__visible void trace_hardirqs_off_caller(unsigned long caller_addr)
-{
-	lockdep_hardirqs_off(caller_addr);
-
-	if (!this_cpu_read(tracing_irq_cpu)) {
-		this_cpu_write(tracing_irq_cpu, 1);
-		tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
-		if (!in_nmi())
-			trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
-	}
-}
-EXPORT_SYMBOL(trace_hardirqs_off_caller);
-NOKPROBE_SYMBOL(trace_hardirqs_off_caller);
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
