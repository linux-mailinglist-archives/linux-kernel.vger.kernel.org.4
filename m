Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9903968CF69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBGGRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBGGQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:16:59 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1891432E40
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:16:58 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id v26so7424301vsk.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 22:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BL5RDYzyjIW0mBHFqtPQ+SR8w2nC8B8+flvI5fBxZgw=;
        b=IuIPBVpgZ08hpK4xFIoKrvp98G7sGXKJZSPnLTiDktVAWL9NFTimGFlEOvkINklzzR
         telGKhbhhmE+xk6vt37eV3miAfiOsAR+oVKDxq9wj992ZlhH444eFPLUIkkNrMwJJGaO
         DYdfR3VLzz74L2mKpy/3al2NNCiHwl02TdcHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BL5RDYzyjIW0mBHFqtPQ+SR8w2nC8B8+flvI5fBxZgw=;
        b=EC6th3MoQ97QqoWpJZLOt04/+onjWHrlq8W9/e8vbIVoJu8sJ500P+Z5DsxYWZ2Ceg
         AnHv/X7fJpMdDNqdyGqdQ3ip9j5qQtLWJrL3S3mknCQCit+GKsEQ29GApvCK8G6JIGyW
         Sar1P+FYUoZwyZBt0VS/BDU2WSPmUICNtRAPs59PCUeUyJ0ewoe82MDFfmqFGZFCkoPk
         h4l+QgqE/t7PETDsptRQLlqxm6lVki8V5SrqCDdtno4WdEb2ArdvsilCw4SrkyG2Db/k
         Ad9dV+X4bJ/nFIvxAF5FridePMbwgbeFRVya2lMi0uVCTLD7VIhK9P/3A6Uq4iYzuYdh
         ECeQ==
X-Gm-Message-State: AO0yUKXeXFpCAFExBfFnp1uSMrs2qqDz1x9k/BMJkI3F+GkhgQC/VzRO
        9W4YxbmQi+65xCG7CyX5RMBFhNlYleDpt3MbyPGUCA==
X-Google-Smtp-Source: AK7set9i8K1ex1GvgvpZt6KGbhoq9sUGJc6ymsZdnVtxGQNh9dKmWUVTJu+n4uH1wjcaZNmg0kj24+MMLo54M70VIbY=
X-Received: by 2002:a05:6102:3d18:b0:3f7:93c4:9e56 with SMTP id
 i24-20020a0561023d1800b003f793c49e56mr549289vsv.85.1675750617274; Mon, 06 Feb
 2023 22:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-8-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 14:16:46 +0800
Message-ID: <CAGXv+5HVNSFyBncAepAhghHsjRdY=XyzsRY0Htm1KcRE7U9dfg@mail.gmail.com>
Subject: Re: [PATCH v1 07/45] clk: mediatek: mt2712: Add error handling to clk_mt2712_apmixed_probe()
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
> This function was completely missing error handling: add it.
>

Fixes tag?

Code looks OK. So once the tag is added,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt2712.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
> index ce28ee47f5cf..8aa361f0fa13 100644
> --- a/drivers/clk/mediatek/clk-mt2712.c
> +++ b/drivers/clk/mediatek/clk-mt2712.c
> @@ -1091,15 +1091,25 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
>         struct device_node *node = pdev->dev.of_node;
>
>         clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> +       if (!clk_data)
> +               return -ENOMEM;
>
> -       mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> +       r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> +       if (r)
> +               goto free_clk_data;
>
>         r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +       if (r) {
> +               dev_err(&pdev->dev, "Cannot register clock provider: %d\n", r);
> +               goto unregister_plls;
> +       }
>
> -       if (r != 0)
> -               pr_err("%s(): could not register clock provider: %d\n",
> -                       __func__, r);
> +       return 0;
>
> +unregister_plls:
> +       mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
> +free_clk_data:
> +       mtk_free_clk_data(clk_data);
>         return r;
>  }
>
> --
> 2.39.1
>
