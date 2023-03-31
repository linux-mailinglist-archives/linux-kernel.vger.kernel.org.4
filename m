Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFF76D286D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjCaTFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCaTFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F922E80
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680289498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+r0WN00sxY7Hroo/hPnXAvWHqS8FTdeCAevU2rHES8=;
        b=XGhqa2a5by79MHWI+q9Bn5BzfngQ23trMgeuw8qiQMdA3V3IalPTXCaeMaVQ3Bk+aOtE1v
        g6CHMiEfjE4FCLzlRhqPhsU9ofzzZNjHvvVyNCmPGWaQAz3JbLkih5DXqzOlpYe2J4CEUA
        MinDP+mYpsTPrsRfpR3RhE+8kukxuac=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-WWki2PlSPWKjHnI9J8OoXA-1; Fri, 31 Mar 2023 15:04:57 -0400
X-MC-Unique: WWki2PlSPWKjHnI9J8OoXA-1
Received: by mail-ed1-f70.google.com with SMTP id m18-20020a50d7d2000000b00501dfd867a4so33450370edj.20
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680289496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+r0WN00sxY7Hroo/hPnXAvWHqS8FTdeCAevU2rHES8=;
        b=Gn7/J4Z8dgxqq2/deOfrNHZCLmkjizfClBaSMLkTG1xP18Ccm4241V9ssomoglBGKf
         2Lgk0fWdzzebfRBl2LEL4ErbaVmJVRzuc8AGqZlXX10FhIzaZWhsWa/rxKghRjWG/SMc
         9buJUhRAfT+dvhwLN6cIIofk4dzFx6Lx8KMCXK63yNJXCfj+X139tgc9acLSH+7Z66v7
         hVI7f5O8Lglc+q2ots4h/pEvEBn9RuOeZ54rjOXN7zzjqpwFMcJ3xFa55hL1DA9Tly4u
         gzqyCBJ8RTAz/UT3e6KyfCjVk0WSnYrFg7RTkEhNnLl+pFuuglG4sdLLU9Kp6LDvAxfw
         1Uaw==
X-Gm-Message-State: AAQBX9dT+sDF5jkqZ0Yq2Vem5calD/YTnRmCOgbcXwkKATTsJegNJaJC
        SkyO2UC7nvlWc3d1/OzXaPfkcjWryhCd3LsNohIyyGr2dTutyS4rCKANVBGnM90UO0J+E5dQdTz
        Zb9Nf6Jik0UumuiE3tfzkPrDy
X-Received: by 2002:a17:906:b303:b0:933:48ce:73a5 with SMTP id n3-20020a170906b30300b0093348ce73a5mr26072786ejz.56.1680289495969;
        Fri, 31 Mar 2023 12:04:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350amjLGcMOyimR8YSCqcQck9y2sC3ipxj/zD6t1cDby8ja+vtgrO/hKtX9jM0G/cVvjA6Z7npQ==
X-Received: by 2002:a17:906:b303:b0:933:48ce:73a5 with SMTP id n3-20020a170906b30300b0093348ce73a5mr26072772ejz.56.1680289495699;
        Fri, 31 Mar 2023 12:04:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906348600b009334219656dsm1251286ejb.56.2023.03.31.12.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 12:04:54 -0700 (PDT)
Message-ID: <d1750883-3eba-c824-3f89-9568345709b8@redhat.com>
Date:   Fri, 31 Mar 2023 21:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [BUG] [RFC] systemd-devd triggers kernel memleak apparently in
 drivers/core/dd.c: driver_register()
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Armin Wolf <W_Armin@gmx.de>, Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
 <d011a1d7-34ab-5f54-fcc7-d727abc7ec9b@alu.unizg.hr>
 <ZCLa3_HnLQA0GQKS@kroah.com>
 <b50f9460-ac54-e997-f9b9-3c47a9b87aae@alu.unizg.hr>
 <df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de>
 <16862c45-2ffd-a2f2-6719-020c5d515800@alu.unizg.hr>
 <4f65a23f-4e04-f04f-e56b-230a38ac5ec4@gmx.de>
 <01e920bc-5882-ba0c-dd15-868bf0eca0b8@alu.unizg.hr>
 <8b478e6d-7482-2cbb-ee14-b2dc522daf35@alu.unizg.hr>
 <9f757a7b-6ac9-804a-063f-4cc2c6fc3f54@alu.unizg.hr>
 <de54f828-e2c6-4c10-92ce-ca86fb5c5fb4@t-8ch.de>
 <6a5dc4de-b315-1e6d-e5e2-5b95521a37c7@alu.unizg.hr>
 <2c1d0b9b-0e71-b616-6486-52e741d25afb@redhat.com>
 <9c142ac2-9340-4a9b-8541-99f613772340@app.fastmail.com>
 <4dc118c2-0dde-bd5e-ea41-427ed33e4545@alu.unizg.hr>
 <b06d1d1f-7cd5-4532-ac49-d449ef68bbcb@app.fastmail.com>
 <bccb52fa-e1c9-482c-a024-9a02179728b2@t-8ch.de>
 <b2d0461b-a32b-50e0-640d-9e789bb5da30@alu.unizg.hr>
 <1059aa55-9370-4b8d-8c6c-7fdfd9ac0c70@app.fastmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1059aa55-9370-4b8d-8c6c-7fdfd9ac0c70@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/31/23 20:54, Mark Pearson wrote:
