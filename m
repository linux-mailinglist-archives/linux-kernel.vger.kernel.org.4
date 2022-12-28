Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7046573A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiL1H3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL1H3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:29:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA1EA6;
        Tue, 27 Dec 2022 23:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672212537; bh=6kFiEmAt3E+SY2q1pR4B7vFAm3bFbsURWe5eJo6564g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dtufoGCa2A4ZTS8/r3Zgt2C0n50ZxDgbxt23/YBvGW6eL3T5F3IkJI7jsPu/3Qcb+
         qJIihTekuOdLcbo33zv9paOCrHqvpkgk1OpJOA+5rkXkKgIiXBGOa4mrB3Z0Yx0zbe
         CROFNyhRSYAMLmcsFcloVm5tkikkVQ9gKGUaa679yMPVF3sEpfo+vMO3YsHfmqarpK
         P1Kyylc8pg36LwpR6dwt27X290CjWikS2wll9rTAqX0IC7p4KOwUQ6Jc8oaFR7ptX9
         ay0oWwiEUL8iGSOUMJsKPQpD1Idci1AodSHzKe4IXhaFzn9NMDDZxy9iaAw8X1PyCZ
         pc1DlYjQTMFdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.184.137]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHG8m-1p5ysT16TQ-00DIAs; Wed, 28
 Dec 2022 08:28:57 +0100
Message-ID: <241784a8-713f-5cf8-75d0-7ce0c0bc7279@gmx.de>
Date:   Wed, 28 Dec 2022 08:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH linux-next] parisc: use strscpy() to instead of strncpy()
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        yang.yang29@zte.com.cn
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
References: <202212231040562072342@zte.com.cn>
 <0fb8a86a-ca92-8d5f-99da-6815b2d5ec3e@gmx.de>
 <eaad272203baa65ad65ac2206e5197595c88508e.camel@HansenPartnership.com>
 <279ea596-6a20-0bb8-39c3-67b45d7425a6@gmx.de>
 <ca6e40fff619aa16cb178382f5404d047ed08f3c.camel@HansenPartnership.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <ca6e40fff619aa16cb178382f5404d047ed08f3c.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1bwZVkUzZcDza0DIFcB5W7Z9TvkgixlLPmgKhErGJv8vUU9QPRX
 uvBUL7cdBhgT4Ij1vChb++w5ukVjbkJ5pX/ciHJs/fwddZtRRicZAnbqLHBv1ywzQN23VeN
 Fr/HlDiZqqeUY2UibnyN5CdzD+MHE55TGbOOv/fUL32MMhh1r7qqRPsAQrPis90BNX2rCgk
 Gc06xe5Wo3uI9oj1u7fwA==
UI-OutboundReport: notjunk:1;M01:P0:/PP6Y0hgJnI=;YLgA2M4DbSQMZmHeJs/CkHzREZ3
 GX+ADUERQHGbMQmOxtB0V/x3oYLCkTVSe5v1aQGF1eHZHttUumTZcK8L+RuSz/LUKCxY/OJfL
 WDEppGSrvMtgHVBpQExOxat0bLlUG1xmq06ZPhSqBesETXI0HodWruj3F/aRh9wyfEpT9K27a
 L+XsizUx9aR0zfAueo9k0/PTgF4m3CbSyOqADeLtdqrZgf31X4d95UHFZCTQJ4iO75V3K+3hz
 CBdiWnq4U0oghCPlolE3c5Lhgb2tkzYfGhcYeX5EevZG41TTcuRK+rKXZoYe59fnyfEb3bBOA
 fzSDx0ouVmhGJf9ID/XfURIBQ5P/3qNaiEnd2XRvfMn3tQgCvw+wz+DOGiikfRhSaehS0g8nH
 blec4FVnAe2CDeYm97i+ra57K09HztO0fELadxsxwv+APPjiN4UOPNYk6zn+59u5gAX3ssaE5
 lwpVRlMqfY2nUi7FGWyUprV9IbcJXV/UV4b0sMp3gHT5vfWfhwjWQI4/60vpIJxfoikRzQNCV
 8ERnEY1wLavbP4HMpX9y1e3K/aDCob2T9l5ivHdp4NUXOH86Da4SRKZQwnKtFbq7+FUMbdsew
 brDbWoVHkZYGjLeFxSjrmLYsTFepfQCwcRIgaV607aaFv4z6vxg3B9MNpaCkBkgTMuLzxjHyp
 0StTj3bF21miiV5Ki7oeiPArOw5+V2x7VQ36InZbF6IjMfb8d4ZZgE2yrZpYOO+M5qnCFmyP/
 DWMyOi3wQzkNZbVXSAtmFz94tO0ti0+ff0e6qQHTN+RdprjgribGFtWW55oZnGp9kGbp1QdZV
 3cIzRW8rwaO8qAbUbTqbfmTFKK+Yj/v2oDjDJU2pzbyvEEy0Z05ifLByMUp8T3PRYY090esoh
 KnUGBdi25Ex1Jzom+4KIXuBbTgRo2qaQUW1jcd7dp3UTCYX3fkrtcbL7lJwqCg8tdwgz2OAY7
 PDGkJ3m2nQ+8UP23b9eQCnjWzHo=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/22 23:43, James Bottomley wrote:
