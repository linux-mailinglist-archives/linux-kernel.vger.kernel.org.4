Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BA96B2536
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCINYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjCINYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:24:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130D19C41
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678368181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yhh05HEeTynj++ObYTl6qMBxPge98QWiHU+ULkQSrwM=;
        b=NR1s9O0TxhdLqPQ4bjwTT7QA6Qeg4aKGo1qkLP3LWDhGdK3FYj85DEbIQMYFMKHIpvoh/Z
        61HqdTYbhzWnEtZETsfDm+QD/seR3/mB5jq+XtHpRd14zb6JQ/4SMx2t2p5h9ETSrgq2b1
        n2/t+rcRohMBajUy3K67vFrUI+/jDGY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-h_VLKafaMNC_0U4vN--noQ-1; Thu, 09 Mar 2023 08:23:00 -0500
X-MC-Unique: h_VLKafaMNC_0U4vN--noQ-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a7bc847000000b003e00be23a70so2377988wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678368179;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yhh05HEeTynj++ObYTl6qMBxPge98QWiHU+ULkQSrwM=;
        b=kdqYKdz7aMrJGFs8MoRO1ibJe0zUkL3rmBdtvjNgBFE96XD/vvbEIHJJg1Lpw/7af6
         gmtnGQjcbb3CeBn0YQ6rlvE1eb9IBK9iZTo+BAZpAIYWXKPNPrxgdDfh7ey7X0BysP6G
         ph92MZIYe1DLo3+pr2SOAMXBIDBs935/UKsTjFh9/Hf0pJPY8R64d7Cxgpf532gVoEn5
         cKHBenYQVRLpgoGl8/SbJTBNNQaBIJdHq+uVMYHRaDKZNh+B/3Pslz2ak4B/84BPt2jK
         Y0uylgtACk9NVkHTWLnEoCW9p9dzmwTVpNnr5JyVbBwm5L6kLBN9F1s0lBMXo5xoiznd
         tNgg==
X-Gm-Message-State: AO0yUKWA8ESamKTXP6XlkPz7hQ5G88NkIWjRNLs3FpXhJ2s3Ogl0VDGM
        DQgOQ88uSCI9A9CczdDDYD8e537P9e5AiYK/PUQfuelU5DziWn9ocZ4xQ3luhoCs/eCU3aTYUu+
        xli75IeeWDgFJCLLPZTu5pkNm
X-Received: by 2002:a5d:6604:0:b0:2c7:d7e:4c6c with SMTP id n4-20020a5d6604000000b002c70d7e4c6cmr12864106wru.44.1678368178938;
        Thu, 09 Mar 2023 05:22:58 -0800 (PST)
X-Google-Smtp-Source: AK7set/ZYO/c53IQo1unP9hzEw3MBcOJ/D9vBXdr4gD0cfHk7JyBlZHSLClP55Q8+cgLUagfjU8x/w==
X-Received: by 2002:a5d:6604:0:b0:2c7:d7e:4c6c with SMTP id n4-20020a5d6604000000b002c70d7e4c6cmr12864095wru.44.1678368178535;
        Thu, 09 Mar 2023 05:22:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:5200:a73:3e7e:12c:b175? (p200300cbc70252000a733e7e012cb175.dip0.t-ipconnect.de. [2003:cb:c702:5200:a73:3e7e:12c:b175])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c315300b003db0bb81b6asm2820877wmo.1.2023.03.09.05.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 05:22:58 -0800 (PST)
Message-ID: <42d864d6-6517-6601-c9c9-e06f7b731314@redhat.com>
Date:   Thu, 9 Mar 2023 14:22:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: fix potential invalid pointer dereference in
 kmemdup()
Content-Language: en-US
To:     Xujun Leng <lengxujun2007@126.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <fedd5372-2376-a354-b465-c6cbb930352e@redhat.com>
 <20230309100415.2382-1-lengxujun2007@126.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230309100415.2382-1-lengxujun2007@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.23 11:04, Xujun Leng wrote:
