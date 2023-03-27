Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5086CAAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjC0Qsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjC0Qsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:48:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632602718;
        Mon, 27 Mar 2023 09:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14D97B817B0;
        Mon, 27 Mar 2023 16:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFDDC433D2;
        Mon, 27 Mar 2023 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679935729;
        bh=RBHLpix/Xszw9JJ0ucrZ1EJILEOxun33InjcawwuCE4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NFJzwgrr4eBE9U877Qj9iwNQVN3CSva0WlZVYlhzk5QTBEQ/JnlaUJ/zdEf3Agylr
         4KonOj+BjRk5SMrCm99RotKuLIVL2L1fx+9iUJeJUsGIUPMt/b0qu25qmrWGUbpWW1
         wQEKbOStS83AG+Wr94+TSX1Yz6rymnDklS2dgI0v4lceabnviiN2kLFHdCvz1WmWaL
         ZIqTDy/B2D+Lj6CY4QatRjxsZrp0R6O0mkEOzqRcXR4rXSIL87uEmynQ6sapMekxCz
         o2aS4pZTTqCfLCrkdoCHaVLP0wtqTJmUeie3CX9FuSQxNxrIzz96ZT54Y+A3up5vcA
         pxuWLFB7wOTEw==
Message-ID: <0af15083921c5d3c89392209654f0c9b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230327132718.573-3-quic_devipriy@quicinc.com>
References: <20230327132718.573-1-quic_devipriy@quicinc.com> <20230327132718.573-3-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V10 2/4] clk: qcom: Add Global Clock Controller driver for IPQ9574
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, arnd@arndb.de, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel.ziswiler@toradex.com, mturquette@baylibre.com,
        nfraprado@collabora.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, shawnguo@kernel.org, will@kernel.org
Date:   Mon, 27 Mar 2023 09:48:47 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Devi Priya (2023-03-27 06:27:16)
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq957=
4.c
> new file mode 100644
> index 000000000000..b2a2d618a5ec
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -0,0 +1,4248 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (c) 2023 The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

What is this include for?

> +#include <linux/regmap.h>

Need to include clk-provider.h

> +
> +#include <linux/reset-controller.h>

Put a newline here.

> +#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +
> +#include "clk-rcg.h"
> +#include "clk-branch.h"
> +#include "clk-alpha-pll.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "clk-regmap-phy-mux.h"
> +#include "reset.h"
> +
> +/* Need to match the order of clocks in DT binding */
> +enum {
> +       DT_XO,
> +       DT_SLEEP_CLK,
> +       DT_BIAS_PLL_UBI_NC_CLK,
> +       DT_PCIE30_PHY0_PIPE_CLK,
> +       DT_PCIE30_PHY1_PIPE_CLK,
> +       DT_PCIE30_PHY2_PIPE_CLK,
> +       DT_PCIE30_PHY3_PIPE_CLK,
> +       DT_USB3PHY_0_CC_PIPE_CLK,
> +};
> +
> +enum {
> +       P_XO,
> +       P_PCIE30_PHY0_PIPE,
> +       P_PCIE30_PHY1_PIPE,
> +       P_PCIE30_PHY2_PIPE,
> +       P_PCIE30_PHY3_PIPE,
> +       P_USB3PHY_0_PIPE,
> +       P_GPLL0,
> +       P_GPLL0_DIV2,
> +       P_GPLL0_OUT_AUX,
> +       P_GPLL2,
> +       P_GPLL4,
> +       P_PI_SLEEP,
> +       P_BIAS_PLL_UBI_NC_CLK,
> +};
> +
> +static const struct parent_map gcc_xo_map[] =3D {
> +       { P_XO, 0 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_data[] =3D {
> +       { .index =3D DT_XO },
> +};
> +
> +static const struct clk_parent_data gcc_sleep_clk_data[] =3D {
> +       { .index =3D DT_SLEEP_CLK },
> +};
> +
> +static struct clk_alpha_pll gpll0_main =3D {
> +       .offset =3D 0x20000,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> +       .clkr =3D {
> +               .enable_reg =3D 0x0b000,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data) {

All these clk_init_data structs should be const.

> +                       .name =3D "gpll0_main",
> +                       .parent_data =3D gcc_xo_data,
> +                       .num_parents =3D ARRAY_SIZE(gcc_xo_data),
> +                       .ops =3D &clk_alpha_pll_ops,
> +               },
> +       },
> +};
