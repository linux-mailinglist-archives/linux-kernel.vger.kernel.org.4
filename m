Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14466E011
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjAQOMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjAQOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:12:28 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287093BDAD;
        Tue, 17 Jan 2023 06:12:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b17so26144178pld.7;
        Tue, 17 Jan 2023 06:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8T4Av5sluJXt+Zl2bdIPegxIz0+hLbjYRZdYk7XDGIo=;
        b=WLEO7Th9M7wacwYtjCLpc3JYdhQFdVS42gtPjG6oOxsVlEO08+qAZMULbFLitKE9jS
         uorch4XhqoxWtGNtEzpG+Tk4wdZVyjc3sZQKY28/RfNXn+UZrWIadSbXk/OPaEYDq4ua
         cwi8aE2Mav7AePz5SDV7yDtYAoIMjb9bKKArOUV4wDI69HsX6P/K3+jmzxDysVT7mO9Y
         gWYDHC6Mr0lkL6Gp97L+26uu+pXP4mE4OP0E4+62segsd/W6Zs0oVb13IIYmOz7VgCs/
         XWW3nj2pKSsMN/wZ8heiCKOESNdw/08sIW0byi+djTpqSOFNqu3WRgPMfbBH4bMvRTSY
         at8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T4Av5sluJXt+Zl2bdIPegxIz0+hLbjYRZdYk7XDGIo=;
        b=TpzGF/ocvQBhsuzyg0jWvgE0uvxqQqGTFJehw9lTZTaeN3xBce567eVHQmID7oHQ47
         eG8XCB32PMmsA4JMHf52A7IF+ceUWXh9dF0J3MVDdDCcRhMayNjITi2DfE7bQomdgSsX
         NkAi+cwPxViBFrY7MdZIGIcTzjE1vi0cqUsGS7+isGsR5Ei2d7Q5KP/3Pa9gwTLzP4kd
         1Pg19uyvfCNjVGuuA6gia/CTwgtKKql47Yp+AbKRParM9NJ5RcWqF/+U++9DyqhMSj71
         kMhjTJIu3oBeNyEP/Tz3n0xiLHg9b5TszRDvZzVczNDNbjXdp3+qxy3F7zJ6ftQ6/sO+
         slyQ==
X-Gm-Message-State: AFqh2kpk7vHpDhcIcm75X3zPiGrhcf97lL8WCBPF95uJV7uNoAFmC6+p
        qRwlUIx8z05Wv5J5Ss1kHQM=
X-Google-Smtp-Source: AMrXdXvjPZ4+K3rTIHbVhAtJHf/mCvGL3OX5C4i1w+MiifTVKhkdhykYIlj1Is6/bo5W0NeKrOIpJQ==
X-Received: by 2002:a17:90b:1b4f:b0:226:d23b:8037 with SMTP id nv15-20020a17090b1b4f00b00226d23b8037mr2859651pjb.33.1673964746685;
        Tue, 17 Jan 2023 06:12:26 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a118200b0022966311621sm4147654pja.28.2023.01.17.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:12:26 -0800 (PST)
Date:   Tue, 17 Jan 2023 22:12:18 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 1/2] backlight: ktz8866: Add support for Kinetic
 KTZ8866 backlight
Message-ID: <Y8aswmc8dkzM+RsB@Gentoo>
References: <20230117134742.23238-1-lujianhua000@gmail.com>
 <Y8aq1aJd8QJCo3RU@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8aq1aJd8QJCo3RU@aspen.lan>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:04:05PM +0000, Daniel Thompson wrote:
