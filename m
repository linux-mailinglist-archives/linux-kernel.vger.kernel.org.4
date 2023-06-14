Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F372F3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbjFNEwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242338AbjFNEw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:52:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590AC122
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:52:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b4f8523197so3476125ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686718345; x=1689310345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOGUIeRe2rK2jH6MjOQ7yvAIrs8mgJudUR0sm9NyIA8=;
        b=Qn7pJFh6xO4WWSsEvgjH1opYxxWqsZzkWMnhskuVes2RbFb0G9Db8wOg5c2t/g5uV4
         l+NB+sdWccozmqfgrIO0cQ2bCbjPfwynIP1bNggehSck+yXsTOzslUxqhzpCC8N9/Zvv
         vs/GQ05QI7fbfZPOc654z8tZvRRpy+oaY5eScgIzuU4ACqnVCe2fyuSddgZ8WZkrVY4l
         J/S/xzfgMwIQA7uWtnDEMyHMDrAC3EIUv81GD70LHmdZgRlGkVnFkBoloBHfeFuLh1hb
         xr/6tszPWnfn/rtetdX4ptDoVRPcHUOF851waRJ+d4elXbzRgvCxOZbaNtExexFZvahN
         AHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686718345; x=1689310345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOGUIeRe2rK2jH6MjOQ7yvAIrs8mgJudUR0sm9NyIA8=;
        b=MRU/e0Lecz2uKRvyEXvQUGoLDwlTvTeQOFo3bDsQDCgoE2iUYdayYHYVYgkza+s0nq
         kdqPx5yd/N048QPYVCk48UufISypUeR86OOICKd51HhKhwiOLh8qPSXwobZkfxNABVvG
         Grg8AnD6/7xvSzdh7wDfy/s06aySWn9AwQ3xAsf2XMBltp2yz1ddvrHoxoRrzV5GdIOU
         LhvmU7gda8iWt/S0p+YEHrpw9DXq+vMibeJKjcJqjGImJG5xO0s14zjy2QDTEZ7x8N2R
         H56TaaDxwUvvrteFoD5Sq0fFhG28BtaKE8rtQ9zGpt67YWQjSlTDhxm2OGKC0wLem7pN
         hRaQ==
X-Gm-Message-State: AC+VfDze5Fgkm9KF4pR702GaEC1ZgDaoBnhNvG6rcJ0Azb2bs/XruNi+
        cdu8fao8IZVzAkRdfR78oxajt+Akrao=
X-Google-Smtp-Source: ACHHUZ4WrU2ahi67DkOUvlkSBAGa3NHRaCOZ9UlXYnqBTMJ01tRUTmllG2EJdSmda82dW4unVO1Okg==
X-Received: by 2002:a17:903:1d1:b0:1a1:d54b:71df with SMTP id e17-20020a17090301d100b001a1d54b71dfmr792990plh.0.1686718345433;
        Tue, 13 Jun 2023 21:52:25 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:bf5f:2e99:78f2:6007])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001acad86ebc5sm11089790plg.33.2023.06.13.21.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 21:52:24 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4/4] xtensa: add load/store exception handler
Date:   Tue, 13 Jun 2023 21:52:12 -0700
Message-Id: <20230614045212.2534746-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230614045212.2534746-1-jcmvbkbc@gmail.com>
References: <20230614045212.2534746-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory attached to instruction bus of the xtensa CPU is only accessible
for a limited subset of opcodes. Other opcodes generate an exception
with the load/store error cause code. This property complicates use of
such systems. Provide a handler that recognizes and transparently fixes
such exceptions. The following opcodes are recognized when used outside
of FLIX bundles: l32i, l32i.n, l16ui, l16si, l8ui.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig             |  12 ++++
 arch/xtensa/include/asm/traps.h |   5 ++
 arch/xtensa/kernel/align.S      | 109 ++++++++++++++++++++++++++++----
 arch/xtensa/kernel/setup.c      |   3 +-
 arch/xtensa/kernel/traps.c      |  21 +++++-
 5 files changed, 136 insertions(+), 14 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index b1189f085a68..c9cb0cc78ebb 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -209,6 +209,18 @@ config XTENSA_UNALIGNED_USER
 
 	  Say Y here to enable unaligned memory access in user space.
 
