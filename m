Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550F4693D91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjBMEyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBMEyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A946B5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:08 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so10977622pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPcTKWGDPVSnaGv0xj2Ptv0rfddqsVuLBZ9aJFRMto4=;
        b=ubuWRUQI6DO7BXFrAM9O2TncXqmRilKXfzowXV5xcve/F4+hWvI8bU1bI5sCYwrNov
         xWzsT6/qXeY2wz5ryX3qVeyqTsqVrRn/s3UW2DoOrYNf3MiUDDNou9CMk6L1/oz6H6WB
         dU9WOxrHlhzoqkkzZ3zk/+UppeNZ3tzBybM7gU1o59qToIXc3KlDQVgPX9EVQHkcfv8P
         pLfafwQFE3MEzcXXtOJWy7Ic+zdkXeZoKdOzIMMSnWK/NlAKj/jwFBpv0hi/KY5NiGY8
         s+1hNqY4Wfbk6uEa34IyNOF/CuCjhHIbS4gNTmG0iU8hA3c/pOm7STbsvA06gX1ZwHSz
         TN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPcTKWGDPVSnaGv0xj2Ptv0rfddqsVuLBZ9aJFRMto4=;
        b=zMNfz23FZXYgWzGJMKfNOZYvI7nlfwFphKhQbKi95iwvZDC6iI8tMH6EyIdfXf9j/U
         4AnrA/aeglK03OKIq8Bs6DuIFh7nFzFqxwPUnUq8i6GM7q++4EexTmm5bgMbsq0Kw+yr
         cRtoihia9CdV5BZaQwub5Cn9brggqr98nu9T7/woToPrhu3cCsgATPtFxyAuakfvh1Qr
         PupURzAROlqr6xxZvxJ5cOvKHd7p7ucw3YQMIE5nGfTt8QSQu+kWfO/Znb/2o+S+Pmnr
         EI1WCc0oFjEG8ERi/o/hSK63875cp2/1U4MyfuqgKavp/+sagEPG/+vylNDTnXF4WjhY
         pTMA==
X-Gm-Message-State: AO0yUKXxPQmvHWooPf+yV5nLCKm7ezRK3M2GQa10YU3ISJxf5dVpICe0
        HYFl5FudeMhpKurz82SYi4L1MtsbYr52wgO/
X-Google-Smtp-Source: AK7set8wsluuoT60XcCmUYhbCv4YoEM/b0+zhHi0Xb0+nvF6B/eyE34xZth1kgXw3SU6JZ4UKZal8w==
X-Received: by 2002:a17:903:22c9:b0:198:fded:3b69 with SMTP id y9-20020a17090322c900b00198fded3b69mr25993049plg.53.1676264047642;
        Sun, 12 Feb 2023 20:54:07 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:07 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 04/20] riscv: kernel enabling user code for shadow stack and landing pad
Date:   Sun, 12 Feb 2023 20:53:33 -0800
Message-Id: <20230213045351.3945824-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables architectural support for shadow stack and landing pad instr
for user mode on riscv.

This patch does following
- Defines a new structure cfi_status
- Includes cfi_status in thread_info
- Defines offsets to new member fields in thread_info in asm-offsets.c
- Saves and restore cfi state on trap entry (U --> S) and exit (S --> U)

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/processor.h   | 11 ++++++++
 arch/riscv/include/asm/thread_info.h |  5 ++++
 arch/riscv/kernel/asm-offsets.c      |  5 ++++
 arch/riscv/kernel/entry.S            | 40 ++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index bdebce2cc323..f065309927b1 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -41,6 +41,17 @@ struct thread_struct {
 	unsigned long bad_cause;
 };
 
