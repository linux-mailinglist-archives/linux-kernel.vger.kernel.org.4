Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069EA5FE335
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJMUYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJMUXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:23:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8C5159D58
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665692611; x=1697228611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGOoMAJR5hBAKRpXEvmTbPxECjoZohq6t2fBwrzA0Pw=;
  b=c8gqwewCizdqpOO43cn1Vo6lTXO68K7gzlcG7pw7BSVEabvn3VHNYMSk
   fI2NSKKEivg7z1ZNItiT0QtsFnTY6/VzHHLmWxAj3Zcdi4fVjfQ/tGu16
   WarjQuCRbMM2koMzkDouyYhIk9DQ37weDcvrTI30QfnogAgJMzriQqxWo
   ozwpiFqXFSGnVph8+c19LMu10yd9Mm/A4urMXnenyRFaGCIMAw/3DG3pU
   RZsXMFGETzgmLN7xe9AxNhQGiH2qRB7O5K79plkn24y/GBjJ5BFAhRoGq
   XoWo4sS6ckjw/cRi0hnJ45oTh3CFEhPHV0kH7rvaiTADuqIMKWUoWYLJ0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="302808970"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="302808970"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 13:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="690271053"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="690271053"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 13 Oct 2022 13:23:28 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com
Subject: [PATCH v3 6/6] x86/gsseg: use the LKGS instruction if available for load_gs_index()
Date:   Thu, 13 Oct 2022 13:01:34 -0700
Message-Id: <20221013200134.1487-7-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013200134.1487-1-xin3.li@intel.com>
References: <20221013200134.1487-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
link: https://lkml.org/lkml/2022/10/7/352
link: https://lkml.org/lkml/2022/10/7/373
link: https://lkml.org/lkml/2022/10/10/1286
---
 arch/x86/include/asm/gsseg.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
index 5e3b56a17098..7463ac65ef56 100644
--- a/arch/x86/include/asm/gsseg.h
+++ b/arch/x86/include/asm/gsseg.h
@@ -3,15 +3,39 @@
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
 
+/* Replace with "lkgs %di" once binutils support LKGS instruction */
+#define LKGS_DI _ASM_BYTES(0xf2,0x0f,0x00,0xf7)
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
+	asm_inline volatile("1:\n"
+			    ALTERNATIVE("call asm_load_gs_index\n",
+					_ASM_BYTES(0x3e) LKGS_DI,
+					X86_FEATURE_LKGS)
+			    _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_REG, %k[sel])
+			    : ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT)
+			    : : _ASM_AX);
 }
 
 #endif /* CONFIG_X86_64 */
-- 
2.34.1

