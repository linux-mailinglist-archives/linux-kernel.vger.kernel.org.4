Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB82F670D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjAQXQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjAQXNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:13:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504E305E1;
        Tue, 17 Jan 2023 13:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673989278; bh=I2/wwz29IHFFWcH9NG7gDXsFobXahOWXy341hdlCpYY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Lo5nnjf4+kdztqPH73lADlseS1W3S7XxGEPFe8HkXuE04yz7wfbFE4DBXR79uOVpl
         OEImMyhNsH1UAYLGl1ttT54qLyF+5LLqr7S5Gj3+NwnAWmvzcEjrCrL61pAxztgVNW
         1mpdzyqASn54AlnkEN8MRihhRiXiQO/6A//R4AeXNcmr7dyNvCjuT5SdOJfApw6DA0
         Oa1JI87VlWpUW1QfyGQf0gTuui7YqipKNUXOzYck4dw+HROYGS+HoSQFwDwTu1F1c3
         0ocoEW1ouSM6DowZq4UUL9Z3asps5mXDEThQK2l93sqSXGh011lflTcrC1QVVf9roV
         QfUEP3c5xkxxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXQ5-1oyQor0v9r-00JZIG; Tue, 17
 Jan 2023 22:01:18 +0100
Subject: Re: [PATCH 2/4] ACPI: battery: Fix buffer overread if not
 NUL-terminated
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230114085053.72059-1-W_Armin@gmx.de>
 <20230114085053.72059-3-W_Armin@gmx.de>
 <CAJZ5v0h2vTAUovMoEoWVX2gJQiJS6C9PSYzMqQMtxPusgdHBMQ@mail.gmail.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <90f1270d-3c37-088b-98ac-a08caba685e8@gmx.de>
Date:   Tue, 17 Jan 2023 22:01:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h2vTAUovMoEoWVX2gJQiJS6C9PSYzMqQMtxPusgdHBMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:pAd8VmJjNzHqqsFRHkj5Z0z7Wk0o10r4M/TV2n9E619EIGaL7Ed
 n6AXDzEn57YSyLCB+050zIKViyYr0MHkPTKq2bpBDYF0MB8jRqDTovaQ/rpfWeOBvhVMND4
 gh/mvxtyI5Z74f5XjJ4SqwCARoUBAgnqxM3F7wlT/aS0J39Y368QwsdT+bSpxgsLNcXO3j/
 ce7QZ9zd/R/3IHCRCGtvw==
UI-OutboundReport: notjunk:1;M01:P0:MSvNwI6J0lQ=;Vs7jRF3ENCqJUnOM82hzUBHNH/S
 XHb5AQg1iDZXS5O9Xi5VurF+5p8MiO5trHIXOJLBdVZ/QAFh1WTug3e07QaKFlVvx6tqXZpiJ
 iVHalJ6E2O8oUFmDa2F2I/Pn9V7bxzA4vEVh9LY9cquF9E/n7DSJS2l8ioeL6VIc17SckISlv
 UgsO5BgADeBuM/JDRPkVb5+ESdPhAjtlbqwWFf4KxlwQrt0yb7iCWyUvpjb6mzTiU9Zcvovim
 1SPjPVigNVmYn5R+EqNorhw1WgvRROkipHYqd4CrH7cqZ0sqlbS6v4tIQOzlruydBZ7wra7Ee
 RI4Xw5JoIrDCz2Tb9rgezzl5vCAhIzBamY5rwswf25dJF83aywQC6mBBGtF55W4ODVHG2nj5r
 +u5+41UoWvQeyNqS+E5nbRXylQQMopo19CZFN6Dq4c006TIUGYVq+jqamxukc0vgDOG663jfZ
 Wiub8d3/EGHbC2XQ0PkK7mFMhW3cXQ8Blt0lbkFYS8EXK++eQo7m1/wY/ING3LaInpQzg2VbJ
 HNQO7RcIGl2mvKM1kPRhc0vPITSr8ARsvPINBMEPUph0DLz3DbYAMf1XToPf2WxG50+3NY9lp
 dzh/LB+zSr5Zn9TmNmp85y+u6wEgr6qCo08/vZmwk6PRawOjBCoDCmH+X0DLF2rHSNCtK+6dc
 17qbDxsMuxOyGVNpvjLixLXkkij9yQnAB3Y2gfo9qKKz3nStQOzEhVG698RLF0Ja54eVdfKM9
 8b6zaowhVnw+/s9CG0tlLfQAktHpJMLdis3u27ji8N6UexTguUEOEuEZi4Bwf8GXZXgdRVd7V
 2L7sWmIQS/1fKL22K2IISTqL7t03cxVHH+KSKG92r6o4ouqOYAUepUZzFZz9ZUs6YmYnDEaP6
 KGTAjN/qxtE0HPf2nreK0ny7Lov1Q/6dDF7T4xdMNGaZ9dYoBw/t26fK6UwNnhVj0xTQloVbF
 JsgI+Fa4IgFX/bmiqLSPQC1knew=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.01.23 um 15:42 schrieb Rafael J. Wysocki:

> On Sat, Jan 14, 2023 at 9:51 AM Armin Wolf <W_Armin@gmx.de> wrote:
>> If the buffer containing string data is not NUL-terminated
>> (which is perfectly legal according to the ACPI specification),
>> the acpi battery driver might not honor its length.
> Note that this is about extracting package entries of type ACPI_TYPE_BUFFER.
>
> And please spell ACPI in capitals.
>
>> Fix this by limiting the amount of data to be copied to
>> the buffer length while also using strscpy() to make sure
>> that the resulting string is always NUL-terminated.
> OK
>
>> Also use '\0' instead of a plain 0.
> Why?  It's a u8, not a char.
>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/acpi/battery.c | 23 ++++++++++++++++-------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index fb64bd217d82..9f6daa9f2010 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -438,15 +438,24 @@ static int extract_package(struct acpi_battery *battery,
>>                  if (offsets[i].mode) {
>>                          u8 *ptr = (u8 *)battery + offsets[i].offset;
> I would add
>
> u32 len = 32;
>
>> -                       if (element->type == ACPI_TYPE_STRING ||
>> -                           element->type == ACPI_TYPE_BUFFER)
>> +                       switch (element->type) {
> And here I would do
>
> case ACPI_TYPE_BUFFER:
>          if (len > element->buffer.length + 1)
>                  len = element->buffer.length + 1;
>
>          fallthrough;
> case ACPI_TYPE_STRING:
>          strscpy(ptr, element->buffer.pointer, len);
>          break;
> case ACPI_TYPE_INTEGER:
>
> and so on.

But wouldn't this cause the ACPI string object to be accessed the wrong way
(buffer.pointer instead of string.pointer)?

Armin Wolf

>> +                       case ACPI_TYPE_STRING:
>>                                  strscpy(ptr, element->string.pointer, 32);
>> -                       else if (element->type == ACPI_TYPE_INTEGER) {
>> -                               strncpy(ptr, (u8 *)&element->integer.value,
>> -                                       sizeof(u64));
>> +
>> +                               break;
>> +                       case ACPI_TYPE_BUFFER:
>> +                               strscpy(ptr, element->buffer.pointer,
>> +                                       min_t(u32, element->buffer.length + 1, 32));
>> +
>> +                               break;
>> +                       case ACPI_TYPE_INTEGER:
>> +                               strncpy(ptr, (u8 *)&element->integer.value, sizeof(u64));
>>                                  ptr[sizeof(u64)] = 0;
>> -                       } else
>> -                               *ptr = 0; /* don't have value */
>> +
>> +                               break;
>> +                       default:
>> +                               *ptr = '\0'; /* don't have value */
>> +                       }
>>                  } else {
>>                          int *x = (int *)((u8 *)battery + offsets[i].offset);
>>                          *x = (element->type == ACPI_TYPE_INTEGER) ?
>> --