+config XTENSA_LOAD_STORE
+	bool "Load/store exception handler for memory only readable with l32"
+	help
+	  The Xtensa architecture only allows reading memory attached to its
+	  instruction bus with l32r and l32i instructions, all other
+	  instructions raise an exception with the LoadStoreErrorCause code.
+	  This makes it hard to use some configurations, e.g. store string
+	  literals in FLASH memory attached to the instruction bus.
+
+	  Say Y here to enable exception handler that allows transparent
+	  byte and 2-byte access to memory attached to instruction bus.
+
 config HAVE_SMP
 	bool "System Supports SMP (MX)"
 	depends on XTENSA_VARIANT_CUSTOM
diff --git a/arch/xtensa/include/asm/traps.h b/arch/xtensa/include/asm/traps.h
index acffb02f8760..212c3b9ff407 100644
--- a/arch/xtensa/include/asm/traps.h
+++ b/arch/xtensa/include/asm/traps.h
@@ -47,6 +47,7 @@ __init trap_set_handler(int cause, xtensa_exception_handler *handler);
 asmlinkage void fast_illegal_instruction_user(void);
 asmlinkage void fast_syscall_user(void);
 asmlinkage void fast_alloca(void);
+asmlinkage void fast_load_store(void);
 asmlinkage void fast_unaligned(void);
 asmlinkage void fast_second_level_miss(void);
 asmlinkage void fast_store_prohibited(void);
