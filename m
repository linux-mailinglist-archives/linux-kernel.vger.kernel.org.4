Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC26D05E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjC3NII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjC3NIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:08:06 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ABB7ED9;
        Thu, 30 Mar 2023 06:08:02 -0700 (PDT)
Received: from [10.128.10.193] (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 1FD3D5802D6;
        Thu, 30 Mar 2023 21:07:46 +0800 (CST)
Message-ID: <fcfe5a83-f1a8-31cc-9eea-60033af65515@sangfor.com.cn>
Date:   Thu, 30 Mar 2023 21:07:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9 7/8] LoongArch: ftrace: Enable
 HAVE_FUNCTION_GRAPH_RETVAL
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        bp@alien8.de, hpa@zytor.com, zhangqing@loongson.cn,
        kernel@xen0n.name, mingo@redhat.com, peterz@infradead.org,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1680176068.git.pengdonglin@sangfor.com.cn>
 <df4919a76bbf733330158f6ec43c2d424b02d6e1.1680176068.git.pengdonglin@sangfor.com.cn>
 <CAAhV-H6OTxsbM53G4=YSmm0cDTBaAyKJ8zOS+UK6Wx-T7rvLSg@mail.gmail.com>
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
In-Reply-To: <CAAhV-H6OTxsbM53G4=YSmm0cDTBaAyKJ8zOS+UK6Wx-T7rvLSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkgZVh0YQ00YTxpPTE0dGFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PVE6PCo6OT0LH08YUSsTSR0V
        GgEwFDRVSlVKTUNLSkNKTU1MTEhOVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFCSExMNwY+
