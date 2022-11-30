Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9C63CD74
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiK3Cfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiK3Cft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:35:49 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17EA13CD1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:35:47 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so581917pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK41owb8xQar3YPAMlOv6Q9IlVxICe86b2kCZ83CjmI=;
        b=NYaY1njFT+Iv04FROrsPA9asr8bF0H1T04E0ghH8zlytybXdGXaucom+/NQFSJL3iN
         efDS5zB46j0rOji8pcj485H1bPAwEnbMedmSqSEmf9B0wOaK9y7b1cF2ad77M3muEnbi
         qstWPWEJs/VJ5jCtWTtcb7YUXNolbQ28uZPsHenqV73ygMFTNij1XXA1rKcB0p91dDSg
         +bpgfhsHSzWV1Tyhw4e43BlxsTlU2cGT7GoXFBSE8FPrEOI9hkNdf7a2KEI+vkMrrO1l
         AJvx8bfKnp+cn/ARJvoFo0ELvjUsXydRIUgT9uh8J5GQOc3rLSUsST/k+m1AtfbnbM4a
         FzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK41owb8xQar3YPAMlOv6Q9IlVxICe86b2kCZ83CjmI=;
        b=VVImN6ohPGy4S+917QZsiO3P6oPr3/0CUnpuznIF7Uo568+vRrQy2xnkoK4xlMLyPm
         MkF8/x/vt61q50vdtNSjP5wDEOhsSpCDJPbsf1eayAFsxwrtluDd5zbOTU3rcoF3dnL5
         ccZnKY/kVvVSu/u48gyUcjtxbHBOsNlZwMAMUp/hoYa/2b6/rJ13Fsaj+BB57RaB/UiQ
         ej6PrI9k6T5VvEcP19Y+0RUF76yuHfAr2WBeH+8i2d5JwqNPUbdNKsU+GxCtnXKb3F8y
         ld/ysOq0Gi+dwZHOuhnX7Jlpva5ER7sEAn+xa9HvDiMMnnH5eQBcy3HUJLloEnMcsnBT
         du+Q==
X-Gm-Message-State: ANoB5pl6CN1imuTECeuM6VdqG5LWNcYWRKqIjG+rGaOLc9NJt6DrcDWV
        4gzz665WOawb9/k4EiGOEa3CyTZuNXNIaQ==
X-Google-Smtp-Source: AA0mqf5bUTnWIeZUMTYfWzcYyQ2Ayw75862olJovnwQkgFAZMu4TKHAv/LhckeZcuq6IEBmsNETSfA==
X-Received: by 2002:a17:903:120c:b0:188:fc5f:84f3 with SMTP id l12-20020a170903120c00b00188fc5f84f3mr51970782plh.2.1669775747099;
        Tue, 29 Nov 2022 18:35:47 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v11-20020a63464b000000b00476b165ff8bsm15069pgk.57.2022.11.29.18.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 18:35:46 -0800 (PST)
Subject: [PATCH 2/2] RISC-V: Add some comments about the shadow and overflow stacks
Date:   Tue, 29 Nov 2022 18:35:15 -0800
Message-Id: <20221130023515.20217-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130023515.20217-1-palmer@rivosinc.com>
References: <20221130023515.20217-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     jszhang@kernel.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It took me a while to page all this back in when trying to review the
recent spin_shadow_stack, so I figured I'd just write up some comments.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index acdfcacd7e57..336d4aadadb1 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -200,18 +200,18 @@ void __init trap_init(void)
 }
 
 #ifdef CONFIG_VMAP_STACK
+/*
+ * Extra stack space that allows us to provide panic messages when the kernel
+ * has overflowed its stack.
+ */
 static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
 		overflow_stack)__aligned(16);
 /*
- * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
- * to get per-cpu overflow stack(get_overflow_stack).
+ * A temporary stack for use by handle_kernel_stack_overflow.  This is used so
+ * we can call into C code to get the per-hart overflow stack.  Usage of this
+ * stack must be protected by spin_shadow_stack.
  */
 long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);
-asmlinkage unsigned long get_overflow_stack(void)
-{
-	return (unsigned long)this_cpu_ptr(overflow_stack) +
-		OVERFLOW_STACK_SIZE;
-}
 
 /*
  * A pseudo spinlock to protect the shadow stack from being used by multiple
@@ -222,6 +222,12 @@ asmlinkage unsigned long get_overflow_stack(void)
  */
 unsigned long spin_shadow_stack;
 
+asmlinkage unsigned long get_overflow_stack(void)
+{
+	return (unsigned long)this_cpu_ptr(overflow_stack) +
+		OVERFLOW_STACK_SIZE;
+}
+
 asmlinkage void handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
-- 
2.38.1

