Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6779066DFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjAQOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjAQOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:04:10 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4038EAB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:04:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r2so30682723wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y4LXP+MvmQsKOsJ5hed0UZC24OVAbgZXP4avzgJImfo=;
        b=opFgH3H9FQHOvkzBbVCJtTAWCFhR4Gl5cpi5yVHXNLW4da+cPYgoa34+Yc5btwsON6
         wAFkWy9rpieA3cmX4wsInZCIhTwJyh4pf0ch+AlCuup/auiH2i2TrLh5sqb9j/Hod/Lz
         WFM9X0msAR+amngpn9QrYSrXPiEFSTRc6ek40te5liqS/P46vGr52CTA6lftavMtiHgY
         PPOdyZ/VhU/H812UoNX++Ky93zdzjsBhROMSZ+EgdH/K7S0UOuteh68xzTo2RX104+TW
         usKWw3EHHG1EXoAnUSZfbfjDh5z6fU8a1bp61o5K/dIGqEyCrgzJMPSwqrswaFBiw6Vt
         HeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4LXP+MvmQsKOsJ5hed0UZC24OVAbgZXP4avzgJImfo=;
        b=VP/ARs9YEt0O8FPDPXMqCyMzYvezeoneCHA7zdju8KAKmK17MJgmWGNyoXb78yKkl9
         9ZvqxrL85sQm8Lcnr8s5wzxR4tGnmMErUSkOM6LIhif2Z7/kxIj0Ap7D1h+wbOmwDxOx
         7d0v1mRgtx9OtqhGVCZ9016F0J5aZdk2hLhT1X1EuOPWGCkkP11dx9dvX3MKcJYB1ec1
         b/ku7ENJtB/rrLit39pxk8uOeuZZOxZ7B+NWYAzuXPnHmkLqXAIvTldA7HM2fWfwMAVm
         IffnyRKGYAws6+a5vp6Z75mcJ2Pz2Ndy3Q9ec6A4ylzNhbWI6Clc7x1ihIX12l1+YgKC
         8QBQ==
X-Gm-Message-State: AFqh2krXNbVim+CxoL7by0nHQxEamIG2FW+JVzFqsij94s73XcxWGiTm
        xaJM5xYT7IJZt0/v14OmiTn9dw==
X-Google-Smtp-Source: AMrXdXvgQIsKAuGnrCo5SfyGi1kiUlgYMiOXbXCSkybN7DpkVs2OGedhHFnEkAHf5h4Swg1d0vCHsw==
X-Received: by 2002:adf:e841:0:b0:2b9:d6ba:21f1 with SMTP id d1-20020adfe841000000b002b9d6ba21f1mr2885264wrn.21.1673964247673;
        Tue, 17 Jan 2023 06:04:07 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m15-20020adffe4f000000b002bdd155ca4dsm14561248wrs.48.2023.01.17.06.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:04:07 -0800 (PST)
Date:   Tue, 17 Jan 2023 14:04:05 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 1/2] backlight: ktz8866: Add support for Kinetic
 KTZ8866 backlight
Message-ID: <Y8aq1aJd8QJCo3RU@aspen.lan>
References: <20230117134742.23238-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117134742.23238-1-lujianhua000@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:47:41PM +0800, Jianhua Lu wrote:
> Add support for Kinetic KTZ8866 backlight, which is used in
> Xiaomi tablet, Mi Pad 5 series. This driver lightly based on
> downstream implementation [1].
> [1] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/elish-r-oss/drivers/video/backlight/ktz8866.c
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> Changes in v2:
>   - Add missing staitc modifier to ktz8866_write function.
>
> Changes in v3:
>   - Add 2022 to Copyright line.
>   - Sort headers.
>   - Remove meaningless comment.
>   - Use definitions instead of hardcoding.
>   - Add missing maintainer info.
>
> Changes in v4:
>   - Change 2022 to 2023.
>   - Remove useless macro and enum.
>   - Describe settings by devicetree.
>   - Move header file to C file.
>
>  MAINTAINERS                       |   6 +
>  drivers/video/backlight/Kconfig   |   8 ++
>  drivers/video/backlight/Makefile  |   1 +
>  drivers/video/backlight/ktz8866.c | 195 ++++++++++++++++++++++++++++++
>  4 files changed, 210 insertions(+)
>  create mode 100644 drivers/video/backlight/ktz8866.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42fc47c6edfd..2084e74e1b58 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11674,6 +11674,12 @@ M:	John Hawley <warthog9@eaglescrag.net>
>  S:	Maintained
>  F:	tools/testing/ktest
>
> +KTZ8866 BACKLIGHT DRIVER
> +M:	Jianhua Lu <lujianhua000@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> +F:	drivers/video/backlight/ktz8866.c
> +
>  L3MDEV
>  M:	David Ahern <dsahern@kernel.org>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 936ba1e4d35e..2845fd7e33ad 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -190,6 +190,14 @@ config BACKLIGHT_KTD253
>  	  which is a 1-wire GPIO-controlled backlight found in some mobile
>  	  phones.
>
> +config BACKLIGHT_KTZ8866
> +	tristate "Backlight Driver for Kinetic KTZ8866"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +		Say Y to enabled the backlight driver for the Kinetic KTZ8866
> +		found in Xiaomi Mi Pad 5 series.
> +
>  config BACKLIGHT_LM3533
>  	tristate "Backlight Driver for LM3533"
>  	depends on MFD_LM3533
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index e815f3f1deff..f70a819c304c 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_BACKLIGHT_HP680)		+= hp680_bl.o
>  obj-$(CONFIG_BACKLIGHT_HP700)		+= jornada720_bl.o
>  obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
>  obj-$(CONFIG_BACKLIGHT_KTD253)		+= ktd253-backlight.o
> +obj-$(CONFIG_BACKLIGHT_KTZ8866)		+= ktz8866.o
>  obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
>  obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
>  obj-$(CONFIG_BACKLIGHT_LM3639)		+= lm3639_bl.o
> diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
> new file mode 100644
> index 000000000000..98916f92d069
> --- /dev/null
> +++ b/drivers/video/backlight/ktz8866.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Backlight driver for the Kinetic KTZ8866
> + *
> + * Copyright (C) 2023 Jianhua Lu <lujianhua000@gmail.com>

Shouldn't this be:
Copyright (C) 2022, 2023 Jianhua Lu <lujianhua000@gmail.com>

> +static int ktz8866_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct backlight_device *backlight_dev;
> +	struct backlight_properties props;
> +	struct ktz8866 *ktz;
> +
> +	ktz = devm_kzalloc(&client->dev, sizeof(*ktz), GFP_KERNEL);
> +	if (!ktz)
> +		return -ENOMEM;
> +
> +	ktz->client = client;
> +	ktz->regmap = devm_regmap_init_i2c(client, &ktz8866_regmap_config);
> +
> +	if (IS_ERR(ktz->regmap)) {
> +		dev_err(&client->dev, "failed to init regmap\n");
> +		return PTR_ERR(ktz->regmap);
> +	}
> +
> +	memset(&props, 0, sizeof(props));
> +	props.type = BACKLIGHT_RAW;
> +	props.max_brightness = MAX_BRIGHTNESS;
> +	props.brightness = DEFAULT_BRIGHTNESS;

There is still pending feedback from v3.

| Please set the scale property correctly. "Unknown" is never correct for
| new drivers.

Do not ignore feedback. You should either act on it or, if you disagree
or need additional clarification then, reply on the mail thread.


Daniel.
