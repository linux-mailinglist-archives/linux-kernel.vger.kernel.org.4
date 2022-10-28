Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C426107D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiJ1CSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiJ1CR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:17:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124B8BB3B3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:17:55 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mz5fy2Fznz15MG0;
        Fri, 28 Oct 2022 10:12:58 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 10:17:52 +0800
Message-ID: <66633c9c-f00e-742b-4572-cc0efb153c50@huawei.com>
Date:   Fri, 28 Oct 2022 10:17:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] mm/mmap: Fix memory leak in mmap_region()
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lizetao1@huawei.com" <lizetao1@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "cmllamas@google.com" <cmllamas@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221027025837.136492-1-lizetao1@huawei.com>
 <20221027073029.dyo2p2kearlutizq@revolver>
Content-Language: en-US
From:   Li Zetao <lizetao1@huawei.com>
In-Reply-To: <20221027073029.dyo2p2kearlutizq@revolver>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.176]
X-ClientProxiedBy: dggpeml100005.china.huawei.com (7.185.36.185) To
 kwepemi500012.china.huawei.com (7.221.188.12)
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

On 2022/10/27 15:30, Liam Howlett wrote:
> * Li Zetao <lizetao1@huawei.com> [221026 21:55]:
>> There is a memory leak reported by kmemleak:
>>
>>    unreferenced object 0xffff88817231ce40 (size 224):
>>      comm "mount.cifs", pid 19308, jiffies 4295917571 (age 405.880s)
>>      hex dump (first 32 bytes):
>>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>        60 c0 b2 00 81 88 ff ff 98 83 01 42 81 88 ff ff  `..........B....
>>      backtrace:
>>        [<ffffffff81936171>] __alloc_file+0x21/0x250
>>        [<ffffffff81937051>] alloc_empty_file+0x41/0xf0
>>        [<ffffffff81937159>] alloc_file+0x59/0x710
>>        [<ffffffff81937964>] alloc_file_pseudo+0x154/0x210
>>        [<ffffffff81741dbf>] __shmem_file_setup+0xff/0x2a0
>>        [<ffffffff817502cd>] shmem_zero_setup+0x8d/0x160
>>        [<ffffffff817cc1d5>] mmap_region+0x1075/0x19d0
>>        [<ffffffff817cd257>] do_mmap+0x727/0x1110
>>        [<ffffffff817518b2>] vm_mmap_pgoff+0x112/0x1e0
>>        [<ffffffff83adf955>] do_syscall_64+0x35/0x80
>>        [<ffffffff83c0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>> The root cause was traced to an error handing path in mmap_region()
>> when arch_validate_flags() or mas_preallocate() fails. In the shared
>> anonymous mapping sence, vma will be setuped and mapped with a new
>> shared anonymous file via shmem_zero_setup(). So in this case, the
>> file resource needs to be released.
>>
>> Fix it by calling fput(vma->vm_file) when arch_validate_flags() or
>> mas_preallocate() returns an error. And for the beauty of the code,
>> put fput() under mapping_unmap_writable().
> It does look like the unrolling is in the wrong order in that section.
>
>> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
>> Fixes: c462ac288f2c ("mm: Introduce arch_validate_flags()")
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>> ---
>>   mm/mmap.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index e270057ed04e..8530195b3ec5 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2674,6 +2674,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>>   		error = -EINVAL;
>>   		if (file)
>>   			goto close_and_free_vma;I will modify it in the second version
>> +		else if (vm_flags & VM_SHARED)
>> +			goto put_vma_file;
>>   		else
>>   			goto free_vma;
>>   	}
>> @@ -2682,6 +2684,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>>   		error = -ENOMEM;
>>   		if (file)
>>   			goto close_and_free_vma;
>> +		else if (vm_flags & VM_SHARED)
>> +			goto put_vma_file;
>>   		else
>>   			goto free_vma;
>>   	}
> I am not happy about this getting more complex as it already duplicates
> too much code.

It's true that my modification would cause the code to further 
complicate. I will rework it in the

next version.

>> @@ -2746,13 +2750,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>>   	if (vma->vm_ops && vma->vm_ops->close)
>>   		vma->vm_ops->close(vma);
>>   unmap_and_free_vma:
>> -	fput(vma->vm_file);
>> -	vma->vm_file = NULL;
>> -
>>   	/* Undo any partial mapping done by a device driver. */
>>   	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
>>   	if (vm_flags & VM_SHARED)
> Could we change the above if to "if (file && vm_flags & VM_SHARED)" and
> jump to unmap_and_free_vma "if (vma->vm_file)"?  We could then drop your
> new goto label. I still think the reodering is correct and worth while.
>
> Or am I missing something?
Thanks for your constructive comments.
>>   		mapping_unmap_writable(file->f_mapping);
>> +put_vma_file:
>> +	fput(vma->vm_file);
>> +	vma->vm_file = NULL;
>>   free_vma:
>>   	vm_area_free(vma);
>>   unacct_error:
>> -- 
>> 2.31.1

Regards,

Li Zetao

