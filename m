Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19AC5B99F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiIOLnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiIOLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E496CD1C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tmkbhGubwHT7U0oeakCgE2xWz6Q0qYpLFWybSMdPCks=; b=UazKyAoWHkUK+zDI+b0L+qfcTl
        u/jp4ebYoWITCg17Gf/dblsPpxGUb15mAoje3eeVExdXK6rGJHdfELi9nsV2PEbC10YtgKd0ZHjQ4
        SPnKVyaeetRv/gYMZlqrjQVrtTjGdf20wN5C/42ZilPDtpIle4mKulgln3cjGroZeNRDSuwKIgZkG
        rQERu8CuwSn0S6v3rbaKZyQI3s75jBkl/efUlJZf7GehCtPXSLDSUa5MUTs8iTzdZCvuXn1P5LOUm
        7nN2DgHGeJCX8XZgt/Mdzi9Gjbg/x1yFCH2rTxekVE7U72r+vmlIlkcgBSvRb1QxrhVZ6zZ441MVW
        I0jXA1UQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDm-00Cabd-Ra; Thu, 15 Sep 2022 11:40:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20025302ED3;
        Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0F15829AADBE4; Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Message-ID: <20220915111148.101125588@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:29 +0200
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
Subject: [PATCH v3 50/59] x86/retbleed: Add SKL call thunk
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

Add the actual SKL call thunk for call depth accounting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/callthunks.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -7,6 +7,7 @@
 #include <linux/moduleloader.h>
 
 #include <asm/alternative.h>
+#include <asm/asm-offsets.h>
 #include <asm/cpu.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
@@ -55,7 +56,21 @@ static const struct core_text builtin_co
 	.name = "builtin",
 };
 
-static struct thunk_desc callthunk_desc __ro_after_init;
+asm (
+	".pushsection .rodata				\n"
+	".global skl_call_thunk_template		\n"
+	"skl_call_thunk_template:			\n"
+		__stringify(INCREMENT_CALL_DEPTH)"	\n"
+	".global skl_call_thunk_tail			\n"
+	"skl_call_thunk_tail:				\n"
+	".popsection					\n"
+);
+
+extern u8 skl_call_thunk_template[];
+extern u8 skl_call_thunk_tail[];
+
+#define SKL_TMPL_SIZE \
+	((unsigned int)(skl_call_thunk_tail - skl_call_thunk_template))
 
 extern void error_entry(void);
 extern void xen_error_entry(void);
@@ -157,11 +172,11 @@ static const u8 nops[] = {
 
 static __init_or_module void *patch_dest(void *dest, bool direct)
 {
-	unsigned int tsize = callthunk_desc.template_size;
+	unsigned int tsize = SKL_TMPL_SIZE;
 	u8 *pad = dest - tsize;
 
 	/* Already patched? */
-	if (!bcmp(pad, callthunk_desc.template, tsize))
+	if (!bcmp(pad, skl_call_thunk_template, tsize))
 		return pad;
 
 	/* Ensure there are nops */
@@ -171,9 +186,9 @@ static __init_or_module void *patch_dest
 	}
 
 	if (direct)
-		memcpy(pad, callthunk_desc.template, tsize);
+		memcpy(pad, skl_call_thunk_template, tsize);
 	else
-		text_poke_copy_locked(pad, callthunk_desc.template, tsize, true);
+		text_poke_copy_locked(pad, skl_call_thunk_template, tsize, true);
 	return pad;
 }
 


