Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF48366BC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjAPKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjAPKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:50:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4C919691;
        Mon, 16 Jan 2023 02:50:51 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B3CC6600368;
        Mon, 16 Jan 2023 10:50:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673866250;
        bh=fv9pXlQnrEaoEbB7qQZKK+ZultkhktdaDvgSnP/FYkU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dsx5mxopeWUr/8GBQf91C9aSwtSgeosqsEWV4fgYPs8yHAEBxKmVTfC/XjoyiLHpi
         cvdKX3Jh7zb+GJIjj8Gy/F5Zm+a4O7Qe/hg6QLvDZVwYmKfHH2tXgcO8yCiEnCTNAA
         jlE9j/EgXzgO843NgjWLKuv+z9dOm2sQ43+mvUrPaiTFX3tsqNH1uqYQfSp9s0eDyo
         LQYwQxOQwEFvk6dXYrbfRxv5sCDMdTdp4rIsKzcI6hVqxzTu+djqO67HtAbBCD4XQp
         g2/K6nVikxEpg45G8dsEy9W1rWHbnBHmuI9yo6FNzPOncYksu1aL7BAgx5JKChTa+u
         kFILUVUulLnXg==
Message-ID: <feab4ff4-b874-aa10-2031-ad6b84cbc004@collabora.com>
Date:   Mon, 16 Jan 2023 11:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 4/6] thermal/drivers/mediatek: Add the Low Voltage
 Thermal Sensor driver
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-1-bchihi@baylibre.com>
 <20230112152855.216072-5-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230112152855.216072-5-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/01/23 16:28, bchihi@baylibre.com ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
> controllers contained in a thermal domain.
> 
> A thermal domains can be the MCU or the AP.
> 
> Each thermal domains contain up to seven controllers, each thermal
> controller handle up to four thermal sensors.
> 
> The LVTS has two Finite State Machines (FSM), one to handle the
> functionin temperatures range like hot or cold temperature and another
> one to handle monitoring trip point. The FSM notifies via interrupts
> when a trip point is crossed.
> 
> The interrupt is managed at the thermal controller level, so when an
> interrupt occurs, the driver has to find out which sensor triggered
> such an interrupt.
> 
> The sampling of the thermal can be filtered or immediate. For the
> former, the LVTS measures several points and applies a low pass
> filter.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>   drivers/thermal/mediatek/Kconfig            |   15 +
>   drivers/thermal/mediatek/Makefile           |    1 +
>   drivers/thermal/mediatek/lvts_thermal.c     | 1244 +++++++++++++++++++
>   include/dt-bindings/thermal/mediatek-lvts.h |   19 +
>   4 files changed, 1279 insertions(+)
>   create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
>   create mode 100644 include/dt-bindings/thermal/mediatek-lvts.h
> 

..snip..

