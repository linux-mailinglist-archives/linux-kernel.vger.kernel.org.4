Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310586E4BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjDQOzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjDQOyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:54:55 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A426975F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:47 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id n193so3622844ybf.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743286; x=1684335286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xMWyDEyN1k6jfannonDWx0OZZhgMHQXlFtW1zUQ9HKI=;
        b=Hrm5i9qQ+Mw+3lAlo0np5rtqmcSkq+LgL7uGUoSVMsK5wRRxyhV5ENaD9X1JDHyZhz
         PQ3/R2f5u2Oj4Q1KMWLez5neRkhokmEzZyw8UMxF8cCXQKq32ILU+kJ9J0sYtTM6MiMN
         YilZNWKeoWj+sjXv8fKGfWaiZDfzi66QPcprGgMZKCk0ZMTxAcuE6w+c3Lpd1MEyCCmB
         xewZq/fABYh2cOCak9E4NBDDt2SsSFcq39Ji7NFG0e/DrXTq4kQLMAAQRN8Mk+lqekSa
         PG9Zk5X7Esya+4nLUcp2KxCGzn6iYLU8xfomA20nEj5z+uAFdmsI0nJmwy51DRRAo2IM
         pJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743286; x=1684335286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMWyDEyN1k6jfannonDWx0OZZhgMHQXlFtW1zUQ9HKI=;
        b=ND8rBErqP26qVf6c05XDvSdfFvohZGUh77Ra5VGt9QrvnI42jOWL35D+9A/PkCf2CJ
         FUyIQaAJyXOkUink7YKfI+ZX5PIpp409Sp4zevsvajajp1Wbl3LGY0esqVQv6YP7mIkB
         lgq7d69mEtfm5dUM/XPd8T69CAp84lEeAb5LV3IOkVz69HKRlX0nD/FWnBDa5lWFw09p
         97PjxoXlTYyo5LXcWd9chwWYIrj0B4MdfQdD6x5OBnEy8Bsq3F7tVkF+9RnqcUW/K+Fz
         3xqXfLUu2WjGRcmI3Cw6VpVXMffVdNAjnJRw5a6JC7xv0PJ02mCv09CLTH2/QBO4tFqa
         dPrg==
X-Gm-Message-State: AAQBX9dxjYPrWIRtQRDG7RrB0accclbAJEu8A1O60Nn8U2eeoHV8b+Du
        QpAPzXIPFcI4AuA5etrH1uRgbShQLNSzHeNzeILohg==
X-Google-Smtp-Source: AKy350a3CvaFRMXdedTij/+ooVIxFEkhYZqPOSZe33j+7t6xPOdYXwurZmJJ7TqadVmxJyLNPjyNGmsp1Q+K/qXnkGw=
X-Received: by 2002:a25:e0c5:0:b0:b75:8ac3:d5d9 with SMTP id
 x188-20020a25e0c5000000b00b758ac3d5d9mr9714380ybg.3.1681743286336; Mon, 17
 Apr 2023 07:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230410184526.15990-1-blarson@amd.com> <20230410184526.15990-12-blarson@amd.com>
In-Reply-To: <20230410184526.15990-12-blarson@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:54:10 +0200
Message-ID: <CAPDyKFqRy=gCPiRfPs6DrgmjGFPazi-HQeG0fSjqSe3vFE9pjA@mail.gmail.com>
Subject: Re: [PATCH v13 11/15] mmc: sdhci-cadence: Enable device specific
 override of writel()
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 at 20:47, Brad Larson <blarson@amd.com> wrote:
>
> SoCs with device specific Cadence implementation, such as setting
> byte-enables before the write, need to override writel().  Add a
> callback where the default is writel() for all existing chips.
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v10 changes:
> - The 1st patch adding private writel() is unchanged.  The 2nd patch is split
>   into two patches to provide for device specific init in one patch with no
>   effect on existing designs.  Then add the pensando support into the next patch.
>   Then the 4th patch is mmc hardware reset support which is unchanged.
>
> v9 changes:
> - No change to this patch but as some patches are deleted and this is
>   a respin the three successive patches to sdhci-cadence.c are
>   patches 12, 13, and 14 which do the following:
>
>   1. Add ability for Cadence specific design to have priv writel().
>   2. Add Elba SoC support that requires its own priv writel() for
>      byte-lane control .
>   3. Add support for mmc hardware reset.
>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 6f2de54a5987..708d4297f241 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -67,6 +67,7 @@ struct sdhci_cdns_phy_param {
>  struct sdhci_cdns_priv {
>         void __iomem *hrs_addr;
>         bool enhanced_strobe;
> +       void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>         unsigned int nr_phy_params;
>         struct sdhci_cdns_phy_param phy_params[];
>  };
> @@ -90,6 +91,12 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
>         { "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
>  };
>
> +static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
> +                              void __iomem *reg)
> +{
> +       writel(val, reg);
> +}
> +
>  static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>                                     u8 addr, u8 data)
>  {
> @@ -104,17 +111,17 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>
>         tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
>               FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
> -       writel(tmp, reg);
> +       priv->priv_writel(priv, tmp, reg);
>
>         tmp |= SDHCI_CDNS_HRS04_WR;
> -       writel(tmp, reg);
> +       priv->priv_writel(priv, tmp, reg);
>
>         ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
>         if (ret)
>                 return ret;
>
>         tmp &= ~SDHCI_CDNS_HRS04_WR;
> -       writel(tmp, reg);
> +       priv->priv_writel(priv, tmp, reg);
>
>         ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
>                                  0, 10);
> @@ -191,7 +198,7 @@ static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
>         tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
>         tmp &= ~SDHCI_CDNS_HRS06_MODE;
>         tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
> -       writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
> +       priv->priv_writel(priv, tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
>  }
>
>  static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
> @@ -223,7 +230,7 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>          */
>         for (i = 0; i < 2; i++) {
>                 tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
> -               writel(tmp, reg);
> +               priv->priv_writel(priv, tmp, reg);
>
>                 ret = readl_poll_timeout(reg, tmp,
>                                          !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
> @@ -386,6 +393,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         priv->nr_phy_params = nr_phy_params;
>         priv->hrs_addr = host->ioaddr;
>         priv->enhanced_strobe = false;
> +       priv->priv_writel = cdns_writel;
>         host->ioaddr += SDHCI_CDNS_SRS_BASE;
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                                 sdhci_cdns_hs400_enhanced_strobe;
> --
> 2.17.1
>
