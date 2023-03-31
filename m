Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3616D2A01
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjCaVav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjCaVas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:30:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BE721ABA;
        Fri, 31 Mar 2023 14:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680298216; i=w_armin@gmx.de;
        bh=R7fOxnM8TqM20tsEV91hAAgyV7dbxpKdwInfKo11u/I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qCtyfO1srXIxxIoyaYK+ehBc8zgMBnEAyrgXA4VfscQZgDJwwCUCW9zg7QjkwJvXr
         mUyGpzuDkQj1zqFQzxTk4HcBxwgAj+JczY2ukiSJJohSyErQRXIXaQnYKD7APdg5dQ
         Z96zw1IjauYza1ffGgyMVB8GdCt0qrs4TI49Pml9NxVGII3dBdeuup6FY4BOB0N2pf
         ziJbs8aGuOUKD9ZvHwZahdlzupx4NQa9bEoan516jKNE0osiBtZ+Y+ff1gosZUp6on
         2faKHMTuUXsIF+xfgdYD//nj2lZZqHkUfzJ3nrIrpHSa74GhXm8EUb9rtDNpPhjHAx
         NBFRtBFevXbyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowGU-1qDsNq2G2I-00qOPD; Fri, 31
 Mar 2023 23:30:16 +0200
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix memory leak when showing
 current settings
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        markpearson@lenovo.com
Cc:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230331180912.38392-1-W_Armin@gmx.de>
 <baa37033-9b0c-5e40-41a9-bca0836c1330@alu.unizg.hr>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <0bbab386-70ef-5c1a-1007-d2e26346bdd3@gmx.de>
Date:   Fri, 31 Mar 2023 23:30:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <baa37033-9b0c-5e40-41a9-bca0836c1330@alu.unizg.hr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:swYGjKjlJELeKJo98/pbKwtdO+gOSfJ9uB/K3KMgouQJz29KqAS
 GkWRuNvE5EHeWZnGMN+nGF7vQQINK+s+hY1K1iH6r2G4gtqn+FzWSuNEn4SqUny5m0Lr17i
 zOsVdTzkplYa//ruNw0FkSeK3QbHNxc15zUmg2WxLF71JgJ+twPoA01eCsQQZ9PglkE27yu
 7adUZVMd3ukiic5VMuQoQ==
UI-OutboundReport: notjunk:1;M01:P0:IlyvthIc2VU=;CHx1Atz/omIRPTPE+DJggP1wanu
 +dhwHETx+oZvPlOrAfMARC9LrMOyZUlOl+v+ZAP+AJWKkiCgIRd+bS7eoKaW3zxDXfrcZtqBE
 TxDqywYvKzU1HS4ePxuiWNYybUDnaa0fpfX66luFKZZ8jMDnkQcWmtsUf5Adx4Qe5LE2LzUps
 f8M+0Xqbn/686EQ4IFEvMqOcLADToCm7vNB5b43Y5gMUjKjCxtCAuKgOVNCFknIPHqLgrwWGb
 rYd7AYoekgWqIZyneR0nWpNhfcj3Z6gedcl1lEslbuAE0SZ6S9v82apO/Eeu6YJKEgvdc/ELB
 iVBVLsL7gOdTUrh0QpCFXCls5BV/030nswJoxSvL3bayy+TU+QPfWCDmUj2Spl2Kya897M5sB
 gPsUB8uB7dCrQcJ5y23GNL1XqG7/VyI37VGbBw7DSXND6w70mBtp0n0hdBTV5K1gnYiDxY9DM
 sFKbrujTnhw7Dmaf3NDhT742ayznfLjRKKUFRU+JFXq2ZnFfBj9lYVwZnSiJCT9/pAeZiIsWj
 +QG98PlV41fhwL9lnFgQR07m/AHIISBlBMtmw1CeVajcS7UMGOrxv8dBNrcS4HDNx5V6rOfbD
 7kNn4UwLrkl8JP7MeISJqwuaKCR4z/drUcMZY+TI7r/RR5LuNky00UdKtNKD04NdlwYjPFUbd
 gfZSSw0xxX4TWOz1p/lIV4V8Yi1ZTgcrSVmxI/UzNK/YG7jJ7iVThcMwBLh4HKa5iQ54G9YEz
 vAcn+w9JJyUwEsKiaChMfJFUywjPTTWuepYrqHEEwYlN6Nj+VUE9U4MQ9wM0I2Rnly39MJEki
 2uNqwTHpaRGhjmv00YIo6jiolSsAuI22mBvY00jwGPNUhnJ7vh+4oEg2bnU3sRSN8Rkp9WWif
 oyewRYEwNjnXxbCsd+ZifoRTrG4EcmWZCeIX7MaRGEvGlfceAoeXWr9Xx1HQwDpOKEGoUo5iT
 73CCezCxE2Mcv5EcIuUeoTxs1X0=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.03.23 um 22:23 schrieb Mirsad Goran Todorovac:

