Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2F68AC9C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 22:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjBDVcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 16:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjBDVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:32:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7992412A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 13:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675546311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A79++hJc3LuTXydOJ7kggZGXXk1oHl6TMkO4Slurx+8=;
        b=W/itydqoGBcB+nuZ/NJqLUH2gSBaLI1nwwPPXsfzLwpApdU6lxJsr3lqms4xpCep9dhWlS
        ZC3Uyy78uGnacPL1H5l7rlaB8+5HrxCpAZxzz4e/iaqzG81z5CyAO0xqylOoMe1jv7giiw
        ewIEqpG4CKrhfjHTk+k8FcoKR5owFWA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-vDx-oaFvO8yPvyxqDTm4fg-1; Sat, 04 Feb 2023 16:31:50 -0500
X-MC-Unique: vDx-oaFvO8yPvyxqDTm4fg-1
Received: by mail-wr1-f72.google.com with SMTP id b9-20020adfc749000000b002c3dede475cso155225wrh.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 13:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A79++hJc3LuTXydOJ7kggZGXXk1oHl6TMkO4Slurx+8=;
        b=BNM1IAu6eTnKDhbbr3SilfKf30dHCg1IYyGFhA0V6knMzCYp15qnkBz2inTvaQ9lVT
         5uzihrvXjCpAoILMVM6vEPA0cABonEcXwkTzxM/zp9dsNvXMKNF+vEtlaNhX9iD63GRD
         omfGhPBt1UrAJhVW64V/pvNDAv3OGCwtN+wkHauXUyoYcqubY6pjYUnZ8wxYIZgJlnJ2
         0uvLEJyEf0CoJXk6F8LDdbqd6weCKm/QaTYD4YsoC5zuMbfxubt4R0hjCskE8180FnWP
         3T6OzJ9AaQpee398aiWDiVb2UjEUQ66Xg/VfUhTn92wHW+uYD0pV24QKjvbK2cyai4/G
         28ng==
X-Gm-Message-State: AO0yUKVNZUGuQXHXxKmvqHQM2WVtLzBOKs3CnXnOmfchbTcb6ozsYpVN
        FMBU7ATp+EMQhS39Ok38rpbztL77Te7pjfgfz9haSVm9SEhvySx1bxZPbtQEgYLwJj1XiJrr8wF
        B1kNM/EOiYSlb2A590Z+ztIYy
X-Received: by 2002:a05:600c:43c5:b0:3dc:5674:66e6 with SMTP id f5-20020a05600c43c500b003dc567466e6mr14228835wmn.25.1675546308803;
        Sat, 04 Feb 2023 13:31:48 -0800 (PST)
X-Google-Smtp-Source: AK7set+Npyxq0IKHXdTkNssZIPOTehayAS/AWe3+2I23QKnb3vhvQiP1dTS2yMvxhWSggetDK6xBOw==
X-Received: by 2002:a05:600c:43c5:b0:3dc:5674:66e6 with SMTP id f5-20020a05600c43c500b003dc567466e6mr14228823wmn.25.1675546308478;
        Sat, 04 Feb 2023 13:31:48 -0800 (PST)
Received: from [192.168.1.81] ([212.76.254.34])
        by smtp.gmail.com with ESMTPSA id az24-20020a05600c601800b003dc4baaedd3sm11979605wmb.37.2023.02.04.13.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 13:31:47 -0800 (PST)
Message-ID: <f256b437-7495-1115-7eea-619b6e241e02@redhat.com>
Date:   Sat, 4 Feb 2023 22:31:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
Content-Language: en-US
To:     Darrell Kavanagh <darrell.kavanagh@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
 <20230130123113.00002c3f@Huawei.com>
 <CAMxBKG3xOEj1gEs9pGzKb+rDjTLPqAq1YOp4bEFas4tQMzGZ+Q@mail.gmail.com>
 <20230130173525.0000418d@huawei.com>
 <CAMxBKG1yKcodDD2kvfwKvpYnPrXmgaOk9rTztRPFzKMCZ5F=tA@mail.gmail.com>
 <20230130194110.256144e7@jic23-huawei>
 <CAMxBKG3S6aJSrO-BAPCAhVpg2qF2kWfRJ9d0n2EmOY=JGNid-A@mail.gmail.com>
 <20230130203110.60c96f37@jic23-huawei>
 <CAMxBKG1+Vcaic2WzVvZZSrVDO7+PTYJZgPP77s_GPOdo+BKJAQ@mail.gmail.com>
 <CAMxBKG0Q4H6Dv9a=oOAX8c5TS08ZJBBO0tTLRaUY9h-W1FTHCQ@mail.gmail.com>
 <20230201102824.00002044@Huawei.com>
 <c3207f3a-ecb9-0e69-e26a-71dc1b06db6a@redhat.com>
 <d9cec163f93922e59378a4aa351934ba1d702817.camel@hadess.net>
 <CAMxBKG3Nh5C1N5_SAftQxStkkj2Y0YRuymB4Z2av79p=1HPuMQ@mail.gmail.com>
 <7005e022-dd4c-835c-bdc2-11bbbd214071@redhat.com>
 <CAMxBKG1s5pqU08w2keOxf7J9UJakiwbCVve9iSDr1Vis0=6biQ@mail.gmail.com>
 <CAMxBKG1EUgJqMtrxBVOWP9GnZkc518HU2xUnLW4UUWH+8_u=cQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMxBKG1EUgJqMtrxBVOWP9GnZkc518HU2xUnLW4UUWH+8_u=cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/4/23 18:09, Darrell Kavanagh wrote:
