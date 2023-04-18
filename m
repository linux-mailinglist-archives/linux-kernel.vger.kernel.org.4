Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887A66E6A50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjDRQ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjDRQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:58:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D77530F5;
        Tue, 18 Apr 2023 09:58:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id iw7-20020a05600c54c700b003f16fce55b5so221117wmb.0;
        Tue, 18 Apr 2023 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681837112; x=1684429112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6qUjw+9IN0xT2b+Y+r4noQaKqVwfg3S7vKVKrsqDTY=;
        b=JZ6KOhP4jYskKGLyfwgC4hVeIgqCrD9EybJ11fHq850UrXZ3ol+f0QLRHCfH3BD6Tx
         Oru7jlPaT56J/4SsHstMJJkCDJ4DJpshJkD1s53uxNyuls71OD0FSKSZatGnsMx4K7U+
         4z0FQqmpQ4hGZf7rOpTnpfZJZgGkkr7AoDBU+NQtAaLU4VV1eFvdlmmLl0U7qMj5ml/U
         IlhGNeVIIljlHQu7Pf17qf+zkeSvF/4DubeEGoYmE1y+swMtQblaPSmfHliGY3jaewyY
         c8kHOZ/JZtpBskrq15sGmp33HVSe6GNbMQgHy2zUgUrp2Ty0JFg8KElY9/vYFALyp3lw
         rDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837112; x=1684429112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6qUjw+9IN0xT2b+Y+r4noQaKqVwfg3S7vKVKrsqDTY=;
        b=eG0VjPvQVH2ywpP61ZmBi2fgAPhwyuE08Adl+xUoKRS3fnzMqIJoD3yy5tcTje1vhB
         D2jPjz2oG1GwagCT83GSDQMTLKfoTsZeFjHctIyJFAK8hsj846mELj4AQCQNaJQsTK+2
         4wZ0nDiwb07+DArCvQjwoiAdI8Pb+t5EhF27+JnojZ4DDG0Qzc8I9ZHTNaVBfy1RyB+G
         8G4bkRjEaR6sEvHbtPkqy4d51zusS2NReoc9AhK19w4GLuFBxwPNZLa8rFUtP2nQXAe2
         O6kkmVH24Ja9HOmyNFiKR+TgSOHb5DVGMrT1ZdPFfMKZD2TU+k8kf8gEZ8M6Czh8mlVN
         nHQA==
X-Gm-Message-State: AAQBX9dI6lRNkRQQu23eBH7OzLVYEzz+6brwPaMSkioJG1gRSgRdrjPh
        rUs7PI58rspP2/67VOyUIcKRaa67Pgw=
X-Google-Smtp-Source: AKy350bBQNddun1q5Lfe+bhdAPTidimlCCNDylrVcmCkAAMBiZruZImp4c5onHLe0GkNa4JPw0AzWQ==
X-Received: by 2002:a05:600c:d7:b0:3f1:7287:55ad with SMTP id u23-20020a05600c00d700b003f1728755admr6338104wmm.10.1681837112366;
        Tue, 18 Apr 2023 09:58:32 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id t16-20020a7bc3d0000000b003f1692ebd0asm10262398wmj.3.2023.04.18.09.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:58:31 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH 2/4] openrisc: Support storing and restoring fpu state
Date:   Tue, 18 Apr 2023 17:58:11 +0100
Message-Id: <20230418165813.1900991-3-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230418165813.1900991-1-shorne@gmail.com>
References: <20230418165813.1900991-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OpenRISC floating point state is not so expensive to save as OpenRISC uses
general purpose registers for floating point instructions.  We need to save
only the floating point status and control register, FPCSR.

Add support to maintain the FPCSR unconditionally upon exceptions and
switches.  On machines that do not support FPU this will always just
store 0x0 and restore is a no-op.  On FPU systems this adds an
additional special purpose register read/write and read/write to memory
(already cached).

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/ptrace.h |  4 ++--
 arch/openrisc/kernel/entry.S       | 14 ++++++++++++++
 arch/openrisc/kernel/traps.c       |  5 +++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
