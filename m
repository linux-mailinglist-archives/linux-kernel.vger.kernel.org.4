Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1937D707EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjERLJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjERLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:09:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FE8213B;
        Thu, 18 May 2023 04:08:36 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ejN/mH3LR4t0/RUCezt3x65qUEpqLMlgQXY4nbjFu8=;
        b=XC6eLNNsAdHp2b1+A3c+pnQghTjEL3wVKhHYIY5YjHmAUd88GYRm6AG5WTglqeoArFVR2h
        UxivzU+HIJyIjwZvNlHpo06Bq2aw6vGRhtAzUPUtQjF7QB+iqVLR9RJRTPJyfbNhnUliFu
        hDqUlFpq+tT+xIZmZov+y1iKmkvpSSG9/bmWQGqzqPfFEkmhhKgcZuz3Cix7IW1nyXHQ+W
        gYinMFk1gCFu+z2f9th7ZoIvMcrHuQ10fopwSBPfMxQ3f81NTWZtwPnMC6RCWcCG3wlJCY
        zGgt9aQJaSedQdj8hMKaNa8OnehslekxEapqvhf32gRHvMWQu7RUxD50R6qYjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ejN/mH3LR4t0/RUCezt3x65qUEpqLMlgQXY4nbjFu8=;
        b=51/M3jrukm/XcJMmtDuSZIBW9GG7Y57/BG1pVdiWYWKLgYj54RmbGam1WV0cPwlL7YbrgJ
        4wLJdsY5DeCsEJBw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/unwind/orc: Add 'unwind_debug' cmdline option
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6afb9e48a05fd2046bfad47e69b061b43dfd0e0e.1681331449.git.jpoimboe@kernel.org>
References: <6afb9e48a05fd2046bfad47e69b061b43dfd0e0e.1681331449.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168440808334.404.13534074205868319070.tip-bot2@tip-bot2>
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

Commit-ID:     89da5a69a831f20df6463fd524e1578e12a8f46f
Gitweb:        https://git.kernel.org/tip/89da5a69a831f20df6463fd524e1578e12a8f46f
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 12 Apr 2023 13:31:05 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:31:50 -07:00

x86/unwind/orc: Add 'unwind_debug' cmdline option

Sometimes the one-line ORC unwinder warnings aren't very helpful.  Add a
new 'unwind_debug' cmdline option which will dump the full stack
contents of the current task when an error condition is encountered.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/6afb9e48a05fd2046bfad47e69b061b43dfd0e0e.1681331449.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++-
 arch/x86/kernel/unwind_orc.c                    | 49 +++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab2..f922eea 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6563,6 +6563,12 @@
 	unknown_nmi_panic
 			[X86] Cause panic on unknown NMI.
 
+	unwind_debug	[X86-64]
+			Enable unwinder debug output.  This can be
+			useful for debugging certain unwinder error
+			conditions, including corrupt stacks and
+			bad/missing unwinder metadata.
+
 	usbcore.authorized_default=
 			[USB] Default USB device authorization:
 			(default -1 = authorized except for wireless USB,
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 5fbcb22..7891727 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -13,8 +13,14 @@
 
 #define orc_warn_current(args...)					\
 ({									\
-	if (state->task == current && !state->error)			\
+	static bool dumped_before;					\
+	if (state->task == current && !state->error) {			\
 		orc_warn(args);						\
+		if (unwind_debug && !dumped_before) {			\
+			dumped_before = true;				\
+			unwind_dump(state);				\
+		}							\
+	}								\
 })
 
 extern int __start_orc_unwind_ip[];
@@ -23,8 +29,49 @@ extern struct orc_entry __start_orc_unwind[];
 extern struct orc_entry __stop_orc_unwind[];
 
 static bool orc_init __ro_after_init;
+static bool unwind_debug __ro_after_init;
 static unsigned int lookup_num_blocks __ro_after_init;
 
+static int __init unwind_debug_cmdline(char *str)
+{
+	unwind_debug = true;
+
+	return 0;
+}
+early_param("unwind_debug", unwind_debug_cmdline);
+
+static void unwind_dump(struct unwind_state *state)
+{
+	static bool dumped_before;
+	unsigned long word, *sp;
+	struct stack_info stack_info = {0};
+	unsigned long visit_mask = 0;
+
+	if (dumped_before)
+		return;
+
+	dumped_before = true;
+
+	printk_deferred("unwind stack type:%d next_sp:%p mask:0x%lx graph_idx:%d\n",
+			state->stack_info.type, state->stack_info.next_sp,
+			state->stack_mask, state->graph_idx);
+
+	for (sp = __builtin_frame_address(0); sp;
+	     sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+		if (get_stack_info(sp, state->task, &stack_info, &visit_mask))
+			break;
+
+		for (; sp < stack_info.end; sp++) {
+
+			word = READ_ONCE_NOCHECK(*sp);
+
+			printk_deferred("%0*lx: %0*lx (%pB)\n", BITS_PER_LONG/4,
+					(unsigned long)sp, BITS_PER_LONG/4,
+					word, (void *)word);
+		}
+	}
+}
+
 static inline unsigned long orc_ip(const int *ip)
 {
 	return (unsigned long)ip + *ip;
