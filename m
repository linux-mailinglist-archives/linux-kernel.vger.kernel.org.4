Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E32663D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjAJKJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjAJKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:09:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29574FCC5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:09:28 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nrmhm0VQCznTXJ;
        Tue, 10 Jan 2023 18:07:52 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 18:09:25 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <michael.roth@amd.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <kirill.shutemov@linux.intel.com>, <jroedel@suse.de>,
        <keescook@chromium.org>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <brijesh.singh@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <liwei391@huawei.com>
Subject: [PATCH] x86/boot/compressed: Register NMI handler in EFI boot loader
Date:   Tue, 10 Jan 2023 18:27:45 +0800
Message-ID: <20230110102745.2514694-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kdump is enabled, when using mce_inject to inject errors, EFI
boot loader would decompressed & load second kernel for saving
vmcore file.

For normal errors that is fine. However, in MCEs cases, the panic
cpu that firstly enters into mce_panic(), is running within nmi
interrupt context, and the processor blocks delivery of subsequent
NMIs until the next execution of the IRET instruction.

When the panic cpu takes long time in the panic processing route,
and causes the watchdog timeout, at this moment, the processor
already receives NMI interrupt in the background.

In the following processure, panic cpu would run into EFI loader
and raise page fault exception (like visiting `vidmem` variable
when attempts to call debug_putstr()), the cpu would execute IRET
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

For increasing probability of issue reproduce, there is two ways of
modification to select:
1. modify the threshold value of watchdog;
2. add delays before panic() in mce_panic() and modify PANIC_TIMEOUT macro;

Fixes: ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 arch/x86/boot/compressed/ident_map_64.c    | 5 +++++
 arch/x86/boot/compressed/idt_64.c          | 1 +
 arch/x86/boot/compressed/idt_handlers_64.S | 1 +
 arch/x86/boot/compressed/misc.h            | 1 +
 4 files changed, 8 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index d4a314cc50d6..6893127f673f 100644
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
index 6debb816e83d..b169c9728d52 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -60,6 +60,7 @@ void load_stage2_idt(void)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
+	set_idt_entry(X86_TRAP_NMI, boot_nmi_fault);
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
index 22890e199f5b..2aef8e1b515b 100644
--- a/arch/x86/boot/compressed/idt_handlers_64.S
+++ b/arch/x86/boot/compressed/idt_handlers_64.S
@@ -69,6 +69,7 @@ SYM_FUNC_END(\name)
 	.text
 	.code64
 
+EXCEPTION_HANDLER	boot_nmi_fault do_boot_nmi_fault error_code=0
 EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 62208ec04ca4..d89d3f8417f6 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -187,6 +187,7 @@ static inline void cleanup_exception_handling(void) { }
 #endif
 
 /* IDT Entry Points */
+void boot_nmi_fault(void);
 void boot_page_fault(void);
 void boot_stage1_vc(void);
 void boot_stage2_vc(void);
-- 
2.25.1

