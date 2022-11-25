Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4106385A5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiKYI4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKYI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:56:34 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E02129809;
        Fri, 25 Nov 2022 00:56:33 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyUVT-000h4L-9x; Fri, 25 Nov 2022 16:56:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 16:56:23 +0800
Date:   Fri, 25 Nov 2022 16:56:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     ye.xingchen@zte.com.cn
Cc:     olivia@selenic.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] hwrng: n2-drv - Use device_get_match_data()
 to simplify the?? code
Message-ID: <Y4CDN4eWfXtAKAdN@gondor.apana.org.au>
References: <202211171710153200734@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211171710153200734@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:10:15PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Directly get the match data with device_get_match_data().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/char/hw_random/n2-drv.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
> index 73e408146420..2f784addb717 100644
> --- a/drivers/char/hw_random/n2-drv.c
> +++ b/drivers/char/hw_random/n2-drv.c
> @@ -695,20 +695,15 @@ static void n2rng_driver_version(void)
>  static const struct of_device_id n2rng_match[];
>  static int n2rng_probe(struct platform_device *op)
>  {
> -	const struct of_device_id *match;
>  	int err = -ENOMEM;
>  	struct n2rng *np;
> 
> -	match = of_match_device(n2rng_match, &op->dev);
> -	if (!match)
> -		return -EINVAL;
> -
>  	n2rng_driver_version();
>  	np = devm_kzalloc(&op->dev, sizeof(*np), GFP_KERNEL);
>  	if (!np)
>  		goto out;
>  	np->op = op;
> -	np->data = (struct n2rng_template *)match->data;
> +	np->data = (struct n2rng_template *) device_get_match_data(&op->dev);

Please explain why changing the error case is OK.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
