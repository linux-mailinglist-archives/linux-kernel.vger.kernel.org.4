Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC5A6BF060
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCQSGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjCQSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:06:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98BEB1EEE;
        Fri, 17 Mar 2023 11:06:33 -0700 (PDT)
Date:   Fri, 17 Mar 2023 18:06:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679076391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WU4Z6qR1Wid4MUPWVdVJTi6oGBROhg9ZyyhyAzGoY8Y=;
        b=gm8wEn4+wab0hU/6AFDn4XJgXT/UGu5xWOoQqiZhCU0lNfi0rMWbpIKNJ8DGgbtFIasJva
        kmhFQxz4p9jHujYx8weTheOJ4Lh8HI1jnnocVo2E58Svg5ozlYHG2XQLvd8fOBs2UNHP4n
        pL7v0ZIGN1e6LO3nxiuqkI3mrdSbl3kn9tb4mpmbFoTTXlWRa7mM+A9+zQLR6RDiq29UqK
        i1Ce44vXBbcB5+UyA5a+JrcmQB3fK1HXNkbvF+d9J1STrVkfwgNjXdCRWnX1qHi1+mxEJM
        MFBD6GdcP/aKhdgfV/pR24eOLfsJyzIzulxQl5MO12pF3dWirWmTZdbbZ0M2Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679076391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WU4Z6qR1Wid4MUPWVdVJTi6oGBROhg9ZyyhyAzGoY8Y=;
        b=QIApr6GMTwm2JLsjiK5aHo62H3w4r6/CSvz6QOcuze9S0zJ66U7g03CjfcFHYV09AmhDop
        ze5CrBgQXHdYEiBQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Convert simple paravirt functions to asm
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230317063325.361-1-jgross@suse.com>
References: <20230317063325.361-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167907639052.5837.17998067253061901240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     11af36cb898123fd4e0034f1bc6550aedcc87800
Gitweb:        https://git.kernel.org/tip/11af36cb898123fd4e0034f1bc6550aedcc87800
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 17 Mar 2023 07:33:25 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 17 Mar 2023 13:29:47 +01:00

x86/paravirt: Convert simple paravirt functions to asm

All functions referenced via __PV_IS_CALLEE_SAVE() need to be assembler
functions, as those functions calls are hidden from the compiler.

In case the kernel is compiled with "-fzero-call-used-regs" the compiler
will clobber caller-saved registers at the end of C functions, which
will result in unexpectedly zeroed registers at the call site of the
related paravirt functions.

Replace the C functions with DEFINE_PARAVIRT_ASM() constructs using
the same instructions as the related paravirt calls in the
PVOP_ALT_[V]CALLEE*() macros. And since they're not C functions visible
to the compiler anymore, latter won't do the callee-clobbered zeroing
invoked by -fzero-call-used-regs and thus won't corrupt registers.

  [ bp: Extend commit message. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230317063325.361-1-jgross@suse.com
---
 arch/x86/include/asm/paravirt_types.h |  8 +++++++-
 arch/x86/kernel/paravirt.c            | 27 +++++---------------------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 71bf64b..4acbcdd 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -559,8 +559,14 @@ void paravirt_flush_lazy_mmu(void);
 
 void _paravirt_nop(void);
 void paravirt_BUG(void);
-u64 _paravirt_ident_64(u64);
 unsigned long paravirt_ret0(void);
+#ifdef CONFIG_PARAVIRT_XXL
+u64 _paravirt_ident_64(u64);
+unsigned long pv_native_save_fl(void);
+void pv_native_irq_disable(void);
+void pv_native_irq_enable(void);
+unsigned long pv_native_read_cr2(void);
+#endif
 
 #define paravirt_nop	((void *)_paravirt_nop)
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 0e68a31..ac10b46 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -64,11 +64,11 @@ static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
-/* identity function, which can be inlined */
-u64 notrace _paravirt_ident_64(u64 x)
-{
-	return x;
-}
+DEFINE_PARAVIRT_ASM(_paravirt_ident_64, "mov %rdi, %rax", .text);
+DEFINE_PARAVIRT_ASM(pv_native_save_fl, "pushf; pop %rax", .noinstr.text);
+DEFINE_PARAVIRT_ASM(pv_native_irq_disable, "cli", .noinstr.text);
+DEFINE_PARAVIRT_ASM(pv_native_irq_enable, "sti", .noinstr.text);
+DEFINE_PARAVIRT_ASM(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 #endif
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
@@ -197,11 +197,6 @@ void paravirt_end_context_switch(struct task_struct *next)
 		arch_enter_lazy_mmu_mode();
 }
 
-static noinstr unsigned long pv_native_read_cr2(void)
-{
-	return native_read_cr2();
-}
-
 static noinstr void pv_native_write_cr2(unsigned long val)
 {
 	native_write_cr2(val);
@@ -222,16 +217,6 @@ noinstr void pv_native_wbinvd(void)
 	native_wbinvd();
 }
 
-static noinstr void pv_native_irq_enable(void)
-{
-	native_irq_enable();
-}
-
-static noinstr void pv_native_irq_disable(void)
-{
-	native_irq_disable();
-}
-
 static noinstr void pv_native_safe_halt(void)
 {
 	native_safe_halt();
@@ -298,7 +283,7 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.end_context_switch		= paravirt_nop,
 
 	/* Irq ops. */
-	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
+	.irq.save_fl		= __PV_IS_CALLEE_SAVE(pv_native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
 	.irq.safe_halt		= pv_native_safe_halt,
