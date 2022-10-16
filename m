Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8F65FFFB6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJPNyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJPNyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:54:50 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD31B1659F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 06:54:44 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id k468oUBNIEkSDk468oMuHO; Sun, 16 Oct 2022 15:54:42 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Oct 2022 15:54:42 +0200
X-ME-IP: 86.243.100.34
Message-ID: <812d099f-2fdd-9213-edb6-b7fe6fe07f62@wanadoo.fr>
Date:   Sun, 16 Oct 2022 15:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7 2/2] input: add Qualcomm SPMI haptics driver
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     krzysztof.kozlowski@linaro.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rob Herring <robh+dt@kernel.org>, Tom Rix <trix@redhat.com>
References: <20221015172915.1436236-3-caleb@connolly.tech>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221015172915.1436236-3-caleb@connolly.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/10/2022 à 19:30, Caleb Connolly a écrit :
> Add support for the haptics found in pmi8998 and related PMICs.
> Based on the ff-memless interface. Currently this driver provides
> a partial implementation of hardware features.
> 
> This driver only supports LRAs (Linear Resonant Actuators) in the "buffer"
> mode with a single wave pattern.

Hi,
some nitpick below, should there be a v8.

CJ

> 
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>   drivers/input/misc/Kconfig                |  15 +
>   drivers/input/misc/Makefile               |   1 +
>   drivers/input/misc/qcom-pmi8998-haptics.c | 690 ++++++++++++++++++++++
>   3 files changed, 706 insertions(+)
>   create mode 100644 drivers/input/misc/qcom-pmi8998-haptics.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index a18ab7358d8f..608a64fa7914 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -186,6 +186,21 @@ config INPUT_PMIC8XXX_PWRKEY
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called pmic8xxx-pwrkey.
> 
> +config INPUT_QCOM_PMI8998_HAPTICS
> +	tristate "Qualcomm SPMI HAPTICS"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on MFD_PM8XXX || MFD_SPMI_PMIC || COMPILE_TEST
> +	select INPUT_FF_MEMLESS
> +	help
> +	  This option enables support for the haptics found in pmi8998 and
> +	  related PMICs. Based on the ff-memless interface.
> +
> +	  This driver is for hardware too new for the INPUT_PM8XXX_VIBRATOR
> +	  driver.
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called qcom_pmi8998_haptics.
> +
>   config INPUT_SPARCSPKR
>   	tristate "SPARC Speaker support"
>   	depends on PCI && SPARC64
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 28dfc444f0a9..039d0a97f2f4 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+= pmic8xxx-pwrkey.o
>   obj-$(CONFIG_INPUT_POWERMATE)		+= powermate.o
>   obj-$(CONFIG_INPUT_PWM_BEEPER)		+= pwm-beeper.o
>   obj-$(CONFIG_INPUT_PWM_VIBRA)		+= pwm-vibra.o
> +obj-$(CONFIG_INPUT_QCOM_PMI8998_HAPTICS)+= qcom-pmi8998-haptics.o
>   obj-$(CONFIG_INPUT_RAVE_SP_PWRBUTTON)	+= rave-sp-pwrbutton.o
>   obj-$(CONFIG_INPUT_RB532_BUTTON)	+= rb532_button.o
>   obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)	+= regulator-haptic.o
> diff --git a/drivers/input/misc/qcom-pmi8998-haptics.c b/drivers/input/misc/qcom-pmi8998-haptics.c
> new file mode 100644
> index 000000000000..e9eec2d9de2d
> --- /dev/null
> +++ b/drivers/input/misc/qcom-pmi8998-haptics.c
> @@ -0,0 +1,690 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Caleb Connolly <caleb@connolly.tech>
> + * Qualcomm QPMI haptics driver for pmi8998 and related PMICs.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/errno.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +// clang-format off
> +#define HAP_STATUS_1_REG		0x0A
> +#define HAP_BUSY_BIT			BIT(1)
> +#define SC_FLAG_BIT			BIT(3)
> +#define AUTO_RES_ERROR_BIT		BIT(4)
> +
> +#define HAP_LRA_AUTO_RES_LO_REG		0x0B
> +#define HAP_LRA_AUTO_RES_HI_REG		0x0C
> +
> +#define HAP_EN_CTL_REG			0x46
> +#define HAP_EN_BIT			BIT(7)
> +
> +#define HAP_EN_CTL2_REG			0x48
> +#define BRAKE_EN_BIT			BIT(0)
> +
> +#define HAP_AUTO_RES_CTRL_REG		0x4B
> +#define AUTO_RES_EN_BIT			BIT(7)
> +#define AUTO_RES_ERR_RECOVERY_BIT	BIT(3)
> +#define AUTO_RES_EN_FLAG_BIT		BIT(0)
> +
> +#define HAP_CFG1_REG			0x4C
> +#define HAP_ACT_TYPE_MASK		BIT(0)
> +
> +#define HAP_CFG2_REG			0x4D
> +#define HAP_LRA_RES_TYPE_MASK		BIT(0)
> +
> +#define HAP_SEL_REG			0x4E
> +#define HAP_WF_SOURCE_MASK		GENMASK(5, 4)
> +#define HAP_WF_SOURCE_SHIFT		4
> +
> +#define HAP_LRA_AUTO_RES_REG		0x4F
> +#define LRA_AUTO_RES_MODE_MASK		GENMASK(6, 4)
> +#define LRA_AUTO_RES_MODE_SHIFT		4
> +#define LRA_HIGH_Z_MASK			GENMASK(3, 2)
> +#define LRA_HIGH_Z_SHIFT		2
> +#define LRA_RES_CAL_MASK		GENMASK(1, 0)
> +#define HAP_RES_CAL_PERIOD_MIN		4
> +#define HAP_RES_CAL_PERIOD_MAX		32
> +
> +#define HAP_VMAX_CFG_REG		0x51
> +#define HAP_VMAX_OVD_BIT		BIT(6)
> +#define HAP_VMAX_MASK			GENMASK(5, 1)
> +#define HAP_VMAX_SHIFT			1
> +
> +#define HAP_ILIM_CFG_REG		0x52
> +#define HAP_ILIM_SEL_MASK		BIT(0)
> +#define HAP_ILIM_400_MA			0
> +#define HAP_ILIM_800_MA			1
> +
> +#define HAP_SC_DEB_REG			0x53
> +#define HAP_SC_DEB_MASK			GENMASK(2, 0)
> +#define HAP_SC_DEB_CYCLES_MIN		0
> +#define HAP_DEF_SC_DEB_CYCLES		8
> +#define HAP_SC_DEB_CYCLES_MAX		32
> +
> +#define HAP_RATE_CFG1_REG		0x54
> +#define HAP_RATE_CFG1_MASK		GENMASK(7, 0)
> +#define HAP_RATE_CFG2_SHIFT		8 // As CFG2 is the most significant byte
> +
> +#define HAP_RATE_CFG2_REG		0x55
> +#define HAP_RATE_CFG2_MASK		GENMASK(3, 0)
> +
> +#define HAP_SC_CLR_REG			0x59
> +#define SC_CLR_BIT			BIT(0)
> +
> +#define HAP_BRAKE_REG			0x5C
> +#define HAP_BRAKE_PAT_MASK		0x3
> +
> +#define HAP_WF_REPEAT_REG		0x5E
> +#define WF_REPEAT_MASK			GENMASK(6, 4)
> +#define WF_REPEAT_SHIFT			4
> +#define WF_REPEAT_MIN			1
> +#define WF_REPEAT_MAX			128
> +#define WF_S_REPEAT_MASK		GENMASK(1, 0)
> +#define WF_S_REPEAT_MIN			1
> +#define WF_S_REPEAT_MAX			8
> +
> +#define HAP_WF_S1_REG			0x60
> +#define HAP_WF_SIGN_BIT			BIT(7)
> +#define HAP_WF_OVD_BIT			BIT(6)
> +#define HAP_WF_SAMP_MAX			GENMASK(5, 1)
> +#define HAP_WF_SAMPLE_LEN		8
> +
> +#define HAP_PLAY_REG			0x70
> +#define HAP_PLAY_BIT			BIT(7)
> +#define HAP_PAUSE_BIT			BIT(0)
> +
> +#define HAP_SEC_ACCESS_REG		0xD0
> +#define HAP_SEC_ACCESS_UNLOCK		0xA5
> +
> +#define HAP_TEST2_REG			0xE3
> +
> +
> +#define HAP_VMAX_MIN_MV			116
> +#define HAP_VMAX_MAX_MV			3596
> +#define HAP_VMAX_MAX_MV_STRONG		3596
> +
> +#define HAP_WAVE_PLAY_RATE_MIN_US	0
> +#define HAP_WAVE_PLAY_RATE_MAX_US	20475
> +#define HAP_WAVE_PLAY_TIME_MAX_MS	15000
> +
> +#define AUTO_RES_ERR_POLL_TIME_NS	(20 * NSEC_PER_MSEC)
> +#define HAPTICS_BACK_EMF_DELAY_US	20000
> +
> +#define HAP_BRAKE_PAT_LEN		4
> +#define HAP_WAVE_SAMP_LEN		8
> +#define NUM_WF_SET			4
> +#define HAP_WAVE_SAMP_SET_LEN		(HAP_WAVE_SAMP_LEN * NUM_WF_SET)
> +#define HAP_RATE_CFG_STEP_US		5
> +
> +#define SC_MAX_COUNT			5
> +#define SC_COUNT_RST_DELAY_US		1000000
> +
> +// Actuator types
> +#define HAP_TYPE_LRA			0
> +#define HAP_TYPE_ERM			1
> +
> +// LRA Wave type
> +#define HAP_WAVE_SINE			0
> +#define HAP_WAVE_SQUARE			1
> +
> +// Play modes
> +#define HAP_PLAY_DIRECT			0
> +#define HAP_PLAY_BUFFER			1
> +#define HAP_PLAY_AUDIO			2
> +#define HAP_PLAY_PWM			3
> +
> +#define HAP_PLAY_MAX			HAP_PLAY_PWM
> +
> +// Auto resonance type
> +#define HAP_AUTO_RES_NONE		0
> +#define HAP_AUTO_RES_ZXD		1
> +#define HAP_AUTO_RES_QWD		2
> +#define HAP_AUTO_RES_MAX_QWD		3
> +#define HAP_AUTO_RES_ZXD_EOP		4
> +// clang-format on
> +
> +static const uint8_t default_brake_pattern[] = {
> +	0x3, 0x3, 0x3, 0x3, 0x3,
> +};
> +
> +static const uint8_t wave_sample_pattern[] = {
> +	0x7e, 0x7e, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28,
> +};
> +
> +/**
> + * struct spmi_haptics - struct for spmi haptics data.
> + *
> + * @dev: Our device parent.
> + * @regmap: Register map for the hardware block.
> + * @input: The input device used to receive events.
> + * @work: Work struct to play effects.
> + * @base: Base address of the regmap.
> + * @play_irq: Fired to load the next wave pattern.
> + * @sc_irq: Short circuit irq.
> + * @last_sc_time: Time since the short circuit IRQ last fired.
> + * @sc_count: Number of times the short circuit IRQ has fired in this interval.
> + * @actuator_type: The type of actuator in use.
> + * @wave_shape: The shape of the waves to use (sine or square).
> + * @play_mode: The play mode to use (direct, buffer, pwm, audio).
> + * @vmax: Max voltage to use when playing.
> + * @current_limit: The current limit for this hardware (400mA or 800mA).
> + * @play_wave_rate: The wave rate to use for this hardware.
> + * @play_lock: Lock to be held when updating the hardware state.
> + */
> +struct spmi_haptics {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct input_dev *input;
> +	struct work_struct work;
> +	uint32_t base;
> +
> +	int play_irq;
> +	int sc_irq;
> +	ktime_t last_sc_time;
> +	uint8_t sc_count;
> +
> +	uint8_t actuator_type;
> +	uint8_t wave_shape;
> +	uint8_t play_mode;
> +	uint32_t vmax;
> +	uint32_t current_limit;
> +	uint32_t play_wave_rate;
> +	struct mutex play_lock;
> +};
> +
> +static int haptics_write_vmax(struct spmi_haptics *haptics)
> +{
> +	uint8_t val = 0;

no need to set val to 0.

> +	uint32_t vmax_mv = haptics->vmax;
> +
> +	vmax_mv = clamp_t(uint32_t, vmax_mv, HAP_VMAX_MIN_MV, HAP_VMAX_MAX_MV);
> +	vmax_mv = DIV_ROUND_CLOSEST(vmax_mv, HAP_VMAX_MIN_MV);
> +
> +	val = FIELD_PREP(HAP_VMAX_MASK, vmax_mv);
> +
> +	return regmap_update_bits(haptics->regmap,
> +				  haptics->base + HAP_VMAX_CFG_REG,
> +				  HAP_VMAX_MASK | HAP_WF_OVD_BIT, val);
> +}
> +
> +static int haptics_module_enable(struct spmi_haptics *haptics, bool enable)
> +{
> +	return regmap_update_bits(haptics->regmap,
> +				  haptics->base + HAP_EN_CTL_REG, HAP_EN_BIT,
> +				  enable ? HAP_EN_BIT : 0);
> +}
> +
> +static int haptics_play(struct spmi_haptics *haptics, bool play)
> +{
> +	return regmap_update_bits(haptics->regmap, haptics->base + HAP_PLAY_REG,
> +				  HAP_PLAY_BIT | HAP_PAUSE_BIT,
> +				  play ? HAP_PLAY_BIT : 0);
> +}
> +
> +static bool is_haptics_module_enabled(struct spmi_haptics *haptics)
> +{
> +	uint32_t val;
> +
> +	regmap_read(haptics->regmap, haptics->base + HAP_EN_CTL_REG, &val);
> +	return !!val;
> +}
> +
> +/*
> + * This IRQ is fired to tell us to load the next wave sample set.
> + * As we only currently support a single sample set, it's unused.
> + */
> +static irqreturn_t haptics_play_irq(int irq, void *data)
> +{
> +	struct spmi_haptics *haptics = data;
> +
> +	dev_dbg(haptics->dev, "play_irq triggered");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Fires every ~50ms whilst the haptics are active.
> + * If the SC_FLAG_BIT is set then that means there isn't a short circuit
> + * and we just need to clear the IRQ to indicate that the device should
> + * keep vibrating.
> + *
> + * Otherwise, it means a short circuit situation has occurred.
> + */
> +static irqreturn_t haptics_sc_irq(int irq, void *data)
> +{
> +	struct spmi_haptics *haptics = data;
> +	int ret;
> +	uint32_t val;
> +	long sc_delta_time_us;
> +	ktime_t temp;
> +
> +	mutex_lock(&haptics->play_lock);
> +
> +	ret = regmap_read(haptics->regmap, haptics->base + HAP_STATUS_1_REG,
> +			  &val);
> +	if (ret)
> +		goto out;
> +
> +	if (!(val & SC_FLAG_BIT)) {
> +		haptics->sc_count = 0;
> +		goto out;
> +	}
> +
> +	temp = ktime_get();
> +	sc_delta_time_us = ktime_us_delta(temp, haptics->last_sc_time);
> +	haptics->last_sc_time = temp;
> +
> +	if (sc_delta_time_us > SC_COUNT_RST_DELAY_US)
> +		haptics->sc_count = 0;
> +	else
> +		haptics->sc_count++;
> +
> +	ret = regmap_update_bits(haptics->regmap,
> +				 haptics->base + HAP_SC_CLR_REG, SC_CLR_BIT,
> +				 SC_CLR_BIT);
> +	if (ret)
> +		goto out;
> +
> +	if (haptics->sc_count > SC_MAX_COUNT) {
> +		cancel_work_sync(&haptics->work);
> +		dev_err(haptics->dev,
> +			"Short circuit persists, disabling haptics\n");
> +		ret = haptics_module_enable(haptics, false);
> +		if (ret)
> +			dev_err(haptics->dev, "Error disabling module, rc=%d\n",
> +				ret);
> +	}
> +
> +out:
> +	mutex_unlock(&haptics->play_lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static int haptics_vibrate(struct spmi_haptics *haptics)
> +{
> +	int ret;
> +
> +	if (haptics->sc_count > SC_MAX_COUNT) {
> +		dev_err(haptics->dev, "Can't play while in short circuit");
> +		return -EINVAL;
> +	}
> +
> +	ret = haptics_write_vmax(haptics);
> +	if (ret)
> +		return ret;
> +
> +	ret = haptics_module_enable(haptics, true);
> +	if (ret) {
> +		dev_err(haptics->dev, "Error enabling module, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = haptics_play(haptics, true);
> +	if (ret) {
> +		dev_err(haptics->dev, "Error enabling play, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;

Be more explicit with "return 0;"?

> +}
> +
> +static int haptics_stop_vibrate(struct spmi_haptics *haptics)
> +{
> +	int ret;
> +
> +	ret = haptics_play(haptics, false);
> +	if (ret) {
> +		dev_err(haptics->dev, "Error disabling play, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = haptics_module_enable(haptics, false);
> +	if (ret) {
> +		dev_err(haptics->dev, "Error disabling module, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;

Be more explicit with "return 0;"?

> +}
> +
> +static void haptics_play_stop_work(struct work_struct *work)
> +{
> +	struct spmi_haptics *haptics =
> +		container_of(work, struct spmi_haptics, work);
> +

No need for blanck line.

> +	int ret;
> +
> +	mutex_lock(&haptics->play_lock);
> +
> +	if (!is_haptics_module_enabled(haptics) && haptics->vmax)
> +		ret = haptics_vibrate(haptics);
> +	else
> +		ret = haptics_stop_vibrate(haptics);
> +	if (ret)
> +		dev_err(haptics->dev, "Error setting haptics, ret=%d", ret);
> +
> +	mutex_unlock(&haptics->play_lock);
> +}
> +
> +static int spmi_haptics_play_effect(struct input_dev *dev, void *data,
> +				    struct ff_effect *effect)
> +{
> +	struct spmi_haptics *haptics = input_get_drvdata(dev);
> +	uint32_t magnitude;
> +
> +	dev_dbg(haptics->dev, "%s: Rumbling with strong: %d and weak: %d",
> +		 __func__, effect->u.rumble.strong_magnitude,
> +		 effect->u.rumble.weak_magnitude);
> +
> +	magnitude = effect->u.rumble.strong_magnitude >> 8;
> +	if (!magnitude)
> +		magnitude = effect->u.rumble.weak_magnitude >> 10;
> +
> +	if (!magnitude)
> +		haptics->vmax = 0;
> +	else
> +		haptics->vmax =
> +			((HAP_VMAX_MAX_MV - HAP_VMAX_MIN_MV) * magnitude) /
> +				100 +
> +			HAP_VMAX_MIN_MV;
> +
> +	schedule_work(&haptics->work);
> +
> +	return 0;
> +}
> +
> +/**
> + * spmi_haptics_close - callback for input device close
> + * @dev: input device pointer
> + *
> + * Turns off the vibrator.
> + */
> +static void spmi_haptics_close(struct input_dev *dev)
> +{
> +	struct spmi_haptics *haptics = input_get_drvdata(dev);
> +
> +	cancel_work_sync(&haptics->work);
> +	haptics->vmax = 0;
> +
> +	if (is_haptics_module_enabled(haptics))
> +		haptics_stop_vibrate(haptics);
> +}
> +
> +static int haptics_write_brake_pattern(struct spmi_haptics *haptics,
> +				       const uint8_t *brake_pattern)
> +{
> +	int ret, i;
> +	uint8_t val = 0;
> +
> +	for (i = HAP_BRAKE_PAT_LEN - 1; i >= 0; i--)
> +		val |= FIELD_PREP(HAP_BRAKE_PAT_MASK, brake_pattern[i])
> +		       << (i * 2);
> +
> +	ret = regmap_update_bits(haptics->regmap, haptics->base + HAP_BRAKE_REG,
> +				 0xff, val);
> +
> +	return ret   ?:
> +		       regmap_update_bits(haptics->regmap,
> +					  haptics->base + HAP_EN_CTL2_REG,
> +					  BRAKE_EN_BIT, BRAKE_EN_BIT);
> +}
> +
> +static int haptics_init(struct spmi_haptics *haptics)
> +{
> +	int ret;
> +	uint8_t val, mask;
> +	uint16_t play_rate;
> +
> +	ret = regmap_update_bits(haptics->regmap, haptics->base + HAP_CFG1_REG,
> +				 HAP_ACT_TYPE_MASK, haptics->actuator_type);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure auto resonance
> +	 * see qpnp_haptics_lra_auto_res_config downstream
> +	 * This is greatly simplified.
> +	 */
> +	val = FIELD_PREP(LRA_RES_CAL_MASK, ilog2(32 / HAP_RES_CAL_PERIOD_MIN)) |
> +	      FIELD_PREP(LRA_AUTO_RES_MODE_MASK, HAP_AUTO_RES_ZXD_EOP) |
> +	      FIELD_PREP(LRA_HIGH_Z_MASK, 1);
> +	mask = LRA_AUTO_RES_MODE_MASK | LRA_HIGH_Z_MASK | LRA_RES_CAL_MASK;
> +
> +	ret = regmap_update_bits(haptics->regmap,
> +				 haptics->base + HAP_LRA_AUTO_RES_REG, mask,
> +				 val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(HAP_WF_SOURCE_MASK, haptics->play_mode);
> +	ret = regmap_update_bits(haptics->regmap, haptics->base + HAP_SEL_REG,
> +				 HAP_WF_SOURCE_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(haptics->regmap,
> +				 haptics->base + HAP_ILIM_CFG_REG,
> +				 HAP_ILIM_SEL_MASK, haptics->current_limit);
> +	if (ret)
> +		return ret;
> +
> +	/* Configure the debounce for short-circuit detection. */
> +	ret = regmap_update_bits(haptics->regmap,
> +				 haptics->base + HAP_SC_DEB_REG,
> +				 HAP_SC_DEB_MASK, HAP_SC_DEB_CYCLES_MAX);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(haptics->regmap, haptics->base + HAP_CFG2_REG,
> +				 HAP_LRA_RES_TYPE_MASK, haptics->wave_shape);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure RATE_CFG1 and RATE_CFG2 registers.
> +	 * Note: For ERM (unsupported) these registers act as play rate and
> +	 * for LRA these represent resonance period
> +	 */
> +	play_rate = haptics->play_wave_rate / HAP_RATE_CFG_STEP_US;
> +	val = FIELD_PREP(HAP_RATE_CFG1_MASK, play_rate);
> +	ret = regmap_update_bits(haptics->regmap,
> +				 haptics->base + HAP_RATE_CFG1_REG,
> +				 HAP_RATE_CFG1_MASK, val);
> +	val = FIELD_PREP(HAP_RATE_CFG2_MASK, play_rate >> 8);
> +	ret = ret   ?:
> +		      regmap_update_bits(haptics->regmap,
> +					 haptics->base + HAP_RATE_CFG2_REG,
> +					 HAP_RATE_CFG1_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = haptics_write_brake_pattern(haptics, default_brake_pattern);
> +	if (ret)
> +		return ret;
> +
> +	/* Currently this is the only supported play mode */
> +	if (haptics->play_mode == HAP_PLAY_BUFFER) {
> +		/* zero repeats and zero sample repeats */
> +		val = FIELD_PREP(WF_REPEAT_MASK, 0) |
> +		      FIELD_PREP(WF_S_REPEAT_MASK, 0);
> +		ret = regmap_update_bits(haptics->regmap,
> +					 haptics->base + HAP_WF_REPEAT_REG,
> +					 WF_REPEAT_MASK | WF_S_REPEAT_MASK,
> +					 val);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_bulk_write(haptics->regmap,
> +					haptics->base + HAP_WF_S1_REG,
> +					wave_sample_pattern, HAP_WAVE_SAMP_LEN);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int spmi_haptics_probe(struct platform_device *pdev)
> +{
> +	struct spmi_haptics *haptics;
> +	struct input_dev *input_dev;
> +	int ret, irq;
> +
> +	haptics = devm_kzalloc(&pdev->dev, sizeof(*haptics), GFP_KERNEL);
> +	if (!haptics)
> +		return -ENOMEM;
> +
> +	haptics->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!haptics->regmap)
> +		return -ENODEV;
> +
> +	haptics->dev = &pdev->dev;
> +
> +	platform_set_drvdata(pdev, haptics);
> +
> +	ret = device_property_read_u32(haptics->dev, "reg", &haptics->base);
> +	if (ret)
> +		return dev_err_probe(haptics->dev, ret,
> +				     "Couldn't read base address");
> +
> +	/* This is the only currently supported configuration, these values

Missing new line after \* ?

> +	 * are left to allow future additions
> +	 */
> +	haptics->actuator_type = HAP_TYPE_LRA;
> +	haptics->play_mode = HAP_PLAY_BUFFER;
> +	haptics->wave_shape = HAP_WAVE_SINE;
> +	haptics->current_limit = HAP_ILIM_400_MA;
> +
> +	ret = device_property_read_u32(haptics->dev, "qcom,wave-play-rate-us",
> +				       &haptics->play_wave_rate);
> +	if (ret)
> +		return dev_err_probe(haptics->dev, ret,
> +				     "qcom,wave-play-rate-us is required\n");
> +
> +	INIT_WORK(&haptics->work, haptics_play_stop_work);
> +
> +	ret = haptics_init(haptics);
> +	if (ret)
> +		return ret;
> +
> +	input_dev = devm_input_allocate_device(&pdev->dev);
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	input_dev->name = "spmi_haptics";
> +	input_dev->id.version = 1;
> +	input_dev->close = spmi_haptics_close;
> +	input_set_drvdata(input_dev, haptics);
> +
> +	haptics->input = input_dev;
> +
> +	/* In the future this should become FF_PERIODIC */
> +	input_set_capability(haptics->input, EV_FF, FF_RUMBLE);
> +
> +	ret = input_ff_create_memless(input_dev, NULL,
> +				      spmi_haptics_play_effect);
> +	if (ret)
> +		return dev_err_probe(
> +			&pdev->dev, ret,
> +			"Couldn't register haptics as EV_FF device\n");
> +
> +	ret = input_register_device(input_dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Couldn't register input device\n");
> +
> +	/* NOTE: the play IRQ is only used for buffer mode */
> +	irq = platform_get_irq_byname(pdev, "play");
> +	if (irq < 0) {
> +		return dev_err_probe(&pdev->dev, irq,
> +				     "Unable to get play irq\n");
> +	}

No need for { }.

> +	ret = devm_request_threaded_irq(haptics->dev, irq, NULL,
> +					haptics_play_irq, IRQF_ONESHOT,
> +					"haptics_play_irq", haptics);
> +	if (ret)
> +		return dev_err_probe(haptics->dev, ret,
> +				     "Couldn't request play irq\n");
> +
> +	irq = platform_get_irq_byname(pdev, "short");
> +	if (irq < 0)
> +		return dev_err_probe(&pdev->dev, irq,
> +				     "Unable to get short circut irq\n");
> +	ret = devm_request_threaded_irq(haptics->dev, irq, NULL, haptics_sc_irq,
> +					IRQF_ONESHOT, "haptics_short_irq",
> +					haptics);
> +	if (ret)
> +		return dev_err_probe(haptics->dev, ret,
> +				     "Couldn't request short circuit irq\n");
> +
> +	mutex_init(&haptics->play_lock);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused spmi_haptics_suspend(struct device *dev)
> +{
> +	struct spmi_haptics *haptics = dev_get_drvdata(dev);
> +
> +	cancel_work_sync(&haptics->work);
> +	haptics_stop_vibrate(haptics);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(spmi_haptics_pm_ops, spmi_haptics_suspend, NULL);
> +
> +static int spmi_haptics_remove(struct platform_device *pdev)
> +{
> +	struct spmi_haptics *haptics = dev_get_drvdata(&pdev->dev);
> +
> +	cancel_work_sync(&haptics->work);

Harmless and certainly more explicit this way, but is it needed?
spmi_haptics_close() already calls it (and I guess that it is called by 
input_unregister_device() below)

> +	mutex_destroy(&haptics->play_lock);
> +	input_unregister_device(haptics->input);
> +
> +	return 0;
> +}
> +
> +static void spmi_haptics_shutdown(struct platform_device *pdev)
> +{
> +	struct spmi_haptics *haptics = dev_get_drvdata(&pdev->dev);
> +
> +	cancel_work_sync(&haptics->work);
> +	haptics_stop_vibrate(haptics);
> +}
> +
> +static const struct of_device_id spmi_haptics_match_table[] = {
> +	{ .compatible = "qcom,pmi8998-haptics" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, spmi_haptics_match_table);
> +
> +static struct platform_driver spmi_haptics_driver = {
> +	.probe		= spmi_haptics_probe,
> +	.remove		= spmi_haptics_remove,
> +	.shutdown	= spmi_haptics_shutdown,
> +	.driver		= {
> +		.name	= "spmi-haptics",
> +		.pm	= &spmi_haptics_pm_ops,
> +		.of_match_table = spmi_haptics_match_table,
> +	},
> +};
> +module_platform_driver(spmi_haptics_driver);
> +
> +MODULE_DESCRIPTION("spmi haptics driver using ff-memless framework");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Caleb Connolly <caleb@connolly.tech>");
> --
> 2.38.0
> 
> 
> 

