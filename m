Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3686F639340
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKZCF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZCF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:05:26 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A340957B6C;
        Fri, 25 Nov 2022 18:05:23 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJw66650WzmW57;
        Sat, 26 Nov 2022 10:04:46 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 10:05:21 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 10:05:21 +0800
Subject: Re: [PATCH] powercap: fix possible name leak while device_register()
 fails
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20221112094048.3614365-1-yangyingliang@huawei.com>
 <CAJZ5v0g6bct5pTruxHjjJPQpwDNR8WgqhLWaZWo8NKeRH3n6iw@mail.gmail.com>
 <Y35zwffl7bUdjs93@kroah.com>
 <b4fe247b-0980-40ea-bc69-0430e3b18320@huawei.com>
 <CAJZ5v0j+M79zD4Tsskkpsq8gyFQ8enjoZh-f54qOu1Rs_5tojA@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <b33cd789-eec7-f8c0-beb3-66b9c9e85a8e@huawei.com>
Date:   Sat, 26 Nov 2022 10:05:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j+M79zD4Tsskkpsq8gyFQ8enjoZh-f54qOu1Rs_5tojA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/26 2:45, Rafael J. Wysocki wrote:
> On Thu, Nov 24, 2022 at 3:16 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>>
>> On 2022/11/24 3:25, Greg Kroah-Hartman wrote:
>>> On Wed, Nov 23, 2022 at 08:00:14PM +0100, Rafael J. Wysocki wrote:
>>>> On Sat, Nov 12, 2022 at 10:42 AM Yang Yingliang
>>>> <yangyingliang@huawei.com> wrote:
>>>>> If device_register() returns error, the name allocated by
>> Sorry,
>> I didn't describe clearly here, it's not only after device_register()
>> failure, but also in the error path before register, the name is not
>> freed, see description below.
> So you would need to update the changelog at least.  But see below.
>
>>>>> dev_set_name() need be freed. In technical, we should call
>>>>> put_device() to give up the reference and free the name in
>>>>> driver core, but in some cases the device is not intizalized,
>>>>> put_device() can not be called, so don't complicate the code,
>>>>> just call kfree_const() to free name in the error path.
>>>>>
>>>>> Fixes: 75d2364ea0ca ("PowerCap: Add class driver")
>>>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>>>> ---
>>>>>    drivers/powercap/powercap_sys.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
>>>>> index f0654a932b37..11e742dc83b9 100644
>>>>> --- a/drivers/powercap/powercap_sys.c
>>>>> +++ b/drivers/powercap/powercap_sys.c
>>>>> @@ -572,6 +572,7 @@ struct powercap_zone *powercap_register_zone(
>>>>>    err_name_alloc:
>>>>>           idr_remove(power_zone->parent_idr, power_zone->id);
>>>>>    err_idr_alloc:
>>>>> +       kfree_const(dev_name(&power_zone->dev));
>>>>>           if (power_zone->allocated)
>>>>>                   kfree(power_zone);
>>>>>           mutex_unlock(&control_type->lock);
>>>>> @@ -622,6 +623,7 @@ struct powercap_control_type *powercap_register_control_type(
>>>>>           dev_set_name(&control_type->dev, "%s", name);
>>>>>           result = device_register(&control_type->dev);
>>>>>           if (result) {
>>>>> +               kfree_const(dev_name(&control_type->dev));
>>>> Why is it necessary to free a device name explicitly after a failing
>>>> device_register()?
>> powercap_register_zone()
>> {
>>       ...
>>       dev_set_name() // allocate name
>>       ...
>>       if (!power_zone->constraints)
>>           goto err_const_alloc; //the name is leaked in this path
>>       ...
>>       if (!power_zone->zone_dev_attrs)
>>           goto err_attr_alloc; //the name is leaked in this path
>>       ...
>>       if (result)
>>           goto err_dev_ret; //the name is leaked in this path
>>
>>       result = device_register(&power_zone->dev);
>>       if (result)
>>           goto err_dev_ret;//put_device() is not called, the name is
>> leaked in this path
>>       ...
>> err_dev_ret:
>>       kfree(power_zone->zone_dev_attrs);
>> err_attr_alloc:
>>       kfree(power_zone->constraints);
>> err_const_alloc:
>>       kfree(power_zone->name);
>> err_name_alloc:
>>       idr_remove(power_zone->parent_idr, power_zone->id);
>> err_idr_alloc:
>>       if (power_zone->allocated)
>>           kfree(power_zone);
>> }
> So can't the dev_set_name() be reordered closer to device_register(),
> so it is not necessary to worry about freeing the name?
Just move dev_set_name() closer to device_register() is not enough to free
the name, it should call put_device() after device_register() failure. I 
will try
this.
>
>>>> If it is really necessary, then there is a problem in
>>>> device_register() itself AFAICS, because it uses dev_set_name() at
>>>> least in the dev->init_name present case.
>> When the dev_set_name() called in device_register(), if register fails, the
>> name is freed in its error path. But in this case, dev_set_name() is called
>> outside the register, it needs call put_device() to free the name.
> In any case, device_register() needs to take care of it anyway,
> because it uses dev_set_name() itself in the dev->init_name case,
> doesn't it?
Yes, it's right.

Thanks,
Yang
>
> .
