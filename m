Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21066C418
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjAPPjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjAPPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:38:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF841D933;
        Mon, 16 Jan 2023 07:38:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nwbfp3TC5z6J6KT;
        Mon, 16 Jan 2023 23:34:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 15:38:18 +0000
Date:   Mon, 16 Jan 2023 15:38:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: stm32: add oversampling support
Message-ID: <20230116153817.00004770@Huawei.com>
In-Reply-To: <20230116090333.33492-1-olivier.moysan@foss.st.com>
References: <20230116090333.33492-1-olivier.moysan@foss.st.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 10:03:33 +0100
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add oversampling support for STM32H7, STM32MP15 & STM32MP13.
> STM32F4 ADC has no oversampling feature.
> 
> The current support of the oversampling feature aims at increasing
> the data SNR, without changing the data resolution.
> As the oversampling by itself increases data resolution,
> a right shift is applied to keep initial resolution.
> Only the oversampling ratio corresponding to a power of two are
> supported here, to get a direct link between right shift and
> oversampling ratio. (2exp(n) ratio <=> n right shift)
> 
> The oversampling ratio is shared by all channels, whatever channel type.
> (e.g. single ended or differential).
> 
> Oversampling can be configured using IIO ABI:
> - in_voltage_oversampling_ratio_available
> - in_voltage_oversampling_ratio
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Hi. A few minor suggestions inline.

Also, what is relationship of Fabrice to this patch?
I'd either expect him to have sent it on, or a Co-developed marking
as appropriate.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc-core.h |  16 ++++
>  drivers/iio/adc/stm32-adc.c      | 144 +++++++++++++++++++++++++++++++
>  2 files changed, 160 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
> index 73b2c2e91c08..86a98286eeb3 100644
> --- a/drivers/iio/adc/stm32-adc-core.h
> +++ b/drivers/iio/adc/stm32-adc-core.h
> @@ -91,6 +91,7 @@
>  #define STM32H7_ADC_IER			0x04
>  #define STM32H7_ADC_CR			0x08
>  #define STM32H7_ADC_CFGR		0x0C
> +#define STM32H7_ADC_CFGR2		0x10
>  #define STM32H7_ADC_SMPR1		0x14
>  #define STM32H7_ADC_SMPR2		0x18
>  #define STM32H7_ADC_PCSEL		0x1C
> @@ -160,6 +161,14 @@
>  #define STM32H7_DMNGT_SHIFT		0
>  #define STM32H7_DMNGT_MASK		GENMASK(1, 0)
>  
> +/* STM32H7_ADC_CFGR2 bit fields */
> +#define STM32H7_OVSR_SHIFT		16 /* Correspond to OSVR field in datasheet */
> +#define STM32H7_OVSR_MASK		GENMASK(25, 16)
> +#define STM32H7_OVSR_BITS		10
> +#define STM32H7_OVSS_SHIFT		5

As below - mostly I'd expect FIELD_PREP / FIELD_GET to be used as they
avoid the need for separate defines for MASK and SHIFT (only MASK ones
are used).

