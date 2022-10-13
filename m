Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837F85FD8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJMMAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJMMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:00:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4683471A;
        Thu, 13 Oct 2022 05:00:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C7B256602367;
        Thu, 13 Oct 2022 13:00:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665662410;
        bh=VNVQipGNrbjuBtIH2RudWcorn7bEswqp62N/Tc0FIFA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dCO6LKtKGVYvpS7M0VYa3gC8WdkUuFuDbJImUaqCGK+OYlQsP4LSUsZQCYlv6xTxg
         IlAnmgsHkOskbIRX4NTq9Dc64xLi+L5eY5WnIw4NahpBt2VEGJ6hAnlpPcuaaxP2Jj
         6fqYf7Z8KoX5RMOWaK9UUzkP5ivb1Hv4QpHX9KlpXShikV23YhWUCYuAfPYJdHK0Xv
         OHYtckEZbt5p3GdoOeTYEy8sFWW5gImeCYlumhlS3DTJGte6ZRxhTt1JmxbGcdFIeT
         KdXyNHX/h04fkYrMn5R1MEYDOtlZfcPQx45W35pncUfaYEzmMvI3JG0Akq8nr9DyTx
         FQRTurq9X7zYQ==
Message-ID: <2e35a219-22a5-00bb-cc82-0cfdc523094d@collabora.com>
Date:   Thu, 13 Oct 2022 14:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/4] clk: mediatek: Add new clock driver to handle
 FHCTL hardware
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        kuan-hsin.lee@mediatek.com, yu-chang.wang@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
References: <20221013112336.15438-1-johnson.wang@mediatek.com>
 <20221013112336.15438-4-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221013112336.15438-4-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/10/22 13:23, Johnson Wang ha scritto:
> To implement frequency hopping and spread spectrum clocking
> function, we introduce new clock type and APIs to handle
> FHCTL hardware.
> 
> Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>   drivers/clk/mediatek/Kconfig     |   7 +
>   drivers/clk/mediatek/Makefile    |   1 +
>   drivers/clk/mediatek/clk-fhctl.c | 244 ++++++++++++++++++++++++++++
>   drivers/clk/mediatek/clk-fhctl.h |  26 +++
>   drivers/clk/mediatek/clk-pllfh.c | 268 +++++++++++++++++++++++++++++++
>   drivers/clk/mediatek/clk-pllfh.h |  82 ++++++++++
>   6 files changed, 628 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-fhctl.c
>   create mode 100644 drivers/clk/mediatek/clk-fhctl.h
>   create mode 100644 drivers/clk/mediatek/clk-pllfh.c
>   create mode 100644 drivers/clk/mediatek/clk-pllfh.h
> 

..snip..

> diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
> new file mode 100644
> index 000000000000..a728ff749db1
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-pllfh.c
> @@ -0,0 +1,268 @@

..snip..

> +
> +int mtk_clk_register_pllfhs(struct device_node *node,
> +			    const struct mtk_pll_data *plls, int num_plls,
> +			    struct mtk_pllfh_data *pllfhs, int num_fhs,
> +			    struct clk_hw_onecell_data *clk_data)
> +{
> +	void __iomem *base;
> +	int i;
> +	struct clk_hw *hw;
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("%s(): ioremap failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < num_plls; i++) {
> +		const struct mtk_pll_data *pll = &plls[i];
> +		struct mtk_pllfh_data *pllfh;

		bool use_fhctl;

		pllfh = get_pllfh_by_id(pllfhs, num_fhs, pll->id);
		use_fhctl = fhctl_is_supported_and_enabled(pllfh);

		if (use_fhctl)
			hw = mtk_clk_register_pllfh(pll, pllfh, base);
		else
			hw = mtk_clk_register_pll(pll, base);

		if (IS_ERR(hw) {
			pr_err("Failed to register %s clk %s: %d\n",
			       use_fhctl ? "fhpll" : "pll", pll->name,
			       PTR_ERR(hw));
			goto err;
		}

.... that's better.
			
> +
> +		clk_data->hws[pll->id] = hw;
> +	}
> +
> +	return 0;
> +
> +err:
> +	while (--i >= 0) {
> +		const struct mtk_pll_data *pll = &plls[i];
> +		struct mtk_pllfh_data *pllfh;
> +
> +		pllfh = get_pllfh_by_id(pllfhs, num_fhs, pll->id);
> +
> +		if (fhctl_is_supported_and_enabled(pllfh))
> +			mtk_clk_unregister_pllfh(clk_data->hws[pll->id]);
> +		else
> +			mtk_clk_unregister_pll(clk_data->hws[pll->id]);
> +
> +		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
> +	}
> +
> +	iounmap(base);
> +
> +	return PTR_ERR(hw);
> +}
> +

..snip..

> diff --git a/drivers/clk/mediatek/clk-pllfh.h b/drivers/clk/mediatek/clk-pllfh.h
> new file mode 100644
> index 000000000000..effc7976c496
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-pllfh.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Edward-JW Yang <edward-jw.yang@mediatek.com>
> + */
> +
> +#ifndef __DRV_CLKFH_H
> +#define __DRV_CLKFH_H

This should be __CLK_PLLFH_H.

...after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