+#if defined(CONFIG_USER_SHADOW_STACK) || defined(CONFIG_USER_INDIRECT_BR_LP)
+struct cfi_status {
+	unsigned int ufcfi_en : 1; /* Enable for forward cfi. Note that ELP goes in sstatus */
+	unsigned int ubcfi_en : 1; /* Enable for backward cfi. */
+	unsigned int rsvd1 : 30;
+	unsigned int lp_label; /* saved label value (25bit) */
+	long user_shdw_stk; /* Current user shadow stack pointer */
+	long shdw_stk_base; /* Base address of shadow stack */
+};
+#endif
+
 /* Whitelist the fstate from the task_struct for hardened usercopy */
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 67322f878e0d..f74b8bd55d5b 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -65,6 +65,11 @@ struct thread_info {
 	 */
 	long			kernel_sp;	/* Kernel stack pointer */
 	long			user_sp;	/* User stack pointer */
+#if defined(CONFIG_USER_SHADOW_STACK) || defined(CONFIG_USER_INDIRECT_BR_LP)
+	/* cfi_state only if config is defined */
+	/* state of user cfi state. note this includes LPLR and SSP as well */
+	struct cfi_status       user_cfi_state;
+#endif
 	int			cpu;
 };
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index df9444397908..340e6413cf3c 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -38,6 +38,11 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
 
+#if defined(CONFIG_USER_SHADOW_STACK) || defined(CONFIG_USER_INDIRECT_BR_LP)
+	OFFSET(TASK_TI_USER_CFI_STATUS, task_struct, thread_info.user_cfi_state);
+	OFFSET(TASK_TI_USER_LPLR, task_struct, thread_info.user_cfi_state.lp_label);
+	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
+#endif
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 99d38fdf8b18..f283130c81ec 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -73,6 +73,31 @@ _save_context:
 	REG_S x30, PT_T5(sp)
 	REG_S x31, PT_T6(sp)
 
+#if	defined(CONFIG_USER_SHADOW_STACK) || defined(CONFIG_USER_INDIRECT_BR_LP)
+	/*
+	* If U --> S, CSR_SCRATCH should be holding U TP
+	* If S --> S, CSR_SCRATCH should be holding S TP
+	* s2 == tp means, previous mode was S
+	* else previous mode U
+	* we need to save cfi status only when previous mode was U
+	*/
+	csrr s2, CSR_SCRATCH
+	xor s2, s2, tp
+	beqz s2, skip_bcfi_save
+	/* load cfi status word */
+	lw s2, TASK_TI_USER_CFI_STATUS(tp)
+	andi s3, s2, 1
+	beqz s3, skip_fcfi_save
+	/* fcfi is enabled, capture ELP and LPLR state and record it */
+	csrr s3, CSR_LPLR /* record label register */
+	sw s3, TASK_TI_USER_LPLR(tp) /* save it back in thread_info structure */
+skip_fcfi_save:
+	andi s3, s2, 2
+	beqz s3, skip_bcfi_save
+	csrr s3, CSR_SSP
+	REG_S s3, TASK_TI_USER_SSP(tp) /* save user ssp in thread_info */
+skip_bcfi_save:
+#endif
 	/*
 	 * Disable user-mode memory access as it should only be set in the
 	 * actual user copy routines.
@@ -283,6 +308,21 @@ resume_userspace:
 	 */
 	csrw CSR_SCRATCH, tp
 
+#if	defined(CONFIG_USER_SHADOW_STACK) || defined(CONFIG_USER_INDIRECT_BR_LP)
+	lw s2, TASK_TI_USER_CFI_STATUS(tp)
+	andi s3, s2, 1
+	beqz s3, skip_fcfi_resume
+	xor s3, s3, s3
+	lw s3, TASK_TI_USER_LPLR(tp)
+	csrw CSR_LPLR, s3
+skip_fcfi_resume:
+	andi s3, s2, 2
+	beqz s3, skip_bcfi_resume
+	REG_L s3, TASK_TI_USER_SSP(tp) /* save user ssp in thread_info */
+	csrw CSR_SSP, s3
+skip_bcfi_resume:
+#endif
+
 restore_all:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	REG_L s1, PT_STATUS(sp)
-- 
2.25.1

