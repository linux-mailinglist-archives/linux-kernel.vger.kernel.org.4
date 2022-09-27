Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664DE5EB967
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiI0E7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiI0E7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:59:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1756B5FA5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A435A612E7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D03C433D6;
        Tue, 27 Sep 2022 04:59:28 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Jun Yi <yijun@loongson.cn>
Subject: [PATCH] LoongArch: Fix and cleanup csr_era handling in do_ri()
Date:   Tue, 27 Sep 2022 12:58:20 +0800
Message-Id: <20220927045820.2770062-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't emulate reserved instructions and just send a signal to the
current process now. So we don't need to call compute_return_era() to
add 4 (point to the next instruction) to csr_era in pt_regs. RA/ERA's
backup/restore is cleaned up as well.

Signed-off-by: Jun Yi <yijun@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/traps.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index aa1c95aaf595..5010e95cef84 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -461,11 +461,9 @@ asmlinkage void noinstr do_watch(struct pt_regs *regs)
 
 asmlinkage void noinstr do_ri(struct pt_regs *regs)
 {
-	int status = -1;
+	int status = SIGILL;
 	unsigned int opcode = 0;
 	unsigned int __user *era = (unsigned int __user *)exception_era(regs);
-	unsigned long old_era = regs->csr_era;
-	unsigned long old_ra = regs->regs[1];
 	irqentry_state_t state = irqentry_enter(regs);
 
 	local_irq_enable();
@@ -477,21 +475,12 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
 
 	die_if_kernel("Reserved instruction in kernel code", regs);
 
-	compute_return_era(regs);
-
 	if (unlikely(get_user(opcode, era) < 0)) {
 		status = SIGSEGV;
 		current->thread.error_code = 1;
 	}
 
-	if (status < 0)
-		status = SIGILL;
-
-	if (unlikely(status > 0)) {
-		regs->csr_era = old_era;		/* Undo skip-over.  */
-		regs->regs[1] = old_ra;
-		force_sig(status);
-	}
+	force_sig(status);
 
 out:
 	local_irq_disable();
-- 
2.31.1

