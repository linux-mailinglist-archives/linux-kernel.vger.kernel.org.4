Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2276D6CDAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjC2NfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjC2NfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:35:16 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A483C11;
        Wed, 29 Mar 2023 06:35:12 -0700 (PDT)
Date:   Wed, 29 Mar 2023 08:35:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1680096910; bh=eEv0t9qeBuNyXL35ktgEkmY3CiNmiIqFD7Xg42hmzE0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FeLOiC4oDGCCLrN6dE6sqgoem8dXnHayqk+yRWvLQEnwOxfaxIjLKND17BsQZR4Bo
         TuxPotoDQpLsNV/5caolvah/OcW0BQku7iroFX7k0tMKAIss9WalUrGDNU5mR4LqfH
         EOw8MzOWbpnLVwoXfGyw4XYxfw1YQFO7lfCqwY3I=
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Armin Wolf <W_Armin@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Message-ID: <de54f828-e2c6-4c10-92ce-ca86fb5c5fb4@t-8ch.de>
In-Reply-To: <9f757a7b-6ac9-804a-063f-4cc2c6fc3f54@alu.unizg.hr>
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr> <ZCLPaYGKHlFQGKYQ@kroah.com> <542c13f5-4cdd-7750-f10a-ef64bb7e8faa@alu.unizg.hr> <d011a1d7-34ab-5f54-fcc7-d727abc7ec9b@alu.unizg.hr> <ZCLa3_HnLQA0GQKS@kroah.com> <b50f9460-ac54-e997-f9b9-3c47a9b87aae@alu.unizg.hr> <df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de> <16862c45-2ffd-a2f2-6719-020c5d515800@alu.unizg.hr> <4f65a23f-4e04-f04f-e56b-230a38ac5ec4@gmx.de> <01e920bc-5882-ba0c-dd15-868bf0eca0b8@alu.unizg.hr> <8b478e6d-7482-2cbb-ee14-b2dc522daf35@alu.unizg.hr> <9f757a7b-6ac9-804a-063f-4cc2c6fc3f54@alu.unizg.hr>
Subject: Re: [BUG] [BISECTED] [CORRECTION] systemd-devd triggers kernel
 memleak apparently in drivers/core/dd.c: driver_register()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <de54f828-e2c6-4c10-92ce-ca86fb5c5fb4@t-8ch.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mar 29, 2023 08:31:31 Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr=
>:

