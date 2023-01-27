Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953E567ED84
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjA0S2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjA0S2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:28:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEE084FA5;
        Fri, 27 Jan 2023 10:27:28 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:26:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674844016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QU3D1MVl4nF12dfqXKBPUAzNEWPP6wcbOhCTHK/byU8=;
        b=BR2yPxn5qEXFU3+oe32J7VXsBmiWCfl8fN0gB5HX2tQIZmxAwIVEbjq/88AmEm3XA8Us2m
        a+WUlhreRnAIkvEB0jMpTvOETBlJvOcGdHugvHtkukIHPqQLpTl4dK41QJ2d5zv8Dtt0c/
        iReCVYsUNw/U1gJxlhFKYbSD7Y1CC0MG5z32ybixvOeaDsXfgTTA0iMKV2Jm7LvWm8qOgW
        rnktT/c4tSL9a4TPqAMa4cBpeb2XjkeozfGp9DfF7wHYSqrnpQpOqKOcNCEh0Cx850+0EK
        lgDrXku48e+Oc5f1q2+/GxNUvNp3vCR3ayCgYo/AsrwU2sfaccf9MaTAhMThJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674844016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QU3D1MVl4nF12dfqXKBPUAzNEWPP6wcbOhCTHK/byU8=;
        b=IC/19wwIS/2KBYmfmmyc0PGI1+9wb+6uiRyMwAVhaqoPYSnVM5pmzDAaGJcUhero2qidIj
        t1oBPU1CATpC7ZAQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Use ReportFatalError to report missing
 SEPT_VE_DISABLE
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167484401624.4906.9634557672121237563.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     71acdcd7cd0abee7698c2d5e5a8a66602a00b12c
Gitweb:        https://git.kernel.org/tip/71acdcd7cd0abee7698c2d5e5a8a66602a00b12c
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 27 Jan 2023 01:11:57 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 27 Jan 2023 09:45:55 -08:00

x86/tdx: Use ReportFatalError to report missing SEPT_VE_DISABLE

Linux TDX guests require that the SEPT_VE_DISABLE "attribute" be set.
If it is not set, the kernel is theoretically required to handle
exceptions anywhere that kernel memory is accessed, including places
like NMI handlers and in the syscall entry gap.

Rather than even try to handle these exceptions, the kernel refuses to
run if SEPT_VE_DISABLE is unset.

However, the SEPT_VE_DISABLE detection and refusal code happens very
early in boot, even before earlyprintk runs.  Calling panic() will
effectively just hang the system.

Instead, call a TDX-specific panic() function.  This makes a very simple
TDVMCALL which gets a short error string out to the hypervisor without
any console infrastructure.

Use TDG.VP.VMCALL<ReportFatalError> to report the error. The hypercall
can encode message up to 64 bytes in eight registers.

[ dhansen: tweak comment and remove while loop brackets. ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230126221159.8635-6-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 669d9e4..fbb9913 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -22,6 +22,7 @@
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
+#define TDVMCALL_REPORT_FATAL_ERROR	0x10003
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -140,6 +141,41 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 }
 EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
 
+static void __noreturn tdx_panic(const char *msg)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = TDVMCALL_REPORT_FATAL_ERROR,
+		.r12 = 0, /* Error code: 0 is Panic */
+	};
+	union {
+		/* Define register order according to the GHCI */
+		struct { u64 r14, r15, rbx, rdi, rsi, r8, r9, rdx; };
+
+		char str[64];
+	} message;
+
+	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
+	strncpy(message.str, msg, 64);
+
+	args.r8  = message.r8;
+	args.r9  = message.r9;
+	args.r14 = message.r14;
+	args.r15 = message.r15;
+	args.rdi = message.rdi;
+	args.rsi = message.rsi;
+	args.rbx = message.rbx;
+	args.rdx = message.rdx;
+
+	/*
+	 * This hypercall should never return and it is not safe
+	 * to keep the guest running. Call it forever if it
+	 * happens to return.
+	 */
+	while (1)
+		__tdx_hypercall(&args, 0);
+}
+
 static void tdx_parse_tdinfo(u64 *cc_mask)
 {
 	struct tdx_module_output out;
@@ -172,7 +208,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 */
 	td_attr = out.rdx;
 	if (!(td_attr & ATTR_SEPT_VE_DISABLE))
-		panic("TD misconfiguration: SEPT_VE_DISABLE attibute must be set.\n");
+		tdx_panic("TD misconfiguration: SEPT_VE_DISABLE attribute must be set.");
 }
 
 /*
