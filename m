Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249F26595A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiL3HOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiL3HOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:14:44 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D954618B1B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:14:41 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id m2so20500003vsv.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a8F4zzV/vu1q4g0plcu6P3mnsAHtPvIOrW+ZJBWEg+E=;
        b=ECRs6s2lm792mTvvDaGmappALn9IJ1FxWTnPjsUmFd+98x4+MqXc6uuKzC5EeGg6gQ
         v8xVHUT4t9v3qq+yEBJaykPBOAEqa9eXhsaB9+zsThYh2o1vj3ZSXpGF02pPLKi/INVh
         Ezr+JfuKthFSrL0TlmY0yvLe/Bo+QZOicPGWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8F4zzV/vu1q4g0plcu6P3mnsAHtPvIOrW+ZJBWEg+E=;
        b=WxXmeD8V8Ex9N2dqwEJ6Si2brs9mRBU0dCzMVFWKPa/mU4NZ1JLSW3C5snjUT0YYBF
         yqxB3dnw6XV8gp/XN6QbEFqDsse2s/Hc7GbqXPPmENnPaxQntMKz7iIs1h1MRYDbpcYO
         R3GwQFpTdvKyCmKuQF8kG/XJtXYGjcS26OR0/bmT0zgSVNpXlYwXu/y0swNyyVZH4Y7O
         GAtMavFeU/TyU1ExZrzyw9l34zfgLQ2TQXgINyLnjUVJZWH8Os3vqs1ly1nwMoSQGOs9
         storh/gVtKGi9lsNFx2ImHZBlXw32OEk6ZsdXtGRTpEYEMtXHag3FzedldDL6a3+s4aL
         NM+w==
X-Gm-Message-State: AFqh2koUzitgd0PdU2jGZs2K4tUv9vpyqwEPMk7R3tBCHvf4omT50QVx
        vabbC0CexT1RHgry/qF5IzZST9nNvxAOqcYeNH5p9w==
X-Google-Smtp-Source: AMrXdXsBKahjZiIz8GIZGM9hHBUj2ovAFRxVWv0Ln6hq7bm27mA8O1d5BlU91ycIAu2cd1gvqaT+Nk4TP644ARCusgE=
X-Received: by 2002:a05:6102:4427:b0:3b0:6da7:39ba with SMTP id
 df39-20020a056102442700b003b06da739bamr4325181vsb.26.1672384480981; Thu, 29
 Dec 2022 23:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-13-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 15:14:29 +0800
