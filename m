Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0656BCFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCPMjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCPMje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12893144AD;
        Thu, 16 Mar 2023 05:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1DA962000;
        Thu, 16 Mar 2023 12:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D76C433EF;
        Thu, 16 Mar 2023 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678970371;
        bh=kFvhACJwx9bZhyzisvpDgQzAutWLxqYdw6r6fSMMCso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mjj0O5yunvQi4KJeuDculdQpHv5/fW/DoGOUtrhmW0CLMCdukwcO7YYbw0NQ9pm97
         kOqCA4uQwsJfPmjOmTwpY526Q7NdSjVLY6uGwLgKQ1t+Szfm9AyXfCefDqBF+24rqY
         McpICDN7xMQYvzEVLh2KpctN1oGzzwLbk1j+O3OsvwpqGGw0r03ehDOPSabVIXQjY8
         VxPApXkGlP9ou2r6kw7hSJzkz/UYHC4Bi+zvvQQ0J78pbfdfud4XaisDbQ+wPHed5J
         fFqsutMiR4ZCLJYrnxbC8BfTble9TKcmUZFCuyDSgEsj7Fx+PCza1FIC7wU+rXFOp9
         ebuWhUaAGKZ+g==
Date:   Thu, 16 Mar 2023 21:39:25 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        linux@armlinux.org.uk, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] function_graph: Support recording and printing
 the return value of function
Message-Id: <20230316213925.f958c648e25f723db86aa705@kernel.org>
In-Reply-To: <664f9fa1-da31-2be9-76d9-3eb08e08b7f9@sangfor.com.cn>
References: <20230315133911.958741-1-pengdonglin@sangfor.com.cn>
        <20230315133911.958741-2-pengdonglin@sangfor.com.cn>
        <20230315134911.GD2006103@hirez.programming.kicks-ass.net>
        <20230315101348.1234c7f5@gandalf.local.home>
        <20230315145757.GE2006103@hirez.programming.kicks-ass.net>
        <664f9fa1-da31-2be9-76d9-3eb08e08b7f9@sangfor.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 11:18:23 +0800
Donglin Peng <pengdonglin@sangfor.com.cn> wrote:

> On 2023/3/15 22:57, Peter Zijlstra wrote:
> > On Wed, Mar 15, 2023 at 10:13:48AM -0400, Steven Rostedt wrote:
> >> On Wed, 15 Mar 2023 14:49:11 +0100
> >> Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >>>> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> >>>> index 1265ad519249..35ac9c58dc77 100644
> >>>> --- a/arch/x86/kernel/ftrace_64.S
> >>>> +++ b/arch/x86/kernel/ftrace_64.S
> >>>> @@ -348,6 +348,10 @@ SYM_CODE_START(return_to_handler)
> >>>>   	movq %rax, (%rsp)
> >>>>   	movq %rdx, 8(%rsp)
> >>>>   	movq %rbp, %rdi
> >>>> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> >>>> +	/* Pass the function return value to ftrace_return_to_handler */
> >>>> +	movq %rax, %rsi
> >>>> +#endif
> >>>>   
> >>>>   	call ftrace_return_to_handler
> >>>
> >>> What about the case of double register return values (when the value
> >>> is returned in the A,D pair) ?
> >>
> >> Is there anything that does that in 64 bit kernels?
> > 
> > Note sure; but I have a patch series that introduces cmpxchg128 and
> > friends. Most of the actual functions are __always_inline, but still,
> > the moment a compiler decides to break out a subfunction on a u128
> > boundary we're in luck.
> I have reviewed the kretprobe implementation and noticed that $retval
> only retrieves the value of pt_regs.ax, which is an unsigned long data
> type. I wrote a demo and tested it on an x86 machine, and found that
> $retval only shows the least significant 32 bits of retval.Therefore,I
> think it can be consistent with kretprobe.

Yeah, because it doesn't support 128bit type (u128/long long).
It is possible to support it, but I think we can just document this
as a limitation for fgraph return value. It is just for quickly trace
most of the return values.

Thank you,

> 
> static noinline unsigned long long test_retval_func(void)
> {
> 	unsigned long long value = 0x1234567887654321;
> 	return value;
> }
> 
> add a kretprobe event:
> echo 'r:myretprobe test_retval_func $retval:x64' > kprobe_events
> 
> the trace log:
> myretprobe: (retval_open+0x1c/0x2c [test_retval] <- test_retval_func) 
> arg1=0x87654321


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
