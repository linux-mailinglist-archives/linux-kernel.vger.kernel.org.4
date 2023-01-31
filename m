Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21C3683682
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjAaT1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjAaT1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:27:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730413D61;
        Tue, 31 Jan 2023 11:27:15 -0800 (PST)
Date:   Tue, 31 Jan 2023 19:27:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675193234;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0HATiiLZYv74OfydVnW0IEt/f49Kgu+SS/ROn0/KEoI=;
        b=2DlZavsdfT9WXwTeNSTF1qRyDMYF8Q8H1YMbwx1z5tpiUe75qAMCFiHEk8wB/C8MxtsgOS
        RwVxqiomRkMooU1kPdAhmh/OLZuN3ZTt7KjFXz7vI2H/D7YAa9AcPXew8eoDGXgV6YzDBJ
        y1drgiVYeMe5yW2TkJsJoq1GwoojT3FLTdLMyDDFhRMkwCOPFGpaJBan5YV+Wjy6aJFg6D
        RTcd3ziutlX4y/YJso+XDNw1mqVQ5itEl7JtB/ep38M9ttQ1ZbTXADnGVsWOGU1cPQAVvD
        52cHoirs8duJ0se4foMaNSzb6TBwhZvLz0lp0+c4cdfKiogyPA6H+AfeLudlJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675193234;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0HATiiLZYv74OfydVnW0IEt/f49Kgu+SS/ROn0/KEoI=;
        b=kkDvkmvNc9IemmY+GUhavRN32IjUhzrAhuJEpb6fhEE6OTmFMRuK+sASQVWASnLTasW/ZY
        6gFHyy68hSmoFzCw==
From:   "tip-bot2 for Alexey Kardashevskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/amd: Cache debug register values in percpu variables
Cc:     Alexey Kardashevskiy <aik@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230120031047.628097-2-aik@amd.com>
References: <20230120031047.628097-2-aik@amd.com>
MIME-Version: 1.0
Message-ID: <167519323327.4906.15737370282542087502.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7914695743d598b189d549f2f57af24aa5633705
Gitweb:        https://git.kernel.org/tip/7914695743d598b189d549f2f57af24aa5633705
Author:        Alexey Kardashevskiy <aik@amd.com>
AuthorDate:    Fri, 20 Jan 2023 14:10:45 +11:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Jan 2023 20:09:26 +01:00

x86/amd: Cache debug register values in percpu variables

Reading DR[0-3]_ADDR_MASK MSRs takes about 250 cycles which is going to
be noticeable with the AMD KVM SEV-ES DebugSwap feature enabled.  KVM is
going to store host's DR[0-3] and DR[0-3]_ADDR_MASK before switching to
a guest; the hardware is going to swap these on VMRUN and VMEXIT.

Store MSR values passed to set_dr_addr_mask() in percpu variables
(when changed) and return them via new amd_get_dr_addr_mask().
The gain here is about 10x.

As set_dr_addr_mask() uses the array too, change the @dr type to
unsigned to avoid checking for <0. And give it the amd_ prefix to match
the new helper as the whole DR_ADDR_MASK feature is AMD-specific anyway.

While at it, replace deprecated boot_cpu_has() with cpu_feature_enabled()
in set_dr_addr_mask().

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230120031047.628097-2-aik@amd.com
---
 arch/x86/include/asm/debugreg.h |  9 ++++--
 arch/x86/kernel/cpu/amd.c       | 47 ++++++++++++++++++++++----------
 arch/x86/kernel/hw_breakpoint.c |  4 +--
 3 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index b049d95..f126b2e 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -126,9 +126,14 @@ static __always_inline void local_db_restore(unsigned long dr7)
 }
 
 #ifdef CONFIG_CPU_SUP_AMD
-extern void set_dr_addr_mask(unsigned long mask, int dr);
+extern void amd_set_dr_addr_mask(unsigned long mask, unsigned int dr);
+extern unsigned long amd_get_dr_addr_mask(unsigned int dr);
 #else
-static inline void set_dr_addr_mask(unsigned long mask, int dr) { }
+static inline void amd_set_dr_addr_mask(unsigned long mask, unsigned int dr) { }
+static inline unsigned long amd_get_dr_addr_mask(unsigned int dr)
+{
+	return 0;
+}
 #endif
 
 #endif /* _ASM_X86_DEBUGREG_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 208c2ce..380753b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1158,24 +1158,43 @@ static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 	return false;
 }
 
-void set_dr_addr_mask(unsigned long mask, int dr)
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[4], amd_dr_addr_mask);
+
+static unsigned int amd_msr_dr_addr_masks[] = {
+	MSR_F16H_DR0_ADDR_MASK,
+	MSR_F16H_DR1_ADDR_MASK,
+	MSR_F16H_DR1_ADDR_MASK + 1,
+	MSR_F16H_DR1_ADDR_MASK + 2
+};
+
+void amd_set_dr_addr_mask(unsigned long mask, unsigned int dr)
 {
-	if (!boot_cpu_has(X86_FEATURE_BPEXT))
+	int cpu = smp_processor_id();
+
+	if (!cpu_feature_enabled(X86_FEATURE_BPEXT))
 		return;
 
-	switch (dr) {
-	case 0:
-		wrmsr(MSR_F16H_DR0_ADDR_MASK, mask, 0);
-		break;
-	case 1:
-	case 2:
-	case 3:
-		wrmsr(MSR_F16H_DR1_ADDR_MASK - 1 + dr, mask, 0);
-		break;
-	default:
-		break;
-	}
+	if (WARN_ON_ONCE(dr >= ARRAY_SIZE(amd_msr_dr_addr_masks)))
+		return;
+
+	if (per_cpu(amd_dr_addr_mask, cpu)[dr] == mask)
+		return;
+
+	wrmsr(amd_msr_dr_addr_masks[dr], mask, 0);
+	per_cpu(amd_dr_addr_mask, cpu)[dr] = mask;
+}
+
+unsigned long amd_get_dr_addr_mask(unsigned int dr)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_BPEXT))
+		return 0;
+
+	if (WARN_ON_ONCE(dr >= ARRAY_SIZE(amd_msr_dr_addr_masks)))
+		return 0;
+
+	return per_cpu(amd_dr_addr_mask[dr], smp_processor_id());
 }
+EXPORT_SYMBOL_GPL(amd_get_dr_addr_mask);
 
 u32 amd_get_highest_perf(void)
 {
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index bbb0f73..b01644c 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -127,7 +127,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 
 	set_debugreg(*dr7, 7);
 	if (info->mask)
-		set_dr_addr_mask(info->mask, i);
+		amd_set_dr_addr_mask(info->mask, i);
 
 	return 0;
 }
@@ -166,7 +166,7 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 
 	set_debugreg(dr7, 7);
 	if (info->mask)
-		set_dr_addr_mask(0, i);
+		amd_set_dr_addr_mask(0, i);
 
 	/*
 	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