> +
> +static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
> +{
> +	struct lvts_sensor *lvts_sensor = tz->devdata;
> +	void __iomem *base = lvts_sensor->base;
> +	u32 raw_low = lvts_temp_to_raw(low);
> +	u32 raw_high = lvts_temp_to_raw(high);
> +
> +	/*
> +	 * Hot to normal temperature threshold
> +	 *
> +	 * LVTS_H2NTHRE
> +	 *
> +	 * Bits:
> +	 *
> +	 * 14-0 : Raw temperature for threshold
> +	 */
> +	if (low != -INT_MAX) {
> +		dev_dbg(&tz->device, "Setting low limit temperature interrupt: %d\n", low);
> +		writel(raw_low, LVTS_H2NTHRE(base));
> +	}
> +
> +	/*
> +	 * Hot temperature threshold
> +	 *
> +	 * LVTS_HTHRE
> +	 *
> +	 * Bits:
> +	 *
> +	 * 14-0 : Raw temperature for threshold
> +	 */
> +	dev_dbg(&tz->device, "Setting high limit temperature interrupt: %d\n", high);
> +	writel(raw_high, LVTS_HTHRE(base));
> +
> +	return 0;
> +}
> +
> +static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
> +{
> +	irqreturn_t iret = IRQ_NONE;
> +	u32 value, masks[] = { 0x0009001F, 0X000881F0, 0x00247C00, 0x1FC00000 };

Please, no magic numbers around.

> +	int i;
> +
> +	/*
> +	 * Interrupt monitoring status
> +	 *
> +	 * LVTS_MONINTST
> +	 *
> +	 * Bits:

You're describing the register with nice words, but there's another way to do
the same that will be even more effective.

/*
  * LVTS MONINT: Interrupt Monitoring register
  * Each bit describes the enable status of per-sensor interrupts.
  */
#define LVTS_MONINT_THRES_COLD	BIT(0)	/* Cold threshold */
#define LVTS_MONINT_THRES_HOT	BIT(1)	/* Hot threshold */
#define LVTS_MONINT_OFFST_LOW	BIT(2)	/* Low offset */
#define LVTS_MONINT_OFFST_HIGH	BIT(3)	/* High offset */
#define LVTS_MONINT_OFFST_NTH	BIT(4)	/* Normal To Hot */
#define EVERYTHING_ELSE ........................

#define LVTS_MONINT_SNS0_MASK	GENMASK( ... )
#define LVTS_MONINT_SNS1_MASK	GENMASK .....

/* Find a better name for this one */
#define LVTS_MONINT_EN_IRQS	( LVTS_MONINT_THRES_COLD | LVTS_MONINT_THRES_HOT |
				  LVTS_MONINT_OFFST_LOW ..... etc etc)




