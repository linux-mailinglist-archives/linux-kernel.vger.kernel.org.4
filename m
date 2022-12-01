Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E5563F617
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiLARWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLARWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:22:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BED27AFCE0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:22:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8CAED6E;
        Thu,  1 Dec 2022 09:22:20 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.5.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B528B3F73B;
        Thu,  1 Dec 2022 09:22:12 -0800 (PST)
Date:   Thu, 1 Dec 2022 17:21:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: Re: [PATCH 3/3] arm64: kprobes: Return DBG_HOOK_ERROR if kprobes can
 not handle a BRK
Message-ID: <Y4jis+EsXuQb7l2n@FVFF77S0Q05N>
References: <166990553243.253128.13594802750635478633.stgit@devnote3>
 <166990556124.253128.2968612748605960211.stgit@devnote3>
 <Y4jDhHDQD3wY6g8C@FVFF77S0Q05N>
 <20221202010713.15d9c3bf5520b17a3df8e290@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202010713.15d9c3bf5520b17a3df8e290@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 01:07:13AM +0900, Masami Hiramatsu wrote:
> On Thu, 1 Dec 2022 15:08:52 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Thu, Dec 01, 2022 at 11:39:21PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Return DBG_HOOK_ERROR if kprobes can not handle a BRK because it
> > > fails to find a kprobe corresponding to the address.
> > > 
> > > Since arm64 kprobes uses stop_machine based text patching for removing
> > > BRK, it ensures all running kprobe_break_handler() is done at that point.
> > > And after removing the BRK, it removes the kprobe from its hash list.
> > > Thus, if the kprobe_break_handler() fails to find kprobe from hash list,
> > > there is a bug.
> > 
> > IIUC this relies on BRK handling not being preemptible, which is something
> > we've repeatedly considered changing along with a bunch of other debug
> > exception handling.
> 
> Interesting idea... and it also need many changes in kprobe itself.
> 
> > 
> > In case we do try to change that in future, it would be good to have a comment
> > somewhere to that effect.
> 
> Hmm, it would fundamentally change the assumptions that kprobes relies on,
> and would require a lot of thought again. (e.g. current running kprobe is
> stored in per-cpu variable, it should be per-task. etc.)

Ah; I had not considered that.

Feel free to ignore the above; with the comments as below:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> 
> > 
> > I think there are other ways we could synchronise against that (e.g. using RCU
> > tasks rude) if we ever do that, and this patch looks good to me.
> > 
> > > 
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > >  arch/arm64/kernel/probes/kprobes.c |   79 +++++++++++++++++-------------------
> > >  1 file changed, 37 insertions(+), 42 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > index d2ae37f89774..ea56b22d4da8 100644
> > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > @@ -298,7 +298,8 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
> > >  	return 0;
> > >  }
> > >  
> > > -static void __kprobes kprobe_handler(struct pt_regs *regs)
> > > +static int __kprobes
> > > +kprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
> > >  {
> > >  	struct kprobe *p, *cur_kprobe;
> > >  	struct kprobe_ctlblk *kcb;
> > > @@ -308,39 +309,45 @@ static void __kprobes kprobe_handler(struct pt_regs *regs)
> > >  	cur_kprobe = kprobe_running();
> > >  
> > >  	p = get_kprobe((kprobe_opcode_t *) addr);
> > > +	if (WARN_ON_ONCE(!p)) {
> > > +		/*
> > > +		 * Something went wrong. This must be put by kprobe, but we
> > > +		 * could not find corresponding kprobes. Let the kernel handle
> > > +		 * this error case.
> > > +		 */
> > 
> > Could we make this:
> > 
> > 		/*
> > 		 * Something went wrong. This BRK used an immediate reserved
> > 		 * for kprobes, but we couldn't find any corresponding probe.
> > 		 */
> 
> OK.
> 
> > 
> > > +		return DBG_HOOK_ERROR;
> > > +	}
> > >  
> > > -	if (p) {
> > > -		if (cur_kprobe) {
> > > -			if (reenter_kprobe(p, regs, kcb))
> > > -				return;
> > > -		} else {
> > > -			/* Probe hit */
> > > -			set_current_kprobe(p);
> > > -			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > > -
> > > -			/*
> > > -			 * If we have no pre-handler or it returned 0, we
> > > -			 * continue with normal processing.  If we have a
> > > -			 * pre-handler and it returned non-zero, it will
> > > -			 * modify the execution path and no need to single
> > > -			 * stepping. Let's just reset current kprobe and exit.
> > > -			 */
> > > -			if (!p->pre_handler || !p->pre_handler(p, regs)) {
> > > -				setup_singlestep(p, regs, kcb, 0);
> > > -			} else
> > > -				reset_current_kprobe();
> > > -		}
> > > +	if (cur_kprobe) {
> > > +		/* Hit a kprobe inside another kprobe */
> > > +		if (!reenter_kprobe(p, regs, kcb))
> > > +			return DBG_HOOK_ERROR;
> > > +	} else {
> > > +		/* Probe hit */
> > > +		set_current_kprobe(p);
> > > +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > > +
> > > +		/*
> > > +		 * If we have no pre-handler or it returned 0, we
> > > +		 * continue with normal processing.  If we have a
> > > +		 * pre-handler and it returned non-zero, it will
> > > +		 * modify the execution path and no need to single
> > > +		 * stepping. Let's just reset current kprobe and exit.
> > > +		 */
> > 
> > Minor wording nit: could we replace:
> > 
> > 	no need to single stepping.
> > 
> > With:
> > 	
> > 	not need to single-step.
> 
> OK, I'll update both in v2.
> 
> Thank you!
> 
> > 
> > Thanks,
> > Mark.
> > 
> > > +		if (!p->pre_handler || !p->pre_handler(p, regs))
> > > +			setup_singlestep(p, regs, kcb, 0);
> > > +		else
> > > +			reset_current_kprobe();
> > >  	}
> > > -	/*
> > > -	 * The breakpoint instruction was removed right
> > > -	 * after we hit it.  Another cpu has removed
> > > -	 * either a probepoint or a debugger breakpoint
> > > -	 * at this address.  In either case, no further
> > > -	 * handling of this interrupt is appropriate.
> > > -	 * Return back to original instruction, and continue.
> > > -	 */
> > > +
> > > +	return DBG_HOOK_HANDLED;
> > >  }
> > >  
> > > +static struct break_hook kprobes_break_hook = {
> > > +	.imm = KPROBES_BRK_IMM,
> > > +	.fn = kprobe_breakpoint_handler,
> > > +};
> > > +
> > >  static int __kprobes
> > >  kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned long esr)
> > >  {
> > > @@ -365,18 +372,6 @@ static struct break_hook kprobes_break_ss_hook = {
> > >  	.fn = kprobe_breakpoint_ss_handler,
> > >  };
> > >  
> > > -static int __kprobes
> > > -kprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
> > > -{
> > > -	kprobe_handler(regs);
> > > -	return DBG_HOOK_HANDLED;
> > > -}
> > > -
> > > -static struct break_hook kprobes_break_hook = {
> > > -	.imm = KPROBES_BRK_IMM,
> > > -	.fn = kprobe_breakpoint_handler,
> > > -};
> > > -
> > >  /*
> > >   * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
> > >   * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
> > > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
