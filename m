Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B368CB82
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBGAza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGAz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE90322013
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 16:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675731280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xab6yaqQhUADgjEaX4jCYFge8g71VoEH5wyXFWZGIFs=;
        b=dZB6d+DVzz7DlVKlf+QTb8IYRKVhtTg4g6n0zJNu1tS/Crkc5Ne9ND2rObBR98AgU0ENXq
        QMKW+KfA7tiLVOWGTCnths5tUO//reOv2+lYrhx4Y1M1bZayfRkRzhkJvod/vrug0hx0fW
        cB9rMXAqlebs/Ct2cLiNqZ3qtYZXQRo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-80-W7WNbXSjMTK8HZmk76b_oQ-1; Mon, 06 Feb 2023 19:54:39 -0500
X-MC-Unique: W7WNbXSjMTK8HZmk76b_oQ-1
Received: by mail-pf1-f197.google.com with SMTP id v23-20020aa78097000000b005748c087db1so7171338pff.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 16:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xab6yaqQhUADgjEaX4jCYFge8g71VoEH5wyXFWZGIFs=;
        b=tf/pwZcC92tDk8wM3WJV+TLmSRHqL/dFan5svubMGnbYaTx4hRJ8nMKwyXKbl98WdC
         voARjkfSUhV15RmhSrSnWhcbf3J4J/bktr09GJ9hPm+VXbcXGwo5oAt3vLPgXbm1xlsb
         4u2I3HqvvP19rzeIrbOIWwY7yOS8vkXGxUY0gIRtormfTCr46fUbpXi7PvkOzmeB5Haa
         O/LEIB6LDaKXbJbW7r2ouyMSoyoNC4eaaJKtWoZQW3jRozRSCHyfdR1bQ7nxmBDsFjve
         4rEI5zEt+ANJeQcxjkuE2Z6vzS6dsMAYVRPQ3+iXrLn6wrm3zmy+jXlHCepOTKCJE1Fm
         dugw==
X-Gm-Message-State: AO0yUKW5KdgucRSd1fC+tddbQW3O47bcPlLUARp9UbyqzTNGGUNnDI2g
        GEWIoUklBo5O2SzViD/8uK1x7rw1OKpEgM0O2p9uwOf9xm39iuM/V1Vb+mpyhQ2TUxURuXbsMf7
        Df9ZY3JYCyAA8A1eaKKb17TzkEzuC1OxMGjY=
X-Received: by 2002:a17:90b:3511:b0:230:c41b:4d8d with SMTP id ls17-20020a17090b351100b00230c41b4d8dmr1277633pjb.16.1675731277434;
        Mon, 06 Feb 2023 16:54:37 -0800 (PST)
X-Google-Smtp-Source: AK7set8P3gWmrKE1AVwAcDsBacpeQIPvSoZcpc/5nSGEQJpN+YN5XOiP3VJ8Bhg1KzRCJ4TedcxS2w==
X-Received: by 2002:a17:90b:3511:b0:230:c41b:4d8d with SMTP id ls17-20020a17090b351100b00230c41b4d8dmr1277616pjb.16.1675731277089;
        Mon, 06 Feb 2023 16:54:37 -0800 (PST)
Received: from [10.72.13.183] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q7-20020a63ae07000000b004da5d3a8023sm6671549pgf.79.2023.02.06.16.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 16:54:36 -0800 (PST)
Message-ID: <06f51bab-42e1-975a-ad4f-6815c2063adb@redhat.com>
Date:   Tue, 7 Feb 2023 08:54:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] rbd: avoid double free memory on error path in
 rbd_dev_create()
Content-Language: en-US
To:     =?UTF-8?B?0J/QtdGC0YDQvtCy0LAg0J3QsNGC0LDQu9C40Y8g0JzQuNGF0LDQudC70L4=?=
         =?UTF-8?B?0LLQvdCw?= <n.petrova@fintech.ru>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <20230203141515.125205-1-n.petrova@fintech.ru>
 <CAOi1vP_7Oaw8O-p2X1xymzym1Xf_RZeN0u=SeE4Zbc2y+AfgYA@mail.gmail.com>
 <c01e807428894bef8fed628df0b8f4b6@fintech.ru>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <c01e807428894bef8fed628df0b8f4b6@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/02/2023 23:15, Петрова Наталия Михайловна wrote:
> Hi Ilya!
> Thanks for your response! I don't quite understand your idea and suggestion. The patch is designed to avoid double free memory. I explored the code again and suppose there is another situation for rbd_dev->rbd_client and rbd_dev->spec. Free memory of these pointers is possible only once in rbd_dev_free() function. In do_rbd_add() deallocation memory is only for rbd_opts: drivers/block/rbd.c 7157.

Hi Петрова,

If the rbd_dev_create() fails, for spec it will be freed in 
rbd_dev_create()->rbd_spec_put() first and then in do_rbd_add() it will 
call rbd_spec_put() again.

It won't trigger double free but this should generate a warning when the 
refcount underflow, because the refcount_dec_and_test() will warn and 
then return false when underflow happens.

The same for rbd_client.

Thanks,

- Xiubo

> Correct me if I'm wrong.
>
> Thanks,
> Natalia
>
> -----Original Message-----
> From: Ilya Dryomov <idryomov@gmail.com>
> Sent: Monday, February 6, 2023 2:59 PM
> To: Петрова Наталия Михайловна <n.petrova@fintech.ru>
> Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>; Jens Axboe <axboe@kernel.dk>; ceph-devel@vger.kernel.org; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; lvc-project@linuxtesting.org; Alexey Khoroshilov <khoroshilov@ispras.ru>
> Subject: Re: [PATCH] rbd: avoid double free memory on error path in rbd_dev_create()
>
> On Fri, Feb 3, 2023 at 3:15 PM Natalia Petrova <n.petrova@fintech.ru> wrote:
>> If rbd_dev_create() fails after assignment 'opts' to 'rbd_dev->opts',
>> double free of 'rbd_options' happens:
>> one is in rbd_dev_free() and another one is in do_rbd_add().
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 1643dfa4c2c8 ("rbd: introduce a per-device ordered workqueue")
>> Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>> ---
>>   drivers/block/rbd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c index
>> 04453f4a319c..ab6bfc352cde 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -5357,7 +5357,6 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
>>          if (!rbd_dev)
>>                  return NULL;
>>
>> -       rbd_dev->opts = opts;
>>
>>          /* get an id and fill in device name */
>>          rbd_dev->dev_id = ida_simple_get(&rbd_dev_id_ida, 0, @@
>> -5372,6 +5371,7 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
>>          if (!rbd_dev->task_wq)
>>                  goto fail_dev_id;
>>
>> +       rbd_dev->opts = opts;
>>          /* we have a ref from do_rbd_add() */
>>          __module_get(THIS_MODULE);
>>
>> --
>> 2.34.1
>>
> Hi Natalia,
>
> It seems like a similar issue is affecting rbd_dev->rbd_client and rbd_dev->spec.  Unlike rbd_dev->opts, they are ref-counted and I'm guessing that the verification tool doesn't go that deep.
>
> I'd prefer all three to be addressed in the same change, since it's the same error path.  Would you be willing to look into that and post a new revision or should I treat just this patch as a bug report?
>
> Thanks,
>
>                  Ilya

-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li

