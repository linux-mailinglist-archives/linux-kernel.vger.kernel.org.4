Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A336482C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiLINZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLINZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:25:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2E3D93D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670592337; x=1702128337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5keQeb9S+KFaicFjIjAGLohVdO9xiTEtldY0S8UVDYw=;
  b=EovttXS6iaIn9O5sYm0fZH0QypmTs2UndyTrZIFP8Gnm/NL1lDJsVoNU
   fL78QWfhBHr77ZjJgDTUsqtFzMg9LJNXm2wbI9Icv+nX/0EMvYsL6vMSP
   4cPJWtSJ0WxgZ46r7x6scxkcX+yQ+VEyP18VRGGXZFfSAlCgxWlO7s6Nm
   6Vq/sw86wqWJfJ4Kpb23GmoQINMNfaWmAvvqlK0hm4nmbvS/cC+4tVFyU
   fAPStuz99LTp5tEzp+OCCWac/wSL8hAYjRVWv5sKkuihVxhJ72hEqfPx8
   0TpfyMHse3vwq3AFO80OgpMSPtNtShBVRVC4V6pMieJVXkgDyw/1DvRVl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="317483303"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="317483303"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 05:25:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="892670378"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="892670378"
Received: from elinares-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.38.98])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 05:25:33 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4B536109CE4; Fri,  9 Dec 2022 16:25:31 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/4] x86/tdx: Use ReportFatalError to report missing SEPT_VE_DISABLE
Date:   Fri,  9 Dec 2022 16:25:22 +0300
Message-Id: <20221209132524.20200-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for SEPT_VE_DISABLE happens early in the kernel boot where
earlyprintk is not yet functional. Kernel successfully detect broken
TD configuration and stops the kernel with panic(), but it cannot
communicate the reason to the user.

Use TDG.VP.VMCALL<ReportFatalError> to report the error. The hypercall
can encode message up to 64 bytes in eight registers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index cfd4c95b9f04..8ad04d101270 100644
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
+	 * Keep calling the hypercall in case VMM did not terminated
+	 * the TD as it must.
+	 */
+	while (1) {
+		__tdx_hypercall(&args, 0);
+	}
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
-- 
2.38.0

