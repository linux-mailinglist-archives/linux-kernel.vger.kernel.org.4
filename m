Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5267462F6B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbiKRN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242072AbiKRN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:58:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 112A813CF1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:57:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3486023A;
        Fri, 18 Nov 2022 05:58:05 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB4893F587;
        Fri, 18 Nov 2022 05:57:57 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:57:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        revest@chromium.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 4/4] ftrace: arm64: move from REGS to ARGS
Message-ID: <Y3ePYOxwPbSzxhoZ@FVFF77S0Q05N.cambridge.arm.com>
References: <20221103170520.931305-1-mark.rutland@arm.com>
 <20221103170520.931305-5-mark.rutland@arm.com>
 <20221115112701.GB32523@willie-the-truck>
 <Y3YRqvfYOP+RBk8r@FVFF77S0Q05N>
 <20221118123149.GB3697@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118123149.GB3697@willie-the-truck>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 12:31:50PM +0000, Will Deacon wrote:
> On Thu, Nov 17, 2022 at 10:52:15AM +0000, Mark Rutland wrote:
> > On Tue, Nov 15, 2022 at 11:27:03AM +0000, Will Deacon wrote:
> > > On Thu, Nov 03, 2022 at 05:05:20PM +0000, Mark Rutland wrote:
> > > > This commit replaces arm64's support for FTRACE_WITH_REGS with support
> > > > for FTRACE_WITH_ARGS. This removes some overhead and complexity, and
> > > > removes some latent issues with inconsistent presentation of struct
> > > > pt_regs (which can only be reliably saved/restored at exception
> > > > boundaries).
> > > 
> > > [...]
> > > 
> > > > @@ -78,10 +77,71 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
> > > >  	return addr;
> > > >  }
> > > >  
> > > > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > > >  struct dyn_ftrace;
> > > >  struct ftrace_ops;
> > > > -struct ftrace_regs;
> > > > +
> > > > +#define arch_ftrace_get_regs(regs) NULL
> > > > +
> > > > +struct ftrace_regs {
> > > > +	/* x0 - x8 */
> > > > +	unsigned long regs[9];
> > > > +	unsigned long __unused;
> > > > +
> > > > +	unsigned long fp;
> > > > +	unsigned long lr;
> > > > +
> > > > +	unsigned long sp;
> > > > +	unsigned long pc;
> > > > +};
> > > > +
> > > > +static __always_inline unsigned long
> > > > +ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
> > > > +{
> > > > +	return fregs->pc;
> > > > +}
> > > > +
> > > > +static __always_inline void
> > > > +ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
> > > > +				    unsigned long pc)
> > > > +{
> > > > +	fregs->pc = pc;
> > > > +}
> > > > +
> > > > +static __always_inline unsigned long
> > > > +ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
> > > > +{
> > > > +	return fregs->sp;
> > > > +}
> > > > +
> > > > +static __always_inline unsigned long
> > > > +ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
> > > > +{
> > > > +	if (n < 8)
> > > > +		return fregs->regs[n];
> > > 
> > > Where does this '8' come from?
> > 
> > Because in AAPCS64 the arguments are in x0 to x7, as mentioned in the commit
> > message:
> > 
> > | Per AAPCS64, all function call argument and return values are held in
> > | the following GPRs:
> > | 
> > | * X0 - X7 : parameter / result registers
> > | * X8      : indirect result location register
> > | * SP      : stack pointer (AKA SP)
> > 
> > The 'indirect result location register' would be used when returning large
> > structures, and isn't a function argument as such.
> 
> Ah gotcha, I was mainly wondering about the role of x8 in 'struct
> ftrace_regs', but now I see that the FETCH_OP_REG might want to get at that.

Ah, I see. Should I just add the bits above from the commit message into a
comment block above the definition of struct ftrace_regs ?

Thanks,
Mark.
