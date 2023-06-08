Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD70727B06
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbjFHJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjFHJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D748095
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686215781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/g6i5zf198nGPm+MV1Nr9xaejdPk8jLKCdPYWK6o4ZE=;
        b=AtFRR8JSv8zVzHvfwYN9RNt+C2Xsy9WvME3LjPBr5VJP0o/mMObZGy+ZqW95BltAHuZuhN
        XgE+tbSEGyZtRAQevH0ijJWKaAs6kKKpYzYZp3hQHmdYI7/HldjYeiyNb9GKtj3kPY2+3m
        wgFoedKJL7+jgqnt0obxI3E3TYYvG3U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-iYkiunfmOTuUt1lkP94deA-1; Thu, 08 Jun 2023 05:16:19 -0400
X-MC-Unique: iYkiunfmOTuUt1lkP94deA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-97542592eb9so45498366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686215778; x=1688807778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/g6i5zf198nGPm+MV1Nr9xaejdPk8jLKCdPYWK6o4ZE=;
        b=REIlk1AmvnXZszZAhBhdB//gfoBB8fmm1GsGbFZ+ov0aIT+x8YluEfjmSSPjwrvo24
         rzaDAocOhcTstO1okhxu0EFZEDy4mNwIUko+cWkSaEZtaCawAHeZApmkc0g1w0Azjtcd
         O1nlZZ9msws7fuox79CrKuM7WwPyhMxdj6CcWAvJ87l5rYhXwjl6iBEHLEtgtYG2nUBl
         g0b0ePI0Lwk/G5QOqnsYv65622DfgG2QUmebyJg5KGW144WBDu5/pFwThdOKC3IIYXll
         rzkRe8Bn/IvxrEAU0Vv+pb5t1b04LsHb4XTZ9ia0oTTmvNo/qhJy2M8VBbjw6Ph0jc17
         ONrg==
X-Gm-Message-State: AC+VfDyu+dtVfiiXYtq7qV/RSMYSS0vfXHyWuf2k9PgCpXqQ+ltKcMPI
        VMzGbDtvzdR6enlh7bRzTAj713/3Dyl390x9X/Pw8G8SIhmHu/Nbf1CIRUHnzLCBpgET2F/84PP
        e2Mo7nXfGSlNnX4foHei30VA5
X-Received: by 2002:a17:907:940d:b0:973:daaa:f3e1 with SMTP id dk13-20020a170907940d00b00973daaaf3e1mr8763875ejc.39.1686215778565;
        Thu, 08 Jun 2023 02:16:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ssA8LbEuNba5wrIlkWrwkykJZqPvTjTVBcB3aqCAGv0JOUgrTFDP7mbrP+L5w00CG8+Cy6g==
X-Received: by 2002:a17:907:940d:b0:973:daaa:f3e1 with SMTP id dk13-20020a170907940d00b00973daaaf3e1mr8763864ejc.39.1686215778223;
        Thu, 08 Jun 2023 02:16:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jt26-20020a170906dfda00b00978993e0d21sm431526ejc.78.2023.06.08.02.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:16:17 -0700 (PDT)
Message-ID: <f27f0d06-0b18-06bb-cb1f-042527c1ca31@redhat.com>
Date:   Thu, 8 Jun 2023 11:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] platform/x86: dell-laptop: Add drm module soft dependency
Content-Language: en-US, nl
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAFv23QmVP4ZFAhAFBSx6ty-4fcQ-u9+uZb0xaD2gCJPCdpPvQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AceLan,

On 6/8/23 05:04, AceLan Kao wrote:
> Hans de Goede <hdegoede@redhat.com> 於 2023年6月8日 週四 上午3:16寫道：
>>
>> Hi,
>>
>> On 6/7/23 09:47, Matthew Garrett wrote:
>>> On Wed, Jun 07, 2023 at 03:39:33PM +0800, AceLan Kao wrote:
>>>
>>>> What do you think if we unregister backlight devices if the backlight type
>>>> is larger than the current registered one.
>>>> Do this check in backlight_device_register() and unregister backlight
>>>> devices by the order raw(1) > platform(2) > firmware(3)
>>>> And maybe introduce a sticky bit into the backlight device if the backlight
>>>> driver doesn't want to be removed.
>>>
>>> Hans looked at doing this, but there were some awkward corner cases.
>>> When we first introduced this functionality, firmware was preferred to
>>> platform was preferred to raw - but on Intel, at least, this behaviour
>>> changed with later versions of Windows. I don't think there's a single
>>> static policy that works, I think you need to pay attention to the hints
>>> the platform gives you. How does Windows know which interface to use on
>>> this platform? The simplest solution may actually just be for
>>> dell-laptop to refuse to register a backlight if the platform claims to
>>> be Windows 8 or later.
>>
>> I like that idea.
>>
>> AceLan, I guess that you hit this easy while testing on a (development)
>> Meteor Lake platform ?
>>
>> I have had other/similar reports about Meteor Lake platforms.
>>
>> On hw from the last 10 years dell-laptop will not register
>> its vendor-type backlight class device because
>> acpi_video_get_backlight_type() will return acpi_backlight_video
>> there (1) so it does not matter if the GPU driver shows up only
>> later (2).
>>
>> But it seems that on Meteor Lake the ACPI tables will no longer
>> contain acpi_video backlight control support which causes
>> acpi_video_get_backlight_type() to return acpi_backlight_vendor (2).
>> triggering the issue you are seeing.
>>
>> Can you give the attached patch a try please ?
>>
>> Regards,
>>
>> Hans
>>
>>
>> 1) Starting with kernel >= 6.2 acpi_video.c will only register
>> the /sys/class/backlight/acpi_video# node after a drm/kms drivers
>> asks it to register it.
>>
>> 2) The native GPU driver will tell the drivers/acpi/video_detect.c
>> code that native backlight control is available changing
>> the return of acpi_video_get_backlight_type() to native, which
>> is why loading the native GPU driver first also fixes this issue.
> 
> Hi Hans,
> 
> Yes, this patch works for me, thanks.
> 
> BTW, I encountered this issue on the RPL platform.

Thank you for testing. I have updated the commit message
to reflect that this impacts both RPL and MTL platforms
and submitted the fix upstream:

https://lore.kernel.org/linux-acpi/20230608091258.7963-1-hdegoede@redhat.com/

Regards,

Hans

