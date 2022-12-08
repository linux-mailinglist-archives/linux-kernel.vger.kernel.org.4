Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE872646735
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLHCpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLHCo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:44:58 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DED9880D6;
        Wed,  7 Dec 2022 18:44:56 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NSJLp5tzSzJpBF;
        Thu,  8 Dec 2022 10:41:22 +0800 (CST)
Received: from [10.174.176.219] (10.174.176.219) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 10:44:53 +0800
Subject: Re: [RFC 2/2] ACPI: APEI: fix reboot caused by synchronous error loop
 because of memory_failure() failed
To:     Bixuan Cui <cuibixuan@linux.alibaba.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <naoya.horiguchi@nec.com>, <linmiaohe@huawei.com>,
        <akpm@linux-foundation.org>, <xueshuai@linux.alibaba.com>,
        <ashish.kalra@amd.com>
CC:     <xiezhipeng1@huawei.com>, <wangkefeng.wang@huawei.com>,
        <xiexiuqi@huawei.com>, <tanxiaofei@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20221205115111.131568-1-lvying6@huawei.com>
 <20221205115111.131568-3-lvying6@huawei.com>
 <ddc81946-8b76-ea49-ebf5-f2de2e30540d@linux.alibaba.com>
From:   Lv Ying <lvying6@huawei.com>
Message-ID: <c5468dee-f4eb-3c5a-9456-ca3422768084@huawei.com>
Date:   Thu, 8 Dec 2022 10:44:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ddc81946-8b76-ea49-ebf5-f2de2e30540d@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.219]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 3b6ac3694b8d..4c1c558f7161 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2266,7 +2266,11 @@ static void __memory_failure_work_func(struct 
>> work_struct *work, bool sync)
>>               break;
>>           if (entry.flags & MF_SOFT_OFFLINE)
>>               soft_offline_page(entry.pfn, entry.flags);
>> -        else if (!sync || (entry.flags & MF_ACTION_REQUIRED))
>> +        else if (sync) {
>> +            if ((entry.flags & MF_ACTION_REQUIRED) &&
>> +                    memory_failure(entry.pfn, entry.flags))
>> +                force_sig_mceerr(BUS_MCEERR_AR, 0, 0);
>> +        } else
>>               memory_failure(entry.pfn, entry.flags);
> Hi,
> 
> Some of the ideas in this patch are wrong :-(
> 
> 1. As Shuai Xue said, it is wrong to judge synchronization error and 
> asynchronization error through functions such as 
> memory_failure_queue_kick()/ghes_proc()/ghes_proc_in_irq(), because both 
> synchronization error and asynchronization error may go to the same 
> notification.
> 
Hi Bixuan:

Thanks for your review. I agree with you that ghes_proc_in_irq() is
called in SDEI, SEA, NMI notify type, they are NMI-like notify, this
function run some job which may not be NMI safe in IRQ context. And NMI
may be asynchronous error.

However, cureent kernel use ghes_kick_task_work in ghes_proc_in_irq(),
there is an assumption here that ghes_proc_in_irq() are currently in the
context of a synchronous exception, although this is not appropriate.

The challenge for my patch is to prove the rationality of distinguishing
synchronous errors. I do not have a good idea yet of distinguishing 
synchronous error by looking through ACPI/UEFI spec, so I sent this
patchset for more input. And I resent RFC PATCH v1 [1]add this as TODO.

> 2. There is no need to pass 'sync' to __memory_failure_work_func(), 
> because memory_failure() can directly handle synchronous and 
> asynchronous errors according to entry.flags & MF_ACTION_REQUIRED:
> 
> entry.flags & MF_ACTION_REQUIRED == 1: Action: poison page and kill task 
> for synchronous error
> entry.flags & MF_ACTION_REQUIRED == 0: Action: poison page for 
> asynchronous error
> 
> Reference x86:
> do_machine_check # MCE, synchronous
>     ->kill_me_maybe
>       ->memory_failure(p->mce_addr >> PAGE_SHIFT, MF_ACTION_REQUIRED);
> 
> uc_decode_notifier # CMCI, asynchronous
>     ->memory_failure(pfn, 0)
> 
> At the same time, the modification here is repeated with your patch 01
>       if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
> -        flags = 0;
> +        flags = sync ? MF_ACTION_REQUIRED : 0;
> 

Thanks, there is indeed no need to pass 'sync' to
__memory_failure_work_func(). MF_ACTION_REQUIRED can cover this, I will 
update it in the next version patchset.

> 3. Why add 'force_sig_mceerr(BUS_MCEERR_AR, 0, 0)' after 
> memory_failure(pfn, MF_ACTION_REQUIRED)?
> The task will be killed in memory_failure():
> if poisoned, kill_accessing_process()->kill_proc()
> if not poisoned, hwpoison_user_mappings()->collect_procs()->kill_procs()
> 
> Reference x86 to handle synchronous error:
> kill_me_maybe()
> {
>      int flags = MF_ACTION_REQUIRED;
>      ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
>      if (!ret) {
>      ...
>          return;
>      }
>      if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>          return;
> 
>      pr_err("Memory error not recovered");
>      kill_me_now(cb);
> }
> 

Thanks again, this patch is based on synchronous error is not 
distinguished from
asynchronous  error, in that case, kill_accessing_process() run in 
kthread worker may not kill current thread. Now, based on the first 
patch, this SEA loop can be handled. But this patch is also needed 
reference x86 kill_me_maybe(), I update this patch in RFC PATCH v1[1].
I will integrate this patch into the first patch, because this patch 
commit message is not suitable based on the first patch.

[1] 
https://lore.kernel.org/linux-mm/20221207093935.1972530-1-lvying6@huawei.com/T/


-- 
Thanks!
Lv Ying