> On 31. 03. 2023. 20:09, Armin Wolf wrote:
>> When retriving a item string with tlmi_setting(), the result has to be
>> freed using kfree(). In current_value_show() however, malformed
>> item strings are not freed, causing a memory leak.
>> Fix this by eliminating the early return responsible for this.
>>
>> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Link: https://lore.kernel.org/platform-driver-x86/01e920bc-5882-ba0c-dd=
15-868bf0eca0b8@alu.unizg.hr/T/#t
>> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface suppor=
t on Lenovo platforms")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>> Changes in v2:
>> - Add Reported-by: and Link: tags
>> ---
>>   drivers/platform/x86/think-lmi.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/th=
ink-lmi.c
>> index cc66f7cbccf2..8cafb9d4016c 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -930,10 +930,12 @@ static ssize_t current_value_show(struct kobject =
*kobj, struct kobj_attribute *a
>>   	/* validate and split from `item,value` -> `value` */
>>   	value =3D strpbrk(item, ",");
>>   	if (!value || value =3D=3D item || !strlen(value + 1))
>> -		return -EINVAL;
>> +		ret =3D -EINVAL;
>> +	else
>> +		ret =3D sysfs_emit(buf, "%s\n", value + 1);
>>
>> -	ret =3D sysfs_emit(buf, "%s\n", value + 1);
>>   	kfree(item);
>> +
>>   	return ret;
>>   }
>>
>> --
>> 2.30.2
> I can confirm that the test passed in the original environment that caus=
ed the kmemleak.
>
> [root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8e614889e390 (size 16):
>    comm "kworker/u12:5", pid 366, jiffies 4294896428 (age 93.704s)
>    hex dump (first 16 bytes):
>      6d 65 6d 73 74 69 63 6b 30 00 cc cc cc cc cc cc  memstick0.......
>    backtrace:
>      [<ffffffff860fb26c>] slab_post_alloc_hook+0x8c/0x3e0
>      [<ffffffff86102b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
>      [<ffffffff860773c9>] __kmalloc_node_track_caller+0x59/0x180
>      [<ffffffff86066a1a>] kstrdup+0x3a/0x70
>      [<ffffffff86066a8c>] kstrdup_const+0x2c/0x40
>      [<ffffffff864a987c>] kvasprintf_const+0x7c/0xb0
>      [<ffffffff86e3b427>] kobject_set_name_vargs+0x27/0xa0
>      [<ffffffff8678ed17>] dev_set_name+0x57/0x80
>      [<ffffffffc0e49f0f>] memstick_check+0x10f/0x3b0 [memstick]
>      [<ffffffff85dcb4c0>] process_one_work+0x250/0x530
>      [<ffffffff85dcb7f8>] worker_thread+0x48/0x3a0
>      [<ffffffff85dd6dff>] kthread+0x10f/0x140
>      [<ffffffff85c02fa9>] ret_from_fork+0x29/0x50
> unreferenced object 0xffff8e6158f93b90 (size 16):
>    comm "kworker/u12:5", pid 366, jiffies 4294896433 (age 93.684s)
>    hex dump (first 16 bytes):
>      6d 65 6d 73 74 69 63 6b 30 00 cc cc cc cc cc cc  memstick0.......
>    backtrace:
>      [<ffffffff860fb26c>] slab_post_alloc_hook+0x8c/0x3e0
>      [<ffffffff86102b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
>      [<ffffffff860773c9>] __kmalloc_node_track_caller+0x59/0x180
>      [<ffffffff86066a1a>] kstrdup+0x3a/0x70
>      [<ffffffff86066a8c>] kstrdup_const+0x2c/0x40
>      [<ffffffff864a987c>] kvasprintf_const+0x7c/0xb0
>      [<ffffffff86e3b427>] kobject_set_name_vargs+0x27/0xa0
>      [<ffffffff8678ed17>] dev_set_name+0x57/0x80
>      [<ffffffffc0e49f0f>] memstick_check+0x10f/0x3b0 [memstick]
>      [<ffffffff85dcb4c0>] process_one_work+0x250/0x530
>      [<ffffffff85dcb7f8>] worker_thread+0x48/0x3a0
>      [<ffffffff85dd6dff>] kthread+0x10f/0x140
>      [<ffffffff85c02fa9>] ret_from_fork+0x29/0x50
> [root@pc-mtodorov marvin]# uname -rms
> Linux 6.3.0-rc4-00034-gfcd476ea6a88-dirty x86_64
> [root@pc-mtodorov marvin]#
>
> NOTE: The leaks here belong to drivers/memstick/core/memstick.c leak for=
 which I have
> proposed a fix in message <df560535-2a8e-de21-d45d-805159d70954@alu.uniz=
g.hr>.
>
> This test was built on the 6.3-rc4+ commit fcd476ea6a88 Torvalds tree + =
the following
> patches (Armin's, and Thomas's).
>
>   drivers/platform/x86/think-lmi.c | 18 ++++++++++--------
>   drivers/usb/host/xhci.c          |  1 +
>   2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/thi=
nk-lmi.c
> index c816646eb661..c2146add88ab 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -930,10 +930,12 @@ static ssize_t current_value_show(struct kobject *=
kobj, struct kobj_attribute *a
>          /* validate and split from `item,value` -> `value` */
>          value =3D strpbrk(item, ",");
>          if (!value || value =3D=3D item || !strlen(value + 1))
> -               return -EINVAL;
> +               ret =3D -EINVAL;
> +       else
> +               ret =3D sysfs_emit(buf, "%s\n", value + 1);
>
> -       ret =3D sysfs_emit(buf, "%s\n", value + 1);
>          kfree(item);
> +
>          return ret;
>   }
>
> @@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting *tlmi_create_auth(c=
onst char *pwd_type,
>
>   static int tlmi_analyze(void)
>   {
> -       acpi_status status;
>          int i, ret;
>
>          if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
> @@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
>                  char *p;
>
>                  tlmi_priv.setting[i] =3D NULL;
> -               status =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GU=
ID);
> -               if (ACPI_FAILURE(status))
> +               ret =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID)=
;
> +               if (ret)
>                          break;
>                  if (!item)
>                          break;
> @@ -1457,10 +1458,10 @@ static int tlmi_analyze(void)
>                           * name string.
>                           * Try and pull that out if it's available.
>                           */
> -                       char *item, *optstart, *optend;
> +                       char *optitem, *optstart, *optend;
>
> -                       if (!tlmi_setting(setting->index, &item, LENOVO_=
BIOS_SETTING_GUID)) {
> -                               optstart =3D strstr(item, "[Optional:");
> +                       if (!tlmi_setting(setting->index, &optitem, LENO=
VO_BIOS_SETTING_GUID)) {
> +                               optstart =3D strstr(optitem, "[Optional:=
");
>                                  if (optstart) {
>                                          optstart +=3D strlen("[Optional=
:");
>                                          optend =3D strstr(optstart, "]"=
);
> @@ -1469,6 +1470,7 @@ static int tlmi_analyze(void)
>                                                          kstrndup(optsta=
rt, optend - optstart,
>                                                                         =
 GFP_KERNEL);
>                                  }
> +                               kfree(optitem);
>                          }
>                  }
>                  /*
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 6183ce8574b1..905f1e89ead8 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4438,6 +4438,7 @@ static int __maybe_unused xhci_change_max_exit_lat=
ency(struct xhci_hcd *xhci,
>
>          if (!virt_dev || max_exit_latency =3D=3D virt_dev->current_mel)=
 {
>                  spin_unlock_irqrestore(&xhci->lock, flags);
> +               xhci_free_command(xhci, command);
>                  return 0;
>          }
>
> Xhci patch from Mathias is included because it is well tested and alread=
y submitted and acked.
>
> At your convenience and according to the Code of Conduct, you can add:
>
> Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>
> Otherwise, Armin, I think you should submit this patch rightly because a=
ll idea to search in
> think-lmi.c was yours.
>
> Bisect was also much faster and in fewer steps.
>
> Thanks,
> Mirsad
>
Thank you for reporting the memory leak issues and testing the patches.
I will send a v3 of my patch soon which will contain your Tested-by: tag.

Armin Wolf

