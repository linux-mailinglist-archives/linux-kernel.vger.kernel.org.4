Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF65BB00E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiIPPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiIPPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:16:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4967FA6C16;
        Fri, 16 Sep 2022 08:16:49 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MTcxY1PHXz67nLn;
        Fri, 16 Sep 2022 23:12:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 17:16:47 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 16:16:47 +0100
Date:   Fri, 16 Sep 2022 16:16:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <cmo@melexis.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Message-ID: <20220916161645.00000ec6@huawei.com>
In-Reply-To: <67684133a45c4da6d4c13f5ee766d35cdae854e6.1663324968.git.cmo@melexis.com>
References: <cover.1663324968.git.cmo@melexis.com>
        <67684133a45c4da6d4c13f5ee766d35cdae854e6.1663324968.git.cmo@melexis.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 12:45:50 +0200
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

Hi Crt,

I think I also mentioned switching to devm_iio_device_register().
I don't mind if that's in a follow on patch (as technically unconnected
from runtime pm) but it is something that needs tidying up now there is
nothing else in remove. Otherwise we leave this driver in a state that
I don't want anyone else copying into a new driver!

As per my reply to the cover letter, I'm unconvinced that we want to drop
the code to put the device into a low power state on remove().
We do however want to make that a problem for the devm_ infrastrucuture.
Normally this is done by adding a devm_add_action_or_reset() call
to add a callback just after we power up the chip in the first place.
That way an error path also results in us trying to leave the device
in a low power state.

Jonathan

> ---
>  drivers/iio/temperature/mlx90632.c | 341 ++++++++++++++++++++++++-----
>  1 file changed, 287 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 549c0ab5c2be..80497d9bc4e9 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -6,11 +6,14 @@
>  
>  static int mlx90632_write_raw(struct iio_dev *indio_dev,
> @@ -902,6 +1122,7 @@ static int mlx90632_probe(struct i2c_client *client,
>  	mlx90632->client = client;
>  	mlx90632->regmap = regmap;
>  	mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
> +	mlx90632->powerstatus = MLX90632_PWR_STATUS_HALT;
>  
>  	mutex_init(&mlx90632->lock);
>  	indio_dev->name = id->name;
> @@ -961,16 +1182,19 @@ static int mlx90632_probe(struct i2c_client *client,
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
> -	pm_runtime_enable(&client->dev);
> +
> +	devm_pm_runtime_enable(&client->dev);
>  	pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
> +	pm_runtime_put_autosuspend(&client->dev);
>  
>  	return iio_device_register(indio_dev);
>  }
> @@ -978,16 +1202,8 @@ static int mlx90632_probe(struct i2c_client *client,
>  static int mlx90632_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct mlx90632_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);

Once you reach the point where this is all that is left in
remove() you can just use devm_iio_device_register() and it'll
be cleaned up automatically + can drop remove().

It is technically an unconnected change though, so I guess it can be a follow up
patch.

> -
> -	pm_runtime_disable(&client->dev);
> -	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
> -
> -	mlx90632_sleep(data);
> -
>  	return 0;
>  }
>  
> @@ -1003,30 +1219,47 @@ static const struct of_device_id mlx90632_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mlx90632_of_match);
>
