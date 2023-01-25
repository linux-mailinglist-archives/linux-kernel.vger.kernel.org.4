Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C4C67BD6F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbjAYUyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjAYUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:54:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431854A237;
        Wed, 25 Jan 2023 12:54:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBBAD615AD;
        Wed, 25 Jan 2023 20:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B378C433EF;
        Wed, 25 Jan 2023 20:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674680080;
        bh=jLzNKjyc09opMzRxjkf1IrKwt5abM/dWPoSM+2ilEkk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X/uDu3O5qXsiTWl6cqsmS+r3tM9PmmYl/gFX19wihE3gUQssRRRgZbXD/YR3Wiuqk
         IDIOALPim0r8rA8sD99J+rL7RbcPKZHAqIShXKxxm20xyRARghupyDkZFnTF07p1Gg
         x7JmCz7CT4EIbHToFXV/QEnk9aW3XzDnctemrD8C8d8lnlSF1y1AqY+DD2bTM9EgjZ
         rLyHtU7lgSfEPSlueZesJyGbxtnJb3D59IZqPaa13fq5yleqo56ZMgQQGZL92OPVOb
         PcN24IDwrkFTwLT+82hERv8tlcCyzyaPZzORg8i4LHKihykE/jVpLlPgqmGxZ0UHeE
         1KCji5hDKRu5Q==
Message-ID: <9cf8a94f7ec4d8912bcf507631991999.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230125104520.89684-6-quic_kathirav@quicinc.com>
References: <20230125104520.89684-1-quic_kathirav@quicinc.com> <20230125104520.89684-6-quic_kathirav@quicinc.com>
Subject: Re: [PATCH 05/10] clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Kathiravan T <quic_kathirav@quicinc.com>
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, arnd@arndb.de,
        bhupesh.sharma@linaro.org, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, marcel.ziswiler@toradex.com,
        mturquette@baylibre.com, nfraprado@collabora.com,
        quic_gurus@quicinc.com, robh+dt@kernel.org, robimarko@gmail.com,
        shawnguo@kernel.org, ulf.hansson@linaro.org, will@kernel.org
Date:   Wed, 25 Jan 2023 12:54:37 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kathiravan Thirumoorthy (2023-01-25 02:45:15)
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq533=
2.c
> new file mode 100644
> index 000000000000..8351096a4d32
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -0,0 +1,3954 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights r=
eserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
[...]
> +
> +static const struct freq_tbl ftbl_gcc_pcnoc_bfdcd_clk_src[] =3D {
> +       F(24000000, P_XO, 1, 0, 0),
> +       F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
> +       F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
> +       { }
> +};
> +
> +static struct clk_rcg2 gcc_pcnoc_bfdcd_clk_src =3D {
> +       .cmd_rcgr =3D 0x31004,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D gcc_parent_map_0,
> +       .freq_tbl =3D ftbl_gcc_pcnoc_bfdcd_clk_src,
> +       .clkr.hw.init =3D &(const struct clk_init_data){
> +               .name =3D "gcc_pcnoc_bfdcd_clk_src",
> +               .parent_data =3D gcc_parent_data_0,
> +               .num_parents =3D ARRAY_SIZE(gcc_parent_data_0),
> +               .ops =3D &clk_rcg2_ops,
> +               .flags =3D CLK_IS_CRITICAL,

Why not just turn these clks on in probe and never register them with
the framework? That saves some memory for clks that there is no desire
to control from linux. This is an RCG, so in theory the frequency can
change, but does it really? Usually bus clks are controlled by the
interconnect driver.
