Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0AE67D054
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjAZPev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjAZPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:34:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F156A712
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h9TgFQ/b9wTcT2zGUiB6D5VZSC+7nZ1MX8BeZINlqwk=; b=B1c9xa2HNMN/9BoAnVevSSIOvx
        /Z6Bq26COwn8PKWvkvG0Nw4TzQ9f1jJSt/S9KLr2RkgWAE+MxdZtrkbWaUFuTI2SMOPujSx1vfeDN
        UoyZ99n70TLnY1vJR4yrQpmygDUAMbz11cy5WS4PlxYqxLtzLuNDK3qzt/13uAgPn97KTNhnrRbTb
        3MNvc3CSxsajYWAsuKdVUu7M8lL4e5jG5pAICPSwhZOR3mB5UfciiOlsCnUr0HZ1KxL8zqs9zJoJ8
        8UG74P+mc+moSRMiiD1hfbq3GwxEgK/Y6V9mMeurPMqXnMIv+aXlzpmSUfyTngW0yXT+98+3lL2X4
        nVY1+p+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL4Gj-006rLM-4r; Thu, 26 Jan 2023 15:34:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A9E3300577;
        Thu, 26 Jan 2023 16:34:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 253BC2084C4A6; Thu, 26 Jan 2023 16:34:27 +0100 (CET)
Date:   Thu, 26 Jan 2023 16:34:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, erhard_f@mailbox.org,
        ndesaulniers@google.com, mhiramat@kernel.org, sandipan.das@amd.com
Subject: [PATCH v1.1 3/3] x86/static_call: Add support for Jcc tail-calls
Message-ID: <Y9Kdg9QjHkr9G5b5@hirez.programming.kicks-ass.net>
References: <20230123205915.751729592@infradead.org>
 <20230123210607.173715335@infradead.org>
 <20230123174431.4421dfdf@gandalf.local.home>
 <Y8/X6fdRT80jssIf@hirez.programming.kicks-ass.net>
 <20230124100753.13608e1f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124100753.13608e1f@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 10:07:53AM -0500, Steven Rostedt wrote:
> On Tue, 24 Jan 2023 14:06:49 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Just to confirm, as it's not clear if this is the static call site or one
> > > of the functions that is being called.  
> > 
> > Ah, you've not looked at enough asm then? ;-) Yes this is the static
> > call site, see the __SCT_ target (instruction at 0x35d).
> 
> Yeah, could you specify it a bit more in the change log such that those
> looking back at this don't have to have that requirement of staring at
> enough asm ;-)

How's this then?

---
Subject: x86/static_call: Add support for Jcc tail-calls
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Jan 20 16:40:33 CET 2023

Clang likes to create conditional tail calls like:

0000000000000350 <amd_pmu_add_event>:
350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4

Where 0x35d is a static call site that's turned into a conditional
tail-call using the Jcc class of instructions.

Teach the in-line static call text patching about this.

Notably, since there is no conditional-ret, in that case patch the Jcc
to point at an empty stub function that does the ret -- or the return
thunk when needed.

Reported-by: "Erhard F." <erhard_f@mailbox.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/kernel/static_call.c |   50 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -9,6 +9,7 @@ enum insn_type {
 	NOP = 1,  /* site cond-call */
 	JMP = 2,  /* tramp / site tail-call */
 	RET = 3,  /* tramp / site cond-tail-call */
+	JCC = 4,
 };
 
 /*
@@ -25,12 +26,40 @@ static const u8 xor5rax[] = { 0x2e, 0x2e
 
 static const u8 retinsn[] = { RET_INSN_OPCODE, 0xcc, 0xcc, 0xcc, 0xcc };
 
+static u8 __is_Jcc(u8 *insn) /* Jcc.d32 */
+{
+	u8 ret = 0;
+
+	if (insn[0] == 0x0f) {
+		u8 tmp = insn[1];
+		if ((tmp & 0xf0) == 0x80)
+			ret = tmp;
+	}
+
+	return ret;
+}
+
+extern void __static_call_return(void);
+
+asm (".global __static_call_return\n\t"
+     ".type __static_call_return, @function\n\t"
+     ASM_FUNC_ALIGN "\n\t"
+     "__static_call_return:\n\t"
+     ANNOTATE_NOENDBR
+     ANNOTATE_RETPOLINE_SAFE
+     "ret; int3\n\t"
+     ".size __static_call_return, . - __static_call_return \n\t");
+
 static void __ref __static_call_transform(void *insn, enum insn_type type,
 					  void *func, bool modinit)
 {
 	const void *emulate = NULL;
 	int size = CALL_INSN_SIZE;
 	const void *code;
+	u8 op, buf[6];
+
+	if ((type == JMP || type == RET) && (op = __is_Jcc(insn)))
+		type = JCC;
 
 	switch (type) {
 	case CALL:
@@ -57,6 +86,20 @@ static void __ref __static_call_transfor
 		else
 			code = &retinsn;
 		break;
+
+	case JCC:
+		if (!func) {
+			func = __static_call_return;
+			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+				func = x86_return_thunk;
+		}
+
+		buf[0] = 0x0f;
+		__text_gen_insn(buf+1, op, insn+1, func, 5);
+		code = buf;
+		size = 6;
+
+		break;
 	}
 
 	if (memcmp(insn, code, size) == 0)
@@ -68,9 +111,9 @@ static void __ref __static_call_transfor
 	text_poke_bp(insn, code, size, emulate);
 }
 
-static void __static_call_validate(void *insn, bool tail, bool tramp)
+static void __static_call_validate(u8 *insn, bool tail, bool tramp)
 {
-	u8 opcode = *(u8 *)insn;
+	u8 opcode = insn[0];
 
 	if (tramp && memcmp(insn+5, tramp_ud, 3)) {
 		pr_err("trampoline signature fail");
@@ -79,7 +122,8 @@ static void __static_call_validate(void
 
 	if (tail) {
 		if (opcode == JMP32_INSN_OPCODE ||
-		    opcode == RET_INSN_OPCODE)
+		    opcode == RET_INSN_OPCODE ||
+		    __is_Jcc(insn))
 			return;
 	} else {
 		if (opcode == CALL_INSN_OPCODE ||
