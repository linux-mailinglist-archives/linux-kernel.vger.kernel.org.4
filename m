Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C362F4CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiKRMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiKRMb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:31:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14138CD0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:31:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7CF0B823AE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EFBC433D6;
        Fri, 18 Nov 2022 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668774715;
        bh=Nh3NzJbEfvZTCSH3QvtCEwh5yBDVeSLUhz1ZQCC1KD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K9ZdtXF0U/keAUEDERBh8h2v7ZUwV9O2Wl5Gm68a5Hh3izm3vmUk8+H7cySeSRaJR
         SCU4lz5MX5ZNV0AwMNMa2mdARmapdZQqVXBURVYmCnvF1E4vaAaQPFPCnalw/fCw0L
         k+0qrMksCEUxmf8abkMcEpMrtOzpS1+wN0zN0jRuTyuRtid7j10AgjUueQILI3n+sp
         SQiFgrRctAuICj63oYSxdnHOZhOi45c9JjJ/iAFA0Sekk1RlXOtRSQQfY02KxeWmJd
         AopymhGU0kiiTHI+IaTJk7xEM3JdEjzVLrRG5dDOHhdSyN6a59WOBpDUfi3wYwMxyw
         am7cLpmdiq8bQ==
Date:   Fri, 18 Nov 2022 12:31:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        revest@chromium.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 4/4] ftrace: arm64: move from REGS to ARGS
Message-ID: <20221118123149.GB3697@willie-the-truck>
References: <20221103170520.931305-1-mark.rutland@arm.com>
 <20221103170520.931305-5-mark.rutland@arm.com>
 <20221115112701.GB32523@willie-the-truck>
 <Y3YRqvfYOP+RBk8r@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3YRqvfYOP+RBk8r@FVFF77S0Q05N>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:52:15AM +0000, Mark Rutland wrote:
> On Tue, Nov 15, 2022 at 11:27:03AM +0000, Will Deacon wrote:
> > On Thu, Nov 03, 2022 at 05:05:20PM +0000, Mark Rutland wrote:
> > > This commit replaces arm64's support for FTRACE_WITH_REGS with support
> > > for FTRACE_WITH_ARGS. This removes some overhead and complexity, and
> > > removes some latent issues with inconsistent presentation of struct
> > > pt_regs (which can only be reliably saved/restored at exception
> > > boundaries).
> > 
> > [...]
> > 
> > > @@ -78,10 +77,71 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
> > >  	return addr;
> > >  }
> > >  
> > > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > >  struct dyn_ftrace;
> > >  struct ftrace_ops;
> > > -struct ftrace_regs;
> > > +
> > > +#define arch_ftrace_get_regs(regs) NULL
> > > +
> > > +struct ftrace_regs {
> > > +	/* x0 - x8 */
> > > +	unsigned long regs[9];
> > > +	unsigned long __unused;
> > > +
> > > +	unsigned long fp;
> > > +	unsigned long lr;
> > > +
> > > +	unsigned long sp;
> > > +	unsigned long pc;
> > > +};
> > > +
> > > +static __always_inline unsigned long
> > > +ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
> > > +{
> > > +	return fregs->pc;
> > > +}
> > > +
> > > +static __always_inline void
> > > +ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
> > > +				    unsigned long pc)
> > > +{
> > > +	fregs->pc = pc;
> > > +}
> > > +
> > > +static __always_inline unsigned long
> > > +ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
> > > +{
> > > +	return fregs->sp;
> > > +}
> > > +
> > > +static __always_inline unsigned long
> > > +ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
> > > +{
> > > +	if (n < 8)
> > > +		return fregs->regs[n];
> > 
> > Where does this '8' come from?
> 
> Because in AAPCS64 the arguments are in x0 to x7, as mentioned in the commit
> message:
> 
> | Per AAPCS64, all function call argument and return values are held in
> | the following GPRs:
> | 
> | * X0 - X7 : parameter / result registers
> | * X8      : indirect result location register
> | * SP      : stack pointer (AKA SP)
> 
> The 'indirect result location register' would be used when returning large
> structures, and isn't a function argument as such.

Ah gotcha, I was mainly wondering about the role of x8 in 'struct
ftrace_regs', but now I see that the FETCH_OP_REG might want to get at that.

Will
