Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE738666F40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjALKPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbjALKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:15:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8929F2BC3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673518463; x=1705054463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oRXi0A8UvnI9/37rkmxYQJBeXqQb51nyJuKI+eZ9+L0=;
  b=LRVZ29Tfyj3Wl0uGBie3wyX5tY98zZjbNQ9hUTpDKwcUVuc4KR2CfPNq
   CNnL6jnLilgtAyok7W0PKACK7XGHlbX1fe77My3NGvvkqw2Elj0ZG2w33
   3tmIqdrDsO8DeIw0fQlHG8e27qLs4H4wTFU1KAIOm0mpvOr8BYUBsrQBv
   TWIxVPhn/K8kpBCufnFUiPfmScKC30spDWEf8PEAMUlIOeDcXcVs5RKSH
   Cj3PdIixFOyS4E4VBkrpcpsMP+vtAdzKCm6n7Qu8FCwJXunotllPvIVKI
   u1iZb7IhzBSJzdaFPc7lXP0XEH5zFNRT/LIACRB63W3iy3WYMr5oBtjs0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350892187"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="350892187"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659722914"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="659722914"
Received: from glieseu-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.52.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:20 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id AEE8A109AF6; Thu, 12 Jan 2023 13:14:13 +0300 (+03)
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
Subject: [PATCHv2 6/7] x86/tdx: Relax SEPT_VE_DISABLE check for debug TD
Date:   Thu, 12 Jan 2023 13:14:06 +0300
Message-Id: <20230112101407.24327-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230112101407.24327-1-kirill.shutemov@linux.intel.com>
References: <20230112101407.24327-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A "SEPT #VE" occurs when a TDX guest touches memory that is not properly
mapped into the "secure EPT".  This can be the result of hypervisor
attacks or bugs, *OR* guest bugs.  Most notably, buggy guests might
touch unaccepted memory for lots of different memory safety bugs like
buffer overflows.

TDX guests do not want to continue in the face of hypervisor attacks or
hypervisor bugs.  They want to terminate as fast and safely as possible.
SEPT_VE_DISABLE ensures that TDX guests *can't* continue in the face of
these kinds of issues.

But, that causes a problem.  TDX guests that can't continue can't spit
out oopses or other debugging info.  In essence SEPT_VE_DISABLE=1 guests
are not debuggable.

Relax the SEPT_VE_DISABLE check to warning on debug TD and panic() in
the #VE handler on EPT-violation on private memory. It will produce
useful backtrace.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 56accf653709..2f4fbb7cd990 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -38,6 +38,7 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
+#define ATTR_DEBUG		BIT(0)
 #define ATTR_SEPT_VE_DISABLE	BIT(28)
 
 /* TDX Module call error codes */
@@ -207,8 +208,15 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
 	 */
 	td_attr = out.rdx;
-	if (!(td_attr & ATTR_SEPT_VE_DISABLE))
-		tdx_panic("TD misconfiguration: SEPT_VE_DISABLE attribute must be set.");
+	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
+		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
+
+		/* Relax SEPT_VE_DISABLE check for debug TD. */
+		if (td_attr & ATTR_DEBUG)
+			pr_warn("%s\n", msg);
+		else
+			tdx_panic(msg);
+	}
 }
 
 /*
@@ -664,6 +672,11 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 	}
 }
 
+static inline bool is_private_gpa(u64 gpa)
+{
+	return gpa == cc_mkenc(gpa);
+}
+
 /*
  * Handle the kernel #VE.
  *
@@ -682,6 +695,8 @@ static int virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 	case EXIT_REASON_CPUID:
 		return handle_cpuid(regs, ve);
 	case EXIT_REASON_EPT_VIOLATION:
+		if (is_private_gpa(ve->gpa))
+			panic("Unexpected EPT-violation on private memory.");
 		return handle_mmio(regs, ve);
 	case EXIT_REASON_IO_INSTRUCTION:
 		return handle_io(regs, ve);
-- 
2.38.2

