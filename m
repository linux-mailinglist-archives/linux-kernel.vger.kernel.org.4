Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2FB6E0B65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDMK2l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Apr 2023 06:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDMK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:28:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246002737;
        Thu, 13 Apr 2023 03:28:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxwkY5Tgbz67QKJ;
        Thu, 13 Apr 2023 18:27:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Apr
 2023 11:28:32 +0100
Date:   Thu, 13 Apr 2023 11:28:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Patrik =?ISO-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <letux-kernel@openphoenux.org>, <kernel@pyra-handheld.com>,
        <pgoudagunta@nvidia.com>, <hns@goldelico.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v4 8/9] iio: adc: palmas: add support for iio threshold
 events
Message-ID: <20230413112830.00006279@Huawei.com>
In-Reply-To: <20230408114825.824505-9-risca@dalakolonin.se>
References: <20230408114825.824505-1-risca@dalakolonin.se>
        <20230408114825.824505-9-risca@dalakolonin.se>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Sat,  8 Apr 2023 13:48:24 +0200
Patrik Dahlström <risca@dalakolonin.se> wrote:

> The palmas gpadc block has support for monitoring up to 2 ADC channels
> and issue an interrupt if they reach past a set threshold. This change
> hooks into the IIO events system and exposes to userspace the ability to
> configure these threshold values for each channel, but only allow up to
> 2 such thresholds to be enabled at any given time. Trying to enable a
> third channel will result in an error.
> 
> Userspace is expected to input calibrated, as opposed to raw, values as
> threshold. However, it is not enough to do the opposite of what is done
> when converting the other way around. To account for tolerances in the
> ADC, the calculated raw threshold should be adjusted based on the ADC
> specifications for the device. These specifications include the integral
> nonlinearity (INL), offset, and gain error. To adjust the high
> threshold, use the following equation:
> 
>   (calibrated value + INL) * Gain error + offset = maximum value  [1]
> 
> Likewise, use the following equation for the low threshold:
> 
>   (calibrated value - INL) * Gain error - offset = minimum value
> 
> The gain error is a combination of gain error, as listed in the
> datasheet, and gain error drift due to temperature and supply. The exact
> values for these specifications vary between palmas devices. This patch
> sets the values found in TWL6035, TWL6037 datasheet.
> 
> [1] TI Application Report, SLIA087A, Guide to Using the GPADC in
>     TPS65903x, TPS65917-Q1, TPS65919-Q1, and TPS65916 Devices.
> 
> Signed-off-by: Patrik Dahlström <risca@dalakolonin.se>

0-day found some stuff we'd missed in here.

I've fixed it up and pushed out again.

> ---
...
> +static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir,
> +					  enum iio_event_info info,
> +					  int val, int val2)
> +{
> +	struct palmas_gpadc *adc = iio_priv(indio_dev);
> +	int adc_chan = chan->channel;
> +	int old;
> +	int ret;
> +
> +	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	mutex_lock(&adc->lock);
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (val < 0 || val > 0xFFF) {
> +			ret = -EINVAL;
> +			break;

Should be goto out_unlock; Found because old is undefined.

> +		}
> +		if (dir == IIO_EV_DIR_RISING) {
> +			old = adc->thresholds[adc_chan].high;
> +			adc->thresholds[adc_chan].high = val;
> +		}

Whilst here should be } else {

Tidied both up force an update on the testing branch.

> +		else {
> +			old = adc->thresholds[adc_chan].low;
> +			adc->thresholds[adc_chan].low = val;
> +		}
> +		ret = 0;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	if (val != old && palmas_gpadc_get_event(adc, adc_chan, dir))
> +		ret = palmas_gpadc_reconfigure_event_channels(adc);
> +
> +out_unlock:
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
