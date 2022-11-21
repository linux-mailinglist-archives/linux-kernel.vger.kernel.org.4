Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5FF6329D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKUQmW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 11:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKUQmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:42:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B381ADA8;
        Mon, 21 Nov 2022 08:42:16 -0800 (PST)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGClr0LXGz67v9b;
        Tue, 22 Nov 2022 00:39:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 17:42:14 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 16:42:13 +0000
Date:   Mon, 21 Nov 2022 16:42:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <rajat.khandelwal@intel.com>
Subject: Re: [PATCH v10] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221121164212.00005484@Huawei.com>
In-Reply-To: <ed7b5e4e-cd3b-ab83-0b61-568b95656740@linux.intel.com>
References: <20221118153729.762018-1-rajat.khandelwal@linux.intel.com>
        <20221117163040.00001f5a@Huawei.com>
        <ed7b5e4e-cd3b-ab83-0b61-568b95656740@linux.intel.com>
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

On Fri, 18 Nov 2022 18:27:10 +0530
Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:

> Have provided inline comments.
> Please provide your comments for me to spin a v11 :)
> 
> On 11/17/2022 10:00 PM, Jonathan Cameron wrote:
> > On Fri, 18 Nov 2022 21:07:29 +0530
> > Rajat Khandelwal<rajat.khandelwal@linux.intel.com>  wrote:
> >  
> >> Maxim MAX30208 is a digital temperature sensor with 0.1°C accuracy.
> >>
> >> Add support for max30208 driver in iio subsystem.  
> > Blank line here.
> >  
> >> Datasheet:https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
> >>  
> > Datasheet part of the tags block, so no blank line between that and the SoB.
> > That makes life easy for tools parsing git messages.  
> 
> - Got it. Will do that.
> 
> >  
> >> Signed-off-by: Rajat Khandelwal<rajat.khandelwal@linux.intel.com>  
> > One query inline.  Basically boils down to what we do after
> > overflow occurs.  I assume you are right and the first reading is the most recent, but
> > I think we still want to flush the whole fifo in that case to get back to
> > a sane state for future reads.
> >
> > Jonathan
> >  
> >> +/**
> >> + * max30208_request() - Request a reading
> >> + * @data: Struct comprising member elements of the device
> >> + *
> >> + * Requests a reading from the device and waits until the conversion is ready.
> >> + */
> >> +static int max30208_request(struct max30208_data *data)
> >> +{
> >> +	/*
> >> +	 * Sensor can take up to 500 ms to respond so execute a total of
> >> +	 * 10 retries to give the device sufficient time.
> >> +	 */
> >> +	int retries = 10;
> >> +	u8 regval;
> >> +	int ret;
> >> +
> >> +	ret = i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	regval = ret | MAX30208_TEMP_SENSOR_SETUP_CONV;
> >> +
> >> +	ret = i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP, regval);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	while (retries--) {
> >> +		ret = i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +
> >> +		if (ret & MAX30208_STATUS_TEMP_RDY)
> >> +			return 0;
> >> +
> >> +		msleep(50);
> >> +	}
> >> +	dev_err(&data->client->dev, "Temperature conversion failed\n");
> >> +
> >> +	return -ETIMEDOUT;
> >> +}
> >> +
> >> +static int max30208_update_temp(struct max30208_data *data)
> >> +{
> >> +	u8 data_count;
> >> +	int ret;
> >> +
> >> +	mutex_lock(&data->lock);
> >> +
> >> +	ret = max30208_request(data);
> >> +	if (ret)
> >> +		goto unlock;
> >> +
> >> +	ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
> >> +	if (ret < 0)
> >> +		goto unlock;
> >> +	else if (!ret) {
> >> +		ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_DATA_CNTR);
> >> +		if (ret < 0)
> >> +			goto unlock;
> >> +
> >> +		data_count = ret;
> >> +	} else
> >> +		data_count = 1;
> >> +
> >> +	while (data_count) {
> >> +		ret = i2c_smbus_read_word_swapped(data->client, MAX30208_FIFO_DATA);
> >> +		if (ret < 0)
> >> +			goto unlock;
> >> +
> >> +		data_count--;
> >> +	}  
> > Hmm. Given you've been poking this a lot, I guess this works and the part is
> > as just odd. Just to check one last case... Does max30208_request() guarantee we can't
> > get...
> >
> > 1. Read first time, overflow set so we read latest result - leaving
> >     31 ancient values in the fifo.
> > 2. Read again really quickly and get those ancient values.
> > ?
> >
> > Perhaps we should flush out those unwanted values from the fifo, so after
> > overflow we get back to a normal state rather than immediately overflowing again.
> >
> > More than possible that I still don't understand how this device works though!  
> 
> - Ok, so whenever user wants a temperature reading, conversion first takes place and then
> the reading gets returned. So, user will always get the latest converted reading despite
> the number of ancient readings.
> Flushing everytime we get an overflow is not required I think because even though overflow
> could happen again, user still gets the latest updated reading. Also, I plan to incorporate
> buffered flow in IIO. Even though, I think let FIFO remain intact because it doesn't impact
> the recent readings.

Fair enough. Sounds like yes, we are guaranteed there will always be a new reading before
we start popping entries off the fifo again. If that's the case, all is fine as is - was
just really hard to figure that out from the code / datasheet, so I wanted to check.

Jonathan

> 
> >> +
> >> +unlock:
> >> +	mutex_unlock(&data->lock);
> >> +	return ret;
> >> +}
> >> +  

