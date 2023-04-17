Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6546E3EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDQFaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQFax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:30:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B33126B8;
        Sun, 16 Apr 2023 22:30:49 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AF1DB75B;
        Mon, 17 Apr 2023 07:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681709442;
        bh=eovj2G78JXYDRcIrgt0oiYQ6nuD4yXkGQthiJoaUxDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+6TLzFYs7Qu8jtTZSt3cj4EjETYc6y6Vld85joRJSvPhQP3neSnGZrve8zfxONvR
         OgALy57ujP5SxzozDU3/ZCKyA1N3NBLPa8EAfzuvJTWtdDOHZht118RYSiZfseQwHO
         z8q+dGnM+gzmrIbYqsJOqJK4xGkSRct8IA+InNDg=
Date:   Mon, 17 Apr 2023 08:30:59 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: imx296: Fix error handling while reading
 temperature
Message-ID: <20230417053059.GC28551@pendragon.ideasonboard.com>
References: <827f94730c85b742f9ae66209b383a50ca79ec43.1681683246.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <827f94730c85b742f9ae66209b383a50ca79ec43.1681683246.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for the patch.

On Mon, Apr 17, 2023 at 12:14:42AM +0200, Christophe JAILLET wrote:
> If imx296_read() returns an error, its returned value is a negative value.
> But because of the "& IMX296_TMDOUT_MASK" (i.e. 0x3ff), 'tmdout' can't be
> negative.
> 
> So the error handling does not work as expected and a wrong value is used
> to compute the temperature.
> 
> Apply the IMX296_TMDOUT_MASK mask after checking for errors to fix it.
> 
> Fixes: cb33db2b6ccf ("media: i2c: IMX296 camera sensor driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Dan Carpenter has submitted the same fix in
https://lore.kernel.org/linux-media/Y%2FYf19AE78jn5YW7@kili/. Sakari,
could you please pick it up ?

> ---
>  drivers/media/i2c/imx296.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx296.c b/drivers/media/i2c/imx296.c
> index 4f22c0515ef8..c3d6d52fc772 100644
> --- a/drivers/media/i2c/imx296.c
> +++ b/drivers/media/i2c/imx296.c
> @@ -922,10 +922,12 @@ static int imx296_read_temperature(struct imx296 *sensor, int *temp)
>  	if (ret < 0)
>  		return ret;
>  
> -	tmdout = imx296_read(sensor, IMX296_TMDOUT) & IMX296_TMDOUT_MASK;
> +	tmdout = imx296_read(sensor, IMX296_TMDOUT);
>  	if (tmdout < 0)
>  		return tmdout;
>  
> +	tmdout &= IMX296_TMDOUT_MASK;
> +
>  	/* T(°C) = 246.312 - 0.304 * TMDOUT */;
>  	*temp = 246312 - 304 * tmdout;
>  

-- 
Regards,

Laurent Pinchart
