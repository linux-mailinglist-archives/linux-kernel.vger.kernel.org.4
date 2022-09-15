Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D25B99DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiIOLl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIOLka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546B3AE6A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=As36aOynrXCL6dT8N1wy2coxxgtaR4tVqpdPjpxHvf0=; b=OmEzBGMcguXP6Umj7V8YX2Y0G3
        L6Mk3Vmh0jFodumgm5U+uGKcFd7rgyIXby9uL1raBUWm09WCInqD1WEWWnilhUQ5RURjDJDBbiiF2
        kmGuHqZA04qaY5jdI60bkaRd1wqD9QIwVJR7WpBjrjBrORkTO/OZvVxJRQDGnIevJyPKPt8VhsFzX
        +BvicyuGjnzV+RhxGHKq3BuM70vbw3ZT2fdxDOPJVjfaCrH3+iRpPNLGVFAmOTa2L5BZflXXIue2q
        01/HODden+Jn+g8G04nlP2ZTSKBRYTTELjWlizxJmkFr8eTPjRA66fQt0/ZUl4x+z11qK42WtKBdx
        Qbbhv4rA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDt-0012WA-6H; Thu, 15 Sep 2022 11:40:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CD3F302ED9;
        Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1A84729AADBE3; Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Message-ID: <20220915111148.306100465@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:31 +0200
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
Subject: [PATCH v3 52/59] static_call: Add call depth tracking support
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

When indirect calls are switched to direct calls then it has to be ensured
that the call target is not the function, but the call thunk when call
depth tracking is enabled. But static calls are available before call
thunks have been set up.

Ensure a second run through the static call patching code after call thunks
have been created. When call thunks are not enabled this has no side
effects.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h |    5 +++++
 arch/x86/kernel/callthunks.c       |   18 ++++++++++++++++++
 arch/x86/kernel/static_call.c      |    1 +
 include/linux/static_call.h        |    2 ++
 kernel/static_call_inline.c        |   23 ++++++++++++++++++-----
 5 files changed, 44 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -91,11 +91,16 @@ struct callthunk_sites {
 extern void callthunks_patch_builtin_calls(void);
 extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
+extern void *callthunks_translate_call_dest(void *dest);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
 callthunks_patch_module_calls(struct callthunk_sites *sites,
 			      struct module *mod) {}
+static __always_inline void *callthunks_translate_call_dest(void *dest)
+{
+	return dest;
+}
 #endif
 
 #ifdef CONFIG_SMP
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -6,6 +6,7 @@
 #include <linux/kallsyms.h>
 #include <linux/memory.h>
 #include <linux/moduleloader.h>
+#include <linux/static_call.h>
 
 #include <asm/alternative.h>
 #include <asm/asm-offsets.h>
@@ -270,10 +271,27 @@ void __init callthunks_patch_builtin_cal
 	pr_info("Setting up call depth tracking\n");
 	mutex_lock(&text_mutex);
 	callthunks_setup(&cs, &builtin_coretext);
+	static_call_force_reinit();
 	thunks_initialized = true;
 	mutex_unlock(&text_mutex);
 }
 
+void *callthunks_translate_call_dest(void *dest)
+{
+	void *target;
+
+	lockdep_assert_held(&text_mutex);
+
+	if (!thunks_initialized || skip_addr(dest))
+		return dest;
+
+	if (!is_coretext(NULL, dest))
+		return dest;
+
+	target = patch_dest(dest, false);
+	return target ? : dest;
+}
+
 #ifdef CONFIG_MODULES
 void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
 					    struct module *mod)
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -34,6 +34,7 @@ static void __ref __static_call_transfor
 
 	switch (type) {
 	case CALL:
+		func = callthunks_translate_call_dest(func);
 		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
 		if (func == &__static_call_return0) {
 			emulate = code;
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -162,6 +162,8 @@ extern void arch_static_call_transform(v
 
 extern int __init static_call_init(void);
 
+extern void static_call_force_reinit(void);
+
 struct static_call_mod {
 	struct static_call_mod *next;
 	struct module *mod; /* for vmlinux, mod == NULL */
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -15,7 +15,18 @@ extern struct static_call_site __start_s
 extern struct static_call_tramp_key __start_static_call_tramp_key[],
 				    __stop_static_call_tramp_key[];
 
-static bool static_call_initialized;
+static int static_call_initialized;
+
+/*
+ * Must be called before early_initcall() to be effective.
+ */
+void static_call_force_reinit(void)
+{
+	if (WARN_ON_ONCE(!static_call_initialized))
+		return;
+
+	static_call_initialized++;
+}
 
 /* mutex to protect key modules/sites */
 static DEFINE_MUTEX(static_call_mutex);
@@ -475,7 +486,8 @@ int __init static_call_init(void)
 {
 	int ret;
 
-	if (static_call_initialized)
+	/* See static_call_force_reinit(). */
+	if (static_call_initialized == 1)
 		return 0;
 
 	cpus_read_lock();
@@ -490,11 +502,12 @@ int __init static_call_init(void)
 		BUG();
 	}
 
-	static_call_initialized = true;
-
 #ifdef CONFIG_MODULES
-	register_module_notifier(&static_call_module_nb);
+	if (!static_call_initialized)
+		register_module_notifier(&static_call_module_nb);
 #endif
+
+	static_call_initialized = 1;
 	return 0;
 }
 early_initcall(static_call_init);


