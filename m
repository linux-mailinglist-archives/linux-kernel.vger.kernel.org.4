Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147395BAF70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiIPOde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPOd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:33:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175D941D12;
        Fri, 16 Sep 2022 07:33:28 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [104.132.8.103])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4B372440;
        Fri, 16 Sep 2022 16:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663338806;
        bh=0mq6iLjBRXE5LO1vAZY1gNiVywyq6U+Bz30w2WEJ6W0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFOXZCjlrBQLXWQVyj4ZYr+ig3ENlC0wfxUIL2C3aKei8hr+pAgbpWkDF8+4BdlCl
         +yeOJcWbv60wj4es3VfrER/TBurm/yyeKBuZDwpAvEpFIHDMJquJEvOXgHLbRECoUQ
         RGBlyg0gbDBV0jRAIpxOs0l+95zluKk/tPnRbRvs=
Date:   Fri, 16 Sep 2022 17:33:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org, kishon@ti.com,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        jacopo@jmondi.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <YySJKFdB+a8zxRLS@pendragon.ideasonboard.com>
References: <20220818143307.967150-1-m.felsch@pengutronix.de>
 <20220818143307.967150-5-m.felsch@pengutronix.de>
 <YxZWB3mE1Mk4JV/c@pendragon.ideasonboard.com>
 <20220915165404.ghcjntxom7kzqyuy@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220915165404.ghcjntxom7kzqyuy@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Thu, Sep 15, 2022 at 06:54:04PM +0200, Marco Felsch wrote:
> On 22-09-05, Laurent Pinchart wrote:
> > On Thu, Aug 18, 2022 at 04:33:07PM +0200, Marco Felsch wrote:
> > > Adding support for the TC358746 parallel <-> MIPI CSI bridge. This chip
> > > supports two operating modes:
> > >   1st) parallel-in -> mipi-csi out
> > >   2nd) mipi-csi in -> parallel out
> > > 
> > > This patch only adds the support for the 1st mode.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  drivers/media/i2c/Kconfig    |   17 +
> > >  drivers/media/i2c/Makefile   |    1 +
> > >  drivers/media/i2c/tc358746.c | 1645 ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 1663 insertions(+)
> > >  create mode 100644 drivers/media/i2c/tc358746.c

[snip]

> > > diff --git a/drivers/media/i2c/tc358746.c b/drivers/media/i2c/tc358746.c
> > > new file mode 100644
> > > index 000000000000..7b71d0cf72a9
> > > --- /dev/null
> > > +++ b/drivers/media/i2c/tc358746.c

[snip]

> > > +struct tc358746 {
> > > +	struct v4l2_subdev		sd;
> > > +	struct media_pad		pads[TC358746_NR_PADS];
> > > +	struct v4l2_async_notifier	notifier;
> > > +	struct v4l2_mbus_framefmt	mbusfmt;
> > 
> > Could you use the active state API instead of manually storing mbusfmt
> > here ? It involves
> 
> I will do that, thanks for the hint and it also elimates a few basic
> checks like the pad-num check.

Even nicer :-)

> > - Implementing the .init_cfg() operation
> > - Calling v4l2_subdev_init_finalize() in probe
> > - Replacing calls to __tc358746_get_pad_format() with
> >   v4l2_subdev_get_pad_format()
> > - Propagating the format from sink to source in tc358746_set_fmt()
> > - Dropping tc358746_src_mbus_code() from tc358746_get_fmt() and simply
> >   retrieving the format using v4l2_subdev_get_pad_format() there
> > - Dropping this field
> > 
> > The formats for both the ACTIVE and TRY states will then be stored in
> > the subdev state, unconditionally. You can retrieve the active state
> > with v4l2_subdev_get_locked_active_state() in tc358746_s_stream().
> > 
> > > +	struct v4l2_fwnode_endpoint	csi_vep;
> > > +
> > > +	struct v4l2_ctrl_handler	ctrl_hdl;
> > > +
> > > +	struct regmap			*regmap;
> > > +	struct clk			*refclk;
> > > +	struct gpio_desc		*reset_gpio;
> > > +	struct regulator_bulk_data	supplies[ARRAY_SIZE(tc358746_supplies)];
> > > +
> > > +	struct clk_hw			mclk_hw;
> > > +	unsigned long			mclk_rate;
> > > +	u8				mclk_prediv;
> > > +	u16				mclk_postdiv;
> > > +
> > > +	unsigned long			pll_rate;
> > > +	u8				pll_post_div;
> > > +	u16				pll_pre_div;
> > > +	u16				pll_mul;
> > > +
> > > +	struct v4l2_ctrl		*sensor_pclk_ctrl;
> > > +
> > > +#define TC358746_VB_MAX_SIZE		(511 * 32)
> > > +#define TC358746_VB_DEFAULT_SIZE	  (1 * 32)
> > > +	unsigned int			vb_size; /* Video buffer size in bits */
> > > +
> > > +	struct phy_configure_opts_mipi_dphy dphy_cfg;
> > > +};

