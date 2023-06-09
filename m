Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A672A01F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbjFIQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbjFIQW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:22:58 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E43C18
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:22:41 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-568900c331aso19133047b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686327761; x=1688919761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mwQzu1mHmg5s3RKGFVLiYioIdNZ9wrhFOjBtuF+UR3o=;
        b=OeqWZw34Y6D3kTo5yYID2yBZzJAAQtqpAjCwfyz2PBcyKOWEGB/dLXjUD+499rrI0n
         1J3XHsBf/izlVlQK1sRykEQSKROn6Hl4Xq7+rh5QHQpNSLNnEIsG37BPydK+BpsRhPsR
         tf6k2z1MQkyTXtU2A8vHyifUVpFv1ssnBx1+CS6lXoi5wSvMUbhhodAWfTqjQGmecKGQ
         b05Wq1s6maRCr1AuqWMKXOQY23dOW3wv21iL9cWzvhnFhnYqLYK9wkLtOThpaXsKHXad
         7LG0W3fFsODO6cW+MHJ1MMF3KQ1xuEn7ouIW7S8Pz8Zdx/4rcUAuqb85jmwP8gdGcu3E
         WBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327761; x=1688919761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwQzu1mHmg5s3RKGFVLiYioIdNZ9wrhFOjBtuF+UR3o=;
        b=XN9zwKWCGRo17iWjIWmHMlrcToWvKUUsTGxlPM7EUarsutKKkLyD4T3ySSRMCb1m5d
         mpuEJh2DOywUzRNWJBM2xukMLFh5NFSMeO97t4qzbUn0XysCnW5C+b2khKIXpktDxr6l
         9AVg3aIAU3xLGA63Rk9tvSr7ImEWH1w8iT+DJjBeWxcL4QCxXyg6PGYSm8iTgTgRppO2
         /6lvQWJPNFAwHGXjt3qYw2b3vjZskokInzvpLCp7Y8FzfCguW9I5H3EsCPpWE5A1E1/Z
         AZ96ZOiJVhcPe0GkphvYUbXkJyE/z2AVsAC7TA48ChXrkoXaFhoObqT2MwDowmmpLPpD
         plbQ==
X-Gm-Message-State: AC+VfDxrjHO+6316FXgZ+iUSomQNsfrXd23YuLCSZJLsgKT8HxAQ7zhK
        W5TcW+tfYiq0dz3VHrCwFbv5VnXUyRnanb0Xy+Ix+w==
X-Google-Smtp-Source: ACHHUZ7DcgGfw00xFeO5tg+xstcf0mM87ob4gA9UhI4JskArhrXvT7uOKL98JgUrv1OrQJ5y7tNmkHSsuMQI+Z6RFrg=
X-Received: by 2002:a81:4744:0:b0:565:e48d:32cf with SMTP id
 u65-20020a814744000000b00565e48d32cfmr1431353ywa.7.1686327760864; Fri, 09 Jun
 2023 09:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230609115058.9059-1-quic_jkona@quicinc.com> <20230609115058.9059-3-quic_jkona@quicinc.com>
In-Reply-To: <20230609115058.9059-3-quic_jkona@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 9 Jun 2023 19:22:29 +0300
Message-ID: <CAA8EJpr-iKMzYP7HVQV8pzXbxzLvBaq38aovJ5Ffny18yXvJZg@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] clk: qcom: camcc-sm8550: Add camera clock
 controller driver for SM8550
To:     Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
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

