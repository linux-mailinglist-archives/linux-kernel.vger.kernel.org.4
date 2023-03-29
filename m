Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB286CEF52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjC2Q1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjC2Q1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:27:45 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061661AC;
        Wed, 29 Mar 2023 09:27:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 26790604EF;
        Wed, 29 Mar 2023 18:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680107255; bh=FA1Sp9XFFJV8m71ey1XTi5F9pz278WSZ6c/cgDO+iNQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sroboDFef95RRqHKtwPCma74z1tY1mK1osA6KAwwNKlBm4j71ACpjckBbHRiX1vk0
         Py2D/YuieBn8QwanHvp/mRlBKhAE9a+CU6+7Hq819fQrzdKVVCQWtjfFobnFy1s40g
         TlU4INLPTnd3840C0a5IwuCVKVZ1v49uLJvNgZI8mWexix9tIJdtj0nYuNWsg4PmSq
         4g1UXgDZquzGgWxRZMBxbdcUTg7RZQJSIk5VPAEeMt0eAqXSXQinC9jMgWn/8U/vTz
         ekyuGvS2VkF8DbfrtyywP+jC3KwGBx50S+ZHMKqCp755ZnJQ7LJMLloD/8G0eGOz0y
         musv0UKTD/H9Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8x-Kd1HQ5kEF; Wed, 29 Mar 2023 18:27:32 +0200 (CEST)
Received: from [10.0.1.78] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 1A705604EA;
        Wed, 29 Mar 2023 18:27:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680107252; bh=FA1Sp9XFFJV8m71ey1XTi5F9pz278WSZ6c/cgDO+iNQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZMPa+ki1D3G3D6yAOR+vDdV97ueVvNPE/Ewuoc+EpopFIc+27V3teKq4aZm0xcTxJ
         Qc4f4ZgBGFl1qUEGdSbpPicXEQ1pRCc7zOqewCUJ04JLy9bJxQQQ4YKRMsPlpwp/6g
         +DFMdGuYQ9Ug5AsxR46lY1QKMalMoKMyFfbtugNQFHxabjHaUBm4tbvHWll6JQ9Sq6
         zi5qBXLm1KVZ/GNMpJbX1atcKmm5YVkImx3WFjlNgrT8Zaq2JhDXXRe/lL22ccLySz
         HVO9KFtwoz6sTCOVOQUIaANdzOAsMNSkodj+n6kYY6LJc8gCdI90BSUtGAdZYlHQx3
         WSTxhJ0sDNzOw==
Message-ID: <c8316d69-1aa4-f911-8074-11193d9f1a7c@alu.unizg.hr>
Date:   Wed, 29 Mar 2023 18:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [BUG] [BISECTED] [CORRECTION] systemd-devd triggers kernel
 memleak apparently in drivers/core/dd.c: driver_register()
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Armin Wolf <W_Armin@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mark Pearson <mpearson-lenovo@squebb.ca>
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
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2c1d0b9b-0e71-b616-6486-52e741d25afb@redhat.com>
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

On 29.3.2023. 17:46, Hans de Goede wrote:

>> So, the "tlmi_setting" memory leak appears to be fixed by this diff.
>>
>> The next step is to add Armin-suggested patch:
>>
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>> index c816646eb661..1e77ecb0cba8 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>>
>>          /* validate and split from `item,value` -> `value` */
>>          value = strpbrk(item, ",");
>> -       if (!value || value == item || !strlen(value + 1))
>> +       if (!value || value == item || !strlen(value + 1)) {
>> +               kfree(item);
>>                  return -EINVAL;
>> +       }
>>
>>          ret = sysfs_emit(buf, "%s\n", value + 1);
>>          kfree(item);
>>
>> and Thomas' correction for the return type of the tlmi_setting() function:
>>
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>> index 86b33b74519be..c924e9e4a6a5b 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -1353,7 +1353,6 @@ static struct tlmi_pwd_setting *tlmi_create_auth(const char *pwd_type,
>>
>>   static int tlmi_analyze(void)
>>   {
>> -       acpi_status status;
>>          int i, ret;
>>
>>          if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
>> @@ -1390,8 +1389,8 @@ static int tlmi_analyze(void)
>>                  char *p;
>>
>>                  tlmi_priv.setting[i] = NULL;
>> -               status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>> -               if (ACPI_FAILURE(status))
>> +               ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>> +               if (ret)
>>                          break;
>>                  if (!item)
>>                          break;
>>
>> A build on top of 6.3-rc4+ fcd476ea6a88 commit is on the way, with all three included.
> 
> Good work on catching these issues, thank you all for your work on this.

Not at all. It was a very interesting problem and a great session of brainstorming with
Greg, Armin and Thomas.

> I assume that these fixes will be posted as a proper 3 patch
> patch-series (one patch per fix) once you are done testing?

This is for others to decide. Armin gave a great hint with the one patch, and I sort of
had a race condition of the one with Thomas that was the final fix ;-)

The tlmi_setting return value fix by Thomas is already committed to the for-next tree,
I got it from there.

I do not have any authorship pretensions, this was a collaboration, so I don't know what
is due in the Code of Conduct for such circumstances. I trust you guys will do the right thing.

The 6.3.0-rc4-00034-gfcd476ea6a88 kernel apparently has a stackdump:

  WARNING: CPU: 4 PID: 746 at drivers/thermal/thermal_sysfs.c:879 cooling_device_stats_setup+0xb4/0xc0

but with our without the patch, and it apparently isn't related.

Best regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

