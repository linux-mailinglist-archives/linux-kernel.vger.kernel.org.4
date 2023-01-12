Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396376671EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjALMRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjALMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:16:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A39F2607;
        Thu, 12 Jan 2023 04:16:35 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:16:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673525793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKCyVZ17DkWWOeoDYMPHKFx4KyBogrF+pRNES4m/olI=;
        b=uLB4KQC26r2xt1ga/Giy0y0YXDDsvf1rFh55DuL5AVv5qyTXKF+Jwvopr4YEWbZQY89gAg
        BAkdR6wVk3aQ5sctgtcdsS2vruo4bu4GBNZQeSSt6ol1v5EZwGE01sbt4aSQFrpVVeLwHi
        /WZ9TD+YKmWT9dNZiopHAFw4+oupf+0SHYU0Ytj6XKH8MGHRKH1tyBIlMhPoJmNI0mjSRm
        wvvhmBxOKNbvMN2ulX6uR1zcs3jg+g+Ar4mWR3Qw/Bi/IA7ksyTDmrn6y0DYzivXYlO0I7
        DMhRHNRDBCfpdTi5+ZmoQGrnZVMhsdE8T0gFXesA2qrqxk8QJdlQ65FHcUJAsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673525793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKCyVZ17DkWWOeoDYMPHKFx4KyBogrF+pRNES4m/olI=;
        b=YeHslwAn97vy8JaOMfJ2Cs5KQcr6jYV0oyFabeo6cH72U+CXw4r+ixv1qemZhGQ4k0+bb4
        HA+9ugYb/dm6SPDQ==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/gsseg: Move load_gs_index() to its own new header file
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Xin Li <xin3.li@intel.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230112072032.35626-5-xin3.li@intel.com>
References: <20230112072032.35626-5-xin3.li@intel.com>
MIME-Version: 1.0
Message-ID: <167352579260.4906.893581523646809362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ae53fa18703000f507107df43efd1168a0365361
Gitweb:        https://git.kernel.org/tip/ae53fa18703000f507107df43efd1168a0365361
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 11 Jan 2023 23:20:31 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Jan 2023 13:06:36 +01:00

x86/gsseg: Move load_gs_index() to its own new header file

GS is a special segment on x86_64, move load_gs_index() to its own new
header file to simplify header inclusion.

No change in functionality.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230112072032.35626-5-xin3.li@intel.com
---
 arch/x86/include/asm/gsseg.h         | 41 +++++++++++++++++++++++++++-
 arch/x86/include/asm/mmu_context.h   |  1 +-
 arch/x86/include/asm/special_insns.h | 21 +--------------
 arch/x86/kernel/paravirt.c           |  1 +-
 arch/x86/kernel/signal_32.c          |  1 +-
 arch/x86/kernel/tls.c                |  1 +-
 6 files changed, 45 insertions(+), 21 deletions(-)
 create mode 100644 arch/x86/include/asm/gsseg.h

diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
new file mode 100644
index 0000000..d15577c
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
index b8d40dd..e01aa74 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -12,6 +12,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
+#include <asm/gsseg.h>
 
 extern atomic64_t last_mm_ctx_id;
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index a71d0e8..cfd9499 100644
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
index 327757a..bdc886c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -32,6 +32,7 @@
 #include <asm/special_insns.h>
 #include <asm/tlb.h>
 #include <asm/io_bitmap.h>
+#include <asm/gsseg.h>
 
 /*
  * nop stub, which must not clobber anything *including the stack* to
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 2553136..bb4f3f3 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -31,6 +31,7 @@
 #include <asm/sigframe.h>
 #include <asm/sighandling.h>
 #include <asm/smap.h>
+#include <asm/gsseg.h>
 
 #ifdef CONFIG_IA32_EMULATION
 #include <asm/ia32_unistd.h>
diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index 3c883e0..3ffbab0 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -12,6 +12,7 @@
 #include <asm/ldt.h>
 #include <asm/processor.h>
 #include <asm/proto.h>
+#include <asm/gsseg.h>
 
 #include "tls.h"
 
