Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6864974BE58
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjGHQAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 12:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 12:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA6125;
        Sat,  8 Jul 2023 09:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B18060C96;
        Sat,  8 Jul 2023 16:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B4BC433C7;
        Sat,  8 Jul 2023 15:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688832009;
        bh=GifulMvU5m6h49AE1BgpWViYZeT9ct6TM3z7xLfpLj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gw/VIoP9JV57GytRzQjDH9w5G0CdhhM1uDx1qIETXUlZ/cTZcwWGC7J0pUJWt5iIc
         GCj+cORLQBkaR+EPAmJ5ytnNSBSWm+iRAaUhqxvATW43tSJ7XjKQPPnW9vsvCylWEl
         x2RDlr8mkISHIhbSTqsgOXLgi6OqTP5PhA7dftGjcBA+cqq22El10MuqyTKT+uEt2r
         8emnfLF0F72tMhmrMiUW4/fvyCnaUgNtTpVFvNKn5kTc3UgzsR8KQnWhdWHYqxbs00
         n+sJ10t0wfcj/lTebSIn1GVRATkBsNjJc1EJqCy8+q3dcXxjMIIb4SYUCxOtRlJAOq
         0gd1MRZTJqXCw==
Date:   Sat, 8 Jul 2023 16:59:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Ibrahim Tilki" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
Subject: Re: [PATCH 07/11] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20230708165955.08c1159c@jic23-huawei>
In-Reply-To: <20230708072835.3035398-8-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
        <20230708072835.3035398-8-quic_jprakash@quicinc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 12:58:31 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS. One major difference is
> that the register interface used here is that of an SDAM present on

What's an SDAM?

