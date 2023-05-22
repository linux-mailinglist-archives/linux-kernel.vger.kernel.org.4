Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55270B7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjEVIcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEVIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0F61BC;
        Mon, 22 May 2023 01:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B517B61EDB;
        Mon, 22 May 2023 08:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA68C433EF;
        Mon, 22 May 2023 08:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684744294;
        bh=W/SXzFaHoumvyxZpY2Mb9F9Cjxd6ET1DkSU5bd0jR5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGT1mRq9rwx+b3tvRHL+d9ZKPS1Px1p4204bXukdUNB+yDmywsAwwVRiJ1uqQELh4
         Myq1sKS37mJRcN/jl14QYnx6SpISjwPdpiWofYWE/gaMSQvdpopMPkWifPcN9CPaIK
         GeGFLcoluend2l/psVCAz7HfloxhNoHu7WacVfFSZw7zi9LBGAwdLnnfQiiP2pEPGr
         duFQ2mw+l2ZmITRgbXvpqPffZ5p8QGEqmfcixmHFizmvv832TPQnHsVLgFg3DKLAvm
         FpRXJFHQBzN1BLAkqnFULKhd7aPQHVI0+vzF/vOlKyD1pJGcRPvy3LJgr3GjZKL4CA
         4+to49AjRCQqw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q10x3-0004Rv-F9; Mon, 22 May 2023 10:31:34 +0200
Date:   Mon, 22 May 2023 10:31:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] clk: qcom: Add lpass clock controller driver for
 SC8280XP
Message-ID: <ZGsoZTPRLTQZOX3I@hovoldconsulting.com>
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
 <20230518113800.339158-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518113800.339158-4-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:37:58PM +0100, Srinivas Kandagatla wrote:
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
>  drivers/clk/qcom/lpasscc-sc8280xp.c | 71 +++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100644 drivers/clk/qcom/lpasscc-sc8280xp.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 12be3e2371b3..8188f4dedf40 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -514,6 +514,14 @@ config SC_GPUCC_8280XP
>  	  Say Y if you want to support graphics controller devices and
>  	  functionality such as 3D graphics.
>  
> +config SC_LPASSCC_8280XP

Should go after SC_LPASSCC_7280.

> +	tristate "SC8280 Low Power Audio Subsystem (LPASS) Clock Controller"
> +	select SC_GCC_8280XP
> +	help
> +	  Support for the LPASS clock controller on SC8280XP devices.
> +	  Say Y if you want to use the LPASS branch clocks of the LPASS clock
> +	  controller to reset the LPASS subsystem.
> +
>  config SC_LPASSCC_7280
>  	tristate "SC7280 Low Power Audio Subsystem (LPASS) Clock Controller"
>  	select SC_GCC_7280
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 9ff4c373ad95..dce2dd639524 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
>  obj-$(CONFIG_SC_DISPCC_7180) += dispcc-sc7180.o
>  obj-$(CONFIG_SC_DISPCC_7280) += dispcc-sc7280.o
>  obj-$(CONFIG_SC_DISPCC_8280XP) += dispcc-sc8280xp.o
> +obj-$(CONFIG_SC_LPASSCC_8280XP) += lpasscc-sc8280xp.o

This looks misplaced too.

>  obj-$(CONFIG_SA_GCC_8775P) += gcc-sa8775p.o
>  obj-$(CONFIG_SA_GPUCC_8775P) += gpucc-sa8775p.o
>  obj-$(CONFIG_SC_GCC_7180) += gcc-sc7180.o
> diff --git a/drivers/clk/qcom/lpasscc-sc8280xp.c b/drivers/clk/qcom/lpasscc-sc8280xp.c
> new file mode 100644
> index 000000000000..118320f8ee40
> --- /dev/null
> +++ b/drivers/clk/qcom/lpasscc-sc8280xp.c
> @@ -0,0 +1,71 @@
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
> +#include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
> +#include "common.h"
> +#include "reset.h"

Nit: add newline separators before dt-bindings and local includes,
respectively?

> +static int __init lpasscc_sc8280xp_init(void)
> +{
> +	return platform_driver_register(&lpasscc_sc8280xp_driver);
> +}
> +subsys_initcall(lpasscc_sc8280xp_init);

Do you really need subsys init for this? I've been using this driver as
a module on the X13s and it seems to work fine.

> +static void __exit lpasscc_sc8280xp_exit(void)
> +{
> +	platform_driver_unregister(&lpasscc_sc8280xp_driver);
> +}
> +module_exit(lpasscc_sc8280xp_exit);
> +
> +MODULE_DESCRIPTION("QTI LPASSCC SC8280XP Driver");
> +MODULE_LICENSE("GPL");

Johan
