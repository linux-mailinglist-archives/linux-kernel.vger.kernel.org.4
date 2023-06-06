Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A4724D65
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbjFFTnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbjFFTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:42:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAC410F1;
        Tue,  6 Jun 2023 12:42:42 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:42:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686080559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmfBFSf2C3LJhhefwC/O7pKNZ+pUInq+fA2/eX3pAKg=;
        b=xW8Z62iXSXz/CXoEyHyVDHw2jo2CTW225Wv2gbzAbuFq08SW32SVsDR5HP2lU8+U2GdpI9
        kN0Rr6TylVJPyZcuSg31vMGvH73oHW74ggo8UMm4T/O9HhYrhxEh1DTBVapCOb2nI/pj3e
        82iztNCkvL6pGZqLYvl9qTJU+oqf4EF+m7BhEFinPSoqeH+tIqEyVQOCw2YFrFtht7jJCv
        vobMmFdtpm+vS7hEhvraOz96miRSrC9zjqah7Eo2qpZ1ZZPhByfmId9g30MM/wLP1IQJQL
        S/zEf+GlwsDGg3B+Uk1cEtpZeazH6l3AkeR/8aougNM/nnq3H1iiPeHaTBuXAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686080559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmfBFSf2C3LJhhefwC/O7pKNZ+pUInq+fA2/eX3pAKg=;
        b=/2x9zyONgdi/Db4vOyZ0hq9EwW8UxjZg83uaToWcT3v+4a02V0dXmF8HEQdfEOm2WmVp3u
        GeVLMDulGGZbeeDw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/tdx: Make _tdx_hypercall() and __tdx_module_call()
 available in boot stub
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230606142637.5171-8-kirill.shutemov@linux.intel.com>
References: <20230606142637.5171-8-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168608055881.404.1921370774228488687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     ff40b5769a50fab654a70575ff0f49853b799b0e
Gitweb:        https://git.kernel.org/tip/ff40b5769a50fab654a70575ff0f49853b799b0e
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 06 Jun 2023 17:26:35 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 17:31:23 +02:00

x86/tdx: Make _tdx_hypercall() and __tdx_module_call() available in boot stub

Memory acceptance requires a hypercall and one or multiple module calls.

Make helpers for the calls available in boot stub. It has to accept
memory where kernel image and initrd are placed.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20230606142637.5171-8-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c           | 32 +-------------------
 arch/x86/include/asm/shared/tdx.h | 51 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/tdx.h        | 19 +-----------
 3 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e146b59..e6f4c27 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -14,20 +14,6 @@
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
 
-/* TDX module Call Leaf IDs */
-#define TDX_GET_INFO			1
-#define TDX_GET_VEINFO			3
-#define TDX_GET_REPORT			4
-#define TDX_ACCEPT_PAGE			6
-#define TDX_WR				8
-
-/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
-#define TDCS_NOTIFY_ENABLES		0x9100000000000010
-
-/* TDX hypercall Leaf IDs */
-#define TDVMCALL_MAP_GPA		0x10001
-#define TDVMCALL_REPORT_FATAL_ERROR	0x10003
-
 /* MMIO direction */
 #define EPT_READ	0
 #define EPT_WRITE	1
@@ -51,24 +37,6 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
-/*
- * Wrapper for standard use of __tdx_hypercall with no output aside from
- * return code.
- */
-static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
-{
-	struct tdx_hypercall_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = fn,
-		.r12 = r12,
-		.r13 = r13,
-		.r14 = r14,
-		.r15 = r15,
-	};
-
-	return __tdx_hypercall(&args);
-}
-
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __tdx_hypercall_failed(void)
 {
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 2631e01..1ff0ee8 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -10,6 +10,20 @@
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+/* TDX module Call Leaf IDs */
+#define TDX_GET_INFO			1
+#define TDX_GET_VEINFO			3
+#define TDX_GET_REPORT			4
+#define TDX_ACCEPT_PAGE			6
+#define TDX_WR				8
+
+/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
+#define TDCS_NOTIFY_ENABLES		0x9100000000000010
+
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
+#define TDVMCALL_REPORT_FATAL_ERROR	0x10003
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -37,8 +51,45 @@ struct tdx_hypercall_args {
 u64 __tdx_hypercall(struct tdx_hypercall_args *args);
 u64 __tdx_hypercall_ret(struct tdx_hypercall_args *args);
 
+/*
+ * Wrapper for standard use of __tdx_hypercall with no output aside from
+ * return code.
+ */
+static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = fn,
+		.r12 = r12,
+		.r13 = r13,
+		.r14 = r14,
+		.r15 = r15,
+	};
+
+	return __tdx_hypercall(&args);
+}
+
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void);
 
+/*
+ * Used in __tdx_module_call() to gather the output registers' values of the
+ * TDCALL instruction when requesting services from the TDX module. This is a
+ * software only structure and not part of the TDX module/VMM ABI
+ */
+struct tdx_module_output {
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+};
+
+/* Used to communicate with the TDX module */
+u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+		      struct tdx_module_output *out);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 28d889c..234197e 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -21,21 +21,6 @@
 #ifndef __ASSEMBLY__
 
 /*
- * Used to gather the output registers values of the TDCALL and SEAMCALL
- * instructions when requesting services from the TDX module.
- *
- * This is a software only structure and not part of the TDX module/VMM ABI.
- */
-struct tdx_module_output {
-	u64 rcx;
-	u64 rdx;
-	u64 r8;
-	u64 r9;
-	u64 r10;
-	u64 r11;
-};
-
-/*
  * Used by the #VE exception handler to gather the #VE exception
  * info from the TDX module. This is a software only structure
  * and not part of the TDX module/VMM ABI.
@@ -55,10 +40,6 @@ struct ve_info {
 
 void __init tdx_early_init(void);
 
-/* Used to communicate with the TDX module */
-u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-		      struct tdx_module_output *out);
-
 void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
