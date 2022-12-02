Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0851B6405F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiLBLlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbiLBLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:41:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F01CE43D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:41:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so6290657wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=U4oz8SSnE2zH+GohF5+iQafg1aGfg/iY/5Nv8cvrkb4=;
        b=aP1kbEov8QRDX8CAf0EiKIgSjoR9E59RSNGByUUnbzuCe5ru95AQQZhUmETCxsJAdF
         AWYfsLOpV7WDn5Dm53BiK5EXZpqOTUSj8STjci6i185es4QllvkolJ53m/mB7gIUPLZY
         uwklyYypa5zI+6TabQjjd1GLvNoQ3UvEW76sAl8RqAf4L6wHqeEN+JY2Tfy4HunyesXI
         gnBmQOlX595zGMJoHtwDDTNkdUl8L0GmNvY34NglMgZef7k1qEhKl7Ff7Qm+mxZuZeXN
         85yBSRaRHMg0JYQyN0U2IOsITzL6XDTSLnq8uGU6YJ8Hqr5TN3R/Azd+cNJuTSEQTrep
         7Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4oz8SSnE2zH+GohF5+iQafg1aGfg/iY/5Nv8cvrkb4=;
        b=Xao/VEqF9B2G9gUbSma2jzqmCfS8YpHEXskuIqvDKYQ1Qhq/YsTYJvXe/2oXhkyj4b
         Bom0L/5ymsBv/EDgF2CDLiSLQASH82ffX6NXmM0fbgj6u5hD2XFFygswq58bI8MU87up
         +xL1iWj2V4+VLmvZOR79IcwuoB4u7OMkCFtccodvXILbGMXRCY5UBx3cVShDZYfznbAz
         Zlxq8Msqma/FXWBww6mARyQgJpGhYNLto3Zs+VPEIBLLQl5/c/bOdf2k7wbwHt3k6h63
         wYonT6I3Vk/BEXkPePlTKst3TI24FjGreibOd2V7k8eYr98SIDKcDnAULMwlC8trfoyv
         IUeg==
X-Gm-Message-State: ANoB5pnueNiITHC3St1RpALZTdViL2C8zoKYtOlH5UkoCXxwyg4sfQDA
        mdAPRhxYX6mpgEgN8u0fYu/4yQ==
X-Google-Smtp-Source: AA0mqf7sJS6oRW+XfXeDsK6+elCMZNU62vpBmLcePkew8oXw+ClGBjbQ2rPmqjjQkhYcIVYNKacaUQ==
X-Received: by 2002:a05:600c:a56:b0:3cf:77a6:2c2e with SMTP id c22-20020a05600c0a5600b003cf77a62c2emr37078202wmq.179.1669981271603;
        Fri, 02 Dec 2022 03:41:11 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b003c6f3f6675bsm13381928wmq.26.2022.12.02.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:41:11 -0800 (PST)
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-7-ddrokosov@sberdevices.ru>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 06/11] clk: meson: introduce a1-clkc common driver
 for all A1 clock controllers
Date:   Fri, 02 Dec 2022 12:36:50 +0100
In-reply-to: <20221201225703.6507-7-ddrokosov@sberdevices.ru>
Message-ID: <1jy1rq6nje.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 02 Dec 2022 at 01:56, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> Generally, A1 SoC has four clock controllers on the board: PLL,
> Peripherals, CPU, and Audio. The audio clock controller is different
> from others, but the rest are very similar from a functional and regmap
> point of view. So a it's good idea to generalize some routines for all
> of them. Exactly, meson-a1-clkc driver contains the common probe() flow.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

I think you should leave this out for the initial submission. It makes
harder to review.

In some case, these factorizations actually the maitenance harder.

There is also the s4 that is coming up. It looks similar to the A1 as
well.

Let's wait for both them to land, see how it goes and then we'll decide
if a factorization is appropriate.

> ---
>  drivers/clk/meson/Kconfig         |  4 ++
>  drivers/clk/meson/Makefile        |  1 +
>  drivers/clk/meson/meson-a1-clkc.c | 63 +++++++++++++++++++++++++++++++
>  drivers/clk/meson/meson-a1-clkc.h | 25 ++++++++++++
>  4 files changed, 93 insertions(+)
>  create mode 100644 drivers/clk/meson/meson-a1-clkc.c
>  create mode 100644 drivers/clk/meson/meson-a1-clkc.h
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index bd44ba47200e..1c885541c3a9 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -43,6 +43,10 @@ config COMMON_CLK_MESON_CPU_DYNDIV
>  	tristate
>  	select COMMON_CLK_MESON_REGMAP
>  
> +config COMMON_CLK_MESON_A1_CLKC
> +	tristate
> +	select COMMON_CLK_MESON_REGMAP
> +
>  config COMMON_CLK_MESON8B
>  	bool "Meson8 SoC Clock controller support"
>  	depends on ARM
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 0e6f293c05d4..15136d861a65 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
>  obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
>  obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
>  obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
> +obj-$(CONFIG_COMMON_CLK_MESON_A1_CLKC) += meson-a1-clkc.o
>  
>  # Amlogic Clock controllers
>  
> diff --git a/drivers/clk/meson/meson-a1-clkc.c b/drivers/clk/meson/meson-a1-clkc.c
> new file mode 100644
> index 000000000000..2fe320a0e16e
> --- /dev/null
> +++ b/drivers/clk/meson/meson-a1-clkc.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson-A1 Clock Controller Driver
> + *
> + * Copyright (c) 2022, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> + */
> +
> +#include <linux/of_device.h>
> +#include "meson-a1-clkc.h"
> +
> +static struct regmap_config clkc_regmap_config = {
> +	.reg_bits   = 32,
> +	.val_bits   = 32,
> +	.reg_stride = 4,
> +};
> +
> +int meson_a1_clkc_probe(struct platform_device *pdev)
> +{
> +	struct meson_a1_clkc_data *clkc;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	void __iomem *base;
> +	struct regmap *map;
> +	int clkid, i, err;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return dev_err_probe(dev, -ENXIO, "can't get IO resource\n");
> +
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "can't ioremap resource %pr\n", res);
> +
> +	map = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
> +				     "can't init regmap mmio region\n");
> +
> +	clkc = (struct meson_a1_clkc_data *)of_device_get_match_data(dev);
> +	if (!clkc)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "can't get A1 clkc driver data\n");
> +
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < clkc->num_regs; i++)
> +		clkc->regs[i]->map = map;
> +
> +	for (clkid = 0; clkid < clkc->hw->num; clkid++) {
> +		err = devm_clk_hw_register(dev, clkc->hw->hws[clkid]);
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					     "clock registration failed\n");
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   (void *)clkc->hw);
> +}
> +EXPORT_SYMBOL_GPL(meson_a1_clkc_probe);
> +
> +MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/meson-a1-clkc.h b/drivers/clk/meson/meson-a1-clkc.h
> new file mode 100644
> index 000000000000..503eca0f6cb5
> --- /dev/null
> +++ b/drivers/clk/meson/meson-a1-clkc.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Amlogic Meson-A1 Clock Controller driver
> + *
> + * Copyright (c) 2022, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> + */
> +
> +#ifndef __MESON_A1_CLKC_H__
> +#define __MESON_A1_CLKC_H__
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "clk-regmap.h"
> +
> +struct meson_a1_clkc_data {
> +	const struct clk_hw_onecell_data *hw;
> +	struct clk_regmap *const *regs;
> +	size_t num_regs;
> +};
> +
> +int meson_a1_clkc_probe(struct platform_device *pdev);
> +#endif

