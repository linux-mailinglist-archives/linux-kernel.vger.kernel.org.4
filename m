Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61087660E45
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 12:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjAGLga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 06:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjAGLg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 06:36:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E726CFF2;
        Sat,  7 Jan 2023 03:36:26 -0800 (PST)
Date:   Sat, 07 Jan 2023 11:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673091385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHFyM2eIBJfJJi6mFFPW4A3huteEXEQugWFCywDFYpY=;
        b=FxisGmZ53v75T4A/6w5qor40Wr+U7opG8ubaPyBjw4du22xFUUF1JQpEPTbZ2FuySvmE/u
        W+9G8LlWH4M3OYrlX0QV31IgVUKwYRjjCnCc4i4VizvOu6+pUE4h1OSSGWnGgBNuVpRBzW
        9FYxqLYTotycl/tEBaYjRnh99Ae8rrrRQJpwgIZsGg3Ra6bkU4zP+rw6D4/7yGtJlSyg+a
        UkU1E5rTvvMiRndUXzNPvgsPnpjvHdDb9yglVxZv5Yn2Vij6eDpcBtToUYSHtrwmiMBWGc
        pqkNT7hPtepgzfM+EsXWcUh1wECgewI8WTGPO52ndhNAUAl4xWVTvC5hTmedzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673091385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHFyM2eIBJfJJi6mFFPW4A3huteEXEQugWFCywDFYpY=;
        b=RAlE/kRmDjkZvBhc7cl6GMTDNSPZSvO1AL0KPk0o0cFBVLdPHZqkObp3VJV1BwZAHrqxie
        ubcz7u/G62XNyWCg==
From:   "tip-bot2 for Masami Hiramatsu (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/kprobes: Drop removed INT3 handling code
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <166981518895.1131462.4693062055762912734.stgit@devnote3>
References: <166981518895.1131462.4693062055762912734.stgit@devnote3>
MIME-Version: 1.0
Message-ID: <167309138457.4906.13063757584973355042.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8e791f7eba4c7711f56616ae163ee3cbc00b1bf4
Gitweb:        https://git.kernel.org/tip/8e791f7eba4c7711f56616ae163ee3cbc00b1bf4
Author:        Masami Hiramatsu (Google) <mhiramat@kernel.org>
AuthorDate:    Wed, 30 Nov 2022 22:33:09 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Jan 2023 12:29:08 +01:00

x86/kprobes: Drop removed INT3 handling code

Drop removed INT3 handling code from kprobe_int3_handler() because this
case (get_kprobe() doesn't return corresponding kprobe AND the INT3 is
removed) must not happen with the kprobe managed INT3, but can happen
with the non-kprobe INT3, which should be handled by other callbacks.

For the kprobe managed INT3, it is already safe. The commit 5c02ece81848d
("x86/kprobes: Fix ordering while text-patching") introduced
text_poke_sync() to the arch_disarm_kprobe() right after removing INT3.
Since this text_poke_sync() uses IPI to call sync_core() on all online
cpus, that ensures that all running INT3 exception handlers have done.
And, the unregister_kprobe() will remove the kprobe from the hash table
after arch_disarm_kprobe().

Thus, when the kprobe managed INT3 hits, kprobe_int3_handler() should
be able to find corresponding kprobe always by get_kprobe(). If it can
not find any kprobe, this means that is NOT a kprobe managed INT3.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/166981518895.1131462.4693062055762912734.stgit@devnote3
---
 arch/x86/kernel/kprobes/core.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6629968..33390ed 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -986,20 +986,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
 			kprobe_post_process(p, regs, kcb);
 			return 1;
 		}
-	}
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
 	} /* else: not a kprobe fault; let the kernel handle it */
 
 	return 0;
