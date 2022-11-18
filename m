Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377FA62FBC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242323AbiKRReN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242541AbiKRRdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:33:46 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023FE99EAA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:32:36 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so8908824pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NBmSk7fBSAJxNI2xlbnnvVbJDd4rleDkNQ22MfWjS4=;
        b=F0LYXy04+BTUjesxYiznzIMp2EPv6TsAXbgRS7pQaL8OVC5YVDOU5m8FLAC/FIzrky
         g023O0gv5uUPYMTsf65qv4ardfNDmUcl38ECWjHwojCt7NXtJVG3KJKr1l6WR8RljrFP
         rtiSJ0hvZ+xve4POcmFgudRMFpS3FTy5EaS4Gp6yEvXM8t7ByKn/EOEiFaG72rgpdwtE
         Ia1Qz9fLb20rSXAqzcEWosodqLqAhvtnpMJWCkTJmbTsx6dmQL6By1FcxZHnAhuYj8tx
         Rx9JHHuYX8ZUr+6rVgwnFnQKpG7/Ap36Kcc5H9AbqX6x0fsKxCcuJeXrTC8tCsXKkK0B
         4qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NBmSk7fBSAJxNI2xlbnnvVbJDd4rleDkNQ22MfWjS4=;
        b=PQDNXGMp1BP0t+tE7bj1jE2C1Ae2rYhzcMoM1sQs1hXrC7cl6WhbuOECdCBYRFeLo5
         Tce/Kalygsh+kfBJR0GIrvMyS3DYDbmqUzVJB0Weo7WRIxIqaPXZK7wPAdD8INtCnWIN
         MBinYn0v1jFi1hXSMUhfeKAPkGZ12b06KyQI3GkFzamItTzd+ONEwNEwO4MYvKp3299D
         OlrcjwUsmI2cH/IiTdp0jJUVrvcYlJfPNlSXnnb4NvGNJUUacfe0IJzLn4igbIA/pG/s
         qXXPDUI5FNHQ83i+y+m2YAd9Xnlsa2l424ULDp5iN0D+OD5dIx9lZLx77qrDW6zzo+2c
         EW5w==
X-Gm-Message-State: ANoB5plNiKo20L/BY3NmNHGR3iZq3B/LqaV/FvpeH7jhsOCXRO0e+m3p
        kawnYrKQ1KVk8aSKduFoqSA=
X-Google-Smtp-Source: AA0mqf4QhHX9xixekXRosr4UFGQ5KWFFv0b2o6M8eemOOc2cuROcW7yNBijARk3dISgqt+U20PDZ2A==
X-Received: by 2002:a17:902:cf0e:b0:17c:5b01:f227 with SMTP id i14-20020a170902cf0e00b0017c5b01f227mr620277plg.3.1668792755984;
        Fri, 18 Nov 2022 09:32:35 -0800 (PST)
Received: from localhost.localdomain ([112.2.231.196])
        by smtp.gmail.com with ESMTPSA id u7-20020a656707000000b00476b6b7f339sm3037979pgf.11.2022.11.18.09.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:32:35 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH v3 2/2] riscv/ftrace: make ftrace_caller call ftrace_graph_func
Date:   Sat, 19 Nov 2022 01:32:17 +0800
Message-Id: <20221118173217.888077-3-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221118173217.888077-1-suagrfillet@gmail.com>
References: <20221118173217.888077-1-suagrfillet@gmail.com>
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

In order to make the function graph use ftrace directly, ftrace_caller
should be adjusted to save the necessary regs against the pt_regs layout
so it can call ftrace_graph_func reasonably.

SAVE_ALL now saves all the regs according to the pt_regs struct. Here
supersedes SAVE_ALL by SAVE_ABI_REGS which has an extra option to allow
saving only the necessary ABI-related regs for ftrace_caller.

