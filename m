Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA4D68CF62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjBGGQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBGGP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:15:58 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89885A0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:15:57 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id az37so7333795vkb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 22:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTjQiyosWxthU58WlgDXThqF+F9aTUK0CMslx80hUwY=;
        b=Xc7lweU8aAZbcFpCkRSu5sKNXsTPygGVdzDK1iKRJYctzI2Ct4LJTUmZS/GxSapZS/
         CWO303+bC3bUtepKEUhsg8ZgfX9ECndrkE8TmfW7yQOP4JeED3xsmX6qGZqHII2/e2fU
         7J0ZvkCUGrErw1hvGOLplhM1MxOwr/Qjc+7hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTjQiyosWxthU58WlgDXThqF+F9aTUK0CMslx80hUwY=;
        b=5EBxz4H96pImN67H5VpxcwK0LkP+vcQEfDbM0pWO6Cgq9z0nPS55IsEGZ2USEd9YCu
         4slFXqcU2x3bWlwUfXv9cCDGWNuw3n4qddXA1N9OC2mEZgbbflJNo/l9IgKYxhyoPets
         VZFCf3zsqWLv+YgkR3HtQ5KMfQ+X036+tqZvuVCqybHLs827rhmzNdvH7ZD62qV2Dsfl
         OWH1AhY2kPbmmfcrtmcoc4l4tLuIWn/pENCS4s1e7A3xvCgZOznFvVCx7JltxSc6wlBB
         Kk3fcdLGpqrR/7FZ+y+UA6vzEUSFccx3pSdEtkRBUmL4ZiacsLfHlvzlgKLjSMiuQkLr
         BiqA==
X-Gm-Message-State: AO0yUKVdR8+i6xH4UJr0aY/C0Z3s/BhgLo8XJzbIoQhojSFeMrWordVV
        0h6bhnOt9ezRD9RI2h95ulNBYpPgbTSsHpaTE5QLiQ==
X-Google-Smtp-Source: AK7set8mjFUJySYXRimSiwIbHAy8wpkjAOcLOC+zyHxCXibLAi/1kue7IPAWcZTu+ytamq1HwE3isG1vaH6/UhR2pZk=
X-Received: by 2002:a1f:a757:0:b0:3ea:94ea:110b with SMTP id
 q84-20020a1fa757000000b003ea94ea110bmr246643vke.22.1675750556666; Mon, 06 Feb
 2023 22:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 14:15:45 +0800
Message-ID: <CAGXv+5Gg60-4B29V9cYUw7b1OVcZvU+w9qdiiBbt10LJsAJiCA@mail.gmail.com>
Subject: Re: [PATCH v1 05/45] clk: mediatek: mt2712: Migrate topckgen/mcucfg
 to mtk_clk_simple_probe()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Now that the common mtk_clk_simple_{probe,remove}() functions can deal
