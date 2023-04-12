Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7D6DFDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjDLSpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjDLSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:45:18 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961865AA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:14 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1878a0bf68fso324203fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325113; x=1683917113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLfUCOkvkjyXKASrYl3qRN6UMeyF56v/rVBV6eIg7OU=;
        b=LXig5OVv0EMvil57sXSWTi76UfLZM8wn4OvA0mUUP/vvbDAUhBcNkNdWeurhAjohvM
         E2dbpblNPTfzJ6dpDqwo5QxROXDPTbmvGSGbP+Z4ViCRYMLdSTTsecKHqacyy/9nkDnL
         b77Jv6NAA4/7OOi++dLGOY/TUiEsGjaz05RbPU0N+JB0bk4n+PDgrEdIgbf1ulo7y4o1
         2XKSZc/QsGw9ERkVML8ci/wFpG9NcyuSRZaTr13GcWkn6gwX7r1epZqfro81GZIWeXdE
         BfysPNlu1gSuszBwxA/3C7duFWmHpOPbqm+owmpLTVdvUJy9CN3YqA0t5IrIHLPuOv5x
         ZpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325113; x=1683917113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLfUCOkvkjyXKASrYl3qRN6UMeyF56v/rVBV6eIg7OU=;
        b=fdslBnOps2OqaAWkkc/n5sSy0XM6SERr8/aVZe/Zm5TgHnjW3aZiGl0McwgV3M+b/b
         a5qbU3ACC7jv4dLG8Dt0x8jTDPuDu9Viuumkho+d4MwX0WVWvEEWuLdO9oSYTZZBmQRC
         7+KylErJEagAmOIV2EoWj+2DdADsV1zu3pRMoLbKI5wKzvHbymXft6pzy4RQekDbXPqI
         Bt+E1ATk2qC+amoXkNDWD3ghOCnh6nGqMMLdX1TOrV7siOvzlhPX0NQTtXxwYLj1RZfU
         6/1o5fPZLUElV5djuqxonxafn2iUmsgkQZi55+U0KZoYnGbw0ziJYPWWbXY2K5Gogdc8
         6Q7Q==
X-Gm-Message-State: AAQBX9dlfHtw21cb2c+8rpvoozZ4MCUPjaPDHuEqwvM7XqKLvUHaOAww
        flso4bjerGcDBjJ7+UvUt+mp0CA5Yw==
X-Google-Smtp-Source: AKy350b1DWOuoEhyCT/n3PsSepFtS53HZr1WIVAz6A4p6EVfGFc9QX8S0VATs2m6mFgswiakpXtoww==
X-Received: by 2002:a05:6870:6488:b0:184:442a:96d2 with SMTP id cz8-20020a056870648800b00184442a96d2mr4539287oab.54.1681325113282;
        Wed, 12 Apr 2023 11:45:13 -0700 (PDT)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id w24-20020a9d77d8000000b00690e990e61asm6706020otl.14.2023.04.12.11.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:45:13 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 4/6] x86/boot: Move copy_bootdata() to very early boot.
Date:   Wed, 12 Apr 2023 14:45:00 -0400
Message-Id: <20230412184502.145289-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412184502.145289-1-brgerst@gmail.com>
References: <20230412184502.145289-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the boot data very early in the boot process.  Since at this point
the kernel is running on identity-mapped pagetables, pointers to global
data need to be adjusted.

By copying the data early before memory encryption is enabled, it is no
longer necessary to remap the real mode data as unencrypted.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/setup.h  |  5 ++-
 arch/x86/kernel/head64.c      | 29 +++++------------
 arch/x86/kernel/head_64.S     | 20 ++++--------
 arch/x86/kernel/setup.c       |  2 +-
 arch/x86/mm/mem_encrypt_amd.c | 61 -----------------------------------
 5 files changed, 19 insertions(+), 98 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index fd409b7dda74..47eac5d877a8 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -128,7 +128,10 @@ void clear_bss(void);
 asmlinkage void __init i386_start_kernel(void);
 
 #else
-asmlinkage void __init x86_64_start_kernel(char *real_mode);
+
+asmlinkage void __init copy_bootdata(unsigned long physbase,
+				     struct boot_params *real_mode_data);
+asmlinkage void __init x86_64_start_kernel(void);
 asmlinkage void __init x86_64_start_reservations(void);
 
 #endif /* __i386__ */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 08ea521041bf..9be8ce41d021 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -443,31 +443,20 @@ static char *get_cmd_line_ptr(struct boot_params *bp)
 	return (char *)cmd_line_ptr;
 }
 
-static void __init copy_bootdata(char *real_mode_data)
+asmlinkage __visible void __init copy_bootdata(unsigned long physbase,
+					       struct boot_params *real_mode_data)
 {
 	char *cmd_line_ptr;
+	struct boot_params *bp = fixup_pointer(&boot_params, physbase);
+	char *command_line = fixup_pointer(&boot_command_line, physbase);
 
-	/*
-	 * If SME is active, this will create decrypted mappings of the
-	 * boot data in advance of the copy operations.
-	 */
-	sme_map_bootdata(real_mode_data);
-
-	memcpy(&boot_params, real_mode_data, sizeof(boot_params));
-	cmd_line_ptr = get_cmd_line_ptr(&boot_params);
+	memcpy(bp, real_mode_data, sizeof(boot_params));
+	cmd_line_ptr = get_cmd_line_ptr(bp);
 	if (cmd_line_ptr)
-		memcpy(boot_command_line, __va(cmd_line_ptr), COMMAND_LINE_SIZE);
-
-	/*
-	 * The old boot data is no longer needed and won't be reserved,
-	 * freeing up that memory for use by the system. If SME is active,
-	 * we need to remove the mappings that were created so that the
-	 * memory doesn't remain mapped as decrypted.
-	 */
-	sme_unmap_bootdata(real_mode_data);
+		memcpy(command_line, cmd_line_ptr, COMMAND_LINE_SIZE);
 }
 
-asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
+asmlinkage __visible void __init x86_64_start_kernel(void)
 {
 	/*
 	 * Build-time sanity checks on the kernel image and module
@@ -520,8 +509,6 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	/* Needed before cc_platform_has() can be used for TDX */
 	tdx_early_init();
 
-	copy_bootdata(__va(real_mode_data));
-
 	/*
 	 * Load microcode early on BSP.
 	 */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a5df3e994f04..83fb0dc97ba5 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -64,8 +64,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
-	leaq	_text(%rip), %rdi
-
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
 	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
@@ -73,6 +71,12 @@ SYM_CODE_START_NOALIGN(startup_64)
 	shrq	$32,  %rdx
 	wrmsr
 
+	leaq	_text(%rip), %rdi
+	pushq	%rsi
+	call	copy_bootdata
+	popq	%rsi
+
+	leaq	_text(%rip), %rdi
 	pushq	%rsi
 	call	startup_64_setup_env
 	popq	%rsi
@@ -125,8 +129,6 @@ SYM_CODE_START(secondary_startup_64)
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
 	 * and someone has loaded a mapped page table.
 	 *
-	 * %rsi holds a physical pointer to real_mode_data.
-	 *
 	 * We come here either from startup_64 (using physical addresses)
 	 * or from trampoline.S (using virtual addresses).
 	 *
@@ -197,13 +199,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * hypervisor could lie about the C-bit position to perform a ROP
 	 * attack on the guest by writing to the unencrypted stack and wait for
 	 * the next RET instruction.
-	 * %rsi carries pointer to realmode data and is callee-clobbered. Save
-	 * and restore it.
 	 */
-	pushq	%rsi
 	movq	%rax, %rdi
 	call	sev_verify_cbit
-	popq	%rsi
 
 	/*
 	 * Switch to new page-table
@@ -294,9 +292,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	wrmsr
 
 	/* Setup and Load IDT */
-	pushq	%rsi
 	call	early_setup_idt
-	popq	%rsi
 
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
@@ -332,10 +328,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	pushq $0
 	popfq
 
-	/* rsi is pointer to real mode structure with interesting info.
-	   pass it to C */
-	movq	%rsi, %rdi
-
 .Ljump_to_C_code:
 	/*
 	 * Jump to run C code and to be on a real kernel address.
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 16babff771bd..256262cb29c0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -74,7 +74,7 @@ RESERVE_BRK(dmi_alloc, 65536);
 unsigned long _brk_start = (unsigned long)__brk_base;
 unsigned long _brk_end   = (unsigned long)__brk_base;
 
-struct boot_params boot_params;
+struct boot_params boot_params __section(".data");
 
 /*
  * These are the four main kernel memory regions, we put them into
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index e0b51c09109f..120e9c09c04b 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -154,67 +154,6 @@ void __init sme_early_decrypt(resource_size_t paddr, unsigned long size)
 	__sme_early_enc_dec(paddr, size, false);
 }
 
-static void __init __sme_early_map_unmap_mem(void *vaddr, unsigned long size,
-					     bool map)
-{
-	unsigned long paddr = (unsigned long)vaddr - __PAGE_OFFSET;
-	pmdval_t pmd_flags, pmd;
-
-	/* Use early_pmd_flags but remove the encryption mask */
-	pmd_flags = __sme_clr(early_pmd_flags);
-
-	do {
-		pmd = map ? (paddr & PMD_MASK) + pmd_flags : 0;
-		__early_make_pgtable((unsigned long)vaddr, pmd);
-
-		vaddr += PMD_SIZE;
-		paddr += PMD_SIZE;
-		size = (size <= PMD_SIZE) ? 0 : size - PMD_SIZE;
-	} while (size);
-
-	flush_tlb_local();
-}
-
-void __init sme_unmap_bootdata(char *real_mode_data)
-{
-	struct boot_params *boot_data;
-	unsigned long cmdline_paddr;
-
-	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
-		return;
-
-	/* Get the command line address before unmapping the real_mode_data */
-	boot_data = (struct boot_params *)real_mode_data;
-	cmdline_paddr = boot_data->hdr.cmd_line_ptr | ((u64)boot_data->ext_cmd_line_ptr << 32);
-
-	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), false);
-
-	if (!cmdline_paddr)
-		return;
-
-	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, false);
-}
-
-void __init sme_map_bootdata(char *real_mode_data)
-{
-	struct boot_params *boot_data;
-	unsigned long cmdline_paddr;
-
-	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
-		return;
-
-	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
-
-	/* Get the command line address after mapping the real_mode_data */
-	boot_data = (struct boot_params *)real_mode_data;
-	cmdline_paddr = boot_data->hdr.cmd_line_ptr | ((u64)boot_data->ext_cmd_line_ptr << 32);
-
-	if (!cmdline_paddr)
-		return;
-
-	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
-}
-
 void __init sev_setup_arch(void)
 {
 	phys_addr_t total_mem = memblock_phys_mem_size();
-- 
2.39.2

