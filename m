Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD35B9A02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiIOLo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiIOLlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D28E7EFD8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0/PtPljRLva+i3OXSAsXYK2WvcvC4WWFyxPXVnV3iEE=; b=FZ0N8GSIiotBeRaHB7bpUt3l3v
        Wl42bsha7EfmVuWTj9WBnLLPDMYXeUCK9xMpD80V1zD6C4bQRu/3Yuf/DIGR+FSPM+SqNHGD5bLdr
        eGxkjB1MvyJT3HcHRP8SMSNDtfWWz14EzE9iXrIavcXVyi8MovOEN0KIFePDqtSrqCbg0/0D6VKfF
        is3t4bgenyRJMwLcWtwIFxLhj4P5ia6BEDswaQYRQnSLB1cqVL6mqXD1yitP904TbEjyzM7GTS6DW
        WkDKA3nXop3iFd4eW3cms2jJXk1kIRsl29ebLylCl3jO7kWzXPxKDBsKwzaipfz7BxDVqSap8Hmve
        +NOqqRZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDk-0012Ri-G0; Thu, 15 Sep 2022 11:39:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 039E2302EAA;
        Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D5D0329AADBEB; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111147.159977224@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:20 +0200
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
Subject: [PATCH v3 41/59] x86/alternatives: Provide text_poke_copy_locked()
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

The upcoming call thunk patching must hold text_mutex and needs access to
text_poke_copy(), which takes text_mutex.

Provide a _locked postfixed variant to expose the inner workings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |    1 
 arch/x86/kernel/alternative.c        |   37 ++++++++++++++++++++---------------
 2 files changed, 23 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -45,6 +45,7 @@ extern void *text_poke(void *addr, const
 extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
+extern void *text_poke_copy_locked(void *addr, const void *opcode, size_t len, bool core_ok);
 extern void *text_poke_set(void *addr, int c, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1227,27 +1227,15 @@ void *text_poke_kgdb(void *addr, const v
 	return __text_poke(text_poke_memcpy, addr, opcode, len);
 }
 
-/**
- * text_poke_copy - Copy instructions into (an unused part of) RX memory
- * @addr: address to modify
- * @opcode: source of the copy
- * @len: length to copy, could be more than 2x PAGE_SIZE
- *
- * Not safe against concurrent execution; useful for JITs to dump
- * new code blocks into unused regions of RX memory. Can be used in
- * conjunction with synchronize_rcu_tasks() to wait for existing
- * execution to quiesce after having made sure no existing functions
- * pointers are live.
- */
-void *text_poke_copy(void *addr, const void *opcode, size_t len)
+void *text_poke_copy_locked(void *addr, const void *opcode, size_t len,
+			    bool core_ok)
 {
 	unsigned long start = (unsigned long)addr;
 	size_t patched = 0;
 
-	if (WARN_ON_ONCE(core_kernel_text(start)))
+	if (WARN_ON_ONCE(!core_ok && core_kernel_text(start)))
 		return NULL;
 
-	mutex_lock(&text_mutex);
 	while (patched < len) {
 		unsigned long ptr = start + patched;
 		size_t s;
@@ -1257,6 +1245,25 @@ void *text_poke_copy(void *addr, const v
 		__text_poke(text_poke_memcpy, (void *)ptr, opcode + patched, s);
 		patched += s;
 	}
+	return addr;
+}
+
+/**
+ * text_poke_copy - Copy instructions into (an unused part of) RX memory
+ * @addr: address to modify
+ * @opcode: source of the copy
+ * @len: length to copy, could be more than 2x PAGE_SIZE
+ *
+ * Not safe against concurrent execution; useful for JITs to dump
+ * new code blocks into unused regions of RX memory. Can be used in
+ * conjunction with synchronize_rcu_tasks() to wait for existing
+ * execution to quiesce after having made sure no existing functions
+ * pointers are live.
+ */
+void *text_poke_copy(void *addr, const void *opcode, size_t len)
+{
+	mutex_lock(&text_mutex);
+	addr = text_poke_copy_locked(addr, opcode, len, false);
 	mutex_unlock(&text_mutex);
 	return addr;
 }


