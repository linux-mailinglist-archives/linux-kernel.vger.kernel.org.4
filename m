Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05A56A707C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCAQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCAQEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:04:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1D9474DB;
        Wed,  1 Mar 2023 08:04:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9327EB80EF8;
        Wed,  1 Mar 2023 16:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41658C433D2;
        Wed,  1 Mar 2023 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677686673;
        bh=jhbNh5npF+2xotxEnHi0d9c8tIQ2/suSf/qT+gwNOPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iREM1trPofudk2zEySLLmJ5bwgd1O0ohcd8o2Fe/SV9X+2ADPetblrHcbCX4JgVTP
         KJ1azrx3stgZZFmxSltR4guavYPVBZQViXvoKrDgW/r8iBNImWzM1kF8+2SgR6MkmS
         DVEaFnNMSk3vivxHXCN3yMnWvuLgzRdlEUW87dKt72YPigNhUkCV8K8bXAdJpPj8/g
         uGJGntrkX9zHcXcL1fsytuBraZSffzn/RHt/zDKxGPAImcltdnqrjnUWvAsnirImVV
         ZA/bP3CMT/8kZTQcqtJfU84LhzlVr/xV4EZ7MLH4NBRzETDQQHrZUf224nuwVOrDsb
         YZrXFzHyhasPQ==
Date:   Wed, 1 Mar 2023 16:04:27 +0000
From:   Lee Jones <lee@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, krzysztof.kozlowski@linaro.org,
        linux-leds@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v7 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
Message-ID: <Y/93i3m+aNPVeRCu@google.com>
References: <20230203035644.474208-1-quic_fenglinw@quicinc.com>
 <20230203035644.474208-2-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230203035644.474208-2-quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2023, Fenglin Wu wrote:

> Add initial driver to support flash LED module found in Qualcomm
> Technologies, Inc. PMICs. The flash module can have 3 or 4 channels
> and each channel can be controlled indepedently and support full scale
> current up to 1.5 A. It also supports connecting two channels together
> to supply one LED component with full scale current up to 2 A. In that
> case, the current will be split on each channel symmetrically and the
> channels will be enabled and disabled at the same time.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sm7225-fairphone-fp4 + pm6150l
> ---

Change log?

