Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F49704457
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjEPE3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEPE3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:29:39 -0400
Received: from mail.nsr.re.kr (unknown [210.104.33.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A642709;
        Mon, 15 May 2023 21:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; s=LIY0OQ3MUMW6182UNI14; d=nsr.re.kr; t=1684211263; c=relaxed/relaxed; h=content-type:date:from:message-id:mime-version:subject:to; bh=8QnBe+FmwYhxB58/tqEQzgt9Fguui1fViSCh9RAcyus=; b=xPeeWNy9QffjNcz8KLRYO2d5dUw12D4P7gudo6kDJF3R1KvmIiI9lBslCKPLKEYDbKsrx64upnKj4UyMRLzpQf1YSf8kqMzSfIoNowJIbhmTbWWauCyqjDFd3k65AtwE+/aDAbAIRT9lBKHQI4QyH4o6NjU7crB1lThOc6RsY7zLDOvJkap+yePX8KhuAkQ8f1cvuYRUQoCCMyADRJHJopT86yhYq8Zv0FP4VORtcH14/dmbDaeOfdUN12h8ExToLvvZ2ze7FGW51i/jY3HV7I+CUDuc+R7ewQ4VXwUvFUQEdRHVqiwTSt9KiXJH6vqsLy66hiY8LMyB5avcpWLA0g==
Received: from 210.104.33.70 (nsr.re.kr)
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128 bits))
        by mail.nsr.re.kr with SMTP; Tue, 16 May 2023 13:27:28 +0900
Received: from 192.168.155.188 ([192.168.155.188])
          by mail.nsr.re.kr (Crinity Message Backbone-7.0.1) with SMTP ID 758;
          Tue, 16 May 2023 13:29:16 +0900 (KST)
From:   Dongsoo Lee <letrhee@nsr.re.kr>
To:     'Dave Hansen' <dave.hansen@intel.com>, linux-crypto@vger.kernel.org
Cc:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'Dave Hansen' <dave.hansen@linux.intel.com>, x86@kernel.org,
        "'H. Peter Anvin'" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        'Dongsoo Lee' <letrhee@gmail.com>
References: <20230428110058.1516119-1-letrhee@nsr.re.kr> <20230428110058.1516119-4-letrhee@nsr.re.kr> <f0c77850-f8ca-3e21-2722-1deaae424130@intel.com>
In-Reply-To: <f0c77850-f8ca-3e21-2722-1deaae424130@intel.com>
Subject: RE: [PATCH 3/3] crypto: LEA block cipher AVX2 optimization
Date:   Tue, 16 May 2023 13:29:16 +0900
Message-ID: <000d01d987ae$f9c0ed50$ed42c7f0$@nsr.re.kr>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHK1YbJb9NIiePFBRS96VOevnCZtwHh++F1ApCjMaivVh1lQA==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review and sorry it took me a while to respond.

>> +config CRYPTO_LEA_AVX2
>> +	tristate "Ciphers: LEA with modes: ECB, CBC, CTR, XTS
>> (SSE2/MOVBE/AVX2)"
>> +	select CRYPTO_LEA
>> +	imply CRYPTO_XTS
>> +	imply CRYPTO_CTR
>> +	help
>> +	  LEA cipher algorithm (KS X 3246, ISO/IEC 29192-2:2019)
>> +
>> +	  LEA is one of the standard cryptographic alorithms of
>> +	  the Republic of Korea. It consists of four 32bit word.
> The "four 32bit word" thing is probably not a detail end users care =
about enough to see in Kconfig text.

I am in the process of re-implementing it for LEA cipher and will try to =
improve the description.

>> +	  See:
>> +	  https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
>> +
>> +	  Architecture: x86_64 using:
>> +	  - SSE2 (Streaming SIMD Extensions 2)
>> +	  - MOVBE (Move Data After Swapping Bytes)
>> +	  - AVX2 (Advanced Vector Extensions)
>
>What about i386?  If this is truly 64-bit-only for some reason, it's =
not reflected anywhere that I can see, like having a:
>
>	depends on X86_64
>
>I'm also a _bit_ confused why this has one config option called "_AVX2"
>but that also includes the SSE2 implementation.

As you mentioned, the SIMD optimizations used in this implementation are =
also applicable on i386. The initial support target was for x86_64 =
environments where AVX2 instructions are available, so we ended up with =
an awkward support target, which may need to be changed.
Internally, there is an implementation for i386, and I'll include it in =
the submission.

The LEA 4-way SIMD implementation can be done purely using SSE2 =
commands, but it can also be done a bit faster using `vpunpckldq` (AVX), =
`vpbroadcast` (AVX2), `vpxor` (AVX), etc. In this implementation, 4-way =
encryption is not possible without AVX2. If a future SSE2 implementation =
were to be added, it would be possible to include both a 4-way =
implementation with SSE2 and a 4-way implementation with AVX2.