> +#define STM32H7_OVSS_MASK		GENMASK(8, 5)
> +#define STM32H7_ROVSE			BIT(0)
> +
>  enum stm32h7_adc_dmngt {
>  	STM32H7_DMNGT_DR_ONLY,		/* Regular data in DR only */
>  	STM32H7_DMNGT_DMA_ONESHOT,	/* DMA one shot mode */
> @@ -226,6 +235,13 @@ enum stm32h7_adc_dmngt {
>  #define STM32MP13_RES_SHIFT		3
>  #define STM32MP13_RES_MASK		GENMASK(4, 3)
>  
> +/* STM32MP13_ADC_CFGR2 bit fields */
> +#define STM32MP13_OVSR_SHIFT		2
> +#define STM32MP13_OVSR_MASK		GENMASK(4, 2)
> +#define STM32MP13_OVSR_BITS		3
> +#define STM32MP13_OVSS_SHIFT		5
> +#define STM32MP13_OVSS_MASK		GENMASK(8, 5)
> +
>  /* STM32MP13_ADC_DIFSEL - bit fields */
>  #define STM32MP13_DIFSEL_MASK		GENMASK(18, 0)
>  
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 45d4e79f8e55..17050875f23d 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -6,6 +6,7 @@
>   * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> @@ -13,6 +14,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>

Why? That is only relevant for custom attributes.

>  #include <linux/iio/timer/stm32-lptim-trigger.h>
>  #include <linux/iio/timer/stm32-timer-trigger.h>
>  #include <linux/iio/trigger.h>
> @@ -27,6 +29,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include <linux/util_macros.h>

I'm not immediately seeing anything from here being used.

>  
>  #include "stm32-adc-core.h"
>  
>
...


>  
> +static void stm32h7_adc_set_ovs(struct iio_dev *indio_dev, u32 ovs_idx)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	u32 ovsr_bits, bits, msk = STM32H7_ROVSE;
> +
> +	msk |= STM32H7_OVSR_MASK | STM32H7_OVSS_MASK;

As below.

> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR2, msk);
> +
> +	if (!ovs_idx)
> +		return;
> +
> +	bits = STM32H7_ROVSE;
> +	ovsr_bits = (1 << ovs_idx) - 1;
> +	bits |= ovsr_bits << STM32H7_OVSR_SHIFT;
Good place to FIELD_PREP() and avoid need for SHIFT definitions.

> +	bits |= ovs_idx << STM32H7_OVSS_SHIFT;
> +
> +	stm32_adc_set_bits(adc, STM32H7_ADC_CFGR2, bits & msk);
> +}
> +
> +static void stm32mp13_adc_set_ovs(struct iio_dev *indio_dev, u32 ovs_idx)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	u32 bits, msk = STM32H7_ROVSE;
> +
> +	msk |= STM32MP13_OVSR_MASK | STM32MP13_OVSS_MASK;

	u32 bits, msk;

	msk = STM32H7_ROVSE | STM32MP13_OVSR_MASK | STM32MP13_OVSS_MSK;

is more readable.

> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR2, msk);
> +
> +	if (!ovs_idx)
> +		return;
> +
> +	bits = STM32H7_ROVSE;
> +	if (ovs_idx - 1)
> +		bits |= (ovs_idx - 1) << STM32MP13_OVSR_SHIFT;
> +	bits |= ovs_idx << STM32MP13_OVSS_SHIFT;
FIELD_PREP() for all these.

> +
> +	stm32_adc_set_bits(adc, STM32H7_ADC_CFGR2, bits & msk);
> +}
> +
>  static int stm32h7_adc_exit_pwr_down(struct iio_dev *indio_dev)
>  {
>  	struct stm32_adc *adc = iio_priv(indio_dev);
> @@ -1461,6 +1524,71 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int stm32_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			       int val, int val2, long mask)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	int nb = adc->cfg->adc_info->num_ovs;
> +	u32 idx;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		if (val2) {
> +			ret = -EINVAL;
> +			goto err;
> +		}

Do as much as possible outside of the serialization caused
by iio_device_claim_direct_mode.
These sanity checks and indeed the array search can all be done
outside of that and directly return on error.


> +
> +		for (idx = 0; idx < nb; idx++)
> +			if (adc->cfg->adc_info->oversampling[idx] == val)
> +				break;
> +
> +		if (idx >= nb) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
> +			goto err;
> +
> +		adc->cfg->set_ovs(indio_dev, idx);
> +
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +
> +		adc->ovs_idx = idx;
> +
> +err:
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int stm32_adc_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +				const int **vals, int *type, int *length, long m)

Where it doesn't hurt readability, I'd prefer we keep lines under 80 chars.

> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*type = IIO_VAL_INT;
> +		*length = adc->cfg->adc_info->num_ovs;
> +		*vals = adc->cfg->adc_info->oversampling;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

Thanks,

Jonathan
