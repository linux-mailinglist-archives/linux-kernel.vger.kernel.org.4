Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01C6B5CAF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCKOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjCKORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE302D146
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678544198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1iG+fjnzXNUUAw3R/ZarZG33QxnXVTiItT/wxoL/grM=;
        b=A98twABi+bO1aNGhTxvQr26WgYbN52LPiOGuAFKpGtg4XVEytmXs1eGDnsBBcl/95RuSuS
        k4smtUEv1Rl2OnDO2+1cv0k5nzwQnt24eRvm0txBDs+EjJdLxft9cO6s/q1n2GGSdte4Ld
        41B4gNECXZqFkKIfaM1qnbaiRlIYx0s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373--wspL0eHO2WcphR8QruPcA-1; Sat, 11 Mar 2023 09:16:37 -0500
X-MC-Unique: -wspL0eHO2WcphR8QruPcA-1
Received: by mail-qt1-f197.google.com with SMTP id k19-20020ac86053000000b003bd0d4e3a50so4485879qtm.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678544196;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iG+fjnzXNUUAw3R/ZarZG33QxnXVTiItT/wxoL/grM=;
        b=J+bBdYK2AWWIDJ4Z5tFLEeTf2T24xur5z21ZePdKGy5Y4p+7aqoQVyLayiUQUmweXR
         5CME/e0w6p4UFLGzfkXctgY2HbB6P4G7CbBd9N7Gk5nBpQHLN7DBeCU35fIBlgttwMQf
         FKA4laZZ2Z/XExvxPtHIlFC38mj1oAVVbfkSehRV92tCPICUy/0kJ7j6GVrb6G2UlTce
         gqeFP4nwa37tvka2hYddGqdfCFq3LU7ac05eyLTx2bPDZAad75DSkg4Rm0Jh1teLScFX
         fNhOAEF2bJvnpm3oIVOlMQuQQ2krLYzaLkOSa+mOj5pGQQcY6bmp4uVKOOO/DcqE9ZQ/
         Esew==
X-Gm-Message-State: AO0yUKVJinLiWUQUjCp//yzTi9uWInG/CMAidGOTUMfK4R1JnNVRRRUK
        nRmlxb0xktVuV9QVxKSJ1MMjic78joOv1qKwj7IVw/yofP7JORyfxbVQd2x1w+tWaUg7OVHBcNB
        bDcqkS4H4coIPPieENIWody/tA28F69+eTS0LjXkgfRQjnC/PfKJinGrFRo9mMEuLFQ7QgU+dGC
        33jBA=
X-Received: by 2002:a05:622a:134a:b0:3c0:3f60:de2e with SMTP id w10-20020a05622a134a00b003c03f60de2emr26168144qtk.16.1678544196428;
        Sat, 11 Mar 2023 06:16:36 -0800 (PST)
X-Google-Smtp-Source: AK7set+Uacq/yCB6vygqoe7xjYr4ZM97FA4S13Brk0Ob44yDZmTcRVeFTIuBL8ns3HyWTiiSsAxBPQ==
X-Received: by 2002:a05:622a:134a:b0:3c0:3f60:de2e with SMTP id w10-20020a05622a134a00b003c03f60de2emr26168114qtk.16.1678544196129;
        Sat, 11 Mar 2023 06:16:36 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id dt37-20020a05620a47a500b007343fceee5fsm1915114qkb.8.2023.03.11.06.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 06:16:35 -0800 (PST)
Subject: Re: [PATCH] platform/x86: x86-android-tablets: select PMIC_OPREGION
 to resolve a link error of intel_soc_pmic_exec_mipi_pmic_seq_element
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310192915.2700069-1-trix@redhat.com>
 <e3c00116-5283-8c76-7414-66f36fb575fa@redhat.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b8fa13a6-5fd7-13e6-812f-2e31b64b1eaf@redhat.com>
Date:   Sat, 11 Mar 2023 06:16:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e3c00116-5283-8c76-7414-66f36fb575fa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/11/23 3:12 AM, Hans de Goede wrote:
> Hi,
>
> On 3/10/23 20:29, Tom Rix wrote:
>> A rand config causes this link error
>> drivers/platform/x86/x86-android-tablets/lenovo.o: In function `lenovo_yt3_init':
>> lenovo.c:(.init.text+0x6c): undefined reference to `intel_soc_pmic_exec_mipi_pmic_seq_element'
>>
>> The rand config has
>> CONFIG_X86_ANDROID_TABLETS=y
>> CONFIG_PMIC_OPREGION=n
>>
>> PMIC_OPREGION should be selected to build the
>> intel_soc_pmic_exec_mipi_pmic_seq_element symbol.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Thanks, but this is a dup with:
>
> https://patchwork.kernel.org/project/platform-driver-x86/patch/20230309094035.18736-1-hdegoede@redhat.com/
>
> I just did not get around to pushing that out to pdx86/for-next yet.
> I have just pushed this to pdx86/for-next to avoid further duplicate fixes.
>
> FWIW, since all other users of PMIC_OPREGION use depends on, not select this
> should have been a depends on too. Unless Kconfig symbols are explicitly
> intended to be selected (typically these are hidden Kconfig symbols (1))
> then you should usually use depends on. Mixing depends on and select leads
> to Kconfig circular dependencies errors.

Ok, thanks for the pointer.

Tom

>
> Regards,
>
> Hans
>
>
> 1) A hidden Kconfig symbol is one which is e.g. just 'bool' not
> 'bool "Description of feature here"' these typically are libraries /
>
> helpers.
>
>
>
>
>> ---
>>   drivers/platform/x86/x86-android-tablets/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/platform/x86/x86-android-tablets/Kconfig b/drivers/platform/x86/x86-android-tablets/Kconfig
>> index 2b3daca5380b..65980229d783 100644
>> --- a/drivers/platform/x86/x86-android-tablets/Kconfig
>> +++ b/drivers/platform/x86/x86-android-tablets/Kconfig
>> @@ -6,6 +6,7 @@
>>   config X86_ANDROID_TABLETS
>>   	tristate "X86 Android tablet support"
>>   	depends on I2C && SPI && SERIAL_DEV_BUS && ACPI && EFI && GPIOLIB
>> +	select PMIC_OPREGION
>>   	help
>>   	  X86 tablets which ship with Android as (part of) the factory image
>>   	  typically have various problems with their DSDTs. The factory kernels

