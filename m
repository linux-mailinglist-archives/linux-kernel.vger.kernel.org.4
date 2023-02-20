Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB2869C6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjBTIom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBTIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:44:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE4C164
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676882641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bIx447q7zOccwg9isjOzlMuhknxYljdkPuPhMeel7o=;
        b=Ocz3BL2Bi4nexqwzHsPjM28IP4BZ6seUMW7u/+WyrK9dzOXy9wYDQH2AcBwFQadPQSY6Z9
        ezJkit7Lc1xN8ZDF492FLKCIr1V2GKj8ai6wL9HOU3Aqs8tMV4+0SHLeI2GyFqmvDbA/lz
        QL6vURZ0+R0eh7gnfpRuNyagfFtUuac=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-674-Uo0JUt4cMwOdKsKXhGvReQ-1; Mon, 20 Feb 2023 03:43:59 -0500
X-MC-Unique: Uo0JUt4cMwOdKsKXhGvReQ-1
Received: by mail-ed1-f70.google.com with SMTP id b1-20020aa7dc01000000b004ad062fee5eso781458edu.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bIx447q7zOccwg9isjOzlMuhknxYljdkPuPhMeel7o=;
        b=EsQVFCf5TOZsITt7uNdytZZkbMO01XRMFRAtUf6OBHZbKf1Ju1YX7CBP9t/Agny38C
         ax8bqNjZUlKRPI63JeOkZWt9afs0AHUDmBXYJuN/hi1uJ6+4f0mQ7z8T5k+Njcn/VxVy
         sojLfFKsnDXmEN8MEUpq+Vahvt6Dk3ogqiBgsi5O/zfLOW+n5Et1dL83TdGowT5khvB9
         XhTkyUTlY3KqxTwPg//L2c2OZzl6p62dGv/i2YcnpXViO8P4L0p7dLu1ILZCsT2YP8VC
         D9I1HCSPp7JgxOjTV8gOnhA5pikepEuIrztts1L+E2Y6VUzzsh65pHLIReShoECacRR2
         qTWQ==
X-Gm-Message-State: AO0yUKWdzlKQl7S4NplG9iT9TujS64fltvHjeiIYeDNvDTn9Y/q3txc0
        Bhmt0Q0I5Hitmib46bHfirO0w+IUeaGh9lLRk+mVfGYQkqV93bqal7DKQhXpIYK52y9dq03zR+p
        Ybu+4Rk+PLTSHQnUd8cVUfJuS
X-Received: by 2002:a17:906:f6c4:b0:8b1:20f4:44a3 with SMTP id jo4-20020a170906f6c400b008b120f444a3mr7979740ejb.7.1676882638562;
        Mon, 20 Feb 2023 00:43:58 -0800 (PST)
X-Google-Smtp-Source: AK7set+58GGsB5PqX1g9IAc8g9ygEgGVI/hQd4d0eNE8503gRE129xA2uYyWHH8ochtavL3PvBJfDQ==
X-Received: by 2002:a17:906:f6c4:b0:8b1:20f4:44a3 with SMTP id jo4-20020a170906f6c400b008b120f444a3mr7979726ejb.7.1676882638289;
        Mon, 20 Feb 2023 00:43:58 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id hb22-20020a170906b89600b008b14d3978adsm5440924ejb.189.2023.02.20.00.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 00:43:57 -0800 (PST)
Message-ID: <5cc2d613-d4fd-84e7-9791-963d69a66869@redhat.com>
Date:   Mon, 20 Feb 2023 09:43:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: API for setting colors of RGB backlit keyboard zones (was [PATCH
 V3] platform/x86: hp-wmi: Support omen backlight control wmi-acpi methods)
Content-Language: en-US
To:     Rishit Bansal <rishitbansal0@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
References: <20230131235027.36304-1-rishitbansal0@gmail.com>
 <9b761996-d522-b0f8-6472-10e40e09e036@redhat.com>
 <65a11a89-e780-6d60-a40e-cd3245780762@gmail.com>
 <b83ad6ba-7d55-f309-5d7b-4a5ff77ff5a3@redhat.com>
 <02c96cfe-ab10-513f-fc36-f474dd227656@gmail.com>
 <544484b9-c0ac-2fd0-1f41-8fa94cb94d4b@redhat.com>
 <Y+I7xNqkq/X6Lag+@duo.ucw.cz>
 <3c48e204-780c-f78c-8219-267e297dc1e3@gmail.com>
 <ec5bc4a6-dc9f-90dd-0cf6-5fab47bb5fa6@redhat.com>
 <b11185d3-fbf3-a461-39bc-67bee4739e40@gmail.com>
 <Y/C7A9eCjpdbzYbz@duo.ucw.cz>
 <bd2ae598-3f13-f465-4bde-6ab364b79db3@redhat.com>
 <a11fd918-d1bc-8a1f-c123-bcb0b4fa38a5@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a11fd918-d1bc-8a1f-c123-bcb0b4fa38a5@gmail.com>
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

On 2/19/23 19:46, Rishit Bansal wrote:
> 
> 
> On 19/02/23 18:50, Hans de Goede wrote:
>> Hi,
>>
>> On 2/18/23 12:48, Pavel Machek wrote:
>>> Hi!
>>>
>>>
>>>>> I do agree with you that we need to avoid kbd_backlight in the name to avoid causing existing upower code to have weird interactions with this (it supports / assumes there is only 1 kbd_backlight LED class device).
>>>>>
>>>>> So lets go with just these 4:
>>>>>
>>>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-1/
>>>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-2/
>>>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-3/
>>>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-4/
>>>>>
>>>>> Using the _zoned_ between kbd and baclight to avoid confusing the existing upower code. Then once this has landed we can look into extending upower support for this.
>>>>>
>>>>> Note the requested documentation patch should probably also explain that the _zoned_ was done deliberately to make current upower code ignore the devices.
>>>>>
>>>
>>>>
>>>> This makes sense, I agree that the global LED file will cause more confusion
>>>> and hacks in the code. I'll start working on the  _zoned_ naming scheme with
>>>> 4 files + documentation changes and make a patch for this soon!
>>>>
>>>
>>> /sys/class/leds/:rgb:kbd_zoned_backlight-4/ is better than what was
>>> suggested above.
>>
>> Ah yes using rgb for the color part of the name makes sense.
>>
>>> But we already use _1 suffix to deduplicate the, so
>>> I'm not sure this is best naming.
>>
>>
>>
>> I guess we could try to actually name the zones, something like
>> (no idea if this are indeed the 4 zones):
>>
>> :rgb:kbd_zoned_backlight-main
>> :rgb:kbd_zoned_backlight-wasd
>> :rgb:kbd_zoned_backlight-cursor
>> :rgb:kbd_zoned_backlight-numpad
>>
>> Rishit any comments on this or improvements to it.
> 
> Here is an image of how the 4 zones on the keyboard look like (https://imgur.com/a/iQdRWCM). I think we can call them "left", "middle", "right", and "wasd":
> 
> :rgb:kbd_zoned_backlight-left
> :rgb:kbd_zoned_backlight-middle
> :rgb:kbd_zoned_backlight-right
> :rgb:kbd_zoned_backlight-wasd

Sounds good to me, lets go for this. Please add these names to
the requested documentation update.

Regards,

Hans

