Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE16561142E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJ1OMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJ1OMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:12:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490E21C811D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666966351; x=1698502351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JE7pYb0iyhrn1PbMnI0l9LTThn2Yh8uAqjKnOua3gYk=;
  b=NSSmMzr4mzNYR7nqtwRMQpvl6iYJ4VHaMRd5o5RUvlXn+cLLhoLn+OdQ
   5ms7PN77qol8nDP7rpyj3HLqidAA+qMoFu676Va60G3DNb0TQYXmTB7yt
   cY5DchAbZtbXlta0NUqrV+bHyiVrypbUeFUXaUFUPFMX6Xw+lIs2O33dR
   Jtb1LQiDI3oWPdHjz1QZ+p2NBXR1gyVzl/MSWLGhfOXbcFAGRu6iBgI0X
   JZpexYsq7zdEQi2dwFi8sl4h1adToh4JQGepGwLzeT57mNI6EOkpX6t5L
   n75l7WUr08mTWr76iR3r+TnID/BcaV2oddar2BLB1y509dQEKW0hwyakU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="335142691"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="335142691"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 07:12:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="583936260"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="583936260"
Received: from snehalde-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.229])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 07:12:24 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 13F0A104D5B; Fri, 28 Oct 2022 17:12:22 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] x86/tdx: Extract GET_INFO call from get_cc_mask()
Date:   Fri, 28 Oct 2022 17:12:19 +0300
Message-Id: <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

TDCALL [TDG.VP.INFO] is used to get details like gpa_width,
TD attributes, etc.

So far only gpa_width was needed to enumerate the shared bit, but
upcoming changes will need TD attributes too.

Extract GET_INFO call out of get_cc_mask() into a separate helper and
save attributes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 928dcf7a20d9..343d60853b71 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -34,6 +34,12 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
+/* Caches GPA width from TDG.VP.INFO TDCALL */
+static unsigned int gpa_width __ro_after_init;
+
+/* Caches TD Attributes from TDG.VP.INFO TDCALL */
+static u64 td_attr __ro_after_init;
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -98,17 +104,16 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
-static u64 get_cc_mask(void)
+static void tdx_parse_tdinfo(void)
 {
 	struct tdx_module_output out;
-	unsigned int gpa_width;
 
 	/*
 	 * TDINFO TDX module call is used to get the TD execution environment
 	 * information like GPA width, number of available vcpus, debug mode
-	 * information, etc. More details about the ABI can be found in TDX
-	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
-	 * [TDG.VP.INFO].
+	 * information, TD attributes etc. More details about the ABI can be
+	 * found in TDX Guest-Host-Communication Interface (GHCI), section
+	 * 2.4.2 TDCALL [TDG.VP.INFO].
 	 *
 	 * The GPA width that comes out of this call is critical. TDX guests
 	 * can not meaningfully run without it.
@@ -116,7 +121,11 @@ static u64 get_cc_mask(void)
 	tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out);
 
 	gpa_width = out.rcx & GENMASK(5, 0);
+	td_attr = out.rdx;
+}
 
+static u64 get_cc_mask(void)
+{
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
 	 * Set it for shared pages and clear it for private pages.
@@ -755,6 +764,12 @@ void __init tdx_early_init(void)
 	if (memcmp(TDX_IDENT, sig, sizeof(sig)))
 		return;
 
+	/*
+	 * Initializes gpa_width and td_attr. Must be called before
+	 * get_cc_mask() or attribute checks.
+	 */
+	tdx_parse_tdinfo();
+
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
 	cc_set_vendor(CC_VENDOR_INTEL);
-- 
2.38.0

