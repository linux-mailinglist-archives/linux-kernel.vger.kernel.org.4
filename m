Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3C46055F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiJTD1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJTD1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:27:08 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B216E286
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:27:07 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w74so21543011oie.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrTrr/AbOZpQ6QHnwNWQS/WlfAPQBvIDtPQnyjJ/xrI=;
        b=Z2p3UItqZ5oQssgEbNAIUAQcyChFU6Ml9yFLtFvHDFLBras8kWTXQ5dvU7auQrQ+rA
         7PIwcACmz41UbdFXofMB5rrPDDEFtZgk9KdMeaJAC9LyGgoJby/sn5m4NUgSH9vFndSn
         QYwd7Ylrztp+ax2tVGAKKBD1PWZlBE825Y+QCoSIP+cEPfrSqXVZMgvDDw4wiPFjyH4j
         glCgMR5tkbI/tpImqb5yJWYbeabrIpwQfcpJa8zRYpNl9ob3mmz7HH/D6Gm5DNFK68DI
         WOsoEECAZ4qpFSyFBGcnDIuXZxOuKPmqvmWRy4ODGcaKVg5tLgznlUbdrnKWaXWBlpw+
         kfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrTrr/AbOZpQ6QHnwNWQS/WlfAPQBvIDtPQnyjJ/xrI=;
        b=vlLIXnFigxcI5maVx8KgH5aM/EA3s/kWQPoG0JaBEdRTRw6d3C4QfFt8mX+x4V5Cwt
         szYya+RtimUuAqL+17blWP8VB4szWnc6GuLqqCNVbINZ0RlrPYxz65VuRzy6yCuuNcVo
         mh2NrItk4MsvdcFqXUWvK8KEbJgq6vtZM5inmBC8df8m3mCyuOyhYVNiK5FyHue+4y/V
         E94ccyb4w82X8+f1SbOe6nEE8D/oQLpBvMdUvS54Pyzkras/rNJG9+nS+iXeMcjtGFcL
         x1d+cUuMGK3S+TAkcuZjifzWTtwkMZkmT2CIv+78OFSFrQejEMitSDioBYSSqqtMe+lt
         mYAg==
X-Gm-Message-State: ACrzQf1NdhZAUi1GNe5QJuTIpXdy5tC4mqmaLuEN0h4mHDHFJwaXqLq0
        lGlciQ6mn/P4AFb8/68rVIQ=
X-Google-Smtp-Source: AMsMyM7eB9Y0BQM2stTC+vPJTidAiabmFHMNHba1bGRtSr0BlTQZA5SaIvTQAZgi0swIcZDHavN1yA==
X-Received: by 2002:a05:6808:1587:b0:355:3525:8ed with SMTP id t7-20020a056808158700b00355352508edmr6340031oiw.153.1666236426316;
        Wed, 19 Oct 2022 20:27:06 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id x17-20020a056830245100b006393ea22c1csm7642057otr.16.2022.10.19.20.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 20:27:05 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/2] arm: drop arch implementation for find_bit() functions
Date:   Wed, 19 Oct 2022 20:20:24 -0700
Message-Id: <20221020032024.1804535-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221020032024.1804535-1-yury.norov@gmail.com>
References: <20221020032024.1804535-1-yury.norov@gmail.com>
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

Generic code works on par with arch or better, according to my
testing, and with recent improvements merged in v6.1, it should
be even faster.

ARM already uses many generic find_bit() functions - those that it
doesn't implement. So we are talking about migrating a subset of the
API; most of find_bit() family has only generic implementation on ARM.

This patch switches ARM to generic find_bit() entirely.

CC: Guenter Roeck <linux@roeck-us.net>
CC: Dennis Zhou <dennis@kernel.org>
CC: Russell King <linux@armlinux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: linux-arm-kernel@lists.infradead.org
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/arm/include/asm/bitops.h |  63 -----------
 arch/arm/kernel/armksyms.c    |  11 --
 arch/arm/lib/Makefile         |   2 +-
 arch/arm/lib/findbit.S        | 193 ----------------------------------
 4 files changed, 1 insertion(+), 268 deletions(-)
 delete mode 100644 arch/arm/lib/findbit.S

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 714440fa2fc6..23a7cde3422e 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -157,24 +157,6 @@ extern int _test_and_set_bit(int nr, volatile unsigned long * p);
 extern int _test_and_clear_bit(int nr, volatile unsigned long * p);
 extern int _test_and_change_bit(int nr, volatile unsigned long * p);
 
