Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAED67505D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjATJND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjATJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:13:01 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8548C939;
        Fri, 20 Jan 2023 01:12:31 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pInR9-0029bo-CL; Fri, 20 Jan 2023 17:11:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Jan 2023 17:11:51 +0800
Date:   Fri, 20 Jan 2023 17:11:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     davem@davemloft.net, jesper.nilsson@axis.com,
        lars.persson@axis.com, kernel@axis.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] crypto: axis - do not DMA to IV
Message-ID: <Y8pa15wREUvWO1L8@gondor.apana.org.au>
References: <20230110135042.2940847-1-vincent.whitchurch@axis.com>
 <20230110135042.2940847-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110135042.2940847-3-vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:50:32PM +0100, Vincent Whitchurch wrote:
> The crypto API does not promise that the IV buffer is suitable for DMA.
> Use an intermediate buffer instead.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/crypto/axis/artpec6_crypto.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
> index 87af44ac3e64..d3b6ee065a81 100644
> --- a/drivers/crypto/axis/artpec6_crypto.c
> +++ b/drivers/crypto/axis/artpec6_crypto.c
> @@ -321,6 +321,7 @@ struct artpec6_crypto_request_context {
>  	u32 cipher_md;
>  	bool decrypt;
>  	struct artpec6_crypto_req_common common;
> +	unsigned char iv_bounce[AES_BLOCK_SIZE] CRYPTO_MINALIGN_ATTR;

Please use the newly introduced CRYPTO_DMA_ALIGN macro.

CRYPTO_MINALIGN only reflects minimum kmalloc alignment, which
may be less than that required for DMA.  You're currently safe
on arm32, but we should not rely on this in new code.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
