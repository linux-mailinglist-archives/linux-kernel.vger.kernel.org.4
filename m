Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75186D22B6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjCaOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjCaOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:32:21 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ECE20D94
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:31:58 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-544f7c176easo417956967b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680273098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rM7ugpFCyNjwhnUhml20+mwW8AlBrHR+eTjQajO32Zg=;
        b=Oa+hC5q3BeYwJzc0m5XU91Q7zQRwOafGdwcwsFxuH63OAc7bMR4mOqT6iaQWt3bW50
         dg1Z9TmB1duvrsU/SAAKyezSeZyHp9YswJvfmSQNXtwer9eR7xMkcTrC26Pk3hWmrfmN
         dpSB4RdaY6thxaJFX2g73s6w1UqERcer7JuZFW5dXsc49NyxGoTmov1k7sbFaQGu+x1M
         iBdq/hWPjSMeMeJwsNg8KGglCdelj6oiy6Y6ej7Km139mqQZTw45XuDrlSV9Qs9bH2wj
         GKEGSv4Zrguvii+FEWsixOfLQ7JIY5fyZq6UQq6XuzlwYYqIDYScVr3lIBH6WpXXKZgD
         Ms/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680273098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rM7ugpFCyNjwhnUhml20+mwW8AlBrHR+eTjQajO32Zg=;
        b=7zzJW3Aidxq33GocJPB9s/8ZAZ0mRGhQ/Mb2cjmhfeSkefhIvcNJr4sSI/pggLJvcg
         02WRWSzZWW75VSTs3wiBS7Z9f0f6WDkKnYLqAQ8+6RDz/ah7RnG2d1coo7Q36bzEgihP
         vQAUiOukSsV08KJddm2ARRDIyn4Vw6BxaYHLT4FLUzeeIJXZY0w8MtdwTL7JCi2/TZcw
         RGnUdDo5xtZaTa7Q5H9YORr/S4rOAiUcvfLlLhhRPKiznYbypOBs3pG3LQywMLe1s0wD
         HyD6ThSbWaKsvg8NBMR+UCZxCAcZjp9knoO64j1sw8yPfgGKaWxDwBYcYC1bdpN5mhe2
         lL2A==
X-Gm-Message-State: AAQBX9fdW90MWZGFvt9LuGMlVPYi0I1PVM+L4gcZfkiZKq3DTxFwWvEI
        3qxv7ILjJgKGJHODhKbUlEnDTB9RVNERLX4zTbp3LA==
X-Google-Smtp-Source: AKy350Zs9CxS2t6p8TcNsUtCCj2WfSKacDr9FWeKjiRytXdNKlpHnPwZKDqe+wfcBCoFJGY0BdETlddD9LkgDV1RA7E=
X-Received: by 2002:a81:aa05:0:b0:53c:6fda:835f with SMTP id
 i5-20020a81aa05000000b0053c6fda835fmr2302302ywh.0.1680273097825; Fri, 31 Mar
 2023 07:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230331101619.4117312-1-vigneshr@ti.com>
In-Reply-To: <20230331101619.4117312-1-vigneshr@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Mar 2023 16:31:01 +0200
Message-ID: <CAPDyKFqQZgmd_ydbjKJ+5-Dte9i2=DqWwZNgVHi2MnH+q7pZ1g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci_am654: Add support for PM suspend/resume
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 at 12:17, Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> From: Aswath Govindraju <a-govindraju@ti.com>
>
> Add support for suspend/resume and pm_runtime resume/suspend.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>
> Since RFC v2:
> Address all comments around sdhci_am654_remove()
> Set autosuspend_delay to -1 as SDHCI will host rootfs via SD/eMMC and
> autosuspend can cause long latency for user interactive applications

I am curious about the "long" latency. Do you have some data that you
can share for how long it takes to runtime-resume the device?

Using -1 as the default value for the autosuspend_delay seems fine to
me, but did you consider using a longer timeout than the common 100ms?
Could that perhaps be a better default option?

Of course, in the end this is a choice of performance in favor of
wasting energy.

Kind regards
Uffe

