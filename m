Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4F6B2000
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCIJ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjCIJ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:29:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF17231F1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678354093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VMW5hwC6HC6dArngY2midPA7q9IEMSNo48mdSfV3d7k=;
        b=G0bl+nyqwjCt76A/2uAEpCUn2yclmXk9a+h2k4RoUwd1+m19tDZaYzXQ2/YsxC3gxiJCVz
        gfwEgr2nqhjTqaR3GD3gDWpuRVapLY2eRTe1ntJJxTibOmXyIsPIF5qQDyg9hYDhpqBVFw
        7EoNDHjULV5xV66BNDzJpYTdKwnLzDw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-pc0-8Ev2OcK8M5A6Oh5sIg-1; Thu, 09 Mar 2023 04:28:11 -0500
X-MC-Unique: pc0-8Ev2OcK8M5A6Oh5sIg-1
Received: by mail-ed1-f69.google.com with SMTP id r9-20020a05640251c900b004d4257341c2so2031639edd.19
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMW5hwC6HC6dArngY2midPA7q9IEMSNo48mdSfV3d7k=;
        b=Tl5AIgc6SW76+ZTeFWDiGScHm0cQTzASlkkQ8u5BibDYopG0nGd/p6ANetyhh1x9OI
         jm8DZRbJA/eqlkRWkjtqXpqFuEnZMrpmFRIZZcWg2PiW8stEJRwFianeBfqACUSvwajR
         YiulyXoWkl9POsN2XAe2pfYfabIdvzoALkMoc2te6LzIUsS6/g0pbxK8gCRRqcQTU8jv
         fCmbgiANm812Ky0G165VqPdoaaM7vZ+orOqW5bRciOZiAl8HxhEeyc4j7NBjWnilsBSN
         9c5hJcXGP8OMiXznvy4xcdW1/JbfzqIQPPo1Fh0ALM6gnws7+Am6iQFvrABgLLq7ArVw
         tHJA==
X-Gm-Message-State: AO0yUKXAt/lSGJf2rHgc8i5ZvAe7lLNZ8QAU17nF1n0WrzR4JyFTCzhc
        Gat7/ZKvWyn9+dP3FGb0H1PEsHa4Pc/CQVEzbBUDU8KHVT5K6eBxi76Vc1S/3gxsWkf4oh5O+rK
        9nHNlJqNeaTYNYQZ7GPK6vAkw
X-Received: by 2002:a17:906:fe08:b0:881:23a:aba5 with SMTP id wy8-20020a170906fe0800b00881023aaba5mr27731567ejb.11.1678354090640;
        Thu, 09 Mar 2023 01:28:10 -0800 (PST)
X-Google-Smtp-Source: AK7set+8g+H2OKXwjUA1+Snhl7sS0ncXF5f4QcIXMWkB/UX63q9FqevpstwVpmmcsk8oVyx5eH7w9A==
X-Received: by 2002:a17:906:fe08:b0:881:23a:aba5 with SMTP id wy8-20020a170906fe0800b00881023aaba5mr27731544ejb.11.1678354090334;
        Thu, 09 Mar 2023 01:28:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906309500b008b1779ba3c1sm8544502ejv.115.2023.03.09.01.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:28:09 -0800 (PST)
Message-ID: <e12fe65e-0b1f-a058-75e6-fa3e0a292c5b@redhat.com>
Date:   Thu, 9 Mar 2023 10:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Content-Language: en-US, nl
To:     "Wu, Wentong" <wentong.wu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y/8qJzScTfFucpP9@kekkonen.localdomain>
 <ae28faf8-c8a4-3f75-08d0-8e5233f2fa5d@redhat.com>
 <DM6PR11MB4316F4B72F98ADBF577412378DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
 <ZAb2G7kqsEvrBhpG@kekkonen.localdomain>
 <DM6PR11MB4316B4F865472CA998E696FC8DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
 <4c3ba301-6241-f2f4-f139-b4f4a0cd6223@redhat.com>
 <DM6PR11MB43166ADFA7D0775BA2C223C78DB59@DM6PR11MB4316.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <DM6PR11MB43166ADFA7D0775BA2C223C78DB59@DM6PR11MB4316.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/9/23 02:08, Wu, Wentong wrote:
