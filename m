Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047FB74E5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjGKEin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjGKEiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:38:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E939B19B5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:37:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8bbcfd89aso26054115ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689050231; x=1691642231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6/LQivFQA8b9jqIbP/DKJy7uDItnS1KInLB/h6YL4E=;
        b=INZmHpMkDYaDHO81d91eDec/Uy59gNKLYqtirIkhfbTORdvT+K6MtRPcAHdo5XfYkY
         t4jA4hWVEAx3jTAOQn65n1psr2Fgz2MhTQd4PkQ16h4FyXIpBcQ4J6/5SCVgZFNW3fg/
         yOcg/kcFxn0/0nX+b2pQbObPw14pubsel1QSUCPASDQAJ8c2ZyVoWw1Tf8htz1ngu1fO
         R+oa3W4iuyTdml26TL/GlWJaCPb0HSk53u3jk7z62Ysl0YL/vIMByQk0h9Z/OoXZuke8
         zMFOh8n5i9OpAen+ubLq0KCHFRvFhAkaJ2RHXhK6jk3tHxhE3jcgrL/+2gVvynsf+tft
         HNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689050231; x=1691642231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6/LQivFQA8b9jqIbP/DKJy7uDItnS1KInLB/h6YL4E=;
        b=HdlO+EAFbpR52RCjM7UCdDfF7t+tUPzYHkg/ohgdiz49klG29t+kUS66hXvUQSRXVB
         q+XG5jxzHOcXdF+VzEuT9W2REaNZkuJlt2+sTSnWAhNvZo8YCSIA45OmxkTJ9OpIG5ge
         0voCFtB+GCha5xQZ7we8WVSc/B3zE2Tb0GWH2iCBOShj6TkrYqFRfwFpX2LOrPgiOe50
         ORdusK0xuxaMmJcBCLw3JpiMGopdlXpRZ0En3zkRt8nacAnsdzZAo7erg2tvS5D66Tq+
         KAaU4v+5CW2TucGd6MPViQ7w281fH+oR0MjpjrHRI6jo3ZVLD418/nb+SgXSXNInBm0u
         bHJA==
X-Gm-Message-State: ABy/qLZAdaSy5pgHnltNIuQeLUfBsCid29DZc35IzdzPPkll8m2kFE/k
        u/jB2TXmNJ3hiMDVk9da4+7mh4MtBTA=
X-Google-Smtp-Source: APBJJlGhJ7QLiDPN9miky37HhIg4qsjTT/GdG+V4xvu2VF0QXlbV7qU6bR7qI4hgkj/OLzCA/MVYeA==
X-Received: by 2002:a17:902:7c02:b0:1b9:cb27:7f43 with SMTP id x2-20020a1709027c0200b001b9cb277f43mr6973132pll.43.1689050231191;
        Mon, 10 Jul 2023 21:37:11 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:7ddc:afcc:49de:c0c7])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ee1200b001b89bc1908bsm740069plb.68.2023.07.10.21.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 21:37:10 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: fix unaligned and load/store configuration interaction
Date:   Mon, 10 Jul 2023 21:37:01 -0700
Message-Id: <20230711043701.3504937-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unaligned exception handler is needed in configurations with hardware
support for unaligned access when the load/store exception handler is
enabled because such configurations would still raise an exception on
unaligned access through the instruction bus.

Fixes: f29cf77609cc ("xtensa: add load/store exception handler")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/align.S | 34 ++++++++++++++--------------------
 arch/xtensa/kernel/traps.c |  3 ++-
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/xtensa/kernel/align.S b/arch/xtensa/kernel/align.S
index 20d6b4961001..ee97edce2300 100644
--- a/arch/xtensa/kernel/align.S
+++ b/arch/xtensa/kernel/align.S
@@ -1,7 +1,7 @@
 /*
  * arch/xtensa/kernel/align.S
  *
- * Handle unalignment exceptions in kernel space.
+ * Handle unalignment and load/store exceptions.
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file "COPYING" in the main directory of
@@ -26,20 +26,18 @@
 #define LOAD_EXCEPTION_HANDLER
 #endif
 
-#if XCHAL_UNALIGNED_STORE_EXCEPTION || defined LOAD_EXCEPTION_HANDLER
+#if XCHAL_UNALIGNED_STORE_EXCEPTION || defined CONFIG_XTENSA_LOAD_STORE
+#define STORE_EXCEPTION_HANDLER
+#endif
+
+#if defined LOAD_EXCEPTION_HANDLER || defined STORE_EXCEPTION_HANDLER
 #define ANY_EXCEPTION_HANDLER
 #endif
 
-#if XCHAL_HAVE_WINDOWED
+#if XCHAL_HAVE_WINDOWED && defined CONFIG_MMU
 #define UNALIGNED_USER_EXCEPTION
 #endif
 
-/*  First-level exception handler for unaligned exceptions.
- *
- *  Note: This handler works only for kernel exceptions.  Unaligned user
- *        access should get a seg fault.
- */
-
 /* Big and little endian 16-bit values are located in
  * different halves of a register.  HWORD_START helps to
  * abstract the notion of extracting a 16-bit value from a
@@ -228,8 +226,6 @@ ENDPROC(fast_load_store)
 #ifdef ANY_EXCEPTION_HANDLER
 ENTRY(fast_unaligned)
 
-#if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
-
 	call0	.Lsave_and_load_instruction
 
 	/* Analyze the instruction (load or store?). */
