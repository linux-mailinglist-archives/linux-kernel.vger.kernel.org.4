Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B65686D79
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBAR4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBAR4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:56:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63791EBF3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675274145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFAeXA1XdcMNLN0rSiKe5P8CKHTtok03BfRTmM0Pwgo=;
        b=biy2MDioPjU/gV45uWbk9smIAZVw712UzABqIDPq4r9d9ZVO1m6CtoI7+OHDrn5a+rZBYy
        o4uj16922iXahAw/a+zz58ZAp5lyN/p40wf+d7bqkLWkQHCbphKy0MmmMNqyaQqIh9OC7Z
        cJqV07bgVQbkQiD2Wh53ivBEKcKHRQo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-_5hJj4CtMza4GoSXtI3UyA-1; Wed, 01 Feb 2023 12:55:44 -0500
X-MC-Unique: _5hJj4CtMza4GoSXtI3UyA-1
Received: by mail-ed1-f71.google.com with SMTP id l17-20020a056402255100b00472d2ff0e59so13421954edb.19
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 09:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFAeXA1XdcMNLN0rSiKe5P8CKHTtok03BfRTmM0Pwgo=;
        b=6mZEABnKvaGo97VV9i96TVk3qBjfoONZ/1Elj/tV7YmgOrdBbgKr1+DZmQWJ5L1o6Y
         tjkWSZbHQvS2bRwhRsVJ3GdeXgZNTV4ij2IDIC+lxdMPF3MEeLzLo703rLoZGKx43W0h
         eEtFllbX2fqBMUTQCGl5hOzad3KSIiDRJxO541HZbhAjeRjm3yphkA/RiA6xbicl9Cuw
         HYCuEVNM47HMmpXxh3GRMUTkzK4mWxDKdBsT2VWnZFDi0RDlPqGaRdrUXd5MmnlLVpR9
         1q6VGBjtClHgHP5hcr0l3W7sDVuHJo+YRnyX9jMw0AekmGXAPBhF/zrBCFuWgR65b6rO
         cQmg==
X-Gm-Message-State: AO0yUKUpuRtTbpZgZ6QDJyJ0T9AwAsTuTgI9lMVofQtwVG6AHUXwAaSe
        HZlGSF+MAfo2A0IyrNa/u6s7Zf+V7iaqbHvoScZbF1pEDi3fnkzvfsHRCoobcEMBFbFh6c49aYc
        osjCuIUgJeLfDdpB0UwHkwq5C
X-Received: by 2002:a17:907:d38b:b0:878:7449:429f with SMTP id vh11-20020a170907d38b00b008787449429fmr3327472ejc.16.1675274143666;
        Wed, 01 Feb 2023 09:55:43 -0800 (PST)
X-Google-Smtp-Source: AK7set+IQFJ+Dd/5eLlvpo4HyU3h1W+V9gisNjQIRkgJ0Gy8saNxMttk9mNAi8DgwLOJ1U70gnX7mA==
X-Received: by 2002:a17:907:d38b:b0:878:7449:429f with SMTP id vh11-20020a170907d38b00b008787449429fmr3327458ejc.16.1675274143434;
        Wed, 01 Feb 2023 09:55:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q8-20020a056402032800b004a24b8b58cbsm4406633edw.16.2023.02.01.09.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 09:55:42 -0800 (PST)
Message-ID: <7005e022-dd4c-835c-bdc2-11bbbd214071@redhat.com>
Date:   Wed, 1 Feb 2023 18:55:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
Content-Language: en-US, nl
To:     Darrell Kavanagh <darrell.kavanagh@gmail.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
 <20230129182441.082f29d0@jic23-huawei>
 <CAMxBKG0tyLSpaDPGBXsJbqgHSG9rH6owtSJsLw_ekmTA3Kyvdw@mail.gmail.com>
 <CAMxBKG3zL_yvw=dHK+Gqd3EHWzvJmiLHVvKnf6UsYbMgcS6nrg@mail.gmail.com>
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMxBKG3Nh5C1N5_SAftQxStkkj2Y0YRuymB4Z2av79p=1HPuMQ@mail.gmail.com>
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

On 2/1/23 18:50, Darrell Kavanagh wrote:
> Thank you. I don't have anything that could be called a big machine.
> The fastest processor I have access to is a Core m3-8100Y - that's in
> a Chromebook with 4GB memory - it can run Linux in a chroot or
> officially in Google's VM. I also have an ancient gen 2 core i5-2410M
> machine which is slower than the m3 in theory, but that has 6GB of
> memory.
> 
> Is the kernel build more processor or memory bound?

It is mostly processor bound, esp. wtih something like make -j4,
make -j16 will start taking some RAM, but with make -j4 I expect you
to be fully CPU bound.

