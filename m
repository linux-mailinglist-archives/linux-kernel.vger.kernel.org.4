Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2438E607535
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJUKlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:41:29 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D2B25E089;
        Fri, 21 Oct 2022 03:41:27 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1olpS3-004ceY-HY; Fri, 21 Oct 2022 18:41:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Oct 2022 18:41:07 +0800
Date:   Fri, 21 Oct 2022 18:41:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tomas Marek <tomas.marek@elrest.cz>
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au,
        mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, oleg.karfich@wago.com
Subject: Re: [PATCH 1/2] hwrng: stm32 - fix number of returned bytes on read
Message-ID: <Y1J3QwynPFIlfrIv@loth.rohan.me.apana.org.au>
References: <20221012160924.12226-1-tomas.marek@elrest.cz>
 <20221012160924.12226-2-tomas.marek@elrest.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012160924.12226-2-tomas.marek@elrest.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 06:09:23PM +0200, Tomas Marek wrote:
>
> diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
> index bc22178f83e8..8eaacefd498b 100644
> --- a/drivers/char/hw_random/stm32-rng.c
> +++ b/drivers/char/hw_random/stm32-rng.c
> @@ -49,11 +49,13 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  		/* Manage timeout which is based on timer and take */
>  		/* care of initial delay time when enabling rng	*/
>  		if (!sr && wait) {
> -			retval = readl_relaxed_poll_timeout_atomic(priv->base
> +			int ret;
> +
> +			ret = readl_relaxed_poll_timeout_atomic(priv->base

This would make a lot more sense if you called it err instead of ret.

But as you're fixing a real bug I'm going to apply your patch as is
and you can post an incremental patch to improve it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
