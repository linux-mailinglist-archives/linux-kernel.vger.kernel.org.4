Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE77C5BF8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiIUIUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiIUIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:20:28 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890074AD5E;
        Wed, 21 Sep 2022 01:20:15 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkwl20tj04snw15cjtflt-3.rev.dnainternet.fi [IPv6:2001:14ba:4493:6f40:fec3:d72a:e447:8113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 87F501B00215;
        Wed, 21 Sep 2022 11:20:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1663748412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSVINzCF2eS3xcrh5DnWhSMbMw+hUAB1vftTLn/Rz+U=;
        b=lXYUsMTUNfXUj5Lirl2SwqqQxwGF1Gc15ljIWPeYUwN3stAbpo08xWax0/6ylVR6LSNY4B
        AgBsw7bRB6p8vBmbuWlhvpk5blIDFAXfRnDB1ov6p12FjWedGZEET6ogh7q2AEBlzdTtZH
        Nb5LzNqR6aG45MUyLo+6za92Jy/m8O1WZE3IYBtR4pys73HaDHukUeWOpWClZzpk5bql5T
        yxbewQ1cdK1GTmDKaELqprJRruOb42LMiaZocRT+pywsvwWlircCjyyUWgIhNT5Njv2WnD
        o7l7lY8RedsraBOTTmhdvwSXWJ4t6D7F8DhXUk5GTjbD/F5pILwnjdpNN6QvOQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 3833E634CAA;
        Wed, 21 Sep 2022 11:20:12 +0300 (EEST)
Date:   Wed, 21 Sep 2022 11:20:12 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Hidenori Kobayashi <hidenorik@chromium.org>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: ov8856: Add runtime PM callbacks
Message-ID: <YyrJPBXzL+MZH8az@valkosipuli.retiisi.eu>
References: <20220921081536.2551789-1-hidenorik@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921081536.2551789-1-hidenorik@chromium.org>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1663748412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSVINzCF2eS3xcrh5DnWhSMbMw+hUAB1vftTLn/Rz+U=;
        b=UxzWW99PtmSC45uzy0X/cBpneysjdpTQdXJxwr/GXTfyWgQhzmelzS2zskIoeO+UalfARq
        E8+qEmNj+ag28lg2A6xXcmcnX5+YJc4dLbU7PhndPrN6x3vD4gjCYHoQYA1pCQqkeo41S+
        5e/rMLL4bekwLXbygvu3izobIVcz6/6IyIvtoxU51YLlGpBcRrPVRnsbZMfTOaIsglxDzZ
        mxXjQQKq2UdosQEhUJjF5qEI6+BOLnA70TwjMXvpd8vsFO9wsKi723pc1LI+KQYoybeIuF
        GlMspDycCILfEAjXJYcJ1gemABjSCPLfdv3dKMgexBi3WCVT1sK1WYkdwsVePQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1663748412; a=rsa-sha256;
        cv=none;
        b=pHfChq+L5kIn3V4mH/WwgHha5MutNMx+9QP2/rI3TXA1RqIopSlH5+pbBFxuxGdyVRpojR
        4y/L9VeBFSmB64vvcmWhykJSVQiGx33eBEDrny11684bee7UA+iSqEQZPP5zWM70k1I7Ds
        y2h7s16H9fam+YDsZvwtYjrDE1QOMMt9GNuEpbtHHYqlY9x+MhdcCPS0unXXjPHqu6bCzG
        +6bcbrzSLm6+Mwrw+tzdRHqGCVmXfzyKJHg6cuEPZwcWe/ni2e6+3B/6QiLPd+mSowBtCt
        mda/AfJXt0f0rVnv/Ib5Qly0LWRkZ98M3iDILPJtv4tNJa9z9dPrGcZaaZwcpg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hidenori,

On Wed, Sep 21, 2022 at 05:15:35PM +0900, Hidenori Kobayashi wrote:
> There were no runtime PM callbacks registered, leaving regulators being
> enabled while the device is suspended on DT systems. Add callbacks that
> call existing power controlling functions to turn them off/on.
> 
> To simplify the code with this addition, change the argument of the
> power controlling functions.
> 
> Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.org>
> ---
> V1 -> V2: Change argument of power controlling functions
> ---
>  drivers/media/i2c/ov8856.c | 41 ++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index a9728afc81d4..188699455fdf 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -2110,17 +2110,18 @@ static int ov8856_set_stream(struct v4l2_subdev *sd, int enable)
>  	return ret;
>  }
>  
> -static int __ov8856_power_on(struct ov8856 *ov8856)
> +static int __ov8856_power_on(struct device *dev)
>  {
> -	struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +	struct ov8856 *ov8856 = to_ov8856(sd);
>  	int ret;
>  
> -	if (is_acpi_node(dev_fwnode(&client->dev)))
> +	if (is_acpi_node(dev_fwnode(dev)))
>  		return 0;
>  
>  	ret = clk_prepare_enable(ov8856->xvclk);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "failed to enable xvclk\n");
> +		dev_err(dev, "failed to enable xvclk\n");
>  		return ret;
>  	}
>  
> @@ -2132,7 +2133,7 @@ static int __ov8856_power_on(struct ov8856 *ov8856)
>  	ret = regulator_bulk_enable(ARRAY_SIZE(ov8856_supply_names),
>  				    ov8856->supplies);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "failed to enable regulators\n");
> +		dev_err(dev, "failed to enable regulators\n");
>  		goto disable_clk;
>  	}
>  
> @@ -2148,11 +2149,12 @@ static int __ov8856_power_on(struct ov8856 *ov8856)
>  	return ret;
>  }
>  
> -static void __ov8856_power_off(struct ov8856 *ov8856)
> +static void __ov8856_power_off(struct device *dev)
>  {
> -	struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +	struct ov8856 *ov8856 = to_ov8856(sd);
>  
> -	if (is_acpi_node(dev_fwnode(&client->dev)))
> +	if (is_acpi_node(dev_fwnode(dev)))
>  		return;
>  
>  	gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
> @@ -2170,7 +2172,7 @@ static int __maybe_unused ov8856_suspend(struct device *dev)
>  	if (ov8856->streaming)
>  		ov8856_stop_streaming(ov8856);
>  
> -	__ov8856_power_off(ov8856);
> +	__ov8856_power_off(dev);
>  	mutex_unlock(&ov8856->mutex);
>  
>  	return 0;
> @@ -2184,7 +2186,7 @@ static int __maybe_unused ov8856_resume(struct device *dev)
>  
>  	mutex_lock(&ov8856->mutex);
>  
> -	__ov8856_power_on(ov8856);
> +	__ov8856_power_on(dev);
>  	if (ov8856->streaming) {
>  		ret = ov8856_start_streaming(ov8856);
>  		if (ret) {
> @@ -2200,6 +2202,18 @@ static int __maybe_unused ov8856_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int __maybe_unused ov8856_runtime_suspend(struct device *dev)
> +{
> +	__ov8856_power_off(dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused ov8856_runtime_resume(struct device *dev)
> +{
> +	return __ov8856_power_on(dev);
> +}

These two functions are redundant now, you can call __ov8856_power_on /
__ov8856_power_off directly. The return type of __ov8856_power_off needs to
be changed to int. You could also remove the underscores from the names at
the same time.

> +
>  static int ov8856_set_format(struct v4l2_subdev *sd,
>  			     struct v4l2_subdev_state *sd_state,
>  			     struct v4l2_subdev_format *fmt)
> @@ -2451,7 +2465,7 @@ static int ov8856_remove(struct i2c_client *client)
>  	pm_runtime_disable(&client->dev);
>  	mutex_destroy(&ov8856->mutex);
>  
> -	__ov8856_power_off(ov8856);
> +	__ov8856_power_off(&client->dev);
>  
>  	return 0;
>  }
> @@ -2477,7 +2491,7 @@ static int ov8856_probe(struct i2c_client *client)
>  
>  	full_power = acpi_dev_state_d0(&client->dev);
>  	if (full_power) {
> -		ret = __ov8856_power_on(ov8856);
> +		ret = __ov8856_power_on(&client->dev);
>  		if (ret) {
>  			dev_err(&client->dev, "failed to power on\n");
>  			return ret;
> @@ -2533,13 +2547,14 @@ static int ov8856_probe(struct i2c_client *client)
>  	mutex_destroy(&ov8856->mutex);
>  
>  probe_power_off:
> -	__ov8856_power_off(ov8856);
> +	__ov8856_power_off(&client->dev);
>  
>  	return ret;
>  }
>  
>  static const struct dev_pm_ops ov8856_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(ov8856_suspend, ov8856_resume)
> +	SET_RUNTIME_PM_OPS(ov8856_runtime_suspend, ov8856_runtime_resume, NULL)
>  };
>  
>  #ifdef CONFIG_ACPI

-- 
Kind regards,

Sakari Ailus
