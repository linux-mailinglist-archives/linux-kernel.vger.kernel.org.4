Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6565B32C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbjABOGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjABOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:06:37 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAD41A5;
        Mon,  2 Jan 2023 06:06:36 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D056610000A;
        Mon,  2 Jan 2023 14:06:32 +0000 (UTC)
Date:   Mon, 2 Jan 2023 15:06:31 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Robert Mader <robert.mader@collabora.com>
Cc:     linux-kernel@vger.kernel.org, nicholas@rothemail.net,
        javierm@redhat.com, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: imx258: Parse and register properties
Message-ID: <20230102140631.hadlh3stozecnzpj@uno.localdomain>
References: <20221225154234.378555-1-robert.mader@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221225154234.378555-1-robert.mader@collabora.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert

On Sun, Dec 25, 2022 at 04:42:34PM +0100, Robert Mader wrote:
> Analogous to e.g. the imx219. This enables propagating
> V4L2_CID_CAMERA_SENSOR_ROTATION values so that libcamera
> can detect the correct rotation from the device tree
> and propagate it further to e.g. Pipewire.
>
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> ---
>  drivers/media/i2c/imx258.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> index eab5fc1ee2f7..85819043d1e3 100644
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
> @@ -1149,6 +1150,7 @@ static int imx258_init_controls(struct imx258 *imx258)
>  {
>  	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
>  	struct v4l2_ctrl_handler *ctrl_hdlr;
> +	struct v4l2_fwnode_device_properties props;

Might be nicer to move this one line up

>  	s64 vblank_def;
>  	s64 vblank_min;
>  	s64 pixel_rate_min;
> @@ -1156,7 +1158,7 @@ static int imx258_init_controls(struct imx258 *imx258)
>  	int ret;
>
>  	ctrl_hdlr = &imx258->ctrl_handler;
> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 8);
> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);

I count 9 controls being registered before this patch, not 8. Do I
count them right ?

If that's case, as v4l2_ctrl_new_fwnode_properties()
can register up to two controls (V4L2_CID_ROTATION and
V4L2_CID_ORIENTATION) I would pre-reserve 11 controls not 10 to avoid
relocations.

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

The rest looks good to me!

Thanks
   j

>  	imx258->sd.ctrl_handler = ctrl_hdlr;
>
>  	return 0;
> --
> 2.39.0
>
