Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD77147BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjE2KIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjE2KIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:08:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0945AB5;
        Mon, 29 May 2023 03:08:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso4035734a12.2;
        Mon, 29 May 2023 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685354925; x=1687946925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z9OdJ38rLFc0LIoh1dJNLAxFJEm0V5ziHvYVDbhzooo=;
        b=bYyXamQhpm5+3gUrLgOr5pq1WkswZswy8k4UUHHZQoxUVvvBvjLa+8cFXVhZ4EspVk
         RMcBQUdrs1/MwVZoUto/8L9MLwXXjZbqF8PURziK7h69FRb/2ubkvNV+io0u/vz6m/Bo
         nb5PNTXqx+kL45JvCOZN8q1Umvad5tTXzJZdK2xF54tme6PRpSCjFpH3go3qVNlUo1OT
         xRyKXS/mJcC8KcsZ4lLq+pf6IEwHGJwcd4Mm9HESgjDzDeg5FMUSU6GKY22mGRMUdCOO
         fbPoOdG1ZL5YDNing299bf2a9EflSC9Ax5iYQLOpa2+H368sswUxhrO5Mh41lwyhGLJi
         asZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685354925; x=1687946925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9OdJ38rLFc0LIoh1dJNLAxFJEm0V5ziHvYVDbhzooo=;
        b=N6HBy3ngaogWB6UzVj035TNzJMXF2eMonSBF09UgTlzu8RPbeJBRFQtVvft40sqU5E
         KKE06aTBf/w9V5IMYz2ZjLTw3iZVb8oTYAc7NEsKFQHga4jxwdXP6vAEzqV9KZ4lhI3S
         aTD204AClzWhqLOwefNNSVn8ueScsTLoiKX62cpPl194SPPk6TJANQ8o5MIwP2KApVn2
         yGDIbkpIEpPRrePn3ffdGUZ6dnwmJbIPWaEQafRF3a2+L/jaF0/6GdUwHYaShDFwivFc
         AA9Ave03DAbuXYP8FqFYl/bwnHxkgew0zsAO1W6hnhqV8G+iH2HOhS75KtO+watJz3fJ
         3prQ==
X-Gm-Message-State: AC+VfDwsN8lho4y+eZzvzJE2tt+DAL60J+70qqsNvLLw881KF4m4gDts
        Ee+Lnx3zy70QeLClKn1SLo0=
X-Google-Smtp-Source: ACHHUZ5MaZFpO1HPbhAmfc3KvmbVwUqOf1/lCyqSky202DJdD6qHbh3Y/f1h5lNcZWWGv3ES/1gAvA==
X-Received: by 2002:a17:906:478f:b0:94f:322d:909d with SMTP id cw15-20020a170906478f00b0094f322d909dmr12182210ejc.63.1685354925227;
        Mon, 29 May 2023 03:08:45 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7da45000000b005148e981bd3sm2702381eds.12.2023.05.29.03.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:08:44 -0700 (PDT)
Date:   Mon, 29 May 2023 12:08:42 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
Subject: Re: [PATCH v2 2/2] media: i2c: Add support for alvium camera
Message-ID: <ZHR5qup6412nLgzz@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-3-tomm.merciai@gmail.com>
 <8563d09d-fa63-43e3-98a9-8008d53034aa@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8563d09d-fa63-43e3-98a9-8008d53034aa@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,
Thanks for the review.

