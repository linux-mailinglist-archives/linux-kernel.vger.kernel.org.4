Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73A360E64B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJZRSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJZRSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:18:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E28844EA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:18:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1onk1s-0003AO-MF; Wed, 26 Oct 2022 19:17:24 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1onk1p-0005PJ-NT; Wed, 26 Oct 2022 19:17:21 +0200
Date:   Wed, 26 Oct 2022 19:17:21 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>, devicetree@vger.kernel.org,
        Jacopo Mondi <jacopo@jmondi.org>, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 8/9] media: i2c: ov5645: Don't return early on
 failures for s_stream(0)
Message-ID: <20221026171721.4nfvhamguwnrw6zf@pengutronix.de>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026130658.45601-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026130658.45601-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

thanks for the patch, please see below my comments.

On 22-10-26, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Make sure we dont stop the code flow in case of errors while stopping
> the stream and return the error code of the first error case if any.
> 
> v4l2-core takes care of warning the user so no need to add a warning
> message in the driver.
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> * Now propagating the first error code in case of failure.
> 
> v1->v2
> * New patch
> ---
>  drivers/media/i2c/ov5645.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index eea3067ddc8b..5702a55607fc 100644
> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -996,17 +996,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
>  		if (ret < 0)
>  			goto err_rpm_put;
>  	} else {
> +		int stream_off_ret = 0;
> +
>  		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);

If this write failed..

>  		if (ret < 0)
> -			return ret;
> +			stream_off_ret = ret;
>  
>  		ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
>  				       OV5645_SYSTEM_CTRL0_STOP);

why should this write be successful?

Regards,
  Marco

> -		if (ret < 0)
> -			return ret;
> +		if (ret < 0 && !stream_off_ret)
> +			stream_off_ret = ret;
>  
>  		pm_runtime_mark_last_busy(ov5645->dev);
>  		pm_runtime_put_autosuspend(ov5645->dev);
> +
> +		if (stream_off_ret)
> +			return stream_off_ret;
>  	}
>  
>  	return 0;
> -- 
> 2.25.1
> 
> 
> 
