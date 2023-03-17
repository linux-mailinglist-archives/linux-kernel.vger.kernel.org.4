Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CAF6BDF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 03:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCQCuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 22:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCQCuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 22:50:05 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07116A9F4;
        Thu, 16 Mar 2023 19:50:01 -0700 (PDT)
Received: from [172.23.196.229] (unknown [121.32.254.147])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id DFE60580599;
        Fri, 17 Mar 2023 10:49:49 +0800 (CST)
Message-ID: <34781b74-8d3e-a7e6-9abe-e8d45d680eec@sangfor.com.cn>
Date:   Fri, 17 Mar 2023 10:49:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: Re: [PATCH v4 1/2] function_graph: Support recording and printing the
 return value of function
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230315133911.958741-1-pengdonglin@sangfor.com.cn>
 <20230315133911.958741-2-pengdonglin@sangfor.com.cn>
 <ZBOkY8FkqgoBfzQ2@shell.armlinux.org.uk>
Content-Language: en-US
In-Reply-To: <ZBOkY8FkqgoBfzQ2@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSB4eVk1OSxlOHRpMTkpNH1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpJSlVISVVJTk9VSk9MWVdZFhoPEhUdFFlBWU9LSFVKSktPSEhVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6PRw6PT0NSB9CNyk*NA8x
        QzkwCVFVSlVKTUxCS0lKSEJKT09KVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSklKVUhJVUlOT1VKT0xZV1kIAVlBT0xOTTcG
X-HM-Tid: 0a86ed793c992eb7kusndfe60580599
X-HM-MType: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/17 7:21, Russell King (Oracle) wrote:
> On Wed, Mar 15, 2023 at 06:39:10AM -0700, Donglin Peng wrote:
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index e24a9820e12f..ad03fc868f34 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -99,6 +99,7 @@ config ARM
>>   	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>>   	select HAVE_FUNCTION_ERROR_INJECTION
>>   	select HAVE_FUNCTION_GRAPH_TRACER
>> +	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>>   	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>>   	select HAVE_GCC_PLUGINS
>>   	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
>> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
>> index 3e7bcaca5e07..0151d2ce9958 100644
>> --- a/arch/arm/kernel/entry-ftrace.S
>> +++ b/arch/arm/kernel/entry-ftrace.S
>> @@ -258,6 +258,10 @@ ENDPROC(ftrace_graph_regs_caller)
>>   #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>   ENTRY(return_to_handler)
>>   	stmdb	sp!, {r0-r3}
>> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>> +	/* Pass the function return value to ftrace_return_to_handler */
>> +	mov	r1, r0
> 
> In a similar vein to Peter's comment, do we care about 64-bit return
> values here, because the above only covers 32-bit values.
> 
> If we do care about 64-bit values, then we get into EABI/OABI
> stickyness, because on EABI the 64-bit value would have to be passed
> in r2,r3, and OABI would need r1,r2.
> 
> it would be better to have the 64-bit argument as the first argument
> to ftrace_return_to_handler() which would eliminate that variability,
> but I don't know what effect that would have for other architectures.
> 
> Things get more icky if we want 128-bit values. For EABI, we've
> conveniently just stacked that. For OABI, that would need to be in
> r1-r3 and the final high bits on the stack.
> 
> With a 128-bit argument as the first, that would be r0-r3 with the
> existing stack pointer argument stored... on the stack.
> 
> So, really it depends what size of return value we want to report.
> Also, please bear in mind that where a function returns a 32-bit
> value, that will be in r0, and r1 will be whatever happened to be
> in it at function exit - there's no defined value for r1.
> 

Thank you. I will document this as a limitation of fgraph return value.
It can just cover most cases at present and I think the r0 is enough.

