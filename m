Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8369C63FD39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiLBAnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiLBAnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:43:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27F45AE20
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:43:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F909621D5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC501C433D6;
        Fri,  2 Dec 2022 00:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669941782;
        bh=vrpHgsXnWq/mFSpt5S6Islz7chU8nc7CTyA5NLJO2CQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yi1Vp5+azdR9L5gJ9EOmJbTLCfvxt0poEKYHftsX3TPvWgVHg6kFOtwji8/F8l3se
         xFRYA0OILK8snjGAQ8jKvwyMQAzRaiRxDdZcNUP4P3eERu6prJXRAIfQJhPfP0/A+7
         Bcb+Fe7kWjYK01cJbvTz/YsAhlenewYuphyyl7nNVaIr+N524BUO0qAX64zpsZehIz
         YLJZ1kQVCySDwuKREvkpHRGEtWRYt7B72zS3SeK4zV3hX4obFUT9qHer8Sr0dhyNgX
         4zAoeqNkEb7rPgPc83CMgEAe0oQ2SFkp7u0TsdiurKc7vBT+3eawtiEgpm8rGBhINr
         ex37831vU5mwA==
Date:   Fri, 2 Dec 2022 09:42:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: Re: [PATCH 3/3] arm64: kprobes: Return DBG_HOOK_ERROR if kprobes
 can not handle a BRK
Message-Id: <20221202094258.1ca06a6f49dcc3878e18c46a@kernel.org>
In-Reply-To: <Y4jis+EsXuQb7l2n@FVFF77S0Q05N>
References: <166990553243.253128.13594802750635478633.stgit@devnote3>
        <166990556124.253128.2968612748605960211.stgit@devnote3>
        <Y4jDhHDQD3wY6g8C@FVFF77S0Q05N>
        <20221202010713.15d9c3bf5520b17a3df8e290@kernel.org>
        <Y4jis+EsXuQb7l2n@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 17:21:55 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Dec 02, 2022 at 01:07:13AM +0900, Masami Hiramatsu wrote:
> > On Thu, 1 Dec 2022 15:08:52 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > On Thu, Dec 01, 2022 at 11:39:21PM +0900, Masami Hiramatsu (Google) wrote:
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > 
> > > > Return DBG_HOOK_ERROR if kprobes can not handle a BRK because it
> > > > fails to find a kprobe corresponding to the address.
> > > > 
> > > > Since arm64 kprobes uses stop_machine based text patching for removing
> > > > BRK, it ensures all running kprobe_break_handler() is done at that point.
> > > > And after removing the BRK, it removes the kprobe from its hash list.
> > > > Thus, if the kprobe_break_handler() fails to find kprobe from hash list,
> > > > there is a bug.
> > > 
> > > IIUC this relies on BRK handling not being preemptible, which is something
> > > we've repeatedly considered changing along with a bunch of other debug
> > > exception handling.
> > 
> > Interesting idea... and it also need many changes in kprobe itself.
> > 
> > > 
> > > In case we do try to change that in future, it would be good to have a comment
> > > somewhere to that effect.
> > 
> > Hmm, it would fundamentally change the assumptions that kprobes relies on,
> > and would require a lot of thought again. (e.g. current running kprobe is
> > stored in per-cpu variable, it should be per-task. etc.)
> 
> Ah; I had not considered that.
> 
> Feel free to ignore the above; with the comments as below:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

OK, Thanks!

