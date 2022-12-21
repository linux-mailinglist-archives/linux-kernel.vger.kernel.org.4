Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CAF6539D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 00:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiLUXdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 18:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLUXdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 18:33:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B924BE9;
        Wed, 21 Dec 2022 15:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76CD0B81C57;
        Wed, 21 Dec 2022 23:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E971BC433EF;
        Wed, 21 Dec 2022 23:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671665595;
        bh=hW75uHYjkBGcArJykLAMMvyqPnKjnbwTvRuVZaZ3I0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oES6z3NNR1B9i6Gjr3jFxQ4kj1uEHYqNeoyESPTRPm9ePZccspuyxf56cifNCjUz3
         y9xY+i0QFbxTFxobYfpC/sy9w4EtCsQA39A39aTk7USe8sR5Ir21KMwebWwEbgGv2r
         58Djqj4LmmWq4TceUr96P7je5yL0PfBYIrxBaOZ/5YVuhUXG+hT082kkBUjsfUI6eU
         yfEAo8aqtKsvjg/kiVo5zKiQhA0IGNRMnXW+QsWWSV34tRVbgfmktq5GNQFIE4DAYO
         7r4MwA/axqYvyTTZCQfR2oLmEQf31r+PX81o3zNz6aaBfgEfAR6ZgoR+ito8WFzPpv
         C8ZGm362Gi7VA==
Date:   Wed, 21 Dec 2022 15:33:13 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, nstange@suse.de,
        elliott@hpe.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, smueller@chronox.de
Subject: Re: [PATCH 2/6] crypto: xts - drop xts_check_key()
Message-ID: <Y6OXuT95MlkNanSR@sol.localdomain>
References: <20221221224111.19254-1-vdronov@redhat.com>
 <20221221224111.19254-3-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221224111.19254-3-vdronov@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 11:41:07PM +0100, Vladis Dronov wrote:
> xts_check_key() is obsoleted by xts_verify_key(). Over time XTS crypto
> drivers adopted the newer xts_verify_key() variant, but xts_check_key()
> is still used by a number of drivers. Switch drivers to use the newer
> xts_verify_key() and make a couple of cleanups. This allows us to drop
> xts_check_key() completely and avoid redundancy.
> 
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  arch/s390/crypto/paes_s390.c                  |  2 +-
>  drivers/crypto/atmel-aes.c                    |  2 +-
>  drivers/crypto/axis/artpec6_crypto.c          |  2 +-
>  drivers/crypto/cavium/cpt/cptvf_algs.c        |  8 +++----
>  .../crypto/cavium/nitrox/nitrox_skcipher.c    |  8 +++----
>  drivers/crypto/ccree/cc_cipher.c              |  2 +-
>  .../crypto/marvell/octeontx/otx_cptvf_algs.c  |  2 +-
>  .../marvell/octeontx2/otx2_cptvf_algs.c       |  2 +-
>  include/crypto/xts.h                          | 21 +++----------------
>  9 files changed, 15 insertions(+), 34 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

but one comment below:

>  static inline int xts_verify_key(struct crypto_skcipher *tfm,
>  				 const u8 *key, unsigned int keylen)
>  {
> @@ -42,7 +25,9 @@ static inline int xts_verify_key(struct crypto_skcipher *tfm,
>  	if (fips_enabled && keylen != 32 && keylen != 64)
>  		return -EINVAL;
>  
> -	/* ensure that the AES and tweak key are not identical */
> +	/* ensure that the AES and tweak key are not identical
> +	 * when in FIPS mode or the FORBID_WEAK_KEYS flag is set.
> +	 */
>  	if ((fips_enabled || (crypto_skcipher_get_flags(tfm) &
>  			      CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) &&
>  	    !crypto_memneq(key, key + (keylen / 2), keylen / 2))

Please use the kernel style for block comments:

	/*
	 * Ensure that the AES and tweak key are not identical when in FIPS mode
	 * or the FORBID_WEAK_KEYS flag is set.
	 */

- Eric
