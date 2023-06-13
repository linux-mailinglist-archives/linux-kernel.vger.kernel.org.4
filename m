Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C46E72DD1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbjFMI46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbjFMIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4434FC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686646491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lq/Vzw3AF1ObJ3IrcJEvD5SDZtKPvLXzmLX18LSDRk=;
        b=X7AFN/yHePWXa7u/qx9pNNOqjlOcf+6wo36kQYiGVDwV0YnfQxbDW8xtFR03ccqi92D75O
        /XIL2tA5YNdhTSInObcgCz2+x1C7LbGnjIOGlaMsnmyehgm0NZAVbxVIf9V87A5MyuRJJ2
        LkuTIPEOzcjJ8m5sHr1PZVAU1TdcuDg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Z8jdDihUOLiVvLHCxkcrbA-1; Tue, 13 Jun 2023 04:54:49 -0400
X-MC-Unique: Z8jdDihUOLiVvLHCxkcrbA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5149385acd0so5225234a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686646488; x=1689238488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lq/Vzw3AF1ObJ3IrcJEvD5SDZtKPvLXzmLX18LSDRk=;
        b=iGWCYRvuqrSY31Xv++MtT2r5QS4QXwQEaJj3eP+sdCMsKooURtiGkwQwFVu4W8n6G5
         tNgk3BkcATf5kM5l7vjYwaD8HV0VHO8NUiQp8wP3qaXXq82zwelCtdsnk2yU91s1qtJB
         yGiZ5N+Q9YyfZpk6SKzzM54eJZyyH8zlBIzBh2gbLyFHWKLC+jgHsQeMbPelbYsyVbZK
         IJzf4jYRs+j0UnE1CQ9qJyjDqKQy+ikBw4hEkodm34SnNwjCEuHas56nGGijUZSdxEx8
         bpk5hMRJ59YLQa/J4SdHx5TQkRra+qBGPqL4CFBTV7n3SqwmHFMAEIXC9JJ8M2kSZr4v
         EajA==
X-Gm-Message-State: AC+VfDyUHiqAISUhgomB/xgCkIjsdy0Pq5ti100f7768HfF9nWqwj07k
        FWgCXXuNGvjHjALU5rjsvSd/9NqcOag93jivAyf1JkrmoqZDJjJI8bravddym/cdxZxdBKwtwe/
        94snEjAuC1KGavTe1nMsOjcBS
X-Received: by 2002:a17:907:3d9e:b0:961:a67:29c with SMTP id he30-20020a1709073d9e00b009610a67029cmr10390305ejc.70.1686646488543;
        Tue, 13 Jun 2023 01:54:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6xRNQrq4kwulgXVo8nmA7/9h7IWljyL6GA6RUNd2OJZ/Cz3fyPNOJ7ZM1CVQs4C0j+V44I+Q==
X-Received: by 2002:a17:907:3d9e:b0:961:a67:29c with SMTP id he30-20020a1709073d9e00b009610a67029cmr10390287ejc.70.1686646488268;
        Tue, 13 Jun 2023 01:54:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kt5-20020a170906aac500b00978868cb24csm6483663ejb.144.2023.06.13.01.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:54:47 -0700 (PDT)
Message-ID: <0132feaa-6a89-2a8a-9eb2-c444b61c01b3@redhat.com>
Date:   Tue, 13 Jun 2023 10:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] platform/x86: dell-laptop: Add drm module soft dependency
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20230607034331.576623-1-acelan.kao@canonical.com>
 <20230607042032.GA28835@srcf.ucam.org>
 <CAFv23QmDNUFcPwvSQt5aUxtmHasfr8wrF72ObvcO-X19gfn=LA@mail.gmail.com>
 <20230607052724.GA29834@srcf.ucam.org>
 <CAFv23QkEdGnEz1q7vbyFCa9S9Dqh-zec72nRGyZ3wAz-8wpbvA@mail.gmail.com>
 <20230607062341.GA30618@srcf.ucam.org> <20230607065604.yaivqbbd3dkawxo4@pali>
 <CAFv23Q==r4newMXE3OWavRSRt-bEi5-qR0Vo-5HGLw4r9J36MA@mail.gmail.com>
 <20230607074732.GA31666@srcf.ucam.org>
 <457e2a4a-e28a-cd24-c129-4ff6162ccc36@redhat.com>
 <CAFv23QmVP4ZFAhAFBSx6ty-4fcQ-u9+uZb0xaD2gCJPCdpPvQg@mail.gmail.com>
 <f27f0d06-0b18-06bb-cb1f-042527c1ca31@redhat.com>
 <CAFv23Q==ghYCW-ukKQJZ_JhYgS4CSCDwbg9sZL9_B1Pa_LviWg@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAFv23Q==ghYCW-ukKQJZ_JhYgS4CSCDwbg9sZL9_B1Pa_LviWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AceLan,

