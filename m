Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67144649D36
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiLLLJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiLLLJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:09:00 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5CD12624;
        Mon, 12 Dec 2022 02:59:06 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NVz7j6kFBz6J7DH;
        Mon, 12 Dec 2022 18:56:01 +0800 (CST)
Received: from localhost (10.195.246.54) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 10:59:03 +0000
Date:   Mon, 12 Dec 2022 10:59:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ferry Toth <fntoth@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 01/11] iio: light: tsl2563: Do not hardcode interrupt
 trigger type
Message-ID: <20221212105902.000059a4@Huawei.com>
In-Reply-To: <c48cc4ff-9021-0e32-6e68-89fa549847cc@gmail.com>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
        <20221211132611.0ab2f29e@jic23-huawei>
        <c48cc4ff-9021-0e32-6e68-89fa549847cc@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.246.54]
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

On Sun, 11 Dec 2022 18:14:01 +0100
Ferry Toth <fntoth@gmail.com> wrote:

> Hi,
> 
> Op 11-12-2022 om 14:26 schreef Jonathan Cameron:
> > On Wed,  7 Dec 2022 21:03:38 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> >> From: Ferry Toth <ftoth@exalondelft.nl>
> >>
> >> Instead of hardcoding IRQ trigger type to IRQF_TRIGGER_RAISING,
> >> let's respect the settings specified in the firmware description.
> >> To be compatible with the older firmware descriptions, if trigger
> >> type is not set up there, we'll set it to default (raising edge).
> >>
> >> Fixes: 388be4883952 ("staging:iio: tsl2563 abi fixes and interrupt handling")
> >> Fixes: bdab1001738f ("staging:iio:light:tsl2563 remove old style event registration.")
> >> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Andy, would have preferred a cover letter, so I had an obvious place
> > to reply to the whole series...
> > 
> > Mostly I'm amazed anyone still has one of these devices (I have one but
> > it's on a break out board for the stargate2/imote2 pxa27x platform that we
> > dropped support for last year - I hadn't booted it for a few years)
> > - I can probably bodge it onto something else but I can't say it was
> > high on my todo list ;)  So nice to know that someone still cares about
> > this.
> > 
> > So I'm curious Ferry, what device has one of these?  
> 
> It's a breakout board too. I think it's something like GY-2561.
> 
> I wanted to write up an example how to get connect iio sensors to work 
> with linux. So I asked my colleague who is a great fan of aliexpress if 
> he had any sensor on a breakout board with I2C. In the past I had it 
> working with MRAA and UPM but that seems to be a dead end now.
> 
> We have ACPI working on Intel Edison-Arduino with quite a few examples 
> from Andy. And the "Arduino" header makes it very easy to wire up these 
> kind of breakout boards, fantastic platform this type of developments.
> 
> Just wiring up the I2C and get it to work was easy enough. And then the 
> interrupt pin makes an interesting example (even though likely useless 
> for most applications of the light sensor).
> 
> Write-up here if you are interested:
> https://htot.github.io/meta-intel-edison/4.6-libiio.html

Thanks!

Jonathan

> 
> > Whole series applied to the togreg branch of iio.git though note I'll only
> > push this out as testing for now because I'll want to rebase that tree
> > after rc1 is available.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> ---
> >>   drivers/iio/light/tsl2563.c | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> >> index d0e42b73203a..71302ae864d9 100644
> >> --- a/drivers/iio/light/tsl2563.c
> >> +++ b/drivers/iio/light/tsl2563.c
> >> @@ -704,6 +704,7 @@ static int tsl2563_probe(struct i2c_client *client)
> >>   	struct iio_dev *indio_dev;
> >>   	struct tsl2563_chip *chip;
> >>   	struct tsl2563_platform_data *pdata = client->dev.platform_data;
> >> +	unsigned long irq_flags;
> >>   	int err = 0;
> >>   	u8 id = 0;
> >>   
> >> @@ -759,10 +760,15 @@ static int tsl2563_probe(struct i2c_client *client)
> >>   		indio_dev->info = &tsl2563_info_no_irq;
> >>   
> >>   	if (client->irq) {
> >> +		irq_flags = irq_get_trigger_type(client->irq);
> >> +		if (irq_flags == IRQF_TRIGGER_NONE)
> >> +			irq_flags = IRQF_TRIGGER_RISING;
> >> +		irq_flags |= IRQF_ONESHOT;
> >> +
> >>   		err = devm_request_threaded_irq(&client->dev, client->irq,
> >>   					   NULL,
> >>   					   &tsl2563_event_handler,
> >> -					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> >> +					   irq_flags,
> >>   					   "tsl2563_event",
> >>   					   indio_dev);
> >>   		if (err) {  
> >   
> 

