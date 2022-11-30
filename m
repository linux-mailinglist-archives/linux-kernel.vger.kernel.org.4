Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E013863DA3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiK3QKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiK3QKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:10:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB9D490B9;
        Wed, 30 Nov 2022 08:10:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA4A761CC7;
        Wed, 30 Nov 2022 16:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85091C433D6;
        Wed, 30 Nov 2022 16:10:28 +0000 (UTC)
Date:   Wed, 30 Nov 2022 11:10:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/3] tracing/osnoise: Add preempt/irq disable options
Message-ID: <20221130111026.47b9c456@gandalf.local.home>
In-Reply-To: <700e7f91-00a9-d625-741d-122b9b1e1e1c@kernel.org>
References: <cover.1669409262.git.bristot@kernel.org>
        <03d4a8522792fa3a51920c79f8a5074933a2fcb3.1669409262.git.bristot@kernel.org>
        <20221128153919.33c008d1@gandalf.local.home>
        <700e7f91-00a9-d625-741d-122b9b1e1e1c@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 16:47:29 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 11/28/22 21:39, Steven Rostedt wrote:
> > On Fri, 25 Nov 2022 22:20:23 +0100
> > Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> >   
> >> @@ -1308,6 +1315,8 @@ static void notify_new_max_latency(u64 latency)
> >>   */
> >>  static int run_osnoise(void)
> >>  {
> >> +	bool preempt_disable = test_bit(OSN_PREEMPT_DISABLE, &osnoise_options);
> >> +	bool irq_disable = test_bit(OSN_IRQ_DISABLE, &osnoise_options);  
> > 
> > 	bool irq_disable = test_bit(OSN_IRQ_DISABLE, &osnoise_options);
> > 	bool preempt_disable = IS_ENABLED(CONFIG_PREEMPT) &&
> > 			!irq_disable && test_bit(OSN_PREEMPT_DISABLE, &osnoise_options);  
> 
> Ooops again, that is not exactly what I wanted, because...

Then just remove the "IS_ENABLED()" part and it should work just fine.

> 
> >>  	struct osnoise_variables *osn_var = this_cpu_osn_var();
> >>  	u64 start, sample, last_sample;
> >>  	u64 last_int_count, int_count;
> >> @@ -1335,6 +1344,14 @@ static int run_osnoise(void)
> >>  	 */
> >>  	threshold = tracing_thresh ? : 5000;
> >>  
> >> +	/*
> >> +	 * IRQ disable also implies in preempt disable.
> >> +	 */
> >> +	if (irq_disable)
> >> +		local_irq_disable();  
> > 
> > 	if (preempt_disable)  
> >> +		preempt_disable();

The above is a nop when CONFIG_PREEMPT is false.

> >> +
> >>  	/*
> >>  	 * Make sure NMIs see sampling first
> >>  	 */
> >> @@ -1422,16 +1439,21 @@ static int run_osnoise(void)
> >>  		 * cond_resched()
> >>  		 */
> >>  		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
> >> -			local_irq_disable();
> >> +			if (!irq_disable)
> >> +				local_irq_disable();
> >> +
> >>  			rcu_momentary_dyntick_idle();
> >> -			local_irq_enable();
> >> +
> >> +			if (!irq_disable)
> >> +				local_irq_enable();
> >>  		}
> >>  
> >>  		/*
> >>  		 * For the non-preemptive kernel config: let threads runs, if
> >> -		 * they so wish.
> >> +		 * they so wish, unless set not do to so.
> >>  		 */  
> 
> Then I end up cond_resched'ing here in the non-preemptive kernel.

Sorry, I missed the point that you want to *not* cond_resched() even in a
CONFIG_PREEMPT is false situation, if preempt_disable flag is set. That's
the reason I added the IS_ENABLED(CONFIG_PREEMPT) check at the top. I
originally didn't have that, but then thought this should always happen in
that case.

> 
> >> -		cond_resched();
> >> +		if (!irq_disable && !preempt_disable)
> >> +			cond_resched();  
> 
> But I also want to avoid this cond_resched if preempt_disable is set.

Right, so just remove the IS_ENABLED() part in the beginning.

> 
> So, I will merge both things:
> 
> 	- change the preempt_disable assignment to check !irq_disabled, like:
> 
> 		/*
> 		 * Disabling preemption is only required if IRQs are enabled, and the options is set on.
> 		 */
> 		preempt_disable = !irq_disable && test_bit(OSN_PREEMPT_DISABLE, &osnoise_options);

Yep (that's what I original had until I changed it)

> 
> 	- change the preempt disabled if to
> 		if (IS_ENABLED(CONFIG_PREEMPT) && preempt_disabled)
> 			preempt_disable();

No need, preempt_disable() is a nop when CONFIG_PREEMPT is false.

> 
> I tested with both preemption models (preemptive and not preemptive) and it works fine.
> 
> am I missing something?

Just that you don't need to add the IS_ENABLED() part at all.

-- Steve
