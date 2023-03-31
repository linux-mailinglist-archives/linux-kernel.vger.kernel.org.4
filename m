Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096A76D29E7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjCaVVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaVVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:21:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E4E20C2D;
        Fri, 31 Mar 2023 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680297654; i=w_armin@gmx.de;
        bh=J9VJ8CHCU7rBcZL4VF0tmdp+Zcs9G7T5R2pDmGrzVYw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Vsk2gXxK3q/yF7L1hCjIf5x66hSTh9ZoINek8cNGbTnw2s1AzzoDj+9yfGIRcr0hL
         RXA9yVqOgE9K68eszzua3NmQWyx5jZs+rjCKsuplDW6ziJW6P6f7tsCmDLod/RFFdM
         3gCuo8x+w/38w15OWHKpRtxkLKpfuTRPw9suSG+t8s4C/cX3tDK1TpA35ND+eXwrCb
         whX3f4NokQ8mCUr5czw/zbOLMBtGps00bOpkk57gZCSsDRIiYtd35WmVPYqEmwJmIA
         vrXBmZo4j3DHYevallOmwfNCL5gU5EIfCcY75xk5F/d9i3N10mO+5zSRQGyRIbKDi1
         3hB/VG+G5mimw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1premm0y6A-00UNqV; Fri, 31
 Mar 2023 23:20:54 +0200
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix memory leak when showing
 current settings
To:     Mark Pearson <mpearson-lenovo@squebb.ca>,
        Mark Pearson <markpearson@lenovo.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20230331180912.38392-1-W_Armin@gmx.de>
 <2233a8da-aaad-4265-b583-f3db27f75667@app.fastmail.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <3ab4081c-7d14-b39c-cc20-a76d414efff0@gmx.de>
Date:   Fri, 31 Mar 2023 23:20:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2233a8da-aaad-4265-b583-f3db27f75667@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:oxORIEaY5t/M5Y6Gin1i1w4lhOVPWlk99KZmsvml6G5TvEV4Wzq
 3rdv9fm89qqnQ8Dxd9Mj8vDFpO3cn8WMuRclmekOInPE4YF6Lg3BKfsQkDy2aiw6Qw9vSFd
 UXk7p5whhbjeBZ9SBDBNbXXL+Zgxbv1mrX5yacHg3HZQlqcrZ+xbmyniP2HsViM1zC9aj4o
 AszgBt7lLetV2LHt3M/qw==
UI-OutboundReport: notjunk:1;M01:P0:z2CP21p4ckY=;IY8iFp6Xq9JohvdoZouGiVVVBsX
 jweVIcawk7vxKDAjKHVQ3F9nq021Hz60ZuCRDonkqJ3KULmoZWTCSzzcTW37PeV7O19EDEOMi
 cBCXVh5h3gPYIWyAStlD4pF0nsYZOiQWhNvNDlL0HksqieJHjLV9bdZJrQtBTO+TJRu2YLt7c
 AmUL0o8x2bcgovH0xfD94tz0zvkL7ophrWZGkIfKy2gowbwAP/JVcTQP0AInW6RtmOHBBGkT4
 sBD5TgoZCzB07+axN74fx/LjkuXpudVu2VkyLidQK7NQOAJ15DxTn9s7o7dPfcM+UAf+K9LM2
 1JnPO6oSW6t9AnfJLTKX120brVeyA5RncN/4+K1BDwblrqNbNg8Y9F9CgOqzphN+6WAG2iorU
 fT5u8yhfsjqkDdQ4JSYivkcOoM72YJz5cDheK0I+5H5fgQ6I+yPbTqlf2ZOU7AGM7KFtOEQ/0
 BLkNWWqTzII3XwtDNO0rSeeRWDasQ1RYjB0OLwq6KPCsz1jz/d83m8Qc1ppOo0pvaDPBkF6XF
 sHJc8BqW/CRgfmPxXwxBY08NmcXV8DVWO+RwRx8tHROrUbF4cHM09veysCgElBR4sWfS9HqZ3
 fYr5XSQXTGpwTpRRrLj3kZGB3H+KUeTfYG9ujrfAPRQj2/i0ME9LxSreDFMMKNtw0BkcuLV0J
 6My3cDYgqZxIa91E/WykyPrrXNGmZkuE9j8m8HJojcgUWKhqOwXAtS/JFOnIByzq7lo+zMGyQ
 9pyJTNqjMPWUGGybNcQAN1PSF68xrmRSJOj5oDgSasY+1OXwHMlvrV9oqOA3slMpSe8rVid3P
 WXI5CYm3Vx6DrlMMIczBv9O2QbIPHlcIS8QhQMe8njKknV0xNCKtpcvy/3KlKEXT5374lUuL5
 Fr0CfmqerT5XEPHExTNfjaqeM95DxCPtvUmumGMAqRtCHgpFl76Gt2LXAzJ3DGf6O/ch5TeKw
 vobCAIJs8kOd/no9vPB84M2AMAM=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.03.23 um 21:14 schrieb Mark Pearson:

> Hi Armin
>
> On Fri, Mar 31, 2023, at 2:09 PM, Armin Wolf wrote:
>> When retriving a item string with tlmi_setting(), the result has to be
>> freed using kfree(). In current_value_show() however, malformed
>> item strings are not freed, causing a memory leak.
>> Fix this by eliminating the early return responsible for this.
>>
>> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Link:
>> https://lore.kernel.org/platform-driver-x86/01e920bc-5882-ba0c-dd15-868bf0eca0b8@alu.unizg.hr/T/#t
>> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface
>> support on Lenovo platforms")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>> Changes in v2:
>> - Add Reported-by: and Link: tags
>> ---
>>   drivers/platform/x86/think-lmi.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/think-lmi.c
>> b/drivers/platform/x86/think-lmi.c
>> index cc66f7cbccf2..8cafb9d4016c 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -930,10 +930,12 @@ static ssize_t current_value_show(struct kobject
>> *kobj, struct kobj_attribute *a
>>   	/* validate and split from `item,value` -> `value` */
>>   	value = strpbrk(item, ",");
>>   	if (!value || value == item || !strlen(value + 1))
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +	else
>> +		ret = sysfs_emit(buf, "%s\n", value + 1);
>>
>> -	ret = sysfs_emit(buf, "%s\n", value + 1);
>>   	kfree(item);
>> +
>>   	return ret;
>>   }
>>
>> --
>> 2.30.2
> Thanks for doing this - it was on my todo list but you beat me to it.
>
> As a minor note - the Fixes tag should, I think, be
> Fixes: 0fdf10e5fc96 ("platform/x86: think-lmi: Split current_value to reflect only the value")
>
> As that's when I believe I introduced the issue.
>
> Mark

Hi,

you are correct, i will send a v3 soon.

Armin Wolf

