Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4ED68D366
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjBGKAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjBGKAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:00:04 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FF538B49
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:58:57 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id ay40so1915444uab.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UKAmol5TEfreTL5fKdpmvKgwo5MvEZ/OuY/L64/Fn9E=;
        b=AZV4fMKX+dB8v9gtL3/NQ3H33vsLvwVLIdCYSUSfg1+f1LloGk9pSR5kh1LstZgzw+
         GQGd0uIxU6CK77aZHfjUqB/nR9M3KuOtmYZnodL5zZGUpNVUa96WkGYbHZGZd1IVjBU6
         vAj7/ZL9+vTMdvnot/sbpUuYnRnhYk+YlPU1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKAmol5TEfreTL5fKdpmvKgwo5MvEZ/OuY/L64/Fn9E=;
        b=ThLEdXWlpb7OWQDUkr+S3gUhOB+MAVbnj0cIQ8Qkc5xv9hvp+mrAFOdme/iL28sAJn
         E8MVzSXj3xgC6y43nAf3fmbvC8ufrskMo5iGGahoQ7kyW33SoCn0LbgVrQKWuBd7GYTs
         +uh4o8dzSgpQLB+yIlwLJdVmSjLtiPGGsi4bV0xvomnel4PcLERNYkcYJDy4Ku6JfYPp
         9Ft3OkdcvDOwPbtzpfcNTxcEgJpFU4TMSVFSvh0Nlo+Kw+AgKKuSgUJOdk5ccu8XpSMU
         oaMtYvFUp8MQpE4Nur5HqEV8N3sDc1JZv4zLqPazSKGwBMyESN3L7o5xDkU0usyEg/6m
         cS9Q==
X-Gm-Message-State: AO0yUKWByOXj/Bo+h0SAXW0jCFsdAHy3QrW0Yq0zo5iFHv2FyzQq/2qd
        ydLzel+qF9q7F5ZSb8X1pxdTPRn7QFLP/BnmYxm8wA==
X-Google-Smtp-Source: AK7set8wPm+MBZbJ1SW1ybEspzYBJqRZjEkamn0E1uxwefeZPiIVj7iCo/N7wDPzLvH1BFASR6ba2PJiEhF8i5UizQ4=
X-Received: by 2002:ab0:76c4:0:b0:5f0:4676:e4f1 with SMTP id
 w4-20020ab076c4000000b005f04676e4f1mr501137uaq.44.1675763936243; Tue, 07 Feb
 2023 01:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-20-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-20-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 17:58:45 +0800
Message-ID: <CAGXv+5G0ksgGMXUGk-=CXUANtGQa2M5RLY+wG7c-0cMSKS5DJQ@mail.gmail.com>
Subject: Re: [PATCH v1 19/45] clk: mediatek: mt8183: Convert all remaining
 clocks to common probe
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Switch to mtk_clk_simple_{probe,remove}() for infracfg and topckgen
> clocks on MT8183 to allow full module build for clock drivers.
> In order to do this, like done for other MediaTek clock drivers, it
> was necessary to join top_early_divs with top_divs and to stop
> registering the `clk13m` clock early.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt8183.c | 160 ++++++------------------------
>  1 file changed, 28 insertions(+), 132 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 0fad2cf7f41b..035fdd02f0be 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -25,11 +25,8 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
>         FIXED_CLK(CLK_TOP_UNIVP_192M, "univpll_192m", "univpll", 192000000),
>  };
>
> -static const struct mtk_fixed_factor top_early_divs[] = {
> -       FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),
> -};
> -
>  static const struct mtk_fixed_factor top_divs[] = {
> +       FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),

A clock with the same name is now present in the DT, and so this clock
would fail to register. We should drop this one completely and point
any references to it internally to "csw_f26m_ck_d2".

>         FACTOR(CLK_TOP_F26M_CK_D2, "csw_f26m_ck_d2", "clk26m", 1, 2),

MT8192 and MT8195 aren't affected because they only have "csw_f26m_ck_d2",
which systimer was referencing.

>         FACTOR_FLAGS(CLK_TOP_SYSPLL_CK, "syspll_ck", "mainpll", 1, 1, 0),
>         FACTOR_FLAGS(CLK_TOP_SYSPLL_D2, "syspll_d2", "syspll_ck", 1, 2, 0),
> @@ -809,26 +806,6 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
>         .rst_bank_nr = ARRAY_SIZE(infra_rst_ofs),
>  };
>
> -static struct clk_hw_onecell_data *top_clk_data;
> -
> -static void clk_mt8183_top_init_early(struct device_node *node)
> -{
> -       int i;
> -
> -       top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> -
> -       for (i = 0; i < CLK_TOP_NR_CLK; i++)
> -               top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> -
> -       mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
> -                       top_clk_data);

And since we used to not do error checking, the name conflict was OK.
With the new common probe, it's not.

ChenYu
