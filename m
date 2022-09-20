Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0636B5BE436
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiITLPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiITLPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:15:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440AF5A88F;
        Tue, 20 Sep 2022 04:15:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 08220415;
        Tue, 20 Sep 2022 13:15:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663672509;
        bh=i0Jv0Y5a3WhqdpYRmI+zPfQuWii27DpRd00nSJNjruU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1yt5Yb48jgYu2vpphvBgSwwGUWRL2BGvf0t4xrDL+qNU2KrbsnfBQGOJxCAhuHq7
         fzEvpvM1kA1yweixUA/9UYcQn3R2ZRJOdn/Ix0nWWDB1swHT1V7OI1ZAdCYVNuwVZF
         NVQ6sFpph1Yjepd26i2b8JBqazLGsi8VjlKiNEvc=
Date:   Tue, 20 Sep 2022 14:14:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        jacopo@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <Yymgr3pdbNWq6hn0@pendragon.ideasonboard.com>
References: <20220916134535.128131-1-m.felsch@pengutronix.de>
 <20220916134535.128131-5-m.felsch@pengutronix.de>
 <YyhktzmcgXKnrMFU@pendragon.ideasonboard.com>
 <20220919171142.6av6ap5gwweldado@pengutronix.de>
 <Yyio06jhK13BiNiP@pendragon.ideasonboard.com>
 <20220920104854.2wugqxffkf4qeib6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220920104854.2wugqxffkf4qeib6@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Tue, Sep 20, 2022 at 12:48:54PM +0200, Marco Felsch wrote:
