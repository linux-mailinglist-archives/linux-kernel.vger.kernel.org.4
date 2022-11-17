Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472C562D878
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiKQKwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbiKQKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:52:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9255D5ADCA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:52:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D5DED6E;
        Thu, 17 Nov 2022 02:52:31 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.70.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B16903F73B;
        Thu, 17 Nov 2022 02:52:23 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:52:15 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        revest@chromium.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 4/4] ftrace: arm64: move from REGS to ARGS
Message-ID: <Y3YRqvfYOP+RBk8r@FVFF77S0Q05N>
References: <20221103170520.931305-1-mark.rutland@arm.com>
 <20221103170520.931305-5-mark.rutland@arm.com>
 <20221115112701.GB32523@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115112701.GB32523@willie-the-truck>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:27:03AM +0000, Will Deacon wrote:
> On Thu, Nov 03, 2022 at 05:05:20PM +0000, Mark Rutland wrote:
> > This commit replaces arm64's support for FTRACE_WITH_REGS with support
> > for FTRACE_WITH_ARGS. This removes some overhead and complexity, and
> > removes some latent issues with inconsistent presentation of struct
> > pt_regs (which can only be reliably saved/restored at exception
> > boundaries).
> 
> [...]
> 
> > @@ -78,10 +77,71 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >  	return addr;
> >  }
> >  
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> >  struct dyn_ftrace;
> >  struct ftrace_ops;
> > -struct ftrace_regs;
> > +
> > +#define arch_ftrace_get_regs(regs) NULL
> > +
> > +struct ftrace_regs {
> > +	/* x0 - x8 */
> > +	unsigned long regs[9];
> > +	unsigned long __unused;
> > +
> > +	unsigned long fp;
> > +	unsigned long lr;
> > +
> > +	unsigned long sp;
> > +	unsigned long pc;
> > +};
> > +
> > +static __always_inline unsigned long
> > +ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
> > +{
> > +	return fregs->pc;
> > +}
> > +
> > +static __always_inline void
> > +ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
> > +				    unsigned long pc)
> > +{
> > +	fregs->pc = pc;
> > +}
> > +
> > +static __always_inline unsigned long
> > +ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
> > +{
> > +	return fregs->sp;
> > +}
> > +
> > +static __always_inline unsigned long
> > +ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
> > +{
> > +	if (n < 8)
> > +		return fregs->regs[n];
> 
> Where does this '8' come from?

Because in AAPCS64 the arguments are in x0 to x7, as mentioned in the commit
message:

| Per AAPCS64, all function call argument and return values are held in
| the following GPRs:
| 
| * X0 - X7 : parameter / result registers
| * X8      : indirect result location register
| * SP      : stack pointer (AKA SP)

The 'indirect result location register' would be used when returning large
structures, and isn't a function argument as such.

The logic is the same as in regs_get_kernel_argument() for pt_regs.

I can add a comment here to explain that, if that would help?

The rest of the registers are as described in the commit message (and I now
spot a typo that I'll go fix):

| Additionally, ad function call boundaries, the following GPRs hold
| context/return information:
| 
| * X29 : frame pointer (AKA FP)
| * X30 : link register (AKA LR)
| 
| ... and for ftrace we need to capture the instrumented address:
| 
|  * PC  : program counter
| 
| No other GPRs are relevant, as none of the other arguments hold
| parameters or return values:
| 
| * X9  - X17 : temporaries, may be clobbered
| * X18       : shadow call stack pointer (or temorary)
| * X19 - X28 : callee saved

Thanks,
Mark.