> PMK8550. There may be more than one SDAM used for ADC5 Gen3 and each
> has eight channels, which may be used for either immediate reads
> (same functionality as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or
> recurring measurements (same as ADC_TM functionality). In this case,
> we have VADC and ADC_TM functionality combined into the same driver.
> By convention, we reserve the first channel of the first SDAM for
> all immediate reads and use the remaining channels across all SDAMs
> for ADC_TM monitoring functionality.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
Various comments inline.  Some apply in various places but I typically
only call out one or two.

Jonathan

> ---
>  drivers/iio/adc/Kconfig               |   25 +
>  drivers/iio/adc/Makefile              |    1 +
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c | 1193 +++++++++++++++++++++++++
>  3 files changed, 1219 insertions(+)
>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index dc14bde31ac1..bd9d74f7b76b 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -961,6 +961,31 @@ config QCOM_SPMI_ADC5
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called qcom-spmi-adc5.
>  
> +config QCOM_SPMI_ADC5_GEN3
> +	tristate "Qualcomm Technologies Inc. SPMI PMIC5 GEN3 ADC"
> +	depends on SPMI && THERMAL
> +	select REGMAP_SPMI
> +	select QCOM_VADC_COMMON
> +	help
> +	  This is the IIO Voltage PMIC5 Gen3 ADC driver for Qualcomm Technologies Inc. PMICs.
> +
> +	  The driver supports reading multiple channels. The ADC is a 16-bit
> +	  sigma-delta ADC. The hardware supports calibrated results for
> +	  conversion requests and clients include reading voltage phone
> +	  power, on board system thermistors connected to the PMIC ADC,

voltage of phone power supply (perhaps?)

> +	  PMIC die temperature, charger temperature, battery current, USB voltage
> +	  input and voltage signals connected to supported PMIC GPIO pins. The
> +	  hardware supports internal pull-up for thermistors and can choose between
> +	  a 30k, 100k or 400k ohm pull up using the ADC channels.
> +
> +	  In addition, the same driver supports ADC thermal monitoring devices too.
> +	  They appear as thermal zones with multiple trip points. A thermal client sets
> +	  threshold temperature for both warm and cool trips and gets updated when a
> +	  threshold is reached.

Would expect to see thermal maintainers cc'd on a patch adding thermal support.

> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called qcom-spmi-adc5-gen3.
> +
>  config RCAR_GYRO_ADC
>  	tristate "Renesas R-Car GyroADC driver"
>  	depends on ARCH_RCAR_GEN2 || COMPILE_TEST

> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> new file mode 100644
> index 000000000000..fe5515ee8451
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -0,0 +1,1193 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/adc/qcom-vadc-common.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +
> +#define ADC5_GEN3_HS				0x45
> +#define ADC5_GEN3_HS_BUSY			BIT(7)
> +#define ADC5_GEN3_HS_READY			BIT(0)
> +
> +#define ADC5_GEN3_STATUS1			0x46
> +#define ADC5_GEN3_STATUS1_CONV_FAULT		BIT(7)
> +#define ADC5_GEN3_STATUS1_THR_CROSS		BIT(6)
> +#define ADC5_GEN3_STATUS1_EOC			BIT(0)
> +
> +#define ADC5_GEN3_TM_EN_STS			0x47
> +#define ADC5_GEN3_TM_HIGH_STS			0x48
> +#define ADC5_GEN3_TM_LOW_STS			0x49
> +
> +#define ADC5_GEN3_EOC_STS			0x4a
> +#define ADC5_GEN3_EOC_CHAN_0			BIT(0)
> +
> +#define ADC5_GEN3_EOC_CLR			0x4b
> +#define ADC5_GEN3_TM_HIGH_STS_CLR		0x4c
> +#define ADC5_GEN3_TM_LOW_STS_CLR		0x4d
> +#define ADC5_GEN3_CONV_ERR_CLR			0x4e
> +#define ADC5_GEN3_CONV_ERR_CLR_REQ		BIT(0)
> +
> +#define ADC5_GEN3_SID				0x4f
> +#define ADC5_GEN3_SID_MASK			GENMASK(3, 0)
> +
> +#define ADC5_GEN3_PERPH_CH			0x50
> +#define ADC5_GEN3_CHAN_CONV_REQ			BIT(7)
> +
> +#define ADC5_GEN3_TIMER_SEL			0x51
> +#define ADC5_GEN3_TIME_IMMEDIATE		0x1
> +
> +#define ADC5_GEN3_DIG_PARAM			0x52
> +#define ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK	GENMASK(5, 4)
> +#define ADC5_GEN3_DIG_PARAM_CAL_SEL_SHIFT	4
> +#define ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK	GENMASK(3, 2)
> +#define ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_SHIFT	2
> +
> +#define ADC5_GEN3_FAST_AVG			0x53
> +#define ADC5_GEN3_FAST_AVG_CTL_EN		BIT(7)
> +#define ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK	GENMASK(2, 0)
> +
> +#define ADC5_GEN3_ADC_CH_SEL_CTL		0x54
> +#define ADC5_GEN3_DELAY_CTL			0x55
> +#define ADC5_GEN3_HW_SETTLE_DELAY_MASK		0xf
> +
> +#define ADC5_GEN3_CH_EN				0x56
> +#define ADC5_GEN3_HIGH_THR_INT_EN		BIT(1)
> +#define ADC5_GEN3_LOW_THR_INT_EN		BIT(0)
> +
> +#define ADC5_GEN3_LOW_THR0			0x57
> +#define ADC5_GEN3_LOW_THR1			0x58
> +#define ADC5_GEN3_HIGH_THR0			0x59
> +#define ADC5_GEN3_HIGH_THR1			0x5a
> +
> +#define ADC5_GEN3_CH_DATA0(channel)	(0x5c + (channel) * 2)
> +#define ADC5_GEN3_CH_DATA1(channel)	(0x5d + (channel) * 2)
> +
> +#define ADC5_GEN3_CONV_REQ			0xe5
> +#define ADC5_GEN3_CONV_REQ_REQ			BIT(0)
> +
> +#define ADC5_GEN3_SID_OFFSET			0x8
> +#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
> +#define V_CHAN(x)				(((x).sid << ADC5_GEN3_SID_OFFSET) | (x).channel)

FIELD_PREP() makes the cleaner.
Obviously lots of cases of this - one major advantage is you get rid of the offset
defines in favor of the MASK is used for everything.

> +
> +enum adc5_cal_method {
> +	ADC5_NO_CAL = 0,
> +	ADC5_RATIOMETRIC_CAL,
> +	ADC5_ABSOLUTE_CAL
> +};
> +
> +enum adc_time_select {

Why adc, not adc5?

> +	MEAS_INT_DISABLE = 0,
> +	MEAS_INT_IMMEDIATE,
> +	MEAS_INT_50MS,
> +	MEAS_INT_100MS,
> +	MEAS_INT_1S,
> +	MEAS_INT_NONE,
> +};
>
> +/**
> + * struct adc5_channel_prop - ADC channel property.
> + * @channel: channel number, refer to the channel list.
> + * @cal_method: calibration method.
> + * @decimation: sampling rate supported for the channel.
> + * @sid: slave id of PMIC owning the channel.
> + * @prescale: channel scaling performed on the input signal.
> + * @hw_settle_time: the time between AMUX being configured and the
> + *	start of conversion.
> + * @avg_samples: ability to provide single result from the ADC
> + *	that is an average of multiple measurements.
> + * @sdam_index: Index for which SDAM this channel is on.
> + * @scale_fn_type: Represents the scaling function to convert voltage
> + *	physical units desired by the client for the channel.
> + * @datasheet_name: Channel name used in device tree.
> + * @chip: pointer to top-level ADC device structure.
> + * @adc_tm: indicates if the channel is used for TM measurements.
> + * @tm_chan_index: TM channel number used (ranging from 1-7).
> + * @timer: time period of recurring TM measurement.
> + * @tzd: pointer to thermal device corresponding to TM channel.
> + * @high_thr_en: TM high threshold crossing detection enabled.
> + * @low_thr_en: TM low threshold crossing detection enabled.
> + * @last_temp: last temperature that caused threshold violation,
> + *	or a thermal TM channel.
> + * @last_temp_set: indicates if last_temp is stored.
> + */
> +struct adc5_channel_prop {
> +	unsigned int			channel;
> +	enum adc5_cal_method		cal_method;
> +	unsigned int			decimation;
> +	unsigned int			sid;
> +	unsigned int			prescale;
> +	unsigned int			hw_settle_time;
> +	unsigned int			avg_samples;
> +	unsigned int			sdam_index;
> +
> +	enum vadc_scale_fn_type		scale_fn_type;
> +	const char			*datasheet_name;
> +
> +	struct adc5_chip		*chip;
> +	/* TM properties */

Got plenty of space, so spell out TM

> +	bool				adc_tm;
> +	unsigned int			tm_chan_index;
> +	unsigned int			timer;
> +	struct thermal_zone_device	*tzd;
> +	bool				high_thr_en;
> +	bool				low_thr_en;
> +	int				last_temp;
> +	bool				last_temp_set;
> +};
> +
> +/**
> + * struct adc5_chip - ADC private structure.
> + * @regmap: SPMI ADC5 Gen3 peripheral register map field.
> + * @dev: SPMI ADC5 Gen3 device.
> + * @base: pointer to array of ADC peripheral base and interrupt.
> + * @num_sdams: number of SDAMs being used.

Define SDAM somewhere in here..

> + * @nchannels: number of ADC channels.
> + * @chan_props: array of ADC channel properties.
> + * @iio_chans: array of IIO channels specification.
> + * @complete: ADC result notification after interrupt is received.
> + * @lock: ADC lock for access to the peripheral.

Can you be more specific.  Access to peripheral could just be controlled via
regmap locking.

> + * @data: software configuration data.
> + * @n_tm_channels: number of ADC channels used for TM measurements.
> + * @tm_handler_work: scheduled work for handling TM threshold violation.
> + */
> +struct adc5_chip {
> +	struct regmap			*regmap;
> +	struct device			*dev;
> +	struct adc5_sdam_data		*base;
> +	unsigned int			num_sdams;
> +	unsigned int			nchannels;
> +	struct adc5_channel_prop	*chan_props;
> +	struct iio_chan_spec		*iio_chans;
> +	struct completion		complete;
> +	struct mutex			lock;
> +	const struct adc5_data		*data;
> +	/* TM properties */
> +	unsigned int			n_tm_channels;
> +	struct work_struct		tm_handler_work;
> +};
> +
> +static int adc5_gen3_read(struct adc5_chip *adc, unsigned int sdam_index, u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_read(adc->regmap, adc->base[sdam_index].base_addr + offset, data, len);
> +}
> +
> +static int adc5_gen3_write(struct adc5_chip *adc, unsigned int sdam_index, u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_write(adc->regmap, adc->base[sdam_index].base_addr + offset, data, len);
> +}
> +
> +static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data, u8 sdam_index)
> +{
> +	int ret;
> +	u8 rslt[2];
> +
> +	ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CH_DATA0(0), rslt, 2);
> +	if (ret)
> +		return ret;
> +
> +	*data = (rslt[1] << 8) | rslt[0];

