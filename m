Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9A6DFDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDLSph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDLSpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:45:23 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E459C5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:15 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i15-20020a9d610f000000b006a11f365d13so5253276otj.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325115; x=1683917115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WxAOYQvB1/+zLeJWbAjVCxh3aoYklNTPW85OIPHgas=;
        b=OVQrLlD7CUCucbyt526lxhXpqj2jb03tYwsa6VKmMzp3SZ5Bv7OeZoh2U203GgurGr
         j4waufjf8DqD6BSm7Ia54o3w7PwG+R2chyOZq77K2DOTJ/ZTXUFiDBP05+BtIPwZVvPv
         IAq+qt1pN/Pwl0EQ29MzYFeX5KYJ1AQij3C35EATOFmfvzjccaGwqq38NareXFCRh1mM
         sLsUbwLllhT0QVPfbvBBY/O8CU9WOmBGzAf+dSt6N5aRkArRXlPUUw3DdMq+mqZMb+pD
         ZCGAg+QuImm0QsyVqj+TLXqr/8CpTte3db14IwhryHSfFV9pX9XXQhUfKv7ikkjOvhf0
         2cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325115; x=1683917115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WxAOYQvB1/+zLeJWbAjVCxh3aoYklNTPW85OIPHgas=;
        b=BgUjy0fB6vS1YyjrKc1tUMjzGV7qUE6GlHgGsmlt5a1RTVku++5+18gAhInOG6BqlH
         Zf/skzdgXnlZ5rrHAaNUX3MS1zflgJc/1hvS34c/8P49dVdwLMKEJkj3ZuHQ2/Cg/ERu
         KHrkHmKBOF/At30bFlh26V17FWC69tQOWXN68j95BvRYCU8JsissfoxGGpoW4ko63REh
         KBQWDvPsx2koG8XhQ7cq0EH9jbkvR2Bp3EXsCGmTYFZmk6N3SbpnpiloeydTPZOgMGsC
         b3ZWkL/UnF2HE1MGVf5oGY3AU3Wn7hTxaVwbam6UuMLScN04h7WU6YaZ1PJLUnEoXUAT
         xBLA==
X-Gm-Message-State: AAQBX9f5ihHXFkJ62EwRundA3can+zkASKj4wX49acdMIsdHEXSG4wQE
        pOy835j+oxLNqh/gya8g2jHw09d+vw==
X-Google-Smtp-Source: AKy350ZGEux9XRh8Jcdm6CsOeqmso+rvsJ/sIkk3iShWOxI3u06/OaHS+jQFdQ1Kxvtq5qVyFY0bjQ==
X-Received: by 2002:a05:6830:12cd:b0:6a3:3655:b8a7 with SMTP id a13-20020a05683012cd00b006a33655b8a7mr75639otq.14.1681325115058;
        Wed, 12 Apr 2023 11:45:15 -0700 (PDT)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id w24-20020a9d77d8000000b00690e990e61asm6706020otl.14.2023.04.12.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:45:14 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 6/6] x86/boot: Use copied boot data in sme_enable()
Date:   Wed, 12 Apr 2023 14:45:02 -0400
Message-Id: <20230412184502.145289-7-brgerst@gmail.com>
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

Use the copied version instead of the original real mode data.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/mem_encrypt.h |  4 +--
 arch/x86/kernel/head_64.S          |  8 +-----
 arch/x86/mm/mem_encrypt_identity.c | 42 ++++++++++++++++--------------
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index b7126701574c..74f094eb88a6 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -40,7 +40,7 @@ void __init sme_early_init(void);
 void __init sev_setup_arch(void);
 
 void __init sme_encrypt_kernel(struct boot_params *bp);
-void __init sme_enable(struct boot_params *bp);
+void __init sme_enable(void);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
@@ -70,7 +70,7 @@ static inline void __init sme_early_init(void) { }
 static inline void __init sev_setup_arch(void) { }
 
 static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
-static inline void __init sme_enable(struct boot_params *bp) { }
+static inline void __init sme_enable(void) { }
 
 static inline void sev_es_init_vc_handling(void) { }
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c7b2ef379f42..c6ea37712921 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -72,14 +72,11 @@ SYM_CODE_START_NOALIGN(startup_64)
 	wrmsr
 
 	leaq	_text(%rip), %rdi
-	pushq	%rsi
+	/* RSI contains address of real_mode_data */
 	call	copy_bootdata
-	popq	%rsi
 
 	leaq	_text(%rip), %rdi
-	pushq	%rsi
 	call	startup_64_setup_env
-	popq	%rsi
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
@@ -88,10 +85,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * which needs to be done before any CPUID instructions are executed in
 	 * subsequent code.
 	 */
-	movq	%rsi, %rdi
-	pushq	%rsi
 	call	sme_enable
-	popq	%rsi
 #endif
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index c6efcf559d88..e75e4f5a8a71 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -502,8 +502,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __init sme_enable(struct boot_params *bp)
+void __init sme_enable(void)
 {
+	struct boot_params *bp;
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
@@ -513,6 +514,27 @@ void __init sme_enable(struct boot_params *bp)
 	bool snp;
 	u64 msr;
 
+	/*
+	 * Fixups have not been applied to phys_base yet and we're running
+	 * identity mapped, so we must obtain the address to global data
+	 * using rip-relative addressing.
+	 */
+	asm("lea sme_cmdline_arg(%%rip), %0"
+	    : "=r" (cmdline_arg)
+	    : "p" (sme_cmdline_arg));
+	asm("lea sme_cmdline_on(%%rip), %0"
+	    : "=r" (cmdline_on)
+	    : "p" (sme_cmdline_on));
+	asm("lea sme_cmdline_off(%%rip), %0"
+	    : "=r" (cmdline_off)
+	    : "p" (sme_cmdline_off));
+	asm("lea boot_params(%%rip), %0"
+	    : "=r" (bp)
+	    : "m" (boot_params));
+	asm("lea boot_command_line(%%rip), %0"
+	    : "=r" (cmdline_ptr)
+	    : "p" (boot_command_line));
+
 	snp = snp_init(bp);
 
 	/* Check for the SME/SEV support leaf */
@@ -577,29 +599,11 @@ void __init sme_enable(struct boot_params *bp)
 		goto out;
 	}
 
-	/*
-	 * Fixups have not been applied to phys_base yet and we're running
-	 * identity mapped, so we must obtain the address to the SME command
-	 * line argument data using rip-relative addressing.
-	 */
-	asm ("lea sme_cmdline_arg(%%rip), %0"
-	     : "=r" (cmdline_arg)
-	     : "p" (sme_cmdline_arg));
-	asm ("lea sme_cmdline_on(%%rip), %0"
-	     : "=r" (cmdline_on)
-	     : "p" (sme_cmdline_on));
-	asm ("lea sme_cmdline_off(%%rip), %0"
-	     : "=r" (cmdline_off)
-	     : "p" (sme_cmdline_off));
-
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
 		active_by_default = true;
 	else
 		active_by_default = false;
 
-	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
-				     ((u64)bp->ext_cmd_line_ptr << 32));
-
 	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
 		return;
 
-- 
2.39.2

