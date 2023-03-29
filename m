Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62EE6CEFAA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjC2Qnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC2Qn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:43:29 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB2C46AC;
        Wed, 29 Mar 2023 09:43:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0B164604EF;
        Wed, 29 Mar 2023 18:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680108206; bh=XAfqU+2ECVlLAnB9ptFM/m0416xktbuZ+dEHC1VmtNA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=2BBnESqw6fzJGuoFXTF+z009y0itELitbJXOT768NxiBWrVNhdCpfO+EeRTSNZriY
         AC+vtp3oNy9eUVVF5nVPbZDz1tk1lLSSI4+YTYySNom82JdURH2CK6HASxQdYRywNA
         +bkAkpydjgkLuX6EWVWmGBPumwKg+RBfbJ5RcuFf6Xlz+oYdrcHMAuSCXkljluQiEd
         BcpaZ1bfb8CQCfKTNzMaQnAIcwNNwTjGHo+5xlrC+2JNH8EdFCpcP8PAumgVJ4CJGA
         mDYqtOxR+h0jrYae2cLGHHeeTqUxK8dv4n7vJ4AqCm+Y8lwQ1C1dm5pzG0+Wsqlql2
         uEeIsGACr0L0Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1RfS9nBdcp0P; Wed, 29 Mar 2023 18:43:23 +0200 (CEST)
Received: from [10.0.1.78] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 250A1604EA;
        Wed, 29 Mar 2023 18:43:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680108203; bh=XAfqU+2ECVlLAnB9ptFM/m0416xktbuZ+dEHC1VmtNA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ia96eRbQODgmaZjUdjsvmZLSG76V3a5G0MUqRW1OjBrbPLzkrp/P3DfHk8HsxilIN
         FrEz2sYD1fomh4ZlyB8fBKPjnLIaHeONunT8eqygGaUUL95tdYHS7/pilSRcGPgyQk
         jtNRoVbjgJwBHpew2awpMOVQUuVjGozwX7QUQ0/6WUP0HdE4U4AI1KEH7a3etEjgKb
         MB7mlSxPPRTe/LH6CW1o5xA4Zh4eIHKBD129wP36g+pD2dOO0z14yGHSFnpLV2M5OY
         PxYetZpkmTa3eQn7aTvHvSYiXzUCqi60qWAe1z+14DmLydTQKChEMSVJ9ixRBLepvF
         Eha3VSXgbns8g==
Message-ID: <9fa34eb2-d119-9039-6db7-edfd0ee406f9@alu.unizg.hr>
Date:   Wed, 29 Mar 2023 18:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [BUG] [BISECTED] [CORRECTION] systemd-devd triggers kernel
 memleak apparently in drivers/core/dd.c: driver_register()
Content-Language: en-US
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
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <9c142ac2-9340-4a9b-8541-99f613772340@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.3.2023. 18:24, Mark Pearson wrote:
> Hi
> 
> On Wed, Mar 29, 2023, at 11:46 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 3/29/23 16:18, Mirsad Goran Todorovac wrote:
>>> On 29.3.2023. 15:35, Thomas Weißschuh wrote:
>>>>
>>>> Mar 29, 2023 08:31:31 Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>:
>>>>
> <snip>
>>>
>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>> index c816646eb661..e8c28f4f5a71 100644
>>> --- a/drivers/platform/x86/think-lmi.c
>>> +++ b/drivers/platform/x86/think-lmi.c
>>> @@ -1469,6 +1469,7 @@ static int tlmi_analyze(void)
>>>                                                          kstrndup(optstart, optend - optstart,
>>>                                                                          GFP_KERNEL);
>>>                                  }
>>> +                               kfree(item);
>>>                          }
>>>                  }
>>>                  /*
>>>
>>> You were 3 minutes faster ;-)
>>>
>>> The build with this patch is finished. Apparently, that was the culprit, for now
> <snip>
>>>
>>>
>>> So, the "tlmi_setting" memory leak appears to be fixed by this diff.
>>>
> My only concern here is it looks like I was dumb and used the variable name 'item' twice in the same function. I guess the compiler is smart enough to handle it but I'd like to change the name to make it clearer which 'item' is being freed in each context.
> 
> In that block I would change it to be:
> char *optitem, *optstart, *optend;
> and fix all the pieces in the block to then be correct too (with the needed free)
> 
>>> The next step is to add Armin-suggested patch:
>>>
>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>> index c816646eb661..1e77ecb0cba8 100644
>>> --- a/drivers/platform/x86/think-lmi.c
>>> +++ b/drivers/platform/x86/think-lmi.c
>>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>>>
>>>          /* validate and split from `item,value` -> `value` */
>>>          value = strpbrk(item, ",");
>>> -       if (!value || value == item || !strlen(value + 1))
>>> +       if (!value || value == item || !strlen(value + 1)) {
>>> +               kfree(item);
>>>                  return -EINVAL;
>>> +       }
>>>
>>>          ret = sysfs_emit(buf, "%s\n", value + 1);
>>>          kfree(item);
>>>
> This looks good to me - thank you!
> 
>>> and Thomas' correction for the return type of the tlmi_setting() function:
>>>
>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>> index 86b33b74519be..c924e9e4a6a5b 100644
>>> --- a/drivers/platform/x86/think-lmi.c
>>> +++ b/drivers/platform/x86/think-lmi.c
>>> @@ -1353,7 +1353,6 @@ static struct tlmi_pwd_setting *tlmi_create_auth(const char *pwd_type,
>>>
>>>   static int tlmi_analyze(void)
>>>   {
>>> -       acpi_status status;
>>>          int i, ret;
>>>
>>>          if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
>>> @@ -1390,8 +1389,8 @@ static int tlmi_analyze(void)
>>>                  char *p;
>>>
>>>                  tlmi_priv.setting[i] = NULL;
>>> -               status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>> -               if (ACPI_FAILURE(status))
>>> +               ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>> +               if (ret)
>>>                          break;
>>>                  if (!item)
>>>                          break;
>>>
>>> A build on top of 6.3-rc4+ fcd476ea6a88 commit is on the way, with all three included.
>>
>> Good work on catching these issues, thank you all for your work on this.
>>
> Seconded - thank you for flagging and catching this. These were my mistakes :(

Armin's hint was the largest part of the catch. I did not even suspect think-lmi.c,
to be honest ...

Apparently, the three patches together do not raise any new issues on my box, but of
course, proper testing and peer review is required.

Best regards,
Mirsad

>> I assume that these fixes will be posted as a proper 3 patch
>> patch-series (one patch per fix) once you are done testing?
>>
> Let me know if you are happy to propose the changes as a patch-series. If you don't have time I can help and get these in ASAP as I was the original culprit.
> 
> Happy to help out with testing too as I have access to HW. Let me know.
> 
> Mark

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

