Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A015765FE63
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjAFJw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjAFJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:52:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BC134D52;
        Fri,  6 Jan 2023 01:52:23 -0800 (PST)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 32E9E4AE;
        Fri,  6 Jan 2023 10:52:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672998742;
        bh=lIAU0L9csCgQrcqU9s1hO62N1jxYfhqjohcIhTHMs94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLFTKZJX9Ytap9LP8zNRjVo5qfOVf7PJCKkMZFeCpCAE8E2i6ED7xD/AAcNlWEJOf
         cSaEfDlktMwUTGpv5f9Zj+1wlbnyC39Trs9una2Yt+5uGAZ+eRrxgB9XQ47buMwzeO
         BkKUShJDcydKAV7AFL+1smS3w2ADnNX1MwWybtKI=
Date:   Fri, 6 Jan 2023 10:52:19 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/4] media: i2c: imx334: add missing reset values for
 mode 3840x2160_regs[]
Message-ID: <20230106095219.ar6zqwyu7u5dusq6@uno.localdomain>
References: <20230106072931.2317597-1-shravan.chippa@microchip.com>
 <20230106072931.2317597-3-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230106072931.2317597-3-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan

On Fri, Jan 06, 2023 at 12:59:29PM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>
> There are some missing reset reg_mode values for the 3840x2160@60
> resolution. The camera sensor still works in 3840x2160@60 resolution mode
> because of the register reset values. This is an issue when we change the
> modes dynamically. As an example, when we change the mode from 1920x1080@30
>  resolution to 3840x2160@60 resoultion then the mode values will be written
 ^ rogue space

> to the registers from the array mode_3840x2160_regs[] which gives the wrong
> output which is incorrect resolution.
>
> So add the missing reset values to the mode_3840x2160_regs[].
>

Are you resetting the registers to their default values, or are they
actually tuned for 3840x2160 operations ?

> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index ebacba3059b3..a4549d194cae 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -166,6 +166,7 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
>  	{0x3288, 0x21},
>  	{0x328a, 0x02},
>  	{0x302c, 0x3c},
> +	{0x302d, 0x00},
>  	{0x302e, 0x00},
>  	{0x302f, 0x0f},
>  	{0x3076, 0x70},
> @@ -240,7 +241,26 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
>  	{0x3794, 0x7a},
>  	{0x3796, 0xa1},
>  	{0x3e04, 0x0e},
> +	{0x319e, 0x00},
>  	{0x3a00, 0x01},
> +	{0x3A18, 0xBF},
> +	{0x3A19, 0x00},
> +	{0x3A1A, 0x67},
> +	{0x3A1B, 0x00},
> +	{0x3A1C, 0x6F},
> +	{0x3A1D, 0x00},
> +	{0x3A1E, 0xD7},
> +	{0x3A1F, 0x01},
> +	{0x3A20, 0x6F},
> +	{0x3A21, 0x00},
> +	{0x3A22, 0xCF},
> +	{0x3A23, 0x00},
> +	{0x3A24, 0x6F},
> +	{0x3A25, 0x00},
> +	{0x3A26, 0xB7},
> +	{0x3A27, 0x00},
> +	{0x3A28, 0x5F},
> +	{0x3A29, 0x00},

Nit: this is a small bunch of registers, and all the rest of the table
uses lowercase. Please do the same for sake of consistency.

Thanks
  j


>  };
>
>  /* Supported sensor mode configurations */
> --
> 2.34.1
>
