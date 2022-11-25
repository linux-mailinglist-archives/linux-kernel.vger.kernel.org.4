Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F5638CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiKYOql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiKYOq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:46:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5A35F6E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:44:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98BCEB82B1D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 14:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78841C433D7;
        Fri, 25 Nov 2022 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669387491;
        bh=8NIIVDovM0SYY9RImta8s62LMtgAu/OF6DMIyj6uBfA=;
        h=From:To:Cc:Subject:Date:From;
        b=tkb+NtypaHy+oUxQWBoy+1CFK7NjdmhkCXx222q35vNLloSsz6gU/KAhKT992/aDl
         wG6lYFJ3ZvqtUdCX5ZttiGw9wcMRX3/6Vrqxm6fllWSYWh8pTG6l6nkGpXE8Jk3veU
         kFGmw+l3BK4VPVLW37uQNLasRBNsaG/nVHWCQtD8lW1jKvzkNmFyBn3XmU5AzsUtVu
         fJj4Lokxdxz/0DTA1xIHf/NCpjkgyukn10A51UxZOsiVOvssMeqOoVCIQQmMEOexBw
         c9VCDdZeX35wSIQPsXPH2VCnPiiGgZqm0mwjGvkeZ7u1hF7UkJ/tyTfH5ADxs3/pv5
         N5s/adEAFZ8UA==
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
Subject: [PATCH -tip] x86/kprobes: Drop removed INT3 handling code
Date:   Fri, 25 Nov 2022 23:44:47 +0900
Message-Id: <166938748740.2964025.7215038423815144481.stgit@devnote3>
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

For the kprobe managed INT3, the arch_disarm_kprobe() removes the INT3
and then calls text_poke_sync(). Since this text_poke_sync() uses IPI
to call sync_core() on all online cpus, that ensures that all running
INT3 exception handlers have done.
And, the unregister_kprobe() will remove the kprobe from the hash table
after arch_disarm_kprobe().

Thus, when the kprobe managed INT3 hits, kprobe_int3_handler() should
be able to find corresponding kprobe always by get_kprobe(). If it can
not find any kprobe, this means that is NOT a kprobe managed INT3.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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

