Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6E76BCC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCPKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCPKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:12:28 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46075BBB3E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:12:09 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5447d217bc6so21209377b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678961528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HUXMtYCJCytkJaYrRDzWMzdMH+FzcGdy44GMw4xZIbw=;
        b=qrgea51T34DMF4J459mkcIfZM1O5H1D7Blf2NqQVaiHCYu/S0yJheRooxcaRzkLKA8
         o/qVX9Z5kPl+ZfI2iQMguYLIjfKBVzZ/51FeU9TxUjsn21UWVJRd8bkLeLExN+2r/t9C
         45dK+4coBBS0nCQo/mOSU3oqeFUNMQfD0NX0r49iCClhHAW/fcHlu/dqbB/fgBjBk390
         bWnb+0+NO+OPFq5zMlxdFnzT+Ug9A8QfqOeZrVpa+1ikFXFkqKb9IEE3Cl9JP69IlFoN
         gMlRtPTcKjpVX08WqHkJdp4oZzjNf+lUIWzemFJQ3SKZD40b09+Qkie46tTorxxT0epL
         5G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678961528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUXMtYCJCytkJaYrRDzWMzdMH+FzcGdy44GMw4xZIbw=;
        b=hb2attFSmZbE6saezqlKfT5/Gc4IE7DeH71w2wg9U87kGqeN4j5jjtPj5e3YbRFstW
         fC0nd3A19svt+sLjoRsSrHQbbRCljDoMme9Ei+nGub11jCArgd8rz6Ub+UJ7vy3Wa1CI
         ntiX1z3PT9DQbMgcpY2jtPHgRrBHPWTsjAUlVWFiHyAUVhidMsw1pNvjLxgZI+uLZveb
         UzQ4QGOKvVXsKEmqAkMp/kpopUFsN6M6wG5VZOaZiyDyS31NfXrRQcY9nVQ9EyjncHBL
         1eyn2/1WDSf1oSRx9K+Q/YQxvdf9p2g4NW/16JpKj8fUTc3Y0SB3r//AsAMOhg1VxMDw
         pzJw==
X-Gm-Message-State: AO0yUKVcNAFfz0zuq25TN4YREsL3VdBBXgbKq3C9WGJL9huM5SRc7se+
        HWBRhuUuN5eJhLDxI0tdmcUeye4Zxvho/Zj+Aic6SA==
X-Google-Smtp-Source: AK7set/KxCCnM2xscrt5p3IwN8pijGV3hZwQNY4jhHYrQ6X7R+dhtMmXWquofPXgEnNNKJko0qibO1BNsjyewjnx8Xk=
X-Received: by 2002:a81:d84d:0:b0:543:9065:b225 with SMTP id
 n13-20020a81d84d000000b005439065b225mr1963135ywl.5.1678961528178; Thu, 16 Mar
 2023 03:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230316083049.29979-1-quic_tdas@quicinc.com> <20230316083049.29979-3-quic_tdas@quicinc.com>
In-Reply-To: <20230316083049.29979-3-quic_tdas@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Mar 2023 12:11:57 +0200
Message-ID: <CAA8EJpqxtRyVKoqNsY01FmHaa10WK9LT49ydenztoJ1q0ah0+A@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: qcom: videocc-sm8450: Add video clock controller
 driver for SM8450
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_skakitap@quicinc.com, quic_jkona@quicinc.com
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