> On 22-09-19, Laurent Pinchart wrote:
> > On Mon, Sep 19, 2022 at 07:11:42PM +0200, Marco Felsch wrote:
> > > On 22-09-19, Laurent Pinchart wrote:
> > > > On Fri, Sep 16, 2022 at 03:45:35PM +0200, Marco Felsch wrote:
> > > > > Adding support for the TC358746 parallel <-> MIPI CSI bridge. This chip
> > > > > supports two operating modes:
> > > > >   1st) parallel-in -> mipi-csi out
> > > > >   2nd) mipi-csi in -> parallel out
> > > > > 
> > > > > This patch only adds the support for the 1st mode.
> > > > > 
> > > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > > ---
> > > > > Changelog:
> > > > > 
> > > > > v2:
> > > > > - use the correct CID_LINK_FREQ control to query the sensor_pclk_rate
> > > > > - remove now not needed tc358746_link_setup() and
> > > > >   struct v4l2_ctrl sensor_pclk_ctrl
> > > > > - call v4l2_subdev_link_validate_default() during link validation
> > > > > - remove MEDIA_BUS_FMT_GBR888_1X24/YUV444 format support
> > > > > - use subdev active_state API
> > > > > - replace own .get_fmt with v4l2_subdev_get_fmt
> > > > > - remove unnecessary pad checks
> > > > > - restructure tc358746_get_format_by_code() if-case
> > > > > - move apply_dphy_config|apply_misc_config from resume intos s_stream
> > > > > - use goto in s_stream enable case
> > > > > - fix error handling in suspend/resume
> > > > > - split probe() into more sub-functions
> > > > > - use dev_dbg() for printing successful probe
> > > > > 
> > > > >  drivers/media/i2c/Kconfig    |   17 +
> > > > >  drivers/media/i2c/Makefile   |    1 +
> > > > >  drivers/media/i2c/tc358746.c | 1682 ++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 1700 insertions(+)
> > > > >  create mode 100644 drivers/media/i2c/tc358746.c
> > > > > 
> > > > > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > > > > index 7806d4b81716..aefb9c9e0c08 100644
> > > > > --- a/drivers/media/i2c/Kconfig
> > > > > +++ b/drivers/media/i2c/Kconfig
> > > > > @@ -1272,6 +1272,23 @@ config VIDEO_TC358743_CEC
> > > > >  	  When selected the tc358743 will support the optional
> > > > >  	  HDMI CEC feature.
> > > > >  
> > > > > +config VIDEO_TC358746
> > > > > +	tristate "Toshiba TC358746 parallel-CSI2 bridge"
> > > > > +	depends on VIDEO_DEV && I2C
> > > > > +	select VIDEO_V4L2_SUBDEV_API
> > > > > +	select MEDIA_CONTROLLER
> > > > > +	select V4L2_FWNODE
> > > > > +	select GENERIC_PHY_MIPI_DPHY
> > > > > +	select REGMAP_I2C
> > > > > +	select COMMON_CLK
> > > > > +	help
> > > > > +	  Support for the Toshiba TC358746 parallel to MIPI CSI-2 bridge.
> > > > > +	  The bridge can work in both directions but currently only the
> > > > > +	  parallel-in / csi-out path is supported.
> > > > > +
> > > > > +	  To compile this driver as a module, choose M here: the
> > > > > +	  module will be called tc358746.
> > > > > +
> > > > >  config VIDEO_TVP514X
> > > > >  	tristate "Texas Instruments TVP514x video decoder"
> > > > >  	depends on VIDEO_DEV && I2C
> > > > > diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> > > > > index 0a2933103dd9..d1096c2ab480 100644
> > > > > --- a/drivers/media/i2c/Makefile
> > > > > +++ b/drivers/media/i2c/Makefile
> > > > > @@ -118,6 +118,7 @@ obj-$(CONFIG_VIDEO_SONY_BTF_MPX) += sony-btf-mpx.o
> > > > >  obj-$(CONFIG_VIDEO_SR030PC30) += sr030pc30.o
> > > > >  obj-$(CONFIG_VIDEO_ST_MIPID02) += st-mipid02.o
> > > > >  obj-$(CONFIG_VIDEO_TC358743) += tc358743.o
> > > > > +obj-$(CONFIG_VIDEO_TC358746) += tc358746.o
> > > > >  obj-$(CONFIG_VIDEO_TDA1997X) += tda1997x.o
> > > > >  obj-$(CONFIG_VIDEO_TDA7432) += tda7432.o
> > > > >  obj-$(CONFIG_VIDEO_TDA9840) += tda9840.o
> > > > > diff --git a/drivers/media/i2c/tc358746.c b/drivers/media/i2c/tc358746.c
> > > > > new file mode 100644
> > > > > index 000000000000..4f1a809b9fc3
> > > > > --- /dev/null
> > > > > +++ b/drivers/media/i2c/tc358746.c
> > > > > @@ -0,0 +1,1682 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * TC358746 - Parallel <-> CSI-2 Bridge
> > > > > + *
> > > > > + * Copyright 2022 Marco Felsch <kernel@pengutronix.de>
> > > > > + *
> > > > > + * Notes:
> > > > > + *  - Currently only 'Parallel-in -> CSI-out' mode is supported!
> > > > > + */
> > > > > +
> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/clk-provider.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/i2c.h>
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/phy/phy-mipi-dphy.h>
> > > > > +#include <linux/property.h>
> > > > > +#include <linux/pm_runtime.h>
> > > > > +#include <linux/regmap.h>
> > > > > +#include <media/v4l2-ctrls.h>
> > > > > +#include <media/v4l2-device.h>
> > > > > +#include <media/v4l2-fwnode.h>
> > > > > +#include <media/v4l2-mc.h>
> > > > > +
> > > > > +/* 16-bit registers */
> > > > > +#define CHIPID_REG			0x0000
> > > > > +#define		CHIPID			GENMASK(15, 8)
> > > > > +
> > > > > +#define SYSCTL_REG			0x0002
> > > > > +#define		SRESET			BIT(0)
> > > > > +
> > > > > +#define CONFCTL_REG			0x0004
> > > > > +#define		PDATAF_MASK		GENMASK(9, 8)
> > > > > +#define		PDATAF_MODE0		0
> > > > > +#define		PDATAF_MODE1		1
> > > > > +#define		PDATAF_MODE2		2
> > > > > +#define		PDATAF(val)		FIELD_PREP(PDATAF_MASK, (val))
> > > > > +#define		PPEN			BIT(6)
> > > > > +#define		DATALANE_MASK		GENMASK(1, 0)
> > > > > +
> > > > > +#define FIFOCTL_REG			0x0006
> > > > > +#define DATAFMT_REG			0x0008
> > > > > +#define		PDFMT(val)		FIELD_PREP(GENMASK(7, 4), (val))
> > > > > +
> > > > > +#define MCLKCTL_REG			0x000c
> > > > > +#define		MCLK_HIGH_MASK		GENMASK(15, 8)
> > > > > +#define		MCLK_LOW_MASK		GENMASK(7, 0)
> > > > > +#define		MCLK_HIGH(val)		FIELD_PREP(MCLK_HIGH_MASK, (val))
> > > > > +#define		MCLK_LOW(val)		FIELD_PREP(MCLK_LOW_MASK, (val))
> > > > > +
> > > > > +#define PLLCTL0_REG			0x0016
> > > > > +#define		PLL_PRD_MASK		GENMASK(15, 12)
> > > > > +#define		PLL_PRD(val)		FIELD_PREP(PLL_PRD_MASK, (val))
> > > > > +#define		PLL_FBD_MASK		GENMASK(8, 0)
> > > > > +#define		PLL_FBD(val)		FIELD_PREP(PLL_FBD_MASK, (val))
> > > > > +
> > > > > +#define PLLCTL1_REG			0x0018
> > > > > +#define		PLL_FRS_MASK		GENMASK(11, 10)
> > > > > +#define		PLL_FRS(val)		FIELD_PREP(PLL_FRS_MASK, (val))
> > > > > +#define		CKEN			BIT(4)
> > > > > +#define		RESETB			BIT(1)
> > > > > +#define		PLL_EN			BIT(0)
> > > > > +
> > > > > +#define CLKCTL_REG			0x0020
> > > > > +#define		MCLKDIV_MASK		GENMASK(3, 2)
> > > > > +#define		MCLKDIV(val)		FIELD_PREP(MCLKDIV_MASK, (val))
> > > > > +#define		MCLKDIV_8		0
> > > > > +#define		MCLKDIV_4		1
> > > > > +#define		MCLKDIV_2		2
> > > > > +
> > > > > +#define WORDCNT_REG			0x0022
> > > > > +#define PP_MISC_REG			0x0032
> > > > > +#define		FRMSTOP			BIT(15)
> > > > > +#define		RSTPTR			BIT(14)
> > > > > +
> > > > > +/* 32-bit registers */
> > > > > +#define CLW_DPHYCONTTX_REG		0x0100
> > > > > +#define CLW_CNTRL_REG			0x0140
> > > > > +#define D0W_CNTRL_REG			0x0144
> > > > > +#define		LANEDISABLE		BIT(0)
> > > > > +
> > > > > +#define STARTCNTRL_REG			0x0204
> > > > > +#define		START			BIT(0)
> > > > > +
> > > > > +#define LINEINITCNT_REG			0x0210
> > > > > +#define LPTXTIMECNT_REG			0x0214
> > > > > +#define TCLK_HEADERCNT_REG		0x0218
> > > > > +#define		TCLK_ZEROCNT(val)	FIELD_PREP(GENMASK(15, 8), (val))
> > > > > +#define		TCLK_PREPARECNT(val)	FIELD_PREP(GENMASK(6, 0), (val))
> > > > > +
> > > > > +#define TCLK_TRAILCNT_REG		0x021C
> > > > > +#define THS_HEADERCNT_REG		0x0220
> > > > > +#define		THS_ZEROCNT(val)	FIELD_PREP(GENMASK(14, 8), (val))
> > > > > +#define		THS_PREPARECNT(val)	FIELD_PREP(GENMASK(6, 0), (val))
> > > > > +
> > > > > +#define TWAKEUP_REG			0x0224
> > > > > +#define TCLK_POSTCNT_REG		0x0228
> > > > > +#define THS_TRAILCNT_REG		0x022C
> > > > > +#define HSTXVREGEN_REG			0x0234
> > > > > +#define TXOPTIONCNTRL_REG		0x0238
> > > > > +#define CSI_CONTROL_REG			0x040C
> > > > > +#define		CSI_MODE		BIT(15)
> > > > > +#define		TXHSMD			BIT(7)
> > > > > +#define		NOL(val)		FIELD_PREP(GENMASK(2, 1), (val))
> > > > > +
> > > > > +#define CSI_CONFW_REG			0x0500
> > > > > +#define		MODE(val)		FIELD_PREP(GENMASK(31, 29), (val))
> > > > > +#define		MODE_SET		0x5
> > > > > +#define		ADDRESS(val)		FIELD_PREP(GENMASK(28, 24), (val))
> > > > > +#define		CSI_CONTROL_ADDRESS	0x3
> > > > > +#define		DATA(val)		FIELD_PREP(GENMASK(15, 0), (val))
> > > > > +
> > > > > +#define CSI_START_REG			0x0518
> > > > > +#define		STRT			BIT(0)
> > > > > +
> > > > > +static const struct v4l2_mbus_framefmt tc358746_def_fmt = {
> > > > > +	.width		= 640,
> > > > > +	.height		= 480,
> > > > > +	.code		= MEDIA_BUS_FMT_UYVY8_2X8,
> > > > > +	.field		= V4L2_FIELD_NONE,
> > > > > +	.colorspace	= V4L2_COLORSPACE_DEFAULT,
> > > > > +	.ycbcr_enc	= V4L2_YCBCR_ENC_DEFAULT,
> > > > > +	.quantization	= V4L2_QUANTIZATION_DEFAULT,
> > > > > +	.xfer_func	= V4L2_XFER_FUNC_DEFAULT,
> > > > > +};
> > > > > +
> > > > > +static const char * const tc358746_supplies[] = {
> > > > > +	"vddc", "vddio", "vddmipi"
> > > > > +};
> > > > > +
> > > > > +enum {
> > > > > +	TC358746_SINK,
> > > > > +	TC358746_SOURCE,
> > > > > +	TC358746_NR_PADS
> > > > > +};
> > > > > +
> > > > > +struct tc358746 {
> > > > > +	struct v4l2_subdev		sd;
> > > > > +	struct media_pad		pads[TC358746_NR_PADS];
> > > > > +	struct v4l2_async_notifier	notifier;
> > > > > +	struct v4l2_fwnode_endpoint	csi_vep;
> > > > > +
> > > > > +	struct v4l2_ctrl_handler	ctrl_hdl;
> > > > > +
> > > > > +	struct regmap			*regmap;
> > > > > +	struct clk			*refclk;
> > > > > +	struct gpio_desc		*reset_gpio;
> > > > > +	struct regulator_bulk_data	supplies[ARRAY_SIZE(tc358746_supplies)];
> > > > > +
> > > > > +	struct clk_hw			mclk_hw;
> > > > > +	unsigned long			mclk_rate;
> > > > > +	u8				mclk_prediv;
> > > > > +	u16				mclk_postdiv;
> > > > > +
> > > > > +	unsigned long			pll_rate;
> > > > > +	u8				pll_post_div;
> > > > > +	u16				pll_pre_div;
> > > > > +	u16				pll_mul;
> > > > > +
> > > > > +#define TC358746_VB_MAX_SIZE		(511 * 32)
> > > > > +#define TC358746_VB_DEFAULT_SIZE	  (1 * 32)
> > > > > +	unsigned int			vb_size; /* Video buffer size in bits */
> > > > > +
> > > > > +	struct phy_configure_opts_mipi_dphy dphy_cfg;
> > > > > +};
> > > > > +
> > > > > +static inline struct tc358746 *to_tc358746(struct v4l2_subdev *sd)
> > > > > +{
> > > > > +	return container_of(sd, struct tc358746, sd);
> > > > > +}
> > > > > +
> > > > > +static inline struct tc358746 *clk_hw_to_tc358746(struct clk_hw *hw)
> > > > > +{
> > > > > +	return container_of(hw, struct tc358746, mclk_hw);
> > > > > +}
> > > > > +
> > > > > +struct tc358746_format {
> > > > > +	u32		code;
> > > > > +	bool		csi_format;
> > > > > +	unsigned char	bus_width;
> > > > > +	unsigned char	bpp;
> > > > > +	/* Register values */
> > > > > +	u8		pdformat; /* Peripheral Data Format */
> > > > > +	u8		pdataf;   /* Parallel Data Format Option */
> > > > > +};
> > > > > +
> > > > > +enum {
> > > > > +	PDFORMAT_RAW8 = 0,
> > > > > +	PDFORMAT_RAW10,
> > > > > +	PDFORMAT_RAW12,
> > > > > +	PDFORMAT_RGB888,
> > > > > +	PDFORMAT_RGB666,
> > > > > +	PDFORMAT_RGB565,
> > > > > +	PDFORMAT_YUV422_8BIT,
> > > > > +	/* RESERVED = 7 */
> > > > > +	PDFORMAT_RAW14 = 8,
> > > > > +	PDFORMAT_YUV422_10BIT,
> > > > > +	PDFORMAT_YUV444,
> > > > > +};
> > > > > +
> > > > > +/* Check tc358746_src_mbus_code() if you add new formats */
> > > > > +static const struct tc358746_format tc358746_formats[] = {
> > > > > +	{
> > > > > +		.code = MEDIA_BUS_FMT_UYVY8_2X8,
> > > > > +		.bus_width = 8,
> > > > > +		.bpp = 16,
> > > > > +		.pdformat = PDFORMAT_YUV422_8BIT,
> > > > > +		.pdataf = PDATAF_MODE0,
> > > > > +	}, {
> > > > > +		.code = MEDIA_BUS_FMT_UYVY8_1X16,
> > > > > +		.csi_format = true,
> > > > > +		.bus_width = 16,
> > > > > +		.bpp = 16,
> > > > > +		.pdformat = PDFORMAT_YUV422_8BIT,
> > > > > +		.pdataf = PDATAF_MODE1,
> > > > > +	}, {
> > > > > +		.code = MEDIA_BUS_FMT_YUYV8_1X16,
> > > > > +		.csi_format = true,
> > > > > +		.bus_width = 16,
> > > > > +		.bpp = 16,
> > > > > +		.pdformat = PDFORMAT_YUV422_8BIT,
> > > > > +		.pdataf = PDATAF_MODE2,
> > > > > +	}, {
> > > > > +		.code = MEDIA_BUS_FMT_UYVY10_2X10,
> > > > > +		.bus_width = 10,
> > > > > +		.bpp = 20,
> > > > > +		.pdformat = PDFORMAT_YUV422_10BIT,
> > > > > +		.pdataf = PDATAF_MODE0, /* don't care */
> > > > > +	}
> > > > > +};
> > > > > +
> > > > > +/* Get n-th format for pad */
> > > > > +static const struct tc358746_format *
> > > > > +tc358746_get_format_by_idx(unsigned int pad, unsigned int index)
> > > > > +{
> > > > > +	unsigned int idx = 0;
> > > > > +	unsigned int i;
> > > > > +
> > > > > +	for (i = 0; i < ARRAY_SIZE(tc358746_formats); i++) {
> > > > > +		const struct tc358746_format *fmt = &tc358746_formats[i];
> > > > > +
> > > > > +		if ((pad == TC358746_SOURCE && fmt->csi_format) ||
> > > > > +		    (pad == TC358746_SINK)) {
> > > > > +			if (idx == index)
> > > > > +				return fmt;
> > > > > +			idx++;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return ERR_PTR(-EINVAL);
> > > > > +}
> > > > > +
> > > > > +static const struct tc358746_format *
> > > > > +tc358746_get_format_by_code(unsigned int pad, u32 code)
> > > > > +{
> > > > > +	unsigned int i;
> > > > > +
> > > > > +	for (i = 0; i < ARRAY_SIZE(tc358746_formats); i++) {
> > > > > +		const struct tc358746_format *fmt = &tc358746_formats[i];
> > > > > +
> > > > > +		if (pad == TC358746_SINK && fmt->code == code)
> > > > > +			return fmt;
> > > > > +
> > > > > +		if (pad == TC358746_SOURCE && !fmt->csi_format)
> > > > > +			continue;
> > > > > +
> > > > > +		if (fmt->code == code)
> > > > > +			return fmt;
> > > > > +	}
> > > > > +
> > > > > +	return ERR_PTR(-EINVAL);
> > > > > +}
> > > > > +
> > > > > +static u32 tc358746_src_mbus_code(u32 code)
> > > > > +{
> > > > > +	switch (code) {
> > > > > +	case MEDIA_BUS_FMT_UYVY8_2X8:
> > > > > +		return MEDIA_BUS_FMT_UYVY8_1X16;
> > > > > +	case MEDIA_BUS_FMT_UYVY10_2X10:
> > > > > +		return MEDIA_BUS_FMT_UYVY10_1X20;
> > > > > +	default:
> > > > > +		return code;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +static bool tc358746_writeable_reg(struct device *dev, unsigned int reg)
> > > > > +{
> > > > > +	switch (reg) {
> > > > > +	case SYSCTL_REG ... CSI_START_REG:
> > > > > +		return true;
> > > > > +	default:
> > > > > +		return false;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +static bool tc358746_readable_reg(struct device *dev, unsigned int reg)
> > > > > +{
> > > > > +	switch (reg) {
> > > > > +	case CHIPID_REG ... CSI_START_REG:
> > > > > +		return true;
> > > > > +	default:
> > > > > +		return false;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +static const struct regmap_config tc358746_regmap_config = {
> > > > > +	.name = "tc358746",
> > > > > +	.reg_bits = 16,
> > > > > +	.val_bits = 16,
> > > > > +	.max_register = CSI_START_REG,
> > > > > +	.writeable_reg = tc358746_writeable_reg,
> > > > > +	.readable_reg = tc358746_readable_reg,
> > > > > +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> > > > > +	.val_format_endian = REGMAP_ENDIAN_BIG,
> > > > > +};
> > > > > +
> > > > > +static int tc358746_write(struct tc358746 *tc358746, u32 reg, u32 val)
> > > > > +{
> > > > > +	size_t count;
> > > > > +
> > > > > +	/* 32-bit registers starting from CLW_DPHYCONTTX */
> > > > > +	count = reg < CLW_DPHYCONTTX_REG ? 1 : 2;
> > > > > +
> > > > > +	return regmap_bulk_write(tc358746->regmap, reg, &val, count);
> > > > > +}
> > > > > +
> > > > > +static int tc358746_read(struct tc358746 *tc358746, u32 reg, u32 *val)
> > > > > +{
> > > > > +	size_t count;
> > > > > +
> > > > > +	/* 32-bit registers starting from CLW_DPHYCONTTX */
> > > > > +	count = reg < CLW_DPHYCONTTX_REG ? 1 : 2;
> > > > > +	*val = 0;
> > > > > +
> > > > > +	return regmap_bulk_read(tc358746->regmap, reg, val, count);
> > > > > +}
> > > > > +
> > > > > +static int
> > > > > +tc358746_update_bits(struct tc358746 *tc358746, u32 reg, u32 mask, u32 val)
> > > > > +{
> > > > > +	u32 tmp, orig;
> > > > > +	int err;
> > > > > +
> > > > > +	err = tc358746_read(tc358746, reg, &orig);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	tmp = orig & ~mask;
> > > > > +	tmp |= val & mask;
> > > > > +
> > > > > +	return tc358746_write(tc358746, reg, tmp);
> > > > > +}
> > > > > +
> > > > > +static int tc358746_set_bits(struct tc358746 *tc358746, u32 reg, u32 bits)
> > > > > +{
> > > > > +	return tc358746_update_bits(tc358746, reg, bits, bits);
> > > > > +}
> > > > > +
> > > > > +static int tc358746_clear_bits(struct tc358746 *tc358746, u32 reg, u32 bits)
> > > > > +{
> > > > > +	return tc358746_update_bits(tc358746, reg, bits, 0);
> > > > > +}
> > > > > +
> > > > > +static int tc358746_sw_reset(struct tc358746 *tc358746)
> > > > > +{
> > > > > +	int err;
> > > > > +
> > > > > +	err = tc358746_set_bits(tc358746, SYSCTL_REG, SRESET);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	udelay(10);
> > > > > +
> > > > > +	return tc358746_clear_bits(tc358746, SYSCTL_REG, SRESET);
> > > > > +}
> > > > > +
> > > > > +static int
> > > > > +tc358746_apply_pll_config(struct tc358746 *tc358746)
> > > > > +{
> > > > > +	u8 post = tc358746->pll_post_div;
> > > > > +	u16 pre = tc358746->pll_pre_div;
> > > > > +	u16 mul = tc358746->pll_mul;
> > > > > +	u32 val, mask;
> > > > > +	int err;
> > > > > +
> > > > > +	err = tc358746_read(tc358746, PLLCTL1_REG, &val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	/* Don't touch the PLL if running */
> > > > > +	if (FIELD_GET(PLL_EN, val) == 1)
> > > > > +		return 0;
> > > > > +
> > > > > +	/* Pre-div and Multiplicator have a internal +1 logic */
> > > > > +	val = PLL_PRD(pre - 1) | PLL_FBD(mul - 1);
> > > > > +	mask = PLL_PRD_MASK | PLL_FBD_MASK;
> > > > > +	err = tc358746_update_bits(tc358746, PLLCTL0_REG, mask, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	val = PLL_FRS(ilog2(post)) | RESETB | PLL_EN;
> > > > > +	mask = PLL_FRS_MASK | RESETB | PLL_EN;
> > > > > +	tc358746_update_bits(tc358746, PLLCTL1_REG, mask, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	udelay(1000);
> > > > > +
> > > > > +	return tc358746_set_bits(tc358746, PLLCTL1_REG, CKEN);
> > > > > +}
> > > > > +
> > > > > +static int tc358746_apply_misc_config(struct tc358746 *tc358746)
> > > > > +{
> > > > > +	struct v4l2_subdev *sd = &tc358746->sd;
> > > > > +	struct v4l2_subdev_state *sink_state;
> > > > > +	struct v4l2_mbus_framefmt *mbusfmt;
> > > > 
> > > > This can be const.
> > > 
> > > Sure
> > > 
> > > > > +	const struct tc358746_format *fmt;
> > > > > +	struct device *dev = sd->dev;
> > > > > +	u32 val;
> > > > > +	int err;
> > > > > +
> > > > > +	sink_state = v4l2_subdev_lock_and_get_active_state(sd);
> > > > > +	mbusfmt = v4l2_subdev_get_pad_format(sd, sink_state, TC358746_SINK);
> > > > > +	v4l2_subdev_unlock_state(sink_state);
> > > > 
> > > > You should keep the state locked until the end of this function,
> > > > otherwise the format could change.
> > > 
> > > That couldn't be the case since this function is called during
> > > .s_stream(on) and my understanding was that it is not allowed to change
> > > the active format after calling .s_stream(on). But I can move it to the
> > > end.
> > 
> > You're right, my bad. I can't wait for the .enable_streams() and
> > .disable_streams() operations to replace .s_stream(), the state will
> > then be passed by the framework to the drivers, simplifying all this.
> 
> Ah.. there are changes coming :) Is there some roadmap or todo or so?
> Maybe we/I could support on some internal work.

The .enable_streams() and .disable_streams() operations are part of [1].
The first 16 patches should be in v6.1. Reviews of the rest of the
series would be appreciated.

Further updates on top of that are just in my head for now :-) One idea
is to rework media_pipeline_start() to split it into multiple functions,
with a function that would lock all active states in the pipeline prior
to calling .enable_streams(). The details are still vague at this point,
but the goal is to move state locking out of drivers and pass it
explicitly to all subdev functions.

If there's anything you dislike with the subdev API that could be solved
by increasing usage of the subdev state, let me know, we could cooperate
on development.

[1] https://lore.kernel.org/linux-media/20220831141357.1396081-1-tomi.valkeinen@ideasonboard.com

> > > > > +	fmt = tc358746_get_format_by_code(TC358746_SINK, mbusfmt->code);
> > > > > +
> > > > > +	/* Self defined CSI user data type id's are not supported yet */
> > > > > +	val = PDFMT(fmt->pdformat);
> > > > > +	dev_dbg(dev, "DATAFMT: 0x%x\n", val);
> > > > > +	err = tc358746_write(tc358746, DATAFMT_REG, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	val = PDATAF(fmt->pdataf);
> > > > > +	dev_dbg(dev, "CONFCTL[PDATAF]: 0x%x\n", fmt->pdataf);
> > > > > +	err = tc358746_update_bits(tc358746, CONFCTL_REG, PDATAF_MASK, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	val = tc358746->vb_size / 32;
> > > > > +	dev_dbg(dev, "FIFOCTL: %u (0x%x)\n", val, val);
> > > > > +	err = tc358746_write(tc358746, FIFOCTL_REG, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	/* Total number of bytes for each line/width */
> > > > > +	val = mbusfmt->width * fmt->bpp / 8;
> > > > > +	dev_dbg(dev, "WORDCNT: %u (0x%x)\n", val, val);
> > > > > +	return tc358746_write(tc358746, WORDCNT_REG, val);
> > > > > +}
> > > > > +
> > > > > +#ifndef MHZ
> > > > > +#define MHZ		(1000 * 1000)
> > > > > +#endif
> > > > > +
> > > > > +/* Use MHz as base so the div needs no u64 */
> > > > > +static u32 tc358746_cfg_to_cnt(unsigned int cfg_val,
> > > > > +			       unsigned int clk_mhz,
> > > > > +			       unsigned int time_base)
> > > > > +{
> > > > > +	return DIV_ROUND_UP(cfg_val * clk_mhz, time_base);
> > > > > +}
> > > > > +
> > > > > +static u32 tc358746_ps_to_cnt(unsigned int cfg_val,
> > > > > +			      unsigned int clk_mhz)
> > > > > +{
> > > > > +	return tc358746_cfg_to_cnt(cfg_val, clk_mhz, USEC_PER_SEC);
> > > > > +}
> > > > > +
> > > > > +static u32 tc358746_us_to_cnt(unsigned int cfg_val,
> > > > > +			      unsigned int clk_mhz)
> > > > > +{
> > > > > +	return tc358746_cfg_to_cnt(cfg_val, clk_mhz, 1);
> > > > > +}
> > > > > +
> > > > > +static int tc358746_apply_dphy_config(struct tc358746 *tc358746)
> > > > > +{
> > > > > +	struct phy_configure_opts_mipi_dphy *cfg = &tc358746->dphy_cfg;
> > > > > +	bool non_cont_clk = !!(tc358746->csi_vep.bus.mipi_csi2.flags &
> > > > > +			       V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK);
> > > > > +	struct device *dev = tc358746->sd.dev;
> > > > > +	unsigned long hs_byte_clk, hf_clk;
> > > > > +	u32 val, val2, lptxcnt;
> > > > > +	int err;
> > > > > +
> > > > > +	/* The hs_byte_clk is also called SYSCLK in the excel sheet */
> > > > > +	hs_byte_clk = cfg->hs_clk_rate / 8;
> > > > > +	hs_byte_clk /= MHZ;
> > > > > +	hf_clk = hs_byte_clk / 2;
> > > > > +
> > > > > +	val = tc358746_us_to_cnt(cfg->init, hf_clk) - 1;
> > > > > +	dev_dbg(dev, "LINEINITCNT: %u (0x%x)\n", val, val);
> > > > > +	err = tc358746_write(tc358746, LINEINITCNT_REG, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	val = tc358746_ps_to_cnt(cfg->lpx, hs_byte_clk) - 1;
> > > > > +	lptxcnt = val;
> > > > > +	dev_dbg(dev, "LPTXTIMECNT: %u (0x%x)\n", val, val);
> > > > > +	err = tc358746_write(tc358746, LPTXTIMECNT_REG, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	val = tc358746_ps_to_cnt(cfg->clk_prepare, hs_byte_clk) - 1;
> > > > > +	val2 = tc358746_ps_to_cnt(cfg->clk_zero, hs_byte_clk) - 1;
> > > > > +	dev_dbg(dev, "TCLK_PREPARECNT: %u (0x%x)\n", val, val);
> > > > > +	dev_dbg(dev, "TCLK_ZEROCNT: %u (0x%x)\n", val2, val2);
> > > > > +	dev_dbg(dev, "TCLK_HEADERCNT: 0x%x\n",
> > > > > +		(u32)(TCLK_PREPARECNT(val) | TCLK_ZEROCNT(val2)));
> > > > > +	err = tc358746_write(tc358746, TCLK_HEADERCNT_REG,
> > > > > +			     TCLK_PREPARECNT(val) | TCLK_ZEROCNT(val2));
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	val = tc358746_ps_to_cnt(cfg->clk_trail, hs_byte_clk);
> > > > > +	dev_dbg(dev, "TCLK_TRAILCNT: %u (0x%x)\n", val, val);
> > > > > +	err = tc358746_write(tc358746, TCLK_TRAILCNT_REG, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	val = tc358746_ps_to_cnt(cfg->hs_prepare, hs_byte_clk) - 1;
> > > > > +	val2 = tc358746_ps_to_cnt(cfg->hs_zero, hs_byte_clk) - 1;
> > > > > +	dev_dbg(dev, "THS_PREPARECNT: %u (0x%x)\n", val, val);
> > > > > +	dev_dbg(dev, "THS_ZEROCNT: %u (0x%x)\n", val2, val2);
> > > > > +	dev_dbg(dev, "THS_HEADERCNT: 0x%x\n",
> > > > > +		(u32)(THS_PREPARECNT(val) | THS_ZEROCNT(val2)));
> > > > > +	err = tc358746_write(tc358746, THS_HEADERCNT_REG,
> > > > > +			     THS_PREPARECNT(val) | THS_ZEROCNT(val2));
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	/* TWAKEUP > 1ms in lptxcnt steps */
> > > > > +	val = tc358746_us_to_cnt(cfg->wakeup, hs_byte_clk);
> > > > > +	val = val / (lptxcnt + 1) - 1;
> > > > > +	dev_dbg(dev, "TWAKEUP: %u (0x%x)\n", val, val);
> > > > > +	err = tc358746_write(tc358746, TWAKEUP_REG, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	val = tc358746_ps_to_cnt(cfg->clk_post, hs_byte_clk);
> > > > > +	dev_dbg(dev, "TCLK_POSTCNT: %u (0x%x)\n", val, val);
> > > > > +	err = tc358746_write(tc358746, TCLK_POSTCNT_REG, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	val = tc358746_ps_to_cnt(cfg->hs_trail, hs_byte_clk);
> > > > > +	dev_dbg(dev, "THS_TRAILCNT: %u (0x%x)\n", val, val);
> > > > > +	err = tc358746_write(tc358746, THS_TRAILCNT_REG, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	dev_dbg(dev, "CONTCLKMODE: %u", non_cont_clk ? 0 : 1);
> > > > > +	return  tc358746_write(tc358746, TXOPTIONCNTRL_REG, non_cont_clk ? 0 : 1);
> > > > > +}
> > > > > +
> > > > > +#define MAX_DATA_LANES 4
> > > > > +
> > > > > +static int tc358746_enable_csi_lanes(struct tc358746 *tc358746, int enable)
> > > > > +{
> > > > > +	unsigned int lanes = tc358746->dphy_cfg.lanes;
> > > > > +	unsigned int lane;
> > > > > +	u32 reg, val;
> > > > > +	int err;
> > > > > +
> > > > > +	err = tc358746_update_bits(tc358746, CONFCTL_REG, DATALANE_MASK,
> > > > > +				   lanes - 1);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	/* Clock lane */
> > > > > +	val = enable ? 0 : LANEDISABLE;
> > > > > +	dev_dbg(tc358746->sd.dev, "CLW_CNTRL: 0x%x\n", val);
> > > > > +	err = tc358746_write(tc358746, CLW_CNTRL_REG, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	for (lane = 0; lane < MAX_DATA_LANES; lane++) {
> > > > > +		/* Data lanes */
> > > > > +		reg = D0W_CNTRL_REG + lane * 0x4;
> > > > > +		val = (enable && lane < lanes) ? 0 : LANEDISABLE;
> > > > > +
> > > > > +		dev_dbg(tc358746->sd.dev, "D%uW_CNTRL: 0x%x\n", lane, val);
> > > > > +		err = tc358746_write(tc358746, reg, val);
> > > > > +		if (err)
> > > > > +			return err;
> > > > > +	}
> > > > > +
> > > > > +	val = 0;
> > > > > +	if (enable) {
> > > > > +		/* Clock lane */
> > > > > +		val |= BIT(0);
> > > > > +
> > > > > +		/* Data lanes */
> > > > > +		for (lane = 1; lane <= lanes; lane++)
> > > > > +			val |= BIT(lane);
> > > > > +	}
> > > > > +
> > > > > +	dev_dbg(tc358746->sd.dev, "HSTXVREGEN: 0x%x\n", val);
> > > > > +	return tc358746_write(tc358746, HSTXVREGEN_REG, val);
> > > > > +}
> > > > > +
> > > > > +static int tc358746_enable_csi_module(struct tc358746 *tc358746, int enable)
> > > > > +{
> > > > > +	unsigned int lanes = tc358746->dphy_cfg.lanes;
> > > > > +	int err;
> > > > > +
> > > > > +	/*
> > > > > +	 * START and STRT are only reseted/disabled by sw reset. This is
> > > > > +	 * required to put the lane state back into LP-11 state. The sw reset
> > > > > +	 * don't reset register values.
> > > > > +	 */
> > > > > +	if (!enable)
> > > > > +		return tc358746_sw_reset(tc358746);
> > > > > +
> > > > > +	err = tc358746_write(tc358746, STARTCNTRL_REG, START);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	err = tc358746_write(tc358746, CSI_START_REG, STRT);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	/* CSI_CONTROL_REG is only indirect accessible */
> > > > > +	return tc358746_write(tc358746, CSI_CONFW_REG,
> > > > > +			      MODE(MODE_SET) |
> > > > > +			      ADDRESS(CSI_CONTROL_ADDRESS) |
> > > > > +			      DATA(CSI_MODE | TXHSMD | NOL(lanes - 1)));
> > > > > +}
> > > > > +
> > > > > +static int tc358746_enable_parallel_port(struct tc358746 *tc358746, int enable)
> > > > > +{
> > > > > +	int err;
> > > > > +
> > > > > +	if (enable) {
> > > > > +		err = tc358746_write(tc358746, PP_MISC_REG, 0);
> > > > > +		if (err)
> > > > > +			return err;
> > > > > +
> > > > > +		return tc358746_set_bits(tc358746, CONFCTL_REG, PPEN);
> > > > > +	}
> > > > > +
> > > > > +	err = tc358746_set_bits(tc358746, PP_MISC_REG, FRMSTOP);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	err = tc358746_clear_bits(tc358746, CONFCTL_REG, PPEN);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	return tc358746_set_bits(tc358746, PP_MISC_REG, RSTPTR);
> > > > > +}
> > > > > +
> > > > > +static inline struct v4l2_subdev *tc358746_get_remote_sd(struct media_pad *pad)
> > > > > +{
> > > > > +	pad = media_pad_remote_pad_first(pad);
> > > > > +	if (!pad)
> > > > > +		return NULL;
> > > > > +
> > > > > +	return media_entity_to_v4l2_subdev(pad->entity);
> > > > > +}
> > > > > +
> > > > > +static int tc358746_s_stream(struct v4l2_subdev *sd, int enable)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > > > +	struct v4l2_subdev *src;
> > > > > +	int err;
> > > > > +
> > > > > +	dev_dbg(sd->dev, "%sable\n", enable ? "en" : "dis");
> > > > > +
> > > > > +	src = tc358746_get_remote_sd(&tc358746->pads[TC358746_SINK]);
> > > > > +	if (!src)
> > > > > +		return -EPIPE;
> > > > > +
> > > > > +	if (enable) {
> > > > > +		err = pm_runtime_resume_and_get(sd->dev);
> > > > > +		if (err)
> > > > > +			return err;
> > > > > +
> > > > > +		err = tc358746_apply_dphy_config(tc358746);
> > > > > +		if (err)
> > > > > +			goto err_out;
> > > > > +
> > > > > +		err = tc358746_apply_misc_config(tc358746);
> > > > > +		if (err)
> > > > > +			goto err_out;
> > > > > +
> > > > > +		err = tc358746_enable_csi_lanes(tc358746, 1);
> > > > > +		if (err)
> > > > > +			goto err_out;
> > > > > +
> > > > > +		err = tc358746_enable_csi_module(tc358746, 1);
> > > > > +		if (err)
> > > > > +			goto err_out;
> > > > > +
> > > > > +		err = tc358746_enable_parallel_port(tc358746, 1);
> > > > > +		if (err)
> > > > > +			goto err_out;
> > > > > +
> > > > > +		err = v4l2_subdev_call(src, video, s_stream, 1);
> > > > > +		if (err)
> > > > > +			goto err_out;
> > > > > +
> > > > > +		return err;
> > > > > +
> > > > > +err_out:
> > > > > +		pm_runtime_mark_last_busy(sd->dev);
> > > > > +		pm_runtime_put_sync_autosuspend(sd->dev);
> > > > > +
> > > > > +		return err;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Lane disable trigger state change from LP-11 to LP-00
> > > > > +	 * therefore it must happen before the CSI modile is disabled.
> > > > > +	 */
> > > > > +	err = tc358746_enable_csi_lanes(tc358746, 0);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	err = tc358746_enable_csi_module(tc358746, 0);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	err = tc358746_enable_parallel_port(tc358746, 0);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	pm_runtime_mark_last_busy(sd->dev);
> > > > > +	pm_runtime_put_sync_autosuspend(sd->dev);
> > > > > +
> > > > > +	return v4l2_subdev_call(src, video, s_stream, 0);
> > > > > +}
> > > > > +
> > > > > +static int tc358746_init_cfg(struct v4l2_subdev *sd,
> > > > > +			     struct v4l2_subdev_state *state)
> > > > > +{
> > > > > +	struct v4l2_mbus_framefmt *fmt;
> > > > > +
> > > > > +	fmt = v4l2_subdev_get_pad_format(sd, state, TC358746_SINK);
> > > > > +	*fmt = tc358746_def_fmt;
> > > > > +
> > > > > +	fmt = v4l2_subdev_get_pad_format(sd, state, TC358746_SOURCE);
> > > > > +	*fmt = tc358746_def_fmt;
> > > > > +	fmt->code = tc358746_src_mbus_code(tc358746_def_fmt.code);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int tc358746_enum_mbus_code(struct v4l2_subdev *sd,
> > > > > +				   struct v4l2_subdev_state *sd_state,
> > > > > +				   struct v4l2_subdev_mbus_code_enum *code)
> > > > > +{
> > > > > +	const struct tc358746_format *fmt;
> > > > > +
> > > > > +	fmt = tc358746_get_format_by_idx(code->pad, code->index);
> > > > > +	if (IS_ERR(fmt))
> > > > > +		return PTR_ERR(fmt);
> > > > > +
> > > > > +	code->code = fmt->code;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int tc358746_set_fmt(struct v4l2_subdev *sd,
> > > > > +			    struct v4l2_subdev_state *sd_state,
> > > > > +			    struct v4l2_subdev_format *format)
> > > > > +{
> > > > > +	struct v4l2_mbus_framefmt *src_fmt, *sink_fmt;
> > > > > +	const struct tc358746_format *fmt;
> > > > > +
> > > > > +	/* Source follows the sink */
> > > > > +	if (format->pad == TC358746_SOURCE)
> > > > > +		return 0;
> > > > 
> > > > You need to get the source pad format here and copy it to format,
> > > > otherwise userspace will think whatever format it has passed has been
> > > > accepted.
> > > 
> > > That's right, I will change that. Thanks.
> > > 
> > > > > +	sink_fmt = v4l2_subdev_get_pad_format(sd, sd_state, TC358746_SINK);
> > > > > +
> > > > > +	fmt = tc358746_get_format_by_code(format->pad, format->format.code);
> > > > > +	if (IS_ERR(fmt))
> > > > > +		fmt = tc358746_get_format_by_code(format->pad, tc358746_def_fmt.code);
> > > > > +
> > > > > +	format->format.code = fmt->code;
> > > > > +	format->format.field = V4L2_FIELD_NONE;
> > > > > +
> > > > 
> > > > Is there no constraint at all on the width and height ?
> > > 
> > > No there are no contraints, at least not listed in the datasheet I have.
> > > 
> > > > I would expect zero width or height to be invalid for instance, and
> > > > the width to be required to be a multiple of 2 for YUV 4:2:2 formats.
> > > 
> > > You just specify the wordcnt in bytes per line. The datasheet I have on
> > > my side don't say that it is forbidden to write zero to it. Regarding
> > > the alignment, the datasheet says nothing about it too. But sure it can
> > > be that this will fail. But shouldn't this fail on the sensor first?
> > 
> > That's a good point. I'm fine without checks here.
> > 
> > > Since this is just a bridge, no-cropping/selection/zoom supported, it
> > > just takes the input from the parallel interface. If someone
> > > misconfigured it on purpose the link-validation will fail in case of
> > > format missmatch. If the format has a wrong alignment, the sensor should
> > > fail first. But of course I could add a helper to check the alignment
> > > and to set some sane defaults.
> > > 
> > > > > +	dev_dbg(sd->dev, "Update format: %ux%u code:0x%x -> %ux%u code:0x%x",
> > > > > +		sink_fmt->width, sink_fmt->height, sink_fmt->code,
> > > > > +		format->format.width, format->format.height, format->format.code);
> > > > > +
> > > > > +	*sink_fmt = format->format;
> > > > > +
> > > > > +	src_fmt = v4l2_subdev_get_pad_format(sd, sd_state, TC358746_SOURCE);
> > > > > +	*src_fmt = *sink_fmt;
> > > > > +	src_fmt->code = tc358746_src_mbus_code(sink_fmt->code);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static unsigned long tc358746_find_pll_settings(struct tc358746 *tc358746,
> > > > > +						unsigned long refclk,
> > > > > +						unsigned long fout)
> > > > > +
> > > > > +{
> > > > > +	struct device *dev = tc358746->sd.dev;
> > > > > +	unsigned long best_freq = 0;
> > > > > +	u32 min_delta = 0xffffffff;
> > > > > +	u16 prediv_max = 17;
> > > > > +	u16 prediv_min = 1;
> > > > > +	u16 m_best, mul;
> > > > > +	u16 p_best, p;
> > > > > +	u8 postdiv;
> > > > > +
> > > > > +	if (fout > 1000 * MHZ) {
> > > > > +		dev_err(dev, "HS-Clock above 1 Ghz are not supported\n");
> > > > > +		return 0;
> > > > > +	} else if (fout >= 500 * MHZ)
> > > > 
> > > > If one branch of an if uses curly braces, all should. You can work
> > > > around this by turning this else if into an if.
> > > 
> > > Okay.
> > > 
> > > > > +		postdiv = 1;
> > > > > +	else if (fout >= 250 * MHZ)
> > > > > +		postdiv = 2;
> > > > > +	else if (fout >= 125 * MHZ)
> > > > > +		postdiv = 4;
> > > > > +	else
> > > > > +		postdiv = 8;
> > > > > +
> > > > > +	for (p = prediv_min; p <= prediv_max; p++) {
> > > > > +		unsigned long delta, fin;
> > > > > +		u64 tmp;
> > > > > +
> > > > > +		fin = DIV_ROUND_CLOSEST(refclk, p);
> > > > > +		if (fin < 4 * MHZ || fin > 40 * MHZ)
> > > > > +			continue;
> > > > > +
> > > > > +		tmp = fout * p * postdiv;
> > > > > +		do_div(tmp, fin);
> > > > > +		mul = tmp;
> > > > > +		if (mul > 511)
> > > > > +			continue;
> > > > > +
> > > > > +		tmp = mul * fin;
> > > > > +		do_div(tmp, p * postdiv);
> > > > > +
> > > > > +		delta = abs(fout - tmp);
> > > > > +		if (delta < min_delta) {
> > > > > +			p_best = p;
> > > > > +			m_best = mul;
> > > > > +			min_delta = delta;
> > > > > +			best_freq = tmp;
> > > > > +		};
> > > > > +
> > > > > +		if (delta == 0)
> > > > > +			break;
> > > > > +	};
> > > > > +
> > > > > +	if (!best_freq) {
> > > > > +		dev_err(dev, "Failed find PLL frequency\n");
> > > > > +		return 0;
> > > > > +	}
> > > > > +
> > > > > +	tc358746->pll_post_div = postdiv;
> > > > > +	tc358746->pll_pre_div = p_best;
> > > > > +	tc358746->pll_mul = m_best;
> > > > > +
> > > > > +	if (best_freq != fout)
> > > > > +		dev_warn(dev, "Request PLL freq:%lu, found PLL freq:%lu\n",
> > > > > +			 fout, best_freq);
> > > > > +
> > > > > +	dev_dbg(dev, "Found PLL settings: freq:%lu prediv:%u multi:%u postdiv:%u\n",
> > > > > +		best_freq, p_best, m_best, postdiv);
> > > > > +
> > > > > +	return best_freq;
> > > > > +}
> > > > > +
> > > > > +#define TC358746_PRECISION 10
> > > > > +
> > > > > +static int
> > > > > +tc358746_link_validate(struct v4l2_subdev *sd, struct media_link *link,
> > > > > +		       struct v4l2_subdev_format *source_fmt,
> > > > > +		       struct v4l2_subdev_format *sink_fmt)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > > > +	unsigned long csi_bitrate, sensor_bitrate;
> > > > > +	struct v4l2_subdev_state *sink_state;
> > > > > +	struct v4l2_mbus_framefmt *mbusfmt;
> > > > > +	const struct tc358746_format *fmt;
> > > > > +	unsigned int fifo_sz, tmp, n;
> > > > > +	struct v4l2_subdev *sensor;
> > > > > +	s64 sensor_pclk_rate;
> > > > > +	int err;
> > > > > +
> > > > > +	err = v4l2_subdev_link_validate_default(sd, link, source_fmt, sink_fmt);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	sink_state = v4l2_subdev_lock_and_get_active_state(sd);
> > > > 
> > > > This makes me thinkg we should pass the state to this function. Not
> > > > something that needs to be addressed in this patch of course.
> > > 
> > > Passing the state? My understanding of *_get_active_state() is to get
> > > the active state or do you want to add a new function like
> > > *_get_state(active)?
> > 
> > I meant passing the state to the .link_validate() handler.
> 
> Ah.. :) Nice to see some progress within the media layer.
> 
> > > > > +	mbusfmt = v4l2_subdev_get_pad_format(sd, sink_state, TC358746_SINK);
> > > > > +	v4l2_subdev_unlock_state(sink_state);
> > > > 
> > > > I'd release the lock at the end of the function, to make sure the format
> > > > won't change during validation. This is also a race condition in the
> > > > subdev core and should be fixed there, I'd be fine if you ignored it
> > > > here for now.
> > > 
> > > I can change this but for my understanding. Why is it even possible to
> > > change the state that late? We are going to enable the stream real
> > > soon after the validation is done.
> > 
> > Due to bugs in the framework :-) I plan to address that by locking all
> > states when constructing the pipelines, which will remove the need to
> > lock them in individual drivers.
> 
> *Thumbs up*
> 
> > > > > +
> > > > > +	/* Check the FIFO settings */
> > > > > +	fmt = tc358746_get_format_by_code(TC358746_SINK, mbusfmt->code);
> > > > > +	if (IS_ERR(fmt))
> > > > > +		return PTR_ERR(fmt);
> > > > 
> > > > Can this happen if the format has been validate at set_fmt time ?
> > > 
> > > Of course not, I will drop the IS_ERR().
> > > 
> > > > > +
> > > > > +	sensor = media_entity_to_v4l2_subdev(link->source->entity);
> > > > > +	sensor_pclk_rate = v4l2_get_link_freq(sensor->ctrl_handler, 0, 0);
> > > > 
> > > > Shouldn't you set the last two arguments to non-zero values, to support
> > > > sources that only implement the V4L2_CID_PIXEL_RATE control ?
> > > 
> > > Nope, I don't wanna support PIXEL_RATE right now. This can be changed
> > > later I think.
> > 
> > Would it be hard to support it already, given that the
> > v4l2_get_link_freq() should make it easier ? That would avoid having to
> > come back to this code later.
> 
> I had the pixel-rate first, then Jacobo mentioned (correctly) that my
> usage of pixel-rate was wrong. Supporting PIXEL_RATE as well would add
> more complexity because we need to take core of the mbus format to get
> the correct mul/div settings.

That's right, but the required information could be stored in the
tc358746_format structure, can't it ?

> Also I think that only a few drivers
> implementing the PIXEL_RATE correctly in case of parallel sensors _and_
> this is just a fallback which will print a warning if triggered. All I
> want to do here is: "give me the link frequence" :) If there are drivers
> not supporting this but support PIXEL_RATE it shouldn't be that hard for
> those driver to add the LINK_FREQ ctrl. This would also improve the
> kernel quality since there are now heuristics and no warnings printed.
> 
> Is it okay, to keep it simple and just go with LINK_FREQ. for now?

OK, I won't insist much.

> > > > I'd also name the variable source_link_freq, as it may not be a sensor,
> > > > and it's a link frequency, not a pixel clock rate.
> > > 
> > > In parallel case (which is the only supported right now) the pclk is the
> > > link_freq. but I can change it of course.
> > 
> > I read "pclk" as "pixel clock". That makes me think of
> > V4L2_CID_PIXEL_RATE, which indicates the number of pixels per second.
> > With YUV 4:2:2 2X8 media bus formats, the link frequency will be twice
> > the pixel rate.
> 
> Hm.. the link frequency is the frequency on the physical parallel bus,
> as far as I understood the ctrl. In parallel use-case this is pixelclk.
> 
> Also according PIXEL_RATE documentation, it is defined as
> pixel-per-second. For YUV 4:2:2 those this mean mean:
>  - y1 == 1st pixel,
>  - u1 == 2nd pixel,
>  - y2 == 3rd pixel,
>  - ...

YUYV8_2X8 transfers Y0, U0, Y1, V0, Y2, U2, Y3, V2, ... You need two
cycles per pixel. That's why sensor_pclk_rate can be misleading, as it
may refer to the sensor pixel sampling clock, or the parallel bus clock,
and those two are different. It's just a variable naming issue to avoid
confusion.

> All I want is to get the rate/frequency of the physical bus from the
> input device :) According my above explanation, could we please go with
> "the LINK_FREQ ctrl only" since this would avoid possible kernel
> warnings and is the most accurate one.
> 
> > > > > +	if (sensor_pclk_rate <= 0) {
> > > > > +		dev_err(tc358746->sd.dev,
> > > > > +			"Failed to query or invalid sensor link frequency\n");
> > > > > +		/* Return -EINVAL in case of sensor_pclk_rate is 0 */
> > > > > +		return sensor_pclk_rate ? : -EINVAL;
> > > > > +	}
> > > > > +	sensor_bitrate = sensor_pclk_rate * fmt->bus_width;
> > > > > +
> > > > > +	csi_bitrate = tc358746->dphy_cfg.lanes * tc358746->pll_rate;
> > > > > +
> > > > > +	dev_dbg(tc358746->sd.dev,
> > > > > +		"Fifo settings params: sensor-bitrate:%lu csi-bitrate:%lu",
> > > > > +		sensor_bitrate, csi_bitrate);
> > > > > +
> > > > > +	/* Avoid possible FIFO overflows */
> > > > > +	if (csi_bitrate < sensor_bitrate) {
> > > > > +		dev_err(sd->dev,
> > > > > +			"Link validation failed csi-bitrate:%lu < sensor-bitrate:%lu\n",
> > > > > +			csi_bitrate, sensor_bitrate);
> > > > 
> > > > As this can be triggered by userspace, I'd make it a dev_dbg().
> > > 
> > > So you would rather fail silently without printing the reason? Is there
> > > a common kernel agreement when to use dev_err() or info() or dbg()?
> > 
> > It's not completely silent :-) The idea is that an error condition that
> > can be triggered by unpriviledged userspace shouldn't be able to flood
> > the kernel log. dev_dbg() will still allow debugging.
> 
> Okay, I droppped it completely since the dev_dbg() in front of this
> call.
> 
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	/* Best case */
> > > > > +	if (csi_bitrate == sensor_bitrate) {
> > > > > +		tc358746->vb_size = TC358746_VB_DEFAULT_SIZE;
> > > > > +		goto out;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Avoid possible FIFO underflow in case of
> > > > > +	 * csi_bitrate > sensor_bitrate. For such case the chip has a internal
> > > > > +	 * fifo which can be used to delay the line output.
> > > > > +	 *
> > > > > +	 * Fifo size calculation:
> > > > > +	 *
> > > > > +	 * fifo-sz, image-width - in bits
> > > > > +	 * sbr                  - sensor_bitrate in bits/s
> > > > > +	 * csir                 - csi_bitrate in bits/s
> > > > > +	 *
> > > > > +	 *                1             1      1
> > > > > +	 * image-width * --- + fifo-sz --- >= ---- * image-width
> > > > > +	 *               sbr           sbr    csir
> > > > 
> > > > Given that csir > sbr, 1/csir < 1 sbr, so this will always be true,
> > > > even with fifo-sz set to 0. Am I missing something ?
> > > 
> > > Nope, that is right. Didn't checked that while I was coding it.
> > > 
> > > > > +	 *
> > > > > +	 * fifo-sz >= abs(sbr/csir * image-width - image-width)
> > > > > +	 *                `-----´
> > > > > +	 *                   n
> > > > 
> > > > The n variable doesn't store sbr/csir but csir/sbr (multiplied by a
> > > > precision factor). And do I understand correctly that, as sbr < csir,
> > > > this would be equal to the following ?
> > > > 
> > > > 	 * fifo-sz >= image-width - sbr/csir * image-width
> > > 
> > > Exactly, my above comment and the below code is a bit of, you're right
> > > but the calc is still correct:
> > > 
> > >         (mbusfmt->width * precision)   (mbusfmt->width * precision)
> > >   tmp = ---------------------------- = ----------------------------
> > >                         n                    csi_bitrate
> > > 			                     --------------
> > > 					     sensor_bitrate
> > > 
> > > 					`---------------------------´
> > >    					   sbr/csir * image-width
> > > 
> > > maybe I should comment it like:
> > > 
> > > > * fifo-sz >= abs(sbr/csir * image-width - image-width)
> > > > *
> > > > * with n = 1/(sbr/csir) = csir/sbr
> > > > *
> > > > * fifo-sz >= abs(image-width / n - image-width)
> > > > *
> > > > *  or
> > > > *
> > > > *  fifo-sz >= image-width - image-width / n
> > > 
> > > > > +	 *
> > > > > +	 */
> > > > > +
> > > > > +	sensor_bitrate /= TC358746_PRECISION;
> > > > > +	n = csi_bitrate / sensor_bitrate;
> > > > > +	tmp = (mbusfmt->width * TC358746_PRECISION) / n;
> > > > > +	fifo_sz = mbusfmt->width - tmp;
> > > > > +	fifo_sz *= fmt->bpp;
> > > > > +	tc358746->vb_size = round_up(fifo_sz, 32);
> > > > > +
> > > > > +out:
> > > > > +	dev_dbg(tc358746->sd.dev,
> > > > > +		"Found FIFO size[bits]:%u -> aligned to size[bits]:%u\n",
> > > > > +		fifo_sz, tc358746->vb_size);
> > > > > +
> > > > > +	return tc358746->vb_size > TC358746_VB_MAX_SIZE ? -EINVAL : 0;
> > > > > +}
> > > > > +
> > > > > +static int tc358746_get_mbus_config(struct v4l2_subdev *sd, unsigned int pad,
> > > > > +				    struct v4l2_mbus_config *config)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > > > +
> > > > > +	if (pad != TC358746_SOURCE)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	config->type = V4L2_MBUS_CSI2_DPHY;
> > > > > +	config->bus.mipi_csi2 = tc358746->csi_vep.bus.mipi_csi2;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +int __maybe_unused
> > > > 
> > > > As reported by the buildbot, this should be static. Same for s_register.
> > > 
> > > Yes.
> > > 
> > > > > +tc358746_g_register(struct v4l2_subdev *sd, struct v4l2_dbg_register *reg)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > > > +
> > > > > +	/* 32-bit registers starting from CLW_DPHYCONTTX */
> > > > > +	reg->size = reg->reg < CLW_DPHYCONTTX_REG ? 2 : 4;
> > > > > +
> > > > > +	if (pm_runtime_resume_and_get(sd->dev)) {
> > > > > +		dev_err(sd->dev, "Failed to resume the device\n");
> > > > > +		return 0;
> > > > > +	}
> > > > 
> > > > Is there a point in powering the hardware on here if it's off, in order
> > > > to read a register that will have been reset due to the power cycle ?
> > > > pm_runtime_get_if_in_use() seems better. Same in .s_register().
> > > 
> > > You're right, I will change that.
> > > 
> > > > > +	tc358746_read(tc358746, reg->reg, (u32 *)&reg->val);
> > > > > +
> > > > > +	pm_runtime_mark_last_busy(sd->dev);
> > > > > +	pm_runtime_put_sync_autosuspend(sd->dev);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +int __maybe_unused
> > > > > +tc358746_s_register(struct v4l2_subdev *sd, const struct v4l2_dbg_register *reg)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > > > +
> > > > > +	if (pm_runtime_resume_and_get(sd->dev)) {
> > > > > +		dev_err(sd->dev, "Failed to resume the device\n");
> > > > > +		return 0;
> > > > > +	}
> > > > > +
> > > > > +	tc358746_write(tc358746, (u32)reg->reg, (u32)reg->val);
> > > > > +
> > > > > +	pm_runtime_mark_last_busy(sd->dev);
> > > > > +	pm_runtime_put_sync_autosuspend(sd->dev);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static const struct v4l2_subdev_core_ops tc358746_core_ops = {
> > > > > +#ifdef CONFIG_VIDEO_ADV_DEBUG
> > > > > +	.g_register = tc358746_g_register,
> > > > > +	.s_register = tc358746_s_register,
> > > > > +#endif
> > > > > +};
> > > > > +
> > > > > +static const struct v4l2_subdev_video_ops tc358746_video_ops = {
> > > > > +	.s_stream = tc358746_s_stream,
> > > > > +};
> > > > > +
> > > > > +static const struct v4l2_subdev_pad_ops tc358746_pad_ops = {
> > > > > +	.init_cfg = tc358746_init_cfg,
> > > > > +	.enum_mbus_code = tc358746_enum_mbus_code,
> > > > > +	.set_fmt = tc358746_set_fmt,
> > > > > +	.get_fmt = v4l2_subdev_get_fmt,
> > > > > +	.link_validate = tc358746_link_validate,
> > > > > +	.get_mbus_config = tc358746_get_mbus_config,
> > > > > +};
> > > > > +
> > > > > +static const struct v4l2_subdev_ops tc358746_ops = {
> > > > > +	.core = &tc358746_core_ops,
> > > > > +	.video = &tc358746_video_ops,
> > > > > +	.pad = &tc358746_pad_ops,
> > > > > +};
> > > > > +
> > > > > +static const struct media_entity_operations tc358746_entity_ops = {
> > > > > +	.get_fwnode_pad = v4l2_subdev_get_fwnode_pad_1_to_1,
> > > > > +	.link_validate = v4l2_subdev_link_validate,
> > > > > +};
> > > > > +
> > > > > +static int tc358746_mclk_enable(struct clk_hw *hw)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
> > > > > +	unsigned int div;
> > > > > +	u32 val;
> > > > > +	int err;
> > > > > +
> > > > > +	div = tc358746->mclk_postdiv / 2;
> > > > > +	val = MCLK_HIGH(div - 1) | MCLK_LOW(div - 1);
> > > > > +	dev_dbg(tc358746->sd.dev, "MCLKCTL: %u (0x%x)\n", val, val);
> > > > > +	err = tc358746_write(tc358746, MCLKCTL_REG, val);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	if (tc358746->mclk_prediv == 8)
> > > > > +		val = MCLKDIV(MCLKDIV_8);
> > > > > +	else if (tc358746->mclk_prediv == 4)
> > > > > +		val = MCLKDIV(MCLKDIV_4);
> > > > > +	else
> > > > > +		val = MCLKDIV(MCLKDIV_2);
> > > > > +
> > > > > +	dev_dbg(tc358746->sd.dev, "CLKCTL[MCLKDIV]: %u (0x%x)\n", val, val);
> > > > > +	return tc358746_update_bits(tc358746, CLKCTL_REG, MCLKDIV_MASK, val);
> > > > > +}
> > > > > +
> > > > > +static void tc358746_mclk_disable(struct clk_hw *hw)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
> > > > > +
> > > > > +	tc358746_write(tc358746, MCLKCTL_REG, 0);
> > > > > +}
> > > > > +
> > > > > +static long
> > > > > +tc358746_find_mclk_settings(struct tc358746 *tc358746, unsigned long mclk_rate)
> > > > > +{
> > > > > +	unsigned long pll_rate = tc358746->pll_rate;
> > > > > +	const unsigned char prediv[] = { 2, 4, 8 };
> > > > > +	unsigned int mclk_prediv, mclk_postdiv;
> > > > > +	struct device *dev = tc358746->sd.dev;
> > > > > +	unsigned int postdiv, mclkdiv;
> > > > > +	unsigned long best_mclk_rate;
> > > > > +	unsigned int i;
> > > > > +
> > > > > +	/*
> > > > > +	 *                          MCLK-Div
> > > > > +	 *           -------------------´`---------------------
> > > > > +	 *          ´                                          `
> > > > > +	 *         +-------------+     +------------------------+
> > > > > +	 *         | MCLK-PreDiv |     |       MCLK-PostDiv     |
> > > > > +	 * PLL --> |   (2/4/8)   | --> | (mclk_low + mclk_high) | --> MCLK
> > > > > +	 *         +-------------+     +------------------------+
> > > > > +	 *
> > > > > +	 * The register value of mclk_low/high is mclk_low/high+1, i.e.:
> > > > > +	 *   mclk_low/high = 1   --> 2 MCLK-Ref Counts
> > > > > +	 *   mclk_low/high = 255 --> 256 MCLK-Ref Counts == max.
> > > > > +	 * If mclk_low and mclk_high are 0 then MCLK is disabled.
> > > > > +	 *
> > > > > +	 * Keep it simple and support 50/50 duty cycles only for now,
> > > > > +	 * so the calc will be:
> > > > > +	 *
> > > > > +	 *   MCLK = PLL / (MCLK-PreDiv * 2 * MCLK-PostDiv)
> > > > > +	 */
> > > > > +
> > > > > +	if (mclk_rate == tc358746->mclk_rate)
> > > > > +		return mclk_rate;
> > > > > +
> > > > > +	/* Highest possible rate */
> > > > > +	mclkdiv = pll_rate / mclk_rate;
> > > > > +	if (mclkdiv <= 8) {
> > > > > +		mclk_prediv = 2;
> > > > > +		mclk_postdiv = 4;
> > > > > +		best_mclk_rate = pll_rate / (2 * 4);
> > > > > +		goto out;
> > > > > +	}
> > > > > +
> > > > > +	/* First check the prediv */
> > > > > +	for (i = 0; i < ARRAY_SIZE(prediv); i++) {
> > > > > +		postdiv = mclkdiv / prediv[i];
> > > > > +
> > > > > +		if (postdiv % 2)
> > > > > +			continue;
> > > > > +
> > > > > +		if (postdiv >= 4 && postdiv <= 512) {
> > > > > +			mclk_prediv = prediv[i];
> > > > > +			mclk_postdiv = postdiv;
> > > > > +			best_mclk_rate = pll_rate / (prediv[i] * postdiv);
> > > > > +			goto out;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	/* No suitable prediv found, so try to adjust the postdiv */
> > > > > +	for (postdiv = 4; postdiv <= 512; postdiv += 2) {
> > > > > +		unsigned int pre;
> > > > > +
> > > > > +		pre = mclkdiv / postdiv;
> > > > > +		if (pre == 2 || pre == 4 || pre == 8) {
> > > > > +			mclk_prediv = pre;
> > > > > +			mclk_postdiv = postdiv;
> > > > > +			best_mclk_rate = pll_rate / (pre * postdiv);
> > > > > +			goto out;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	/* The MCLK <-> PLL gap is to high -> use largest possible div */
> > > > > +	mclk_prediv = 8;
> > > > > +	mclk_postdiv = 512;
> > > > > +	best_mclk_rate = pll_rate / (8 * 512);
> > > > > +
> > > > > +out:
> > > > > +	tc358746->mclk_prediv = mclk_prediv;
> > > > > +	tc358746->mclk_postdiv = mclk_postdiv;
> > > > > +	tc358746->mclk_rate = best_mclk_rate;
> > > > > +
> > > > > +	if (best_mclk_rate != mclk_rate)
> > > > > +		dev_warn(dev, "Request MCLK freq:%lu, found MCLK freq:%lu\n",
> > > > > +			 mclk_rate, best_mclk_rate);
> > > > > +
> > > > > +	dev_dbg(dev, "Found MCLK settings: freq:%lu prediv:%u postdiv:%u\n",
> > > > > +		best_mclk_rate, mclk_prediv, mclk_postdiv);
> > > > > +
> > > > > +	return best_mclk_rate;
> > > > > +}
> > > > > +
> > > > > +unsigned long tc358746_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
> > > > > +	unsigned int prediv, postdiv;
> > > > > +	u32 val;
> > > > > +	int err;
> > > > > +
> > > > > +	err = tc358746_read(tc358746, MCLKCTL_REG, &val);
> > > > > +	if (err)
> > > > > +		return 0;
> > > > > +
> > > > > +	postdiv = FIELD_GET(MCLK_LOW_MASK, val) + 1;
> > > > > +	postdiv += FIELD_GET(MCLK_HIGH_MASK, val) + 1;
> > > > > +
> > > > > +	err = tc358746_read(tc358746, CLKCTL_REG, &val);
> > > > > +	if (err)
> > > > > +		return 0;
> > > > > +
> > > > > +	prediv = FIELD_GET(MCLKDIV_MASK, val);
> > > > > +	if (prediv == MCLKDIV_8)
> > > > > +		prediv = 8;
> > > > > +	else if (prediv == MCLKDIV_4)
> > > > > +		prediv = 4;
> > > > > +	else
> > > > > +		prediv = 2;
> > > > > +
> > > > > +	return tc358746->pll_rate / (prediv * postdiv);
> > > > > +}
> > > > > +
> > > > > +static long tc358746_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
> > > > > +				     unsigned long *parent_rate)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
> > > > > +
> > > > > +	*parent_rate = tc358746->pll_rate;
> > > > > +
> > > > > +	return tc358746_find_mclk_settings(tc358746, rate);
> > > > > +}
> > > > > +
> > > > > +static int tc358746_mclk_set_rate(struct clk_hw *hw, unsigned long rate,
> > > > > +				  unsigned long parent_rate)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
> > > > > +
> > > > > +	tc358746_find_mclk_settings(tc358746, rate);
> > > > > +
> > > > > +	return tc358746_mclk_enable(hw);
> > > > > +}
> > > > > +
> > > > > +static const struct clk_ops tc358746_mclk_ops = {
> > > > > +	.enable = tc358746_mclk_enable,
> > > > > +	.disable = tc358746_mclk_disable,
> > > > > +	.recalc_rate = tc358746_recalc_rate,
> > > > > +	.round_rate = tc358746_mclk_round_rate,
> > > > > +	.set_rate = tc358746_mclk_set_rate,
> > > > > +};
> > > > > +
> > > > > +static int
> > > > > +tc358746_init_subdev(struct tc358746 *tc358746, struct i2c_client *client)
> > > > > +{
> > > > > +	struct v4l2_subdev *sd;
> > > > > +	int err;
> > > > > +
> > > > > +	sd = &tc358746->sd;
> > > > 
> > > > You could initialize the variable when declaring it.
> > > 
> > > Yes.
> > > 
> > > > > +	v4l2_i2c_subdev_init(sd, client, &tc358746_ops);
> > > > > +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> > > > > +	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
> > > > > +	sd->entity.ops = &tc358746_entity_ops;
> > > > > +
> > > > > +	tc358746->pads[TC358746_SINK].flags = MEDIA_PAD_FL_SINK;
> > > > > +	tc358746->pads[TC358746_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
> > > > > +	err = media_entity_pads_init(&sd->entity, TC358746_NR_PADS,
> > > > > +				     tc358746->pads);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	err = v4l2_subdev_init_finalize(sd);
> > > > > +	if (err)
> > > > > +		media_entity_cleanup(&sd->entity);
> > > > > +
> > > > > +	return err;
> > > > > +}
> > > > > +
> > > > > +static int
> > > > > +tc358746_init_output_port(struct tc358746 *tc358746, unsigned long refclk)
> > > > > +{
> > > > > +	struct device *dev = tc358746->sd.dev;
> > > > > +	struct v4l2_fwnode_endpoint *vep;
> > > > > +	unsigned long csi_link_rate;
> > > > > +	struct fwnode_handle *ep;
> > > > > +	unsigned char csi_lanes;
> > > > > +	int err;
> > > > > +
> > > > > +	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), TC358746_SOURCE,
> > > > > +					     0, 0);
> > > > > +	if (!ep) {
> > > > > +		dev_err(dev, "Missing endpoint node\n");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	/* Currently we only support 'parallel in' -> 'csi out' */
> > > > > +	vep = &tc358746->csi_vep;
> > > > > +	vep->bus_type = V4L2_MBUS_CSI2_DPHY;
> > > > > +	err = v4l2_fwnode_endpoint_alloc_parse(ep, vep);
> > > > > +	fwnode_handle_put(ep);
> > > > > +	if (err) {
> > > > > +		dev_err(dev, "Failed to parse source endpoint\n");
> > > > > +		return err;
> > > > > +	}
> > > > > +
> > > > > +	csi_lanes = vep->bus.mipi_csi2.num_data_lanes;
> > > > > +	if (csi_lanes == 0 || csi_lanes > 4 ||
> > > > > +	    vep->nr_of_link_frequencies == 0) {
> > > > > +		dev_err(dev, "error: Invalid CSI-2 settings\n");
> > > > > +		err = -EINVAL;
> > > > > +		goto err;
> > > > > +	}
> > > > > +
> > > > > +	/* TODO: Add support to handle multiple link frequencies */
> > > > > +	csi_link_rate = (unsigned long)vep->link_frequencies[0];
> > > > > +	tc358746->pll_rate = tc358746_find_pll_settings(tc358746, refclk,
> > > > > +							csi_link_rate * 2);
> > > > > +	if (!tc358746->pll_rate) {
> > > > > +		err = -EINVAL;
> > > > > +		goto err;
> > > > > +	}
> > > > > +
> > > > > +	err = phy_mipi_dphy_get_default_config_for_hsclk(tc358746->pll_rate,
> > > > > +						csi_lanes, &tc358746->dphy_cfg);
> > > > > +	if (err)
> > > > > +		goto err;
> > > > > +
> > > > > +	tc358746->vb_size = TC358746_VB_DEFAULT_SIZE;
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +err:
> > > > > +	v4l2_fwnode_endpoint_free(vep);
> > > > > +
> > > > > +	return err;
> > > > > +}
> > > > > +
> > > > > +static int tc358746_init_hw(struct tc358746 *tc358746)
> > > > > +{
> > > > > +	struct device *dev = tc358746->sd.dev;
> > > > > +	unsigned int chipid;
> > > > > +	u32 val;
> > > > > +	int err;
> > > > > +
> > > > > +	err = pm_runtime_resume_and_get(dev);
> > > > > +	if (err < 0) {
> > > > > +		dev_err(dev, "Failed to resume the device\n");
> > > > > +		return err;
> > > > > +	}
> > > > > +
> > > > > +	 /* Ensure that CSI interface is put into LP-11 state */
> > > > > +	err = tc358746_sw_reset(tc358746);
> > > > > +	if (err) {
> > > > > +		pm_runtime_put_noidle(dev);
> > > > 
> > > > Don't you need a regular put (possibly with autosuspend) here ?
> > > > Otherwise a reset failure will decrement the runtime PM use count but
> > > > leave the decide powered.
> > > 
> > > The runtime_disable() will be called within the probe(). Please see
> > > the error path there for tc358746_init_hw().
> > 
> > Those are two different things, I don't think pm_runtime_disable() will
> > power the device off.
> 
> Arg.. Yes you're right. I will fix it by using the
> pm_runtime_put_sync_suspend() now. Thanks.

I think pm_runtime_put_sync() is enough, or even pm_runtime_put() if you
don't need the power to be turned off immediately.

> > > > > +		dev_err(dev, "Failed to reset the device\n");
> > > > > +		return err;
> > > > > +	}
> > > > > +
> > > > > +	err = tc358746_read(tc358746, CHIPID_REG, &val);
> > > > > +	pm_runtime_mark_last_busy(dev);
> > > > > +	pm_runtime_put_sync_autosuspend(dev);
> > > > > +	if (err) {
> > > > > +		dev_err(dev, "Failed to read chipid\n");
> > > > 
> > > > How about moving the read failure message to tc358746_read() ? It's
> > > > useful to get error messages for all failures, not just this one. Or do
> > > > we get a message from regmap already ? If we do, then we could just drop
> > > > this.
> > > 
> > > I don't see any code within regmap. I will move it to tc358746_read()
> > > and tc358746_write() helpers.
> > > 
> > > > > +		return -ENODEV;
> > > > > +	}
> > > > > +
> > > > > +	chipid = FIELD_GET(CHIPID, val);
> > > > > +	if (chipid != 0x44) {
> > > > > +		dev_err(dev, "Invalid chipid 0x%02x\n", chipid);
> > > > > +		return -ENODEV;
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int tc358746_setup_mclk_provider(struct tc358746 *tc358746)
> > > > 
> > > > I'd move this right after tc358746_mclk_ops as they're related.
> > > 
> > > Okay.
> > > 
> > > > > +{
> > > > > +	struct clk_init_data mclk_initdata = { };
> > > > > +	struct device *dev = tc358746->sd.dev;
> > > > > +	const char *mclk_name;
> > > > > +	int err;
> > > > > +
> > > > > +	/* MCLK clk provider support is optional */
> > > > > +	if (!device_property_present(dev, "#clock-cells"))
> > > > > +		return 0;
> > > > > +
> > > > > +	/* Init to highest possibel MCLK */
> > > > > +	tc358746->mclk_postdiv = 512;
> > > > > +	tc358746->mclk_prediv = 8;
> > > > > +
> > > > > +	mclk_name = "tc358746-mclk";
> > > > > +	device_property_read_string(dev, "clock-output-names",
> > > > > +				    &mclk_name);
> > > > 
> > > > This holds on a single line.
> > > 
> > > Sure.
> > > 
> > > > > +
> > > > > +	mclk_initdata.name = mclk_name;
> > > > > +	mclk_initdata.ops = &tc358746_mclk_ops;
> > > > > +	tc358746->mclk_hw.init = &mclk_initdata;
> > > > > +
> > > > > +	err = devm_clk_hw_register(dev, &tc358746->mclk_hw);
> > > > > +	if (err) {
> > > > > +		dev_err(dev, "Failed to register mclk provider\n");
> > > > > +		return err;
> > > > > +	}
> > > > > +
> > > > > +	err = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> > > > > +					  &tc358746->mclk_hw);
> > > > > +	if (err)
> > > > > +		dev_err(dev, "Failed to add mclk provider\n");
> > > > > +
> > > > > +	return err;
> > > > > +}
> > > > > +
> > > > > +static int tc358746_init_controls(struct tc358746 *tc358746)
> > > > > +{
> > > > > +	u64 *link_frequencies = tc358746->csi_vep.link_frequencies;
> > > > > +	struct v4l2_ctrl *ctrl;
> > > > > +	int err;
> > > > > +
> > > > > +	err = v4l2_ctrl_handler_init(&tc358746->ctrl_hdl, 1);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	ctrl = v4l2_ctrl_new_int_menu(&tc358746->ctrl_hdl, NULL,
> > > > > +				      V4L2_CID_LINK_FREQ, 0, 0,
> > > > 
> > > > Shouldn't the max argument be set to the number of items minus 1 ?
> > > 
> > > Right now I would keep it that way since the driver only supports one
> > > link-frequencies setting. So the ctrl don't let the userspace assume
> > > that there are more than one link-frequency.
> > 
> > Good point. Can you add a short comment above the call to explain this ?
> 
> Yes.
> 
> > 
> > > > > +				      link_frequencies);
> > > > > +	if (ctrl)
> > > > > +		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> > > > > +
> > > > > +	tc358746->sd.ctrl_handler = &tc358746->ctrl_hdl;
> > > > > +	if (tc358746->ctrl_hdl.error)
> > > > > +		return tc358746->ctrl_hdl.error;
> > > > 
> > > > You need to call v4l2_ctrl_handler_free() in the failure paths.
> > > 
> > > Arg.. you're right.
> > > 
> > > > > +
> > > > > +	return v4l2_ctrl_handler_setup(&tc358746->ctrl_hdl);
> > > > 
> > > > This can be skipped I think, as the only supported control is read-only.
> > > 
> > > Yes, you're right.
> > > 
> > > > > +}
> > > > > +
> > > > > +static int tc358746_notify_bound(struct v4l2_async_notifier *notifier,
> > > > > +				 struct v4l2_subdev *sd,
> > > > > +				 struct v4l2_async_subdev *asd)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 =
> > > > > +		container_of(notifier, struct tc358746, notifier);
> > > > > +	struct media_pad *sink = &tc358746->pads[TC358746_SINK];
> > > > > +
> > > > > +	return v4l2_create_fwnode_links_to_pad(sd, sink, MEDIA_LNK_FL_ENABLED);
> > > > 
> > > > I'd make the link immutable too, as only one source subdev is supported.
> > > 
> > > Yes, I can do that.
> > > 
> > > > > +}
> > > > > +
> > > > > +static const struct v4l2_async_notifier_operations tc358746_notify_ops = {
> > > > > +	.bound = tc358746_notify_bound,
> > > > > +};
> > > > > +
> > > > > +static int tc358746_async_register(struct tc358746 *tc358746)
> > > > > +{
> > > > > +	struct v4l2_fwnode_endpoint vep = {
> > > > > +		.bus_type = V4L2_MBUS_PARALLEL,
> > > > > +	};
> > > > > +	struct v4l2_async_subdev *asd;
> > > > > +	struct fwnode_handle *ep;
> > > > > +	int err;
> > > > > +
> > > > > +	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(tc358746->sd.dev),
> > > > > +					     TC358746_SINK, 0, 0);
> > > > > +	if (!ep)
> > > > > +		return -ENOTCONN;
> > > > > +
> > > > > +	err = v4l2_fwnode_endpoint_parse(ep, &vep);
> > > > > +	if (err) {
> > > > > +		fwnode_handle_put(ep);
> > > > > +		return err;
> > > > > +	}
> > > > > +
> > > > > +	v4l2_async_nf_init(&tc358746->notifier);
> > > > > +	asd = v4l2_async_nf_add_fwnode_remote(&tc358746->notifier, ep,
> > > > > +					      struct v4l2_async_subdev);
> > > > > +	if (IS_ERR(asd)) {
> > > > > +		fwnode_handle_put(ep);
> > > > 
> > > > You can move this before the error check and drop the next one.
> > > 
> > > Sure, thanks.
> > > 
> > > > > +		return PTR_ERR(asd);
> > > > 
> > > > Shouldn't v4l2_async_nf_cleanup() be called here ?
> > > 
> > > Yep.
> > > 
> > > > > +	}
> > > > > +
> > > > > +	fwnode_handle_put(ep);
> > > > > +
> > > > > +	tc358746->notifier.ops = &tc358746_notify_ops;
> > > > > +
> > > > > +	err = v4l2_async_subdev_nf_register(&tc358746->sd, &tc358746->notifier);
> > > > > +	if (err) {
> > > > > +		v4l2_async_nf_cleanup(&tc358746->notifier);
> > > > > +		return err;
> > > > > +	}
> > > > > +
> > > > > +	tc358746->sd.fwnode = fwnode_graph_get_endpoint_by_id(
> > > > > +		dev_fwnode(tc358746->sd.dev), TC358746_SOURCE, 0, 0);
> > > > 
> > > > Where is this reference dropped ?
> > > 
> > > That's a good question, should it be dropped upon the notify callback or
> > > does the v4l2-subdev use the fwnode elsewhere? I introduced this to get
> > > rid of the message: "considering updating the driver..".
> > 
> > I think it needs to be dropped in .remove() (and in probe error paths,
> > as needed).
> 
> Yep, I think so too. I will fix that, thanks.
> 
> > > > > +
> > > > > +	err = v4l2_async_register_subdev(&tc358746->sd);
> > > > > +	if (err) {
> > > > > +		v4l2_async_nf_unregister(&tc358746->notifier);
> > > > > +		v4l2_async_nf_cleanup(&tc358746->notifier);
> > > > > +	}
> > > > > +
> > > > > +	return err;
> > > > 
> > > > 	return 0;
> > > 
> > > This would drop possible errors from async_register, but I changed the
> > > function completely, so I will return 0 :)
> > 
> > I had misread the code, I thought there was a return err in the error
> > condition, my bad.
> > 
> > > > > +}
> > > > > +
> > > > > +static int tc358746_probe(struct i2c_client *client)
> > > > > +{
> > > > > +	struct device *dev = &client->dev;
> > > > > +	struct tc358746 *tc358746;
> > > > > +	unsigned long refclk;
> > > > > +	unsigned int i;
> > > > > +	int err;
> > > > > +
> > > > > +	tc358746 = devm_kzalloc(&client->dev, sizeof(*tc358746), GFP_KERNEL);
> > > > > +	if (!tc358746)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	tc358746->regmap = devm_regmap_init_i2c(client, &tc358746_regmap_config);
> > > > > +	if (IS_ERR(tc358746->regmap))
> > > > > +		return dev_err_probe(dev, PTR_ERR(tc358746->regmap),
> > > > > +				     "Failed to init regmap\n");
> > > > > +
> > > > > +	tc358746->refclk = devm_clk_get(dev, "refclk");
> > > > > +	if (IS_ERR(tc358746->refclk))
> > > > > +		return dev_err_probe(dev, PTR_ERR(tc358746->refclk),
> > > > > +				     "Failed to get refclk\n");
> > > > > +
> > > > > +	err = clk_prepare_enable(tc358746->refclk);
> > > > > +	if (err)
> > > > > +		return dev_err_probe(dev, err,
> > > > > +				     "Failed to enable refclk\n");
> > > > > +
> > > > > +	refclk = clk_get_rate(tc358746->refclk);
> > > > > +	clk_disable_unprepare(tc358746->refclk);
> > > > > +
> > > > > +	if (refclk < 6 * MHZ || refclk > 40 * MHZ)
> > > > > +		return dev_err_probe(dev, -EINVAL, "Invalid refclk range\n");
> > > > > +
> > > > > +	for (i = 0; i < ARRAY_SIZE(tc358746_supplies); i++)
> > > > > +		tc358746->supplies[i].supply = tc358746_supplies[i];
> > > > > +
> > > > > +	err = devm_regulator_bulk_get(dev, ARRAY_SIZE(tc358746_supplies),
> > > > > +				      tc358746->supplies);
> > > > > +	if (err)
> > > > > +		return dev_err_probe(dev, err, "Failed to get supplies\n");
> > > > > +
> > > > > +	tc358746->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > > > > +						       GPIOD_OUT_HIGH);
> > > > > +	if (IS_ERR(tc358746->reset_gpio))
> > > > > +		return dev_err_probe(dev, PTR_ERR(tc358746->reset_gpio),
> > > > > +				     "Failed to get reset-gpios\n");
> > > > > +
> > > > > +	err = tc358746_init_subdev(tc358746, client);
> > > > > +	if (err)
> > > > > +		return dev_err_probe(dev, err, "Failed to init subdev\n");
> > > > > +
> > > > > +	err = tc358746_init_output_port(tc358746, refclk);
> > > > > +	if (err)
> > > > > +		goto err_subdev;
> > > > > +
> > > > > +	/*
> > > > > +	 * Keep this order since we need the output port link-frequencies
> > > > > +	 * information.
> > > > > +	 */
> > > > > +	err = tc358746_init_controls(tc358746);
> > > > > +	if (err)
> > > > > +		goto err_fwnode;
> > > > > +
> > > > > +	dev_set_drvdata(dev, tc358746);
> > > > > +	pm_runtime_set_autosuspend_delay(dev, 200);
> > > > 
> > > > 200ms may be a bit short for a complete stop/restart cycle. How about
> > > > 1s ?
> > > 
> > > Isn't it the time upon which the pm-fw will put the device into stop? I
> > > can increase it of course, but I don't see any improvements for it.
> > 
> > The idea is that autosuspend is helpful to avoid an expensive
> > power-off/power-on cycle when stopping video capture, reconfiguring the
> > source (and the pipeline) and restarting capture. Depending on the
> > source, 200ms may be a bit short.
> 
> Ah now  I got your point. From that pov, I agree with you. I will
> increase it to 1000, thanks.
> 
> > > Thanks again for the detailed review :)
> > > 
> > > > > +	pm_runtime_use_autosuspend(dev);
> > > > > +	pm_runtime_enable(dev);
> > > > > +
> > > > > +	err = tc358746_init_hw(tc358746);
> > > > > +	if (err)
> > > > > +		goto err_pm;
> > > > > +
> > > > > +	err = tc358746_setup_mclk_provider(tc358746);
> > > > > +	if (err)
> > > > > +		goto err_pm;
> > > > > +
> > > > > +	err = tc358746_async_register(tc358746);
> > > > > +	if (err < 0)
> > > > > +		goto err_pm;
> > > > > +
> > > > > +	dev_dbg(dev, "%s found @ 0x%x (%s)\n", client->name,
> > > > > +		client->addr, client->adapter->name);
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +err_pm:
> > > > > +	pm_runtime_disable(dev);
> > > > > +	pm_runtime_set_suspended(dev);
> > > > > +	pm_runtime_dont_use_autosuspend(dev);
> > > > > +	v4l2_ctrl_handler_free(&tc358746->ctrl_hdl);
> > > > > +err_fwnode:
> > > > > +	v4l2_fwnode_endpoint_free(&tc358746->csi_vep);
> > > > > +err_subdev:
> > > > > +	v4l2_subdev_cleanup(&tc358746->sd);
> > > > > +	media_entity_cleanup(&tc358746->sd.entity);
> > > > > +
> > > > > +	return err;
> > > > > +}
> > > > > +
> > > > > +static int tc358746_remove(struct i2c_client *client)
> > > > > +{
> > > > > +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> > > > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > > > +
> > > > > +	v4l2_subdev_cleanup(sd);
> > > > > +	v4l2_ctrl_handler_free(&tc358746->ctrl_hdl);
> > > > > +	v4l2_fwnode_endpoint_free(&tc358746->csi_vep);
> > > > > +	v4l2_async_nf_unregister(&tc358746->notifier);
> > > > > +	v4l2_async_nf_cleanup(&tc358746->notifier);
> > > > > +	v4l2_async_unregister_subdev(sd);
> > > > > +	media_entity_cleanup(&sd->entity);
> > > > > +
> > > > > +	pm_runtime_disable(sd->dev);
> > > > > +	pm_runtime_set_suspended(sd->dev);
> > > > > +	pm_runtime_dont_use_autosuspend(sd->dev);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int tc358746_suspend(struct device *dev)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = dev_get_drvdata(dev);
> > > > > +	int err;
> > > > > +
> > > > > +	clk_disable_unprepare(tc358746->refclk);
> > > > > +
> > > > > +	err = regulator_bulk_disable(ARRAY_SIZE(tc358746_supplies),
> > > > > +				     tc358746->supplies);
> > > > > +	if (err)
> > > > > +		clk_prepare_enable(tc358746->refclk);
> > > > > +
> > > > > +	return err;
> > > > > +}
> > > > > +
> > > > > +static int tc358746_resume(struct device *dev)
> > > > > +{
> > > > > +	struct tc358746 *tc358746 = dev_get_drvdata(dev);
> > > > > +	int err;
> > > > > +
> > > > > +	gpiod_set_value(tc358746->reset_gpio, 1);
> > > > > +
> > > > > +	err = regulator_bulk_enable(ARRAY_SIZE(tc358746_supplies),
> > > > > +				    tc358746->supplies);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	/* min. 200ns */
> > > > > +	usleep_range(10, 20);
> > > > > +
> > > > > +	gpiod_set_value(tc358746->reset_gpio, 0);
> > > > > +
> > > > > +	err = clk_prepare_enable(tc358746->refclk);
> > > > > +	if (err)
> > > > > +		goto err;
> > > > > +
> > > > > +	/* min. 700us ... 1ms */
> > > > > +	usleep_range(1000, 1500);
> > > > > +
> > > > > +	/*
> > > > > +	 * Enable the PLL here since it can be called by the clk-framework or by
> > > > > +	 * the .s_stream() callback. So this is the common place for both.
> > > > > +	 */
> > > > > +	err = tc358746_apply_pll_config(tc358746);
> > > > > +	if (err)
> > > > > +		goto err_clk;
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +err_clk:
> > > > > +	clk_disable_unprepare(tc358746->refclk);
> > > > > +err:
> > > > > +	regulator_bulk_disable(ARRAY_SIZE(tc358746_supplies),
> > > > > +			       tc358746->supplies);
> > > > > +	return err;
> > > > > +}
> > > > > +
> > > > > +DEFINE_RUNTIME_DEV_PM_OPS(tc358746_pm_ops, tc358746_suspend,
> > > > > +			  tc358746_resume, NULL);
> > > > > +
> > > > > +static const struct of_device_id __maybe_unused tc358746_of_match[] = {
> > > > > +	{ .compatible = "toshiba,tc358746" },
> > > > > +	{ },
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, tc358746_of_match);
> > > > > +
> > > > > +static struct i2c_driver tc358746_driver = {
> > > > > +	.driver = {
> > > > > +		.name = "tc358746",
> > > > > +		.pm = pm_ptr(&tc358746_pm_ops),
> > > > > +		.of_match_table = tc358746_of_match,
> > > > > +	},
> > > > > +	.probe_new = tc358746_probe,
> > > > > +	.remove = tc358746_remove,
> > > > > +};
> > > > > +
> > > > > +module_i2c_driver(tc358746_driver);
> > > > > +
> > > > > +MODULE_DESCRIPTION("Toshiba TC358746 Parallel to CSI-2 bridge driver");
> > > > > +MODULE_AUTHOR("Marco Felsch <kernel@pengutronix.de>");
> > > > > +MODULE_LICENSE("GPL");

-- 
Regards,

Laurent Pinchart
