Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F224666974F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbjAMMfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241324AbjAMMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7A1551F2;
        Fri, 13 Jan 2023 04:31:13 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpjIidHUzb9GXLO72/VEZJ8q4SC9KSNRvn+qUsbytro=;
        b=Gm3U9xka0fowfk5S/4gHOeupvaQ+Psm3XspaNxRV/NZeFWTelGxHMTwOAgiDIaOUoaWtqC
        Q8duMuemq49jZ1M4kejDKqW6awcidJtRCA51zvg8Njs8pzT88pHb/0glJ+lPBkLVswUvcF
        3MoBFXhCPPmwL5AzcHD/P1rzojzaOxu0QPOoPiDeaIomZO5AiMVDkv184dcvcrDOKWPQhL
        q5LsOhTKO6b7u6zRvUDb5EhIFr/0omYSeZ74GNYrE0/1JgH50e7Altf6QsaqkviPRWOLWi
        un2E5yLk2cqBGwtCmbl2F87tnaqmEX3KBRiQvmx8WJB0Mh9ov7ph74j2Pz73EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpjIidHUzb9GXLO72/VEZJ8q4SC9KSNRvn+qUsbytro=;
        b=n9Hovsv48zhzj9m0CbgQwDzhDoMYfL3s95uTOlHWaBsAABSokSheirBdTlA1J3qYRjCDs+
        S1uq9+CQLLuQyhBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64, smp: Remove trace_.*_rcuidle() usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.804410487@infradead.org>
References: <20230112195540.804410487@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307129.4906.3474317514178863759.tip-bot2@tip-bot2>
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

Commit-ID:     4a3182e6d62c95f8572630c22aafee2306cfea58
Gitweb:        https://git.kernel.org/tip/4a3182e6d62c95f8572630c22aafee2306cfea58
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:38 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:15 +01:00

arm64, smp: Remove trace_.*_rcuidle() usage

Ever since commit d3afc7f12987 ("arm64: Allow IPIs to be handled as
normal interrupts") this function is called in regular IRQ context.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.804410487@infradead.org
---
 arch/arm64/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ffc5d76..4e83272 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -865,7 +865,7 @@ static void do_handle_IPI(int ipinr)
 	unsigned int cpu = smp_processor_id();
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
+		trace_ipi_entry(ipi_types[ipinr]);
 
 	switch (ipinr) {
 	case IPI_RESCHEDULE:
@@ -914,7 +914,7 @@ static void do_handle_IPI(int ipinr)
 	}
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+		trace_ipi_exit(ipi_types[ipinr]);
 }
 
 static irqreturn_t ipi_handler(int irq, void *data)