-/*
- * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
- */
-unsigned long _find_first_zero_bit_le(const unsigned long *p, unsigned long size);
-unsigned long _find_next_zero_bit_le(const unsigned long *p,
-				     unsigned long size, unsigned long offset);
-unsigned long _find_first_bit_le(const unsigned long *p, unsigned long size);
-unsigned long _find_next_bit_le(const unsigned long *p, unsigned long size, unsigned long offset);
-
-/*
- * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
- */
-unsigned long _find_first_zero_bit_be(const unsigned long *p, unsigned long size);
-unsigned long _find_next_zero_bit_be(const unsigned long *p,
-				     unsigned long size, unsigned long offset);
-unsigned long _find_first_bit_be(const unsigned long *p, unsigned long size);
-unsigned long _find_next_bit_be(const unsigned long *p, unsigned long size, unsigned long offset);
-
 #ifndef CONFIG_SMP
 /*
  * The __* form of bitops are non-atomic and may be reordered.
@@ -195,26 +177,6 @@ unsigned long _find_next_bit_be(const unsigned long *p, unsigned long size, unsi
 #define test_and_clear_bit(nr,p)	ATOMIC_BITOP(test_and_clear_bit,nr,p)
 #define test_and_change_bit(nr,p)	ATOMIC_BITOP(test_and_change_bit,nr,p)
 
-#ifndef __ARMEB__
-/*
- * These are the little endian, atomic definitions.
- */
-#define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
-#define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
-#define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
-#define find_next_bit(p,sz,off)		_find_next_bit_le(p,sz,off)
-
-#else
-/*
- * These are the big endian, atomic definitions.
- */
-#define find_first_zero_bit(p,sz)	_find_first_zero_bit_be(p,sz)
-#define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_be(p,sz,off)
-#define find_first_bit(p,sz)		_find_first_bit_be(p,sz)
-#define find_next_bit(p,sz,off)		_find_next_bit_be(p,sz,off)
-
-#endif
-
 #if __LINUX_ARM_ARCH__ < 5
 
 #include <asm-generic/bitops/__fls.h>
