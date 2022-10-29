Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8026122C3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJ2MGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJ2MFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:05:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C77158082;
        Sat, 29 Oct 2022 05:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24F316010F;
        Sat, 29 Oct 2022 12:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6808BC433C1;
        Sat, 29 Oct 2022 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667045117;
        bh=OtZDT/As12nGJ7lylmrts3vX2uaqID/HTfb/hQ5AFpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P2Wweqp/n9lZqD67N4d7B/OiA3eleqX64r0mvKpG0DHHs+t2LpIWzFniVlPcEEFoE
         GI0RYjRac6yawVjBG9KwwN7IKQ+uhpi5LlcV01QUn6J5Xb0qD38lsY45ILUNzsqj+g
         HIveD0+2eX/tkJCJHOpPzCCjV/74eWM39XkS+BWwfUnghZX3pHl6Gt0+89GxaqBGEW
         jyjXRmNdCbuvNFkwjbIZAC7nO2n1Qq6uRaZzhuNaRDRFwq0iBIDOKyZWvJBXKnO9cF
         NjiE4eQI9P3uHU0sm1pPVcY2jy4EH4seMsKRH0G2eO9G/ow/A7CI+e+vwqldrpEqXt
         xwdhicHWkj/Mg==
Date:   Sat, 29 Oct 2022 13:17:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v5] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221029131711.020400de@jic23-huawei>
In-Reply-To: <20221024183148.GA3170088@roeck-us.net>
References: <20221024165658.181340-1-rajat.khandelwal@linux.intel.com>
        <20221024112829.GA2807876@roeck-us.net>
        <CO1PR11MB483509CDD93AFA3176C42080962E9@CO1PR11MB4835.namprd11.prod.outlook.com>
        <20221024183148.GA3170088@roeck-us.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 11:31:48 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Mon, Oct 24, 2022 at 05:11:17PM +0000, Khandelwal, Rajat wrote:
> > Hi Guenter,
> > Thanks for the acknowledgement.
> >   
> > >Agreed; the sensor doesn't seem to be very useful for traditional hardware
> > >monitoring. The driver better resides in IIO.  
> > Cool! I didn't know the categorical reasoning behind this but since this is 
> > accepted in IIO, I don't have to do anything more.   
> 
> Huh. There is no "categorical" reasoning. Call it a gut feeling.
> I can not imagine anyone using this chip for hardware monitoring,
> and presumably you have an IIO use case or you would not have
> implemented an IIO driver.
> 
> >   
> > >I don't understand why readings are discarded. Why trigger multiple
> > >readings just to discard all but the last one ? I thought iio would
> > >be expected to return all values.  
> > Ok. The plan is to trigger temperature conversion on the GPIO input also.
> > The user can trigger as many times the temperature conversion he wants (I accept unnecessary),
> > which will keep the FIFO increasing (without reading converted values) but the driver should be
> > resilient to all the erroneous zones. Also, when the user does really make a syscall to read the
> > temperature, it definitely should be the last converted reading.   
> 
> That is your use case. I don't know how IIO drivers are normally
> implemented, but I would expect a generic driver. In this case,
> I would expect userspace to decide what it wants to with the data
> and not let the kernel driver discard most of it.

Two separate interfaces - the sysfs one this driver initially supports (in common
with many other first submissions) - that is normally for polling of the channel
value - we want the latest. Second interface is chardev version that uses
a kfifo to avoid dropping data and is commonly interrupt driven.  For that
interface, we indeed try to pass all the data to userspace.

> 
> >   
> > >This is really pointless. The register has only one bit to set.
> > >Just write that bit; reading the register before that is pointless.  
> > I think the register also has some bits which are reserved. Hence, rather than to make a number
> > for specifically the value keeping those bits the same, I read whatever is there and only store the
> > required one. 
> >   
> I personally would not accept that kind of code, but that is just
> me.

I'm completely lost on this.  Please don't move comments to the top, put
them inline alongside the code.  Do crop the code to only include relevant
parts though to save us all scrolling through uncomnented code!
If you agree with a reviewer comment it's also fine to crop that bit out -
if we don't see a reply we assume you accept the feedback.


> 
> > >Also, the code assumes that one of the gpio input registers would be used
> > >to trigger temperature readings. Why trigger another one if this is indeed
> > >the case ? Triggering a temperature reading should only be necessary if
> > >there is no data in the fifo.  
> > GPIO input triggering is yet not implemented as I would have to work on ACPI interrupts and I have
> > written the driver for now to get it included in Linux. 
> > There are 2 ways - via GPIO and making a syscall. I agree that temperature reading should be
> > necessary only when there is no data in FIFO but since we intend to keep GPIO as a trigger point,
> > user can keep triggering conversions and not reading them out. (As pointed above, driver should be
> > resilient to all erroneous zones).  
> 
> What does that have to do with interrupts ? Anything connected to the
> gpio pin would trigger a reading.
> 
> >   
> > >The datasheet says that it can take up to 50 ms to report a result.
> > >10 retries with 50ms wait each time seems overkill.  
> > That's correct. But, the response time can be up to 500 ms. Also, while debugging I had put timestamps
> > which when analyzed, indicated that time may go beyond 50 ms. 
> >   
> 
> It seems to me that this would warrant an explanation in the driver.
> 500ms seems hard to believe.
> 
> > >And why use usleep_range() here
> > >but msleep() above ?  
> > I am sorry about that. I have converted usleep_range into msleep (2 places). 
> >   
> > >This is wrong. It uses the overflow counter as data counter if it
> > >is != 0. The overflow counter counts the number of overflows, not
> > >the number of entries in the fifo.  
> > So there is no such thing as 'overflow counter'. The point is if the overflow counter has  
> 
> Interesting statement. MAX30208_FIFO_OVF_CNTR very much
> sounds like overflow counter to me, and the datasheet
> suggests the same.
> 
> > even one word, I use the data count equal to the overflow counter value. However, if it
> > has zero, then use the number of words in actual FIFO. 
> > This logic is just used to count how many values to pop to get the most recent reading.
> >   
> 
> The code is
> 
> +       ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
> +       if (ret < 0) {
> +               dev_err(&data->client->dev, "Error reading reg FIFO overflow counter\n");
> +               goto unlock;
> +       } else if (!ret) {
> +               ret = i2c_smbus_read_byte_data(data->client,
> +                                              MAX30208_FIFO_DATA_CNTR);
> +               if (ret < 0) {
> +                       dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
> +                       goto unlock;
> +               }
> +       }
> +
> +       data_count = ret;
> 
> If reading MAX30208_FIFO_OVF_CNTR returns a value > 0, it is used as
> data_count. That does not seem correct. The data sheet says if
> MAX30208_FIFO_OVF_CNTR is != 0, data_count is 32. Maybe the datasheet
> is wrong all over the place, but at least in this case that seems
> very unlikely.
> 
> > > data_count is declared as u8 and will never be < 0.  
> > Data count can never be <0 as only first few bits of the 8 bits are used in the register. 
> >   
> 	u8 data_count;
> ...
> 	data_count = i2c_smbus_read_byte_data(data->client,
>                                               MAX30208_FIFO_DATA_CNTR);
>         if (data_count < 0) {
> 
> Really ? Static analyzers will have a field day with this code.
> 
> Anyway, I don't really care much about this code, so I'll let
> Jonathan take it from here. I just wanted to share my observations.
> 
> Thanks,
> Guenter

