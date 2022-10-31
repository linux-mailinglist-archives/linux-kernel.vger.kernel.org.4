Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB861387B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiJaN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJaN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:56:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259DE2C4;
        Mon, 31 Oct 2022 06:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E3461253;
        Mon, 31 Oct 2022 13:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89213C433D6;
        Mon, 31 Oct 2022 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667224593;
        bh=iOmwncQH3Y6yGSTU4hQSdlvIACqmymxsbpgLTMPTEXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1HwHqpejoRdZazFe/wHCMougeuGQsGEvil2CCRBhvGFEYwLiNy/lMHZ5ruhOxgt7
         gtxr4WUQGv9FdirbR1EqGLW/G3JU2zjWh5/N6qM268ISdVk2MwkUKf4qbWSwZ6n03Y
         M1oG4mHPLYU+ESN2TvpLb456hu3OMrd32THrmbQqHT+OaBKE6oeQPWqR+lffMFqTHe
         NknKuplIC2G/yb3yTmG2+LVFQK1x22o/QCYKiXz1OkOxZeZmkjnbn3hLoltZi7SfC/
         zTx/LVo0xVKVgMvXtKIcxR1NMy9e5lTC9RwaEK6S5uUL734R79Q2+t357WNi5yyW6H
         l+TAGisiuyi0Q==
Date:   Mon, 31 Oct 2022 13:56:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 07/13] mfd: rk808: split into core and i2c
Message-ID: <Y1/UCkQQXOb38VW+@google.com>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
 <20221020204251.108565-8-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221020204251.108565-8-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022, Sebastian Reichel wrote:

> Split rk808 into a core and an i2c part in preperation for
> SPI support.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/clk/Kconfig                   |   2 +-
>  drivers/input/misc/Kconfig            |   2 +-
>  drivers/mfd/Kconfig                   |   7 +-
>  drivers/mfd/Makefile                  |   3 +-
>  drivers/mfd/{rk808.c => rk8xx-core.c} | 210 ++++----------------------
>  drivers/mfd/rk8xx-i2c.c               | 209 +++++++++++++++++++++++++
>  drivers/pinctrl/Kconfig               |   2 +-
>  drivers/power/supply/Kconfig          |   2 +-
>  drivers/regulator/Kconfig             |   2 +-
>  drivers/rtc/Kconfig                   |   2 +-
>  include/linux/mfd/rk808.h             |   6 +
>  sound/soc/codecs/Kconfig              |   2 +-
>  12 files changed, 263 insertions(+), 186 deletions(-)
>  rename drivers/mfd/{rk808.c => rk8xx-core.c} (75%)
>  create mode 100644 drivers/mfd/rk8xx-i2c.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index d79905f3e174..8448d616b9aa 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -83,7 +83,7 @@ config COMMON_CLK_MAX9485
>  
>  config COMMON_CLK_RK808
>  	tristate "Clock driver for RK805/RK808/RK809/RK817/RK818"
> -	depends on MFD_RK808
> +	depends on MFD_RK8XX
>  	help
>  	  This driver supports RK805, RK809 and RK817, RK808 and RK818 crystal oscillator clock.
>  	  These multi-function devices have two fixed-rate oscillators, clocked at 32KHz each.
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 9f088900f863..1899afeaec47 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -588,7 +588,7 @@ config INPUT_PWM_VIBRA
>  
>  config INPUT_RK805_PWRKEY
>  	tristate "Rockchip RK805 PMIC power key support"
> -	depends on MFD_RK808
> +	depends on MFD_RK8XX
>  	help
>  	  Select this option to enable power key driver for RK805.
>  
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b93856de432..8e3de443cc3d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1201,12 +1201,17 @@ config MFD_RC5T583
>  	  Additional drivers must be enabled in order to use the
>  	  different functionality of the device.
>  
> -config MFD_RK808
> +config MFD_RK8XX
> +	bool
> +	select MFD_CORE
> +
> +config MFD_RK8XX_I2C
>  	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power Management Chip"
>  	depends on I2C && OF
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
> +	select MFD_RK8XX
>  	help
>  	  If you say yes here you get support for the RK805, RK808, RK809,
>  	  RK817 and RK818 Power Management chips.
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 7ed3ef4a698c..edf84e870f98 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -223,7 +223,8 @@ obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
>  obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> -obj-$(CONFIG_MFD_RK808)		+= rk808.o
> +obj-$(CONFIG_MFD_RK8XX)		+= rk8xx-core.o
> +obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
>  obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
>  obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
>  obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk8xx-core.c
> similarity index 75%
> rename from drivers/mfd/rk808.c
> rename to drivers/mfd/rk8xx-core.c
> index b154ca96d812..098506972710 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk8xx-core.c
> @@ -3,16 +3,9 @@
>   * MFD core driver for Rockchip RK808/RK818
>   *
>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
> - *
> - * Author: Chris Zhong <zyw@rock-chips.com>
> - * Author: Zhang Qing <zhangqing@rock-chips.com>
> - *
>   * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> - *
> - * Author: Wadim Egorov <w.egorov@phytec.de>
>   */

The patch and the premise behind it look reasonable.

What's the reason for taking out the Author tags?

-- 
Lee Jones [李琼斯]
