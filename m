Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC536D5FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjDDMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjDDMHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:07:02 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92DF3C0B;
        Tue,  4 Apr 2023 05:03:08 -0700 (PDT)
Received: from [10.128.10.193] (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 7CA695809D2;
        Tue,  4 Apr 2023 20:02:48 +0800 (CST)
Message-ID: <d8b58492-e702-05b7-399e-054892ba6ded@sangfor.com.cn>
Date:   Tue, 4 Apr 2023 20:02:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: Re: [PATCH v10 2/8] tracing: Add documentation for funcgraph-retval
 and funcgraph-retval-hex
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        bp@alien8.de, hpa@zytor.com, chenhuacai@kernel.org,
        zhangqing@loongson.cn, kernel@xen0n.name, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1680265828.git.pengdonglin@sangfor.com.cn>
 <a3dcdd61b3ac07eefabc1b11fc18e9fae23d8cbe.1680265828.git.pengdonglin@sangfor.com.cn>
 <ZCqOl1TCHGhbf0hf@FVFF77S0Q05N>
Content-Language: en-US
In-Reply-To: <ZCqOl1TCHGhbf0hf@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTE4YVkIZQ0lMGEIdTUtJH1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6GCo*GD0OGj4WAQ8tAQlO
        EiwKC0xVSlVKTUNLTUtCTExLSkJNVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFKSkpLTTcG
X-HM-Tid: 0a874c25f8c72eb7kusn7ca695809d2
X-HM-MType: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/3 16:30, Mark Rutland wrote:
> On Fri, Mar 31, 2023 at 05:47:38AM -0700, Donglin Peng wrote:
>> Add documentation for the two newly introduced options for the
>> function_graph tracer. The funcgraph-retval option is used to
>> control whether or not to display the return value, while the
>> funcgraph-retval-hex option is used to control the display
>> format of the return value.
>>
>> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
>> ---
>> v9:
>>   - Update limitation description
>>
>> v7:
>>   - Rename trace option 'graph_retval_hex' to 'funcgraph-retval-hex'
>>   - Update documentation description
>>
>> v6:
>>   - Modify the limitations for funcgraph-retval
>>   - Optimize the English expression
>>
>> v5:
>>   - Describe the limitations of funcgraph-retval
>> ---
>>   Documentation/trace/ftrace.rst | 74 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
>> index b927fb2b94dc..f572ae419219 100644
>> --- a/Documentation/trace/ftrace.rst
>> +++ b/Documentation/trace/ftrace.rst
>> @@ -1328,6 +1328,19 @@ Options for function_graph tracer:
>>   	only a closing curly bracket "}" is displayed for
>>   	the return of a function.
>>   
>> +  funcgraph-retval
>> +	When set, the return value of each traced function
>> +	will be printed after an equal sign "=". By default
>> +	this is off.
>> +
>> +  funcgraph-retval-hex
>> +	When set, the return value will always be printed
>> +	in hexadecimal format. If the option is not set and
>> +	the return value is an error code, it will be printed
>> +	in signed decimal format; otherwise it will also be
>> +	printed in hexadecimal format. By default, this option
>> +	is off.
>> +
>>     sleep-time
>>   	When running function graph tracer, to include
>>   	the time a task schedules out in its function.
>> @@ -2673,6 +2686,67 @@ It is default disabled.
>>       0)   1.757 us    |        } /* kmem_cache_free() */
>>       0)   2.861 us    |      } /* putname() */
>>   
>> +The return value of each traced function can be displayed after
>> +an equal sign "=". When encountering system call failures, it
>> +can be verfy helpful to quickly locate the function that first
>> +returns an error code.
>> +
>> +	- hide: echo nofuncgraph-retval > trace_options
>> +	- show: echo funcgraph-retval > trace_options
>> +
>> +  Example with funcgraph-retval::
>> +
>> +    1)               |    cgroup_migrate() {
>> +    1)   0.651 us    |      cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
>> +    1)               |      cgroup_migrate_execute() {
>> +    1)               |        cpu_cgroup_can_attach() {
>> +    1)               |          cgroup_taskset_first() {
>> +    1)   0.732 us    |            cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
>> +    1)   1.232 us    |          } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
>> +    1)   0.380 us    |          sched_rt_can_attach(); /* = 0x0 */
>> +    1)   2.335 us    |        } /* cpu_cgroup_can_attach = -22 */
>> +    1)   4.369 us    |      } /* cgroup_migrate_execute = -22 */
>> +    1)   7.143 us    |    } /* cgroup_migrate = -22 */
>> +
>> +The above example shows that the function cpu_cgroup_can_attach
>> +returned the error code -22 firstly, then we can read the code
>> +of this function to get the root cause.
>> +
>> +When the option funcgraph-retval-hex is not set, the return value can
>> +be displayed in a smart way. Specifically, if it is an error code,
>> +it will be printed in signed decimal format, otherwise it will
>> +printed in hexadecimal format.
>> +
>> +	- smart: echo nofuncgraph-retval-hex > trace_options
>> +	- hexadecimal always: echo funcgraph-retval-hex > trace_options
>> +
>> +  Example with funcgraph-retval-hex::
>> +
>> +    1)               |      cgroup_migrate() {
>> +    1)   0.651 us    |        cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
>> +    1)               |        cgroup_migrate_execute() {
>> +    1)               |          cpu_cgroup_can_attach() {
>> +    1)               |            cgroup_taskset_first() {
>> +    1)   0.732 us    |              cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
>> +    1)   1.232 us    |            } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
>> +    1)   0.380 us    |            sched_rt_can_attach(); /* = 0x0 */
>> +    1)   2.335 us    |          } /* cpu_cgroup_can_attach = 0xffffffea */
>> +    1)   4.369 us    |        } /* cgroup_migrate_execute = 0xffffffea */
>> +    1)   7.143 us    |      } /* cgroup_migrate = 0xffffffea */
>> +
>> +At present, there are some limitations when using the funcgraph-retval
>> +option, and these limitations will be eliminated in the future:
>> +
>> +- Even if the function return type is void, a return value will still
>> +  be printed, and you can just ignore it.
>> +
>> +- Even if return values are stored in multiple registers, only the
>> +  value contained in the first register will be recorded and printed.
>> +  To illustrate, in the x86 architecture, eax and edx are used to store
>> +  a 64-bit return value, with the lower 32 bits saved in eax and the
>> +  upper 32 bits saved in edx. However, only the value stored in eax
>> +  will be recorded and printed.
> 
> With some procedure call standards (e.g. arm64's AAPCS64), when a type is
> smaller than a GPR it's up to the consumer to perform the narrowing, and the
> upport bits may contain UNKNOWN values. For example, with a u8 in a 64-bit GPR,
> bits [3:8] may contain arbitrary values.

Thank you. Just to clarify, Should it be that bits [63:8] may contain
arbitrary values in such cases?

> 
> It's probably worth noting that this means *some* manual processing will always
> be necessary for such cases.
> 
> That's mostly visible around where largelr types get truncated (whether
> explciitly or implicitly), e.g.
> 
> 	u8 narrow_to_u8(u64 val)
> 	{
> 		// implicitly truncated
> 		return val;
> 	}
> 
> ... could be compiled to:
> 
> 	narrow_to_u8:
> 		< ... ftrace instrumentation ... >
> 		RET
> 
> ... and so:
> 	
> 	narrow_to_u8(0x123456789abcdef);
> 
> ... might be recorded as returning 0x123456789abcdef rather than 0xef.
> 
> 
> That can happen in surprising ways, e.g.
> 
> 	int error_if_not_4g_aligned(u64 val)
> 	{
> 		if (val & GENMASK(63, 32))

Should it be GENMASK(31, 0)?

> 			return -EINVAL;
> 
> 		return 0;
> 	}
> 
> ... could be compiled to:
> 
> 	error_if_not_4g_aligned:
> 		CBNZ	w0, .Lnot_aligned
> 		RET				// bits [31:0] are zero, bits
> 						// [63:32] are UNKNOWN
> 	.Lnot_aligned:
> 		MOV	x0, #-EINVAL
> 		RET
> 
> .... and so:
> 
> 	error_if_not_4g_aligned(SZ_8G)
> 
> ... could return with bits [63:32] non-zero
> 
> Thanks,
> Mark.

