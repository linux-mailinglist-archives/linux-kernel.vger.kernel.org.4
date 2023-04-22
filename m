Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FBC6EBA78
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjDVQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDVQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:47:57 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111FE19B;
        Sat, 22 Apr 2023 09:47:40 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Q3ckw6J2yz9sJ5;
        Sat, 22 Apr 2023 18:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1682182056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIrYwtDUNhK/5waVX3oGzXkU27Yiu2oa4nhKmolwfzA=;
        b=nkYzQtYFyrl+LQ9rMpj32chuo7A1iONlR4jFzFD9XTHDyCMfuHHCniNLvMFsTOa/7u0Dio
        F1p/7pJpQZlt0SQouksXiUMZ5qClYJNIt6AVY7rnNTXyVA914BnQMulrtB4dLNP0y4OSvP
        QXmEb8a243SXNWu1KQfE8iAFoTW3kU9jmFmdHwKzZ2H/LJW8BYc+rtg/9ZQaPRLfSDn4Hq
        ltyB2KPQkYFRdJM4en2WaQxkxp9D/llEQxWLuE534kSt8Hpxpc/AOOYqxV9mq5868qXi0m
        ohjbn7A4VglZZPnZ6nwVWVr/aYmv0VziANtNo4QnhY3Du6yDM8Kqi8A+CKb6lA==
Message-ID: <d0068345-6832-c9ae-ec40-bb692baa3f69@mariushoch.de>
Date:   Sat, 22 Apr 2023 18:47:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ACPI: scan: Ignore MAGN0001
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230421162702.3558-1-mail@mariushoch.de>
 <06e9623d-26ae-e0e3-8fd8-1f5c89497a5a@redhat.com>
Content-Language: en-US
From:   Marius Hoch <mail@mariushoch.de>
In-Reply-To: <06e9623d-26ae-e0e3-8fd8-1f5c89497a5a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 21/04/2023 20:07, Hans de Goede wrote:
> Hi Marius,
>
> On 4/21/23 18:27, Marius Hoch wrote:
>> The LSM303D on the Lenovo Yoga Tablet 2 series is present
>> as both ACCL0001 and MAGN0001. As we can only ever register an
>> i2c client for one of them, ignore MAGN0001.
>>
>> Currently this errors:
>> i2c i2c-4: Failed to register i2c client MAGN0001:00 at 0x1d (-16)
>>
>> Tested on a Lenovo Yoga Tablet 2 1051-F.
>>
>> Signed-off-by: Marius Hoch <mail@mariushoch.de>
> By adding the HID to the ignore_serial_bus_ids[] list, you are
> causing the ACPI code to instead instantiate a platform_device
> for it.
>
> This will successfully silence the error you are trying to silence,
> but I don't think it really is what you intent / want to do ?
It is not, no. Given we will only ever care for ACCL0001, we can 
entirely skip MAGN0001.
>
> IMHO it would be better to add a NOT_PRESENT_ENTRY_HID() entry
> to the override_status_ids[] table in drivers/acpi/x86/utils.c,
> this will override the return of _STA, causing neither a
> platform_device not an i2c_client to get instantiated for
> the duplicate MAGN0001 device.
That sounds much better, thanks for the pointer!
I've send a new patch (20230422164401.5986-1-mail@mariushoch.de).

Cheers,
Marius
>
> (please keep the comment above the entry why the entry is there)
>
> Regards,
>
> Hans
>
>
>
>
>
>
>
>> ---
>>   drivers/acpi/scan.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 0c6f06abe3f4..d21c411e9719 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1730,6 +1730,12 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>>   	 */
>>   		{"BCM4752", },
>>   		{"LNV4752", },
>> +	/*
>> +	 * The LSM303D on the Lenovo Yoga Tablet 2 series is present
>> +	 * as both ACCL0001 and MAGN0001. As we can only ever register an
>> +	 * i2c client for one of them, ignore MAGN0001.
>> +	 */
>> +		{"MAGN0001", },
>>   		{}
>>   	};
>>   
>>
>> base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f

