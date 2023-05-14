Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2086E701E98
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjENRJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbjENRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:09:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620315270;
        Sun, 14 May 2023 10:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3366D60EFB;
        Sun, 14 May 2023 17:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E838C433EF;
        Sun, 14 May 2023 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084126;
        bh=8O1EOYZmCwHjuRGBGe8zpASVzWkit7T6R6L6cffS204=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VIKLBpTOdFFYuPmTuCAd9jJ4EAycL9EieWsodM6vhuDm8odVGH34zxweXTeZSZV+h
         IpyuA1uWK9+RrksQqmkbK7BHJOJANKVyjYKRXdxaBaYrUAjPwcp+QbVrI3jTmASaJb
         fPNq7bHdo2P1Pcw3+53noLTXQREiltq9uFsRpOrV/4jvdNYmLqrRujBpF8IZFUFwoJ
         cL/NKM4pi0v+ac2RXbEmYPHStlCDal9T7nPJhrlDNm0cUElBOXWgwSFyjR5CDpYAnJ
         Dk88blP8ashrp7zNmN5qs4lF7NHDC2e22OvjstabjoBDnT1JadSX0T/6sM/1jAj/+q
         NYlo4MXTunFaw==
Date:   Sun, 14 May 2023 18:24:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 2/7] iio: light: vcnl4000: Add proximity ps_it for
 vcnl4200
Message-ID: <20230514182446.0e42777d@jic23-huawei>
In-Reply-To: <20230509140153.3279288-3-astrid.rost@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
        <20230509140153.3279288-3-astrid.rost@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Tue, 9 May 2023 16:01:48 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> Add ps_it attributes for vcnl4200 (similar to vcnl4040).
> Add read/write attribute for proximity integration time.
> Read attribute for available proximity integration times.
> Change sampling rate depending on integration time.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>

Similar to previous patch, I'd prefer to move away from
code based selection of values for each type of device to data
based - with data stored in the existing chip_spec structures.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 52 +++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 13568454baff..e14475070ac3 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -124,6 +124,15 @@ static const int vcnl4040_ps_it_times[][2] = {
>  	{0, 800},
>  };
>  
> +static const int vcnl4200_ps_it_times[][2] = {
> +	{0, 96},
> +	{0, 144},
> +	{0, 192},
> +	{0, 384},
> +	{0, 768},
> +	{0, 864},
> +};
> +
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>  
>  enum vcnl4000_device_ids {
> @@ -500,6 +509,16 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
>  static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
>  {
>  	int ret;
> +	const int(*ps_it_times)[][2];
> +	int size;
> +
> +	if (data->id == VCNL4200) {
> +		ps_it_times = &vcnl4200_ps_it_times;
> +		size = ARRAY_SIZE(vcnl4200_ps_it_times);
> +	} else {
> +		ps_it_times = &vcnl4040_ps_it_times;
> +		size = ARRAY_SIZE(vcnl4040_ps_it_times);

See below.  Same points hold (I tend to review upwards as I find it
easier to follow).

> +	}
>  
>  	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>  	if (ret < 0)
> @@ -507,11 +526,11 @@ static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
>  
>  	ret = FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
>  
> -	if (ret >= ARRAY_SIZE(vcnl4040_ps_it_times))
> +	if (ret >= size)
>  		return -EINVAL;
>  
> -	*val = vcnl4040_ps_it_times[ret][0];
> -	*val2 = vcnl4040_ps_it_times[ret][1];
> +	*val = (*ps_it_times)[ret][0];
> +	*val2 = (*ps_it_times)[ret][1];
>  
>  	return 0;
>  }
> @@ -521,9 +540,19 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
>  	unsigned int i;
>  	int ret, index = -1;
>  	u16 regval;
> +	const int(*ps_it_times)[][2];
> +	int size;
>  
> -	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_it_times); i++) {
> -		if (val == vcnl4040_ps_it_times[i][1]) {
> +	if (data->id == VCNL4200) {
> +		ps_it_times = &vcnl4200_ps_it_times;

As below. I'd like this to be data in chip_spec rather than code here.
That almost always ends up more flexible and compact in the long run as
support for more parts is added to a driver.

> +		size = ARRAY_SIZE(vcnl4200_ps_it_times);
> +	} else {
> +		ps_it_times = &vcnl4040_ps_it_times;
> +		size = ARRAY_SIZE(vcnl4040_ps_it_times);
> +	}
> +
> +	for (i = 0; i < size; i++) {
> +		if (val == (*ps_it_times)[i][1]) {
>  			index = i;
>  			break;
>  		}
> @@ -532,6 +561,8 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
>  	if (index < 0)
>  		return -EINVAL;
>  
> +	data->vcnl4200_ps.sampling_rate = ktime_set(0, val * 60000);
> +
>  	mutex_lock(&data->vcnl4000_lock);
>  
>  	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> @@ -619,11 +650,18 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
>  			       const int **vals, int *type, int *length,
>  			       long mask)
>  {
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_INT_TIME:
> -		*vals = (int *)vcnl4040_ps_it_times;
> +		if (data->id == VCNL4200) {
> +			*vals = (int *)vcnl4200_ps_it_times;
> +			*length = 2 * ARRAY_SIZE(vcnl4200_ps_it_times);

As for previous, I'd much rather this was 'data' in the chip_spec structure
than code selecting it here.  That is I'd expect it to be arrange so this
part looks like.
		*vals = (int *)data->chip_spec->int_times;
		*length = 2 * data->chip_spec->num_int_times;

> +		} else {
> +			*vals = (int *)vcnl4040_ps_it_times;
> +			*length = 2 * ARRAY_SIZE(vcnl4040_ps_it_times);
> +		}
>  		*type = IIO_VAL_INT_PLUS_MICRO;
> -		*length = 2 * ARRAY_SIZE(vcnl4040_ps_it_times);
>  		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;

