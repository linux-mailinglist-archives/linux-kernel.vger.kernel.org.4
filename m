Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB0685E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjBADuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjBADuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:50:06 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3464ABCA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:50:02 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P67Dm3F3QzJsB6;
        Wed,  1 Feb 2023 11:48:24 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 11:49:59 +0800
Message-ID: <cc396e04-b462-caca-2360-ed3cd19b21fe@huawei.com>
Date:   Wed, 1 Feb 2023 11:49:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: kprobe: Fixup kernel panic when probing an illegal
 position
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        <guoren@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <mhiramat@kernel.org>,
        <conor.dooley@microchip.com>, <penberg@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20230126130509.1418251-1-guoren@kernel.org>
 <878rhig9zj.fsf@all.your.base.are.belong.to.us>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <878rhig9zj.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/31 20:32, Björn Töpel 写道:
> guoren@kernel.org writes:
> 
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> The kernel would panic when probed for an illegal position. eg:
>>
>> (CONFIG_RISCV_ISA_C=n)
>>
>> echo 'p:hello kernel_clone+0x16 a0=%a0' >> kprobe_events
>> echo 1 > events/kprobes/hello/enable
>> cat trace
>>
>> Kernel panic - not syncing: stack-protector: Kernel stack
>> is corrupted in: __do_sys_newfstatat+0xb8/0xb8
>> CPU: 0 PID: 111 Comm: sh Not tainted
>> 6.2.0-rc1-00027-g2d398fe49a4d #490
>> Hardware name: riscv-virtio,qemu (DT)
>> Call Trace:
>> [<ffffffff80007268>] dump_backtrace+0x38/0x48
>> [<ffffffff80c5e83c>] show_stack+0x50/0x68
>> [<ffffffff80c6da28>] dump_stack_lvl+0x60/0x84
>> [<ffffffff80c6da6c>] dump_stack+0x20/0x30
>> [<ffffffff80c5ecf4>] panic+0x160/0x374
>> [<ffffffff80c6db94>] generic_handle_arch_irq+0x0/0xa8
>> [<ffffffff802deeb0>] sys_newstat+0x0/0x30
>> [<ffffffff800158c0>] sys_clone+0x20/0x30
>> [<ffffffff800039e8>] ret_from_syscall+0x0/0x4
>> ---[ end Kernel panic - not syncing: stack-protector:
>> Kernel stack is corrupted in: __do_sys_newfstatat+0xb8/0xb8 ]---
>>
>> That is because the kprobe's ebreak instruction broke the kernel's
>> original code. The user should guarantee the correction of the probe
>> position, but it couldn't make the kernel panic.
>>
>> This patch adds arch_check_kprobe in arch_prepare_kprobe to prevent an
>> illegal position (Such as the middle of an instruction).
> 
> Nice!
> 
> @liaochang Will you remove your patch from the OPTPROBE series?

Sure, i will remove it.

> 
>> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> ---
>>  arch/riscv/kernel/probes/kprobes.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
>> index f21592d20306..475989f06d6d 100644
>> --- a/arch/riscv/kernel/probes/kprobes.c
>> +++ b/arch/riscv/kernel/probes/kprobes.c
>> @@ -48,6 +48,21 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
>>  	post_kprobe_handler(p, kcb, regs);
>>  }
>>  
>> +static bool __kprobes arch_check_kprobe(struct kprobe *p)
>> +{
>> +	unsigned long tmp  = (unsigned long)p->addr - p->offset;
>> +	unsigned long addr = (unsigned long)p->addr;
>> +
>> +	while (tmp <= addr) {
>> +		if (tmp == addr)
>> +			return true;
>> +
>> +		tmp += GET_INSN_LENGTH(*(kprobe_opcode_t *)tmp);
> 
> kprobe_opcode_t is u32; This can trigger a misaligned load, right?

I think it depends on the hardware implementation, event an EEI may guarantee that misaligned
loads and stores are fully supported, hardware will requires additional sychronizatin to ensure
atomicity, so it is better to use a load instruction whose effective address is naturally aligned.

From "Volum I: RISC-V Unprivileged ISA 2.6":

"..., Loads and stores whose effective address is not naturally aligned to the referenced datatype
(i.e, the effective address is not divisible by the size of the access in bytes) have behavior
dependenet on the EEI."

> 
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>  {
>>  	unsigned long probe_addr = (unsigned long)p->addr;
>> @@ -55,6 +70,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>  	if (probe_addr & 0x1)
>>  		return -EILSEQ;
>>  
>> +	if (!arch_check_kprobe(p))
>> +		return -EILSEQ;
>> +
>>  	/* copy instruction */
>>  	p->opcode = *p->addr;
> 
> Not related to your patch, but this can also trigger a misaligned load.
> 
> 
> Björn

-- 
BR,
Liao, Chang
