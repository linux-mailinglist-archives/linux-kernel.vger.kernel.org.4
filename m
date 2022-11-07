Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA561FB6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiKGRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKGRcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:32:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6622B20BE0;
        Mon,  7 Nov 2022 09:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01383611E6;
        Mon,  7 Nov 2022 17:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB79C433D6;
        Mon,  7 Nov 2022 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667842360;
        bh=/3vHnyI/NFM87j4khRS7iy63kuMqTNYgGJWlOGjO70M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWdJgtWFFoNViSs2nnifF4/6516vsYT/nm+j7zSHE1kypGk6qUkoNdAPW6u69a43/
         V1QzAk5vzuKko5bVVfvSXw33ztBmss+Rg6yoH2tT0jG2tAQLSa8Fy0mBk8FmzT6dYD
         sVNZnwm9W4ledoX9ADTBFi3QHDvGBWkLdwWhncACLg2W77pGb5G9sqQlE1DeY0T8Z0
         CXooTNUy8o18xcINj162/zwP2qxLaxbzoU9ZMZ1XYwUvdIYrF28bGPxqcg86qksA1x
         UekNO/swFKXD0Dxa5RB9NxLbEe2QuBy8GBL81uLWbOr5L7lsFC2t7yJMR3i+Ph2sPl
         8RfD7rB0UPfCg==
Date:   Mon, 7 Nov 2022 11:32:37 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] clk: qcom: Add QDU1000 and QRU1000 GCC support
Message-ID: <20221107173237.xkeigtihoes3vsux@builder.lan>
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
 <20221026190441.4002212-4-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026190441.4002212-4-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:04:39PM -0700, Melody Olvera wrote:
> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
> new file mode 100644
> index 000000000000..7bd8ebf0ddb5
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-qdu1000.c
> @@ -0,0 +1,2645 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gcc-qdu1000.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "clk-regmap-phy-mux.h"
> +#include "reset.h"
> +
> +enum {
> +	P_BI_TCXO,
> +	P_GCC_GPLL0_OUT_EVEN,
> +	P_GCC_GPLL0_OUT_MAIN,
> +	P_GCC_GPLL1_OUT_MAIN,
> +	P_GCC_GPLL2_OUT_MAIN,
> +	P_GCC_GPLL3_OUT_MAIN,
> +	P_GCC_GPLL4_OUT_MAIN,
> +	P_GCC_GPLL5_OUT_MAIN,
> +	P_GCC_GPLL6_OUT_MAIN,
> +	P_GCC_GPLL7_OUT_MAIN,
> +	P_GCC_GPLL8_OUT_MAIN,
> +	P_PCIE_0_PHY_AUX_CLK,
> +	P_PCIE_0_PIPE_CLK,
> +	P_SLEEP_CLK,
> +	P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
> +};
[..]
> +static const struct clk_parent_data gcc_parent_data_1[] = {
> +	{ .index = P_BI_TCXO },
> +	{ .hw = &gcc_gpll0.clkr.hw },
> +	{ .index = P_SLEEP_CLK },

.index here refers to the index in the clocks property in DT.

I think it's okay to reuse the parent-enum, but the entries within must
then match the order defined in the DT binding. So you need to ensure
that the first N entires in the enum matches the binding.

Perhaps it's cleaner to just carry a separate enum for the clocks order,
as we've done in the other drivers?

If nothing else it makes it clear that one number space is arbitrary and
internal to the driver and the other is ABI.

> +	{ .hw = &gcc_gpll0_out_even.clkr.hw },
> +};
> +
[..]
> +static struct clk_regmap_mux gcc_pcie_0_phy_aux_clk_src = {
> +	.reg = 0x9d080,
> +	.shift = 0,
> +	.width = 2,
> +	.parent_map = gcc_parent_map_6,
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data){

Sorry for being picky, but I do like when there's a space between the
')' and '{' in these lines...

> +			.name = "gcc_pcie_0_phy_aux_clk_src",
> +			.parent_data = gcc_parent_data_6,
> +			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
> +			.ops = &clk_regmap_mux_closest_ops,
> +		},
> +	},
> +};

Regards,
Bjorn