get_unaligned_le16...

> +
> +	if (*data == ADC5_USR_DATA_CHECK) {
> +		dev_err(adc->dev, "Invalid data:%#x\n", *data);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(adc->dev, "voltage raw code:%#x\n", *data);
> +
> +	return 0;
> +}
> +
> +static void adc5_gen3_update_dig_param(struct adc5_chip *adc,
> +			struct adc5_channel_prop *prop, u8 *data)
> +{
> +	/* Update calibration select */
> +	*data &= ~ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK;
> +	*data |= (prop->cal_method << ADC5_GEN3_DIG_PARAM_CAL_SEL_SHIFT);
> +
> +	/* Update decimation ratio select */
> +	*data &= ~ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK;
> +	*data |= (prop->decimation << ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_SHIFT);

FIELD_PREP() after masking the bits out.

> +}
> +
> +static int adc5_gen3_configure(struct adc5_chip *adc,
> +			struct adc5_channel_prop *prop)
> +{
> +	u8 sdam_index = prop->sdam_index;
> +	u8 conv_req = 0;
> +	u8 buf[7];
> +	int ret;
> +
> +	/* Reserve channel 0 of first SDAM for immediate conversions */
> +	if (prop->adc_tm)
> +		sdam_index = 0;
> +
> +	ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_SID, buf, sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	/* Write SID */
> +	buf[0] = prop->sid & ADC5_GEN3_SID_MASK;
> +
> +	/*
> +	 * Use channel 0 by default for immediate conversion and
> +	 * to indicate there is an actual conversion request
> +	 */
> +	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | 0;
> +
> +	buf[2] = ADC5_GEN3_TIME_IMMEDIATE;
> +
> +	/* Digital param selection */
> +	adc5_gen3_update_dig_param(adc, prop, &buf[3]);
> +
> +	/* Update fast average sample value */
> +	buf[4] &= (u8) ~ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK;

Hmm. Is this cast necessary? I can't immediately spot why.

> +	buf[4] |= prop->avg_samples | ADC5_GEN3_FAST_AVG_CTL_EN;
> +
> +	/* Select ADC channel */
> +	buf[5] = prop->channel;
> +
> +	/* Select HW settle delay for channel */
> +	buf[6] &= (u8) ~ADC5_GEN3_HW_SETTLE_DELAY_MASK;
> +	buf[6] |= prop->hw_settle_time;
> +
> +	reinit_completion(&adc->complete);
> +
> +	ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_SID, buf, sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &conv_req, 1);
> +}
> +
> +#define ADC5_GEN3_HS_DELAY_MIN_US		100
> +#define ADC5_GEN3_HS_DELAY_MAX_US		110
> +#define ADC5_GEN3_HS_RETRY_COUNT		150

