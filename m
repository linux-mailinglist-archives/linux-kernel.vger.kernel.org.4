Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E534B6AAF3B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 12:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCELEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 06:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCELEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 06:04:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D728EA5FD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 03:04:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74B1B60AE9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 11:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28BFC433EF;
        Sun,  5 Mar 2023 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678014246;
        bh=+h5Ipn6g03I3fzNCzees1eXF/FLWf9Wxv0AtlFg0Dhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U67eQWMIKzi5eaWOKiy+E+RwWWbvssN49Or0BD+M1MWsGTS0bahQJr5BAW0JS52Yd
         b0CoJpfaKsOfZXQdQDAqONy+k5OFgItlS2P9gMrl6nKLgtQd1Cgg9jpu+imfK27VDN
         JleCjSpg27ik+QFQnSZXztXKCClzGfvT/noNbMU2S4e5j/p24jgqL/i5hP0nKaLo+g
         BocTceI6YdQsPCtJi4I4G7otjIqUNG6IAEAqcMV8kBG0JPvtyPBOPT+L19+x1zFp9w
         6HJ46cJLDFoOJtDI8PvBiIB7aqO2aUPUMbwaF6GGHnskg9ETYCLH63FslU29r8qNuj
         pfXTGVHWiThCA==
Date:   Sun, 5 Mar 2023 11:04:02 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Message-ID: <20230305110402.GK2574592@google.com>
References: <20230301091234.3159953-1-Naresh.Solanki@9elements.com>
 <20230301091234.3159953-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301091234.3159953-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023, Naresh Solanki wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement a regulator driver with IRQ support for fault management.
> Written against documentation [1] and [2] and tested on real hardware.
> 
> Every channel has it's own regulator supply nammed 'vss1-supply' and
> 'vss2-supply'. The regulator supply is used to determine the output
> voltage, as the smart switch provides no output regulation.
> The driver requires the 'shunt-resistor-micro-ohms' to be present in
> the devicetree to properly calculate current related values.
> 
> You must specify compatible devictree layout:
> 
> regulator@3a {
>         reg = <0x3a>;
>         vss1-supply = <&p3v3>;
>         compatible = "maxim,max5978";
> 
>         ...
> 
>         regulators {
>                 sw0_ref: SW0 {
>                         regulator-compatible = "SW0";
>                         shunt-resistor-micro-ohms = <12000>;
>                         ...
>                 }
>         }
> }
> 
> 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/mfd/Kconfig          | 10 ++++
>  drivers/mfd/simple-mfd-i2c.c | 13 +++++
>  include/linux/mfd/max597x.h  | 97 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+)
>  create mode 100644 include/linux/mfd/max597x.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index d4fc4ca9fdbd..de899e0d2f1a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -266,6 +266,16 @@ config MFD_MADERA_SPI
>  	  Support for the Cirrus Logic Madera platform audio SoC
>  	  core functionality controlled via SPI.
>  
> +config MFD_MAX597X
> +	tristate "Maxim 597x power switch and monitor"
> +	depends on (I2C && OF)
> +	select MFD_SIMPLE_MFD_I2C
> +	help
> +	  This driver controls a Maxim 5970/5978 switch via I2C bus.
> +	  The MAX5970/5978 is a smart switch with no output regulation, but
> +	  fault protection and voltage and current monitoring capabilities.
> +	  Also it supports upto 4 indication leds.
> +
>  config MFD_CS47L15
>  	bool "Cirrus Logic CS47L15"
>  	select PINCTRL_CS47L15
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index e31f13fd6a79..20782b4dd172 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -72,9 +72,22 @@ static const struct simple_mfd_data silergy_sy7636a = {
>  	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
>  };
>  
> +static const struct mfd_cell max597x_cells[] = {
> +	{ .name = "max597x-regulator", },
> +	{ .name = "max597x-iio", },
> +	{ .name = "max597x-led", },
> +};
> +
> +static const struct simple_mfd_data maxim_max597x = {
> +	.mfd_cell = max597x_cells,
> +	.mfd_cell_size = ARRAY_SIZE(max597x_cells),
> +};
> +
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>  	{ .compatible = "kontron,sl28cpld" },
>  	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
> +	{ .compatible = "maxim,max5970", .data = &maxim_max597x},
> +	{ .compatible = "maxim,max5978", .data = &maxim_max597x},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max597x.h
> new file mode 100644
> index 000000000000..8a4da98caf3e
> --- /dev/null
> +++ b/include/linux/mfd/max597x.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Device driver for regulators in MAX5970 and MAX5978 IC
> + *
> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#ifndef _MAX597X_H
> +#define _MAX597X_H

__MFD_*

