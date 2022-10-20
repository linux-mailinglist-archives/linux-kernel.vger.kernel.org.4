Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D100C606366
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJTOnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJTOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D4E1A1B28
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A07A561BC2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9F1C433C1;
        Thu, 20 Oct 2022 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666276986;
        bh=1mkLwMduon6mFlXdZ1go1kC/+lZJsRhnP5cXjU0CP9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Se7BLwYGeyBpaIOaeMvTnpIfQPcLMy/HG8PNLOANqEHWjQO00EEcU/9jHx1e4NEcE
         Jrau7ya8nIOCwPX2I7qExozEfboSDqcOn/awK3TURUhTT2f2APsBtlkLkdvqmDKULG
         K8nwJidULg8IeFaF35l1ft1sh4gh/z4m8wFDlhPCz2zGNIq3pU3+PhEp7rainQg7Hr
         urKMdQLW61oxmVeixPwxqNTKEHGKvekeyHEZUzCTm5mity78SeuRqwM9TbbJbX8ghh
         6gixtq4lXPVK8ApMSpbFxhJihlKxt412Cp6TsnaNX6NlkVanE1KXYkJUE6ryLVqbwV
         XcYIjkGmKMpFw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v2] riscv: fix race when vmap stack overflow
Date:   Thu, 20 Oct 2022 22:33:29 +0800
Message-Id: <20221020143329.3276-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Since v1:
 - use smp_store_release directly
 - use unsigned int instead of atomic_t

 arch/riscv/kernel/entry.S | 4 ++++
 arch/riscv/kernel/traps.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index b9eda3fcbd6d..7b924b16792b 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -404,6 +404,10 @@ handle_syscall_trace_exit:
 
 #ifdef CONFIG_VMAP_STACK
 handle_kernel_stack_overflow:
+1:	la sp, spin_shadow_stack
+	amoswap.w sp, sp, (sp)
+	bnez sp, 1b
+
 	la sp, shadow_stack
 	addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f3e96d60a2ff..f1f57c1241b6 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -221,11 +221,15 @@ asmlinkage unsigned long get_overflow_stack(void)
 		OVERFLOW_STACK_SIZE;
 }
 
+unsigned int spin_shadow_stack;
+
 asmlinkage void handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
 	unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
 
+	smp_store_release(&spin_shadow_stack, 0);
+
 	console_verbose();
 
 	pr_emerg("Insufficient stack space to handle exception!\n");
-- 
2.37.2

