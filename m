Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1D60BBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiJXVUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiJXVTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38BA2764F5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666639482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iFzj8nzx4mTmz0Y3cxobVCxkf6lqhopWzXipdhBzytA=;
        b=h7Sz5FFPWvucaLxGF9nWSPucNdwMBfvzT3odZSI7E4WD2Vex+j8batynDQMZEJGuGvEl5V
        GsAWwGq7y6IJc6yIOhhpnxd3VGcQbCnpwGyqA9VpX844wQeD1nMO8eCEwy5gHIVACkLsSc
        mwn0UEmzRDO6dfO+WnVhUZzMiejVZXg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-499-aJt1dOPeM5KJBmvarHPVmg-1; Mon, 24 Oct 2022 10:59:26 -0400
X-MC-Unique: aJt1dOPeM5KJBmvarHPVmg-1
Received: by mail-ej1-f71.google.com with SMTP id sb13-20020a1709076d8d00b0078d8e1f6f7aso1140939ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFzj8nzx4mTmz0Y3cxobVCxkf6lqhopWzXipdhBzytA=;
        b=qAYGMm2DscrKHPrLt7uUQ+Bo4hzGko9XR4VHMnP7MpL0zWlLSPXG3OTM+HL7CFl7Gz
         j5CNjxoXLofnEdpWgJDecczuQQDsZ5iIV19NYimW0mwPrPM4GCVtfejY0NjeKLH5E7+o
         gh51jUej5QRLS/7q5HYA7SSy5HBQFUzqpBjgaPFbQrVamLOwQZuYhAouW01fpZmu/7Tg
         K/8H6LE60CKL3HkXsKOMizj/wLoiaNiOeXHrQee2UC/3z9JDRkYEphLFqFdNJjQMbJ9X
         KUMuzXHotVyST/FcdDFZImWM9ek1HSExGrF/Nv5roN2E4J0t5u1BUMyj6iiaIHkBsQQi
         ypjQ==
X-Gm-Message-State: ACrzQf1Yc46azNvLw15vjLKSHTBaYW/4yIVMtGWRTPt+FKnaVfyJvdPk
        19R/40V8hOmPtoL/+xErl/zSFA2fBMJ/bcdktKG7CofGcS/vQYvpXgMUWIHMxE7LH/k7jb+jghq
        jJ888X1rzXM8X6nWJeCYq5/OA
X-Received: by 2002:a17:907:7f0b:b0:78d:c16e:e5fc with SMTP id qf11-20020a1709077f0b00b0078dc16ee5fcmr28530507ejc.713.1666623565636;
        Mon, 24 Oct 2022 07:59:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM69bJEQQwKngd5TdTH6bub92gbhuYs2zsoHIkPxYVrqbL3E1umD+fdI6rLXDyn6eS9NZQ41YA==
X-Received: by 2002:a17:907:7f0b:b0:78d:c16e:e5fc with SMTP id qf11-20020a1709077f0b00b0078dc16ee5fcmr28530490ejc.713.1666623565451;
        Mon, 24 Oct 2022 07:59:25 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id n16-20020a170906379000b007a6c25819f1sm2043335ejc.145.2022.10.24.07.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:59:24 -0700 (PDT)
Message-ID: <a75c2439-415c-a132-754c-7676029f792b@redhat.com>
Date:   Mon, 24 Oct 2022 16:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] ACPI: video: Fix missing native backlight on
 Chromebooks
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     kernel@collabora.com, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221024141210.67784-1-dmitry.osipenko@collabora.com>
 <37ec64ac-9e08-dd41-4b20-8701bf9413fb@daynix.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <37ec64ac-9e08-dd41-4b20-8701bf9413fb@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/24/22 16:52, Akihiko Odaki wrote:
> On 2022/10/24 23:12, Dmitry Osipenko wrote:
>> Chromebooks don't have backlight in ACPI table, they suppose to use
>> native backlight in this case. Check presence of the CrOS embedded
>> controller ACPI device and prefer the native backlight if EC found.
>>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Fixes: 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native() helper")
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>
>> Changelog:
>>
>> v2: - Added explanatory comment to the code and added check for the
>>        native backlight presence, like was requested by Hans de Goede.
>>
>>   drivers/acpi/video_detect.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index 0d9064a9804c..9cd8797d12bb 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -668,6 +668,11 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>>       { },
>>   };
>>   +static bool google_cros_ec_present(void)
>> +{
>> +    return acpi_dev_found("GOOG0004");
>> +}
>> +
>>   /*
>>    * Determine which type of backlight interface to use on this system,
>>    * First check cmdline, then dmi quirks, then do autodetect.
>> @@ -730,6 +735,13 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>>               return acpi_backlight_video;
>>       }
>>   +    /*
>> +     * Chromebooks that don't have backlight handle in ACPI table
>> +     * are supposed to use native backlight if it's available.
>> +     */
>> +    if (google_cros_ec_present() && native_available)
>> +        return acpi_backlight_native;
>> +
>>       /* No ACPI video (old hw), use vendor specific fw methods. */
>>       return acpi_backlight_vendor;
>>   }
> 
> Hi,
> 
> The native_available check does not prevent duplicate registration if vendor backlight registers first. It was enough for the combination of ACPI video and native because ACPI video delays its registration, but it is not the case for vendor/native combination.

There are no drivers providing acpi_backlight_vendor functionality on chromebooks.

All the drivers providing acpi_backlight_vendor functionality use vendor (Dell, Acer, Asus, etc.)
specific firmware (smbios, EC bitbanging or ACPI) backlight control method which are not available
on CoreBoot based ChromeBooks.

Also notice that the theoretical problem of a vendor driver loading first was already present
before the backlight refactor which landed in 6.1 and this has never been an issue.

Regards,

Hans

