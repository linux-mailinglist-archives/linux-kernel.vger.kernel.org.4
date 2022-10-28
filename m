Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE496117FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJ1QsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJ1QsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:48:08 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294F120DB74
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WkDjf+3IQgCyMglzhEzUvxitZ2xNrXhv5I3AR6iDziY=; b=M/Gbjsk9bvCVCw0Chxu+P8YgKs
        GaYtSL13ilKICTNDPb8tJ4/atXRKoeph3SLC8sixyssIPvIoQcXbbHQBdHo9xHp2tuikvozlov+QS
        U4g9MXMyB6nFkk6GRR7Sy4LQAswi9CxnUr+cwup5sG4I1qwIbjrd8y9nA5xcAXk4TZ4Zq5jCZoW4A
        Wz9uHo+PTHBsoXU2wnS8pkctAY1FZUYMdsErxsA8sn4NYeN8NaPsMxQCRgM5AVmHmhbuZGzfEpDaV
        AaseJ2fuTdmFPu1WTp5Z+WDeF5Bp26fgtkJGzTsl4R5/KQD7WQXJihwKRmvQOpg5tcnAgtAChjsu6
        z9qUjezw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33780 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ooSWZ-00006s-W3; Fri, 28 Oct 2022 17:48:04 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1ooSWZ-000FEA-CU; Fri, 28 Oct 2022 17:48:03 +0100
In-Reply-To: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] ARM: findbit: convert to macros
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ooSWZ-000FEA-CU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 28 Oct 2022 17:48:03 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the pairs of _find_first and _find_next functions are pretty
similar, use macros to generate this code. This commit does not
change the generated code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/lib/findbit.S | 158 +++++++++++------------------------------
 1 file changed, 42 insertions(+), 116 deletions(-)

diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 256e095d490b..8280f66d38a5 100644
--- a/arch/arm/lib/findbit.S
+++ b/arch/arm/lib/findbit.S
@@ -14,155 +14,81 @@
 #include <asm/assembler.h>
                 .text
 
-/*
- * Purpose  : Find a 'zero' bit
- * Prototype: int find_first_zero_bit(void *addr, unsigned int maxbit);
- */
-ENTRY(_find_first_zero_bit_le)
-		teq	r1, #0	
+		.macro	find_first, endian, set, name
+ENTRY(_find_first_\name\()bit_\endian)
+		teq	r1, #0
 		beq	3f
 		mov	r2, #0
 1:
