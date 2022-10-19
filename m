Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB73604C85
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiJSP7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiJSP6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:58:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746B21CCCE0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2653BB824FA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF9FC433C1;
        Wed, 19 Oct 2022 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666195024;
        bh=tl/t0JSFx6B/W7U7U+lCNfIdDELRIvrRpnIkdxf7UO8=;
        h=From:To:Cc:Subject:Date:From;
        b=LXQ3DBXykd8cxJe+nDeTMuzZh2SioIauX440gB0kLifBqT436A3SwZ8AqZAu0d5Ks
         QaH7PcJ7Zc5hE1yZ2imldpdk31TSsBPmyqtqIUmi/FDTM7tlChYsG3UdkuAm43zcOZ
         RAvDnZZCtCzMzQWa2vGzAFjZlg84MC1gKhu9nK2YdtXDm2qiYt7ZuDVhgD6so4+eab
         ItBZ4nypwK6bA1YqZxImaHz4C5ugTj8o4tT4JXmFk+xq+iKF2uoHw9fPykRoMDNju8
         p4Ah1KhNSiZSfM7VwAmm6T8F5k5PTyhH7sfIJdBw4ZMGoCPp3RMnU1QXuOVwaKr0tn
         j/GdetFOTgQsA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH] riscv: fix race when vmap stack overflow
Date:   Wed, 19 Oct 2022 23:47:27 +0800
Message-Id: <20221019154727.2395-1-jszhang@kernel.org>
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
will make the shadow stack usage serialized.

Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Suggested-by: Guo Ren <guoren@kernel.org>
---
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
index f3e96d60a2ff..88a54947dffb 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -221,11 +221,15 @@ asmlinkage unsigned long get_overflow_stack(void)
 		OVERFLOW_STACK_SIZE;
 }
 
+atomic_t spin_shadow_stack;
+
 asmlinkage void handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
 	unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
 
+	atomic_set_release(&spin_shadow_stack, 0);
+
 	console_verbose();
 
 	pr_emerg("Insufficient stack space to handle exception!\n");
-- 
2.37.2

