Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51759721836
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 17:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFDPen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFDPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 11:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFACD;
        Sun,  4 Jun 2023 08:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9584760B75;
        Sun,  4 Jun 2023 15:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76917C433D2;
        Sun,  4 Jun 2023 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685892879;
        bh=Q2x+B61PRDU4ePo1k8Ni2aqUQ+O036qqTKi2Y9A/u1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRKGyRUZc/319m3B4YvFys4WpvGN849SulNSJTNhi058tPA0qSLak9puvoe1ObxB7
         P4XM2CeG5VgSW9QkAAcYShVpr7bY9lr8dcWfG5pQLro6ADjhCsg+bctqEvVw515MY3
         MEoGaObsL+9KRVYtXKHImXTfdDFbWiW2jzL+JB5Z2Cauws1wwT8q58N6NSiGEHJ885
         MSCNBIJwzaJchmTGwEdHXSfFt4zMREUPrG+NKDBZHa3hEfXVMy8yCv/ZNSorIa/MQ/
         eytlJUERhAd2pV+K57qjkmCaEGLMzcI6A74FelbUJtmkKRd/V11LzGi+Y9zLto1RXe
         WJAOI4mXVZM8g==
Date:   Sun, 4 Jun 2023 08:34:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 10/12] crypto: x86/aesni - Use the proper data type in
 struct aesni_xts_ctx
Message-ID: <20230604153434.GA1212@quark.localdomain>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20230603152227.12335-11-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603152227.12335-11-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 08:22:25AM -0700, Chang S. Bae wrote:
> Every field in struct aesni_xts_ctx is a pointer to a byte array.

A byte array.  Not a pointer to a byte array.

> Then, the field can be redefined as that struct type instead of the obscure
> pointer.

There's no pointer.

>  static inline struct
>  aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
>  {
> -	unsigned long align = AESNI_ALIGN;
> -
> -	if (align <= crypto_tfm_ctx_alignment())
> -		align = 1;
> -	return PTR_ALIGN(crypto_aead_ctx(tfm), align);
> +	return (struct aesni_rfc4106_gcm_ctx *)aes_align_addr(crypto_aead_ctx(tfm));
>  }

Explicit casts from 'void *' are unnecessary.

>  static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  			    unsigned int keylen)
>  {
> -	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
> +	struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
>  	int err;
>  
>  	err = xts_verify_key(tfm, key, keylen);
> @@ -893,20 +892,20 @@ static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  	keylen /= 2;
>  
>  	/* first half of xts-key is for crypt */
> -	err = aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_crypt_ctx,
> +	err = aes_set_key_common(crypto_skcipher_tfm(tfm), &ctx->crypt_ctx,
>  				 key, keylen);
>  	if (err)
>  		return err;
>  
>  	/* second half of xts-key is for tweak */
> -	return aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_tweak_ctx,
> +	return aes_set_key_common(crypto_skcipher_tfm(tfm), &ctx->tweak_ctx,
>  				  key + keylen, keylen);
>  }

To re-iterate what I said on v6, the runtime alignment to a 16-byte boundary
should happen when translating the raw crypto_skcipher_ctx() into the pointer to
the aes_xts_ctx.  It should not happen when accessing each individual field in
the aes_xts_ctx.

Yet, this code is still doing runtime alignment when accessing each individual
field, as the second argument to aes_set_key_common() is 'void *raw_ctx' which
aes_set_key_common() runtime-aligns to crypto_aes_ctx.

We should keep everything consistent, which means making aes_set_key_common()
take a pointer to crypto_aes_ctx and not do the runtime alignment.

- Eric
