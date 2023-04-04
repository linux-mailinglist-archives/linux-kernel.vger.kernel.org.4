Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307C96D57D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjDDFGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjDDFGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:06:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F9F1BDB;
        Mon,  3 Apr 2023 22:06:10 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A4002DD;
        Tue,  4 Apr 2023 07:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680584768;
        bh=9GWrMYDb3U4UEOCVUm6RA9iWuelR9UXKNj3mKCqSmK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5dsM6kiUs2Vsy1BURmaChruAsivnCgHFUCDZsmQQ9J+XHCQJIX6ppQm0JodF3iMo
         tZn5XgR16GJ/W/pZcEdlF3Vb9RugFIj7dTrd1ugQwsZTgOWoIhwpe+Xgd/DtRKpl30
         /W60QDWAEaFn/YPuVdnfrGMi2i8IPLH+vQW+JIVo=
Date:   Tue, 4 Apr 2023 08:06:15 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v3 6/9] media: cadence: Add operation on reset
Message-ID: <20230404050615.GN16648@pendragon.ideasonboard.com>
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
 <20230331121826.96973-7-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230331121826.96973-7-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Thank you for the patch.

On Fri, Mar 31, 2023 at 08:18:23PM +0800, Jack Zhu wrote:
> Add operation on reset for Cadence MIPI-CSI2 RX Controller.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>  drivers/media/platform/cadence/cdns-csi2rx.c | 30 ++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index cc3ebb0d96f6..a1555cedb349 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -13,6 +13,7 @@
>  #include <linux/of_graph.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  
>  #include <media/v4l2-ctrls.h>
> @@ -68,6 +69,9 @@ struct csi2rx_priv {
>  	struct clk			*sys_clk;
>  	struct clk			*p_clk;
>  	struct clk			*pixel_clk[CSI2RX_STREAMS_MAX];
> +	struct reset_control		*sys_rst;
> +	struct reset_control		*p_rst;
> +	struct reset_control		*pixel_rst[CSI2RX_STREAMS_MAX];
>  	struct phy			*dphy;
>  
>  	u8				lanes[CSI2RX_LANES_MAX];
> @@ -112,6 +116,7 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  	if (ret)
>  		return ret;
>  
> +	reset_control_deassert(csi2rx->p_rst);
>  	csi2rx_reset(csi2rx);
>  
>  	reg = csi2rx->num_lanes << 8;
> @@ -154,6 +159,8 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  		if (ret)
>  			goto err_disable_pixclk;

The loop after the err_disable_pixclk label should assert the
pixel_rst[i] reset.

>  
> +		reset_control_deassert(csi2rx->pixel_rst[i]);
> +
>  		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF,
>  		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
>  
> @@ -169,6 +176,7 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  	if (ret)
>  		goto err_disable_pixclk;
>  
> +	reset_control_deassert(csi2rx->sys_rst);
>  	clk_disable_unprepare(csi2rx->p_clk);
>  
>  	return 0;
> @@ -188,14 +196,17 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
>  	unsigned int i;
>  
>  	clk_prepare_enable(csi2rx->p_clk);
> +	reset_control_assert(csi2rx->sys_rst);
>  	clk_disable_unprepare(csi2rx->sys_clk);
>  
>  	for (i = 0; i < csi2rx->max_streams; i++) {
>  		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
>  
> +		reset_control_assert(csi2rx->pixel_rst[i]);
>  		clk_disable_unprepare(csi2rx->pixel_clk[i]);
>  	}
>  
> +	reset_control_assert(csi2rx->p_rst);
>  	clk_disable_unprepare(csi2rx->p_clk);
>  
>  	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
> @@ -299,6 +310,17 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  		return PTR_ERR(csi2rx->p_clk);
>  	}
>  
> +	csi2rx->sys_rst =
> +		devm_reset_control_get_optional_exclusive(&pdev->dev,
> +							  "sys_rst");

You can write this on two lines:

	csi2rx->sys_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
								    "sys_rst");
> +	if (IS_ERR(csi2rx->sys_rst))
> +		return PTR_ERR(csi2rx->sys_rst);
> +
> +	csi2rx->p_rst =
> +		devm_reset_control_get_optional_exclusive(&pdev->dev, "p_rst");

And here,

	csi2rx->p_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
								  "p_rst");

would be the same number of lines but more readable in my opinion.

> +	if (IS_ERR(csi2rx->p_rst))
> +		return PTR_ERR(csi2rx->p_rst);
> +
>  	csi2rx->dphy = devm_phy_optional_get(&pdev->dev, "dphy");
>  	if (IS_ERR(csi2rx->dphy)) {
>  		dev_err(&pdev->dev, "Couldn't get external D-PHY\n");
> @@ -350,6 +372,7 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  
>  	for (i = 0; i < csi2rx->max_streams; i++) {
>  		char clk_name[16];
> +		char rst_name[16];

You don't need two variables, you can rename clk_name to name, and use
it for both clk and rst.

With these small issues addressed you can add my

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

in the next version.

>  
>  		snprintf(clk_name, sizeof(clk_name), "pixel_if%u_clk", i);
>  		csi2rx->pixel_clk[i] = devm_clk_get(&pdev->dev, clk_name);
> @@ -357,6 +380,13 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  			dev_err(&pdev->dev, "Couldn't get clock %s\n", clk_name);
>  			return PTR_ERR(csi2rx->pixel_clk[i]);
>  		}
> +
> +		snprintf(rst_name, sizeof(rst_name), "pixel_if%u_rst", i);
> +		csi2rx->pixel_rst[i] =
> +			devm_reset_control_get_optional_exclusive(&pdev->dev,
> +								  rst_name);
> +		if (IS_ERR(csi2rx->pixel_rst[i]))
> +			return PTR_ERR(csi2rx->pixel_rst[i]);
>  	}
>  
>  	return 0;

-- 
Regards,

Laurent Pinchart
