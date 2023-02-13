Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56B069507D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjBMTSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBMTSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:18:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E758BBBE;
        Mon, 13 Feb 2023 11:18:22 -0800 (PST)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 59AAC3D7;
        Mon, 13 Feb 2023 20:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1676315900;
        bh=dbjHgNMknKX80WENjtASVp6a811uvB8JzulOZIQPrTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HH1UC49FCnm3OTyLWUkT0L1GtKV/xGj2mLw8mELuuuEzioSDjtNGwaBA7CDRVKpgD
         a4PYyMNUjPXojwZovDv8qdDFeucFA8Z6jaYI3MHGNLIWBs8fB+zw6eirJI/uQ3boJ3
         nSD17118/hFdYs3kVruHwE0FCRThvKDaPSH6gtEA=
Date:   Mon, 13 Feb 2023 20:18:17 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: i2c: ov5670: Support single-lane operation
Message-ID: <20230213175958.ytisoa4lf2vy2x5g@uno.localdomain>
References: <20230210-ov5670-single-lane-v1-0-71835d39c1ce@z3ntu.xyz>
 <20230210-ov5670-single-lane-v1-2-71835d39c1ce@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230210-ov5670-single-lane-v1-2-71835d39c1ce@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca

On Fri, Feb 10, 2023 at 09:33:18PM +0100, Luca Weiss wrote:
> Currently the driver always configures the sensor for dual-lane MIPI
> output, but it also supports single-lane output. Add support for that by
> checking the data-lanes fwnode property how many lanes are used and
> configure the necessary registers based on that.
>
> To achieve this we move setting register 0x3018 out of the general reg
> sequence so we set it to the correct value. The pixel_rate value also
> needs to be adjusted.

This is not necessary right now as the driver supports a single pixel
rate, but I think it prepares for adding more frequencies, so good to
have it here!

