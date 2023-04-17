Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3395F6E4C02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjDQOzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjDQOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:55:05 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671FE9EEB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:52 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id m14so8678300ybk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743291; x=1684335291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X5Hf/UiW8fMQe86HypOJ09uF879JSlzBCXY8H8UW8D8=;
        b=cX4u6RU3ZsOLpMlDkCDthwGRDUBMdKasT50TlEFx6jucCWx5QoQ0e2sLa1W+79T98a
         RCPAfW88xqXV4rSzK5exeu2xCWeHVW5YB1+J/Efd9h7AX50Ubax6lNU78Tc8gwHODVZI
         mnX+tW6sOnWmDpf3BhDzTLy+y9huKSeMHLwyKZ77LElDRV8OYR5PWwX6nHVGesIOrR0n
         EmJocjBv8dgE7HxKEZ+orBOckdMyJArI9Xm2PS3u4AbQo2A1Jn4ekrIMXt2UnZyuQgIA
         6CvW5DOewP+VpaM5aO1buxkW0g7TuZe+3Sy9569X367xErSQ4ep+dJ1Mn509/gj+GWLl
         jZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743291; x=1684335291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5Hf/UiW8fMQe86HypOJ09uF879JSlzBCXY8H8UW8D8=;
        b=TTmIfswSwZT1DqswtUrGuuKw8Mkc/WJDJyGxyrWGFMmHBmDiZvTPZOpqiI7vRwLvU+
         TPWe0q/8MJvW4rLLWlNdm4SHf4fDmaIgpUUAtrbDt+KMm4zgO4QontJefa+8klH+JzkV
         mmS8a5TiacZsRPwdQ3DH3Gn/FI7e1xPqSckPOoM9SeiTqHmRsHLDq6K5dvSeYv2KBDXL
         7kYUlaAiP0TzJCvqS8GKMR0BuD8KMR4jGB4w9g76ThVlHZAJ/7kcn3PCOZMoblswR32Y
         EIlgygTlE57jCB45tjubE9VbcSjzkd5G3opxPHSGYYYcYutwT6s8L8FoZaztGNSN78rO
         MqaQ==
X-Gm-Message-State: AAQBX9fML0AdcoEsjcxGErRPYEBeKNH9xkEE2mAhYS5dwcLA+J1B4YwT
        rBA39j6UoR7pyr2Tli96Q8HMCiwvHembXgwuefg8bQ==
X-Google-Smtp-Source: AKy350a7HcIfAv81OfalbFmbOeei5Ktp9PG2URV6ueZN038+lY74EZ0QQ0meiqBynjKkiHJUVvZcgoCdYNlkeQdL5Z0=
X-Received: by 2002:a25:74d4:0:b0:b8e:df36:fea1 with SMTP id
 p203-20020a2574d4000000b00b8edf36fea1mr7754829ybc.3.1681743291278; Mon, 17
 Apr 2023 07:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230410184526.15990-1-blarson@amd.com> <20230410184526.15990-13-blarson@amd.com>
In-Reply-To: <20230410184526.15990-13-blarson@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:54:15 +0200
Message-ID: <CAPDyKFrJULviF7+LJZmC89AfyKrcPFtthPY2fb9a=9aqpJcCEA@mail.gmail.com>
Subject: Re: [PATCH v13 12/15] mmc: sdhci-cadence: Support device specific
 init during probe
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 at 20:47, Brad Larson <blarson@amd.com> wrote:
>
> Move struct sdhci_pltfm_data under new struct sdhci_cdns_drv_data.
> Add an init() into sdhci_cdns_drv_data for platform specific device
> initialization in the device probe which is not used for existing devices.
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v10 changes:
> - New patch to provide for platform specific init() with no change
>   to existing designs.
>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 708d4297f241..c528a25f48b8 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -77,6 +77,11 @@ struct sdhci_cdns_phy_cfg {
>         u8 addr;
>  };
>
> +struct sdhci_cdns_drv_data {
> +       int (*init)(struct platform_device *pdev);
> +       const struct sdhci_pltfm_data pltfm_data;
> +};
> +
>  static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
>         { "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
>         { "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
> @@ -325,13 +330,17 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>         .set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
>  };
>
> -static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
> -       .ops = &sdhci_cdns_ops,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
> +       .pltfm_data = {
> +               .ops = &sdhci_cdns_ops,
> +               .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       },
>  };
>
> -static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
> -       .ops = &sdhci_cdns_ops,
> +static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
> +       .pltfm_data = {
> +               .ops = &sdhci_cdns_ops,
> +       },
>  };
>
>  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> @@ -357,7 +366,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
> -       const struct sdhci_pltfm_data *data;
> +       const struct sdhci_cdns_drv_data *data;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_cdns_priv *priv;
>         struct clk *clk;
> @@ -376,10 +385,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>
>         data = of_device_get_match_data(dev);
>         if (!data)
> -               data = &sdhci_cdns_pltfm_data;
> +               data = &sdhci_cdns_drv_data;
>
>         nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> -       host = sdhci_pltfm_init(pdev, data,
> +       host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>                                 struct_size(priv, phy_params, nr_phy_params));
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
> @@ -397,6 +406,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         host->ioaddr += SDHCI_CDNS_SRS_BASE;
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                                 sdhci_cdns_hs400_enhanced_strobe;
> +       if (data->init) {
> +               ret = data->init(pdev);
> +               if (ret)
> +                       goto free;
> +       }
>         sdhci_enable_v4_mode(host);
>         __sdhci_read_caps(host, &version, NULL, NULL);
>
> @@ -461,7 +475,7 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
>  static const struct of_device_id sdhci_cdns_match[] = {
>         {
>                 .compatible = "socionext,uniphier-sd4hc",
> -               .data = &sdhci_cdns_uniphier_pltfm_data,
> +               .data = &sdhci_cdns_uniphier_drv_data,
>         },
>         { .compatible = "cdns,sd4hc" },
>         { /* sentinel */ }
> --
> 2.17.1
>
