Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F246D8CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjDFBfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDFBfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:35:46 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D654729F;
        Wed,  5 Apr 2023 18:35:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A537E905;
        Thu,  6 Apr 2023 03:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680744943;
        bh=12mH4xyNP3DoccOweLixoRft2FfphUv36oa0MAhTESE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdLVJF2hXGMc4JVzbf4DjfcxQw4IKGODbyGt2WKwxO045zhOnfwn66Fp3GHF7ggCY
         eiD6Ul9NQP884zJPPMoGBurQkgjBl+OPpokaKBDKlaqsX4cxK6YVa8QI89VieV6ooq
         ER+dUs3Q1GsNmPmVawe7diniQsqy4f/FHcOS+Xxc=
Date:   Thu, 6 Apr 2023 04:35:51 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] media: hi846: preserve the streaming state during
 system suspend
Message-ID: <20230406013551.GL9915@pendragon.ideasonboard.com>
References: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
 <20230405092904.1129395-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230405092904.1129395-3-martin.kepplinger@puri.sm>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch.

On Wed, Apr 05, 2023 at 11:29:04AM +0200, Martin Kepplinger wrote:
> The hi846 driver changed the "streaming" state inside of "start/stop_streaming".
> The problem is that inside of the (system) suspend callback, it calls
> "stop_streaming" unconditionally. So streaming would always be stopped
> when suspending.
> 
> That makes sense with runtime pm for example, after s_stream(..., 0) but
> does not preserve the "streaming" state during system suspend when
> currently streaming.

The driver shouldn't need to stop streaming at system suspend time. It
should have had its .s_stream(0) operation called and shouldn't be
streaming anymore. If that's not the case, there's an issue somewhere
else, which should be fixed. The code that stops streaming at system
suspend and restarts it at system resume should then be dropped from
this driver.

> Fix this by simply setting the streaming state outside of "start/stop_streaming"
> which is s_stream().
> 
> While at it, improve things a bit by not assigning "1", but the "enable"
> value we later compare against, and fix one error handling path in resume().
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/media/i2c/hi846.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> index 0b0eda2e223cd..1ca6e9407d618 100644
> --- a/drivers/media/i2c/hi846.c
> +++ b/drivers/media/i2c/hi846.c
> @@ -1780,8 +1780,6 @@ static int hi846_start_streaming(struct hi846 *hi846)
>  		return ret;
>  	}
>  
> -	hi846->streaming = 1;
> -
>  	dev_dbg(&client->dev, "%s: started streaming successfully\n", __func__);
>  
>  	return ret;
> @@ -1793,8 +1791,6 @@ static void hi846_stop_streaming(struct hi846 *hi846)
>  
>  	if (hi846_write_reg(hi846, HI846_REG_MODE_SELECT, HI846_MODE_STANDBY))
>  		dev_err(&client->dev, "failed to stop stream");
> -
> -	hi846->streaming = 0;
>  }
>  
>  static int hi846_set_stream(struct v4l2_subdev *sd, int enable)
> @@ -1816,10 +1812,12 @@ static int hi846_set_stream(struct v4l2_subdev *sd, int enable)
>  		}
>  
>  		ret = hi846_start_streaming(hi846);
> +		hi846->streaming = enable;
>  	}
>  
>  	if (!enable || ret) {
>  		hi846_stop_streaming(hi846);
> +		hi846->streaming = 0;
>  		pm_runtime_put(&client->dev);
>  	}
>  
> @@ -1898,6 +1896,8 @@ static int __maybe_unused hi846_resume(struct device *dev)
>  		if (ret) {
>  			dev_err(dev, "%s: start streaming failed: %d\n",
>  				__func__, ret);
> +			hi846_stop_streaming(hi846);
> +			hi846->streaming = 0;
>  			goto error;
>  		}
>  	}

-- 
Regards,

Laurent Pinchart
