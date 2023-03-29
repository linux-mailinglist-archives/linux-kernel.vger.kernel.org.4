Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24FA6CF597
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC2VvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjC2VvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:51:07 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976E7BD;
        Wed, 29 Mar 2023 14:51:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id AE007604EF;
        Wed, 29 Mar 2023 23:51:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680126661; bh=fEhti2hRUbbQ2jmFQVZNshQ0C0S+W7tYfFaN2uTUyZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T7qfQaz3GoCGc4H2z7sxnBwZ1ZpTRx7o29fiGJpd7i0PN17jsFSKLDYPoLPIOIIAK
         mNvlFRJ8TAdQMq63DgeVdEfJkJ2OZY0CNJxGVE+XH6p1vXpnBi2BYfD9tLoY9mObgB
         GzpoXCYrljL/32D+ZIK0qksLeE3nBwgRtOqB4OyTW5sq4l1S4h8JWj09cGnw8rXk1F
         pvcJXzmAD0lbZ621lBQvNLvlxO+mOHe1yrf++pypLnZ3TaquMtVLBcAVwNqE3WVtli
         m9lZbum75j6JcRtuLicw9o95j7UM/euAoY4GWFPxklbjzqE+MnaEHiMM3qC0OdVA6N
         RW9XEcadvIieA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gSYNoCsSHbyC; Wed, 29 Mar 2023 23:50:59 +0200 (CEST)
Received: from [192.168.1.3] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id 996CD604EA;
        Wed, 29 Mar 2023 23:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680126659; bh=fEhti2hRUbbQ2jmFQVZNshQ0C0S+W7tYfFaN2uTUyZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wKojQ9sx+Zzs/RNdTHTbP4bDNscteJZiyIPIawJir1btjleQTKjjEiZ3EdWTgVZZP
         G1JEcgdr4Pqufqc0yLgpKgbm/9ra8FTExNZFgG7Z8Z/oX/VRUwwIUoNdfiOpDMRmuo
         +liJiivpnikMZjoFuPrOq8SwWm7cXkgXJvQdDJSzJ88FT8slY+8aNsbOmXhOZ/58p3
         nzNOlLc7OszzhHRfY3sKkdAgHkSCuGedAytpnlY+wriUH5Z8baNyR1VT15kxEqkRv7
         8zi8EUIYKMRq3sIWtLJgZPbQ5VTW9vLWFL1qbTlRAJIr93zmchgdwboxP4cTbYe7wu
         XjOJruCgTH58A==
Message-ID: <b2d0461b-a32b-50e0-640d-9e789bb5da30@alu.unizg.hr>
Date:   Wed, 29 Mar 2023 23:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] [RFC] systemd-devd triggers kernel memleak apparently in
 drivers/core/dd.c: driver_register()
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
 <ZCLPaYGKHlFQGKYQ@kroah.com>
 <542c13f5-4cdd-7750-f10a-ef64bb7e8faa@alu.unizg.hr>
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
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <bccb52fa-e1c9-482c-a024-9a02179728b2@t-8ch.de>
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

On 29. 03. 2023. 21:21, Thomas Weißschuh wrote:
> 
> Mar 29, 2023 14:00:22 Mark Pearson <mpearson-lenovo@squebb.ca>:
> 
>> Thanks Mirsad
>>
>> On Wed, Mar 29, 2023, at 2:49 PM, Mirsad Goran Todorovac wrote:
>> <snip>
>>>
>>> Here is the patch proposal according to what Mark advised (using
>>> different name for optitem):
>>>
>>> diff --git a/drivers/platform/x86/think-lmi.c
>>> b/drivers/platform/x86/think-lmi.c
>>> index c816646eb661..ab17254781c4 100644
>>> --- a/drivers/platform/x86/think-lmi.c
>>> +++ b/drivers/platform/x86/think-lmi.c
>>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject
>>> *kobj, struct kobj_attribute *a
>>>
>>>          /* validate and split from `item,value` -> `value` */
>>>          value = strpbrk(item, ",");
>>> -       if (!value || value == item || !strlen(value + 1))
>>> +       if (!value || value == item || !strlen(value + 1)) {
>>> +               kfree(item);
>>>                  return -EINVAL;
>>> +       }
>>>
>>>          ret = sysfs_emit(buf, "%s\n", value + 1);
>>>          kfree(item);
>>> @@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting
>>> *tlmi_create_auth(const char *pwd_type,
>>>
>>>   static int tlmi_analyze(void)
>>>   {
>>> -       acpi_status status;
>>>          int i, ret;
>>>
>>>          if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
>>> @@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
>>>                  char *p;
>>>
>>>                  tlmi_priv.setting[i] = NULL;
>>> -               status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>> -               if (ACPI_FAILURE(status))
>>> +               ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>> +               if (ret)
>>
>> Really minor, but tweak to be this and save a line of code?
> 
> This hunk is actually from another commit and should not be needed here.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/platform/x86/think-lmi.c?id=da62908efe80f132f691efc2ace4ca67626de86b

Thank you, Thomas,

Indeed, my mistake.

I have accepted Armin's suggestion to test if that patch closed the leak, and I
have just quoted it, never claiming authorship.

I ought to apologise if I made confusion here.

I was a bit euphoric about the leak being fixed, so forgive me for this blatant
mistake. Of course, putting it here would cause a patch collision, so it was a
stupid thing to do, and I would never do it in a formal patch submission ...

Thanks, anyway for correction.

Best regards,
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

