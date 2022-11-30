Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3115663D6CA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiK3NdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK3NdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:33:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4546C2A976
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:33:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99DA161BEA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFB1C433C1;
        Wed, 30 Nov 2022 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669815193;
        bh=XO5UJqdtuocJYtQeIVXnMEv2iX5AN+0skfN/KK6ex14=;
        h=From:To:Cc:Subject:Date:From;
        b=Tl81z/noFegDucrDO/148YmlTLCpLmQXXrq0HQamnuT/lYSlxG0zL75XB9jt4Zyav
         ulbHsnITYoTmzQy59PMt2RyC2l57y3zn42h6MN6A3Hj9X/zH/NDqOHD6BG9m9kczkr
         OVafDTpKeVJpQT6i8fnh5X8DBwDXw1o/ZsVQ3QCWAQuYfdSmMQw1Pc6tfE5Uuab+/b
         McQbiZhS9Fjnm5iQEIlMh9SRN2Ucq6eNXiv43e1Ib/9ai1BUxdos/HrIDXK4os7YMh
         PCoH5sIL1xU1hkedljc50HqFiaQKnGsrFOXt1VuFeCASZb7kpoBgz6ewDMtwljVoYw
         GP0Td1RZUXiyQ==
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
Subject: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Date:   Wed, 30 Nov 2022 22:33:09 +0900
Message-Id: <166981518895.1131462.4693062055762912734.stgit@devnote3>
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
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Changes in v2:
  - update comment to mention that the first safe commit.
---
 arch/x86/kernel/kprobes/core.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 66299682b6b7..33390ed4dcf3 100644
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

