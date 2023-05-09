Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55456FCC7E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjEIRP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEIRPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:15:24 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BBFF3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:15:19 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b983027d0faso7954019276.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683652519; x=1686244519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m5K/VAWobe6QtxBJm14y/m85k0/aUzIPJ6lOqo+MArk=;
        b=PHkY22nUfk6ytVvqirp/RANagas4xMclCKwMRG8BUr1dgA/WCO2jk84mRCxTTnEqIT
         M0n37dDMZlDsNbMD5bGfgWxRk2G1upgUpXVvFPqc2kmyf1x2bT5E1vsTqWpEFLmrF8aZ
         scgHU5xA0OuoOiF1UqBDDvZYd05/7yxKc1UUPn8foGN4UnAL0kP5jZKEmcseEIrYoOsR
         WAmtSAmJgzpT5Jz4T9k3szfmDHTpUHf8z0bK9lfylRrn7r0ihWRPYddwE6MafErctofi
         zuok2nfDNuUJSe97KdZ6862SdqYOapY5Un8ZEEpiyAb2hHWR7i6GxR04neU+af5eT8Lw
         nR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683652519; x=1686244519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5K/VAWobe6QtxBJm14y/m85k0/aUzIPJ6lOqo+MArk=;
        b=CLsZlvunCNiNHgBGY8ImK+usOYL0oBFQZTqa6VM1uI+e/Eq8imJy34YO8EtAgO/2nZ
         e6iINbCgP6GS1RpVrkTMEuPGu3L6us68nGfyprBBbPsBET1yaUbM/jM0Zu14HV2jei8w
         ArhTeLv1jlzn/AdlyO8HZ7BOVaoEhhspgE5J5toLiVDwOwDujR//kKTrabD/CUWtvsGZ
         hcG7m3DwMYWTjUZ1dcZUD6cr3G5qRdXygMb7gZDeFYFeKvvrp4U4lIPOr8ZRZblcKFOV
         1wRE9Y6trkS/PiOutCbcqYP2XlTbr+T53jDk98Femv090GgYTXd7X/fiXDmTAFnRzCuk
         t6Ig==
X-Gm-Message-State: AC+VfDzmhyJ024tWA8tPli6zeQ8XRM1/ZlIvrnNtUTmz8qwd2qsJGO2Q
        1NihlvrXo/kBw0Aa2fItwMIueZ7P4nJjqrXHLG9BYQ==
X-Google-Smtp-Source: ACHHUZ7AVxP2o6Dea5tX2/rrit6n8sU9feVdJ1gls8GblkvBvwBO2QPgHpwK8l1GrqC5Ok74a+e2rRUA8cWtPZkQAB8=
X-Received: by 2002:a25:1854:0:b0:b75:9a44:5342 with SMTP id
 81-20020a251854000000b00b759a445342mr16103411yby.4.1683652518988; Tue, 09 May
 2023 10:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230509161218.11979-1-quic_jkona@quicinc.com> <20230509161218.11979-4-quic_jkona@quicinc.com>
In-Reply-To: <20230509161218.11979-4-quic_jkona@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 9 May 2023 20:15:08 +0300
Message-ID: <CAA8EJppn9=gPFk1RRB9y50aU_G3J6QrsOVQ9GH5gT86D_hOAgQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk: qcom: videocc-sm8550: Add video clock controller
 driver for SM8550
To:     Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 9 May 2023 at 19:14, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
> Add support for the video clock controller for video clients to be able
> to request for videocc clocks on SM8550 platform.
>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig          |  10 +
>  drivers/clk/qcom/Makefile         |   1 +
>  drivers/clk/qcom/videocc-sm8550.c | 468 ++++++++++++++++++++++++++++++
>  3 files changed, 479 insertions(+)
>  create mode 100644 drivers/clk/qcom/videocc-sm8550.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 12be3e2371b3..6bb9b4aff047 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -925,6 +925,16 @@ config SM_VIDEOCC_8250
>           Say Y if you want to support video devices and functionality such as
>           video encode and decode.
>
> +config SM_VIDEOCC_8550
> +       tristate "SM8550 Video Clock Controller"
> +       select SM_GCC_8550
> +       select QCOM_GDSC
> +       help
> +         Support for the video clock controller on Qualcomm Technologies, Inc.
> +         SM8550 devices.
> +         Say Y if you want to support video devices and functionality such as
> +         video encode/decode.
> +
>  config SPMI_PMIC_CLKDIV
>         tristate "SPMI PMIC clkdiv Support"
>         depends on SPMI || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 9ff4c373ad95..f0b95fc217aa 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -127,6 +127,7 @@ obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
>  obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
>  obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>  obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
> +obj-$(CONFIG_SM_VIDEOCC_8550) += videocc-sm8550.o
>  obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
>  obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
>  obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
> diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
> new file mode 100644
> index 000000000000..10e4b2725ddf
> --- /dev/null
> +++ b/drivers/clk/qcom/videocc-sm8550.c
> @@ -0,0 +1,468 @@
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
> +#include <dt-bindings/clock/qcom,sm8550-videocc.h>
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
> +       DT_BI_TCXO,

