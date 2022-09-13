Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148465B7A32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiIMSxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiIMSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:52:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B12344561;
        Tue, 13 Sep 2022 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Nhmtl5U4i4aIMPF1bl0Sfg+C74cfK2TnIe+LlE37uRU=; b=eK0RlLHEjCIF0rUTBXogwTMNSv
        IfpEnispYRuoUd9lahWonBcV7K9cdHI6PIehPePhbfbRsFa/b7lcN6npUcyF61eOuZMVQbjEAEzm3
        AqpLwwOfknRGzfWmhClsPzpCvtGSPSs1mVQ+nWmpu4tMYAxrJ8NyyB14k6Q40vA2aqm1E5qBBu72N
        59SstCz0pagKKcI63IKdWDEGjBPrOUOxtma1dmuW5iNKyhJG3F32oYdKqQS5uhj4nu0WVptuxc8fM
        A6asMYDS2YyJXpmGCigZD2zcCFAvDFKtttW8X/3ZQ4AIv1QwiRyh4y2tus454mkIMCTdDuSyqLGiE
        XzTjTmAA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYAnB-00EnsI-7s; Tue, 13 Sep 2022 18:37:53 +0000
Message-ID: <e324fb96-bbf9-5ec6-78f3-9f298dac0644@infradead.org>
Date:   Tue, 13 Sep 2022 11:37:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Armin Wolf <W_Armin@gmx.de>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "hmh@hmh.eng.br" <hmh@hmh.eng.br>,
        "matan@svgalib.org" <matan@svgalib.org>,
        "corentin.chary@gmail.com" <corentin.chary@gmail.com>,
        "jeremy@system76.com" <jeremy@system76.com>,
        "productdev@system76.com" <productdev@system76.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-6-W_Armin@gmx.de>
 <b1b794b4-f6c3-7697-5d5a-b811809a9313@infradead.org>
 <2aae0ae9-9608-675a-ec0c-6e7526e57363@gmx.de>
 <MN0PR12MB6101CE9055DC152A6E96B2EDE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
 <7224d38e-9b51-0f81-e113-72f065909ea0@infradead.org>
 <4ec6d46f-b5c9-3c47-a102-6356e72c5225@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4ec6d46f-b5c9-3c47-a102-6356e72c5225@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/22 11:30, Limonciello, Mario wrote:
> On 9/13/2022 13:27, Randy Dunlap wrote:
>>
>>
>> On 9/13/22 09:08, Limonciello, Mario wrote:
>>> [Public]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Armin Wolf <W_Armin@gmx.de>
>>>> Sent: Tuesday, September 13, 2022 09:41
>>>> To: Randy Dunlap <rdunlap@infradead.org>; hdegoede@redhat.com;
>>>> markgross@kernel.org
>>>> Cc: rafael@kernel.org; lenb@kernel.org; hmh@hmh.eng.br;
>>>> matan@svgalib.org; corentin.chary@gmail.com; jeremy@system76.com;
>>>> productdev@system76.com; platform-driver-x86@vger.kernel.org; linux-
>>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
>>>>
>>>> Am 12.09.22 um 23:56 schrieb Randy Dunlap:
>>>>
>>>>> Hi--
>>>>>
>>>>> On 9/12/22 05:53, Armin Wolf wrote:
>>>>>> diff --git a/drivers/platform/x86/dell/Kconfig
>>>> b/drivers/platform/x86/dell/Kconfig
>>>>>> index 25421e061c47..209e63e347e2 100644
>>>>>> --- a/drivers/platform/x86/dell/Kconfig
>>>>>> +++ b/drivers/platform/x86/dell/Kconfig
>>>>>> @@ -189,6 +189,19 @@ config DELL_WMI_DESCRIPTOR
>>>>>>        default n
>>>>>>        depends on ACPI_WMI
>>>>>>
>>>>>> +config DELL_WMI_DDV
>>>>>> +    tristate "Dell WMI sensors Support"
>>>>>> +    default m
>>>>> You should (try to) justify default m, otherwise just
>>>>> don't have a default for it.
>>>>
>>>> I have chosen default m since many other Dell platform drivers are being
>>>> default m. Since this driver is not essential for normal operation,
>>>> i will drop default m then.
>>>
>>> Actually Dell drivers directory are a bit unique in this regard.  There is a special
>>> top level boolean.  I would suggest to keep it as is.
>>>
>>> Take a look at:
>>> menuconfig X86_PLATFORM_DRIVERS_DELL
>>>
>>
>> So all of those "default m" and "default y" drivers are *needed*
>> as opposed to desirable?
>>
> 
> It was supposed to be a convenience option, it's first introduced in f1e1ea516721d1.
> 
> So if you have a Dell laptop you set the one option and then get defaults for all those modules.

oh well. whatever.

thanks.

>>>>
>>>> Armin Wolf
>>>>
>>>>>> +    depends on ACPI_BATTERY
>>>>>> +    depends on ACPI_WMI
>>>>>> +    help
>>>>>> +      This option adds support for WMI-based sensors like
>>>>>> +      battery temperature sensors found on some Dell notebooks.
>>>>>> +      It also supports reading of the batteries ePPID.
>>>>>> +
>>>>>> +      To compile this drivers as a module, choose M here: the module will
>>>>>> +      be called dell-wmi-ddv.
>>
>> thanks.
> 

-- 
~Randy
