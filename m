Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D28565700B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiL0ViW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiL0ViT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:38:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D552AEE;
        Tue, 27 Dec 2022 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672177089; bh=keIeliYcd8sxEhx8+27XdCyPKZIok/NRhLRBs3q1Ogg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=E18PPFYQcFPYL+wdtQS24x0woc5EUIXe8IU7TGlLLYk20cXE+5IMRGNXa7EvJ8839
         bp4GqnOI/5mx/9C66YqeHJTnrn17nW77eWm5g9eDUXHf+Fls/PMt/THa/QMTh27Z/a
         y7tEMrww9vJGJR/5ILPrQwbQouglP9ip5rzRGQKIbml0lQaM8VRz1HA6JQdcpFU4sP
         /6TyQHTnplhpUdsO9plyVK5dI8TUrGL6EKHuH6b6LW4Lqv8XCIGDQ5aMYZ4EmltBOd
         WZND8kHmeoFAaz6oCzfL2B20aUQDJjHJlRDOl9d2dvdd43at7siyzaFWrQPumnW/Vi
         10m8ocvYVSEwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.190.3]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bjy-1omh0I3RZm-017z96; Tue, 27
 Dec 2022 22:38:08 +0100
Message-ID: <279ea596-6a20-0bb8-39c3-67b45d7425a6@gmx.de>
Date:   Tue, 27 Dec 2022 22:38:04 +0100
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
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <eaad272203baa65ad65ac2206e5197595c88508e.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+NvjDV/A5UhPQPx3tiLXcr1ycyuSq3KhZvBJrFWkiLVBQfUIYBQ
 RvO9FK/53FpYskPVI9PLS+CoobgKUB2dg1aI+mAAFsbQKSx1RaweENZ/vLvm296kmexabQP
 OP5jzxZnxZdy48ILp56o3BGOzh6Am77vr5fAFQ9MH3V/Q2uGj4AkTN3h5Cxe3+WMVbjPTAk
 aMVNQzFFWBkstmE7tWSGA==
UI-OutboundReport: notjunk:1;M01:P0:0C+5ALWlcIg=;KivZwQnYs/9b8eKt/1r4YK3SD/c
 mLI8L0bkXOcoahlENooMjy0NcFWzKOqE83KoyolhZ9CTrkMx7MsmcDmySObiGdNWjFwQ3f/Ym
 /qpdrgmaldeHve+uI2HO3QttVjcRBkaoENIHxsC0ep14MSzo104djof2oVFgeCsRE9OZgQN5G
 junkG5oWmWSrwOEca2eqWx6u3orXZs5qDy3I18FvQccaKPDb8M2I6ZWuSZhb/zF1HOjTYUJcj
 wASlIIAbo4QsIt9Vrq1o/uYO+4giocebjfQXa7BmdayDuB8Rtwal5ABBaNCSgucgPOP8tHsLJ
 gRcVZOR65PAHWPJflwB85yj2b02m0f6hcJiKnjDeqMMVaXk6tZLvhdAhjWQQhIrlIJaD9CQZo
 n0bxmIL6Dz/R4g2gXOTlJARMB78BXcUvhCNB8fWzxSkjifOON/phEzaaji7eszAZ5g83zAgmB
 q2Bq9aLCrhMInXLj1Wjw4j9QWAPDBWKUt2f510NW2Ro8Otu5O2GDzl5twQAUzmtRhvFXnQw5j
 8dOdDW7AX3DpIEbn1g9D6WGEHF15zUCmzt48NVOQbirgK5KGmiP2xW4e2hoNutrGIa5VFABEq
 Kh9gsML08nAHvN4bTHeMYIFXkrXn5/4o7awp0HR1zP+w23gnbXeuurlfBfbe88+tWDbrLh7Uo
 xadbkTXmsTH9sfdv4bRMQyjXCYh/6jKvwZ1pWfWxE+sVM57jG3U665RIqxZaXBLErIdpvoG0o
 cXw2pUVpqRfkKmKfp0zX0vWSHDHSqyBfbpJ8OLN0xU/Od3DTveoS9JhjwAAR5ty3cm3P1pY6S
 rlI6X40w1JNAgAqQP7o416qREMkNI40ZMPiRB0y6E68CmhzYyXl/t/Qggi0IeYlciiwDFG/vP
 yIzTTV53iIl41xoC3eKzpXQYkb2gj4sW5BfQGMfDzcRwCy6HASGLixp2ocX/ps7B9sMxiJzOm
 emNTdYxE4y7M/ZPMRjOf/4Qqfkg=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 12/27/22 13:38, James Bottomley wrote:
> On Fri, 2022-12-23 at 08:55 +0100, Helge Deller wrote:
>> On 12/23/22 03:40, yang.yang29@zte.com.cn=C2=A0wrote:
>>> From: Xu Panda <xu.panda@zte.com.cn>
>>>
>>> The implementation of strscpy() is more robust and safer.
>>> That's now the recommended way to copy NUL-terminated strings.
>>
>> Thanks for your patch, but....
>>
>>> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
>>> Signed-off-by: Yang Yang <yang.yang29@zte.com>
>>> ---
>>>  =C2=A0 drivers/parisc/pdc_stable.c | 9 +++------
>>>  =C2=A0 1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/parisc/pdc_stable.c
>>> b/drivers/parisc/pdc_stable.c
>>> index d6af5726ddf3..403bca0021c5 100644
>>> --- a/drivers/parisc/pdc_stable.c
>>> +++ b/drivers/parisc/pdc_stable.c
>>> @@ -274,8 +274,7 @@ pdcspath_hwpath_write(struct pdcspath_entry
>>> *entry, const char *buf, size_t coun
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* We'll use a local =
copy of buf */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0count =3D min_t(size_=
t, count, sizeof(in)-1);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strncpy(in, buf, count);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0in[count] =3D '\0';
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strscpy(in, buf, count + 1)=
;
>>
>> could you resend it somewhat simplified, e.g.
>> strscpy(in, buf, sizeof(in));
>
> I don't think you can: count is the size of buf, if that's < sizeof(in)
> you've introduced a write beyond end of buffer.  In fact sysfs tends to
> pass pages as buffers, so there's no actual problem, but if that ever
> changed ...

Huh?... he doesn't change "count", so what's wrong with the latest patch?

Helge
