Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41F861FF3F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiKGUNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiKGUNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:13:32 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5C3959F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:13:30 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d10so11671032pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LmK9VmA5NawWrTbsNF7MjvDxQgaGH0+3nIRanZy7zco=;
        b=PI6yHV/Yn0U2tfINU9JTLjBLwdqF4IV2uF6Z3NXxOJl55qXRMikvL7GhaKoMl0OAUq
         mTafw3vIXpWJeeCaTKY2+4680w6OsrMgaSao0uqUGc77et4vgwMiI9B2IcfuRfWNvMX8
         WdPm8YIch+GQeLDu5b5Zj6dvw83Uf7FC5hGfG0aZyVKvAus0n/bjTwiigyoABQQzngft
         yzepZkhdhiSCo8Prfz+mK/X6avZhyU/vaCf/NVw5QjsWb9xebUw4GAF2aQsSSJE07Wfc
         szjPvg+5Zl5ZjQoqFYQ3vnfGdbfyUztRxiu279QSq06dUv1QDCz2g3e68XaHXMRGtbxz
         +MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmK9VmA5NawWrTbsNF7MjvDxQgaGH0+3nIRanZy7zco=;
        b=Z1vKucoIZs0GC6tD26Jtmt3aDrJLi2EBcG8+gMaUCNx4PEEvauhUVIiRdVdoTrve1Z
         n1xyhlTI4csIhApGUn/K4gao4Jr+JwzYHWs+n24k0WEhzatCZAwK86BWTc2LHRLGVLUd
         p/xXAlUqJ3fmO97gjoTWSYhotcvv3vwByFoA5la+PcKL/pERAiTSpVXhSfkv9e4yrLHB
         isJAxnhqs7f+1QFprIVBDUIFJC6Xl4nwjpVLfuyylmAKI7LZQUUlPFAi/bdBsU9/PRdn
         CHVH+CuYcH0WxNcqNjXPiFSqLaHMeDQuMZ9+cjXY5F+uKurXXWlMqP4aK0FRtPaI/9xQ
         QxtA==
X-Gm-Message-State: ACrzQf1WjJFe9ohDIkATi5UYQqFg5o3HZLQGFXHTCMta1h767AD2Q9kp
        W+1x0gLbaUpDwIv7eK3FPZ4B4idw8/FrlkwE1RALaA==
X-Google-Smtp-Source: AMsMyM6pTMDtu4I31DiYaGxAglszbAZx4nak9WlilhEtTB+olkeWOgX31NV4wr+ieTYhPP+wwY00HgZywZYnSYlC8m0=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr46114161pgk.595.1667852010122; Mon, 07
 Nov 2022 12:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20221019054857.8286-1-sai.krishna.potthuri@amd.com>
In-Reply-To: <20221019054857.8286-1-sai.krishna.potthuri@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:12:51 +0100
Message-ID: <CAPDyKFq8Z+emgNToxE4hOzv1gZRcDzykwLJL=otv+7HGWP1fEw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support for dynamic configuration
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, saikrishna12468@gmail.com,
        git@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 at 07:49, Sai Krishna Potthuri
<sai.krishna.potthuri@amd.com> wrote:
>
> Add dynamic configuration support for Xilinx ZynqMP which takes care of
> configuring the SD secure space configuration registers using EEMI APIs,
> performing SD reset assert and deassert.
> High level sequence:
> - Check for the PM dynamic configuration support, if no error proceed with
> SD dynamic configurations(next steps) otherwise skip the dynamic
> configuration.
> - Put the SD Controller in reset.
> - Configure SD Fixed configurations.
> - Configure the SD Slot Type.
> - Configure the BASE_CLOCK.
> - Configure the 8-bit support.
> - Bring the SD Controller out of reset.
> - Wait for 1msec delay.
>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 69 ++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 3997cad1f793..f051f3802aff 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/of.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
>
> @@ -1521,6 +1522,65 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
>         return 0;
>  }
>
> +static int sdhci_zynqmp_set_dynamic_config(struct device *dev,
> +                                          struct sdhci_arasan_data *sdhci_arasan)
> +{
> +       struct sdhci_host *host = sdhci_arasan->host;
> +       struct clk_hw *hw = &sdhci_arasan->clk_data.sdcardclk_hw;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 mhz, node_id = !strcmp(clk_name, "clk_out_sd0") ? NODE_SD_0 : NODE_SD_1;
> +       struct reset_control *rstc;
> +       int ret;
> +
> +       /* Obtain SDHC reset control */
> +       rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
> +       if (IS_ERR(rstc)) {
> +               dev_err(dev, "Cannot get SDHC reset.\n");
> +               return PTR_ERR(rstc);
> +       }
> +
> +       ret = reset_control_assert(rstc);
> +       if (ret)
> +               return ret;
> +
> +       ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_FIXED, 0);
> +       if (ret)
> +               return ret;
> +
> +       ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_EMMC_SEL,
> +                                     !!(host->mmc->caps & MMC_CAP_NONREMOVABLE));
> +       if (ret)
> +               return ret;
> +
> +       mhz = DIV_ROUND_CLOSEST_ULL(clk_get_rate(pltfm_host->clk), 1000000);
> +       if (mhz > 100 && mhz <= 200)
> +               mhz = 200;
> +       else if (mhz > 50 && mhz <= 100)
> +               mhz = 100;
> +       else if (mhz > 25 && mhz <= 50)
> +               mhz = 50;
> +       else
> +               mhz = 25;
> +
> +       ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_BASECLK, mhz);
> +       if (ret)
> +               return ret;
> +
> +       ret = zynqmp_pm_set_sd_config(node_id, SD_CONFIG_8BIT,
> +                                     !!(host->mmc->caps & MMC_CAP_8_BIT_DATA));
> +       if (ret)
> +               return ret;
> +
> +       ret = reset_control_deassert(rstc);
> +       if (ret)
> +               return ret;
> +
> +       usleep_range(1000, 1500);
> +
> +       return 0;
> +}
> +
>  static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
>  {
>         struct sdhci_host *host = sdhci_arasan->host;
> @@ -1685,6 +1745,15 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto unreg_clk;
>         }
>
> +       if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a")) {
> +               ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_SET_SD_CONFIG);
> +               if (!ret) {
> +                       ret = sdhci_zynqmp_set_dynamic_config(dev, sdhci_arasan);
> +                       if (ret)
> +                               goto unreg_clk;
> +               }
> +       }
> +
>         sdhci_arasan->phy = ERR_PTR(-ENODEV);
>         if (of_device_is_compatible(np, "arasan,sdhci-5.1")) {
>                 sdhci_arasan->phy = devm_phy_get(dev, "phy_arasan");
> --
> 2.17.1
>
