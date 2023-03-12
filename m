Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E802A6B66B0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCLN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCLN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:27:40 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE95E53D82;
        Sun, 12 Mar 2023 06:27:11 -0700 (PDT)
Received: from [192.168.0.193] (unknown [113.87.239.236])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 30CDA58016E;
        Sun, 12 Mar 2023 21:27:01 +0800 (CST)
Message-ID: <8bff97c8-e365-ee1a-2d48-79fd4902f0e3@sangfor.com.cn>
Date:   Sun, 12 Mar 2023 21:26:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: Re: [RFC v2] function_graph: Support recording and outputing the
 return value of function
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230312022826.10367-1-pengdonglin@sangfor.com.cn>
 <20230312185853.1b85d63cfda11824fc609e18@kernel.org>
In-Reply-To: <20230312185853.1b85d63cfda11824fc609e18@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQh9CVkkeQkkYTUlIQ0MZSFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSFVDTFVJSEJVSUhNWVdZFhoPEhUdFFlBWU9LSFVKSktPSEhVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M1E6Sgw5Cj0LMSgJMyFNPj8C
        IRYaFFZVSlVKTUxDTUlMTUlKQk5PVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpIVUNMVUlIQlVJSE1ZV1kIAVlBSk1MTEk3Bg++
X-HM-Tid: 0a86d600ca232eb7kusn30cda58016e
X-HM-MType: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/12 17:58, Masami Hiramatsu (Google) wrote:
> Hi Donglin,
> 
> This looks really interesting. There is fprobe and I'm trying introduce the
> fprobe event, but that is an event trace. So this is another way to trace
> the return values.
Thank you. I have seen your patches, and fprobe is better than 
kprobe,and I am learning it.
>  > On Sat, 11 Mar 2023 18:28:26 -0800
> Donglin Peng <pengdonglin@sangfor.com.cn> wrote:
> 
>> When using function_graph to analyze the reasons for system call failures,
>> we need to spend a considerable amount of time analyzing the logs and
>> cannot quickly locate the error. This modification aims to make this
>> process easier by recording the return values of each traced function.
>> When outputting trace logs, the tracing option funcgraph-retval can be
>> used to control whether to display the return values. If the return value
>> looks like an error code, it will be output in both hexadecimal and signed
>> decimal, otherwise only hexadecimal.
> 
> Hm, this will confuse the output parser. The output should be human readable
> but also machine readable. I think you can introduce an option (tracefs/options/*)
> to show "smart" output or hexadecimal output always.
> 
> treacefs/options/graph_retval_hex
> 
> If this is 1, the return value is printed always in hexadecimal. If it is 0,
> when the IS_ERR(retval) is true, it will show it in signed decimal, or
> hexadecimal (with "0x" prefix).
Good idea,i will add this in v4.
> 
>> Currently, this modification supports the following commonly used processor
>> architectures: x64, x86, arm64, arm, riscv.
> 
> This may also need to be reviewed by each arch maintainer. So we need
> CONFIG_HAVE_FUNCTION_GRAPH_RETVAL which indicates that this architecture
> support ftrace-graph retval and CONFIG_FUNCTION_GRAPH_RETVAL which
> switches this retval is printed or not.
> 
Yeah,I will modify this in v4.
>>
>> One drawback is that even if a function's return type is void, the value
>> stored in the return value register will still be recorded and output.
> 
> Yeah, but I think that is no problem. We can notify user that this retval
> is always be shown even if the function return type is void.
> 
Yeah.I implement a simple tool to deal with the trace logs using BTF 
information just now, the processed trace logs are added in v3.
>> I think the BTF files can be used to obtain the return type of kernel
>> functions, but the search cost is a bit high. Therefore, we can
>> implement a tool to process trace logs based on BTF information.
> 
> Agreed. Anyway for some specific functions, we can use fprobe events.
> 
Yeah.
> Thank you.
>
>>
>> For example:
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
>> Search -22 directly in the trace.log and find that the function
>> cpu_cgroup_can_attach returned -22 first, then read the code of this
>> function to get the root cause.
>>
>> ...
>>   0)            |  cgroup_migrate() {
>>   0)  0.521 us  |    cgroup_migrate_add_task(); /* => ffff88800cbaa000 */
>>   0)  0.500 us  |    cgroup_migrate_add_task(); /* => ffff88800cbaa000 */
>>   0)  0.441 us  |    cgroup_migrate_add_task(); /* => ffff88800cbaa000 */
>>   0)  0.521 us  |    cgroup_migrate_add_task(); /* => ffff88800cbaa000 */
>>   0)  0.421 us  |    cgroup_migrate_add_task(); /* => ffff88800cbaa000 */
>>   0)  0.431 us  |    cgroup_migrate_add_task(); /* => ffff88800cbaa000 */
>>   0)            |    cgroup_migrate_execute() {
>>   0)            |      cpu_cgroup_can_attach() {
>>   0)            |        cgroup_taskset_first() {
>>   0)  0.221 us  |          cgroup_taskset_next(); /* => ffff88800e13c000 */
>>   0)  0.641 us  |        } /* cgroup_taskset_first => ffff88800e13c000 */
>>   0)  0.320 us  |        sched_rt_can_attach(); /* => 0 */
>>   0)  1.713 us  |      } /* cpu_cgroup_can_attach => ffffffea -22 */
>>   0)  3.717 us  |    } /* cgroup_migrate_execute => ffffffea -22 */
>>   0)  9.959 us  |  } /* cgroup_migrate => ffffffea -22 */
>> ...
>>
>> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
>> ---
>>   arch/arm/kernel/entry-ftrace.S       |  1 +
>>   arch/arm64/kernel/entry-ftrace.S     |  1 +
>>   arch/riscv/kernel/mcount.S           |  2 +
>>   arch/x86/kernel/ftrace_32.S          |  1 +
>>   arch/x86/kernel/ftrace_64.S          |  2 +
>>   include/linux/ftrace.h               |  1 +
>>   kernel/trace/fgraph.c                |  3 +-
>>   kernel/trace/trace.h                 |  1 +
>>   kernel/trace/trace_entries.h         |  5 +-
>>   kernel/trace/trace_functions_graph.c | 70 ++++++++++++++++++++++++----
>>   10 files changed, 74 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
>> index 3e7bcaca5e07..c6666c0d909c 100644
>> --- a/arch/arm/kernel/entry-ftrace.S
>> +++ b/arch/arm/kernel/entry-ftrace.S
>> @@ -258,6 +258,7 @@ ENDPROC(ftrace_graph_regs_caller)
>>   #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>   ENTRY(return_to_handler)
>>   	stmdb	sp!, {r0-r3}
>> +	mov	r1, r0			@ pass the return value
>>   	add	r0, sp, #16		@ sp at exit of instrumented routine
>>   	bl	ftrace_return_to_handler
>>   	mov	lr, r0			@ r0 has real ret addr
>> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
>> index 350ed81324ac..0eb9a0e3ba3d 100644
>> --- a/arch/arm64/kernel/entry-ftrace.S
>> +++ b/arch/arm64/kernel/entry-ftrace.S
>> @@ -276,6 +276,7 @@ SYM_CODE_START(return_to_handler)
>>   	stp x4, x5, [sp, #32]
>>   	stp x6, x7, [sp, #48]
>>   
>> +	mov	x1, x0			// pass the return value
>>   	mov	x0, x29			//     parent's fp
>>   	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
>>   	mov	x30, x0			// restore the original return address
>> diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
>> index 30102aadc4d7..afce5abcbcd2 100644
>> --- a/arch/riscv/kernel/mcount.S
>> +++ b/arch/riscv/kernel/mcount.S
>> @@ -69,6 +69,8 @@ ENTRY(return_to_handler)
>>   	mv	t6, s0
>>   #endif
>>   	SAVE_RET_ABI_STATE
>> +	/* pass the return value to ftrace_return_to_handler */
>> +	mv	a1, a0
>>   #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
>>   	mv	a0, t6
>>   #endif
>> diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
>> index a0ed0e4a2c0c..7611374ccce8 100644
>> --- a/arch/x86/kernel/ftrace_32.S
>> +++ b/arch/x86/kernel/ftrace_32.S
>> @@ -184,6 +184,7 @@ SYM_CODE_END(ftrace_graph_caller)
>>   return_to_handler:
>>   	pushl	%eax
>>   	pushl	%edx
>> +	movl	%eax, %edx	#  2nd argument: the return value
>>   	movl	$0, %eax
>>   	call	ftrace_return_to_handler
>>   	movl	%eax, %ecx
>> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
>> index 1265ad519249..d685b773e7ad 100644
>> --- a/arch/x86/kernel/ftrace_64.S
>> +++ b/arch/x86/kernel/ftrace_64.S
>> @@ -348,6 +348,8 @@ SYM_CODE_START(return_to_handler)
>>   	movq %rax, (%rsp)
>>   	movq %rdx, 8(%rsp)
>>   	movq %rbp, %rdi
>> +	/* Pass the return value to ftrace_return_to_handler */
>> +	movq %rax, %rsi
>>   
>>   	call ftrace_return_to_handler
>>   
>> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
>> index 366c730beaa3..157fd25be2b7 100644
>> --- a/include/linux/ftrace.h
>> +++ b/include/linux/ftrace.h
>> @@ -1032,6 +1032,7 @@ struct ftrace_graph_ent {
>>    */
>>   struct ftrace_graph_ret {
>>   	unsigned long func; /* Current function */
>> +	unsigned long retval;
>>   	int depth;
>>   	/* Number of functions that overran the depth limit for current task */
>>   	unsigned int overrun;
>> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
>> index 218cd95bf8e4..006b39a98dc3 100644
>> --- a/kernel/trace/fgraph.c
>> +++ b/kernel/trace/fgraph.c
>> @@ -240,12 +240,13 @@ static struct notifier_block ftrace_suspend_notifier = {
>>    * Send the trace to the ring-buffer.
>>    * @return the original return address.
>>    */
>> -unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>> +unsigned long ftrace_return_to_handler(unsigned long frame_pointer, unsigned long retval)
>>   {
>>   	struct ftrace_graph_ret trace;
>>   	unsigned long ret;
>>   
>>   	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
>> +	trace.retval = retval;
>>   	trace.rettime = trace_clock_local();
>>   	ftrace_graph_return(&trace);
>>   	/*
>> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
>> index 616e1aa1c4da..5ef32c6e1d45 100644
>> --- a/kernel/trace/trace.h
>> +++ b/kernel/trace/trace.h
>> @@ -831,6 +831,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
>>   #define TRACE_GRAPH_PRINT_TAIL          0x100
>>   #define TRACE_GRAPH_SLEEP_TIME          0x200
>>   #define TRACE_GRAPH_GRAPH_TIME          0x400
>> +#define TRACE_GRAPH_PRINT_RETVAL        0x800
>>   #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
>>   #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
>>   
>> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
>> index cd41e863b51c..d798cb17546f 100644
>> --- a/kernel/trace/trace_entries.h
>> +++ b/kernel/trace/trace_entries.h
>> @@ -93,16 +93,17 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>>   	F_STRUCT(
>>   		__field_struct(	struct ftrace_graph_ret,	ret	)
>>   		__field_packed(	unsigned long,	ret,		func	)
>> +		__field_packed(	unsigned long,	ret,		retval	)
>>   		__field_packed(	int,		ret,		depth	)
>>   		__field_packed(	unsigned int,	ret,		overrun	)
>>   		__field_packed(	unsigned long long, ret,	calltime)
>>   		__field_packed(	unsigned long long, ret,	rettime	)
>>   	),
>>   
>> -	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
>> +	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d retval: %lx",
>>   		 (void *)__entry->func, __entry->depth,
>>   		 __entry->calltime, __entry->rettime,
>> -		 __entry->depth)
>> +		 __entry->depth, __entry->retval)
>>   );
>>   
>>   /*
>> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
>> index 203204cadf92..706d3e5c2156 100644
>> --- a/kernel/trace/trace_functions_graph.c
>> +++ b/kernel/trace/trace_functions_graph.c
>> @@ -58,6 +58,8 @@ static struct tracer_opt trace_opts[] = {
>>   	{ TRACER_OPT(funcgraph-irqs, TRACE_GRAPH_PRINT_IRQS) },
>>   	/* Display function name after trailing } */
>>   	{ TRACER_OPT(funcgraph-tail, TRACE_GRAPH_PRINT_TAIL) },
>> +	/* Display function return value */
>> +	{ TRACER_OPT(funcgraph-retval, TRACE_GRAPH_PRINT_RETVAL) },
>>   	/* Include sleep time (scheduled out) between entry and return */
>>   	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
>>   
>> @@ -619,6 +621,43 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
>>   	trace_seq_puts(s, "|  ");
>>   }
>>   
>> +static void print_graph_retval(struct trace_seq *s, unsigned long retval,
>> +				bool leaf, void *func)
>> +{
>> +	unsigned long err_code = 0;
>> +
>> +	if (retval == 0)
>> +		goto done;
>> +
>> +	/* Guess whether the retval looks like an error code */
>> +	if ((retval & BIT(7)) && (retval >> 8) == 0)
>> +		err_code = (unsigned long)(s8)retval;
>> +	else if ((retval & BIT(15)) && (retval >> 16) == 0)
>> +		err_code = (unsigned long)(s16)retval;
>> +	else if ((retval & BIT(31)) && (((u64)retval) >> 32) == 0)
>> +		err_code = (unsigned long)(s32)retval;
>> +	else
>> +		err_code = retval;
>> +
>> +	if (!IS_ERR_VALUE(err_code))
>> +		err_code = 0;
>> +
>> +done:
>> +	if (leaf) {
>> +		if (err_code != 0)
>> +			trace_seq_printf(s, "%ps(); /* => %lx %ld */\n",
>> +				func, retval, err_code);
>> +		else
>> +			trace_seq_printf(s, "%ps(); /* => %lx */\n", func, retval);
>> +	} else {
>> +		if (err_code != 0)
>> +			trace_seq_printf(s, "} /* %ps => %lx %ld */\n",
>> +				func, retval, err_code);
>> +		else
>> +			trace_seq_printf(s, "} /* %ps => %lx */\n", func, retval);
>> +	}
>> +}
>> +
>>   /* Case of a leaf function on its call entry */
>>   static enum print_line_t
>>   print_graph_entry_leaf(struct trace_iterator *iter,
>> @@ -663,7 +702,10 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>>   	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
>>   		trace_seq_putc(s, ' ');
>>   
>> -	trace_seq_printf(s, "%ps();\n", (void *)call->func);
>> +	if (flags & TRACE_GRAPH_PRINT_RETVAL)
>> +		print_graph_retval(s, graph_ret->retval, true, (void *)call->func);
>> +	else
>> +		trace_seq_printf(s, "%ps();\n", (void *)call->func);
>>   
>>   	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
>>   			cpu, iter->ent->pid, flags);
>> @@ -942,16 +984,24 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
>>   		trace_seq_putc(s, ' ');
>>   
>>   	/*
>> -	 * If the return function does not have a matching entry,
>> -	 * then the entry was lost. Instead of just printing
>> -	 * the '}' and letting the user guess what function this
>> -	 * belongs to, write out the function name. Always do
>> -	 * that if the funcgraph-tail option is enabled.
>> +	 * Always write out the function name and its return value if the
>> +	 * function-retval option is enabled.
>>   	 */
>> -	if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
>> -		trace_seq_puts(s, "}\n");
>> -	else
>> -		trace_seq_printf(s, "} /* %ps */\n", (void *)trace->func);
>> +	if (flags & TRACE_GRAPH_PRINT_RETVAL) {
>> +		print_graph_retval(s, trace->retval, false, (void *)trace->func);
>> +	} else {
>> +		/*
>> +		 * If the return function does not have a matching entry,
>> +		 * then the entry was lost. Instead of just printing
>> +		 * the '}' and letting the user guess what function this
>> +		 * belongs to, write out the function name. Always do
>> +		 * that if the funcgraph-tail option is enabled.
>> +		 */
>> +		if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
>> +			trace_seq_puts(s, "}\n");
>> +		else
>> +			trace_seq_printf(s, "} /* %ps */\n", (void *)trace->func);
>> +	}
>>   
>>   	/* Overrun */
>>   	if (flags & TRACE_GRAPH_PRINT_OVERRUN)
>> -- 
>> 2.25.1
>>
> 
> 
