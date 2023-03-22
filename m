Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8116C4587
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCVJCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCVJCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:02:03 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5D95B42A;
        Wed, 22 Mar 2023 02:02:01 -0700 (PDT)
Received: from [10.128.10.193] (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 9E5CB5807BE;
        Wed, 22 Mar 2023 17:01:55 +0800 (CST)
Message-ID: <88c2c37b-c221-5c27-9663-7026084adf8d@sangfor.com.cn>
Date:   Wed, 22 Mar 2023 17:01:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/2] function_graph: Support recording and printing the
 return value of function
Content-Language: en-US
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
References: <20230320131650.482594-1-pengdonglin@sangfor.com.cn>
 <20230320131650.482594-2-pengdonglin@sangfor.com.cn>
 <ZBnqAYO7rdk4Qikq@shell.armlinux.org.uk>
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
In-Reply-To: <ZBnqAYO7rdk4Qikq@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTx4eVkwdS0NOT04YGR0eTFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS09ISFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46GSo*Kj0OKRRJLRI3QiE2
        NwNPFA9VSlVKTUxCT0xOTEpMS01MVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFPTU1DNwY+
X-HM-Tid: 0a87088db1662eb7kusn9e5cb5807be
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/22 1:31, Russell King (Oracle) wrote:
> On Mon, Mar 20, 2023 at 06:16:49AM -0700, Donglin Peng wrote:
>> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
>> index 3e7bcaca5e07..ba1986e27af8 100644
>> --- a/arch/arm/kernel/entry-ftrace.S
>> +++ b/arch/arm/kernel/entry-ftrace.S
>> @@ -258,7 +258,15 @@ ENDPROC(ftrace_graph_regs_caller)
>>   #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>   ENTRY(return_to_handler)
>>   	stmdb	sp!, {r0-r3}
>> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>> +	/*
>> +	 * Pass both the function return values in the register r0 and r1
>> +	 * to ftrace_return_to_handler
>> +	 */
>> +	add	r2, sp, #16		@ sp at exit of instrumented routine
>> +#else
>>   	add	r0, sp, #16		@ sp at exit of instrumented routine
>> +#endif
>>   	bl	ftrace_return_to_handler
> ...
>> -unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>> +static unsigned long __ftrace_return_to_handler(unsigned long retval_1st,
>> +			unsigned long retval_2nd, unsigned long frame_pointer)
> ...
>> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>> +unsigned long ftrace_return_to_handler(unsigned long retval_1st,
>> +			unsigned long retval_2nd, unsigned long frame_pointer)
>> +{
>> +	return __ftrace_return_to_handler(retval_1st, retval_2nd, frame_pointer);
>> +}
>> +#else
>> +unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>> +{
>> +	return __ftrace_return_to_handler(0, 0, frame_pointer);
>> +}
>> +#endif
>> +
> 
> Hi,
> 
> To echo Mark's criticism, I also don't like this. I feel it would be
> better if ftrace_return_to_handler() always took the same arguments
> irrespective of the setting of CONFIG_FUNCTION_GRAPH_RETVAL.
> 
> On 32-bit ARM, we have to stack r0-r3 anyway to prevent the call to
> ftrace_return_to_handler() corrupting the return value, and these
> are the registers we need. So we might as well pass a pointer to
> these stacked registers. Whether that's acceptable on other
> architectures, I couldn't say.

Agree, I think we can introduce a new structure called pt_ret_regs for
each relevant architecture. The pt_ret_regs should only contain the
return registers and the frame pointer register, for arm, they are r0~r3
and r11.Then we can pass the pointer to the pt_ret_regs to 
ftrace_return_to_handler.

> 
> Thanks.
> 