Regards,

Hans










> On Wed, 1 Feb 2023 at 16:12, Bastien Nocera <hadess@hadess.net> wrote:
>>
>> On Wed, 2023-02-01 at 12:00 +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 2/1/23 11:28, Jonathan Cameron wrote:
>>>> On Wed, 1 Feb 2023 01:40:49 +0000
>>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
>>>>
>>>>> Hello, all.
>>>>>
>>>>> I've finally reached a conclusion on this, after testing all the
>>>>> combinations of the patches (with and without reading the acpi
>>>>> mounting matrix), window managers (wayland, xorg) and the
>>>>> presence or
>>>>> not of my custom kernel parms.
>>>>>
>>>>> What works well is the full set of patches with the custom kernel
>>>>> parms and a new hwdb entry for the sensor:
>>>>>
>>>>> sensor:modalias:acpi:SMO8B30*:dmi:*:svnLENOVO*:pn82AT:*
>>>>>  ACCEL_MOUNT_MATRIX=0, 1, 0; -1, 0, 0; 0, 0, 1
>>>>>
>>>>> The autorotate then works correctly in wayland and xorg, but for
>>>>> xorg,
>>>>> the settings say the screen is "portrait left" when in actual
>>>>> fact it
>>>>> is in standard laptop landscape orientation. Wayland does not
>>>>> have
>>>>> this problem (I guess because wayland's view of the screen is
>>>>> straight
>>>>> from the kernel).
>>>>>
>>>>> Without the hwdb entry, the orientation is 90 degrees out without
>>>>> using the acpi matrix and 180 degrees out when using it. I could
>>>>> have
>>>>> gone either way here with appropriate hwdb entries, but my view
>>>>> is
>>>>> that we *should* be using the matrix.
>>>>
>>>> Added Hans de Goede as he has probably run into more of this mess
>>>> than anyone else.  Hans, any thoughts on if we are doing something
>>>> wrong on kernel side?  Or is the matrix just wrong *sigh*
>>>
>>> I see below that this laptop has a panel which is mounted 90 degrees
>>> rotated, that likely explains why the ACPI matrix does not work.
>>> So the best thing to do here is to just override it with a hwdb
>>> entries.
>>>
>>> IIRC there are already 1 or 2 other hwdb entries which actually
>>> override the ACPI provided matrix because of similar issues.
>>>
>>> Linux userspace expects the matrix in this case to be set so that
>>> it causes e.g. gnome's auto-rotation to put the image upright
>>> even with older gnome versions / mate / xfce which don't know about
>>> the panel being mounted 90 degrees.
>>>
>>> So e.g. "monitor-sensor" will report left-side-up or right-side-up
>>> while the device is actually in normal clamshell mode with the
>>> display up-right.
>>>
>>> This reporting of left-side-up or right-side-up is actually "correct"
>>> looking from the native LCD panel orientation and as mentioned is
>>> done for backward compatibility. This is documented here:
>>>
>>> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb#L54
>>>
>>> The way we are handling this is likely incompatible with how Windows
>>> handles this special case of 90° rotated screen + ROTM. Or the
>>> matrix in the ACPI tables could be just wrong...
>>>
>>>> I think 'ROTM' is defined by MS.
>>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries
>>>
>>> Right and as such it would be good if we can still add support to
>>> it to the sensor driver in question. Because the ROTM info usually
>>> is correct and avoids the need for adding more and more hwdb entries.
>>>
>>> Note there already is existing support in some other sensor drivers.
>>>
>>> So we probably need to factor out some helper code for this and share
>>> that between sensor drivers.
>>>
>>>
>>>>> The only thing that concerns me is the need for custom kernel
>>>>> parms.
>>>>> It would be better if there was a way to avoid this, so that the
>>>>> user
>>>>> didn't have to mess around with their grub config. Though having
>>>>> said
>>>>> that, the sensors fix as we have it doesn't make things worse -
>>>>> under
>>>>> currently released kernels the screen always starts up sideways
>>>>> unless
>>>>> custom parms are added in grub.
>>>
>>> We actually have a quirk mechanism in the kernel for specifying
>>> the need for: video=DSI-1:panel_orientation=right_side_up  and this
>>> will also automatically fix the fbcon orientation, see:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_panel_orientation_quirks.c
>>>
>>> If you submit a patch for this upstream please Cc me.
>>
>> And if after that change, and copy/pasting the orientation from the
>> DSDT into hwdb the sensor and screen move in the expected ways, then
>> maybe stealing the BMC150 driver's
>> bmc150_apply_bosc0200_acpi_orientation() might be a good idea.
>>
>> Once exported through "mount_matrix", iio-sensor-proxy should see it
>> and read it without the need for a hwdb entry.
>>
>> Cheers
> 

