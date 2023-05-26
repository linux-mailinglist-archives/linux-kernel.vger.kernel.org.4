Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81059712654
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbjEZMMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjEZMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6378E128;
        Fri, 26 May 2023 05:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2D44615BE;
        Fri, 26 May 2023 12:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE386C4339B;
        Fri, 26 May 2023 12:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685103123;
        bh=0OGgez+bxAhDWB3J6RtnFhQscw9kTUdRiuRLaL+k4+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oz2Xi+dyCsvXKib4pJ3+bzEvLSbQo9vvNxHeSVKDOVh3+kgqpeUay2KsmkvJTWfFu
         Ib12E54jAsNGXIMx801lVLhDiI4MM+FuaW+7J0kYlro3Q+T/L/YxXFRWBtqzE6EPyR
         CLAqPqx30ceChoQs6A9S0pBN7TY+Yas1sAZfG3+95Q+nprdwKxBTIwPgtNnrwUmU3/
         eiha+pU6HuSQ0Nhtsu0W9One5cu9KVekUNPeIXxUNmrCPhiS0G5VRNgWbBYSSEP2uH
         /5o0wb4PrQINrI89YFslvlM4/YsfCjMiFp4gjEhnT1rkboF/W2XBTNHKiLF/npLOGL
         VcJHmB9cgks8g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q2WIo-00073t-Vh; Fri, 26 May 2023 14:12:15 +0200
Date:   Fri, 26 May 2023 14:12:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] clk: qcom: Add lpass clock controller driver for
 SC8280XP
Message-ID: <ZHCiHtVkVL7_ZwaK@hovoldconsulting.com>
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525122930.17141-4-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 01:29:27PM +0100, Srinivas Kandagatla wrote:
> Add support for the lpass clock controller found on SC8280XP based devices.
> This would allow lpass peripheral loader drivers to control the clocks and
> bring the subsystems out of reset.
> 
> Currently this patch only supports resets as the Q6DSP is in control of
> LPASS IP which manages most of the clocks via Q6PRM service on GPR rpmsg
> channel.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig            |  8 ++++
>  drivers/clk/qcom/Makefile           |  1 +
>  drivers/clk/qcom/lpasscc-sc8280xp.c | 63 +++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
>  create mode 100644 drivers/clk/qcom/lpasscc-sc8280xp.c

> --- /dev/null
> +++ b/drivers/clk/qcom/lpasscc-sc8280xp.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>

Newline?

> +#include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
> +
> +#include "common.h"
> +#include "reset.h"
> +
> +static const struct qcom_reset_map lpasscc_sc8280xp_resets[] = {
> +	[LPASS_AUDIO_SWR_TX_CGCR] = { 0xc010, 1 },
> +};
> +
> +static struct regmap_config lpasscc_sc8280xp_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.name = "lpass-tcsr",
> +	.max_register = 0x12000,
> +};
> +
> +static const struct qcom_cc_desc lpasscc_reset_sc8280xp_desc = {

Nit: Isn't "lpasscc_sc8280xp" the prefix you should use throughout
(i.e. this should be lpasscc_sc8280xp_reset_desc or similar).

> +	.config = &lpasscc_sc8280xp_regmap_config,
> +	.resets = lpasscc_sc8280xp_resets,
> +	.num_resets = ARRAY_SIZE(lpasscc_sc8280xp_resets),
> +};
> +
> +static const struct of_device_id lpasscc_sc8280xp_match_table[] = {
> +	{
> +		.compatible = "qcom,sc8280xp-lpasscc",
> +		.data = &lpasscc_reset_sc8280xp_desc,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lpasscc_sc8280xp_match_table);

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
