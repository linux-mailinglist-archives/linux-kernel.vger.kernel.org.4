Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A59464E5BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiLPBoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLPBoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:44:15 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACAA2B7EB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:44:13 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8AxB_FszZtjt_8FAA--.13516S3;
        Fri, 16 Dec 2022 09:44:12 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+RpzZtjNg0BAA--.4585S3;
        Fri, 16 Dec 2022 09:44:10 +0800 (CST)
Subject: Re: [PATCH 6/6] LoongArch: Add generic ex-handler unwind in prologue
 unwinder
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221215040141.18610-1-hejinyang@loongson.cn>
 <20221215040141.18610-7-hejinyang@loongson.cn>
 <2aa963e1-e202-73b8-725f-3ca207d622a7@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <2bba3021-b4d8-f23e-c924-3e951ce3f768@loongson.cn>
Date:   Fri, 16 Dec 2022 09:44:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2aa963e1-e202-73b8-725f-3ca207d622a7@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxX+RpzZtjNg0BAA--.4585S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw13GrWkJrW5urWxZw1fZwb_yoW7uFWkpr
        y8ArsYkrW8Ar1vvF43C3WUAr9xuFn7ua18Ar48GF1UAr18Xr1Yqr1jqw1jgr1DAr4rZFyU
        JF1UAr1S9F17J3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2MKZUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-15 20:04, Qing Zhang wrote:

> Hi, Jinyang
>
> On 2022/12/15 下午12:01, Jinyang He wrote:
>> When exception is triggered, code flow go handle_\exception in some
>> cases. One of stackframe in this case as follows,
>>
>> high -> +-------+
>>          | REGS  |  <- a pt_regs
>>          |       |
>>          |       |  <- ex trigger
>>          | REGS  |  <- ex pt_regs   <-+
>>          |       |                    |
>>          |       |                    |
>> low  -> +-------+           ->unwind-+
>>
>> When unwinder unwind to handler_\exception it cannot go on prologue
>> analysis. It is asynchronous code flow, we should get the next frame
>> PC from regs->csr_era but not from regs->regs[1]. And we copy the
>> handler codes to eentry in the early time and copy the handler codes
>> to NUMA-relative memory named pcpu_handlers if NUMA is enabled. Thus,
>> unwinder cannot unwind normally. Therefore, try to give some hint in
>> handler_\exception and fixup it in unwind_next_frame.
>>
>> Reported-by: Qing Zhang <zhangqing@loongson.cn>
>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/unwind.h     |   2 +-
>>   arch/loongarch/kernel/genex.S           |   3 +
>>   arch/loongarch/kernel/unwind_prologue.c | 100 +++++++++++++++++++++---
>>   arch/loongarch/mm/tlb.c                 |   2 +-
>>   4 files changed, 92 insertions(+), 15 deletions(-)
>>
> The others look good to me, but there is still a small problem:
> When I tested hw_breakpoint.ko with prologue unwinder,
> sometimes output address [<9000000100302724>] 0x9000000100302724, eg: 
> CPU: 3 PID: 0
> But some processes are normal, eg: CPU: 0 PID: 0
>
> [27.655549] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.1.0-rc8 #9
> [27.655552] Hardware name: Loongson Loongson-3A5000-7A1000-1w-A2101/
> Loongson-LS3A5000-7A1000-1w-A2101,  BIOS 
> vUDK2018-LoongArch-V2.0.pre-beta8 06/15/2022
>
> [27.655604]...
> [27.655606] Call Trace:
> [27.655607] [<9000000000222f88>] show_stack+0x60/0x184
> [27.655613] [<90000000010e9b8c>] dump_stack_lvl+0x60/0x88
> [27.655618] [] sample_hbp_handler+0x30/0x4c [data_breakpoint]
> [27.655626] [<900000000037c8a0>] __perf_event_overflow+0x84/0x26c
> [27.655629] [<900000000038980c>] perf_bp_event+0xc0/0xc8
> [27.655633] [<900000000022e3bc>] watchpoint_handler+0x54/0x88
> [27.655637] [<90000000010ea2f8>] do_watch+0x30/0x48
> [27.655640] [<9000000100302724>] 0x9000000100302724      // Not natural
> [27.655642] [<9000000000ab4cbc>] add_interrupt_randomness+0x60/0xbc
> [27.655646] [<90000000002a0fa0>] handle_irq_event_percpu+0x28/0x70
> [27.655650] [<90000000002a6f9c>] handle_percpu_irq+0x54/0x88
> [27.655652] [<90000000002a025c>] generic_handle_domain_irq+0x28/0x40
> [27.655655] [<9000000000995458>] handle_cpu_irq+0x68/0xa4
> [27.655658] [<90000000010ea8dc>] handle_loongarch_irq+0x34/0x4c
> [27.655661] [<90000000010ea974>] do_vint+0x80/0xb4
> [27.655664] [<90000000002216a0>] __arch_cpu_idle+0x20/0x24
> [27.655667] [<90000000010f8178>] default_idle_call+0x30/0x58
> [27.655670] [<90000000002825cc>] do_idle+0xb4/0x118
> [27.655674] [<900000000028281c>] cpu_startup_entry+0x20/0x24
> [27.655677] [<900000000022b198>] start_secondary+0x9c/0xa4
> [27.655679] [<90000000010eb124>] smpboot_entry+0x60/0x64
>
>
> [27.658940] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc8 #9
> ...
> [28.229978] Call Trace:
> [28.229979] [<9000000000222f88>] show_stack+0x60/0x184
> [28.237503] [<90000000010e9b8c>] dump_stack_lvl+0x60/0x88
> [28.242866] [] sample_hbp_handler+0x30/0x4c [data_breakpoint]
> [28.250132] [<900000000037c8a0>] __perf_event_overflow+0x84/0x26c
> [28.256186] [<900000000038980c>] perf_bp_event+0xc0/0xc8
> [28.261462] [<900000000022e3bc>] watchpoint_handler+0x54/0x88
> [28.267170] [<90000000010ea2f8>] do_watch+0x30/0x48
> [28.272013] [<90000000017d2724>] exception_handlers+0x2724/0x1000  //...

