Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23EF5EC22D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiI0MO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiI0MOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:14:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA4BAFADD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:14:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r10-20020a1c440a000000b003b494ffc00bso1186028wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VNMJ8dAUFpnWH5my97l4aBgOKeowx7PWc9A+8a4PR10=;
        b=Opaisrf0YyM9ixDUEygxXwqhLUcxRIYHwPrAdD1EsngI+gSnI/P5zTxmU4bHQwEbZ8
         mLS0ZeKunZyelGY7r82jc+c5L3r/JpLt8UQpXsMKRmpz5Pz2xtF+J8jjul5+9LnuS92y
         9cO+ajXsttOxz6Qyg3KHTsGYzFnpF84e9Jgo3zX63DixeXqh8pwgY67PmOvHafSrJixr
         D+mGcn1nE1vTyE4IQ0J8ipqVDJDMOsusEDI+X83E2+//Hnt8lp5exKgzO+Fwqki9Obev
         NMj8LPhCmysizM4Y+L3j8Zh1R462w6ohWMR5FQU626vJckfUGFcOznxcydQY/ogLDdnF
         akAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VNMJ8dAUFpnWH5my97l4aBgOKeowx7PWc9A+8a4PR10=;
        b=2sywbJGlWaqEzxp33t1NStB4uNbHhN9lZ6rPZfxC3i1rCFW0/bKF6vGe/IGmy/9k4/
         9lsS5W3mnSjNz7S08yx0DlzLEmlp0ak9VL34iavIvXaglQ4ZdpJER4+qvnXdCYk2Mus4
         F+ovMCPoRFp2SVcUJncWsocgd7UvlsRgpbel1VcEwb714tz7WJAkpMATCEJaNHFE8gPA
         mh9dkJZSD4Gr1+0lp7v6uXajq3gC9S0f9kapBuUHvB2YxfoInH7sL9uDVm2YuUK9ll4x
         XRlaHx617b7ktbLrNE80BBivHGIKd7zvOnRbMsdhSbrPNU8KC2yL8/SGAy0InQMdpbSL
         iXmQ==
X-Gm-Message-State: ACrzQf06wKTGdYvYN30Z3yuizwf2nvQxbIsOKwH5fnUNzuwbrFU+dgNS
        iPeAh/psvck5NgwQwM/klFRVwKn7e0Lm4nBwUYpRwYD3tjo=
X-Google-Smtp-Source: AMsMyM5xwt8GtZ5GqRGo+ZWthPbEfmJgCcSjohJZ+6LcAxXTNx9DpuzY2FpP0asC0lryGBBctHMQcUWoC+0O6+WUrgk=
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id
 n13-20020a05600c4f8d00b003b49f2f4311mr2366068wmq.17.1664280855969; Tue, 27
 Sep 2022 05:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <53fc6ffa5d1c428fefeae7d313cf4a669c3a1e98.1663873255.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <53fc6ffa5d1c428fefeae7d313cf4a669c3a1e98.1663873255.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 14:13:39 +0200
Message-ID: <CAPDyKFrLvXhnEgx5JjvnUnrTWsAid-2Wvgj3ypEU5AetkT+6JQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: wmt-sdmmc: Fix an error handling path in wmt_mci_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     cjb@laptop.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sept 2022 at 21:06, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> A dma_free_coherent() call is missing in the error handling path of the
> probe, as already done in the remove function.
>
> Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
>   * Add and use the (ugly named) 'fail5_and_a_half' label   [Dan Carpenter <dan.carpenter@oracle.com>]
>
> v1: https://lore.kernel.org/all/bf2e2e69226b20d173cce66287f59488fd47474b.1646588375.git.christophe.jaillet@wanadoo.fr/
> ---
>  drivers/mmc/host/wmt-sdmmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 163ac9df8cca..9b5c503e3a3f 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -846,7 +846,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->clk_sdmmc)) {
>                 dev_err(&pdev->dev, "Error getting clock\n");
>                 ret = PTR_ERR(priv->clk_sdmmc);
> -               goto fail5;
> +               goto fail5_and_a_half;
>         }
>
>         ret = clk_prepare_enable(priv->clk_sdmmc);
> @@ -863,6 +863,9 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         return 0;
>  fail6:
>         clk_put(priv->clk_sdmmc);
> +fail5_and_a_half:
> +       dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
> +                         priv->dma_desc_buffer, priv->dma_desc_device_addr);
>  fail5:
>         free_irq(dma_irq, priv);
>  fail4:
> --
> 2.34.1
>
