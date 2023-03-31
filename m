Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58CC6D288A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjCaTNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjCaTNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:13:37 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC27523B67;
        Fri, 31 Mar 2023 12:13:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id BE2E560515;
        Fri, 31 Mar 2023 21:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680290010; bh=YVy5UrfBcqm7V19v/bxeo/073hQvPnZW2/E7cRzj4FQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lL5tvT7ZMlSO11FGNcW0bueGi3jLdBwTSD8qVtQJYMlcO7LzSZr9FXj37UjbtoVMX
         ki2jrvxfFivh5oAcQ60JiSk+q74QGqQOzTWmOTbjSEVw4LpLpkuQXvflnXsFbnzNJl
         UcnvFXxxOCSM2YQXBHk1O4bHReVvI0CbPh8Q/7ZOh3sKd4SOwUTHhHwZfBt+rXsRy8
         2ntZn4ZoGtt08KbZTXJ14rRzpa5Ee8sUN8pT1m0Lx6/8BZcVK8dA2BtyyyLfDt9hzw
         wWiyyOVEI+AxlGQxnGeIEU/a4KjMiTB+0B1DG44F7B81QsfBTtkJ2U2GjkEF2BWJ7n
         RZON/7ZnJQeFg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TJ3Bl9K1X53z; Fri, 31 Mar 2023 21:13:27 +0200 (CEST)
Received: from [192.168.1.4] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id A23CF60514;
        Fri, 31 Mar 2023 21:13:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680290007; bh=YVy5UrfBcqm7V19v/bxeo/073hQvPnZW2/E7cRzj4FQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ITRdxECnzdnTxIcSjcSZpI2gELoe5owt+XJeDquMdEpc3GCPufhlIIuDt4StpdAtb
         fu7uaP0s1hTVhReMuow0bN9SdlgbNpWgrLhn/cP2rgfrQ6OdJcx4+kqZqClhxc9giy
         Ychg1uAyQXgu5nb01oOIt3rZb9ybSpNT2soarKCxjy6HMajZgEssNfWPxY8DpPQeGg
         4cK4QaIR2ZqQN0X+ib+0CSq0XJhrssN9avXFb39mlmM8txD8+PM1Nw1rmxxpwMRqQm
         5a5ZgUjW18Gvs+vhQtA0zZg1sIKStfIMwC028F1teisfNqQWS4SYs6jJW6KGmYG+iL
         vGfiEp+kne5rQ==
Message-ID: <9310d196-2463-ba6b-dad3-3b688adee0a8@alu.unizg.hr>
Date:   Fri, 31 Mar 2023 21:13:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] [RFC] systemd-devd triggers kernel memleak apparently in
 drivers/core/dd.c: driver_register()
Content-Language: en-US, hr
To:     Mark Pearson <mpearson-lenovo@squebb.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Armin Wolf <W_Armin@gmx.de>, Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
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
 <d1750883-3eba-c824-3f89-9568345709b8@redhat.com>
 <a1896b4a-1843-4946-ab6f-63132a03e009@app.fastmail.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <a1896b4a-1843-4946-ab6f-63132a03e009@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 03. 2023. 21:10, Mark Pearson wrote:
> 
> 
> On Fri, Mar 31, 2023, at 3:04 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 3/31/23 20:54, Mark Pearson wrote:
>>> Hi all,
>>>
>>> On Wed, Mar 29, 2023, at 5:50 PM, Mirsad Goran Todorovac wrote:
>>>> On 29. 03. 2023. 21:21, Thomas Weißschuh wrote:
>>>>>
>>>>> Mar 29, 2023 14:00:22 Mark Pearson <mpearson-lenovo@squebb.ca>:
>>>>>
>>>>>> Thanks Mirsad
>>>>>>
>>>>>> On Wed, Mar 29, 2023, at 2:49 PM, Mirsad Goran Todorovac wrote:
>>>>>> <snip>
>>>>>>>
>>>>>>> Here is the patch proposal according to what Mark advised (using
>>>>>>> different name for optitem):
>>>>>>>
>>>>>>> diff --git a/drivers/platform/x86/think-lmi.c
>>>>>>> b/drivers/platform/x86/think-lmi.c
>>>>>>> index c816646eb661..ab17254781c4 100644
>>>>>>> --- a/drivers/platform/x86/think-lmi.c
>>>>>>> +++ b/drivers/platform/x86/think-lmi.c
>>>>>>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject
>>>>>>> *kobj, struct kobj_attribute *a
>>>>>>>
>>>>>>>          /* validate and split from `item,value` -> `value` */
>>>>>>>          value = strpbrk(item, ",");
>>>>>>> -       if (!value || value == item || !strlen(value + 1))
>>>>>>> +       if (!value || value == item || !strlen(value + 1)) {
>>>>>>> +               kfree(item);
>>>>>>>                  return -EINVAL;
>>>>>>> +       }
>>>>>>>
>>>>>>>          ret = sysfs_emit(buf, "%s\n", value + 1);
>>>>>>>          kfree(item);
>>>>>>> @@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting
>>>>>>> *tlmi_create_auth(const char *pwd_type,
>>>>>>>
>>>>>>>   static int tlmi_analyze(void)
>>>>>>>   {
>>>>>>> -       acpi_status status;
>>>>>>>          int i, ret;
>>>>>>>
>>>>>>>          if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
>>>>>>> @@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
>>>>>>>                  char *p;
>>>>>>>
>>>>>>>                  tlmi_priv.setting[i] = NULL;
>>>>>>> -               status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>>>>>> -               if (ACPI_FAILURE(status))
>>>>>>> +               ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>>>>>> +               if (ret)
>>>>>>
>>>>>> Really minor, but tweak to be this and save a line of code?
>>>>>
>>>>> This hunk is actually from another commit and should not be needed here.
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/platform/x86/think-lmi.c?id=da62908efe80f132f691efc2ace4ca67626de86b
>>>>
>>>> Thank you, Thomas,
>>>>
>>>> Indeed, my mistake.
>>>>
>>>> I have accepted Armin's suggestion to test if that patch closed the leak, and I
>>>> have just quoted it, never claiming authorship.
>>>>
>>>> I ought to apologise if I made confusion here.
>>>>
>>>> I was a bit euphoric about the leak being fixed, so forgive me for this blatant
>>>> mistake. Of course, putting it here would cause a patch collision, so it was a
>>>> stupid thing to do, and I would never do it in a formal patch submission ...
>>>>
>>>> Thanks, anyway for correction.
>>>>
>>>> Best regards,
>>>> Mirsad
>>>>
>>>
>>> I have the patches ready to fix this issue - I just wanted to check that I wouldn't be stepping on anybodies toes or if there is a protocol for doing this.
>>>  - I will add Reported-by tag for Mirsad and Suggested-by for Armin.
>>>  - I've identified Fixes tags for the two commits that caused the issue.
>>> Let me know if there's anything else I should do - otherwise I'll get them sent out ASAP.
>>
>> This sounds to me like you have covered all the bases.
>>
>> Note Armin did send out a related fix earlier today,
>> which I guess is duplicate with one of your patches:
>>
>> https://patchwork.kernel.org/project/platform-driver-x86/patch/20230331180912.38392-1-W_Armin@gmx.de/
>>
>> So maybe add Armin's patch on top of pdx86/fixes and
>> use that as a base for your series (dropping your
>> likely duplicate patch) ?
>>
> Makes sense - will do
> Thanks!
> Mark

Hi, Mark,

You might find it convenient to test the patches in my initial environment that triggered
the bug. Otherwise, it is fine with me.

Regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

