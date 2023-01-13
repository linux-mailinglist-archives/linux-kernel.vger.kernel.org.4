Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54E1669328
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbjAMJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbjAMJmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:42:25 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EC37FEF8;
        Fri, 13 Jan 2023 01:31:38 -0800 (PST)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5B58C4D4;
        Fri, 13 Jan 2023 10:31:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673602296;
        bh=as+L/QPxdqQJEWl8FxG1PpXjcsdzFj4FeCjO0Y8t9CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5Hrb4mpsI29bQcTlOdFVVbLU9otzBqVzfqtD1aFxxM1fSe5xQ7o/5Ulv0idmEUWV
         R0a8/MZk9d6BI70/6TWEPHpRcpGlFYQwS41h/AYURBLvd/LDYG/NyQQE3v+l8scdK+
         7AA458KpDFRDLIB+37QTPC09ccUINllIWD9eXaNU=
Date:   Fri, 13 Jan 2023 10:31:33 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     shravan kumar <shravan.chippa@microchip.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v9 4/4] media: i2c: imx334: update pixel and link
 frequency
Message-ID: <20230113093133.6lqbnlhqkyhzhwyd@uno.localdomain>
References: <20230113010135.2620818-1-shravan.chippa@microchip.com>
 <20230113010135.2620818-5-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230113010135.2620818-5-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan

On Fri, Jan 13, 2023 at 06:31:35AM +0530, shravan kumar wrote:
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
>  drivers/media/i2c/imx334.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index 4ab1b9eb9a64..373022fbd6b2 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -49,7 +49,8 @@
>  #define IMX334_INCLK_RATE	24000000
>
>  /* CSI2 HW configuration */
> -#define IMX334_LINK_FREQ	891000000
> +#define IMX334_LINK_FREQ_891M	891000000
> +#define IMX334_LINK_FREQ_445M	445500000

Good!

>  #define IMX334_NUM_DATA_LANES	4
>
>  #define IMX334_REG_MIN		0x00
> @@ -144,7 +145,8 @@ struct imx334 {
>  };
>
>  static const s64 link_freq[] = {
> -	IMX334_LINK_FREQ,
> +	IMX334_LINK_FREQ_891M,
> +	IMX334_LINK_FREQ_445M,
>  };
>
>  /* Sensor mode registers */
> @@ -468,7 +470,7 @@ static const struct imx334_mode supported_modes[] = {
>  		.vblank_min = 45,
>  		.vblank_max = 132840,
>  		.pclk = 297000000,
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
>  		ret = 0;
>  		break;
> @@ -1102,7 +1111,7 @@ static int imx334_parse_hw_config(struct imx334 *imx334)
>  	}
>
>  	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
> -		if (bus_cfg.link_frequencies[i] == IMX334_LINK_FREQ)
> +		if (bus_cfg.link_frequencies[i] == IMX334_LINK_FREQ_891M)

Is it legit to specify 445MHz in device tree ? I think so, as it's one
of the frequencies the sensor can operate at. If that's the case the
code here will fail, as it only recognize 891MHz ?

The DTS property serve to specify a sub-set of all the link-frequencies the
driver can to operate at. If a dtb specifies 445MHz only, it means
your driver cannot operate at 891MHz full resolution mode. Sakari, is
my understanding correct here ?

In theory you could require dtbs to support both frequencies, but
old dtbs will only have 891MHz specified, should they continue to work but
with only the full resolution mode available ?

A possible way out is to:

1) Collect the allowed frequencies at dtbs probe time

        static const s64 link_freq[] = {
                IMX334_LINK_FREQ_891M,
                IMX334_LINK_FREQ_445M,
        };
        static s64 enabled_link_freq[ARRAY_SIZE(link_freq)] = {};


        ...

  	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++) {
                for (j = 0; j < ARRAY_SIZE(link_freq); j++) {
                        if (bus_cfg.link_frequencies[i] == link_freq[j])
                                enabled_link_frequencies[j] = link_freq[j];
                }
        }

        for (i = 0; i < ARRAY_SIZE(link_freq); i++) {
                if (enabled_link_freq[i] != 0)
                        break;
        }
        if (i == ARRAY_SIZE(link_freq)) {
		dev_err(imx334->dev, "no valid link frequencies in DTS");
		ret = -EINVAL;
		goto done_endpoint_free;
        }

        ...

2) When enumerating or setting mode, make sure the mode's
   enabled_link_freq[mode->link_freq_idx] != 0

   but this might quickly get complex and error prone.

Sakari, what is the best way to handle situations like this one ?
The driver is upstream working with a single link_frequency of 891MHz.
A new link frequency is added, and it is now allowed to have DTS
specify both frequencies, or just one of them. Should the driver rule
out all modes that require a link_frequency not specified in DTS ?

There are several examples of drivers handling multiple link_freqs in
media/i2c/ but I haven't find out that filters the modes according to
the specified frequencies (I admit I only quickly looked).

Thanks
  j

}




>  			goto done_endpoint_free;
>
>  	ret = -EINVAL;
> --
> 2.34.1
>