@@ -64,6 +65,10 @@ void do_unhandled(struct pt_regs *regs);
 static inline void __init early_trap_init(void)
 {
 	static struct exc_table init_exc_table __initdata = {
+#ifdef CONFIG_XTENSA_LOAD_STORE
+		.fast_kernel_handler[EXCCAUSE_LOAD_STORE_ERROR] =
+			fast_load_store,
+#endif
 #ifdef CONFIG_MMU
 		.fast_kernel_handler[EXCCAUSE_DTLB_MISS] =
 			fast_second_level_miss,
diff --git a/arch/xtensa/kernel/align.S b/arch/xtensa/kernel/align.S
index bcbd7962a684..20d6b4961001 100644
--- a/arch/xtensa/kernel/align.S
+++ b/arch/xtensa/kernel/align.S
@@ -22,7 +22,17 @@
 #include <asm/asmmacro.h>
 #include <asm/processor.h>
 
-#if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
+#if XCHAL_UNALIGNED_LOAD_EXCEPTION || defined CONFIG_XTENSA_LOAD_STORE
+#define LOAD_EXCEPTION_HANDLER
+#endif
+
+#if XCHAL_UNALIGNED_STORE_EXCEPTION || defined LOAD_EXCEPTION_HANDLER
+#define ANY_EXCEPTION_HANDLER
+#endif
+
+#if XCHAL_HAVE_WINDOWED
+#define UNALIGNED_USER_EXCEPTION
+#endif
 
 /*  First-level exception handler for unaligned exceptions.
  *
@@ -58,10 +68,6 @@
  *  BE  shift left / mask 0 0 X X
  */
 
-#if XCHAL_HAVE_WINDOWED
-#define UNALIGNED_USER_EXCEPTION
-#endif
-
 #if XCHAL_HAVE_BE
 
 #define HWORD_START	16
@@ -103,7 +109,7 @@
  *
  *	       23			    0
  *		-----------------------------
- *	res	          0000           0010
+ *	L8UI	xxxx xxxx 0000 ssss tttt 0010
  *	L16UI	xxxx xxxx 0001 ssss tttt 0010
  *	L32I	xxxx xxxx 0010 ssss tttt 0010
  *	XXX	          0011 ssss tttt 0010
@@ -128,9 +134,11 @@
 
 #define OP0_L32I_N	0x8		/* load immediate narrow */
 #define OP0_S32I_N	0x9		/* store immediate narrow */
+#define OP0_LSAI	0x2		/* load/store */
 #define OP1_SI_MASK	0x4		/* OP1 bit set for stores */
 #define OP1_SI_BIT	2		/* OP1 bit number for stores */
 
+#define OP1_L8UI	0x0
 #define OP1_L32I	0x2
 #define OP1_L16UI	0x1
 #define OP1_L16SI	0x9
@@ -155,8 +163,73 @@
  */
 
 	.literal_position
+#ifdef CONFIG_XTENSA_LOAD_STORE
+ENTRY(fast_load_store)
+
+	call0	.Lsave_and_load_instruction
+
+	/* Analyze the instruction (load or store?). */
+
+	extui	a0, a4, INSN_OP0, 4	# get insn.op0 nibble
+
+#if XCHAL_HAVE_DENSITY
+	_beqi	a0, OP0_L32I_N, 1f	# L32I.N, jump
+#endif
+	bnei	a0, OP0_LSAI, .Linvalid_instruction
+	/* 'store indicator bit' set, jump */
+	bbsi.l	a4, OP1_SI_BIT + INSN_OP1, .Linvalid_instruction
+
+1:
+	movi	a3, ~3
+	and	a3, a3, a8		# align memory address
+
+	__ssa8	a8
+
+#ifdef CONFIG_MMU
+	/* l32e can't be used here even when it's available. */
+	/* TODO access_ok(a3) could be used here */
+	j	.Linvalid_instruction
+#endif
+	l32i	a5, a3, 0
+	l32i	a6, a3, 4
+	__src_b	a3, a5, a6		# a3 has the data word
+
+#if XCHAL_HAVE_DENSITY
+	addi	a7, a7, 2		# increment PC (assume 16-bit insn)
+	_beqi	a0, OP0_L32I_N, .Lload_w# l32i.n: jump
+	addi	a7, a7, 1
+#else
+	addi	a7, a7, 3
+#endif
+
+	extui	a5, a4, INSN_OP1, 4
+	_beqi	a5, OP1_L32I, .Lload_w
+	bnei	a5, OP1_L8UI, .Lload16
+	extui	a3, a3, 0, 8
+	j	.Lload_w
+
+ENDPROC(fast_load_store)
+#endif
+
+/*
+ * Entry condition:
+ *
+ *   a0:	trashed, original value saved on stack (PT_AREG0)
+ *   a1:	a1
+ *   a2:	new stack pointer, original in DEPC
+ *   a3:	a3
+ *   depc:	a2, original value saved on stack (PT_DEPC)
+ *   excsave_1:	dispatch table
+ *
+ *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
+ *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
+ */
+
+#ifdef ANY_EXCEPTION_HANDLER
 ENTRY(fast_unaligned)
 
+#if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
+
 	call0	.Lsave_and_load_instruction
 
 	/* Analyze the instruction (load or store?). */
@@ -171,12 +244,17 @@ ENTRY(fast_unaligned)
 	/* 'store indicator bit' not set, jump */
 	_bbci.l	a4, OP1_SI_BIT + INSN_OP1, .Lload
 
+#endif
+#if XCHAL_UNALIGNED_STORE_EXCEPTION
+
 	/* Store: Jump to table entry to get the value in the source register.*/
 
 .Lstore:movi	a5, .Lstore_table	# table
 	extui	a6, a4, INSN_T, 4	# get source register
 	addx8	a5, a6, a5
 	jx	a5			# jump into table
+#endif
+#if XCHAL_UNALIGNED_LOAD_EXCEPTION
 
 	/* Load: Load memory address. */
 
@@ -207,7 +285,9 @@ ENTRY(fast_unaligned)
 
 	extui	a5, a4, INSN_OP1, 4
 	_beqi	a5, OP1_L32I, .Lload_w	# l32i: jump
-
+#endif
+#ifdef LOAD_EXCEPTION_HANDLER
+.Lload16:
 	extui	a3, a3, 0, 16		# extract lower 16 bits
 	_beqi	a5, OP1_L16UI, .Lload_w
 	addi	a5, a5, -OP1_L16SI
@@ -247,7 +327,8 @@ ENTRY(fast_unaligned)
 	mov	a13, a3		;	_j .Lexit;	.align 8
 	mov	a14, a3		;	_j .Lexit;	.align 8
 	mov	a15, a3		;	_j .Lexit;	.align 8
-
+#endif
+#if XCHAL_UNALIGNED_STORE_EXCEPTION
 .Lstore_table:
 	l32i	a3, a2, PT_AREG0;	_j .Lstore_w;	.align 8
 	mov	a3, a1;			_j .Lstore_w;	.align 8	# fishy??
@@ -265,7 +346,9 @@ ENTRY(fast_unaligned)
 	mov	a3, a13		;	_j .Lstore_w;	.align 8
 	mov	a3, a14		;	_j .Lstore_w;	.align 8
 	mov	a3, a15		;	_j .Lstore_w;	.align 8
+#endif
 
+#ifdef ANY_EXCEPTION_HANDLER
 	/* We cannot handle this exception. */
 
 	.extern _kernel_exception
@@ -294,6 +377,8 @@ ENTRY(fast_unaligned)
 
 2:	movi	a0, _user_exception
 	jx	a0
+#endif
+#if XCHAL_UNALIGNED_STORE_EXCEPTION
 
 	# a7: instruction pointer, a4: instruction, a3: value
 .Lstore_w:
@@ -358,7 +443,8 @@ ENTRY(fast_unaligned)
 #else
 	s32i	a6, a4, 4
 #endif
-
+#endif
+#ifdef ANY_EXCEPTION_HANDLER
 .Lexit:
 #if XCHAL_HAVE_LOOPS
 	rsr	a4, lend		# check if we reached LEND
@@ -453,7 +539,7 @@ ENTRY(fast_unaligned)
 	__src_b	a4, a4, a5	# a4 has the instruction
 
 	ret
-
+#endif
 ENDPROC(fast_unaligned)
 
 ENTRY(fast_unaligned_fixup)
@@ -490,5 +576,4 @@ ENTRY(fast_unaligned_fixup)
 	jx	a0
 
 ENDPROC(fast_unaligned_fixup)
-
-#endif /* XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION */
+#endif
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 5c0c0fcac144..08d9cb5cbd41 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -245,7 +245,8 @@ void __init init_arch(bp_tag_t *bp_start)
 {
 	/* Initialize basic exception handling if configuration may need it */
 
-	if (IS_ENABLED(CONFIG_KASAN))
+	if (IS_ENABLED(CONFIG_KASAN) ||
+	    IS_ENABLED(CONFIG_XTENSA_LOAD_STORE))
 		early_trap_init();
 
 	/* Initialize MMU. */
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index f447262468c5..5fc19aa5ba5d 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -54,6 +54,9 @@ static void do_interrupt(struct pt_regs *regs);
 #if XTENSA_FAKE_NMI
 static void do_nmi(struct pt_regs *regs);
 #endif
+#ifdef CONFIG_XTENSA_LOAD_STORE
+static void do_load_store(struct pt_regs *regs);
+#endif
 static void do_unaligned_user(struct pt_regs *regs);
 static void do_multihit(struct pt_regs *regs);
 #if XTENSA_HAVE_COPROCESSORS
@@ -89,7 +92,10 @@ static dispatch_init_table_t __initdata dispatch_init_table[] = {
 { EXCCAUSE_SYSTEM_CALL,		USER,	   fast_syscall_user },
 { EXCCAUSE_SYSTEM_CALL,		0,	   system_call },
 /* EXCCAUSE_INSTRUCTION_FETCH unhandled */
-/* EXCCAUSE_LOAD_STORE_ERROR unhandled*/
+#ifdef CONFIG_XTENSA_LOAD_STORE
+{ EXCCAUSE_LOAD_STORE_ERROR,	USER|KRNL, fast_load_store },
+{ EXCCAUSE_LOAD_STORE_ERROR,	0,	   do_load_store },
+#endif
 { EXCCAUSE_LEVEL1_INTERRUPT,	0,	   do_interrupt },
 #ifdef SUPPORT_WINDOWED
 { EXCCAUSE_ALLOCA,		USER|KRNL, fast_alloca },
@@ -354,6 +360,19 @@ static void do_div0(struct pt_regs *regs)
 	force_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)regs->pc);
 }
 
+#ifdef CONFIG_XTENSA_LOAD_STORE
+static void do_load_store(struct pt_regs *regs)
+{
+	__die_if_kernel("Unhandled load/store exception in kernel",
+			regs, SIGKILL);
+
+	pr_info_ratelimited("Load/store error to %08lx in '%s' (pid = %d, pc = %#010lx)\n",
+			    regs->excvaddr, current->comm,
+			    task_pid_nr(current), regs->pc);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void *)regs->excvaddr);
+}
+#endif
+
 /*
  * Handle unaligned memory accesses from user space. Kill task.
  *
-- 
2.30.2

