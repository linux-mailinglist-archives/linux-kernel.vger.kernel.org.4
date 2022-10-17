Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B86011CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJQOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJQOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CD2691A8;
        Mon, 17 Oct 2022 07:53:45 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rbeIB8LitiEsAb/IgJkIxwr56dTJtOb8kqOCz0x2uk=;
        b=mFEXRUebwB0ceuQ8qbbEG6P86tI7rAGvb1nTJwNiKdnMD2DHpQpjdZ0gNFiHru6Gwa9otq
        nFuL0EpqmloSqJOlHp6wFl/zS55X65XwVaDJwZObl5p6CL6pRM6qcyNNNVIx3VoGHYoPpQ
        XadnJW3KrC9GU5RQWo6F84l+fCqqE8NNupK+wDi3Yf6F8HPxMZwus91S7hVHvhjf3xql8i
        cAjmKMdgwzdULuBp0okZLjIPKl2BPSO0lGNmx7YbHdlpJ0+H3UrNc6Fdw4sa48XSJD1gTM
        c55QFMx2/xX+D67CEyUnBXrlwo2jGksoA4h0RNY3CPfVQhxRc2l6/bbc+lGVbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rbeIB8LitiEsAb/IgJkIxwr56dTJtOb8kqOCz0x2uk=;
        b=dLINRy4T0JG/DJrkQuY3IcoXkIPVWp9tBssgWEzWthATzXSTkarB6xLqsvePtuSQrP9qm1
        YLsrJevnj/oknRCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] static_call: Add call depth tracking support
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111148.306100465@infradead.org>
References: <20220915111148.306100465@infradead.org>
MIME-Version: 1.0
Message-ID: <166601841630.401.8138685499148178070.tip-bot2@tip-bot2>
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

Commit-ID:     7825451fa4dc04660f1f53d236e4302161d0ebd1
Gitweb:        https://git.kernel.org/tip/7825451fa4dc04660f1f53d236e4302161d0ebd1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:31 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:16 +02:00

static_call: Add call depth tracking support

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
Link: https://lore.kernel.org/r/20220915111148.306100465@infradead.org
---
 arch/x86/include/asm/alternative.h |  5 +++++
 arch/x86/kernel/callthunks.c       | 18 ++++++++++++++++++
 arch/x86/kernel/static_call.c      |  1 +
 include/linux/static_call.h        |  2 ++
 kernel/static_call_inline.c        | 23 ++++++++++++++++++-----
 5 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4c416b2..07ac257 100644
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
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index dfe7fff..0710036 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -6,6 +6,7 @@
 #include <linux/kallsyms.h>
 #include <linux/memory.h>
 #include <linux/moduleloader.h>
+#include <linux/static_call.h>
 
 #include <asm/alternative.h>
 #include <asm/asm-offsets.h>
@@ -271,10 +272,27 @@ void __init callthunks_patch_builtin_calls(void)
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
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 5d3844a..2ebc338 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -34,6 +34,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 
 	switch (type) {
 	case CALL:
+		func = callthunks_translate_call_dest(func);
 		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
 		if (func == &__static_call_return0) {
 			emulate = code;
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index df53bed..141e6b1 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -162,6 +162,8 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 extern int __init static_call_init(void);
 
+extern void static_call_force_reinit(void);
+
 struct static_call_mod {
 	struct static_call_mod *next;
 	struct module *mod; /* for vmlinux, mod == NULL */
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index dc5665b..639397b 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -15,7 +15,18 @@ extern struct static_call_site __start_static_call_sites[],
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
