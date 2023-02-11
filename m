Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3F6930B7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjBKLxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjBKLxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:53:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F701DBBA;
        Sat, 11 Feb 2023 03:52:45 -0800 (PST)
Date:   Sat, 11 Feb 2023 11:52:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676116351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3UF4wUqZTLvsdmEa7SQuuYGrDWhV3gF1yMB3AJ8OCY=;
        b=C1rHgM0VI4Xh2WVeo/NHY+tfh6BSJNL9LVbHs/ulVoGfj7yu5okNbTq+FuZkij3BfNs2YN
        oMoaVn0wkAj9lhWCBiSaEEMLqxwQRfT6q0qIjpQc2lpiP4CDshLL9fEzTEZJ5zUW/Ssal8
        aar2T6KIBVVuc6hhZS0DX70o8eZZOHGUTMvyPm0tV8heaeRJkeuj5CGvVz8RoBvNrjQ/l4
        g3LigABbYsBnurTXmuVukVGLRvzoEB/cxnzJvY6OiVPbFzZBjVSPNMe+dUssFeFqn6j2lA
        zyXUbkPNizFCZPSOvph/seHdb0VjB7ogbdqc+v9Fuw/TPI+yuCQ1GCUxibOnvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676116351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3UF4wUqZTLvsdmEa7SQuuYGrDWhV3gF1yMB3AJ8OCY=;
        b=eUfPflm92sbzSIzpiq2s6bEOpIukNzEfJhrjxiJT8CHxFOjs1zYIE0hxZNcQj7329mvDGj
        T2SdsxRfFEqD7JBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/entry: Fix unwinding from kprobe on PUSH/POP
 instruction
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
References: <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167611635115.4906.2832947332319700484.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     37064583f63eca93c98a9cdf2360485ea05f617a
Gitweb:        https://git.kernel.org/tip/37064583f63eca93c98a9cdf2360485ea05f617a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 10 Feb 2023 14:42:02 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 11 Feb 2023 12:37:51 +01:00

x86/entry: Fix unwinding from kprobe on PUSH/POP instruction

If a kprobe (INT3) is set on a stack-modifying single-byte instruction,
like a single-byte PUSH/POP or a LEAVE, ORC fails to unwind past it:

  Call Trace:
   <TASK>
   dump_stack_lvl+0x57/0x90
   handler_pre+0x33/0x40 [kprobe_example]
   aggr_pre_handler+0x49/0x90
   kprobe_int3_handler+0xe3/0x180
   do_int3+0x3a/0x80
   exc_int3+0x7d/0xc0
   asm_exc_int3+0x35/0x40
  RIP: 0010:kernel_clone+0xe/0x3a0
  Code: cc e8 16 b2 bf 00 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54 cc <53> 48 89 fb 48 83 ec 68 4c 8b 27 65 48 8b 04 25 28 00 00 00 48 89
  RSP: 0018:ffffc9000074fda0 EFLAGS: 00000206
  RAX: 0000000000808100 RBX: ffff888109de9d80 RCX: 0000000000000000
  RDX: 0000000000000011 RSI: ffff888109de9d80 RDI: ffffc9000074fdc8
  RBP: ffff8881019543c0 R08: ffffffff81127e30 R09: 00000000e71742a5
  R10: ffff888104764a18 R11: 0000000071742a5e R12: ffff888100078800
  R13: ffff888100126000 R14: 0000000000000000 R15: ffff888100126005
   ? __pfx_call_usermodehelper_exec_async+0x10/0x10
   ? kernel_clone+0xe/0x3a0
   ? user_mode_thread+0x5b/0x80
   ? __pfx_call_usermodehelper_exec_async+0x10/0x10
   ? call_usermodehelper_exec_work+0x77/0xb0
   ? process_one_work+0x299/0x5f0
   ? worker_thread+0x4f/0x3a0
   ? __pfx_worker_thread+0x10/0x10
   ? kthread+0xf2/0x120
   ? __pfx_kthread+0x10/0x10
   ? ret_from_fork+0x29/0x50
   </TASK>

The problem is that #BP saves the pointer to the instruction immediately
*after* the INT3, rather than to the INT3 itself.  The instruction
replaced by the INT3 hasn't actually run, but ORC assumes otherwise and
expects the wrong stack layout.

Fix it by annotating the #BP exception as a non-signal stack frame,
which tells the ORC unwinder to decrement the instruction pointer before
looking up the corresponding ORC entry.

Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org
---
 arch/x86/entry/entry_64.S |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 15739a2..8d21881 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -385,7 +385,14 @@ SYM_CODE_END(xen_error_entry)
  */
 .macro idtentry vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
+
+	.if \vector == X86_TRAP_BP
+		/* #BP advances %rip to the next instruction */
+		UNWIND_HINT_IRET_REGS offset=\has_error_code*8 signal=0
+	.else
+		UNWIND_HINT_IRET_REGS offset=\has_error_code*8
+	.endif
+
 	ENDBR
 	ASM_CLAC
 	cld