index 01f81d4e97dc..375147ff71fc 100644
--- a/arch/openrisc/include/asm/ptrace.h
+++ b/arch/openrisc/include/asm/ptrace.h
@@ -59,7 +59,7 @@ struct pt_regs {
 	 * -1 for all other exceptions.
 	 */
 	long  orig_gpr11;	/* For restarting system calls */
-	long dummy;		/* Cheap alignment fix */
+	long fpcsr;		/* Floating point control status register. */
 	long dummy2;		/* Cheap alignment fix */
 };
 
@@ -115,6 +115,6 @@ static inline long regs_return_value(struct pt_regs *regs)
 #define PT_GPR31      124
 #define PT_PC	      128
 #define PT_ORIG_GPR11 132
-#define PT_SYSCALLNO  136
+#define PT_FPCSR      136
 
 #endif /* __ASM_OPENRISC_PTRACE_H */
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index a130c4dac48d..c7b47e571220 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -106,6 +106,8 @@
 	l.mtspr r0,r3,SPR_EPCR_BASE				;\
 	l.lwz   r3,PT_SR(r1)					;\
 	l.mtspr r0,r3,SPR_ESR_BASE				;\
+	l.lwz	r3,PT_FPCSR(r1)					;\
+	l.mtspr	r0,r3,SPR_FPCSR					;\
 	l.lwz   r2,PT_GPR2(r1)					;\
 	l.lwz   r3,PT_GPR3(r1)					;\
 	l.lwz   r4,PT_GPR4(r1)					;\
@@ -175,6 +177,8 @@ handler:							;\
 	/* r30 already save */					;\
 	l.sw    PT_GPR31(r1),r31					;\
 	TRACE_IRQS_OFF_ENTRY						;\
+	l.mfspr	r30,r0,SPR_FPCSR				;\
+	l.sw	PT_FPCSR(r1),r30				;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
 	l.addi	r30,r0,-1					;\
 	l.sw	PT_ORIG_GPR11(r1),r30
@@ -215,6 +219,8 @@ handler:							;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
 	l.addi	r30,r0,-1					;\
 	l.sw	PT_ORIG_GPR11(r1),r30				;\
+	l.mfspr	r30,r0,SPR_FPCSR				;\
+	l.sw	PT_FPCSR(r1),r30				;\
 	l.addi	r3,r1,0						;\
 	/* r4 is exception EA */				;\
 	l.addi	r5,r0,vector					;\
@@ -1087,6 +1093,10 @@ ENTRY(_switch)
 	l.sw    PT_GPR28(r1),r28
 	l.sw    PT_GPR30(r1),r30
 
+	/* Store the old FPU state to new pt_regs */
+	l.mfspr	r29,r0,SPR_FPCSR
+	l.sw	PT_FPCSR(r1),r29
+
 	l.addi	r11,r10,0			/* Save old 'current' to 'last' return value*/
 
 	/* We use thread_info->ksp for storing the address of the above
@@ -1109,6 +1119,10 @@ ENTRY(_switch)
 	l.lwz	r29,PT_SP(r1)
 	l.sw	TI_KSP(r10),r29
 
+	/* Restore the old value of FPCSR */
+	l.lwz	r29,PT_FPCSR(r1)
+	l.mtspr	r0,r29,SPR_FPCSR
+
 	/* ...and restore the registers, except r11 because the return value
 	 * has already been set above.
 	 */
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index fd9a0f2b66c4..f5bbe6b55849 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -75,8 +75,9 @@ void show_registers(struct pt_regs *regs)
 		in_kernel = 0;
 
 	printk("CPU #: %d\n"
-	       "   PC: %08lx    SR: %08lx    SP: %08lx\n",
-	       smp_processor_id(), regs->pc, regs->sr, regs->sp);
+	       "   PC: %08lx    SR: %08lx    SP: %08lx FPCSR: %08lx\n",
+	       smp_processor_id(), regs->pc, regs->sr, regs->sp,
+	       regs->fpcsr);
 	printk("GPR00: %08lx GPR01: %08lx GPR02: %08lx GPR03: %08lx\n",
 	       0L, regs->gpr[1], regs->gpr[2], regs->gpr[3]);
 	printk("GPR04: %08lx GPR05: %08lx GPR06: %08lx GPR07: %08lx\n",
-- 
2.39.1

