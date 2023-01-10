Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0419F663F62
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjAJLmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjAJLl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:41:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D734880D;
        Tue, 10 Jan 2023 03:41:56 -0800 (PST)
Date:   Tue, 10 Jan 2023 11:41:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673350914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sedPqbI5HVM+u7FgQ4xK9nbtiPEU0rs7b5ZXfBwhtog=;
        b=xYVZTiT4f6PqGLPqqrejnLR1jfecWsp7VncqysTjefAbkoAIpD3sQt7Ro6WcoFroALzVKx
        0TFbHJ96uMDEZ0pPwJnVg/9Sg5ZM/6UrBC7Py52YzXbZ6qO37NJAlJENh2H7IgSBKJ85YF
        zDaIyqpnG5j0No+rc7xj7EezJum122IauXOsOHIL8AFFB94BCYUac4t2qG+Vkhjh4RUqZv
        hwOBmjEB+8beFu7jTV1CdbgH7bbXklnVfaGxMQpWC1v+G0ZPQtidxP9JHyZhoD4WlJBKsp
        X5/oQEqTQSYRwOxoWHk8SYogdfmt84oOr/b8M1XFYDrEVAaEDFEpuBXAk6ogaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673350914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sedPqbI5HVM+u7FgQ4xK9nbtiPEU0rs7b5ZXfBwhtog=;
        b=xHhtfhY+j8PnZMXkT9/nKQk9d/89mfEwBVGCKUDJgCEczh9T84SEgYGxBUL6TA9oWE5Sg6
        WqOi9nY3BUVY3mBA==
From:   "tip-bot2 for Zeng Heng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
Cc:     Zeng Heng <zengheng4@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230110102745.2514694-1-zengheng4@huawei.com>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
MIME-Version: 1.0
Message-ID: <167335091340.4906.11748242170478099845.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     f919e902ac2371ec46b5582a42c50544dcb097f6
Gitweb:        https://git.kernel.org/tip/f919e902ac2371ec46b5582a42c50544dcb097f6
Author:        Zeng Heng <zengheng4@huawei.com>
AuthorDate:    Tue, 10 Jan 2023 18:27:45 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Jan 2023 11:56:55 +01:00

x86/boot/compressed: Register dummy NMI handler in EFI boot loader, to avoid kdump crashes

If kdump is enabled, when using mce_inject to inject errors, EFI
boot loader would decompressed & load second kernel for saving
vmcore file.

For normal errors that is fine. However, in MCEs cases, the panic
CPU that firstly enters into mce_panic(), is running within nmi
interrupt context, and the processor blocks delivery of subsequent
NMIs until the next execution of the IRET instruction.

When the panic CPU takes long time in the panic processing route,
and causes the watchdog timeout, at this moment, the processor
already receives NMI interrupt in the background.

In the following processure, panic CPU would run into EFI loader
and raise page fault exception (like visiting `vidmem` variable
when attempts to call debug_putstr()), the CPU would execute IRET
instruction when exits from page fault handler.

But the loader never registers handler for NMI vector in IDT,
lack of vector handler would cause reboot, which interrupts
kdump processure and fails to save vmcore file.

Here is steps to reproduce the above issue (Have a certain probability):

	1. # cat uncorrected
	CPU 1 BANK 4
	STATUS uncorrected 0xc0
	MCGSTATUS  EIPV MCIP
	ADDR 0x1234
	RIP 0xdeadbabe
	RAISINGCPU 0
	MCGCAP SER CMCI TES 0x6
	2. # modprobe mce_inject
	3. # mce-inject uncorrected

For increasing probability of reproduction of this issue, there is two ways of
modification to select:

  1. modify the threshold value of watchdog;
  2. add delays before panic() in mce_panic() and modify PANIC_TIMEOUT macro;

Fixes: ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230110102745.2514694-1-zengheng4@huawei.com
---
 arch/x86/boot/compressed/ident_map_64.c    | 5 +++++
 arch/x86/boot/compressed/idt_64.c          | 1 +
 arch/x86/boot/compressed/idt_handlers_64.S | 1 +
 arch/x86/boot/compressed/misc.h            | 1 +
 4 files changed, 8 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index d4a314c..6893127 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -379,3 +379,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 */
 	kernel_add_identity_map(address, end);
 }
+
+void do_boot_nmi_fault(struct pt_regs *regs, unsigned long error_code)
+{
+	/* ignore */
+}
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 6debb81..b169c97 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -60,6 +60,7 @@ void load_stage2_idt(void)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
+	set_idt_entry(X86_TRAP_NMI, boot_nmi_fault);
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
index 22890e1..2aef8e1 100644
--- a/arch/x86/boot/compressed/idt_handlers_64.S
+++ b/arch/x86/boot/compressed/idt_handlers_64.S
@@ -69,6 +69,7 @@ SYM_FUNC_END(\name)
 	.text
 	.code64
 
+EXCEPTION_HANDLER	boot_nmi_fault do_boot_nmi_fault error_code=0
 EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 62208ec..d89d3f8 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -187,6 +187,7 @@ static inline void cleanup_exception_handling(void) { }
 #endif
 
 /* IDT Entry Points */
+void boot_nmi_fault(void);
 void boot_page_fault(void);
 void boot_stage1_vc(void);
 void boot_stage2_vc(void);
