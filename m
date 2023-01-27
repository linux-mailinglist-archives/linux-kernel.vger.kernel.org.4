Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5608A67ECBD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjA0RuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjA0RuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:50:10 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47799222F8;
        Fri, 27 Jan 2023 09:50:09 -0800 (PST)
Received: from ideasonboard.com (host-212-171-97-20.retail.telecomitalia.it [212.171.97.20])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 00FFE2B3;
        Fri, 27 Jan 2023 18:50:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674841807;
        bh=v7G07t5L08i5boBm0RLnOVqjSaVBg3gd6Vet3cm421A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OicZoMW3ofW8PgV1RjsoL1hCWsuCh2zOT+9wxZjefNRVdYAYWHDff9gYiGDWkJ8pw
         D5YDZvfVDhUAZx2q41uEDY2/EPdRL2Bk3lGOpaail7uLu/4XNYFy5TV9qCfwbOawX9
         1FwXowKjk7GEvbgxpZaJWl453d2ZOdQWe+oo54mQ=
Date:   Fri, 27 Jan 2023 18:50:03 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-media@vger.kernel.org, kernel@pengutronix.de,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <20230127175003.6ofmfaqovbqu54hg@uno.localdomain>
References: <20230127151245.46732-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230127151245.46732-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel

On Fri, Jan 27, 2023 at 04:12:44PM +0100, Marcel Ziswiler wrote:
> From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
>
> Implement the introduced get_mbus_config operation to report the
> number of used data lanes on the MIPI CSI-2 interface.
>

OV5640 can operate in parallel mode too.

You can check how it currently configured with ov5640_is_csi2() and
populate struct v4l2_mbus_config accordingly.

Thanks
   j

> Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> ---
>
>  drivers/media/i2c/ov5640.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index e0f908af581b..42d43f0d1e1c 100644
> --- a/drivers/media/i2c/ov5640.c
> +++ b/drivers/media/i2c/ov5640.c
> @@ -3733,6 +3733,19 @@ static int ov5640_init_cfg(struct v4l2_subdev *sd,
>  	return 0;
>  }
>
> +static int ov5640_get_mbus_config(struct v4l2_subdev *sd,
> +				   unsigned int pad,
> +				   struct v4l2_mbus_config *cfg)
> +{
> +	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> +
> +	cfg->type = V4L2_MBUS_CSI2_DPHY;
> +	cfg->bus.mipi_csi2.num_data_lanes = sensor->ep.bus.mipi_csi2.num_data_lanes;
> +	cfg->bus.mipi_csi2.flags = 0;
> +
> +	return 0;
> +}
> +
>  static const struct v4l2_subdev_core_ops ov5640_core_ops = {
>  	.log_status = v4l2_ctrl_subdev_log_status,
>  	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
> @@ -3753,6 +3766,7 @@ static const struct v4l2_subdev_pad_ops ov5640_pad_ops = {
>  	.get_selection = ov5640_get_selection,
>  	.enum_frame_size = ov5640_enum_frame_size,
>  	.enum_frame_interval = ov5640_enum_frame_interval,
> +	.get_mbus_config = ov5640_get_mbus_config,
>  };
>
>  static const struct v4l2_subdev_ops ov5640_subdev_ops = {
> --
> 2.36.1
>
