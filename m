Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AB76BC48F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCPDUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCPDTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:19:07 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F948DCC1;
        Wed, 15 Mar 2023 20:18:31 -0700 (PDT)
Received: from [172.23.196.229] (unknown [121.32.254.146])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id B5BCD580405;
        Thu, 16 Mar 2023 11:18:23 +0800 (CST)
Message-ID: <664f9fa1-da31-2be9-76d9-3eb08e08b7f9@sangfor.com.cn>
Date:   Thu, 16 Mar 2023 11:18:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: Re: [PATCH v4 1/2] function_graph: Support recording and printing the
 return value of function
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
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
 <20230315134911.GD2006103@hirez.programming.kicks-ass.net>
 <20230315101348.1234c7f5@gandalf.local.home>
 <20230315145757.GE2006103@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20230315145757.GE2006103@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHx4fVkxDTx8YSENMGRgfTFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpJSlVISVVJTk9VSk9NWVdZFhoPEhUdFFlBWU9LSFVKSktPSEhVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Py46FBw6Cz0VDxkpUTAJMQgZ
        SEowC1FVSlVKTUxDQkhNTEtOSkpJVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSklKVUhJVUlOT1VKT01ZV1kIAVlBT09DSjcG
X-HM-Tid: 0a86e86d066f2eb7kusnb5bcd580405
X-HM-MType: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/15 22:57, Peter Zijlstra wrote:
> On Wed, Mar 15, 2023 at 10:13:48AM -0400, Steven Rostedt wrote:
>> On Wed, 15 Mar 2023 14:49:11 +0100
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>>> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
>>>> index 1265ad519249..35ac9c58dc77 100644
>>>> --- a/arch/x86/kernel/ftrace_64.S
>>>> +++ b/arch/x86/kernel/ftrace_64.S
>>>> @@ -348,6 +348,10 @@ SYM_CODE_START(return_to_handler)
>>>>   	movq %rax, (%rsp)
>>>>   	movq %rdx, 8(%rsp)
>>>>   	movq %rbp, %rdi
>>>> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>>>> +	/* Pass the function return value to ftrace_return_to_handler */
>>>> +	movq %rax, %rsi
>>>> +#endif
>>>>   
>>>>   	call ftrace_return_to_handler
>>>
>>> What about the case of double register return values (when the value
>>> is returned in the A,D pair) ?
>>
>> Is there anything that does that in 64 bit kernels?
> 
> Note sure; but I have a patch series that introduces cmpxchg128 and
> friends. Most of the actual functions are __always_inline, but still,
> the moment a compiler decides to break out a subfunction on a u128
> boundary we're in luck.
I have reviewed the kretprobe implementation and noticed that $retval
only retrieves the value of pt_regs.ax, which is an unsigned long data
type. I wrote a demo and tested it on an x86 machine, and found that
$retval only shows the least significant 32 bits of retval.Therefore,I
think it can be consistent with kretprobe.

static noinline unsigned long long test_retval_func(void)
{
	unsigned long long value = 0x1234567887654321;
	return value;
}

add a kretprobe event:
echo 'r:myretprobe test_retval_func $retval:x64' > kprobe_events

the trace log:
myretprobe: (retval_open+0x1c/0x2c [test_retval] <- test_retval_func) 
arg1=0x87654321
