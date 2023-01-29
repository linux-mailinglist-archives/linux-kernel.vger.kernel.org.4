Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914DE67FE8A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjA2L0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjA2L0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:26:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B451E9ED;
        Sun, 29 Jan 2023 03:26:33 -0800 (PST)
Received: from ideasonboard.com (host-212-171-97-20.pool212171.interbusiness.it [212.171.97.20])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 95C22327;
        Sun, 29 Jan 2023 12:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674991591;
        bh=7+gAWNuSUUownB9Iy5YqVG3A2mVpXMNfNAiYiMY2Rs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2JZPHVQ7wR1xBfBwPRnGBu2xBmnGdfHv6+SVZ1PGoMhRwGqMD57EA3FG+imPZi4x
         aAI9Pfn4y15gU8IKsy+kwxBi3G86GArDtNxWpVZKmIiL7M4LjuGk/lXHm42YWugwEr
         H/n9zD/k/fEAUVZdYjSx70fQ1/f3XqDXfRnysY70=
Date:   Sun, 29 Jan 2023 12:26:28 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] media: i2c: ov2685: Add controls from fwnode
Message-ID: <20230129112628.rb6h4xdfwvs3hbl7@uno.localdomain>
References: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
 <20230129-ov2685-improvements-v1-3-f281bd49399c@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230129-ov2685-improvements-v1-3-f281bd49399c@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Sun, Jan 29, 2023 at 10:42:37AM +0100, Luca Weiss wrote:
> Add V4L2_CID_CAMERA_ORIENTATION and V4L2_CID_CAMERA_SENSOR_ROTATION
> controls to the ov2685 driver by attempting to parse them from firmware.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/media/i2c/ov2685.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
> index 844a91dbc8e5..bfced11b178b 100644
> --- a/drivers/media/i2c/ov2685.c
> +++ b/drivers/media/i2c/ov2685.c
> @@ -17,6 +17,7 @@
>  #include <media/media-entity.h>
>  #include <media/v4l2-async.h>
>  #include <media/v4l2-ctrls.h>
> +#include <media/v4l2-fwnode.h>
>  #include <media/v4l2-subdev.h>
>
>  #define CHIP_ID				0x2685
> @@ -613,6 +614,7 @@ static int ov2685_initialize_controls(struct ov2685 *ov2685)
>  	const struct ov2685_mode *mode;
>  	struct v4l2_ctrl_handler *handler;
>  	struct v4l2_ctrl *ctrl;
> +	struct v4l2_fwnode_device_properties props;
>  	u64 exposure_max;
>  	u32 pixel_rate, h_blank;
>  	int ret;
> @@ -661,6 +663,15 @@ static int ov2685_initialize_controls(struct ov2685 *ov2685)
>  				ARRAY_SIZE(ov2685_test_pattern_menu) - 1,
>  				0, 0, ov2685_test_pattern_menu);
>

As the below function can register up to 2 controls, you should also
reserve space for them when initializing the control handler to avoid
relocations

-       ret = v4l2_ctrl_handler_init(handler, 8);
+       ret = v4l2_ctrl_handler_init(handler, 10);


> +	/* set properties from fwnode (e.g. rotation, orientation) */
> +	ret = v4l2_fwnode_device_parse(&ov2685->client->dev, &props);
> +	if (ret)
> +		goto err_free_handler;
> +
> +	ret = v4l2_ctrl_new_fwnode_properties(handler, &ov2685_ctrl_ops, &props);
> +	if (ret)
> +		goto err_free_handler;
> +
>  	if (handler->error) {
>  		ret = handler->error;
>  		dev_err(&ov2685->client->dev,
>
> --
> 2.39.1
>
