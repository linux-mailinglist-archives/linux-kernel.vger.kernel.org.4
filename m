Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F26C1CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjCTQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjCTQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:49:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F4BDE4;
        Mon, 20 Mar 2023 09:42:12 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JuaMGlprU5ha55klIjjd+7lbfYKhYcjfunRgfgyOQk8=;
        b=mzDNA2wDUS2Fm6ccyxvmffUt+lLVQdLCWFSpiJpZb64u+tdlbqpXc89RJZbPaMGNDozA4G
        V8Nvfbasfm0HB0Srm3AcBVghj+o6jQy6cwsyzvEfc9gQxGSJP7I1vKSiO0yUipTWczHQm5
        w1DkaV1uA1ZPOM0xf0kNVFMd0VdNVlZYJL4pIg6cmQ1BMYH9WxfGDxOdokI+/ntwnWRLVX
        NB4kxoNcHAdbHaED6HboFR9v/tlb9njptpTuuODLDwT4HCrw084Qpig4FBt62nhekExKN/
        yYEkMY5la7X+ksZMvjQ9eeEAAT+Y+CWUp/bjOAayFvHSR+p25eDN8/Bc0L7bLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JuaMGlprU5ha55klIjjd+7lbfYKhYcjfunRgfgyOQk8=;
        b=xvyPs0tFMcpteK6yMeztixCOACD+bx/QEEp4dGIqSUR4yMQcFnsV3nXZEOOCDYOnTPPkyv
        fwt1xVfd1eOshnAQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/traps: Move control protection handler to separate file
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036978.5837.12031387744724790018.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     0a3589d0e0ff7d57b76f49503f1877789641a5f6
Gitweb:        https://git.kernel.org/tip/0a3589d0e0ff7d57b76f49503f1877789641a5f6
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:02 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:08 -07:00

x86/traps: Move control protection handler to separate file

Today the control protection handler is defined in traps.c and used only
for the kernel IBT feature. To reduce ifdeffery, move it to it's own file.
In future patches, functionality will be added to make this handler also
handle user shadow stack faults. So name the file cet.c.

No functional change.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-8-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/Makefile |  2 +-
 arch/x86/kernel/cet.c    | 76 +++++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/traps.c  | 75 +--------------------------------------
 3 files changed, 78 insertions(+), 75 deletions(-)
 create mode 100644 arch/x86/kernel/cet.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index dd61752..92446f1 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -144,6 +144,8 @@ obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
 obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
 
+obj-$(CONFIG_X86_CET)			+= cet.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
new file mode 100644
index 0000000..7ad22b7
--- /dev/null
+++ b/arch/x86/kernel/cet.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/ptrace.h>
+#include <asm/bugs.h>
+#include <asm/traps.h>
+
+static __ro_after_init bool ibt_fatal = true;
+
+extern void ibt_selftest_ip(void); /* code label defined in asm below */
+
+enum cp_error_code {
+	CP_EC        = (1 << 15) - 1,
+
+	CP_RET       = 1,
+	CP_IRET      = 2,
+	CP_ENDBR     = 3,
+	CP_RSTRORSSP = 4,
+	CP_SETSSBSY  = 5,
+
+	CP_ENCL	     = 1 << 15,
+};
+
+DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
+		pr_err("Unexpected #CP\n");
+		BUG();
+	}
+
+	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
+		return;
+
+	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
+		regs->ax = 0;
+		return;
+	}
+
+	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
+	if (!ibt_fatal) {
+		printk(KERN_DEFAULT CUT_HERE);
+		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+		return;
+	}
+	BUG();
+}
+
+/* Must be noinline to ensure uniqueness of ibt_selftest_ip. */
+noinline bool ibt_selftest(void)
+{
+	unsigned long ret;
+
+	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
+	     ANNOTATE_RETPOLINE_SAFE
+	     "	jmp *%%rax\n\t"
+	     "ibt_selftest_ip:\n\t"
+	     UNWIND_HINT_FUNC
+	     ANNOTATE_NOENDBR
+	     "	nop\n\t"
+
+	     : "=a" (ret) : : "memory");
+
+	return !ret;
+}
+
+static int __init ibt_setup(char *str)
+{
+	if (!strcmp(str, "off"))
+		setup_clear_cpu_cap(X86_FEATURE_IBT);
+
+	if (!strcmp(str, "warn"))
+		ibt_fatal = false;
+
+	return 1;
+}
+
+__setup("ibt=", ibt_setup);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d317dc3..cc223e6 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -213,81 +213,6 @@ DEFINE_IDTENTRY(exc_overflow)
 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
 }
 
-#ifdef CONFIG_X86_KERNEL_IBT
-
-static __ro_after_init bool ibt_fatal = true;
-
-extern void ibt_selftest_ip(void); /* code label defined in asm below */
-
-enum cp_error_code {
-	CP_EC        = (1 << 15) - 1,
-
-	CP_RET       = 1,
-	CP_IRET      = 2,
-	CP_ENDBR     = 3,
-	CP_RSTRORSSP = 4,
-	CP_SETSSBSY  = 5,
-
-	CP_ENCL	     = 1 << 15,
-};
-
-DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
-		pr_err("Unexpected #CP\n");
-		BUG();
-	}
-
-	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
-		return;
-
-	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
-		regs->ax = 0;
-		return;
-	}
-
-	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
-	if (!ibt_fatal) {
-		printk(KERN_DEFAULT CUT_HERE);
-		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
-		return;
-	}
-	BUG();
-}
-
-/* Must be noinline to ensure uniqueness of ibt_selftest_ip. */
-noinline bool ibt_selftest(void)
-{
-	unsigned long ret;
-
-	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
-	     ANNOTATE_RETPOLINE_SAFE
-	     "	jmp *%%rax\n\t"
-	     "ibt_selftest_ip:\n\t"
-	     UNWIND_HINT_FUNC
-	     ANNOTATE_NOENDBR
-	     "	nop\n\t"
-
-	     : "=a" (ret) : : "memory");
-
-	return !ret;
-}
-
-static int __init ibt_setup(char *str)
-{
-	if (!strcmp(str, "off"))
-		setup_clear_cpu_cap(X86_FEATURE_IBT);
-
-	if (!strcmp(str, "warn"))
-		ibt_fatal = false;
-
-	return 1;
-}
-
-__setup("ibt=", ibt_setup);
-
-#endif /* CONFIG_X86_KERNEL_IBT */
-
 #ifdef CONFIG_X86_F00F_BUG
 void handle_invalid_op(struct pt_regs *regs)
 #else
