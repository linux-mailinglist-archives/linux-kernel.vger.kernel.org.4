Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB846CD133
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjC2Eba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC2Eb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:31:28 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDBC210C;
        Tue, 28 Mar 2023 21:31:25 -0700 (PDT)
Received: from [10.128.10.193] (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 42A495801FC;
        Wed, 29 Mar 2023 12:31:15 +0800 (CST)
Message-ID: <115b1771-8204-749a-0a93-7835e74ea6ba@sangfor.com.cn>
Date:   Wed, 29 Mar 2023 12:31:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 7/8] LoongArch: ftrace: Enable
 HAVE_FUNCTION_GRAPH_RETVAL
Content-Language: en-US
To:     Qing Zhang <zhangqing@loongson.cn>, mhiramat@kernel.org,
        rostedt@goodmis.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        chenhuacai@kernel.org, kernel@xen0n.name, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230328134319.2185812-1-pengdonglin@sangfor.com.cn>
 <20230328134319.2185812-8-pengdonglin@sangfor.com.cn>
 <28389252-4611-977f-ab80-baeca99d9080@loongson.cn>
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
In-Reply-To: <28389252-4611-977f-ab80-baeca99d9080@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxlMVkMaGhkaGE5CTk1KS1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6ITo4Hj0PTEstSjoqPUgu
        VilPCz5VSlVKTUNLS01PSUxNTU9MVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFMQ09PNwY+
X-HM-Tid: 0a872ba266f92eb7kusn42a495801fc
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/29 12:08, Qing Zhang wrote:
> Hi, Donglin
> 
> On 2023/3/28 下午9:43, Donglin Peng wrote:
>> The commit d4815c5d1bbd ("function_graph: Support recording and
>> printing the return value of function") laid the groundwork for the
>> for the funcgraph-retval, and this modification makes it available
>> on the LoongArch platform.
>>
>> We introduce a new structure called fgraph_ret_regs for the LoongArch
>> platform to hold return registers and the frame pointer. We then fill
>> its content in the return_to_handler and pass its address to the
>> function ftrace_return_to_handler to record the return value.
>>
>> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
>> ---
>> v8:
>>   - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
>> ---
>>   arch/loongarch/Kconfig              |  1 +
>>   arch/loongarch/include/asm/ftrace.h | 18 ++++++++++++++++++
>>   arch/loongarch/kernel/mcount.S      |  6 ++++--
>>   arch/loongarch/kernel/mcount_dyn.S  |  7 ++++---
>>   4 files changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 7fd51257e0ed..4bf60132869b 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -99,6 +99,7 @@ config LOONGARCH
>>       select HAVE_FAST_GUP
>>       select HAVE_FTRACE_MCOUNT_RECORD
>>       select HAVE_FUNCTION_ARG_ACCESS_API
>> +    select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>>       select HAVE_FUNCTION_GRAPH_TRACER
>>       select HAVE_FUNCTION_TRACER
>>       select HAVE_GENERIC_VDSO
>> diff --git a/arch/loongarch/include/asm/ftrace.h 
>> b/arch/loongarch/include/asm/ftrace.h
>> index 3418d32d4fc7..433c6218888b 100644
>> --- a/arch/loongarch/include/asm/ftrace.h
>> +++ b/arch/loongarch/include/asm/ftrace.h
>> @@ -63,4 +63,22 @@ void ftrace_graph_func(unsigned long ip, unsigned 
>> long parent_ip,
>>   #endif /* CONFIG_FUNCTION_TRACER */
>> +#ifndef __ASSEMBLY__
>> +struct fgraph_ret_regs {
>> +    unsigned long a0;
>> +    unsigned long a1;
>> +    unsigned long fp;
>> +};
> 
> This overall looks good, but some places need attention:
> 
> This will need to be padded to 16 bytes, as within the kernel,
> loongarch requires the SP to be aligned to 16 bytes at all time.
> Please can you add an `__unused/padding` field to ensure.

Thank you for pointing out this issue, and I will fix it.

>> +
>> +static inline unsigned long fgraph_ret_regs_return_value(struct 
>> fgraph_ret_regs *ret_regs)
>> +{
>> +    return ret_regs->a0;
>> +}
>> +
>> +static inline unsigned long fgraph_ret_regs_frame_pointer(struct 
>> fgraph_ret_regs *ret_regs)
>> +{
>> +    return ret_regs->fp;
>> +}
>> +#endif
>> +
>>   #endif /* _ASM_LOONGARCH_FTRACE_H */
>> diff --git a/arch/loongarch/kernel/mcount.S 
>> b/arch/loongarch/kernel/mcount.S
>> index 8cdc1563cd33..3e405c0212c0 100644
>> --- a/arch/loongarch/kernel/mcount.S
>> +++ b/arch/loongarch/kernel/mcount.S
>> @@ -79,10 +79,12 @@ SYM_FUNC_START(ftrace_graph_caller)
>>   SYM_FUNC_END(ftrace_graph_caller)
>>   SYM_FUNC_START(return_to_handler)
>> -    PTR_ADDI    sp, sp, -2 * SZREG
>> +    PTR_ADDI    sp, sp, -3 * SZREG
> As above, this will need to be padded to keep the stack aligned to 16
> bytes.
>      PTR_ADDI    sp, sp, -4 * SZREG

Thanks.

> 
>>       PTR_S        a0, sp, 0
>>       PTR_S        a1, sp, SZREG
>> +    PTR_S        zero, sp, 2 * SZREG
>> +    move        a0, sp
>>       bl        ftrace_return_to_handler
>>       /* Restore the real parent address: a0 -> ra */
>> @@ -90,7 +92,7 @@ SYM_FUNC_START(return_to_handler)
>>       PTR_L        a0, sp, 0
>>       PTR_L        a1, sp, SZREG
>> -    PTR_ADDI    sp, sp, 2 * SZREG
>> +    PTR_ADDI    sp, sp, 3 * SZREG
>>       jr        ra
>>   SYM_FUNC_END(return_to_handler)
>>   #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>> diff --git a/arch/loongarch/kernel/mcount_dyn.S 
>> b/arch/loongarch/kernel/mcount_dyn.S
>> index bbabf06244c2..ab85a953c6d3 100644
>> --- a/arch/loongarch/kernel/mcount_dyn.S
>> +++ b/arch/loongarch/kernel/mcount_dyn.S
>> @@ -131,18 +131,19 @@ SYM_CODE_END(ftrace_graph_caller)
>>   SYM_CODE_START(return_to_handler)
>>       /* Save return value regs */
>> -    PTR_ADDI     sp, sp, -2 * SZREG
>> +    PTR_ADDI     sp, sp, -3 * SZREG
> as above.

Thanks.

> 
> Thanks,
> - Qing
>>       PTR_S        a0, sp, 0
>>       PTR_S        a1, sp, SZREG
>> +    PTR_S        zero, sp, 2 * SZREG
>> -    move        a0, zero
>> +    move        a0, sp
>>       bl        ftrace_return_to_handler
>>       move        ra, a0
>>       /* Restore return value regs */
>>       PTR_L        a0, sp, 0
>>       PTR_L        a1, sp, SZREG
>> -    PTR_ADDI     sp, sp, 2 * SZREG
>> +    PTR_ADDI     sp, sp, 3 * SZREG
>>       jr        ra
>>   SYM_CODE_END(return_to_handler)
>>
> 

