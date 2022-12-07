Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1431E6451AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLGCCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGCC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:02:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4420A532EE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 18:02:26 -0800 (PST)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRgWN1B6tzJqJV;
        Wed,  7 Dec 2022 10:01:36 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 10:02:24 +0800
Subject: Re: [PATCH] riscv: stacktrace: Fix missing the first frame
To:     Conor Dooley <conor@kernel.org>
References: <20221205132936.493245-1-liushixin2@huawei.com>
 <Y49qvHb3LVas1cvO@spud>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Changbin Du <changbin.du@intel.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <e3bace03-b0eb-9e58-f39e-6ecf8589491c@huawei.com>
Date:   Wed, 7 Dec 2022 10:02:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y49qvHb3LVas1cvO@spud>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/7 0:15, Conor Dooley wrote:
> On Mon, Dec 05, 2022 at 09:29:36PM +0800, Liu Shixin wrote:
>> When running kfence_test, I found some testcases failed like this:
>>
>>  # test_out_of_bounds_read: EXPECTATION FAILED at mm/kfence/kfence_test.c:346
>>  Expected report_matches(&expect) to be true, but is false
>>  not ok 1 - test_out_of_bounds_read
>>
>> The corresponding call-trace is:
>>
>>  BUG: KFENCE: out-of-bounds read in kunit_try_run_case+0x38/0x84
>>
>>  Out-of-bounds read at 0x(____ptrval____) (32B right of kfence-#10):
>>   kunit_try_run_case+0x38/0x84
>>   kunit_generic_run_threadfn_adapter+0x12/0x1e
>>   kthread+0xc8/0xde
>>   ret_from_exception+0x0/0xc
>>
>> The kfence_test using the first frame of call trace to check whether the
>> testcase is succeed or not. Patch a7c5c7e8ff78 skip first frame for all
>> case, which results the kfence_test failed. Indeed, we only need to skip
>> the first frame for case (task==NULL || task==current).
>>
>> With this patch, the call-trace will be:
>>
>>  BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read+0x88/0x19e
>>
>>  Out-of-bounds read at 0x(____ptrval____) (1B left of kfence-#7):
>>   test_out_of_bounds_read+0x88/0x19e
>>   kunit_try_run_case+0x38/0x84
>>   kunit_generic_run_threadfn_adapter+0x12/0x1e
>>   kthread+0xc8/0xde
>>   ret_from_exception+0x0/0xc
>>
>> Fixes: a7c5c7e8ff78 ("riscv: eliminate unreliable __builtin_frame_address(1)")
> This fixes tag is not right, did checkpatch not warn about it?
Yes, there are no warn. Maybe it's because I do have this commit in my local repository.
I confused the original commit with my local commit.

Thanks for your reminder. I'll fix it as soon as possible.
> The correct fixes tag would be:
> Fixes: 6a00ef449370 ("riscv: eliminate unreliable __builtin_frame_address(1)")
>
> Maybe consider automating the creation of fixes tags, like so:
> git log -1 --format='Fixes: %h (\"%s\")'
Thanks, it seems to be convenient.

>
> Thanks,
> Conor.
>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  arch/riscv/kernel/stacktrace.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
>> index 08d11a53f39e..5fe2ae4cf135 100644
>> --- a/arch/riscv/kernel/stacktrace.c
>> +++ b/arch/riscv/kernel/stacktrace.c
>> @@ -30,6 +30,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>>  		fp = (unsigned long)__builtin_frame_address(0);
>>  		sp = current_stack_pointer;
>>  		pc = (unsigned long)walk_stackframe;
>> +		level = -1;
>>  	} else {
>>  		/* task blocked in __switch_to */
>>  		fp = task->thread.s[0];
>> @@ -41,7 +42,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>>  		unsigned long low, high;
>>  		struct stackframe *frame;
>>  
>> -		if (unlikely(!__kernel_text_address(pc) || (level++ >= 1 && !fn(arg, pc))))
>> +		if (unlikely(!__kernel_text_address(pc) || (level++ >= 0 && !fn(arg, pc))))
>>  			break;
>>  
>>  		/* Validate frame pointer */
>> -- 
>> 2.25.1
>>

