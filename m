Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFDA638044
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiKXUku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKXUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:40:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA7E6F0F9;
        Thu, 24 Nov 2022 12:40:46 -0800 (PST)
Date:   Thu, 24 Nov 2022 20:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669322444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZ4epoRQ2zVfah+JpJhEtCKyEqBItJutIh76m0Wbb8M=;
        b=zBnU5w5fDAbtos3LNBlWwfftdkiSlHFqXge3Zl79fOYCUGVE/4h+bnry9fpN6uyBrsS+Fo
        0AbzKGXXsvUTiy1s/xvGx7Kn8hRZKbyZH0FDzmjsdEeT065jN/TSk3fCekkCHzj6L1N7wP
        tx1fx+eYGBLMNRZ5hx2qoqV6cMiV9IVO+mFCH2AW6HAWz9EAxgbwbhuOjIG0LgxchD537c
        aDeagg3qqcKytK5y7iY13DFqip1A567SlozXVkqB/au8/9ojawN/qThhD56Lkc76Dt1o47
        99UZmTp/mP6y3sjLIjCzFa7XmEZmn3RzGgD06A2X+dYhzyZpOwFTLJyaYDsxVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669322444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZ4epoRQ2zVfah+JpJhEtCKyEqBItJutIh76m0Wbb8M=;
        b=qYOeFIG6YacUFVG7wGjhbPY5P2t3lOzKDHh2wqikqk4Qv/gsIK35SrTWif0n9gzuT/D0Y7
        CvGmJr85JNNUCHAw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/paravirt: Remove clobber bitmask from .parainstructions
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220903073706.3193746-1-keescook@chromium.org>
References: <20220903073706.3193746-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <166932244330.4906.12220898230115738164.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5736b1b70170e15d66ec02e500db917ef42ade83
Gitweb:        https://git.kernel.org/tip/5736b1b70170e15d66ec02e500db917ef42ade83
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Sat, 03 Sep 2022 00:37:06 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 13:53:54 +01:00

x86/paravirt: Remove clobber bitmask from .parainstructions

The u16 "clobber" value is not used in .parainstructions since commit
27876f3882fd ("x86/paravirt: Remove clobbers from struct paravirt_patch_site")

Remove the u16 from the section macro, the argument from all macros, and
all now-unused CLBR_* macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20220903073706.3193746-1-keescook@chromium.org
---
 arch/x86/include/asm/paravirt_types.h | 61 +++++---------------------
 1 file changed, 12 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 27c6927..8c1da41 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -20,37 +20,6 @@ enum paravirt_lazy_mode {
 
 #ifdef CONFIG_PARAVIRT
 
-/* Bitmask of what can be clobbered: usually at least eax. */
-#define CLBR_EAX  (1 << 0)
-#define CLBR_ECX  (1 << 1)
-#define CLBR_EDX  (1 << 2)
-#define CLBR_EDI  (1 << 3)
-
-#ifdef CONFIG_X86_32
-/* CLBR_ANY should match all regs platform has. For i386, that's just it */
-#define CLBR_ANY  ((1 << 4) - 1)
-
-#define CLBR_ARG_REGS	(CLBR_EAX | CLBR_EDX | CLBR_ECX)
-#define CLBR_RET_REG	(CLBR_EAX | CLBR_EDX)
-#else
-#define CLBR_RAX  CLBR_EAX
-#define CLBR_RCX  CLBR_ECX
-#define CLBR_RDX  CLBR_EDX
-#define CLBR_RDI  CLBR_EDI
-#define CLBR_RSI  (1 << 4)
-#define CLBR_R8   (1 << 5)
-#define CLBR_R9   (1 << 6)
-#define CLBR_R10  (1 << 7)
-#define CLBR_R11  (1 << 8)
-
-#define CLBR_ANY  ((1 << 9) - 1)
-
-#define CLBR_ARG_REGS	(CLBR_RDI | CLBR_RSI | CLBR_RDX | \
-			 CLBR_RCX | CLBR_R8 | CLBR_R9)
-#define CLBR_RET_REG	(CLBR_RAX)
-
-#endif /* X86_64 */
-
 #ifndef __ASSEMBLY__
 
 #include <asm/desc_defs.h>
@@ -297,27 +266,23 @@ extern struct paravirt_patch_template pv_ops;
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
 	[paravirt_opptr] "m" (pv_ops.op)
-#define paravirt_clobber(clobber)		\
-	[paravirt_clobber] "i" (clobber)
-
 /*
  * Generate some code, and mark it as patchable by the
  * apply_paravirt() alternate instruction patcher.
  */
