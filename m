Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED230699380
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjBPLqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjBPLqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:46:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1F61F922;
        Thu, 16 Feb 2023 03:45:39 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A63566021A4;
        Thu, 16 Feb 2023 11:45:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676547937;
        bh=o/FP9rqUBJvBwDql8xUNhZRLBGZHY01568WAydoSR7w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TQsTV7McwOYuXdArxz49Cu7476JnE0tG8GZEqaG3t4Q0hc9QX+1zmxuGgRdJ8nf1B
         J0blOV3kV3viD+uR9YfwHUCEt3ZqLtfZD3Uc0jewhAKn/K45BEFO0und+8BZpKXKRc
         sX7M4UK+6TGGt7qA8L61EoGpFmSa8XaZTo4tRGkb6dU7Xph+Sl7SzH8MU/ArApycyf
         3FOfj3aMSEwUOilJ/rcFSe2m6m08DWclZaCA2iWwy+IjicpM+tFeTvvKYbG3gAs95J
         y4XG4GYYqyLd8O5cB3OUm0hp2zYNT5lCDgTgBzw9mM9BjDAs15pU13Ctxg/CxirV21
         Mh9uPQ/cy3JGw==
Message-ID: <bd36729a-0a36-5a15-462b-16087fa8ab6c@collabora.com>
Date:   Thu, 16 Feb 2023 12:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 24/47] clk: mediatek: mt7622: Move infracfg to
 clk-mt7622-infracfg.c
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
 <20230214134127.59273-25-angelogioacchino.delregno@collabora.com>
 <CAGXv+5EOQbZWrCZNf4qtxytDC=HdcZCxpkXb_Y=QFaW_g8urfQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5EOQbZWrCZNf4qtxytDC=HdcZCxpkXb_Y=QFaW_g8urfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/02/23 11:53, Chen-Yu Tsai ha scritto:
