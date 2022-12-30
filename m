Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0255659635
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiL3ISc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiL3IR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:17:58 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D461A05F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:17:56 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id d1so4655158ual.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UKptmBLuOQg1RM4zVHa29163pPmBL0D399wKsCGeJf8=;
        b=LvNoP9vLe6bcqAB3jeW57I2iLYWVxxrHHxAE39uHilcHZ6iInZxn9iXNpVYI6S6hbs
         uqsm6uaQKXnYhhYQF6xbVj2/Ja/3HTtor48an7kltiVPUAVGykta8SDU3e5xXlf9Zaru
         Led7+q/PlqhI5FT3ZPnIlOHDStqgRUxpeIF9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKptmBLuOQg1RM4zVHa29163pPmBL0D399wKsCGeJf8=;
        b=PARQUykI1VPgZPW4Hbt74cM5L0FKdVw+pld/SiFf1vErxoM5WmW0VY9fVvU5qLSKsq
         VNqeXlqCFjD3f8QwmbM38ywdAwus7D67BRfgcSHBb/bamfkt+tRZ9UHeu8OoNU+ELrA2
         ++q6501aigK+yPDjtJ+1mdmq5jrAKKHcVcvSueKkKJZyM/HEERNGytGFJvlOHYnFNY80
         Jdr2aP4XgKaJMvgJS0sua8oikpC9Mva5D3X+uUXzr6G+xeD4Azm3Tjx+x41+ZAHaxA1O
         /26BPST+/YSJQ4DGldXOuWyYrX3gU6G3dwCrgrXSlRZ8oLaaZNEPPKq1Xn50UEwnhwnz
         Jdng==
X-Gm-Message-State: AFqh2kr2FbboemJps8vlZZU/ze/BabeM+Q+Shk/vJZMIg8JOXeEZM/l0
        SiM7ywmK1og6qUvf+RYjvrfHDbfhCe0cv03ab9x5Lg==
X-Google-Smtp-Source: AMrXdXvVoiFEJpFzEVXeUJXm4MP1RYdUzBiiTLiLJOdYxjRbC1msIGJnP7BIg5ubV8Sk8yKBy18sm6YwSacIh59ToeA=
X-Received: by 2002:a9f:386b:0:b0:419:1620:be75 with SMTP id
 q40-20020a9f386b000000b004191620be75mr2823546uad.78.1672388275999; Fri, 30
 Dec 2022 00:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-17-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-17-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 16:17:45 +0800
Message-ID: <CAGXv+5GR7ef8pTVDHa20QH4hBv2rMAqoY2MjKqK5QRdbFdfDKw@mail.gmail.com>
Subject: Re: [PATCH v2 16/23] clk: mediatek: mt8186: Join top_adj_div and top_muxes
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Like done for MT8192, join the two to register them in one shot, as
> there's no point in doing that separately from one another.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt8186-topckgen.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
> index d05143891b69..63befb1f492d 100644
> --- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
> @@ -669,9 +669,6 @@ static struct mtk_composite top_muxes[] = {
>         MUX(CLK_TOP_APLL_I2S4_MCK_SEL, "apll_i2s4_mck_sel", apll_mck_parents, 0x0320, 19, 1),
>         MUX(CLK_TOP_APLL_TDMOUT_MCK_SEL, "apll_tdmout_mck_sel", apll_mck_parents,
>                 0x0320, 20, 1),
> -};
> -
> -static const struct mtk_composite top_adj_divs[] = {
>         DIV_GATE(CLK_TOP_APLL12_CK_DIV0, "apll12_div0", "apll_i2s0_mck_sel",
>                         0x0320, 0, 0x0328, 8, 0),
>         DIV_GATE(CLK_TOP_APLL12_CK_DIV1, "apll12_div1", "apll_i2s1_mck_sel",
> @@ -747,26 +744,19 @@ static int clk_mt8186_topck_probe(struct platform_device *pdev)
>         if (r)
>                 goto unregister_muxes;
>
> -       r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
> -                                       &mt8186_clk_lock, clk_data, &pdev->dev);
> -       if (r)
> -               goto unregister_composite_muxes;
> -
>         r = clk_mt8186_reg_mfg_mux_notifier(&pdev->dev,
>                                             clk_data->hws[CLK_TOP_MFG]->clk);
>         if (r)
> -               goto unregister_composite_divs;
> +               goto unregister_composite_muxes;
>
>         r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>         if (r)
> -               goto unregister_composite_divs;
> +               goto unregister_composite_muxes;
>
>         platform_set_drvdata(pdev, clk_data);
>
>         return r;
>
> -unregister_composite_divs:
> -       mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), clk_data);
>  unregister_composite_muxes:
>         mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
>  unregister_muxes:
> @@ -787,7 +777,6 @@ static int clk_mt8186_topck_remove(struct platform_device *pdev)
>
>         of_clk_del_provider(node);
>         mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), clk_data);
> -       mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), clk_data);

Wrong line? Not sure how this would've compiled.

>         mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), clk_data);
>         mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
>         mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), clk_data);
> --
> 2.39.0
>
