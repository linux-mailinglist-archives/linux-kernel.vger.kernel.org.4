Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4986C33D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCUOOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCUOOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:14:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B6FCC25;
        Tue, 21 Mar 2023 07:14:17 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:14:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679408056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCBGRWtQKxfchyDAQdVLTwugq1Q6+YeRk5nNyr2Nfg4=;
        b=OWp+G8ZHaKkNl9tb4Mtdwup/lRmr7Rs8MGlRj5YF36ZgBLHTeBcjSWs7YJhcaqxneyU3lB
        HF54XTP6LV1/vpeOXYOBRZXjsKajn9uqMtV+KntlGU/iouDHC5o3DfbnlhpUFsoyHWsqKD
        OJIeWtHR2nXsyltBzTFmnkfPawSnLpWKG8pZXhlQDAEhyRWGZi9ZG6gjpb6zyL0tJ9mAwN
        HJUHdyKQgcbZNHiIXMnONtpu+9kqSHxgGqe/4nUBrMATl1vfc6OID+NIS+yseNt0jYi8k4
        UyGWx3O+24TF2BIGe5xuGslYVC4lF2dg1S7aBzsILz1nyglFwE/64iGCQEccOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679408056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCBGRWtQKxfchyDAQdVLTwugq1Q6+YeRk5nNyr2Nfg4=;
        b=f9tOXY6Mg0bz8YeObZsDt0k3iLoDPOc9A+EKWhKzlDmIwhjiIfM09QG+P6sABpXEaeA92U
        miP3yY7FpB40xNAg==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/smpboot: Remove early_gdt_descr on 64-bit
Cc:     Brian Gerst <brgerst@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230316222109.1940300-8-usama.arif@bytedance.com>
References: <20230316222109.1940300-8-usama.arif@bytedance.com>
MIME-Version: 1.0
Message-ID: <167940805578.5837.1678729048718748115.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     c253b64020c7a7c7a1f6adf8922456614be0f665
Gitweb:        https://git.kernel.org/tip/c253b64020c7a7c7a1f6adf8922456614be0f665
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 16 Mar 2023 22:21:04 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 21 Mar 2023 13:35:53 +01:00

x86/smpboot: Remove early_gdt_descr on 64-bit

Build the GDT descriptor on the stack instead.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Usama Arif <usama.arif@bytedance.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lore.kernel.org/r/20230316222109.1940300-8-usama.arif@bytedance.com

---
 arch/x86/kernel/acpi/sleep.c |  2 --
 arch/x86/kernel/head_64.S    | 11 ++++++-----
 arch/x86/kernel/smpboot.c    |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 1b4c43d..de89bb4 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -127,8 +127,6 @@ int x86_acpi_suspend_lowlevel(void)
 	 * value is in the actual %rsp register.
 	 */
 	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
-	early_gdt_descr.address =
-			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
 	initial_gs = per_cpu_offset(smp_processor_id());
 	smpboot_control = smp_processor_id();
 #endif
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index cc1b145..a5b46c2 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -265,7 +265,12 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * addresses where we're currently running on. We have to do that here
 	 * because in 32bit we couldn't load a 64bit linear address.
 	 */
-	lgdt	early_gdt_descr(%rip)
+	subq	$16, %rsp
+	movw	$(GDT_SIZE-1), (%rsp)
+	leaq	gdt_page(%rdx), %rax
+	movq	%rax, 2(%rsp)
+	lgdt	(%rsp)
+	addq	$16, %rsp
 
 	/* set up data segments */
 	xorl %eax,%eax
@@ -667,10 +672,6 @@ SYM_DATA_END(level1_fixmap_pgt)
 	.data
 	.align 16
 
-SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
-SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
-
-	.align 16
 SYM_DATA(smpboot_control,		.long 0)
 
 	.align 16
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a1531cc..94e6c54 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1086,10 +1086,10 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		start_ip = real_mode_header->trampoline_start64;
 #endif
 	idle->thread.sp = (unsigned long)task_pt_regs(idle);
-	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 	initial_code = (unsigned long)start_secondary;
 
 	if (IS_ENABLED(CONFIG_X86_32)) {
+		early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 		initial_stack  = idle->thread.sp;
 	} else {
 		smpboot_control = cpu;
