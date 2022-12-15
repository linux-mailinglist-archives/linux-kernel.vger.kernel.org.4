Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F15E64E1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiLOTmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLOTmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:42:51 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF3F511CD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:42:50 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id q22so4140uap.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rHbX/9pdBJCPlt7rLakm1ev9LsnGgN+B441Y+SBJEk8=;
        b=aJ3GMKFqDC48dhp8Uw9nYA+3LagpHlHlbDIPFSDppkD3MUupJWTbsN2V/+/JlnRdNq
         zBFmm+mKBU//o0lzhzU3I5MaZXwX7Wt6/IPLcdSKzRMmZ1u2ayvOVTvB1+9A97gWPdgI
         S9ojuGJSFTxmRYRgj5lvwNjSbfXh6cMtM4wEPRrYMXLDcUHsoD9HFOlYiWUMQTEoo5o0
         LvLdt5kwzBWIhgVoDw3bi4J5XpWnDHkMQVAAc4mGRXPfRQVbY0YkKy9R9k/nKpeBO7XO
         W+UaRMSazHpPDPQbDy+NA+wUIVEf6AKZfOgaFLNZMJDmAinPgV7BTT9Hy7Q+WhHNy8qt
         PXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHbX/9pdBJCPlt7rLakm1ev9LsnGgN+B441Y+SBJEk8=;
        b=ZgSv0xRIg0o0fO19tltki+s/3xDRPbdSyG1Efv49fXb9169RyJTkvdRizPIMNqldJU
         Eoyc3KIZkcvf4MvW4kWyftMhUTUZz3HWInq5+AZSwQqtDUF1HO02sAEa2snjKbe5+9NL
         CZu6b1qt1LpRlod0F8H6ucUqmuLn8/P6a6+Rnjcu8hooq7j1ja/VQUJafNtp9UnlLlhk
         7nVsZI5z2tafZqSXQSswq+A9GtknHwNbk2skP/FYMuuHlgJ+BxFZJWczfGDnLRe/Ma9j
         LuOTVJs+VAD8QyBSaVPQwWUarqdb/B15dqmKd7JppP6BvSR21b/4pWP7i6oOy1g5Jmxu
         NHLg==
X-Gm-Message-State: ANoB5plNxksKqleMXuOUD+IpjCQyhDwFZhtYTOGxzGAQTFX6novfHluc
        oFaxJxNL6gERF8sdrnDCSxbTLPi61xkJbTpKlFCDTQ==
X-Google-Smtp-Source: AA0mqf7eDQsajaexQCaers4ICvmKfL+VhgYzE8A+KZB37B6hUYayyyaAqmeHEhL18zOMmt3E9wysFS3e439XDRKF5qE=
X-Received: by 2002:ab0:6845:0:b0:423:5afb:644a with SMTP id
 a5-20020ab06845000000b004235afb644amr2991841uas.121.1671133369248; Thu, 15
 Dec 2022 11:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221214220727.1350784-3-jcormier@criticallink.com> <601ddc9c-66a8-0ab4-69ef-ba4e9c0f9420@roeck-us.net>
