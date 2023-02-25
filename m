Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD066A2B74
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBYTMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYTMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:12:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C76136C3;
        Sat, 25 Feb 2023 11:12:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4DEF1CE01D0;
        Sat, 25 Feb 2023 19:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB556C433D2;
        Sat, 25 Feb 2023 19:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677352357;
        bh=0vpB2THat6gxQ/k766OqOq20mDWVg0CTv/RytdcMqhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FSc6o3KXvp8Rh7d1okql+FX6ytVZ68JtMLB5AKgVcvyVa9tWV4YDa7zUTGn83GPZz
         jEVKB3jn2TYc5jXIYG+fwHWGr8rw1OB7T0m20BBIyQsSg6zds/FPcb/ojHtp56pSxL
         RrIl3zvC/OjNUu9X4RElAxQ8FAnOlHISoudoYq+gVYv0XBuiFZk9Q59kpPQe0QW2S/
         G7wL+qn0dS02zz+POlJkbAVCc+WPUmJGfAzyz/kGFJ3Z1wQbEiJkrenZVR7Tlnx7kH
         UdL9SUtLCrTvHkgEFgR9vuAUWYB4NAknikfMsVqOArFnZYf8Ckpc4c7qTuUuXzPb2u
         1pyf0InMHfsQw==
Date:   Sat, 25 Feb 2023 19:27:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for pac193x
Message-ID: <20230225192701.79df7fd0@jic23-huawei>
In-Reply-To: <20230220123232.413029-3-marius.cristea@microchip.com>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
        <20230220123232.413029-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 14:32:32 +0200
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip
> PAC193X series of Power Monitor with Accumulator chip family.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

Hi Marius,

As mentioned in DT binding review, wild cards in file names and driver names
have caused us mess far too many times in the past.  So don't do it, just pick
a representative part from the list - if no other basis to chose go with the
lowest number currently supported.

The custom ABI in here needs documentation before we can review it properly.

Comments inline.

It's a big driver, so I'm sure more stuff will come up next round just due to
mental exhaustion reviewing it in one go!

Thanks,

Jonathan
> ---
>  MAINTAINERS               |    7 +
>  drivers/iio/adc/Kconfig   |   12 +
>  drivers/iio/adc/Makefile  |    1 +
>  drivers/iio/adc/pac193x.c | 2072 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 2092 insertions(+)
>  create mode 100644 drivers/iio/adc/pac193x.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c81bbb771678..6675dc1b6b19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8187,6 +8187,13 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>  F:	drivers/fpga/intel-m10-bmc-sec-update.c
>  
> +MICROCHIP PAC193X POWER/ENERGY MONITOR DRIVER
> +M:	Marius Cristea <marius.cristea@@microchip.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
> +F:	drivers/iio/adc/pac193x.c
> +
>  MICROCHIP POLARFIRE FPGA DRIVERS
>  M:	Conor Dooley <conor.dooley@microchip.com>
>  R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 4a95c843a91b..ae4f60e290c4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -867,6 +867,18 @@ config NPCM_ADC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called npcm_adc.
>  
> +config PAC193X
> +	tristate "Microchip Technology PAC193X driver"
> +	depends on I2C
> +	depends on IIO
> +	help
> +	  Say yes here to build support for Microchip Technology's PAC1934,
> +	  PAC1933, PAC1932, PAC1931 Single/Multi-Channel Power Monitor with
> +	  Accumulator.

Order preferred as 1, 2, 3, 4 
Nothing really wrong with this way around other than it not being the common
choice so being slightly unexpected if someone is reading this fast.


> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pac193x.
> +
>  config PALMAS_GPADC
>  	tristate "TI Palmas General Purpose ADC"
>  	depends on MFD_PALMAS
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 36c18177322a..81824128c6cd 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
>  obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
>  obj-$(CONFIG_NAU7802) += nau7802.o
>  obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
> +obj-$(CONFIG_PAC193X) += pac193x.o
>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
> diff --git a/drivers/iio/adc/pac193x.c b/drivers/iio/adc/pac193x.c
> new file mode 100644
> index 000000000000..ece6bf028fe2
> --- /dev/null
> +++ b/drivers/iio/adc/pac193x.c
> @@ -0,0 +1,2072 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for PAC193X Multi-Channel DC Power/Energy Monitor
> + *
> + * Copyright (C) 2017-2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Bogdan Bolocan <bogdan.bolocan@microchip.com>
> + * Author: Victor Tudose
> + * Author: Marius Cristea <marius.cristea@microchip.com>
> + *
> + * Datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
Check these includes to make sure they are all still relevant.
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/timer.h>
> +#include <linux/util_macros.h>
> +
> +/*
> + * maxim should be (17 * 60 * 1000) around 17 minutes@1024 sps

Either spell it out of max

> + * till PAC193X register stars to saturate
> + */
> +#define PAC193X_MAX_RFSH_LIMIT_MS		60000
> +
> +/* 50msec is the timeout for validity of the cached registers */
> +#define PAC193X_MIN_POLLING_TIME_MS		50
> +
> +#define SHUNT_UOHMS_DEFAULT			100000
> +/* 32000mV */
> +#define PAC193X_VOLTAGE_MILLIVOLTS_MAX		32000
> +/* voltage bits resolution when set for unsigned values */
> +#define PAC193X_VOLTAGE_U_RES			16
> +/* voltage bits resolution when set for signed values */
> +#define PAC193X_VOLTAGE_S_RES			15
> +/* 100mV maximum for current shunts */
> +#define PAC193X_VSENSE_MILLIVOLTS_MAX		100
> +/* voltage bits resolution when set for unsigned values */
> +#define PAC193X_CURRENT_U_RES			16
> +/* voltage bits resolution when set for signed values */
> +#define PAC193X_CURRENT_S_RES			15
> +
> +/* power resolution is 28 bits when unsigned */
> +#define PAC193X_POWER_U_RES			 28
> +/* power resolution is 27 bits when signed */
> +#define PAC193X_POWER_S_RES			27
> +
> +/* energy accumulation is 48 bits long */
> +#define PAC193X_ENERGY_U_RES			48
> +
> +#define PAC193X_ENERGY_S_RES			47
> +#define PAC193X_ENERGY_SHIFT_MAIN_VAL		32
> +
> +#define BIT_INDEX_31				31
> +
> +/*
> + * max signed value that can be stored on 32 bits and 8 digits fractional value
> + * (2^31 - 1) * 10^8 + 99999999
> + */
> +#define PAC_193X_MAX_POWER_ACC			214748364799999999LL
> +/*
> + * min signed value that can be stored on 32 bits and 8 digits fractional value
> + * -(2^31) * 10^8 - 99999999
> + */
> +#define PAC_193X_MIN_POWER_ACC			-214748364899999999LL
> +
> +/* maximum value that device can measure - 32 V * 0.1 V */
> +#define PAC193X_PRODUCT_VOLTAGE_PV_FSR		3200000000000UL
> +
> +#define PAC193X_MAX_NUM_CHANNELS		4
> +#define PAC1931_NUM_CHANNELS			1
> +#define PAC1932_NUM_CHANNELS			2
> +#define PAC1933_NUM_CHANNELS			3
> +#define PAC1934_NUM_CHANNELS			4
> +#define PAC193X_CH_1				0
> +#define PAC193X_CH_2				1
> +#define PAC193X_CH_3				2
> +#define PAC193X_CH_4				3
> +#define PAC193X_MEAS_REG_LEN			76
> +#define PAC193X_CTRL_REG_LEN			12
> +
> +/*
> + * 1000usec is the minimum wait time for normal conversions when sample
> + * rate doesn't change
> + */
> +#define PAC193X_MIN_UPDATE_WAIT_TIME_MS		1000
> +
> +#define PAC193X_DEFAULT_CHIP_SAMP_SPEED		1024
> +
> +/* I2C address map */
> +#define PAC193X_REFRESH_REG			0x00

Naming with ADDR and without is confusing. What's the difference?

