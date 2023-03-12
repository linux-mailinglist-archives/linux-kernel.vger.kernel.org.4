Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DAA6B6587
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCLLfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCLLe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:34:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F82CFF4;
        Sun, 12 Mar 2023 04:34:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-71-204-nat.elisa-mobile.fi [85.76.71.204])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 85617814;
        Sun, 12 Mar 2023 12:33:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678620819;
        bh=a8DkiaE3y0B8qd4PoP4jQ/AswEH3y8SaJYCdRIAiNLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YbcHPAdiPG9QX13+TFakNJ9jRNXMWWN+6iq+uPQOWr0GDa1W9QPp3qR1gm8X4vvVF
         vgziMEdAXYeCTxT/16igfVMAKhi3xI9YwmHFthEBygdeS8LZn65JVdE3Ip9HZz4wZI
         15p1+6NKLgWRIm6Cubraj5IM5LVw4QTUG/YwyNKk=
Date:   Sun, 12 Mar 2023 13:33:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v2 4/6] media: cadence: Add support for external dphy and
 JH7110 SoC
Message-ID: <20230312113338.GC2545@pendragon.ideasonboard.com>
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
 <20230310120553.60586-5-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310120553.60586-5-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Thank you for the patch.

On Fri, Mar 10, 2023 at 08:05:51PM +0800, Jack Zhu wrote:
> Add support for external MIPI D-PHY and Starfive JH7110 SoC which
> has the cadence csi2 receiver.

This patch bundles multiple changes that should be split into their own
patches. I'll comment on that below.

> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>  drivers/media/platform/cadence/cdns-csi2rx.c | 273 ++++++++++++++++++-
>  1 file changed, 263 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index cc3ebb0d96f6..7e7b096869fc 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -10,9 +10,11 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_graph.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  
>  #include <media/v4l2-ctrls.h>
> @@ -30,6 +32,12 @@
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
> @@ -37,6 +45,7 @@
>  
>  #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
>  #define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
> +#define CSI2RX_STREAM_DATA_CFG_EN_DATA_TYPE_0	BIT(7)
>  #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
>  
>  #define CSI2RX_STREAM_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x00c)
> @@ -54,8 +63,19 @@ enum csi2rx_pads {
>  	CSI2RX_PAD_MAX,
>  };
>  
> +struct csi2rx_fmt {
> +	u32				code;
> +	u8				bpp;
> +	u32				dt;
> +};
> +
> +struct csi2rx_platform_info {
> +	unsigned long sys_clk_rate;
> +};
> +
>  struct csi2rx_priv {
>  	struct device			*dev;
> +	unsigned int			power_count;
>  	unsigned int			count;
>  
>  	/*
> @@ -68,6 +88,9 @@ struct csi2rx_priv {
>  	struct clk			*sys_clk;
>  	struct clk			*p_clk;
>  	struct clk			*pixel_clk[CSI2RX_STREAMS_MAX];
> +	struct reset_control		*sys_rst;
> +	struct reset_control		*p_rst;
> +	struct reset_control		*pixel_rst[CSI2RX_STREAMS_MAX];
>  	struct phy			*dphy;
>  
>  	u8				lanes[CSI2RX_LANES_MAX];
> @@ -83,14 +106,100 @@ struct csi2rx_priv {
>  	/* Remote source */
>  	struct v4l2_subdev		*source_subdev;
>  	int				source_pad;
> +
> +	const struct csi2rx_platform_info	*platform_info;
> +};
> +
> +static const struct csi2rx_fmt formats[] = {
> +	{
> +		.code	= MEDIA_BUS_FMT_SRGGB10_1X10,
> +		.bpp	= 10,
> +		.dt	= 0x2b,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SGRBG10_1X10,
> +		.bpp	= 10,
> +		.dt	= 0x2b,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SGBRG10_1X10,
> +		.bpp	= 10,
> +		.dt	= 0x2b,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SBGGR10_1X10,
> +		.bpp	= 10,
> +		.dt	= 0x2b,
> +	},
>  };
>  
> +static u8 csi2rx_get_bpp(u32 code)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(formats); i++) {
> +		if (formats[i].code == code)
> +			return formats[i].bpp;
> +	}
> +
> +	return 0;
> +}
> +
> +static u32 csi2rx_get_dt(u32 code)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(formats); i++) {
> +		if (formats[i].code == code)
> +			return formats[i].dt;
> +	}
> +
> +	return 0;
> +}
> +
> +static s64 csi2rx_get_pixel_rate(struct csi2rx_priv *csi2rx)
> +{
> +	struct v4l2_ctrl *ctrl;
> +
> +	ctrl = v4l2_ctrl_find(csi2rx->source_subdev->ctrl_handler,
> +			      V4L2_CID_PIXEL_RATE);
> +	if (!ctrl) {
> +		dev_err(csi2rx->dev, "no pixel rate control in subdev: %s\n",
> +			csi2rx->source_subdev->name);
> +		return -EINVAL;
> +	}
> +
> +	return v4l2_ctrl_g_ctrl_int64(ctrl);
> +}
> +
>  static inline
>  struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
>  {
>  	return container_of(subdev, struct csi2rx_priv, subdev);
>  }
>  
> +static int csi2rx_s_power(struct v4l2_subdev *subdev, int on)

