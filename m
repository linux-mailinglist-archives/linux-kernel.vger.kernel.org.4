Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00314625F74
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiKKQ1C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Nov 2022 11:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiKKQ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:27:01 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CC7B229;
        Fri, 11 Nov 2022 08:26:57 -0800 (PST)
Received: from frapeml500004.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N83v83qdLz6823d;
        Sat, 12 Nov 2022 00:24:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500004.china.huawei.com (7.182.85.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 17:26:54 +0100
Received: from localhost (10.45.151.252) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 16:26:53 +0000
Date:   Fri, 11 Nov 2022 16:26:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v6] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221111162651.00004e3f@Huawei.com>
In-Reply-To: <CO1PR11MB4835AE2627AF1C441B6E4FC0963D9@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20221025171858.225242-1-rajat.khandelwal@linux.intel.com>
        <20221029160353.3999849b@jic23-huawei>
        <CO1PR11MB4835BF50AD0BED735350F5B196379@CO1PR11MB4835.namprd11.prod.outlook.com>
        <20221106115705.623503c3@jic23-huawei>
        <CO1PR11MB483574B32554D41253DE6A93963D9@CO1PR11MB4835.namprd11.prod.outlook.com>
        <20221106125020.1e546305@jic23-huawei>
        <CO1PR11MB4835AE2627AF1C441B6E4FC0963D9@CO1PR11MB4835.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.45.151.252]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Sun, 6 Nov 2022 17:32:03 +0000
"Khandelwal, Rajat" <rajat.khandelwal@intel.com> wrote:

> Hi Jonathan,
> This is really weird and I don’t know how could I be so mistaken. So, actually on page 29 of datasheet,
> its given that this RO bit is on 1st position and its default value of 0x0 on reset. I impetuously considered
> the number "1" written above and took it for the default value. All this time, I have been thinking that
> this bit is already set to "1" and really not paying attention to it. 
> Thanks Jonathan for pointing it out. Maybe I even missed it in my dry runs because the temperature
> was not varying at the same place the sensor was kept. 
> 
> Before sending out v8 (probably the last one I hope), I would like to make sure that there are 3 last
> changes to be done.
> 1. Not returning previous stale values if temperature conversion gets complete. Simply returning error. 
> 2. Setting up GPIO FIFO_RO. 
> 3. Dropping ACPI_PTR 

I've lost track (busy week!), but that sounds likely roughly what I remember being outstanding.

> 
> On the algorithm end, I think it should remain the same because first I count the number of data words to
> be popped out before I get a reading (for overflow, it is the number of words which get rewritten and for
> normal case, it is the FIFO data count register value). Then I would keep popping up that many values until
> I reach the end which gives me the current converted reading. 
> Please let me know if there is still doubt or you think if its erroneous?
That's fine when operating in what I'll call 'ring buffer' mode :)
> 
> I am still in shock of how I could have possibly misread the datasheet! Maybe I was in a hurry of submitting
> the patch?
> I will be careful next time. 
> 
> Thanks Jonathan for being patient with me. :)

No problem.  One advantage of reading a lot of similar code is I kind of know
how I expect things to work.  As long as they conform to that model, I tend not
to dive deep in data sheets.  When something new happens I get suspicious
and start looking closely.

Jonathan

