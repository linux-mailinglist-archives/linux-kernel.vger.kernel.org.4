Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F962A17D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKOSnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKOSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:43:52 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5527DCC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:43:51 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so17264247fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=riYy6P33ZZy18g0NCwmRmQ/TR/Zp7ho4V4Ku/hEbkcQ=;
        b=R7Q/2Zu9e/nFjheSx0I4A2sOqiikywnNTYMF5ic7CCk4ahR7vX+mAKvcnZzZ7IIAro
         yZBQmu6rZz3moR2dDHX5+HL+yQy9UOyv/oDcVw6Y/UnTFEWiEKkPzFnAJ4EvNRTF9A7v
         a3dnnVN+jUI2/KYIlpVrAcwwcjnOcmcJJ2xQHOUMBCxuwM+CSBJU9klAfhw3fKS9GDOr
         VTFKPrhtZDEUV0W+e9bvgJOm66EyeY6k6bIFzib8KbEJQMdISKPOcECByot9yDtYGFEF
         4/5eqEaaGVSzWCWaez2RHBliL+DbLUxwtpjWHbEwyRsVndfTkgnWFynhJi2Gzk6uqKyx
         m9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riYy6P33ZZy18g0NCwmRmQ/TR/Zp7ho4V4Ku/hEbkcQ=;
        b=L8gQ3y57zUxX+kGUm3/ryrvF3tfbwopeU9XZ+vzoyq8JXkeC8ukMquzcuaGKvWUHti
         V+98prwGrmx5iRoS6IZtpBaA5AKZ8tTyqggO4+OSYwg/z7beooJdodROswRa6j4lDOUk
         TodhOZqOuDYxYeEgPBJmRf9dJoLDzx8gk5NdJSoJXGmnZLhT1s+0chpe7MBPcVMQarcR
         SIaxNa14XhgKvmcMO3iZGijv1VE2/SCciGbDYIXpD9l+ilgzI9udgr143g8wbHgj915o
         IRg7ewAjn8dKHu8W8UjBdtiIfIsUmarCDBIvaV7khrimXmeL+FgTD81OyyNbjoqLtRcV
         1aYg==
X-Gm-Message-State: ANoB5pmAtfYH/IiAgwqgNmpw6edejDc6RvrxPrkvTNKDf1hbIwXpJaXg
        +mghp1TYGim5hxfpbSByzOk7XUPOfA==
X-Google-Smtp-Source: AA0mqf7C9BkMLbpW/a9HCYoojJ2ewAVV1PGkY0mk7T1POa+dzgBeQ4F728L3Q6BFhuqtEtw8PBKtxg==
X-Received: by 2002:a05:6870:f22a:b0:136:4744:b97f with SMTP id t42-20020a056870f22a00b001364744b97fmr1907501oao.297.1668537830937;
        Tue, 15 Nov 2022 10:43:50 -0800 (PST)
Received: from citadel.. (075-134-122-108.res.spectrum.com. [75.134.122.108])
        by smtp.gmail.com with ESMTPSA id q25-20020a05683022d900b006619f38a686sm5663769otc.56.2022.11.15.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:43:50 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86-32: Remove setup_once
Date:   Tue, 15 Nov 2022 13:43:28 -0500
Message-Id: <20221115184328.70874-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.38.1
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

After the removal of the stack canary segment setup code, this function
does nothing.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/head_32.S | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 9b7acc9c7874..67c8ed99144b 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -260,16 +260,6 @@ SYM_FUNC_START(startup_32_smp)
 	/* Shift the stack pointer to a virtual address */
 	addl $__PAGE_OFFSET, %esp
 
-/*
- * start system 32-bit setup. We need to re-do some of the things done
- * in 16-bit mode for the "real" operations.
- */
-	movl setup_once_ref,%eax
-	andl %eax,%eax
-	jz 1f				# Did we do this already?
-	call *%eax
-1:
-
 /*
  * Check if it is 486
  */
@@ -331,18 +321,7 @@ SYM_FUNC_END(startup_32_smp)
 
 #include "verify_cpu.S"
 
-/*
- *  setup_once
- *
- *  The setup work we only want to run on the BSP.
- *
- *  Warning: %esi is live across this function.
- */
 __INIT
-setup_once:
-	andl $0,setup_once_ref	/* Once is enough, thanks */
-	RET
-
 SYM_FUNC_START(early_idt_handler_array)
 	# 36(%esp) %eflags
 	# 32(%esp) %cs
@@ -458,7 +437,6 @@ SYM_DATA(early_recursion_flag, .long 0)
 __REFDATA
 	.align 4
 SYM_DATA(initial_code,		.long i386_start_kernel)
-SYM_DATA(setup_once_ref,	.long setup_once)
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 #define	PGD_ALIGN	(2 * PAGE_SIZE)
-- 
2.38.1

