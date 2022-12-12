Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D790C649B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLLJfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiLLJfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:35:17 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 061BA7647
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:35:14 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxRPDR9ZZjh_wEAA--.11481S3;
        Mon, 12 Dec 2022 17:35:13 +0800 (CST)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxmFfR9ZZjlU0sAA--.24307S3;
        Mon, 12 Dec 2022 17:35:13 +0800 (CST)
Subject: Re: [PATCH v10 0/4] Add kprobe and kretprobe support for LoongArch
To:     Hengqi Chen <chenhengqi@outlook.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1670575981-14389-1-git-send-email-yangtiezhu@loongson.cn>
 <SY4P282MB3518614999070D8FD19D14DFC0E29@SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <987d1061-bad8-9566-5177-148a87179d0d@loongson.cn>
Date:   Mon, 12 Dec 2022 17:35:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <SY4P282MB3518614999070D8FD19D14DFC0E29@SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxmFfR9ZZjlU0sAA--.24307S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZryDWr4fJw13AF1ktF4rAFb_yoW5tFW5pF
        ZrZFn5KrWrWr13Aryaq3s09r1ftw18Gr47K3W7JrWFy3W7Zw15ZrWxKrZxWa4xG3yYqr1S
        qF1rXFWag3W7J37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hengqi

On 2022/12/12 下午4:41, Hengqi Chen wrote:
> Hi, Tiezhu:
> 
> I tested this patchset from BPF side, failed with EINVAL:
> 
>      $ cat /sys/kernel/tracing/error_log
>      [  262.299093] trace_kprobe: error: Failed to register probe event
>        Command: p:kprobes/libbpf_4609_inet_bind_0x0_0 inet_bind+0x0
> 
This is because KPROBE_ON_FTRACE is not yet supported. Trace Event 
cannot be used now.
We will support it soon, if you want to test it by install 
kprobe_example.ko as jeff did.

Thanks
-Qing                                                ^
> --
> Hengqi
> 
> On 2022/12/9 16:52, Tiezhu Yang wrote:
>> v10:
>>    -- Remove sign_extend() based on the latest code
>>    -- Rename insns_are_not_supported() to insns_not_supported()
>>    -- Rename insns_are_not_simulated() to insns_not_simulated()
>>    -- Set KPROBE_HIT_SSDONE if cur->post_handler is not NULL
>>    -- Enable preemption for KPROBE_REENTER in kprobe_fault_handler()
>>
>> v9:
>>    -- Rename sign_extended() to sign_extend()
>>    -- Modify kprobe_fault_handler() to handle all of kprobe_status
>>
>> v8:
>>    -- Put "regs->csr_prmd &= ~CSR_PRMD_PIE;" ahead to save one line
>>    -- Add code comment of preempt_disable()
>>    -- Put kprobe_page_fault() in __do_page_fault()
>>    -- Modify the check condition of break insn in kprobe_breakpoint_handler()
>>
>> v7:
>>    -- Remove stop_machine_cpuslocked() related code
>>
>> v6:
>>    -- Add a new patch to redefine larch_insn_patch_text() with
>>       stop_machine_cpuslocked()
>>    -- Modify kprobe_breakpoint_handler() to consider the original
>>       insn is break and return the correct value
>>    -- Modify do_bp() to refresh bcode when original insn is break
>>
>> v5:
>>    -- Rebase on the latest code
>>    -- Use stop_machine_cpuslocked() to modify insn to avoid CPU race
>>
>> v4:
>>    -- Remove kprobe_exceptions_notify() in kprobes.c
>>    -- Call kprobe_breakpoint_handler() and kprobe_singlestep_handler()
>>       in do_bp()
>>
>> v3:
>>    -- Rebase on the latest code
>>    -- Check the alignment of PC in simu_branch() and simu_pc()
>>    -- Add ibar in flush_insn_slot()
>>    -- Rename kprobe_{pre,post}_handler() to {post_}kprobe_handler
>>    -- Add preempt_disable() and preempt_enable_no_resched()
>>    -- Remove r0 save/restore and do some minor changes
>>       in kprobes_trampoline.S
>>    -- Do not enable CONFIG_KPROBES by default
>>
>> v2:
>>    -- Split simu_branch() and simu_pc() into a single patch
>>    -- Call kprobe_page_fault() in do_page_fault()
>>    -- Add kprobes_trampoline.S for kretprobe
>>
>> Tiezhu Yang (4):
>>    LoongArch: Simulate branch and PC instructions
>>    LoongArch: Add kprobe support
>>    LoongArch: Add kretprobe support
>>    samples/kprobes: Add LoongArch support
>>
>>   arch/loongarch/Kconfig                     |   2 +
>>   arch/loongarch/include/asm/inst.h          |  20 ++
>>   arch/loongarch/include/asm/kprobes.h       |  59 +++++
>>   arch/loongarch/include/asm/ptrace.h        |   1 +
>>   arch/loongarch/kernel/Makefile             |   2 +
>>   arch/loongarch/kernel/inst.c               | 123 ++++++++++
>>   arch/loongarch/kernel/kprobes.c            | 364 +++++++++++++++++++++++++++++
>>   arch/loongarch/kernel/kprobes_trampoline.S |  96 ++++++++
>>   arch/loongarch/kernel/traps.c              |  13 +-
>>   arch/loongarch/mm/fault.c                  |   3 +
>>   samples/kprobes/kprobe_example.c           |   8 +
>>   11 files changed, 687 insertions(+), 4 deletions(-)
>>   create mode 100644 arch/loongarch/include/asm/kprobes.h
>>   create mode 100644 arch/loongarch/kernel/kprobes.c
>>   create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
>>

