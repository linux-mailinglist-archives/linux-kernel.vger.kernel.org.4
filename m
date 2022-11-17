Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9120E62E73B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbiKQVnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbiKQVna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:43:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2921025;
        Thu, 17 Nov 2022 13:43:27 -0800 (PST)
Date:   Thu, 17 Nov 2022 21:43:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668721406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e1EptTRRDZWJPGJ1JeZSDbsVVsKPz/WMABLqUp0/9uc=;
        b=ewbMtQFGcZ3oIfwVOmzkIvD6WoKj7AWjdWKXuEkjIAQ73tBznZsBDblRrGfJ8KPm7BcOUM
        I1kraZoWaGagK82bPQTYpkgBiLsqn3vI4l8wmZHsCMHdKB3giC1v3uYVHuadlW8a34nTP2
        3aIpC6crjUpNs0WOYCoZVVCGuKP6kX1D3zJ6/3f5T3HuKuGnS5BqxEUGJg7BiPnmjPjlMr
        oXAFEOYIyfhCceayqCpUpUYKhV94GtbdBA6lpMrztnnTFDfb7+0dj4Ntp1f40kOCGV1iaW
        aSWLY4GVogAkhB23l/Ny+gGtFyMmo1StPZ+wpNQei6uXzF76i8PfI2nZW7C0mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668721406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e1EptTRRDZWJPGJ1JeZSDbsVVsKPz/WMABLqUp0/9uc=;
        b=XzL7nxdn81wb/lX0WzkD+2zue+yOTkGWJ91WAX8HltF9A5Zjz1nlmxfdRxR8WeDTHFt8d1
        NE7doVPWQDCdZ1Bw==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Add a wrapper to get TDREPORT0 from the TDX Module
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166872140508.4906.7190539793443618681.tip-bot2@tip-bot2>
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

Commit-ID:     51acfe89af1118f906f9b68d95fdfb22832ac960
Gitweb:        https://git.kernel.org/tip/51acfe89af1118f906f9b68d95fdfb22832ac960
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Wed, 16 Nov 2022 14:38:18 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Nov 2022 11:03:09 -08:00

x86/tdx: Add a wrapper to get TDREPORT0 from the TDX Module

To support TDX attestation, the TDX guest driver exposes an IOCTL
interface to allow userspace to get the TDREPORT0 (a.k.a. TDREPORT
subtype 0) from the TDX module via TDG.MR.TDREPORT TDCALL.

In order to get the TDREPORT0 in the TDX guest driver, instead of using
a low level function like __tdx_module_call(), add a
tdx_mcall_get_report0() wrapper function to handle it.

This is a preparatory patch for adding attestation support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Wander Lairson Costa <wander@redhat.com>
Link: https://lore.kernel.org/all/20221116223820.819090-2-sathyanarayanan.kuppuswamy%40linux.intel.com
---
 arch/x86/coco/tdx/tdx.c    | 40 +++++++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/tdx.h |  2 ++-
 2 files changed, 42 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b8998cf..cfd4c95 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -5,6 +5,8 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/export.h>
+#include <linux/io.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -15,6 +17,7 @@
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
+#define TDX_GET_REPORT			4
 #define TDX_ACCEPT_PAGE			6
 
 /* TDX hypercall Leaf IDs */
@@ -36,6 +39,12 @@
 
 #define ATTR_SEPT_VE_DISABLE	BIT(28)
 
+/* TDX Module call error codes */
+#define TDCALL_RETURN_CODE(a)	((a) >> 32)
+#define TDCALL_INVALID_OPERAND	0xc0000100
+
+#define TDREPORT_SUBTYPE_0	0
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -100,6 +109,37 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/**
+ * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
+ *                           subtype 0) using TDG.MR.REPORT TDCALL.
+ * @reportdata: Address of the input buffer which contains user-defined
+ *              REPORTDATA to be included into TDREPORT.
+ * @tdreport: Address of the output buffer to store TDREPORT.
+ *
+ * Refer to section titled "TDG.MR.REPORT leaf" in the TDX Module
+ * v1.0 specification for more information on TDG.MR.REPORT TDCALL.
+ * It is used in the TDX guest driver module to get the TDREPORT0.
+ *
+ * Return 0 on success, -EINVAL for invalid operands, or -EIO on
+ * other TDCALL failures.
+ */
+int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
+{
+	u64 ret;
+
+	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
+				virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
+				0, NULL);
+	if (ret) {
+		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+			return -EINVAL;
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
+
 static void tdx_parse_tdinfo(u64 *cc_mask)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 020c81a..28d889c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,8 @@ void tdx_safe_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
+int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
+
 #else
 
 static inline void tdx_early_init(void) { };
