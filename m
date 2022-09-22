Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678D65E649B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiIVOCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiIVOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:01:57 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62583D0795;
        Thu, 22 Sep 2022 07:01:55 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 304A8201342;
        Thu, 22 Sep 2022 14:01:53 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 2B27B80607; Thu, 22 Sep 2022 15:51:05 +0200 (CEST)
Date:   Thu, 22 Sep 2022 15:51:05 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] random: throttle hwrng writes if no entropy is credited
Message-ID: <YyxoSV3p0JPMMeWO@owl.dominikbrodowski.net>
References: <20220920141438.2782446-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920141438.2782446-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

thanks for splitting this change out of my other patch. You can add my
Signed-off-by, but I'd like to suggest rewriting the commit message as
follows (please modify as needed):


In case a hwrng source does not provide (trusted) entropy, it cannot
assist in initializing the CRNG. Therefore, in case
add_hwgenerator_randomness() is called with the entropy parameter set
to zero, go to sleep until one reseed interval has passed.

While the hwrng thread currently only runs under conditions where this
is non-zero, this change is not harmful and prepares for future updates
to the hwrng core.


Thanks,
	Dominik




Am Tue, Sep 20, 2022 at 04:14:38PM +0200 schrieb Jason A. Donenfeld:
> This value is currently never set to zero, because the hwrng thread only
> runs if it's going to be non-zero. This is an oversight, however, that
> Dominik is working on fixing. In preparation for this, and so that
> there's less coordination required between my tree and Herbert's, make
> this currently useless, but not harmful, change here now, in hopes that
> Dominik can make the corresponding change in the hwrng core later.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 16e0c5f6cf2f..520a385c7dab 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -865,9 +865,9 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
>  
>  	/*
>  	 * Throttle writing to once every reseed interval, unless we're not yet
> -	 * initialized.
> +	 * initialized or no entropy is credited.
>  	 */
> -	if (!kthread_should_stop() && crng_ready())
> +	if (!kthread_should_stop() && (crng_ready() || !entropy))
>  		schedule_timeout_interruptible(crng_reseed_interval());
>  }
>  EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
> -- 
> 2.37.3
> 
