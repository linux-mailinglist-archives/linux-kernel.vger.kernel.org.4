Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7076B4AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjCJP1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjCJP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:27:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570C12BAFC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:16:08 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id h8so5887836plf.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678461329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N39RYo79xVBTcwlXscYbtTZ48SrQ3sOuHu+uQiLwf8c=;
        b=w1JpB/ZXvlR8nFbbRuZV13kAgblsxjtJ382xgxW9UzeSI+B3oi7mBtHDPakrflKi67
         JEBe94Y824l+0EwHf05dF7FlkT9y8wmKkarFG4sWdJL55Wwae2RTDpbR/R/OFLLWtYin
         nnGg0qDwFoPWvYHnbjgHLy2xwM5j3JVsUUWeGS6e9y9AJ6DplPucBwRDbAGCHyIVgtuw
         mpZQEid0BvuDl7uBW9S9czZUiFClNkfN24ZMMNQcVse1m/k2fAAZ6R2yQxufCg9Du3UH
         fHMEbaC+qfeXuWUHMsgJD4IzOJ5KHY1Gte9k9hGYwnmeEpY/4DhTggH+2PkFxuzYJYui
         zBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N39RYo79xVBTcwlXscYbtTZ48SrQ3sOuHu+uQiLwf8c=;
        b=4JfQVlUNbpCXGMYcaQlZTHWPglWQYcuGhn6XKRXgoGl6eFcxOUhckfOmZv9WJErkPq
         OchvMCWLibpTdgQ+X83foHtU7BjrviG5tjp7SnSGSUbxe51/Ii6uY/oI9Ltwjm2+UMY2
         l9GC1qbmGdVmN/h4CONwiwd1/Iv5yFshZnoBdqYV/+ysXsMuJhNGFyP+srMHUyLXYK5b
         7pWNRVJJp6Mkn7TfJiXJUFHjD0ekSkdbNZFX0dyT1NOXVSk70mNWNsvCkLfWmsGsZmGv
         adeyvU0Tek0U/pH7A5jUhIwNAhWSbZR8WtVMuqzeK+HuwGC5cqp8SRP1tzjYGK3ZBYbL
         XBSQ==
X-Gm-Message-State: AO0yUKW3fH7vyxL8P6xo+W5zYHbFWP+q7t/9ryk86oCz7z7iAi7RhFj9
        rCEkvIda5nYzgiuRSgeryZNhpFDBFjURNm9GAPFJyw==
X-Google-Smtp-Source: AK7set8wBPd3eR19/8FgGsEp0qu4kQMyEwrIG9kwt+pd8OJGY+yyFJ7UbTDzC6DqHo/XP34E4Wgb+nv47hPzv4BDAio=
X-Received: by 2002:a17:90b:1283:b0:234:925b:7d61 with SMTP id
 fw3-20020a17090b128300b00234925b7d61mr9645631pjb.9.1678461328917; Fri, 10 Mar
 2023 07:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20230310144715.1543836-1-robh@kernel.org>
