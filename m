Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901BF5B99CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIOLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIOLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FE7476D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VtHSfWHBCM/dkewK26y+PcMV0oq6+DiYrWTtkB689iQ=; b=qT4Oro5EOrXrMzLS+pxGmYqBzT
        wKr4CiPeRYXh4EWABg4a8UZ5WMgFMZroQS/bmdKW7Yc0FpoD/RFLBKbQ42K0AcOT0hKew/BGXbrfn
        3+bvymrca5LT0Z+uIXutQ4UV5a+iDqsOo6eHngfmbXqlgMZtREuBsqawB0a92Hqv25L9DiWYr39hb
        1ppdcPB2DX8nOxOLhzF/p3Bcs9WbdC+5X4twleGeUFSpn+wIm2iINAWSZVBfK9T+Hjcf0FhDCmi16
        vAxSkSuRoR1zyaXLrZ1RLrviuAHDc+nCwqLX1o3gOUs8vmtkP9T56CSoL7AzN2vs9Burj0Ljk5L2d
        QiPOiTeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDd-0012Nr-GT; Thu, 15 Sep 2022 11:39:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E41B4302D5A;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8542A29BA2EAA; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111145.806607235@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:07 +0200
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
Subject: [PATCH v3 28/59] objtool: Allow !PC relative relocations
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

From: Peter Zijlstra <peterz@infradead.org>

Objtool doesn't currently much like per-cpu usage in alternatives:

arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0xf: unsupported relocation in alternatives section
  f:   65 c7 04 25 00 00 00 00 00 00 00 80     movl   $0x80000000,%gs:0x0      13: R_X86_64_32S        __x86_call_depth

Since the R_X86_64_32S relocation is location invariant (it's
computation doesn't include P - the address of the location itself),
it can be trivially allowed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c       |   42 +++++++++++++++++++++++++++++-----
 tools/objtool/check.c                 |    6 +---
 tools/objtool/include/objtool/arch.h  |    6 ++--
 tools/objtool/include/objtool/check.h |   17 +++++++------
 4 files changed, 51 insertions(+), 20 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -73,6 +73,30 @@ unsigned long arch_jump_destination(stru
 	return insn->offset + insn->len + insn->immediate;
 }
 
+bool arch_pc_relative_reloc(struct reloc *reloc)
+{
+	/*
+	 * All relocation types where P (the address of the target)
+	 * is included in the computation.
+	 */
+	switch (reloc->type) {
+	case R_X86_64_PC8:
+	case R_X86_64_PC16:
+	case R_X86_64_PC32:
+	case R_X86_64_PC64:
+
+	case R_X86_64_PLT32:
+	case R_X86_64_GOTPC32:
+	case R_X86_64_GOTPCREL:
+		return true;
+
+	default:
+		break;
+	}
+
+	return false;
+}
+
 #define ADD_OP(op) \
 	if (!(op = calloc(1, sizeof(*op)))) \
 		return -1; \
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1622,7 +1620,7 @@ static int handle_group_alt(struct objto
 		 * accordingly.
 		 */
 		alt_reloc = insn_reloc(file, insn);
-		if (alt_reloc &&
+		if (alt_reloc && arch_pc_relative_reloc(alt_reloc) &&
 		    !arch_support_alt_relocation(special_alt, insn, alt_reloc)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -93,4 +91,6 @@ bool arch_is_rethunk(struct symbol *sym)
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
+bool arch_pc_relative_reloc(struct reloc *reloc);
+
 #endif /* _ARCH_H */