> Hi, again,
>
> NOTE: I forgot to rewind to the first bad commit. So please ignore
> the previous email.
>
> On 29.3.2023. 15:22, Mirsad Goran Todorovac wrote:
>> Hi, Armin, Mr. Greg,
>> On 29.3.2023. 10:13, Mirsad Goran Todorovac wrote:
>>> On 28.3.2023. 21:55, Armin Wolf wrote:
>>>> Am 28.03.23 um 21:06 schrieb Mirsad Goran Todorovac:
>>>>
>>>>> On 3/28/2023 6:53 PM, Armin Wolf wrote:
>>>>>> =E2=80=A6
>>>>>
>>>>> Hi Armin,
>>>>>
>>>>> I tried your suggestion, and though it is an obvious improvement and =
a
>>>>> leak fix, this
>>>>> was not the one we were searching for.
>>>>>
>>>>> I tested the following patch:
>>>>>
>>>>> diff --git a/drivers/platform/x86/think-lmi.c
>>>>> b/drivers/platform/x86/think-lmi.c
>>>>> index c816646eb661..1e77ecb0cba8 100644
>>>>> --- a/drivers/platform/x86/think-lmi.c
>>>>> +++ b/drivers/platform/x86/think-lmi.c
>>>>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject
>>>>> *kobj, struct kobj_attribute *a
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* validate and split from=
 `item,value` -> `value` */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D strpbrk(item, ",=
");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D item=
 || !strlen(value + 1))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D item=
 || !strlen(value + 1)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 kfree(item);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sysfs_emit(buf, "%=
s\n", value + 1);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(item);
>>>>>
>>>>> (I would also object to the use of strlen() here, for it is inherentl=
y
>>>>> insecure
>>>>> against SEGFAULT in kernel space.)
>>>>>
>>>>> I still get:
>>>>> [root@pc-mtodorov marvin]# uname -rms
>>>>> Linux 6.3.0-rc4-armin-patch-00025-g3a93e40326c8-dirty x86_64
>>>>> [root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak [edited]
>>>>> unreferenced object 0xffff8eb008ef9260 (size 96):
>>>>> =C2=A0 comm "systemd-udevd", pid 771, jiffies 4294896499 (age 74.880s=
)
>>>>> =C2=A0 hex dump (first 32 bytes):
>>>>> =C2=A0=C2=A0=C2=A0 53 65 72 69 61 6c 50 6f 72 74 31 41 64 64 72 65 Se=
rialPort1Addre
>>>>> =C2=A0=C2=A0=C2=A0 73 73 2c 33 46 38 2f 49 52 51 34 3b 5b 4f 70 74 ss=
,3F8/IRQ4;[Opt
>>>>> =C2=A0 backtrace:
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9eafb26c>] slab_post_alloc_hook+0x8c/0x3=
e0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9eb02b49>] __kmem_cache_alloc_node+0x1d9=
/0x2a0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9ea773c9>] __kmalloc_node_track_caller+0=
x59/0x180
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9ea66a1a>] kstrdup+0x3a/0x70
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0eef9aa>] tlmi_extract_output_string.is=
ra.0+0x2a/0x60
>>>>> [think_lmi]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0eefb64>] tlmi_setting.constprop.4+0x54=
/0x90 [think_lmi]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0ef02c1>] tlmi_probe+0x591/0xba0 [think=
_lmi]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0629c53>] wmi_dev_probe+0x163/0x230 [wm=
i]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f1987eb>] really_probe+0x17b/0x3d0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f198ad4>] __driver_probe_device+0x84/0x=
190
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f198c14>] driver_probe_device+0x24/0xc0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f198ed2>] __driver_attach+0xc2/0x190
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f195ab1>] bus_for_each_dev+0x81/0xd0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f197c62>] driver_attach+0x22/0x30
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f197354>] bus_add_driver+0x1b4/0x240
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f19a0a2>] driver_register+0x62/0x120
>>>>> unreferenced object 0xffff8eb018ddbb40 (size 64):
>>>>> =C2=A0 comm "systemd-udevd", pid 771, jiffies 4294896528 (age 74.780s=
)
>>>>> =C2=A0 hex dump (first 32 bytes):
>>>>> =C2=A0=C2=A0=C2=A0 55 53 42 50 6f 72 74 41 63 63 65 73 73 2c 45 6e US=
BPortAccess,En
>>>>> =C2=A0=C2=A0=C2=A0 61 62 6c 65 64 3b 5b 4f 70 74 69 6f 6e 61 6c 3a ab=
led;[Optional:
>>>>> =C2=A0 backtrace:
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9eafb26c>] slab_post_alloc_hook+0x8c/0x3=
e0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9eb02b49>] __kmem_cache_alloc_node+0x1d9=
/0x2a0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9ea773c9>] __kmalloc_node_track_caller+0=
x59/0x180
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9ea66a1a>] kstrdup+0x3a/0x70
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0eef9aa>] tlmi_extract_output_string.is=
ra.0+0x2a/0x60
>>>>> [think_lmi]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0eefb64>] tlmi_setting.constprop.4+0x54=
/0x90 [think_lmi]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0ef02c1>] tlmi_probe+0x591/0xba0 [think=
_lmi]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0629c53>] wmi_dev_probe+0x163/0x230 [wm=
i]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f1987eb>] really_probe+0x17b/0x3d0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f198ad4>] __driver_probe_device+0x84/0x=
190
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f198c14>] driver_probe_device+0x24/0xc0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f198ed2>] __driver_attach+0xc2/0x190
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f195ab1>] bus_for_each_dev+0x81/0xd0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f197c62>] driver_attach+0x22/0x30
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f197354>] bus_add_driver+0x1b4/0x240
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f19a0a2>] driver_register+0x62/0x120
>>>>> unreferenced object 0xffff8eb006fe2b40 (size 64):
>>>>> =C2=A0 comm "systemd-udevd", pid 771, jiffies 4294896542 (age 74.724s=
)
>>>>> =C2=A0 hex dump (first 32 bytes):
>>>>> =C2=A0=C2=A0=C2=A0 55 53 42 42 49 4f 53 53 75 70 70 6f 72 74 2c 45 US=
BBIOSSupport,E
>>>>> =C2=A0=C2=A0=C2=A0 6e 61 62 6c 65 64 3b 5b 4f 70 74 69 6f 6e 61 6c na=
bled;[Optional
>>>>> =C2=A0 backtrace:
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9eafb26c>] slab_post_alloc_hook+0x8c/0x3=
e0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9eb02b49>] __kmem_cache_alloc_node+0x1d9=
/0x2a0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9ea773c9>] __kmalloc_node_track_caller+0=
x59/0x180
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9ea66a1a>] kstrdup+0x3a/0x70
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0eef9aa>] tlmi_extract_output_string.is=
ra.0+0x2a/0x60
>>>>> [think_lmi]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0eefb64>] tlmi_setting.constprop.4+0x54=
/0x90 [think_lmi]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0ef02c1>] tlmi_probe+0x591/0xba0 [think=
_lmi]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffffc0629c53>] wmi_dev_probe+0x163/0x230 [wm=
i]
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f1987eb>] really_probe+0x17b/0x3d0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f198ad4>] __driver_probe_device+0x84/0x=
190
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f198c14>] driver_probe_device+0x24/0xc0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f198ed2>] __driver_attach+0xc2/0x190
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f195ab1>] bus_for_each_dev+0x81/0xd0
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f197c62>] driver_attach+0x22/0x30
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f197354>] bus_add_driver+0x1b4/0x240
>>>>> =C2=A0=C2=A0=C2=A0 [<ffffffff9f19a0a2>] driver_register+0x62/0x120
>>>>>
>>>>> There are currently 84 wmi_dev_probe leaks, sized mostly 64 bytes, an=
d
>>>>> one 96 and two 192 bytes.
>>>>>
>>>>> I also cannot figure out the mechanism by which current_value_show()
>>>>> is called, when it is static?
>>>>>
>>>>> Any idea?
>>>>>
>>>>> Thanks.
>>>>>
>>>>> Best regards,
>>>>> Mirsad
>>>>>
>>>> Can you tell me how many BIOS settings think-lmi provides on your mach=
ine? Because according to the stacktrace,
>>>> the other place where the leak could have occurred is inside tlmi_anal=
yze(), which calls tlmi_setting().
>>>
>>> Yes, Sir!
>>>
>>> I think these could be the ones you need (totaling 83, which is close t=
o 82 systemd-udevd leaks):
>>>
>>> [root@pc-mtodorov marvin]# ls -l /sys/devices/virtual/firmware-attribut=
es/thinklmi/attributes | grep ^d
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 AfterPowerLoss
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 AlarmDate(MM\DD=
\YYYY)
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 AlarmDayofWeek
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 AlarmTime(HH:MM=
:SS)
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 ASPMSupport
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 AutomaticBootSe=
quence
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 BIOSPasswordAtB=
ootDeviceList
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 BIOSPasswordAtR=
eboot
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 BIOSPasswordAtU=
nattendedBoot
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 BootMode
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 BootPriority
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 BootUpNum-LockS=
tatus
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 C1ESupport
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 CardReader
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 ClearTCGSecurit=
yFeature
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 ComputraceModul=
eActivation
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 ConfigurationCh=
angeDetection
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 ConfigureSATAas
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 CoreMulti-Proce=
ssing
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 CoverTamperDete=
cted
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 CSM
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 CStateSupport
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 DeviceGuard
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 DustShieldAlert
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 EISTSupport
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 EnhancedPowerSa=
vingMode
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 ErrorBootSequen=
ce
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 Friday
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 FrontUSBPorts
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 HardDiskPre-del=
ay
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 Intel(R)SGXCont=
rol
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 InternalSpeaker
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 Monday
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 OnboardAudioCon=
troller
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 OnboardEthernet=
Controller
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 OptionKeysDispl=
ay
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 OptionKeysDispl=
ayStyle
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 OSOptimizedDefa=
ults
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 PasswordCountEx=
ceededError
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 PCIe16xSlotSpee=
d
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 PCIe1xSlot1Spee=
d
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 PrimaryBootSequ=
ence
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 PXEIPV4NetworkS=
tack
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 PXEIPV6NetworkS=
tack
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 PXEOptionROM
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 RearUSBPorts
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 RequireAdmin.Pa=
ss.whenFlashing
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 RequireHDPonSys=
temBoot
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 SATAController
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 SATADrive1
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 SATADrive2
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 Saturday
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 SecureBoot
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 SecureRollBackP=
revention
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 SecurityChip
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 SelectActiveVid=
eo
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 SerialPort1Addr=
ess
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 SmartUSBProtect=
ion
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 StartupDeviceMe=
nuPrompt
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 StartupSequence
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 Sunday
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 Thursday
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 Tuesday
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 TurboMode
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBBIOSSupport
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBEnumerationD=
elay
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBPort1
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBPort2
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBPort3
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBPort4
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBPort5
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBPort6
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBPort7
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBPort8
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 USBPortAccess
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 UserDefinedAlar=
mTime(HH:MM:SS)
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 VirtualizationT=
echnology
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 VTdFeature
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 WakefromSerialP=
ortRing
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 WakeOnLAN
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 WakeUponAlarm
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 Wednesday
>>> drwxr-xr-x 2 root root=C2=A0=C2=A0=C2=A0 0 Mar 29 08:24 WindowsUEFIFirm=
wareUpdate
>>> [root@pc-mtodorov marvin]# ls -l /sys/devices/virtual/firmware-attribut=
es/thinklmi/attributes | grep ^d | wc -l
>>> 83
>>> [root@pc-mtodorov marvin]#
>>>
>>>> However, i have no idea on how *info is somehow leaked, it has to happ=
en inside the for-loop tween the call
>>>> to tlmi_setting() and strreplace(), because otherwise the strings woul=
d not contain the "/" character.
>>>
>>> I see. It is the line 1404.
>>>
>>>> Can you check if the problem is somehow solved by applying the followi=
ng commit from the platform-drivers-x86
>>>> for-next branch:
>>>> da62908efe80 ("platform/x86: think-lmi: Properly interpret return valu=
e of tlmi_setting")
>>>
>>> It could possibly be that. But I do not recall seeing these messages in=
 6.3-rc3 ...
>>>
>>> ...
>>>
>>> Unfortunately, the build with Thomas' patch you referred to did not wor=
k:
>>>
>>> unreferenced object 0xffff9dff4d28bbc8 (size 192):
>>> =C2=A0=C2=A0 comm "systemd-udevd", pid 769, jiffies 4294897473 (age 85.=
700s)
>>> =C2=A0=C2=A0 hex dump (first 32 bytes):
>>> =C2=A0=C2=A0=C2=A0=C2=A0 50 72 69 6d 61 72 79 42 6f 6f 74 53 65 71 75 6=
5=C2=A0 PrimaryBootSeque
>>> =C2=A0=C2=A0=C2=A0=C2=A0 6e 63 65 2c 4d 2e 32 20 44 72 69 76 65 20 31 3=
a=C2=A0 nce,M.2 Drive 1:
>>> =C2=A0=C2=A0 backtrace:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa48fb26c>] slab_post_alloc_hook+0x8c=
/0x3e0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4902b49>] __kmem_cache_alloc_node+0=
x1d9/0x2a0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa48773c9>] __kmalloc_node_track_call=
er+0x59/0x180
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4866a1a>] kstrdup+0x3a/0x70
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffc0c7f9aa>] tlmi_extract_output_strin=
g.isra.0+0x2a/0x60 [think_lmi]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffc0c7fb64>] tlmi_setting.constprop.4+=
0x54/0x90 [think_lmi]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffc0c802c1>] tlmi_probe+0x591/0xba0 [t=
hink_lmi]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffc03c9c53>] wmi_dev_probe+0x163/0x230=
 [wmi]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f987eb>] really_probe+0x17b/0x3d0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f98ad4>] __driver_probe_device+0x8=