> On Tue, 2022-12-27 at 22:38 +0100, Helge Deller wrote:
>> Hi James,
>>
>> On 12/27/22 13:38, James Bottomley wrote:
>>> On Fri, 2022-12-23 at 08:55 +0100, Helge Deller wrote:
>>>> On 12/23/22 03:40, yang.yang29@zte.com.cn=C2=A0wrote:
>>>>> From: Xu Panda <xu.panda@zte.com.cn>
>>>>>
>>>>> The implementation of strscpy() is more robust and safer.
>>>>> That's now the recommended way to copy NUL-terminated strings.
>>>>
>>>> Thanks for your patch, but....
>>>>
>>>>> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
>>>>> Signed-off-by: Yang Yang <yang.yang29@zte.com>
>>>>> ---
>>>>>  =C2=A0=C2=A0 drivers/parisc/pdc_stable.c | 9 +++------
>>>>>  =C2=A0=C2=A0 1 file changed, 3 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/parisc/pdc_stable.c
>>>>> b/drivers/parisc/pdc_stable.c
>>>>> index d6af5726ddf3..403bca0021c5 100644
>>>>> --- a/drivers/parisc/pdc_stable.c
>>>>> +++ b/drivers/parisc/pdc_stable.c
>>>>> @@ -274,8 +274,7 @@ pdcspath_hwpath_write(struct pdcspath_entry
>>>>> *entry, const char *buf, size_t coun
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* We'll use =
a local copy of buf */
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0count =3D min=
_t(size_t, count, sizeof(in)-1);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strncpy(in, buf, count);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0in[count] =3D '\0';
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strscpy(in, buf, count + =
1);
>>>>
>>>> could you resend it somewhat simplified, e.g.
>>>> strscpy(in, buf, sizeof(in));
>>>
>>> I don't think you can: count is the size of buf, if that's <
>>> sizeof(in) you've introduced a write beyond end of buffer.=C2=A0 In fa=
ct
>>> sysfs tends to pass pages as buffers, so there's no actual problem,
>>> but if that ever changed ...
>>
>> Huh?... he doesn't change "count", so what's wrong with the latest
>> patch?
>
> the array buf[] is actually buf[count], so if count < 64 then
> sizeof(buf) < sizeof(in) and you're copying whatever is after buf on
> the stack or wherever it comes from. The amount you copy into in[]
> truly has to be the smaller of count and sizeof(in).  These are file
> operations, so you shouldn't rely on buf[] being null terminated

Ok, the main point I missed was that buf[] might not be null terminated.
Thanks for the explanation.

Yang & Xu, no need to resend the patch. I'll take your v1 version.

Thanks!
Helge

> (kernfs ensures it is, but it's a dangerous thing to rely on in the
> face of someone trying to exploit a stack smashing attack).
>
> James
>

