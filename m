Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1621965FF4F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjAFLFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAFLE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:04:58 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828F86E0D2;
        Fri,  6 Jan 2023 03:04:57 -0800 (PST)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E4F564AE;
        Fri,  6 Jan 2023 12:04:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673003096;
        bh=GTINAZFVf6JoIW6tV+2Ycf4hQeOQsajQPsDSSlpHy7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pl2Grl17a1SKdwnA1EBF6+76g4vklyLKXet7/+z4Oc1dA5guR5TdZvfcCjwa47U30
         IZdiUH2rIaYJbpBvE9CeXeS+LhIZTnICm3fa1m5djSXg7+42FFJRSy2tcdBvK+s8ei
         GsuwxQU9MG+ajPop+9kxFCWdTQeP59kjcAXbUtYY=
Date:   Fri, 6 Jan 2023 12:04:53 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v8 4/4] media: i2c: imx334: update pixel and link
 frequency
Message-ID: <20230106110453.woy7libfwlpgbpeq@uno.localdomain>
References: <20230106072931.2317597-1-shravan.chippa@microchip.com>
 <20230106072931.2317597-5-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230106072931.2317597-5-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan

On Fri, Jan 06, 2023 at 12:59:31PM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>
> Update pixel_rate and link frequency for 1920x1080@30
> while changing mode.
>
> Add dummy ctrl cases for pixel_rate and link frequency
> to avoid error while changing the modes dynamically
>
> Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index 0315e1c9541d..8c3ba660abae 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -50,6 +50,7 @@
>
>  /* CSI2 HW configuration */
>  #define IMX334_LINK_FREQ	891000000

I guess you want to rename this one to  IMX334_LINK_FREQ_891M

Give our previous discussion this seems correct for the following mode

	{
		.width = 3840,
		.height = 2160,
		.hblank = 560,
		.vblank = 2340,
		.vblank_min = 90,
		.vblank_max = 132840,
		.pclk = 594000000,
		.link_freq_idx = 0,
		.reg_list = {
			.num_of_regs = ARRAY_SIZE(mode_3840x2160_regs),
			.regs = mode_3840x2160_regs,
		},
	}, {

        duration: (3840+560) * (2160+2340)  / 594000000 = 33sec = 30FPS
        link_freq (3840+560) * (2160+2340)  * 30 * 12 / 8 = 891000000

Which works well if we use min_vblank = 90 for 60FPS

        duration: (3840+560) * (2160+90)  / 594000000 = 0.16 = 60 FPS
        link_freq (3840+560) * (2160+90)  * 60 * 12 / 8 = 891000000


> +#define IMX334_LINK_FREQ_445M	445500000

But this doesn't work well for me

	{
		.width = 1920,
		.height = 1080,
		.hblank = 280,
		.vblank = 1170,
		.vblank_min = 90,
		.vblank_max = 132840,
		.pclk = 74250000,
		.link_freq_idx = 1,
		.reg_list = {
			.num_of_regs = ARRAY_SIZE(mode_1920x1080_regs),
			.regs = mode_1920x1080_regs,
		},
	},

        duration: (1920+280) * (1080+1170) / 74250000 = 66msec = 16FPS
        link_freq = (1920+280) * (1080+1170) * 60 * 10 / 8 = 371250000

Do you agree with the above or have I missed something ?

I understand you get 30 FPS with the 1920*1080 mode so could you
please check in the newly introduce mode register table what are the
actual values for the blankings and compute the pixel_rate and
link_freq accordingly ?

>  #define IMX334_NUM_DATA_LANES	4
>
>  #define IMX334_REG_MIN		0x00
> @@ -145,6 +146,7 @@ struct imx334 {
>
>  static const s64 link_freq[] = {
>  	IMX334_LINK_FREQ,
> +	IMX334_LINK_FREQ_445M,
>  };
>
>  /* Sensor mode registers */
> @@ -468,7 +470,7 @@ static const struct imx334_mode supported_modes[] = {
>  		.vblank_min = 90,
>  		.vblank_max = 132840,
>  		.pclk = 74250000,
> -		.link_freq_idx = 0,
> +		.link_freq_idx = 1,
>  		.reg_list = {
>  			.num_of_regs = ARRAY_SIZE(mode_1920x1080_regs),
>  			.regs = mode_1920x1080_regs,
> @@ -598,6 +600,11 @@ static int imx334_update_controls(struct imx334 *imx334,
>  	if (ret)
>  		return ret;
>
> +	ret = __v4l2_ctrl_modify_range(imx334->pclk_ctrl, mode->pclk,
> +				       mode->pclk, 1, mode->pclk);
> +	if (ret)
> +		return ret;
> +
>  	ret = __v4l2_ctrl_modify_range(imx334->hblank_ctrl, mode->hblank,
>  				       mode->hblank, 1, mode->hblank);
>  	if (ret)
> @@ -698,6 +705,8 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
>  		pm_runtime_put(imx334->dev);
>
>  		break;
> +	case V4L2_CID_PIXEL_RATE:
> +	case V4L2_CID_LINK_FREQ:
>  	case V4L2_CID_HBLANK:

Same question as for patch 1/4: Do we need these safety checks for
read-only controls ?

Thanks
  j

>  		ret = 0;
>  		break;
> --
> 2.34.1
>