Message-ID: <CAGXv+5HC3BpO0RKUgpkNxsRtLJ+0+-WgfU8H55JSJ3ETTeRPVg@mail.gmail.com>
Subject: Re: [PATCH v2 12/23] clk: mediatek: clk-mtk: Extend mtk_clk_simple_probe()
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> As a preparation to increase probe functions commonization across
> various MediaTek SoC clock controller drivers, extend function
> mtk_clk_simple_probe() to be able to register not only gates, but
> also fixed clocks, factors, muxes and composites.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 101 ++++++++++++++++++++++++++++++---
>  drivers/clk/mediatek/clk-mtk.h |  10 ++++
>  2 files changed, 103 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index d05364e17e95..b0a6225cd7b2 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -11,12 +11,14 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
>  #include "clk-mtk.h"
>  #include "clk-gate.h"
> +#include "clk-mux.h"
>
>  const struct mtk_gate_regs cg_regs_dummy = { 0, 0, 0 };
>
> @@ -465,20 +467,71 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>         const struct mtk_clk_desc *mcd;
>         struct clk_hw_onecell_data *clk_data;
>         struct device_node *node = pdev->dev.of_node;
> -       int r;
> +       void __iomem *base;
> +       int num_clks, r;
>
>         mcd = of_device_get_match_data(&pdev->dev);
>         if (!mcd)
>                 return -EINVAL;
>
> -       clk_data = mtk_alloc_clk_data(mcd->num_clks);
> +       /* Composite clocks needs us to pass iomem pointer */
> +       if (mcd->composite_clks) {
> +               if (!mcd->shared_io)
> +                       base = devm_platform_ioremap_resource(pdev, 0);
> +               else
> +                       base = of_iomap(node, 0);
> +
> +               if (IS_ERR_OR_NULL(base))
> +                       return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
> +       }
> +
> +       /* Calculate how many clk_hw_onecell_data entries to allocate */
> +       num_clks = mcd->num_clks + mcd->num_composite_clks;
> +       num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
> +       num_clks += mcd->num_mux_clks;
> +
> +       clk_data = mtk_alloc_clk_data(num_clks);
>         if (!clk_data)
>                 return -ENOMEM;
>
> -       r = mtk_clk_register_gates(node, mcd->clks, mcd->num_clks,
> -                                  clk_data, &pdev->dev);
> -       if (r)
> -               goto free_data;
> +       if (mcd->fixed_clks) {
> +               r = mtk_clk_register_fixed_clks(mcd->fixed_clks,
> +                                               mcd->num_fixed_clks, clk_data);
> +               if (r)
> +                       goto free_data;
> +       }
> +
> +       if (mcd->factor_clks) {
> +               r = mtk_clk_register_factors(mcd->factor_clks,
> +                                            mcd->num_factor_clks, clk_data);
> +               if (r)
> +                       goto unregister_fixed_clks;
> +       }
> +
> +       if (mcd->mux_clks) {
> +               r = mtk_clk_register_muxes(mcd->mux_clks, mcd->num_mux_clks,
> +                                          node, mcd->clk_lock, clk_data,
> +                                          &pdev->dev);
> +               if (r)
> +                       goto unregister_factors;
> +       };
> +
> +       if (mcd->composite_clks) {
> +               /* We don't check composite_lock because it's optional */
> +               r = mtk_clk_register_composites(mcd->composite_clks,
> +                                               mcd->num_composite_clks,
> +                                               base, mcd->clk_lock,
> +                                               clk_data, &pdev->dev);
> +               if (r)
> +                       goto unregister_muxes;
> +       }
> +
> +       if (mcd->clks) {
> +               r = mtk_clk_register_gates(node, mcd->clks, mcd->num_clks,
> +                                          clk_data, &pdev->dev);
> +               if (r)
> +                       goto unregister_composites;
> +       }
>
>         r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>         if (r)
> @@ -496,9 +549,28 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>         return r;
>
>  unregister_clks:
> -       mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
> +       if (mcd->clks)
> +               mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
> +unregister_composites:
> +       if (mcd->composite_clks)
> +               mtk_clk_unregister_composites(mcd->composite_clks,
> +                                             mcd->num_composite_clks, clk_data);
> +unregister_muxes:
> +       if (mcd->mux_clks)
> +               mtk_clk_unregister_muxes(mcd->mux_clks,
> +                                        mcd->num_mux_clks, clk_data);
> +unregister_factors:
> +       if (mcd->factor_clks)
> +               mtk_clk_unregister_factors(mcd->factor_clks,
> +                                          mcd->num_factor_clks, clk_data);
> +unregister_fixed_clks:
> +       if (mcd->fixed_clks)
> +               mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
> +                                             mcd->num_fixed_clks, clk_data);
>  free_data:
>         mtk_free_clk_data(clk_data);
> +       if (mcd->shared_io && base)
> +               iounmap(base);
>         return r;
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
> @@ -510,7 +582,20 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
>         struct device_node *node = pdev->dev.of_node;
>
>         of_clk_del_provider(node);
> -       mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
> +       if (mcd->clks)
> +               mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
> +       if (mcd->composite_clks)
> +               mtk_clk_unregister_composites(mcd->composite_clks,
> +                                             mcd->num_composite_clks, clk_data);
> +       if (mcd->mux_clks)
> +               mtk_clk_unregister_muxes(mcd->mux_clks,
> +                                        mcd->num_mux_clks, clk_data);
> +       if (mcd->factor_clks)
> +               mtk_clk_unregister_factors(mcd->factor_clks,
> +                                          mcd->num_factor_clks, clk_data);
> +       if (mcd->fixed_clks)
> +               mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
> +                                             mcd->num_fixed_clks, clk_data);
>         mtk_free_clk_data(clk_data);
>
>         return 0;
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index dd43235285db..1d036ba6ca07 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -220,7 +220,17 @@ void mtk_clk_unregister_ref2usb_tx(struct clk_hw *hw);
>  struct mtk_clk_desc {
>         const struct mtk_gate *clks;
>         size_t num_clks;

I would've suggested renaming this to "gates" as well, but that seems
likely to cause additional unnecessary churn. Maybe you could leave
a comment in the header about this "historical reason"?

> +       const struct mtk_composite *composite_clks;
> +       size_t num_composite_clks;
> +       const struct mtk_fixed_clk *fixed_clks;
> +       size_t num_fixed_clks;
> +       const struct mtk_fixed_factor *factor_clks;
> +       size_t num_factor_clks;
> +       const struct mtk_mux *mux_clks;
> +       size_t num_mux_clks;

Nit: I would order these based on the order they are used/registered.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

>         const struct mtk_clk_rst_desc *rst_desc;
> +       spinlock_t *clk_lock;
> +       bool shared_io;
>  };
>
>  int mtk_clk_simple_probe(struct platform_device *pdev);
> --
> 2.39.0
>