Why these particular values?  Good to state assumptions behind them
incase someone wants to be modify them in the future.

> +
> +static int adc5_gen3_poll_wait_hs(struct adc5_chip *adc,
> +				unsigned int sdam_index)
> +{
> +	u8 conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	u8 status = 0;
> +	int ret, count;
> +
> +	for (count = 0; count < ADC5_GEN3_HS_RETRY_COUNT; count++) {
> +		ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_HS, &status, 1);
> +		if (ret)
> +			return ret;
> +
> +		if (status == ADC5_GEN3_HS_READY) {
> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CONV_REQ,
> +					&conv_req, 1);
> +			if (ret)
> +				return ret;
> +
> +			if (!conv_req)
> +				return 0;
> +		}
> +
> +		usleep_range(ADC5_GEN3_HS_DELAY_MIN_US,
> +			ADC5_GEN3_HS_DELAY_MAX_US);
> +	}
> +
> +	dev_err(adc->dev, "Setting HS ready bit timed out, status:%#x\n", status);
> +	return -ETIMEDOUT;
> +}
> +

> +#define ADC5_GEN3_CONV_TIMEOUT_MS	501
Why?  Perhaps a specification reference?



> +static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
> +{
> +	struct adc5_chip *adc = dev_id;
> +	u8 status, tm_status[2], eoc_status, val;
> +	int ret, sdam_num;
> +
> +	sdam_num = get_sdam_from_irq(adc, irq);
> +	if (sdam_num < 0) {
> +		dev_err(adc->dev, "adc irq %d not associated with an sdam\n", irq);
> +		goto handler_end;
> +	}
> +
> +	ret = adc5_gen3_read(adc, sdam_num, ADC5_GEN3_EOC_STS, &eoc_status, 1);
> +	if (ret) {
> +		dev_err(adc->dev, "adc read eoc status failed with %d\n", ret);
> +		goto handler_end;
> +	}
> +
> +	/* CHAN0 is the preconfigured channel for immediate conversion */
> +	if (eoc_status & ADC5_GEN3_EOC_CHAN_0)
> +		complete(&adc->complete);
> +
> +	ret = adc5_gen3_read(adc, sdam_num, ADC5_GEN3_TM_HIGH_STS, tm_status, 2);
> +	if (ret) {
> +		dev_err(adc->dev, "adc read TM status failed with %d\n", ret);
> +		goto handler_end;
> +	}
> +
> +	if (tm_status[0] || tm_status[1])
> +		schedule_work(&adc->tm_handler_work);
> +
> +	ret = adc5_gen3_read(adc, sdam_num, ADC5_GEN3_STATUS1, &status, 1);
> +	if (ret) {
> +		dev_err(adc->dev, "adc read status1 failed with %d\n", ret);
> +		goto handler_end;
> +	}
> +
> +	dev_dbg(adc->dev, "Interrupt status:%#x, EOC status:%#x, high:%#x, low:%#x\n",
> +			status, eoc_status, tm_status[0], tm_status[1]);
> +
> +	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {

If you got an IRQ and could tell it was definitely from this device, IRQ_HANDLED probably the
appropriate return - rather than triggering the unhandled irq generic stuff.

> +		dev_err_ratelimited(adc->dev, "Unexpected conversion fault, status:%#x, eoc_status:%#x\n",
> +				status, eoc_status);
> +		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
> +		ret = adc5_gen3_write(adc, sdam_num, ADC5_GEN3_CONV_ERR_CLR, &val, 1);
> +		if (ret < 0)
> +			goto handler_end;
> +
> +		/* To indicate conversion request is only to clear a status */
> +		val = 0;
> +		ret = adc5_gen3_write(adc, sdam_num, ADC5_GEN3_PERPH_CH, &val, 1);
> +		if (ret < 0)
> +			goto handler_end;
> +
> +		val = ADC5_GEN3_CONV_REQ_REQ;
> +		ret = adc5_gen3_write(adc, sdam_num, ADC5_GEN3_CONV_REQ, &val, 1);
> +		if (ret < 0)
> +			goto handler_end;
> +	}
> +
> +	return IRQ_HANDLED;
> +
> +handler_end:
> +	return IRQ_NONE;

Return directly as then more immediately obvious that there is a problem.
However I'm not sure IRQ_NONE is appropriate as it doesn't mean error...
Normally we just log something then return IRQ_HANDLED.

> +}
> +
> +static void tm_handler_work(struct work_struct *work)
> +{
> +	struct adc5_chip *adc = container_of(work, struct adc5_chip, tm_handler_work);
> +	struct adc5_channel_prop *chan_prop;
> +	u8 tm_status[2] = {0};
> +	u8 buf[16] = {0};
> +	u8 val;
> +	int ret, i, sdam_index = -1;
> +
> +	for (i = 0; i < adc->nchannels; i++) {
> +		bool upper_set = false, lower_set = false;
> +		int temp, offset;
> +		u8 data_low = 0, data_high = 0;
> +		u16 code = 0;
> +
> +		chan_prop = &adc->chan_props[i];
> +		offset = chan_prop->tm_chan_index;
> +
> +		if (!chan_prop->adc_tm)
> +			continue;
> +
> +		mutex_lock(&adc->lock);
> +		if (chan_prop->sdam_index != sdam_index) {
> +			sdam_index = chan_prop->sdam_index;
> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_TM_HIGH_STS, tm_status, 2);
> +			if (ret) {
> +				dev_err(adc->dev, "adc read TM status failed with %d\n", ret);
> +				goto out;
> +			}
> +
> +			ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_TM_HIGH_STS_CLR, tm_status, 2);
> +			if (ret) {
> +				dev_err(adc->dev, "adc write TM status failed with %d\n", ret);
> +				goto out;
> +			}
> +
> +			/* To indicate conversion request is only to clear a status */
> +			val = 0;
> +			ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &val, 1);
> +			if (ret) {
> +				dev_err(adc->dev, "adc write status clear conv_req failed with %d\n", ret);
> +				goto out;
> +			}
> +
> +			val = ADC5_GEN3_CONV_REQ_REQ;
> +			ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &val, 1);
> +			if (ret) {
> +				dev_err(adc->dev, "adc write conv_req failed with %d\n", ret);
> +				goto out;
> +			}
> +
> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CH_DATA0(0), buf, sizeof(buf));
> +			if (ret < 0) {
> +				dev_err(adc->dev, "adc read data failed with %d\n", ret);
> +				goto out;
> +			}
> +		}
> +
> +		if ((tm_status[0] & BIT(offset)) && (chan_prop->high_thr_en))
> +			upper_set = true;
> +
> +		if ((tm_status[1] & BIT(offset)) && (chan_prop->low_thr_en))
> +			lower_set = true;
> +
> +		mutex_unlock(&adc->lock);
> +
> +		if (!(upper_set || lower_set))
> +			continue;
> +
> +		data_low = buf[2 * offset];
> +		data_high = buf[2 * offset + 1];
> +		code = ((data_high << 8) | data_low);