On Thu, 16 Mar 2023 at 10:31, Taniya Das <quic_tdas@quicinc.com> wrote:
>
> Add support for the video clock controller driver for peripheral clock
> clients to be able to request for video cc clocks.
>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig          |   9 +
>  drivers/clk/qcom/Makefile         |   1 +
>  drivers/clk/qcom/videocc-sm8450.c | 464 ++++++++++++++++++++++++++++++
>  3 files changed, 474 insertions(+)
>  create mode 100644 drivers/clk/qcom/videocc-sm8450.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 5ab4b7dfe3c2..81909e179bc7 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -892,4 +892,13 @@ config CLK_GFM_LPASS_SM8250
>           Support for the Glitch Free Mux (GFM) Low power audio
>            subsystem (LPASS) clocks found on SM8250 SoCs.
>
> +config SM_VIDEOCC_8450
> +       tristate "SM8450 Video Clock Controller"
> +       select SM_GCC_8450
> +       select QCOM_GDSC
> +       help
> +         Support for the video clock controller on Qualcomm Technologies, Inc.
> +         SM8450 devices.
> +         Say Y if you want to support video devices and functionality such as
> +         video encode/decode.
>  endif
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index c743805a9cbb..5cbd0eedd6d9 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -119,6 +119,7 @@ obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
>  obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
>  obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>  obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
> +obj-$(CONFIG_SM_VIDEOCC_8450) += videocc-sm8450.o
>  obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
>  obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
>  obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
> diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
> new file mode 100644
> index 000000000000..ca60f3be587d
> --- /dev/null
> +++ b/drivers/clk/qcom/videocc-sm8450.c
> @@ -0,0 +1,464 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,videocc-sm8450.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +       P_BI_TCXO,
> +       P_VIDEO_CC_PLL0_OUT_MAIN,
> +       P_VIDEO_CC_PLL1_OUT_MAIN,
> +};
> +
> +static const struct pll_vco lucid_evo_vco[] = {
> +       { 249600000, 2020000000, 0 },
> +};
> +
> +static const struct alpha_pll_config video_cc_pll0_config = {
> +       .l = 0x1E,
> +       .alpha = 0x0,
> +       .config_ctl_val = 0x20485699,
> +       .config_ctl_hi_val = 0x00182261,
> +       .config_ctl_hi1_val = 0x32AA299C,
> +       .user_ctl_val = 0x00000000,
> +       .user_ctl_hi_val = 0x00000805,
> +};
> +
> +static struct clk_alpha_pll video_cc_pll0 = {
> +       .offset = 0x0,
> +       .vco_table = lucid_evo_vco,
> +       .num_vco = ARRAY_SIZE(lucid_evo_vco),
> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
> +       .clkr = {
> +               .hw.init = &(const struct clk_init_data){
> +                       .name = "video_cc_pll0",
> +                       .parent_data = &(const struct clk_parent_data){
> +                               .fw_name = "bi_tcxo",

Could you please follow the last of recent drivers and use DT indices
instead of clock-names?

Also, as a syntax nit, could you please add whitespaces between ) and { ?

> +                       },
> +                       .num_parents = 1,
> +                       .ops = &clk_alpha_pll_lucid_evo_ops,
> +               },
> +       },
> +};
> +

[skipped]


> +
> +static void video_cc_sm8450_pm_runtime_disable(void *data)
> +{
> +       pm_runtime_disable(data);
> +}
> +
> +static int video_cc_sm8450_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       int ret;
> +
> +       pm_runtime_enable(&pdev->dev);
> +
> +       ret = devm_add_action_or_reset(&pdev->dev, video_cc_sm8450_pm_runtime_disable, &pdev->dev);
> +       if (ret)
> +               return ret;

Could you please shift to using devm_pm_runtime_enable()?

> +
> +       ret = pm_runtime_resume_and_get(&pdev->dev);
> +       if (ret)
> +               return ret;
> +
> +       regmap = qcom_cc_map(pdev, &video_cc_sm8450_desc);
> +       if (IS_ERR(regmap)) {
> +               pm_runtime_put(&pdev->dev);
> +               return PTR_ERR(regmap);
> +       }
> +
> +       clk_lucid_evo_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
> +       clk_lucid_evo_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
> +
> +       /*
> +        * Keep clocks always enabled:
> +        *      video_cc_ahb_clk
> +        *      video_cc_sleep_clk
> +        *      video_cc_xo_clk
> +        */
> +       regmap_update_bits(regmap, 0x80e4, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0x8130, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0x8114, BIT(0), BIT(0));
> +
> +       ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
> +
> +       pm_runtime_put(&pdev->dev);
> +
> +       return ret;
> +}
> +
> +static struct platform_driver video_cc_sm8450_driver = {
> +       .probe = video_cc_sm8450_probe,
> +       .driver = {
> +               .name = "video_cc-sm8450",
> +               .of_match_table = video_cc_sm8450_match_table,
> +       },
> +};
> +
> +static int __init video_cc_sm8450_init(void)
> +{
> +       return platform_driver_register(&video_cc_sm8450_driver);
> +}
> +subsys_initcall(video_cc_sm8450_init);
> +
> +static void __exit video_cc_sm8450_exit(void)
> +{
> +       platform_driver_unregister(&video_cc_sm8450_driver);
> +}
> +module_exit(video_cc_sm8450_exit);
> +
> +MODULE_DESCRIPTION("QTI VIDEO_CC SM8450 Driver");
> +MODULE_LICENSE("GPL v2");

I think this should be just "GPL" nowaways.

> --
> 2.17.1
>


-- 
With best wishes
Dmitry
