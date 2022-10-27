Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513E160F24A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiJ0IZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJ0IZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:25:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCE83F1C7;
        Thu, 27 Oct 2022 01:25:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DFA1066028BE;
        Thu, 27 Oct 2022 09:25:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666859143;
        bh=/YidnNINzPW5vZDb/pa0jpw8YDaXO7CEUDNd8zcAIYA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CzQgNRVc/yB6bXgQzIRqdr2PZWskO8Gm9x5NCkX+XC5HRzEcJbDe8uf4WroOTVfdk
         JtdlmD6xcXhn5lHuYUbVKo9RbAaeqBFudlChVquwQQn2hh3KGfJHc86e+igEui4V8b
         Vj8botpKBnxvgRImzcd2pNlDJwATLCDJkIx71v0Wk5sKualwJ4i8zbxrC0YCqcrxuk
         yE9daXe1GRNQY9Bj9fW0M7edZwMymnPMaZ8i6YR6SMpRDAQy7bsL1mtbmJZvHXT9dF
         djLA/u6cb+qN4Jrf5s2jkT5xN46+hjApXcuxUujJ3NiEQIb6z9yv9PiwVZBq6wghDG
         gcV959ZS9J5jg==
Message-ID: <cb050482-cf6e-829e-7fd4-cfcde72c545b@collabora.com>
Date:   Thu, 27 Oct 2022 10:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 08/19] clk: mediatek: Add MT8188 imgsys clock support
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
 <20221024094254.29218-9-Garmin.Chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024094254.29218-9-Garmin.Chang@mediatek.com>
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
> Add MT8188 imgsys clock controllers which provide clock gate
> control for image IP blocks.
> 
> Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>
> ---
>   drivers/clk/mediatek/Makefile         |   2 +-
>   drivers/clk/mediatek/clk-mt8188-img.c | 124 ++++++++++++++++++++++++++
>   2 files changed, 125 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/clk/mediatek/clk-mt8188-img.c
> 
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index bd0a2aa5b6fa..242b49bafa9e 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -84,7 +84,7 @@ obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt
>   				   clk-mt8186-cam.o clk-mt8186-mdp.o clk-mt8186-ipe.o
>   obj-$(CONFIG_COMMON_CLK_MT8188) += clk-mt8188-apmixedsys.o clk-mt8188-topckgen.o \
>   				   clk-mt8188-peri_ao.o clk-mt8188-infra_ao.o \
> -				   clk-mt8188-cam.o clk-mt8188-ccu.o
> +				   clk-mt8188-cam.o clk-mt8188-ccu.o clk-mt8188-img.o
>   obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
>   obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
>   obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8188-img.c b/drivers/clk/mediatek/clk-mt8188-img.c
> new file mode 100644
> index 000000000000..00f3bbf4d502
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8188-img.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Garmin Chang <garmin.chang@mediatek.com>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/mediatek,mt8188-clk.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +static const struct mtk_gate_regs imgsys_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x8,
> +	.sta_ofs = 0x0,
> +};
> +
> +#define GATE_IMGSYS(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &imgsys_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +static const struct mtk_gate imgsys_main_clks[] = {
> +	GATE_IMGSYS(CLK_IMGSYS_MAIN_LARB9, "imgsys_main_larb9", "top_img", 0),
> +	GATE_IMGSYS(CLK_IMGSYS_MAIN_TRAW0, "imgsys_main_traw0", "top_img", 1),
> +	GATE_IMGSYS(CLK_IMGSYS_MAIN_TRAW1, "imgsys_main_traw1", "top_img", 2),
> +	GATE_IMGSYS(CLK_IMGSYS_MAIN_VCORE_GALS, "imgsys_main_vcore_gals", "top_img", 3),
> +	GATE_IMGSYS(CLK_IMGSYS_MAIN_DIP0, "imgsys_main_dip0", "top_img", 8),
> +	GATE_IMGSYS(CLK_IMGSYS_MAIN_WPE0, "imgsys_main_wpe0", "top_img", 9),
> +	GATE_IMGSYS(CLK_IMGSYS_MAIN_IPE, "imgsys_main_ipe", "top_img", 10),
> +	GATE_IMGSYS(CLK_IMGSYS_MAIN_WPE1, "imgsys_main_wpe1", "top_img", 12),
> +	GATE_IMGSYS(CLK_IMGSYS_MAIN_WPE2, "imgsys_main_wpe2", "top_img", 13),
> +	GATE_IMGSYS(CLK_IMGSYS_MAIN_GALS, "imgsys_main_gals", "top_img", 31),
> +};
> +
> +static const struct mtk_gate imgsys_wpe1_clks[] = {
> +	GATE_IMGSYS(CLK_IMGSYS_WPE1_LARB11, "imgsys_wpe1_larb11", "top_img", 0),
> +	GATE_IMGSYS(CLK_IMGSYS_WPE1, "imgsys_wpe1", "top_img", 1),
> +};
> +
> +static const struct mtk_gate imgsys_wpe2_clks[] = {
> +	GATE_IMGSYS(CLK_IMGSYS_WPE2_LARB11, "imgsys_wpe2_larb11", "top_img", 0),
> +	GATE_IMGSYS(CLK_IMGSYS_WPE2, "imgsys_wpe2", "top_img", 1),
> +};
> +
> +static const struct mtk_gate imgsys_wpe3_clks[] = {
> +	GATE_IMGSYS(CLK_IMGSYS_WPE3_LARB11, "imgsys_wpe3_larb11", "top_img", 0),
> +	GATE_IMGSYS(CLK_IMGSYS_WPE3, "imgsys_wpe3", "top_img", 1),
> +};
> +
> +static const struct mtk_gate imgsys1_dip_top_clks[] = {
> +	GATE_IMGSYS(CLK_IMGSYS1_DIP_TOP_LARB10, "imgsys1_dip_larb10", "top_img", 0),
> +	GATE_IMGSYS(CLK_IMGSYS1_DIP_TOP_DIP_TOP, "imgsys1_dip_dip_top", "top_img", 1),
> +};
> +
> +static const struct mtk_gate imgsys1_dip_nr_clks[] = {
> +	GATE_IMGSYS(CLK_IMGSYS1_DIP_NR_LARB15, "imgsys1_dip_nr_larb15", "top_img", 0),
> +	GATE_IMGSYS(CLK_IMGSYS1_DIP_NR_DIP_NR, "imgsys1_dip_nr_dip_nr", "top_img", 1),
> +};
> +
> +static const struct mtk_clk_desc imgsys_main_desc = {
> +	.clks = imgsys_main_clks,
> +	.num_clks = ARRAY_SIZE(imgsys_main_clks),
> +};
> +
> +static const struct mtk_clk_desc imgsys_wpe1_desc = {
> +	.clks = imgsys_wpe1_clks,
> +	.num_clks = ARRAY_SIZE(imgsys_wpe1_clks),
> +};
> +
> +static const struct mtk_clk_desc imgsys_wpe2_desc = {
> +	.clks = imgsys_wpe2_clks,
> +	.num_clks = ARRAY_SIZE(imgsys_wpe2_clks),
> +};
> +
> +static const struct mtk_clk_desc imgsys_wpe3_desc = {
> +	.clks = imgsys_wpe3_clks,
> +	.num_clks = ARRAY_SIZE(imgsys_wpe3_clks),
> +};
> +
> +static const struct mtk_clk_desc imgsys1_dip_top_desc = {
> +	.clks = imgsys1_dip_top_clks,
> +	.num_clks = ARRAY_SIZE(imgsys1_dip_top_clks),
> +};
> +
> +static const struct mtk_clk_desc imgsys1_dip_nr_desc = {
> +	.clks = imgsys1_dip_nr_clks,
> +	.num_clks = ARRAY_SIZE(imgsys1_dip_nr_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8188_imgsys_main[] = {
> +	{
> +		.compatible = "mediatek,mt8188-imgsys",
> +		.data = &imgsys_main_desc,
> +	}, {
> +		.compatible = "mediatek,mt8188-imgsys_wpe1",

I know that this was done in other clock drivers as well, but can we please
stop using underscores in devicetree compatibles?
That makes them look more consistent with the rest of the DT.

"mediatek,mt8188-imgsys-wpe1", as an example, would look a bit better.

P.S.: Please do the same on all of the other drivers that you are introducing
       with this series.

Thanks,
Angelo
