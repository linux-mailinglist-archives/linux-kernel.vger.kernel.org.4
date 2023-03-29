Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710A56CED3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjC2Pq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjC2Pqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6976C2108
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680104767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i57EZDM4t+iV84PvhjXPUXnseWI25y0hAnwsmocDh/0=;
        b=TZPq/ARahsruRJJQpOCreKg8Lh9LqntTf+pjHZR79OXtCZlWC5YUje3UzFUj10VoUvfZs6
        rBsHhcl267tsuY3kvwI4dAKIaqzSPH+GZUrQeXVQyAD6Q24cYaC6RjS0tHqiYwF49LeA8h
        7GzPqRPEvkNzz/noLp3X/4uhSUozT60=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-q2Um3M3nPEyVRLGQ94jRpA-1; Wed, 29 Mar 2023 11:46:06 -0400
X-MC-Unique: q2Um3M3nPEyVRLGQ94jRpA-1
Received: by mail-ed1-f72.google.com with SMTP id a40-20020a509eab000000b005024c025bf4so10634369edf.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i57EZDM4t+iV84PvhjXPUXnseWI25y0hAnwsmocDh/0=;
        b=LjVzy20oJSGko0Abwhfk9AmmIruk1HPYBL9+wrpTFqipWVP+bukLrU9Afy2ZrAtQVD
         rIBhSoswjf+sMf7IF3zv7VkTvO+cVvLuyUExuiIZI2u4D9qY9VN8GjsvseEEm0OxEVlX
         wu2luImAZzTmR9qKWWG+B84EGeYefMNwSHmxn2arZOlzep0QwyH0SSp9ObkxTrA4oal9
         egUSsi/lTO45+14TAx46wtDG7tuDSdmkOTyXaQCwJdOl0vj64sokFlWdhWu7PF8Zv6OY
         JU0+Z5lAFERHMfqkgOmGp9ikOmw89D3R+c05X0etYlCvafQ7/GfjcZMb7Z2B9nOOGOG4
         BghQ==
X-Gm-Message-State: AAQBX9fSzui8JHPzdjdX9A7F9FsnQ5eXxyRfgTKqL8x+k0ItZtUrosSe
        T0i+LHrOmH3uax4LNZ5vB1o9AhGQ9AzRb3qGCCBFmY3AsFaK3XSWmgMcXWrYF2+HR7QZr1bJZBy
        NPfSDztcWs33CLPkjvbGE4NYj
X-Received: by 2002:aa7:de02:0:b0:4fb:e9b8:ca5a with SMTP id h2-20020aa7de02000000b004fbe9b8ca5amr19702946edv.40.1680104762743;
        Wed, 29 Mar 2023 08:46:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350aS8i4uE5DEfWRh87N9YpzPCKBKgVasO+8mwXjTajJTSbXNrhA1UGO6wD9bf8isRSEkx/77xg==
X-Received: by 2002:aa7:de02:0:b0:4fb:e9b8:ca5a with SMTP id h2-20020aa7de02000000b004fbe9b8ca5amr19702924edv.40.1680104762288;
        Wed, 29 Mar 2023 08:46:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i28-20020a50871c000000b004fd204d180dsm17126883edb.64.2023.03.29.08.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:46:01 -0700 (PDT)
Message-ID: <2c1d0b9b-0e71-b616-6486-52e741d25afb@redhat.com>
Date:   Wed, 29 Mar 2023 17:46:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [BUG] [BISECTED] [CORRECTION] systemd-devd triggers kernel
 memleak apparently in drivers/core/dd.c: driver_register()
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
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
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6a5dc4de-b315-1e6d-e5e2-5b95521a37c7@alu.unizg.hr>
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