In-Reply-To: <601ddc9c-66a8-0ab4-69ef-ba4e9c0f9420@roeck-us.net>
From:   Jon Cormier <jcormier@criticallink.com>
Date:   Thu, 15 Dec 2022 14:42:38 -0500
Message-ID: <CADL8D3b2U6xdcsa4CySgvFJMHPF6sOPZQuA-tZO9NHtamVPCxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hwmon: ltc2945: Allow setting shunt resistor
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        John Pruitt <jpruitt@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:11 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/14/22 14:07, Cormier, Jonathan wrote:
> > From: John Pruitt <jpruitt@criticallink.com>
> >
> > Added the ability to specify the value of the shunt resistor in the
> > device tree instead of assuming it is 1 milliOhm. The value in the
> > device tree has the name shunt-resistor-micro-ohms and the
> > default value is 1000 micro-ohms in order to preserve the
> > current behavior.
> >
>
> Also needs a devicetree match table.
On it
>
> > Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
> > Signed-off-by: John Pruitt <jpruitt@criticallink.com>
> > ---
> >   drivers/hwmon/ltc2945.c | 86 +++++++++++++++++++++++++++++++----------
> >   1 file changed, 65 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> > index 9adebb59f604..4e8b92e53133 100644
> > --- a/drivers/hwmon/ltc2945.c
> > +++ b/drivers/hwmon/ltc2945.c
> > @@ -58,6 +58,11 @@
> >   #define CONTROL_MULT_SELECT (1 << 0)
> >   #define CONTROL_TEST_MODE   (1 << 4)
> >
> > +struct ltc2945_data {
> > +     struct regmap *regmap;
> > +     u32 shunt_resistor; // number of microohms
>
> No C++ comments in this code, please. Also, "number of" is not needed.
> Something like "in microohms" or just "microohms" would be sufficient.
>
> > +};
> > +
> >   static inline bool is_power_reg(u8 reg)
> >   {
> >       return reg < LTC2945_SENSE_H;
> > @@ -66,7 +71,9 @@ static inline bool is_power_reg(u8 reg)
> >   /* Return the value from the given register in uW, mV, or mA */
> >   static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >   {
> > -     struct regmap *regmap = dev_get_drvdata(dev);
> > +     struct ltc2945_data *data = dev_get_drvdata(dev);
> > +     struct regmap *regmap = data->regmap;
> > +     u32 shunt_resistor = data->shunt_resistor;
> >       unsigned int control;
> >       u8 buf[3];
> >       long long val;
> > @@ -93,8 +100,11 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >       case LTC2945_MIN_POWER_THRES_H:
> >               /*
> >                * Convert to uW by assuming current is measured with
> > -              * an 1mOhm sense resistor, similar to current
> > -              * measurements.
> > +              * a 1000 microOhm sense resistor (aka shunt resistor)
> > +              * or what is specified in DT, similar to current
> > +              * measurements. The shunt_resistor value is in
> > +              * microOhms.
>
> The units are already in the variable declaration. No need to repeat.
> There is no need to replace "1 mOhm" with "1000 microOhm".
>
> It might make sense to drop all those comments, add a kerneldoc comment
> to struct ltc2945_data, and explain it all there.
Will do
>
> > +              *
> >                * Control register bit 0 selects if voltage at SENSE+/VDD
> >                * or voltage at ADIN is used to measure power.
> >                */
> > @@ -108,6 +118,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >                       /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> >                       val = (val * 25LL) >> 1;
> >               }
> > +             val *= 1000;
> > +             val = DIV_ROUND_CLOSEST_ULL(val, shunt_resistor);
> >               break;
> >       case LTC2945_VIN_H:
> >       case LTC2945_MAX_VIN_H:
> > @@ -132,12 +144,15 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >       case LTC2945_MIN_SENSE_THRES_H:
> >               /*
> >                * 25 uV resolution. Convert to current as measured with
> > -              * an 1 mOhm sense resistor, in mA. If a different sense
> > -              * resistor is installed, calculate the actual current by
> > -              * dividing the reported current by the sense resistor value
> > -              * in mOhm.
> > +              * an 1000 microOhm sense (or shunt) resistor, in mA.
> > +              * If a different shunt resistor is installed, calculate
> > +              * the actual current by dividing the reported current
> > +              * by the shunt resistor value in microOhms. The actual
> > +              * The actual shunt resistor value can be specified
> > +              * in the device tree.
>
> All but the last sentence just replace 1 mOhm with 1000 microOhm, which
> does not add any value. Applies to all similar changes; I won't comment
> on it anymore below.
>
> >                */
> > -             val *= 25;
> > +             val *= 25 * 1000;
> > +             val = DIV_ROUND_CLOSEST_ULL(val, shunt_resistor);
> >               break;
> >       default:
> >               return -EINVAL;
> > @@ -148,7 +163,9 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >   static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >                             unsigned long val)
> >   {
> > -     struct regmap *regmap = dev_get_drvdata(dev);
> > +     struct ltc2945_data *data = dev_get_drvdata(dev);
> > +     struct regmap *regmap = data->regmap;
> > +     u32 shunt_resistor = data->shunt_resistor;
> >       unsigned int control;
> >       int ret;
> >
> > @@ -160,8 +177,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >       case LTC2945_MIN_POWER_THRES_H:
> >               /*
> >                * Convert to register value by assuming current is measured
> > -              * with an 1mOhm sense resistor, similar to current
> > +              * with a 1000 microOhm sense resistor, (aka shunt resistor)
> > +              * or what is specified in DT, similar to current
> >                * measurements.
> > +              *
> >                * Control register bit 0 selects if voltage at SENSE+/VDD
> >                * or voltage at ADIN is used to measure power, which in turn
> >                * determines register calculations.
> > @@ -171,14 +190,16 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >                       return ret;
> >               if (control & CONTROL_MULT_SELECT) {
> >                       /* 25 mV * 25 uV = 0.625 uV resolution. */
> > -                     val = DIV_ROUND_CLOSEST(val, 625);
> > +                     val *= shunt_resistor;
>
> This can now easily result in an overflow.
Okay will fix
>
> > +                     val = DIV_ROUND_CLOSEST(val, 625 * 1000);
> >               } else {
> >                       /*
> >                        * 0.5 mV * 25 uV = 0.0125 uV resolution.
> >                        * Divide first to avoid overflow;
> >                        * accept loss of accuracy.
> >                        */
> > -                     val = DIV_ROUND_CLOSEST(val, 25) * 2;
> > +                     val *= shunt_resistor;
> > +                     val = DIV_ROUND_CLOSEST(val, 25 * 1000) * 2;
> >               }
> >               break;
> >       case LTC2945_VIN_H:
> > @@ -204,12 +225,14 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >       case LTC2945_MIN_SENSE_THRES_H:
> >               /*
> >                * 25 uV resolution. Convert to current as measured with
> > -              * an 1 mOhm sense resistor, in mA. If a different sense
> > -              * resistor is installed, calculate the actual current by
> > -              * dividing the reported current by the sense resistor value
> > -              * in mOhm.
> > +              * a 1000 microOhm sense (or shunt) resistor, in mA. If
> > +              * a different shunt resistor is installed, calculate
> > +              * the actual current by dividing the reported current
> > +              * by the sense resistor value in microOhms. The actual
> > +              * shunt resistor value can be specified in the device tree.
> >                */
> > -             val = DIV_ROUND_CLOSEST(val, 25);
> > +             val *= shunt_resistor;
>
> Needs to ensure that there are no overflows. Try to write the maximum value
> for unsigned long and see what happens.
>
> > +             val = DIV_ROUND_CLOSEST(val, 25 * 1000);
> >               break;
> >       default:
> >               return -EINVAL;
> > @@ -234,7 +257,8 @@ static ssize_t ltc2945_value_store(struct device *dev,
> >                                  const char *buf, size_t count)
> >   {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > -     struct regmap *regmap = dev_get_drvdata(dev);
> > +     struct ltc2945_data *data = dev_get_drvdata(dev);
> > +     struct regmap *regmap = data->regmap;
> >       u8 reg = attr->index;
> >       unsigned long val;
> >       u8 regbuf[3];
> > @@ -269,7 +293,8 @@ static ssize_t ltc2945_history_store(struct device *dev,
> >                                    const char *buf, size_t count)
> >   {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > -     struct regmap *regmap = dev_get_drvdata(dev);
> > +     struct ltc2945_data *data = dev_get_drvdata(dev);
> > +     struct regmap *regmap = data->regmap; >         u8 reg = attr->index;
> >       int num_regs = is_power_reg(reg) ? 3 : 2;
> >       u8 buf_min[3] = { 0xff, 0xff, 0xff };
> > @@ -321,7 +346,8 @@ static ssize_t ltc2945_bool_show(struct device *dev,
> >                                struct device_attribute *da, char *buf)
> >   {
> >       struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > -     struct regmap *regmap = dev_get_drvdata(dev);
> > +     struct ltc2945_data *data = dev_get_drvdata(dev);
> > +     struct regmap *regmap = data->regmap;
> >       unsigned int fault;
> >       int ret;
> >
> > @@ -450,6 +476,14 @@ static int ltc2945_probe(struct i2c_client *client)
> >       struct device *dev = &client->dev;
> >       struct device *hwmon_dev;
> >       struct regmap *regmap;
> > +     u32 shunt_resistor;
> > +
> drop this empty line
>
> > +     struct ltc2945_data *data;
> > +
> > +     data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +     dev_set_drvdata(dev, data);
> >
> >       regmap = devm_regmap_init_i2c(client, &ltc2945_regmap_config);
> >       if (IS_ERR(regmap)) {
> > @@ -457,11 +491,21 @@ static int ltc2945_probe(struct i2c_client *client)
> >               return PTR_ERR(regmap);
> >       }
> >
> > +     data->regmap = regmap;
> > +     if (of_property_read_u32(client->dev.of_node,
> > +                              "shunt-resistor-micro-ohms", &shunt_resistor))
>
> Please consider using device_property_read_u32().
>
> > +             shunt_resistor = 1000; /* 1000 micro-Ohm if not set via DT */
>
> "if not set via DT" -> "default value". With device_property_read_u32(),
> this can be set by other means, not just DT.
>
> > +
> > +     if (shunt_resistor == 0)
> > +             return -EINVAL;
> > +
> > +     data->shunt_resistor = shunt_resistor;
> > +
> >       /* Clear faults */
> >       regmap_write(regmap, LTC2945_FAULT, 0x00);
> >
> >       hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> > -                                                        regmap,
> > +                                                        data,
> >                                                          ltc2945_groups);
> >       return PTR_ERR_OR_ZERO(hwmon_dev);
> >   }
>


-- 
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
