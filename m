Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55D6F22BC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 05:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjD2Dn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 23:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2Dn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 23:43:26 -0400
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B002680;
        Fri, 28 Apr 2023 20:43:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.STmyWyg_1682739796;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STmyWyg_1682739796)
          by smtp.aliyun-inc.com;
          Sat, 29 Apr 2023 11:43:16 +0800
Date:   Sat, 29 Apr 2023 11:43:15 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 21/43] x86/ftrace: Adapt assembly for PIE support
Message-ID: <20230429034315.GB91541@k08j02272.eu95sqa>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <0092ce94b325ad8eb47ff4f95e012f9af1a127de.1682673543.git.houwenlong.hwl@antgroup.com>
 <20230428093719.037081e3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428093719.037081e3@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 09:37:19PM +0800, Steven Rostedt wrote:
> On Fri, 28 Apr 2023 17:51:01 +0800
> "Hou Wenlong" <houwenlong.hwl@antgroup.com> wrote:
> 
> > Change the assembly code to use only relative references of symbols for
> > the kernel to be PIE compatible.
> > 
> > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > Cc: Thomas Garnier <thgarnie@chromium.org>
> > Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/kernel/ftrace_64.S | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > index eddb4fabc16f..411fa4148e18 100644
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -315,7 +315,14 @@ STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
> >  SYM_FUNC_START(__fentry__)
> >  	CALL_DEPTH_ACCOUNT
> >  
> > +#ifdef CONFIG_X86_PIE
> > +	pushq %r8
> > +	leaq ftrace_stub(%rip), %r8
> > +	cmpq %r8, ftrace_trace_function(%rip)
> > +	popq %r8
> > +#else
> >  	cmpq $ftrace_stub, ftrace_trace_function
> > +#endif
> >  	jnz trace
> >  	RET
> >  
> > @@ -329,7 +336,7 @@ trace:
> >  	 * ip and parent ip are used and the list function is called when
> >  	 * function tracing is enabled.
> >  	 */
> > -	movq ftrace_trace_function, %r8
> > +	movq ftrace_trace_function(%rip), %r8
> >  	CALL_NOSPEC r8
> >  	restore_mcount_regs
> >  
> 
> I really don't want to add more updates to !DYNAMIC_FTRACE. This code only
> exists to make sure I don't break it for other architectures.
> 
> How about
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 442eccc00960..ee4d0713139d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -37,7 +37,7 @@ config X86_64
>  
>  config FORCE_DYNAMIC_FTRACE
>  	def_bool y
> -	depends on X86_32
> +	depends on X86_32 || X86_PIE
>  	depends on FUNCTION_TRACER
>  	select DYNAMIC_FTRACE
>  	help
> 
> 
> ?
>
OK, I'll drop it. Actually, I select DYNAMIC_FTRACE when
CONFIG_RETPOLINE is enabled for PIE due to the indirect call for
__fentry__() in patch 34.

Thanks.
> -- Steve