On 3/29/23 16:18, Mirsad Goran Todorovac wrote:
> On 29.3.2023. 15:35, Thomas Weißschuh wrote:
>>
>> Mar 29, 2023 08:31:31 Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>:
>>
>>> Hi, again,
>>>
>>> NOTE: I forgot to rewind to the first bad commit. So please ignore
>>> the previous email.
>>>
>>> On 29.3.2023. 15:22, Mirsad Goran Todorovac wrote:
>>>> Hi, Armin, Mr. Greg,
>>>> On 29.3.2023. 10:13, Mirsad Goran Todorovac wrote:
>>>>> On 28.3.2023. 21:55, Armin Wolf wrote:
>>>>>> Am 28.03.23 um 21:06 schrieb Mirsad Goran Todorovac:
>>>>>>
>>>>>>> On 3/28/2023 6:53 PM, Armin Wolf wrote:
>>>>>>>> …
>>>>>>>
>>>>>>> Hi Armin,
>>>>>>>
>>>>>>> I tried your suggestion, and though it is an obvious improvement and a
>>>>>>> leak fix, this
>>>>>>> was not the one we were searching for.
>>>>>>>
>>>>>>> I tested the following patch:
>>>>>>>
>>>>>>> diff --git a/drivers/platform/x86/think-lmi.c
>>>>>>> b/drivers/platform/x86/think-lmi.c
>>>>>>> index c816646eb661..1e77ecb0cba8 100644
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
>>>>>>>
>>>>>>> (I would also object to the use of strlen() here, for it is inherently
>>>>>>> insecure
>>>>>>> against SEGFAULT in kernel space.)
>>>>>>>
>>>>>>> I still get:
>>>>>>> [root@pc-mtodorov marvin]# uname -rms
>>>>>>> Linux 6.3.0-rc4-armin-patch-00025-g3a93e40326c8-dirty x86_64
>>>>>>> [root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak [edited]
>>>>>>> unreferenced object 0xffff8eb008ef9260 (size 96):
>>>>>>>    comm "systemd-udevd", pid 771, jiffies 4294896499 (age 74.880s)
>>>>>>>    hex dump (first 32 bytes):
>>>>>>>      53 65 72 69 61 6c 50 6f 72 74 31 41 64 64 72 65 SerialPort1Addre
>>>>>>>      73 73 2c 33 46 38 2f 49 52 51 34 3b 5b 4f 70 74 ss,3F8/IRQ4;[Opt
>>>>>>>    backtrace:
>>>>>>>      [<ffffffff9eafb26c>] slab_post_alloc_hook+0x8c/0x3e0
>>>>>>>      [<ffffffff9eb02b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>>>>>>      [<ffffffff9ea773c9>] __kmalloc_node_track_caller+0x59/0x180
>>>>>>>      [<ffffffff9ea66a1a>] kstrdup+0x3a/0x70
>>>>>>>      [<ffffffffc0eef9aa>] tlmi_extract_output_string.isra.0+0x2a/0x60
>>>>>>> [think_lmi]
>>>>>>>      [<ffffffffc0eefb64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
>>>>>>>      [<ffffffffc0ef02c1>] tlmi_probe+0x591/0xba0 [think_lmi]
>>>>>>>      [<ffffffffc0629c53>] wmi_dev_probe+0x163/0x230 [wmi]
>>>>>>>      [<ffffffff9f1987eb>] really_probe+0x17b/0x3d0
>>>>>>>      [<ffffffff9f198ad4>] __driver_probe_device+0x84/0x190
>>>>>>>      [<ffffffff9f198c14>] driver_probe_device+0x24/0xc0
>>>>>>>      [<ffffffff9f198ed2>] __driver_attach+0xc2/0x190
>>>>>>>      [<ffffffff9f195ab1>] bus_for_each_dev+0x81/0xd0
>>>>>>>      [<ffffffff9f197c62>] driver_attach+0x22/0x30
>>>>>>>      [<ffffffff9f197354>] bus_add_driver+0x1b4/0x240
>>>>>>>      [<ffffffff9f19a0a2>] driver_register+0x62/0x120
>>>>>>> unreferenced object 0xffff8eb018ddbb40 (size 64):
>>>>>>>    comm "systemd-udevd", pid 771, jiffies 4294896528 (age 74.780s)
>>>>>>>    hex dump (first 32 bytes):
>>>>>>>      55 53 42 50 6f 72 74 41 63 63 65 73 73 2c 45 6e USBPortAccess,En
>>>>>>>      61 62 6c 65 64 3b 5b 4f 70 74 69 6f 6e 61 6c 3a abled;[Optional:
>>>>>>>    backtrace:
>>>>>>>      [<ffffffff9eafb26c>] slab_post_alloc_hook+0x8c/0x3e0
>>>>>>>      [<ffffffff9eb02b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>>>>>>      [<ffffffff9ea773c9>] __kmalloc_node_track_caller+0x59/0x180
>>>>>>>      [<ffffffff9ea66a1a>] kstrdup+0x3a/0x70
>>>>>>>      [<ffffffffc0eef9aa>] tlmi_extract_output_string.isra.0+0x2a/0x60
>>>>>>> [think_lmi]
>>>>>>>      [<ffffffffc0eefb64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
>>>>>>>      [<ffffffffc0ef02c1>] tlmi_probe+0x591/0xba0 [think_lmi]
>>>>>>>      [<ffffffffc0629c53>] wmi_dev_probe+0x163/0x230 [wmi]
>>>>>>>      [<ffffffff9f1987eb>] really_probe+0x17b/0x3d0
>>>>>>>      [<ffffffff9f198ad4>] __driver_probe_device+0x84/0x190
>>>>>>>      [<ffffffff9f198c14>] driver_probe_device+0x24/0xc0
>>>>>>>      [<ffffffff9f198ed2>] __driver_attach+0xc2/0x190
>>>>>>>      [<ffffffff9f195ab1>] bus_for_each_dev+0x81/0xd0
>>>>>>>      [<ffffffff9f197c62>] driver_attach+0x22/0x30
>>>>>>>      [<ffffffff9f197354>] bus_add_driver+0x1b4/0x240
>>>>>>>      [<ffffffff9f19a0a2>] driver_register+0x62/0x120
>>>>>>> unreferenced object 0xffff8eb006fe2b40 (size 64):
>>>>>>>    comm "systemd-udevd", pid 771, jiffies 4294896542 (age 74.724s)
>>>>>>>    hex dump (first 32 bytes):
>>>>>>>      55 53 42 42 49 4f 53 53 75 70 70 6f 72 74 2c 45 USBBIOSSupport,E
>>>>>>>      6e 61 62 6c 65 64 3b 5b 4f 70 74 69 6f 6e 61 6c nabled;[Optional
>>>>>>>    backtrace:
>>>>>>>      [<ffffffff9eafb26c>] slab_post_alloc_hook+0x8c/0x3e0
>>>>>>>      [<ffffffff9eb02b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>>>>>>      [<ffffffff9ea773c9>] __kmalloc_node_track_caller+0x59/0x180
>>>>>>>      [<ffffffff9ea66a1a>] kstrdup+0x3a/0x70
>>>>>>>      [<ffffffffc0eef9aa>] tlmi_extract_output_string.isra.0+0x2a/0x60
>>>>>>> [think_lmi]
>>>>>>>      [<ffffffffc0eefb64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
>>>>>>>      [<ffffffffc0ef02c1>] tlmi_probe+0x591/0xba0 [think_lmi]
>>>>>>>      [<ffffffffc0629c53>] wmi_dev_probe+0x163/0x230 [wmi]
>>>>>>>      [<ffffffff9f1987eb>] really_probe+0x17b/0x3d0
>>>>>>>      [<ffffffff9f198ad4>] __driver_probe_device+0x84/0x190
>>>>>>>      [<ffffffff9f198c14>] driver_probe_device+0x24/0xc0
>>>>>>>      [<ffffffff9f198ed2>] __driver_attach+0xc2/0x190
>>>>>>>      [<ffffffff9f195ab1>] bus_for_each_dev+0x81/0xd0
>>>>>>>      [<ffffffff9f197c62>] driver_attach+0x22/0x30
>>>>>>>      [<ffffffff9f197354>] bus_add_driver+0x1b4/0x240
>>>>>>>      [<ffffffff9f19a0a2>] driver_register+0x62/0x120
>>>>>>>
>>>>>>> There are currently 84 wmi_dev_probe leaks, sized mostly 64 bytes, and
>>>>>>> one 96 and two 192 bytes.
>>>>>>>
>>>>>>> I also cannot figure out the mechanism by which current_value_show()
>>>>>>> is called, when it is static?
>>>>>>>
>>>>>>> Any idea?
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Mirsad
>>>>>>>
>>>>>> Can you tell me how many BIOS settings think-lmi provides on your machine? Because according to the stacktrace,
>>>>>> the other place where the leak could have occurred is inside tlmi_analyze(), which calls tlmi_setting().
>>>>>
>>>>> Yes, Sir!
>>>>>
>>>>> I think these could be the ones you need (totaling 83, which is close to 82 systemd-udevd leaks):
>>>>>
>>>>> [root@pc-mtodorov marvin]# ls -l /sys/devices/virtual/firmware-attributes/thinklmi/attributes | grep ^d
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 AfterPowerLoss
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 AlarmDate(MM\DD\YYYY)
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 AlarmDayofWeek
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 AlarmTime(HH:MM:SS)
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 ASPMSupport
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 AutomaticBootSequence
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 BIOSPasswordAtBootDeviceList
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 BIOSPasswordAtReboot
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 BIOSPasswordAtUnattendedBoot
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 BootMode
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 BootPriority
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 BootUpNum-LockStatus
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 C1ESupport
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 CardReader
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 ClearTCGSecurityFeature
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 ComputraceModuleActivation
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 ConfigurationChangeDetection
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 ConfigureSATAas
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 CoreMulti-Processing
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 CoverTamperDetected
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 CSM
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 CStateSupport
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 DeviceGuard
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 DustShieldAlert
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 EISTSupport
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 EnhancedPowerSavingMode
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 ErrorBootSequence
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 Friday
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 FrontUSBPorts
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 HardDiskPre-delay
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 Intel(R)SGXControl
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 InternalSpeaker
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 Monday
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 OnboardAudioController
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 OnboardEthernetController
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 OptionKeysDisplay
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 OptionKeysDisplayStyle
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 OSOptimizedDefaults
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 PasswordCountExceededError
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 PCIe16xSlotSpeed
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 PCIe1xSlot1Speed
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 PrimaryBootSequence
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 PXEIPV4NetworkStack
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 PXEIPV6NetworkStack
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 PXEOptionROM
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 RearUSBPorts
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 RequireAdmin.Pass.whenFlashing
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 RequireHDPonSystemBoot
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 SATAController
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 SATADrive1
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 SATADrive2
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 Saturday
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 SecureBoot
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 SecureRollBackPrevention
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 SecurityChip
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 SelectActiveVideo
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 SerialPort1Address
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 SmartUSBProtection
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 StartupDeviceMenuPrompt
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 StartupSequence
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 Sunday
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 Thursday
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 Tuesday
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 TurboMode
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBBIOSSupport
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBEnumerationDelay
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBPort1
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBPort2
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBPort3
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBPort4
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBPort5
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBPort6
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBPort7
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBPort8
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 USBPortAccess
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 UserDefinedAlarmTime(HH:MM:SS)
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 VirtualizationTechnology
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 VTdFeature
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 WakefromSerialPortRing
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 WakeOnLAN
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 WakeUponAlarm
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 Wednesday
>>>>> drwxr-xr-x 2 root root    0 Mar 29 08:24 WindowsUEFIFirmwareUpdate
>>>>> [root@pc-mtodorov marvin]# ls -l /sys/devices/virtual/firmware-attributes/thinklmi/attributes | grep ^d | wc -l
>>>>> 83
>>>>> [root@pc-mtodorov marvin]#
>>>>>
>>>>>> However, i have no idea on how *info is somehow leaked, it has to happen inside the for-loop tween the call
>>>>>> to tlmi_setting() and strreplace(), because otherwise the strings would not contain the "/" character.
>>>>>
>>>>> I see. It is the line 1404.
>>>>>
>>>>>> Can you check if the problem is somehow solved by applying the following commit from the platform-drivers-x86
>>>>>> for-next branch:
>>>>>> da62908efe80 ("platform/x86: think-lmi: Properly interpret return value of tlmi_setting")
>>>>>
>>>>> It could possibly be that. But I do not recall seeing these messages in 6.3-rc3 ...
>>>>>
>>>>> ...
>>>>>
>>>>> Unfortunately, the build with Thomas' patch you referred to did not work:
>>>>>
>>>>> unreferenced object 0xffff9dff4d28bbc8 (size 192):
>>>>>     comm "systemd-udevd", pid 769, jiffies 4294897473 (age 85.700s)
>>>>>     hex dump (first 32 bytes):
>>>>>       50 72 69 6d 61 72 79 42 6f 6f 74 53 65 71 75 65  PrimaryBootSeque
>>>>>       6e 63 65 2c 4d 2e 32 20 44 72 69 76 65 20 31 3a  nce,M.2 Drive 1:
>>>>>     backtrace:
>>>>>       [<ffffffffa48fb26c>] slab_post_alloc_hook+0x8c/0x3e0
>>>>>       [<ffffffffa4902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>>>>       [<ffffffffa48773c9>] __kmalloc_node_track_caller+0x59/0x180
>>>>>       [<ffffffffa4866a1a>] kstrdup+0x3a/0x70
>>>>>       [<ffffffffc0c7f9aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
>>>>>       [<ffffffffc0c7fb64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
>>>>>       [<ffffffffc0c802c1>] tlmi_probe+0x591/0xba0 [think_lmi]
>>>>>       [<ffffffffc03c9c53>] wmi_dev_probe+0x163/0x230 [wmi]
>>>>>       [<ffffffffa4f987eb>] really_probe+0x17b/0x3d0
>>>>>       [<ffffffffa4f98ad4>] __driver_probe_device+0x84/0x190
>>>>>       [<ffffffffa4f98c14>] driver_probe_device+0x24/0xc0
>>>>>       [<ffffffffa4f98ed2>] __driver_attach+0xc2/0x190
>>>>>       [<ffffffffa4f95ab1>] bus_for_each_dev+0x81/0xd0
>>>>>       [<ffffffffa4f97c62>] driver_attach+0x22/0x30
>>>>>       [<ffffffffa4f97354>] bus_add_driver+0x1b4/0x240
>>>>>       [<ffffffffa4f9a0a2>] driver_register+0x62/0x120
>>>>> unreferenced object 0xffff9dff4d28a008 (size 192):
>>>>>     comm "systemd-udevd", pid 769, jiffies 4294897517 (age 85.540s)
>>>>>     hex dump (first 32 bytes):
>>>>>       45 72 72 6f 72 42 6f 6f 74 53 65 71 75 65 6e 63  ErrorBootSequenc
>>>>>       65 2c 4e 65 74 77 6f 72 6b 20 31 3a 4d 2e 32 20  e,Network 1:M.2
>>>>>     backtrace:
>>>>>       [<ffffffffa48fb26c>] slab_post_alloc_hook+0x8c/0x3e0
>>>>>       [<ffffffffa4902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>>>>       [<ffffffffa48773c9>] __kmalloc_node_track_caller+0x59/0x180
>>>>>       [<ffffffffa4866a1a>] kstrdup+0x3a/0x70
>>>>>       [<ffffffffc0c7f9aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
>>>>>       [<ffffffffc0c7fb64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
>>>>>       [<ffffffffc0c802c1>] tlmi_probe+0x591/0xba0 [think_lmi]
>>>>>       [<ffffffffc03c9c53>] wmi_dev_probe+0x163/0x230 [wmi]
>>>>>       [<ffffffffa4f987eb>] really_probe+0x17b/0x3d0
>>>>>       [<ffffffffa4f98ad4>] __driver_probe_device+0x84/0x190
>>>>>       [<ffffffffa4f98c14>] driver_probe_device+0x24/0xc0
>>>>>       [<ffffffffa4f98ed2>] __driver_attach+0xc2/0x190
>>>>>       [<ffffffffa4f95ab1>] bus_for_each_dev+0x81/0xd0
>>>>>       [<ffffffffa4f97c62>] driver_attach+0x22/0x30
>>>>>       [<ffffffffa4f97354>] bus_add_driver+0x1b4/0x240
>>>>>       [<ffffffffa4f9a0a2>] driver_register+0x62/0x120
>>>>> [root@pc-mtodorov marvin]# uname -rms
>>>>> Linux 6.3.0-rc4-armin+tw-patch-00025-g3a93e40326c8-dirty x86_64
>>>>> [root@pc-mtodorov marvin]#
>>>>>
>>>>> What was applied is:
>>>>>
>>>>> mtodorov@domac:~/linux/kernel/linux_torvalds$ git diff
>>>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>>>> index c816646eb661..9a3015f43aaf 100644
>>>>> --- a/drivers/platform/x86/think-lmi.c
>>>>> +++ b/drivers/platform/x86/think-lmi.c
>>>>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>>>>>
>>>>>           /* validate and split from `item,value` -> `value` */
>>>>>           value = strpbrk(item, ",");
>>>>> -       if (!value || value == item || !strlen(value + 1))
>>>>> +       if (!value || value == item || !strlen(value + 1)) {
>>>>> +               kfree(item);
>>>>>                   return -EINVAL;
>>>>> +       }
>>>>>
>>>>>           ret = sysfs_emit(buf, "%s\n", value + 1);
>>>>>           kfree(item);
>>>>> @@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting *tlmi_create_auth(const char *pwd_type,
>>>>>
>>>>>    static int tlmi_analyze(void)
>>>>>    {
>>>>> -       acpi_status status;
>>>>>           int i, ret;
>>>>>
>>>>>           if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
>>>>> @@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
>>>>>                   char *p;
>>>>>
>>>>>                   tlmi_priv.setting[i] = NULL;
>>>>> -               status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>>>> -               if (ACPI_FAILURE(status))
>>>>> +               ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>>>> +               if (ret)
>>>>>                           break;
>>>>>                   if (!item)
>>>>>                           break;
>>>>>
>>>>>
>>>>>> Also current_value_show() is used by attr_current_val, the __ATTR_RW_MODE() macro arranges for that.
>>>>>
>>>>> Thanks.
>>>>>
>>>>> In this build:
>>>>>
>>>>> [root@pc-mtodorov marvin]# uname -rms
>>>>> Linux 6.3.0-rc34tests-00001-g6981739a967c x86_64
>>>>> [root@pc-mtodorov marvin]#
>>>>>
>>>>> ... the bug isn't present, so it might be something added recently:
>>>>>
>>>>> commit 8a02d70679fc1c434401863333c8ea7dbf201494
>>>>> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>>> Date:   Sun Mar 19 20:32:21 2023 -0400
>>>>>
>>>>>       platform/x86: think-lmi: Add possible_values for ThinkStation
>>>>>
>>>>> commit cf337f27f3bfc4aeab4954c468239fd6233c7638
>>>>> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>>> Date:   Sun Mar 19 20:32:20 2023 -0400
>>>>>
>>>>>       platform/x86: think-lmi: only display possible_values if available
>>>>>
>>>>> commit 45e21289bfc6e257885514790a8a8887da822d40
>>>>> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>>> Date:   Sun Mar 19 20:32:19 2023 -0400
>>>>>
>>>>>       platform/x86: think-lmi: use correct possible_values delimiters
>>>>>
>>>>> commit 583329dcf22e568a328a944f20427ccfc95dce01
>>>>> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>>> Date:   Sun Mar 19 20:32:18 2023 -0400
>>>>>
>>>>>       platform/x86: think-lmi: add missing type attribute
>>>>>
>>>>> I have CC:-ed the author of the commits.
>>>>>
>>>>> I can try bisect, but only after my day job.
>>>> I seem to have been right about the culprit commit.
>>>> Here is the bisect log:
>>>> mtodorov@domac:~/linux/kernel/linux_torvalds$ git bisect log
>>>> git bisect start '--' './drivers/platform/x86'
>>>> # good: [caa0708a81d6a2217c942959ef40d515ec1d3108] bootconfig: Change message if no bootconfig with CONFIG_BOOT_CONFIG_FORCE=y
>>>> git bisect good caa0708a81d6a2217c942959ef40d515ec1d3108
>>>> # bad: [8a02d70679fc1c434401863333c8ea7dbf201494] platform/x86: think-lmi: Add possible_values for ThinkStation
>>>> git bisect bad 8a02d70679fc1c434401863333c8ea7dbf201494
>>>> # good: [1a0009abfa7893b9cfcd3884658af1cbee6b26ce] platform: mellanox: mlx-platform: Initialize shift variable to 0
>>>> git bisect good 1a0009abfa7893b9cfcd3884658af1cbee6b26ce
>>>> # good: [b7c994f8c35e916e27c60803bb21457bc1373500] platform/x86 (gigabyte-wmi): Add support for A320M-S2H V2
>>>> git bisect good b7c994f8c35e916e27c60803bb21457bc1373500
>>>> # good: [45e21289bfc6e257885514790a8a8887da822d40] platform/x86: think-lmi: use correct possible_values delimiters
>>>> git bisect good 45e21289bfc6e257885514790a8a8887da822d40
>>>> # good: [cf337f27f3bfc4aeab4954c468239fd6233c7638] platform/x86: think-lmi: only display possible_values if available
>>>> git bisect good cf337f27f3bfc4aeab4954c468239fd6233c7638
>>>> # first bad commit: [8a02d70679fc1c434401863333c8ea7dbf201494] platform/x86: think-lmi: Add possible_values for ThinkStation
>>>> mtodorov@domac:~/linux/kernel/linux_torvalds$
>>>> Please see below.
>>>> Apparently, this commit broke something on my Lenovo box:
>>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>>> index e190fec26021..3f0641360251 100644
>>>> --- a/drivers/platform/x86/think-lmi.c
>>>> +++ b/drivers/platform/x86/think-lmi.c
>>>> @@ -941,9 +941,6 @@ static ssize_t possible_values_show(struct kobject *kobj, struct kobj_attribute
>>>>   {
>>>>          struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
>>>> -       if (!tlmi_priv.can_get_bios_selections)
>>>> -               return -EOPNOTSUPP;
>>>> -
>>>>          return sysfs_emit(buf, "%s\n", setting->possible_values);
>>>>   }
>>>> @@ -1052,6 +1049,18 @@ static struct kobj_attribute attr_current_val = __ATTR_RW_MODE(current_value, 06
>>>>   static struct kobj_attribute attr_type = __ATTR_RO(type);
>>>> +static umode_t attr_is_visible(struct kobject *kobj,
>>>> +                                            struct attribute *attr, int n)
>>>> +{
>>>> +       struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
>>>> +
>>>> +       /* We don't want to display possible_values attributes if not available */
>>>> +       if ((attr == &attr_possible_values.attr) && (!setting->possible_values))
>>>> +               return 0;
>>>> +
>>>> +       return attr->mode;
>>>> +}
>>>> +
>>>>   static struct attribute *tlmi_attrs[] = {
>>>>          &attr_displ_name.attr,
>>>>          &attr_current_val.attr,
>>>> @@ -1061,6 +1070,7 @@ static struct attribute *tlmi_attrs[] = {
>>>>   };
>>>>   static const struct attribute_group tlmi_attr_group = {
>>>> +       .is_visible = attr_is_visible,
>>>>          .attrs = tlmi_attrs,
>>>>   };
>>>> Hope this helps narrow down the problem.
>>>> Best regards,
>>>> Mirsad
>>>> Why aren't you looking at the wmi.c driver?  That should be
>>>>>>>> …
>>>
>>> mtodorov@domac:~/linux/kernel/linux_torvalds$ git bisect log
>>> git bisect start '--' './drivers/platform/x86'
>>> # good: [caa0708a81d6a2217c942959ef40d515ec1d3108] bootconfig: Change message if no bootconfig with CONFIG_BOOT_CONFIG_FORCE=y
>>> git bisect good caa0708a81d6a2217c942959ef40d515ec1d3108
>>> # bad: [8a02d70679fc1c434401863333c8ea7dbf201494] platform/x86: think-lmi: Add possible_values for ThinkStation
>>> git bisect bad 8a02d70679fc1c434401863333c8ea7dbf201494
>>> # good: [1a0009abfa7893b9cfcd3884658af1cbee6b26ce] platform: mellanox: mlx-platform: Initialize shift variable to 0
>>> git bisect good 1a0009abfa7893b9cfcd3884658af1cbee6b26ce
>>> # good: [b7c994f8c35e916e27c60803bb21457bc1373500] platform/x86 (gigabyte-wmi): Add support for A320M-S2H V2
>>> git bisect good b7c994f8c35e916e27c60803bb21457bc1373500
>>> # good: [45e21289bfc6e257885514790a8a8887da822d40] platform/x86: think-lmi: use correct possible_values delimiters
>>> git bisect good 45e21289bfc6e257885514790a8a8887da822d40
>>> # good: [cf337f27f3bfc4aeab4954c468239fd6233c7638] platform/x86: think-lmi: only display possible_values if available
>>> git bisect good cf337f27f3bfc4aeab4954c468239fd6233c7638
>>> # first bad commit: [8a02d70679fc1c434401863333c8ea7dbf201494] platform/x86: think-lmi: Add possible_values for ThinkStation
>>> mtodorov@domac:~/linux/kernel/linux_torvalds$
>>>
>>> So the commit that triggered the bug on the Lenovo desktop box was:
>>>
>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>> index 3f0641360251..c816646eb661 100644
>>> --- a/drivers/platform/x86/think-lmi.c
>>> +++ b/drivers/platform/x86/think-lmi.c
>>> @@ -1450,6 +1450,26 @@ static int tlmi_analyze(void)
>>>                           if (ret || !setting->possible_values)
>>>                                   pr_info("Error retrieving possible values for %d : %s\n",
>>>                                                   i, setting->display_name);
>>> +               } else {
>>> +                       /*
>>> +                        * Older Thinkstations don't support the bios_selections API.
>>> +                        * Instead they store this as a [Optional:Option1,Option2] section of the
>>> +                        * name string.
>>> +                        * Try and pull that out if it's available.
>>> +                        */
>>> +                       char *item, *optstart, *optend;
>>> +
>>> +                       if (!tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID)) {
>>> +                               optstart = strstr(item, "[Optional:");
>>> +                               if (optstart) {
>>> +                                       optstart += strlen("[Optional:");
>>> +                                       optend = strstr(optstart, "]");
>>> +                                       if (optend)
>>> +                                               setting->possible_values =
>>> +                                                       kstrndup(optstart, optend - optstart,
>>> +                                                                       GFP_KERNEL);
>>
>> I guess item needs to be freed here.
>>
>> (Next week I have access to my Lenovo machine again.
>> I'll look at it then if it's not solved.)
> 
> Yes, thank you, Thomas, I am just building with the following patch:
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index c816646eb661..e8c28f4f5a71 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1469,6 +1469,7 @@ static int tlmi_analyze(void)
>                                                         kstrndup(optstart, optend - optstart,
>                                                                         GFP_KERNEL);
>                                 }
> +                               kfree(item);
>                         }
>                 }
>                 /*
> 
> You were 3 minutes faster ;-)
> 
> The build with this patch is finished. Apparently, that was the culprit, for now
> I get:
> 
> [root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8fa859c89f10 (size 16):
>   comm "kworker/u12:5", pid 369, jiffies 4294897651 (age 91.724s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 cc cc cc cc cc cc  memstick0.......
>   backtrace:
>     [<ffffffff8ef0a8fc>] slab_post_alloc_hook+0x8c/0x3e0
>     [<ffffffff8ef12289>] __kmem_cache_alloc_node+0x1d9/0x2a0
>     [<ffffffff8ee85719>] __kmalloc_node_track_caller+0x59/0x1f0
>     [<ffffffff8ee749da>] kstrdup+0x3a/0x70
>     [<ffffffff8ee74a4c>] kstrdup_const+0x2c/0x40
>     [<ffffffff8f2c0a3c>] kvasprintf_const+0x7c/0xb0
>     [<ffffffff8fc5f427>] kobject_set_name_vargs+0x27/0xa0
>     [<ffffffff8f5a79f7>] dev_set_name+0x57/0x80
>     [<ffffffffc0cd2f0f>] memstick_check+0x10f/0x3b0 [memstick]
>     [<ffffffff8ebd41d0>] process_one_work+0x250/0x600
>     [<ffffffff8ebd45d8>] worker_thread+0x48/0x3a0
>     [<ffffffff8ebdfdef>] kthread+0x10f/0x140
>     [<ffffffff8ea03089>] ret_from_fork+0x29/0x50
> unreferenced object 0xffff8fa859c89d90 (size 16):
>   comm "kworker/u12:5", pid 369, jiffies 4294897656 (age 91.704s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 cc cc cc cc cc cc  memstick0.......
>   backtrace:
>     [<ffffffff8ef0a8fc>] slab_post_alloc_hook+0x8c/0x3e0
>     [<ffffffff8ef12289>] __kmem_cache_alloc_node+0x1d9/0x2a0
>     [<ffffffff8ee85719>] __kmalloc_node_track_caller+0x59/0x1f0
>     [<ffffffff8ee749da>] kstrdup+0x3a/0x70
>     [<ffffffff8ee74a4c>] kstrdup_const+0x2c/0x40
>     [<ffffffff8f2c0a3c>] kvasprintf_const+0x7c/0xb0
>     [<ffffffff8fc5f427>] kobject_set_name_vargs+0x27/0xa0
>     [<ffffffff8f5a79f7>] dev_set_name+0x57/0x80
>     [<ffffffffc0cd2f0f>] memstick_check+0x10f/0x3b0 [memstick]
>     [<ffffffff8ebd41d0>] process_one_work+0x250/0x600
>     [<ffffffff8ebd45d8>] worker_thread+0x48/0x3a0
>     [<ffffffff8ebdfdef>] kthread+0x10f/0x140
>     [<ffffffff8ea03089>] ret_from_fork+0x29/0x50
> [root@pc-mtodorov marvin]#
> 
> So, the "tlmi_setting" memory leak appears to be fixed by this diff.
> 
> The next step is to add Armin-suggested patch:
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index c816646eb661..1e77ecb0cba8 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
> 
>         /* validate and split from `item,value` -> `value` */
>         value = strpbrk(item, ",");
> -       if (!value || value == item || !strlen(value + 1))
> +       if (!value || value == item || !strlen(value + 1)) {
> +               kfree(item);
>                 return -EINVAL;
> +       }
> 
>         ret = sysfs_emit(buf, "%s\n", value + 1);
>         kfree(item);
> 
> and Thomas' correction for the return type of the tlmi_setting() function:
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 86b33b74519be..c924e9e4a6a5b 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1353,7 +1353,6 @@ static struct tlmi_pwd_setting *tlmi_create_auth(const char *pwd_type,
> 
>  static int tlmi_analyze(void)
>  {
> -       acpi_status status;
>         int i, ret;
> 
>         if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
> @@ -1390,8 +1389,8 @@ static int tlmi_analyze(void)
>                 char *p;
> 
>                 tlmi_priv.setting[i] = NULL;
> -               status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
> -               if (ACPI_FAILURE(status))
> +               ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
> +               if (ret)
>                         break;
>                 if (!item)
>                         break;
> 
> A build on top of 6.3-rc4+ fcd476ea6a88 commit is on the way, with all three included.

Good work on catching these issues, thank you all for your work on this.

I assume that these fixes will be posted as a proper 3 patch
patch-series (one patch per fix) once you are done testing?

Regards,

Hans