>> On 09.03.23 07:46, Xujun Leng wrote:
>>>> On 07.03.23 10:03, Xujun Leng wrote:
>>>>> If kmemdup() was called with src == NULL, then memcpy() source address
>>>>> is fatal, and if kmemdup() was called with len == 0, kmalloc_track_caller()
>>>>> will return ZERO_SIZE_PTR to variable p, then memcpy() destination address
>>>>> is fatal. Both 2 cases will cause an invalid pointer dereference.
>>>>>
>>>
>>>> "fix" in subject implies that there is actually a case broken. Is there,
>>>> or is this rather a "sanitize" ?
>>> Yes, I agree that word "sanitize" is a better choice.
>>> And no, I don't find an actually case but in my test code as follow:
>>>
>>> #include <linux/module.h>
>>> #include <linux/string.h>
>>> #include <linux/slab.h>
>>> #include <linux/printk.h>
>>> #include <linux/err.h>
>>>
>>> /*
>>>    * Test cases for kmemdup() and memdup_user().
>>>    */
>>> enum {
>>> 	TC_KMEMDUP_ARG0_NULL, /* i.e. kmemdup(NULL, 5, GFP_KERNEL) */
>>> 	TC_KMEMDUP_ARG1_ZERO, /* i.e. kmemdup("12345", 0, GFP_KERNEL) */
>>>
>>> 	TC_MEMDUP_USER_ARG0_NULL, /* i.e. memdup_user(NULL, 5) */
>>> 	TC_MEMDUP_USER_ARG1_ZERO  /* i.e. memdup_user("12345", 0) */
>>> };
>>>
>>> static int test_case;
>>> static const char *test_func_name[] = {"kmemdup", "memdup_user"};
>>> static void *ptr;
>>>
>>> module_param(test_case, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
>>>
>>> static void *kmemdup_arg0_null(void)
>>> {
>>> 	return kmemdup(NULL, 5, GFP_KERNEL);
>>> }
>>>
>>> static void *kmemdup_arg1_zero(void)
>>> {
>>> 	return kmemdup("12345", 0, GFP_KERNEL);
>>> }
>>>
>>> static void *memdup_user_arg0_null(void)
>>> {
>>> 	return memdup_user(NULL, 5);
>>> }
>>>
>>> static void *memdup_user_arg1_zero(void)
>>> {
>>> 	return memdup_user("12345", 0);
>>> }
>>>
>>> static int check_ptr(void)
>>> {
>>> 	if (ZERO_OR_NULL_PTR(ptr)) {
>>> 		printk(KERN_ERR "test case %d: %s failed, PTR_ERR(ptr) = %ld\n",
>>> 				test_case, test_func_name[test_case / 2], PTR_ERR(ptr));
>>> 		return -EINVAL;
>>> 	}
>>> 	
>>> 	if (IS_ERR(ptr)) {
>>> 		printk(KERN_ERR "test case %d: %s failed, PTR_ERR(ptr) = %ld\n",
>>> 				test_case, test_func_name[test_case / 2], PTR_ERR(ptr));
>>> 		return PTR_ERR(ptr);
>>> 	}
>>>
>>> 	printk(KERN_INFO "mm-util test module loaded.\n");
>>>
>>> 	return 0;
>>> }
>>>
>>> static int __init memdup_user_test_init(void)
>>> {
>>> 	if (test_case < 0 || test_case > TC_MEMDUP_USER_ARG1_ZERO) {
>>> 		printk(KERN_INFO "invalid test case %d\n", test_case);
>>> 		return -EINVAL;
>>> 	}
>>>
>>> 	printk(KERN_INFO "test case: %d\n", test_case);
>>>
>>> 	switch (test_case) {
>>> 	case TC_KMEMDUP_ARG0_NULL:
>>> 		ptr = kmemdup_arg0_null();
>>> 		break;
>>> 	case TC_KMEMDUP_ARG1_ZERO:
>>> 		ptr = kmemdup_arg1_zero();
>>> 		break;
>>>
>>> 	case TC_MEMDUP_USER_ARG0_NULL:
>>> 		ptr = memdup_user_arg0_null();
>>> 		break;
>>>
>>> 	case TC_MEMDUP_USER_ARG1_ZERO:
>>> 		ptr = memdup_user_arg1_zero();
>>> 		break;
>>> 	
>>> 	default:
>>> 		/* should be never happend */
>>> 		ptr = NULL;
>>> 		break;
>>> 	}
>>>
>>> 	return check_ptr();
>>> }
>>>
>>> static void __exit memdup_user_test_exit(void)
>>> {
>>> 	if (ptr) {
>>> 		kfree(ptr);
>>> 		ptr = NULL;
>>> 	}
>>>
>>> 	printk(KERN_INFO "mm-util test module exited.\n");
>>> }
>>>
>>> module_init(memdup_user_test_init);
>>> module_exit(memdup_user_test_exit);
>>>
>>> MODULE_LICENSE("GPL");
>>>
>>> Build the code as module, and run the module in QEMU ARM64, with different
>>> test case(pass 0,1,2,3 to moddule parameter "test_case"), get follow the
>>> results:
>>>
>>> root@qemu-ubuntu:~# modprobe memdup_kernel_user_test test_case=0
>>> [  142.979506] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>>> [  142.983171] Mem abort info:
>>> [  142.984049]   ESR = 0x0000000096000004
>>> [  142.984556]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [  142.985327]   SET = 0, FnV = 0
>>> [  142.986867]   EA = 0, S1PTW = 0
>>> [  142.987198]   FSC = 0x04: level 0 translation fault
>>> [  142.987555] Data abort info:
>>> [  142.987819]   ISV = 0, ISS = 0x00000004
>>> [  142.988132]   CM = 0, WnR = 0
>>> [  142.988540] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000046168000
>>> [  142.989715] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
>>> [  142.992158] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>> [  142.993012] Modules linked in: memdup_kernel_user_test(+) drm ip_tables x_tables ipv6
>>> [  142.996663] CPU: 0 PID: 133 Comm: modprobe Not tainted 6.3.0-rc1-next-20230307-dirty #1
>>> [  143.002024] Hardware name: linux,dummy-virt (DT)
>>> [  143.003370] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [  143.005461] pc : __memcpy+0x54/0x230
>>> [  143.006833] lr : kmemdup+0x50/0x68
>>> [  143.007208] sp : ffff80000aa53ae0
>>> [  143.011440] x29: ffff80000aa53ae0 x28: ffff8000010c0378 x27: ffff8000010c0058
>>> [  143.012386] x26: ffff80000a216fd8 x25: ffff80000aa53d00 x24: ffff8000010c0040
>>> [  143.014183] x23: 0000000000000000 x22: ffff0000037d6580 x21: 0000000000000000
>>> [  143.018590] x20: 0000000000000005 x19: ffff0000039a9100 x18: 0000000000000001
>>> [  143.020166] x17: ffff80000aa75000 x16: ffff0000047bed91 x15: ffff0000037d69f8
>>> [  143.021158] x14: 0000000000000147 x13: ffff0000037d69f8 x12: 00000000ffffffea
>>> [  143.024978] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffff80000a1fb518
>>> [  143.025800] x8 : 00000000ffffffff x7 : 00000000ffffffff x6 : ffff800036288000
>>> [  143.026667] x5 : ffff0000039a9105 x4 : 0000000000000005 x3 : 0000000080200020
>>> [  143.027257] x2 : 0000000000000005 x1 : 0000000000000000 x0 : ffff0000039a9100
>>> [  143.028177] Call trace:
>>> [  143.028833]  __memcpy+0x54/0x230
>>> [  143.029424]  memdup_user_test_init+0xd8/0x1000 [memdup_kernel_user_test]
>>> [  143.032466]  do_one_initcall+0x70/0x1b4
>>> [  143.038282]  do_init_module+0x58/0x1e8
>>> [  143.039354]  load_module+0x181c/0x1920
>>> [  143.040919]  __do_sys_finit_module+0xb8/0x10c
>>> [  143.041558]  __arm64_sys_finit_module+0x20/0x2c
>>> [  143.044052]  invoke_syscall+0x44/0x104
>>> [  143.044663]  el0_svc_common.constprop.0+0x44/0xec
>>> [  143.045562]  do_el0_svc+0x38/0x98
>>> [  143.047935]  el0_svc+0x2c/0x84
>>> [  143.048175]  el0t_64_sync_handler+0xb8/0xbc
>>> [  143.048295]  el0t_64_sync+0x190/0x194
>>> [  143.049274] Code: f9000006 f81f80a7 d65f03c0 361000c2 (b9400026)
>>> [  143.050933] ---[ end trace 0000000000000000 ]---
>>> Segmentation fault
>>>
>>> root@qemu-ubuntu:~# modprobe memdup_kernel_user_test test_case=1
>>> [   87.896982] test case 1: kmemdup failed, PTR_ERR(ptr) = 16
>>> modprobe: ERROR: could not insert 'memdup_kernel_user_test': Invalid argument
>>>
>>> root@qemu-ubuntu:~# modprobe memdup_kernel_user_test test_case=2
>>> [  124.032509] test case 2: memdup_user failed, PTR_ERR(ptr) = -14
>>> modprobe: ERROR: could not insert 'memdup_kernel_user_test': Bad address
>>>
>>> root@qemu-ubuntu:~# modprobe memdup_kernel_user_test test_case=3
>>> [  155.496285] test case 3: memdup_user failed, PTR_ERR(ptr) = 16
>>> modprobe: ERROR: could not insert 'memdup_kernel_user_test': Invalid argument
>>>
>>> To sum it up, it is:
>>> 1) If call kmemdup() with the src == NULL, a NULL pointer dereference
>>>      fault happened.
>>> 2) If call kmemdup() with the len == 0, an invalid address value
>>>      ZERO_SIZE_PTR returned, consider that many existing code check
>>>      kmemdup() return value like this:
>>>      ptr = kmemdup();
>>>      if (!ptr) {
>>>      	/* allocation failed */
>>>      }
>>>      this could be a problem, but no fault happended, memcpy() will do
>>>      nothing if copy length is zero, my previous statement is wrong.
>>> 3) If call memdup_user() with src == NULL, -EFAULT returned. Because
>>>      copy_from_user() takes care of the NULL pointer case, there is no
>>>      fault to happend.
>>> 4) If call memdup_user() with len == 0, an invalid address value
>>>      ZERO_SIZE_PTR returned. The existing code uses IS_ERR() to check
>>>      memdup_user() return value, unfortunately, the check range of the
>>>      macro function doesn't contain ZERO_SIZE_PTR value.
>>>
>>> For 1), (2), we can add the following code to kmemdup() to eliminate:
>>> if (!src || len == 0)
>>> 	return NULL;
>>>
>>> For 4), we can change the statement if (!p) of memdup_user() to
>>> if (ZERO_OR_NULL_PTR(s)) to solve that.
>>>
>>> BTW, the return values of kmemdup() and memdup_user() got a little
>>> bit confused for now:
>>> . kmemdup() can return ZERO_SIZE_PTR, NULL, and a valid memory allocation
>>>     address, the caller should check those return values with ZERO_OR_NULL_PTR(),
>>>     but many existing code don't follow this.
>>> . memdup_user() can return ZERO_SIZE_PTR,-ENOMEM,-EFAULT,NULL, and a valid
>>>     memory allocation address, the caller should check those return values with
>>>     ZERO_OR_NULL_PTR() and IS_ERR() at the same time, but i can't find any code
>>>     do things like this.
>>>
>>>>> Signed-off-by: Xujun Leng <lengxujun2007@126.com>
>>>>> ---
>>>>>     mm/util.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/mm/util.c b/mm/util.c
>>>>> index dd12b9531ac4..d1a3b3d2988e 100644
>>>>> --- a/mm/util.c
>>>>> +++ b/mm/util.c
>>>>> @@ -128,6 +128,9 @@ void *kmemdup(const void *src, size_t len, gfp_t gfp)
>>>>>     {
>>>>>     	void *p;
>>>>>     
>>>>> +	if (!src || len == 0)
>>>>> +		return NULL;
>>>>> +
>>>>>     	p = kmalloc_track_caller(len, gfp);
>>>>>     	if (p)
>>>>>     		memcpy(p, src, len);
>>>
>>>> Why should we take care of kmemdup(), but not memdup_user() ? Shouldn't
>>>> it suffer from similar problems?
>>> By the foregoing, i think that both kmemdup() and memdup_user() need to
>>> change.
>>
>> The issue is that you can call mostly any kernel function with
>> unsupported arguments and trigger crashes. It all depends on with which
>> parameters functions are expected to be called.
>>
>> If kmemdup() is not expected to be called with !src or !len, all is
>> fine. And if there are no broken cases, existing code obeys these rules.
>>
>> Of course, we could improve the documentation or adjust the
>> implementations, if there is real need to.
>>
>> But adjusting individual functions here while others are left with he
>> same, theoretical (!) problems, is not a good approach IMHO.
> 
> Yes, you're right. The best way is to change kmalloc_slab(), let it always
> return NULL on allocate failure, even for requested size == 0. And of course,
> the detailed error message ZERO_SIZE_PTR will lost.
> 
> On the other hand, except kmemdup() and memdup_user(), the other functions
> in mm/util.c, who called kmalloc_track_caller(), like kstrdup(), kstrndup(),
> kmemdup_nul(), memdup_user_nul(), their all do argument check, and the
> len >= 1(if ignore the wrap case). So if we need change kmemdup() and
> memdup_user() a little, to let those all functions keep the same? If the
> answer is NO, we can end the disscuss to save your time.

It's not me to decide. :) I consider sanitizing the input of all of 
these functions valuable, I just don't think the individual poking makes 
sense. So I would certainly review a patch (series) that unifies the 
error checks performed in these functions (e.g., be able to handle NULL 
pointers or len=0).

-- 
Thanks,

David / dhildenb