> 
> Thanks
> Rajat
> 
> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org> 
> Sent: Sunday, November 6, 2022 6:20 PM
> To: Khandelwal, Rajat <rajat.khandelwal@intel.com>
> Cc: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>; lars@metafoo.de; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; jdelvare@suse.com; linux@roeck-us.net; linux-hwmon@vger.kernel.org
> Subject: Re: [PATCH v6] iio: temperature: Add driver support for Maxim MAX30208
> 
> 
> >   
> > >     
> > > > Error return to indicate what happened - there is one for timeouts.      
> > > As indicated above, if you are in for that, then here we should 
> > > ideally return 0 since even after the error, we want update_temp to do its job and return the last reading.
> > >     
> > > >Whilst you debated this logic with Guenter in v5, I don't follow the conclusion.
> > > >If FIFO_OVF_CNTR > 0 then FIFO_DATA_CNTR == maximum value.  Logic 
> > > >of this is given in FIFO_DATA Read Example (Page 16 of the spec)  
> > > >It doesn't matter as such because you read FIFO_DATA_CNTR again 
> > > >anyway, but it would be more obvious what is going on if you just set data_count = 32 if overflow has occured.
> > > >
> > > >The only thing I would argue you 'might' want to do with the 
> > > >overflow counter is to use it to indicate we need to read at least the number of elements in the fifo.
> > > >If there are no additional elements at the end, wait until there is 
> > > >one. Otherwise you potentially get very stale data - it might have 
> > > >been overflowing for a long time) This decrease by more than 1 is 
> > > >worrying.  I can understand it not decreasing, or even increasing 
> > > >(new data came in), but this condition sounds either like we are doing something wrong or there is a hardware bug.  
> > > Ok, even I started doubting the nature of the device I encountered when I tested it.
> > > The thing is, this driver also comes with an EV kit wherein you can 
> > > plug into PC, download the software and interface it via USB. 
> > > Whenever I emulated reads from the OS, I encountered erroneous counter decrements.
> > > However, I have tested it using native I2C on my microcontroller and 
> > > I don't ever encounter such readings, thus concluding that the 
> > > spurious erroneous zones only exist when the EV kit is interfaced via USB.
> > > Thanks for creating this doubt. I have solved it by only 
> > > decrementing data_count unless it becomes 0.
> > > Regarding data_count variable, so when overflow counter is >0, I want to decrease 'overflow counter'
> > > number of times to get the required reading and when overflow 
> > > counter is =0, I want to decrease 'data counter' number of times to get the reading. Hope it makes sense now in the new version.  
> >   
> > >That isn't how I read the datasheet. 
> > >
> > >OVF_COUNTER (address 0x06), Overflow Counter OVF_COUNTER[4:0] logs the number of words lost if new words are written after the FIFO is>full. ... Each time a complete word is popped from the FIFO, the OVF_COUNTER is reset to zero.
> > >
> > >so if you get overflow counter set, then you should drain the fifo completely (it is stale) and wait for one new reading to turn up so that we >know we have something fresh.
> > >That reading may well turn up whilst you are busy draining the fifo and if so that is fine to use - if not you should wait a bit longer until one >does.    
> 
> Guessing you are using outlook or similar with it's habit of deciding it knows better on line wraps and lack of undestanding of > characters.
> 
> Ah well, I've rewrapped your reply to make it readable on a client set up for kernel mailing list reading.
> 
> > I don’t understand why do we have to drain the FIFO completely? Two 
> > things. First, even after the overflow the last place at which the 
> > overflow happened would be still the latest reading, right?  
> 
> It's the latest reading we have but it could be from last week.
> 
> > So let's
> > say overflow happens and a value of X gets placed in place of Y 
> > (previous value).  
> 
> Ah.  I'd assumed that this worked like a FIFO given the naming in which case that value X would be dropped if the FIFO is full.
> Turns out that is dependent on mode on this device.  The FIFO_RO bit stops this being a fifo and instead makes it a ring buffer with oldest sample dropped.  Default of that value though is 0 and I don't think you write it...  To get the behaviour you describe it would need to be written to 1.  So as it stands the data dropped should be the newest data, not the oldest data.
> 
> 
> > It won't matter to me because I will be reading X, which is the 
> > correct version of reading I want to give to user this time and 
> > popping out the whole FIFO (32 words) would incur additional delays.  
> 
> I don't follow this.  The 'fifo' (be it operating as a fifo or a ring) always reads out oldest data that it contains first.
> So you if it is full you have to read the whole thing to get the most recent reading.
> 
> > Second, in the previous versions I reported that I want to use the 
> > previous known readings also and also the two GPIOs. This would be 
> > provided to you for verification in subsequent patches but those would 
> > mean that clearing the FIFO on every overflow would completely 
> > undermine these features. I would have to again incorporate the same 
> > logic to implement these features in the future. :)  
> 
> I'm not following.  If you move to using the all the infrastructure for buffered data flows in IIO you'll not be dropping anything (except when an error condition or very long delay occurred).  That's a different path entirely however and you will probably still want a way to grab a single recent temperature reading.
> 
> With the buffered flow, whenever you get a fifo watershed interrupt (nearly full here) you drain all the content into a software fifo that is what userspace actually talks to.  (there are some other tricks to do that on demand for latency reduction).
> 
> Jonathan
> 
> 
> >   
> > >Please reply inline rather than pulling comments to top of email to reply to them.
> > >Pulling them to the top removes the context that can be crucial in understanding the comment.    
> > Sure.
> > 
> > Thanks
> > Rajat
> > 
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, November 6, 2022 5:27 PM
> > To: Khandelwal, Rajat <rajat.khandelwal@intel.com>
> > Cc: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>; 
> > lars@metafoo.de; linux-kernel@vger.kernel.org; 
> > linux-iio@vger.kernel.org; jdelvare@suse.com; linux@roeck-us.net; 
> > linux-hwmon@vger.kernel.org
> > Subject: Re: [PATCH v6] iio: temperature: Add driver support for Maxim 
> > MAX30208
> > 
> > On Mon, 31 Oct 2022 17:24:51 +0000
> > "Khandelwal, Rajat" <rajat.khandelwal@intel.com> wrote:
> > 
> >   
> > >     
> > > >I agree with Guenter's comment that this is a bit overly noisy. We 
> > > >don't expect random register reads to fail + IIRC there is tracing in the i2c subsystem if we
> > > >are getting such errors.   Hence probably reduce the error to cover only larger
> > > >blocks of code.  Reasonable to report that the temperature request failed perhaps.      
> > > So, I kind of just started upstreaming matches in the IIO community 
> > > also for change of domains and on seeing other drivers which were 
> > > returning on each error, I thought maybe its required in IIO? Thanks for this comment. I have removed them.  
> > 
> > It's a question of balance.  Mostly I don't complain too much on where 
> > an individual author decides that balance lies (as it doesn't really 
> > matter, but seeing as Guenter had already raised it I commented this 
> > time ;)  
> > >     
> > > >dev_err()  Failing isn't expected so it's a device error not 
> > > >something we should merely warn about.  
> > > Ok, so here I have incorporated dev_err but what I wanted was if 
> > > MAX30208_STATUS_TEMP_RDY is written successfully and any error 
> > > happens after that, the user still gets returned the most recent 
> > > reading when this operation fails. So, I have changed it into dev_err with printing "Temperature conversion failed, reporting the last known reading...") Will that be ok?  
> > 
> > It is a condition that we really don't expect to happen and we don't know how stale the reading is.  So I'd just report an error.  Userspace can read again if it thinks the error is likely to be resolved.
> >   
> > >     
> > > > Error return to indicate what happened - there is one for timeouts.      
> > > As indicated above, if you are in for that, then here we should 
> > > ideally return 0 since even after the error, we want update_temp to do its job and return the last reading.
> > >     
> > > >Whilst you debated this logic with Guenter in v5, I don't follow the conclusion.
> > > >If FIFO_OVF_CNTR > 0 then FIFO_DATA_CNTR == maximum value.  Logic 
> > > >of this is given in FIFO_DATA Read Example (Page 16 of the spec)  
> > > >It doesn't matter as such because you read FIFO_DATA_CNTR again 
> > > >anyway, but it would be more obvious what is going on if you just set data_count = 32 if overflow has occured.
> > > >
> > > >The only thing I would argue you 'might' want to do with the 
> > > >overflow counter is to use it to indicate we need to read at least the number of elements in the fifo.
> > > >If there are no additional elements at the end, wait until there is 
> > > >one. Otherwise you potentially get very stale data - it might have 
> > > >been overflowing for a long time) This decrease by more than 1 is 
> > > >worrying.  I can understand it not decreasing, or even increasing 
> > > >(new data came in), but this condition sounds either like we are doing something wrong or there is a hardware bug.  
> > > Ok, even I started doubting the nature of the device I encountered when I tested it.
> > > The thing is, this driver also comes with an EV kit wherein you can 
> > > plug into PC, download the software and interface it via USB. 
> > > Whenever I emulated reads from the OS, I encountered erroneous counter decrements.
> > > However, I have tested it using native I2C on my microcontroller and 
> > > I don't ever encounter such readings, thus concluding that the 
> > > spurious erroneous zones only exist when the EV kit is interfaced via USB.
> > > Thanks for creating this doubt. I have solved it by only 
> > > decrementing data_count unless it becomes 0.
> > > Regarding data_count variable, so when overflow counter is >0, I want to decrease 'overflow counter'
> > > number of times to get the required reading and when overflow 
> > > counter is =0, I want to decrease 'data counter' number of times to get the reading. Hope it makes sense now in the new version.  
> > 
> > That isn't how I read the datasheet. 
> > 
> > OVF_COUNTER (address 0x06), Overflow Counter OVF_COUNTER[4:0] logs the number of words lost if new words are written after the FIFO is full. ... Each time a complete word is popped from the FIFO, the OVF_COUNTER is reset to zero.
> > 
> > so if you get overflow counter set, then you should drain the fifo completely (it is stale) and wait for one new reading to turn up so that we know we have something fresh.
> > That reading may well turn up whilst you are busy draining the fifo and if so that is fine to use - if not you should wait a bit longer until one does.
> > 
> > 
> > Please reply inline rather than pulling comments to top of email to reply to them.
> > Pulling them to the top removes the context that can be crucial in understanding the comment.
> > 
> > Jonathan
> >   
> > > 
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Saturday, October 29, 2022 8:34 PM
> > > To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > > Cc: lars@metafoo.de; linux-kernel@vger.kernel.org; 
> > > linux-iio@vger.kernel.org; jdelvare@suse.com; linux@roeck-us.net; 
> > > linux-hwmon@vger.kernel.org; Khandelwal, Rajat 
> > > <rajat.khandelwal@intel.com>
> > > Subject: Re: [PATCH v6] iio: temperature: Add driver support for 
> > > Maxim
> > > MAX30208
> > > 
> > > On Tue, 25 Oct 2022 22:48:58 +0530
> > > Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:
> > >     
> > > > Maxim MAX30208 is a digital temperature sensor with 0.1°C accuracy.
> > > > 
> > > > Add support for max30208 driver in iio subsystem.
> > > > Datasheet: 
> > > > https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
> > > > 
> > > > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>  
> > > 
> > > Hi Rajat,
> > > 
> > > Consider using regmap for this. It will provide you with some helpful utility functions.  I don't mind you sticking to direct i2c calls though if you prefer.
> > > 
> > > Quite a few things inline that have been commented on in previous reviews.
> > > Make sure you incorporate all feedback or you'll end up going through more versions than would otherwise be necessary.
> > > 
> > > Jonathan
> > >     
> > > > diff --git a/drivers/iio/temperature/Makefile
> > > > b/drivers/iio/temperature/Makefile
> > > > index dd08e562ffe0..dfec8c6d3019 100644
> > > > --- a/drivers/iio/temperature/Makefile
> > > > +++ b/drivers/iio/temperature/Makefile
> > > > @@ -7,6 +7,7 @@ obj-$(CONFIG_IQS620AT_TEMP) += iqs620at-temp.o
> > > >  obj-$(CONFIG_LTC2983) += ltc2983.o
> > > >  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
> > > >  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> > > > +obj-$(CONFIG_MAX30208) += max30208.o
> > > >  obj-$(CONFIG_MAX31856) += max31856.o
> > > >  obj-$(CONFIG_MAX31865) += max31865.o
> > > >  obj-$(CONFIG_MLX90614) += mlx90614.o diff --git 
> > > > a/drivers/iio/temperature/max30208.c
> > > > b/drivers/iio/temperature/max30208.c
> > > > new file mode 100644
> > > > index 000000000000..41b26755ce27
> > > > --- /dev/null
> > > > +++ b/drivers/iio/temperature/max30208.c
> > > > @@ -0,0 +1,323 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +/*
> > > > + * Copyright (c) Rajat Khandelwal 
> > > > +<rajat.khandelwal@linux.intel.com>
> > > > + *
> > > > + * Maxim MAX30208 digital temperature sensor with 0.1°C accuracy
> > > > + * (7-bit I2C slave address (0x50 - 0x53))
> > > > + *
> > > > + * Note: This driver sets GPIO1 to behave as input for temperature
> > > > + * conversion and GPIO0 to act as interrupt for temperature conversion.      
> > > 
> > > It doesn't use them, so unless you have to be in that state to use the current method, drop the note and don't set them to do that.
> > > 
> > > You can add that support if / when the driver supports it.
> > >     
> > > > + */
> > > > +
> > > > +#include <linux/bitops.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +#define MAX30208_DRV_NAME		"max30208"      
> > > 
> > > Mentioned below, but I'd prefer to see the string directly inline.
> > >     
> > > > +
> > > > +#define MAX30208_STATUS			0x00
> > > > +#define MAX30208_STATUS_TEMP_RDY	BIT(0)
> > > > +#define MAX30208_INT_ENABLE		0x01
> > > > +#define MAX30208_INT_ENABLE_TEMP_RDY	BIT(0)
> > > > +
> > > > +#define MAX30208_FIFO_OVF_CNTR		0x06
> > > > +#define MAX30208_FIFO_DATA_CNTR		0x07
> > > > +#define MAX30208_FIFO_DATA		0x08
> > > > +
> > > > +#define MAX30208_SYSTEM_CTRL		0x0c
> > > > +#define MAX30208_SYSTEM_CTRL_RESET	0x01
> > > > +
> > > > +#define MAX30208_TEMP_SENSOR_SETUP	0x14
> > > > +#define MAX30208_TEMP_SENSOR_SETUP_CONV	BIT(0)
> > > > +
> > > > +#define MAX30208_GPIO_SETUP		0x20
> > > > +#define MAX30208_GPIO1_SETUP		GENMASK(7, 6)
> > > > +#define MAX30208_GPIO0_SETUP		GENMASK(1, 0)
> > > > +#define MAX30208_GPIO_CTRL		0x21
> > > > +#define MAX30208_GPIO1_CTRL		BIT(3)
> > > > +#define MAX30208_GPIO0_CTRL		BIT(0)
> > > > +
> > > > +struct max30208_data {
> > > > +	struct i2c_client *client;
> > > > +	struct iio_dev *indio_dev;
> > > > +	struct mutex lock; /* Lock to prevent concurrent reads */  
> > > 
> > > Be more explicit - reads of what?
> > >     
> > > > +};
> > > > +
> > > > +static const struct iio_chan_spec max30208_channels[] = {
> > > > +	{
> > > > +		.type = IIO_TEMP,
> > > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > > > +	},
> > > > +};
> > > > +
> > > > +/**
> > > > + * max30208_request() - Request a reading
> > > > + * @data: Struct comprising member elements of the device
> > > > + *
> > > > + * Requests a reading from the device and waits until the conversion is ready.
> > > > + */
> > > > +static int max30208_request(struct max30208_data *data) {
> > > > +	/*
> > > > +	 * Sensor can take up to 500 ms to respond so execute a total of
> > > > +	 * 10 retries to give the device sufficient time.
> > > > +	 */
> > > > +	int retries = 10;
> > > > +	u8 regval;
> > > > +	int ret;
> > > > +
> > > > +	ret = i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&data->client->dev, "Error reading reg temperature 
> > > > +setup\n");  
> > > 
> > > I agree with Guenter's comment that this is a bit overly noisy. We don't expect random register reads to fail + IIRC there is tracing in the i2c subsystem if we
> > > are getting such errors.   Hence probably reduce the error to cover only larger
> > > blocks of code.  Reasonable to report that the temperature request failed perhaps.
> > > 
> > >     
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	regval = ret | MAX30208_TEMP_SENSOR_SETUP_CONV;
> > > > +
> > > > +	ret = i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP, regval);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&data->client->dev, "Error writing reg temperature setup\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	while (retries--) {
> > > > +		ret = i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> > > > +		if (ret < 0) {
> > > > +			dev_err(&data->client->dev, "Error reading reg status\n");
> > > > +			goto sleep;  
> > > 
> > > Can this happen for a documented reason?  If not treat it as a comms error and return it.
> > >     
> > > > +		}
> > > > +
> > > > +		if (ret & MAX30208_STATUS_TEMP_RDY)
> > > > +			return 0;
> > > > +
> > > > +		msleep(50);
> > > > +	}
> > > > +	dev_warn(&data->client->dev, "Temperature conversion failed\n");  
> > > 
> > > dev_err()  Failing isn't expected so it's a device error not something we should merely warn about.
> > >     
> > > > +
> > > > +	return 0;  
> > > Error return to indicate what happened - there is one for timeouts.
> > >     
> > > > +
> > > > +sleep:      
> > > 
> > > Why sleep in an error path?  It's failed - why do we think sleeping is a good idea?
> > >     
> > > > +	msleep(50);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int max30208_update_temp(struct max30208_data *data) {
> > > > +	u8 data_count;
> > > > +	int ret;
> > > > +
> > > > +	mutex_lock(&data->lock);
> > > > +
> > > > +	ret = max30208_request(data);
> > > > +	if (ret < 0)
> > > > +		goto unlock;
> > > > +
> > > > +	ret = i2c_smbus_read_byte_data(data->client,
> > > > +MAX30208_FIFO_OVF_CNTR);  
> > > Whilst you debated this logic with Guenter in v5, I don't follow the conclusion.
> > > If FIFO_OVF_CNTR > 0 then FIFO_DATA_CNTR == maximum value.  Logic of this is given in FIFO_DATA Read Example (Page 16 of the spec)  It doesn't matter as such because you read FIFO_DATA_CNTR again anyway, but it would be more obvious what is going on if you just set data_count = 32 if overflow has occured.
> > > 
> > > The only thing I would argue you 'might' want to do with the overflow counter is to use it to indicate we need to read at least the number of elements in the fifo.
> > > If there are no additional elements at the end, wait until there is 
> > > one. Otherwise you potentially get very stale data - it might have 
> > > been overflowing for a long time)
> > >     
> > > > +	if (ret < 0) {
> > > > +		dev_err(&data->client->dev, "Error reading reg FIFO overflow counter\n");
> > > > +		goto unlock;
> > > > +	} else if (!ret) {
> > > > +		ret = i2c_smbus_read_byte_data(data->client,
> > > > +					       MAX30208_FIFO_DATA_CNTR);
> > > > +		if (ret < 0) {
> > > > +			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
> > > > +			goto unlock;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	data_count = ret;
> > > > +
> > > > +	/*
> > > > +	 * Ideally, counter should decrease by 1 each time a word is read from FIFO.
> > > > +	 * However, practically, the device behaves erroneously and counter sometimes
> > > > +	 * decreases by more than 1. Hence, do not loop the counter until it becomes 0
> > > > +	 * rather, use the exact counter value after each FIFO word is read.      
> > > 
> > > This decrease by more than 1 is worrying.  I can understand it not decreasing, or even increasing (new data came in), but this condition sounds either like we are doing something wrong or there is a hardware bug.
> > >     
> > > > +	 * Return the last reading from FIFO as the most recently 
> > > > +triggered one  
> > > 
> > > Not necessarily recent (even if most recent available). Imagine this runs after overflow and runs really quickly.
> > > You may not get a new reading.
> > >     
> > > > +	 */
> > > > +	while (data_count) {
> > > > +		ret = i2c_smbus_read_word_swapped(data->client,
> > > > +						  MAX30208_FIFO_DATA);
> > > > +		if (ret < 0) {
> > > > +			dev_err(&data->client->dev, "Error reading reg FIFO data\n");
> > > > +			goto unlock;
> > > > +		}
> > > > +
> > > > +		data_count = i2c_smbus_read_byte_data(data->client,
> > > > +						      MAX30208_FIFO_DATA_CNTR);
> > > > +		if (data_count < 0) {
> > > > +			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
> > > > +			ret = data_count;  
> > > 
> > > Flip this around so you consistently use ret for return values.  We still have problem that data_count is a u8 so the above test is invalid.
> > > 
> > > 		ret = i2c_smbus_read_byte_data(data->client, ...)
> > > 		if (ret < 0) {
> > > 			dev_err(..);
> > > 			goto unlock
> > > 		}
> > > 		data_count = ret;
> > > 
> > > Guenter pointed this out in v5.
> > >     
> > > > +			goto unlock;
> > > > +		}
> > > > +	}
> > > > +
> > > > +unlock:
> > > > +	mutex_unlock(&data->lock);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int max30208_read(struct iio_dev *indio_dev,
> > > > +			 struct iio_chan_spec const *chan,
> > > > +			 int *val, int *val2, long mask) {
> > > > +	struct max30208_data *data = iio_priv(indio_dev);
> > > > +	int ret;
> > > > +
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		ret = max30208_update_temp(data);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +
> > > > +		*val = sign_extend32(ret, 15);
> > > > +		return IIO_VAL_INT;
> > > > +
> > > > +	case IIO_CHAN_INFO_SCALE:
> > > > +		*val = 5;
> > > > +		return IIO_VAL_INT;
> > > > +
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}
> > > > +
> > > > +static int max30208_gpio_setup(struct max30208_data *data) {
> > > > +	u8 regval;
> > > > +	int ret;
> > > > +
> > > > +	ret = i2c_smbus_read_byte_data(data->client,
> > > > +				       MAX30208_GPIO_SETUP);  
> > > 
> > > Excessive line breaks.  This is under 80 chars.  In cases where readability is helped by going above that (though under 100 chars) that is fine too.  Make sure you tidy up all similar cases.
> > >     
> > > > +	if (ret < 0) {
> > > > +		dev_err(&data->client->dev, "Error reading reg GPIO setup\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Setting GPIO1 to trigger temperature conversion
> > > > +	 * when driven low.
> > > > +	 * Setting GPIO0 to trigger interrupt when temperature
> > > > +	 * conversion gets completed.
> > > > +	 */
> > > > +	regval = ret | MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP;  
> > > 
> > > If the driver 'works' in current form without setting this stuff up I would prefer that you leave this until you have a patch actually using the GPIO signals.
> > > That way we can review all the GPIO related code together.
> > >     
> > > > +	ret = i2c_smbus_write_byte_data(data->client,
> > > > +					MAX30208_GPIO_SETUP, regval);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&data->client->dev, "Error writing reg GPIO setup\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret = i2c_smbus_read_byte_data(data->client,
> > > > +				       MAX30208_INT_ENABLE);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&data->client->dev, "Error reading reg interrupt enable\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	/* Enabling GPIO0 interrupt */
> > > > +	regval = ret | MAX30208_INT_ENABLE_TEMP_RDY;  
> > > 
> > > This belongs in a patch adding interrupt support. It should not be here until then.
> > >     
> > > > +	ret = i2c_smbus_write_byte_data(data->client,
> > > > +					MAX30208_INT_ENABLE, regval);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&data->client->dev, "Error writing reg interrupt enable\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct iio_info max30208_info = {
> > > > +	.read_raw = max30208_read,
> > > > +};
> > > > +
> > > > +static int max30208_probe(struct i2c_client *i2c) {
> > > > +	struct device *dev = &i2c->dev;
> > > > +	struct max30208_data *data;
> > > > +	struct iio_dev *indio_dev;
> > > > +	int ret;
> > > > +
> > > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > > > +	if (!indio_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	data = iio_priv(indio_dev);
> > > > +	data->client = i2c;
> > > > +	mutex_init(&data->lock);
> > > > +
> > > > +	indio_dev->name = MAX30208_DRV_NAME;  
> > > 
> > > I'm not a huge fan of defines either here or in the driver structure initializer.
> > > The reason being that we need clear visibility of these strings and there is no particular reason why they are the same.
> > > So I'd prefer getting rid of that define and putting the strings directly in both locations.
> > >     
> > > > +	indio_dev->channels = max30208_channels;
> > > > +	indio_dev->num_channels = ARRAY_SIZE(max30208_channels);
> > > > +	indio_dev->info = &max30208_info;
> > > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > > +
> > > > +	/* Reset the device initially */  
> > > 
> > > The expressive nature of the field define makes it obvious this is a reset.
> > > so I would drop the comment.  There is a price in maintainability to comments (they often become wrong over time as a driver evolves).  As such keep them for places where the comment tells us something not easily seen from the code.
> > >     
> > > > +	ret = i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
> > > > +					MAX30208_SYSTEM_CTRL_RESET);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failure in performing reset\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	msleep(50);
> > > > +
> > > > +	ret = max30208_gpio_setup(data);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	ret = devm_iio_device_register(dev, indio_dev);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to register IIO device\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct i2c_device_id max30208_id_table[] = {
> > > > +	{ "max30208" },
> > > > +	{ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i2c, max30208_id_table);
> > > > +
> > > > +static const struct acpi_device_id max30208_acpi_match[] = {
> > > > +	{ "MAX30208" },
> > > > +	{ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(acpi, max30208_acpi_match);
> > > > +
> > > > +static const struct of_device_id max30208_of_match[] = {
> > > > +	{ .compatible = "maxim,max30208" },
> > > > +	{ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, max30208_of_match);
> > > > +
> > > > +static struct i2c_driver max30208_driver = {
> > > > +	.driver = {
> > > > +		.name = MAX30208_DRV_NAME,
> > > > +		.of_match_table = max30208_of_match,
> > > > +		.acpi_match_table = ACPI_PTR(max30208_acpi_match),  
> > > 
> > > Try building without ACPI support and you should see a warning from the compiler.  Sadly ACPI_PTR() is not as smart as it should be.
> > > If interested, take a look at how pm_ptr() deals with the same issue.
> > > 
> > > Anyhow, best option is just don't bother with ACPI_PTR().
> > > The saving in module size is trivial and not worth the ifdef magic needed to make it work warning free.
> > > 
> > >     
> > > > +	},
> > > > +	.probe_new = max30208_probe,
> > > > +	.id_table = max30208_id_table,
> > > > +};
> > > > +
> > > > +static int __init max30208_init(void) {
> > > > +	return i2c_add_driver(&max30208_driver); } 
> > > > +module_init(max30208_init);
> > > > +
> > > > +static void __exit max30208_exit(void) {
> > > > +	i2c_del_driver(&max30208_driver); } module_exit(max30208_exit);  
> > > 
> > > module_i2c_driver() to get rid of this boilerplate.
> > > 
> > > Note this was a comment I made on v1... I wondered if I'd been half 
> > > asleep so went looking :)
> > > 
> > > Jonathan
> > >     
> >   
> 