ftrace_caller and ftrace_regs_caller save their regs with the respective
option of SAVE_ABI_REGS, then call the tracing function, especially
graph_ops's ftrace_graph_func. So the ftrace_graph_[regs]_call labels
aren't needed anymore if FTRACE_WITH_REGS is defined.

As the previous patch described, the ftrace_caller remains with its
ftrace_graph_call if FTRACE_WITH_REGS isn't defined,

For convenience, the original argument setup for the tracing function in
ftrace_[regs]_caller is killed and appended to the tail of SAVE_ABI_REGS.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/mcount-dyn.S | 143 ++++++++++++++++++++++++---------
 1 file changed, 105 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 64bc79816f5e..c70f04711a2e 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -57,19 +57,55 @@
 	.endm
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	.macro SAVE_ALL
+
+/**
+* SAVE_ABI_REGS - save regs against the pt_regs struct
+*
+* @all: tell if saving all the regs
+*
+* If all is set, all the regs will be saved, otherwise only ABI
+* related regs (a0-a7,epc,ra and optional s0) will be saved.
+*
+* For convenience the argument setup for tracing function is appended here.
+* Especially $sp is passed as the 4th argument of the tracing function.
+*
+* After the stack is established,
+*
+* 0(sp) stores the PC of the traced function which can be accessed
+* by &(fregs)->regs->epc in tracing function. Note that the real
+* function entry address should be computed with -FENTRY_RA_OFFSET.
+*
+* 8(sp) stores the function return address (i.e. parent IP) that
+* can be accessed by &(fregs)->regs->ra in tracing function.
+*
+* The other regs are saved at the respective localtion and accessed
+* by the respective pt_regs member.
+*
+* Here is the layout of stack for your reference.
+*
+* PT_SIZE_ON_STACK  ->  +++++++++
+*                       + ..... +
+*                       + t3-t6 +
+*                       + s2-s11+
+*                       + a0-a7 + --++++-> ftrace_caller saved
+*                       + s1    +   +
+*                       + s0    + --+
+*                       + t0-t2 +   +
+*                       + tp    +   +
+*                       + gp    +   +
+*                       + sp    +   +
+*                       + ra    + --+ // parent IP
+*               sp  ->  + epc   + --+ // PC
+*                       +++++++++
+**/
+	.macro SAVE_ABI_REGS, all=0
 	addi	sp, sp, -PT_SIZE_ON_STACK
 
 	REG_S t0,  PT_EPC(sp)
 	REG_S x1,  PT_RA(sp)
-	REG_S x2,  PT_SP(sp)
-	REG_S x3,  PT_GP(sp)
-	REG_S x4,  PT_TP(sp)
-	REG_S x5,  PT_T0(sp)
-	REG_S x6,  PT_T1(sp)
-	REG_S x7,  PT_T2(sp)
-	REG_S x8,  PT_S0(sp)
-	REG_S x9,  PT_S1(sp)
+
+	// always save the ABI regs
+
 	REG_S x10, PT_A0(sp)
 	REG_S x11, PT_A1(sp)
 	REG_S x12, PT_A2(sp)
@@ -78,6 +114,18 @@
 	REG_S x15, PT_A5(sp)
 	REG_S x16, PT_A6(sp)
 	REG_S x17, PT_A7(sp)
+
+	// save the leftover regs
+
+	.if \all == 1
+	REG_S x2,  PT_SP(sp)
+	REG_S x3,  PT_GP(sp)
+	REG_S x4,  PT_TP(sp)
+	REG_S x5,  PT_T0(sp)
+	REG_S x6,  PT_T1(sp)
+	REG_S x7,  PT_T2(sp)
+	REG_S x8,  PT_S0(sp)
+	REG_S x9,  PT_S1(sp)
 	REG_S x18, PT_S2(sp)
 	REG_S x19, PT_S3(sp)
 	REG_S x20, PT_S4(sp)