On 6/13/23 09:30, AceLan Kao wrote:
> Hans de Goede <hdegoede@redhat.com> 於 2023年6月8日 週四 下午5:16寫道：
>>
>> Hi AceLan,
>>
>> On 6/8/23 05:04, AceLan Kao wrote:
>>> Hans de Goede <hdegoede@redhat.com> 於 2023年6月8日 週四 上午3:16寫道：
>>>>
>>>> Hi,
>>>>
>>>> On 6/7/23 09:47, Matthew Garrett wrote:
>>>>> On Wed, Jun 07, 2023 at 03:39:33PM +0800, AceLan Kao wrote:
>>>>>
>>>>>> What do you think if we unregister backlight devices if the backlight type
>>>>>> is larger than the current registered one.
>>>>>> Do this check in backlight_device_register() and unregister backlight
>>>>>> devices by the order raw(1) > platform(2) > firmware(3)
>>>>>> And maybe introduce a sticky bit into the backlight device if the backlight
>>>>>> driver doesn't want to be removed.
>>>>>
>>>>> Hans looked at doing this, but there were some awkward corner cases.
>>>>> When we first introduced this functionality, firmware was preferred to
>>>>> platform was preferred to raw - but on Intel, at least, this behaviour
>>>>> changed with later versions of Windows. I don't think there's a single
>>>>> static policy that works, I think you need to pay attention to the hints
>>>>> the platform gives you. How does Windows know which interface to use on
>>>>> this platform? The simplest solution may actually just be for
>>>>> dell-laptop to refuse to register a backlight if the platform claims to
>>>>> be Windows 8 or later.
>>>>
>>>> I like that idea.
>>>>
>>>> AceLan, I guess that you hit this easy while testing on a (development)
>>>> Meteor Lake platform ?
>>>>
>>>> I have had other/similar reports about Meteor Lake platforms.
>>>>
>>>> On hw from the last 10 years dell-laptop will not register
>>>> its vendor-type backlight class device because
>>>> acpi_video_get_backlight_type() will return acpi_backlight_video
>>>> there (1) so it does not matter if the GPU driver shows up only
>>>> later (2).
>>>>
>>>> But it seems that on Meteor Lake the ACPI tables will no longer
>>>> contain acpi_video backlight control support which causes
>>>> acpi_video_get_backlight_type() to return acpi_backlight_vendor (2).
>>>> triggering the issue you are seeing.
>>>>
>>>> Can you give the attached patch a try please ?
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>>>
>>>> 1) Starting with kernel >= 6.2 acpi_video.c will only register
>>>> the /sys/class/backlight/acpi_video# node after a drm/kms drivers
>>>> asks it to register it.
>>>>
>>>> 2) The native GPU driver will tell the drivers/acpi/video_detect.c
>>>> code that native backlight control is available changing
>>>> the return of acpi_video_get_backlight_type() to native, which
>>>> is why loading the native GPU driver first also fixes this issue.
>>>
>>> Hi Hans,
>>>
>>> Yes, this patch works for me, thanks.
>>>
>>> BTW, I encountered this issue on the RPL platform.
>>
>> Thank you for testing. I have updated the commit message
>> to reflect that this impacts both RPL and MTL platforms
>> and submitted the fix upstream:
>>
>> https://lore.kernel.org/linux-acpi/20230608091258.7963-1-hdegoede@redhat.com/
>>
>> Regards,
>>
>> Hans
>>
> 
> Hi Hans,
> 
> I got another issue on the same platform.
> The first issue was that when set to DSC graphics only in the BIOS,
> I encountered the issue I reported here, dell_laptop creates dell_backlight
> and then nvidia creates nvidia_0 later.
> 
> Now, set to hybrid mode in the BIOS, I found I still got 2 backlight interfaces
>    $ ls /sys/class/backlight/
>    acpi_video0  intel_backlight
> acpi_video0 is redundant and non-working.
> 
> Do you think should I set this platform to the dmi quirk? Or is there anything
> I could try to get rid of this?


This is very hard to answer without more info.

For starters please make sure that you are testing with the latest kernel and
provide full dmesg output for a boot with the BIOS set to hybrid mode.

Regards,

Hans


