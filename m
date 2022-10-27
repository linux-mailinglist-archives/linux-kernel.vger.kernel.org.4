Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F81560F244
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiJ0IXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiJ0IXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:23:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021611CB0C;
        Thu, 27 Oct 2022 01:23:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4649D66028BE;
        Thu, 27 Oct 2022 09:23:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666859018;
        bh=/jwDS3QbZfRcGewQkh8GqK9+PG6pPsrzVesZzj+NEmk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cAgm1JQUQTkRnNBO0wZLz88LKPBhm1qnScqLHK1J/ZaInJ6Y+p6tmsoYucfo/Y4h5
         YGpSUdmRgMW39PA2Q4nxb+wZhyyyUmZ4gSXvir8PY4thQBBD7mDfiWl5ScItMwxFIx
         faHIjNSLU8TfbJsa5rKAJ6NKN5fLEzZweKAM7aaP1c0mhZLENPlXvYqnduzewNyuFa
         l3409yBpDJrNHsUOEDybymGLJJjz7K9GRWtxTr3jsX4s0USOXoxAEa23maP6rzFgNm
         p67wLTaL3Q4rtAijwUeQwurLDg8vnx3TFhtvJ48FYXzG9lcP480rBnEp8fN2e9Egpq
         Su55dhTwuTayQ==
Message-ID: <5e71c0b1-d645-1900-282d-df7d13cc60f8@collabora.com>
Date:   Thu, 27 Oct 2022 10:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 10/19] clk: mediatek: Add MT8188 mfgcfg clock support
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
 <20221024094254.29218-11-Garmin.Chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024094254.29218-11-Garmin.Chang@mediatek.com>
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
> Add MT8188 mfg clock controller which provides clock gate
> control for GPU.
> 
> Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>
> ---
>   drivers/clk/mediatek/Makefile         |  2 +-
>   drivers/clk/mediatek/clk-mt8188-mfg.c | 50 +++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/clk/mediatek/clk-mt8188-mfg.c
> 
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 21b05e880a3a..cd8870c28146 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -85,7 +85,7 @@ obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt
>   obj-$(CONFIG_COMMON_CLK_MT8188) += clk-mt8188-apmixedsys.o clk-mt8188-topckgen.o \
>   				   clk-mt8188-peri_ao.o clk-mt8188-infra_ao.o \
>   				   clk-mt8188-cam.o clk-mt8188-ccu.o clk-mt8188-img.o \
> -				   clk-mt8188-ipe.o
> +				   clk-mt8188-ipe.o clk-mt8188-mfg.o
>   obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
>   obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
>   obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8188-mfg.c b/drivers/clk/mediatek/clk-mt8188-mfg.c
> new file mode 100644
> index 000000000000..3a75cd7443fd
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8188-mfg.c
> @@ -0,0 +1,50 @@
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
> +static const struct mtk_gate_regs mfgcfg_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x8,
> +	.sta_ofs = 0x0,
> +};
> +
> +#define GATE_MFGCFG(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &mfgcfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +static const struct mtk_gate mfgcfg_clks[] = {
> +	GATE_MFGCFG(CLK_MFGCFG_BG3D, "mfgcfg_bg3d", "top_mfg_core_tmp", 0),
> +};

This will make it impossible to properly perform GPU DVFS.

Hint:

#define GATE_MFG(_id, _name, _parent, _shift)			\
	GATE_MTK_FLAGS(_id, _name, _parent, &mfg_cg_regs,	\
		       _shift, &mtk_clk_gate_ops_setclr,	\
		       CLK_SET_RATE_PARENT)

Regards,
Angelo


