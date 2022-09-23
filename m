Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406C35E7913
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiIWLGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIWLGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:06:46 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43A21181EB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:06:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 3so11940296pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CivlmnyVEpJwxv4DfN3B0qY4C20BTHgcub0RDyyW0bM=;
        b=EkZWmF2KFjEeC9eST5w3FG1iQSe8lysLjlSX4ewpXpPvQffX41YrJ9eQE+qHBoFxE4
         96x/BQSHseSbZlpC0NodeqBWzzXltawzlJO+BF83TflXKKdCpoUjQ97rFddlnP00MHxq
         9FjR8FNe0e4JoTbZID0ICO70hZOeoRiDO0NuoRb0uCTIuHiwhM0x3Ch0z5IN8wGDL8dp
         Kk1WEpmD+dPkterwT6eXG/jG9bu2qXjgVbf7GcIH1iUUTP7nWXHKHpX+o/oH70iu7XX0
         fmyGmt1W+EQevlfXDbt+pGZd6k8260RT5IMxM7gM/Ks+OmVFwD+JAyWmZ8PkI7/Ev133
         Rggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CivlmnyVEpJwxv4DfN3B0qY4C20BTHgcub0RDyyW0bM=;
        b=IWra1B5vo/6CIs/i72ZW68RslKEOl4dbRisxcoPXQyrkcBFCpqhPr8rdWoh/AG0RO+
         aP2yLCVa9S2RmXkhpw+Z61z4Hu5Pu9bD7hB/KLEjOCDr6NqqTBucHG39e/S83aDlF+9B
         8+9z9IXXtusa9IrKu4yDBJw3PseZ1n/mvNg0fQxC8IIW3hD78SzmkdxythX3VvpgWsBx
         UyE/jsUVuWeEkwNgoOXab68Y8enXVhI7ypG1r3GfewDFkBx0NE4fRDjXZ+lYTYAgUypH
         190tIuWdZPsrOSvLDuDiGQGP5RVJRuiZNuF0EA1VEX5YC0lTJ9SF90oF6vZT8vvLAfqn
         92cQ==
X-Gm-Message-State: ACrzQf3CjO0uICtNKpOqbxm7ozgMlQ6lSEyVu+/VPHJMxEtvUBqyPTwe
        u2dIXXAZFQljjj+BtCZqLGQg+63Ddc2a7MUimo/Y+Q==
X-Google-Smtp-Source: AMsMyM5yjt4thE5+scbK0mFtX6Qki9qAhM+aBrZAdvG3AwgbQrDAjujCM9rFQSp2nJxxMKdOQ1bqv2d1CQtnz1OfIvw=
X-Received: by 2002:a63:85c6:0:b0:43a:eb08:6ea7 with SMTP id
 u189-20020a6385c6000000b0043aeb086ea7mr7216977pgd.336.1663931204200; Fri, 23
 Sep 2022 04:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220922050718.1079651-1-Naresh.Solanki@9elements.com> <20220922050718.1079651-3-Naresh.Solanki@9elements.com>