> On Tue, Jan 17, 2023 at 09:47:41PM +0800, Jianhua Lu wrote:
> > Add support for Kinetic KTZ8866 backlight, which is used in
> > Xiaomi tablet, Mi Pad 5 series. This driver lightly based on
> > downstream implementation [1].
> > [1] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/elish-r-oss/drivers/video/backlight/ktz8866.c
> >
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > Changes in v2:
> >   - Add missing staitc modifier to ktz8866_write function.
> >
> > Changes in v3:
> >   - Add 2022 to Copyright line.
> >   - Sort headers.
> >   - Remove meaningless comment.
> >   - Use definitions instead of hardcoding.
> >   - Add missing maintainer info.
> >
> > Changes in v4:
> >   - Change 2022 to 2023.
> >   - Remove useless macro and enum.
> >   - Describe settings by devicetree.
> >   - Move header file to C file.
> >
> >  MAINTAINERS                       |   6 +
> >  drivers/video/backlight/Kconfig   |   8 ++
> >  drivers/video/backlight/Makefile  |   1 +
> >  drivers/video/backlight/ktz8866.c | 195 ++++++++++++++++++++++++++++++
> >  4 files changed, 210 insertions(+)
> >  create mode 100644 drivers/video/backlight/ktz8866.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 42fc47c6edfd..2084e74e1b58 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11674,6 +11674,12 @@ M:	John Hawley <warthog9@eaglescrag.net>
> >  S:	Maintained
> >  F:	tools/testing/ktest
> >
> > +KTZ8866 BACKLIGHT DRIVER
> > +M:	Jianhua Lu <lujianhua000@gmail.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > +F:	drivers/video/backlight/ktz8866.c
> > +
> >  L3MDEV
> >  M:	David Ahern <dsahern@kernel.org>
> >  L:	netdev@vger.kernel.org
> > diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> > index 936ba1e4d35e..2845fd7e33ad 100644
> > --- a/drivers/video/backlight/Kconfig
> > +++ b/drivers/video/backlight/Kconfig
> > @@ -190,6 +190,14 @@ config BACKLIGHT_KTD253
> >  	  which is a 1-wire GPIO-controlled backlight found in some mobile
> >  	  phones.
> >
> > +config BACKLIGHT_KTZ8866
> > +	tristate "Backlight Driver for Kinetic KTZ8866"
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	help
> > +		Say Y to enabled the backlight driver for the Kinetic KTZ8866
> > +		found in Xiaomi Mi Pad 5 series.
> > +
> >  config BACKLIGHT_LM3533
> >  	tristate "Backlight Driver for LM3533"
> >  	depends on MFD_LM3533
> > diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> > index e815f3f1deff..f70a819c304c 100644
> > --- a/drivers/video/backlight/Makefile
> > +++ b/drivers/video/backlight/Makefile
> > @@ -36,6 +36,7 @@ obj-$(CONFIG_BACKLIGHT_HP680)		+= hp680_bl.o
> >  obj-$(CONFIG_BACKLIGHT_HP700)		+= jornada720_bl.o
> >  obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
> >  obj-$(CONFIG_BACKLIGHT_KTD253)		+= ktd253-backlight.o
> > +obj-$(CONFIG_BACKLIGHT_KTZ8866)		+= ktz8866.o
> >  obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
> >  obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
> >  obj-$(CONFIG_BACKLIGHT_LM3639)		+= lm3639_bl.o
> > diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
> > new file mode 100644
> > index 000000000000..98916f92d069
> > --- /dev/null
> > +++ b/drivers/video/backlight/ktz8866.c
> > @@ -0,0 +1,195 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Backlight driver for the Kinetic KTZ8866
> > + *
> > + * Copyright (C) 2023 Jianhua Lu <lujianhua000@gmail.com>
> 
> Shouldn't this be:
> Copyright (C) 2022, 2023 Jianhua Lu <lujianhua000@gmail.com>
> 
> > +static int ktz8866_probe(struct i2c_client *client,
> > +			 const struct i2c_device_id *id)
> > +{
> > +	struct backlight_device *backlight_dev;
> > +	struct backlight_properties props;
> > +	struct ktz8866 *ktz;
> > +
> > +	ktz = devm_kzalloc(&client->dev, sizeof(*ktz), GFP_KERNEL);
> > +	if (!ktz)
> > +		return -ENOMEM;
> > +
> > +	ktz->client = client;
> > +	ktz->regmap = devm_regmap_init_i2c(client, &ktz8866_regmap_config);
> > +
> > +	if (IS_ERR(ktz->regmap)) {
> > +		dev_err(&client->dev, "failed to init regmap\n");
> > +		return PTR_ERR(ktz->regmap);
> > +	}
> > +
> > +	memset(&props, 0, sizeof(props));
> > +	props.type = BACKLIGHT_RAW;
> > +	props.max_brightness = MAX_BRIGHTNESS;
> > +	props.brightness = DEFAULT_BRIGHTNESS;
> 
> There is still pending feedback from v3.
> 
> | Please set the scale property correctly. "Unknown" is never correct for
> | new drivers.
Do you means backlight_properties.backlight_scale?
> 
> Do not ignore feedback. You should either act on it or, if you disagree
> or need additional clarification then, reply on the mail thread.
> 
> 
> Daniel.
