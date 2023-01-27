Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9F67E993
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjA0PfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjA0PfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:35:14 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDBA83949;
        Fri, 27 Jan 2023 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674833708;
  x=1706369708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=knTxw+HOO+Mu4udu1BTSisM/sBDYJVdlFnR7EzrCZEE=;
  b=i+iOX1Ph5Cp5dG9d2fXKa1WHuGutzJKJ1OMyd1fSqKNXkIY3tqKKhCT4
   jazj+h6ylgCjgcDws6hq6CWoP/v62JXCpmtLgT3+SpAi0fmulq/GBUNZg
   WG2Bs8l+rdZh5p+l1j99oU3csgy3DT2IQdvBOXbfKssaMEZM8RQRWJTaa
   kXlmszHu6OfRfmFqvVcnld3+BPpLQ0B7OVgKzac61YhsxwNFGo41UyOGL
   8HqRLfTjW0FSh8sqPNpKCnjEzKbbHhdtMmJ2nWyFTE8U3bwHVoBrNVEgM
   jTHOH4FCL4nmchVOrOOfcqi51lrwWZjkdYj0Ss0wGBe8WKs8ap4IJgNB7
   Q==;
Date:   Fri, 27 Jan 2023 16:35:06 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>, kernel <kernel@axis.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/12] crypto: axis - do not DMA to ahash_request.result
Message-ID: <Y9PvKurcZLva8Vws@axis.com>
References: <20230110135042.2940847-1-vincent.whitchurch@axis.com>
 <20230110135042.2940847-2-vincent.whitchurch@axis.com>
 <Y8paPhBZqzipaMEL@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y8paPhBZqzipaMEL@gondor.apana.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 10:09:18AM +0100, Herbert Xu wrote:
> On Tue, Jan 10, 2023 at 02:50:31PM +0100, Vincent Whitchurch wrote:
> >
> > @@ -2216,6 +2220,14 @@ static void artpec6_crypto_complete_aead(struct crypto_async_request *req)
> >  
> >  static void artpec6_crypto_complete_hash(struct crypto_async_request *req)
> >  {
> > +	struct ahash_request *areq = container_of(req, struct ahash_request, base);
> > +	struct artpec6_hash_request_context *ctx = ahash_request_ctx(areq);
> > +	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
> > +	size_t digestsize = crypto_ahash_digestsize(ahash);
> > +
> > +	if (ctx->hash_flags & HASH_FLAG_FINALIZED)
> > +		memcpy(areq->result, ctx->digeststate, digestsize);
> > +
> 
> I was just looking through the driver and digeststate does not
> appear to be aligned to the DMA cacheline, should it be?

Yes, you're right, thanks, that buffer and a few others are missing
alignment annotations.  I'll add a patch to fix that when I respin the
series.
