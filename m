Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05E67504E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjATJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjATJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:10:24 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C08C938;
        Fri, 20 Jan 2023 01:09:32 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pInOg-0029Vm-GN; Fri, 20 Jan 2023 17:09:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Jan 2023 17:09:18 +0800
Date:   Fri, 20 Jan 2023 17:09:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     davem@davemloft.net, jesper.nilsson@axis.com,
        lars.persson@axis.com, kernel@axis.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars Persson <larper@axis.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/12] crypto: axis - do not DMA to ahash_request.result
Message-ID: <Y8paPhBZqzipaMEL@gondor.apana.org.au>
References: <20230110135042.2940847-1-vincent.whitchurch@axis.com>
 <20230110135042.2940847-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110135042.2940847-2-vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:50:31PM +0100, Vincent Whitchurch wrote:
>
> @@ -2216,6 +2220,14 @@ static void artpec6_crypto_complete_aead(struct crypto_async_request *req)
>  
>  static void artpec6_crypto_complete_hash(struct crypto_async_request *req)
>  {
> +	struct ahash_request *areq = container_of(req, struct ahash_request, base);
> +	struct artpec6_hash_request_context *ctx = ahash_request_ctx(areq);
> +	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
> +	size_t digestsize = crypto_ahash_digestsize(ahash);
> +
> +	if (ctx->hash_flags & HASH_FLAG_FINALIZED)
> +		memcpy(areq->result, ctx->digeststate, digestsize);
> +

I was just looking through the driver and digeststate does not
appear to be aligned to the DMA cacheline, should it be?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