@@ -244,8 +240,7 @@ ENTRY(fast_unaligned)
 	/* 'store indicator bit' not set, jump */
 	_bbci.l	a4, OP1_SI_BIT + INSN_OP1, .Lload
 
-#endif
-#if XCHAL_UNALIGNED_STORE_EXCEPTION
+#ifdef STORE_EXCEPTION_HANDLER
 
 	/* Store: Jump to table entry to get the value in the source register.*/
 
@@ -254,7 +249,7 @@ ENTRY(fast_unaligned)
 	addx8	a5, a6, a5
 	jx	a5			# jump into table
 #endif
-#if XCHAL_UNALIGNED_LOAD_EXCEPTION
+#ifdef LOAD_EXCEPTION_HANDLER
 
 	/* Load: Load memory address. */
 
@@ -328,7 +323,7 @@ ENTRY(fast_unaligned)
 	mov	a14, a3		;	_j .Lexit;	.align 8
 	mov	a15, a3		;	_j .Lexit;	.align 8
 #endif
-#if XCHAL_UNALIGNED_STORE_EXCEPTION
+#ifdef STORE_EXCEPTION_HANDLER
 .Lstore_table:
 	l32i	a3, a2, PT_AREG0;	_j .Lstore_w;	.align 8
 	mov	a3, a1;			_j .Lstore_w;	.align 8	# fishy??
@@ -348,7 +343,6 @@ ENTRY(fast_unaligned)
 	mov	a3, a15		;	_j .Lstore_w;	.align 8
 #endif
 
-#ifdef ANY_EXCEPTION_HANDLER
 	/* We cannot handle this exception. */
 
 	.extern _kernel_exception
@@ -377,8 +371,8 @@ ENTRY(fast_unaligned)
 
 2:	movi	a0, _user_exception
 	jx	a0
-#endif
-#if XCHAL_UNALIGNED_STORE_EXCEPTION
+
+#ifdef STORE_EXCEPTION_HANDLER
 
 	# a7: instruction pointer, a4: instruction, a3: value
 .Lstore_w:
@@ -444,7 +438,7 @@ ENTRY(fast_unaligned)
 	s32i	a6, a4, 4
 #endif
 #endif
-#ifdef ANY_EXCEPTION_HANDLER
+
 .Lexit:
 #if XCHAL_HAVE_LOOPS
 	rsr	a4, lend		# check if we reached LEND
@@ -539,7 +533,7 @@ ENTRY(fast_unaligned)
 	__src_b	a4, a4, a5	# a4 has the instruction
 
 	ret
-#endif
+
 ENDPROC(fast_unaligned)
 
 ENTRY(fast_unaligned_fixup)
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 17eb180eff7c..427c125a137a 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -102,7 +102,8 @@ static dispatch_init_table_t __initdata dispatch_init_table[] = {
 #endif
 { EXCCAUSE_INTEGER_DIVIDE_BY_ZERO, 0,	   do_div0 },
 /* EXCCAUSE_PRIVILEGED unhandled */
-#if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
+#if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION || \
+		IS_ENABLED(CONFIG_XTENSA_LOAD_STORE)
 #ifdef CONFIG_XTENSA_UNALIGNED_USER
 { EXCCAUSE_UNALIGNED,		USER,	   fast_unaligned },
 #endif
-- 
2.30.2

