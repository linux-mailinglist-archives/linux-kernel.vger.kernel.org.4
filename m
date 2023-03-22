Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785E36C4543
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCVIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCVIr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:47:28 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166BF14235;
        Wed, 22 Mar 2023 01:47:26 -0700 (PDT)
Received: from [10.128.10.193] (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 5DCC85807B4;
        Wed, 22 Mar 2023 16:47:18 +0800 (CST)
Message-ID: <a7256b94-c044-7aef-bee2-69182956e913@sangfor.com.cn>
Date:   Wed, 22 Mar 2023 16:47:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/2] function_graph: Support recording and printing the
 return value of function
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        will@kernel.org, catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230320131650.482594-1-pengdonglin@sangfor.com.cn>
 <20230320131650.482594-2-pengdonglin@sangfor.com.cn>
 <ZBm+HKK9laIXAdsc@FVFF77S0Q05N>
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
In-Reply-To: <ZBm+HKK9laIXAdsc@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTkwZVhpOHkgaGU5OSExCT1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS09ISFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTI6Mzo4GT0LLRQPLg8ZQy1D
        NR4KCTxVSlVKTUxCT0xPQ0hCQkJOVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFNTUNNNwY+
X-HM-Tid: 0a8708804f962eb7kusn5dcc85807b4
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/21 22:24, Mark Rutland wrote:
> On Mon, Mar 20, 2023 at 06:16:49AM -0700, Donglin Peng wrote:
>> When using the function_graph tracer to analyze system call failures,
>> it can be time-consuming to analyze the trace logs and locate the kernel
>> function that first returns an error. This change aims to simplify the
>> process by recording the function return value to the 'retval' member of
>> 'ftrace_graph_ent' and printing it when outputing the trace log.
>>
>> New trace options are introduced: funcgraph-retval and graph_retval_hex.
>> The former is used to control whether to display the return value, while
>> the latter is used to control the display format of the reutrn value.
>>
>> Note that even if a function's return type is void, a return value will
>> still be printed, so just ignore it.
>>
>> Currently, this modification supports the following commonly used
>> processor architectures: x86_64, x86, arm64, arm, riscv.
>>
>> Here is an example:
>>
>> I want to attach the demo process to a cpu cgroup, but it failed:
>>
>> echo `pidof demo` > /sys/fs/cgroup/cpu/test/tasks
>> -bash: echo: write error: Invalid argument
>>
>> The strace logs tells that the write system call returned -EINVAL(-22):
>> ...
>> write(1, "273\n", 4)                    = -1 EINVAL (Invalid argument)
>> ...
>>
>> Use the following commands to capture trace logs when calling the write
>> system call:
>>
>> cd /sys/kernel/debug/tracing/
>> echo 0 > tracing_on
>> echo > trace
>> echo *sys_write > set_graph_function
>> echo *spin* > set_graph_notrace
>> echo *rcu* >> set_graph_notrace
>> echo *alloc* >> set_graph_notrace
>> echo preempt* >> set_graph_notrace
>> echo kfree* >> set_graph_notrace
>> echo $$ > set_ftrace_pid
>> echo function_graph > current_tracer
>> echo 1 > tracing_on
>> echo `pidof demo` > /sys/fs/cgroup/cpu/test/tasks
>> echo 0 > tracing_on
>> echo 1 > options/funcgraph-retval
>> cat trace > ~/trace.log
>>
>> Search the error code -22 directly in the file trace.log and find the
>> first function that return -22, then read the function code to get the
>> root cause.
>>
>> ...
>>
>>   1)          | cgroup_migrate() {
>>   1) 0.651 us |   cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
>>   1)          |   cgroup_migrate_execute() {
>>   1)          |     cpu_cgroup_can_attach() {
>>   1)          |       cgroup_taskset_first() {
>>   1) 0.732 us |         cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
>>   1) 1.232 us |       } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
>>   1) 0.380 us |       sched_rt_can_attach(); /* = 0x0 */
>>   1) 2.335 us |     } /* cpu_cgroup_can_attach = -22 */
>>   1) 4.369 us |   } /* cgroup_migrate_execute = -22 */
>>   1) 7.143 us | } /* cgroup_migrate = -22 */
>>
>> ...
>>
>> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
> 
>> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
>> index 350ed81324ac..d1a5d76e6d72 100644
>> --- a/arch/arm64/kernel/entry-ftrace.S
>> +++ b/arch/arm64/kernel/entry-ftrace.S
>> @@ -276,7 +276,15 @@ SYM_CODE_START(return_to_handler)
>>   	stp x4, x5, [sp, #32]
>>   	stp x6, x7, [sp, #48]
>>   
>> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>> +	/*
>> +	 * Pass both the function return values in the register x0 and x1
>> +	 * to ftrace_return_to_handler.
>> +	 */
>> +	mov	x2, x29			//     parent's fp
>> +#else
>>   	mov	x0, x29			//     parent's fp
>> +#endif
>>   	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
>>   	mov	x30, x0			// restore the original return address
> 
> 
> Please don't make the calling convention of the asm change depending on a
> selectable config option.
> 
> We already store the regs here; I'd be happy to make that a struct ftrace_regs
> and pass a pointer to that to C code. Then it's be easy to acquire the value
> you want in the exact same way as upon entry, and it'll work even if we decide
> to return a structure by value somewhere (as that can use registers x2-x7 too).

Agree, I think we only need to store return registers, but ftrace_regs
has too many members. So we can introduce a new structure called
pt_ret_regs which only contains return registers and frame pointer
register, for ARM64, they are x0~x7 and x29. Then pass the pointer to
pt_ret_regs to ftrace_return_to_handler.

> 
> Thanks,
> Mark.

