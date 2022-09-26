Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0C05EA958
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiIZO5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiIZO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:57:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575D2491D4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:28:06 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mbk5L2lwZzpVZ6;
        Mon, 26 Sep 2022 21:25:10 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:28:04 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:28:03 +0800
Subject: Re: [PATCH RESEND v2 2/2] riscv: kprobe: Allow coexistence of ftrace
 and kprobe
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <guoren@kernel.org>, <palmer@dabbelt.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <jszhang@kernel.org>, <peterz@infradead.org>,
        <liaochang1@huawei.com>, <me@packi.ch>, <penberg@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220909023625.149651-1-lihuafei1@huawei.com>
 <20220909023625.149651-2-lihuafei1@huawei.com>
 <20220910122539.6f09af4ecf4e766bf94ed0a2@kernel.org>
 <51c98dd6-5897-6e8b-303c-270e946568f0@huawei.com>
 <20220925135617.8c7851fde494635fa3c2562a@kernel.org>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <ec9f3162-c97d-a19e-e676-1ab71fccba32@huawei.com>
Date:   Mon, 26 Sep 2022 21:28:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20220925135617.8c7851fde494635fa3c2562a@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/25 12:56, Masami Hiramatsu (Google) wrote:
> On Fri, 23 Sep 2022 16:43:43 +0800
> Li Huafei <lihuafei1@huawei.com> wrote:
> 
>>>> The problem is that we think that only the first instruction address at
>>>> the function entry is needed for ftrace, but it is actually the first 4.
>>>> As Masami mentioned in [1], we can treat the first 4 instructions as a
>>>> 16-byte virtual instruction, and func+4, func+8 and func+12 will be
>>>> changed to func+0. This way, ftrace and kprobe do not bother each other
>>>> and can coexist.
>>>>
>>>> After this patch:
>>>>
>>>>   # cd /sys/kernel/debug/tracing/
>>>>   # echo cmdline_proc_show > set_ftrace_filter
>>>>   # echo function > current_tracer
>>>>   # echo 'p cmdline_proc_show' > kprobe_events
>>>>   # echo 'p cmdline_proc_show+4' >> kprobe_events
>>>>   # echo 'p cmdline_proc_show+8' >> kprobe_events
>>>>   # echo 'p cmdline_proc_show+12' >> kprobe_events
>>>>   # echo 'p cmdline_proc_show+16' >> kprobe_events
>>>
>>> Oh, no, I meant, if it is a 16 byte virtual insturiction, it should
>>> reject probing the address inside the instruction. It is rejected as
>>> same as the case you probe "function+1" address (that is not an
>>> instruction boundary, right?)
>>>
>>> So, it should reject it instead of modifying the probed address. (Return
>>>  -EILSEQ) It is usual there is any instruction which can not be probed.
> 
> I think it should return -EBUSY, because this is ftrace reserved area.
> 

What you mean is:

  sym+0 => OK
  sym+offset(0<offset<16) => -EBUSY

If so, I think we can put the check that we can't probe the ftrace
reserved area into arch_prepare_kprobe(), something like this(just an
idea, not tested):

 diff --git a/arch/riscv/kernel/probes/kprobes.c
b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7cf32..0e38be896a73 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -48,6 +48,16 @@ static void __kprobes arch_simulate_insn(struct
kprobe *p, struct pt_regs *regs)
        post_kprobe_handler(p, kcb, regs);
 }

+static bool is_ftrace_reserved(unsigned long addr)
+{
+       unsigned long offset;
+
+       if(WARN_ON(!kallsyms_lookup_size_offset(addr, NULL, &offset)))
+               return false;
+
+       return offset > 0 && offset < 16;
+}
+
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
        unsigned long probe_addr = (unsigned long)p->addr;
@@ -55,6 +65,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
        if (probe_addr & 0x1)
                return -EILSEQ;

+       if (is_ftrace_reserved(probe_addr))
+               return -EBUSY;
+
        /* copy instruction */
        p->opcode = *p->addr;

Now riscv doesn't need to implement arch_adjust_kprobe_addr() for now.

