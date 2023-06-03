Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA0721190
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFCSfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFCSfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:35:20 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69420B1
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 11:35:19 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 60973bd3-023d-11ee-b3cf-005056bd6ce9;
        Sat, 03 Jun 2023 21:35:17 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 21:35:13 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Walker Chen <walker.chen@starfivetech.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/43] soc: Add SoC driver for Cirrus ep93xx
Message-ID: <ZHuH4U7yGbTvS5km@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-4-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-4-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 08:33:54AM +0300, Nikita Shubin kirjoitti:
> This adds an SoC driver for the ep93xx. Currently there
> is only one thing not fitting into any other framework,
> and that is the swlock setting.
> 
> It's used for clock settings and restart.

...

>  source "drivers/soc/ux500/Kconfig"
>  source "drivers/soc/versatile/Kconfig"
>  source "drivers/soc/xilinx/Kconfig"
> +source "drivers/soc/cirrus/Kconfig"

Why not ordered?

...

>  obj-$(CONFIG_ARCH_U8500)	+= ux500/
>  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
>  obj-y				+= xilinx/
> +obj-$(CONFIG_EP93XX_SOC)	+= cirrus/

Ditto.

...

> +/*
> + * Soc driver for Cirrus EP93xx chips.

SoC

> + * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/core.c
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
> + *
> + * Thanks go to Michael Burian and Ray Lehtiniemi for their key
> + * role in the ep93xx linux community

Linux
community.

> + */

...

> +#include <linux/soc/cirrus/ep93xx.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>

Can this be ordered?

...

> +#define EP93XX_SYSCON_SYSCFG_REV_MASK	(0xf0000000)

GENMASK() ?
(will need bits.h)

> +#define EP93XX_SYSCON_SYSCFG_REV_SHIFT	(28)

Here and above, do you need parentheses?

...

> +static struct regmap *map;

Global?!

...

> +EXPORT_SYMBOL_GPL(ep93xx_syscon_swlocked_write);

Can it (and other exported symbols) be exported with a namespace?

...

> +/**
> + * ep93xx_chip_revision() - returns the EP93xx chip revision

> + *

Redundant (?) blank line, but...

kernel doc validation will complain here a lot. Either drop kernel doc style or
fill it correctly.

> + */

...

> +static int __init ep93xx_soc_init(void)
> +{
> +	/* Multiplatform guard, only proceed on ep93xx */
> +	if (!of_machine_is_compatible("cirrus,ep9301"))
> +		return 0;
> +
> +	map = syscon_regmap_lookup_by_compatible("cirrus,ep9301-syscon");
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	pr_info("EP93xx SoC revision %s\n", ep93xx_get_soc_rev());
> +
> +	return 0;
> +}

> +

Unneeded blank line.

> +core_initcall(ep93xx_soc_init);
> +

Trailing blank line.

-- 
With Best Regards,
Andy Shevchenko