4/0x190
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f98c14>] driver_probe_device+0x24/=
0xc0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f98ed2>] __driver_attach+0xc2/0x19=
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f95ab1>] bus_for_each_dev+0x81/0xd=
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f97c62>] driver_attach+0x22/0x30
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f97354>] bus_add_driver+0x1b4/0x24=
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f9a0a2>] driver_register+0x62/0x12=
0
>>> unreferenced object 0xffff9dff4d28a008 (size 192):
>>> =C2=A0=C2=A0 comm "systemd-udevd", pid 769, jiffies 4294897517 (age 85.=
540s)
>>> =C2=A0=C2=A0 hex dump (first 32 bytes):
>>> =C2=A0=C2=A0=C2=A0=C2=A0 45 72 72 6f 72 42 6f 6f 74 53 65 71 75 65 6e 6=
3=C2=A0 ErrorBootSequenc
>>> =C2=A0=C2=A0=C2=A0=C2=A0 65 2c 4e 65 74 77 6f 72 6b 20 31 3a 4d 2e 32 2=
0=C2=A0 e,Network 1:M.2
>>> =C2=A0=C2=A0 backtrace:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa48fb26c>] slab_post_alloc_hook+0x8c=
/0x3e0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4902b49>] __kmem_cache_alloc_node+0=
x1d9/0x2a0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa48773c9>] __kmalloc_node_track_call=
er+0x59/0x180
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4866a1a>] kstrdup+0x3a/0x70
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffc0c7f9aa>] tlmi_extract_output_strin=
g.isra.0+0x2a/0x60 [think_lmi]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffc0c7fb64>] tlmi_setting.constprop.4+=
0x54/0x90 [think_lmi]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffc0c802c1>] tlmi_probe+0x591/0xba0 [t=
hink_lmi]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffc03c9c53>] wmi_dev_probe+0x163/0x230=
 [wmi]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f987eb>] really_probe+0x17b/0x3d0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f98ad4>] __driver_probe_device+0x8=
