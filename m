Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B26B02CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjCHJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjCHJYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:24:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839DFA17F0;
        Wed,  8 Mar 2023 01:23:59 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ec29so32142375edb.6;
        Wed, 08 Mar 2023 01:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678267438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDrNWFI668GD0hnej03xw5wrA2ehb8uxzEH/VH608bc=;
        b=WWUXmy11KRg3Y9ocgjf6+kaMCvpWsm1AD55PYIG1Nnb9vv2vvdZB99P89xhsOUaK24
         /Y4Oy5lyM5Q/8tHdbIvhiAiZTdDwYuofjpD+UPKqwAitN90a0Cw6tUwt+boGWjcF5ay1
         r3uvCt1uAgV6codhBt1JWgNXUmQJHNYeUI3g2HwmGciClIs2wGuukluuNbrG47lhxSvb
         8xrS62W3aY8Saa5pli6zhsOy04kYX/D/k7boaR3B24/bXnHG101UzPIrA6+r+3ygZWZH
         sZRe9XVCSqfxOj0LAE1/Vc0zt7fvLIPp1lGO87IirRUI2irQ7RcyuBrPoQ0JqjLehan8
         Jw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678267438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDrNWFI668GD0hnej03xw5wrA2ehb8uxzEH/VH608bc=;
        b=FkF/2vlAes2GjuQKCbWSnQG5AVCciGEAJ/AWqKa1AI663GVuNlJhI1LxwrpDZVKH11
         xsW7fC5HYzTWpiXxbEAerrVwq3SmO38vIL75MLd7ZXj4WAEMgWSb4mOg5Sg7AToSRBPH
         BX0QZ+1AbdRtxu29PPFn85URcfJjvHaDqrP0PEA19LASBKCwtvr21icAMKqoEjAl2bKh
         NQAnEx+bIbzrGhnfq60toc0hJ+8nngxfXgmelEL4R6x5NVVkpN4G2Di19JkfH6HVf9y7
         i1D9xOqTkkfqYVyxAFReMXKY/BX9/iiSByzNaMUMqLV/IWC9UHFUUmPULPMQ4B665VqF
         cjTQ==
X-Gm-Message-State: AO0yUKUMA43AQD+xe8ugkPcW5L8RVTskVejCCdV7kme3Thgm6cPxexhQ
        wTQRGYCbqyBMo32RiKry7XGiWwKZ5CRCYqcb2qHOAMlCqks=
X-Google-Smtp-Source: AK7set++oYRF40WedQZ6ojGmG/FH1iT/MTSIZRr49bD9esqX8F65/q+8irUkZWmgB9gJFQmt/yR6D2wvx6t6Awuhtlo=
X-Received: by 2002:a17:907:ca29:b0:882:cdb5:4e60 with SMTP id
 uk41-20020a170907ca2900b00882cdb54e60mr8742615ejc.11.1678267437991; Wed, 08
 Mar 2023 01:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20230308084419.11934-1-clamor95@gmail.com> <20230308084419.11934-5-clamor95@gmail.com>
 <c04d4306-de81-363c-2d2e-60f5283a5249@linaro.org>
In-Reply-To: <c04d4306-de81-363c-2d2e-60f5283a5249@linaro.org>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 8 Mar 2023 11:23:27 +0200
Message-ID: <CAPVz0n0DNpn7uO+2X9QREpdc51R--ogsLSXWTyL1TybDsO2GvQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] power: max17040: get thermal data from adc if available
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 11:08 Krzys=
ztof Kozlowski
<krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 08/03/2023 09:44, Svyatoslav Ryhel wrote:
> > Since fuel gauge does not support thermal monitoring,
> > some vendors may couple this fuel gauge with thermal/adc
> > sensor to monitor battery cell exact temperature.
> >
> > Add this feature by adding optional iio thermal channel.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/power/supply/max17040_battery.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/su=
pply/max17040_battery.c
> > index 6dfce7b1309e..8c743c26dc6e 100644
> > --- a/drivers/power/supply/max17040_battery.c
> > +++ b/drivers/power/supply/max17040_battery.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> > +#include <linux/iio/consumer.h>
> >
> >  #define MAX17040_VCELL       0x02
> >  #define MAX17040_SOC 0x04
> > @@ -143,6 +144,7 @@ struct max17040_chip {
> >       struct power_supply             *battery;
> >       struct power_supply_battery_info        *batt_info;
> >       struct chip_data                data;
> > +     struct iio_channel              *channel_temp;
> >
> >       /* battery capacity */
> >       int soc;
> > @@ -416,6 +418,11 @@ static int max17040_get_property(struct power_supp=
ly *psy,
> >       case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> >               val->intval =3D chip->batt_info->charge_full_design_uah;
> >               break;
> > +     case POWER_SUPPLY_PROP_TEMP:
> > +             iio_read_channel_raw(chip->channel_temp,
> > +                                  &val->intval);
> > +             val->intval *=3D 10;
>
> I am not convinced this is needed at all. You basically chain two
> subsystems only to report to user-space via power supply, but it is
> already reported via IIO. I would understand it if you use the value for
> something, e.g. control the charger. Here, it's just feeding different
> user-space interface. Therefore:
> 1. IO channels are not a hardware property of the fuel gauge,
> 2. I have doubts this should be even exposed via power supply interface.
>

I can assure you that this is only the beginning of weird vendor solutions
I have discovered. Nonetheless, max17040 has no battery temp property,
this means in case I have a critical battery overheating, userspace
will tell me nothing
since instead of having direct battery temp property under power supply I h=
ave
separate iio sensor, which may not even be monitored. It is always nice to =
have
battery explosions.

>
> Best regards,
> Krzysztof
>