>  drivers/leds/flash/Kconfig           |  15 +
>  drivers/leds/flash/Makefile          |   1 +
>  drivers/leds/flash/leds-qcom-flash.c | 769 +++++++++++++++++++++++++++
>  3 files changed, 785 insertions(+)
>  create mode 100644 drivers/leds/flash/leds-qcom-flash.c
> 
> diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
> index d3eb689b193c..f36a60409290 100644
> --- a/drivers/leds/flash/Kconfig
> +++ b/drivers/leds/flash/Kconfig
> @@ -61,6 +61,21 @@ config LEDS_MT6360
>  	  Independent current sources supply for each flash LED support torch
>  	  and strobe mode.
>  
> +config LEDS_QCOM_FLASH
> +	tristate "LED support for flash module inside Qualcomm Technologies, Inc. PMIC"
> +	depends on MFD_SPMI_PMIC || COMPILE_TEST
> +	depends on LEDS_CLASS && OF
> +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
> +	select REGMAP
> +	help
> +	  This option enables support for the flash module found in Qualcomm
> +	  Technologies, Inc. PMICs. The flash module can have 3 or 4 flash LED
> +	  channels and each channel is programmable to support up to 1.5 A full
> +	  scale current. It also supports connecting two channels' output together
> +	  to supply one LED component to achieve current up to 2 A. In such case,
> +	  the total LED current will be split symmetrically on each channel and
> +	  they will be enabled/disabled at the same time.
> +
>  config LEDS_RT4505
>  	tristate "LED support for RT4505 flashlight controller"
>  	depends on I2C && OF
> diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
> index 0acbddc0b91b..8a60993f1a25 100644
> --- a/drivers/leds/flash/Makefile
> +++ b/drivers/leds/flash/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_LEDS_AS3645A)	+= leds-as3645a.o
>  obj-$(CONFIG_LEDS_KTD2692)	+= leds-ktd2692.o
>  obj-$(CONFIG_LEDS_LM3601X)	+= leds-lm3601x.o
>  obj-$(CONFIG_LEDS_MAX77693)	+= leds-max77693.o
> +obj-$(CONFIG_LEDS_QCOM_FLASH)	+= leds-qcom-flash.o
>  obj-$(CONFIG_LEDS_RT4505)	+= leds-rt4505.o
>  obj-$(CONFIG_LEDS_RT8515)	+= leds-rt8515.o
>  obj-$(CONFIG_LEDS_SGM3140)	+= leds-sgm3140.o
> diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
> new file mode 100644
> index 000000000000..51ef60e2338c
> --- /dev/null
> +++ b/drivers/leds/flash/leds-qcom-flash.c
> @@ -0,0 +1,769 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/leds.h>
> +#include <linux/led-class-flash.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <media/v4l2-flash-led-class.h>
> +
> +/* registers definitions */
> +#define FLASH_TYPE_REG			0x04
> +#define FLASH_TYPE_VAL			0x18
> +
> +#define FLASH_SUBTYPE_REG		0x05
> +#define FLASH_SUBTYPE_3CH_VAL		0x04
> +#define FLASH_SUBTYPE_4CH_VAL		0x07
> +
> +#define FLASH_STS_3CH_OTST1		BIT(0)
> +#define FLASH_STS_3CH_OTST2		BIT(1)
> +#define FLASH_STS_3CH_OTST3		BIT(2)
> +#define FLASH_STS_3CH_BOB_THM_OVERLOAD	BIT(3)
> +#define FLASH_STS_3CH_VPH_DROOP		BIT(4)
> +#define FLASH_STS_3CH_BOB_ILIM_S1	BIT(5)
> +#define FLASH_STS_3CH_BOB_ILIM_S2	BIT(6)
> +#define FLASH_STS_3CH_BCL_IBAT		BIT(7)
> +
> +#define FLASH_STS_4CH_VPH_LOW		BIT(0)
> +#define FLASH_STS_4CH_BCL_IBAT		BIT(1)
> +#define FLASH_STS_4CH_BOB_ILIM_S1	BIT(2)
> +#define FLASH_STS_4CH_BOB_ILIM_S2	BIT(3)
> +#define FLASH_STS_4CH_OTST2		BIT(4)
> +#define FLASH_STS_4CH_OTST1		BIT(5)
> +#define FLASH_STS_4CHG_BOB_THM_OVERLOAD	BIT(6)
> +
> +#define FLASH_TIMER_EN_BIT		BIT(7)
> +#define FLASH_TIMER_VAL_MASK		GENMASK(6, 0)
> +#define FLASH_TIMER_STEP_MS		10
> +
> +#define FLASH_STROBE_HW_SW_SEL_BIT	BIT(2)
> +#define SW_STROBE_VAL			0
> +#define HW_STROBE_VAL			1
> +#define FLASH_HW_STROBE_TRIGGER_SEL_BIT	BIT(1)
> +#define STROBE_LEVEL_TRIGGER_VAL	0
> +#define STROBE_EDGE_TRIGGER_VAL		1
> +#define FLASH_STROBE_POLARITY_BIT	BIT(0)
> +#define STROBE_ACTIVE_HIGH_VAL		1
> +
> +#define FLASH_IRES_MASK_4CH		BIT(0)
> +#define FLASH_IRES_MASK_3CH		GENMASK(1, 0)
> +#define FLASH_IRES_12P5MA_VAL		0
> +#define FLASH_IRES_5MA_VAL_4CH		1
> +#define FLASH_IRES_5MA_VAL_3CH		3
> +
> +/* constants */
> +#define FLASH_CURRENT_MAX_UA		1500000
> +#define TORCH_CURRENT_MAX_UA		500000
> +#define FLASH_TOTAL_CURRENT_MAX_UA	2000000
> +#define FLASH_CURRENT_DEFAULT_UA	1000000
> +#define TORCH_CURRENT_DEFAULT_UA	200000
> +
> +#define TORCH_IRES_UA			5000
> +#define FLASH_IRES_UA			12500
> +
> +#define FLASH_TIMEOUT_MAX_US		1280000
> +#define FLASH_TIMEOUT_STEP_US		10000
> +
> +#define UA_PER_MA			1000
> +
> +enum hw_type {
> +	QCOM_MVFLASH_3CH,
> +	QCOM_MVFLASH_4CH,
> +};
> +
> +enum led_mode {
> +	FLASH_MODE,
> +	TORCH_MODE,
> +};
> +
> +enum led_strobe {
> +	SW_STROBE,
> +	HW_STROBE,
> +};
> +
> +enum {
> +	REG_STATUS1,
> +	REG_STATUS2,
> +	REG_STATUS3,
> +	REG_CHAN_TIMER,
> +	REG_ITARGET,
> +	REG_MODULE_EN,
> +	REG_IRESOLUTION,
> +	REG_CHAN_STROBE,
> +	REG_CHAN_EN,
> +	REG_MAX_COUNT,
> +};
> +
> +struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
> +	REG_FIELD(0x08, 0, 7),			/* status1	*/
> +	REG_FIELD(0x09, 0, 7),                  /* status2	*/
> +	REG_FIELD(0x0a, 0, 7),                  /* status3	*/
> +	REG_FIELD_ID(0x40, 0, 7, 3, 1),         /* chan_timer	*/
> +	REG_FIELD_ID(0x43, 0, 6, 3, 1),         /* itarget	*/
> +	REG_FIELD(0x46, 7, 7),                  /* module_en	*/
> +	REG_FIELD(0x47, 0, 5),                  /* iresolution	*/
> +	REG_FIELD_ID(0x49, 0, 2, 3, 1),         /* chan_strobe	*/
> +	REG_FIELD(0x4c, 0, 2),                  /* chan_en	*/
> +};
> +
> +struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
> +	REG_FIELD(0x06, 0, 7),			/* status1	*/
> +	REG_FIELD(0x07, 0, 6),			/* status2	*/
> +	REG_FIELD(0x09, 0, 7),			/* status3	*/
> +	REG_FIELD_ID(0x3e, 0, 7, 4, 1),		/* chan_timer	*/
> +	REG_FIELD_ID(0x42, 0, 6, 4, 1),		/* itarget	*/
> +	REG_FIELD(0x46, 7, 7),			/* module_en	*/
> +	REG_FIELD(0x49, 0, 3),			/* iresolution	*/
> +	REG_FIELD_ID(0x4a, 0, 6, 4, 1),		/* chan_strobe	*/
> +	REG_FIELD(0x4e, 0, 3),			/* chan_en	*/
> +};
> +
> +struct qcom_flash_led {
> +	struct led_classdev_flash	flash;
> +	struct v4l2_flash		*v4l2_flash;
> +	u32				max_flash_current_ma;
> +	u32				max_torch_current_ma;
> +	u32				max_timeout_ms;
> +	u32				flash_current_ma;
> +	u32				flash_timeout_ms;
> +	u8				*chan_id;
> +	u8				chan_count;
> +	bool				enabled;
> +	void				*priv_data;

How is this anything other than an obfuscated version of the previous
implementation?

Right, let's go back to first principles:

Why do you need a separate 'chip' structure anyway?

> +};
> +
> +struct qcom_flash_chip {
> +	struct qcom_flash_led	*leds;

Goes away if you just use qcom_flash_led.

> +	struct regmap_field     *r_fields[REG_MAX_COUNT];

This looks like it might be an issue.

If so, why not have another structure that all LEDs get a pointer to,
but does not have a pointer to the LEDs, thus satisfying our one-way
rule?

As far as I can see, the only time you need to point from 'chip' to
'leds' is to release v4l2_flash.  If you can find another sane way of
doing that, you can drop the chip to leds link.

Take a peak at some other drivers, to see how they manage that.

> +	struct device		*dev;

Can be derived from led_classdev_flash.

> +	struct mutex		lock;

Any reason why the lock can't be per LED?

> +	enum hw_type		hw_type;
> +	u8			leds_count;

Goes away if you just use qcom_flash_led.

> +	u8			max_channels;

What is a channel?  And how does it relate to the LEDs?

Looks like the LED structure also has a "chan_count" attribute.

> +	u8			chan_en_bits;
> +};
> +
> +static inline void *flash_led_get_priv_data(struct qcom_flash_led *led)
> +{
> +	return led->priv_data;
> +}
> +
> +static int set_flash_module_en(struct qcom_flash_led *led, bool en)
> +{
> +	struct qcom_flash_chip *chip = flash_led_get_priv_data(led);
> +	u8 led_mask = 0, enable;
> +	int i, rc;
> +
> +	for (i = 0; i < led->chan_count; i++)
> +		led_mask |= BIT(led->chan_id[i]);
> +
> +	mutex_lock(&chip->lock);
> +	if (en)
> +		chip->chan_en_bits |= led_mask;
> +	else
> +		chip->chan_en_bits &= ~led_mask;
> +
> +	enable = !!chip->chan_en_bits;
> +	rc = regmap_field_write(chip->r_fields[REG_MODULE_EN], enable);
> +	if (rc)
> +		dev_err(chip->dev, "write module_en failed, rc=%d\n", rc);
> +	mutex_unlock(&chip->lock);
> +
> +	return rc;
> +}
> +
> +static int set_flash_current(struct qcom_flash_led *led, u32 current_ma, enum led_mode mode)
> +{
> +	struct qcom_flash_chip *chip = flash_led_get_priv_data(led);
> +	u32 itarg_ua, ires_ua;
> +	u8 shift, ires_mask = 0, ires_val = 0, chan_id;
> +	int i, rc;
> +
> +	/*
> +	 * Split the current across the channels and set the
> +	 * IRESOLUTION and ITARGET registers accordingly.
> +	 */
> +	itarg_ua = (current_ma * UA_PER_MA) / led->chan_count + 1;
> +	ires_ua = (mode == FLASH_MODE) ? FLASH_IRES_UA : TORCH_IRES_UA;
> +
> +	for (i = 0; i < led->chan_count; i++) {
> +		u8 itarget = 0;
> +
> +		if (itarg_ua > ires_ua)
> +			itarget = itarg_ua / ires_ua - 1;
> +
> +		chan_id = led->chan_id[i];
> +
> +		rc = regmap_fields_write(chip->r_fields[REG_ITARGET], chan_id, itarget);
> +		if (rc)
> +			return rc;
> +
> +		if (chip->hw_type == QCOM_MVFLASH_3CH) {
> +			shift = chan_id * 2;
> +			ires_mask |= FLASH_IRES_MASK_3CH << shift;
> +			ires_val |= ((mode == FLASH_MODE) ?
> +				(FLASH_IRES_12P5MA_VAL << shift) :
> +				(FLASH_IRES_5MA_VAL_3CH << shift));
> +		} else if (chip->hw_type == QCOM_MVFLASH_4CH) {
> +			shift = chan_id;
> +			ires_mask |= FLASH_IRES_MASK_4CH << shift;
> +			ires_val |= ((mode == FLASH_MODE) ?
> +				(FLASH_IRES_12P5MA_VAL << shift) :
> +				(FLASH_IRES_5MA_VAL_4CH << shift));
> +		} else {
> +			dev_err(chip->dev, "HW type %d is not supported\n", chip->hw_type);
> +			return -ENOTSUPP;
> +		}
> +	}
> +
> +	return regmap_field_update_bits(chip->r_fields[REG_IRESOLUTION], ires_mask, ires_val);
> +}
> +
> +static int set_flash_timeout(struct qcom_flash_led *led, u32 timeout_ms)
> +{
> +	struct qcom_flash_chip *chip = flash_led_get_priv_data(led);
> +	u8 timer, chan_id;
> +	int rc, i;
> +
> +	/* set SAFETY_TIMER for all the channels connected to the same LED */
> +	timeout_ms = min_t(u32, timeout_ms, led->max_timeout_ms);
> +
> +	for (i = 0; i < led->chan_count; i++) {
> +		chan_id = led->chan_id[i];
> +
> +		timer = timeout_ms / FLASH_TIMER_STEP_MS;
> +		timer = clamp_t(u8, timer, 0, FLASH_TIMER_VAL_MASK);
> +
> +		if (timeout_ms)
> +			timer |= FLASH_TIMER_EN_BIT;
> +
> +		rc = regmap_fields_write(chip->r_fields[REG_CHAN_TIMER], chan_id, timer);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int set_flash_strobe(struct qcom_flash_led *led, enum led_strobe strobe, bool state)
> +{
> +	struct qcom_flash_chip *chip = flash_led_get_priv_data(led);
> +	u8 strobe_sel, chan_en, chan_id, chan_mask = 0;
> +	int rc, i;
> +
> +	/* Set SW strobe config for all channels connected to the LED */
> +	for (i = 0; i < led->chan_count; i++) {
> +		chan_id = led->chan_id[i];
> +
> +		if (strobe == SW_STROBE)
> +			strobe_sel = FIELD_PREP(FLASH_STROBE_HW_SW_SEL_BIT, SW_STROBE_VAL);
> +		else
> +			strobe_sel = FIELD_PREP(FLASH_STROBE_HW_SW_SEL_BIT, HW_STROBE_VAL);
> +
> +		strobe_sel |=
> +			FIELD_PREP(FLASH_HW_STROBE_TRIGGER_SEL_BIT, STROBE_LEVEL_TRIGGER_VAL) |
> +			FIELD_PREP(FLASH_STROBE_POLARITY_BIT, STROBE_ACTIVE_HIGH_VAL);
> +
> +		rc = regmap_fields_write(chip->r_fields[REG_CHAN_STROBE], chan_id, strobe_sel);
> +		if (rc)
> +			return rc;
> +
> +		chan_mask |= BIT(chan_id);
> +	}
> +
> +	/* Enable/disable flash channels */
> +	chan_en = state ? chan_mask : 0;
> +	rc = regmap_field_update_bits(chip->r_fields[REG_CHAN_EN], chan_mask, chan_en);
> +	if (rc)
> +		return rc;
> +
> +	led->enabled = state;
> +	return 0;
> +}
> +
> +static int qcom_flash_brightness_set(struct led_classdev_flash *fled_cdev, u32 brightness)
> +{
> +	struct qcom_flash_led *led = container_of(fled_cdev, struct qcom_flash_led, flash);
> +
> +	led->flash_current_ma = min_t(u32, led->max_flash_current_ma, brightness / UA_PER_MA);
> +	return 0;
> +}
> +
> +static int qcom_flash_timeout_set(struct led_classdev_flash *fled_cdev, u32 timeout)
> +{
> +	struct qcom_flash_led *led = container_of(fled_cdev, struct qcom_flash_led, flash);
> +
> +	led->flash_timeout_ms = timeout / USEC_PER_MSEC;
> +	return 0;
> +}
> +
> +static int qcom_flash_strobe_set(struct led_classdev_flash *fled_cdev, bool state)
> +{
> +	struct qcom_flash_led *led = container_of(fled_cdev, struct qcom_flash_led, flash);
> +	int rc;
> +
> +	rc = set_flash_current(led, led->flash_current_ma, FLASH_MODE);
> +	if (rc)
> +		return rc;
> +
> +	rc = set_flash_timeout(led, led->flash_timeout_ms);
> +	if (rc)
> +		return rc;
> +
> +	rc = set_flash_module_en(led, state);
> +	if (rc)
> +		return rc;
> +
> +	return set_flash_strobe(led, SW_STROBE, state);
> +}
> +
> +static int qcom_flash_strobe_get(struct led_classdev_flash *fled_cdev, bool *state)
> +{
> +	struct qcom_flash_led *led = container_of(fled_cdev, struct qcom_flash_led, flash);
> +
> +	*state = led->enabled;
> +	return 0;
> +}
> +
> +static int qcom_flash_fault_get(struct led_classdev_flash *fled_cdev, u32 *fault)
> +{
> +	struct qcom_flash_led *led = container_of(fled_cdev, struct qcom_flash_led, flash);
> +	struct qcom_flash_chip *chip = flash_led_get_priv_data(led);
> +	u8 shift, chan_id, chan_mask = 0;
> +	u8 ot_mask, oc_mask, uv_mask;
> +	u32 val, fault_sts = 0;
> +	int i, rc;
> +
> +	rc = regmap_field_read(chip->r_fields[REG_STATUS1], &val);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < led->chan_count; i++) {
> +		chan_id = led->chan_id[i];
> +		shift = chan_id * 2;
> +
> +		if (val & BIT(shift))
> +			fault_sts |= LED_FAULT_SHORT_CIRCUIT;
> +
> +		chan_mask |= BIT(chan_id);
> +	}
> +
> +	rc = regmap_field_read(chip->r_fields[REG_STATUS2], &val);
> +	if (rc)
> +		return rc;
> +
> +	if (chip->hw_type == QCOM_MVFLASH_3CH) {
> +		ot_mask = FLASH_STS_3CH_OTST1 |
> +			  FLASH_STS_3CH_OTST2 |
> +			  FLASH_STS_3CH_OTST3 |
> +			  FLASH_STS_3CH_BOB_THM_OVERLOAD;
> +		oc_mask = FLASH_STS_3CH_BOB_ILIM_S1 |
> +			  FLASH_STS_3CH_BOB_ILIM_S2 |
> +			  FLASH_STS_3CH_BCL_IBAT;
> +		uv_mask = FLASH_STS_3CH_VPH_DROOP;
> +	} else if (chip->hw_type == QCOM_MVFLASH_4CH) {
> +		ot_mask = FLASH_STS_4CH_OTST2 |
> +			  FLASH_STS_4CH_OTST1 |
> +			  FLASH_STS_4CHG_BOB_THM_OVERLOAD;
> +		oc_mask = FLASH_STS_4CH_BCL_IBAT |
> +			  FLASH_STS_4CH_BOB_ILIM_S1 |
> +			  FLASH_STS_4CH_BOB_ILIM_S2;
> +		uv_mask = FLASH_STS_4CH_VPH_LOW;
> +	}
> +
> +	if (val & ot_mask)
> +		fault_sts |= LED_FAULT_OVER_TEMPERATURE;
> +
> +	if (val & oc_mask)
> +		fault_sts |= LED_FAULT_OVER_CURRENT;
> +
> +	if (val & uv_mask)
> +		fault_sts |= LED_FAULT_INPUT_VOLTAGE;
> +
> +	rc = regmap_field_read(chip->r_fields[REG_STATUS3], &val);
> +	if (rc)
> +		return rc;
> +
> +	if (chip->hw_type == QCOM_MVFLASH_3CH) {
> +		if (val & chan_mask)
> +			fault_sts |= LED_FAULT_TIMEOUT;
> +	} else if (chip->hw_type == QCOM_MVFLASH_4CH) {
> +		for (i = 0; i < led->chan_count; i++) {
> +			chan_id = led->chan_id[i];
> +			shift = chan_id * 2;
> +
> +			if (val & BIT(shift))
> +				fault_sts |= LED_FAULT_TIMEOUT;
> +		}
> +	}
> +
> +	*fault = fault_sts;
> +	return 0;
> +}
> +
> +static int qcom_flash_led_brightness_set(struct led_classdev *led_cdev,
> +					enum led_brightness brightness)
> +{
> +	struct led_classdev_flash *fled_cdev =
> +		container_of(led_cdev, struct led_classdev_flash, led_cdev);

lcdev_to_flcdev()

> +	struct qcom_flash_led *led =
> +		container_of(fled_cdev, struct qcom_flash_led, flash);

Please create a helper similar to above.

flcdev_to_qcom_fled()

> +	u32 current_ma = brightness * led->max_torch_current_ma / LED_FULL;
> +	bool enable = !!brightness;
> +	int rc;
> +
> +	rc = set_flash_current(led, current_ma, TORCH_MODE);
> +	if (rc)
> +		return rc;
> +
> +	/* Disable flash timeout for torch LED */
> +	rc = set_flash_timeout(led, 0);
> +	if (rc)
> +		return rc;
> +
> +	rc = set_flash_module_en(led, enable);
> +	if (rc)
> +		return rc;
> +
> +	return set_flash_strobe(led, SW_STROBE, enable);
> +}
> +
> +static const struct led_flash_ops qcom_flash_ops = {
> +	.flash_brightness_set = qcom_flash_brightness_set,
> +	.strobe_set = qcom_flash_strobe_set,
> +	.strobe_get = qcom_flash_strobe_get,
> +	.timeout_set = qcom_flash_timeout_set,
> +	.fault_get = qcom_flash_fault_get,
> +};
> +
> +#if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
> +static int qcom_flash_external_strobe_set(struct v4l2_flash *v4l2_flash, bool enable)
> +{
> +	struct led_classdev_flash *flash = v4l2_flash->fled_cdev;
> +	struct qcom_flash_led *led = container_of(flash, struct qcom_flash_led, flash);
> +	int rc;
> +
> +	rc = set_flash_module_en(led, enable);
> +	if (rc)
> +		return rc;
> +
> +	if (enable)
> +		return set_flash_strobe(led, HW_STROBE, true);
> +	else
> +		return set_flash_strobe(led, SW_STROBE, false);
> +}
> +
> +static enum led_brightness
> +qcom_flash_intensity_to_led_brightness(struct v4l2_flash *v4l2_flash, s32 intensity)
> +{
> +	struct led_classdev_flash *flash = v4l2_flash->fled_cdev;
> +	struct qcom_flash_led *led = container_of(flash, struct qcom_flash_led, flash);
> +	u32 current_ma = intensity / UA_PER_MA;
> +
> +	current_ma = min_t(u32, current_ma, led->max_torch_current_ma);
> +	if (!current_ma)
> +		return LED_OFF;
> +
> +	return (current_ma * LED_FULL) / led->max_torch_current_ma;
> +}
> +
> +static s32 qcom_flash_brightness_to_led_intensity(struct v4l2_flash *v4l2_flash,
> +					enum led_brightness brightness)
> +{
> +	struct led_classdev_flash *flash = v4l2_flash->fled_cdev;
> +	struct qcom_flash_led *led = container_of(flash, struct qcom_flash_led, flash);
> +
> +	return (brightness * led->max_torch_current_ma * UA_PER_MA) / LED_FULL;
> +}
> +
> +static const struct v4l2_flash_ops qcom_v4l2_flash_ops = {
> +	.external_strobe_set = qcom_flash_external_strobe_set,
> +	.intensity_to_led_brightness = qcom_flash_intensity_to_led_brightness,
> +	.led_brightness_to_intensity = qcom_flash_brightness_to_led_intensity,
> +};
> +
> +static int qcom_flash_v4l2_init(struct qcom_flash_led *led, struct fwnode_handle *fwnode)
> +{
> +	struct qcom_flash_chip *chip = flash_led_get_priv_data(led);
> +	struct v4l2_flash_config v4l2_cfg = { 0 };
> +	struct led_flash_setting *intensity = &v4l2_cfg.intensity;
> +
> +	if (!(led->flash.led_cdev.flags & LED_DEV_CAP_FLASH))
> +		return 0;
> +
> +	intensity->min = intensity->step = TORCH_IRES_UA * led->chan_count;
> +	intensity->max = led->max_torch_current_ma * UA_PER_MA;
> +	intensity->val = min_t(u32, intensity->max, TORCH_CURRENT_DEFAULT_UA);
> +
> +	strscpy(v4l2_cfg.dev_name, led->flash.led_cdev.dev->kobj.name,
> +					sizeof(v4l2_cfg.dev_name));
> +
> +	v4l2_cfg.has_external_strobe = true;
> +	v4l2_cfg.flash_faults = LED_FAULT_INPUT_VOLTAGE |
> +				LED_FAULT_OVER_CURRENT |
> +				LED_FAULT_SHORT_CIRCUIT |
> +				LED_FAULT_OVER_TEMPERATURE |
> +				LED_FAULT_TIMEOUT;
> +
> +	led->v4l2_flash = v4l2_flash_init(chip->dev, fwnode, &led->flash,
> +					&qcom_v4l2_flash_ops, &v4l2_cfg);
> +	return PTR_ERR_OR_ZERO(led->v4l2_flash);
> +}
> +# else
> +static int qcom_flash_v4l2_init(struct qcom_flash_led *led, struct fwnode_handle *fwnode)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static int qcom_flash_register_led_device(struct device *parent,
> +		struct fwnode_handle *node, struct qcom_flash_led *led)
> +{
> +	struct qcom_flash_chip *chip = flash_led_get_priv_data(led);
> +	struct led_init_data init_data;
> +	struct led_classdev_flash *flash = &led->flash;
> +	struct led_flash_setting *brightness, *timeout;
> +	u32 count, current_ua, timeout_us;
> +	u32 channels[4];
> +	int i, rc;
> +
> +	count = fwnode_property_count_u32(node, "led-sources");
> +	if (count <= 0) {
> +		dev_err(chip->dev, "No led-sources specified\n");
> +		return -ENODEV;
> +	}
> +
> +	if (count > chip->max_channels) {
> +		dev_err(chip->dev, "led-sources count %u exceeds maximum channel count %u\n",
> +				count, chip->max_channels);
> +		return -EINVAL;
> +	}
> +
> +	rc = fwnode_property_read_u32_array(node, "led-sources", channels, count);
> +	if (rc < 0) {
> +		dev_err(chip->dev, "Failed to read led-sources property, rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	led->chan_count = count;
> +	led->chan_id = devm_kcalloc(chip->dev, count, sizeof(u8), GFP_KERNEL);
> +	if (!led->chan_id)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < count; i++) {
> +		if ((channels[i] == 0) || (channels[i] > chip->max_channels)) {
> +			dev_err(chip->dev, "led-source out of HW support range [1-%u]\n",
> +					chip->max_channels);
> +			return -EINVAL;
> +		}
> +
> +		/* Make chan_id indexing from 0 */
> +		led->chan_id[i] = channels[i] - 1;
> +	}
> +
> +	rc = fwnode_property_read_u32(node, "led-max-microamp", &current_ua);
> +	if (rc < 0) {
> +		dev_err(chip->dev, "Failed to read led-max-microamp property, rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	if (current_ua == 0) {
> +		dev_err(chip->dev, "led-max-microamp shouldn't be 0\n");
> +		return -EINVAL;
> +	}
> +
> +	current_ua = min_t(u32, current_ua, TORCH_CURRENT_MAX_UA * led->chan_count);
> +	led->max_torch_current_ma = current_ua / UA_PER_MA;
> +
> +	if (fwnode_property_present(node, "flash-max-microamp")) {
> +		flash->led_cdev.flags |= LED_DEV_CAP_FLASH;
> +
> +		rc = fwnode_property_read_u32(node, "flash-max-microamp", &current_ua);
> +		if (rc < 0) {
> +			dev_err(chip->dev, "Failed to read flash-max-microamp property, rc=%d\n",
> +					rc);
> +			return rc;
> +		}
> +
> +		current_ua = min_t(u32, current_ua, FLASH_CURRENT_MAX_UA * led->chan_count);
> +		current_ua = min_t(u32, current_ua, FLASH_TOTAL_CURRENT_MAX_UA);
> +
> +		/* Initialize flash class LED device brightness settings */
> +		brightness = &flash->brightness;
> +		brightness->min = brightness->step = FLASH_IRES_UA * led->chan_count;
> +		brightness->max = current_ua;
> +		brightness->val = min_t(u32, current_ua, FLASH_CURRENT_DEFAULT_UA);
> +
> +		led->max_flash_current_ma = current_ua / UA_PER_MA;
> +		led->flash_current_ma = brightness->val / UA_PER_MA;
> +
> +		rc = fwnode_property_read_u32(node, "flash-max-timeout-us", &timeout_us);
> +		if (rc < 0) {
> +			dev_err(chip->dev, "Failed to read flash-max-timeout-us property, rc=%d\n",
> +					rc);
> +			return rc;
> +		}
> +
> +		timeout_us = min_t(u32, timeout_us, FLASH_TIMEOUT_MAX_US);
> +
> +		/* Initialize flash class LED device timeout settings */
> +		timeout = &flash->timeout;
> +		timeout->min = timeout->step = FLASH_TIMEOUT_STEP_US;
> +		timeout->val = timeout->max = timeout_us;
> +
> +		led->max_timeout_ms = led->flash_timeout_ms = timeout_us / USEC_PER_MSEC;
> +
> +		flash->ops = &qcom_flash_ops;
> +	}
> +
> +	flash->led_cdev.brightness_set_blocking = qcom_flash_led_brightness_set;
> +
> +	init_data.fwnode = node;
> +	init_data.devicename = NULL;
> +	init_data.default_label = NULL;
> +	init_data.devname_mandatory = false;
> +
> +	rc = devm_led_classdev_flash_register_ext(parent, flash, &init_data);
> +	if (rc < 0) {
> +		dev_err(chip->dev, "Register flash LED classdev failed, rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	return qcom_flash_v4l2_init(led, node);
> +}
> +
> +static int qcom_flash_led_probe(struct platform_device *pdev)
> +{
> +	struct qcom_flash_chip *chip;
> +	struct qcom_flash_led *led;
> +	struct fwnode_handle *child;
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	struct reg_field *regs;
> +	int count, i, rc;
> +	u32 val, reg_base;
> +
> +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "Failed to get parent regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	rc = fwnode_property_read_u32(dev->fwnode, "reg", &reg_base);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to get register base address, rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = regmap_read(regmap, reg_base + FLASH_TYPE_REG, &val);
> +	if (rc < 0) {
> +		dev_err(dev, "Read flash LED module type failed, rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	if (val != FLASH_TYPE_VAL) {
> +		dev_err(dev, "type %#x is not a flash LED module\n", val);
> +		return -ENODEV;
> +	}
> +
> +	rc = regmap_read(regmap, reg_base + FLASH_SUBTYPE_REG, &val);
> +	if (rc < 0) {
> +		dev_err(dev, "Read flash LED module subtype failed, rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	if (val == FLASH_SUBTYPE_3CH_VAL) {
> +		chip->hw_type = QCOM_MVFLASH_3CH;
> +		chip->max_channels = 3;
> +		regs = mvflash_3ch_regs;
> +	} else if (val == FLASH_SUBTYPE_4CH_VAL) {
> +		chip->hw_type = QCOM_MVFLASH_4CH;
> +		chip->max_channels = 4;
> +		regs = mvflash_4ch_regs;
> +	} else {
> +		dev_err(dev, "flash LED subtype %#x is not yet supported\n", val);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < REG_MAX_COUNT; i++)
> +		regs[i].reg += reg_base;
> +
> +	rc = devm_regmap_field_bulk_alloc(dev, regmap, chip->r_fields, regs, REG_MAX_COUNT);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to allocate regmap field, rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	chip->dev = dev;
> +	platform_set_drvdata(pdev, chip);
> +	mutex_init(&chip->lock);
> +
> +	count = device_get_child_node_count(dev);
> +	if (count == 0 || count > chip->max_channels) {
> +		dev_err(dev, "No child or child count exceeds %d\n", chip->max_channels);
> +		return -EINVAL;
> +	}
> +
> +	chip->leds = devm_kcalloc(dev, count, sizeof(*chip->leds), GFP_KERNEL);
> +	if (!chip->leds)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node(dev, child) {
> +		led = &chip->leds[chip->leds_count];
> +		led->priv_data = chip;
> +
> +		rc = qcom_flash_register_led_device(dev, child, led);
> +		if (rc < 0)
> +			goto release;
> +
> +		chip->leds_count++;
> +	}
> +
> +	return 0;
> +
> +release:
> +	while (chip->leds && chip->leds_count--)
> +		v4l2_flash_release(chip->leds[chip->leds_count].v4l2_flash);
> +	return rc;
> +}
> +
> +static int qcom_flash_led_remove(struct platform_device *pdev)
> +{
> +	struct qcom_flash_chip *chip = platform_get_drvdata(pdev);
> +
> +	while (chip->leds_count--)
> +		v4l2_flash_release(chip->leds[chip->leds_count].v4l2_flash);
> +
> +	mutex_destroy(&chip->lock);
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_flash_led_match_table[] = {
> +	{ .compatible = "qcom,spmi-flash-led" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, qcom_flash_led_match_table);
> +static struct platform_driver qcom_flash_led_driver = {
> +	.driver = {
> +		.name = "leds-qcom-flash",
> +		.of_match_table = qcom_flash_led_match_table,
> +	},
> +	.probe = qcom_flash_led_probe,
> +	.remove = qcom_flash_led_remove,
> +};
> +
> +module_platform_driver(qcom_flash_led_driver);
> +
> +MODULE_DESCRIPTION("QCOM Flash LED driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]