@@ -237,35 +199,10 @@ unsigned long _find_next_bit_be(const unsigned long *p, unsigned long size, unsi
 #endif
 
 #include <asm-generic/bitops/ffz.h>
-
 #include <asm-generic/bitops/fls64.h>
-
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
-
-#ifdef __ARMEB__
-
-static inline int find_first_zero_bit_le(const void *p, unsigned size)
-{
-	return _find_first_zero_bit_le(p, size);
-}
-#define find_first_zero_bit_le find_first_zero_bit_le
-
-static inline int find_next_zero_bit_le(const void *p, int size, int offset)
-{
-	return _find_next_zero_bit_le(p, size, offset);
-}
-#define find_next_zero_bit_le find_next_zero_bit_le
-
-static inline int find_next_bit_le(const void *p, int size, int offset)
-{
-	return _find_next_bit_le(p, size, offset);
-}
-#define find_next_bit_le find_next_bit_le
-
-#endif
-
 #include <asm-generic/bitops/le.h>
 
 /*
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 82e96ac83684..10130987d388 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -150,17 +150,6 @@ EXPORT_SYMBOL(_clear_bit);
 EXPORT_SYMBOL(_test_and_clear_bit);
 EXPORT_SYMBOL(_change_bit);
 EXPORT_SYMBOL(_test_and_change_bit);
-EXPORT_SYMBOL(_find_first_zero_bit_le);
-EXPORT_SYMBOL(_find_next_zero_bit_le);
-EXPORT_SYMBOL(_find_first_bit_le);
-EXPORT_SYMBOL(_find_next_bit_le);
-
-#ifdef __ARMEB__
-EXPORT_SYMBOL(_find_first_zero_bit_be);
-EXPORT_SYMBOL(_find_next_zero_bit_be);
-EXPORT_SYMBOL(_find_first_bit_be);
-EXPORT_SYMBOL(_find_next_bit_be);
-#endif
 
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(__gnu_mcount_nc);
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 6d2ba454f25b..8b152b1a3014 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -7,7 +7,7 @@
 
 lib-y		:= changebit.o csumipv6.o csumpartial.o               \
 		   csumpartialcopy.o csumpartialcopyuser.o clearbit.o \
-		   delay.o delay-loop.o findbit.o memchr.o memcpy.o   \
+		   delay.o delay-loop.o memchr.o memcpy.o             \
 		   memmove.o memset.o setbit.o                        \
 		   strchr.o strrchr.o                                 \
 		   testchangebit.o testclearbit.o testsetbit.o        \
diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
deleted file mode 100644
index 7fd3600db8ef..000000000000
--- a/arch/arm/lib/findbit.S
+++ /dev/null
@@ -1,193 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  linux/arch/arm/lib/findbit.S
- *
- *  Copyright (C) 1995-2000 Russell King
- *
- * 16th March 2001 - John Ripley <jripley@sonicblue.com>
- *   Fixed so that "size" is an exclusive not an inclusive quantity.
- *   All users of these functions expect exclusive sizes, and may
- *   also call with zero size.
- * Reworked by rmk.
- */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-                .text
-
-/*
- * Purpose  : Find a 'zero' bit
- * Prototype: int find_first_zero_bit(void *addr, unsigned int maxbit);
- */
-ENTRY(_find_first_zero_bit_le)
-		teq	r1, #0	
-		beq	3f
-		mov	r2, #0
-1:
- ARM(		ldrb	r3, [r0, r2, lsr #3]	)
- THUMB(		lsr	r3, r2, #3		)
- THUMB(		ldrb	r3, [r0, r3]		)
-		eors	r3, r3, #0xff		@ invert bits
-		bne	.L_found		@ any now set - found zero bit
-		add	r2, r2, #8		@ next bit pointer
-2:		cmp	r2, r1			@ any more?
-		blo	1b
-3:		mov	r0, r1			@ no free bits
-		ret	lr
-ENDPROC(_find_first_zero_bit_le)
-
-/*
- * Purpose  : Find next 'zero' bit
- * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
- */
-ENTRY(_find_next_zero_bit_le)
-		cmp	r2, r1
-		bhs	3b
-		ands	ip, r2, #7
-		beq	1b			@ If new byte, goto old routine
- ARM(		ldrb	r3, [r0, r2, lsr #3]	)
- THUMB(		lsr	r3, r2, #3		)
- THUMB(		ldrb	r3, [r0, r3]		)
-		eor	r3, r3, #0xff		@ now looking for a 1 bit
-		movs	r3, r3, lsr ip		@ shift off unused bits
-		bne	.L_found
-		orr	r2, r2, #7		@ if zero, then no bits here
-		add	r2, r2, #1		@ align bit pointer
-		b	2b			@ loop for next bit
-ENDPROC(_find_next_zero_bit_le)
-
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
-
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
-
-#ifdef __ARMEB__
-
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
-
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
-
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
-
-#endif
-
-/*
- * One or more bits in the LSB of r3 are assumed to be set.
- */
-.L_found:
-#if __LINUX_ARM_ARCH__ >= 5
-		rsb	r0, r3, #0
-		and	r3, r3, r0
-		clz	r3, r3
-		rsb	r3, r3, #31
-		add	r0, r2, r3
-#else
-		tst	r3, #0x0f
-		addeq	r2, r2, #4
-		movne	r3, r3, lsl #4
-		tst	r3, #0x30
-		addeq	r2, r2, #2
-		movne	r3, r3, lsl #2
-		tst	r3, #0x40
-		addeq	r2, r2, #1
-		mov	r0, r2
-#endif
-		cmp	r1, r0			@ Clamp to maxbit
-		movlo	r0, r1
-		ret	lr
-
-- 
2.34.1

