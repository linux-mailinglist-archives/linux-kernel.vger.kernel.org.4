Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222C73957D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjFVCXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVCXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:23:15 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9218A1A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:23:13 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b5f362f4beso157146a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687400593; x=1689992593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2t5KAjltcM5MEsffCq+OvNauZAaIEtA44G2Tn8lRMA=;
        b=hs0Gq/uSBcccPWXW2uHShGyCbqTNr5lfgn2C+U7Rgn8MSxTAzH66a7FsgwXqDZCzKx
         FhnThtX55MCK6kQ4g1uIudOlgfLfkj69AajOWTpDRaGaLDLwiD6A61yremIxMUDsKRR9
         0/k9tUY23sOJ2g2FvehpRA5K2CZwBBdM1bF5cS8Q/gisW4jBZbXyeHOdt9kWp4IT/4Bz
         clIoY7qINaNC3C/5QfctLh1Gg4lJzvGY6/7OfnEd17Wk4OLW4oHKXVzFYtolMQCq5xRp
         tOzmlvPucCheWyY6VoY8G1njAqNdc7Uv0YnrsnZN7SsCSGL5ncfnK1cHhY4Nk7dssOcP
         dAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687400593; x=1689992593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2t5KAjltcM5MEsffCq+OvNauZAaIEtA44G2Tn8lRMA=;
        b=gP4dVhAja+S4yTc55IfGdoTXoD8K5BZSzqJkfBRQChxlbO2pC7GXEu2i/upWoHDKpZ
         Qc6wTSOdGqGFIcWce08A9Q+R23dSkWgaM0Qw1j7M2gun/x7cMM1drUDvk1z4w95d+RvP
         hkm0JLWompoiws5xOhg5Pmuf8AIs15VsirHUaegm9CBmca3hyiR/FGZ3pKZsc2V0U/5m
         4RNTp50nuFDfA+3eslt5wEPl9X5YnDKm/uAQEpFrJmOZE/SMMFqZkmroRD+6f4T+kEEa
         fpwZHz/nHzwEBNhKyogGn5EpX8RVNpY0JAL9kgdWbkajsDvs8Vgw9Ec1M9DqoKyTjeiw
         bjjA==
X-Gm-Message-State: AC+VfDy5pKq5+dWJ67lXm+kux/6IQPhL+GzCV5hCmjgfpnkKTL2R3ydj
        IyYTF1SPFev87XSRX9FRETU=
X-Google-Smtp-Source: ACHHUZ5xuQ0EpTo0pYQIl7XVvUVKkvpc4PnJ+XIFTlvdeUeiV51ju2NbVBXzB5xo/V1YXS//k+hFVQ==
X-Received: by 2002:a05:6830:1d5a:b0:6b5:8762:cf6c with SMTP id p26-20020a0568301d5a00b006b58762cf6cmr8876245oth.34.1687400592706;
        Wed, 21 Jun 2023 19:23:12 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id g13-20020a63e60d000000b005307501cfe4sm3718043pgh.44.2023.06.21.19.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:23:12 -0700 (PDT)
Date:   Wed, 21 Jun 2023 19:20:59 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 2/3] linux/bits.h: Add fixed-width GENMASK and BIT macros
Message-ID: <ZJOwC5LIEySpduQJ@yury-ThinkPad>
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509051403.2748545-3-lucas.demarchi@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas, all!

(Thanks, Andy, for pointing to this thread.)

On Mon, May 08, 2023 at 10:14:02PM -0700, Lucas De Marchi wrote:
> Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
> masks for fixed-width types and also the corresponding BIT_U32(),
> BIT_U16() and BIT_U8().

Can you split BIT() and GENMASK() material to separate patches?

> All of those depend on a new "U" suffix added to the integer constant.
> Due to naming clashes it's better to call the macro U32. Since C doesn't
> have a proper suffix for short and char types, the U16 and U18 variants
> just use U32 with one additional check in the BIT_* macros to make
> sure the compiler gives an error when the those types overflow.

I feel like I don't understand the sentence...

> The BIT_U16() and BIT_U8() need the help of GENMASK_INPUT_CHECK(),
> as otherwise they would allow an invalid bit to be passed. Hence
> implement them in include/linux/bits.h rather than together with
> the other BIT* variants.

I don't think it's a good way to go because BIT() belongs to a more basic
level than GENMASK(). Not mentioning possible header dependency issues.
If you need to test against tighter numeric region, I'd suggest to
do the same trick as  GENMASK_INPUT_CHECK() does, but in uapi/linux/const.h
directly. Something like:
        #define _U8(x)		(CONST_GT(U8_MAX, x) + _AC(x, U))

