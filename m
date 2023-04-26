Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4AB6EF670
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbjDZObD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbjDZObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:31:01 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BB28449D;
        Wed, 26 Apr 2023 07:30:57 -0700 (PDT)
Received: from loongson.cn (unknown [36.45.46.252])
        by gateway (Coremail) with SMTP id _____8CxlfCdNUlkvxoBAA--.1954S3;
        Wed, 26 Apr 2023 22:30:53 +0800 (CST)
Received: from [192.168.43.142] (unknown [36.45.46.252])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxKLKbNUlkbQo9AA--.17141S3;
        Wed, 26 Apr 2023 22:30:52 +0800 (CST)
Message-ID: <b68f2888-6c6f-bdaa-d66d-b2ae2d0a79cb@loongson.cn>
Date:   Wed, 26 Apr 2023 22:30:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] LoongArch: ftrace: Add direct call support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Qing Zhang <zhangqing@loongson.cn>
References: <1682473754-25077-1-git-send-email-tangyouling@loongson.cn>
 <1682473754-25077-4-git-send-email-tangyouling@loongson.cn>
 <ZEkqdfNk4YKVvxxM@FVFF77S0Q05N>
From:   Youling Tang <tangyouling@loongson.cn>
In-Reply-To: <ZEkqdfNk4YKVvxxM@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxKLKbNUlkbQo9AA--.17141S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3WFWkKFWxKF1UWw18Ar47Arb_yoW7ZFWkpr
        W7A3ZrtFWUuF4vk3sF9a48Wr4UXrWkX34fu3ZrAryFkr98Wryjvr48Ar98XFy0qw4kGrWI
        qF4rury5CF4aq37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8fsqJUUUUU==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark

On 2023/4/26 21:43, Mark Rutland wrote:
> Hi,
>
> On Wed, Apr 26, 2023 at 09:49:12AM +0800, Youling Tang wrote:
>> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
>> register_ftrace_direct[_multi] interfaces allowing users to register
>> the customed trampoline (direct_caller) as the mcount for one or
>> more target functions. And modify_ftrace_direct[_multi] are also
>> provided for modifying direct_caller.
>>
>> There are a few cases to distinguish:
>> - If a direct call ops is the only one tracing a function:
>>    - If the direct called trampoline is within the reach of a 'bl'
>>      instruction
>>       -> the ftrace patchsite jumps to the trampoline
>>    - Else
>>       -> the ftrace patchsite jumps to the ftrace_regs_caller trampoline
>> 	which reads the ops pointer in the patchsite and jumps to the
>>   	direct call address stored in the ops
> I think you forgot to update this wording; there's no ops pointer in the
> patchsite as you don't implement DYNAMIC_FTRACE_WITH_CALL_OPS.
>
> I think you can delete the "Else" case here, and replace the above with:
>
> - If a direct call ops is the only one tracing a function AND the direct called
>    trampoline is within the reach of a 'bl' instruction
>    -> the ftrace patchsite jumps to the trampoline
>
>> - Else
>>    -> the ftrace patchsite jumps to the ftrace_regs_caller trampoline and
>>       its ops literal points to ftrace_list_ops so it iterates over all
>>       registered ftrace ops, including the direct call ops and calls its
>>       call_direct_funcs handler which stores the direct called trampoline's
>>       address in the ftrace_regs and the ftrace_regs_caller trampoline will
> Likewise here, there's no "ops literal" associated with the patchsite.

Yes, thank you for pointing out, I will fix this description.


Thanks,

Youling.

