Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175FE624F76
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiKKBTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKKBTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:19:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E391E4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:19:18 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7gkG3R4tzqSJ6;
        Fri, 11 Nov 2022 09:15:34 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 09:19:15 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 09:19:15 +0800
Message-ID: <b65fc60a-f7f6-61f9-050c-37d4df0e2433@huawei.com>
Date:   Fri, 11 Nov 2022 09:19:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] firmware: dmi-sysfs: Fix null-ptr-deref in
 dmi_sysfs_register_handle
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linmq006@gmail.com>
References: <20221017095342.2567-1-chenzhongjin@huawei.com>
 <Y205w1j7lc1a5EPS@kroah.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <Y205w1j7lc1a5EPS@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/11/11 1:49, Greg KH wrote:
> On Mon, Oct 17, 2022 at 05:53:42PM +0800, Chen Zhongjin wrote:
>> KASAN reported a null-ptr-deref error:
>>
>> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>> CPU: 0 PID: 1373 Comm: modprobe
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>> RIP: 0010:dmi_sysfs_entry_release
>> ...
>> Call Trace:
>>   <TASK>
>>   kobject_put
>>   dmi_sysfs_register_handle (drivers/firmware/dmi-sysfs.c:540) dmi_sysfs
>>   dmi_decode_table (drivers/firmware/dmi_scan.c:133)
>>   dmi_walk (drivers/firmware/dmi_scan.c:1115)
>>   dmi_sysfs_init (drivers/firmware/dmi-sysfs.c:149) dmi_sysfs
>>   do_one_initcall (init/main.c:1296)
>>   ...
>> Kernel panic - not syncing: Fatal exception
>> Kernel Offset: 0x4000000 from 0xffffffff81000000
>> ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> It is because previous patch added kobject_put() to release the memory
>> which will call  dmi_sysfs_entry_release() and list_del().
>>
>> However, list_add_tail(entry->list) is called after the error block,
>> so the list_head is uninitialized and cannot be deleted.
>>
>> Because entry is allocated by kzalloc() so the list.prev is NULL in
>> the error path. Check it in dmi_sysfs_entry_release() to avoid
>> deleting uninitialized list_head.
>>
>> Fixes: 660ba678f999 ("firmware: dmi-sysfs: Fix memory leak in dmi_sysfs_register_handle")
>>
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>>   drivers/firmware/dmi-sysfs.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
>> index 66727ad3361b..f8815eeed00c 100644
>> --- a/drivers/firmware/dmi-sysfs.c
>> +++ b/drivers/firmware/dmi-sysfs.c
>> @@ -557,9 +557,12 @@ static void dmi_sysfs_entry_release(struct kobject *kobj)
>>   {
>>   	struct dmi_sysfs_entry *entry = to_entry(kobj);
>>   
>> -	spin_lock(&entry_list_lock);
>> -	list_del(&entry->list);
>> -	spin_unlock(&entry_list_lock);
>> +	if (entry->list.prev != NULL) {
> You should not be poking around in a lock structure like this at all.
> Also the lock isn't held, so how do you know this is going to work?
>
> I suggest fixing up the original patch, perhaps reverting that instead?

It makes sense, but in fact the original patch did fix the memory leak.

I'm going to move kobject_put behind list_add_tail to keep consistency, 
because only after that the
entry initialization is complete.

Will send v2, thanks for your review!


Best,

Chen

> thanks,
>
> greg k-h
