Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D80272F3CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242159AbjFNEwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjFNEw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:52:26 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796E311B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:52:25 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b1576c2f6eso4003419a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686718344; x=1689310344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnBq6jRAi07bdIevMbcQiNQG6VP5ua0fb3T92QcFjPs=;
        b=q4Qd2GriVxvaFyVITi6RJ6+CVtI4pvoQ+jKl6u4SGlIskewJ9JwJGVynq4S10NA8Em
         lJgfr1wErvaPDDB/JUzRIBCMLLtEYLq2LgksDSz/6cFxC2sqT/5WvlcoBXn+VoIDmkUy
         a46SOnH3Kf9TyfnaSHLiD2l2eMIbdZjABJgpLgKCDfBI/oaJf629gRdZdOVNEkAHr6f0
         yQNolxLyzUb9IISIPk5P78vglcFDxTmGG1gCmA7I3hskveftmQbQMYQ7DIPtrT/xnVqL
         NrVx1mcNcvUKkHLPoW4fmQDxne0kKPYPlGUC0dbvjcSKQpDheb23T56H3iSCC5ez6fB5
         gYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686718344; x=1689310344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnBq6jRAi07bdIevMbcQiNQG6VP5ua0fb3T92QcFjPs=;
        b=PknN9UrcfKH8OzXT/FYLOHZjGAOhMsD1OYYep882V5bWjUUG6WXi3vWqPlcbU/WACL
         earnYqvUCFtD/MZtz20oEHffn87QR3j1fDBLQ83ll8OklOQTxuqoKriLTrSQyczJQBUr
         c50R+ByAsSRI1hFu5bKe+Iph/Qicf0qwTIbEqM5vmzA+8iypcJWDa27PVPjhMEQmTPik
         a5MiZxvI4LgCiEhxI16UwFkUUZC5rehlc69RqVPhZH7/UJ0KJPlC7rAHGCQ6iG/iYIH/
         SzFrhPuXykSZvIkYVqV57fqnju1yLyXpk4w7cjIiRtzL2Qd+vMuVhJhX49YX+O1eltl+
         Ttpg==
X-Gm-Message-State: AC+VfDwMj4US1co++ZLUmJe1slsAFGWuPGLfOnCh5WM4lm0iQp6heLjO
        NLBnNtt/BR+xbrXIZliE8c6S0EXHtws=
X-Google-Smtp-Source: ACHHUZ7ae3Pc0xmODe/TffboxokkoxTPNjl6VyUFO+mUXpSZA2OspvwRsDftsbOM4xStclTKVsOqJQ==
X-Received: by 2002:a05:6358:cb13:b0:129:c374:5f82 with SMTP id gr19-20020a056358cb1300b00129c3745f82mr7663211rwb.21.1686718344324;
        Tue, 13 Jun 2023 21:52:24 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:bf5f:2e99:78f2:6007])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001acad86ebc5sm11089790plg.33.2023.06.13.21.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 21:52:24 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/4] xtensa: rearrange unaligned exception handler
Date:   Tue, 13 Jun 2023 21:52:11 -0700
Message-Id: <20230614045212.2534746-4-jcmvbkbc@gmail.com>
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

- extract initialization part of the exception handler into a separate
  function.
- use single label for invalid instruction instead of two labels, one
  for load and one for store, at one place.
- use sext instruction for sign extension when available.
- store SAR on the stack instead of in a0.
- replace numeric labels for load and store writeback with .Lload_w and
  .Lstore_w respectively.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/align.S | 171 +++++++++++++++++++------------------
 1 file changed, 89 insertions(+), 82 deletions(-)

diff --git a/arch/xtensa/kernel/align.S b/arch/xtensa/kernel/align.S
index d062c732ef18..bcbd7962a684 100644
--- a/arch/xtensa/kernel/align.S
+++ b/arch/xtensa/kernel/align.S
@@ -157,58 +157,7 @@
 	.literal_position
 ENTRY(fast_unaligned)
 