> +#define PAC193X_CTRL_REG			0x01
> +#define PAC193X_REFRESH_V_REG			0x1F
> +#define PAC193X_ACC_COUNT_REG			0x02
> +#define PAC193X_CTRL_STAT_REGS_ADDR		0x1C
> +#define PAC193X_PID_REG_ADDR			0xFD
> +#define PAC193X_MID_REG_ADDR			0xFE
> +#define PAC193X_RID_REG_ADDR			0xFF
> +
> +/* PRODUCT ID REGISTER + MANUFACTURER ID REGISTER + REVISION ID REGISTER */
> +#define PAC193X_ID_REG_LEN			0x03
> +#define PAC193X_PID_IDX				0
> +#define PAC193X_MID_IDX				1
> +#define PAC193X_RID_IDX				2
> +
> +#define PAC193X_ACPI_ARG_COUNT			4
> +#define PAC193X_ACPI_GET_NAMES_AND_MOHMS_VALS	1
> +#define PAC193X_ACPI_GET_UOHMS_VALS		2
> +#define PAC193X_ACPI_GET_BIPOLAR_SETTINGS	4
> +#define PAC193X_ACPI_GET_SAMP			5
> +
> +#define PAC193X_VPOWER_ACC_1_ADDR		0x03
> +#define PAC193X_VPOWER_ACC_2_ADDR		0x04
> +#define PAC193X_VPOWER_ACC_3_ADDR		0x05
> +#define PAC193X_VPOWER_ACC_4_ADDR		0x06
> +#define PAC193X_VBUS_1_ADDR			0x07
> +#define PAC193X_VBUS_2_ADDR			0x08
> +#define PAC193X_VBUS_3_ADDR			0x09
> +#define PAC193X_VBUS_4_ADDR			0x0A
> +#define PAC193X_VSENSE_1_ADDR			0x0B
> +#define PAC193X_VSENSE_2_ADDR			0x0C
> +#define PAC193X_VSENSE_3_ADDR			0x0D
> +#define PAC193X_VSENSE_4_ADDR			0x0E
> +#define PAC193X_VBUS_AVG_1_ADDR			0x0F
> +#define PAC193X_VBUS_AVG_2_ADDR			0x10
> +#define PAC193X_VBUS_AVG_3_ADDR			0x11
> +#define PAC193X_VBUS_AVG_4_ADDR			0x12
> +#define PAC193X_VSENSE_AVG_1_ADDR		0x13
> +#define PAC193X_VSENSE_AVG_2_ADDR		0x14
> +#define PAC193X_VSENSE_AVG_3_ADDR		0x15
> +#define PAC193X_VSENSE_AVG_4_ADDR		0x16
> +#define PAC193X_VPOWER_1_ADDR			0x17
> +#define PAC193X_VPOWER_2_ADDR			0x18
> +#define PAC193X_VPOWER_3_ADDR			0x19
> +#define PAC193X_VPOWER_4_ADDR			0x1A
> +
> +#define PAC193X_SAMPLE_RATE_SHIFT		6
> +
> +/*
> + * these indexes are exactly describing the element order within a single
> + * PAC193X phys channel IIO channel descriptor; see the static const struct
> + * iio_chan_spec pac193x_single_channel[] declaration
> + */
> +#define IIO_EN					0
> +#define IIO_POW					1
> +#define IIO_VOLT				2
> +#define IIO_CRT					3
> +#define IIO_VOLTAVG				4
> +#define IIO_CRTAVG				5
> +
> +#define PAC193X_VBUS_SENSE_REG_LEN		2
> +#define PAC193X_ACC_REG_LEN			3
> +#define PAC193X_VPOWER_REG_LEN			4
> +#define PAC193X_VPOWER_ACC_REG_LEN		6
> +#define PAC193X_MAX_REGISTER_LENGTH		6
> +
> +#define PAC193X_CUSTOM_ATTR_FOR_CHANNEL		2
> +#define PAC193X_SHARED_DEVATTRS_COUNT		1
> +
> +/*
> + * relative offsets when using multi-byte reads/writes even though these
> + * bytes are read one after the other, they are not at adjacent memory
> + * locations within the I2C memory map. The chip can skip some addresses
> + */
> +#define PAC193X_CHANNEL_DIS_REG_OFF		0
> +#define PAC193X_NEG_PWR_REG_OFF			1
> +
> +/*
> + * when reading/writing multiple bytes from offset PAC193X_CHANNEL_DIS_REG_OFF,
> + * the chip jumps over the 0x1E (REFRESH_G) and 0x1F (REFRESH_V) offsets
> + */
> +#define PAC193X_SLOW_REG_OFF			2
> +#define PAC193X_CTRL_ACT_REG_OFF		3
> +#define PAC193X_CHANNEL_DIS_ACT_REG_OFF		4
> +#define PAC193X_NEG_PWR_ACT_REG_OFF		5
> +#define PAC193X_CTRL_LAT_REG_OFF		6
> +#define PAC193X_CHANNEL_DIS_LAT_REG_OFF		7
> +#define PAC193X_NEG_PWR_LAT_REG_OFF		8
> +#define PAC193X_PID_REG_OFF			9
> +#define PAC193X_MID_REG_OFF			10
> +#define PAC193X_REV_REG_OFF			11
> +#define PAC193X_CTRL_STATUS_INFO_LEN		12
> +
> +#define PAC193X_MID				0x5D
> +#define PAC1934_PID				0x5B
> +#define PAC1933_PID				0x5A
> +#define PAC1932_PID				0x59
> +#define PAC1931_PID				0x58
> +
> +/* Scale constant = (10^8 / 2^28) * 3.2 * 10^9 */
> +#define PAC193X_SCALE_CONSTANT			1192092895UL
> +
> +#define PAC193X_MAX_VPOWER_RSHIFTED_BY_28B	11921
> +#define PAC193X_MAX_VSENSE_RSHIFTED_BY_16B	1525
> +
> +#define PAC193X_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
> +
> +#define PAC193X_CRTL_SAMPLE_RATE_MASK	GENMASK(7, 6)
> +#define PAC193X_CRTL_SAMPLE_RATE_SET(x)	((u8)FIELD_PREP(PAC193X_CRTL_SAMPLE_RATE_MASK, (x)))
> +#define PAC193X_CHAN_SLEEP_MASK		BIT(5)
> +#define PAC193X_CHAN_SLEEP_SET		BIT(5)
> +#define PAC193X_CHAN_SINLE_MASK		BIT(4)
> +#define PAC193X_CHAN_SINLE_SHOT_SET	BIT(4)
> +#define PAC193X_CHAN_ALERT_MASK		BIT(3)
> +#define PAC193X_CHAN_ALERT_EN		BIT(3)
> +#define PAC193X_CHAN_ALERT_CC_MASK	BIT(2)
> +#define PAC193X_CHAN_ALERT_CC_EN	BIT(2)
> +#define PAC193X_CHAN_OVF_ALERT_MASK	BIT(1)
> +#define PAC193X_CHAN_OVF_ALERT_EN	BIT(1)
> +#define PAC193X_CHAN_OVF_MASK		BIT(0)
> +
> +#define PAC193X_CHAN_DIS_CH1_OFF_MASK	BIT(7)
> +#define PAC193X_CHAN_DIS_CH1_OFF(x)	((u8)FIELD_PREP(PAC193X_CHAN_DIS_CH1_OFF_MASK, !(x)))
> +#define PAC193X_CHAN_DIS_CH2_OFF_MASK	BIT(6)
> +#define PAC193X_CHAN_DIS_CH2_OFF(x)	((u8)FIELD_PREP(PAC193X_CHAN_DIS_CH2_OFF_MASK, !(x)))
> +#define PAC193X_CHAN_DIS_CH3_OFF_MASK	BIT(5)
> +#define PAC193X_CHAN_DIS_CH3_OFF(x)	((u8)FIELD_PREP(PAC193X_CHAN_DIS_CH3_OFF_MASK, !(x)))
> +#define PAC193X_CHAN_DIS_CH4_OFF_MASK	BIT(4)
> +#define PAC193X_CHAN_DIS_CH4_OFF(x)	((u8)FIELD_PREP(PAC193X_CHAN_DIS_CH4_OFF_MASK, !(x)))
> +#define PAC193X_SMBUS_TIMEOUT_MASK	BIT(3)
> +#define PAC193X_SMBUS_TIMEOUT_EN(x)	FIELD_PREP(PAC193X_SMBUS_TIMEOUT_MASK, x)
> +#define PAC193X_SMBUS_BYTECOUNT_MASK	BIT(2)
> +#define PAC193X_SMBUS_BYTECOUNT_EN(x)	FIELD_PREP(PAC193X_SMBUS_BYTECOUNT_MASK, x)
> +#define PAC193X_SMBUS_NO_SKIP_MASK	BIT(1)
> +#define PAC193X_SMBUS_NO_SKIP_EN(x)	FIELD_PREP(PAC193X_SMBUS_NO_SKIP_MASK, x)
> +
> +#define PAC193X_NEG_PWR_CH1_BIDI(x)	((x) ? BIT(7) : 0)

To be more standard for kernel code, define a mask and use FIELD_PREP() for these
as well.

> +#define PAC193X_NEG_PWR_CH2_BIDI(x)	((x) ? BIT(6) : 0)
> +#define PAC193X_NEG_PWR_CH3_BIDI(x)	((x) ? BIT(5) : 0)
> +#define PAC193X_NEG_PWR_CH4_BIDI(x)	((x) ? BIT(4) : 0)
> +#define PAC193X_NEG_PWR_CH1_BIDV(x)	((x) ? BIT(3) : 0)
> +#define PAC193X_NEG_PWR_CH2_BIDV(x)	((x) ? BIT(2) : 0)
> +#define PAC193X_NEG_PWR_CH3_BIDV(x)	((x) ? BIT(1) : 0)
> +#define PAC193X_NEG_PWR_CH4_BIDV(x)	((x) ? BIT(0) : 0)
> +
> +/*
> + * Universal Unique Identifier (UUID),
> + * 033771E0-1705-47B4-9535-D1BBE14D9A09, is
> + * reserved to Microchip for the PAC193X and must not be changed
> + */
> +#define PAC193X_DSM_UUID		"033771E0-1705-47B4-9535-D1BBE14D9A09"
> +
> +enum pac193x_ids {
> +	pac1934,
> +	pac1933,
> +	pac1932,
> +	pac1931
> +};
> +
> +enum pac193x_samps {
> +	pac193X_samp_1024sps,
> +	pac193X_samp_256sps,
> +	pac193X_samp_64sps,
> +	pac193X_samp_8sps
> +};
> +
> +/**
> + * struct pac193x_features - features of a pac193x instance
> + * @phys_channels: number of physical channels supported by the chip
> + * @prod_id: product ID
> + */
> +struct pac193x_features {
> +	u8 phys_channels;
> +	u8 prod_id;
> +};
> +
> +struct samp_rate_mapping {
> +	u16 samp_rate;
> +	u8 shift2value;
> +};
> +
> +static const unsigned int samp_rate_map_tbl[] = {
> +	[pac193X_samp_1024sps] = 1024,
> +	[pac193X_samp_256sps] = 256,
> +	[pac193X_samp_64sps] = 64,
> +	[pac193X_samp_8sps] = 8,
> +};
> +
> +static const struct pac193x_features pac193x_chip_config[] = {
> +	[pac1934] = {
> +	    .phys_channels = PAC193X_MAX_NUM_CHANNELS,

Better as a number than a define.

> +	    .prod_id = PAC1934_PID,
> +	},
> +	[pac1933] = {
> +	    .phys_channels = PAC193X_MAX_NUM_CHANNELS - 1,
> +	    .prod_id = PAC1933_PID,
> +	},
> +	[pac1932] = {
> +	    .phys_channels = PAC193X_MAX_NUM_CHANNELS - 2,
> +	    .prod_id = PAC1932_PID,
> +	},
> +	[pac1931] = {
> +	    .phys_channels = PAC193X_MAX_NUM_CHANNELS - 3,
> +	    .prod_id = PAC1931_PID,
> +	},
> +};
> +
> +/**
> + * struct reg_data - data from the registers
> + * @meas_regs: snapshot of raw measurements registers
> + * @ctrl_regs: snapshot of control registers
> + * @energy_sec_acc: snapshot of energy values
> + * @vpower_acc: accumulated vpower values
> + * @vpower: snapshot of vpower registers
> + * @vbus: snapshot of vbus registers
> + * @vbus_avg: averages of vbus registers
> + * @vsense: snapshot of vsense registers
> + * @vsense_avg: averages of vsense registers
> + * @num_enabled_channels: count of how many chip channels are currently enabled
> + */
> +struct reg_data {
> +	u8	meas_regs[PAC193X_MEAS_REG_LEN];
> +	u8	ctrl_regs[PAC193X_CTRL_REG_LEN];
> +	s64	energy_sec_acc[PAC193X_MAX_NUM_CHANNELS];
> +	s64	vpower_acc[PAC193X_MAX_NUM_CHANNELS];
> +	s32	vpower[PAC193X_MAX_NUM_CHANNELS];
> +	s32	vbus[PAC193X_MAX_NUM_CHANNELS];
> +	s32	vbus_avg[PAC193X_MAX_NUM_CHANNELS];
> +	s32	vsense[PAC193X_MAX_NUM_CHANNELS];
> +	s32	vsense_avg[PAC193X_MAX_NUM_CHANNELS];
> +	u8	num_enabled_channels;
> +};
> +
> +/**
> + * struct pac193x_chip_info - information about the chip
> + * @client: the i2c-client attached to the device
> + * @lock: lock used by the chip's mutex
> + * @tmr_forced_update: timers used
> + * @wq_chip: queued work used for refresh commands
> + * @work_chip_rfsh: work used for refresh commands
> + * @phys_channels: phys channels count
> + * @active_channels: array of values, true means that channel is active
> + * @bi_dir: array of bools, true means that channel is bidirectional
> + * @chip_variant: chip variant
> + * @chip_revision: chip revision
> + * @shunts: shunts
> + * @chip_reg_data: chip reg data
> + * @sample_rate_value: sampling frequency
> + * @channel_names: channel names
> + * @pac193x_info: pac193x_info
> + * @jiffies_tstamp: chip's uptime
> + * @crt_samp_spd_bitfield:the current sampling speed

Order should match below.

> + */
> +struct pac193x_chip_info {
> +	struct i2c_client	*client;
> +	struct mutex		lock; /*lock to prevent concurent reads/writes */
> +	struct timer_list	tmr_forced_update;
> +	struct workqueue_struct *wq_chip;
> +	struct work_struct	work_chip_rfsh;
> +	u8			phys_channels;
> +	bool			active_channels[PAC193X_MAX_NUM_CHANNELS];
> +	bool			bi_dir[PAC193X_MAX_NUM_CHANNELS];
> +	u8			chip_variant;
> +	u8			chip_revision;
> +	u32			shunts[PAC193X_MAX_NUM_CHANNELS];
> +	struct reg_data		chip_reg_data;
> +	s32			sample_rate_value;
> +	char			*channel_names[PAC193X_MAX_NUM_CHANNELS];
> +	u8			crt_samp_spd_bitfield;
> +	unsigned long		jiffies_tstamp;
> +	struct iio_info		pac193x_info;
> +};
> +
> +struct __packed pac193x_uuid_format {

Not a standard UUID?  uuid_t

> +	u32	data1;
> +	u16	data2;
> +	u16	data3;
> +	u8	data4[8];
> +};
> +
> +#define to_pac193x_chip_info(d) container_of(d, struct pac193x_chip_info, work_chip_rfsh)
> +
> +/* macros to extract the parameters */
> +#define MVACCS(x)		sign_extend64((u64)(x), 47)
> +#define MVPOWERS(x)		sign_extend32((u32)(x), 27)
> +#define MVBUS_SENSES(x)		sign_extend32((u32)(x), 15)
Prefix defines with PAC193X to avoid future namespace clasehs.
I'm not 100% convinced these aren't better handled inline though rther than vai these
macros.

