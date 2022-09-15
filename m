Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A505B99F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiIOLnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIOLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CDC4C615
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+OpChG5m5Za8mkIkCncS6zKt3a7LKRkg2fN4td+8QnM=; b=haQ/PsSTTcURnEcbbpmp09Qe39
        FSsHDS7MY05LLri8lIGqUw1mhGJUlqXCVviJVxBAH1aSqcHjTXuO50jDyX8aHqj+2SuFEzj8FwUCv
        6N96yRMczSktCcAigCeBmihbGur7XcmQdoU6iecJQ4Nr8Ly7JZFQKR/+sh2wtExQxr9fffc8LfSLq
        HUvEobVcA88D600MGWWjYLgTitlbJMgMSe8qtaNDxcLgOoKhgLOH00Swr/uML3h4vwlRxV/OPucba
        BSdLJyGCsCe3nD98zRDkrlt18txfxVKb8EwebIOybT9Ghcr7X4Yqbfb/jZuESdhc8TJBRw7baIgby
        P+88wdhA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDn-00Cabe-09; Thu, 15 Sep 2022 11:40:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23293302ED7;
        Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1350129AADBE5; Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Message-ID: <20220915111148.204285506@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:30 +0200
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
Subject: [PATCH v3 51/59] x86/calldepth: Add ret/call counting for debug
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

Add a debuigfs mechanism to validate the accounting, e.g. vs. call/ret
balance and to gather statistics about the stuffing to call ratio.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   36 +++++++++++++++++++++--
 arch/x86/kernel/callthunks.c         |   53 +++++++++++++++++++++++++++++++++++
 arch/x86/lib/retpoline.S             |    7 +++-
 3 files changed, 91 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -57,6 +57,22 @@
 #define RET_DEPTH_INIT_FROM_CALL	0xfc00000000000000ULL
 #define RET_DEPTH_CREDIT		0xffffffffffffffffULL
 
+#ifdef CONFIG_CALL_THUNKS_DEBUG
+# define CALL_THUNKS_DEBUG_INC_CALLS				\
+	incq	%gs:__x86_call_count;
+# define CALL_THUNKS_DEBUG_INC_RETS				\
+	incq	%gs:__x86_ret_count;
+# define CALL_THUNKS_DEBUG_INC_STUFFS				\
+	incq	%gs:__x86_stuffs_count;
+# define CALL_THUNKS_DEBUG_INC_CTXSW				\
+	incq	%gs:__x86_ctxsw_count;
+#else
+# define CALL_THUNKS_DEBUG_INC_CALLS
+# define CALL_THUNKS_DEBUG_INC_RETS
+# define CALL_THUNKS_DEBUG_INC_STUFFS
+# define CALL_THUNKS_DEBUG_INC_CTXSW
+#endif
+
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 #define CREDIT_CALL_DEPTH					\
 	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
@@ -72,18 +88,23 @@
 #define RESET_CALL_DEPTH_FROM_CALL				\
 	mov	$0xfc, %rax;					\
 	shl	$56, %rax;					\
-	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);	\
+	CALL_THUNKS_DEBUG_INC_CALLS
 
 #define INCREMENT_CALL_DEPTH					\
-	sarq	$5, %gs:pcpu_hot + X86_call_depth;
+	sarq	$5, %gs:pcpu_hot + X86_call_depth;		\
+	CALL_THUNKS_DEBUG_INC_CALLS
 
 #define ASM_INCREMENT_CALL_DEPTH				\
-	sarq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+	sarq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth);	\
+	CALL_THUNKS_DEBUG_INC_CALLS
 
 #else
 #define CREDIT_CALL_DEPTH
+#define ASM_CREDIT_CALL_DEPTH
 #define RESET_CALL_DEPTH
 #define INCREMENT_CALL_DEPTH
+#define ASM_INCREMENT_CALL_DEPTH
 #define RESET_CALL_DEPTH_FROM_CALL
 #endif
 
