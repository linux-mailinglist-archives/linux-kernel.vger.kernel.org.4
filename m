Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7086F436A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjEBMLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjEBMLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:11:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6D5B92
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:10:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEB4121A20;
        Tue,  2 May 2023 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683029427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=68HytYcZlZwUKMdmIm0HdW7MUHwu5UcVeNGcmReZa2g=;
        b=umF1t+y17HbI/hb8VlpUUMdlhTXgGaM3TpQQr4UcbZuD8ORRnrW+kxUiBf9usGhak5FtQn
        rf3d5s8jXqB1aRIXlAIcGym0embRtXPiPtElTMTzdUzFvaP30+Ot2FR0QRelHU9bItLoWW
        Z5Ojd4Gz8KRWUfewxEMpo3otl6qmweY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD369139C3;
        Tue,  2 May 2023 12:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rFzdKLP9UGT0LwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 02 May 2023 12:10:27 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mikelley@microsoft.com, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 08/16] x86/mtrr: move 32-bit code from mtrr.c to legacy.c
Date:   Tue,  2 May 2023 14:09:23 +0200
Message-Id: <20230502120931.20719-9-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230502120931.20719-1-jgross@suse.com>
References: <20230502120931.20719-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some code in mtrr.c which is relevant for old 32-bit CPUs
only. Move it to a new source legacy.c.

While modifying mtrr_init_finalize() fix spelling of its name.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V6:
- new patch
---
 arch/x86/kernel/cpu/mtrr/Makefile |  2 +-
 arch/x86/kernel/cpu/mtrr/legacy.c | 84 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mtrr/mtrr.c   | 80 +++--------------------------
 arch/x86/kernel/cpu/mtrr/mtrr.h   |  7 +++
 4 files changed, 98 insertions(+), 75 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mtrr/legacy.c

diff --git a/arch/x86/kernel/cpu/mtrr/Makefile b/arch/x86/kernel/cpu/mtrr/Makefile
index cc4f9f1cb94c..aee4bc5ad496 100644
--- a/arch/x86/kernel/cpu/mtrr/Makefile
+++ b/arch/x86/kernel/cpu/mtrr/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y		:= mtrr.o if.o generic.o cleanup.o
-obj-$(CONFIG_X86_32) += amd.o cyrix.o centaur.o
+obj-$(CONFIG_X86_32) += amd.o cyrix.o centaur.o legacy.o
 
diff --git a/arch/x86/kernel/cpu/mtrr/legacy.c b/arch/x86/kernel/cpu/mtrr/legacy.c
new file mode 100644
index 000000000000..7d379fb26cce
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
index 3a38f34bf289..0eeb03d92d8c 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -545,49 +545,6 @@ int arch_phys_wc_index(int handle)
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
@@ -615,27 +572,10 @@ void __init mtrr_bp_init(void)
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
@@ -677,7 +617,7 @@ void mtrr_save_state(void)
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
 
-static int __init mtrr_init_finialize(void)
+static int __init mtrr_init_finalize(void)
 {
 	if (!mtrr_enabled())
 		return 0;
@@ -688,16 +628,8 @@ static int __init mtrr_init_finialize(void)
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
index 0dd11e41baa6..f626febeb545 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -61,6 +61,13 @@ void mtrr_set_mask(void);
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
-- 
2.35.3