> 
> Thanks,
> Mark.
> 
> > 
> > > 
> > > I think there are other ways we could synchronise against that (e.g. using RCU
> > > tasks rude) if we ever do that, and this patch looks good to me.
> > > 
> > > > 
> > > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > ---
> > > >  arch/arm64/kernel/probes/kprobes.c |   79 +++++++++++++++++-------------------
> > > >  1 file changed, 37 insertions(+), 42 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > > index d2ae37f89774..ea56b22d4da8 100644
> > > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > > @@ -298,7 +298,8 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static void __kprobes kprobe_handler(struct pt_regs *regs)
> > > > +static int __kprobes
> > > > +kprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
> > > >  {
> > > >  	struct kprobe *p, *cur_kprobe;
> > > >  	struct kprobe_ctlblk *kcb;
> > > > @@ -308,39 +309,45 @@ static void __kprobes kprobe_handler(struct pt_regs *regs)
> > > >  	cur_kprobe = kprobe_running();
> > > >  
> > > >  	p = get_kprobe((kprobe_opcode_t *) addr);
> > > > +	if (WARN_ON_ONCE(!p)) {
> > > > +		/*
> > > > +		 * Something went wrong. This must be put by kprobe, but we
> > > > +		 * could not find corresponding kprobes. Let the kernel handle
> > > > +		 * this error case.
> > > > +		 */
> > > 
> > > Could we make this:
> > > 
> > > 		/*
> > > 		 * Something went wrong. This BRK used an immediate reserved
> > > 		 * for kprobes, but we couldn't find any corresponding probe.
> > > 		 */
> > 
> > OK.
> > 
> > > 
> > > > +		return DBG_HOOK_ERROR;
> > > > +	}
> > > >  
> > > > -	if (p) {
> > > > -		if (cur_kprobe) {
> > > > -			if (reenter_kprobe(p, regs, kcb))
> > > > -				return;
> > > > -		} else {
> > > > -			/* Probe hit */
> > > > -			set_current_kprobe(p);
> > > > -			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > > > -
> > > > -			/*
> > > > -			 * If we have no pre-handler or it returned 0, we
> > > > -			 * continue with normal processing.  If we have a
> > > > -			 * pre-handler and it returned non-zero, it will
> > > > -			 * modify the execution path and no need to single
> > > > -			 * stepping. Let's just reset current kprobe and exit.
> > > > -			 */
> > > > -			if (!p->pre_handler || !p->pre_handler(p, regs)) {
> > > > -				setup_singlestep(p, regs, kcb, 0);
> > > > -			} else
> > > > -				reset_current_kprobe();
> > > > -		}
> > > > +	if (cur_kprobe) {
> > > > +		/* Hit a kprobe inside another kprobe */
> > > > +		if (!reenter_kprobe(p, regs, kcb))
> > > > +			return DBG_HOOK_ERROR;
> > > > +	} else {
> > > > +		/* Probe hit */
> > > > +		set_current_kprobe(p);
> > > > +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > > > +
> > > > +		/*
> > > > +		 * If we have no pre-handler or it returned 0, we
> > > > +		 * continue with normal processing.  If we have a
> > > > +		 * pre-handler and it returned non-zero, it will
> > > > +		 * modify the execution path and no need to single
> > > > +		 * stepping. Let's just reset current kprobe and exit.
> > > > +		 */
> > > 
> > > Minor wording nit: could we replace:
> > > 
> > > 	no need to single stepping.
> > > 
> > > With:
> > > 	
> > > 	not need to single-step.
> > 
> > OK, I'll update both in v2.
> > 
> > Thank you!
> > 
> > > 
> > > Thanks,
> > > Mark.
> > > 
> > > > +		if (!p->pre_handler || !p->pre_handler(p, regs))
> > > > +			setup_singlestep(p, regs, kcb, 0);
> > > > +		else
> > > > +			reset_current_kprobe();
> > > >  	}
> > > > -	/*
> > > > -	 * The breakpoint instruction was removed right
> > > > -	 * after we hit it.  Another cpu has removed
> > > > -	 * either a probepoint or a debugger breakpoint
> > > > -	 * at this address.  In either case, no further
> > > > -	 * handling of this interrupt is appropriate.
> > > > -	 * Return back to original instruction, and continue.
> > > > -	 */
> > > > +
> > > > +	return DBG_HOOK_HANDLED;
> > > >  }
> > > >  
> > > > +static struct break_hook kprobes_break_hook = {
> > > > +	.imm = KPROBES_BRK_IMM,
> > > > +	.fn = kprobe_breakpoint_handler,
> > > > +};
> > > > +
> > > >  static int __kprobes
> > > >  kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned long esr)
> > > >  {
> > > > @@ -365,18 +372,6 @@ static struct break_hook kprobes_break_ss_hook = {
> > > >  	.fn = kprobe_breakpoint_ss_handler,
> > > >  };
> > > >  
> > > > -static int __kprobes
> > > > -kprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
> > > > -{
> > > > -	kprobe_handler(regs);
> > > > -	return DBG_HOOK_HANDLED;
> > > > -}
> > > > -
> > > > -static struct break_hook kprobes_break_hook = {
> > > > -	.imm = KPROBES_BRK_IMM,
> > > > -	.fn = kprobe_breakpoint_handler,
> > > > -};
> > > > -
> > > >  /*
> > > >   * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
> > > >   * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
> > > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
