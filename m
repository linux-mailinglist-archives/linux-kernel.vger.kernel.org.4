Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2E8638203
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKYBJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiKYBJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:09:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD52A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:09:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7300FB828B4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E58AC433C1;
        Fri, 25 Nov 2022 01:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669338546;
        bh=QbvzCVj+PTeLzj0/LVqRAUZ98M4/iaizm8NUyKbAdp0=;
        h=From:To:Cc:Subject:Date:From;
        b=YVV1kWFBMzk0C0u43AsN+3OD71NG1HHydwNb8KBG3zHzXD6FpSSPqdrgYyiIBfcdn
         kEQO/oWlZxc3nrzfus91DHNbVULzOv9pMbTs6YKPakplYX88mEG/SGtkotb0y0304+
         o1TqlENVnF9/3xeAhtUChko9b+n0SNpBuXzBAvJcO0KzLkNtbHaDGnPHvkB5tEGivQ
         sPV0wwP51+UmE80/f6VpUSPGBZ1lYybE7gbpxR1rV75YVyFuKvsdaf8oiIYBDJYUxG
         Wig1UcSRj6fq5JfsJzSNtPrY0h529gOGcv9QqXMSwDeopZO42/BexV26p6bx4GcxZo
         vfzZs4Ivw5Fzg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Subject: [PATCH -tip] x86/kprobes: Handle removed INT3 in do_int3()
Date:   Fri, 25 Nov 2022 10:09:02 +0900
Message-Id: <166933854220.2683864.10006153553442313230.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since x86 doesn't use stop_machine() to patch the kernel text,
there is a small chance that the another CPU removes the INT3
during do_int3(). In this case, if no INT3 notifier callbacks
handled that, the kernel calls die() because of a stray INT3.

Currently this is checked and recovered in the kprobe_int3_handler(),
but this is wrong because;

 - If CONFIG_KPROBES is not set, kernel does not handle this case.

 - After kprobe_int3_handler() ignores that INT3, that can be
  removed before notify_die(DIE_INT3). And if the callback misses
  it, kernel dies.

 - It skips the INT3 notifier callbacks if the INT3 is NOT managed
  by the kprobes. Another callback may be able to handle it.

Thus, move the removed INT3 recovering code to do_int3(),
after calling all callbacks.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |   15 +--------------
 arch/x86/kernel/traps.c        |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 66299682b6b7..aa414224ac8a 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -987,20 +987,7 @@ int kprobe_int3_handler(struct pt_regs *regs)
 			return 1;
 		}
 	}
-
-	if (*addr != INT3_INSN_OPCODE) {
-		/*
-		 * The breakpoint instruction was removed right
-		 * after we hit it.  Another cpu has removed
-		 * either a probepoint or a debugger breakpoint
-		 * at this address.  In either case, no further
-		 * handling of this interrupt is appropriate.
-		 * Back up over the (now missing) int3 and run
-		 * the original instruction.
-		 */
-		regs->ip = (unsigned long)addr;
-		return 1;
-	} /* else: not a kprobe fault; let the kernel handle it */
+	/* This may not a kprobe fault; let the kernel handle it */
 
 	return 0;
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 8b83d8fbce71..2d22379bdf66 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -788,6 +788,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
 static bool do_int3(struct pt_regs *regs)
 {
+	unsigned long addr = instruction_pointer(regs) - INT3_INSN_SIZE;
 	int res;
 
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
@@ -802,6 +803,20 @@ static bool do_int3(struct pt_regs *regs)
 #endif
 	res = notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP, SIGTRAP);
 
+	if (unlikely(res != NOTIFY_STOP)) {
+		if (*(u8 *)addr != INT3_INSN_OPCODE) {
+			/*
+			 * Another CPU removed the INT3 instruction before
+			 * callbacks handle it. This is not a stray INT3
+			 * but recoverable.
+			 * Back up over the (now missing) INT3 and run
+			 * the original instruction.
+			 */
+			regs->ip = addr;
+			return true;
+		}
+	}
+
 	return res == NOTIFY_STOP;
 }
 NOKPROBE_SYMBOL(do_int3);

