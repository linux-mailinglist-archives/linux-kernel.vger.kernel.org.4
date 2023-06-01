Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E97192CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjFAF43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjFAF4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:56:05 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FFE67
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:55:12 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aef03.dynamic.kabel-deutschland.de [95.90.239.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5E01D61E4052B;
        Thu,  1 Jun 2023 07:53:39 +0200 (CEST)
Message-ID: <fde8e0c8-2730-f679-d361-86fad007ee47@molgen.mpg.de>
Date:   Thu, 1 Jun 2023 07:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 03/43] soc: Add SoC driver for Cirrus ep93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Walker Chen <walker.chen@starfivetech.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-4-nikita.shubin@maquefel.me>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230601053546.9574-4-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Nikita,


Thank you for your patch. Some small nit picks.

Am 01.06.23 um 07:33 schrieb Nikita Shubin:
> This adds an SoC driver for the ep93xx. Currently there
> is only one thing not fitting into any other framework,
> and that is the swlock setting.

If you reflow for 75 characters per line, this would fit into two lines.

> It's used for clock settings and restart.

What datasheet did you use, and on what board did you test this?

> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

[…]

>   drivers/soc/Kconfig               |   1 +
>   drivers/soc/Makefile              |   1 +
>   drivers/soc/cirrus/Kconfig        |  11 +++
>   drivers/soc/cirrus/Makefile       |   2 +
>   drivers/soc/cirrus/soc-ep93xx.c   | 134 ++++++++++++++++++++++++++++++
>   include/linux/soc/cirrus/ep93xx.h |  16 +++-
>   6 files changed, 161 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/soc/cirrus/Kconfig
>   create mode 100644 drivers/soc/cirrus/Makefile
>   create mode 100644 drivers/soc/cirrus/soc-ep93xx.c
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 4e176280113a..6149f0447b61 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -30,5 +30,6 @@ source "drivers/soc/ti/Kconfig"
>   source "drivers/soc/ux500/Kconfig"
>   source "drivers/soc/versatile/Kconfig"
>   source "drivers/soc/xilinx/Kconfig"
> +source "drivers/soc/cirrus/Kconfig"
>   
>   endmenu
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 3b0f9fb3b5c8..7a8a154b8d96 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -36,3 +36,4 @@ obj-y				+= ti/
>   obj-$(CONFIG_ARCH_U8500)	+= ux500/
>   obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
>   obj-y				+= xilinx/
> +obj-$(CONFIG_EP93XX_SOC)	+= cirrus/
> diff --git a/drivers/soc/cirrus/Kconfig b/drivers/soc/cirrus/Kconfig
> new file mode 100644
> index 000000000000..bc82c0422325
> --- /dev/null
> +++ b/drivers/soc/cirrus/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if ARCH_EP93XX
> +
> +config EP93XX_SOC
> +	bool "Cirrus EP93xx chips SoC"
> +	default y if !EP93XX_SOC_COMMON
> +	help
> +	  Support Soc for Cirrus EP93xx chips.

Above (and more common in the whole SOC directory) you spell it SoC.

> +
> +endif
> diff --git a/drivers/soc/cirrus/Makefile b/drivers/soc/cirrus/Makefile
> new file mode 100644
> index 000000000000..ed6752844c6f
> --- /dev/null
> +++ b/drivers/soc/cirrus/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y	+= soc-ep93xx.o
> diff --git a/drivers/soc/cirrus/soc-ep93xx.c b/drivers/soc/cirrus/soc-ep93xx.c
> new file mode 100644
> index 000000000000..64842e9e2316
> --- /dev/null
> +++ b/drivers/soc/cirrus/soc-ep93xx.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Soc driver for Cirrus EP93xx chips.

Ditto.

> + * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/core.c
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
> + *
> + * Thanks go to Michael Burian and Ray Lehtiniemi for their key
> + * role in the ep93xx linux community

If you know their email addresses, you could add those too. Maybe also 
add a dot/period at the end.

> + */
> +
> +#include <linux/soc/cirrus/ep93xx.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +
> +#define EP93XX_SYSCON_DEVCFG		0x80
> +
> +#define EP93XX_SWLOCK_MAGICK		0xaa
> +#define EP93XX_SYSCON_SWLOCK		0xc0
> +#define EP93XX_SYSCON_SYSCFG		0x9c
> +#define EP93XX_SYSCON_SYSCFG_REV_MASK	(0xf0000000)
> +#define EP93XX_SYSCON_SYSCFG_REV_SHIFT	(28)

[…]


Kind regards,

Paul
