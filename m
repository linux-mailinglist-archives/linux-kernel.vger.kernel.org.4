Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059096482C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLINZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLINZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:25:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64403D939
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670592336; x=1702128336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pqHHbopmGNY5t74exyfAEgTwAvM3lKXws1pSWDVVq7U=;
  b=eiOtqLsqmiWyw/fKhuxkgg6TNRgyamHYXpC3EB+r2rMD+VBop8LIutWA
   g6j2Gs5mLtDpfjMNXvO/6lHiQ9GDtMJ2OmKIc66O0RUTbblA4qntosWiU
   RWiY+OlJONjuaU9gX1BmMKagabvJfcMgUDWx6eiOcomteBGxeHXSxWIu5
   0husm3qHGTk+KRa4RmHzbsBoAvQ4Pd97ou2zTI3OHOUNsJSTO5Dj6U+SZ
   Khm0sfc+gh8gvorP4ZK5i02085+CIzVs5JUd5OOEkcIaAxd6jOcICDXBN
   aSBEXrush8R/FTqNdZzxMCsB9yMFxGcyVlukZstbSaBah7UVq2vXysJ/p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="317483308"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="317483308"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 05:25:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="892670376"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="892670376"
Received: from elinares-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.38.98])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 05:25:33 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 54B84109CE5; Fri,  9 Dec 2022 16:25:31 +0300 (+03)
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
Subject: [PATCH 3/4] x86/tdx: Relax SEPT_VE_DISABLE check for debug TD
Date:   Fri,  9 Dec 2022 16:25:23 +0300
Message-Id: <20221209132524.20200-4-kirill.shutemov@linux.intel.com>
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

SEPT_VE_DISABLE check is required to keep the TD protected from VMM
attacks, but it makes harder to debug guest kernel bugs. If guest
touches unaccepted memory the TD will get terminated without any
traces on what has happened.

Relax the SEPT_VE_DISABLE check to warning on debug TD and panic() in
the #VE handler on EPT-violation on private memory. It will produce
useful backtrace.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 8ad04d101270..0e47846ff8ff 100644
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
@@ -682,6 +690,8 @@ static int virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 	case EXIT_REASON_CPUID:
 		return handle_cpuid(regs, ve);
 	case EXIT_REASON_EPT_VIOLATION:
+		if (ve->gpa != cc_mkdec(ve->gpa))
+			panic("Unexpected EPT-violation on private memory.");
 		return handle_mmio(regs, ve);
 	case EXIT_REASON_IO_INSTRUCTION:
 		return handle_io(regs, ve);
-- 
2.38.0

