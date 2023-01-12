Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEEB666F45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbjALKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbjALKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:15:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8DB62E7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673518464; x=1705054464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LevyWGVkjbR3XtkwGaqhIDNbRXys+KmZlOUqinj8SNU=;
  b=ZuovMUXY6fnFmy0ZxxCgq8sGq4SPLSlFZSOrgn1mQYYXXlO8iflfKasJ
   oS985OVzy/VHlsAxmr4mdAySriRdm0V6XxT6uQZQDAw+gPfDGmtqW23qe
   Zf3wDgPQflyGswv/2Fmwajx8VKHHqXKyKVSwBq2L9xFedDzG7WZ95/QVy
   WM8m2SIotqTXcwFXYMSIQLHcAijvkvQdcESZVabRPRsKHjJf2SlsIWpam
   EhQBaMyaHpxZa3DyB03RErqzPvaDUkYxqUWoVk/xK+6kNjktkcEa71XDg
   Ai4Y2AoNf7NZja7xqR8zBOejgD57Of9RuQ5upMN+wldBIhmFGSkjETHxi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324899417"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="324899417"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="903128288"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="903128288"
Received: from glieseu-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.52.1])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:21 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B9318109AF7; Thu, 12 Jan 2023 13:14:13 +0300 (+03)
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
Subject: [PATCHv2 7/7] x86/tdx: Disable NOTIFY_ENABLES
Date:   Thu, 12 Jan 2023 13:14:07 +0300
Message-Id: <20230112101407.24327-8-kirill.shutemov@linux.intel.com>
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

== Background ==

There is a class of side-channel attacks against SGX enclaves called
"SGX Step"[1]. These attacks create lots of exceptions inside of
enclaves. Basically, run an in-enclave instruction, cause an exception.
Over and over.

There is a concern that a VMM could attack a TDX guest in the same way
by causing lots of #VE's. The TDX architecture includes new
countermeasures for these attacks. It basically counts the number of
exceptions and can send another *special* exception once the number of
VMM-induced #VE's hits a critical threshold[2].

== Problem ==

But, these special exceptions are independent of any action that the
guest takes. They can occur anywhere that the guest executes. This
includes sensitive areas like the entry code. The (non-paranoid) #VE
handler is incapable of handling exceptions in these areas.

== Solution ==

Fortunately, the special exceptions can be disabled by the guest via
write to NOTIFY_ENABLES TDCS field. NOTIFY_ENABLES is disabled by
default, but might be enabled by a bootloader, firmware or an earlier
kernel before the current kernel runs.

Disable NOTIFY_ENABLES feature explicitly and unconditionally. Any
NOTIFY_ENABLES-based #VE's that occur before this point will end up
in the early #VE exception handler and die due to unexpected exit
reason.

[1] https://github.com/jovanbulck/sgx-step
[2] https://intel.github.io/ccc-linux-guest-hardening-docs/security-spec.html#safety-against-ve-in-kernel-code

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
---
 arch/x86/coco/tdx/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 2f4fbb7cd990..d72176a7d3a0 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -19,6 +19,10 @@
 #define TDX_GET_VEINFO			3
 #define TDX_GET_REPORT			4
 #define TDX_ACCEPT_PAGE			6
+#define TDX_WR				8
+
+/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
+#define TDCS_NOTIFY_ENABLES		0x9100000000000010
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
@@ -863,6 +867,9 @@ void __init tdx_early_init(void)
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
 
+	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
+	tdx_module_call(TDX_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
+
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
 	 * as flag, not as part of physical address.
-- 
2.38.2

