Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF866CCF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjC2BP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC2BP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:15:26 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4DC99;
        Tue, 28 Mar 2023 18:15:22 -0700 (PDT)
Received: from [10.128.10.193] (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 495325805E3;
        Wed, 29 Mar 2023 09:15:12 +0800 (CST)
Message-ID: <c043935e-3961-8896-45de-03fcad676e08@sangfor.com.cn>
Date:   Wed, 29 Mar 2023 09:15:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 3/8] ARM: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        chenhuacai@kernel.org, zhangqing@loongson.cn, kernel@xen0n.name,
        mingo@redhat.com, peterz@infradead.org, xiehuan09@gmail.com,
        dinghui@sangfor.com.cn, huangcun@sangfor.com.cn,
        dolinux.peng@gmail.com, linux-trace-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230328134319.2185812-1-pengdonglin@sangfor.com.cn>
 <20230328134319.2185812-4-pengdonglin@sangfor.com.cn>
 <ZCLzf6RX4U00g9Cu@shell.armlinux.org.uk>
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
In-Reply-To: <ZCLzf6RX4U00g9Cu@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSE9PVh9NGRhJSE0fT00dSlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS09LQ1VKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6Kww4Oj0cOVYRDyssOigM
        GQ9PCkJVSlVKTUNLS05JTkpITEpDVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFNSUtNNwY+
X-HM-Tid: 0a872aeee9a02eb7kusn495325805e3
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/28 22:02, Russell King (Oracle) wrote:
> On Tue, Mar 28, 2023 at 06:43:14AM -0700, Donglin Peng wrote:
>> The commit d4815c5d1bbd ("function_graph: Support recording and printing
>> the return value of function") laid the groundwork for the for the
>> funcgraph-retval, and this modification makes it available on the
>> ARM platform.
>>
>> We introduce a new structure called fgraph_ret_regs for the ARM platform
>> to hold return registers and the frame pointer. We then fill its content
>> in the return_to_handler and pass its address to the function
>> ftrace_return_to_handler to record the return value.
>>
>> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
>> ---
>> v8:
>>   - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
>> ---
>>   arch/arm/Kconfig               |  1 +
>>   arch/arm/include/asm/ftrace.h  | 18 ++++++++++++++++++
>>   arch/arm/kernel/entry-ftrace.S |  6 +++++-
>>   3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index e24a9820e12f..73061379855a 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -98,6 +98,7 @@ config ARM
>>   	select HAVE_FAST_GUP if ARM_LPAE
>>   	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>>   	select HAVE_FUNCTION_ERROR_INJECTION
>> +	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>>   	select HAVE_FUNCTION_GRAPH_TRACER
>>   	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>>   	select HAVE_GCC_PLUGINS
>> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
>> index 7e9251ca29fe..2ab4bee21d79 100644
>> --- a/arch/arm/include/asm/ftrace.h
>> +++ b/arch/arm/include/asm/ftrace.h
>> @@ -77,4 +77,22 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
>>   
>>   #endif /* ifndef __ASSEMBLY__ */
>>   
>> +
>> +#ifndef __ASSEMBLY__
>> +struct fgraph_ret_regs {
>> +	unsigned long regs[4];
>> +	unsigned long fp;
>> +};
>> +
>> +static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
>> +{
>> +	return ret_regs->regs[0];
>> +}
>> +
>> +static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
>> +{
>> +	return ret_regs->fp;
>> +}
>> +#endif
>> +
>>   #endif /* _ASM_ARM_FTRACE */
>> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
>> index 3e7bcaca5e07..5f1e74555b25 100644
>> --- a/arch/arm/kernel/entry-ftrace.S
>> +++ b/arch/arm/kernel/entry-ftrace.S
>> @@ -257,11 +257,15 @@ ENDPROC(ftrace_graph_regs_caller)
>>   
>>   #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>   ENTRY(return_to_handler)
>> +	sub	sp, sp, #4
>>   	stmdb	sp!, {r0-r3}
>> -	add	r0, sp, #16		@ sp at exit of instrumented routine
>> +	add	r0, sp, #20		@ sp at exit of instrumented routine
>> +	str	r0, [sp, #16]
>> +	mov	r0, sp
> 
> 1) EABI wants the stack to be aligned to 8 bytes.
> 2) We can do better than this.
> 
> 	mov	ip, sp
> 	stmdb	sp!, {r0-r3, ip, lr}
> 	mov	r0, sp

Great, I will modify it.

> 
>>   	bl	ftrace_return_to_handler
>>   	mov	lr, r0			@ r0 has real ret addr
>>   	ldmia	sp!, {r0-r3}
> 
> 	ldmia	sp, {r0-r3}		@ since we need to manually adjust sp,

Thanks, I will modify it.

> 
>> +	add	sp, sp, #4		@ skip fp
> 
> 	add	sp, sp, #4 * 6		@ restore stack pointer here

Thanks, I will modify it.

> 
>>   	ret	lr
>>   ENDPROC(return_to_handler)
>>   #endif
>> -- 
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 

