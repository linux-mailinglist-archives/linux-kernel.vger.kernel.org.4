Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62775BB01F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiIPPWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiIPPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:22:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6258E4DB;
        Fri, 16 Sep 2022 08:22:17 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MTd7y3bc7z67W0D;
        Fri, 16 Sep 2022 23:21:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 17:22:15 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 16:22:15 +0100
Date:   Fri, 16 Sep 2022 16:22:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Crt Mori <cmo@melexis.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Message-ID: <20220916162214.00002fd0@huawei.com>
In-Reply-To: <CAKv63utO6_vPtuCZKSa5MFFKbSYPQbrAGytiiqT+CZ402rO9fA@mail.gmail.com>
References: <cover.1662454215.git.cmo@melexis.com>
        <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
        <20220915150752.643a3e7d@jic23-huawei>
        <CAKv63utO6_vPtuCZKSa5MFFKbSYPQbrAGytiiqT+CZ402rO9fA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Thu, 15 Sep 2022 16:35:33 +0200
Crt Mori <cmo@melexis.com> wrote:

> > > +     pm_runtime_get_sync(dev);  
> > So, this isn't quite enough.
> >
> > Take a look at what devm_pm_runtime_enable()
> > does as the documentation for
> > pm_runtime_use_autosuspend()
> >
> > I'd suggest using devm_pm_runtime_enable() and
> > an additional callback to turn the device on that
> > is registered after devm_pm_runtime_enable()
> > (so will maintain the ordering you have here).
> >
> >
 Oops. I should have looked for a reply before responding to your v4.

> >  
> I copied this from pressure/bmp280-core driver. I had devm_pm
> originally, but was asked to replace it.

It is a little odd to mix and match, but I think it makes sense in
this case.  Can see why people might disagree (maybe it was me!)

> 
> > > +     pm_runtime_put_noidle(dev);
> > > +     pm_runtime_disable(dev);
> > > +}
> > > +
> > >  static int mlx90632_probe(struct i2c_client *client,
> > >                         const struct i2c_device_id *id)
> > >  {
> > > @@ -902,6 +1132,7 @@ static int mlx90632_probe(struct i2c_client *client,
> > >       mlx90632->client = client;
> > >       mlx90632->regmap = regmap;
> > >       mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
> > > +     mlx90632->powerstatus = MLX90632_PWR_STATUS_HALT;
> > >
> > >       mutex_init(&mlx90632->lock);
> > >       indio_dev->name = id->name;
> > > @@ -961,16 +1192,25 @@ static int mlx90632_probe(struct i2c_client *client,
> > >
> > >       mlx90632->emissivity = 1000;
> > >       mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
> > > +     mlx90632->interaction_ts = jiffies; /* Set initial value */
> > >
> > > -     pm_runtime_disable(&client->dev);
> > > +     pm_runtime_get_noresume(&client->dev);
> > >       ret = pm_runtime_set_active(&client->dev);
> > >       if (ret < 0) {
> > >               mlx90632_sleep(mlx90632);
> > >               return ret;
> > >       }
> > > +
> > >       pm_runtime_enable(&client->dev);
> > >       pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
> > >       pm_runtime_use_autosuspend(&client->dev);
> > > +     pm_runtime_put_autosuspend(&client->dev);
> > > +
> > > +     ret = devm_add_action_or_reset(&client->dev, mlx90632_pm_disable, &client->dev);  
> >
> > Having moved those over to devm you need to also have dropped the calls in remove()
> > (I only noticed this whilst trying to fix the autosuspend issue above.)  
> 
> So in remove, there should be no pm calls, because mlx90632_pm_disable
> function handle all of it? I still keep the sleep call, so that it
> also puts the sensor in lowest state, or I rather keep it only in
> regulator_disable (which should also be called at removal)?

No, you still need some calls, because the devm_pm_runtime_enable()
registers a callback that only does part of what you have - it leaves
the device in an unknown state. If you want to power it up again so
that you can in turn switch it off cleanly (and hence handle the
non runtime pm case nicely) then you still need to do that.

The sleep is still useful because we may not have a controllable regulator.
In that case we want to go to a low power state anyway.

If we do have a controllable regulator, then sleeping followed by hitting
the power button does no harm.


Jonathan


> 
> > > +     if (ret) {
> > > +             mlx90632_sleep(mlx90632);
> > > +             return ret;
> > > +     }
> > >
> > >       return iio_device_register(indio_dev);
> > >  }  
> >  

