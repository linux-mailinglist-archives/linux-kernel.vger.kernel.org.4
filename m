Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEAF746C69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGDIx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDIx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:53:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1997115;
        Tue,  4 Jul 2023 01:53:25 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 26AFE6606ED1;
        Tue,  4 Jul 2023 09:53:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688460804;
        bh=/4dyF8HZFtyp5Y+HhxEP3bwZNJAwUnFLGbeU+g9n2hg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=W3r6fyfFCV1d9e3fbQqWrqlaliK8RIJShsA3JhU6t4EZyN4iWkAeaGI3c56yX1tnH
         AIiII36iLobpWce1aQFoKmrM9lYwC30dMdNIaTPaW1W36djA7K7sMC0dGJ7po+J+Uk
         Q+0G44HIScbow+zRuk+KM1HPRgCeaOEiDzSOPZzOJpKo3zHQ4SFM1heRe3bnfSSu5y
         xmXWRoJsHcw6cSG+wAQSznNP/ZrZq5aSDyj43q5ijt5vopAk2Mcl8Uva0BeeZ1F1rP
         QI6WkjLbZKkcbgMmuKEBsqyhifcfmK+wc4uhDbV2Nblw8fX8J+67YgJVCoCFbd69t/
         WsCfOWSGdf/Mg==
Message-ID: <ef7b62ab-b1f3-b687-7561-1ab65282ba23@collabora.com>
Date:   Tue, 4 Jul 2023 10:53:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/7] ASoC: mediatek: mt7986: support audio clock
 control
Content-Language: en-US
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230626023501.11120-1-maso.huang@mediatek.com>
 <20230626023501.11120-3-maso.huang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230626023501.11120-3-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/06/23 04:34, Maso Huang ha scritto:
> Add audio clock wrapper and audio tuner control.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>   sound/soc/mediatek/mt7986/mt7986-afe-clk.c | 75 ++++++++++++++++++++++
>   sound/soc/mediatek/mt7986/mt7986-afe-clk.h | 18 ++++++
>   2 files changed, 93 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-clk.c
>   create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-clk.h
> 
> diff --git a/sound/soc/mediatek/mt7986/mt7986-afe-clk.c b/sound/soc/mediatek/mt7986/mt7986-afe-clk.c
> new file mode 100644
> index 000000000000..a8b5fae05673
> --- /dev/null
> +++ b/sound/soc/mediatek/mt7986/mt7986-afe-clk.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mt7986-afe-clk.c  --  MediaTek 7986 afe clock ctrl
> + *
> + * Copyright (c) 2021 MediaTek Inc.
> + * Author: Vic Wu <vic.wu@mediatek.com>
> + *         Maso Huang <maso.huang@mediatek.com>
> + */
> +
> +#include <linux/clk.h>
> +
> +#include "mt7986-afe-common.h"
> +#include "mt7986-afe-clk.h"
> +#include "mt7986-reg.h"
> +
> +enum {
> +	CK_INFRA_AUD_BUS_CK = 0,
> +	CK_INFRA_AUD_26M_CK,
> +	CK_INFRA_AUD_L_CK,
> +	CK_INFRA_AUD_AUD_CK,
> +	CK_INFRA_AUD_EG2_CK,
> +	CLK_NUM
> +};
> +
> +static const char *aud_clks[CLK_NUM] = {
> +	[CK_INFRA_AUD_BUS_CK] = "aud_bus_ck",
> +	[CK_INFRA_AUD_26M_CK] = "aud_26m_ck",
> +	[CK_INFRA_AUD_L_CK] = "aud_l_ck",
> +	[CK_INFRA_AUD_AUD_CK] = "aud_aud_ck",
> +	[CK_INFRA_AUD_EG2_CK] = "aud_eg2_ck",
> +};
> +
> +int mt7986_init_clock(struct mtk_base_afe *afe)
> +{
> +	struct mt7986_afe_private *afe_priv = afe->platform_priv;
> +	int ret, i;
> +
> +	afe_priv->clks = devm_kcalloc(afe->dev, CLK_NUM,
> +				sizeof(*afe_priv->clks), GFP_KERNEL);
> +	if (!afe_priv->clks)
> +		return -ENOMEM;
> +	afe_priv->num_clks = CLK_NUM;
> +
> +	for (i = 0; i < afe_priv->num_clks; i++)
> +		afe_priv->clks[i].id = aud_clks[i];
> +
> +	ret = devm_clk_bulk_get(afe->dev, afe_priv->num_clks, afe_priv->clks);
> +	if (ret)
> +		return dev_err_probe(afe->dev, ret, "Failed to get clocks\n");
> +
> +	return 0;
> +}
> +
> +int mt7986_afe_enable_clock(struct mtk_base_afe *afe)
> +{
> +	struct mt7986_afe_private *afe_priv = afe->platform_priv;
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(afe_priv->num_clks, afe_priv->clks);

You don't need a wrapper function for just a single clk_bulk_prepare_enable() call.

> +	if (ret)
> +		return dev_err_probe(afe->dev, ret, "Failed to enable clocks\n");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt7986_afe_enable_clock);
> +
> +int mt7986_afe_disable_clock(struct mtk_base_afe *afe)
> +{
> +	struct mt7986_afe_private *afe_priv = afe->platform_priv;
> +
> +	clk_bulk_disable_unprepare(afe_priv->num_clks, afe_priv->clks);

Same for this one....

... which means that this file will have only mt7986_init_clock() so, ultimately,
you don't need a mt7986-afe-clk.c file at all.
Please merge this logic into mt7986-afe-pcm.c, which is also the only user of it.

Thanks,
Angelo

