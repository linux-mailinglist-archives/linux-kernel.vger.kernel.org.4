Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F1C6D57C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjDDEzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDDEzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:55:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A28C1BD3;
        Mon,  3 Apr 2023 21:55:31 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0F2D48B;
        Tue,  4 Apr 2023 06:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680584130;
        bh=5uL4oIBoFMHFkQ5Gr4oonHd/VCDxMP7J0OJm0Xetvrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqyUy0ykuBYF2dB2e+ug7oIIwfkWvQovQyk07IbzRc93YNmhqcwiMBClKOzc095Pj
         ZWHrjKBaW9XBU6NFgXFd8NgY02VIxlkzHYp0JFfjXEvEM9PfzS6M19POQlMvdkgLLn
         qzePEhpuToQ4x75XTDW8ns98NRwLUBFu+PUy3dZI=
Date:   Tue, 4 Apr 2023 07:55:35 +0300
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
Subject: Re: [PATCH v3 7/9] media: cadence: Add support for external dphy
Message-ID: <20230404045535.GL16648@pendragon.ideasonboard.com>
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
 <20230331121826.96973-8-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230331121826.96973-8-jack.zhu@starfivetech.com>
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

On Fri, Mar 31, 2023 at 08:18:24PM +0800, Jack Zhu wrote:
> Add support for external MIPI D-PHY.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/cadence/cdns-csi2rx.c | 66 +++++++++++++++++---
>  1 file changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index a1555cedb349..add982edce64 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -31,6 +31,12 @@
>  #define CSI2RX_STATIC_CFG_DLANE_MAP(llane, plane)	((plane) << (16 + (llane) * 4))
>  #define CSI2RX_STATIC_CFG_LANES_MASK			GENMASK(11, 8)
>  
> +#define CSI2RX_DPHY_LANE_CTRL_REG		0x40
> +#define CSI2RX_DPHY_CL_RST			BIT(16)
> +#define CSI2RX_DPHY_DL_RST(i)			BIT((i) + 12)
> +#define CSI2RX_DPHY_CL_EN			BIT(4)
> +#define CSI2RX_DPHY_DL_EN(i)			BIT(i)
> +
>  #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
>  
>  #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
> @@ -105,6 +111,24 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
>  	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
>  }
>  
> +static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
> +{
> +	union phy_configure_opts opts = { };
> +	int ret;
> +
> +	ret = phy_power_on(csi2rx->dphy);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_configure(csi2rx->dphy, &opts);
> +	if (ret) {
> +		phy_power_off(csi2rx->dphy);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  {
>  	unsigned int i;
> @@ -144,6 +168,17 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  	if (ret)
>  		goto err_disable_pclk;
>  
> +	/* Enable DPHY clk and data lanes. */
> +	if (csi2rx->dphy) {
> +		reg = CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
> +		for (i = 0; i < csi2rx->num_lanes; i++) {
> +			reg |= CSI2RX_DPHY_DL_EN(csi2rx->lanes[i] - 1);
> +			reg |= CSI2RX_DPHY_DL_RST(csi2rx->lanes[i] - 1);
> +		}
> +
> +		writel(reg, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> +	}
> +
>  	/*
>  	 * Create a static mapping between the CSI virtual channels
>  	 * and the output stream.
> @@ -177,10 +212,22 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  		goto err_disable_pixclk;
>  
>  	reset_control_deassert(csi2rx->sys_rst);
> +
> +	if (csi2rx->dphy) {
> +		ret = csi2rx_configure_ext_dphy(csi2rx);
> +		if (ret) {
> +			dev_err(csi2rx->dev,
> +				"Failed to configure external DPHY: %d\n", ret);
> +			goto err_disable_sysclk;
> +		}
> +	}
> +
>  	clk_disable_unprepare(csi2rx->p_clk);
>  
>  	return 0;
>  
> +err_disable_sysclk:
> +	clk_disable_unprepare(csi2rx->sys_clk);
>  err_disable_pixclk:
>  	for (; i > 0; i--)
>  		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
> @@ -211,6 +258,13 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
>  
>  	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
>  		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
> +
> +	if (csi2rx->dphy) {
> +		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> +
> +		if (phy_power_off(csi2rx->dphy))
> +			dev_warn(csi2rx->dev, "Couldn't power off DPHY\n");
> +	}
>  }
>  
>  static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
> @@ -327,15 +381,6 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  		return PTR_ERR(csi2rx->dphy);
>  	}
>  
> -	/*
> -	 * FIXME: Once we'll have external D-PHY support, the check
> -	 * will need to be removed.
> -	 */
> -	if (csi2rx->dphy) {
> -		dev_err(&pdev->dev, "External D-PHY not supported yet\n");
> -		return -EINVAL;
> -	}
> -
>  	ret = clk_prepare_enable(csi2rx->p_clk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Couldn't prepare and enable P clock\n");
> @@ -365,7 +410,7 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  	 * FIXME: Once we'll have internal D-PHY support, the check
>  	 * will need to be removed.
>  	 */
> -	if (csi2rx->has_internal_dphy) {
> +	if (!csi2rx->dphy && csi2rx->has_internal_dphy) {
>  		dev_err(&pdev->dev, "Internal D-PHY not supported yet\n");
>  		return -EINVAL;
>  	}
> @@ -492,6 +537,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev,
>  		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
>  		 csi2rx->num_lanes, csi2rx->max_lanes, csi2rx->max_streams,
> +		 csi2rx->dphy ? "external" :
>  		 csi2rx->has_internal_dphy ? "internal" : "no");
>  
>  	return 0;

-- 
Regards,

Laurent Pinchart
