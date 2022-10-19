Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B16604309
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiJSLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiJSLSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:18:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6F191D73
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666176521; x=1697712521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j1nrWwUKj7h3R57+EPy6Nb6HTjf2lvY1jPi2BPfuQLU=;
  b=Yo4vx2MmaUJcxTMargud/XUOTPm00ViPMyaSic9loJinc1ph1ANXNV3o
   IfpHsUvMrzSgg5qn4YVFM/KpXtig92kGYA0E7Yn+zEnGIWwEwbUgbLFxn
   LbI/Kt+pmFtxJupvHLmNCb6BWiFyDa3C2wGGKDG5aQXY5JrCHHNKI3Wc3
   y8z8k1XXbdJEjri+Hq7SH67rAlbcY4Z2R5AatEuW1F4X3lj5xvauRWeg5
   1N6SLEOxHoplJ0hXdkOA887u4kAOYvhfnRFWHv3gVsU4XXA2IpK4V7TB3
   MfQiA1ccDQYAHjXaw+A/VwunJ507uoD8mFBprJ7tiO499UhcDAkLgxEs3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293770260"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="293770260"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 03:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="804242264"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="804242264"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2022 03:46:22 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com
Subject: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available for load_gs_index()
Date:   Wed, 19 Oct 2022 03:23:10 -0700
Message-Id: <20221019102310.1543-6-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019102310.1543-1-xin3.li@intel.com>
References: <20221019102310.1543-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
---

Changes since v3:
* We want less ASM not more, thus keep local_irq_save/restore() inside
  native_load_gs_index() (Thomas Gleixner).
* For paravirt enabled kernels, initialize pv_ops.cpu.load_gs_index to
  native_lkgs (Thomas Gleixner).

Changes since V2:
* Mark DI as input and output (+D) as in V1, since the exception handler
  modifies it (Brian Gerst).

Changes since V1:
* Use EX_TYPE_ZERO_REG instead of fixup code in the obsolete .fixup code
  section (Peter Zijlstra).
* Add a comment that states the LKGS_DI macro will be repalced with "lkgs %di"
  once the binutils support the LKGS instruction (Peter Zijlstra).
---
 arch/x86/include/asm/gsseg.h | 33 +++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/common.c |  1 +
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
index d15577c39e8d..ab6a595cea70 100644
--- a/arch/x86/include/asm/gsseg.h
+++ b/arch/x86/include/asm/gsseg.h
@@ -14,17 +14,42 @@
 
 extern asmlinkage void asm_load_gs_index(u16 selector);
 
+/* Replace with "lkgs %di" once binutils support LKGS instruction */
+#define LKGS_DI _ASM_BYTES(0xf2,0x0f,0x00,0xf7)
+
+static inline void native_lkgs(unsigned int selector)
+{
+	u16 sel = selector;
+	asm_inline volatile("1: " LKGS_DI
+			    _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_REG, %k[sel])
+			    : [sel] "+D" (sel));
+}
+
 static inline void native_load_gs_index(unsigned int selector)
 {
-	unsigned long flags;
+	if (cpu_feature_enabled(X86_FEATURE_LKGS)) {
+		native_lkgs(selector);
+	} else {
+		unsigned long flags;
 
-	local_irq_save(flags);
-	asm_load_gs_index(selector);
-	local_irq_restore(flags);
+		local_irq_save(flags);
+		asm_load_gs_index(selector);
+		local_irq_restore(flags);
+	}
 }
 
 #endif /* CONFIG_X86_64 */
 
+static inline void __init lkgs_init(void)
+{
+#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_X86_64
+	if (cpu_feature_enabled(X86_FEATURE_LKGS))
+		pv_ops.cpu.load_gs_index = native_lkgs;
+#endif
+#endif
+}
+
 #ifndef CONFIG_PARAVIRT_XXL
 
 static inline void load_gs_index(unsigned int selector)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..d6eb4f60b47d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1939,6 +1939,7 @@ void __init identify_boot_cpu(void)
 	setup_cr_pinning();
 
 	tsx_init();
+	lkgs_init();
 }
 
 void identify_secondary_cpu(struct cpuinfo_x86 *c)
-- 
2.34.1

