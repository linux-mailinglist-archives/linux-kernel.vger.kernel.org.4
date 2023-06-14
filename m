Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894FC72FB03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbjFNKdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244016AbjFNKct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:32:49 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660D02111
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:32:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9ecc0979cso18249291cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738723; x=1689330723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk5KTXO8tGRkVKak2dEfcHSu4PyVlCkfKJkrfYPVHyA=;
        b=XvUMgbgt3tZfZoM0Qg4P6ZznuGBCmG+3ewIJiR77hnwu+5apM6jGgR+2Cz35KEU0kh
         EXUzkR14nC90XXe9JYrEE2Q6wtyzFsp6vijbZ78JxmfLIlngyw2XFex2U1Ynwfu5MxaO
         g3RA2tPUyttReMvNN0gUQ54g070Iew+zflhUC4pCBeKpGZ+zhz2Iaheo5HhvB83fm8Mm
         ja9dTROH8FEOp/6tcOepc1mf+A0r3bn8e3EXlE7ZQK5x7KknHnL50Om/qY5yof0hcf8F
         g8E0mPB2bBujtDaSZOxDMzMRe/5Yszqpw7f4XUUuAH3shrLGRC3nRHygY0jXna5h5F8Y
         tEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738723; x=1689330723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk5KTXO8tGRkVKak2dEfcHSu4PyVlCkfKJkrfYPVHyA=;
        b=gGi9s1Sv3R7/BjViPJ4CyihroTPGlEOwJb/pyWKhGDEOC4eI1hCDoqZcOkHqBwbMKk
         Fpm3Qv+QC11EkaCPCheynhRgO8wPpQfQTPU7Ku0CIbPcpnwNtWK5WN3wmM3yKKF43f7w
         AHIgkubaZGGW8zjb6BkiBgA2M+1NlXVi6RJuxTvhI7zyLcg/MIT/aA5l2xH9Ob5d42Ml
         G32rFj4Puy28wlToX4SuU15mzvtCmP0iSaQf7yUCysrHfijhkuXSGZWsOyb31FFLajad
         kkRiVVzCHlT3smOS72RPjR8bFUUDsuUaFSPWrrFpcjf3SaKq3XxY0hM3QIWdIqdf7reU
         Jhuw==
X-Gm-Message-State: AC+VfDzFLiJx5OCVpsqExhuCDsXkM+Sn7U+BsHjHcUQ6xuXGea3hcaej
        +tNYkldSj5Uu81ekS3KTAbUsuwxwZe0JzFog4XdU0A==
X-Google-Smtp-Source: ACHHUZ6WGpvvy5YTbPx2DKWT/5s0zb051L42eJ/xFYh1BZ6zGKLEOUsGaJH18B0DhavSJ889KalaPEaW4whvvpH3dXQ=
X-Received: by 2002:ac8:5ac1:0:b0:3f2:384:9292 with SMTP id
 d1-20020ac85ac1000000b003f203849292mr2153503qtd.34.1686738723505; Wed, 14 Jun
 2023 03:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230613150148.429828-1-yann.gautier@foss.st.com>
In-Reply-To: <20230613150148.429828-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 12:31:27 +0200
Message-ID: <CAPDyKFpOOm-PR5NiggT6NqiXgbz6qGQ46-y26XZNi1S2-B=VYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: set feedback clock when using delay block
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-mmc@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 at 17:02, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> The feedback clock is used only for SDR104 & HS200 modes, and when
> delay block is used (frequency is higher than 50 MHz). The tuning
> procedure is then only required for those modes. Skip the procedure
> for other modes.
> The setting of this feedback clock is done just after enabling delay
> block, and before configuring it.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 60bca78a72b19..953d1be4e379c 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -293,18 +293,8 @@ static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
>         clk |= host->clk_reg_add;
>         clk |= ddr;
>
> -       /*
> -        * SDMMC_FBCK is selected when an external Delay Block is needed
> -        * with SDR104 or HS200.
> -        */
> -       if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50) {
> +       if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50)
>                 clk |= MCI_STM32_CLK_BUSSPEED;
> -               if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104 ||
> -                   host->mmc->ios.timing == MMC_TIMING_MMC_HS200) {
> -                       clk &= ~MCI_STM32_CLK_SEL_MSK;
> -                       clk |= MCI_STM32_CLK_SELFBCK;
> -               }
> -       }
>
>         mmci_write_clkreg(host, clk);
>  }
> @@ -511,10 +501,27 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct mmci_host *host = mmc_priv(mmc);
>         struct sdmmc_dlyb *dlyb = host->variant_priv;
> +       u32 clk;
> +
> +       if ((host->mmc->ios.timing != MMC_TIMING_UHS_SDR104 &&
> +            host->mmc->ios.timing != MMC_TIMING_MMC_HS200) ||
> +           host->mmc->actual_clock <= 50000000)
> +               return 0;
>
>         if (!dlyb || !dlyb->base)
>                 return -EINVAL;
>
> +       writel_relaxed(DLYB_CR_DEN, dlyb->base + DLYB_CR);
> +
> +       /*
> +        * SDMMC_FBCK is selected when an external Delay Block is needed
> +        * with SDR104 or HS200.
> +        */
> +       clk = host->clk_reg;
> +       clk &= ~MCI_STM32_CLK_SEL_MSK;
> +       clk |= MCI_STM32_CLK_SELFBCK;
> +       mmci_write_clkreg(host, clk);
> +
>         if (sdmmc_dlyb_lng_tuning(host))
>                 return -EINVAL;
>
> --
> 2.25.1
>
