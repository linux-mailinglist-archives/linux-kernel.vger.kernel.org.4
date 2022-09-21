Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F795BF409
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIUDAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIUDAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:00:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF01167E8;
        Tue, 20 Sep 2022 20:00:23 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXNMz1WBSzlWcH;
        Wed, 21 Sep 2022 10:56:15 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 11:00:21 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 11:00:21 +0800
Message-ID: <8b7093a5-291f-6c2f-e915-51b07d912ca1@huawei.com>
Date:   Wed, 21 Sep 2022 11:00:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH -next 6/7] riscv: stacktrace: Fix unwinding on
 ftrace_regs_call
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <frederic@kernel.org>,
        <vincent.chen@sifive.com>, <ardb@kernel.org>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <keescook@chromium.org>, <catalin.marinas@arm.com>
References: <20220920151202.180057-1-chenzhongjin@huawei.com>
 <20220920151202.180057-7-chenzhongjin@huawei.com>
 <CAJF2gTSQAzqLcJSp4B=8vPTb10+TieZXDJPAigCBgm5iVYpdTg@mail.gmail.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <CAJF2gTSQAzqLcJSp4B=8vPTb10+TieZXDJPAigCBgm5iVYpdTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/9/21 9:43, Guo Ren wrote:
> On Tue, Sep 20, 2022 at 11:15 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>> When unwinding on ftrace_regs_call, the traced function will be skipped
>> because ftrace_regs_caller doesn't save the fp and ra.
>>
>> Save the encoded fp so that we can get the pt_regs so that we can unwind
>> from ftrace_regs_call to the traced function.
>>
>> Also the pt_regs->status should be set as kernel mode.
>>
>> Stacktrace before this patch:
>>
>>   Call Trace:
>>    ...
>>    [<ffffffff0161a0e0>] handler_pre+0x30/0x4a [kprobe_unwind]
>>    [<ffffffff800bce92>] aggr_pre_handler+0x60/0x94
>>    [<ffffffff80006df0>] kprobe_ftrace_handler+0x13e/0x188
>>    [<ffffffff80008e7e>] ftrace_regs_call+0x8/0x10
>>    [<ffffffff80002540>] do_one_initcall+0x4c/0x1f2
>>    [<ffffffff8008a4e6>] do_init_module+0x56/0x210
>>   ...
>>
>> Stacktrace after this patch:
>>
>>   Call Trace:
>>    ...
>>    [<ffffffff016150e0>] handler_pre+0x30/0x4a [kprobe_unwind]
>>    [<ffffffff800bce96>] aggr_pre_handler+0x60/0x94
>>    [<ffffffff80006df0>] kprobe_ftrace_handler+0x13e/0x188
>>    [<ffffffff80008e82>] ftrace_regs_call+0x8/0x10
>> + [<ffffffff01615000>] empty_call+0x0/0x1e [kprobe_unwind]
>>    [<ffffffff80002540>] do_one_initcall+0x4c/0x1f2
>>    [<ffffffff8008a4ea>] do_init_module+0x56/0x210
>>    ...
>>
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>>   arch/riscv/kernel/mcount-dyn.S | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
>> index d171eca623b6..56a4014c392f 100644
>> --- a/arch/riscv/kernel/mcount-dyn.S
>> +++ b/arch/riscv/kernel/mcount-dyn.S
>> @@ -10,6 +10,8 @@
>>   #include <asm/asm-offsets.h>
>>   #include <asm-generic/export.h>
>>   #include <asm/ftrace.h>
>> +#include <asm/frame.h>
>> +#include <asm/csr.h>
>>
>>          .text
>>
>> @@ -97,6 +99,11 @@
>>          REG_S x29, PT_T4(sp)
>>          REG_S x30, PT_T5(sp)
>>          REG_S x31, PT_T6(sp)
>> +
>> +#ifdef CONFIG_FRAME_POINTER
>> +       li s0, SR_PP
>> +       REG_S s0, PT_STATUS(sp)
> Change another register.
>
>> +#endif
>>          .endm
>>
>>          .macro RESTORE_ALL
>> @@ -172,6 +179,7 @@ ENDPROC(ftrace_caller)
>>   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>>   ENTRY(ftrace_regs_caller)
>>          SAVE_ALL
>> +       ENCODE_FRAME_POINTER
> Maybe the patch should merge with others, so separated make it hard to review.

Thanks for review!

Happy to see you have approved the ENCODE FP part.

The patches is separated just because I wanted to paste the call trace 
result in commit message.

I'll merge the ENCODE_FRAME_POINTER patches all together and do this in 
the cover.


Also noticed another email for your ongoing patches. I'll review them 
and reply later.


Best,

Chen

