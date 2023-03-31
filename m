Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012706D29F2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCaV1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaV1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:27:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2C27690;
        Fri, 31 Mar 2023 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680298010; i=w_armin@gmx.de;
        bh=/3rqtvs5kgeV/KaRx25DhuOLd3xth9Ng3YZIi49OEuo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qsJR/i+MGGAoIXBzBY7vhhXmD5H4s6LWxQQUyhOVksoRjdlTIbZSkgUWM36i3dMiB
         RHd0eDfBtzP5QkL2bWD7AG9FaK6jl/N/FCTe864NFfKgg55oIckEIOuFGKtK+E/33T
         dO2SP7bzMFZpRmpvdofHrwQ0TD+c8qGL5ELAix36K4ElMuo0w7PQgVyZp0Mhn9dVHj
         SsLJDofjI5fujE89D89O2jzg1X29lI0ht6eObXdaM5/w3GFYwz6TE0hktu1GIla7K+
         ECiPeLb3ItzPjf20a+cuwS1N6LT/uijkhoI1x5ErEzaUASVRjgQCn3mNNSYQQtDffV
         ORVxv1SYtNbEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1qBwSt1ewH-00nurT; Fri, 31
 Mar 2023 23:26:50 +0200
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix memory leak when showing
 current settings
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        markpearson@lenovo.com
Cc:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230331180912.38392-1-W_Armin@gmx.de>
 <b166ae90-3878-061d-4bda-6de214c63ca0@alu.unizg.hr>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <7dae767a-51e3-2b3f-3396-7e8193300ac7@gmx.de>
Date:   Fri, 31 Mar 2023 23:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b166ae90-3878-061d-4bda-6de214c63ca0@alu.unizg.hr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:OFhEwbEnkn+MtTKdLdtCBxS+VmIeWM6ojr3LBBfRZO8KzzfP06e
 z03B0GfuBxLAX2XYtUnCAH0E9KHoT8nRK7+jbOda83Ji1LYbvZgchFTvQuDKUK0aIuTkPDN
 QU4CtO+OXLvKKDf5VfEzqMNxe1W51OW9IBoPcwCOvFLpD1C45Q2YYxhkrBiLKwG6un3BqV+
 qNq6qajIohgww5SuzsllQ==
UI-OutboundReport: notjunk:1;M01:P0:SrlptbDyMTc=;t086jGzhRm7zQE4nFvHANjQsqkN
 78eD8xlVK/ry5dnRiIWKCWeNdiGFbg2tnUrV/V7sGal95HnfOu5SimDqoqotVxC56kmLC+xBh
 EMSIdnbPjDUzkIvceRJvZ9mfnALXX7t5pldq6rPcLLx+tUE43yl3NwoUFOC+zFlWE4yMbMy4V
 aiPEwp5BPZ5+BOpUwW0boO1eIXHet8M515oggbmrY444KZy7TvT2lDNxz0AjxmQeQ7j4rQCH9
 jADZBjU3CoDHgwWCTYe/nzKD2Kk8g7fo/zQ0A7380u8xu256bQvyTOpAFXBgbhzYVpYoVzXGp
 tj/ic8ML1JrfVl9JPErJvPbVHTpLtSAdLBHkVFHqxMvtYPrqPFgEiD8wT9wnEFZgHIIdYElYl
 mO3RcAvesuNuG9Ho6Crv13quiXt8TlN8ESqLt4w/1aNcvTP6UPjLQSkyLnGqzxZUCwaYyg7KB
 s8jtHIvq5eIlBSdDzPoi6A6aIdBqBOz/3BPYmJrFk0/ApvYS+WuFCfpAc95R3ef0bs8uOKCIi
 /mojxz5tY0yICu/huQKMR3GTzue5G59CSaZQkARCViChdvL4VfvESK+1Z7q9TWnHNJitD+p4v
 mf+p4Ll583Q3U0R2JBnY/Go0iAhbvcZzHMT+FQ3P5jrk+JDUzvuLt7rNdXRw82Fzr25vg5i0Y
 Cmrr+Q73kb5mitMG0kqsC+Mv5FI54Ta34A+Oox4zduoHR9F9PDTJMpyD4VY/LHKDjF7II1iVs
 Y2AEoIR/sXdmfTeTs+MczD+4xyFoY+41o+qeDfFJu/q6tDlXOa7wvjKDk8ejFE41WyVd6IHoK
 oSIkEpPXB94e5ZNqeFQWcF6RMO28rF6SF0Of+0nHy0bPKr5FPukc+YQEygrDHHZ96tYNqsBEF
 P4PS/QAekToMwPZLNZNRK1VWxZu02Gf7OpKOuiKvPtjp7nvSPA/uIVfKBn96nipqdQOOGpSzL
 wcjET6ASK0x/l2Wv4LHAg72JXRA=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.03.23 um 21:34 schrieb Mirsad Goran Todorovac:

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
> Hi, Armin,
>
> You might have wanted it to be tested in the original setting?
>
> Should this patch work as a standalone fix, without the others?
>
> This part:
>
> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject *k=
obj, struct kobj_attribute *a
>
>          /* validate and split from `item,value` -> `value` */
>          value =3D strpbrk(item, ",");
> -       if (!value || value =3D=3D item || !strlen(value + 1))
> +       if (!value || value =3D=3D item || !strlen(value + 1)) {
> +               kfree(item);
>                  return -EINVAL;
> +       }
>
>          ret =3D sysfs_emit(buf, "%s\n", value + 1);
>          kfree(item);
>
> was apparently superseded.

Hi,

this part is indeed superseded by the patch, and it should work as a stand=
alone fix.
I thought it might be better to have two patches for those two memory leak=
s, as they
are not directly connected.

> Should this one be applied? I guess it should, as I stated in email
> <4dc118c2-0dde-bd5e-ea41-427ed33e4545@alu.unizg.hr> from 2023-03-29 20:4=
9 UTC+02:
>
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
>
> If Mark had found a better fix, then that one goes away, too.
>
> NOTE PLEASE that in the above-mentioned message (like all the others) I =
just specified the
> commit at which the test kernel was built + all the applied patches (git=
 diff did not give
> authors).
>
> This did not imply that I claim Mr. Wei=C3=9Fschuh's fix for tlmi_analyz=
e() return, God forbid!
> I apologise if I made room for such an impression.
>
> That's all, I think. Thank Heavens. God bless!
>
> I will assume the test build on the bottom patch + the Thomas's patch st=
ill apply + your patch.

All good.

Armin Wolf

> Best regards,
> Mirsad
>