>
> Otherwise, this looks sane to me.
>
> Mark.
>
>>       return to that address instead of returning to the traced function
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>>   arch/loongarch/Kconfig              |  1 +
>>   arch/loongarch/include/asm/ftrace.h | 12 ++++++++++++
>>   arch/loongarch/kernel/ftrace_dyn.c  |  8 ++++++++
>>   arch/loongarch/kernel/mcount_dyn.S  |  7 ++++++-
>>   4 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 3ddde336e6a5..d6068a88d53f 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -92,6 +92,7 @@ config LOONGARCH
>>   	select HAVE_DMA_CONTIGUOUS
>>   	select HAVE_DYNAMIC_FTRACE
>>   	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
>> +	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>   	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>>   	select HAVE_EBPF_JIT
>>   	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
>> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
>> index 3418d32d4fc7..f789e680f633 100644
>> --- a/arch/loongarch/include/asm/ftrace.h
>> +++ b/arch/loongarch/include/asm/ftrace.h
>> @@ -57,6 +57,18 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
>>   #define ftrace_graph_func ftrace_graph_func
>>   void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>>   		       struct ftrace_ops *op, struct ftrace_regs *fregs);
>> +
>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>> +static inline void
>> +__arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
>> +{
>> +	regs->regs[13] = addr;	/* t1 */
>> +}
>> +
>> +#define arch_ftrace_set_direct_caller(fregs, addr) \
>> +	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
>> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>> +
>>   #endif
>>   
>>   #endif /* __ASSEMBLY__ */
>> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
>> index 3cc4f8159f48..4062a7e63137 100644
>> --- a/arch/loongarch/kernel/ftrace_dyn.c
>> +++ b/arch/loongarch/kernel/ftrace_dyn.c
>> @@ -66,6 +66,14 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec, struct module *mod
>>   	unsigned long pc = rec->ip + LOONGARCH_INSN_SIZE;
>>   	struct plt_entry *plt;
>>   
>> +	/*
>> +	 * If a custom trampoline is unreachable, rely on the ftrace_regs_caller
>> +	 * trampoline which knows how to indirectly reach that trampoline
>> +	 * through ops->direct_call.
>> +	 */
>> +	if (*addr != FTRACE_ADDR && *addr != FTRACE_REGS_ADDR && !reachable_by_bl(*addr, pc))
>> +		*addr = FTRACE_REGS_ADDR;
>> +
>>   	/*
>>   	 * When the target is within range of the 'bl' instruction, use 'addr'
>>   	 * as-is and branch to that directly.
>> diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
>> index bbabf06244c2..1008fbc3cabc 100644
>> --- a/arch/loongarch/kernel/mcount_dyn.S
>> +++ b/arch/loongarch/kernel/mcount_dyn.S
>> @@ -42,7 +42,6 @@
>>   	.if \allregs
>>   	PTR_S		tp, sp, PT_R2
>>   	PTR_S		t0, sp, PT_R12
>> -	PTR_S		t1, sp, PT_R13
>>   	PTR_S		t2, sp, PT_R14
>>   	PTR_S		t3, sp, PT_R15
>>   	PTR_S		t4, sp, PT_R16
>> @@ -64,6 +63,8 @@
>>   	PTR_S		zero, sp, PT_R0
>>   	.endif
>>   	PTR_S		ra, sp, PT_ERA /* Save trace function ra at PT_ERA */
>> +	move		t1, zero
>> +	PTR_S		t1, sp, PT_R13
>>   	PTR_ADDI	t8, sp, PT_SIZE
>>   	PTR_S		t8, sp, PT_R3
>>   	.endm
>> @@ -104,8 +105,12 @@ ftrace_common_return:
>>   	PTR_L		a7, sp, PT_R11
>>   	PTR_L		fp, sp, PT_R22
>>   	PTR_L		t0, sp, PT_ERA
>> +	PTR_L		t1, sp, PT_R13
>>   	PTR_ADDI	sp, sp, PT_SIZE
>> +	bnez		t1,.Ldirect
>>   	jr		t0
>> +.Ldirect:
>> +	jr		t1
>>   SYM_CODE_END(ftrace_common)
>>   
>>   SYM_CODE_START(ftrace_caller)
>> -- 
>> 2.37.1
>>

