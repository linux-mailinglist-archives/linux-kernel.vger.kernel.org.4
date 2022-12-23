Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D7E654D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiLWHza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiLWHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:55:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6DB31DCB;
        Thu, 22 Dec 2022 23:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671782113; bh=9XWdkzYBrIgElEtM3tR1kNnyRZn1eMogBcI4mhuPYX8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=X/MOFmCbfVokJs92huvsCHXQlUSx5PNHEx2incp0BoIVguq3Mcc9a7pYojDLZ4XiN
         n5Qf1QkSeVyuc69LPdioo3lcUHoZd4P1/5D7a9+v8CER57eqXxUSjaG3I9M8Ba4jLd
         wwr7GylamDdjl1XHjrgX5w4UCjQwucPYbUDMbLDwSJkT//k1onGzfO/QvNwP9oFWN4
         ruIyM4xdOWt4d5fF5v6ghIJ+/PUZ8PdP0XZHXxx5FJ8EUbrypHhw504ki/85GnJjs/
         +MYu4IH8peNqnOPrxjd00qXSYA+f0eh/IZb4RtHpr8/WZDvSCowC5UpbNpX5c830PX
         74LURZd6JXK2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.152.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1ox7430BVm-00zHjC; Fri, 23
 Dec 2022 08:55:13 +0100
Message-ID: <0fb8a86a-ca92-8d5f-99da-6815b2d5ec3e@gmx.de>
Date:   Fri, 23 Dec 2022 08:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH linux-next] parisc: use strscpy() to instead of strncpy()
Content-Language: en-US
To:     yang.yang29@zte.com.cn, james.bottomley@hansenpartnership.com
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
References: <202212231040562072342@zte.com.cn>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202212231040562072342@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IRxU7up7L4DJ/C+Ns0Fid0Iba8yLSTeiKbaQskmU/UwNrbenEu+
 8tPF2MD/n9eCSepBSOPETYM8zqmi6AXo0CySqo9IwKhfg0N1abdjiB1S1BMr2HQ/vVE8Uip
 CfFRuosACY7UI9/X4XRK/HrJ/56s0VzJDk11dd0eCWjP28d7MjLbZzU/iF8C4KYTeMyM1P3
 Y2frFeRsl3Cy0LEujP3BA==
UI-OutboundReport: notjunk:1;M01:P0:f+izm0NQ4C4=;fBIsGrToJ65nYWTYBnipugSu+2R
 iOPAWPVCJtMM4/Dud1qnYdzlfu4uJTDbHPsWDL8pzLqIThuug4hbD9bI3nyCQEfzl8dVP+oU1
 7LPz2ECp1FJ/aSduL6giWKPHLhyN1kbcb6ZNUvDvg2nEt/y2kefhFP5GuL3y/32YrhKDwHWdu
 Xz32FNnVL8wW9zkuZXLvgk5hXnIEcdXip7aqdiyEpK1Qc1NpNIeeeSAXfvz7BUxYxmKHAUhYe
 pMkx+rZY761cDKcyTf6Rh56Gkr7EKl1mNL4Q5Sqz1pq4LOJLsHpGRGH9PcE6bolH1YLg5EkTX
 UpIuE6+sgCRdz2Yucg2/yX5GcclAyd/7eDMUMA9hnqzrBfSdmq7A0xY+WGMxbgDYd3lFLBbXt
 ZbvDrI9NdUE9A71gR5bj1IL8xyH6+geZ+VrKvqLwsGkoioioVj/gRJORVQXOE/1YN5u8kueBt
 +ycw972ozaUWxvxggFbdGc1iVZ0XBsOpwNKmKD9cBPnzXPcfTmNHGjdJLLemG/rhmPUfhSHF8
 4BUOidB/JLiU817rJ9fGpfVHOXFUSsKKAjf5lW0pe4/igFra3xgKuTTSGKgX6POiLLd9UuDFs
 T27/JSMGyQyqQj3FZ7X+rm8viqOdc/+9qYptzsy6ml1JFkwjxZFgzbP8tFzUHP3qdcOmgRCAB
 0TVrb3MxWzszlXVYAFFBYyGHc1NoK/PflLEkroNzxecDRgpLjAWXWwoxofr7cZTAlO4LhNsry
 JazrbasM9ogcGNk8HLTg0joB5xh7AY2N8zPTVfXZsGxFWSI9eebexXnyZE2RuMvIAfKSMY8Zk
 L5oWJOumtzaxfhxUqWKpVzMhrABipFoDstQqo6a2CuRFomcoaSfMqKJ08qCscvA8o4L7ygzmx
 3ht27OmqwOENYepMj7k2do4pf/daVtYuQh5CGkti+Ul1UnpNlPC/LGMeLVjnGVmWR21lYe8UR
 EoT08XFzFwo1wKjjPsXbCtQ0TcE=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/22 03:40, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.

Thanks for your patch, but....

> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>   drivers/parisc/pdc_stable.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
> index d6af5726ddf3..403bca0021c5 100644
> --- a/drivers/parisc/pdc_stable.c
> +++ b/drivers/parisc/pdc_stable.c
> @@ -274,8 +274,7 @@ pdcspath_hwpath_write(struct pdcspath_entry *entry, =
const char *buf, size_t coun
>
>   	/* We'll use a local copy of buf */
>   	count =3D min_t(size_t, count, sizeof(in)-1);
> -	strncpy(in, buf, count);
> -	in[count] =3D '\0';
> +	strscpy(in, buf, count + 1);

could you resend it somewhat simplified, e.g.
strscpy(in, buf, sizeof(in));


>
>   	/* Let's clean up the target. 0xff is a blank pattern */
>   	memset(&hwpath, 0xff, sizeof(hwpath));
> @@ -388,8 +387,7 @@ pdcspath_layer_write(struct pdcspath_entry *entry, c=
onst char *buf, size_t count
>
>   	/* We'll use a local copy of buf */
>   	count =3D min_t(size_t, count, sizeof(in)-1);
> -	strncpy(in, buf, count);
> -	in[count] =3D '\0';
> +	strscpy(in, buf, count + 1);

same here

>
>   	/* Let's clean up the target. 0 is a blank pattern */
>   	memset(&layers, 0, sizeof(layers));
> @@ -756,8 +754,7 @@ static ssize_t pdcs_auto_write(struct kobject *kobj,
>
>   	/* We'll use a local copy of buf */
>   	count =3D min_t(size_t, count, sizeof(in)-1);
> -	strncpy(in, buf, count);
> -	in[count] =3D '\0';
> +	strscpy(in, buf, count + 1);

and here

>
>   	/* Current flags are stored in primary boot path entry */
>   	pathentry =3D &pdcspath_entry_primary;