>>>
>>> Or, is there any real reason you "have to" probe such intermediate 
>>> address?
>>
>> No. In fact in my first version of the patch(see [1]),
>> arch_adjust_kprobe_addr() returned -EILSEQ when probing intermediate
>> addresses. but Guo pointed out that I changed the API and it did.
>>
>> Currently there are x86 & powerpc using their own arch_adjust_kprobe_addr().
>>
>> On x86, when X86_KERNEL_IBT is enabled, arch_adjust_kprobe_addr()
>> adjusts sym+0 (endbr) to sym+4 (ftrace location). If we probe through
>> kprobe_events, we get:
>>
>>     # cd /sys/kernel/debug/tracing/
>>     # echo 'p cmdline_proc_show' > kprobe_events
>>     # echo 'p cmdline_proc_show+4' >> kprobe_events
>>     # ls events/kprobes/
>>     enable                 p_cmdline_proc_show_0
>>     filter                 p_cmdline_proc_show_4
>>     # cat /sys/kernel/debug/kprobes/list
>>     ffffffff812d31e4  k  cmdline_proc_show+0x4    [DISABLED][FTRACE]
>>     ffffffff812d31e4  k  cmdline_proc_show+0x4    [DISABLED][FTRACE]
> 
> This is because 
> 
>  - X86_KERNEL_IBT is an option.
>  - endbr is considered as a nop. (No accessible register has been changed)
>  - endbr is not involved in the ftrace itself.
> 

Yes, I agree.

> I think I'd better to warn user that with X86_KERNEL_IBT the
> probed address seems different in the document, because this

I think it can be clarified, although there may not be many users who
are confused now. :)

> result seems something wrong. (see the event address is different
> from where user specified.)
> 
>              cat-152     [003] .....   340.044650: p_cmdline_proc_show_4: (cmdline_proc_show+0x4/0x30)
>              cat-152     [003] .....   340.044652: p_cmdline_proc_show_0: (cmdline_proc_show+0x4/0x30)
> 
> BPF is also working on this issue now;
> 
> https://lore.kernel.org/all/20220922210320.1076658-1-jolsa@kernel.org/T/#u
> 
> Maybe ftrace also should change to show the event address as +0
> if the kprobe is on the function entry.
> 
> 
> Anyway, so What you are doing is something like below;
> 
>     # echo 'p cmdline_proc_show+5' > kprobe_events
>     # echo 'p cmdline_proc_show+6' > kprobe_events
>     # echo 'p cmdline_proc_show+7' > kprobe_events
>     # echo 'p cmdline_proc_show+8' > kprobe_events
> 
> All of those will fail because there is an ftrace replaced 5 byte nop
> and it should NOT be replaced by the kprobes.
> 
>> '/sys/kernel/debug/tracing/events/kprobes/' shows that we generated two
>> probe_events, but '/sys/kernel/debug/kprobes/list' shows that it is the
>> same address with two probes (aggr_kprobe).
> 
> Yes, this is because the endbr is a special instruction, not the
> ftrace instruction. When arm64 instroduces similar instruction,
> we have to do similar thing.
> 
>>
>> The same is true for powerpc:
>>
>>     # cd /sys/kernel/debug/tracing/
>>     # echo 'p cmdline_proc_show' > kprobe_events
>>     # echo 'p cmdline_proc_show+12' >> kprobe_events
>>     # ls events/kprobes/
>>     enable                  p_cmdline_proc_show_0
>>     filter                  p_cmdline_proc_show_12
>>     # cat /sys/kernel/debug/kprobes/list
>>     c000000000515c0c  k  cmdline_proc_show+0xc    [DISABLED][FTRACE]
>>     c000000000515c0c  k  cmdline_proc_show+0xc    [DISABLED][FTRACE]
>>     c0000000000508c0  k  __kretprobe_trampoline+0x0    [OPTIMIZED]
> 
> OK, so what about following rule?
> 
> kprobes on ftrace only accept the cases if the probe address is
> either 
> - func + 0 (as function entry)
> - func + offset, where the offset is what the ftrace returns.
> 

Yes, I agree. For riscv these two addresses are the same, i.e. func+0.


Thanks,
Huafei

