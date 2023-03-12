Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4726B6565
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCLL1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCLL0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:26:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928105292E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678620397; x=1710156397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HoVvsInTn5TZ+MT8glj3IrotSxRmkydAQ9cgijR6SG0=;
  b=ae//+b+q2Un1jllrUsL5mv3njV0zy/zZ8Jc/TPJOg9t+5bs0G62o9iC+
   II7V1pCu4cDrsBSJewmF1sM0RtfrvC9z/IhkwvySUuHpd/2BQp/HO8IHN
   rmUKUQa9EZh0Dayj4sDeFq0QbayzQ+eXNnHGwiH5DW9VkkYKcKHBgYOLl
   SV+R37K+hNz10+IMLRkov5/kdc9zr2ZrJLK5op7gxvukG3hW0M2RRAUSw
   rxMhNpJ2X9bXtl3IUl59BO3XKM0y1DiHVWrEuzjDKFSZ+saEnjZNpwTDv
   skp/ECCsM2CGWFbvayzcSvdh6ADV44jynUSsqn97vii2MTKXBRyqvsZp/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="339349957"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="339349957"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="852438031"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="852438031"
Received: from nmoazzen-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.219.215])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:30 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9992410D7B5; Sun, 12 Mar 2023 14:26:19 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv16 07/17] x86/mm: Reduce untagged_addr() overhead for systems without LAM
Date:   Sun, 12 Mar 2023 14:26:02 +0300
Message-Id: <20230312112612.31869-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use alternatives to reduce untagged_addr() overhead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/disabled-features.h |  8 ++++-
 arch/x86/include/asm/uaccess.h           | 41 +++++++++++++++++-------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 5dfa4fb76f4b..fafe9be7a6f4 100644
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
index c79ebdbd6356..457e814712af 100644
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
-- 
2.39.2

