Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5995F640E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiJFJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiJFJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:59:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CC88E9BD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:59:03 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i3so1579837pfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Taz++R124HxhonY+iwrsPBbZtAcEK5dkiZQoTWiFaMM=;
        b=CS8m6xuHQ8AmqYOk8QY5UMjvGM2QdP6fw58iBYLfot93QVaU/+5630ejqZ1tOyxffl
         wE+sfxa7T+SSF19IGmPFCyEPfIZrOYOeNMH1aNPySe56LQeeElMv3mNCcPaGPfUNiBeU
         AQECJUTLb+yzdzzpsgb1HSaMK7wHFJys+OFKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Taz++R124HxhonY+iwrsPBbZtAcEK5dkiZQoTWiFaMM=;
        b=OsWev1FQsjNGz7AW4h+QaVlsZu0L9BJqIajDvUuv0uHP6TCxjmZmOK/QYtiwJoR3Rt
         bcisHT8YX04U2j61oR1N1PBxlakORX5EnUTi2xQtTlcXoD1KZ6dbVklIPiWa6QRruDZF
         aWVQuLdZntyXq6mT1V9d25e+uttwGLPbNi/v9UXZYrvaX9gjlvdEGlTfgRh5Ok/bUEs1
         Vy8fege9GXN8nYqxDkHEt20NEc5vatHGPyMWKLPdZ5D21QXUROwWZNdfxlVF4mm/VjqW
         LVP6SDKDB5Pm2czvHHNrOowyKMtzQwq4AIbIzTxhKPlA+NW3lt+mfnXV75aWw/T+QYbY
         uagQ==
X-Gm-Message-State: ACrzQf3mJLSiVVvAoay0zD1UPbYw0oL42kTV59QRZjRqFVopN6YrBSNg
        iq/9Dlz3l+azrJTtXZapBK1HFA==
X-Google-Smtp-Source: AMsMyM6R6Yrc+Adyhe/l9fNSSu8uNMIftiMEuyNrsU+HN+MNdWtt5cyokaRdSMol/vHA9uqknb9GWA==
X-Received: by 2002:a63:f250:0:b0:44e:633b:23ae with SMTP id d16-20020a63f250000000b0044e633b23aemr3750717pgk.17.1665050330090;
        Thu, 06 Oct 2022 02:58:50 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:ff93:7208:af9f:b262])
        by smtp.gmail.com with ESMTPSA id d8-20020a621d08000000b005623b769b50sm2646306pfd.202.2022.10.06.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:58:49 -0700 (PDT)
Date:   Thu, 6 Oct 2022 18:58:46 +0900
From:   Hidenori Kobayashi <hidenorik@chromium.org>
To:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] media: ov8856: Add runtime PM callbacks
Message-ID: <20221006095846.pvhmis44z777fnsl@google.com>
References: <20220921092417.2579126-1-hidenorik@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921092417.2579126-1-hidenorik@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Could you kindly take a look, please?

On Wed, Sep 21, 2022 at 06:24:17PM +0900, Hidenori Kobayashi wrote:
> There were no runtime PM callbacks registered, leaving regulators being
> enabled while the device is suspended on DT systems. Adjust and register
> existing power controlling functions to turn them off/on.
> 
> Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.org>
> ---
> V2 -> V3: Remove redundant wrappers (were added in V1)
> V1 -> V2: Change argument of power controlling functions
> ---
>  drivers/media/i2c/ov8856.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index a9728afc81d4..760611ee5485 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -2110,17 +2110,18 @@ static int ov8856_set_stream(struct v4l2_subdev *sd, int enable)
>  	return ret;
>  }
>  
> -static int __ov8856_power_on(struct ov8856 *ov8856)
> +static int ov8856_power_on(struct device *dev)
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
> @@ -2148,17 +2149,20 @@ static int __ov8856_power_on(struct ov8856 *ov8856)
>  	return ret;
>  }
>  
> -static void __ov8856_power_off(struct ov8856 *ov8856)
> +static int ov8856_power_off(struct device *dev)
>  {
> -	struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +	struct ov8856 *ov8856 = to_ov8856(sd);
>  
> -	if (is_acpi_node(dev_fwnode(&client->dev)))
> -		return;
> +	if (is_acpi_node(dev_fwnode(dev)))
> +		return 0;
>  
>  	gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
>  	regulator_bulk_disable(ARRAY_SIZE(ov8856_supply_names),
>  			       ov8856->supplies);
>  	clk_disable_unprepare(ov8856->xvclk);
> +
> +	return 0;
>  }
>  
>  static int __maybe_unused ov8856_suspend(struct device *dev)
> @@ -2170,7 +2174,7 @@ static int __maybe_unused ov8856_suspend(struct device *dev)
>  	if (ov8856->streaming)
>  		ov8856_stop_streaming(ov8856);
>  
> -	__ov8856_power_off(ov8856);
> +	ov8856_power_off(dev);
>  	mutex_unlock(&ov8856->mutex);
>  
>  	return 0;
> @@ -2184,7 +2188,7 @@ static int __maybe_unused ov8856_resume(struct device *dev)
>  
>  	mutex_lock(&ov8856->mutex);
>  
> -	__ov8856_power_on(ov8856);
> +	ov8856_power_on(dev);
>  	if (ov8856->streaming) {
>  		ret = ov8856_start_streaming(ov8856);
>  		if (ret) {
> @@ -2451,7 +2455,7 @@ static int ov8856_remove(struct i2c_client *client)
>  	pm_runtime_disable(&client->dev);
>  	mutex_destroy(&ov8856->mutex);
>  
> -	__ov8856_power_off(ov8856);
> +	ov8856_power_off(&client->dev);
>  
>  	return 0;
>  }
> @@ -2477,7 +2481,7 @@ static int ov8856_probe(struct i2c_client *client)
>  
>  	full_power = acpi_dev_state_d0(&client->dev);
>  	if (full_power) {
> -		ret = __ov8856_power_on(ov8856);
> +		ret = ov8856_power_on(&client->dev);
>  		if (ret) {
>  			dev_err(&client->dev, "failed to power on\n");
>  			return ret;
> @@ -2533,13 +2537,14 @@ static int ov8856_probe(struct i2c_client *client)
>  	mutex_destroy(&ov8856->mutex);
>  
>  probe_power_off:
> -	__ov8856_power_off(ov8856);
> +	ov8856_power_off(&client->dev);
>  
>  	return ret;
>  }
>  
>  static const struct dev_pm_ops ov8856_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(ov8856_suspend, ov8856_resume)
> +	SET_RUNTIME_PM_OPS(ov8856_power_off, ov8856_power_on, NULL)
>  };
>  
>  #ifdef CONFIG_ACPI
> -- 
> 2.37.3.968.ga6b4b080e4-goog
> 
