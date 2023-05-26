Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39831712CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjEZSko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbjEZSkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:40:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA2E6E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:40:08 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2cLoqaT1Flhpt2cLoqbSL7; Fri, 26 May 2023 20:39:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685126389;
        bh=TKNTKEUqbXyYA3X3GQmzl5PGmEb8NbeBHIgFAeXj1qU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SHBP2voazNgw1eWsgphdh9A1sEa/c1Li99l30L9gEv8HOw6qAqGmhIXiNw2SgTcD+
         eE7Tycm//oqvvh9Dzit1Q+th9nmN+ROT5hWiClT3di/4g/I3uwqsyjcKY2tVQcNwP7
         IvM9n+Bbfo0PNgjytPGu2Qa2PK3F0j6GyDMAH+wnA3j90Ay/9HF67nLRwGpe3dKDsu
         6T/HnbLLUUkbhepbS//IZkNTrCE0MNUwW+DYfihFHISZd025wqfExk7guc5UrXb6uA
         yMMsmqmxqzS2a2ghCpOBz7mgDxtD7UfpC/+30O5t+G37BdqZSYW5VWXd0iC4KArLHN
         A5F22OhkHXQzQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 26 May 2023 20:39:49 +0200
X-ME-IP: 86.243.2.178
Message-ID: <8563d09d-fa63-43e3-98a9-8008d53034aa@wanadoo.fr>
Date:   Fri, 26 May 2023 20:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] media: i2c: Add support for alvium camera
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-3-tomm.merciai@gmail.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230526173955.797226-3-tomm.merciai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/05/2023 à 19:39, Tommaso Merciai a écrit :
> The Alvium camera is shipped with sensor + isp in the same housing.
> The camera can be equipped with one out of various sensor and abstract
> the user from this. Camera is connected via MIPI CSI-2.
> 
> Most of the sensor's features are supported, with the main exception
> being fw update.
> 
> The driver provides all mandatory, optional and recommended V4L2 controls
> for maximum compatibility with libcamera
> 
> References:
>   - https://www.alliedvision.com/en/products/embedded-vision-solutions
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---

Hi,

a few nit below, should it help.


