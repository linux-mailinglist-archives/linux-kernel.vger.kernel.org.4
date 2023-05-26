Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78287120D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbjEZHXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbjEZHXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:23:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16979B;
        Fri, 26 May 2023 00:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EB5A64D88;
        Fri, 26 May 2023 07:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D370C433D2;
        Fri, 26 May 2023 07:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685085784;
        bh=Z+s29jQiBKqU2l46jPccXJdvd9jdYJHsfjEWMx9TRx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cO9AGl9ps5XpW7/aAs6LaRMSKLZ1cqcbu2Z+46QILzHNiwtf+EwAt9g9m5eSnbEqI
         r1hv7FzcVRviZlyvezLBCR8xF52yBI8s7LWkZTZSidKN5OY3Ne3NJzcj7bo2IZ5Qbs
         HvW1tCT4NqlDYUQXRyo5vbKNqwB1WIzNrZGoUahJ8IFi5b6dAgIrNM2ouWTK/W/PHl
         suqEYo/I0NqUVeSf1wVwdUPMEFD48zm9+OmkkJJ9rUxHRzPTrUdJHGlSbBNvLBusDW
         /JxJB6FvRBBemQWV1cwTv3exX0djxv0RnSgR6BnVJ99K9hJRB7P+Sx3SG5j0IWVNG4
         GSjtfJJtfQY+Q==
Date:   Fri, 26 May 2023 00:23:01 -0700
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
Subject: Re: [PATCH v7 12/12] crypto: x86/aes-kl - Implement the AES-XTS
 algorithm
Message-ID: <20230526072301.GC875@sol.localdomain>
References: <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230524165717.14062-13-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524165717.14062-13-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:57:17AM -0700, Chang S. Bae wrote:
> == API Limitation ==
> 
> The setkey() function transforms an AES key into a handle. But, an
> extended key is a usual outcome of setkey() in other AES cipher
> implementations. For this reason, a setkey() failure does not fall
> back to the other. So, expose AES-KL methods via synchronous
> interfaces only.

I don't understand what this paragraph is trying to say.

> +/*
> + * The below wrappers for the encryption/decryption functions
> + * incorporate the feature availability check:
> + *
> + * In the rare event of hardware failure, the wrapping key can be lost
> + * after wake-up from a deep sleep state. Then, this check helps to
> + * avoid any subsequent misuse with populating a proper error code.
> + */
> +
> +static inline int aeskl_enc(const void *ctx, u8 *out, const u8 *in)
> +{
> +	if (!valid_keylocker())
> +		return -ENODEV;
> +
> +	return __aeskl_enc(ctx, out, in);
> +}

Is it not sufficient for the valid_keylocker() check to occur at the top level
(in xts_encrypt() and xts_decrypt()), which would seem to be a better place to
do it?  Is this because valid_keylocker() needs to be checked in every
kernel_fpu_begin() section separately, to avoid a race condition?  If that's
indeed the reason, can you explain that in the comment?

> +static inline int xts_keylen(struct skcipher_request *req, u32 *keylen)
> +{
> +	struct aes_xts_ctx *ctx = aes_xts_ctx(crypto_skcipher_reqtfm(req));
> +
> +	if (ctx->crypt_ctx.key_length != ctx->tweak_ctx.key_length)
> +		return -EINVAL;
> +
> +	*keylen = ctx->crypt_ctx.key_length;
> +	return 0;
> +}

This is odd.  Why would the key lengths be different here?

> +	err = simd_register_skciphers_compat(aeskl_skciphers, ARRAY_SIZE(aeskl_skciphers),
> +					     aeskl_simd_skciphers);
> +	if (err)
> +		return err;
> +
> +	return 0;

This can be simplified to:

	return simd_register_skciphers_compat(aeskl_skciphers,
					      ARRAY_SIZE(aeskl_skciphers),
					      aeskl_simd_skciphers);

- Eric