> +
> +#define PAC193X_VPOWER_ACC_CHANNEL(_index, _si, _address) {			\
> +	.type = IIO_ENERGY,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|			\
> +				BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = (_si),							\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = PAC193X_ENERGY_U_RES,				\
> +		.storagebits = PAC193X_ENERGY_U_RES,				\
> +		.shift = 0,							\
> +		.endianness = IIO_CPU,						\
> +	}									\
> +}
> +
> +#define PAC193X_VBUS_CHANNEL(_index, _si, _address) {				\
> +	.type = IIO_VOLTAGE,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = (_si),							\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = PAC193X_VOLTAGE_U_RES,				\
> +		.storagebits = PAC193X_VOLTAGE_U_RES,				\
> +		.shift = 0,							\
> +		.endianness = IIO_CPU,						\
> +	}									\
> +}
> +
> +#define PAC193X_VBUS_AVG_CHANNEL(_index, _si, _address) {			\
> +	.type = IIO_VOLTAGE,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_AVERAGE_RAW)			\
> +				| BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = (_si),							\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = PAC193X_VOLTAGE_U_RES,				\
> +		.storagebits = PAC193X_VOLTAGE_U_RES,				\
> +		.shift = 0,							\
> +		.endianness = IIO_CPU,						\
> +	}									\
> +}
> +
> +#define PAC193X_VSENSE_CHANNEL(_index, _si, _address) {				\
> +	.type = IIO_CURRENT,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = (_si),							\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = PAC193X_CURRENT_U_RES,				\
> +		.storagebits = PAC193X_CURRENT_U_RES,				\
> +		.shift = 0,							\
> +		.endianness = IIO_CPU,						\
> +	}									\
> +}
> +
> +#define PAC193X_VSENSE_AVG_CHANNEL(_index, _si, _address) {			\
> +	.type = IIO_CURRENT,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_AVERAGE_RAW) |			\
> +			BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = (_si),							\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = PAC193X_CURRENT_U_RES,				\
> +		.storagebits = PAC193X_CURRENT_U_RES,				\
> +		.shift = 0,	
When shift is 0, it can be assumed as 'obvious' default and skipped. Rely on C to set it to 0 for us.						\
> +		.endianness = IIO_CPU,						\
> +	}									\
> +}
> +
> +#define PAC193X_VPOWER_CHANNEL(_index, _si, _address) {				\
> +	.type = IIO_POWER,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = (_si),							\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = PAC193X_POWER_U_RES,				\
> +		.storagebits = 32,						\
> +		.shift = 4,							\
> +		.endianness = IIO_CPU,						\
> +	}									\
> +}
> +
> +#define PAC193X_SOFT_TIMESTAMP(_index) {					\
> +	.type = IIO_TIMESTAMP,							\
> +	.channel = -1,								\

What is this for?  

