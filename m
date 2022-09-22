Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703BF5E5D59
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIVIWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIVIW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:22:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBBC9FDA;
        Thu, 22 Sep 2022 01:22:25 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MY7WK2DnDzHnyV;
        Thu, 22 Sep 2022 16:20:13 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:22:23 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 16:22:23 +0800
Message-ID: <7834a259-4bd7-a955-acaa-21c36c7c22c2@huawei.com>
Date:   Thu, 22 Sep 2022 16:22:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH for-next v2 0/4] riscv: Improvments for stacktrace
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <jolsa@kernel.org>, <guoren@kernel.org>, <frederic@kernel.org>,
        <vincent.chen@sifive.com>, <ardb@kernel.org>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <keescook@chromium.org>, <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
References: <20220921125128.33913-1-chenzhongjin@huawei.com>
 <YysZf2Y37QMBDt8n@FVFF77S0Q05N>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YysZf2Y37QMBDt8n@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/9/21 22:02, Mark Rutland wrote:
> On Wed, Sep 21, 2022 at 08:51:23PM +0800, Chen Zhongjin wrote:
>> Currently, the stacktrace with FRAME_POINTER on riscv has some problem:
>>
>> 1. stacktrace will stop at irq so it can't get the stack frames before
>> irq entry.
>> 2. stacktrace can't unwind all the real stack frames when there is
>> k{ret}probes or ftrace.
>>
>> These are mainly becase when there is a pt_regs on stack, we can't unwind
>> the stack frame as normal function.
>>
>> Some architectures (e.g. arm64) create a extra stackframe inside pt_regs.
>> However this doesn't work for riscv because the ra is not ensured to be
>> pushed to stack. As explained in:
>> commit f766f77a74f5("riscv/stacktrace: Fix stack output without ra on the stack top")
> FWIW, this is also a latent problem on arm64, since we don't know whether the
> LR is live at an exception boundary (and we currently always ignore it).

In fact this is still a problem for riscv, I didn't unwind the caller of 
ftrace or probed func

of kretprobe because they are inside function pro/epilogue.

The problem on riscv is a little more complex, for leaf function, ra 
will always not be pushed

to stack and fp will be pushed to ra slot. This patch solved this problem.

> My plan to fix that on arm64 is to push an empty frame record to the stack upon
> an exception, and use that to find the pt_regs, from which we can get the PC
> and LR (and then we can report the later as unreliable). That should be roughly
> equivalent to what you do in this series (where use use the LSB to identify
> that the pointer is actually a pt_regs).

IIRC, this solution looks like:

=====

Func1     { lr, fp } or { nothing }

irq entry { pt_regs & empty stackframe[2] }

handler   { lr, fp }

======

handler->fp points to stackframe, and when we find stackframe is empty, 
we know we are inside

an pt_regs and can find registers by offset.

I think it's available, there no other scenario will cause the frame 
list contains zero (unless stack is clobbered).

And it seems only fp slot should be zero, lr will be clobbered after 
function call, we cannot use lr inside pt_regs.

> One important thing to note is that when crossing an exception boundary you
> won't know whether RA is live, and so you might try to consume an address twice
> (if it has also been pushed to the stack). That could be problematic for
> unwinding ftrace or kretprobes. On arm64 we had to implement
> HAVE_FUNCTION_GRAPH_RET_ADDR_PTR so that we could reliably unwind ftrace. See
> commit:
>
>    c6d3cd32fd0064af ("arm64: ftrace: use HAVE_FUNCTION_GRAPH_RET_ADDR_PTR")
>
> ... and we haven't yet come up with something similar for kretprobes (though I
> suspect we'll need to).

Can we test the sp and fp inside pt_regs? Because luckily arm64 saves 
lr, fp and moves sp together.

Before sp is moved we will have fp == sp from last frame 'mov x29, sp'. 
So if they are same, we uses the lr in pt_regs,

conversely we use lr on stack.

That's what I planned to use for orc unwinder (or we need to track lr as 
sp/fp). Seems it also works for this

solution. Haven't thought it in detail through.


Best,

Chen

