Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DC6F23D8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 11:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjD2J2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD2J2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 05:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19267172A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682760448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfB3ZMqimdPUhX5nGpTF53m3LpvPeKGPMjucJtvQhEU=;
        b=QEqOGofeik+kh3u99JHZVr3Bw6KpHDQ7/ch3aAxLBpuneYjSRq+8qV1NZDZJP6qcIwizzl
        iF42Y/gZmhIT85BH1opN6bmCXsBpb9C3lCgB4OiWly/OcvnyPiyqAVMKBLWlLhyFCz1z50
        eC0xNb7Qw812VNU+7VdGgt/oD1MmOt4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-koM05-cQPQ-T8KMv51D1ng-1; Sat, 29 Apr 2023 05:27:26 -0400
X-MC-Unique: koM05-cQPQ-T8KMv51D1ng-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9576a365957so93215466b.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 02:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682760446; x=1685352446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfB3ZMqimdPUhX5nGpTF53m3LpvPeKGPMjucJtvQhEU=;
        b=VU335yYVd5rs73AdRbumpLrXKfjjeyLrUKrejJezBPcVefeCJ1mKpcb01o3EKvFXKt
         0pIrCaUd9CV0+5RbU3Tm9NLIgU0LwtMiDLSBhe7kxigr5U/LipMCdYGk+KK05wcofx1O
         w6NqLj2fT0s7NLUlbt7Ewg/SjN0JNALLih4ku6d7+EfWf7ukF4P1+Cy/EvMtnFhVLKNV
         FQuuQJD9pWDguT2a6zpq18kkuD1QEXLp+G65QqyTGnMYsJOGLYHLS/bq50eHkdyNJxfV
         JifCO8dzQlRjGO4bayiegdUc8JToHKN8bWnPSfBswa9pNtVYCuIf2eMKlNnvIkQ+apha
         oHtQ==
X-Gm-Message-State: AC+VfDyyHusjE+bx1E9adYSgQjwreyNdj/9+B2nlWVEQB5NYfIPpXKVY
        pKDPA0U6s2scpss8fFQzAhKh/QXaGjzYQ4EhrPTE/lrP8oqIKmjTp9hHvNvS2LtcyBLMOWh7zae
        O6se1WTuEUmLmRySg5MQ90rkM
X-Received: by 2002:a17:907:94ca:b0:92f:924b:e8f4 with SMTP id dn10-20020a17090794ca00b0092f924be8f4mr7723759ejc.4.1682760445857;
        Sat, 29 Apr 2023 02:27:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Cm68ZUeU1U91IWUgPnHSGdiLMMiAKPkHLdDEGcE7kyXyU51tAyKO703Jwl3Z2AJMhVQBp9g==
X-Received: by 2002:a17:907:94ca:b0:92f:924b:e8f4 with SMTP id dn10-20020a17090794ca00b0092f924be8f4mr7723745ejc.4.1682760445568;
        Sat, 29 Apr 2023 02:27:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hb8-20020a170906b88800b0094bb4c75695sm12326825ejb.194.2023.04.29.02.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 02:27:24 -0700 (PDT)
Message-ID: <b6340042-e0fa-5706-0b9b-1d9dd17da11a@redhat.com>
Date:   Sat, 29 Apr 2023 11:27:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v2 1/2] platform/x86: wmi: Allow retrieving the number of
 WMI object instances
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230426212848.108562-1-W_Armin@gmx.de>
 <20230426212848.108562-2-W_Armin@gmx.de>
 <339c6ba5-6d60-8271-1b5d-6c4165801187@redhat.com>
 <4db0e619-7f18-3f6b-9fb3-769f95233a72@gmx.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4db0e619-7f18-3f6b-9fb3-769f95233a72@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/27/23 18:26, Armin Wolf wrote:
> Am 27.04.23 um 11:43 schrieb Hans de Goede:
> 
>> Hi Armin,
>>
>> Thank you for your work on this.
>>
>> On 4/26/23 23:28, Armin Wolf wrote:
>>> Currently, the WMI driver core knows how many instances of a given
>>> WMI object exist, but WMI drivers cannot access this information.
>>> At the same time, some current and upcoming WMI drivers want to
>>> have access to this information. Add wmi_instance_count() and
>>> wmidev_instance_count() to allow WMI drivers to get the number of
>>> WMI object instances.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>   drivers/platform/x86/wmi.c | 40 ++++++++++++++++++++++++++++++++++++++
>>>   include/linux/acpi.h       |  2 ++
>>>   include/linux/wmi.h        |  2 ++
>>>   3 files changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>> index c226dd4163a1..7c1a904dec5f 100644
>>> --- a/drivers/platform/x86/wmi.c
>>> +++ b/drivers/platform/x86/wmi.c
>>> @@ -263,6 +263,46 @@ int set_required_buffer_size(struct wmi_device *wdev, u64 length)
>>>   }
>>>   EXPORT_SYMBOL_GPL(set_required_buffer_size);
>>>
>>> +/**
>>> + * wmi_instance_count - Get number of WMI object instances
>>> + * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>>> + * @instance_count: variable to hold the instance count
>>> + *
>>> + * Get the number of WMI object instances.
>>> + *
>>> + * Returns: acpi_status signaling success or error.
>>> + */
>>> +acpi_status wmi_instance_count(const char *guid_string, u8 *instance_count)
>>> +{
>>> +    struct wmi_block *wblock;
>>> +    acpi_status status;
>>> +
>>> +    status = find_guid(guid_string, &wblock);
>>> +    if (ACPI_FAILURE(status))
>>> +        return status;
>>> +
>>> +    *instance_count = wmidev_instance_count(&wblock->dev);
>>> +
>>> +    return AE_OK;
>>> +}
>>> +EXPORT_SYMBOL_GPL(wmi_instance_count);
>> I would prefer this to have a normal kernel function prototype
>> which returns -errno rather then returning an acpi_status. E.g. :
>>
>> /**
>>   * wmi_instance_count - Get number of WMI object instances
>>   * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>>   *
>>   * Get the number of WMI object instances.
>>   *
>>   * Returns: The number of WMI object instances, 0 if the GUID is not found.
>>   */
>> int wmi_instance_count(const char *guid_string)
>> {
>>     struct wmi_block *wblock;
>>     acpi_status status;
>>
>>     status = find_guid(guid_string, &wblock);
>>     if (ACPI_FAILURE(status))
>>         return 0;
>>
>>     return wmidev_instance_count(&wblock->dev);
>> }
>> EXPORT_SYMBOL_GPL(wmi_instance_count);
>>
>> This will also allow this to completely replace
>> the get_instance_count() function in dell-wmi-sysman.
>>
>> Note I have just gone with always returning 0 here
>> on error. I guess you could look at the status and
>> return 0 for not-found and -errno for other errors
>> but I don't think any callers will care for the difference,
>> so just always returning 0 seems easier for callers to
>> deal with.
>>
>> As always this is just a suggestion, let me know if
>> you think this is a bad idea.
>>
>> Regards,
>>
>> Hans
>>
> I like this idea. Returning a negative errno on error would allow drivers to
> distinguish between "WMI object not found" and "zero instances found", which
> might be useful for some drivers.
> 
> Maybe a function for converting ACPI errors to POSIX errors already exists,
> otherwise i will just write one myself.

Ok, that sounds good to me. I'm looking forward to a non RFC submission
of these changes.

Regards,

Hans


