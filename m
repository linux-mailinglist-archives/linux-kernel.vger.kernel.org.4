Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0DD5FA41E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJJTYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJJTXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:23:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187960693
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665429832; x=1696965832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=juR16UITaT3MxswvlHsDaympRivW8hA0yaAGOHpwels=;
  b=g8nrM80n4dYW4Xcs2GjTUl2gOZLoypFdfa98gjmbkKdJgsPrSE9M0m93
   mqdzUX+tGksW+YfTu+cDJR34PgyxiENf/Re8e+9btioczxCRcvIzq1CpK
   uU7zCnc/43oZYxZfQwBWdqolyR3CKWmHQzJWPYemoWnmtyF63ZlHKr4uV
   jkjGp/Uuk9+G9QkZS1q6wwwgheRuDxDG5bHcwDpagQgNxgxj8zaKVZ8xZ
   yaQzkUOi0iGuIY4IqIur5U/EWjEMPIG8Az11pe30L7JDBNzg11/5NqoPv
   iVWKFITQTip3wO5gcf5D5xb1MQwEwkuBsnWdmRFV4CSQ+ZwTXVmnmRbb6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284044538"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="284044538"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 12:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="694762695"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="694762695"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2022 12:23:50 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org
Subject: [PATCH v2 5/6] x86/gsseg: move load_gs_index() to its own header file
Date:   Mon, 10 Oct 2022 12:01:58 -0700
Message-Id: <20221010190159.11920-6-xin3.li@intel.com>
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

<asm/cpufeature.h> depends on <asm/special_insns.h>, so in order to be
able to use alternatives in native_load_gs_index(), factor it out into
a separate header file.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/ia32/ia32_signal.c          |  1 +
 arch/x86/include/asm/gsseg.h         | 32 ++++++++++++++++++++++++++++
 arch/x86/include/asm/mmu_context.h   |  1 +
 arch/x86/include/asm/special_insns.h | 17 ---------------
 arch/x86/kernel/paravirt.c           |  1 +
 arch/x86/kernel/tls.c                |  1 +
 6 files changed, 36 insertions(+), 17 deletions(-)
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
index 000000000000..5e3b56a17098
--- /dev/null
+++ b/arch/x86/include/asm/gsseg.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_GSSEG_H
+#define _ASM_X86_GSSEG_H
+
+#include <linux/types.h>
+#include <asm/processor.h>
+
+#ifdef CONFIG_X86_64
+
+extern asmlinkage void asm_load_gs_index(u16 selector);
+
+static inline void native_load_gs_index(unsigned int selector)
+{
+	asm_load_gs_index(selector);
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
index 6de00dec6564..cfd9499b617c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -120,13 +120,6 @@ static inline void native_wbinvd(void)
 	asm volatile("wbinvd": : :"memory");
 }
 
-extern asmlinkage void asm_load_gs_index(u16 selector);
-
-static inline void native_load_gs_index(unsigned int selector)
-{
-	asm_load_gs_index(selector);
-}
-
 static inline unsigned long __read_cr4(void)
 {
 	return native_read_cr4();
@@ -180,16 +173,6 @@ static inline void wbinvd(void)
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

