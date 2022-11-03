Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D9A6185C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiKCRGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiKCRF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:05:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5C861B1F8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:05:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A456411FB;
        Thu,  3 Nov 2022 10:05:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D32773F5A1;
        Thu,  3 Nov 2022 10:05:32 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org, will@kernel.org
Subject: [PATCH v2 2/4] ftrace: rename ftrace_instruction_pointer_set() -> ftrace_regs_set_instruction_pointer()
Date:   Thu,  3 Nov 2022 17:05:18 +0000
Message-Id: <20221103170520.931305-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103170520.931305-1-mark.rutland@arm.com>
References: <20221103170520.931305-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In subsequent patches we'll add a sew of ftrace_regs_{get,set}_*()
helpers. In preparation, this patch renames
ftrace_instruction_pointer_set() to
ftrace_regs_set_instruction_pointer().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/include/asm/ftrace.h | 5 +++--
 arch/s390/include/asm/ftrace.h    | 5 +++--
 arch/x86/include/asm/ftrace.h     | 2 +-
 include/linux/ftrace.h            | 9 ++++-----
 kernel/livepatch/patch.c          | 2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 3cee7115441b4..c3eb48f675669 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -37,8 +37,9 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
 	return fregs->regs.msr ? &fregs->regs : NULL;
 }
 
-static __always_inline void ftrace_instruction_pointer_set(struct ftrace_regs *fregs,
-							   unsigned long ip)
+static __always_inline void
+ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
+				    unsigned long ip)
 {
 	regs_set_return_ip(&fregs->regs, ip);
 }
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 85bc26ccdb872..113d194acea01 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -54,8 +54,9 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
 	return NULL;
 }
 
-static __always_inline void ftrace_instruction_pointer_set(struct ftrace_regs *fregs,
-							   unsigned long ip)
+static __always_inline void
+ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
+				    unsigned long ip)
 {
 	fregs->regs.psw.addr = ip;
 }
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index d2350a8351fa4..b2925d342c650 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -48,7 +48,7 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	return &fregs->regs;
 }
 
-#define ftrace_instruction_pointer_set(fregs, _ip)	\
+#define ftrace_regs_set_instruction_pointer(fregs, _ip)	\
 	do { (fregs)->regs.ip = (_ip); } while (0)
 
 struct ftrace_ops;
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index f201fcbfffb07..ec3657a60f850 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -111,12 +111,11 @@ struct ftrace_regs {
 #define arch_ftrace_get_regs(fregs) (&(fregs)->regs)
 
 /*
- * ftrace_instruction_pointer_set() is to be defined by the architecture
- * if to allow setting of the instruction pointer from the ftrace_regs
- * when HAVE_DYNAMIC_FTRACE_WITH_ARGS is set and it supports
- * live kernel patching.
+ * ftrace_regs_set_instruction_pointer() is to be defined by the architecture
+ * if to allow setting of the instruction pointer from the ftrace_regs when
+ * HAVE_DYNAMIC_FTRACE_WITH_ARGS is set and it supports live kernel patching.
  */
-#define ftrace_instruction_pointer_set(fregs, ip) do { } while (0)
+#define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
 #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 4c4f5a776d808..4152c71507e24 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -118,7 +118,7 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	if (func->nop)
 		goto unlock;
 
-	ftrace_instruction_pointer_set(fregs, (unsigned long)func->new_func);
+	ftrace_regs_set_instruction_pointer(fregs, (unsigned long)func->new_func);
 
 unlock:
 	ftrace_test_recursion_unlock(bit);
-- 
2.30.2

