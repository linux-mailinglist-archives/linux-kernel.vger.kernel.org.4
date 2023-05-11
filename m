Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080976FF2E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbjEKNb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbjEKNbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:31:20 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340308A7D;
        Thu, 11 May 2023 06:30:48 -0700 (PDT)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id D4CDC34257E;
        Thu, 11 May 2023 16:30:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=9JSAwBIFENdjbz+Vq+
        nThd7WXvA6GppuJ7tkjnIXu/k=; b=gWsLhjlCdbmdg+EGw4lMtZRCfZM5VZAuLg
        BnY9a/x+66pOGpC38TjYzZY4xa8fuenks3nZkuRRhl7x3hcLRKKHQXoP6NWCyFmk
        qgYP4MqlU+njE2Tgf2GnF5GMv9Co3i/CTqkegqnSBRcMF1oChw5ANOE1abLz2HZc
        hdilUnOB4=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id CB119342574;
        Thu, 11 May 2023 16:30:45 +0300 (MSK)
Received: from [10.178.154.27] (10.178.154.27) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Thu, 11 May
 2023 16:30:44 +0300
Message-ID: <50d56c9c-49c7-8d93-6698-3d0e90d89c54@yadro.com>
Date:   Thu, 11 May 2023 16:30:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V9 3/4] riscv: ftrace: Add
 DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Song Shuai <suagrfillet@gmail.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <paul.walmsley@sifive.com>,
        <rostedt@goodmis.org>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>, <guoren@kernel.org>, <jszhang@kernel.org>
References: <20230510101857.2953955-1-suagrfillet@gmail.com>
 <20230510101857.2953955-4-suagrfillet@gmail.com>
 <87ttwjjpx8.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From:   Evgenii Shatokhin <e.shatokhin@yadro.com>
In-Reply-To: <87ttwjjpx8.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.178.154.27]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11.05.2023 10:19, Björn Töpel wrote:
> Song Shuai <suagrfillet@gmail.com> writes:
> 
>> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
>>
>> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
>> register_ftrace_direct[_multi] interfaces allowing users to register
>> the customed trampoline (direct_caller) as the mcount for one or
>> more target functions. And modify_ftrace_direct[_multi] are also
>> provided for modifying direct_caller.
>>
>> To make the direct_caller and the other ftrace hooks (eg. function/fgraph
>> tracer, k[ret]probes) co-exist, a temporary register is nominated to
>> store the address of direct_caller in ftrace_regs_caller. After the
>> setting of the address direct_caller by direct_ops->func and the
>> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
>> by the `jr` inst.
>>
>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>> Tested-by: Guo Ren <guoren@kernel.org>
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> ---
>>   arch/riscv/Kconfig              |  1 +
>>   arch/riscv/include/asm/ftrace.h |  8 ++++++++
>>   arch/riscv/kernel/mcount-dyn.S  | 10 ++++++++++
>>   3 files changed, 19 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index e0632493482f..fdf0b219a02c 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -144,6 +144,7 @@ config RISCV
>>        select UACCESS_MEMCPY if !MMU
>>        select ZONE_DMA32 if 64BIT
>>        select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
>> +     select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>        select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>>        select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>>        select HAVE_FUNCTION_GRAPH_TRACER
>> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
>> index 84f856a3286e..84904c1e4369 100644
>> --- a/arch/riscv/include/asm/ftrace.h
>> +++ b/arch/riscv/include/asm/ftrace.h
>> @@ -114,6 +114,14 @@ struct ftrace_regs;
>>   void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>>                       struct ftrace_ops *op, struct ftrace_regs *fregs);
>>   #define ftrace_graph_func ftrace_graph_func
>> +
>> +static inline void
>> +__arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
>> +{
>> +             regs->t1 = addr;
>> +}
>> +#define arch_ftrace_set_direct_caller(fregs, addr) \
>> +     __arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
>>   #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>>
>>   #endif /* __ASSEMBLY__ */
>> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
>> index f26e9f6e2fed..9d405baedb52 100644
>> --- a/arch/riscv/kernel/mcount-dyn.S
>> +++ b/arch/riscv/kernel/mcount-dyn.S
>> @@ -231,6 +231,7 @@ ENDPROC(ftrace_caller)
>>
>>   #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>>   ENTRY(ftrace_regs_caller)
>> +     move    t1, zero
> 
> Please use "mv", and not "move" [1].
> 
>>        SAVE_ABI_REGS 1
>>        PREPARE_ARGS
>>
>> @@ -239,7 +240,10 @@ ftrace_regs_call:
>>        call    ftrace_stub
>>
>>        RESTORE_ABI_REGS 1
>> +     bnez    t1,.Ldirect
>>        jr t0
>> +.Ldirect:
>> +     jr t1
> 
> Again, while you're doing changes here, please try to align op/operands.
> 
> Wearing my BPF hat, I'm happy to finally get DIRECT_CALLS support!
> 
> This does not take the WITH_CALL_OPS approach Mark suggested in the v7
> threads, but given that text patching story on RISC-V is still a bit sad
> (inconsistency in the RV tree, no specification, cannot work with
> preempt, ...) I'd say this approach is OK for now, and we can change to
> WITH_CALL_OPS later in a wider "let's improve RISC-V textpatching" work.
> 
> Thoughts?

The WITH_CALL_OPS approach seems to need much more time and effort, so, 
yes, I'd also use this implementation of DIRECT_CALLS for now. Other 
improvements could wait for the future "big patching rework".

FWIW, the implementation of kprobes for RISC-V has been improving 
gradually too, not everything was done in the first very patchset, but 
it was usable nonetheless.

I have not tested this particular version of this 
DYNAMIC_FTRACE_WITH_DIRECT_CALLS series, only some previous ones - there 
were no outstanding problems there. The code looks sane to me.

> 
> 
> Björn
> 
> [1] https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.md#-a-listing-of-standard-risc-v-pseudoinstructions
> 

Regards,
Evgenii