Any additional handling for gcc_video_ahb clk? It doesn't seem to be
used as a parent. Probably you intended to use it as a pm_clk?

> +};
> +
> +enum {
> +       P_BI_TCXO,
> +       P_VIDEO_CC_PLL0_OUT_MAIN,
> +       P_VIDEO_CC_PLL1_OUT_MAIN,
> +};
> +
> +static const struct pll_vco lucid_ole_vco[] = {
> +       { 249600000, 2300000000, 0 },
> +};
> +
> +static const struct alpha_pll_config video_cc_pll0_config = {
> +       .l = 0x44000025,
> +       .alpha = 0x8000,
> +       .config_ctl_val = 0x20485699,
> +       .config_ctl_hi_val = 0x00182261,
> +       .config_ctl_hi1_val = 0x82aa299c,
> +       .test_ctl_val = 0x00000000,
> +       .test_ctl_hi_val = 0x00000003,
> +       .test_ctl_hi1_val = 0x00009000,
> +       .test_ctl_hi2_val = 0x00000034,
> +       .user_ctl_val = 0x00000000,
> +       .user_ctl_hi_val = 0x00000005,
> +};
> +
> +static struct clk_alpha_pll video_cc_pll0 = {
> +       .offset = 0x0,
> +       .vco_table = lucid_ole_vco,
> +       .num_vco = ARRAY_SIZE(lucid_ole_vco),
> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +       .clkr = {
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "video_cc_pll0",
> +                       .parent_data = &(const struct clk_parent_data) {
> +                               .index = DT_BI_TCXO,
> +                       },
> +                       .num_parents = 1,
> +                       .ops = &clk_alpha_pll_lucid_ole_ops,
> +               },
> +       },
> +};
> +
> +static const struct alpha_pll_config video_cc_pll1_config = {
> +       .l = 0x44000036,
> +       .alpha = 0xb000,
> +       .config_ctl_val = 0x20485699,
> +       .config_ctl_hi_val = 0x00182261,
> +       .config_ctl_hi1_val = 0x82aa299c,
> +       .test_ctl_val = 0x00000000,
> +       .test_ctl_hi_val = 0x00000003,
> +       .test_ctl_hi1_val = 0x00009000,
> +       .test_ctl_hi2_val = 0x00000034,
> +       .user_ctl_val = 0x00000000,
> +       .user_ctl_hi_val = 0x00000005,
> +};
> +
> +static struct clk_alpha_pll video_cc_pll1 = {
> +       .offset = 0x1000,
> +       .vco_table = lucid_ole_vco,
> +       .num_vco = ARRAY_SIZE(lucid_ole_vco),
> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +       .clkr = {
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "video_cc_pll1",
> +                       .parent_data = &(const struct clk_parent_data) {
> +                               .index = DT_BI_TCXO,
> +                       },
> +                       .num_parents = 1,
> +                       .ops = &clk_alpha_pll_lucid_ole_ops,
> +               },
> +       },
> +};
> +
> +static const struct parent_map video_cc_parent_map_0[] = {
> +       { P_BI_TCXO, 0 },
> +       { P_VIDEO_CC_PLL0_OUT_MAIN, 1 },
> +};
> +
> +static const struct clk_parent_data video_cc_parent_data_0[] = {
> +       { .index = DT_BI_TCXO },
> +       { .hw = &video_cc_pll0.clkr.hw },
> +};
> +
> +static const struct parent_map video_cc_parent_map_1[] = {
> +       { P_BI_TCXO, 0 },
> +       { P_VIDEO_CC_PLL1_OUT_MAIN, 1 },
> +};
> +
> +static const struct clk_parent_data video_cc_parent_data_1[] = {
> +       { .index = DT_BI_TCXO },
> +       { .hw = &video_cc_pll1.clkr.hw },
> +};
> +
> +static const struct freq_tbl ftbl_video_cc_mvs0_clk_src[] = {
> +       F(720000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
> +       F(1014000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
> +       F(1098000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
> +       F(1332000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
> +       F(1600000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
> +       { }
> +};
> +
> +static struct clk_rcg2 video_cc_mvs0_clk_src = {
> +       .cmd_rcgr = 0x8000,
> +       .mnd_width = 0,
> +       .hid_width = 5,
> +       .parent_map = video_cc_parent_map_0,
> +       .freq_tbl = ftbl_video_cc_mvs0_clk_src,
> +       .clkr.hw.init = &(const struct clk_init_data) {
> +               .name = "video_cc_mvs0_clk_src",
> +               .parent_data = video_cc_parent_data_0,
> +               .num_parents = ARRAY_SIZE(video_cc_parent_data_0),
> +               .flags = CLK_SET_RATE_PARENT,
> +               .ops = &clk_rcg2_shared_ops,
> +       },
> +};
> +
> +static const struct freq_tbl ftbl_video_cc_mvs1_clk_src[] = {
> +       F(1050000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
> +       F(1350000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
> +       F(1500000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
> +       F(1650000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
> +       { }
> +};
> +
> +static struct clk_rcg2 video_cc_mvs1_clk_src = {
> +       .cmd_rcgr = 0x8018,
> +       .mnd_width = 0,
> +       .hid_width = 5,
> +       .parent_map = video_cc_parent_map_1,
> +       .freq_tbl = ftbl_video_cc_mvs1_clk_src,
> +       .clkr.hw.init = &(const struct clk_init_data) {
> +               .name = "video_cc_mvs1_clk_src",
> +               .parent_data = video_cc_parent_data_1,
> +               .num_parents = ARRAY_SIZE(video_cc_parent_data_1),
> +               .flags = CLK_SET_RATE_PARENT,
> +               .ops = &clk_rcg2_shared_ops,
> +       },
> +};
> +
> +static struct clk_regmap_div video_cc_mvs0_div_clk_src = {
> +       .reg = 0x80c4,
> +       .shift = 0,
> +       .width = 4,
> +       .clkr.hw.init = &(const struct clk_init_data) {
> +               .name = "video_cc_mvs0_div_clk_src",
> +               .parent_hws = (const struct clk_hw*[]) {
> +                       &video_cc_mvs0_clk_src.clkr.hw,
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +               .ops = &clk_regmap_div_ro_ops,
> +       },
> +};
> +
> +static struct clk_regmap_div video_cc_mvs0c_div2_div_clk_src = {
> +       .reg = 0x8070,
> +       .shift = 0,
> +       .width = 4,
> +       .clkr.hw.init = &(const struct clk_init_data) {
> +               .name = "video_cc_mvs0c_div2_div_clk_src",
> +               .parent_hws = (const struct clk_hw*[]) {
> +                       &video_cc_mvs0_clk_src.clkr.hw,
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +               .ops = &clk_regmap_div_ro_ops,
> +       },
> +};
> +
> +static struct clk_regmap_div video_cc_mvs1_div_clk_src = {
> +       .reg = 0x80ec,
> +       .shift = 0,
> +       .width = 4,
> +       .clkr.hw.init = &(const struct clk_init_data) {
> +               .name = "video_cc_mvs1_div_clk_src",
> +               .parent_hws = (const struct clk_hw*[]) {
> +                       &video_cc_mvs1_clk_src.clkr.hw,
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +               .ops = &clk_regmap_div_ro_ops,
> +       },
> +};
> +
> +static struct clk_regmap_div video_cc_mvs1c_div2_div_clk_src = {
> +       .reg = 0x809c,
> +       .shift = 0,
> +       .width = 4,
> +       .clkr.hw.init = &(const struct clk_init_data) {
> +               .name = "video_cc_mvs1c_div2_div_clk_src",
> +               .parent_hws = (const struct clk_hw*[]) {
> +                       &video_cc_mvs1_clk_src.clkr.hw,
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +               .ops = &clk_regmap_div_ro_ops,
> +       },
> +};
> +
> +static struct clk_branch video_cc_mvs0_clk = {
> +       .halt_reg = 0x80b8,
> +       .halt_check = BRANCH_HALT_SKIP,
> +       .hwcg_reg = 0x80b8,
> +       .hwcg_bit = 1,
> +       .clkr = {
> +               .enable_reg = 0x80b8,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "video_cc_mvs0_clk",
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &video_cc_mvs0_div_clk_src.clkr.hw,
> +                       },
> +                       .num_parents = 1,
> +                       .flags = CLK_SET_RATE_PARENT,
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch video_cc_mvs0c_clk = {
> +       .halt_reg = 0x8064,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0x8064,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "video_cc_mvs0c_clk",
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &video_cc_mvs0c_div2_div_clk_src.clkr.hw,
> +                       },
> +                       .num_parents = 1,
> +                       .flags = CLK_SET_RATE_PARENT,
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch video_cc_mvs1_clk = {
> +       .halt_reg = 0x80e0,
> +       .halt_check = BRANCH_HALT_SKIP,
> +       .hwcg_reg = 0x80e0,
> +       .hwcg_bit = 1,
> +       .clkr = {
> +               .enable_reg = 0x80e0,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "video_cc_mvs1_clk",
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &video_cc_mvs1_div_clk_src.clkr.hw,
> +                       },
> +                       .num_parents = 1,
> +                       .flags = CLK_SET_RATE_PARENT,
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch video_cc_mvs1c_clk = {
> +       .halt_reg = 0x8090,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0x8090,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "video_cc_mvs1c_clk",
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &video_cc_mvs1c_div2_div_clk_src.clkr.hw,
> +                       },
> +                       .num_parents = 1,
> +                       .flags = CLK_SET_RATE_PARENT,
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct gdsc video_cc_mvs0c_gdsc = {
> +       .gdscr = 0x804c,
> +       .en_rest_wait_val = 0x2,
> +       .en_few_wait_val = 0x2,
> +       .clk_dis_wait_val = 0x6,
> +       .pd = {
> +               .name = "video_cc_mvs0c_gdsc",
> +       },
> +       .pwrsts = PWRSTS_OFF_ON,
> +       .flags = RETAIN_FF_ENABLE,
> +};
> +
> +static struct gdsc video_cc_mvs0_gdsc = {
> +       .gdscr = 0x80a4,
> +       .en_rest_wait_val = 0x2,
> +       .en_few_wait_val = 0x2,
> +       .clk_dis_wait_val = 0x6,
> +       .pd = {
> +               .name = "video_cc_mvs0_gdsc",
> +       },
> +       .pwrsts = PWRSTS_OFF_ON,
> +       .parent = &video_cc_mvs0c_gdsc.pd,
> +       .flags = RETAIN_FF_ENABLE | HW_CTRL,
> +};
> +
> +static struct gdsc video_cc_mvs1c_gdsc = {
> +       .gdscr = 0x8078,
> +       .en_rest_wait_val = 0x2,
> +       .en_few_wait_val = 0x2,
> +       .clk_dis_wait_val = 0x6,
> +       .pd = {
> +               .name = "video_cc_mvs1c_gdsc",
> +       },
> +       .pwrsts = PWRSTS_OFF_ON,
> +       .flags = RETAIN_FF_ENABLE,
> +};
> +
> +static struct gdsc video_cc_mvs1_gdsc = {
> +       .gdscr = 0x80cc,
> +       .en_rest_wait_val = 0x2,
> +       .en_few_wait_val = 0x2,
> +       .clk_dis_wait_val = 0x6,
> +       .pd = {
> +               .name = "video_cc_mvs1_gdsc",
> +       },
> +       .pwrsts = PWRSTS_OFF_ON,
> +       .parent = &video_cc_mvs1c_gdsc.pd,
> +       .flags = RETAIN_FF_ENABLE | HW_CTRL,
> +};
> +
> +static struct clk_regmap *video_cc_sm8550_clocks[] = {
> +       [VIDEO_CC_MVS0_CLK] = &video_cc_mvs0_clk.clkr,
> +       [VIDEO_CC_MVS0_CLK_SRC] = &video_cc_mvs0_clk_src.clkr,
> +       [VIDEO_CC_MVS0_DIV_CLK_SRC] = &video_cc_mvs0_div_clk_src.clkr,
> +       [VIDEO_CC_MVS0C_CLK] = &video_cc_mvs0c_clk.clkr,
> +       [VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC] = &video_cc_mvs0c_div2_div_clk_src.clkr,
> +       [VIDEO_CC_MVS1_CLK] = &video_cc_mvs1_clk.clkr,
> +       [VIDEO_CC_MVS1_CLK_SRC] = &video_cc_mvs1_clk_src.clkr,
> +       [VIDEO_CC_MVS1_DIV_CLK_SRC] = &video_cc_mvs1_div_clk_src.clkr,
> +       [VIDEO_CC_MVS1C_CLK] = &video_cc_mvs1c_clk.clkr,
> +       [VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC] = &video_cc_mvs1c_div2_div_clk_src.clkr,
> +       [VIDEO_CC_PLL0] = &video_cc_pll0.clkr,
> +       [VIDEO_CC_PLL1] = &video_cc_pll1.clkr,
> +};
> +
> +static struct gdsc *video_cc_sm8550_gdscs[] = {
> +       [VIDEO_CC_MVS0C_GDSC] = &video_cc_mvs0c_gdsc,
> +       [VIDEO_CC_MVS0_GDSC] = &video_cc_mvs0_gdsc,
> +       [VIDEO_CC_MVS1C_GDSC] = &video_cc_mvs1c_gdsc,
> +       [VIDEO_CC_MVS1_GDSC] = &video_cc_mvs1_gdsc,
> +};
> +
> +static const struct qcom_reset_map video_cc_sm8550_resets[] = {
> +       [CVP_VIDEO_CC_INTERFACE_BCR] = { 0x80f0 },
> +       [CVP_VIDEO_CC_MVS0_BCR] = { 0x80a0 },
> +       [CVP_VIDEO_CC_MVS0C_BCR] = { 0x8048 },
> +       [CVP_VIDEO_CC_MVS1_BCR] = { 0x80c8 },
> +       [CVP_VIDEO_CC_MVS1C_BCR] = { 0x8074 },

Please rename them to start with the VIDEO_CC prefix.

> +       [VIDEO_CC_MVS0C_CLK_ARES] = { 0x8064, 2 },
> +       [VIDEO_CC_MVS1C_CLK_ARES] = { 0x8090, 2 },
> +};
> +
> +static const struct regmap_config video_cc_sm8550_regmap_config = {
> +       .reg_bits = 32,
> +       .reg_stride = 4,
> +       .val_bits = 32,
> +       .max_register = 0x9f4c,
> +       .fast_io = true,
> +};
> +
> +static struct qcom_cc_desc video_cc_sm8550_desc = {
> +       .config = &video_cc_sm8550_regmap_config,
> +       .clks = video_cc_sm8550_clocks,
> +       .num_clks = ARRAY_SIZE(video_cc_sm8550_clocks),
> +       .resets = video_cc_sm8550_resets,
> +       .num_resets = ARRAY_SIZE(video_cc_sm8550_resets),
> +       .gdscs = video_cc_sm8550_gdscs,
> +       .num_gdscs = ARRAY_SIZE(video_cc_sm8550_gdscs),
> +};
> +
> +static const struct of_device_id video_cc_sm8550_match_table[] = {
> +       { .compatible = "qcom,sm8550-videocc" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, video_cc_sm8550_match_table);
> +
> +static int video_cc_sm8550_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       int ret;
> +
> +       ret = devm_pm_runtime_enable(&pdev->dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = pm_runtime_resume_and_get(&pdev->dev);
> +       if (ret)
> +               return ret;
> +
> +       regmap = qcom_cc_map(pdev, &video_cc_sm8550_desc);
> +       if (IS_ERR(regmap)) {
> +               pm_runtime_put(&pdev->dev);
> +               return PTR_ERR(regmap);
> +       }
> +
> +       clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
> +       clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
> +
> +       /*
> +        * Keep clocks always enabled:
> +        *      video_cc_ahb_clk
> +        *      video_cc_sleep_clk
> +        *      video_cc_xo_clk
> +        */
> +       regmap_update_bits(regmap, 0x80f4, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0x8140, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0x8124, BIT(0), BIT(0));
> +
> +       ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
> +
> +       pm_runtime_put(&pdev->dev);
> +
> +       return ret;
> +}
> +
> +static struct platform_driver video_cc_sm8550_driver = {
> +       .probe = video_cc_sm8550_probe,
> +       .driver = {
> +               .name = "video_cc-sm8550",
> +               .of_match_table = video_cc_sm8550_match_table,
> +       },
> +};
> +
> +static int __init video_cc_sm8550_init(void)
> +{
> +       return platform_driver_register(&video_cc_sm8550_driver);
> +}
> +subsys_initcall(video_cc_sm8550_init);

module_platform_driver() instead? There is no need to register videocc
at the subsys level.

> +
> +static void __exit video_cc_sm8550_exit(void)
> +{
> +       platform_driver_unregister(&video_cc_sm8550_driver);
> +}
> +module_exit(video_cc_sm8550_exit);
> +
> +MODULE_DESCRIPTION("QTI VIDEO_CC SM8550 Driver");
> +MODULE_LICENSE("GPL");

-- 
With best wishes
Dmitry
