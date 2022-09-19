Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC45BCC61
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiISNAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiISNAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:00:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207761F2E9;
        Mon, 19 Sep 2022 06:00:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5513C9BA;
        Mon, 19 Sep 2022 15:00:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663592440;
        bh=v2R/DzsoY89MalQQFUlcxHPOdvaGIj7Ikznat8iauhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRlfgPRibxJTOATXr6AULLdaqZBKHevxUKjsq2tRSspRFCev9LGXu6lvSzp7WV+wH
         W1scDwuN+ceUHhJw+SQ0AOtn5X2Ul+Qt1AhdYpnTutQBZV+c9BfefEGssGX9Eik0sR
         MgYcWlcs7ILufo7PuAumtSOLoha2xHzB2olzSa4I=
Date:   Mon, 19 Sep 2022 16:00:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        akinobu.mita@gmail.com, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: mt9m111: don't turn on the output while
 powering it
Message-ID: <Yyhn68RabEvVXu+S@pendragon.ideasonboard.com>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <20220916135713.143890-3-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220916135713.143890-3-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Thank you for the patch.

On Fri, Sep 16, 2022 at 03:57:13PM +0200, Marco Felsch wrote:
> Currently the .s_power() turn on/off the device and enables/disables the
> sensor output. This is wrong since it should only handle the power not
> not the sensor output behaviour. Enabling the sensor output should be
> part of the .s_stream() callback.
> 
> Fix this by adding mt9m111_set_output() which gets called by the
> .s_stream() callback and remove the output register bits from
> mt9m111_resume/suspend.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> 
> v2:
> - new patch, replaces: "media: mt9m111: remove .s_power callback"
> ---
>  drivers/media/i2c/mt9m111.c | 38 ++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> index 8de93ab99cbc..2cc0b0da7636 100644
> --- a/drivers/media/i2c/mt9m111.c
> +++ b/drivers/media/i2c/mt9m111.c
> @@ -426,10 +426,25 @@ static int mt9m111_setup_geometry(struct mt9m111 *mt9m111, struct v4l2_rect *rec
>  	return ret;
>  }
>  
> -static int mt9m111_enable(struct mt9m111 *mt9m111)
> +static int mt9m111_set_output(struct mt9m111 *mt9m111, int on)
>  {
>  	struct i2c_client *client = v4l2_get_subdevdata(&mt9m111->subdev);
> -	return reg_write(RESET, MT9M111_RESET_CHIP_ENABLE);
> +	int ret;
> +
> +	if (on) {
> +		ret = reg_clear(RESET, MT9M111_RESET_OUTPUT_DISABLE);
> +		if (ret)
> +			return ret;
> +
> +		return reg_set(RESET, MT9M111_RESET_CHIP_ENABLE);
> +	}
> +
> +	/* disable */
> +	ret = reg_set(RESET, MT9M111_RESET_OUTPUT_DISABLE);
> +	if (ret)
> +		return ret;
> +
> +	return reg_clear(RESET, MT9M111_RESET_CHIP_ENABLE);

Unless the hardware specifically requires this sequence, I'd use the
inverse of the enable sequence here.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  }
>  
>  static int mt9m111_reset(struct mt9m111 *mt9m111)
> @@ -927,10 +942,7 @@ static int mt9m111_suspend(struct mt9m111 *mt9m111)
>  	ret = reg_set(RESET, MT9M111_RESET_RESET_MODE);
>  	if (!ret)
>  		ret = reg_set(RESET, MT9M111_RESET_RESET_SOC |
> -			      MT9M111_RESET_OUTPUT_DISABLE |
>  			      MT9M111_RESET_ANALOG_STANDBY);
> -	if (!ret)
> -		ret = reg_clear(RESET, MT9M111_RESET_CHIP_ENABLE);
>  
>  	return ret;
>  }
> @@ -951,9 +963,9 @@ static void mt9m111_restore_state(struct mt9m111 *mt9m111)
>  
>  static int mt9m111_resume(struct mt9m111 *mt9m111)
>  {
> -	int ret = mt9m111_enable(mt9m111);
> -	if (!ret)
> -		ret = mt9m111_reset(mt9m111);
> +	int ret;
> +
> +	ret = mt9m111_reset(mt9m111);
>  	if (!ret)
>  		mt9m111_restore_state(mt9m111);
>  
> @@ -965,9 +977,7 @@ static int mt9m111_init(struct mt9m111 *mt9m111)
>  	struct i2c_client *client = v4l2_get_subdevdata(&mt9m111->subdev);
>  	int ret;
>  
> -	ret = mt9m111_enable(mt9m111);
> -	if (!ret)
> -		ret = mt9m111_reset(mt9m111);
> +	ret = mt9m111_reset(mt9m111);
>  	if (!ret)
>  		ret = mt9m111_set_context(mt9m111, mt9m111->ctx);
>  	if (ret)
> @@ -1116,8 +1126,14 @@ static int mt9m111_enum_mbus_code(struct v4l2_subdev *sd,
>  static int mt9m111_s_stream(struct v4l2_subdev *sd, int enable)
>  {
>  	struct mt9m111 *mt9m111 = container_of(sd, struct mt9m111, subdev);
> +	int ret;
> +
> +	ret = mt9m111_set_output(mt9m111, enable);
> +	if (ret)
> +		return ret;
>  
>  	mt9m111->is_streaming = !!enable;
> +
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
