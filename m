Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB423669113
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjAMIgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjAMIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:36:06 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36860DE;
        Fri, 13 Jan 2023 00:36:04 -0800 (PST)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F0BD4D4;
        Fri, 13 Jan 2023 09:36:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673598963;
        bh=VQT4BG0dE+fL3/VcbSF1FpPnNRKBiUQgGWK5hdEYWqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJ7rt7DkySsQdmkcfak19ltcH4h0QFqnnFEJA9Wb0SCn3Jrzi7j1DK3Q3FbJF5Xid
         Va+g2s23aR1V6yjdvZeFYoDqg6s8bG3yweNHZVFAsuCCNBoiPKrddQKwzWo1YTdTUX
         JwE71sjMRdLsIagRjiUvYTggHsB7nJUx/9Csg+Vo=
Date:   Fri, 13 Jan 2023 09:36:01 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/4] media: i2c: imx334: add missing reset values for
 mode 3840x2160_regs[]
Message-ID: <20230113083601.ctvydmuayeslo2b2@uno.localdomain>
References: <20230113010135.2620818-1-shravan.chippa@microchip.com>
 <20230113010135.2620818-3-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230113010135.2620818-3-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan

On Fri, Jan 13, 2023 at 06:31:33AM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>
> There are some missing reset reg_mode values for the 3840x2160@60
> resolution. The camera sensor still works in 3840x2160@60 resolution mode
> because of the register reset values. This is an issue when we change the
> modes dynamically. As an example, when we change the mode from 1920x1080@30
>  resolution to 3840x2160@60 resoultion then the mode values will be written
 ^ rougue space

> to the registers from the array mode_3840x2160_regs[] which gives the wrong
> output which is incorrect resolution.
>
> So add the missing reset values to the mode_3840x2160_regs[].
>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>

Not checking the register values as I don't have a datasheet

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

> ---
>  drivers/media/i2c/imx334.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index ebacba3059b3..40ece08f20f5 100644
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
> +	{0x3a18, 0xbf},
> +	{0x3a19, 0x00},
> +	{0x3a1a, 0x67},
> +	{0x3a1b, 0x00},
> +	{0x3a1c, 0x6f},
> +	{0x3a1d, 0x00},
> +	{0x3a1e, 0xd7},
> +	{0x3a1f, 0x01},
> +	{0x3a20, 0x6f},
> +	{0x3a21, 0x00},
> +	{0x3a22, 0xcf},
> +	{0x3a23, 0x00},
> +	{0x3a24, 0x6f},
> +	{0x3a25, 0x00},
> +	{0x3a26, 0xb7},
> +	{0x3a27, 0x00},
> +	{0x3a28, 0x5f},
> +	{0x3a29, 0x00},
>  };
>
>  /* Supported sensor mode configurations */
> --
> 2.34.1
>