> +	 *
> +	 * 31 : Interrupt for stage 3
> +	 * 30 : Interrupt for stage 2
> +	 * 29 : Interrupt for state 1
> +	 * 28 : Interrupt using filter on sensor 3
> +	 *
> +	 * 27 : Interrupt using immediate on sensor 3
> +	 * 26 : Interrupt normal to hot on sensor 3
> +	 * 25 : Interrupt high offset on sensor 3
> +	 * 24 : Interrupt low offset on sensor 3
> +	 *
> +	 * 23 : Interrupt hot threshold on sensor 3
> +	 * 22 : Interrupt cold threshold on sensor 3
> +	 * 21 : Interrupt using filter on sensor 2
> +	 * 20 : Interrupt using filter on sensor 1
> +	 *
> +	 * 19 : Interrupt using filter on sensor 0
> +	 * 18 : Interrupt using immediate on sensor 2
> +	 * 17 : Interrupt using immediate on sensor 1
> +	 * 16 : Interrupt using immediate on sensor 0
> +	 *
> +	 * 15 : Interrupt device access timeout interrupt
> +	 * 14 : Interrupt normal to hot on sensor 2
> +	 * 13 : Interrupt high offset interrupt on sensor 2
> +	 * 12 : Interrupt low offset interrupt on sensor 2
> +	 *
> +	 * 11 : Interrupt hot threshold on sensor 2
> +	 * 10 : Interrupt cold threshold on sensor 2
> +	 *  9 : Interrupt normal to hot on sensor 1
> +	 *  8 : Interrupt high offset interrupt on sensor 1
> +	 *
> +	 *  7 : Interrupt low offset interrupt on sensor 1
> +	 *  6 : Interrupt hot threshold on sensor 1
> +	 *  5 : Interrupt cold threshold on sensor 1
> +	 *  4 : Interrupt normal to hot on sensor 0
> +	 *
> +	 *  3 : Interrupt high offset interrupt on sensor 0
> +	 *  2 : Interrupt low offset interrupt on sensor 0
> +	 *  1 : Interrupt hot threshold on sensor 0
> +	 *  0 : Interrupt cold threshold on sensor 0
> +	 *
> +	 * We are interested in the sensor(s) responsible of the
> +	 * interrupt event. We update the thermal framework with the
> +	 * thermal zone associated with the sensor. The framework will
> +	 * take care of the rest whatever the kind of interrupt, we
> +	 * are only interested in which sensor raised the interrupt.
> +	 *
> +	 * sensor 3 interrupt: 0001 1111 1100 0000 0000 0000 0000 0000
> +	 *                  => 0x1FC00000
> +	 * sensor 2 interrupt: 0000 0000 0010 0100 0111 1100 0000 0000
> +	 *                  => 0x00247C00
> +	 * sensor 1 interrupt: 0000 0000 0001 0001 0000 0011 1110 0000
> +	 *                  => 0X000881F0
> +	 * sensor 0 interrupt: 0000 0000 0000 1001 0000 0000 0001 1111
> +	 *                  => 0x0009001F
> +	 */
> +	value = readl(LVTS_MONINTSTS(lvts_ctrl->base));
> +
> +	/*
> +	 * Let's figure out which sensors raised the interrupt
> +	 *
> +	 * NOTE: the masks array must be ordered with the index
> +	 * corresponding to the sensor id eg. index=0, mask for
> +	 * sensor0.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(masks); i++) {
> +
> +		if (!(value & masks[i]))

Questions for you:

1. Are the masks always the same for all SoCs?
2. Do they correspond to what we set in lvts_irq_init()?

I'd expect future new SoCs to have different masks... and since lvts_irq_init() is
actually "playing with" interrupts register(s), with one of them (LVTS_MONINT)
having the same layout as this one, I would place all of the initialization in
that function instead.

This means that we'd initialize those masks at lvts_irq_init() time, in a struct
member, and read it back in this interrupt handler: like that, we get that a bit
more ordered and generally more readable.

> +			continue;
> +
> +		thermal_zone_device_update(lvts_ctrl->sensors[i].tz,
> +					   THERMAL_TRIP_VIOLATED);
> +		iret |= IRQ_HANDLED;
> +	}
> +
> +	/*
> +	 * Write back to clear the interrupt status (W1C)
> +	 */
> +	writel(value, LVTS_MONINTSTS(lvts_ctrl->base));
> +
> +	return iret;
> +}
> +
> +/*
> + * Temperature interrupt handler. Even if the driver supports more
> + * interrupt modes, we use the interrupt when the temperature crosses
> + * the hot threshold the way up and the way down (modulo the
> + * hysteresis).
> + *
> + * Each thermal domain has a couple of interrupts, one for hardware
> + * reset and another one for all the thermal events happening on the
> + * different sensors.
> + *
> + * The interrupt is configured for thermal events when crossing the
> + * hot temperature limit. At each interrupt, we check in every
> + * controller if there is an interrupt pending.
> + */
> +static irqreturn_t lvts_irq_handler(int irq, void *data)
> +{
> +	struct lvts_domain *lvts_td = data;
> +	irqreturn_t iret = IRQ_NONE;
> +	int i;
> +
> +	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
> +		iret |= lvts_ctrl_irq_handler(lvts_td->lvts_ctrl);

Please do *not* OR your function calls! While this is surely fine here in
this function and for this particular case, it's generally bad practice
and shall be avoided.

> +
> +	return iret;
> +}
> +
> +static struct thermal_zone_device_ops lvts_ops = {
> +	.get_temp = lvts_get_temp,
> +	.set_trips = lvts_set_trips,
> +};
> +

..snip..

