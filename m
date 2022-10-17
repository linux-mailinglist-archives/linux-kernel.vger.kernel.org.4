Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE960122A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiJQO7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiJQO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:58:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3196AA22;
        Mon, 17 Oct 2022 07:55:26 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYc+Bwyqcd+mMAZkehzGWiKcVAn9xuZmXYCp07jjxYs=;
        b=RV6hU5sfb6z2cVPPwRBP5fdxYYzDP4RBZhzFVSmaYDTplGGgsDisStBo7p/JgcVlwAdABk
        tDYuwAAQT4qQS11xHVbEe9GkMBLDD6+W3xsHWfJOsFfmnzXr4ToxL1wOJ1gxCYGSlIjnb7
        oZiW77q49f0bE+GyDXIhtazuUG6X36axCETn97c6ojO11pR8hVtCsSYIwJflctYjAyoDmU
        SBQbg/Lr88D2IY5w0UyAfQmY+FwpuTb1tJRWh+uUAcxRnUTZ/w8IoPu4hnZET9UXtWvYYy
        Qv/Ik8os2vfevLop28lIjNF3HAko4zK7/w2ifTIJ8oOR1rcruR4CVF8HhFcQpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYc+Bwyqcd+mMAZkehzGWiKcVAn9xuZmXYCp07jjxYs=;
        b=2SZhIUNiNSazfWYNdEjHEfcwNQN3jnNw22/rgl0Ft6kleGT8ibRCtRKeuVcsTPx4TFf3Ad
        +PY/DOH3+WKppYAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/asm: Differentiate between code and function alignment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111143.824822743@infradead.org>
References: <20220915111143.824822743@infradead.org>
MIME-Version: 1.0
Message-ID: <166601846350.401.9004588340970794658.tip-bot2@tip-bot2>
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

Commit-ID:     8eb5d34e77c63fde8af21c691bcf6e3cd87f7829
Gitweb:        https://git.kernel.org/tip/8eb5d34e77c63fde8af21c691bcf6e3cd87f7829
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:40:58 +02:00

x86/asm: Differentiate between code and function alignment

Create SYM_F_ALIGN to differentiate alignment requirements between
SYM_CODE and SYM_FUNC.

This distinction is useful later when adding padding in front of
functions; IOW this allows following the compiler's
patchable-function-entry option.

[peterz: Changelog]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.824822743@infradead.org
---
 arch/x86/include/asm/linkage.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 9ee0e28..c2d6e27 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -12,11 +12,15 @@
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #endif /* CONFIG_X86_32 */
 
-#ifdef __ASSEMBLY__
-
 #define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT, 0x90;
 #define __ALIGN_STR	__stringify(__ALIGN)
 
+#define ASM_FUNC_ALIGN		__ALIGN_STR
+#define __FUNC_ALIGN		__ALIGN
+#define SYM_F_ALIGN		__FUNC_ALIGN
+
+#ifdef __ASSEMBLY__
+
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
 #else /* CONFIG_RETPOLINE */
@@ -55,7 +59,7 @@
 
 /* SYM_FUNC_START -- use for global functions */
 #define SYM_FUNC_START(name)				\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
@@ -65,7 +69,7 @@
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #define SYM_FUNC_START_LOCAL(name)			\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
+	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
@@ -75,7 +79,7 @@
 
 /* SYM_FUNC_START_WEAK -- use for weak functions */
 #define SYM_FUNC_START_WEAK(name)			\
-	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
+	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
