Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A090D60430C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJSLUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiJSLSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:18:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D34E191D61
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666176515; x=1697712515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3IzxOY7iZxpDqFZXqjU2m7iuBaRk3oOqMz/MsyK/kHA=;
  b=XwYLXZkpZneXmRhMZUiCrW8gxX9uiSBEoOgRJn23Lugwkb4WiRHPp6de
   f58JTifqaobAKQBts53YS+W+vwmuclgdrNAip24JkRkVJNIVIoqH74Ik0
   W5ldWL6FxN4n/tqJsMlS9nVLTMzF8ZAjjPi0/qldYdxU1zCNRhjWbvq4I
   XdZ2n4emmMLr3CNLMaVcd/3YEO1JdXC1+Tkyox1kZz8H8y+pjnKsfy/H8
   8O3OnNCKeWRLL+QfN45DdkuH3SrGcPL3ClyWozUImzhyCLTkz99y4WVic
   tvfQgoOG0GXq+Jm+YEcf9npBtYbs7l/PlO8+50QbLSom3+3AEygXWJY+L
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293770259"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="293770259"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 03:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="804242258"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="804242258"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2022 03:46:21 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com
Subject: [PATCH v4 4/5] x86/gsseg: move load_gs_index() to its own new header file
Date:   Wed, 19 Oct 2022 03:23:09 -0700
Message-Id: <20221019102310.1543-5-xin3.li@intel.com>
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

GS is a special segment on x86_64, move load_gs_index() to its own new
header file.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/ia32/ia32_signal.c          |  1 +
 arch/x86/include/asm/gsseg.h         | 41 ++++++++++++++++++++++++++++
 arch/x86/include/asm/mmu_context.h   |  1 +
 arch/x86/include/asm/special_insns.h | 21 --------------
 arch/x86/kernel/paravirt.c           |  1 +
 arch/x86/kernel/tls.c                |  1 +
 6 files changed, 45 insertions(+), 21 deletions(-)
 create mode 100644 arch/x86/include/asm/gsseg.h

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index c9c3859322fa..14c739303099 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -34,6 +34,7 @@
 #include <asm/sigframe.h>
 #include <asm/sighandling.h>
 #include <asm/smap.h>
+#include <asm/gsseg.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
new file mode 100644
index 000000000000..d15577c39e8d
--- /dev/null
+++ b/arch/x86/include/asm/gsseg.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_GSSEG_H
+#define _ASM_X86_GSSEG_H
+
+#include <linux/types.h>
+
+#include <asm/asm.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative.h>
+#include <asm/processor.h>
+#include <asm/nops.h>
+
+#ifdef CONFIG_X86_64
+
+extern asmlinkage void asm_load_gs_index(u16 selector);
+
+static inline void native_load_gs_index(unsigned int selector)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	asm_load_gs_index(selector);
+	local_irq_restore(flags);
+}
+
+#endif /* CONFIG_X86_64 */
+
+#ifndef CONFIG_PARAVIRT_XXL
+
+static inline void load_gs_index(unsigned int selector)
+{
+#ifdef CONFIG_X86_64
+	native_load_gs_index(selector);
+#else
+	loadsegment(gs, selector);
+#endif
+}
+
+#endif /* CONFIG_PARAVIRT_XXL */
+
+#endif /* _ASM_X86_GSSEG_H */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b8d40ddeab00..e01aa74a6de7 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -12,6 +12,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
+#include <asm/gsseg.h>
 
 extern atomic64_t last_mm_ctx_id;
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index a71d0e8d4684..cfd9499b617c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -120,17 +120,6 @@ static inline void native_wbinvd(void)
 	asm volatile("wbinvd": : :"memory");
 }
 
-extern asmlinkage void asm_load_gs_index(u16 selector);
-
-static inline void native_load_gs_index(unsigned int selector)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	asm_load_gs_index(selector);
-	local_irq_restore(flags);
-}
-
 static inline unsigned long __read_cr4(void)
 {
 	return native_read_cr4();
@@ -184,16 +173,6 @@ static inline void wbinvd(void)
 	native_wbinvd();
 }
 
-
-static inline void load_gs_index(unsigned int selector)
-{
-#ifdef CONFIG_X86_64
-	native_load_gs_index(selector);
-#else
-	loadsegment(gs, selector);
-#endif
-}
-
 #endif /* CONFIG_PARAVIRT_XXL */
 
 static inline void clflush(volatile void *__p)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7ca2d46c08cc..00f6a92551d2 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -32,6 +32,7 @@
 #include <asm/special_insns.h>
 #include <asm/tlb.h>
 #include <asm/io_bitmap.h>
+#include <asm/gsseg.h>
 
 /*
  * nop stub, which must not clobber anything *including the stack* to
diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index 3c883e064242..3ffbab0081f4 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -12,6 +12,7 @@
 #include <asm/ldt.h>
 #include <asm/processor.h>
 #include <asm/proto.h>
+#include <asm/gsseg.h>
 
 #include "tls.h"
 
-- 
2.34.1

