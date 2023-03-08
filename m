Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A46B0D28
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjCHPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCHPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:43:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D32ACB079
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:42:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 21D5621A08;
        Wed,  8 Mar 2023 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678290132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=D8WxbyyO7u7WlwK3Tkf3hyugox0XtO5Ax82nB45NCXY=;
        b=MJKaCwXB+yWdUWhuvNgryG50DFmtXND/cJoW8xqPZPnuASLnruaWUO+fLj+yTNFv4QTBf+
        3bH5FdlVfC0Ajn3k+vaudJdeKgSFh2AO/Hd1d169yEdjghuHMlBT59Jrr41FltRBrZPY4x
        udnDseijvKAzLFGF6NIQvdugtQKOpE0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE9C91348D;
        Wed,  8 Mar 2023 15:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wjkaLdOsCGTOGgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 08 Mar 2023 15:42:11 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/paravirt: convert simple paravirt functions to asm
Date:   Wed,  8 Mar 2023 16:42:10 +0100
Message-Id: <20230308154210.18454-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All functions referenced via __PV_IS_CALLEE_SAVE() need to be assembler
functions, as those functions calls are hidden from gcc. In case the
kernel is compiled with "-fzero-call-used-regs" the compiler will
clobber caller-saved registers at the end of C functions, which will
result in unexpectedly zeroed registers at the call site of the
related paravirt functions.

Replace the C functions with DEFINE_PARAVIRT_ASM() constructs using
the same instructions as the related paravirt calls in the
PVOP_ALT_[V]CALLEE*() macros.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h |  8 +++++++-
 arch/x86/kernel/paravirt.c            | 27 ++++++---------------------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8c1da419260f..49f5c6955229 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -562,8 +562,14 @@ void paravirt_flush_lazy_mmu(void);
 
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
index 42e182868873..d25ac4b08c41 100644
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
+DEFINE_PARAVIRT_ASM(pv_native_save_fl, "pushf; pop %rax", .text);
+DEFINE_PARAVIRT_ASM(pv_native_irq_disable, "cli", .text);
+DEFINE_PARAVIRT_ASM(pv_native_irq_enable, "sti", .text);
+DEFINE_PARAVIRT_ASM(pv_native_read_cr2, "mov %cr2, %rax", .text);
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
-- 
2.35.3

