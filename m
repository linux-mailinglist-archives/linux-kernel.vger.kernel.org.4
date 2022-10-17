Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AA5600DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJQLmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiJQLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:42:11 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED34686F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:42:08 -0700 (PDT)
Received: from cp.tophost.it (vm1054.cs12.seeweb.it [217.64.195.253])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 3DCF11F4DD;
        Mon, 17 Oct 2022 13:42:06 +0200 (CEST)
MIME-Version: 1.0
Date:   Mon, 17 Oct 2022 13:27:36 +0200
From:   konrad.dybcio@somainline.org
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
Subject: Re: [PATCH v7 2/2] input: add Qualcomm SPMI haptics driver
In-Reply-To: <20221015172915.1436236-3-caleb@connolly.tech>
References: <20221015172915.1436236-3-caleb@connolly.tech>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <86abaebaaeff3bfeafc3fff8a069256e@pop.somainline.org>
X-Sender: konrad.dybcio@somainline.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-15 19:30, Caleb Connolly wrote:
> Add support for the haptics found in pmi8998 and related PMICs.
> Based on the ff-memless interface. Currently this driver provides
> a partial implementation of hardware features.
> 
> This driver only supports LRAs (Linear Resonant Actuators) in the 
> "buffer"
> mode with a single wave pattern.
> 
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  drivers/input/misc/Kconfig                |  15 +
>  drivers/input/misc/Makefile               |   1 +
>  drivers/input/misc/qcom-pmi8998-haptics.c | 690 ++++++++++++++++++++++
>  3 files changed, 706 insertions(+)
>  create mode 100644 drivers/input/misc/qcom-pmi8998-haptics.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index a18ab7358d8f..608a64fa7914 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -186,6 +186,21 @@ config INPUT_PMIC8XXX_PWRKEY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pmic8xxx-pwrkey.
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
>  config INPUT_SPARCSPKR
>  	tristate "SPARC Speaker support"
>  	depends on PCI && SPARC64
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 28dfc444f0a9..039d0a97f2f4 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+= 
> pmic8xxx-pwrkey.o
>  obj-$(CONFIG_INPUT_POWERMATE)		+= powermate.o
>  obj-$(CONFIG_INPUT_PWM_BEEPER)		+= pwm-beeper.o
>  obj-$(CONFIG_INPUT_PWM_VIBRA)		+= pwm-vibra.o
> +obj-$(CONFIG_INPUT_QCOM_PMI8998_HAPTICS)+= qcom-pmi8998-haptics.o
>  obj-$(CONFIG_INPUT_RAVE_SP_PWRBUTTON)	+= rave-sp-pwrbutton.o
>  obj-$(CONFIG_INPUT_RB532_BUTTON)	+= rb532_button.o
>  obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)	+= regulator-haptic.o
> diff --git a/drivers/input/misc/qcom-pmi8998-haptics.c
> b/drivers/input/misc/qcom-pmi8998-haptics.c
> new file mode 100644
> index 000000000000..e9eec2d9de2d
> --- /dev/null
> +++ b/drivers/input/misc/qcom-pmi8998-haptics.c
> @@ -0,0 +1,690 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Caleb Connolly <caleb@connolly.tech>
> + * Qualcomm QPMI haptics driver for pmi8998 and related PMICs.
Did they actually call it QPMI or was it supposed to be SPMI?


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
Not sure if that was meant to be here?


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
Unless something changed, all comments should be /* C-style */

[...]

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
IMO the ternary operator here is really forced.. maybe an 'if' would be
more readable


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
/*
  * This is..


> +	 * are left to allow future additions
> +	 */
> +	haptics->actuator_type = HAP_TYPE_LRA;
> +	haptics->play_mode = HAP_PLAY_BUFFER;
> +	haptics->wave_shape = HAP_WAVE_SINE;
> +	haptics->current_limit = HAP_ILIM_400_MA;
> +
> +	ret = device_property_read_u32(haptics->dev, 
> "qcom,wave-play-rate-us",
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
typo: circuit

> +	ret = devm_request_threaded_irq(haptics->dev, irq, NULL, 
> haptics_sc_irq,
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
> +static SIMPLE_DEV_PM_OPS(spmi_haptics_pm_ops, spmi_haptics_suspend, 
> NULL);
> +
> +static int spmi_haptics_remove(struct platform_device *pdev)
> +{
> +	struct spmi_haptics *haptics = dev_get_drvdata(&pdev->dev);
> +
> +	cancel_work_sync(&haptics->work);
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
I have mixed feelings about calling this "SPMI haptics" instead of 
something like
"QCOM SPMI haptics" with SPMI being used on all kinds of platforms, but 
ultimately
I don't think it's that much of an issue, the compatible says it all.

Konrad

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
