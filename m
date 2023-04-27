Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A764B6F0A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbjD0Qj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbjD0Qj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:39:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF9710CA;
        Thu, 27 Apr 2023 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682613574; i=w_armin@gmx.de;
        bh=wIQuDcQk6w2wCann6GJTP1l0oz5xWwIyaPeXTwbAmHY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=STIdIdHdDb73/pPg3h/tFMgpQD1XwIT5+hGx3VaIQm5QlNhtlaLBt41fHIOzxk8j9
         fXR0CHq3nWKjvJBRcW+AZunuZt/EeSY1aCqqX1tpV7zYb9U/qt7y+0vJI/3kAyvnBO
         ZXK8uI74Bc2T1IYXW0ltXn1NW4ukUOKyy0U8k1U7oxxI/NPnLxAHpvrL1wbSp5tEvj
         ksIxuoiGI/7hskf0Tytdp7ylpIgueGXCc4c0lO6K18u4fdxENgOHvTWc75IiHwZ8CC
         GBmt7CLg/ux4n3e4fAE0YarPQrtG3mDZsZ7c15pva9cGbbdG1R80cQ+RrjYno9Sdt/
         J/9eZuPnzyZdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1qQJTf091h-00cutE; Thu, 27
 Apr 2023 18:39:34 +0200
Subject: Re: [PATCH v3] hwmon: add HP WMI Sensors driver
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424100459.41672-1-james@equiv.tech>
 <cd81a7d6-4b81-f074-1f28-6d1b5300b937@gmx.de> <ZEkkLggFLCGlvq8f@equiv.tech>
 <30339393-0ba2-9788-6ad8-98c89afc6994@gmx.de> <ZEomR842t6QrahyO@equiv.tech>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <de4c28c1-6e70-ceb9-484a-143c2b1ebccc@gmx.de>
Date:   Thu, 27 Apr 2023 18:39:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ZEomR842t6QrahyO@equiv.tech>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:KYRjlB2gpZfeoo05t5SD0A5qhSGRhf+qZJrMVzF/7wb/g+a7MK6
 HvHaSrIERBjyVBlMjAGGPQuYeEVgFNnNcn3ABgBkHGLwTUw+NIfU5u2cRky32z+ZOZUlyY6
 c3gbSXbSFqhJPmmByYy6d9hBB+qzGZEjObdufVUaFxFO4IgDLJgHsvQ6a3uaRFeCuSBfXTL
 jVIpmptxt3EZN6tqCB+qA==
UI-OutboundReport: notjunk:1;M01:P0:BJzmJgDuYBk=;ZpNuOSj0oeDyUitaktFBk8in2er
 hKW+yH55ZYRzrObb1fCwlGj/ycXH5Tk4QY5aUCsTDIiuPoN0OB75WD++ixtRa9UnrQqXsZUkX
 mDWh/nRVohsngDZBBqOEjpFBjPzy/srQ5J3xUOjhTyt7LlVlECpLh3saMSxC59LQvD9aYzuWq
 8cMmO8B+FbQJGU5vjTCjQngkNx1bcJk1vZ4XlkhFfsW/01Umzm9GQIHKV17JeSSbLnCvxIdJ1
 F6qRad63Av4XTWjCO5bVA7sB+ozkSUYhTw79caI/Zm+pZVlbqhq1usIvWXHi4Ve2uR2J+q2UP
 wrnz0JjvkvSRJI3isGxPAp3C1M+Cj3iGmV5S5+87LqqSRR8SBVANmSDnw+Q2pE6CHyt76VtYu
 aSQ7wQHO93IlOfHtVdaAJHi7gtrOHAoxQTao//jlul0nlKxGvhZAPH4a28V4tJ19fEbUNV7Ak
 LLl+jCQuDpUW/mBzzt4eVpbcdqhMcIGyQFoOrzZ8CmuO9a4TG7WaSdYLN4yvdJ6KoWMMEdxoK
 RRuaXk1ZPvupuxQaHPw98cCkqrdqwTt0ZQK5R0xF59hmnPOsiN2DXR1MmU9C4/KroLPKenxZO
 67Y/Cykl6mGpGILlJeg4MmAA5aBNISdnYMsKyXOnUDpX37AZ91aLC/ARkWgLviYLOiSFG9EB6
 Ft5CozySo1O3cJaHPy3XpIupHYww2LH9f8hNxcXQDn5n8hzbQnatbl2EcI1W4120Q9OkNTuxC
 0GK+uzo8zTxMg8pM64tKWG0R8hookNEBY8Kex5IT/Y1WLpdN08tJKL8btH4WOejsXj14DeMOA
 9oT2L2LdvZmLrm4bDdXk/Jh26pk+F/5eS5+AHvpdiU1bf25yKmw3X/bO9dXV4cz/SFMYnWPZm
 2AO8PfjRZ3CHpZ9tsg035M8oONNWmHgamxVAn3WtmBup8vQnN8gc26NjMKEZhnal7LjERDcp1
 IjjU3+yS38XLj2a4XYMrdtWPt8I=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.04.23 um 09:37 schrieb James Seo:

> On Wed, Apr 26, 2023 at 09:35:33PM +0200, Armin Wolf wrote:
>> Am 26.04.23 um 15:16 schrieb James Seo:
>>
>>> On Mon, Apr 24, 2023 at 11:13:36PM +0200, Armin Wolf wrote:
>>>> Am 24.04.23 um 12:05 schrieb James Seo:
>>>>
>>>>> +	for (i = 0; i < HP_WMI_MAX_INSTANCES; i++, pevents++) {
>>>> Hi,
>>>>
>>>> the WMI driver core already knows how many instances of a given WMI object are available.
>>>> Unfortunately, this information is currently unavailable to drivers. Would it be convenient
>>>> for you to access this information? I could try to implement such a function if needed.
>>>>
>>>>> +	for (i = 0; i < HP_WMI_MAX_INSTANCES; i++, info++) {
>>>> Same as above.
>>>>
>>> Hello,
>>>
>>> Having the WMI object instance count wouldn't make much difference to
>>> me for now. The driver has to iterate through all instances during
>>> init anyway. If I were forced to accommodate 50+ sensors, I'd rewrite
>>> some things and I think I'd want such a function then, but I picked
>>> the current arbitrary limit of 32 because even that seems unlikely.
>>>
>>> So, maybe don't worry about it unless you want to. Or am I missing
>>> something?
>>>
>> Hi,
>>
>> i already have a experimental patch available which adds such a function.
>> If you could test this patch to see if it works, then i could submit it upstream
>> where other drivers could profit from being able to know the number of
>> WMI object instances.
>>
> Both your proposed functions worked as expected.
>
>> Your driver could also profit from such a function, as it could optimize the amount
>> of memory allocated to store WMI object data.
> I suppose I might as well. I assume I'm supposed to wait until your
> new functions are merged before making changes that rely on them?

I think you can submit this driver as-is and provide a follow-up patch once
the changes are merged.

>> The current instance discovery algorithm
>> (using a for-loop and break on error) also has a potential issue: when a single WMI call
>> fails for some reason (ACPI error, ...), all following WMI instances are being ignored.
>>
> This is the intended behavior for now, on the assumption that a real
> ACPI failure probably indicates that the system has bigger problems.
> I do have vague plans to make the driver more tolerant of failure to
> retrieve or validate instances, but haven't decided anything yet.
>
> Regards,
>
> James

Ok.

Armin Wolf