> The following test file is is used to test this:
> 
> 	$ cat mask.c
> 	#include <linux/types.h>
> 	#include <linux/bits.h>
> 
> 	static const u32 a = GENMASK_U32(31, 0);
> 	static const u16 b = GENMASK_U16(15, 0);
> 	static const u8 c = GENMASK_U8(7, 0);
> 	static const u32 x = BIT_U32(31);
> 	static const u16 y = BIT_U16(15);
> 	static const u8 z = BIT_U8(7);
> 
> 	#if FAIL
> 	static const u32 a2 = GENMASK_U32(32, 0);
> 	static const u16 b2 = GENMASK_U16(16, 0);
> 	static const u8 c2 = GENMASK_U8(8, 0);
> 	static const u32 x2 = BIT_U32(32);
> 	static const u16 y2 = BIT_U16(16);
> 	static const u8 z2 = BIT_U8(8);
> 	#endif
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  include/linux/bits.h       | 22 ++++++++++++++++++++++
>  include/uapi/linux/const.h |  2 ++
>  include/vdso/const.h       |  1 +
>  3 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 7c0cf5031abe..ff4786c99b8c 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -42,4 +42,26 @@
>  #define GENMASK_ULL(h, l) \
>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>  
> +#define __GENMASK_U32(h, l) \
> +	(((~U32(0)) - (U32(1) << (l)) + 1) & \
> +	 (~U32(0) >> (32 - 1 - (h))))
> +#define GENMASK_U32(h, l) \
> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U32(h, l))
> +
> +#define __GENMASK_U16(h, l) \
> +	((U32(0xffff) - (U32(1) << (l)) + 1) & \
> +	 (U32(0xffff) >> (16 - 1 - (h))))
> +#define GENMASK_U16(h, l) \
> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U16(h, l))
> +
> +#define __GENMASK_U8(h, l) \
> +	(((U32(0xff)) - (U32(1) << (l)) + 1) & \
> +	 (U32(0xff) >> (8 - 1 - (h))))
> +#define GENMASK_U8(h, l) \
> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U8(h, l))

[...]

I see nothing wrong with fixed-wight versions of GENMASK if it helps
people to write safer code. Can you please in commit message mention
the exact patch(es) that added a bug related to GENMASK() misuse? It
would be easier to advocate the purpose of new API with that in mind.

Regarding implementation - we should avoid copy-pasting in cases
like this. Below is the patch that I boot-tested for x86_64 and
compile-tested for arm64.

It looks less opencoded, and maybe Andy will be less skeptical about
this approach because of less maintenance burden. Please take it if
you like for v2.

Thanks,
Yury

From 39c5b35075df67e7d88644470ca78a3486367c02 Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Wed, 21 Jun 2023 15:27:29 -0700
Subject: [PATCH] bits: introduce fixed-type genmasks

Generalize __GENMASK() to support different types, and implement
fixed-types versions of GENMASK() based on it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitops.h |  1 -
 include/linux/bits.h   | 22 ++++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..1db50c69cfdb 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,7 +15,6 @@
 #  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
 #endif
 
-#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 7c0cf5031abe..cb94128171b2 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -6,6 +6,8 @@
 #include <vdso/bits.h>
 #include <asm/bitsperlong.h>
 
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
+
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
@@ -30,16 +32,16 @@
 #define GENMASK_INPUT_CHECK(h, l) 0
 #endif
 
-#define __GENMASK(h, l) \
-	(((~UL(0)) - (UL(1) << (l)) + 1) & \
-	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
-#define GENMASK(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
+#define __GENMASK(t, h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + \
+	 (((t)~0ULL - ((t)(1) << (l)) + 1) & \
+	 ((t)~0ULL >> (BITS_PER_TYPE(t) - 1 - (h)))))
 
-#define __GENMASK_ULL(h, l) \
-	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
-	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
-#define GENMASK_ULL(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
+#define GENMASK(h, l)		__GENMASK(unsigned long,  h, l)
+#define GENMASK_ULL(h, l)	__GENMASK(unsigned long long, h, l)
+#define GENMASK_U8(h, l)	__GENMASK(u8,  h, l)
+#define GENMASK_U16(h, l)	__GENMASK(u16, h, l)
+#define GENMASK_U32(h, l)	__GENMASK(u32, h, l)
+#define GENMASK_U64(h, l)	__GENMASK(u64, h, l)
 
 #endif	/* __LINUX_BITS_H */
-- 
2.39.2