> +
> +static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
> +{
> +	u32 value;
> +
> +	/*
> +	 * LVTS_PROTCTL : Thermal Protection Sensor Selection
> +	 *
> +	 * Bits:
> +	 *
> +	 * 19-18 : Sensor to base the protection on
> +	 * 17-16 : Strategy:
> +	 *         00 : Average of 4 sensors
> +	 *         01 : Max of 4 sensors
> +	 *         10 : Selected sensor with bits 19-18
> +	 *         11 : Reserved
> +	 */
> +	value = BIT(16);
> +	writel(value, LVTS_PROTCTL(lvts_ctrl->base));
> +
> +	/*
> +	 * LVTS_PROTTA : Stage 1 temperature threshold
> +	 * LVTS_PROTTB : Stage 2 temperature threshold
> +	 * LVTS_PROTTC : Stage 3 temperature threshold
> +	 *
> +	 * Bits:
> +	 *
> +	 * 14-0: Raw temperature threshold
> +	 *
> +	 * writel(0x0, LVTS_PROTTA(lvts_ctrl->base));
> +	 * writel(0x0, LVTS_PROTTB(lvts_ctrl->base));
> +	 */
> +	writel(lvts_ctrl->hw_tshut_raw_temp, LVTS_PROTTC(lvts_ctrl->base));
> +
> +	/*
> +	 * LVTS_MONINT : Interrupt configuration register
> +	 *
> +	 * The LVTS_MONINT register layout is the same as the LVTS_MONINTSTS
> +	 * register, except we set the bits to enable the interrupt.
> +	 */
> +	value = 0x9FBF7BDE;

	u32 val;

	val = FIELD_PREP(LVTS_MONINT_SNS0_MASK, LVTS_MONINT_EN_IRQS);
	val |= FIELD_PREP(LVTS_MONINT_SNS1_MASK, LVTS_MONINT_EN_IRQS);

	... etc

	writel(val, ...... )

> +	writel(value, LVTS_MONINT(lvts_ctrl->base));
> +
> +	return 0;
> +}
> +

..snip..