-	/* Note: We don't expect the address to be aligned on a word
-	 *       boundary. After all, the processor generated that exception
-	 *       and it would be a hardware fault.
-	 */
-
-	/* Save some working register */
-
-	s32i	a4, a2, PT_AREG4
-	s32i	a5, a2, PT_AREG5
-	s32i	a6, a2, PT_AREG6
-	s32i	a7, a2, PT_AREG7
-	s32i	a8, a2, PT_AREG8
-
-	rsr	a0, depc
-	s32i	a0, a2, PT_AREG2
-	s32i	a3, a2, PT_AREG3
-
-	rsr	a3, excsave1
-	movi	a4, fast_unaligned_fixup
-	s32i	a4, a3, EXC_TABLE_FIXUP
-
-	/* Keep value of SAR in a0 */
-
-	rsr	a0, sar
-	rsr	a8, excvaddr		# load unaligned memory address
-
-	/* Now, identify one of the following load/store instructions.
-	 *
-	 * The only possible danger of a double exception on the
-	 * following l32i instructions is kernel code in vmalloc
-	 * memory. The processor was just executing at the EPC_1
-	 * address, and indeed, already fetched the instruction.  That
-	 * guarantees a TLB mapping, which hasn't been replaced by
-	 * this unaligned exception handler that uses only static TLB
-	 * mappings. However, high-level interrupt handlers might
-	 * modify TLB entries, so for the generic case, we register a
-	 * TABLE_FIXUP handler here, too.
-	 */
-
-	/* a3...a6 saved on stack, a2 = SP */
-
-	/* Extract the instruction that caused the unaligned access. */
-
-	rsr	a7, epc1	# load exception address
-	movi	a3, ~3
-	and	a3, a3, a7	# mask lower bits
-
-	l32i	a4, a3, 0	# load 2 words
-	l32i	a5, a3, 4
-
-	__ssa8	a7
-	__src_b	a4, a4, a5	# a4 has the instruction
+	call0	.Lsave_and_load_instruction
 
 	/* Analyze the instruction (load or store?). */
 
@@ -249,7 +198,7 @@ ENTRY(fast_unaligned)
 	addi	a7, a7, 2		# increment PC (assume 16-bit insn)
 
 	extui	a5, a4, INSN_OP0, 4
-	_beqi	a5, OP0_L32I_N, 1f	# l32i.n: jump
+	_beqi	a5, OP0_L32I_N, .Lload_w# l32i.n: jump
 
 	addi	a7, a7, 1
 #else
@@ -257,21 +206,24 @@ ENTRY(fast_unaligned)
 #endif
 
 	extui	a5, a4, INSN_OP1, 4
-	_beqi	a5, OP1_L32I, 1f	# l32i: jump
+	_beqi	a5, OP1_L32I, .Lload_w	# l32i: jump
 
 	extui	a3, a3, 0, 16		# extract lower 16 bits
-	_beqi	a5, OP1_L16UI, 1f
+	_beqi	a5, OP1_L16UI, .Lload_w
 	addi	a5, a5, -OP1_L16SI
-	_bnez	a5, .Linvalid_instruction_load
+	_bnez	a5, .Linvalid_instruction
 
 	/* sign extend value */
-
+#if XCHAL_HAVE_SEXT
+	sext	a3, a3, 15
+#else
 	slli	a3, a3, 16
 	srai	a3, a3, 16
+#endif
 
 	/* Set target register. */
 
-1:
+.Lload_w:
 	extui	a4, a4, INSN_T, 4	# extract target register
 	movi	a5, .Lload_table
 	addx8	a4, a4, a5
@@ -297,28 +249,27 @@ ENTRY(fast_unaligned)
 	mov	a15, a3		;	_j .Lexit;	.align 8
 
 .Lstore_table:
-	l32i	a3, a2, PT_AREG0;	_j 1f;	.align 8
-	mov	a3, a1;			_j 1f;	.align 8	# fishy??
-	l32i	a3, a2, PT_AREG2;	_j 1f;	.align 8
-	l32i	a3, a2, PT_AREG3;	_j 1f;	.align 8
-	l32i	a3, a2, PT_AREG4;	_j 1f;	.align 8
-	l32i	a3, a2, PT_AREG5;	_j 1f;	.align 8
-	l32i	a3, a2, PT_AREG6;	_j 1f;	.align 8
-	l32i	a3, a2, PT_AREG7;	_j 1f;	.align 8
-	l32i	a3, a2, PT_AREG8;	_j 1f;	.align 8
-	mov	a3, a9		;	_j 1f;	.align 8
-	mov	a3, a10		;	_j 1f;	.align 8
-	mov	a3, a11		;	_j 1f;	.align 8
-	mov	a3, a12		;	_j 1f;	.align 8
-	mov	a3, a13		;	_j 1f;	.align 8
-	mov	a3, a14		;	_j 1f;	.align 8
-	mov	a3, a15		;	_j 1f;	.align 8
+	l32i	a3, a2, PT_AREG0;	_j .Lstore_w;	.align 8
+	mov	a3, a1;			_j .Lstore_w;	.align 8	# fishy??
+	l32i	a3, a2, PT_AREG2;	_j .Lstore_w;	.align 8
+	l32i	a3, a2, PT_AREG3;	_j .Lstore_w;	.align 8
+	l32i	a3, a2, PT_AREG4;	_j .Lstore_w;	.align 8
+	l32i	a3, a2, PT_AREG5;	_j .Lstore_w;	.align 8
+	l32i	a3, a2, PT_AREG6;	_j .Lstore_w;	.align 8
+	l32i	a3, a2, PT_AREG7;	_j .Lstore_w;	.align 8
+	l32i	a3, a2, PT_AREG8;	_j .Lstore_w;	.align 8
+	mov	a3, a9		;	_j .Lstore_w;	.align 8
+	mov	a3, a10		;	_j .Lstore_w;	.align 8
+	mov	a3, a11		;	_j .Lstore_w;	.align 8
+	mov	a3, a12		;	_j .Lstore_w;	.align 8
+	mov	a3, a13		;	_j .Lstore_w;	.align 8
+	mov	a3, a14		;	_j .Lstore_w;	.align 8
+	mov	a3, a15		;	_j .Lstore_w;	.align 8
 
 	/* We cannot handle this exception. */
 
 	.extern _kernel_exception