> Hi all,
> 
> On Wed, Mar 29, 2023, at 5:50 PM, Mirsad Goran Todorovac wrote:
>> On 29. 03. 2023. 21:21, Thomas Weißschuh wrote:
>>>
>>> Mar 29, 2023 14:00:22 Mark Pearson <mpearson-lenovo@squebb.ca>:
>>>
>>>> Thanks Mirsad
>>>>
>>>> On Wed, Mar 29, 2023, at 2:49 PM, Mirsad Goran Todorovac wrote:
>>>> <snip>
>>>>>
>>>>> Here is the patch proposal according to what Mark advised (using
>>>>> different name for optitem):
>>>>>
>>>>> diff --git a/drivers/platform/x86/think-lmi.c
>>>>> b/drivers/platform/x86/think-lmi.c
>>>>> index c816646eb661..ab17254781c4 100644
>>>>> --- a/drivers/platform/x86/think-lmi.c
>>>>> +++ b/drivers/platform/x86/think-lmi.c
>>>>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject
>>>>> *kobj, struct kobj_attribute *a
>>>>>
>>>>>          /* validate and split from `item,value` -> `value` */
>>>>>          value = strpbrk(item, ",");
>>>>> -       if (!value || value == item || !strlen(value + 1))
>>>>> +       if (!value || value == item || !strlen(value + 1)) {
>>>>> +               kfree(item);
>>>>>                  return -EINVAL;
>>>>> +       }
>>>>>
>>>>>          ret = sysfs_emit(buf, "%s\n", value + 1);
>>>>>          kfree(item);
>>>>> @@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting
>>>>> *tlmi_create_auth(const char *pwd_type,
>>>>>
>>>>>   static int tlmi_analyze(void)
>>>>>   {
>>>>> -       acpi_status status;
>>>>>          int i, ret;
>>>>>
>>>>>          if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
>>>>> @@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
>>>>>                  char *p;
>>>>>
>>>>>                  tlmi_priv.setting[i] = NULL;
>>>>> -               status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>>>> -               if (ACPI_FAILURE(status))
>>>>> +               ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>>>> +               if (ret)
>>>>
>>>> Really minor, but tweak to be this and save a line of code?
>>>
>>> This hunk is actually from another commit and should not be needed here.
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/platform/x86/think-lmi.c?id=da62908efe80f132f691efc2ace4ca67626de86b
>>
>> Thank you, Thomas,
>>
>> Indeed, my mistake.
>>
>> I have accepted Armin's suggestion to test if that patch closed the leak, and I
>> have just quoted it, never claiming authorship.
>>
>> I ought to apologise if I made confusion here.
>>
>> I was a bit euphoric about the leak being fixed, so forgive me for this blatant
>> mistake. Of course, putting it here would cause a patch collision, so it was a
>> stupid thing to do, and I would never do it in a formal patch submission ...
>>
>> Thanks, anyway for correction.
>>
>> Best regards,
>> Mirsad
>>
> 
> I have the patches ready to fix this issue - I just wanted to check that I wouldn't be stepping on anybodies toes or if there is a protocol for doing this.
>  - I will add Reported-by tag for Mirsad and Suggested-by for Armin.
>  - I've identified Fixes tags for the two commits that caused the issue.
> Let me know if there's anything else I should do - otherwise I'll get them sent out ASAP.

This sounds to me like you have covered all the bases.

Note Armin did send out a related fix earlier today,
which I guess is duplicate with one of your patches:

https://patchwork.kernel.org/project/platform-driver-x86/patch/20230331180912.38392-1-W_Armin@gmx.de/

So maybe add Armin's patch on top of pdx86/fixes and
use that as a base for your series (dropping your
likely duplicate patch) ?

Regards,

Hans