Thank you for sharing this note. I will append the following limitation.

In certain procedure call standards, such as arm64's AAPCS64, when a
type is smaller than a GPR, it is the responsibility of the consumer to
perform the narrowing, and the upper bits may contain UNKNOWN values.
Therefore, it is advisable to check the code for such cases. For
instance,when using a u8 in a 64-bit GPR, bits [63:8] may contain
arbitrary values, especially when larger types are truncated, whether
explicitly or implicitly. Here are some specific cases to illustrate
this point:

  - Case One:

   The function narrow_to_u8 is defined as follows:

  	u8 narrow_to_u8(u64 val)
	{
		// implicitly truncated
		return val;
	}

   It may be compiled to:

	narrow_to_u8:
		< ... ftrace instrumentation ... >
		RET

   If you pass 0x123456789abcdef to this function and want to narrow it,
   it may be recorded as 0x123456789abcdef instead of 0xef.

   - Case Two:

   The function error_if_not_4g_aligned is defined as follows:

	int error_if_not_4g_aligned(u64 val)
	{
		if (val & GENMASK(31, 0))
			return -EINVAL;

		return 0;
	}

   It could be compile to:

	error_if_not_4g_aligned:
		CBNZ	w0, .Lnot_aligned
		RET				// bits [31:0] are zero, bits
						// [63:32] are UNKNOWN
	.Lnot_aligned:
		MOV	x0, #-EINVAL
		RET

   When passing 0x2_0000_0000 to it, the return value may be recorded as
   0x2_0000_0000 instead of 0.
