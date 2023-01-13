Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095D166933D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbjAMJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbjAMJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:47:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D6A69B10;
        Fri, 13 Jan 2023 01:36:57 -0800 (PST)
Date:   Fri, 13 Jan 2023 09:36:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673602616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXuL1K66hVbbl9oh0JbPD/eGxNZzYXrhlx9eaWy4U8I=;
        b=y2e+r1z/cqcPUoWXtGQeq+zFge5v/TfLp7Rzbgh92sI1uNdJEVJl657Sv62XMBV6u1Fbul
        f8A/dl/IbQqFagqv/h41yeDmr8VVVMpOqBomTOt4HWn7zunkYTsyj9BOAX9qwGOZErCQ3Q
        B8n8civBxxHSWW7RafznrXCNXa+Xvgb98dFFZpFOn9xqxjxGdqw8/yPVaE+7zbPaoDh7MG
        LJFyAMsJj1euqH5lkNdp8AMSSKV7L1uxzAABVXNbkVWnWWG3HZD73CGLM/iTYxrF4T6Mko
        VBm3VrPwJU+agYmMlq4RWTen50a7czOKG6ZPGBrChlmrbHcL2MOUNcGG6BKPHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673602616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXuL1K66hVbbl9oh0JbPD/eGxNZzYXrhlx9eaWy4U8I=;
        b=54cZ1Z8JGlCzBYnaPnskvMgbrVBTDUsjBPjNdVREMh9sgn553DHY4FBjNW05AiGtKnF5+f
        VHf6C7RPe+TT9fBw==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/gsseg: Use the LKGS instruction if available for
 load_gs_index()
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Xin Li <xin3.li@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112072032.35626-6-xin3.li@intel.com>
References: <20230112072032.35626-6-xin3.li@intel.com>
MIME-Version: 1.0
Message-ID: <167360261521.4906.1537966381271124611.tip-bot2@tip-bot2>
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

Commit-ID:     92cbbadf73f45c5d8bb26ed8668ff59671ff21e6
Gitweb:        https://git.kernel.org/tip/92cbbadf73f45c5d8bb26ed8668ff59671ff21e6
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 11 Jan 2023 23:20:32 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 10:07:27 +01:00

x86/gsseg: Use the LKGS instruction if available for load_gs_index()

The LKGS instruction atomically loads a segment descriptor into the
%gs descriptor registers, *except* that %gs.base is unchanged, and the
base is instead loaded into MSR_IA32_KERNEL_GS_BASE, which is exactly
what we want this function to do.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230112072032.35626-6-xin3.li@intel.com
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/gsseg.h | 33 +++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/common.c |  1 +
 arch/x86/xen/enlighten_pv.c  |  1 +
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
index d15577c..ab6a595 100644
--- a/arch/x86/include/asm/gsseg.h
+++ b/arch/x86/include/asm/gsseg.h
@@ -14,17 +14,42 @@
 
 extern asmlinkage void asm_load_gs_index(u16 selector);
 
+/* Replace with "lkgs %di" once binutils support LKGS instruction */
+#define LKGS_DI _ASM_BYTES(0xf2,0x0f,0x00,0xf7)
+
+static inline void native_lkgs(unsigned int selector)
+{
+	u16 sel = selector;
+	asm_inline volatile("1: " LKGS_DI
+			    _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_REG, %k[sel])
+			    : [sel] "+D" (sel));
+}
+
 static inline void native_load_gs_index(unsigned int selector)
 {
-	unsigned long flags;
+	if (cpu_feature_enabled(X86_FEATURE_LKGS)) {
+		native_lkgs(selector);
+	} else {
+		unsigned long flags;
 
-	local_irq_save(flags);
-	asm_load_gs_index(selector);
-	local_irq_restore(flags);
+		local_irq_save(flags);
+		asm_load_gs_index(selector);
+		local_irq_restore(flags);
+	}
 }
 
 #endif /* CONFIG_X86_64 */
 
+static inline void __init lkgs_init(void)
+{
+#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_X86_64
+	if (cpu_feature_enabled(X86_FEATURE_LKGS))
+		pv_ops.cpu.load_gs_index = native_lkgs;
+#endif
+#endif
+}
+
 #ifndef CONFIG_PARAVIRT_XXL
 
 static inline void load_gs_index(unsigned int selector)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d..b7ac85a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1960,6 +1960,7 @@ void __init identify_boot_cpu(void)
 	setup_cr_pinning();
 
 	tsx_init();
+	lkgs_init();
 }
 
 void identify_secondary_cpu(struct cpuinfo_x86 *c)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5b13796..ce2f19e 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -276,6 +276,7 @@ static void __init xen_init_capabilities(void)
 	setup_clear_cpu_cap(X86_FEATURE_ACC);
 	setup_clear_cpu_cap(X86_FEATURE_X2APIC);
 	setup_clear_cpu_cap(X86_FEATURE_SME);
+	setup_clear_cpu_cap(X86_FEATURE_LKGS);
 
 	/*
 	 * Xen PV would need some work to support PCID: CR3 handling as well
