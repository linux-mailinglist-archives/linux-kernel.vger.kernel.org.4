Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F1A5BE586
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiITMRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiITMRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:17:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC1F74E0E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:17:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f14so3460644lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PjV/C/iJaslECOoT/9+C2TwJfWJ2ZEuELuT2THrHTSs=;
        b=R2XTmSX2SYLGWoAi8uGJIOaJZirw2IXSXnPpGo8lFigrYdCueJMlmMabp/H99h9XTu
         KIyUhUkxdHZQ0mhs8+0HYvvGOV0vpaTCCeNexfh8+gQROBi2NP0IJVbnTgpv8clOcECi
         AesONc22xViO48ek3VJ3rmhJcNY/tVYV/SDitUibR/c9sgiygDNqDfF+hCHqZaNsqwVm
         dVhJ93iQbzw6ZBnFIoqKednYBtDNTJ6iR961ETXTXbW7Eg6asVAkueV89q9nWR3LPZYi
         meq507FGw86zQ4mr++L3/sPwT8j1iCHvUkybKLRR8O2J39ROH2UxiN7AE33gMrqHnj6B
         EcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PjV/C/iJaslECOoT/9+C2TwJfWJ2ZEuELuT2THrHTSs=;
        b=CZgrcOFZHjJxMS5g8BE8lSldr6+u1sA6pFTKn8n29ErjKcJpByMzT6Z3eAEC1l1Q87
         H2tMV/W657F9kVBVDM3af4fs/MowgifiwFr86yFvTP6K8EUURikdw+mNmkLX9pxfcmDK
         3L/MKAS1ttDdx2Kq5RPVQc9vc9zu4JWypAylzj2YlpU6Wz1roSnU5U8Z+vIUi6S+5S+Q
         OePhg61rTqvUpv5oiAjJDJVoNmNglMTvP69O1Xio2FNZVqgJ8q/7YHD2FkzKutbwGVeE
         CPvBvTDL8jZFwMiIL7brJabnLuTGiWF0xkkTR61ZGSBavnXM5qfBBBCUNQTr1Sw08TaT
         8WIg==
X-Gm-Message-State: ACrzQf1sMh9ofCOcakc35Ux8EjymVA/XpCaELdYdTgHcjguJSepey4V+
        z9Z1ILhuowZKjE8FF9f1mKrMQwQoScPq28Tyizf07w==
X-Google-Smtp-Source: AMsMyM4TtcxV4q/66+HfLL3mPzRYJ9eXY2eQe4lofxHEXFr3UeUUpUmikabbHChRqteAz4+a6hi5gLJ+Ff+wq6MJqq4=
X-Received: by 2002:a05:6512:280d:b0:498:fd40:51d4 with SMTP id
 cf13-20020a056512280d00b00498fd4051d4mr8952799lfb.167.1663676256865; Tue, 20
 Sep 2022 05:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220919181309.286611-1-dinguyen@kernel.org> <20220919181309.286611-2-dinguyen@kernel.org>
In-Reply-To: <20220919181309.286611-2-dinguyen@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Sep 2022 14:17:00 +0200
Message-ID: <CAPDyKFoB7Z6kDOBd9rVLXU5yRQK7d5A-ut5CRroepbAfQpuByw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Mon, 19 Sept 2022 at 20:13, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> The clock-phase settings for the SDMMC controller in the SoCFPGA
> Strarix10/Agilex/N5X platforms reside in a register in the System
> Manager. Add a method to access that register through the syscon
> interface.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 68 ++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 9901208be797..9e3237c18a9d 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -17,10 +17,15 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
> +#include <linux/mfd/altera-sysmgr.h>
> +#include <linux/regmap.h>
>
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
>
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
> +       ((((smplsel) & 0x7) << 4) | (((drvsel) & 0x7) << 0))
> +
>  int dw_mci_pltfm_register(struct platform_device *pdev,
>                           const struct dw_mci_drv_data *drv_data)
>  {
> @@ -62,9 +67,70 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
>  };
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>
> +static int dw_mci_socfpga_priv_init(struct dw_mci *host)
> +{
> +       struct device_node *np = host->dev->of_node;
> +       struct regmap *sys_mgr_base_addr;
> +       u32 clk_phase[2] = {0}, reg_offset;
> +       int i, rc, hs_timing;
> +
> +       rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);

This needs to be documented through updated DT bindings.

> +       if (rc) {
> +               sys_mgr_base_addr =
> +                       altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");

DT bindings?

> +               if (IS_ERR(sys_mgr_base_addr)) {
> +                       pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
> +                       return 1;
> +               }
> +       } else
> +               return 1;
> +
> +       of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);

DT bindings?

> +
> +       for (i = 0; i < ARRAY_SIZE(clk_phase); i++) {
> +               switch (clk_phase[i]) {
> +               case 0:
> +                       clk_phase[i] = 0;
> +                       break;
> +               case 45:
> +                       clk_phase[i] = 1;
> +                       break;
> +               case 90:
> +                       clk_phase[i] = 2;
> +                       break;
> +               case 135:
> +                       clk_phase[i] = 3;
> +                       break;
> +               case 180:
> +                       clk_phase[i] = 4;
> +                       break;
> +               case 225:
> +                       clk_phase[i] = 5;
> +                       break;
> +               case 270:
> +                       clk_phase[i] = 6;
> +                       break;
> +               case 315:
> +                       clk_phase[i] = 7;
> +                       break;
> +               default:
> +                       clk_phase[i] = 0;
> +                       break;
> +               }
> +       }

In my opinion, it looks like converting to use
mmc_of_parse_clk_phase() should be able to avoid some of the open
coding above.

If you need some inspiration of how to implement this, you may have a
look at drivers/mmc/host/sdhci-of-aspeed.c

> +       hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
> +       regmap_write(sys_mgr_base_addr, reg_offset, hs_timing);
> +
> +       return 0;
> +}
> +
> +static const struct dw_mci_drv_data socfpga_drv_data = {
> +       .init           = dw_mci_socfpga_priv_init,
> +};
> +
>  static const struct of_device_id dw_mci_pltfm_match[] = {
>         { .compatible = "snps,dw-mshc", },
> -       { .compatible = "altr,socfpga-dw-mshc", },
> +       { .compatible = "altr,socfpga-dw-mshc", .data = &socfpga_drv_data, },
>         { .compatible = "img,pistachio-dw-mshc", },
>         {},
>  };
> --
> 2.25.1
>

Kind regards
Uffe
