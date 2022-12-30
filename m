Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD17C659688
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiL3JI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3JIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:08:25 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E694228D;
        Fri, 30 Dec 2022 01:08:24 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pBBMu-00CI8h-TN; Fri, 30 Dec 2022 17:08:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Dec 2022 17:08:00 +0800
Date:   Fri, 30 Dec 2022 17:08:00 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Robert Elliott <elliott@hpe.com>
Cc:     davem@davemloft.net, Jason@zx2c4.com, ardb@kernel.org,
        ap420073@gmail.com, David.Laight@aculab.com, ebiggers@kernel.org,
        tim.c.chen@linux.intel.com, peter@n8pjl.ca, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] crypto: x86/sha - yield FPU context during long
 loops
Message-ID: <Y66qcI/pweImS/1u@gondor.apana.org.au>
References: <20221219220223.3982176-1-elliott@hpe.com>
 <20221219220223.3982176-4-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219220223.3982176-4-elliott@hpe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:02:13PM -0600, Robert Elliott wrote:
>
> diff --git a/arch/x86/crypto/sha1_avx2_x86_64_asm.S b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
> index c3ee9334cb0f..df03fbb2c42c 100644
> --- a/arch/x86/crypto/sha1_avx2_x86_64_asm.S
> +++ b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
> @@ -58,9 +58,9 @@
>  /*
>   * SHA-1 implementation with Intel(R) AVX2 instruction set extensions.
>   *
> - *This implementation is based on the previous SSSE3 release:
> - *Visit http://software.intel.com/en-us/articles/
> - *and refer to improving-the-performance-of-the-secure-hash-algorithm-1/
> + * This implementation is based on the previous SSSE3 release:
> + * Visit http://software.intel.com/en-us/articles/
> + * and refer to improving-the-performance-of-the-secure-hash-algorithm-1/

Could you please leave out changes which are not related to the
main purpose of this patch?

Put them into a separate patch if necessary.

> diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
> index 44340a1139e0..b269b455fbbe 100644
> --- a/arch/x86/crypto/sha1_ssse3_glue.c
> +++ b/arch/x86/crypto/sha1_ssse3_glue.c
> @@ -41,9 +41,7 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
>  	 */
>  	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
>  
> -	kernel_fpu_begin();
>  	sha1_base_do_update(desc, data, len, sha1_xform);
> -	kernel_fpu_end();

Moving kernel_fpu_begin/kernel_fpu_end down seems to be entirely
unnecessary as you could already call kernel_fpu_yield deep down
the stack with the current code.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