> with divider clocks it is possible to migrate more clock drivers to it:
> in this case, it's about topckgen.
> While at it, also perform a fast migration for mcucfg.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/clk/mediatek/clk-mt2712.c | 127 +++++-------------------------
>  1 file changed, 21 insertions(+), 106 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
> index 94f8fc2a4f7b..db20c46e088b 100644
> --- a/drivers/clk/mediatek/clk-mt2712.c
> +++ b/drivers/clk/mediatek/clk-mt2712.c
> @@ -36,14 +36,11 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
>         FIXED_CLK(CLK_TOP_CVBSPLL, "cvbspll", NULL, 108000000),
>  };
>
> -static const struct mtk_fixed_factor top_early_divs[] = {
> +static const struct mtk_fixed_factor top_divs[] = {
>         FACTOR(CLK_TOP_SYS_26M, "sys_26m", "clk26m", 1,
>                 1),
>         FACTOR(CLK_TOP_CLK26M_D2, "clk26m_d2", "sys_26m", 1,
>                 2),
> -};
> -
> -static const struct mtk_fixed_factor top_divs[] = {
>         FACTOR(CLK_TOP_ARMCA35PLL, "armca35pll_ck", "armca35pll", 1,
>                 1),
>         FACTOR(CLK_TOP_ARMCA35PLL_600M, "armca35pll_600m", "armca35pll_ck", 1,
> @@ -1295,114 +1292,30 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
>         return r;
>  }
>
> -static struct clk_hw_onecell_data *top_clk_data;
> -
> -static void clk_mt2712_top_init_early(struct device_node *node)
> -{
> -       int r, i;
> -
> -       if (!top_clk_data) {
> -               top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> -
> -               for (i = 0; i < CLK_TOP_NR_CLK; i++)
> -                       top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> -       }
> -
> -       mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
> -                       top_clk_data);
> -
> -       r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
> -       if (r)
> -               pr_err("%s(): could not register clock provider: %d\n",
> -                       __func__, r);
> -}
> -
> -CLK_OF_DECLARE_DRIVER(mt2712_topckgen, "mediatek,mt2712-topckgen",
> -                       clk_mt2712_top_init_early);
> -
> -static int clk_mt2712_top_probe(struct platform_device *pdev)
> -{
> -       int r, i;
> -       struct device_node *node = pdev->dev.of_node;
> -       void __iomem *base;
> -
> -       base = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(base)) {
> -               pr_err("%s(): ioremap failed\n", __func__);
> -               return PTR_ERR(base);
> -       }
> -
> -       if (!top_clk_data) {
> -               top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> -       } else {
> -               for (i = 0; i < CLK_TOP_NR_CLK; i++) {
> -                       if (top_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
> -                               top_clk_data->hws[i] = ERR_PTR(-ENOENT);
> -               }
> -       }
> -
> -       mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
> -                       top_clk_data);
> -       mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
> -                       top_clk_data);
> -       mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
> -       mtk_clk_register_composites(&pdev->dev, top_muxes,
> -                                   ARRAY_SIZE(top_muxes), base,
> -                                   &mt2712_clk_lock, top_clk_data);
> -       mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
> -                       &mt2712_clk_lock, top_clk_data);
> -       mtk_clk_register_gates(&pdev->dev, node, top_clks,
> -                              ARRAY_SIZE(top_clks), top_clk_data);
> -
> -       r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
> -
> -       if (r != 0)
> -               pr_err("%s(): could not register clock provider: %d\n",
> -                       __func__, r);
> -
> -       return r;
> -}
> -
> -static int clk_mt2712_mcu_probe(struct platform_device *pdev)
> -{
> -       struct clk_hw_onecell_data *clk_data;
> -       int r;
> -       struct device_node *node = pdev->dev.of_node;
> -       void __iomem *base;
> -
> -       base = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(base)) {
> -               pr_err("%s(): ioremap failed\n", __func__);
> -               return PTR_ERR(base);
> -       }
> -
> -       clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
> -
> -       r = mtk_clk_register_composites(&pdev->dev, mcu_muxes,
> -                                       ARRAY_SIZE(mcu_muxes), base,
> -                                       &mt2712_clk_lock, clk_data);
> -       if (r)
> -               dev_err(&pdev->dev, "Could not register composites: %d\n", r);
> -
> -       r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> -
> -       if (r != 0)
> -               pr_err("%s(): could not register clock provider: %d\n",
> -                       __func__, r);
> +static const struct mtk_clk_desc topck_desc = {
> +       .clks = top_clks,
> +       .num_clks = ARRAY_SIZE(top_clks),
> +       .fixed_clks = top_fixed_clks,
> +       .num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
> +       .factor_clks = top_divs,
> +       .num_factor_clks = ARRAY_SIZE(top_divs),
> +       .composite_clks = top_muxes,
> +       .num_composite_clks = ARRAY_SIZE(top_muxes),
> +       .divider_clks = top_adj_divs,
> +       .num_divider_clks = ARRAY_SIZE(top_adj_divs),
> +       .clk_lock = &mt2712_clk_lock,

At some point maybe we should look into splitting up the locks to one
per block, or converting everything to regmap.

ChenYu
