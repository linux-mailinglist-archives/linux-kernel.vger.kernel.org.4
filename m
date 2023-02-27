Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5740F6A3E50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjB0J2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0J2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:28:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F4B76B1;
        Mon, 27 Feb 2023 01:28:11 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19B066602216;
        Mon, 27 Feb 2023 09:28:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677490090;
        bh=fldeCQ2T3yK2LbLkV58DiP2FN50W9J7zlsxRxl8CG0c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=muSvg7U/qWbXs3L1PUQ0RBl7Rh8gbjl/8NqkagVl/L6OHTx6O+uEE0zle6Dpcs0Sd
         7H1akkLBKCE49h6FPNpktm05EhzY06VyX8aJb8qIacgtyNkQF+AELASrpc1pH8GflM
         On7KLALIWvNE4mJKEIQ7H5juaCiwWcXqtIOxw00wmdKiosEGpDqeQAGpuv2AaJkgRj
         rJ8z9U9hLl7YICyqQrGPjFYqly73XNk73Nr+K+8zAbWkrEbqEjZ40+ylR4kXE3XoLS
         OZTOdSSBjAVbVUeCvAmX1OnX90fR4yK+BSpyrQvekroyt9fffedVtq0BE00XP9G5ny
         KyIS9miksZX+g==
Message-ID: <cd634833-b28e-d6d3-692d-5a391b85ad34@collabora.com>
Date:   Mon, 27 Feb 2023 10:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/4] clk: mediatek: Add drivers for MediaTek MT6735
 main clock and reset drivers
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230225094246.261697-1-y.oudjana@protonmail.com>
 <20230225094246.261697-5-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230225094246.261697-5-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/02/23 10:42, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
> clock and reset controllers. These provide the base clocks and resets
> on the platform, and should be enough to bring up all essential blocks
> including PWRAP, MSDC and peripherals (UART, I2C, SPI).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   MAINTAINERS                                  |   4 +
>   drivers/clk/mediatek/Kconfig                 |   9 +
>   drivers/clk/mediatek/Makefile                |   1 +
>   drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 139 ++++++
>   drivers/clk/mediatek/clk-mt6735-infracfg.c   |  78 ++++
>   drivers/clk/mediatek/clk-mt6735-pericfg.c    |  91 ++++
>   drivers/clk/mediatek/clk-mt6735-topckgen.c   | 450 +++++++++++++++++++
>   7 files changed, 772 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
> 

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt6735-topckgen.c b/drivers/clk/mediatek/clk-mt6735-topckgen.c
> new file mode 100644
> index 000000000000..5fa743e4b0fc
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6735-topckgen.c
> @@ -0,0 +1,450 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-mux.h"
> +
> +#include <dt-bindings/clock/mediatek,mt6735-topckgen.h>
> +

..snip..

> +
> +int clk_mt6735_topckgen_probe(struct platform_device *pdev)

It gets *even easier* than that!

Check out this one:
https://patchwork.kernel.org/project/linux-mediatek/patch/20230222092543.19187-5-angelogioacchino.delregno@collabora.com/

...being part of:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=724004

So you can use simple_probe for MT6735's topckgen too!

In this case, it would be...

static const struct mtk_clk_desc topck_desc = {
	.clks = topckgen_muxes,
	.num_clks = ARRAY_SIZE(topckgen_muxes),
	.fixed_clks = topckgen_fixed_clks,
	.num_fixed_clks = ARRAY_SIZE(topckgen_fixed_clks),
	.factor_clks = topckgen_factors,
	.num_factor_clks = ARRAY_SIZE(topckgen_factors),
	.clk_lock = &mt6735_topckgen_lock,
};

static const struct of_device_id of_match_mt6735_topckgen[] = {
	{ .compatible = "mediatek,mt6735-topckgen", .data = &topck_desc },
	{ /* sentinel */ }
};

MODULE_DEVICE_TABLE(of, of_match_mt6735_topckgen)
     ^^^^^
You're missing that on multiple clock drivers ;-)

...And you're replacing .probe(), .remove() callbacks with

static struct platform_driver clk_mt6735_topckgen = {
	.probe = mtk_clk_simple_probe,
	.remove = mtk_clk_simple_remove,

	......

Other than that, good job!

After performing these changes, please make sure to mention the dependency on
my last cleanup series on your cover letter for v4, so that maintainers will
be aware of what to do.

Your v4 smells like Reviewed-by tags all over. Keep up the great work!

Cheers,
Angelo
