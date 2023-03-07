Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3C6AD9F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCGJK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCGJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668AC39CE5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678180208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xq6BJBcSeW4yq2VBjVjaaTsW2n5w7aHjtQQjjTr0wW0=;
        b=Zipmf34NRB9wOccrZeP4sVOkrX1AMrerJPy6Dwjlqt/mKTT0iKC7kiuFpbDL4Pwnc7g0Oe
        xr7yESyzEPjk/Rl/SAH9Sz5m0ppENpIgVOJDOSLCHAgdOl1QkiZ6mlXv0abgo6DW5u7Am4
        qD4HUI4liyuwnjuIOIBs2PZKv5ZEg2E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-B265AYm0MDSv3cWQd9V-Wg-1; Tue, 07 Mar 2023 04:10:07 -0500
X-MC-Unique: B265AYm0MDSv3cWQd9V-Wg-1
Received: by mail-ed1-f71.google.com with SMTP id w7-20020a056402268700b004bbcdf3751bso17775389edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678180206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xq6BJBcSeW4yq2VBjVjaaTsW2n5w7aHjtQQjjTr0wW0=;
        b=ZP1FQlFo3ADl++e8qWDvcdAxNlb2a6vhvPZcf/y+DwKYtOCVE9ID48Bru3P+CU5qJC
         sebrBkWMuHWRuK+Zx5zAx5ujqWcCikpgBStE195R9Yw++bj5EeepyR+SOWNmnzlJZD67
         urfsrX3uN75UyezZ97AcL+GuOp6OI+8x3B5Ex6tW/9XHNt7X4xVdOU2/OmxkyyxMIyqP
         JvQzF6M6R7Ri/e4x5rZe141E9gsPfI/9nfbLp2qRBU3EOC3XcjvW7Xog1+UaVPyIy/0o
         PAbZsdK+cAdtdhxfRWWcCwd4waBhfFAqm5Ri0fF/3pAjdw5+RmpVGGJO+SSoHNcsWR++
         Nqpg==
X-Gm-Message-State: AO0yUKVRzhanivJhCEr0OQQ1o20vAFyXF2pZHy/nlxmUY1rh9anEREY4
        GaVMJsGcgI5wDVuPlOsaa8yiwXZpO4iCYrK23kg80UHLZzE3zZ+ODRrtZeKA4uueJdWBKX1hNMJ
        XJhlF0lmOiYabfPsqENaHJxOT
X-Received: by 2002:a17:907:d109:b0:878:78f9:d1be with SMTP id uy9-20020a170907d10900b0087878f9d1bemr13134208ejc.23.1678180206172;
        Tue, 07 Mar 2023 01:10:06 -0800 (PST)
X-Google-Smtp-Source: AK7set/9zwjAYX9UrtgzuuxMAQSXMi4wg00d2LGZvD9pjiVibrQht5iiOSqtGq9qN0hdUA0/dJDdCw==
X-Received: by 2002:a17:907:d109:b0:878:78f9:d1be with SMTP id uy9-20020a170907d10900b0087878f9d1bemr13134192ejc.23.1678180205874;
        Tue, 07 Mar 2023 01:10:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906370d00b008d5183c1e20sm5754774ejc.190.2023.03.07.01.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:10:05 -0800 (PST)
Message-ID: <4c3ba301-6241-f2f4-f139-b4f4a0cd6223@redhat.com>
Date:   Tue, 7 Mar 2023 10:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
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
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <DM6PR11MB4316B4F865472CA998E696FC8DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
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