X-HM-Tid: 0a8732a1a59b2eb7kusn1fd3d5802d6
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/30 20:48, Huacai Chen wrote:
> Hi, Donglin,
> 
> On Thu, Mar 30, 2023 at 7:39 PM Donglin Peng <pengdonglin@sangfor.com.cn> wrote:
>>
>> The previous patch ("function_graph: Support recording and printing
>> the return value of function") has laid the groundwork for the for
>> the funcgraph-retval, and this modification makes it available on
>> the LoongArch platform.
>>
>> We introduce a new structure called fgraph_ret_regs for the LoongArch
>> platform to hold return registers and the frame pointer. We then fill
>> its content in the return_to_handler and pass its address to the
>> function ftrace_return_to_handler to record the return value.
>>
>> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
>> ---
>> v9:
>>   - Fix stack pointer align issues
>>   - Update the commit message
>>
>> v8:
>>   - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
>> ---
>>   arch/loongarch/Kconfig              |  1 +
>>   arch/loongarch/include/asm/ftrace.h | 20 ++++++++++++++++++++
>>   arch/loongarch/kernel/asm-offsets.c | 12 ++++++++++++
>>   arch/loongarch/kernel/mcount.S      | 14 ++++++++------
>>   arch/loongarch/kernel/mcount_dyn.S  | 15 ++++++++-------
>>   5 files changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 7fd51257e0ed..4bf60132869b 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -99,6 +99,7 @@ config LOONGARCH
>>          select HAVE_FAST_GUP
>>          select HAVE_FTRACE_MCOUNT_RECORD
>>          select HAVE_FUNCTION_ARG_ACCESS_API
>> +       select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>>          select HAVE_FUNCTION_GRAPH_TRACER
>>          select HAVE_FUNCTION_TRACER
>>          select HAVE_GENERIC_VDSO
>> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
>> index 3418d32d4fc7..01e7f92de03c 100644
>> --- a/arch/loongarch/include/asm/ftrace.h
>> +++ b/arch/loongarch/include/asm/ftrace.h
>> @@ -63,4 +63,24 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>>
>>   #endif /* CONFIG_FUNCTION_TRACER */
>>
>> +#ifndef __ASSEMBLY__
>> +struct fgraph_ret_regs {
>> +       /* a0 - a1 */
>> +       unsigned long regs[2];
>> +
>> +       unsigned long fp;
>> +       unsigned long __unused;
>> +};
>> +
>> +static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
>> +{
>> +       return ret_regs->regs[0];
>> +}
>> +
>> +static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
>> +{
>> +       return ret_regs->fp;
>> +}
>> +#endif
>> +
>>   #endif /* _ASM_LOONGARCH_FTRACE_H */
>> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
>> index 4bdb203fc66e..fab5bcddeb23 100644
>> --- a/arch/loongarch/kernel/asm-offsets.c
>> +++ b/arch/loongarch/kernel/asm-offsets.c
>> @@ -12,6 +12,7 @@
>>   #include <asm/cpu-info.h>
>>   #include <asm/ptrace.h>
>>   #include <asm/processor.h>
>> +#include <asm/ftrace.h>
>>
>>   void output_ptreg_defines(void)
>>   {
>> @@ -60,6 +61,17 @@ void output_ptreg_defines(void)
>>          BLANK();
>>   }
>>
>> +
>> +void output_fgraph_ret_regs_defines(void)
>> +{
>> +       COMMENT(" LoongArch fgraph_ret_regs offsets. ");
> No space needed at the beginning, and I prefer to move this function
> to the end of this file.
> 

Yes, I will fix it. I copy it from output_pbe_defines, and it has a
space at the beginning, so I will fix it too.

> Huacai
>> +       OFFSET(FGRET_REGS_A0, fgraph_ret_regs, regs[0]);
>> +       OFFSET(FGRET_REGS_A1, fgraph_ret_regs, regs[1]);
>> +       OFFSET(FGRET_REGS_FP, fgraph_ret_regs, fp);
>> +       DEFINE(FGRET_REGS_SIZE, sizeof(struct fgraph_ret_regs));
>> +       BLANK();
>> +}
>> +
>>   void output_task_defines(void)
>>   {
>>          COMMENT("LoongArch task_struct offsets.");
>> diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcount.S
>> index 8cdc1563cd33..cb8e5803de4b 100644
>> --- a/arch/loongarch/kernel/mcount.S
>> +++ b/arch/loongarch/kernel/mcount.S
>> @@ -79,18 +79,20 @@ SYM_FUNC_START(ftrace_graph_caller)
>>   SYM_FUNC_END(ftrace_graph_caller)
>>
>>   SYM_FUNC_START(return_to_handler)
>> -       PTR_ADDI        sp, sp, -2 * SZREG
>> -       PTR_S           a0, sp, 0
>> -       PTR_S           a1, sp, SZREG
>> +       PTR_ADDI        sp, sp, -FGRET_REGS_SIZE
>> +       PTR_S           a0, sp, FGRET_REGS_A0
>> +       PTR_S           a1, sp, FGRET_REGS_A1
>> +       PTR_S           zero, sp, FGRET_REGS_FP
>>
>> +       move            a0, sp
>>          bl              ftrace_return_to_handler
>>
>>          /* Restore the real parent address: a0 -> ra */
>>          move            ra, a0
>>
>> -       PTR_L           a0, sp, 0
>> -       PTR_L           a1, sp, SZREG
>> -       PTR_ADDI        sp, sp, 2 * SZREG
>> +       PTR_L           a0, sp, FGRET_REGS_A0
>> +       PTR_L           a1, sp, FGRET_REGS_A1
>> +       PTR_ADDI        sp, sp, FGRET_REGS_SIZE
>>          jr              ra
>>   SYM_FUNC_END(return_to_handler)
>>   #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>> diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
>> index bbabf06244c2..ec24ae1de741 100644
>> --- a/arch/loongarch/kernel/mcount_dyn.S
>> +++ b/arch/loongarch/kernel/mcount_dyn.S
>> @@ -131,18 +131,19 @@ SYM_CODE_END(ftrace_graph_caller)
>>
>>   SYM_CODE_START(return_to_handler)
>>          /* Save return value regs */
>> -       PTR_ADDI        sp, sp, -2 * SZREG
>> -       PTR_S           a0, sp, 0
>> -       PTR_S           a1, sp, SZREG
>> +       PTR_ADDI        sp, sp, -FGRET_REGS_SIZE
>> +       PTR_S           a0, sp, FGRET_REGS_A0
>> +       PTR_S           a1, sp, FGRET_REGS_A1
>> +       PTR_S           zero, sp, FGRET_REGS_FP
>>
>> -       move            a0, zero
>> +       move            a0, sp
>>          bl              ftrace_return_to_handler
>>          move            ra, a0
>>
>>          /* Restore return value regs */
>> -       PTR_L           a0, sp, 0
>> -       PTR_L           a1, sp, SZREG
>> -       PTR_ADDI        sp, sp, 2 * SZREG
>> +       PTR_L           a0, sp, FGRET_REGS_A0
>> +       PTR_L           a1, sp, FGRET_REGS_A1
>> +       PTR_ADDI        sp, sp, FGRET_REGS_SIZE
>>
>>          jr              ra
>>   SYM_CODE_END(return_to_handler)
>> --
>> 2.25.1
>>