> 
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Tuesday, March 7, 2023 5:10 PM
>>
>> Hi,
>>
>> On 3/7/23 09:40, Wu, Wentong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>>>> Sent: Tuesday, March 7, 2023 4:30 PM
>>>>
>>>> Hi Wentong,
>>>>
>>>> On Tue, Mar 07, 2023 at 08:17:04AM +0000, Wu, Wentong wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>>>> Sent: Wednesday, March 1, 2023 6:42 PM
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 3/1/23 11:34, Sakari Ailus wrote:
>>>>>>> Hi Wentong,
>>>>>>>
>>>>>>> On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
>>>>>>>> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls",
>>>>>>>> is a companion chip designed to provide secure and low power
>>>>>>>> vision capability to IA platforms. IVSC is available in existing
>>>>>>>> commercial platforms from multiple OEMs.
>>>>>>>>
>>>>>>>> The primary use case of IVSC is to bring in context awareness.
>>>>>>>> IVSC interfaces directly with the platform main camera sensor via
>>>>>>>> a CSI-2 link and processes the image data with the embedded AI
>>>>>>>> engine. The detected events are sent over I2C to ISH (Intel
>>>>>>>> Sensor Hub) for additional data fusion from multiple sensors. The
>>>>>>>> fusion results are used to implement advanced use cases like:
>>>>>>>>  - Face detection to unlock screen
>>>>>>>>  - Detect user presence to manage backlight setting or waking up
>>>>>>>> system
>>>>>>>>
>>>>>>>> Since the Image Processing Unit(IPU) used on the host processor
>>>>>>>> needs to configure the CSI-2 link in normal camera usages, the
>>>>>>>> CSI-2 link and camera sensor can only be used in
>>>>>>>> mutually-exclusive ways by host IPU and IVSC. By default the IVSC
>>>>>>>> owns the CSI-2 link and camera sensor. The IPU driver can take
>>>>>>>> ownership of the CSI-2 link and camera sensor using interfaces
>>>>>>>> provided
>>>> by this IVSC driver.
>>>>>>>>
>>>>>>>> Switching ownership requires an interface with two different
>>>>>>>> hardware modules inside IVSC. The software interface to these
>>>>>>>> modules is via Intel MEI (The Intel Management Engine) commands.
>>>>>>>> These two hardware modules have two different MEI UUIDs to
>>>>>>>> enumerate. These hardware
>>>>>> modules are:
>>>>>>>>  - ACE (Algorithm Context Engine): This module is for algorithm
>>>>>>>> computing when IVSC owns camera sensor. Also ACE module controls
>>>>>>>> camera sensor's ownership. This hardware module is used to set
>>>>>>>> ownership
>>>>>> of camera sensor.
>>>>>>>>  - CSI (Camera Serial Interface): This module is used to route
>>>>>>>> camera sensor data either to IVSC or to host for IPU driver and
>>>> application.
>>>>>>>>
>>>>>>>> IVSC also provides a privacy mode. When privacy mode is turned
>>>>>>>> on, camera sensor can't be used. This means that both ACE and
>>>>>>>> host IPU can't get image data. And when this mode is turned on,
>>>>>>>> host IPU driver is informed via a registered callback, so that
>>>>>>>> user can be
>>>> notified.
>>>>>>>>
>>>>>>>> In summary, to acquire ownership of camera by IPU driver, first
>>>>>>>> ACE module needs to be informed of ownership and then to setup
>>>>>>>> MIPI CSI-2 link for the camera sensor and IPU.
>>>>>>>
>>>>>>> I thought this for a while and did some research, and I can
>>>>>>> suggest the
>>>>>>> following:
>>>>>>>
>>>>>>> - The IVSC sub-device implements a control for privacy
>> (V4L2_CID_PRIVACY
>>>>>>>   is a good fit).
>>>>>>>
>>>>>>> - Camera sensor access needs to be requested from IVSC before
>>>>>>> accessing
>>>> the
>>>>>>>   sensor via I²C. The IVSC ownership control needs to be in the right
>>>>>>>   setting for this to work, and device links can be used for that purpose
>>>>>>>   (see device_link_add()). With DL_FLAG_PM_RUNTIME and
>>>>>> DL_FLAG_RPM_ACTIVE,
>>>>>>>   the supplier devices will be PM runtime resumed before the consumer
>>>>>>>   (camera sensor). As these devices are purely virtual on host side and has
>>>>>>>   no power state as such, you can use runtime PM callbacks to transfer
>> the
>>>>>>>   ownership.
>>>>>>
>>>>>> Interesting proposal to use device-links + runtime-pm for this
>>>>>> instead of modelling this as an i2c-mux. FWIW I'm fine with going
>>>>>> this route instead of using an i2c-mux approach.
>>>>>>
>>>>>> I have been thinking about the i2c-mux approach a bit and the
>>>>>> problem is that we are not really muxing but want to turn on/off
>>>>>> control and AFAIK the i2c-mux framework simply leaves the mux muxed
>>>>>> to the last used i2c-chain, so control will never be released when
>>>>>> the i2c
>>>> transfers are done.
>>>>>>
>>>>>> And if were to somehow modify things (or maybe there already is
>>>>>> some release
>>>>>> callback) then the downside becomes that the i2c-mux core code
>>>>>> operates at the i2c transfer level. So each i2c read/write would
>>>>>> then enable +
>>>> disavle control.
>>>>>>
>>>>>> Modelling this using something like runtime pm as such is a much
>>>>>> better fit because then we request control once on probe /
>>>>>> stream-on and release it once we are fully done, rather then
>>>>>> requesting + releasing control once per i2c- transfer.
>>>>>
>>>>> Seems runtime pm can't fix the problem of initial i2c transfer
>>>>> during sensor driver probe, probably we have to switch to i2c-mux modeling
>> way.
>>>>
>>>> What do you mean? The supplier devices are resumed before the
>>>> driver's probe is called.
>>>
>>> But we setup the link with device_link_add during IVSC driver's probe,
>>> we can't guarantee driver probe's sequence.
>>
>> Then maybe we need to do the device_link_add somewhere else.
> 
> sensor's parent is the LJCA I2C device whose driver is being upstream 
> https://www.spinics.net/lists/kernel/msg4702552.htmland and sensor's
> power is controlled by IVSC instead of INT3472 if IVSC enabled.

