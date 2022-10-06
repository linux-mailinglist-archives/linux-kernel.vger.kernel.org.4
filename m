Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982B15F6B23
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiJFQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiJFQDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:03:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFDFAE228
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665072187; x=1696608187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TYDLP/WLagDk6RRKpxF1aIZ7QTqIfIktvLR1UyU4GrE=;
  b=g3QiBSh2sWgslY+YgKSUpLOo+GKlO1AsiQRinu6nZGFUpr0jMJHgtmvX
   uVk2hAPAuGTSEkzmlfMrKd3TV8S1IjRzr3Rd5Ntt6t345UBgFGSr+n9pb
   E50aY82ocCXPlWcc7Vz2u2vE9B2ezTCM6qbVgnxyMPYMGQ4Ng27T4+Bg8
   lXt/naDrQuKBziNjFNAwfn02/5jD+LKUbYY40BU6MSC/WhqcOrivNApg/
   YhXWkX69oCZcHr4m2BOU82O3ESiRKVtUq3XObxrnAIFivXxr8Msuco6zQ
   Nvnagk82J1gg3LWrVbX0DV1OPor8k6PNayyCA3H1n2Tn8OlmINSppxjnh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="286709428"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="286709428"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 09:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="687486237"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="687486237"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2022 09:02:36 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Subject: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for load_gs_index()
Date:   Thu,  6 Oct 2022 08:40:41 -0700
Message-Id: <20221006154041.13001-7-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006154041.13001-1-xin3.li@intel.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

The LKGS instruction atomically loads a segment descriptor into the
%gs descriptor registers, *except* that %gs.base is unchanged, and the
base is instead loaded into MSR_IA32_KERNEL_GS_BASE, which is exactly
what we want this function to do.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/gsseg.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
index 5e3b56a17098..b8a6a98d88b8 100644
--- a/arch/x86/include/asm/gsseg.h
+++ b/arch/x86/include/asm/gsseg.h
@@ -3,15 +3,41 @@
 #define _ASM_X86_GSSEG_H
 
 #include <linux/types.h>
+
+#include <asm/asm.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative.h>
 #include <asm/processor.h>
+#include <asm/nops.h>
 
 #ifdef CONFIG_X86_64
 
 extern asmlinkage void asm_load_gs_index(u16 selector);
 
+#define LKGS_DI	_ASM_BYTES(0xf2,0x0f,0x00,0xf7)
+
 static inline void native_load_gs_index(unsigned int selector)
 {
-	asm_load_gs_index(selector);
+	u16 sel = selector;
+
+	/*
+	 * Note: the fixup is used for the LKGS instruction, but
+	 * it needs to be attached to the primary instruction sequence
+	 * as it isn't something that gets patched.
+	 *
+	 * %rax is provided to the assembly routine as a scratch
+	 * register.
+	 */
+	alternative_io("1: call asm_load_gs_index\n"
+		       ".pushsection \".fixup\",\"ax\"\n"
+		       "2:	xorl %k[sel], %k[sel]\n"
+		       "	jmp 1b\n"
+		       ".popsection\n"
+		       _ASM_EXTABLE(1b, 2b),
+		       _ASM_BYTES(0x3e) LKGS_DI,
+		       X86_FEATURE_LKGS,
+		       ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT),
+		       ASM_NO_INPUT_CLOBBER(_ASM_AX));
 }
 
 #endif /* CONFIG_X86_64 */
-- 
2.34.1