code = get_unaligned_le16(&buf[2 * offset]) or similar.

> +		pr_debug("ADC_TM threshold code:%#x\n", code);
> +
> +		ret = qcom_adc5_hw_scale(chan_prop->scale_fn_type,
> +			chan_prop->prescale, adc->data, code, &temp);
> +		if (ret) {
> +			dev_err(adc->dev, "Invalid temperature reading, ret=%d, code=%#x\n",
> +					ret, code);
> +			continue;
> +		}
> +
> +		chan_prop->last_temp = temp;
> +		chan_prop->last_temp_set = true;
> +		thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
> +	}
> +
> +	return;
> +
> +out:
> +	mutex_unlock(&adc->lock);
> +}

...

> +static int adc5_gen3_read_raw(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan, int *val, int *val2,
> +			 long mask)
> +{
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	struct adc5_channel_prop *prop;
> +	u16 adc_code_volt;
> +	int ret;
> +
> +	prop = &adc->chan_props[chan->address];
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = adc5_gen3_do_conversion(adc, prop,
> +					&adc_code_volt);
> +		if (ret)
> +			return ret;
> +
> +		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
> +			prop->prescale, adc->data,
> +			adc_code_volt, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		ret = adc5_gen3_do_conversion(adc, prop,
> +					&adc_code_volt);
> +		if (ret)
> +			return ret;
> +		*val = (int)adc_code_volt;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info adc5_gen3_info = {
> +	.read_raw = adc5_gen3_read_raw,
> +	.fwnode_xlate = adc5_gen3_fwnode_xlate,
> +};
...

> +static int adc_tm5_gen3_disable_channel(struct adc5_channel_prop *prop)
> +{

As mentioned below - this shares a bunch of code with the disable in the
remove callback.  If that shared code can be used in both paths that would
be great.

> +	struct adc5_chip *adc = prop->chip;
> +	int ret;
> +	u8 val;
> +
> +	prop->high_thr_en = false;
> +	prop->low_thr_en = false;
> +
> +	val = MEAS_INT_DISABLE;
> +	ret = adc5_gen3_write(adc, prop->sdam_index, ADC5_GEN3_TIMER_SEL, &val, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* To indicate there is an actual conversion request */
> +	val = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
> +	ret = adc5_gen3_write(adc, prop->sdam_index, ADC5_GEN3_PERPH_CH, &val, 1);
> +	if (ret)
> +		return ret;
> +
> +	val = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc, prop->sdam_index, ADC5_GEN3_CONV_REQ, &val, 1);
> +}
> +
> +static int adc_tm5_gen3_configure(struct adc5_channel_prop *prop,
> +					int low_temp, int high_temp)
> +{
> +	struct adc5_chip *adc = prop->chip;
> +	u8 conv_req = 0, buf[12];

Why 12?  Can you use a define or similar to express where that magic size
comes from?

> +	u16 adc_code;
> +	int ret;
> +
> +	ret = adc5_gen3_poll_wait_hs(adc, prop->sdam_index);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adc5_gen3_read(adc, prop->sdam_index, ADC5_GEN3_SID, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Write SID */
> +	buf[0] = prop->sid & ADC5_GEN3_SID_MASK;

FIELD_PREP() preferred for field configuration.

> +
> +	/*
> +	 * Select TM channel and indicate there is an actual
> +	 * conversion request
> +	 */
> +	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
> +
> +	buf[2] = prop->timer;
> +
> +	/* Digital param selection */
> +	adc5_gen3_update_dig_param(adc, prop, &buf[3]);
> +
> +	/* Update fast average sample value */
> +	buf[4] &= (u8) ~ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK;
> +	buf[4] |= prop->avg_samples | ADC5_GEN3_FAST_AVG_CTL_EN;
> +
> +	/* Select ADC channel */
> +	buf[5] = prop->channel;
> +
> +	/* Select HW settle delay for channel */
> +	buf[6] &= (u8) ~ADC5_GEN3_HW_SETTLE_DELAY_MASK;
> +	buf[6] |= prop->hw_settle_time;
> +
> +	/* High temperature corresponds to low voltage threshold */
> +	if (high_temp != INT_MAX) {
> +		prop->low_thr_en = true;
> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
> +		put_unaligned_le16(adc_code, &buf[8]);
> +	} else {
> +		prop->low_thr_en = false;
> +	}
> +
> +	/* Low temperature corresponds to high voltage threshold */
> +	if (low_temp != -INT_MAX) {
> +		prop->high_thr_en = true;
> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low_temp);
> +		put_unaligned_le16(adc_code, &buf[10]);
> +	} else {
> +		prop->high_thr_en = false;
> +	}
> +
> +	buf[7] = 0;
> +	if (prop->high_thr_en)
> +		buf[7] |= ADC5_GEN3_HIGH_THR_INT_EN;
> +	if (prop->low_thr_en)
> +		buf[7] |= ADC5_GEN3_LOW_THR_INT_EN;
> +
> +	ret = adc5_gen3_write(adc, prop->sdam_index, ADC5_GEN3_SID, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc, prop->sdam_index, ADC5_GEN3_CONV_REQ, &conv_req, 1);
> +}
> +
> +static int adc_tm5_gen3_set_trip_temp(struct thermal_zone_device *tz,
> +					int low_temp, int high_temp)
> +{
> +	struct adc5_channel_prop *prop = tz->devdata;
> +	struct adc5_chip *adc;
> +	int ret;
> +
> +	if (!prop || !prop->chip)
> +		return -EINVAL;
> +
> +	adc = prop->chip;
> +
> +	dev_dbg(adc->dev, "channel:%s, low_temp(mdegC):%d, high_temp(mdegC):%d\n",
> +		prop->datasheet_name, low_temp, high_temp);
> +
> +	mutex_lock(&adc->lock);
> +	if (high_temp == INT_MAX && low_temp <= -INT_MAX)
> +		ret = adc_tm5_gen3_disable_channel(prop);
> +	else
> +		ret = adc_tm5_gen3_configure(prop, low_temp, high_temp);
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}

> +
> +static int adc_tm_register_tzd(struct adc5_chip *adc)
> +{
> +	unsigned int i, channel;
> +	struct thermal_zone_device *tzd;
> +
> +	for (i = 0; i < adc->nchannels; i++) {
> +		channel = V_CHAN(adc->chan_props[i]);
> +
> +		if (!adc->chan_props[i].adc_tm)
> +			continue;
> +		tzd = devm_thermal_of_zone_register(
> +			adc->dev, channel,
> +			&adc->chan_props[i], &adc_tm_ops);

Short line wrap.   BTW I don't mind if you go over 80 chars if it helps readability but here
that's happening anyway.

> +
> +		if (IS_ERR(tzd)) {
> +			if (PTR_ERR(tzd) == -ENODEV) {
> +				dev_warn(adc->dev, "thermal sensor on channel %d is not used\n",
> +					 channel);
> +				continue;
> +			}
> +
> +			dev_err(adc->dev, "Error registering TZ zone:%ld for channel:%d\n",
> +				PTR_ERR(tzd), adc->chan_props[i].channel);
> +			return PTR_ERR(tzd);
> +		}
> +		adc->chan_props[i].tzd = tzd;
> +	}
> +
> +	return 0;
> +}
> +
> +struct adc5_channels {
> +	const char *datasheet_name;
> +	unsigned int prescale_index;
> +	enum iio_chan_type type;
> +	long info_mask;
> +	enum vadc_scale_fn_type scale_fn_type;
> +};
> +
> +/* In these definitions, _pre refers to an index into adc5_prescale_ratios. */
> +#define ADC5_CHAN(_dname, _type, _mask, _pre, _scale)	\
> +	{						\
> +		.datasheet_name = _dname,		\

Use of datasheet name is historical and makes a horribly messy userspace interface.
Unless there is a very strong reason otherwise, the read_label callback should be used
instead.  Unfortunately it's hard to fix this issue in existing drivers without
breaking ABI.  We don't want more cases.

> +		.prescale_index = _pre,			\
> +		.type = _type,				\
> +		.info_mask = _mask,			\
> +		.scale_fn_type = _scale,		\
> +	},						\
> +
> +#define ADC5_CHAN_TEMP(_dname, _pre, _scale)		\
> +	ADC5_CHAN(_dname, IIO_TEMP,			\
> +		BIT(IIO_CHAN_INFO_PROCESSED),		\
> +		_pre, _scale)				\
> +
> +#define ADC5_CHAN_VOLT(_dname, _pre, _scale)		\
> +	ADC5_CHAN(_dname, IIO_VOLTAGE,			\
> +		  BIT(IIO_CHAN_INFO_PROCESSED),		\
> +		  _pre, _scale)				\
> +
> +#define ADC5_CHAN_CUR(_dname, _pre, _scale)		\
> +	ADC5_CHAN(_dname, IIO_CURRENT,			\
> +		  BIT(IIO_CHAN_INFO_PROCESSED),		\
> +		  _pre, _scale)				\
> +

These seem rather over wrapped.  Could get nearer 80 chars and use
a few fewer lines.


> +static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
> +				    struct adc5_channel_prop *prop,
> +				    struct fwnode_handle *fwnode,
> +				    const struct adc5_data *data)
> +{
> +	const char *name = fwnode_get_name(fwnode), *channel_name;

I'd break the definition of channel_name out on it's own (so not in the same line
as name)

> +	struct device *dev = adc->dev;
> +	u32 chan, value, varr[2], sid = 0;
> +	int ret, val;
> +
> +	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
> +	if (ret < 0) {
> +		dev_err(dev, "invalid channel number %s\n", name);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Value read from "reg" is virtual channel number
> +	 * virtual channel number = sid << 8 | channel number
> +	 */
> +
> +	sid = (chan >> ADC5_GEN3_SID_OFFSET);
> +	chan = (chan & ADC5_GEN3_CHANNEL_MASK);

Slightly nicer to just provide the masks as defines and use FIELD_GET() for both.

> +
> +	if (chan > ADC5_GEN3_OFFSET_EXT2 ||
> +	    !data->adc_chans[chan].datasheet_name) {
> +		dev_err(dev, "%s invalid channel number %d\n", name, chan);
> +		return -EINVAL;
> +	}
> +
> +	prop->channel = chan;
> +	prop->sid = sid;
> +
> +	ret = fwnode_property_read_string(fwnode, "label", &channel_name);
> +	if (ret)
> +		channel_name = name;
> +	prop->datasheet_name = channel_name;
> +
> +	prop->decimation = ADC5_DECIMATION_DEFAULT;
> +	ret = fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
> +	if (!ret) {
> +		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
> +		if (ret < 0) {
> +			dev_err(dev, "%#x invalid decimation %d\n",
> +				chan, value);
> +			return ret;
> +		}
> +		prop->decimation = ret;
> +	}
> +
> +	prop->prescale = adc->data->adc_chans[prop->channel].prescale_index;
> +	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
> +	if (!ret) {
> +		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
> +		if (ret < 0) {
> +			dev_err(dev, "%#x invalid pre-scaling <%d %d>\n",
> +				chan, varr[0], varr[1]);
> +			return ret;

As this is only called in probe, you can use dev_err_probe() for a small simplification
here and in similar cases.


> +		}
> +		prop->prescale = ret;
> +	}
> +
> +	prop->hw_settle_time = VADC_DEF_HW_SETTLE_TIME;
> +	ret = fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
> +	if (!ret) {
> +		ret = qcom_adc5_hw_settle_time_from_dt(value,
> +						data->hw_settle_1);
> +		if (ret < 0) {
> +			dev_err(dev, "%#x invalid hw-settle-time %d us\n",
> +				chan, value);
> +			return ret;
> +		}
> +		prop->hw_settle_time = ret;
> +	}
> +
> +	prop->avg_samples = VADC_DEF_AVG_SAMPLES;
> +	ret = fwnode_property_read_u32(fwnode, "qcom,avg-samples", &value);
> +	if (!ret) {
> +		ret = qcom_adc5_avg_samples_from_dt(value);
> +		if (ret < 0) {
> +			dev_err(dev, "%#x invalid avg-samples %d\n",
> +				chan, value);
> +			return ret;
> +		}
> +		prop->avg_samples = ret;
> +	}
> +
> +	if (fwnode_property_read_bool(fwnode, "qcom,ratiometric"))
> +		prop->cal_method = ADC5_RATIOMETRIC_CAL;
> +	else
> +		prop->cal_method = ADC5_ABSOLUTE_CAL;
> +
> +	prop->timer = MEAS_INT_IMMEDIATE;
> +
> +	prop->adc_tm = fwnode_property_read_bool(fwnode, "qcom,adc-tm-type");
> +
> +	if (prop->adc_tm) {
> +		adc->n_tm_channels++;
> +		if (adc->n_tm_channels > ((adc->num_sdams * 8) - 1)) {
> +			dev_err(adc->dev, "Number of TM nodes %u greater than channels supported:%u\n",
> +				adc->n_tm_channels, (adc->num_sdams * 8) - 1);
> +			return -EINVAL;
> +		}
> +
> +		val = adc->n_tm_channels / 8;
> +		prop->sdam_index = val;
> +		prop->tm_chan_index = adc->n_tm_channels - (8*val);
> +
> +		prop->timer = MEAS_INT_1S;
> +	}
> +
> +	return 0;
> +}
> +

...

> +
> +static int adc5_gen3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct adc5_chip *adc;
> +	struct regmap *regmap;
> +	int ret, i, irq;
> +	u32 *reg;
> +	char buf[20];
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->regmap = regmap;
> +	adc->dev = dev;
> +
> +	ret = device_property_count_u32(dev, "reg");
> +	if (ret < 0)
> +		return ret;
> +
> +	adc->num_sdams = ret;

The binding needs to make it clear that reg can be a bunch of different base
addresses.

> +
> +	reg = devm_kcalloc(dev, adc->num_sdams, sizeof(u32), GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;

I think this is only used locally.  So I'd prefer local allocation and clean it up
afterwards rather than tying it to the lifetime of the device.

> +
> +	ret = device_property_read_u32_array(dev, "reg", reg, adc->num_sdams);
> +	if (ret) {
> +		dev_err(adc->dev, "Failed to read reg property, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	adc->base = devm_kcalloc(adc->dev, adc->num_sdams, sizeof(*adc->base), GFP_KERNEL);
> +	if (!adc->base)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < adc->num_sdams; i++) {
> +		adc->base[i].base_addr = reg[i];
> +
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0) {
> +			dev_err(adc->dev, "Failed to get SDAM%d irq, ret=%d\n", i, irq);
> +			return irq;
> +		}
> +		adc->base[i].irq = irq;
> +
> +		scnprintf(buf, sizeof(buf), "adc-sdam%d", i);
> +		adc->base[i].irq_name = devm_kstrdup(adc->dev, buf, GFP_KERNEL);

Why not devm_kasprintf()?

Unusual to have such a separation between getting irqs and the requesting them.
Why not push this until after the adc5_get_fw_data) and then I think you can
do it in a single loop.


> +		if (!adc->base[i].irq_name)
> +			return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, adc);
> +
> +	init_completion(&adc->complete);
> +	mutex_init(&adc->lock);

This is interleaving some general setup with a bunch of firwmare related stuff.
I'd push this above the getting of irq's above.

> +
> +	ret = adc5_get_fw_data(adc);
> +	if (ret < 0) {
> +		dev_err(adc->dev, "adc get dt data failed, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < adc->num_sdams; i++) {
> +		ret = devm_request_irq(dev, adc->base[i].irq, adc5_gen3_isr,
> +					0, adc->base[i].irq_name, adc);
> +		if (ret < 0) {
> +			dev_err(adc->dev, "Getting IRQ %d failed, ret=%d\n", adc->base[i].irq, ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = adc_tm_register_tzd(adc);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (adc->n_tm_channels)
> +		INIT_WORK(&adc->tm_handler_work, tm_handler_work);
> +
> +	indio_dev->name = pdev->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &adc5_gen3_info;
> +	indio_dev->channels = adc->iio_chans;
> +	indio_dev->num_channels = adc->nchannels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int adc5_gen3_exit(struct platform_device *pdev)
> +{

As you are mixing devm manged cleanup and the explicit sort the
result is that you remove the userspace interfaces 'after' you run
everything in here. I'm thinking disabling the channels at least
isn't a good idea in that case.

If you want to use devm (which is good) then you need to work out how
to register additional callbacks during probe to tear down everything in
the right order (typically the reverse of what happens in probe)
devm_add_action_or_reset() is the way to add those extra callbacks.

If not, just don't use devm for at least those bits that will end up
running out of order (such as iio_device_register()) and manually call their
cleanup routines instead.


> +	struct adc5_chip *adc = platform_get_drvdata(pdev);
> +	u8 data = 0;
> +	int i, sdam_index;
> +
> +	mutex_lock(&adc->lock);
> +	/* Disable all available channels */
> +	for (i = 0; i < adc->num_sdams * 8; i++) {
> +		sdam_index = i / 8;
> +		data = MEAS_INT_DISABLE;
> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_TIMER_SEL, &data, 1);
> +
> +		/* To indicate there is an actual conversion request */
> +		data = ADC5_GEN3_CHAN_CONV_REQ | (i - (sdam_index * 8));
> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &data, 1);
> +
> +		data = ADC5_GEN3_CONV_REQ_REQ;
> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &data, 1);

This block is very similar to adc_tm5_gen3_disable_channel() Perhaps you can factor
out a little function to be used here and in that function.

> +	}
> +
> +	mutex_unlock(&adc->lock);
> +
> +	if (adc->n_tm_channels)
> +		cancel_work_sync(&adc->tm_handler_work);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver adc5_gen3_driver = {
> +	.driver = {
> +		.name = "qcom-spmi-adc5-gen3",
> +		.of_match_table = adc5_match_table,
> +	},
> +	.probe = adc5_gen3_probe,
> +	.remove = adc5_gen3_exit,

adc5_gen3_remove() naming preferred.

> +};
> +module_platform_driver(adc5_gen3_driver);
> +
> +MODULE_ALIAS("platform:qcom-spmi-adc5-gen3");
> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. PMIC5 Gen3 ADC driver");
> +MODULE_LICENSE("GPL");