@@ -92,19 +140,28 @@
 	REG_S x29, PT_T4(sp)
 	REG_S x30, PT_T5(sp)
 	REG_S x31, PT_T6(sp)
+
+	// save s0 if FP_TEST defined
+
+	.else
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	REG_S x8,  PT_S0(sp)
+#endif
+	.endif
+
+	// setup 4 args for tracing functions
+
+	addi	a0, t0, -FENTRY_RA_OFFSET	// ip
+	la	a1, function_trace_op
+	REG_L	a2, 0(a1)			// op
+	REG_L	a1, PT_RA(sp)			// parent_ip
+	mv	a3, sp				// fregs
+
 	.endm
 
-	.macro RESTORE_ALL
+	.macro RESTORE_ABI_REGS, all=0
 	REG_L t0,  PT_EPC(sp)
 	REG_L x1,  PT_RA(sp)
-	REG_L x2,  PT_SP(sp)
-	REG_L x3,  PT_GP(sp)
-	REG_L x4,  PT_TP(sp)
-	REG_L x5,  PT_T0(sp)
-	REG_L x6,  PT_T1(sp)
-	REG_L x7,  PT_T2(sp)
-	REG_L x8,  PT_S0(sp)
-	REG_L x9,  PT_S1(sp)
 	REG_L x10, PT_A0(sp)
 	REG_L x11, PT_A1(sp)
 	REG_L x12, PT_A2(sp)
@@ -113,6 +170,16 @@
 	REG_L x15, PT_A5(sp)
 	REG_L x16, PT_A6(sp)
 	REG_L x17, PT_A7(sp)
+
+	.if \all == 1
+	REG_L x2,  PT_SP(sp)
+	REG_L x3,  PT_GP(sp)
+	REG_L x4,  PT_TP(sp)
+	REG_L x5,  PT_T0(sp)
+	REG_L x6,  PT_T1(sp)
+	REG_L x7,  PT_T2(sp)
+	REG_L x8,  PT_S0(sp)
+	REG_L x9,  PT_S1(sp)
 	REG_L x18, PT_S2(sp)
 	REG_L x19, PT_S3(sp)
 	REG_L x20, PT_S4(sp)
@@ -128,10 +195,16 @@
 	REG_L x30, PT_T5(sp)
 	REG_L x31, PT_T6(sp)
 
+	.else
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	REG_L x8,  PT_S0(sp)
+#endif
+	.endif
 	addi	sp, sp, PT_SIZE_ON_STACK
 	.endm
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 ENTRY(ftrace_caller)
 	SAVE_ABI
 
@@ -160,33 +233,27 @@ ftrace_graph_call:
 	jr t0
 ENDPROC(ftrace_caller)
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 ENTRY(ftrace_regs_caller)
-	SAVE_ALL
-
-	addi	a0, t0, -FENTRY_RA_OFFSET
-	la	a1, function_trace_op
-	REG_L	a2, 0(a1)
-	REG_L	a1, PT_RA(sp)
-	mv	a3, sp
+	SAVE_ABI_REGS 1
 
 ftrace_regs_call:
 	.global ftrace_regs_call
 	call	ftrace_stub
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	addi	a0, sp, PT_RA
-	REG_L	a1, PT_T0(sp)
-	addi	a1, a1, -FENTRY_RA_OFFSET
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	mv	a2, s0
-#endif
-ftrace_graph_regs_call:
-	.global ftrace_graph_regs_call
-	call	ftrace_stub
-#endif
 
-	RESTORE_ALL
+	RESTORE_ABI_REGS 1
 	jr t0
 ENDPROC(ftrace_regs_caller)
+
+ENTRY(ftrace_caller)
+	SAVE_ABI_REGS 0
+
+ftrace_call:
+	.global ftrace_call
+	call	ftrace_stub
+
+	RESTORE_ABI_REGS 0
+	jr t0
+ENDPROC(ftrace_caller)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
-- 
2.20.1

