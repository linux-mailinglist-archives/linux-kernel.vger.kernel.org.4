Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B47D749318
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjGFB2a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 21:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGFB23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:28:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB810102;
        Wed,  5 Jul 2023 18:28:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QxJkG4Pqwz67cDq;
        Thu,  6 Jul 2023 09:25:26 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 6 Jul
 2023 02:28:23 +0100
Date:   Thu, 6 Jul 2023 09:28:19 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Roan van Dijk <roan@protonic.nl>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: scd4x: Add pressure compensation
Message-ID: <20230706092819.000022df@Huawei.com>
In-Reply-To: <20230704084706.370637-1-roan@protonic.nl>
References: <20230704084706.370637-1-roan@protonic.nl>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Tue,  4 Jul 2023 10:47:06 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> This patch adds pressure compensation to the scd4x driver. The pressure can
> be written to the sensor in hPa. The pressure will be compensated
> internally by the sensor.
> 
> Signed-off-by: Roan van Dijk <roan@protonic.nl>

Why treat this as a channel with just calibbias?
From what I can recall we've previous treated such cases as an
output channel with the advantage that the units are then fully
defined.  I may well be forgetting some argument or a case that
does it with calibbias though.

Jonathan


> ---
>  drivers/iio/chemical/scd4x.c | 41 +++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
> index a4f22d926400..fe6b3f3f7186 100644
> --- a/drivers/iio/chemical/scd4x.c
> +++ b/drivers/iio/chemical/scd4x.c
> @@ -36,6 +36,8 @@
>  #define SCD4X_WRITE_BUF_SIZE 5
>  #define SCD4X_FRC_MIN_PPM 0
>  #define SCD4X_FRC_MAX_PPM 2000
> +#define SCD4X_AMB_PRESSURE_MIN 700
> +#define SCD4X_AMB_PRESSURE_MAX 1200
>  #define SCD4X_READY_MASK 0x01
>  
>  /*Commands SCD4X*/
> @@ -45,6 +47,8 @@ enum scd4x_cmd {
>  	CMD_STOP_MEAS           = 0x3f86,
>  	CMD_SET_TEMP_OFFSET     = 0x241d,
>  	CMD_GET_TEMP_OFFSET     = 0x2318,
> +	CMD_SET_AMB_PRESSURE	= 0xe000,
> +	CMD_GET_AMB_PRESSURE	= 0xe000,
>  	CMD_FRC                 = 0x362f,
>  	CMD_SET_ASC             = 0x2416,
>  	CMD_GET_ASC             = 0x2313,
> @@ -373,7 +377,10 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		mutex_lock(&state->lock);
> -		ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, sizeof(tmp));
> +		if (chan->type == IIO_TEMP)
> +			ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, sizeof(tmp));
> +		else if (chan->type == IIO_PRESSURE)
> +			ret = scd4x_read(state, CMD_GET_AMB_PRESSURE, &tmp, sizeof(tmp));
>  		mutex_unlock(&state->lock);
>  		if (ret)
>  			return ret;
> @@ -386,6 +393,25 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static const int scd4x_pressure_calibbias_available[] = {
> +	SCD4X_AMB_PRESSURE_MIN, 1, SCD4X_AMB_PRESSURE_MAX,
> +};
> +
> +static int scd4x_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    const int **vals, int *type, int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*vals = scd4x_pressure_calibbias_available;
> +		*type = IIO_VAL_INT;
> +
> +		return IIO_AVAIL_RANGE;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +
>  static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
>  				int val, int val2, long mask)
>  {
> @@ -395,9 +421,11 @@ static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		mutex_lock(&state->lock);
> -		ret = scd4x_write(state, CMD_SET_TEMP_OFFSET, val);
> +		if (chan->type == IIO_TEMP)
> +			ret = scd4x_write(state, CMD_SET_TEMP_OFFSET, val);
> +		else if (chan->type == IIO_PRESSURE)
> +			ret = scd4x_write(state, CMD_SET_AMB_PRESSURE, val);
>  		mutex_unlock(&state->lock);
> -
>  		return ret;
>  	default:
>  		return -EINVAL;
> @@ -503,9 +531,16 @@ static const struct iio_info scd4x_info = {
>  	.attrs = &scd4x_attr_group,
>  	.read_raw = scd4x_read_raw,
>  	.write_raw = scd4x_write_raw,
> +	.read_avail = scd4x_read_avail,
>  };
>  
>  static const struct iio_chan_spec scd4x_channels[] = {
> +	{
> +		.type = IIO_PRESSURE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS),
> +		.scan_index = -1,
> +	},
>  	{
>  		.type = IIO_CONCENTRATION,
>  		.channel2 = IIO_MOD_CO2,

