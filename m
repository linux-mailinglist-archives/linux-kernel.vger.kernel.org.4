Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4820461F0F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiKGKlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKGKlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBAF12D0B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667817654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOI04EjI3O9ZzvsFWiAIDa7+u7EqLZMtqbHkmMa9+zY=;
        b=OlPSj2G9Sx+MBTZqrFcFxUOCKIrN6gASKxCrG5Ky7w7jktEEQ51Hru5+cR6h4HTKo9HxWw
        hLHxgkV02uRvRCq+FLAMydbT0SqvLqMXu+2X/iLDzOk9uW2bq+xbL0fku3Iv7vp4qUBKYX
        owYEJzfB0RDzKgqnV3WvskD5CcC/DAc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-385-oQ9v69KmNGukgm4g7X9YKQ-1; Mon, 07 Nov 2022 05:40:52 -0500
X-MC-Unique: oQ9v69KmNGukgm4g7X9YKQ-1
Received: by mail-ed1-f69.google.com with SMTP id q13-20020a056402518d00b00462b0599644so8169257edd.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOI04EjI3O9ZzvsFWiAIDa7+u7EqLZMtqbHkmMa9+zY=;
        b=jSrCQHBtR+ihChd76/IUCka/Rkgp6uSfQJHGM88Uy27iHcT6Vhljk11rjNOajk27/T
         drba46XYJkbrsTuY18/5X9BdKPmxuqYeaPv6lQj2jQSzBMjYaRFj99XZ4MmrhYkSn+yz
         E4JgKRIiFTwK124b6gYb97e+ENmvaCmYQeadwJ7MYan2E2MLhcCjC3890nXSmpkGOOBZ
         YbIuNmd+CK7RsBGEZhIS+IBkXPEsf+IzrSk5ruTUIi6PvSJarNc3CBgYrAz4yQeT2EYu
         akWr/7hFQ/kJUQgMmDdKnl72atl31bLadYzBjlx/9jTwgJT0MT2ZrDKwUjT9UKC9TReI
         gQ3A==
X-Gm-Message-State: ACrzQf0DRWfPX0dtf6xWHgLsaanCVyLxirBWEW1xtxoPiBksKP+PVt6F
        JmVZO7MFJqbi+TKghw5CNX+mEe3d5b9+Vt5CTNrgRBxgdeOfKZ2rxy7Uqf23VxZIVAKoKe2iugT
        KNoX6a7dliJ0fNfe/xCMX+TVV
X-Received: by 2002:a17:907:969e:b0:7a6:fe3:6f11 with SMTP id hd30-20020a170907969e00b007a60fe36f11mr47854631ejc.501.1667817651415;
        Mon, 07 Nov 2022 02:40:51 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5yuuVGtrX6nqxx0QzI2KV2bH4Ckq5XZu6QTRAyQ52BRH+Jsx6QTaPYbCZFV/iTxAa6SrTNPA==
X-Received: by 2002:a17:907:969e:b0:7a6:fe3:6f11 with SMTP id hd30-20020a170907969e00b007a60fe36f11mr47854622ejc.501.1667817651237;
        Mon, 07 Nov 2022 02:40:51 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g22-20020a50ee16000000b004616b006871sm3979043eds.82.2022.11.07.02.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:40:50 -0800 (PST)
Message-ID: <718b55db-5597-45eb-893a-aabd59646bf2@redhat.com>
Date:   Mon, 7 Nov 2022 11:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1] hp_wmi causing rfkill soft blocked wifi
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Jorge Lopez <jorgealtxwork@gmail.com>,
        "balalic.enver@gmail.com" <balalic.enver@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "Tsao, Anson" <anson.tsao@amd.com>
References: <20221028155527.7724-1-jorge.lopez2@hp.com>
 <MN0PR12MB6101426E91BB9B6D1A4F03F6E2329@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <MN0PR12MB6101426E91BB9B6D1A4F03F6E2329@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/28/22 18:08, Limonciello, Mario wrote:
> [Public]
> 
> +Anson
> 
>> -----Original Message-----
>> From: Jorge Lopez <jorgealtxwork@gmail.com>
>> Sent: Friday, October 28, 2022 10:55
>> To: hdegoede@redhat.com; balalic.enver@gmail.com; platform-driver-
>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: markgross@kernel.org
>> Subject: [PATCH v1] hp_wmi causing rfkill soft blocked wifi
>>
>> After upgrading BIOS to U82 01.02.01 Rev.A, the console is flooded
>> strange char "^@" which printed out every second and makes login
>> nearly impossible. Also the below messages were shown both in console
>> and journal/dmesg every second:
>>
>> usb 1-3: Device not responding to setup address.
>> usb 1-3: device not accepting address 4, error -71
>> usb 1-3: device descriptor read/all, error -71
>> usb usb1-port3: unable to enumerate USB device
>>
>> Wifi is soft blocked by checking rfkill. When unblocked manually,
>> after few seconds it would be soft blocked again. So I was suspecting
>> something triggered rfkill to soft block wifi.  At the end it was
>> fixed by removing hp_wmi module.
>>
>> The root cause is the way hp-wmi driver handles command 1B on
>> post-2009 BIOS.  In pre-2009 BIOS, command 1Bh return 0x4 to indicate
>> that BIOS no longer controls the power for the wireless devices.
>>
>> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216468
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Hans,
> 
> Since this is effectively essentially removing the broken BIOS RFKILL interface
> for numerous machines I think this should probably go to stable too, if you agree.

I agree, I've added a Cc: stable while merging this and I'll include this
in my next fixes pull-req to Linus.

Jorge, many thanks for fixing this!

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
>>
>> ---
>> Based on the latest platform-drivers-x86.git/for-next
>> ---
>>  drivers/platform/x86/hp-wmi.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
>> index 627a6d0eaf83..29cd4e437d97 100644
>> --- a/drivers/platform/x86/hp-wmi.c
>> +++ b/drivers/platform/x86/hp-wmi.c
>> @@ -1300,8 +1300,15 @@ static int __init hp_wmi_bios_setup(struct
>> platform_device *device)
>>  	wwan_rfkill = NULL;
>>  	rfkill2_count = 0;
>>
>> -	if (hp_wmi_rfkill_setup(device))
>> -		hp_wmi_rfkill2_setup(device);
>> +	/*
>> +	 * In pre-2009 BIOS, command 1Bh return 0x4 to indicate that
>> +	 * BIOS no longer controls the power for the wireless
>> +	 * devices. All features supported by this command will no
>> +	 * longer be supported.
>> +	 */
>> +	if (!hp_wmi_bios_2009_later())
>> +		if (hp_wmi_rfkill_setup(device))
>> +			hp_wmi_rfkill2_setup(device);
>>
>>  	err = hp_wmi_hwmon_init();
>>
>> --
>> 2.34.1
> 