4/0x190
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f98c14>] driver_probe_device+0x24/=
0xc0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f98ed2>] __driver_attach+0xc2/0x19=
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f95ab1>] bus_for_each_dev+0x81/0xd=
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f97c62>] driver_attach+0x22/0x30
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f97354>] bus_add_driver+0x1b4/0x24=
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [<ffffffffa4f9a0a2>] driver_register+0x62/0x12=
0
>>> [root@pc-mtodorov marvin]# uname -rms
>>> Linux 6.3.0-rc4-armin+tw-patch-00025-g3a93e40326c8-dirty x86_64
>>> [root@pc-mtodorov marvin]#
>>>
>>> What was applied is:
>>>
>>> mtodorov@domac:~/linux/kernel/linux_torvalds$ git diff
>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/th=
ink-lmi.c
>>> index c816646eb661..9a3015f43aaf 100644
>>> --- a/drivers/platform/x86/think-lmi.c
>>> +++ b/drivers/platform/x86/think-lmi.c
>>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject *=
kobj, struct kobj_attribute *a
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* validate and split =
from `item,value` -> `value` */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D strpbrk(item=
, ",");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D item |=
| !strlen(value + 1))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D item |=
| !strlen(value + 1)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 kfree(item);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sysfs_emit(buf=
, "%s\n", value + 1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(item);
>>> @@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting *tlmi_create_auth(=
const char *pwd_type,
>>>
>>> =C2=A0=C2=A0static int tlmi_analyze(void)
>>> =C2=A0=C2=A0{
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_status status;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, ret;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wmi_has_guid(LENOV=
O_SET_BIOS_SETTINGS_GUID) &&
>>> @@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *p;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlmi_priv.setting[i] =3D NULL;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 status =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID)=
;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!item)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 break;
>>>
>>>
>>>> Also current_value_show() is used by attr_current_val, the __ATTR_RW_M=
ODE() macro arranges for that.
>>>
>>> Thanks.
>>>
>>> In this build:
>>>
>>> [root@pc-mtodorov marvin]# uname -rms
>>> Linux 6.3.0-rc34tests-00001-g6981739a967c x86_64
>>> [root@pc-mtodorov marvin]#
>>>
>>> ... the bug isn't present, so it might be something added recently:
>>>
>>> commit 8a02d70679fc1c434401863333c8ea7dbf201494
>>> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Date:=C2=A0=C2=A0 Sun Mar 19 20:32:21 2023 -0400
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 platform/x86: think-lmi: Add possible_values f=
or ThinkStation
>>>
>>> commit cf337f27f3bfc4aeab4954c468239fd6233c7638
>>> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Date:=C2=A0=C2=A0 Sun Mar 19 20:32:20 2023 -0400
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 platform/x86: think-lmi: only display possible=
_values if available
>>>
>>> commit 45e21289bfc6e257885514790a8a8887da822d40
>>> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Date:=C2=A0=C2=A0 Sun Mar 19 20:32:19 2023 -0400
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 platform/x86: think-lmi: use correct possible_=
values delimiters
>>>
>>> commit 583329dcf22e568a328a944f20427ccfc95dce01
>>> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Date:=C2=A0=C2=A0 Sun Mar 19 20:32:18 2023 -0400
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 platform/x86: think-lmi: add missing type attr=
ibute
>>>
>>> I have CC:-ed the author of the commits.
>>>
>>> I can try bisect, but only after my day job.
>> I seem to have been right about the culprit commit.
>> Here is the bisect log:
>> mtodorov@domac:~/linux/kernel/linux_torvalds$ git bisect log
>> git bisect start '--' './drivers/platform/x86'
>> # good: [caa0708a81d6a2217c942959ef40d515ec1d3108] bootconfig: Change me=
ssage if no bootconfig with CONFIG_BOOT_CONFIG_FORCE=3Dy
>> git bisect good caa0708a81d6a2217c942959ef40d515ec1d3108
>> # bad: [8a02d70679fc1c434401863333c8ea7dbf201494] platform/x86: think-lm=
i: Add possible_values for ThinkStation
>> git bisect bad 8a02d70679fc1c434401863333c8ea7dbf201494
>> # good: [1a0009abfa7893b9cfcd3884658af1cbee6b26ce] platform: mellanox: m=
lx-platform: Initialize shift variable to 0
>> git bisect good 1a0009abfa7893b9cfcd3884658af1cbee6b26ce
>> # good: [b7c994f8c35e916e27c60803bb21457bc1373500] platform/x86 (gigabyt=
e-wmi): Add support for A320M-S2H V2
>> git bisect good b7c994f8c35e916e27c60803bb21457bc1373500
>> # good: [45e21289bfc6e257885514790a8a8887da822d40] platform/x86: think-l=
mi: use correct possible_values delimiters
>> git bisect good 45e21289bfc6e257885514790a8a8887da822d40
>> # good: [cf337f27f3bfc4aeab4954c468239fd6233c7638] platform/x86: think-l=
mi: only display possible_values if available
>> git bisect good cf337f27f3bfc4aeab4954c468239fd6233c7638
>> # first bad commit: [8a02d70679fc1c434401863333c8ea7dbf201494] platform/=
x86: think-lmi: Add possible_values for ThinkStation
>> mtodorov@domac:~/linux/kernel/linux_torvalds$
>> Please see below.
>> Apparently, this commit broke something on my Lenovo box:
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/thi=
nk-lmi.c
>> index e190fec26021..3f0641360251 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -941,9 +941,6 @@ static ssize_t possible_values_show(struct kobject *=
kobj, struct kobj_attribute
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tlmi_attr_setting *set=
ting =3D to_tlmi_attr_setting(kobj);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tlmi_priv.can_get_bios_select=
ions)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sysfs_emit(buf, "%s\n"=
, setting->possible_values);
>> =C2=A0}
>> @@ -1052,6 +1049,18 @@ static struct kobj_attribute attr_current_val =3D=
 __ATTR_RW_MODE(current_value, 06
>> =C2=A0static struct kobj_attribute attr_type =3D __ATTR_RO(type);
>> +static umode_t attr_is_visible(struct kobject *kobj,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct attribute *attr, int n)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tlmi_attr_setting *setting =
=3D to_tlmi_attr_setting(kobj);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We don't want to display possib=
le_values attributes if not available */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((attr =3D=3D &attr_possible_va=
lues.attr) && (!setting->possible_values))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return attr->mode;
>> +}
>> +
>> =C2=A0static struct attribute *tlmi_attrs[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &attr_displ_name.attr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &attr_current_val.attr,
>> @@ -1061,6 +1070,7 @@ static struct attribute *tlmi_attrs[] =3D {
>> =C2=A0};
>> =C2=A0static const struct attribute_group tlmi_attr_group =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .is_visible =3D attr_is_visible,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .attrs =3D tlmi_attrs,
>> =C2=A0};
>> Hope this helps narrow down the problem.
>> Best regards,
>> Mirsad
>> Why aren't you looking at the wmi.c driver?=C2=A0 That should be
>>>>>> =E2=80=A6
>
> mtodorov@domac:~/linux/kernel/linux_torvalds$ git bisect log
> git bisect start '--' './drivers/platform/x86'
> # good: [caa0708a81d6a2217c942959ef40d515ec1d3108] bootconfig: Change mes=
sage if no bootconfig with CONFIG_BOOT_CONFIG_FORCE=3Dy
> git bisect good caa0708a81d6a2217c942959ef40d515ec1d3108
> # bad: [8a02d70679fc1c434401863333c8ea7dbf201494] platform/x86: think-lmi=
: Add possible_values for ThinkStation
> git bisect bad 8a02d70679fc1c434401863333c8ea7dbf201494
> # good: [1a0009abfa7893b9cfcd3884658af1cbee6b26ce] platform: mellanox: ml=
x-platform: Initialize shift variable to 0
> git bisect good 1a0009abfa7893b9cfcd3884658af1cbee6b26ce
> # good: [b7c994f8c35e916e27c60803bb21457bc1373500] platform/x86 (gigabyte=
-wmi): Add support for A320M-S2H V2
> git bisect good b7c994f8c35e916e27c60803bb21457bc1373500
> # good: [45e21289bfc6e257885514790a8a8887da822d40] platform/x86: think-lm=
i: use correct possible_values delimiters
> git bisect good 45e21289bfc6e257885514790a8a8887da822d40
> # good: [cf337f27f3bfc4aeab4954c468239fd6233c7638] platform/x86: think-lm=
i: only display possible_values if available
> git bisect good cf337f27f3bfc4aeab4954c468239fd6233c7638
> # first bad commit: [8a02d70679fc1c434401863333c8ea7dbf201494] platform/x=
86: think-lmi: Add possible_values for ThinkStation
> mtodorov@domac:~/linux/kernel/linux_torvalds$
>
> So the commit that triggered the bug on the Lenovo desktop box was:
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/thin=
k-lmi.c
> index 3f0641360251..c816646eb661 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1450,6 +1450,26 @@ static int tlmi_analyze(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (ret || !setting->possible_values)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("Error retrieving pos=
sible values for %d : %s\n",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i, setti=
ng->display_name);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Older =
Thinkstations don't support the bios_selections API.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Instea=
d they store this as a [Optional:Option1,Option2] section of the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * name s=
tring.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Try an=
d pull that out if it's available.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *item, *o=
ptstart, *optend;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tlmi_sett=
ing(setting->index, &item, LENOVO_BIOS_SETTING_GUID)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optstart =3D strstr(item, "[Optional:");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (optstart) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 optstart +=3D strlen("[Optional:");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 optend =3D strstr(optstart, "]");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (optend)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setting->possible_va=
lues =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 kstrndup(optstart, optend - optstart,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);

I guess item needs to be freed here.

(Next week I have access to my Lenovo machine again.
I'll look at it then if it's not solved.)

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * firmware-attributes requires that possible=
_values are separated by ';' but
>
> Thousand apologies, once again.
>
> Best regards,
> Mirsad
>
> --
> Mirsad Todorovac
> System engineer
> Faculty of Graphic Arts | Academy of Fine Arts
> University of Zagreb
> Republic of Croatia, the European Union
>
> Sistem in=C5=BEenjer
> Grafi=C4=8Dki fakultet | Akademija likovnih umjetnosti> Sveu=C4=8Dili=C5=
=A1te u Zagrebu