>> +struct lea_xts_ctx {
>> +	u8 raw_crypt_ctx[sizeof(struct crypto_lea_ctx)] SIMD_ALIGN_ATTR;
>> +	u8 raw_tweak_ctx[sizeof(struct crypto_lea_ctx)] SIMD_ALIGN_ATTR; };
>
>The typing here is a bit goofy.  What's wrong with:
>
>struct lea_xts_ctx {
>	struct crypto_lea_ctx crypt_ctx SIMD_ALIGN_ATTR;
>	struct crypto_lea_ctx lea_ctx   SIMD_ALIGN_ATTR;
>};
>
>?  You end up with the same sized structure but you don't have to cast =
it as much.

This is a mistake I made by just bringing in other code without much =
thought. I'll fix it.

>> +struct _lea_u128 {
>> +	u64 v0, v1;
>> +};
>> +
>> +static inline void xor_1blk(u8 *out, const u8 *in1, const u8 *in2) {
>> +	const struct _lea_u128 *_in1 =3D (const struct _lea_u128 *)in1;
>> +	const struct _lea_u128 *_in2 =3D (const struct _lea_u128 *)in2;
>> +	struct _lea_u128 *_out =3D (struct _lea_u128 *)out;
>> +
>> +	_out->v0 =3D _in1->v0 ^ _in2->v0;
>> +	_out->v1 =3D _in1->v1 ^ _in2->v1;
>> +}
>> +
>> +static inline void xts_next_tweak(u8 *out, const u8 *in) {
>> +	const u64 *_in =3D (const u64 *)in;
>> +	u64 *_out =3D (u64 *)out;
>> +	u64 v0 =3D _in[0];
>> +	u64 v1 =3D _in[1];
>> +	u64 carry =3D (u64)(((s64)v1) >> 63);
>> +
>> +	v1 =3D (v1 << 1) ^ (v0 >> 63);
>> +	v0 =3D (v0 << 1) ^ ((u64)carry & 0x87);
>> +
>> +	_out[0] =3D v0;
>> +	_out[1] =3D v1;
>> +}
>
>I don't really care either way, but it's interesting that in two =
adjacent functions this deals with two adjacent 64-bit values.  In one =
it defines a structure with two u64's and in the next it treats it as an =
array.

I'll unify them in one way.