-.Linvalid_instruction_load:
-.Linvalid_instruction_store:
+.Linvalid_instruction:
 
 	movi	a4, 0
 	rsr	a3, excsave1
@@ -326,6 +277,7 @@ ENTRY(fast_unaligned)
 
 	/* Restore a4...a8 and SAR, set SP, and jump to default exception. */
 
+	l32i	a0, a2, PT_SAR
 	l32i	a8, a2, PT_AREG8
 	l32i	a7, a2, PT_AREG7
 	l32i	a6, a2, PT_AREG6
@@ -343,8 +295,8 @@ ENTRY(fast_unaligned)
 2:	movi	a0, _user_exception
 	jx	a0
 
-1: 	# a7: instruction pointer, a4: instruction, a3: value
-
+	# a7: instruction pointer, a4: instruction, a3: value
+.Lstore_w:
 	movi	a6, 0			# mask: ffffffff:00000000
 
 #if XCHAL_HAVE_DENSITY
@@ -361,7 +313,7 @@ ENTRY(fast_unaligned)
 
 	extui	a5, a4, INSN_OP1, 4	# extract OP1
 	_beqi	a5, OP1_S32I, 1f	# jump if 32 bit store
-	_bnei	a5, OP1_S16I, .Linvalid_instruction_store
+	_bnei	a5, OP1_S16I, .Linvalid_instruction
 
 	movi	a5, -1
 	__extl	a3, a3			# get 16-bit value
@@ -434,6 +386,7 @@ ENTRY(fast_unaligned)
 
 	/* Restore working register */
 
+	l32i	a0, a2, PT_SAR
 	l32i	a8, a2, PT_AREG8
 	l32i	a7, a2, PT_AREG7
 	l32i	a6, a2, PT_AREG6
@@ -448,6 +401,59 @@ ENTRY(fast_unaligned)
 	l32i	a2, a2, PT_AREG2
 	rfe
 
+	.align	4
+.Lsave_and_load_instruction:
+
+	/* Save some working register */
+
+	s32i	a3, a2, PT_AREG3
+	s32i	a4, a2, PT_AREG4
+	s32i	a5, a2, PT_AREG5
+	s32i	a6, a2, PT_AREG6
+	s32i	a7, a2, PT_AREG7
+	s32i	a8, a2, PT_AREG8
+
+	rsr	a4, depc
+	s32i	a4, a2, PT_AREG2
+
+	rsr	a5, sar
+	s32i	a5, a2, PT_SAR
+
+	rsr	a3, excsave1
+	movi	a4, fast_unaligned_fixup
+	s32i	a4, a3, EXC_TABLE_FIXUP
+
+	rsr	a8, excvaddr		# load unaligned memory address
+
+	/* Now, identify one of the following load/store instructions.
+	 *
+	 * The only possible danger of a double exception on the
+	 * following l32i instructions is kernel code in vmalloc
+	 * memory. The processor was just executing at the EPC_1
+	 * address, and indeed, already fetched the instruction.  That
+	 * guarantees a TLB mapping, which hasn't been replaced by
+	 * this unaligned exception handler that uses only static TLB
+	 * mappings. However, high-level interrupt handlers might
+	 * modify TLB entries, so for the generic case, we register a
+	 * TABLE_FIXUP handler here, too.
+	 */
+
+	/* a3...a6 saved on stack, a2 = SP */
+
+	/* Extract the instruction that caused the unaligned access. */
+
+	rsr	a7, epc1	# load exception address
+	movi	a3, ~3
+	and	a3, a3, a7	# mask lower bits
+
+	l32i	a4, a3, 0	# load 2 words
+	l32i	a5, a3, 4
+
+	__ssa8	a7
+	__src_b	a4, a4, a5	# a4 has the instruction
+
+	ret
+
 ENDPROC(fast_unaligned)
 
 ENTRY(fast_unaligned_fixup)
@@ -459,10 +465,11 @@ ENTRY(fast_unaligned_fixup)
 	l32i	a7, a2, PT_AREG7
 	l32i	a6, a2, PT_AREG6
 	l32i	a5, a2, PT_AREG5
-	l32i	a4, a2, PT_AREG4
+	l32i	a4, a2, PT_SAR
 	l32i	a0, a2, PT_AREG2
-	xsr	a0, depc			# restore depc and a0
-	wsr	a0, sar
+	wsr	a4, sar
+	wsr	a0, depc			# restore depc and a0
+	l32i	a4, a2, PT_AREG4
 
 	rsr	a0, exccause
 	s32i	a0, a2, PT_DEPC			# mark as a regular exception
-- 
2.30.2

