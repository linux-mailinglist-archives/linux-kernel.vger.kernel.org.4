Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE86BFF47
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 05:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCSEOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 00:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCSEOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 00:14:46 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9D511644;
        Sat, 18 Mar 2023 21:14:42 -0700 (PDT)
Received: from [192.168.2.16] (unknown [106.38.161.27])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id AFEDD5801B1;
        Sun, 19 Mar 2023 12:14:26 +0800 (CST)
Message-ID: <2147f6d6-24f8-7008-7b57-7a8509e79e0e@sangfor.com.cn>
Date:   Sun, 19 Mar 2023 12:14:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: Re: [PATCH v4 1/2] function_graph: Support recording and printing the
 return value of function
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        mhiramat@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, palmer@dabbelt.com,
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
 <34781b74-8d3e-a7e6-9abe-e8d45d680eec@sangfor.com.cn>
 <20230318124028.4faf75d1@rorschach.local.home>
In-Reply-To: <20230318124028.4faf75d1@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0sdVh5IGUIdQkxJS0JOT1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpLTVVIQ1VKTUpVSUxZV1kWGg8SFR0UWUFZT0tIVUpKS09ISFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6Ijo4Nj0IDxwqK0gtHBFO
        CzYwFCFVSlVKTUxCSkJCSU1MQ0hOVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSktNVUhDVUpNSlVJTFlXWQgBWUFPSkxLNwY+
X-HM-Tid: 0a86f8136a742eb7kusnafedd5801b1
X-HM-MType: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/19 0:40, Steven Rostedt wrote:
> On Fri, 17 Mar 2023 10:49:49 +0800
> Donglin Peng <pengdonglin@sangfor.com.cn> wrote:
> 
>>> So, really it depends what size of return value we want to report.
>>> Also, please bear in mind that where a function returns a 32-bit
>>> value, that will be in r0, and r1 will be whatever happened to be
>>> in it at function exit - there's no defined value for r1.
>>>    
>>
>> Thank you. I will document this as a limitation of fgraph return value.
>> It can just cover most cases at present and I think the r0 is enough.
> 
> One thing we could possibly do here is to use BTF or objtool to denote
> the return value of each function and use 2 bits of the ftrace
> rec->flags to state that it is:
> 
> 0 - void
> 1 - 1 word size return
> 2 - 2 word size return

Yeah, the BTF contains details of the function return type. However the
direct search cost is a bit high, we may parse it to fill the 
dyn_ftrace.flags.

> 
> I believe we can get access to the function's rec via the return call
> (or add that access) and pass both words to the return function, and
> then the return callback can use this lookup to determine what values
> are useful or not.

Yeah, we can obtain the function address via ret_stack in the function
ftrace_pop_return_trace, then pass the address to lookup_rec to
find the dyn_ftrace.

> 
> In any case, I would suggest passing both regs to the callback, and for
> now just ignore the second reg until we can come up with a way to
> differentiate each function.
> 

Yeah, I will modify it to pass two regs in v5.

> -- Steve

