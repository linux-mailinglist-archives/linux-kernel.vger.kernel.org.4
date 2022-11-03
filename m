Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136416173B6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKCBXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCBXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:23:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A0F62D7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:23:51 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N2mHN2JRVzbcCw;
        Thu,  3 Nov 2022 09:23:44 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 09:23:48 +0800
Message-ID: <9cee98fa-fa5c-9b3e-505b-6e86f526a027@huawei.com>
Date:   Thu, 3 Nov 2022 09:23:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/8] riscv/kprobe: Prepare the skeleton to implement RISCV
 OPTPROBES feature
To:     Conor Dooley <conor@kernel.org>
CC:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
 <20221030090141.2550837-2-chenguokai17@mails.ucas.ac.cn>
 <Y2AlEcVRibarLp8a@spud> <1fe22055-7458-e052-4438-0338da9e369c@huawei.com>
 <Y2GsIIckeiZnNA3T@spud>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <Y2GsIIckeiZnNA3T@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



在 2022/11/2 7:30, Conor Dooley 写道:
> On Tue, Nov 01, 2022 at 07:07:44PM +0800, liaochang (A) wrote:
>> Hi，Conor,
>>
>> 在 2022/11/1 3:42, Conor Dooley 写道:
>>> Hey Chen Guokai,
>>>
>>> On Sun, Oct 30, 2022 at 05:01:34PM +0800, Chen Guokai wrote:
>>>> From: Liao Chang <liaochang1@huawei.com>
>>>>
>>>> Prepare skeleton to implement optimized kprobe on RISCV, it consists
>>>> of Makfile, Kconfig and some architecture specific files: kprobe.h and
>>>> opt.c opt.c includes some macro, type definition and functions required
>>>> by kprobe framework, opt_trampoline.S provides a piece of assembly code
>>>> template used to construct the detour buffer as the target of long jump
>>>> instruction(s) for each optimzed kprobe.
>>>>
>>>> Since the jump range of PC-relative instruction JAL is +/-1M, that is
>>>> too small to reach the detour buffer, hence the foudamental idea to
>>>> address OPTPROBES on RISCV is to replace 'EBREAK' with 'AUIPC+JALR'. which
>>>> means it needs to clobber one more instruction beside the kprobe
>>>> instruction, furthermore, RISCV supports hybird RVI and RVC in single
>>>> kernel binary, so in theory a pair of 'AUIPC/JALR' is about to clobber
>>>> 10 bytes(3 RVC and 1 RVI, 2 bytes is padding for alignment) at worst
>>>> case. The second hardsome problem is looking for one integer register as
>>>> the destination of 'AUIPC/JALR' without any side-effect.
>>>>
>>>> More solution details will be introduced in the coming commits.
>>>
>>> nit: you can drop this reference to future commits.
>>>
>>>>
>>>> Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
>>>> Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>>
>>> FYI, your signoff should come last since you're sending the patches, so
>>> this would become:
>>>
>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>>> Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
>>>> Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
>>>
>>> I noticed on some of the other patches that your SoB is missing there,
>>> for example patch 2.
>>
>> Yes, i have sent patch 2 to mailing list long time ago, got some feedback from
>> Palmer Debbelt. Because that patch is designed for riscv optprobe, so i bring it
>> to this patchset.
> 
> Not sure if you understood the point I was making - you need to have a 
> Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> at the end of every patch that Chen sends. Patch 2 does not have one.
> For the other patches, the order should be you, followed by Chen since
> they are the one that sent the patch to the list this time.
> 
> See:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> Or:
> Documentation/translations/zh_CN/process/submitting-patches.rst
> 
> In the zh_CN document, the relevant section is:
> 何时使用Acked-by:，CC:，和Co-Developed by:

Thanks for your explanation, it is very clear and helpful, i will make SoB correct.

