Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491CE65D533
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbjADOMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239742AbjADOMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:12:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E0D1EEEF;
        Wed,  4 Jan 2023 06:12:05 -0800 (PST)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 855D76F0;
        Wed,  4 Jan 2023 15:12:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672841522;
        bh=msUYvAx7nht3qkWr7r2R/VeKP9ruGiKSIVIO/mml9Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaOsVC2Yn3RRXAMOBkNE7Zh3BYIS+mpWQJtUUN+Hypq2K164Zzw0pMuXN+v6qQFlB
         AsvlWWd/UZCT0ExN/PKbTKyQWSRadFxAH/CJhg8spJz64MoHYr2KH1F2ySEa0QLMeJ
         lUkrFVLRyMphz2bDgKmWCe4k5f3AMqTJ4ACWj+Xk=
Date:   Wed, 4 Jan 2023 15:11:59 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Robert Mader <robert.mader@collabora.com>
Cc:     linux-kernel@vger.kernel.org, nicholas@rothemail.net,
        javierm@redhat.com, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2] media: i2c: imx258: Parse and register properties
Message-ID: <20230104141159.e2klapbpenslxqbx@uno.localdomain>
References: <20230104122337.123055-1-robert.mader@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230104122337.123055-1-robert.mader@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert

On Wed, Jan 04, 2023 at 01:23:37PM +0100, Robert Mader wrote:
> Analogous to e.g. the imx219. This enables propagating
> V4L2_CID_CAMERA_ORIENTATION and V4L2_CID_CAMERA_SENSOR_ROTATION
> values.
> The motivation is to allow libcamera detect these values from the
> device tree and propagate them further to e.g. Pipewire.
>
> While at it, reserve space for 3 additional controls even if
> v4l2_ctrl_new_fwnode_properties() can only register 2 of
> them, to fix the existing implementation which reserve space for 8
> controls but actually registers 9.
>
> Changes in v2:
>  - Reserve 11 instead of 10 controls
>  - Change order of variable declaration
>  - Slightly extend description

This part should go below, after ---, as it shouldn't be part of the commit
message

The patch looks good

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

>
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> ---
>  drivers/media/i2c/imx258.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> index eab5fc1ee2f7..3b560865b657 100644
> --- a/drivers/media/i2c/imx258.c
> +++ b/drivers/media/i2c/imx258.c
> @@ -9,6 +9,7 @@
>  #include <linux/pm_runtime.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
> +#include <media/v4l2-fwnode.h>
>  #include <asm/unaligned.h>
>
>  #define IMX258_REG_VALUE_08BIT		1
> @@ -1148,6 +1149,7 @@ static const struct v4l2_subdev_internal_ops imx258_internal_ops = {
>  static int imx258_init_controls(struct imx258 *imx258)
>  {
>  	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
> +	struct v4l2_fwnode_device_properties props;
>  	struct v4l2_ctrl_handler *ctrl_hdlr;
>  	s64 vblank_def;
>  	s64 vblank_min;
> @@ -1156,7 +1158,7 @@ static int imx258_init_controls(struct imx258 *imx258)
>  	int ret;
>
>  	ctrl_hdlr = &imx258->ctrl_handler;
> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 8);
> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 11);
>  	if (ret)
>  		return ret;
>
> @@ -1232,6 +1234,15 @@ static int imx258_init_controls(struct imx258 *imx258)
>  		goto error;
>  	}
>
> +	ret = v4l2_fwnode_device_parse(&client->dev, &props);
> +	if (ret)
> +		goto error;
> +
> +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx258_ctrl_ops,
> +					      &props);
> +	if (ret)
> +		goto error;
> +
>  	imx258->sd.ctrl_handler = ctrl_hdlr;
>
>  	return 0;
> --
> 2.39.0
>
