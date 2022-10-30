Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B59612AA0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJ3MzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3MzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 08:55:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8CAC23
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 05:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61C61B80D34
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 12:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DECBC433D6;
        Sun, 30 Oct 2022 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667134498;
        bh=5yoWTKKzJPGZvHI5RJZ+Ao+F3Il25e1XFouqIcbN/OM=;
        h=From:To:Cc:Subject:Date:From;
        b=HxNVdgXEvFeRh1kbN198L/t6hi9jKHlgNeKv2l+40ZteX0YlwXW+eGG6VM/fFMq7w
         31+NuSwyxTfZtVkel46cbH7T4tSLoFyxYrbZrYXniVgUImPkSKnasv1W3KVRfl5sn/
         19AvicBwhny8xHgsgFcXmFKAu2KjdH+T+ylsvqkCNGjfC8+0KsrzAbt/UoPOzRO5QT
         JCzSf5oYfswN0PXMmBnMv+lQhm53ydqMiaXesMm7QCYbCI+/VzqUIgTPG4LwiGdaVg
         mtIQToo8nIiOaxlUaiuRIfvSG2FyXSpdJr1XFI3/L8NrN2iC2kZO/li7P96IyNyNbQ
         N8RRKe1TQSujw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] riscv: fix race when vmap stack overflow
Date:   Sun, 30 Oct 2022 20:45:17 +0800
Message-Id: <20221030124517.2370-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when detecting vmap stack overflow, riscv firstly switches
to the so called shadow stack, then use this shadow stack to call the
get_overflow_stack() to get the overflow stack. However, there's
a race here if two or more harts use the same shadow stack at the same
time.

To solve this race, we introduce spin_shadow_stack atomic var, which
will be swap between its own address and 0 in atomic way, when the
var is set, it means the shadow_stack is being used; when the var
is cleared, it means the shadow_stack isn't being used.

Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Suggested-by: Guo Ren <guoren@kernel.org>
---
Since v2:
 - use REG_AMOSWAP
 - add comment to the purpose of smp_store_release()

Since v1:
 - use smp_store_release directly
 - use unsigned int instead of atomic_t


 arch/riscv/include/asm/asm.h | 1 +
 arch/riscv/kernel/entry.S    | 4 ++++
 arch/riscv/kernel/traps.c    | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 1b471ff73178..acf563072b8b 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -23,6 +23,7 @@
 #define REG_L		__REG_SEL(ld, lw)
 #define REG_S		__REG_SEL(sd, sw)
 #define REG_SC		__REG_SEL(sc.d, sc.w)
+#define REG_AMOSWAP	__REG_SEL(amoswap.d, amoswap.w)
 #define REG_ASM		__REG_SEL(.dword, .word)
 #define SZREG		__REG_SEL(8, 4)
 #define LGREG		__REG_SEL(3, 2)
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index b9eda3fcbd6d..ea6b78dac739 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -404,6 +404,10 @@ handle_syscall_trace_exit:
 
 #ifdef CONFIG_VMAP_STACK
 handle_kernel_stack_overflow:
+1:	la sp, spin_shadow_stack
+	REG_AMOSWAP sp, sp, (sp)
+	bnez sp, 1b
+
 	la sp, shadow_stack
 	addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f3e96d60a2ff..dea47f329708 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -221,11 +221,20 @@ asmlinkage unsigned long get_overflow_stack(void)
 		OVERFLOW_STACK_SIZE;
 }
 
+unsigned long spin_shadow_stack;
+
 asmlinkage void handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
 	unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
 
+	/*
+	 * to ensure spin flag is set after the sp is used in entry.S:
+	 * //load per-cpu overflow stack.
+	 * REG_L sp, -8(sp)
+	 */
+	smp_store_release(&spin_shadow_stack, 0);
+
 	console_verbose();
 
 	pr_emerg("Insufficient stack space to handle exception!\n");
-- 
2.37.2