> If ftrace shows the IP (PC) is func+0 (x86 without endbr) it allows
> only func+0. If it shows IP (PC) is func+4, it allows both func + 0
> and func+4. But not allows other offsets for kprobes on ftrace because
> such intermediate address doesn't have any means and no difference.
> (the register sets also same)
> This doesn't break even if you introduces something like endbr on
> RISC-V in the future too.
> 
>> 	
>> So for kprobe, can we consider all instructions before the "real"
>> instruction of the function as a virtual instruction?
> 
> Yes, as far as those are the "ftrace reserved" instructions.
> 
>> And then refuse to
>> probe the intermediate address of this virtual instruction to avoid
>> ambiguity for the user here.
> 
> Yes.
> 
> Thank you,
> 
>>
>> [1]
>> https://lore.kernel.org/lkml/20220426015751.88582-2-lihuafei1@huawei.com/
>>
>> Thanks,
>> Huafei
>>
>>>
>>> Thank you,
>>>
>>>>   # ls events/kprobes/
>>>>   enable                  p_cmdline_proc_show_12  p_cmdline_proc_show_8
>>>>   filter                  p_cmdline_proc_show_16
>>>>   p_cmdline_proc_show_0   p_cmdline_proc_show_4
>>>>   # echo 1 > events/kprobes/enable
>>>>   # cat ../kprobes/list
>>>>   ffffffff8025cba4  k  cmdline_proc_show+0x0    [FTRACE]
>>>>   ffffffff8025cba4  k  cmdline_proc_show+0x0    [FTRACE]
>>>>   ffffffff8025cba4  k  cmdline_proc_show+0x0    [FTRACE]
>>>>   ffffffff8025cba4  k  cmdline_proc_show+0x0    [FTRACE]
>>>>   ffffffff8025cbb4  k  cmdline_proc_show+0x10
>>>>   # cat /proc/cmdline
>>>>   nokaslr rootwait root=/dev/vda rw
>>>>   # cat trace
>>>>   # tracer: function
>>>>   #
>>>>   # entries-in-buffer/entries-written: 6/6   #P:4
>>>>   #
>>>>   #                                _-----=> irqs-off/BH-disabled
>>>>   #                               / _----=> need-resched
>>>>   #                              | / _---=> hardirq/softirq
>>>>   #                              || / _--=> preempt-depth
>>>>   #                              ||| / _-=> migrate-disable
>>>>   #                              |||| /     delay
>>>>   #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>>>   #              | |         |   |||||     |         |
>>>>                cat-144     [000] ...2.   179.164908: p_cmdline_proc_show_12: (cmdline_proc_show+0x0/0x46)
>>>>                cat-144     [000] ...2.   179.165617: p_cmdline_proc_show_8: (cmdline_proc_show+0x0/0x46)
>>>>                cat-144     [000] ...2.   179.165653: p_cmdline_proc_show_4: (cmdline_proc_show+0x0/0x46)
>>>>                cat-144     [000] ...2.   179.165655: p_cmdline_proc_show_0: (cmdline_proc_show+0x0/0x46)
>>>>                cat-144     [000] ...2.   179.165837: cmdline_proc_show <-seq_read_iter
>>>>                cat-144     [000] d....   179.166099: p_cmdline_proc_show_16: (cmdline_proc_show+0x10/0x46)
>>>>
>>>> [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20191218140622.57bbaca5@xhacker.debian/
>>>>
>>>> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
>>>> Suggested-by: Guo Ren <guoren@kernel.org>
>>>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>>>> ---
>>>> v1: https://lore.kernel.org/lkml/20220426015751.88582-1-lihuafei1@huawei.com/
>>>> v2: https://lore.kernel.org/lkml/20220819025522.154189-2-lihuafei1@huawei.com/
>>>>
>>>> v2 RESEND:
>>>>  - Rebase onto v6.0-rc4.
>>>>
>>>> Changlog in v1 -> v2:
>>>>  - Allows probing func+offs(<16) instead of returning -EILSEQ, which
>>>>    does not change the arch_adjust_kprobe_addr() interface convention.
>>>>  - ftrace_location(addr) is unnecessary, consistent with powerpc and
>>>>    x86.
>>>>
>>>>  arch/riscv/include/asm/ftrace.h    | 26 ++++++++++++++++++++++++++
>>>>  arch/riscv/kernel/ftrace.c         | 26 --------------------------
>>>>  arch/riscv/kernel/probes/kprobes.c | 20 ++++++++++++++++++++
>>>>  3 files changed, 46 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
>>>> index 04dad3380041..c59e4a63f1c1 100644
>>>> --- a/arch/riscv/include/asm/ftrace.h
>>>> +++ b/arch/riscv/include/asm/ftrace.h
>>>> @@ -77,6 +77,32 @@ do {									\
>>>>   */
>>>>  #define MCOUNT_INSN_SIZE 8
>>>>  
>>>> +/*
>>>> + * Put 16 bytes at the front of the function within the patchable function
>>>> + * entry nops' area.
>>>> + *
>>>> + * 0: REG_S  ra, -SZREG(sp)
>>>> + * 1: auipc  ra, 0x?
>>>> + * 2: jalr   -?(ra)
>>>> + * 3: REG_L  ra, -SZREG(sp)
>>>> + *
>>>> + * So the opcodes is:
>>>> + * 0: 0xfe113c23 (sd)/0xfe112e23 (sw)
>>>> + * 1: 0x???????? -> auipc
>>>> + * 2: 0x???????? -> jalr
>>>> + * 3: 0xff813083 (ld)/0xffc12083 (lw)
>>>> + */
>>>> +#if __riscv_xlen == 64
>>>> +#define INSN0	0xfe113c23
>>>> +#define INSN3	0xff813083
>>>> +#elif __riscv_xlen == 32
>>>> +#define INSN0	0xfe112e23
>>>> +#define INSN3	0xffc12083
>>>> +#endif
>>>> +
>>>> +#define FUNC_ENTRY_SIZE	16
>>>> +#define FUNC_ENTRY_JMP	4
>>>> +
>>>>  #ifndef __ASSEMBLY__
>>>>  struct dyn_ftrace;
>>>>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>>>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>>>> index 552088e9acc4..9d951aab662a 100644
>>>> --- a/arch/riscv/kernel/ftrace.c
>>>> +++ b/arch/riscv/kernel/ftrace.c
>>>> @@ -70,32 +70,6 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -/*
>>>> - * Put 16 bytes at the front of the function within the patchable function
>>>> - * entry nops' area.
>>>> - *
>>>> - * 0: REG_S  ra, -SZREG(sp)
>>>> - * 1: auipc  ra, 0x?
>>>> - * 2: jalr   -?(ra)
>>>> - * 3: REG_L  ra, -SZREG(sp)
>>>> - *
>>>> - * So the opcodes is:
>>>> - * 0: 0xfe113c23 (sd)/0xfe112e23 (sw)
>>>> - * 1: 0x???????? -> auipc
>>>> - * 2: 0x???????? -> jalr
>>>> - * 3: 0xff813083 (ld)/0xffc12083 (lw)
>>>> - */
>>>> -#if __riscv_xlen == 64
>>>> -#define INSN0	0xfe113c23
>>>> -#define INSN3	0xff813083
>>>> -#elif __riscv_xlen == 32
>>>> -#define INSN0	0xfe112e23
>>>> -#define INSN3	0xffc12083
>>>> -#endif
>>>> -
>>>> -#define FUNC_ENTRY_SIZE	16
>>>> -#define FUNC_ENTRY_JMP	4
>>>> -
>>>>  int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>>>>  {
>>>>  	unsigned int call[4] = {INSN0, 0, 0, INSN3};
>>>> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
>>>> index e6e950b7cf32..ef7aabec9681 100644
>>>> --- a/arch/riscv/kernel/probes/kprobes.c
>>>> +++ b/arch/riscv/kernel/probes/kprobes.c
>>>> @@ -21,6 +21,26 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>>>  static void __kprobes
>>>>  post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>>>>  
>>>> +#ifdef CONFIG_DYNAMIC_FTRACE
>>>> +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
>>>> +					 bool *on_func_entry)
>>>> +{
>>>> +	/*
>>>> +	 * The first 4 instructions at the beginning of the ftraced function
>>>> +	 * are used as a jump to ftrace trampoline, which we can think of as
>>>> +	 * a 16-byte virtual instruction. func+4, func+8 and func+12 will be
>>>> +	 * changed to func+0. This allows the function entry to be probed with
>>>> +	 * the help of KPROBES_ON_FTRACE and does not break ftrace
>>>> +	 * functionality.
>>>> +	 */
>>>> +	if (offset < FUNC_ENTRY_SIZE)
>>>> +		offset = 0;
>>>> +
>>>> +	*on_func_entry = !offset;
>>>> +	return (kprobe_opcode_t *)(addr + offset);
>>>> +}
>>>> +#endif
>>>> +
>>>>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>>>  {
>>>>  	unsigned long offset = GET_INSN_LENGTH(p->opcode);
>>>> -- 
>>>> 2.17.1
>>>>
>>>
>>>
> 
> 
