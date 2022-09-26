Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0125D5EA9B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiIZPJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiIZPIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:08:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE9E58B4F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:40:42 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MbkNd2wpfzHpmT;
        Mon, 26 Sep 2022 21:38:25 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:40:40 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:40:38 +0800
Subject: Re: [PATCH RESEND v2 2/2] riscv: kprobe: Allow coexistence of ftrace
 and kprobe
To:     Guo Ren <guoren@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <palmer@dabbelt.com>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <jszhang@kernel.org>,
        <peterz@infradead.org>, <liaochang1@huawei.com>, <me@packi.ch>,
        <penberg@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220909023625.149651-1-lihuafei1@huawei.com>
 <20220909023625.149651-2-lihuafei1@huawei.com>
 <20220910122539.6f09af4ecf4e766bf94ed0a2@kernel.org>
 <51c98dd6-5897-6e8b-303c-270e946568f0@huawei.com>
 <CAJF2gTSn+PXxnHz2A8FeCAWDx_jqCtgfP2bdHVASPY8nfC5igA@mail.gmail.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <3e76afe3-f74d-b26b-64b4-7304b2f1293a@huawei.com>
Date:   Mon, 26 Sep 2022 21:40:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTSn+PXxnHz2A8FeCAWDx_jqCtgfP2bdHVASPY8nfC5igA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2022/9/25 20:45, Guo Ren wrote:
> Hi Li,
> 
> Current riscv ftrace detour instructions could be reduced to half [1].
> 
> Before optimization (16 byte):
> <func_prolog>:
>  0: REG_S  ra, -SZREG(sp)
>  4: auipc  ra, ?
>  8: jalr   ?(ra)
> 12: REG_L  ra, -SZREG(sp)
>  (func_boddy)
> 
> The previous implementation is from afc76b8b8011 ("riscv: Using
> PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
> 
> After optimization (8 byte):
> <func_prolog>:
>  0: auipc  t0, ?
>  4: jalr   t0, ?(t0)
>  (func_boddy)
> 
> [1]: https://lore.kernel.org/linux-riscv/20220921034910.3142465-4-guoren@kernel.org/

Nice patch! Thank you for the information. I will update my patch based
on it.

Thanks,
Huafei

> 
> I'm appreciate you could base it on that patch.
> 
> On Fri, Sep 23, 2022 at 4:43 PM Li Huafei <lihuafei1@huawei.com> wrote:
>>
>> Hi Masami,
>>
>> Thanks for your comment and sorry for the late reply.
>>
>> On 2022/9/10 11:25, Masami Hiramatsu (Google) wrote:
>>> Hi Li,
>>>
>>> On Fri, 9 Sep 2022 10:36:25 +0800
>>> Li Huafei <lihuafei1@huawei.com> wrote:
>>>
>>>> When using ftrace and kprobe at the same time, it was found that one
>>>> might cause the other to be unavailable. This can be reproduced by the
>>>> following steps.
>>>
>>> Yes, this must be solved by CONFIG_HAVE_KPROBES_ON_FTRACE.
>>>
>>>>
>>>>   # cd /sys/kernel/debug/tracing/
>>>>   # echo cmdline_proc_show > set_ftrace_filter
>>>>   # echo function > current_tracer
>>>>   # echo 'p cmdline_proc_show' > kprobe_events
>>>>   # echo 'p cmdline_proc_show+4' >> kprobe_events
>>>>   # ls events/kprobes/
>>>>   enable                 p_cmdline_proc_show_0
>>>>   filter                 p_cmdline_proc_show_4
>>>>   # echo 1 > events/kprobes/p_cmdline_proc_show_4/enable
>>>>   # echo 1 > events/kprobes/p_cmdline_proc_show_0/enable
>>>>   [  129.830108] 00000000ebed457d: expected (ffdb0097 4f0080e7) but got (00100073 4f0080e7)
>>>>   [  129.835990] ------------[ ftrace bug ]------------
>>>>   [  129.839510] ftrace failed to modify
>>>>   [  129.839536] [<ffffffff80258910>] cmdline_proc_show+0x0/0x46
>>>>   [  129.845831]  actual:   23:3c:11:fe:73:00:10:00
>>>>   [  129.849299] Updating ftrace call site to call a different ftrace function
>>>>   [  129.853998] ftrace record flags: e0000002
>>>>   [  129.856771]  (2) R
>>>>   [  129.856771]  expected tramp: ffffffff80008e60
>>>>   [  129.861688] ------------[ cut here ]------------
>>>>   [  129.865092] WARNING: CPU: 0 PID: 14 at kernel/trace/ftrace.c:2085 ftrace_bug+0x21a/0x24c
>>>>   [  129.870949] Modules linked in:
>>>>   [  129.873301] CPU: 0 PID: 14 Comm: migration/0 Not tainted 5.18.0-rc3-00002-gd8bfcd250f58 #6
>>>>   [  129.879217] Hardware name: riscv-virtio,qemu (DT)
>>>>   [  129.882666] Stopper: multi_cpu_stop+0x0/0x168 <- stop_machine_cpuslocked+0xfa/0x12e
>>>>   [  129.888430] epc : ftrace_bug+0x21a/0x24c
>>>>   [  129.891254]  ra : ftrace_bug+0x21a/0x24c
>>>>   [  129.894057] epc : ffffffff807c3bee ra : ffffffff807c3bee sp : ff20000000283c80
>>>>   [  129.899144]  gp : ffffffff813a83b8 tp : ff60000080021600 t0 : ffffffff804155c0
>>>>   [  129.904257]  t1 : 0720072007200720 t2 : 7420646574636570 s0 : ff20000000283cb0
>>>>   [  129.909402]  s1 : ff6000007fe622a0 a0 : 0000000000000022 a1 : c0000000ffffefff
>>>>   [  129.914472]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : 341adec112294700
>>>>   [  129.919487]  a5 : 341adec112294700 a6 : 0000000000000730 a7 : 0000000000000030
>>>>   [  129.924595]  s2 : ffffffff80258910 s3 : ffffffffffffffea s4 : 0000000000000000
>>>>   [  129.929776]  s5 : 0000000000000a35 s6 : ffffffff80d667c8 s7 : ff6000007fe04000
>>>>   [  129.934892]  s8 : 0000000000000004 s9 : 0000000000000002 s10: 0000000000000001
>>>>   [  129.939992]  s11: 0000000000000003 t3 : ff6000007ff20f00 t4 : ff6000007ff20f00
>>>>   [  129.945134]  t5 : ff6000007ff20000 t6 : ff200000002839c8
>>>>   [  129.948838] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
>>>>   [  129.954580] [<ffffffff800bf110>] ftrace_replace_code+0xce/0xd0
>>>>   [  129.958771] [<ffffffff800bf280>] ftrace_modify_all_code+0xb4/0x12c
>>>>   [  129.964420] [<ffffffff800bf30a>] __ftrace_modify_code+0x12/0x1c
>>>>   [  129.969163] [<ffffffff800b4ea4>] multi_cpu_stop+0x9a/0x168
>>>>   [  129.973035] [<ffffffff800b4b1c>] cpu_stopper_thread+0xb4/0x15e
>>>>   [  129.977205] [<ffffffff8003457a>] smpboot_thread_fn+0x106/0x1e4
>>>>   [  129.981277] [<ffffffff80030ca6>] kthread+0xee/0x108
>>>>   [  129.984763] [<ffffffff800039ba>] ret_from_exception+0x0/0xc
>>>>   [  129.988809] ---[ end trace 0000000000000000 ]---
>>>>   # cat trace
>>>>   # tracer: function
>>>>   #
>>>>   # WARNING: FUNCTION TRACING IS CORRUPTED
>>>>   #          MAY BE MISSING FUNCTION EVENTS
>>>>   # entries-in-buffer/entries-written: 0/0   #P:4
>>>>   #
>>>>   #                                _-----=> irqs-off/BH-disabled
>>>>   #                               / _----=> need-resched
>>>>   #                              | / _---=> hardirq/softirq
>>>>   #                              || / _--=> preempt-depth
>>>>   #                              ||| / _-=> migrate-disable
>>>>   #                              |||| /     delay
>>>>   #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>>>   #              | |         |   |||||     |         |
>>>>
>>>> As you can see, the ftrace functionality is broken. This is because
>>>> DYNAMIC_FTRACE uses 4 instructions to make the jump from the function
>>>> entry to the ftrace trampoline.
>>>>
>>>> After 'echo function > current_tracer':
>>>>
>>>>   <cmdline_proc_show>:
>>>>     0xffffffff80258910 <+0>:     sd      ra,-8(sp)
>>>>     0xffffffff80258914 <+4>:     auipc   ra,0xffdb0
>>>>     0xffffffff80258918 <+8>:     jalr    1264(ra) # 0xffffffff80008e04 <ftrace_caller>
>>>>     0xffffffff8025891c <+12>:    ld      ra,-8(sp)
>>>>
>>>> After 'echo 1 > events/kprobes/p_cmdline_proc_show_4/enable':
>>>>
>>>>   <cmdline_proc_show>:
>>>>     0xffffffff80258910 <+0>:     sd      ra,-8(sp)
>>>>     0xffffffff80258914 <+4>:     ebreak
>>>>     0xffffffff80258918 <+8>:     jalr    1264(ra)
>>>>     0xffffffff8025891c <+12>:    ld      ra,-8(sp)
>>>>
>>>> This time the second instruction is replaced with a breakpoint
>>>> instruction and the ftrace-related instructions are broken. Then, when
>>>> enabling 'p_cmdline_proc_show_0', a regs ftrace handler is registered
>>>> based on KPROBES_ON_FTRACE, ftrace_modify_call() changes 'ftrace_caller'
>>>> to 'ftrace_regs_caller', and checks for ftrace-related instructions is
>>>> modified or not. Here it has been modified, causing ftrace to report a
>>>> warning and disable itself.
>>>>
>>>> In turn, the breakpoints inserted by kprobe may be overwritten by
>>>> ftrace.
>>>
>>> In this case, we should NOT probe such address by kprobes. The reason
>>> why I introduce the CONFIG_KPROBES_ON_FTRACE is to avoid this issue.
>>>
>>
>> Yes, I think CONFIG_KPROBES_ON_FTRACE is mainly intended to solve the
>> problem of coexistence with ftrace and not just as an optimization.
>>
>>>
>>>>
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
>>
>> '/sys/kernel/debug/tracing/events/kprobes/' shows that we generated two
>> probe_events, but '/sys/kernel/debug/kprobes/list' shows that it is the
>> same address with two probes (aggr_kprobe).
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
>>
>> So for kprobe, can we consider all instructions before the "real"
>> instruction of the function as a virtual instruction? And then refuse to
>> probe the intermediate address of this virtual instruction to avoid
>> ambiguity for the user here.
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
>>>> @@ -77,6 +77,32 @@ do {                                                                      \
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
>>>> +#define INSN0       0xfe113c23
>>>> +#define INSN3       0xff813083
>>>> +#elif __riscv_xlen == 32
>>>> +#define INSN0       0xfe112e23
>>>> +#define INSN3       0xffc12083
>>>> +#endif
>>>> +
>>>> +#define FUNC_ENTRY_SIZE     16
>>>> +#define FUNC_ENTRY_JMP      4
>>>> +
>>>>  #ifndef __ASSEMBLY__
>>>>  struct dyn_ftrace;
>>>>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>>>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>>>> index 552088e9acc4..9d951aab662a 100644
>>>> --- a/arch/riscv/kernel/ftrace.c
>>>> +++ b/arch/riscv/kernel/ftrace.c
>>>> @@ -70,32 +70,6 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
>>>>      return 0;
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
>>>> -#define INSN0       0xfe113c23
>>>> -#define INSN3       0xff813083
>>>> -#elif __riscv_xlen == 32
>>>> -#define INSN0       0xfe112e23
>>>> -#define INSN3       0xffc12083
>>>> -#endif
>>>> -
>>>> -#define FUNC_ENTRY_SIZE     16
>>>> -#define FUNC_ENTRY_JMP      4
>>>> -
>>>>  int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>>>>  {
>>>>      unsigned int call[4] = {INSN0, 0, 0, INSN3};
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
>>>> +                                     bool *on_func_entry)
>>>> +{
>>>> +    /*
>>>> +     * The first 4 instructions at the beginning of the ftraced function
>>>> +     * are used as a jump to ftrace trampoline, which we can think of as
>>>> +     * a 16-byte virtual instruction. func+4, func+8 and func+12 will be
>>>> +     * changed to func+0. This allows the function entry to be probed with
>>>> +     * the help of KPROBES_ON_FTRACE and does not break ftrace
>>>> +     * functionality.
>>>> +     */
>>>> +    if (offset < FUNC_ENTRY_SIZE)
>>>> +            offset = 0;
>>>> +
>>>> +    *on_func_entry = !offset;
>>>> +    return (kprobe_opcode_t *)(addr + offset);
>>>> +}
>>>> +#endif
>>>> +
>>>>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>>>  {
>>>>      unsigned long offset = GET_INSN_LENGTH(p->opcode);
>>>> --
>>>> 2.17.1
>>>>
>>>
>>>
> 
> 
> 
