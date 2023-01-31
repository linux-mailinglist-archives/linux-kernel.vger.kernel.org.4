Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84B682F21
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjAaOXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjAaOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:22:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068B8227BE;
        Tue, 31 Jan 2023 06:22:31 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675174949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIK6h1KtCD8rcXT0b011MAZsKo8KXw2KFk2eTEW6GPs=;
        b=slof44rc3eWWU/WuZj9MtjapNPbZRcBfswkwWAQ623al5j/rJ/Tc/ZREOyau2E6Uv+nScV
        0RUcbTDqyNz4MKYkwDq+NNWzOubZ9EeXBv9r2Fy5R55ZcPStThTi4WSD0b+xX4ATxDDhfa
        rCDh6MQDo06QXmKfpIJ7MdoYzbXheYsSQ6K32cp3YkeBNehMLbMyLAsGS1QW9jm/tHG5Z1
        uJj5dAO9GXuXsqMu4sRmFHj1iLwYI5rBXl27jVAmXJ+xTTP5uqlwgtJvFN6Gdn3F9gw2er
        nF1NBMCqoM7EFBztPMDhT1OYN5naVAiq5grftq1dE6Hdidp1GtB7nIpF30n/kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675174949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIK6h1KtCD8rcXT0b011MAZsKo8KXw2KFk2eTEW6GPs=;
        b=QxZJbH+U1SzLTgoCsa3Guo8aqcARSQP0zUr7TqQoAeJ3g2rqdLHecbM2d28wIYGPVTDNHL
        rnBccCzxgqxlurDA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle: drivers: firmware: psci: Dont instrument
 suspend code
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126151323.349423061@infradead.org>
References: <20230126151323.349423061@infradead.org>
MIME-Version: 1.0
Message-ID: <167517494867.4906.2717215016942079366.tip-bot2@tip-bot2>
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

Commit-ID:     393e2ea30aec634b37004d401863428e120d5e1b
Gitweb:        https://git.kernel.org/tip/393e2ea30aec634b37004d401863428e120d5e1b
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Thu, 26 Jan 2023 16:08:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 31 Jan 2023 15:01:45 +01:00

cpuidle: drivers: firmware: psci: Dont instrument suspend code

The PSCI suspend code is currently instrumentable, which is not safe as
instrumentation (e.g. ftrace) may try to make use of RCU during idle
periods when RCU is not watching.

To fix this we need to ensure that psci_suspend_finisher() and anything
it calls are not instrumented. We can do this fairly simply by marking
psci_suspend_finisher() and the psci*_cpu_suspend() functions as
noinstr, and the underlying helper functions as __always_inline.

When CONFIG_DEBUG_VIRTUAL=y, __pa_symbol() can expand to an out-of-line
instrumented function, so we must use __pa_symbol_nodebug() within
psci_suspend_finisher().

The raw SMCCC invocation functions are written in assembly, and are not
subject to compiler instrumentation.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230126151323.349423061@infradead.org
---
 drivers/firmware/psci/psci.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index aef76d8..29619f4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -108,9 +108,10 @@ bool psci_power_state_is_valid(u32 state)
 	return !(state & ~valid_mask);
 }
 
-static unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
-			unsigned long arg0, unsigned long arg1,
-			unsigned long arg2)
+static __always_inline unsigned long
+__invoke_psci_fn_hvc(unsigned long function_id,
+		     unsigned long arg0, unsigned long arg1,
+		     unsigned long arg2)
 {
 	struct arm_smccc_res res;
 
@@ -118,9 +119,10 @@ static unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
 	return res.a0;
 }
 
-static unsigned long __invoke_psci_fn_smc(unsigned long function_id,
-			unsigned long arg0, unsigned long arg1,
-			unsigned long arg2)
+static __always_inline unsigned long
+__invoke_psci_fn_smc(unsigned long function_id,
+		     unsigned long arg0, unsigned long arg1,
+		     unsigned long arg2)
 {
 	struct arm_smccc_res res;
 
@@ -128,7 +130,7 @@ static unsigned long __invoke_psci_fn_smc(unsigned long function_id,
 	return res.a0;
 }
 
-static int psci_to_linux_errno(int errno)
+static __always_inline int psci_to_linux_errno(int errno)
 {
 	switch (errno) {
 	case PSCI_RET_SUCCESS:
@@ -169,7 +171,8 @@ int psci_set_osi_mode(bool enable)
 	return psci_to_linux_errno(err);
 }
 
-static int __psci_cpu_suspend(u32 fn, u32 state, unsigned long entry_point)
+static __always_inline int
+__psci_cpu_suspend(u32 fn, u32 state, unsigned long entry_point)
 {
 	int err;
 
@@ -177,13 +180,15 @@ static int __psci_cpu_suspend(u32 fn, u32 state, unsigned long entry_point)
 	return psci_to_linux_errno(err);
 }
 
-static int psci_0_1_cpu_suspend(u32 state, unsigned long entry_point)
+static __always_inline int
+psci_0_1_cpu_suspend(u32 state, unsigned long entry_point)
 {
 	return __psci_cpu_suspend(psci_0_1_function_ids.cpu_suspend,
 				  state, entry_point);
 }
 
-static int psci_0_2_cpu_suspend(u32 state, unsigned long entry_point)
+static __always_inline int
+psci_0_2_cpu_suspend(u32 state, unsigned long entry_point)
 {
 	return __psci_cpu_suspend(PSCI_FN_NATIVE(0_2, CPU_SUSPEND),
 				  state, entry_point);
@@ -450,10 +455,12 @@ late_initcall(psci_debugfs_init)
 #endif
 
 #ifdef CONFIG_CPU_IDLE
-static int psci_suspend_finisher(unsigned long state)
+static noinstr int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
-	phys_addr_t pa_cpu_resume = __pa_symbol(cpu_resume);
+	phys_addr_t pa_cpu_resume;
+
+	pa_cpu_resume = __pa_symbol_nodebug((unsigned long)cpu_resume);
 
 	return psci_ops.cpu_suspend(power_state, pa_cpu_resume);
 }