[snip]

> > > +#ifndef MHZ
> > 
> > Where would it be previously defined ? This sounds like asking for
> > trouble later.
> 
> Sorry I don't get that, do you mean that I should define it at the very
> beginning?

I mean that either MHZ is defined somewhere in the kernel already, in
case we should include the corresponding header, or it's not, and I
wouldn't add an #ifndev here. Otherwise, if someone adds a MHZ macro
later that gets pulled in through one of the kernel headers used by the
driver, it may cause subtle bugs if the definition is different. Of
course nobody will

#define MHZ		42

but we could get

#define MHZ		1000 * 1000

and something could break here. I'd drop the #ifndef to get the compiler
to complain if there's a redefinition.

> > > +#define MHZ		(1000 * 1000)
> > > +#endif

[snip]

> > > +static int
> > > +tc358746_link_validate(struct v4l2_subdev *sd, struct media_link *link,
> > > +		       struct v4l2_subdev_format *source_fmt,
> > > +		       struct v4l2_subdev_format *sink_fmt)
> > > +{
> > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > +	unsigned long csi_bitrate, sensor_bitrate;
> > > +	const struct tc358746_format *fmt;
> > > +	unsigned int fifo_sz, tmp, n;
> > > +	s64 sensor_pclk_rate;
> > > +
> > > +	/* Check the FIFO settings */
> > > +	fmt = tc358746_get_format_by_code(TC358746_SINK, tc358746->mbusfmt.code);
> > > +	if (IS_ERR(fmt))
> > > +		return PTR_ERR(fmt);
> > > +
> > > +	sensor_pclk_rate = v4l2_ctrl_g_ctrl_int64(tc358746->sensor_pclk_ctrl);
> > > +	sensor_bitrate = sensor_pclk_rate * fmt->bus_width;
> > > +
> > > +	csi_bitrate = tc358746->dphy_cfg.lanes * tc358746->pll_rate;
> > > +
> > > +	dev_dbg(tc358746->sd.dev,
> > > +		"Fifo settings params: sensor-bitrate:%lu csi-bitrate:%lu",
> > > +		sensor_bitrate, csi_bitrate);
> > > +
> > > +	/* Avoid possible FIFO overflows */
> > > +	if (csi_bitrate < sensor_bitrate) {
> > > +		dev_err(sd->dev,
> > > +			"Link validation failed csi-bitrate:%lu < sensor-bitrate:%lu\n",
> > > +			csi_bitrate, sensor_bitrate);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* Best case */
> > > +	if (csi_bitrate == sensor_bitrate) {
> > > +		tc358746->vb_size = TC358746_VB_DEFAULT_SIZE;
> > > +		goto out;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Avoid possible FIFO underflow in case of
> > > +	 * csi_bitrate > sensor_bitrate. For such case the chip has a internal
> > > +	 * fifo which can be used to delay the line output.
> > > +	 *
> > > +	 * Fifo size calculation:
> > > +	 *
> > > +	 * fifo-sz, image-width - in bits
> > > +	 * sbr                  - sensor_bitrate in bits/s
> > > +	 * csir                 - csi_bitrate in bits/s
> > > +	 *
> > > +	 *                1             1      1
> > > +	 * image-width * --- + fifo-sz --- >= ---- * image-width
> > > +	 *               sbr           sbr    csir
> > > +	 *
> > > +	 * fifo-sz >= abs(sbr/csir * image-width - image-width)
> > > +	 *                `-----´
> > > +	 *                   n
> > > +	 *
> > > +	 */
> > > +
> > > +	sensor_bitrate /= TC358746_PRECISION;
> > > +	n = csi_bitrate / sensor_bitrate;
> > > +	tmp = (tc358746->mbusfmt.width * TC358746_PRECISION) / n;
> > > +	fifo_sz = tc358746->mbusfmt.width - tmp;
> > > +	fifo_sz *= fmt->bpp;
> > > +	tc358746->vb_size = round_up(fifo_sz, 32);
> > > +
> > 
> > Please also call v4l2_subdev_link_validate_default() here.
> 
> Did it in my internal prepared v2 ^^ I call it now at the very
> beginning of this function.
> 
> > I wonder if the above calculation wouldn't be better performed in
> > .s_stream() (or rather in a function being called by .s_stream()) when
> > enabling streaming.
> 
> No I wouldn't shift that, since the link validation is in IMHO the
> correct place to inform the user that the pipeline can't negotiate if
> the fifo can't be configured correctly. Therefore I placed it here.

The issue is that the user could enable the link first, and then change
the V4L2_CID_LINK_FREQ of the sensor and push the pixel rate above what
the TC358746 can support. Given the model that configures subdevs
independently, you can only validate the pipeline at stream on time.

> > > +out:
> > > +	dev_dbg(tc358746->sd.dev,
> > > +		"Found FIFO size[bits]:%u -> aligned to size[bits]:%u\n",
> > > +		fifo_sz, tc358746->vb_size);
> > > +
> > > +	return tc358746->vb_size > TC358746_VB_MAX_SIZE ? -EINVAL : 0;
> > > +}

[snip]

> > > +static int tc358746_probe(struct i2c_client *client)
> > > +{
> > > +	struct clk_init_data mclk_initdata = { };
> > > +	struct device *dev = &client->dev;
> > > +	struct v4l2_fwnode_endpoint *vep;
> > > +	unsigned long csi_link_rate;
> > > +	struct tc358746 *tc358746;
> > > +	struct fwnode_handle *ep;
> > > +	unsigned char csi_lanes;
> > > +	struct v4l2_subdev *sd;
> > > +	struct v4l2_ctrl *ctrl;
> > > +	unsigned long refclk;
> > > +	unsigned int i;
> > > +	int err;
> > > +	u32 val;
> > > +
> > > +	tc358746 = devm_kzalloc(&client->dev, sizeof(*tc358746), GFP_KERNEL);
> > > +	if (!tc358746)
> > > +		return -ENOMEM;
> > > +
> > > +	tc358746->regmap = devm_regmap_init_i2c(client, &tc358746_regmap_config);
> > > +	if (IS_ERR(tc358746->regmap))
> > > +		return dev_err_probe(dev, PTR_ERR(tc358746->regmap),
> > > +				     "Failed to init regmap\n");
> > > +
> > > +	tc358746->refclk = devm_clk_get(dev, "refclk");
> > > +	if (IS_ERR(tc358746->refclk))
> > > +		return dev_err_probe(dev, PTR_ERR(tc358746->refclk),
> > > +				     "Failed to get refclk\n");
> > > +
> > > +	err = clk_prepare_enable(tc358746->refclk);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err,
> > > +				     "Failed to enable refclk\n");
> > > +
> > > +	refclk = clk_get_rate(tc358746->refclk);
> > > +	clk_disable_unprepare(tc358746->refclk);
> > > +
> > > +	if (refclk < 6 * MHZ || refclk > 40 * MHZ)
> > > +		return dev_err_probe(dev, -EINVAL, "Invalid refclk range\n");
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(tc358746_supplies); i++)
> > > +		tc358746->supplies[i].supply = tc358746_supplies[i];
> > > +
> > > +	err = devm_regulator_bulk_get(dev, ARRAY_SIZE(tc358746_supplies),
> > > +				      tc358746->supplies);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to get supplies\n");
> > > +
> > > +	tc358746->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > > +						       GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(tc358746->reset_gpio))
> > > +		return dev_err_probe(dev, PTR_ERR(tc358746->reset_gpio),
> > > +				     "Failed to get reset-gpios\n");
> > > +
> > > +	sd = &tc358746->sd;
> > > +	v4l2_i2c_subdev_init(sd, client, &tc358746_ops);
> > > +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> > > +	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
> > > +	sd->entity.ops = &tc358746_entity_ops;
> > > +
> > > +	tc358746->pads[TC358746_SINK].flags = MEDIA_PAD_FL_SINK;
> > > +	tc358746->pads[TC358746_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
> > > +	err = media_entity_pads_init(&sd->entity, TC358746_NR_PADS,
> > > +				     tc358746->pads);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err,
> > > +				     "Failed to setup media-entity pads\n");
> > > +
> > > +	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), TC358746_SOURCE,
> > > +					     0, 0);
> > > +	if (!ep) {
> > > +		dev_err(dev, "Missing endpoint node\n");
> > > +		err = -EINVAL;
> > > +		goto err_mc;
> > > +	}
> > > +
> > > +	/* Currently we only support 'parallel in' -> 'csi out' */
> > > +	vep = &tc358746->csi_vep;
> > > +	vep->bus_type = V4L2_MBUS_CSI2_DPHY;
> > > +	err = v4l2_fwnode_endpoint_alloc_parse(ep, vep);
> > > +	fwnode_handle_put(ep);
> > > +	if (err) {
> > > +		dev_err(dev, "Failed to parse source endpoint\n");
> > > +		goto err_mc;
> > > +	}
> > > +
> > > +	csi_lanes = vep->bus.mipi_csi2.num_data_lanes;
> > > +	if (csi_lanes == 0 || csi_lanes > 4 ||
> > > +	    vep->nr_of_link_frequencies == 0) {
> > > +		dev_err(dev, "error: Invalid CSI-2 settings\n");
> > > +		err = -EINVAL;
> > > +		goto err_vep;
> > > +	}
> > > +
> > > +	/* TODO: Add support to handle multiple link frequencies */
> > > +	csi_link_rate = (unsigned long)vep->link_frequencies[0];
> > > +	tc358746->pll_rate = tc358746_find_pll_settings(tc358746, refclk,
> > > +							csi_link_rate * 2);
> > > +	if (!tc358746->pll_rate) {
> > > +		err = -EINVAL;
> > > +		goto err_vep;
> > > +	}
> > > +
> > > +	err = phy_mipi_dphy_get_default_config_for_hsclk(tc358746->pll_rate,
> > > +							 csi_lanes,
> > > +							 &tc358746->dphy_cfg);
> > > +	if (err)
> > > +		goto err_vep;
> > > +
> > > +	tc358746->mbusfmt = tc358746_def_fmt;
> > > +	tc358746->vb_size = TC358746_VB_DEFAULT_SIZE;
> > > +
> > > +	dev_set_drvdata(dev, tc358746);
> > > +	pm_runtime_set_autosuspend_delay(dev, 200);
> > > +	pm_runtime_use_autosuspend(dev);
> > > +	pm_runtime_enable(dev);
> > > +
> > > +	err = pm_runtime_resume_and_get(dev);
> > > +	if (err < 0) {
> > > +		dev_err(dev, "Failed to resume the device\n");
> > > +		goto err_vep;
> > > +	}
> > > +
> > > +	 /* Ensure that CSI interface is put into LP-11 state */
> > > +	err = tc358746_sw_reset(tc358746);
> > > +	if (err) {
> > > +		pm_runtime_put_noidle(dev);
> > > +		dev_err(dev, "Failed to reset the device\n");
> > > +		goto err_pm;
> > > +	}
> > > +
> > > +	err = tc358746_read(tc358746, CHIPID_REG, &val);
> > > +	pm_runtime_mark_last_busy(dev);
> > > +	pm_runtime_put_sync_autosuspend(dev);
> > > +	if (err) {
> > > +		dev_err(dev, "Failed to read chipid\n");
> > > +		err = -ENODEV;
> > > +		goto err_pm;
> > > +	}
> > > +
> > > +	if (FIELD_GET(CHIPID, val) != 0x44) {
> > > +		dev_err(dev, "Invalid chipid 0x%02x\n",
> > > +			(u32)FIELD_GET(CHIPID, val));
> > > +		err = -ENODEV;
> > > +		goto err_pm;
> > > +	}
> > > +
> > > +	/* Optional MCLK provider support */
> > > +	if (device_property_present(dev, "#clock-cells")) {
> > > +		const char *mclk_name;
> > > +
> > > +		/* Init to highest possibel MCLK */
> > > +		tc358746->mclk_postdiv = 512;
> > > +		tc358746->mclk_prediv = 8;
> > > +
> > > +		mclk_name = "tc358746-mclk";
> > > +		device_property_read_string(dev, "clock-output-names",
> > > +					    &mclk_name);
> > > +
> > > +		mclk_initdata.name = mclk_name;
> > > +		mclk_initdata.ops = &tc358746_mclk_ops;
> > > +		tc358746->mclk_hw.init = &mclk_initdata;
> > > +
> > > +		err = devm_clk_hw_register(dev, &tc358746->mclk_hw);
> > > +		if (err) {
> > > +			dev_err(dev, "Failed to register mclk provider\n");
> > > +			goto err_pm;
> > > +		}
> > > +
> > > +		err = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> > > +						  &tc358746->mclk_hw);
> > > +		if (err) {
> > > +			dev_err(dev, "Failed to add mclk provider\n");
> > > +			goto err_pm;
> > > +		}
> > > +	}
> > > +
> > > +	v4l2_ctrl_handler_init(&tc358746->ctrl_hdl, 1);
> > > +
> > > +	ctrl = v4l2_ctrl_new_int_menu(&tc358746->ctrl_hdl, NULL,
> > > +				      V4L2_CID_LINK_FREQ, 0, 0,
> > > +				      vep->link_frequencies);
> > > +	if (ctrl)
> > > +		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> > > +
> > > +	tc358746->sd.ctrl_handler = &tc358746->ctrl_hdl;
> > > +	if (tc358746->ctrl_hdl.error) {
> > > +		err = tc358746->ctrl_hdl.error;
> > > +		goto err_pm;
> > > +	}
> > > +
> > > +	v4l2_ctrl_handler_setup(&tc358746->ctrl_hdl);
> > > +
> > > +	err = tc358746_async_register(tc358746);
> > > +	if (err < 0)
> > > +		goto err_ctrl;
> > > +
> > > +	dev_info(dev, "%s found @ 0x%x (%s)\n", client->name,
> > > +		  client->addr, client->adapter->name);
> > 
> > I'd skip this to avoid adding noise to the kernel log at boot time. I
> > would also probably split some of the code out of the probe function as
> > it's fairly large. Up to you.
> 
> Yes it is large but most of it is just requesting stuff and so..
> Therefore I kept it here since I don't need it elsewhere. What about
> setting it to dev_dbg()? Sometimes it can be useful e.g. to find the
> problem why /dev/media is not comming up..

I find that enabling dev_dbg() messages from drivers/base/dd.c are
helpful for that, but a dev_dbg() message here is fine too.

> > > +
> > > +	return 0;
> > > +
> > > +err_ctrl:
> > > +	v4l2_ctrl_handler_free(&tc358746->ctrl_hdl);
> > > +err_pm:
> > > +	pm_runtime_disable(dev);
> > > +	pm_runtime_set_suspended(dev);
> > > +	pm_runtime_dont_use_autosuspend(dev);
> > > +err_vep:
> > > +	v4l2_fwnode_endpoint_free(vep);
> > > +err_mc:
> > > +	media_entity_cleanup(&sd->entity);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static int tc358746_remove(struct i2c_client *client)
> > > +{
> > > +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > +
> > > +	v4l2_ctrl_handler_free(&tc358746->ctrl_hdl);
> > > +	v4l2_fwnode_endpoint_free(&tc358746->csi_vep);
> > > +	v4l2_async_nf_unregister(&tc358746->notifier);
> > > +	v4l2_async_nf_cleanup(&tc358746->notifier);
> > > +	v4l2_async_unregister_subdev(sd);
> > > +	v4l2_device_unregister_subdev(sd);
> > 
> > This shouldn't be needed v4l2_async_unregister_subdev() should be
> > enough.
> 
> Okay, thanks. There are a lot of unregister helpers in the v4l2 space..

Too many of them indeed. I'd like to simplify all that.

> > > +	media_entity_cleanup(&sd->entity);
> > > +
> > > +	pm_runtime_disable(sd->dev);
> > > +	pm_runtime_set_suspended(sd->dev);
> > > +	pm_runtime_dont_use_autosuspend(sd->dev);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int tc358746_suspend(struct device *dev)
> > > +{
> > > +	struct tc358746 *tc358746 = dev_get_drvdata(dev);
> > > +
> > > +	clk_disable_unprepare(tc358746->refclk);
> > > +
> > > +	return regulator_bulk_disable(ARRAY_SIZE(tc358746_supplies),
> > > +				      tc358746->supplies);
> > 
> > Shouldn't you reenable the clock if this fails ?
> 
> Hm.. if this fails I could end in a undefined chip state. But I got the
> point that the framework would be in a bad state if it tries again to
> suspend the device.

It would be, and without a way to recover, so that could be an issue.

> > > +}
> > > +
> > > +static int tc358746_resume(struct device *dev)
> > > +{
> > > +	struct tc358746 *tc358746 = dev_get_drvdata(dev);
> > > +	int err;
> > > +
> > > +	gpiod_set_value(tc358746->reset_gpio, 1);
> > > +
> > > +	err = regulator_bulk_enable(ARRAY_SIZE(tc358746_supplies),
> > > +				    tc358746->supplies);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* min. 200ns */
> > > +	usleep_range(10, 20);
> > > +
> > > +	gpiod_set_value(tc358746->reset_gpio, 0);
> > > +
> > > +	err = clk_prepare_enable(tc358746->refclk);
> > > +	if (err)
> > > +		return err;
> > 
> > The regulators need to be disabled in case of failure here and below
> > (and so does the clock below).
> 
> Yes, you're right.
> 
> > > +
> > > +	/* min. 700us ... 1ms */
> > > +	usleep_range(1000, 1500);
> > > +
> > > +	/* Sync state */
> > > +	err = tc358746_apply_pll_config(tc358746);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = tc358746_apply_dphy_config(tc358746);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return tc358746_apply_misc_config(tc358746);
> > 
> > Does all this belong to the PM resume handler ? It seems configuration
> > could be handled in .s_stream() instead.
> 
> This gets called by the s_stream() during getting the power state but I
> can move the dphy/misc_config to the .s_stream() of course.

That would be nice, thanks.

> The pll
> needs to be there since the device can be a clock provider e.g. for the
> sensor.

OK.

> Thanks for the review :)
> 
> > > +}
> > > +
> > > +DEFINE_RUNTIME_DEV_PM_OPS(tc358746_pm_ops, tc358746_suspend,
> > > +			  tc358746_resume, NULL);
> > > +
> > > +static const struct of_device_id __maybe_unused tc358746_of_match[] = {
> > > +	{ .compatible = "toshiba,tc358746" },
> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, tc358746_of_match);
> > > +
> > > +static struct i2c_driver tc358746_driver = {
> > > +	.driver = {
> > > +		.name = "tc358746",
> > > +		.pm = pm_ptr(&tc358746_pm_ops),
> > > +		.of_match_table = tc358746_of_match,
> > > +	},
> > > +	.probe_new = tc358746_probe,
> > > +	.remove = tc358746_remove,
> > > +};
> > > +
> > > +module_i2c_driver(tc358746_driver);
> > > +
> > > +MODULE_DESCRIPTION("Toshiba TC358746 Parallel to CSI-2 bridge driver");
> > > +MODULE_AUTHOR("Marco Felsch <kernel@pengutronix.de>");
> > > +MODULE_LICENSE("GPL");

-- 
Regards,

Laurent Pinchart