On Fri, 9 Jun 2023 at 14:52, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
> Add support for the camera clock controller for camera clients to be
> able to request for camcc clocks on SM8550 platform.
>
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
> Changes since V3:
>  - No changes
> Changes since V2:
>  - No changes
> Changes since V1:
>  - Sorted the PLL names in proper order
>  - Updated all PLL configurations to lower case hex
>  - Reused evo ops instead of adding new ops for ole pll
>  - Moved few clocks to separate patch to fix patch too long error
>
>  drivers/clk/qcom/Kconfig        |    7 +
>  drivers/clk/qcom/Makefile       |    1 +
>  drivers/clk/qcom/camcc-sm8550.c | 3405 +++++++++++++++++++++++++++++++
>  3 files changed, 3413 insertions(+)
>  create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 9cd1f05d436b..85efed78dc9a 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -756,6 +756,13 @@ config SM_CAMCC_8450
>           Support for the camera clock controller on SM8450 devices.
>           Say Y if you want to support camera devices and camera functionality.
>
> +config SM_CAMCC_8550
> +       tristate "SM8550 Camera Clock Controller"
> +       select SM_GCC_8550
> +       help
> +         Support for the camera clock controller on SM8550 devices.
> +         Say Y if you want to support camera devices and camera functionality.
> +
>  config SM_DISPCC_6115
>         tristate "SM6115 Display Clock Controller"
>         depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 75d035150118..97c8cefc2fd0 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_SDX_GCC_75) += gcc-sdx75.o
>  obj-$(CONFIG_SM_CAMCC_6350) += camcc-sm6350.o
>  obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
>  obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
> +obj-$(CONFIG_SM_CAMCC_8550) += camcc-sm8550.o
>  obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
>  obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
>  obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
> diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
> new file mode 100644
> index 000000000000..85f0c1e09b2b
> --- /dev/null
> +++ b/drivers/clk/qcom/camcc-sm8550.c
> @@ -0,0 +1,3405 @@
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
> +#include <dt-bindings/clock/qcom,sm8550-camcc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +       DT_IFACE,
> +       DT_BI_TCXO,
> +};
> +
> +enum {
> +       P_BI_TCXO,
> +       P_CAM_CC_PLL0_OUT_EVEN,
> +       P_CAM_CC_PLL0_OUT_MAIN,
> +       P_CAM_CC_PLL0_OUT_ODD,
> +       P_CAM_CC_PLL1_OUT_EVEN,
> +       P_CAM_CC_PLL2_OUT_EVEN,
> +       P_CAM_CC_PLL2_OUT_MAIN,
> +       P_CAM_CC_PLL3_OUT_EVEN,
> +       P_CAM_CC_PLL4_OUT_EVEN,
> +       P_CAM_CC_PLL5_OUT_EVEN,
> +       P_CAM_CC_PLL6_OUT_EVEN,
> +       P_CAM_CC_PLL7_OUT_EVEN,
> +       P_CAM_CC_PLL8_OUT_EVEN,
> +       P_CAM_CC_PLL9_OUT_EVEN,
> +       P_CAM_CC_PLL9_OUT_ODD,
> +       P_CAM_CC_PLL10_OUT_EVEN,
> +       P_CAM_CC_PLL11_OUT_EVEN,
> +       P_CAM_CC_PLL12_OUT_EVEN,
> +};
> +
> +static const struct pll_vco lucid_ole_vco[] = {
> +       { 249600000, 2300000000, 0 },
> +};
> +
> +static const struct pll_vco rivian_ole_vco[] = {
> +       { 777000000, 1285000000, 0 },
> +};
> +
> +static const struct alpha_pll_config cam_cc_pll0_config = {
> +       /* .l includes RINGOSC_CAL_L_VAL, CAL_L_VAL, L_VAL fields */
> +       .l = 0x4444003e,

I'd still insist on not touching the config.l field semantics.

> +       .alpha = 0x8000,
> +       .config_ctl_val = 0x20485699,
> +       .config_ctl_hi_val = 0x00182261,
> +       .config_ctl_hi1_val = 0x82aa299c,
> +       .test_ctl_val = 0x00000000,
> +       .test_ctl_hi_val = 0x00000003,
> +       .test_ctl_hi1_val = 0x00009000,
> +       .test_ctl_hi2_val = 0x00000034,
> +       .user_ctl_val = 0x00008400,
> +       .user_ctl_hi_val = 0x00000005,
> +};
> +

[skipped the rest, LGTM]

> +
> +static struct platform_driver cam_cc_sm8550_driver = {
> +       .probe = cam_cc_sm8550_probe,
> +       .driver = {
> +               .name = "cam_cc-sm8550",
> +               .of_match_table = cam_cc_sm8550_match_table,
> +       },
> +};
> +
> +static int __init cam_cc_sm8550_init(void)
> +{
> +       return platform_driver_register(&cam_cc_sm8550_driver);
> +}
> +subsys_initcall(cam_cc_sm8550_init);

As it was pointed out, this driver is built as a module by default.
Please perform the tesing and cleanup before sending the driver and
use module_platform_driver.

> +
> +static void __exit cam_cc_sm8550_exit(void)
> +{
> +       platform_driver_unregister(&cam_cc_sm8550_driver);
> +}
> +module_exit(cam_cc_sm8550_exit);
> +
> +MODULE_DESCRIPTION("QTI CAMCC SM8550 Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
