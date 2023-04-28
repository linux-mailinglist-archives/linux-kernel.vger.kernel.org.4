Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7196F1C02
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346048AbjD1Py6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345910AbjD1Pyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:54:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D45412B;
        Fri, 28 Apr 2023 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682697292; x=1714233292;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h6uIyeYL79bSTSpFqsQE6YehbS58Bqy5B/88nYriI/E=;
  b=Ub4vmxhgA2SVT3iBPaVn8bFbtRR0hdKfSlYqok/8R3WsdqGpYaTHHJih
   6yeCHwV1pFmHjL5DcyPkVRguQILiJomDmldVQIhA++BaNedIzolZ6QEd2
   xgRwIrjR6pThPkcQFA4lFXgbu+2U+qaKNQsnvoA+vSGcm23TSP2WuDt2C
   DQj5iwYQCLBPgDkyK84EvSS9F+9eE0WCcC2+RmvJWgMRdGWYlC6+qoW2V
   Wg3ycl5sbdZqAdne8LzNM0ndrFsbM5m/a0jB2/9/M491FpOK8CEPmf0uJ
   Q/+fnNzi7I+5lkG7UMYFiFRwzCMpWWX1SEWWvWb4IXREPasPEHMVILLVh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="327404521"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="327404521"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="869243891"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="869243891"
Received: from scha1-mobl1.amr.corp.intel.com (HELO [10.212.154.191]) ([10.212.154.191])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:54:51 -0700
Message-ID: <f0c77850-f8ca-3e21-2722-1deaae424130@intel.com>
Date:   Fri, 28 Apr 2023 08:54:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] crypto: LEA block cipher AVX2 optimization
Content-Language: en-US
To:     Dongsoo Lee <letrhee@nsr.re.kr>, linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <abc@test.nsr.re.kr>,
        Dongsoo Lee <letrhee@gmail.com>
References: <20230428110058.1516119-1-letrhee@nsr.re.kr>
 <20230428110058.1516119-4-letrhee@nsr.re.kr>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230428110058.1516119-4-letrhee@nsr.re.kr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config CRYPTO_LEA_AVX2
> +	tristate "Ciphers: LEA with modes: ECB, CBC, CTR, XTS (SSE2/MOVBE/AVX2)"
> +	select CRYPTO_LEA
> +	imply CRYPTO_XTS
> +	imply CRYPTO_CTR
> +	help
> +	  LEA cipher algorithm (KS X 3246, ISO/IEC 29192-2:2019)
> +
> +	  LEA is one of the standard cryptographic alorithms of
> +	  the Republic of Korea. It consists of four 32bit word.

The "four 32bit word" thing is probably not a detail end users care
about enough to see in Kconfig text.

> +	  See:
> +	  https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
> +
> +	  Architecture: x86_64 using:
> +	  - SSE2 (Streaming SIMD Extensions 2)
> +	  - MOVBE (Move Data After Swapping Bytes)
> +	  - AVX2 (Advanced Vector Extensions)

What about i386?  If this is truly 64-bit-only for some reason, it's not
reflected anywhere that I can see, like having a:

	depends on X86_64

I'm also a _bit_ confused why this has one config option called "_AVX2"
but that also includes the SSE2 implementation.

> +	  Processes 4(SSE2), 8(AVX2) blocks in parallel.
> +	  In CTR mode, the MOVBE instruction is utilized for improved performance.
> +
>  config CRYPTO_CHACHA20_X86_64
>  	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (SSSE3/AVX2/AVX-512VL)"
>  	depends on X86 && 64BIT
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> index 9aa46093c91b..de23293b88df 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -109,6 +109,9 @@ aria-aesni-avx2-x86_64-y := aria-aesni-avx2-asm_64.o aria_aesni_avx2_glue.o
>  obj-$(CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64) += aria-gfni-avx512-x86_64.o
>  aria-gfni-avx512-x86_64-y := aria-gfni-avx512-asm_64.o aria_gfni_avx512_glue.o
>  
> +obj-$(CONFIG_CRYPTO_LEA_AVX2) += lea-avx2-x86_64.o
> +lea-avx2-x86_64-y := lea_avx2_x86_64-asm.o lea_avx2_glue.o
> +
>  quiet_cmd_perlasm = PERLASM $@
>        cmd_perlasm = $(PERL) $< > $@
>  $(obj)/%.S: $(src)/%.pl FORCE
> diff --git a/arch/x86/crypto/lea_avx2_glue.c b/arch/x86/crypto/lea_avx2_glue.c
> new file mode 100644
> index 000000000000..532958d3caa5
> --- /dev/null
> +++ b/arch/x86/crypto/lea_avx2_glue.c
> @@ -0,0 +1,1112 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Glue Code for the SSE2/MOVBE/AVX2 assembler instructions for the LEA Cipher
> + *
> + * Copyright (c) 2023 National Security Research.
> + * Author: Dongsoo Lee <letrhee@nsr.re.kr>
> + */
> +
> +#include <asm/simd.h>
> +#include <asm/unaligned.h>
> +#include <crypto/algapi.h>
> +#include <crypto/ctr.h>
> +#include <crypto/internal/simd.h>
> +#include <crypto/scatterwalk.h>
> +#include <crypto/skcipher.h>
> +#include <crypto/internal/skcipher.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
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
> +	u8 raw_tweak_ctx[sizeof(struct crypto_lea_ctx)] SIMD_ALIGN_ATTR;
> +};

