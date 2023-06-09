Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E223772A26A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjFIShb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjFIShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:37:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F783A99
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686335829; x=1717871829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=13cn72a/wCkpmzunPjxPIh2qs4h8VINUpDvsn4MEd2k=;
  b=Zon+hOPsd+2vbS2D8HCN1G3YYn01M0ne26rxfPPrAu0lfnXPbP98O98D
   H3gA6rTyvSnjCO3ZnkdHDj6aS6B0snGEiJT6kZQlf7DOMtT0OTameaUNf
   DXneOeeSKDbiCH1CrrTmPEYWLs8ZH+jvowIeDPCltEP/kxg/lg7GeFMHa
   BwehYmryttPDQxPf3oi5RMRXDGmDXyiR92WAkYWBvFyLn9BZWRqVQz+t8
   ascfRoqnXEFgG+ur+UsqOmkKL0xwqV9/LJcpRKRFo7pj7E5zFzmaiZFtd
   hkvaEAG7V0oRO0AU6/XCDa8EmB0VU8Uw7Q74DcPo/bMx9tr69WmzOu9nX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338022156"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="338022156"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 11:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="710444037"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="710444037"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2023 11:37:06 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 06/12] x86/vsyscall: Reorganize the #PF emulation code
Date:   Fri,  9 Jun 2023 21:36:26 +0300
Message-Id: <20230609183632.48706-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sohil Mehta <sohil.mehta@intel.com>

Separate out the actual vsyscall emulation from the page fault specific
handling in preparation for the upcoming #GP fault emulation.

Export is_vsyscall_vaddr() so that it can be reused later.

No functional change intended.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 51 +++++++++++++++++----------
 arch/x86/include/asm/vsyscall.h       | 10 +++---
 arch/x86/mm/fault.c                   | 13 ++-----
 3 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index e0ca8120aea8..dd112e538992 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -82,6 +82,15 @@ static void warn_bad_vsyscall(const char *level, struct pt_regs *regs,
 			   regs->sp, regs->ax, regs->si, regs->di);
 }
 
+/*
+ * The (legacy) vsyscall page is the long page in the kernel portion
+ * of the address space that has user-accessible permissions.
+ */
+bool is_vsyscall_vaddr(unsigned long vaddr)
+{
+	return unlikely((vaddr & PAGE_MASK) == VSYSCALL_ADDR);
+}
+
 static int addr_to_vsyscall_nr(unsigned long addr)
 {
 	int nr;
@@ -117,8 +126,7 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 	}
 }
 
-bool emulate_vsyscall(unsigned long error_code,
-		      struct pt_regs *regs, unsigned long address)
+static bool __emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 {
 	struct task_struct *tsk;
 	unsigned long caller;
@@ -127,22 +135,6 @@ bool emulate_vsyscall(unsigned long error_code,
 	long ret;
 	unsigned long orig_dx;
 
-	/* Write faults or kernel-privilege faults never get fixed up. */
-	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
-		return false;
-
-	if (!(error_code & X86_PF_INSTR)) {
-		/* Failed vsyscall read */
-		if (vsyscall_mode == EMULATE)
-			return false;
-
-		/*
-		 * User code tried and failed to read the vsyscall page.
-		 */
-		warn_bad_vsyscall(KERN_INFO, regs, "vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround");
-		return false;
-	}
-
 	/*
 	 * No point in checking CS -- the only way to get here is a user mode
 	 * trap to a high address, which means that we're in 64-bit user code.
@@ -294,6 +286,29 @@ bool emulate_vsyscall(unsigned long error_code,
 	return true;
 }
 
+bool emulate_vsyscall_pf(unsigned long error_code, struct pt_regs *regs,
+			 unsigned long address)
+{
+	/* Write faults or kernel-privilege faults never get fixed up. */
+	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
+		return false;
+
+	if (!(error_code & X86_PF_INSTR)) {
+		/* Failed vsyscall read */
+		if (vsyscall_mode == EMULATE)
+			return false;
+
+		/*
+		 * User code tried and failed to read the vsyscall page.
+		 */
+		warn_bad_vsyscall(KERN_INFO, regs,
+				  "vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround");
+		return false;
+	}
+
+	return __emulate_vsyscall(regs, address);
+}
+
 /*
  * A pseudo VMA to allow ptrace access for the vsyscall page.  This only
  * covers the 64bit vsyscall page now. 32bit has a real VMA now and does
diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index ab60a71a8dcb..667b280afc1a 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -5,6 +5,8 @@
 #include <linux/seqlock.h>
 #include <uapi/asm/vsyscall.h>
 
+extern bool is_vsyscall_vaddr(unsigned long vaddr);
+
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
 extern void map_vsyscall(void);
 extern void set_vsyscall_pgtable_user_bits(pgd_t *root);
@@ -13,12 +15,12 @@ extern void set_vsyscall_pgtable_user_bits(pgd_t *root);
  * Called on instruction fetch fault in vsyscall page.
  * Returns true if handled.
  */
-extern bool emulate_vsyscall(unsigned long error_code,
-			     struct pt_regs *regs, unsigned long address);
+extern bool emulate_vsyscall_pf(unsigned long error_code,
+				struct pt_regs *regs, unsigned long address);
 #else
 static inline void map_vsyscall(void) {}
-static inline bool emulate_vsyscall(unsigned long error_code,
-				    struct pt_regs *regs, unsigned long address)
+static inline bool emulate_vsyscall_pf(unsigned long error_code,
+				       struct pt_regs *regs, unsigned long address)
 {
 	return false;
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e4399983c50c..645eb3323f34 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -730,7 +730,7 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 		 * Per the above we're !in_interrupt(), aka. task context.
 		 *
 		 * In this case we need to make sure we're not recursively
-		 * faulting through the emulate_vsyscall() logic.
+		 * faulting through the emulate_vsyscall_pf() logic.
 		 */
 		if (current->thread.sig_on_uaccess_err && signal) {
 			sanitize_error_code(address, &error_code);
@@ -798,15 +798,6 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 	show_opcodes(regs, loglvl);
 }
 
-/*
- * The (legacy) vsyscall page is the long page in the kernel portion
- * of the address space that has user-accessible permissions.
- */
-static bool is_vsyscall_vaddr(unsigned long vaddr)
-{
-	return unlikely((vaddr & PAGE_MASK) == VSYSCALL_ADDR);
-}
-
 static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address, u32 pkey, int si_code)
@@ -1329,7 +1320,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * to consider the PF_PK bit.
 	 */
 	if (is_vsyscall_vaddr(address)) {
-		if (emulate_vsyscall(error_code, regs, address))
+		if (emulate_vsyscall_pf(error_code, regs, address))
 			return;
 	}
 #endif
-- 
2.39.2

