Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15A6011BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiJQOyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiJQOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1589691AC;
        Mon, 17 Oct 2022 07:53:45 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fV1/l0X11YiOIK2ib0RRC0WGOOh6xbDnMI8H9/XHTz4=;
        b=VaW8qTDnK0LmcEguYPGUfOjyOmKWUvSm0Tkg5rpTPv0+kxxTyn1zUVrPGSkOi/5h9866lm
        GLSoaf8jjsubxjnwlKkL9TFV9kY312BMBCfTgyTPD7SooySeOs5Fvp+aHxkI0dKzOUjj10
        JKBka4GEA+crbWVyeU0x5sQ2jVpRRQz6oteah6LUMqOl1JhVYP4CgTDONO6/WScFYN5Y5v
        Mlk5tKpN77RBabZYP8cxpYuiijFoQMB20ru4j6/KJ6XagJ9dXsH16A/OgxQicjQ+W/0Ef0
        5SgeUdwZ/73QlnZmnzDvdXTWVhCkQWfY1LEuJvT/Medy7AxjjxUmqSrC7BQFWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fV1/l0X11YiOIK2ib0RRC0WGOOh6xbDnMI8H9/XHTz4=;
        b=2N33ZBtZpASKvE5Fhs6wJxTLP2QqlDGM08rd6APJPIUAU/3Sd/LS8Ngoqyyej/KmdU9zUO
        Wekn831hBwLLzzDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/calldepth: Add ret/call counting for debug
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111148.204285506@infradead.org>
References: <20220915111148.204285506@infradead.org>
MIME-Version: 1.0
Message-ID: <166601841738.401.8846324922900036711.tip-bot2@tip-bot2>
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

Commit-ID:     f5c1bb2afe93396d41c5cbdcb909b08a75b8dde4
Gitweb:        https://git.kernel.org/tip/f5c1bb2afe93396d41c5cbdcb909b08a75b8dde4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:16 +02:00

x86/calldepth: Add ret/call counting for debug

Add a debuigfs mechanism to validate the accounting, e.g. vs. call/ret
balance and to gather statistics about the stuffing to call ratio.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111148.204285506@infradead.org
---
 arch/x86/include/asm/nospec-branch.h | 36 ++++++++++++++++--
 arch/x86/kernel/callthunks.c         | 53 +++++++++++++++++++++++++++-
 arch/x86/lib/retpoline.S             |  7 +++-
 3 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 06ba7ca..4771147 100644
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
 #if defined(CONFIG_CALL_DEPTH_TRACKING) && !defined(COMPILE_OFFSETS)
 
 #include <asm/asm-offsets.h>
@@ -75,18 +91,23 @@
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
 
@@ -137,7 +158,8 @@
 	jnz	771b;					\
 	/* barrier for jnz misprediction */		\
 	lfence;						\
-	ASM_CREDIT_CALL_DEPTH
+	ASM_CREDIT_CALL_DEPTH				\
+	CALL_THUNKS_DEBUG_INC_CTXSW
 #else
 /*
  * i386 doesn't unconditionally have LFENCE, as such it can't
@@ -321,6 +343,12 @@ static inline void x86_set_skl_return_thunk(void)
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
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 01f6f6b..dfe7fff 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -2,6 +2,7 @@
 
 #define pr_fmt(fmt) "callthunks: " fmt
 
+#include <linux/debugfs.h>
 #include <linux/kallsyms.h>
 #include <linux/memory.h>
 #include <linux/moduleloader.h>
@@ -35,6 +36,15 @@ static int __init debug_thunks(char *str)
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
@@ -283,3 +293,46 @@ void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
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
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index e002060..5f61c65 100644
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
