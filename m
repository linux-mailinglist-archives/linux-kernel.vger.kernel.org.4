Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BCB7091BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjESIdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjESId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:33:29 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9AA102;
        Fri, 19 May 2023 01:33:27 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pzvY9-00Ane4-IY; Fri, 19 May 2023 16:33:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 May 2023 16:33:21 +0800
Date:   Fri, 19 May 2023 16:33:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     yangmengfei1394@phytium.com.cn
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangmengfei1394@phytium.com.cn
Subject: Re: [PATCH] Crypto: Fix one bug when use kernel ecdsa algorithm
Message-ID: <ZGc0UdrY9Suaxdjq@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510075142.1638-1-yangmengfei1394@phytium.com.cn>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yangmengfei1394@phytium.com.cn wrote:
>
> diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
> index f35fd653e4e5..a68f0e23bf89 100644
> --- a/include/crypto/akcipher.h
> +++ b/include/crypto/akcipher.h
> @@ -459,7 +459,9 @@ static inline int crypto_akcipher_set_priv_key(struct crypto_akcipher *tfm,
>                                               unsigned int keylen)
> {
>        struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
> -
> -       return alg->set_priv_key(tfm, key, keylen);
> +       if (likely(alg->set_priv_key != NULL))
> +               return alg->set_priv_key(tfm, key, keylen);
> +       else
> +               return -EPERM;
> }
> #endif

Instead of doing this, we should move the code that sets the
default functions from crypto_register_akcipher into
akcipher_prepare_alg.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