On 3/7/23 09:40, Wu, Wentong wrote:
> 
> 
>> -----Original Message-----
>> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Sent: Tuesday, March 7, 2023 4:30 PM
>>
>> Hi Wentong,
>>
>> On Tue, Mar 07, 2023 at 08:17:04AM +0000, Wu, Wentong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>> Sent: Wednesday, March 1, 2023 6:42 PM
>>>>
>>>> Hi,
>>>>
>>>> On 3/1/23 11:34, Sakari Ailus wrote:
>>>>> Hi Wentong,
>>>>>
>>>>> On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
>>>>>> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls",
>>>>>> is a companion chip designed to provide secure and low power
>>>>>> vision capability to IA platforms. IVSC is available in existing
>>>>>> commercial platforms from multiple OEMs.
>>>>>>
>>>>>> The primary use case of IVSC is to bring in context awareness.
>>>>>> IVSC interfaces directly with the platform main camera sensor via
>>>>>> a CSI-2 link and processes the image data with the embedded AI
>>>>>> engine. The detected events are sent over I2C to ISH (Intel
>>>>>> Sensor Hub) for additional data fusion from multiple sensors. The
>>>>>> fusion results are used to implement advanced use cases like:
>>>>>>  - Face detection to unlock screen
>>>>>>  - Detect user presence to manage backlight setting or waking up
>>>>>> system
>>>>>>
>>>>>> Since the Image Processing Unit(IPU) used on the host processor
>>>>>> needs to configure the CSI-2 link in normal camera usages, the
>>>>>> CSI-2 link and camera sensor can only be used in
>>>>>> mutually-exclusive ways by host IPU and IVSC. By default the IVSC
>>>>>> owns the CSI-2 link and camera sensor. The IPU driver can take
>>>>>> ownership of the CSI-2 link and camera sensor using interfaces provided
>> by this IVSC driver.
>>>>>>
>>>>>> Switching ownership requires an interface with two different
>>>>>> hardware modules inside IVSC. The software interface to these
>>>>>> modules is via Intel MEI (The Intel Management Engine) commands.
>>>>>> These two hardware modules have two different MEI UUIDs to
>>>>>> enumerate. These hardware
>>>> modules are:
>>>>>>  - ACE (Algorithm Context Engine): This module is for algorithm
>>>>>> computing when IVSC owns camera sensor. Also ACE module controls
>>>>>> camera sensor's ownership. This hardware module is used to set
>>>>>> ownership
>>>> of camera sensor.
>>>>>>  - CSI (Camera Serial Interface): This module is used to route
>>>>>> camera sensor data either to IVSC or to host for IPU driver and
>> application.
>>>>>>
>>>>>> IVSC also provides a privacy mode. When privacy mode is turned
>>>>>> on, camera sensor can't be used. This means that both ACE and
>>>>>> host IPU can't get image data. And when this mode is turned on,
>>>>>> host IPU driver is informed via a registered callback, so that user can be
>> notified.
>>>>>>
>>>>>> In summary, to acquire ownership of camera by IPU driver, first
>>>>>> ACE module needs to be informed of ownership and then to setup
>>>>>> MIPI CSI-2 link for the camera sensor and IPU.
>>>>>
>>>>> I thought this for a while and did some research, and I can
>>>>> suggest the
>>>>> following:
>>>>>
>>>>> - The IVSC sub-device implements a control for privacy (V4L2_CID_PRIVACY
>>>>>   is a good fit).
>>>>>
>>>>> - Camera sensor access needs to be requested from IVSC before accessing
>> the
>>>>>   sensor via I²C. The IVSC ownership control needs to be in the right
>>>>>   setting for this to work, and device links can be used for that purpose
>>>>>   (see device_link_add()). With DL_FLAG_PM_RUNTIME and
>>>> DL_FLAG_RPM_ACTIVE,
>>>>>   the supplier devices will be PM runtime resumed before the consumer
>>>>>   (camera sensor). As these devices are purely virtual on host side and has
>>>>>   no power state as such, you can use runtime PM callbacks to transfer the
>>>>>   ownership.
>>>>
>>>> Interesting proposal to use device-links + runtime-pm for this
>>>> instead of modelling this as an i2c-mux. FWIW I'm fine with going
>>>> this route instead of using an i2c-mux approach.
>>>>
>>>> I have been thinking about the i2c-mux approach a bit and the
>>>> problem is that we are not really muxing but want to turn on/off
>>>> control and AFAIK the i2c-mux framework simply leaves the mux muxed
>>>> to the last used i2c-chain, so control will never be released when the i2c
>> transfers are done.
>>>>
>>>> And if were to somehow modify things (or maybe there already is some
>>>> release
>>>> callback) then the downside becomes that the i2c-mux core code
>>>> operates at the i2c transfer level. So each i2c read/write would then enable +
>> disavle control.
>>>>
>>>> Modelling this using something like runtime pm as such is a much
>>>> better fit because then we request control once on probe / stream-on
>>>> and release it once we are fully done, rather then requesting +
>>>> releasing control once per i2c- transfer.
>>>
>>> Seems runtime pm can't fix the problem of initial i2c transfer during
>>> sensor driver probe, probably we have to switch to i2c-mux modeling way.
>>
>> What do you mean? The supplier devices are resumed before the driver's probe
>> is called.
> 
> But we setup the link with device_link_add during IVSC driver's probe, we can't
> guarantee driver probe's sequence.

Then maybe we need to do the device_link_add somewhere else.

The mainline kernel delays probing of camera sensors on Intel platforms
until the INT3472 driver has probed the INT3472 device on which the
sensors have an ACPI _DEP.

This is already used to make sure that clock lookups and regulator
info is in place before the sensor's probe() function runs.

So that when the driver does clk_get() it succeeds and so that regulator_get()
does not end up returning a dummy regulator.

So I think the code adding the device_link-s for the IVSC should be added
to: drivers/platform/x86/intel/int3472/discrete.c and then the runtime-resume
will happen before the sensor's probe() function runs.

Likewise drivers/platform/x86/intel/int3472/discrete.c should also ensure
that the ivsc driver's probe() has run before it calls 
acpi_dev_clear_dependencies().

The acpi_dev_clear_dependencies() call in discrete.c tells the ACPI subsystem
to go ahead and create the i2c-clients for the sensors and allow the sensor
drivers to get loaded and probe the sensor.

Regards,

Hans