Thanks.
> 
> Hope that helps,
> Conor.
> 
>>>> ---
>>>>  arch/riscv/Kconfig                        |  1 +
>>>>  arch/riscv/include/asm/kprobes.h          | 32 ++++++++++++++
>>>>  arch/riscv/kernel/probes/Makefile         |  1 +
>>>>  arch/riscv/kernel/probes/opt.c            | 51 +++++++++++++++++++++++
>>>>  arch/riscv/kernel/probes/opt_trampoline.S | 12 ++++++
>>>>  5 files changed, 97 insertions(+)
>>>>  create mode 100644 arch/riscv/kernel/probes/opt.c
>>>>  create mode 100644 arch/riscv/kernel/probes/opt_trampoline.S
>>>>
>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>> index 6b48a3ae9843..ca29306c93e2 100644
>>>> --- a/arch/riscv/Kconfig
>>>> +++ b/arch/riscv/Kconfig
>>>> @@ -99,6 +99,7 @@ config RISCV
>>>>  	select HAVE_KPROBES if !XIP_KERNEL
>>>>  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>>>>  	select HAVE_KRETPROBES if !XIP_KERNEL
>>>> +	select HAVE_OPTPROBES if !XIP_KERNEL
>>>>  	select HAVE_MOVE_PMD
>>>>  	select HAVE_MOVE_PUD
>>>>  	select HAVE_PCI
>>>> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
>>>> index 217ef89f22b9..22b73a2fd1fd 100644
>>>> --- a/arch/riscv/include/asm/kprobes.h
>>>> +++ b/arch/riscv/include/asm/kprobes.h
>>>> @@ -43,5 +43,37 @@ bool kprobe_single_step_handler(struct pt_regs *regs);
>>>>  void __kretprobe_trampoline(void);
>>>>  void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>>>>  
>>>> +#ifdef CONFIG_OPTPROBES
>>>> +
>>>> +/* optinsn template addresses */
>>>> +extern __visible kprobe_opcode_t optprobe_template_entry[];
>>>> +extern __visible kprobe_opcode_t optprobe_template_end[];
>>>> +
>>>> +#define MAX_OPTINSN_SIZE				\
>>>> +	((unsigned long)optprobe_template_end -		\
>>>> +	 (unsigned long)optprobe_template_entry)
>>>> +
>>>> +/*
>>>> + * For RVI and RVC hybird encoding kernel, althought long jump just needs
>>>> + * 2 RVI instructions(AUIPC+JALR), optimized instructions is 10 bytes long
>>>> + * at most to ensure no RVI would be truncated actually, so it means four
>>>> + * combinations:
>>>> + * - 2 RVI
>>>> + * - 4 RVC
>>>> + * - 2 RVC + 1 RVI
>>>> + * - 3 RVC + 1 RVI (truncated, need padding)
>>>> + */
>>>> +#define MAX_COPIED_INSN		4
>>>> +#define MAX_OPTIMIZED_LENGTH	10
>>>> +
>>>> +struct arch_optimized_insn {
>>>> +	kprobe_opcode_t copied_insn[MAX_COPIED_INSN];
>>>> +	/* detour code buffer */
>>>> +	kprobe_opcode_t *insn;
>>>> +	unsigned long length;
>>>> +	int rd;
>>>> +};
>>>> +
>>>> +#endif /* CONFIG_OPTPROBES */
>>>>  #endif /* CONFIG_KPROBES */
>>>>  #endif /* _ASM_RISCV_KPROBES_H */
>>>> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
>>>> index 7f0840dcc31b..6255b4600875 100644
>>>> --- a/arch/riscv/kernel/probes/Makefile
>>>> +++ b/arch/riscv/kernel/probes/Makefile
>>>> @@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
>>>>  obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
>>>>  obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
>>>>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
>>>> +obj-$(CONFIG_OPTPROBES)		+= opt.o opt_trampoline.o
>>>>  CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
>>>> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
>>>> new file mode 100644
>>>> index 000000000000..56c8a227c857
>>>> --- /dev/null
>>>> +++ b/arch/riscv/kernel/probes/opt.c
>>>> @@ -0,0 +1,51 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + *  Kernel Probes Jump Optimization (Optprobes)
>>>> + *
>>>> + * Copyright (C) Guokai Chen, 2022
>>>> + * Author: Guokai Chen chenguokai17@mails.ucas.ac.cn
>>>> + */
>>>> +
>>>> +#define pr_fmt(fmt)	"optprobe: " fmt
>>>> +
>>>> +#include <linux/kprobes.h>
>>>> +#include <asm/kprobes.h>
>>>> +
>>>> +int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
>>>> +				  struct kprobe *orig)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
>>>> +{
>>>> +}
>>>> +
>>>> +void arch_optimize_kprobes(struct list_head *oplist)
>>>> +{
>>>> +}
>>>> +
>>>> +void arch_unoptimize_kprobes(struct list_head *oplist,
>>>> +			     struct list_head *done_list)
>>>> +{
>>>> +}
>>>> +
>>>> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>>>> +{
>>>> +}
>>>> +
>>>> +int arch_within_optimized_kprobe(struct optimized_kprobe *op,
>>>> +				 kprobe_opcode_t *addr)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> diff --git a/arch/riscv/kernel/probes/opt_trampoline.S b/arch/riscv/kernel/probes/opt_trampoline.S
>>>> new file mode 100644
>>>> index 000000000000..16160c4367ff
>>>> --- /dev/null
>>>> +++ b/arch/riscv/kernel/probes/opt_trampoline.S
>>>> @@ -0,0 +1,12 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Copyright (C) 2022 Guokai Chen
>>>> + */
>>>> +
>>>> +#include <linux/linkage.h>
>>>> +
>>>> +#incldue <asm/csr.h>
>>>> +#include <asm/asm-offsets.h>
>>>> +
>>>> +SYM_ENTRY(optprobe_template_entry, SYM_L_GLOBAL, SYM_A_NONE)
>>>> +SYM_ENTRY(optprobe_template_end, SYM_L_GLOBAL, SYM_A_NONE)
>>>> -- 
>>>> 2.25.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>> .
>>
>> -- 
>> BR,
>> Liao, Chang
> .

-- 
BR,
Liao, Chang