The typing here is a bit goofy.  What's wrong with:

struct lea_xts_ctx {
	struct crypto_lea_ctx crypt_ctx SIMD_ALIGN_ATTR;
	struct crypto_lea_ctx lea_ctx   SIMD_ALIGN_ATTR;
};

?  You end up with the same sized structure but you don't have to cast
it as much.

> +struct _lea_u128 {
> +	u64 v0, v1;
> +};
> +
> +static inline void xor_1blk(u8 *out, const u8 *in1, const u8 *in2)
> +{
> +	const struct _lea_u128 *_in1 = (const struct _lea_u128 *)in1;
> +	const struct _lea_u128 *_in2 = (const struct _lea_u128 *)in2;
> +	struct _lea_u128 *_out = (struct _lea_u128 *)out;
> +
> +	_out->v0 = _in1->v0 ^ _in2->v0;
> +	_out->v1 = _in1->v1 ^ _in2->v1;
> +}
> +
> +static inline void xts_next_tweak(u8 *out, const u8 *in)
> +{
> +	const u64 *_in = (const u64 *)in;
> +	u64 *_out = (u64 *)out;
> +	u64 v0 = _in[0];
> +	u64 v1 = _in[1];
> +	u64 carry = (u64)(((s64)v1) >> 63);
> +
> +	v1 = (v1 << 1) ^ (v0 >> 63);
> +	v0 = (v0 << 1) ^ ((u64)carry & 0x87);
> +
> +	_out[0] = v0;
> +	_out[1] = v1;
> +}

I don't really care either way, but it's interesting that in two
adjacent functions this deals with two adjacent 64-bit values.  In one
it defines a structure with two u64's and in the next it treats it as an
array.

> +static int xts_encrypt_8way(struct skcipher_request *req)
> +{
...

It's kinda a shame that there isn't more code shared here between, for
instance the 4way and 8way functions.  But I guess this crypto code
tends to be merged and then very rarely fixed up after.

> +static int xts_lea_set_key(struct crypto_skcipher *tfm, const u8 *key,
> +				u32 keylen)
> +{
> +	struct crypto_tfm *tfm_ctx = crypto_skcipher_ctx(tfm);
> +	struct lea_xts_ctx *ctx = crypto_tfm_ctx(tfm_ctx);
> +
> +	struct crypto_lea_ctx *crypt_key =
> +		(struct crypto_lea_ctx *)(ctx->raw_crypt_ctx);
> +	struct crypto_lea_ctx *tweak_key =
> +		(struct crypto_lea_ctx *)(ctx->raw_tweak_ctx);

These were those goofy casts that can go away if the typing is a bit
more careful

...
> +static struct simd_skcipher_alg *lea_simd_algs[ARRAY_SIZE(lea_simd_avx2_algs)];
> +
> +static int __init crypto_lea_avx2_init(void)
> +{
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
> +	if (!boot_cpu_has(X86_FEATURE_AVX2) || !boot_cpu_has(X86_FEATURE_AVX)) {
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
*ANY* of these to be used.  In other cipher code that I've seen, it
separates out the AVX/YMM acceleration from the pure SSE2/XMM
acceleration functions so that CPUs with only SSE2 can still benefit.

Either this is wrong, or there is something subtle going on that I'm
missing.


