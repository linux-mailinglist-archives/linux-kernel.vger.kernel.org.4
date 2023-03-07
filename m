Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5A6ADED0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCGMfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCGMfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D160034F74
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678192468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKnr0DUp/m2+BwAmLNBkIvjqUTFOrVYFFcfsOrK3Ipk=;
        b=LZjaafEIu4SaIUAEAn9bvra9Wv+4uMxPa3i3d6znwOCHUcY5Oq9qXdoC1z/eG3kircQ8mB
        VLnz5G+eM4zcTDSaI961ncWf5k0LGRRJIeZT2pa1Q8UlUYZEcggENiQzlR90f2EGAGMhl0
        jf2RBepQ11T/FwE9ZO+KrDAqC+vGjtk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-83jHpsBPP-WexOoBO9-44A-1; Tue, 07 Mar 2023 07:34:26 -0500
X-MC-Unique: 83jHpsBPP-WexOoBO9-44A-1
Received: by mail-ed1-f69.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so18402285edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678192465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKnr0DUp/m2+BwAmLNBkIvjqUTFOrVYFFcfsOrK3Ipk=;
        b=pxk8v5YMEZiM4VGMBMS0q2GYYl8v98Nu3Qdruh9dPOe+vdn59l1nmC94bGpKswMVAp
         BRr1lRlQ4wJKuMLdy5Xi8dkyzJvOv3uuUSZkl8K1vBhrPO1caeVBTixDkOcu0P0aD406
         DB6dWEuqDWfHC5kXXpfPNqc5TqNgJcxI21i54f/JvI5XZE5VNgDfORXMG+gnclU52dbJ
         tV8P9j8ONprfha8/taj4/dYidsbvLyCXRAyYtFOORkRt00wmN06rsFZHwzbmAggLfsXz
         fHJ+9FLxv8nmWO/p2yleSLoJUKqm/kdASaYMIPF0U6daWHY0IeJtQ02sOWnnmIm1L+Hu
         YfJA==
X-Gm-Message-State: AO0yUKW1scsXm7171p/A/WnVbwWJ4IbGh26HZDm513qs2YAskjbbQ99o
        +XOGuaRL8j+WTyUcMkaX9SDpLmvSHkKSDdQazt5yDp5NVClazqBixeO6YZaUlIXfqgoHjJBTpny
        FUsFkZuQCd822OUcB7yTv4x8f
X-Received: by 2002:a17:906:fe0c:b0:8b3:b74:aeb5 with SMTP id wy12-20020a170906fe0c00b008b30b74aeb5mr18325972ejb.30.1678192465822;
        Tue, 07 Mar 2023 04:34:25 -0800 (PST)
X-Google-Smtp-Source: AK7set8iX49b4+qtmGhtc9D6W+y2btz3BJ60OCfbE03rLGSf8RexIl8hvboRPNJlCF415awJ/SJcmQ==
X-Received: by 2002:a17:906:fe0c:b0:8b3:b74:aeb5 with SMTP id wy12-20020a170906fe0c00b008b30b74aeb5mr18325953ejb.30.1678192465488;
        Tue, 07 Mar 2023 04:34:25 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bl15-20020a170906c24f00b008d83ad86fe8sm6048770ejb.59.2023.03.07.04.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:34:24 -0800 (PST)
Message-ID: <d3a285c6-2c0b-99e8-5d98-b5eb8d44d54a@redhat.com>
Date:   Tue, 7 Mar 2023 13:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] backlight: apple_bl: Use acpi_video_get_backlight_type()
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230307120540.389920-1-hdegoede@redhat.com>
 <ZActl7YN+u7Yz58m@smile.fi.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZActl7YN+u7Yz58m@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/7/23 13:27, Andy Shevchenko wrote:
> On Tue, Mar 07, 2023 at 01:05:40PM +0100, Hans de Goede wrote:
>> On some MacBooks both the apple_bl and the apple-gmux backlight drivers
>> may be able to export a /sys/class/backlight device.
>>
>> To avoid having 2 backlight devices for one LCD panel until now
>> the apple-gmux driver has been calling apple_bl_unregister() to move
>> the apple_bl backlight device out of the way when it loads.
>>
>> Similar problems exist on other x86 laptops and all backlight drivers
>> which may be used on x86 laptops have moved to using
>> acpi_video_get_backlight_type() to determine whether they should load
>> or not.
>>
>> Switch apple_bl to this model too, so that it is consistent with all
>> the other x86 backlight drivers.
>>
>> Besides code-simplification and consistency this has 2 other benefits:
>>
>> 1) It removes a race during boot where userspace will briefly see
>>    an apple_bl backlight and then have it disappear again, leading to e.g.:
>>    https://bbs.archlinux.org/viewtopic.php?id=269920
>>
>> 2) This allows user to switch between the drivers by passing
>>    acpi_backlight=apple_gmux or acpi_backlight=vendor on the kernel
>>    commandline.
> 
> ...
> 
>> +	depends on ACPI_VIDEO=n || ACPI_VIDEO
> 
> I'm wondering if "imply ACPI_VIDEO" (i.o.w. weak dependency) is what suitable
> here.

No, because then if apple_bl is builtin and acpi_video is a module
we will get unresolved dependencies.

The quoted bit of Kconfig magic is exactly to avoid that scenario,
other combinations are fine (due to stubs in acpi/video.h when
disabled).

Regards,

Hans


