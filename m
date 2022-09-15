Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62155B9D73
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiIOOiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiIOOha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:37:30 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B91F9E6B5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:36:10 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-127d10b4f19so47684378fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Zr0MOjMyJ6WGRsERkhoXjTXWIw4oT4dBi2Wz+SVWe98=;
        b=MWwj6VeFoHgj5/3eit/oxW6bAWnNYIjrRgjtLUhPpVWH4i3gh6+Kdhwe6G9kKWK7Y+
         Wtyll+uKUfso51oiIxfuu6OByixdV1/4tYlDoL1yyBnNtmILX50Gx0qd727qrXPdbrl1
         +/DGmiBGNF34sz6OOO+++bJw1FrDKV2SCcG5CWCULCt6WP+CWo4BiOAb7aH9fudiZLx2
         ioigFbhWdhcm+5WOvNC1odH68jQ1aYOd8wAK0NOcND5NmlSSRJE80R+WDS+bMX5rQUsT
         ryzgwTe68xOmq3LvDm6UvlHDLNxZoQAw0cFW7LwbDK/iZnBWMuUm47LH8ZsDno9B82Cm
         sqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Zr0MOjMyJ6WGRsERkhoXjTXWIw4oT4dBi2Wz+SVWe98=;
        b=4FiG0YYIToM43JHYXMkdTeUaoU81J38kpieb2ZWynuDThrbTH43j6t3VVpoEgJ4AC7
         PiXuY9I8WPzvJ7ZKS4Fx4rCnlf8o25GyeLTrdLfbWb3DWL9J7im0JVFXGjf3glWkp6fc
         f4ooR094JYRXSdFxPXUojPqcUg4zlj1YawmBKuEhi9xDnG52V/Rbu3MC3kIHKkIy7p6M
         7PSRszOYehAKHqu+3YQGfZzn1ladFbaYiPQuePO5Xr73qJZkgOnti9Bve/SP2U7+ovl1
         IpUwjr8uilNTqAEQPmb1245LqG9o/xmLnakdAPcPTkbwqBv3bnCqpKWSqRFr7YJZcG2X
         Dx5g==
X-Gm-Message-State: ACgBeo1c/9PTMPXsPm+Zq+igsO0I057uQwpvA5z90qm9DMk3Qjp+EW7U
        deTrffqf/EBwBdLWpJU1p1cvQoNY0UIYOye57mn9yg==
X-Google-Smtp-Source: AA6agR5lghRRXWw0R59Hhnd0mNw6jUREHggPbSqfDKsiOlYodoP3EA7gazsus1vkNSFxYZ70kYfDIkkwjmQvgqlsmzQ=
X-Received: by 2002:a05:6870:4586:b0:10d:2ec7:be6 with SMTP id
 y6-20020a056870458600b0010d2ec70be6mr5732908oao.7.1663252569231; Thu, 15 Sep
 2022 07:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
 <20220915150752.643a3e7d@jic23-huawei>
In-Reply-To: <20220915150752.643a3e7d@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Thu, 15 Sep 2022 16:35:33 +0200
Message-ID: <CAKv63utO6_vPtuCZKSa5MFFKbSYPQbrAGytiiqT+CZ402rO9fA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     pm_runtime_get_sync(dev);
> So, this isn't quite enough.
>
> Take a look at what devm_pm_runtime_enable()
> does as the documentation for
> pm_runtime_use_autosuspend()
>
> I'd suggest using devm_pm_runtime_enable() and
> an additional callback to turn the device on that
> is registered after devm_pm_runtime_enable()
> (so will maintain the ordering you have here).
>
>
>
I copied this from pressure/bmp280-core driver. I had devm_pm
originally, but was asked to replace it.

> > +     pm_runtime_put_noidle(dev);
> > +     pm_runtime_disable(dev);
> > +}
> > +
> >  static int mlx90632_probe(struct i2c_client *client,
> >                         const struct i2c_device_id *id)
> >  {
> > @@ -902,6 +1132,7 @@ static int mlx90632_probe(struct i2c_client *client,
> >       mlx90632->client = client;
> >       mlx90632->regmap = regmap;
> >       mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
> > +     mlx90632->powerstatus = MLX90632_PWR_STATUS_HALT;
> >
> >       mutex_init(&mlx90632->lock);
> >       indio_dev->name = id->name;
> > @@ -961,16 +1192,25 @@ static int mlx90632_probe(struct i2c_client *client,
> >
> >       mlx90632->emissivity = 1000;
> >       mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
> > +     mlx90632->interaction_ts = jiffies; /* Set initial value */
> >
> > -     pm_runtime_disable(&client->dev);
> > +     pm_runtime_get_noresume(&client->dev);
> >       ret = pm_runtime_set_active(&client->dev);
> >       if (ret < 0) {
> >               mlx90632_sleep(mlx90632);
> >               return ret;
> >       }
> > +
> >       pm_runtime_enable(&client->dev);
> >       pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
> >       pm_runtime_use_autosuspend(&client->dev);
> > +     pm_runtime_put_autosuspend(&client->dev);
> > +
> > +     ret = devm_add_action_or_reset(&client->dev, mlx90632_pm_disable, &client->dev);
>
> Having moved those over to devm you need to also have dropped the calls in remove()
> (I only noticed this whilst trying to fix the autosuspend issue above.)

So in remove, there should be no pm calls, because mlx90632_pm_disable
function handle all of it? I still keep the sleep call, so that it
also puts the sensor in lowest state, or I rather keep it only in
regulator_disable (which should also be called at removal)?

> > +     if (ret) {
> > +             mlx90632_sleep(mlx90632);
> > +             return ret;
> > +     }
> >
> >       return iio_device_register(indio_dev);
> >  }
>
