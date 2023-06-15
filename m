Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5EE7323C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjFOXiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjFOXix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:38:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0F8294E;
        Thu, 15 Jun 2023 16:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE27262C63;
        Thu, 15 Jun 2023 23:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB25C433C0;
        Thu, 15 Jun 2023 23:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686872331;
        bh=Fqi/K2Gf7K/Hp8uv0SoXSv+oUBt2a09UEToTLMpKZAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNSeXOdAoDxAxc+XyTRJ4Nnp3IXYQg1jp8Tq9VNVbB4jpUTGrz1qdR2t0a/HNRUnh
         tuGNQuQ1UZSBI6y/ESQWcL+dV5Nt6fUnRUCd8piqBa9t8OG2dfT+741FTon228RjIQ
         eFyB2AjIJBTRZdAdbiLWgPJTso6HdXP6eYjC5AX0OoFsuC9TtxznJVTHuj1FVOHYna
         1glW8sM9VWVmo2Y+cJgRJOlKxMSo9aixEnG+jQrqpDmsmBWMM7yBp0Gf+Qy4zhAFXf
         jZVfyc/HCarUXQAlLB6p9xd0Z+eCu64Ns4FZj8tozsCFIriiK2CPCV9PI+PNuXGHya
         wyiB8/zDRO7IA==
Date:   Thu, 15 Jun 2023 16:38:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, Bob Gilligan <gilligan@arista.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH-next 2/3] crypto: api - Provide gfp mask for tfm
 allocation
Message-ID: <20230615233849.GB25295@sol.localdomain>
References: <20230614174643.3836590-1-dima@arista.com>
 <20230614174643.3836590-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614174643.3836590-3-dima@arista.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 06:46:42PM +0100, Dmitry Safonov wrote:
> diff --git a/crypto/cipher.c b/crypto/cipher.c
> index d39ef5f72ab8..184188339a4a 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -102,7 +102,7 @@ struct crypto_cipher *crypto_clone_cipher(struct crypto_cipher *cipher)
>  		return ERR_PTR(-ENOSYS);
>  
>  	ntfm = __crypto_alloc_tfm(alg, CRYPTO_ALG_TYPE_CIPHER,
> -				  CRYPTO_ALG_TYPE_MASK);
> +				  CRYPTO_ALG_TYPE_MASK, GFP_ATOMIC);
>  	if (IS_ERR(ntfm))
>  		return ERR_CAST(ntfm);
>  

Should crypto_clone_cipher() not have a gfp_t argument itself?

I'm wondering if any users of the crypto_clone_*() functions will need anything
other than GFP_ATOMIC, such as GFP_NOFS or GFP_NOIO.

FWIW, btrfs's support for fscrypt is planned to use per-extent keys.  It's
challenging to implement.  I've been thinking it might need a
crypto_clone_skcipher() function that it can use during filesystem I/O.  That
use case would want GFP_NOFS, I think.

- Eric