-#define _paravirt_alt(insn_string, type, clobber)	\
+#define _paravirt_alt(insn_string, type)		\
 	"771:\n\t" insn_string "\n" "772:\n"		\
 	".pushsection .parainstructions,\"a\"\n"	\
 	_ASM_ALIGN "\n"					\
 	_ASM_PTR " 771b\n"				\
 	"  .byte " type "\n"				\
 	"  .byte 772b-771b\n"				\
-	"  .short " clobber "\n"			\
 	_ASM_ALIGN "\n"					\
 	".popsection\n"
 
 /* Generate patchable code, with the default asm parameters. */
 #define paravirt_alt(insn_string)					\
-	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
+	_paravirt_alt(insn_string, "%c[paravirt_typenum]")
 
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
@@ -469,20 +434,19 @@ int paravirt_disable_iospace(void);
 	})
 
 
-#define ____PVOP_CALL(ret, op, clbr, call_clbr, extra_clbr, ...)	\
+#define ____PVOP_CALL(ret, op, call_clbr, extra_clbr, ...)	\
 	({								\
 		PVOP_CALL_ARGS;						\
 		PVOP_TEST_NULL(op);					\
 		asm volatile(paravirt_alt(PARAVIRT_CALL)		\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
-			       paravirt_clobber(clbr),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
 	})
 
-#define ____PVOP_ALT_CALL(ret, op, alt, cond, clbr, call_clbr,		\
+#define ____PVOP_ALT_CALL(ret, op, alt, cond, call_clbr,		\
 			  extra_clbr, ...)				\
 	({								\
 		PVOP_CALL_ARGS;						\
@@ -491,45 +455,44 @@ int paravirt_disable_iospace(void);
 					 alt, cond)			\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
-			       paravirt_clobber(clbr),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
 	})
 
 #define __PVOP_CALL(rettype, op, ...)					\
-	____PVOP_CALL(PVOP_RETVAL(rettype), op, CLBR_ANY,		\
+	____PVOP_CALL(PVOP_RETVAL(rettype), op,				\
 		      PVOP_CALL_CLOBBERS, EXTRA_CLOBBERS, ##__VA_ARGS__)
 
 #define __PVOP_ALT_CALL(rettype, op, alt, cond, ...)			\
-	____PVOP_ALT_CALL(PVOP_RETVAL(rettype), op, alt, cond, CLBR_ANY,\
+	____PVOP_ALT_CALL(PVOP_RETVAL(rettype), op, alt, cond,		\
 			  PVOP_CALL_CLOBBERS, EXTRA_CLOBBERS,		\
 			  ##__VA_ARGS__)
 
 #define __PVOP_CALLEESAVE(rettype, op, ...)				\
-	____PVOP_CALL(PVOP_RETVAL(rettype), op.func, CLBR_RET_REG,	\
+	____PVOP_CALL(PVOP_RETVAL(rettype), op.func,			\
 		      PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 #define __PVOP_ALT_CALLEESAVE(rettype, op, alt, cond, ...)		\
 	____PVOP_ALT_CALL(PVOP_RETVAL(rettype), op.func, alt, cond,	\
-			  CLBR_RET_REG, PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
+			  PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 
 #define __PVOP_VCALL(op, ...)						\
-	(void)____PVOP_CALL(, op, CLBR_ANY, PVOP_VCALL_CLOBBERS,	\
+	(void)____PVOP_CALL(, op, PVOP_VCALL_CLOBBERS,			\
 		       VEXTRA_CLOBBERS, ##__VA_ARGS__)
 
 #define __PVOP_ALT_VCALL(op, alt, cond, ...)				\
-	(void)____PVOP_ALT_CALL(, op, alt, cond, CLBR_ANY,		\
+	(void)____PVOP_ALT_CALL(, op, alt, cond,			\
 				PVOP_VCALL_CLOBBERS, VEXTRA_CLOBBERS,	\
 				##__VA_ARGS__)
 
 #define __PVOP_VCALLEESAVE(op, ...)					\
-	(void)____PVOP_CALL(, op.func, CLBR_RET_REG,			\
+	(void)____PVOP_CALL(, op.func,					\
 			    PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 #define __PVOP_ALT_VCALLEESAVE(op, alt, cond, ...)			\
-	(void)____PVOP_ALT_CALL(, op.func, alt, cond, CLBR_RET_REG,	\
+	(void)____PVOP_ALT_CALL(, op.func, alt, cond,			\
 				PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 
