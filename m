Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA6B744CED
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjGBJV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 05:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:21:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494F1AC;
        Sun,  2 Jul 2023 02:21:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv3Pz27jmz6D9CM;
        Sun,  2 Jul 2023 17:18:31 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 10:21:20 +0100
Date:   Sun, 2 Jul 2023 17:21:16 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     George Stark <gnstark@sberdevices.ru>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v3 5/5] meson saradc: support reading from channel 7 mux
 inputs
Message-ID: <20230702172116.00006f33@Huawei.com>
In-Reply-To: <20230627224017.1724097-6-gnstark@sberdevices.ru>
References: <20230627224017.1724097-1-gnstark@sberdevices.ru>
        <20230627224017.1724097-6-gnstark@sberdevices.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 01:37:18 +0300
George Stark <gnstark@sberdevices.ru> wrote:

> Add iio channel for every channel 7 mux input.
> Meson saradc channel 7 is connected to a mux that can switch channel
> input to well-known sources like Vdd, GND and several Vdd dividers.
> 
> Signed-off-by: George Stark <GNStark@sberdevices.ru>
> ---
>  drivers/iio/adc/meson_saradc.c | 83 ++++++++++++++++++++++++++++++++--
>  1 file changed, 79 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 4a9dacedb6c3..c99a55944ece 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -163,6 +163,7 @@
>  #define MESON_SAR_ADC_MAX_FIFO_SIZE				32
>  #define MESON_SAR_ADC_TIMEOUT					100 /* ms */
>  #define MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL			6
> +#define MESON_SAR_ADC_VOLTAGE_AND_MUX_CHANNEL			7
>  #define MESON_SAR_ADC_TEMP_OFFSET				27
>  
>  /* temperature sensor calibration information in eFuse */
> @@ -202,6 +203,19 @@
>  	.datasheet_name = "TEMP_SENSOR",				\
>  }
>  
> +#define MESON_SAR_ADC_MUX(_chan, _sel) {				\
> +	.type = IIO_VOLTAGE,						\
> +	.channel = _chan,						\
> +	.indexed = 1,							\
> +	.address = MESON_SAR_ADC_VOLTAGE_AND_MUX_CHANNEL,		\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +				BIT(IIO_CHAN_INFO_AVERAGE_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),		\
> +	.datasheet_name = "SAR_ADC_MUX_"#_sel,				\
> +}
> +
>  enum meson_sar_adc_avg_mode {
>  	NO_AVERAGING = 0x0,
>  	MEAN_AVERAGING = 0x1,
> @@ -235,6 +249,27 @@ enum meson_sar_adc_channel_index {
>  	NUM_CHAN_7,
>  	NUM_CHAN_TEMP,
>  	NUM_CHAN_SOFT_TIMESTAMP,

Silly question... Why does this device have timestamp channels?
It has no buffer support so they don't 'do anything'.
If it had then putting other channels after that might have broken
things if not done very carefully (hence I went looking)

> +	NUM_MUX_0_VSS,
> +	NUM_MUX_1_VDD_DIV4,
> +	NUM_MUX_2_VDD_DIV2,
> +	NUM_MUX_3_VDD_MUL3_DIV4,
> +	NUM_MUX_4_VDD,
> +};
...

>  static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
> @@ -247,6 +282,11 @@ static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
>  	MESON_SAR_ADC_CHAN(NUM_CHAN_6),
>  	MESON_SAR_ADC_CHAN(NUM_CHAN_7),
>  	IIO_CHAN_SOFT_TIMESTAMP(NUM_CHAN_SOFT_TIMESTAMP),
> +	MESON_SAR_ADC_MUX(NUM_MUX_0_VSS, 0),
> +	MESON_SAR_ADC_MUX(NUM_MUX_1_VDD_DIV4, 1),
> +	MESON_SAR_ADC_MUX(NUM_MUX_2_VDD_DIV2, 2),
> +	MESON_SAR_ADC_MUX(NUM_MUX_3_VDD_MUL3_DIV4, 3),
> +	MESON_SAR_ADC_MUX(NUM_MUX_4_VDD, 4),
>  };

Jonathan