> +static int alvium_setup_mipi_fmt(struct alvium_dev *alvium)
> +{
> +	int sz = 0;
> +	int fmt = 0;

No need to init.
If the loop index was just 'i', the code below would be slighly less 
verbose.

> +	int avail_fmt_cnt = 0;
> +
> +	alvium->alvium_csi2_fmt = NULL;
> +
> +	/* calculate fmt array size */
> +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> +		if (alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit]) {
> +			if (!alvium_csi2_fmts[fmt].is_raw) {
> +				sz++;
> +			} else if (alvium_csi2_fmts[fmt].is_raw &&
> +			      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {

It is makes sense, this if/else looks equivalent to:

			if (!alvium_csi2_fmts[fmt].is_raw ||
			    alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
				sz++;

The same simplification could also be applied in the for loop below.

> +				sz++;
> +			}
> +		}
> +	}
> +
> +	/* init alvium_csi2_fmt array */
> +	alvium->alvium_csi2_fmt_n = sz;
> +	alvium->alvium_csi2_fmt = kmalloc((
> +						     sizeof(struct alvium_pixfmt) * sz),
> +						     GFP_KERNEL);

kmalloc_array()?
Also some unneeded ( and )

> +
> +	/* Create the alvium_csi2 fmt array from formats available */
> +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> +		if (alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit]) {
> +			if (!alvium_csi2_fmts[fmt].is_raw) {
> +				alvium->alvium_csi2_fmt[avail_fmt_cnt] =
> +					alvium_csi2_fmts[fmt];
> +				avail_fmt_cnt++;
> +			} else if (alvium_csi2_fmts[fmt].is_raw &&
> +			      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
> +				alvium->alvium_csi2_fmt[avail_fmt_cnt] =
> +					alvium_csi2_fmts[fmt];
> +				avail_fmt_cnt++;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

[...]

> +struct alvium_mode {
> +	struct v4l2_rect crop;
> +	struct v4l2_mbus_framefmt fmt;
> +	u32 width;
> +	u32 height;
> +

Useless NL.

> +};
> +
> +struct alvium_pixfmt {
> +	u8 id;
> +	u32 code;
> +	u32 colorspace;
> +	u8 fmt_av_bit;
> +	u8 bay_av_bit;
> +	u64 mipi_fmt_regval;
> +	u64 bay_fmt_regval;
> +	u8 is_raw;

If moved a few lines above, there would be less holes in the struct.

> +};
> +

[...]

> +struct alvium_dev {
> +	struct i2c_client *i2c_client;
> +	struct v4l2_subdev sd;
> +	struct v4l2_fwnode_endpoint ep;
> +	struct media_pad pad;
> +
> +	struct mutex lock;
> +
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *pwdn_gpio;
> +
> +	u16 bcrm_addr;
> +	alvium_bcrm_vers_t bcrm_v;
> +	alvium_fw_vers_t fw_v;
> +
> +	alvium_avail_feat_t avail_ft;
> +	u8 is_mipi_fmt_avail[ALVIUM_NUM_SUPP_MIPI_DATA_BIT];
> +	u8 is_bay_avail[ALVIUM_NUM_BAY_AV_BIT];
> +
> +	u32 min_csi_clk;
> +	u32 max_csi_clk;
> +	u32 img_min_width;
> +	u32 img_max_width;
> +	u32 img_inc_width;
> +	u32 img_min_height;
> +	u32 img_max_height;
> +	u32 img_inc_height;
> +	u32 min_offx;
> +	u32 max_offx;
> +	u32 inc_offx;
> +	u32 min_offy;
> +	u32 max_offy;
> +	u32 inc_offy;
> +	u64 min_gain;
> +	u64 max_gain;
> +	u64 inc_gain;
> +	u64 min_exp;
> +	u64 max_exp;
> +	u64 inc_exp;
> +	u64 min_rbalance;
> +	u64 max_rbalance;
> +	u64 inc_rbalance;
> +	u64 min_bbalance;
> +	u64 max_bbalance;
> +	u64 inc_bbalance;
> +	s32 min_hue;
> +	s32 max_hue;
> +	s32 inc_hue;
> +	u32 min_contrast;
> +	u32 max_contrast;
> +	u32 inc_contrast;
> +	u32 min_sat;
> +	u32 max_sat;
> +	u32 inc_sat;
> +	s32 min_black_lvl;
> +	s32 max_black_lvl;
> +	s32 inc_black_lvl;
> +	u64 min_gamma;
> +	u64 max_gamma;
> +	u64 inc_gamma;
> +	s32 min_sharp;
> +	s32 max_sharp;
> +	s32 inc_sharp;
> +
> +	u32 streamon_delay;
> +
> +	struct alvium_mode mode;
> +	struct v4l2_fract frame_interval;
> +	u64 min_fr;
> +	u64 max_fr;
> +	u64 fr;
> +
> +	u8 h_sup_csi_lanes;
> +	struct clk *xclk;
> +	u32 xclk_freq;
> +	u32 csi_clk;
> +	u64 link_freq;
> +
> +	struct alvium_ctrls ctrls;
> +
> +	u8 bcrm_mode;
> +	u8 hshake_bit;

What is the need of keeping this value in the struct?
Its usage seems to be only local to some function (read from HW, then used)

Should it be kept, does it make sense to have it a u8:1 and maybe some 
!! in the code, to pack it with the bitfield just a few lines below.


> +
> +	struct alvium_pixfmt *alvium_csi2_fmt;
> +	u8 alvium_csi2_fmt_n;
> +	struct v4l2_mbus_framefmt fmt;
> +
> +	u8 streaming:1;
> +	u8 apply_fiv:1;
> +
> +	bool upside_down;

This looks only written. Is it useles or here for future use?
Can these fields be all u8:1, or bool:1 ?

CJ

> +};
> +
> +static inline struct alvium_dev *sd_to_alvium(struct v4l2_subdev *sd)
> +{
> +	return container_of(sd, struct alvium_dev, sd);
> +}
> +
> +static inline struct alvium_dev *i2c_to_alvium(struct i2c_client *client)
> +{
> +	return sd_to_alvium(i2c_get_clientdata(client));
> +}
> +
> +static inline bool alvium_is_csi2(const struct alvium_dev *alvium)
> +{
> +	return alvium->ep.bus_type == V4L2_MBUS_CSI2_DPHY;
> +}
> +
> +static inline struct v4l2_subdev *ctrl_to_sd(struct v4l2_ctrl *ctrl)
> +{
> +	return &container_of(ctrl->handler, struct alvium_dev,
> +					  ctrls.handler)->sd;
> +}
> +#endif /* ALVIUM_H_ */