I believe that the INT3472 code is still involved at least on
a Dell Latitude 9420 the INT3472 code still needs to set the
clock-enable and the privacy-LED GPIOs otherwise the main camera won't
work.

So I'm not sure what you mean with "sensor's power is controlled
by IVSC instead of INT3472" ?


> struct device_link *device_link_add(struct device *consumer,
>                                     struct device *supplier, u32 flags)
> 
> So probably we have to add above device_link_add in LJCA I2C's driver,
> and we can find the consumer(camera sensor) with ACPI API, but the 
> supplier, mei_ace, is mei client device under mei framework and it's
> dynamically allocated device instead of ACPI device, probably I can find
> its parent with some ACPI lookup from this LJCA I2C device, but
> unfortunately mei framework doesn't export the API to find mei client
> device with its parent bus device(struct mei_device).
> 
> I'm not sure if modeling this mei_ace as LJCA I2C's runtime power
> control is acceptable, if yes, probably this mei_ace driver have to go with
> LJCA I2C device driver.

Looking at the ACPI table the sensor ACPI device has 2 _DEP-s listed
the I2C controller and the INT3472 device. Since we are already doing
similar setup in the INT3472 device that seems like a good place
to add the device_link()-s (it can return -EPROBE_DEFER to wait
for the mei_ace to show up).

But when the INT3472 code runs, the consumer device does not exist
yet and AFAICT the same is true when the LCJA i2c-controller driver
is getting registered. The consumer only exists when the i2c_client
is instantiated and at that point the sensor drivers probe() method
can run immediately and we are too late to add the device_link.

As a hobby project I have been working on atomisp2 support and
I have a similar issue there. There is no INT3472 device there,
but there is a _DSM method which needs to be used to figure out
which ACPI GPIO resource is reset / powerdown and if the GPIOs
are active-low or active high.

I have written a little helper function to call the _DSM and
to then turn this into lookups and call devm_acpi_dev_add_driver_gpios().

Since on atomisp2 we cannot use the INT3472 driver to delay
the sensor-driver probe and have the INT3472 driver setup
the GPIO lookup, at least for the sensor drivers used with
atomisp2 there is going to be a need to add a single line
to probe() like this:

	v4l2_get_acpi_sensor_info(&i2c_client->dev, NULL);

To me it sounds like we need to do something similar here
and extend the helper function which I have written
(but not yet submitted upstream) :

https://github.com/jwrdegoede/linux-sunxi/commit/e2287979db43d46fa7d354c1bde92eb6219b613d

To also setup the device-links needed for the runtime-pm
solution to getting the i2c passed through to the sensor.

Ideally v4l2_get_acpi_sensor_info() should return void
(easier to use in the sensor drivers) but I think it should return
an int, so that it can e.g. return -EPROBE_DEFER to wait for
the mei_ace.

Regards,

Hans




>> The mainline kernel delays probing of camera sensors on Intel platforms until
>> the INT3472 driver has probed the INT3472 device on which the sensors have an
>> ACPI _DEP.
>>
>> This is already used to make sure that clock lookups and regulator info is in place
>> before the sensor's probe() function runs.
>>
>> So that when the driver does clk_get() it succeeds and so that regulator_get()
>> does not end up returning a dummy regulator.
>>
>> So I think the code adding the device_link-s for the IVSC should be added
>> to: drivers/platform/x86/intel/int3472/discrete.c and then the runtime-resume
>> will happen before the sensor's probe() function runs.
>>
>> Likewise drivers/platform/x86/intel/int3472/discrete.c should also ensure that
>> the ivsc driver's probe() has run before it calls acpi_dev_clear_dependencies().
>>
>> The acpi_dev_clear_dependencies() call in discrete.c tells the ACPI subsystem to
>> go ahead and create the i2c-clients for the sensors and allow the sensor drivers
>> to get loaded and probe the sensor.
>>
>> Regards,
>>
>> Hans
> 