On Fri, May 26, 2023 at 08:39:44PM +0200, Christophe JAILLET wrote:
> Le 26/05/2023 à 19:39, Tommaso Merciai a écrit :
> > The Alvium camera is shipped with sensor + isp in the same housing.
> > The camera can be equipped with one out of various sensor and abstract
> > the user from this. Camera is connected via MIPI CSI-2.
> > 
> > Most of the sensor's features are supported, with the main exception
> > being fw update.
> > 
> > The driver provides all mandatory, optional and recommended V4L2 controls
> > for maximum compatibility with libcamera
> > 
> > References:
> >   - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> 
> Hi,
> 
> a few nit below, should it help.
> 
> 
> > +static int alvium_setup_mipi_fmt(struct alvium_dev *alvium)
> > +{
> > +	int sz = 0;
> > +	int fmt = 0;
> 
> No need to init.
> If the loop index was just 'i', the code below would be slighly less
> verbose.
> 
> > +	int avail_fmt_cnt = 0;
> > +
> > +	alvium->alvium_csi2_fmt = NULL;
> > +
> > +	/* calculate fmt array size */
> > +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> > +		if (alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit]) {
> > +			if (!alvium_csi2_fmts[fmt].is_raw) {
> > +				sz++;
> > +			} else if (alvium_csi2_fmts[fmt].is_raw &&
> > +			      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
> 
> It is makes sense, this if/else looks equivalent to:
> 
> 			if (!alvium_csi2_fmts[fmt].is_raw ||
> 			    alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
> 				sz++;
> 
> The same simplification could also be applied in the for loop below.

I Don't agree on this.
This is not a semplification.
This change the logic of the statement.

Also initialization of sz and avail_fmt_cnt is needed.
Maybe I can include fmt variable initialization into the for loop:

for (int fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {

But from my perspective this seems clear.

> 
> > +				sz++;
> > +			}
> > +		}
> > +	}
> > +
> > +	/* init alvium_csi2_fmt array */
> > +	alvium->alvium_csi2_fmt_n = sz;
> > +	alvium->alvium_csi2_fmt = kmalloc((
> > +						     sizeof(struct alvium_pixfmt) * sz),
> > +						     GFP_KERNEL);
> 
> kmalloc_array()?
> Also some unneeded ( and )

Thanks for this tip.

> 
> > +
> > +	/* Create the alvium_csi2 fmt array from formats available */
> > +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> > +		if (alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit]) {
> > +			if (!alvium_csi2_fmts[fmt].is_raw) {
> > +				alvium->alvium_csi2_fmt[avail_fmt_cnt] =
> > +					alvium_csi2_fmts[fmt];
> > +				avail_fmt_cnt++;
> > +			} else if (alvium_csi2_fmts[fmt].is_raw &&
> > +			      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
> > +				alvium->alvium_csi2_fmt[avail_fmt_cnt] =
> > +					alvium_csi2_fmts[fmt];
> > +				avail_fmt_cnt++;
> > +			}
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> [...]
> 
> > +struct alvium_mode {
> > +	struct v4l2_rect crop;
> > +	struct v4l2_mbus_framefmt fmt;
> > +	u32 width;
> > +	u32 height;
> > +
> 
> Useless NL.

Right, thanks.

> 
> > +};
> > +
> > +struct alvium_pixfmt {
> > +	u8 id;
> > +	u32 code;
> > +	u32 colorspace;
> > +	u8 fmt_av_bit;
> > +	u8 bay_av_bit;
> > +	u64 mipi_fmt_regval;
> > +	u64 bay_fmt_regval;
> > +	u8 is_raw;
> 
> If moved a few lines above, there would be less holes in the struct.

?

> 
> > +};
> > +
> 
> [...]
> 
> > +struct alvium_dev {
> > +	struct i2c_client *i2c_client;
> > +	struct v4l2_subdev sd;
> > +	struct v4l2_fwnode_endpoint ep;
> > +	struct media_pad pad;
> > +
> > +	struct mutex lock;
> > +
> > +	struct gpio_desc *reset_gpio;
> > +	struct gpio_desc *pwdn_gpio;
> > +
> > +	u16 bcrm_addr;
> > +	alvium_bcrm_vers_t bcrm_v;
> > +	alvium_fw_vers_t fw_v;
> > +
> > +	alvium_avail_feat_t avail_ft;
> > +	u8 is_mipi_fmt_avail[ALVIUM_NUM_SUPP_MIPI_DATA_BIT];
> > +	u8 is_bay_avail[ALVIUM_NUM_BAY_AV_BIT];
> > +
> > +	u32 min_csi_clk;
> > +	u32 max_csi_clk;
> > +	u32 img_min_width;
> > +	u32 img_max_width;
> > +	u32 img_inc_width;
> > +	u32 img_min_height;
> > +	u32 img_max_height;
> > +	u32 img_inc_height;
> > +	u32 min_offx;
> > +	u32 max_offx;
> > +	u32 inc_offx;
> > +	u32 min_offy;
> > +	u32 max_offy;
> > +	u32 inc_offy;
> > +	u64 min_gain;
> > +	u64 max_gain;
> > +	u64 inc_gain;
> > +	u64 min_exp;
> > +	u64 max_exp;
> > +	u64 inc_exp;
> > +	u64 min_rbalance;
> > +	u64 max_rbalance;
> > +	u64 inc_rbalance;
> > +	u64 min_bbalance;
> > +	u64 max_bbalance;
> > +	u64 inc_bbalance;
> > +	s32 min_hue;
> > +	s32 max_hue;
> > +	s32 inc_hue;
> > +	u32 min_contrast;
> > +	u32 max_contrast;
> > +	u32 inc_contrast;
> > +	u32 min_sat;
> > +	u32 max_sat;
> > +	u32 inc_sat;
> > +	s32 min_black_lvl;
> > +	s32 max_black_lvl;
> > +	s32 inc_black_lvl;
> > +	u64 min_gamma;
> > +	u64 max_gamma;
> > +	u64 inc_gamma;
> > +	s32 min_sharp;
> > +	s32 max_sharp;
> > +	s32 inc_sharp;
> > +
> > +	u32 streamon_delay;
> > +
> > +	struct alvium_mode mode;
> > +	struct v4l2_fract frame_interval;
> > +	u64 min_fr;
> > +	u64 max_fr;
> > +	u64 fr;
> > +
> > +	u8 h_sup_csi_lanes;
> > +	struct clk *xclk;
> > +	u32 xclk_freq;
> > +	u32 csi_clk;
> > +	u64 link_freq;
> > +
> > +	struct alvium_ctrls ctrls;
> > +
> > +	u8 bcrm_mode;
> > +	u8 hshake_bit;
> 
> What is the need of keeping this value in the struct?
> Its usage seems to be only local to some function (read from HW, then used)
> 
> Should it be kept, does it make sense to have it a u8:1 and maybe some !! in
> the code, to pack it with the bitfield just a few lines below.

I don't agree on this.
Those variable are not used only locally.
Also v4l2 ctrls use those variables.
We need to keep into the priv struct of the driver.

> 
> 
> > +
> > +	struct alvium_pixfmt *alvium_csi2_fmt;
> > +	u8 alvium_csi2_fmt_n;
> > +	struct v4l2_mbus_framefmt fmt;
> > +
> > +	u8 streaming:1;
> > +	u8 apply_fiv:1;
> > +
> > +	bool upside_down;
> 
> This looks only written. Is it useles or here for future use?
> Can these fields be all u8:1, or bool:1 ?

Rotation is not used.
I will drop this in v3. Thanks!

Regards,
Tommaso

> 
> CJ
> 
> > +};
> > +
> > +static inline struct alvium_dev *sd_to_alvium(struct v4l2_subdev *sd)
> > +{
> > +	return container_of(sd, struct alvium_dev, sd);
> > +}
> > +
> > +static inline struct alvium_dev *i2c_to_alvium(struct i2c_client *client)
> > +{
> > +	return sd_to_alvium(i2c_get_clientdata(client));
> > +}
> > +
> > +static inline bool alvium_is_csi2(const struct alvium_dev *alvium)
> > +{
> > +	return alvium->ep.bus_type == V4L2_MBUS_CSI2_DPHY;
> > +}
> > +
> > +static inline struct v4l2_subdev *ctrl_to_sd(struct v4l2_ctrl *ctrl)
> > +{
> > +	return &container_of(ctrl->handler, struct alvium_dev,
> > +					  ctrls.handler)->sd;
> > +}
> > +#endif /* ALVIUM_H_ */
> 