>
> RFC v2:
> https://lore.kernel.org/all/20220408124338.27090-1-a-govindraju@ti.com/
>
>  drivers/mmc/host/sdhci_am654.c | 147 +++++++++++++++++++++++++++++----
>  1 file changed, 131 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 672d37ea98d0..7cdf0f54e3a5 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -85,6 +85,7 @@
>  #define DRIVER_STRENGTH_40_OHM 0x4
>
>  #define CLOCK_TOO_SLOW_HZ      50000000
> +#define SDHCI_AM654_AUTOSUSPEND_DELAY  -1
>
>  /* Command Queue Host Controller Interface Base address */
>  #define SDHCI_AM654_CQE_BASE_ADDR 0x200
> @@ -808,16 +809,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>
>         pltfm_host->clk = clk_xin;
>
> -       /* Clocks are enabled using pm_runtime */
> -       pm_runtime_enable(dev);
> -       ret = pm_runtime_resume_and_get(dev);
> -       if (ret)
> -               goto pm_runtime_disable;
> -
>         base = devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(base)) {
>                 ret = PTR_ERR(base);
> -               goto pm_runtime_put;
> +               goto err_pltfm_free;
>         }
>
>         sdhci_am654->base = devm_regmap_init_mmio(dev, base,
> @@ -825,31 +820,47 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>         if (IS_ERR(sdhci_am654->base)) {
>                 dev_err(dev, "Failed to initialize regmap\n");
>                 ret = PTR_ERR(sdhci_am654->base);
> -               goto pm_runtime_put;
> +               goto err_pltfm_free;
>         }
>
>         ret = sdhci_am654_get_of_property(pdev, sdhci_am654);
>         if (ret)
> -               goto pm_runtime_put;
> +               goto err_pltfm_free;
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
>                 dev_err_probe(dev, ret, "parsing dt failed\n");
> -               goto pm_runtime_put;
> +               goto err_pltfm_free;
>         }
>
>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>
> +       pm_runtime_get_noresume(dev);
> +       ret = pm_runtime_set_active(dev);
> +       if (ret)
> +               goto pm_put;
> +       pm_runtime_enable(dev);
> +       ret = clk_prepare_enable(pltfm_host->clk);
> +       if (ret)
> +               goto pm_disable;
> +
>         ret = sdhci_am654_init(host);
>         if (ret)
> -               goto pm_runtime_put;
> +               goto clk_disable;
>
> +       /* Setting up autosuspend */
> +       pm_runtime_set_autosuspend_delay(dev, SDHCI_AM654_AUTOSUSPEND_DELAY);
> +       pm_runtime_use_autosuspend(dev);
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);
>         return 0;
>
> -pm_runtime_put:
> -       pm_runtime_put_sync(dev);
> -pm_runtime_disable:
> +clk_disable:
> +       clk_disable_unprepare(pltfm_host->clk);
> +pm_disable:
>         pm_runtime_disable(dev);
> +pm_put:
> +       pm_runtime_put_noidle(dev);
>  err_pltfm_free:
>         sdhci_pltfm_free(pdev);
>         return ret;
> @@ -858,23 +869,127 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  static int sdhci_am654_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         int ret;
>
> -       sdhci_remove_host(host, true);
> -       ret = pm_runtime_put_sync(&pdev->dev);
> +       ret = pm_runtime_resume_and_get(&pdev->dev);
>         if (ret < 0)
>                 return ret;
>
> +       sdhci_remove_host(host, true);
> +       clk_disable_unprepare(pltfm_host->clk);
>         pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
>         sdhci_pltfm_free(pdev);
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int sdhci_am654_restore(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +       u32 ctl_cfg_2 = 0;
> +       u32 val;
> +       int ret;
> +
> +       if (sdhci_am654->flags & DLL_CALIB) {
> +               regmap_read(sdhci_am654->base, PHY_STAT1, &val);
> +               if (~val & CALDONE_MASK) {
> +                       /* Calibrate IO lines */
> +                       regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> +                                          PDB_MASK, PDB_MASK);
> +                       ret = regmap_read_poll_timeout(sdhci_am654->base,
> +                                                      PHY_STAT1, val,
> +                                                      val & CALDONE_MASK,
> +                                                      1, 20);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
> +       /* Enable pins by setting IO mux to 0 */
> +       if (sdhci_am654->flags & IOMUX_PRESENT)
> +               regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> +                                  IOMUX_ENABLE_MASK, 0);
>
> +       /* Set slot type based on SD or eMMC */
> +       if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +               ctl_cfg_2 = SLOTTYPE_EMBEDDED;
> +
> +       regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
> +                          ctl_cfg_2);
> +
> +       regmap_read(sdhci_am654->base, CTL_CFG_3, &val);
> +       if (~val & TUNINGFORSDR50_MASK)
> +               /* Enable tuning for SDR50 */
> +               regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
> +                                  TUNINGFORSDR50_MASK);
> +
> +       return 0;
> +}
> +
> +static int sdhci_am654_runtime_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       int ret;
> +
> +       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +               mmc_retune_needed(host->mmc);
> +
> +       ret = cqhci_suspend(host->mmc);
> +       if (ret)
> +               return ret;
> +
> +       ret = sdhci_runtime_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       /* disable the clock */
> +       clk_disable_unprepare(pltfm_host->clk);
>         return 0;
>  }
>
> +static int sdhci_am654_runtime_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       int ret;
> +
> +       /* Enable the clock */
> +       ret = clk_prepare_enable(pltfm_host->clk);
> +       if (ret)
> +               return ret;
> +
> +       ret = sdhci_am654_restore(host);
> +       if (ret)
> +               return ret;
> +
> +       ret = sdhci_runtime_resume_host(host, 0);
> +       if (ret)
> +               return ret;
> +
> +       ret = cqhci_resume(host->mmc);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops sdhci_am654_dev_pm_ops = {
> +       SET_RUNTIME_PM_OPS(sdhci_am654_runtime_suspend,
> +                          sdhci_am654_runtime_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
> +};
> +
>  static struct platform_driver sdhci_am654_driver = {
>         .driver = {
>                 .name = "sdhci-am654",
>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +               .pm = &sdhci_am654_dev_pm_ops,
>                 .of_match_table = sdhci_am654_of_match,
>         },
>         .probe = sdhci_am654_probe,
> --
> 2.40.0
>
