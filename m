Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74D35B9C95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIOOH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIOOHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C1D9BB68;
        Thu, 15 Sep 2022 07:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAC0761596;
        Thu, 15 Sep 2022 14:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7F8C433C1;
        Thu, 15 Sep 2022 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663250873;
        bh=HxlRuhoGcTxGqqXgKJmA6+MnE6LBLOge8LuTDWJ4KRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fGsnt+uO3gA7zuYabdAm2RR0ZftsGM27oRNKu4tgZdjau8SOmAo+Lpr6dA6Qo1a36
         T9tN198SkyqDAU5LpSyLYvNf6O5LRPcuyYNlOYCom1olN94fModxGnRg5raZmhPItj
         Hm0i7XCbLC8PAcFG/lr/flZP3Yf4eor+raEGYxLy7Xc0Er8Rgv3Kyp71BAiud83rHo
         pa4enNG3QrfcnphTEp/g6hqPDCfonOHADoFV7YQH3/igxD1n1PDVqSWjN2tTDxoLsM
         WD7jrQ5CIa78T7moTxKq5AEhKIUZ/svtRFvUbKIRVw3qp8mWjQy7rkUy/TATUubIEa
         GLUAu3b1tUqTw==
Date:   Thu, 15 Sep 2022 15:07:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Message-ID: <20220915150752.643a3e7d@jic23-huawei>
In-Reply-To: <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
References: <cover.1662454215.git.cmo@melexis.com>
        <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Sep 2022 11:04:30 +0200
cmo@melexis.com wrote:

> From: Crt Mori <cmo@melexis.com>
> 
> The sensor can operate in lower power modes and even make measurements when
> in those lower powered modes. The decision was taken that if measurement
> is not requested within 2 seconds the sensor will remain in SLEEP_STEP
> power mode, where measurements are triggered on request with setting the
> start of measurement bit (SOB). In this mode the measurements are taking
> a bit longer because we need to start it and complete it. Currently, in
> continuous mode we read ready data and this mode is activated if sensor
> measurement is requested within 2 seconds. The suspend timeout is
> increased to 6 seconds (instead of 3 before), because that enables more
> measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> rate (2 seconds).
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>

This is missing necessary disabling of autosuspend (see inline).

Also, I just realised you have the original pm disables in remove after
this patch - so effectively you disable runtime pm twice.

There is a sleep in that remove function which can also be done with
a devm_add_action_or_reset().  Do that as well and you can move
the device register to the devm form and drop the remove() function entirely.


> ---
>  drivers/iio/temperature/mlx90632.c | 347 +++++++++++++++++++++++++----
>  1 file changed, 302 insertions(+), 45 deletions(-)

> +	return 2;
> +}
> +

Nitpick, but single line is plenty.

> +
> +static int mlx90632_set_meas_type(struct mlx90632_data *data, u8 type)
> +{


>  
>  static int mlx90632_write_raw(struct iio_dev *indio_dev,
> @@ -875,6 +1096,15 @@ static int mlx90632_enable_regulator(struct mlx90632_data *data)
>  	return ret;
>  }
>  
> +static void mlx90632_pm_disable(void *data)
> +{
> +	struct device *dev = data;
> +
> +	pm_runtime_get_sync(dev);
So, this isn't quite enough.

Take a look at what devm_pm_runtime_enable()
does as the documentation for
pm_runtime_use_autosuspend()

I'd suggest using devm_pm_runtime_enable() and
an additional callback to turn the device on that
is registered after devm_pm_runtime_enable()
(so will maintain the ordering you have here).


 
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_disable(dev);
> +}
> +
>  static int mlx90632_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -902,6 +1132,7 @@ static int mlx90632_probe(struct i2c_client *client,
>  	mlx90632->client = client;
>  	mlx90632->regmap = regmap;
>  	mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
> +	mlx90632->powerstatus = MLX90632_PWR_STATUS_HALT;
>  
>  	mutex_init(&mlx90632->lock);
>  	indio_dev->name = id->name;
> @@ -961,16 +1192,25 @@ static int mlx90632_probe(struct i2c_client *client,
>  
>  	mlx90632->emissivity = 1000;
>  	mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
> +	mlx90632->interaction_ts = jiffies; /* Set initial value */
>  
> -	pm_runtime_disable(&client->dev);
> +	pm_runtime_get_noresume(&client->dev);
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret < 0) {
>  		mlx90632_sleep(mlx90632);
>  		return ret;
>  	}
> +
>  	pm_runtime_enable(&client->dev);
>  	pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
> +	pm_runtime_put_autosuspend(&client->dev);
> +
> +	ret = devm_add_action_or_reset(&client->dev, mlx90632_pm_disable, &client->dev);

Having moved those over to devm you need to also have dropped the calls in remove()
(I only noticed this whilst trying to fix the autosuspend issue above.)
> +	if (ret) {
> +		mlx90632_sleep(mlx90632);
> +		return ret;
> +	}
>  
>  	return iio_device_register(indio_dev);
>  }