>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/media/i2c/ov5670.c | 85 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 70 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5670.c b/drivers/media/i2c/ov5670.c
> index 189920571df2..4ca082455c46 100644
> --- a/drivers/media/i2c/ov5670.c
> +++ b/drivers/media/i2c/ov5670.c
> @@ -29,6 +29,12 @@
>  #define OV5670_REG_SOFTWARE_RST		0x0103
>  #define OV5670_SOFTWARE_RST		0x01
>
> +#define OV5670_MIPI_SC_CTRL0_REG		0x3018
> +#define OV5670_MIPI_SC_CTRL0_LANES(v)		((((v) - 1) << 5) & \
> +						 GENMASK(7, 5))
> +#define OV5670_MIPI_SC_CTRL0_MIPI_EN		BIT(4)
> +#define OV5670_MIPI_SC_CTRL0_RESERVED		BIT(1)
> +
>  /* vertical-timings from sensor */
>  #define OV5670_REG_VTS			0x380e
>  #define OV5670_VTS_30FPS		0x0808 /* default for 30 fps */
> @@ -92,7 +98,6 @@ struct ov5670_reg_list {
>  };
>
>  struct ov5670_link_freq_config {
> -	u32 pixel_rate;
>  	const struct ov5670_reg_list reg_list;
>  };
>
> @@ -163,7 +168,6 @@ static const struct ov5670_reg mode_2592x1944_regs[] = {
>  	{0x3005, 0xf0},
>  	{0x3007, 0x00},
>  	{0x3015, 0x0f},
> -	{0x3018, 0x32},
>  	{0x301a, 0xf0},
>  	{0x301b, 0xf0},
>  	{0x301c, 0xf0},
> @@ -429,7 +433,6 @@ static const struct ov5670_reg mode_1296x972_regs[] = {
>  	{0x3005, 0xf0},
>  	{0x3007, 0x00},
>  	{0x3015, 0x0f},
> -	{0x3018, 0x32},
>  	{0x301a, 0xf0},
>  	{0x301b, 0xf0},
>  	{0x301c, 0xf0},
> @@ -695,7 +698,6 @@ static const struct ov5670_reg mode_648x486_regs[] = {
>  	{0x3005, 0xf0},
>  	{0x3007, 0x00},
>  	{0x3015, 0x0f},
> -	{0x3018, 0x32},
>  	{0x301a, 0xf0},
>  	{0x301b, 0xf0},
>  	{0x301c, 0xf0},
> @@ -961,7 +963,6 @@ static const struct ov5670_reg mode_2560x1440_regs[] = {
>  	{0x3005, 0xf0},
>  	{0x3007, 0x00},
>  	{0x3015, 0x0f},
> -	{0x3018, 0x32},
>  	{0x301a, 0xf0},
>  	{0x301b, 0xf0},
>  	{0x301c, 0xf0},
> @@ -1226,7 +1227,6 @@ static const struct ov5670_reg mode_1280x720_regs[] = {
>  	{0x3005, 0xf0},
>  	{0x3007, 0x00},
>  	{0x3015, 0x0f},
> -	{0x3018, 0x32},
>  	{0x301a, 0xf0},
>  	{0x301b, 0xf0},
>  	{0x301c, 0xf0},
> @@ -1492,7 +1492,6 @@ static const struct ov5670_reg mode_640x360_regs[] = {
>  	{0x3005, 0xf0},
>  	{0x3007, 0x00},
>  	{0x3015, 0x0f},
> -	{0x3018, 0x32},
>  	{0x301a, 0xf0},
>  	{0x301b, 0xf0},
>  	{0x301c, 0xf0},
> @@ -1762,8 +1761,6 @@ static const char * const ov5670_test_pattern_menu[] = {
>  #define OV5670_LINK_FREQ_422MHZ_INDEX	0
>  static const struct ov5670_link_freq_config link_freq_configs[] = {
>  	{
> -		/* pixel_rate = link_freq * 2 * nr_of_lanes / bits_per_sample */
> -		.pixel_rate = (OV5670_LINK_FREQ_422MHZ * 2 * 2) / 10,
>  		.reg_list = {
>  			.num_of_regs = ARRAY_SIZE(mipi_data_rate_840mbps),
>  			.regs = mipi_data_rate_840mbps,
> @@ -1859,6 +1856,7 @@ static const struct ov5670_mode supported_modes[] = {
>  struct ov5670 {
>  	struct v4l2_subdev sd;
>  	struct media_pad pad;
> +	struct v4l2_fwnode_endpoint endpoint;
>
>  	struct v4l2_ctrl_handler ctrl_handler;
>  	/* V4L2 Controls */
> @@ -2101,9 +2099,13 @@ static const struct v4l2_ctrl_ops ov5670_ctrl_ops = {
>  /* Initialize control handlers */
>  static int ov5670_init_controls(struct ov5670 *ov5670)
>  {
> +	struct v4l2_mbus_config_mipi_csi2 *bus_mipi_csi2 =
> +		&ov5670->endpoint.bus.mipi_csi2;
>  	struct i2c_client *client = v4l2_get_subdevdata(&ov5670->sd);
>  	struct v4l2_fwnode_device_properties props;
>  	struct v4l2_ctrl_handler *ctrl_hdlr;
> +	unsigned int lanes_count;
> +	s64 mipi_pixel_rate;
>  	s64 vblank_max;
>  	s64 vblank_def;
>  	s64 vblank_min;
> @@ -2124,12 +2126,15 @@ static int ov5670_init_controls(struct ov5670 *ov5670)
>  		ov5670->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>
>  	/* By default, V4L2_CID_PIXEL_RATE is read only */
> +	lanes_count = bus_mipi_csi2->num_data_lanes;
> +	mipi_pixel_rate = OV5670_LINK_FREQ_422MHZ * 2 * lanes_count / 10;
> +
>  	ov5670->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &ov5670_ctrl_ops,
>  					       V4L2_CID_PIXEL_RATE,
> -					       link_freq_configs[0].pixel_rate,
> -					       link_freq_configs[0].pixel_rate,
> +					       mipi_pixel_rate,
> +					       mipi_pixel_rate,
>  					       1,
> -					       link_freq_configs[0].pixel_rate);
> +					       mipi_pixel_rate);
>
>  	vblank_max = OV5670_VTS_MAX - ov5670->cur_mode->height;
>  	vblank_def = ov5670->cur_mode->vts_def - ov5670->cur_mode->height;
> @@ -2288,8 +2293,13 @@ static int ov5670_set_pad_format(struct v4l2_subdev *sd,
>  				 struct v4l2_subdev_format *fmt)
>  {
>  	struct ov5670 *ov5670 = to_ov5670(sd);
> +	struct v4l2_mbus_config_mipi_csi2 *bus_mipi_csi2 =
> +		&ov5670->endpoint.bus.mipi_csi2;
>  	const struct ov5670_mode *mode;
> +	unsigned int lanes_count;
> +	s64 mipi_pixel_rate;
>  	s32 vblank_def;
> +	s64 link_freq;
>  	s32 h_blank;
>
>  	mutex_lock(&ov5670->mutex);
> @@ -2306,9 +2316,14 @@ static int ov5670_set_pad_format(struct v4l2_subdev *sd,
>  	} else {
>  		ov5670->cur_mode = mode;
>  		__v4l2_ctrl_s_ctrl(ov5670->link_freq, mode->link_freq_index);
> +
> +		lanes_count = bus_mipi_csi2->num_data_lanes;
> +		link_freq = link_freq_menu_items[mode->link_freq_index];
> +		/* pixel_rate = link_freq * 2 * nr_of_lanes / bits_per_sample */
> +		mipi_pixel_rate = link_freq * 2 * lanes_count / 10;
>  		__v4l2_ctrl_s_ctrl_int64(
>  			ov5670->pixel_rate,
> -			link_freq_configs[mode->link_freq_index].pixel_rate);
> +			mipi_pixel_rate);
>  		/* Update limits and set FPS to default */
>  		vblank_def = ov5670->cur_mode->vts_def -
>  			     ov5670->cur_mode->height;
> @@ -2361,6 +2376,19 @@ static int ov5670_identify_module(struct ov5670 *ov5670)
>  	return 0;
>  }
>
> +static int ov5670_mipi_configure(struct ov5670 *ov5670)
> +{
> +	struct v4l2_mbus_config_mipi_csi2 *bus_mipi_csi2 =
> +		&ov5670->endpoint.bus.mipi_csi2;
> +	unsigned int lanes_count = bus_mipi_csi2->num_data_lanes;
> +
> +	return ov5670_write_reg(ov5670, OV5670_MIPI_SC_CTRL0_REG,
> +				OV5670_REG_VALUE_08BIT,
> +				OV5670_MIPI_SC_CTRL0_LANES(lanes_count) |
> +				OV5670_MIPI_SC_CTRL0_MIPI_EN |
> +				OV5670_MIPI_SC_CTRL0_RESERVED);
> +}
> +
>  /* Prepare streaming by writing default values and customized values */
>  static int ov5670_start_streaming(struct ov5670 *ov5670)
>  {
> @@ -2399,6 +2427,12 @@ static int ov5670_start_streaming(struct ov5670 *ov5670)
>  		return ret;
>  	}
>
> +	ret = ov5670_mipi_configure(ov5670);
> +	if (ret) {
> +		dev_err(&client->dev, "%s failed to configure MIPI\n", __func__);
> +		return ret;
> +	}
> +
>  	ret = __v4l2_ctrl_handler_setup(ov5670->sd.ctrl_handler);
>  	if (ret)
>  		return ret;
> @@ -2647,6 +2681,7 @@ static int ov5670_gpio_probe(struct ov5670 *ov5670)
>
>  static int ov5670_probe(struct i2c_client *client)
>  {
> +	struct fwnode_handle *handle;
>  	struct ov5670 *ov5670;
>  	u32 input_clk = 0;
>  	bool full_power;
> @@ -2683,11 +2718,26 @@ static int ov5670_probe(struct i2c_client *client)
>  	if (ret)
>  		return dev_err_probe(&client->dev, ret, "GPIO probe failed\n");
>
> +	/* Graph Endpoint */
> +	handle = fwnode_graph_get_next_endpoint(dev_fwnode(&client->dev), NULL);
> +	if (!handle)
> +		return dev_err_probe(&client->dev, -ENXIO, "Endpoint for node get failed\n");

As commented on the previous patch, I don't think parsing the endpoint
can return -EPROBE_DEFER

> +
> +	ov5670->endpoint.bus_type = V4L2_MBUS_CSI2_DPHY;
> +	ov5670->endpoint.bus.mipi_csi2.num_data_lanes = 2;
> +
> +	ret = v4l2_fwnode_endpoint_alloc_parse(handle, &ov5670->endpoint);
> +	fwnode_handle_put(handle);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Endpoint parse failed\n");
> +

ditto

>  	full_power = acpi_dev_state_d0(&client->dev);
>  	if (full_power) {
>  		ret = ov5670_runtime_resume(&client->dev);
> -		if (ret)
> -			return dev_err_probe(&client->dev, ret, "Power up failed\n");
> +		if (ret) {
> +			dev_err_probe(&client->dev, ret, "Power up failed\n");
> +			goto error_endpoint;
> +		}
>
>  		/* Check module identity */
>  		ret = ov5670_identify_module(ov5670);
> @@ -2754,6 +2804,9 @@ static int ov5670_probe(struct i2c_client *client)
>  	if (full_power)
>  		ov5670_runtime_suspend(&client->dev);
>
> +error_endpoint:
> +	v4l2_fwnode_endpoint_free(&ov5670->endpoint);
> +
>  	return ret;
>  }
>
> @@ -2769,6 +2822,8 @@ static void ov5670_remove(struct i2c_client *client)
>
>  	pm_runtime_disable(&client->dev);
>  	ov5670_runtime_suspend(&client->dev);
> +
> +	v4l2_fwnode_endpoint_free(&ov5670->endpoint);

Nits apart
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

>  }
>
>  static const struct dev_pm_ops ov5670_pm_ops = {
>
> --
> 2.39.1
>
