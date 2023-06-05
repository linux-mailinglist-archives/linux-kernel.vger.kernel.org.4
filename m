Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68D2722861
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjFEOJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjFEOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB9114;
        Mon,  5 Jun 2023 07:08:18 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ySiat6WU1J2CA4+tNRFmgwTIF7Allh68HcFpjr3VHw=;
        b=W9eTlqCWDINf5d6FlEaVwh+RxxzvfwpY1uc5mIkjjUzs4fAGIJjBg/3j2QAECRx03LdQJj
        AjrFUlMAscuFho8u4lo+lXG+fK9Swn5SGcvMXnn+byC2SdS1ps91iAWlVa0LWIgzYR2z22
        OEewDZ9Zzas31edepKeqqV/UaixpVEStI1BmfnovdRCISdU4y+7q3RbSR3KaqqzBjlzF5b
        t6kUKrx0zXyBSeVmY/D3/huzQQTEgpgpHlMmtQ6FQnRbEEp0Z7e9TetTk7gslu2XNZjgFs
        863c7UC3eTmx4PNeGGVQBtwh0aKr0381rRPZXVJnjG0vdb89N5DsA1wiSYcyIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ySiat6WU1J2CA4+tNRFmgwTIF7Allh68HcFpjr3VHw=;
        b=YGAqPfzS2sQ+AEFAaLWaI1h8bOLtgXjkYyvZzW+ORPB1HA9RSRh/Hv0cn9mtLdFkNnyyRw
        qk9ElqsT+P1f+YAA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Move 32-bit code from mtrr.c to legacy.c
Cc:     Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-9-jgross@suse.com>
References: <20230502120931.20719-9-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409561.404.2307944206335343244.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     b5d3c72829b1f2b181cd7c5b426f7deaae452045
Gitweb:        https://git.kernel.org/tip/b5d3c72829b1f2b181cd7c5b426f7deaae452045
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:23 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:33 +02:00

x86/mtrr: Move 32-bit code from mtrr.c to legacy.c

There is some code in mtrr.c which is relevant for old 32-bit CPUs
only. Move it to a new source legacy.c.

While modifying mtrr_init_finalize() fix spelling of its name.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-9-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mtrr/Makefile |  2 +-
 arch/x86/kernel/cpu/mtrr/legacy.c | 84 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mtrr/mtrr.c   | 80 ++---------------------------
 arch/x86/kernel/cpu/mtrr/mtrr.h   |  7 +++-
 4 files changed, 98 insertions(+), 75 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mtrr/legacy.c

diff --git a/arch/x86/kernel/cpu/mtrr/Makefile b/arch/x86/kernel/cpu/mtrr/Makefile
index cc4f9f1..aee4bc5 100644
--- a/arch/x86/kernel/cpu/mtrr/Makefile
+++ b/arch/x86/kernel/cpu/mtrr/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y		:= mtrr.o if.o generic.o cleanup.o
-obj-$(CONFIG_X86_32) += amd.o cyrix.o centaur.o
+obj-$(CONFIG_X86_32) += amd.o cyrix.o centaur.o legacy.o
 
diff --git a/arch/x86/kernel/cpu/mtrr/legacy.c b/arch/x86/kernel/cpu/mtrr/legacy.c
new file mode 100644
index 0000000..7d379fb
--- /dev/null
+++ b/arch/x86/kernel/cpu/mtrr/legacy.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/types.h>
+#include <linux/syscore_ops.h>
+#include <asm/cpufeature.h>
+#include <asm/mtrr.h>
+#include <asm/processor.h>
+#include "mtrr.h"
+
+void mtrr_set_if(void)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		/* Pre-Athlon (K6) AMD CPU MTRRs */
+		if (cpu_feature_enabled(X86_FEATURE_K6_MTRR))
+			mtrr_if = &amd_mtrr_ops;
+		break;
+	case X86_VENDOR_CENTAUR:
+		if (cpu_feature_enabled(X86_FEATURE_CENTAUR_MCR))
+			mtrr_if = &centaur_mtrr_ops;
+		break;
+	case X86_VENDOR_CYRIX:
+		if (cpu_feature_enabled(X86_FEATURE_CYRIX_ARR))
+			mtrr_if = &cyrix_mtrr_ops;
+		break;
+	default:
+		break;
+	}
+}
+
+/*
+ * The suspend/resume methods are only for CPUs without MTRR. CPUs using generic
+ * MTRR driver don't require this.
+ */
+struct mtrr_value {
+	mtrr_type	ltype;
+	unsigned long	lbase;
+	unsigned long	lsize;
+};
+
+static struct mtrr_value mtrr_value[MTRR_MAX_VAR_RANGES];
+
+static int mtrr_save(void)
+{
+	int i;
+
+	for (i = 0; i < num_var_ranges; i++) {
+		mtrr_if->get(i, &mtrr_value[i].lbase,
+				&mtrr_value[i].lsize,
+				&mtrr_value[i].ltype);
+	}
+	return 0;
+}
+
+static void mtrr_restore(void)
+{
+	int i;
+
+	for (i = 0; i < num_var_ranges; i++) {
+		if (mtrr_value[i].lsize) {
+			mtrr_if->set(i, mtrr_value[i].lbase,
+				     mtrr_value[i].lsize,
+				     mtrr_value[i].ltype);
+		}
+	}
+}
+
+static struct syscore_ops mtrr_syscore_ops = {
+	.suspend	= mtrr_save,
+	.resume		= mtrr_restore,
+};
+
+void mtrr_register_syscore(void)
+{
+	/*
+	 * The CPU has no MTRR and seems to not support SMP. They have
+	 * specific drivers, we use a tricky method to support
+	 * suspend/resume for them.
+	 *
+	 * TBD: is there any system with such CPU which supports
+	 * suspend/resume? If no, we should remove the code.
+	 */
+	register_syscore_ops(&mtrr_syscore_ops);
+}
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 007ecca..b7793a4 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -541,49 +541,6 @@ int arch_phys_wc_index(int handle)
 }
 EXPORT_SYMBOL_GPL(arch_phys_wc_index);
 
