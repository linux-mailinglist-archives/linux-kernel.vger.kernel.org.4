Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED8F669760
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbjAMMfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbjAMMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E4E55653;
        Fri, 13 Jan 2023 04:31:13 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31uxH5Ak6dZ7vSuNzmfeVzcX2gOxsrZ6IzipXbFlZ/A=;
        b=J84fC2U8gNj7sqDb1qmDKC4iWbwT0AUvkbmmkbLWZoEd3MUFi21w8mwM2L1hnd9DmWfO5w
        jK6cjLf6ecALVzF6UtwJfYuan7XPJ6NCtCr6T2mYGvv4A37Vwhw2qRbOcR8AT53hDumd36
        5OR9S5Kuw/xAOy00ukbPZLMRdGav1QX/2ibJ7bSSP3DOAvVWydR9ZdAtGd6HJUPlmEnzqE
        zWWXfNKG40XI9HlNhvkLJAmxRv6KE+MtldI+pci1W2bBOkBi3VmyRoBXwolpnLlvBpz+5m
        gz/8+rkIvEbuaTSjA9X8zav5Lgfg1OBOQ/eqpIXCunZ8or6gUQNrNj1jQ4KCPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31uxH5Ak6dZ7vSuNzmfeVzcX2gOxsrZ6IzipXbFlZ/A=;
        b=yNeMi+E95jq3xcHE9s7Icgn3DsxyHOspIdEeNDEsgEj9NJeOSpwZTV1JAU53r37sHRA7+x
        hMOU1TEYnW85HjDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/tdx: Remove TDX_HCALL_ISSUE_STI
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.682137572@infradead.org>
References: <20230112195540.682137572@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307173.4906.11995531818303643380.tip-bot2@tip-bot2>
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

Commit-ID:     e80a48bade619ec5a92230b3d4ae84bfc2746822
Gitweb:        https://git.kernel.org/tip/e80a48bade619ec5a92230b3d4ae84bfc2746822
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:15 +01:00

x86/tdx: Remove TDX_HCALL_ISSUE_STI

Now that arch_cpu_idle() is expected to return with IRQs disabled,
avoid the useless STI/CLI dance.

Per the specs this is supposed to work, but nobody has yet relied up
this behaviour so broken implementations are possible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.682137572@infradead.org
---
 arch/x86/coco/tdx/tdcall.S        | 13 -------------
 arch/x86/coco/tdx/tdx.c           | 23 ++++-------------------
 arch/x86/include/asm/shared/tdx.h |  1 -
 3 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index f9eb113..508c173 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -139,19 +139,6 @@ SYM_FUNC_START(__tdx_hypercall)
 
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
-	/*
-	 * For the idle loop STI needs to be called directly before the TDCALL
-	 * that enters idle (EXIT_REASON_HLT case). STI instruction enables
-	 * interrupts only one instruction later. If there is a window between
-	 * STI and the instruction that emulates the HALT state, there is a
-	 * chance for interrupts to happen in this window, which can delay the
-	 * HLT operation indefinitely. Since this is the not the desired
-	 * result, conditionally call STI before TDCALL.
-	 */
-	testq $TDX_HCALL_ISSUE_STI, %rsi
-	jz .Lskip_sti
-	sti
-.Lskip_sti:
 	tdcall
 
 	/*
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f4a59c3..8804174 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -220,7 +220,7 @@ static int ve_instr_len(struct ve_info *ve)
 	}
 }
 
-static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
+static u64 __cpuidle __halt(const bool irq_disabled)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -240,20 +240,14 @@ static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
 	 * can keep the vCPU in virtual HLT, even if an IRQ is
 	 * pending, without hanging/breaking the guest.
 	 */
-	return __tdx_hypercall(&args, do_sti ? TDX_HCALL_ISSUE_STI : 0);
+	return __tdx_hypercall(&args, 0);
 }
 
 static int handle_halt(struct ve_info *ve)
 {
-	/*
-	 * Since non safe halt is mainly used in CPU offlining
-	 * and the guest will always stay in the halt state, don't
-	 * call the STI instruction (set do_sti as false).
-	 */
 	const bool irq_disabled = irqs_disabled();
-	const bool do_sti = false;
 
-	if (__halt(irq_disabled, do_sti))
+	if (__halt(irq_disabled))
 		return -EIO;
 
 	return ve_instr_len(ve);
@@ -261,22 +255,13 @@ static int handle_halt(struct ve_info *ve)
 
 void __cpuidle tdx_safe_halt(void)
 {
-	 /*
-	  * For do_sti=true case, __tdx_hypercall() function enables
-	  * interrupts using the STI instruction before the TDCALL. So
-	  * set irq_disabled as false.
-	  */
 	const bool irq_disabled = false;
-	const bool do_sti = true;
 
 	/*
 	 * Use WARN_ONCE() to report the failure.
 	 */
-	if (__halt(irq_disabled, do_sti))
+	if (__halt(irq_disabled))
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
-
-	/* XXX I can't make sense of what @do_sti actually does */
-	raw_local_irq_disable();
 }
 
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index e53f262..5591768 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -8,7 +8,6 @@
 #define TDX_HYPERCALL_STANDARD  0
 
 #define TDX_HCALL_HAS_OUTPUT	BIT(0)
-#define TDX_HCALL_ISSUE_STI	BIT(1)
 
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
