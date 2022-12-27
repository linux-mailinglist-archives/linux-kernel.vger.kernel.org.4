Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA03656FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiL0VbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiL0VbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:31:20 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B77325C9;
        Tue, 27 Dec 2022 13:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672176637; bh=56htlLHUcU+qWeQhLbsL8ptRSB512sH1ur2RjROHFv0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qB5clFHjXX3d/b6Lzf83twSzJQdvGjWD2S7wFGPaBic5eUBqTl5R/xovKgNaMKain
         RFpPO2PH6GzAewmyOJ2AU6JfJ81NLrtsuukOiVHMPzZx367lYgpYTvJU72yLjB3xk9
         6Ci4gd9EyieOj7q5Wu8VSponmwu9zBoXaO/98f2g9TTAbCQeKh5kxz+2VGX0fHj/R7
         TcBCMgXmC+VXx9jyK3XuwqNcS7cntKyc3eUrbuLsVrmKJJGXl4H9xa0T/Qh9VR+M36
         BnPvYR3eh+vk5HDMKzGQumlN4iFeCsbwl+7v+t2Cy8kbyFFj2vMQ6eyYOKGbPmfpM0
         5Jtfa0Za17nxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.190.3]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1oWFfa3l4M-00nAgK; Tue, 27
 Dec 2022 22:30:36 +0100
Message-ID: <1d0def42-11b7-0039-368d-d355f348767c@gmx.de>
Date:   Tue, 27 Dec 2022 22:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH linux-next v2] parisc: use strscpy() to instead of
 strncpy()
Content-Language: en-US
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>,
        james.bottomley@hansenpartnership.com, yang.yang29@zte.com.cn
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
References: <202212261840048448622@zte.com.cn>
 <2298026.kkTNVCUfUN@daneel.sf-tec.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <2298026.kkTNVCUfUN@daneel.sf-tec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fzFzyXibYGlFunT25rS5QA0JPUUmHCmc6BTRssFDg4sbaWZWOxU
 95p1lYwU9Lt3Yoi1vCqmJ3uuBc6xgle8dAV1u2nbHRHyAMI05/cTJSXZsdElLnIq/JlOoGO
 gw6q7z95yWa2oydYj/FNoG+WqdRFXW0uBkXrNcRlyeuutLjHsfYaziIz1esV0On5BPhWcPw
 2kEs+XQd3rSrC5FyuzNbA==
UI-OutboundReport: notjunk:1;M01:P0:Yrmu8I+tIOQ=;pKAqIZhx4/65Yn3POPk/3XM0NrY
 XwFYnErerMkCScZNllGiVmYIQcT1f+u8bNZtWDFtnyi9Eel7lVKZL4PWmEEhEYe91zxTN/DNk
 fF6YHESa6WXS/T4iMJXjDgnTtWXgsNiiQ/AMJ7A+ZihHcEQPEtFxYtrVVTagH+hdCuQZypeNo
 qZc9t90B4A+dLkCcOQPg3AtURSuloD80yD7rO6oCkrGYVXbmt6QeBamw0wPcRBmbF20U8Bm2p
 4GbZwhyQgtnIKnj8Aat2G5dVzzdWIL+6yZaruqs/h/JNpdg18Hvai+r0vpjcNFuR1fMPJlO60
 U4ubm8YdMnlWvQuqwYxs/XkK6eAiqTAmQjbgEATnIjDdWjiu97kjg+0IxusjOBQF7Hg67fNG4
 20621mfHpfaHBaTwdkKeh9PNO3JvSEKYMCqGVvIdFH5/6mIQ5toGfQRpU00OFQ66qsdQFQG0L
 yXMyUay1R3pVI3sSM16hCaSwZfKEm8SSxoe3sSeXDYWMj22n/ViyJAWzThrn2LAHnTETypli5
 +HJOXWbqKNpuyLkunn5H+PtHxojX0miItTLHnWqkVI100k9cXLlzhhcVmeFAl1nVjeSCSu1DD
 wRDijQSK4UZ7vx0k96KmE51epKUgHlv+S3P6GVSWDWfZN3kw1G85qpqaI8ubnMLeBMH73SlB9
 KMZwflq3QHRHaTejS0D9yQrfB7m6nAnb7A1ICLe/3vcgB/Cs5zCyMx+CgEztxexuMUx7PcUGt
 RYM+Ldi1yG0up09JDFBI8Q83n3oCl4pMcnv8LMcFW48aW25nCKwHchN0BTbAI8hJNyPsNrgy3
 vc309JZoC34/ihXfcSSRrxKmrLI9MVd6mnkcvvdDiqkI8GhkWNK5Wib2hXflS4kzNCIV3o565
 M19UuEle6TSoqckkfzKfIHomGxHbtjBH3ATURchk0CCg2WJ/7v1cEqrvpay1emH1BAGfcj4U9
 uKEEH/ZBdTd23FzCSkZaMd79pg8=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/22 08:47, Rolf Eike Beer wrote:
> Am Montag, 26. Dezember 2022, 11:40:04 CET schrieb yang.yang29@zte.com.c=
n:
>> From: Xu Panda <xu.panda@zte.com.cn>
>>
>> The implementation of strscpy() is more robust and safer.
>> That's now the recommended way to copy NUL-terminated strings.
>>
>> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
>> Signed-off-by: Yang Yang <yang.yang29@zte.com>
>> ---
>> change for v2
>>   - sizeof(in) is better and simplified, thanks for Helge Deller.
>> ---
>>   drivers/parisc/pdc_stable.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
>> index d6af5726ddf3..d3075445260b 100644
>> --- a/drivers/parisc/pdc_stable.c
>> +++ b/drivers/parisc/pdc_stable.c
>> @@ -274,8 +274,7 @@ pdcspath_hwpath_write(struct pdcspath_entry *entry,
>> const char *buf, size_t coun
>>
>>   	/* We'll use a local copy of buf */
>>   	count =3D min_t(size_t, count, sizeof(in)-1);
>> -	strncpy(in, buf, count);
>> -	in[count] =3D '\0';
>> +	strscpy(in, buf, sizeof(in));
>
> What is "count" now needed for? Looks like a write only variable at leas=
t in
> these hunks.

isn't count the return value?

Helge