> +	.scan_index = (_index),							\
> +}
> +
> +static const struct iio_chan_spec pac193x_single_channel[] = {
> +	PAC193X_VPOWER_ACC_CHANNEL(0, 0, PAC193X_VPOWER_ACC_1_ADDR),
> +	PAC193X_VPOWER_CHANNEL(0, 0, PAC193X_VPOWER_1_ADDR),
> +	PAC193X_VBUS_CHANNEL(0, 0, PAC193X_VBUS_1_ADDR),
> +	PAC193X_VSENSE_CHANNEL(0, 0, PAC193X_VSENSE_1_ADDR),
> +	PAC193X_VBUS_AVG_CHANNEL(0, 0, PAC193X_VBUS_AVG_1_ADDR),
> +	PAC193X_VSENSE_AVG_CHANNEL(0, 0, PAC193X_VSENSE_AVG_1_ADDR),
> +};
> +
> +static const struct iio_chan_spec pac193x_ts[] = {
> +	PAC193X_SOFT_TIMESTAMP(0),
> +};
> +
> +static inline u64 pac193x_get_mvaccu(u8 *addr)
> +{
> +	return (((u64)(*(u8 *)((addr) + 0)) << 40) |
> +		((u64)(*(u8 *)((addr) + 1)) << 32) |
> +		((u64)(*(u8 *)((addr) + 2)) << 24) |
> +		((u64)(*(u8 *)((addr) + 3)) << 16) |
> +		((u64)(*(u8 *)((addr) + 4)) << 8)  |
> +		((u64)(*(u8 *)((addr) + 5)) << 0));

get_unaligned_be48()?

> +}
> +
> +static inline u32 pac193x_get_vpoweru(u8 *addr)
> +{
> +	return (((u32)(*(u8 *)((addr) + 0)) << 20) |
> +		((u32)(*(u8 *)((addr) + 1)) << 12) |
> +		((u32)(*(u8 *)((addr) + 2)) << 4) |
> +		((u32)(*(u8 *)((addr) + 3)) >> 4));
Hmm. Does this do same as

get_unaligned_be32(addr) >> 4 ?

> +}
> +
> +static inline u16 pac193x_get_mvbus_senseu(u8 *addr)
> +{
> +	u16 tmp;
> +
> +	tmp = (u16)(*(u16 *)(addr));
> +	be16_to_cpus(&tmp);

get_unaligned_be16?

> +
> +	return tmp;
> +}
> +
> +/* Low-level I2c functions */
> +static int pac193x_i2c_read(struct i2c_client *client, u8 reg_addr, void *databuf, u8 len)
> +{
> +	int ret;
> +	struct i2c_msg msgs[2] = {
> +		{ .addr = client->addr,
> +		 .len = 1,
> +		 .buf = (u8 *)&reg_addr,
> +		 .flags = 0
> +		},
> +		{ .addr = client->addr,
> +		 .len = len,
> +		 .buf = databuf,
> +		 .flags = I2C_M_RD
> +		}
> +	};
> +
> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int pac193x_i2c_write_byte(struct i2c_client *client, u8 reg_addr, u8 val)
> +{
> +	int ret;
> +	u8 buf[2];
> +	struct i2c_msg msg = {
> +		.addr = client->addr,
> +		.len = sizeof(buf),
> +		.buf = (u8 *)&buf,
> +		.flags = 0
> +	};
> +
> +	buf[0] = reg_addr;
> +	buf[1] = val;
> +
> +	ret = i2c_transfer(client->adapter, &msg, 1);

i2c_smbus_write_byte_data()?  

> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"failed writing register 0x%02X\n", reg_addr);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pac193x_i2c_send_byte(struct i2c_client *client, u8 reg_addr)
> +{
> +	int ret;
> +	u8 buf;
> +	struct i2c_msg msg = {
> +		.addr = client->addr,
> +		.len = sizeof(buf),
> +		.buf = (u8 *)&buf,
> +		.flags = 0
> +	};
> +
> +	buf = reg_addr;
> +	ret = i2c_transfer(client->adapter, &msg, 1);

looks like it might match i2c_smbus_write()

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int pac193x_i2c_write(struct i2c_client *client, u8 reg_addr, u8 *data, int len)
> +{
> +	int ret;
> +	u8 send[PAC193X_MAX_REGISTER_LENGTH + 1];
> +	struct i2c_msg msg = {
> +		.addr = client->addr,
> +		.len = len + 1,
> +		.flags = 0
> +	};
> +
> +	send[0] = reg_addr;
> +	memcpy(&send[1], data, len * sizeof(u8));
> +	msg.buf = send;
> +
> +	ret = i2c_transfer(client->adapter, &msg, 1);

i2c_master_send()

> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"failed writing data from register 0x%02X\n", reg_addr);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pac193x_match_samp_rate(struct pac193x_chip_info *chip_info, u32 new_samp_rate)
> +{
> +	int cnt;
> +
> +	for (cnt = 0; cnt < ARRAY_SIZE(samp_rate_map_tbl); cnt++) {
> +		if (new_samp_rate == samp_rate_map_tbl[cnt]) {
> +			chip_info->crt_samp_spd_bitfield = cnt;
> +			break;
			return 0;
> +		}
> +	}

return -EINVAL;

> +
> +	if (cnt == ARRAY_SIZE(samp_rate_map_tbl))
> +		/* not a valid sample rate value */
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static ssize_t shunt_value_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac193x_chip_info *chip_info = iio_priv(indio_dev);
> +	int len = 0;
> +	int target = (int)(attr->attr.name[strlen(attr->attr.name) - 1] - '0') - 1;
> +
> +	len += sprintf(buf, "%u\n", chip_info->shunts[target]);
> +
> +	return len;
> +}
> +
> +static ssize_t channel_name_show(struct device *dev,

Looks like per channel label support provided by the read_label iio_info callback.

> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac193x_chip_info *chip_info = iio_priv(indio_dev);
> +	int len = 0;
> +	int target = (int)(attr->attr.name[strlen(attr->attr.name) - 1] - '0') - 1;
> +
> +	len += sprintf(buf, "%s\n", chip_info->channel_names[target]);
> +
> +	return len;
> +}
> +
> +static ssize_t shunt_value_store(struct device *dev,

Shunt values aren't normally dynamic.  Why do you need to write it from
userspace? I'd expect that to come from firmware.

If it's needed the ext_info framework might be a better fit than
direct implementation of the attribute.

> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac193x_chip_info *chip_info = iio_priv(indio_dev);
> +	int sh_val, target;
> +
> +	target = (int)(attr->attr.name[strlen(attr->attr.name) - 1] - '0') - 1;
> +	if (kstrtouint(buf, 10, &sh_val)) {
> +		dev_err(dev, "Shunt value is not valid\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&chip_info->lock);
> +	chip_info->shunts[target] = sh_val;
> +	mutex_unlock(&chip_info->lock);
> +
> +	return count;
> +}
> +

...

> +static int pac193x_send_refresh(struct pac193x_chip_info *chip_info,
> +				bool refresh_v, u32 wait_time)
> +{
> +	/* this function only sends REFRESH or REFRESH_V */
> +	struct i2c_client *client = chip_info->client;
> +	int ret;
> +	u8 refresh_cmd, bidir_reg;
> +	bool revision_bug = false;
> +
> +	if (chip_info->chip_revision == 2 || chip_info->chip_revision == 3) {
> +		/*
> +		 *chip rev 2 and 3 bug workaround

space after *

> +		 * see: PAC193X Family Data Sheet Errata DS80000836A.pdf
> +		 */
> +		revision_bug = true;
> +
> +		bidir_reg = PAC193X_NEG_PWR_CH1_BIDI(chip_info->bi_dir[PAC193X_CH_1]) |
> +			PAC193X_NEG_PWR_CH2_BIDI(chip_info->bi_dir[PAC193X_CH_2]) |
> +			PAC193X_NEG_PWR_CH3_BIDI(chip_info->bi_dir[PAC193X_CH_3]) |
> +			PAC193X_NEG_PWR_CH4_BIDI(chip_info->bi_dir[PAC193X_CH_4]) |
> +			PAC193X_NEG_PWR_CH1_BIDV(chip_info->bi_dir[PAC193X_CH_1]) |
> +			PAC193X_NEG_PWR_CH2_BIDV(chip_info->bi_dir[PAC193X_CH_2]) |
> +			PAC193X_NEG_PWR_CH3_BIDV(chip_info->bi_dir[PAC193X_CH_3]) |
> +			PAC193X_NEG_PWR_CH4_BIDV(chip_info->bi_dir[PAC193X_CH_4]);
> +
> +		/* write the updated registers back */
> +		ret = pac193x_i2c_write_byte(client,
> +					     PAC193X_CTRL_STAT_REGS_ADDR +
> +					     PAC193X_NEG_PWR_REG_OFF,
> +					     bidir_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * if refresh_v is not false, send REFRESH_V instead of REFRESH
> +	 * (doesn't reset the accumulators)
> +	 */
> +	if (refresh_v)
> +		refresh_cmd = PAC193X_REFRESH_V_REG;
> +	else
> +		refresh_cmd = PAC193X_REFRESH_REG;
> +
> +	ret = pac193x_i2c_send_byte(client, refresh_cmd);
> +	if (ret) {
> +		dev_err(&client->dev, "%s - cannot send 0x%02X\n",
> +			__func__, refresh_cmd);
> +		return ret;
> +	}
> +
> +	if (revision_bug) {
> +		/*
> +		 * chip rev 2 and 3 bug workaround - write again the same register
> +		 * write the updated registers back
> +		 */
> +		ret = pac193x_i2c_write_byte(client,
> +					     PAC193X_CTRL_STAT_REGS_ADDR +
> +					     PAC193X_NEG_PWR_REG_OFF, bidir_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* register data retrieval timestamp */
> +	chip_info->jiffies_tstamp = jiffies;
> +
> +	/* wait till the data is available */
> +	usleep_range(wait_time, wait_time + 100);
> +
> +	return ret;
> +}
> +


...

> +
> +/**
> + * pac193x_read_raw() - data read function.
> + * @indio_dev: the struct iio_dev associated with this device instance
> + * @chan: the channel whose data is to be read
> + * @val: first element of returned value (typically INT)
> + * @val2: second element of returned value (typically MICRO)
> + * @mask: what we actually want to read as per the info_mask_* in iio_chan_spec.

As below. This doc doesn't add a huge amount as it's documenting IIO rather than
this function.

> + */
> +static int pac193x_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct pac193x_chip_info *chip_info = iio_priv(indio_dev);
> +	s64 curr_energy, int_part;
> +	int rem, ret, channel = chan->channel - 1;
> +
> +	ret = pac193x_retrieve_data(chip_info, PAC193X_MIN_UPDATE_WAIT_TIME_MS);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (chan->address) {
> +			case PAC193X_VBUS_1_ADDR:
> +			case PAC193X_VBUS_2_ADDR:
> +			case PAC193X_VBUS_3_ADDR:
> +			case PAC193X_VBUS_4_ADDR:
> +				*val = chip_info->chip_reg_data.vbus[channel];
> +				return IIO_VAL_INT;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		case IIO_CURRENT:
> +			switch (chan->address) {
> +			case PAC193X_VSENSE_1_ADDR:
> +			case PAC193X_VSENSE_2_ADDR:
> +			case PAC193X_VSENSE_3_ADDR:
> +			case PAC193X_VSENSE_4_ADDR:
> +				*val = chip_info->chip_reg_data.vsense[channel];
> +				return IIO_VAL_INT;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		case IIO_POWER:
> +			switch (chan->address) {
> +			case PAC193X_VPOWER_1_ADDR:
> +			case PAC193X_VPOWER_2_ADDR:
> +			case PAC193X_VPOWER_3_ADDR:
> +			case PAC193X_VPOWER_4_ADDR:
> +				*val = chip_info->chip_reg_data.vpower[channel];
> +				return IIO_VAL_INT;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		case IIO_ENERGY:
> +			switch (chan->address) {
> +			case PAC193X_VPOWER_ACC_1_ADDR:
> +			case PAC193X_VPOWER_ACC_2_ADDR:
> +			case PAC193X_VPOWER_ACC_3_ADDR:
> +			case PAC193X_VPOWER_ACC_4_ADDR:
> +				/*
> +				 * expresses the 64 bit energy value as a 32 bit integer part and
> +				 * 32 bits (representing 8 digits) fractional value

I'm lost.  So it's a 64 bit value?
We have IIO_VAL_INT_64. Does that not work here?

> +				 */
> +				curr_energy = chip_info->chip_reg_data.energy_sec_acc[channel];
> +				int_part = div_s64_rem(curr_energy, 100000000, &rem);
> +
> +				/* rescale reminder to be printed as "nano" value */
> +				rem = rem * 10;
> +
> +				*val = int_part;
> +				*val2 = rem;
> +				return IIO_VAL_INT_PLUS_NANO;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_AVERAGE_RAW:

I'd forgotten we had this ABI and had to look up the docs.   Hmm. It's a bit clunky but I guess
still useful in this case.  Longer term we should think about how to describe that and how it
is different from oversampling. The problem with oversampling is it affects the main channel
so we can't easily associate both an averaged value  and a raw one like you have here.

Given lots of other changes requested and early in this kernel cycle, perhaps it will make sense to revisit
this question at a later version of this patch (or maybe just leave it alone as too hard
to do better!)

> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (chan->address) {
> +			case PAC193X_VBUS_AVG_1_ADDR:
> +			case PAC193X_VBUS_AVG_2_ADDR:
> +			case PAC193X_VBUS_AVG_3_ADDR:
> +			case PAC193X_VBUS_AVG_4_ADDR:
> +				*val = chip_info->chip_reg_data.vbus_avg[channel];
> +				return IIO_VAL_INT;
> +
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		case IIO_CURRENT:
> +			switch (chan->address) {
> +			case PAC193X_VSENSE_AVG_1_ADDR:
> +			case PAC193X_VSENSE_AVG_2_ADDR:
> +			case PAC193X_VSENSE_AVG_3_ADDR:
> +			case PAC193X_VSENSE_AVG_4_ADDR:
> +				*val = chip_info->chip_reg_data.vsense_avg[channel];
> +				return IIO_VAL_INT;
> +
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->address) {
> +		/* Voltages - scale for millivolts */
> +		case PAC193X_VBUS_1_ADDR:
> +		case PAC193X_VBUS_2_ADDR:
> +		case PAC193X_VBUS_3_ADDR:
> +		case PAC193X_VBUS_4_ADDR:
> +		case PAC193X_VBUS_AVG_1_ADDR:
> +		case PAC193X_VBUS_AVG_2_ADDR:
> +		case PAC193X_VBUS_AVG_3_ADDR:
> +		case PAC193X_VBUS_AVG_4_ADDR:
> +			*val = PAC193X_VOLTAGE_MILLIVOLTS_MAX;
> +			if (chan->scan_type.sign == 'u')
> +				*val2 = PAC193X_VOLTAGE_U_RES;
> +			else
> +				*val2 = PAC193X_VOLTAGE_S_RES;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +
> +		/*
> +		 * Currents - scale for mA - depends on the
> +		 * channel's shunt value
> +		 * (100mV * 1000000) / (2^16 * shunt(uohm))
> +		 */
> +		case PAC193X_VSENSE_1_ADDR:
> +		case PAC193X_VSENSE_2_ADDR:
> +		case PAC193X_VSENSE_3_ADDR:
> +		case PAC193X_VSENSE_4_ADDR:
> +		case PAC193X_VSENSE_AVG_1_ADDR:
> +		case PAC193X_VSENSE_AVG_2_ADDR:
> +		case PAC193X_VSENSE_AVG_3_ADDR:
> +		case PAC193X_VSENSE_AVG_4_ADDR:
> +			*val = PAC193X_MAX_VSENSE_RSHIFTED_BY_16B;
> +			if (chan->scan_type.sign == 'u')
> +				*val2 = chip_info->shunts[channel];
> +			else
> +				*val2 = chip_info->shunts[channel] >> 1;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		/*
> +		 * Power - mW - it will use the combined scale
> +		 * for current and voltage
> +		 * current(mA) * voltage(mV) = power (uW)
> +		 */
> +		case PAC193X_VPOWER_1_ADDR:
> +		case PAC193X_VPOWER_2_ADDR:
> +		case PAC193X_VPOWER_3_ADDR:
> +		case PAC193X_VPOWER_4_ADDR:
> +			*val = PAC193X_MAX_VPOWER_RSHIFTED_BY_28B;
> +			if (chan->scan_type.sign == 'u')
> +				*val2 = chip_info->shunts[channel];
> +			else
> +				*val2 = chip_info->shunts[channel] >> 1;
> +			return IIO_VAL_FRACTIONAL;
> +		case PAC193X_VPOWER_ACC_1_ADDR:
> +		case PAC193X_VPOWER_ACC_2_ADDR:
> +		case PAC193X_VPOWER_ACC_3_ADDR:
> +		case PAC193X_VPOWER_ACC_4_ADDR:
> +
> +			/*
> +			 * expresses the 32 bit scale value
> +			 * here compute the scale for energy (Watt-second or Joule)
> +			 */
> +			*val = PAC193X_SCALE_CONSTANT;
> +
> +			if (chan->scan_type.sign == 'u')
> +				*val2 = chip_info->shunts[channel];
> +			else
> +				*val2 = chip_info->shunts[channel] >> 1;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = chip_info->sample_rate_value;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * pac193x_write_raw() - data write function.
> + * @indio_dev:	the struct iio_dev associated with this device instance
> + * @chan:	the channel whose data is to be written
> + * @val:	first element of value to set (typically INT)
> + * @val2:	second element of value to set (typically MICRO)
> + * @mask:	what we actually want to write as per the info_mask_* in iio_chan_spec.
> + *
> + * Note that all raw writes are assumed IIO_VAL_INT and info mask elements
> + * are assumed to be IIO_INT_PLUS_MICRO unless the callback write_raw_get_fmt
> + * in struct iio_info is provided by the driver.

These docs are more of IIO callbacks in general than this particular function.
Not sure it's helpful to have them here.

> + */
> +static int pac193x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct pac193x_chip_info *chip_info = iio_priv(indio_dev);
> +	struct i2c_client *client = chip_info->client;
> +	int ret = -EINVAL;
> +	s32 old_samp_rate;
> +	u8 ctrl_reg;
> +
> +	if (iio_buffer_enabled(indio_dev))
If you need to not do it whilst the buffer is enabled
then you want iio_device_claim_direct_mode() and the release to ensure
that you don't have a race against buffer being enabled.

However you don't support buffered mode so far. Hence what is this really here for?


> +		return -EBUSY;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = pac193x_match_samp_rate(chip_info, (u16)val);
> +		if (ret)
> +			return ret;
> +
> +		/* store the old sampling rate */

Given you have a good variable name the comment doesn't add anything.

> +		old_samp_rate = chip_info->sample_rate_value;
> +
> +		/* we have a valid sample rate */
> +		chip_info->sample_rate_value = val;
> +
> +		/*
> +		 * now lock the access to the chip, write the new
> +		 * sampling value and trigger a snapshot(incl refresh)
> +		 */
> +		mutex_lock(&chip_info->lock);
> +
> +		/* enable ALERT pin */
Where is this wired to?
> +		ctrl_reg = PAC193X_CRTL_SAMPLE_RATE_SET(chip_info->crt_samp_spd_bitfield) |
> +			PAC193X_CHAN_ALERT_EN;
> +		ret = pac193x_i2c_write_byte(client, PAC193X_CTRL_REG, ctrl_reg);
> +		if (ret) {
> +			dev_err(&client->dev, "%s - can't update sample rate\n", __func__);
> +			chip_info->sample_rate_value = old_samp_rate;
> +			mutex_unlock(&chip_info->lock);

Fun thing about i2c bus write failures. You have no idea what failed. The value might be
the old value or the new one after the failed write... So normally we don't bother too much if our values are
out of sync. and that leads to easier unwinding.  However, if you want to keep this as it
is then that's fine.

> +			return ret;
> +		}
> +
> +		/*
> +		 * unlock the access towards the chip - register
> +		 * snapshot includes its own access lock
> +		 */
> +		mutex_unlock(&chip_info->lock);
> +
> +		/*
> +		 * now, force a snapshot with refresh - call retrieve
> +		 * data in order to update the refresh timer
> +		 * alter the timestamp in order to force trigger a
> +		 * register snapshot and a timestamp update
> +		 */
> +		chip_info->jiffies_tstamp -=
> +			msecs_to_jiffies(PAC193X_MIN_POLLING_TIME_MS);
> +		ret = pac193x_retrieve_data(chip_info, (1024 / old_samp_rate) * 1000);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"%s - cannot snapshot ctrl and measurement regs\n",
> +				__func__);
> +			return ret;
> +		}
> +
> +		ret = 0;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void pac193x_work_periodic_rfsh(struct work_struct *work)
> +{
> +	struct pac193x_chip_info *chip_info = to_pac193x_chip_info(work);
> +
> +	/* do a REFRESH, then read */
> +	pac193x_reg_snapshot(chip_info, true, false, PAC193X_MIN_UPDATE_WAIT_TIME_MS);
> +}
> +
> +static void pac193x_read_reg_timeout(struct timer_list *t)
> +{
> +	struct pac193x_chip_info *chip_info = from_timer(chip_info, t, tmr_forced_update);
> +
> +	mod_timer(&chip_info->tmr_forced_update,
> +		  jiffies + msecs_to_jiffies(PAC193X_MAX_RFSH_LIMIT_MS));
> +
> +	/* schedule the periodic reading from the chip */
> +	queue_work(chip_info->wq_chip, &chip_info->work_chip_rfsh);

Why not queue_delayed_work()?

> +}
> +
> +static int pac193x_read_revision(struct pac193x_chip_info *chip_info, u8 *buf)
> +{
> +	int ret;
> +	struct i2c_client *client = chip_info->client;
> +
> +	/*
> +	 * try to identify the chip variant

why try?  Is there a reason (other than hardware failure) that this might not work?

> +	 * read the chip ID values
> +	 */
> +	ret = pac193x_i2c_read(client, PAC193X_PID_REG_ADDR, buf, PAC193X_ID_REG_LEN);
> +	if (ret) {
> +		dev_err(&client->dev, "cannot read revision\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pac193x_chip_identify(struct pac193x_chip_info *chip_info)
> +{
> +	int ret;
> +	struct i2c_client *client = chip_info->client;
> +	u8 rev_info[PAC193X_ID_REG_LEN];
> +
> +	ret = pac193x_read_revision(chip_info, (u8 *)rev_info);
> +
Trivial: Drop blank line here. Keeps the error block next to the call and clearly
associated with it.
> +	if (ret) {
> +		dev_err(&client->dev, "cannot read revision\n");
> +		return ret;
> +	}
> +
> +	if (rev_info[PAC193X_PID_IDX] != pac193x_chip_config[chip_info->chip_variant].prod_id) {
> +		dev_err(&client->dev,
> +			"chip's product ID doesn't match the exact one for this part\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&client->dev, "Chip revision: 0x%02X\n", rev_info[PAC193X_RID_IDX]);
> +	chip_info->chip_revision = rev_info[PAC193X_RID_IDX];
> +
> +	return 0;
> +}
> +
> +static int pac193x_get_variant(struct pac193x_chip_info *chip_info)
> +{
> +	u8 rev_info[PAC193X_ID_REG_LEN];
> +	int ret;
> +
> +	ret = pac193x_read_revision(chip_info, (u8 *)rev_info);
> +

As above, no blank line here preferred.

Though in this case
	if (ret)
		return 0; 
probably better, though that wants a comment on why a return of 0 is
not an error.

> +	if (!ret) {
> +		chip_info->chip_variant = rev_info[PAC193X_PID_IDX];
> +		chip_info->chip_revision = rev_info[PAC193X_RID_IDX];
> +		switch (chip_info->chip_variant) {
> +		case PAC1934_PID:
You have an array of structures containing pids and number of channels. Better to search
that for these than end up with this duplication.

> +			chip_info->phys_channels = PAC1934_NUM_CHANNELS;
> +			break;
> +		case PAC1933_PID:
> +			chip_info->phys_channels = PAC1933_NUM_CHANNELS;
> +			break;
> +		case PAC1932_PID:
> +			chip_info->phys_channels = PAC1932_NUM_CHANNELS;
> +			break;
> +		case PAC1931_PID:
> +			chip_info->phys_channels = PAC1931_NUM_CHANNELS;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int pac193x_setup_periodic_refresh(struct pac193x_chip_info *chip_info)
> +{
> +	chip_info->wq_chip = create_workqueue("wq_pac193x");

Add add a comment on why this needs it's own work queue rather than using
a system one.

here I'd expect a devm_add_action_or_reset() to flush and free the queue.

> +	INIT_WORK(&chip_info->work_chip_rfsh, pac193x_work_periodic_rfsh);
> +
> +	/* setup the latest moment for reading the regs before saturation */
> +	timer_setup(&chip_info->tmr_forced_update, pac193x_read_reg_timeout, 0);

And another devm_callback here to deal with the timer callback.
> +
> +	/* register the timer */
> +	mod_timer(&chip_info->tmr_forced_update,
> +		  jiffies + msecs_to_jiffies(PAC193X_MAX_RFSH_LIMIT_MS));
> +
> +	return 0;
> +}
> +
> +static union acpi_object *pac193x_acpi_eval_function(acpi_handle handle,
> +						     int revision,
> +						     int function)
> +{
> +	acpi_status status;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	union acpi_object args[PAC193X_ACPI_ARG_COUNT];
> +	struct acpi_object_list args_list;
> +	uuid_t uuid;
> +
> +	uuid_parse(PAC193X_DSM_UUID, &uuid);
> +
> +	args[0].type = ACPI_TYPE_BUFFER;
> +	args[0].buffer.length = sizeof(struct pac193x_uuid_format);
> +	args[0].buffer.pointer = (u8 *)&uuid;
> +
> +	args[1].type = ACPI_TYPE_INTEGER;
> +	args[1].integer.value = revision;
> +
> +	args[2].type = ACPI_TYPE_INTEGER;
> +	args[2].integer.value = function;
> +
> +	args[3].type = ACPI_TYPE_PACKAGE;
> +	args[3].package.count = 0;
> +
> +	args_list.count = PAC193X_ACPI_ARG_COUNT;
> +	args_list.pointer = &args[0];
> +
> +	status = acpi_evaluate_object(handle, "_DSM", &args_list, &buffer);
> +
> +	if (ACPI_FAILURE(status)) {
> +		kfree(buffer.pointer);
> +		return NULL;
> +	}
> +
> +	return buffer.pointer;
> +}
> +
> +static char *pac193x_acpi_get_acpi_match_entry(acpi_handle handle)
> +{
> +	acpi_status status;
> +	union acpi_object *name_object;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +
> +	status = acpi_evaluate_object(handle, "_HID", NULL, &buffer);
> +	name_object = buffer.pointer;
> +
> +	return name_object->string.pointer;
> +}
> +
> +static const char *pac193x_match_acpi_device(struct i2c_client *client,
> +					     struct pac193x_chip_info *chip_info)
> +{
> +	char *name;
> +	acpi_handle handle;
> +	union acpi_object *rez;
> +	unsigned short bi_dir_mask;
> +	int idx, i;
> +

Any docs for the ACPI stuff?
It looks plausible, but an example DSDT blob would make it easier to review.

> +	handle = ACPI_HANDLE(&client->dev);
> +	name = pac193x_acpi_get_acpi_match_entry(handle);

Having to do this again is a bit nasty.  The tricky corner is you might get
here either by match against the ACPI match table or via a PRP0001 path.

You could use acpi_match_device_ids(acpi_companion(&client->dev)... )
to distinguish which case you have without rolling your own _HID read routine.


> +	if (!name)
> +		return NULL;
> +
> +	rez = pac193x_acpi_eval_function(handle, 0, PAC193X_ACPI_GET_NAMES_AND_MOHMS_VALS);
> +
> +	if (!rez)
> +		return NULL;
> +
> +	for (i = 0; i < rez->package.count; i += 2) {
> +		idx = i / 2;
> +		chip_info->channel_names[idx] =
> +			devm_kmemdup(&client->dev, rez->package.elements[i].string.pointer,
> +				     (size_t)rez->package.elements[i].string.length + 1,
> +				     GFP_KERNEL);
> +		chip_info->channel_names[idx][rez->package.elements[i].string.length] = '\0';
> +		chip_info->shunts[idx] =
> +			rez->package.elements[i + 1].integer.value * 1000;
> +		chip_info->active_channels[idx] = (chip_info->shunts[idx] != 0);
> +	}
> +
> +	kfree(rez);
> +
> +	rez = pac193x_acpi_eval_function(handle, 1, PAC193X_ACPI_GET_UOHMS_VALS);
> +	if (!rez) {
> +		/*
> +		 * initialising with default values
> +		 * we assume all channels are unidectional(the mask is zero)
> +		 * and assign the default sampling rate
> +		 */
> +		chip_info->sample_rate_value = PAC193X_DEFAULT_CHIP_SAMP_SPEED;
> +		return name;
> +	}
> +
> +	for (i = 0; i < rez->package.count; i++) {
> +		idx = i;
> +		chip_info->shunts[idx] = rez->package.elements[i].integer.value;
> +		chip_info->active_channels[idx] = (chip_info->shunts[idx] != 0);
> +	}
> +
> +	kfree(rez);
> +
> +	rez = pac193x_acpi_eval_function(handle, 1, PAC193X_ACPI_GET_BIPOLAR_SETTINGS);
> +	if (!rez)
> +		return NULL;
> +	bi_dir_mask = rez->package.elements[0].integer.value;
> +	chip_info->bi_dir[0] = (bi_dir_mask & (1 << 0)) << 0;
> +	chip_info->bi_dir[0] = (bi_dir_mask & (1 << 1)) << 1;
> +	chip_info->bi_dir[0] = (bi_dir_mask & (1 << 2)) << 2;
> +	chip_info->bi_dir[0] = (bi_dir_mask & (1 << 3)) << 3;
> +	kfree(rez);
> +
> +	rez = pac193x_acpi_eval_function(handle, 1, PAC193X_ACPI_GET_SAMP);
> +	if (!rez)
> +		return NULL;
> +
> +	chip_info->sample_rate_value = rez->package.elements[0].integer.value;
> +	kfree(rez);
> +
> +	return name;
> +}
> +
> +static const struct of_device_id pac193x_of_match[] = {
> +	{ .compatible = "microchip,pac1934",
> +	  .data = (void *)&pac193x_chip_config[pac1934]

Shouldn't need that cast as any const pointer should cast implicitly
to a const void * which is what data is.

Also prefer
	{
		.compatible...
	},
	{

> +	},
> +	{ .compatible = "microchip,pac1933",
> +	  .data = (void *)&pac193x_chip_config[pac1933]
> +	},
> +	{ .compatible = "microchip,pac1932",
> +	  .data = (void *)&pac193x_chip_config[pac1932]
> +	},
> +	{ .compatible = "microchip,pac1931",
> +	  .data = (void *)&pac193x_chip_config[pac1931]
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pac193x_of_match);
After other suggested changes you should be able to move this down
next to the driver structure which is a  more conventional place to find these
tables.

> +
> +static int pac193x_match_of_device(struct i2c_client *client,
> +				   struct pac193x_chip_info *chip_info)
> +{
> +	struct device_node *node;
> +	unsigned int current_channel;
> +	int idx, ret;

Use generic property accessors linux/property.h for all these.

> +
> +	ret = of_property_read_u32(client->dev.of_node, "microchip,samp-rate",
> +				   &chip_info->sample_rate_value);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"Cannot read sample rate value ...%d\n", ret);
only called from probe, so dev_err_probe better.

> +		goto err_of_node_put;

put the node in the caller not in here as this function didn't get it.

> +	}
> +
> +	ret = pac193x_match_samp_rate(chip_info, chip_info->sample_rate_value);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"The given sample rate value is not supported: %d\n",
> +			chip_info->sample_rate_value);
> +		goto err_of_node_put;
> +	}
> +
> +	current_channel = 1;
> +	for_each_child_of_node(client->dev.of_node, node) {
> +		ret = of_property_read_u32(node, "reg", &idx);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"invalid channel_index, error: %d\n",
> +				ret);
> +			goto err_of_node_put;
> +		}
> +		/* adjust idx to match channel index (1 to 4) from the datasheet */
> +		idx--;
> +		if (current_channel >= (chip_info->phys_channels + 1) ||
> +		    idx >= chip_info->phys_channels || idx < 0) {
> +			dev_err(&client->dev,
> +				"invalid channel_index %d value on %s\n",
> +				(idx + 1), node->full_name);
> +			goto err_of_node_put;
> +		}
> +
> +		/* enable channel */
> +		chip_info->active_channels[idx] = true;
> +
> +		ret = of_property_read_u32(node, "microchip,uohms-shunt-res",
> +					   &chip_info->shunts[idx]);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"%s: invalid shunt-resistor value: %d\n",
> +				node->full_name, ret);
> +			goto err_of_node_put;
> +		}
> +
> +		ret = of_property_read_string(node, "microchip,rail-name",
> +					      (const char **)&chip_info->channel_names[idx]);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"%s: invalid rail-name value: %d\n",
> +				node->full_name, ret);
> +			goto err_of_node_put;
> +		}
> +
> +		chip_info->bi_dir[idx] =
> +			of_property_read_bool(node, "microchip,bi-directional");
> +
> +		current_channel++;
> +	}
> +
> +	return 0;
> +
> +err_of_node_put:
> +	of_node_put(node);
> +	return ret;
> +}
> +
> +static int pac193x_chip_configure(struct pac193x_chip_info *chip_info)
> +{
> +	int cnt, ret;
> +	struct i2c_client *client = chip_info->client;
> +	u8 regs[PAC193X_CTRL_STATUS_INFO_LEN], idx, ctrl_reg;
> +	u32 wait_time;
> +
> +	/*
> +	 * count how many channels are enabled and store
> +	 * this information within the driver data
> +	 */
> +	cnt = 0;
> +	chip_info->chip_reg_data.num_enabled_channels = 0;
> +	while (cnt < chip_info->phys_channels) {
> +		if (chip_info->active_channels[cnt])
> +			chip_info->chip_reg_data.num_enabled_channels++;
> +		cnt++;
> +	}
> +
> +	/*
> +	 * read whatever information was gathered before the driver was loaded
> +	 * establish which channels are enabled/disabled and then establish the
> +	 * information retrieval mode (using SKIP or no).

It's unusual to have a driver carry on with existing values.  Much more common
to either have it reset the device (to known default state) or write all the
registers if such a reset doesn't exist.

One reason for that flow is that we really don't trust other software :)
Another is that often we don't know if the device had any power until we turned it
on.  So it's much easier to review code where we control all the state.

If there is a strong reason for carrying on with existing settings please add
comments here and something to the patch description to point out this unusual
behaviour. 

> +	 * Read the chip ID values
> +	 */
> +	ret = pac193x_i2c_read(client, PAC193X_CTRL_STAT_REGS_ADDR,
> +			       (u8 *)regs, PAC193X_CTRL_STATUS_INFO_LEN);

sizeof(regs)
so a reviewer doesn't need to go check there is space.

> +	if (ret) {
> +		dev_err(&client->dev,
> +			"%s - cannot read regs from 0x%02X\n",
> +			__func__, PAC193X_CTRL_STAT_REGS_ADDR);

As this is only called from probe, you can use dev_err_probe() for simpler code
in here.

> +		return ret;
> +	}
> +
> +	/* write the CHANNEL_DIS and the NEG_PWR registers */
> +	regs[PAC193X_CHANNEL_DIS_REG_OFF] =
> +		PAC193X_CHAN_DIS_CH1_OFF(chip_info->active_channels[PAC193X_CH_1]) |
> +		PAC193X_CHAN_DIS_CH2_OFF(chip_info->active_channels[PAC193X_CH_2]) |
> +		PAC193X_CHAN_DIS_CH3_OFF(chip_info->active_channels[PAC193X_CH_3]) |
> +		PAC193X_CHAN_DIS_CH4_OFF(chip_info->active_channels[PAC193X_CH_4]) |
> +		PAC193X_SMBUS_TIMEOUT_EN(0) |
> +		PAC193X_SMBUS_BYTECOUNT_EN(0) |
> +		PAC193X_SMBUS_NO_SKIP_EN(0);
> +
> +	regs[PAC193X_NEG_PWR_REG_OFF] =
> +		PAC193X_NEG_PWR_CH1_BIDI(chip_info->bi_dir[PAC193X_CH_1]) |
> +		PAC193X_NEG_PWR_CH2_BIDI(chip_info->bi_dir[PAC193X_CH_2]) |
> +		PAC193X_NEG_PWR_CH3_BIDI(chip_info->bi_dir[PAC193X_CH_3]) |
> +		PAC193X_NEG_PWR_CH4_BIDI(chip_info->bi_dir[PAC193X_CH_4]) |
> +		PAC193X_NEG_PWR_CH1_BIDV(chip_info->bi_dir[PAC193X_CH_1]) |
> +		PAC193X_NEG_PWR_CH2_BIDV(chip_info->bi_dir[PAC193X_CH_2]) |
> +		PAC193X_NEG_PWR_CH3_BIDV(chip_info->bi_dir[PAC193X_CH_3]) |
> +		PAC193X_NEG_PWR_CH4_BIDV(chip_info->bi_dir[PAC193X_CH_4]);
> +
> +	/*
> +	 * the current can be measured uni or bi-dir, but voltages are set only
> +	 * for uni-directional operation
> +	 * no SLOW triggered REFRESH, clear POR
> +	 */
> +	regs[PAC193X_SLOW_REG_OFF] = 0;
> +
> +	/* write the updated registers back */
> +	ret = pac193x_i2c_write(client, PAC193X_CTRL_STAT_REGS_ADDR, (u8 *)regs, 3);
> +	if (ret)
> +		return ret;
> +
> +	/* enable the ALERT pin functionality */

Where is the alert pin wired to?  I'd expect to see an interrupt and for this
to be optional as people have a habit of not writing interrupt lines up (sigh)

> +	ctrl_reg = PAC193X_CRTL_SAMPLE_RATE_SET(chip_info->crt_samp_spd_bitfield) |
> +		PAC193X_CHAN_ALERT_EN;
> +	ret = pac193x_i2c_write_byte(client, PAC193X_CTRL_REG, ctrl_reg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * send a REFRESH to the chip, so the new settings take place
> +	 * as well as resetting the accumulators
> +	 */
> +	ret = pac193x_i2c_send_byte(client, PAC193X_REFRESH_REG);

Naming of write_byte vs send_byte is a bit confusing.
Perhaps call one write_reg()?

> +	if (ret) {
> +		dev_err(&client->dev,
> +			"%s - cannot send 0x%02X\n",
> +			__func__, PAC193X_REFRESH_REG);
> +		return ret;
> +	}
> +
> +	/*
> +	 * get the current(in the chip) sampling speed and compute the
> +	 * required timeout based on its value
> +	 * the timeout is 1/sampling_speed
> +	 */
> +	idx = regs[PAC193X_CTRL_ACT_REG_OFF] >> PAC193X_SAMPLE_RATE_SHIFT;
> +	wait_time = (1024 / samp_rate_map_tbl[idx]) * 1000;
> +
> +	/*
> +	 * wait the maximum amount of time to be on the safe side - the
> +	 * maximum wait time is for 8sps
> +	 */
> +	usleep_range(wait_time, wait_time + 100);
> +
> +	/* setup the refresh timeout */
As below, some of these comments are obvious, so drop them. Others
are much more useful of course and want to be kept.
> +	ret = pac193x_setup_periodic_refresh(chip_info);

return pac193x...

> +
> +	return ret;
> +}
> +
> +static int pac193x_prep_iio_channels(struct pac193x_chip_info *chip_info, struct iio_dev *indio_dev)
> +{
> +	struct i2c_client *client;
> +	struct iio_chan_spec *ch_sp;
> +	int channel_size, channel_attribute_count, attribute_count, cnt;
> +	void *dyn_ch_struct, *tmp_data;
> +
> +	client = chip_info->client;
> +
> +	/* find out dynamically how many IIO channels we need */
> +	channel_attribute_count = 0;
> +	channel_size = 0;
> +	for (cnt = 0; cnt < chip_info->phys_channels; cnt++) {
> +		if (chip_info->active_channels[cnt]) {
> +			/* add the size of the properties of one chip physical channel */
> +			channel_size += sizeof(pac193x_single_channel);
> +			/* count how many enabled channels we have */
> +			channel_attribute_count += ARRAY_SIZE(pac193x_single_channel);
> +			dev_info(&client->dev, ":%s: Channel %d active\n", __func__, cnt + 1);
> +		}
> +	}
> +
> +	/* now add the timestamp channel size */
> +	channel_size += sizeof(pac193x_ts);
> +
> +	/* add one more channel which is the timestamp */
> +	attribute_count = channel_attribute_count + 1;
> +
> +	dyn_ch_struct = kzalloc(channel_size, GFP_KERNEL);
> +	if (!dyn_ch_struct)
> +		return -EINVAL;
> +
> +	tmp_data = dyn_ch_struct;
> +
> +	/* populate the dynamic channels and make all the adjustments */
> +	for (cnt = 0; cnt < chip_info->phys_channels; cnt++) {
> +		if (chip_info->active_channels[cnt]) {
> +			memcpy(tmp_data, pac193x_single_channel, sizeof(pac193x_single_channel));
> +			ch_sp = (struct iio_chan_spec *)tmp_data;
> +			ch_sp[IIO_EN].channel = cnt  + 1;
> +			ch_sp[IIO_EN].scan_index = cnt;
> +			ch_sp[IIO_EN].address = cnt + PAC193X_VPOWER_ACC_1_ADDR;
> +			ch_sp[IIO_POW].channel = cnt  + 1;
> +			ch_sp[IIO_POW].scan_index = cnt;
> +			ch_sp[IIO_POW].address = cnt + PAC193X_VPOWER_1_ADDR;
> +			ch_sp[IIO_VOLT].channel = cnt  + 1;
> +			ch_sp[IIO_VOLT].scan_index = cnt;
> +			ch_sp[IIO_VOLT].address = cnt + PAC193X_VBUS_1_ADDR;
> +			ch_sp[IIO_CRT].channel = cnt  + 1;
> +			ch_sp[IIO_CRT].scan_index = cnt;
> +			ch_sp[IIO_CRT].address = cnt + PAC193X_VSENSE_1_ADDR;
> +			ch_sp[IIO_VOLTAVG].channel = cnt  + 1;
> +			ch_sp[IIO_VOLTAVG].scan_index = cnt;
> +			ch_sp[IIO_VOLTAVG].address = cnt + PAC193X_VBUS_AVG_1_ADDR;
> +			ch_sp[IIO_CRTAVG].channel = cnt  + 1;
> +			ch_sp[IIO_CRTAVG].scan_index = cnt;
> +			ch_sp[IIO_CRTAVG].address = cnt + PAC193X_VSENSE_AVG_1_ADDR;
> +
> +			/*
> +			 * now modify the parameters in all channels if the
> +			 * whole chip rail(channel) is bi-directional
> +			 */
> +			if (chip_info->bi_dir[cnt]) {
> +				ch_sp[IIO_EN].scan_type.sign = 's';
> +				ch_sp[IIO_EN].scan_type.realbits = PAC193X_ENERGY_S_RES;
> +				ch_sp[IIO_POW].scan_type.sign = 's';
> +				ch_sp[IIO_POW].scan_type.realbits = PAC193X_POWER_S_RES;
> +				ch_sp[IIO_VOLT].scan_type.sign = 's';
> +				ch_sp[IIO_VOLT].scan_type.realbits = PAC193X_VOLTAGE_S_RES;
> +				ch_sp[IIO_CRT].scan_type.sign = 's';
> +				ch_sp[IIO_CRT].scan_type.realbits = PAC193X_CURRENT_S_RES;
> +				ch_sp[IIO_VOLTAVG].scan_type.sign = 's';
> +				ch_sp[IIO_VOLTAVG].scan_type.realbits = PAC193X_VOLTAGE_S_RES;
> +				ch_sp[IIO_CRTAVG].scan_type.sign = 's';
> +				ch_sp[IIO_CRTAVG].scan_type.realbits = PAC193X_CURRENT_S_RES;
> +			}
> +			tmp_data += sizeof(pac193x_single_channel);
> +		}
> +	}
> +
> +	/* now copy the timestamp channel */
> +	memcpy(tmp_data, pac193x_ts, sizeof(pac193x_ts));
> +	ch_sp = (struct iio_chan_spec *)tmp_data;
> +	ch_sp[0].scan_index = attribute_count - 1;
> +
> +	/*
> +	 * send the updated dynamic channel structure information towards IIO
> +	 * prepare the required field for IIO class registration
> +	 */
> +	indio_dev->num_channels = attribute_count;
> +	indio_dev->channels = devm_kmemdup(&client->dev,
> +					   (const struct iio_chan_spec *)dyn_ch_struct,
> +					   channel_size, GFP_KERNEL);
> +
> +	kfree(dyn_ch_struct);
> +
> +	if (!indio_dev->channels)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static ssize_t reset_accumulators_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac193x_chip_info *chip_info = iio_priv(indio_dev);
> +	int ret, i;
> +	u8 refresh_cmd = PAC193X_REFRESH_REG;
> +
> +	ret = pac193x_i2c_send_byte(chip_info->client, refresh_cmd);
> +	if (ret) {
> +		dev_err(&indio_dev->dev,
> +			"%s - cannot send 0x%02X\n",
> +			__func__, refresh_cmd);
> +	}
> +
> +	for (i = 0 ; i < chip_info->phys_channels; i++)
> +		chip_info->chip_reg_data.energy_sec_acc[i] = 0;
> +
> +	return count;
> +}
> +
> +static IIO_DEVICE_ATTR(shunt_value_1, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(shunt_value_2, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(shunt_value_3, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(shunt_value_4, 0644, shunt_value_show, shunt_value_store, 0);
> +
> +static IIO_DEVICE_ATTR(channel_name_1, 0444, channel_name_show, NULL, 0);
> +static IIO_DEVICE_ATTR(channel_name_2, 0444, channel_name_show, NULL, 0);
> +static IIO_DEVICE_ATTR(channel_name_3, 0444, channel_name_show, NULL, 0);
> +static IIO_DEVICE_ATTR(channel_name_4, 0444, channel_name_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(reset_accumulators, 0200, NULL, reset_accumulators_store, 0);
> +
> +static struct attribute *pac193x_all_attributes[] = {
> +	PAC193X_DEV_ATTR(shunt_value_1),

These all need ABI documentation so that we can easily review what they do.
Documenation/ABI/testing/sysfs-bus-iio-pac1931
Note that if they overlap with ABI used elsewhere we may need to move it to a more
generic place (there can't be two lots of docs for the same ABI element)

> +	PAC193X_DEV_ATTR(channel_name_1),
> +	PAC193X_DEV_ATTR(shunt_value_2),
> +	PAC193X_DEV_ATTR(channel_name_2),
> +	PAC193X_DEV_ATTR(shunt_value_3),
> +	PAC193X_DEV_ATTR(channel_name_3),
> +	PAC193X_DEV_ATTR(shunt_value_4),
> +	PAC193X_DEV_ATTR(channel_name_4),
> +	PAC193X_DEV_ATTR(reset_accumulators),
> +	NULL
> +};
> +
> +static int pac193x_prep_custom_attributes(struct pac193x_chip_info *chip_info,
> +					  struct iio_dev *indio_dev)
> +{
> +	int i, j, active_channels_count = 0;
> +	struct attribute **pac193x_custom_attributes;
> +	struct attribute_group *pac193x_group;
> +	struct i2c_client *client = chip_info->client;
> +
> +	for (i = 0 ; i < chip_info->phys_channels; i++)
> +		if (chip_info->active_channels[i])
> +			active_channels_count++;
> +
> +	pac193x_group = devm_kzalloc(&client->dev, sizeof(*pac193x_group), GFP_KERNEL);
> +
> +	pac193x_custom_attributes = devm_kzalloc(&client->dev,
> +						 (PAC193X_CUSTOM_ATTR_FOR_CHANNEL *
> +						 active_channels_count +
> +						 PAC193X_SHARED_DEVATTRS_COUNT)
> +						 * sizeof(*pac193x_group) + 1,
> +						 GFP_KERNEL);
> +	j = 0;
> +
> +	for (i = 0 ; i < chip_info->phys_channels; i++) {
> +		if (chip_info->active_channels[i]) {
> +			pac193x_custom_attributes[PAC193X_CUSTOM_ATTR_FOR_CHANNEL * j] =
> +			pac193x_all_attributes[PAC193X_CUSTOM_ATTR_FOR_CHANNEL * i];
> +			pac193x_custom_attributes[PAC193X_CUSTOM_ATTR_FOR_CHANNEL * j + 1] =
> +			pac193x_all_attributes[PAC193X_CUSTOM_ATTR_FOR_CHANNEL * i + 1];
> +			j++;
> +		}
> +	}
> +
> +	for (i = 0; i < PAC193X_SHARED_DEVATTRS_COUNT; i++)
> +		pac193x_custom_attributes[PAC193X_CUSTOM_ATTR_FOR_CHANNEL *
> +			active_channels_count + i] =
> +			pac193x_all_attributes[PAC193X_CUSTOM_ATTR_FOR_CHANNEL *
> +			chip_info->phys_channels + i];
> +
> +	pac193x_group->attrs = pac193x_custom_attributes;
> +	chip_info->pac193x_info.attrs = pac193x_group;
> +
> +	return 0;
> +}
> +
> +static void pac193x_remove(struct i2c_client *client)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
> +	struct pac193x_chip_info *chip_info = iio_priv(indio_dev);
> +
> +	ret = try_to_del_timer_sync(&chip_info->tmr_forced_update);
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"%s - cannot delete the forced readout timer\n",
> +			__func__);
> +
> +	if (chip_info->wq_chip) {
> +		cancel_work_sync(&chip_info->work_chip_rfsh);
> +		flush_workqueue(chip_info->wq_chip);
> +		destroy_workqueue(chip_info->wq_chip);
> +	}
> +}
> +
> +static int pac193x_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct pac193x_chip_info *chip_info;
> +	struct iio_dev *indio_dev;
> +	const char *name = NULL;
> +	const struct of_device_id *match;
> +	int cnt, ret, dev_id = 0;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip_info));
> +	if (!indio_dev) {
> +		dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
> +			      "Can't allocate iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip_info = iio_priv(indio_dev);
> +
> +	i2c_set_clientdata(client, indio_dev);

Assuming you follow suggestion to go fully devm managed handling of remove, I don't htink
you will need this.

> +	chip_info->client = client;
> +
> +	memset(&chip_info->chip_reg_data, 0, sizeof(chip_info->chip_reg_data));

The iio_priv space is allocated with kzalloc so no need to zero here.

> +
> +	if (ACPI_HANDLE(&client->dev)) {
> +		pac193x_get_variant(chip_info);

Why is this ACPI specific? 

If you can query the variant from the hardware, that is the right thing to use
for all registration types.  It can be helpful to call out if there is
a mismatch though with a warning print, so comparing the result of
the i2c call with the data is fine.

> +	} else {
> +		dev_id = id->driver_data;
> +
> +		/* store the type of chip */
> +		chip_info->chip_variant = dev_id;
> +
> +		/* get the maximum number of channels for the given chip id */
> +		chip_info->phys_channels = pac193x_chip_config[dev_id].phys_channels;
> +	}
> +
> +	/*
> +	 * load default settings - all channels disabled,
> +	 * uni directional flow, default shunt values

The concept of a default shunt value bothers me a little if this is
an external resistor.  How is there in any real sense a default?
Can we just fail if it's not provided - or wrap the default up for
just ACPI case where I guess there might be firmware that doesn't
specify it?

> +	 */
> +	for (cnt = 0; cnt < chip_info->phys_channels; cnt++) {
> +		chip_info->active_channels[cnt] = false;
> +		chip_info->bi_dir[cnt] = false;
> +		chip_info->shunts[cnt] = SHUNT_UOHMS_DEFAULT;
> +	}
> +
> +	chip_info->crt_samp_spd_bitfield = pac193X_samp_1024sps;
> +
> +	if (ACPI_HANDLE(&client->dev)) {
> +		switch (chip_info->chip_variant) {
> +		case PAC1934_PID:
> +			client->dev.init_name = "pac1934";

Fairly sure init_name is only relevant prior to driver_add() which is
long gone by the time probe is called.

> +			break;
> +		case PAC1933_PID:
> +			client->dev.init_name = "pac1933";
> +			break;
> +		case PAC1932_PID:
> +			client->dev.init_name = "pac1932";
> +			break;
> +		case PAC1931_PID:
> +			client->dev.init_name = "pac1931";
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		name = pac193x_match_acpi_device(client, chip_info);

This looks to be doing a lot more than matching (which has already happened
via the i2c query above). Rename the function.


> +	} else {
> +		/* identify the chip we have to deal with */
> +		ret = pac193x_chip_identify(chip_info);
> +		if (ret)
> +			return -EINVAL;
> +
> +		/* check if we find the device within DT */
> +		if (!client->dev.of_node || (!of_get_next_child(client->dev.of_node, NULL)))

You are checking for a child node?  This isn't checking for the device itself so the comment
doesn't match.

> +			return -EINVAL;
> +
> +		match = of_match_node(pac193x_of_match, client->dev.of_node);
> +		if (match) {
> +			ret = pac193x_match_of_device(client, chip_info);
> +			if (!ret)
> +				name = match->compatible;

I can't really follow why this complexity is all here.  This should be using
generic firmware properties from include/linux/property.h so that
ACPI PNP0001 and various other less common firmware types work.
Then you should be able to query the properties without a dance to match
the node. Given the ACPI specific handling it's fine to try that first
and then fallback to generic handling if it fails.  Though note, don't base
that decision on the ACPI_HANDLE as you may have a PRP0001 using firmware which
is also ACPI but uses device tree binding properties.

Name should not be the compatible, but rather just pac1931 etc (no vendor).
Given you have a bunch of different match codes, better to have a per type
constant structure with all the chip differences and just put a string
in there to use for the name.  That way same thing works for ACPI and DT.
Your pac193x_features structure is perfect for this.


> +		}
> +	}
> +
> +	if (!name) {
> +		dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
> +			      "parameter parsing returned an error\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_init(&chip_info->lock);
> +
> +	/*
> +	 * do now any chip specific initialization (e.g. read/write
> +	 * some registers), enable/disable certain channels, change the sampling
> +	 * rate to the requested value
> +	 */
> +	ret = pac193x_chip_configure(chip_info);
> +	if (ret < 0)
> +		goto free_chan_attr_mem;

I'm not totally sure which parts of remove match with this, but I'd expect
there to be devm_add_action_or_reset() calls to setup automated tear down
alongside each aspect.

The one thing the call doesn't seem to do is free memory!

> +
> +	/* prepare the channel information */
> +	ret = pac193x_prep_iio_channels(chip_info, indio_dev);
> +	if (ret < 0)
> +		goto free_chan_attr_mem;
> +
> +	ret = pac193x_prep_custom_attributes(chip_info, indio_dev);
> +	if (ret < 0) {
> +		dev_err_probe(&indio_dev->dev, ret,
> +			      "Can't configure custom attributes for PAC193X device\n");
> +		goto free_chan_attr_mem;
> +	}
> +
> +	chip_info->pac193x_info.read_raw = pac193x_read_raw;
> +	chip_info->pac193x_info.read_avail = pac193x_read_avail;
> +	chip_info->pac193x_info.write_raw = pac193x_write_raw;
> +
> +	indio_dev->info = &chip_info->pac193x_info;
> +	indio_dev->name = name;
> +	indio_dev->dev.parent = &client->dev;

Parent is set automatically by the devm_iio_device_alloc(). A driver should
only be doing this if it needs to change the default for some reason (a few drivers
do).

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/*
> +	 * read whatever it has been accumulated in the chip so far

whatever has been

> +	 * and reset the accumulators
> +	 */
> +	ret = pac193x_reg_snapshot(chip_info, true, false, PAC193X_MIN_UPDATE_WAIT_TIME_MS);
> +	if (ret < 0)
> +		goto free_chan_attr_mem;
> +
> +	/* register with IIO */

Drop all comments that say things that can be easily seen from the code.
They provide no value and can easily become wrong.

> +	ret = devm_iio_device_register(&client->dev, indio_dev);

This results in the user interface being remove after you've called
the pac193x_remove() which seems likely to be a nasty race.

There are two ways to use devm safely.
1) Stop using any devm_ calls at the first thing you manually undo in
   error paths / remove() callback.
2) Don't have any handing in error paths or remove callback because you
   have converted everything to device managed (devm_add_action_or_reset() etc
   to register custom callbacks).

2 is preferred unless things get really complex because it allows for
easy step by step review.

> +	if (ret < 0) {
> +		dev_err_probe(&indio_dev->dev, ret,
> +			      "Can't register IIO device\n");
> +		goto free_chan_attr_mem;
> +	}
> +
> +	return 0;
> +
> +free_chan_attr_mem:
> +	pac193x_remove(client);

devm_add_action_or_reset() allows you to register an extra callback
that will be called in the correct location.  Ideally a remove flow
is almost always the reverse of probe flow as that makes it much easier
to avoid use after free and similar races.  The code here is probably correct
but it is harder to review.

You will probably want to break the _remove() function up into a couple
of different callbacks, undoing individual steps in probe()

> +
> +	return ret;
> +}
> +
> +static const struct i2c_device_id pac193x_id[] = {
> +	{ "pac1934", pac1934 },

Opposite order is more common.

> +	{ "pac1933", pac1933 },
> +	{ "pac1932", pac1932 },
> +	{ "pac1931", pac1931 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, pac193x_id);
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id pac193x_acpi_match[] = {
> +	{"MCHP1930", 0},

Someone had a sense of humour if this ID doesn't actually cover a part
called 1930.. :)

> +	{ },
Trivial, but prefer no , on "NULL terminators" as we will never add
anything after them.
. 
> +};
> +MODULE_DEVICE_TABLE(acpi, pac193x_acpi_match);
> +#endif
> +
> +static struct i2c_driver pac193x_driver = {
> +	.driver	 = {
> +		.name = "pac193x",
> +		.of_match_table = pac193x_of_match,
> +		.acpi_match_table = ACPI_PTR(pac193x_acpi_match)

It is very rarely worth the complexity to save a tiny bit of size
that results from ACPI_PTR()  So unless I'm missing another reason
for this (missing stubs maybe) then I'd not bother with that protection
or the ifdef guards.


> +		},
> +	.probe = pac193x_probe,

Use probe_new
This has very nearly gone away in upstream kernel.

> +	.remove = pac193x_remove,
> +	.id_table = pac193x_id,
> +};
> +
> +module_i2c_driver(pac193x_driver);
> +
> +MODULE_AUTHOR("Bogdan Bolocan <bogdan.bolocan@microchip.com>");
> +MODULE_AUTHOR("Victor Tudose");
> +MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
> +MODULE_DESCRIPTION("IIO driver for PAC193X Multi-Channel DC Power/Energy Monitor");
> +MODULE_LICENSE("GPL");

