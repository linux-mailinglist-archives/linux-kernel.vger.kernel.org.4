Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90526E45B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjDQKvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjDQKus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:50:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EE3868B;
        Mon, 17 Apr 2023 03:50:03 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aolYCW6BgKOyEtD8DrOwUI4vowED8g/kmdmypggM9C8=;
        b=H6ouT7OvKN8c2M+K4Yxtcyt/W6y0H2vOT+E9Ee8nG8LX1nCElXJTK60h0sTTkJIaUx6cV/
        //2bGvjT5PT+1oLI0TJfdmTWNl+RPjVZNffKpNJuYxAw8tg2+TceTfFvgbl6HQpPwM1m0N
        1PGU3s5vrivVFvIqY9Eoz0Q6Jzoagi+kvRhsAfebpZlobA8qdMP/hL9staj5PRbQIkRy+A
        W3pgnUTKzD8XdGSpva7ozMz8t9y2C0f3wVIjSjsnqRr6TNwmBwv1pU2AGKh5cg0jRBbGta
        iwujHZrZYx2lPKWj8uJok8Tr1s1s2fbx7NDtZWy7iqn5D0Wq4eO4PVdCCkn5cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aolYCW6BgKOyEtD8DrOwUI4vowED8g/kmdmypggM9C8=;
        b=z/lrDazUoFU10SPyVdzEi6CEORp8wWY6wd6aYGotfmvb7frPnkZdh+JSA41/6sqdrXYvjy
        t6WCNpkCo7SgQNAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] init: Mark [arch_call_]rest_init() __noreturn
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <7194ed8a989a85b98d92e62df660f4a90435a723.1681342859.git.jpoimboe@kernel.org>
References: <7194ed8a989a85b98d92e62df660f4a90435a723.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840811.404.2288887185629391218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9ea7e6b62c2bd2f7bbfc3f10099df803002dd33b
Gitweb:        https://git.kernel.org/tip/9ea7e6b62c2bd2f7bbfc3f10099df803002dd33b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 16:49:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:23 +02:00

init: Mark [arch_call_]rest_init() __noreturn

In preparation for improving objtool's handling of weak noreturn
functions, mark start_kernel(), arch_call_rest_init(), and rest_init()
__noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/7194ed8a989a85b98d92e62df660f4a90435a723.1681342859.git.jpoimboe@kernel.org
---
 arch/s390/kernel/setup.c     | 2 +-
 include/linux/start_kernel.h | 4 ++--
 init/main.c                  | 4 ++--
 tools/objtool/check.c        | 2 ++
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 8ec5cdf..4259b6c 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -396,7 +396,7 @@ int __init arch_early_irq_init(void)
 	return 0;
 }
 
-void __init arch_call_rest_init(void)
+void __init __noreturn arch_call_rest_init(void)
 {
 	unsigned long stack;
 
diff --git a/include/linux/start_kernel.h b/include/linux/start_kernel.h
index 8b369a4..864921e 100644
--- a/include/linux/start_kernel.h
+++ b/include/linux/start_kernel.h
@@ -9,7 +9,7 @@
    up something else. */
 
 extern asmlinkage void __init start_kernel(void);
-extern void __init arch_call_rest_init(void);
-extern void __ref rest_init(void);
+extern void __init __noreturn arch_call_rest_init(void);
+extern void __ref __noreturn rest_init(void);
 
 #endif /* _LINUX_START_KERNEL_H */
diff --git a/init/main.c b/init/main.c
index 4425d17..161ed95 100644
--- a/init/main.c
+++ b/init/main.c
@@ -683,7 +683,7 @@ static void __init setup_command_line(char *command_line)
 
 static __initdata DECLARE_COMPLETION(kthreadd_done);
 
-noinline void __ref rest_init(void)
+noinline void __ref __noreturn rest_init(void)
 {
 	struct task_struct *tsk;
 	int pid;
@@ -889,7 +889,7 @@ static int __init early_randomize_kstack_offset(char *buf)
 early_param("randomize_kstack_offset", early_randomize_kstack_offset);
 #endif
 
-void __init __weak arch_call_rest_init(void)
+void __init __weak __noreturn arch_call_rest_init(void)
 {
 	rest_init();
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index df634da..3d7227f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -202,6 +202,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"__reiserfs_panic",
 		"__stack_chk_fail",
 		"__ubsan_handle_builtin_unreachable",
+		"arch_call_rest_init",
 		"arch_cpu_idle_dead",
 		"cpu_bringup_and_idle",
 		"cpu_startup_entry",
@@ -217,6 +218,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"machine_real_restart",
 		"make_task_dead",
 		"panic",
+		"rest_init",
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
 		"snp_abort",