>> +static int xts_encrypt_8way(struct skcipher_request *req) {
>...
>
>It's kinda a shame that there isn't more code shared here between, for =
instance the 4way and 8way functions.  But I guess this crypto code =
tends to be merged and then very rarely fixed up after.

This is a mistake in implementation: as I mentioned, the code I =
submitted also requires AVX2 for the 4-way implementation, so this is =
unnecessary duplication. I will add a proper SSE2 4-way implementation =
by sharing the code with the 8-way.


>> +static int xts_lea_set_key(struct crypto_skcipher *tfm, const u8 =
*key,
>> +				u32 keylen)
>> +{
>> +	struct crypto_tfm *tfm_ctx =3D crypto_skcipher_ctx(tfm);
>> +	struct lea_xts_ctx *ctx =3D crypto_tfm_ctx(tfm_ctx);
>> +
>> +	struct crypto_lea_ctx *crypt_key =3D
>> +		(struct crypto_lea_ctx *)(ctx->raw_crypt_ctx);
>> +	struct crypto_lea_ctx *tweak_key =3D
>> +		(struct crypto_lea_ctx *)(ctx->raw_tweak_ctx);
>
>These were those goofy casts that can go away if the typing is a bit =
more careful

I'll fix it by redefining `struct lea_xts_ctx`.


>> +static struct simd_skcipher_alg
>> *lea_simd_algs[ARRAY_SIZE(lea_simd_avx2_algs)];
>> +
>> +static int __init crypto_lea_avx2_init(void) {
>> +	const char *feature_name;
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_XMM2)) {
>> +		pr_info("SSE2 instructions are not detected.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_MOVBE)) {
>> +		pr_info("MOVBE instructions are not detected.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_AVX2) ||=20
>> +!boot_cpu_has(X86_FEATURE_AVX))
>> {
>> +		pr_info("AVX2 instructions are not detected.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
>> +				&feature_name)) {
>> +		pr_info("CPU feature '%s' is not supported.\n", feature_name);
>> +		return -ENODEV;
>> +	}
>
>This looks suspect.
>
>It requires that *ALL* of XMM2, MOVBE, AVX, AVX2 and XSAVE support for
>*ANY* of these to be used.  In other cipher code that I've seen, it =
separates out the AVX/YMM acceleration from the pure SSE2/XMM =
acceleration functions so that CPUs with only SSE2 can still benefit.
>
>Either this is wrong, or there is something subtle going on that I'm =
missing.

This is a mistake, as the initial support was implemented for x86_64 =
environments with AVX2 instructions.

Since there are already implementations that support i386 and x86_64, =
SSE2, SSE2 and MOVBE, and AVX2 each independently, I will change it to =
support the various environments in the next version.


Thank you.


-----Original Message-----
From: Dave Hansen <dave.hansen@intel.com>=20
Sent: Saturday, April 29, 2023 12:55 AM
To: Dongsoo Lee <letrhee@nsr.re.kr>; linux-crypto@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>; David S. Miller =
<davem@davemloft.net>; Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar =
<mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; Dave Hansen =
<dave.hansen@linux.intel.com>; x86@kernel.org; H. Peter Anvin =
<hpa@zytor.com>; linux-kernel@vger.kernel.org; David S. Miller =
<abc@test.nsr.re.kr>; Dongsoo Lee <letrhee@gmail.com>
Subject: Re: [PATCH 3/3] crypto: LEA block cipher AVX2 optimization

> +config CRYPTO_LEA_AVX2
> +	tristate "Ciphers: LEA with modes: ECB, CBC, CTR, XTS
> (SSE2/MOVBE/AVX2)"
> +	select CRYPTO_LEA
> +	imply CRYPTO_XTS
> +	imply CRYPTO_CTR
> +	help
> +	  LEA cipher algorithm (KS X 3246, ISO/IEC 29192-2:2019)
> +
> +	  LEA is one of the standard cryptographic alorithms of
> +	  the Republic of Korea. It consists of four 32bit word.

The "four 32bit word" thing is probably not a detail end users care =
about enough to see in Kconfig text.

> +	  See:
> +	  https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
> +
> +	  Architecture: x86_64 using:
> +	  - SSE2 (Streaming SIMD Extensions 2)
> +	  - MOVBE (Move Data After Swapping Bytes)
> +	  - AVX2 (Advanced Vector Extensions)

What about i386?  If this is truly 64-bit-only for some reason, it's not =
reflected anywhere that I can see, like having a:

	depends on X86_64

I'm also a _bit_ confused why this has one config option called "_AVX2"
but that also includes the SSE2 implementation.

> +	  Processes 4(SSE2), 8(AVX2) blocks in parallel.
> +	  In CTR mode, the MOVBE instruction is utilized for improved
> performance.
> +
>  config CRYPTO_CHACHA20_X86_64
>  	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12=20
> (SSSE3/AVX2/AVX-512VL)"
>  	depends on X86 && 64BIT
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile index =

> 9aa46093c91b..de23293b88df 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -109,6 +109,9 @@ aria-aesni-avx2-x86_64-y :=3D=20
> aria-aesni-avx2-asm_64.o aria_aesni_avx2_glue.o
>  obj-$(CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64) +=3D=20
> aria-gfni-avx512-x86_64.o  aria-gfni-avx512-x86_64-y :=3D=20
> aria-gfni-avx512-asm_64.o aria_gfni_avx512_glue.o
>
> +obj-$(CONFIG_CRYPTO_LEA_AVX2) +=3D lea-avx2-x86_64.o =
lea-avx2-x86_64-y=20
> +:=3D lea_avx2_x86_64-asm.o lea_avx2_glue.o
> +
>  quiet_cmd_perlasm =3D PERLASM $@
>        cmd_perlasm =3D $(PERL) $< > $@
>  $(obj)/%.S: $(src)/%.pl FORCE
> diff --git a/arch/x86/crypto/lea_avx2_glue.c=20
> b/arch/x86/crypto/lea_avx2_glue.c new file mode 100644 index=20
> 000000000000..532958d3caa5
> --- /dev/null
> +++ b/arch/x86/crypto/lea_avx2_glue.c
> @@ -0,0 +1,1112 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Glue Code for the SSE2/MOVBE/AVX2 assembler instructions for the=20
> +LEA
> Cipher
> + *
> + * Copyright (c) 2023 National Security Research.
> + * Author: Dongsoo Lee <letrhee@nsr.re.kr> */
> +
> +#include <asm/simd.h>
> +#include <asm/unaligned.h>
> +#include <crypto/algapi.h>
> +#include <crypto/ctr.h>
> +#include <crypto/internal/simd.h>
> +#include <crypto/scatterwalk.h>
> +#include <crypto/skcipher.h>
> +#include <crypto/internal/skcipher.h> #include <linux/err.h> #include =

> +<linux/module.h> #include <linux/types.h>
> +
> +#include <crypto/lea.h>
> +#include <crypto/xts.h>
> +#include "ecb_cbc_helpers.h"
> +
> +#define SIMD_KEY_ALIGN 16
> +#define SIMD_ALIGN_ATTR __aligned(SIMD_KEY_ALIGN)
> +
> +struct lea_xts_ctx {
> +	u8 raw_crypt_ctx[sizeof(struct crypto_lea_ctx)] SIMD_ALIGN_ATTR;
> +	u8 raw_tweak_ctx[sizeof(struct crypto_lea_ctx)] SIMD_ALIGN_ATTR; };

The typing here is a bit goofy.  What's wrong with:

struct lea_xts_ctx {
	struct crypto_lea_ctx crypt_ctx SIMD_ALIGN_ATTR;
	struct crypto_lea_ctx lea_ctx   SIMD_ALIGN_ATTR;
};

?  You end up with the same sized structure but you don't have to cast =
it as much.

> +struct _lea_u128 {
> +	u64 v0, v1;
> +};
> +
> +static inline void xor_1blk(u8 *out, const u8 *in1, const u8 *in2) {
> +	const struct _lea_u128 *_in1 =3D (const struct _lea_u128 *)in1;
> +	const struct _lea_u128 *_in2 =3D (const struct _lea_u128 *)in2;
> +	struct _lea_u128 *_out =3D (struct _lea_u128 *)out;
> +
> +	_out->v0 =3D _in1->v0 ^ _in2->v0;
> +	_out->v1 =3D _in1->v1 ^ _in2->v1;
> +}
> +
> +static inline void xts_next_tweak(u8 *out, const u8 *in) {
> +	const u64 *_in =3D (const u64 *)in;
> +	u64 *_out =3D (u64 *)out;
> +	u64 v0 =3D _in[0];
> +	u64 v1 =3D _in[1];
> +	u64 carry =3D (u64)(((s64)v1) >> 63);
> +
> +	v1 =3D (v1 << 1) ^ (v0 >> 63);
> +	v0 =3D (v0 << 1) ^ ((u64)carry & 0x87);
> +
> +	_out[0] =3D v0;
> +	_out[1] =3D v1;
> +}

I don't really care either way, but it's interesting that in two =
adjacent functions this deals with two adjacent 64-bit values.  In one =
it defines a structure with two u64's and in the next it treats it as an =
array.

> +static int xts_encrypt_8way(struct skcipher_request *req) {
...

It's kinda a shame that there isn't more code shared here between, for =
instance the 4way and 8way functions.  But I guess this crypto code =
tends to be merged and then very rarely fixed up after.

> +static int xts_lea_set_key(struct crypto_skcipher *tfm, const u8 =
*key,
> +				u32 keylen)
> +{
> +	struct crypto_tfm *tfm_ctx =3D crypto_skcipher_ctx(tfm);
> +	struct lea_xts_ctx *ctx =3D crypto_tfm_ctx(tfm_ctx);
> +
> +	struct crypto_lea_ctx *crypt_key =3D
> +		(struct crypto_lea_ctx *)(ctx->raw_crypt_ctx);
> +	struct crypto_lea_ctx *tweak_key =3D
> +		(struct crypto_lea_ctx *)(ctx->raw_tweak_ctx);

These were those goofy casts that can go away if the typing is a bit =
more careful

...
> +static struct simd_skcipher_alg
> *lea_simd_algs[ARRAY_SIZE(lea_simd_avx2_algs)];
> +
> +static int __init crypto_lea_avx2_init(void) {
> +	const char *feature_name;
> +
> +	if (!boot_cpu_has(X86_FEATURE_XMM2)) {
> +		pr_info("SSE2 instructions are not detected.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!boot_cpu_has(X86_FEATURE_MOVBE)) {
> +		pr_info("MOVBE instructions are not detected.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!boot_cpu_has(X86_FEATURE_AVX2) ||=20
> +!boot_cpu_has(X86_FEATURE_AVX))
> {
> +		pr_info("AVX2 instructions are not detected.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
> +				&feature_name)) {
> +		pr_info("CPU feature '%s' is not supported.\n", feature_name);
> +		return -ENODEV;
> +	}

This looks suspect.

It requires that *ALL* of XMM2, MOVBE, AVX, AVX2 and XSAVE support for
*ANY* of these to be used.  In other cipher code that I've seen, it =
separates out the AVX/YMM acceleration from the pure SSE2/XMM =
acceleration functions so that CPUs with only SSE2 can still benefit.

Either this is wrong, or there is something subtle going on that I'm =
missing.