> I've just noticed that the working mount matrix that I added to my
> hwdb is the matrix retrieved from the ACPI ROTM call in the amended
> driver, transposed.

An other word for the mount matrix would be a rotation matrix,
since it defines how the physical sensor is mounted on the PCB
in a rotated fashion compared to its standard orientation.

The x, y, z axis relationship underling of course does
not change by the rotation, so yes all mount matrices
are a transposition of the standard:

1, 0, 0 : 0, 1, 0 : 0, 0, 1

matrix, that is expected. Where that to not be the case
then there would be a bug in the accelerometer driver itself
where the driver itself is swapping or inverting axis.

Regards,

Hans




> On Fri, 3 Feb 2023 at 18:23, Darrell Kavanagh
> <darrell.kavanagh@gmail.com> wrote:
>>
>> Finally got a 6.2.0-rc6 kernel built and installed, with the following
>> patch, and everything is working as expected.
>>
>> Moving on now to look at Bastien's suggestion.
>>
>> Thanks,
>> Darrell
>>
>> diff --git a/kernel/drm_panel_orientation_quirks.c
>> b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> index 3659f04..590bb7b 100644
>> --- a/kernel/drm_panel_orientation_quirks.c
>> +++ b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> @@ -304,6 +304,12 @@ static const struct dmi_system_id orientation_data[] = {
>>                   DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad
>> D330-10IGM"),
>>                 },
>>                 .driver_data = (void *)&lcd1200x1920_rightside_up,
>> +       }, {    /* Lenovo IdeaPad Duet 3 10IGL5 */
>> +               .matches = {
>> +                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
>> +               },
>> +               .driver_data = (void *)&lcd1200x1920_rightside_up,
>>         }, {    /* Lenovo Ideapad D330-10IGL (HD) */
>>                 .matches = {
>>                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>
>> On Wed, 1 Feb 2023 at 17:55, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 2/1/23 18:50, Darrell Kavanagh wrote:
>>>> Thank you. I don't have anything that could be called a big machine.
>>>> The fastest processor I have access to is a Core m3-8100Y - that's in
>>>> a Chromebook with 4GB memory - it can run Linux in a chroot or
>>>> officially in Google's VM. I also have an ancient gen 2 core i5-2410M
>>>> machine which is slower than the m3 in theory, but that has 6GB of
>>>> memory.
>>>>
>>>> Is the kernel build more processor or memory bound?
>>>
>>> It is mostly processor bound, esp. wtih something like make -j4,
>>> make -j16 will start taking some RAM, but with make -j4 I expect you
>>> to be fully CPU bound.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>> On Wed, 1 Feb 2023 at 16:12, Bastien Nocera <hadess@hadess.net> wrote:
>>>>>
>>>>> On Wed, 2023-02-01 at 12:00 +0100, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 2/1/23 11:28, Jonathan Cameron wrote:
>>>>>>> On Wed, 1 Feb 2023 01:40:49 +0000
>>>>>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
>>>>>>>
>>>>>>>> Hello, all.
>>>>>>>>
>>>>>>>> I've finally reached a conclusion on this, after testing all the
>>>>>>>> combinations of the patches (with and without reading the acpi
>>>>>>>> mounting matrix), window managers (wayland, xorg) and the
>>>>>>>> presence or
>>>>>>>> not of my custom kernel parms.
>>>>>>>>
>>>>>>>> What works well is the full set of patches with the custom kernel
>>>>>>>> parms and a new hwdb entry for the sensor:
>>>>>>>>
>>>>>>>> sensor:modalias:acpi:SMO8B30*:dmi:*:svnLENOVO*:pn82AT:*
>>>>>>>>  ACCEL_MOUNT_MATRIX=0, 1, 0; -1, 0, 0; 0, 0, 1
>>>>>>>>
>>>>>>>> The autorotate then works correctly in wayland and xorg, but for
>>>>>>>> xorg,
>>>>>>>> the settings say the screen is "portrait left" when in actual
>>>>>>>> fact it
>>>>>>>> is in standard laptop landscape orientation. Wayland does not
>>>>>>>> have
>>>>>>>> this problem (I guess because wayland's view of the screen is
>>>>>>>> straight
>>>>>>>> from the kernel).
>>>>>>>>
>>>>>>>> Without the hwdb entry, the orientation is 90 degrees out without
>>>>>>>> using the acpi matrix and 180 degrees out when using it. I could
>>>>>>>> have
>>>>>>>> gone either way here with appropriate hwdb entries, but my view
>>>>>>>> is
>>>>>>>> that we *should* be using the matrix.
>>>>>>>
>>>>>>> Added Hans de Goede as he has probably run into more of this mess
>>>>>>> than anyone else.  Hans, any thoughts on if we are doing something
>>>>>>> wrong on kernel side?  Or is the matrix just wrong *sigh*
>>>>>>
>>>>>> I see below that this laptop has a panel which is mounted 90 degrees
>>>>>> rotated, that likely explains why the ACPI matrix does not work.
>>>>>> So the best thing to do here is to just override it with a hwdb
>>>>>> entries.
>>>>>>
>>>>>> IIRC there are already 1 or 2 other hwdb entries which actually
>>>>>> override the ACPI provided matrix because of similar issues.
>>>>>>
>>>>>> Linux userspace expects the matrix in this case to be set so that
>>>>>> it causes e.g. gnome's auto-rotation to put the image upright
>>>>>> even with older gnome versions / mate / xfce which don't know about
>>>>>> the panel being mounted 90 degrees.
>>>>>>
>>>>>> So e.g. "monitor-sensor" will report left-side-up or right-side-up
>>>>>> while the device is actually in normal clamshell mode with the
>>>>>> display up-right.
>>>>>>
>>>>>> This reporting of left-side-up or right-side-up is actually "correct"
>>>>>> looking from the native LCD panel orientation and as mentioned is
>>>>>> done for backward compatibility. This is documented here:
>>>>>>
>>>>>> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb#L54
>>>>>>
>>>>>> The way we are handling this is likely incompatible with how Windows
>>>>>> handles this special case of 90° rotated screen + ROTM. Or the
>>>>>> matrix in the ACPI tables could be just wrong...
>>>>>>
>>>>>>> I think 'ROTM' is defined by MS.
>>>>>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries
>>>>>>
>>>>>> Right and as such it would be good if we can still add support to
>>>>>> it to the sensor driver in question. Because the ROTM info usually
>>>>>> is correct and avoids the need for adding more and more hwdb entries.
>>>>>>
>>>>>> Note there already is existing support in some other sensor drivers.
>>>>>>
>>>>>> So we probably need to factor out some helper code for this and share
>>>>>> that between sensor drivers.
>>>>>>
>>>>>>
>>>>>>>> The only thing that concerns me is the need for custom kernel
>>>>>>>> parms.
>>>>>>>> It would be better if there was a way to avoid this, so that the
>>>>>>>> user
>>>>>>>> didn't have to mess around with their grub config. Though having
>>>>>>>> said
>>>>>>>> that, the sensors fix as we have it doesn't make things worse -
>>>>>>>> under
>>>>>>>> currently released kernels the screen always starts up sideways
>>>>>>>> unless
>>>>>>>> custom parms are added in grub.
>>>>>>
>>>>>> We actually have a quirk mechanism in the kernel for specifying
>>>>>> the need for: video=DSI-1:panel_orientation=right_side_up  and this
>>>>>> will also automatically fix the fbcon orientation, see:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_panel_orientation_quirks.c
>>>>>>
>>>>>> If you submit a patch for this upstream please Cc me.
>>>>>
>>>>> And if after that change, and copy/pasting the orientation from the
>>>>> DSDT into hwdb the sensor and screen move in the expected ways, then
>>>>> maybe stealing the BMC150 driver's
>>>>> bmc150_apply_bosc0200_acpi_orientation() might be a good idea.
>>>>>
>>>>> Once exported through "mount_matrix", iio-sensor-proxy should see it
>>>>> and read it without the need for a hwdb entry.
>>>>>
>>>>> Cheers
>>>>
>>>
> 