> +
> +static int lvts_ctrl_initialize(struct device *dev, struct lvts_ctrl *lvts_ctrl)
> +{
> +	/*
> +	 * Write device mask: 0xC1030000
> +	 */
> +	u32 cmds[] = {
> +		0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
> +		0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
> +		0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,
> +		0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
> +	};
...what is this long list of commands?

Why 0xC103_0000? Describe that please.

Also, why is this not a platform data constant?

Example:
struct lvts_plat {
	const struct lvts_ctrl_data *ctrl_data;
	u8 num_ctrl_data;
	const u16 device_mask;
	const u16 *init_cmds;
	u8 num_init_cmds;
}

where device_mask gets set to 0xc103 and init_cmds is an array containing
the low-16 (0x0e01, 0x0cfc, ...), and where this function would simply do
something like

	lvts_write_config(lvts_ctrl, plat->device_mask, init_cmds, num_init_cmds);

... and where lvts_write_config() does something like:

	for (i = 0; i < num_cmds; i++) {
		u32 val = device_mask | init_cmds[i];
		writel(val, LVTS_CONFIG ...)
	}
> +
> +	lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
> +
> +	return 0;
> +}
> +
> +static int lvts_ctrl_calibrate(struct device *dev, struct lvts_ctrl *lvts_ctrl)
> +{
> +	int i;
> +	void __iomem *lvts_edata[] = {

Can we constify this?

> +		LVTS_EDATA00(lvts_ctrl->base),
> +		LVTS_EDATA01(lvts_ctrl->base),
> +		LVTS_EDATA02(lvts_ctrl->base),
> +		LVTS_EDATA03(lvts_ctrl->base)
> +	};
> +
> +	/*
> +	 * LVTS_EDATA0X : Efuse calibration reference value for sensor X
> +	 *
> +	 * Bits:
> +	 *
> +	 * 20-0 : Efuse value for normalization data
> +	 */
> +	for (i = 0; i < LVTS_SENSOR_MAX; i++)
> +		writel(lvts_ctrl->calibration[i], lvts_edata[i]);
> +
> +	return 0;
> +}
> +
> +static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
> +{
> +	u32 period_unit = (118 * 1000) / (256 * 38);

#define SOMETHING	118
#define SOMETHING_ELSE	1000
#define ....

const u32 period_unit = (SOMETHING * SOMETHING_ELSE) / ....

> +	u32 grp_interval = 1;
> +	u32 flt_interval = 1;
> +	u32 sensor_interval = 1;
> +	u32 hw_filter = 0x2;
> +	u32 value;
> +

...snip...

> +
> +static struct lvts_ctrl_data mt819x_lvts_data_ctrl[] = {

No wildcards. Please, rename this to give the name of the oldest SoC
that uses these values. Assuming that it is MT8192.... mt8192_lvts_data_ctrl[]

> +	{
> +		.cal_offset = { 0x4, 0x7 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT819x_MCU_BIG_CPU0 },
> +			{ .dt_id = MT819x_MCU_BIG_CPU1 }
> +		},
> +		.num_lvts_sensor = 2,
> +		.offset = 0x0,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
> +	},
> +
> +	{
> +		.cal_offset = { 0xd, 0x10 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT819x_MCU_BIG_CPU2 },
> +			{ .dt_id = MT819x_MCU_BIG_CPU3 }
> +		},
> +		.num_lvts_sensor = 2,
> +		.offset = 0x100,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
> +	},
> +
> +	{
> +		.cal_offset = { 0x16, 0x19, 0x1c, 0x1f },
> +		.lvts_sensor = {
> +			{ .dt_id = MT819x_MCU_LITTLE_CPU0 },
> +			{ .dt_id = MT819x_MCU_LITTLE_CPU1 },
> +			{ .dt_id = MT819x_MCU_LITTLE_CPU2 },
> +			{ .dt_id = MT819x_MCU_LITTLE_CPU3 }
> +		},
> +		.num_lvts_sensor = 4,
> +		.offset = 0x200,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
> +	}
> +};
> +
> +static struct lvts_data mt819x_lvts_mcu_data = {

Same here.

> +	.lvts_ctrl	= mt819x_lvts_data_ctrl,
> +	.num_lvts_ctrl	= ARRAY_SIZE(mt819x_lvts_data_ctrl),
> +};
> +
> +static const struct of_device_id lvts_of_match[] = {
> +	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt819x_lvts_mcu_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, lvts_of_match);
> +
> +static struct platform_driver lvts_driver = {
> +	.probe = lvts_probe,
> +	.remove = lvts_remove,
> +	.driver = {
> +		.name = "mtk-lvts-thermal",
> +		.of_match_table = lvts_of_match,
> +	},
> +};
> +module_platform_driver(lvts_driver);
> +
> +MODULE_AUTHOR("Balsam CHIHI <bchihi@baylibre.com>");
> +MODULE_DESCRIPTION("MediaTek LVTS Thermal Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
> new file mode 100644
> index 000000000000..80d060400236
> --- /dev/null
> +++ b/include/dt-bindings/thermal/mediatek-lvts.h

Bindings go in a different commit: add this in your patch [2/6], where you are
adding the yaml binding.

Also, please follow binding names: rename this file to mediatek,mt8192-lvts.h.

> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Balsam CHIHI <bchihi@baylibre.com>
> + */
> +
> +#ifndef __MEDIATEK_LVTS_DT_H
> +#define __MEDIATEK_LVTS_DT_H
> +
> +#define MT819x_MCU_BIG_CPU0	0

No wildcards: MT8192_MCU_BIG_CPU0

> +#define MT819x_MCU_BIG_CPU1	1
> +#define	MT819x_MCU_BIG_CPU2	2
> +#define	MT819x_MCU_BIG_CPU3	3
> +#define	MT819x_MCU_LITTLE_CPU0	4
> +#define	MT819x_MCU_LITTLE_CPU1	5
> +#define	MT819x_MCU_LITTLE_CPU2	6
> +#define	MT819x_MCU_LITTLE_CPU3	7
> +
> +#endif /* __MEDIATEK_LVTS_DT_H */

Regards,
Angelo
