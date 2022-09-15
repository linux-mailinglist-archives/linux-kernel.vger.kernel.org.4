Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF445B99D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIOLlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiIOLkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688DE4D4D0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HFxAeBcqZzx1YzuFlftNJ033Kmjw/OvruEBmGEN0HcI=; b=GpJ0Bgru3VoLfV6FxgRXxgmHQ1
        mSKaaTOE7XLtF/uowNYk021SriD9MqJKdWz+csRxNSJ9mxk1IyMcLAS4UF1xYX3F69BR7CXs4DLBv
        RTghGZDATMJwrjnKlZ0dcc/okGPKHL1GWn8vp5DnOtAvlgsL+8rXXkG6bN/er0Mt5B1uxBwGP0wDY
        uk0MqlVYXEP2GoLhqjDTU4hYU0nQrPgjWYJBqq0nURsV/1Px73TOcltpmcKehqEyGMtaeBbsuWr/S
        7ROz5ot9ljTkxFpxeNse3R95bVKTXGL3IEsnV4s7d5y965EmbURZzqynjNWLKiVfK8rRZfqqGz97o
        MeeJLYlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDb-0012My-MC; Thu, 15 Sep 2022 11:39:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD59B301100;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1A56F29AADBE3; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111144.038540008@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:50 +0200
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
Subject: [PATCH v3 11/59] x86/paravirt: Properly align PV functions
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

Ensure inline asm functions are consistently aligned with compiler
generated and SYM_FUNC_START*() functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h           |    1 +
 arch/x86/include/asm/qspinlock_paravirt.h |    2 +-
 arch/x86/kernel/kvm.c                     |    1 +
 arch/x86/kernel/paravirt.c                |    2 ++
 4 files changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -665,6 +665,7 @@ bool __raw_callee_save___native_vcpu_is_
 	asm(".pushsection " section ", \"ax\";"				\
 	    ".globl " PV_THUNK_NAME(func) ";"				\
 	    ".type " PV_THUNK_NAME(func) ", @function;"			\
+	    ASM_FUNC_ALIGN						\
 	    PV_THUNK_NAME(func) ":"					\
 	    ASM_ENDBR							\
 	    FRAME_BEGIN							\
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -39,7 +39,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_sp
 asm    (".pushsection .text;"
 	".globl " PV_UNLOCK ";"
 	".type " PV_UNLOCK ", @function;"
-	".align 4,0x90;"
+	ASM_FUNC_ALIGN
 	PV_UNLOCK ": "
 	ASM_ENDBR
 	FRAME_BEGIN
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -802,6 +802,7 @@ asm(
 ".pushsection .text;"
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
+ASM_FUNC_ALIGN
 "__raw_callee_save___kvm_vcpu_is_preempted:"
 ASM_ENDBR
 "movq	__per_cpu_offset(,%rdi,8), %rax;"
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -40,6 +40,7 @@
 extern void _paravirt_nop(void);
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global _paravirt_nop\n"
+     ASM_FUNC_ALIGN
      "_paravirt_nop:\n\t"
      ASM_ENDBR
      ASM_RET
@@ -50,6 +51,7 @@ asm (".pushsection .entry.text, \"ax\"\n
 /* stub always returning 0. */
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global paravirt_ret0\n"
+     ASM_FUNC_ALIGN
      "paravirt_ret0:\n\t"
      ASM_ENDBR
      "xor %" _ASM_AX ", %" _ASM_AX ";\n\t"