.s_power() is deprecated, please drop it. You should use runtime PM
instead (with autosuspend). In .s_stream(), you should call
pm_runtime_resume_and_get() when starting streaming, and
pm_runtime_put_autosuspend() when stopping streaming.

> +{
> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +
> +	mutex_lock(&csi2rx->lock);
> +
> +	if (on) {
> +		if (!csi2rx->power_count)
> +			phy_init(csi2rx->dphy);
> +
> +		csi2rx->power_count++;
> +	} else {
> +		csi2rx->power_count--;
> +
> +		if (!csi2rx->power_count)
> +			phy_exit(csi2rx->dphy);
> +	}
> +
> +	mutex_unlock(&csi2rx->lock);
> +	return 0;
> +}
> +
>  static void csi2rx_reset(struct csi2rx_priv *csi2rx)
>  {
>  	writel(CSI2RX_SOFT_RESET_PROTOCOL | CSI2RX_SOFT_RESET_FRONT,
> @@ -101,17 +210,70 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
>  	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
>  }
>  
> +static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)

Support for external DPHYs should be split to a patch of its own.

> +{
> +	union phy_configure_opts opts = { };
> +	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
> +	struct v4l2_subdev_format sd_fmt;
> +	s64 pixel_rate;
> +	int ret;
> +	u8 bpp;
> +
> +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad = 0;
> +
> +	ret = v4l2_subdev_call(csi2rx->source_subdev, pad, get_fmt, NULL,
> +			       &sd_fmt);

Don't call .get_fmt() on the source. A subdev driver should only look at
its own formats. As the format on the source pad of the source must
match the format on the sink pad of this subdev when the pipeline is
valid, you can use the format on the sink pad here.

> +	if (ret)
> +		return ret;
> +
> +	bpp = csi2rx_get_bpp(sd_fmt.format.code);
> +	if (!bpp)
> +		return -EINVAL;
> +
> +	pixel_rate = csi2rx_get_pixel_rate(csi2rx);
> +	if (pixel_rate < 0)
> +		return pixel_rate;
> +
> +	ret = phy_mipi_dphy_get_default_config(pixel_rate, bpp,
> +					       csi2rx->num_lanes, cfg);
> +	if (ret)
> +		return ret;
> +
> +	phy_pm_runtime_get_sync(csi2rx->dphy);
> +
> +	ret = phy_power_on(csi2rx->dphy);
> +	if (ret)
> +		goto out;
> +
> +	ret = phy_configure(csi2rx->dphy, &opts);
> +	if (ret) {
> +		/* Can't do anything if it fails. Ignore the return value. */
> +		phy_power_off(csi2rx->dphy);
> +		goto out;
> +	}
> +
> +out:
> +	phy_pm_runtime_put_sync(csi2rx->dphy);
> +
> +	return ret;
> +}
> +
>  static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  {
> +	struct v4l2_subdev_format sd_fmt;
>  	unsigned int i;
>  	unsigned long lanes_used = 0;
>  	u32 reg;
> +	u32 dt = 0;
>  	int ret;
>  
>  	ret = clk_prepare_enable(csi2rx->p_clk);
>  	if (ret)
>  		return ret;
>  
> +	reset_control_deassert(csi2rx->p_rst);

Support for reset controllers should also be split to a patch of its
own.

> +
>  	csi2rx_reset(csi2rx);
>  
>  	reg = csi2rx->num_lanes << 8;
> @@ -139,6 +301,29 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
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
> +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad = 0;
> +
> +	ret = v4l2_subdev_call(csi2rx->source_subdev, pad, get_fmt, NULL,
> +			       &sd_fmt);

Same as above regarding the format.

> +	if (ret)
> +		dev_warn(csi2rx->dev, "Couldn't get format\n");
> +
> +	dt = csi2rx_get_dt(sd_fmt.format.code);
> +	if (!dt)

When you reach this point, the format should be guaranteed to be valid
as .set_fmt() will have adjusted it. There should thus be no need to
handle errors.

> +		dev_warn(csi2rx->dev, "Couldn't get dt\n");
> +
>  	/*
>  	 * Create a static mapping between the CSI virtual channels
>  	 * and the output stream.
> @@ -154,6 +339,8 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  		if (ret)
>  			goto err_disable_pixclk;
>  
> +		reset_control_deassert(csi2rx->pixel_rst[i]);
> +
>  		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF,
>  		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
>  
> @@ -161,6 +348,11 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  		       CSI2RX_STREAM_DATA_CFG_VC_SELECT(i),
>  		       csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i));
>  
> +		if (dt)
> +			writel(readl(csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i)) |
> +			       CSI2RX_STREAM_DATA_CFG_EN_DATA_TYPE_0 | dt,
> +			       csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i));

Support for CSI-2 DT should be split to a patch of its own.

> +
>  		writel(CSI2RX_STREAM_CTRL_START,
>  		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
>  	}
> @@ -169,10 +361,27 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  	if (ret)
>  		goto err_disable_pixclk;
>  
> +	if (csi2rx->platform_info && csi2rx->platform_info->sys_clk_rate > 0)
> +		clk_set_rate(csi2rx->sys_clk,
> +			     csi2rx->platform_info->sys_clk_rate);
> +
> +	reset_control_deassert(csi2rx->sys_rst);
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
> @@ -188,18 +397,28 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
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
> @@ -236,11 +455,16 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
>  	return ret;
>  }
>  
> +static const struct v4l2_subdev_core_ops csi2rx_core_ops = {
> +	.s_power = csi2rx_s_power,
> +};
> +
>  static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
>  	.s_stream	= csi2rx_s_stream,
>  };
>  
>  static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
> +	.core		= &csi2rx_core_ops,
>  	.video		= &csi2rx_video_ops,
>  };
>  
> @@ -250,6 +474,8 @@ static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
>  {
>  	struct v4l2_subdev *subdev = notifier->sd;
>  	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +	struct v4l2_device *v4l2_dev;
> +	int ret;
>  
>  	csi2rx->source_pad = media_entity_get_fwnode_pad(&s_subdev->entity,
>  							 s_subdev->fwnode,
> @@ -265,6 +491,15 @@ static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
>  	dev_dbg(csi2rx->dev, "Bound %s pad: %d\n", s_subdev->name,
>  		csi2rx->source_pad);
>  
> +	/* ensure source subdev register subdev node */
> +	v4l2_dev = notifier->v4l2_dev ? notifier->v4l2_dev :
> +		notifier->parent->v4l2_dev;
> +	if (v4l2_dev) {
> +		ret = v4l2_device_register_subdev_nodes(v4l2_dev);

This belongs to the main driver (the camss in your case), not this
driver.

> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return media_create_pad_link(&csi2rx->source_subdev->entity,
>  				     csi2rx->source_pad,
>  				     &csi2rx->subdev.entity, 0,
> @@ -299,21 +534,23 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  		return PTR_ERR(csi2rx->p_clk);
>  	}
>  
> +	csi2rx->sys_rst =
> +		devm_reset_control_get_optional_exclusive(&pdev->dev,
> +							  "sys_rst");
> +	if (IS_ERR(csi2rx->sys_rst))
> +		return PTR_ERR(csi2rx->sys_rst);
> +
> +	csi2rx->p_rst =
> +		devm_reset_control_get_optional_exclusive(&pdev->dev, "p_rst");
> +	if (IS_ERR(csi2rx->p_rst))
> +		return PTR_ERR(csi2rx->p_rst);
> +
>  	csi2rx->dphy = devm_phy_optional_get(&pdev->dev, "dphy");
>  	if (IS_ERR(csi2rx->dphy)) {
>  		dev_err(&pdev->dev, "Couldn't get external D-PHY\n");
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
> @@ -343,13 +580,14 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  	 * FIXME: Once we'll have internal D-PHY support, the check
>  	 * will need to be removed.
>  	 */
> -	if (csi2rx->has_internal_dphy) {
> +	if (!csi2rx->dphy && csi2rx->has_internal_dphy) {
>  		dev_err(&pdev->dev, "Internal D-PHY not supported yet\n");
>  		return -EINVAL;
>  	}
>  
>  	for (i = 0; i < csi2rx->max_streams; i++) {
>  		char clk_name[16];
> +		char rst_name[16];
>  
>  		snprintf(clk_name, sizeof(clk_name), "pixel_if%u_clk", i);
>  		csi2rx->pixel_clk[i] = devm_clk_get(&pdev->dev, clk_name);
> @@ -357,6 +595,13 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
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
> @@ -425,6 +670,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>  	csi2rx = kzalloc(sizeof(*csi2rx), GFP_KERNEL);
>  	if (!csi2rx)
>  		return -ENOMEM;
> +	csi2rx->platform_info = of_device_get_match_data(&pdev->dev);
>  	platform_set_drvdata(pdev, csi2rx);
>  	csi2rx->dev = &pdev->dev;
>  	mutex_init(&csi2rx->lock);
> @@ -441,6 +687,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>  	csi2rx->subdev.dev = &pdev->dev;
>  	v4l2_subdev_init(&csi2rx->subdev, &csi2rx_subdev_ops);
>  	v4l2_set_subdevdata(&csi2rx->subdev, &pdev->dev);
> +	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>  	snprintf(csi2rx->subdev.name, V4L2_SUBDEV_NAME_SIZE, "%s.%s",
>  		 KBUILD_MODNAME, dev_name(&pdev->dev));
>  
> @@ -462,6 +709,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev,
>  		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
>  		 csi2rx->num_lanes, csi2rx->max_lanes, csi2rx->max_streams,
> +		 csi2rx->dphy ? "external" :
>  		 csi2rx->has_internal_dphy ? "internal" : "no");
>  
>  	return 0;
> @@ -483,8 +731,13 @@ static int csi2rx_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct csi2rx_platform_info stf_jh7110_info = {
> +	.sys_clk_rate = 297000000,

This sounds like something that would be better handled through the
assigned-clock-rates property in DT.

> +};
> +
>  static const struct of_device_id csi2rx_of_table[] = {
>  	{ .compatible = "cdns,csi2rx" },
> +	{ .compatible = "starfive,jh7110-csi2rx", .data = &stf_jh7110_info },

I would move SoC-specific compatible strings before the generic one.
Maxime, is there a need to keep the generic compatible string now that
we have SoC-specific support ?

>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, csi2rx_of_table);

-- 
Regards,

Laurent Pinchart
