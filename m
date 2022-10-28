Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B313611802
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiJ1Qse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiJ1QsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:48:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FBB20FB25
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=awLfhDYQKzr/5OLyGPM7CZguAgBNbZFtXaI32A3EvdI=; b=CO64jMczJw9bQw0Y3YstvDrriM
        M+W8fedhsaHxOfUSNWbJRsCBF9rAcxapIXf0Q+k955dpSOJDszQvU5HVXUWsWrkqzWJPK/g+/1k1i
        Z/3VObBwbMlz4Lj+7cCoKw3nsxnl7kWr15DLtET6C/fi3XOKJMgvZy5cHD1dz6pPzhukAgG/TZBMO
        x8EinmXLmk2YovZTrFKXEMB1CwzP1DSWAKLqosYnUJ4EBn10Efc57gXrVpn2e2HqO12vEjSyeu3zt
        Gfl/JjOzUvA9f27nbL2i0gtTAz5259q+dubis4/J1EQZQqAkFhxMBc7SgruCIV5YHCukHdTjHpZAJ
        BB0OGYoA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33794 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ooSWf-000073-2Y; Fri, 28 Oct 2022 17:48:09 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1ooSWe-000FEG-G7; Fri, 28 Oct 2022 17:48:08 +0100
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
Subject: [PATCH 4/5] ARM: findbit: operate by words
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ooSWe-000FEG-G7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 28 Oct 2022 17:48:08 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the implementations to operate on words rather than bytes
which makes bitmap searching faster.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/assembler.h |  6 +++
 arch/arm/lib/findbit.S           | 78 ++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 90fbe4a3f9c8..28e18f79c300 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -761,6 +761,12 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.endif
 	.endm
 
+	.if		__LINUX_ARM_ARCH__ < 6
+	.set		.Lrev_l_uses_tmp, 1
+	.else
+	.set		.Lrev_l_uses_tmp, 0
+	.endif
+
 	/*
 	 * bl_r - branch and link to register
 	 *
diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 8280f66d38a5..6ec584d16d46 100644
--- a/arch/arm/lib/findbit.S
+++ b/arch/arm/lib/findbit.S
@@ -14,32 +14,32 @@
 #include <asm/assembler.h>
                 .text
 
+#ifdef __ARMEB__
+#define SWAB_ENDIAN le
+#else
+#define SWAB_ENDIAN be
+#endif
+
 		.macro	find_first, endian, set, name
 ENTRY(_find_first_\name\()bit_\endian)
 		teq	r1, #0
 		beq	3f
 		mov	r2, #0
-1:
-		.ifc	\endian, be
-		eor	r3, r2, #0x18
- ARM(		ldrb	r3, [r0, r3, lsr #3]	)
- THUMB(		lsr	r3, #3			)
- THUMB(		ldrb	r3, [r0, r3]		)
+1:		ldr	r3, [r0], #4
+		.ifeq \set
+		mvns	r3, r3			@ invert/test bits
 		.else
- ARM(		ldrb	r3, [r0, r2, lsr #3]	)
- THUMB(		lsr	r3, r2, #3		)
- THUMB(		ldrb	r3, [r0, r3]		)
+		movs	r3, r3			@ test bits
 		.endif
-		.ifeq	\set
-		eors	r3, r3, #0xff		@ invert bits
+		.ifc \endian, SWAB_ENDIAN
+		bne	.L_found_swab
 		.else
-		movs	r3, r3
+		bne	.L_found		@ found the bit?
 		.endif
-		bne	.L_found		@ any now set - found zero bit
-		add	r2, r2, #8		@ next bit pointer
+		add	r2, r2, #32		@ next index
 2:		cmp	r2, r1			@ any more?
 		blo	1b
-3:		mov	r0, r1			@ no free bits
+3:		mov	r0, r1			@ no more bits
 		ret	lr
 ENDPROC(_find_first_\name\()bit_\endian)
 		.endm
@@ -48,24 +48,25 @@ ENDPROC(_find_first_\name\()bit_\endian)
 ENTRY(_find_next_\name\()bit_\endian)
 		cmp	r2, r1
 		bhs	3b
-		ands	ip, r2, #7
-		beq	1b			@ If new byte, goto old routine
-		.ifc	\endian, be
-		eor	r3, r2, #0x18
- ARM(		ldrb	r3, [r0, r3, lsr #3]	)
- THUMB(		lsr	r3, #3			)
- THUMB(		ldrb	r3, [r0, r3]		)
-		.else
- ARM(		ldrb	r3, [r0, r2, lsr #3]	)
- THUMB(		lsr	r3, r2, #3		)
- THUMB(		ldrb	r3, [r0, r3]		)
+		mov	ip, r2, lsr #5		@ word index
+		add	r0, r0, ip, lsl #2
+		ands	ip, r2, #31		@ bit position
+		beq	1b
+		ldr	r3, [r0], #4
+		.ifeq \set
+		mvn	r3, r3			@ invert bits
+		.endif
+		.ifc \endian, SWAB_ENDIAN
+		rev_l	r3, ip
+		.if	.Lrev_l_uses_tmp
+		@ we need to recompute ip because rev_l will have overwritten
+		@ it.
+		and	ip, r2, #31		@ bit position
 		.endif
-		.ifeq	\set
-		eor	r3, r3, #0xff		@ now looking for a 1 bit
 		.endif
 		movs	r3, r3, lsr ip		@ shift off unused bits
 		bne	.L_found
-		orr	r2, r2, #7		@ if zero, then no bits here
+		orr	r2, r2, #31		@ no zero bits
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
 ENDPROC(_find_next_\name\()bit_\endian)
@@ -95,6 +96,8 @@ ENDPROC(_find_next_\name\()bit_\endian)
 /*
  * One or more bits in the LSB of r3 are assumed to be set.
  */
+.L_found_swab:
+		rev_l	r3, ip
 .L_found:
 #if __LINUX_ARM_ARCH__ >= 7
 		rbit	r3, r3			@ reverse bits
@@ -107,13 +110,20 @@ ENDPROC(_find_next_\name\()bit_\endian)
 		rsb	r3, r3, #31		@ offset of first set bit
 		add	r0, r2, r3		@ add offset of first set bit
 #else
-		tst	r3, #0x0f
+		mov	ip, #~0
+		tst	r3, ip, lsr #16		@ test bits 0-15
+		addeq	r2, r2, #16
+		moveq	r3, r3, lsr #16
+		tst	r3, #0x00ff
+		addeq	r2, r2, #8
+		moveq	r3, r3, lsr #8
+		tst	r3, #0x000f
 		addeq	r2, r2, #4
-		movne	r3, r3, lsl #4
-		tst	r3, #0x30
+		moveq	r3, r3, lsr #4
+		tst	r3, #0x0003
 		addeq	r2, r2, #2
-		movne	r3, r3, lsl #2
-		tst	r3, #0x40
+		moveq	r3, r3, lsr #2
+		tst	r3, #0x0001
 		addeq	r2, r2, #1
 		mov	r0, r2
 #endif
-- 
2.30.2