+		.ifc	\endian, be
+		eor	r3, r2, #0x18
+ ARM(		ldrb	r3, [r0, r3, lsr #3]	)
+ THUMB(		lsr	r3, #3			)
+ THUMB(		ldrb	r3, [r0, r3]		)
+		.else
  ARM(		ldrb	r3, [r0, r2, lsr #3]	)
  THUMB(		lsr	r3, r2, #3		)
  THUMB(		ldrb	r3, [r0, r3]		)
+		.endif
+		.ifeq	\set
 		eors	r3, r3, #0xff		@ invert bits
+		.else
+		movs	r3, r3
+		.endif
 		bne	.L_found		@ any now set - found zero bit
 		add	r2, r2, #8		@ next bit pointer
 2:		cmp	r2, r1			@ any more?
 		blo	1b
 3:		mov	r0, r1			@ no free bits
 		ret	lr
-ENDPROC(_find_first_zero_bit_le)
+ENDPROC(_find_first_\name\()bit_\endian)
+		.endm
 
-/*
- * Purpose  : Find next 'zero' bit
- * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
- */
-ENTRY(_find_next_zero_bit_le)
+		.macro	find_next, endian, set, name
+ENTRY(_find_next_\name\()bit_\endian)
 		cmp	r2, r1
 		bhs	3b
 		ands	ip, r2, #7
 		beq	1b			@ If new byte, goto old routine
+		.ifc	\endian, be
+		eor	r3, r2, #0x18
+ ARM(		ldrb	r3, [r0, r3, lsr #3]	)
+ THUMB(		lsr	r3, #3			)
+ THUMB(		ldrb	r3, [r0, r3]		)
+		.else
  ARM(		ldrb	r3, [r0, r2, lsr #3]	)
  THUMB(		lsr	r3, r2, #3		)
  THUMB(		ldrb	r3, [r0, r3]		)
+		.endif
+		.ifeq	\set
 		eor	r3, r3, #0xff		@ now looking for a 1 bit
+		.endif
 		movs	r3, r3, lsr ip		@ shift off unused bits
 		bne	.L_found
 		orr	r2, r2, #7		@ if zero, then no bits here
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
-ENDPROC(_find_next_zero_bit_le)
+ENDPROC(_find_next_\name\()bit_\endian)
+		.endm
 
-/*
- * Purpose  : Find a 'one' bit
- * Prototype: int find_first_bit(const unsigned long *addr, unsigned int maxbit);
- */
-ENTRY(_find_first_bit_le)
-		teq	r1, #0	
-		beq	3f
-		mov	r2, #0
-1:
- ARM(		ldrb	r3, [r0, r2, lsr #3]	)
- THUMB(		lsr	r3, r2, #3		)
- THUMB(		ldrb	r3, [r0, r3]		)
-		movs	r3, r3
-		bne	.L_found		@ any now set - found zero bit
-		add	r2, r2, #8		@ next bit pointer
-2:		cmp	r2, r1			@ any more?
-		blo	1b
-3:		mov	r0, r1			@ no free bits
-		ret	lr
-ENDPROC(_find_first_bit_le)
+		.macro	find_bit, endian, set, name
+		find_first \endian, \set, \name
+		find_next  \endian, \set, \name
+		.endm
 
-/*
- * Purpose  : Find next 'one' bit
- * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
- */
-ENTRY(_find_next_bit_le)
-		cmp	r2, r1
-		bhs	3b
-		ands	ip, r2, #7
-		beq	1b			@ If new byte, goto old routine
- ARM(		ldrb	r3, [r0, r2, lsr #3]	)
- THUMB(		lsr	r3, r2, #3		)
- THUMB(		ldrb	r3, [r0, r3]		)
-		movs	r3, r3, lsr ip		@ shift off unused bits
-		bne	.L_found
-		orr	r2, r2, #7		@ if zero, then no bits here
-		add	r2, r2, #1		@ align bit pointer
-		b	2b			@ loop for next bit
-ENDPROC(_find_next_bit_le)
+/* _find_first_zero_bit_le and _find_next_zero_bit_le */
+		find_bit le, 0, zero_
 
-#ifdef __ARMEB__
+/* _find_first_bit_le and _find_next_bit_le */
+		find_bit le, 1
 
-ENTRY(_find_first_zero_bit_be)
-		teq	r1, #0
-		beq	3f
-		mov	r2, #0
-1:		eor	r3, r2, #0x18		@ big endian byte ordering
- ARM(		ldrb	r3, [r0, r3, lsr #3]	)
- THUMB(		lsr	r3, #3			)
- THUMB(		ldrb	r3, [r0, r3]		)
-		eors	r3, r3, #0xff		@ invert bits
-		bne	.L_found		@ any now set - found zero bit
-		add	r2, r2, #8		@ next bit pointer
-2:		cmp	r2, r1			@ any more?
-		blo	1b
-3:		mov	r0, r1			@ no free bits
-		ret	lr
-ENDPROC(_find_first_zero_bit_be)
+#ifdef __ARMEB__
 
-ENTRY(_find_next_zero_bit_be)
-		cmp	r2, r1
-		bhs	3b
-		ands	ip, r2, #7
-		beq	1b			@ If new byte, goto old routine
-		eor	r3, r2, #0x18		@ big endian byte ordering
- ARM(		ldrb	r3, [r0, r3, lsr #3]	)
- THUMB(		lsr	r3, #3			)
- THUMB(		ldrb	r3, [r0, r3]		)
-		eor	r3, r3, #0xff		@ now looking for a 1 bit
-		movs	r3, r3, lsr ip		@ shift off unused bits
-		bne	.L_found
-		orr	r2, r2, #7		@ if zero, then no bits here
-		add	r2, r2, #1		@ align bit pointer
-		b	2b			@ loop for next bit
-ENDPROC(_find_next_zero_bit_be)
+/* _find_first_zero_bit_be and _find_next_zero_bit_be */
+		find_bit be, 0, zero_
 
-ENTRY(_find_first_bit_be)
-		teq	r1, #0
-		beq	3f
-		mov	r2, #0
-1:		eor	r3, r2, #0x18		@ big endian byte ordering
- ARM(		ldrb	r3, [r0, r3, lsr #3]	)
- THUMB(		lsr	r3, #3			)
- THUMB(		ldrb	r3, [r0, r3]		)
-		movs	r3, r3
-		bne	.L_found		@ any now set - found zero bit
-		add	r2, r2, #8		@ next bit pointer
-2:		cmp	r2, r1			@ any more?
-		blo	1b
-3:		mov	r0, r1			@ no free bits
-		ret	lr
-ENDPROC(_find_first_bit_be)
-
-ENTRY(_find_next_bit_be)
-		cmp	r2, r1
-		bhs	3b
-		ands	ip, r2, #7
-		beq	1b			@ If new byte, goto old routine
-		eor	r3, r2, #0x18		@ big endian byte ordering
- ARM(		ldrb	r3, [r0, r3, lsr #3]	)
- THUMB(		lsr	r3, #3			)
- THUMB(		ldrb	r3, [r0, r3]		)
-		movs	r3, r3, lsr ip		@ shift off unused bits
-		bne	.L_found
-		orr	r2, r2, #7		@ if zero, then no bits here
-		add	r2, r2, #1		@ align bit pointer
-		b	2b			@ loop for next bit
-ENDPROC(_find_next_bit_be)
+/* _find_first_bit_be and _find_next_bit_be */
+		find_bit be, 1
 
 #endif
 
-- 
2.30.2

