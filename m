Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A9D74E3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGKBvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGKBvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A955136;
        Mon, 10 Jul 2023 18:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C81612AB;
        Tue, 11 Jul 2023 01:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCB6C433C7;
        Tue, 11 Jul 2023 01:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689040263;
        bh=DyLifkE+mWkAJUWftPR5lGeD6sKueyYzATZh59IvHwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoJ0l1uO1SG+a0wjcEMYnieBeWbRZEPyqQUJaeEcVX3zfM8X8IpzK2aG0G/3KCs4E
         30Q2WG56TYfXxP96eJ+QjIgVk4cA5Evomj7TK0ebhyIj8BNRHtdrr0r1Ku44lSUgKZ
         6/2qNGxfZEe31jVAP9TyUyoAVOi8q70izu8rQ2z2JMNbFCviz+k/6MmEDY3pIlOm9D
         /BuNnB5ozUhlZmRjh4zZZwQft4iEouEfYe1IiqKukeWFLzLeIg2AtxV7cpGeEoYLdy
         1OK+0/EiiFDPfZttGzRLqBD2p8NGplr49H0VK/qk111g7ywuJLfyF3RCyJQnFoOaOj
         vkHXND+BsUMDg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 2/2] x86/kprobes: Prohibit probing on compiler generated CFI checking code
Date:   Tue, 11 Jul 2023 10:50:58 +0900
Message-Id: <168904025785.116016.12766408611437534723.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168904023542.116016.10540228903086100726.stgit@devnote2>
References: <168904023542.116016.10540228903086100726.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Prohibit probing on the compiler generated CFI typeid checking code
because it is used for decoding typeid when CFI error happens.

The compiler generates the following instruction sequence for indirect
call checks on x86;

   movl    -<id>, %r10d       ; 6 bytes
   addl    -4(%reg), %r10d    ; 4 bytes
   je      .Ltmp1             ; 2 bytes
   ud2                        ; <- regs->ip

And handle_cfi_failure() decodes these instructions (movl and addl)
for the typeid and the target address. Thus if we put a kprobe on
those instructions, the decode will fail and report a wrong typeid
and target address.


Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/kprobes/core.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index f7f6042eb7e6..fa8c2b41cbaf 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -54,6 +54,7 @@
 #include <asm/insn.h>
 #include <asm/debugreg.h>
 #include <asm/ibt.h>
+#include <asm/cfi.h>
 
 #include "common.h"
 
@@ -293,7 +294,40 @@ static int can_probe(unsigned long paddr)
 #endif
 		addr += insn.length;
 	}
+	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+		/*
+		 * The compiler generates the following instruction sequence
+		 * for indirect call checks and cfi.c decodes this;
+		 *
+		 *   movl    -<id>, %r10d       ; 6 bytes
+		 *   addl    -4(%reg), %r10d    ; 4 bytes
+		 *   je      .Ltmp1             ; 2 bytes
+		 *   ud2                        ; <- regs->ip
+		 *   .Ltmp1:
+		 *
+		 * Also, these movl and addl are used for showing expected
+		 * type. So those must not be touched.
+		 */
+		__addr = recover_probed_instruction(buf, addr);
+		if (!__addr)
+			return 0;
+
+		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
+			return 0;
+
+		if (insn.opcode.value == 0xBA)
+			offset = 12;
+		else if (insn.opcode.value == 0x3)
+			offset = 6;
+		else
+			goto out;
+
+		/* This movl/addl is used for decoding CFI. */
+		if (is_cfi_trap(addr + offset))
+			return 0;
+	}
 
+out:
 	return (addr == paddr);
 }
 

