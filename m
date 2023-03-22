Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5120C6C51DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjCVRFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjCVREf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:04:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EEF65135;
        Wed, 22 Mar 2023 10:03:51 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679504587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=edp4sA8P2SeTyb0SGU+QuEOamlFlg79W7OTGRixB7Og=;
        b=KXrbtHPssTbaO9apAZDqMZeeWyMNj+4Z51dlK8txaU6mx5vlRWZuGuDnjGwp0LxclQjxzB
        Js1+2bp5N+x78UH+KQZVF0sgKKKzvb09dKwuMSNgrzMUJwCBtyjmbiJCRV7NGwS1WQR0zI
        R6SK8x9lmfg1dwKxQCTg1If1zVXyKvwtQO6d7q7QEeyV1vs3tcctHjYNgR8JDXJHOQbIoL
        hv/5iwvqOWdK9jB2O0rIE5ZbD/XgvRo4P82d8+avchC4Q2InP8OlP91rLHeKb765TjbC6C
        cWUYnQMYWVwI5tSMDp/D23LngVF8ZKtlgsnFe3WdBgIp8i0HaxZ+LvhwlFHLeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679504587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=edp4sA8P2SeTyb0SGU+QuEOamlFlg79W7OTGRixB7Og=;
        b=fjLWQZOeP1usF/QnNO1Efsy9cmDPxaChH9QfF5Low+CmNziVpa2MONCiV565UC2mVoNlw6
        tZxGlekVEdQNjkDg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Reduce untagged_addr() overhead for systems without LAM
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950458737.5837.5944537315353690399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     e0bddc19ba9578bc4e4c60a3f29ccc227277854c
Gitweb:        https://git.kernel.org/tip/e0bddc19ba9578bc4e4c60a3f29ccc227277854c
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 12 Mar 2023 14:26:02 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 13:08:39 -07:00

x86/mm: Reduce untagged_addr() overhead for systems without LAM

Use alternatives to reduce untagged_addr() overhead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230312112612.31869-8-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/disabled-features.h |  8 +++-
 arch/x86/include/asm/uaccess.h           | 41 ++++++++++++++++-------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 5dfa4fb..fafe9be 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -75,6 +75,12 @@
 # define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
 #endif
 
+#ifdef CONFIG_ADDRESS_MASKING
+# define DISABLE_LAM		0
+#else
+# define DISABLE_LAM		(1 << (X86_FEATURE_LAM & 31))
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 # define DISABLE_ENQCMD		0
 #else
@@ -115,7 +121,7 @@
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING)
-#define DISABLED_MASK12	0
+#define DISABLED_MASK12	(DISABLE_LAM)
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c79ebdb..457e814 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -9,6 +9,7 @@
 #include <linux/kasan-checks.h>
 #include <linux/mm_types.h>
 #include <linux/string.h>
+#include <linux/mmap_lock.h>
 #include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/smap.h>
@@ -30,26 +31,44 @@ static inline bool pagefault_disabled(void);
  * Magic with the 'sign' allows to untag userspace pointer without any branches
  * while leaving kernel addresses intact.
  */
-static inline unsigned long __untagged_addr(unsigned long addr,
-					    unsigned long mask)
+static inline unsigned long __untagged_addr(unsigned long addr)
 {
-	long sign = addr >> 63;
+	long sign;
+
+	/*
+	 * Refer tlbstate_untag_mask directly to avoid RIP-relative relocation
+	 * in alternative instructions. The relocation gets wrong when gets
+	 * copied to the target place.
+	 */
+	asm (ALTERNATIVE("",
+			 "sar $63, %[sign]\n\t" /* user_ptr ? 0 : -1UL */
+			 "or %%gs:tlbstate_untag_mask, %[sign]\n\t"
+			 "and %[sign], %[addr]\n\t", X86_FEATURE_LAM)
+	     : [addr] "+r" (addr), [sign] "=r" (sign)
+	     : "m" (tlbstate_untag_mask), "[sign]" (addr));
 
-	addr &= mask | sign;
 	return addr;
 }
 
 #define untagged_addr(addr)	({					\
-	u64 __addr = (__force u64)(addr);				\
-	__addr = __untagged_addr(__addr, current_untag_mask());		\
-	(__force __typeof__(addr))__addr;				\
+	unsigned long __addr = (__force unsigned long)(addr);		\
+	(__force __typeof__(addr))__untagged_addr(__addr);		\
 })
 
+static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
+						   unsigned long addr)
+{
+	long sign = addr >> 63;
+
+	mmap_assert_locked(mm);
+	addr &= (mm)->context.untag_mask | sign;
+
+	return addr;
+}
+
 #define untagged_addr_remote(mm, addr)	({				\
-	u64 __addr = (__force u64)(addr);				\
-	mmap_assert_locked(mm);						\
-	__addr = __untagged_addr(__addr, (mm)->context.untag_mask);	\
-	(__force __typeof__(addr))__addr;				\
+	unsigned long __addr = (__force unsigned long)(addr);		\
+	(__force __typeof__(addr))__untagged_addr_remote(mm, __addr);	\
 })
 
 #else
