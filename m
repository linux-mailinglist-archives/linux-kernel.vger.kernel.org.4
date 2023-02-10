Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2FF692A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjBJWmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjBJWmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:42:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBCF55E72
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 360D7B82616
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90465C433A8;
        Fri, 10 Feb 2023 22:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676068931;
        bh=LXh7cCWgskiu1lOCHbKoWebvfAUhqVsfAvFuxIYpy5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FteLrbx76zQKCC/KPwhIke7oMow6ISwTy6SILIJCVjLWipk90bh3gczA4nnV6Y4vQ
         216+36ARPC6NR/y0K9b9zoKJkjY0i2P4jbJVI9X0r0zK9EeT4jr6+7CcgKpgfkZWsy
         lFGbT1FgR12esskj57a+fCtomcG21FDzi70/neyUJ7dGk+ahSqSeQLgfwucmS9xmTo
         TsjJspy9Z7vf1HH/Fl9iC1BnRZ6bKMQhDG0ASF4q1rijWVOKl/wFzRwIePRTPFc52G
         05a0Kjnsoq/97ko3FlHmi3B9kjYYOvqU32ViPEhUc8CytwUVpnNEHogOu3Im+O9WHU
         efJjvaauzJ/sw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/2] x86/entry: Fix unwinding from kprobe on PUSH/POP instruction
Date:   Fri, 10 Feb 2023 14:42:02 -0800
Message-Id: <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676068346.git.jpoimboe@kernel.org>
References: <cover.1676068346.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/entry/entry_64.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 15739a2c0983..8d21881adf86 100644
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
-- 
2.39.1

