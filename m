Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD4614EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKAP76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKAP7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:59:55 -0400
Received: from smtp72.iad3b.emailsrvr.com (smtp72.iad3b.emailsrvr.com [146.20.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA846460
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1667318392;
        bh=jkwakeBq1fnnuwEnGmhfLOr99f1JkOiZgTBQuf/26jA=;
        h=Date:Subject:To:From:From;
        b=W5extsFyRNYdnJNIna82TqBKFD84tG6tbNa6V6bmkefhmIl/gjGs05n/QE3jmpOaR
         2o6BlmhyBBBy0u85UeASbL9vUgr6xNIvn7/NN2KTDfzK9dEucBLbuYCsOdJAVFbb9y
         ESxo3babuiiYX+/okZr1XSrp11nmRPOndXi9YZqQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp2.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 49B8720163;
        Tue,  1 Nov 2022 11:59:51 -0400 (EDT)
Message-ID: <83f1aa93-bbd9-925e-a1d4-26729262a008@mev.co.uk>
Date:   Tue, 1 Nov 2022 15:59:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] comedi: Fix potential memory leak in comedi_init()
To:     shangxiaojing <shangxiaojing@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     hsweeten@visionengravers.com, zhangxuezhi1@coolpad.com,
        fmhess@users.sourceforge.net, linux-kernel@vger.kernel.org
References: <20221101032125.27337-1-shangxiaojing@huawei.com>
 <Y2CkW5EVLiLUoNWh@kroah.com>
 <32c291d7-0e87-ec1f-e2af-28d7f8ca0981@huawei.com>
 <5b8ee99d-2358-39c5-b663-2d1c80353639@mev.co.uk>
 <5344d255-5186-dc97-89f0-0b8c40f65324@huawei.com>
Content-Language: en-GB
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <5344d255-5186-dc97-89f0-0b8c40f65324@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: ddcb070e-9978-4bc2-9b22-ddd1806a1527-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 11:57, shangxiaojing wrote:
> 
> 
> On 2022/11/1 19:40, Ian Abbott wrote:
>> On 01/11/2022 06:16, shangxiaojing wrote:
>>>
>>>
>>> On 2022/11/1 12:45, Greg KH wrote:
>>>> On Tue, Nov 01, 2022 at 11:21:25AM +0800, Shang XiaoJing wrote:
>>>>> comedi_init() will goto out_unregister_chrdev_region if cdev_add()
>>>>> failed, which won't free the resource alloced in kobject_set_name().
>>>>> Call kfree_const() to free the leaked name before goto
>>>>> out_unregister_chrdev_region.
>>>>>
>>>>> unreferenced object 0xffff8881000fa8c0 (size 8):
>>>>>    comm "modprobe", pid 239, jiffies 4294905173 (age 51.308s)
>>>>>    hex dump (first 8 bytes):
>>>>>      63 6f 6d 65 64 69 00 ff                          comedi..
>>>>>    backtrace:
>>>>>      [<000000005f9878f7>] __kmalloc_node_track_caller+0x4c/0x1c0
>>>>>      [<000000000fd70302>] kstrdup+0x3f/0x70
>>>>>      [<000000009428bc33>] kstrdup_const+0x46/0x60
>>>>>      [<00000000ed50d9de>] kvasprintf_const+0xdb/0xf0
>>>>>      [<00000000b2766964>] kobject_set_name_vargs+0x3c/0xe0
>>>>>      [<00000000f2424ef7>] kobject_set_name+0x62/0x90
>>>>>      [<000000005d5a125b>] 0xffffffffa0013098
>>>>>      [<00000000f331e663>] do_one_initcall+0x7a/0x380
>>>>>      [<00000000aa7bac96>] do_init_module+0x5c/0x230
>>>>>      [<000000005fd72335>] load_module+0x227d/0x2420
>>>>>      [<00000000ad550cf1>] __do_sys_finit_module+0xd5/0x140
>>>>>      [<00000000069a60c5>] do_syscall_64+0x3f/0x90
>>>>>      [<00000000c5e0d521>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>
>>>>> Fixes: ed9eccbe8970 ("Staging: add comedi core")
>>>>> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
>>>>> ---
>>>>>   drivers/comedi/comedi_fops.c | 5 ++++-
>>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/comedi/comedi_fops.c 
>>>>> b/drivers/comedi/comedi_fops.c
>>>>> index e2114bcf815a..2c508c2cf6f6 100644
>>>>> --- a/drivers/comedi/comedi_fops.c
>>>>> +++ b/drivers/comedi/comedi_fops.c
>>>>> @@ -3379,8 +3379,11 @@ static int __init comedi_init(void)
>>>>>       retval = cdev_add(&comedi_cdev, MKDEV(COMEDI_MAJOR, 0),
>>>>>                 COMEDI_NUM_MINORS);
>>>>> -    if (retval)
>>>>> +    if (retval) {
>>>>> +        kfree_const(comedi_cdev.kobj.name);
>>>>> +        comedi_cdev.kobj.name = NULL;
>>>>>           goto out_unregister_chrdev_region;
>>>>> +    }
>>>>
>>>> A driver should never have to poke around in the internals of a cdev
>>>> object like this.  Please fix the cdev core to not need this if
>>>> cdev_add() fails.
>>
>> Or at least there should be a function that can be called to undo the 
>> allocations of kobject_set_name().
> 
> It's ok to add a pair function, but maybe only one place where used 
> cdev_add() need free name. Your mean all "kfree_const(name);" should be 
> replaced to the new function?
> 
>>
>>>>
>>> Hi,
>>>
>>> I had checked all 67 places that used cdev_add(), and only the 
>>> following 5 functions set the name before the cdev_add():
>>>
>>> 1. comedi_init(), will memleak and will be fixed by this patch.
>>> 2. hfi1_cdev_init(), won't memleak.
>>> 3. qib_cdev_init(), won't memleak.
>>> 4. uio_major_init(), won't memleak.
>>> 5. __register_chrdev(), won't memleak.
>>>
>>> As the result, I just fix the code in comedi_init(). Should I still 
>>> fix the cdev core code, which is free the name in cdev_add() fail path?
>>
>> I'm stuck trying to work out why hfi1_cdev_init() doesn't have the 
>> same problem when cdev_add() returns an error.
>>
> 
> Only user_add() calls the hfi1_cdev_init(), and will call user_remove() 
> if hfi1_cdev_init() failed. In user_remove(), hfi1_cdev_cleanup() will 
> call cdev_del().

No it won't.  hfi1_cdev_cleanup() only calls cdev_del() if device is 
non-null, but device will be null if the call to cdev_add() failed in 
hfi1_cdev_init().

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

