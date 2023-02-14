Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BFC696350
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjBNMTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjBNMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:19:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E3627488
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:18:59 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b5so16864413plz.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Xh0puu3pBwVerTFteBcL8T1N51CVp7Tov2k34ecZpM=;
        b=Ik5m6qKBsYSBjKFm9MAJwpLRavqbfuB3z9MYaBBOFn3imdsVzdF8gf5+X13cMxYsMh
         RijGQHbYNPvA0zs88a3juJZdr7DkuoT0e7O2V7ET4//GTmZy9HjC2I6UUtvZNsSGq89M
         iP41YPTvmVSCNB0zB/LRi9RJbRdo4UrpBI33tJtAWhW/ttu8j0JQIF1dkwKGSuRQP4js
         aW0DtrQ5phzRVE2V7V1g2vwExuE2sIPur5dDECl44Wa9VY3OGSqUohRrM65Nme5x9cXA
         lnzXCwxZqVsPUs1KJAhNdU8LvjGIMQ99VRnpoCLHiZL4ymkDfdUvyOIctPUfK1l2NsHY
         /gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Xh0puu3pBwVerTFteBcL8T1N51CVp7Tov2k34ecZpM=;
        b=m71zJnCL4aUet521m9ah87gDzMxFee4rIWFBX3frpI8z4ZPYEpjCxoBe7iCHVDefjB
         w/ZJ+3hBTrL0ZFjsDMzbMKDQCOoD6per0C2xmt5NKlHvEECxkdYVjgvGJdejRN9KpvP4
         lQ2S0Lslc2Cxo2tkHQSelA0sOjpiIbgI/5HH0u+majWgUkoauEvu+0PvaJ3Q6IyjU1Iz
         bOL2qTn9ohCbeX5BXhluFWU/4tanqcejuieBRqcGF24DvX9+Uy9ZLgbRzXZxKu6JX6Tx
         DTcHosfrHBghTtAIKZY+EJvPH5Kn84YFJoUDMtNcnufmhBY2UId9Yl+BTZWXuyxojuvv
         BiUw==
X-Gm-Message-State: AO0yUKXbDnuMWDkGwkTVwHLeJDzTR/f/AdNobq1ugpnNJ0lpwjsGykNN
        ExZBjlLlJRKu4naWZhfaXcZzqBS+/ZaDq8O2at1VRA==
X-Google-Smtp-Source: AK7set8y6ih7+HG36KQ91giji/BrdDd/UJeTMMIq46RK+Piw24wVk53b337RaQNnFoMPo1DMXqwBgByzbplW1g++Oew=
X-Received: by 2002:a17:90a:c90f:b0:233:ba2c:16a6 with SMTP id
 v15-20020a17090ac90f00b00233ba2c16a6mr2976614pjt.109.1676377138128; Tue, 14
 Feb 2023 04:18:58 -0800 (PST)
MIME-Version: 1.0
References: <202302101628321403257@zte.com.cn>
In-Reply-To: <202302101628321403257@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 13:18:21 +0100
Message-ID: <CAPDyKFp-1FCcWJE7K+kGvvcTvNhOo69Wb4R1UNWKOsN=1dLBwg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Use devm_platform_get_and_ioremap_resource()
To:     ye.xingchen@zte.com.cn
Cc:     kdasu.kdev@gmail.com, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, adrian.hunter@intel.com,
        f.fainelli@gmail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 at 09:28, <ye.xingchen@zte.com.cn> wrote:
>
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 0a19b7af1d41..4c22337199cf 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -255,7 +255,6 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>         struct sdhci_brcmstb_priv *priv;
>         u32 actual_clock_mhz;
>         struct sdhci_host *host;
> -       struct resource *iomem;
>         struct clk *clk;
>         struct clk *base_clk = NULL;
>         int res;
> @@ -291,8 +290,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>         }
>
>         /* Map in the non-standard CFG registers */
> -       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       priv->cfg_regs = devm_ioremap_resource(&pdev->dev, iomem);
> +       priv->cfg_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
>         if (IS_ERR(priv->cfg_regs)) {
>                 res = PTR_ERR(priv->cfg_regs);
>                 goto err;
> --
> 2.25.1
