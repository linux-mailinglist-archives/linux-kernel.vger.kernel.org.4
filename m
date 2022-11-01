Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB1B614A24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKAL63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiKAL6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:58:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAFA632D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:58:03 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1pN53HxtzpW4Z;
        Tue,  1 Nov 2022 19:54:29 +0800 (CST)
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 19:58:01 +0800
Message-ID: <5344d255-5186-dc97-89f0-0b8c40f65324@huawei.com>
Date:   Tue, 1 Nov 2022 19:57:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] comedi: Fix potential memory leak in comedi_init()
To:     Ian Abbott <abbotti@mev.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <hsweeten@visionengravers.com>, <zhangxuezhi1@coolpad.com>,
        <fmhess@users.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <20221101032125.27337-1-shangxiaojing@huawei.com>
 <Y2CkW5EVLiLUoNWh@kroah.com>
 <32c291d7-0e87-ec1f-e2af-28d7f8ca0981@huawei.com>
 <5b8ee99d-2358-39c5-b663-2d1c80353639@mev.co.uk>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <5b8ee99d-2358-39c5-b663-2d1c80353639@mev.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/1 19:40, Ian Abbott wrote:
> On 01/11/2022 06:16, shangxiaojing wrote:
>>
>>
>> On 2022/11/1 12:45, Greg KH wrote:
>>> On Tue, Nov 01, 2022 at 11:21:25AM +0800, Shang XiaoJing wrote:
>>>> comedi_init() will goto out_unregister_chrdev_region if cdev_add()
>>>> failed, which won't free the resource alloced in kobject_set_name().
>>>> Call kfree_const() to free the leaked name before goto
>>>> out_unregister_chrdev_region.
>>>>
>>>> unreferenced object 0xffff8881000fa8c0 (size 8):
>>>>    comm "modprobe", pid 239, jiffies 4294905173 (age 51.308s)
>>>>    hex dump (first 8 bytes):
>>>>      63 6f 6d 65 64 69 00 ff                          comedi..
>>>>    backtrace:
>>>>      [<000000005f9878f7>] __kmalloc_node_track_caller+0x4c/0x1c0
>>>>      [<000000000fd70302>] kstrdup+0x3f/0x70
>>>>      [<000000009428bc33>] kstrdup_const+0x46/0x60
>>>>      [<00000000ed50d9de>] kvasprintf_const+0xdb/0xf0
>>>>      [<00000000b2766964>] kobject_set_name_vargs+0x3c/0xe0
>>>>      [<00000000f2424ef7>] kobject_set_name+0x62/0x90
>>>>      [<000000005d5a125b>] 0xffffffffa0013098
>>>>      [<00000000f331e663>] do_one_initcall+0x7a/0x380
>>>>      [<00000000aa7bac96>] do_init_module+0x5c/0x230
>>>>      [<000000005fd72335>] load_module+0x227d/0x2420
>>>>      [<00000000ad550cf1>] __do_sys_finit_module+0xd5/0x140
>>>>      [<00000000069a60c5>] do_syscall_64+0x3f/0x90
>>>>      [<00000000c5e0d521>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>
>>>> Fixes: ed9eccbe8970 ("Staging: add comedi core")
>>>> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
>>>> ---
>>>>   drivers/comedi/comedi_fops.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/comedi/comedi_fops.c 
>>>> b/drivers/comedi/comedi_fops.c
>>>> index e2114bcf815a..2c508c2cf6f6 100644
>>>> --- a/drivers/comedi/comedi_fops.c
>>>> +++ b/drivers/comedi/comedi_fops.c
>>>> @@ -3379,8 +3379,11 @@ static int __init comedi_init(void)
>>>>       retval = cdev_add(&comedi_cdev, MKDEV(COMEDI_MAJOR, 0),
>>>>                 COMEDI_NUM_MINORS);
>>>> -    if (retval)
>>>> +    if (retval) {
>>>> +        kfree_const(comedi_cdev.kobj.name);
>>>> +        comedi_cdev.kobj.name = NULL;
>>>>           goto out_unregister_chrdev_region;
>>>> +    }
>>>
>>> A driver should never have to poke around in the internals of a cdev
>>> object like this.  Please fix the cdev core to not need this if
>>> cdev_add() fails.
> 
> Or at least there should be a function that can be called to undo the 
> allocations of kobject_set_name().

It's ok to add a pair function, but maybe only one place where used 
cdev_add() need free name. Your mean all "kfree_const(name);" should be 
replaced to the new function?

> 
>>>
>> Hi,
>>
>> I had checked all 67 places that used cdev_add(), and only the 
>> following 5 functions set the name before the cdev_add():
>>
>> 1. comedi_init(), will memleak and will be fixed by this patch.
>> 2. hfi1_cdev_init(), won't memleak.
>> 3. qib_cdev_init(), won't memleak.
>> 4. uio_major_init(), won't memleak.
>> 5. __register_chrdev(), won't memleak.
>>
>> As the result, I just fix the code in comedi_init(). Should I still 
>> fix the cdev core code, which is free the name in cdev_add() fail path?
> 
> I'm stuck trying to work out why hfi1_cdev_init() doesn't have the same 
> problem when cdev_add() returns an error.
> 

Only user_add() calls the hfi1_cdev_init(), and will call user_remove() 
if hfi1_cdev_init() failed. In user_remove(), hfi1_cdev_cleanup() will 
call cdev_del().

Thanks,
-- 
Shang XiaoJing