@@ -134,7 +155,8 @@
 	jnz	771b;					\
 	/* barrier for jnz misprediction */		\
 	lfence;						\
-	ASM_CREDIT_CALL_DEPTH
+	ASM_CREDIT_CALL_DEPTH				\
+	CALL_THUNKS_DEBUG_INC_CTXSW
 #else
 /*
  * i386 doesn't unconditionally have LFENCE, as such it can't
@@ -319,6 +341,12 @@ static inline void x86_set_skl_return_th
 {
 	x86_return_thunk = &__x86_return_skl;
 }
+#ifdef CONFIG_CALL_THUNKS_DEBUG
+DECLARE_PER_CPU(u64, __x86_call_count);
+DECLARE_PER_CPU(u64, __x86_ret_count);
+DECLARE_PER_CPU(u64, __x86_stuffs_count);
+DECLARE_PER_CPU(u64, __x86_ctxsw_count);
+#endif
 #else
 static inline void x86_set_skl_return_thunk(void) {}
 #endif
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -2,6 +2,7 @@
 
 #define pr_fmt(fmt) "callthunks: " fmt
 
+#include <linux/debugfs.h>
 #include <linux/kallsyms.h>
 #include <linux/memory.h>
 #include <linux/moduleloader.h>
@@ -35,6 +36,15 @@ static int __init debug_thunks(char *str
 }
 __setup("debug-callthunks", debug_thunks);
 
+#ifdef CONFIG_CALL_THUNKS_DEBUG
+DEFINE_PER_CPU(u64, __x86_call_count);
+DEFINE_PER_CPU(u64, __x86_ret_count);
+DEFINE_PER_CPU(u64, __x86_stuffs_count);
+DEFINE_PER_CPU(u64, __x86_ctxsw_count);
+EXPORT_SYMBOL_GPL(__x86_ctxsw_count);
+EXPORT_SYMBOL_GPL(__x86_call_count);
+#endif
+
 extern s32 __call_sites[], __call_sites_end[];
 
 struct thunk_desc {
@@ -283,3 +293,46 @@ void noinline callthunks_patch_module_ca
 	mutex_unlock(&text_mutex);
 }
 #endif /* CONFIG_MODULES */
+
+#if defined(CONFIG_CALL_THUNKS_DEBUG) && defined(CONFIG_DEBUG_FS)
+static int callthunks_debug_show(struct seq_file *m, void *p)
+{
+	unsigned long cpu = (unsigned long)m->private;
+
+	seq_printf(m, "C: %16llu R: %16llu S: %16llu X: %16llu\n,",
+		   per_cpu(__x86_call_count, cpu),
+		   per_cpu(__x86_ret_count, cpu),
+		   per_cpu(__x86_stuffs_count, cpu),
+		   per_cpu(__x86_ctxsw_count, cpu));
+	return 0;
+}
+
+static int callthunks_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, callthunks_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_ops = {
+	.open		= callthunks_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init callthunks_debugfs_init(void)
+{
+	struct dentry *dir;
+	unsigned long cpu;
+
+	dir = debugfs_create_dir("callthunks", NULL);
+	for_each_possible_cpu(cpu) {
+		void *arg = (void *)cpu;
+		char name [10];
+
+		sprintf(name, "cpu%lu", cpu);
+		debugfs_create_file(name, 0644, dir, arg, &dfs_ops);
+	}
+	return 0;
+}
+__initcall(callthunks_debugfs_init);
+#endif
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -203,13 +203,18 @@ EXPORT_SYMBOL(__x86_return_thunk)
 	.align 64
 SYM_FUNC_START(__x86_return_skl)
 	ANNOTATE_NOENDBR
-	/* Keep the hotpath in a 16byte I-fetch */
+	/*
+	 * Keep the hotpath in a 16byte I-fetch for the non-debug
+	 * case.
+	 */
+	CALL_THUNKS_DEBUG_INC_RETS
 	shlq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth)
 	jz	1f
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
 1:
+	CALL_THUNKS_DEBUG_INC_STUFFS
 	.rept	16
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call	2f


