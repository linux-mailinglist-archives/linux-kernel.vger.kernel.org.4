Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982496A1788
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBXHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBXHxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:53:45 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E93136F6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:53:43 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id j14so20279099vse.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vdmyGXqsuWEA5J1LKHJz/9OjkInX21YMvFtAnrWDjfY=;
        b=adA6qbq4MVAaO3KK3woJiwoMOuBmQNISBj+EVmRR/SNgcOzcS9d+nUzZPzfYwPYLmu
         ZbqTf2Zsdn/vl/g48cSS+4twwPXAG8NkA1nSxH04kVTlIC4X3i+Tz1cMxwGW2aci91j7
         pHI7rr/eT1IJedTRY6hTC+yNaAoPiwBhJHmTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdmyGXqsuWEA5J1LKHJz/9OjkInX21YMvFtAnrWDjfY=;
        b=pa3evdHUu6ZZkLATV0uSbZ+EeHA2QIXAp/OwwLiq86dUUpztHgYdXK/iRpuF7ZHa1p
         Lx1cadQBZAE2tJNdsaT97QRmLDgn28DbNQZs5HKt2aPdjxJmiXp297ppFrMyTMejDlzk
         RKDfsfHeK7RoPf5/Of7M75N+JZhsh07UXcsLnG61as+keziCVi88rYkxI2IX5o/j/ivx
         C51bOPgtwelwqMqsSiahWXIQc2ABrdvMTdA51FopONvJZVPQgnT22Sm3AUh/AQ2WBLdS
         2hat1keuvToPjFwOPn22IjuW876KgWd8H1PVvy0oC6wBjix793HBXse1/kOovnF6Iwza
         fZqA==
X-Gm-Message-State: AO0yUKWEwGq0vTg8RMV03U30vi6q4XV9B9duvY/O1PIHAlL5PaIDwp/H
        upKaGSYNq1bKLJQDtJBVXEd4Gas3fAyY7UiWIAirZw==
X-Google-Smtp-Source: AK7set9ZAp9+Vs7DCN8gO7YWRVX7TWXuw4hHRRsssi+Iv2W0TTsgH88ywdYxCBLS54DFWC5u60r7qCR10D/MbBr9UZw=
X-Received: by 2002:a1f:4343:0:b0:400:ea69:7082 with SMTP id
 q64-20020a1f4343000000b00400ea697082mr1911875vka.0.1677225222656; Thu, 23 Feb
 2023 23:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20230222092543.19187-1-angelogioacchino.delregno@collabora.com> <20230222092543.19187-54-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230222092543.19187-54-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 15:53:31 +0800
Message-ID: <CAGXv+5F6U9VZaRR3TW_rkDQrROVBGarqZJC6+ntR0d-TxJZ_Lw@mail.gmail.com>
Subject: Re: [PATCH v5 53/54] clk: mediatek: mt8135: Join root_clk_alias and
 top_divs arrays
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

On Wed, Feb 22, 2023 at 5:27 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for converting this driver to the common simple probe
> mechanism, join the root_clk_alias and top_divs mtk_fixed_factor
> arrays.
>
> This commit brings no functional change.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/clk/mediatek/clk-mt8135.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
> index 1c76c0003f99..8785d58cb3a5 100644
> --- a/drivers/clk/mediatek/clk-mt8135.c
> +++ b/drivers/clk/mediatek/clk-mt8135.c
> @@ -2,8 +2,6 @@
>  /*
>   * Copyright (c) 2014 MediaTek Inc.
>   * Author: James Liao <jamesjj.liao@mediatek.com>
> - * Copyright (c) 2023 Collabora, Ltd.
> - *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Was this meant for some other patch?

Also this is the first patch where my MT8186 fails to boot, which makes
absolutely no sense, since the MT8135 driver isn't even built.

ChenYu

>   */
>
>  #include <linux/clk.h>
> @@ -19,14 +17,12 @@
>
>  static DEFINE_SPINLOCK(mt8135_clk_lock);
>
> -static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
> +static const struct mtk_fixed_factor top_divs[] __initconst = {
>         FACTOR(CLK_TOP_DSI0_LNTC_DSICLK, "dsi0_lntc_dsiclk", "clk_null", 1, 1),
>         FACTOR(CLK_TOP_HDMITX_CLKDIG_CTS, "hdmitx_clkdig_cts", "clk_null", 1, 1),
>         FACTOR(CLK_TOP_CLKPH_MCK, "clkph_mck", "clk_null", 1, 1),
>         FACTOR(CLK_TOP_CPUM_TCK_IN, "cpum_tck_in", "clk_null", 1, 1),
> -};
>
> -static const struct mtk_fixed_factor top_divs[] __initconst = {
>         FACTOR(CLK_TOP_MAINPLL_806M, "mainpll_806m", "mainpll", 1, 2),
>         FACTOR(CLK_TOP_MAINPLL_537P3M, "mainpll_537p3m", "mainpll", 1, 3),
>         FACTOR(CLK_TOP_MAINPLL_322P4M, "mainpll_322p4m", "mainpll", 1, 5),
> @@ -534,7 +530,6 @@ static void __init mtk_topckgen_init(struct device_node *node)
>
>         clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
>
> -       mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
>         mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
>         mtk_clk_register_composites(NULL, top_muxes,
>                                     ARRAY_SIZE(top_muxes), base,
> --
> 2.39.2
>
