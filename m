Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426105F2EE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJCKjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJCKi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:38:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F46C1DA74
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 03:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29EA8B80F2B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DD4C433D6;
        Mon,  3 Oct 2022 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664793536;
        bh=Ge/o7Rp8DcY2sG0HuCr9FZPeFSgyQgALAhESbZPndRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZaefyPbry2+/5DcwEpVZlyTQfffy/QXFw2DUFzzbsDvxRnGR21S2t/KwZT3ATBXha
         lxrD1qzQiZoBI8aJJgbfoR6TWckp/KrqnWTZlgRsmWc63P3LmfF2r82uQVcs32F1US
         tsJk6YBDilccAjDtZeNTwMWavvXFSzcCCEcLTHKkjNzZHetyonpT8rHBoaioUOqUSy
         rtFQD76heyFpj5nTk8zSGPzKy+eofdjRsaHa0V0du7cBFr8UT+JeaXZ9Dqce6BRNTL
         tqDJBW1LPZ/ebb9/8wbE3hB1EzyfR4cpUv1iKkuNtCmZ5gF5B/KAsutiYHiZcezC4c
         rklcZlV5+fvVQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] riscv: consolidate ret_from_kernel_thread into ret_from_fork
Date:   Mon,  3 Oct 2022 18:29:19 +0800
Message-Id: <20221003102921.3973-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221003102921.3973-1-jszhang@kernel.org>
References: <20221003102921.3973-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ret_from_kernel_thread() behaves similarly with ret_from_fork(),
the only difference is whether call the fn(arg) or not, this can be
acchieved by testing fn is NULL or not, I.E s0 is 0 or not.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/entry.S   | 11 +++--------
 arch/riscv/kernel/process.c |  5 ++---
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 39097c1474a0..d227aca7f9d4 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -323,20 +323,15 @@ END(handle_kernel_stack_overflow)
 
 ENTRY(ret_from_fork)
 	call schedule_tail
-	move a0, sp /* pt_regs */
-	la ra, ret_from_exception
-	tail syscall_exit_to_user_mode
-ENDPROC(ret_from_fork)
-
-ENTRY(ret_from_kernel_thread)
-	call schedule_tail
+	beqz s0, 1f	/* not from kernel thread */
 	/* Call fn(arg) */
 	move a0, s1
 	jalr s0
+1:
 	move a0, sp /* pt_regs */
 	la ra, ret_from_exception
 	tail syscall_exit_to_user_mode
-ENDPROC(ret_from_kernel_thread)
+ENDPROC(ret_from_fork)
 
 
 /*
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 52002d54b163..fdafed185e21 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -34,7 +34,6 @@ EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
 extern asmlinkage void ret_from_fork(void);
-extern asmlinkage void ret_from_kernel_thread(void);
 
 void arch_cpu_idle(void)
 {
@@ -174,7 +173,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		/* Supervisor/Machine, irqs on: */
 		childregs->status = SR_PP | SR_PIE;
 
-		p->thread.ra = (unsigned long)ret_from_kernel_thread;
 		p->thread.s[0] = (unsigned long)args->fn;
 		p->thread.s[1] = (unsigned long)args->fn_arg;
 	} else {
@@ -184,8 +182,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		if (clone_flags & CLONE_SETTLS)
 			childregs->tp = tls;
 		childregs->a0 = 0; /* Return value of fork() */
-		p->thread.ra = (unsigned long)ret_from_fork;
+		p->thread.s[0] = 0;
 	}
+	p->thread.ra = (unsigned long)ret_from_fork;
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
 	return 0;
 }
-- 
2.37.2

