Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E6760F224
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiJ0IV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiJ0IVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:21:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C175A89F;
        Thu, 27 Oct 2022 01:21:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5EE2166028BE;
        Thu, 27 Oct 2022 09:21:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666858867;
        bh=JTs5EfxuT2CF8mMbi3GPlfEzuwjMPovBJC96FXd0pEk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IczBjs84N1s4KWfrRb7gMdhDuUAESC+qy35NJH54cFfF4EdUMS06EEY+lMgX6QnUX
         uUTwXxtyyp99KD6VcUMmnf5ZRXxgrkCLRnI65m92nniyyh/c+NewYmlpKXwX2InqwD
         dkM4KnIyxgWZ5VImVG9sVl/RuHQ8CqCi1xU8FxX194iXNxFrZZHnJ3TYLpw5w0OHXh
         i4UWD2g0aWp0tGAhAUgqDkXKtNxQj/r5UHVatS+e8gwZbNBBZoPNkj5VJDc562UrSy
         1czIk7zbgW19H3NszBLhF2EusABSHQDxJEVTTNzK6fv+hgoab+TaVs2Hlq1g8dT3Ap
         55HA06djrI74w==
Message-ID: <875b601c-bc41-2d6b-2e93-4c98e3b6c371@collabora.com>
Date:   Thu, 27 Oct 2022 10:21:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 03/19] clk: mediatek: Add MT8188 topckgen clock support
Content-Language: en-US
To:     "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221024094254.29218-1-Garmin.Chang@mediatek.com>
 <20221024094254.29218-4-Garmin.Chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024094254.29218-4-Garmin.Chang@mediatek.com>
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

Il 24/10/22 11:42, Garmin.Chang ha scritto:
> Add MT8188 topckgen clock controller which provides muxes, dividers
> to handle variety clock selection in other IP blocks.
> 
> Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>
> ---
>   drivers/clk/mediatek/Makefile              |    2 +-
>   drivers/clk/mediatek/clk-mt8188-topckgen.c | 1337 ++++++++++++++++++++
>   2 files changed, 1338 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/clk/mediatek/clk-mt8188-topckgen.c
> 
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 957530b4303f..4fc7de25f036 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -82,7 +82,7 @@ obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt
>   				   clk-mt8186-mfg.o clk-mt8186-mm.o clk-mt8186-wpe.o \
>   				   clk-mt8186-img.o clk-mt8186-vdec.o clk-mt8186-venc.o \
>   				   clk-mt8186-cam.o clk-mt8186-mdp.o clk-mt8186-ipe.o
> -obj-$(CONFIG_COMMON_CLK_MT8188) += clk-mt8188-apmixedsys.o
> +obj-$(CONFIG_COMMON_CLK_MT8188) += clk-mt8188-apmixedsys.o clk-mt8188-topckgen.o
>   obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
>   obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
>   obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> new file mode 100644
> index 000000000000..c6ac6c2558ae
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> @@ -0,0 +1,1337 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Garmin Chang <garmin.chang@mediatek.com>
> +
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/mediatek,mt8188-clk.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-mux.h"
> +
> +static DEFINE_SPINLOCK(mt8188_clk_lock);
> +
> +static const struct mtk_fixed_clk top_fixed_clks[] = {
> +	FIXED_CLK(CLK_TOP_ULPOSC1, "ulposc_ck1", NULL, 260000000),
> +	FIXED_CLK(CLK_TOP_MPHONE_SLAVE_BCK, "mphone_slave_bck", NULL, 49152000),
> +	FIXED_CLK(CLK_TOP_PAD_FPC, "pad_fpc_ck", NULL, 50000000),
> +	FIXED_CLK(CLK_TOP_466M_FMEM, "hd_466m_fmem_ck", NULL, 533000000),
> +	FIXED_CLK(CLK_TOP_PEXTP_PIPE, "pextp_pipe", NULL, 250000000),
> +	FIXED_CLK(CLK_TOP_DSI_PHY, "dsi_phy", NULL, 500000000),
> +};
> +
> +static const struct mtk_fixed_factor top_divs[] = {
> +	FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck", "mfgpll", 1, 1),
> +	FACTOR(CLK_TOP_MAINPLL, "mainpll_ck", "mainpll", 1, 1),

Are you sure that mainpll and univpll should have CLK_SET_RATE_PARENT?
This will give issues in GPU DVFS, as this is the case with all MediaTek SoCs.

Please check this series and add it as a dependency of yours:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=688135

> +	FACTOR(CLK_TOP_MAINPLL_D3, "mainpll_d3", "mainpll_ck", 1, 3),
> +	FACTOR(CLK_TOP_MAINPLL_D4, "mainpll_d4", "mainpll_ck", 1, 4),

..snip..

> +
> +static struct mtk_composite top_muxes[] = {
> +	/* CLK_MISC_CFG_3 */
> +	MUX(CLK_TOP_MFG_CK_FAST_REF, "mfg_ck_fast_ref", mfg_fast_ref_parents, 0x0250, 8, 1),
> +};

CLK_TOP_MFG_CK_FAST_REF is not a composite clock: you can register it with a call
to devm_clk_hw_register_mux() in the probe function.

Check clk-mt8195-topckgen.c upstream for an example.

Regards,
Angelo