There is not in kernel text section but in kernel bss section. Because
the boot cpu set csr.eentry to eentry and set others cpus set csr.eentry
to pcpu_handlers[cpu]. All of these eentry are not in orginal position.
So we cannot find its real symbol. But I still give a chance to go on 
and record
PC value when unwind_state_fixup return true in unwind_by_prologue().


Thanks,

Jinyang


> [28.278155] [<9000000000ab4cbc>] add_interrupt_randomness+0x60/0xbc
> [28.284381] [<90000000002a0fa0>] handle_irq_event_percpu+0x28/0x70
> [28.290520] [<90000000002a6f9c>] handle_percpu_irq+0x54/0x88
> [28.296140] [<90000000002a025c>] generic_handle_domain_irq+0x28/0x40
> [28.302452] [<9000000000995458>] handle_cpu_irq+0x68/0xa4
> [28.307813] [<90000000010ea8dc>] handle_loongarch_irq+0x34/0x4c
> [28.313693] [<90000000010ea974>] do_vint+0x80/0xb4
> [28.318450] [<90000000002216a0>] __arch_cpu_idle+0x20/0x24
> [28.323897] [<90000000010f8178>] default_idle_call+0x30/0x58
> [28.329518] [<90000000002825cc>] do_idle+0xb4/0x118
> [28.334361] [<900000000028281c>] cpu_startup_entry+0x20/0x24
> [28.339982] [<90000000010ec0dc>] kernel_init+0x0/0x110
> [28.345085] [<90000000011106f8>] arch_post_acpi_subsys_init+0x0/0x4
>
> Maybe sometimes assembly kallsyms is not recognized, let me think...
>
> Thanks,
> -Qing
>