In-Reply-To: <20220922050718.1079651-3-Naresh.Solanki@9elements.com>
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
Date:   Fri, 23 Sep 2022 13:06:52 +0200
Message-ID: <CALNFmy0VGEYso1SDXQzmt8419RmG8CHEJUzZpFd0WvYeBzPDUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (max6639) Change from pdata to dt configuration
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Marcello Sylvester Bauer <sylv@sylv.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 7:07 AM Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> From: Marcello Sylvester Bauer <sylv@sylv.io>
>
> max6639_platform_data is not used by any in-kernel driver and does not
> address the MAX6639 channels separately. Move to device tree
> configuration with explicit properties to configure each channel.
>
> Non-DT platform can still use this module with its default
> configuration.
>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/max6639.c               | 162 +++++++++++++++++++-------
>  include/linux/platform_data/max6639.h |  15 ---
>  2 files changed, 119 insertions(+), 58 deletions(-)
>  delete mode 100644 include/linux/platform_data/max6639.h
>
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 14bb7726f8d7..4e8c3d3ec4fd 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -19,7 +19,6 @@
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> -#include <linux/platform_data/max6639.h>
>
>  /* Addresses to scan */
>  static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> @@ -85,8 +84,9 @@ struct max6639_data {
>         u8 temp_ot[2];          /* OT Temperature, 0..255 C (->_emergency) */
>
>         /* Register values initialized only once */
> -       u8 ppr;                 /* Pulses per rotation 0..3 for 1..4 ppr */
> -       u8 rpm_range;           /* Index in above rpm_ranges table */
> +       u8 ppr[2];              /* Pulses per rotation 0..3 for 1..4 ppr */
> +       u8 rpm_range[2];        /* Index in above rpm_ranges table */
> +       u8 pwm_polarity[2];     /* Fans PWM polarity, 0..1 */
>
>         /* Optional regulator for FAN supply */
>         struct regulator *reg;
> @@ -319,7 +319,7 @@ static ssize_t fan_input_show(struct device *dev,
>                 return PTR_ERR(data);
>
>         return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
> -                      data->rpm_range));
> +                      data->rpm_range[attr->index]));
>  }
>
>  static ssize_t alarm_show(struct device *dev,
> @@ -386,28 +386,26 @@ static struct attribute *max6639_attrs[] = {
>  ATTRIBUTE_GROUPS(max6639);
>
>  /*
> - *  returns respective index in rpm_ranges table
> - *  1 by default on invalid range
> + *  Get respective index in rpm_ranges table
>   */
> -static int rpm_range_to_reg(int range)
> +static int rpm_range_to_index(u8 *index, int range)
>  {
>         int i;
>
>         for (i = 0; i < ARRAY_SIZE(rpm_ranges); i++) {
> -               if (rpm_ranges[i] == range)
> -                       return i;
> +               if (rpm_ranges[i] == range) {
> +                       *index = i;
> +                       return 0;
> +               }
>         }
>
> -       return 1; /* default: 4000 RPM */
> +       return -EINVAL;
>  }
>
>  static int max6639_init_client(struct i2c_client *client,
>                                struct max6639_data *data)
>  {
> -       struct max6639_platform_data *max6639_info =
> -               dev_get_platdata(&client->dev);
>         int i;
> -       int rpm_range = 1; /* default: 4000 RPM */
>         int err;
>
>         /* Reset chip to default values, see below for GCONFIG setup */
> @@ -416,43 +414,25 @@ static int max6639_init_client(struct i2c_client *client,
>         if (err)
>                 goto exit;
>
> -       /* Fans pulse per revolution is 2 by default */
> -       if (max6639_info && max6639_info->ppr > 0 &&
> -                       max6639_info->ppr < 5)
> -               data->ppr = max6639_info->ppr;
> -       else
> -               data->ppr = 2;
> -       data->ppr -= 1;
> -
> -       if (max6639_info)
> -               rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
> -       data->rpm_range = rpm_range;
> -
>         for (i = 0; i < 2; i++) {
>
>                 /* Set Fan pulse per revolution */
>                 err = i2c_smbus_write_byte_data(client,
>                                 MAX6639_REG_FAN_PPR(i),
> -                               data->ppr << 6);
> +                               data->ppr[i] << 6);
>                 if (err)
>                         goto exit;
>
>                 /* Fans config PWM, RPM */
>                 err = i2c_smbus_write_byte_data(client,
>                         MAX6639_REG_FAN_CONFIG1(i),
> -                       MAX6639_FAN_CONFIG1_PWM | rpm_range);
> +                       MAX6639_FAN_CONFIG1_PWM | data->rpm_range[i]);
>                 if (err)
>                         goto exit;
>
> -               /* Fans PWM polarity high by default */
> -               if (max6639_info && max6639_info->pwm_polarity == 0)
> -                       err = i2c_smbus_write_byte_data(client,
> -                               MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> -               else
> -                       err = i2c_smbus_write_byte_data(client,
> -                               MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> -               if (err)
> -                       goto exit;
> +               /* Fans PWM polarity */
> +               err = i2c_smbus_write_byte_data(client,
> +                       MAX6639_REG_FAN_CONFIG2a(i), data->pwm_polarity[i] ? 0x00 : 0x02);
>
>                 /*
>                  * /THERM full speed enable,
> @@ -464,10 +444,6 @@ static int max6639_init_client(struct i2c_client *client,
>                 if (err)
>                         goto exit;
>
> -               /* Max. temp. 80C/90C/100C */
> -               data->temp_therm[i] = 80;
> -               data->temp_alert[i] = 90;
> -               data->temp_ot[i] = 100;
>                 err = i2c_smbus_write_byte_data(client,
>                                 MAX6639_REG_THERM_LIMIT(i),
>                                 data->temp_therm[i]);
> @@ -483,8 +459,6 @@ static int max6639_init_client(struct i2c_client *client,
>                 if (err)
>                         goto exit;
>
> -               /* PWM 120/120 (i.e. 100%) */
> -               data->pwm[i] = 120;
>                 err = i2c_smbus_write_byte_data(client,
>                                 MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
>                 if (err)
> @@ -524,12 +498,87 @@ static void max6639_regulator_disable(void *data)
>         regulator_disable(data);
>  }
>
> +static int max6639_probe_child_from_dt(struct i2c_client *client,
> +                                     struct device_node *child,
> +                                     struct max6639_data *data)
> +
> +{
> +       struct device *dev = &client->dev;
> +       u32 i, val;
> +       int err;
> +
> +       err = of_property_read_u32(child, "reg", &i);
> +       if (err) {
> +               dev_err(dev, "missing reg property of %pOFn\n", child);
> +               return err;
> +       }
> +
> +       if (i >= 2) {
> +               dev_err(dev, "invalid reg %d of %pOFn\n", i, child);
> +               return -EINVAL;
> +       }
> +
> +       err = of_property_read_u32(child, "pulses-per-revolution", &val);
> +       if (!err) {
> +               if (val < 0 || val > 5) {
> +                       dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val, child);
> +                       return -EINVAL;
> +               }
> +               data->ppr[i] = val;
> +       }
> +
> +       err = of_property_read_u32(child, "maxim,rpm-range", &val);
> +       if (!err) {
> +               err = rpm_range_to_index(&data->rpm_range[i], val);
> +               if (err) {
> +                       dev_err(dev, "invalid maxim,rpm-range %d of %pOFn\n", val, child);
> +                       return err;
> +               }
> +       }
> +
> +       err = of_property_read_u32(child, "pwm-polarity", &val);
> +       if (!err) {
> +               if (val > 1) {
> +                       dev_err(dev, "invalid pwm-polarity %d of %pOFn\n", val, child);
> +                       return -EINVAL;
> +               }
> +               data->pwm_polarity[i] = val;
> +       }
> +
> +       return 0;
> +}
> +
> +static int max6639_probe_from_dt(struct i2c_client *client, struct max6639_data *data)
> +{
> +       struct device *dev = &client->dev;
> +       const struct device_node *np = dev->of_node;
> +       struct device_node *child;
> +       int err;
> +
> +       /* Compatible with non-DT platforms */
> +       if (!np)
> +               return 0;
> +
> +       for_each_child_of_node(np, child) {
> +               if (strcmp(child->name, "channel"))

According to the dt-binding this should be "fan" instead of "channel".

> +                       continue;
> +
> +               err = max6639_probe_child_from_dt(client, child, data);
> +               if (err) {
> +                       of_node_put(child);
> +                       return err;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int max6639_probe(struct i2c_client *client)
>  {
>         struct device *dev = &client->dev;
>         struct max6639_data *data;
>         struct device *hwmon_dev;
> -       int err;
> +       int err, i;
>
>         data = devm_kzalloc(dev, sizeof(struct max6639_data), GFP_KERNEL);
>         if (!data)
> @@ -560,6 +609,24 @@ static int max6639_probe(struct i2c_client *client)
>
>         mutex_init(&data->update_lock);
>
> +       /* default values */
> +       for (i = 0; i < 2; i++) {
> +               /* 4000 RPM */
> +               data->rpm_range[i] = 1;
> +               data->ppr[i] = 2;
> +               data->pwm_polarity[i] = 1;
> +               /* Max. temp. 80C/90C/100C */
> +               data->temp_therm[i] = 80;
> +               data->temp_alert[i] = 90;
> +               data->temp_ot[i] = 100;
> +               /* PWM 120/120 (i.e. 100%) */
> +               data->pwm[i] = 120;
> +       }
> +
> +       err = max6639_probe_from_dt(client, data);
> +       if (err)
> +               return err;
> +
>         /* Initialize the max6639 chip */
>         err = max6639_init_client(client, data);
>         if (err < 0)
> @@ -618,6 +685,14 @@ static const struct i2c_device_id max6639_id[] = {
>
>  MODULE_DEVICE_TABLE(i2c, max6639_id);
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id maxim_of_platform_match[] = {
> +       {.compatible = "maxim,max6639"},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, maxim_of_platform_match);
> +#endif
> +
>  static SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
>
>  static struct i2c_driver max6639_driver = {
> @@ -625,6 +700,7 @@ static struct i2c_driver max6639_driver = {
>         .driver = {
>                    .name = "max6639",
>                    .pm = &max6639_pm_ops,
> +                  .of_match_table = of_match_ptr(maxim_of_platform_match),
>                    },
>         .probe_new = max6639_probe,
>         .id_table = max6639_id,
> diff --git a/include/linux/platform_data/max6639.h b/include/linux/platform_data/max6639.h
> deleted file mode 100644
> index 65bfdb4fdc15..000000000000
> --- a/include/linux/platform_data/max6639.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_MAX6639_H
> -#define _LINUX_MAX6639_H
> -
> -#include <linux/types.h>
> -
> -/* platform data for the MAX6639 temperature sensor and fan control */
> -
> -struct max6639_platform_data {
> -       bool pwm_polarity;      /* Polarity low (0) or high (1, default) */
> -       int ppr;                /* Pulses per rotation 1..4 (default == 2) */
> -       int rpm_range;          /* 2000, 4000 (default), 8000 or 16000 */
> -};
> -
> -#endif /* _LINUX_MAX6639_H */
> --
> 2.35.3
>
