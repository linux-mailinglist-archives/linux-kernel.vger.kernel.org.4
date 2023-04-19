Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB66E74B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjDSILL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjDSILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:11:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD7A5F0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:11:02 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 403FB660324C;
        Wed, 19 Apr 2023 09:11:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681891861;
        bh=N9N5Z5PUO2VBsvggGI6LzSyVWaQ71ALkM8ielchtweQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oe0VZA1rILmQ75rbPrJ+2gbcSIw4gNsBHM7Cw4E4GeHiEjkksuUYU5keH3A3B8p4x
         zy4l6tqfIgoE8mwzTQye/Lh6zZV36EPcYjX5RMORPVh1NBJou8L7NOO4jUGBzQ+pDu
         hzbzTCbOHRHHoapv6JY0Zw2Czdc0QBGFRYNrvbsfnJN62hOeOvdDKmMkvpvMLmyiX8
         EEmht/5D3QSyrQwTpjgeXVAcl2SjN8jGEZYIqB0/gOMYeTfGMHV4EpTUniSDZ5RlvM
         /nMo77nkSmvPqG3tx84BEuHIFIhmKHCHKgG1wZ7uoe/7MJlTPscfES/YzaW8hjQYKd
         PIP6FyBICkujQ==
Message-ID: <3dac0be8-6a49-43db-da65-e99d2e9719e6@collabora.com>
Date:   Wed, 19 Apr 2023 10:10:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH linux-next v3 4/4] clocksource/drivers/timer-mediatek:
 Make timer-mediatek become loadable module
To:     walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230419074910.10809-1-walter.chang@mediatek.com>
 <20230419074910.10809-5-walter.chang@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230419074910.10809-5-walter.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/04/23 09:49, walter.chang@mediatek.com ha scritto:
> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> 
> Make the timer-mediatek driver which can register
> an always-on timer as tick_broadcast_device on
> MediaTek SoCs become loadable module in GKI.
> 
> Tested-by: Walter Chang <walter.chang@mediatek.com>
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>

I think I typoed your email when sending the example patch for the
conversion to platform_device. Check [1], it may be better to just
iterate through that? (please ignore the pure_initcall() part, that's
a mistake, it's never gonna happen as it automatically becomes a
module_init() call).

It depends on what maintainers think about that clocksource.h addition,
the patch got zero comments, so if you're interested in that perhaps we
can explicitly ask what would be the best option between yours and mine;
that addition is done only to avoid the big ifdef party that this patch
proposes and makes things a bit shorter if this timer modularization
goes on with more drivers, but I don't have strong opinions anyway.

In the meanwhile, just to eventually speed up integrating this, or the
other patch - I'll still give you a review of this one.

[1]: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20230309132119.175650-1-angelogioacchino.delregno@collabora.com/

> ---
>   drivers/clocksource/Kconfig          |  2 +-
>   drivers/clocksource/timer-mediatek.c | 39 ++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 526382dc7482..a7413ad7b6ad 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -472,7 +472,7 @@ config SYS_SUPPORTS_SH_CMT
>   	bool
>   
>   config MTK_TIMER
> -	bool "Mediatek timer driver" if COMPILE_TEST
> +	tristate "Mediatek timer driver"

While at it, you could also fix the text, Mediatek -> MediaTek

>   	depends on HAS_IOMEM
>   	select TIMER_OF
>   	select CLKSRC_MMIO
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 7bcb4a3f26fb..3448848682c0 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -13,6 +13,9 @@
>   #include <linux/clocksource.h>
>   #include <linux/interrupt.h>
>   #include <linux/irqreturn.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>   #include <linux/sched_clock.h>
>   #include <linux/slab.h>
>   #include "timer-of.h"
> @@ -337,5 +340,41 @@ static int __init mtk_gpt_init(struct device_node *node)
>   
>   	return 0;
>   }
> +
> +#ifdef MODULE

#ifndef MODULE
... two lines...
#else
... a bunch of lines ...
#endif

looks more readable. I'd go with that.

> +static int mtk_timer_probe(struct platform_device *pdev)
> +{
> +	int (*timer_init)(struct device_node *node);
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	timer_init = of_device_get_match_data(&pdev->dev);
> +	return timer_init(np);
> +}
> +
> +static const struct of_device_id mtk_timer_match_table[] = {
> +	{
> +		.compatible = "mediatek,mt6577-timer",
> +		.data = mtk_gpt_init,

Fits in one line!

> +	},
> +	{
> +		.compatible = "mediatek,mt6765-timer",
> +		.data = mtk_syst_init,

ditto.

> +	},
> +	{}

Always end with { /* sentinel */ }

> +};
> +
> +static struct platform_driver mtk_timer_driver = {
> +	.probe = mtk_timer_probe,
> +	.driver = {
> +		.name = "mtk-timer",

"mediatek-timer" looks nicer :-)

> +		.of_match_table = mtk_timer_match_table,
> +	},
> +};
> +module_platform_driver(mtk_timer_driver);
> +
> +MODULE_DESCRIPTION("MediaTek Module Timer driver");

"MediaTek Timer driver" is enough, "Module" gets misleading if this gets compiled
as built in platform driver (instead of built in timer_of).

> +MODULE_LICENSE("GPL v2");
> +#else
>   TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
>   TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
> +#endif


