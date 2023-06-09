Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B3572A26D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjFIShn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjFISh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:37:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B7E3C1B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686335834; x=1717871834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rt9yrRSSQctOLo3XiuDMAeXvCUu9OQR70n+HgxLIsZI=;
  b=ehaSCjjrMt2sXmmP8ykcWVHJorxI1ZJX9Wg1p4nbV+q3RD0OsBFw9iYD
   8I03eGc0YAzEpojQIXFpyLZmeI5zTK/3N883ImZ1+hYuFdITMfWLRXXQi
   x45+KuIsqWnqISrSBCzmBLOiR6jnjim2fGgS8Xv2d8o6LKI9kWgWEehIM
   FpoDhfkWL7QaJuNRru8V14fwX2YMmbfRMZ0x5JhDDWN0jf4aT6/hNeQXv
   l1bTNjUCoTGRifdC2MbQYMG6RIc6F1tqAG5QFexj3ChRWH4mJvI19RIYS
   YtPRTFFKfoHNMieeQMNPQHdE0t+6bCnDBnfHefOI2g8gz46K89xgq7tCQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338022183"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="338022183"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 11:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="710444066"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="710444066"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2023 11:37:12 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 08/12] x86/vsyscall: Add vsyscall emulation for #GP
Date:   Fri,  9 Jun 2023 21:36:28 +0300
Message-Id: <20230609183632.48706-9-alexander.shishkin@linux.intel.com>
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

The legacy vsyscall page is mapped at a fixed address in the kernel
address range 0xffffffffff600000-0xffffffffff601000. Prior to LASS being
introduced, a legacy vsyscall page access from userspace would always
generate a page fault. The kernel emulates the execute (XONLY) accesses
in the page fault handler and returns back to userspace with the
appropriate register values.

Since LASS intercepts these accesses before the paging structures are
traversed it generates a general protection fault instead of a page
fault. The #GP fault doesn't provide much information in terms of the
error code. So, use the faulting RIP which is preserved in the user
registers to emulate the vsyscall access without going through complex
instruction decoding.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 11 ++++++++++-
 arch/x86/include/asm/vsyscall.h       |  6 ++++++
 arch/x86/kernel/traps.c               |  4 ++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index dd112e538992..76e1344997d2 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -23,7 +23,7 @@
  * soon be no new userspace code that will ever use a vsyscall.
  *
  * The code in this file emulates vsyscalls when notified of a page
- * fault to a vsyscall address.
+ * fault or a general protection fault to a vsyscall address.
  */
 
 #include <linux/kernel.h>
@@ -309,6 +309,15 @@ bool emulate_vsyscall_pf(unsigned long error_code, struct pt_regs *regs,
 	return __emulate_vsyscall(regs, address);
 }
 
+bool emulate_vsyscall_gp(struct pt_regs *regs)
+{
+	/* Emulate only if the RIP points to the vsyscall address */
+	if (!is_vsyscall_vaddr(regs->ip))
+		return false;
+
+	return __emulate_vsyscall(regs, regs->ip);
+}
+
 /*
  * A pseudo VMA to allow ptrace access for the vsyscall page.  This only
  * covers the 64bit vsyscall page now. 32bit has a real VMA now and does
diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index 667b280afc1a..7180a849143f 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -17,6 +17,7 @@ extern void set_vsyscall_pgtable_user_bits(pgd_t *root);
  */
 extern bool emulate_vsyscall_pf(unsigned long error_code,
 				struct pt_regs *regs, unsigned long address);
+extern bool emulate_vsyscall_gp(struct pt_regs *regs);
 #else
 static inline void map_vsyscall(void) {}
 static inline bool emulate_vsyscall_pf(unsigned long error_code,
@@ -24,6 +25,11 @@ static inline bool emulate_vsyscall_pf(unsigned long error_code,
 {
 	return false;
 }
+
+static inline bool emulate_vsyscall_gp(struct pt_regs *regs)
+{
+	return false;
+}
 #endif
 
 #endif /* _ASM_X86_VSYSCALL_H */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f3e619ce9fbd..42d13e17e068 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -65,6 +65,7 @@
 #include <asm/vdso.h>
 #include <asm/tdx.h>
 #include <asm/cfi.h>
+#include <asm/vsyscall.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -753,6 +754,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (cpu_feature_enabled(X86_FEATURE_UMIP) && fixup_umip_exception(regs))
 			goto exit;
 
+		if (cpu_feature_enabled(X86_FEATURE_LASS) && emulate_vsyscall_gp(regs))
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
-- 
2.39.2

