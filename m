Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E18678932
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjAWVHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjAWVHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:07:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E58530E95
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pkk66lDIJdbY60ClGNOpgyRAJcMk6omCEJ+djxw5JoA=; b=qVtHjS1IZwObvMJEhV0hetLUHa
        +rbrAxQlZcVwT0dQnAArr5cbptj8fQDv4vnpEv8YMg7FKIaPFOEGv4ZFCxmFm6OOVVLvHWjS5HAp4
        5eYb5dZRMKkD5qNJQ9EGuyETZM/0AWHKgmJR0ByGfZXrTNgbfGCNKaVNPw4Qi9bZgZISVMqCLbanB
        VzMLHomINHP63+4/SN8BzPN4sCB03UgUZc5QTKjY5yCI53lGkKRb8U1okcSbVA8xG2DVqin3Bb21/
        GeQhsgbCuPhEn2z0dbKFltN9hknYu27I5cnEIQtVt0IWbj4p2CwGmo/dTc9xyLZ2vYGtum7JYTDE8
        +nNPnVLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK41f-004Wrc-CF; Mon, 23 Jan 2023 21:06:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6217B300673;
        Mon, 23 Jan 2023 22:06:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2930E2038B0D9; Mon, 23 Jan 2023 22:06:45 +0100 (CET)
Message-ID: <20230123210607.057678245@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 23 Jan 2023 21:59:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        erhard_f@mailbox.org, ndesaulniers@google.com, mhiramat@kernel.org,
        sandipan.das@amd.com
Subject: [PATCH 1/3] x86/alternative: Introduce int3_emulate_jcc()
References: <20230123205915.751729592@infradead.org>
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

Move the kprobe Jcc emulation into int3_emulate_jcc() so it can be
used by more code -- specifically static_call() will need this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/include/asm/text-patching.h |   31 ++++++++++++++++++++++++++++
 arch/x86/kernel/kprobes/core.c       |   38 +++++++----------------------------
 2 files changed, 39 insertions(+), 30 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -184,6 +184,37 @@ void int3_emulate_ret(struct pt_regs *re
 	unsigned long ip = int3_emulate_pop(regs);
 	int3_emulate_jmp(regs, ip);
 }
+
+static __always_inline
+void int3_emulate_jcc(struct pt_regs *regs, u8 cc, unsigned long ip, unsigned long disp)
+{
+	static const unsigned long jcc_mask[6] = {
+		[0] = X86_EFLAGS_OF,
+		[1] = X86_EFLAGS_CF,
+		[2] = X86_EFLAGS_ZF,
+		[3] = X86_EFLAGS_CF | X86_EFLAGS_ZF,
+		[4] = X86_EFLAGS_SF,
+		[5] = X86_EFLAGS_PF,
+	};
+
+	bool invert = cc & 1;
+	bool match;
+
+	if (cc < 0xc) {
+		match = regs->flags & jcc_mask[cc >> 1];
+	} else {
+		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
+			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
+		if (cc >= 0xe)
+			match = match || (regs->flags & X86_EFLAGS_ZF);
+	}
+
+	if ((match && !invert) || (!match && invert))
+		ip += disp;
+
+	int3_emulate_jmp(regs, ip);
+}
+
 #endif /* !CONFIG_UML_X86 */
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -464,50 +464,26 @@ static void kprobe_emulate_call(struct k
 }
 NOKPROBE_SYMBOL(kprobe_emulate_call);
 
-static nokprobe_inline
-void __kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs, bool cond)
+static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
 {
 	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
 
-	if (cond)
-		ip += p->ainsn.rel32;
+	ip += p->ainsn.rel32;
 	int3_emulate_jmp(regs, ip);
 }
-
-static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
-{
-	__kprobe_emulate_jmp(p, regs, true);
-}
 NOKPROBE_SYMBOL(kprobe_emulate_jmp);
 
-static const unsigned long jcc_mask[6] = {
-	[0] = X86_EFLAGS_OF,
-	[1] = X86_EFLAGS_CF,
-	[2] = X86_EFLAGS_ZF,
-	[3] = X86_EFLAGS_CF | X86_EFLAGS_ZF,
-	[4] = X86_EFLAGS_SF,
-	[5] = X86_EFLAGS_PF,
-};
-
 static void kprobe_emulate_jcc(struct kprobe *p, struct pt_regs *regs)
 {
-	bool invert = p->ainsn.jcc.type & 1;
-	bool match;
+	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
 
-	if (p->ainsn.jcc.type < 0xc) {
-		match = regs->flags & jcc_mask[p->ainsn.jcc.type >> 1];
-	} else {
-		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
-			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
-		if (p->ainsn.jcc.type >= 0xe)
-			match = match || (regs->flags & X86_EFLAGS_ZF);
-	}
-	__kprobe_emulate_jmp(p, regs, (match && !invert) || (!match && invert));
+	int3_emulate_jcc(regs, p->ainsn.jcc.type, ip, p->ainsn.rel32);
 }
 NOKPROBE_SYMBOL(kprobe_emulate_jcc);
 
 static void kprobe_emulate_loop(struct kprobe *p, struct pt_regs *regs)
 {
+	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
 	bool match;
 
 	if (p->ainsn.loop.type != 3) {	/* LOOP* */
@@ -535,7 +511,9 @@ static void kprobe_emulate_loop(struct k
 	else if (p->ainsn.loop.type == 1)	/* LOOPE */
 		match = match && (regs->flags & X86_EFLAGS_ZF);
 
-	__kprobe_emulate_jmp(p, regs, match);
+	if (match)
+		ip += p->ainsn.rel32;
+	int3_emulate_jmp(regs, ip);
 }
 NOKPROBE_SYMBOL(kprobe_emulate_loop);
 