In-Reply-To: <20230310144715.1543836-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Mar 2023 16:14:52 +0100
Message-ID: <CAPDyKFrwH0uEZ+ikvaPkwsmT6-JoZwDC7SCfS-TX_pXyh38+-A@mail.gmail.com>
Subject: Re: [PATCH] mmc: Use of_property_read_bool() for boolean properties
To:     Rob Herring <robh@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 at 15:48, Rob Herring <robh@kernel.org> wrote:
>
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c            | 22 +++++++++++-----------
>  drivers/mmc/host/omap_hsmmc.c      |  8 ++++----
>  drivers/mmc/host/sdhci-esdhc-imx.c |  4 ++--
>  drivers/mmc/host/sdhci-pxav2.c     |  2 +-
>  drivers/mmc/host/sdhci-s3c.c       |  4 ++--
>  drivers/mmc/host/tmio_mmc_core.c   |  2 +-
>  drivers/mmc/host/wmt-sdmmc.c       |  6 ++----
>  7 files changed, 23 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index b9e5dfe74e5c..f2b2e8b0574e 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1962,28 +1962,28 @@ static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
>         if (ret)
>                 return ret;
>
> -       if (of_get_property(np, "st,sig-dir-dat0", NULL))
> +       if (of_property_read_bool(np, "st,sig-dir-dat0"))
>                 host->pwr_reg_add |= MCI_ST_DATA0DIREN;
> -       if (of_get_property(np, "st,sig-dir-dat2", NULL))
> +       if (of_property_read_bool(np, "st,sig-dir-dat2"))
>                 host->pwr_reg_add |= MCI_ST_DATA2DIREN;
> -       if (of_get_property(np, "st,sig-dir-dat31", NULL))
> +       if (of_property_read_bool(np, "st,sig-dir-dat31"))
>                 host->pwr_reg_add |= MCI_ST_DATA31DIREN;
> -       if (of_get_property(np, "st,sig-dir-dat74", NULL))
> +       if (of_property_read_bool(np, "st,sig-dir-dat74"))
>                 host->pwr_reg_add |= MCI_ST_DATA74DIREN;
> -       if (of_get_property(np, "st,sig-dir-cmd", NULL))
> +       if (of_property_read_bool(np, "st,sig-dir-cmd"))
>                 host->pwr_reg_add |= MCI_ST_CMDDIREN;
> -       if (of_get_property(np, "st,sig-pin-fbclk", NULL))
> +       if (of_property_read_bool(np, "st,sig-pin-fbclk"))
>                 host->pwr_reg_add |= MCI_ST_FBCLKEN;
> -       if (of_get_property(np, "st,sig-dir", NULL))
> +       if (of_property_read_bool(np, "st,sig-dir"))
>                 host->pwr_reg_add |= MCI_STM32_DIRPOL;
> -       if (of_get_property(np, "st,neg-edge", NULL))
> +       if (of_property_read_bool(np, "st,neg-edge"))
>                 host->clk_reg_add |= MCI_STM32_CLK_NEGEDGE;
> -       if (of_get_property(np, "st,use-ckin", NULL))
> +       if (of_property_read_bool(np, "st,use-ckin"))
>                 mmci_probe_level_translator(mmc);
>
> -       if (of_get_property(np, "mmc-cap-mmc-highspeed", NULL))
> +       if (of_property_read_bool(np, "mmc-cap-mmc-highspeed"))
>                 mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
> -       if (of_get_property(np, "mmc-cap-sd-highspeed", NULL))
> +       if (of_property_read_bool(np, "mmc-cap-sd-highspeed"))
>                 mmc->caps |= MMC_CAP_SD_HIGHSPEED;
>
>         return 0;
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4bd744755205..517dde777413 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1736,18 +1736,18 @@ static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>         if (legacy && legacy->name)
>                 pdata->name = legacy->name;
>
> -       if (of_find_property(np, "ti,dual-volt", NULL))
> +       if (of_property_read_bool(np, "ti,dual-volt"))
>                 pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
>
> -       if (of_find_property(np, "ti,non-removable", NULL)) {
> +       if (of_property_read_bool(np, "ti,non-removable")) {
>                 pdata->nonremovable = true;
>                 pdata->no_regulator_off_init = true;
>         }
>
> -       if (of_find_property(np, "ti,needs-special-reset", NULL))
> +       if (of_property_read_bool(np, "ti,needs-special-reset"))
>                 pdata->features |= HSMMC_HAS_UPDATED_RESET;
>
> -       if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
> +       if (of_property_read_bool(np, "ti,needs-special-hs-handling"))
>                 pdata->features |= HSMMC_HAS_HSPE_SUPPORT;
>
>         return pdata;
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 58f042fdd4f4..d7c0c0b9e26c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1597,7 +1597,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>         struct esdhc_platform_data *boarddata = &imx_data->boarddata;
>         int ret;
>
> -       if (of_get_property(np, "fsl,wp-controller", NULL))
> +       if (of_property_read_bool(np, "fsl,wp-controller"))
>                 boarddata->wp_type = ESDHC_WP_CONTROLLER;
>
>         /*
> @@ -1614,7 +1614,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>
>         of_property_read_u32(np, "fsl,strobe-dll-delay-target",
>                                 &boarddata->strobe_dll_delay_target);
> -       if (of_find_property(np, "no-1-8-v", NULL))
> +       if (of_property_read_bool(np, "no-1-8-v"))
>                 host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>
>         if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index fc306eb1f845..91aca8f8d6ef 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -228,7 +228,7 @@ static struct sdhci_pxa_platdata *pxav2_get_mmc_pdata(struct device *dev)
>         if (!pdata)
>                 return NULL;
>
> -       if (of_find_property(np, "non-removable", NULL))
> +       if (of_property_read_bool(np, "non-removable"))
>                 pdata->flags |= PXA_FLAG_CARD_PERMANENT;
>
>         of_property_read_u32(np, "bus-width", &bus_width);
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 9085f3932443..504015e84308 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -437,12 +437,12 @@ static int sdhci_s3c_parse_dt(struct device *dev,
>         pdata->max_width = max_width;
>
>         /* get the card detection method */
> -       if (of_get_property(node, "broken-cd", NULL)) {
> +       if (of_property_read_bool(node, "broken-cd")) {
>                 pdata->cd_type = S3C_SDHCI_CD_NONE;
>                 return 0;
>         }
>
> -       if (of_get_property(node, "non-removable", NULL)) {
> +       if (of_property_read_bool(node, "non-removable")) {
>                 pdata->cd_type = S3C_SDHCI_CD_PERMANENT;
>                 return 0;
>         }
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index e24c3d284515..be7f18fd4836 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1084,7 +1084,7 @@ static void tmio_mmc_of_parse(struct platform_device *pdev,
>          * For new platforms, please use "disable-wp" instead of
>          * "toshiba,mmc-wrprotect-disable"
>          */
> -       if (of_get_property(np, "toshiba,mmc-wrprotect-disable", NULL))
> +       if (of_property_read_bool(np, "toshiba,mmc-wrprotect-disable"))
>                 mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
>  }
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 9aa3027ca25e..68525d900046 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -802,10 +802,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         priv->power_inverted = 0;
>         priv->cd_inverted = 0;
>
> -       if (of_get_property(np, "sdon-inverted", NULL))
> -               priv->power_inverted = 1;
> -       if (of_get_property(np, "cd-inverted", NULL))
> -               priv->cd_inverted = 1;
> +       priv->power_inverted = of_property_read_bool(np, "sdon-inverted");
> +       priv->cd_inverted = of_property_read_bool(np, "cd-inverted");
>
>         priv->sdmmc_base = of_iomap(np, 0);
>         if (!priv->sdmmc_base) {
> --
> 2.39.2
>