-/* The suspend/resume methods are only for CPU without MTRR. CPU using generic
- * MTRR driver doesn't require this
- */
-struct mtrr_value {
-	mtrr_type	ltype;
-	unsigned long	lbase;
-	unsigned long	lsize;
-};
-
-static struct mtrr_value mtrr_value[MTRR_MAX_VAR_RANGES];
-
-static int mtrr_save(void)
-{
-	int i;
-
-	for (i = 0; i < num_var_ranges; i++) {
-		mtrr_if->get(i, &mtrr_value[i].lbase,
-				&mtrr_value[i].lsize,
-				&mtrr_value[i].ltype);
-	}
-	return 0;
-}
-
-static void mtrr_restore(void)
-{
-	int i;
-
-	for (i = 0; i < num_var_ranges; i++) {
-		if (mtrr_value[i].lsize) {
-			mtrr_if->set(i, mtrr_value[i].lbase,
-				     mtrr_value[i].lsize,
-				     mtrr_value[i].ltype);
-		}
-	}
-}
-
-
-
-static struct syscore_ops mtrr_syscore_ops = {
-	.suspend	= mtrr_save,
-	.resume		= mtrr_restore,
-};
-
 int __initdata changed_by_mtrr_cleanup;
 
 /**
@@ -611,27 +568,10 @@ void __init mtrr_bp_init(void)
 		return;
 	}
 
-	if (generic_mtrrs) {
+	if (generic_mtrrs)
 		mtrr_if = &generic_mtrr_ops;
-	} else {
-		switch (boot_cpu_data.x86_vendor) {
-		case X86_VENDOR_AMD:
-			/* Pre-Athlon (K6) AMD CPU MTRRs */
-			if (cpu_feature_enabled(X86_FEATURE_K6_MTRR))
-				mtrr_if = &amd_mtrr_ops;
-			break;
-		case X86_VENDOR_CENTAUR:
-			if (cpu_feature_enabled(X86_FEATURE_CENTAUR_MCR))
-				mtrr_if = &centaur_mtrr_ops;
-			break;
-		case X86_VENDOR_CYRIX:
-			if (cpu_feature_enabled(X86_FEATURE_CYRIX_ARR))
-				mtrr_if = &cyrix_mtrr_ops;
-			break;
-		default:
-			break;
-		}
-	}
+	else
+		mtrr_set_if();
 
 	if (mtrr_enabled()) {
 		/* Get the number of variable MTRR ranges. */
@@ -673,7 +613,7 @@ void mtrr_save_state(void)
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
 
-static int __init mtrr_init_finialize(void)
+static int __init mtrr_init_finalize(void)
 {
 	if (!mtrr_enabled())
 		return 0;
@@ -684,16 +624,8 @@ static int __init mtrr_init_finialize(void)
 		return 0;
 	}
 
-	/*
-	 * The CPU has no MTRR and seems to not support SMP. They have
-	 * specific drivers, we use a tricky method to support
-	 * suspend/resume for them.
-	 *
-	 * TBD: is there any system with such CPU which supports
-	 * suspend/resume? If no, we should remove the code.
-	 */
-	register_syscore_ops(&mtrr_syscore_ops);
+	mtrr_register_syscore();
 
 	return 0;
 }
-subsys_initcall(mtrr_init_finialize);
+subsys_initcall(mtrr_init_finalize);
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 6f3312b..e1e8864 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -61,6 +61,13 @@ extern u32 phys_hi_rsvd;
 void mtrr_state_warn(void);
 const char *mtrr_attrib_to_str(int x);
 void mtrr_wrmsr(unsigned, unsigned, unsigned);
+#ifdef CONFIG_X86_32
+void mtrr_set_if(void);
+void mtrr_register_syscore(void);
+#else
+static inline void mtrr_set_if(void) { }
+static inline void mtrr_register_syscore(void) { }
+#endif
 
 /* CPU specific mtrr_ops vectors. */
 extern const struct mtrr_ops amd_mtrr_ops;
