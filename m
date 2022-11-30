Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEE063CD5D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiK3C3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiK3C3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:29:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A976A763
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:29:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so577139pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=gi2uEo4iaZLZVK/wFCJO91dGFuOd6zHilYY5g4w8jXE=;
        b=aUkhALw5FZWUswh6W0OKLKG/PwAdMiQfPz8JlPvDUwuQRWoP2iqoCnoCuaP0b6FLjd
         z9pJyDQwNTNkR2DYc/QW1TFA+STq2guziXD++tNbePuCdZzOmhhCvSdjiipRqA7Y5SbJ
         ZWiLnrXtOvxxwxQdOaIzRYEJ/FD7t+CIavlnh4p/m/GeCIU4ya5d12XiROmAxNbr8tx8
         CN1ZFNB0iFUvxDxobsRKFcYITV1e6aspAHpFu5DmT90FjB+9Yl3FvQTOMfyEWsOuVT1V
         fWvN4hRifrmQ41cyG5FlurfDj8h3JZnoTq+pnqXaVOlckim4NO8kl9pP0EAN13dZbI9F
         iPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gi2uEo4iaZLZVK/wFCJO91dGFuOd6zHilYY5g4w8jXE=;
        b=o0tiBbsdOEF4NxNGAiDbRQqfTQYkChN4CD5aqIoypY0goMXA7l0zGIdibpMcesRF4R
         hYSKgkzf9QYVok8fCfufawezQmUZBxIM9mOPTafdDkAT9APCp6D8NiqYfa/85CbTsV8A
         gvh0dS/mK8FbS4EOdaPsnO3rDPGxSny6qfoTvxWwfG2/oQt4W3ZvfnAfrqEsXUUO3+KG
         Rx4ubLpU+RPKXB9YGdA/Nr8OYec3Q++RxiMqcAOpbijmmWk9Et1tkHga+3bHkjqy1J7I
         54VLilWLHBT1HzOV0pxkw5WZYHxu6r8uOUWLhr11n1sY35xCYkHJEzufAj+I26RNomto
         NkVQ==
X-Gm-Message-State: ANoB5pnHov1+MbV6HPNE0MWLb+xUgqv7MOht0fFnML/zIRmv8VTaeLuQ
        +NTiMXBJ6cNj4FygaRMkGnn2INOmPjkilQ==
X-Google-Smtp-Source: AA0mqf71uUGWF1g6dJ/2iwnyLEvslimAagc1jwlrS97pQyhcX+j/bfxmFnS1On0YvTACfZSnAX9WHw==
X-Received: by 2002:a17:902:9307:b0:189:9284:2140 with SMTP id bc7-20020a170902930700b0018992842140mr9828829plb.111.1669775342931;
        Tue, 29 Nov 2022 18:29:02 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p22-20020a170902a41600b001869b988d93sm11496627plq.187.2022.11.29.18.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 18:29:02 -0800 (PST)
Subject: [PATCH v4] riscv: fix race when vmap stack overflow
Date:   Tue, 29 Nov 2022 18:24:43 -0800
Message-Id: <20221130022442.18358-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
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

From: Jisheng Zhang <jszhang@kernel.org>

Currently, when detecting vmap stack overflow, riscv firstly switches
to the so called shadow stack, then use this shadow stack to call the
get_overflow_stack() to get the overflow stack. However, there's
a race here if two or more harts use the same shadow stack at the same
time.

To solve this race, we introduce spin_shadow_stack atomic var, which
will be swap between its own address and 0 in atomic way, when the
var is set, it means the shadow_stack is being used; when the var
is cleared, it means the shadow_stack isn't being used.

Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Suggested-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/r/20221030124517.2370-1-jszhang@kernel.org
[Palmer: Add AQ to the swap, and also some comments.]
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
Sorry to just re-spin this one without any warning, but I'd read patch a
few times and every time I'd managed to convice myself there was a much
simpler way of doing this.  By the time I'd figured out why that's not
the case it seemed faster to just write the comments.

I've stashed this, right on top of the offending commit, at
palmer/riscv-fix_vmap_stack.

Since v3:
 - Add AQ to the swap.
 - Add a bunch of comments.

Since v2:
 - use REG_AMOSWAP
 - add comment to the purpose of smp_store_release()

Since v1:
 - use smp_store_release directly
 - use unsigned int instead of atomic_t
---
 arch/riscv/include/asm/asm.h |  1 +
 arch/riscv/kernel/entry.S    | 13 +++++++++++++
 arch/riscv/kernel/traps.c    | 18 ++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 618d7c5af1a2..e15a1c9f1cf8 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -23,6 +23,7 @@
 #define REG_L		__REG_SEL(ld, lw)
 #define REG_S		__REG_SEL(sd, sw)
 #define REG_SC		__REG_SEL(sc.d, sc.w)
+#define REG_AMOSWAP_AQ	__REG_SEL(amoswap.d.aq, amoswap.w.aq)
 #define REG_ASM		__REG_SEL(.dword, .word)
 #define SZREG		__REG_SEL(8, 4)
 #define LGREG		__REG_SEL(3, 2)
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 98f502654edd..5fdb6ba09600 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -387,6 +387,19 @@ handle_syscall_trace_exit:
 
 #ifdef CONFIG_VMAP_STACK
 handle_kernel_stack_overflow:
+	/*
+	 * Takes the psuedo-spinlock for the shadow stack, in case multiple
+	 * harts are concurrently overflowing their kernel stacks.  We could
+	 * store any value here, but since we're overflowing the kernel stack
+	 * already we only have SP to use as a scratch register.  So we just
+	 * swap in the address of the spinlock, as that's definately non-zero.
+	 *
+	 * Pairs with a store_release in handle_bad_stack().
+	 */
+1:	la sp, spin_shadow_stack
+	REG_AMOSWAP_AQ sp, sp, (sp)
+	bnez sp, 1b
+
 	la sp, shadow_stack
 	addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index bb6a450f0ecc..be54ccea8c47 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -213,11 +213,29 @@ asmlinkage unsigned long get_overflow_stack(void)
 		OVERFLOW_STACK_SIZE;
 }
 
+/*
+ * A pseudo spinlock to protect the shadow stack from being used by multiple
+ * harts concurrently.  This isn't a real spinlock because the lock side must
+ * be taken without a valid stack and only a single register, it's only taken
+ * while in the process of panicing anyway so the performance and error
+ * checking a proper spinlock gives us doesn't matter.
+ */
+unsigned long spin_shadow_stack;
+
 asmlinkage void handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
 	unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
 
+	/*
+	 * We're done with the shadow stack by this point, as we're on the
+	 * overflow stack.  Tell any other concurrent overflowing harts that
+	 * they can proceed with panicing by releasing the pseudo-spinlock.
+	 *
+	 * This pairs with an amoswap.aq in handle_kernel_stack_overflow.
+	 */
+	smp_store_release(&spin_shadow_stack, 0);
+
 	console_verbose();
 
 	pr_emerg("Insufficient stack space to handle exception!\n");
-- 
2.38.1