> On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> The infracfg driver cannot be converted to clk_mtk_simple_probe() as
>> it registers cpumuxes, which is not supported on the common probing
>> mechanism: for this reason, move it to its own file.
>>
>> While at it, also convert it to be a platform driver instead.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/Makefile              |   3 +-
>>   drivers/clk/mediatek/clk-mt7622-infracfg.c | 127 +++++++++++++++++++++
>>   drivers/clk/mediatek/clk-mt7622.c          |  78 +------------
>>   3 files changed, 134 insertions(+), 74 deletions(-)
>>   create mode 100644 drivers/clk/mediatek/clk-mt7622-infracfg.c
>>
>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>> index c1bee331eebf..0f2cd735d9fd 100644
>> --- a/drivers/clk/mediatek/Makefile
>> +++ b/drivers/clk/mediatek/Makefile
>> @@ -46,7 +46,8 @@ obj-$(CONFIG_COMMON_CLK_MT2712_MFGCFG) += clk-mt2712-mfg.o
>>   obj-$(CONFIG_COMMON_CLK_MT2712_MMSYS) += clk-mt2712-mm.o
>>   obj-$(CONFIG_COMMON_CLK_MT2712_VDECSYS) += clk-mt2712-vdec.o
>>   obj-$(CONFIG_COMMON_CLK_MT2712_VENCSYS) += clk-mt2712-venc.o
>> -obj-$(CONFIG_COMMON_CLK_MT7622) += clk-mt7622.o clk-mt7622-apmixedsys.o
>> +obj-$(CONFIG_COMMON_CLK_MT7622) += clk-mt7622.o clk-mt7622-apmixedsys.o \
>> +                                  clk-mt7622-infracfg.o
>>   obj-$(CONFIG_COMMON_CLK_MT7622_ETHSYS) += clk-mt7622-eth.o
>>   obj-$(CONFIG_COMMON_CLK_MT7622_HIFSYS) += clk-mt7622-hif.o
>>   obj-$(CONFIG_COMMON_CLK_MT7622_AUDSYS) += clk-mt7622-aud.o
>> diff --git a/drivers/clk/mediatek/clk-mt7622-infracfg.c b/drivers/clk/mediatek/clk-mt7622-infracfg.c
>> new file mode 100644
>> index 000000000000..09d8ac4d483a
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-mt7622-infracfg.c
>> @@ -0,0 +1,127 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2017 MediaTek Inc.
>> + * Copyright (c) 2023 Collabora, Ltd.
>> + *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> + */
>> +
>> +#include <dt-bindings/clock/mt7622-clk.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-cpumux.h"
>> +#include "clk-gate.h"
>> +#include "clk-mtk.h"
>> +#include "reset.h"
>> +
>> +#define GATE_INFRA(_id, _name, _parent, _shift)                                \
>> +       GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
>> +
>> +static const struct mtk_gate_regs infra_cg_regs = {
>> +       .set_ofs = 0x40,
>> +       .clr_ofs = 0x44,
>> +       .sta_ofs = 0x48,
>> +};
>> +
>> +static const char * const infra_mux1_parents[] = {
>> +       "clkxtal",
>> +       "armpll",
>> +       "main_core_en",
>> +       "armpll"
>> +};
>> +
>> +static const struct mtk_composite cpu_muxes[] = {
>> +       MUX(CLK_INFRA_MUX1_SEL, "infra_mux1_sel", infra_mux1_parents, 0x000, 2, 2),
>> +};
>> +
>> +static const struct mtk_gate infra_clks[] = {
>> +       GATE_INFRA(CLK_INFRA_DBGCLK_PD, "infra_dbgclk_pd", "axi_sel", 0),
>> +       GATE_INFRA(CLK_INFRA_TRNG, "trng_ck", "axi_sel", 2),
>> +       GATE_INFRA(CLK_INFRA_AUDIO_PD, "infra_audio_pd", "aud_intbus_sel", 5),
>> +       GATE_INFRA(CLK_INFRA_IRRX_PD, "infra_irrx_pd", "irrx_sel", 16),
>> +       GATE_INFRA(CLK_INFRA_APXGPT_PD, "infra_apxgpt_pd", "f10m_ref_sel", 18),
>> +       GATE_INFRA(CLK_INFRA_PMIC_PD, "infra_pmic_pd", "pmicspi_sel", 22),
>> +};
>> +
>> +static u16 infrasys_rst_ofs[] = { 0x30 };
>> +
>> +static const struct mtk_clk_rst_desc clk_rst_desc = {
>> +       .version = MTK_RST_SIMPLE,
>> +       .rst_bank_ofs = infrasys_rst_ofs,
>> +       .rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
>> +};
>> +
>> +static const struct of_device_id of_match_clk_mt7622_infracfg[] = {
>> +       { .compatible = "mediatek,mt7622-infracfg" },
>> +       { /* sentinel */ }
>> +};
>> +
>> +static int clk_mt7622_infracfg_probe(struct platform_device *pdev)
>> +{
>> +       struct clk_hw_onecell_data *clk_data;
>> +       struct device_node *node = pdev->dev.of_node;
>> +       void __iomem *base;
>> +       int ret;
>> +
>> +       base = devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(base))
>> +               return PTR_ERR(base);
>> +
>> +       clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
>> +       if (!clk_data)
>> +               return -ENOMEM;
>> +
>> +       ret = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
>> +       if (ret)
>> +               goto free_clk_data;
>> +
>> +       ret = mtk_clk_register_gates(&pdev->dev, node, infra_clks,
>> +                                    ARRAY_SIZE(infra_clks), clk_data);
>> +       if (ret)
>> +               goto free_clk_data;
>> +
>> +       ret = mtk_clk_register_cpumuxes(&pdev->dev, node, cpu_muxes,
>> +                                       ARRAY_SIZE(cpu_muxes), clk_data);
>> +       if (ret)
>> +               goto unregister_gates;
>> +
>> +       ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>> +       if (ret)
>> +               goto unregister_cpumuxes;
>> +
>> +       return 0;
>> +
>> +unregister_cpumuxes:
>> +       mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
>> +unregister_gates:
>> +       mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
>> +free_clk_data:
>> +       mtk_free_clk_data(clk_data);
> 
> Implementing error handling deserves a separate commit, or at least a mention.
> 

Something just ticked in my brain and I think you even said that already in
a previous review?

In that case, I'm sorry for apparently ignoring that. Count that done for v3!

Regards,
Angelo

