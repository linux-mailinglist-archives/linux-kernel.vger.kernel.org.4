Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650B65FA41D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJJTYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJJTXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:23:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6873606AB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665429832; x=1696965832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GoA9pNPB/aZ7nuj9piguDaWtAHjuR84sIzoHe1Tko9U=;
  b=OdhOtzHLpqTW1P+XW3ANwW0orA43rNd2tS0IaXYZaxeO0zg9e/wuGFj2
   1PGMpw/A47/1R9Ix8fS2Jqs/beA1YNKBSaHPCHKiL8NKBFb0IfzilUfYc
   5FWz8NfU4WYAu/R0ua3F4r4DHFIbpJm8bCIfVxVptPkj9sLHWWv0p33T+
   2lI6umwQHxGA76X4EZw2r2l/LbaN2/TN4/t3+dSrD7S917dbz2Ih/MXjE
   o9WBLfhcKdOkVsaNPKtHNjPyC+FOQs6lDU/ZW+fmPXjKOvfNLBwsVi0xK
   3O33Nk0IIKyvAq9aIAUB4OPyLBipRCuv27KQeRGkcfGgMVU3vgJZPqOIY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284044540"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="284044540"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 12:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="694762697"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="694762697"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2022 12:23:50 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org
Subject: [PATCH v2 6/6] x86/gsseg: use the LKGS instruction if available for load_gs_index()
Date:   Mon, 10 Oct 2022 12:01:59 -0700
Message-Id: <20221010190159.11920-7-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010190159.11920-1-xin3.li@intel.com>
References: <20221010190159.11920-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Xin Li <xin3.li@intel.com>
link: https://lkml.org/lkml/2022/10/7/352
link: https://lkml.org/lkml/2022/10/7/373
---
 arch/x86/include/asm/gsseg.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
index 5e3b56a17098..4aaef7a1d68f 100644
--- a/arch/x86/include/asm/gsseg.h
+++ b/arch/x86/include/asm/gsseg.h
@@ -3,15 +3,40 @@
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
+			    : ASM_CALL_CONSTRAINT
+			    : [sel] "D" (sel)
+			    : "memory", _ASM_AX);
 }
 
 #endif /* CONFIG_X86_64 */
-- 
2.34.1