> +#include <linux/regmap.h>
> +
> +#define MAX5970_NUM_SWITCHES 2
> +#define MAX5978_NUM_SWITCHES 1
> +#define MAX597X_NUM_LEDS     4
> +
> +struct max597x_data {
> +	int num_switches;
> +	u32 irng[MAX5970_NUM_SWITCHES];
> +	u32 mon_rng[MAX5970_NUM_SWITCHES];
> +	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
> +};
> +
> +enum max597x_chip_type {
> +	MAX597x_TYPE_MAX5978 = 1,
> +	MAX597x_TYPE_MAX5970,
> +};
> +
> +#define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
> +#define MAX5970_REG_CURRENT_H(ch)		(0x00 + (ch) * 4)
> +#define MAX5970_REG_VOLTAGE_L(ch)		(0x03 + (ch) * 4)
> +#define MAX5970_REG_VOLTAGE_H(ch)		(0x02 + (ch) * 4)
> +#define MAX5970_REG_MON_RANGE			0x18
> +#define  MAX5970_MON_MASK			0x3
> +#define  MAX5970_MON(reg, ch) \
> +	(((reg) >> ((ch) * 2)) & MAX5970_MON_MASK)

Why the '\n'?

> +#define  MAX5970_MON_MAX_RANGE_UV		16000000
> +
> +#define MAX5970_REG_CH_UV_WARN_H(ch)		(0x1A + (ch) * 10)
> +#define MAX5970_REG_CH_UV_WARN_L(ch)		(0x1B + (ch) * 10)
> +#define MAX5970_REG_CH_UV_CRIT_H(ch)		(0x1C + (ch) * 10)
> +#define MAX5970_REG_CH_UV_CRIT_L(ch)		(0x1D + (ch) * 10)
> +#define MAX5970_REG_CH_OV_WARN_H(ch)		(0x1E + (ch) * 10)
> +#define MAX5970_REG_CH_OV_WARN_L(ch)		(0x1F + (ch) * 10)
> +#define MAX5970_REG_CH_OV_CRIT_H(ch)		(0x20 + (ch) * 10)
> +#define MAX5970_REG_CH_OV_CRIT_L(ch)		(0x21 + (ch) * 10)
> +
> +#define  MAX5970_VAL2REG_H(x)		(((x) >> 2) & 0xFF)
> +#define  MAX5970_VAL2REG_L(x)		((x) & 0x3)
> +
> +#define MAX5970_REG_DAC_FAST(ch)	(0x2E + (ch))
> +
> +#define MAX5970_FAST2SLOW_RATIO		200
> +
> +#define MAX5970_REG_STATUS0		0x31
> +#define  MAX5970_CB_IFAULTF(ch)		(1 << (ch))
> +#define  MAX5970_CB_IFAULTS(ch)		(1 << ((ch) + 4))
> +
> +#define MAX5970_REG_STATUS1		0x32
> +#define  STATUS1_PROT_MASK		0x3
> +#define  STATUS1_PROT(reg) \
> +	(((reg) >> 6) & STATUS1_PROT_MASK)
> +#define  STATUS1_PROT_SHUTDOWN		0
> +#define  STATUS1_PROT_CLEAR_PG		1
> +#define  STATUS1_PROT_ALERT_ONLY	2
> +
> +#define MAX5970_REG_STATUS2		0x33
> +#define  MAX5970_IRNG_MASK		0x3
> +#define  MAX5970_IRNG(reg, ch) \
> +	(((reg) >> ((ch) * 2)) & MAX5970_IRNG_MASK)
> +
> +#define MAX5970_REG_STATUS3		0x34
> +#define  MAX5970_STATUS3_ALERT		BIT(4)
> +#define  MAX5970_STATUS3_PG(ch)		BIT(ch)
> +
> +#define MAX5970_REG_FAULT0		0x35
> +#define  UV_STATUS_WARN(ch)		(1 << (ch))
> +#define  UV_STATUS_CRIT(ch)		(1 << ((ch) + 4))
> +
> +#define MAX5970_REG_FAULT1		0x36
> +#define  OV_STATUS_WARN(ch)		(1 << (ch))
> +#define  OV_STATUS_CRIT(ch)		(1 << ((ch) + 4))
> +
> +#define MAX5970_REG_FAULT2		0x37
> +#define  OC_STATUS_WARN(ch)		(1 << (ch))
> +
> +#define MAX5970_REG_CHXEN		0x3b
> +#define  CHXEN(ch)			(3 << ((ch) * 2))
> +
> +#define MAX5970_REG_LED_FLASH		0x43
> +
> +#define MAX_REGISTERS			0x49
> +#define ADC_MASK			0x3FF
> +
> +#endif				/* _MAX597X_H */
> -- 
> 2.39.1
> 

-- 
Lee Jones [李琼斯]
