Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49420735B87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFSPuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjFSPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:50:36 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5EA4;
        Mon, 19 Jun 2023 08:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687189835;
  x=1718725835;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=jV18MHlcdS/4W3J35UCUnXhAnFfGk9RQbYDuqUPQ4r8=;
  b=TSLn6bEzHoHeP1JS2TVLwYHfJxfbNYg0w8Q9Va4bVKHagwvmaML4E6o9
   UXOJwU0NkbLTjvUjvpHq9KRVe50mcc8AM7zUF+imF5dUNtgxr0VYLYsUM
   cIRowHYKCN+k5m+TjiNXgzpv4//kDu5Erton5xmPi3tDEU6bURCdJgwk2
   qhJcNrcAyQHdjEzUIquc70FgpaUTR1p/f8gh0fX9qqYag261Xv9rGYZ5t
   JKVZgIxD4CM0zHHH8BEsD4Ke105FGG1wFLGATyt73UpLj9jOwkFEh3JTt
   plDptDQasvwrB2a+Dx1rckaSjZXeucpAKcxC51uNwaxiiqNM7PsMvviux
   Q==;
References: <cover.1686926857.git.waqarh@axis.com>
 <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
 <682cf4f8-ba1b-d74a-c744-6aa484c1acd5@metafoo.de>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <kernel@lists.axis.com>
Subject: Re: [PATCH 2/2] iio: Add driver for Murata IRS-D200
Date:   Mon, 19 Jun 2023 13:21:51 +0200
In-Reply-To: <682cf4f8-ba1b-d74a-c744-6aa484c1acd5@metafoo.de>
Message-ID: <pndsfan1mev.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 18:37 -0700 Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 6/16/23 08:10, Waqar Hameed wrote:
>> Murata IRS-D200 is a PIR sensor for human detection. It has support for
>> raw data measurements and detection event notification.
>>
>> Add a driver with support for triggered buffer and events. Map the
>> various settings to the `iio` framework, e.g. threshold values, sampling
>> frequency, filter frequencies etc.
>>
>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>
> Looks very good, small minor comments.

Thanks!

[...]

>> index 000000000000..699801d60295
>> --- /dev/null
>> +++ b/drivers/iio/proximity/irsd200.c
>> @@ -0,0 +1,1051 @@
>> [...]
>> +/*
>> + * The upper 4 bits in register IRS_REG_COUNT value is the upper count value
>> + * (exceeding upper threshold value). The lower 4 is the lower count value
>> + * (exceeding lower threshold value).
>> + */
>> +#define IRS_UPPER_COUNT(count)	(count >> 4)
>> +#define IRS_LOWER_COUNT(count)	(count & GENMASK(3, 0))
>
> Usually we add parenthesis around macro arguments to avoid issues in case the
> argument is a non-singular expression.

Of course! Will use `FIELD_GET()` as Jonathan suggests.

>> [...]
>>
>> +static int irsd200_read_data(struct irsd200_data *data, s16 *val)
>> +{
>> +	unsigned int tmpval;
>> +	int ret;
>> +
>> +	ret = regmap_read(data->regmap, IRS_REG_DATA_HI, &tmpval);
>> +	if (ret < 0) {
>> +		dev_err(data->dev, "Could not read hi data (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	*val = (s16)(tmpval << 8);
>> +
>> +	ret = regmap_read(data->regmap, IRS_REG_DATA_LO, &tmpval);
>> +	if (ret < 0) {
>> +		dev_err(data->dev, "Could not read lo data (%d)\n", ret);
>> +		return ret;
>> +	}
> Is there a way to bulk read those registers in one go to avoid inconsistent data
> if they change while being read?

Yes, will use `regmap_bulk_read()`.

>> +	*val |= tmpval;
>> +
>> +	return 0;
>> +}
>> [...]
>> +static int irsd200_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan, int val,
>> +			     int val2, long mask)
>> +{
>> +	struct irsd200_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		ret = irsd200_write_data_rate(data, val);
>> +		return ret;
> Maybe just `return irsd200_write_data_rate(...)`

Of course! (Remnant from a refactorization... Sorry!)

>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>
>> [...]
>> +static int irsd200_probe(struct i2c_client *client)
>> +{
>> +	struct iio_trigger *trigger;
>> +	struct irsd200_data *data;
>> +	struct iio_dev *indio_dev;
>> +	struct regmap *regmap;
>> +	size_t i;
>> +	int ret;
>> +
>> +	regmap = devm_regmap_init_i2c(client, &irsd200_regmap_config);
>> +	if (IS_ERR(regmap)) {
>> +		dev_err(&client->dev, "Could not initialize regmap\n");
> dev_err_probe() is the more modern variant for error reporting in the probe
> function. Same for all the other dev_err() in this function.

Alright, I'll change to `dev_err_probe()`.