> Thanks,
> Mark.
>
>> So, I choosed the method of x86 that, if there is a pt_regs on stack,
>> we encoded the frame pointer and save it. When unwinding stack frame,
>> we can get pt_regs and registers required for unwinding stacks.
>>
>> In addition, the patch set contains some refactoring of stacktrace.c to
>> keep the stacktrace code on riscv consistent with other architectures.
>>
>> Stacktrace before for kretprobes:
>>
>>    Call Trace:
>>    ...
>>    [<ffffffff800d5d48>] __kretprobe_trampoline_handler+0xc2/0x13e
>>    [<ffffffff808b766c>] trampoline_probe_handler+0x30/0x46
>>    [<ffffffff800070de>] __kretprobe_trampoline+0x52/0x92
>>    [<ffffffff0163809c>] kprobe_init+0x9c/0x1000 [kprobe_unwind]
>>    [<ffffffff800027c8>] do_one_initcall+0x4c/0x1f2
>>    ...
>>
>> Stacktrace after:
>>
>>    Call Trace:
>>    ...
>>    [<ffffffff800d5d48>] __kretprobe_trampoline_handler+0xc2/0x13e
>>    [<ffffffff808b766c>] trampoline_probe_handler+0x30/0x46
>>    [<ffffffff800070de>] __kretprobe_trampoline+0x52/0x92
>> + [<ffffffff01633076>] the_caller+0x2c/0x38 [kprobe_unwind]
>>    [<ffffffff0163809c>] kprobe_init+0x9c/0x1000 [kprobe_unwind]
>>    [<ffffffff800027c8>] do_one_initcall+0x4c/0x1f2
>>    ...
>>
>> Stacktrace before for ftrace:
>>
>>    Call Trace:
>>    ...
>>    [<ffffffff80006df0>] kprobe_ftrace_handler+0x13e/0x188
>>    [<ffffffff80008e7e>] ftrace_regs_call+0x8/0x10
>>    [<ffffffff80002540>] do_one_initcall+0x4c/0x1f2
>>    [<ffffffff8008a4e6>] do_init_module+0x56/0x210
>>    ...
>>
>>    Stacktrace after:
>>
>>    Call Trace:
>>    ...
>>    [<ffffffff016150e0>] handler_pre+0x30/0x4a [kprobe_unwind]
>>    [<ffffffff800bce96>] aggr_pre_handler+0x60/0x94
>>    [<ffffffff80006df0>] kprobe_ftrace_handler+0x13e/0x188
>>    [<ffffffff80008e82>] ftrace_regs_call+0x8/0x10
>> + [<ffffffff01615000>] traced_func+0x0/0x1e [kprobe_unwind]
>>    [<ffffffff80002540>] do_one_initcall+0x4c/0x1f2
>>    [<ffffffff8008a4ea>] do_init_module+0x56/0x210
>>    ...
>>
>> Noticed that the caller of ftrace and probed func of kretprobe
>> cannot be unwind because they are inside function pro/epilogue.
>>
>> ---
>> v1 -> v2:
>> - Merge three patches which add ENCODE_FRAME_POINTER together
>> - Update commit message
>> - Delete the KRETPORBES stuff added in unwind_state, we don't need them
>> to recover the kretporbes ret_addr because we can get it in pt_regs
>> ---
>> Chen Zhongjin (4):
>>    riscv: stacktrace: Replace walk_stackframe with arch_stack_walk
>>    riscv: stacktrace: Introduce unwind functions
>>    riscv: stacktrace: Save pt_regs in ENCODE_FRAME_POINTER
>>    riscv: stacktrace: Implement stacktrace for irq
>>
>>   arch/riscv/include/asm/frame.h                |  45 ++++++
>>   arch/riscv/include/asm/stacktrace.h           |   9 +-
>>   arch/riscv/kernel/entry.S                     |   3 +
>>   arch/riscv/kernel/mcount-dyn.S                |   7 +
>>   arch/riscv/kernel/perf_callchain.c            |   2 +-
>>   arch/riscv/kernel/probes/kprobes_trampoline.S |   7 +
>>   arch/riscv/kernel/stacktrace.c                | 150 ++++++++++++------
>>   7 files changed, 174 insertions(+), 49 deletions(-)
>>   create mode 100644 arch/riscv/include/asm/frame.h
>>
>> -- 
>> 2.17.1
>>
