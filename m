Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4B46E14CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDMTEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDMTEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967D76B9;
        Thu, 13 Apr 2023 12:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97C9D64121;
        Thu, 13 Apr 2023 19:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A480BC433D2;
        Thu, 13 Apr 2023 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681412686;
        bh=4FEqjPSBWEd+pQmOy7lkm5ZVGdiBe0T6lbnRPjNK85g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UAziBoFmAvl5QgFgIIgzUAEmm6wP/gfbXnWPRyN/iA8nfXj+JVRWegwz3HWImMTo3
         zvK4Tbbh/Up5MxbxsC7MZTNlvv3134kK7//YFFBi2M5mnry7e0xKnTcAzJJ5k5wcOJ
         iFGbhPAaNl6rlcYRqZm9dJumC3zhRe90N5eFRvd3+opD//BPEXuF3uBjTonBTlkdyt
         rpy4kcUdW7ITUeQuTfiQ0R9weuoiLKZYKsb7Y8+aLzJvAZJzdG1Z9K/iuSAJHKoCyP
         X9kOH5ZEa6yaw1SLkhc+L6DC84xITPetDsb3qpTyNXCW7IjSGpUIgp8bGHUuZtaNP2
         gTV/hqq4qlzPQ==
Message-ID: <2f955dc3105570df0acc2695739183ed.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230413-topic-lahaina_vidcc-v1-2-134f9b22a5b3@linaro.org>
References: <20230413-topic-lahaina_vidcc-v1-0-134f9b22a5b3@linaro.org> <20230413-topic-lahaina_vidcc-v1-2-134f9b22a5b3@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: Introduce SM8350 VIDEOCC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 13 Apr 2023 12:04:44 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-04-13 11:44:59)
> diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc=
-sm8350.c
> new file mode 100644
> index 000000000000..186a5bd9e184
> --- /dev/null
> +++ b/drivers/clk/qcom/videocc-sm8350.c
> @@ -0,0 +1,575 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_clock.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,sm8350-videocc.h>
> +#include <dt-bindings/reset/qcom,sm8350-videocc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "reset.h"
> +#include "gdsc.h"
> +
> +enum {
> +       DT_BI_TCXO,
> +       DT_BI_TCXO_AO,
> +       DT_SLEEP_CLK,
> +};
> +
> +enum {
> +       P_BI_TCXO,
> +       P_BI_TCXO_AO,
> +       P_SLEEP_CLK,
> +       P_VIDEO_PLL0_OUT_MAIN,
> +       P_VIDEO_PLL1_OUT_MAIN,
> +};
> +
> +static struct pll_vco lucid_5lpe_vco[] =3D {

const

> +       { 249600000, 1750000000, 0 },
> +};
> +
> +static const struct alpha_pll_config video_pll0_config =3D {
> +       .l =3D 0x25,
> +       .alpha =3D 0x8000,
> +       .config_ctl_val =3D 0x20485699,
> +       .config_ctl_hi_val =3D 0x00002261,
> +       .config_ctl_hi1_val =3D 0x2a9a699c,
> +       .test_ctl_val =3D 0x00000000,
> +       .test_ctl_hi_val =3D 0x00000000,
> +       .test_ctl_hi1_val =3D 0x01800000,
> +       .user_ctl_val =3D 0x00000000,
> +       .user_ctl_hi_val =3D 0x00000805,
> +       .user_ctl_hi1_val =3D 0x00000000,
> +};
> +
> +static struct clk_alpha_pll video_pll0 =3D {
> +       .offset =3D 0x42c,
> +       .vco_table =3D lucid_5lpe_vco,
> +       .num_vco =3D ARRAY_SIZE(lucid_5lpe_vco),
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){

const

> +                       .name =3D "video_pll0",
> +                       .parent_data =3D &(const struct clk_parent_data){
> +                               .index =3D DT_BI_TCXO,
> +                       },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_lucid_5lpe_ops,
> +               },
[...]
> +
> +static const struct regmap_config video_cc_sm8350_regmap_config =3D {
> +       .reg_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .val_bits =3D 32,
> +       .max_register =3D 0x10000,
> +       .fast_io =3D true,
> +};
> +
> +static struct qcom_cc_desc video_cc_sm8350_desc =3D {
> +       .config =3D &video_cc_sm8350_regmap_config,
> +       .clks =3D video_cc_sm8350_clocks,
> +       .num_clks =3D ARRAY_SIZE(video_cc_sm8350_clocks),
> +       .resets =3D video_cc_sm8350_resets,
> +       .num_resets =3D ARRAY_SIZE(video_cc_sm8350_resets),
> +       .gdscs =3D video_cc_sm8350_gdscs,
> +       .num_gdscs =3D ARRAY_SIZE(video_cc_sm8350_gdscs),
> +};
> +
> +static void video_cc_sm8350_pm_runtime_disable(void *data)
> +{
> +       pm_runtime_disable(data);
> +}
> +
> +static int video_cc_sm8350_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       int ret;
> +
> +       pm_runtime_enable(&pdev->dev);
> +
> +       ret =3D devm_add_action_or_reset(&pdev->dev, video_cc_sm8350_pm_r=
untime_disable, &pdev->dev);

devm_pm_runtime_enable()?

> +       if (ret)
> +               return ret;
> +
