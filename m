Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922FB5B99D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIOLlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIOLkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFB84D4F2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OBX5EIwP3G2xjma/pjou8yu95pcGhCBhrOFKdTw9gg0=; b=JcDDGK88BceBW3kLMyI7OJSLcS
        DTTj5DwXQZOtp/KNHhLZK4pEAk1sGgCUi4LSHYT1kJEHJoqq/gtwtPGqOCkVsKmjVS2n5Q/Jr4XFx
        tpZa9E0Fp67iUBHpigcIJiVWqC/AiN8HLiJ2YyixpJcQyviEo7hWmSsG1D3Xaodwk/4gyXWe2pIKm
        fbA+tABWcxEOvs8xAZvB4gytS/LmlcXPiGAt7JtLSQML3/8A4uRKX+xgWXp7+Hw1csyZaTpZw6MTm
        IxHrZesTWEYyJX6TmMaiM1v9vtBVmXkpcq9bkF/H2FcrjGdWcpLY/PDGos+ulr2h6WEtNvxTt3wAr
        i5pyLr9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDb-0012Mv-6G; Thu, 15 Sep 2022 11:39:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B55403010AC;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0C38329AADBEE; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111143.824822743@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 09/59] x86/asm: Differentiate between code and function alignment
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Create SYM_F_ALIGN to differentiate alignment requirements between
SYM_CODE and SYM_FUNC.

This distinction is useful later when adding padding in front of
functions; IOW this allows following the compiler's
patchable-function-entry option.

[peterz: Changelog]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/linkage.h |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

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
@@ -43,7 +47,7 @@
 
 /* SYM_FUNC_START -- use for global functions */
 #define SYM_FUNC_START(name)				\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
@@ -53,7 +57,7 @@
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #define SYM_FUNC_START_LOCAL(name)			\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
+	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
@@ -63,7 +67,7 @@
 
 /* SYM_FUNC_START_WEAK -- use for weak functions */
 #define SYM_FUNC_START_WEAK(name)			\
-	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
+	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */


